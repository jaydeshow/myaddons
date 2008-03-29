-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x

if FW.CLASS == "WARLOCK" then
	local FW = FW;
	local WL = FW:ClassModule("Warlock");
	if FW.Modules.Timer then
	
		--						istype: 1=magic,2=curse,3=cc,4=pet,(5=powerup),6=enslave/charm,(7=tdebuff)
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture
		FW:RegisterSpell(FW.L.IMMOLATE,			1,015,1,1,00,"Interface\\Icons\\Spell_Fire_Immolation");
			FW:RegisterSpellModSetB(FW.L.IMMOLATE, 		FW.L.VOIDHEART, 4,  3);
		FW:RegisterSpell(FW.L.CORRUPTION,		1,018,1,1,00,"Interface\\Icons\\Spell_Shadow_AbominationExplosion");
			FW:RegisterSpellModRank(FW.L.CORRUPTION, 	1, -6);
			FW:RegisterSpellModRank(FW.L.CORRUPTION, 	2, -3);
			FW:RegisterSpellModSetB(FW.L.CORRUPTION, 	FW.L.VOIDHEART, 4,  3);
		FW:RegisterSpell(FW.L.UNSTABLE_AFFLICTION,	1,018,1,1,00,"Interface\\Icons\\Spell_Shadow_UnstableAffliction_3");
		FW:RegisterSpell(FW.L.CURSE_OF_AGONY,		1,024,1,2,00,"Interface\\Icons\\Spell_Shadow_CurseOfSargeras");
		FW:RegisterSpell(FW.L.SIPHON_LIFE,		1,030,1,1,00,"Interface\\Icons\\Spell_Shadow_Requiem");
		FW:RegisterSpell(FW.L.CURSE_OF_SHADOW,		1,300,0,2,00,"Interface\\Icons\\Spell_Shadow_CurseOfAchimonde");
		FW:RegisterSpell(FW.L.CURSE_OF_THE_ELEMENTS,	1,300,0,2,00,"Interface\\Icons\\Spell_Shadow_ChillTouch");
		FW:RegisterSpell(FW.L.CURSE_OF_RECKLESSNESS,	1,120,0,2,00,"Interface\\Icons\\Spell_Shadow_UnholyStrength");
		FW:RegisterSpell(FW.L.CURSE_OF_WEAKNESS,	1,120,0,2,00,"Interface\\Icons\\Spell_Shadow_CurseOfMannoroth");
		FW:RegisterSpell(FW.L.CURSE_OF_DOOM,		1,060,0,2,00,"Interface\\Icons\\Spell_Shadow_AuraOfDarkness");
		FW:RegisterSpell(FW.L.CURSE_OF_TONGUES,		1,030,0,2,10,"Interface\\Icons\\Spell_Shadow_CurseOfTounges");
		FW:RegisterSpell(FW.L.CURSE_OF_EXHAUSTION,	1,012,0,2,00,"Interface\\Icons\\Spell_Shadow_GrimWard");
		FW:RegisterSpell(FW.L.BANISH,			1,030,0,3,10,"Interface\\Icons\\Spell_Shadow_Cripple");
			FW:RegisterSpellModRank(FW.L.BANISH, 		1, -10);
		FW:RegisterSpell(FW.L.FEAR,			1,020,0,3,10,"Interface\\Icons\\Spell_Shadow_Possession");
			FW:RegisterSpellModRank(FW.L.FEAR, 		1, -10);
			FW:RegisterSpellModRank(FW.L.FEAR, 		2, -5);
		FW:RegisterSpell(FW.L.HOWL_OF_TERROR,		0,008,0,3,00,"Interface\\Icons\\Spell_Shadow_DeathScream");
			FW:RegisterSpellModRank(FW.L.HOWL_OF_TERROR, 	1, -2);
		FW:RegisterSpell(FW.L.ENSLAVE_DEMON,		1,300,0,6,00,"Interface\\Icons\\Spell_Shadow_EnslaveDemon");
		FW:RegisterSpell(FW.L.INFERNO,			0,300,0,6,00,"Interface\\Icons\\Spell_Shadow_EnslaveDemon");
		
		--buffname,duration
		FW:RegisterBuff(FW.L.ESSENCE_OF_SAPPHIRON,		20);
		FW:RegisterBuff(FW.L.EPHEMERAL_POWER,			15);
		FW:RegisterBuff(FW.L.SHADOWFLAME,			15);
		FW:RegisterBuff(FW.L.FLAMESHADOW,			15);
		FW:RegisterBuff(FW.L.SPELL_HASTE,			06);
		FW:RegisterBuff(FW.L.UNSTABLE_POWER,			20);
		FW:RegisterBuff(FW.L.SHADOW_TRANCE,			10);
		FW:RegisterBuff(FW.L.BLESSING_OF_THE_SILVER_CRESCENT,	20);
		FW:RegisterBuff(FW.L.RECURRING_POWER,			10);
		FW:RegisterBuff(FW.L.CALL_OF_THE_NEXUS,			10);
		FW:RegisterBuff(FW.L.HEROISM,				40);
		FW:RegisterBuff(FW.L.BLOODLUST,				40);
		FW:RegisterBuff(FW.L.LESSER_SPELL_BLASTING,		10);
		FW:RegisterBuff(FW.L.SPELL_BLASTING,			10);
		FW:RegisterBuff(FW.L.BACKLASH,				08);
		FW:RegisterBuff(FW.L.UNSTABLE_CURRENTS,			15);
		FW:RegisterBuff(FW.L.INFERNAL_POWER,			05);
		FW:RegisterBuff(FW.L.SPELL_POWER,			15);
		FW:RegisterBuff(FW.L.FEL_INFUSION,			20);
		FW:RegisterBuff(FW.L.ARCANE_ENERGY,			15);
		FW:RegisterBuff(FW.L.AURA_OF_THE_CRUSADE,		10);
		FW:RegisterBuff(FW.L.BAND_OF_THE_ETERNAL_SAGE,		15);
		FW:RegisterBuff(FW.L.MOJO_MADNESS,			20);
		FW:RegisterBuff(FW.L.FOCUS,				06);
		
		--debuffname,duration,texture
		FW:RegisterDebuff(FW.L.SHADOW_VULNERABILITY,		12,"Interface\\Icons\\Spell_Shadow_ShadowBolt");
	end
	local t1,t2,t3,t4,t5;
	local BP = {};
	local Shards = 0;-- used for checking shard use only
	
	local PetTarget = "";
	local PetSpell = "";
	local PetTime = -1;
	
	local function WL_UpdatePetTarget()
		if PetTime ~= -1 and PetTime <= GetTime() then
			PetTime = -1;
			PetTarget = UnitName("pettarget");
			if PetTarget then
				if PetSpell == FW.L.SEDUCTION then
					FW:CastShow("SeduceStart",PetTarget);
				end
			end
		end
	end

	local function WL_ScanBloodpact(unit)
		local unitClass = select(2,UnitClass(unit));
		local unitName = UnitName(unit);

		if not unitClass or not unitName then return; end

		t1 = strlower(FW.Settings.BloodPactMsg);

		if string.find(t1,strlower(unitName)) or string.find(t1,strlower(unitClass)) or string.find(t1,"all") or (unit == "player" and string.find(t1,"self")) then

			t2 = FW:UnitHasBuff(unit,FW.L.BUFF_BLOOD_PACT);
			if BP[unitName] ~= t2 then
				if FW.Settings.BloodPact then
					if t2 then
						FW:Show(string.format(FW.L._GAINED_BLOOD_PACT,unitName),unpack(FW.Settings.ColorBloodpactGain));
					else
						FW:Show(string.format(FW.L._LOST_BLOOD_PACT,unitName),unpack(FW.Settings.ColorBloodpactLoss));
					end
				end
				BP[unitName] = t2;
			end
		end
	end
	
	local function WL_BloodpactScan()
		
		for i=1,GetNumPartyMembers(),1 do
			WL_ScanBloodpact(FW.PARTY[i]);
		end
		WL_ScanBloodpact("player");
	end
	
	local function WL_IsShard(link)
		if string.find(link,"^|c.-|Hitem:"..FW.ID_SOULSHARD..":") then
			return true;
		else
			return false;
		end
	end
	
	local function WL_IsShardBag(link)
		_,_,link = string.find(link,"^|c.-|Hitem:(.-):");
		return link == "22243" or link == "22244" or link == "21340" or link == "21341" or link == "21342" or link == "21872";
	end
	
	local BagStats = {[0]={},[1]={},[2]={},[3]={},[4]={}};
	local SMP = {};
	
	local function WL_ScanBags()
		if not FW.Settings.ShardManager then return;end
		
		--FW:ShowDebug("Scanning Bag");
		local link;
		local item;
		local bag;
		
		BagStats.shard = 0;
		BagStats.empty = 0;
		BagStats.emptybag = nil;
		BagStats.emptyslot = nil;
		BagStats.shardbag = nil;
		BagStats.shardslot = nil;
		
		SMP[1],SMP[2],SMP[3],SMP[4],SMP[5] = strsplit(",",FW.Settings.ShardManagerPriorMsg);
		
		for k,v in ipairs(SMP) do 
			SMP[k] = tonumber(v);
		end	
		for i=1,5 do
			if not SMP[i] or SMP[i]<0 or SMP[i]>4 then
				--FW:ShowDebug("Wrong bag prior");
				return;	
			end
		end
		for i=1,4 do 
			for j=i+1,5 do
				if (SMP[i] == SMP[j]) then
					--FW:ShowDebug("Wrong bag prior");
					return;
				end
			end
		end
		
		for i=1,5 do
			bag = SMP[i];
			if bag then
				BagStats[bag].size = GetContainerNumSlots(bag);
				BagStats[bag].empty = 0;
				BagStats[bag].shard = 0;
				BagStats[bag].prior = i;
				if bag == 0 or BagStats[bag].size == 0 then
					BagStats[bag].shardbag = false;
				else
					BagStats[bag].shardbag = WL_IsShardBag(GetInventoryItemLink("player", ContainerIDToInventoryID(bag)));
				end
				for slot=1,BagStats[bag].size do
				
					link = GetContainerItemLink(bag,slot);
					if link then
						if WL_IsShard(link) then
							BagStats[bag].shard = BagStats[bag].shard + 1;
							BagStats.shard=BagStats.shard+1;
	
							BagStats.shardbag = bag;
							BagStats.shardslot = slot;
						end
						--_, _, locked = GetContainerItemInfo(bag, slot);
					else
						BagStats[bag].empty = BagStats[bag].empty + 1;
						BagStats.empty=BagStats.empty+1;
	
						if not BagStats.emptybag then
							BagStats.emptybag = bag;
							BagStats.emptyslot = slot;
						end
					end
				end
			end
		end
		
		if FW.Settings.ShardManagerDelete then
			if BagStats.shardbag and not BagStats[BagStats.shardbag].shardbag and ( (FW.Settings.ShardManagerMax>0 and BagStats.shard > FW.Settings.ShardManagerMax) or (BagStats.empty < FW.Settings.ShardManagerFree and BagStats.shard > FW.Settings.ShardManagerMin)) then
				
				ClearCursor();
				PickupContainerItem(BagStats.shardbag,BagStats.shardslot);
				local i1,i2,i3 = GetCursorInfo();
				if i1=="item" and i2 == FW.ID_SOULSHARD then -- make sure i only delete shards in case of bugs
					DeleteCursorItem();
					--FW:ShowDebug("Deleted a Soulshard");
				else
					--FW:ShowDebug("Failed to delete a Soulshard");
					ClearCursor();
				end
				return;
			end
		end
		if FW.Settings.ShardManagerPrior then
			
			if BagStats.emptybag and BagStats.shardbag and BagStats[BagStats.emptybag].prior < BagStats[BagStats.shardbag].prior then
				ClearCursor();
				PickupContainerItem(BagStats.shardbag,BagStats.shardslot);
				local i1,i2,i3 = GetCursorInfo();
				if i1=="item" and i2 == FW.ID_SOULSHARD then -- make sure i only move shards in case of bugs
					if BagStats.emptybag == 0 then
						PutItemInBackpack();
					else
						PutItemInBag(ContainerIDToInventoryID(BagStats.emptybag));
					end
					--FW:ShowDebug("Moved a Soulshard");
				else
					--FW:ShowDebug("Failed to move a Soulshard");
					ClearCursor();
				end	
			end
		end
	end
	local function WL_CastSelfEndMessage(target)
		FW:SendData(FW.SS_CAST_SELF..target);
	end
	local function WL_RegisterShardManager()
		if FW.Settings.ShardManager then
			FW:RegisterToEvent("BAG_UPDATE",WL_ScanBags);
		else
			FW:UnregisterToEvent("BAG_UPDATE",WL_ScanBags);
		end
	end
	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("UpdateInterval",		WL_BloodpactScan);
		WL_RegisterShardManager();
	end);
	
	FW:RegisterUpdatedEvent(WL_UpdatePetTarget);
	FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_START",
	function()
		if arg1 == "pet" then
			local spellName, _, _, spellTexture, startTime, endTime = UnitChannelInfo("pet");
			t1,t2,t3,t4,t5 = 0,0,0,0,0;

			if spellName == FW.L.CONSUME_SHADOWS then
				PetTarget = FW.L.NOTARGET;
			elseif spellName == FW.L.SEDUCTION then

				PetTarget = UnitName("pettarget");
				t1,t2,t3,t4,t5 = FW:CastTargetInfo(PetTarget);
				FW:CastShow("SeduceSuccess",PetTarget);
			else
				PetTarget = UnitName("pettarget") or FW.L.NOTARGET;
			end

			if FW.Modules.Timer then
				FW:INSERT(FW.ST,(endTime-startTime)/1000,GetTime(),(endTime-startTime)/1000,PetTarget,0,4,spellTexture,spellName,t1,t2,t3,0,t4,0,1,0,0,FW:GetFilterType(spellName),t5);
			end
		end
	end);
	FW:RegisterToEvent("UNIT_SPELLCAST_START",		
	function() 
		if arg1 == "pet" then
			PetTime = GetTime() + FW.Settings.PetTargetDelay;
			PetSpell = UnitCastingInfo("pet");
		end
	end);
	if FW.Modules.Casting then
		FW:RegisterOnSelfCastStart(function(s,t)
			if s == FW.L.RITUAL_OF_SUMMONING then
				FW:CastShow("SummonStart",t);
				FW:SummonStartMessage(FW.PLAYER,t);
			elseif s == FW.L.SOULSTONE_RESURRECTION then
				--FW:ShowDebug("SS casting by you");
				FW:CastStartMessage(FW.PLAYER);
				FW:CastShow("SoulstoneStart",t);

			end
		end);
		FW:RegisterOnSelfCastCancel(function(s,t)
			if s == FW.L.SOULSTONE_RESURRECTION then
				FW:CastCancelMessage(FW.PLAYER);
				FW:CastShow("SoulstoneCancel",t); 
			elseif s == FW.L.RITUAL_OF_SUMMONING then
				FW:CastShow("SummonCancel",t);
				FW:SummonCancelMessage(FW.PLAYER,t);

			end
		end);
		FW:RegisterOnSelfCastSuccess(function(s,t,index)
			if s == FW.L.SOULSTONE_RESURRECTION then

				FW:CastShow("SoulstoneSuccess",t);
				WL_CastSelfEndMessage(t);

			elseif s == FW.L.RITUAL_OF_SUMMONING then -- doing this so i keep the proper summoning target saved

				FW:CastShow("SummonFinish",t);

				Shards = FW:GotShards();
				FW:SET(FW.SelfQueue,index,1, FW.L.RITUAL_OF_SUMMONING.." (C)"); -- rename to channeling
				FW:SET(FW.SelfQueue,index,2, 0); -- 
				FW:SET(FW.SelfQueue,index,4, 0); -- set this spell to not finished again

				return true; -- block the remove because i want to keep it for channeling

			elseif s == FW.L.RITUAL_OF_SUMMONING.." (C)" then
				if FW:GotShards() < Shards then -- succes if a shard was used
					FW:CastShow("SummonSuccess",t);
					FW:SummonEndMessage(FW.PLAYER,t);
				else
					FW:CastShow("SummonFailed",t);
					FW:SummonCancelMessage(FW.PLAYER,t);
				end
			elseif s == FW.L.MEETING_STONE_SUMMON.." (C)" then
				FW:SummonEndMessage(FW.PLAYER,t);

			elseif s == FW.L.RITUAL_OF_SOULS then
				FW:CastShow("SoulwellStart",2080*(1+0.1*select(5,GetTalentInfo(2,1))));
			end
		end);
	end
	if FW.Modules.Timer then
		FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_STOP",
		function()
			if arg1 == "pet" then
				for i=1,FW:ROWS(FW.ST),1 do
					if FW:GET(FW.ST,i,6) == 4 then
						FW:REMOVE(FW.ST,i);
						break;
					end
				end
			end
		end);
		FW:RegisterOnTimerBreak(function(unit,mark,spell)
			if spell == FW.L.FEAR then
				if mark~=0 then unit=FW.RaidIcons[mark] or unit;end
				FW:CastShow("FearBreak",unit);
			elseif spell == FW.L.BANISH then
				if mark~=0 then unit=FW.RaidIcons[mark] or unit;end
				FW:CastShow("BanishBreak",unit);
			elseif spell == FW.L.ENSLAVE_DEMON then
				if mark~=0 then unit=FW.RaidIcons[mark] or unit;end
				FW:CastShow("EnslaveBreak",unit);
			end
		end);
		FW:RegisterOnTimerFade(function(unit,mark,spell,time,index)
			if spell == FW.L.FEAR then
				if time <= FW:GetFadeTime("FearFade") then
					if mark~=0 then unit=FW.RaidIcons[mark] or unit;end
					FW:CastShow("FearFade",unit);
					FW:SET(FW.ST,index,12, 1)
				end
			elseif spell == FW.L.BANISH then
				if time <= FW:GetFadeTime("BanishFade") then
					if mark~=0 then unit=FW.RaidIcons[mark] or unit;end
					FW:CastShow("BanishFade",unit);
					FW:SET(FW.ST,index,12, 1)
				end
			elseif spell == FW.L.ENSLAVE_DEMON or spell == FW.L.INFERNO then
				if time <= FW:GetFadeTime("EnslaveFade") then
					if mark~=0 then unit=FW.RaidIcons[mark] or unit;end
					FW:CastShow("EnslaveFade",unit);
					FW:SET(FW.ST,index,12, 1)
				end
			end
		end);
	end
	if FW.Modules.Cooldown then
		FW:RegisterOnCooldownUsed(function(spell)
			if spell == FW.L.DEVOUR_MAGIC then
				FW:CastShow("DevourMagicSuccess",nil);
			elseif spell == FW.L.SPELL_LOCK then
				FW:CastShow("SpellLockSuccess",nil);
			end
		end);
		
		FW:RegisterCooldownBuff(FW.L.FEL_ARMOR);
		FW:RegisterCooldownBuff(FW.L.DEMON_ARMOR);
		FW:RegisterCooldownBuff(FW.L.BURNING_WISH);
		FW:RegisterCooldownBuff(FW.L.FEL_ENERGY);
		FW:RegisterCooldownBuff(FW.L.TOUCH_OF_SHADOW);
		FW:RegisterCooldownBuff(FW.L.FEL_STAMINA);
	end
	
	FW:SetMainCategory(FW.L.RAID_MESSAGES,FW.ICON_MESSAGE,10,"DEFAULT");
		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.RAID_MESSAGES_HINT1);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.RAID_MESSAGES_HINT2);
			FW:RegisterOption(FW.CHK,2,FW.NON,FW.L.SHOW_IN_RAID,	FW.L.SHOW_IN_RAID_TT,	"OutputRaid");
			FW:RegisterOption(FW.MSG,2,FW.NON,FW.L.SHOW_IN_CHANNEL,	FW.L.SHOW_IN_CHANNEL_TT,"Output");
		
		if FW.Modules.Casting then
		FW:SetSubCategory(FW.L.SUMMONING,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SUMMON_START,		"",	"SummonStart");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SUMMON_CANCEL,		"",	"SummonCancel");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SUMMON_PORTAL,		"",	"SummonFinish");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SUMMON_FAILED,		"",	"SummonFailed");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SUMMON_SUCCESS,		"",	"SummonSuccess");
			FW:RegisterOption(FW.MSG,2,FW.NON,FW.L.SUMMON_START_W,		"",	"SummonStartWhisper");
			FW:RegisterOption(FW.MSG,2,FW.NON,FW.L.SUMMON_CANCEL_W,		"",	"SummonCancelWhisper");
			FW:RegisterOption(FW.MSG,2,FW.NON,FW.L.SUMMON_FAILED_W,		"",	"SummonFailedWhisper");
							  
		FW:SetSubCategory(FW.L.SOULSTONE_NORMAL,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SOULTONE_START,		"",	"SoulstoneStart");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SOULTONE_CANCEL,		"",	"SoulstoneCancel");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SOULTONE_SUCCESS,	"",	"SoulstoneSuccess");
			FW:RegisterOption(FW.MSG,2,FW.NON,FW.L.SOULTONE_START_W,	"",	"SoulstoneStartWhisper");
			FW:RegisterOption(FW.MSG,2,FW.NON,FW.L.SOULTONE_CANCEL_W,	"",	"SoulstoneCancelWhisper");
			FW:RegisterOption(FW.MSG,2,FW.NON,FW.L.SOULTONE_SUCCESS_W,	"",	"SoulstoneSuccessWhisper");
			
		FW:SetSubCategory(FW.L.SOULWELL,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SOULWELL_START,		"",	"SoulwellStart");
		end
		FW:SetSubCategory(FW.L.PET,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SEDUCE_START,		"",	"SeduceStart");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SEDUCE_SUCCESS,		"",	"SeduceSuccess");
			if FW.Modules.Cooldown then
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.SPELL_LOCK_SUCCESS,	"",	"SpellLockSuccess");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.DEVOUR_MAGIC_SUCCESS,	"",	"DevourMagicSuccess");
			end
		
		if FW.Modules.Timer then
		FW:SetSubCategory(FW.L.BREAK_FADE,FW.ICON_SPECIFIC,2);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.BREAK_FADE_HINT1);
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.FEAR_BREAK,		"",	"FearBreak");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.FEAR_FADE,		"",	"FearFade");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.BANISH_BREAK,		"",	"BanishBreak");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.BANISH_FADE,		"",	"BanishFade");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.ENSLAVE_BREAK,		"",	"EnslaveBreak");
			FW:RegisterOption(FW.MS2,2,FW.NON,FW.L.ENSLAVE_FADE,		"",	"EnslaveFade");
		end

	FW:SetMainCategory(FW.L.SHARD_MANAGER,FW.ICON_DEFAULT,9,"DEFAULT");
		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.SHARD_MANAGER_HINT1);
			
			FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ENABLE,		FW.L.SHARD_MANAGER_ENABLE_TT,	"ShardManager",		function() WL_RegisterShardManager(); WL_ScanBags();end);
			FW:RegisterOption(FW.MSG,1,FW.NON,FW.L.SHARD_BAG_PRIOR,	FW.L.SHARD_BAG_PRIOR_TT,	"ShardManagerPrior",	WL_ScanBags);
			FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHARD_DELETE,	FW.L.SHARD_DELETE_TT,		"ShardManagerDelete",	WL_ScanBags);
			FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SHARD_MAX,	FW.L.SHARD_MAX_TT,		"ShardManagerMax",	WL_ScanBags);
			FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SHARD_FREE,	FW.L.SHARD_FREE_TT,		"ShardManagerFree",	WL_ScanBags);
			FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SHARD_MIN,	FW.L.SHARD_MIN_TT,		"ShardManagerMin",	WL_ScanBags);
	
	FW:SetMainCategory(FW.L.SELF_MESSAGES,FW.ICON_SELFMESSAGE,11,"DEFAULT");
		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.SELF_MESSAGES_HINT1);
		
		FW:SetSubCategory(FW.L.BLOOD_PACT,FW.ICON_SPECIFIC,2)
			FW:RegisterOption(FW.MSG,1,FW.LEF,FW.L.BLOOD_PACT_ON,	FW.L.BLOOD_PACT_TT,	"BloodPact");
			FW:RegisterOption(FW.COL,1,FW.RIG,FW.L.BLOOD_PACT_GAIN,		"",		"ColorBloodpactGain");
			FW:RegisterOption(FW.COL,1,FW.RIG,FW.L.BLOOD_PACT_LOSS,		"",		"ColorBloodpactLoss");
			
	FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
		FW:SetSubCategory(FW.L.CASTING,FW.ICON_DEFAULT,2);
			FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DELAY_PET_TARGET		,"",		"PetTargetDelay");
	
	FW.Default.PetTargetDelay = 0.5; -- delay between pet cast start and target check
	
	FW.Default.ShardManager = false;
	FW.Default.ShardManagerDelete = false;
	FW.Default.ShardManagerMax = 0;
	FW.Default.ShardManagerMin = 28;
	FW.Default.ShardManagerFree = 2;
	FW.Default.ShardManagerPrior = true;
	FW.Default.ShardManagerPriorMsg = "4,0,1,2,3";
	
	FW.Default.OutputRaid = true;
	FW.Default.Output = true;
	FW.Default.OutputMsg = "MyProWarlockChannel";

	FW.Default.SummonStartWhisper = false;	FW.Default.SummonStartWhisperMsg = ">> You are being Summoned! <<";
	FW.Default.SummonCancelWhisper = false;	FW.Default.SummonCancelWhisperMsg = "<< Your Summon was Cancelled >>";
	FW.Default.SummonFailedWhisper = false;	FW.Default.SummonFailedWhisperMsg = "<< Your Summon Failed >>";

	FW.Default.SoulstoneSuccessWhisper = true;	FW.Default.SoulstoneSuccessWhisperMsg = ">> You are now soulstoned! <<";
	FW.Default.SoulstoneStartWhisper = false;	FW.Default.SoulstoneStartWhisperMsg = ">> Soulstoning you now <<";
	FW.Default.SoulstoneCancelWhisper = false;	FW.Default.SoulstoneCancelWhisperMsg = "<< Soulstoning cancelled >>";

	FW.Default.SummonStart = 1;		FW.Default.SummonStartMsg = "Summoning >> %s << Get Ready";
	FW.Default.SummonFinish = 0;		FW.Default.SummonFinishMsg = "Summoning >> %s << Clicky clicky!"
	FW.Default.SummonCancel = 1;		FW.Default.SummonCancelMsg = "Summoning >> %s << Cancelled";
	FW.Default.SummonFailed = 1;		FW.Default.SummonFailedMsg = "Summoning >> %s << Failed!";
	FW.Default.SummonSuccess = 1;		FW.Default.SummonSuccessMsg = "Summoning >> %s << Successful!"; 
	FW.Default.SoulstoneSuccess = 0;	FW.Default.SoulstoneSuccessMsg = "Soulstoned >> %s << Use it well!";
	FW.Default.SoulstoneStart = 1;		FW.Default.SoulstoneStartMsg = "Soulstoning >> %s << Now";
	FW.Default.SoulstoneCancel = 1;		FW.Default.SoulstoneCancelMsg = "Soulstoning >> %s << Cancelled";

	FW.Default.SeduceSuccess = 0;		FW.Default.SeduceSuccessMsg = "Seduced >> %s << Don't hit it!";
	FW.Default.SeduceStart = 0;		FW.Default.SeduceStartMsg = "Seducing >> %s << Now";
	FW.Default.DevourMagicSuccess = 0;	FW.Default.DevourMagicSuccessMsg = ">> Devour Magic Used <<";
	FW.Default.SpellLockSuccess = 0;	FW.Default.SpellLockSuccessMsg = ">> Spell Lock Used <<";

	FW.Default.SoulwellStart = 0;		FW.Default.SoulwellStartMsg = "Summoning >> %shp Soulwell << Yummie!";

	FW.Default.FearBreak = 0;		FW.Default.FearBreakMsg = ">> Fear on %s Broke Early! <<";
	FW.Default.FearFade = 0;		FW.Default.FearFadeMsg = ">> Fear on %s Fading in 3 seconds! <<";
	FW.Default.BanishBreak = 1;		FW.Default.BanishBreakMsg = ">> Banish on %s Broke Early! <<";
	FW.Default.BanishFade = 1;		FW.Default.BanishFadeMsg = ">> Banish on %s Fading in 3 seconds! <<";
	FW.Default.EnslaveBreak = 1;		FW.Default.EnslaveBreakMsg = ">> Enslave on %s Broke Early! <<";
	FW.Default.EnslaveFade = 1;		FW.Default.EnslaveFadeMsg = ">> Enslave on %s Fading in 3 seconds! <<";

	FW.Default.BloodPact = false;		FW.Default.BloodPactMsg = "warrior self";
	
	if FW.Default.CooldownFilter then
		FW.Default.CooldownFilter[FW.L.DEATH_COIL] = 			{-2,0.00,0.63,0.05};
		FW.Default.CooldownFilter[FW.L.SHADOW_WARD] = 			{-2,0.63,0.00,1.00};
		FW.Default.CooldownFilter[FW.L.RITUAL_OF_SOULS] = 		{-2,0.64,0.21,0.93};
		FW.Default.CooldownFilter[FW.L.SOULSHATTER] = 			{-2,0.00,0.38,1.00};
		FW.Default.CooldownFilter[FW.L.PHASE_SHIFT] = 			{-1};
	end
end
