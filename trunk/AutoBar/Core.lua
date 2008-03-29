--[[
Name: AutoBar
Author: Toadkiller of Proudmoore
Credits: Saien the original author.  Sayclub (Korean), PDI175 (Chinese traditional and simplified), Teodred (German), Cinedelle (French), shiftos (Spanish)
Website: http://www.wowace.com/
Description: Dynamic 24 button bar automatically adds potions, water, food and other items you specify into a button for use. Does not use action slots so you can save those for spells and abilities.
]]
local REVISION = tonumber(("$Revision: 55356 $"):match("%d+"))
local DATE = ("$Date: 2007-05-31 17:44:03 -0400 (Thu, 31 May 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
--
-- Copyright 2004, 2005, 2006 original author.
-- New Stuff Copyright 2006+ Toadkiller of Proudmoore.

-- Maintained by Azethoth / Toadkiller of Proudmoore.  Original author Saien of Hyjal
-- http://code.google.com/p/autobar/

-- See Changelist.lua for changes


--
-- The Update Cycle / Hierarchy
--

-- Initialize
-- UpdateCategories
-- UpdateSpells
-- UpdateStyles
-- UpdateObjects
-- UpdateRescan
-- UpdateScan
-- UpdateAttributes
-- UpdateActive
-- UpdateButtons

-- In normal operation after one each of UpdateCategories through UpdateObjects,
-- The Update functions can be called directly or via AutoBar.delay["UpdateButtons"].
-- Delayed calls allow multiple updates to clump & get dealt with at once, especially after combat ends.

local _G = getfenv(0)
local L = AceLibrary("AceLocale-2.2"):new("AutoBar")
local LBS = LibStub("LibBabble-Spell-3.0")
local BS = LBS:GetLookupTable()
local LibStickyFrames = LibStub("LibStickyFrames-1.0")
local AceOO = AceLibrary("AceOO-2.0")
local AceEvent = AceLibrary("AceEvent-2.0")
local waterfall = AceLibrary("Waterfall-1.0")

-- If the Debug library is available then use it
if AceLibrary:HasInstance("AceDebug-2.0") then
	AutoBar = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AutoBarConsole-1.0", "AceDB-2.0", "AceHook-2.1", "AceDebug-2.0");
else
	AutoBar = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AutoBarConsole-1.0", "AceDB-2.0", "AceHook-2.1");
end
AutoBar.revision = REVISION
AutoBar.date = DATE

AutoBar.delay = {}

--	<Binding name="AutoBarButtonBear_X" runOnUp="true" header="AutoBarClassBarMage">--[[ dummy ]]</Binding>
--	<Binding name="AutoBarButtonBear_X" runOnUp="true" header="AutoBarClassBarPaladin">--[[ dummy ]]</Binding>
--	<Binding name="AutoBarButtonBear_X" runOnUp="true" header="AutoBarClassBarPriest">--[[ dummy ]]</Binding>
--	<Binding name="AutoBarButtonBear_X" runOnUp="true" header="AutoBarClassBarWarlock">--[[ dummy ]]</Binding>
--	<Binding name="AutoBarButtonBear_X" runOnUp="true" header="AutoBarClassBarWarrior">--[[ dummy ]]</Binding>

BINDING_HEADER_AUTOBAR_SEP = L["AutoBar"];
BINDING_NAME_AUTOBAR_CONFIG = L["CONFIG_WINDOW"];

BINDING_HEADER_AutoBarButtonHeader = L["AutoBarButtonHeader"]
BINDING_NAME_AutoBarButtonHearth_X = L["AutoBarButtonHearth"]
BINDING_NAME_AutoBarButtonMount_X = L["AutoBarButtonMount"]
BINDING_NAME_AutoBarButtonBandages_X = L["AutoBarButtonBandages"]
BINDING_NAME_AutoBarButtonHeal_X = L["AutoBarButtonHeal"]
BINDING_NAME_AutoBarButtonRecovery_X = L["AutoBarButtonRecovery"]
BINDING_NAME_AutoBarButtonFood_X = L["AutoBarButtonFood"]
BINDING_NAME_AutoBarButtonFoodBuff_X = L["AutoBarButtonFoodBuff"]
BINDING_NAME_AutoBarButtonFoodCombo_X = L["AutoBarButtonFoodCombo"]
BINDING_NAME_AutoBarButtonBuff_X = L["AutoBarButtonBuff"]
BINDING_NAME_AutoBarButtonBuffWeapon1_X = L["AutoBarButtonBuffWeapon1"]
BINDING_NAME_AutoBarButtonBuffWeapon2_X = L["AutoBarButtonBuffWeapon2"]
BINDING_NAME_AutoBarButtonClassBuff_X = L["AutoBarButtonClassBuff"]
BINDING_NAME_AutoBarButtonClassPet_X = L["AutoBarButtonClassPet"]
BINDING_NAME_AutoBarButtonFreeAction_X = L["AutoBarButtonFreeAction"]
BINDING_NAME_AutoBarButtonER_X = L["AutoBarButtonER"]
BINDING_NAME_AutoBarButtonExplosive_X = L["AutoBarButtonExplosive"]
BINDING_NAME_AutoBarButtonFishing_X = L["AutoBarButtonFishing"]
BINDING_NAME_AutoBarButtonBattleStandards_X = L["AutoBarButtonBattleStandards"]
BINDING_NAME_AutoBarButtonTrinket1_X = L["AutoBarButtonTrinket1"]
BINDING_NAME_AutoBarButtonTrinket2_X = L["AutoBarButtonTrinket2"]
BINDING_NAME_AutoBarButtonPets_X = L["AutoBarButtonPets"]
BINDING_NAME_AutoBarButtonQuest_X = L["AutoBarButtonQuest"]
BINDING_NAME_AutoBarButtonSpeed_X = L["AutoBarButtonSpeed"]
BINDING_NAME_AutoBarButtonStance_X = L["AutoBarButtonStance"]
BINDING_NAME_AutoBarButtonStealth_X = L["AutoBarButtonStealth"]
BINDING_NAME_AutoBarButtonWater_X = L["AutoBarButtonWater"]

BINDING_HEADER_AutoBarCooldownHeader = L["AutoBarCooldownHeader"]
BINDING_NAME_AutoBarButtonCooldownPotionHealth_X = L["AutoBarButtonCooldownPotionHealth"]
BINDING_NAME_AutoBarButtonCooldownStoneHealth_X = L["AutoBarButtonCooldownStoneHealth"]
BINDING_NAME_AutoBarButtonCooldownPotionMana_X = L["AutoBarButtonCooldownPotionMana"]
BINDING_NAME_AutoBarButtonCooldownStoneMana_X = L["AutoBarButtonCooldownStoneMana"]
BINDING_NAME_AutoBarButtonCooldownPotionRejuvenation_X = L["AutoBarButtonCooldownPotionRejuvenation"]
BINDING_NAME_AutoBarButtonCooldownStoneRejuvenation_X = L["AutoBarButtonCooldownStoneRejuvenation"]

BINDING_HEADER_AutoBarClassBarDruid = L["AutoBarClassBarDruid"]
BINDING_NAME_AutoBarButtonBear_X = L["AutoBarButtonBear"]
BINDING_NAME_AutoBarButtonBoomkinTree_X = L["AutoBarButtonBoomkinTree"]
BINDING_NAME_AutoBarButtonCat_X = L["AutoBarButtonCat"]
BINDING_NAME_AutoBarButtonTravel_X = L["AutoBarButtonTravel"]

BINDING_HEADER_AutoBarClassBarHunter = L["AutoBarClassBarHunter"]
BINDING_NAME_AutoBarButtonFoodPet_X = L["AutoBarButtonFoodPet"]
BINDING_NAME_AutoBarButtonSting_X = L["AutoBarButtonSting"]
BINDING_NAME_AutoBarButtonTrap_X = L["AutoBarButtonTrap"]

BINDING_HEADER_AutoBarClassBarMage = L["AutoBarClassBarMage"]

BINDING_HEADER_AutoBarClassBarPaladin = L["AutoBarClassBarPaladin"]

BINDING_HEADER_AutoBarClassBarPriest = L["AutoBarClassBarPriest"]

BINDING_HEADER_AutoBarClassBarRogue = L["AutoBarClassBarRogue"]
BINDING_NAME_AutoBarButtonPickLock_X = L["AutoBarButtonPickLock"]

BINDING_HEADER_AutoBarClassBarShaman = L["AutoBarClassBarShaman"]
BINDING_NAME_AutoBarButtonTotemAir_X = L["AutoBarButtonTotemAir"]
BINDING_NAME_AutoBarButtonTotemEarth_X = L["AutoBarButtonTotemEarth"]
BINDING_NAME_AutoBarButtonTotemFire_X = L["AutoBarButtonTotemFire"]
BINDING_NAME_AutoBarButtonTotemWater_X = L["AutoBarButtonTotemWater"]

BINDING_HEADER_AutoBarClassBarWarlock = L["AutoBarClassBarWarlock"]

BINDING_HEADER_AutoBarClassBarWarrior = L["AutoBarClassBarWarrior"]

function AutoBar:ConfigToggle()
	if (not InCombatLockdown()) then
		if (waterfall:IsOpen("AutoBar")) then
			waterfall:Close("AutoBar")
		else
			AutoBar:OpenOptions()
		end
	end
end


function AutoBar:OnInitialize()
	AutoBar.currentPlayer = UnitName("player") .. " - " .. GetCVar("realmName");
	_, AutoBar.CLASS = UnitClass("player");
	AutoBar.CLASSPROFILE = "_" .. AutoBar.CLASS;

	self:RegisterDB("AutoBarDB", "AutoBarDBPC", "class")

	AutoBar.inWorld = false;
	AutoBar.inCombat = false;	-- For item use restrictions
	AutoBar.inBG = false;		-- For battleground only items

	-- Single parent for key binding overides
	self.keyFrame = CreateFrame("Frame", nil, UIParent)

	-- List of buttonName = AutoBarButton
	self.buttonList = {}
	-- List of buttonName = AutoBarButton for disabled buttons
	self.buttonListDisabled = {}

	AutoBar:LogEvent("OnInitialize")
	self:InitializeOptions()
	self:InitializeDelays()
	self:Initialize()
	self:RegisterEvent("AceEvent_FullyInitialized", "FullyInitialized")
end

function AutoBar:FullyInitialized()
	AutoBar:UpdateCategories()
	AutoBar.delay["UpdateStyles"]:Start()
	AutoBar.enableBindings = true
	AutoBar.Class.Bar:RegisterStickyFrames()
end

function AutoBar:OnEnable(first)
	self:LogEvent("OnEnable")

	-- Called when the addon is enabled
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	self:RegisterEvent("SPELLS_CHANGED")
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE")

	-- For item use restrictions
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_CONTROL_GAINED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_ALIVE")
	self:RegisterEvent("PLAYER_UNGHOST")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN")
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
end


function AutoBar:OnDisable()
	-- Called when the addon is disabled
	AutoBar:LogEvent("OnDisable")
end

local logItems = {}	-- n = startTime

function AutoBar:LogEvent(eventName, arg1)
	if (AutoBar.db.profile.performance) then
		if (arg1) then
			AutoBar:Print(eventName .. " arg1 " .. tostring(arg1) .. " time: " .. GetTime())
		else
			AutoBar:Print(eventName .. " time: " .. GetTime())
		end
	end
end

function AutoBar:LogEventStart(eventName)
	if (AutoBar.db.profile.performance) then
		if (logItems[eventName]) then
			AutoBar:Print(eventName .. " restarted before previous completion")
		else
			logItems[eventName] = GetTime()
			AutoBar:Print(eventName .. " started time: " .. logItems[eventName])
		end
	end
end

function AutoBar:LogEventEnd(eventName, arg1)
	if (AutoBar.db.profile.performance) then
		if (logItems[eventName]) then
			local elapsed = GetTime() - logItems[eventName]
			logItems[eventName] = nil
			if (arg1) then
				AutoBar:Print(eventName .. " " .. tostring(arg1) .. " time: " .. elapsed)
			else
				AutoBar:Print(eventName .. " time: " .. elapsed)
			end
		else
			AutoBar:Print(eventName .. " restarted before previous completion")
		end
	end
end


-- Will not update if set during combat
function AutoBar:RegisterOverrideBindings()
	AutoBar:LogEvent("RegisterOverrideBindings")
	ClearOverrideBindings(AutoBar.keyFrame)
	for barKey, bar in pairs(AutoBar.barList) do
		for buttonIndex, buttonDB in ipairs(self.db.profile.bars[barKey].buttons) do
			AutoBar.Class.Button:UpdateBindings(buttonDB.name, buttonDB.name .. "Frame")
		end
	end
end
--/dump GetBindingKey("AutoBarButtonHearth_X")
--/script ClearOverrideBindings(AutoBar.keyFrame)
--/script SetOverrideBindingClick(AutoBar.keyFrame, false, "F5", AutoBar.buttonList["AutoBarButtonHearth"]:GetButtonFrameName())
--/script AutoBar.buttonList["AutoBarButtonTravel"]:UpdateBindings()
--/script AutoBar:RegisterOverrideBindings()

-- Layered delayed callback objects
-- Timers lower down the list are superceded and cancelled by those higher up
local timerList = {
	{name = "AutoBarInit", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateCategories", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateSpells", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateStyles", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateObjects", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateRescan", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateScan", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateAttributes", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateActive", timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateButtons", timer = nil, runPostCombat = false, callback = nil},
}
local timerIndexList = {
	["AutoBarInit"] = 1,
	["UpdateCategories"] = 2,
	["UpdateSpells"] = 3,
	["UpdateStyles"] = 4,
	["UpdateObjects"] = 5,
	["UpdateRescan"] = 6,
	["UpdateScan"] = 7,
	["UpdateAttributes"] = 8,
	["UpdateActive"] = 9,
	["UpdateButtons"] = 10,
}
local IDelayedCallback = AceOO.Interface { Callback = "function" }

local DELAY_TIME = 0.06
local DELAY_TIME_INCREMENTAL = 0.01

local Delayed = AceOO.Class(IDelayedCallback)
Delayed.virtual = true -- this means that it cannot be instantiated. (cannot call :new())
Delayed.prototype.postCombat = false -- Set to true to trigger call after combat
Delayed.prototype.timerList = timerList
Delayed.prototype.timerListIndex = 0
Delayed.prototype.timerInfo = 0
Delayed.prototype.name = "No Name"

function Delayed.prototype:init(timerListIndex)
	Delayed.super.prototype.init(self)
	self.timerListIndex = timerListIndex
	self.timerInfo = timerList[timerListIndex]
	self.name = timerList[timerListIndex].name
--	AutoBar:Print("Delayed.prototype:init " .. tostring(self.name))
end

function Delayed.prototype:Callback()
	self.timerInfo.timer = nil
end

-- Returns a new or recycled list object
function Delayed.prototype:Start(arg1)
	AutoBar:LogEvent("--> DELAYED ", self.name)

	-- If in combat delay call till after combat
	if (InCombatLockdown()) then
		self.timerInfo.runPostCombat = true
		return
	end

	local currentTime = GetTime()
	local function MyCallback()
		local myself = self
		local arg1 = arg1
--AutoBar:Print("***MyCallback "..myself.name.." at  " .. tostring(GetTime()).." arg1  " .. tostring(arg1))
		myself:Callback(arg1)
	end

--AutoBar:Print("***Delayed.prototype:Start "..self.name.." here ");
	if (self.timerInfo.timer) then
--AutoBar:Print("***Delayed.prototype:Start "..self.name.." extend timer at " .. currentTime);
		-- Timer not expired, extend it
		if (currentTime - self.timerInfo.timer > DELAY_TIME - DELAY_TIME_INCREMENTAL) then
			-- Almost or already exceeding DELAY_TIME, so use a small incremental delay
			AutoBar:CancelScheduledEvent(self.name)
			AutoBar:ScheduleEvent(self.name, MyCallback, DELAY_TIME_INCREMENTAL)
		else
			-- Still more than DELAY_TIME_INCREMENTAL before the original timer so do not change it
		end
	else
		-- Cancel if higher level timer already in progress
		for i, timerInfo in ipairs(self.timerList) do
			if (i < self.timerListIndex and timerInfo.timer) then
--AutoBar:Print("***Delayed.prototype:Start cancel "..self.name.." because " .. timerInfo.name)
				return
			elseif (i == self.timerListIndex) then
				break
			end
		end

		-- Start new Timer
		self.timerInfo.timer = currentTime;
		AutoBar:ScheduleEvent(self.name, MyCallback, DELAY_TIME)
--AutoBar:Print("***Delayed.prototype:Start start "..self.name.." delay at " .. currentTime)

		-- Cancel Superceded timers
		for i, timerInfo in ipairs(self.timerList) do
			if (i > self.timerListIndex and timerInfo.timer) then
				AutoBar:CancelScheduledEvent(timerInfo.name)
				timerInfo.timer = nil
			end
		end
	end
--AutoBar:Print("***Delayed.prototype:Start "..self.name.." end ");
end


function AutoBar:PLAYER_ENTERING_WORLD()
	AutoBar.inCombat = false;
	local scanned = false;
	if (not AutoBar.initialized) then
--AutoBar:Print("   PLAYER_ENTERING_WORLD")
		AutoBar.delay["UpdateCategories"]:Start()
		scanned = true;
		AutoBar.initialized = true;
	end

	if (not AutoBar.inWorld) then
		AutoBar.inWorld = true;
--AutoBar:Print("   PLAYER_ENTERING_WORLD")
		AutoBar.delay["UpdateCategories"]:Start()
	end
end


function AutoBar:PLAYER_LEAVING_WORLD()
	AutoBar.inWorld = false;
end


function AutoBar:BAG_UPDATE(arg1)
	AutoBar:LogEvent("BAG_UPDATE", arg1)
	if (AutoBar.inWorld and arg1 <= NUM_BAG_FRAMES) then
		AutoBarSearch.dirtyBags[arg1] = true
		if (InCombatLockdown()) then
			for buttonName, button in pairs(AutoBar.buttonList) do
				button:UpdateCount()
			end
		else
			AutoBar.delay["UpdateScan"]:Start()
		end
	end
end


function AutoBar:BAG_UPDATE_COOLDOWN(arg1)
	AutoBar:LogEvent("BAG_UPDATE_COOLDOWN", arg1)
--AutoBar:Print("   BAG_UPDATE_COOLDOWN arg1 " .. tostring(arg1))
	if (not InCombatLockdown()) then
		AutoBar.delay["UpdateScan"]:Start(arg1)
	end
	for buttonName, button in pairs(AutoBar.buttonList) do
		button:UpdateCooldown()
	end
end


function AutoBar:SPELL_UPDATE_COOLDOWN(arg1)
	AutoBar:LogEvent("SPELL_UPDATE_COOLDOWN", arg1)
--AutoBar:Print("   SPELL_UPDATE_COOLDOWN arg1 " .. tostring(arg1))
	for buttonName, button in pairs(AutoBar.buttonList) do
		button:UpdateCooldown()
	end
end


function AutoBar:ACTIONBAR_UPDATE_USABLE(arg1)
	AutoBar:LogEvent("ACTIONBAR_UPDATE_USABLE", arg1)
	if (AutoBar.inWorld) then
		if (InCombatLockdown()) then
			for buttonName, button in pairs(AutoBar.buttonList) do
				button:UpdateUsable()
			end
			pendingScan = true
		else
			AutoBar.delay["UpdateScan"]:Start(arg1)
		end
	end
end


function AutoBar:UPDATE_SHAPESHIFT_FORMS(arg1)
	AutoBar:LogEvent("UPDATE_SHAPESHIFT_FORMS", arg1)
	if (AutoBar.inWorld) then
		if (InCombatLockdown()) then
			for buttonName, button in pairs(AutoBar.buttonList) do
				button:UpdateUsable()
			end
			pendingScan = true
		else
			AutoBar.delay["UpdateScan"]:Start(arg1)
		end
	end
end


function AutoBar:UPDATE_BINDINGS()
	if (not InCombatLockdown()) then
--AutoBar:Print("UPDATE_BINDINGS:RegisterOverrideBindings")
		self:RegisterOverrideBindings()
		AutoBar.delay["UpdateButtons"]:Start()
	end
end


function AutoBar:LEARNED_SPELL_IN_TAB(arg1)
	AutoBar:LogEvent("LEARNED_SPELL_IN_TAB", arg1)
	AutoBar.delay["UpdateSpells"]:Start(arg1)
end


function AutoBar:SPELLS_CHANGED(arg1)
	AutoBar:LogEvent("SPELLS_CHANGED", arg1)
	AutoBar.delay["UpdateSpells"]:Start(arg1)
end


function AutoBar:ZONE_CHANGED(arg1)
	AutoBar:LogEvent("ZONE_CHANGED", arg1)
	if (not InCombatLockdown()) then
--		AutoBar.delay["UpdateActive"]:Start()
	end
end


function AutoBar:ZONE_CHANGED_INDOORS(arg1)
	AutoBar:LogEvent("ZONE_CHANGED_INDOORS", arg1)
	if (not InCombatLockdown()) then
--		AutoBar.delay["UpdateActive"]:Start()
	end
end


function AutoBar:ZONE_CHANGED_NEW_AREA(arg1)
	AutoBar:LogEvent("ZONE_CHANGED_NEW_AREA", arg1)
	if (not InCombatLockdown()) then
		AutoBar.delay["UpdateActive"]:Start()
	end
end


function AutoBar:PLAYER_CONTROL_GAINED()
	AutoBar:LogEvent("PLAYER_CONTROL_GAINED", arg1)
	if (not InCombatLockdown()) then
		AutoBar.delay["UpdateButtons"]:Start()
	end
end


function AutoBar:PLAYER_REGEN_ENABLED(arg1)
	AutoBar:LogEvent("PLAYER_REGEN_ENABLED", arg1)
	AutoBar.inCombat = false
	AutoBar.delay["UpdateRescan"]:Start()
end


function AutoBar:PLAYER_REGEN_DISABLED(arg1)
	AutoBar:LogEvent("PLAYER_REGEN_DISABLED", arg1)
	AutoBar.inCombat = true
--AutoBar:Print("   PLAYER_REGEN_DISABLED")
	if (self:IsEventScheduled("UpdateRescan")) then
		self:CancelScheduledEvent("UpdateRescan")
		AutoBarSearch.stuff:Reset()
	elseif (self:IsEventScheduled("UpdateScan")) then
		self:CancelScheduledEvent("UpdateScan")
		AutoBarSearch.stuff:Scan()
	elseif (self:IsEventScheduled("UpdateActive")) then
		self:CancelScheduledEvent("UpdateActive")
	elseif (self:IsEventScheduled("UpdateButtons")) then
		self:CancelScheduledEvent("UpdateButtons")
	end
	AutoBar:UpdateActive()
	if (waterfall:IsOpen("AutoBar")) then
		waterfall:Close("AutoBar")
	end
end


--function AutoBar:UNIT_MANA()
--	if (arg1 == "player") then
--		AutoBar:LogEvent("UNIT_MANA", arg1)
--		if (not InCombatLockdown()) then
--			AutoBar.delay["UpdateButtons"]:Start()
--		end
--	end
--end
--
--
--function AutoBar:UNIT_HEALTH()
--	if (arg1 == "player") then
--		AutoBar:LogEvent("UNIT_HEALTH", arg1)
--		if (not InCombatLockdown()) then
--			AutoBar.delay["UpdateButtons"]:Start()
--		end
--	end
--end


function AutoBar:PLAYER_ALIVE(arg1)
	if (not InCombatLockdown()) then
		AutoBar:LogEvent("PLAYER_ALIVE", arg1)
		AutoBar.delay["UpdateButtons"]:Start()
	end
end


function AutoBar:PLAYER_UNGHOST(arg1)
	if (not InCombatLockdown()) then
		AutoBar:LogEvent("PLAYER_UNGHOST", arg1)
		AutoBar.delay["UpdateButtons"]:Start()
	end
end


function AutoBar:UPDATE_BATTLEFIELD_STATUS()
	if (AutoBar.inWorld) then
		local bgStatus = false
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status, mapName, instanceID = GetBattlefieldStatus(i);
			if (instanceID ~= 0) then
				bgStatus = true
				break
			end
		end
		if (AutoBar.inBG ~= bgStatus) then
			AutoBar.inBG = bgStatus
			AutoBar.delay["UpdateActive"]:Start()
		end
	end
end


-- When dragging, contains { frameName, index }, otherwise nil
AutoBar.dragging = nil;
local draggingData = {};

function AutoBar.GetDraggingIndex(frameName)
	if (AutoBar.dragging and AutoBar.dragging.frameName == frameName) then
		return AutoBar.dragging.index;
	end
	return nil;
end


function AutoBar.SetDraggingIndex(frameName, index)
	draggingData.frameName = frameName;
	draggingData.index = index;
	AutoBar.dragging = draggingData;
end


function AutoBar.LinkDecode(link)
	if (link) then
		local _, _, id, _, _, _, name = string.find(link, "item:(%d+):(%d+):(%d+):(%d+).+%[(.+)%]");
		if (id and name) then
			return name, tonumber(id);
		end
	end
end



AutoBar.dockingFrames = {
	["NONE"] = {
		text = L["AUTOBAR_CONFIG_DOCKTONONE"],
		offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
	},
	["BT3Bar1"] = {
		text = L["AUTOBAR_CONFIG_BT3BAR"]..1,
		offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
	},
	["BT3Bar2"] = {
		text = L["AUTOBAR_CONFIG_BT3BAR"]..2,
		offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
	},
	["BT3Bar3"] = {
		text = L["AUTOBAR_CONFIG_BT3BAR"]..3,
		offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
	},
	["BT3Bar4"] = {
		text = L["AUTOBAR_CONFIG_BT3BAR"]..4,
		offset = { x = 0, y = 0, point = "CENTER", relative = "BOTTOMLEFT" },
	},
	["BT3Bar6"] = {
		text = L["AUTOBAR_CONFIG_BT3BAR"]..6,
		offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
	},
	["BT3Bar10"] = {
		text = L["AUTOBAR_CONFIG_BT3BAR"]..10,
		offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
	},
	["MainMenuBarArtFrame"] = {
		text = L["AUTOBAR_CONFIG_DOCKTOMAIN"],
		offset = { x = 0, y = 0, point = "CENTER", relative = "TOPRIGHT" },
	},
	["ChatFrame1"] = {
		text = L["AUTOBAR_CONFIG_DOCKTOCHATFRAME"],
		offset = { x = 0, y = 25, point = "CENTER", relative = "TOPLEFT" },
	},
	["ChatFrameMenuButton"] = {
		text = L["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"],
		offset = { x = 0, y = 25, point = "CENTER", relative = "TOPLEFT" },
	},
	["MainMenuBar"] = {
		text = L["AUTOBAR_CONFIG_DOCKTOACTIONBAR"],
		offset = { x = 7, y = 40, point = "CENTER", relative = "TOPLEFT" },
	},
	["CharacterMicroButton"] = {
		text = L["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"],
		offset = { x = 0, y = 0, point = "CENTER", relative = "BOTTOMLEFT" },
	},
}

AutoBar.dockingFramesValidateList = {
	["NONE"] = L["AUTOBAR_CONFIG_DOCKTONONE"],
	["BT3Bar1"] = L["AUTOBAR_CONFIG_BT3BAR"]..1,
	["BT3Bar2"] = L["AUTOBAR_CONFIG_BT3BAR"]..2,
	["BT3Bar3"] = L["AUTOBAR_CONFIG_BT3BAR"]..3,
	["BT3Bar4"] = L["AUTOBAR_CONFIG_BT3BAR"]..4,
	["BT3Bar6"] = L["AUTOBAR_CONFIG_BT3BAR"]..6,
	["BT3Bar10"] = L["AUTOBAR_CONFIG_BT3BAR"]..10,
	["MainMenuBarArtFrame"] = L["AUTOBAR_CONFIG_DOCKTOMAIN"],
	["ChatFrame1"] = L["AUTOBAR_CONFIG_DOCKTOCHATFRAME"],
	["ChatFrameMenuButton"] = L["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"],
	["MainMenuBar"] = L["AUTOBAR_CONFIG_DOCKTOACTIONBAR"],
	["CharacterMicroButton"] = L["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"],
}


function AutoBar:StateChanged(newState)
	AutoBar:Print(self:GetName().. ": " .. tostring(self:GetAttribute("state")));
end

-- Initialize
--		All Initialization
-- UpdateCategories
--		Based on the current db, add or remove Custom Categories
-- UpdateSpells
--		Rescan all registerred spells
--		This is on a less frequent cycle than UpdateScan.  Called on leveling or spellbook changes.
--		ToDo: Also trigger on spec changes
-- UpdateStyles
--		Based on the current Style setting, update all instantiated Bars, Buttons, Popups
--		New objects obey current Style settings on instantiation
-- UpdateObjects
--		Based on the current db, instantiate or refresh Bars, Buttons
--		Move disabled Bars, Buttons to cold storage, & thaw out re-enabled ones
--		This is done on Initialize and on Configuration changes
--		Could be triggered by events (Boss specific categories for instance)
-- UpdateRescan
--		Rescan all bags and inventory from scratch based on current Buttons and their Categories
-- UpdateScan
--		Scan all bags and inventory based on current Buttons and their Categories
--		Triggered by bag & inventory changes, combat end
-- UpdateAttributes
--		Based on the current Scan results, update the Button and Popup Attributes
--		Create Popup Buttons as needed
-- UpdateActive
--		Based on the current Scan results, Bars and their Buttons, determine the active Buttons
-- UpdateButtons
--		Based on the active Bars and their Buttons display them
--		Triggered by events

-- ToDo: Mmm Styles callback should be pulled out of the hierarchy



function AutoBar:Initialize()
--AutoBar:Print("AutoBar:Initialize")
	self:LogEventStart("AutoBar:Initialize")
	AutoBarCategory:Initialize()
	AutoBarCategory:UpdateCustomCategoriesOptions()
	AutoBarCategory:UpdateCustomCategories()
	AutoBarSearch:Initialize()
	AutoBarButton:TooltipHackInitialize()
	self:LogEventEnd("AutoBar:Initialize")
AutoBarSearch:Test()
end

-- Complete reload of everything.  Dump most old data structures.
local DelayedInitialize = AceOO.Class(Delayed)

function DelayedInitialize.prototype:init(timerListIndex)
	DelayedInitialize.super.prototype.init(self, timerListIndex)
end

function DelayedInitialize.prototype:Callback()
--AutoBar:Print("   DelayedInitialize.prototype:Callback  self "..tostring(self))
	DelayedInitialize.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedInitialize <--")
	AutoBar:Initialize()
	AutoBar:UpdateCategories()
end



-- Based on the current db, add or remove Custom Categories
-- ToDo: support scheme for mutable categories like pet food.
function AutoBar:UpdateCategories()
	self:LogEventStart("AutoBar:UpdateCategories")
	AutoBarCategory:UpdateCustomCategories()
	AutoBarCategory:UpdateCustomCategoriesOptions()
	self:LogEventEnd("AutoBar:UpdateCategories")
	self:UpdateSpells()
end

local DelayedUpdateCategories = AceOO.Class(Delayed)

function DelayedUpdateCategories.prototype:init()
	DelayedUpdateCategories.super.prototype.init(self, timerIndexList["UpdateCategories"])
end

function DelayedUpdateCategories.prototype:Callback()
	DelayedUpdateCategories.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateCategories <--")
	AutoBar:UpdateCategories()
end



-- Rescan all registerred spells
function AutoBar:UpdateSpells()
	self:LogEventStart("AutoBar:UpdateSpells")
	AutoBarSearch.stuff:ScanSpells()
	AutoBarCategory:UpdateCategories()
--	AutoBar:RefreshButtons()
	self:LogEventEnd("AutoBar:UpdateSpells")
	-- ToDo: make this update on learn.
	self:UpdateStyles()
end

local DelayedUpdateSpells = AceOO.Class(Delayed)

function DelayedUpdateSpells.prototype:init()
	DelayedUpdateSpells.super.prototype.init(self, timerIndexList["UpdateSpells"])
end

function DelayedUpdateSpells.prototype:Callback()
	DelayedUpdateSpells.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateSpells <--")
	AutoBar:UpdateSpells()
end



-- Based on the current Style setting, update all instantiated Bars, Buttons, Popups
function AutoBar:UpdateStyles()
	self:LogEventStart("AutoBar:UpdateStyles")

	if (AutoBar.style) then
		AutoBar:GetDB().style = AutoBar.style
		AutoBar.style = nil
	end

	self:LogEvent("AutoBar:UpdateStyles " .. tostring(AutoBar:GetStyle().name))
	for barKey, bar in pairs(AutoBar.barList) do
		bar:RefreshStyle()
	end
--	for buttonName, button in pairs(AutoBar.buttonList) do
--		AutoBar:RefreshStyle(button.frame, button.parentBar)
--	end
--	for buttonName, button in pairs(AutoBar.buttonListDisabled) do
--		AutoBar:RefreshStyle(button.frame, button.parentBar)
--	end
	self:LogEventEnd("AutoBar:UpdateStyles")
	self:UpdateObjects()
end
--/script AutoBar:RefreshStyle(AutoBar.buttonList["AutoBarButtonTrinket1"].frame, AutoBar.buttonList["AutoBarButtonTrinket1"].parentBar)

local DelayedUpdateStyles = AceOO.Class(Delayed)

function DelayedUpdateStyles.prototype:init()
	DelayedUpdateStyles.super.prototype.init(self, timerIndexList["UpdateStyles"])
end

function DelayedUpdateStyles.prototype:Callback()
	DelayedUpdateStyles.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateStyles <--")
	AutoBar:UpdateStyles()
end



-- Refresh Buttons so they can update spells to cast etc.
--function AutoBar:RefreshButtons()
--	self:LogEventStart("AutoBar:RefreshButtons")
----	local barDBList = AutoBar:GetDB().bars
----	for barKey, barDB in pairs(barDBList) do
----		if (barDB.enabled and AutoBar.barList[barKey]) then
----			local buttonList = AutoBar.barList[barKey].buttonList
----			for buttonIndex, button in ipairs(buttonList) do
----				button:Refresh()
----			end
----		end
----	end
--	self:LogEventEnd("RefreshButtons")
--end



-- Based on the current db, instantiate or refresh Bars, Buttons, Popups
function AutoBar:UpdateObjects()
	self:LogEventStart("AutoBar:UpdateObjects")
	local barDBList = AutoBar:GetDB().bars
	for barKey, barDB in pairs(barDBList) do
		if (barDB.enabled) then
--AutoBar:Print("UpdateObjects barKey " .. tostring(barKey))
			if (AutoBar.barList[barKey]) then
				AutoBar.barList[barKey]:UpdateObjects()
			else
				AutoBar.barList[barKey] = AutoBar.Class.Bar:new(barKey)
			end
		end
	end
	self:LogEventEnd("AutoBar:UpdateObjects")
	self:UpdateRescan()
end

local DelayedUpdateObjects = AceOO.Class(Delayed)

function DelayedUpdateObjects.prototype:init()
	DelayedUpdateObjects.super.prototype.init(self, timerIndexList["UpdateObjects"])
end

function DelayedUpdateObjects.prototype:Callback()
	DelayedUpdateObjects.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateObjects <--")
	AutoBar:UpdateObjects()
end



-- Rescan all bags and inventory from scratch based on current Buttons and their Categories
function AutoBar:UpdateRescan()
	self:LogEventStart("AutoBar:UpdateRescan")
	AutoBarSearch:Reset()
	self:LogEventEnd("AutoBar:UpdateRescan")
	self:UpdateAttributes()
end

local DelayedUpdateRescan = AceOO.Class(Delayed)

function DelayedUpdateRescan.prototype:init()
	DelayedUpdateRescan.super.prototype.init(self, timerIndexList["UpdateRescan"])
end

function DelayedUpdateRescan.prototype:Callback()
	DelayedUpdateRescan.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateRescan <--")
	AutoBar:UpdateRescan()
end



-- Scan all bags and inventory based on current Buttons and their Categories
function AutoBar:UpdateScan()
	self:LogEventStart("AutoBar:UpdateScan")
	AutoBarSearch:UpdateScan()
	self:LogEventEnd("AutoBar:UpdateScan")
	self:UpdateAttributes()
end

local DelayedUpdateScan = AceOO.Class(Delayed)

function DelayedUpdateScan.prototype:init()
	DelayedUpdateScan.super.prototype.init(self, timerIndexList["UpdateScan"])
end

function DelayedUpdateScan.prototype:Callback()
	DelayedUpdateScan.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateScan <--")
	AutoBar:UpdateScan()
end



-- Based on the current Scan results, update the Button and Popup Attributes
-- Create Popup Buttons as needed
function AutoBar:UpdateAttributes()
	self:LogEventStart("AutoBar:UpdateAttributes")
	for barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateAttributes()
	end
	self:LogEventEnd("AutoBar:UpdateAttributes")
	self:UpdateActive()
end

local DelayedUpdateAttributes = AceOO.Class(Delayed)

function DelayedUpdateAttributes.prototype:init()
	DelayedUpdateAttributes.super.prototype.init(self, timerIndexList["UpdateAttributes"])
end

function DelayedUpdateAttributes.prototype:Callback()
	DelayedUpdateAttributes.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateAttributes <--")
	AutoBar:UpdateAttributes()
end



-- Based on the current Scan results, Bars and their Buttons, determine the active Buttons
function AutoBar:UpdateActive()
	self:LogEventStart("AutoBar:UpdateActive")
	for barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateActive()
		bar:RefreshLayout()
	end
	self:LogEventEnd("AutoBar:UpdateActive")
	self:UpdateButtons()
end

local DelayedUpdateActive = AceOO.Class(Delayed)

function DelayedUpdateActive.prototype:init()
	DelayedUpdateActive.super.prototype.init(self, timerIndexList["UpdateActive"])
end

function DelayedUpdateActive.prototype:Callback()
	DelayedUpdateActive.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateActive <--")
	AutoBar:UpdateActive()
end



-- Based on the active Bars and their Buttons display them
function AutoBar:UpdateButtons()
	self:LogEventStart("AutoBar:UpdateButtons")
	for buttonName, button in pairs(self.buttonListDisabled) do
--AutoBar:Print("   AutoBar:UpdateButtons Disabled " .. buttonName);
		assert(not button.buttonDB.enabled, "In disabled list but enabled " .. button.buttonName)
		button:Disable()
		button:UpdateCooldown()
		button:UpdateCount()
		button:UpdateHotkeys()
		button:UpdateIcon()
		button:UpdateUsable()
	end
	for buttonName, button in pairs(self.buttonList) do
--AutoBar:Print("   AutoBar:UpdateButtons Enabled " .. buttonName);
		assert(button.buttonDB.enabled, "In list but disabled " .. button.buttonName)
		button:SetupButton()
		button:UpdateCooldown()
		button:UpdateCount()
		button:UpdateHotkeys()
		button:UpdateIcon()
		button:UpdateUsable()
	end
	self:LogEventEnd("AutoBar:UpdateButtons #buttons " .. tostring(# self.buttonList))
	if (self.enableBindings) then
		self:RegisterOverrideBindings()
		self:RegisterEvent("UPDATE_BINDINGS")
		self.enableBindings = nil
	end
end

local DelayedUpdateButtons = AceOO.Class(Delayed)

function DelayedUpdateButtons.prototype:init()
	DelayedUpdateButtons.super.prototype.init(self, timerIndexList["UpdateButtons"])
end

function DelayedUpdateButtons.prototype:Callback()
	DelayedUpdateButtons.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateButtons <--")
	AutoBar:UpdateButtons()
end


function AutoBar:InitializeDelays()
	AutoBar.delayInitialize = DelayedInitialize:new(timerIndexList["AutoBarInit"])
	AutoBar.delay["UpdateCategories"] = DelayedUpdateCategories:new()
	AutoBar.delay["UpdateSpells"] = DelayedUpdateSpells:new()
	AutoBar.delay["UpdateStyles"] = DelayedUpdateStyles:new()
	AutoBar.delay["UpdateObjects"] = DelayedUpdateObjects:new()
	AutoBar.delay["UpdateRescan"] = DelayedUpdateRescan:new()
	AutoBar.delay["UpdateScan"] = DelayedUpdateScan:new()
	AutoBar.delay["UpdateActive"] = DelayedUpdateActive:new()
	AutoBar.delay["UpdateButtons"] = DelayedUpdateButtons:new()
end


-- Return the display texture of the object
function AutoBar:GetTexture(id, itemType, itemInfo)
	if (not id) then
		return "";
	end

	local texture
	if (itemType) then
		if (itemType == "spell") then
--AutoBar:Print("AutoBar:GetTexture id " .. tostring(id) .. " itemType " .. tostring(itemType).. " itemInfo " ..tostring(itemInfo))
			texture = LBS:GetSpellIcon(id)
		else
			texture = ""
		end
		return texture
	end

	-- Last item has priority so use its icon
	if (type(id) == "table" and id[1]) then
		id = id[# id]
	end

	if (id and AutoBarCategoryList[id]) then
		if (AutoBarCategoryList[id].texture) then
			return AutoBarCategoryList[id].texture
		else
			id = AutoBarCategoryList[id].items[# AutoBarCategoryList[id].items];
		end
	end
	if (type(id)=="number" and id > 0) then
		local _,_,_,_,_,_,_,_,_,texture = GetItemInfo(tonumber(id));

		if (texture) then return texture; end
	end
	return "Interface\\Icons\\INV_Misc_Gift_01";
end


--
-- Bar & Button drag locking / unlocking
--

function AutoBar.ToggleStickyMode()
	LibStickyFrames:StickyMode(not LibStickyFrames.stickyMode)
end

function AutoBar.SetStickyMode(stickyMode)
	if (AutoBar.stickyMode ~= stickyMode) then
		AutoBar.stickyMode = stickyMode

		for i, bar in pairs(AutoBar.barList) do
			if (bar.config.enabled) then
				if (stickyMode) then
					bar:UnlockBars()
				else
					bar:LockBars()
				end
			end
		end
		if (AutoBarFuBar) then
			AutoBarFuBar:UpdateDisplay()
		end
	end
end

function AutoBar:UnlockButtons()
	self.unlockButtons = true
	for i, bar in pairs(self.barList) do
		if (bar.config.enabled) then
			bar:UnlockButtons()
		end
	end
	self:UpdateActive()
	if (AutoBarFuBar) then
		AutoBarFuBar:UpdateDisplay()
	end
end

function AutoBar:LockButtons()
	self.unlockButtons = nil
	for i, bar in pairs(self.barList) do
		if bar.config.enabled then
			bar:LockButtons()
		end
	end
	self:UpdateActive()
	if (AutoBarFuBar) then
		AutoBarFuBar:UpdateDisplay()
	end
end


--
-- Drag and Drop support
--

-- Retrieve last object dragged from
function AutoBar:GetDraggingObject()
	return AutoBar.fromObject
end

-- Record last object dragged from
function AutoBar:SetDraggingObject(fromObject)
	AutoBar.fromObject = fromObject
end


--AutoBar:Print("AutoBar:DragStop " .. tostring() .. " x/y " .. tostring() .. " / " ..tostring())
--/dump AutoBar.db.profile.bars["AutoBarClassBarBasic"].buttons[16]
--/dump AutoBar.unlockButtons
