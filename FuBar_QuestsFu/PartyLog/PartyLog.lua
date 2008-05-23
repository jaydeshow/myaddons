local VERSION = tonumber(("$Revision: 43802 $"):match("%d+"))

local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local quixote = AceLibrary("Quixote-1.0")

local QuestsFu = QuestsFu
local PartyLog = QuestsFu:NewModule("PartyLog", "AceEvent-2.0", "AceConsole-2.0")
QuestsFu:SetModuleDefaultState('PartyLog', false)

if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-07-14 15:56:30 -0700 (Sat, 14 Jul 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local clear = QuestsFu.clear

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_PartyLog")

PartyLog.lname = L["PartyLog"]
PartyLog.desc = L["Display party member quest logs, where possible"]

function PartyLog:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("PartyLog")
	QuestsFu:RegisterDefaults("PartyLog", "profile", {
		data = {
			fontSizePercent=0.7, detached=true, transparency=0,
		},
		strata = 'LOW',
		minWidth = 150,
		maxHeight = 800,
	})
	self.menu = {
		name = L["Party quest logs"],
		desc = L["Display party member quest logs, where possible"],
		type = "group",
		args = {
			strata = QuestsFu.strataOption(self, 'QuestsFu_PartyLog', 1),
			maxHeight = QuestsFu.maxHeightOption(self, 'QuestsFu_PartyLog', 2),
			minWidth = QuestsFu.minWidthOption(self, 'QuestsFu_PartyLog', 3),
			--This one will look a little weird on the tablet right-click menu, as it'll be duplicating native functionality.  But it's totally worth it to stop people complaining.
			lock = QuestsFu.lockOption(self, 'QuestsFu_PartyLog', 4),
		},
	}
end

function PartyLog:OnEnable()
	self:RegisterEvent("Quixote_Party_Quest_Sync", "Update")
	self:RegisterEvent("Quixote_Party_Quest_Gained", "Update")
	self:RegisterEvent("Quixote_Party_Quest_Lost", "Update")
	self:RegisterEvent("Quixote_Party_Leaderboard_Update", "Update")
	self:RegisterEvent("Quixote_Party_Quest_Complete", "Update")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "Update")
end

function PartyLog:OnDisable()
	QuestsFu.toggleTablet('QuestsFu_PartyLog', false)
	tablet:Unregister('QuestsFu_PartyLog')
end

local expanded = {}
function PartyLog:Update()
	if not tablet:IsRegistered('QuestsFu_PartyLog') then
		tablet:Register('QuestsFu_PartyLog', 'detachedData', self.db.profile.data, 'cantAttach', true,
			'dontHook', true, 'hideWhenEmpty', true, 'strata', self.db.profile.strata,
			'minWidth', self.db.profile.minWidth, 'maxHeight', self.db.profile.maxHeight,
			'menu', function() dewdrop:FeedAceOptionsTable(self.menu) end,
			'children', function()
				if GetNumPartyMembers() > 0 then
					for i=1, GetNumPartyMembers(), 1 do
						local name = UnitName("party"..i)
						local cat = tablet:AddCategory('text', name, 'columns', 2)
						if quixote:PartyMemberHasQuixote(name) then
							for quest in quixote:IteratePartyQuests(name) do
								cat:AddLine('text', quest, 'indentation', 10)
								for description in quixote:IteratePartyQuestLeaderboard(name, quest) do
									cat:AddLine('text', description, 'text2', ("%d/%d"):format(quixote:GetPartyQuestStatus(name, quest, description)), 'indentation', 20)
								end
							end
						else
							cat:AddLine('text', L["Doesn't have Quixote."], 'indentation', 10, 'textR', 1, 'textG', 1, 'textB', 0)
						end
					end
				end
			end)
		tablet:Open('QuestsFu_PartyLog')
	end
	tablet:Refresh('QuestsFu_PartyLog')
end
