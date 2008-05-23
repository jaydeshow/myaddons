local VERSION = tonumber(("$Revision: 63601 $"):match("%d+"))

local _G = getfenv(0)

local QuestsFu = QuestsFu
local QuestsFu_Blizz = QuestsFu:NewModule("Blizz", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2008-03-04 14:03:02 -0500 (Tue, 04 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local new, del = QuestsFu.new, QuestsFu.del
local quixote = AceLibrary("Quixote-1.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Blizz")

QuestsFu_Blizz.lname = L["Blizzard frames"]
QuestsFu_Blizz.desc = L["Improvements to the default UI"]

function QuestsFu_Blizz:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Blizz")
	QuestsFu:RegisterDefaults("Blizz", "profile", {
		levels = {
			log = true,
			dialog = true,
			lfg = true,
		},
		givers = true,
	})
	self.menu = {
		name = L["Blizzard frames"],
		desc = L["Improvements to the default UI"],
		type = "group",
		args = {
			levels = {
				name = L["Quest levels"],
				desc = L["Show quest levels in the quest log and NPC dialogs"],
				type = 'group',
				args = {
					log = {
						name = L["Quest log"],
						desc = L["Add levels to the quest log"],
						type = 'toggle',
						get = function() return self.db.profile.levels.log end,
						set = function(t)
							self.db.profile.levels.log = t
							self:UpdateHooks()
						end,
					},
					dialog = {
						name = L["NPC dialogs"],
						desc = L["Add levels to NPC dialogs"],
						type = 'toggle',
						get = function() return self.db.profile.levels.dialog end,
						set = function(t)
							self.db.profile.levels.dialog = t
							self:UpdateHooks()
						end,
					},
					lfg = {
						name = L["LFG"],
						desc = L["Add levels to quests in the LFG tool"],
						type = 'toggle',
						get = function() return self.db.profile.levels.lfg end,
						set = function(t)
							self.db.profile.levels.lfg = t
							self:UpdateHooks()
						end,
						disabled = true,
					},
				},
			},
			givers = {
				name = L["Givers"],
				desc = L["Add quest givers to the quest log"],
				type = 'toggle',
				get = function() return self.db.profile.givers end,
				set = function(t)
					self.db.profile.levels.givers = t
				end,
				disabled = function() return not QuestsFu:HasModule('Givers') end,
			},
		},
	}
end

function QuestsFu_Blizz:OnEnable()
	self:UpdateHooks()
end

function QuestsFu_Blizz:UpdateHooks()
	-- In quest log
	if self.db.profile.levels.log then
		if not self:IsHooked("QuestLog_Update") then
			self:SecureHook("QuestLog_Update")
		end
	elseif self:IsHooked("QuestLog_Update") then
		self:Unhook("QuestLog_Update")
	end
	-- In dialogs
	if self.db.profile.levels.dialog then
		if not self:IsEventRegistered("GOSSIP_SHOW") then
			self:RegisterEvent("GOSSIP_SHOW")
			self:RegisterEvent("QUEST_GREETING")
		end
	elseif self:IsEventRegistered("GOSSIP_SHOW") then
		self:UnregisterEvent("GOSSIP_SHOW")
		self:UnregisterEvent("QUEST_GREETING")
	end
	--[[
	-- In lfg
	if self.db.profile.levels.log then
		if not self:IsHooked("GetLFGTypeEntries") then
			self:Hook("GetLFGTypeEntries", true)
		end
	elseif self:IsHooked("GetLFGTypeEntries") then
		self:Unhook("GetLFGTypeEntries")
	end
	--]]
	-- Quest givers
	if self.db.profile.givers and QuestsFu:HasModule('Givers') then
		if not self:IsHooked("QuestLog_SetSelection") then
			self:SecureHook("QuestLog_SetSelection")
		end
	elseif self:IsHooked("QuestLog_SetSelection") then
		self:Unhook("QuestLog_SetSelection")
	end
end

----------------------------------------------------
-- Add quest levels to the quest log
----------------------------------------------------

function QuestsFu_Blizz:QuestLog_Update()
	--This is fragile, but lets us ignore event sequencing.  It'll break if anyone is meddling with the output of GetQuestLogTitle.
	--(questIndexes can change on every QUEST_LOG_UPDATE; this *will* be called before Quixote updates from that event, because Quixote is
	--throttling to avoid crashing the client on edge cases. I blame Blizzard for it being possible to crash the game by scanning the quest log. So.)
	for i = 1, QUESTS_DISPLAYED, 1 do
		--local questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
		local titleLine = _G["QuestLogTitle"..i]
		if titleLine and titleLine:GetText() then
			local title, level, tag, suggestedGroup, complete = quixote:GetQuest(titleLine:GetText():trim())
			if title then
				-- If the quest isn't complete, clear out the tag, for its info has been moved to the title.
				if (not complete) or (complete == 0) then _G["QuestLogTitle"..i.."Tag"]:SetText("") end
				titleLine:SetText(QuestsFu:MakeTag(level, tag, suggestedGroup)..title)
				local check = _G["QuestLogTitle" .. i .. "Check"]
				if check:IsVisible() then
					check:SetPoint("LEFT", titleLine, "LEFT", -1, -2)
				end
			end
		end
	end
end

----------------------------------------------------
-- Add quest levels to LFG
----------------------------------------------------

--[[
-- Fuck you, Blizzard. ~vhaarr
function QuestsFu_Blizz:GetLFGTypeEntries(index)
	if index and tonumber(index) then
		index = tonumber(index)
		local original = {self.hooks["GetLFGTypeEntries"](index)}
		for i, v in ipairs(original) do
			if index == 2 or index == 3 or index == 5 then
				if (index == 5 and tourist:IsZone(v)) or tourist:IsInstance(v) then
					local low, high = tourist:GetLevel(v)
					if low and high then
						original[i] = v .. " ("..tostring(low).."-"..tostring(high)..")"
					end
				end
			elseif index == 4 then
				local _, level = quixote:GetQuestByName(v)
				if level and tonumber(level) then
					original[i] = "["..tostring(level).."] "..v
				end
			end
		end
		return unpack(original)
	end
	return self.hooks["GetLFGTypeEntries"](index)
end
]]

----------------------------------------------------
-- Add quest levels to NPC dialog when possible
----------------------------------------------------

local function gossip_loop(buttonindex, do_texture, ...)
	local numQuests = select('#', ...)
	for i=2, numQuests, 3 do
		local button = _G["GossipTitleButton"..buttonindex]
		button:SetText(format('[%d] %s', select(i, ...), button:GetText()))
		if do_texture then
			local texture = _G["GossipTitleButton"..buttonindex.."GossipIcon"]
			local _,_,_,_,complete,objectives = quixote:GetQuestByName(select(i-1, ...))
			if complete==1 or objectives==0 then
				texture:SetDesaturated(false)
			else
				texture:SetDesaturated(true)
			end
		end
		buttonindex = buttonindex + 1
	end
	return buttonindex + 1
end

function QuestsFu_Blizz:GOSSIP_SHOW()
	local buttonindex = 1
	if GetGossipAvailableQuests() then
		buttonindex = gossip_loop(buttonindex, false, GetGossipAvailableQuests())
	end
	if GetGossipActiveQuests() then
		buttonindex = gossip_loop(buttonindex, true, GetGossipActiveQuests())
	end
end

function QuestsFu_Blizz:QUEST_GREETING()
	local numactive,numavailable = GetNumActiveQuests(), GetNumAvailableQuests()
	local title, level, button
	local o,GetTitle,GetLevel = 0,GetActiveTitle,GetActiveLevel
	for i=1, numactive + numavailable do
		if i == numactive + 1 then
			o,GetTitle,GetLevel = numactive,GetAvailableTitle,GetAvailableLevel
		end
		title,level = GetTitle(i-o), GetLevel(i-o)
		button = _G["QuestTitleButton"..i]
		button:SetText(format('[%d] %s',level,title))
	end
end

----------------------------------------------------
-- Add quest givers to the quest log
----------------------------------------------------

function QuestsFu_Blizz:QuestLog_SetSelection(id)
	local name = quixote:GetQuestById(id)
	local givers = QuestsFu:GetModule('Givers')
	if name and givers and givers.db.char.questgivers[name] then
		local questObjectives = QuestLogObjectivesText:GetText()
		QuestLogObjectivesText:SetText(givers.db.char.questgivers[name] .. '\n\n' .. questObjectives)
	end
end
