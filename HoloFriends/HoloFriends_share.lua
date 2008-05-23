--[[
HoloFriends addon created by Holo, continued by Zappster

Get the latest version at www.curse-gaming.com

See HoloFriends_friends.lua for more informations  
]]

--[[

This file manages the share-friends dialog

]]

local NUM_SCROLLFRAME_BUTTONS = 10;

local charList = {};
local friendsList = {};
local selectedFriendsListKey = "";
local charListCheckedCnt = 0;
local friendsListCheckedCnt = 0;

function HoloFriendsShare_OnLoad() 

end

function HoloFriendsShare_OnShow()
  charList = HoloFriendsShare_copyCharList(HoloFriendsFuncs_GetAvailableCharacters(HOLOFRIENDS_LIST));
  selectedFriendsListKey = UnitName("player");
  charListCheckedCnt = 0;
  friendsListCheckedCnt = 0;
  
  -- be certain, the name exists in HOLOFRIENDS_LIST, otherwise
  -- HoloFriendsFuncs_LoadList() would create a new entry
  if (HoloFriendsFuncs_IsDataAvailable(HOLOFRIENDS_LIST, selectedFriendsListKey)) then
    -- use a copy, not the original data
    friendsList = HoloFriendsShare_copyFriendslist(HoloFriendsFuncs_LoadList(HOLOFRIENDS_LIST, selectedFriendsListKey));
  end
  
  for i=1,NUM_SCROLLFRAME_BUTTONS do
    getglobal("HoloFriendsShareSource"..i.."ShareIcon"):Hide();
    getglobal("HoloFriendsShareTarget"..i.."ShareIcon"):Hide();
  end
  
  HoloFriendsShare_SourceScrollFrame_Update();
  HoloFriendsShare_TargetScrollFrame_Update();
  
  HoloFriendsShareFrameButtonShare:Disable();
end

function HoloFriendsShare_OnHide()
  charList = {};
  friendsList = {};
  selectedFriendsListKey = "";
  charListCheckedCnt = 0;
  friendsListCheckedCnt = 0;
  
  HoloFriendsShareButton:Enable();
end

--[[
  HoloFriendsShare_SourceScrollFrame_Update() and HoloFriendsShare_TargetScrollFrame_Update()
--]]
function HoloFriendsShare_ScrollFrame_Update(list, scrollFrame, btnName)

	--data stored locally
	local entry = {};

  -- group expanded/collapsed?
	local expanded = true;
  
  -- count visible entries and make an array that refers from offset x
  --(which means the x. visible line) to the corresponding index in list
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
    end
    
    if (visible) then
      table.insert(offsetPlusTable, offsetPlus);
      visibleCnt = visibleCnt +1;
    else
      offsetPlus = offsetPlus + 1;
    end
  end
    
  -- button and textures
	local button, buttonText, buttonIcon;
  
  -- scrollframe offset
	local offset;
  
	FauxScrollFrame_Update(scrollFrame, visibleCnt, NUM_SCROLLFRAME_BUTTONS, 16);
  offset = FauxScrollFrame_GetOffset(scrollFrame);
  
  -- some counters
	local line = 1;
  local counter = 0;
	local index;
  
  -- set values / textures for all buttons
  expanded = true;
	while( line <= NUM_SCROLLFRAME_BUTTONS ) do

		index = counter + (offset +1) + offsetPlusTable[1];

		entry = list[index];

		button = getglobal(btnName..line);
		button:SetID(index);

		if ( line > visibleCnt ) then
			button:Hide();
		else
			button:Show();
		end
		if( entry ) then

			-- get textfields and icon
			buttonText = getglobal(btnName..line.."Name");
      buttonIcon = getglobal(btnName..line.."ShareIcon");

			-- group header?
			if( entry.name == "1" or entry.name == "0" ) then
				buttonText:SetText(entry.group);
        buttonIcon:Hide();

				if( entry.name == "1" ) then
					button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
					expanded = true;
				else
					button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					expanded = false;
				end
			else -- no, we got a player
				if( expanded ) then
          buttonText:SetText(entry.name);
					button:SetNormalTexture("");
          
          if (entry.share) then
            buttonIcon:Show();
          else
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
end

function HoloFriendsShare_SourceScrollFrame_Update()
  HoloFriendsShare_ScrollFrame_Update(friendsList, HoloFriendsShareSourceScrollFrame, "HoloFriendsShareSource");
end

function HoloFriendsShare_TargetScrollFrame_Update()
  HoloFriendsShare_ScrollFrame_Update(charList, HoloFriendsShareTargetScrollFrame, "HoloFriendsShareTarget");
end

function HoloFriendsShare_Source_OnClick(button)
  local icon = getglobal(button:GetName().."ShareIcon");
  local index = button:GetID();
  

  if (HoloFriendsFuncs_IsGroup(friendsList, index)) then
    if (friendsList[index].name == "0") then
      friendsList[index].name = "1" --show
    else
      friendsList[index].name = "0" --collapse
    end
    
    HoloFriendsShare_SourceScrollFrame_Update();
  else
    -- show/hide checkbox-symbol
    if (friendsList[index].share) then
      friendsList[index].share = false;
      friendsListCheckedCnt = friendsListCheckedCnt -1;
      icon:Hide();
    else
      friendsList[index].share = true;
      friendsListCheckedCnt = friendsListCheckedCnt +1;
      icon:Show();
    end
    
    if (charListCheckedCnt >0 and friendsListCheckedCnt >0) then
      HoloFriendsShareFrameButtonShare:Enable();
    else
      HoloFriendsShareFrameButtonShare:Disable();
    end
  end
end

function HoloFriendsShare_Target_OnClick(button)
  local icon = getglobal(button:GetName().."ShareIcon");
  local index = button:GetID();
  
  -- show/hide checkbox-symbol
  if (charList[index].share) then
    charList[index].share = false;
    charListCheckedCnt = charListCheckedCnt -1;
    icon:Hide();
  else
    charList[index].share = true;
    charListCheckedCnt = charListCheckedCnt +1;
    icon:Show();
  end
  
  if (charListCheckedCnt >0 and friendsListCheckedCnt >0) then
    HoloFriendsShareFrameButtonShare:Enable();
  else
    HoloFriendsShareFrameButtonShare:Disable();
  end
end

--[[
 Char-DropDown
]]

function HoloFriendsShare_CharDropDown_OnShow()
  UIDropDownMenu_Initialize(HoloFriendsShareCharDropDown, HoloFriendsShare_CharDropDown_Init);
  UIDropDownMenu_SetText(UnitName("player"), HoloFriendsShareCharDropDown);
  UIDropDownMenu_SetWidth(120, HoloFriendsShareCharDropDown);
end

function HoloFriendsShare_CharDropDown_Init()
  for k,value in pairs(HoloFriendsFuncs_GetAvailableCharacters(HOLOFRIENDS_LIST)) do
    local info = { };
    info.text = value;
    info.value = value;
    info.func = HoloFriendsShare_CharDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end
  
function HoloFriendsShare_CharDropDown_OnClick()
  UIDropDownMenu_SetText(this.value, HoloFriendsShareCharDropDown);
  
  selectedFriendsListKey = this.value;
  
  -- be certain, the name exists in HOLOFRIENDS_LIST, otherwise
  -- HoloFriendsFuncs_LoadList() would create a new entry
  if (HoloFriendsFuncs_IsDataAvailable(HOLOFRIENDS_LIST, selectedFriendsListKey)) then
    -- use a copy, not the original data
    friendsList = HoloFriendsShare_copyFriendslist(HoloFriendsFuncs_LoadList(HOLOFRIENDS_LIST, selectedFriendsListKey));
  else
    friendsList = {};
  end
  
  friendsListCheckedCnt = 0;
  HoloFriendsShareFrameButtonShare:Disable();
  HoloFriendsShare_SourceScrollFrame_Update();
end

function HoloFriendsShare_copyFriendslist(list)
	local result = {};
  
  for key, entry in pairs(list) do
  	local temp = {};
		temp.name = entry.name
		temp.group = entry.group;
    temp.comment = entry.comment;
    temp.share = false;
    
    table.insert(result, temp);
  end
  
  return result;
end

function HoloFriendsShare_copyCharList(list)
	local result = {};
  
  for key, entry in pairs(list) do
  	local temp = {};
		temp.name = entry;
    temp.share = false;
    
    table.insert(result, temp);
  end
  
  return result;
end

function HoloFriendsShare_share()

  -- data source should be available ...
  if (not (HoloFriendsFuncs_IsDataAvailable(HOLOFRIENDS_LIST, selectedFriendsListKey))) then
    return;
  end

	local realm = GetCVar("realmName");
  local srcEntry, tarEntry;
  
  for cKey, cVal in pairs(charList) do
    if (cVal.share) then
      for fKey, fVal in pairs(friendsList) do
        if (fVal.share and not (cVal.name == fVal.name)) then
          -- get values
          srcEntry = HOLOFRIENDS_LIST[realm][selectedFriendsListKey][fKey];

          -- copy values          
          tarEntry = {};
          tarEntry.name = srcEntry.name;
          tarEntry.group = FRIENDS;
          tarEntry.connected = 0;
          tarEntry.comment = srcEntry.comment;
          tarEntry.notify = 0;
          tarEntry.class = srcEntry.class;
          tarEntry.level = srcEntry.level;
          tarEntry.area = srcEntry.area;
          tarEntry.imported = true;
          
          -- check if entry already exists
          if (not (HoloFriendsFuncs_ContainsPlayer(HOLOFRIENDS_LIST[realm][cVal.name], tarEntry.name))) then
            -- add
            table.insert(HOLOFRIENDS_LIST[realm][cVal.name], tarEntry);
          end
        end
      end
      
      -- update current player's friendslist, if he was a target
      if (cVal.name == UnitName("player")) then
        HoloFriends_List_Update();
      end
    end
  end
  
  -- reset selections
  for k, v in pairs(charList) do
    v.share = false;
  end
  for k, v in pairs(friendsList) do
    v.share = false;
  end
  charListCheckedCnt = 0;
  friendsListCheckedCnt = 0;
  
  HoloFriendsShareFrameButtonShare:Disable();
  HoloFriendsShare_SourceScrollFrame_Update();
  HoloFriendsShare_TargetScrollFrame_Update();
  
end
