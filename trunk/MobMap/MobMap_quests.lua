-- quest database functions

function MobMap_GetQuestList(namefilter, minlevel, maxlevel, zoneid, noHordeOnly, noAllianceOnly, minmoney, npcfilter, groupfilter, rewardid)
	local quests={};
	local questid;
	namefilter=MobMap_PatternEscape(namefilter);
	local match=true;
	for questid=1, MobMap_GetQuestCount(), 1 do
		match=true;
		local questname=MobMap_GetQuestName(questid);

		if(namefilter~=nil) then
			if(string.find(string.lower(questname),".-"..string.lower(namefilter)..".-")==nil) then match=false; end
		end

		local level, zone, prequest, postquest, isHorde, isAlliance, money, npc, sourcepointer, grouptype, always, choice = MobMap_GetDetailsForQuest(questid);

		if(match==true and minlevel~=nil) then
			if(level<minlevel) then match=false; end
		end

		if(match==true and maxlevel~=nil) then
			if(level>maxlevel) then match=false; end
		end
		if(match==true and zoneid~=nil) then
			if(zone~=zoneid) then match=false; end
		end
		if(match==true and noHordeOnly~=nil and noHordeOnly~=false) then
			if(isHorde==true and isAlliance==false) then match=false; end
		end
		if(match==true and noAllianceOnly~=nil and noAllianceOnly~=false) then
			if(isAlliance==true and isHorde==false) then match=false; end
		end
		if(match==true and minmoney~=nil) then
			if(money<minmoney) then match=false; end
		end
		if(match==true and npcfilter~=nil) then
			if(npc==0 or string.find(string.lower(MobMap_GetMobName(npc)),".-"..string.lower(npcfilter)..".-")==nil) then match=false; end
		end
		if(match==true and groupfilter~=nil) then
			if(grouptype~=groupfilter) then match=false; end
		end
		if(match==true and rewardid~=nil) then
			local k,v;
			local found=false;
			for k,v in pairs(choice) do
				if(v==tonumber(rewardid)) then found=true; break; end
			end
			if(found==false) then
				for k,v in pairs(always) do
					if(v==tonumber(rewardid)) then found=true; break; end
				end
			end
			if(found==false) then match=false; end
		end

		if(match==true) then
			table.insert(quests, questid);
		end
	end
	
	return quests;
end

function MobMap_GetDetailsForQuest(questid)
	local data1=mobmap_questdata[(questid-1)*3+1];
	local data2=mobmap_questdata[(questid-1)*3+2];
	local data3=mobmap_questdata[(questid-1)*3+3];
	if(data1==nil or data2==nil or data3==nil) then return nil; end
	local level=MobMap_Mask(data1,mobmap_poweroftwo[8]);
	local zoneid=MobMap_Mask(data1/mobmap_poweroftwo[8],mobmap_poweroftwo[8]);
	local prequest=MobMap_Mask(data1/mobmap_poweroftwo[16],mobmap_poweroftwo[16]);
	local postquest=MobMap_Mask(data1/mobmap_poweroftwo[32],mobmap_poweroftwo[16]);
	local isHorde=MobMap_Mask(data1/mobmap_poweroftwo[48],mobmap_poweroftwo[1]);
	if(isHorde==1) then isHorde=true; else isHorde=false; end
	local isAlliance=MobMap_Mask(data1/mobmap_poweroftwo[49],mobmap_poweroftwo[1]);
	if(isAlliance==1) then isAlliance=true; else isAlliance=false; end
	local money=MobMap_Mask(data2,mobmap_poweroftwo[24]);
	local npcid=MobMap_Mask(data2/mobmap_poweroftwo[24],mobmap_poweroftwo[16]);
	local grouptype=MobMap_Mask(data2/mobmap_poweroftwo[40],mobmap_poweroftwo[4]);
	local rewardpointer=MobMap_Mask(data3,mobmap_poweroftwo[20]);
	local rewardcount=MobMap_Mask(data3/mobmap_poweroftwo[20],mobmap_poweroftwo[4]);
	local sourcepointer=MobMap_Mask(data3/mobmap_poweroftwo[24],mobmap_poweroftwo[16]);


	local always={};
	local choice={};
	if(rewardcount>0) then
		local i;
		for i=1, rewardcount, 1 do
			local rewarddata=mobmap_questrewarddata[floor((rewardpointer+i-2)/3)+1];
			local rewardid=MobMap_Mask(rewarddata/mobmap_poweroftwo[((rewardpointer+i-2)%3)*17],mobmap_poweroftwo[16]);
			local isChoice=MobMap_Mask(rewarddata/mobmap_poweroftwo[((rewardpointer+i-2)%3)*17+16],mobmap_poweroftwo[1]);
			if(isChoice~=0) then
				table.insert(choice,rewardid);
			else
				table.insert(always,rewardid);
			end
		end
	end

	return level, zoneid, prequest, postquest, isHorde, isAlliance, money, npcid, sourcepointer, grouptype, always, choice;
end

function MobMap_GetNPCForQuest(questid)
	if(questid>MobMap_GetQuestCount()) then return 0; end
	local data=mobmap_questdata[(questid-1)*3+2];
	local npcid=MobMap_Mask(data/mobmap_poweroftwo[24],mobmap_poweroftwo[16]);
	return npcid;
end

function MobMap_GetPreAndPostQuestForQuest(questid)
	if(questid>MobMap_GetQuestCount()) then return 0; end
	local data=mobmap_questdata[(questid-1)*3+1];
	local prequest=MobMap_Mask(data/mobmap_poweroftwo[16],mobmap_poweroftwo[16]);
	local postquest=MobMap_Mask(data/mobmap_poweroftwo[32],mobmap_poweroftwo[16]);
	return prequest, postquest;
end

function MobMap_GetPreQuestForQuest(questid)
	if(questid>MobMap_GetQuestCount()) then return 0; end
	local data=mobmap_questdata[(questid-1)*3+1];
	local prequest=MobMap_Mask(data/mobmap_poweroftwo[16],mobmap_poweroftwo[16]);
	return prequest;
end

function MobMap_GetPostQuestForQuest(questid)
	if(questid>MobMap_GetQuestCount()) then return 0; end
	local data=mobmap_questdata[(questid-1)*3+1];
	local postquest=MobMap_Mask(data/mobmap_poweroftwo[32],mobmap_poweroftwo[16]);
	return postquest;
end

function MobMap_GetQuestName(questid)
	return mobmap_questnames[questid];
end

mobmap_inverse_questnames=nil;

function MobMap_GetQuestIDByName(questname, faction)
	local firstAlliance=(faction=="Alliance");
	local firstHorde=(faction=="Horde");
	local questTable;
	if(mobmap_optimize_response_times==true) then
		if(mobmap_inverse_questnames==nil) then
			mobmap_inverse_questnames={};
			local k,v;
			for k,v in pairs(mobmap_questnames) do
				if(mobmap_inverse_questnames[v]) then
					if(type(mobmap_inverse_questnames[v])~="table") then
						local newtable={};
						table.insert(newtable, mobmap_inverse_questnames[v]);
						mobmap_inverse_questnames[v]=newtable;
					end
					table.insert(mobmap_inverse_questnames[v],k);
				else
					mobmap_inverse_questnames[v]=k;
				end
			end
		end
		if(mobmap_inverse_questnames[questname]==nil) then
			return nil;
		else
			if(type(mobmap_inverse_questnames[questname])=="table") then
				questTable=mobmap_inverse_questnames[questname];
			else
				return mobmap_inverse_questnames[questname];
			end
		end
	else
		local k,v;
		questTable={};
		for k,v in pairs(mobmap_questnames) do
			if(v==questname) then
				table.insert(questTable, k);
			end
		end
	end
	local i;
	local quest=nil;
	for i=1, table.getn(questTable), 1 do
		quest=questTable[i];
		if(firstAlliance==false and firstHorde==false) then break; end
		local isHorde, isAlliance;
		_, _, _, _, isHorde, isAlliance = MobMap_GetDetailsForQuest(quest);
		if((firstAlliance==true and isAlliance==true) or (firstHorde==true and isHorde==true)) then break; end
	end
	return quest;
end

function MobMap_GetQuestObjective(questid)
	return HuffmanDecode(mobmap_questobjdata[questid], mobmap_questobjdata_huffmantree, mobmap_questobjdata_precodingtable);
end

function MobMap_GetQuestSourceName(sourcepointer)
	return mobmap_queststartitems[sourcepointer];
end

function MobMap_EvaluateQuestChains(quests)
	if(quests==nil) then return nil; end
	local result={};
	
	local key, questid, questsgiven, questsprocessed;
	
	questsgiven={};
	questsprocessed={};
	for key, questid in pairs(quests) do
		questsgiven[questid]=1;
	end

	for key, questid in pairs(quests) do
		if(questsprocessed[questid]~=1) then
			local prequest, postquest = MobMap_GetPreAndPostQuestForQuest(questid);
			local currentquest=questid;
			if(prequest~=0) then
				currentquest=MobMap_FindQuestChainStart(prequest);
				prequest, postquest = MobMap_GetPreAndPostQuestForQuest(currentquest);
			end
			repeat
				if(questsgiven[currentquest]==1) then
					table.insert(result,currentquest);
				else
					table.insert(result,currentquest+1000000);
				end
				questsprocessed[currentquest]=1;
				currentquest=MobMap_GetPostQuestForQuest(currentquest);
			until(currentquest==0 or currentquest>MobMap_GetQuestCount())
		end
	end

	return result;
end

function MobMap_FindQuestChainStart(questid)
	local prequest = MobMap_GetPreQuestForQuest(questid);
	if(prequest==0) then
		return questid;
	else
		return MobMap_FindQuestChainStart(prequest);
	end	
end

-- user interface functions

mobmap_questlist={};

function MobMap_RefreshQuestList()
	local namefilter=MobMapQuestListNameFilter:GetText();
	if(namefilter=="") then namefilter=nil; end
	local npcfilter=MobMapQuestListNPCFilter:GetText();
	if(npcfilter=="") then npcfilter=nil; end
	local zonefilter=MobMapQuestListZoneFilter:GetText();
	local i;
	local zoneid=MobMap_GetZoneID(zonefilter);
	if(zoneid==0 or zonefilter=="") then zoneid=nil; end

	local typefilter=UIDropDownMenu_GetSelectedID(MobMapQuestListTypeFilter);
	if(typefilter==1) then 
		typefilter=nil; 
	else
		if(typefilter>1) then typefilter=typefilter-2; end
	end
	local minlevel=MobMapQuestListMinLevelFilter:GetText();
	local maxlevel=MobMapQuestListMaxLevelFilter:GetText();
	if(minlevel=="") then minlevel=nil; else minlevel=tonumber(minlevel); end
	if(maxlevel=="") then maxlevel=nil; else maxlevel=tonumber(maxlevel); end
	local noAllianceOnly=nil;
	local noHordeOnly=nil;
	if(MobMapQuestListAllianceFilter:GetChecked()==1) then
		noHordeOnly=true;
	end
	if(MobMapQuestListHordeFilter:GetChecked()==1) then
		noAllianceOnly=true;
	end
	if(noAllianceOnly==true and noHordeOnly==true) then noAllianceOnly=nil; noHordeOnly=nil; end
	local moneyfilter=MoneyInputFrame_GetCopper(MobMapQuestListMoneyFilter);
	if(moneyfilter==0) then moneyfilter=nil; end
	local rewardid=MobMapQuestListRewardFilter.itemid;

	mobmap_questlist=MobMap_GetQuestList(namefilter, minlevel, maxlevel, zoneid, noHordeOnly, noAllianceOnly, moneyfilter, npcfilter, typefilter, rewardid);
	mobmap_questlist=MobMap_EvaluateQuestChains(mobmap_questlist);
	FauxScrollFrame_SetOffset(MobMapQuestListScrollFrame, 0);
	MobMap_UpdateQuestList();
end

function MobMap_UpdateQuestList()
	local maxquestcount=7+math.floor((mobmap_window_height-430)/30.6);
	local questcount=table.getn(mobmap_questlist);
	local offset=FauxScrollFrame_GetOffset(MobMapQuestListScrollFrame);

	for i=1,20,1 do
		local questindex=i+offset;
		local frame=getglobal("MobMapQuest"..i);
		if(questindex>questcount or i>maxquestcount) then
			MobMap_UpdateQuestEntry(i, nil);
		else
			MobMap_UpdateQuestEntry(i, mobmap_questlist[questindex]);
		end
	end

	FauxScrollFrame_Update(MobMapQuestListScrollFrame, questcount, maxquestcount, 22);
end

function MobMap_UpdateQuestEntry(frameid, questid)
	local frame=getglobal("MobMapQuest"..frameid);
	if(questid==nil) then
		frame:Hide();
	else
		if(questid>1000000) then
			frame.notinrs=true;
			frame:SetAlpha(0.5);
			questid=questid-1000000;
		else
			frame.notinrs=false;
			frame:SetAlpha(1.0);
		end
		frame.questid=questid;
		
		local level, zoneid, prequest, postquest, isHorde, isAlliance, money, npcid, sourcepointer, grouptype, always, choice = MobMap_GetDetailsForQuest(questid);

		local frame_name=getglobal("MobMapQuest"..frameid.."QuestName");
		local frame_source=getglobal("MobMapQuest"..frameid.."QuestSource");
		local frame_zone=getglobal("MobMapQuest"..frameid.."QuestZone");
		local frame_type=getglobal("MobMapQuest"..frameid.."QuestType");
		local frame_level=getglobal("MobMapQuest"..frameid.."QuestLevel");
		local frame_horde=getglobal("MobMapQuest"..frameid.."FactionIconHorde");
		local frame_alliance=getglobal("MobMapQuest"..frameid.."FactionIconAlliance");

		frame_name:SetText(MobMap_GetQuestName(questid));
		local questcolor=MobMap_GetQuestDifficultyColor(level);
		frame_name:SetTextColor(questcolor.r, questcolor.g, questcolor.b);
		if(prequest~=0) then
			frame_name:SetWidth(220);
			getglobal(frame_name:GetName().."Text"):SetWidth(220);
		else
			frame_name:SetWidth(240);
			getglobal(frame_name:GetName().."Text"):SetWidth(240);
		end

		if(npcid==0 and sourcepointer==0) then
			frame_source:SetText("???");
			frame_source:SetTextColor(1.0,1.0,1.0,1.0);
		else
			if(sourcepointer~=0) then
				frame_source:SetText("Item: "..MobMap_GetQuestSourceName(sourcepointer));
				frame_source:SetTextColor(1.0,1.0,1.0,1.0);
			else
				frame.npcid=npcid;
				frame_source:SetText(MobMap_GetMobName(npcid));
				frame_source:SetTextColor(1.0,0.82,0.0,1.0);
			end
		end

		frame_zone:SetText(MobMap_GetZoneName(zoneid));
		frame_type:SetText(MOBMAP_QUEST_TYPES[grouptype]);
		if(level==0) then
			frame_level:SetText("?");
		else
			frame_level:SetText(level);
		end

		if(isHorde==true) then
			frame_horde:Show();
		else
			frame_horde:Hide();
		end

		if(isAlliance==true) then
			frame_alliance:Show();
		else
			frame_alliance:Hide();
		end

		frame:Show();
	end
end

function MobMap_ClearQuestListFilters()
	MobMapQuestListNameFilter:SetText("");
	MobMapQuestListNPCFilter:SetText("");
	MobMapQuestListZoneFilter:SetText("");
	MobMapQuestListMinLevelFilter:SetText("");
	MobMapQuestListMaxLevelFilter:SetText("");
	MobMapQuestListAllianceFilter:SetChecked(false);
	MobMapQuestListHordeFilter:SetChecked(false);
	MoneyInputFrame_SetCopper(MobMapQuestListMoneyFilter, 0);
	MobMap_ClearRewardSelection();
end

function MobMap_ShowAllQuestGivers()
	local questgiverlist={};
	local i,k;
	for i=1,table.getn(mobmap_questlist),1 do
		local npcid=MobMap_GetNPCForQuest(mobmap_questlist[i]);
		if(npcid~=0) then
			local found=false;
			for k=1,table.getn(questgiverlist),1 do
				if(questgiverlist[k]==npcid) then
					found=true;
					break;
				end
			end
			if(found==false) then
				table.insert(questgiverlist, npcid);
				if(table.getn(questgiverlist)>=100) then
					break;
				end
			end
		end
	end
	if(table.getn(questgiverlist)>=100) then
		MobMap_DisplayMessage(MOBMAP_QUEST_TOO_MANY_QUEST_GIVERS);
	end
	MobMap_ShowMultipleMobs(questgiverlist);
end

function MobMap_QuestListTypeFilter_OnLoad()
	UIDropDownMenu_Initialize(this, MobMap_QuestListTypeFilter_Initialize);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetSelectedID(MobMapQuestListTypeFilter, 1);
end

function MobMap_QuestListTypeFilter_Initialize()
	local i;
	local info={};
	info.text=MOBMAP_QUEST_TYPE_FILTER_ALL;
	info.func=MobMap_QuestListTypeFilter_OnClick;
	UIDropDownMenu_AddButton(info);
	for i=1, 8, 1 do
		MobMap_QuestListTypeFilter_SubInitialize(i);
	end
end

function MobMap_QuestListTypeFilter_SubInitialize(id)
	local info={};
	info.text=MOBMAP_QUEST_TYPES[id-1];
	info.func=MobMap_QuestListTypeFilter_OnClick;
	UIDropDownMenu_AddButton(info);
end

function MobMap_QuestListTypeFilter_OnClick()
	UIDropDownMenu_SetSelectedID(MobMapQuestListTypeFilter, this:GetID());
end

mobmap_qlzf_notextchanged=0;
mobmap_qlzf_textlen=0;
mobmap_qlzf_marklen=0;

function MobMap_QuestListZoneFilter_OnTextChanged()
	if(mobmap_qlzf_notextchanged==1 or mobmap_qlzf_textlen==string.len(MobMapQuestListZoneFilter:GetText())+1 or mobmap_qlzf_textlen==string.len(MobMapQuestListZoneFilter:GetText())+mobmap_qlzf_marklen) then
		mobmap_qlzf_notextchanged=0;
		mobmap_qlzf_textlen=string.len(MobMapQuestListZoneFilter:GetText());
	else
		local text=MobMapQuestListZoneFilter:GetText();
		local match=nil;
		if(text~="") then
			local i;
			for i=1, 255, 1 do
				if(mobmap_zones[i]~=nil and string.find(string.lower(mobmap_zones[i]),"^"..string.lower(text)..".-")~=nil) then
					match=mobmap_zones[i];
					break;
				end
			end
		end
		if(match~=nil) then
			local textlen=string.len(text);
			mobmap_qlzf_notextchanged=1;
			mobmap_qlzf_textlen=string.len(match);
			MobMapQuestListZoneFilter:SetText(match);
			if(string.len(match)>textlen) then MobMapQuestListZoneFilter:HighlightText(textlen,string.len(match)); end
			mobmap_qlzf_marklen=string.len(match)-textlen;
		end
	end
end

function MobMap_OpenRewardSelection()
	MobMap_SetSelectionFunc(MobMap_DoRewardSelection);
	MobMap_ShowItemNameSelectionFrame(MobMapQuestListRewardFilter.selecteditem);
end

function MobMap_ClearRewardSelection()
	this:SetText(MOBMAP_QUEST_REWARD_FILTER_TEXT);
	this.itemid=nil;
	this.itemname=nil;
	this.selecteditem=nil;
	MobMap_RefreshQuestList();
end

function MobMap_DoRewardSelection(itemihid)
	MobMapQuestListRewardFilter.selecteditem=itemihid;
	MobMapQuestListRewardFilter.itemname=MobMap_GetItemNameByIHID(itemihid);
	local itemid, quality = MobMap_GetItemDataByIHID(itemihid);
	MobMapQuestListRewardFilter.itemid=itemid;
	local r, g, b = GetItemQualityColor(quality);
	local hexcolor=MobMap_RGBToHex(r,g,b);
	MobMapQuestListRewardFilter:SetText(MOBMAP_QUEST_REWARD_FILTER_PRETEXT.." |cFF"..hexcolor.."["..MobMapQuestListRewardFilter.itemname.."]|r");
	MobMap_RefreshQuestList();
end

function MobMap_DoQuestRewardSearch(itemihid)
	MobMap_ShowPanel("MobMapQuestListFrame");
	MobMap_ClearQuestListFilters();
	MobMap_DoRewardSelection(itemihid);
end

-- quest detail frame

function MobMap_ShowQuestDetails(questid)
	if(questid==0) then return; end
	MobMapQuestDetailFrame:Hide();
	local level, zone, prequest, postquest, isHorde, isAlliance, money, npc, sourcepointer, grouptype, always, choice = MobMap_GetDetailsForQuest(questid);
	if(level==nil) then return; end

	MobMapQuestDetailFrameTitleText:SetText(MobMap_GetQuestName(questid));
	MobMapQuestDetailFrameDetailsLevel:SetText(level);
	MobMapQuestDetailFrameDetailsType:SetText(MOBMAP_QUEST_TYPES_LONG[grouptype]);
	local factiontext="";
	if(isAlliance==true) then
		factiontext=MOBMAP_QUEST_FACTION_ALLIANCE;
	end
	if(isHorde==true) then
		if(factiontext~="") then factiontext=factiontext..", "; end
		factiontext=factiontext..MOBMAP_QUEST_FACTION_HORDE;
	end

	MobMapQuestDetailFrameDetailsFaction:SetText(factiontext);
	MobMapQuestDetailFrameDetailsPrequest:SetText("");
	MobMapQuestDetailFrameDetailsPrequest:Disable();
	local questname;
	if(prequest~=0) then
		questname=MobMap_GetQuestName(prequest);
		if(questname) then
			MobMapQuestDetailFrameDetailsPrequest.questid=prequest;
			MobMapQuestDetailFrameDetailsPrequest:SetText(questname);
			MobMapQuestDetailFrameDetailsPrequest:Enable();
		end
	end

	MobMapQuestDetailFrameDetailsPostquest:SetText("");
	MobMapQuestDetailFrameDetailsPostquest:Disable();
	if(postquest~=0) then
		questname=MobMap_GetQuestName(postquest);
		if(questname) then
			MobMapQuestDetailFrameDetailsPostquest.questid=postquest;
			MobMapQuestDetailFrameDetailsPostquest:SetText(questname);
			MobMapQuestDetailFrameDetailsPostquest:Enable();
		end
	end

	MobMapQuestDetailFrameDetailsSource:Disable();
	if(sourcepointer~=0) then
		MobMapQuestDetailFrameDetailsSource:SetText("Item: "..MobMap_GetQuestSourceName(sourcepointer));
	else
		if(npc==0) then
			MobMapQuestDetailFrameDetailsSource:SetText("???");
		else
			MobMapQuestDetailFrameDetailsSource.npcid=npc;
			MobMapQuestDetailFrameDetailsSource:SetText(MobMap_GetMobName(npc));
			MobMapQuestDetailFrameDetailsSource:Enable();
		end
	end

	MobMapQuestDetailFrameDetailsZone:SetText(MobMap_GetZoneName(zone));
	MobMap_DisplayObjective(MobMap_GetQuestObjective(questid));

	MoneyFrame_Update("MobMapQuestDetailFrameRewardsMoney", money);

	local i;
	for i=1,6,1 do
		getglobal("MobMapQuestDetailFrameRewardsChoosable"..i):Hide();
		getglobal("MobMapQuestDetailFrameRewardsChoosable"..i).itemid=nil;
	end
	for i=1,4,1 do
		getglobal("MobMapQuestDetailFrameRewardsAlways"..i):Hide();
		getglobal("MobMapQuestDetailFrameRewardsAlways"..i).itemid=nil;
	end

	local index, id;
	for index, id in pairs(choice) do
		local itemString=MobMap_ConstructItemString(id);
		local itemFrame=getglobal("MobMapQuestDetailFrameRewardsChoosable"..index);
		itemFrame.itemid=id;
		local itemName=GetItemInfo(itemString);
		if(itemName~=nil) then
			MobMap_ShowQuestReward(index, "Choosable", id);
		else
			if(mobmap_request_item_details==true) then
				MobMapScanTooltip:SetHyperlink(itemString);
			end
		end
	end

	for index, id in pairs(always) do
		local itemString=MobMap_ConstructItemString(id);
		local itemFrame=getglobal("MobMapQuestDetailFrameRewardsAlways"..index);
		itemFrame.itemid=id;
		local itemName=GetItemInfo(itemString);
		if(itemName~=nil) then
			MobMap_ShowQuestReward(index, "Always", id);
		else
			if(mobmap_request_item_details==true) then
				MobMapScanTooltip:SetHyperlink(itemString);
			end
		end
	end
	
	MobMapQuestDetailFrame:Show();
end

function MobMap_ShowQuestReward(index, rewardtype, itemid)
	local itemString=MobMap_ConstructItemString(itemid);
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemString);
	local itemFrame=getglobal("MobMapQuestDetailFrameRewards"..rewardtype..index);
	local itemFrameName=getglobal("MobMapQuestDetailFrameRewards"..rewardtype..index.."Name");
	local itemFrameTexture=getglobal("MobMapQuestDetailFrameRewards"..rewardtype..index.."IconTexture");
	if(itemName~=nil) then
		itemFrameName:SetText(itemName);
		local r, g, b = GetItemQualityColor(itemRarity);
		itemFrameName:SetTextColor(r,g,b);
		itemFrameTexture:SetTexture(itemTexture);
		itemFrame.itemstring=itemString;
		itemFrame.itemlink=itemLink;
		itemFrame:Show();
	else
		if(mobmap_request_item_details==true) then
			itemFrameName:SetText("???");
		else
			MobMap_LoadDatabase(MOBMAP_ITEMNAME_HELPER_DATABASE);
			local ihid=MobMap_GetIHIDByItemID(itemid);
			if(ihid~=nil) then
				itemFrameName:SetText(MobMap_GetItemNameByIHID(ihid));
				local _, quality=MobMap_GetItemDataByIHID(ihid);
				local r, g, b = GetItemQualityColor(quality);
				itemFrameName:SetTextColor(r,g,b);
			end
		end
		itemFrame.itemstring=nil;
		itemFrame.itemlink=nil;
		itemFrameTexture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark.blp");
		itemFrame:Show();
	end
end

local mobmap_questdetailframe_updatetimer = 0;

function MobMap_QuestDetailFrame_OnUpdate()
	if(mobmap_questdetailframe_updatetimer<=0) then
		local i;
		for i=1,6,1 do
			getglobal("MobMapQuestDetailFrameRewardsChoosable"..i):Hide();
		end
		for i=1,4,1 do
			getglobal("MobMapQuestDetailFrameRewardsAlways"..i):Hide();
		end

		local index;
		for index=1,6,1 do
			local itemFrame=getglobal("MobMapQuestDetailFrameRewardsChoosable"..index);
			if(itemFrame.itemid~=nil) then
				MobMap_ShowQuestReward(index, "Choosable", itemFrame.itemid);
			end
		end
		for index=1,4,1 do
			local itemFrame=getglobal("MobMapQuestDetailFrameRewardsAlways"..index);
			if(itemFrame.itemid~=nil) then
				MobMap_ShowQuestReward(index, "Always", itemFrame.itemid);
			end
		end
		mobmap_questdetailframe_updatetimer=0.5;
	else
		mobmap_questdetailframe_updatetimer=mobmap_questdetailframe_updatetimer-arg1;
	end
end

function MobMap_QuestItem_OnClick()
	if(IsControlKeyDown()) then
		if(this.itemlink~=nil) then
			DressUpItemLink(this.itemlink);
		end
	elseif(IsShiftKeyDown()) then
		if(this.itemlink~=nil) then
			ChatEdit_InsertLink(this.itemlink);
		end
	end
end

function MobMap_DisplayObjective(text)
	local i;
	local frame=nil;
	local space=MobMapQuestDetailFrameObjective;
	
	for i=1,200,1 do
		frame=getglobal("MobMapQuestDetailFrameObjectiveWord"..i);
		if(frame) then 
			frame:Hide(); 
			frame:ClearAllPoints();
		end
	end
	for i=1,20,1 do
		frame=getglobal("MobMapQuestDetailFrameObjectiveLink"..i);
		if(frame) then 
			frame:ClearAllPoints();
			frame:Hide();
		end
	end

	local parts={};
	local partcount=1;
	local inLink=false;
	for w in string.gmatch(text, "%S+") do
    		if(inLink==false) then
			parts[partcount]=w;
			if(string.find(w,"^|")~=nil) then
				inLink=true;
				if(string.find(w,"|.?$")~=nil) then
					inLink=false;
					partcount=partcount+1;
				end
			else
			    	partcount=partcount+1;
			end
		else
			parts[partcount]=parts[partcount].." "..w;
			if(string.find(w,"|.?$")~=nil) then
				inLink=false;
				partcount=partcount+1;
			end
		end
	end

	local k, token;
	local nextlink=1;
	local nextword=1;
	local xpos=0;
	local ypos=0;
	local lineheight=14;
	for k, token in pairs(parts) do
		if(string.find(token,"|")~=nil) then
			local id, entity, after = string.match(token,"^|(%d+)|(.*)|(.*)");
			if(id~=nil) then id=tonumber(id); end
			if(id~=nil and entity~=nil) then
				frame=getglobal("MobMapQuestDetailFrameObjectiveLink"..nextlink);
				if(frame==nil) then
					frame=CreateFrame("Button","MobMapQuestDetailFrameObjectiveLink"..nextlink,space,"MobMapQuestObjectiveLinkFrameTemplate");
				end
				local textobject=getglobal(frame:GetName().."Text");
				if(after==nil) then entity=entity.." "; end
				frame:SetText(entity);
				textobject:SetWidth(1000);
				local textwidth=textobject:GetStringWidth();
				textobject:SetWidth(textwidth+6);
				textobject:SetHeight(lineheight);
				frame:SetWidth(textwidth+6);
				frame:SetHeight(lineheight);
				if(xpos+textwidth>space:GetWidth()) then
					ypos=ypos-lineheight;
					xpos=0;
				end
				frame:ClearAllPoints();
				frame:SetPoint("TOPLEFT",space,"TOPLEFT",xpos,ypos);
				xpos=xpos+textwidth-2;
				frame:Show();
				frame.mobid=id;
				nextlink=nextlink+1;
			end
			token=after;
		end
		if(token~=nil) then
			frame=getglobal("MobMapQuestDetailFrameObjectiveWord"..nextword);
			if(frame==nil) then
				frame=CreateFrame("Frame","MobMapQuestDetailFrameObjectiveWord"..nextword,space,"MobMapQuestObjectiveWordFrameTemplate");
			end
			local textobject=getglobal(frame:GetName().."Text");
			textobject:SetText(token.." ");
			textobject:SetWidth(1000);
			local textwidth=textobject:GetStringWidth();
			textobject:SetWidth(textwidth+1);
			textobject:SetHeight(lineheight);
			frame:SetWidth(textwidth+1);
			frame:SetHeight(lineheight);
			if(xpos+textwidth>space:GetWidth()) then
				ypos=ypos-lineheight;
				xpos=0;
			end
			frame:ClearAllPoints();
			frame:SetPoint("TOPLEFT",space,"TOPLEFT",xpos,ypos);
			xpos=xpos+textwidth;
			frame:Show();
			nextword=nextword+1;
		end
	end
end