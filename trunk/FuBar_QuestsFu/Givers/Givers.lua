local VERSION = tonumber(("$Revision: 43802 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Givers = QuestsFu:NewModule("Givers", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-07-14 18:56:30 -0400 (Sat, 14 Jul 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local quixote = AceLibrary("Quixote-1.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Givers")

QuestsFu_Givers.lname = L["Givers"]
QuestsFu_Givers.desc = L["Record who initiated a quest"]

function QuestsFu_Givers:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Givers")
	QuestsFu:RegisterDefaults("Givers", "char", {
		questgivers = {},
	})
end

function QuestsFu_Givers:OnEnable()
	if quixote.firstScanDone then
		self:Hook("AcceptQuest", true)

		--Check various bits of saved info for continuing validity
		-- Make sure that we haven't lost a quest whose questgiver we're remembering.
		for name,text in pairs(self.db.char.questgivers) do
			if not quixote:GetQuest(name) then
				self.db.char.questgivers[name] = nil
			end
		end
	else
		self:RegisterEvent("Quixote_Ready", function() self:OnEnable() end, true)
	end
end

function QuestsFu_Givers:AcceptQuest()
	if (not UnitName("npc")) or UnitIsPlayer("npc") then
		self.db.char.questgivers[GetTitleText()] = L["Item or other player"]
	else
		local x,y = GetPlayerMapPosition("player")
		self.db.char.questgivers[GetTitleText()] = L["%s in %s (%d,%d)"]:format(UnitName('npc'), GetZoneText(), floor(x*100), floor(y*100))
	end
	return self.hooks["AcceptQuest"]()
end

function QuestsFu_Givers:Quest_Lost(name, id)
	self.db.char.questgivers[name] = nil
end
