--[[
HoloFriends addon created by Holo, continued by Zappster

Get the latest version at www.curse-gaming.com

This adds an enhanced friends list.
You will love it ;)

Zappster


Change Log:
0.3:  - new feature by Ithilyn: scan all not monitored friends via /who
      - new feature by Ithilyn: last seen in comments
      - minor bugfixes
0.23:
    	- new feature: added share-friends-dialog
    	- minor bugfixes
    	- refactoring
    	- removed support for FriendNotes, HoloWar
0.22:
  	- new friends will be added with notify by default (if there are less than 50 friends on your notifylist)
0.21:
  	- menu entries are back
  	- bugfix: scrollbar definition in .xml
0.20:
--	- updated to LUA 5.1 and Wow 2.0, the menu entries were removed (I'm still working on that issue)
	- based on a HoloFriends version with enhancements from Veithflo
0.11:
	- bugfix: fixed nil error introduced with 0.10, I should stop for today;(
0.10:
	- bugfix: reenabled send message and invite button, sorry for this bug:(
0.09:
	- bugfix: add friend/ignore entry is no longer clickable if player is already in one of your lists
	- bugfix: fixed nil bug when trying to move ignore group
	- new feature: groups can now be renamed
	- new feature: the number of online friends is now displayed in the lower left corner
	- new feature: you can now have more than 50 friends in your list, the online state of 49 can be monitored
	- new feature: added who request to following drop down menues: target, party, raid, who, guild, and chat
		(the entries in the guild and who menu are maybe useless, but who, guild and chat all use the same drop down)
0.08:
	- localisation: included french localisation done by Feu
	- localisation: removed error messages on non english/german/french clients, an empty icon is displayed instead
	- localisation: class icons do show up on french clients
	- bugfix: fixed a bug when dragging groups
	- bugfix: shift click works as intended now in the add ignore dialog
	- new feature: added add friend and add ignore to following drop down menues: target, party, raid, who, guild, and chat
		(the entries in the guild menu are maybe useless, but who, guild and chat alll use the same drop down)
0.07:
	- new feature: added ignore list support
	- bugfix: removed a field error that could occur when removing the last group and it was empty
	- bugfix: drop down menu items are disabled if not applicable
0.06:
	- bugfix: the list entry text is now truncated if it is too long
0.05:
	- feature request: does import FriendNotes
	- feature request: new checkbox: toggles show/hide offline friends
	- bugfix: another way to add wrong spelled friends eliminated
0.04:
	- bugfix: wrong spelled friends are no longer added
	- changed: inserted more nil and index sanity checks
0.03:
	- bugfix: fixed bug with empty list and resulting nil error
0.02:
	- bugfix: drag and drop with long friendslists
	- feature request: added FriendsFacts functionality
	- feature request: friends are now added to the selected group
		(if none is selected, they are added to the default list)
0.01:
	- initial release
]]

--[[

This file manages the friendslist, but also the initialisation of the addon.

]]

local MAX_SRV_FRIENDS = 50;

local selectedEntry = -1;
local lastClicked = -1;
local isGroupSelected = false;
local list = {};
local MOVING_FRIEND = nil;
local TARGET_FRIEND = nil;
local lastAddedFriend = nil;
local ignoreAddFriendsSysMsg = false;
local ignoreRemoveFriendsSysMsg = false;


HOLOFRIENDS_DISPLAYED_NAMES = 18;
HOLOFRIENDS_LIST = {};
if HOLOFRIENDS_LIST_TEMPLATE then
	-- HOLOFRIENDS_LIST_TEMPLATE = "%1$s - |cffffffff%3$s|r";
else
	HOLOFRIENDS_LIST_TEMPLATE = "%1$s - |cffffffff%3$s|r";
end
if HOLOFRIENDS_LIST_OFFLINE_TEMPLATE then
	-- HOLOFRIENDS_LIST_OFFLINE_TEMPLATE = "|cff999999%1$s - %3$s|r";
else
	HOLOFRIENDS_LIST_OFFLINE_TEMPLATE = "|cff999999%1$s - %3$s|r";
end
HOLOFRIENDS_LIST_NEAR_TEMPLATE = "%1$s - |cff55bb00%3$s|r";
if HOLOFRIENDS_LEVEL_TEMPLATE then
	-- HOLOFRIENDS_LEVEL_TEMPLATE = "%s %2$s";
else
	HOLOFRIENDS_LEVEL_TEMPLATE = "|cff999999"..string.sub(FRIENDS_LEVEL_TEMPLATE, 1, string.find(FRIENDS_LEVEL_TEMPLATE, " ")).." %2$s|r";--%1$s 
end
HOLOFRIENDS_SHOW_OFFLINE_FRIENDS = 1;

-- this one hooks our functions and gets the realm list
function HoloFriends_OnLoad()
  
	-- hook functions
  hooksecurefunc("UnitPopup_OnClick", HoloFriends_UnitPopup_OnClick);
  hooksecurefunc("ChatFrame_OnEvent", HoloFriends_UnitPopup_OnUpdate);
  hooksecurefunc("ChatFrame_OnEvent", HoloFriends_ChatFrame_OnEvent);
  hooksecurefunc("SendMailFrame_SendeeAutocomplete", HoloFriends_SendMailFrame_SendeeAutocomplete);
  
	-- insert the drop down menu
	HoloFriends_InsertDropDown();

	-- hide old friends frame
	FriendsListFrame:Hide();
	-- and replace with new
	FriendsListFrame = HoloFriendsFrame;

	-- modify the ADD_FRIEND popup
	StaticPopupDialogs["ADD_FRIEND"].OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriends_AddFriend(editBox:GetText());
	end
	StaticPopupDialogs["ADD_FRIEND"].EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriends_AddFriend(editBox:GetText());
		this:GetParent():Hide();
	end

	-- hide the button on the drag item
	HoloFriendsNameButtonDrag:SetNormalTexture("");
	HoloFriendsNameButtonDragClassIcon:Hide();
	HoloFriendsNameButtonDragServer:Hide();
	HoloFriendsNameButtonDragName:SetPoint("TOPLEFT", "HoloFriendsNameButtonDrag", "TOPLEFT", 20, 0);
	HoloFriendsNameButtonDrag:Hide();
	-- get the correct list
	list = HoloFriendsFuncs_LoadList(HOLOFRIENDS_LIST, UnitName("player"));

	this:RegisterEvent("FRIENDLIST_UPDATE");
	this:RegisterEvent("WHO_LIST_UPDATE");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
  
  SlashCmdList["HOLOFRIENDS"] = HoloFriends_SlashCommand;
	SLASH_HOLOFRIENDS1 = "/holofriends";
	SLASH_HOLOFRIENDS2 = "/hfriends";

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(format(HOLOFRIENDS_LOADED, HoloFriendsFuncs_Version()));
	end
end


function HoloFriends_SlashCommand(msg)

 	local cmd, subCmd = HoloFriends_GetCmd(msg);

  if (cmd == "delete") then
    local dialog = StaticPopup_Show ("HOLOFRIENDS_DELETECHARDATA", subCmd);
    if(dialog) then
       dialog.data = subCmd;
    end
  end
  
end

-- from wowWiki
function HoloFriends_GetCmd(msg)
 	if msg then
 		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters

 		if a then
 			return c, strsub(msg, b+2);
 		else	
 			return "";
 		end
 	end
end



function HoloFriends_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		HoloFriends_OnLoad();
		this:UnregisterEvent("VARIABLES_LOADED");
		return;
	end
	if( event == "FRIENDLIST_UPDATE" ) then
		if( lastAddedFriend and (lastAddedFriend ~= "") and HoloFriends_IsSelectedEntryValid() ) then
			HoloFriends_InsertNewEntry(lastAddedFriend, list[HoloFriends_GetSelectedEntry()].group);
		end
		lastAddedFriend = nil;
		HoloFriends_List_Update();
		return;
	end
	if( event == "WHO_LIST_UPDATE" ) then
		HoloFriends_CheckWhoListResult();
	end
	if( event == "CHAT_MSG_SYSTEM" ) then
		if( string.find(arg1, ".*"..string.sub(WHO_NUM_RESULTS, 3)) ) then
			HoloFriends_CheckWhoListResult();
		end
		return;
	end
end

function HoloFriends_OnUpdate()
	if( MOVING_FRIEND ) then
		local slot;
		TARGET_FRIEND = nil;
		for index=1, HOLOFRIENDS_DISPLAYED_NAMES, 1 do
			slot = getglobal("HoloFriendsNameButton"..index);
			if( MouseIsOver(slot) ) then
				slot:LockHighlight();
				TARGET_FRIEND = slot;
				local pos = HoloFriendsScrollFrame:GetVerticalScroll();
				if( index == 1 and pos >= FRIENDS_FRAME_IGNORE_HEIGHT ) then
					HoloFriendsScrollFrameScrollBar:SetValue(pos - FRIENDS_FRAME_IGNORE_HEIGHT);
				end
				if( index == HOLOFRIENDS_DISPLAYED_NAMES
				and (pos < FRIENDS_FRAME_IGNORE_HEIGHT*(table.getn(list) - HOLOFRIENDS_DISPLAYED_NAMES)) ) then
					HoloFriendsScrollFrameScrollBar:SetValue(pos + FRIENDS_FRAME_IGNORE_HEIGHT);
				end
			else
				slot:UnlockHighlight();
			end
		end
		MOVING_FRIEND:UnlockHighlight();
        end
end

-- check the local list
function HoloFriends_CheckLocalList()
	local index = next(list);
	while( index ) do
		if( not list[index].name ) then
			table.remove(list, index);
		else
      if (list[index].imported) then
        list[index].imported = nil;
        HoloFriends_SetNotify(index, (GetNumFriends() < MAX_SRV_FRIENDS), false);
      end
			index = next(list, index);
		end
	end
  
	-- check if group "friends" is in our list
	if( not HoloFriendsFuncs_ContainsGroup(list, FRIENDS) ) then
		HoloFriends_InsertNewEntry("1", FRIENDS);
	end
end

-- check if all entries in server friendslist are in our list
function HoloFriends_CheckServerList()

	-- cleanup
	local index = next(list);
	while( index ) do
		if( list[index].level and (list[index].level == UNKNOWN or list[index].level == 0 or list[index].level == "") ) then
			list[index].level = nil;
		end
		list[index].notify = nil;
		index = next(list, index);
	end

	local max = GetNumFriends();
	-- data we get from server
	local name;
	local level;
	local class;
	local area;
	local connected;
  local onstate;
  local playerIndex;
	-- check if all friends are in our list
	for index = 1, max, 1  do
		name, level, class, area, connected, onstate = GetFriendInfo(index);

		playerIndex = HoloFriendsFuncs_ContainsPlayer(list, name);
		if( playerIndex ) then
			if( level ~= 0 ) then list[playerIndex].level  = level; end
			if( class ~= UNKNOWN ) then list[playerIndex].class  = class; end
			if( area ~= UNKNOWN ) then 
				if ((GetRealZoneText() == area) and ( connected == 1)) then
					list[playerIndex].area  = "|cff55bb00"..area.." "..onstate;
				else
					list[playerIndex].area  = area.." "..onstate;
				end
			end
			list[playerIndex].connected  = connected;
            if (connected == 1) then
			   list[playerIndex].lastSeen  = date("%Y-%m-%d %H:%M");
            end
			list[playerIndex].notify = 1;
		else
			HoloFriends_InsertNewEntry(name, nil, level, class, area, connected, 1);
			--ignoreRemoveFriendsSysMsg = true;
			--RemoveFriend(name);
		end
	end

	--sort the entries
	table.sort(list, HoloFriendsFuncs_CompareEntry);
end

-- returns the index in server list of given name
--[[
function HoloFriends_GetServerListIndex(name)
	local max = GetNumFriends();
	-- data we get from server
	local serverName;
	-- check if friend is in our list
	for index = 1, max, 1  do
		serverName, _, _, _, _ = GetFriendInfo(index);
		if( name == serverName ) then
			return index;
		end
	end
	return nil;
end
]]


-- create and insert a new friend entry
-- @param name
-- @param group
-- @param level - may be nil
-- @param class - may be nil
-- @param area - may be nil
-- @param connected - may be nil
-- @param notify - may be nil
function HoloFriends_InsertNewEntry(name, group, level, class, area, connected, notify)
	if( not name or name == "" ) then
		return nil;
	end
	local temp = {};
	temp.name = name;
	if( not group or group == "" ) then
		temp.group = FRIENDS;
	else
		temp.group = group;
	end
	temp.level = level;
	if( class ~= UNKNOWN ) then temp.class = class; end
	temp.area = area;
	temp.connected = connected;
	temp.notify  = notify;
	-- if it has comment in ignore list, copy it
	wasIgnore = HoloFriendsFuncs_ContainsPlayer(HoloIgnore_GetList(), name);
	if( wasIgnore ) then
		temp.comment = HoloIgnore_GetComment(wasIgnore);
	end
	table.insert(list, temp);
	--table.sort(list, HoloFriendsFuncs_CompareEntry);
end


-- add a friend
function HoloFriends_AddFriend(name)
	if( name and name ~= "" ) then
		-- enforce first letter uppercase
		-- name = string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)
		lastAddedFriend = name;
		HoloFriends_DeselectEntry();
   
		if (not HoloFriendsFuncs_ContainsPlayer(list, lastAddedFriend)) then
			if (GetNumFriends() < MAX_SRV_FRIENDS) then
				AddFriend(lastAddedFriend);
			else
	      		HoloFriends_InsertNewEntry(lastAddedFriend, "", "", "", "", "", 0);
				HoloFriendsFuncs_SystemMessage(format(HOLOFRIENDS_ONLINE_STATUS_DISABLED, lastAddedFriend));
			end
		end
    
	elseif ( UnitCanCooperate("player", "target") ) then
		lastAddedFriend = UnitName("target");
		
		if (not HoloFriendsFuncs_ContainsPlayer(list, lastAddedFriend)) then
			if (GetNumFriends() < MAX_SRV_FRIENDS) then
				AddFriend(lastAddedFriend);
			else
	      		HoloFriends_InsertNewEntry(lastAddedFriend, "", "", "", "", "", 0);
				HoloFriendsFuncs_SystemMessage(format(HOLOFRIENDS_ONLINE_STATUS_DISABLED, lastAddedFriend));
			end
		end
	else
		StaticPopup_Show("ADD_FRIEND");
	end
end

-- remove the selected friend
function HoloFriends_RemoveFriend()
	if( not isGroupSelected and HoloFriends_IsSelectedEntryValid() ) then
		local notify = HoloFriends_GetNotify(selectedEntry);
		if( notify ) then
			-- remove from original list
			RemoveFriend(list[selectedEntry].name);
		end
		-- remove from our list
		table.remove(list, selectedEntry);
		HoloFriends_DeselectEntry();
		if( not notify ) then
			HoloFriends_List_Update();
		end
	end
end

function HoloFriends_SendMessage()
	if(not isGroupSelected and HoloFriends_IsSelectedEntryValid() ) then
		local name = list[selectedEntry].name
		if ( not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat("/w "..name.." ");
		else
			ChatFrameEditBox:SetText("/w "..name.." ");
		end
		ChatEdit_ParseText(ChatFrame1.editBox, 0);
	end
end

function HoloFriends_GroupInvite()
	if(not isGroupSelected and HoloFriends_IsSelectedEntryValid() ) then
		InviteUnit(list[selectedEntry].name);
	end
end


-- BEGIN OF GETTERS/SETTERS

-- returns true if entry is connected
function HoloFriends_IsConnected(index)
	return ( HoloFriendsFuncs_IsListIndexValid(list, index) and list[index].connected );
end

-- set the name of a player
function HoloFriends_SetName(index, name)
	if( (not HoloFriendsFuncs_IsListIndexValid(list, index)) or (not name) ) then
		return;
	end
	if( not HoloFriendsFuncs_IsGroup(list, index) ) then
		list[index].name = name;
	end
end


-- set the group of a player
function HoloFriends_SetGroup(index, group)
	if( (not HoloFriendsFuncs_IsListIndexValid(list, index)) or (not group) ) then
		return;
	end
	
	list[index].group = group;
end


-- set the level of a player
function HoloFriends_SetLevel(index, level)
	if( (not HoloFriendsFuncs_IsListIndexValid(list, index)) or (not level) ) then
		return;
	end
	if( not HoloFriendsFuncs_IsGroup(list, index) ) then
		list[index].level = level;
	end
end

-- returns the level of the entry, or HOLOFRIENDS_UNKNOWN if no data is available
function HoloFriends_GetLevel(index, bColor)
	if( HoloFriendsFuncs_IsListIndexValid(list, index) and list[index].level ) then
		if (bColor == false) then
			return list[index].level;
		else
			color = GetDifficultyColor(list[index].level);
			return string.format("|cff%02x%02x%02x%s|r"
				,color.r * 255
				,color.g * 255
				,color.b * 255
				,list[index].level);
			-- return list[index].level;
		end
	else
		return HOLOFRIENDS_UNKNOWN;
	end
end

-- set the class of a player
function HoloFriends_SetClass(index, class)
	if( (not HoloFriendsFuncs_IsListIndexValid(list, index)) or (not class) ) then
		return;
	end
	if( not HoloFriendsFuncs_IsGroup(list, index) ) then
		list[index].class = class;
	end
end

-- returns the class of the entry, or HOLOFRIENDS_UNKNOWN if no data is available
function HoloFriends_GetClass(index)
	if( HoloFriendsFuncs_IsListIndexValid(list, index) and list[index].class ) then
		return list[index].class;
	else
		return HOLOFRIENDS_UNKNOWN;
	end
end

-- Add By Cosin For Class Color
function HoloFriends_GetColoredClass(index)
	local class = HoloFriends_GetClass(index);
	if (class ~= HOLOFRIENDS_UNKNOWN and HOLOFRIENDS_CLASS_COLOR_KEY and HOLOFRIENDS_CLASS_COLOR_KEY[class]) then
		colorKey = HOLOFRIENDS_CLASS_COLOR_KEY[class];
		class = string.format("|cff%02x%02x%02x%s|r"
			,RAID_CLASS_COLORS[colorKey].r * 255
			,RAID_CLASS_COLORS[colorKey].g * 255
			,RAID_CLASS_COLORS[colorKey].b * 255
			,class);
	end
	return class;
end

-- Add By Cosin For Name Color
function HoloFriends_GetColoredName(name, class)
	local name = name;
	if (class ~= HOLOFRIENDS_UNKNOWN and HOLOFRIENDS_CLASS_COLOR_KEY and HOLOFRIENDS_CLASS_COLOR_KEY[class]) then
		colorKey = HOLOFRIENDS_CLASS_COLOR_KEY[class];
		name = string.format("|cff%02x%02x%02x%s|r"
			,RAID_CLASS_COLORS[colorKey].r * 255
			,RAID_CLASS_COLORS[colorKey].g * 255
			,RAID_CLASS_COLORS[colorKey].b * 255
			,name);
	end
	return name;
end

-- set the area of a player
function HoloFriends_SetArea(index, area)
	if( (not HoloFriendsFuncs_IsListIndexValid(list, index)) or (not area) ) then
		return;
	end
	if( not HoloFriendsFuncs_IsGroup(list, index) ) then
		list[index].area = area;
	end
end

-- returns the area of the entry, or UNKNOWN if no data is available
function HoloFriends_GetArea(index)
	if( HoloFriendsFuncs_IsListIndexValid(list, index) and list[index].area ) then
--~ 		if ( GetRealZoneText() == list[index].area ) then
--~ 			return "|cff55bb00"..list[index].area;
--~ 		else
			return list[index].area;
--~ 		end
	else
		return UNKNOWN;
	end
end

-- set the lastSeen value of a player
function HoloFriends_SetLastSeen(index, lastSeen)
	if( (not HoloFriendsFuncs_IsListIndexValid(list, index)) or (not lastSeen) ) then
		return;
	end
	if( not HoloFriendsFuncs_IsGroup(list, index) ) then
		list[index].lastSeen = lastSeen;
	end
end

-- returns the lastSeen value of the entry, or UNKNOWN if no data is available
function HoloFriends_GetLastSeen(index)
	if( HoloFriendsFuncs_IsListIndexValid(list, index) and list[index].lastSeen ) then
		return list[index].lastSeen;
	else
		return UNKNOWN;
	end
end

-- set the comment of a player
function HoloFriends_SetComment(index, comment)
	if( (not HoloFriendsFuncs_IsListIndexValid(list, index)) or (not comment) ) then
		return;
	end

	list[index].comment = comment;
end

-- returns the comment of the entry
function HoloFriends_GetComment(index)
	if( HoloFriendsFuncs_IsListIndexValid(list, index) and list[index].comment ) then
		return list[index].comment;
	else
		return "";
	end
end

-- returns the id of the last clicked entry
function HoloFriends_GetLastClickedIndex()
	return lastClicked;
end

-- returns the selected entry
function HoloFriends_GetSelectedEntry()
	return selectedEntry;
end

-- returns true if the selected entry is valid
function HoloFriends_IsSelectedEntryValid()
	return HoloFriendsFuncs_IsListIndexValid(list, selectedEntry);
end


-- set the notify flag of a player
function HoloFriends_SetNotify(index, notify, silent)
	if( not HoloFriendsFuncs_IsListIndexValid(list, index) ) then
		return;
	end
	list[index].notify = notify;
	if( notify ) then
		-- add to server list
		AddFriend(list[index].name);
		if( not silent) then
			HoloFriendsFuncs_SystemMessage(format(HOLOFRIENDS_ONLINE_STATUS_ENABLED, list[index].name));
		end
	else
		-- remove from server list
		RemoveFriend(list[index].name);
		if( not silent ) then
			HoloFriendsFuncs_SystemMessage(format(HOLOFRIENDS_ONLINE_STATUS_DISABLED, list[index].name));
		end
	end
end

function HoloFriends_GetNotify(index)
	if( HoloFriendsFuncs_IsListIndexValid(list, index) ) then
		return list[index].notify;
	else
		return nil;
	end
end

function HoloFriends_GetList()
  return list;
end

-- END OF GETTER/SETTERS

function HoloFriends_CheckWhoListResult()
	local charname, guildname, level, race, class, zone, unknown;
	local numWho = GetNumWhoResults();
	for index=1, numWho do
		charname, guildname, level, race, class, zone, unknown = GetWhoInfo(index);
		playerIndex = HoloFriendsFuncs_ContainsPlayer(list, charname);
		if( playerIndex and not HoloFriends_GetNotify(playerIndex) ) then
			if( level ~= 0 ) then list[playerIndex].level  = level; end
			if( class ~= UNKNOWN ) then list[playerIndex].class  = class; end
			if( zone ~= UNKNOWN ) then list[playerIndex].area  = zone; end
			list[playerIndex].connected  = ( (level ~= 0) and (class ~= UNKNOWN) and (zone ~= UNKNOWN) );
                        list[playerIndex].lastSeen  = date("%Y-%m-%d %H:%M");
		end
	end
	HoloFriends_List_Update();
end


-- BEGIN OF ITEM TOOLTIP
function HoloFriends_NameButton_SetTooltip()
	local index = this:GetID();
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText(HoloFriendsFuncs_GetName(list, index), 1.0, 1.0, 1.0);
	if( not HoloFriendsFuncs_IsGroup(list, index) ) then
		local info;
		if( HoloFriends_IsConnected(index) ) then
			info = format(TEXT(HOLOFRIENDS_LEVEL_TEMPLATE), HoloFriends_GetLevel(index), HoloFriends_GetColoredClass(index)); --HoloFriends_GetClass(index));
		else
			local class = HoloFriends_GetClass(index)
			if (class and class ~= HOLOFRIENDS_UNKNOWN) then
				info = "|cff999999"..format(TEXT(HOLOFRIENDS_LEVEL_TEMPLATE_OFFLINE), HoloFriends_GetLevel(index, false), HoloFriends_GetClass(index)).."|r";
			else
				info = "|cff999999"..UNKNOWN.."|r";
			end
		end
		GameTooltip:AddLine(info, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end
	if( HoloFriends_GetComment(index) ~= "" ) then
		GameTooltip:AddLine(HoloFriends_GetComment(index), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end
	if( not HoloFriendsFuncs_IsGroup(list, index) ) then
    lastSeen = HoloFriends_GetLastSeen(index)
    
	  if (lastSeen == UNKNOWN) then
			lastSeen = HOLOFRIENDS_NEVERSEEN;
		else
      lastSeen = HoloFriendsFuncs_GetDateString(lastSeen, HOLOFRIENDS_DATEFORMAT);
			lastSeen = HOLOFRIENDS_LASTSEEN..": " .. lastSeen
	  end
	  GameTooltip:AddLine(lastSeen, 1, 1, 1, 1);
	end
	GameTooltip:Show();
end
-- END OF ITEM TOOLTIP


-- START OF GUI FUNCTIONS
-- drag and drop function
function HoloFriends_NameButton_OnDragStart()
	if( HoloFriendsFuncs_IsGroup(list, this:GetID()) ) then
		return;
	end
	local cursorX, cursorY = GetCursorPosition();
	cursorX = cursorX / this:GetScale();
	cursorY = cursorY / this:GetScale();

	MOVING_FRIEND = HoloFriendsNameButtonDrag;
	MOVING_FRIEND:SetID(this:GetID());
	HoloFriendsNameButtonDragName:SetText(getglobal(this:GetName().."Name"):GetText());
	MOVING_FRIEND:ClearAllPoints();
	MOVING_FRIEND:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", cursorX+5, cursorY);
	MOVING_FRIEND:Show();
	MOVING_FRIEND:StartMoving();
end

-- drag and drop function
function HoloFriends_NameButton_OnDragStop()
	if( not MOVING_FRIEND ) then
		return;
	end
	MOVING_FRIEND:StopMovingOrSizing();
	MOVING_FRIEND:Hide();
	MOVING_FRIEND:ClearAllPoints();

	if( not TARGET_FRIEND ) then
		return;
	end
	local targetIndex = TARGET_FRIEND:GetID();
	if( targetIndex > table.getn(list) ) then
		targetIndex = table.getn(list);
	end
	list[MOVING_FRIEND:GetID()].group = list[targetIndex].group;
	MOVING_FRIEND = nil;
	HoloFriends_List_Update();
end

-- if we clicked on a header, toggle state and select header, otherwise just select entry
function HoloFriends_NameButton_OnClick(button)
	lastClicked = this:GetID();
	if( not lastClicked ) then
		return;
	end

	if( button == "LeftButton" ) then
		selectedEntry = lastClicked;
    -- group selected
		if( list[selectedEntry].name == "0" ) then
			isGroupSelected = true;
			list[selectedEntry].name = "1";
		elseif( list[selectedEntry].name == "1" ) then
			isGroupSelected = tru
			list[selectedEntry].name = "0";
		else
    -- player selected
      isGroupSelected = false;
			if( not HoloFriends_GetNotify(selectedEntry) ) then
				SendWho("n-"..HoloFriendsFuncs_GetName(list, selectedEntry));
                                -- this is broken code.  GetNumWhoResults() won't be ready until later.  Hence the need 
                                -- to click on a disconnected user twice for it to actually disappear -- ithilyn 2007/06/06
				local numWho = GetNumWhoResults();
				if ( numWho == 0 ) then
					list[selectedEntry].connected  = false;
				end
			end
		end
  	HoloFriends_List_Update();
	else
		HoloFriends_ShowListDropdown(lastClicked);	
	end
end

function HoloFriends_CheckBox_OnClick()
		if( this:GetChecked() and GetNumFriends() == MAX_SRV_FRIENDS ) then
			this:SetChecked(nil);
			HoloFriendsFuncs_SystemMessage(HOLOFRIENDS_LIMITALERT);
		else
			HoloFriends_SetNotify(this:GetParent():GetID(), this:GetChecked());
			if ( this:GetChecked() ) then
				ignoreAddFriendsSysMsg = true;
				PlaySound("igMainMenuOptionCheckBoxOff");
			else
				ignoreRemoveFriendsSysMsg = true;
				PlaySound("igMainMenuOptionCheckBoxOn");
			end
		end
	HoloFriends_List_Update();
end

function HoloFriends_List_Update()

  -- check local data
  HoloFriends_CheckLocalList();
  
	-- check if server list has more entries than our
	HoloFriends_CheckServerList();
  
  -- update scrollframe & buttons

	-- data stored locally
	local entry = {};
	local onlineCounter = 0;
	local sumCounter = 0;

  -- group expanded/collapsed?
	local expanded = true;
  
  -- count visible entries and make an array that refers from offset x
  --(which means the x. visible line) to the corresponding index in friendsList
  local offsetPlusTable = {};
  local offsetPlus = 0;
  local visibleCnt = 0;
  local visible = true;
  
  if (table.getn(list) == 0) then
    table.insert(offsetPlusTable, 0);
  end
  
  for k,entry in pairs(list) do
  
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
    -- entry = player .. on- or offline?
    elseif (not (HOLOFRIENDS_SHOW_OFFLINE_FRIENDS ==1)) then
      if (expanded and entry.connected) then
        visible = true;
      else
        visible = false;
      end
    end
    

    if (visible) then
      table.insert(offsetPlusTable, offsetPlus);
      visibleCnt = visibleCnt +1;
    else
      offsetPlus = offsetPlus + 1;
    end
    
		-- count online and all friends
		if( entry.connected ) then
			onlineCounter = onlineCounter + 1;
		end
		if( not (entry.name == "1" or entry.name == "0") ) then
			sumCounter = sumCounter + 1;
		end
  end
  
  -- enable/disable remove-buttons
	if ( HoloFriends_IsSelectedEntryValid()
	and HoloFriendsFuncs_IsGroup(list, selectedEntry)
	and HoloFriendsFuncs_GetGroup(list, selectedEntry) ~= FRIENDS ) then
		HoloFriendsRemoveGroupButton:Enable();
		HoloFriendsRemoveFriendButton:Disable();
	else
		HoloFriendsRemoveGroupButton:Disable();
		HoloFriendsRemoveFriendButton:Enable();
	end
  
  -- button and textures
	local button, buttonText, buttonIcon, buttonCheckBox;
  
  -- scrollframe offset
	local offset;
  
	FauxScrollFrame_Update(HoloFriendsScrollFrame, visibleCnt, HOLOFRIENDS_DISPLAYED_NAMES, 16);
  offset = FauxScrollFrame_GetOffset(HoloFriendsScrollFrame);
  
  -- some counters
	local line = 1;
  local counter = 0;
	local index;
    
  -- set values / textures for all buttons
  expanded = true;
	while( line <= HOLOFRIENDS_DISPLAYED_NAMES ) do

		index = counter + (offset +1) + offsetPlusTable[offset+1];

		entry = list[index];

		button = getglobal("HoloFriendsNameButton"..line);
		button:SetID(index);

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
      
			-- get textfield, icon and checkbox
			buttonText = getglobal("HoloFriendsNameButton"..line.."Name");
			buttonIcon = getglobal("HoloFriendsNameButton"..line.."ClassIcon");
			buttonCheckBox = getglobal("HoloFriendsNameButton"..line.."Server");

			-- group header?
			if( entry.name == "1" or entry.name == "0" ) then
				buttonText:SetText(entry.group);
				buttonText:ClearAllPoints();
				buttonText:SetPoint("TOPLEFT", "HoloFriendsNameButton"..line, "TOPLEFT", 20, 0);
				buttonIcon:Hide();
				buttonCheckBox:Hide();

				if( entry.name == "1" ) then
					button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
					expanded = true;
				else
					button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					expanded = false;
				end
			else -- no, we got a player
				if( expanded and (entry.connected or HOLOFRIENDS_SHOW_OFFLINE_FRIENDS == 1) ) then
					if( entry.connected ) then
						if (GetRealZoneText() == HoloFriends_GetArea(index)) then
							buttonText:SetText(format(TEXT(HOLOFRIENDS_LIST_NEAR_TEMPLATE),
									HoloFriends_GetColoredName(entry.name, entry.class), -- entry.name,
									HoloFriends_GetLevel(index),
									HoloFriends_GetArea(index))
							);
						else
							buttonText:SetText(format(TEXT(HOLOFRIENDS_LIST_TEMPLATE),
									HoloFriends_GetColoredName(entry.name, entry.class), -- entry.name,
									HoloFriends_GetLevel(index),
									HoloFriends_GetArea(index))
							);
						end
					else
						buttonText:SetText(format(TEXT(HOLOFRIENDS_LIST_OFFLINE_TEMPLATE),
								entry.name,
								HoloFriends_GetLevel(index, false),
								HoloFriends_GetArea(index))
						);
					end
					button:SetNormalTexture("");
					buttonCheckBox:Show();
					buttonCheckBox:SetChecked(entry.notify);
					
					local class = entry.class;
					if( class and class ~= UNKNOWN ) then
						local coords = HOLOFRIENDS_CLASS_ICON_TCOORDS[strupper(class)];
						if( coords ) then
							buttonIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
						else
							buttonIcon:SetTexCoord(0.25, 0.5, 0.5, 0.75);
						end
						buttonIcon:Show();
						buttonText:ClearAllPoints();
						buttonText:SetPoint("LEFT", buttonIcon:GetName(), "RIGHT", 3, 0);
					else
						buttonText:ClearAllPoints();
						buttonText:SetPoint("TOPLEFT", "HoloFriendsNameButton"..line, "TOPLEFT", 36, 0);
						buttonIcon:Hide();
					end
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
	if ( table.getn(list) > HOLOFRIENDS_DISPLAYED_NAMES ) then
		showScrollBar = 1;
	end
  
	-- set the appropriate width of textfield
	for index = 1, HOLOFRIENDS_DISPLAYED_NAMES, 1 do
		button = getglobal("HoloFriendsNameButton"..index);
		buttonText = getglobal("HoloFriendsNameButton"..index.."Name");
		buttonIcon = getglobal("HoloFriendsNameButton"..index.."ClassIcon"); 
		if ( showScrollBar ) then
			button:SetWidth(295);
			if( buttonIcon:IsVisible() ) then
				buttonText:SetWidth(240);
			else
				buttonText:SetWidth(256);
			end
		else
			button:SetWidth(315);
			if( buttonIcon:IsVisible() ) then
				buttonText:SetWidth(260);
			else
				buttonText:SetWidth(276);
			end
		end
	end
	HoloFriendsOnline:SetText(format("%s %d / %d", HOLOFRIENDS_ONLINE, onlineCounter, sumCounter));
end

function HoloFriends_OnHide()
	-- prevents addition of wrong spelled friends
	lastAddedFriend = nil;
end

function HoloFriends_DeselectEntry()
  selectedEntry = -1;
end
-- END OF GUI FUNCTIONS

-- START OF SEND MAIL AUTOCOMPLETION
function HoloFriends_SendMailFrame_SendeeAutocomplete()
	local text = this:GetText();
	local textlen = strlen(text);
	local numFriends, name;

	-- First check local friends list
    	numFriends = table.getn(list);
	for i=1, numFriends do
		if( not (HoloFriendsFuncs_IsGroup(list, i) or HoloFriends_GetNotify(i)) ) then
			name = HoloFriendsFuncs_GetName(list, i);
			if ( strfind(strupper(name), "^"..strupper(text)) ) then
				this:SetText(name);
				this:HighlightText(textlen, -1);
				return;
			end
		end
	end
end
-- END OF SEND MAIL AUTOCOMPLETION

-- START OF CHAT MESSAGE EVENT HANDLER HOOK
function HoloFriends_ChatFrame_OnEvent(event)
	if ( event == "CHAT_MSG_SYSTEM" ) then
		if( ignoreAddFriendsSysMsg
		and string.find(arg1, ".*"..string.sub(ERR_FRIEND_ADDED_S, 3)) ) then
			ignoreAddFriendsSysMsg = false;
			return;
		end
		if( ignoreRemoveFriendsSysMsg 
		and string.find(arg1, ".*"..string.sub(ERR_FRIEND_REMOVED_S, 3)) ) then
			ignoreRemoveFriendsSysMsg = false;
			return;
		end
	end

end
-- END OF CHAT MESSAGE EVENT HANDLER HOOK
