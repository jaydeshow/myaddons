--
-- AutoBarOptions
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Waterfall Configuration Options for AutoBar
-- http://code.google.com/p/autobar/
--

-- Category:
--  AutoBar.db.account.customCategory[customCategoryIndex]
--	A separate list of Categories that is global to all players
--	Users can add their own custom Categories to this list.
--	Custom Categories can have specific items and spells dragged into their list.
--	Custom Categories can also be set to PT3 Sets, one regular Set & one priority Set
--	A priority Set item has priority over a regular Set item with the same value.
--	All common settings available to a built in Category are also available to a Custom category

-- CustomButton:
--  AutoBar.db.account.customButtons[customButtonIndex]
--	A separate list of Buttons that is global to all players
--	Some Buttons like custom Buttons can have their Categories chosen from the Categories list

-- Button:
--  AutoBar.db.char.buttons[buttonName]
--  Contains the defaults for Button settings & changes to the settings are stored here.
--  Enable / Disable state is recorded here
--  Only one buttonName per button found in a Bar
--  defaultBar: barKey
--  defaultButtonIndex (#, "*" for at end, "~" for do not place, "buttonName" to insert after a button).
--  place: true.  Placement sets it to false.
--    Buttons are placed in their defaultBar at defaultButtonIndex on initialize.
--  deleted: false. Can be deleted by deleting from a Bar.
--  Deleted Buttons can be added back to a Bar
--  Plugin & Custom Buttons are added here & must have non-clashing names

-- Bar:
--  AutoBar.db.char.bars[barKey]
--  Bars contain a list of their Buttons
--  Bars are populated by Buttons with place set to true.
--  Also, resetting a Bar replaces all buttons defaulting to it.
--	Buttons can be reordered within the Bar
--	enabled: true or false
--  Plugin & Custom Bars are added here & must have non-clashing names

-- ToDo:
-- BarSettings:
--  AutoBar.db.profile.barSettings[barKey]
--	Bar & Button visual settings are inherited AutoBar -> Bar -> Button
--  Plugin Buttons / Bars


local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 55356 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")
local LBS = LibStub("LibBabble-Spell-3.0")
local BS = LBS:GetLookupTable()
local waterfall = AceLibrary:GetInstance("Waterfall-1.0")


function AutoBar:InitializeOptions()
	self:InitializeDefaults()
	self:UpgradeVersion()
	self:PopulateBars()

	self:CreateOptions()

	waterfall:Register("AutoBar",
						"aceOptions", self.options,
						"title", L["AutoBar"] .. " " .. AutoBar.version .. " (" .. AutoBar.revision .. ")",
						"treeLevels", 5,
						"colorR", 0.8, "colorG", 0.4, "colorB", 0.8,
						"hideTreeRoot"
					)
	self.options.args.config = {
		name = L["AutoBar"],
		desc = L["Toggle the config panel"],
		wfHidden = true,
		type = "execute",
		func = AutoBar.OpenOptions,
	}
--AutoBar:Print("AutoBar:InitializeOptions waterfall " .. tostring(waterfall) .. " self.options " .. tostring(self.options))
end

function AutoBar:OpenOptions()
	AutoBar:CreateOptions()
	waterfall:Refresh("AutoBar")
	waterfall:Open("AutoBar")
end

function AutoBar:GetDB(barKey, buttonIndex, categoryIndex)
	if (categoryIndex) then
		return AutoBar.db.account.customCategories[categoryIndex]
	end

	local config = AutoBar.db.profile
	if (barKey) then
		config = AutoBar.db.profile.bars[barKey]
		if (buttonIndex) then
			config = config.buttons[buttonIndex]
		end
	end
	return config
end


function AutoBar:GetOptions(barKey, buttonIndex, buttonCategoryIndex, categoryIndex)
	if (categoryIndex) then
		return AutoBar.options.args.categories.args[categoryIndex]
	end

	local config = self.options.args
	if (barKey) then
		config = self.options.args.bars.args[barKey]
		if (buttonIndex) then
			config = config.args.buttons.args[buttonIndex]
			if (buttonCategoryIndex) then
				config = config.args.categories.args[buttonCategoryIndex]
			end
		end
	end
	return config
end
-- /dump AutoBar:GetOptions("AutoBarClassBarBasic").args.buttons.args[31].args.categories.args[1].args.categories.passValue.buttonIndex
-- /dump AutoBar:GetOptions("AutoBarClassBarDruid").args.buttons.args[7]


function AutoBar:GetCategoriesItemDB(categoryIndex, itemIndex)
	local config = AutoBar.db.account.customCategories[categoryIndex]
	if (itemIndex) then
		config = config.items
	end
	return config
end


local function AutoBarChanged()
	AutoBar:UpdateObjects()
end


local function ButtonCategoriesChanged()
--	AutoBar:CreateButtonCategoryOptions(AutoBar.options.args.categories.args)
	AutoBar:UpdateCategories()
end


local function ButtonChanged()
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function optionsChanged()
	AutoBar:UpdateStyles()
	waterfall:Refresh("AutoBar")
end

--/script AutoBar:CorruptionCheck()
-- Verify that indexes are in sequential order for buttonDBList,
function AutoBar:CorruptionCheck()
	local clean = true
	local barDBList = AutoBar:GetDB().bars
	for barKey in pairs(barDBList) do
		-- Check buttonDBList
		local buttonDBList = AutoBar:GetDB(barKey).buttons
		for buttonDBIndex, buttonDB in ipairs(buttonDBList) do
			if (buttonDB.order ~= buttonDBIndex) then
				clean = false
				AutoBar:Print("AutoBar:CorruptionCheck bad order " .. buttonDBIndex .. " barKey " .. barKey .. " # buttonDBList " .. tostring(# buttonDBList))
				buttonDB.order = buttonDBIndex
			end
		end
		local badIndexMax = nil
		for buttonDBIndex, buttonDB in pairs(buttonDBList) do
			if (buttonDBIndex > 1 and buttonDBList[buttonDBIndex - 1] == nil) then
				badIndexMax = buttonDBIndex
			end
			if (buttonDB.hasCustomCategories and buttonDB.buttonClass ~= "AutoBarButtonCustom") then
				clean = false
				AutoBar:Print("AutoBar:CorruptionCheck hasCustomCategories drift " .. buttonDBIndex .. " barKey " .. barKey .. " buttonDB.name " .. tostring(buttonDB.name))
			end
		end
		if (badIndexMax) then
			clean = false
			AutoBar:Print("AutoBar:CorruptionCheck badIndexMax " .. badIndexMax .. " barKey " .. barKey .. " # buttonDBList " .. tostring(# buttonDBList))
			for buttonDBIndex = # buttonDBList + 2, badIndexMax, 1 do
				local buttonDB = buttonDBList[buttonDBIndex]
				if (buttonDB) then
					buttonDBList[# buttonDBList + 1] = buttonDB
					buttonDBList[buttonDBIndex] = nil
				end
			end
		end
		for buttonDBIndex, buttonDB in ipairs(buttonDBList) do
			if (buttonDB.order ~= buttonDBIndex) then
				clean = false
				AutoBar:Print("AutoBar:CorruptionCheck bad order " .. buttonDBIndex .. " barKey " .. barKey .. " # buttonDBList " .. tostring(# buttonDBList))
				buttonDB.order = buttonDBIndex
			end
		end

		-- Check buttonOptionsList
		local buttonOptionsList = AutoBar:GetOptions(barKey).args.buttons.args
		for buttonOptionsIndex, buttonOptions in ipairs(buttonOptionsList) do
			if (buttonOptions.order ~= buttonOptionsIndex) then
				clean = false
				AutoBar:Print("AutoBar:CorruptionCheck bad order " .. buttonOptionsIndex .. " barKey " .. barKey .. " # buttonOptionsList " .. tostring(# buttonOptionsList))
				buttonOptions.order = buttonOptionsIndex
			end
		end
		badIndexMax = nil
		for buttonOptionsIndex, buttonOptions in pairs(buttonOptionsList) do
			if (type(buttonOptionsIndex) == "number") then
				if (buttonOptionsIndex > 1 and buttonOptionsList[buttonOptionsIndex - 1] == nil) then
					badIndexMax = buttonOptionsIndex
				end
			end
		end
		if (badIndexMax) then
			clean = false
			AutoBar:Print("AutoBar:CorruptionCheck badIndexMax " .. badIndexMax .. " barKey " .. barKey .. " # buttonOptionsList " .. tostring(# buttonOptionsList))
			for buttonOptionsIndex = # buttonOptionsList + 2, badIndexMax, 1 do
				local buttonOptions = buttonOptionsList[buttonOptionsIndex]
				if (buttonOptions) then
					buttonOptionsList[# buttonOptionsList + 1] = buttonOptions
					buttonOptionsList[buttonOptionsIndex] = nil
				end
			end
		end
		for buttonOptionsIndex, buttonOptions in ipairs(buttonOptionsList) do
			if (buttonOptions.order ~= buttonOptionsIndex) then
				clean = false
				AutoBar:Print("AutoBar:CorruptionCheck bad order " .. buttonOptionsIndex .. " barKey " .. barKey .. " # buttonOptionsList " .. tostring(# buttonOptionsList))
				buttonOptions.order = buttonOptionsIndex
			end
		end

		-- Check bar
		local bar = AutoBar.barList[barKey]
		if (bar) then
			badIndexMax = nil
			local activeButtonList = bar.activeButtonList
			for buttonIndex, button in pairs(activeButtonList) do
				if (buttonIndex > 1 and activeButtonList[buttonIndex - 1] == nil) then
					badIndexMax = buttonIndex
				end
			end
			if (badIndexMax) then
				clean = false
				AutoBar:Print("AutoBar:CorruptionCheck badIndexMax " .. badIndexMax .. " barKey " .. barKey .. " # activeButtonList " .. tostring(# buttonDBList))
				for buttonIndex = # activeButtonList + 2, badIndexMax, 1 do
					local button = activeButtonList[buttonIndex]
					if (button) then
						activeButtonList[# activeButtonList + 1] = button
						activeButtonList[buttonIndex] = nil
					end
				end
			end
		end

	end
	return clean
end
-- /dump (# AutoBar.barList["AutoBarClassBarBasic"].activeButtonList)
-- /dump (AutoBar.barList["AutoBarClassBarBasic"].activeButtonList[1]:IsActive())

local function ResetBars()
	AutoBar:ResetDB("char")
	AutoBar:ResetDB("profile")
	AutoBar:PopulateBars(true)
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function Refresh()
	AutoBar:CorruptionCheck()
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
	AutoBar:CorruptionCheck()
end


local function ResetDefaults()
	AutoBar:ResetDB("char")
	waterfall:Refresh("AutoBar")
end


local function categoriesChanged()
	AutoBar:CreateCustomCategoryOptions(AutoBar.options.args.categories.args)
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


function AutoBar:OnProfileDisable()
    -- this is called every time your profile changes (before the change)
--AutoBar:Print("OnProfileDisable")
end


function AutoBar:OnProfileEnable()
    -- this is called every time your profile changes (after the change)
--AutoBar:Print("OnProfileEnable")
	AutoBar:UpgradeVersion()
	AutoBar:PopulateBars(true)
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function getCombatLockdown()
	 return InCombatLockdown()
end


local function getBarEnabledLockdown(table)
	local barKey = table.barKey
	return InCombatLockdown() or not AutoBar:GetDB(barKey).enabled
end


local function getAlignButtons(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).alignButtons
end

local function setAlignButtons(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).alignButtons = value
	AutoBarChanged()
end

local function getAlpha(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).alpha
end

local function setAlpha(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	AutoBar:GetDB(barKey, buttonIndex).alpha = value
	AutoBar:GetDB(barKey, buttonIndex).faded = nil
	AutoBarChanged()
end

local function getAlwaysShow(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).alwaysShow
end

local function setAlwaysShow(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	AutoBar:GetDB(barKey, buttonIndex).alwaysShow = value
	optionsChanged()
end

local function getArrangeOnUse(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	local categoryIndex = table.categoryIndex
	return AutoBar:GetDB(barKey, buttonIndex, categoryIndex).arrangeOnUse
end

local function setArrangeOnUse(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	local categoryIndex = table.categoryIndex
	AutoBar:GetDB(barKey, buttonIndex, categoryIndex).arrangeOnUse = value
	optionsChanged()
end

local function getBattleground(table)
	local categoryIndex = table.categoryIndex
	return AutoBar:GetDB(nil, nil, categoryIndex).battleground
end

local function setBattleground(table, value)
	local categoryIndex = table.categoryIndex
	AutoBar:GetDB(nil, nil, categoryIndex).battleground = value
	categoriesChanged()
end

local function getCategoryItem(table)
	local categoryIndex, itemIndex = table.categoryIndex, table.itemIndex
	local itemDB = AutoBar:GetCategoriesItemDB(categoryIndex, itemIndex)[itemIndex]
	assert(itemDB)
	return itemDB
end

local function setCategoryItem(table, itemDB)
	local categoryIndex, itemIndex = table.categoryIndex, table.itemIndex
--AutoBar:Print("setItem itemType " .. tostring(itemDB.itemType) .. " itemId " .. tostring(itemDB.itemId) .. " itemInfo " .. tostring(itemDB.itemInfo) .. " spellName " .. tostring(itemDB.spellName))
--	local itemDB = AutoBar:GetCategoriesItemDB(categoryIndex, itemIndex)[itemIndex]
	categoriesChanged()
end

local function getDocking(table)
	local barKey = table.barKey
	local docking = AutoBar:GetDB(barKey).docking
	if (not docking) then
		docking = "NONE"
	end
	return docking
end

local function setDocking(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).docking = value
	if (value == "NONE") then
		AutoBar:GetDB(barKey).docking = nil
	end
	AutoBarChanged()
end

local function getDockShiftX(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).dockShiftX
end

local function setDockShiftX(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).dockShiftX = value
	AutoBarChanged()
end

local function getDockShiftY(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).dockShiftY
end

local function setDockShiftY(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).dockShiftY = value
	AutoBarChanged()
end

local function getFrameStrata(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).frameStrata
end

local function setFrameStrata(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).frameStrata = value
	AutoBarChanged()
end

local function getLocation(table)
	local categoryIndex = table.categoryIndex
	return AutoBar:GetDB(nil, nil, categoryIndex).location
end

local function setLocation(table, value)
	local categoryIndex = table.categoryIndex
	AutoBar:GetDB(nil, nil, categoryIndex).location = value
	categoriesChanged()
end

local function getName(table)
	local categoryIndex = table.categoryIndex
--AutoBar:Print("getName " .. tostring(categoryIndex).. "  " ..tostring(table))
	return AutoBar:GetDB(nil, nil, categoryIndex).name
end

local function setName(table, value)
	local categoryIndex = table.categoryIndex
	local categoryDB = AutoBar:GetDB(nil, nil, categoryIndex)
	local categoryInfo = AutoBarCategoryList["Custom." .. categoryDB.name]
	value = categoryInfo:ChangeName(value)
	-- ToDo: If name did not change toss an error message?
	AutoBar.options.args.categories.args[categoryIndex].name = value
	ButtonChanged()
end

local function getNonCombat(table)
	local categoryIndex = table.categoryIndex
	return AutoBar:GetDB(nil, nil, categoryIndex).nonCombat
end

local function setNonCombat(table, value)
	local categoryIndex = table.categoryIndex
	AutoBar:GetDB(nil, nil, categoryIndex).nonCombat = value
	categoriesChanged()
end

local function getNotUsable(table)
	local categoryIndex = table.categoryIndex
	return AutoBar:GetDB(nil, nil, categoryIndex).notUsable
end

local function setNotUsable(table, value)
	local categoryIndex = table.categoryIndex
	AutoBar:GetDB(nil, nil, categoryIndex).notUsable = value
	categoriesChanged()
end

local function getPopupDirection(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).popupDirection
end

local function setPopupDirection(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).popupDirection = value
	AutoBarChanged()
end

local function getTargeted(table)
	local categoryIndex = table.categoryIndex
	return AutoBar:GetDB(nil, nil, categoryIndex).targeted
end

local function setTargeted(table, value)
	local categoryIndex = table.categoryIndex
	AutoBar:GetDB(nil, nil, categoryIndex).targeted = value
	categoriesChanged()
end

local function getButtonWidth(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).buttonWidth
end

local function setButtonWidth(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	AutoBar:GetDB(barKey, buttonIndex).buttonWidth = value
	AutoBarChanged()
end

local function getButtonHeight(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).buttonHeight
end

local function setButtonHeight(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	AutoBar:GetDB(barKey, buttonIndex).buttonHeight = value
	AutoBarChanged()
end

local function getCollapseButtons(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).collapseButtons
end

local function setCollapseButtons(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).collapseButtons = value
	AutoBarChanged()
end

local function getColumns(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).columns
end

local function setColumns(table, value)
	local barKey = table.barKey
	local rows = AutoBar:GetDB(barKey).rows
	local columns = value
	AutoBar:GetDB(barKey).columns = value
	AutoBarChanged()
end

--AutoBar:Print("getButtonEnabled barKey " .. tostring(barKey) .. " buttonIndex " .. tostring(buttonIndex).. " table " ..tostring(table));
local function getEnabled(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).enabled
end

local function setEnabled(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
--	AutoBar:GetDB(barKey, buttonIndex).enabled = value
	local config = AutoBar:GetDB(barKey, buttonIndex)
	config.enabled = not config.enabled
	config.isChecked = config.enabled
	optionsChanged()
end

local function getFadeOut(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).fadeOut
end

local function setFadeOut(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).fadeOut = value
	AutoBar.barList[barKey]:SetFadeOut(value)
	AutoBarChanged()
end

local function getHide(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).hide
end

local function setHide(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	AutoBar:GetDB(barKey, buttonIndex).hide = value
	optionsChanged()
end

local function getNoPopup(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).noPopup
end

local function setNoPopup(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	AutoBar:GetDB(barKey, buttonIndex).noPopup = value
	optionsChanged()
end

local function getOrder(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).order
end


-- Cut the button at fromIndex out of fromBarKey
-- 1 <= fromIndex <= # frombuttonDBList
-- Adjust the remaining buttons to fill the gap if any
-- Return the button, its DB & its Options
function AutoBar:ButtonCut(fromBarKey, fromIndex)
	local button, buttonDB, buttonOptions
	local frombuttonDBList = AutoBar:GetDB(fromBarKey).buttons
	local nButtons = # frombuttonDBList
	assert(fromIndex > 0, "AutoBar:ButtonCut fromIndex < 1")
	assert(fromIndex <= nButtons, "AutoBar:ButtonCut fromIndex > nButtons")
--AutoBar:Print("AutoBar:ButtonCut fromBarKey " .. tostring(fromBarKey) .. " fromIndex " .. tostring(fromIndex))

	-- Cut the DB
	buttonDB = frombuttonDBList[fromIndex]
	local hasCustomCategoriesBefore, hasCustomCategoriesAfter
	for index = fromIndex, nButtons, 1 do
		hasCustomCategoriesBefore = frombuttonDBList[index + 1] and frombuttonDBList[index + 1].hasCustomCategories
		frombuttonDBList[index] = frombuttonDBList[index + 1]
		hasCustomCategoriesAfter = frombuttonDBList[index] and frombuttonDBList[index].hasCustomCategories
		assert(hasCustomCategoriesBefore == hasCustomCategoriesAfter, "AutoBar:ButtonCut hasCustomCategoriesBefore ~= hasCustomCategoriesAfter")
		if (frombuttonDBList[index]) then
			frombuttonDBList[index].order = index
		end
	end

	-- Cut the Options
	local fromButtonOptionsList = AutoBar:GetOptions(fromBarKey).args.buttons.args
	local fromCategoryOptionsList
	buttonOptions = fromButtonOptionsList[fromIndex]
	assert(# fromButtonOptionsList == nButtons, "AutoBar:ButtonCut # fromButtonOptionsList ~= # frombuttonDBList")
	for index = fromIndex, # fromButtonOptionsList, 1 do
		fromButtonOptionsList[index] = fromButtonOptionsList[index + 1]
		if (fromButtonOptionsList[index]) then
			fromButtonOptionsList[index].order = index
			fromButtonOptionsList[index].args.enabled.passValue.buttonIndex = index

			-- Update passValue for categories if necessary
			if (AutoBar:GetOptions(fromBarKey, index).args.categories) then
				fromCategoryOptionsList = AutoBar:GetOptions(fromBarKey, index).args.categories.args
				for categoryIndex, categoryOptions in ipairs(fromCategoryOptionsList) do
					categoryOptions.args.categories.passValue.buttonIndex = fromIndex
					categoryOptions.args.categories.passValue.categoryIndex = categoryIndex
				end
			end
		end
	end
	assert(# fromButtonOptionsList == # frombuttonDBList, "AutoBar:ButtonCut # fromButtonOptionsList ~= # frombuttonDBList")

	local bar = AutoBar.barList[fromBarKey]
	button = bar.buttonList[fromIndex]

	return button, buttonDB, buttonOptions
end


-- Paste buttonDB, buttonOptions at toIndex of toBarKey
-- 1 <= toIndex <= # tobuttonDBList + 1
-- Adjust the remaining buttons to fill the gap if any
function AutoBar:ButtonPaste(buttonDB, buttonOptions, fromBarKey, toBarKey, toIndex, button)
	local tobuttonDBList = AutoBar:GetDB(toBarKey).buttons
	local nButtons = # tobuttonDBList
	assert(toIndex > 0, "AutoBar:ButtonPaste toIndex < 1")
	assert(toIndex <= nButtons + 1, "AutoBar:ButtonPaste toIndex > nButtons + 1")
	assert(buttonDB, "AutoBar:ButtonPaste buttonDB nil")
	assert(buttonOptions, "AutoBar:ButtonPaste buttonOptions nil")
	local multiBarPaste = fromBarKey ~= toBarKey
--AutoBar:Print("AutoBar:ButtonPaste fromBarKey " .. tostring(fromBarKey) .. " toBarKey " .. tostring(toBarKey) .. " toIndex " .. tostring(toIndex))

	-- Make room
	local hasCustomCategoriesBefore, hasCustomCategoriesAfter
	if (toIndex <= nButtons) then
		for index = nButtons + 1, toIndex + 1, -1 do
			hasCustomCategoriesBefore = tobuttonDBList[index - 1].hasCustomCategories
			tobuttonDBList[index] = tobuttonDBList[index - 1]
			tobuttonDBList[index].order = index
			hasCustomCategoriesAfter = tobuttonDBList[index].hasCustomCategories
			assert(hasCustomCategoriesBefore == hasCustomCategoriesAfter, "AutoBar:ButtonPaste hasCustomCategoriesBefore ~= hasCustomCategoriesAfter")
		end
	end
	-- Paste the DB
	tobuttonDBList[toIndex] = buttonDB
	buttonDB.order = toIndex

	-- Make room
	local toButtonOptionsList = AutoBar:GetOptions(toBarKey).args.buttons.args
	assert(# toButtonOptionsList == nButtons, "AutoBar:ButtonCut # toButtonOptionsList ~= # tobuttonDBList")
	local toCategoryOptionsList
	if (toIndex <= nButtons) then
		for index = # toButtonOptionsList + 1, toIndex + 1, -1 do
			toButtonOptionsList[index] = toButtonOptionsList[index - 1]
			toButtonOptionsList[index].order = index
			toButtonOptionsList[index].args.enabled.passValue.barKey = toBarKey
			toButtonOptionsList[index].args.enabled.passValue.buttonIndex = index

			-- Update passValue for categories if necessary
			if (AutoBar:GetOptions(toBarKey, index).args.categories) then
				toCategoryOptionsList = AutoBar:GetOptions(toBarKey, index).args.categories.args
				for categoryIndex, categoryOptions in ipairs(toCategoryOptionsList) do
					categoryOptions.args.categories.passValue.barKey = toBarKey
					categoryOptions.args.categories.passValue.buttonIndex = index
					categoryOptions.args.categories.passValue.categoryIndex = categoryIndex
				end
			end
		end
	end
	-- Paste the Options
	toButtonOptionsList[toIndex] = buttonOptions
	buttonOptions.order = toIndex
	buttonOptions.args.enabled.passValue.barKey = toBarKey
	buttonOptions.args.enabled.passValue.buttonIndex = toIndex
	-- Update passValue for categories if necessary
	if (AutoBar:GetOptions(toBarKey, toIndex).args.categories) then
		toCategoryOptionsList = AutoBar:GetOptions(toBarKey, toIndex).args.categories.args
		for categoryIndex, categoryOptions in ipairs(toCategoryOptionsList) do
			categoryOptions.args.categories.passValue.barKey = toBarKey
			categoryOptions.args.categories.passValue.buttonIndex = toIndex
			categoryOptions.args.categories.passValue.categoryIndex = categoryIndex
		end
	end
	assert(# toButtonOptionsList == # tobuttonDBList, "AutoBar:ButtonCut # toButtonOptionsList ~= # tobuttonDBList")

	-- Handle reparenting for multiBarPaste of the actual button
	if (multiBarPaste) then
		-- First cut at this, just delete the old button.
--		AutoBar.barList[fromBarKey]:ButtonRemove(buttonDB)
		buttonDB.defaultBar = toBarKey
		button.parentBar.frame:SetAttribute("addchild", button.frame)
	end
end


-- This supports moving without the lame condition where you cannot move to a particular end
-- Button is cut from fromIndex of fromBarKey and inserted at toIndex of toBarKey
-- For toIndex <= tobuttonDBList existing buttons are shuffled up to make room
-- For toIndex > tobuttonDBList button is inserted at end
function AutoBar:ButtonMove(fromBarKey, fromIndex, toBarKey, toIndex)
	local frombuttonDBList = AutoBar:GetDB(fromBarKey).buttons
	local tobuttonDBList = AutoBar:GetDB(toBarKey).buttons
	local nButtons = # tobuttonDBList
	local multiBarMove = fromBarKey ~= toBarKey
assert(AutoBar:CorruptionCheck(), "AutoBar:ButtonMove start failed CorruptionCheck")

--AutoBar:Print("\nAutoBar:ButtonMove initial  fromBarKey " .. tostring(fromBarKey) .. " fromIndex " .. tostring(fromIndex) .. " toBarKey " .. tostring(toBarKey) .. " toIndex " .. tostring(toIndex))
	-- Wrangle the indexes
	if (toIndex < 1) then
		toIndex = 1
	end
	if (toIndex > nButtons) then
		if (multiBarMove) then
			-- Special case move to end across multiple bars
			toIndex = nButtons + 1
		else
			toIndex = nButtons
		end
	end
	if (not multiBarMove) then
		if (toIndex > fromIndex) then
			-- Adjust offset due to cut from earlier in the list
--			toIndex = toIndex - 1
		elseif (toIndex == fromIndex) then
			return
		end
	end
--AutoBar:Print("AutoBar:ButtonMove adjusted fromBarKey " .. tostring(fromBarKey) .. " fromIndex " .. tostring(fromIndex) .. " toBarKey " .. tostring(toBarKey) .. " toIndex " .. tostring(toIndex))

	-- Cut & Paste
	local button, buttonDB, buttonOptions = AutoBar:ButtonCut(fromBarKey, fromIndex)
assert(AutoBar:CorruptionCheck(), "AutoBar:ButtonMove Cut failed CorruptionCheck")
	AutoBar:ButtonPaste(buttonDB, buttonOptions, fromBarKey, toBarKey, toIndex, button)
assert(AutoBar:CorruptionCheck(), "AutoBar:ButtonMove Paste failed CorruptionCheck")
end
-- /dump AutoBar:GetOptions("AutoBarClassBarBasic").args.buttons.args[31].args.categories.args[1].args.categories.passValue.buttonIndex


local function setOrder(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
--AutoBar:Print("AutoBar:DragStop barKey " .. tostring(barKey) .. " buttonIndex " .. tostring(buttonIndex) .. " value " ..tostring(value))
	AutoBar:ButtonMove(barKey, buttonIndex, barKey, value)
assert(AutoBar:CorruptionCheck(), "setOrder Oh Shit failed CorruptionCheck")
	ButtonChanged()
end

local function getPadding(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).padding
end

local function setPadding(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).padding = value
	AutoBarChanged()
end

local function getRows(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).rows
end

local function setRows(table, value)
	local barKey = table.barKey
	local rows = value
	local columns = AutoBar:GetDB(barKey).columns
	AutoBar:GetDB(barKey).rows = value
	AutoBarChanged()
end

local function getRightClickTargetsPet(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	return AutoBar:GetDB(barKey, buttonIndex).rightClickTargetsPet
end

local function setRightClickTargetsPet(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	AutoBar:GetDB(barKey, buttonIndex).rightClickTargetsPet = value
	optionsChanged()
end

local function getScale(table)
	local barKey = table.barKey
	return AutoBar:GetDB(barKey).scale
end

local function setScale(table, value)
	local barKey = table.barKey
	AutoBar:GetDB(barKey).scale = value
	AutoBarChanged()
end

local function CategoryAdd(table)
	local barKey, buttonIndex, categoryIndex, categoryKey = table.barKey, table.buttonIndex, table.categoryIndex, table.categoryKey
	local buttonInfo = AutoBar.options.args.bars.args[barKey].args.buttons.args[buttonIndex].args.categories
	local buttonDB = AutoBar:GetDB(barKey, buttonIndex)
	local buttonCategoryIndex = # buttonDB + 1
	buttonDB[buttonCategoryIndex] = "Misc.Hearth"
	AutoBar:CreateButtonCategoryOptions(barKey, buttonIndex, AutoBar.options.args.bars.args[barKey].args.buttons.args[buttonIndex].args.categories.args)
	optionsChanged()
end

local function CategoryRemove(table)
	local barKey, buttonIndex, categoryIndex, categoryKey = table.barKey, table.buttonIndex, table.categoryIndex, table.categoryKey
	local buttonInfo = AutoBar.options.args.bars.args[barKey].args.buttons.args[buttonIndex].args.categories
	local buttonDB = AutoBar:GetDB(barKey, buttonIndex)

	for i = categoryIndex, # buttonDB, 1 do
		buttonInfo[i] = buttonInfo[i + 1]
		if (buttonInfo[i]) then
			buttonInfo[i].order = i
		end
		buttonDB[i] = buttonDB[i + 1]
	end

	AutoBar:CreateButtonCategoryOptions(barKey, buttonIndex, AutoBar.options.args.bars.args[barKey].args.buttons.args[buttonIndex].args.categories.args)
	ButtonChanged()
end

local function getButtonCategory(table)
	local barKey, buttonIndex, categoryIndex, categoryKey = table.barKey, table.buttonIndex, table.categoryIndex, table.categoryKey
	local buttonDB = AutoBar:GetDB(barKey, buttonIndex)

	return buttonDB[categoryIndex]
end

local function setButtonCategory(table, value)
	local barKey, buttonIndex, categoryIndex, categoryKey = table.barKey, table.buttonIndex, table.categoryIndex, table.categoryKey
	local buttonDB = AutoBar:GetDB(barKey, buttonIndex)
	buttonDB[categoryIndex] = value

	AutoBar:CreateButtonCategoryOptions(barKey, buttonIndex, AutoBar.options.args.bars.args[barKey].args.buttons.args[buttonIndex].args.categories.args)

	ButtonChanged()
end

local MAXBARBUTTONS = 64
local function ButtonNew(table)
	local barKey = table.barKey
	local buttonDBList = AutoBar:GetDB(barKey).buttons
	local buttonIndex = # buttonDBList + 1
	if (buttonIndex <= MAXBARBUTTONS) then
		local newButtonName = AutoBarButton:GetNewName(L["Custom"] .. L["Button"], buttonIndex)
		buttonDBList[buttonIndex] = {
			name = newButtonName,
			buttonClass = "AutoBarButtonCustom",
			defaultBar = barKey,
			hasCustomCategories = true,
			enabled = true,
			order = buttonIndex,
		}
		buttonDBList[buttonIndex][1] = "Misc.Hearth"
		local barOptions = AutoBar.options.args.bars.args
		barOptions[barKey] = AutoBar:CreateBarOptions(barKey, barOptions[barKey])
	end

	ButtonChanged()
end


local function ButtonDelete(table)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
	local button, buttonDB, buttonOptions = AutoBar:ButtonCut(barKey, buttonIndex)
	-- Move to disabled cache
	if (AutoBar.buttonList[buttonDB.name]) then
		AutoBar.buttonListDisabled[buttonDB.name] = AutoBar.buttonList[buttonDB.name]
		AutoBar.buttonList[buttonDB.name] = nil
--AutoBar:Print("ButtonDelete Freeze " .. tostring(buttonDB.name) .. " --> buttonListDisabled")
	end
--AutoBar:Print("ButtonDelete " .. tostring(button.buttonName))
	button.frame:Hide()
	buttonDB.enabled = nil
	buttonDB = nil
	buttonOptions = nil
	ButtonChanged()
end


local function CategoryNew()
	local categoriesList = AutoBar.options.args.categories.args
	local categoryIndex = # AutoBar.db.account.customCategories + 1
	local newCategoryName = AutoBarCustom:GetNewName(L["Custom"], categoryIndex)
	AutoBar.db.account.customCategories[categoryIndex] = {
		name = newCategoryName,
		desc = newCategoryName,
		order = categoryIndex,
		items = {},
	}
	AutoBarCategoryUpdate(AutoBar.db.account.customCategories[categoryIndex], nil)
	categoriesChanged()
--DevTools_Dump(AutoBar.db.account.customCategories)
end


local function CategoryDelete(table)
	local categoryIndex = table.categoryIndex
	local categoriesList = AutoBar.options.args.categories.args
	local categoriesListDB = AutoBar.db.account.customCategories
	for i = categoryIndex, # categoriesListDB, 1 do
		categoriesList[i] = categoriesList[i + 1]
		if (categoriesList[i]) then
			categoriesList[i].order = i
		end
		categoriesListDB[i] = categoriesListDB[i + 1]
	end
	AutoBarCategoryUpdate(nil, AutoBar.db.account.customCategories[categoryIndex])
	categoriesChanged()
--DevTools_Dump(categoriesListDB)
end


local function ItemNew(table)
	local categoryIndex = table.categoryIndex
	local itemsListDB = AutoBar.db.account.customCategories[categoryIndex].items
	local itemIndex = # itemsListDB + 1
	itemsListDB[itemIndex] = {}
	categoriesChanged()
--	local itemsList = AutoBar.options.args.categories.args[categoryIndex].args.items.args
--DevTools_Dump(itemsList)
end


local function ItemDelete(table)
	local categoryIndex, itemIndex = table.categoryIndex, table.itemIndex
	local itemsList = AutoBar.options.args.categories.args[categoryIndex].args.items.args
	local itemsListDB = AutoBar.db.account.customCategories[categoryIndex].items
	for i = itemIndex, # itemsListDB, 1 do
		itemsList[i] = itemsList[i + 1]
		itemsListDB[i] = itemsListDB[i + 1]
	end
	categoriesChanged()
--DevTools_Dump(itemsListDB)
end

local alignValidateList = {
	["1"] = L["TOPLEFT"],
	["2"] = L["LEFT"],
	["3"] = L["BOTTOMLEFT"],
	["4"] = L["TOP"],
	["5"] = L["CENTER"],
	["6"] = L["BOTTOM"],
	["7"] = L["TOPRIGHT"],
	["8"] = L["RIGHT"],
	["9"] = L["BOTTOMRIGHT"],
}

local popupDirectionValidateList = {
	["1"] = L["TOP"],
	["2"] = L["LEFT"],
	["3"] = L["BOTTOM"],
	["4"] = L["RIGHT"],
}

function AutoBar:CreateOptions()
	local name = L["AutoBar"]
	if (not self.options) then
		self.options = {
			type = "group",
			order = 1,
			name = name,
			desc = name,
			args = {
				lockBars = {
					order = 1,
					name = L["Move the Bars"],
					type = "toggle",
					desc = L["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."],
					get = function() return AutoBar.stickyMode end,
					set = AutoBar.ToggleStickyMode,
					disabled = getCombatLockdown,
				},
				lockButtons = {
					order = 1,
					name = L["Move the Buttons"],
					type = "toggle",
					desc = L["Drag a Button to move it, right click to configure the Button."],
					get = function() return AutoBar.unlockButtons end,
					set = function(v)
						if AutoBar.unlockButtons then
							AutoBar:LockButtons()
						else
							AutoBar:UnlockButtons()
						end
					end,
					disabled = getCombatLockdown,
				},
				bars = {
					type = "group",
					order = 3,
					name = L["Bars"],
					desc = L["Bars"],
					args = {
					}
				},
	--			buttons = {
	--				order = 3,
	--				type = "group",
	--				name = L["Buttons"],
	--				desc = L["Buttons"],
	--				args = {
	--				}
	--			},
				categories = {
					type = "group",
					order = 4,
					name = L["Categories"],
					desc = L["Categories"],
					args = {
						newCategory = {
						    type = "execute",
						    name = L["New"],
						    desc = L["New"],
						    func = CategoryNew,
						},
						reset = {
						    type = "execute",
						    name = L["Reset"],
						    desc = L["Reset"],
						    func = function() self.db.account.customCategories = {}; categoriesChanged(); end,
						},
					}
				},
				style = {
				    type = 'text',
					order = 8,
					name = L["Style"],
				    desc = L["Change the style of the bar."],
				    get = function()
				        return self.db.profile.style or "Dreamlayout"
				    end,
				    set = function(name)
				        self.db.profile.style = name
						optionsChanged()
				    end,
				    validate = AutoBar.styleValidateList,
				},
	--			head1 = {
	--				order = 10,
	--				type = "header",
	--			},
				sticky = {
					order = 15,
					name = L["Sticky Frames"],
					desc = L["Snap Bars while moving"],
					type = "toggle",
					get = function() return self.db.profile.sticky end,
					set = function(value)
						self.db.profile.sticky = value
						AutoBarChanged()
					end,
				},
				showCount = {
					type = "toggle",
					order = 21,
					name = L["Show Count Text"],
					desc = L["Show Count Text for %s"]:format(name),
					get = function() return self.db.profile.showCount end,
					set = function(value)
						self.db.profile.showCount = value
						AutoBarChanged()
					end,
				},
				showHotkey = {
					type = "toggle",
					order = 31,
					name = L["Show Hotkey Text"],
					desc = L["Show Hotkey Text for %s"]:format(name),
					get = function() return self.db.profile.showHotkey end,
					set = function(value)
						self.db.profile.showHotkey = value
						AutoBarChanged()
					end,
				},
				showTooltip = {
					type = "toggle",
					order = 41,
					name = L["Show Tooltips"],
					desc = L["Show Tooltips for %s"]:format(name),
					get = function() return self.db.profile.showTooltip end,
					set = function(value)
						self.db.profile.showTooltip = value
						AutoBarChanged()
					end,
				},
				showEmptyButtons = {
					type = "toggle",
					order = 51,
					name = L["Show Empty Buttons"],
					desc = L["Show Empty Buttons for %s"]:format(name),
					get = function() return self.db.profile.showEmptyButtons end,
					set = function(value)
						self.db.profile.showEmptyButtons = value
						AutoBarChanged()
					end,
				},
				rightclick = {
					type = "toggle",
					order = 61,
					name = L["RightClick SelfCast"],
					desc = L["SelfCast using Right click"],
					get = function() return AutoBar.db.profile.selfCastRightClick end,
					set = function(value)
						AutoBar.db.profile.selfCastRightClick = value
						AutoBarChanged()
					end,
				},
	--			alignButtons = {
	--			    type = 'text',
	--				order = 71,
	--				name = L["Align Buttons"],
	--				desc = L["Align Buttons"],
	--				get = getAlignButtons,
	--				set = setAlignButtons,
	--				columns = 3,
	--			    validate = alignValidateList,
	--				passValue = {["barKey"] = nil},
	--			},
				refresh = {
				    type = "execute",
					order = 181,
				    name = L["Refresh"],
				    desc = L["Refresh all the bars & buttons"],
				    func = Refresh,
					passValue = {},
					disabled = getCombatLockdown,
				},
				resetBars = {
				    type = "execute",
					order = 181,
				    name = L["Reset Bars"],
				    desc = L["Reset the Bars to default Bar settings"],
				    func = ResetBars,
					passValue = {},
					disabled = getCombatLockdown,
				},
--				resetDefaults = {
--				    type = "execute",
--					order = 181,
--				    name = "Reset Defaults",--Temporary do not localize
--				    desc = "Resets the default settings & Bar indexes for the Buttons",--Temporary do not localize
--				    func = ResetDefaults,
--					passValue = {},
--					disabled = getCombatLockdown,
--				},
				performance = {
					type = "toggle",
					order = 61,
					name = L["Log Performance"],
					desc = L["Log Performance"],
					get = function() return AutoBar.db.profile.performance end,
					set = function(value)
						AutoBar.db.profile.performance = value
					end,
				},
	--			head5 = {
	--				order = 50,
	--				type = "header",
	--			},
			},
		}
	end

	self:RegisterChatCommand({L["SLASHCMD_SHORT"], L["SLASHCMD_LONG"]}, self.options)

	-- Create Options for Bars and their associated Buttons
	local barOptions = self.options.args.bars.args
	for barKey, barData in pairs(self.db.profile.bars) do
		barOptions[barKey] = self:CreateBarOptions(barKey, barOptions[barKey])
	end

	self:CreateCustomCategoryOptions(self.options.args.categories.args)
end


local frameStrataValidateList = {
	["LOW"] = LOW,
	["MEDIUM"] = L["Medium"],
	["HIGH"] = HIGH,
--	["DIALOG"] = L["Dialog"],
}


-- Creates Options for a Bar and its Buttons
function AutoBar:CreateBarOptions(barKey, existingOptions)
	local name = L[barKey]
	local barOptions

	if (existingOptions) then
		barOptions = existingOptions
		barOptions.args.enabled.passValue["barKey"] = barKey
	else
		local passValue = {["barKey"] = barKey}
		barOptions = {
			type = "group",
			name = name,
			desc = L["Configuration for %s"]:format(name),
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = L["Enabled"],
					desc = L["Enable %s."]:format(name),
					get = getEnabled,
					set = setEnabled,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				collapseButtons = {
					type = "toggle",
					order = 3,
					name = L["Collapse Buttons"],
					desc = L["Collapse Buttons that have nothing in them."],
					get = getCollapseButtons,
					set = setCollapseButtons,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				fadeout = {
					type = "toggle",
					order = 4,
					name = L["FadeOut"],
					desc = L["Fade out the Bar when not hovering over it."],
					get = getFadeOut,
					set = setFadeOut,
					passValue = passValue,
					disabled = getBarEnabled,
				},
				alpha = {
					type = "range",
					order = 12,
					name = L["Alpha"],
					desc = L["Change the alpha of the bar."],
					min = 0, max = 1, step = 0.01, bigStep = 0.05,
					get = getAlpha,
					set = setAlpha,
					passValue = passValue,
					disabled = getBarEnabled,
				},
				rows = {
					type = "range",
					order = 13,
					name = L["Rows"],
					desc = L["Number of rows for %s"]:format(name),
					max = 32, min = 1, step = 1, -- maxbuttons will be adjusted by the bar itself.
					get = getRows,
					set = setRows,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				columns = {
					type = "range",
					order = 14,
					name = L["Columns"],
					desc = L["Number of columns for %s"]:format(name),
					max = 32, min = 1, step = 1, -- maxbuttons will be adjusted by the bar itself.
					get = getColumns,
					set = setColumns,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				padding = {
					type = "range",
					order = 15,
					name = L["Padding"],
					desc = L["Change the padding of the bar."],
					min = -20, max = 30, step = 1,
					get = getPadding,
					set = setPadding,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				scale = {
					type = "range",
					order = 16,
					name = L["Scale"],
					desc = L["Change the scale of the bar."],
					min = .1, max = 2, step = 0.01, bigStep = 0.05,
					isPercent = true,
					get = getScale,
					set = setScale,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
--				buttonWidth = {
--					type = "range",
--					order = 17,
--					name = L["Button Width"],
--					desc = L["Change the button width."],
--					min = 9, max = 72, step = 1,
--					get = getButtonWidth,
--					set = setButtonWidth,
--					passValue = passValue,
--					disabled = getBarEnabledLockdown,
--				},
--				buttonHeight = {
--					type = "range",
--					order = 30,
--					name = L["Button Height"],
--					desc = L["Change the button height."],
--					min = 9, max = 72, step = 1,
--					get = getButtonHeight,
--					set = setButtonHeight,
--					passValue = passValue,
--					disabled = getBarEnabledLockdown,
--				},
				alignButtons = {
				    type = 'text',
					order = 31,
					name = L["Align Buttons"],
					desc = L["Align Buttons"],
					get = getAlignButtons,
					set = setAlignButtons,
					columns = 3,
				    validate = alignValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				popupDirection = {
				    type = 'text',
					order = 32,
					name = L["Popup Direction"],
					desc = L["Popup Direction"],
					get = getPopupDirection,
					set = setPopupDirection,
					columns = 2,
				    validate = popupDirectionValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				head5 = {
					order = 70,
					type = "header",
				},
				docking = {
				    type = 'text',
					order = 71,
					name = L["Docked to"],
					desc = L["Docked to"],
					get = getDocking,
					set = setDocking,
				    validate = AutoBar.dockingFramesValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				dockShiftX = {
					type = "range",
					order = 72,
					name = L["Shift Dock Left/Right"],
					desc = L["Shift Dock Left/Right"],
					min = -50, max = 50, step = 1, bigStep = 1,
					get = getDockShiftX,
					set = setDockShiftX,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				dockShiftY = {
					type = "range",
					order = 73,
					name = L["Shift Dock Up/Down"],
					desc = L["Shift Dock Up/Down"],
					min = -50, max = 50, step = 1, bigStep = 1,
					get = getDockShiftY,
					set = setDockShiftY,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				frameStrata = {
				    type = 'text',
					order = 74,
					name = L["Frame Level"],
					desc = L["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"],
					get = getFrameStrata,
					set = setFrameStrata,
				    validate = frameStrataValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				buttons = {
					order = 200,
					type = "group",
					name = L["Buttons"],
					desc = L["Buttons"],
					args = {
						newButton = {
						    type = "execute",
						    name = L["New"],
						    desc = L["New"],
						    func = ButtonNew,
							passValue = passValue,
						},
					}
				},
			},
		}
	end

	-- Buttons Config
	local buttonsOptions = barOptions.args.buttons.args
	for buttonIndex, buttonDB in ipairs(self.db.profile.bars[barKey].buttons) do
		buttonsOptions[buttonIndex] = self:CreateButtonOptions(barKey, buttonIndex, buttonDB, buttonsOptions[buttonIndex])
	end
	-- Trim excess
	for buttonIndex = # self.db.profile.bars[barKey].buttons + 1, # buttonsOptions, 1 do
		buttonsOptions[buttonIndex] = nil
	end

	return barOptions
end
--/dump AutoBar.db.profile.bars["AutoBarClassBarBasic"].buttons
--/dump AutoBar.db.profile.bars["AutoBarClassBarDruid"].buttons

function AutoBar:CreateButtonOptions(barKey, buttonIndex, buttonDB, existingConfig)
	local name = AutoBarButton:GetDisplayName(buttonDB)

	if (buttonDB.buttonClass == "AutoBarButtonCustom") then
	end

	local passValue
	if (existingConfig) then
		passValue = existingConfig.args.enabled.passValue
		passValue["barKey"] = barKey
		passValue["buttonIndex"] = buttonIndex
	else
		passValue = {["barKey"] = barKey, ["buttonIndex"] = buttonIndex}
		existingConfig = {
			order = buttonIndex,
			name = name,
			desc = L["Configuration for %s"]:format(name),
			type = "group",
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = L["Enabled"],
					desc = L["Enable %s."]:format(name),
					get = getEnabled,
					set = setEnabled,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				arrangeOnUse = {
					type = "toggle",
					order = 3,
					name = L["Rearrange Order on Use"],
					desc = L["Rearrange Order on Use for %s"]:format(name),
					get = getArrangeOnUse,
					set = setArrangeOnUse,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				hide = {
					type = "toggle",
					order = 4,
					name = L["Hide"],
					desc = L["Hide %s"]:format(name),
					get = getHide,
					set = setHide,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				noPopup = {
					type = "toggle",
					order = 5,
					name = L["No Popup"],
					desc = L["No Popup for %s"]:format(name),
					get = getNoPopup,
					set = setNoPopup,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				alwaysShow = {
					type = "toggle",
					order = 6,
					name = L["Always Show"],
					desc = L["Always Show %s, even if empty."]:format(name),
					get = getAlwaysShow,
					set = setAlwaysShow,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				rightClickTargetsPet = {
					type = "toggle",
					order = 7,
					name = L["Right Click Targets Pet"],
					desc = L["Right Click Targets Pet"],
					get = getRightClickTargetsPet,
					set = setRightClickTargetsPet,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				buttonOrder = {
					type = "range",
					order = 8,
					name = L["Order"],
					desc = L["Change the order of %s in the Bar"],
					min = 1, max = MAXBARBUTTONS, step = 1, bigStep = 1,
					get = getOrder,
					set = setOrder,
					finalSetOnly = true,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
			},
		}
	end

	-- Delete option for Custom Buttons
	if (buttonDB.buttonClass == "AutoBarButtonCustom") then
		if (not existingConfig.args.delete) then
			existingConfig.args.delete = {
			    type = "execute",
				order = 14,
			    name = L["Delete"],
			    desc = L["Delete"],
			    func = ButtonDelete,
				passValue = passValue,
				disabled = getCombatLockdown,
			}
		end
	end

	if (buttonDB.hasCustomCategories) then
--AutoBar:Print("AutoBar:CreateButtonOptions hasCustomCategories " .. barKey .. " buttonDB " .. buttonIndex .. " buttonDB " .. tostring(buttonDB))
		if (not existingConfig.args.categories) then
			existingConfig.args.categories = {
				type = "group",
				order = 15,
				name = L["Categories"],
				desc = L["Categories for %s"]:format(name),
				args = {
					newCategory = {
					    type = "execute",
					    name = L["New"],
					    desc = L["New"],
					    func = CategoryAdd,
						passValue = passValue,
					},
				}
			}
		end
		self:CreateButtonCategoryOptions(barKey, buttonIndex, existingConfig.args.categories.args)
	end
	return existingConfig
end


function AutoBar:CreateButtonCategoryOptions(barKey, buttonIndex, categoryOptions)
--AutoBar:Print("AutoBar:CreateButtonCategoryOptions barKey " .. barKey .. " buttonIndex " .. tostring(buttonIndex))
	if (not AutoBarCategoryList) then
		return
	end
	for categoryIndex, categoryKey in ipairs(self.db.profile.bars[barKey].buttons[buttonIndex]) do
		local categoryInfo = AutoBarCategoryList[categoryKey]
		if (not categoryInfo) then
			-- Missing Category, change to Misc.Hearth
			-- ToDo: or maybe some kind of blank category?
			categoryInfo = AutoBarCategoryList["Misc.Hearth"]
		end
		if (not categoryInfo) then
			return
		end

		local name = categoryInfo.description or L["Custom"]
		local passValue
		if (categoryOptions[categoryIndex]) then
			passValue = categoryOptions[categoryIndex].args.categories.passValue
		else
			passValue = {["barKey"] = barKey, ["buttonIndex"] = buttonIndex, ["categoryIndex"] = categoryIndex, ["categoryKey"] = categoryKey}
			categoryOptions[categoryIndex] = {
				order = categoryIndex,
				name = name,
				desc = L["Categories for %s"]:format(name),
				type = "group",
				args = {
					categories = {
					    type = 'text',
					    name = "Category",
					    desc = "Category",
						get = getButtonCategory,
						set = setButtonCategory,
						columns = 3,
					    validate = AutoBar.categoryValidateList,
						passValue = passValue,
					},
					delete = {
					    type = "execute",
					    name = L["Delete"],
					    desc = L["Delete"],
					    func = CategoryRemove,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
				},
			}
		end
		passValue.buttonIndex = buttonIndex
	end

	-- Trim excess
	for categoryIndex = # self.db.profile.bars[barKey].buttons[buttonIndex] + 1, # categoryOptions, 1 do
		categoryOptions[categoryIndex] = nil
	end
end



-- Create CustomCategoryOptions for those that do not exist yet
-- Also refresh the item list for each
function AutoBar:CreateCustomCategoryOptions(options)
	if (not self.db.account.customCategories) then
		return
	end
	for categoryIndex, categoryDB in ipairs(self.db.account.customCategories) do
		local name = categoryDB.name or L["Custom"]
		if (not options[categoryIndex]) then
			options[categoryIndex] = {
				order = categoryIndex,
				name = name,
				desc = L["Configuration for %s"]:format(name),
				type = "group",
				args = {
					name = {
						type = "text",
						order = 1,
						name = L["Name"],
						desc = L["Name"],
						usage = L["<Any String>"],
						get = getName,
						set = setName,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
					},
					arrangeOnUse = {
						type = "toggle",
						order = 2,
						name = L["Rearrange Order on Use"],
						desc = L["Rearrange Order on Use for %s"]:format(name),
						get = getArrangeOnUse,
						set = setArrangeOnUse,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
					},
					battleground = {
						type = "toggle",
						order = 3,
						name = L["Battlegrounds only"],
						desc = L["Battlegrounds only"],
						get = getBattleground,
						set = setBattleground,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
					},
					location = {
						type = "toggle",
						order = 4,
						name = L["Location"],
						desc = L["Location"],
						get = getLocation,
						set = setLocation,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
					},
					nonCombat = {
						type = "toggle",
						order = 5,
						name = L["Non Combat Only"],
						desc = L["Non Combat Only"],
						get = getNonCombat,
						set = setNonCombat,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
					},
					notUsable = {
						type = "toggle",
						order = 6,
						name = L["Not directly usable"],
						desc = L["Not directly usable"],
						get = getNotUsable,
						set = setNotUsable,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
					},
					targeted = {
						type = "toggle",
						order = 7,
						name = L["Targeted"],
						desc = L["Targeted"],
						get = getTargeted,
						set = setTargeted,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
	--ToDo: targeted = false,"PET", shield & chest etc
					},
					delete = {
					    type = "execute",
						order = 9,
					    name = L["Delete"],
					    desc = L["Delete"],
					    func = CategoryDelete,
						passValue = {["categoryIndex"] = categoryIndex},
						disabled = getCombatLockdown,
					},
					items = {
						type = "group",
						order = 10,
						name = L["Items"],
						desc = L["Items"],
						args = {
							newItem = {
							    type = "execute",
							    name = L["New"],
							    desc = L["New"],
							    func = ItemNew,
								passValue = {["categoryIndex"] = categoryIndex},
							},
						},
					},
				},
			}
		end
		local items = options[categoryIndex].args.items.args
		for itemIndex, itemDB in ipairs(self.db.account.customCategories[categoryIndex].items) do
			local name
			if (itemDB.itemType == "item") then
				if (itemDB.itemId and itemDB.itemId ~= 0) then
					name = GetItemInfo(itemDB.itemId)
				end
			end
			if (itemDB.itemType == "spell") then
				if (itemDB.spellName) then
					name = BS[itemDB.spellName]
				end
			end
			if (not name) then
				name = tostring(itemIndex)
			end

			local passValue
			if (not items[itemIndex]) then
				passValue = {["categoryIndex"] = categoryIndex, ["itemIndex"] = itemIndex,}
				items[itemIndex] = {
					order = itemIndex,
					type = "group",
					name = name,
					desc = name,
					args = {
						itemLink = {
							type = "dragLink",
							order = 1,
							name = L["Item"],
							desc = L["Item"],
							linkInfo = itemDB,
							get = getCategoryItem,
							set = setCategoryItem,
							passValue = {["categoryIndex"] = categoryIndex, ["itemIndex"] = itemIndex,},
							disabled = getCombatLockdown,
--							icon = LBS:GetSpellIcon("Create Healthstone"),
--							iconWidth = 36,
--							iconHeight = 36,
						},
						delete = {
						    type = "execute",
							order = 3,
						    name = L["Delete"],
						    desc = L["Delete"],
						    func = ItemDelete,
							passValue = {["categoryIndex"] = categoryIndex, ["itemIndex"] = itemIndex},
							disabled = getCombatLockdown,
						},
						head5 = {
							order = 5,
							type = "header",
						},
					}
				}
			else
				items[itemIndex].name = name
				items[itemIndex].desc = name
				items[itemIndex].args.itemLink.linkInfo = itemDB.itemType
				items[itemIndex].args.itemLink.passValue.categoryIndex = categoryIndex
				items[itemIndex].args.itemLink.passValue.itemIndex = itemIndex
			end
		end
	end

	-- Trim excess
	for categoryIndex = # self.db.account.customCategories + 1, # options, 1 do
		options[categoryIndex] = nil
	end
end
-- /dump AutoBar.options.args.categories.args[1]
-- /dump AutoBar.db.account.customCategories
-- /script AutoBar.db.account.customCategories[3] = nil


local ROW_COLUMN_MAX = 32

function AutoBar:InitializeDefaults()
	self.defaults = {
		name = "Spambelly",
		guiName = "Spambelly",
		alignButtons = "3",
		alpha = 1,
		frameLocked = false,
		showCount = true,
		showHotkey = true,
		showTooltip = true,
		showMacrotext = true,
		performance = false,
		selfCastRightClick = true,
		showEmptyButtons = false,
		sticky = true,
		style = "Dreamlayout",
		bars = {
			["AutoBarClassBarBasic"] = {
				enabled = true,
				rows = 1,
				columns = ROW_COLUMN_MAX,
				alignButtons = "3",
				alpha = 1,
				buttonWidth = 36,
				buttonHeight = 36,
				collapseButtons = true,
				docking = nil,
				dockShiftX = 0,
				dockShiftY = 0,
				fadeOut = false,
				frameStrata = "LOW",
				hide = false,
				padding = 0,
				popupDirection = "1",
				scale = 1,
				showGrid = false,
				showOnModifier = nil,
				position = {x = 300, y = 300},
				buttons = {},
			},
			["AutoBarClassBarDruid"] = {
				enabled = (AutoBar.CLASS == "DRUID"),
				rows = 1,
				columns = ROW_COLUMN_MAX,
				alignButtons = "3",
				alpha = 1,
				buttonWidth = 36,
				buttonHeight = 36,
				collapseButtons = true,
				docking = nil,
				dockShiftX = 0,
				dockShiftY = 0,
				fadeOut = false,
				frameStrata = "LOW",
				hide = false,
				padding = 0,
				popupDirection = "1",
				scale = 1,
				showGrid = false,
				showOnModifier = nil,
				position = {x = 300, y = 300},
				DRUID = true,
				buttons = {},
			},
		}
	}
	self:RegisterDefaults('profile', self.defaults)

	self.defaultPositions = {
		["AutoBarClassBarBasic"] = {
			posX = 300,
			posY = 200,
			anchor = "BOTTOMLEFT",
		},
		["AutoBarClassBarDruid"] = {
			posX = 300,
			posY = 280,
			anchor = "BOTTOMLEFT",
		},
	}

	self.defaultChar = {}

	self.defaultChar.buttons = {
		AutoBarButtonBear = {
			name = "AutoBarButtonBear",
			buttonClass = "AutoBarButtonBear",
			defaultBar = "AutoBarClassBarDruid",
			defaultButtonIndex = 1,
			place = true,
			enabled = true,
			isChecked = true,
			noPopup = true,
		},
		AutoBarButtonCat = {
			name = "AutoBarButtonCat",
			buttonClass = "AutoBarButtonCat",
			defaultBar = "AutoBarClassBarDruid",
			defaultButtonIndex = 2,
			place = true,
			enabled = true,
			isChecked = true,
			noPopup = true,
		},
		AutoBarButtonTravel = {
			name = "AutoBarButtonTravel",
			buttonClass = "AutoBarButtonTravel",
			defaultBar = "AutoBarClassBarDruid",
			defaultButtonIndex = 3,
			place = true,
			enabled = true,
			isChecked = true,
			noPopup = true,
		},
		AutoBarButtonBoomkinTree = {
			name = "AutoBarButtonBoomkinTree",
			buttonClass = "AutoBarButtonBoomkinTree",
			defaultBar = "AutoBarClassBarDruid",
			defaultButtonIndex = 4,
			place = true,
			enabled = true,
			isChecked = true,
			noPopup = true,
		},
		AutoBarButtonER = {
			name = "AutoBarButtonER",
			buttonClass = "AutoBarButtonER",
			defaultBar = "AutoBarClassBarDruid",
			defaultButtonIndex = 5,
			place = true,
			enabled = true,
			isChecked = true,
			noPopup = true,
		},
		AutoBarButtonStealth = {
			name = "AutoBarButtonStealth",
			buttonClass = "AutoBarButtonStealth",
			defaultBar = "AutoBarClassBarDruid",
			defaultButtonIndex = 6,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonHearth = {
			name = "AutoBarButtonHearth",
			buttonClass = "AutoBarButtonHearth",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 1,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonMount = {
			name = "AutoBarButtonMount",
			buttonClass = "AutoBarButtonMount",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 2,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonBandages = {
			name = "AutoBarButtonBandages",
			buttonClass = "AutoBarButtonBandages",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 3,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonHeal = {
			name = "AutoBarButtonHeal",
			buttonClass = "AutoBarButtonHeal",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 4,
			place = true,
			enabled = false,
			isChecked = true,
		},
		AutoBarButtonRecovery = {
			name = "AutoBarButtonRecovery",
			buttonClass = "AutoBarButtonRecovery",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 5,
			place = true,
			enabled = false,
			isChecked = true,
		},
		AutoBarButtonCooldownPotionHealth = {
			name = "AutoBarButtonCooldownPotionHealth",
			buttonClass = "AutoBarButtonCooldownPotionHealth",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 6,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonCooldownPotionMana = {
			name = "AutoBarButtonCooldownPotionMana",
			buttonClass = "AutoBarButtonCooldownPotionMana",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 7,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonCooldownPotionRejuvenation = {
			name = "AutoBarButtonCooldownPotionRejuvenation",
			buttonClass = "AutoBarButtonCooldownPotionRejuvenation",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 8,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonCooldownStoneHealth = {
			name = "AutoBarButtonCooldownStoneHealth",
			buttonClass = "AutoBarButtonCooldownStoneHealth",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 9,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonCooldownStoneMana = {
			name = "AutoBarButtonCooldownStoneMana",
			buttonClass = "AutoBarButtonCooldownStoneMana",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 10,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonCooldownStoneRejuvenation = {
			name = "AutoBarButtonCooldownStoneRejuvenation",
			buttonClass = "AutoBarButtonCooldownStoneRejuvenation",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 11,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonFood = {
			name = "AutoBarButtonFood",
			buttonClass = "AutoBarButtonFood",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 12,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonFoodBuff = {
			name = "AutoBarButtonFoodBuff",
			buttonClass = "AutoBarButtonFoodBuff",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 13,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonFoodCombo = {
			name = "AutoBarButtonFoodCombo",
			buttonClass = "AutoBarButtonFoodCombo",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 14,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonBuff = {
			name = "AutoBarButtonBuff",
			buttonClass = "AutoBarButtonBuff",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 15,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonBuffWeapon1 = {
			name = "AutoBarButtonBuffWeapon1",
			buttonClass = "AutoBarButtonBuffWeapon",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 16,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonSpeed = {
			name = "AutoBarButtonSpeed",
			buttonClass = "AutoBarButtonSpeed",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 17,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonFreeAction = {
			name = "AutoBarButtonFreeAction",
			buttonClass = "AutoBarButtonFreeAction",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 18,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonExplosive = {
			name = "AutoBarButtonExplosive",
			buttonClass = "AutoBarButtonExplosive",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 19,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonFishing = {
			name = "AutoBarButtonFishing",
			buttonClass = "AutoBarButtonFishing",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 20,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonPets = {
			name = "AutoBarButtonPets",
			buttonClass = "AutoBarButtonPets",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 21,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonBattleStandards = {
			name = "AutoBarButtonBattleStandards",
			buttonClass = "AutoBarButtonBattleStandards",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 22,
			place = true,
			enabled = true,
			isChecked = true,
		},
		AutoBarButtonQuest = {
			name = "AutoBarButtonQuest",
			buttonClass = "AutoBarButtonQuest",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 23,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonElixirBattle = {
			name = "AutoBarButtonElixirBattle",
			buttonClass = "AutoBarButtonElixirBattle",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 24,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonElixirGuardian = {
			name = "AutoBarButtonElixirGuardian",
			buttonClass = "AutoBarButtonElixirGuardian",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 25,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonElixirBoth = {
			name = "AutoBarButtonElixirBoth",
			buttonClass = "AutoBarButtonElixirBoth",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 26,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonCrafting = {
			name = "AutoBarButtonCrafting",
			buttonClass = "AutoBarButtonCrafting",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 27,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonTrack = {
			name = "AutoBarButtonTrack",
			buttonClass = "AutoBarButtonTrack",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 28,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonTrinket1 = {
			name = "AutoBarButtonTrinket1",
			buttonClass = "AutoBarButtonTrinket1",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 29,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
		AutoBarButtonTrinket2 = {
			name = "AutoBarButtonTrinket2",
			buttonClass = "AutoBarButtonTrinket2",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = 30,
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		},
	}

	if (AutoBar.CLASS == "HUNTER" or AutoBar.CLASS == "ROGUE" or AutoBar.CLASS == "SHAMAN" or AutoBar.CLASS == "WARRIOR") then
		self.defaultChar.buttons["AutoBarButtonBuffWeapon2"] = {
			name = "AutoBarButtonBuffWeapon2",
			buttonClass = "AutoBarButtonBuffWeapon",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
			invertButtons = true,
		}
	end

	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		self.defaultChar.buttons["AutoBarButtonWater"] = {
			name = "AutoBarButtonWater",
			buttonClass = "AutoBarButtonWater",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "AutoBarButtonFood",
			place = true,
			enabled = true,
			isChecked = true,
		}

		self.defaultChar.buttons["AutoBarButtonWaterBuff"] = {
			name = "AutoBarButtonWaterBuff",
			buttonClass = "AutoBarButtonWaterBuff",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "AutoBarButtonWater",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}
	end

	if (AutoBar.CLASS == "HUNTER") then
		self.defaultChar.buttons["AutoBarButtonFoodPet"] = {
			name = "AutoBarButtonFoodPet",
			buttonClass = "AutoBarButtonFoodPet",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
			rightClickTargetsPet = true,
		}
		self.defaultChar.buttons["AutoBarButtonTrap"] = {
			name = "AutoBarButtonTrap",
			buttonClass = "AutoBarButtonTrap",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}
		self.defaultChar.buttons["AutoBarButtonSting"] = {
			name = "AutoBarButtonSting",
			buttonClass = "AutoBarButtonSting",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}
	end

	if (AutoBar.CLASS == "MAGE" or AutoBar.CLASS == "WARLOCK") then
		self.defaultChar.buttons["AutoBarButtonConjure"] = {
			name = "AutoBarButtonConjure",
			buttonClass = "AutoBarButtonConjure",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
		}
	end

	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR" and AutoBar.CLASS ~= "PALADIN") then
		self.defaultChar.buttons["AutoBarButtonClassPet"] = {
			name = "AutoBarButtonClassPet",
			buttonClass = "AutoBarButtonClassPet",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
		}
	end

	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "HUNTER" and AutoBar.CLASS ~= "SHAMAN" and AutoBar.CLASS ~= "WARLOCK") then
		self.defaultChar.buttons["AutoBarButtonClassBuff"] = {
			name = "AutoBarButtonClassBuff",
			buttonClass = "AutoBarButtonClassBuff",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
		}
	end

	if (AutoBar.CLASS == "HUNTER" or AutoBar.CLASS == "PALADIN") then
		self.defaultChar.buttons["AutoBarButtonAura"] = {
			name = "AutoBarButtonAura",
			buttonClass = "AutoBarButtonAura",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}
	end

	if (AutoBar.CLASS == "ROGUE") then
		self.defaultChar.buttons["AutoBarButtonPickLock"] = {
			name = "AutoBarButtonPickLock",
			buttonClass = "AutoBarButtonPickLock",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
			targeted = "Lockpicking",
		}
	end

	if (AutoBar.CLASS == "SHAMAN") then
		self.defaultChar.buttons["AutoBarButtonTotemEarth"] = {
			name = "AutoBarButtonTotemEarth",
			buttonClass = "AutoBarButtonTotemEarth",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}

		self.defaultChar.buttons["AutoBarButtonTotemAir"] = {
			name = "AutoBarButtonTotemAir",
			buttonClass = "AutoBarButtonTotemAir",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}

		self.defaultChar.buttons["AutoBarButtonTotemFire"] = {
			name = "AutoBarButtonTotemFire",
			buttonClass = "AutoBarButtonTotemFire",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}

		self.defaultChar.buttons["AutoBarButtonTotemWater"] = {
			name = "AutoBarButtonTotemWater",
			buttonClass = "AutoBarButtonTotemWater",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
			arrangeOnUse = true,
		}
	end

	if (AutoBar.CLASS == "WARRIOR") then
		self.defaultChar.buttons["AutoBarButtonStance"] = {
			name = "AutoBarButtonStance",
			buttonClass = "AutoBarButtonStance",
			defaultBar = "AutoBarClassBarBasic",
			defaultButtonIndex = "*",
			place = true,
			enabled = true,
			isChecked = true,
		}
	end

	self:RegisterDefaults('char', self.defaultChar)
end

function AutoBar:ButtonExists(barDB, targetButtonDB)
	for buttonDBIndex, buttonDB in ipairs(barDB.buttons) do
		if (buttonDB.name == targetButtonDB.name) then
			return true
		end
	end
	return false
end

function AutoBar:ButtonInsert(barDB, buttonDB)
	for buttonDBIndex, aButtonDB in ipairs(barDB.buttons) do
		if (aButtonDB.name == buttonDB.defaultButtonIndex) then
--AutoBar:Print("AutoBar:ButtonInsert buttonDBIndex + 1 " .. tostring(buttonDBIndex + 1) .. " " .. tostring(buttonDB.name) .. " # barDB.Buttons " .. tostring(# barDB.buttons))
			table.insert(barDB.buttons, buttonDBIndex + 1, AutoBar:ButtonPopulate(buttonDB))
--AutoBar:Print("AutoBar:ButtonInsert # barDB.Buttons " .. tostring(# barDB.buttons))
			return nil
		end
	end
	return buttonDB
end

function AutoBar:BarsCompact()
	local barDBList = AutoBar:GetDB().bars
	for barKey in pairs(barDBList) do
		local buttonDBList = AutoBar:GetDB(barKey).buttons
		local badIndexMax = nil
		for buttonDBIndex, buttonDB in pairs(buttonDBList) do
			if (buttonDBIndex > 1 and buttonDBList[buttonDBIndex - 1] == nil) then
				badIndexMax = buttonDBIndex
			end
			buttonDB.order = buttonDBIndex
		end
		if (badIndexMax) then
--AutoBar:Print("AutoBar:BarsCompact badIndexMax " .. tostring(badIndexMax))
			local source = 0
			local sink = 1
			local sinkButtonDB, sourceButtonDB
			while true do
				sinkButtonDB = buttonDBList[sink]
				if (sinkButtonDB) then
					sink = sink + 1
				else
					if (source < sink) then
						source = sink + 1
					end
					while source <= badIndexMax do
						sourceButtonDB = buttonDBList[source]
						if (sourceButtonDB) then
							-- Move it
							buttonDBList[sink] = sourceButtonDB
							buttonDBList[source] = nil
							sourceButtonDB.order = sink
							sink = sink + 1
							source = source + 1
							break
						else
							source = source + 1
						end
					end
				end
				if (source > badIndexMax or sink > badIndexMax) then
					break
				end
			end
		end
	end
end

function AutoBar:ButtonPopulate(buttonDB)
	newButtonDB = {}
	-- ToDo: Upgrade if there is ever a table inside
	for key, value in pairs(buttonDB) do
		newButtonDB[key] = value
	end
	buttonDB.place = false

	newButtonDB.defaultBar = nil
	newButtonDB.defaultButtonIndex = nil
	newButtonDB.place = nil
	newButtonDB.deleted = nil
--AutoBar:Print("AutoBar:ButtonPopulate " .. tostring(newButtonDB.name))
	return newButtonDB
end

local insertList = {}
local appendList = {}

-- Clone the default buttons into the profile if necessary
-- if ignorePlace then ignore previous placement
function AutoBar:PopulateBars(ignorePlace)
--assert(AutoBar:CorruptionCheck(), "AutoBar:PopulateBars start failed CorruptionCheck")
	local barDBList = AutoBar:GetDB().bars
	local barDB, buttonIndex
	for index in pairs(insertList) do
		insertList[index] = nil
	end
	for index in pairs(appendList) do
		appendList[index] = nil
	end
--AutoBar:Print("AutoBar:PopulateBars AutoBarClassBarBasic " .. tostring(# AutoBar.db.profile.bars["AutoBarClassBarBasic"].buttons))
	for buttonName, buttonDB in pairs(self.db.char.buttons) do
		barDB = barDBList[buttonDB.defaultBar]
		if (barDB and (buttonDB.place or ignorePlace) and not buttonDB.deleted and not AutoBar:ButtonExists(barDB, buttonDB)) then
			buttonIndex = nil
			if (type(buttonDB.defaultButtonIndex) == "number") then
				buttonIndex = tonumber(buttonDB.defaultButtonIndex)
			elseif (type(buttonDB.defaultButtonIndex) == "string") then
				-- "*" append, "~" do not place, "buttonName" insert after the button
				if (buttonDB.defaultButtonIndex == "*") then
--AutoBar:Print("AutoBar:PopulateBars # appendList + 1 " .. tostring(# appendList + 1) .. " " .. tostring(buttonDB.name) .. " buttonName " .. tostring(buttonName))
					appendList[# appendList + 1] = buttonDB
				elseif (buttonDB.defaultButtonIndex == "~") then
				else
					insertList[# insertList + 1] = buttonDB
				end
			end
			if (buttonIndex) then
				if (barDB.buttons[buttonIndex]) then
					appendList[# appendList + 1] = buttonDB
				else
					barDB.buttons[buttonIndex] = AutoBar:ButtonPopulate(buttonDB)
					barDB.buttons[buttonIndex].order = buttonIndex
--AutoBar:Print("AutoBar:PopulateBars buttonIndex " .. tostring(buttonIndex) .. " " .. tostring(buttonDB.name) .. " buttonName " .. tostring(buttonName))
				end
			end
		end
	end
	AutoBar:BarsCompact()
	for index, buttonDB in ipairs(insertList) do
		barDB = barDBList[buttonDB.defaultBar]
		local couldNotInsertDB = AutoBar:ButtonInsert(barDB, buttonDB)
		if (couldNotInsertDB) then
			appendList[# appendList + 1] = couldNotInsertDB
		end
	end
--AutoBar:Print("AutoBar:BarsCompact ")
	for index, buttonDB in ipairs(appendList) do
		barDB = barDBList[buttonDB.defaultBar]
		local nButtons = # barDB.buttons + 1
		barDB.buttons[nButtons] = AutoBar:ButtonPopulate(buttonDB)
		barDB.buttons[nButtons].order = nButtons
--AutoBar:Print("AutoBar:PopulateBars append nButtons " .. tostring(nButtons) .. " " .. tostring(buttonDB.name))
	end
--assert(AutoBar:CorruptionCheck(), "AutoBar:PopulateBars end failed CorruptionCheck")
--AutoBar:Print("AutoBar:PopulateBars AutoBarClassBarBasic " .. tostring(# AutoBar.db.profile.bars["AutoBarClassBarBasic"].buttons))
end

-- /dump AutoBar.options.args.bars.args["AutoBarClassBarBasic"].args.buttons.args[1]
-- /dump AutoBar.db.profile.bars["AutoBarClassBarBasic"].buttons
-- /dump (# AutoBar.db.profile.bars["AutoBarClassBarBasic"].buttons)
-- /dump AutoBar.options.args.categories
-- /dump LibStub:GetLibrary("LibBabble-Spell-3.0", true):GetSpellIcon("Prospecting")
--AutoBar:Print("AutoBar:DragStop" .. frame:GetName() .. " x/y " .. tostring().. " / " ..tostring())
-- /script AutoBar.db.account.customCategories = nil


-- Upgrade from old DB versions
function AutoBar:UpgradeVersion()
--	if (not AutoBar.db.profile.version) then
--		local barDBList = AutoBar:GetDB().bars
--		for barKey in pairs(barDBList) do
--			local buttonDBList = AutoBar:GetDB(barKey).buttons
--			for buttonDBIndex in pairs(buttonDBList) do
--				buttonDBList[buttonDBIndex] = nil
--			end
--		end
--		AutoBar.db.profile.version = 1
--	end
end
