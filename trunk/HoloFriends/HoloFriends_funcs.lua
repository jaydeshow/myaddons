--[[
HoloFriends addon created by Holo, continued by Zappster

Get the latest version at www.curse-gaming.com

See HoloFriends_friends.lua for more informations  
]]

--[[

This file defines common functions for *_friends, *_ignore and *_share

]]


local version = 0.3;

--[[
  print a message in default chat with system colors
  
  @param msg - String
]]
function HoloFriendsFuncs_SystemMessage(msg)
	local info = ChatTypeInfo["SYSTEM"];
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, info.r, info.g, info.b, info.id);
	end
end


--[[
  add a group to the list
  
  @param list - Table
  @param group - String
]]
function HoloFriendsFuncs_AddGroup(list, group)
  
	if (not group or group == "" ) then
		return;
	end

	local groupIndex = HoloFriendsFuncs_ContainsGroup(list, group);
	if( not groupIndex ) then
		local temp = {};
		temp.name = "1";
		temp.group = group;

		table.insert(list, temp);

		table.sort(list, HoloFriendsFuncs_CompareEntry);
	end
end

--[[
  remove a group from the list
  
  @param list - Table
  @param index - int
  @param moveToGroup - String
]]
function HoloFriendsFuncs_RemoveGroup(list, index, moveToGroup)
DEFAULT_CHAT_FRAME:AddMessage("RemoveGroup "..index.." "..moveToGroup);
	local group = HoloFriendsFuncs_GetGroup(list, index);
	if( group == moveToGroup or group == FRIENDS or group == IGNORE or group == UNKNOWN ) then
		return;
	end
	table.remove(list, index);
	-- move all players belonging to this group
	for idx, entry in pairs(list) do
		if(entry.group == group ) then
			entry.group = moveToGroup;
		end
	end

	table.sort(list, HoloFriendsFuncs_CompareEntry);
end

--[[
  renames the given group from the list
  
  @param list - Table
  @param index - int
  @param name - String
]]
function HoloFriendsFuncs_RenameGroup(list, index, name)
	local group = HoloFriendsFuncs_GetGroup(list, index);
  -- who want's a group 'friends' on his igno-list? It's a cleaner API without any extra-argument
	if( group == FRIENDS or group == IGNORE or group == UNKNOWN ) then
		return;
	end
	-- move all players belonging to this group
	for idx, entry in pairs(list) do
		if(entry.group == group ) then
			entry.group = name;
		end
	end
end


--[[
  returns the index of given group name, nil if we do not have name in our list
  
  @param list - Table
  @param group - String
]]
function HoloFriendsFuncs_ContainsGroup(list, group)
	if ( not group ) then
		return nil;
	end
	local groupIndex = next(list);
	while( groupIndex ) do
		if( HoloFriendsFuncs_IsGroup(list, groupIndex) and
			HoloFriendsFuncs_GetGroup(list, groupIndex) == group)
		then
			return groupIndex;
		end
		groupIndex = next(list, groupIndex);
	end
	return nil;
end

--[[
  returns nil or the index of name on the list
  
  @param list - Table
  @param name - String
]]
function HoloFriendsFuncs_ContainsPlayer(list, name)
	if( not name or name == "" ) then
		return nil;
	end
	local playerIndex = next(list);
	while( playerIndex ) do
		if( HoloFriendsFuncs_GetName(list, playerIndex) == name ) then
			return playerIndex;
		end
		playerIndex = next(list, playerIndex);
	end
	return nil;
end


--[[
  returns the group of the entry or UNKNOWN
  
  @param list - Table
  @param index - int
]]
function HoloFriendsFuncs_GetGroup(list, index)
	if( not HoloFriendsFuncs_IsListIndexValid(list, index) ) then
		return UNKNOWN;
	end;
	
	return list[index].group;
end

--[[
  returns the name of the entry if it is a player, or group name if it is a group

  @param list - Table
  @param index - int
]]
function HoloFriendsFuncs_GetName(list, index)
	if( not HoloFriendsFuncs_IsListIndexValid(list, index) ) then
		return UNKNOWN;
	end;
	if( HoloFriendsFuncs_IsGroup(list, index) ) then
		return list[index].group;
	else
		return list[index].name;
	end
end


--[[
  returns true if entry is a group
  
  @param list - Table
  @param index - int
]]
function HoloFriendsFuncs_IsGroup(list, index)
	return ( HoloFriendsFuncs_IsListIndexValid(list, index) and (list[index].name == "0" or list[index].name == "1") );
end

--[[
  returns true if entry is a player
  
  @param list - Table
  @param index - int
]]
function HoloFriendsFuncs_IsPlayer(list, index)
	return ( HoloFriendsFuncs_IsListIndexValid(list, index) and not (list[index].name == "0" or list[index].name == "1") );
end


--[[
  check if index is valid
  
  @param list - Table
  @param index - int
]]
function HoloFriendsFuncs_IsListIndexValid(list, index)
	return ( index and (index > 0) and (index <= table.getn(list)));
end


--[[
  sorts players ascending after group and name
  
  @param a - Table (must have 'group' and 'name')
  @param b - Table (must have 'group' and 'name')
]]
function HoloFriendsFuncs_CompareEntry(a, b)
	return a.group..a.name < b.group..b.name;
end


--[[
  loads data from the char 'player' on the current realm
  
  @param completeList - Table
  @param player - String, name of character
]]
function HoloFriendsFuncs_LoadList(completeList, player)
	local listVersion = completeList.version;
	local realm = GetCVar("realmName");
	local result = nil;
  
	if( listVersion and listVersion > version ) then
    HoloFriendsFuncs_SystemMessage(format(HOLOFRIENDS_INVALIDLISTVERSION, listVersion));
    -- HOLOFRIENDS_LIST or HOLOIGNORE_LIST won't be used
		completeList = {};
		completeList.version = version;
		
		completeList[realm] = {};
		completeList[realm][player] = {};
		result = completeList[realm][player];
  else
		-- set version to latest
		completeList.version = version;
    
		-- get realm list
    result = completeList[realm];
		-- new realm?
		if( not result ) then
			completeList[realm] = {};
			result = completeList[realm];
		end
		-- get player list
		result = completeList[realm][player];
		if( not result ) then
			completeList[realm][player] = {};
			result = completeList[realm][player];
		end
	end

	return result;
end

function HoloFriendsFuncs_IsDataAvailable(list, charName)
	local realm = GetCVar("realmName");
  local result = list[realm][charName];
  
  if (result) then
    return true;
  else
    return false;
  end
end


--[[
  returns all chars from the current realm (no reference to the original data)
  
  @param completeList - Table
]]
function HoloFriendsFuncs_GetAvailableCharacters(completeList)
	local realm = GetCVar("realmName");
	local result = {};
  
	-- get realm list
  local list = completeList[realm];
  for key, entry in pairs(list) do
    table.insert(result, key);
  end
  
  -- sort the result
  table.sort(result, function (a,b) return a < b; end);
  
  return result;
end

function HoloFriendsFuncs_DeleteChar(char)
  
  local fList = HOLOFRIENDS_LIST;
  local iList = HOLOIGNORE_LIST;
	local realm = GetCVar("realmName");
  
  local exists = fList[realm][char];
  if (exists == nil) then
    HoloFriendsFuncs_SystemMessage(format(HOLOFRIENDS_DELETECHARNOTFOUND, char));
    return;
  end
  
  fList[realm][char] = nil;
  iList[realm][char] = nil;
  
  -- deleted yourself ...
  if (UnitName("player") == char) then
    HoloFriends_List_Update();
    HoloIgnore_List_Update();
  end
  
  --Share visible?
  if (HoloFriendsShareFrame:IsShown()) then
    HoloFriendsShare_OnShow();
  end
  
  HoloFriendsFuncs_SystemMessage(format(HOLOFRIENDS_DELETECHARDONE, char));
end

function HoloFriendsFuncs_Version()
  return version;
end

--[[
  @param isoDate - a date in iso format: %Y-%m-%d %H:%M
  @param dateFormat -  format of the return value (i.e. %d.%m.%Y %H:%M)
--]]
function HoloFriendsFuncs_GetDateString(isoDate, dateFormat)
  local Y = string.sub(isoDate, 1, 4);
  local m = string.sub(isoDate, 6, 7);
  local d = string.sub(isoDate, 9, 10);
  local H = string.sub(isoDate, 12, 13);
  local M = string.sub(isoDate, 15, 16);
  
  local retStr = dateFormat;
  retStr = string.gsub(retStr, "%%Y", Y);
  retStr = string.gsub(retStr, "%%m", m);
  retStr = string.gsub(retStr, "%%d", d);
  retStr = string.gsub(retStr, "%%H", H);
  retStr = string.gsub(retStr, "%%M", M);
  
  return retStr;
end
