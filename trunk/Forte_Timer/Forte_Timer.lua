local FW = FW;
local ST = FW:Module("Timer");
local GetTime = GetTime;

local r, g, b, a;

local t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19;
local s1, s2, s3, s4, s5;

local NORMAL = 0;
local HIDDEN = 1;
local FADING = 2;
local REMOVE = 3;
local FAILED = 4;

local FADE_SHOW = {FW.L.SHORT_HIDE,FW.L.SHORT_FADE,FW.L.SHORT_REMOVED,FW.L.SHORT_RESISTED,FW.L.SHORT_IMMUNE,FW.L.SHORT_EVADED,FW.L.SHORT_REFLECTED};

local NUM_TIMERS = 15;

FW.ST = {};
local ActiveDots = {};
local FW_OnTimerFade = {};
local FW_OnTimerBreak = {};

local FW_RaidIconCoords  = {
	{0.00,0.25,0.00,0.25},
	{0.25,0.50,0.00,0.25},
	{0.50,0.75,0.00,0.25},
	{0.75,1.00,0.00,0.25},
	{0.00,0.25,0.25,0.50},
	{0.25,0.50,0.25,0.50},
	{0.50,0.75,0.25,0.50},
	{0.75,1.00,0.25,0.50}
}

--[[

FW.ST

1:Duration Timer
2:Last Timer Update
3:Duration of Spell
4:Target
5:Is Dot
6:Is Magic/Curse/Crowd Control etc
7:Texture
8:Name
9:Target Type (0:trash 1:boss 2:player)
10:belongs to your target
11:belongs to your focus
12:Expire msg given
13:Unique ID 
14:Timer state 0:normal 1:hiding 2:expired 3:removed 4+:failed
15:Timer fading size/alpha
16:Stacks or similar
17:Remove time
18:Filter
19:Raid target icon
]]


local SORT={
	TIMER =		{ORDER=	{1},		ASC={1}, 	ORDER2=	{13,1},		ASC2={1,1}},
}

--istype: 1=magic,2=curse,3=cc,4=pet,(5=powerup),6=enslave/charm,(7=tdebuff)
function FW:RegisterSpell(spell,hastarget, duration, isdot, istype, reducedinpvp, texture)
	FW.Track[spell]={hastarget,duration,isdot,istype,reducedinpvp,texture};
end

function FW:RegisterSpellModRank(spell,rank,mod)
	if not FW.Track[spell]["r"] then FW.Track[spell]["r"] = {};end
	FW.Track[spell]["r"][rank] = mod;
end

function FW:RegisterSpellModSetB(spell,setb,num,mod)
	if not FW.SetBonus[setb] then FW.SetBonus[setb] = 0; end
	if not FW.Track[spell]["s"] then FW.Track[spell]["s"] = {};end
	if not FW.Track[spell]["s"][setb] then FW.Track[spell]["s"][setb] = {};end
	FW.Track[spell]["s"][setb][num] = mod;
end

function FW:RegisterSpellModTlnt(spell,tal,num,mod)
	if not FW.Talent[tal] then FW.Talent[tal] = 0; end
	if not FW.Track[spell]["t"] then FW.Track[spell]["t"] = {};end
	if not FW.Track[spell]["t"][tal] then FW.Track[spell]["t"][tal] = {};end
	FW.Track[spell]["t"][tal][num] = mod;
end

function FW:RegisterBuff(buff,duration)
	FW.TrackBuffs[buff]=duration;
end

function FW:RegisterDebuff(debuff,duration,texture)
	FW.TrackDebuffs[debuff]={duration,texture};
end

local function ST_Exception(set)
	if UnitName("target") then
		FC_Saved.Exceptions[UnitName("target")] = set;
	end
end

local function ST_STSetExpandTexture()
	if FW.Settings.TimerExpand then
		FWSTFrameExpand:SetTexCoord(-0.25,1,-0.25,0,0.75,1,0.75,0);
	else
		FWSTFrameExpand:SetTexCoord(-0.25,0,-0.25,1,0.75,0,0.75,1);
	end
end

local function ST_STSetSideTexture()
	if FW.Settings.TimerTime then
		FWSTFrameSide:SetTexCoord(-0.25,1,-0.25,0,0.75,1,0.75,0);
		FWSTFrameSide:SetTexCoord(0,0, 1,0, 0,1, 1,1);
	else
		FWSTFrameSide:SetTexCoord(-0.25,0,-0.25,1,0.75,0,0.75,1);
		FWSTFrameSide:SetTexCoord(0,1, 1,1, 0,0, 1,0);
	end
end

local function ST_TimerLock()
	if FW.Settings.TimerDisableButtons then
		FWSTFrame:EnableMouse(false);
		FWSTFrameExpandButton:EnableMouse(false);
		FWSTFrameSideButton:EnableMouse(false);
	else
		FWSTFrame:EnableMouse(true);
		FWSTFrameExpandButton:EnableMouse(true);
		FWSTFrameSideButton:EnableMouse(true);
	end
end

local function ST_TimerShow()
	if FW.Settings.Timer then
		ST_TimerLock();
		FWSTFrame:Show();
		FWSTBars:Show();
		FWSTBackground:Show();
		FWSTFrame:SetScale(FW.Settings.TimerScale);
		FWSTBars:SetScale(FW.Settings.TimerScale);
		FWSTBackground:SetScale(FW.Settings.TimerScale);
		FWSTFrame:SetWidth(FW.Settings.TimerWidth+FW.BORDER*2);
		FWSTBars:SetWidth(FW.Settings.TimerWidth+FW.BORDER*2);
		FWSTBackground:SetBackdropColor(unpack(FW.Settings.ColorTimerBg));
		FWSTBackground:SetBackdropBorderColor(unpack(FW.Settings.ColorTimerBg));
		if not FW.Settings.TimerDisableButtons then
			FWSTTexture:Show();
			FWSTFrameTitle:Show();
			FWSTFrameExpand:Show();
			FWSTFrameSide:Show();
		else
			FWSTTexture:Hide();
			FWSTFrameTitle:Hide();
			FWSTFrameExpand:Hide();
			FWSTFrameSide:Hide();
		end
		FWSTFrameTitle:SetFont(FW.Settings.TimerFont,FW.Settings.TimerFontSize);
		for i=1,NUM_TIMERS,1 do
			getglobal("FWSTBar"..i):ClearAllPoints();
			getglobal("FWSTLabel"..i):ClearAllPoints();
			getglobal("FWSTBar"..i):SetWidth(FW.Settings.TimerWidth-FW.Settings.TimerHeight-1);
			getglobal("FWSTLabel"..i):SetWidth(FW.Settings.TimerWidth);
			getglobal("FWSTBar"..i):SetHeight(FW.Settings.TimerHeight);
			getglobal("FWSTBar"..i):SetStatusBarTexture(FW.Settings.TimerTexture);
			getglobal("FWSTBar"..i.."Back"):SetTexture(FW.Settings.TimerTexture);
			
			getglobal("FWSTBar"..i.."Button"):SetWidth(FW.Settings.TimerHeight);
			getglobal("FWSTBar"..i.."Button"):SetHeight(FW.Settings.TimerHeight);
			
			getglobal("FWSTBar"..i.."Time"):SetTextColor(unpack(FW.Settings.ColorTimerTime));
			
			getglobal("FWSTBar"..i.."Spark"):SetWidth(FW.Settings.TimerHeight);
			getglobal("FWSTBar"..i.."Spark"):SetHeight(FW.Settings.TimerHeight*2);
			
			getglobal("FWSTBar"..i.."RaidTargetIcon"):SetWidth(FW.Settings.TimerHeight);
			getglobal("FWSTBar"..i.."RaidTargetIcon"):SetHeight(FW.Settings.TimerHeight);
			getglobal("FWSTBar"..i.."RaidTargetIcon"):SetAlpha(FW.Settings.TimerRaidTargetsAlpha);
			
			getglobal("FWSTBar"..i.."Name"):SetFont(FW.Settings.TimerFont,FW.Settings.TimerFontSize);
			getglobal("FWSTBar"..i.."Time"):SetFont(FW.Settings.TimerFont,FW.Settings.TimerFontSize);
			getglobal("FWSTLabel"..i.."Text"):SetFont(FW.Settings.TimerLabelFont,FW.Settings.TimerLabelFontSize);
			
			if FW.Settings.TimerTime then 
				getglobal("FWSTBar"..i.."Time"):SetPoint("TOPRIGHT", getglobal("FWSTBar"..i), "TOPRIGHT", -1, 0);
				getglobal("FWSTBar"..i.."Time"):SetPoint("BOTTOMRIGHT", getglobal("FWSTBar"..i), "BOTTOMRIGHT", -1, 0);
				getglobal("FWSTBar"..i.."Time"):SetPoint("TOPLEFT", getglobal("FWSTBar"..i), "TOPRIGHT", -FW.Settings.TimerTimeSpace, 0);
				getglobal("FWSTBar"..i.."Time"):SetPoint("BOTTOMLEFT", getglobal("FWSTBar"..i), "BOTTOMRIGHT", -FW.Settings.TimerTimeSpace, 0);
				
				if FW.Settings.TimerMaximizeName then
					getglobal("FWSTBar"..i.."RaidTargetIcon"):SetPoint("CENTER", getglobal("FWSTBar"..i), "CENTER",(-FW.Settings.TimerTimeSpace-FW.Settings.TimerHeight)/2, 0);
					
					getglobal("FWSTBar"..i.."Name"):SetPoint("TOPLEFT", getglobal("FWSTBar"..i), "TOPLEFT", 1, 0);
					getglobal("FWSTBar"..i.."Name"):SetPoint("BOTTOMLEFT", getglobal("FWSTBar"..i), "BOTTOMLEFT", 1, 0);
				else
					getglobal("FWSTBar"..i.."RaidTargetIcon"):SetPoint("CENTER", getglobal("FWSTBar"..i), "CENTER",-FW.Settings.TimerHeight/2, 0);
					
					getglobal("FWSTBar"..i.."Name"):SetPoint("TOPLEFT", getglobal("FWSTBar"..i), "TOPLEFT",FW.Settings.TimerTimeSpace-FW.Settings.TimerHeight, 0);
					getglobal("FWSTBar"..i.."Name"):SetPoint("BOTTOMLEFT", getglobal("FWSTBar"..i), "BOTTOMLEFT",FW.Settings.TimerTimeSpace-FW.Settings.TimerHeight, 0);
				end
				
				getglobal("FWSTBar"..i.."Name"):SetPoint("TOPRIGHT", getglobal("FWSTBar"..i), "TOPRIGHT", -FW.Settings.TimerTimeSpace, 0);
				getglobal("FWSTBar"..i.."Name"):SetPoint("BOTTOMRIGHT", getglobal("FWSTBar"..i), "BOTTOMRIGHT", -FW.Settings.TimerTimeSpace, 0);
			else
				getglobal("FWSTBar"..i.."Time"):SetPoint("TOPLEFT", getglobal("FWSTBar"..i), "TOPLEFT", 1, 0);
				getglobal("FWSTBar"..i.."Time"):SetPoint("BOTTOMLEFT", getglobal("FWSTBar"..i), "BOTTOMLEFT", 1, 0);
				getglobal("FWSTBar"..i.."Time"):SetPoint("TOPRIGHT", getglobal("FWSTBar"..i), "TOPLEFT", FW.Settings.TimerTimeSpace, 0);
				getglobal("FWSTBar"..i.."Time"):SetPoint("BOTTOMRIGHT", getglobal("FWSTBar"..i), "BOTTOMLEFT", FW.Settings.TimerTimeSpace, 0);
				
				getglobal("FWSTBar"..i.."Name"):SetPoint("TOPLEFT", getglobal("FWSTBar"..i), "TOPLEFT", FW.Settings.TimerTimeSpace, 0);
				getglobal("FWSTBar"..i.."Name"):SetPoint("BOTTOMLEFT", getglobal("FWSTBar"..i), "BOTTOMLEFT", FW.Settings.TimerTimeSpace, 0);
				
				if FW.Settings.TimerMaximizeName then
					getglobal("FWSTBar"..i.."RaidTargetIcon"):SetPoint("CENTER", getglobal("FWSTBar"..i), "CENTER",(FW.Settings.TimerTimeSpace-FW.Settings.TimerHeight)/2, 0);
				
					getglobal("FWSTBar"..i.."Name"):SetPoint("TOPRIGHT", getglobal("FWSTBar"..i), "TOPRIGHT", -1, 0);
					getglobal("FWSTBar"..i.."Name"):SetPoint("BOTTOMRIGHT", getglobal("FWSTBar"..i), "BOTTOMRIGHT", -1, 0);
				else
				
					getglobal("FWSTBar"..i.."RaidTargetIcon"):SetPoint("CENTER", getglobal("FWSTBar"..i), "CENTER",-FW.Settings.TimerHeight/2, 0);

					getglobal("FWSTBar"..i.."Name"):SetPoint("TOPRIGHT", getglobal("FWSTBar"..i), "TOPRIGHT", -FW.Settings.TimerTimeSpace-FW.Settings.TimerHeight, 0);
					getglobal("FWSTBar"..i.."Name"):SetPoint("BOTTOMRIGHT", getglobal("FWSTBar"..i), "BOTTOMRIGHT", -FW.Settings.TimerTimeSpace-FW.Settings.TimerHeight, 0);
				end
			end	
		end
		if FW.Settings.TimerExpand == true then
			if not FW.Settings.TimerDisableButtons then
				FWSTBars:SetPoint("BOTTOMLEFT", FWSTFrame,"BOTTOMLEFT", 0, 0);
				FWSTLabel1:SetPoint("BOTTOMRIGHT", FWSTBars, "BOTTOMRIGHT",-FW.BORDER,19);
			else
				FWSTBars:SetPoint("BOTTOMLEFT", FWSTFrame,"BOTTOMLEFT", 0, 19-FW.BORDER);
				FWSTLabel1:SetPoint("BOTTOMRIGHT", FWSTBars, "BOTTOMRIGHT",-FW.BORDER,FW.BORDER);
			end
			for i=2,NUM_TIMERS,1 do
				getglobal("FWSTLabel"..i):SetPoint("BOTTOMRIGHT", getglobal("FWSTBar"..(i-1)), "TOPRIGHT", 0, 0);
			end
			for i=1,NUM_TIMERS,1 do
				getglobal("FWSTBar"..i):SetPoint("BOTTOMRIGHT", getglobal("FWSTLabel"..i), "TOPRIGHT", 0, 0);
			end
		else
			if not FW.Settings.TimerDisableButtons then
				FWSTBars:SetPoint("TOPLEFT", FWSTFrame,"TOPLEFT", 0, 0);
				FWSTLabel1:SetPoint("TOPRIGHT", FWSTBars, "TOPRIGHT",-FW.BORDER,-19);
			else
				FWSTBars:SetPoint("TOPLEFT", FWSTFrame,"TOPLEFT", 0, -19+FW.BORDER);
				FWSTLabel1:SetPoint("TOPRIGHT", FWSTBars, "TOPRIGHT",-FW.BORDER,-FW.BORDER);
			end
			for i=2,NUM_TIMERS,1 do
				getglobal("FWSTLabel"..i):SetPoint("TOPRIGHT", getglobal("FWSTBar"..(i-1)), "BOTTOMRIGHT", 0, 0);
			end
			for i=1,NUM_TIMERS,1 do
				getglobal("FWSTBar"..i):SetPoint("TOPRIGHT", getglobal("FWSTLabel"..i), "BOTTOMRIGHT", 0, 0);
			end
		end
		ST_STSetExpandTexture();
		ST_STSetSideTexture();
	else
		FWSTFrame:Hide();
		FWSTBars:Hide();
		FWSTBackground:Hide();
	end
end

local function ST_TimerScale()
	ST_TimerShow();
	FW:CorrectScale(FWSTFrame);
end

local function ST_Fade(i,t,instant)
	if FW:GET(FW.ST,i,14) ~= t then
		if instant then
			FW:SET(FW.ST,i,17,GetTime());
		else
			FW:SET(FW.ST,i,17,GetTime()+FW.Settings.TimerFadeTime);
		end
		FW:SET(FW.ST,i,14,t);
	end
end

local function ST_UpdateSpellTimers()
	local time = GetTime();
	local i = 1;
	
	while i <= FW:ROWS(FW.ST) do -- remove everything marked as self buff
		if FW:GET(FW.ST,i,6) == 5 then
			if FW:PlayerHasBuff(FW:GET(FW.ST,i,8)) then -- remove, will be re-added
				FW:REMOVE(FW.ST,i);
			else
				ST_Fade(i,FADING,true);
				i=i+1;
			end
		else
			i=i+1;
		end	
	end
	i = 1;
	while i <= FW:ROWS(FW.ST) do
		t1,t2,t3,t4,_,t6,_,t8,t9,_,_,t12,_,t14,t15,_,t17,_,t19 = FW:GET(FW.ST,i);
		t1=t1+t2-time;

		-- fade messages if time <= X sec
		if t12 == 0 and t14<=HIDDEN then -- marked as not expiring
			for index,f in ipairs(FW_OnTimerFade) do
				f(t4,t19,t8,t1,i);
			end
		end
		-- counting
		FW:SET(FW.ST,i,1, t1);
		FW:SET(FW.ST,i,2, time);
		
		if t14<=HIDDEN and t1<=0 then
			-- normal fade
			ST_Fade(i,FADING);
		end
		
		if t14==NORMAL then -- normal counting down
			if FW.Settings.TimerIgnoreLong and t3 >= 120 and t9~=1 and t6 <= 4 then -- hide long spells on trash
				FW:SET(FW.ST,i,14, HIDDEN);
				FW:SET(FW.ST,i,17, time+FW.Settings.TimerHideTime);
			end
			
			i=i+1;
		else -- special
			if t14 == HIDDEN and not FW.Settings.TimerIgnoreLong then
				FW:SET(FW.ST,i,14, NORMAL);
				t15=1;
			else
				if time <= t17 then
					t15=1;
				elseif FW.Settings.TimerFade and time<t17+FW.Settings.TimerFadeSpeed then 
					t15=1-math.pow( ((time-t17)/FW.Settings.TimerFadeSpeed),3);
				else
					t15=0;
				end	
			end
			
			if t15<=0 and t14~=HIDDEN then
				FW:REMOVE(FW.ST,i);
			else 
				FW:SET(FW.ST,i,15, t15);
				i=i+1;
			end
		end
	end
	-- add buffs!
	if FW.Settings.TimerBuff then
		i = 1;
		while true do
			t1 = GetPlayerBuffName(i);
			if not t1 then break; end
			if FW.TrackBuffs[t1] then
				FW:INSERT(FW.ST,GetPlayerBuffTimeLeft(i),time,FW.TrackBuffs[t1],t1,0,5,GetPlayerBuffTexture(i),t1,0,0,0,0,-2,0,1,GetPlayerBuffApplications(i),0,FW:GetFilterType(t1),0);
			end
			i=i+1;
		end
	end
end

local function ST_ClearMobTimers()
	--FW:ShowDebug("clear timer");
	local i = 1;
	while i <= FW:ROWS(FW.ST) do
		_,_,_,_,_,t6,_,t8,t9 = FW:GET(FW.ST,i);
		if t6 < 5 and t9 < 2 then -- remove all non-player timers except charms
			FW:REMOVE(FW.ST,i);
		else
			i=i+1;
		end
	end
end

local function ST_TargetChanged()

	local target = UnitName("target");
	if target then
	
		if UnitIsUnit("target","focus") then
			for i=1,FW:ROWS(FW.SelfQueue),1 do
				FW:SET(FW.SelfQueue,i,9, FW:GET(FW.SelfQueue,i,10));
			end
			for i=1,FW:ROWS(FW.ST),1 do
				FW:SET(FW.ST,i,10, FW:GET(FW.ST,i,11));
			end
		else
			for i=1,FW:ROWS(FW.SelfQueue),1 do
				if FW:GET(FW.SelfQueue,i,8) ~= 0 and FW:GET(FW.SelfQueue,i,5) == target then
					FW:SET(FW.SelfQueue,i,9, 1);
				else
					FW:SET(FW.SelfQueue,i,9, 0);
				end
			end	
			for i=1,FW:ROWS(FW.ST),1 do
				if FW:GET(FW.ST,i,9) ~= 0 and FW:GET(FW.ST,i,4) == target then
					FW:SET(FW.ST,i,10, 1);
				else
					FW:SET(FW.ST,i,10, 0);
				end
			end
		end
		local time = GetTime();
		for i=1,FW:ROWS(FW.ST),1 do
			t1,t2,_,_,_,_,_,t8,_,t10,t11,_,t13,t14 = FW:GET(FW.ST,i);
			t1 = t1 + t2 - time;
			if t10 == 0 then
				local left = FW:UnitHasYourDebuff("target",t8);
				
				if left and left-0.75 < t1 and left+0.75 > t1 then -- half of global cd lag margin
					--FW:Show(time-t1);

					if t13 == -1 then -- attempt to correct uncertain casts
						for j=1,FW:ROWS(FW.ST),1 do
							if FW:GET(FW.ST,j,10) == 1 and FW:GET(FW.ST,j,13) ~= -1 then
								FW:SET(FW.ST,i,13, FW:GET(FW.ST,j,13));
								break;
							end
						end
						if FW:GET(FW.ST,i,13) == -1 then FW:SET(FW.ST,i,13,  FW:GiveID(1,0)); end
						FW:SET(FW.ST,i,10, 1);
					else
						
						for j=1,FW:ROWS(FW.ST),1 do

							if FW:GET(FW.ST,j,13) == t13 then -- set all timers belonging to this id to target
								FW:SET(FW.ST,j,10, 1);
								if FW:GET(FW.ST,j,14) == HIDDEN then
									FW:SET(FW.ST,j,17, time+FW.Settings.TimerHideTime);
								end
							end

						end
					end
				end
			end
		end
	else
		for i=1,FW:ROWS(FW.SelfQueue),1 do
			FW:SET(FW.SelfQueue,i,9, 0);
		end
		for i=1,FW:ROWS(FW.ST),1 do
			FW:SET(FW.ST,i,10, 0);
		end	
	end
end

local function ST_FocusChanged()

	if UnitIsUnit("target","focus") then
		for i=1,FW:ROWS(FW.SelfQueue),1 do
			FW:SET(FW.SelfQueue,i,10, FW:GET(FW.SelfQueue,i,9));
		end
		for i=1,FW:ROWS(FW.ST),1 do
			FW:SET(FW.ST,i,11, FW:GET(FW.ST,i,10));
		end
	else
		for i=1,FW:ROWS(FW.SelfQueue),1 do
			FW:SET(FW.SelfQueue,i,10, 0);
		end		
		for i=1,FW:ROWS(FW.ST),1 do
			FW:SET(FW.ST,i,11, 0);
		end
	end
end

local function ST_BreakMessages(unit,mark,spell)
	for i, f in ipairs(FW_OnTimerBreak) do
		f(unit,mark,spell);
	end
end

local scanned = {};
local function ST_ScanUnitDebuffs(unit)
	local targetName = UnitName(unit);
	if not targetName or UnitIsUnit(unit,"target") or UnitIsUnit(unit,"focus") then return; end
	local time = GetTime();
	local done = true;
	for i=1,FW:ROWS(FW.ST) do
		if not scanned[i] then
			done=false;
			t1,t2,t3,t4,_,_,_,t8,t9,t10,t11,_,t13,t14,_,_,_,_,t19 = FW:GET(FW.ST,i);
			t1=t1+t2-time;
			if t14 <= HIDDEN and t10==0 and t11==0 and t3-t1 >= FW.Settings.BuffDelay and t1 > 0.75 then
				if t4==targetName then
					local t = FW:UnitHasYourDebuff(unit,t8);
					if t then 
						if t-0.75<t1 and t+0.75>t1 then
							-- i can do something here, by checking if this unit has one of your debuffs, and then checking for all other debuffs of this unit#
							scanned[i] = true;
							FW:SET(FW.ST,i,19, GetRaidTargetIndex(unit) or 0);
							for j=1,FW:ROWS(FW.ST) do
								if not scanned[j] then
									local s1,s2,s3,s4,_,_,_,s8,_,_,_,_,s13,s14,_,_,_,_,s19 = FW:GET(FW.ST,j);
									s1 = s1 + s2 - time;
									if s14 <= HIDDEN and s13 == t13 and s3-s1 >= FW.Settings.BuffDelay and s1 > 0.75 then
										scanned[j] = true;
										if not FW:UnitHasYourDebuff(unit,s8) then
											if not UnitIsDead(unit) then
												ST_BreakMessages(s4,s19,s8);
											end
											ST_Fade(j,REMOVE);
										end
									end
								end
							end
						end
					elseif t9>0 then -- unique and doesnt have buff, so remove
						scanned[i] = true;
						if not UnitIsDead(unit) then
							ST_BreakMessages(t4,t19,t8);
						end
						ST_Fade(i,REMOVE);
						--FW:ShowDebug("removed from unique unit: "..t8);
					end
				end
			else
				scanned[i] = true;
			end
		end
	end
	return done;
end

local function ST_RaidTargetScan()
	if not FW.Settings.TimerImproveRaidTarget then return;end
	FW:ERASE(scanned);
	if GetNumRaidMembers() > 0 then	
		for i=1,GetNumRaidMembers(),1 do
			if ST_ScanUnitDebuffs(FW.RAID[i].."target") then return; end
		end
	elseif GetNumPartyMembers() > 0 then
		for i=1,GetNumPartyMembers(),1 do
			if ST_ScanUnitDebuffs(FW.PARTY[i].."target") then return; end
		end
	end
end

local function ST_ScanTargetDebuffs()
	local time = GetTime();
	local i = 1;	
	local debuff,texture,count,left;
	local targetName = UnitName("target");
	local index;
	if targetName and UnitIsEnemy("target","player") then
		while true do
			debuff,_,texture,count,_,_,left = UnitDebuff("target",i);
			if debuff then
				--FW:Show(debuff.." "..texture.." "..count);
				if FW.TrackDebuffs[debuff] and FW.TrackDebuffs[debuff][2] == texture then
					index = FW:FIND2(FW.ST,texture,7,debuff,8);
					if index then
						if FW.ST[index+8] < count --[[ or FW.ST[index+5] == FADING]] then
							FW.ST[index-7] = FW.TrackDebuffs[debuff][1];
							FW.ST[index-6] = time;
							FW.ST[index+6] = NORMAL;
							FW.ST[index+7] = 1;
						end
						FW.ST[index+8] = count;
					else
						FW:INSERT(FW.ST,(FW.TrackDebuffs[debuff][1]),time,FW.TrackDebuffs[debuff][1],debuff,0,7,texture,debuff,0,0,0,0,-2,0,1,count,0,FW:GetFilterType(debuff),GetRaidTargetIndex("target") or 0);
					end
				end
				i=i+1;
			else
				break;
			end
		end
	end

	i=1;
	while i<= FW:ROWS(FW.ST) do
		t1,_,t3,t4,_,t6,t7,t8,_,t10,t11,_,t13,t14,_,_,_,_,t19 = FW:GET(FW.ST,i);
		
		if t14 <= HIDDEN then
			
			if t6 == 7 then -- remove target debuffs
				if not FW:UnitHasDebuff("target",t8,t7) then
					ST_Fade(i,FADING,true);
				end
				
			elseif t3-t1 >= FW.Settings.BuffDelay and t1 > 0.75 then -- debuff checking if the debuff is applied longer than/equal BuffDelay and remaining time > 0.75s
				if t6 == 6 then -- handle charm spells
					-- exceptions
					if t8 == FW.L.INFERNO then t8 = FW.L.ENSLAVE_DEMON;end

					if FW:UnitHasYourDebuff("pet",t8) then
						FW:SET(FW.ST,i,19, GetRaidTargetIndex("pet") or 0);
					else
						ST_BreakMessages(t4,t19,t8);
						ST_Fade(i,REMOVE);
					end

				elseif t13 == -1 then -- correct uncertain casts
					local focus = FW:UnitHasYourDebuff("focus",t8);
					--FW:Show("uncertain cast detected");
					if focus and focus-0.75<t1 and focus+0.75>t1 then -- if focus has the uncertain cast spell
						FW:SET(FW.ST,i,13, FW:GiveID(0,1) );
						FW:SET(FW.ST,i,10, 0);
						FW:SET(FW.ST,i,11, 1);
						FW:SET(FW.ST,i,19, GetRaidTargetIndex("focus") or 0);
					else
						local target = FW:UnitHasYourDebuff("target",t8);
						if target and target-0.75<t1 and target+0.75>t1 then
							FW:SET(FW.ST,i,13, FW:GiveID(1,0) );
							FW:SET(FW.ST,i,10, 1);
							FW:SET(FW.ST,i,11, 0);
							FW:SET(FW.ST,i,19, GetRaidTargetIndex("target") or 0);
						end
					end
					
				-- normal debuff checking
				elseif t10 == 1 then
					if FW:UnitHasYourDebuff("target",t8) then
						FW:SET(FW.ST,i,19, GetRaidTargetIndex("target") or 0);
					else
						if not UnitIsDead("target") then
							ST_BreakMessages(t4,t19,t8);
						end
						ST_Fade(i,REMOVE);
					end
					
				elseif t11 == 1 then
					if FW:UnitHasYourDebuff("focus",t8) then
						FW:SET(FW.ST,i,19, GetRaidTargetIndex("focus") or 0);
					else
						if not UnitIsDead("focus") then
							ST_BreakMessages(t4,t19,t8);
						end
						ST_Fade(i,REMOVE);
					end
				end
			end
		end
		i=i+1;
	end
end

local function ST_MobDies()
	for i=1,FW:ROWS(FW.ST),1 do
		if FW:GET(FW.ST,i,10) == 1 then
			if arg7 == FW:GET(FW.ST,i,4) then
				ST_ScanTargetDebuffs();-- scan the current target for debuffs now, should remove them if it's idd your target that died
			end
			break;
		end
	end
	if FW.Settings.TimerImproveRaidTarget then
		for i=1,FW:ROWS(FW.ST),1 do
			if FW:GET(FW.ST,i,10)==0 and FW:GET(FW.ST,i,11)==0 and arg7 == FW:GET(FW.ST,i,4) then
				if FW:GET(FW.ST,i,9)>0 then
					ST_RaidTargetScan();-- do a raid scan the moment a unique non target/focus unit dies
				end
				break;
			end
		end
	end
end

local function ST_RegisterImproved()
	FW:ERASE(ActiveDots);
end

local function ST_RemoveDots()
	if not FW.Settings.TimerImprove then return; end
	local i=1;
	local time = GetTime();
	
	while i<= FW:ROWS(ActiveDots) do
		t1,t2,t3 = FW:GET(ActiveDots,i);
		if t3 < time then
			FW:REMOVE(ActiveDots,i);
			for j=1,FW:ROWS(FW.ST),1 do
				_,_,_,t4,_,_,_,t8,_,t10,t11 = FW:GET(FW.ST,j);
				if t4 == t1 and t8 == t2 and t10~=1 and t11~=1 then
					ST_Fade(j,REMOVE);
				end
			end
			FW:ShowDebug("removing "..t2.." on "..t1);
		else
			i=i+1;
		end
	end
end


local function ColorVal(v,total,flag,flag2,filter,spell)
	
	if flag2 > REMOVE then
		if FW.Settings.TimerHighlightNew and v > -0.5 then
			r,g,b = FW:MixColors(-2*v,FW.Settings.ColorHighlight,FW.Settings.ColorFail);
		else
			r,g,b = unpack(FW.Settings.ColorFail);
		end
	elseif flag2 == REMOVE then
		r,g,b = unpack(FW.Settings.ColorFail);
	else	
		if FW.Settings.TimerHighlightNew and total-v<0.5 then
			if filter == FW.FILTER_COLOR then
				r,g,b = FW:MixColors2((total-v)*2,
				FW.Settings.ColorHighlight[1],FW.Settings.ColorHighlight[2],FW.Settings.ColorHighlight[3],
				FW.Settings.TimerFilter[spell][2],FW.Settings.TimerFilter[spell][3],FW.Settings.TimerFilter[spell][4]
				);
			else
				if flag == 1 then -- magic dot
					r,g,b = FW:MixColors((total-v)*2,FW.Settings.ColorHighlight,FW.Settings.ColorMagic);
				elseif flag == 2 then -- curses
					r,g,b = FW:MixColors((total-v)*2,FW.Settings.ColorHighlight,FW.Settings.ColorCurse);
				elseif flag == 3 or flag == 6 then --cc or charm
					r,g,b = FW:MixColors((total-v)*2,FW.Settings.ColorHighlight,FW.Settings.ColorCrowd);
				elseif flag == 4 then --pet 
					r,g,b = FW:MixColors((total-v)*2,FW.Settings.ColorHighlight,FW.Settings.ColorPet);
				elseif flag == 5 or flag == 7 then --powerup
					r,g,b = FW:MixColors((total-v)*2,FW.Settings.ColorHighlight,FW.Settings.ColorBuff);
				end
			end
		else
		 	if filter == FW.FILTER_COLOR then
				r,g,b = unpack(FW.Settings.TimerFilter[spell],2,4);
			else
				if flag == 1 then -- magic dot
					r,g,b = unpack(FW.Settings.ColorMagic);
				elseif flag == 2 then -- curses
					r,g,b = unpack(FW.Settings.ColorCurse);
				elseif flag == 3 or flag == 6 then --cc or charm
					r,g,b = unpack(FW.Settings.ColorCrowd);
				elseif flag == 4 then --pet 
					r,g,b = unpack(FW.Settings.ColorPet);
				elseif flag == 5 or flag == 7 then --powerup
					r,g,b = unpack(FW.Settings.ColorBuff);
				end
			end
		end
	end
	--alpha
	if FW.Settings.TimerBlink and v <= 3 and v>0 then
		a=0.25+0.25*math.cos(25*math.sqrt(v));
	else
		a=0.5;
	end
end

local function ST_DrawTimers()
	if not FWSTFrame:IsShown() then return; end
	
	local n = 0;
	if FW.Settings.TimerGroupID then FW:BST(FW.ST,SORT.TIMER.ORDER2,SORT.TIMER.ASC2);else FW:BST(FW.ST,SORT.TIMER.ORDER,SORT.TIMER.ASC);end
	local index=0;
	local lastid = -2;
	local higha = 0;
	local curra = 0;
	local highh = 0;
	local h1;
	local label;
	local Bar,Spark,Label;
	for i=1, NUM_TIMERS, 1 do

		Bar = getglobal("FWSTBar"..i);
		Label = getglobal("FWSTLabel"..i);
		index = index+1;
		while index <= FW:ROWS(FW.ST) do -- stuff to make it 'skip' certain timers for display
			t1,_,t3,t4,_,t6,t7,t8,t9,t10,t11,_,t13,t14,t15,t16,_,t18,t19 = FW:GET(FW.ST,index);
			if t15>0 and (t6 ~= 7 or FW.Settings.TimerDebuff) and t18~=FW.FILTER_HIDE and (not FW.Settings.TimerTarget or t13<=0 or t10==1 or t11==1) then break; else index=index+1 end
		end
		if index <= FW:ROWS(FW.ST) and i <= FW.Settings.TimerMax then
			
			Spark = getglobal("FWSTBar"..i.."Spark");
			ColorVal(t1,t3,t6,t14,t18,t8);
			
			if t19 == 0 or not FW.Settings.TimerRaidTargets then
				getglobal("FWSTBar"..i.."RaidTargetIcon"):Hide();
			else
				getglobal("FWSTBar"..i.."RaidTargetIcon"):Show();
				getglobal("FWSTBar"..i.."RaidTargetIcon"):SetTexCoord(unpack(FW_RaidIconCoords [t19]));
			end
			
			if t1<0 then Spark:Hide();t1=0;else Spark:Show();end
			Bar:SetValue(t1/t3);
			Bar.id = index;

			Bar:SetStatusBarColor(r,g,b);
			getglobal("FWSTBar"..i.."Back"):SetVertexColor(r,g,b,a);
			
			local lh;
			if i>1 and FW.Settings.TimerSpace > 0 then if i==2 then lh = FW.Settings.TimerSpace*h1; else lh = FW.Settings.TimerSpace*t15;end else lh = 0.01;end
			
			if t13<=0 or t10==1 or t14>REMOVE then curra=t15 else curra = FW.Settings.TimerNormalAlpha*t15; end
			Bar:SetAlpha(curra); 
			Label:Hide();
			if FW.Settings.TimerSpell then 
				if t13 >= 0 and FW.Settings.TimerGroupID then
				
					if lastid ~= t13 then
						if FW.Settings.TimerShowID and t13 > 0 and t9 == 0 then
							getglobal("FWSTLabel"..i.."Text"):SetText("#"..t13.." "..t4);
						else
							getglobal("FWSTLabel"..i.."Text"):SetText(t4);
						end
						if t10 == 1 then
							getglobal("FWSTLabel"..i.."Text"):SetTextColor(unpack(FW.Settings.ColorTimerTarget));
						elseif t11 == 1 then
							getglobal("FWSTLabel"..i.."Text"):SetTextColor(unpack(FW.Settings.ColorTimerFocus));
						else
							getglobal("FWSTLabel"..i.."Text"):SetTextColor(unpack(FW.Settings.ColorTimerNormal));
						end
						
						higha = curra;highh = t15;label = i;
						lh=FW.Settings.TimerLabelHeight*t15;
						Label:SetAlpha(higha);
						Label:Show();
					else
						if higha < curra then
							higha = curra;
							getglobal("FWSTLabel"..label):SetAlpha(higha);
						end
						if highh < t15 then
							n=n+(t15-highh)*FW.Settings.TimerLabelHeight;highh = t15;
							getglobal("FWSTLabel"..label):SetHeight(FW.Settings.TimerLabelHeight*highh);
						end
					end
				end
				t4 = t8;
			elseif FW.Settings.TimerGroupID and i>1 then
				if lastid ~= t13 then
					lh=FW.Settings.TimerSpacingHeight*t15;
					if i==2 then
						lh = FW.Settings.TimerSpacingHeight*h1;
						highh = h1; 
					else	
						lh = FW.Settings.TimerSpacingHeight*t15;
						highh = t15;
					end
					label = i;
				elseif label and (label~=2 or h1==1) then
					if highh < t15 then
						n=n+(t15-highh)*FW.Settings.TimerSpacingHeight;
						highh = t15;
						getglobal("FWSTLabel"..label):SetHeight(FW.Settings.TimerSpacingHeight*highh);
					end
				end
				
			end
			if i==1 then h1 = t15;end
			Label:SetHeight(lh);n=n+lh;
			
			if FW.Settings.TimerShowID and t13 > 0 and t9 == 0 and not FW.Settings.TimerSpell then
				getglobal("FWSTBar"..i.."Name"):SetText("#"..t13.." "..t4);
			elseif t16 ~= 0 then
				getglobal("FWSTBar"..i.."Name"):SetText(t4.." ("..t16..")");
			else
				getglobal("FWSTBar"..i.."Name"):SetText(t4);
			end
			Bar:SetHeight(t15*FW.Settings.TimerHeight);
			
			n = n + t15*FW.Settings.TimerHeight;
			
			if t10 == 1 then
				getglobal("FWSTBar"..i.."Name"):SetTextColor(unpack(FW.Settings.ColorTimerTarget));
			elseif t11 == 1 then
				getglobal("FWSTBar"..i.."Name"):SetTextColor(unpack(FW.Settings.ColorTimerFocus));
			else
				getglobal("FWSTBar"..i.."Name"):SetTextColor(unpack(FW.Settings.ColorTimerNormal));
			end
			if t14 > REMOVE then
				getglobal("FWSTBar"..i.."Time"):SetText(FADE_SHOW[t14]);
			else
				getglobal("FWSTBar"..i.."Time"):SetText(FW:SecToTimeD(t1));
			end
			getglobal("FWSTBar"..i.."ButtonTexture"):SetTexture(t7);
			
			Spark:SetPoint("CENTER", Bar, "LEFT",t1/t3*Bar:GetWidth(), 0);
			
			lastid = t13;
			
			Bar:Show();
		elseif Bar:IsShown() then
			Bar:Hide();
			Label:Hide();
		end
	end
	-- bar/bg positioning
	local y3 = n-1+FW.BORDER;
	local a1;
	if FW.Settings.TimerExpand == true then 
		a1 = "TOPLEFT";
	else
		y3 = -y3;
		a1 = "BOTTOMLEFT";
	end
	if n > 0 then
		FWSTBars:SetPoint(a1, FWSTFrame, a1, 0, y3);	
	else
		FWSTBars:SetPoint(a1, FWSTFrame, a1, 0, 0);
	end
	if FW.Settings.TimerDisableButtons then
		if n >= 10 then
			FWSTBackground:Show();
		else
			FWSTBackground:Hide();
		end
	end
end

local function ST_TimerFilterChange(spell,newtype)
	for i=1,FW:ROWS(FW.ST),1 do
		if FW:GET(FW.ST,i,8)  == spell then
			FW:SET(FW.ST,i,18, newtype or 0)
		end
	end
end

-- globally accessable

function FW:GetFadeTime(what)
	local _,_,t=string.find(FW.Settings[what.."Msg"],"([%.%d]+)");
	t = tonumber(t); return t or 0;
end

function FW:RemoveTimer_OnClick()
	FW:REMOVE(FW.ST,this:GetParent().id);
end

function FW:GiveID(istarget,isfocus)
	local high,id = 0,0;
	for i=1,FW:ROWS(FW.ST),1 do
		id = FW:GET(FW.ST,i,13);
		if high < id then high = id; end
		if (istarget == 1 and FW:GET(FW.ST,i,10) == 1) or (isfocus == 1 and FW:GET(FW.ST,i,11) == 1) then
			return id;
		end
	end
	return high+1;
end

function FW:STFrameExpand_OnClick()
	FW.Settings.TimerExpand = not FW.Settings.TimerExpand;
	PlaySound("igMainMenuOptionCheckBoxOn");
	ST_STSetExpandTexture();
	ST_TimerShow();
	FW:RefreshOptions();
end

function FW:STFrameSide_OnClick()
	FW.Settings.TimerTime = not FW.Settings.TimerTime;
	PlaySound("igMainMenuOptionCheckBoxOn");
	ST_STSetSideTexture();
	ST_TimerShow();
	FW:RefreshOptions();
end

function FW:STFrame_OnClick(button)
	if this.fwmovingx then return; end
	if button == "RightButton" then
		FW:ScrollTo(FW.L.SPELL_TIMER);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:AddDot(unit,spell)
	if not FW.Settings.TimerImprove then return; end
	FW:ShowDebug("adding dot "..spell.." to "..unit);
	local index = FW:FIND2(ActiveDots,unit,1,spell,2);
	if index then
		ActiveDots[index+1] = GetTime()+FW.Settings.DotTicksDelay;
	else
		FW:INSERT(ActiveDots, unit,spell,GetTime()+FW.Settings.DotInitDelay);
	end
end

function FW:GetFilterType(spell)
	if FW.Settings.TimerFilter[spell] then
		return FW.Settings.TimerFilter[spell][1];
	else
		return 0;
	end
end

function FW:RegisterOnTimerFade(func)
	tinsert(FW_OnTimerFade,func);
end

function FW:RegisterOnTimerBreak(func)
	tinsert(FW_OnTimerBreak,func);
end

local function ST_CombatLogEvent()
	if arg4 == FW.PLAYER then
		if arg2 == "SPELL_PERIODIC_DAMAGE" or arg2 == "SPELL_PERIODIC_MISSED" then
			if FW.Settings.TimerImprove then 
				FW:AddDot(arg7,arg10);
			end
		end		
	else
		if arg2 == "UNIT_DIED" then
			ST_MobDies();
		end
	end
end
	

function FW:TimerOnload()
	FW:RegisterFrame("FWSTFrame",ST_TimerShow,"Timer");
	
	FW:RegisterToEvent("PLAYER_TARGET_CHANGED",		ST_TargetChanged);
	FW:RegisterToEvent("PLAYER_FOCUS_CHANGED",		ST_FocusChanged);
	FW:RegisterToEvent("COMBAT_LOG_EVENT_UNFILTERED",	ST_CombatLogEvent);
	
	FW:RegisterVariablesEvent(function()
		ST_RegisterImproved();
		FW:RegisterTimedEvent("AnimationInterval",	ST_UpdateSpellTimers);
		FW:RegisterTimedEvent("SpellTimerInterval",	ST_ScanTargetDebuffs);
		FW:RegisterTimedEvent("SpellTimerInterval",	ST_RemoveDots);
		FW:RegisterTimedEvent("AnimationInterval",	ST_DrawTimers);
		FW:RegisterTimedEvent("UpdateInterval",		ST_RaidTargetScan);
	end);
	
	FW:RegisterOnLeaveCombat(function()
		if not UnitIsDeadOrGhost("player") then --  remove non-player timers when dropped from combat, keep if player died
			ST_ClearMobTimers();
		end
	end);
	FW.RegisterFilterRefresh(function()
		for i=1,FW:ROWS(FW.ST),1 do
			FW:SET(FW.ST,i,18, 0);
		end
		for spell, data in pairs(FW.Settings.TimerFilter) do
			ST_TimerFilterChange(spell,data[1])
		end
	end);
	FW:AddCommand("u",function(s)
		if s == "trash" then
			ST_Exception(0);
		elseif s == "boss" then
			ST_Exception(1);
		elseif s == "none" then
			ST_Exception(nil);
		end
	end);
	--FW:Show("Timer Module Loaded");
end

FW:SetMainCategory(FW.L.SPELL_TIMER,FW.ICON_ST,3,"TIMER","FWSTFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.ST_HINT1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.ST_HINT2);
		
	FW:SetSubCategory(FW.L.BASIC,FW.ICON_BASIC,2)
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ENABLE,		FW.L.ST_BASIC1_TT ,	"Timer",		ST_TimerShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.LOCK,		FW.L.ST_BASIC2_TT,	"TimerDisableButtons",	ST_TimerShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXPAND_UP,	FW.L.EXPAND_UP_TT,	"TimerExpand",		function() ST_TimerShow();ST_STSetExpandTexture();end);

	FW:SetSubCategory(FW.L.DISPLAY_MODES,FW.ICON_SPECIFIC,3)
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES1,	FW.L.DISPLAY_MODES1_TT,	"TimerBuff");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES2,	FW.L.DISPLAY_MODES2_TT,	"TimerDebuff");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES3,	FW.L.DISPLAY_MODES3_TT,	"TimerIgnoreLong");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DISPLAY_MODES4,	FW.L.DISPLAY_MODES4_TT,	"TimerHideTime");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES5,	FW.L.DISPLAY_MODES5_TT,	"TimerBarResists");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DISPLAY_MODES6,	FW.L.DISPLAY_MODES6_TT,	"TimerFailTime");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES7,	FW.L.DISPLAY_MODES7_TT,	"TimerGroupID");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES8,	FW.L.DISPLAY_MODES8_TT,	"TimerShowID");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES9,	FW.L.DISPLAY_MODES9_TT,	"TimerSpell");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.DISPLAY_MODES10,	FW.L.DISPLAY_MODES10_TT,"TimerTarget");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.FADING5,	FW.L.FADING5_TT,	"TimerHighlightNew");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.FADING6,	FW.L.FADING6_TT,	"TimerNormalAlpha");		
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.COUNTDOWN_ON_RIGHT,	FW.L.COUNTDOWN_ON_RIGHT_TT,	"TimerTime",		function() ST_TimerShow();ST_STSetSideTexture();end);
	
	FW:SetSubCategory(FW.L.FADING,FW.ICON_SPECIFIC,4)
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.FADING1,	FW.L.FADING1_TT,	"TimerBlink");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.FADING2,	FW.L.FADING2_TT,	"TimerFade");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.FADING3,	FW.L.FADING3_TT,	"TimerFadeTime");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.FADING4,	FW.L.FADING4_TT,	"TimerFadeSpeed");

	FW:SetSubCategory(FW.L.EXTRA,FW.ICON_SPECIFIC,5)
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXTRA1,	FW.L.EXTRA1_TT,		"TimerRaidTargets");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.EXTRA2,	FW.L.EXTRA2_TT,		"TimerRaidTargetsAlpha",ST_TimerShow);	
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXTRA3,	FW.L.EXTRA3_TT,		"TimerImprove",		ST_RegisterImproved);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXTRA4,	FW.L.EXTRA4_TT,		"TimerImproveRaidTarget");

	FW:SetSubCategory(FW.L.COLORING_FILTERING,FW.ICON_FILTER,6);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.HIGHLIGHT,		"",	"ColorHighlight");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FAIL,			"",	"ColorFail");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.MAGIC_DOT,		"",	"ColorMagic");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.CURSE,			"",	"ColorCurse");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.CC,			"",	"ColorCrowd");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.PET,			"",	"ColorPet");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.POWERUP_BUFFS,		"",	"ColorBuff");
		FW:RegisterOption(FW.FIL,2,FW.NON,FW.L.CUSTOMIZE,FW.L.ST_CUSTOMIZE_TT,	"TimerFilter",		ST_TimerFilterChange);

	FW:SetSubCategory(FW.L.SIZING,FW.ICON_SIZE,7);	
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_WIDTH,					"",	"TimerWidth",		ST_TimerShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_HEIGHT,					"",	"TimerHeight",		ST_TimerShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_SPACING,					"",	"TimerSpace",		ST_TimerShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SCALE,						"",	"TimerScale",		ST_TimerScale);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.UNIT_SPACING,		FW.L.UNIT_SPACING_TT,		"TimerSpacingHeight");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.UNIT_LABEL_HEIGHT,	FW.L.UNIT_LABEL_HEIGHT_TT,	"TimerLabelHeight");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.COUNTDOWN_WIDTH,		FW.L.COUNTDOWN_WIDTH_TT,		"TimerTimeSpace",	ST_TimerShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.MAXIMIZE_SPACE,		FW.L.MAXIMIZE_SPACE_TT,		"TimerMaximizeName",	ST_TimerShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.MAX_SHOWN,					"",	"TimerMax");	

	FW:SetSubCategory(FW.L.APPEARANCE,FW.ICON_APPEARANCE,8);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.NORMAL_TEXT,	FW.L.NORMAL_TEXT_TT,	"ColorTimerNormal");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.TARGET_TEXT,	FW.L.TARGET_TEXT_TT,	"ColorTimerTarget");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FOCUS_TEXT,	FW.L.FOCUS_TEXT_TT,	"ColorTimerFocus");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.COUNTDOWN_TEXT,			"",	"ColorTimerTime",	ST_TimerShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FRAME_BACKGROUND,		"",	"ColorTimerBg",		ST_TimerShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.BAR_FONT,			"",	"TimerFont",		ST_TimerShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.LABEL_FONT,	FW.L.LABEL_FONT_TT,	"TimerLabelFont",	ST_TimerShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FW.L.BAR_TEXTURE,			"",	"TimerTexture",		ST_TimerShow);

FW:SetMainCategory(FW.L.SELF_MESSAGES,FW.ICON_SELFMESSAGE,11,"DEFAULT");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.SELF_MESSAGES_HINT1);
		
	FW:SetSubCategory(FW.L.SPELL_TIMER,FW.ICON_SPECIFIC,2);
		FW:RegisterOption(FW.CHK,1,FW.LEF,FW.L.SHOW_FAILED,	FW.L.SHOW_FAILED_TT,	"TimerResists");
		FW:RegisterOption(FW.COL,1,FW.RIG,FW.L.FAILED_MESSAGE_COLOR,		"",	"ColorFailedMsg");

		
FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FW.L.SPELL_TIMER,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.UPDATE_INTERVAL_SPELL_TIMER,	"",	"SpellTimerInterval");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DELAY_TARGET_DEBUFF_CHECK,	"",	"BuffDelay");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DELAY_DOT_TICKS_INIT,		"",	"DotInitDelay");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DELAY_DOT_TICKS,			"",	"DotTicksDelay");

FW.Default.SpellTimerInterval = 0.10;
FW.Default.BuffDelay = 2; -- delay before checking if a buff is still applied (seems to be lag to server + slowness of server)
FW.Default.DotTicksDelay = 3.75; -- if no dot ticks are seen for this time, dots of this type and target are removed
FW.Default.DotInitDelay = 5; -- if no dot ticks are seen for this time after cast, dots of this type and target are removed

FW.Default.TimerDisableButtons = false;
FW.Default.TimerMax = 10;
FW.Default.TimerFont = FW.Default.Font;
FW.Default.TimerFontSize = FW.Default.FontSize;
FW.Default.TimerTexture = FW.Default.Texture;
FW.Default.Timer = true;
FW.Default.TimerShowID = false;
FW.Default.TimerGroupID = true;
FW.Default.TimerIgnoreLong = false;
FW.Default.TimerExpand = true;
FW.Default.TimerBackground = true;
FW.Default.TimerTime = true;
FW.Default.TimerResists = true;
FW.Default.TimerBarResists = true;
FW.Default.TimerBuff = true;
FW.Default.TimerDebuff = true;
FW.Default.TimerBlink = true;
FW.Default.TimerMaximizeName = false;
FW.Default.TimerFade = true;
FW.Default.TimerHighlightNew = true
FW.Default.TimerHideTime = 2;
FW.Default.TimerFailTime = 2;
FW.Default.TimerFadeTime = 1;
FW.Default.TimerFadeSpeed = 0.5;
FW.Default.TimerSpell = false;
FW.Default.TimerLabelHeight = 14;
FW.Default.TimerSpacingHeight = 3;
FW.Default.TimerLabelFont = FW.Default.Font;
FW.Default.TimerLabelFontSize = FW.Default.FontSize;
FW.Default.TimerImprove = false;
FW.Default.TimerImproveRaidTarget = false;
FW.Default.TimerRaidTargets = false;
FW.Default.TimerRaidTargetsAlpha = 0.7;
FW.Default.TimerTarget = false;

FW.Default.TimerHeight = 14;
FW.Default.TimerSpace = 1;
FW.Default.TimerScale = 1;
FW.Default.TimerWidth = 250;
FW.Default.TimerNormalAlpha = 0.50;
FW.Default.TimerTimeSpace = 35;

FW.Default.TimerFilter = {};

FW.Default.ColorCurse = 	{0.64,0.21,0.93};
FW.Default.ColorCrowd = 	{0.00,1.00,0.50};
FW.Default.ColorMagic = 	{1.00,0.50,0.00};
FW.Default.ColorPet = 		{1.00,0.00,0.95};
FW.Default.ColorBuff = 		{0.00,0.75,1.00};
FW.Default.ColorTimerNormal = 	{1.00,1.00,1.00};
FW.Default.ColorTimerTime = 	{1.00,1.00,1.00};
FW.Default.ColorTimerTarget = 	{1.00,1.00,1.00};
FW.Default.ColorTimerFocus = 	{1.00,1.00,0.50};
FW.Default.ColorTimerBg = 	{0.00,0.00,0.00,1.00};
FW.Default.ColorHighlight =	{1.00,1.00,1.00};
FW.Default.ColorFail =		{1.00,0.00,0.30};
