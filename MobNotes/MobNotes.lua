--
-- Very simple addon that adds a note to NPC tooltips when available.
-- If you want to add your own notes in-game, simply do
--  /script MobNotesDB["Name of mob"] = "Note"
-- (note that %t doesn't work with /script)
--
-- Database upgrades (i.e. if the addon is updated on the SVN with new notes)
-- will NOT overwrite or change any custom notes you have added.
--

--[[
<Pkekyo|> much easier to ninja out of combatlog what CAN'T be done imo - for the end user, atleast
<vhaarr> I'm not interested in your opinion
<ag`> :p
<kergoth> write a little addon to ninja those messages and inject them into mobnotes's SV, perhaps.  then it's still flexible for adding any notes, but would gain those bits automatically?
<vhaarr> kergoth: that could be interesting, at least if those "Your Polymorph fails. X is immune." and "Your Wound Poison fails. X is immune." etc messages are generated from the same event.
<vhaarr> kergoth: actually it's CHAT_MSG_SPELL_SELF_DAMAGE
<vhaarr> which is fired pretty often

-- Could still be interesting to fool around with it as a separate addon, but I
-- don't think I want it included here. Perhaps wait for 2.4 and see then.
--
--]]

-- Obviously bump this number if you add any new notes. Note that changing old
-- notes will not upgrade the users DB.
local DB_VERSION = 11

-- The default database should only include strategy-neutral comments, like what
-- mobs are capable of doing and how they can be crowd controlled, or if they
-- are immune to everything, like sheeps or stuns. Don't include any strategy
-- like "kill this mob first" or "have your offtank on this one".
local defaultDatabase = nil

local l = GetLocale()

local POPUP_TEXT = "Set a note for |cffff4488%s|r."
local TARGET_ERROR = "You must target something to add a note."
local NOTE_SET = "Note for |cffff4488%s|r set to \"|cff888888%s|r\"."
local SET = "Set"
local CANCEL = "Cancel"
local NOTE_PREFIX = "|cffff4488Note:|r "
-- Keybinding to output the note to chat
BINDING_HEADER_MOBNOTES = "MobNotes"
BINDING_NAME_MOBNOTES_PRINT = "Print Note"

if l == "zhCN" then
	POPUP_TEXT = "为|cffff4488%s|r设置注释."
	TARGET_ERROR = "你必须先选择一个目标来添加注释"
	NOTE_SET = "|cffff4488%s|r的注释更改为\"|cff888888%s|r\"."
	SET = "设置"
	CANCEL = "取消"
	NOTE_PREFIX = "|cffff4488注释：|r "
elseif l == "zhTW" then
	POPUP_TEXT = "為|cffff4488%s|r設定註解"
	TARGET_ERROR = "你必須先選擇一個目標來增加註解"
	NOTE_SET = "|cffff4488%s|r的註解更改為\"|cff888888%s|r\"."
	SET = "設定"
	CANCEL = "取消"
	NOTE_PREFIX = "|cffff4488註解: |r "
end

if l == "enUS" then
defaultDatabase = {
	-- Zul'Aman trash
	["Amani'shi Guardian"] = "Immune to snares, polymorph, and fear. Dispels sheep from nearby friends.",
	["Amani'shi Medicine Man"] = "Can be sheeped, snared and MC'ed. Uses healing and protection totems.",
	["Amani'shi Tribesman"] = "Can be CC'ed by all means.",
	["Amani Bear"] = "Can use Tranquilizing Shot on their frenzy. Freezing Trap, Polymorph and Fear works.",
	["Amani'shi Warbringer"] = "Immune to CC. Dismounts around 20%.",
	["Amani'shi Scout"] = "Can be rooted and stunlocked, summons reinforcements if they reach a set of drums.",
	["Amani'shi Handler"] = "Immune to Polymorph and Fear, can be stunned. Uses Tranquilizing Poison.",
	["Amani'shi Tempest"] = "Does Thunderclap that can be outranged.",
	["Amani'shi Flame Caster"] = "Vulnerable to Polymorph, Mind Control, snares, stuns and interrupts. Can spell steal his buff.",
	["Amani'shi Beast Tamer"] = "Can be sheeped, trapped and stunned. Mind Controls random players.",

	-- Moroes adds
	["Lady Catriona Von'Indi"] = "Holy priest, heals and dispels.",
	["Baron Rafe Dreuger"] = "Retribution paladin, will stun.",
	["Lady Keira Berrybuck"] = "Holy paladin, heals and dispels + divine shield.",
	["Baroness Dorothea Millstipe"] = "Shadow priest with mana burn.",
	["Lord Robin Daris"] = "Mortal Strike warrior, also does WW.",
	["Lord Crispin Ference"] = "Protection warrior, disarm, shield bash and shield wall.",

	-- Karazhan trash
	["Spectral Performer"] = "Immune to CC, opens a spotlight that buffs anyone that stand in it.",
	["Arcane Anomaly"] = "Random teleport that clears threat, attacks on it drains mana before health.",
	["Mana Feeder"] = "Immune to all spells, burns mana.",
	["Mana Warp"] = "Self-destructs for significant damage on low health, interruptable.",
	["Spectral Charger"] = "Charges farthest player. AoE fear to all nearby. Dispel-able magic debuff. Can be Shackled, Stunned and Trapped.",
	["Spectral Stable Hand"] = "Heals other mobs. Can be Trapped or Shackled.",
	["Skeletal Waiter"] = "Brittle bones can be spell reflected or grounded with totem. Vulnerable to stuns.",
	["Ghostly Steward"] = "Immune to stun, trap, shackle and taunt. Vulnerable to disarm.",
	["Phantom Valet"] = "Immune to taunt",
	["Phantom Attendant"] = "Vulnerable to shackle and snare. Immune to taunt.",
	["Spectral Retainer"] = "Immune to shackle. MCs random player.",
	["Spectral Sentry"] = "Ranged attacker. Can be shackled.",
	["Night Mistress"] = "Can be shackled.",
	["Concubine"] = "Vulnerable to stun, snare and banish. Tremor totem works on aoe seduce.",
	["Wanton Hostess"] = "AoE silence. Can be stunned.",
	["Phantom Stagehand"] = "Immune to snare and stun. Can be disarmed.",
	["Skeletal Usher"] = "Immune to trap, turn undead and taunt. Can be shackled.",
	["Trapped Soul"] = "Immune to shackle and stun.",
	["Spell Shade"] = "Can be shackled and feared.",

	-- Hex Lord Malacrass adds
	["Thurg"] = "Melee. Can sheep or trap, but he will resist trap a few times.",
	["Gazakroth"] = "Spams fireballs, can be banished.",
	["Lord Raadan"] = "Frontal Flamebreath & Thunderclap, can be sleeped.",
	["Darkheart"] = "Melee and instant cast AoE fear, can be shackled.",
	["Alyson Antille"] = "Heals can be interrupted and she can be sheeped.",
	["Slither"] = "Poison bolts. Can be sleeped.",
	["Fenstalker"] = "Casts Volatile Infection on players, dealing damage to nearby allies. Can be banished.",
	["Koragg"] = "Can be shackled or feared using Turn Undead.",

	-- Serpentshrine Cavern trash
	["Coilfang Beast-Tamer"] = "Enrages the sporebats, dispelling CC on them. Frontal cleave.",
	["Coilfang Hate-Screamer"] = "AoE silence, 30 yard range.",
	["Serpentshrine Sporebat"] = "Random charge with a minimum range requirement.",

	["Vashj'ir Honor Guard"] = "Intimidating shout and enrage.",
	["Coilfang Shatterer"] = "Warriors can Spell Reflect the Shatter Armor ability.",
	["Coilfang Priestess"] = "Can be CC'ed and stunned by most means.",

	["Greyheart Tidecaller"] = "Can be sheeped and feared. Drops Water Elemental Totem and uses Poison Shield.",
	["Coilfang Serpentguard"] = "Can't be CC'ed, uses frontal Cleave and armor reduction aura.",
	["Greyheart Skulker"] = "Can be sheeped, feared and disarmed.",
	["Greyheart Nether-Mage"] = "Can be sheeped, does AoE damage to the raid. Clears threat after Blink.",

	["Coilfang Fathom-Witch"] = "Immune to CC, does a AoE shadow nova with knockback and random mind controls.",

	["Tidewalker Depth-Seer"] = "Drops a HoT on friendlies, can not be CC'ed, but spell interrupts work. Uses Tranquility on low health.",
	["Tidewalker Harpooner"] = "Nets the tank and clears threat, immune to CC.",
	["Tidewalker Hydromancer"] = "Can be stunned, silenced and interrupted. Vulnerable to CoT. Frostbolts and Frost Nova.",
	["Tidewalker Shaman"] = "Immune to all CC, spells can be interrupted.",
	["Tidewalker Warrior"] = "Can be sheeped, feared, snared and disarmed. Random threat dumps.",

	["Greyheart Shield-Bearer"] = "Can be sheeped, sapped and feared.",
	["Serpentshrine Lurker"] = "Can be banished, drops mushrooms.",

	-- Black Temple trash
	["Aqueous Lord"] = "Summons Aqueous Spawns.",
	["Aqueous Spawn"] = "Can be banished and stunned, heals Lords.",
	["Coilskar Sea-Caller"] = "Can be sheeped, casts Hurricane and Forked Lightning, based on LoS.",
	["Coilskar Wrangler"] = "Immune to CC. Frenzies Leviathans.",
	["Leviathan"] = "Immune to CC. Tail Swipe and Poison Spit.",
	["Coilskar Soothsayer"] = "Can be CC'ed, uses Holy Nova.",
	["Coilskar Harpooner"] = "Can be CC'ed, nets people.",
	["Dragon Turtle"] = "Can be CC'ed.",
	["Coilskar General"] = "Can dispel CC on other mobs, based on LoS/range. Immune to CC.",
	
	["Bonechewer Taskmaster"] = "Immune to CC, buffs workers.",
	["Dragonmaw Sky Stalker"] = "Immune to CC, does AoE damage.",
	["Dragonmaw Wind Reaver"] = "Immune to CC, does AoE damage.",
	["Illidari Fearbringer"] = "Frontal cone AoE, Rain of Fire and a long-range War Stomp.",
	["Ashtongue Battlelord"] = "Immune to CC. Cleave.",
	["Ashtongue Feral Spirit"] = "Frenzies and charges, can be trapped.",
	["Ashtongue Stormcaller"] = "Can be CC'ed.",
	["Ashtongue Primalist"] = "Immune to CC, AoE Wing Clip and Cyclone.",
	["Ashtongue Stalker"] = "Can be CC'ed, blinds random target.",
	["Illidari Centurion"] = "Immune to CC, AoE cone silence ability.",
	["Illidari Boneslicer"] = "Can be banished, AoE Gouge, Shadowstep, Cloak of Shadows and Wound Poison.",
	["Illidari Nightlord"] = "Not banishable, uses Hellfire, AoE fear and summons ~10 adds.",

	["Dragonmaw Wyrmcaller"] = "Will call for nearby Dragonmaw Sky Stalker, immune to CC.",
	["Illidari Boneslicer"] = "Can be banished, Kidney Shot on main target, uses Shadowstep and Cloak of Shadows.",
	["Illidari Defiler"] = "Can be banished. Banishes a random target and uses Rain of Fire.",
	["Illidari Heartseeker"] = "Can be banished.",
	["Bonechewer Behemoth"] = "Charge on a far away target, Meteors.",
	["Bonechewer Blade Fury"] = "Can be sheeped. Clears aggro after WW.",
	["Bonechewer Combatant"] = "Vulnerable to CC.",
	["Bonechewer Shield Disciple"] = "Vulnerable to CC, Shield Wall on low health.",
	["Bonechewer Blood Prophet"] = "Vulnerable to CC.",
	["Bonechewer Brawler"] = "Cleave to front targets.",
	["Ashtongue Spiritbinder"] = "Vulnerable to CC.",
	["Ashtongue Rogue"] = "Vulnerable to CC.",
	["Ashtongue Elementalist"] = "Vulnerable to CC.",
	["Ashtongue Mystic"] = "Vulnerable to CC. Bloodlust and Cyclone, also drops totems.",
	["Ashtongue Sorcerer"] = "Vulnerable to CC.",
	["Shadowmoon Blood Mage"] = "Vulnerable to CC, can be intercepted by sheeping. AoE cone Siphon Life ability.",
	["Shadowmoon Champion"] = "Immune to CC, throw WW weapon into crowds.",
	["Shadowmoon Houndmaster"] = "Can be CCed after dismounted and release the hound.",
	["Shadowmoon Riding Hound"] = "CC'able, charges.",
	["Shadowmoon Deathshaper"] = "CC'able, uses Raise Dead.",

	-- Tempest Keep trash
	["Apprentice Star Scryer"] = "Can be crowd controlled, does AoE Starshards.",
	["Astromancer"] = "Can be feared, sheeped, trapped and snared. Does Fireball Volley.",
	["Star Scryer"] = "Can be sheeped, trapped and snared, does AoE Starshards.",
	["Bloodwarder Legionnaire"] = "Cleave and Whirlwind, can only be snared. Immune to fear and trap.",
	["Tempest-Smith"] = "Can be sapped, sheeped and mind controlled. Throws lots of bombs and buffs the Crystalcores.",
	["Bloodwarder Vindicator"] = "Cleanses CC on other mobs, uses Hammer of Justice and Holy Light. Immune to CC.",
	["Bloodwarder Marshal"] = "Whirlwind, immune to CC.",
	["Bloodwarder Squire"] = "Heals, immune to CC and stuns but not counterspells.",
	["Astromancer Lord"] = "Mind controls a random player, immune to CC and stuns.",
	["Tempest Falconer"] = "Fire Shield buff can't be removed. Immune to CC.",
	["Phoenix-Hawk"] = "Charges the player furthest away from the tank. AoE mana burn and knockbacks.",
	["Crystalcore Devastator"] = "Melee knockback, can counter melee attacks for 2k damage and counters ranged with silence. Immune to stuns.",
	["Crystalcore Sentinel"] = "Uninterruptable explosion for 6k and reflectable Overcharge on tank for 16k. Immune to stuns.",
	["Crystalcore Mechanic"] = "Heals Devastators and Sentinels. Random saw blades on raid. Can be banished.",
	["Nether Scryer"] = "Mass mind control.",
	["Crimson Hand Centurion"] = "Arcane Flurry that hits people in melee range for a lot of damage. Can be sheeped.",
	["Crimson Hand Blood Knight"] = "Stuns tank and dispels CC on mobs, immune to CC.",
	["Crimson Battle Mage"] = "Uses AoE spells. Can be feared and sheeped.",
	["Crimson Hand Inquisitor"] = "Can be crowd controlled, casts Power Infusion.",

	-- Gruul's Lair trash
	["Lair Brute"] = "Random charge on people who are too far away. Wipes threat after charge. Immune to all CC.",
	["Gronn-Priest"] = "Immune to CC and silence, interruptable.",

	-- The Blood Furnace
	["Felguard Annihilator"] = "Random Charge. Can be slowed, Banished or Stunned.",
	["Laughing Skull Rogue"] = "Stealth, stackable poison (320 per stack in Heroic).",
	["Laughing Skull Enforcer"] ="Strike(about 2000 dmg in Heroic) and Shield Slam.",
	["Shadowmoon Summoner"] = "Summon Succubus and Felstalker.",
	["Hellfire Imp"] = "Fire Blast causes around 3300 dmg in Heroic.",
	["Laughing Skull Legionnaire"] = "Uppercut with knockback.",
	["Shadowmoon Warlock"] ="Shadow Bolt and Corruption, can be CCed.",
	["Shadowmoon Technician"] = "Throw Bomb.",
	["Nascent Fel Orc"] = "Stomp causes minor damage and knockback, stuns target using Concussion Blow.",
	["Fel Orc Neophyte"] = "Immune to charm.",
	["Felguard Brute"] = "Uppercut with knockback, dumps threat.",

	-- Hyjal trash by hepha
	["Ghoul"] = "Can be shackled or feared by Turn Undead, vulnerable to movement control abilities.",
	["Gargoyle"] = "Can be intercepted, will go ground if aggro target runs away.",
	["Crypt Fiend"] = "Can be shackled or feared by turn undead, vulnerable to movement control abilities.",
	["Abomination"] = "Can be shackled or feared by Turn Undead, vulnerable to movement control abilities.", -- mob name needs check
	["Necromancer"] = "Can be sheeped or feared, summon spells can be intercepted.", -- mob name needs check
	["Banshee"] = "Can be shackled or feared by Turn Undead, vulnerable to movement control abilities",
	["Frost Wyrm"] = "Can be tanked by a hunter or wl, cast ice AOE around 8 yards.",
	["Giant Infernal"] = "Can be banished and feared, vulnerable to movement control abilities.",
	["Felstalker"] = "Can be banished and feared, vulnerable to movement control abilities, Mana Burn on players.",
	--[""] = "",

	-- Magister's Terrace
	["Sunblade Blood Knight"] = "Casts Holy Light. Stealable seal +holy dmg to melee and spells. Can be CC'ed.",
	["Sunblade Mage Guard"] = "Magic Dampening Fields reduces spell dmg and healing by 75%. AOE stun. Can be sheeped.",
	["Sunblade Magister"] = "Immune to MC and seduce. Casts Arcane Nova and Frostbolt. Spell Haste, stealable and dispellable.",
	["Sunblade Warlock"] = "Casts Incinerate and Immolate. Stealable Fel Armor buff +250 spell damage. Can be CC'ed.",
	["Sunblade Physician"] = "Casts Prayer of Mending. Can be CC'ed.",
	["Wretched Bruiser"] = "Uses Mortal Strike. Can be CC'ed.",
	["Wretched Skulker"] = "Fel infusion increases attack speed and damage.",
	["Wretched Husk"] = "Frostbolts and fireballs.",
	["Sunblade Sentinel"] = "Lightning on all nearby party members.",
	["Sunblade Keeper"] = "Detonates mana cell, Wyrms go into feeding frenzy and act as a single large group. Casts Ban on the player with highest aggro.",
	["Sister of Torment"] = "Can be banished. Casts seduce on random targets.",
	["Ethereum Smuggler"] = "Teleports to random target and spams Arcane Explosion. Can be sheeped.",
	["Coilskar Witch"] = "Forked Lightning cone effect. Can be CC'ed.",
	["Apoko"] = "Shaman, Drops Totems(Windfury, Fire Nova, Earth Bind) uses Warstomp, Heals, Purges.",
	["Eramas Brightblaze"] = "Runemaster, very fast attacks, can pummel and snap kick.",
	["Ellrys Duskhallow"] = "Warlock, casts Shadow Bolt, Fear, and Seed of Corruption.",
	["Garaxxas"] = "Hunter, uses Freezing Trap, Concussive Shot.",
	["Kagani Nightstrike"] = "Rogue, uses Cheap Shot, Kidney Shot, Gouge and Kick.",
	["Warlord Salaris"] = "Arms warrior, uses Mortal Strike and Intimidating Shout.",
	["Yazzai"] = "Frost mage, casts Frostbolt, Frost Nova, Blizzard, Polymorphs, Ice Block.",
	["Zelfan"] = "Engineer, uses Explosive Sheep, Goblin Flame Gun, Goblin Rocket Launcher, Grenades.",
	["Priestess Delrissa"] = "Holy priest, heals and dispels.",
}
elseif l == "deDE" then
defaultDatabase = {
	-- Zul'Aman trash
	["Wächter der Amani'shi"] = "Immune to snares, polymorph, and fear. Dispels sheep from nearby friends.",
	["Medizinmann der Amani'shi"] = "Can be sheeped, snared and MC'ed. Nuke down his totems.",
	["Stammesangehöriger der Amani'shi"] = "Can be CC'ed by all means.",
	["Bär der Amani"] = "Can use Tranquilizing Shot on their frenzy. Freezing Trap, Polymorph and Fear works.",
	["Kriegshetzer der Amani'shi"] = "Immune to CC. Dismounts around 20%.",
	["Späher der Amani'shi"] = "Can be rooted and stunlocked, prevent them from reaching the drums.",
	["Tierführer der Amani'shi"] = "Immune to Polymorph and Fear, can be stunned. Uses Tranquilizing Poison.",
	["Sturmkrieger der Amani'shi"] = "Engaging him stops the waves. Does a nasty AoE that can be outranged.",
	["Flammenwirker der Amani'shi"] = "Vulnerable to Polymorph, Mind Control, snares, stuns and interrupts. Can spell steal his buff.",
	["Bestienbändiger der Amani'shi"] = "Can be sheeped, trapped and stunned. Mind Controls random players.",

	-- Moroes adds
	["Lady Catriona Von'Indi"] = "Holy priest, heals and dispels.",
	["Baron Rafe Dreuger"] = "Retribution paladin, will stun.",
	["Lady Keira Beerhas"] = "Holy paladin, heals and dispels + divine shield.",
	["Baroness Dorothea Mühlenstein"] = "Shadow priest with mana burn.",
	["Lord Robin Daris"] = "Mortal Strike warrior, also does WW.",
	["Lord Crispin Ference"] = "Protection warrior, disarm, shield bash and shield wall.",

	-- Karazhan trash
	["Spektraler Gaukler"] = "Immune to CC, opens a spotlight that buffs anyone that stand in it.",
	["Arkananomalie"] = "Random teleport that clears threat, attacks on it drains mana before health.",
	["Manaschlinger"] = "Immune to all spells, burns mana.",
	["Manawirbel"] = "Self-destructs for significant damage on low health, interruptable.",

	-- Hex Lord Malacrass adds
	["Thurg"] = "Melee. Can sheep or trap, but he will resist trap a few times.",
	["Gazakroth"] = "Spams fireballs, can be banished.",
	["Lord Raadan"] = "Frontal Flamebreath & Thunderclap, can be sleeped.",
	["Düsterherz"] = "Melee and instant cast AoE fear, can be shackled.",
	["Alyson Antille"] = "Heals can be interrupted and she can be sheeped.",
	["Glibber"] = "Poison bolts. Can be sleeped.",
	["Fennpirscher"] = "Casts Volatile Infection on players, dealing damage to nearby allies. Can be banished.",
	["Koragg"] = "Can be shackled or feared using Turn Undead.",

	-- Serpentshrine Cavern trash
	["Bestienbändiger des Echsenkessels"] = "Enrages the sporebats, dispelling CC on them. Frontal cleave.",
	["Hassschürer des Echsenkessels"] = "AoE silence, 30 yard range.",
	["Sporensegler des Echsenkessels"] = "Random charge with a minimum range requirement.",

	["Ehrenwache der Vashj'ir"] = "Intimidating shout and enrage.",
	["Zertrümmerer des Echsenkessels"] = "Warriors can Spell Reflect the Shatter Armor ability.",
	["Priesterin des Echsenkessels"] = "Can be CC'ed and stunned by most means.",

	["Gezeitenrufer der Grauherzen"] = "Can be sheeped and feared. Drops Water Elemental Totem and uses Poison Shield.",
	["Schlangenwache des Echsenkessels"] = "Can't be CC'ed, uses frontal Cleave and armor reduction aura.",
	["Schleicher der Grauherzen"] = "Can be sheeped, feared and disarmed.",
	["Nethermagier der Grauherzen"] = "Can be sheeped, does AoE damage to the raid.",

	["Tiefenhexe des Echsenkessels"] = "Immune to CC, does a AoE shadow nova with knockback and random mind controls.",

	["Tiefenseher der Gezeitenwandler"] = "Drops a HoT on friendlies, can not be CC'ed, but spell interrupts work. Uses Tranquility on low health.",
	["Harpunenkämpfer der Gezeitenwandler"] = "Nets the tank and clears threat, immune to CC.",
	["Wasserbeschwörer der Gezeitenwandler"] = "Can be stunned, silenced and interrupted. Vulnerable to CoT. Frostbolts and Frost Nova.",
	["Schamane der Gezeitenwandler"] = "Immune to all CC, spells can be interrupted.",
	["Krieger der Gezeitenwandler"] = "Can be sheeped, feared, snared and disarmed. Random threat dumps.",

	["Schildträger der Grauherzen"] = "Can be sheeped, sapped and feared.",
	["Lauerer des Schlangenschreins"] = "Can be banished, drops mushrooms.",

	-- Black Temple trash
	["Aqueouslord"] = "Summons 2 Aqueous Spawns.",
	["Aqueousbrut"] = "Can be banished and stunned, heals Lords.",
	["Meeresrufer der Echsennarbe"] = "Can be sheeped, casts Hurricane and Forked Lightning, based on LoS.",
	["Zänker der Echsennarbe"] = "Immune to CC. Frenzies Leviathans.",
	["Leviathan"] = "Immune to CC. Tail Swipe and Poison Spit.",
	["Sterndeuterin der Echsennarbe"] = "Can be CC'ed, uses Holy Nova.",
	["Harpunenkämpfer der Echsennarbe"] = "Can be CC'ed, nets people.",
	["Drachenschildkröte"] = "Can be CC'ed.",
	["General der Echsennarbe"] = "Can dispel CC on other mobs, possibly based on LoS/range. Immune to CC.",

	-- Tempest Keep trash
	["Sternenseherlehrling"] = "Can be crowd controlled, does AoE Starshards.",
	["Astromant"] = "Can be feared, sheeped, trapped and snared. Purge the buff. Does Fireball Volley.",
	["Sternenseher"] = "Can be sheeped, trapped and snared, does AoE Starshards.",
	["Legionär der Blutwärter"] = "Cleave and Whirlwind, can only be snared. Immune to fear and trap.",
	["Schmied der Stürme"] = "Can be sapped, sheeped and mind controlled. Throws lots of bombs and buffs the Crystalcores.",
	["Verteidiger der Blutwärter"] = "Cleanses CC on other mobs, uses Hammer of Justice and Holy Light. Immune to CC.",
	["Marschall der Blutwärter"] = "Whirlwind, immune to CC.",
	["Knappe der Blutwärter"] = "Heals, immune to CC and stuns but not counterspells.",
	["Astromantenlord"] = "Mind controls a random player, immune to CC and stuns.",
	["Falkner der Stürme"] = "Fire Shield buff can't be removed. Immune to CC.",
	["Phönixfalke"] = "Charges the player furthest away from the tank. AoE mana burn and knockbacks.",
	["Kristallkernverwüster"] = "Melee knockback, can counter melee attacks for 2k damage and counters ranged with silence. Immune to stuns.",
	["Kristallkernschildwache"] = "Uninterruptable explosion for 6k and reflectable Overcharge on tank for 16k. Immune to stuns.",
	["Kristallkernmechaniker"] = "Heals Devastators and Sentinels. Random saw blades on raid. Can be banished.",
	["Netherseher"] = "Mass mind control.",
	["Zenturio der Purpurhand"] = "Whirlwind. Can be sheeped.",
	["Blutritter der Purpurhand"] = "Stuns tank and dispels CC on mobs, immune to CC.",
	["Kampfmagier der Purpurhand"] = "Uses AoE spells and hits for 18k on tanks. Can be feared.",
	["Inquisitor der Purpurhand"] = "Can be crowd controlled, casts Power Infusion.",

	-- Gruul's Lair trash
	["Schläger des Unterschlupfs"] = "Random charge on people who are too far away. Wipes threat after charge. Immune to all CC.",
	["Gronnpriester"] = "Immune to CC and silence, interruptable.",

	--[""] = "",
}

elseif l == "zhCN" then
defaultDatabase = {
	-- Zul'Aman trash
	["阿曼尼守护者"] = "免疫冰冻、减速、变形和恐惧，可以驱散变羊",
	["阿曼尼医师"] = "可以变羊、冰冻和心灵控制，技能为治疗和保护性图腾",
	["阿曼尼部族成员"] = "可以被任何控制技能控制",
	["阿曼尼野熊"] = "狂暴可以用宁神射击解除，可以被冰冻陷阱、变形和恐惧控制",
	["阿曼尼战争使者"] = "免疫控制技能，20%血量时下马",
	["阿曼尼斥候"] = "可以缠绕和眩晕，在他们靠近战鼓后会召唤增援",
	["阿曼尼训练师"] = "免疫变形和恐惧，可以眩晕，会使用宁神毒药",
	["阿曼尼暴徒"] = "雷霆一击，拉开距离躲避",
	["阿曼尼烈焰法师"] = "可以被变羊、控制、冰冻、眩晕和打断，可以偷取他的buff",
	["阿曼尼驯兽员"] = "可以被变羊、陷阱和眩晕，随机精神控制玩家",

	-- Moroes adds
	["卡翠欧娜·冯因迪女伯爵"] = "神圣牧师，会治疗和驱散",
	["拉弗·杜格尔男爵"] = "惩戒骑士，眩晕技能",
	["吉拉·拜瑞巴克女伯爵"] = "神圣骑士，治疗、驱散和圣盾术",
	["杜萝希·米尔斯提女伯爵"] = "暗影牧师，会施放法力燃烧",
	["罗宾·达瑞斯伯爵"] = "武器战士，技能为致死打击和旋风斩",
	["克里斯宾·费伦斯伯爵"] = "防护战士，缴械、盾牌猛击和盾墙",

	-- Karazhan trash
	["鬼灵演员"] = "免疫控制技能，会施放聚光灯，所有位于其下的人和mob伤害提高",
	["奥术畸体"] = "随机传送，清空当前仇恨，有法力护盾",
	["法力猎食者"] = "免疫所有法术，会施放燃烧法力", -- need check
	["法力畸变"] = "低生命时施放巨大伤害的AOE自爆，可以被打断",

	-- Hex Lord Malacrass adds
	["索尔格"] = "近战，可以被变形和陷阱，不过若干次陷阱控制后他会抵抗（DR递减？！）",
	["卡扎克洛斯"] = "群发火球术，可以被放逐",
	["兰尔丹"] = "对前方施放火焰吐息，以及雷霆一击，可以被变羊",
	["黑心"] = "近战攻击和瞬发的群体恐惧，可以被束缚锁定",
	["阿莱松·安提雷"] = "可以被打断的治疗术，可以被变羊",
	["滑行者"] = "毒液箭，可以被变羊",
	["沼泽猎手"] = "对玩家施放快速传染，对附近队友造成伤害，可以被放逐",
	["库拉格"] = "可以被束缚或超度亡灵恐惧",

	-- Serpentshrine Cavern trash
	["盘牙驯兽师"] = "使孢子蝠狂暴，解除它的控制技能，对正前方玩家施放顺劈",
	["盘牙尖啸者"] = "30码距离AoE沉默",
	["毒蛇神殿孢子蝠"] = "有最小距离的随机冲锋", -- need check

	["瓦丝琪的荣誉卫士"] = "破胆怒吼和狂怒",
	["盘牙粉碎者"] = "战士怪，会反弹破甲技能",
	["盘牙女祭司"] = "大多数情况下可以被控制和眩晕",

	["暗心唤潮者"] = "可以被变羊和恐惧，会施放水元素图腾和毒液盾",
	["盘牙毒蛇守卫"] = "不能被控制，会顺劈斩和护甲降低光环",
	["暗心隐藏者"] = "可以被变羊、恐惧和缴械",
	["暗心虚空法师"] = "可以被变羊，对队伍施放AOE，在闪现后清空仇恨",

	["盘牙深渊女巫"] = "免疫控制技能，会施放带击退效果的暗影新星AOE和随机精神控制",

	["踏潮深渊先知"] = "对其他怪物施放HOT治疗，不能被控制，但是可以对其使用打断和反制，在低生命时使用宁静",
	["踏潮持叉者"] = "对坦克施放投网并清空仇恨，免疫控制技能",
	["踏潮水术师"] = "可以被眩晕、沉默和打断，CoT会很有效，会施放寒冰箭和冰环",
	["踏潮萨满祭司"] = "免疫所有控制技能，法术可以被打断",
	["踏潮战士"] = "可以被变羊、恐惧、陷阱和缴械，随机变换仇恨",

	["暗心持盾者"] = "可以被变羊、恐惧和闷棍",
	["毒蛇神殿潜伏者"] = "可以被放逐，施放蘑菇",

	-- Black Temple trash
	["邪水领主"] = "召唤2个邪水爪牙",
	["邪水爪牙"] = "可以被放逐和眩晕，会治疗邪水领主",
	["库斯卡唤海者"] = "可以被变羊，会施放飓风和叉状闪电",
	["库斯卡争斗者"] = "免疫控制技能，会使海兽狂暴",
	["海兽"] = "免疫控制技能，会尾击和毒液喷吐",
	["库斯卡占卜者"] = "可以被控制技能影响，会施放神圣新星",
	["库斯卡持戟者"] = "可以被控制技能影响，会网住玩家",
	["龙龟"] = "可以被控制技能影响",
	["库斯卡将军"] = "会驱散其他怪物的控制技能，应该是根据距离或控制等级来决定，免疫控制技能",

	-- Black Temple trash by hepha
	["龙喉唤龙者"] = "会呼叫附近的龙喉空行者，免疫控场",
	["伊利达雷切骨者"] = "可由术士放逐，会肾击目标，会使用暗影斗篷",
	["伊利达雷玷污者"] = "可由术士放逐",
	["伊利达雷觅心者"] = "可由术士放逐",
	["噬骨巨兽"] = "随机施放两种技能，冲锋最远的目标，类似TAQ阿努比萨斯会施放损石术",
	["噬骨剑武者"] = "可以变羊，旋风斩时清空仇恨并免疫控场",
	["噬骨战士"] = "可以控场",
	["噬骨持盾者"] = "可以控场，低生命时会开盾墙",
	["噬骨血先知"] = "可以控场",
	["噬骨殴斗者"] = "顺劈斩，近战伤害职业要躲避",
	["灰舌缚灵者"] = "可以控场",
	["灰舌盗贼"] = "可以控场",
	["灰舌元素师"] = "可以控场",
	["灰舌秘术师"] = "可以控场",
	["灰舌巫师"] = "可以控场",
	["影月血法师"] = "可以控场，可通过不断变形打断施法，免疫反制",
	["影月勇士"] = "不可控场，会丢武器在人群里旋风斩",
	["影月驯犬者"] = "进入战斗后，释放座骑影月骑乘猎犬，此时可控场",

	-- Tempest Keep trash
	["星占师学徒"] = "可以被控制技能控制，会施放AOE星辰碎片",
	["星术师"] = "可以被恐惧、变形、陷阱或缠绕，施放群体火球术",
	["星占师"] = "可以被恐惧、变形、陷阱或缠绕，会施放AOE星辰碎片",
	["血警卫军团士兵"] = "顺劈斩和旋风斩，仅能被缠绕，免疫恐惧和陷阱",
	["风暴要塞铁匠"] = "可以被闷棍、变羊和心灵控制，群体投掷炸弹并且会buff晶核怪物",
	["血警卫守备官"] = "净化其他怪物的控制技能，会使用制裁之锤和圣光术，免疫控制技能",
	["血警卫典狱长"] = "旋风斩，免疫控制技能",
	["血警卫侍从"] = "治疗型mob，免疫控制技能和眩晕，但是可以被反制",
	["星术师领主"] = "心灵控制随机玩家，免疫控制技能和眩晕",
	["风暴驯鹰者"] = "不能被解除的火焰之盾buff，免疫控制技能",
	["凤鹰"] = "冲锋距离坦克最远的玩家，施放AOE法力燃烧和击退",
	["晶核摧毁者"] = "近战攻击带击退效果，反击近战攻击造成2000左右伤害，沉默反制远程职业，免疫眩晕",
	["晶核斥候"] = "不能被打断的AOE爆炸，6000伤害，以及对坦克施放可以被反弹的超载技能，16000左右伤害，免疫眩晕",
	["晶核机械师"] = "会治疗摧毁者和斥候，对团队成员随机施放锯齿之刃，可以被放逐",
	["虚空占卜者"] = "群体心灵控制",
	["炽手百夫长"] = "近战范围内的奥术洪流造成大量伤害，可以被变羊",
	["炽手血骑士"] = "击晕坦克并驱散其他怪物的控制技能，免疫控制技能",
	["红衣战斗法师"] = "使用AOE法术，可以被恐惧或变羊",
	["炽手审讯者"] = "可以被控制技能控制，会施放能量灌注",

	-- Gruul's Lair trash
	["巢穴卫兵"] = "随机对远距离玩家冲锋，冲锋后清空仇恨，免疫所有控制技能",
	["戈隆祭司"] = "免疫控制技能和沉默，可以打断",

	-- The Blood Furnace
	["恶魔卫士歼灭者"] = "随机冲锋，可以被减速、定身和昏迷",
	["嘲颅盗贼"] = "淬毒造成伤害并且可叠加（英雄模式每层320）",
	["嘲颅执行者"] ="盾牌猛击",
	["影月召唤者"] = "召唤魅魔和地狱犬，火球术，魅魔会魅惑，地狱犬会施放燃烧法力",
	["地狱火小鬼"] = "英雄模式下火焰冲击造成大量伤害（英雄模式3300）",
	["嘲颅军团士兵"] = "上钩拳带击退效果",
	["影月术士"] ="暗影箭，腐蚀术，可以被控场",
	["影月技师"] = "投掷炸弹，自走炸弹",
	["初生的邪兽人"] = "践踏 少量伤害并击退，震荡猛击昏迷目标",
	["邪兽人新兵"] = "免疫媚惑",
	["恶魔卫士蛮兵"] = "上钩拳，造成伤害并击退，附带减仇恨效果",

	-- Hyjal trash by hepha
	["食尸鬼"] = "牧师可锁，圣骑可超渡，可用定身技能",
	["石像鬼"] = "可反制施法，制造仇恨变成他目标跑远，就能拉下来",
	["地穴魔"] = "牧师可锁，圣骑可超渡，可用定身技能",
	["憎恶"] = "牧师可锁，圣骑可超渡，可用定身技能", -- mob name needs check
	["亡灵巫师"] = "可被变形、恐惧，需反制召唤术", -- mob name needs check
	["女妖"] = "牧师可锁，圣骑可超渡，可用定身技能",
	["冰霜巨龙"] = "可由猎人或者术士Tank，会对目标施放AOE技能冰霜吐息半径8码",
	["庞大的地狱火"] = "可被术士放逐，可以恐惧、可用定身技能",
	["地狱捕猎者"] = "可被术士放逐，可以恐惧、可用定身技能，会吸取法力",
}

elseif l == "zhTW" then
defaultDatabase = {
	-- Zul'Aman trash
	["阿曼尼希守衛"] = "免疫冰凍、減速、變形和恐懼，可以驅散變羊",
	["阿曼尼希咒醫"] = "可以變羊、冰凍和心靈控制，技能為治療和保護性圖騰",
	["阿曼尼希族人"] = "可以被任何控制技能控制",
	["阿曼尼熊"] = "狂暴可以用寧神射擊解除，可以被冰凍陷阱、變形和恐懼控制",
	["阿曼尼希戰爭使者"] = "免疫控制技能，20% 血量時下馬",
	["阿曼尼希斥候"] = "可以纏繞和眩暈，在他們靠近戰鼓後會召喚增援",
	["阿曼尼希管理員"] = "免疫變形和恐懼，可以眩暈，會使用寧神毒藥",
	["阿曼尼希暴怒者"] = "雷霆一擊，拉開距離躲避",
	["阿曼尼希火焰施放者"] = "可以被變羊、控制、冰凍、眩暈和打斷，可以偷取他的 buff",
	["阿曼尼希馴獸師"] = "可以被變羊、陷阱和眩暈，隨機精神控制玩家",

	-- Moroes adds
	["凱崔娜·瓦映迪女士"] = "神聖牧師，會治療和驅散",
	["男爵洛夫·崔克爾"] = "懲戒騎士，眩暈技能",
	["凱伊拉·拜瑞巴克女士"] = "神聖騎士，治療、驅散和聖盾術",
	["女爵朵洛希·米爾斯泰普"] = "暗影牧師，會施放法力燃燒",
	["貴族羅賓·達利斯"] = "武器戰士，技能為致死打擊和旋風斬",
	["貴族克利斯平·費蘭斯"] = "防護戰士，繳械、盾牌猛擊和盾牆",

	-- Karazhan trash
	["鬼靈表演者"] = "免疫控制技能，會施放聚光燈，所有位於其下的人和 mob 傷害提高",
	["秘法異反元素"] = "隨機傳送，清空當前仇恨，有法力護盾",
	["法力供應蟲"] = "免疫所有法術，會施放燃燒法力", -- need check
	["法力扭曲"] = "低生命時施放巨大傷害的 AOE 自爆，可以被打斷",

	-- Hex Lord Malacrass adds
	["瑟吉"] = "近戰，可以被變形和陷阱，不過若干次陷阱控制後他會抵抗（DR 遞減?!）",
	["葛薩克羅司"] = "群發火球術，可以被放逐",
	["領主雷阿登"] = "對前方施放火焰吐息，以及雷霆一擊，可以被變羊",
	["黑心"] = "近戰攻擊和瞬發的群體恐懼，可以被束縛鎖定",
	["艾利森·安第列"] = "可以被打斷的治療術，可以被變羊",
	["史立塞"] = "毒液箭，可以被變羊",
	["沼群巡者"] = "對玩家施放快速傳染，對附近隊友造成傷害，可以被放逐",
	["可拉格"] = "可以被束縛或超度亡靈恐懼",
	
	-- Serpentshrine Cavern trash
	["盤牙馴獸師"] = "使孢子蝠狂暴，解除它受到的控制技能，對正前方玩家施放順劈",
	["盤牙憎恨尖嘯者"] = "30 碼距離 AOE 沉默",
	["毒蛇神殿孢子蝙蝠"] = "有最小距離的隨機衝鋒", -- need check

	["瓦司金榮譽守衛"] = "破膽怒吼和狂怒",
	["盤牙破碎者"] = "戰士怪，會反彈破甲技能",
	["盤牙女祭司"] = "大多數情況下可以被控制和眩暈",

	["灰色之心浪潮呼喚者"] = "可以被變羊和恐懼，會施放水元素圖騰和毒液盾",
	["盤牙海蛇守衛"] = "不能被控制，會順劈斬和護甲降低光環",
	["灰色之心隱藏者"] = "可以被變羊、恐懼和繳械",
	["灰色之心虛空法師"] = "可以被變羊，對隊伍施放 AOE，在閃現後清空仇恨",

	["盤牙深淵女巫"] = "免疫控制技能，會施放帶擊退效果的暗影新星AOE和隨機精神控制",

	["潮行者深淵先知"] = "對其他怪物施放 HOT 治療，不能被控制，但是可以對其使用打斷和反制，在低生命時使用寧靜",
	["潮行者獵魚者"] = "對坦克施放投網並清空仇恨，免疫控制技能",
	["潮行者海法師"] = "可以被眩暈、沉默和打斷，CoT 會很有效，會施放寒冰箭和冰環",
	["潮行者薩滿"] = "免疫所有控制技能，法術可以被打斷",
	["潮行者戰士"] = "可以被變羊、恐懼、陷阱和繳械，狂暴時可寧神，隨機變換仇恨",

	["灰色之心盾衛"] = "可以被變羊、恐懼和悶棍",
	["毒蛇神殿潛伏者"] = "可以被放逐，施放蘑菇",

	-- Black Temple trash
	["元水領主"] = "召喚 2 個元水爪牙",
	["元水之子"] = "可以被放逐和眩暈，會治療元水領主",
	["考斯卡召海者"] = "可以被變羊，會施放颶風和叉狀閃電",
	["考斯卡爭吵者"] = "免疫控制技能，會使海獸狂暴",
	["巨神海蛇"] = "免疫控制技能，會尾擊和毒液噴吐",
	["考斯卡預言者"] = "可以被控制技能影響，會施放神聖新星",
	["考斯卡獵魚者"] = "可以被控制技能影響，會網住玩家",
	["龍形龜"] = "可以被控制技能影響",
	["考斯卡將軍"] = "會驅散其他怪物的控制技能，應該是根據距離或控制等級來決定，免疫控制技能",

	-- Black Temple trash by hepha
	["龍喉召龍者"] = "會呼叫附近的龍喉空行者，免疫控場",
	["伊利達瑞切骨者"] = "可由術士放逐，會腎擊目標，會開暗影披風",
	["伊利達瑞污染者"] = "可由術士放逐",
	["伊利達瑞尋心者"] = "可由術士放逐",
	["噬骨者巨獸"] = "隨機施放兩種技能，衝鋒最遠的目標，像TAQ阿努比斯會施放損石術，需全體靠近坦克",
	["噬骨劍刃狂怒者"] = "由法師開場羊，旋風斬時清空仇恨並免疫控場",
	["噬骨者戰士"] = "可以控場",
	["噬骨護盾門徒"] = "可以控場，快沒血時會開盾牆",
	["噬骨鮮血預言者"] = "可以控場",
	["噬骨打鬥者"] = "會順劈斬，近戰傷害職業要站在背後打",
	["灰舌縛靈者"] = "可以控場",
	["灰舌盜賊"] = "可以控場",
	["灰舌元素師"] = "可以控場",
	["灰舌秘法師"] = "可以控場",
	["灰舌巫士"] = "可以控場",
	["影月血法師"] = "可以控場，在打時由法師持續變形斷法",
	["影月勇士"] = "不可控場，會丟武器在人群裡旋風斬",
	["影月馴犬者"] = "進入戰鬥後，釋放座騎影月騎乘獵犬可控場",

	-- Tempest Keep trash
	["見習占星者"] = "可以被控制技能控制，會施放 AOE 星辰碎片",
	["星術師"] = "可以被恐懼、變形、陷阱或纏繞，施放群體火球術",
	["占星者"] = "可以被恐懼、變形、陷阱或纏繞，會施放 AOE 星辰碎片",
	["血守衛軍團士兵"] = "順劈斬和旋風斬，僅能被纏繞，免疫恐懼和陷阱",
	["風暴要塞-鐵匠"] = "可以被悶棍、變羊和心靈控制，群體投擲炸彈並且會 buff 晶核怪物",
	["血守衛復仇者"] = "凈化其他怪物的控制技能，會使用制裁之錘和聖光術，免疫控制技能",
	["血守衛治安官"] = "旋風斬，免疫控制技能",
	["血守衛扈從"] = "治療型 mob，免疫控制技能和眩暈，但是可以被反制",
	["星術領主"] = "心靈控制隨機玩家，免疫控制技能和眩暈",
	["風暴要塞-熔爐鷹獵者"] = "不能被解除的火焰之盾 buff，免疫控制技能",
	["小鳳鷹"] = "衝鋒距離坦克最遠的玩家，施放 AOE 法力燃燒和擊退，牧師加暗抗能減少傷害",
	["水晶之核毀壞者"] = "近戰攻擊帶擊退效果，反擊近戰攻擊造成 2000 左右傷害，沈默反制遠程職業，免疫眩暈",
	["水晶之核哨兵"] = "不能被打斷的 AOE 爆炸，6000 傷害，以及對坦克施放可以被反彈的超載技能，16000 左右傷害，免疫眩暈",
	["水晶之核技師"] = "會治療摧毀者和斥候，對團隊成員隨機施放鋸齒之刃，可以被放逐",
	["虛空占卜師"] = "群體心靈控制",
	["紅手百夫長"] = "可以被變羊，近戰範圍內的奧術洪流造成大量傷害，可持續變形斷他施放奧術洪流",
	["紅手血騎士"] = "擊暈坦克並驅散其他怪物的控制技能，免疫控制技能",
	["紅衣戰鬥法師"] = "使用 AOE 法術，可以被恐懼或變羊",
	["紅手審判官"] = "可以被控制技能控制，會施放能量灌注，法師可竊取",

	-- Gruul's Lair trash
	["巢穴蠻兵"] = "隨機對遠距離玩家衝鋒，衝鋒後清空仇恨，免疫所有控制技能",
	["古羅牧師"] = "免疫控制技能和沈默，可以打斷",

	-- The Blood Furnace
	["惡魔守衛殲滅者"] = "隨機衝鋒，可以被減速、定身和昏迷",
	["獰笑骷髏盜賊"] = "淬毒造成傷害並且可疊加（英雄模式每層 320）",
	["獰笑骷髏執行者"] ="盾牌猛擊",
	["影月召喚者"] = "召喚魅魔和地獄犬，火球術，魅魔會魅惑，地獄犬會施放燃燒法力",
	["地獄火小鬼"] = "英雄模式下火焰衝擊造成大量傷害",
	["獰笑骷髏軍團士兵"] = "上鉤拳帶擊退效果",
	["影月術士"] ="暗影箭，腐蝕術，可以被控場",
	["影月技師"] = "投擲炸彈，自走炸彈",
	["年幼的魔獄獸人"] = "踐踏 少量傷害並擊退，震盪猛擊昏迷目標",
	["魔獄獸人新兵"] = "免疫媚惑",
	["惡魔守衛蠻兵"] = "上鉤拳，造成傷害並擊退，附帶減仇恨效果",

	-- Hyjal trash by hepha
	["食屍鬼"] = "牧師可鎖，聖騎可超渡，可用定身技能",
	["石像鬼"] = "可法制施法，製造仇恨變成他目標跑遠，就能拉下來",
	["地穴惡魔"] = "牧師可鎖，聖騎可超渡，可用定身技能",
	["憎惡"] = "牧師可鎖，聖騎可超渡，可用定身技能",
	["亡靈巫師"] = "可被變形、恐懼，需反制招喚術",
	["食屍鬼"] = "牧師可鎖，聖騎可超渡，可用定身技能",
	["女妖"] = "牧師可鎖，聖騎可超渡，可用定身技能",
	["冰龍"] = "可由獵人或者術士坦住，會對目標施放AOE技能冰霜吐息半徑8碼",
	["巨型地獄火"] = "可被術士放逐，可以恐懼、可用定身技能",
	["惡魔捕獵者"] = "可被術士放逐，可以恐懼、可用定身技能，會吸取法力",
}

end

function MobNotes_GetNote(name)
	if not name then return end
	return _G.MobNotesDB[name]
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function()
	if event == "VARIABLES_LOADED" then
		if not _G.MobNotesDB then
			_G.MobNotesDB = defaultDatabase
			_G.MobNotesDB.VERSION = DB_VERSION
		end

		if not _G.MobNotesDB.VERSION or _G.MobNotesDB.VERSION < DB_VERSION then
			for k, v in pairs(defaultDatabase) do
				if not _G.MobNotesDB[k] then
					_G.MobNotesDB[k] = v
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage("|cffff4488Mob Notes|r database updated to revision " .. tostring(DB_VERSION) .. ".")
			_G.MobNotesDB.VERSION = DB_VERSION
		end

		local orig = GameTooltip:GetScript("OnTooltipSetUnit")
		GameTooltip:SetScript("OnTooltipSetUnit", function(tooltip, ...)
			local name, unitid = tooltip:GetUnit()
			if UnitExists(unitid) and _G.MobNotesDB[name] then
				GameTooltip:AddLine(NOTE_PREFIX .. _G.MobNotesDB[name], 0.5, 0.5, 0.5, 1)
			end
			return orig(tooltip, ...)
		end)
	end
end)

frame:RegisterEvent("VARIABLES_LOADED")

local function addNoteFromPopup(note)
	if type(note) ~= "string" or note:trim():len() == 0 then note = nil end
	local t = UnitExists("target") and UnitName("target") or nil
	if t then
		_G.MobNotesDB[t] = note
		DEFAULT_CHAT_FRAME:AddMessage(NOTE_SET:format(t, tostring(note)))
	end
end

_G.SlashCmdList["MOBNOTES_SHORTHAND"] = function(input)
	if not UnitExists("target") then
		DEFAULT_CHAT_FRAME:AddMessage(TARGET_ERROR)
		return
	end
	if type(input) ~= "string" or input:trim():len() == 0 then
		if not StaticPopupDialogs["MobNotes"] then
			StaticPopupDialogs["MobNotes"] = {
				text = nil,
				button1 = SET,
				button2 = CANCEL,
				whileDead = 1,
				hideOnEscape = 1,
				timeout = 0,
				OnShow = function()
					-- We have to do this onshow to reset the previous text
					local t = UnitExists("target") and UnitName("target") or ""
					_G[this:GetName().."EditBox"]:SetText(_G.MobNotesDB[t] or "")
				end,
				OnHide = function()
					_G[this:GetName().."EditBox"]:SetText("")
				end,
				EditBoxOnEnterPressed = function()
					addNoteFromPopup(_G[this:GetParent():GetName().."EditBox"]:GetText())
					this:GetParent():Hide()
				end,
				EditBoxOnEscapePressed = function()
					this:GetParent():Hide()
				end,
				OnAccept = function()
					addNoteFromPopup(_G[this:GetParent():GetName().."EditBox"]:GetText())
				end,
				hasEditBox = 1,
			}
		end
		StaticPopupDialogs["MobNotes"].text = POPUP_TEXT:format(UnitName("target"))
		StaticPopup_Show("MobNotes")
	else
		local t = UnitName("target")
		_G.MobNotesDB[t] = input
		DEFAULT_CHAT_FRAME:AddMessage(NOTE_SET:format(t, input))
	end
end
_G.SLASH_MOBNOTES_SHORTHAND1 = "/mobnotes"

