--
-- AutoBarButton
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Buttons for AutoBar
-- http://code.google.com/p/autobar/
--

local AutoBar = AutoBar
local spellNameList = AutoBar.spellNameList
local spellIconList = AutoBar.spellIconList

local REVISION = tonumber(("$Revision: 79885 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local AceOO = AceLibrary("AceOO-2.0")
local LibKeyBound = LibStub("LibKeyBound-1.0")
local L = AutoBar.locale
local _G = getfenv(0)
local _

if not AutoBar.Class then
	AutoBar.Class = {}
end

AutoBarButton = AceOO.Class(AutoBar.Class.Button)
AutoBarButton.dirtyButton = {}
AutoBarButton.dirtyPopupCount = {}
AutoBarButton.dirtyPopupCooldown = {}


function AutoBarButton.prototype:init(parentBar, buttonDB)
	AutoBarButton.super.prototype.init(self, parentBar, buttonDB)
end


-- Return the interface display name
function AutoBarButton:GetDisplayName(buttonDB)
	local name
	if (buttonDB.name) then
		name = tostring(buttonDB.name)
	else
		name = L[buttonDB.buttonKey] or L["Custom"]
	end
	return name
end


-- Handle dragging of items, macros, spells to the button
-- Handle rearranging of buttons when buttonLock is off
function AutoBarButton:AddCategoryItem(category, itemType, itemId, itemInfo)
	local categoryInfo = AutoBarCategoryList[category]
	local itemsListDB = categoryInfo.customCategoriesDB.items
	local itemIndex = # itemsListDB + 1
--AutoBar:Print("AutoBarButton.prototype:DropLink " .. tostring(categoryInfo.description) .. "itemType " .. tostring(itemType) .. " itemId " .. tostring(itemId) .. " itemInfo " .. tostring(itemInfo))
	local itemDB = {
		itemType = itemType,
		itemId = itemId,
		itemInfo = itemInfo
	}
	itemsListDB[itemIndex] = itemDB
	if (itemType == "spell") then
		local spellName, spellRank = GetSpellName(itemId, itemInfo)
		itemDB.spellName = spellName
		itemDB.spellRank = spellRank
		itemDB.spellClass = WaterfallDragLink.CLASS
	else
		itemDB.spellName = nil
		itemDB.spellRank = nil
		itemDB.spellClass = nil
	end
end


-- Handle dragging of items, macros, spells to the button
-- Handle rearranging of buttons when buttonLock is off
function AutoBarButton.prototype:DropLink(itemType, itemId, itemInfo)
	if (itemType == "item" or itemType == "spell" or itemType == "macro") then
		-- Select a Custom Category to use
		local categoryInfo, categoryKey, dropped
		for index = # self, 1, -1 do
			categoryKey = self[index]
			categoryInfo = AutoBarCategoryList[categoryKey]

			if (categoryInfo and categoryInfo.customKey) then
				AutoBarButton:AddCategoryItem(categoryKey, itemType, itemId, itemInfo)
				AutoBar:BarButtonChanged()
				dropped = true
				break
			end
		end

		-- Create a Custom Category to use
		local buttonDB = self.buttonDB
		if (not dropped and buttonDB.drop) then
			local buttonCategoryIndex = # buttonDB + 1
			local categoryKey = AutoBar:CategoryNew()
			buttonDB[buttonCategoryIndex] = categoryKey
			AutoBarButton:AddCategoryItem(categoryKey, itemType, itemId, itemInfo)
			AutoBar:BarButtonChanged()
		end
	end
end


-- Handle dragging of items, macros, spells to the button
-- Handle rearranging of buttons when buttonLock is off
function AutoBarButton.prototype:DropObject()
	local toObject = self
	local fromObject = AutoBar:GetDraggingObject()
	local refreshNeeded
--AutoBar:Print("AutoBarButton.prototype:DropObject " .. tostring(fromObject and fromObject.buttonDB.buttonKey or "none") .. " --> " .. tostring(toObject.buttonDB.buttonKey))
	if (fromObject and fromObject ~= toObject and AutoBar.moveButtonsMode) then
		AutoBar:ButtonMove(fromObject.parentBar.barKey, fromObject.order, toObject.parentBar.barKey, toObject.order)
		AutoBar:BarButtonChanged()
		ClearCursor()
	else
		local buttonDB = toObject.buttonDB
		if (buttonDB.hasCustomCategories and AutoBar.moveButtonsMode or buttonDB.drop) then
			local itemType, itemId, itemInfo = GetCursorInfo()
			if (itemType == "item" or itemType == "spell" or itemType == "macro") then
--AutoBar:Print("AutoBarButton.prototype:DropObject itemType " .. tostring(itemType) .. " itemId " .. tostring(itemId) .. " itemInfo " .. tostring(itemInfo))
				toObject:DropLink(itemType, itemId, itemInfo)
				refreshNeeded = true
				ClearCursor()
				AutoBar:CategoriesChanged()
			end
		end
	end

	if (refreshNeeded) then
		if (fromObject) then
			fromObject:UpdateButton()
		end
	end
	AutoBar:SetDraggingObject(nil)
end


-- Set the state attributes of the button
function AutoBarButton.prototype:SetupButton()
	local buttonName = self.buttonDB.buttonKey
	local frame = self.frame

	local bag, slot, spell, itemId, macroId = AutoBarSearch.sorted:GetInfo(buttonName, 1)
	local popupHeader = frame.popupHeader

--AutoBar:Print("AutoBarButton.prototype:SetupButton buttonName " .. tostring(buttonName) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell " .. tostring(spell) .. " macroId " .. tostring(macroId))
	if ((bag or slot or spell or macroId) and self.buttonDB.enabled) then
		frame:SetAttribute("showstates", "*")
		frame:SetAttribute("hidestates", nil)
		local sortedItems = AutoBarSearch.sorted:GetList(buttonName)
		local noPopup = self.buttonDB.noPopup
		local nItems = # sortedItems
		if (nItems < 2) then
			noPopup = true
		end

		local buttonItems = AutoBarSearch.items:GetList(buttonName)
		local itemData = buttonItems[itemId]

--AutoBar:Print("AutoBarButton.prototype:SetupButton " .. tostring(buttonName) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell " .. tostring(spell) .. " noPopup " .. tostring(noPopup))
		self:SetupAttributes(self, bag, slot, spell, macroId, itemId, itemData)
		if (noPopup) then
			if (popupHeader) then
				for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
					popupButton.frame:SetAttribute("hidestates", "*")
				end
			end
		else
			frame:SetAttribute("childraise-OnEnter", true)
			frame:SetAttribute("childstate-OnEnter", "enter")
			frame:SetAttribute("childstate-OnLeave", "leave")
			frame:SetAttribute("*childraise-OnEnter", true)
			frame:SetAttribute("*childstate-OnEnter", "enter")
			frame:SetAttribute("*childstate-OnLeave", "leave")

			local showOnModifier --= self.buttonDB.showOnModifier
			local popupOnModifier --= self.buttonDB.popupOnModifier
			local alwaysPopup = self.buttonDB.alwaysPopup
			local buttonIndex = self.buttonDB.order

			-- Create the Button's Popup Header
			if (not popupHeader) then
				local name = buttonName .. "PopupHeader"
				popupHeader = CreateFrame("Frame", name, frame, "SecureStateHeaderTemplate")
				popupHeader:SetAttribute("childraise-enter", true)
				popupHeader:SetAttribute("*childraise-enter", true)
--				popupHeader:SetAttribute("state", "0")
				popupHeader:SetFrameStrata("DIALOG")
				popupHeader:SetWidth(2)
				popupHeader:SetHeight(2)
				frame:SetAttribute("anchorchild", popupHeader)
				frame.popupHeader = popupHeader
				popupHeader.popupButtonList = {}
--AutoBar:Print(tostring(frame) .. " ->  " .. tostring(popupHeader) .. " popupHeader " .. tostring(name))
--popupHeader.StateChanged = AutoBar.StateChanged
--AutoBar:Print(tostring(popupHeader) .. " ->  " .. tostring(frame) .. " popupHeader " .. tostring(buttonName .. "PopupHeader buttonIndex " .. tostring(buttonIndex)))
			end
			if (not popupOnModifier) then
				popupHeader:SetAttribute("statemap-anchor-enter", tostring(buttonIndex))
				popupHeader:SetAttribute("statemap-anchor-leave", ";") -- a nonempty statemap.  to work with the delay
				popupHeader:SetAttribute("delaystatemap-anchor-leave", tostring(buttonIndex)..":0")
				popupHeader:SetAttribute("delaytimemap-anchor-leave",  tostring(buttonIndex)..":0.01")
				popupHeader:SetAttribute("delayhovermap-anchor-leave", tostring(buttonIndex)..":true")

				popupHeader:SetAttribute("*statemap-anchor-enter", tostring(buttonIndex))
				popupHeader:SetAttribute("*statemap-anchor-leave", ";") -- a nonempty statemap.  to work with the delay
				popupHeader:SetAttribute("*delaystatemap-anchor-leave", tostring(buttonIndex)..":0")
				popupHeader:SetAttribute("*delaytimemap-anchor-leave",  tostring(buttonIndex)..":0.01")
				popupHeader:SetAttribute("*delayhovermap-anchor-leave", tostring(buttonIndex)..":true")
				if (alwaysPopup) then
					popupHeader:SetAttribute("state", tostring(buttonIndex))
				end
			else
				popupHeader:SetAttribute("hidestates", nil)
				popupHeader:SetAttribute("showstates", nil)
				popupHeader:SetAttribute(popupOnModifier .. "statemap-anchor-enter", tostring(buttonIndex))
				popupHeader:SetAttribute(popupOnModifier .. "statemap-anchor-leave", ";") -- a nonempty statemap.  to work with the delay
				popupHeader:SetAttribute(popupOnModifier .. "delaystatemap-anchor-leave", tostring(buttonIndex)..":0")
				popupHeader:SetAttribute(popupOnModifier .. "delaytimemap-anchor-leave",  tostring(buttonIndex)..":0.01")
				popupHeader:SetAttribute(popupOnModifier .. "delayhovermap-anchor-leave", tostring(buttonIndex)..":true")
			end

			local relativePoint = popupHeader
			local relativeSide, side
			local barKey = self.parentBar.barKey
			local layoutDB = AutoBar.barLayoutDBList[barKey]
			local buttonWidth = layoutDB.buttonWidth
			local buttonHeight = layoutDB.buttonHeight
			local padding = layoutDB.padding
			local popupDirection = layoutDB.popupDirection
			local paddingX, paddingY = 0, 0
			local hitRectPadding = -math.max(4, padding)
			if (popupDirection == "1") then	-- Top
				side = "BOTTOM"
				relativeSide = "TOP"
				paddingY = padding
			elseif (popupDirection == "2") then -- Left
				side = "RIGHT"
				relativeSide = "LEFT"
				paddingX = -padding
			elseif (popupDirection == "3") then -- Bottom
				side = "TOP"
				relativeSide = "BOTTOM"
				paddingY = -padding
			elseif (popupDirection == "4") then -- Right
				side = "LEFT"
				relativeSide = "RIGHT"
				paddingX = padding
			end
--			popupHeader:SetAllPoints(frame)
			popupHeader:ClearAllPoints()
			popupHeader:SetPoint(relativeSide)
--			popupHeader:SetAttribute("ofspoint", "*:" .. relativeSide)
--			popupHeader:SetAttribute("ofsrelpoint", "*:" .. side)
--			popupHeader:SetAttribute("ofsx", 0)
--			popupHeader:SetAttribute("ofsy", 0)

			for popupButtonIndex = 2, nItems, 1 do
				local popupButton = AutoBar.Class.PopupButton:GetPopupButton(self, popupButtonIndex, popupHeader)
				local popupButtonFrame = popupButton.frame

				-- Attach to edge of previous popupButtonFrame or the popupHeader

--				popupButtonFrame:SetAllPoints(relativePoint)
				popupButtonFrame:ClearAllPoints()
				popupButtonFrame:SetPoint(side, relativePoint, relativeSide, paddingX, paddingY)
				if (popupButtonIndex == 2) then
					if (popupDirection == "1") then
						popupButtonFrame:SetHitRectInsets(hitRectPadding, hitRectPadding, hitRectPadding, -padding)
					elseif (popupDirection == "2") then
						popupButtonFrame:SetHitRectInsets(hitRectPadding, -padding, hitRectPadding, hitRectPadding)
					elseif (popupDirection == "3") then
						popupButtonFrame:SetHitRectInsets(hitRectPadding, hitRectPadding, -padding, hitRectPadding)
					elseif (popupDirection == "4") then
						popupButtonFrame:SetHitRectInsets(-padding, hitRectPadding, hitRectPadding, hitRectPadding)
					end
				else
					popupButtonFrame:SetHitRectInsets(hitRectPadding, hitRectPadding, hitRectPadding, hitRectPadding)
				end
--				popupHeader:SetAttribute("ofspoint", "*:" .. relativeSide)
--				popupHeader:SetAttribute("ofsrelpoint", "*:" .. side)
--				popupHeader:SetAttribute("ofsx", 0)
--				popupHeader:SetAttribute("ofsy", 0)
				relativePoint = popupButtonFrame

				-- Support selfcast
				popupButtonFrame:SetAttribute("checkselfcast", true)

				bag, slot, spell, itemId, macroId = AutoBarSearch.sorted:GetInfo(buttonName, popupButtonIndex)
				itemData = buttonItems[itemId]
				self:SetupAttributes(popupButton, bag, slot, spell, macroId, itemId, itemData)
--AutoBar:Print("AutoBarButton.prototype:SetupButton SetUp buttonName " .. tostring(popupButton.frame:GetName()) .. " itemId ".. tostring(popupButton.frame:GetAttribute("itemId")))
				popupButton:UpdateIcon()
			end

			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				if (popupButtonIndex > nItems) then
--AutoBar:Print("AutoBarButton.prototype:SetupButton Disabling buttonName " .. tostring(popupButton.frame:GetName()) .. " itemId ".. tostring(popupButton.frame:GetAttribute("itemId")))
					popupButton.frame:SetAttribute("hidestates", "*")
					popupButton.frame:SetAttribute("showstates", nil)
				elseif (alwaysPopup) then
					popupButton.frame:SetAttribute("hidestates", nil)
					popupButton.frame:SetAttribute("showstates", "*")
--AutoBar:Print("AutoBarButton.prototype:SetupButton alwaysPopup buttonName " .. tostring(buttonName))
				else
					popupButton.frame:SetAttribute("hidestates", 0)
					popupButton.frame:SetAttribute("showstates", nil)
				end
			end
		end

	else
		frame:SetAttribute("itemId", nil)
		frame:SetAttribute("childraise-OnEnter", nil)
		frame:SetAttribute("childstate-OnEnter", nil)
		frame:SetAttribute("childstate-OnLeave", nil)
		frame:SetAttribute("*childraise-OnEnter", nil)
		frame:SetAttribute("*childstate-OnEnter", nil)
		frame:SetAttribute("*childstate-OnLeave", nil)
		frame:SetAttribute("showstates", nil)
		frame:SetAttribute("hidestates", "*")
		if (popupHeader) then
			popupHeader:SetAttribute("showstates", nil)
			popupHeader:SetAttribute("hidestates", "*")
		end

		if ((AutoBar.moveButtonsMode or AutoBar.db.account.showEmptyButtons or self.buttonDB.alwaysShow) and self.buttonDB.enabled) then
			frame:SetAttribute("showstates", "*")
			frame:SetAttribute("hidestates", nil)
			if (self[1]) then
--AutoBar:Print("AutoBarButton.prototype:SetupButton buttonName " .. tostring(self.buttonDB.buttonKey) .. " self[1] ".. tostring(self[1]))
				frame:SetAttribute("category", self[# self])
			else
				frame:SetAttribute("category", nil)
			end
		else
			frame:SetAttribute("category", nil)
		end
--AutoBar:Print("AutoBarButton.prototype:SetupButton buttonKey " .. tostring(self.buttonDB.buttonKey) .. " category ".. tostring(frame:GetAttribute("category")))
	end
end
--/dump (# AutoBarSearch.sorted:GetList("AutoBarButtonRecovery"))
--/dump (AutoBar.buttonList["AutoBarButtonTrinket1"].frame.popupHeader:GetAttribute("state"))
--/script (AutoBar.buttonList["AutoBarButtonTrinket1"].frame.popupHeader:SetAttribute("state", 0))
--/dump (AutoBar.buttonList["AutoBarButtonRecovery"].frame.popupHeader.popupButtonList[5].frame:GetAttribute("hidestates"))
--/script AutoBar.buttonList["AutoBarButtonHearth"].frame.macroName:Show()
--/script AutoBar.buttonList["AutoBarButtonHearth"].frame.macroName:SetText("???")
--/script AutoBar.buttonList["AutoBarButtonTrinket1"].frame:SetAttribute("showstates", "*")


-- Clear the state attributes of the button
function AutoBarButton:SetupAttributesClear(frame)
	frame:SetAttribute("target-slot1", nil)
	frame:SetAttribute("target-slot2", nil)
	frame:SetAttribute("target-bag2", nil)
	frame:SetAttribute("unit2", nil)
	frame:SetAttribute("*unit2", nil)
	frame:SetAttribute("*type1", nil)
	frame:SetAttribute("type2", nil)
	frame:SetAttribute("*type2", nil)
	frame:SetAttribute("*item1", nil)
	frame:SetAttribute("item2", nil)
	frame:SetAttribute("*item2", nil)
	frame:SetAttribute("*spell1", nil)
	frame:SetAttribute("spell2", nil)
	frame:SetAttribute("*spell2", nil)
	frame:SetAttribute("*bag1", nil)
	frame:SetAttribute("*slot1", nil)
	frame:SetAttribute("bag2", nil)
	frame:SetAttribute("*bag2", nil)
	frame:SetAttribute("slot2", nil)
	frame:SetAttribute("*slot2", nil)
	frame:SetAttribute("macroId", nil)
	frame:SetAttribute("*macro1", nil)
	frame:SetAttribute("*macro2", nil)
	frame:SetAttribute("*macrotext1", nil)
	frame:SetAttribute("*macrotext2", nil)
	frame:SetAttribute("macroName", nil)
end

local spellHealingTouch, spellHealingTouchIcon
spellHealingTouch, _, spellHealingTouchIcon = GetSpellInfo(5185)

local spellNaturesSwiftness
spellNameList["Nature's Swiftness"], _, spellIconList["Nature's Swiftness"] = GetSpellInfo(17116)

local spellRegrowth, spellRegrowthIcon
spellRegrowth, _, spellRegrowthIcon = GetSpellInfo(8936)

local SPELL_FEED_PET = GetSpellInfo(6991) -- Feed Pet
local SPELL_PICK_LOCK = GetSpellInfo(1804) -- Pick Lock
local SPELL_PROWL = GetSpellInfo(5215)

local TRINKET1_SLOT = 13
local TRINKET2_SLOT = 14

-- Set the state attributes of the button
function AutoBarButton.prototype:SetupAttributes(button, bag, slot, spell, macroId, itemId, itemData)
	local frame = button.frame
	AutoBarButton:SetupAttributesClear(frame)

	local enabled = true
	frame.needsTooltip = true
	local buttonName = self.buttonDB.buttonKey
	local category = itemData and itemData.category

	frame:SetAttribute("category", category)

	local targeted, castSpell, itemsRightClick
	local buttonDB = self.buttonDB	-- Use base button info for popups as well
	local selfCastRightClick = AutoBar.db.account.selfCastRightClick

	-- Set up special conditions from Category attributes
	local categoryInfo = AutoBarCategoryList[category]
	if (categoryInfo) then
		targeted = categoryInfo.targeted

		-- Disable battleground only items outside BG
		if (categoryInfo.battleground and not AutoBar.inBG) then
			enabled = false
		end

		castSpell = categoryInfo.castSpell
		itemsRightClick = categoryInfo.itemsRightClick
	end

	if (not targeted and buttonDB.targeted) then
		targeted = buttonDB.targeted
	end

	if (targeted) then
		if (targeted == "CHEST") then
			frame:SetAttribute("target-slot1", 5)
			frame:SetAttribute("target-slot2", 5)
--AutoBar:Print("AutoBarButton.prototype:SetupAttributes CHEST " .. tostring(categoryInfo.description) .. " buttonName " .. tostring(buttonName))
		elseif (targeted == "SHIELD") then
			frame:SetAttribute("target-slot1", 17)
			frame:SetAttribute("target-slot2", 17)
		elseif (targeted == "WEAPON") then
			frame:SetAttribute("target-slot1", 16)
			frame:SetAttribute("target-slot2", 17)
		elseif (targeted == TRINKET1_SLOT) then
			frame:SetAttribute("target-slot1", TRINKET1_SLOT)
			frame:SetAttribute("target-slot2", TRINKET2_SLOT)
--AutoBar:Print("\nAutoBarButton.prototype:SetupAttributes buttonName " .. tostring(buttonName) .. " bag ".. tostring(bag) .. " slot " .. tostring(slot) .. " TRINKET1_SLOT " .. tostring(TRINKET1_SLOT))
		elseif (targeted == TRINKET2_SLOT) then
			frame:SetAttribute("target-slot1", TRINKET2_SLOT)
			frame:SetAttribute("target-slot2", TRINKET1_SLOT)
--AutoBar:Print("\nAutoBarButton.prototype:SetupAttributes buttonName " .. tostring(buttonName) .. " bag ".. tostring(bag) .. " slot " .. tostring(slot) .. " TRINKET2_SLOT " .. tostring(TRINKET2_SLOT))
		elseif (AutoBar.CLASS == "ROGUE" and targeted == "Lockpicking") then
				frame:SetAttribute("type2", "spell")
				frame:SetAttribute("spell2", SPELL_PICK_LOCK)
				frame:SetAttribute("target-bag2", bag)
				frame:SetAttribute("target-slot2", slot)
		elseif (AutoBar.CLASS == "HUNTER" and targeted == "PET") then
			-- Right Click targets pet
			if (category and strfind(category, "Consumable.Food")) then
				frame:SetAttribute("type2", "spell")
				frame:SetAttribute("spell2", SPELL_FEED_PET)
				frame:SetAttribute("target-bag2", bag)
				frame:SetAttribute("target-slot2", slot)
--AutoBar:Print("\nAutoBarButton.prototype:SetupAttributes buttonName " .. tostring(buttonName) .. " bag ".. tostring(bag) .. " slot " .. tostring(slot))
			else
				frame:SetAttribute("unit2", "pet")
				frame:SetAttribute("*unit2", "pet")
			end
		elseif (targeted) then
			-- Support selfcast-RightMouse
			if (selfCastRightClick) then
				frame:SetAttribute("unit2", "player")
				frame:SetAttribute("*unit2", "player")
			else
				frame:SetAttribute("unit2", nil)
				frame:SetAttribute("*unit2", nil)
			end
		end
	end

	if (enabled) then
		if (buttonDB) then
			-- Handle right click pet targeting for a slot
			if (buttonDB.rightClickTargetsPet) then
				if (category and strfind(category, "Consumable.Food")) then
					frame:SetAttribute("type2", "spell")
					frame:SetAttribute("spell2", SPELL_FEED_PET)
					frame:SetAttribute("target-bag2", bag)
					frame:SetAttribute("target-slot2", slot)
--AutoBar:Print("AutoBarButton.prototype:SetupAttributes buttonName " .. tostring(buttonName) .. " bag ".. tostring(bag).. " slot " .. tostring(slot))
				else
					frame:SetAttribute("unit2", "pet")
					frame:SetAttribute("*unit2", "pet")
				end
			elseif (selfCastRightClick) then
				frame:SetAttribute("unit2", "player")
				frame:SetAttribute("*unit2", "player")
			end

			if (not castSpell) then
				castSpell = buttonDB.castSpell
			end
		end

		-- The matched spell to cast on RightClick
		if (itemsRightClick and itemsRightClick[itemId]) then
			castSpell = itemsRightClick[itemId]
			selfCastRightClick = nil
--AutoBar:Print("AutoBarButton.prototype:SetupAttributes buttonName " .. buttonName .. " castSpell " .. tostring(castSpell))
		end
		-- Special spell to cast on RightClick
		if (castSpell) then
			frame:SetAttribute("type2", "spell")
			frame:SetAttribute("spell2", castSpell)
			frame:SetAttribute("*type2", "spell")
			frame:SetAttribute("*spell2", castSpell)
		end

		-- selfCastRightClick targeting
		local unit2 = frame:GetAttribute("*unit2") or frame:GetAttribute("unit2")
		if (selfCastRightClick and not unit2) then
			frame:SetAttribute("unit2", "player")
			frame:SetAttribute("*unit2", "player")
		end

		local type2 = frame:GetAttribute("*type2") or frame:GetAttribute("type2")
		frame:SetScript("OnAttributeChanged", nil)
		if (not bag and slot) then
			local itemLink = GetInventoryItemLink("player", slot)
			frame:SetAttribute("*type1", "item")
			frame:SetAttribute("*item1", itemLink)
			if (not type2) then
				frame:SetAttribute("type2", "item")
				frame:SetAttribute("item2", itemLink)
				frame:SetAttribute("*type2", "item")
				frame:SetAttribute("*item2", itemLink)
			end
--/script local usable, noMana = IsUsableItem(GetContainerItemLink(2, 4)); AutoBar:Print("usable " .. tostring(usable) .. " noMana " .. tostring(noMana))
--/script local usable, noMana = IsUsableItem("Clefthoof Ribs"); AutoBar:Print("usable " .. tostring(usable) .. " noMana " .. tostring(noMana))
		elseif (bag and slot) then
			local itemLink = GetContainerItemLink(bag, slot)
			if (buttonDB.shuffle) then
				itemLink = bag .. " " .. slot
			else
				itemLink = GetContainerItemLink(bag, slot)
			end
			frame:SetAttribute("*type1", "item")
			frame:SetAttribute("*item1", itemLink)
			if (not type2) then
				frame:SetAttribute("type2", "item")
				frame:SetAttribute("item2", itemLink)
				frame:SetAttribute("*type2", "item")
				frame:SetAttribute("*item2", itemLink)
			end
		elseif (macroId) then
			local macroInfo = AutoBarSearch.macros[macroId]
			frame:SetAttribute("*type1", "macro")
			frame:SetAttribute("*type2", "macro")
			frame:SetAttribute("macroId", macroId)
--AutoBar:Print("AutoBarButton:SetupAttributes macroId " .. tostring(macroId) .. "\n" .. tostring(macroId) .. "\n")
			if (macroInfo.macroIndex) then
				frame:SetAttribute("*macro1", macroInfo.macroIndex)
				frame:SetAttribute("*macro2", macroInfo.macroIndex)
				button.macroActive = true
--AutoBar:Print("AutoBarButton:SetupAttributes macroIndex " .. tostring(macroInfo.macroIndex) .. "\n")
			else
				frame:SetAttribute("*macrotext1", macroInfo.macroText)
				frame:SetAttribute("*macrotext2", macroInfo.macroText)
				frame:SetAttribute("macroName", macroInfo.macroName)
				button.macroActive = true
--AutoBar:Print("AutoBarButton:SetupAttributes macroText: " .. tostring(macroInfo.macroText) .. "\n")
			end
		elseif (spell) then
--AutoBar:Print("AutoBarButton:SetupAttributes spell " .. tostring(spell))
			-- Also castSpell on left click
			frame:SetAttribute("*type1", "spell")
			frame:SetAttribute("*spell1", spell)

			if (not type2) then
				frame:SetAttribute("type2", "spell")
				frame:SetAttribute("spell2", spell)
				frame:SetAttribute("*type2", "spell")
				frame:SetAttribute("*spell2", spell)
			end
		elseif (castSpell) then
			-- Also castSpell on left click if nothing else is available
			frame:SetAttribute("*type1", "spell")
			frame:SetAttribute("*spell1", castSpell)
		else
			frame:SetAttribute("*type1", nil)
			frame:SetAttribute("type2", nil)
			frame:SetAttribute("*type2", nil)
		end
	end
	if (self.buttonDB.invertButtons) then
		-- Only supports items for now (off hand buffing)
		local temp
		temp = frame:GetAttribute("target-slot1")
		frame:SetAttribute("target-slot1", frame:GetAttribute("target-slot2"))
		frame:SetAttribute("target-slot2", temp)

--AutoBar:Print("AutoBarButton.prototype:SetupAttributes invertButtons\n" .. " *type1 " .. tostring(frame:GetAttribute("*type1")) .. " *item1 " .. tostring(frame:GetAttribute("*item1")) .. " *spell1 " .. tostring(frame:GetAttribute("*spell1")) .. " target-slot1 " .. tostring(frame:GetAttribute("target-slot1")) .. " target-slot2 " .. tostring(frame:GetAttribute("target-slot2")))
	end
	frame:SetAttribute("itemId", itemId)
	if (frame.menu) then
		frame:SetAttribute("type2", "menu")
		frame:SetAttribute("*type2", "menu")
	end
end
--/dump AutoBar.buttonList["AutoBarButtonFoodPet"][1]
--/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("type2")
--/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("*type2")
--/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("spell2")
--/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("target-bag2")
--/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("target-slot2")
--/dump AutoBar.buttonList["AutoBarButtonBuff"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("target-slot1")
--/dump AutoBar.buttonList["AutoBarButtonCooldownStoneMana"].frame:GetAttribute("itemId")
--/dump AutoBar.buttonList["AutoBarButtonBuff"].frame:GetAttribute("target-slot2")

--
-- Button Update callback functions
--

function AutoBarButton:SetTooltipOnEnter(button)
	AutoBarButton.SetTooltip(this, "OnEnter")
end

function AutoBarButton:SetTooltipOnLeave(button)
	AutoBarButton.SetTooltip(this, "OnLeave")
end

function AutoBarButton:SetTooltip(button)
--AutoBar:Print("SetTooltip " .. tostring(self.needsTooltip) .. " button " .. tostring(button) .. " button " .. tostring(button) .. " showTooltip " .. tostring(AutoBar.db.account.showTooltip) .. " self.needsTooltip " .. tostring(self.needsTooltip))
	local isAutoBarButton = self.class and self.class.buttonDB

	if (isAutoBarButton and self.GetHotkey) then
		LibKeyBound:Set(self)
	end
	local noTooltip = not (AutoBar.db.account.showTooltip and self.needsTooltip or AutoBar.moveButtonsMode)
	noTooltip = noTooltip or (InCombatLockdown() and not AutoBar.db.account.showTooltipCombat) or (button == "OnLeave")
	if (noTooltip) then
		self.updateTooltip = nil
		GameTooltip:Hide()
		return
	end

	if (GetCVar("UberTooltips") == "1") then
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
	else
		local x = self:GetRight();
		if ( x >= ( GetScreenWidth() / 2 ) ) then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		end
--		GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	end

	-- Add Button or Bar name
	if (AutoBar.moveButtonsMode) then
		if (self.class and self.class.sharedLayoutDB) then
			GameTooltip:AddLine(self.class.barName)
		elseif(isAutoBarButton) then
			GameTooltip:AddLine(AutoBarButton:GetDisplayName(self.class.buttonDB))
		end
	else
		local buttonType = self:GetAttribute("*type1")

--AutoBar:Print("AutoBarButton:SetTooltip self.needsTooltip " .. tostring(self.needsTooltip).." buttonType " .. tostring(buttonType))
		if (not buttonType) then
			if (isAutoBarButton) then
--AutoBar:Print("AutoBarButton:SetTooltip 2 self.class.buttonDB " .. tostring(self.class.buttonDB))
				GameTooltip:AddLine(AutoBarButton:GetDisplayName(self.class.buttonDB))
			else
				self.updateTooltip = nil
			end
		elseif (buttonType == "item") then
			local itemLink = self:GetAttribute("*item1")
			if (itemLink) then
				local itemId = self:GetAttribute("itemId")
				local bag, slot = AutoBarSearch.found:GetItemData(itemId)
--AutoBar:Print("AutoBarButton:SetTooltip self.class.buttonDB.buttonKey " .. tostring(self.class.buttonDB.buttonKey) .. " itemId " .. tostring(itemId) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot))
				if (bag and slot) then
					GameTooltip:SetBagItem(bag, slot)
				elseif (slot) then
					GameTooltip:SetInventoryItem("player", slot)
				else
					GameTooltip:SetHyperlink(itemLink)
				end
			end
			self.updateTooltip = TOOLTIP_UPDATE_TIME
			if (AutoBar.db.account.showTooltipExtended) then
				GameTooltip_ShowCompareItem()
			end
-- /script local bag, slot = strmatch("3,4", "^(%d+)%s+(%d+)$"); AutoBar:Print("bag " .. tostring(bag).." slot " .. tostring(slot))
		elseif (buttonType == "spell") then
			local spellName = self:GetAttribute("*spell1")

			if (spellName) then
				local spellInfo = AutoBarSearch.spells[spellName]
				GameTooltip:SetSpell(spellInfo.spellId, spellInfo.spellTab)
			end
			self.updateTooltip = TOOLTIP_UPDATE_TIME
		elseif (buttonType == "macro") then
			local macroIndex = self:GetAttribute("*macro1")
			local macroName, macroText
			if (macroIndex) then
				macroName, _, macroText = GetMacroInfo(macroIndex)
			else
				macroText = self:GetAttribute("*macrotext1")
				macroName = self:GetAttribute("macroName")
			end

			GameTooltip:AddLine(macroName, 0.2, 0.8, 0.8)
			GameTooltip:AddLine(macroText, 1, 1, 1, 1)
		end

		local rightClickType = self:GetAttribute("*type2") or self:GetAttribute("type2")
		if (rightClickType == "spell") then
			local spellName = self:GetAttribute("*spell2") or self:GetAttribute("spell") or self:GetAttribute("spell2")
			if spellName then
				GameTooltip:AddLine(L["Right Click casts "] .. spellName, 1, 0.2, 1, 1)
			end
		end
	end

	GameTooltip:Show()
end

-- A nice hack for the SecureAnchorEnterTemplateThatScrewsTooltips by Tigerheart
function AutoBarButton:TooltipHackInitialize()
	-- ToDo: may as well hook for non anchor buttons?
	-- ToDo: Check that we are owned by AutoBar?
	hooksecurefunc("SecureStateAnchor_RunChild", AutoBarButton.SetTooltip)
end


-- Add your Button custom options to the optionlist
-- optionList[myCustomOptionKey]
-- Call specific SetOption<Type> methods to do the actual setting
function AutoBarButton.prototype:AddOptions(optionList, passValue)
end


-- Call specific option type methods to do the actual setting
function AutoBarButton.prototype:SetOptionBoolean(optionList, passValue, getFunc, setFunc, valueName, name, desc)
	if (not optionList[valueName]) then
		optionList[valueName] = {
			type = "toggle",
			order = 10,
			name = name,
			desc = desc,
			get = getFunc,
			set = setFunc,
			passValue = passValue,
			disabled = InCombatLockdown,
		}
	else
		optionList[valueName].passValue = passValue
		optionList[valueName].getFunc = getFunc
		optionList[valueName].setFunc = setFunc
	end
end


-- Add category to the end of the buttons list
function AutoBarButton.prototype:AddCategory(categoryName)
	for i, category in ipairs(self) do
		if (category == categoryName) then
			-- Ignore.  ToDo shuffle to end.
			return
		end
	end
	-- Add to end
	self[# self + 1] = categoryName
end

-- Delete category from the buttons list
function AutoBarButton.prototype:DeleteCategory(categoryName)
	for i, category in ipairs(self) do
		if (category == categoryName) then
			for j = i, # self do
				self[j] = self[j + 1]
				self[j + 1] = nil
			end
			return
		end
	end
end

-- Register the Macro
function AutoBarButton.prototype:AddMacro(macroText, macroTexture)
	self.macroText = macroText
	self.macroTexture = macroTexture
	local buttonKey = self.buttonDB.buttonKey
--AutoBar:Print("AutoBarButtonMacro.prototype:AddMacro RegisterMacro " .. tostring(buttonKey))
	AutoBarSearch:RegisterMacro(buttonKey, nil, L[buttonKey], macroText)
end


AutoBarButtonMacro = AceOO.Class(AutoBarButton)

function AutoBarButtonMacro.prototype:init(parentBar, buttonDB)
	AutoBarButtonMacro.super.prototype.init(self, parentBar, buttonDB)
end

-- Set the state attributes of the button
function AutoBarButtonMacro.prototype:SetupButton()
	local buttonName = self.buttonDB.buttonKey
	local frame = self.frame

	if (self.macroText and self.buttonDB.enabled) then
--AutoBar:Print("AutoBarButtonMacro.prototype:SetupButton buttonName " .. tostring(buttonName) .. " frame " .. tostring(frame))
		frame:SetAttribute("showstates", "*")

		frame:SetAttribute("childraise-OnEnter", nil)
		frame:SetAttribute("childstate-OnEnter", nil)
		frame:SetAttribute("childstate-OnLeave", nil)
		frame:SetAttribute("*childraise-OnEnter", nil)
		frame:SetAttribute("*childstate-OnEnter", nil)
		frame:SetAttribute("*childstate-OnLeave", nil)

		self:SetupAttributes(self, nil, nil, nil, self.buttonDB.buttonKey)
	else
		frame:SetAttribute("showstates", nil)
	end
end


local AutoBarButtonAura = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonAura"] = AutoBarButtonAura

function AutoBarButtonAura.prototype:init(parentBar, buttonDB)
	AutoBarButtonAura.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Aura")
end


local AutoBarButtonBandages = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBandages"] = AutoBarButtonBandages

function AutoBarButtonBandages.prototype:init(parentBar, buttonDB)
	AutoBarButtonBandages.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Bandage.Basic")
	self:AddCategory("Consumable.Bandage.Battleground.Alterac Valley")
	self:AddCategory("Consumable.Bandage.Battleground.Arathi Basin")
	self:AddCategory("Consumable.Bandage.Battleground.Warsong Gulch")
end


local AutoBarButtonBattleStandards = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBattleStandards"] = AutoBarButtonBattleStandards

function AutoBarButtonBattleStandards.prototype:init(parentBar, buttonDB)
	AutoBarButtonBattleStandards.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Battle Standard.Battleground")
	self:AddCategory("Misc.Battle Standard.Alterac Valley")
end


local AutoBarButtonBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBuff"] = AutoBarButtonBuff

function AutoBarButtonBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonBuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff.Chest")
	self:AddCategory("Consumable.Buff.Shield")
	self:AddCategory("Consumable.Buff.Other.Target")
	self:AddCategory("Consumable.Buff.Other.Self")
	self:AddCategory("Consumable.Buff Group.General.Target")
	self:AddCategory("Consumable.Buff Group.General.Self")

	-- Melee
	if (AutoBar.CLASS ~= "MAGE" and AutoBar.CLASS ~= "WARLOCK" and AutoBar.CLASS ~= "PRIEST") then
		self:AddCategory("Consumable.Buff Group.Melee.Target")
		self:AddCategory("Consumable.Buff Group.Melee.Self")
	end

	-- Mana & Spell
	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		self:AddCategory("Consumable.Buff Group.Caster.Target")
		self:AddCategory("Consumable.Buff Group.Caster.Self")
	end
end


local AutoBarButtonBuffWeapon = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBuffWeapon"] = AutoBarButtonBuffWeapon

function AutoBarButtonBuffWeapon.prototype:init(parentBar, buttonDB)
	AutoBarButtonBuffWeapon.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Weapon Buff")
	if (not buttonDB.invertButtons) then
		self:AddCategory("Spell.Buff.Weapon")
	end
end


local AutoBarButtonClassBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonClassBuff"] = AutoBarButtonClassBuff

function AutoBarButtonClassBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonClassBuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Class.Buff")
end

function AutoBarButtonClassBuff.prototype:SetupAttributes(button, bag, slot, spell, macroId, itemId, itemData)
	local selfCastRightClick = AutoBar.db.account.selfCastRightClick
	AutoBar.db.account.selfCastRightClick = nil
	AutoBarButtonClassBuff.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, itemId, itemData)
	AutoBar.db.account.selfCastRightClick = selfCastRightClick
end


local AutoBarButtonClassPet = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonClassPet"] = AutoBarButtonClassPet

function AutoBarButtonClassPet.prototype:init(parentBar, buttonDB)
	AutoBarButtonClassPet.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Class.Pet")
end


local AutoBarButtonConjure = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonConjure"] = AutoBarButtonConjure

function AutoBarButtonConjure.prototype:init(parentBar, buttonDB)
	AutoBarButtonConjure.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "MAGE") then
		self:AddCategory("Spell.Mage.Conjure Food")
		self:AddCategory("Spell.Mage.Conjure Mana Stone")
	elseif (AutoBar.CLASS == "WARLOCK") then
		self:AddCategory("Spell.Warlock.Create Firestone")
		self:AddCategory("Spell.Warlock.Create Soulstone")
		self:AddCategory("Spell.Warlock.Create Spellstone")
		self:AddCategory("Spell.Warlock.Create Healthstone")
	end
end


local AutoBarButtonCrafting = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCrafting"] = AutoBarButtonCrafting

function AutoBarButtonCrafting.prototype:init(parentBar, buttonDB)
	AutoBarButtonCrafting.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Crafting")
end


AutoBarButtonCustom = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCustom"] = AutoBarButtonCustom

function AutoBarButtonCustom.prototype:init(parentBar, buttonDB)
	AutoBarButtonCustom.super.prototype.init(self, parentBar, buttonDB)
	self.frame.SetKey = nil
end

function AutoBarButtonCustom.prototype:GetButtonBinding()
	return nil
end

function AutoBarButtonCustom.prototype:CreateButtonFrame()
	AutoBarButtonCustom.super.prototype.CreateButtonFrame(self)
	self.frame.GetActionName = nil
	self.frame.SetKey = nil
	self.frame.ClearBindings = nil
	self.frame.GetBindings = nil
end


local spellAquaticForm, spellAquaticFormIcon
spellAquaticForm, _, spellAquaticFormIcon = GetSpellInfo(1066)

spellNameList["Bear Form"], _, spellIconList["Bear Form"] = GetSpellInfo(5487)
spellNameList["Cat Form"], _, spellIconList["Cat Form"] = GetSpellInfo(768)
spellNameList["Dire Bear Form"], _, spellIconList["Dire Bear Form"] = GetSpellInfo(9634)

local spellMoonkinForm, spellMoonkinFormIcon
spellMoonkinForm, _, spellMoonkinFormIcon = GetSpellInfo(24858)

local spellTreeOfLifeForm, spellTreeOfLifeFormIcon
spellTreeOfLifeForm, _, spellTreeOfLifeFormIcon = GetSpellInfo(33891)

spellNameList["Ghost Wolf"], _, spellIconList["Ghost Wolf"] = GetSpellInfo(2645)

local shapeshift = {
--	spellAquaticForm,
--	spellNameList["Bear Form"],
--	spellNameList["Cat Form"],
--	spellNameList["Dire Bear Form"],
--	spellNameList["Flight Form"],
--	spellMoonkinForm,
--	spellNameList["Swift Flight Form"],
--	spellNameList["Travel Form"],
--	spellTreeOfLifeForm,
}
local shapeshiftIn = {}
local shapeshiftSet = {}
local formIndexList = {}
local concatList = {}
local excludeList = {}

local function ShapeshiftRefresh()
	for index in pairs(shapeshift) do
		shapeshift[index] = nil
	end
	for index in pairs(shapeshiftIn) do
		shapeshiftIn[index] = nil
	end
	for index in pairs(shapeshiftSet) do
		shapeshiftSet[index] = nil
	end
	for formName, formIndex in pairs(formIndexList) do
		formIndexList[formName] = nil
	end

	local numShapeshiftForms = GetNumShapeshiftForms()
	for index = 1, numShapeshiftForms, 1 do
		local icon, name, active, castable = GetShapeshiftFormInfo(index)
		shapeshift[name] = " [stance:" .. index .. "] " .. name .. ";"
		shapeshiftIn[name] = " [stance:" .. index .. "]"
		shapeshiftSet[name] = " [nostance:" .. index .. "] " .. name .. ";"
		formIndexList[name] = index
	end
end

local function GetCancelList(excludeList)
	ShapeshiftRefresh()
	for index in pairs(concatList) do
		concatList[index] = nil
	end

	local index = 1
	concatList[index] = "/cancelform [stance:"
	index = index + 1

	for excludeForm in pairs(excludeList) do
		formIndexList[excludeForm] = nil
	end

	local needsSlash = false

	for formName, formIndex in pairs(formIndexList) do
		if (formName and formIndex) then
			if (needsSlash) then
				concatList[index] = "/"
				index = index + 1
				concatList[index] = tostring(formIndex)
			else
				concatList[index] = tostring(formIndex)
				needsSlash = true
			end
			index = index + 1
		end
	end
	concatList[index] = "]\n/dismount [mounted]\n/cast "
	index = index + 1
	return concatList
end

local AutoBarButtonBear = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonBear"] = AutoBarButtonBear

function AutoBarButtonBear.prototype:init(parentBar, buttonDB)
	AutoBarButtonBear.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end

function AutoBarButtonBear.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonBear.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil
	if (AutoBar.CLASS == "DRUID") then
		for excludeForm in pairs(excludeList) do
			excludeList[excludeForm] = nil
		end
		excludeList[spellNameList["Dire Bear Form"]] = true
		excludeList[spellNameList["Bear Form"]] = true
		local concatList = GetCancelList(excludeList)
		local macroTexture

		if (shapeshiftSet[spellNameList["Dire Bear Form"]]) then
			concatList[# concatList + 1] = shapeshiftSet[spellNameList["Dire Bear Form"]]
			macroTexture = spellIconList["Dire Bear Form"]
			self.macroActive = true
		elseif (shapeshiftSet[spellNameList["Bear Form"]]) then
			concatList[# concatList + 1] = shapeshiftSet[spellNameList["Bear Form"]]
			macroTexture = spellIconList["Bear Form"]
			self.macroActive = true
		end

		if (self.macroActive) then
			local macroText = table.concat(concatList)
			self:AddMacro(macroText, macroTexture)
		end
	end
end

local AutoBarButtonBoomkinTree = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonBoomkinTree"] = AutoBarButtonBoomkinTree

function AutoBarButtonBoomkinTree.prototype:init(parentBar, buttonDB)
	AutoBarButtonBoomkinTree.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end

function AutoBarButtonBoomkinTree.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonBoomkinTree.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil
	if (AutoBar.CLASS == "DRUID") then
		for excludeForm in pairs(excludeList) do
			excludeList[excludeForm] = nil
		end
		excludeList[spellMoonkinForm] = true
		excludeList[spellTreeOfLifeForm] = true
		local concatList = GetCancelList(excludeList)
		local macroTexture

		if (shapeshiftSet[spellMoonkinForm]) then
			concatList[# concatList + 1] = shapeshiftSet[spellMoonkinForm]
			macroTexture = spellMoonkinFormIcon
			self.macroActive = true
		elseif (shapeshiftSet[spellTreeOfLifeForm]) then
			concatList[# concatList + 1] = shapeshiftSet[spellTreeOfLifeForm]
			macroTexture = spellTreeOfLifeFormIcon
			self.macroActive = true
		end

		if (self.macroActive) then
			local macroText = table.concat(concatList)
			self:AddMacro(macroText, macroTexture)
		end
	end
end


local AutoBarButtonCat = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonCat"] = AutoBarButtonCat

function AutoBarButtonCat.prototype:init(parentBar, buttonDB)
	AutoBarButtonCat.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end

function AutoBarButtonCat.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonCat.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil
	if (AutoBar.CLASS == "DRUID") then
		for excludeForm in pairs(excludeList) do
			excludeList[excludeForm] = nil
		end
		excludeList[spellNameList["Cat Form"]] = true
		local concatList = GetCancelList(excludeList)
		local macroTexture

		if (shapeshiftSet[spellNameList["Cat Form"]]) then
			concatList[# concatList + 1] = shapeshiftSet[spellNameList["Cat Form"]]
			macroTexture = spellIconList["Cat Form"]
			self.macroActive = true

			local macroText = table.concat(concatList)
			self:AddMacro(macroText, macroTexture)
		end
	end
end


spellNameList["Mangle (Cat)()"], _, spellIconList["Mangle (Cat)()"] = GetSpellInfo(33983)
spellNameList["Mangle (Cat)()"] = spellNameList["Mangle (Cat)()"] .. "()"

local AutoBarButtonPowerShift = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonPowerShift"] = AutoBarButtonPowerShift

function AutoBarButtonPowerShift.prototype:init(parentBar, buttonDB)
	AutoBarButtonPowerShift.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end

function AutoBarButtonPowerShift.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonPowerShift.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil
	if (AutoBar.CLASS == "DRUID") then
--[[
/run local f="Cat Form";f=GetSpellCooldown(f)>0 or UnitMana('player')>15 or not IsUsableSpell(f) or CancelPlayerBuff(f)
/cast [form] Mangle (Cat)()
/stopmacro [form]
/cast !Cat Form
--]]
		ShapeshiftRefresh()
		local macroTexture

		if (GetSpellInfo(spellNameList["Cat Form"]) and GetSpellInfo(spellNameList["Mangle (Cat)()"])) then
			concatList[1] = "/run local f=\""
			concatList[2] = spellNameList["Cat Form"]
			concatList[3] = "\";f=GetSpellCooldown(f)>0 or UnitMana('player')>15 or not IsUsableSpell(f) or CancelPlayerBuff(f)\n/cast [form] "
			concatList[4] = spellNameList["Mangle (Cat)()"]
			concatList[5] = "\n/stopmacro [form]\n"
			concatList[6] = "/cast !"
			concatList[7] = spellNameList["Cat Form"]
			concatList[8] = "\n"
			macroTexture = spellIconList["Mangle (Cat)()"]
			self.macroActive = true

			local macroText = table.concat(concatList)
--AutoBar:Print("AutoBarButtonPowerShift:Refresh " .. tostring(macroText) .. " macroTexture " .. tostring(macroTexture))
			self:AddMacro(macroText, macroTexture)
		end
	end
end


spellNameList["Feral Charge"], _, spellIconList["Feral Charge"] = GetSpellInfo(16979)
spellNameList["Shadowstep"], _, spellIconList["Shadowstep"] = GetSpellInfo(36554)
spellNameList["Charge"] = GetSpellInfo(11578)
spellNameList["Intercept"], _, spellIconList["Intercept"] = GetSpellInfo(25275)
spellNameList["Intervene"] = GetSpellInfo(3411)


local AutoBarButtonCharge = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonCharge"] = AutoBarButtonCharge

function AutoBarButtonCharge.prototype:init(parentBar, buttonDB)
	AutoBarButtonCharge.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end

function AutoBarButtonCharge.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonCharge.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil
	for index in pairs(concatList) do
		concatList[index] = nil
	end

	concatList[1] = "/cast "
	local index = 2
	local macroTexture
	if (AutoBar.CLASS == "DRUID") then
		ShapeshiftRefresh()
		if (GetSpellInfo(spellNameList["Feral Charge"])) then
			if (shapeshiftSet[spellNameList["Dire Bear Form"]]) then
				concatList[index] = shapeshiftSet[spellNameList["Dire Bear Form"]]
				concatList[index + 1] = shapeshiftIn[spellNameList["Dire Bear Form"]]
				self.macroActive = true
			elseif (shapeshiftSet[spellNameList["Bear Form"]]) then
				concatList[index] = shapeshiftSet[spellNameList["Bear Form"]]
				concatList[index + 1] = shapeshiftIn[spellNameList["Bear Form"]]
				self.macroActive = true
			end
			concatList[index + 2] = spellNameList["Feral Charge"]
			concatList[index + 3] = ";"

			macroTexture = spellIconList["Feral Charge"]
		end
	elseif (AutoBar.CLASS == "ROGUE") then
		if (GetSpellInfo(spellNameList["Shadowstep"])) then
			concatList[index] = spellNameList["Shadowstep"]

			macroTexture = spellIconList["Shadowstep"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "WARRIOR") then
		if (GetSpellInfo(spellNameList["Charge"])) then
			concatList[index] = "[nocombat,harm,nostance:1]"
			concatList[index + 1] = spellNameList["Battle Stance"]
			concatList[index + 2] = ";"
			concatList[index + 3] = "[nocombat,harm,stance:1]"
			concatList[index + 4] = spellNameList["Charge"]
			concatList[index + 5] = ";"
			self.macroActive = true
			index = index + 6
		end
		if (GetSpellInfo(spellNameList["Intercept"])) then
			concatList[index] = "[combat,harm,nostance:3]"
			concatList[index + 1] = spellNameList["Berserker Stance"]
			concatList[index + 2] = ";"
			concatList[index + 3] = "[combat,harm,stance:3]"
			concatList[index + 4] = spellNameList["Intercept"]
			concatList[index + 5] = ";"
			self.macroActive = true
			index = index + 6
		end
		if (GetSpellInfo(spellNameList["Intervene"])) then
			concatList[index] = "[nostance:2,help]"
			concatList[index + 1] = spellNameList["Defensive Stance"]
			concatList[index + 2] = ";"
			concatList[index + 3] = "[stance:2,help]"
			concatList[index + 4] = spellNameList["Intervene"]
			concatList[index + 5] = ";"
			self.macroActive = true
			index = index + 6
		end

		macroTexture = spellIconList["Intercept"]
	end
	if (self.macroActive) then
		local macroText = table.concat(concatList)
		self:AddMacro(macroText, macroTexture)
	end
end


local AutoBarButtonTravel = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonTravel"] = AutoBarButtonTravel

function AutoBarButtonTravel.prototype:init(parentBar, buttonDB)
	AutoBarButtonTravel.super.prototype.init(self, parentBar, buttonDB)

	self:Refresh(parentBar, buttonDB)
end

function AutoBarButtonTravel.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonTravel.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil
	for index in pairs(concatList) do
		concatList[index] = nil
	end

	local macroTexture
	if (AutoBar.CLASS == "DRUID") then
		for excludeForm in pairs(excludeList) do
			excludeList[excludeForm] = nil
		end
		excludeList[spellAquaticForm] = true
		excludeList[spellNameList["Cat Form"]] = true
		excludeList[spellNameList["Travel Form"]] = true
		excludeList[spellNameList["Swift Flight Form"]] = true
		excludeList[spellNameList["Flight Form"]] = true
		local concatList = GetCancelList(excludeList)

		local index = # concatList + 1
		if (shapeshift[spellAquaticForm]) then
			concatList[index] = " [swimming] "
			concatList[index+1] = spellAquaticForm
			concatList[index+2] = ";"
			index = index + 3
			self.macroActive = true
		end

		if (shapeshift[spellNameList["Cat Form"]]) then
			concatList[index] = " [indoors] "
			concatList[index+1] = spellNameList["Cat Form"]
			concatList[index+2] = ";"
			index = index + 3
			self.macroActive = true
		end

		if (shapeshift[spellNameList["Swift Flight Form"]]) then
			concatList[index] = " [flyable,nocombat] "
			concatList[index+1] = spellNameList["Swift Flight Form"]
			concatList[index+2] = ";"
			index = index + 3
			self.macroActive = true
		elseif (shapeshift[spellNameList["Flight Form"]]) then
			concatList[index] = " [flyable] "
			concatList[index+1] = spellNameList["Flight Form"]
			concatList[index+2] = ";"
			index = index + 3
			self.macroActive = true
		end

		if (shapeshiftSet[spellNameList["Travel Form"]]) then
			concatList[index] = " [outdoors] "
			concatList[index+1] = spellNameList["Travel Form"]
			index = index + 2
			self.macroActive = true
		end

		macroTexture = spellIconList["Travel Form"]
	elseif (AutoBar.CLASS == "SHAMAN") then
		if (GetSpellInfo(spellNameList["Ghost Wolf"])) then
			local index = 1
			concatList[index] = "/dismount [mounted]\n"
			concatList[index + 1] = "/cast "
			concatList[index + 2] = spellNameList["Ghost Wolf"]
			index = index + 3

			macroTexture = spellIconList["Ghost Wolf"]
			self.macroActive = true
		end
	end
	if (self.macroActive) then
		local macroText = table.concat(concatList)
		self:AddMacro(macroText, macroTexture)
	end
end


local AutoBarButtonDebuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonDebuff"] = AutoBarButtonDebuff

function AutoBarButtonDebuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonDebuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Debuff.Single")
	self:AddCategory("Spell.Debuff.Multiple")
end


local AutoBarButtonElixirBattle = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonElixirBattle"] = AutoBarButtonElixirBattle

function AutoBarButtonElixirBattle.prototype:init(parentBar, buttonDB)
	AutoBarButtonElixirBattle.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff Type.Battle")
end


local AutoBarButtonElixirGuardian = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonElixirGuardian"] = AutoBarButtonElixirGuardian

function AutoBarButtonElixirGuardian.prototype:init(parentBar, buttonDB)
	AutoBarButtonElixirGuardian.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff Type.Guardian")
end


local AutoBarButtonElixirBoth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonElixirBoth"] = AutoBarButtonElixirBoth

function AutoBarButtonElixirBoth.prototype:init(parentBar, buttonDB)
	AutoBarButtonElixirBoth.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff Type.Flask")
end


local AutoBarButtonER = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonER"] = AutoBarButtonER

function AutoBarButtonER.prototype:init(parentBar, buttonDB)
	AutoBarButtonER.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end


spellNameList["Divine Shield"], _, spellIconList["Divine Shield"] = GetSpellInfo(1020)
spellNameList["Feign Death"], _, spellIconList["Feign Death"] = GetSpellInfo(5384)
spellNameList["Healing Wave"], _, spellIconList["Healing Wave"] = GetSpellInfo(25396)
spellNameList["Ice Block"], _, spellIconList["Ice Block"] = GetSpellInfo(45438)
spellNameList["Last Stand"], _, spellIconList["Last Stand"] = GetSpellInfo(12975)
spellNameList["Power Word: Shield"], _, spellIconList["Power Word: Shield"] = GetSpellInfo(25218)
spellNameList["Vanish"], _, spellIconList["Vanish"] = GetSpellInfo(26889)

function AutoBarButtonER.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonER.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil
	for index in pairs(concatList) do
		concatList[index] = nil
	end
	local index = 1

	local macroTexture
	if (AutoBar.CLASS == "DRUID") then
		if (GetSpellInfo(spellNameList["Nature's Swiftness"])) then
			for excludeForm in pairs(excludeList) do
				excludeList[excludeForm] = nil
			end
			excludeList[spellTreeOfLifeForm] = true
			concatList = GetCancelList(excludeList)

			index = # concatList + 1

			concatList[index] = " "
			concatList[index + 1] = spellNameList["Nature's Swiftness"]
			concatList[index + 2] = "\n/cast "
			index = index + 3

			concatList[index] = "[nostance] "
			concatList[index + 1] = spellHealingTouch
			concatList[index + 2] = "; "
			concatList[index + 3] = spellRegrowth
			index = index + 4
			macroTexture = spellHealingTouchIcon
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "HUNTER") then
		if (GetSpellInfo(spellNameList["Feign Death"])) then
			concatList[index] = "/cast "
			concatList[index + 1] = spellNameList["Feign Death"]

			macroTexture = spellIconList["Feign Death"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "MAGE") then
		if (GetSpellInfo(spellNameList["Ice Block"])) then
			concatList[index] = "/cast "
			concatList[index + 1] = spellNameList["Ice Block"]

			macroTexture = spellIconList["Ice Block"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "PALADIN") then
		if (GetSpellInfo(spellNameList["Divine Shield"])) then
			concatList[index] = "/cast "
			concatList[index + 1] = spellNameList["Divine Shield"]

			macroTexture = spellIconList["Divine Shield"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "PRIEST") then
		if (GetSpellInfo(spellNameList["Power Word: Shield"])) then
			concatList[index] = "/cast "
			concatList[index + 1] = spellNameList["Power Word: Shield"]

			macroTexture = spellIconList["Power Word: Shield"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "ROGUE") then
		if (GetSpellInfo(spellNameList["Vanish"])) then
			concatList[index] = "/cast "
			concatList[index + 1] = spellNameList["Vanish"]

			macroTexture = spellIconList["Vanish"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "SHAMAN") then
		if (GetSpellInfo(spellNameList["Nature's Swiftness"])) then
			concatList[index] = "/cast "
			concatList[index + 1] = spellNameList["Nature's Swiftness"]
			concatList[index + 2] = "\n/cast "
			concatList[index + 3] = spellNameList["Healing Wave"]

			macroTexture = spellIconList["Healing Wave"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "WARRIOR") then
		if (GetSpellInfo(spellNameList["Last Stand"])) then
			concatList[index] = "/cast "
			concatList[index + 1] = spellNameList["Last Stand"]

			macroTexture = spellIconList["Last Stand"]
			self.macroActive = true
		end
	end
	if (self.macroActive) then
		local macroText = table.concat(concatList)
		self:AddMacro(macroText, macroTexture)
	end
end



local AutoBarButtonExplosive = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonExplosive"] = AutoBarButtonExplosive

function AutoBarButtonExplosive.prototype:init(parentBar, buttonDB)
	AutoBarButtonExplosive.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Explosives")
end


local AutoBarButtonFishing = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFishing"] = AutoBarButtonFishing

function AutoBarButtonFishing.prototype:init(parentBar, buttonDB)
	AutoBarButtonFishing.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Tradeskill.Tool.Fishing.Lure")
	self:AddCategory("Tradeskill.Tool.Fishing.Gear")
	self:AddCategory("Tradeskill.Tool.Fishing.Other")
	self:AddCategory("Tradeskill.Tool.Fishing.Tool")
	self:AddCategory("Spell.Fishing")
end

local AutoBarButtonFood = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFood"] = AutoBarButtonFood

function AutoBarButtonFood.prototype:init(parentBar, buttonDB)
	AutoBarButtonFood.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "MAGE" and not buttonDB.disableConjure) then
--AutoBar:Print("AutoBarButtonFood.prototype:init buttonDB.disableConjure " .. tostring(buttonDB.disableConjure))
		self:AddCategory("Consumable.Food.Conjure")
	end
	self:AddCategory("Consumable.Food.Percent.Basic")
	self:AddCategory("Consumable.Food.Edible.Basic.Non-Conjured")
	self:AddCategory("Consumable.Food.Edible.Bread.Conjured")
	self:AddCategory("Consumable.Food.Edible.Bread.Combo.Conjured")
end

local function GetDisableConjure(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).disableConjure
end

local function SetDisableConjure(table)
	local buttonDB = AutoBar:GetButtonDB(table.buttonKey)
	local self = AutoBar.buttonList[buttonKey]
	if (buttonDB.disableConjure) then
		buttonDB.disableConjure = nil
	else
		buttonDB.disableConjure = true
	end
	AutoBar:BarButtonChanged()
	AutoBar:CategoriesChanged()
end

function AutoBarButtonFood.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonFood.super.prototype.Refresh(self, parentBar, buttonDB)
	if (AutoBar.CLASS == "MAGE") then
		if (buttonDB.disableConjure) then
			self:DeleteCategory("Consumable.Food.Conjure")
			buttonDB.castSpell = nil
			AutoBarCategoryList["Consumable.Food.Edible.Bread.Conjured"]:SetCastList(nil)
		else
			self:AddCategory("Consumable.Food.Conjure")
			AutoBarCategoryList["Consumable.Food.Edible.Bread.Conjured"]:SetCastList(AutoBarCategory:FilterClass({"MAGE", spellRitualOfRefreshment, "MAGE", spellConjureFood,}))
		end
	end
end

function AutoBarButtonFood.prototype:AddOptions(optionList, passValue)
	if (AutoBar.CLASS == "MAGE") then
		self:SetOptionBoolean(optionList, passValue, GetDisableConjure, SetDisableConjure, "disableConjure", L["Disable Conjure Button"], L["Disable Conjure Button"])
	end
end


local AutoBarButtonFoodBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFoodBuff"] = AutoBarButtonFoodBuff

function AutoBarButtonFoodBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonFoodBuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Food.Buff.Stamina")
	self:AddCategory("Consumable.Food.Buff.HP Regen")
	self:AddCategory("Consumable.Food.Buff.Spirit")
	self:AddCategory("Consumable.Food.Percent.Bonus")
	self:AddCategory("Consumable.Food.Buff.Intellect")

	-- Melee
	if (AutoBar.CLASS ~= "MAGE" and AutoBar.CLASS ~= "WARLOCK" and AutoBar.CLASS ~= "PRIEST") then
		self:AddCategory("Consumable.Food.Buff.Strength")
		self:AddCategory("Consumable.Food.Buff.Agility")
		self:AddCategory("Consumable.Food.Buff.Attack Power")
	end

	-- Healing
	if (AutoBar.CLASS == "DRUID" or AutoBar.CLASS == "PALADIN" or AutoBar.CLASS == "PRIEST" or AutoBar.CLASS == "SHAMAN") then
		self:AddCategory("Consumable.Food.Buff.Healing")
	end

	-- Mana & Spell
	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		self:AddCategory("Consumable.Food.Buff.Mana Regen")
		self:AddCategory("Consumable.Food.Buff.Spell Damage")
	end

	self:AddCategory("Consumable.Food.Buff.Other")
end


local AutoBarButtonFoodCombo = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFoodCombo"] = AutoBarButtonFoodCombo

function AutoBarButtonFoodCombo.prototype:init(parentBar, buttonDB)
	AutoBarButtonFoodCombo.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Food.Combo Percent")
	self:AddCategory("Consumable.Food.Edible.Combo.Non-Conjured")
	self:AddCategory("Consumable.Food.Edible.Battleground.Arathi Basin.Basic")
	self:AddCategory("Consumable.Food.Edible.Battleground.Warsong Gulch.Basic")
	self:AddCategory("Consumable.Food.Edible.Combo.Conjured")
end


local AutoBarButtonFoodPet = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFoodPet"] = AutoBarButtonFoodPet

function AutoBarButtonFoodPet.prototype:init(parentBar, buttonDB)
	AutoBarButtonFoodPet.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "HUNTER") then
		self:AddCategory("Consumable.Food.Pet.Bread")
		self:AddCategory("Consumable.Food.Pet.Cheese")
		self:AddCategory("Consumable.Food.Pet.Fish")
		self:AddCategory("Consumable.Food.Pet.Fruit")
		self:AddCategory("Consumable.Food.Pet.Fungus")
		self:AddCategory("Consumable.Food.Pet.Meat")
		self:AddCategory("Consumable.Buff Pet")
	end

	self.rightClickTargetsPet = true
end


local AutoBarButtonFreeAction = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFreeAction"] = AutoBarButtonFreeAction

function AutoBarButtonFreeAction.prototype:init(parentBar, buttonDB)
	AutoBarButtonFreeAction.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff.Free Action")
end


local AutoBarButtonHeal = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonHeal"] = AutoBarButtonHeal

function AutoBarButtonHeal.prototype:init(parentBar, buttonDB)
	AutoBarButtonHeal.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Stone.Health.Other")
	self:AddCategory("Consumable.Cooldown.Stone.Health.Statue")
	self:AddCategory("Consumable.Cooldown.Potion.Health.Basic")
	self:AddCategory("Consumable.Cooldown.Potion.Rejuvenation")
	self:AddCategory("Consumable.Cooldown.Potion.Health.PvP")
	self:AddCategory("Consumable.Cooldown.Stone.Health.Warlock")
	self:AddCategory("Consumable.Cooldown.Potion.Health.Coilfang")
	self:AddCategory("Consumable.Cooldown.Potion.Health.Tempest Keep")
	self:AddCategory("Consumable.Cooldown.Potion.Health.Blades Edge")
end


local AutoBarButtonHearth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonHearth"] = AutoBarButtonHearth

function AutoBarButtonHearth.prototype:init(parentBar, buttonDB)
	AutoBarButtonHearth.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "DRUID" or AutoBar.CLASS == "MAGE" or AutoBar.CLASS == "SHAMAN" or AutoBar.CLASS == "WARLOCK") then
		self:AddCategory("Spell.Portals")
	end
	self:AddCategory("Misc.Hearth")
end


local AutoBarButtonMount = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonMount"] = AutoBarButtonMount

function AutoBarButtonMount.prototype:init(parentBar, buttonDB)
	AutoBarButtonMount.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Mount.Normal")
	if (AutoBar.CLASS == "DRUID" or AutoBar.CLASS == "PALADIN" or AutoBar.CLASS == "SHAMAN" or AutoBar.CLASS == "WARLOCK") then
		self:AddCategory("Misc.Mount.Summoned")
	end
	self:AddCategory("Misc.Mount.Flying")
	self:AddCategory("Misc.Mount.Ahn'Qiraj")

	local buttonData = AutoBar.db.char.buttonDataList[buttonDB.buttonKey]
	if (not buttonData) then
		buttonData = {}
		AutoBar.db.char.buttonDataList[buttonDB.buttonKey] = buttonData
	end
	buttonData.SetBest = self.SetBest
	self.flyable = -1
end

--[[
function AutoBarButtonMount.prototype:GetMountId(flyable, sortedItems, searchItems)
	local itemId, category
	for sortedIndex, sortedItemData in ipairs(sortedItems) do
		itemId = sortedItemData.itemId
		category = searchItems[itemId].category
		if (flyable) then
			if (category == "Misc.Mount.Flying") then
				return itemId
			end
			if (AutoBar.CLASS == "DRUID" and category == "Misc.Mount.Summoned") then
				if (itemId == spellNameList["Flight Form"] or itemId == spellNameList["Swift Flight Form"]) then
					return itemId
				end
			end
		else
			if (category == "Misc.Mount.Normal") then
				return itemId
			end
			if (category == "Misc.Mount.Summoned") then
				if (AutoBar.CLASS == "DRUID" and itemId ~= spellNameList["Flight Form"] and itemId ~= spellNameList["Swift Flight Form"]) then
					return itemId
				end
				return itemId
			end
		end
		categoryInfo = AutoBarCategoryList[category]
	end
end
--]]

function AutoBarButtonMount.prototype.SetBest(sorted, buttonDB, buttonData, sortedItems, searchItems)
	local stopProcessing
	local flyable = AutoBar.flyable
	local self = AutoBar.buttonList[buttonDB.buttonKey]
	if (self.flyable ~= flyable) then
		local mountId = buttonData.arrangeOnUse
--AutoBar:Print("AutoBarButtonMount.prototype.SetBest self.flyable " .. tostring(self.flyable) .. " mountId " .. tostring(mountId))
		if (mountId) then
			if (self.flyable) then
				buttonData.flyingMount = mountId
			else
				buttonData.groundMount = mountId
			end
		end
		self.flyable = flyable
		mountId = nil
		if (flyable) then
			mountId = buttonData.flyingMount
		else
			mountId = buttonData.groundMount
		end

--AutoBar:Print("AutoBarButtonMount.prototype.SetBest self.flyable " .. tostring(self.flyable) .. " -> mountId " .. tostring(mountId))
		if (mountId) then
			buttonData.arrangeOnUse = mountId
		end
	end
	return stopProcessing
end


local AutoBarButtonPets = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonPets"] = AutoBarButtonPets

function AutoBarButtonPets.prototype:init(parentBar, buttonDB)
	AutoBarButtonPets.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Minipet.Normal")
	self:AddCategory("Misc.Minipet.Snowball")
end


local AutoBarButtonPickLock = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonPickLock"] = AutoBarButtonPickLock

function AutoBarButtonPickLock.prototype:init(parentBar, buttonDB)
	AutoBarButtonPickLock.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Unlock")
	self:AddCategory("Misc.Lockboxes")
end


AutoBarButtonPlaceHolder = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonPlaceHolder"] = AutoBarButtonPlaceHolder

function AutoBarButtonPlaceHolder.prototype:init(parentBar, buttonDB)
	AutoBarButtonPlaceHolder.super.prototype.init(self, parentBar, buttonDB)
end


local AutoBarButtonQuest = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonQuest"] = AutoBarButtonQuest

function AutoBarButtonQuest.prototype:init(parentBar, buttonDB)
	AutoBarButtonQuest.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Usable.Permanent")
	self:AddCategory("Misc.Usable.StartsQuest")
	self:AddCategory("Misc.Usable.Quest")
	self:AddCategory("Misc.Usable.Replenished")
	self:AddCategory("Misc.Usable.BossItem")
end


local AutoBarButtonRecovery = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonRecovery"] = AutoBarButtonRecovery

function AutoBarButtonRecovery.prototype:init(parentBar, buttonDB)
	AutoBarButtonRecovery.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "ROGUE") then
		self:AddCategory("Consumable.Buff.Energy")
	elseif (AutoBar.CLASS == "WARRIOR") then
		self:AddCategory("Consumable.Buff.Rage")
	else
		self:AddCategory("Consumable.Cooldown.Stone.Mana.Other")
		self:AddCategory("Consumable.Cooldown.Potion.Rejuvenation")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Basic")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Pvp")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Coilfang")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Tempest Keep")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Blades Edge")
		if (AutoBar.CLASS == "MAGE") then
			self:AddCategory("Consumable.Cooldown.Stone.Mana.Mana Stone")
		end
	end
end


local AutoBarButtonRotationDrums = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonRotationDrums"] = AutoBarButtonRotationDrums

function AutoBarButtonRotationDrums.prototype:init(parentBar, buttonDB)
	AutoBarButtonRotationDrums.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end

function AutoBarButtonRotationDrums.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonRotationDrums.super.prototype.Refresh(self, parentBar, buttonDB)
	if (true) then
		local itemName,_,_,_,_,_,_,_,_,macroTexture = GetItemInfo(29529)
		if (itemName) then
			for index in pairs(concatList) do
				concatList[index] = nil
			end
			local index = 2
			local endString = L["{star}"] .. itemName .. L["{star}"]
			concatList[1] = "/use " .. itemName
			if (buttonDB.announceSay) then
				concatList[index] = "/s" .. endString
				index = index + 1
			end
			if (buttonDB.announceParty) then
				concatList[index] = "/p" .. endString
				index = index + 1
			end
			if (buttonDB.announceRaid) then
				concatList[index] = "/ra" .. endString
				index = index + 1
			end
			local startString = "/in 28 "
			endString = L["{skull}"] .. itemName .. L["{skull}"]
			if (buttonDB.announceSay) then
				concatList[index] = startString .. "/s" .. endString
				index = index + 1
			end
			if (buttonDB.announceParty) then
				concatList[index] = startString .. "/p" .. endString
				index = index + 1
			end
			if (buttonDB.announceRaid) then
				concatList[index] = startString .. "/ra" .. endString
				index = index + 1
			end
			local macroText = table.concat(concatList, "\n")
--AutoBar:Print("AutoBarButtonRotationDrums " .. tostring(macroText))
			self:AddMacro(macroText, macroTexture)
		end
	end
end

function AutoBarButtonRotationDrums.prototype:IsActive()
	if (not self.buttonDB.enabled) then
		return false
	end
	if (AutoBar.db.account.showEmptyButtons or AutoBar.moveButtonsMode or self.buttonDB.alwaysShow or not self.parentBar.sharedLayoutDB.collapseButtons) then --or AutoBar.keyBoundMode
		return true
	end
	local count = GetItemCount(29529)
	return count > 0
end

local function GetAnnounceSay(table)
	return AutoBar:GetButtonDB(table.buttonKey).announceSay
end

local function SetAnnounceSay(table)
	local buttonDB = AutoBar:GetButtonDB(table.buttonKey)
	if (buttonDB.announceSay) then
		buttonDB.announceSay = nil
	else
		buttonDB.announceSay = true
	end
	AutoBar:BarButtonChanged()
end

local function GetAnnounceParty(table)
	return AutoBar:GetButtonDB(table.buttonKey).announceParty
end

local function SetAnnounceParty(table)
	local buttonDB = AutoBar:GetButtonDB(table.buttonKey)
	if (buttonDB.announceParty) then
		buttonDB.announceParty = nil
	else
		buttonDB.announceParty = true
	end
	AutoBar:BarButtonChanged()
end

local function GetAnnounceRaid(table)
	return AutoBar:GetButtonDB(table.buttonKey).announceRaid
end

local function SetAnnounceRaid(table)
	local buttonDB = AutoBar:GetButtonDB(table.buttonKey)
	if (buttonDB.announceRaid) then
		buttonDB.announceRaid = nil
	else
		buttonDB.announceRaid = true
	end
	AutoBar:BarButtonChanged()
end

function AutoBarButtonRotationDrums.prototype:AddOptions(optionList, passValue)
--AutoBar:Print("AutoBarButtonRotationDrums.prototype:AddOptions passValue " .. tostring(passValue))
	self:SetOptionBoolean(optionList, passValue, GetAnnounceSay, SetAnnounceSay, "announceSay", L["Announce to Say"], L["Announce to Say"])
	self:SetOptionBoolean(optionList, passValue, GetAnnounceParty, SetAnnounceParty, "announceParty", L["Announce to Party"], L["Announce to Party"])
	self:SetOptionBoolean(optionList, passValue, GetAnnounceRaid, SetAnnounceRaid, "announceRaid", L["Announce to Raid"], L["Announce to Raid"])
end


local AutoBarButtonCooldownDrums = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownDrums"] = AutoBarButtonCooldownDrums

function AutoBarButtonCooldownDrums.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownDrums.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Drums")
end


local AutoBarButtonCooldownPotionCombat = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownPotionCombat"] = AutoBarButtonCooldownPotionCombat

function AutoBarButtonCooldownPotionCombat.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownPotionCombat.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Potion.Combat")
end


local AutoBarButtonCooldownStoneCombat = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownStoneCombat"] = AutoBarButtonCooldownStoneCombat

function AutoBarButtonCooldownStoneCombat.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownStoneCombat.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Stone.Combat")
end


local AutoBarButtonCooldownPotionHealth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownPotionHealth"] = AutoBarButtonCooldownPotionHealth

function AutoBarButtonCooldownPotionHealth.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownPotionHealth.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Potion.Health.Basic")
	self:AddCategory("Consumable.Cooldown.Potion.Health.PvP")
	self:AddCategory("Consumable.Cooldown.Potion.Health.Coilfang")
	self:AddCategory("Consumable.Cooldown.Potion.Health.Tempest Keep")
	self:AddCategory("Consumable.Cooldown.Potion.Health.Blades Edge")
end


local AutoBarButtonCooldownStoneHealth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownStoneHealth"] = AutoBarButtonCooldownStoneHealth

function AutoBarButtonCooldownStoneHealth.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownStoneHealth.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Stone.Health.Other")
	self:AddCategory("Consumable.Cooldown.Stone.Health.Statue")
	self:AddCategory("Consumable.Cooldown.Stone.Health.Warlock")
end


local AutoBarButtonCooldownPotionMana = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownPotionMana"] = AutoBarButtonCooldownPotionMana

function AutoBarButtonCooldownPotionMana.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownPotionMana.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "ROGUE") then
		self:AddCategory("Consumable.Buff.Energy")
	elseif (AutoBar.CLASS == "WARRIOR") then
		self:AddCategory("Consumable.Buff.Rage")
	else
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Basic")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Pvp")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Coilfang")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Tempest Keep")
		self:AddCategory("Consumable.Cooldown.Potion.Mana.Blades Edge")
	end
end


local AutoBarButtonCooldownStoneMana = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownStoneMana"] = AutoBarButtonCooldownStoneMana

function AutoBarButtonCooldownStoneMana.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownStoneMana.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		self:AddCategory("Consumable.Cooldown.Stone.Mana.Other")
		if (AutoBar.CLASS == "MAGE") then
			self:AddCategory("Consumable.Cooldown.Stone.Mana.Mana Stone")
		end
	end
end


local AutoBarButtonCooldownPotionRejuvenation = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownPotionRejuvenation"] = AutoBarButtonCooldownPotionRejuvenation

function AutoBarButtonCooldownPotionRejuvenation.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownPotionRejuvenation.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Potion.Rejuvenation")
end



local AutoBarButtonCooldownStoneRejuvenation = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownStoneRejuvenation"] = AutoBarButtonCooldownStoneRejuvenation

function AutoBarButtonCooldownStoneRejuvenation.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownStoneRejuvenation.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
--		self:AddCategory("Consumable.Cooldown.Potion.Rejuvenation")
	end
end


local AutoBarButtonSpeed = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSpeed"] = AutoBarButtonSpeed

function AutoBarButtonSpeed.prototype:init(parentBar, buttonDB)
	AutoBarButtonSpeed.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff.Speed")
end


local AutoBarButtonSpell1 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSpell1"] = AutoBarButtonSpell1

function AutoBarButtonSpell1.prototype:init(parentBar, buttonDB)
	AutoBarButtonSpell1.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "DRUID") then
	elseif (AutoBar.CLASS == "ROGUE") then
	elseif (AutoBar.CLASS == "WARRIOR") then
	elseif (AutoBar.CLASS == "MAGE") then
	end
end


local AutoBarButtonSpell2 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSpell2"] = AutoBarButtonSpell2

function AutoBarButtonSpell2.prototype:init(parentBar, buttonDB)
	AutoBarButtonSpell2.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "DRUID") then
	elseif (AutoBar.CLASS == "ROGUE") then
	elseif (AutoBar.CLASS == "WARRIOR") then
	elseif (AutoBar.CLASS == "MAGE") then
	end
end


local AutoBarButtonSpell3 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSpell3"] = AutoBarButtonSpell3

function AutoBarButtonSpell3.prototype:init(parentBar, buttonDB)
	AutoBarButtonSpell3.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "DRUID") then
	elseif (AutoBar.CLASS == "ROGUE") then
	elseif (AutoBar.CLASS == "WARRIOR") then
	elseif (AutoBar.CLASS == "MAGE") then
	end
end


local AutoBarButtonSpell4 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSpell4"] = AutoBarButtonSpell4

function AutoBarButtonSpell4.prototype:init(parentBar, buttonDB)
	AutoBarButtonSpell4.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "DRUID") then
	elseif (AutoBar.CLASS == "ROGUE") then
	elseif (AutoBar.CLASS == "WARRIOR") then
	elseif (AutoBar.CLASS == "MAGE") then
	end
end


local AutoBarButtonStance = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonStance"] = AutoBarButtonStance

function AutoBarButtonStance.prototype:init(parentBar, buttonDB)
	AutoBarButtonStance.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "WARRIOR") then
		self:AddCategory("Spell.Stance")
	end
end

function AutoBarButtonStance.prototype:GetLastUsed()
	local nStance = GetShapeshiftForm(true)
	local icon, name = GetShapeshiftFormInfo(nStance)
	return name
end


local AutoBarButtonStealth = AceOO.Class(AutoBarButtonMacro)
AutoBar.Class["AutoBarButtonStealth"] = AutoBarButtonStealth

function AutoBarButtonStealth.prototype:init(parentBar, buttonDB)
	AutoBarButtonStealth.super.prototype.init(self, parentBar, buttonDB)
	self:Refresh(parentBar, buttonDB)
end

spellNameList["Invisibility"], _, spellIconList["Invisibility"] = GetSpellInfo(66)
spellNameList["Shadowform"], _, spellIconList["Shadowform"] = GetSpellInfo(15473)
spellNameList["Shadowmeld"], _, spellIconList["Shadowmeld"] = GetSpellInfo(20580)
spellNameList["Stealth"], _, spellIconList["Stealth"] = GetSpellInfo(1787)

function AutoBarButtonStealth.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonStealth.super.prototype.Refresh(self, parentBar, buttonDB)
	self.macroActive = nil

	for index in pairs(concatList) do
		concatList[index] = nil
	end

	concatList[1] = "/cast "
	local index = 2
	local macroTexture
	if (AutoBar.CLASS == "DRUID") then
		for excludeForm in pairs(excludeList) do
			excludeList[excludeForm] = nil
		end
		excludeList[spellNameList["Cat Form"]] = true
		concatList = GetCancelList(excludeList)

		local index = # concatList + 1
		if (shapeshiftSet[spellNameList["Cat Form"]]) then
			concatList[index] = " [nostance] "
			concatList[index+1] = spellNameList["Cat Form"]
			concatList[index+2] = "; "
			concatList[index+3] = SPELL_PROWL -- [nostealth]
			index = index+4

			macroTexture = spellIconList["Cat Form"]
			self.macroActive = true
		end
	elseif (AutoBar.CLASS == "ROGUE") then
		if (GetSpellInfo(spellNameList["Stealth"])) then
			concatList[index] = spellNameList["Stealth"]

			macroTexture = spellIconList["Stealth"]
			self.macroActive = true
		end
--[[
	elseif (AutoBar.CLASS == "PRIEST") then
		if (GetSpellInfo(spellNameList["Shadowform"])) then
			concatList[index] = spellNameList["Shadowform"]

			macroTexture = spellIconList["Shadowform"]
			self.macroActive = true
		end
--]]
	elseif (AutoBar.CLASS == "MAGE") then
		if (GetSpellInfo(spellNameList["Invisibility"])) then
			concatList[index] = spellNameList["Invisibility"]

			macroTexture = spellIconList["Invisibility"]
			self.macroActive = true
		end
	else
		if (GetSpellInfo(spellNameList["Shadowmeld"])) then
			concatList[index] = spellNameList["Shadowmeld"]

			macroTexture = spellIconList["Shadowmeld"]
			self.macroActive = true
		end
	end
	if (self.macroActive) then
		local macroText = table.concat(concatList)
		self:AddMacro(macroText, macroTexture)
	end
end


local AutoBarButtonSting = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSting"] = AutoBarButtonSting

function AutoBarButtonSting.prototype:init(parentBar, buttonDB)
	AutoBarButtonSting.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Sting")
end


local totemAir = 4
local totemEarth = 2
local totemFire = 1
local totemWater = 3

local destroyMacro = {
	[totemFire] = "/run DestroyTotem(1)",
	[totemEarth] = "/run DestroyTotem(2)",
	[totemWater] = "/run DestroyTotem(3)",
	[totemAir] = "/run DestroyTotem(4)",
}
local function DestroyTotem(frame, totemType)
	frame:SetAttribute("*type2", "macro")
	frame:SetAttribute("*macrotext2", destroyMacro[totemType])
	frame:SetAttribute("type2", "macro")
	frame:SetAttribute("macrotext2", destroyMacro[totemType])
end

local AutoBarButtonTotemAir = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemAir"] = AutoBarButtonTotemAir

function AutoBarButtonTotemAir.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemAir.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Air")
end

function AutoBarButtonTotemAir.prototype:SetupAttributes(button, bag, slot, spell, macroId, itemId, itemData)
	AutoBarButtonTotemAir.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, itemId, itemData)

	DestroyTotem(self.frame, totemAir)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemAir.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("*type1")
	if (itemType and not self.parentBar.faded) then
		local start, duration, enabled = 0, 0, 1
		local totemName
		_, totemName, start, duration = GetTotemInfo(totemAir)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- IS this necessary?
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enabled)
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
-- /script CooldownFrame_SetTimer(AutoBarButtonTotemAirFrame.cooldown, 0, 0, 0)

local AutoBarButtonTotemEarth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemEarth"] = AutoBarButtonTotemEarth

function AutoBarButtonTotemEarth.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemEarth.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Earth")
end

function AutoBarButtonTotemEarth.prototype:SetupAttributes(button, bag, slot, spell, macroId, itemId, itemData)
	AutoBarButtonTotemEarth.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, itemId, itemData)

	DestroyTotem(self.frame, totemEarth)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemEarth.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("*type1")
	if (itemType and not self.parentBar.faded) then
		local start, duration, enabled = 0, 0, 1
		local totemName
		_, totemName, start, duration = GetTotemInfo(totemEarth)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- IS this necessary?
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enabled)
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


local AutoBarButtonTotemFire = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemFire"] = AutoBarButtonTotemFire

function AutoBarButtonTotemFire.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemFire.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Fire")
end

function AutoBarButtonTotemFire.prototype:SetupAttributes(button, bag, slot, spell, macroId, itemId, itemData)
	AutoBarButtonTotemFire.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, itemId, itemData)

	DestroyTotem(self.frame, totemFire)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemFire.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("*type1")
	if (itemType and not self.parentBar.faded) then
		local start, duration, enabled = 0, 0, 1
		local totemName
		_, totemName, start, duration = GetTotemInfo(totemFire)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- IS this necessary?
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enabled)
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


local AutoBarButtonTotemWater = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemWater"] = AutoBarButtonTotemWater

function AutoBarButtonTotemWater.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemWater.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Water")
end

function AutoBarButtonTotemWater.prototype:SetupAttributes(button, bag, slot, spell, macroId, itemId, itemData)
	AutoBarButtonTotemWater.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, itemId, itemData)

	DestroyTotem(self.frame, totemWater)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemWater.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("*type1")
	if (itemType and not self.parentBar.faded) then
		local start, duration, enabled = 0, 0, 1
		local totemName
		_, totemName, start, duration = GetTotemInfo(totemWater)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- IS this necessary?
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enabled)
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


local AutoBarButtonTrack = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrack"] = AutoBarButtonTrack

function AutoBarButtonTrack.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrack.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Track")
end


local AutoBarButtonTrap = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrap"] = AutoBarButtonTrap

function AutoBarButtonTrap.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrap.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Trap")
end


local AutoBarButtonTrinket1 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrinket1"] = AutoBarButtonTrinket1

function AutoBarButtonTrinket1.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrinket1.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Gear.Trinket")
	buttonDB.targeted = TRINKET1_SLOT
	buttonDB.equipped = TRINKET1_SLOT
end

function AutoBarButtonTrinket1.prototype:GetLastUsed()
	local name, itemId = AutoBar.LinkDecode(GetInventoryItemLink("player", TRINKET1_SLOT))
	return itemId
end


local AutoBarButtonTrinket2 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrinket2"] = AutoBarButtonTrinket2

function AutoBarButtonTrinket2.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrinket2.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Gear.Trinket")
	buttonDB.targeted = TRINKET2_SLOT
	buttonDB.equipped = TRINKET2_SLOT
end

function AutoBarButtonTrinket2.prototype:GetLastUsed()
	local name, itemId = AutoBar.LinkDecode(GetInventoryItemLink("player", TRINKET2_SLOT))
	return itemId
end

local equipTrinket2String = "/equipslot " .. TRINKET2_SLOT .. " "
function AutoBarButtonTrinket2.prototype:SetupAttributes(button, bag, slot, spell, macroId, itemId, itemData)
--AutoBar:Print("AutoBarButtonTrinket2.prototype:SetupAttributes " .. tostring(bag) .. "|" .. tostring(slot) .. "|" .. tostring(itemId))

	local _, equippedItemId = AutoBar.LinkDecode(GetInventoryItemLink("player", TRINKET2_SLOT))

	if (equippedItemId == itemId) then
		AutoBarButtonTrinket2.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, itemId, itemData)
	elseif (not bag) then
		AutoBarButtonTrinket2.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, itemId, itemData)
	else
		local _,_,_,_,_,_,_,_,_,macroTexture = GetItemInfo(tonumber(itemId))
		local macroText = equipTrinket2String .. bag .." " .. slot -- "/equipslot [button:2] Z X Y" to do right click filtering

		button.macroText = macroText
		button.macroTexture = macroTexture
		local macroId = macroText
		AutoBarSearch:RegisterMacro(macroId, nil, L["AutoBarButtonTrinket2"], macroText)
--AutoBar:Print("AutoBarButtonTrinket2.prototype:SetupAttributes macroId " .. tostring(macroId))
		AutoBarButtonTrinket2.super.prototype.SetupAttributes(self, button, nil, nil, nil, macroId)
	end
end


local AutoBarButtonWarlockStones = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonWarlockStones"] = AutoBarButtonWarlockStones

function AutoBarButtonWarlockStones.prototype:init(parentBar, buttonDB)
	AutoBarButtonWarlockStones.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "WARLOCK") then
		self:AddCategory("Consumable.Warlock.Firestone")
		self:AddCategory("Consumable.Warlock.Soulstone")
		self:AddCategory("Consumable.Warlock.Spellstone")
	end
end


local AutoBarButtonWater = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonWater"] = AutoBarButtonWater

function AutoBarButtonWater.prototype:init(parentBar, buttonDB)
	AutoBarButtonWater.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "MAGE") then
		self:AddCategory("Consumable.Water.Conjure")
	end
	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		self:AddCategory("Consumable.Water.Percentage")
		self:AddCategory("Consumable.Water.Basic")
	end
end

local function GetDisableConjureWater(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).disableConjureWater
end

local function SetDisableConjureWater(table)
	local buttonDB = AutoBar:GetButtonDB(table.buttonKey)
	if (buttonDB.disableConjureWater) then
		buttonDB.disableConjureWater = nil
	else
		buttonDB.disableConjureWater = true
	end
	AutoBar:BarButtonChanged()
	AutoBar:CategoriesChanged()
end

function AutoBarButtonWater.prototype:Refresh(parentBar, buttonDB)
	AutoBarButtonWater.super.prototype.Refresh(self, parentBar, buttonDB)
	if (AutoBar.CLASS == "MAGE") then
		if (buttonDB.disableConjureWater) then
			self:DeleteCategory("Consumable.Water.Conjure")
			buttonDB.castSpell = nil
			AutoBarCategoryList["Consumable.Water.Basic"]:SetCastList(nil)
		else
			self:AddCategory("Consumable.Water.Conjure")
			AutoBarCategoryList["Consumable.Water.Basic"]:SetCastList(AutoBarCategory:FilterClass({"MAGE", spellConjureWater,}))
		end
	end
end

function AutoBarButtonWater.prototype:AddOptions(optionList, passValue)
	if (AutoBar.CLASS == "MAGE") then
		self:SetOptionBoolean(optionList, passValue, GetDisableConjureWater, SetDisableConjureWater, "disableConjureWater", L["Disable Conjure Button"], L["Disable Conjure Button"])
	end
end


local AutoBarButtonWaterBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonWaterBuff"] = AutoBarButtonWaterBuff

function AutoBarButtonWaterBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonWaterBuff.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		self:AddCategory("Consumable.Water.Buff")
	end
end



-- /script AutoBar:Print(tostring(AutoBarProfile.basic[2].castSpell))
-- /script AutoBar:Print(tostring(AutoBar.buttons[2].castSpell))
-- /script AutoBarSAB1Border:Hide()
-- /script AutoBar.buttonList["AutoBarButtonPowerShift"]:Refresh()
-- /dump AutoBarCategoryList["Spell.Portals"]
-- /script AutoBar:Print("f:"..tostring(GetCVar("flyable")))
