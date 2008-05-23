local VERSION = tonumber(("$Revision: 52839 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_PartyNotify = QuestsFu:NewModule("PartyNotify", "AceEvent-2.0", "AceConsole-2.0", "Sink-1.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-10-21 22:50:16 -0400 (Sun, 21 Oct 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_PartyNotify")
local quixote = AceLibrary("Quixote-1.0")

QuestsFu_PartyNotify.lname = L["Party status"]
QuestsFu_PartyNotify.desc = L["Report on party quest status"]

function QuestsFu_PartyNotify:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("PartyNotify")
	QuestsFu:RegisterDefaults("PartyNotify", "profile", {
		questcomplete = true,
		objectivecomplete = true,
		objectiveprogress = true,
		questnames = true,
	})
	self.menu = {
		name = L["Party status"],
		desc = L["Report on party quest status"],
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
		},
	}
	self.menu.args.output = AceLibrary("Sink-1.0"):GetAceOptionsDataTable(self).output
end

function QuestsFu_PartyNotify:OnEnable()
	self:RegisterEvent("Quixote_Party_Leaderboard_Update")
	self:RegisterEvent("Quixote_Party_Quest_Complete")
end

function QuestsFu_PartyNotify:Quixote_Party_Quest_Complete(sender, title)
	if self.db.profile.questcomplete then
		self:Pour(ERR_QUEST_COMPLETE_S:format("("..sender..") "..title), QuestsFu:GetColorFromCompletion(1))
	end
end

function QuestsFu_PartyNotify:Quixote_Party_Leaderboard_Update(sender, title, description, numHad, numGot, numNeeded)
	local db = self.db.profile
	local objectives, complete = quixote:GetNumPartyQuestObjectives(sender, title)
	if db.questcomplete and objectives == complete then return end
	if db.questnames then
		sender = "("..sender..":"..title..") "
	else
		sender = "("..sender..") "
	end
	if numGot == numNeeded then
		if db.objectivecomplete or db.objectiveprogress then
			self:Pour(ERR_QUEST_COMPLETE_S:format(sender..description), QuestsFu:GetColorFromCompletion(1))
		end
	elseif db.objectiveprogress then
		self:Pour(ERR_QUEST_ADD_ITEM_SII:format(sender..description, numGot, numNeeded), QuestsFu:GetColorFromCompletion(tonumber(numGot)/tonumber(numNeeded)))
	end
end
