--[[
Name: LibRollCall-3.0
Revision: $Rev: 76176 $
Author: Cameron Kenneth Knight (ckknight@gmail.com)
Website: http://wiki.wowace.com/index.php/LibRollCall-3.0
Documentation: http://wiki.wowace.com/index.php/LibRollCall-3.0
SVN: svn://svn.wowace.com/wowace/trunk/LibRollCall-3.0
Description: A library to provide an easy way to get information about guild members.
License: MIT
]]

local MAJOR_VERSION = "LibRollCall-3.0"
local MINOR_VERSION = "$Revision: 76176 $"

if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
if not LibStub("CallbackHandler-1.0", true) then error(MAJOR_VERSION .. " requires CallbackHandler-1.0.") end

local RollCall, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not RollCall then
	return
end
if oldLib then
	oldLib = {}
	for k, v in pairs(RollCall) do
		RollCall[k] = nil
		oldLib[k] = v
	end
end

local callbacks = RollCall.callbacks
if not callbacks then
	callbacks = LibStub("CallbackHandler-1.0"):New(RollCall)
	RollCall.callbacks = callbacks
end

local guildRosterTime = 0
local events = {}

local frame = RollCall.frame
if not frame then
	frame = CreateFrame("Frame")
	RollCall.frame = frame
else
	frame:UnregisterAllEvents()
	frame:SetScript("OnEvent", nil)
	frame:SetScript("OnUpdate", nil)
	frame:Show()
end
frame:SetScript("OnEvent", function(this, event, ...)
	events[event](...)
end)
frame:SetScript("OnUpdate", function(this, elapsed)
	local currentTime = GetTime()
	if currentTime > guildRosterTime then
		guildRosterTime = currentTime + 15
		if IsInGuild() then
			GuildRoster()
		end
	end
end)

local playersOnline = {}
local playerOfflineTimes = {}
local playerRanks = {}
local playerRankIndexes = {}
local playerLevels = {}
local playerClasses = {}
local playerClassesEnglish = {}
local playerZones = {}
local playerStatuses = {}
local playerNotes = {}
local playerOfficerNotes = {}
local numPlayersOnline = 0
local numPlayersTotal = 0
local guildLeader = nil

function RollCall:GuildControlPopupFrame_OnShow()
	GuildControlPopupFrame:UnregisterEvent("GUILD_ROSTER_UPDATE")
end

if not oldLib or not oldLib.hookGuildControlPopupFrame_OnShow then
	-- Hooking the OnShow, which registers the event, to unregister it
	-- so that the Guild Control Panel will not "reset" every 15 seconds
	hooksecurefunc("GuildControlPopupFrame_OnShow", function()
		RollCall:GuildControlPopupFrame_OnShow()
	end)
end
RollCall.hookGuildControlPopupFrame_OnShow = true

function events.PLAYER_GUILD_UPDATE(event, arg1)
	if arg1 and arg1 ~= "player" then return end
	
	if IsInGuild() then
		GuildRoster()
		callbacks:Fire("Joined")
	else
		callbacks:Fire("Left")
		
		events.GUILD_ROSTER_UPDATE()
	end
end

local tmp, tmp2 = {}, {}
function events.GUILD_ROSTER_UPDATE()
	if IsInGuild() then
		playersOnline, tmp = tmp, playersOnline
		playerLevels, tmp2 = tmp2, playerLevels
		numPlayersOnline = 0
		numPlayersTotal = GetNumGuildMembers(true)
		
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status, englishClass
		local yearsOffline, monthsOffline, daysOffline, hoursOffline, secondsOffline
		for i = 1, numPlayersTotal do
			name, rank, rankIndex, level, class, zone, note, officernote, online, status, englishClass = GetGuildRosterInfo(i)
			yearsOffline, monthsOffline, daysOffline, hoursOffline = GetGuildRosterLastOnline(i)
			if yearsOffline then
				secondsOffline = hoursOffline * 60 * 60
				secondsOffline = secondsOffline + daysOffline * 24 * 60 * 60
				secondsOffline = secondsOffline + monthsOffline * 30 * 24 * 60 * 60
				secondsOffline = secondsOffline + yearsOffline * 365 * 24 * 60 * 60
			else
				secondsOffline = nil
			end
			if status == "" then
				status = nil
			end
			if note == "" then
				note = nil
			end
			if officernote == "" then
				officernote = nil
			end
			local add, connect
			if name then
				playerRanks[name] = rank or UNKNOWN
				playerRankIndexes[name] = rankIndex or -1
				playerLevels[name] = level or -1
				playerClasses[name] = class or UNKNOWN
				playerClassesEnglish[name] = englishClass or UNKNOWN
				playerZones[name] = zone or UNKNOWN
				playerStatuses[name] = status
				playerNotes[name] = note
				playerOfficerNotes[name] = officernote
				playerOfflineTimes[name] = secondsOffline
				if tmp2[name] then
					tmp2[name] = nil
				else
					add = true
				end
				if rankIndex == 0 then
					guildLeader = name
				end
			end
			if online then
				numPlayersOnline = numPlayersOnline + 1
				if name then
					playersOnline[name] = true
					if tmp[name] then
						tmp[name] = nil
					else
						connect = true
					end
				end
			end
			if add then
				callbacks:Fire("MemberAdded", name)
			end
			if connect then
				callbacks:Fire("MemberConnected", name)
			end
		end
		for k in pairs(tmp2) do
			tmp2[k] = nil
			callbacks:Fire("MemberRemoved", k)
		end
		for k in pairs(tmp) do
			tmp[k] = nil
			callbacks:Fire("MemberDisconnected", k)
		end
		
		guildRosterTime = GetTime() + 15
	else
		for name in pairs(playerLevels) do
			playersOnline[name] = nil
			playerRanks[name] = nil
			playerRankIndexes[name] = nil
			playerLevels[name] = nil
			playerClasses[name] = nil
			playerClassesEnglish[name] = nil
			playerZones[name] = nil
			playerStatuses[name] = nil
			playerNotes[name] = nil
			playerOfficerNotes[name] = nil
		end
		numPlayersOnline = 0
		numPlayersTotal = 0
		guildLeader = nil
	end
	callbacks:Fire("Updated")
end

if IsInGuild() then
	guildRosterTime = GetTime() + 15
	GuildRoster()
end

function RollCall:GetNumOnline()
	return numPlayersOnline
end

function RollCall:GetNumTotal()
	return numPlayersTotal
end

local playerName = UnitName("player")

function RollCall:HasMember(name)
	return not not playerLevels[name or playerName]
end

function RollCall:IsMemberOnline(name)
	return not not playersOnline[name or playerName]
end

function RollCall:GetRank(name)
	return playerRanks[name or playerName]
end

function RollCall:GetRankIndex(name)
	return playerRankIndexes[name or playerName]
end

function RollCall:GetLevel(name)
	return playerLevels[name or playerName]
end

function RollCall:GetClass(name)
	return playerClasses[name or playerName]
end

function RollCall:GetEnglishClass(name)
	return playerClassesEnglish[name or playerName]
end

function RollCall:GetClassColor(name)
	local class = playerClassesEnglish[name or playerName]
	if not class then return 0.8, 0.8, 0.8 end
	local color = RAID_CLASS_COLORS[class]
	return color.r, color.g, color.b
end

function RollCall:GetClassHexColor(name)
	local class = playerClassesEnglish[name or playerName]
	if not class then return "cccccc" end
	local color = RAID_CLASS_COLORS[class]
	return ("%02x%02x%02x"):format(color.r*255, color.g*255, color.b*255)
end

function RollCall:GetZone(name)
	return playerZones[name or playerName]
end

function RollCall:GetStatus(name)
	return playerStatuses[name or playerName]
end

function RollCall:GetNote(name)
	return playerNotes[name or playerName]
end

function RollCall:GetOfficerNote(name)
	return playerOfficerNotes[name or playerName]
end

function RollCall:GetSecondsOffline(name)
	return playerOfflineTimes[name or playerName]
end

function RollCall:GetGuildName()
	return (GetGuildInfo('player'))
end

function RollCall:GetGuildLeader()
	return guildLeader
end

local sorts; sorts = {
	NAME = function(a, b)
		return a < b
	end,
	CLASS =	function(a, b)
		local playerClasses_a = playerClasses[a]
		local playerClasses_b = playerClasses[b]
		if playerClasses_a < playerClasses_b then
			return true
		elseif playerClasses_a > playerClasses_b then
			return false
		else
			local playerLevels_a = playerLevels[a]
			local playerLevels_b = playerLevels[b]
			if playerLevels_a < playerLevels_b then
				return true
			elseif playerLevels_a > playerLevels_b then
				return false
			else
				return a < b
			end
		end
	end,
	LEVEL =	function(a,b)
		local playerLevels_a = playerLevels[a]
		local playerLevels_b = playerLevels[b]
		if playerLevels_a < playerLevels_b then
			return true
		elseif playerLevels_a > playerLevels_b then
			return false
		else
			local playerClasses_a = playerClasses[a]
			local playerClasses_b = playerClasses[b]
			if playerClasses_a < playerClasses_b then
				return true
			elseif playerClasses_a > playerClasses_b then
				return false
			else
				return a < b
			end
		end
	end,
	ZONE = function(a, b)
		local playerZones_a = playerZones[a]
		local playerZones_b = playerZones[b]
		if playerZones_a < playerZones_b then
			return true
		elseif playerZones_a > playerZones_b then
			return false
		else
			return sorts.CLASS(a, b)
		end
	end,
	RANK = function(a, b)
		local playerRanks_a = playerZones[a]
		local playerRanks_b = playerZones[b]
		if playerRanks_a < playerRanks_b then
			return true
		elseif playerRanks_a > playerRanks_b then
			return false
		else
			return sorts.CLASS(a, b)
		end
	end,
}

local tmps = setmetatable({}, {__mode='k'})
local iter = function(t)
	local n = t.n
	n = n + 1
	t.n = n
	local value = t[n]
	if not value then
		tmps[t] = true
	else
		return value
	end
end
function RollCall:GetIterator(sort, includeOffline)
	local sortFunc = sorts[sort or "NAME"]
	
	local tmp = next(tmps) or {}
	tmps[tmp] = nil
	for k in pairs(tmp) do
		tmp[k] = nil
	end
	
	for k in pairs(includeOffline and playerLevels or playersOnline) do
		tmp[#tmp+1] = k
	end
	
	table.sort(tmp, sortFunc)
	tmp.n = 0
	
	return iter, tmp, nil
end

for event in pairs(events) do
	frame:RegisterEvent(event)
end
