local VERSION = tonumber(("$Revision: 65775 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Tooltips = QuestsFu:NewModule("Tooltips", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2008-03-25 12:55:17 -0400 (Tue, 25 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local quixote = AceLibrary("Quixote-1.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Tooltips")

QuestsFu_Tooltips.lname = L["Tooltips"]
QuestsFu_Tooltips.desc = L["Show quest objectives in item/mob tooltips"]

function QuestsFu_Tooltips:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Tooltips")
	QuestsFu:RegisterDefaults("Tooltips", "profile", {
		player = true,
		party = true,
	})
	self.menu = {
		name = L["Tooltips"], desc = L["Show quest objectives in item/mob tooltips"],
		type = "group", handler = self, pass = true,
		get = function(k) return self.db.profile[k] end,
		set = function(k, t) self.db.profile[k] = t end,
		args = {
			player = {
				type = "toggle", order = 1,
				name = L["Player"], desc = L["Show your own quests"],
			},
			--party = {
			--	type = "toggle", order = 2,
			--	name = L["Party"], desc = L["Show your party member's quests, so long as they have Quixote"],
			--},
		},
	}
end

function QuestsFu_Tooltips:OnEnable()
	self:HookScript(GameTooltip, "OnTooltipSetItem")
	self:HookScript(GameTooltip, "OnTooltipSetUnit")
end

function QuestsFu_Tooltips:OnTooltipSetUnit(tooltip, ...)
	local name = tooltip:GetUnit()
	if name and quixote:IsQuestMob(name) then
		for _,q,i,n in quixote:IterateQuestsForMob(name) do
			GameTooltip:AddDoubleLine(q, i..'/'..n, 1, 1, 1, QuestsFu:GetColorFromCompletion(i/n))
		end
	end
	return self.hooks[tooltip].OnTooltipSetUnit(tooltip, ...)
end

function QuestsFu_Tooltips:OnTooltipSetItem(tooltip, ...)
	local t = tooltip:GetItem()
	if t then
		local q,i,n = quixote:IsQuestItem(t)
		if q then
			tooltip:AddDoubleLine(q, i..'/'..n, 1, 1, 1, QuestsFu:GetColorFromCompletion(i/n))
		end
	end
	return self.hooks[tooltip].OnTooltipSetItem(tooltip, ...)
end
