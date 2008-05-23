local StatLogic = AceLibrary("StatLogic-1.0");

--------------------------------------------------------------------------------------------------------
--                                                Misc                                                --
--------------------------------------------------------------------------------------------------------

BINDING_HEADER_EXAMINER = "观察助手";
BINDING_NAME_EXAMINER_OPEN = "开启观察助手";
BINDING_NAME_EXAMINER_TARGET = "观察目标";
BINDING_NAME_EXAMINER_MOUSEOVER = "观察鼠标划过目标";

Examiner.Classification = {
	["worldboss"] = "首领",
	["rareelite"] = "稀有精英",
	["elite"] = "精英",
	["rare"] = "稀有",
};

--------------------------------------------------------------------------------------------------------
--                                        Stat Order & Naming                                         --
--------------------------------------------------------------------------------------------------------

Examiner.StatEntryOrder = {
	{	name = "基本属性", 
	  	stats = {
			"STR", 
			"AGI", 
			"STA", 
			"INT", 
			"SPI", 
			"ARMOR",
		},
	},
	{	name = "生命法力", 
		stats = {
			"HEALTH", 
			"MANA", 
			"HEALTH_REG", 
			"MANA_REG",
		} 
	},
	{	name = "攻击属性", 
		stats = {
			"AP", 
			"RANGED_AP", 
			"FERAL_AP", 
			"MELEE_CRIT_RATING", 
			"MELEE_HIT_RATING", 
			"MELEE_HASTE_RATING", 
			"MELEE_DMG", 
--		  	"RANGEDDMG", 
		  	"IGNORE_ARMOR",
			"EXPERTISE_RATING",
		},
	},
	{	name = "武器技能", 
		stats = {
			"WPNSKILL_SWORD", 
			"WPNSKILL_MACE", 
			"WPNSKILL_AXE", 
			"WPNSKILL_DAGGER", 
			"WPNSKILL_FIST", 
			"WPNSKILL_SWORD_2H", 
			"WPNSKILL_MACE_2H", 
			"WPNSKILL_AXE_2H", 
			"WPNSKILL_FERAL", 
			"WPNSKILL_BOW", 
			"WPNSKILL_GUN", 
			"WPNSKILL_CROSSBOW",
		},
	},
	{	name = "法术属性", 
		stats = {
			"HEAL", 
			"SPELL_DMG", 
			"SPELL_DMG_UNDEAD",
			"SPELL_DMG_DEMON",
			"ARCANE_SPELL_DMG", 
			"FIRE_SPELL_DMG", 
			"NATURE_SPELL_DMG", 
			"FROST_SPELL_DMG", 
			"SHADOW_SPELL_DMG", 
			"HOLY_SPELL_DMG", 
			"SPELL_CRIT_RATING", 
			"SPELL_HIT_RATING", 
			"SPELL_HASTE_RATING", 
			"SPELLPEN",
		},
	},
	{	name = "防御属性", 
		stats = {
			"DEFENSE_RATING", 
			"DODGE_RATING", 
			"PARRY_RATING", 
			"BLOCK_RATING", 
			"BLOCK_VALUE", 
			"RESILIENCE_RATING",
		}
	},
};

ExScanner.StatNames = {};
for _, tab in pairs(Examiner.StatEntryOrder) do 
	for _, id in pairs(tab.stats) do
		ExScanner.StatNames[id] = StatLogic:GetStatNameFromID(id);
	end
end
