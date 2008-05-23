--[[
HoloFriends addon created by Holo, continued by Zappster

Get the latest version at www.curse-gaming.com

See HoloFriends_friends.lua for more informations  
]]

--[[

This file defines pop-up-menus for *_friends and *_ignore

]]


-- BEGIN OF TARGET AND LIST DROP DOWN MENU
function HoloFriends_UnitPopup_OnClick()
	local button = UnitPopupMenus[this.owner][this.value];
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local name = dropdownFrame.name;
	local id = dropdownFrame.userData;

	if ( this.value == "HOLOFRIENDS_ADDCOMMENT" ) then
		if( dropdownFrame == HoloFriendsDropDown ) then
			StaticPopup_Show("HOLOFRIENDS_ADDCOMMENT", name);
		elseif( dropdownFrame == HoloIgnoreDropDown ) then
			StaticPopup_Show("HOLOIGNORE_ADDCOMMENT", name);
		end
	elseif ( this.value == "HOLOFRIENDS_ADDGROUP" ) then
		StaticPopup_Show("HOLOFRIENDS_ADDGROUP");
	elseif ( this.value == "HOLOFRIENDS_REMOVEGROUP" ) then
		if( dropdownFrame == HoloFriendsDropDown ) then
			HoloFriendsFuncs_RemoveGroup(HoloFriends_GetList(), id, FRIENDS);
      HoloFriends_DeselectEntry();
      HoloFriends_List_Update();
		elseif( dropdownFrame == HoloIgnoreDropDown ) then
			HoloFriendsFuncs_RemoveGroup(HoloIgnore_GetList(), id, IGNORE);
      HoloIgnore_DeselectEntry();
      HoloIgnore_List_Update();
		end
	elseif ( this.value == "HOLOFRIENDS_ADDFRIEND" ) then
		HoloFriends_AddFriend(name);
	elseif ( this.value == "HOLOFRIENDS_ADDIGNORE" ) then
		HoloIgnore_AddIgnore(name);
	elseif ( this.value == "HOLOFRIENDS_WHOREQUEST" ) then
		SendWho("n-"..name);
	elseif ( this.value == "HOLOFRIENDS_RENAMEGROUP" ) then
		if( dropdownFrame == HoloFriendsDropDown ) then
			StaticPopup_Show("HOLOFRIENDS_RENAMEGROUP");
		elseif( dropdownFrame == HoloIgnoreDropDown ) then
			StaticPopup_Show("HOLOIGNORE_RENAMEGROUP");
		end
	else
    -- no-op
	end
end

function HoloFriends_UnitPopup_OnUpdate(elapsed)

	if ( not DropDownList1:IsVisible() ) then
		return;
	else
		-- If none of the untipopup frames are visible then return
		for index, value in pairs(UnitPopupFrames) do
			if ( UIDROPDOWNMENU_OPEN_MENU == value ) then
				break;
			elseif ( index == getn(UnitPopupFrames) ) then
				return;
			end
		end
	end

	local dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	local which = dropdown.which;
	local name = dropdown.name;
	if( not name ) then
		name = UnitName(dropdown.unit);
	end
	if( (which == "PARTY") or (which == "PLAYER") or (which == "RAID") or (which == "FRIEND") ) then
		local index = table.getn(UnitPopupMenus[which]);
		if( HoloFriendsFuncs_ContainsPlayer(HoloIgnore_GetList(),name) ) then
			UIDropDownMenu_DisableButton(1, index);
		end
		if( HoloFriendsFuncs_ContainsPlayer(HoloFriends_GetList(), name) ) then
			UIDropDownMenu_DisableButton(1, index - 1);
		end
	end
end

function HoloFriends_ExtendDropdown(dropdown)
  
	if ( not (dropdown and type(dropdown) == "table") ) then
		return;
	end

	table.insert(dropdown, table.getn(dropdown), "HOLOFRIENDS_ADDFRIEND");
	table.insert(dropdown, table.getn(dropdown), "HOLOFRIENDS_ADDIGNORE");
	table.insert(dropdown, table.getn(dropdown), "HOLOFRIENDS_WHOREQUEST");
end

function HoloFriends_InsertDropDown()
	-- list drop down
	UnitPopupButtons["HOLOFRIENDS_ADDCOMMENT"] = { text = TEXT(HOLOFRIENDS_ADDCOMMENT), dist = 0 };
	UnitPopupButtons["HOLOFRIENDS_ADDGROUP"] = { text = TEXT(HOLOFRIENDS_ADDGROUP), dist = 0 };
	UnitPopupButtons["HOLOFRIENDS_RENAMEGROUP"] = { text = TEXT(HOLOFRIENDS_RENAMEGROUP), dist = 0 };
	UnitPopupButtons["HOLOFRIENDS_REMOVEGROUP"] = { text = TEXT(HOLOFRIENDS_REMOVEGROUP), dist = 0 };
	UnitPopupButtons["HOLOFRIENDS_ADDFRIEND"] = { text = TEXT(ADD_FRIEND), dist = 0 };
	UnitPopupButtons["HOLOFRIENDS_ADDIGNORE"] = { text = TEXT(IGNORE_PLAYER), dist = 0 };
	UnitPopupButtons["HOLOFRIENDS_WHOREQUEST"] = { text = TEXT(HOLOFRIENDS_WHOREQUEST), dist = 0 };

	UnitPopupMenus["HOLOFRIENDS_LIST"] = {"WHISPER", "INVITE", "HOLOFRIENDS_ADDCOMMENT", "HOLOFRIENDS_RENAMEGROUP", "HOLOFRIENDS_ADDGROUP", "HOLOFRIENDS_REMOVEGROUP", "HOLOFRIENDS_WHOREQUEST", "CANCEL" };

	--extend the existing drop down menus
	HoloFriends_ExtendDropdown(UnitPopupMenus["PARTY"]);
	HoloFriends_ExtendDropdown(UnitPopupMenus["PLAYER"]);
	HoloFriends_ExtendDropdown(UnitPopupMenus["RAID"]);
	HoloFriends_ExtendDropdown(UnitPopupMenus["FRIEND"]);
end
-- END OF LIST DROP DOWN MENU

-- HoloFriends specific functions
function HoloFriends_ShowListDropdown(id)
	HideDropDownMenu(1);
	HoloFriendsDropDown.initialize = HoloFriends_ListDropDown_Initialize;
	HoloFriendsDropDown.displayMode = "MENU";
	HoloFriendsDropDown.name = HoloFriendsFuncs_GetName(HoloFriends_GetList(), id);
	HoloFriendsDropDown.userData = id;
	ToggleDropDownMenu(1, nil, HoloFriendsDropDown, "cursor");
	-- hide the invite and whisper buttons
	if( not HoloFriends_IsConnected(id) ) then
		UIDropDownMenu_DisableButton(1, 2);
		UIDropDownMenu_DisableButton(1, 3);
		UIDropDownMenu_DisableButton(1, 8);
	end
	-- hide the remove group button
	if( not HoloFriendsFuncs_IsGroup(HoloFriends_GetList(), id) or HoloFriendsFuncs_GetGroup(HoloFriends_GetList(), id) == FRIENDS ) then
		UIDropDownMenu_DisableButton(1, 5);
		UIDropDownMenu_DisableButton(1, 7);
	end
end

function HoloFriends_ListDropDown_Initialize()
	UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "HOLOFRIENDS_LIST", nil, HoloFriendsDropDown.name, HoloFriendsDropDown.userData);
end
-- end of HoloFriends specific functions


-- HoloIgnore specific functions
function HoloIgnore_InsertDropDown()
	UnitPopupMenus["HOLOIGNORE_LIST"] = {"HOLOFRIENDS_ADDCOMMENT", "HOLOFRIENDS_RENAMEGROUP", "HOLOFRIENDS_REMOVEGROUP", "CANCEL" };
end

function HoloIgnore_ShowListDropdown(id)
	HideDropDownMenu(1);
	HoloIgnoreDropDown.initialize = HoloIgnore_ListDropDown_Initialize;
	HoloIgnoreDropDown.displayMode = "MENU";
	HoloIgnoreDropDown.name = HoloFriendsFuncs_GetName(HoloIgnore_GetList(), id);
	HoloIgnoreDropDown.userData = id;
	ToggleDropDownMenu(1, nil, HoloIgnoreDropDown, "cursor");

	-- hide the remove group button
	if( not HoloFriendsFuncs_IsGroup(HoloIgnore_GetList(), id) or HoloFriendsFuncs_GetGroup(HoloIgnore_GetList(), id) == IGNORE ) then
		UIDropDownMenu_DisableButton(1, 3);
		UIDropDownMenu_DisableButton(1, 4);
	end
end

function HoloIgnore_ListDropDown_Initialize()
	UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "HOLOIGNORE_LIST", nil, HoloIgnoreDropDown.name, HoloIgnoreDropDown.userData);
end
-- end of HoloFriends specific functions