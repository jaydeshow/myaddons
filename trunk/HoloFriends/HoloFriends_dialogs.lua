--[[
HoloFriends addon created by Holo, continued by Zappster

Get the latest version at www.curse-gaming.com

See HoloFriends_friends.lua for more informations  
]]

--[[

This file defines static dialogs for *_friends, *_ignore and *_share

]]

-- ---------------------------------------------------------------
-- HoloFriends dialogs
-- ---------------------------------------------------------------

-- dialog to add comment
StaticPopupDialogs["HOLOFRIENDS_ADDCOMMENT"] = {
	text = TEXT(HOLOFRIENDS_ADDCOMMENT_LONG),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 500,
	hasWideEditBox = 1,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		HoloFriends_SetComment(HoloFriends_GetLastClickedIndex(), editBox:GetText());
	end,
	OnShow = function()
		this:SetWidth(420);
		local editBox = getglobal(this:GetName().."WideEditBox");
		editBox:SetText(HoloFriends_GetComment(HoloFriends_GetLastClickedIndex()));
		getglobal(this:GetName().."WideEditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."WideEditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		HoloFriends_SetComment(HoloFriends_GetLastClickedIndex(), editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

-- the dialog for adding groups
StaticPopupDialogs["HOLOFRIENDS_ADDGROUP"] = {
	text = TEXT(HOLOFRIENDS_ADDGROUP),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 24,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_AddGroup(HoloFriends_GetList(), editBox:GetText());
    HoloFriends_DeselectEntry();
    HoloFriends_List_Update();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_AddGroup(HoloFriends_GetList(), editBox:GetText());
    HoloFriends_DeselectEntry();
    HoloFriends_List_Update();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

-- the dialog for renaming groups
StaticPopupDialogs["HOLOFRIENDS_RENAMEGROUP"] = {
	text = TEXT(HOLOFRIENDS_RENAMEGROUP),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 24,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_RenameGroup(HoloFriends_GetList(), HoloFriends_GetLastClickedIndex(), editBox:GetText());
    HoloFriends_DeselectEntry();
    HoloFriends_List_Update();
	end,
	OnShow = function()
		local editBox = getglobal(this:GetName().."EditBox");
		editBox:SetText(HoloFriendsFuncs_GetGroup(HoloFriends_GetList(), HoloFriends_GetLastClickedIndex()));
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_RenameGroup(HoloFriends_GetList(), HoloFriends_GetLastClickedIndex(), editBox:GetText());
    HoloFriends_DeselectEntry();
    HoloFriends_List_Update();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

-- the dialog for deleting a char
StaticPopupDialogs["HOLOFRIENDS_DELETECHARDATA"] = {
  text = HOLOFRIENDS_DELETECHARDLG,
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
  OnAccept = function(char) HoloFriendsFuncs_DeleteChar(char); end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

-- ---------------------------------------------------------------
-- HoloIgnore dialogs
-- ---------------------------------------------------------------

-- dialog to add comment
StaticPopupDialogs["HOLOIGNORE_ADDCOMMENT"] = {
	text = TEXT(HOLOFRIENDS_ADDCOMMENT_LONG),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 500,
	hasWideEditBox = 1,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		HoloIgnore_SetComment(HoloIgnore_GetLastClickedIndex(), editBox:GetText());
		HoloIgnore_List_Update();
	end,
	OnShow = function()
		this:SetWidth(420);
		local editBox = getglobal(this:GetName().."WideEditBox");
		editBox:SetText(HoloIgnore_GetComment(HoloIgnore_GetLastClickedIndex()));
		getglobal(this:GetName().."WideEditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."WideEditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		HoloIgnore_SetComment(HoloIgnore_GetLastClickedIndex(), editBox:GetText());
		HoloIgnore_List_Update();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

-- the dialog for adding groups
StaticPopupDialogs["HOLOIGNORE_ADDGROUP"] = {
	text = TEXT(HOLOFRIENDS_ADDGROUP),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 24,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_AddGroup(HoloIgnore_GetList(), editBox:GetText());
    HoloIgnore_DeselectEntry();
    HoloIgnore_List_Update();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_AddGroup(HoloIgnore_GetList(), editBox:GetText());
    HoloIgnore_DeselectEntry();
    HoloIgnore_List_Update();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

-- the dialog for renaming groups
StaticPopupDialogs["HOLOIGNORE_RENAMEGROUP"] = {
	text = TEXT(HOLOFRIENDS_RENAMEGROUP),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 24,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_RenameGroup(HoloIgnore_GetList(), HoloIgnore_GetLastClickedIndex(), editBox:GetText());
		HoloIgnore_DeselectEntry();
		HoloIgnore_List_Update();
	end,
	OnShow = function()
		local editBox = getglobal(this:GetName().."EditBox");
		editBox:SetText(HoloFriendsFuncs_GetGroup(HoloIgnore_GetList(), HoloIgnore_GetLastClickedIndex()));
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		HoloFriendsFuncs_RenameGroup(HoloIgnore_GetList(), HoloIgnore_GetLastClickedIndex(), editBox:GetText());
		HoloIgnore_DeselectEntry();
		HoloIgnore_List_Update();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};
