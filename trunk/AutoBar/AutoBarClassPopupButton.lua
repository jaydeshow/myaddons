--
-- AutoBarClassPopupButton
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Popup Buttons for AutoBar
-- Popup Buttons are contained by AutoBar.Class.Button
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
-- Bound to the underlying AutoBarButton which provides its state information, icon etc.
AutoBar.Class.PopupButton = AceOO.Class()

function AutoBar.Class.PopupButton:GetPopupButton(parentButton, popupButtonIndex, popupHeader)
	local popupButtonList = popupHeader.popupButtonList
	if (popupButtonList[popupButtonIndex]) then
		popupButtonList[popupButtonIndex]:Refresh(parentButton, popupButtonIndex, popupHeader)
	else
		popupButtonList[popupButtonIndex] = AutoBar.Class.PopupButton:new(parentButton, popupButtonIndex, popupHeader)
	end

	return popupButtonList[popupButtonIndex]
end



function AutoBar.Class.PopupButton.prototype:init(parentButton, popupButtonIndex, popupHeader)
	AutoBar.Class.PopupButton.super.prototype.init(self)

	self.parentBar = parentButton.parentBar
	self.parentButton = parentButton
	self.buttonDB = parentButton.buttonDB
	self.buttonName = self.buttonDB.name
	self.popupButtonIndex = popupButtonIndex
	self.popupHeader = popupHeader
	self:CreateButtonFrame()
	self:Refresh(parentButton, popupButtonIndex, popupHeader)
end


function AutoBar.Class.PopupButton.prototype:Refresh(parentButton, popupButtonIndex, popupHeader)
end


function AutoBar.Class.PopupButton:GetFrameStrata(barKey)
	local frameStrata = AutoBar:GetDB(barKey).frameStrata
	if (frameStrata == "LOW") then
		return "MEDIUM"
	elseif (frameStrata == "MEDIUM") then
		return "HIGH"
	elseif (frameStrata == "HIGH") then
		return "DIALOG"
	end
end


-- Return the name of the global frame for this button.  Keybinds are made to this.
function AutoBar.Class.PopupButton.prototype:GetButtonFrameName(popupButtonIndex)
	return self.parentButton:GetButtonFrameName() .. "Popup" .. popupButtonIndex
end


function AutoBar.Class.PopupButton.prototype:CreateButtonFrame()
	local popupButtonIndex = self.popupButtonIndex
	local popupHeader = self.popupHeader
	local popupButtonName = self:GetButtonFrameName(popupButtonIndex)
	local popupButton = CreateFrame("CheckButton", popupButtonName, popupHeader, "ActionButtonTemplate, SecureActionButtonTemplate")
	self.frame = popupButton
--AutoBar:Print(tostring(popupHeader) .. " popupHeader ->  " .. tostring(popupButton) .. " popupButton " .. tostring(popupButtonName))

	popupButton:SetFrameStrata(AutoBar.Class.PopupButton:GetFrameStrata(self.parentBar.barKey))

	-- Hide in state 0, show in all other states
	popupButton:SetAttribute("hidestates", 0)
--	popupButton:SetAttribute("*hidestates", 0)
	-- Attach to our header
	popupHeader:SetAttribute("addchild", popupButton)

	popupButton.class = self
	popupButton:RegisterForClicks("AnyUp")

	popupButton:SetScript("OnEnter", AutoBarButton.SetTooltipOnEnter)
	popupButton:SetScript("OnLeave", AutoBarButton.SetTooltipOnLeave)
	popupButton:SetScript("PostClick", self.PostClick)

	popupButton.icon = _G[("%sIcon"):format(popupButtonName)]
	popupButton.border = _G[("%sBorder"):format(popupButtonName)]
	popupButton.cooldown = _G[("%sCooldown"):format(popupButtonName)]
	popupButton.macroName = _G[("%sName"):format(popupButtonName)]
	popupButton.hotKey = _G[("%sHotKey"):format(popupButtonName)]
	popupButton.count = _G[("%sCount"):format(popupButtonName)]
	popupButton.flash = _G[("%sFlash"):format(popupButtonName)]
	popupButton.flash:Hide()

	-- Hide the empty button outline
	local oldNT = _G[("%sNormalTexture"):format(popupButtonName)]
	oldNT:Hide()
	popupButton.normalTexture = popupButton:CreateTexture(("%sATNT"):format(popupButtonName))
	popupButton.normalTexture:SetAllPoints(oldNT)
	popupButton.normalTexture:Show()

	popupButton.pushedTexture = popupButton:GetPushedTexture()
	popupButton.highlightTexture = popupButton:GetHighlightTexture()

	popupButton.textureCache = {}
	popupButton.textureCache.pushed = popupButton.pushedTexture:GetTexture()
	popupButton.textureCache.highlight = popupButton.highlightTexture:GetTexture()

	AutoBar:RefreshStyle(popupButton, self.parentBar)
end


-- Handle a click on a popped up button
function AutoBar.Class.PopupButton.prototype:PostClick(mousebutton, down)
	local self = this.class
	AutoBarButton.dirtyPopupCount[this] = true
	AutoBarButton.dirtyPopupCooldown[this] = true
	self.frame:SetChecked(0)


	local buttonName = self.buttonName
	local buttonInfo = AutoBar.buttonList[self.buttonName]

	if (self.buttonDB.arrangeOnUse and not InCombatLockdown()) then
		local popupButtonIndex = self.popupButtonIndex
		local index
		local itemId = self.frame:GetAttribute("itemId")
		local category = self.frame:GetAttribute("category")
		local update = false
--AutoBar:Print("AutoBar.Class.PopupButton.prototype:PostClick buttonsIndex " .. buttonName .. " popupButtonIndex " .. popupButtonIndex .. " category " .. tostring(category))
		for index = # buttonInfo, 1, -1 do
--AutoBar:Print("    " .. tostring(buttonInfo[index]) .. " vs " .. tostring(category))
			if (buttonInfo[index] and buttonInfo[index] == category) then
				local slotIndexA, slotIndexB, categoryIndexA, categoryIndexB
				-- First arrange the slot categories
				local targetIndex = # buttonInfo
				local temp = buttonInfo[index]
--AutoBar:Print("AutoBar.Class.PopupButton.prototype:PostClick ??? swap index " .. index .. "  <> targetIndex " .. targetIndex)
				if (index ~= targetIndex) then
					buttonInfo[index] = buttonInfo[targetIndex]
					buttonInfo[targetIndex] = temp
					slotIndexA = index
					slotIndexB = targetIndex
					update = true
--AutoBar:Print("AutoBar.Class.PopupButton.prototype:PostClick Slot swap index " .. index .. "  <> targetIndex " .. targetIndex)
				end

--AutoBar:Print("arrangeOnUse start " .. tostring(category) .. " / " .. tostring(itemId) .. " AutoBarCategoryList[category]:GetArrangeOnUse() " .. tostring(AutoBarCategoryList[category]:GetArrangeOnUse()))
				-- Arrange the category if allowed
				local swapItemId
				if (AutoBarCategoryList[category]:GetArrangeOnUse()) then
					categoryIndexA, categoryIndexB, swapItemId = AutoBarCategoryList[category]:ArrangeOnUse(itemId)
				end

--AutoBar:Print("Rearrange " .. tostring(buttonName) .. " slotIndexA " .. tostring(slotIndexA) .. " slotIndexB " .. tostring(slotIndexB))
--AutoBar:Print("Rearrange " .. tostring(category) .. " categoryIndexA " .. tostring(categoryIndexA) .. " categoryIndexB " .. tostring(categoryIndexB))
--AutoBar:Print("Rearrange " .. tostring(itemId) .. " swapItemId " .. tostring(swapItemId))
				AutoBarSearch.items:Rearrange(buttonName, slotIndexA, slotIndexB, category, categoryIndexA, categoryIndexB)
--AutoBar:Print("Rearrange " .. tostring(category) .. " swapItemId " .. tostring(swapItemId) .. " itemId " .. tostring(itemId))
--				AutoBarSearch.items:RearrangeItems(buttonName, slotIndexA, slotIndexB, category, swapItemId, itemId)

				-- ToDo: only update the button itself
				if (update or swapItemId) then
					AutoBarButton.dirtyButton[buttonName] = true
					AutoBar.delay["UpdateScan"]:Start()
				end
				break
			end
		end
	end
end


local borderBlue = {r = 0, g = 0, b = 1.0, a = 0.75}
local borderGreen = {r = 0, g = 1.0, b = 0, a = 0.35}
-- Returns Icon texture, borderColor
-- Nil borderColor hides border
function AutoBar.Class.PopupButton.prototype:GetIconTexture()
	local frame = self.frame
	local bag = frame:GetAttribute("bag")
	local slot = frame:GetAttribute("slot")
	local itemId = frame:GetAttribute("itemId")
	local spell	= frame:GetAttribute("*spell1")
	local texture, borderColor

	if (itemId and not spell) then
		_,_,_,_,_,_,_,_,_,texture = GetItemInfo(tonumber(itemId))
	end
	if (not texture) then
		local spellName
		if (spell) then
			spellName = spell
--AutoBar:Print("AutoBar.Class.PopupButton.prototype:GetIconTexture *spell1 " .. tostring(spellName))
		else
			spellName = frame:GetAttribute("*spell2")
--AutoBar:Print("AutoBar.Class.PopupButton.prototype:GetIconTexture *spell2 " .. tostring(spellName))
		end
		if (spellName) then
			texture = LBS:GetSpellIcon(spellName)
		end
	end

	if ((not bag) and slot) then
		-- Add a green border if button is an equipped item
		borderColor = borderGreen
	elseif (spell) then
		-- Add a blue border if button is a spell
		borderColor = borderBlue
	end

--AutoBar:Print("AutoBar.Class.PopupButton.prototype:GetIconTexture texture " .. tostring(texture) .. " borderColor " .. tostring(borderColor))
	return texture, borderColor
end

function AutoBar.Class.PopupButton.prototype:UpdateIcon()
	local button = self.frame
	local texture, borderColor = self:GetIconTexture()

--AutoBar:Print("AutoBar.Class.PopupButton.prototype:UpdateIcon texture " .. tostring(texture) .. " borderColor " .. tostring(borderColor) .. " buttonName " .. tostring(self.buttonName))
	if (texture) then
		button.icon:SetTexture(texture)
		button.icon:Show()
		button.normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
		button.normalTexture:SetTexCoord(0,0,0,0)
		button.tex = texture
	else
		button.icon:Hide()
		button.cooldown:Hide()
		button.normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot")
		button.hotKey:SetVertexColor(0.6, 0.6, 0.6)
		button.normalTexture:SetTexCoord(-0.1,1.1,-0.1,1.12)
		button.tex = nil
	end

	if (borderColor) then
		button.border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
		button.border:Show()
	else
		button.border:Hide()
	end
end

-- Set count based on the *type1 settings
function AutoBar.Class.PopupButton.prototype:UpdateCount()
	local count = 0
	local itemId = self.frame:GetAttribute("itemId")
	if (itemId) then
		local itemType = self.frame:GetAttribute("*type1")

		if (itemType == "item") then
			count = GetItemCount(tonumber(itemId))
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
			count = GetActionCount(actionSlot)
		elseif (itemType == "macro") then
--			local macroText = self.frame:GetAttribute("*macrotext1")
		elseif (itemType == "spell") then
			--ToDo: Reagent based count
--			local spellName = self.frame:GetAttribute("*spell1")
		end
	end

	if (count > 1) then
		self.frame.count:SetText(count)
	else
		self.frame.count:SetText("")
	end
end

function AutoBar.Class.PopupButton.prototype:UpdateUsable()
	local itemId = self.frame:GetAttribute("itemId")
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
			self.frame.icon:SetVertexColor(0.4, 0.4, 0.4)
		end
	end
end

function AutoBar.Class.PopupButton.prototype:IsActive()
	return self.frame:GetAttribute("itemId")
end

-- Set cooldown based on the *type1 settings
function AutoBar.Class.PopupButton.prototype:UpdateCooldown()
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
			start, duration, enabled = GetSpellCooldown(spellName, BOOKTYPE_SPELL)
		end

		if (start and duration and enable and start > 0 and duration > 0) then
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enable)
		else
			CooldownFrame_SetTimer(self.frame.cooldown, 0, 0, 0)
		end
	end
end

