-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x

if FW.CLASS == "PRIEST" then
	local FW = FW;
	local PR = FW:ClassModule("Priest");

	if FW.Modules.Timer then
	
		--						istype: 1=magic,2=curse,3=cc,4=pet,(5=powerup),6=enslave/charm,(7=tdebuff)
		--spell, hastarget, duration, isdot, istype, reducedinpvp, texture
 		
 		FW:RegisterSpell(FW.L.SHADOW_WORD_PAIN,		1,018,1,1,00,"Interface\\Icons\\Spell_Shadow_ShadowWordPain");
			FW:RegisterSpellModSetB(FW.L.SHADOW_WORD_PAIN,	FW.L.ABSOLUTION,2,3);
			FW:RegisterSpellModTlnt(FW.L.SHADOW_WORD_PAIN,	FW.L.IMPROVED_SWP,1,3);
			FW:RegisterSpellModTlnt(FW.L.SHADOW_WORD_PAIN,	FW.L.IMPROVED_SWP,2,6);
		FW:RegisterSpell(FW.L.VAMPIRIC_TOUCH,		1,015,1,1,00,"Interface\\Icons\\Spell_Holy_Stoicism");
 		FW:RegisterSpell(FW.L.VAMPIRIC_EMBRACE,		1,060,0,1,00,"Interface\\Icons\\Spell_Shadow_UnsummonBuilding");
 		FW:RegisterSpell(FW.L.SHADOW_WORD_DEATH,	0,012,0,1,00,"Interface\\Icons\\Spell_Shadow_DemonicFortitude");
 		FW:RegisterSpell(FW.L.SHADOWFIEND,		0,015,0,4,00,"Interface\\Icons\\Spell_Shadow_Shadowfiend");
 		--FW:RegisterSpell(FW.L.POWER_WORD_SHIELD,	1,030,0,1,00,"Interface\\Icons\\Spell_Holy_PowerWordShield");
 		--FW:RegisterSpell(FW.L.WEAKENED_SOUL,		1,015,0,1,00,"Interface\\Icons\\Spell_Holy_AshesToAshes");
  		FW:RegisterSpell(FW.L.PSYCHIC_SCREAM,		0,008,0,3,00,"Interface\\Icons\\Spell_Shadow_PsychicScream");
 		FW:RegisterSpell(FW.L.SHACKLE_UNDEAD,		1,050,0,3,00,"Interface\\Icons\\Spell_Nature_Slow");
			FW:RegisterSpellModRank(FW.L.SHACKLE_UNDEAD, 	1, -20);
			FW:RegisterSpellModRank(FW.L.SHACKLE_UNDEAD, 	2, -10);
		FW:RegisterSpell(FW.L.MIND_SOOTHE,		1,015,0,3,00,"Interface\\Icons\\Spell_Holy_MindSooth");
		       
	       --buffname,duration
		FW:RegisterBuff(FW.L.FADE,				10);
	       
		FW:RegisterBuff(FW.L.ESSENCE_OF_SAPPHIRON,		20);
		FW:RegisterBuff(FW.L.EPHEMERAL_POWER,			15);
		FW:RegisterBuff(FW.L.SPELL_HASTE,			06);
		FW:RegisterBuff(FW.L.UNSTABLE_POWER,			20);
		FW:RegisterBuff(FW.L.BLESSING_OF_THE_SILVER_CRESCENT,	20);
		FW:RegisterBuff(FW.L.RECURRING_POWER,			10);
		FW:RegisterBuff(FW.L.CALL_OF_THE_NEXUS,			10);
		FW:RegisterBuff(FW.L.HEROISM,				40);
		FW:RegisterBuff(FW.L.BLOODLUST,				40);
		FW:RegisterBuff(FW.L.LESSER_SPELL_BLASTING,		10);
		FW:RegisterBuff(FW.L.SPELL_BLASTING,			10);
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

	if FW.Default.CooldownFilter then

	end
end
