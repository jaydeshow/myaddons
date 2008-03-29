--
-- AutoBarProfile
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Categories for AutoBar
-- A Category encapsulates a list of items / spells etc. along with metadata describing their use.
-- http://code.google.com/p/autobar/
--

--	PeriodicGroup
--		description
--		texture
--		targeted
--		nonCombat
--		location
--		battleground
--		notUsable (soul shards, arrows, etc.)
--		flying

--	AutoBar
--		arrangeOnUse

--		spell
--		limit

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 55356 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end


AutoBarCategoryList = {}

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")
local PT = LibStub("LibPeriodicTable-3.1")
local LBS = LibStub("LibBabble-Spell-3.0")
local BS = LBS:GetLookupTable()
local BZ = AceLibrary:GetInstance("Babble-Zone-2.2")
local AceOO = AceLibrary("AceOO-2.0")

-- List of categoryKey, category.description pairs for button categories
AutoBar.categoryValidateList = {}


local function sortList(a, b)
	local x = tonumber(a[2]);
	local y = tonumber(b[2]);

	if (x == y) then
		if (a[3]) then
			return false;
		else
			if (b[3]) then
				return true;
			else
				return false;
			end
		end
	else
		return x < y;
	end
end


local function castListPairs(castList)
	local i = -1

	return function ()
		i = i + 2
		if (castList[i]) then
			return i, castList[i], castList[i + 1]
		end
	end
end


-- Mandatory attributes:
--		description - localized description
--		texture - display icon texture
-- Optional attributes:
--		arrangeOnUse, targeted, nonCombat, location, battleground, notUsable
AutoBarCategory = AceOO.Class()
AutoBarCategory.virtual = true -- this means that it cannot be instantiated. (cannot call :new())

function AutoBarCategory.prototype:init(description, texture)
	AutoBarCategory.super.prototype.init(self) -- very important. Will fail without this.
	self.categoryKey = description

	if (L:HasTranslation(description)) then
		self.description = L[description]
	else
		self.description = description
		self.customKey = "Custom." .. description
--AutoBar:Print("AutoBarCategory customKey " .. tostring(self.customKey))
	end
	self.texture = texture
end

-- True if an item gets arranged to the top on use
function AutoBarCategory.prototype:SetArrangeOnUse(arrangeOnUse)
	self.arrangeOnUse = arrangeOnUse
end

-- True if an item gets arranged to the top on use
function AutoBarCategory.prototype:GetArrangeOnUse()
	return self.arrangeOnUse
end

-- Move item to the top (end) of list
function AutoBarCategory.prototype:ArrangeOnUse(itemId)
	local swapItemId, categoryIndexA, categoryIndexB

--AutoBar:Print("AutoBarCategory.prototype:ArrangeOnUse " .. tostring(self.description) .. " itemId " .. tostring(itemId))
	local itemList = self.items
	categoryIndexB = # itemList
	for i, categoryItemId in ipairs(itemList) do
--AutoBar:Print("arrangeOnUse ".. i .. " / " .. categoryItemId .. " categoryIndexB " .. categoryIndexB)
		if (categoryItemId == itemId and i ~= categoryIndexB) then
			categoryIndexA = i
			swapItemId = itemList[categoryIndexB]
			itemList[i] = swapItemId
			itemList[categoryIndexB] = itemId
--AutoBar:Print("arrangeOnUse i " .. tostring(i) .. " itemList[i] " .. tostring(itemList[i]))
--AutoBar:Print("arrangeOnUse categoryIndexB " .. tostring(categoryIndexB) .. " itemList[categoryIndexB] " .. tostring(itemList[categoryIndexB]))
			break
		end
	end
	if (self.castList) then
		local castList = self.castList
		categoryIndexB = # castList - 1
		for i, spellClass, spellName in castListPairs(castList) do
--	AutoBar:Print("arrangeOnUse ".. i .. " spellClass " .. spellClass .. " spellName " .. spellName)
			if (spellName and spellName == itemId and i ~= categoryIndexB) then
				castList[i], castList[categoryIndexB] = castList[categoryIndexB], castList[i]
				castList[i + 1], castList[categoryIndexB + 1] = castList[categoryIndexB + 1], castList[i + 1]
	--AutoBar:Print("arrangeOnUse i " .. tostring(i) .. " castList[i] " .. tostring(castList[i]))
	--AutoBar:Print("arrangeOnUse categoryIndexB " .. tostring(categoryIndexB) .. " castList[categoryIndexB] " .. tostring(castList[categoryIndexB]))
				break
			end
		end
	end

	return categoryIndexA, categoryIndexB, swapItemId
end
--/dump AutoBarCategoryList["Custom.XXX"]

-- True if items can be targeted
function AutoBarCategory.prototype:SetTargeted(targeted)
	self.targeted = targeted
end

-- True if only usable outside combat
function AutoBarCategory.prototype:SetNonCombat(nonCombat)
	self.nonCombat = nonCombat
end

-- True if item is location specific
function AutoBarCategory.prototype:SetLocation(location)
	self.location = location
end

-- True if item is for battlegrounds only
function AutoBarCategory.prototype:SetBattleground(battleground)
	self.battleground = battleground
end

-- True if item is not usable (soul shards, arrows, etc.)
function AutoBarCategory.prototype:SetNotUsable(notUsable)
	self.notUsable = notUsable
end

-- Return nil or list of spells matching player class
-- itemsPerLine defaults to 2 (class type, spell).
-- Only supports 2 & 3 for now.
-- ToDo: generalize for more per line.
function AutoBarCategory:FilterClass(castList, itemsPerLine)
	local spellName, index, filteredList2, filteredList3
	if (not itemsPerLine) then
		itemsPerLine = 2
	end
--AutoBar:Print("AutoBarCategory:FilterClass castList " .. tostring(castList))

	-- Filter out CLASS spells from castList
	index = 1
	for i = 1, # castList, itemsPerLine do
--AutoBar:Print("AutoBarCategory:FilterClass spellName " .. tostring(castList[i+1]) .. " spellClass " .. tostring(castList[i]))
		if (AutoBar.CLASS == castList[i] or "*" == castList[i]) then
			spellName = castList[i + 1]
			if (not filteredList2) then
				filteredList2 = {}
			end
			if (itemsPerLine == 3 and not filteredList3) then
				filteredList3 = {}
			end
			filteredList2[index] = spellName
			if (itemsPerLine == 3) then
				spellName = castList[i + 2]
				filteredList3[index] = spellName
			end
			index = index + 1
		end
	end
	return filteredList2, filteredList3
end

-- Top castable item from castList will cast on RightClick
function AutoBarCategory.prototype:SetCastList(castList)
--AutoBar:Print("AutoBarCategory.prototype:SetCastList " .. description .. " castList " .. tostring(castList))
	if (castList) then
		self.spells = castList
		for index, spellName in ipairs(castList) do
--AutoBar:Print("AutoBarCategory.prototype:SetCastList " .. tostring(spellName))
			AutoBarSearch:RegisterSpell(spellName)
			if (AutoBarSearch:CanCastSpell(spellName)) then	-- TODO: update on leveling in case new spell aquired
--AutoBar:Print("AutoBarCategory.prototype:SetCastList castable " .. tostring(spellName))
				self.castSpell = spellName
			end
		end
	end
end

-- Called once to allocate space and initialize items
function AutoBarCategory.prototype:ItemsInit()
	self.items = nil
end

-- Reset the item list based on changed settings.
-- So pet change, Spellbook changed for spells, etc.
function AutoBarCategory.prototype:Refresh()
end



-- Category consisting of regular items, defined by PeriodicTable sets
AutoBarItems = AceOO.Class(AutoBarCategory)

-- ptItems, ptPriorityItems are PeriodicTable sets
-- priorityItems sort higher than items at the same value
function AutoBarItems.prototype:init(description, shortTexture, ptItems, ptPriorityItems)
	AutoBarItems.super.prototype.init(self, description, "Interface\\Icons\\" .. shortTexture) -- very important. Will fail without this.
	self.ptItems = ptItems
	self.ptPriorityItems = ptPriorityItems

	local rawList = nil
	rawList = self:RawItemsAdd(rawList, ptItems, false)
	if (ptPriorityItems) then
		rawList = self:RawItemsAdd(rawList, ptPriorityItems, true)
	end
	self.items = self:RawItemsConvert(rawList)
end

-- Reset the item list based on changed settings.
function AutoBarItems.prototype:Refresh()
end

-- Convert rawList to a simple array of itemIds, ordered by their value in the set, and priority if any
function AutoBarItems.prototype:RawItemsConvert(rawList)
	local itemArray = {}
	table.sort(rawList, sortList)
	for i, j in ipairs(rawList) do
		itemArray[i] = j[1]
	end
	return itemArray
end


-- Add items from set to rawList
-- If priority is true, the items will have priority over non-priority items with the same values
function AutoBarItems.prototype:RawItemsAdd(rawList, set, priority)
--AutoBar:Print("RawItemsAdd set " .. tostring(set).." priority ".. tostring(priority));
	if (not rawList) then
		rawList = {};
	end
	if (set) then
		local cacheSet = PT:GetSetTable(set);
		if (cacheSet) then
			local index = table.getn(rawList) + 1;
			for itemId, value in PT:IterateSet(set) do
				if (not value or type(value) == "boolean") then
					value = 0;
				end
				value = tonumber(value);
				rawList[index] = {itemId, value, priority};
				index = index + 1;
			end
		end
	end
	return rawList;
end



-- Category consisting of regular items
AutoBarPetFood = AceOO.Class(AutoBarItems)

-- ptItems, ptPriorityItems are PeriodicTable sets
-- priorityItems sort higher than items at the same value
function AutoBarPetFood.prototype:init(description, shortTexture, ptItems, ptPriorityItems)
	AutoBarPetFood.super.prototype.init(self, description, "Interface\\Icons\\" .. shortTexture, ptItems, ptPriorityItems)

	self.castSpell = BS["Feed Pet"];
end

-- Reset the item list based on changed settings.
function AutoBarPetFood.prototype:Refresh()
end


-- Category consisting of spells
AutoBarSpells = AceOO.Class(AutoBarCategory)

-- castList, is of the form:
-- { "DRUID", BS["Flight Form"], "DRUID", BS["Swift Flight Form"], ["<class>", "<localized spell name>",] ... }
-- rightClickList, is of the form:
-- { "DRUID", BS["Mark of the Wild"], BS["Gift of the Wild"], ["<class>", "<localized spell name left click>", "<localized spell name right click>",] ... }
-- Pass in only one of castList, rightClickList
-- Icon from castList is used unless not available but rightClickList is
function AutoBarSpells.prototype:init(description, shortTexture, castList, rightClickList, customCategoriesDB)
	AutoBarSpells.super.prototype.init(self, description, "Interface\\Icons\\" .. shortTexture) -- very important. Will fail without this.
	local spellName, index
--AutoBar:Print("AutoBarSpells.prototype:init " .. description .. " castList " .. tostring(castList))

	self.customCategoriesDB = customCategoriesDB

	-- Filter out non CLASS spells from castList and rightClickList
	if (castList) then
		self.castList = AutoBarCategory:FilterClass(castList)
	end
	if (rightClickList) then
		self.castList, self.rightClickList = AutoBarCategory:FilterClass(rightClickList, 3)
	end

	-- Populate items based on currently castable spells
	if (not self.items) then
		self.items = {}
	end
	if (self.rightClickList and not self.itemsRightClick) then
		self.itemsRightClick = {}
	end
	self:Refresh()
end

-- Reset the item list based on changed settings.
function AutoBarSpells.prototype:Refresh()
	local index = 1
	if (self.castList and self.rightClickList) then
		for spellNameLeft in pairs(self.itemsRightClick) do
			self.itemsRightClick[spellNameLeft] = nil
		end
		for i = 1, # self.castList, 1 do
			local spellNameLeft, spellNameRight = self.castList[i], self.rightClickList[i]
--AutoBar:Print("AutoBarSpells.prototype:Refresh spellNameLeft " .. tostring(spellNameLeft) .. " spellNameRight " .. tostring(spellNameRight))
			AutoBarSearch:RegisterSpell(spellNameLeft)
			AutoBarSearch:RegisterSpell(spellNameRight)
			if (AutoBarSearch:CanCastSpell(spellNameLeft)) then
				self.items[index] = spellNameLeft
				if (AutoBarSearch:CanCastSpell(spellNameRight)) then
					self.itemsRightClick[spellNameLeft] = spellNameRight
--AutoBar:Print("AutoBarSpells.prototype:Refresh castable spellNameLeft " .. tostring(spellNameLeft) .. " spellNameRight " .. tostring(spellNameRight))
				else
					self.itemsRightClick[spellNameLeft] = spellNameLeft
--AutoBar:Print("AutoBarSpells.prototype:Refresh castable spellNameLeft " .. tostring(spellNameLeft))
				end
				index = index + 1
			elseif (AutoBarSearch:CanCastSpell(spellNameRight)) then
--AutoBar:Print("AutoBarSpells.prototype:Refresh castable spellNameRight " .. tostring(spellNameRight))
				self.items[index] = spellNameRight
				self.itemsRightClick[spellNameRight] = spellNameRight
				index = index + 1
			end
		end
		for i = index, # self.items, 1 do
			self.items[i] = nil
		end
	elseif (self.castList) then
		for i, spellName in ipairs(self.castList) do
			if (spellName) then
--AutoBar:Print("AutoBarSpells.prototype:Refresh spellName " .. tostring(spellName))
				AutoBarSearch:RegisterSpell(spellName)
				if (AutoBarSearch:CanCastSpell(spellName)) then
--AutoBar:Print("AutoBarSpells.prototype:Refresh castable " .. tostring(spellName))
					self.items[index] = spellName
					index = index + 1
				end
			end
		end
		for i = index, # self.items, 1 do
			self.items[i] = nil
		end
	end
end



-- Custom Category
AutoBarCustom = AceOO.Class(AutoBarSpells)

-- ptItems, ptPriorityItems are PeriodicTable sets
-- priorityItems sort higher than items at the same value
function AutoBarCustom.prototype:init(customCategoriesDB)
	local description = customCategoriesDB.name
	local itemList = customCategoriesDB.items
	local itemType, itemId, itemInfo, spellName, spellClass, texture
	for index = # itemList, 1, -1 do
		local itemDB = itemList[index]
		itemType = itemDB.itemType
		itemId = itemDB.itemId
		itemInfo = itemDB.itemInfo
		spellName = itemDB.spellName
		spellClass = itemDB.spellClass
		if ((not spellClass) or (spellClass == AutoBar.CLASS)) then
			break
		end
	end
	if (itemType == "item") then
		texture = AutoBar:GetTexture(itemId)
	elseif (itemType == "spell") then
		texture = AutoBar:GetTexture(spellName, itemType, itemInfo)
	else
		texture = "Interface\\Icons\\INV_Misc_Gift_01"
	end

	AutoBarCustom.super.prototype.init(self, description, texture, nil, nil, customCategoriesDB)
--AutoBar:Print("AutoBarCustom.prototype:init customCategoriesDB " .. tostring(customCategoriesDB) .. " self.customCategoriesDB " .. tostring(self.customCategoriesDB))
	self:Refresh()
end

-- True if an item gets arranged to the top on use
function AutoBarCustom.prototype:GetArrangeOnUse()
	return self.customCategoriesDB.arrangeOnUse
end

-- If not used yet, change name to newName
-- Return the name in use either way
function AutoBarCustom.prototype:ChangeName(newName)
	if (not AutoBarCategoryList["Custom." .. newName]) then
		local oldCustomKey = self.customKey
		self.customKey = "Custom." .. newName
		AutoBarCategoryList[self.customKey] = AutoBarCategoryList[oldCustomKey]
		AutoBarCategoryList[oldCustomKey] = nil
		-- Update categoryValidateList
		AutoBar.categoryValidateList[self.customKey] = self.description
		AutoBar.categoryValidateList[oldCustomKey] = nil

		self.customCategoriesDB.name = newName
		self.description = newName
		self.categoryKey = newName	-- What the hell is this?
	end
	return self.customCategoriesDB.name
end
-- /dump AutoBarCategoryList["Custom.Custom"]
-- /dump AutoBarCategoryList["Custom.XXX"]


-- Return the unique name to use
function AutoBarCustom:GetNewName(baseName, index)
	local newKey = "Custom." .. baseName .. index
	while (AutoBarCategoryList[newKey]) do
		index = index + 1
		newKey = "Custom." .. baseName .. index
	end
	return baseName .. index
end


-- Reset the item list based on changed settings.
function AutoBarCustom.prototype:Refresh()
	local itemList = self.customCategoriesDB.items
	local itemType, itemId
	local itemsIndex = 1
	local castListIndex = 1

	for index, itemDB in ipairs(itemList) do
		itemType = itemDB.itemType
		itemId = itemDB.itemId
		if (itemType == "item") then
			if (not self.items) then
				self.items = {}
			end
			self.items[itemsIndex] = itemId
			itemsIndex = itemsIndex + 1
		elseif (itemType == "spell" and itemDB.spellName) then
			if (not self.castList) then
				self.castList = {}
			end
			self.castList[castListIndex] = itemDB.spellClass
			self.castList[castListIndex + 1] = itemDB.spellName
			castListIndex = castListIndex + 2
		end
	end

	-- Trim excess
	if (self.items) then
		for index = itemsIndex, # self.items, 1 do
			self.items[index] = nil
		end
	end
	if (self.castList) then
		for index = castListIndex, # self.castList, 2 do
			self.castList[index] = nil
			self.castList[index + 1] = nil
		end
	end

	if (self.castList) then
		AutoBarCategory:FilterClass(self.castList)
	end
--DevTools_Dump(self.itemList)
--DevTools_Dump(self.items)
--DevTools_Dump(self.castList)
	AutoBarCustom.super.prototype.Refresh(self)
end



-- Create category list using PeriodicTable data.
function AutoBarCategory:Initialize()
	AutoBarCategoryList["Misc.Hearth"] = AutoBarItems:new(
			"Misc.Hearth", "INV_Misc_Rune_01", "Misc.Hearth")

	AutoBarCategoryList["Consumable.Buff.Free Action"] = AutoBarItems:new(
			"Consumable.Buff.Free Action", "INV_Potion_04", "Consumable.Buff.Free Action")

	AutoBarCategoryList["Consumable.Anti-Venom"] = AutoBarItems:new(
			"Consumable.Anti-Venom", "INV_Drink_14", "Consumable.Anti-Venom")
	AutoBarCategoryList["Consumable.Anti-Venom"]:SetTargeted(true)

	AutoBarCategoryList["Misc.Battle Standard.Battleground"] = AutoBarItems:new(
			"Misc.Battle Standard.Battleground", "INV_BannerPVP_01", "Misc.Battle Standard.Battleground")
	AutoBarCategoryList["Misc.Battle Standard.Battleground"]:SetBattleground(true)

	AutoBarCategoryList["Misc.Battle Standard.Alterac Valley"] = AutoBarItems:new(
			"Misc.Battle Standard.Alterac Valley", "INV_BannerPVP_02", "Misc.Battle Standard.Alterac Valley")
	AutoBarCategoryList["Misc.Battle Standard.Alterac Valley"]:SetLocation(BZ["Alterac Valley"])

	AutoBarCategoryList["Reagent.Ammo.Arrow"] = AutoBarItems:new(
			"Reagent.Ammo.Arrow", "INV_Ammo_Arrow_02", "Reagent.Ammo.Arrow")
	AutoBarCategoryList["Reagent.Ammo.Arrow"]:SetNotUsable(true)

	AutoBarCategoryList["Reagent.Ammo.Bullet"] = AutoBarItems:new(
			"Reagent.Ammo.Bullet", "INV_Ammo_Bullet_02", "Reagent.Ammo.Bullet")
	AutoBarCategoryList["Reagent.Ammo.Bullet"]:SetNotUsable(true)

	AutoBarCategoryList["Reagent.Ammo.Thrown"] = AutoBarItems:new(
			"Reagent.Ammo.Thrown", "INV_Axe_19", "Reagent.Ammo.Thrown")
	AutoBarCategoryList["Reagent.Ammo.Thrown"]:SetNotUsable(true)

	AutoBarCategoryList["Misc.Explosives"] = AutoBarItems:new(
			"Misc.Explosives", "INV_Misc_Bomb_08", "Misc.Explosives")
	AutoBarCategoryList["Misc.Explosives"]:SetTargeted(true)

	AutoBarCategoryList["Misc.Engineering.Fireworks"] = AutoBarItems:new(
			"Misc.Engineering.Fireworks", "INV_Misc_MissileSmall_Red", "Misc.Engineering.Fireworks")
	AutoBarCategoryList["Misc.Engineering.Fireworks"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Gear"] = AutoBarItems:new(
			"Tradeskill.Tool.Fishing.Gear", "INV_Helmet_31", "Tradeskill.Tool.Fishing.Gear")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Lure"] = AutoBarItems:new(
			"Tradeskill.Tool.Fishing.Lure", "INV_Misc_Food_26", "Tradeskill.Tool.Fishing.Lure")
	AutoBarCategoryList["Tradeskill.Tool.Fishing.Lure"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Tool"] = AutoBarItems:new(
			"Tradeskill.Tool.Fishing.Tool", "INV_Fishingpole_01", "Tradeskill.Tool.Fishing.Tool")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Mana.Other"] = AutoBarItems:new(
			"Consumable.Cooldown.Stone.Mana.Other", "Spell_Shadow_SealOfKings", "Consumable.Cooldown.Stone.Mana.Other")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Health.Other"] = AutoBarItems:new(
			"Consumable.Cooldown.Stone.Health.Other", "INV_Misc_Food_55", "Consumable.Cooldown.Stone.Health.Other")

	AutoBarCategoryList["Consumable.Bandage.Basic"] = AutoBarItems:new(
			"Consumable.Bandage.Basic", "INV_Misc_Bandage_Netherweave_Heavy", "Consumable.Bandage.Basic")
	AutoBarCategoryList["Consumable.Bandage.Basic"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Bandage.Battleground.Alterac Valley"] = AutoBarItems:new(
			"Consumable.Bandage.Battleground.Alterac Valley", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Alterac Valley")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Alterac Valley"]:SetTargeted(true)
	AutoBarCategoryList["Consumable.Bandage.Battleground.Alterac Valley"]:SetLocation(BZ["Alterac Valley"])

	AutoBarCategoryList["Consumable.Bandage.Battleground.Arathi Basin"] = AutoBarItems:new(
			"Consumable.Bandage.Battleground.Arathi Basin", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Arathi Basin")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Arathi Basin"]:SetTargeted(true)
	AutoBarCategoryList["Consumable.Bandage.Battleground.Arathi Basin"]:SetLocation(BZ["Arathi Basin"])

	AutoBarCategoryList["Consumable.Bandage.Battleground.Warsong Gulch"] = AutoBarItems:new(
			"Consumable.Bandage.Battleground.Warsong Gulch", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Warsong Gulch")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Warsong Gulch"]:SetTargeted(true)
	AutoBarCategoryList["Consumable.Bandage.Battleground.Warsong Gulch"]:SetLocation(BZ["Warsong Gulch"])

	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"] = AutoBarItems:new(
			"Consumable.Food.Edible.Basic.Non-Conjured", "INV_Misc_Food_23", "Consumable.Food.Edible.Basic.Non-Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = AutoBarItems:new(
			"Consumable.Food.Edible.Battleground.Arathi Basin.Basic", "INV_Misc_Food_33", "Consumable.Food.Edible.Battleground.Arathi Basin.Basic")
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"]:SetLocation(BZ["Arathi Basin"])

	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = AutoBarItems:new(
			"Consumable.Food.Edible.Battleground.Warsong Gulch.Basic", "INV_Misc_Food_33", "Consumable.Food.Edible.Battleground.Warsong Gulch.Basic")
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"]:SetLocation(BZ["Warsong Gulch"])

	AutoBarCategoryList["Consumable.Food.Combo Health"] = AutoBarItems:new(
			"Consumable.Food.Combo Health", "INV_Misc_Food_33", "Consumable.Food.Combo Health")
	AutoBarCategoryList["Consumable.Food.Combo Health"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Bread.Conjured"] = AutoBarItems:new(
			"Consumable.Food.Edible.Bread.Conjured", "INV_Misc_Food_73CinnamonRoll", "Consumable.Food.Edible.Bread.Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Bread.Conjured"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Edible.Bread.Conjured"]:SetCastList(AutoBarCategory:FilterClass({"MAGE", BS["Conjure Food"],}))

	AutoBarCategoryList["Consumable.Food.Percent.Basic"] = AutoBarItems:new(
			"Consumable.Food.Percent.Basic", "INV_Misc_Food_60", "Consumable.Food.Percent.Basic")
	AutoBarCategoryList["Consumable.Food.Percent.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Percent.Bonus"] = AutoBarItems:new(
			"Consumable.Food.Percent.Bonus", "INV_Misc_Food_62", "Consumable.Food.Percent.Bonus")
	AutoBarCategoryList["Consumable.Food.Percent.Bonus"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Combo Percent"] = AutoBarItems:new(
			"Consumable.Food.Combo Percent", "INV_Food_ChristmasFruitCake_01", "Consumable.Food.Combo Percent")
	AutoBarCategoryList["Consumable.Food.Combo Percent"]:SetNonCombat(true)

--	rawList = self:RawItemsAdd(nil, "Consumable.Food.Edible.Bread.Basic", false);
--	rawList = self:RawItemsAdd(rawList, "Consumable.Food.Edible.Bread.Conjured", true);
--	AutoBarCategoryList["Consumable.Food.Pet.Bread"]["items"] = self:RawItemsConvert(rawList);
--	["Consumable.Food.Pet.Bread"] = {
--		["description"] = Consumable.Food.Pet.Bread;
--		["texture"] = "INV_Misc_Food_35";
--		["nonCombat"] = true,
--		["targeted"] = "PET";
--		["castSpell"] = BS["Feed Pet"];
--	},
	AutoBarCategoryList["Consumable.Food.Pet.Bread"] = AutoBarPetFood:new(
			"Consumable.Food.Pet.Bread", "INV_Misc_Food_35", "Consumable.Food.Edible.Bread.Basic", "Consumable.Food.Edible.Bread.Conjured")
	AutoBarCategoryList["Consumable.Food.Pet.Bread"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Pet.Bread"]:SetTargeted("PET")

--	AutoBarCategoryList["Consumable.Food.Pet.Cheese"]["items"] = self:GetSetItemsArrayPT3("Consumable.Food.Edible.Cheese.Basic");
--	["Consumable.Food.Pet.Cheese"] = {
--		["description"] = Consumable.Food.Pet.Cheese;
--		["texture"] = "INV_Misc_Food_37";
--		["nonCombat"] = true,
--		["targeted"] = "PET";
--		["castSpell"] = BS["Feed Pet"];
--	},
	AutoBarCategoryList["Consumable.Food.Pet.Cheese"] = AutoBarPetFood:new(
			"Consumable.Food.Pet.Cheese", "INV_Misc_Food_37", "Consumable.Food.Edible.Cheese.Basic")
	AutoBarCategoryList["Consumable.Food.Pet.Cheese"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Pet.Cheese"]:SetTargeted("PET")

--	rawList = self:RawItemsAdd(nil, "Consumable.Food.Inedible.Fish", false);
--	rawList = self:RawItemsAdd(rawList, "Consumable.Food.Edible.Fish.Basic", true);
--	AutoBarCategoryList["Consumable.Food.Pet.Fish"]["items"] = self:RawItemsConvert(rawList);
--	["Consumable.Food.Pet.Fish"] = {
--		["description"] = Consumable.Food.Pet.Fish;
--		["texture"] = "INV_Misc_Fish_22";
--		["nonCombat"] = true,
--		["targeted"] = "PET";
--		["castSpell"] = BS["Feed Pet"];
--	},
	AutoBarCategoryList["Consumable.Food.Pet.Fish"] = AutoBarPetFood:new(
			"Consumable.Food.Pet.Fish", "INV_Misc_Fish_22", "Consumable.Food.Inedible.Fish", "Consumable.Food.Edible.Fish.Basic")
	AutoBarCategoryList["Consumable.Food.Pet.Fish"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Pet.Fish"]:SetTargeted("PET")

--	AutoBarCategoryList["Consumable.Food.Pet.Fruit"]["items"] = self:GetSetItemsArrayPT3("Consumable.Food.Edible.Fruit.Basic");
--	["Consumable.Food.Pet.Fruit"] = {
--		["description"] = Consumable.Food.Pet.Fruit;
--		["texture"] = "INV_Misc_Food_19";
--		["nonCombat"] = true,
--		["targeted"] = "PET";
--		["castSpell"] = BS["Feed Pet"];
--	},
	AutoBarCategoryList["Consumable.Food.Pet.Fruit"] = AutoBarPetFood:new(
			"Consumable.Food.Pet.Fruit", "INV_Misc_Food_19", "Consumable.Food.Edible.Fruit.Basic")
	AutoBarCategoryList["Consumable.Food.Pet.Fruit"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Pet.Fruit"]:SetTargeted("PET")

--	AutoBarCategoryList["Consumable.Food.Pet.Fungus"]["items"] = self:GetSetItemsArrayPT3("Consumable.Food.Edible.Fungus.Basic");	-- Now includes senjin combo ;-(
--	["Consumable.Food.Pet.Fungus"] = {
--		["description"] = Consumable.Food.Pet.Fungus;
--		["texture"] = "INV_Mushroom_05";
--		["nonCombat"] = true,
--		["targeted"] = "PET";
--		["castSpell"] = BS["Feed Pet"];
--	},
	AutoBarCategoryList["Consumable.Food.Pet.Fungus"] = AutoBarPetFood:new(
			"Consumable.Food.Pet.Fungus", "INV_Mushroom_05", "Consumable.Food.Edible.Fungus.Basic")
	AutoBarCategoryList["Consumable.Food.Pet.Fungus"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Pet.Fungus"]:SetTargeted("PET")

--	rawList = self:RawItemsAdd(nil, "Consumable.Food.Inedible.Meat", false);
--	rawList = self:RawItemsAdd(rawList, "Consumable.Food.Edible.Meat.Basic", true);
--	AutoBarCategoryList["Consumable.Food.Pet.Meat"]["items"] = self:RawItemsConvert(rawList);
--	["Consumable.Food.Pet.Meat"] = {
--		["description"] = Consumable.Food.Pet.Meat;
--		["texture"] = "INV_Misc_Food_14";
--		["nonCombat"] = true,
--		["targeted"] = "PET";
--		["castSpell"] = BS["Feed Pet"];
--	},
	AutoBarCategoryList["Consumable.Food.Pet.Meat"] = AutoBarPetFood:new(
			"Consumable.Food.Pet.Meat", "INV_Misc_Food_14", "Consumable.Food.Inedible.Meat", "Consumable.Food.Edible.Meat.Basic")
	AutoBarCategoryList["Consumable.Food.Pet.Meat"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Pet.Meat"]:SetTargeted("PET")

	AutoBarCategoryList["Consumable.Buff Pet"] = AutoBarPetFood:new(
			"Consumable.Buff Pet", "INV_Misc_Food_87_SporelingSnack", "Consumable.Buff Pet")
	AutoBarCategoryList["Consumable.Buff Pet"]:SetTargeted("PET")

	AutoBarCategoryList["Consumable.Food.Bonus"] = AutoBarItems:new(
			"Consumable.Food.Bonus", "INV_Misc_Food_47", "Consumable.Food.Bonus")
	AutoBarCategoryList["Consumable.Food.Bonus"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Agility"] = AutoBarItems:new(
			"Consumable.Food.Buff.Agility", "INV_Misc_Fish_13", "Consumable.Food.Buff.Agility")
	AutoBarCategoryList["Consumable.Food.Buff.Agility"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Attack Power"] = AutoBarItems:new(
			"Consumable.Food.Buff.Attack Power", "INV_Misc_Fish_13", "Consumable.Food.Buff.Attack Power")
	AutoBarCategoryList["Consumable.Food.Buff.Attack Power"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Healing"] = AutoBarItems:new(
			"Consumable.Food.Buff.Healing", "INV_Misc_Fish_13", "Consumable.Food.Buff.Healing")
	AutoBarCategoryList["Consumable.Food.Buff.Healing"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.HP Regen"] = AutoBarItems:new(
			"Consumable.Food.Buff.HP Regen", "INV_Misc_Fish_19", "Consumable.Food.Buff.HP Regen")
	AutoBarCategoryList["Consumable.Food.Buff.HP Regen"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Intellect"] = AutoBarItems:new(
			"Consumable.Food.Buff.Intellect", "INV_Misc_Food_63", "Consumable.Food.Buff.Intellect")
	AutoBarCategoryList["Consumable.Food.Buff.Intellect"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Mana Regen"] = AutoBarItems:new(
			"Consumable.Food.Buff.Mana Regen", "INV_Drink_17", "Consumable.Food.Buff.Mana Regen")
	AutoBarCategoryList["Consumable.Food.Buff.Mana Regen"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Spell Damage"] = AutoBarItems:new(
			"Consumable.Food.Buff.Spell Damage", "INV_Misc_Food_65", "Consumable.Food.Buff.Spell Damage")
	AutoBarCategoryList["Consumable.Food.Buff.Spell Damage"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Spirit"] = AutoBarItems:new(
			"Consumable.Food.Buff.Spirit", "INV_Misc_Fish_03", "Consumable.Food.Buff.Spirit")
	AutoBarCategoryList["Consumable.Food.Buff.Spirit"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Stamina"] = AutoBarItems:new(
			"Consumable.Food.Buff.Stamina", "INV_Misc_Food_65", "Consumable.Food.Buff.Stamina")
	AutoBarCategoryList["Consumable.Food.Buff.Stamina"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Strength"] = AutoBarItems:new(
			"Consumable.Food.Buff.Strength", "INV_Misc_Food_41", "Consumable.Food.Buff.Strength")
	AutoBarCategoryList["Consumable.Food.Buff.Strength"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Other"] = AutoBarItems:new(
			"Consumable.Food.Buff.Other", "INV_Drink_17", "Consumable.Food.Buff.Other")
	AutoBarCategoryList["Consumable.Food.Buff.Other"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Basic"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Health.Basic", "INV_Potion_54", "Consumable.Cooldown.Potion.Health.Basic")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.PvP"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Health.PvP", "INV_Potion_39", "Consumable.Cooldown.Potion.Health.PvP")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.PvP"]:SetBattleground(true)

	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Blades Edge"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Health.Blades Edge", "INV_Potion_167", "Consumable.Cooldown.Potion.Health.Blades Edge")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Blades Edge"]:SetLocation(BZ["Blade's Edge Mountains"])

	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Coilfang"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Health.Coilfang", "INV_Potion_167", "Consumable.Cooldown.Potion.Health.Coilfang")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Coilfang"]:SetLocation("Coilfang")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Tempest Keep"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Health.Tempest Keep", "INV_Potion_153", "Consumable.Cooldown.Potion.Health.Tempest Keep")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Tempest Keep"]:SetLocation("Tempest Keep")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Basic"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Mana.Basic", "INV_Potion_76", "Consumable.Cooldown.Potion.Mana.Basic")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Pvp"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Mana.Pvp", "INV_Potion_81", "Consumable.Cooldown.Potion.Mana.Pvp")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Pvp"]:SetBattleground(true)

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Blades Edge"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Mana.Blades Edge", "INV_Potion_168", "Consumable.Cooldown.Potion.Mana.Blades Edge")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Blades Edge"]:SetLocation(BZ["Blade's Edge Mountains"])

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Coilfang"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Mana.Coilfang", "INV_Potion_168", "Consumable.Cooldown.Potion.Mana.Coilfang")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Coilfang"]:SetLocation("Coilfang")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Mana.Tempest Keep", "INV_Potion_156", "Consumable.Cooldown.Potion.Mana.Tempest Keep")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Tempest Keep"]:SetLocation("Tempest Keep")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Health.Warlock"] = AutoBarItems:new(
			"Consumable.Cooldown.Stone.Health.Warlock", "INV_Stone_04", "Consumable.Cooldown.Stone.Health.Warlock")

	AutoBarCategoryList["Misc.Minipet.Normal"] = AutoBarItems:new(
			"Misc.Minipet.Normal", "Ability_Creature_Poison_05", "Misc.Minipet.Normal")
	AutoBarCategoryList["Misc.Minipet.Normal"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Misc.Minipet.Snowball"] = AutoBarItems:new(
			"Misc.Minipet.Snowball", "INV_Misc_Bag_17", "Misc.Minipet.Snowball")
	AutoBarCategoryList["Misc.Minipet.Snowball"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Misc.Mount.Normal"] = AutoBarItems:new(
			"Misc.Mount.Normal", "Ability_Mount_JungleTiger", "Misc.Mount.Normal")
	AutoBarCategoryList["Misc.Mount.Normal"]:SetNonCombat(true)
	AutoBarCategoryList["Misc.Mount.Normal"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Misc.Mount.Ahn'Qiraj"] = AutoBarItems:new(
			"Misc.Mount.Ahn'Qiraj", "INV_Misc_QirajiCrystal_05", "Misc.Mount.Ahn'Qiraj")
	AutoBarCategoryList["Misc.Mount.Ahn'Qiraj"]:SetNonCombat(true)
	AutoBarCategoryList["Misc.Mount.Ahn'Qiraj"]:SetArrangeOnUse(true)
	AutoBarCategoryList["Misc.Mount.Ahn'Qiraj"]:SetLocation(BZ["Ahn'Qiraj"])

	AutoBarCategoryList["Misc.Mount.Flying"] = AutoBarItems:new(
			"Misc.Mount.Flying", "Ability_Mount_Wyvern_01", "Misc.Mount.Flying")
	AutoBarCategoryList["Misc.Mount.Flying"]:SetNonCombat(true)
	AutoBarCategoryList["Misc.Mount.Flying"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Consumable.Cooldown.Potion.Rejuvenation"] = AutoBarItems:new(
			"Consumable.Cooldown.Potion.Rejuvenation", "INV_Potion_47", "Consumable.Cooldown.Potion.Rejuvenation")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Health.Statue"] = AutoBarItems:new(
			"Consumable.Cooldown.Stone.Health.Statue", "INV_Misc_Statue_10", "Consumable.Cooldown.Stone.Health.Statue")

	AutoBarCategoryList["Consumable.Leatherworking.Drums"] = AutoBarItems:new(
			"Consumable.Leatherworking.Drums", "INV_Misc_Drum_06", "Consumable.Leatherworking.Drums")

	AutoBarCategoryList["Consumable.Tailor.Net"] = AutoBarItems:new(
			"Consumable.Tailor.Net", "INV_Misc_Net_01", "Consumable.Tailor.Net")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = AutoBarItems:new(
			"Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep", "INV_Potion_83", "Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Mana.Mana Stone"] = AutoBarItems:new(
			"Consumable.Cooldown.Stone.Mana.Mana Stone", "INV_Misc_Gem_Emerald_01", "Consumable.Cooldown.Stone.Mana.Mana Stone")

	AutoBarCategoryList["Consumable.Buff.Rage"] = AutoBarItems:new(
			"Consumable.Buff.Rage", "INV_Potion_24", "Consumable.Buff.Rage")

	AutoBarCategoryList["Consumable.Buff.Energy"] = AutoBarItems:new(
			"Consumable.Buff.Energy", "INV_Drink_Milk_05", "Consumable.Buff.Energy")

	AutoBarCategoryList["Misc.Booze"] = AutoBarItems:new(
			"Misc.Booze", "INV_Drink_03", "Misc.Booze")
	AutoBarCategoryList["Misc.Booze"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Basic"] = AutoBarItems:new(
			"Consumable.Water.Basic", "INV_Drink_10", "Consumable.Water.Basic", "Consumable.Water.Conjured")
	AutoBarCategoryList["Consumable.Water.Basic"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Water.Basic"]:SetCastList(AutoBarCategory:FilterClass({"MAGE", BS["Conjure Water"],}))

	AutoBarCategoryList["Consumable.Water.Percentage"] = AutoBarItems:new(
			"Consumable.Water.Percentage", "INV_Drink_04", "Consumable.Water.Percentage")
	AutoBarCategoryList["Consumable.Water.Percentage"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Buff.Spirit"] = AutoBarItems:new(
			"Consumable.Water.Buff.Spirit", "INV_Drink_16", "Consumable.Water.Buff.Spirit")
	AutoBarCategoryList["Consumable.Water.Buff.Spirit"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Buff"] = AutoBarItems:new(
			"Consumable.Water.Buff", "INV_Drink_08", "Consumable.Water.Buff")
	AutoBarCategoryList["Consumable.Water.Buff"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Mana"] = AutoBarItems:new("Consumable.Weapon Buff.Oil.Mana", "INV_Potion_100",
			"Consumable.Weapon Buff.Oil.Mana")
	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Mana"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Wizard"] = AutoBarItems:new("Consumable.Weapon Buff.Oil.Wizard", "INV_Potion_105",
			"Consumable.Weapon Buff.Oil.Wizard")
	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Wizard"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Crippling"] = AutoBarItems:new("Consumable.Weapon Buff.Poison.Crippling", "INV_Potion_19",
			"Consumable.Weapon Buff.Poison.Crippling")
	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Crippling"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Deadly"] = AutoBarItems:new("Consumable.Weapon Buff.Poison.Deadly", "Ability_Rogue_DualWeild",
			"Consumable.Weapon Buff.Poison.Deadly")
	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Deadly"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Instant"] = AutoBarItems:new("Consumable.Weapon Buff.Poison.Instant", "Ability_Poisons",
			"Consumable.Weapon Buff.Poison.Instant", "Consumable.Weapon Buff.Poison.Anesthetic")
	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Instant"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Mind Numbing"] = AutoBarItems:new("Consumable.Weapon Buff.Poison.Mind Numbing", "Spell_Nature_NullifyDisease",
			"Consumable.Weapon Buff.Poison.Mind Numbing")
	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Mind Numbing"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Wound"] = AutoBarItems:new("Consumable.Weapon Buff.Poison.Wound", "Ability_PoisonSting",
			"Consumable.Weapon Buff.Poison.Wound")
	AutoBarCategoryList["Consumable.Weapon Buff.Poison.Wound"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Sharpening Stone"] = AutoBarItems:new("Consumable.Weapon Buff.Stone.Sharpening Stone", "INV_Stone_SharpeningStone_01",
			"Consumable.Weapon Buff.Stone.Sharpening Stone")
	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Sharpening Stone"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Weight Stone"] = AutoBarItems:new("Consumable.Weapon Buff.Stone.Weight Stone", "INV_Stone_WeightStone_02",
			"Consumable.Weapon Buff.Stone.Weight Stone")
	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Weight Stone"]:SetTargeted("WEAPON")


	AutoBarCategoryList["Consumable.Buff Group.General.Self"] = AutoBarItems:new("Consumable.Buff Group.General.Self", "INV_Potion_80",
			"Consumable.Buff Group.General.Self")

	AutoBarCategoryList["Consumable.Buff Group.General.Target"] = AutoBarItems:new("Consumable.Buff Group.General.Target", "INV_Potion_80",
			"Consumable.Buff Group.General.Target")
	AutoBarCategoryList["Consumable.Buff Group.General.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff Group.Caster.Self"] = AutoBarItems:new("Consumable.Buff Group.Caster.Self", "INV_Potion_66",
			"Consumable.Buff Group.Caster.Self")

	AutoBarCategoryList["Consumable.Buff Group.Caster.Target"] = AutoBarItems:new("Consumable.Buff Group.Caster.Target", "INV_Potion_66",
			"Consumable.Buff Group.Caster.Target")
	AutoBarCategoryList["Consumable.Buff Group.Caster.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff Group.Melee.Self"] = AutoBarItems:new("Consumable.Buff Group.Melee.Self", "INV_Potion_43",
			"Consumable.Buff Group.Melee.Self")

	AutoBarCategoryList["Consumable.Buff Group.Melee.Target"] = AutoBarItems:new("Consumable.Buff Group.Melee.Target", "INV_Potion_43",
			"Consumable.Buff Group.Melee.Target")
	AutoBarCategoryList["Consumable.Buff Group.Melee.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Other.Self"] = AutoBarItems:new("Consumable.Buff.Other.Self", "INV_Potion_80",
			"Consumable.Buff.Other.Self")

	AutoBarCategoryList["Consumable.Buff.Other.Target"] = AutoBarItems:new("Consumable.Buff.Other.Target", "INV_Potion_80",
			"Consumable.Buff.Other.Target")
	AutoBarCategoryList["Consumable.Buff.Other.Target"]:SetTargeted(true)


	AutoBarCategoryList["Consumable.Buff.Chest"] = AutoBarItems:new("Consumable.Buff.Chest", "INV_Misc_Rune_10",
			"Consumable.Buff.Chest")
	AutoBarCategoryList["Consumable.Buff.Chest"]:SetTargeted("CHEST")

	AutoBarCategoryList["Consumable.Buff.Shield"] = AutoBarItems:new("Consumable.Buff.Shield", "INV_Misc_Rune_13",
			"Consumable.Buff.Shield")
	AutoBarCategoryList["Consumable.Buff.Shield"]:SetTargeted("SHIELD")

	AutoBarCategoryList["Consumable.Weapon Buff"] = AutoBarItems:new("Consumable.Weapon Buff", "INV_Misc_Rune_13",
			"Consumable.Weapon Buff")
	AutoBarCategoryList["Consumable.Weapon Buff"]:SetTargeted("WEAPON")
	AutoBarCategoryList["Consumable.Weapon Buff"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Consumable.Buff.Health"] = AutoBarItems:new("Consumable.Buff.Health", "INV_Potion_43",
			"Consumable.Buff.Health")

	AutoBarCategoryList["Consumable.Buff.Armor"] = AutoBarItems:new("Consumable.Buff.Armor", "INV_Potion_66",
			"Consumable.Buff.Armor")

	AutoBarCategoryList["Consumable.Buff.Regen Health"] = AutoBarItems:new("Consumable.Buff.Regen Health", "INV_Potion_80",
			"Consumable.Buff.Regen Health")

	AutoBarCategoryList["Consumable.Buff.Agility"] = AutoBarItems:new("Consumable.Buff.Agility", "INV_Scroll_02",
			"Consumable.Buff.Agility")
	AutoBarCategoryList["Consumable.Buff.Agility"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Intellect"] = AutoBarItems:new("Consumable.Buff.Intellect", "INV_Scroll_01",
			"Consumable.Buff.Intellect")
	AutoBarCategoryList["Consumable.Buff.Intellect"]:SetTargeted(true)

--	AutoBarCategoryList["BUFF_PROTECTION"] = AutoBarItems:new("Consumable.Buff.Protection", "INV_Scroll_07",
--			"Consumable.Buff.Protection")
--	AutoBarCategoryList["BUFF_PROTECTION"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Spirit"] = AutoBarItems:new("Consumable.Buff.Spirit", "INV_Scroll_01",
			"Consumable.Buff.Spirit")
	AutoBarCategoryList["Consumable.Buff.Spirit"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Stamina"] = AutoBarItems:new("Consumable.Buff.Stamina", "INV_Scroll_07",
			"Consumable.Buff.Stamina")
	AutoBarCategoryList["Consumable.Buff.Stamina"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Strength"] = AutoBarItems:new("Consumable.Buff.Strength", "INV_Scroll_02",
			"Consumable.Buff.Strength")
	AutoBarCategoryList["Consumable.Buff.Strength"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Attack Power"] = AutoBarItems:new("Consumable.Buff.Attack Power", "INV_Misc_MonsterScales_07",
			"Consumable.Buff.Attack Power")
	AutoBarCategoryList["Consumable.Buff.Attack Power"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Attack Speed"] = AutoBarItems:new("Consumable.Buff.Attack Speed", "INV_Misc_MonsterScales_17",
			"Consumable.Buff.Attack Speed")
	AutoBarCategoryList["Consumable.Buff.Attack Speed"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Dodge"] = AutoBarItems:new("Consumable.Buff.Dodge", "INV_Misc_MonsterScales_17",
			"Consumable.Buff.Dodge")
	AutoBarCategoryList["Consumable.Buff.Dodge"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Resistance.Self"] = AutoBarItems:new("Consumable.Buff.Resistance", "INV_Misc_MonsterScales_15",
			"Consumable.Buff.Resistance.Self")

	AutoBarCategoryList["Consumable.Buff.Resistance.Target"] = AutoBarItems:new("Consumable.Buff.Resistance", "INV_Misc_MonsterScales_15",
			"Consumable.Buff.Resistance.Target")
	AutoBarCategoryList["Consumable.Buff.Resistance.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Speed"] = AutoBarItems:new("Consumable.Buff.Speed", "INV_Potion_95",
			"Consumable.Buff.Speed")

	AutoBarCategoryList["Consumable.Buff Type.Battle"] = AutoBarItems:new("Consumable.Buff Type.Battle", "INV_Potion_111",
			"Consumable.Buff Type.Battle")

	AutoBarCategoryList["Consumable.Buff Type.Guardian"] = AutoBarItems:new("Consumable.Buff Type.Guardian", "INV_Potion_155",
			"Consumable.Buff Type.Guardian")

	AutoBarCategoryList["Consumable.Buff Type.Both"] = AutoBarItems:new("Consumable.Buff Type.Both", "INV_Potion_118",
			"Consumable.Buff Type.Both")

	AutoBarCategoryList["Gear.Trinket"] = AutoBarItems:new("Gear.Trinket", "INV_Misc_OrnateBox",
			"Gear.Trinket")
	AutoBarCategoryList["Gear.Trinket"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Misc.Lockboxes"] = AutoBarItems:new("Misc.Lockboxes", "INV_Trinket_Naxxramas06",
			"Misc.Lockboxes")
	AutoBarCategoryList["Misc.Lockboxes"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Misc.Usable.Permanent"] = AutoBarItems:new("Misc.Usable.Permanent", "INV_BannerPVP_02",
			"Misc.Usable.Permanent")
	AutoBarCategoryList["Misc.Usable.Permanent"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Misc.Usable.Quest"] = AutoBarItems:new("Misc.Usable.Quest", "INV_BannerPVP_02",
			"Misc.Usable.Quest")
	AutoBarCategoryList["Misc.Usable.Quest"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Misc.Usable.Replenished"] = AutoBarItems:new("Misc.Usable.Replenished", "INV_BannerPVP_02",
			"Misc.Usable.Replenished")
	AutoBarCategoryList["Misc.Usable.Replenished"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Warlock.Create Firestone"] = AutoBarSpells:new(
			"Spell.Warlock.Create Firestone", LBS:GetShortSpellIcon("Create Firestone"), {
			"WARLOCK", BS["Create Firestone"],
			})

	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = AutoBarSpells:new(
			"Spell.Warlock.Create Healthstone", LBS:GetShortSpellIcon("Create Healthstone"), {
			"WARLOCK", BS["Create Healthstone"],
			"WARLOCK", BS["Ritual of Souls"],
			})

	AutoBarCategoryList["Spell.Warlock.Create Soulstone"] = AutoBarSpells:new(
			"Spell.Warlock.Create Soulstone", LBS:GetShortSpellIcon("Create Soulstone"), {
			"WARLOCK", BS["Create Soulstone"],
			})

	AutoBarCategoryList["Spell.Warlock.Create Spellstone"] = AutoBarSpells:new(
			"Spell.Warlock.Create Spellstone", LBS:GetShortSpellIcon("Create Spellstone"), {
			"WARLOCK", BS["Create Spellstone"],
			})

	AutoBarCategoryList["Consumable.Mage.Conjure Mana Stone"] = AutoBarSpells:new(
			"Consumable.Mage.Conjure Mana Stone", "INV_Misc_Gem_Emerald_01", {
			"MAGE", BS["Conjure Mana Agate"],
			"MAGE", BS["Conjure Mana Jade"],
			"MAGE", BS["Conjure Mana Citrine"],
			"MAGE", BS["Conjure Mana Ruby"],
			"MAGE", BS["Conjure Mana Emerald"],
			})

	AutoBarCategoryList["Spell.Aura"] = AutoBarSpells:new(
			"Spell.Aura", LBS:GetShortSpellIcon("Crusader Aura"), {
			"HUNTER", BS["Aspect of the Beast"],
			"HUNTER", BS["Aspect of the Cheetah"],
			"HUNTER", BS["Aspect of the Hawk"],
			"HUNTER", BS["Aspect of the Monkey"],
			"HUNTER", BS["Aspect of the Pack"],
			"HUNTER", BS["Aspect of the Viper"],
			"HUNTER", BS["Aspect of the Wild"],
			"PALADIN", BS["Concentration Aura"],
			"PALADIN", BS["Crusader Aura"],
			"PALADIN", BS["Devotion Aura"],
			"PALADIN", BS["Fire Resistance Aura"],
			"PALADIN", BS["Frost Resistance Aura"],
			"PALADIN", BS["Retribution Aura"],
			"PALADIN", BS["Sanctity Aura"],
			"PALADIN", BS["Shadow Resistance Aura"],
			})
	AutoBarCategoryList["Spell.Aura"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Class.Buff"] = AutoBarSpells:new(
			"Spell.Class.Buff", LBS:GetShortSpellIcon("Force of Nature"), nil, {
			"DRUID", BS["Omen of Clarity"], BS["Omen of Clarity"],
			"DRUID", BS["Thorns"], BS["Thorns"],
			"DRUID", BS["Mark of the Wild"], BS["Gift of the Wild"],
			"DRUID", BS["Nature's Grasp"], BS["Nature's Grasp"],
			"MAGE", BS["Arcane Intellect"], BS["Arcane Brilliance"],
			"PRIEST", BS["Shadow Protection"], BS["Prayer of Shadow Protection"],
			"PRIEST", BS["Divine Spirit"], BS["Prayer of Spirit"],
			"PRIEST", BS["Power Word: Fortitude"], BS["Prayer of Fortitude"],
			"WARRIOR", BS["Demoralizing Shout"], BS["Challenging Shout"],
			"WARRIOR", BS["Battle Shout"], BS["Commanding Shout"],
			"WARRIOR", BS["Commanding Shout"], BS["Battle Shout"],
			"PALADIN", BS["Blessing of Freedom"], BS["Blessing of Freedom"],
			"PALADIN", BS["Blessing of Kings"], BS["Greater Blessing of Kings"],
			"PALADIN", BS["Blessing of Light"], BS["Greater Blessing of Light"],
			"PALADIN", BS["Blessing of Might"], BS["Greater Blessing of Might"],
			"PALADIN", BS["Blessing of Protection"], BS["Blessing of Protection"],
			"PALADIN", BS["Blessing of Sacrifice"], BS["Blessing of Sacrifice"],
			"PALADIN", BS["Blessing of Salvation"], BS["Greater Blessing of Salvation"],
			"PALADIN", BS["Blessing of Sanctuary"], BS["Greater Blessing of Sanctuary"],
			"PALADIN", BS["Blessing of Wisdom"], BS["Greater Blessing of Wisdom"],
			})
	AutoBarCategoryList["Spell.Class.Buff"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Class.Pet"] = AutoBarSpells:new(
			"Spell.Class.Pet", LBS:GetShortSpellIcon("Force of Nature"), {
			"DRUID", BS["Force of Nature"],
			"HUNTER", BS["Scare Beast"],
			"HUNTER", BS["Tame Beast"],
			"HUNTER", BS["Beast Training"],
			"HUNTER", BS["Beast Lore"],
			"HUNTER", BS["Eyes of the Beast"],
			"HUNTER", BS["Mend Pet"],
			"HUNTER", BS["Feed Pet"],
			"HUNTER", BS["Dismiss Pet"],
			"HUNTER", BS["Revive Pet"],
			"HUNTER", BS["Call Pet"],
			"MAGE", BS["Summon Water Elemental"],
			"PRIEST", BS["Shadowfiend"],
			"SHAMAN", BS["Fire Elemental Totem"],
			"SHAMAN", BS["Earth Elemental Totem"],
			"WARLOCK", BS["Eye of Kilrogg"],
			"WARLOCK", BS["Summon Felguard"],
			"WARLOCK", BS["Summon Felhunter"],
			"WARLOCK", BS["Summon Imp"],
			"WARLOCK", BS["Summon Succubus"],
			"WARLOCK", BS["Summon Voidwalker"],
			})
	AutoBarCategoryList["Spell.Class.Pet"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Portals"] = AutoBarSpells:new(
			"Spell.Portals", "Spell_Arcane_PortalShattrath", nil, {
			"MAGE", BS["Teleport: Undercity"], BS["Portal: Undercity"],
			"MAGE", BS["Teleport: Thunder Bluff"], BS["Portal: Thunder Bluff"],
			"MAGE", BS["Teleport: Stormwind"], BS["Portal: Stormwind"],
			"MAGE", BS["Teleport: Silvermoon"], BS["Portal: Silvermoon"],
			"MAGE", BS["Teleport: Exodar"], BS["Portal: Exodar"],
			"MAGE", BS["Teleport: Darnassus"], BS["Portal: Darnassus"],
			"MAGE", BS["Teleport: Ironforge"], BS["Portal: Ironforge"],
			"MAGE", BS["Teleport: Orgrimmar"], BS["Portal: Orgrimmar"],
			"MAGE", BS["Teleport: Shattrath"], BS["Portal: Shattrath"],
			"DRUID", BS["Teleport: Moonglade"], BS["Teleport: Moonglade"],
			"SHAMAN", BS["Astral Recall"], BS["Astral Recall"],
			"WARLOCK", BS["Ritual of Summoning"], BS["Ritual of Summoning"],
			})

	AutoBarCategoryList["Spell.Stance"] = AutoBarSpells:new(
			"Spell.Stance", LBS:GetShortSpellIcon("Berserker Stance"), nil, {
			"WARRIOR", BS["Defensive Stance"], BS["Berserker Stance"],
			"WARRIOR", BS["Battle Stance"], BS["Defensive Stance"],
			"WARRIOR", BS["Berserker Stance"], BS["Defensive Stance"],
			})

	AutoBarCategoryList["Spell.Totem.Earth"] = AutoBarSpells:new(
			"Spell.Totem.Earth", "Spell_Nature_EarthElemental_Totem", {
			"SHAMAN", BS["Earth Elemental Totem"],
			"SHAMAN", BS["Earthbind Totem"],
			"SHAMAN", BS["Stoneclaw Totem"],
			"SHAMAN", BS["Stoneskin Totem"],
			"SHAMAN", BS["Strength of Earth Totem"],
			"SHAMAN", BS["Tremor Totem"],
			})
	AutoBarCategoryList["Spell.Totem.Earth"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Totem.Air"] = AutoBarSpells:new(
			"Spell.Totem.Air", "Spell_Nature_InvisibilityTotem", {
			"SHAMAN", BS["Grace of Air Totem"],
			"SHAMAN", BS["Grounding Totem"],
			"SHAMAN", BS["Nature Resistance Totem"],
			"SHAMAN", BS["Sentry Totem"],
			"SHAMAN", BS["Tranquil Air Totem"],
			"SHAMAN", BS["Windfury Totem"],
			"SHAMAN", BS["Windwall Totem"],
			"SHAMAN", BS["Wrath of Air Totem"],
			})
	AutoBarCategoryList["Spell.Totem.Air"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Totem.Fire"] = AutoBarSpells:new(
			"Spell.Totem.Fire", "Spell_Fire_SelfDestruct", {
			"SHAMAN", BS["Fire Elemental Totem"],
			"SHAMAN", BS["Fire Nova Totem"],
			"SHAMAN", BS["Flametongue Totem"],
			"SHAMAN", BS["Frost Resistance Totem"],
			"SHAMAN", BS["Magma Totem"],
			"SHAMAN", BS["Searing Totem"],
			"SHAMAN", BS["Totem of Wrath"],
			})
	AutoBarCategoryList["Spell.Totem.Fire"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Totem.Water"] = AutoBarSpells:new(
			"Spell.Totem.Water", "Spell_Frost_SummonWaterElemental", {
			"SHAMAN", BS["Disease Cleansing Totem"],
			"SHAMAN", BS["Fire Resistance Totem"],
			"SHAMAN", BS["Healing Stream Totem"],
			"SHAMAN", BS["Mana Spring Totem"],
			"SHAMAN", BS["Mana Tide Totem"],
			"SHAMAN", BS["Poison Cleansing Totem"],
			})
	AutoBarCategoryList["Spell.Totem.Water"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Buff.Weapon"] = AutoBarSpells:new(
			"Spell.Buff.Weapon", LBS:GetShortSpellIcon("Windfury"), {
			"SHAMAN", BS["Windfury Weapon"],
			"SHAMAN", BS["Rockbiter Weapon"],
			"SHAMAN", BS["Flametongue Weapon"],
			"SHAMAN", BS["Frostbrand Weapon"],
			})
	AutoBarCategoryList["Spell.Buff.Weapon"]:SetArrangeOnUse(true)
	AutoBarCategoryList["Spell.Buff.Weapon"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Spell.Crafting"] = AutoBarSpells:new(
			"Spell.Crafting", LBS:GetShortSpellIcon("First Aid"), {
			"*", BS["Alchemy"],
			"*", BS["Armorsmith"],
			"*", BS["Basic Campfire"],
			"*", BS["Blacksmithing"],
			"*", BS["Cooking"],
--			"*", BS["Disenchant"],
			"*", BS["Enchanting"],
			"*", BS["Engineering"],
			"*", BS["First Aid"],
			"*", BS["Jewelcrafting"],
			"*", BS["Leatherworking"],
			"*", BS["Poisons"],
			"*", BS["Prospecting"],
			"*", BS["Smelting"],
			"*", BS["Tailoring"],
			"*", BS["Weaponsmith"],
			})
	AutoBarCategoryList["Spell.Crafting"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Fishing"] = AutoBarSpells:new(
			"Spell.Fishing", LBS:GetShortSpellIcon("Fishing"), {
			"*", BS["Fishing"],
			})
	AutoBarCategoryList["Spell.Crafting"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Track"] = AutoBarSpells:new(
			"Spell.Track", LBS:GetShortSpellIcon("Track Humanoids"), {
			"*", BS["Ammunition"],
			"*", BS["Banker"],
			"*", BS["BattleMaster"],
			"*", BS["Class Trainer"],
			"*", BS["Find Fish"],
			"*", BS["Find Herbs"],
			"*", BS["Find Minerals"],
			"*", BS["Find Treasure"],
			"*", BS["FlightMaster"],
			"*", BS["Food & Drink"],
			"*", BS["Innkeeper"],
			"*", BS["Profession Trainers"],
			"*", BS["Reagents"],
			"*", BS["Repair"],
			"*", BS["StableMaster"],
			"DRUID", BS["Track Humanoids"],
			"HUNTER", BS["Track Beasts"],
			"HUNTER", BS["Track Demons"],
			"HUNTER", BS["Track Dragonkin"],
			"HUNTER", BS["Track Elementals"],
			"HUNTER", BS["Track Giants"],
			"HUNTER", BS["Track Hidden"],
			"HUNTER", BS["Track Humanoids"],
			"HUNTER", BS["Track Undead"],
			"PALADIN", BS["Sense Undead"],
			"WARLOCK", BS["Sense Demons"],
			})
	AutoBarCategoryList["Spell.Track"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Trap"] = AutoBarSpells:new(
			"Spell.Trap", LBS:GetShortSpellIcon("Snake Trap"), {
			"HUNTER", BS["Explosive Trap"],
			"HUNTER", BS["Frost Trap"],
			"HUNTER", BS["Immolation Trap"],
			"HUNTER", BS["Snake Trap"],
			"HUNTER", BS["Freezing Trap"],
			})
	AutoBarCategoryList["Spell.Trap"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Spell.Sting"] = AutoBarSpells:new(
			"Spell.Sting", LBS:GetShortSpellIcon("Wyvern Sting"), {
			"HUNTER", BS["Scorpid Sting"],
			"HUNTER", BS["Viper Sting"],
			"HUNTER", BS["Serpent Sting"],
			"HUNTER", BS["Wyvern Sting"],
			})
	AutoBarCategoryList["Spell.Sting"]:SetArrangeOnUse(true)

	AutoBarCategoryList["Consumable.Water.Conjure"] = AutoBarSpells:new(
			"Consumable.Water.Conjure", LBS:GetShortSpellIcon("Conjure Water"), {
			"MAGE", BS["Conjure Water"],
			})

	AutoBarCategoryList["Consumable.Food.Conjure"] = AutoBarSpells:new(
			"Consumable.Food.Conjure", LBS:GetShortSpellIcon("Conjure Food"), {
			"MAGE", BS["Conjure Food"],
			})

	AutoBarCategoryList["Misc.Mount.Summoned"] = AutoBarSpells:new(
			"Misc.Mount.Summoned", "Ability_Mount_JungleTiger", {
			"PALADIN", BS["Summon Warhorse"],
			"PALADIN", BS["Summon Charger"],
			"WARLOCK", BS["Summon Felsteed"],
			"WARLOCK", BS["Summon Dreadsteed"],
			"DRUID", BS["Travel Form"],
			"DRUID", BS["Flight Form"],
			"DRUID", BS["Swift Flight Form"],
			"SHAMAN", BS["Ghost Wolf"],
			})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetArrangeOnUse(true)
end


-- Learned new spells etc.  Refresh all categories
function AutoBarCategory:UpdateCategories()
	for categoryKey, categoryInfo in pairs(AutoBarCategoryList) do
		categoryInfo:Refresh()
	end
end


function AutoBarCategory:UpdateCustomCategoriesOptions()
-- ToDo maybe PT:AddData("AutoBar", {["AutoBar.SetA"] = "u,11436:Moose,7521:Sock", ["AutoBar.SetB"] = "5132,25443",}) ?

	if (not AutoBar.db.account.customCategories) then
		AutoBar.db.account.customCategories = {}
	end
	for index, customCategoriesDB in ipairs(AutoBar.db.account.customCategories) do
		assert(customCategoriesDB, "customCategoriesDB nil")
		AutoBarCategoryList["Custom." .. customCategoriesDB.name] = AutoBarCustom:new(customCategoriesDB)
	end
end


-- Add or remove a custom category
function AutoBarCategoryUpdate(customCategoriesDBAdd, customCategoriesDBDelete)
	if (customCategoriesDBAdd) then
		-- ToDo avoid duplicate names
		AutoBarCategoryList["Custom." .. customCategoriesDBAdd.name] = AutoBarCustom:new(customCategoriesDBAdd)
	end
	if (customCategoriesDBDelete) then
		-- ToDo avoid duplicate names, remove category from buttons
		AutoBarCategoryList["Custom." .. customCategoriesDBDelete.name] = nil
	end
end


function AutoBarCategory:UpdateCustomCategories()
	for categoryKey, categoryInfo in pairs(AutoBarCategoryList) do
		--
		categoryInfo:Refresh()

		if (categoryInfo.customKey) then
			local found = false
			for index, customCategoriesDB in ipairs(AutoBar.db.account.customCategories) do
				if ("Custom." .. customCategoriesDB.name == categoryKey) then
					found = true
				end
			end

			-- Remove missing custom Categories
			if (not found) then
				AutoBarCategoryList[categoryKey] = nil
			end
		end
	end

	--
	for categoryKey in pairs(AutoBar.categoryValidateList) do
		AutoBar.categoryValidateList[categoryKey] = nil
	end
	for categoryKey, categoryInfo in pairs(AutoBarCategoryList) do
		AutoBar.categoryValidateList[categoryKey] = categoryInfo.description
	end
end


-- /dump AutoBarCategoryList["Misc.Mount.Summoned"]
-- /dump AutoBarCategoryList["Spell.Crafting"].castList
-- /script LibStub("LibBabble-Spell-3.0")["Tailoring"]
