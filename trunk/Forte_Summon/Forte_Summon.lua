-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x
local FW = FW;
local SU = FW:Module("Summon");

local r, g, b, a;
local t1,t2,t3,t4,t5,t6,t7;
local NUM_SUMMONS = 10;

local Zone;
local SubZone;
local RealZone;
local Coordinates = {};
local ActiveSummons = {};
local WorldMapRatio = 1.5;

local su = {};

local NisFar = 0;
local Nis30y = 0;

local SORT={
	SUMMON =	{ORDER=	{6,3,4,1},	ASC={1,1,0,1}},
}
local SUMMON_PRIOR = {
	WHISPER = 1,
	NORMAL = 2,
	SUMMON = 3,
	IGNORE = 4,
};

local SUMMON_DISTANCE = {0.05,0.05,0.1}; -- the two old continents and outlands

function FW:UnitFrame_OnEnter()
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	GameTooltip:SetUnit(this.unit);
	GameTooltipTextLeft1:SetTextColor(GameTooltip_UnitColor(this.unit));
end

function FW:UnitFrame_OnLeave()
	GameTooltip:Hide();	
end

local function SU_SummonShow(hide) -- with hide set, will force the frame to hide, even in 'combat'
	if InCombatLockdown() then return;end
	if FW.Settings.Summon and not hide and (FC_Saved.RAID or FC_Saved.PARTY) and not WorldMapFrame:IsShown() then
		FWSUFrame:Show();
		FWSUBackground:Show();
		FWSUBackground:ClearAllPoints();
		
		FWSUFrame:SetWidth(FW.Settings.SummonWidth+2*FW.BORDER);
		FWSUBackground:SetWidth(FW.Settings.SummonWidth+2*FW.BORDER);
		FWSUFrame:SetScale(FW.Settings.SummonScale);
		FWSUBackground:SetScale(FW.Settings.SummonScale);
		
		FWSUBackground:SetBackdropColor(unpack(FW.Settings.ColorSummonBg));
		FWSUBackground:SetBackdropBorderColor(unpack(FW.Settings.ColorSummonBg));
		
		FWSUFrameAmount:SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
		FWSUFrameInfo:SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
		
		r,g,b = unpack(FW.Settings.ColorSummonText);
		for i=1,NUM_SUMMONS,1 do
			getglobal("FWSUBar"..i):ClearAllPoints();
			
			getglobal("FWSUBar"..i.."Name"):SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
			getglobal("FWSUBar"..i.."Info"):SetFont(FW.Settings.SummonFont,FW.Settings.SummonFontSize);
			
			getglobal("FWSUBar"..i):SetWidth(FW.Settings.SummonWidth);
			getglobal("FWSUBar"..i):SetHeight(FW.Settings.SummonHeight);
			getglobal("FWSUBar"..i.."NormalTexture"):SetTexture(FW.Settings.SummonTexture);
			getglobal("FWSUBar"..i.."Name"):SetTextColor(r,g,b);
			getglobal("FWSUBar"..i.."Info"):SetTextColor(r,g,b);
		end
		if FW.Settings.SummonExpand then
			FWSUBackground:SetPoint("BOTTOMRIGHT", FWSUFrame, "BOTTOMRIGHT", 0, 0);
			FWSUBar1:SetPoint("BOTTOMLEFT", FWSUBackground, "BOTTOMLEFT", FW.BORDER, 18);
			
			for i=2,NUM_SUMMONS,1 do
				getglobal("FWSUBar"..i):SetPoint("BOTTOMLEFT", getglobal("FWSUBar"..(i-1)), "TOPLEFT", 0, FW.Settings.SummonSpace);
			end
		else
			FWSUBackground:SetPoint("TOPLEFT", FWSUFrame, "TOPLEFT", 0, 0);
			FWSUBar1:SetPoint("TOPLEFT", FWSUBackground, "TOPLEFT", FW.BORDER, -18);
			
			for i=2,NUM_SUMMONS,1 do
				getglobal("FWSUBar"..i):SetPoint("TOPLEFT", getglobal("FWSUBar"..(i-1)), "BOTTOMLEFT", 0, -FW.Settings.SummonSpace);
			end
		end
	else
		FWSUFrame:Hide();
		FWSUBackground:Hide();
	end
end

local function SU_SummonScale()
	SU_SummonShow();
	FW:CorrectScale(FWSUFrame);
end


local function ColorVal(flag,prior)
	
	if flag == SUMMON_PRIOR.NORMAL then
		if prior > 1 then prior = 1; end
		r,g,b = FW:MixColors(prior,FW.Settings.ColorSummonClose,FW.Settings.ColorSummonFar);
	elseif flag == SUMMON_PRIOR.SUMMON then
		r,g,b = unpack(FW.Settings.ColorSummoning);
	elseif flag == SUMMON_PRIOR.WHISPER then
		r,g,b = unpack(FW.Settings.ColorWhisper);
	end
end

local function SU_DrawSummon()
	if not FWSUFrame:IsShown() then return; end
	FW:BST(su,SORT.SUMMON.ORDER,SORT.SUMMON.ASC); -- sort viewable data, first by class, then by distance, last by name
	local n=0;
	local index=0;
	local Bar;
	for i=1, NUM_SUMMONS, 1 do
		Bar = getglobal("FWSUBar"..i);
		index = index+1;
		while index <= FW:ROWS(su) do
			t1,t2,_,t4,_,t6,t7 = FW:GET(su,index);
			if t6 ~= SUMMON_PRIOR.IGNORE then break; else index=index+1 end
		end
		if FW.Settings.SummonDetails and i <= FW.Settings.SummonMax and index <= FW:ROWS(su) then
			
			ColorVal(t6,t4);
			
			getglobal("FWSUBar"..i.."Name"):SetText(t1);
			getglobal("FWSUBar"..i.."Info"):SetText(t7);
			getglobal("FWSUBar"..i.."NormalTexture"):SetVertexColor(r,g,b);
		
			if UnitIsUnit("target",t2) then
				Bar:SetAttribute("type1" ,"spell");
				Bar:SetAttribute("spell", FW.L.RITUAL_OF_SUMMONING);
			else
				Bar:SetAttribute("type1" ,"target");
				Bar:SetAttribute("unit",t2);
			end
			Bar.unit = t2;
			
			n=n+1;
			Bar:Show();
		else
			Bar:Hide();
		end

	end
	
	
	if FW.Settings.SummonCloser then
		FWSUFrameAmount:SetText("x"..Nis30y);
		FWSUFrameInfo:SetText(NisFar.." | "..Nis30y..FW.L._ALL);
	else
		FWSUFrameInfo:SetText(FW.L.FAR_..NisFar.." | "..Nis30y);
		FWSUFrameAmount:SetText("x"..NisFar);
	end
	if n>0 then
		FWSUBackground:SetHeight(21+(FW.Settings.SummonHeight+FW.Settings.SummonSpace)*n-FW.Settings.SummonSpace);
	else
		FWSUBackground:SetHeight(20);
	end
end

local function SU_ClearSummon() -- remove everybody that's added with normal priority and people outside the raid
	local i=1;
	while i <= FW:ROWS(su) do
		if FW:GET(su,i,6) == SUMMON_PRIOR.NORMAL then 
			FW:REMOVE(su,i);
		elseif not FW:NameToID(FW:GET(su,i,1)) then
			FW:REMOVE(su,i);
		else
			i=i+1;
		end
	end
	NisFar = 0;
	Nis30y = 0;
end

local pc,px,py;
local function SU_AddCoordinates(unit,c)
	t3 = UnitName(unit);
	t1,t2= GetPlayerMapPosition(unit);
	if t1~=0 or t2~=0 then
		FW:INSERT(Coordinates,t3 ,c,t1,t2);
		if t3 == FW.PLAYER then
			pc=c;px=t1;py=t2;
		end
	end
end


local function SU_StoreMap() -- stores the viewing part of the map, and every raid member's position on the map
	pc=nil;px=0;py=0;
	FW:ERASE(Coordinates);
	for c=1,3,1 do -- get all the positions from people now
		SetMapZoom(c);
		if GetNumRaidMembers()>0 then
			for i=1,GetNumRaidMembers(),1 do
				SU_AddCoordinates(FW.RAID[i],c);
			end
		else
			for i=1,GetNumPartyMembers(),1 do
				SU_AddCoordinates(FW.PARTY[i],c);
			end
			SU_AddCoordinates("player",c);
		end
	end
	SetMapToCurrentZone();
	RealZone = GetRealZoneText();
    	SubZone = GetSubZoneText();
   	Zone = GetZoneText();
end

local function SU_QueueSummon(unit)
	local unitName = UnitName(unit);
	FW:SETKEY(su,unitName, unit,(FW:IsWarlock(unit) or 2),0,GetTime(),SUMMON_PRIOR.WHISPER,unitName);
	SU_DrawSummon();
end

--FW.Zones only useable in raids!

local function SU_InInstance(name,index)
	if index then
		-- check for bugged coordinates
		if FC_Saved.RAID and FW.Zones[name] == FW.L.COILFANG_RESERVOIR then -- ppl inside Coilfang Reservoir may show up as near the dark portal...
			if Coordinates[index+2]<0.5 then
				return false;
			else
				return true;
			end
		else
			return false;
		end
		
	else
		return true;
	end
end

local function SU_InMyInstance(name,index)
	-- BLIZZARD FAILS since someone in your instance outside viewing range shows up in some bugged spot on the world map
	-- meaning there's no way to know for sure someone is inside your instance, only if he's in a zone named the same
	-- Fixed for: Coilfang Reservoir

	if FC_Saved.RAID and FW.Zones[name] ~= Zone and FW.Zones[name] ~= RealZone and FW.Zones[name] ~= SubZone then -- zone text doesnt match
		return false;
	end
	-- zone matches, but is this unit actually inside the instance?
	return SU_InInstance(name,index);
	
end

--[[local function SU_AddSummon(unit)
	local prior = 1;-- default out of range priority
	local unitName = UnitName(unit);
	local cIndex = FW:FIND(Coordinates,unitName);
	local index = FW:FIND(su,unitName);
	if index then -- if it exists, means this unit has special properties
		su[index+1] = unit; -- update unit id even if this is a special prior!
		if su[index+5]==SUMMON_PRIOR.IGNORE and su[index+4] <= GetTime() then -- whisper and ignore priority expire
			--FW:ShowDebug("removing ignore on "..unitName);
			FW:REMOVE_INDEX(su,index);
		end
		return;
	end
	-- automatic adding
	if not UnitIsDeadOrGhost(unit) and UnitIsConnected(unit) and not UnitIsUnit(unit,"player") and not CheckInteractDistance(unit, 4) then -- alive,connected and outside follow range
		if pc then -- outside instance
			Nis30y = Nis30y + 1;
			if not cIndex or Coordinates[cIndex+1] ~= pc then -- this unit is on another continent, give high prior
				prior = 2; --
				NisFar = NisFar + 1;
			else
				prior = math.sqrt(math.pow(px-Coordinates[cIndex+2],2) + math.pow( WorldMapRatio*(py-Coordinates[cIndex+3]) ,2));
				if prior <= SUMMON_DISTANCE[pc] then
					if not FW.Settings.SummonCloser then
						return; -- too close to need a summon
					end
				else
					NisFar = NisFar + 1;
				end
			end
		else -- inside instance 
			Nis30y = Nis30y + 1;
			if UnitIsVisible(unit) then
				if FW.Settings.SummonCloser then
					prior = 0;
				else
					return;
				end
			else
				NisFar = NisFar + 1;
			end
		end
		FW:INSERT(su,unitName, unit,(FW:IsWarlock(unit) or 2),prior,GetTime(),SUMMON_PRIOR.NORMAL,unitName);
	end
	if cIndex then FW:REMOVE_INDEX(Coordinates,cIndex); end-- speed up searching player coordinates a bit, deleting the player i've done
end]]

local function SU_AddSummon(unit)
	local prior = 1;-- default out of range priority
	local unitName = UnitName(unit);
	local cIndex = FW:FIND(Coordinates,unitName);
	local index = FW:FIND(su,unitName);
	if index then -- if it exists, means this unit has special properties
		su[index+1] = unit; -- update unit id even if this is a special prior!
		if su[index+5]==SUMMON_PRIOR.IGNORE and su[index+4] <= GetTime() then -- whisper and ignore priority expire
			--FW:ShowDebug("removing ignore on "..unitName);
			FW:REMOVE_INDEX(su,index);
		end
		return;
	end
	
	-- automatic adding
	if not UnitIsDeadOrGhost(unit) and UnitIsConnected(unit) and not UnitIsUnit(unit,"player") and not CheckInteractDistance(unit, 4) then -- alive,connected and outside follow range
		if pc then -- outside instance
		
			if FW.Settings.SummonOldMode and SU_InInstance(unitName,cIndex) then
				return;
			else -- this unit isnt in an instance
				Nis30y = Nis30y + 1;
				if not cIndex or Coordinates[cIndex+1] ~= pc then -- this unit is on another continent, give high prior
					prior = 2; --
					NisFar = NisFar + 1;
				else
					prior = math.sqrt(math.pow(px-Coordinates[cIndex+2],2) + math.pow( WorldMapRatio*(py-Coordinates[cIndex+3]) ,2));
					if prior <= SUMMON_DISTANCE[pc] then
						if not FW.Settings.SummonCloser then
							return; -- too close to need a summon
						end
					else
						NisFar = NisFar + 1;
					end
				end
			end
		else -- inside instance 
			if not FW.Settings.SummonOldMode or SU_InMyInstance(unitName,cIndex) then
				Nis30y = Nis30y + 1;
				if UnitIsVisible(unit) then
					if FW.Settings.SummonCloser then
						prior = 0;
					else
						return;
					end
				else
					NisFar = NisFar + 1;
				end
			else -- not inside my instance, ignore
				return;
			end		
		end
		
		FW:INSERT(su,unitName, unit,(FW:IsWarlock(unit) or 2),prior,GetTime(),SUMMON_PRIOR.NORMAL,unitName);
	end
	if cIndex then FW:REMOVE_INDEX(Coordinates,cIndex); end-- speed up searching player coordinates a bit, deleting the player i've done
end

local function SU_ScanSummon()

	if FW.Settings.Summon and (FC_Saved.RAID or FC_Saved.PARTY) and not InCombatLockdown() and not WorldMapFrame:IsShown() then -- dont do shit if not in raid, in combat or when your map is shown :P
		SU_ClearSummon();
		-- Do scans
		SU_StoreMap();
		
		if GetNumRaidMembers()>0 then
			for i=1,GetNumRaidMembers(),1 do
				SU_AddSummon(FW.RAID[i]);
			end
		else
			for i=1,GetNumPartyMembers(),1 do
				SU_AddSummon(FW.PARTY[i]);
			end
			SU_AddSummon("player");
		end
		SU_DrawSummon();
	end
end

local function SU_SummonWhisper()
	arg1 = strlower(arg1);
	if not (FC_Saved.RAID or FC_Saved.PARTY) or not FW.Settings.Summon or not FW.Settings.SummonKeyword or string.find(arg1,strlower(FW.L.SUMMON_REQUEST_BLOCK)) then return; end
	t1 = FW:NameToID(arg2);
	if t1 then
		_,_,t2 = string.find(arg1,"^"..strlower(FW.Settings.SummonKeywordMsg).." (%l+)");
		if t2 then
			for i=1,GetNumRaidMembers(),1 do
				if strlower(UnitName(FW.RAID[i])) == t2 then
					SU_QueueSummon(FW.RAID[i]);
					FW:Whisper(string.format(FW.L.SUMMON_REQUEST_FOR,UnitName(FW.RAID[i])),arg2);
					FW:Whisper(string.format(FW.L.SUMMON_REQUEST_BY,arg2),UnitName(FW.RAID[i]));
					return;
				end
			end
			for i=1,GetNumPartyMembers(),1 do
				if strlower(UnitName(FW.PARTY[i])) == t2 then
					SU_QueueSummon(FW.PARTY[i]);
					FW:Whisper(string.format(FW.L.SUMMON_REQUEST_FOR,UnitName(FW.PARTY[i])),arg2);
					FW:Whisper(string.format(FW.L.SUMMON_REQUEST_BY,arg2),UnitName(FW.PARTY[i]));
					return;
				end
			end
			SU_QueueSummon(t1);
			FW:Whisper(FW.L.SUMMON_REQUEST,arg2);
		elseif arg1==strlower(FW.Settings.SummonKeywordMsg) then
			SU_QueueSummon(t1);
			FW:Whisper(FW.L.SUMMON_REQUEST,arg2);
		end		
	end
end
local function SU_SummonCastStart(player,target,from)
	--FW:ShowDebug("Summon Start msg: "..target.." by "..player);
	
	-- don't do anything when i get more summon targets for one player, lag may cause a warlock's target to update too slow, and showns as summoning it's old target
	if not ActiveSummons[player] or player == from then
		
		ActiveSummons[player] = target;

		-- Move this player to bottom
		local id =  FW:NameToID(target);
		if id then
			FW:SETKEY(su,target, id,(FW:IsWarlock(id) or 2),0,GetTime(),SUMMON_PRIOR.SUMMON,"<"..player..">");
			SU_DrawSummon();
		end
	end
end

local function SU_SummonCastCancel(player,target,from)
	--FW:ShowDebug("Summon Cancel msg: "..target.." by "..player);
	ActiveSummons[player] = nil;
	
	local index = FW:FIND(su,target);
	-- change this player back to normal, if nobody else was summoning him / has summoned him
	if index and (su[index+5] ~= SUMMON_PRIOR.IGNORE or player == from) then -- don't change mainprior if ignored already

		for key, val in pairs(ActiveSummons) do -- don't change prior if being summoned by another warlock
			if val == target then
				su[index+6] = "<"..key..">";
				return;
			end
		end
		FW:REMOVE_INDEX(su,index);
		SU_DrawSummon();
	end
end

local function SU_SummonCastEnd(player,target,from)
	--FW:ShowDebug("Summon End msg: "..target.." by "..player);
	
	ActiveSummons[player] = nil;
	
	local index = FW:FIND(su,target);
	
	if index and (su[index+5] ~= SUMMON_PRIOR.IGNORE or player == from) then -- don't change mainprior if ignored already

		for key, val in pairs(ActiveSummons) do -- don't change prior if being summoned by another warlock
			if val == target then
				su[index+6] = "<"..key..">";
				return;
			end
		end
		su[index+4] = GetTime()+10;
		su[index+5] = SUMMON_PRIOR.IGNORE;
		SU_DrawSummon();
	end
end

-- globally accessable
function FW:SUFrame_OnClick(button)
	if this.fwmovingx then return; end
	if button == "LeftButton" then
		if FW.Settings.SummonDetails then -- toggles between hidden->normal->all30y->etc
			if FW.Settings.SummonCloser then
				FW.Settings.SummonDetails = false;
			else
				FW.Settings.SummonCloser = true;
			end
		else
			FW.Settings.SummonDetails = true;
			FW.Settings.SummonCloser = false;
		end
		SU_DrawSummon();
		FW:RefreshOptions();
		
	else
		FW:ScrollTo(FW.L.SUMMON_ASSISTANT);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:IgnoreClick()
	local unitName = UnitName(this.unit);
	FW:SETKEY(su,unitName, this.unit,(FW:IsWarlock(this.unit) or 2),0,(GetTime()+10),SUMMON_PRIOR.IGNORE,unitName);
	SU_DrawSummon();
end

local SU_OriginalChatFrame_OnEvent = ChatFrame_OnEvent;
local function SU_ChatFrame_OnEvent(event)

	if event == "CHAT_MSG_WHISPER_INFORM" then
		if string.find(arg1,FW.L.SUMMON_REQUEST_BLOCK) then
			return;
		end
	end
       SU_OriginalChatFrame_OnEvent(event);
end
ChatFrame_OnEvent = SU_ChatFrame_OnEvent;

function FW:SummonOnload()
	FW:RegisterFrame("FWSUFrame",SU_SummonShow,"Summon");

	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("SummonInterval",		SU_SummonShow);
		FW:RegisterTimedEvent("SummonInterval",		SU_ScanSummon);
	end);

	FW:RegisterToEvent("CHAT_MSG_WHISPER",		SU_SummonWhisper);
	FW:RegisterToEvent("PLAYER_TARGET_CHANGED",	SU_DrawSummon);-- change summon buttons to summon or select

	FW:RegisterOtherCasts();
	
	FW:RegisterOnLeaveCombat(SU_SummonShow);
	FW:RegisterOnEnterCombat(function() SU_SummonShow(1);end);
	
	FW:RegisterLoadEvent(SU_SummonShow);

	FW:RegisterMessage(FW.SU_CAST_START,
		function(m,f) 
			local _,_,t1,t2 = string.find(m,"^(.-) (.+)$");
			if t1 and t2 then SU_SummonCastStart(t1,t2,f); end
		end,
	1);
	FW:RegisterMessage(FW.SU_CAST_CANCEL,
		function(m,f) 
			local _,_,t1,t2 = string.find(m,"^(.-) (.+)$");
			if t1 and t2 then SU_SummonCastCancel(t1,t2,f); end
		end,
	1);
	FW:RegisterMessage(FW.SU_CAST_END,
		function(m,f) 
			local _,_,t1,t2 = string.find(m,"^(.-) (.+)$");
			if t1 and t2 then SU_SummonCastEnd(t1,t2,f); end
		end,
	1);
	--FW:Show("Summon Module Loaded");
end

FW:SetMainCategory(FW.L.SUMMON_ASSISTANT,FW.ICON_SU,8,"DEFAULT","FWSUFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.SU_HINT1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.SU_HINT2);
	
	FW:SetSubCategory(FW.L.BASIC,FW.ICON_BASIC,2)
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ENABLE,			FW.L.SU_ENABLE_TT,	"Summon",		SU_SummonShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_BARS,		FW.L.SHOW_BARS_TT,	"SummonDetails");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXPAND_UP,		FW.L.EXPAND_UP_TT,	"SummonExpand",		SU_SummonShow);
	
	FW:SetSubCategory(FW.L.SPECIFIC,FW.ICON_SPECIFIC,3);	
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_CLOSE,		FW.L.SHOW_CLOSE_TT,		"SummonCloser");
		FW:RegisterOption(FW.MSG,1,FW.NON,FW.L.QUEUE_SUMMON,		FW.L.QUEUE_SUMMON_TT,		"SummonKeyword");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_MEETING_STONE,	FW.L.SHOW_MEETING_STONE_TT,	"SummonMeetingStone");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.OLD_SUMMONING_MODE,	FW.L.OLD_SUMMONING_MODE_TT,	"SummonOldMode");
		
	FW:SetSubCategory(FW.L.SIZING,FW.ICON_SIZE,4);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_WIDTH,		"",	"SummonWidth",		SU_SummonShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_HEIGHT,		"",	"SummonHeight",		SU_SummonShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_SPACING,		"",	"SummonSpace",		SU_SummonShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SCALE,			"",	"SummonScale",		SU_SummonScale);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.MAX_SHOWN,		"",	"SummonMax");	

	FW:SetSubCategory(FW.L.BAR_COLORING,FW.ICON_FILTER,5);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.PLAYER_FAR,		"",	"ColorSummonFar");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.PLAYER_CLOSE,		"",	"ColorSummonClose");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BEING_SUMMONED,		"",	"ColorSummoning");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.WHISPERED,		"",	"ColorWhisper");

	FW:SetSubCategory(FW.L.APPEARANCE,FW.ICON_APPEARANCE,6);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BAR_TEXT,		"",	"ColorSummonText",	SU_SummonShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FRAME_BACKGROUND,	"",	"ColorSummonBg",	SU_SummonShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.BAR_FONT,		"",	"SummonFont",		SU_SummonShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FW.L.BAR_TEXTURE,		"",	"SummonTexture",	SU_SummonShow);
		
FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FW.L.SUMMON_ASSISTANT,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.UPDATE_INTERVAL_SUMMON,	"",	"SummonInterval");

FW.Default.SummonInterval = 1;

FW.Default.SummonFont = FW.Default.Font;
FW.Default.SummonFontSize = FW.Default.FontSize;
FW.Default.SummonTexture = FW.Default.Texture;
FW.Default.Summon = true;
FW.Default.SummonDetails = true;
FW.Default.SummonCloser = false;
FW.Default.SummonScale = 1;
FW.Default.SummonWidth = 100;
FW.Default.SummonHeight = 12;
FW.Default.SummonMax = 5;
FW.Default.SummonKeyword = true;
FW.Default.SummonKeywordMsg = "summon";
FW.Default.SummonExpand = false;
FW.Default.SummonSpace = 1;
FW.Default.SummonMeetingStone = false;
FW.Default.SummonOldMode = false;

FW.Default.ColorSummonClose = 	{0.60,0.60,0.60};
FW.Default.ColorSummonFar = 	{1.00,1.00,1.00};
FW.Default.ColorSummoning = 	{0.64,0.21,0.93};
FW.Default.ColorWhisper = 	{1.00,0.00,1.00};
FW.Default.ColorSummonBg = 	{0.55,0.00,0.88,0.75};
FW.Default.ColorSummonText = 	{1.00,1.00,1.00};