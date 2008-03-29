local InventoryLib = LibStub("LibInventory-2.1")
local InventoryLib_Items = InventoryLib:GetItems()
local InventoryLib_types_tree, InventoryLib_types_base, InventoryLib_types_sub, InventoryLib_types_slot = InventoryLib:GetTypesTables()

local _G = getfenv(0)

local next		= _G.next
local pairs		= _G.pairs
local select	= _G.select

local GetItemInfo	= _G.GetItemInfo

local table_insert	= _G.table.insert
local table_remove	= _G.table.remove

-- --------------------
-- --------------------
-- these should all be nil for release
ITEMDB_DEBUG_ENABLE = nil;
ITEMDB_DEBUG_INSPECT = nil;
ITEMDB_DEBUG_SESSIONITEMS = nil;
-- --------------------
-- --------------------

UIPanelWindows["ItemDB_DBFrame"] = { area = "doublewide", pushable = 0, width = 840, whileDead = 1 };

local DressUpItemLink_orig = DressUpItemLink;

function DressUpItemLink(link)
	if ( not link ) then
		return;
	end
	if ( ItemDB_DBFrame:IsShown() ) then
		if ( not ItemDB_DBFrame_DressUpFrame:IsShown() ) then
			ShowUIPanel(ItemDB_DBFrame_DressUpFrame);
			ItemDB_DBFrame_DressUpModel:SetUnit("player");
		end
		ItemDB_DBFrame_DressUpModel:TryOn(link);
	else
		DressUpItemLink_orig(link);
	end
end

function ItemDB_SetDressUpBackground()
	local texture = DressUpTexturePath();
	ItemDB_DBFrame_DressUpBackgroundTop:SetTexture(texture..1);
	ItemDB_DBFrame_DressUpBackgroundBot:SetTexture(texture..3);
end

function ItemDB_DressUpFrame_OnShow()
	UIPanelWindows["ItemDB_DBFrame"].width = 1020;
	UpdateUIPanelPositions(ItemDB_DBFrame);
	PlaySound("igCharacterInfoOpen");
end

function ItemDB_DressUpFrame_OnHide()
	UIPanelWindows["ItemDB_DBFrame"].width = 840;
	UpdateUIPanelPositions();
	PlaySound("igCharacterInfoClose");
end

local ItemDBRarityFilter = {1, 1, 1, 1, 1, 1, 1};
local ItemDBSortReverse = 0;
local ItemDBSortCurrent = "name";
local ItemDB_DBFrame_selectedClass;
local ItemDB_DBFrame_selectedSubclass;
local ItemDB_DBFrame_selectedInvtype;
local ItemDB_DBFrame_selectedTab;
local ItemDB_DBFrame_clickedButton;

ITEMDB_NUM_ITEMS_TO_DISPLAY = 8;
ITEMDB_NUM_FILTERS_TO_DISPLAY = 15;
ITEMDB_ITEM_FILTER_HEIGHT = 20;
ITEMDB_ITEM_BUTTON_HEIGHT = 37;
ITEMDB_CLASS_FILTERS = {};
ITEMDB_OPEN_FILTER_LIST = {};

local ItemsAll;
local ItemsSession;
local ItemsSessionKnown;
local ItemsSessionRecheck;
local ItemsList;
local types;
local ItemTypes;
local ItemSubTypes;
local ItemInvTypes;

local cleansubclasspattern = "^"..HIGHLIGHT_FONT_COLOR_CODE.."(.*)"..FONT_COLOR_CODE_CLOSE.."$"

MoneyTypeInfo["ITEMDB"] = {
	UpdateFunc = function()
		return this.staticMoney;
	end,
	showSmallerCoins = 1,
	fixedWidth = 1,
	collapse = 1,
	truncateSmallCoins = nil,
};

--~ StaticPopupDialogs["ITEMDB_LINKING_WARNING"] = {
--~ 	text = TEXT(ITEMDB_STRING_LINKING_WARNING),
--~ 	button1 = TEXT(YES),
--~ 	button2 = TEXT(NO),
--~ 	OnAccept = function()
--~ 		ChatEdit_InsertLink(ItemDB_DBFrame_ItemButton_GetLink(ItemDB_DBFrame_clickedButton));
--~ 	end,
--~ 	showAlert = 1,
--~ 	whileDead = 1,
--~ 	timeout = 0,
--~ 	hideOnEscape = 1
--~ };

function ItemDB_DBFrame_OnLoad()
	-- Register slash command
	SLASH_ITEMDB1 = "/itemdb";
	SlashCmdList["ITEMDB"] = function(msg)
		ItemDB_DBFrame_SlashCommandHandler(msg);
	end

	PanelTemplates_SetNumTabs(this, 1);
	PanelTemplates_SetTab(ItemDB_DBFrame, 1);
end

function ItemDB_DBFrame_OnShow()
	ItemDB_DBFrame_Filters_Update()
	if (not ItemsList) then
		ItemDB_DBFrame_BuildItemsList();
	end
	if (not ItemDB_DBFrame_selectedTab) then
		ItemDB_DBFrame_Tab_OnClick(1);
	end
end

function ItemDB_DBFrame_Tab_OnClick(index)
	if ( not index ) then
		index = this:GetID();
	end
	PanelTemplates_SetTab(ItemDB_DBFrame, index);
	if (index ~= ItemDB_DBFrame_selectedTab) then
		ItemDB_DBFrame_selectedTab = index;
		ItemDB_DBFrame_BuildItemsList();
	end
	PlaySound("igCharacterInfoTab");
end

function ItemDB_DBFrame_SlashCommandHandler(msg)
	ItemDB_DBFrame_ToggleUI()
end

function ItemDB_DBFrame_ToggleUI()
	if( ItemDB_DBFrame:IsVisible() ) then
		HideUIPanel(ItemDB_DBFrame);
	else
		ShowUIPanel(ItemDB_DBFrame);
	end
end

local tablecache = setmetatable({}, {__mode='k'})
local function recyclelisttable(t)
	for k, v in pairs(t) do
		tablecache[v] = true
		t[k] = nil
	end
	return t
end
local function getlisttable(...)
	local t = next(tablecache) or {}
	tablecache[t] = nil
	for i = 1, select('#', ...), 2 do
		t[select(i, ...)] = select(i + 1, ...)
	end
	return t
end

local PATTERN_itemid = "item:(%-?%d+):%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+"
local PATTERN_itemlink = "|c%x+|H"..PATTERN_itemid.."|h%[.-%]|h|r"
local function getbaseid(link)
	if link then
		if type(link) == "number" then return link end
		local baseid = strmatch(link, PATTERN_itemlink)
		if not baseid then
			baseid = strmatch(link, PATTERN_itemid)
		end
		if not baseid then
			baseid = link
		end
		return tonumber(baseid)
	end
	return
end

ItemsList = {}
function ItemDB_DBFrame_BuildItemsList()
	FauxScrollFrame_SetOffset(ItemDB_DBFrame_ItemList_BrowseScrollFrame, 0);
	local scrollbar = _G.ItemDB_DBFrame_ItemList_BrowseScrollFrameScrollBar
	scrollbar:SetValue(0);
	ItemsList = recyclelisttable(ItemsList)
	local FilterName = strlower(ItemDB_DBFrame_ItemList_Name:GetText())
	local FilterMinLevel = tonumber(ItemDB_DBFrame_ItemList_MinLevel:GetText()) or 0
	local FilterMaxLevel = tonumber(ItemDB_DBFrame_ItemList_MaxLevel:GetText()) or 70
	local cleansubclass = nil;
	local cleaninvtype = nil;
	if (ItemDB_DBFrame_selectedSubclass) then
		_, _, cleansubclass = string.find(ItemDB_DBFrame_selectedSubclass, cleansubclasspattern);
	end
	if (ItemDB_DBFrame_selectedInvtype) then
		_, _, cleaninvtype = string.find(ItemDB_DBFrame_selectedInvtype, cleansubclasspattern);
	end

	local ItemsKnown, ItemsSession = InventoryLib:GetCounts()
	if (ItemDB_DBFrame_selectedTab == 1) then
		for id, safe in pairs(InventoryLib_Items) do
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(id);
			itemEquipLoc = _G[itemEquipLoc]
			if (not itemEquipLoc or itemEquipLoc == "") then
				itemEquipLoc = InventoryLib.LOCALE_INVTYPE_OTHER
			end
			if ((ItemDBRarityFilter[itemRarity + 1] == 1) and (string.find(strlower(itemName), FilterName)) and (itemMinLevel >= FilterMinLevel) and (((itemMinLevel <= FilterMaxLevel)))) then
				if (not ItemDB_DBFrame_selectedClass or (itemType == ItemDB_DBFrame_selectedClass and (not cleansubclass or (itemSubType == cleansubclass and (not cleaninvtype or (itemEquipLoc == cleaninvtype)))))) then
					local itemValue = ItemDB_DBFrame_GetValue(itemLink) or -1
					if (not ItemDB_DBFrame_ItemList_HasValueCheckButton:GetChecked() or itemValue >= 0) then
						table_insert(ItemsList, getlisttable("name", itemName, "link", itemLink, "quality", itemRarity, "level", itemMinLevel, "ilevel", itemLevel, "texture", itemTexture, "stack", itemStackCount, "value", itemValue, "safe", safe))
					end
				end
			end
		end
		ItemDB_DBFrame_ItemList_ItemCount:SetText(#ItemsList.." / "..ItemsKnown.." items");
	end
	ItemDB_DBFrame_SortItems2();
	ItemDB_DBFrame_ItemList_Update();
end

function ItemDB_DBFrame_GetValue(itemID)
	if GetSellValue then
		return GetSellValue(getbaseid(itemID))
	end
	if (IsAddOnLoaded("KC_Items")) then
-- KC_Items < 0.94
--		return KC_Items:GetItemPrices(KC_Items:GetCode(itemID))
-- KC_Items >= 0.94
		return KC_Items.common:GetItemPrices(KC_Items.common:GetCode(itemID))
	end
	if (IsAddOnLoaded("ColaLight")) then
		return ColaLight.db.account.SellValues[getbaseid(itemID)]
	end
	if (SellValues and GetItemInfo(itemID)) then
		return SellValues[GetItemInfo(itemID)]
	end
	return nil
end

function ItemDB_DBFrame_ResetButton_OnClick()
	ItemDB_DBFrame_ItemList_Name:SetText("");
	ItemDB_DBFrame_ItemList_MinLevel:SetText("");
	ItemDB_DBFrame_ItemList_MaxLevel:SetText("");
	ItemDBRarityFilter = {1, 1, 1, 1, 1, 1, 1};
	ItemDB_DBFrame_ItemList_HasValueCheckButton:SetChecked(false);
	ItemDB_DBFrame_selectedClass = nil;
	ItemDB_DBFrame_selectedSubclass = nil;
	ItemDB_DBFrame_selectedInvtype = nil;
	ItemDB_DBFrame_Filters_Update();
	ItemsList = recyclelisttable(ItemsList)
	ItemDB_DBFrame_ItemList_Update()
	ItemDB_DBFrame_ItemList_NoResultsText:SetText(_G.BROWSE_SEARCH_TEXT)
end

-- Dropdown functions
function ItemDB_DBFrame_ItemList_RarityFilterDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, ItemDB_DBFrame_ItemList_RarityFilterDropDown_Initialize);
	UIDropDownMenu_SetText(FILTER, this);
	UIDropDownMenu_SetWidth(130, ItemDB_DBFrame_ItemList_RarityFilterDropDown);
end

function ItemDB_DBFrame_ItemList_RarityFilterDropDown_Initialize()
	for i=0, #ITEM_QUALITY_COLORS  do
		local info = {};
		local checked = nil;
		if (ItemDBRarityFilter[i + 1] == 1) then
			checked = 1;
		end
		local color = ITEM_QUALITY_COLORS[i];
		info.text = getglobal("ITEM_QUALITY"..i.."_DESC");
		info.textR = color.r;
		info.textG = color.g;
		info.textB = color.b;
		info.value = i;
		info.checked = checked;
		info.keepShownOnClick = 1;
		info.func = ItemDB_DBFrame_ItemList_RarityFilterDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function ItemDB_DBFrame_ItemList_RarityFilterDropDown_OnClick()
	if ( UIDropDownMenuButton_GetChecked() ) then
		ItemDBRarityFilter[this.value + 1] = 0;
	else
		ItemDBRarityFilter[this.value + 1] = 1;
	end
end

function ItemDB_DBFrame_ItemList_Update()
	local numItemsList = #ItemsList;
	local button, buttonName, iconTexture, itemName, color, moneyFrame, buttonHighlight;
	local offset = FauxScrollFrame_GetOffset(ItemDB_DBFrame_ItemList_BrowseScrollFrame);
--	local index;
--	local isLastSlotEmpty;
	local name, quality, level, texture, value, count;
	-- Update sort arrows
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseQualitySort, "quality");
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseNameSort, "name");
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseLevelSort, "level");
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseValueSort, "value");

	-- Show the no results text if no items found
	if ( numItemsList == 0 ) then
		ItemDB_DBFrame_ItemList_NoResultsText:Show();
	else
		ItemDB_DBFrame_ItemList_NoResultsText:Hide();
	end

	for i=1, ITEMDB_NUM_ITEMS_TO_DISPLAY do
		index = offset + i;
		button = getglobal("ItemDB_DBFrame_ItemList_ItemButton"..i);
		-- Show or hide auction buttons
		if ( index > numItemsList ) then
			button:Hide();
			-- If the last button is empty then set isLastSlotEmpty var
			if ( i == ITEMDB_NUM_ITEMS_TO_DISPLAY ) then
				isLastSlotEmpty = 1;
			end
		else
			button:Show();

			buttonName = "ItemDB_DBFrame_ItemList_ItemButton"..i;
			local cur_item = ItemsList[index]
			name = cur_item["name"];
			quality = cur_item["quality"];
			level = cur_item["level"];
			ilevel = cur_item["ilevel"];
			texture = cur_item["texture"];
			count = cur_item["stack"];
			value = cur_item["value"];

			if (not texture or texture == "") then
				texture = "Interface\\Icons\\INV_Misc_QuestionMark";
			end

			-- Resize button if there isn't a scrollbar
			buttonHighlight = getglobal("ItemDB_DBFrame_ItemList_ItemButton"..i.."Highlight");
			if ( numItemsList <= ITEMDB_NUM_ITEMS_TO_DISPLAY ) then
				button:SetWidth(625);
				buttonHighlight:SetWidth(589);
				ItemDB_DBFrame_ItemList_BrowseValueSort:SetWidth(207);
			else
				button:SetWidth(600);
				buttonHighlight:SetWidth(562);
				ItemDB_DBFrame_ItemList_BrowseValueSort:SetWidth(184);
			end
			-- Set name and quality color
			color = ITEM_QUALITY_COLORS[quality];
			itemName = getglobal(buttonName.."Name");
			itemName:SetText(name);
			itemName:SetVertexColor(color.r, color.g, color.b);
			-- Set level
			if ( level > UnitLevel("player") ) then
				getglobal(buttonName.."Level"):SetText((RED_FONT_COLOR_CODE.."%3d"..FONT_COLOR_CODE_CLOSE.."/%3d"):format(level, ilevel));
			else
				getglobal(buttonName.."Level"):SetText(("%3d/%3d"):format(level, ilevel));
			end
			-- Set item texture, count, and usability
			iconTexture = getglobal(buttonName.."ItemIconTexture");
			iconTexture:SetTexture(texture);
--~ 			if cur_item["safe"] then
				iconTexture:SetVertexColor(1.0, 1.0, 1.0);
--~ 			else
--~ 				iconTexture:SetVertexColor(1.0, 0.1, 0.1);
--~ 			end
			itemCount = getglobal(buttonName.."ItemCount");
			if ( count > 1 ) then
				itemCount:SetText(count);
				itemCount:Show();
			else
				itemCount:Hide();
			end
			-- Set item's value
			moneyFrame = getglobal(buttonName.."MoneyFrame");
			unsellableText = getglobal(buttonName.."UnsellableText");
			-- If not bidAmount set the bid amount to the min bid
			if ( value and value > 0 ) then
				MoneyFrame_Update(moneyFrame:GetName(), value);
				moneyFrame:SetPoint("RIGHT", buttonName, "RIGHT", 10, 3);
				moneyFrame:Show();
				unsellableText:Hide();
			elseif ( value and value == 0 ) then
				MoneyFrame_Update(moneyFrame:GetName(), 0);
				moneyFrame:Hide();
				unsellableText:Show();
			else
				MoneyFrame_Update(moneyFrame:GetName(), 0);
				moneyFrame:Hide();
				unsellableText:Hide();
			end

			-- Set highlight
--			if ( GetSelectedAuctionItem("list") and (offset + i) == GetSelectedAuctionItem("list") ) then
--				button:LockHighlight();
				
--			else
--				button:UnlockHighlight();
--			end
		end
	end
	FauxScrollFrame_Update(ItemDB_DBFrame_ItemList_BrowseScrollFrame, numItemsList, ITEMDB_NUM_ITEMS_TO_DISPLAY, ITEMDB_ITEM_BUTTON_HEIGHT);
end

-- SortButton functions
function ItemDB_DBFrame_SortButton_UpdateArrow(button, type, sort)
	if ( IsAuctionSortReversed(type, sort) ) then
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 1.0, 0);
	else
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 0, 1.0);
	end
end

function ItemDB_DBFrame_ItemButton_OnEnter(index)
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
	GameTooltip:SetHyperlink(ItemsList[index]["link"])
	GameTooltip_ShowCompareItem()
--~ 	if ( IsModifiedClick("DRESSUP") ) then
	if IsControlKeyDown() then
		ShowInspectCursor()
	else
		ResetCursor()
	end
end

function ItemDB_DBFrame_Link2Chat(index)
--~ 	if ItemsList[index]["safe"] then
		ChatEdit_InsertLink(ItemsList[index]["link"])
--~ 	else
--~ 		ItemDB_DBFrame_clickedButton = index
--~ 		StaticPopup_Show("ITEMDB_LINKING_WARNING")
--~ 	end
end

function ItemDB_DBFrame_ItemButton_GetLink(index)
	if (ItemsList[index]) then
		return ItemsList[index]["link"]
	end
end

function ItemDB_DBFrame_ItemButton_GetLinkFromID(itemID)
	local itemName, itemLink, itemRarity = GetItemInfo(itemID);
	if (itemName) then
		return itemLink;
	end
	return nil;
end

function ItemDB_DBFrame_SortButton_UpdateArrow(button, sort)
	if ( sort == ItemDBSortCurrent ) then
		getglobal(button:GetName().."Arrow"):Show();
	else
		getglobal(button:GetName().."Arrow"):Hide();
		return;
	end
	if ( ItemDBSortReverse == 1 ) then
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 1.0, 0);
	else
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 0, 1.0);
	end
end

function ItemDB_DBFrame_SortItems(sort)
	if ( sort == ItemDBSortCurrent ) then
		ItemDBSortReverse = 1 - ItemDBSortReverse;
	else
		ItemDBSortCurrent = sort;
	end
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseQualitySort, "quality");
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseNameSort, "name");
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseLevelSort, "level");
	ItemDB_DBFrame_SortButton_UpdateArrow(ItemDB_DBFrame_ItemList_BrowseValueSort, "value");
	ItemDB_DBFrame_SortItems2();
	ItemDB_DBFrame_ItemList_Update();
end

function ItemDB_DBFrame_SortItems2()
	if (ItemDBSortCurrent == "quality") then
		table.sort(ItemsList, ItemDB_DBFrame_SortItems_CompareQuality);
	end
	if (ItemDBSortCurrent == "name") then
		table.sort(ItemsList, ItemDB_DBFrame_SortItems_CompareName);
	end
	if (ItemDBSortCurrent == "level") then
		table.sort(ItemsList, ItemDB_DBFrame_SortItems_CompareLevel);
	end
	if (ItemDBSortCurrent == "value") then
		table.sort(ItemsList, ItemDB_DBFrame_SortItems_CompareValue);
	end
end

function ItemDB_DBFrame_SortItems_CompareQuality(a, b)
	if (not a or not b) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["quality"] < b["quality"]) or (ItemDBSortReverse == 1 and a["quality"] > b["quality"])) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["quality"] > b["quality"]) or (ItemDBSortReverse == 1 and a["quality"] < b["quality"])) then
		return false;
	end
	return ItemDB_DBFrame_SortItems_CompareName2(a, b);
end

function ItemDB_DBFrame_SortItems_CompareName(a, b)
	if (not a or not b) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["name"] < b["name"]) or (ItemDBSortReverse == 1 and a["name"] > b["name"])) then
		return true;
	else
		return false;
	end
end

function ItemDB_DBFrame_SortItems_CompareName2(a, b)
	if (not a or not b) then
		return true;
	end
	if (a["name"] < b["name"]) then
		return true;
	else
		return false;
	end
end

function ItemDB_DBFrame_SortItems_CompareLevel(a, b)
	if (not a or not b) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["level"] < b["level"]) or (ItemDBSortReverse == 1 and a["level"] > b["level"])) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["level"] > b["level"]) or (ItemDBSortReverse == 1 and a["level"] < b["level"])) then
		return false;
	end
	if ((ItemDBSortReverse == 0 and a["ilevel"] < b["ilevel"]) or (ItemDBSortReverse == 1 and a["ilevel"] > b["ilevel"])) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["ilevel"] > b["ilevel"]) or (ItemDBSortReverse == 1 and a["ilevel"] < b["ilevel"])) then
		return false;
	end
	return ItemDB_DBFrame_SortItems_CompareName2(a, b);
end

function ItemDB_DBFrame_SortItems_CompareValue(a, b)
	if (not a or not b) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["value"] == nil) or (ItemDBSortReverse == 1 and b["value"] == nil)) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and b["value"] == nil) or (ItemDBSortReverse == 1 and a["value"] == nil)) then
		return false;
	end
	if ((ItemDBSortReverse == 0 and a["value"] < b["value"]) or (ItemDBSortReverse == 1 and a["value"] > b["value"])) then
		return true;
	end
	if ((ItemDBSortReverse == 0 and a["value"] > b["value"]) or (ItemDBSortReverse == 1 and a["value"] < b["value"])) then
		return false;
	end
	return ItemDB_DBFrame_SortItems_CompareName2(a, b);
end

function ItemDB_DBFrame_Filters_Update()
	ItemDB_DBFrame_Filters_UpdateClasses();
	-- Update scrollFrame
	FauxScrollFrame_Update(ItemDB_DBFrame_FilterScrollFrame, #ITEMDB_OPEN_FILTER_LIST, ITEMDB_NUM_FILTERS_TO_DISPLAY, ITEMDB_ITEM_FILTER_HEIGHT);
end

function ItemDB_DBFrame_Filters_UpdateClasses()
	-- Initialize the list of open filters
	ITEMDB_OPEN_FILTER_LIST = {};
	for i, btype in ipairs(InventoryLib_types_base) do
		if ( ItemDB_DBFrame_selectedClass and ItemDB_DBFrame_selectedClass == btype ) then
			tinsert(ITEMDB_OPEN_FILTER_LIST, {btype, "class", i, 1});
			ItemDB_DBFrame_Filters_UpdateSubClasses(InventoryLib_types_sub[btype]);
		else
			tinsert(ITEMDB_OPEN_FILTER_LIST, {btype, "class", i, nil});
		end
	end
	
	-- Display the list of open filters
	local button, index, info, isLast;
	local offset = FauxScrollFrame_GetOffset(ItemDB_DBFrame_FilterScrollFrame);
	for i=1, ITEMDB_NUM_FILTERS_TO_DISPLAY do
		button = getglobal("ItemDB_DBFrame_FilterButton"..i);
		if ( #ITEMDB_OPEN_FILTER_LIST > ITEMDB_NUM_FILTERS_TO_DISPLAY ) then
			button:SetWidth(136);
		else
			button:SetWidth(156);
		end
		index = offset + i;
		if ( index <= #ITEMDB_OPEN_FILTER_LIST ) then
			info = ITEMDB_OPEN_FILTER_LIST[index];
			ItemDB_DBFrame_FilterButton_SetType(button, info[2], info[1], info[5]);
			button.index = info[3];
			if ( info[4] ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
			button:Show();
		else
			button:Hide();
		end
	end
end

function ItemDB_DBFrame_Filters_UpdateSubClasses(subtypes)
	if (not subtypes) then
		return;
	end
	local subClass;
	for i=1, #subtypes do
		subClass = HIGHLIGHT_FONT_COLOR_CODE..subtypes[i]..FONT_COLOR_CODE_CLOSE; 
		if ( ItemDB_DBFrame_selectedSubclass and ItemDB_DBFrame_selectedSubclass == subClass ) then
			tinsert(ITEMDB_OPEN_FILTER_LIST, {subtypes[i], "subclass", i, 1});
			local cleansubclass = nil;
			if (ItemDB_DBFrame_selectedSubclass) then
				_, _, cleansubclass = string.find(ItemDB_DBFrame_selectedSubclass, cleansubclasspattern);
			end
			if (InventoryLib_types_slot[ItemDB_DBFrame_selectedClass]) then
				ItemDB_DBFrame_Filters_UpdateInvTypes(InventoryLib_types_slot[ItemDB_DBFrame_selectedClass][cleansubclass]);
			end
		else
			tinsert(ITEMDB_OPEN_FILTER_LIST, {subtypes[i], "subclass", i, nil});
		end
	end
end

function ItemDB_DBFrame_Filters_UpdateInvTypes(invtypes)
	if (not invtypes) then
		return;
	end
	local invType, isLast;
	for i=1, #invtypes do
		invType = HIGHLIGHT_FONT_COLOR_CODE..invtypes[i]..FONT_COLOR_CODE_CLOSE; 
		if ( i == #invtypes ) then
			isLast = 1;
		end
		if ( ItemDB_DBFrame_selectedInvtype and ItemDB_DBFrame_selectedInvtype == invType ) then
			tinsert(ITEMDB_OPEN_FILTER_LIST, {invtypes[i], "invtype", i, 1, isLast});
		else
			tinsert(ITEMDB_OPEN_FILTER_LIST, {invtypes[i], "invtype", i, nil, isLast});
		end
	end
end

function ItemDB_DBFrame_FilterButton_SetType(button, type, text, isLast)
	local normalText = getglobal(button:GetName().."NormalText");
	local normalTexture = getglobal(button:GetName().."NormalTexture");
	local line = getglobal(button:GetName().."Lines");
	if ( type == "class" ) then
		button:SetText(text);
		normalText:SetPoint("LEFT", button, "LEFT", 4, 0);
		normalTexture:SetAlpha(1.0);	
		line:Hide();
	elseif ( type == "subclass" ) then
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", button, "LEFT", 12, 0);
		normalTexture:SetAlpha(0.4);
		line:Hide();
	elseif ( type == "invtype" ) then
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", button, "LEFT", 20, 0);
		normalTexture:SetAlpha(0.0);	
		if ( isLast ) then
			line:SetTexCoord(0.4375, 0.875, 0, 0.625);
		else
			line:SetTexCoord(0, 0.4375, 0, 0.625);
		end
		line:Show();
	end
	button.type = type; 
end

function ItemDB_DBFrame_Filter_OnClick()
	if ( this.type == "class" ) then
		if ( ItemDB_DBFrame_selectedClass == this:GetText() ) then
			ItemDB_DBFrame_selectedClass = nil;
		else
			ItemDB_DBFrame_selectedClass = this:GetText();
		end
		ItemDB_DBFrame_selectedSubclass = nil;
	elseif ( this.type == "subclass" ) then
		if ( ItemDB_DBFrame_selectedSubclass == this:GetText() ) then
			ItemDB_DBFrame_selectedSubclass = nil;
		else
			ItemDB_DBFrame_selectedSubclass = this:GetText();
		end
		ItemDB_DBFrame_selectedInvtype = nil;
	elseif ( this.type == "invtype" ) then
		if ( ItemDB_DBFrame_selectedInvtype == this:GetText() ) then
			ItemDB_DBFrame_selectedInvtype = nil;
		else
			ItemDB_DBFrame_selectedInvtype = this:GetText();
		end
	end
	ItemDB_DBFrame_Filters_Update()
end

