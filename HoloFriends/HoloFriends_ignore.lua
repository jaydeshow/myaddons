--[[
HoloFriends addon created by Holo, continued by Zappster

Get the latest version at www.curse-gaming.com

See HoloFriends_friends.lua for more informations  
]]

--[[

This file manages the ignorelist

]]

local selectedEntry = -1;
local lastClicked = -1;
local isGroupSelected = nil;
local ignoreList = {};
local MOVING_IGNORE = nil;
local TARGET_IGNORE = nil;
local lastAddedIgnore = nil;

HOLOIGNORE_TEMPLATE = "%1$s: |cffffffff%2$s|r";
HOLOIGNORE_DISPLAYED_NAMES = 18;
HOLOIGNORE_LIST = {};



-- this one hooks our functions and gets the realm list
function HoloIgnore_OnLoad()

	-- insert the drop down menu
	HoloIgnore_InsertDropDown();

	-- hide old ignores frame
	IgnoreListFrame:Hide();
	-- and replace with new
	IgnoreListFrame = HoloIgnoreFrame;
	
	-- modify the ADD_IGNORE popup
	StaticPopupDialogs["ADD_IGNORE"].OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		lastAddedIgnore = editBox:GetText();
		AddIgnore(lastAddedIgnore);
	end
	StaticPopupDialogs["ADD_IGNORE"].EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		lastAddedIgnore = editBox:GetText();
		AddIgnore(lastAddedIgnore);
		this:GetParent():Hide();
	end

	-- hide the button on the drag item
	HoloIgnoreNameButtonDrag:SetNormalTexture("");
	-- get the correct list
	ignoreList = HoloFriendsFuncs_LoadList(HOLOIGNORE_LIST, UnitName("player"));
	this:RegisterEvent("IGNORELIST_UPDATE");

end

function HoloIgnore_OnHide()
	-- prevents addition of wrong spelled ignores
	lastAddedIgnore = nil;
end

function HoloIgnore_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		HoloIgnore_OnLoad();
		this:UnregisterEvent("VARIABLES_LOADED");
		return;
	end
	if( event == "IGNORELIST_UPDATE" ) then
		if( lastAddedIgnore and (lastAddedIgnore ~= "") and HoloIgnore_IsSelectedEntryValid() ) then
			HoloIgnore_InsertNewIgnore(lastAddedIgnore, ignoreList[HoloIgnore_GetSelectedEntry()].group);
		end
		lastAddedIgnore = nil;
		HoloIgnore_List_Update();
		return;
	end	
end

function HoloIgnore_OnUpdate()
	if( MOVING_IGNORE ) then
		local slot;
		TARGET_IGNORE = nil;
		for index=1, HOLOIGNORE_DISPLAYED_NAMES, 1 do
			slot = getglobal("HoloIgnoreNameButton"..index);
			if( MouseIsOver(slot) ) then
				slot:LockHighlight();
				TARGET_IGNORE = slot;
				local pos = HoloIgnoreScrollFrame:GetVerticalScroll();
				if( index == 1 and pos >= FRIENDS_FRAME_IGNORE_HEIGHT ) then
					HoloIgnoreScrollFrameScrollBar:SetValue(pos - FRIENDS_FRAME_IGNORE_HEIGHT);
				end
				if( index == HOLOIGNORE_DISPLAYED_NAMES
				and (pos < FRIENDS_FRAME_IGNORE_HEIGHT*(table.getn(ignoreList) - HOLOIGNORE_DISPLAYED_NAMES)) ) then
					HoloIgnoreScrollFrameScrollBar:SetValue(pos + FRIENDS_FRAME_IGNORE_HEIGHT);
				end
			else
				slot:UnlockHighlight();
			end
		end
		MOVING_IGNORE:UnlockHighlight();
	end
end

-- check the local list for anomalies, at the moment this could be a missing name field
-- also does import FriendNotes
function HoloIgnore_CheckLocalList()
	local index = next(ignoreList);
	while( index ) do
		if( not ignoreList[index].name ) then
			table.remove(ignoreList, index);
		else
			index = next(ignoreList, index);
		end
	end
  
	-- check if group "ignore" is in our list
	if( not HoloFriendsFuncs_ContainsGroup(ignoreList, IGNORE) ) then
		HoloIgnore_InsertNewIgnore("1", IGNORE);
	end
end

-- check if all entries in server ignore list are in our list
function HoloIgnore_CheckServerList()

	local max = GetNumIgnores();
	-- data we get from server
	local name;
  local srvIgno = {};
	-- check if all ignores are in our list
	for index = 1, max, 1  do
		name = GetIgnoreName(index);
		playerIndex = HoloFriendsFuncs_ContainsPlayer(ignoreList, name);
		if( not playerIndex ) then
			HoloIgnore_InsertNewIgnore(name);
		end
	end
  
	--sort the entries
	table.sort(ignoreList, HoloFriendsFuncs_CompareEntry);
end


-- create and insert a new ignore entry
function HoloIgnore_InsertNewIgnore(name, group)
	if( not name or name == "" ) then
		return nil;
	end
	local temp = {};
	temp.name = name;
	if( not group or group == "" ) then
		temp.group = IGNORE;
	else
		temp.group = group;
	end
	-- if it has comment in friendslist, copy it
	wasFriend = HoloFriendsFuncs_ContainsPlayer(HoloFriends_GetList(), name);
	if( wasFriend ) then
		temp.comment = HoloFriends_GetComment(wasFriend);
	end
	table.insert(ignoreList, temp);
end


-- add a ignore
function HoloIgnore_AddIgnore(name)
	if( name and name ~= "" ) then
		lastAddedIgnore = name;
		AddIgnore(lastAddedIgnore);		
	elseif ( UnitCanCooperate("player", "target") ) then
		lastAddedIgnore = UnitName("target");
		AddIgnore(lastAddedIgnore);
	else
		StaticPopup_Show("ADD_IGNORE");
	end
end

-- remove the selected name
function HoloIgnore_RemoveIgnore()
	if( not isGroupSelected and HoloIgnore_IsSelectedEntryValid() ) then
		-- remove from original list
		DelIgnore(ignoreList[selectedEntry].name);
		-- remove from our list
		table.remove(ignoreList, selectedEntry);
		selectedEntry = -1;
	end
end

function HoloIgnore_List_Update()

	-- check the local list for errors
	HoloIgnore_CheckLocalList();
  
	-- check if server list has more entries than our
	HoloIgnore_CheckServerList();

  
  -- update scrollframe & buttons

	-- data stored locally
	local entry = {};
	local sumCounter = 0;

  -- group expanded/collapsed?
	local expanded = true;
  
  -- count visible entries and make an array that refers from offset x
  --(which means the x. visible line) to the corresponding index in ignoreList
  local offsetPlusTable = {};
  local offsetPlus = 0;
  local visibleCnt = 0;
  local visible = true;
  
  if (table.getn(ignoreList) == 0) then
    table.insert(offsetPlusTable, 0);
  end
  
  for k,entry in pairs(ignoreList) do
  
    if (not expanded) then
      visible = false;
    end
    
    -- entry = group?
    if (entry.name == "1") then
      expanded = true;
      visible = true;
    elseif (entry.name == "0") then
      expanded = false;
      visible = true;
    end
    
    if (visible) then
      table.insert(offsetPlusTable, offsetPlus);
      visibleCnt = visibleCnt +1;
    else
      offsetPlus = offsetPlus + 1;
    end
    
		-- count ignore entries
		if( not (entry.name == "1" or entry.name == "0") ) then
			sumCounter = sumCounter + 1;
		end
  end

	if ( HoloIgnore_IsSelectedEntryValid()
	and HoloFriendsFuncs_IsGroup(ignoreList, selectedEntry)
	and HoloFriendsFuncs_GetGroup(ignoreList, selectedEntry) ~= IGNORE ) then
		HoloIgnoreRemoveGroupButton:Enable();
		HoloIgnoreStopIgnoreButton:Disable();
	else
		HoloIgnoreRemoveGroupButton:Disable();
		HoloIgnoreStopIgnoreButton:Enable();
	end
  
  -- button and textures
	local button, buttonText, buttonIcon, buttonCheckBox;
  
  -- scrollframe offset
	local offset;
  
	FauxScrollFrame_Update(HoloIgnoreScrollFrame, visibleCnt, HOLOIGNORE_DISPLAYED_NAMES, 16);
  offset = FauxScrollFrame_GetOffset(HoloIgnoreScrollFrame);
  
  -- some counters
	local line = 1;
  local counter = 0;
	local index;
    
  -- set values / textures for all buttons
  expanded = true;
  
	while( line <= HOLOIGNORE_DISPLAYED_NAMES ) do

		index = counter + (offset +1) + offsetPlusTable[offset+1];

		entry = ignoreList[index];

		button = getglobal("HoloIgnoreNameButton"..line);
		button:SetID(index);
--		slot = getglobal("HoloIgnoreSlot"..line);
--		slot:SetID(index);

		if ( line > visibleCnt ) then
			button:Hide();
		else
			button:Show();
		end
		if( entry ) then

			if ( index == selectedEntry ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
      
			-- get textfield
			buttonText = getglobal("HoloIgnoreNameButton"..line.."Name");

			-- group header?
			if( entry.name == "1" or entry.name == "0" ) then
				buttonText:SetText(entry.group);
				buttonText:ClearAllPoints();
				buttonText:SetPoint("TOPLEFT", "HoloIgnoreNameButton"..line, "TOPLEFT", 20, 0);

				if( entry.name == "1" ) then
					button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
					expanded = true;
				else
					button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					expanded = false;
				end
			else -- no, we got a player
				if( expanded ) then
  				buttonText:SetText(format(TEXT(HOLOIGNORE_TEMPLATE),
              entry.name,
              HoloIgnore_GetComment(index))
  				);

					button:SetNormalTexture("");
--					buttonText:ClearAllPoints();
--					buttonText:SetPoint("TOPLEFT", "HoloIgnoreNameButton"..line, "TOPLEFT", 36, 0);
				else
					line = line - 1;
				end
			end
		end
		line = line + 1;
		counter = counter + 1;
	end
  
	-- ScrollFrame stuff
	local showScrollBar = nil;
	if ( table.getn(ignoreList) > HOLOIGNORE_DISPLAYED_NAMES ) then
		showScrollBar = 1;
	end
  
	-- set the appropriate width of textfield
	for index = 1, HOLOIGNORE_DISPLAYED_NAMES, 1 do
		button = getglobal("HoloIgnoreNameButton"..index);
		buttonText = getglobal("HoloIgnoreNameButton"..index.."Name");
		if ( showScrollBar ) then
			button:SetWidth(295);
			buttonText:SetWidth(256);
		else
			button:SetWidth(315);
			buttonText:SetWidth(276);
		end
	end
--[[
--old vals
		if ( showScrollBar ) then
			nameText:SetWidth(270);
		else
			nameText:SetWidth(295);
		end
	end
]]
end


-- drag and drop function
function HoloIgnore_NameButton_OnDragStart()
	if( HoloFriendsFuncs_IsGroup(ignoreList, this:GetID()) ) then
		return;
	end
	local cursorX, cursorY = GetCursorPosition();
	cursorX = cursorX / this:GetScale();
	cursorY = cursorY / this:GetScale();

	MOVING_IGNORE = HoloIgnoreNameButtonDrag;
	MOVING_IGNORE:SetID(this:GetID());
	HoloIgnoreNameButtonDragName:SetText(getglobal(this:GetName().."Name"):GetText());
	MOVING_IGNORE:ClearAllPoints();
	MOVING_IGNORE:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", cursorX+5, cursorY);
	MOVING_IGNORE:Show();
	MOVING_IGNORE:StartMoving();
end

-- drag and drop function
function HoloIgnore_NameButton_OnDragStop()
	if( not MOVING_IGNORE ) then
		return;
	end
	MOVING_IGNORE:StopMovingOrSizing();
	MOVING_IGNORE:Hide();
	MOVING_IGNORE:ClearAllPoints();

	if( not TARGET_IGNORE ) then
		return;
	end
	local targetIndex = TARGET_IGNORE:GetID();
	if( targetIndex > table.getn(ignoreList) ) then
		targetIndex = table.getn(ignoreList);
	end
	ignoreList[MOVING_IGNORE:GetID()].group = ignoreList[targetIndex].group;
	MOVING_IGNORE = nil;
	HoloIgnore_List_Update();
end

-- if we clicked on a header, toggle state and select header, otherwise just select entry
function HoloIgnore_NameButton_OnClick(button)
	lastClicked = this:GetID();
	if( not lastClicked ) then
		return;
	end
	if( button == "LeftButton" ) then
		selectedEntry = lastClicked;
		if( ignoreList[selectedEntry].name == "0" ) then
			isGroupSelected = 1;
			ignoreList[selectedEntry].name = "1";
		elseif( ignoreList[selectedEntry].name == "1" ) then
			isGroupSelected = 1;
			ignoreList[selectedEntry].name = "0";
		else
			isGroupSelected = nil;
		end
		HoloIgnore_List_Update();
	else
		--StaticPopup_Show("HOLOIGNORE_ADDCOMMENT", HoloFriendsFuncs_GetName(ignoreList, lastClicked));
		HoloIgnore_ShowListDropdown(lastClicked);
	end
end

function HoloIgnore_DeselectEntry()
  selectedEntry = -1;
end
-- END OF GUI FUNCTIONS

-- BEGIN OF GETTERS/SETTERS
-- check if index is valid
function HoloFriendsFuncs_IsListIndexValid(ignoreList, index)
	return ( index and (index > 0) and (index <= table.getn(ignoreList)));
end

-- returns true if entry is a group
function HoloFriendsFuncs_IsGroup(ignoreList, index)
	return ( HoloFriendsFuncs_IsListIndexValid(ignoreList, index) and (ignoreList[index].name == "0" or ignoreList[index].name == "1") );
end

-- set the name of a player
function HoloIgnore_SetName(index, name)
	if( (not HoloFriendsFuncs_IsListIndexValid(ignoreList, index)) or (not name) ) then
		return;
	end
	if( not HoloFriendsFuncs_IsGroup(ignoreList, index) ) then
		ignoreList[index].name = name;
	end
end



-- set the group of a player
function HoloIgnore_SetGroup(index, group)
	if( (not HoloFriendsFuncs_IsListIndexValid(ignoreList, index)) or (not group) ) then
		return;
	end
	
	ignoreList[index].group = group;
end


-- set the comment of a player
function HoloIgnore_SetComment(index, comment)
	if( (not HoloFriendsFuncs_IsListIndexValid(ignoreList, index)) or (not comment) ) then
		return;
	end

	ignoreList[index]. comment = comment;
end

-- returns the comment of the entry
function HoloIgnore_GetComment(index)
	if( HoloFriendsFuncs_IsListIndexValid(ignoreList, index) and ignoreList[index].comment ) then
		return ignoreList[index].comment;
	else
		return "";
	end
end

-- returns the id of the last clicked entry
function HoloIgnore_GetLastClickedIndex()
	return lastClicked;
end

-- returns the selected entry
function HoloIgnore_GetSelectedEntry()
	return selectedEntry;
end

-- returns true if the selected entry is valid
function HoloIgnore_IsSelectedEntryValid()
	return HoloFriendsFuncs_IsListIndexValid(ignoreList, selectedEntry);
end

function HoloIgnore_GetList()
  return ignoreList;
end

-- END OF GETTER/SETTERS

-- BEGIN OF ITEM TOOLTIP
function HoloIgnore_NameButton_SetTooltip()
	local index = this:GetID();
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText(HoloFriendsFuncs_GetName(ignoreList, index), 1.0, 1.0, 1.0);
	if( HoloIgnore_GetComment(index) ~= "" ) then
		GameTooltip:AddLine(HoloIgnore_GetComment(index), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end
	GameTooltip:Show();
end
-- END OF ITEM TOOLTIP