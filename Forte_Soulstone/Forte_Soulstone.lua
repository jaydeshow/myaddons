-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x
local FW = FW;
local SS = FW:Module("Soulstone");

local r, g, b, a;
local t1,t2,t3,t4,t5,t6,t7,t8;
local s1, s2, s3, s4, s5;

local NUM_SOULSTONES = 15;

local SYNC_REQUEST = "SYQ";
local SYNC_REPLY = "SYR";

local DI_TIME = 180;
local SS_RES = 360;
local SS_TIME = 1800;

local ipairs = ipairs;
local pairs = pairs;

local SSCast = 3; -- ss cast time in seconds, TONS OF HASTE FTL?

local CastQueue = {};
local ss = {};

local SORT={
	SOULSTONE =	{ORDER=	{4,1,2},	ASC={1,1,1}},
	CAST =		{ORDER=	{2},		ASC={1}},
}

FW.ORA_FLAGS = {
	FW.FLAG_DRUID,
	FW.FLAG_SHAMAN,
	FW.FLAG_WARLOCK,
	FW.FLAG_PALADIN
};

FW.COOLDOWN_TEXT = {
	[FW.FLAG_WARLOCK] = FW.L.FLAG_SOULSTONE,
	[FW.FLAG_DRUID] = FW.L.FLAG_REBIRTH,
	[FW.FLAG_PALADIN] = FW.L.FLAG_DIVINE_INTERVENTION,
	[FW.FLAG_SHAMAN] = FW.L.FLAG_ANKH
};


local function SS_IsResser(class)
	if class == "PALADIN" or  class == "SHAMAN" or  class == "PRIEST" then return 1;else return 0;end
end

local function SS_SetSSButton()
	t1 = FW:BestSoulstone();
	t2 = FW:GotSoulstone();
	if t2 and t2 == t1 then
		FWSSButton:SetNormalTexture("Interface\\AddOns\\Forte_Core\\Textures\\SS2");
		FWSSButton.title=string.format(FW.L.USE_,t1);
		FWSSButton.tip=string.format(FW.L.RIGHT_CLICK_TO_USE_,t1);
	else
		FWSSButton:SetNormalTexture("Interface\\AddOns\\Forte_Core\\Textures\\SS1");
		FWSSButton.title=string.format(FW.L.CREATE_,t1);
		FWSSButton.tip=string.format(FW.L.LEFT_CLICK_TO_CREATE_,t1);
	end
	if not InCombatLockdown() then -- update the use function in case it wasnt loaded properly due to combat or whatever
		FWSSButton:SetAttribute("*item2", t1 );
	end
end

local SoulstoneShow = nil;
local function SS_SoulstoneShow(auto) -- with auto set, will only refresh the frame if it's not hidden/shown properly yet
	if not auto then SoulstoneShow = 1;end
	if FW.Settings.Soulstone and (not FW.Settings.SoulstoneAuto or FC_Saved.PARTY or FC_Saved.RAID) then
	
		if (SoulstoneShow or not FWSSFrame:IsShown()) then
			
			FWSSBackground:ClearAllPoints();
			if not InCombatLockdown() then
				SoulstoneShow = nil;
				FWSSFrame:Show();
				FWSSBackground:Show();
				
				FWSSFrame:SetWidth(FW.Settings.SoulstoneWidth+2*FW.BORDER);
				FWSSFrame:SetScale(FW.Settings.SoulstoneScale);
			end
			
			FWSSBackground:SetWidth(FW.Settings.SoulstoneWidth+2*FW.BORDER);
			FWSSBackground:SetScale(FW.Settings.SoulstoneScale);

			FWSSBackground:SetBackdropColor(unpack(FW.Settings.ColorSoulstoneBg));
			FWSSBackground:SetBackdropBorderColor(unpack(FW.Settings.ColorSoulstoneBg));
			
			FWSSFrameAmount:SetFont(FW.Settings.SoulstoneFont,FW.Settings.SoulstoneFontSize);
			FWSSFrameTime:SetFont(FW.Settings.SoulstoneFont,FW.Settings.SoulstoneFontSize);
			
			r,g,b = unpack(FW.Settings.ColorSoulstoneText);
			
			for i=1,NUM_SOULSTONES,1 do
				getglobal("FWSSBar"..i):ClearAllPoints();
				
				getglobal("FWSSBar"..i.."Name"):SetFont(FW.Settings.SoulstoneFont,FW.Settings.SoulstoneFontSize);
				getglobal("FWSSBar"..i.."Time"):SetFont(FW.Settings.SoulstoneFont,FW.Settings.SoulstoneFontSize);
				getglobal("FWSSBar"..i.."Warlock"):SetFont(FW.Settings.SoulstoneFont,FW.Settings.SoulstoneFontSize);
				getglobal("FWSSBar"..i.."Cooldown"):SetFont(FW.Settings.SoulstoneFont,FW.Settings.SoulstoneFontSize);
			
				getglobal("FWSSBar"..i):SetWidth(FW.Settings.SoulstoneWidth);
				getglobal("FWSSBar"..i):SetHeight(FW.Settings.SoulstoneHeight);
				getglobal("FWSSBar"..i):SetStatusBarTexture(FW.Settings.SoulstoneTexture);
				getglobal("FWSSBar"..i.."Back"):SetTexture(FW.Settings.SoulstoneTexture);

				getglobal("FWSSBar"..i.."Name"):SetTextColor(r,g,b);
				getglobal("FWSSBar"..i.."Warlock"):SetTextColor(r,g,b);
				getglobal("FWSSBar"..i.."Cooldown"):SetTextColor(r,g,b);
				getglobal("FWSSBar"..i.."Time"):SetTextColor(r,g,b);

				getglobal("FWSSBar"..i.."Spark"):SetWidth(FW.Settings.SoulstoneHeight);
				getglobal("FWSSBar"..i.."Spark"):SetHeight(FW.Settings.SoulstoneHeight*2);
			end
			if FW.Settings.SoulstoneExpand then
				FWSSBackground:SetPoint("BOTTOMRIGHT", FWSSFrame, "BOTTOMRIGHT", 0, 0);
				FWSSBar1:SetPoint("BOTTOMLEFT", FWSSBackground, "BOTTOMLEFT", FW.BORDER, 18);
				
				for i=2,NUM_SOULSTONES,1 do
					getglobal("FWSSBar"..i):SetPoint("BOTTOMLEFT", getglobal("FWSSBar"..(i-1)), "TOPLEFT", 0, FW.Settings.SoulstoneSpace);
				end
			else
				FWSSBackground:SetPoint("TOPLEFT", FWSSFrame, "TOPLEFT", 0, 0);
				FWSSBar1:SetPoint("TOPLEFT", FWSSBackground, "TOPLEFT", FW.BORDER, -18);
				
				for i=2,NUM_SOULSTONES,1 do
					getglobal("FWSSBar"..i):SetPoint("TOPLEFT", getglobal("FWSSBar"..(i-1)), "BOTTOMLEFT", 0, -FW.Settings.SoulstoneSpace);
				end
			end
		end
	else
		if (SoulstoneShow or FWSSFrame:IsShown()) and not InCombatLockdown() then
			SoulstoneShow = nil;
			FWSSFrame:Hide();
			FWSSBackground:Hide();
		end
	end
end

local function SS_SoulstoneScale()
	SS_SoulstoneShow();
	FW:CorrectScale(FWSSFrame);
end

local function ColorVal(v,flag,flag2)
	if flag2 == FW.FLAG_NORMAL then
	
		if flag == FW.FLAG_RES then
			r,g,b = unpack(FW.Settings.ColorReady);
		elseif flag == FW.FLAG_TIME then
			r,g,b = FW:MixColors(v,FW.Settings.ColorSoulstoneMin,FW.Settings.ColorSoulstoneMax);
		elseif flag == FW.FLAG_WARLOCK then
			r,g,b = unpack(FW.Settings.ColorWarlock);
		elseif flag == FW.FLAG_DRUID then
			r,g,b = unpack(FW.Settings.ColorDruid);
		elseif flag == FW.FLAG_PALADIN then
			r,g,b = unpack(FW.Settings.ColorPaladin);
		elseif flag == FW.FLAG_SHAMAN then
			r,g,b = unpack(FW.Settings.ColorShaman);
		end
		
	elseif flag2 == FW.FLAG_DI then
	
		if flag == FW.FLAG_TIME or flag == FW.FLAG_DI then
			r,g,b = unpack(FW.Settings.ColorReady);
		elseif flag == FW.FLAG_WARLOCK then
			r,g,b = unpack(FW.Settings.ColorWarlock);
		elseif flag == FW.FLAG_DRUID then
			r,g,b = unpack(FW.Settings.ColorDruid);
		elseif flag == FW.FLAG_PALADIN then
			r,g,b = unpack(FW.Settings.ColorPaladin);
		elseif flag == FW.FLAG_SHAMAN then
			r,g,b = unpack(FW.Settings.ColorShaman);
		end

	elseif flag2 == FW.FLAG_DEAD then

		if flag == FW.FLAG_WARLOCK then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorDead,FW.Settings.ColorWarlock);
		elseif flag == FW.FLAG_DRUID then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorDead,FW.Settings.ColorDruid);
		elseif flag == FW.FLAG_PALADIN then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorDead,FW.Settings.ColorPaladin);
		elseif flag == FW.FLAG_SHAMAN then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorDead,FW.Settings.ColorShaman);
		end
		
	elseif flag2 == FW.FLAG_OFFLINE then

		if flag == FW.FLAG_TIME then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorOffline,FW.Settings.ColorSoulstoneMax);
		elseif flag == FW.FLAG_WARLOCK then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorOffline,FW.Settings.ColorWarlock);
		elseif flag == FW.FLAG_DRUID then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorOffline,FW.Settings.ColorDruid);
		elseif flag == FW.FLAG_PALADIN then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorOffline,FW.Settings.ColorPaladin);
		elseif flag == FW.FLAG_SHAMAN then
			r,g,b = FW:MixColors(FW.Settings.Mix,FW.Settings.ColorOffline,FW.Settings.ColorShaman);
		end
	end
end

local function SS_DrawDetails()
	if not FWSSFrame:IsShown() then return; end
	local n = 0;
	local Bar,Spark;
	for i=1, NUM_SOULSTONES, 1 do
		Bar = getglobal("FWSSBar"..i);
		
		if FW.Settings.Details and i <= FW.Settings.SoulstoneMax and i <= FW:ROWS(ss) then
			t1,t2,t3,t4,t5,_,t7,t8 = FW:GET(ss,i);
			
			Spark = getglobal("FWSSBar"..i.."Spark");
			ColorVal(t1,t4,t8);
			
			if FW.Settings.ShowReady then -- swap the value on cooldown bars, but keep color the same
				if t4 ~= FW.FLAG_TIME and t4 ~= FW.FLAG_RES and t4 ~= FW.FLAG_DI then
					t1=1-t1;
				end
			end
			Bar:SetValue(t1);
			
			Bar:SetStatusBarColor(r,g,b);
			getglobal("FWSSBar"..i.."Back"):SetVertexColor(r,g,b,0.5);
			
			getglobal("FWSSBar"..i.."Name"):SetText(t2);
			getglobal("FWSSBar"..i.."Time"):SetText(t3);
			getglobal("FWSSBar"..i.."Warlock"):SetText(t5);
			getglobal("FWSSBar"..i.."Cooldown"):SetText(t7);
			
			Spark:SetPoint("CENTER", Bar, "LEFT", t1*Bar:GetWidth(), 0);
			
			n = n + 1;
			Bar:Show();
		elseif Bar:IsShown() then
			Bar:Hide();
		end
	end
	if n>0 then
		FWSSBackground:SetHeight(21+(FW.Settings.SoulstoneHeight+FW.Settings.SoulstoneSpace)*n-FW.Settings.SoulstoneSpace);
	else
		FWSSBackground:SetHeight(20);
	end
end

local function SS_ProcessSoulstone()
	if FWSSFrame:IsShown() then--does not hide in combat!
		FW:ERASE(ss);
		for name, data in pairs(FC_Saved.Timers) do -- translate to viewable data

			if data[2] == FC_Saved.Update then -- only display ppl currently in the party/raid, meaning only updated entries, but i still want to track someone that left with ss on
				t1=data[1];
				if data[3] == FW.FLAG_RES then t2=data[1]/SS_RES; elseif data[3] == FW.FLAG_DI then t2=data[1]/DI_TIME;else t2=data[1]/SS_TIME; end
				t1 = FW:SecToTime(t1);
				if FC_Saved.Warlocks[data[4]] then t3 = FC_Saved.Warlocks[data[4]][1];else t3=0; end -- mouseover cd time for the warlock
				t3 = FW:SecToTime(t3);

				FW:INSERT(ss, t2,name,t1,data[3],"<"..data[4]..">",data[5],t3,data[6]);
			end
		end

		for name, data in pairs(FC_Saved.Warlocks) do
			if data[2] == FC_Saved.Update and (not FC_Saved.Timers[data[3]] or FC_Saved.Timers[data[3]][2] ~= FC_Saved.Update) then
				t2,t1 = data[1]/SS_TIME,data[1];
				t1 = FW:SecToTime(t1);
				FW:INSERT(ss, t2,name,t1,FW.FLAG_WARLOCK,FW.COOLDOWN_TEXT[FW.FLAG_WARLOCK],0,t1,data[4]);
			end
		end
		if FW.Settings.ShowAll then
			for name, data in pairs(FC_Saved.Cooldowns) do
				if data[2] == FC_Saved.Update then
					t2,t1 = data[1]/data[3],data[1];
					t1 = FW:SecToTime(t1);
					FW:INSERT(ss, t2,name,t1,data[4],FW.COOLDOWN_TEXT[data[4]],0,t1,data[5]);
				end
			end
		end
		for name, data in pairs(FW.Ready) do
			if data[2] ~= -1 then
				if data[3] or data[1] == FW.FLAG_WARLOCK then t1=FW.L.SHORT_READY;else t1="??";end
				FW:INSERT(ss, 0,name,t1,data[1],FW.COOLDOWN_TEXT[data[1]],0,t1,data[2]);
			end
		end

		FW:BST(ss,SORT.SOULSTONE.ORDER,SORT.SOULSTONE.ASC); -- sort viewable data

		s1, s2, s3, s4, s5 = 0,0,"","","ffffff";
		for i=1, FW:ROWS(ss), 1 do
			_,_,t3,t4,_,t6 = FW:GET(ss,i);
			if t4 == FW.FLAG_TIME then 
				s2 = s2 + 1; s1 = s1 + 1; 
				if s3 == "" then s3 = t3; end
			elseif t4 == FW.FLAG_RES or t4 == FW.FLAG_DI then 
				s1 = s1 + 1; 
			end
			if t6 == 1 then s5 = "00ff00";end -- resser

		end
		if s2 > 1 then
			for i=FW:ROWS(ss), 1, -1 do
				if FW:GET(ss,i,4) == FW.FLAG_TIME then s4 = FW:GET(ss,i,3); break; end
			end
		end
		local str = ""; if s3~="" then str=str.." "..s3;end if s4~="" then str=str.."-"..s4;end if str=="" then if s2==s1 then str=FW.L.NO_SS_UP;else str=FW.L.READY_TO_RES;end end
		FWSSFrameAmount:SetText("|cff"..s5.."x"..s1.."|r");
		FWSSFrameTime:SetText(str);

		SS_DrawDetails();
		SS_SetSSButton();
	end
end

local function SS_ShowCooldown(class)
	if class == "PALADIN" then
		return FW.FLAG_PALADIN;
	elseif class == "SHAMAN"then
		return FW.FLAG_SHAMAN;
	elseif class == "DRUID" then 
		return FW.FLAG_DRUID;
	elseif class == "WARLOCK" then
		return FW.FLAG_WARLOCK;
	end
end

local function SS_CastStart(player) -- this player started casting ss, still using addon msg for this atm 
	FW:INSERT(CastQueue,player,GetTime());
end

local function SS_CastDelay(player,delay) -- this player got delayed while casting a ss, only received from players with addon atm 
	for i=FW:ROWS(CastQueue),1,-1 do

		if FW:GET(CastQueue,i,1) == player then
		
			--FW:ShowDebug("SS cast by "..player.." now delayed by "..delay/1000);
			FW:SET(CastQueue,i,2, FW:GET(CastQueue,i,2) + delay/1000);
			FW:BST(CastQueue,SORT.CAST.ORDER,SORT.CAST.ASC);
			break;
		end
	end
end

local function SS_CastCancel(player) -- this player cancelled casting a ss, only received from players with addon atm
	for i=FW:ROWS(CastQueue),1,-1 do
		if FW:GET(CastQueue,i,1) == player then
			--FW:ShowDebug("SS cast by "..player.." now cancelled");
			FW:REMOVE(CastQueue,i);
			break;
		end
	end
end

local function SS_CastEnd(player) -- this player gained a ss, still using this instead of buffs because it also sometimes works for overriding soulstones

	while FW:ROWS(CastQueue) > 0 do
		t1,t2=FW:GET(CastQueue,1);
		if GetTime() - t2 <= SSCast + FW.Settings.SSDelay then -- cast time 3 sec, 2 sec lag at most
			if GetTime() - t2 >= SSCast - FW.Settings.SSDelay then
				FC_Saved.Warlocks[t1] = {SS_TIME,GetTime(),player,FW.FLAG_NORMAL};
				
				--FW:ShowDebug("SS cast on "..player.." by "..CastQueue[1][1]..".");
				FW:REMOVE(CastQueue,1);	
			--else --too new to belong to this cast, 2 sec lag at most
				--FW:ShowDebug("SS cast too fast to make sense");
			end
			break; -- stop checking
		else
			--FW:ShowDebug("SS cast too late to make sense");
			FW:REMOVE(CastQueue,1); -- remove too old
		end
	end
end

local function SS_TimerExpired(name)
	if FC_Saved.Timers[name][4] ~= FW.L.UNKNOWN then -- if this timer has a known warlock, remove this player from the warlock
		if FC_Saved.Warlocks[FC_Saved.Timers[name][4]] then
			FC_Saved.Warlocks[FC_Saved.Timers[name][4]][3] = FW.L.NOBODY;
		end
	end
	FC_Saved.Timers[name] = nil; -- remove this ss timer
end

local function SS_SoulstoneScan(unit,unitName,unitClass,flag,update)
	--FW:Show(unit.." "..unitName.." "..unitClass);
	if flag == FW.FLAG_OFFLINE then
		if FC_Saved.Timers[unitName] then
			if FC_Saved.Timers[unitName][3] == FW.FLAG_RES then
				SS_TimerExpired(unitName); -- you cant use ss when you are offline, ss expired
			else
				-- dont update the timer, timer paused for offline player
				FC_Saved.Timers[unitName][6] = flag;
			end
		end
	else
		if flag == FW.FLAG_NORMAL and FW:UnitHasBuff(unit,FW.L.BUFF_DIVINE_INTERVENTION) then
			flag = FW.FLAG_DI 
		end
		
		if FW:UnitHasBuff(unit,FW.L.BUFF_SOULSTONE) then
			if not FC_Saved.Timers[unitName] then
				SS_CastEnd(unitName);
				FC_Saved.Timers[unitName] = {SS_TIME,update,FW.FLAG_TIME,FW.L.UNKNOWN,SS_IsResser(unitClass),FW.FLAG_NORMAL}; -- timer, last update, flag, caster, isresser
			else
				FC_Saved.Timers[unitName][3] = FW.FLAG_TIME;
				
				if flag == FW.FLAG_DI and FC_Saved.Timers[unitName][6] ~= FW.FLAG_DI then
					if FW.Settings.SoulstoneMsg then
						FW:Show(string.format(FW.L.DI_GAIN,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
					end
				elseif flag ~= FW.FLAG_DI and FC_Saved.Timers[unitName][6] == FW.FLAG_DI then
					if FW.Settings.SoulstoneMsg then
						FW:Show(string.format(FW.L.DI_FADE,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
					end
				end
				
				FC_Saved.Timers[unitName][6] = flag;
				
				if UnitIsUnit(unit,"player") then -- set own timer according to player buff timer
					t1 = FW:PlayerHasBuff(FW.L.BUFF_SOULSTONE);if t1 then FC_Saved.Timers[unitName][1] = GetPlayerBuffTimeLeft(t1);else FC_Saved.Timers[unitName][1] = 0;end
				else
					FC_Saved.Timers[unitName][1] = FC_Saved.Timers[unitName][1] + FC_Saved.Timers[unitName][2] - update; -- should keep the timer 'running' while you are offline
				end
				
				if FC_Saved.Timers[unitName][1] < 0 then FC_Saved.Timers[unitName][1] = 0; end
			end
			
		elseif flag == FW.FLAG_DI then
			if not FC_Saved.Timers[unitName] then
				FC_Saved.Timers[unitName] = {DI_TIME,update,FW.FLAG_DI,FW.L.UNKNOWN,SS_IsResser(unitClass),FW.FLAG_DI}; -- timer, last update, flag, caster, isresser
			
				if FW.Settings.SoulstoneMsg then
					FW:Show(string.format(FW.L.DI_GAIN,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
				end
			else
				FC_Saved.Timers[unitName][3] = FW.FLAG_DI;
				FC_Saved.Timers[unitName][6] = FW.FLAG_DI;
				FC_Saved.Timers[unitName][1] = FC_Saved.Timers[unitName][1] + FC_Saved.Timers[unitName][2] - update;
				if FC_Saved.Timers[unitName][1] < 0 then FC_Saved.Timers[unitName][1] = 0; end
			end		
		
		else
			if FC_Saved.Timers[unitName] then			
				if UnitIsDead(unit) or FW:UnitHasBuff(unit,FW.L.BUFF_SPIRIT_OF_REDEMPTION) then -- ss can be used to res
					
					if FC_Saved.Timers[unitName][3] ~= FW.FLAG_RES then
						-- message
						if FW.Settings.SoulstoneMsg then
							if FC_Saved.Timers[unitName][4] ~= FW.L.UNKNOWN then
								if FC_Saved.Timers[unitName][4] == FW.PLAYER then
									FW:Show(string.format(FW.L.SS_DIED_YOUR,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
								else
									FW:Show(string.format(FW.L.SS_DIED_OTHER,unitName,FC_Saved.Timers[unitName][4]),unpack(FW.Settings.ColorSoulstoneMsg));
								end
							else
								FW:Show(string.format(FW.L.SS_DIED,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
							end
						end
						-- end of message
						FC_Saved.Timers[unitName][1] = SS_RES;
						FC_Saved.Timers[unitName][3] = FW.FLAG_RES;
					end
					
					FC_Saved.Timers[unitName][1] = FC_Saved.Timers[unitName][1] + FC_Saved.Timers[unitName][2] - update;
					if FC_Saved.Timers[unitName][1] < 0 then FC_Saved.Timers[unitName][1] = 0; end
					
				elseif UnitIsEnemy(unit,"player") or UnitIsCharmed(unit) or UnitIsCharmed("player") then -- avoid weird stuff
				
					FC_Saved.Timers[unitName][1] = FC_Saved.Timers[unitName][1] + FC_Saved.Timers[unitName][2] - update; -- should keep the timer 'running'
					if FC_Saved.Timers[unitName][1] < 0 then FC_Saved.Timers[unitName][1] = 0; end
					
				else
					if FC_Saved.Timers[unitName][3] == FW.FLAG_TIME then
						-- message
						if FW.Settings.SoulstoneMsg then
							if FC_Saved.Timers[unitName][4] ~= FW.L.UNKNOWN then
								if FC_Saved.Timers[unitName][4] == FW.PLAYER then
									FW:Show(string.format(FW.L.SS_EXPIRE_YOUR,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
								else
									FW:Show(string.format(FW.L.SS_EXPIRE_OTHER,FC_Saved.Timers[unitName][4],unitName),unpack(FW.Settings.ColorSoulstoneMsg));
								end
							else
								FW:Show(string.format(FW.L.SS_EXPIRE,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
							end
						end
						-- end of message
					elseif FC_Saved.Timers[unitName][6] == FW.FLAG_DI then
						if FW.Settings.SoulstoneMsg then
							FW:Show(string.format(FW.L.DI_FADE,unitName),unpack(FW.Settings.ColorSoulstoneMsg));
						end
					end
					SS_TimerExpired(unitName);
				end
			end	
		end
	end
	if FC_Saved.Timers[unitName] then FC_Saved.Timers[unitName][2] = update; end
end

local function SS_WarlockScan(unit,unitName,unitClass,flag,update)
	if FC_Saved.Warlocks[unitName] then
		FC_Saved.Warlocks[unitName][1] = FC_Saved.Warlocks[unitName][1] + FC_Saved.Warlocks[unitName][2] - update;
		FC_Saved.Warlocks[unitName][2] = update;
		
		if  FC_Saved.Timers[FC_Saved.Warlocks[unitName][3]] and FC_Saved.Timers[FC_Saved.Warlocks[unitName][3]][4] ~= unitName then -- the current warlock set to this player is not this warlock
			if FC_Saved.Warlocks[FC_Saved.Timers[FC_Saved.Warlocks[unitName][3]][4]] then -- if the old warlock that casted exists
				FC_Saved.Warlocks[FC_Saved.Timers[FC_Saved.Warlocks[unitName][3]][4]][3] = FW.L.NOBODY; -- set the old warlock's target to nobody
			end
			FC_Saved.Timers[FC_Saved.Warlocks[unitName][3]][4] = unitName;
		end

		if FC_Saved.Warlocks[unitName][1] < 0 then --  remove warlock if his cooldown is done
			FC_Saved.Warlocks[unitName] = nil;
		else				
			FC_Saved.Warlocks[unitName][4] = flag;
		end
	end
end

local function SS_CooldownScan(unit,unitName,unitClass,flag,update)
	if FC_Saved.Cooldowns[unitName] then
		FC_Saved.Cooldowns[unitName][1] = FC_Saved.Cooldowns[unitName][1] + FC_Saved.Cooldowns[unitName][2] - update;
		FC_Saved.Cooldowns[unitName][2] = update;

		if FC_Saved.Cooldowns[unitName][1] < 0 then --  remove cooldown if his cooldown is done doh
			FC_Saved.Cooldowns[unitName] = nil;
		else
			FC_Saved.Cooldowns[unitName][5] = flag;
		end
	end
end

local function SS_ReadyScan(unit,unitName,unitClass,flag,update)
	if FW.Settings.ShowReady then
		if not FC_Saved.Cooldowns[unitName] and not FC_Saved.Warlocks[unitName] and SS_ShowCooldown(unitClass) and (FW.Settings.ShowAll and FC_Saved.RAID or SS_ShowCooldown(unitClass) == FW.FLAG_WARLOCK) then
			if not FW.Ready[unitName] then
				FW.Ready[unitName] = {SS_ShowCooldown(unitClass),FW.FLAG_NORMAL,true};
			end
			FW.Ready[unitName][2] = flag;
			FW.Ready[unitName][3] = FC_Saved.GotORA[unitName];
		end
	end
end

local function SS_CertainCast(player,target) -- player just finished casting ss on this target, for players with addon
	SS_CastCancel(player);
	--FW:ShowDebug("calling certain by "..player.." on "..target);
	FC_Saved.Warlocks[player] = {SS_TIME,GetTime(),target,FW.FLAG_NORMAL};
	if FC_Saved.Timers[target] then 
		FC_Saved.Timers[target][1] = SS_TIME;
		FC_Saved.Timers[target][2] = GetTime();
		FC_Saved.Timers[target][3] = FW.FLAG_TIME;
	end
end
local function SS_GetTimers()
	FW:SendData(SYNC_REQUEST);
end

local function SS_ReceivedTimer(msg)
	t1,t2,t3,t4,t5,t6 = strsplit(" ",msg);
	
	if t1 == "T" then
		if not FC_Saved.Timers[t2] or (FC_Saved.Timers[t2][4] == FW.L.UNKNOWN and t5 ~= FW.L.UNKNOWN) then
			FC_Saved.Timers[t2] = {tonumber(t3),GetTime(),tonumber(t4),t5,tonumber(t6),FW.FLAG_NORMAL}; -- timer, last update, flag, caster, isresser
		end
	elseif t1 == "W" then
		if not FC_Saved.Warlocks[t2] or (FC_Saved.Warlocks[t2][3] == FW.L.NOBODY and t4 ~= FW.L.NOBODY) then
			FC_Saved.Warlocks[t2] = {tonumber(t3),GetTime(),t4,FW.FLAG_NORMAL}; -- timer, last update, target
		end
	elseif t1 == "C" then
		if not FC_Saved.Cooldowns[t2] then
			FC_Saved.Cooldowns[t2] = {tonumber(t3),GetTime(),tonumber(t4),tonumber(t5),FW.FLAG_NORMAL}; -- timer, last update
		end
	end
end

local function SS_SendTimers()
	-- of course sends the timers as they should be right now
	local time;
	local now = GetTime();
	for name, data in pairs(FC_Saved.Timers) do
		time = data[1]+data[2]-now; 
		if time > 0 then
			FW:SendData(SYNC_REPLY.."T "..name.." "..string.format("%.1f",time).." "..data[3].." "..data[4].." "..data[5]);
		end
	end
	for name, data in pairs(FC_Saved.Warlocks) do
		time = data[1]+data[2]-now;
		if time > 0 then
			FW:SendData(SYNC_REPLY.."W "..name.." "..string.format("%.1f",time).." "..data[3]);
		end
	end
	for name, data in pairs(FC_Saved.Cooldowns) do
		time = data[1]+data[2]-now;
		if time > 0 then
			FW:SendData(SYNC_REPLY.."C "..name.." "..string.format("%.1f",time).." "..data[3].." "..data[4]);
		end
	end
end


local function SS_CooldownReceived(class,cd,player) -- cooldowns generated by ora/ctra
	-- class 1=druid 2=shaman 3=warlock 4=paladin, cd= cooldown in minutes
	--FW:ShowDebug("ora cooldown: "..player.." "..class.." "..cd);
	if class == 3 then
		if not FC_Saved.Warlocks[player] then 
			FC_Saved.Warlocks[player] = {SS_TIME,GetTime(),FW.L.NOBODY,FW.FLAG_NORMAL};
		end
	else
		cd=cd*60;
		FC_Saved.Cooldowns[player] = {cd,GetTime(),cd,FW.ORA_FLAGS[class],FW.FLAG_NORMAL};-- store the class as well as the total cooldown for shamans
	end
	return 1;
end

--globally accessable

function FW:SSFrame_OnClick(button)
	if this.fwmovingx then return; end
	if button == "LeftButton" then
		if FW.Settings.Details then -- toggles between hidden->normal->ready->etc
			if FW.Settings.ShowReady then
				FW.Settings.Details = false;
			else
				FW.Settings.ShowReady = true;
			end
		else
			FW.Settings.Details = true;
			FW.Settings.ShowReady = false;
		end
		SS_DrawDetails();
		FW:RefreshOptions();
		
	else
		FW:ScrollTo(FW.L.SOULSTONE_TRACKER);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:SoulstoneOnload()
	FW:RegisterFrame("FWSSFrame",SS_SoulstoneShow,"Soulstone");
	FW:RegisterScan(SS_SoulstoneScan);
	FW:RegisterScan(SS_WarlockScan);
	FW:RegisterScan(SS_CooldownScan);
	FW:RegisterScan(SS_ReadyScan);
	
	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("UpdateInterval",		SS_ProcessSoulstone);
		FW:RegisterTimedEvent("UpdateInterval",		function() SS_SoulstoneShow(1); end);
	end);


	FW:RegisterOtherCasts();
	FW:RegisterOnEnterCombat(SS_SetSSButton); -- Hopefully set correct spell just before the buttons are locked if loading up in combat
	
	FW:RegisterLoadEvent(SS_SoulstoneShow);
		
	FW:RegisterEnterPartyRaid(SS_GetTimers);
	
	FW:AddCommand("synch",SS_GetTimers);
	
	FW:RegisterMessage(FW.SS_CAST_START,
		function(m) 
			SS_CastStart(m);
		end,
	1);
	FW:RegisterMessage(FW.SS_CAST_DELAY,
		function(m) 
			local _,_,t1,t2 = string.find(m,"^(.-)(%d+)$");
			if t1 and t2 then SS_CastDelay(t1,tonumber(t2)); end
		end,
	1);
	FW:RegisterMessage(FW.SS_CAST_CANCEL,
		function(m) 
			SS_CastCancel(m);
		end,
	1);
	FW:RegisterMessage(FW.SS_CAST_SELF,
		function(m,f) 
			SS_CertainCast(f,m);
		end,
	nil);
	FW:RegisterMessage(SYNC_REQUEST,SS_SendTimers,nil);
	FW:RegisterMessage(SYNC_REPLY,
		function(m) 
			SS_ReceivedTimer(m);
		end,
	nil);
	FW:RegisterORAMessage("CD (%d+) (%d+)",
		function(a1,a2,f)
			a1,a2=tonumber(a1),tonumber(a2);
			if a1 and a2 then
				SS_CooldownReceived(a1,a2,f);
			end
		end,
	1);--ignore from ppl with ora
	--FW:Show("Soulstone Module Loaded");
end
FW:SetMainCategory(FW.L.SOULSTONE_TRACKER,FW.ICON_SS,5,"DEFAULT","FWSSFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.COMBAT_HINT);
		
	FW:SetSubCategory(FW.L.BASIC,FW.ICON_BASIC,2);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ENABLE,		FW.L.SS_ENABLE_TT,	"Soulstone",		SS_SoulstoneShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.AUTO_HIDE,	FW.L.AUTO_HIDE_TT,	"SoulstoneAuto",	SS_SoulstoneShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_BARS,	FW.L.SHOW_BARS_TT,	"Details");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXPAND_UP,	FW.L.EXPAND_UP_TT,	"SoulstoneExpand",	SS_SoulstoneShow);

	FW:SetSubCategory(FW.L.SPECIFIC,FW.ICON_SPECIFIC,3);	
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_ALL_ABILITIES,	FW.L.SHOW_ALL_ABILITIES_TT,	"ShowAll");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_READY,		FW.L.SHOW_READY_TT,		"ShowReady");
	
	FW:SetSubCategory(FW.L.SIZING,FW.ICON_SIZE,4);	
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_WIDTH,			"",	"SoulstoneWidth",	SS_SoulstoneShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_HEIGHT,			"",	"SoulstoneHeight",	SS_SoulstoneShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_SPACING,			"",	"SoulstoneSpace",	SS_SoulstoneShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SCALE,				"",	"SoulstoneScale",	SS_SoulstoneScale);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.MAX_SHOWN,			"",	"SoulstoneMax");

	FW:SetSubCategory(FW.L.BAR_COLORING,FW.ICON_FILTER,5);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.SS_FULL,				"",	"ColorSoulstoneMax");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.SS_EMPTY,			"",	"ColorSoulstoneMin");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.RESURRECT,			"",	"ColorReady");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.DEAD,				"",	"ColorDead");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.OFFLINE,				"",	"ColorOffline");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DEAD_OFFLINE_MIXING,	FW.L.DEAD_OFFLINE_MIXING_TT,	"Mix");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.WARLOCK,				"",	"ColorWarlock");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.DRUID,				"",	"ColorDruid");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.PALADIN,				"",	"ColorPaladin");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.SHAMAN,				"",	"ColorShaman");

	FW:SetSubCategory(FW.L.APPEARANCE,FW.ICON_APPEARANCE,6);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BAR_TEXT,			"",	"ColorSoulstoneText",	SS_SoulstoneShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FRAME_BACKGROUND,		"",	"ColorSoulstoneBg",	SS_SoulstoneShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.BAR_FONT,			"",	"SoulstoneFont",	SS_SoulstoneShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FW.L.BAR_TEXTURE,			"",	"SoulstoneTexture",	SS_SoulstoneShow);

FW:SetMainCategory(FW.L.SELF_MESSAGES,FW.ICON_SELFMESSAGE,11,"DEFAULT");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.SELF_MESSAGES_HINT1);

	FW:SetSubCategory(FW.L.SOULSTONE_TRACKER,FW.ICON_SPECIFIC,2);
		FW:RegisterOption(FW.CHK,1,FW.LEF,FW.L.SHOW_SOULSTONE_MESSAGES,		FW.L.SHOW_SOULSTONE_MESSAGES_TT,"SoulstoneMsg");
		FW:RegisterOption(FW.COL,1,FW.RIG,FW.L.SOULSTONE_MESSAGES_COLOR,				"",	"ColorSoulstoneMsg");

		
FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FW.L.SOULSTONE_TRACKER,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DELAY_MAX_SS_BUFF,	"",	"SSDelay");

FW.Default.SSDelay = 2; -- maximum ss buff lag after casts in seconds

FW.Default.ColorWarlock =	{0.58,0.51,0.79};
FW.Default.ColorReady = 	{1.00,1.00,0.00};
FW.Default.ColorSoulstoneMax = 	{0.64,0.21,0.93};
FW.Default.ColorSoulstoneMin =	{1.00,0.00,0.60};
FW.Default.ColorOffline = 	{0.00,0.00,0.00};
FW.Default.ColorDead = 		{0.50,0.50,0.50};
FW.Default.ColorDruid = 	{1.00,0.49,0.04};
FW.Default.ColorPaladin = 	{0.96,0.55,0.73};
FW.Default.ColorShaman = 	{0.00,0.86,0.73};
FW.Default.ColorSoulstoneBg = 	{0.55,0.00,0.88,0.75};
FW.Default.ColorSoulstoneText = {1.00,1.00,1.00};

FW.Default.SoulstoneFont = FW.Default.Font;
FW.Default.SoulstoneFontSize = FW.Default.FontSize;
FW.Default.SoulstoneTexture = FW.Default.Texture;
FW.Default.Details = true;
FW.Default.SoulstoneAuto = false;
FW.Default.ShowReady = false;
FW.Default.ShowAll = true;
FW.Default.SoulstoneMax = 10;
FW.Default.SoulstoneScale = 1;
FW.Default.SoulstoneWidth = 100;
FW.Default.SoulstoneHeight = 12;
FW.Default.SoulstoneMsg = true;
FW.Default.Soulstone = true;
FW.Default.SoulstoneExpand = false;
FW.Default.SoulstoneSpace = 1;
