local VERSION = tonumber(("$Revision: 52828 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_PlayerNotify = QuestsFu:NewModule("PlayerNotify", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0", "Sink-1.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-10-21 20:23:03 -0400 (Sun, 21 Oct 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_PlayerNotify")
local quixote = AceLibrary("Quixote-1.0")

QuestsFu_PlayerNotify.lname = L["Player status"]
QuestsFu_PlayerNotify.desc = L["Report on player quest status"]

function QuestsFu_PlayerNotify:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("PlayerNotify")
	QuestsFu:RegisterDefaults("PlayerNotify", "profile", {
		questcomplete = true,
		objectivecomplete = true,
		objectiveprogress = true,
		questnames = true,
		suppress = true,
	})
	self.menu = {
		name = L["Player status"],
		desc = L["Report on player quest status"],
		type = "group",
		args = {
			completion = {
				type = "toggle", name = L["Quest Completion"],
				desc = L["Notify of quest completion"],
				get = function() return self.db.profile.questcomplete end,
				set = function(t) self.db.profile.questcomplete = t end,
			},
			objective = {
				type = "toggle", name = L["Objective Completion"],
				desc = L["Notify of individual objective completion"],
				get = function() return self.db.profile.objectivecomplete end,
				set = function(t) self.db.profile.objectivecomplete = t end,
			},
			progress = {
				type = "toggle", name = L["Objective Progress"],
				desc = L["Notify of any progress on an objective"],
				get = function() return self.db.profile.objectiveprogress end,
				set = function(t) self.db.profile.objectiveprogress = t end,
			},
			questnames = {
				type = "toggle", name = L["Show quest names"],
				desc = L["Show the names of quests in output"],
				get = function() return self.db.profile.questnames end,
				set = function(t) self.db.profile.questnames = t end,
			},
			suppress = {
				type = "toggle", name = L["Suppress Blizzard output"],
				desc = L["Hide quest messages that would display in the UIErrorsFrame"],
				get = function() return self.db.profile.suppress end,
				set = function(t) self.db.profile.suppress = t end,
			},
		},
	}
	self.menu.args.output = AceLibrary("Sink-1.0"):GetAceOptionsDataTable(self).output
end

function QuestsFu_PlayerNotify:OnEnable()
	self:RegisterEvent("Quixote_Leaderboard_Update")
	self:RegisterEvent("Quixote_Quest_Complete")
	self:Hook("UIErrorsFrame_OnEvent", true)
end

function QuestsFu_PlayerNotify:UIErrorsFrame_OnEvent(event, message)
	if self.db.profile.suppress and event == "UI_INFO_MESSAGE" and message:match("^.+: ?%d+/%d+$") then return end
	return self.hooks.UIErrorsFrame_OnEvent(event, message)
end

function QuestsFu_PlayerNotify:Quixote_Quest_Complete(title, id)
	if self.db.profile.questcomplete then
		self:Pour(ERR_QUEST_COMPLETE_S:format(title), QuestsFu:GetColorFromCompletion(1))
	end
end

function QuestsFu_PlayerNotify:Quixote_Leaderboard_Update(title, id, lid, description, numHad, numGot, numNeeded)
	local db = self.db.profile
	if db.questnames then
		description = "("..title..") "..description
	end
	if numGot == numNeeded then
		local objectives, complete = quixote:GetNumQuestObjectives(id)
		if db.questcomplete and objectives == complete then return end
		if db.objectivecomplete or db.objectiveprogress then
			-- ERR_QUEST_COMPLETE_S = "%s completed."
			self:Pour(ERR_QUEST_COMPLETE_S:format(description), QuestsFu:GetColorFromCompletion(1))
		end
	elseif db.objectiveprogress then
		-- ERR_QUEST_ADD_ITEM_SII = "%s: %d/%d"
		self:Pour(ERR_QUEST_ADD_ITEM_SII:format(description, numGot, numNeeded), QuestsFu:GetColorFromCompletion(tonumber(numGot)/tonumber(numNeeded)))
	end
end
