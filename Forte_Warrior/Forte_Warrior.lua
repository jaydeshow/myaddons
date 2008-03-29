-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x

if FW.CLASS == "WARRIOR" then
	local FW = FW;
	local WR = FW:ClassModule("Warrior");
	
	if FW.Modules.Timer then
	
		--					istype: 1=magic,2=curse,3=cc,4=pet,(5=powerup),6=enslave/charm,(7=tdebuff)
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture
 		FW:RegisterSpell(FW.L.SUNDER_ARMOR,		1,030,0,3,00,"Interface\\Icons\\Ability_Warrior_Sunder");
	       
	       --buffname,duration
		FW:RegisterBuff(FW.L.BATTLE_SHOUT,		120);
		FW:RegisterBuff(FW.L.COMMANDING_SHOUT,		120);
		FW:RegisterBuff(FW.L.ENRAGE,			12);
		FW:RegisterBuff(FW.L.RAMPAGE,			30);
		FW:RegisterBuff(FW.L.RAGE_OF_THE_UNRAVELLER,	10);
		FW:RegisterBuff(FW.L.FEROCITY,			15);
		FW:RegisterBuff(FW.L.SWEEPING_STRIKES,		10);
		FW:RegisterBuff(FW.L.LIGHTNING_SPEED,		15);
		FW:RegisterBuff(FW.L.LUST_FOR_BATTLE,		20);
		FW:RegisterBuff(FW.L.HASTE,			10);
		FW:RegisterBuff(FW.L.ANCIENT_POWER,		20);
		FW:RegisterBuff(FW.L.BURNING_HATRED,		15);

		--debuffname,duration,texture
		FW:RegisterDebuff(FW.L.SUNDER_ARMOR,		30,"Interface\\Icons\\Ability_Warrior_Sunder");
	end

	if FW.Default.CooldownFilter then

	end
end
