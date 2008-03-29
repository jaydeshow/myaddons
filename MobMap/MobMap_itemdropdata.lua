-- item drop data database functions

function MobMap_GetDropItemNameList(itemnamefilter)
	local i;
	local list={};
	local exactmatch=false;
	if(itemnamefilter) then
		if(string.sub(itemnamefilter,1,1)=="\"" and string.sub(itemnamefilter,-1)=="\"") then
			exactmatch=true;
			itemnamefilter=string.sub(itemnamefilter,2,string.len(itemnamefilter)-1);
		else
			exactmatch=false;
		end
	end

	for i=1,table.getn(mobmap_itemdropdataindex),1 do
		local data=mobmap_itemdropdataindex[i];
		local k;
		for k=0,1,1 do
			local currentIHID=MobMap_Mask(data/mobmap_poweroftwo[k*25],mobmap_poweroftwo[16]);
			local currentName=MobMap_GetItemNameByIHID(currentIHID);
			if(currentName and ((exactmatch==false and string.find(string.lower(currentName),".-"..string.lower(itemnamefilter)..".-")~=nil) or (exactmatch==true and string.lower(currentName)==string.lower(itemnamefilter)))) then
				table.insert(list, currentIHID);
			end
		end
	end
	return list;
end

function MobMap_GetDropChances(IHID)
	local i;
	local position=0;
	for i=1,table.getn(mobmap_itemdropdataindex),1 do
		local data=mobmap_itemdropdataindex[i];
		local k;
		for k=0,1,1 do
			local currentIHID=MobMap_Mask(data/mobmap_poweroftwo[k*25],mobmap_poweroftwo[16]);
			local length=MobMap_Mask(data/mobmap_poweroftwo[k*25+16],mobmap_poweroftwo[8]);
			local isPickup=MobMap_Mask(data/mobmap_poweroftwo[k*25+24],mobmap_poweroftwo[1]);
			if(isPickup==0) then isPickup=false; else isPickup=true; end
			if(currentIHID==IHID) then
				return MobMap_GetRealDropChances(position,length), isPickup;
			end
			position=position+length;
		end
	end
	return {};
end

function MobMap_GetRealDropChances(position, length)
	local p;
	local result={};
	for p=position,position+length-1,1 do
		local data=mobmap_itemdropdata[floor(p/2)+1];
		local m=MobMap_Mask(data/mobmap_poweroftwo[(p%2)*26],mobmap_poweroftwo[16]);
		local c=MobMap_Mask(data/mobmap_poweroftwo[(p%2)*26+16],mobmap_poweroftwo[9]);
		local h=MobMap_Mask(data/mobmap_poweroftwo[(p%2)*26+25],mobmap_poweroftwo[1]);
		c=c/5;
		if(h==0) then
			h=false;
		else
			h=true;
		end
		table.insert(result,{mobid=m, chance=c, heroiconly=h});
	end
	return result;
end

function MobMap_GetMobLootTable(mobid)
	local position=0;
	local result={};
	for i=1,table.getn(mobmap_itemdropdataindex),1 do
		local data=mobmap_itemdropdataindex[i];
		local k;
		for k=0,1,1 do
			local currentIHID=MobMap_Mask(data/mobmap_poweroftwo[k*25],mobmap_poweroftwo[16]);
			local length=MobMap_Mask(data/mobmap_poweroftwo[k*25+16],mobmap_poweroftwo[8]);
			for p=position,position+length-1,1 do
				local data=mobmap_itemdropdata[floor(p/2)+1];
				local m=MobMap_Mask(data/mobmap_poweroftwo[(p%2)*26],mobmap_poweroftwo[16]);
				if(m==mobid) then
					local c=MobMap_Mask(data/mobmap_poweroftwo[(p%2)*26+16],mobmap_poweroftwo[9]);
					local h=MobMap_Mask(data/mobmap_poweroftwo[(p%2)*26+25],mobmap_poweroftwo[1]);
					c=c/5;
					if(h==0) then
						h=false;
					else
						h=true;
					end
					local itemid, quality, isDangerous = MobMap_GetItemDataByIHID(currentIHID);
					local itemname=MobMap_GetItemNameByIHID(currentIHID);
					table.insert(result,{ihid=currentIHID, chance=c, heroiconly=h, itemid=itemid, itemname=itemname, quality=quality, isdangerous=isDangerous});
				end
			end

			position=position+length;			
		end
	end
	MobMap_SortMobLootTable(result);
	return result;
end

function MobMap_SortMobLootTable(tbl)
	table.sort(tbl, MobMap_SortMobLootTable_Comp);
end

function MobMap_SortMobLootTable_Comp(e, f)
	if(e.quality>f.quality) then
		return true;
	else
		if(e.quality<f.quality) then
			return false;
		else
			if(e.itemname<f.itemname) then
				return true;
			else
				if(e.itemname>f.itemname) then
					return false;
				else
					if(e.itemid<f.itemid) then
						return true;
					else
						return false;
					end
				end
			end
		end
	end			
end

function MobMap_GetCrateName(crateid)
	return mobmap_itemsourcecrates[crateid];
end

-- user interface functions

mobmap_drop_list_sorting=0;

function MobMap_DropListFrame_OnShow()
	if(mobmap_dropitemnamelist==nil) then
		MobMap_RefreshDropItemNameList();
	else
		MobMap_ShowSelectedItem();
	end
	MobMap_RefreshDropChanceList();
end

function MobMap_DropListByBosses_OnShow()
	MobMap_UpdateBossNameList();
end

function MobMap_DropListSortingOptions_Update()
	if(mobmap_drop_list_sorting==0) then
		MobMapDropListSortByItems:SetChecked(true);
		MobMapDropListSortByBosses:SetChecked(false);
		MobMapDropListByItem:Show();
		MobMapDropListByBosses:Hide();
	else
		MobMapDropListSortByItems:SetChecked(false);
		MobMapDropListSortByBosses:SetChecked(true);
		MobMapDropListByItem:Hide();
		MobMapDropListByBosses:Show();
	end
end

function MobMap_UpdateBossNameList()
	local maxbosscount=16+math.floor((mobmap_window_height-430)/18);
	for i=1,38,1 do
		MobMap_UpdateBossName(i, nil);
	end
	local offset=FauxScrollFrame_GetOffset(MobMapDropListBossScrollFrame);

	local bosscount=0;
	local k,v,l;
	for k,v in pairs(mobmap_instancelist) do
		bosscount=bosscount+1;
		local pos=bosscount-offset;
		if(v.isExpanded==nil) then
			v.isExpanded=false;
		end
		if(pos>=1 and pos<=maxbosscount) then
			MobMap_UpdateBossName(pos, v.name, nil, k, v.isExpanded);
		end
		if(v.isExpanded==true) then
			for l=1,table.getn(v),1 do
				bosscount=bosscount+1;
				pos=bosscount-offset;
				if(pos>=1 and pos<=maxbosscount) then
					if(v[l]>65000) then
						MobMap_UpdateBossName(pos, MobMap_GetCrateName(v[l]-65000), v[l]);
					else
						MobMap_UpdateBossName(pos, MobMap_GetMobName(v[l]), v[l]);
					end
				end
			end
		end
	end

	FauxScrollFrame_Update(MobMapDropListBossScrollFrame, bosscount, maxbosscount, 22);
end

function MobMap_UpdateBossName(pos, entry, bossid, instanceid, isExpanded)
	local frame=getglobal("MobMapDropListBoss"..pos);
	local framehighlight=getglobal("MobMapDropListBoss"..pos.."Highlight");
	local frametext=getglobal("MobMapDropListBoss"..pos.."Text");
	if(entry==nil) then
		frame:Hide();
	else
		frame:SetText(entry);
		frame.instanceid=instanceid;
		frame.bossid=bossid;
		if(isExpanded==true) then
			frame:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
			framehighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
			frame:UnlockHighlight();
		elseif(isExpanded==false) then
			frame:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
			framehighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
			frame:UnlockHighlight();
		else
			frame:SetNormalTexture("");
			framehighlight:SetTexture("");
		end		
		frame:Show();
	end
end

function MobMap_DropListBossNameEntry_OnClick()
	if(this.instanceid) then
		if(mobmap_instancelist[this.instanceid].isExpanded==true) then
			mobmap_instancelist[this.instanceid].isExpanded=false;
		else
			mobmap_instancelist[this.instanceid].isExpanded=true;
		end
	elseif(this.bossid) then
		MobMap_DisplayBossLootTable(this.bossid);
	end
	MobMap_UpdateBossNameList();
end

mobmap_bossloottable={};

function MobMap_DisplayBossLootTable(npcid)
	local title, subtitle=MobMap_GetMobNameAndSubtitle(MobMap_GetMobFullName(npcid));
	MobMapDropListByBossesName:SetText(title);
	if(subtitle) then
		MobMapDropListByBossesSubtitle:SetText(subtitle);
	else
		MobMapDropListByBossesSubtitle:SetText("");
	end
	local pointer=MobMap_GetMobPointer(npcid);
	if(pointer==nil) then return; end
	local minlevel, maxlevel = MobMap_GetMobDetails(pointer);
	if(minlevel~=maxlevel) then
		MobMapDropListByBossesLevel:SetText(MOBMAP_LEVEL..minlevel.." - "..maxlevel);
	else
		if(minlevel==0) then
			MobMapDropListByBossesLevel:SetText(MOBMAP_BOSS_LEVEL);
		else
			MobMapDropListByBossesLevel:SetText(MOBMAP_LEVEL..minlevel);
		end
	end
	mobmap_bossloottable=MobMap_GetMobLootTable(npcid);
	MobMap_UpdateBossLootTable();
end

function MobMap_UpdateBossLootTable()
	local maxlootcount=5+math.floor((mobmap_window_height-430)/44);
	local itemcount=table.getn(mobmap_bossloottable);
	local offset=FauxScrollFrame_GetOffset(MobMapDropListBossLootTableScrollFrame);

	for i=1,14,1 do
		local itemindex=i+offset;
		if(itemindex>itemcount or i>maxlootcount) then
			MobMap_UpdateBossLootTableEntry(i, nil);
		else
			MobMap_UpdateBossLootTableEntry(i, mobmap_bossloottable[itemindex]);
		end
	end

	FauxScrollFrame_Update(MobMapDropListBossLootTableScrollFrame, itemcount, maxlootcount, 22);
end

function MobMap_UpdateBossLootTableEntry(pos, entry)
	local frame=getglobal("MobMapBossLootTableEntry"..pos);
	local frame_item=getglobal("MobMapBossLootTableEntry"..pos.."ItemButton");
	local frame_name=getglobal("MobMapBossLootTableEntry"..pos.."Name");
	local frame_chance=getglobal("MobMapBossLootTableEntry"..pos.."Chance");
	local frame_heroic=getglobal("MobMapBossLootTableEntry"..pos.."Heroic");
	if(entry==nil) then
		frame:Hide();
	else
		frame_name:SetText(entry.itemname);
		local r, g, b = GetItemQualityColor(entry.quality);
		frame_name:SetTextColor(r,g,b);

		frame.itemid=entry.itemid;
		frame.ihid=entry.ihid;
		frame.isdangerous=entry.isdangerous;

		local itemString=MobMap_ConstructItemString(entry.itemid);
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemString);
		if(itemName==nil and entry.isdangerous==false) then
			MobMapScanTooltip:SetHyperlink(itemString);
			frame.itemlink=nil;
		else
			if(itemName==nil) then
				frame.itemlink=nil;
				local icon=MobMap_GetItemIcon(entry.itemid);
				if(icon) then
					SetItemButtonTexture(frame_item, "Interface\\Icons\\"..icon..".blp");
				else
					SetItemButtonTexture(frame_item, "Interface\\Icons\\INV_Misc_QuestionMark.blp");
				end
			else
				frame.itemlink=itemLink;
				SetItemButtonTexture(frame_item, itemTexture);
			end
		end
		if(entry.chance<=100) then
			frame_chance:SetText(string.format("%5.1f",entry.chance).."%");
		else
			frame_chance:SetText("???%");
		end
		if(entry.heroiconly==true) then
			frame_heroic:Show();
		else
			frame_heroic:Hide();
		end
		frame:Show();
	end
end

mobmap_bossloottable_timeout=0;

function MobMap_BossLootTable_OnUpdate()
	if(mobmap_bossloottable_timeout<0) then
		MobMap_UpdateBossLootTable();
		mobmap_bossloottable_timeout=0.5;
	else
		mobmap_bossloottable_timeout=mobmap_bossloottable_timeout-arg1;
	end
end

mobmap_dropitemnamelist=nil;

function MobMap_RefreshDropItemNameList()
	local filtertext=MobMapDropListItemNameFilter:GetText();
	mobmap_dropitemnamelist=MobMap_GetDropItemNameList(filtertext);
	FauxScrollFrame_SetOffset(MobMapDropListItemScrollFrame, 0);
	MobMap_UpdateDropItemNameList();
end

function MobMap_UpdateDropItemNameList()
	local maxitemcount=15+math.floor((mobmap_window_height-430)/18);
	local itemnamecount=table.getn(mobmap_dropitemnamelist);
	local offset=FauxScrollFrame_GetOffset(MobMapDropListItemScrollFrame);
	MobMapDropListFrameItemHighlightFrame:Hide();

	for i=1,37,1 do
		local itemindex=i+offset;
		if(itemindex>itemnamecount or i>maxitemcount) then
			MobMap_UpdateDropItemNameEntry(i, nil);
		else
			MobMap_UpdateDropItemNameEntry(i, mobmap_dropitemnamelist[itemindex]);
		end
	end

	FauxScrollFrame_Update(MobMapDropListItemScrollFrame, itemnamecount, maxitemcount, 22);
end

function MobMap_UpdateDropItemNameEntry(pos, ihid)
	local frame=getglobal("MobMapDropListItem"..pos);
	local frame_button=getglobal("MobMapDropListItem"..pos.."ItemName");
	local frame_text=getglobal("MobMapDropListItem"..pos.."ItemNameText");
	if(ihid==nil) then
		frame:Hide();
	else
		local itemname=MobMap_GetItemNameByIHID(ihid);
		local itemid, quality = MobMap_GetItemDataByIHID(ihid);
		if(itemname~=nil and itemid~=nil) then
			local r, g, b = GetItemQualityColor(quality);
			frame_text:SetText(itemname);
			frame_text:SetTextColor(r,g,b);
			frame.itemid=itemid;
			frame.ihid=ihid;
			frame:Show();
			if(ihid==MobMapDropListFrame.selecteditem) then
				MobMapDropListFrameItemHighlightFrame:Show();
				MobMapDropListFrameItemHighlightFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 2);
				MobMapDropListFrameItemHighlightFrame:SetAlpha(0.5);
				MobMapDropItemHighlight:SetVertexColor(1.0, 1.0, 1.0);
			end
		end
	end
end

function MobMap_DropListSelectItem(frame)
	if(frame==nil) then frame=this; end
	local ihid=frame:GetParent().ihid;
	if(IsControlKeyDown() or IsShiftKeyDown()) then
		local itemid=frame:GetParent().itemid;
		local itemString=MobMap_ConstructItemString(itemid);
		local itemName, itemLink = GetItemInfo(itemString);
		if(itemLink) then
			if(IsControlKeyDown()) then
				DressUpItemLink(itemLink);
			elseif(IsShiftKeyDown()) then
				ChatEdit_InsertLink(itemLink);
			end
		else
			MobMap_DisplayMessage(MOBMAP_UNSAFE_ITEM_LINK_ERROR);
		end
		return;
	end
	MobMapDropListFrame.selecteditem=ihid;
	MobMapDropListFrame.selecteditemname=MobMap_GetItemNameByIHID(ihid);
	MobMapDropListFrameItemHighlightFrame:Show();
	MobMapDropListFrameItemHighlightFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 2);
	MobMapDropListFrameItemHighlightFrame:SetAlpha(0.5);
	MobMapDropItemHighlight:SetVertexColor(1.0, 1.0, 1.0);
	MobMap_RefreshDropChanceList();
end

function MobMap_ShowSelectedItem()
	if(mobmap_dropitemnamelist==nil or MobMapDropListFrame.selecteditem==nil) then return; end
	local maxitemcount=15+math.floor((mobmap_window_height-430)/18);
	local i;
	for i=1,table.getn(mobmap_dropitemnamelist),1 do
		if(mobmap_dropitemnamelist[i]==MobMapDropListFrame.selecteditem) then
			local offset=i-1;
			if(offset+maxitemcount>table.getn(mobmap_dropitemnamelist)) then
				if(offset-(maxitemcount-1)<0) then
					offset=0;
				else
					offset=offset-(maxitemcount-1);
				end
			end
			FauxScrollFrame_SetOffset(MobMapDropListItemScrollFrame, offset);
			MobMap_UpdateDropItemNameList();
			return;
		end
	end
end


mobmap_dropchancelist={};

function MobMap_RefreshDropChanceList()
	if(MobMapDropListFrame.selecteditem==nil) then
		mobmap_dropchancelist={};
	else
		local isPickup;
		mobmap_dropchancelist, isPickup = MobMap_GetDropChances(MobMapDropListFrame.selecteditem);
		if(isPickup==true) then
			MobMapDropListMoreButton:Show();
		else
			MobMapDropListMoreButton:Hide();
		end
	end
	MobMap_UpdateDropChanceList();
end

function MobMap_UpdateDropChanceList()
	local maxdropchancecount=9+math.floor((mobmap_window_height-430)/33);
	local dropchancecount=table.getn(mobmap_dropchancelist);
	local offset=FauxScrollFrame_GetOffset(MobMapDropListMobScrollFrame);

	for i=1,21,1 do
		local dropindex=i+offset;
		if(dropindex>dropchancecount or i>maxdropchancecount) then
			MobMap_UpdateDropChanceEntry(i, nil);
		else
			MobMap_UpdateDropChanceEntry(i, mobmap_dropchancelist[dropindex]);
		end
	end

	FauxScrollFrame_Update(MobMapDropListMobScrollFrame, dropchancecount, maxdropchancecount, 22);
end

function MobMap_UpdateDropChanceEntry(pos, entry)
	local frame=getglobal("MobMapDropRateEntry"..pos);
	local frame_mobname=getglobal("MobMapDropRateEntry"..pos.."MobName");
	local frame_chance=getglobal("MobMapDropRateEntry"..pos.."Chance");
	local frame_heroic=getglobal("MobMapDropRateEntry"..pos.."Heroic");
	local frame_zone=getglobal("MobMapDropRateEntry"..pos.."ZoneAndLevel");
	if(entry==nil) then
		frame:Hide();
	else
		if(entry.mobid<=65000) then
			frame_mobname:SetText(MobMap_GetMobName(entry.mobid));
		else
			frame_mobname:SetText(MobMap_GetCrateName(entry.mobid-65000));
		end
		if(entry.chance<100) then
			frame_chance:SetText(string.format("%5.1f",entry.chance).."%");
		else
			frame_chance:SetText("???%");
		end
		local zonename=MobMap_GetMobZone(entry.mobid);
		if(zonename==nil) then
			zonename="???";
		else
			zonename=MobMap_GetZoneName(zonename);
		end
		if(entry.mobid<=65000) then
			local minlevel, maxlevel = MobMap_GetMobDetails(MobMap_GetMobPointer(entry.mobid));
			local moblevelstring;
			if(minlevel==maxlevel) then
				if(minlevel==0) then
					moblevelstring=MOBMAP_BOSS_LEVEL;
				else
					moblevelstring=MOBMAP_LEVEL..minlevel;
				end
			else
				moblevelstring=MOBMAP_LEVEL..minlevel.." - "..maxlevel;
			end
			frame_zone:SetText(zonename..", "..moblevelstring);
		else
			frame_zone:SetText("");
		end
		if(entry.heroiconly==true) then
			frame_heroic:Show();
		else
			frame_heroic:Hide();
		end
		frame:Show();
	end
end

function MobMap_IsInDropRateDatabase(itemname, minimumProbability)
	local list=MobMap_GetDropItemNameList("\""..itemname.."\"");
	if(table.getn(list)>0) then
		if(minimumProbability~=nil and table.getn(list)==1) then
			local chancelist=MobMap_GetDropChances(list[1]);
			local k,v;			
			for k,v in pairs(chancelist) do
				if(v.chance>=minimumProbability) then
					return true;
				end
			end
			return false;
		end
		return true;
	else
		return false;
	end
end

function MobMap_DoDropRateItemSearch(itemname)
	if(itemname==nil) then return; end
	MobMap_ShowPanel("MobMapDropListFrame");
	MobMapDropListItemNameFilter:SetText("\""..itemname.."\"");
	MobMap_RefreshDropItemNameList();
	if(MobMapDropListItem1:IsVisible()) then
		MobMap_DropListSelectItem(MobMapDropListItem1ItemName);
	end
end

function MobMap_BossLootItem_OnClick()
	if(this:GetParent().itemlink) then
		if(IsControlKeyDown()) then
			DressUpItemLink(this:GetParent().itemlink);
		elseif(IsShiftKeyDown()) then
			ChatEdit_InsertLink(this:GetParent().itemlink);
		end
	else
		MobMap_DisplayMessage(MOBMAP_UNSAFE_ITEM_LINK_ERROR);
	end
end
