-- position database functions

function MobMap_GetMobPositions(mobid, zoneid)
	if(mobmap_mobs[mobid]==nil) then return nil; end
	local mobpointer=MobMap_GetMobPointer(mobid);
	local minlevel, maxlevel, zonecount = MobMap_GetMobDetails(mobpointer);
	local i;
	for i=1, zonecount, 1 do
		local zonecode, length, pointer = MobMap_GetPointerToPositionData(mobpointer+i);
		if(zonecode==zoneid) then
			return MobMap_GetCoordPairsFromDB(pointer,length);
		end
	end
	return nil;
end

function MobMap_GetCoordPairsFromDB(position, length)
	local i;
	local coords={};
	local xo,yo;
	for i=0, length-1, 1 do
		local xc,yc=MobMap_GetCoordFromDB(position+i)
		if(i%2==0) then
			xo=xc;
			yo=yc;
		else
			table.insert(coords, {x1=xo, x2=xc, y=yo});
		end
	end
	return coords;
end

function MobMap_GetCoordFromDB(position)
	local bucket=floor(position/4)+1;
	local data=mobmap_data[bucket];
	if(data==nil) then return nil; end
	local x;
	local y=0;
	x=floor(data/(mobmap_shiftconst[(position%4)*2])+0.5);
	if(position%2==0) then y=floor(data/(mobmap_shiftconst[(position%4)*2+1])+0.5); end
	x=x%256;
	y=y%256;
	return x,y;
end

-- user interface functions

function MobMap_UpdateMobMapFrame()
	local offset=FauxScrollFrame_GetOffset(MobMapMobSearchFrameMobListScrollFrame);
	local mobcount=table.getn(mobmap_currentlist);
	local maxmobcount=16+math.floor((mobmap_window_height-448)/18);
	for i=1,36,1 do
		local mobindex=i+offset;
		local frame=getglobal("MobMapMob"..i);
		if(mobmap_currentlist[mobindex]~=nil and i<maxmobcount) then
			frame:Show();
			frame:SetText(mobmap_currentlist[mobindex].name);
			frame.subtitle=mobmap_currentlist[mobindex].sub;
			frame.mobid=mobmap_currentlist[mobindex].mobid;
			frame:Enable();
		else
			frame:Hide();
		end
	end
	if(mobmap_currentlist[1]==nil and string.sub(MobMapMobSearchFrameSearchBox:GetText(),1,3)~="id:") then
		MobMapMob1:SetText(MOBMAP_NO_MOBS_FOUND);
		MobMapMob1:Disable();
		MobMapMob1:Show();
		MobMap_UpdateZoneList();
	end

	FauxScrollFrame_Update(MobMapMobSearchFrameMobListScrollFrame, mobcount+1, maxmobcount, 22);
end

function MobMap_UpdateFilter(text, subtitle, zone)
	local maxmobcount=15+math.floor((mobmap_window_height-430)/18);
	mobmap_currentlist = {};
	local filtertext;
	local exactmatch;
	if(string.sub(text,1,1)=="\"" and string.sub(text,-1)=="\"") then
		exactmatch=true;
		filtertext=string.sub(text,2,string.len(text)-1);
	else
		filtertext=text;
		exactmatch=false;
	end
	local zoneid=-1;
	if(zone~="") then zoneid=MobMap_GetZoneID(zone); end
	if(string.sub(text,1,3)=="id:") then
		mobmap_currentlist={};
		mobmap_multidisplay={};
		text=string.sub(text,4);
		for w in string.gmatch(text, "%d*") do
			if(tonumber(w)~=nil) then
				table.insert(mobmap_multidisplay,{id=tonumber(w)});
			end
		end
		if(table.getn(mobmap_multidisplay)==0) then 
			mobmap_multidisplay=nil; 
		else
			MobMap_UpdatePositions();
			MobMap_SwitchMapAndDisplay();
		end
	else
		if(mobmap_multidisplay~=nil) then
			mobmap_multidisplay=nil;
			MobMap_HideAllDots();
		end
		if(exactmatch==false) then
			filtertext=MobMap_PatternEscape(filtertext);
			subtitle=MobMap_PatternEscape(subtitle);
		end
		if(exactmatch==true and subtitle=="") then
			local mobid=MobMap_GetIDForMobName(filtertext);
			if(mobid) then
				if(zoneid==-1 or MobMap_CheckIfMobIsInZone(mobid, zoneid)==true) then
					local part1,part2=MobMap_GetMobNameAndSubtitle(MobMap_GetMobFullName(mobid));
					table.insert(mobmap_currentlist,{name=part1, sub=part2, mobid=mobid});
				end
			end
		else
			for k,v in pairs(mobmap_mobs) do
				local part1,part2=MobMap_GetMobNameAndSubtitle(v);
				if((exactmatch==false and string.find(string.lower(part1),".-"..string.lower(filtertext)..".-")~=nil) or (exactmatch==true and string.lower(part1)==string.lower(filtertext))) then
					if((part2==nil and subtitle=="") or (part2~=nil and string.find(string.lower(part2),".-"..string.lower(subtitle)..".-")~=nil)) then
						if(zoneid==-1 or MobMap_CheckIfMobIsInZone(k, zoneid)==true) then
							table.insert(mobmap_currentlist,{name=part1, sub=part2, mobid=k});
						end
					end
				end
			end
		end
	end
	MobMap_UnsetMob();
	MobMap_UpdateMobMapFrame();
	if(table.getn(mobmap_currentlist)==1) then
		MobMapButton_ProcessClick("MobMapMob1");
	else
		mobmap_zonelist={};
		MobMap_UpdateZoneList();
	end
end

function MobMapButton_OnClick()
	MobMapButton_ProcessClick(this:GetName());
end

function MobMapButton_ProcessClick(button)
	local frame=getglobal(button);
	MobMapMobSearchFrameMobHighlightFrame:Show();
	MobMapMobSearchFrameMobHighlightFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
	MobMapMobSearchFrameMobHighlightFrame:SetAlpha(0.5);
	MobMapHighlight:SetVertexColor(1.0, 1.0, 1.0);
	MobMapMobSearchFrameSelectionDetails:Show();
	MobMapMobSearchFrameSelectionDetailsName:SetText(frame:GetText());
	if(frame.subtitle~=nil) then
		MobMapMobSearchFrameSelectionDetailsSubtitle:SetText(frame.subtitle);
		MobMapMobSearchFrameSelectionDetails.mobfullname=frame:GetText().."|"..frame.subtitle;
		MobMapMobSearchFrameSelectionDetails.mobid=frame.mobid;
	else
		MobMapMobSearchFrameSelectionDetailsSubtitle:SetText("");
		MobMapMobSearchFrameSelectionDetails.mobfullname=frame:GetText();
		MobMapMobSearchFrameSelectionDetails.mobid=frame.mobid;
	end
	local pointer=MobMap_GetMobPointer(frame.mobid);
	if(pointer==nil) then return; end
	local minlevel, maxlevel, zonecount = MobMap_GetMobDetails(pointer);
	if(minlevel~=maxlevel) then
		MobMapMobSearchFrameSelectionDetailsLevel:SetText(MOBMAP_LEVEL..minlevel.." - "..maxlevel);
	else
		if(minlevel==0) then
			MobMapMobSearchFrameSelectionDetailsLevel:SetText(MOBMAP_BOSS_LEVEL);
		else
			MobMapMobSearchFrameSelectionDetailsLevel:SetText(MOBMAP_LEVEL..minlevel);
		end
	end
	mobmap_zonelist={};
	local zonelist=MobMap_GetMobZones(pointer);
	for k,v in pairs(zonelist) do
		table.insert(mobmap_zonelist,{name=MobMap_GetZoneName(v), id=v});
	end
	MobMap_UnsetZone();
	MobMap_UpdateZoneList();
end

function MobMap_UpdateZoneList()
	local maxzonecount=13+math.floor((mobmap_window_height-430)/18);
	local zones=table.getn(mobmap_zonelist);
	local offset=FauxScrollFrame_GetOffset(MobMapMobSearchFrameZoneListScrollFrame);

	for i=1,35,1 do
		local zoneindex=i+offset;
		local frame=getglobal("MobMapZone"..i);
		if(zoneindex>zones or i>maxzonecount) then
			frame:Hide();
		else
			frame:SetText(mobmap_zonelist[zoneindex].name);
			frame.id=mobmap_zonelist[zoneindex].id;
			frame:Show();
		end
	end

	FauxScrollFrame_Update(MobMapMobSearchFrameZoneListScrollFrame, zones, maxzonecount, 22);

	if(zones==1) then
		MobMapZoneButton_ProcessClick("MobMapZone1");
		if(mobmap_questsearch) then HideUIPanel(MobMapFrame); end
	else
		if(not MobMapFrame:IsVisible()) then ShowUIPanel(MobMapFrame); end
		if(MobMapMobSearchFrame~=nil and not MobMapMobSearchFrame:IsVisible()) then MobMap_ShowPanel("MobMapMobSearchFrame"); end
	end
	mobmap_questsearch=false;
end

function MobMapZoneButton_OnClick()
	MobMapZoneButton_ProcessClick(this:GetName());
end

function MobMapZoneButton_ProcessClick(button)
	local frame=getglobal(button);
	MobMapZoneHighlightFrame:Show();
	MobMapZoneHighlightFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
	MobMapZoneHighlightFrame:SetAlpha(0.5);
	MobMapZoneHighlight:SetVertexColor(1.0, 1.0, 1.0);
	mobmap_multidisplay=nil;
	mobmap_currentlyshown={zonename=frame:GetText(), zoneid=frame.id, mobname=MobMapMobSearchFrameSelectionDetailsName:GetText(), mobfullname=MobMapMobSearchFrameSelectionDetails.mobfullname, mobid=MobMapMobSearchFrameSelectionDetails.mobid};
	mobmap_enabled=true;
	MobMapCheckButton:SetChecked(true);
	MobMap_SwitchMapAndDisplay();
end

function MobMap_ShowMobByID(mobid)
	local mobname=MobMap_GetMobName(mobid);
	if(mobname==nil) then return; end
	MobMap_ShowMobByName(mobname);
end

function MobMap_ShowMobByName(mobname)
	MobMapMobSearchFrameSearchBox:SetText("\""..mobname.."\"");
	MobMapMobSearchFrameSubtitleSearchBox:SetText("");
	MobMapMobSearchFrameZoneSearchBox:SetText("");
	MobMap_UpdateFilter(MobMapMobSearchFrameSearchBox:GetText(),MobMapMobSearchFrameSubtitleSearchBox:GetText(),MobMapMobSearchFrameZoneSearchBox:GetText());
end

function MobMap_ShowMultipleMobs(idlist)
	local searchtext="id:";
	for i=1,table.getn(idlist),1 do
		searchtext=searchtext..idlist[i]..",";
	end
	MobMapMobSearchFrameSearchBox:SetText(searchtext);
	MobMapMobSearchFrameSubtitleSearchBox:SetText("");
	MobMapMobSearchFrameZoneSearchBox:SetText("");
	MobMap_UpdateFilter(MobMapMobSearchFrameSearchBox:GetText(),MobMapMobSearchFrameSubtitleSearchBox:GetText(),MobMapMobSearchFrameZoneSearchBox:GetText());
end

-- MobMapMobSearchFrame event handlers

mobmap_mobsearchframe_oldtext1="";
mobmap_mobsearchframe_oldtext2="";
mobmap_mobsearchframe_oldtext3="";
mobmap_mobsearchframe_timeout=0;

function MobMapMobSearchFrame_OnShow()
	mobmap_mobsearchframe_oldtext1=MobMapMobSearchFrameSearchBox:GetText();
	mobmap_mobsearchframe_oldtext2=MobMapMobSearchFrameSubtitleSearchBox:GetText();
	mobmap_mobsearchframe_timeout=-1;
end

function MobMapMobSearchFrame_OnUpdate()
	if(MobMapMobSearchFrameSearchBox:GetText()~=mobmap_mobsearchframe_oldtext1 or MobMapMobSearchFrameSubtitleSearchBox:GetText()~=mobmap_mobsearchframe_oldtext2 or MobMapMobSearchFrameZoneSearchBox:GetText()~=mobmap_mobsearchframe_oldtext3) then
		mobmap_mobsearchframe_oldtext1=MobMapMobSearchFrameSearchBox:GetText();
		mobmap_mobsearchframe_oldtext2=MobMapMobSearchFrameSubtitleSearchBox:GetText();
		mobmap_mobsearchframe_oldtext3=MobMapMobSearchFrameZoneSearchBox:GetText();
		mobmap_mobsearchframe_timeout=1.0;
	end
	if(mobmap_mobsearchframe_timeout==-1) then return; end
	if(mobmap_mobsearchframe_timeout<0) then
		MobMap_UpdateFilter(MobMapMobSearchFrameSearchBox:GetText(),MobMapMobSearchFrameSubtitleSearchBox:GetText(),MobMapMobSearchFrameZoneSearchBox:GetText());
		mobmap_mobsearchframe_timeout=-1;
	else
		mobmap_mobsearchframe_timeout=mobmap_mobsearchframe_timeout-arg1;
	end
end

mobmap_pzf_notextchanged=0;
mobmap_pzf_textlen=0;
mobmap_pzf_marklen=0;

function MobMap_PositionZoneFilter_OnTextChanged()
	if(mobmap_pzf_notextchanged==1 or mobmap_pzf_textlen==string.len(MobMapMobSearchFrameZoneSearchBox:GetText())+1 or mobmap_pzf_textlen==string.len(MobMapMobSearchFrameZoneSearchBox:GetText())+mobmap_pzf_marklen) then
		mobmap_pzf_notextchanged=0;
		mobmap_pzf_textlen=string.len(MobMapMobSearchFrameZoneSearchBox:GetText());
	else
		local text=MobMapMobSearchFrameZoneSearchBox:GetText();
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
			mobmap_pzf_notextchanged=1;
			mobmap_pzf_textlen=string.len(match);
			MobMapMobSearchFrameZoneSearchBox:SetText(match);
			if(string.len(match)>textlen) then MobMapMobSearchFrameZoneSearchBox:HighlightText(textlen,string.len(match)); end
			mobmap_pzf_marklen=string.len(match)-textlen;
		end
	end
end
