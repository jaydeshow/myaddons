﻿--[[
constants.en.lua
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The ["text"] = true; shortcut can ONLY be used for English (the root translation).
]]

--Table for all data to be inserted into.  Included here as it is the first file loaded
AtlasLoot_Data = {};

--Create the library instance
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

--Allow reporting of what translations are missing
AL:EnableDebugging();

--Allow the language to be changed dynamically for debugging purposes
AL:EnableDynamicLocales();

--Register translations
AL:RegisterTranslations("enUS", function() return {
    --Text strings for UI objects
    ["AtlasLoot"] = true,
    ["No match found for"] = true,
    ["Search"] = true,
    ["Clear"] = true,
    ["Select Loot Table"] = true,
    ["Select Sub-Table"] = true,
    ["Drop Rate: "] = true,
    ["DKP"] = true,
    ["Priority:"] = true,
    ["Click boss name to view loot."] = true,
    ["Various Locations"] = true,
    ["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = true,
    ["Toggle AL Panel"] = true,
    [" is safe."] = true,
    ["Server queried for "] = true,
    [".  Right click on any other item to refresh the loot page."] = true,
    ["Back"] = true,
    ["Level 60"] = true,
    ["Level 70"] = true,
    ["|cffff0000(unsafe)"] = true,
    ["Misc"] = true,
    ["Rewards"] = true,
    ["Heroic Mode"] = true,
    ["Normal Mode"] = true,
    ["Raid"] = true,
    ["Factions - Azeroth"] = true,
    ["Factions - Outland"] = true,
    ["Factions - Shattrath City"] = true,
    ["Pre-Burning Crusade"] = true,
    ["Post-Burning Crusade"] = true,
    ["Choose Table ..."] = true,
    ["Close Menu"] = true,
    ["Unknown"] = true,
    ["Skill Required:"] = true,
    ["QuickLook"] = true,
    ["Add to QuickLooks:"] = true,
    ["Assign this loot table\n to QuickLook"] = true,
    ["Req. Rating:"] = true,  --Shorthand for 'Required Rating' for the personal/team ratings in Arena S4
    ["Query Server"] = true,
    
    --Text for Options Panel
    ["Atlasloot Options"] = true,
    ["Safe Chat Links |cff1eff00(recommended)|r"] = true,
    ["Enable all Chat Links |cffff0000(use at own risk)|r"] = true,
    ["Default Tooltips"] = true,
    ["Lootlink Tooltips"] = true,
    ["|cff9d9d9dLootlink Tooltips|r"] = true,
    ["ItemSync Tooltips"] = true,
    ["|cff9d9d9dItemSync Tooltips|r"] = true,
    ["Use EquipCompare"] = true,
    ["|cff9d9d9dUse EquipCompare|r"] = true,
    ["Show Comparison Tooltips"] = true,
    ["Make Loot Table Opaque"] = true,
    ["Show itemIDs at all times"] = true,
    ["Hide AtlasLoot Panel"] = true,
    ["Show Minimap Button"] = true,
    ["Set Minimap Button Position"] = true,
    ["Suppress text spam when querying items"] = true,
    ["Notify me when a LoD Module is loaded"] = true,
    ["Load all loot modules at startup"] = true,
    ["AutoQuery items on loot tables |cffff0000(disconnection risk)|r"] = true,
    ["Done"] = true,
    ["WishList"] = true,
    ["Search Result: %s"] = true,
    ["Last Result"] = true,
    ["Search on"] = true,
    ["All modules"] = true,
    ["If checked, AtlasLoot will load and search across all the modules."] = true,
    ["Search options"] = true,
    ["Partial matching"] = true,
    ["If checked, AtlasLoot search item names for a partial match."] = true,
    ["You don't have any module selected to search on!"] = true,
    --The next 4 lines are the tooltip for the Server Query Button
    --The translation doesn't have to be literal, just re-write the
    --sentences as you would naturally and break them up into 4 roughly
    --equal lines.
    ["Queries the server for all items"] = true,
    ["on this page. The items will be"] = true,
    ["refreshed when you next mouse"] = true,
    ["over them."] = true,
    
    --Slash commands
    ["reset"] = true,
    ["options"] = true,
    ["Reset complete!"] = true,

    --Error Messages and warnings
    ["AtlasLoot Error!"] = true,
    ["WishList Full!"] = true,
    [" added to the WishList."] = true,
    [" already in the WishList!"] = true,
    [" deleted from the WishList."] = true,

    --Incomplete Table Registry error message
    [" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = true,

    --LoD Module disabled or missing
    [" is unavailable, the following load on demand module is required: "] = true,

    --LoD Module load sequence could not be completed
    ["Status of the following module could not be determined: "] = true,

    --LoD Module required has loaded, but loot table is missing
    [" could not be accessed, the following module may be out of date: "] = true,

    --LoD module loaded successfully
    ["sucessfully loaded."] = true,

    --Need a big dataset for searching
    ["Loading available tables for searching"] = true,

    --All Available modules loaded
    ["All Available Modules Loaded"] = true,

    --Minimap Button
    ["|cff1eff00Left-Click|r Browse Loot Tables"] = true,
    ["|cffff0000Right-Click|r View Options"] = true,
    ["|cffff0000Shift-Click|r View Options"] = true,
    ["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = true,

    --AtlasLoot Panel
    ["Options"] = true,
    ["Collections"] = true,
    ["Factions"] = true,
    ["World Events"] = true,
    ["Load Modules"] = true,
    ["Crafting"] = true,

    --First time user
    ["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = true,
    ["New feature in 4.02.01: Type '/atlasloot options' to bring up the options menu and '/atlasloot reset' to reset AtlasLoot after a disconnect."] = true,
    ["New feature in 4.03.00: Introducing the Wishlist!  Simply alt-click on any item to add it to the wishlist.  To delete an item from the wishlist, open up your wishlist and alt-click the item to remove it.  It's that simple.  Buttons to view the wishlist have been added to the Atlas interface and the loot browser."] = true,
    ["New feature in 4.05.00: Advanced searching functionality is now available. You can type in a partial item name, for example typing 'elixir' gives all items in the database with 'elixir' in the name.  Big thanks to Kurax for his help."] = true,
    ["New feature in 4.05.00: All professions are now included in the AtlasLoot_Crafting module."] = true,
    ["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = true,
    ["Setup"] = true,

    --Old Atlas Detected
    ["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = true,
    [").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = true,
    ["OK"] = true,
    ["Incompatible Atlas Detected"] = true,

    --Unsafe item tooltip
    ["Unsafe Item"] = true,
    ["Item Unavailable"] = true,
    ["ItemID:"] = true,
    ["This item is not available on your server or your battlegroup yet."] = true,
    ["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] = true,
    ["You can right-click to attempt to query the server.  You may be disconnected."] = true,

    --Misc Inventory related words
    ["Mount"] = true,
    ["Enchant"] = true,
    ["Trade Goods"] = true,
    ["Scope"] = true,
    ["Pet"] = true,
    ["Darkmoon Faire Card"] = true,
    ["Book"] = true,
    ["Banner"] = true,
    ["Set"] = true,
    ["Token"] = true,
    ["Crafting Reagent"] = true,
    ["Skinning Knife"] = true,
    ["Herbalism Knife"] = true,
    ["Fish"] = true,
    ["Combat Pet"] = true,
    ["Fireworks"] = true,
    
    --Extra inventory stuff
    ["Cloak"] = true,
    ["Weapons"] = true,

    --Labels for loot descriptions
    ["Classes:"] = true,
    ["This Item Begins a Quest"] = true,
    ["Quest Item"] = true,
    ["Quest Reward"] = true,
    ["Shared"] = true,
    ["Unique"] = true,
    ["Right Half"] = true,
    ["Left Half"] = true,
    ["28 Slot Soul Shard"] = true,
    ["20 Slot"] = true,
    ["18 Slot"] = true,
    ["16 Slot"] = true,
    ["10 Slot"] = true,
    ["(has random enchantment)"] = true,
    ["Use to purchase rewards"] = true,
    ["Use to purchase rewards (Horde)"] = true,
    ["Use to purchase rewards (Alliance)"] = true,
    ["World Bosses"] = true,
    ["Reputation Factions"] = true,
    ["Sets/Collections"] = true,
    ["Card Game Item"] = true,
    ["Tier 4"] = true,
    ["Tier 5"] = true,
    ["Tier 6"] = true,
    ["Arena Reward"] = true,
    ["Conjured Item"] = true,
    ["Used to summon boss"] = true,
    ["Phase 1"] = true,
    ["Phase 2"] = true,
    ["Phase 3"] = true,
    ["Fire"] = true,
    ["Water"] = true,
    ["Wind"] = true,
    ["Earth"] = true,
    ["Master Angler"] = true,
    ["First Prize"] = true,
    ["Rare Fish Rewards"] = true,
    ["Rare Fish"] = true,
    ["Tradable against sunmote + item above"] = true,
    ["Rare"] = true,
    ["Heroic"] = true,
    ["Summon"] = true,
    ["Random"] = true,
    ["Weapons"] = true,

    --Card Game Decks and descriptions
    ["Upper Deck Card Game Items"] = true,
    ["Heroes of Azeroth"] = true,
    ["Through The Dark Portal"] = true,
    ["Fires of Outland"] = true,
    ["Servants of the Betrayer"] = true,
    ["Hunt for Illidan"] = true,
    ["Drums of Wars"] = true,
    ["Loot Card Items"] = true,
    ["UDE Items"] = true,
    ["Landro Longshot"] = true,
    ["Thunderhead Hippogryph"] = true,
    ["Saltwater Snapjaw"] = true,
    ["King Mukla"] = true,
    ["Rest and Relaxation"] = true,
    ["Fortune Telling"] = true,
    ["Goblin Gumbo"] = true,
    ["Gone Fishin'"] = true,
    ["Spectral Tiger"] = true,
    ["March of the Legion"] = true,
    ["Kiting"] = true,
    ["Robotic Homing Chicken"] = true,
    ["Paper Airplane"] = true,
    ["Papa Hummel's Old-fashioned Pet Biscuit"] = true,
    ["Personal Weather Machine"] = true,
    ["X-51 Nether-Rocket"] = true,
    ["The Footsteps of Illidan"] = true,
    ["Disco Inferno!"] = true,
    ["Ethereal Plunderer"] = true,

    --Battleground Brackets
    ["Misc. Rewards"] = true,
    ["Superior Rewards"] = true,
    ["Epic Rewards"] = true,
    ["Level 10-19 Rewards"] = true,
    ["Level 20-29 Rewards"] = true,
    ["Level 30-39 Rewards"] = true,
    ["Level 40-49 Rewards"] = true,
    ["Level 50-59 Rewards"] = true,
    ["Level 60 Rewards"] = true,

    --Brood of Nozdormu Paths
    ["Path of the Conqueror"] = true,
    ["Path of the Invoker"] = true,
    ["Path of the Protector"] = true,

    --Violet Eye Paths
    ["Path of the Violet Protector"] = true,
    ["Path of the Violet Mage"] = true,
    ["Path of the Violet Assassin"] = true,
    ["Path of the Violet Restorer"] = true,

    --AQ Opening Event
    ["Red Scepter Shard"] = true,
    ["Blue Scepter Shard"] = true,
    ["Green Scepter Shard"] = true,
    ["Scepter of the Shifting Sands"] = true,

    --World PvP
    ["Hellfire Fortifications"] = true,
    ["Twin Spire Ruins"] = true,
    ["Spirit Towers"] = true,
    ["Halaa"] = true,

    --Karazhan Opera Event Headings
    ["Shared Drops"] = true,
    ["Romulo & Julianne"] = true,
    ["Wizard of Oz"] = true,
    ["Red Riding Hood"] = true,

    --Karazhan Animal Boss Types
    ["Spider"] = true,
    ["Darkhound"] = true,
    ["Bat"] = true,

    --ZG Tokens
    ["Primal Hakkari Kossack"] = true,
    ["Primal Hakkari Shawl"] = true,
    ["Primal Hakkari Bindings"] = true,
    ["Primal Hakkari Sash"] = true,
    ["Primal Hakkari Stanchion"] = true,
    ["Primal Hakkari Aegis"] = true,
    ["Primal Hakkari Girdle"] = true,
    ["Primal Hakkari Armsplint"] = true,
    ["Primal Hakkari Tabard"] = true,

    --AQ20 Tokens
    ["Qiraji Ornate Hilt"] = true,
    ["Qiraji Martial Drape"] = true,
    ["Qiraji Magisterial Ring"] = true,
    ["Qiraji Ceremonial Ring"] = true,
    ["Qiraji Regal Drape"] = true,
    ["Qiraji Spiked Hilt"] = true,

    --AQ40 Tokens
    ["Qiraji Bindings of Dominance"] = true,
    ["Qiraji Bindings of Command"] = true,
    ["Vek'nilash's Circlet"] = true,
    ["Vek'lor's Diadem"] = true,
    ["Ouro's Intact Hide"] = true,
    ["Skin of the Great Sandworm"] = true,
    ["Husk of the Old God"] = true,
    ["Carapace of the Old God"] = true,

    --Blacksmithing Crafted Sets
    ["Imperial Plate"] = true,
    ["The Darksoul"] = true,
    ["Fel Iron Plate"] = true,
    ["Adamantite Battlegear"] = true,
    ["Flame Guard"] = true,
    ["Enchanted Adamantite Armor"] = true,
    ["Khorium Ward"] = true,
    ["Faith in Felsteel"] = true,
    ["Burning Rage"] = true,
    ["Bloodsoul Embrace"] = true,
    ["Fel Iron Chain"] = true,

    --Tailoring Crafted Sets
    ["Bloodvine Garb"] = true,
    ["Netherweave Vestments"] = true,
    ["Imbued Netherweave"] = true,
    ["Arcanoweave Vestments"] = true,
    ["The Unyielding"] = true,
    ["Whitemend Wisdom"] = true,
    ["Spellstrike Infusion"] = true,
    ["Battlecast Garb"] = true,
    ["Soulcloth Embrace"] = true,
    ["Primal Mooncloth"] = true,
    ["Shadow's Embrace"] = true,
    ["Wrath of Spellfire"] = true,

    --Leatherworking Crafted Sets
    ["Volcanic Armor"] = true,
    ["Ironfeather Armor"] = true,
    ["Stormshroud Armor"] = true,
    ["Devilsaur Armor"] = true,
    ["Blood Tiger Harness"] = true,
    ["Primal Batskin"] = true,
    ["Wild Draenish Armor"] = true,
    ["Thick Draenic Armor"] = true,
    ["Fel Skin"] = true,
    ["Strength of the Clefthoof"] = true,
    ["Green Dragon Mail"] = true,
    ["Blue Dragon Mail"] = true,
    ["Black Dragon Mail"] = true,
    ["Scaled Draenic Armor"] = true,
    ["Felscale Armor"] = true,
    ["Felstalker Armor"] = true,
    ["Fury of the Nether"] = true,
    ["Primal Intent"] = true,
    ["Windhawk Armor"] = true,
    ["Netherscale Armor"] = true,
    ["Netherstrike Armor"] = true,

    --Vanilla WoW Sets
    ["Defias Leather"] = true,
    ["Embrace of the Viper"] = true,
    ["Chain of the Scarlet Crusade"] = true,
    ["The Gladiator"] = true,
    ["Ironweave Battlesuit"] = true,
    ["Necropile Raiment"] = true,
    ["Cadaverous Garb"] = true,
    ["Bloodmail Regalia"] = true,
    ["Deathbone Guardian"] = true,
    ["The Postmaster"] = true,
    ["Scourge Invasion"] = true,
    ["Regalia of Undead Cleansing"] = true,
    ["Undead Slayer's Armor"] = true,
    ["Garb of the Undead Slayer"] = true,
    ["Battlegear of Undead Slaying"] = true,
    ["Shard of the Gods"] = true,
    ["Zul'Gurub Rings"] = true,
    ["Major Mojo Infusion"] = true,
    ["Overlord's Resolution"] = true,
    ["Prayer of the Primal"] = true,
    ["Zanzil's Concentration"] = true,
    ["Spirit of Eskhandar"] = true,
    ["The Twin Blades of Hakkari"] = true,
    ["Primal Blessing"] = true,
    ["Dal'Rend's Arms"] = true,
    ["Spider's Kiss"] = true,

    --The Burning Crusade Sets
    ["Latro's Flurry"] = true,
    ["The Twin Stars"] = true,
    ["The Twin Blades of Azzinoth"] = true,

    --ZG Sets
    ["Haruspex's Garb"] = true,
    ["Predator's Armor"] = true,
    ["Illusionist's Attire"] = true,
    ["Freethinker's Armor"] = true,
    ["Confessor's Raiment"] = true,
    ["Madcap's Outfit"] = true,
    ["Augur's Regalia"] = true,
    ["Demoniac's Threads"] = true,
    ["Vindicator's Battlegear"] = true,

    --AQ20 Sets
    ["Symbols of Unending Life"] = true,
    ["Trappings of the Unseen Path"] = true,
    ["Trappings of Vaulted Secrets"] = true,
    ["Battlegear of Eternal Justice"] = true,
    ["Finery of Infinite Wisdom"] = true,
    ["Emblems of Veiled Shadows"] = true,
    ["Gift of the Gathering Storm"] = true,
    ["Implements of Unspoken Names"] = true,
    ["Battlegear of Unyielding Strength"] = true,

    --AQ40 Sets
    ["Genesis Raiment"] = true,
    ["Striker's Garb"] = true,
    ["Enigma Vestments"] = true,
    ["Avenger's Battlegear"] = true,
    ["Garments of the Oracle"] = true,
    ["Deathdealer's Embrace"] = true,
    ["Stormcaller's Garb"] = true,
    ["Doomcaller's Attire"] = true,
    ["Conqueror's Battlegear"] = true,

    --Dungeon 1 Sets
    ["Wildheart Raiment"] = true,
    ["Beaststalker Armor"] = true,
    ["Magister's Regalia"] = true,
    ["Lightforge Armor"] = true,
    ["Vestments of the Devout"] = true,
    ["Shadowcraft Armor"] = true,
    ["The Elements"] = true,
    ["Dreadmist Raiment"] = true,
    ["Battlegear of Valor"] = true,

    --Dungeon 2 Sets
    ["Feralheart Raiment"] = true,
    ["Beastmaster Armor"] = true,
    ["Sorcerer's Regalia"] = true,
    ["Soulforge Armor"] = true,
    ["Vestments of the Virtuous"] = true,
    ["Darkmantle Armor"] = true,
    ["The Five Thunders"] = true,
    ["Deathmist Raiment"] = true,
    ["Battlegear of Heroism"] = true,

    --Dungeon 3 Sets
    ["Hallowed Raiment"] = true,
    ["Incanter's Regalia"] = true,
    ["Mana-Etched Regalia"] = true,
    ["Oblivion Raiment"] = true,
    ["Assassination Armor"] = true,
    ["Moonglade Raiment"] = true,
    ["Wastewalker Armor"] = true,
    ["Beast Lord Armor"] = true,
    ["Desolation Battlegear"] = true,
    ["Tidefury Raiment"] = true,
    ["Bold Armor"] = true,
    ["Doomplate Battlegear"] = true,
    ["Righteous Armor"] = true,

    --Tier 1 Sets
    ["Cenarion Raiment"] = true,
    ["Giantstalker Armor"] = true,
    ["Arcanist Regalia"] = true,
    ["Lawbringer Armor"] = true,
    ["Vestments of Prophecy"] = true,
    ["Nightslayer Armor"] = true,
    ["The Earthfury"] = true,
    ["Felheart Raiment"] = true,
    ["Battlegear of Might"] = true,

    --Tier 2 Sets
    ["Stormrage Raiment"] = true,
    ["Dragonstalker Armor"] = true,
    ["Netherwind Regalia"] = true,
    ["Judgement Armor"] = true,
    ["Vestments of Transcendence"] = true,
    ["Bloodfang Armor"] = true,
    ["The Ten Storms"] = true,
    ["Nemesis Raiment"] = true,
    ["Battlegear of Wrath"] = true,

    --Tier 3 Sets
    ["Dreamwalker Raiment"] = true,
    ["Cryptstalker Armor"] = true,
    ["Frostfire Regalia"] = true,
    ["Redemption Armor"] = true,
    ["Vestments of Faith"] = true,
    ["Bonescythe Armor"] = true,
    ["The Earthshatterer"] = true,
    ["Plagueheart Raiment"] = true,
    ["Dreadnaught's Battlegear"] = true,

    --Tier 4 Sets
    ["Malorne Harness"] = true,
    ["Malorne Raiment"] = true,
    ["Malorne Regalia"] = true,
    ["Demon Stalker Armor"] = true,
    ["Aldor Regalia"] = true,
    ["Justicar Armor"] = true,
    ["Justicar Battlegear"] = true,
    ["Justicar Raiment"] = true,
    ["Incarnate Raiment"] = true,
    ["Incarnate Regalia"] = true,
    ["Netherblade Set"] = true,
    ["Cyclone Harness"] = true,
    ["Cyclone Raiment"] = true,
    ["Cyclone Regalia"] = true,
    ["Voidheart Raiment"] = true,
    ["Warbringer Armor"] = true,
    ["Warbringer Battlegear"] = true,

    --Tier 5 Sets
    ["Nordrassil Harness"] = true,
    ["Nordrassil Raiment"] = true,
    ["Nordrassil Regalia"] = true,
    ["Rift Stalker Armor"] = true,
    ["Tirisfal Regalia"] = true,
    ["Crystalforge Armor"] = true,
    ["Crystalforge Battlegear"] = true,
    ["Crystalforge Raiment"] = true,
    ["Avatar Raiment"] = true,
    ["Avatar Regalia"] = true,
    ["Deathmantle Set"] = true,
    ["Cataclysm Harness"] = true,
    ["Cataclysm Raiment"] = true,
    ["Cataclysm Regalia"] = true,
    ["Corruptor Raiment"] = true,
    ["Destroyer Armor"] = true,
    ["Destroyer Battlegear"] = true,

    --Tier 6 Sets
    ["Thunderheart Harness"] = true,
    ["Thunderheart Raiment"] = true,
    ["Thunderheart Regalia"] = true,
    ["Gronnstalker's Armor"] = true,
    ["Tempest Regalia"] = true,
    ["Lightbringer Armor"] = true,
    ["Lightbringer Battlegear"] = true,
    ["Lightbringer Raiment"] = true,
    ["Vestments of Absolution"] = true,
    ["Absolution Regalia"] = true,
    ["Slayer's Armor"] = true,
    ["Skyshatter Harness"] = true,
    ["Skyshatter Raiment"] = true,
    ["Skyshatter Regalia"] = true,
    ["Malefic Raiment"] = true,
    ["Onslaught Armor"] = true,
    ["Onslaught Battlegear"] = true,

    --Arathi Basin Sets - Alliance
    ["The Highlander's Intent"] = true,
    ["The Highlander's Purpose"] = true,
    ["The Highlander's Will"] = true,
    ["The Highlander's Determination"] = true,
    ["The Highlander's Fortitude"] = true,
    ["The Highlander's Resolution"] = true,
    ["The Highlander's Resolve"] = true,

    --Arathi Basin Sets - Horde
    ["The Defiler's Intent"] = true,
    ["The Defiler's Purpose"] = true,
    ["The Defiler's Will"] = true,
    ["The Defiler's Determination"] = true,
    ["The Defiler's Fortitude"] = true,
    ["The Defiler's Resolution"] = true,

    --PvP Level 60 Rare Sets - Alliance
    ["Lieutenant Commander's Refuge"] = true,
    ["Lieutenant Commander's Pursuance"] = true,
    ["Lieutenant Commander's Arcanum"] = true,
    ["Lieutenant Commander's Redoubt"] = true,
    ["Lieutenant Commander's Investiture"] = true,
    ["Lieutenant Commander's Guard"] = true,
    ["Lieutenant Commander's Stormcaller"] = true,
    ["Lieutenant Commander's Dreadgear"] = true,
    ["Lieutenant Commander's Battlearmor"] = true,

    --PvP Level 60 Rare Sets - Horde
    ["Champion's Refuge"] = true,
    ["Champion's Pursuance"] = true,
    ["Champion's Arcanum"] = true,
    ["Champion's Redoubt"] = true,
    ["Champion's Investiture"] = true,
    ["Champion's Guard"] = true,
    ["Champion's Stormcaller"] = true,
    ["Champion's Dreadgear"] = true,
    ["Champion's Battlearmor"] = true,

    --PvP Level 60 Epic Sets - Alliance
    ["Field Marshal's Sanctuary"] = true,
    ["Field Marshal's Pursuit"] = true,
    ["Field Marshal's Regalia"] = true,
    ["Field Marshal's Aegis"] = true,
    ["Field Marshal's Raiment"] = true,
    ["Field Marshal's Vestments"] = true,
    ["Field Marshal's Earthshaker"] = true,
    ["Field Marshal's Threads"] = true,
    ["Field Marshal's Battlegear"] = true,

    --PvP Level 60 Epic Sets - Horde
    ["Warlord's Sanctuary"] = true,
    ["Warlord's Pursuit"] = true,
    ["Warlord's Regalia"] = true,
    ["Warlord's Aegis"] = true,
    ["Warlord's Raiment"] = true,
    ["Warlord's Vestments"] = true,
    ["Warlord's Earthshaker"] = true,
    ["Warlord's Threads"] = true,
    ["Warlord's Battlegear"] = true,

    --Outland Faction Reputation PvP Sets
    ["Dragonhide Battlegear"] = true,
    ["Wyrmhide Battlegear"] = true,
    ["Kodohide Battlegear"] = true,
    ["Stalker's Chain Battlegear"] = true,
    ["Evoker's Silk Battlegear"] = true,
    ["Crusader's Scaled Battledgear"] = true,
    ["Crusader's Ornamented Battledgear"] = true,
    ["Satin Battlegear"] = true,
    ["Mooncloth Battlegear"] = true,
    ["Opportunist's Battlegear"] = true,
    ["Seer's Linked Battlegear"] = true,
    ["Seer's Mail Battlegear"] = true,
    ["Seer's Ringmail Battlegear"] = true,
    ["Dreadweave Battlegear"] = true,
    ["Savage's Plate Battlegear"] = true,

    --Arena Epic Sets
    ["Gladiator's Sanctuary"] = true,
    ["Gladiator's Wildhide"] = true,
    ["Gladiator's Refuge"] = true,
    ["Gladiator's Pursuit"] = true,
    ["Gladiator's Regalia"] = true,
    ["Gladiator's Aegis"] = true,
    ["Gladiator's Vindication"] = true,
    ["Gladiator's Redemption"] = true,
    ["Gladiator's Raiment"] = true,
    ["Gladiator's Investiture"] = true,
    ["Gladiator's Vestments"] = true,
    ["Gladiator's Earthshaker"] = true,
    ["Gladiator's Thunderfist"] = true,
    ["Gladiator's Wartide"] = true,
    ["Gladiator's Dreadgear"] = true,
    ["Gladiator's Felshroud"] = true,
    ["Gladiator's Battlegear"] = true,

    --Set Labels
    ["Set: Embrace of the Viper"] = true,
    ["Set: Defias Leather"] = true,
    ["Set: The Gladiator"] = true,
    ["Set: Chain of the Scarlet Crusade"] = true,
    ["Set: The Postmaster"] = true,
    ["Set: Necropile Raiment"] = true,
    ["Set: Cadaverous Garb"] = true,
    ["Set: Bloodmail Regalia"] = true,
    ["Set: Deathbone Guardian"] = true,
    ["Set: Dal'Rend's Arms"] = true,
    ["Set: Spider's Kiss"] = true,
    ["Temple of Ahn'Qiraj Sets"] = true,
    ["AQ40 Class Sets"] = true,
    ["Ruins of Ahn'Qiraj Sets"] = true,
    ["AQ20 Class Sets"] = true,
    ["AQ Enchants"] = true,
    ["AQ Opening Quest Chain"] = true,
    ["Pre 60 Sets"] = true,
    ["Crafted Sets"] = true,
    ["Crafted Epic Weapons"] = true,
    ["Zul'Gurub Sets"] = true,
    ["ZG Class Sets"] = true,
    ["ZG Enchants"] = true,
    ["Dungeon 1/2 Sets"] = true,
    ["Dungeon 1 Set"] = true,
    ["Dungeon 2 Set"] = true,
    ["Dungeon 3 Sets"] = true,
    ["Tier 1 Sets"] = true,
    ["Tier 2 Sets"] = true,
    ["Tier 3 Sets"] = true,
    ["Tier 4 Sets"] = true,
    ["Tier 5 Sets"] = true,
    ["Tier 6 Sets"] = true,
    ["PvP Sets (Level 60)"] = true,
    ["PvP Sets (Level 70)"] = true,
    ["PvP Reputation Sets (Level 70)"] = true,
    ["PvP Rewards (Level 60)"] = true,
    ["PvP Rewards (Level 70)"] = true,
    ["PvP Accessories (Level 60)"] = true,
    ["PvP Accessories - Alliance (Level 60)"] = true,
    ["PvP Accessories - Horde (Level 60)"] = true,
    ["PvP Accessories (Level 70)"] = true,
    ["PvP Rewards"] = true,
    ["PvP Armor Sets"] = true,
    ["PvP Weapons"] = true,
    ["PvP Weapons (Level 60)"] = true,
    ["PvP Weapons (Level 70)"] = true,
    ["PvP Accessories"] = true,
    ["PvP Non-Set Epics"] = true,
    ["PvP Honor System"] = true,
    ["PvP Reputation Sets"] = true,
    ["Arena PvP Sets"] = true,
    ["Arena 2 PvP Sets"] = true,
    ["Arena 3 PvP Sets"] = true,
    ["Arena 4 PvP Sets"] = true,
    ["Arena PvP Weapons"] = true,
    ["Arena 2 PvP Weapons"] = true,
    ["Arena 3 PvP Weapons"] = true,
    ["Arena 4 PvP Weapons"] = true,
    ["Arena PvP System"] = true,
    ["Arena Season 1 Weapons"] = true,
    ["Arena Season 2 Weapons"] = true,
    ["Arena Season 3 Weapons"] = true,
    ["Arena Season 4 Weapons"] = true,
    ["Season 1"] = true,
    ["Season 2"] = true,
    ["Season 3"] = true,
    ["Season 4"] = true,
    ["Arathi Basin Sets"] = true,
    ["Class Books"] = true,
    ["Tribute Run"] = true,
    ["Dire Maul Books"] = true,
    ["Random Boss Loot"] = true,
    ["Class Set Pieces"] = true,
    ["Epic Set"] = true,
    ["Rare Set"] = true,
    ["Legendary Items"] = true,
    ["Badge of Justice Rewards"] = true,
    ["Lvl 70 Instance Token Rewards"] = true,
    ["Lvl 70 Instance Rewards"] = true,
    ["Accesories and Weapons"] = true,
    ["Accessories"] = true,
    ["Armor and Weapons"] = true,
    ["Fire Resistance Gear"] = true,
    ["Arcane Resistance Gear"] = true,
    ["Nature Resistance Gear"] = true,
    ["Frost Resistance Gear"] = true,
    ["Shadow Resistance Gear"] = true,
    ["Rare Mounts"] = true,
    ["Tabards"] = true,
    ["Token Hand-Ins"] = true,
    ["Heroic Mode Keys"] = true,
    ["Legendary Items for Kael'thas Fight"] = true,
    ["BoE World Epics"] = true,
    ["World Epics"] = true,
    ["Level 30-39"] = true,
    ["Level 40-49"] = true,
    ["Level 50-60"] = true,
    ["BT Patterns/Plans"] = true,
    ["Hyjal Summit Designs"] =true,
    ["SP Patterns/Plans"] = true,

    --NPCs missing from BabbleBoss
    ["Trash Mobs"] = true,
    ["Dungeon Set 2 Summonable"] = true,
    ["Highlord Kruul"] = true,
    ["Theldren"] = true,
    ["Sothos and Jarien"] = true,
    ["Druid of the Fang"] = true,
    ["Defias Strip Miner"] = true,
    ["Defias Overseer/Taskmaster"] = true,
    ["Scarlet Defender/Myrmidon"] = true,
    ["Scarlet Champion"] = true,
    ["Scarlet Centurion"] = true,
    ["Scarlet Trainee"] = true,
    ["Herod/Mograine"] = true,
    ["Scarlet Protector/Guardsman"] = true,
    ["Shadowforge Flame Keeper"] = true,
    ["Olaf"] = true,
    ["Eric 'The Swift'"] = true,
    ["Shadow of Doom"] = true,
    ["Bone Witch"] = true,
    ["Lumbering Horror"] = true,
    ["Avatar of the Martyred"] = true,
    ["Yor"] = true,
    ["Nexus Stalker"] = true,
    ["Auchenai Monk"] = true,
    ["Cabal Fanatic"] = true,
    ["Unchained Doombringer"] = true,
    ["Crimson Sorcerer"] = true,
    ["Thuzadin Shadowcaster"] = true,
    ["Crimson Inquisitor"] = true,
    ["Crimson Battle Mage"] = true,
    ["Ghoul Ravener"] = true,
    ["Spectral Citizen"] = true,
    ["Spectral Researcher"] = true,
    ["Scholomance Adept"] = true,
    ["Scholomance Dark Summoner"] = true,
    ["Blackhand Elite"] = true,
    ["Blackhand Assassin"] = true,
    ["Firebrand Pyromancer"] = true,
    ["Firebrand Invoker"] = true,
    ["Firebrand Grunt"] = true,
    ["Firebrand Legionnaire"] = true,
    ["Spirestone Warlord"] = true,
    ["Spirestone Mystic"] = true,
    ["Anvilrage Captain"] = true,
    ["Anvilrage Marshal"] = true,
    ["Doomforge Arcanasmith"] = true,
    ["Weapon Technician"] = true,
    ["Doomforge Craftsman"] = true,
    ["Murk Worm"] = true,
    ["Atal'ai Witch Doctor"] = true,
    ["Raging Skeleton"] = true,
    ["Ethereal Priest"] = true,
    ["Sethekk Ravenguard"] = true,
    ["Time-Lost Shadowmage"] = true,
    ["Coilfang Sorceress"] = true,
    ["Coilfang Oracle"] = true,
    ["Shattered Hand Centurion"] = true,
    ["Eredar Deathbringer"] = true,
    ["Arcatraz Sentinel"] = true,
    ["Gargantuan Abyssal"] = true,
    ["Sunseeker Botanist"] = true,
    ["Sunseeker Astromage"] = true,
    ["Durnholde Rifleman"] = true,
    ["Rift Keeper/Rift Lord"] = true,
    ["Crimson Templar"] = true,
    ["Azure Templar"] = true,
    ["Hoary Templar"] = true,
    ["Earthen Templar"] = true,
    ["The Duke of Cynders"] = true,
    ["The Duke of Fathoms"] = true,
    ["The Duke of Zephyrs"] = true,
    ["The Duke of Shards"] = true,
    ["Aether-tech Assistant"] = true,
    ["Aether-tech Adept"] = true,
    ["Aether-tech Master"] = true,
    ["Trelopades"] = true,
    ["King Dorfbruiser"] = true,
    ["Gorgolon the All-seeing"] = true,
    ["Matron Li-sahar"] = true,
    ["Solus the Eternal"] = true,
    ["Balzaphon"] = true,
    ["Lord Blackwood"] = true,
    ["Revanchion"] = true,
    ["Scorn"] = true,
    ["Sever"] = true,
    ["Lady Falther'ess"] = true,
    ["Smokywood Pastures Vendor"] = true,
    ["Shartuul"] = true,
    ["Darkscreecher Akkarai"] = true,
    ["Karrog"] = true,
    ["Gezzarak the Huntress"] = true,
    ["Vakkiz the Windrager"] = true,
    ["Terokk"] = true,
    ["Armbreaker Huffaz"] = true,
    ["Fel Tinkerer Zortan"] = true,
    ["Forgosh"] = true,
    ["Gul'bor"] = true,
    ["Malevus the Mad"] = true,
    ["Porfus the Gem Gorger"] = true,
    ["Wrathbringer Laz-tarash"] = true,
    ["Bash'ir Landing Stasis Chambers"] = true,
    ["Templars"] = true,
    ["Dukes"] = true,
    ["High Council"] = true,
    ["Headless Horseman"] = true,
    ["Barleybrew Brewery"] = true,
    ["Thunderbrew Brewery"] = true,
    ["Gordok Brewery"] = true,
    ["Drohn's Distillery"] = true,
    ["T'chali's Voodoo Brewery"] = true,
    ["Scarshield Quartermaster"] = true,
    ["Overmaster Pyron"] = true,
    ["Father Flame"] = true,
    ["Thomas Yance"] = true,
    ["Knot Thimblejack"] = true,
    ["Shen'dralar Provisioner"] = true,
    ["Namdo Bizzfizzle"] = true,
    ["The Nameles Prophet"] = true,
    ["Zelemar the Wrathful"] = true,
    ["Henry Stern"] = true,
    ["Aggem Thorncurse"] = true,
    ["Roogug"] = true,
    ["Rajaxx's Captains"] = true,
    ["Razorfen Spearhide"] = true,
    ["Rethilgore"] = true,
    ["Kalldan Felmoon"] = true,
    ["Magregan Deepshadow"] = true,
    ["Lord Ahune"] = true,
    ["Coren Direbrew"] = true,
    ["Don Carlos"] = true,

    --Zones
    ["World Drop"] = true,
    ["Sunwell Isle"] = true,
	
    --Shortcuts for Bossname files
    ["LBRS"] = true,
    ["UBRS"] = true,
    ["CoT1"] = true,
    ["CoT2"] = true,
    ["Scholo"] = true,
    ["Strat"] = true,
    ["Serpentshrine"] = true,

    --Chests, etc
    ["Dark Coffer"] = true,
    ["The Secret Safe"] = true,
    ["The Vault"] = true,
    ["Ogre Tannin Basket"] = true,
    ["Fengus's Chest"] = true,
    ["The Prince's Chest"] = true,
    ["Doan's Strongbox"] = true,
    ["Frostwhisper's Embalming Fluid"] = true,
    ["Unforged Rune Covered Breastplate"] = true,
    ["Malor's Strongbox"] = true,
    ["Unfinished Painting"] = true,
    ["Felvine Shard"] = true,
    ["Baelog's Chest"] = true,
    ["Lorgalis Manuscript"] = true,
    ["Fathom Core"] = true,
    ["Conspicuous Urn"] = true,
    ["Gift of Adoration"] = true,
    ["Box of Chocolates"] = true,
    ["Treat Bag"] = true,
    ["Gaily Wrapped Present"] = true,
    ["Festive Gift"] = true,
    ["Ticking Present"] = true,
    ["Gently Shaken Gift"] = true,
    ["Carefully Wrapped Present"] = true,
    ["Winter Veil Gift"] = true,
    ["Smokywood Pastures Extra-Special Gift"] = true,
    ["Brightly Colored Egg"] = true,
    ["Lunar Festival Fireworks Pack"] = true,
    ["Lucky Red Envelope"] = true,
    ["Small Rocket Recipes"] = true,
    ["Large Rocket Recipes"] = true,
    ["Cluster Rocket Recipes"] = true,
    ["Large Cluster Rocket Recipes"] = true,
    ["Timed Reward Chest"] = true,
    ["Timed Reward Chest 1"] = true,
    ["Timed Reward Chest 2"] = true,
    ["Timed Reward Chest 3"] = true,
    ["Timed Reward Chest 4"] = true,
    ["The Talon King's Coffer"] = true,
    ["Krom Stoutarm's Chest"] = true,
    ["Garrett Family Chest"] = true,
    ["Reinforced Fel Iron Chest"] = true,
    ["DM North Tribute Chest"] = true,

    --World Events
    ["Abyssal Council"] = true,
    ["Bash'ir Landing Skyguard Raid"] = true,
    ["Brewfest"] = true,
    ["Children's Week"] = true,
    ["Elemental Invasion"] = true,
    ["Ethereum Prison"] = true,
    ["Feast of Winter Veil"] = true,
    ["Gurubashi Arena Booty Run"] = true,
    ["Hallow's End"] = true,
    ["Harvest Festival"] = true,
    ["Love is in the Air"] = true,
    ["Lunar Festival"] = true,
    ["Midsummer Fire Festival"] = true,
    ["Noblegarden"] = true,
    ["Skettis"] = true,
    ["Stranglethorn Fishing Extravaganza"] = true,

    } end)