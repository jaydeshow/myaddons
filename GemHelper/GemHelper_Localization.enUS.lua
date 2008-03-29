---------------------------------------------------------
-- Localizable strings (defaults) for enUS and enGB

GEMHELPER_VERSION_TEXT		= "Gem Helper v1.5";
GEMHELPER_DONE_TEXT		= "Done";

GEMHELPER_ERRORTOOLTIP_L1	= "Unsafe Item";
GEMHELPER_ERRORTOOLTIP_L2	= "ItemID: ";
GEMHELPER_ERRORTOOLTIP_L3	= "This item is unsafe. To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10.";
GEMHELPER_ERRORTOOLTIP_L4	= "You can right-click to attempt to query the server.  You may be disconnected.";
GEMHELPER_QUERY_MESSAGE		= "Server queried for ";

GEMHELPER_OPENJC_TEXT		= "Open/close the original JC tradeskill window.";
GEMHELPER_CHANGEBGCOLOR_TEXT	= "Change the background color.";

-- GEMHELPER_JEWELCRAFTING_TEXT must match the text written on the top of default Jewelcrafting UI
-- window, which should also be the same as the text written in your Character --> Skills -->
-- Professions panel because this string is used to check whether a player has Jewelcrafting as
-- a profession as well as whether the Jewelcrafting default UI window is about to be open.
GEMHELPER_JEWELCRAFTING_TEXT	= "Jewelcrafting";

GEMHELPER_CHECKBUTTON_TEXT	= {
	[1]	= "Filter by Gem Color",
	[2]	= "Filter by Material",
	[3]	= "Filter by Statistic",

	[11]	= "Blue gems",
	[12]	= "Red gems",
	[13]	= "Yellow gems",
	[14]	= "Meta gems",

	[21]	= "Azure Moonstone (B)",
	[22]	= "Blood Garnet (R)",
	[23]	= "Golden Draenite (Y)",
	[24]	= "Deep Peridot (Y/B)",
	[25]	= "Flame Spessarite (Y/R)",
	[26]	= "Shadow Draenite (R/B)",
	[27]	= "Jaggal Pearl (R/B)",

	[31]	= "Star of Elune (B)",
	[32]	= "Living Ruby (R)",
	[33]	= "Dawnstone (Y)",
	[34]	= "Talasite (Y/B)",
	[35]	= "Noble Topaz (Y/R)",
	[36]	= "Nightseye (R/B)",
	[37]	= "Shadow Pearl (R/B)",

	[41]	= "Skyfire Diamond (M)",
	[42]	= "Earthstorm Diam. (M)",

	[51]	= "Empyrean Sapphire (B)",
	[52]	= "Crimson Spinel (R)",
	[53]	= "Lionseye (Y)",
	[54]	= "Seaspray Emerald (Y/B)",
	[55]	= "Pyrestone (Y/R)",
	[56]	= "Shadowsong Ameth. (R/B)",

	[61]	= "Strength",
	[62]	= "Agility",
	[63]	= "Stamina",
	[64]	= "Intellect",
	[65]	= "Spirit",
	[66]	= "Resilience",

	[71]	= "Hit Rating",
	[72]	= "Critical Strike Rating",
	[73]	= "Attack Power",
	[74]	= "Dodge Rating",
	[75]	= "Defense Rating",
	[76]	= "Parry Rating",

	[80]	= "Spell Hit Rating",
	[81]	= "Spell Critical Rating",
	[82]	= "Spell Penetration",
	[83]	= "Spell Damage",
	[84]	= "Healing",
	[85]	= "Mana every 5 seconds",
	[86]	= "Resist All",

	[101]	= "Show Jewelcrafting Gems",
	[1011]	= "Have Materials",
	[1012]	= "That %s Can Cut",
	[102]	= "Show Enchanting Gems",
	[103]	= "Show Vendor Gems",
	[104]	= "Show Instance Drop Gems",

	[111]	= "Replace default JC UI",
};

-- Data for English localization
GemHelper_GemLocaleData = {
	-- Crafted Uncommon Quality Gems
	[23095] = {["n"] = "Bold Blood Garnet",			["d"] = "Crafted, 1 Blood Garnet"},
	[28595] = {["n"] = "Bright Blood Garnet",		["d"] = "Crafted, 1 Blood Garnet"},
	[23113] = {["n"] = "Brilliant Golden Draenite",		["d"] = "Crafted, 1 Golden Draenite"},
	[23106] = {["n"] = "Dazzling Deep Peridot",		["d"] = "Crafted, 1 Deep Peridot (Scryers only)"},
	[23097] = {["n"] = "Delicate Blood Garnet",		["d"] = "Crafted, 1 Blood Garnet"},
	[23105] = {["n"] = "Enduring Deep Peridot",		["d"] = "Crafted, 1 Deep Peridot"},
	[23114] = {["n"] = "Gleaming Golden Draenite",		["d"] = "Crafted, 1 Golden Draenite"},
	[23100] = {["n"] = "Glinting Flame Spessarite",		["d"] = "Crafted, 1 Flame Spessarite"},
	[23108] = {["n"] = "Glowing Shadow Draenite",		["d"] = "Crafted, 1 Shadow Draenite"},
	[23098] = {["n"] = "Inscribed Flame Spessarite",	["d"] = "Crafted, 1 Flame Spessarite"},
	[23104] = {["n"] = "Jagged Deep Peridot",		["d"] = "Crafted, 1 Deep Peridot"},
	[23099] = {["n"] = "Luminous Flame Spessarite",		["d"] = "Crafted, 1 Flame Spessarite"},
	[23121] = {["n"] = "Lustrous Azure Moonstone",		["d"] = "Crafted, 1 Azure Moonstone"},
	[23101] = {["n"] = "Potent Flame Spessarite",		["d"] = "Crafted, 1 Flame Spessarite"},
	[23103] = {["n"] = "Radiant Deep Peridot",		["d"] = "Crafted, 1 Deep Peridot"},
	[23116] = {["n"] = "Rigid Golden Draenite",		["d"] = "Crafted, 1 Golden Draenite"},
	[23109] = {["n"] = "Royal Shadow Draenite",		["d"] = "Crafted, 1 Shadow Draenite (Aldor only)"},
	[23096] = {["n"] = "Runed Blood Garnet",		["d"] = "Crafted, 1 Blood Garnet"},
	[23110] = {["n"] = "Shifting Shadow Draenite",		["d"] = "Crafted, 1 Shadow Draenite"},
	[28290] = {["n"] = "Smooth Golden Draenite",		["d"] = "Crafted, 1 Golden Draenite"},
	[23118] = {["n"] = "Solid Azure Moonstone",		["d"] = "Crafted, 1 Azure Moonstone"},
	[23111] = {["n"] = "Sovereign Shadow Draenite",		["d"] = "Crafted, 1 Shadow Draenite"},
	[23119] = {["n"] = "Sparkling Azure Moonstone",		["d"] = "Crafted, 1 Azure Moonstone"},
	[23120] = {["n"] = "Stormy Azure Moonstone",		["d"] = "Crafted, 1 Azure Moonstone"},
	[23094] = {["n"] = "Teardrop Blood Garnet",		["d"] = "Crafted, 1 Blood Garnet"},
	[23115] = {["n"] = "Thick Golden Draenite",		["d"] = "Crafted, 1 Golden Draenite"},

	-- Crafted Rare Quality Gems
	[24027] = {["n"] = "Bold Living Ruby",			["d"] = "Crafted, 1 Living Ruby"},
	[24031] = {["n"] = "Bright Living Ruby",		["d"] = "Crafted, 1 Living Ruby"},
	[24047] = {["n"] = "Brilliant Dawnstone",		["d"] = "Crafted, 1 Dawnstone"},
	[24065] = {["n"] = "Dazzling Talasite",			["d"] = "Crafted, 1 Talasite"},
	[24028] = {["n"] = "Delicate Living Ruby",		["d"] = "Crafted, 1 Living Ruby"},
	[24062] = {["n"] = "Enduring Talasite",			["d"] = "Crafted, 1 Talasite"},
	[24036] = {["n"] = "Flashing Living Ruby",		["d"] = "Crafted, 1 Living Ruby"},
	[24050] = {["n"] = "Gleaming Dawnstone",		["d"] = "Crafted, 1 Dawnstone"},
	[24061] = {["n"] = "Glinting Noble Topaz",		["d"] = "Crafted, 1 Noble Topaz"},
	[24056] = {["n"] = "Glowing Nightseye",			["d"] = "Crafted, 1 Nightseye"},
	[24058] = {["n"] = "Inscribed Noble Topaz",		["d"] = "Crafted, 1 Noble Topaz"},
	[24067] = {["n"] = "Jagged Talasite",			["d"] = "Crafted, 1 Talasite"},
	[24060] = {["n"] = "Luminous Noble Topaz",		["d"] = "Crafted, 1 Noble Topaz"},
	[24037] = {["n"] = "Lustrous Star of Elune",		["d"] = "Crafted, 1 Star of Elune"},
	[24059] = {["n"] = "Potent Noble Topaz",		["d"] = "Crafted, 1 Noble Topaz"},
	[24066] = {["n"] = "Radiant Talasite",			["d"] = "Crafted, 1 Talasite"},
	[24051] = {["n"] = "Rigid Dawnstone",			["d"] = "Crafted, 1 Dawnstone"},
	[24057] = {["n"] = "Royal Nightseye",			["d"] = "Crafted, 1 Nightseye"},
	[24030] = {["n"] = "Runed Living Ruby",			["d"] = "Crafted, 1 Living Ruby"},
	[24055] = {["n"] = "Shifting Nightseye",		["d"] = "Crafted, 1 Nightseye"},
	[24048] = {["n"] = "Smooth Dawnstone",			["d"] = "Crafted, 1 Dawnstone"},
	[24033] = {["n"] = "Solid Star of Elune",		["d"] = "Crafted, 1 Star of Elune"},
	[24054] = {["n"] = "Sovereign Nightseye",		["d"] = "Crafted, 1 Nightseye"},
	[24035] = {["n"] = "Sparkling Star of Elune",		["d"] = "Crafted, 1 Star of Elune"},
	[24039] = {["n"] = "Stormy Star of Elune",		["d"] = "Crafted, 1 Star of Elune"},
	[24032] = {["n"] = "Subtle Living Ruby",		["d"] = "Crafted, 1 Living Ruby"},
	[24029] = {["n"] = "Teardrop Living Ruby",		["d"] = "Crafted, 1 Living Ruby"},
	[24052] = {["n"] = "Thick Dawnstone",			["d"] = "Crafted, 1 Dawnstone"},

	-- Crafted Rare Meta Gems
	[25897] = {["n"] = "Bracing Earthstorm Diamond",	["d"] = "Crafted, 1 Earthstorm Diamond"},
	[25899]	= {["n"] = "Brutal Earthstorm Diamond",		["d"] = "Crafted, 1 Earthstorm Diamond"},
	[25890] = {["n"] = "Destructive Skyfire Diamond",	["d"] = "Crafted, 1 Skyfire Diamond"},
	[25895] = {["n"] = "Enigmatic Skyfire Diamond",		["d"] = "Crafted, 1 Skyfire Diamond"},
	[25901]	= {["n"] = "Insightful Earthstorm Diamond",	["d"] = "Crafted, 1 Earthstorm Diamond"},
	[25893] = {["n"] = "Mystical Skyfire Diamond",		["d"] = "Crafted, 1 Skyfire Diamond"},
	[25896] = {["n"] = "Powerful Earthstorm Diamond",	["d"] = "Crafted, 1 Earthstorm Diamond"},
	[25894] = {["n"] = "Swift Skyfire Diamond",		["d"] = "Crafted, 1 Skyfire Diamond"},
	[25898]	= {["n"] = "Tenacious Earthstorm Diamond",	["d"] = "Crafted, 1 Earthstorm Diamond"},

	-- Enchanter Created
	[22460] = {["n"] = "Prismatic Sphere",		["d"] = "Enchanter Crafted, 4 Large Prismatic Shard"},
	[22459] = {["n"] = "Void Sphere",		["d"] = "Enchanter Crafted, 2 Void Crystal"},

	-- PvP Purchased Rare Meta Gems (Terrokar Spirit Towers)
	[28557] = {["n"] = "Swift Starfire Diamond",	["d"] = "Vendor, 8 Spirit Shard (Allerian Stronghold/Stonebreaker Hold)"},
	[28556] = {["n"] = "Swift Windfire Diamond",	["d"] = "Vendor, 8 Spirit Shard (Allerian Stronghold/Stonebreaker Hold)"},

	-- PvP Purchased Gems (Nagrand, Halaa)
	[27679]	= {["n"] = "Sublime Mystic Dawnstone",	["d"] = "Vendor, 100 Halaa Battle Token (Halaa, Nagrand)"},
	[30598] = {["n"] = "Don Amancio's Heart", 	["d"] = "Vendor, 14g 9s 72c (Limited Supply (1)) (Halaa, Nagrand)"},

	-- PvP Purchased Epic Gems (Honor Points)
	[28362] = {["n"] = "Bold Ornate Ruby",		["d"] = "Vendor, 8100 Honor (Champion's Hall/Hall of Legends)"},
	[28120] = {["n"] = "Gleaming Ornate Dawnstone",	["d"] = "Vendor, 8100 Honor (Champion's Hall/Hall of Legends)"},
	[28363] = {["n"] = "Inscribed Ornate Topaz",	["d"] = "Vendor, 10000 Honor (Champion's Hall/Hall of Legends)"},
	[28123] = {["n"] = "Potent Ornate Topaz",	["d"] = "Vendor, 10000 Honor (Champion's Hall/Hall of Legends)"},
	[28118] = {["n"] = "Runed Ornate Ruby",		["d"] = "Vendor, 8100 Honor (Champion's Hall/Hall of Legends)"},
	[28119] = {["n"] = "Smooth Ornate Dawnstone",	["d"] = "Vendor, 8100 Honor (Champion's Hall/Hall of Legends)"},

	-- PvP Puchased Rare Gems (Honor Hold/Thrallmar)
	-- Honor Hold itemIDs
	[27809] = {["n"] = "Barbed Deep Peridot", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},
	[28361] = {["n"] = "Mighty Blood Garnet", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},
	[27820] = {["n"] = "Notched Deep Peridot", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},
	[27812] = {["n"] = "Stark Blood Garnet", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},

	--Thrallmar duplicates, different itemIDs
	--[27786] = {["n"] = "Barbed Deep Peridot", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},
	--[28360] = {["n"] = "Mighty Blood Garnet", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},
	--[27785] = {["n"] = "Notched Deep Peridot", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},
	--[27777] = {["n"] = "Stark Blood Garnet", 	["d"] = "Vendor, 10 Mark of Honor Hold/Thrallmar (Hellfire Peninsula)"},

	-- Vendor Purchased (Common Gems)
	[28458] = {["n"] = "Bold Tourmaline", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28462] = {["n"] = "Bright Tourmaline", 	["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28466] = {["n"] = "Brilliant Amber", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28459] = {["n"] = "Delicate Tourmaline", 	["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28469] = {["n"] = "Gleaming Amber", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28465] = {["n"] = "Lustrous Zircon", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28468] = {["n"] = "Rigid Amber", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28461] = {["n"] = "Runed Tourmaline", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28467] = {["n"] = "Smooth Amber", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28463] = {["n"] = "Solid Zircon", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28464] = {["n"] = "Sparkling Zircon", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28460] = {["n"] = "Teardrop Tourmaline", 	["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},
	[28470] = {["n"] = "Thick Amber", 		["d"] = "Gem Vendor, 2g (Shattrath, Stormspire, Honor Hold, Thrallmar)"},

	-- Instance Epic Gem Drops
	[30565] = {["n"] = "Assassin's Fire Opal",	["d"] = "The Mechanar - Heroic"},
	[30601] = {["n"] = "Beaming Fire Opal",		["d"] = "The Blood Furnace - Heroic"},
	[30574] = {["n"] = "Brutal Tanzanite",		["d"] = "The Botanica - Heroic"},
	[30587] = {["n"] = "Champion's Fire Opal", 	["d"] = "Auchenai Crypts - Heroic"},
	[30566] = {["n"] = "Defender's Tanzanite",	["d"] = "The Mechanar - Heroic"},
	[30594] = {["n"] = "Effulgent Chrysoprase",	["d"] = "Hellfire Ramparts - Heroic"},
	[30584] = {["n"] = "Enscribed Fire Opal",	["d"] = "Mana-Tombs - Heroic"},
	[30559] = {["n"] = "Etched Fire Opal", 		["d"] = "Shadow Labyrinth - Heroic"},
	[30600] = {["n"] = "Fluorescent Tanzanite", 	["d"] = "The Blood Furnace - Heroic"},
	[30558] = {["n"] = "Glimmering Fire Opal",	["d"] = "The Black Morass - Heroic"},
	[30556] = {["n"] = "Glinting Fire Opal",	["d"] = "The Black Morass - Heroic"},
	[30585] = {["n"] = "Glistening Fire Opal",	["d"] = "Mana-Tombs - Heroic"},
	[30555]	= {["n"] = "Glowing Tanzanite",		["d"] = "The Black Morass - Heroic"},
	[31116] = {["n"] = "Infused Amethyst",		["d"] = "Quest Reward - Nightbane, Karazhan"},
	[30551] = {["n"] = "Infused Fire Opal",		["d"] = "The Steamvault - Heroic"},
	[30593] = {["n"] = "Iridescent Fire Opal",	["d"] = "Hellfire Ramparts - Heroic"},
	[30602] = {["n"] = "Jagged Chrysoprase",	["d"] = "The Blood Furnace - Heroic"},
	[30606] = {["n"] = "Lambent Chrysophrase",	["d"] = "The Underbog - Heroic"},
	[30547] = {["n"] = "Luminous Fire Opal",	["d"] = "The Shattered Halls - Heroic"},
	[30548] = {["n"] = "Polished Chrysoprase",	["d"] = "The Shattered Halls - Heroic"},
	[30553] = {["n"] = "Pristine Fire Opal",	["d"] = "Sethekk Halls - Heroic"},
	[31118] = {["n"] = "Pulsing Amethyst",		["d"] = "Quest Reward - Nightbane, Karazhan"},
	[30608] = {["n"] = "Radiant Chrysoprase",	["d"] = "The Underbog - Heroic"},
	[30563]	= {["n"] = "Regal Tanzanite",		["d"] = "Shadow Labyrinth - Heroic"},
	[30604] = {["n"] = "Resplendent Fire Opal",	["d"] = "The Slave Pens - Heroic"},
	[30603]	= {["n"] = "Royal Tanzanite",		["d"] = "The Slave Pens - Heroic"},
	[30586] = {["n"] = "Seer's Chrysoprase",	["d"] = "Auchenai Crypts - Heroic"},
	[30549] = {["n"] = "Shifting Tanzanite",	["d"] = "The Steamvault - Heroic"},
	[30564] = {["n"] = "Shining Fire Opal",		["d"] = "The Mechanar - Heroic Mode"},
	[31117] = {["n"] = "Soothing Amethyst",		["d"] = "Quest Reward - Nightbane, Karazhan"},
	[30546] = {["n"] = "Sovereign Tanzanite",	["d"] = "The Shattered Halls - Heroic"},
	[30607] = {["n"] = "Splendid Fire Opal",	["d"] = "The Underbog - Heroic"},
	[30554] = {["n"] = "Stalwart Fire Opal", 	["d"] = "Sethekk Halls - Heroic"},
	[30592] = {["n"] = "Steady Chrysoprase",	["d"] = "Hellfire Ramparts - Heroic"},
	[30550] = {["n"] = "Sundered Chrysoprase",	["d"] = "The Steamvault - Heroic"},
	[30583] = {["n"] = "Timeless Chrysoprase", 	["d"] = "Mana-Tombs - Heroic"},
	[30605] = {["n"] = "Vivid Chrysoprase", 	["d"] = "The Slave Pens - Heroic"},

	-- Added in Gem Helper v1.1
	[30552] = {["n"] = "Blessed Tanzanite",		["d"] = "Sethekk Halls - Heroic"},
	[30589] = {["n"] = "Dazzling Chrysoprase",	["d"] = "Old Hillsbrad Foothills - Heroic"},
	[30582] = {["n"] = "Deadly Fire Opal",		["d"] = "The Arcatraz - Heroic"},
	[30581] = {["n"] = "Durable Fire Opal",		["d"] = "The Arcatraz - Heroic"},
	[30591] = {["n"] = "Empowered Fire Opal",	["d"] = "Old Hillsbrad Foothills - Heroic"},
	[30590] = {["n"] = "Enduring Chrysoprase",	["d"] = "Old Hillsbrad Foothills - Heroic"},
	[30572] = {["n"] = "Imperial Tanzanite",	["d"] = "The Botanica - Heroic"},
	[30573] = {["n"] = "Mysterious Fire Opal",	["d"] = "The Botanica - Heroic"},
	[30575] = {["n"] = "Nimble Fire Opal",		["d"] = "The Arcatraz - Heroic"},
	[30588] = {["n"] = "Potent Fire Opal",		["d"] = "Auchenai Crypts - Heroic"},
	[30560] = {["n"] = "Rune Covered Chrysoprase",	["d"] = "Shadow Labyrinth - Heroic"},

	-- Added in Gem Helper v1.2 (patch 2.1.1)
	[31863] = {["n"] = "Balanced Nightseye",		["d"] = "Crafted, 1 Nightseye"},
	[31861] = {["n"] = "Great Dawnstone",			["d"] = "Crafted, 1 Dawnstone"},
	[31865] = {["n"] = "Infused Nightseye",			["d"] = "Crafted, 1 Nightseye"},
	[31867] = {["n"] = "Veiled Noble Topaz",		["d"] = "Crafted, 1 Noble Topaz"},
	[31868] = {["n"] = "Wicked Noble Topaz",		["d"] = "Crafted, 1 Noble Topaz"},
	[32836] = {["n"] = "Purified Shadow Pearl",		["d"] = "Crafted, 1 Shadow Pearl, 1 Purified Draenic Water"},
	[32833] = {["n"] = "Purified Jaggal Pearl",		["d"] = "Crafted, 1 Jaggal Pearl, 1 Purified Draenic Water"},
	[32409]	= {["n"] = "Relentless Earthstorm Diamond",	["d"] = "Crafted, 1 Earthstorm Diamond"},
	[32410] = {["n"] = "Thundering Skyfire Diamond",	["d"] = "Crafted, 1 Skyfire Diamond"},

	-- Added in Gem Helper v1.3 (patch 2.1.3)
	[24053] = {["n"] = "Mystic Dawnstone",		["d"] = "Crafted, 1 Dawnstone"},
	[32634] = {["n"] = "Unstable Amethyst",		["d"] = "Vendor, 40 Apexis Shard (Blade's Edge Mountains)"},
	[32635] = {["n"] = "Unstable Peridot",		["d"] = "Vendor, 40 Apexis Shard (Blade's Edge Mountains)"},
	[32636] = {["n"] = "Unstable Sapphire",		["d"] = "Vendor, 40 Apexis Shard (Blade's Edge Mountains)"},
	[32637] = {["n"] = "Unstable Citrine",		["d"] = "Vendor, 40 Apexis Shard (Blade's Edge Mountains)"},
	[32638] = {["n"] = "Unstable Topaz",		["d"] = "Vendor, 40 Apexis Shard (Blade's Edge Mountains)"},
	[32639] = {["n"] = "Unstable Talasite",		["d"] = "Vendor, 40 Apexis Shard (Blade's Edge Mountains)"},
	[32640] = {["n"] = "Potent Unstable Diamond",	["d"] = "Vendor, 160 Apexis Shard (Blade's Edge Mountains)"},
	[32641] = {["n"] = "Imbued Unstable Diamond",	["d"] = "Vendor, 160 Apexis Shard (Blade's Edge Mountains)"},

	-- Added in Gem Helper v1.3 (patch 2.1.3)
	-- The following gems are crafted from epic gem drops in Black Temple/Hyjal
	[32193] = {["n"] = "Bold Crimson Spinel",		["d"] = "Crafted, 1 Crimson Spinel"},
	[32194] = {["n"] = "Delicate Crimson Spinel",		["d"] = "Crafted, 1 Crimson Spinel"},
	[32195] = {["n"] = "Teardrop Crimson Spinel",		["d"] = "Crafted, 1 Crimson Spinel"},
	[32196] = {["n"] = "Runed Crimson Spinel",		["d"] = "Crafted, 1 Crimson Spinel"},
	[32197] = {["n"] = "Bright Crimson Spinel",		["d"] = "Crafted, 1 Crimson Spinel"},
	[32198] = {["n"] = "Subtle Crimson Spinel",		["d"] = "Crafted, 1 Crimson Spinel"},
	[32199] = {["n"] = "Flashing Crimson Spinel",		["d"] = "Crafted, 1 Crimson Spinel"},
	[32200] = {["n"] = "Solid Empyrean Sapphire",		["d"] = "Crafted, 1 Empyrean Sapphire"},
	[32201] = {["n"] = "Sparkling Empyrean Sapphire",	["d"] = "Crafted, 1 Empyrean Sapphire"},
	[32202] = {["n"] = "Lustrous Empyrean Sapphire",	["d"] = "Crafted, 1 Empyrean Sapphire"},
	[32203] = {["n"] = "Stormy Empyrean Sapphire",		["d"] = "Crafted, 1 Empyrean Sapphire"},
	[32204] = {["n"] = "Brilliant Lionseye",		["d"] = "Crafted, 1 Lionseye"},
	[32205] = {["n"] = "Smooth Lionseye",			["d"] = "Crafted, 1 Lionseye"},
	[32206] = {["n"] = "Rigid Lionseye",			["d"] = "Crafted, 1 Lionseye"},
	[32207] = {["n"] = "Gleaming Lionseye",			["d"] = "Crafted, 1 Lionseye"},
	[32208] = {["n"] = "Thick Lionseye",			["d"] = "Crafted, 1 Lionseye"},
	[32209] = {["n"] = "Mystic Lionseye",			["d"] = "Crafted, 1 Lionseye"},
	[32210] = {["n"] = "Great Lionseye",			["d"] = "Crafted, 1 Lionseye"},
	[32211] = {["n"] = "Sovereign Shadowsong Amethyst",	["d"] = "Crafted, 1 Shadowsong Amethyst"},
	[32212] = {["n"] = "Shifting Shadowsong Amethyst",	["d"] = "Crafted, 1 Shadowsong Amethyst"},
	[32213] = {["n"] = "Balanced Shadowsong Amethyst",	["d"] = "Crafted, 1 Shadowsong Amethyst"},
	[32214] = {["n"] = "Infused Shadowsong Amethyst",	["d"] = "Crafted, 1 Shadowsong Amethyst"},
	[32215] = {["n"] = "Glowing Shadowsong Amethyst",	["d"] = "Crafted, 1 Shadowsong Amethyst"},
	[32216] = {["n"] = "Royal Shadowsong Amethyst",		["d"] = "Crafted, 1 Shadowsong Amethyst"},
	[32217] = {["n"] = "Inscribed Pyrestone",		["d"] = "Crafted, 1 Pyrestone"},
	[32218] = {["n"] = "Potent Pyrestone",			["d"] = "Crafted, 1 Pyrestone"},
	[32219] = {["n"] = "Luminous Pyrestone",		["d"] = "Crafted, 1 Pyrestone"},
	[32220] = {["n"] = "Glinting Pyrestone",		["d"] = "Crafted, 1 Pyrestone"},
	[32221] = {["n"] = "Veiled Pyrestone",			["d"] = "Crafted, 1 Pyrestone"},
	[32222] = {["n"] = "Wicked Pyrestone",			["d"] = "Crafted, 1 Pyrestone"},
	[32223] = {["n"] = "Enduring Seaspray Emerald",		["d"] = "Crafted, 1 Seaspray Emerald"},
	[32224] = {["n"] = "Radiant Seaspray Emerald",		["d"] = "Crafted, 1 Seaspray Emerald"},
	[32225] = {["n"] = "Dazzling Seaspray Emerald",		["d"] = "Crafted, 1 Seaspray Emerald"},
	[32226] = {["n"] = "Jagged Seaspray Emerald",		["d"] = "Crafted, 1 Seaspray Emerald"},

	-- Added in Gem Helper v1.4 (patch 2.2.0)
	[33131] = {["n"] = "Crimson Sun",	["d"] = "Crafted, 1 Living Ruby"},
	[33133] = {["n"] = "Don Julio's Heart",	["d"] = "Crafted, 1 Living Ruby"},
	[33134] = {["n"] = "Kailee's Rose",	["d"] = "Crafted, 1 Living Ruby"},
	[33135] = {["n"] = "Falling Star",	["d"] = "Crafted, 1 Star of Elune"},
	[33140] = {["n"] = "Blood of Amber",	["d"] = "Crafted, 1 Dawnstone"},
	[33143] = {["n"] = "Stone of Blades",	["d"] = "Crafted, 1 Dawnstone"},
	[33144] = {["n"] = "Facet of Eternity",	["d"] = "Crafted, 1 Dawnstone"},
	[33782] = {["n"] = "Steady Talasite",	["d"] = "Crafted, 1 Talasite"},

	-- Added in Gem Helper v1.41 (patch 2.2.2)
	[31862] = {["n"] = "Balanced Shadow Draenite",		["d"] = "Crafted, 1 Shadow Draenite"},
	[31860] = {["n"] = "Great Golden Draenite",		["d"] = "Crafted, 1 Golden Draenite"},
	[31864] = {["n"] = "Infused Shadow Draenite",		["d"] = "Crafted, 1 Shadow Draenite"},
	[31866] = {["n"] = "Veiled Flame Spessarite",		["d"] = "Crafted, 1 Flame Spessarite"},
	[31869] = {["n"] = "Wicked Flame Spessarite",		["d"] = "Crafted, 1 Flame Spessarite"},

	-- Added in Gem Helper v1.5 (patch 2.3.0)
	[34220] = {["n"] = "Chaotic Skyfire Diamond",	["d"] = "Crafted, 1 Skyfire Diamond"},
	[34256] = {["n"] = "Charmed Amani Jewel",	["d"] = "Quest Reward - Zul'Aman"},
};
