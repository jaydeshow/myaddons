local VERSION = tonumber(("$Revision: 31060 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Announce = QuestsFu:NewModule("Announce", "AceEvent-2.0", "AceConsole-2.0")
QuestsFu:SetModuleDefaultState('Announce', false)
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-03-27 03:03:52 -0700 (Tue, 27 Mar 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Announce")

QuestsFu_Announce.lname = L["Announce"]
QuestsFu_Announce.desc = L["Announce quest status in chat"]

function QuestsFu_Announce:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Announce")
	QuestsFu:RegisterDefaults("Announce", "profile", {
		objective = false,
		complete = false,
		objectivecomplete = false,
	})
	self.menu = {
		name = L["Announce"],
		desc = L["Announce quest status in chat"],
		type = "group", pass = true,
		handler = QuestsFu_Announce,
		get = function(k) return self.db.profile[k] end,
		set = function(k, t) self.db.profile[k] = t end,
		args = {
			complete = {
				type = 'toggle', name = L["Announce completion"],
				desc = L["Announce when all a quests' objectives are completed"],
			},
			objective = {
				type = 'toggle', name = L["Announce objectives"],
				desc = L["Announce when a quest objective is advanced"],
			},
			objectivecomplete = {
				type = 'toggle', name = L["Announce objective completion"],
				desc = L["Announce when a quest objective is completed"],
			},
		},
	}
end

function QuestsFu_Announce:OnEnable()
	self:RegisterEvent("Quixote_Leaderboard_Update")
	self:RegisterEvent("Quixote_Quest_Complete")
end

function QuestsFu_Announce:Quixote_Leaderboard_Update(title, id, lid, description, numHad, numGot, numNeeded)
	local db = self.db.profile
	if (db.objective or db.objectiveprogress) and GetNumPartyMembers() > 0 then
		if numGot == numNeeded then
			if db.objective or db.objectivecomplete then
				SendChatMessage(ERR_QUEST_COMPLETE_S:format("("..title..") "..description), "PARTY")
			end
		elseif db.objective then
			SendChatMessage(ERR_QUEST_ADD_ITEM_SII:format("("..title..") "..description, numGot, numNeeded), "PARTY")
		end
	end
end

function QuestsFu_Announce:Quixote_Quest_Complete(title, id)
	if self.db.profile.complete and GetNumPartyMembers() > 0 then
		SendChatMessage(ERR_QUEST_COMPLETE_S:format(title), "PARTY")
	end
end
