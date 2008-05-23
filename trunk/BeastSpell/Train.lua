local ips, btnID, updateButton;
local myTP = 0;
local myPetSpell = {};

function BeastSpell_TrainFrame_Init()
	local j, k, name, btn;
	local n = 0;
	btnID = {};
	for j = 1, 6, 1 do
		k = 1;
		while(BST_List[j][k])do
			n = n + 1;
			name = BST_List[j][k];
			btn = CreateFrame("Button", "BST_TrainButton".. n, BeastSpell_TrainFrame, "BST_TrainButtonTemplate");
			btn:SetPoint("TOPLEFT", BeastSpell_TrainFrame, "TOPLEFT", 57 * k -7, -55 * j -30);--(50,-85)
			btn:RegisterForClicks("AnyUp");
			btn.id = n;
			btn.name = name;
			btn.keyDown = 3;
			btnID[name] = n;
			getglobal("BST_TrainButton".. n .."Icon"):SetTexture("Interface\\Icons\\".. BST_Data[name]["icon"] );
			btn.icon = getglobal("BST_TrainButton".. n .."Icon");
			btn.border = getglobal("BST_TrainButton".. n .."Border");
			btn.rank = getglobal("BST_TrainButton".. n .."Rank");
			btn.rankborder = getglobal("BST_TrainButton".. n .."RankBorder");
			k = k + 1;
		end;
	end;
	--创建右键菜单
	CreateFrame("Frame", "BST_RightMenu", BeastSpell_TrainFrame, "UIMenuTemplate"):Hide();
	--数据库
	ips = BeastSpell_Self;
end;
function BeastSpell_TrainFrame_CheckShow()
	if( BeastSpell_TrainFrame.Shown ) then
		BeastSpell_TrainFrame:Hide();
		BeastSpell_TrainFrame.Shown = nil;
	else
		BeastSpell_TrainFrame:Show();
		BeastSpell_TrainFrame.Shown = 1;
		BeastSpell_TrainFrame_OnUpdate();
	end;
end;
function BeastSpell_TrainFrame_UpdateTP()
	local total, spent = GetPetTrainingPoints();
	if ( CraftIsPetTraining() and total > 0 ) then
		myTP = total - spent;
		BST_TP_Text:Show();
		BST_TP_Text:SetText( TRAINING_POINTS .. myTP );
	else
		BST_TP_Text:Hide();
	end;
	if(myTP < 0)then
		myTP = 0;
	end;
	--BeastSpell_TrainFrame_OnUpdate();
end;

function BeastSpell_TrainFrame_OnEvent(event)
	if(not BST_ShowTrain_Button)then
		--展开按钮
		local btn = CreateFrame("Button", "BST_ShowTrain_Button", CraftFrame, "BST_ShowButtonTemplate");
		btn:SetPoint("RIGHT", CraftFrame, "RIGHT", -40, 10);
		btn:SetFrameLevel(CraftFrame:GetFrameLevel() + 2);
		btn:SetScript("OnClick", BeastSpell_TrainFrame_CheckShow);
		BeastSpell_TrainFrame:SetPoint("TOPLEFT", CraftFrame, "TOPRIGHT", -30, 0);
	end;
	if( CraftIsPetTraining() )then
		BST_ShowTrain_Button:Show();
		if( BeastSpell_TrainFrame.Shown ) then
			BeastSpell_TrainFrame:Show();
			BeastSpell_TrainFrame_OnUpdate();
		end;
	else
		BST_ShowTrain_Button:Hide();
		BeastSpell_TrainFrame:Hide();
	end;
end;

--[[
local GetPetSpells = function()
	--UnitIsVisible("pet")
	if(not UnitExists("pet") )then
		return;
	end;
	myPetSpell = {};
	local spellName, spellRank, spellIcon, rank;
	local j = 1;
	while( GetSpellName(j, BOOKTYPE_PET) )do
		spellName, spellRank = GetSpellName(j, BOOKTYPE_PET);
		--spellIcon = GetSpellTexture(j, BOOKTYPE_PET);
		_, _, spellRank = string.find(spellRank, "(%d+)");
		if(spellRank == nil)then
			rank = 1;
		else
			rank = tonumber(spellRank);
		end;
		myPetSpell[spellName] = rank;
		j = j + 1;
	end;
end;
--]]
local GetPetSpells = function()
	--UnitIsVisible("pet")
	if(not UnitExists("pet") )then
		return;
	end;
	myPetSpell = {};
	local craftName, craftRank, craftType;
	local spellName, spellRank, rank;
	local j = 1;
	while( GetSpellName(j, BOOKTYPE_PET) )do
		spellName, spellRank = GetSpellName(j, BOOKTYPE_PET);
		--spellIcon = GetSpellTexture(j, BOOKTYPE_PET);
		_, _, spellRank = string.find(spellRank, "(%d+)");
		if(spellRank == nil)then
			spellRank = "1";
		end;
		myPetSpell[spellName] = tonumber(spellRank);
		j = j + 1;
	end;
	for j = 1, GetNumCrafts(), 1 do
		craftName, craftRank, craftType = GetCraftInfo(j);
		if(craftType == "used" and myPetSpell[craftName])then
			_, _, craftRank = string.find(craftRank, "(%d+)");
			if(craftRank == nil)then
				rank = 1;
			else
				rank = tonumber(craftRank);
			end;
			if(not myPetSpell[craftName] or myPetSpell[craftName] < rank)then
				myPetSpell[craftName] = rank;
			end;
		end;
	end;
end;

--格式化对应技能的图标
local function BST_TrainButton_Init(spell)
	if(not btnID[spell] or not BST_Data[spell])then
		--cuowu
		return;
	end;
	local t = BST_Data[spell];
	local id = btnID[spell];
	local btn = getglobal("BST_TrainButton".. id);
	btn.icon:SetVertexColor(1, 1, 1);
	btn.rankborder:Show();
	btn.enable = 1;
	--btn:Enable();
	local j = 0;
	local m = BST_Data[spell]["max"];
	if(myPetSpell[spell])then
		j = myPetSpell[spell];
	end;
	--btn.border:Show();
	btn.rank:SetText(j .."/".. m);
	if(j < m)then
		if(t["Lv"][j+1] and UnitLevel("pet") < t["Lv"][j+1])then
			btn.border:SetVertexColor(1, 0, 0);
		else
			btn.border:SetVertexColor(0, 1, 0);
		end;
		btn.rank:SetVertexColor(0, 1, 0);
		--btn.rankborder:SetVertexColor(0, 1, 0);
	else
		btn.border:SetVertexColor(1, 0.82, 0);
		btn.rank:SetVertexColor(1, 0.82, 0);
		--btn.rankborder:SetVertexColor(1, 1, 0.5);
	end;
end;

-------------------------------
--获取等级
local function BST_NextLevel(spelLv, t)
	if(not t["Lv"])then
		return 0;
	end;
	local j = spelLv + 1;
	for j = spelLv + 1, t["max"], 1 do
		if(t["Lv"][j] and t["Lv"][j] > 0)then
			return j;
		end;
	end;
	return 0;
end;
local function BST_SuitableLevel(spelLv, t)
	if(not t["Lv"])then
		return 0;
	end;
	local j = spelLv + 1;
	local usedTP = 0;
	if(t["TP"][spelLv])then
		usedTP = t["TP"][spelLv];
	end;
	for j = t["max"], spelLv + 1, -1 do
		if(t["Lv"][j] and t["Lv"][j] > 0 and t["Lv"][j] <= UnitLevel("pet") and t["TP"][j] - usedTP <= myTP)then
			return j;
		end;
	end;
	return 0;
end;
--生成GameTootip
local function BST_LvInfoAddTootip(txt, spell, nowLv, nextLv, t)
	local costTP, costTxt;
	if(t["TP"][nowLv])then
		costTP = t["TP"][nextLv] - t["TP"][nowLv];
	else
		costTP = t["TP"][nextLv];
	end;
	if(costTP > myTP)then
		costTxt = "|cFFff0000".. costTP .."|r";
	else
		costTxt = "|cFF00ff00".. costTP .."|r";
	end;
	local leftTxt = txt .." ".. (nextLv).."/".. t["max"];
	local rightTxt = "TP".. t["TP"][nextLv] .." (".. costTxt ..")";
	GameTooltip:AddDoubleLine(leftTxt, rightTxt, 1, 1, 1, 1, 1, 1);
	--所需等级
	if( UnitLevel("pet") < t["Lv"][nextLv] )then
		GameTooltip:AddLine(BS_REQ_LEVEL .. t["Lv"][nextLv], 1, 0, 0);
	end;
	if( not ips[spell][tostring(nextLv)] )then
		GameTooltip:AddLine(BS_UNLEARNT, 1, 0, 0);
	end;
	--文字说明
	if(t["txt"])then
		if(t["txt"][nextLv])then
			GameTooltip:AddLine(t["txt"][nextLv], 1, 0.82, 0, 1);
		elseif(t["txt"][1])then
			GameTooltip:AddLine(t["txt"][1], 1, 0.82, 0, 1);
		end;
	end;
end;
--更新--------------------更新鼠标提示--------------
local function BST_SetTootip()
	if(not updateButton)then
		if(IsAltKeyDown() and this.keyDown == 1)then
			return;
		elseif(not IsAltKeyDown() and this.keyDown == 0)then
			return;
		end;
	else
		this = updateButton;
	end;
	if( IsAltKeyDown() )then
		this.keyDown = 1;
	else
		this.keyDown = 0;
	end;

	local spell = this.name;
	if(not BST_Data[spell])then
		return;
	end;

	GameTooltip:SetOwner(this,"ANCHOR_LEFT");
	local t = BST_Data[spell];
	local spelLv = 0;
	if(not myPetSpell[spell])then
		spelLv = 0;
		GameTooltip:SetText(spell);
	else
		spelLv = myPetSpell[spell];
		GameTooltip:AddDoubleLine(spell, BS_LEVEL .. spelLv, 1, 1, 1, 0.6, 0.6, 0.6);
	end;
	--消耗、CD
	if(t["til"])then
		local f, _, energy, cd = string.find(t["til"], "(.-)|(.+)");
		if(not f)then
			GameTooltip:AddLine(t["til"], 1, 1, 1);
		else
			GameTooltip:AddDoubleLine(energy, cd, 1, 1, 1, 1, 1, 1);
		end;
	end;
	if(this.enable == 1 and UnitExists("pet") and not IsAltKeyDown() )then
		--技能的文字说明
		if(t["txt"])then
			if(t["txt"][spelLv])then
				GameTooltip:AddLine(t["txt"][spelLv], 1, 0.82, 0, 1);
			elseif(spelLv > 0 and t["txt"][1])then
				GameTooltip:AddLine(t["txt"][1], 1, 0.82, 0, 1);
			end;
		end;
		--下一级和最适等级
		this.nextLv = BST_NextLevel(spelLv, t);
		this.suitLv = BST_SuitableLevel(spelLv, t);
		if(this.suitLv > spelLv and this.nextLv == this.suitLv)then
			BST_LvInfoAddTootip(BS_NEXT_SUIT_LEVEL, spell, spelLv, this.nextLv, t);
		else
			if(this.nextLv > spelLv)then
				BST_LvInfoAddTootip(BS_NEXT_LEVEL, spell, spelLv, this.nextLv, t);
			end;
			if(this.suitLv > spelLv)then
				BST_LvInfoAddTootip(BS_SUIT_LEVEL, spell, spelLv, this.suitLv, t);
			end;
		end;
	else
		local j, leftTxt, rightTxt;
		for j = 1, t["max"], 1 do
			leftTxt = BS_LEVEL .. j .."/".. t["max"];
			if(t["Lv"][j] < 1)then
				rightTxt = BS_DONT_EXIST;
				GameTooltip:AddDoubleLine(leftTxt, rightTxt, 1, 1, 1, 1, 0, 0);
			elseif(not ips[spell] or not ips[spell][tostring(j)])then
				rightTxt = BS_UNLEARNT;
				GameTooltip:AddDoubleLine(leftTxt, rightTxt, 1, 1, 1, 1, 0, 0);
			else
				rightTxt = BS_LEARNT;
				GameTooltip:AddDoubleLine(leftTxt, rightTxt, 1, 1, 1, 0, 1, 0);
			end;
			if(t["txt"] and t["txt"][j])then
				GameTooltip:AddLine(t["txt"][j], 1, 0.82, 0, 1);
			end;
		end;
	end;
	GameTooltip:Show();
end;

function BeastSpell_TrainFrame_OnUpdate()
	local j, k, btn;
	local n = 0;
	for j = 1, 6, 1 do
		k = 1;
		while(BST_List[j][k])do
			n = n + 1;
			name = BST_List[j][k];
			btn = getglobal("BST_TrainButton".. n);
			--btn.border:Hide();
			btn.icon:SetVertexColor(0.4, 0.4, 0.4);
			btn.border:SetVertexColor(0.4, 0.4, 0.4);
			btn.rank:SetText("");
			btn.rankborder:Hide();
			btn.enable = 0;
			--btn:Disable();
			k = k + 1;
		end;
	end;
	--UnitIsVisible("pet")
	if(not UnitExists("pet") )then
		BST_PetNameText:SetText( GetCraftName() );
		return;
	end;
	BeastSpell_TrainFrame_UpdateTP();--初始化TP
	BST_PetNameText:SetText( UnitName("pet") );
	--初始化当前宠物的技能
	local petType = UnitCreatureFamily("pet");
	if(not BST_Species[petType])then
		return;
	end;
	--扫描当前宠物的技能
	GetPetSpells();
	k = 1;
	while(BST_Species2[k])do
		BST_TrainButton_Init(BST_Species2[k])
		k = k + 1;
	end;
	if(BST_Species[petType])then
		k = 1;
		while(BST_Species[petType][k])do
			BST_TrainButton_Init(BST_Species[petType][k])
			k = k + 1;
		end;
	end;
	if(updateButton)then
		updateButton.keyDown = 3;
		BST_SetTootip();
		updateButton = nil;
	end;
end;

function BST_TrainButton_OnEnter()
	BST_SetTootip();
	--添加事件
	--local obj = BeastSpell_TrainFrame;
	if(not this.hover)then
		this.hover = 1;
		this:SetScript("OnUpdate", BST_SetTootip);
	end;
end;
function BST_TrainButton_OnLeave()
	--local obj = BeastSpell_TrainFrame;
	this.hover = nil;
	this.keyDown = nil;
	this:SetScript("OnUpdate", nil);
	GameTooltip:Hide();
end;
function BST_TrainButton_Click()
	if(this.enable == 0 or this.nextLv < 1)then
		return;
	end;
	local spell = this.name;
	if( arg1 == "RightButton" ) then
		BST_RightMenu:SetPoint("TOPLEFT", this, "TOPRIGHT", 0, 0);
		BST_TrainButton_RightMenu_OnShow(BST_Data[spell], ips[spell], this.nextLv, myTP);
	else
		if( ips[spell] and this.suitLv > 0 and ips[spell][tostring(this.suitLv)] )then
			local index = ips[spell][tostring(this.suitLv)];
			DoCraft(index);
			--BeastSpell_TrainFrame_OnUpdate();
			updateButton = this;
		end;
	end;
end;