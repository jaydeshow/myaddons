-------------------------------------------------------------------------------
-- Are you local?
-------------------------------------------------------------------------------

local dewdrop = AceLibrary("Dewdrop-2.0")
local deformatter = AceLibrary("Deformat-2.0")
local crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

local hexColors = { WTF = "|cffa0a0a0" }
for k, v in pairs(RAID_CLASS_COLORS) do
	hexColors[k] = "|cff" .. string.format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
end
local coloredName = setmetatable({}, {__index =
	function(self, key)
		if type(key) == "nil" then return nil end
		local class = select(2, UnitClass(key)) or "WTF"
		self[key] = hexColors[class]  .. key .. "|r"
		return self[key]
	end
})

local _G = getfenv(0)

local rollers = nil
local lastAnnouncement = nil

local currentMin = 0
local currentMax = 0

-------------------------------------------------------------------------------
-- Addon Declaration
-------------------------------------------------------------------------------

GroupFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
local GroupFu = GroupFu

GroupFu.hasIcon = "Interface\\Buttons\\UI-GroupLoot-Dice-Up"

local options = {
	type = "group",
	args = {
		standard = {
			type = "toggle",
			name = L["Only accept 1-100"],
			desc = L["Accept standard (1-100) rolls only."],
			get = function() return GroupFu.db.profile.StandardRollsOnly end,
			set = function(v) GroupFu.db.profile.StandardRollsOnly = v end,
		},
		click = {
			type = "toggle",
			name = L["Perform roll when clicked"],
			desc = L["Perform a standard 1-100 roll when the FuBar plugin is clicked."],
			get = function() return GroupFu.db.profile.RollOnClick end,
			set = function(v) GroupFu.db.profile.RollOnClick = v end,
		},
		announcelocation = {
			type = "text",
			name = L["Announce"],
			desc = L["Where to output roll results."],
			get = function() return GroupFu.db.profile.OutputChannel end,
			set = function(v) GroupFu.db.profile.OutputChannel = v end,
			validate = {
				["AUTO"] = L["Auto (based on group type)"],
				["LOCAL"] = L["Local"],
				["SAY"] = L["Say"],
				["PARTY"] = L["Party"],
				["RAID"] = L["Raid"],
				["GUILD"] = L["Guild"],
				["OFF"] = L["Don't announce"],
			}
		},
		rollclearing = {
			type = "text",
			name = L["Roll clearing"],
			desc = L["When to clear the rolls."],
			get = function() return GroupFu.db.profile.ClearTimer end,
			set = function(v) GroupFu.db.profile.ClearTimer = v end,
			validate = {
				["0"] = L["Never"],
				["15"] = L["15 seconds"],
				["30"] = L["30 seconds"],
				["45"] = L["45 seconds"],
				["60"] = L["60 seconds"]
			},
		},
		loottype = {
			type = "text",
			name = L["Loot type"],
			desc = L["Set the loot type."],
			get = GetLootMethod,
			set = function(v)
				if v == "master" then
					SetLootMethod(v, UnitName("player"))
				else
					SetLootMethod(v)
				end
				dewdrop:Close()
				GroupFu:UpdateDisplay()
			end,
			validate = {
				["group"] = L["group"],
				["master"] = L["master"],
				["freeforall"] = L["freeforall"],
				["roundrobin"] = L["roundrobin"],
				["needbeforegreed"] = L["needbeforegreed"],
			},
			disabled = function()
				if UnitExists("party1") or UnitInRaid("player") and IsPartyLeader() or IsRaidLeader() then
					return false
				end
				return true
			end,
		},
		lootthreshold = {
			type = "text",
			name = L["Loot threshold"],
			desc = L["Set the loot threshold."],
			get = function() return tostring(GetLootThreshold()) end,
			set = function(v)
				SetLootThreshold(tonumber(v))
				dewdrop:Close()
				GroupFu:UpdateDisplay()
			end,
			validate = {
				["2"] = select(4, GetItemQualityColor(2)).._G["ITEM_QUALITY2_DESC"].."|r",
				["3"] = select(4, GetItemQualityColor(3)).._G["ITEM_QUALITY3_DESC"].."|r",
				["4"] = select(4, GetItemQualityColor(4)).._G["ITEM_QUALITY4_DESC"].."|r",
				["5"] = select(4, GetItemQualityColor(5)).._G["ITEM_QUALITY5_DESC"].."|r",
				["6"] = select(4, GetItemQualityColor(6)).._G["ITEM_QUALITY6_DESC"].."|r",
			},
			disabled = function()
				if UnitExists("party1") or UnitInRaid("player") and IsPartyLeader() or IsRaidLeader() then
					return false
				end
				return true
			end,
		},
		leaveparty = {
			type = "execute",
			name = L["Leave Party"],
			desc = L["Leave your current party or raid."],
			disabled = function()
				if UnitExists("party1") or UnitInRaid("player") then
					local inInstance, instanceType = IsInInstance()
					if instanceType == "arena" or instanceType == "pvp" then
						return true
					end
					return false
				end
				return true
			end,
			func = LeaveParty,
		},
		resetinstance = {
			type = "execute",
			name = L["Reset Instances"],
			desc = L["Reset all available instance the group leader has active."],
			disabled = function()
				return not CanShowResetInstances()
			end,
			func = ResetInstances,
		},
	}
}

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------

function GroupFu:OnInitialize()
	local revision = tonumber((string.match("$Revision: 67689 $", "^.-(%d+).-$"))) or 1
	if not self.version then self.version = "1" end
	self.version = self.version .. "." .. revision
	self.revision = revision

	_G.FUBAR_GROUPFU_VERSION = self.version
	_G.FUBAR_GROUPFU_REVISION = self.revision

	self.OnMenuRequest = options
	self.blizzardTooltip = true

	self:RegisterDB("GroupFuDB")
	self:RegisterDefaults("profile", {
		RollOnClick = true,
		OutputChannel = "LOCAL",
		ClearTimer = "30",
		StandardRollsOnly = true,
		TextMode = "GROUPFU",
	})
end

function GroupFu:OnEnable()
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateDisplay")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateDisplay")
	self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED", "UpdateDisplay")
end

function GroupFu:GetHighestRoller()
	local highestPlayer = nil
	for i, v in ipairs(rollers) do
		if not highestPlayer and not v.pass then
			highestPlayer = i
		else
			if not v.pass and v.roll > rollers[highestPlayer].roll then
				highestPlayer = i
			end
		end
	end
	return highestPlayer
end

function GroupFu:OnTextUpdate()
	if rollers then
		local num = UnitInRaid("player") and GetNumRaidMembers() or GetNumPartyMembers() + 1
		local highest = self:GetHighestRoller()
		if highest ~= nil then
			local playerText = string.format(L["%s [%s]"], rollers[highest].player, "|cff"..crayon:GetThresholdHexColor(rollers[highest].roll, 0, 100)..rollers[highest].roll.."|r")
			self:SetText( string.format(L["%s (%d/%d)"], playerText, #rollers, num) )
			return
		end
	end
	self:SetText(self:GetLootTypeText())
end

local function RollSorter(a, b)
	if a.pass then return false
	elseif b.pass then return true
	else return a.roll > b.roll end
end

function GroupFu:OnTooltipUpdate()
	GameTooltip:AddLine("GroupFu")
	local inRaid = UnitInRaid("player")
	GameTooltip:AddDoubleLine(L["Loot method"], self:GetLootTypeText())
	if inRaid then
		local officers = nil
		local ML = nil
		local leader = nil
		for i = 1, GetNumRaidMembers() do
			local name, rank, _, _, _, _, _, _, _, _, isML = GetRaidRosterInfo(i)
			if rank == 1 then
				if officers then officers = officers .. ", " else officers = "" end
				officers = officers .. coloredName[name]
			elseif rank == 2 then
				leader = name
			elseif isML then
				ML = name
			end
		end
		if ML then
			GameTooltip:AddDoubleLine(L["Master looter"], coloredName[ML])
		end
		if leader then
			GameTooltip:AddDoubleLine(L["Leader"], coloredName[leader])
		end
		if officers then
			GameTooltip:AddDoubleLine(L["Officers"], officers)
		end
	end

	if rollers and #rollers > 0 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(L["Player"], L["Roll"])
		table.sort(rollers, RollSorter)
		for i, v in ipairs(rollers) do
			if v.pass then
				GameTooltip:AddDoubleLine(
					string.format("%s (%d %s)", coloredName[v.player], v.level, v.class),
					"|cff696969" .. L["Pass"] .. "|r"
				)
			else
				GameTooltip:AddDoubleLine(
					string.format("%s (%d %s)", coloredName[v.player], v.level, v.class),
					"|cff"..crayon:GetThresholdHexColor(v.roll, 0, 100)..v.roll.."|r"
				)
			end
		end
		local num = inRaid and GetNumRaidMembers() or GetNumPartyMembers() + 1
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(string.format(L["%d of expected %d rolls recorded."], #rollers, num))
	end
	GameTooltip:AddLine(" ")
	if self.db.profile.RollOnClick then
		GameTooltip:AddLine(L["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."], 0.2, 1, 0.2, 1)
	else
		GameTooltip:AddLine(L["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."], 0.2, 1, 0.2, 1)
	end
end

function GroupFu:Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end

function GroupFu:OnClick()
	if IsControlKeyDown() then
		self:AnnounceWinner()
	elseif IsShiftKeyDown() then
		self:ClearRolls(true)
	elseif self.db.profile.RollOnClick then
		RandomRoll("1", "100")
	end
end

function GroupFu:CHAT_MSG_SYSTEM(msg)
	-- Trap rolls
	local player, roll, minRoll, maxRoll = deformatter(msg, RANDOM_ROLL_RESULT)
	if player then
		local db = self.db.profile

		roll = tonumber(roll)
		minRoll = tonumber(minRoll)
		maxRoll = tonumber(maxRoll)

		if not roll or not minRoll or not maxRoll
		or db.StandardRollsOnly and (minRoll ~= 1 or maxRoll ~= 100) then
			return
		elseif not db.StandardRollsOnly and rollers then
			-- If someone else has already rolled, and we accept rolls other
			-- than 1-100, assume that everyone should roll on the same premises
			-- and only accept rolls that have the same range as the first roll.
			if maxRoll ~= currentMax or minRoll ~= currentMin then
				return
			end
		end

		if not rollers then
			currentMin = minRoll
			currentMax = maxRoll
			rollers = {}

			self:RegisterEvent("CHAT_MSG_PARTY", "CheckForPassers")
			self:RegisterEvent("CHAT_MSG_RAID", "CheckForPassers")
		end

		-- Ignore duplicate rolls.
		for i, v in ipairs(rollers) do
			if v.player == player then return end
		end

		if player == UnitName("player") then
			table.insert(rollers, {
				player = player,
				roll = roll,
				class = UnitClass("player") or "Unknown",
				level = UnitLevel("player") or -1,
			})
		else
			table.insert(rollers, {
				player = player,
				roll = roll,
				class = UnitClass(player) or "Unknown",
				level = UnitLevel(player) or -1,
			})
		end

		self:CheckForWinner()
		self:UpdateDisplay()
	end
end

function GroupFu:CheckForWinner()
	local db = self.db.profile
	if db.OutputChannel ~= "OFF" or tonumber(db.ClearTimer) > 0 then
		local num = UnitInRaid("player") and GetNumRaidMembers() or GetNumPartyMembers() + 1
		-- If everyone has rolled, just output the winner.
		if num == #rollers and db.OutputChannel ~= "OFF" then
			self:CancelScheduledEvent("GroupFuAnnounce")
			self:CancelScheduledEvent("GroupFuTimeout")
			self:AnnounceWinner()
		else
			self:CancelScheduledEvent("GroupFuAnnounce")
			self:ScheduleEvent("GroupFuTimeout", self.RollTimeout, tonumber(db.ClearTimer) - 5 or 5, self)
		end
	end
end

function GroupFu:CheckForPassers(msg, author)
	if type(msg) ~= "string" then return end
	if type(rollers) ~= "table" then return end

	if msg:lower():find(string.lower(L["Pass"])) then
		local found = nil
		for i, v in ipairs(rollers) do
			if v.player == author then
				v.pass = true
				v.roll = nil
				found = true
				break
			end
		end
		if not found then
			table.insert(rollers, {
				player = author,
				class = UnitClass(author) or "Unknown",
				level = UnitLevel(author) or -1,
				pass = true,
			})
		end
		self:CheckForWinner()
		self:UpdateDisplay()
	end
end

function GroupFu:ClearRolls(override)
	self:CancelScheduledEvent("GroupFuTimeout")
	self:CancelScheduledEvent("GroupFuAnnounce")

	if self:IsEventRegistered("CHAT_MSG_PARTY") then
		self:UnregisterEvent("CHAT_MSG_PARTY")
		self:UnregisterEvent("CHAT_MSG_RAID")
	end

	if tonumber(self.db.profile.ClearTimer) > 0 or override then
		if type(rollers) == "table" then
			for i, v in ipairs(rollers) do
				for k in pairs(v) do
					v[k] = nil
				end
				rollers[i] = nil
			end
		end
		rollers = nil
	end
	self:Update()
end

function GroupFu:GetLootTypeText()
	if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
		return ITEM_QUALITY_COLORS[GetLootThreshold()].hex .. L[GetLootMethod()]
	else
		return "|cff9d9d9d" .. L["Solo"]
	end
end

function GroupFu:RollTimeout()
	if not rollers then return end

	if self.db.profile.OutputChannel ~= "OFF" then
		local num = UnitInRaid("player") and GetNumRaidMembers() or GetNumPartyMembers() + 1
		self:AnnounceOutput(string.format(L["Roll ending in 5 seconds, recorded %d of %d rolls."], #rollers, num))
	end
	self:ScheduleEvent("GroupFuAnnounce", self.AnnounceWinner, 5, self)
end

function GroupFu:AnnounceWinner()
	if self.db.profile.OutputChannel ~= "OFF" then
		if rollers then
			local highest = self:GetHighestRoller()
			if highest then
				local tiedRollers = nil
				for i, v in ipairs(rollers) do
					if not v.pass and i ~= highest and v.roll == rollers[highest].roll then
						if not tiedRollers then tiedRollers = {} end
						table.insert(tiedRollers, i)
					end
				end
				if tiedRollers then
					table.insert(tiedRollers, highest)
					local playerNames = ""
					for i, v in ipairs(tiedRollers) do
						if playerNames == "" then
							playerNames = rollers[v].player
						else
							playerNames = playerNames .. L[", "] .. rollers[v].player
						end
					end
					lastAnnouncement = string.format(L["Tie: %s are tied at %d."], playerNames, rollers[highest].roll)
				else
					lastAnnouncement = string.format(L["Winner: %s."], string.format(L["%s [%s]"], rollers[highest].player, rollers[highest].roll))
				end
			else
				lastAnnouncement = L["Everyone passed."]
			end
		end
		if lastAnnouncement then
			self:AnnounceOutput(lastAnnouncement)
		end
	end
	self:ClearRolls()
end

function GroupFu:AnnounceOutput( msg )
	if self.db.profile.OutputChannel == "LOCAL" then
		self:Print(msg)
	elseif self.db.profile.OutputChannel == "AUTO" then
		if GetNumRaidMembers() > 0 then
			SendChatMessage(msg, "RAID")
		elseif GetNumPartyMembers() > 0 then
			SendChatMessage(msg, "PARTY")
		else
			self:Print(msg)
		end
	else
		SendChatMessage(msg, self.db.profile.OutputChannel)
	end
end

