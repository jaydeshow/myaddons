local function BST_RightMenu_OnClick()
	local index = this.index;
	if(index > 0)then
		DoCraft(index);
		--BeastSpell_TrainFrame_OnUpdate();
	end;
	BST_RightMenu:Hide();
end;

local function UIMenu_Initialize(menu)
	menu.numButtons = 0;
	menu.subMenu = "";
	local name = menu:GetName();
	local j, btn;
	for j = 1, UIMENU_NUMBUTTONS, 1 do
		btn = getglobal(name .. "Button" .. j);
		btn:SetWidth(UIMENU_BUTTON_WIDTH);
		btn:SetHeight(UIMENU_BUTTON_HEIGHT);
		btn:Hide();
	end;
	--menu:SetWidth(UIMENU_BUTTON_WIDTH + (UIMENU_BORDER_WIDTH * 2));
	menu:SetHeight(UIMENU_BUTTON_HEIGHT + (UIMENU_BORDER_HEIGHT * 2));
end;
local function UIMenu_AddButton(menu, text, index)
	--local menu = BST_RightMenu;
	local id = menu.numButtons + 1;
	if ( id > UIMENU_NUMBUTTONS ) then
		--message("Too many buttons in UIMenu: " .. menu:GetName());
		return;
	end
	menu.numButtons = id;
	local btn = getglobal(menu:GetName().."Button"..id);
	if ( text ) then
		btn:SetText(text);
		btn.index = index;
	end
	btn:SetScript("OnClick", BST_RightMenu_OnClick);
	btn:Show();
	menu:SetHeight((id * UIMENU_BUTTON_HEIGHT) + (UIMENU_BORDER_HEIGHT * 2));
end
local function UIMenu_AutoSize(menu)
	local j, btn, width;
	local name = menu:GetName();
	local maxWidth = 0;
	for j = 1, UIMENU_NUMBUTTONS do
		width = getglobal(name .. "Button" .. j):GetTextWidth();
		if ( width > maxWidth ) then
			maxWidth = width;
		end;
	end;
	for j = 1, UIMENU_NUMBUTTONS do
		btn = getglobal(name .. "Button" .. j );
		btn:SetWidth(maxWidth);
	end;
	menu:SetWidth(maxWidth + (UIMENU_BORDER_WIDTH * 2));
end;

function BST_TrainButton_RightMenu_OnShow(t, ipp, lv0, myTP)
	local petLv = UnitLevel("pet");
	local j = lv0;
	local n = 0;
	UIMenu_Initialize(BST_RightMenu);
	local usedTP = 0;
	if(t["TP"][lv0-1])then
		usedTP = t["TP"][lv0-1];
	end;
	while(j <= t["max"])do
		if(t["Lv"][j] and t["Lv"][j] > 0 and t["Lv"][j] <= petLv and t["TP"][j] - usedTP <= myTP and ipp[tostring(j)])then
			local index = ipp[tostring(j)];
			UIMenu_AddButton(BST_RightMenu, BS_TRAIN_LEVEL .. j, index);
			n = n + 1;
		end;
		j = j + 1;
	end;
	if(n < 1)then
		UIMenu_AddButton(BST_RightMenu, BS_TRAIN_NOLEVEL, 0);
	end;
	BST_RightMenu.timeleft = UIMENU_TIMEOUT;
	UIMenu_AutoSize(BST_RightMenu);
	BST_RightMenu:Show();
end;