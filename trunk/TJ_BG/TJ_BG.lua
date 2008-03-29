local NowStrID;

function TJ_BG_CreatOption()
	CreateFrame("Button", "TJ_BG_PotinTo_Button", TJ_BG_Frame , "TJ_BG_PointButtonTemplate");
	TJ_BG_PotinTo_Button:SetPoint("TOPLEFT", "TJ_BG_Frame", "TOPLEFT", 150, -70);
	TJ_BG_PotinTo_Button_Label:SetText("按钮组锚点");

	CreateFrame("Button", "TJ_BG_relativeTo_Button", TJ_BG_Frame , "TJ_BG_PointButtonTemplate");
	TJ_BG_relativeTo_Button:SetPoint("TOPLEFT", "TJ_BG_Frame", "TOPLEFT", 305, -70);
	TJ_BG_relativeTo_Button_Label:SetText("附着框锚点");

	CreateFrame("EditBox", "TJ_BG_EditX", TJ_BG_Frame , "TJ_BG_EditBoxTemplate");
	TJ_BG_EditX:SetPoint("TOPLEFT", "TJ_BG_Frame", "TOPLEFT", 100, -100);
	TJ_BG_EditX_Label:SetText("横向偏移");

	CreateFrame("EditBox", "TJ_BG_EditY", TJ_BG_Frame , "TJ_BG_EditBoxTemplate");
	TJ_BG_EditY:SetPoint("TOPLEFT", "TJ_BG_Frame", "TOPLEFT", 255, -100);
	TJ_BG_EditY_Label:SetText("纵向偏移");

	--按钮行数、尺寸
	CreateFrame("EditBox", "TJ_BG_EditRows", TJ_BG_Frame , "TJ_BG_EditBoxTemplate");
	TJ_BG_EditRows:SetPoint("TOPLEFT", "TJ_BG_Frame", "TOPLEFT", 100, -130);
	TJ_BG_EditRows_Label:SetText("按钮行数");
	TJ_BG_EditRows:SetText(0);

	CreateFrame("EditBox", "TJ_BG_EditSize", TJ_BG_Frame , "TJ_BG_EditBoxTemplate");
	TJ_BG_EditSize:SetPoint("TOPLEFT", "TJ_BG_Frame", "TOPLEFT", 255, -130);
	TJ_BG_EditSize_Label:SetText("按钮尺寸");
end;

function TJ_BG_Set()
	TJ_BG_Frame:Show();
end;

function TJ_BG_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--print("TJ_BG Loaded...");
	--TJ_BG_DataIcon = {};

	TJ_BG_Tab1:Disable();
	SlashCmdList["TJ_BG"] = TJ_BG_Set;
	SLASH_TJ_BG1 = "/tjbg";
	SLASH_TJ_BG2 = "/tbg";
	TJ_BG_CreatOption();
end;

function TJ_BG_OnEvent()
	if (event == "SPELL_UPDATE_COOLDOWN") then
		TJ_BG_SpellButton_CD();
	elseif (event == "TRAINER_CLOSED") then
		TJ_BG_Spell_LvUp();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");

		NowStrID = "player";

		this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		this:RegisterEvent("TRAINER_CLOSED");

		--动态创建
		if(not TJ_BG_party4_1 or not TJ_BG_partypet4_1)then
			this:RegisterEvent("PARTY_MEMBERS_CHANGED");--当一个玩家行会改变时触发该事件
			this:RegisterEvent("PARTY_LEADER_CHANGED");--当一个玩家的领队被改变时触发该事件.
		end;

		if(not TJ_BG_Data)then
			--TJ_BG_Data = {};
			return;
		end;

		--在所有头像旁，生成按钮
		TJ_BG_UpdateButtonGroups("all");
		TJ_BG_InitOption();

	elseif (event == "PARTY_MEMBERS_CHANGED" or event == "PARTY_LEADER_CHANGED") then
		--当所有按钮创建完毕
		TJ_BG_UpdateButtonGroups("party");
		TJ_BG_UpdateButtonGroups("partypet");
		if(TJ_BG_party4_1 and TJ_BG_partypet4_1)then
			this:UnregisterEvent("PARTY_MEMBERS_CHANGED");--当一个玩家行会改变时触发该事件
			this:UnregisterEvent("PARTY_LEADER_CHANGED");--当一个玩家的领队被改变时触发该事件.
		end;
	end;
end;

function TJ_BG_UpdateButtonGroups(strID)
	local tableTmp = {};
	--人员窗体
	tableTmp["focus"] = "FocusFrame";
	tableTmp["partypetX"] = "";
	if(XPerl_party1)then--okey
		tableTmp["party"] = "XPerl_party";
		tableTmp["partypet"] = "XPerl_partypet";
		tableTmp["player"] = "XPerl_Player";
		tableTmp["target"] = "XPerl_Target";
		tableTmp["targettarget"] = "XPerl_TargetTarget";
		tableTmp["focus"] = "XPerl_Focus";
	elseif(Perl_Party_MemberFrame1)then--okey
		tableTmp["party"] = "Perl_Party_MemberFrame";
		tableTmp["partypet"] = "Perl_Party_Pet";
		tableTmp["player"] = "Perl_Player_Frame";
		tableTmp["target"] = "Perl_Target_Frame";
		tableTmp["targettarget"] = "Perl_Target_Target_Frame";
		tableTmp["focus"] = "Perl_Focus_Frame";
	elseif(Nurfed_party1)then--okey
		tableTmp["party"] = "Nurfed_party";
		tableTmp["partypet"] = "Nurfed_partypet";
		tableTmp["player"] = "Nurfed_player";
		tableTmp["target"] = "Nurfed_target";
		tableTmp["targettarget"] = "Nurfed_targettarget";
		tableTmp["focus"] = "Nurfed_focus";
	elseif(DUF_PartyFrame1)then--okey
		tableTmp["party"] = "DUF_PartyFrame";
		tableTmp["partypet"] = "DUF_PartyPetFrame";
		tableTmp["player"] = "DUF_PlayerFrame";
		tableTmp["target"] = "DUF_TargetFrame";
		tableTmp["targettarget"] = "DUF_TargetOfTargetFrame";
		tableTmp["focus"] = "DUF_Focus_Frame";
	elseif(aUFplayer)then--okey
		tableTmp["party"] = "aUFpartyUnitButton";
		tableTmp["partypet"] = "aUFpartypetUnitButton";
		tableTmp["player"] = "aUFplayer";
		tableTmp["target"] = "aUFtarget";
		tableTmp["targettarget"] = "aUFtargettarget";
		tableTmp["focus"] = "aUFfocus";
	elseif(SmartPlayerFrame)then
		tableTmp["party"] = "SmartPartyFrame";
		tableTmp["partypet"] = "SmartPartyFrame";
		tableTmp["partypetX"] = "PetFrame";
		tableTmp["player"] = "SmartPlayerFrame";
		tableTmp["target"] = "SmartTargetFrame";
		tableTmp["targettarget"] = "SmartToTFrame";
		tableTmp["focus"] = "SmartFocusFrame";
	elseif(PitBullUnitFrame1)then
		tableTmp["party"] = "PitBullCluster2UnitButton";
		tableTmp["partypet"] = "PitBullCluster3UnitButton";
		tableTmp["player"] = "PitBullUnitFrame1";
		tableTmp["target"] = "PitBullUnitFrame4";
		tableTmp["targettarget"] = "PitBullUnitFrame5";
		tableTmp["focus"] = "PitBullUnitFrame6";
	else
		tableTmp["party"] = "PartyMemberFrame";
		tableTmp["partypet"] = "PartyMemberFrame";
		tableTmp["partypetX"] = "PetFrame";
		tableTmp["player"] = "PlayerFrame";
		tableTmp["target"] = "TargetFrame";
		tableTmp["targettarget"] = "TargetofTargetFrame";
	end;

	--单独处理独立的TOT插件
	if(TOTFrame)then
		tableTmp["targettarget"] = "TOTFrame";
	elseif(Sonic_TT_Frame)then
		tableTmp["targettarget"] = "Sonic_TT_Frame";
	elseif(TOTAlertFrame)then
		tableTmp["targettarget"] = "TOTAlertFrame";
	end;
	
	--处理单独的焦点插件
	if(FocusFrame)then
		tableTmp["focus"] = "FocusFrame";
	end;

	local j=1;
	if(strID == "party" or strID == "all")then
		for j=1, 4, 1 do
			if(getglobal(tableTmp["party"] .. j) )then
				TJ_BG_BuildButton("party", "party"..j, tableTmp["party"] .. j );
			end;
		end;
	end;
	if(strID == "partypet" or strID == "all")then
		for j=1, 4, 1 do
			if(getglobal(tableTmp["partypet"] .. j .. tableTmp["partypetX"]) )then
				TJ_BG_BuildButton("partypet", "partypet" .. j, tableTmp["partypet"] .. j .. tableTmp["partypetX"]);
			end;
		end;
	end;
	if(strID == "player" or strID == "all")then
		TJ_BG_BuildButton("player","player", tableTmp["player"]);
	end;
	if(strID == "target" or strID == "all")then
		TJ_BG_BuildButton("target","target", tableTmp["target"]);
	end;
	if(strID == "targettarget" or strID == "all")then
		TJ_BG_BuildButton("targettarget","targettarget", tableTmp["targettarget"]);
	end;
	if(strID == "focus" or strID == "all")then
		if( getglobal(tableTmp["focus"]) )then
			TJ_BG_BuildButton("focus","focus", tableTmp["focus"]);
		end;
	end;
end;

function TJ_BG_BuildButton( strID, unitID, frameName )
	if(not TJ_BG_Data or not TJ_BG_Data[strID])then
		return;
	end;
	local tableTmp = TJ_BG_Data[strID];
	local j,k,n = 1, 1, 1;
	local btn,xx,yy;

	btn = getglobal( "TJ_BG_"..unitID.."_"..n );
	while ( tableTmp[j] or btn ) do
		if(not tableTmp[j])then
			if ( btn ) then
				UnregisterUnitWatch(btn);
				btn:Hide();
				n = n + 1;
			end;
		elseif( tableTmp[j][k] )then
			if (not btn ) then
				btn = CreateFrame("Button", "TJ_BG_"..unitID.."_"..n, getglobal(frameName), "TJ_BG_ButtonTemplate");
			end;
			btn:SetWidth(tableTmp["size"]);
			btn:SetHeight(tableTmp["size"]);
			xx = (k-1) * tableTmp["size"] + tableTmp["x"];
			yy = (1-j) * tableTmp["size"] + tableTmp["y"];
			btn:ClearAllPoints();
			btn:SetPoint(tableTmp["point"], frameName, tableTmp["relative"], xx, yy);
			btn.tag = strID;
			btn.row = j;
			btn.id = k;

			getglobal("TJ_BG_"..unitID.."_"..n.."Icon"):SetTexture(tableTmp[j][k]["Icon"]);
			--getglobal("TJ_BG_"..unitID.."_"..n.."_Icon"):SetTexture(tableTmp[j][k]["Icon"]);
			if(tableTmp[j][k]["Type"] == "spell")then
				btn:SetAttribute("type","spell");
				btn:SetAttribute("spell", tableTmp[j][k]["Info"]);
			elseif(tableTmp[j][k]["Type"] == "item")then
				btn:SetAttribute("type", "item");
				btn:SetAttribute("item", "item:" .. tableTmp[j][k]["Idx"]);
			elseif(tableTmp[j][k]["Type"] == "macro")then
				btn:SetAttribute("type","macro");
				btn:SetAttribute("macro", tableTmp[j][k]["Idx"]);
			end;
			btn:SetAttribute("unit",unitID);
			RegisterUnitWatch(btn);
			btn:Show();
			n = n + 1;
		end;
		k = k + 1;
		if(k > 12)then
			j = j + 1;
			k = 1;
		end;
		btn = getglobal( "TJ_BG_"..unitID.."_"..n );
	end;
end;

function TJ_BG_DownMenu_OnLoad()
	local pointTableN = {"上","下","左","右","左上","左下","右上","右下",};
	local pointTableV = {"TOP","BOTTOM","LEFT","RIGHT","TOPLEFT","BOTTOMLEFT","TOPRIGHT","BOTTOMRIGHT",};
	local j=1;
	for j=1, 8, 1 do
		getglobal( "TJ_BG_MenuButton_" .. j .. "Text" ):SetText( pointTableN[j] );
		getglobal( "TJ_BG_MenuButton_" .. j ).value = pointTableV[j];
	end;
end;

function TJ_BG_InitOption()
	local tableTmp;
	if(not TJ_BG_Data or not TJ_BG_Data[NowStrID])then
		tableTmp = {["rows"]=0,};
		TJ_BG_PotinTo_Button_MainText:SetText("");
		TJ_BG_relativeTo_Button_MainText:SetText("");
		TJ_BG_EditRows:SetText(0);
		TJ_BG_EditSize:SetText("");
		TJ_BG_EditX:SetText("");
		TJ_BG_EditY:SetText("");
	else
		tableTmp = TJ_BG_Data[NowStrID];
		TJ_BG_PotinTo_Button_MainText:SetText(tableTmp["point"]);
		TJ_BG_relativeTo_Button_MainText:SetText(tableTmp["relative"]);
		TJ_BG_EditRows:SetText(tableTmp["rows"]);
		TJ_BG_EditSize:SetText(tableTmp["size"]);
		TJ_BG_EditX:SetText(tableTmp["x"]);
		TJ_BG_EditY:SetText(tableTmp["y"]);
	end;
	
	local j, k, btn;
	for j=1, 5, 1 do
		if( j > tableTmp["rows"] and tableTmp[j] )then
			TJ_BG_Data[NowStrID][j] = nil;
		end;
		for k=1, 12, 1 do
			btn = getglobal("TJ_BG_SpellBook_" .. j .. "_"..k);
			if( j > tableTmp["rows"] )then
				if(btn)then
					btn:Hide();
				end;
			elseif(not tableTmp[j] or not tableTmp[j][k])then
				if(not btn)then
					btn = CreateFrame("Button", "TJ_BG_SpellBook_" .. j .. "_"..k, TJ_BG_Frame, "TJ_BG_Button2Template");
					btn.row = j;
					btn.id = k;
					btn:SetPoint("TOPLEFT", TJ_BG_Frame, "TOPLEFT", k * 25, (1-j)*25-180 );
					btn:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					btn:RegisterForDrag("LeftButton");
				else
					btn:Show();
					btn:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot-Depress");
				end;
			else
				if(not btn)then
					btn = CreateFrame("Button", "TJ_BG_SpellBook_" .. j .. "_"..k, TJ_BG_Frame, "TJ_BG_Button2Template");
					btn.row = j;
					btn.id = k;
					btn:SetPoint("TOPLEFT", TJ_BG_Frame, "TOPLEFT", k * 25, (1-j)*25-180 );
					btn:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					btn:RegisterForDrag("LeftButton");
				end;
				btn:Show();
				btn:SetNormalTexture(tableTmp[j][k]["Icon"]);
			end;
		end;
	end;
end;

function TJ_BG_MenuButton_Click(str)
	getglobal( TJ_BG_DownMenu.par .. "_MainText" ):SetText(str);
	TJ_BG_DownMenu:Hide();
	TJ_BG_SaveToData();
end;

function TJ_BG_DropDown_Click(name)
	if( TJ_BG_DownMenu:IsVisible() )then
		TJ_BG_DownMenu:Hide();
	else
		TJ_BG_DownMenu:ClearAllPoints();
		TJ_BG_DownMenu:SetPoint("TOPRIGHT", getglobal( name ), "BOTTOMRIGHT", 0, 0);
		TJ_BG_DownMenu.par = name;
		TJ_BG_DownMenu:Show();
	end;
end;

function TJ_BG_DropDown_OnHide()
	TJ_BG_DownMenu:Hide();
end;

function TJ_BG_Update()
	if(not TJ_BG_Data)then
		TJ_BG_Data = {};
	end;
	if(not TJ_BG_Data[NowStrID])then
		TJ_BG_PotinTo_Button_MainText:SetText("LEFT");
		TJ_BG_relativeTo_Button_MainText:SetText("RIGHT");
		TJ_BG_EditSize:SetText("15");
		TJ_BG_EditRows:SetText("1");
		TJ_BG_Data[NowStrID] = {
			["y"] = 0,
			["x"] = 0,
			["point"] = "LEFT",
			["rows"] = 1,
			["relative"] = "RIGHT",
			["size"] = 15,
		};
	end;
	if( TJ_BG_EditSize:GetNumber() < 5 )then
		TJ_BG_EditSize:SetText("5");
	end;
	if( TJ_BG_EditRows:GetNumber() > 5 )then
		TJ_BG_EditRows:SetText("5");
	end;
	this:SetText( this:GetNumber() );
	TJ_BG_SaveToData();
	TJ_BG_InitOption();
end;

function TJ_BG_SaveToData()
	if(not TJ_BG_Data or not TJ_BG_Data[NowStrID])then
		return;
	end;
	TJ_BG_Data[NowStrID]["point"] = TJ_BG_PotinTo_Button_MainText:GetText();
	TJ_BG_Data[NowStrID]["relative"] = TJ_BG_relativeTo_Button_MainText:GetText();
	TJ_BG_Data[NowStrID]["rows"] = TJ_BG_EditRows:GetNumber();
	TJ_BG_Data[NowStrID]["size"] = TJ_BG_EditSize:GetNumber();
	TJ_BG_Data[NowStrID]["x"] = TJ_BG_EditX:GetNumber();
	TJ_BG_Data[NowStrID]["y"] = TJ_BG_EditY:GetNumber();

	TJ_BG_UpdateButtonGroups(NowStrID);
end;

function TJ_BG_Tab_Onclick(id)
	local strID_Table = {"player","target","party","partypet","targettarget","focus",};
	TJ_BG_Tab1:Enable();
	TJ_BG_Tab2:Enable();
	TJ_BG_Tab3:Enable();
	TJ_BG_Tab4:Enable();
	TJ_BG_Tab5:Enable();
	TJ_BG_Tab6:Enable();
	getglobal("TJ_BG_Tab" .. id):Disable();
	NowStrID = strID_Table[id];
	TJ_BG_InitOption();
end;

function TJ_BG_GetItemLocation(num)
	local j, k, Link, itemID;
	for j = 0, 4, 1 do
		for k = 1, GetContainerNumSlots(j), 1 do
			Link = GetContainerItemLink(j, k);
			if (Link) then
				_,_,itemID = string.find(Link, "item:(%d+)");
				if(tonumber(itemID) == num)then
					return "bag",j,k;
				end;
			end;
		end;
	end;
	for j = 0, 19, 1 do
		Link = GetInventoryItemLink("player", j);
		if (Link) then
			_,_,itemID = string.find(Link, "item:(%d+)");
			if(tonumber(itemID) == num)then
				return "equip",j,0;
			end;
		end;
	end;
	return "none",0,0;
end;

function TJ_BG_Icon_to_Cursur(row, id)
	if(TJ_BG_Data[NowStrID][row][id])then
		local tableTmp = TJ_BG_Data[NowStrID][row][id];
		if(tableTmp["Type"] == "spell")then
			PickupSpell( tableTmp["Idx"], "BOOKTYPE_SPELL" );
		elseif(tableTmp["Type"] == "item")then
			local iss, j, k = TJ_BG_GetItemLocation(tableTmp["Idx"]);
			if(iss == "bag")then
				PickupContainerItem(j,k);
			elseif(iss == "equip")then
				PickupInventoryItem(j);
			else
				return false;
			end;
		elseif(tableTmp["Type"] == "macro")then
			PickupMacro(tableTmp["Idx"]);
		end;
		return true;
	else
		return false;
	end;
end;

function TJ_BG_CatchSpell(row, id)
	if(TJ_BG_Icon_to_Cursur(row, id))then
		getglobal("TJ_BG_SpellBook_".. row .. "_" ..id):SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot-Depress");
		TJ_BG_Data[NowStrID][row][id] = nil;
		TJ_BG_UpdateButtonGroups(NowStrID);
	end;
end;

function TJ_BG_SetSpell(row, id)
	if ( arg1 == "RightButton" )then
		if(TJ_BG_Data[NowStrID][row] and TJ_BG_Data[NowStrID][row][id])then
			TJ_BG_Data[NowStrID][row][id] = nil;
			getglobal("TJ_BG_SpellBook_".. row .. "_" ..id):SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot-Depress");
			TJ_BG_UpdateButtonGroups(NowStrID);
		end;
	else
		--获取信息
		local infoType, info1, info2 = GetCursorInfo();
		local name, ico;
		if(infoType)then

			if(not TJ_BG_Data[NowStrID][row])then
				TJ_BG_Data[NowStrID][row] = {};
			end;

			ClearCursor();
			TJ_BG_Icon_to_Cursur(row, id)

			if(infoType == "spell")then
				local spellname,spellrank=GetSpellName(info1, "BOOKTYPE_SPELL");
				if(GetSpellName(info1+1, "BOOKTYPE_SPELL") == spellname)then
					spellname = spellname .. "(" .. spellrank .. ")";
				end;
				ico = GetSpellTexture(info1, "BOOKTYPE_SPELL");
				TJ_BG_Data[NowStrID][row][id] = {
					["Type"] = "spell",
					["Icon"] = ico,
					["Info"] = spellname,
					["Idx"] = info1,
				};
				--TJ_BG_Data[name_server]["SpellIdx"][spellname] = info1;
			elseif(infoType == "item")then
				name, _, _, _, _, _, _, _, _, ico = GetItemInfo(info1);
				TJ_BG_Data[NowStrID][row][id] = {
					["Type"] = "item",
					["Icon"] = ico,
					["Info"] = name,
					["Idx"] = info1,
				};
			elseif(infoType == "macro")then
				name, ico = GetMacroInfo(info1);
				TJ_BG_Data[NowStrID][row][id] = {
					["Type"] = "macro",
					["Icon"] = ico,
					["Info"] = name,
					["Idx"] = info1,
				};
			end;
			getglobal("TJ_BG_SpellBook_".. row .. "_" ..id):SetNormalTexture(ico);
			TJ_BG_UpdateButtonGroups(NowStrID);
			TJ_BG_GetSpell(row, id);
		else
			TJ_BG_Icon_to_Cursur(row, id);
		end;
	end;
	--TJ_BG_InitOption();
	--TJ_BG_UpdateButtonGroups(NowStrID);
end;

function TJ_BG_GetSpell(row, id)
	if(not TJ_BG_Data[NowStrID])then
		return;
	end;
	if(TJ_BG_Data[NowStrID][row] and TJ_BG_Data[NowStrID][row][id])then
		local name = TJ_BG_Data[NowStrID][row][id]["Info"];
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 15, -25);
		GameTooltip:SetText(name,1,1,1);
		GameTooltip:Show();
	end;
end;

function TJ_BG_SpellButtonName(tag, row, id)
	local name = TJ_BG_Data[tag][row][id]["Info"];
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 15, -25);
	GameTooltip:SetText(name,1,1,1);
	GameTooltip:Show();
end;

function TJ_BG_SpellButton_CD()
	if(not TJ_BG_Data)then
		return;
	end;
	local unitIDlist = {
		"player",
		"target",
		"targettarget",
		"focus",
		"party1",
		"party2",
		"party3",
		"party4",
		"partypet1",
		"partypet2",
		"partypet3",
		"partypet4",
	};
	local j, k, str;
	local tag, row, id, itype;
	local start, duration, enable, cooldown;
	j = 1;
	while ( unitIDlist[j] ) do
		k = 1;
		btn = getglobal("TJ_BG_" .. unitIDlist[j] .. "_" .. k);
		while ( btn and btn:IsVisible() ) do
			tag = btn.tag;
			row = btn.row;
			id = btn.id;
			if(TJ_BG_Data[tag][row][id])then
				local tableTmp = TJ_BG_Data[tag][row][id];
				itype = tableTmp["Type"];
				if( itype == "spell" )then
					start, duration, enable = GetSpellCooldown(tableTmp["Idx"], "BOOKTYPE_SPELL");
					cooldown = getglobal(btn:GetName().."Cooldown");
					CooldownFrame_SetTimer(cooldown, start, duration, enable);
				elseif( itype == "item" )then
					start, duration, enable = GetItemCooldown(tableTmp["Idx"]);
					cooldown = getglobal(btn:GetName().."Cooldown");
					CooldownFrame_SetTimer(cooldown, start, duration, enable);
				elseif( itype == "macro" )then
					--return;
				end;
			end;
			k = k + 1;
			btn = getglobal("TJ_BG_" .. unitIDlist[j] .. "_" .. k);
		end;
		j = j + 1;
	end;
end;
--local start, duration, enable = GetSpellCooldown(spellID, "bookType");

function TJ_BG_Spell_LvUp()
	if(not TJ_BG_Data)then
		return;
	end;
	local spellname,spellrank;
	local tableTmp = {};
	local j = 1;
	while(GetSpellName(j, "BOOKTYPE_SPELL"))do
		spellname, spellrank = GetSpellName(j, "BOOKTYPE_SPELL");
		if(GetSpellName(j+1, "BOOKTYPE_SPELL") == spellname)then
			tableTmp[spellname .. "(" .. spellrank .. ")"] = j;
		else
			tableTmp[spellname] = j;
		end;
		j = j + 1;
	end;

	local strID, row, k;
	j = 1;
	local strIDlist = {"player", "target", "party", "partypet",};
	while(strIDlist[j] and TJ_BG_Data[strIDlist[j]] )do
		strID = strIDlist[j];
		row = 1;
		while(TJ_BG_Data[strID][row])do
			for k = 1, 12, 1 do
				if(TJ_BG_Data[strID][row][k])then
					if(TJ_BG_Data[strID][row][k]["Type"] == "spell")then
						spellname = TJ_BG_Data[strID][row][k]["Info"];
						TJ_BG_Data[strID][row][k]["Idx"] = tableTmp[spellname];
					end;
				end;
			end;
			row = row + 1;
		end;
		j = j + 1;
	end;
end;