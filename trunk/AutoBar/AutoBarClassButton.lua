--
-- AutoBarClassButton
-- Copyright 2007+ Toadkiller of Proudmoore.
-- A lot of code borrowed from Bartender3
--
-- Layout Buttons for AutoBar
-- Buttons are contained by AutoBar.Class.Bar
-- http://code.google.com/p/autobar/
--

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 54547 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("AutoBar")
local LBS = LibStub("LibBabble-Spell-3.0")
local BS = LBS:GetLookupTable()
local _G = getfenv(0)

if not AutoBar.Class then
	AutoBar.Class = {}
end

-- Basic Button with textures, highlighting, keybindText, tooltips etc.
AutoBar.Class.Button = AceOO.Class("AceEvent-2.0", "AceHook-2.1")


function AutoBar.Class.Button:ShortenKeyBinding(text)
	text = text:gsub("CTRL--", L["|c00FF9966C|r"])
	text = text:gsub("STRG--", L["|c00CCCC00S|r"])
	text = text:gsub("ALT--", L["|c009966CCA|r"])
	text = text:gsub("SHIFT--", L["|c00CCCC00S|r"])
	text = text:gsub(L["Num Pad "], L["NP"])
	text = text:gsub(L["Mouse Button "], L["M"])
	text = text:gsub(L["Middle Mouse"], L["MM"])
	text = text:gsub(L["Backspace"], L["Bs"])
	text = text:gsub(L["Spacebar"], L["Sp"])
	text = text:gsub(L["Delete"], L["De"])
	text = text:gsub(L["Home"], L["Ho"])
	text = text:gsub(L["End"], L["En"])
	text = text:gsub(L["Insert"], L["Ins"])
	text = text:gsub(L["Page Up"], L["Pu"])
	text = text:gsub(L["Page Down"], L["Pd"])
	text = text:gsub(L["Down Arrow"], L["D"])
	text = text:gsub(L["Up Arrow"], L["U"])
	text = text:gsub(L["Left Arrow"], L["L"])
	text = text:gsub(L["Right Arrow"], L["R"])

	return text
end

local function onAttributeChangedFunc(button)
	local self = button.class
	self:UpdateButton()
end

local function onDragStartFunc(button)
	if (AutoBar.unlockButtons) then
		local fromObject = button.class
--AutoBar:Print("onDragStartFunc " .. tostring(fromObject.buttonName) .. " arg1 " .. tostring(arg1) .. " arg2 " .. tostring(arg2))
		AutoBar:SetDraggingObject(fromObject)
	end
end

local function onReceiveDragFunc(button)
	local toObject = button.class
--AutoBar:Print("onReceiveDragFunc " .. tostring(toObject.buttonName) .. " arg1 " .. tostring(arg1) .. " arg2 " .. tostring(arg2))
	toObject:DropObject()
end

local function onUpdateFunc(button, elapsed)
	local self = button.class
	self.elapsed = self.elapsed + elapsed
	if self.elapsed > 0.2 then
		self:OnUpdate(self.elapsed)
		self.elapsed = 0
	end
end

local function updateStateFunc(button, arg1, arg2, arg3)
	local self = button.class
	self:UpdateState()
--AutoBar:Print("updateStateFunc " .. tostring(self.buttonName) .. " arg1 " .. tostring(arg1) .. " arg2 " .. tostring(arg2) .. " arg3 " .. tostring(arg3))
end

function AutoBar.Class.Button.prototype:init(parentBar, buttonDB)
	AutoBar.Class.Button.super.prototype.init(self)

	self.showgrid = 0
	self.flashing = 0
	self.flashtime = 0
	self.outOfRange = false
	self.elapsed = 0
	self.action = 0

	self.parentBar = parentBar
	self.buttonDB = buttonDB
	self.buttonName = buttonDB.name
	self.buttonDBIndex = buttonDB.order
	self:CreateButtonFrame()
	self:Refresh(parentBar, buttonDB)
--AutoBar:Print("button " .. tostring(name) .. " frame " .. tostring(frame) .. " parentBar " .. tostring(self.parentBar.frame))
end

-- Refresh the category list
function AutoBar.Class.Button.prototype:Refresh(parentBar, buttonDB)
	if (buttonDB ~= self.buttonDB) then
		self.buttonDB = buttonDB
		assert(self.buttonName == buttonDB.name, "AutoBar.Class.Button.prototype:Refresh Button Name changed")
		self.buttonName = buttonDB.name
		self.buttonDBIndex = buttonDB.order
	end
	if (self.buttonDB.hasCustomCategories) then
		for categoryIndex, categoryKey in ipairs(self.buttonDB) do
			self[categoryIndex] = categoryKey
		end

		-- Clear out excess if any
		for i = # self.buttonDB + 1, # self, 1 do
			self[i] = nil
		end
	end
end


-- Disable this button
function AutoBar.Class.Button.prototype:Disable()
--	self.frame:SetAttribute("showstates", nil)
--	self.frame:SetAttribute("hidestates", "*")
--	self.frame:SetAttribute("category", nil)
--	self.frame:SetAttribute("itemId", nil)
--	self.frame:Hide()
--AutoBar:Print("AutoBar.Class.Button.prototype:Disable " .. tostring(self.buttonName))
end


-- Return the name of the global frame for this button.  Keybinds are made to this.
function AutoBar.Class.Button.prototype:GetButtonFrameName()
	return self.buttonName .. "Frame"
end

-- Update the keybinds for this Button.
-- Copied from Bartender3
-- Create Override Bindings from the Blizzard bindings to our dummy binds in Bindings.xml.
-- These do not clash with the real frames to bind to, so all is happy.
function AutoBar.Class.Button:UpdateBindings(buttonName, buttonFrameName)
	local frame = self.frame
	local key1, key2 = GetBindingKey(buttonName .. "_X")
	if (key1) then
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateBindings key1 " .. tostring(key1) .. " key2 " .. tostring(key2) .. " buttonName " .. tostring(buttonName))
		SetOverrideBindingClick(AutoBar.keyFrame, false, key1, buttonFrameName)
	end
	if (key2) then
		SetOverrideBindingClick(AutoBar.keyFrame, false, key2, buttonFrameName)
	end
end
-- /script SetOverrideBindingClick(AutoBarButtonTrinket1Frame, false, "U", "AutoBarButtonTrinket1Frame")
-- /script ClearOverrideBindings(AutoBarButtonTrinket1Frame)

-- CreateButtonFrame will NOT anchor the button, you HAVE to do that.
function AutoBar.Class.Button.prototype:CreateButtonFrame()
	local name = self:GetButtonFrameName()
	local frame = CreateFrame("CheckButton", name, self.parentBar.frame, "ActionButtonTemplate, SecureActionButtonTemplate, SecureAnchorEnterTemplate")
	self.parentBar.frame:SetAttribute("addchild", frame)
	self.frame = frame
--AutoBar:Print(tostring(self.parentBar.frame) .. " ->  " .. tostring(frame) .. " button " .. tostring(name))

	local frameStrata = AutoBar:GetDB(self.parentBar.barKey).frameStrata
	frame:SetFrameStrata(frameStrata)

	-- Support selfcast
	frame:SetAttribute("checkselfcast", true)

	frame.class = self
	frame:RegisterForClicks("AnyUp")
	frame:RegisterForDrag("LeftButton", "RightButton")

	frame:SetScript("OnUpdate", onUpdateFunc)

	frame:SetScript("OnAttributeChanged", onAttributeChangedFunc)
	frame:SetScript("OnDragStart", onDragStartFunc)
	frame:SetScript("OnReceiveDrag", onReceiveDragFunc)

	frame:SetScript("PostClick", updateStateFunc)
	frame.icon = _G[("%sIcon"):format(name)]
	frame.border = _G[("%sBorder"):format(name)]
	frame.cooldown = _G[("%sCooldown"):format(name)]
	frame.macroName = _G[("%sName"):format(name)]
	frame.hotKey = _G[("%sHotKey"):format(name)]
	frame.count = _G[("%sCount"):format(name)]
	frame.flash = _G[("%sFlash"):format(name)]
	frame.flash:Hide()

	frame:SetNormalTexture("")
	local oldNT = _G[("%sNormalTexture"):format(name)]
	oldNT:Hide()

	frame.normalTexture = frame:CreateTexture(("%sATNT"):format(name))
	frame.normalTexture:SetAllPoints(oldNT)

	frame.pushedTexture = frame:GetPushedTexture()
	frame.highlightTexture = frame:GetHighlightTexture()

	frame.textureCache = {}
	frame.textureCache.pushed = frame.pushedTexture:GetTexture()
	frame.textureCache.highlight = frame.highlightTexture:GetTexture()

	AutoBar:RefreshStyle(self.frame, self.parentBar)
--	self:UpdateBindings()
	self:UpdateButton()

	self:RegisterBarEvents()
end

local borderBlue = {r = 0, g = 0, b = 1.0, a = 0.75}
local borderGreen = {r = 0, g = 1.0, b = 0, a = 0.35}
local borderMoveActive = {r = 0, g = 1.0, b = 0, a = 1.0}
local borderMoveDisabled = {r = 1.0, g = 0, b = 0, a = 1.0}
local borderMoveEmpty = {r = 0, g = 0, b = 1.0, a = 1.0}

-- Returns Icon texture, borderColor
-- Nil borderColor hides border
function AutoBar.Class.Button.prototype:GetIconTexture()
	local frame = self.frame
	local texture, borderColor
	local itemId = frame:GetAttribute("itemId")
	local bag = frame:GetAttribute("bag")
	local slot = frame:GetAttribute("slot")
	if (itemId) then
		local itemType = self.frame:GetAttribute("*type1")

		if (itemType == "item") then
			_,_,_,_,_,_,_,_,_,texture = GetItemInfo(tonumber(itemId))
			if ((not bag) and slot) then

				-- Add a green border if button is an equipped item
				borderColor = borderGreen
			end
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
--			texture = GetActionTexture(action)
		elseif (itemType == "macro") then
--			local macroText = self.frame:GetAttribute("*macrotext1")
			texture = self.macroTexture
--AutoBar:Print("AutoBar.Class.Button.prototype:GetIconTexture texture " .. tostring(texture) .. " borderColor " .. tostring(borderColor))
		elseif (itemType == "spell") then
			local spellName = self.frame:GetAttribute("*spell1")
			texture = LBS:GetSpellIcon(spellName)

			-- Add a blue border if button is a spell
			borderColor = borderBlue
		end
	end

	local category = frame:GetAttribute("category")
	if (AutoBar.unlockButtons) then
		if (texture) then
			borderColor = borderMoveActive
		else
			if (category and AutoBarCategoryList[category]) then
				texture = AutoBarCategoryList[category].texture
				borderColor = borderMoveEmpty
	--AutoBar:Print("AutoBar.Class.Button.prototype:GetIconTexture unlockButtons category texture " .. tostring(texture))
			else
				texture = "Interface\\Icons\\INV_Misc_Gift_01"
				borderColor = borderMoveDisabled
			end
		end
	elseif ((AutoBar.db.profile.showEmptyButtons or self.buttonDB.alwaysShow) and not texture) then
		if (category) then
			texture = AutoBarCategoryList[category].texture
		end
	end

	return texture, borderColor
end

--/script AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:SetTexture("Interface\\Buttons\\UI-Quickslot2")
--/script AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QirajiCrystal_05")
--/dump AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:GetTexture()
--/script AutoBar.buttonList["AutoBarButtonTrinket1"]:UpdateIcon()

function AutoBar.Class.Button.prototype:UpdateIcon()
	local frame = self.frame
	local texture, borderColor = self:GetIconTexture()

--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateIcon texture " .. tostring(texture) .. " borderColor " .. tostring(borderColor) .. " buttonName " .. tostring(self.buttonName))
	if (texture) then
		frame.icon:SetTexture(texture)
		frame.icon:Show()
		frame.normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
		frame.normalTexture:SetTexCoord(0,0,0,0)
		frame.tex = texture
	else
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateIcon buttonName " .. tostring(self.buttonName) .. " texture " .. tostring(texture))
		frame.icon:Hide()
		frame.cooldown:Hide()
		frame.normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot")
		frame.hotKey:SetVertexColor(0.6, 0.6, 0.6)
		frame.normalTexture:SetTexCoord(-0.1,1.1,-0.1,1.12)
		frame.tex = nil
	end

	if (borderColor) then
		frame.border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
		frame.border:Show()
	else
		frame.border:Hide()
	end
end


function AutoBar.Class.Button.prototype:UpdateButton()
	local frame = self.frame
	self:UpdateIcon()
	self:UpdateCount()
	self:UpdateHotkeys()
--	AutoBar:RefreshStyle(self.frame, self.parentBar)
	local itemId = self.frame:GetAttribute("itemId")
	if (AutoBar.unlockButtons) then
		self:UnregisterButtonEvents()
		self:ShowButton()
	elseif (itemId) then
		self:RegisterButtonEvents()
		self:UpdateState()
		self:UpdateUsable()
		self:UpdateCooldown()
		self:ShowButton()
		self.frame:SetScript("OnUpdate", onUpdateFunc)
	else
		self.frame:SetScript("OnUpdate", nil)
		self:UnregisterButtonEvents()

		if (self.showgrid == 0 and not self.parentBar.config.showGrid) then
			frame.normalTexture:Hide()
			if frame.overlay then
				frame.overlay:Hide()
			end
		else
			frame.normalTexture:Show()
			if frame.overlay then
				frame.overlay:Show()
			end
		end
		frame.cooldown:Hide()
		self:HideButton()
	end

	if (AutoBar.unlockButtons) then
		frame.macroName:SetText(AutoBarButton:GetDisplayName(self.buttonDB))
--	elseif self.parentBar.config.showMacrotext then
--		frame.macroName:SetText(GetActionText(self.action))
	else
		frame.macroName:SetText("")
	end
end

function AutoBar.Class.Button.prototype:UpdateHotkeys()
	if (AutoBar.db.profile.showHotkey) then
		self.frame.hotKey:Show()
	else
		self.frame.hotKey:Hide()
	end

	local frame = self.frame
	local key1, key2 = GetBindingKey(self.buttonName .. "_X")
	local key = key1 or key2
	if (key) then
		frame.hotKey:SetText(AutoBar.Class.Button:ShortenKeyBinding(GetBindingText(key, "KEY_", 1)))
	end
----	local itemId = self.frame:GetAttribute("itemId")
----	local spell	= self.frame:GetAttribute("*spell1")
--	local hotKey = self.frame.hotKey
----	local oor = AutoBar.db.profile.outOfRange or "none"
--	local key1, key2 = GetBindingKey(self.buttonName)
--	local key = key1 or key2
----	if ( GetBindingText(key, "KEY_", 1) == "" or not self.parentBar.config.showHotkey or not HasAction(self.action) ) then
----		if ( HasAction(self.action) and oor == "hotKey" and ActionHasRange(self.action) ) then
----			hotKey:SetText(RANGE_INDICATOR)
----		else
----			hotKey:SetText("")
----		end
----	else
--		hotKey:SetText(ShortenKeyBinding(GetBindingText(key, "KEY_", 1)))
----	end
end

-- Set count based on the *type1 settings
function AutoBar.Class.Button.prototype:UpdateCount()
	if (AutoBar.db.profile.showCount) then
		self.frame.count:Show()
		local count = 0
		local itemId = self.frame:GetAttribute("itemId")
		if (itemId) then
			local itemType = self.frame:GetAttribute("*type1")

			if (itemType == "item") then
				count = GetItemCount(tonumber(itemId))
			elseif (itemType == "action") then
				local action = self.frame:GetAttribute("*action1")
				count = GetActionCount(action)
			elseif (itemType == "macro") then
	--			local macroText = self.frame:GetAttribute("*macrotext1")
			elseif (itemType == "spell") then
				--ToDo: Reagent based count
	--			local spellName = self.frame:GetAttribute("*spell1")
			end

			local popupHeader = self.frame.popupHeader
			if (popupHeader) then
				for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
					popupButton:UpdateCount()
				end
			end
		end

		if (count > 1) then
			self.frame.count:SetText(count)
		else
			self.frame.count:SetText("")
		end
	else
		self.frame.count:Hide()
	end
end

function AutoBar.Class.Button.prototype:UpdateState()
	self.frame:SetChecked(0)
end

function AutoBar.Class.Button.prototype:UpdateUsable()
	local itemId = self.frame:GetAttribute("itemId")
	local category = self.frame:GetAttribute("category")
	if (itemId) then
		local itemType = self.frame:GetAttribute("*type1")
		local isUsable, notEnoughMana

		if (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
			isUsable, notEnoughMana = IsUsableAction(action)
		elseif (itemType == "spell") then
			local spellName = self.frame:GetAttribute("*spell1")
			isUsable, notEnoughMana = IsUsableSpell(spellName)
		else
			self.frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			self.frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
			return
		end

		local oor = AutoBar.db.profile.outOfRange or "none"
		if (isUsable and (not self.outOfRange or not (oor ~= "none"))) then
			self.frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			self.frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
		elseif ((oor ~= "none") and self.outOfRange) then
			if oor == "button" then
				self.frame.icon:SetVertexColor(0.8, 0.1, 0.1)
				self.frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
			else
				self.frame.hotKey:SetVertexColor(0.8, 0.1, 0.1)
				self.frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			end
		elseif ((oor ~= "none") and notEnoughMana) then
			self.frame.icon:SetVertexColor(0.1, 0.3, 1.0)
		else
			self.frame.icon:SetVertexColor(0.3, 0.3, 0.3)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateUsable()
			end
		end
	elseif (category and (AutoBar.unlockButtons or AutoBar.db.profile.showEmptyButtons or self.buttonDB.alwaysShow)) then
		self.frame.icon:SetVertexColor(0.4, 0.4, 0.4, 1)
	end
end


function AutoBar.Class.Button.prototype:IsActive()
	if (not self.buttonDB.enabled) then
		return false
	end
	if (AutoBar.db.profile.showEmptyButtons or AutoBar.unlockButtons or self.buttonDB.alwaysShow or not self.parentBar.config.collapseButtons) then
		return true
	end
	local itemId = self.frame:GetAttribute("itemId")
	if (itemId) then
--AutoBar:Print("AutoBar.Class.Button.prototype:IsActive itemId " .. tostring(itemId))
		local category = self.frame:GetAttribute("category")
		local categoryInfo = AutoBarCategoryList[category]
		if (categoryInfo and categoryInfo.battleground and not AutoBar.inBG) then
			return false
		end

		local itemType = self.frame:GetAttribute("*type1")
		local count = 0

		if (itemType == "item") then
			count = GetItemCount(tonumber(itemId))
			if (count == 0) then
				local sortedItems = AutoBarSearch.sorted:GetList(self.buttonName)
				local noPopup = self.buttonDB.noPopup
				local nItems = # sortedItems
				if (nItems > 1 and not noPopup) then
					count = 1
--AutoBar:Print("AutoBar.Class.Button.prototype:IsActive nItems " .. tostring(nItems))
				end
				if (self.frame:GetAttribute("type2") == "spell") then
					count = 1
				end
			end
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
			count = GetActionCount(action)
		elseif (itemType == "macro") then
--AutoBar:Print("AutoBar.Class.Button.prototype:IsActive macro " .. tostring(spellName) .. " duration " .. tostring(duration))
			count = 1
		elseif (itemType == "spell") then
			--ToDo: Reagent based count
--			local spellName = self.frame:GetAttribute("*spell1")
			count = 1
		end
		return count > 0
	else
		return false
	end
end

-- Set cooldown based on the *type1 settings
function AutoBar.Class.Button.prototype:UpdateCooldown()
	local itemId = self.frame:GetAttribute("itemId")
	if (itemId and not self.parentBar.faded) then
		local itemType = self.frame:GetAttribute("*type1")
		local start, duration, enable = 0, 0, 0

		if (itemType == "item") then
			start, duration, enable = GetItemCooldown(itemId)
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
			start, duration, enable = GetActionCooldown(self.action)
		elseif (itemType == "macro") then
--			local macroText = self.frame:GetAttribute("*macrotext1")
--			start, duration, enable = GetMacroCooldown(self.action)
		elseif (itemType == "spell") then
			local spellName = self.frame:GetAttribute("*spell1")
			start, duration, enabled = GetSpellCooldown(spellName)
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateCooldown spellName " .. tostring(spellName) .. " start " .. tostring(start) .. " duration " .. tostring(duration) .. " enabled " .. tostring(enabled))
		end

		if (start and duration and enable and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- IS this necessary?
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enable)
		else
			CooldownFrame_SetTimer(self.frame.cooldown, 0, 0, 0)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCooldown()
			end
		end
	end
end
--/dump GetSpellCooldown("War Stomp", BOOKTYPE_SPELL)

local ATTACK_BUTTON_FLASH_TIME = ATTACK_BUTTON_FLASH_TIME

function AutoBar.Class.Button.prototype:OnUpdate(elapsed)
	if (not self.frame.tex) then
		self:UpdateIcon()
	end

	if ( self.flashing == 1 ) then
		self.flashtime = self.flashtime - elapsed;
		if ( self.flashtime <= 0 ) then
			local overtime = -self.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			self.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = self.frame.flash
			if ( flashTexture:IsVisible() ) then
				flashTexture:Hide()
			else
				flashTexture:Show()
			end
		end
	end

	local itemType = self.frame:GetAttribute("*type1")
	local inRange = 1
	if (itemType == "item") then
		local itemId = self.frame:GetAttribute("itemId")
		if (ItemHasRange(itemId)) then
			inRange = IsItemInRange(itemId, "target")
		end
	elseif (itemType == "action") then
		local action = self.frame:GetAttribute("*action1")
		if (ActionHasRange(action)) then
			inRange = IsActionInRange(action)
		end
	elseif (itemType == "spell") then
		local spellName = self.frame:GetAttribute("*spell1")
		if (SpellHasRange(spellName)) then
			inRange = IsSpellInRange(spellName, "target")
		end
--AutoBar:Print("AutoBar.Class.Button.prototype:OnUpdate spellName " .. tostring(spellName) .. " SpellHasRange(spellName) " .. tostring(SpellHasRange(spellName)))
	end

	local spellName = self.frame:GetAttribute("*spell1")

	if (self.outOfRange ~= (inRange == 0)) then
		self.outOfRange = not self.outOfRange
		self:UpdateUsable()
	end


	if (not self.updateTooltip) then
		return
	end

	self.updateTooltip = self.updateTooltip - elapsed
	if (self.updateTooltip > 0) then
		return
	end
end

function AutoBar.Class.Button.prototype:StartFlash()
	self.flashing = 1
	self.flashtime = 0
	self:UpdateState()
end

function AutoBar.Class.Button.prototype:StopFlash()
	self.flashing = 0
	self.frame.flash:Hide()
	self:UpdateState()
end

function AutoBar.Class.Button.prototype:ShowButton()
	local frame = self.frame
	if frame.overlay then return end

	frame.pushedTexture:SetTexture(frame.textureCache.pushed)
	frame.highlightTexture:SetTexture(frame.textureCache.highlight)
end

function AutoBar.Class.Button.prototype:HideButton()
	local frame = self.frame
	if frame.overlay then return end

	frame.pushedTexture:SetTexture("")
	frame.highlightTexture:SetTexture("")
end

function AutoBar.Class.Button.prototype:ShowGrid(override)
	local button = self.frame
	if not override then
		self.showgrid = self.showgrid + 1
	end

	button.normalTexture:Show()
	if button.overlay then
		button.overlay:Show()
	end
end

function AutoBar.Class.Button.prototype:HideGrid(override)
	local button = self.frame
	if (not override) then
		self.showgrid = self.showgrid - 1
	end
	local itemId = self.frame:GetAttribute("itemId")
	if (self.showgrid == 0 and not itemId) then
		if (not self.parentBar.config.showGrid) then
			button.normalTexture:Hide()
			if button.overlay then
				button.overlay:Hide()
			end
		end
	end
end

function AutoBar.Class.Button.prototype:UnlockButtons()
	local frame = self.frame
--	frame:SetScript("OnEnter", onEnterFunc)
--	frame:SetScript("OnLeave", onLeaveFunc)
	frame:SetScript("OnDragStart", onDragStartFunc)
	frame:SetScript("OnReceiveDrag", onReceiveDragFunc)
--	if self.buttonDB.hide then
--		frame:SetBackdropColor(1, 0, 0, 0.5)
--	else
--		frame:SetBackdropColor(0, 1, 0, 0.5)
--	end
	frame.macroName:SetText(AutoBarButton:GetDisplayName(self.buttonDB))
	frame:SetFrameLevel(3)
--	self:UpdateButton()
	frame:Show()
--	if self.config.fadeOut then
--		frame:SetAlpha(self.config.alpha)
--		self.faded = nil
--	end
end

function AutoBar.Class.Button.prototype:LockButtons()
	local frame = self.frame
--	frame:SetScript("OnEnter", nil)
--	frame:SetScript("OnLeave", nil)
	frame:SetScript("OnDragStart", nil)
	frame:SetScript("OnReceiveDrag", nil)
--	frame:SetBackdropColor(0.5, 0.5, 0.5, 0.5)
--	frame:SetBackdropBorderColor(0, 0, 0, 0)
	frame.macroName:SetText("")
	--frame:SetFrameLevel(1)
	if (self.buttonDB.hide or self.parentBar.config.hide) then
		frame:Hide()
	else
		frame:Show()
	end
--	if self.config.fadeOut then
--	end
end


function AutoBar.Class.Button.prototype:RegisterBarEvents()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED", "BaseEventHandler")
	self:RegisterEvent("UPDATE_BINDINGS", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_SHOWGRID", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_HIDEGRID", "BaseEventHandler")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "BaseEventHandler")
end

function AutoBar.Class.Button.prototype:RegisterButtonEvents()
	if self.eventsregistered then return end
	self.eventsregistered = true
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "ButtonEventHandler")
	self:RegisterEvent("PLAYER_AURAS_CHANGED", "ButtonEventHandler")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "ButtonEventHandler")
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE", "ButtonEventHandler")
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "ButtonEventHandler")
	self:RegisterEvent("ACTIONBAR_UPDATE_STATE", "ButtonEventHandler")
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS", "ButtonEventHandler")
	self:RegisterEvent("PLAYER_ENTER_COMBAT", "ButtonEventHandler")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT", "ButtonEventHandler")
	self:RegisterEvent("START_AUTOREPEAT_SPELL", "ButtonEventHandler")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL", "ButtonEventHandler")
	self:RegisterEvent("CRAFT_SHOW", "ButtonEventHandler")
	self:RegisterEvent("CRAFT_CLOSE", "ButtonEventHandler")
	self:RegisterEvent("TRADE_SKILL_SHOW", "ButtonEventHandler")
	self:RegisterEvent("TRADE_SKILL_CLOSE", "ButtonEventHandler")
end

function AutoBar.Class.Button.prototype:UnregisterButtonEvents()
	if not self.eventsregistered then return end
	self.eventsregistered = nil
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent("PLAYER_AURAS_CHANGED")
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	self:UnregisterEvent("ACTIONBAR_UPDATE_USABLE")
	self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	self:UnregisterEvent("ACTIONBAR_UPDATE_STATE")
	self:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
	self:UnregisterEvent("PLAYER_ENTER_COMBAT")
	self:UnregisterEvent("PLAYER_LEAVE_COMBAT")
	self:UnregisterEvent("START_AUTOREPEAT_SPELL")
	self:UnregisterEvent("STOP_AUTOREPEAT_SPELL")
	self:UnregisterEvent("CRAFT_SHOW")
	self:UnregisterEvent("CRAFT_CLOSE")
	self:UnregisterEvent("TRADE_SKILL_SHOW")
	self:UnregisterEvent("TRADE_SKILL_CLOSE")
end

--[[
	Following Events are always set and will always be called - i call them the base events
]]
function AutoBar.Class.Button.prototype:BaseEventHandler(e)
	if not self.parentBar.config.Enabled or self.parentBar.config.Hide then return end
	local e = event

	if ( e == "PLAYER_ENTERING_WORLD" or e == "ACTIONBAR_PAGE_CHANGED") then
		self:UpdateButton()
	elseif ( e == "ACTIONBAR_SLOT_CHANGED" ) then
		local button = arg1
		if ( button == 0 or button == self.action ) then
			self:UpdateButton()
		end
	elseif ( e == "UPDATE_BINDINGS" ) then
		self:UpdateHotkeys()
	elseif ( e == "ACTIONBAR_SHOWGRID" ) then
		self:ShowGrid()
	elseif ( e == "ACTIONBAR_HIDEGRID" ) then
		self:HideGrid()
	elseif ( e == "UPDATE_SHAPESHIFT_FORM" ) then
		self:UpdateButton()
	end
end

--[[
	Following Events are only set when the Button in question has a valid action - i call them the button events
]]
function AutoBar.Class.Button.prototype:ButtonEventHandler(e)
	if not self.parentBar.config.Enabled or self.parentBar.config.Hide then return end
	local e = event
	local actionId = self.action

	if ( event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_AURAS_CHANGED" ) then
		self:UpdateUsable()
		self:UpdateHotkeys()
	elseif ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			self:UpdateButton()
		end
	elseif ( event == "ACTIONBAR_UPDATE_USABLE" or event == "UPDATE_INVENTORY_ALERTS" or event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		self:UpdateUsable()
		self:UpdateCooldown()
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		self:UpdateState()
	elseif ( event == "ACTIONBAR_UPDATE_STATE" ) then
		self:UpdateState()
	elseif ( event == "PLAYER_ENTER_COMBAT" ) then
		if ( IsAttackAction(actionId) ) then
			self:StartFlash()
		end
	elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
		if ( IsAttackAction(actionId) ) then
			self:StopFlash()
		end
	elseif ( event == "START_AUTOREPEAT_SPELL" ) then
		if ( IsAutoRepeatAction(actionId) ) then
			self:StartFlash()
		end
	elseif ( event == "STOP_AUTOREPEAT_SPELL" ) then
		if ( self.flashing == 1 and not IsAttackAction(actionId) ) then
			self:StopFlash()
		end
	end
end




--/dump AutoBar.barList
--/script AutoBarClassBarBasicFrame:Show()
--/script AutoBar.barList["AutoBarClassBarBasic"]:UnlockFrames()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].customframe:Hide()
