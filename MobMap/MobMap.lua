-- MobMap - an ingame mob position database - v1.58
-- main code file

-- coded 2007 by Slarti on EU-Blackhand

-- Fixed by Cosin@CWDG
-- Simplified Chinese ALL RIGHT By CWoW  Developer Group (CWDG)

-- global constants

mobmap_shiftconst = {
	[0] = 1,
	[1] = 256,
	[2] = 65536,
	[3] = 1,
	[4] = 16777216,
	[5] = 4294967296,
	[6] = 1099511627776,
	[7] = 1,
}

mobmap_poweroftwo = {
	[0] = 1,
	[1] = 2,
	[2] = 4,
	[3] = 8,
	[4] = 16,
	[5] = 32,
	[6] = 64,
	[7] = 128,
	[8] = 256,
	[9] = 512,
	[10] = 1024,
	[11] = 2048,
	[12] = 4096,
	[13] = 8192,
	[14] = 16384,
	[15] = 32768,
	[16] = 65536,
	[17] = 131072,
	[18] = 262144,
	[19] = 524288,
	[20] = 1048576,
	[21] = 2097152,
	[22] = 4194304,
	[23] = 8388608,
	[24] = 16777216,
	[25] = 33554432,
	[26] = 67108864,
	[27] = 134217728,
	[28] = 268435456,
	[29] = 536870912,
	[30] = 1073741824,
	[31] = 2147483648,
	[32] = 4294967296,
	[33] = 8589934592,
	[34] = 17179869184,
	[35] = 34359738368,
	[36] = 68719476736,
	[37] = 137438953472,
	[38] = 274877906944,
	[39] = 549755813888,
	[40] = 1099511627776,
	[41] = 2199023255552,
	[42] = 4398046511104,
	[43] = 8796093022208,
	[44] = 17592186044416,
	[45] = 35184372088832,
	[46] = 70368744177664,
	[47] = 140737488355328,
	[48] = 281474976710656,
	[49] = 562949953421312,
	[50] = 1125899906842624,
	[51] = 2251799813685248,
	[52] = 4503599627370496,
}

MOBMAP_POSITION_DATABASE = 1;
MOBMAP_QUEST_DATABASE = 2;
MOBMAP_MERCHANT_DATABASE = 3;
MOBMAP_RECIPE_DATABASE = 4;
MOBMAP_ITEMNAME_HELPER_DATABASE = 5;
MOBMAP_MOBNAME_DATABASE = 6;
MOBMAP_DROP_DATABASE = 7;
MOBMAP_PICKUP_DATABASE = 8;
MOBMAP_PICKUP_QUEST_ITEM_DATABASE = 9;
MOBMAP_PICKUP_FISHING_DATABASE = 10;
MOBMAP_PICKUP_MINING_DATABASE = 11;
MOBMAP_PICKUP_HERBS_DATABASE = 12;
MOBMAP_ITEM_TOOLTIP_DATABASE = 13;

MOBMAP_SPELL_MINING=1;
MOBMAP_SPELL_HERBGATHERING=2;
MOBMAP_SPELL_SKINNING=3;
MOBMAP_SPELL_PROSPECTING=4;
MOBMAP_SPELL_LOCKPICKING=5;
MOBMAP_SPELL_PICKPOCKETING=6;
MOBMAP_SPELL_OPENING=7;
MOBMAP_SPELL_DISENCHANTING=8;
MOBMAP_SPELL_ITEMOPENING=9;

MOBMAP_DBVERSION = "0011";

MOBMAP_EXPORT_MAXSIZE = 180000;

MOBMAP_ISONAMAC = IsMacClient();

MOBMAP_PARSETYPE_ITEMNAME = 1;

-- global variables

mobmap_enabled = true;
mobmap_scanning = true;
mobmap_minimap = false;
mobmap_positions = {};
mobmap_quests = {};
mobmap_merchantstock = {};
mobmap_tradeskills = {};
mobmap_loot = {};
mobmap_objects = {};
mobmap_trainer = {};
mobmap_monitor = {};
mobmap_monitor_quest = {};
mobmap_language = nil;
mobmap_dot_transparency = 1.0;
mobmap_button_position = 1;
mobmap_display_database_loading_info = false;
mobmap_show_world_map_tooltips = true;
mobmap_request_item_details = true;
mobmap_hide_questlog_buttons = false;
mobmap_hide_questtracker_buttons = false;
mobmap_hide_reagent_buttons = false;
mobmap_window_height = 430;
mobmap_optimize_response_times = false;
mobmap_minimap_button_visible = true;


mobmap_disabled = false;

-- general database functions

function MobMap_GetZoneName(id)
	return mobmap_zones[id];
end

function MobMap_GetZoneID(zonename)
	local k,v;
	for k,v in pairs(mobmap_zones) do
		if(v==zonename) then
			return k;
		end
	end
	return 0;
end

function MobMap_GetMobCount()
	return mobmap_dbinfo["mobcount"];
end

function MobMap_GetQuestCount()
	return mobmap_dbinfo["questcount"];
end

function MobMap_GetMerchantCount()
	return mobmap_dbinfo["merchantcount"];
end

function MobMap_GetRecipeCount()
	return mobmap_dbinfo["recipecount"];
end

function MobMap_GetDBVersion()
	return mobmap_dbinfo["version"];	
end

function MobMap_GetDBBuildTime()
	return mobmap_dbinfo["buildtime"];	
end

function MobMap_GetDBLanguage()
	return mobmap_dbinfo["language"];	
end

-- minimap button

function MobMap_MinimapButton_OnMove()
	MobMap_MoveMinimapButton();
end

function MobMap_MinimapButton_OnLoad()
	this:RegisterForDrag("LeftButton");
	this:SetMovable(true);
	MobMap_MoveMinimapButton(true);
end

function MobMap_MinimapButton_UpdateVisibility()
	if(mobmap_minimap_button_visible~=true or mobmap_disabled==true) then
		MobMapMinimapButtonFrame:Hide();
	else
		MobMapMinimapButtonFrame:Show();
	end
end

function MobMap_MoveMinimapButton(initial)
	this:ClearAllPoints();
	
	local uiscale=UIParent:GetScale();
	local cursorX, cursorY = GetCursorPosition();
	local minimapX, minimapY = Minimap:GetCenter();
	if(initial==true) then
		cursorX=minimapX;
		cursorY=minimapY+1;
	end
	cursorX=cursorX/uiscale;
	cursorY=cursorY/uiscale;
	
	local distanceX=cursorX-minimapX;
	local distanceY=cursorY-minimapY;
	local distance=sqrt(distanceX*distanceX+distanceY*distanceY);
	if(distance<85) then
		local angle=atan(distanceY/distanceX);
		if(distanceX<0) then
			angle=angle+180;
		end
		this:SetClampedToScreen(false);
		this:SetPoint("CENTER", Minimap, "CENTER", 80*cos(angle), 80*sin(angle));
		this:SetFrameLevel(Minimap:GetFrameLevel()+10);
	else
		this:SetClampedToScreen(true);
		this:SetPoint("CENTER", nil, "BOTTOMLEFT", cursorX, cursorY);
	end
end

-- quest objective parsing

mobmap_questsearch=false;

function MobMap_ParseQuestObjective(objective, typeID)--fix
	MobMap_LoadDatabase(MOBMAP_POSITION_DATABASE);
	MobMap_LoadDatabase(MOBMAP_DROP_DATABASE);
	MobMap_LoadDatabase(MOBMAP_PICKUP_DATABASE);

	local filtered=string.match(objective, ".*：");

	if(filtered~=nil) then
		filtered=string.match(objective, "^(.*)：");
	else
		filtered=objective;
	end

	-- Add By Cosin
	if string.match(filtered, "^已杀死(.*)") ~= nil then
		filtered = string.match(filtered, "^已杀死(.*)")
	elseif string.match(filtered, "^复活(.*)") ~= nil then
		filtered = string.match(filtered, "^复活(.*)")
	elseif string.match(filtered, "^营救(.*)") ~= nil then
		filtered = string.match(filtered, "^营救(.*)")
	elseif string.match(filtered, "^与(.*)交谈") ~= nil then
		filtered = string.match(filtered, "^与(.*)交谈")
	end
	-- End

	--add
	if(typeID==nil or typeID==MOBMAP_PARSETYPE_ITEMNAME) then
--end
		local ihid=MobMap_GetIHIDByItemName(filtered);
		if(ihid~=nil) then
			if(typeID==MOBMAP_PARSETYPE_ITEMNAME) then
				MobMap_LoadDatabase(MOBMAP_RECIPE_DATABASE);
				local itemID=MobMap_GetItemDataByIHID(ihid);
				local alternateItemID=mobmap_tradeskillreagentmappings[itemID];
				if(alternateItemID) then
					local alternateIHID=MobMap_GetIHIDByItemID(alternateItemID);
					if(alternateIHID) then 
						ihid=alternateIHID;
						filtered=MobMap_GetItemNameByItemID(alternateItemID);
					end
				end
			end
			--end
		local isDropped=MobMap_IsInDropRateDatabase(filtered, 1.0);
		local isPickedUp=MobMap_IsInQuestPickupDatabase(filtered);
			if(isDropped==true) then
				ShowUIPanel(MobMapFrame);
				MobMap_DoDropRateItemSearch(filtered);
				return;
			elseif(isPickedUp==true) then
				ShowUIPanel(MobMapFrame);
				MobMap_DoQuestPickupDatabaseSearch(filtered);
				return;
			else
				isDropped=MobMap_IsInDropRateDatabase(filtered);
				if(isDropped==true) then
					ShowUIPanel(MobMapFrame);
					MobMap_DoDropRateItemSearch(filtered);
					return;
				else
					MobMap_LoadDatabase(MOBMAP_MERCHANT_DATABASE);
					local isSold=MobMap_IsInMerchantDatabase(filtered);
					if(isSold==true) then
						ShowUIPanel(MobMapFrame);
						MobMap_DoMerchantItemSearch(ihid);
						return;
					end
				end
			end
		end

	end

	if(typeID==nil) then

	parts={};
	partcount=0;
	for w in string.gmatch(filtered, ".+") do--fix .+ ,%S+
		parts[partcount]=w;
		partcount=partcount+1;
	end
	local startingpoint, length, i;
	for startingpoint=0,partcount-1,1 do
		for length=partcount-startingpoint,1,-1 do
			local str="";
			for i=1,length,1 do
				str=str..parts[i+startingpoint-1];
				if(i<length) then str=str.." "; end
			end

	-- Add By Cosin
	-- Quick Search For Whole String
	-- test mobid
	--[[
	local mobid=MobMap_GetIDForMobName(filtered);
	if(mobid~=nil) then
		ShowUIPanel(MobMapFrame);
		MobMap_ShowPanel("MobMapMobSearchFrame");
		mobmap_questsearch=true;
		MobMap_ShowMobByName(filtered);
		return;
	end]]--
	-- End
	-- Changed By Cosin
	-- Origin Code : for w in string.gmatch(filtered, "%S+") do
    -- Origin Code : 		parts[partcount]=w;
	-- Origin Code :     	partcount=partcount+1;
	-- Origin Code : end
			local strUTF8 = utf8:new(filtered)
			local lenUTF8 = strUTF8:len()
			local i
--[[	for i = 1, lenUTF8 do
		parts[partcount] = strUTF8:getChar(i)
	    	partcount=partcount+1;
	end
	-- End
	local startingpoint, length, i;
	for startingpoint=0,partcount-1,1 do
		for length=partcount-startingpoint,1,-1 do
			local str="";
			for i=1,length,1 do
				str=str..parts[i+startingpoint-1];
				-- Delete By Cosin
				-- if(i<length) then str=str.." "; end
				-- End
			end
			local mobid=MobMap_GetIDForMobName(str);
			if(mobid~=nil) then
				ShowUIPanel(MobMapFrame);
				MobMap_ShowPanel("MobMapMobSearchFrame");
				mobmap_questsearch=true;
				MobMap_ShowMobByName(str);
				return;
				end
			end
		end
	end]]--
	--changed by cosin
			for i = lenUTF8, 1, -1 do
			str = strUTF8:sub(1, i)
			local mobid=MobMap_GetIDForMobName(str);
			if(mobid~=nil) then
				ShowUIPanel(MobMapFrame);
				MobMap_ShowPanel("MobMapMobSearchFrame");
				mobmap_questsearch=true;
				MobMap_ShowMobByName(str);
				return;
			end
			
			if(typeID == nil) then
			MobMap_DisplayMessage(MOBMAP_QUEST_PARSING_FAILED);
			ShowUIPanel(MobMapFrame);
			else
				if(typeID==MOBMAP_PARSETYPE_ITEMNAME) then
				MobMap_DisplayMessage(MOBMAP_ITEM_PARSING_FAILED);
				end
			end
		end
	end
	end
	end
end





function MobMap_ParseQuestTitle(questtitle)
	MobMap_LoadDatabase(MOBMAP_QUEST_DATABASE);
	local questid=MobMap_GetQuestIDByName(questtitle, UnitFactionGroup("player"));
	if(questid) then
		MobMap_ShowQuestDetails(questid);
	else
		MobMap_DisplayMessage(MOBMAP_QUEST_TITLE_NOT_FOUND);		
	end
end

function MobMap_ParseQuestTitleOrObjective(unknowntext)
	MobMap_LoadDatabase(MOBMAP_QUEST_DATABASE);
	local questid=MobMap_GetQuestIDByName(unknowntext, UnitFactionGroup("player"));
	if(questid) then
		MobMap_ShowQuestDetails(questid);
	else
		MobMap_ParseQuestObjective(unknowntext);		
	end
end

-- data acquisition

function MobMap_ScanTarget()
	local targetname=UnitName("target");
	if(targetname~=nil and targetname~=UNKNOWNOBJECT) then
		if(not UnitPlayerControlled("target") and not UnitIsPlayer("target") and not UnitIsDeadOrGhost("target") and (CheckInteractDistance("target", 3) or (UnitReaction("target", "player")~=nil and UnitReaction("target", "player")<5))) then
			if(not WorldMapFrame:IsVisible()) then
				local moblevel=UnitLevel("target");
				if(mobmap_positions[targetname]==nil) then
					mobmap_positions[targetname]={};
				end
				local x, y, zonename = MobMap_GetPlayerCoordinates();
				if(mobmap_positions[targetname][zonename]==nil) then
					mobmap_positions[targetname][zonename]={};
				end
				if(mobmap_positions[targetname]["min"]==nil) then
					mobmap_positions[targetname]["min"]=moblevel;
				else
					if(moblevel<mobmap_positions[targetname]["min"]) then mobmap_positions[targetname]["min"]=moblevel; end
				end
				if(mobmap_positions[targetname]["max"]==nil) then
					mobmap_positions[targetname]["max"]=moblevel;
				else
					if(moblevel>mobmap_positions[targetname]["max"]) then mobmap_positions[targetname]["max"]=moblevel; end
				end
				if(mobmap_positions[targetname][zonename][x.."/"..y]==nil) then
					mobmap_positions[targetname][zonename][x.."/"..y]=1;
					if(mobmap_debug) then MobMap_DisplayMessage("已找到"..targetname.."在区域"..zonename.."于"..x.." / "..y); end
				end
			end
		end
	end
end

mobmap_original_AcceptQuest=nil;

function MobMap_HookAcceptQuest()
	mobmap_original_AcceptQuest=AcceptQuest;
	AcceptQuest=MobMap_AcceptQuest;
end

function MobMap_AcceptQuest(...)
	MobMap_ScanQuest();
	mobmap_original_AcceptQuest(...);
end

function MobMap_ScanQuest()
	if(not QuestFrame:IsVisible()) then return; end
	local title=MobMap_FilterQuestTitle(GetTitleText());
	local objective=MobMap_GetOriginalQuestText(GetObjectiveText());
	local npcname=MobMap_GetQuestGiver();

		
	local zonename=GetRealZoneText();
	local playerfaction=UnitFactionGroup("player");
	if(title==nil or objective==nil or npcname==nil) then return; end

	local completetitle=title;
	local counter=0;
	while(mobmap_quests[completetitle]~=nil) do
		if(mobmap_quests[completetitle].obj==objective) then
			return;
		end
		counter=counter+1;
		completetitle=title.."|"..counter;
	end
	mobmap_quests[completetitle]={obj=objective, level=0, npc=npcname, zone=zonename, group="solo", faction=playerfaction};
	MobMap_QuestMonitor_ClearData();
	mobmap_monitor_quest.action="newquest";
	mobmap_monitor_quest.timestamp=MobMap_Monitor_GetTimestamp();
	mobmap_monitor_quest.title=completetitle;
end

function MobMap_GetOriginalQuestText(str)
	if(str==nil) then return ""; end
	str=string.gsub(str,UnitName("player").."([%s%.,:;%(%)%!%-%?'])","$N%1");
	str=string.gsub(str,UnitClass("player").."([%s%.,:;%(%)%!%-%?'])", "$C%1");
	str=string.gsub(str,string.lower(UnitClass("player")).."([%s%.,:;%(%)%!%-%?'])", "$c%1");
	str=string.gsub(str,UnitRace("player").."([%s%.,:;%(%)%!%-%?'])","$R%1");
	str=string.gsub(str,string.lower(UnitRace("player")).."([%s%.,:;%(%)%!%-%?'])","$r%1");
	return str;
end

function MobMap_ScanQuestLog()
	if(mobmap_monitor_quest.timestamp==nil) then return; end
	MobMap_QuestMonitor_CheckForTimeout(2);
	if(mobmap_monitor_quest.title==nil or mobmap_monitor_quest.action~="newquest") then return; end
	local quest=mobmap_quests[mobmap_monitor_quest.title];
	if(quest==nil) then return; end
	local objective, level, tag, time = MobMap_GetQuestInfoFromQuestLog(mobmap_monitor_quest.title);
	if(objective==nil) then return; end
	if(MobMap_GetOriginalQuestText(objective)==quest.obj) then
		quest.group=tag;
		quest.level=level;
		quest.time=time;
		MobMap_QuestMonitor_ClearData();
	end
end

mobmap_original_GetQuestReward=nil;

function MobMap_HookGetQuestReward()
	mobmap_original_GetQuestReward=GetQuestReward;
	GetQuestReward=MobMap_GetQuestReward;
end

function MobMap_GetQuestReward(...)
	MobMap_FinishQuest();
	mobmap_original_GetQuestReward(...);
end

function MobMap_FinishQuest()
	if(not QuestFrame:IsVisible()) then return; end
	local title=MobMap_FilterQuestTitle(GetTitleText());
	local objectiveText=MobMap_GetQuestInfoFromQuestLog(title);
	if(objectiveText==nil) then return; end
	local objective=MobMap_GetOriginalQuestText(objectiveText);
	local npcname=MobMap_GetQuestGiver();
	if(title==nil or objective==nil or npcname==nil) then return; end

	local completetitle=title;
	local counter=0;
	local quest=nil;
	while(mobmap_quests[completetitle]~=nil) do
		if(mobmap_quests[completetitle].obj==objective) then
			quest=mobmap_quests[completetitle];
			break;
		end
		counter=counter+1;
		completetitle=title.."|"..counter;
	end
	if(quest==nil) then
		mobmap_quests[completetitle]={};
		quest=mobmap_quests[completetitle];
		quest.obj=objective;
	end
	quest.endnpc=npcname;
	MobMap_QuestMonitor_ClearData();
	mobmap_monitor_quest.timestamp=MobMap_Monitor_GetTimestamp();
	mobmap_monitor_quest.action="endquest";
	mobmap_monitor_quest.title=completetitle;
end

function MobMap_GetQuestGiver()
	local target=UnitName("npc");
	if(target==nil) then return nil; end
	if(not UnitExists("npc")) then
		if(mobmap_monitor.action=="questitem") then
			local item=mobmap_monitor.target;
			if(item==nil) then item=""; end
			MobMap_Monitor_ClearData();
			return "ITEM:"..item;
		else
			MobMap_SaveObject(target, "quest");
			return "OBJECT:"..target;
		end
	else
		return target;
	end
end

function MobMap_GetQuestInfoFromQuestLog(title)
	local selected=GetQuestLogSelection();
	local collapsed={};
	local i=1;
	local objective=nil;
	local unlocalizedQuestTag="solo";
	local level=nil;
	local time=nil;
	while(i<=GetNumQuestLogEntries()) do
		local questTitle, questLevel, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(i);
		if(questTitle) then
			questTitle=MobMap_FilterQuestTitle(questTitle);
			if(isHeader) then
				if(isCollapsed) then
					collapsed[questTitle]=true;
					ExpandQuestHeader(i);
				end
			else
				if(questTitle==title) then
					SelectQuestLogEntry(i);
					_, objective = GetQuestLogQuestText();
					unlocalizedQuestTag="solo";
					if(questTag==ELITE) then unlocalizedQuestTag="elite"; end
					if(questTag==LFG_TYPE_DUNGEON) then unlocalizedQuestTag="dungeon"; end
					if(questTag==PVP) then unlocalizedQuestTag="pvp"; end
					if(questTag==RAID) then unlocalizedQuestTag="raid"; end
					if(questTag==GROUP) then unlocalizedQuestTag="group"; end
					if(questTag==DUNGEON_DIFFICULTY2) then unlocalizedQuestTag="heroic"; end
					if(isDaily) then unlocalizedQuestTag="daily"; end
					level=questLevel;
					time=GetQuestLogTimeLeft();
					if(time==nil) then time=0; end
				end
			end
		end
		i=i+1;
	end

	i=1;
	while(i<=GetNumQuestLogEntries()) do
		local questTitle, questLevel, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(i);
		if(questTitle) then
			questTitle=MobMap_FilterQuestTitle(questTitle);
			if(isHeader) then
				if(collapsed[questTitle]) then
					CollapseQuestHeader(i);
				end
			end
		end
		i=i+1;
	end

	SelectQuestLogEntry(selected);

	return objective, level, unlocalizedQuestTag, time;
end

function MobMap_ScanMerchant()
	if(not MerchantFrame:IsVisible()) then return; end
	local i;
	local merchantName=UnitName("npc");
	if(merchantName==nil) then return; end
	local merchantItemCount=GetMerchantNumItems();
	local merchantData={};

	local item;
	for item=1, merchantItemCount, 1 do
		local itemData={};
		local itemlink=GetMerchantItemLink(item);
		if(itemlink~=nil) then
			local itemid=MobMap_GetItemIDFromItemLink(itemlink);
			local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(item);
			itemData["id"]=itemid;
			itemData["price"]=price;
			itemData["quantity"]=quantity;
			if(numAvailable~=-1) then
				itemData["limited"]=1;
			else
				itemData["limited"]=0;
			end

			if(extendedCost) then
				local honorPoints, arenaPoints, itemCount = GetMerchantItemCostInfo(item);
				itemData["honorprice"]=honorPoints;
				itemData["arenaprice"]=arenaPoints;
				local token;
				for token=1, itemCount, 1 do
					local itemTexture, itemValue = GetMerchantItemCostItem(item, token);
					MobMapScanTooltip:Show();
					MobMapScanTooltip:SetOwner(UIParent, "ANCHOR_NONE");
					MobMapScanTooltip:SetMerchantCostItem(item, token);
					local itemName=MobMapScanTooltipTextLeft1:GetText();
					MobMapScanTooltip:Hide();
					if(itemName) then
						itemData["token"..token]=itemName.."|"..itemTexture.."|"..itemValue;
					end
				end
			end

			merchantData[tostring(item)]=itemData;
		end
	end

	mobmap_merchantstock[merchantName]=merchantData;
end

mobmap_original_GetTradeSkillInfo=nil;
mobmap_last_tradeskill_scan=0;

function MobMap_HookGetTradeSkillInfo()
	mobmap_original_GetTradeSkillInfo=GetTradeSkillInfo;
	GetTradeSkillInfo=MobMap_GetTradeSkillInfo;
end

function MobMap_GetTradeSkillInfo(skillIndex)
	local skillName, skillType, numAvailable, isExpanded = mobmap_original_GetTradeSkillInfo(skillIndex);

	if(skillName~=nil and skillType~="header" and mobmap_tradeskills[skillName]==nil) then
		if(mobmap_last_tradeskill_scan+2.0<GetTime()) then
			mobmap_last_tradeskill_scan=GetTime();
			local tradeskillItem={};
			if(mobmap_tradeskills[skillName]~=nil) then
				tradeskillItem=mobmap_tradeskills[skillName];
			end

			local tradeskillName, tradeskillLevel = GetTradeSkillLine();
			
			if(tradeskillName~=nil) then
				tradeskillItem["category"]=tradeskillName;
				local itemlink=GetTradeSkillItemLink(skillIndex);
				local errors=false;
				if(itemlink~=nil) then
					local reagentCount=GetTradeSkillNumReagents(skillIndex);			
					local i;
					for i=1,reagentCount,1 do
						local currentReagent={};
						local reagentName, reagentTexture, reagentCount = GetTradeSkillReagentInfo(skillIndex, i);
						local link=GetTradeSkillReagentItemLink(skillIndex, i);
						if(link==nil) then
							errors=true;
							break;
						end
						local itemid=MobMap_GetItemIDFromItemLink(link);
						currentReagent.itemid=itemid;
						currentReagent.count=reagentCount;
						tradeskillItem["reagent"..i]=currentReagent;
					end
					local minMade, maxMade = GetTradeSkillNumMade(skillIndex);
					local itemid=MobMap_GetItemIDFromItemLink(itemlink);
					tradeskillItem["itemid"]=itemid;
					tradeskillItem["level"]=tradeskillLevel;
					if(minMade~=1 or maxMade~=1) then
						tradeskillItem["minmade"]=minMade;
						tradeskillItem["maxmade"]=maxMade;
					end

					if(errors==false) then 
						mobmap_tradeskills[skillName]=tradeskillItem;
					end
				end
			end
		end
	end

	return skillName, skillType, numAvailable, isExpanded;
end

mobmap_original_GetCraftInfo=nil;

function MobMap_HookGetCraftInfo()
	mobmap_original_GetCraftInfo=GetCraftInfo;
	GetCraftInfo=MobMap_GetCraftInfo;
end

function MobMap_GetCraftInfo(skillIndex)
	local craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = mobmap_original_GetCraftInfo(skillIndex);

	if(craftName~=nil and craftType~="header" and mobmap_tradeskills[craftName]==nil) then
		if(mobmap_last_tradeskill_scan+2.0<GetTime()) then
			mobmap_last_tradeskill_scan=GetTime();
			local tradeskillItem={};
			local tradeskillName, tradeskillLevel = GetCraftDisplaySkillLine();
			
			if(tradeskillName~=nil) then
				tradeskillItem["category"]=tradeskillName;
				local enchantlink=GetCraftItemLink(skillIndex);
				local errors=false;
				if(enchantlink~=nil) then
					local reagentCount=GetCraftNumReagents(skillIndex);
					local i;
					for i=1,reagentCount,1 do
						local currentReagent={};
						local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo(skillIndex, i);
						local link=GetCraftReagentItemLink(skillIndex, i);
						if(link==nil) then
							errors=true;
							break;
						end
						local itemid=MobMap_GetItemIDFromItemLink(link);
						currentReagent.itemid=itemid;
						currentReagent.count=reagentCount;
						tradeskillItem["reagent"..i]=currentReagent;
					end
					local enchantid=MobMap_GetEnchantIDFromEnchantLink(enchantlink);
					if(enchantid~=nil) then
						tradeskillItem["enchantid"]=enchantid;
					else
						local itemid=MobMap_GetItemIDFromItemLink(enchantlink);
						if(itemid~=nil) then
							tradeskillItem["itemid"]=itemid;
						end
					end
					tradeskillItem["level"]=tradeskillLevel;

					if(errors==false) then mobmap_tradeskills[craftName]=tradeskillItem; end
				end
			end
		end
	end

	return craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel;
end

function MobMap_ScanLoot()
	local mobname=nil;
	MobMap_Monitor_CheckForTimeout(4);
	if(IsFishingLoot()) then
		mobname="FISH";
	elseif(mobmap_monitor.action=="spellsuccess" and mobmap_monitor.target~=nil) then
		if(mobmap_monitor.spelltype==MOBMAP_SPELL_PICKPOCKETING and mobmap_monitor.target=="n"..UnitName("target")) then
			mobname="PIPO"..mobmap_monitor.target;
		elseif(mobmap_monitor.spelltype==MOBMAP_SPELL_HERBGATHERING) then
			mobname="HERB"..mobmap_monitor.target;
		elseif(mobmap_monitor.spelltype==MOBMAP_SPELL_MINING) then
			mobname="MING"..mobmap_monitor.target;
		elseif(mobmap_monitor.spelltype==MOBMAP_SPELL_SKINNING) then
			mobname="SKIN"..mobmap_monitor.target;
		elseif(mobmap_monitor.spelltype==MOBMAP_SPELL_PROSPECTING) then
			mobname="PRSP"..mobmap_monitor.target;
		elseif(mobmap_monitor.spelltype==MOBMAP_SPELL_DISENCHANTING) then
			mobname="DISN"..mobmap_monitor.target;
		elseif(mobmap_monitor.spelltype==MOBMAP_SPELL_OPENING or mobmap_monitor.spelltype==MOBMAP_SPELL_LOCKPICKING) then
			mobname="OPEN"..mobmap_monitor.target;
		elseif(mobmap_monitor.spelltype==MOBMAP_SPELL_ITEMOPENING) then
			mobname="ITEM"..mobmap_monitor.target;
		else
			mobname="UNKN";
		end
	else		
		local targetname=UnitName("target");
		if(targetname~=nil and targetname~=UNKNOWNOBJECT) then
			if(CheckInteractDistance("target",4) and UnitIsDead("target") and not UnitIsFriend("player", "target") and not UnitIsPlayer("target")) then
				mobname="n"..targetname;
			else
				mobname="UNKN";
			end
		else
			mobname="UNKN";
		end
	end
	MobMap_Monitor_ClearData();
	local x, y, zonename = MobMap_GetPlayerCoordinates();
	if(x==nil or y==nil or zonename==nil) then return; end
	if(IsInInstance()) then
		local difficulty=GetInstanceDifficulty();
		if(difficulty==2) then zonename=zonename.."HEROIC"; end
	end
	local combinedname=mobname.."#"..x.."#"..y.."#"..zonename;

	local lootstring="+";
	local i;
	for i=1,GetNumLootItems(),1 do
		if(LootSlotIsItem(i)) then
			local itemid, suffixid, uniqueid = MobMap_GetItemIDFromItemLink(GetLootSlotLink(i));
			if(not(tonumber(suffixid)<0)) then
				uniqueid=0;
			end
			local _, _, count = GetLootSlotInfo(1);
			lootstring=lootstring..itemid..":"..suffixid..":"..uniqueid..":"..count.."#";
		elseif(LootSlotIsCoin(i)) then
			local _, moneystring = GetLootSlotInfo(i);
			local money=MobMap_GetMoneyFromMoneyString(moneystring);
			lootstring=lootstring..money.."#";
		end
	end
	if(lootstring=="+") then return; end

	if(mobmap_loot[combinedname]~=nil) then
		mobmap_loot[combinedname]=mobmap_loot[combinedname]..lootstring;
	else
		mobmap_loot[combinedname]=lootstring;
	end
end

function MobMap_ScanTrainer()
	if(not UnitExists("npc")) then return; end
	local npcname=UnitName("npc");

	local i;
	local currentGroup="";
	for i=1,GetNumTrainerServices(),1 do
		local name, rank, category = GetTrainerServiceInfo(i);
		if(name~=nil and category~=nil) then
			if(category=="header") then
				currentGroup=name;
			else
				local trainerOffer={};
				if(rank==nil) then rank=""; end
				local level=GetTrainerServiceLevelReq(i);
				if(level==nil) then level=0; end
				trainerOffer.level=level;
				local cost=GetTrainerServiceCost(i);
				if(cost==nil) then cost=0; end
				trainerOffer.cost=cost;
				local skillName, skillRank = GetTrainerServiceSkillReq(i);
				if(skillName~=nil and skillRank~=nil) then
					trainerOffer.skillName=skillName;
					trainerOffer.skillRank=skillRank;
				end
				local fullName=name.."|"..rank.."|"..currentGroup;

				if(not mobmap_trainer[npcname]) then
					mobmap_trainer[npcname]={};
				end

				if(not mobmap_trainer[npcname][fullName]) then
					mobmap_trainer[npcname][fullName]=trainerOffer;
				end
			end
		end
	end
end

function MobMap_UseContainerItem(bag, slot)
	if(not MerchantFrame:IsShown() and bag~=nil and slot~=nil) then
		local itemLink=GetContainerItemLink(bag, slot);
		if(itemLink==nil) then return; end
		local itemID=MobMap_GetItemIDFromItemLink(itemLink);

		MobMapScanTooltip:Show();
		MobMapScanTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		MobMapScanTooltip:SetBagItem(bag, slot);

		local i;
		for i=2, MobMapScanTooltip:NumLines(), 1 do
			local line=getglobal("MobMapScanTooltipTextLeft"..i):GetText();
			if(line==ITEM_OPENABLE) then
				MobMap_Monitor_ClearData();
				mobmap_monitor.action="spellsuccess";
				mobmap_monitor.spelltype=MOBMAP_SPELL_ITEMOPENING;
				mobmap_monitor.timestamp=MobMap_Monitor_GetTimestamp();
				mobmap_monitor.target="i"..itemID;
				break;
			elseif(line==ITEM_STARTS_QUEST) then
				MobMap_Monitor_ClearData();
				mobmap_monitor.action="questitem";
				mobmap_monitor.timestamp=MobMap_Monitor_GetTimestamp();
				mobmap_monitor.target=itemID;
				break;
			end
		end

		MobMapScanTooltip:Hide();
	end
end

function MobMap_HookUseContainerItem()
	hooksecurefunc("UseContainerItem", MobMap_UseContainerItem);
end

function MobMap_SaveObject(objectName, objectType)
	if(objectName==nil or objectType==nil) then return; end
	local x, y, zonename = MobMap_GetPlayerCoordinates();
	if(x==nil or y==nil or zonename==nil) then return; end
	local combinedname=objectName.."#"..objectType;
	if(mobmap_objects[combinedname]==nil) then
		mobmap_objects[combinedname]={};
	end
	local position=x.."#"..y.."#"..zonename;
	if(mobmap_objects[combinedname][position]==nil) then
		mobmap_objects[combinedname][position]=1;
	end
end

function MobMap_Monitor_SpellCastSent(unit, spell, rank, target)
	if(unit~="player") then return; end
	local spellType=MobMap_Monitor_GetSpellType(spell);
	if(spellType==nil) then return; end
	mobmap_monitor.action="spellcast";
	mobmap_monitor.spelltype=spellType;
	mobmap_monitor.timestamp=MobMap_Monitor_GetTimestamp();
	if(target==nil or target=="") then
		if(spellType==MOBMAP_SPELL_DISENCHANTING or spellType==MOBMAP_SPELL_PROSPECTING) then
			local itemName, itemLink = GameTooltip:GetItem();
			if(itemLink) then
				local itemID=MobMap_GetItemIDFromItemLink(itemLink);
				target="i"..itemID;
			end
		else
			target=GameTooltipTextLeft1:GetText();
			if(target=="") then target=nil; end
		end
	end

	if((spellType==MOBMAP_SPELL_HERBGATHERING or spellType==MOBMAP_SPELL_MINING or spellType==MOBMAP_SPELL_PICKPOCKETING) and target~=nil) then
		if(UnitName("target")==target and target~=nil) then
			target="n"..target;
		else
			target="o"..target;
		end
	end

	if(spellType==MOBMAP_SPELL_SKINNING and target~=nil) then
		target="n"..target;
	end

	if((spellType==MOBMAP_SPELL_OPENING or spellType==MOBMAP_SPELL_LOCKPICKING) and target~=nil) then
		MobMap_SaveObject(target, "container");
		target="o"..target;
	elseif(spellType==MOBMAP_SPELL_HERBGATHERING and target~=nil and string.len(target)>1 and string.sub(target,1,1)=="o") then
		MobMap_SaveObject(string.sub(target,2), "herb");
	elseif(spellType==MOBMAP_SPELL_MINING and target~=nil and string.len(target)>1 and string.sub(target,1,1)=="o") then
		MobMap_SaveObject(string.sub(target,2), "mine");
	end


	if(target~=nil and string.len(target)>1 and (string.sub(target,1,1)=="n" or string.sub(target,1,1)=="o" or string.sub(target,1,1)=="i")) then
		mobmap_monitor.target=target;
	else
		MobMap_Monitor_ClearData();
	end
end

function MobMap_Monitor_SpellCastFailed(unit)
	if(unit=="player") then
		MobMap_Monitor_ClearData();
	end	
end

function MobMap_Monitor_SpellCastInterrupted(unit)
	if(unit=="player") then
		MobMap_Monitor_ClearData();
	end
end

function MobMap_Monitor_SpellCastSucceeded(unit, spell, rank)
	local spellType=MobMap_Monitor_GetSpellType(spell);
	if(unit=="player" and mobmap_monitor.action=="spellcast" and mobmap_monitor.spelltype==spellType) then
		mobmap_monitor.action="spellsuccess";
		mobmap_monitor.timestamp=MobMap_Monitor_GetTimestamp();
	end
end

function MobMap_Monitor_GetTimestamp()
	return GetTime();
end

function MobMap_Monitor_CheckForTimeout(timeout)
	if(mobmap_monitor.timestamp~=nil) then
		if(MobMap_Monitor_GetTimestamp()-mobmap_monitor.timestamp>timeout) then
			MobMap_Monitor_ClearData();
		end
	end
end

function MobMap_Monitor_ClearData()
	mobmap_monitor={};
end

function MobMap_Monitor_GetSpellType(spellname)
	spellname=string.lower(spellname);
	if(string.find(spellname, MOBMAP_MONITOR_SPELL_OPENING)) then
		return MOBMAP_SPELL_OPENING;
	elseif(string.find(spellname, MOBMAP_MONITOR_SPELL_DISENCHANTING)) then
		return MOBMAP_SPELL_DISENCHANTING;
	elseif(string.find(spellname, MOBMAP_MONITOR_SPELL_MINING)) then
		return MOBMAP_SPELL_MINING;
	elseif(string.find(spellname, MOBMAP_MONITOR_SPELL_HERBGATHERING)) then
		return MOBMAP_SPELL_HERBGATHERING;
	elseif(string.find(spellname, MOBMAP_MONITOR_SPELL_SKINNING)) then
		return MOBMAP_SPELL_SKINNING;
	elseif(string.find(spellname, MOBMAP_MONITOR_SPELL_PROSPECTING)) then
		return MOBMAP_SPELL_PROSPECTING;
	elseif(string.find(spellname, MOBMAP_MONITOR_SPELL_LOCKPICKING)) then
		return MOBMAP_SPELL_LOCKPICKING;
	elseif(string.find(spellname, MOBMAP_MONITOR_SPELL_PICKPOCKETING)) then
		return MOBMAP_SPELL_PICKPOCKETING;
	end

	return nil;
end

function MobMap_QuestMonitor_CheckForTimeout(timeout)
	if(mobmap_monitor_quest.timestamp~=nil) then
		if(MobMap_Monitor_GetTimestamp()-mobmap_monitor_quest.timestamp>timeout) then
			MobMap_QuestMonitor_ClearData();
		end
	end
end

function MobMap_QuestMonitor_ClearData()
	mobmap_monitor_quest={};
end

function MobMap_QuestMonitor_XPGained(msg)
	if(mobmap_monitor_quest.timestamp==nil) then return; end
	MobMap_QuestMonitor_CheckForTimeout(2);
	if(mobmap_monitor_quest.title==nil or mobmap_monitor_quest.action~="endquest") then return; end
	local quest=mobmap_quests[mobmap_monitor_quest.title];
	if(quest==nil) then return; end
	local xp=MobMap_GetDataFromChatMessage(COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED, msg);
	if(xp==nil) then return; end
	xp=tonumber(xp);
	quest.xp=xp;
end

function MobMap_QuestMonitor_FactionChange(msg)
	if(mobmap_monitor_quest.timestamp==nil) then return; end
	MobMap_QuestMonitor_CheckForTimeout(2);
	if(mobmap_monitor_quest.title==nil or mobmap_monitor_quest.action~="endquest") then return; end
	local quest=mobmap_quests[mobmap_monitor_quest.title];
	if(quest==nil) then return; end
	local faction, reputation = MobMap_GetDataFromChatMessage(FACTION_STANDING_INCREASED, msg);
	if(faction) then
		MobMap_QuestMonitor_RegisterFactionChange(quest, faction, tonumber(reputation));
		return;
	end
	faction, reputation = MobMap_GetDataFromChatMessage(FACTION_STANDING_DECREASED, msg);
	if(faction) then 
		MobMap_QuestMonitor_RegisterFactionChange(quest, faction, -tonumber(reputation));
	end
end

function MobMap_QuestMonitor_RegisterFactionChange(quest, faction, amount)
	if(quest==nil or faction==nil or amount==nil) then return; end
	local _, race = UnitRace("player");
	if(race=="Human" and amount>0) then
		amount=math.floor(amount/1.1+0.5);
	end
	if(quest.reputation==nil) then
		quest.reputation={};
	end
	if(quest.reputation[faction]==nil) then
		quest.reputation[faction]=amount;
	else
		quest.reputation[faction]=quest.reputation[faction]+amount;
	end
end


--- user interface

function MobMapButtonFrame_OnLoad()
	SLASH_MOBMAP1 = "/mobmap";
	SlashCmdList["MOBMAP"] = MobMap_Command;
end

function MobMap_PlaceMobMapButtonFrame()
	if(Cartographer) then--fix bywolftankk
		MobMapDotParentFrame:SetFrameStrata(WorldMapPositioningGuide:GetFrameStrata());
		MobMapDotParentFrame:SetWidth(WorldMapPositioningGuide:GetWidth()*2);
		MobMapDotParentFrame:SetHeight(WorldMapPositioningGuide:GetHeight()*2);
		MobMapDotParentFrame:SetScale(WorldMapFrame:GetScale()*3);
		MobMapDotParentFrame:ClearAllPoints();
		MobMapDotParentFrame:SetAllPoints(WorldMapPositioningGuide);
		MobMapButtonFrame:SetParent(UIParent);
		MobMapButtonFrame:SetFrameStrata(WorldMapPositioningGuide:GetFrameStrata());
	else
		MobMapButtonFrame:SetParent(WorldMapFrame);
	end
	if(mobmap_button_position==0) then
		MobMapButtonFrame:Hide();
	end
	if(mobmap_button_position==2) then
		MobMapButtonFrame:SetPoint("TOPRIGHT","WorldMapPositioningGuide","TOPRIGHT",-4,-24);
		MobMapButtonFrame:SetFrameLevel(WorldMapPositioningGuide:GetFrameLevel()+20);
		MobMapButton:ClearAllPoints();
		MobMapButton:SetPoint("TOPRIGHT","MobMapButtonFrame","TOPRIGHT",0,0);
		MobMapCheckButton:ClearAllPoints();
		MobMapCheckButton:SetPoint("TOPRIGHT","MobMapButtonFrame","TOPRIGHT",-170,-22);
		MobMapButtonFrameCurrentMob:ClearAllPoints();
		MobMapButtonFrameCurrentMob:SetPoint("TOPRIGHT","MobMapButtonFrame","TOPRIGHT",-106,-6);
		MobMapButtonFrameCurrentMob:SetJustifyH("right");
		MobMapCheckButton:SetChecked(mobmap_enabled);
		MobMapButtonFrame:Show();
	end
	if(mobmap_button_position==1) then
		MobMapButtonFrame:SetPoint("BOTTOMLEFT","WorldMapPositioningGuide","BOTTOMLEFT",0,4);
		MobMapButtonFrame:SetFrameLevel(WorldMapPositioningGuide:GetFrameLevel()+20);
		MobMapButton:ClearAllPoints();
		MobMapButton:SetPoint("BOTTOMLEFT","MobMapButtonFrame","BOTTOMLEFT",4,0);
		MobMapCheckButton:ClearAllPoints();
		MobMapCheckButton:SetPoint("LEFT","MobMapButton","RIGHT",10,0);
		MobMapButtonFrameCurrentMob:ClearAllPoints();
		MobMapButtonFrameCurrentMob:SetPoint("LEFT","MobMapCheckButton","RIGHT",200,0);
		MobMapButtonFrameCurrentMob:SetJustifyH("left");
		MobMapCheckButton:SetChecked(mobmap_enabled);
		MobMapButtonFrame:Show();
	end
	if(mobmap_button_position==3) then
		MobMapButtonFrame:SetPoint("BOTTOMRIGHT","WorldMapPositioningGuide","BOTTOMRIGHT",0,4);
		MobMapButtonFrame:SetFrameLevel(WorldMapPositioningGuide:GetFrameLevel()+20);
		MobMapButton:ClearAllPoints();
		MobMapButton:SetPoint("BOTTOMRIGHT","MobMapButtonFrame","BOTTOMRIGHT",-4,0);
		MobMapCheckButton:ClearAllPoints();
		MobMapCheckButton:SetPoint("RIGHT","MobMapButton","LEFT",-180,0);
		MobMapButtonFrameCurrentMob:ClearAllPoints();
		MobMapButtonFrameCurrentMob:SetPoint("RIGHT","MobMapCheckButton","LEFT",-20,0);
		MobMapButtonFrameCurrentMob:SetJustifyH("right");
		MobMapCheckButton:SetChecked(mobmap_enabled);
		MobMapButtonFrame:Show();
	end
end

function MobMap_ShowMobMapFrame()
	if(mobmap_disabled) then return; end
	if(not MobMapFrame:IsVisible()) then
		ShowUIPanel(MobMapFrame);
		if(MobMapMobSearchFrame) then MobMap_UpdateMobMapFrame(); end
	end
end

function MobMap_ToggleMobMapFrame()
	if(mobmap_disabled) then return; end
	if(MobMapFrame:IsVisible()) then
		HideUIPanel(MobMapFrame);
	else
		ShowUIPanel(MobMapFrame);
		if(MobMapMobSearchFrame) then MobMap_UpdateMobMapFrame(); end
	end
end

function MobMap_ShowExportFrame()
	if(MobMapExportFrame:IsVisible()) then
		HideUIPanel(MobMapExportFrame);
	else
		if(GetLocale()~="deDE" and GetLocale()~="enUS" and GetLocale()~="enGB" and GetLocale()~="zhCN") then
			MobMap_DisplayMessage(MOBMAP_UNSUPPORTED_LOCALE);
		else
			MobMap_ExportData();
		end
	end
end

function MobMapFrame_OnLoad()
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("ADDON_LOADED");
	MobMap_ShowPanel("MobMapAboutFrame");
end

mobmap_lastzone="";

function MobMapFrame_OnEvent()
	if(event=="WORLD_MAP_UPDATE") then
		if(mobmap_enabled and WorldMapFrame:IsVisible()) then
			MobMapButtonFrame:Show();
			MobMapDotParentFrame:Show();
		end
		if(mobmap_enabled and WorldMapFrame:IsVisible() and (MobMapMobSearchFrame or MobMapPickupListFrame)) then
			if(mobmap_lastzone~=MobMap_GetCurrentMapZoneName()) then
				mobmap_lastzone=MobMap_GetCurrentMapZoneName();
				MobMap_Display();
			end
		end
	elseif(event=="PLAYER_TARGET_CHANGED") then
		if(mobmap_scanning) then 
			MobMap_ScanTarget();
		else
			MobMapFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
		end
	elseif(event=="UNIT_SPELLCAST_SENT") then
		MobMap_Monitor_SpellCastSent(arg1, arg2, arg3, arg4);
	elseif(event=="UNIT_SPELLCAST_SUCCEEDED") then
		MobMap_Monitor_SpellCastSucceeded(arg1, arg2, arg3);
	elseif(event=="UNIT_SPELLCAST_FAILED") then
		MobMap_Monitor_SpellCastFailed(arg1);
	elseif(event=="UNIT_SPELLCAST_INTERRUPTED") then
		MobMap_Monitor_SpellCastInterrupted(arg1);
	elseif(event=="CHAT_MSG_COMBAT_XP_GAIN") then
		MobMap_QuestMonitor_XPGained(arg1);
	elseif(event=="CHAT_MSG_COMBAT_FACTION_CHANGE") then
		MobMap_QuestMonitor_FactionChange(arg1);
	elseif(event=="LOOT_OPENED") then
		if(mobmap_scanning) then
			MobMap_ScanLoot();
		else
			MobMapFrame:UnregisterEvent("LOOT_OPENED");
		end
	elseif(event=="QUEST_LOG_UPDATE") then
		if(mobmap_scanning) then 
			MobMap_ScanQuestLog();
		end
	elseif(event=="MERCHANT_SHOW") then
		if(mobmap_scanning) then 
			MobMap_ScanMerchant();
		end
	elseif(event=="MERCHANT_UPDATE") then
		if(mobmap_scanning) then 
			MobMap_ScanMerchant();
		end
	elseif(event=="TRAINER_UPDATE") then
		if(mobmap_scanning) then
			MobMap_ScanTrainer();
		end
	elseif(event=="ADDON_LOADED") then
		if(string.find(arg1,"MobMap")~=nil) then
			local addonsAvailable=true;
			local i;
			for i=1,13,1 do
				local name, _, _, _, loadable = GetAddOnInfo("MobMapDatabaseStub"..i);
				if(name==nil or loadable==nil) then addonsAvailable=false; end
			end

			if(addonsAvailable==false) then
				MobMap_DisplayMessage(MOBMAP_ERROR_ON_LOAD);
				mobmap_disabled=true;
			else
				if(mobmap_dbinfo==nil) then
					MobMap_ErrorMessage(MOBMAP_ERROR_NO_DB_INSTALLED);
					mobmap_disabled=true;
				else
					if(MobMap_GetDBVersion()~=MOBMAP_DBVERSION) then
						MobMap_ErrorMessage(MOBMAP_ERROR_INCOMPATIBLE_DB);
						mobmap_disabled=true;
					else
						MobMap_DisplayMessage(MOBMAP_VERSION.." loaded");
					end
				end
			end


			if(not mobmap_disabled) then
				SLASH_MOBMAP1 = "/mobmap";
				SlashCmdList["MOBMAP"] = MobMap_Command;
			else
				MobMapButtonFrame:Hide();
			end

			if(mobmap_scanning==true and (GetLocale()~="zhCN" and GetLocale()~="enUS" and GetLocale()~="enGB")) then
				mobmap_scanning=false;
			end

			if(mobmap_scanning==true) then
				local k,v;
				local count=0;
				for k,v in pairs(mobmap_positions) do
					count=count+1;
				end
				if(count>2000) then
					MobMap_DisplayMessage(MOBMAP_DATA_SIZE_WARNING);
				end
				MobMapFrame:RegisterEvent("QUEST_LOG_UPDATE");
				MobMapFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
				MobMapFrame:RegisterEvent("MERCHANT_SHOW");
				MobMapFrame:RegisterEvent("MERCHANT_UPDATE");
				MobMapFrame:RegisterEvent("TRAINER_UPDATE");
				MobMapFrame:RegisterEvent("LOOT_OPENED");
				MobMapFrame:RegisterEvent("UNIT_SPELLCAST_SENT");
				MobMapFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
				MobMapFrame:RegisterEvent("UNIT_SPELLCAST_FAILED");
				MobMapFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
				MobMapFrame:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
				MobMapFrame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
				MobMap_HookGetTradeSkillInfo();
				MobMap_HookGetCraftInfo();
				MobMap_HookUseContainerItem();
				MobMap_HookGetQuestReward();
				MobMap_HookAcceptQuest();
			end
			if(mobmap_language~=nil and GetLocale()~=mobmap_language) then
				MobMap_DeletePositionData();
			end
			mobmap_language=GetLocale();
			mobmap_game_version=GetBuildInfo().."|"..GetCVar("realmList");
			if(not mobmap_disabled) then
				if(mobmap_alternate_button_position==true) then
					mobmap_button_position=2;
				end
				MobMap_PlaceMobMapButtonFrame();
			end
			MobMap_MinimapButton_UpdateVisibility();
			MobMapFrame:UnregisterEvent("ADDON_LOADED");
		end
	end
end

function MobMapDotFrame_OnClick()
	if(Cartographer_Waypoints and Cartographer:IsModuleActive(Cartographer_Waypoints)) then 
		Cartographer_Waypoints:SetPointAsWaypoint(this.xcoord/100, this.ycoord/100);
		Cartographer_Waypoints:UpdateWaypoint();

	end
end

function MobMap_SetMapToZone(zonename)
	local continentnames={GetMapContinents()};
	for k,v in pairs(continentnames) do
		local zonenames={GetMapZones(k)};
		for x,y in pairs(zonenames) do
			if(y==zonename) then
				SetMapZoom(k,x);
				return true;
			end
		end
	end
	return false;
end

function MobMap_GetCurrentMapZoneName()
	local zonenames={GetMapZones(GetCurrentMapContinent())};
	return zonenames[GetCurrentMapZone()];
end

mobmap_timer=0;
gatherer_astrolabe_library=nil;
gatherer_astrolabe_library_minimap_update_time=0.2;
gatherer_astrolabe_library_time_changed=false;

mobmap_astrolabe_library_minimap_update_time=0.2;
mobmap_astrolabe_library_time_changed=false;

function MobMapTimerFrame_OnUpdate()
	mobmap_timer=mobmap_timer-arg1;
	if(mobmap_timer<=0) then
		MobMapQuestWatchButtons_Update();
		MobMapQuestLogButtons_Update();
		MobMapReagentButtons_Update();
		-- The following hack is necessary to increase the update interval of the Astrolabe library used by Gatherer.
		-- Astrolabe switches the zone displayed on the world map to the current zone and back to the original again
		-- to determine the player position which causes MobMap to redraw after every change which makes WoW stutter.
		-- Astrolabe's Update Interval is being changed as long as the world map is open and is reset to the original
		-- value afterwards

		-- This hack is only being used for out-of-date Gatherer versions, the current version that's using Astrolabe 0.4
		-- does not need it because the problem was fixed at the source in Astrolabe 0.4
		-- That is why this code has been commented out as of MobMap v1.57 (WoW Patch 2.3.0)
		-- I will probably remove this code completely at some point in the future
		--if(Gatherer~=nil and Gatherer.AstrolabeVersion=="Astrolabe-0.3") then
		--	if(gatherer_astrolabe_library==nil) then gatherer_astrolabe_library=DongleStub(Gatherer.AstrolabeVersion); end
		--	if(gatherer_astrolabe_library_time_changed and not WorldMapFrame:IsShown()) then
		--		gatherer_astrolabe_library.MinimapUpdateTime=gatherer_astrolabe_library_minimap_update_time;
		--		gatherer_astrolabe_library_time_changed=false;
		--	elseif(not gatherer_astrolabe_library_time_changed and WorldMapFrame:IsShown()) then
		--		gatherer_astrolabe_library_minimap_update_time=gatherer_astrolabe_library.MinimapUpdateTime;
		--		gatherer_astrolabe_library.MinimapUpdateTime=5.0;
		--		gatherer_astrolabe_library_time_changed=true;
		--	end
		--end
		--if(Gatherer~=nil and Gatherer.AstrolabeVersion=="Astrolabe-0.2") then
		--	if(gatherer_astrolabe_library==nil) then gatherer_astrolabe_library=AceLibrary:GetInstance(Gatherer.AstrolabeVersion); end
		--	if(gatherer_astrolabe_library_time_changed and not WorldMapFrame:IsShown()) then
		--		gatherer_astrolabe_library.MinimapUpdateTime=gatherer_astrolabe_library_minimap_update_time;
		--		gatherer_astrolabe_library_time_changed=false;
		--	elseif(not gatherer_astrolabe_library_time_changed and WorldMapFrame:IsShown()) then
		--		gatherer_astrolabe_library_minimap_update_time=gatherer_astrolabe_library.MinimapUpdateTime;
		--		gatherer_astrolabe_library.MinimapUpdateTime=5.0;
		--		gatherer_astrolabe_library_time_changed=true;
		--	end
		--end

		-- update MobMap minimap icons
		if(mobmap_astrolabe_version and mobmap_minimap==true) then
			MobMap_UpdateMinimapIcons();
		end


		mobmap_timer=0.2;
	end
end

function MobMap_ShowPanel(panel)
	if(MobMapMobSearchFrame~=nil) then MobMapMobSearchFrame:Hide(); end
	if(MobMapQuestListFrame~=nil) then MobMapQuestListFrame:Hide(); end
	if(MobMapMerchantListFrame~=nil) then MobMapMerchantListFrame:Hide(); end
	if(MobMapRecipeListFrame~=nil) then MobMapRecipeListFrame:Hide(); end
	if(MobMapDropListFrame~=nil) then MobMapDropListFrame:Hide(); end
	if(MobMapPickupListFrame~=nil) then MobMapPickupListFrame:Hide(); end
	if(MobMapOptionsFrame~=nil) then MobMapOptionsFrame:Hide(); end
	if(MobMapAboutFrame~=nil) then MobMapAboutFrame:Hide(); end
	PanelTemplates_DeselectTab(MobMapSearchModeButton);
	PanelTemplates_DeselectTab(MobMapQuestModeButton);
	PanelTemplates_DeselectTab(MobMapMerchantModeButton);
	PanelTemplates_DeselectTab(MobMapRecipeModeButton);
	PanelTemplates_DeselectTab(MobMapDropModeButton);
	PanelTemplates_DeselectTab(MobMapPickupModeButton);
	PanelTemplates_DeselectTab(MobMapOptionsModeButton);
	PanelTemplates_DeselectTab(MobMapAboutModeButton);
	if(panel=="MobMapMobSearchFrame") then
		MobMap_LoadDatabase(MOBMAP_POSITION_DATABASE);
		PanelTemplates_SelectTab(MobMapSearchModeButton);
		MobMapMobSearchFrame:Show();
		MobMap_UpdateMobMapFrame();
	end

	if(panel=="MobMapQuestListFrame") then
		MobMap_LoadDatabase(MOBMAP_QUEST_DATABASE);
		MobMapQuestListFrame:Show();
		PanelTemplates_SelectTab(MobMapQuestModeButton);
		if(mobmap_questlist==nil) then
			MobMap_RefreshQuestList();
		end
	end

	if(panel=="MobMapMerchantListFrame") then
		MobMap_LoadDatabase(MOBMAP_MERCHANT_DATABASE);
		MobMapMerchantListFrame:Show();
		PanelTemplates_SelectTab(MobMapMerchantModeButton);
		if(mobmap_merchantlist==nil) then
			MobMap_RefreshMerchantList();
		end
	end

	if(panel=="MobMapRecipeListFrame") then
		MobMap_LoadDatabase(MOBMAP_RECIPE_DATABASE);
		MobMapRecipeListFrame:Show();
		PanelTemplates_SelectTab(MobMapRecipeModeButton);
		if(mobmap_recipelist==nil) then
			MobMap_RefreshRecipeList();
		end
	end

	if(panel=="MobMapDropListFrame") then
		MobMap_LoadDatabase(MOBMAP_DROP_DATABASE);
		MobMapDropListFrame:Show();
		PanelTemplates_SelectTab(MobMapDropModeButton);
	end

	if(panel=="MobMapPickupListFrame") then
		MobMap_LoadDatabase(MOBMAP_PICKUP_DATABASE);
		MobMapPickupListFrame:Show();
		PanelTemplates_SelectTab(MobMapPickupModeButton);
	end

	if(panel=="MobMapOptionsFrame") then
		PanelTemplates_SelectTab(MobMapOptionsModeButton);
		MobMapOptionsFrame:Show();
	end

	if(panel=="MobMapAboutFrame") then
		PanelTemplates_SelectTab(MobMapAboutModeButton);
		MobMapAboutFrame:Show();
	end
	MobMap_ResizeWindow();
end

function MobMapQuestWatchButtons_Update()
	if(mobmap_disabled) then return; end
	if(QuestWatchFrame:IsVisible()) then		
		local i;
		for i=1,30,1 do
			local frame=getglobal("QuestWatchLine"..i);
			local button=getglobal("MobMapQuestWatchButton"..i);
			if(frame:IsVisible() and mobmap_hide_questtracker_buttons==false) then
				local questobj=frame:GetText();
				if(questobj) then
					if(button==nil) then
						button=CreateFrame("Frame","MobMapQuestWatchButton"..i,QuestWatchFrame,"MobMapQuestButtonFrameTemplate");
						button:ClearAllPoints();
						button:SetPoint("RIGHT","QuestWatchLine"..i,"LEFT",0,0);
						button:SetAlpha(0.6);
					end
					if(string.sub(questobj,1,3)==" - ") then
						button.questobj=string.sub(questobj,4);
						button.questtitle=nil;
						button.unknowntext=nil;
						button:Show();
					else
						local title=questobj;
						if(title~=nil) then
							local filteredtitle=string.match(title,".*%] (.*)");
							if(filteredtitle~=nil) then
								title=filteredtitle;
							end
						end
						button.questtitle=title;
						button.questobj=nil;
						button.unknowntext=nil;
						button:Show();
					end
				end
			else
				if(button~=nil) then button:Hide(); end
			end
		end
	end
	if(EQL3_QuestWatchFrame~=nil and EQL3_QuestWatchFrame:IsVisible()) then
		local i;
		for i=1,30,1 do
			local frame=getglobal("EQL3_QuestWatchLine"..i);
			local button=getglobal("MobMapELQ3QuestWatchButton"..i);
			if(frame:IsVisible() and mobmap_hide_questtracker_buttons==false) then
				local questobj=frame:GetText();
				if(questobj) then
					if(button==nil) then
						button=CreateFrame("Frame","MobMapELQ3QuestWatchButton"..i,EQL3_QuestWatchFrame,"MobMapQuestButtonFrameTemplate");
						button:ClearAllPoints();
						button:SetPoint("RIGHT","EQL3_QuestWatchLine"..i,"LEFT",0,0);
						button:SetAlpha(0.6);
					end
					if(string.find(questobj, "^Quest Tracker.*")==nil) then
						local filteredtitle=string.match(questobj,".*%] (.*)");
						if(filteredtitle~=nil) then
							questobj=filteredtitle;
						end
						button.questobj=nil;
						button.questtitle=nil;
						button.unknowntext=questobj;
						button:Show();
					else
						button:Hide();
					end
				end
			else
				if(button~=nil) then button:Hide(); end
			end
		end
	end
end

function MobMapQuestWatchButtons_HideAll()
	local i;
	for i=1,30,1 do
		local frame=getglobal("MobMapQuestWatchButton"..i);
		if(frame~=nil) then frame:Hide(); end
	end
	for i=1,30,1 do
		local frame=getglobal("MobMapELQ3QuestWatchButton"..i);
		if(frame~=nil) then frame:Hide(); end
	end
end

function MobMapQuestLogButtons_Update()
	if(mobmap_disabled) then return; end
	if(QuestLogFrame:IsVisible()) then		
		local frame=getglobal("QuestLogQuestTitle");
		local button=getglobal("MobMapQuestLogTitleButton");
		if(button==nil) then
			button=CreateFrame("Frame","MobMapQuestLogTitleButton",QuestLogDetailScrollChildFrame,"MobMapQuestButtonFrameTemplate");
			button:ClearAllPoints();
			button:SetFrameStrata("MEDIUM");
			button:SetPoint("LEFT","QuestLogQuestTitle","RIGHT",-8,0);
			button:SetAlpha(0.6);
		end
		local title=frame:GetText();
		if(title~=nil) then
			local filteredtitle=string.match(title,".*%] (.*)");
			if(filteredtitle~=nil) then
				title=filteredtitle;
			end
		end
		button.questtitle=title;
		if(mobmap_hide_questlog_buttons==false) then
			button:Show();
		else
			button:Hide();
		end

		local i;
		for i=1,10,1 do
			frame=getglobal("QuestLogObjective"..i);
			button=getglobal("MobMapQuestLogButton"..i);
			if(frame:IsVisible() and mobmap_hide_questlog_buttons==false) then
				local questobj=frame:GetText();
				if(questobj) then
					if(button==nil) then
						button=CreateFrame("Frame","MobMapQuestLogButton"..i,QuestLogDetailScrollChildFrame,"MobMapQuestButtonFrameTemplate");
						button:ClearAllPoints();
						button:SetFrameStrata("MEDIUM");
						button:SetPoint("LEFT","QuestLogObjective"..i,"RIGHT",-16,0);
						button:SetAlpha(0.6);
					end
					button.questobj=questobj;
					button:Show();
				end
			else
				if(button~=nil) then button:Hide(); end
			end
		end
	end

	if(EQL3_QuestLogFrame~=nil and EQL3_QuestLogFrame:IsVisible()) then		
		local frame=getglobal("EQL3_QuestLogQuestTitle");
		local button=getglobal("MobMapELQ3QuestLogTitleButton");
		if(button==nil) then
			button=CreateFrame("Frame","MobMapELQ3QuestLogTitleButton",EQL3_QuestLogDetailScrollChildFrame,"MobMapQuestButtonFrameTemplate");
			button:ClearAllPoints();
			button:SetFrameStrata("MEDIUM");
			button:SetPoint("LEFT","EQL3_QuestLogQuestTitle","RIGHT",-8,0);
			button:SetAlpha(0.6);
		end
		local title=frame:GetText();
		if(title~=nil) then
			local filteredtitle=string.match(title,".*%] (.*)");
			if(filteredtitle~=nil) then
				title=filteredtitle;
			end
		end
		button.questtitle=title;
		if(mobmap_hide_questlog_buttons==false) then
			button:Show();
		else
			button:Hide();
		end

		local i;
		for i=1,10,1 do
			frame=getglobal("EQL3_QuestLogObjective"..i);
			button=getglobal("MobMapELQ3QuestLogButton"..i);
			if(frame:IsVisible() and mobmap_hide_questlog_buttons==false) then
				local questobj=frame:GetText();
				if(questobj) then
					if(button==nil) then
						button=CreateFrame("Frame","MobMapELQ3QuestLogButton"..i,EQL3_QuestLogDetailScrollChildFrame,"MobMapQuestButtonFrameTemplate");
						button:ClearAllPoints();
						button:SetFrameStrata("MEDIUM");
						button:SetPoint("LEFT","EQL3_QuestLogObjective"..i,"RIGHT",-16,0);
						button:SetAlpha(0.6);
					end
					button.questobj=questobj;
					button:Show();
				end
			else
				if(button~=nil) then button:Hide(); end
			end
		end
	end
	
	if(UberQuest_Details~=nil and UberQuest_Details:IsVisible()) then		
		local frame=getglobal("UberQuest_Details_ScrollChild_QuestTitle");
		local button=getglobal("MobMapUberQuestQuestLogTitleButton");
		if(button==nil) then
			button=CreateFrame("Frame","MobMapUberQuestQuestLogTitleButton",UberQuest_Details_ScrollChild,"MobMapQuestButtonFrameTemplate");
			button:ClearAllPoints();
			button:SetFrameStrata("MEDIUM");
			button:SetPoint("LEFT","UberQuest_Details_ScrollChild_QuestTitle","RIGHT",-8,0);
			button:SetAlpha(0.6);
		end
		local title=frame:GetText();
		if(title~=nil) then
			local filteredtitle=string.match(title,".*%] (.*)");
			if(filteredtitle~=nil) then
				title=filteredtitle;
			end
		end
		button.questtitle=title;
		button:Show();

		local i;
		for i=1,10,1 do
			frame=getglobal("UberQuest_Details_ScrollChild_Objective"..i);
			button=getglobal("MobMapUberQuestQuestLogButton"..i);
			if(frame:IsVisible() and mobmap_hide_questlog_buttons==false) then
				local questobj=frame:GetText();
				if(questobj) then
					if(button==nil) then
						button=CreateFrame("Frame","MobMapUberQuestQuestLogButton"..i,UberQuest_Details_ScrollChild,"MobMapQuestButtonFrameTemplate");
						button:ClearAllPoints();
						button:SetFrameStrata("MEDIUM");
						button:SetPoint("LEFT","UberQuest_Details_ScrollChild_Objective"..i,"RIGHT",-16,0);
						button:SetAlpha(0.6);
					end
					button.questobj=questobj;
					button:Show();
				end
			else
				if(button~=nil) then button:Hide(); end
			end
		end
	end
end

function MobMapQuestLogButtons_HideAll()
	local i;
	frame=getglobal("MobMapQuestLogTitleButton");
	if(frame~=nil) then frame:Hide(); end
	for i=1,10,1 do
		frame=getglobal("MobMapQuestLogButton"..i);
		if(frame~=nil) then frame:Hide(); end
	end
	frame=getglobal("MobMapELQ3QuestLogTitleButton");
	if(frame~=nil) then frame:Hide(); end
	for i=1,10,1 do
		frame=getglobal("MobMapELQ3QuestLogButton"..i);
		if(frame~=nil) then frame:Hide(); end
	end
end

function MobMapReagentButtons_Update()
	if(mobmap_disabled or TradeSkillFrame==nil) then return; end
	if(TradeSkillFrame:IsVisible()) then
		local i;
		local parentFrame;
		local reagentFrame;
		local iStart;
		if(ATSWFrame and ATSWFrame:IsVisible()) then
			parentFrame=ATSWFrame;
			reagentFrame="ATSWReagent";
			iStart=9;
		else
			parentFrame=TradeSkillFrame;
			reagentFrame="TradeSkillReagent";
			iStart=1;
		end
		for i=1,8,1 do
			local frame=getglobal(reagentFrame..i);
			local button=getglobal("MobMapReagentSearchButton"..(i+iStart));
			if(frame:IsVisible() and mobmap_hide_reagent_buttons==false) then
				local reagentName=getglobal(reagentFrame..i.."Name"):GetText();
				if(button==nil) then
					button=CreateFrame("Frame","MobMapReagentSearchButton"..(i+iStart),parentFrame,"MobMapQuestButtonFrameTemplate");
					button:ClearAllPoints();
					if(parentFrame==TradeSkillFrame) then button:SetFrameStrata("HIGH"); else button:SetFrameStrata("MEDIUM"); end
					button:SetPoint("BOTTOMRIGHT",reagentFrame..i,"BOTTOMRIGHT",-2,0);
					button:SetAlpha(1.0);
				end
				button.reagentname=reagentName;
				button:Show();
			else
				if(button~=nil) then button:Hide(); end
			end
		end
	end
end


-- position display
--fix by wolftankk
mobmap_currentlist = {};
mobmap_zonelist = {};
mobmap_currentlyshown = nil;
mobmap_multidisplay = nil;

mobmap_displayed_dot_count = 0;

function MobMap_DisplayPositionData(posdata, mobid, ihid)
	if(posdata==nil) then return; end
	local parentframe;
	if(Cartographer) then
		parentframe=MobMapDotParentFrame;
	else
		parentframe=WorldMapPositioningGuide;
	end
	for k,v in pairs(posdata) do
		for x=v.x1,v.x2,1 do
			local frame=getglobal("MobMapDot"..x.."_"..v.y);
			if(frame==nil) then 
				frame=CreateFrame("Button","MobMapDot"..x.."_"..v.y,parentframe,"MobMapDotFrameTemplate");
				frame:SetPoint("TOPLEFT",WorldMapPositioningGuide,"TOPLEFT",x*frame:GetWidth(),-67-v.y*frame:GetHeight());
				frame:SetFrameLevel(WorldMapPositioningGuide:GetFrameLevel()+21);
				frame:SetAlpha(mobmap_dot_transparency);
				frame.xcoord=x;
				frame.ycoord=v.y;
			end
			if(mobid~=nil) then
				if(frame.idtable==nil) then
					frame.idtable={};
				end
				table.insert(frame.idtable,mobid);
			end
			if(ihid~=nil) then
				if(frame.ihidtable==nil) then
					frame.ihidtable={};
				end
				table.insert(frame.ihidtable,ihid);
			end
			mobmap_displayed_dot_count=mobmap_displayed_dot_count+1;
			frame:Show();
		end
	end
end

function MobMap_HideAllDots()
	mobmap_displayed_dot_count=0;
	for x=1,99,1 do
		for y=1,99,1 do
			local frame=getglobal("MobMapDot"..x.."_"..y);
			if(frame~=nil) then 
				frame:Hide();
				frame.idtable=nil;
				frame.ihidtable=nil;
			end
			local mapiconframe=getglobal("MobMapMinimapDot"..x.."_"..y);
			if(mapiconframe~=nil) then
				mobmap_astrolabe_library:RemoveIconFromMinimap(mapiconframe);
			end
		end
	end
end

function MobMap_HideAllMinimapDots()
	for x=1,99,1 do
		for y=1,99,1 do
			local mapiconframe=getglobal("MobMapMinimapDot"..x.."_"..y);
			if(mapiconframe~=nil) then
				mobmap_astrolabe_library:RemoveIconFromMinimap(mapiconframe);
			end
		end
	end
end

function MobMap_DisplayDotTooltip()
	if(this.idtable~=nil) then
		WorldMapTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		WorldMapTooltip:AddDoubleLine("坐标:",this.xcoord..","..this.ycoord,1,1,1,1,1,1);
		local k,v;
		for k,v in pairs(this.idtable) do
			WorldMapTooltip:AddLine(MobMap_GetMobName(v));
		end		
		WorldMapTooltip:Show();
	end
	if(this.ihidtable~=nil) then
		WorldMapTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		WorldMapTooltip:AddDoubleLine("坐标:",this.xcoord..","..this.ycoord,1,1,1,1,1,1);
		local k,v;
		for k,v in pairs(this.ihidtable) do
			local itemname=MobMap_GetItemNameByIHID(v);
			local itemid, quality = MobMap_GetItemDataByIHID(v);
			WorldMapTooltip:AddLine(MobMap_ConstructColorizedItemName(quality, itemname));
		end		
		WorldMapTooltip:Show();
	end
end

function MobMap_HideDotTooltip()
	WorldMapTooltip:Hide();
end

function MobMap_UpdateMinimapIcons()
	if(mobmap_currentlyshown==nil) then return; end
	if(mobmap_astrolabe_library==nil) then
		mobmap_astrolabe_library=DongleStub(mobmap_astrolabe_version);
	end
	local continent,zone,playerx,playery=mobmap_astrolabe_library:GetCurrentPlayerPosition();
	if(playerx==nil or playery==nil) then return; end
	if(MobMap_GetCurrentMapZoneName()~=mobmap_currentlyshown.zonename) then return; end
	for k,v in pairs(mobmap_currentlyshown.posdata) do
		for x=v.x1,v.x2,1 do
			local mapiconframe=getglobal("MobMapMinimapDot"..x.."_"..v.y);
			if(mapiconframe==nil) then
				mapiconframe=CreateFrame("Frame","MobMapMinimapDot"..x.."_"..v.y,Minimap,"MobMapDotFrameTemplate");
				mapiconframe.isMinimapButton=true;
			end
			if(MobMap_GetDistance(playerx,playery,x/100,v.y/100)<0.04) then
				mobmap_astrolabe_library:PlaceIconOnMinimap(mapiconframe, continent, zone, x/100, v.y/100);
			else
				mobmap_astrolabe_library:RemoveIconFromMinimap(mapiconframe);
			end
		end
	end
end

function MobMap_GetDistance(x1,y1,x2,y2)
	return math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
end

function MobMap_UnsetMob()
	MobMapMobSearchFrameMobHighlightFrame:Hide();
	MobMapMobSearchFrameSelectionDetails:Hide();
	MobMap_UnsetZone();
end

function MobMap_UnsetZone()
	mobmap_currentlyshown=nil;
	MobMapZoneHighlightFrame:Hide();
end

function MobMap_UpdatePositions()
	if(mobmap_currentlyshown==nil) then 
		if(mobmap_multidisplay~=nil) then
			local i,k;
			local zonestats={};
			if(table.getn(mobmap_multidisplay)==1 and mobmap_multidisplay[1].itemtype~=nil) then
				for i=1,table.getn(mobmap_multidisplay[1].zones),1 do
					local positionData=MobMap_GetItemPositions(mobmap_multidisplay[1].itemtype, mobmap_multidisplay[1].ihid, mobmap_multidisplay[1].zones[i].zoneid);
					mobmap_multidisplay[1].zones[i].posdata=positionData;
				end
				if(not WorldMapFrame:IsVisible()) then WorldMapFrame:Show(); end
				MobMap_SetMapToZone(MobMap_GetZoneName(mobmap_multidisplay[1].zones[1].zoneid));
			else
				for i=1,table.getn(mobmap_multidisplay),1 do
					local zonetable=MobMap_GetMobZonesByMobID(mobmap_multidisplay[i].id);
					if(zonetable~=nil) then
						mobmap_multidisplay[i].zones={};
						for k=1,table.getn(zonetable),1 do
							local positionData=MobMap_GetMobPositions(mobmap_multidisplay[i].id, zonetable[k]);
							table.insert(mobmap_multidisplay[i].zones,{zoneid=zonetable[k], posdata=positionData});
							if(zonestats[zonetable[k]]==nil) then
								zonestats[zonetable[k]]=1;
							else
								zonestats[zonetable[k]]=zonestats[zonetable[k]]+1;
							end
						end
						local maxzone=0;
						local maxvalue=0;
						local key, value;
						for key, value in pairs(zonestats) do
							if(value>maxvalue) then maxzone=key; end
						end
						if(maxzone~=0) then
							if(not WorldMapFrame:IsVisible()) then WorldMapFrame:Show(); end
							MobMap_SetMapToZone(MobMap_GetZoneName(maxzone));
						end
					end
				end
			end
		end
		return;
	end
	local pos;
	if(mobmap_currentlyshown.itemtype~=nil) then
		pos=MobMap_GetItemPositions(mobmap_currentlyshown.itemtype, mobmap_currentlyshown.ihid, mobmap_currentlyshown.zoneid);
	else
		pos=MobMap_GetMobPositions(mobmap_currentlyshown.mobid, mobmap_currentlyshown.zoneid);
	end
	mobmap_currentlyshown.posdata=pos;
end

mobmap_astrolabe_version = "Astrolabe-0.4";
mobmap_astrolabe_library = nil;

function MobMap_Display()
	if(WorldMapFrame:IsVisible()==false) then return; end
	if(mobmap_currentlyshown==nil) then 
		if(mobmap_multidisplay==nil) then
			MobMapButtonFrameCurrentMob:SetText("");
			MobMapButtonFrameCurrentMobFrame.itemid=nil;
			MobMap_HideAllDots();
			return;
		else
			MobMap_SwitchMapAndDisplay();
			return;
		end
	end
	
	if(mobmap_currentlyshown.mobname~=nil) then 
		MobMapButtonFrameCurrentMob:SetText(mobmap_currentlyshown.mobname);
		MobMapButtonFrameCurrentMobFrame.itemid=nil;
	else
		MobMapButtonFrameCurrentMob:SetText(MobMap_ConstructColorizedItemName(mobmap_currentlyshown.itemquality, mobmap_currentlyshown.itemname));
		MobMapButtonFrameCurrentMobFrame.itemid=mobmap_currentlyshown.itemid;
		MobMapButtonFrameCurrentMobFrame.ihid=mobmap_currentlyshown.ihid;
	end

	if(MobMap_GetCurrentMapZoneName()~=mobmap_currentlyshown.zonename) then 
		MobMap_HideAllDots();
		return;
	end
	if(mobmap_enabled) then
		MobMap_SwitchMapAndDisplay();
	else
		MobMap_HideAllDots();
	end
end

function MobMap_SwitchMapAndDisplay()
	mobmap_displayed_dot_count=0;
	if(mobmap_currentlyshown==nil) then 
		if(mobmap_multidisplay==nil) then
			MobMapButtonFrameCurrentMob:SetText("");
			MobMapButtonFrameCurrentMobFrame.itemid=nil;
			MobMap_HideAllDots();
			return;
		else
			local showed=false;
			if(not WorldMapFrame:IsVisible()) then 
				ShowUIPanel(WorldMapFrame); 
				MobMapFrame:Hide();
				MobMapFrame:Show();
				showed=true;
			end
			local i,k;
			MobMap_HideAllDots();
			for i=1,table.getn(mobmap_multidisplay),1 do
				if(mobmap_multidisplay[i].zones~=nil) then
					for k=1,table.getn(mobmap_multidisplay[i].zones) do
						if(mobmap_multidisplay[i].zones[k].posdata~=nil and MobMap_GetZoneName(mobmap_multidisplay[i].zones[k].zoneid)==MobMap_GetCurrentMapZoneName()) then
							if(mobmap_multidisplay[i].itemtype==nil) then	
								MobMap_DisplayPositionData(mobmap_multidisplay[i].zones[k].posdata, mobmap_multidisplay[i].id);
							else
								MobMap_DisplayPositionData(mobmap_multidisplay[i].zones[k].posdata, nil, mobmap_multidisplay[i].ihid);
							end
						end
					end
				end
			end
			if(table.getn(mobmap_multidisplay)==1 and mobmap_multidisplay[1].itemtype~=nil) then
				MobMapButtonFrameCurrentMob:SetText(MobMap_ConstructColorizedItemName(mobmap_multidisplay[1].itemquality, mobmap_multidisplay[1].itemname));
				MobMapButtonFrameCurrentMobFrame.itemid=mobmap_multidisplay[1].itemid;
				MobMapButtonFrameCurrentMobFrame.ihid=mobmap_multidisplay[1].ihid;
			end
			return;
		end
	end
	local showed=false;
	if(not WorldMapFrame:IsVisible()) then 
		ShowUIPanel(WorldMapFrame); 
		MobMapFrame:Hide();
		MobMapFrame:Show();
		showed=true;
	end
	if(MobMap_SetMapToZone(mobmap_currentlyshown.zonename)==false) then 
		if(showed) then HideUIPanel(WorldMapFrame); end
		return; 
	end
	if(mobmap_currentlyshown.posdata==nil) then MobMap_UpdatePositions(); end
	MobMap_HideAllDots();
	if(mobmap_currentlyshown.mobname~=nil) then 
		MobMapButtonFrameCurrentMob:SetText(mobmap_currentlyshown.mobname);
		MobMapButtonFrameCurrentMobFrame.itemid=nil;
		MobMap_DisplayPositionData(mobmap_currentlyshown.posdata, mobmap_currentlyshown.mobid);
	else
		MobMapButtonFrameCurrentMob:SetText(MobMap_ConstructColorizedItemName(mobmap_currentlyshown.itemquality, mobmap_currentlyshown.itemname));
		MobMapButtonFrameCurrentMobFrame.itemid=mobmap_currentlyshown.itemid;
		MobMap_DisplayPositionData(mobmap_currentlyshown.posdata, nil, mobmap_currentlyshown.ihid);
	end
end

-- item name selection frame

function MobMap_ShowItemNameSelectionFrame(startihid)
	MobMap_LoadDatabase(MOBMAP_ITEMNAME_HELPER_DATABASE);
	if(startihid~=nil) then
		mobmap_itemnameselection_selecteditem=startihid;
	else
		mobmap_itemnameselection_selecteditem=nil;
	end
	MobMap_RefreshItemNameSelectionFrame();
	MobMapItemNameSelectionFrame:Show();
end

mobmap_itemnameselectionlist=nil;

function MobMap_RefreshItemNameSelectionFrame()
	local filtername=MobMapItemNameSelectionFrameNameFilter:GetText();
	mobmap_itemnameselectionlist=MobMap_GetItemNameList(filtername);
	FauxScrollFrame_SetOffset(MobMapItemNameSelectionFrameScrollFrame, 0);
	MobMap_UpdateItemNameSelectionFrame();
end

function MobMap_UpdateItemNameSelectionFrame()
	local itemnamecount=table.getn(mobmap_itemnameselectionlist);
	local offset=FauxScrollFrame_GetOffset(MobMapItemNameSelectionFrameScrollFrame);
	MobMapItemNameSelectionFrameItemHighlightFrame:Hide();

	for i=1,9,1 do
		local itemindex=i+offset;
		if(itemindex>itemnamecount) then
			MobMap_UpdateItemNameEntry(i, nil);
		else
			MobMap_UpdateItemNameEntry(i, mobmap_itemnameselectionlist[itemindex]);
		end
	end

	FauxScrollFrame_Update(MobMapItemNameSelectionFrameScrollFrame, itemnamecount, 9, 22);
end

function MobMap_UpdateItemNameEntry(pos, ihid)
	local frame=getglobal("MobMapItemSelection"..pos);
	local frame_button=getglobal("MobMapItemSelection"..pos.."ItemName");
	local frame_text=getglobal("MobMapItemSelection"..pos.."ItemNameText");
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
			if(ihid==mobmap_itemnameselection_selecteditem) then
				MobMapItemNameSelectionFrameItemHighlightFrame:Show();
				MobMapItemNameSelectionFrameItemHighlightFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 2);
				MobMapItemNameSelectionFrameItemHighlightFrame:SetAlpha(0.5);
				MobMapItemHighlight:SetVertexColor(1.0, 1.0, 1.0);
			end
		end
	end
end

mobmap_itemnameselection_selecteditem=nil;
mobmap_itemnameselection_selectionfunc=nil;

function MobMap_SelectItem()
	MobMapItemNameSelectionFrameItemHighlightFrame:Show();
	MobMapItemNameSelectionFrameItemHighlightFrame:SetPoint("TOPLEFT", this, "TOPLEFT", 0, 2);
	MobMapItemNameSelectionFrameItemHighlightFrame:SetAlpha(0.5);
	MobMapItemHighlight:SetVertexColor(1.0, 1.0, 1.0);
	mobmap_itemnameselection_selecteditem=this:GetParent().ihid;
end

function MobMap_CallSelectionFunc()
	if(mobmap_itemnameselection_selectionfunc~=nil and mobmap_itemnameselection_selecteditem~=nil) then
		mobmap_itemnameselection_selectionfunc(mobmap_itemnameselection_selecteditem);
	end
end

function MobMap_SetSelectionFunc(selectionfunc)
	mobmap_itemnameselection_selectionfunc=selectionfunc;
end

-- about frame

function MobMap_AboutFrame_OnShow()
	local buildtimestring;
	if(GetLocale()=="zhCN") then
		buildtimestring=date("于%y年%m月%d日 %H:%M(%p) (北京时间)", MobMap_GetDBBuildTime());
	else
		buildtimestring=date("%m/%d/%y at %I:%M %p", MobMap_GetDBBuildTime());
	end
	MobMapAboutFrameDBInfoBuildTime:SetText(MOBMAP_DATABASE_INFO_1..buildtimestring);
	local language;
	if(MobMap_GetDBLanguage()=="sch") then language=MOBMAP_DATABASE_LANGUAGE_CHINESES; end
	if(MobMap_GetDBLanguage()=="ger") then language=MOBMAP_DATABASE_LANGUAGE_GERMAN; end
	if(MobMap_GetDBLanguage()=="eng") then language=MOBMAP_DATABASE_LANGUAGE_ENGLISH; end
	MobMapAboutFrameDBInfoLanguage:SetText(MOBMAP_DATABASE_INFO_2..language);
	local mobcountstring=MobMap_GetMobCount();
	MobMapAboutFrameDBInfoMobCount:SetText(MOBMAP_DATABASE_INFO_3..mobcountstring);
	local questcountstring;
	if(MobMap_GetQuestCount()==-1) then
		questcountstring=MOBMAP_DATABASE_INFO_NOT_INSTALLED;
	else
		questcountstring=MobMap_GetQuestCount();
	end
	MobMapAboutFrameDBInfoQuestCount:SetText(MOBMAP_DATABASE_INFO_4..questcountstring);
	local merchantcountstring;
	if(MobMap_GetMerchantCount()==-1) then
		merchantcountstring=MOBMAP_DATABASE_INFO_NOT_INSTALLED;
	else
		merchantcountstring=MobMap_GetMerchantCount();
	end
	MobMapAboutFrameDBInfoMerchantCount:SetText(MOBMAP_DATABASE_INFO_5..merchantcountstring);
	local recipecountstring;
	if(MobMap_GetRecipeCount()==-1) then
		recipecountstring=MOBMAP_DATABASE_INFO_NOT_INSTALLED;
	else
		recipecountstring=MobMap_GetRecipeCount();
	end
	MobMapAboutFrameDBInfoRecipeCount:SetText(MOBMAP_DATABASE_INFO_6..recipecountstring);
	
	if(UpdateAddOnMemoryUsage==nil) then 
		MobMapAboutFrameMemInfo:Hide();
	else
		MobMapAboutFrameMemInfoText:SetText(MOBMAP_MEMORY_INFO_HEADER.." "..MOBMAP_MEMORY_INFO_UNKNOWN.."\n"..MOBMAP_MEMORY_INFO_UNKNOWN_SECONDLINE);
		MobMapAboutFrameMemInfo.main=nil;
		MobMapAboutFrameMemInfo.dbinfo=nil;
	end
end

function MobMap_UpdateMemoryUsage()
	collectgarbage();
	UpdateAddOnMemoryUsage();
	local main=GetAddOnMemoryUsage("MobMap");
	local DBs={};
	local i;
	local total=main;
	for i=1,13,1 do
		if(IsAddOnLoaded("MobMapDatabaseStub"..i)) then
			local usage=GetAddOnMemoryUsage("MobMapDatabaseStub"..i);
			DBs[i]=usage;
			total=total+usage;
		end
	end
	MobMapAboutFrameMemInfoText:SetText(MOBMAP_MEMORY_INFO_HEADER.." "..(floor(total*100)/100).." KB\n"..MOBMAP_MEMORY_INFO_SECONDLINE);
	MobMapAboutFrameMemInfo.dbinfo=DBs;
	MobMapAboutFrameMemInfo.main=main;
	MobMapAboutFrameMemInfo:Show();
end

function MobMap_ShowMemoryUsageDetailTooltip()
	if(MobMapAboutFrameMemInfo.main==nil) then return; end
	MobMapTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
	MobMapTooltip:SetFrameLevel(5000);
	MobMapTooltip:ClearLines();
	MobMapTooltip:AddLine("|cffffffff"..MOBMAP_MEMORY_INFO_DETAILS_HEADER.."|r");
	MobMapTooltip:AddLine("|cff00ff00"..MOBMAP_MEMORY_INFO_MAIN_ADDON..": "..(floor(MobMapAboutFrameMemInfo.main*100)/100).." KB".."|r");
	local i;
	for i=1,13,1 do
		if(MobMapAboutFrameMemInfo.dbinfo[i]) then
			MobMapTooltip:AddLine("|cff00ff00"..MOBMAP_MEMORY_INFO_DATABASES[i]..": "..(floor(MobMapAboutFrameMemInfo.dbinfo[i]*100)/100).." KB".."|r");
		else
			MobMapTooltip:AddLine("|cffff0000"..MOBMAP_MEMORY_INFO_DATABASES[i]..": 没用加载".."|r");
		end
	end
	MobMapTooltip:Show();
end

-- export frame

function MobMap_ExportData()
	local continueExport=true;
	local complete_datastring="<MobMapData language=\""..GetLocale().."\" version=\"42\" gameversion=\""..mobmap_game_version.."\">";
	local mobmap_export_datastring="";
	local targetname, zones, zone, positions, position, value;
	for targetname,zones in pairs(mobmap_positions) do
		if(zones["min"]~=nil and zones["max"]~=nil) then
			local datastring_to_add="";
			datastring_to_add=datastring_to_add.."<Mob name=\""..MobMap_XMLArgumentEscape(targetname).."\" min=\""..zones["min"].."\" max=\""..zones["max"].."\"";	
			datastring_to_add=datastring_to_add..">";
			for zone,positions in pairs(zones) do
				if(zone~="min" and zone~="max" and zone~="sub") then
					datastring_to_add=datastring_to_add.."<Zone name=\""..MobMap_XMLArgumentEscape(zone).."\">";
					for position,value in pairs(positions) do
						datastring_to_add=datastring_to_add..position..",";
					end
					datastring_to_add=datastring_to_add.."</Zone>";
				end
			end
			datastring_to_add=datastring_to_add.."</Mob>";

			if(string.len(complete_datastring)+string.len(mobmap_export_datastring)+string.len(datastring_to_add) > MOBMAP_EXPORT_MAXSIZE) then
				continueExport=false;
				break;
			else
				continueExport=true;
				mobmap_export_datastring=mobmap_export_datastring..datastring_to_add;
			end
		end
	end

	complete_datastring=complete_datastring..mobmap_export_datastring;
	mobmap_export_datastring="";

	if(continueExport) then
		local merchant, merchantdata;
		for merchant, merchantdata in pairs(mobmap_merchantstock) do
			local datastring_to_add="";
			datastring_to_add=datastring_to_add.."<Merchant name=\""..MobMap_XMLArgumentEscape(merchant).."\">";
			local item, itemdata;
			for item=1, 100, 1 do
				local itemdata=merchantdata[tostring(item)];
				if(itemdata) then
					datastring_to_add=datastring_to_add.."<MItem id=\""..itemdata["id"].."\" qty=\""..itemdata["quantity"].."\" ltd=\""..itemdata["limited"].."\" cost=\""..itemdata["price"];
					if(itemdata["arenaprice"]) then
						datastring_to_add=datastring_to_add.."\" arena=\""..itemdata["arenaprice"];
					end
					if(itemdata["honorprice"]) then
						datastring_to_add=datastring_to_add.."\" honor=\""..itemdata["honorprice"];
					end
					local token;
					for token=1,5,1 do
						if(itemdata["token"..token]) then
							datastring_to_add=datastring_to_add.."\" token"..token.."=\""..MobMap_XMLArgumentEscape(itemdata["token"..token]);
						end
					end
					datastring_to_add=datastring_to_add.."\"/>";
				end
			end
			datastring_to_add=datastring_to_add.."</Merchant>";

			if(string.len(complete_datastring)+string.len(mobmap_export_datastring)+string.len(datastring_to_add) > MOBMAP_EXPORT_MAXSIZE) then
				continueExport=false;
				break;
			else
				continueExport=true;
				mobmap_export_datastring=mobmap_export_datastring..datastring_to_add;
			end
		end

		complete_datastring=complete_datastring..mobmap_export_datastring;
		mobmap_export_datastring="";
	end

	if(continueExport) then
		local skillName, skillData;
		for skillName, skillData in pairs(mobmap_tradeskills) do
			local datastring_to_add="";
			datastring_to_add=datastring_to_add.."<Recipe name=\""..MobMap_XMLArgumentEscape(skillName).."\" skill=\""..MobMap_XMLArgumentEscape(skillData["category"]).."\" level=\""..skillData["level"].."\"";
			if(skillData["itemid"]~=nil) then datastring_to_add=datastring_to_add.." itemid=\""..skillData["itemid"].."\""; end
			if(skillData["enchantid"]~=nil) then datastring_to_add=datastring_to_add.." enchid=\""..skillData["enchantid"].."\""; end
			if(skillData["minmade"]~=nil) then datastring_to_add=datastring_to_add.." mincnt=\""..skillData["minmade"].."\""; end
			if(skillData["maxmade"]~=nil) then datastring_to_add=datastring_to_add.." maxcnt=\""..skillData["maxmade"].."\""; end
			datastring_to_add=datastring_to_add..">";
			local reagent;
			for reagent=1,10,1 do
				if(skillData["reagent"..reagent]~=nil) then
					datastring_to_add=datastring_to_add.."<Reagent id=\""..skillData["reagent"..reagent].itemid.."\" count=\""..skillData["reagent"..reagent].count.."\"/>";
				end
			end
			datastring_to_add=datastring_to_add.."</Recipe>";

			if(string.len(complete_datastring)+string.len(mobmap_export_datastring)+string.len(datastring_to_add) > MOBMAP_EXPORT_MAXSIZE) then
				continueExport=false;
				break;
			else
				continueExport=true;
				mobmap_export_datastring=mobmap_export_datastring..datastring_to_add;
			end
		end

		complete_datastring=complete_datastring..mobmap_export_datastring;
		mobmap_export_datastring="";
	end

	if(continueExport) then
		local lootName, lootData;
		for lootName, lootData in pairs(mobmap_loot) do
			local datastring_to_add="<Loot name=\""..MobMap_XMLArgumentEscape(lootName).."\">"..lootData.."</Loot>";

			if(string.len(complete_datastring)+string.len(mobmap_export_datastring)+string.len(datastring_to_add) > MOBMAP_EXPORT_MAXSIZE) then
				continueExport=false;
				break;
			else
				continueExport=true;
				mobmap_export_datastring=mobmap_export_datastring..datastring_to_add;
			end
		end

		complete_datastring=complete_datastring..mobmap_export_datastring;
		mobmap_export_datastring="";
	end

	if(continueExport) then
		local trainerName, trainerTable;
		for trainerName, trainerTable in pairs(mobmap_trainer) do
			local datastring_to_add="<Trainer name=\""..MobMap_XMLArgumentEscape(trainerName).."\">";
			local skillName, skillTable;
			for skillName, skillTable in pairs(trainerTable) do
				datastring_to_add=datastring_to_add.."<Skill name=\""..MobMap_XMLArgumentEscape(skillName);
				local paramName, paramValue;
				for paramName, paramValue in pairs(skillTable) do
					if(paramName=="level") then
						datastring_to_add=datastring_to_add.."\" level=\""..paramValue;
					elseif(paramName=="cost") then
						datastring_to_add=datastring_to_add.."\" cost=\""..paramValue;
					elseif(paramName=="skillName") then
						datastring_to_add=datastring_to_add.."\" skillname=\""..MobMap_XMLArgumentEscape(paramValue);
					elseif(paramName=="skillRank") then
						datastring_to_add=datastring_to_add.."\" skillrank=\""..paramValue;
					end
				end
				datastring_to_add=datastring_to_add.."\" />";
			end
			datastring_to_add=datastring_to_add.."</Trainer>";

			if(string.len(complete_datastring)+string.len(mobmap_export_datastring)+string.len(datastring_to_add) > MOBMAP_EXPORT_MAXSIZE) then
				continueExport=false;
				break;
			else
				continueExport=true;
				mobmap_export_datastring=mobmap_export_datastring..datastring_to_add;
			end
		end
	end

	mobmap_export_datastring=mobmap_export_datastring.."</MobMapData>";
	complete_datastring=complete_datastring..mobmap_export_datastring;
	mobmap_export_datastring=MobMap_Base64(complete_datastring);
	MobMapExportFrameData.data=mobmap_export_datastring;
	MobMapExportFrameData:SetText(mobmap_export_datastring);
	MobMapExportFrame:Show();
end

function MobMap_DeletePositionData()
	mobmap_positions={};
	mobmap_quests={};
	mobmap_merchantstock={};
	mobmap_tradeskills={};
	mobmap_loot={};
	mobmap_trainer={};
	mobmap_objects={};
end

function MobMapExportDelayFrame_OnUpdate()
	if(mobmap_export_status==3) then MobMap_ExportData(); end
end

-- error frame

function MobMap_ErrorMessage(msg)
	MobMapErrorMessageFrameText:SetText(msg);
	MobMapErrorMessageFrame:Show();
end

-- options frame

function MobMap_OptionsFrame_OnShow()
	MobMapOptionsFrameDotOpacitySlider:SetValue(mobmap_dot_transparency*100);
	MobMapOptionsFrameWindowHeightSlider:SetValue(mobmap_window_height);
	MobMapOptionsFrameAlternateButtonPosCheckButton:SetChecked(mobmap_button_position==2);
	MobMapOptionsFrameAlternateButtonPos2CheckButton:SetChecked(mobmap_button_position==3);
	MobMapOptionsFrameHideWorldmapButtonCheckButton:SetChecked(mobmap_button_position==0);
	MobMapOptionsFrameDatabaseLoadingInfoCheckButton:SetChecked(mobmap_display_database_loading_info);
	MobMapOptionsFrameWorldMapTooltipCheckButton:SetChecked(mobmap_show_world_map_tooltips);
	MobMapOptionsFrameRequestItemDetailsCheckButton:SetChecked(mobmap_request_item_details);
	MobMapOptionsFrameOptimizeResponseTimesCheckButton:SetChecked(mobmap_optimize_response_times);
	MobMapOptionsFrameShowMinimapButtonCheckButton:SetChecked(mobmap_minimap_button_visible);
	MobMapOptionsFrameHideQuestLogButtonsCheckButton:SetChecked(mobmap_hide_questlog_buttons);
	MobMapOptionsFrameHideQuestTrackerButtonsCheckButton:SetChecked(mobmap_hide_questtracker_buttons);
	MobMapOptionsFrameHideReagentButtonsCheckButton:SetChecked(mobmap_hide_reagent_buttons);
end

function MobMap_ResizeWindow()
	MobMapFrame:SetHeight(mobmap_window_height);
	MobMapBackgroundFrame:SetHeight(mobmap_window_height-96);
	if(MobMapOptionsFrame and MobMapOptionsFrame:IsVisible()) then
		MobMapOptionsFrame:SetHeight(mobmap_window_height-30);
	end
	if(MobMapMobSearchFrame and MobMapMobSearchFrame:IsVisible()) then
		MobMapMobSearchFrame:SetHeight(mobmap_window_height-30);
		MobMapMobSearchFrameZoneListScrollFrame:SetHeight(mobmap_window_height-190);
		MobMapMobSearchFrameZoneListScrollFrameInnerTexture:SetHeight(mobmap_window_height-200);
		MobMapMobSearchFrameMobListScrollFrame:SetHeight(mobmap_window_height-190);
		MobMapMobSearchFrameMobListScrollFrameInnerTexture:SetHeight(mobmap_window_height-200);
	end
	if(MobMapQuestListFrame and MobMapQuestListFrame:IsVisible()) then
		MobMapQuestListFrame:SetHeight(mobmap_window_height-30);
		MobMapQuestListScrollFrame:SetHeight(mobmap_window_height-200);
		MobMapQuestListScrollFrameInnerTexture:SetHeight(mobmap_window_height-220);
	end
	if(MobMapMerchantListFrame and MobMapMerchantListFrame:IsVisible()) then
		MobMapMerchantListFrame:SetHeight(mobmap_window_height-30);
		MobMapMerchantListScrollFrame:SetHeight(mobmap_window_height-200);
		MobMapMerchantListScrollFrameInnerTexture:SetHeight(mobmap_window_height-220);
		MobMapMerchantListMerchantDetailFrame:SetHeight(mobmap_window_height-110);
	end
	if(MobMapRecipeListFrame and MobMapRecipeListFrame:IsVisible()) then
		MobMapRecipeListFrame:SetHeight(mobmap_window_height-30);
		MobMapRecipeListScrollFrame:SetHeight(mobmap_window_height-150);
		MobMapRecipeListScrollFrameInnerTexture:SetHeight(mobmap_window_height-170);
	end
	if(MobMapDropListFrame and MobMapDropListFrame:IsVisible()) then
		MobMapDropListFrame:SetHeight(mobmap_window_height-30);
		MobMapDropListByItem:SetHeight(mobmap_window_height-30);
		MobMapDropListByBosses:SetHeight(mobmap_window_height-30);
		MobMapDropListItemScrollFrame:SetHeight(mobmap_window_height-156);
		MobMapDropListItemScrollFrameInnerTexture:SetHeight(mobmap_window_height-170);
		MobMapDropListMobScrollFrame:SetHeight(mobmap_window_height-130);
		MobMapDropListMobScrollFrameInnerTexture:SetHeight(mobmap_window_height-150);
		MobMapDropListBossScrollFrame:SetHeight(mobmap_window_height-130);
		MobMapDropListBossScrollFrameInnerTexture:SetHeight(mobmap_window_height-150);
		MobMapDropListBossLootTableScrollFrame:SetHeight(mobmap_window_height-180);
		MobMapDropListBossLootTableScrollFrameInnerTexture:SetHeight(mobmap_window_height-200);
	end
	if(MobMapPickupListFrame and MobMapPickupListFrame:IsVisible()) then
		MobMapPickupListFrame:SetHeight(mobmap_window_height-30);
		MobMapPickupItemListScrollFrame:SetHeight(mobmap_window_height-150);
		MobMapPickupItemListScrollFrameInnerTexture:SetHeight(mobmap_window_height-170);
		MobMapPickupZoneListScrollFrame:SetHeight(mobmap_window_height-150);
		MobMapPickupZoneListScrollFrameInnerTexture:SetHeight(mobmap_window_height-170);
	end
end

-- general utilities

function MobMap_Command(cmd)
	local parts={};
	local partcount=0;
	for w in string.gmatch(cmd, "%S+") do
    		parts[partcount]=w;
	    	partcount=partcount+1;
	end
	if(partcount==0) then
		MobMap_DisplayMessage(MOBMAP_COMMANDS1);
		MobMap_DisplayMessage(MOBMAP_COMMANDS2);
		MobMap_DisplayMessage(MOBMAP_COMMANDS3);
    		return;
	end
	if(partcount==1) then
		if(parts[0]=="show") then
			MobMap_ShowMobMapFrame();
		end
		if(parts[0]=="clear") then
			MobMap_DeletePositionData();
			MobMap_DisplayMessage(MOBMAP_CLEARED);
		end
	end
end

function MobMap_Base64(str)
	local encodedString="";
	local partcount;
	for partcount=0,ceil(string.len(str)/300)-1,1 do
		local substringlength=string.len(str)-(partcount*300);
		if(substringlength>300) then substringlength=300; end
		local substring=string.sub(str,partcount*300+1,partcount*300+substringlength);
		local encodedSubstring=base64_encode(substring);
		encodedString=encodedString..encodedSubstring;
	end
	return encodedString;
end

function MobMap_GetPlayerCoordinates()
	if(not WorldMapFrame:IsVisible()) then
		SetMapToCurrentZone();
		local x, y = GetPlayerMapPosition("player");
		local zonename = GetRealZoneText();
		if(x>0 and y>0) then
			x=math.floor(x*100+0.5);
			y=math.floor(y*100+0.5);
		else
			x=-1;
			y=-1;
		end
		return x,y,zonename;
	end
	return nil;
end

function MobMap_GetMoneyFromMoneyString(str)
	local gold, silver, copper;
	gold=string.match(str,"(%d+) "..GOLD);
	if(gold==nil) then gold=0; end
	silver=string.match(str,"(%d+) "..SILVER);
	if(silver==nil) then silver=0; end
	copper=string.match(str,"(%d+) "..COPPER);
	if(copper==nil) then copper=0; end	
	return gold*10000+silver*100+copper;
end

function MobMap_GetDataFromChatMessage(template, msg)
	template=string.gsub(template,"%%s","(.+)");
	template=string.gsub(template,"%%d","(%%d+)");
	local _,_,capture1,capture2=string.find(msg, template);
	return capture1,capture2;
end

function MobMap_FilterQuestTitle(title)--add
	local filteredtitle=string.match(title,".*%] (.*)");
	if(filteredtitle~=nil) then
		return filteredtitle;
	else
		return title;
	end
end

function MobMap_GetItemIDFromItemLink(link)
	local found, _, itemString = string.find(link, "^|%x+|H(.+)|h%[.+%]")
	local found2, _, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = string.find(itemString, "^item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)")
	return itemId, suffixId, uniqueId;
end

function MobMap_GetItemIDFromItemString(str)
	local found, _, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = string.find(str, "^item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)")
	return itemId;
end

function MobMap_GetEnchantIDFromEnchantLink(link)
	local found, _, itemString = string.find(link, "^|%x+|H(.+)|h%[.+%]")
	local found2, _, enchantId = string.find(itemString, "^enchant:(%d+)")
	return enchantId;
end

function MobMap_ConstructEnchantLink(enchantid, enchantname)
	local enchantLink="|cffffd000|Henchant:"..enchantid.."|h["..enchantname.."]|h|r";
	return enchantLink;
end

function MobMap_ConstructItemString(itemid)
	local itemString="item:"..itemid..":0:0:0:0:0:0:0";
	return itemString;
end

function MobMap_DisplayMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function MobMap_XMLArgumentEscape(str)
	str=string.gsub(str, "&", "&amp;");
	str=string.gsub(str, "\"", "&quot;");
	str=string.gsub(str, "'", "&apos;");
	str=string.gsub(str, "<", "&lt;");
	str=string.gsub(str, ">", "&gt;");
	str=string.gsub(str, "ü", "|uuml|");
	str=string.gsub(str, "ä", "|auml|");
	str=string.gsub(str, "ö", "|ouml|");
	str=string.gsub(str, "Ü", "|Uuml|");
	str=string.gsub(str, "Ä", "|Auml|");
	str=string.gsub(str, "Ö", "|Ouml|");
	str=string.gsub(str, "ß", "|szlig|");
	str=string.gsub(str, "\n", "$B");
	str=string.gsub(str, "\r", "");
	return str;
end

function MobMap_QuestTextEscape(str)
	str=string.gsub(str, "\r\n", "\n");
	str=string.gsub(str, "\n", "\\n");
	return str;
end

function MobMap_PatternEscape(str)
	if(str==nil) then return nil; end
	str=string.gsub(str,"%^","%%%^");
	str=string.gsub(str,"%(","%%%(");
	str=string.gsub(str,"%)","%%%)");
	str=string.gsub(str,"%%","%%%%");
	str=string.gsub(str,"%.","%%%.");
	str=string.gsub(str,"%[","%%%[");
	str=string.gsub(str,"%]","%%%]");
	str=string.gsub(str,"%*","%%%*");
	str=string.gsub(str,"%+","%%%+");
	str=string.gsub(str,"%-","%%%-");
	str=string.gsub(str,"%?","%%%?");
	return str;	
end

function MobMap_LoadDatabase(dbtype, doLoadDependencies, doGC)
	if(doLoadDependencies==nil or doLoadDependencies==true) then
		if(dbtype==MOBMAP_POSITION_DATABASE) then
			if(MobMap_LoadDatabase(MOBMAP_MOBNAME_DATABASE, true, false)==false) then return false; end
		elseif(dbtype==MOBMAP_QUEST_DATABASE) then
			if(MobMap_LoadDatabase(MOBMAP_MOBNAME_DATABASE, true, false)==false) then return false; end
			if(MobMap_LoadDatabase(MOBMAP_ITEMNAME_HELPER_DATABASE, true, false)==false) then return false; end
		elseif(dbtype==MOBMAP_MERCHANT_DATABASE) then
			if(MobMap_LoadDatabase(MOBMAP_MOBNAME_DATABASE, true, false)==false) then return false; end
			if(MobMap_LoadDatabase(MOBMAP_ITEMNAME_HELPER_DATABASE, true, false)==false) then return false; end
		elseif(dbtype==MOBMAP_RECIPE_DATABASE) then
			if(MobMap_LoadDatabase(MOBMAP_ITEMNAME_HELPER_DATABASE, true, false)==false) then return false; end
		elseif(dbtype==MOBMAP_DROP_DATABASE) then
			if(MobMap_LoadDatabase(MOBMAP_MOBNAME_DATABASE, true, false)==false) then return false; end
			if(MobMap_LoadDatabase(MOBMAP_ITEMNAME_HELPER_DATABASE, true, false)==false) then return false; end
		elseif(dbtype==MOBMAP_PICKUP_DATABASE) then
			if(MobMap_LoadDatabase(MOBMAP_MOBNAME_DATABASE, true, false)==false) then return false; end
			if(MobMap_LoadDatabase(MOBMAP_ITEMNAME_HELPER_DATABASE, true, false)==false) then return false; end
		elseif(dbtype==MOBMAP_ITEMNAME_HELPER_DATABASE) then
			if(MobMap_LoadDatabase(MOBMAP_ITEM_TOOLTIP_DATABASE, true, false)==false) then return false; end
		end
	end
	if(IsAddOnLoaded("MobMapDatabaseStub"..dbtype)==nil) then
		local startTime=GetTime();
		local loaded,reason=LoadAddOn("MobMapDatabaseStub"..dbtype);
		local whatWasLoaded="position";
		local whatExactly="";
		if(dbtype==MOBMAP_QUEST_DATABASE) then whatWasLoaded="quest"; end
		if(dbtype==MOBMAP_MERCHANT_DATABASE) then whatWasLoaded="merchant"; end
		if(dbtype==MOBMAP_RECIPE_DATABASE) then whatWasLoaded="recipe"; end
		if(dbtype==MOBMAP_ITEMNAME_HELPER_DATABASE) then whatWasLoaded="item name helper"; end
		if(dbtype==MOBMAP_MOBNAME_DATABASE) then whatWasLoaded="mob name"; end
		if(dbtype==MOBMAP_DROP_DATABASE) then whatWasLoaded="drop chance"; end
		if(dbtype==MOBMAP_PICKUP_DATABASE) then whatWasLoaded="pickup"; whatExactly="access components "; end
		if(dbtype==MOBMAP_PICKUP_QUEST_ITEM_DATABASE) then whatWasLoaded="pickup"; whatExactly="(quest items) "; end
		if(dbtype==MOBMAP_PICKUP_FISHING_DATABASE) then whatWasLoaded="pickup"; whatExactly="(fishing) "; end
		if(dbtype==MOBMAP_PICKUP_MINING_DATABASE) then whatWasLoaded="pickup"; whatExactly="(mining) "; end
		if(dbtype==MOBMAP_PICKUP_HERBS_DATABASE) then whatWasLoaded="pickup"; whatExactly="(herbs) "; end
		if(dbtype==MOBMAP_ITEM_TOOLTIP_DATABASE) then whatWasLoaded="item tooltip"; end		
		if(not loaded) then
			MobMap_DisplayMessage("MobMap"..whatWasLoaded.."数据"..whatExactly.."不能动态加载！你可以卸载重新安装MobMap修复此问题。");
			return false;
		else
			local loadTime=floor((GetTime()-startTime)*1000)/1000;
			startTime=GetTime();
			if(doGC==nil or doGC==true or mobmap_display_database_loading_info==true) then collectgarbage(); end
			local gcTime=floor((GetTime()-startTime)*1000)/1000;
			UpdateAddOnMemoryUsage();
			local usedRAM=math.floor(GetAddOnMemoryUsage("MobMapDatabaseStub"..dbtype)+0.5);
			if(mobmap_display_database_loading_info==true) then
				MobMap_DisplayMessage("MobMap"..whatWasLoaded.."数据"..whatExactly.."刚才动态加载消耗了"..loadTime.." 秒(+ "..gcTime.." 秒 GC 时间) 及占用"..usedRAM.." KB插件内存");
			end
			return true;
		end
	end
end

function MobMap_Mask(number1, number2)
	if(MOBMAP_ISONAMAC) then
		if(number1<0) then 
			return 0; 
		else 
			return floor(number1%number2); 
		end
	else
		return bit.band(number1,number2-1);
	end
end

function MobMap_RGBToHex(r, g, b)
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

function MobMap_ConstructColorizedItemName(quality, name)
	local r,g,b = GetItemQualityColor(quality);
	return "|cff"..MobMap_RGBToHex(r,g,b).."["..name.."]|r";
end

-- this is actually a copy of a Blizzard function to get the quest difficulty colors

MobMap_QuestDifficultyColor = { };
MobMap_QuestDifficultyColor["impossible"] = { r = 1.00, g = 0.10, b = 0.10 };
MobMap_QuestDifficultyColor["verydifficult"] = { r = 1.00, g = 0.50, b = 0.25 };
MobMap_QuestDifficultyColor["difficult"] = { r = 1.00, g = 1.00, b = 0.00 };
MobMap_QuestDifficultyColor["standard"] = { r = 0.25, g = 0.75, b = 0.25 };
MobMap_QuestDifficultyColor["trivial"]	= { r = 0.50, g = 0.50, b = 0.50 };
MobMap_QuestDifficultyColor["header"]	= { r = 0.7, g = 0.7, b = 0.7 };

function MobMap_GetQuestDifficultyColor(level)
	local levelDiff = level - UnitLevel("player");
	if ( levelDiff >= 5 ) then
		color = MobMap_QuestDifficultyColor["impossible"];
	elseif ( levelDiff >= 3 ) then
		color = MobMap_QuestDifficultyColor["verydifficult"];
	elseif ( levelDiff >= -2 ) then
		color = MobMap_QuestDifficultyColor["difficult"];
	elseif ( -levelDiff <= GetQuestGreenRange() ) then
		color = MobMap_QuestDifficultyColor["standard"];
	else
		color = MobMap_QuestDifficultyColor["trivial"];
	end
	return color;	
end