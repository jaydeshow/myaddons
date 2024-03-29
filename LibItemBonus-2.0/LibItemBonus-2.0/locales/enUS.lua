local locale = GetLocale()

if locale ~= "enUS" and locale ~= "enGB" then return end

local lib = LibStub("LibItemBonus-2.0")
local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}
local HEAL_AND_DMG = {"HEAL", "DMG"}

lib.patterns = {
	NAMES = {
		STR = "Strength",
		AGI = "Agility",
		STA = "Stamina",
		INT = "Intellect",
		SPI = "Spirit",
		ARMOR = "Armor",
		BASE_ARMOR = "Base Armor",
		ARMOR_BONUS = "Armor Bonus",

		ARCANERES = "Arcane Resistance",
		FIRERES = "Fire Resistance",
		NATURERES = "Nature Resistance",
		FROSTRES = "Frost Resistance",
		SHADOWRES = "Shadow Resistance",

		FISHING = "Fishing",
		MINING = "Mining",
		HERBALISM = "Herbalism",
		SKINNING = "Skinning",
		DEFENSE = "Defense",

		BLOCK = "Chance to Block",
		BLOCKVALUE = "Block value",
		DODGE = "Dodge",
		PARRY = "Parry",
		ATTACKPOWER = "Attack Power",
		ATTACKPOWERUNDEAD = "Attack Power against Undead",
		ATTACKPOWERBEAST = "Attack Power against Beasts",
		ATTACKPOWERFERAL = "Attack Power in feral form",
		CRIT = "Crit. hits",
		RANGEDATTACKPOWER = "Ranged Attack Power",
		RANGEDCRIT = "Crit. Shots",
		TOHIT = "Chance to Hit",
		IGNOREARMOR = "Ignore Armor",
		THREATREDUCTION = "Reduced Threat",

		DMG = "Spell Damage",
		DMGUNDEAD = "Spell Damage against Undead",
		ARCANEDMG = "Arcane Damage",
		FIREDMG = "Fire Damage",
		FROSTDMG = "Frost Damage",
		HOLYDMG = "Holy Damage",
		NATUREDMG = "Nature Damage",
		SHADOWDMG = "Shadow Damage",
		SPELLCRIT = "Crit. Spell",
		SPELLTOHIT = "Chance to Hit with spells",
		SPELLPEN = "Spell Penetration",
		HEAL = "Healing",
		HOLYCRIT = "Crit. Holy Spell",

		HEALTHREG = "Life Regeneration",
		MANAREG = "Mana Regeneration",
		HEALTH = "Life Points",
		MANA = "Mana Points",

		CR_WEAPON = "Weapon rating",
		CR_DEFENSE = "Defense rating",
		CR_DODGE = "Dodge rating",
		CR_PARRY = "Parry rating",
		CR_BLOCK = "Block rating",
		CR_HIT = "Hit rating",
		CR_CRIT = "Critical strike rating",
		CR_HASTE = "Haste rating",
		CR_SPELLHIT = "Hit with spell rating",
		CR_SPELLCRIT = "Critical strike with spell rating",
		CR_SPELLHASTE = "Spell haste rating",
		CR_RESILIENCE = "Resilience",
		CR_WEAPON_AXE = "Axe skill rating",
		CR_WEAPON_DAGGER = "Dagger skill rating",
		CR_WEAPON_MACE = "Mace skill rating",
		CR_WEAPON_SWORD = "Sword skill rating",
		CR_WEAPON_SWORD_2H = "Two-Handed Swords skill rating",
		SNARERES = "Snare and Root effects Resistance",
	},

	PATTERNS_SKILL_RATING = {
		{ pattern = "Increases your (.*) rating by (%d+)" },
		{ pattern = "Increases (.*) rating by (%d+)" },
		{ pattern = "Improves your (.*) rating by (%d+)" },
		{ pattern = "Improves (.*) rating by (%d+)" },
	},

	SKILL_NAMES = {
		["hit"] = "CR_HIT",
		["critical strike"] = "CR_CRIT",
		["ranged critical strike"] = "CR_RANGEDCRIT",
		["defense"] = "CR_DEFENSE",
		["spell critical strike"] = "CR_SPELLCRIT",
		["resilience"] = "CR_RESILIENCE",
		["spell hit"] = "CR_SPELLHIT",
		["dodge"] = "CR_DODGE",
		["block"] = "CR_BLOCK",
		["parry"] = "CR_PARRY",
		["axe skill"] = "CR_WEAPON_AXE",
		["dagger skill"] = "CR_WEAPON_DAGGER",
		["mace skill"] = "CR_WEAPON_MACE",
		["sword skill"] = "CR_WEAPON_SWORD",
		["two-handed sword skill"] = "CR_WEAPON_SWORD_2H",
		["feral combat skill"] = "CR_WEAPON_FERAL",
		["shield block"] = "CR_BLOCK",
		["haste"] = "CR_HASTE",
		["spell haste"] = "CR_SPELLHASTE",
		["unarmed skill"] = "CR_WEAPON_FIST",
		["fist skill"] = "CR_WEAPON_FIST",
		["crossbow skill"] = "CR_WEAPON_CROSSBOW",
		["gun skill"] = "CR_WEAPON_GUN",
		["bow skill"] = "CR_WEAPON_BOW",
		["staff skill"] = "CR_WEAPON_STAFF",
		["two-handed maces skill"] = "CR_WEAPON_MACE_2H",
		["two-handed axes skill"] = "CR_WEAPON_AXE_2H",
		["expertise"] = "CR_EXPERTISE",
	},


	PATTERNS_PASSIVE = {
		{ pattern = "Increases ranged attack power by (%d+)%.", effect = "RANGEDATTACKPOWER" },
		{ pattern = "Increases the block value of your shield by (%d+)%.", effect = "BLOCKVALUE" },
		{ pattern = "Increases damage done by Arcane spells and effects by up to (%d+)%.", effect = "ARCANEDMG" },
		{ pattern = "Increases damage done by Fire spells and effects by up to (%d+)%.", effect = "FIREDMG" },
		{ pattern = "Increases damage done by Frost spells and effects by up to (%d+)%.", effect = "FROSTDMG" },
		{ pattern = "Increases damage done by Holy spells and effects by up to (%d+)%.", effect = "HOLYDMG" },
		{ pattern = "Increases damage done by Nature spells and effects by up to (%d+)%.", effect = "NATUREDMG" },
		{ pattern = "Increases damage done by Shadow spells and effects by up to (%d+)%.", effect = "SHADOWDMG" },
		{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
		{ pattern = "Increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects%.", effect = HEAL_AND_DMG },
		{ pattern = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Increases damage done to Undead by magical spells and effects by up to (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
		{ pattern = "Increases damage done to Demons by magical spells and effects by up to (%d+)%.", effect = "DMGDEMON" },
		{ pattern = "Increases damage done to Undead and Demons by magical spells and effects by up to (%d+)%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },
		{ pattern = "Increases attack power by (%d+) when fighting Undead%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
		{ pattern = "Increases attack power by (%d+) when fighting Beasts%.", effect = "ATTACKPOWERBEAST" },
		{ pattern = "Increases attack power by (%d+) when fighting Demons%.", effect = "ATTACKPOWERDEMON" },
		{ pattern = "Increases attack power by (%d+) when fighting Elementals%.", effect = "ATTACKPOWERELEMENTAL" }, -- 18310
		{ pattern = "Increases attack power by (%d+) when fighting Dragonkin%.", effect = "ATTACKPOWERDRAGON" }, -- 19961
		{ pattern = "Increases attack power by (%d+) when fighting Undead and Demons%.", effect = {"ATTACKPOWERUNDEAD", "ATTACKPOWERDEMON"}, nofinish = true }, -- 23206
		{ pattern = "Restores (%d+) health per 5 sec%.", effect = "HEALTHREG" },
		{ pattern = "Restores (%d+) health every 5 sec%.", effect = "HEALTHREG" }, -- 833, 17743
		{ pattern = "Restores (%d+) mana per 5 sec%.", effect = "MANAREG" },
		{ pattern = "Your attacks ignore (%d+) of your opponent's armor.", effect = "IGNOREARMOR" },

		-- Atiesh related patterns
		{ pattern = "Increases your spell damage by up to (%d+) and your healing by up to (%d+)%.", effect = {"DMG", "HEAL"} },
		{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = "HEAL" },
		{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = HEAL_AND_DMG },
		{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
		{ pattern = "Increases the spell critical chance of all party members within %d+ yards by (%d+)%%%.", effect = "SPELLCRIT" },

		-- Added for HealPoints
		{ pattern = "Allow (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},
		{ pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"},
		{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
		{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
		{ pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
		{ pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
		{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
		{ pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
		{ pattern = "Increases healing done by Rejuvenation by up to (%d+)%.", effect = "IMPREJUVENATION"},
		{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "Increases healing done by Flash of Light by up to (%d+)%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
		{ pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
		{ pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
		{ pattern = "Reduces the mana cost of your Renew spell by (%d+)%%%.", effect = "CHEAPERRENEW"},

		{ pattern = "Increases your spell penetration by (%d+)%.", effect = "SPELLPEN" },
		{ pattern = "Increases attack power by (%d+)%.", effect = "ATTACKPOWER" },
		{ pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
		{ pattern = "Restores (%d+) health every 4 sec%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
		{ pattern = "Increases your effective stealth level by (%d+)%.", effect = "STEALTH" },
		{ pattern = "Increases ranged attack speed by (%d+)%%%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
		{ pattern = "Gives (%d+) additional stamina to party members within %d+ yards%.", effect = "STA" }, -- 4248
		{ pattern = "Increases swim speed by (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
		{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
		{ pattern = "Increases run speed by (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
		{ pattern = "Decreases your chance to parry an attack by (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
		{ pattern = "Increases your chance to resist Stun and Fear effects by (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
		{ pattern = "Increases your chance to resist Fear effects by (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
		{ pattern = "Increases your chance to resist Stun and Disorient effects by (%d+)%%%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
		{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 25653
		{ pattern = "Reduces melee damage taken by (%d+)%.", effect = "MELEETAKEN" }, -- 31154
		{ pattern = "Spell Damage received is reduced by (%d+)%.", effect = "DMGTAKEN" }, -- 22191
		{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CR_RANGEDCRIT" },

		-- metagem bonuses (thanks Lerkur)
		{ pattern = "%+(%d+) Agility & (%d+)%% Increased Critical Damage", effect = {"AGI", "CRITDMG"} },
		{ pattern = "%+(%d+) Spell Critical & (%d+)%% Increased Critical Damage", effect = {"CR_SPELLCRIT", "SPELLCRITDMG"} },
		{ pattern = "%+(%d+) Spell Damage & %+(%d+)%% Intellect", effect = {HEAL_AND_DMG, "MOD_INT"} },
		{ pattern = "%+(%d+) Defense Rating & %+(%d+)%% Shield Block Value", effect = {"CR_DEFENSE", "MOD_BLOCKVALUE"} },
	},

	SEPARATORS = { "/", ",", "&", " and " },
	
	HEAL_AND_DMG_PATTERNS = {
		["%+(%d+) Healing and %+(%d+) Spell Damage"] = false,
		["%+(%d+) Healing Spells and %+(%d+) Damage Spells"] = false,
		["%+(%d+) Healing %+(%d+) Spell Damage"] = false,
	},

	GENERIC_PATTERNS = {
		["^%+?(%d+)%%?(.*)$"]	= true,
		["^(.*)%+ ?(%d+)%%?$"]	= false,
		["^(.*): ?(%d+)$"]		= false
	},

	PATTERNS_GENERIC_LOOKUP = {
		["All Stats"] = ALL_STATS,
		["Strength"] = "STR",
		["Agility"] = "AGI",
		["Stamina"] = "STA",
		["Intellect"] = "INT",
		["Spirit"] = "SPI",

		["All Resistances"] = ALL_RESISTS,

		["Fishing"] = "FISHING",
		["Fishing Lure"] = "FISHING",
		["Increased Fishing"] = "FISHING",
		["Mining"] = "MINING",
		["Herbalism"] = "HERBALISM",
		["Skinning"] = "SKINNING",
		["Defense"] = "CR_DEFENSE",
		["Increased Defense"] = "DEFENSE",

		["Attack Power"] = "ATTACKPOWER",
		["Attack Power when fighting Undead"] = "ATTACKPOWERUNDEAD",

		["Dodge"] = "DODGE",
		["Block"] = "BLOCKVALUE",
		["Block Value"] = "BLOCKVALUE",
		["Hit"] = "TOHIT",
		["Spell Hit"] = "SPELLTOHIT",
		["Blocking"] = "BLOCK",
		["Ranged Attack Power"] = "RANGEDATTACKPOWER",
		["health every 5 sec"] = "HEALTHREG",
		["Healing Spells"] = "HEAL",
		["Increases Healing"] = "HEAL",
		["Healing"] = "HEAL",
		["healing Spells"] = "HEAL",
		["Healing and Spell Damage"] = HEAL_AND_DMG,
		["Damage and Healing Spells"] = HEAL_AND_DMG,
		["Spell Damage and Healing"] = HEAL_AND_DMG,
		["Spell Power"] = HEAL_AND_DMG,
		["Spell Damage"] = HEAL_AND_DMG,
		["Critical"] = "CRIT",
		["Critical Hit"] = "CRIT",
		["Health"] = "HEALTH",
		["HP"] = "HEALTH",
		["Mana"] = "MANA",
		["Armor"] = "BASE_ARMOR",
		["Reinforced Armor"] = "ARMOR_BONUS",
		["Resilience"] = "CR_RESILIENCE",
		["Spell Critical strike rating"] = "CR_SPELLCRIT",
		["Spell Penetration"] = "SPELLPEN",
		["Hit Rating"] = "CR_HIT",
		["Defense Rating"] = "CR_DEFENSE",
		["Resilience Rating"] = "CR_RESILIENCE",
		["Crit Rating"] = "CR_CRIT",
		["Critical Rating"] = "CR_CRIT",
		["Critical Strike Rating"] = "CR_CRIT",
		["Dodge Rating"] = "CR_DODGE",
		["Parry Rating"] = "CR_PARRY",
		["Spell Critical Strike Rating"] = "CR_SPELLCRIT",
		["Spell Critical Rating"] = "CR_SPELLCRIT",
		["Spell Critical"] = "CR_SPELLCRIT",
		["Spell Crit Rating"] = "CR_SPELLCRIT",
		["Spell Hit Rating"] = "CR_SPELLHIT",
		["Spell Haste Rating"] = "CR_SPELLHASTE",
		["Haste Rating"] = "CR_HASTE",
		["Mana every 5 Sec"] = "MANAREG",
		["Mana per 5 Seconds"] = "MANAREG",
		["Mana every 5 seconds"] = "MANAREG",
		["Mana Per 5 sec"] = "MANAREG",
		["mana per 5 sec"] = "MANAREG",
		["mana every 5 sec"] = "MANAREG",
		["Mana Regen"] = "MANAREG",
		["Melee Damage"] = "MELEEDMG",
		["Weapon Damage"] = "MELEEDMG",
		["Resist All"] = ALL_RESISTS,
		["Reduced Threat"] = "THREATREDUCTION",
		["Two-Handed Axe Skill Rating"] = "CR_WEAPON_AXE_2H",
		["Stun Resistance"] = "STUNRESIST",
	},

	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "Arcane", 	effect = "ARCANE" },
		{ pattern = "Fire", 	effect = "FIRE" },
		{ pattern = "Frost", 	effect = "FROST" },
		{ pattern = "Holy", 	effect = "HOLY" },
		{ pattern = "Shadow",	effect = "SHADOW" },
		{ pattern = "Nature", 	effect = "NATURE" }
	},

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "Resist", 	effect = "RES" },
		{ pattern = "Damage", 	effect = "DMG" },
		{ pattern = "Effects", 	effect = "DMG" },
	},

	PATTERNS_OTHER = {
		{ pattern = "Reinforced %(%+(%d+) Armor%)", effect = "ARMOR_BONUS" },
		{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },

		{ pattern = "Minor Wizard Oil", effect = HEAL_AND_DMG, value = 8 },
		{ pattern = "Lesser Wizard Oil", effect = HEAL_AND_DMG, value = 16 },
		{ pattern = "Wizard Oil", effect = HEAL_AND_DMG, value = 24 },
		{ pattern = "Brilliant Wizard Oil", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

		{ pattern = "Minor Mana Oil", effect = "MANAREG", value = 4 },
		{ pattern = "Lesser Mana Oil", effect = "MANAREG", value = 8 },
		{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

		{ pattern = "Eternium Line", effect = "FISHING", value = 5 },
		{ pattern = "Vitality", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
		{ pattern = "Soulfrost", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
		{ pattern = "Sunfire", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
		{ pattern = "Savagery", effect = "ATTACKPOWER", value = 70 },
		{ pattern = "Surefooted", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
		{ pattern = "Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3%.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },
		{ pattern = "%+2%% Threat", effect = "THREATREDUCTION", value = -2 },
		{ pattern = "Subtlety", effect = "THREATREDUCTION", value = 2 },

		{ pattern = "Allows underwater breathing%.", effect = "UNDERWATER", value = 1 }, -- 10506
		{ pattern = "Increases your lockpicking skill slightly%.", effect = "LOCKPICK", value = 1 },
		{ pattern = "Moderately increases your stealth detection%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
		{ pattern = "Slightly increases your stealth detection%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
		{ pattern = "Immune to Disarm%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
		{ pattern = "Minor increase to running and swimming speed%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
		{ pattern = "Reduces damage from falling%.", effect = "SLOWFALL", value = 1 }, -- 19982
		{ pattern = "Increases movement speed and life regeneration rate%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
		{ pattern = "Run speed increased slightly%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
		{ pattern = "Increases your stealth slightly%.", effect = "STEALTH", value = 3 }, -- 21758
		{ pattern = "Increases your effective stealth level%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
		{ pattern = "Increases damage and healing done by magical spells and effects slightly%.", effect = HEAL_AND_DMG, value = 6 }, -- 30804

--		{ pattern = "Impress others with your fashion sense%.", effect = "IMPRESS", value = 1 }, -- 10036
--		{ pattern = "Increases your Mojo%.", effect = "MOJO", value = 1 }, -- 23717
	},
}
