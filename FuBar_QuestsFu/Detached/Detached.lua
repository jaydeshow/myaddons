local VERSION = tonumber(("$Revision: 71623 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Detached = QuestsFu:NewModule("Detached", "AceEvent-2.0", "AceConsole-2.0")
QuestsFu:SetModuleDefaultState('Detached', false)

if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2008-04-26 08:11:42 -0400 (Sat, 26 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local tablet = AceLibrary("Tablet-2.0")
local title = AceLibrary("Tablet-2.0")
local quixote = AceLibrary("Quixote-1.0")
local dewdrop = AceLibrary("Dewdrop-2.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Detached")

QuestsFu_Detached.lname = L["Detached"]
QuestsFu_Detached.desc = L["Improved detached tooltip"]

function QuestsFu_Detached:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Detached")
	QuestsFu:RegisterDefaults("Detached", "profile", {
		data = {
			fontSizePercent=1, detached=true, transparency=1,
		},
		strata = "HIGH",
		minWidth = 150,
		maxHeight = 230,
		minimized = false,
	})
	self.menu = {
		name = L["Detached"],
		desc = L["Improved detached tooltip"],
		type = "group",
		args = {
			strata = QuestsFu.strataOption(self, 'QuestsFu_Detached', 1),
			maxHeight = QuestsFu.maxHeightOption(self, 'QuestsFu_Detached', 2),
			minWidth = QuestsFu.minWidthOption(self, 'QuestsFu_Detached', 3),
			lock = QuestsFu.lockOption(self, 'QuestsFu_Detached', 4),
			fontSize = {
				type = "range",
				name = L["Font Size"],
				desc = L["Adjust the font size of this panel"],
				get = function() return self.db.profile.data.fontSizePercent end,
				set = function(t)
					self.db.profile.data.fontSizePercent = t
					QuestsFu.reloadTablet('QuestsFu_Detached')
					self:Update()
				end,
				min = 0.2, max = 2, step = 0.1,
				order = 5,
			},
			transparency = {
				type = "range",
				name = L["Transparency"],
				desc = L["Adjust the transparency of this panel"],
				get = function() return self.db.profile.data.transparency end,
				set = function(t)
					self.db.profile.data.transparency = t
					QuestsFu.reloadTablet('QuestsFu_Detached')
					self:Update()
				end,
				min = 0, max = 1, step = 0.05,
				order = 6,
			},
		},
	}
end

function QuestsFu_Detached:OnEnable()
	if quixote.firstScanDone then
		self:RegisterEvent("Quixote_Update", "Update")
		self:RegisterEvent("PLAYER_LEVEL_UP", "Update") -- Quest difficulty colors can change on level; just redraw the tooltip in case they have it open while levelling.
		self:RegisterEvent("MINIMAP_ZONE_CHANGED", "Update")
		self:RegisterEvent("ZONE_CHANGED", "Update")
		self:RegisterEvent("ZONE_CHANGED_INDOORS", "Update")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "Update")
		
		self:Update()
	else
		self:RegisterEvent("Quixote_Ready", function() self:OnEnable() end, true)
	end
end

function QuestsFu_Detached:OnDisable()
	QuestsFu.toggleTablet('QuestsFu_Detached', false)
	tablet:Unregister('QuestsFu_Detached')
end

function QuestsFu_Detached:ToggleMinimize()
	self.db.profile.minimized = not self.db.profile.minimized
	tablet:Refresh('QuestsFu_Detached')
end

function QuestsFu_Detached:Update()
	if not tablet:IsRegistered('QuestsFu_Detached') then
		tablet:Register('QuestsFu_Detached', 
			'detachedData', self.db.profile.data, 
			'cantAttach', true, 
			'dontHook', true,
			'hideWhenEmpty', true, 
			'showTitleWhenDetached', true,
			'maxHeight', self.db.profile.maxHeight, 
			'minWidth', self.db.profile.minWidth, 
			'strata', self.db.profile.strata, 
			'menu', function() dewdrop:FeedAceOptionsTable(self.menu) end,
			'children', function()
				tablet:AddCategory(
					"text", "QuestsFu",
					"size", 14,
					'textR', 1, 'textG', 0.82, 'textB', 0,
					"text2", format(QUEST_LOG_COUNT_TEMPLATE, select(2, GetNumQuestLogEntries()), MAX_QUESTLOG_QUESTS),
					"text3", format(QUEST_LOG_DAILY_COUNT_TEMPLATE, GetDailyQuestsCompleted(), GetMaxDailyQuests()),
					"columns", 3,
					"showWithoutChildren", true,
					'checked', true,
					'hasCheck', true,
					'checkIcon', QuestsFu_Detached.db.profile.minimized and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up",
					'func', 'ToggleMinimize', 'arg1', QuestsFu_Detached
				)
				if not QuestsFu_Detached.db.profile.minimized then
					QuestsFu:OnTooltipUpdate()
				end
			end)
		tablet:Open('QuestsFu_Detached')
	end
	tablet:Refresh('QuestsFu_Detached')
end
