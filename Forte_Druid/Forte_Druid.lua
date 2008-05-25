-- Forte Class Addon v0.985 by Lurosara 26-04-2008 for Patch 2.4.x
-- Shamelessly cribbed from Xus' Forte Warrior module.

-- TODO:
-- Forte_Timer:
--   Feral: Feral Charge Effect (Possibly too painful to implement in a reasonable manner.)
--   Resto: Nordrassil Raiment (2 piece, +6 sec on Regrowth.)
--   Resto: Make HoT tracking work. (Not sure if this is even worth it.)
-- Forte_Cooldown:
--   Feral: Fix Prowl cooldown display some how.
-- General:
--   Add more trinkets.

if FW.CLASS == "DRUID" then
	local FW = FW;
	local WR = FW:ClassModule("Druid");

	--
	-- Spell Timer
	--
	-- Note that the Cyclone timer is always going to be inaccurate past the first cast because
	-- it has diminishing returns in PvE.
	if FW.Modules.Timer then
		--
		-- Code for dealing with set bonuses.
		-- XXX: This should really live in Forte_Timer/Forte_Core, and should probably be implemented
		-- in a cleaner manner.
		--
		-- What we do here is thus.  We register our set bonus with Forte_Timer/Forte_Core with
		-- a name that is guaranteed to not match, and then bank on the fact that since we are
		-- the last Forte module to register a handler for UNIT_INVENTORY_CHANGED, we will have
		-- ours called last.
		--
		-- In our handler of doom we will do our actual processing, and go and manually fix up
		-- the set item count.  *sighs* It's dirty as all hell, but it works.
		--
		local FWSetBonusByIDs = {};

		local function RegisterSpellModSetBByIDs(spell,setb,settbl,num,mod)
			FW:RegisterSpellModSetB(spell,setb,num,mod);
			FWSetBonusByIDs[setb] = settbl;
		end

		local function FW_RelevantSetBonusByIDs()
			for k, v in pairs(FWSetBonusByIDs) do
				FW.SetBonus[k] = 0;
			end
			-- XXX: Ewwwwwwww, this is kind of inefficient.
			for i=1,12,1 do -- from head to 2nd ring
				local itemLink = GetInventoryItemLink("player",i);
				if itemLink then
					local _,_,itemId = strfind(GetInventoryItemLink("player",i), "(%d+):")
					local itemId = tonumber(itemId);

					for k, v in pairs(FWSetBonusByIDs) do
						for idx, val in ipairs(v) do
							if val == itemId then
								FW.SetBonus[k] = FW.SetBonus[k] + 1;
							end
						end
					end
				end
			end
		end

		FW:RegisterToEvent("UNIT_INVENTORY_CHANGED",	FW_RelevantSetBonusByIDs);

		--
		-- Some static Druid specific definitions.
		--
		-- See the implementation note regarding the "improved" set bonus scanning code
		-- as to why this stuff is defined here. (The name isn't actually expected to match
		-- against anything, so it doesn't need to be localized.)
		--
		FW.L.THUNDERHEART_REGALIA = "Thunderheart Regalia";
		local Thunderheart_Regalia = { 31043, 31035, 31040, 31046, 31049, 34572, 34446, 34555 };

		--
		-- Spells
		--					istype: 1=magic,2=curse,3=cc,4=pet,(5=powerup),6=enslave/charm,(7=tdebuff)
		-- spell, hastarget, duration, isdot, istype, reducedinpvp, texture
		--

		-- Balance Spells
		FW:RegisterSpell(FW.L.CYCLONE,			1,006,0,3,06,"Interface\\Icons\\Spell_Nature_EarthBind");
		FW:RegisterSpell(FW.L.ENTANGLING_ROOTS,	1,027,0,3,12,"Interface\\Icons\\Spell_Nature_StrangleVines");
			FW:RegisterSpellModRank(FW.L.ENTANGLING_ROOTS, 1, -15);
			FW:RegisterSpellModRank(FW.L.ENTANGLING_ROOTS, 2, -12);
			FW:RegisterSpellModRank(FW.L.ENTANGLING_ROOTS, 3, -9);
			FW:RegisterSpellModRank(FW.L.ENTANGLING_ROOTS, 4, -6);
			FW:RegisterSpellModRank(FW.L.ENTANGLING_ROOTS, 5, -3);
		FW:RegisterSpell(FW.L.FAERIE_FIRE,		1,040,0,1,00,"Interface\\Icons\\Spell_Nature_FaerieFire");
		FW:RegisterSpell(FW.L.FORCE_OF_NATURE,	0,030,0,4,00,"Interface\\Icons\\Ability_Druid_ForceofNature");
		FW:RegisterSpell(FW.L.HIBERNATE,			1,040,0,3,12,"Interface\\Icons\\Spell_Nature_Sleep");
			FW:RegisterSpellModRank(FW.L.HIBERNATE, 1, -20);
			FW:RegisterSpellModRank(FW.L.HIBERNATE, 2, -10);
		FW:RegisterSpell(FW.L.INSECT_SWARM,		1,012,1,1,00,"Interface\\Icons\\Spell_Nature_InsectSwarm");
		FW:RegisterSpell(FW.L.MOONFIRE,			1,012,1,1,00,"Interface\\Icons\\Spell_Nature_StarFall");
			RegisterSpellModSetBByIDs(FW.L.MOONFIRE, FW.L.THUNDERHEART_REGALIA,Thunderheart_Regalia,2,3);

		-- Feral Spells
		FW:RegisterSpell(FW.L.BASH,				1,004,0,3,00,"Interface\\Icons\\Ability_Druid_Bash");
			FW:RegisterSpellModTlnt(FW.L.BASH,	FW.L.BRUTAL_IMPACT,1,0.5);
			FW:RegisterSpellModTlnt(FW.L.BASH,	FW.L.BRUTAL_IMPACT,2,1);
		FW:RegisterSpell(FW.L.DEMORALIZING_ROAR,	1,030,0,3,00,"Interface\\Icons\\Ability_Druid_DemoralizingRoar");
		FW:RegisterSpell(FW.L.CHALLENGING_ROAR,	1,006,0,3,00,"Interface\\Icons\\Ability_Druid_ChallangingRoar");
		FW:RegisterSpell(FW.L.FAERIE_FIRE_FERAL,	1,040,0,1,00,"Interface\\Icons\\Spell_Nature_FaerieFire");
		FW:RegisterSpell(FW.L.GROWL,			1,003,0,3,00,"Interface\\Icons\\Ability_Physical_Taunt");
		FW:RegisterSpell(FW.L.LACERATE,			1,015,1,1,00,"Interface\\Icons\\Ability_Druid_Lacerate");
		FW:RegisterSpell(FW.L.MANGLE_BEAR,		1,012,0,1,00,"Interface\\Icons\\Ability_Druid_Mangle2");
		FW:RegisterSpell(FW.L.MANGLE_CAT,		1,012,0,1,00,"Interface\\Icons\\Ability_Druid_Mangle2");
		FW:RegisterSpell(FW.L.POUNCE,			1,003,0,1,00,"Interface\\Icons\\Ability_Druid_SupriseAttack");
			FW:RegisterSpellModTlnt(FW.L.POUNCE,	FW.L.BRUTAL_IMPACT,1,0.5);
			FW:RegisterSpellModTlnt(FW.L.POUNCE,	FW.L.BRUTAL_IMPACT,2,1);
		FW:RegisterSpell(FW.L.RAKE,				1,009,1,1,00,"Interface\\Icons\\Ability_Druid_Disembowel");
		FW:RegisterSpell(FW.L.RIP,				1,012,1,1,00,"Interface\\Icons\\Ability_GhoulFrenzy");

		-- Resto Spells
--		FW:RegisterSpell(FW.L.INNERVATE,		1,020,0,1,00,"Interface\\Icons\\Spell_Nature_Lightning");
--		FW:RegisterSpell(FW.L.ABOLISH_POISON,		1,008,1,1,00,"Interface\\Icons\\Spell_Nature_NullifyPoison_02");
--		FW:RegisterSpell(FW.L.LIFEBLOOM,		1,006,1,1,00,"Interface\\Icons\\INV_Misc_Herb_Felblossom");
--		FW:RegisterSpell(FW.L.REGROWTH,			1,021,1,1,00,"Interface\\Icons\\Spell_Nature_ResistNature");
--		FW:RegisterSpell(FW.L.REJUVENATION,		1,012,0,1,00,"Interface\\Icons\\Spell_Nature_Rejuvenation");

		--
		-- Buffs
		-- buffname,duration
		--

		-- Balance Buffs
		FW:RegisterBuff(FW.L.BARKSKIN,				12);
		FW:RegisterBuff(FW.L.NATURES_GRASP,			45);
		FW:RegisterBuff(FW.L.NATURES_GRACE,			12);
		FW:RegisterBuff(FW.L.ABOLISH_POISON,			8);
		FW:RegisterBuff(FW.L.LIFEBLOOM,  			6);
		FW:RegisterBuff(FW.L.REGROWTH,				21);
		FW:RegisterBuff(FW.L.REJUVENATION,			12);
		FW:RegisterBuff(FW.L.INNERVATE,				20);

		-- Feral Buffs
		FW:RegisterBuff(FW.L.DASH,				15);
		FW:RegisterBuff(FW.L.ENRAGE,				10);
		FW:RegisterBuff(FW.L.FRENZIED_REGENERATION,	        10);
		FW:RegisterBuff(FW.L.TIGERS_FURY,			06);

		FW:RegisterBuff(FW.L.NURTURE,				15); -- 2 piece Feral T5

		-- Resto Buffs
		FW:RegisterBuff(FW.L.CLEARCASTING,			15);
		FW:RegisterBuff(FW.L.NATURAL_PERFECTION,		8);
		FW:RegisterBuff(FW.L.ANCIENT_POWER,                     20);
		FW:RegisterBuff(FW.L.HEROISM,                           20);

		-- Balance Procs/Trinkets
		FW:RegisterBuff(FW.L.AURA_OF_THE_CRUSADE,		10); -- Darkmoon Card: Crusade
		FW:RegisterBuff(FW.L.BAND_OF_THE_ETERNAL_SAGE,	        15); -- Band of the Eternal Sage
		FW:RegisterBuff(FW.L.BLESSING_OF_THE_SILVER_CRESCENT,	20); -- Icon of the Silver Crescent

		-- Feral Procs/Trinkets
		FW:RegisterBuff(FW.L.PRIMAL_INSTINCT,			10); -- Idol of Terror
		FW:RegisterBuff(FW.L.CALL_OF_THE_BERSERKER,	        20); -- Berserker's Call
		FW:RegisterBuff(FW.L.TIMES_FAVOR,			10); -- Moroes' Lucky Pocket Watch
		FW:RegisterBuff(FW.L.PROTECTORS_VIGOR,		        15); -- Shadowmoon Insignia
		FW:RegisterBuff(FW.L.HEIGHTENED_REFLEXES,		20); -- Badge of Tenacity

		--
		-- A few things are kind of hard to track.
		--
		if FW.Modules.Casting then
			FW:RegisterOnSelfCastSuccess(function(s,t,index)
				FW:ShowDebug("FW:Druid Spell Hook s:"..s.." t:"..t.." idx:"..index);

				-- Maim has dynamic duration based on combo points.
				if s == FW.L.MAIM then
					local spellName = FW.L.MAIM;
					local t1,t2,t3,t4,t5 = 0,0,0,0,0;
					local startTime = GetTime();
					local endTime = startTime + (GetComboPoints() + 1) * 1000;
					local spellTexture = "Interface\\Icons\\Ability_Druid_Mangle";

					t1,t2,t3,t4,t5 = FW:CastTargetInfo(t);
					FW:INSERT(FW.ST,(endTime-startTime)/1000,GetTime(),(endTime-startTime)/1000,t,0,3,spellTexture,spellName,t1,t2,t3,0,t4,0,1,0,0,FW:GetFilterType(spellName),t5);
				end

				-- Pounce Bleed requires special handling.
				if s == FW.L.POUNCE then
					local spellName = FW.L.POUNCE_BLEED;
					local t1,t2,t3,t4,t5 = 0,0,0,0,0;
					local startTime = GetTime();
					local endTime = startTime + 18 * 1000;
					local spellTexture = "Interface\\Icons\\INV_Misc_MonsterFang_01";

					t1,t2,t3,t4,t5 = FW:CastTargetInfo(t);
					FW:INSERT(FW.ST,(endTime-startTime)/1000,GetTime(),(endTime-startTime)/1000,t,0,1,spellTexture,spellName,t1,t2,t3,0,t4,0,1,0,0,FW:GetFilterType(spellName),t5);
				end

				-- Mangle also requires special handling.
				--
				-- This is because Mangle (Bear) and Mangle (Cat) do not stack.
				-- Whichever was cast last should just overwrite the old debuff.
				--
				-- FIXME: This is kind of cumbersome, but I can't figure out a
				-- better way to do this.
				if s == FW.L.MANGLE_BEAR or s == FW.L.MANGLE_CAT then
					local searchStr;

					if s == FW.L.MANGLE_BEAR then
						searchStr = FW.L.MANGLE_CAT;
					else
						searchStr = FW.L.MANGLE_BEAR;
					end

					local i = 1;
					while i <= FW:ROWS(FW.ST) do
						local t1,t2,t3,t4,t5,t6,t7,t8,t9 = FW:GET(FW.ST,i);
						FW:ShowDebug("FW:Druid Mangle Scan:"..t1.." "..t2.." "..t3.." "..t4.." "..t5.." "..t6.." "..t7.." "..t8.." "..t9);
						if t8 == searchStr then
							FW:ShowDebug("FW:Druid Mangle found, removing...");
							FW:REMOVE(FW.ST,i);
						else
							i=i+1;
						end
					end
				end
			end);
		end

		--
		-- Debuffs
		-- debuffname,duration,texture
		--

		-- Feral Debuffs
		FW:RegisterDebuff(FW.L.LACERATE,			015,"Interface\\Icons\\Ability_Druid_Lacerate");
	end

	--
	-- Cooldown Timer
	--
	if FW.Modules.Cooldown then
		--
		-- Buffs
		-- 
		-- Note: One day, this will correctly track Clearcasting/Nature's Gasp/Nature's Grace.
		-- For now, don't bother.
		--

		-- Balance buffs
		FW:RegisterCooldownBuff(FW.L.BARKSKIN);
		FW:RegisterCooldownBuff(FW.L.THORNS);

		-- Resto buffs
		FW:RegisterCooldownBuff(FW.L.GIFT_OF_THE_WILD);
		FW:RegisterCooldownBuff(FW.L.MARK_OF_THE_WILD);
		FW:RegisterCooldownBuff(FW.L.OMEN_OF_CLARITY);

		--
		-- Powerups
		--
		-- Note: This stuff, like the spelltimer entries I registered earlier *really*
		-- should live in a separate trinket tracking module.
		--

		-- Balance Procs/Trinkets
		FW:RegisterCooldownPowerup(FW.L.AURA_OF_THE_CRUSADE); -- Darkmoon Card: Crusade
		FW:RegisterCooldownPowerup(FW.L.BAND_OF_THE_ETERNAL_SAGE); -- Band of the Eternal Sage
		FW:RegisterCooldownPowerup(FW.L.BLESSING_OF_THE_SILVER_CRESCENT); -- Icon of the Silver Crescent

		-- Feral Procs/Trinkets
		FW:RegisterCooldownPowerup(FW.L.PRIMAL_INSTINCT); -- Idol of Terror
		FW:RegisterCooldownPowerup(FW.L.CALL_OF_THE_BERSERKER); -- Berserker's Call
		FW:RegisterCooldownPowerup(FW.L.TIMES_FAVOR); -- Moroes' Lucky Pocket Watch
		FW:RegisterCooldownPowerup(FW.L.PROTECTORS_VIGOR); -- Shadowmoon Insignia
		FW:RegisterCooldownPowerup(FW.L.HEIGHTENED_REFLEXES); -- Badge of Tenacity

		--
		-- Prowl cooldown should only be tracked when we exit stealth.
		--
--		FW:RegisterOnCooldownUsed(function(s)
--			FW:ShowDebug("FW:Druid Cooldown Hook s:"..s);
--			if s == FW.L.PROWL then
--				if FW:PlayerHasBuff(s) == nil then
--					FW:ShowDebug("FW:Druid Prowl cast detected.");
--					-- Do a dirty thing and just obliterate the cooldown.
--					-- Rather, I would but I can't, since the cooldown list is local to Forte_Cooldown. :( 
--				end
--			end
--		end);
	end

	if FW.Default.CooldownFilter then

	end
end
