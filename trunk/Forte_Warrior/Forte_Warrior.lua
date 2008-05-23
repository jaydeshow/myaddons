-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x

if FW.CLASS == "WARRIOR" then
	local FW = FW;
	local WR = FW:ClassModule("Warrior");
	
	if FW.Modules.Timer then
	
		--					istype: 1=magic,2=curse,3=cc,4=pet,(5=powerup),6=enslave/charm,(7=tdebuff)
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture
 		FW:RegisterSpell(FW.L.SUNDER_ARMOR,		1,030,0,3,00,"Interface\\Icons\\Ability_Warrior_Sunder");
		FW:RegisterSpell(FW.L.MORTAL_STRIKE,		1,010,0,7,00,"Interface\\Icons\\Ability_Warrior_SavageBlow");
		FW:RegisterSpell(FW.L.REND,			1,021,1,1,00,"Interface\\Icons\\Ability_Gouge");
		FW:RegisterSpell(FW.L.HAMSTRING,		1,015,0,3,00,"Interface\\Icons\\Ability_ShockWave");
		FW:RegisterSpell(FW.L.THUNDER_CLAP,		1,010,0,3,00,"Interface\\Icons\\Spell_Nature_ThunderClap");
		FW:RegisterSpell(FW.L.DEMORALIZING_SHOUT,	1,030,0,3,00,"Interface\\Icons\\Ability_Warrior_WarCry");     
		FW:RegisterSpell(FW.L.SHIELD_BASH,		1,006,0,3,00,"Interface\\Icons\\Ability_Warrior_ShieldBash");
		   
		   --buffname,duration
		FW:RegisterBuff(FW.L.BLOODRAGE,			10);
		FW:RegisterBuff(FW.L.BATTLE_SHOUT,		120);
		FW:RegisterBuff(FW.L.COMMANDING_SHOUT,		120);
		FW:RegisterBuff(FW.L.ENRAGE,		  	12);
		FW:RegisterBuff(FW.L.RAMPAGE,		  	30);
		FW:RegisterBuff(FW.L.RAGE_OF_THE_UNRAVELLER,    10);
		FW:RegisterBuff(FW.L.FEROCITY,		   	15);
		FW:RegisterBuff(FW.L.SWEEPING_STRIKES,		10);
		FW:RegisterBuff(FW.L.LIGHTNING_SPEED,		15);
		FW:RegisterBuff(FW.L.LUST_FOR_BATTLE,		20);
		FW:RegisterBuff(FW.L.HASTE,		    	10);
		FW:RegisterBuff(FW.L.ANCIENT_POWER,		20);
		FW:RegisterBuff(FW.L.BURNING_HATRED,		15);
		FW:RegisterBuff(FW.L.DEATH_WISH,		30);

		--debuffname,duration,texture
		FW:RegisterDebuff(FW.L.SUNDER_ARMOR,		30,"Interface\\Icons\\Ability_Warrior_Sunder");
		FW:RegisterDebuff(FW.L.MORTAL_STRIKE,		10,"Interface\\Icons\\Ability_Warrior_SavageBlow");
		FW:RegisterDebuff(FW.L.REND,			21,"Interface\\Icons\\Ability_Gouge");
		FW:RegisterDebuff(FW.L.HAMSTRING,		15,"Interface\\Icons\\Ability_ShockWave");
		FW:RegisterDebuff(FW.L.THUNDER_CLAP,		10,"Interface\\Icons\\Spell_Nature_ThunderClap");
		FW:RegisterDebuff(FW.L.DEMORALIZING_SHOUT,	30,"Interface\\Icons\\Ability_Warrior_WarCry");     
		FW:RegisterDebuff(FW.L.SHIELD_BASH,		06,"Interface\\Icons\\Ability_Warrior_ShieldBash");

	end

	if FW.Default.CooldownFilter then

	end
end
