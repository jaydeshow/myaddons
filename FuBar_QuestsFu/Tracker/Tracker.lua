local VERSION = tonumber(("$Revision: 55071 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Tracker = QuestsFu:NewModule("Tracker", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-11-16 20:38:50 -0500 (Fri, 16 Nov 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local tablet = AceLibrary("Tablet-2.0")
local quixote = AceLibrary("Quixote-1.0")
local dewdrop = AceLibrary("Dewdrop-2.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Tracker")

QuestsFu_Tracker.lname = L["Tracker"]
QuestsFu_Tracker.desc = L["Replace the default quest tracker with a slightly more featureful one"]

function QuestsFu_Tracker:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Tracker")
	QuestsFu:RegisterDefaults("Tracker", "profile", {
		login = true,
		zone = false,
		subzone = true,
		gained = false,
		progress = true,
		removeCompleted = false,
		useOwnTracker = true,
		data = {
			fontSizePercent=0.7, detached=true, transparency=0,
		},
		strata = 'LOW',
		minWidth = 150,
		maxHeight = 800,
	})
	QuestsFu:RegisterDefaults("Tracker", "char", {
		watchedQuests = {},
		autowatched = {},
	})
	
	self.menu = {
		name = L["Tracker"],
		desc = L["Replace the default quest tracker with a slightly more featureful one"],
		type = "group",
		args = {
			auto = {
				name = L["Autowatch"],
				desc = L["Automatically add quests to the tracker when appropriate"],
				type = "group",
				args = {
					login = {
						type = "toggle", name = L["Login"],
						desc = L["Re-add quests you were watching before you logged out"],
						get = function() return self.db.profile.login end,
						set = function(t) self.db.profile.login = t end,
					},
					zone = {
						type = "toggle", name = L["Zone"],
						desc = L["Add quests to the tracker when you enter their zone"],
						get = function() return self.db.profile.zone end,
						set = function(t) self.db.profile.zone = t end,
					},
					subzone = {
						type = "toggle", name = L["Subzone"],
						desc = L["Add quests to the tracker when you enter their subzone"],
						get = function() return self.db.profile.subzone end,
						set = function(t) self.db.profile.subzone = t end,
					},
					progress = {
						type = "toggle", name = L["Progress"],
						desc = L["Add quests to the tracker when you make progress on them"],
						get = function() return self.db.profile.progress end,
						set = function(t) self.db.profile.progress = t end,
					},
					gained = {
						type = "toggle", name = L["Gained"],
						desc = L["Add quests to the tracker when they are first gained"],
						get = function() return self.db.profile.gained end,
						set = function(t) self.db.profile.gained = t end,
					},
					removeCompleted = {
						type = "toggle", name = L["Remove completed"],
						desc = L["Remove quests from the tracker when you complete their objectives"],
						get = function() return self.db.profile.removeCompleted end,
						set = function(t) self.db.profile.removeCompleted = t end,
					},
				},
			},
			own = {
				type = 'toggle', name = L["Use own tracker"],
				desc = L["Replace the default quest tracker with a slightly more featureful one"],
				get = function() return self.db.profile.useOwnTracker end,
				set = function(t)
					self.db.profile.useOwnTracker = t
					if self.db.profile.useOwnTracker then
						if tablet:IsRegistered('QuestsFu_Tracker') then tablet:Open('QuestsFu_Tracker') end
						self:Update()
					else
						if tablet:IsRegistered('QuestsFu_Tracker') then tablet:Close('QuestsFu_Tracker') end
						QuestWatchFrame:Show()
					end
				end,
			},
			strata = QuestsFu.strataOption(self, 'QuestsFu_Tracker', 1),
			maxHeight = QuestsFu.maxHeightOption(self, 'QuestsFu_Tracker', 2),
			minWidth = QuestsFu.minWidthOption(self, 'QuestsFu_Tracker', 3),
			--This one will look a little weird on the tablet right-click menu, as it'll be duplicating native functionality.  But it's totally worth it to stop people complaining.
			lock = QuestsFu.lockOption(self, 'QuestsFu_Tracker', 4),
		},
	}
end

function QuestsFu_Tracker:OnEnable()
	if quixote.firstScanDone then
		self:SecureHook("AddQuestWatch")
		self:SecureHook("RemoveQuestWatch")
		self:RegisterEvent("MINIMAP_ZONE_CHANGED", "OnZoneChange")
		self:RegisterEvent("ZONE_CHANGED", "OnZoneChange")
		self:RegisterEvent("ZONE_CHANGED_INDOORS", "OnZoneChange")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnZoneChange")
		self:RegisterEvent("Quixote_Leaderboard_Update")
		self:RegisterEvent("Quixote_Quest_Gained")
		self:RegisterEvent("Quixote_Quest_Complete")
		self:RegisterEvent("Quixote_Quest_Lost")
		self:Hook(QuestsFu, "ToggleQuestWatch")
		self:Hook(QuestsFu, "IsWatched")
		
		self:Hook(QuestsFu, "UpdateTooltip")
		self:SecureHook("QuestWatch_Update", "Update")
		self:RegisterEvent("Quixote_Update", "Update")
		self:RegisterEvent("Quixote_Party_Quest_Sync", "Update")
		self:RegisterEvent("Quixote_Party_Quest_Gained", "Update")
		self:RegisterEvent("Quixote_Party_Quest_Lost", "Update")
		self:RegisterEvent("Quixote_Party_Leaderboard_Update", "Update")

		--Check various bits of saved info for continuing validity
		for i,name in pairs(self.db.char.autowatched) do
			if not quixote:GetQuest(name) then
				self.db.char.autowatched[i] = nil
			end
		end
		for name in pairs(self.db.char.watchedQuests) do
			if not quixote:GetQuest(name) then
				self.db.char.watchedQuests[name] = nil
			end
		end
		self:LoadWatchedQuests()
		self:OnZoneChange()

		self.oldMAX_WATCHABLE_QUESTS = MAX_WATCHABLE_QUESTS
		MAX_WATCHABLE_QUESTS = 50
	else
		self:RegisterEvent("Quixote_Ready", function() self:OnEnable() end, true)
	end
end

function QuestsFu_Tracker:OnDisable()
	MAX_WATCHABLE_QUESTS = self.oldMAX_WATCHABLE_QUESTS
	QuestsFu.toggleTablet('QuestsFu_Tracker', false)
	tablet:Unregister('QuestsFu_Tracker')
end

--- Make other QuestsFu modules deal with this ---

function QuestsFu_Tracker:ToggleQuestWatch(object, questid)
	if self.db.profile.useOwnTracker then
		local questName = quixote:GetQuestById(questid)
		if self.db.char.watchedQuests[questName] then
			self.db.char.watchedQuests[questName] = nil
		else
			self.db.char.watchedQuests[questName] = true
		end
		self:Update()
	else
		return self.hooks[object].ToggleQuestWatch(object, questid)
	end
end

function QuestsFu_Tracker:IsWatched(object, questid)
	if type(questid) == 'number' then
		--need the name
		questid = quixote:GetQuestById(questid)
	end
	return self.db.char.watchedQuests[questid]
	--not calling of the hook
end

--- Quest watching ---

function QuestsFu_Tracker:LoadWatchedQuests()
	if not self.db.profile.useOwnTracker then
		if not (GetNumQuestWatches() > 0) then
			for questName in pairs(self.db.char.watchedQuests) do
				local questId = select(8, quixote:GetQuestByName(questName))
				if questId then
					AddQuestWatch(questId)
				else
					self.db.char.watchedQuests[questName] = nil
				end
			end
		end
	end
	self.loadedWatchedQuests = true
	self:Update()
end

function QuestsFu_Tracker:SaveWatchedQuests()
	if self.db.profile.useOwnTracker then
		self:Update()
	else
		if self.loadedWatchedQuests then
			for k in pairs(self.db.char.watchedQuests) do
				self.db.char.watchedQuests[k] = nil
			end
			for i = 1, GetNumQuestWatches() do
				local questName = quixote:GetQuestById(GetQuestIndexForWatch(i))
				if questName then self.db.char.watchedQuests[questName] = true end
			end
		end
	end
end

function QuestsFu_Tracker:AddQuestWatch(questid)
	local questName = quixote:GetQuestById(questid)
	if questName then
		self.db.char.watchedQuests[questName] = true
	end
	QuestWatchFrame:Hide()
end

function QuestsFu_Tracker:RemoveQuestWatch(questid)
	local questName = quixote:GetQuestById(questid)
	if questName then
		self.db.char.watchedQuests[questName] = nil
	end
end

function QuestsFu_Tracker:Quixote_Quest_Lost(name, id)
	if self.db.profile.useOwnTracker then
		self.db.char.watchedQuests[name] = nil
	end
	if #self.db.char.autowatched > 0 then
		for i,n in pairs(self.db.char.autowatched) do
			if n == name then
				table.remove(self.db.char.autowatched, i)
				break
			end
		end
	end
	if self.db.profile.rememberQuestgiver then
		self.db.char.questgivers[name] = nil
	end
end

function QuestsFu_Tracker:OnZoneChange()
	if not (self.db.profile.zone or self.db.profile.subzone) then return end
	if UnitIsDeadOrGhost('player') then return end
	local zone = GetRealZoneText()
	local subzone = GetSubZoneText()
	--Get rid of Trackered quests
	for i, name in pairs(self.db.char.autowatched) do
		local questid = select(8, quixote:GetQuestByName(name))
		RemoveQuestWatch(questid)
		self.db.char.autowatched[i] = nil
	end
	for _, questid in quixote:QuestsByZone(zone) do
		local name = quixote:GetQuestById(questid)
		-- If we're already watching it, don't Tracker.  (This way it won't be de-watched when we leave the zone.)
		if not self.db.char.watchedQuests[name] then
			if self.db.profile.zone then
				table.insert(self.db.char.autowatched, name)
				AddQuestWatch(questid)
			elseif self.db.profile.subzone and subzone ~= "" then
				local objective, description = quixote:GetQuestText(questid)
				if string.find(objective, subzone, 1, true) or string.find(description, subzone, 1, true) then
					table.insert(self.db.char.autowatched, name)
					AddQuestWatch(questid)
				end
			end
		end
	end
	self:Update()
end

function QuestsFu_Tracker:Quixote_Leaderboard_Update(name, id, lid, desc, numHad, numGot, numNeeded)
	if AUTO_QUEST_WATCH=="0" and self.db.profile.progress then
		AddQuestWatch(id)
	end
	self:Update()
end

function QuestsFu_Tracker:Quixote_Quest_Gained(name, id)
	if self.db.profile.gained then
		AddQuestWatch(id)
	end
	if self.db.profile.zone then
		local zone = GetRealZoneText()
		local questzone = select(7, quixote:GetQuestById(id))
		if zone == questzone then
			AddQuestWatch(id)
		end
	elseif self.db.profile.subzone then
		local subzone = GetSubZoneText()
		local objective, description = quixote:GetQuestText(id)
		if subzone ~= "" and (string.find(objective, subzone, 1, true) or string.find(description, subzone, 1, true)) then
			table.insert(self.db.char.autowatched, name)
			AddQuestWatch(id)
		end
	end
	self:Update()
end

function QuestsFu_Tracker:Quixote_Quest_Complete(name, id)
	if self.db.profile.removeCompleted then
		RemoveQuestWatch(id)
	end
	self:Update()
end

--- Tracker ---

function QuestsFu_Tracker:UpdateTooltip(object)
	self:Update()
	return self.hooks[object].UpdateTooltip(object)
end

do
	local function tableCleaner(t)
		--Nil out the table and any other tables nested within it
		for k in pairs(t) do
			if type(t[k]) == 'table' then
				tableCleaner(t[k])
			end
			t[k] = nil
		end
	end
	local function sortQuestsByLevel(a, b)
		local level_a = select(2, quixote:GetQuestByName(a))
		local level_b = select(2, quixote:GetQuestByName(b))
		if not (level_a and level_b) or level_a == level_b then
			return a < b
		else
			return level_a < level_b
		end
	end

	function QuestsFu_Tracker:Update()
		if self.db.profile.useOwnTracker then
			local trackerOrder = {}
			if not tablet:IsRegistered('QuestsFu_Tracker') then
				tablet:Register('QuestsFu_Tracker', 'detachedData', self.db.profile.data, 'cantAttach', true,
					'dontHook', true, 'hideWhenEmpty', true, 'strata', self.db.profile.strata,
					'minWidth', self.db.profile.minWidth, 'maxHeight', self.db.profile.maxHeight,
					'menu', function() dewdrop:FeedAceOptionsTable(self.menu) end,
					'children', function()
						--Sort the quests:
						for questName in pairs(self.db.char.watchedQuests) do
							table.insert(trackerOrder, questName)
						end
						table.sort(trackerOrder, sortQuestsByLevel)
						--Display them:
						tablet:SetTitle("Tracker")
						local cat = tablet:AddCategory('columns', 2, 'child_func', QuestsFu.QuestClick, 'child_arg1', QuestsFu)
						for _,questName in pairs(trackerOrder) do QuestsFu:AddQuestToCategory(cat, questName, false, true, true) end
						--Clear up the order table:
						tableCleaner(trackerOrder)
					end)
				tablet:Open('QuestsFu_Tracker')
			end
			tablet:Refresh('QuestsFu_Tracker')
			QuestWatchFrame:Hide()
		end
	end
end
