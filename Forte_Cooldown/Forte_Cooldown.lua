-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x
local CD = FW:Module("Cooldown");
local FW = FW;

local r, g, b, a;
local t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19;
local s1, s2, s3, s4, s5;
local SORT={
	CD =		{ORDER=	{17,2,1},	ASC={1,1,1}},
}
local LOGA = 0.33;
local NUM_COOLDOWNS = 10;

local FLAG_SPELL = 1;
local FLAG_PET = 2;
local FLAG_ITEM = 3;
local FLAG_SOULSTONE = 4;
local FLAG_HEALTHSTONE = 5;
local FLAG_POTION = 6;
local FLAG_POWERUP = 7;
local FLAG_RES_TIMER = 8;
local FLAG_BUFF = 9;

local IgnoreCooldown = 2; -- must be 2 for wand global cooldown crap

FW.SpecialCooldown = {

	{FW.L.MANA_POTION,	FLAG_POTION},
	{FW.L.HEALING_POTION,	FLAG_POTION},
	{FW.L.PROTECTION_POTION,FLAG_POTION},
	
	{FW.L.SOULSTONE,	FLAG_SOULSTONE},
	
	{FW.L.HEALTHSTONE,	FLAG_HEALTHSTONE},
	{FW.L.FEL_BLOSSOM,	FLAG_HEALTHSTONE},
	{FW.L.NIGHTMARE_SEED,	FLAG_HEALTHSTONE},
	
	-- buffs/debuffs ALWAYS come LAST!
}

function FW:RegisterCooldownPowerup(buff)
	local i=1;
	while i<= #FW.SpecialCooldown and FW.SpecialCooldown[i][2] ~= FLAG_BUFF do	
		i=i+1;
	end
	tinsert(FW.SpecialCooldown,i,{"^"..buff,FLAG_POWERUP});
end

function FW:RegisterCooldownBuff(buff)
	tinsert(FW.SpecialCooldown,{"^"..buff,FLAG_BUFF});
end

local FW_OnCooldownUsed = {}

FW.CooldownsSpells = {};--accessable for auto filling filters atm
FW.CooldownsPet = {};--accessable for auto filling filters atm
FW.CooldownsBuffs = {};

local first = {};
local last = {};
local focus = {};
local cooldownString = {}

local cd = {};

local tags1 = {0,10,60,300,900,1800,3600};
local tags2 = {0,1,10,30,60,120,300,600,900,1200,1800,2700,3600,5400};
local tags;

local function CD_SetTimeTags()
	local f1 = (FW.Settings.CooldownWidth-FW.Settings.CooldownHeight)/FW.Settings.CooldownWidth;
	local f2 = 1-f1;
	local v;
	local val;

	if FW.Settings.CooldownDetail then tags = tags2;else tags = tags1;end
	
	for i=1,15,1 do
		v = tags[i];
		if v and v < FW.Settings.CooldownMax then
			val = f1*math.pow(v/FW.Settings.CooldownMax,LOGA)+f2;
			local d = FW.BORDER+val*(FW.Settings.CooldownWidth)-FW.Settings.CooldownHeight/2;
			local a,b,c;
			
			if FW.Settings.CooldownVertical then
				if FW.Settings.CooldownFlip then a,b,c = "TOP",0,-d;else a,b,c = "BOTTOM",0,d;end
			else
				if FW.Settings.CooldownFlip then a,b,c = "RIGHT",-d,0;else a,b,c = "LEFT",d,0;end
			end
	
			getglobal("FWCDFrameTag"..i):SetPoint("CENTER", FWCDFrame,a,b,c);
			if v>60 then v=(v/60);end
			getglobal("FWCDFrameTag"..i):SetText(v);
			getglobal("FWCDFrameTag"..i):SetFont(FW.Settings.CooldownFont,FW.Settings.CooldownFontSize);
			getglobal("FWCDFrameTag"..i):SetTextColor(unpack(FW.Settings.ColorCooldownText));
			getglobal("FWCDFrameTag"..i):Show()
		else
			getglobal("FWCDFrameTag"..i):Hide();
		end
	end
	d = FW.BORDER+FW.Settings.CooldownWidth-FW.Settings.CooldownHeight/2;
	if FW.Settings.CooldownVertical then
		if FW.Settings.CooldownFlip then a,b,c = "TOP",0,-d;else a,b,c = "BOTTOM",0,d;end
	else
		if FW.Settings.CooldownFlip then a,b,c = "RIGHT",-d,0;else a,b,c = "LEFT",d,0;end
	end
	FWCDFrameTag16:SetPoint("CENTER", FWCDFrame,a,b,c);
	
	v=FW.Settings.CooldownMax;if v>60 then v=math.ceil(v/60);end
	FWCDFrameTag16:SetText(v);
	FWCDFrameTag16:SetFont(FW.Settings.CooldownFont,FW.Settings.CooldownFontSize);
	FWCDFrameTag16:SetTextColor(unpack(FW.Settings.ColorCooldownText));
end

local function CD_CooldownLock()
	if FW.Settings.CooldownDisableButtons then
		FWCDFrame:EnableMouse(false);
	else
		FWCDFrame:EnableMouse(true);
	end
end

local function CD_CooldownShow()
	
	if FW.Settings.Cooldown then
		CD_CooldownLock();
		FWCDFrame:Show();
		FWCDFrame:SetScale(FW.Settings.CooldownScale);
		
		CD_SetTimeTags();
		FWCDFrameBack:SetTexture(FW.Settings.CooldownTexture);
		FWCDFrameBack:SetVertexColor(unpack(FW.Settings.ColorCooldownBar));
		FWCDFrame:SetBackdropColor(unpack(FW.Settings.ColorCooldownBg));
		FWCDFrame:SetBackdropBorderColor(unpack(FW.Settings.ColorCooldownBg));
		if FW.Settings.CooldownVertical then
			FWCDFrame:SetWidth(FW.Settings.CooldownHeight+FW.BORDER*2);
			FWCDFrame:SetHeight(FW.Settings.CooldownWidth+FW.BORDER*2);
			
			FWCDFrameBack:SetTexCoord(1,0, 0,0, 1,1, 0,1);
		else
			FWCDFrame:SetWidth(FW.Settings.CooldownWidth+FW.BORDER*2);
			FWCDFrame:SetHeight(FW.Settings.CooldownHeight+FW.BORDER*2);
			
			FWCDFrameBack:SetTexCoord(0,0, 0,1, 1,0, 1,1);
		end
		for i=1,NUM_COOLDOWNS,1 do
			
			getglobal("FWCDBar"..i.."Texture"):SetTexture(FW.Settings.CooldownTexture);
			
			getglobal("FWCDBar"..i.."Icon"):SetWidth(FW.Settings.CooldownHeight-2);
			getglobal("FWCDBar"..i.."Icon"):SetHeight(FW.Settings.CooldownHeight-2);
			getglobal("FWCDBar"..i.."Icon"):SetFont(FW.Settings.CooldownIconFont,FW.Settings.CooldownIconFontSize);
			getglobal("FWCDBar"..i.."Icon"):SetTextColor(unpack(FW.Settings.ColorCooldownIconText));
			
			getglobal("FWCDBar"..i):SetPoint("TOPLEFT", FWCDFrame, "TOPLEFT", FW.BORDER,-FW.BORDER);
			getglobal("FWCDBar"..i):SetPoint("BOTTOMRIGHT", FWCDFrame, "BOTTOMRIGHT", -FW.BORDER,FW.BORDER);
			
			local d = FW.Settings.CooldownHeight/2;
			local a,b,c;
			if FW.Settings.CooldownVertical then
				if FW.Settings.CooldownFlip then
					a,b,c =  "TOP",0,-d;
				else
					a,b,c =  "BOTTOM",0,d;
				end
			else
				if FW.Settings.CooldownFlip then
					a,b,c = "RIGHT",-d,0;
				else
					a,b,c = "LEFT",d,0;
				end
			end
			getglobal("FWCDBar"..i.."SplashIcon"):SetPoint("CENTER", getglobal("FWCDBar"..i),a,b,c);
		end
		
	else
		FWCDFrame:Hide();
	end
end

local function CD_CooldownScale()	
	CD_CooldownShow();
	FW:CorrectScale(FWCDFrame);
end

local function ColorVal(flag,spell,custom)
	if custom == FW.FILTER_COLOR then
		r,g,b = unpack(FW.Settings.CooldownFilter[spell],2,4);
	else
		if flag == FLAG_SPELL then
			r,g,b = unpack(FW.Settings.ColorCooldownSpell);
		elseif flag == FLAG_PET then
			r,g,b = unpack(FW.Settings.ColorCooldownPet);
		elseif flag == FLAG_ITEM then
			r,g,b = unpack(FW.Settings.ColorCooldownItem);
		elseif flag == FLAG_SOULSTONE then
			r,g,b = unpack(FW.Settings.ColorCooldownSoulstone);
		elseif flag == FLAG_HEALTHSTONE then
			r,g,b = unpack(FW.Settings.ColorCooldownHealthstone);
		elseif flag == FLAG_POTION then
			r,g,b = unpack(FW.Settings.ColorCooldownPotion);
		elseif flag == FLAG_POWERUP then
			r,g,b = unpack(FW.Settings.ColorCooldownPowerup);
		elseif flag == FLAG_RES_TIMER then
			r,g,b = unpack(FW.Settings.ColorCooldownResTimer);
		elseif flag == FLAG_BUFF then
			r,g,b = unpack(FW.Settings.ColorCooldownBuff);
		end
	end
end

local function CD_DrawCooldowns()
	if not FWCDFrame:IsShown() then return; end
	local index=0;
	local Bar;
	for i=1, NUM_COOLDOWNS, 1 do
		Bar = getglobal("FWCDBar"..i);
		index = index+1;
		while index <= FW:ROWS(cd) do
			t1,t2,_,t4,t5,t6,t7,t8,t9,t10,_,t12,t13,t14,t15,_,t17,t18 = FW:GET(cd,index);
			if t14 > 0 and t17==0 then break; else index=index+1 end
		end
		if index <= FW:ROWS(cd) then
			getglobal("FWCDBar"..i.."Icon").title = FW:SecToTime(t2).." "..t1;
			getglobal("FWCDBar"..i.."Icon").tip = cooldownString[t13];
			Bar.id = index;
			if FW.Settings.CooldownSplash and t15==-1 then
				getglobal("FWCDBar"..i.."SplashIcon"):SetTexture(t5);
				getglobal("FWCDBar"..i.."SplashIcon"):Show();
				
				getglobal("FWCDBar"..i.."SplashIcon"):SetWidth(FW.Settings.CooldownSplashFactor*FW.Settings.CooldownHeight*(1-t14));
				getglobal("FWCDBar"..i.."SplashIcon"):SetHeight(FW.Settings.CooldownSplashFactor*FW.Settings.CooldownHeight*(1-t14));
			else
				getglobal("FWCDBar"..i.."SplashIcon"):Hide();
			end
			
			if t2>60 then t2=math.ceil(t2/60) else t2=math.floor(t2) end;
			getglobal("FWCDBar"..i.."Icon"):SetNormalTexture(t5);
			getglobal("FWCDBar"..i.."Icon"):SetText(t2);
			Bar:SetAlpha(t14);
			ColorVal(t6,t1,t18);
			
			getglobal("FWCDBar"..i.."Texture"):SetVertexColor(r,g,b,1-t7);
			getglobal("FWCDBar"..i.."Texture"):ClearAllPoints();
			if FW.Settings.CooldownVertical then
			
				if FW.Settings.CooldownFlip then
					getglobal("FWCDBar"..i.."Texture"):SetTexCoord(t8,0,t7,0, t8,1, t7,1);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("BOTTOMLEFT", Bar, "BOTTOMLEFT", 0, FW.Settings.CooldownWidth-t9);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("TOPRIGHT", Bar, "TOPRIGHT", 0, -t12);	

					getglobal("FWCDBar"..i.."Icon"):SetPoint("CENTER", Bar, "TOP", 0, -t10);
					getglobal("FWCDBar"..i.."Tag"):SetPoint("CENTER", Bar, "TOP", 0, -t10);
				else
					getglobal("FWCDBar"..i.."Texture"):SetTexCoord(t7,0,t8,0, t7,1, t8,1);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("TOPLEFT", Bar, "TOPLEFT", 0, t9-FW.Settings.CooldownWidth);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("BOTTOMRIGHT", Bar, "BOTTOMRIGHT", 0, t12);	

					getglobal("FWCDBar"..i.."Icon"):SetPoint("CENTER", Bar, "BOTTOM", 0, t10);
					getglobal("FWCDBar"..i.."Tag"):SetPoint("CENTER", Bar, "BOTTOM", 0, t10);
				end
			else
				if FW.Settings.CooldownFlip then
					getglobal("FWCDBar"..i.."Texture"):SetTexCoord(t7,0, t7,1, t8,0, t8,1);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("TOPRIGHT", Bar, "TOPRIGHT",-t12, 0);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("BOTTOMLEFT", Bar, "BOTTOMLEFT", FW.Settings.CooldownWidth-t9, 0);
				
					getglobal("FWCDBar"..i.."Icon"):SetPoint("CENTER", Bar, "RIGHT", -t10, 0);
					getglobal("FWCDBar"..i.."Tag"):SetPoint("CENTER", Bar, "RIGHT", -t10, 0);	
				else
					getglobal("FWCDBar"..i.."Texture"):SetTexCoord(t8,0, t8,1, t7,0, t7,1);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("TOPLEFT", Bar, "TOPLEFT", t12, 0);
					getglobal("FWCDBar"..i.."Texture"):SetPoint("BOTTOMRIGHT", Bar, "BOTTOMRIGHT", t9-FW.Settings.CooldownWidth, 0);

					getglobal("FWCDBar"..i.."Icon"):SetPoint("CENTER", Bar, "LEFT", t10, 0);
					getglobal("FWCDBar"..i.."Tag"):SetPoint("CENTER", Bar, "LEFT", t10, 0);
				end
			end
			Bar:Show();
		else
			Bar:Hide();
		end
	end
end

local function CD_CooldownFilterChange(spell,newtype)
	local f;
	for i=1,FW:ROWS(cd),1 do
		if FW:GET(cd,i,1) == spell then
			if newtype == FW.FILTER_HIDE then f=1;else f=0;end
			FW:SET(cd,i,17, f);
			FW:SET(cd,i,18, newtype or 0);
		end
	end
end

local function CD_StartCooldown(spell, start, duration, texture, flag)
	--FW:ShowDebug("New cd: "..spell);
	local f,c;
	if FW.Settings.CooldownFilter[spell] then 
		if FW.Settings.CooldownFilter[spell][1] == -1 then f=1;else f=0;end
		c = FW.Settings.CooldownFilter[spell][1];
	else
		f,c=0,0;
	end
	
	FW:INSERT(cd, spell,duration,start,duration,texture, flag ,0,0,0,0,0,0,0,0,0,GetTime(),f,c);
	for i,f in ipairs(FW_OnCooldownUsed) do
		f(spell);
	end
end

local function CD_EndCooldown(i)
	local spell,_,_,_,_,flag = FW:GET(cd,i);
	
	if flag == FLAG_PET then
		FW.CooldownsPet[spell][1] = 0;
		FW.CooldownsPet[spell][2] = 0;
	elseif flag == FLAG_BUFF then
		FW.CooldownsBuffs[spell][1] = 0;
		FW.CooldownsBuffs[spell][2] = 0;
	else	
		FW.CooldownsSpells[spell][1] = 0;
		FW.CooldownsSpells[spell][2] = 0;
	end

	FW:ShowDebug("Cd over: "..spell);
	FW:SET(cd,i, 2, 0); -- expired
	local v = 1-(FW.Settings.CooldownWidth-FW.Settings.CooldownHeight)/FW.Settings.CooldownWidth;
	FW:SET(cd,i,7, v);
	v = v*FW.Settings.CooldownWidth;
	FW:SET(cd,i,9, v);
	FW:SET(cd,i,10, v-FW.Settings.CooldownHeight/2);
	FW:SET(cd,i,11, v-FW.Settings.CooldownHeight);
	
	
	FW:SET(cd,i,15, -1); -- expired
	FW:SET(cd,i,14, 1);
end

local function CD_IsSpecialCooldown(spell,buff)
	for i,v in ipairs(FW.SpecialCooldown) do
		if not buff and v[2] == FLAG_BUFF then
			return;
		elseif	string.find(spell,v[1]) then
			return v[2];
		end
	end
end

local cooldowns;
function CD_CheckCooldown(spell,start,duration,texture,flag)

	local index;
	if flag == FLAG_BUFF then
		cooldowns = FW.CooldownsBuffs;
	elseif flag == FLAG_PET then
		cooldowns = FW.CooldownsPet;
	else
		cooldowns = FW.CooldownsSpells;
	end
	if cooldowns[spell] then
		if start ~= cooldowns[spell][1] or duration ~= cooldowns[spell][2] then
			if duration == 0 and cooldowns[spell][2] > IgnoreCooldown then -- no event fired when cd is over :|
				index = FW:FINDN(cd,spell,1, flag,6, 0,15) or FW:FINDN(cd,spell,1, flag,6, 1,15);
				if index then
					FW:ShowDebug("force cd over: "..spell);
					cd[index-12] = GetTime();
					cd[index-11] = duration;
					
					CD_EndCooldown(FW:TO_ROW(cd,index));
				end
			elseif duration > IgnoreCooldown then
				index = FW:FINDN(cd, spell,1, flag,6, 0,15) or FW:FINDN(cd, spell,1, flag,6, 1,15);
				if index then
					FW:ShowDebug("Change cd: "..spell);
					cd[index-12] = start;
					cd[index-11] = duration;
				else
					CD_StartCooldown(spell,start,duration,texture,flag);
				end
			end
			cooldowns[spell][1] = start;
			cooldowns[spell][2] = duration;
			cooldowns[spell][3] = texture;
			cooldowns[spell][4] = flag;			
		end
	else
		cooldowns[spell] = {start,duration,texture,flag};
		if duration > IgnoreCooldown then
			 CD_StartCooldown(spell,start,duration,texture,flag);
		end
	end
end

--[[ cd
1: spell
2: timer
3: start
4: duration
5: texture
6: flag

7: highest bar val (0-1)
8: lowest bar val (0-1)

9: highest bar pos
10: icon center
11: lowest pos icon
12: lowest bar pos

13: Sharing space (1-x group)
14: Visibility (0 to 1)
15: Focussed (0,1 or -1 for fading)
16: last update
17: filter (0 or 1)
18: custom color (0 or 1)
]]

local function CD_CreateCooldowns()

	local f1 = (FW.Settings.CooldownWidth-FW.Settings.CooldownHeight)/FW.Settings.CooldownWidth;
	local f2 = 1-f1;
	local v;
	local time = GetTime();
	local i=1;
	local t;
	while i<=FW:ROWS(cd) do
		_,t2,t3,t4 = FW:GET(cd,i);
		t = t4-time+t3
		if t<=-1 then
			FW:REMOVE(cd,i);
		elseif t<= 0 then
			if t2>0 then CD_EndCooldown(i);end
			i=i+1;
		else
			
			FW:SET(cd,i,2, t);
			if t > FW.Settings.CooldownMax then
				v = 1;
			else
				v = f1*math.pow(t/FW.Settings.CooldownMax,LOGA)+f2
			end
			FW:SET(cd,i,7, v);
			v = v*FW.Settings.CooldownWidth;
			FW:SET(cd,i,9, v);
			
			FW:SET(cd,i,10, v-FW.Settings.CooldownHeight/2);
			FW:SET(cd,i,11, v-FW.Settings.CooldownHeight);
			
			i=i+1;
		end
	end
	if not FW.Settings.Cooldown then return; end
	
	FW:BST(cd,SORT.CD.ORDER,SORT.CD.ASC);

	local s3,s7,s8,s9,s12 = 0,0,0,0,0;
	
	local group = 0;
	FW:ERASE(first);
	FW:ERASE(last);
	FW:ERASE(focus);
	i=1;
	while i<=FW:ROWS(cd) do
		t1,t2,t3,_,_,_,t7,t8,t9,t10,_,t12,_,_,t15,_,t17 = FW:GET(cd,i);
		if t17 == 0 then
			if i > 1 and ((s9 > t10 and t2~=0) or (t2==0 and t3==s3)) then -- more than half an icon overlap
				last[group] = i;
				-- set the minimum coordinates
				t8,t12=s8,s12;
				cooldownString[group] = cooldownString[group].."\n"..FW:SecToTime(t2).." "..t1;
			else -- also done when i=1
				group = group+1;
				first[group] = i;
				last[group] = i;
				-- set the minimum coordinates
				t8,t12=s7,s9;
				cooldownString[group] = FW:SecToTime(t2).." "..t1;
			end
			
			FW:SET(cd,i,8, t8);
			FW:SET(cd,i,12, t12);
			FW:SET(cd,i,13, group);

			if t15 ~= 0 then
				if not focus[group] then
					focus[group] = i;
				else
					FW:SET(cd,i,14,0);
					FW:SET(cd,i,15,0);
				end
			end
			if t2~=0 then
				s7,s8,s9,s12 = t7,t8,t9,t12;
			end
			s3 = t3;
		end
		i=i+1;
	end
	for g,n in ipairs(first) do
		if not focus[g] then
			FW:SET(cd,n,14, 1);
			FW:SET(cd,n,15, 1);
		end
	end
	i=1;
	while i<=FW:ROWS(cd) do
		_,_,_,_,_,_,_,_,_,_,_,_,t13,t14,t15,t16,t17 = FW:GET(cd,i);	
		if t15 == 1 and t17==0 then
			t14 = t14+(time-t16);
			if t14 > 1.5 then
				t14 = 1;
				if last[t13] ~= first[t13] then
					FW:SET(cd,i,15, 0);
					if last[t13] == i then
						FW:SET(cd,first[t13],15, 1);
					else
						FW:SET(cd,i+1,15, 1);
					end
				end
			end
		else
			t14 = t14-time+t16;
			if t14 < 0 then t14 = 0; end	
		end
		FW:SET(cd,i,14, t14);
		FW:SET(cd,i,16, time);
		i=i+1;
	end
	if FW.Settings.Cooldown and (not FW.Settings.CooldownHide or FW:FIND(cd,0,17)) then
		FWCDFrame:Show()
	else
		FWCDFrame:Hide()
	end
	CD_DrawCooldowns();
end

local function CD_SoulstoneCooldown()
	if FC_Saved.Warlocks[FW.PLAYER] then
		CD_CheckCooldown(FW:BestSoulstone(),GetTime(),FC_Saved.Warlocks[FW.PLAYER][1]+FC_Saved.Warlocks[FW.PLAYER][2]-FC_Saved.Update,"Interface\\Icons\\Spell_Shadow_SoulGem",FLAG_SOULSTONE)
	end
end

local function CD_ResTimerCooldown()
	if GetCorpseRecoveryDelay()>0 then
		CD_CheckCooldown(FW.L.RESURRECT_TIMER,GetTime(),GetCorpseRecoveryDelay(),"Interface\\Icons\\Ability_Creature_Cursed_02",FLAG_RES_TIMER)
	end
end

local function CD_ScanBagCooldowns()
	--FW:ShowDebug("Scanning Bag");
	local spell,start,duration,texture;
	local link;
	local applies;
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			link = GetContainerItemLink(bag,slot)
			if link then
				spell,_,_,_,_,_,_,_,_,texture = GetItemInfo(link);
				start,duration,applies = GetItemCooldown(link);
				if applies == 1 then CD_CheckCooldown(spell,start,duration,texture,CD_IsSpecialCooldown(spell) or FLAG_ITEM);end
			end
		end
	end
end

local function CD_ScanPetCooldowns()
	--FW:ShowDebug("Scanning Pet");
	local spell,start,duration,texture;
	local applies;
	for i=1, 10 do
		spell, _, texture = GetPetActionInfo(i);
		if spell then
			start, duration, applies = GetPetActionCooldown(i);
			if applies == 1 then CD_CheckCooldown(spell,start,duration,texture,CD_IsSpecialCooldown(spell) or FLAG_PET);end
		end
	end
end

local function CD_ScanActionCooldowns()
	--FW:ShowDebug("Scanning Actions");
	local spell,start,duration,texture;
	local what,id;
	local applies;
	for i=1, 120 do
		what,id = GetActionInfo(i);
		if what == "item" then
			spell,_,_,_,_,_,_,_,_,texture = GetItemInfo(id);
			start,duration,applies = GetItemCooldown(id);
			if applies == 1 then CD_CheckCooldown(spell,start,duration,texture,CD_IsSpecialCooldown(spell) or FLAG_ITEM);end
		end
	end
	for i=1,19,1 do -- all equipable
		link = GetInventoryItemLink("player",i);
		if link then
			spell,_,_,_,_,_,_,_,_,texture = GetItemInfo(link);
			start,duration,applies = GetItemCooldown(link);
			if applies == 1 then CD_CheckCooldown(spell,start,duration,texture,CD_IsSpecialCooldown(spell) or FLAG_ITEM);end
		end
	end
end

local function CD_ScanBookCooldowns()
	--FW:ShowDebug("Scanning Book");
	local i = 1;
	local spell,start,duration;
	
	while true do
		spell = GetSpellName(i,BOOKTYPE_SPELL);
		if spell then
			start,duration = GetSpellCooldown(i,BOOKTYPE_SPELL);
			CD_CheckCooldown(spell,start,duration,GetSpellTexture(i,BOOKTYPE_SPELL),CD_IsSpecialCooldown(spell) or FLAG_SPELL);
			i=i+1;
		else
			break;
		end
	end
	i=1;
	while true do
		spell = GetSpellName(i,BOOKTYPE_PET);
		if spell then
			start,duration = GetSpellCooldown(i,BOOKTYPE_PET);
			CD_CheckCooldown(spell,start,duration,GetSpellTexture(i,BOOKTYPE_PET),CD_IsSpecialCooldown(spell) or FLAG_PET);
			i=i+1;
		else
			break;
		end
	end
end

--[[function FW:Test()
	
	for spell,data in pairs(FW.CooldownsPet) do
		FW:Show("pet:"..spell..","..data[1]..","..data[2]..","..data[4]);
	end
	for spell,data in pairs(FW.CooldownsSpells) do
		FW:Show("spells:"..spell..","..data[1]..","..data[2]..","..data[4]);
	end
	for spell,data in pairs(FW.CooldownsBuffs) do
		FW:Show("cooldowns:"..spell..","..data[1]..","..data[2]..","..data[4]);
	end
end]]

local function CD_ScanBuffCooldowns()
	local i;
	for spell,data in pairs(FW.CooldownsBuffs) do
		if data[2] ~= 0 then
			i = FW:PlayerHasBuff(spell);
			if not i or not FW.Settings.CooldownShowBuffs then
				CD_CheckCooldown(spell,GetTime(),0,data[3],data[4]);
			end
		end
	end

	if FW.Settings.CooldownShowBuffs then
		i = 1;
		local flag,spell;
		while true do
			spell = GetPlayerBuffName(i);
			if spell then
				flag = CD_IsSpecialCooldown(spell,1);
				if flag then
					CD_CheckCooldown(spell,GetTime(),GetPlayerBuffTimeLeft(i),GetPlayerBuffTexture(i),flag);
				end
				i=i+1;
			else
				break;
			end
		end
	end
end

local function CD_ScanCooldowns()
	CD_ScanActionCooldowns();
	CD_ScanBookCooldowns();
	CD_ScanBagCooldowns();
	CD_ScanPetCooldowns();
	CD_ScanBuffCooldowns();
end

---------------------------------------------------------------------------
-- globally accessable
---------------------------------------------------------------------------
function FW:RegisterOnCooldownUsed(func)
	tinsert(FW_OnCooldownUsed,func)
end

function FW:CDFrame_OnClick(button)
	if this.fwmovingx then return; end
	if button == "RightButton" then
		FW:ScrollTo(FW.L.COOLDOWN_TIMER);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:CooldownIcon_OnClick()
	if FW.Settings.CooldownIgnore then
		FW:SET(cd,this:GetParent().id,17, -1);
		local spell = FW:GET(cd,this:GetParent().id,1);
		if not FW.Settings.CooldownFilter[spell] then FW.Settings.CooldownFilter[spell] = {};end
		FW.Settings.CooldownFilter[spell][1] = -1;
	end
end

function FW:CooldownOnload()
	FW:RegisterFrame("FWCDFrame",CD_CooldownShow,"Cooldown");
	
	FW:RegisterDelayedLoadEvent(CD_ScanCooldowns);
	FW:RegisterDelayedLoadEvent(CD_ResTimerCooldown);
	FW:RegisterDelayedLoadEvent(CD_SoulstoneCooldown);
	
	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("AnimationInterval",	CD_CreateCooldowns);
	end);
	
	FW:RegisterToEvent("SPELL_UPDATE_COOLDOWN",	CD_ScanBookCooldowns);
	FW:RegisterToEvent("ACTIONBAR_UPDATE_COOLDOWN",	CD_ScanActionCooldowns);
	FW:RegisterToEvent("PET_BAR_UPDATE_COOLDOWN",	CD_ScanPetCooldowns);
	FW:RegisterToEvent("BAG_UPDATE_COOLDOWN",	CD_ScanBagCooldowns);
	FW:RegisterToEvent("BAG_UPDATE",		CD_ScanBookCooldowns);
	FW:RegisterToEvent("PLAYER_DEAD",		CD_ResTimerCooldown);
	FW:RegisterToEvent("UNIT_AURA",			function () if arg1=="player" then CD_ScanBuffCooldowns();end end);

	FW:RegisterFilterRefresh(function()
		for i=1,FW:ROWS(cd),1 do
			FW:SET(cd,i,17, 0);
			FW:SET(cd,i,18, 0);
		end
		for spell, data in pairs(FW.Settings.CooldownFilter) do
			CD_CooldownFilterChange(spell,data[1])
		end
	end);
	
	-- will move these to class modules later
	FW:RegisterCooldownPowerup(FW.L.THE_RESTRAINED_ESSENCE_OF_SAPPHIRON);
	FW:RegisterCooldownPowerup(FW.L.XIRIS_GIFT);
	FW:RegisterCooldownPowerup(FW.L.ICON_OF_THE_SILVER_CRESCENT);
	FW:RegisterCooldownPowerup(FW.L.THE_SKULL_OF_GULDAN);
	FW:RegisterCooldownPowerup(FW.L.ZANDALARIAN_HERO_CHARM);
	FW:RegisterCooldownPowerup(FW.L.VENGEANCE_OF_THE_ILLIDARI);
	FW:RegisterCooldownPowerup(FW.L.HEX_SHRUNKEN_HEAD);
	
	FW:RegisterCooldownBuff(FW.L.WELL_FED);
	FW:RegisterCooldownBuff(FW.L.RECENTLY_BANDAGED);
end
FW:SetMainCategory(FW.L.COOLDOWN_TIMER,FW.ICON_CD,4,"COOLDOWN","FWCDFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.CD_HINT1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.CD_HINT2);
	
	FW:SetSubCategory(FW.L.BASIC,FW.ICON_BASIC,2);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ENABLE,	FW.L.CD_BASIC1_TT,	"Cooldown",			CD_CooldownShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.LOCK,	FW.L.CD_BASIC2_TT,	"CooldownDisableButtons",	CD_CooldownLock);
	
	FW:SetSubCategory(FW.L.SPECIFIC,FW.ICON_SPECIFIC,3);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.CD_SPECIFIC1,	FW.L.CD_SPECIFIC1_TT,	"CooldownIgnore");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.CD_SPECIFIC2,	FW.L.CD_SPECIFIC2_TT,	"CooldownVertical",		CD_CooldownShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.CD_SPECIFIC8,	FW.L.CD_SPECIFIC8_TT,	"CooldownFlip",			CD_CooldownShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.CD_SPECIFIC3,	FW.L.CD_SPECIFIC3_TT,	"CooldownHide");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.CD_SPECIFIC4,	FW.L.CD_SPECIFIC4_TT,	"CooldownSplash");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.CD_SPECIFIC9,	FW.L.CD_SPECIFIC9_TT,	"CooldownSplashFactor");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.CD_SPECIFIC5,	FW.L.CD_SPECIFIC5_TT,	"CooldownDetail",		CD_CooldownShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.CD_SPECIFIC7,	FW.L.CD_SPECIFIC7_TT,	"CooldownShowBuffs");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.CD_SPECIFIC6,	FW.L.CD_SPECIFIC6_TT,	"CooldownMax",			CD_CooldownShow);

	
	FW:SetSubCategory(FW.L.COLORING_FILTERING,FW.ICON_FILTER,4);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.SPELL,				"",	"ColorCooldownSpell");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.PET,				"",	"ColorCooldownPet");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.ITEM,				"",	"ColorCooldownItem");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.POWERUP,				"",	"ColorCooldownPowerup");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.POTION,				"",	"ColorCooldownPotion");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.HEALTHSTONE_NORMAL,		"",	"ColorCooldownHealthstone");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.SS,				"",	"ColorCooldownSoulstone");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.RESURRECT_TIMER,			"",	"ColorCooldownResTimer");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BUFF,				"",	"ColorCooldownBuff");
		FW:RegisterOption(FW.FIL,2,FW.NON,FW.L.CUSTOMIZE,	FW.L.CD_CUSTOMIZE_TT,	"CooldownFilter",		CD_CooldownFilterChange);

	FW:SetSubCategory(FW.L.SIZING,FW.ICON_SIZE,5);	
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_WIDTH,			"",	"CooldownWidth",		CD_CooldownShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_HEIGHT,			"",	"CooldownHeight",		CD_CooldownShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SCALE,				"",	"CooldownScale",		CD_CooldownScale);
		
	FW:SetSubCategory(FW.L.APPEARANCE,FW.ICON_APPEARANCE,6);

		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BAR,				"",	"ColorCooldownBar",		CD_CooldownShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FRAME_BACKGROUND,		"",	"ColorCooldownBg",		CD_CooldownShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BAR_TEXT,			"",	"ColorCooldownText",		CD_CooldownShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.ICON_TEXT,	FW.L.ICON_TEXT_TT,	"ColorCooldownIconText",	CD_CooldownShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.BAR_FONT,			"",	"CooldownFont",			CD_CooldownShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.ICON_FONT,	FW.L.ICON_TEXT_TT,	"CooldownIconFont",		CD_CooldownShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FW.L.BAR_TEXTURE,			"",	"CooldownTexture",		CD_CooldownShow);

--FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");

--	FW:SetSubCategory(FW.L.COOLDOWN_TIMER,FW.ICON_DEFAULT,2);

FW.Default.Cooldown = true;
FW.Default.CooldownWidth = 250;
FW.Default.CooldownHeight = 16;
FW.Default.CooldownScale = 1;
FW.Default.CooldownFont = FW.Default.Font;
FW.Default.CooldownFontSize = FW.Default.FontSize;
FW.Default.CooldownTexture = FW.Default.Texture;
FW.Default.CooldownVertical = false;
FW.Default.CooldownFlip = false;
FW.Default.CooldownIconFont = FW.Default.Font;
FW.Default.CooldownIconFontSize = FW.Default.FontSize;
FW.Default.CooldownDisableButtons = false;
FW.Default.CooldownSplash = true;
FW.Default.CooldownSplashFactor = 8;
FW.Default.CooldownHide = false;
FW.Default.CooldownMax = 300;
FW.Default.CooldownDetail = false;
FW.Default.CooldownIgnore = true;
FW.Default.CooldownShowBuffs = false;

FW.Default.ColorCooldownText = 		{1.00,1.00,1.00,0.20};
FW.Default.ColorCooldownIconText =	{1.00,1.00,1.00,0.00};
FW.Default.ColorCooldownBg = 		{0.00,0.00,0.00,1.00};
FW.Default.ColorCooldownBar = 		{1.00,1.00,1.00,0.50};

FW.Default.ColorCooldownPotion =	{0.00,1.00,0.50};
FW.Default.ColorCooldownHealthstone =	{0.00,1.00,0.50};
FW.Default.ColorCooldownSpell = 	{1.00,0.50,0.00};
FW.Default.ColorCooldownPet = 		{1.00,0.00,0.95};
FW.Default.ColorCooldownPowerup =	{0.00,0.75,1.00};
FW.Default.ColorCooldownItem =		{1.00,1.00,0.00};
FW.Default.ColorCooldownSoulstone =	{0.64,0.21,0.93};
FW.Default.ColorCooldownResTimer =	{1.00,0.00,0.00};
FW.Default.ColorCooldownBuff =		{1.00,1.00,1.00};

FW.Default.CooldownFilter = 	{
	[FW.L.HEARTHSTONE] = 			{-1},
	[FW.L.BLESSED_MEDALLION_OF_KARABOR] = 	{-1},
	[FW.L.EVERLASTING_UNDERSPORE_FROND] = 	{-1},
	[FW.L.RECENTLY_BANDAGED] = 		{-2,1,0.65,0}
};