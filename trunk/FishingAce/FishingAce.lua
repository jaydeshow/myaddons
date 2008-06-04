FishingAce = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceHook-2.1", "AceDB-2.0")

local L = AceLibrary("AceLocale-2.2"):new("FishingAce")

local options = {
	type='group',
	args = {
		auto = {
			type = 'toggle',
			name = L["Auto Loot"],
			desc = L["AutoLootMsg"],
			get = "IsAutoLoot",
			set = "ToggleAutoLoot",
		},
		lure = {
			type = 'toggle',
			name = L["Auto Lures"],
			desc = L["AutoLureMsg"],
			get = "IsAutoLure",
			set = "ToggleAutoLure",
		},
		sound = {
			type = 'toggle',
			name = L["Enhance Sounds"],
			desc = L["EnhanceSoundsMsg"],
			get = "IsEnhanceSounds",
			set = "ToggleEnhanceSounds",
		},
		action = {
			type = 'toggle',
			name = L["Use Action"],
			desc = L["UseActionMsg"],
			get = "IsUseAction",
			set = "ToggleUseAction",
		},
	},
}

local FISHINGLURES = {
   [34861] = {
      ["n"] = "Sharpened Fish Hook",       		  -- 100 for 10 minutes
      ["b"] = 100,
      ["s"] = 100,
      ["d"] = 10,
   },
   [6533] = {
      ["n"] = "Aquadynamic Fish Attractor",       -- 100 for 10 minutes
      ["b"] = 100,
      ["s"] = 100,
      ["d"] = 10,
   },
   [33820] = {
      ["n"] = "Weather-Beaten Fishing Hat",       -- 75 for 10 minutes
      ["b"] = 75,
      ["s"] = 1,
      ["d"] = 10,
      ["w"] = 1,
   },
   [7307] = {
      ["n"] = "Flesh Eating Worm",                -- 75 for 10 mins
      ["b"] = 75,
      ["s"] = 100,
      ["d"] = 10,
   },
   [6532] = {
      ["n"] = "Bright Baubles",                   -- 75 for 10 mins
      ["b"] = 75,
      ["s"] = 100,
      ["d"] = 10,
   },
   [6811] = {
      ["n"] = "Aquadynamic Fish Lens",            -- 50 for 10 mins
      ["b"] = 50,
      ["s"] = 50,
      ["d"] = 10,
   },
   [6530] = {
      ["n"] = "Nightcrawlers",                    -- 50 for 10 mins
      ["b"] = 50,
      ["s"] = 50,
      ["d"] = 10,
   },
   [6529] = {
      ["n"] = "Shiny Bauble",                     -- 25 for 10 mins
      ["b"] = 25,
      ["s"] = 1,
      ["d"] = 10,
   },
}

local AddingLure = false

FishingAce:RegisterDB("FishingBuddyDBPC")
FishingAce:RegisterDefaults("profile", {
	autoLoot = true,
	autoLure = false,
	enhanceSounds = true,
	useAction = false,
} )
FishingAce:RegisterChatCommand(L["Slash-Commands"], options)

local overrideOn = false
FishingAceButton = nil

local function ResetFAButton()
	if (overrideOn) then
		FishingAceButton:Hide()
		ClearOverrideBindings(FishingAceButton)
		overrideOn = false
	end
end

local function PostCastUpdate(self)
	local stop = true
	if ( not InCombatLockdown() ) then
		ResetFAButton();
		if ( AddingLure ) then
			local sp, rk, dn, ic, st, et = UnitCastingInfo("player")
			if ( not sp or (dn and dn ~= LastLure) ) then
				AddingLure = false
			else
				stop = false
			end
		end
		if ( stop ) then
			FishingAce:CancelScheduledEvent("FishingAce")
		end
	end
end

local function HideAwayAll(self, button, down)
	if ( overrideOn ) then
		FishingAce:ScheduleRepeatingEvent("FishingAce", PostCastUpdate, 1, self)
	end
end

function FishingAce:OnInitialize()
	local btn = CreateFrame("CheckButton", "CastFishingButton", UIParent, "ActionBarButtonTemplate")
	btn:SetScript("OnAttributeChanged", ActionButton_Update)
	if ShiftClickFix_ActionButton then
		ShiftClickFix_ActionButton(btn)
	end
	btn:SetPoint("LEFT", UIParent, "RIGHT", 10000, 0)
	btn:SetFrameStrata("LOW")
	btn:EnableMouse(true)
	btn:RegisterForClicks("RightButtonUp")
	btn:Hide()
	btn:SetScript("PostClick", HideAwayAll)
	FishingAceButton = btn
end

-- Something else that should be in a library
local function SplitLink(link)
	if ( link ) then
		local _,_, color, item, name = string.find(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+)|h%[(.-)%]|h|r")
		return color, item, name
	end
end

local FISHINGTEXTURE = "Interface\\Icons\\Trade_Fishing"
local FishingSpellID, FishingSpellName

-- support finding the fishing skill
local function FindSpellID(thisone)
	local id = 1
	local spellTexture = GetSpellTexture(id, BOOKTYPE_SPELL)
	while (spellTexture) do
		if (spellTexture and spellTexture == thisone) then
			return id
		end
		id = id + 1
		spellTexture = GetSpellTexture(id, BOOKTYPE_SPELL)
	end
--	return nil
end

local function GetFishingSpellID()
	if ( not FishingSpellID or not FishingSkillName) then
		FishingSpellID = FindSpellID(FISHINGTEXTURE)
	end
	if ( FishingSpellID and not FishingSkillName ) then
		FishingSkillName = GetSpellName(FishingSpellID, BOOKTYPE_SPELL)
	end
	return FishingSpellID, FishingSkillName
end

local function GetFishingActionBarID()
   local FishingActionBarID = nil
   for slot=1,72 do
      if ( HasAction(slot) and not IsAttackAction(slot) ) then
         local t,i,s = GetActionInfo(slot)
         if ( t == "spell" ) then
            local tex = GetActionTexture(slot)
            if ( tex and tex == FISHINGTEXTURE ) then
               FishingActionBarID = slot
               break
            end
         end
      end
   end
   return FishingActionBarID
end

-- get our current fishing skill level
local lastSkillIndex = nil
local function GetCurrentSkill()
	local _,skillname = GetFishingSpellID()
	if ( lastSkillIndex ) then
		local name, _, _, rank, _, modifier = GetSkillLineInfo(lastSkillIndex)
		if ( name == skillname )then
			return rank + modifier
		end
	end
	local n = GetNumSkillLines()
	for i=1,n do
		local name, _, _, rank, _, modifier = GetSkillLineInfo(i)
		if ( name == skillname ) then
			lastSkillIndex = i
			return rank + modifier
		end
	end
	return 0
end

local function IsFishingPole()
	-- Get the main hand item texture
	local slot = GetInventorySlotInfo("MainHandSlot")
	local itemTexture = GetInventoryItemTexture("player", slot)
	-- If there is infact an item in the main hand, and it's texture
	-- that matches the fishing pole texture, then we have a fishing pole
	if ( itemTexture and string.find(itemTexture, "INV_Fishingpole") ) then
		local link = GetInventoryItemLink("player", slot)
		local _, id, _ = SplitLink(link)
		-- Make sure it's not "Nat Pagle's Fish Terminator"
		if ( not string.find(id, "^19944") ) then
			return true
		end
	end
	return false
end

local function HijackCheck()
	if ( not InCombatLockdown() and IsFishingPole() ) then
		return true
	end
end

local function FindSpellID(thisone)
	local id = 1
	local spellTexture = GetSpellTexture(id, BOOKTYPE_SPELL)
	while (spellTexture) do
		if (spellTexture and spellTexture == thisone) then
			return id
		end
		id = id + 1
		spellTexture = GetSpellTexture(id, BOOKTYPE_SPELL)
	end
	return nil
end

local function GetBestLure()
	for id,lure in pairs(FISHINGLURES) do
		local count = GetItemCount(id)
		if ( count > 0 ) then
			lure.n = GetItemInfo(id)
			return id, lure.n
		end
	end
	-- return nil, nil
end
FishingAce.GetBestLure = GetBestLure

-- do everything we think is necessary when we start fishing
-- even if we didn't do the switch to a fishing pole
local efsv = nil
local function EnhanceFishingSounds(self, enhance)
	if ( self.db.profile.enhanceSounds ) then
		if ( enhance ) then
            local mv = tonumber(GetCVar("Sound_MasterVolume"))
            local mu = tonumber(GetCVar("Sound_MusicVolume"))
            local av = tonumber(GetCVar("Sound_AmbienceVolume"))
            local sv = tonumber(GetCVar("Sound_SFXVolume"))
            local ws = tonumber(GetCVar("MapWaterSounds"))
			if ( not efsv ) then
				-- collect the current value
				efsv = {}
                efsv["Sound_MasterVolume"] = mv
                efsv["Sound_MusicVolume"] = mu
                efsv["Sound_AmbienceVolume"] = av
                efsv["Sound_SFXVolume"] = sv
                efsv["MapWaterSounds"] = wv
				-- turn 'em off!
                SetCVar("Sound_MasterVolume", 1.0)
                SetCVar("Sound_SFXVolume", 1.0)
                SetCVar("Sound_MusicVolume", 0.0)
                SetCVar("Sound_AmbienceVolume", 0.0)
                SetCVar("MapWaterSounds", 0)
			end
		else
			if ( efsv ) then
				for setting, value in pairs(efsv) do
					SetCVar(setting, value)
				end
				efsv = nil
			end
		end
	end
end

local function StartFishingMode(self)
	if ( not self.startedFishing ) then
		-- Disable Click-to-Move if we're fishing
		if ( GetCVar("autointeract") == "1" ) then
			self.resetClickToMove = true
			SetCVar("autointeract", "0")
		end
		if ( self.db.profile.autoLoot ) then
			if ( not GetAutoLootDefault() ) then
				self.resetAutoLoot = true
				SetAutoLootDefault(true)
			end
		end
		self.startedFishing = GetTime()
		EnhanceFishingSounds(self, true)
	end
end

local function StopFishingMode(self)
	if ( self.startedFishing ) then
		EnhanceFishingSounds(self, false)
		self.startedFishing = nil
	end
	if ( self.resetClickToMove ) then
		-- Re-enable Click-to-Move if we changed it
		SetCVar("autointeract", "1")
		self.resetClickToMove = nil
	end
	if ( self.resetAutoLoot ) then
		SetAutoLootDefault(false)
		self.resetAutoLoot = nil
	end
end

local function FishingMode(self)
	if ( IsFishingPole() ) then
		StartFishingMode(self)
	else
		StopFishingMode(self)
	end
end

local ACTIONDOUBLEWAIT = 0.4
local lastClickTime = nil
local function CheckForDoubleClick()
	if ( lastClickTime ) then
		local pressTime = GetTime()
		local doubleTime = pressTime - lastClickTime
		lastClickTime = pressTime
		if ( doubleTime < ACTIONDOUBLEWAIT ) then
			return true
		end
	end
	lastClickTime = GetTime()
	return false
end

local function SetupFishing()
	if ( FishingAce.db.profile.useAction ) then
		local id = GetFishingActionBarID()
		if ( id ) then
			FishingAceButton:SetAttribute("type", "action")
			FishingAceButton:SetAttribute("action", id)
		end
	else
		local id,name = GetFishingSpellID()
		if ( name ) then
			FishingAceButton:SetAttribute("type", "spell")
			FishingAceButton:SetAttribute("spell", name)
		end
	end
	FishingAceButton:SetAttribute("item", nil)
	FishingAceButton:SetAttribute("target-slot", nil)
end

local LastLure
local function SetupLure()
	if ( not AddingLure ) then
		-- if the pole has an enchantment, we can assume it's got a lure on it (so far, anyway)
		local hmhe,_,_,_,_,_ = GetWeaponEnchantInfo()
		if ( FishingAce.db.profile.autoLure and not hmhe ) then
			local itemid, name = GetBestLure()
			if ( itemid ) then
				FishingAceButton:SetAttribute("type", "item")
				FishingAceButton:SetAttribute("item", "item:"..itemid)
				local slot = GetInventorySlotInfo("MainHandSlot")
				FishingAceButton:SetAttribute("target-slot", slot)
				FishingAceButton:SetAttribute("spell", nil)
				FishingAceButton:SetAttribute("action", nil)
				AddingLure = true
				LastLure = name
				return true
			end
		end
	end
	LastLure = nil
	return false
end

-- handle mouse up and mouse down in the WorldFrame so that we can steal
-- the hardware events to implement 'Easy Cast'
-- Thanks to the Cosmos team for figuring this one out -- I didn't realize
-- that the mouse handler in the WorldFrame got everything first!
local function WF_OnMouseDown(...)
	-- Only steal 'right clicks' (self is arg #1!)
	local button = select(2, ...)
	if ( button == "RightButton" and HijackCheck() ) then
		if ( CheckForDoubleClick() ) then
			-- We're stealing the mouse-up event, make sure we exit MouseLook
			if ( IsMouselooking() ) then
				MouselookStop()
			end
			if ( not SetupLure() ) then
				SetupFishing()
			end
			SetOverrideBindingClick(FishingAceButton, true, "BUTTON2", "FishingAceButton")
			overrideOn = true
		end
	end
end

function FishingAce:OnEnable()
	self:HookScript(WorldFrame, "OnMouseDown", WF_OnMouseDown)
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("SPELLS_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
end

function FishingAce:OnDisable()
--   self:UnRegister("FishingAce")
--   AceHook:Unhook(WorldFrame, "OnMouseDown")
--   self:UnregisterEvent("PLAYER_ENTERING_WORLD")
--   self:UnregisterEvent("PLAYER_LEAVING_WORLD")
--   self:UnregisterEvent("ITEM_LOCK_CHANGED")
--   self:UnregisterEvent("SPELLS_CHANGED")
   ResetButton()
end

function FishingAce:IsEnhanceSounds()
	return self.db.profile.enhanceSounds
end

function FishingAce:ToggleEnhanceSounds()
	self.db.profile.enhanceSounds = not self.db.profile.enhanceSounds
	EnhanceFishingSounds(self, self.db.profile.enhanceSounds)
end

function FishingAce:IsAutoLoot()
	return self.db.profile.autoLoot
end

function FishingAce:ToggleAutoLoot()
	self.db.profile.autoLoot = not self.db.profile.autoLoot
end

function FishingAce:IsAutoLure()
	return self.db.profile.autoLure
end

function FishingAce:ToggleAutoLure()
	self.db.profile.autoLure = not self.db.profile.autoLure
end

function FishingAce:IsUseAction()
	return self.db.profile.useAction
end

function FishingAce:ToggleUseAction()
	self.db.profile.useAction = not self.db.profile.useAction
end

function FishingAce:SPELLS_CHANGED()
	-- Fishing might have moved, go look again
	FishingSpellID = nil
end

function FishingAce:ITEM_LOCK_CHANGED()
	FishingMode(self)
end

function FishingAce:PLAYER_REGEN_DISABLED()
   ResetFAButton();
end

function FishingAce:PLAYER_REGEN_ENABLED()
   ResetFAButton();
end

function FishingAce:PLAYER_ENTERING_WORLD()
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("SPELLS_CHANGED")
end

function FishingAce:PLAYER_LEAVING_WORLD()
	self:UnregisterEvent("ITEM_LOCK_CHANGED")
	self:UnregisterEvent("SPELLS_CHANGED")
end
