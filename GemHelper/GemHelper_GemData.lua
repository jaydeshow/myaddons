---------------------------------------------------------
-- Refer to GEMHELPER_CHECKBUTTON_TEXT in the localization files for checkbox IDs


-- Base Item IDs for gem materials
-- Format: [Checkbox ID] = Gem itemID
GemHelper_MaterialGemID = {
	[21] = 23117,	-- Azure Moonstone
	[22] = 23077,	-- Blood Garnet
	[23] = 23112,	-- Golden Draenite
	[24] = 23079,	-- Deep Peridot
	[25] = 21929,	-- Flame Spessarite
	[26] = 23107,	-- Shadow Draenite
	[27] = 24478,	-- Jaggal Pearl
	[31] = 23438,	-- Star of Elune
	[32] = 23436,	-- Living Ruby
	[33] = 23440,	-- Dawnstone
	[34] = 23437,	-- Talasite
	[35] = 23439,	-- Noble Topaz
	[36] = 23441,	-- Nightseye
	[37] = 24479,	-- Shadow Pearl
	[41] = 25868,	-- Skyfire Diamond
	[42] = 25867,	-- Earthstorm Diamond
	[51] = 32228,	-- Empyrean Sapphire
	[52] = 32227,	-- Crimson Spinel
	[53] = 32229,	-- Lionseye
	[54] = 32249,	-- Seaspray Emerald
	[55] = 32231,	-- Pyrestone
	[56] = 32230,	-- Shadowsong Amethyst
};

-- Create reverse lookup table for speed
GemHelper_ReverseMaterialGemID = {};
for k, v in pairs(GemHelper_MaterialGemID) do
	GemHelper_ReverseMaterialGemID[v] = k;
end


-- Data for rarity, gemtype, colour, stats
-- Format: [Gem itemID] = gemTable
--   ["r"] = rarityID
--   [checkbox ID] = true (if the statistic is applicable)
GemHelper_GemData = {
	-- Crafted Uncommon Quality Gems
	[23095] = {["r"] = 2, [101] = true, [22] = true, [12] = true, [61] = true},				-- Bold Blood Garnet, red, 6 str
	[28595] = {["r"] = 2, [101] = true, [22] = true, [12] = true, [73] = true},				-- Bright Blood Garnet, red, 12 atk pwr
	[23113] = {["r"] = 2, [101] = true, [23] = true, [13] = true, [64] = true},				-- Brilliant Golden Draenite, yellow, 6 int
	[23106] = {["r"] = 2, [101] = true, [24] = true, [13] = true, [11] = true, [85] = true, [64] = true},	-- Dazzling Deep Peridot, yellow, blue, 1 mp5, 3 int
	[23097] = {["r"] = 2, [101] = true, [22] = true, [12] = true, [62] = true},				-- Delicate Blood Garnet, red, 6 agi
	[23105] = {["r"] = 2, [101] = true, [24] = true, [13] = true, [11] = true, [75] = true, [63] = true},	-- Enduring Deep Peridot, yellow, blue, 3 def, 4 stam
	[23114] = {["r"] = 2, [101] = true, [23] = true, [13] = true, [81] = true},				-- Gleaming Golden Draenite, yellow, 6 spellcrit
	[23100] = {["r"] = 2, [101] = true, [25] = true, [13] = true, [12] = true, [71] = true, [62] = true},	-- Glinting Flame Spessarite, yellow, red, 3 hit, 3 agi
	[23108] = {["r"] = 2, [101] = true, [26] = true, [12] = true, [11] = true, [83] = true, [63] = true},	-- Glowing Shadow Draenite, red, blue, 4 spelldmg, 4 stam
	[23098] = {["r"] = 2, [101] = true, [25] = true, [13] = true, [12] = true, [72] = true, [61] = true},	-- Inscribed Flame Spessarite, yellow, red, 3 crit, 3 str
	[23104] = {["r"] = 2, [101] = true, [24] = true, [13] = true, [11] = true, [72] = true, [63] = true},	-- Jagged Deep Peridot, yellow, blue, 3 crit, 4 stam
	[23099] = {["r"] = 2, [101] = true, [25] = true, [13] = true, [12] = true, [84] = true, [64] = true},	-- Luminous Flame Spessarite, yellow, red, 7 heal, 3 int
	[23121] = {["r"] = 2, [101] = true, [21] = true, [11] = true, [85] = true},				-- Lustrous Azure Moonstone, blue, 2 mp5
	[23101] = {["r"] = 2, [101] = true, [25] = true, [13] = true, [12] = true, [81] = true, [83] = true},	-- Potent Flame Spessarite, yellow, red, 3 spellcrit, 4 spelldmg
	[23103] = {["r"] = 2, [101] = true, [24] = true, [13] = true, [11] = true, [81] = true, [82] = true},	-- Radiant Deep Peridot, yellow, blue, 3 spellcrit, 4 spellpenet
	[23116] = {["r"] = 2, [101] = true, [23] = true, [13] = true, [71] = true},				-- Rigid Golden Draenite, yellow, 6 hit
	[23109] = {["r"] = 2, [101] = true, [26] = true, [12] = true, [11] = true, [84] = true, [85] = true},	-- Royal Shadow Draenite, red, blue, 7 heal, 1 mp5
	[23096] = {["r"] = 2, [101] = true, [22] = true, [12] = true, [83] = true},				-- Runed Blood Garnet, red, 7 spelldmg
	[23110] = {["r"] = 2, [101] = true, [26] = true, [12] = true, [11] = true, [62] = true, [63] = true},	-- Shifting Shadow Draenite, red, blue, 3 agi, 4 stam
	[28290] = {["r"] = 2, [101] = true, [23] = true, [13] = true, [72] = true},				-- Smooth Golden Draenite, yellow, 6 crit
	[23118] = {["r"] = 2, [101] = true, [21] = true, [11] = true, [63] = true},				-- Solid Azure Moonstone, blue, 9 stam
	[23111] = {["r"] = 2, [101] = true, [26] = true, [12] = true, [11] = true, [61] = true, [63] = true},	-- Sovereign Shadow Draenite, red, blue, 3 str, 4 stam
	[23119] = {["r"] = 2, [101] = true, [21] = true, [11] = true, [65] = true},				-- Sparkling Azure Moonstone, blue, 6 spi
	[23120] = {["r"] = 2, [101] = true, [21] = true, [11] = true, [82] = true},				-- Stormy Azure Moonstone, blue, 8 spellpenet
	[23094] = {["r"] = 2, [101] = true, [22] = true, [12] = true, [84] = true},				-- Teardrop Blood Garnet, red, 13 heal
	[23115] = {["r"] = 2, [101] = true, [23] = true, [13] = true, [75] = true},				-- Thick Golden Draenite, yellow, 6 def

	-- Crafted Rare Quality Gems
	[24027] = {["r"] = 3, [101] = true, [32] = true, [12] = true, [61] = true},				-- Bold Living Ruby, red, 8 str
	[24031] = {["r"] = 3, [101] = true, [32] = true, [12] = true, [73] = true},				-- Bright Living Ruby, red, 16 ap
	[24047] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [64] = true},				-- Brilliant Dawnstone, yellow, 8 int
	[24065] = {["r"] = 3, [101] = true, [34] = true, [13] = true, [11] = true, [85] = true, [64] = true},	-- Dazzling Talasite, yellow, blue, 4 int, 2 mp5
	[24028] = {["r"] = 3, [101] = true, [32] = true, [12] = true, [62] = true},				-- Delicate Living Ruby, red, 8 agi
	[24062] = {["r"] = 3, [101] = true, [34] = true, [13] = true, [11] = true, [75] = true, [63] = true},	-- Enduring Talasite, yellow, blue, 4 def, 6 stam
	[24036] = {["r"] = 3, [101] = true, [32] = true, [12] = true, [76] = true},				-- Flashing Living Ruby, red, 8 parry
	[24050] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [81] = true},				-- Gleaming Dawnstone, yellow, 8 spell crit
	[24061] = {["r"] = 3, [101] = true, [35] = true, [13] = true, [12] = true, [71] = true, [62] = true},	-- Glinting Noble Topaz, red, yellow, 4 hit, 4 agi
	[24056] = {["r"] = 3, [101] = true, [36] = true, [12] = true, [11] = true, [83] = true, [63] = true},	-- Glowing Nightseye, red, blue, 5 spelldmg, 6 stam
	[24058] = {["r"] = 3, [101] = true, [35] = true, [13] = true, [12] = true, [72] = true, [61] = true},	-- Inscribed Noble Topaz, red, yellow, 4 crit, 4 str
	[24067] = {["r"] = 3, [101] = true, [34] = true, [13] = true, [11] = true, [72] = true, [63] = true},	-- Jagged Talasite, yellow, blue, 4 crit, 6 stam
	[24060] = {["r"] = 3, [101] = true, [35] = true, [13] = true, [12] = true, [84] = true, [64] = true},	-- Luminous Noble Topaz, red, yellow, 9 heal, 4 int
	[24037] = {["r"] = 3, [101] = true, [31] = true, [11] = true, [85] = true},				-- Lustrous Star of Elune, blue, 3 mp5
	[24059] = {["r"] = 3, [101] = true, [35] = true, [13] = true, [12] = true, [81] = true, [83] = true},	-- Potent Noble Topaz, red, yellow, 4 spellcrit, 5 spelldmg
	[24066] = {["r"] = 3, [101] = true, [34] = true, [13] = true, [11] = true, [81] = true, [82] = true},	-- Radiant Talasite, blue, yellow, 4 spellcrit, 5 spellpenet
	[24051] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [71] = true},				-- Rigid Dawnstone, yellow, 8 hit
	[24057] = {["r"] = 3, [101] = true, [36] = true, [12] = true, [11] = true, [84] = true, [85] = true},	-- Royal Nightseye, red, blue, 9 heal, 2 mp5
	[24030] = {["r"] = 3, [101] = true, [32] = true, [12] = true, [83] = true},				-- Runed Living Ruby, red, 9 spelldmg
	[24055] = {["r"] = 3, [101] = true, [36] = true, [12] = true, [11] = true, [62] = true, [63] = true},	-- Shifting Nightseye, red, blue, 4 agi, 6 stam
	[24048] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [72] = true},				-- Smooth Dawnstone, yellow, 8 crit
	[24033] = {["r"] = 3, [101] = true, [31] = true, [11] = true, [63] = true},				-- Solid Star of Elune, blue, 12 stam
	[24054] = {["r"] = 3, [101] = true, [36] = true, [12] = true, [11] = true, [61] = true, [63] = true},	-- Sovereign Nightseye, red, blue, 4 str, 6 stam
	[24035] = {["r"] = 3, [101] = true, [31] = true, [11] = true, [65] = true},				-- Sparkling Star of Elune, blue, 8 spi
	[24039] = {["r"] = 3, [101] = true, [31] = true, [11] = true, [82] = true},				-- Stormy Star of Elune, blue, 10 spellpenet
	[24032] = {["r"] = 3, [101] = true, [32] = true, [12] = true, [74] = true},				-- Subtle Living Ruby, red, 8 dodge
	[24029] = {["r"] = 3, [101] = true, [32] = true, [12] = true, [84] = true},				-- Teardrop Living Ruby, red, 18 heal
	[24052] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [75] = true},				-- Thick Dawnstone, yellow, 8 def

	-- Crafted Rare Meta Gems
	[25897] = {["r"] = 3, [101] = true, [42] = true, [14] = true, [84] = true},				-- Bracing Earthstorm Diamond, meta, 26 healing, 2% reduced threat
	[25899]	= {["r"] = 3, [101] = true, [42] = true, [14] = true},						-- Brutal Earthstorm Diamond, meta, +3 melee damage, chance to stun target
	[25890] = {["r"] = 3, [101] = true, [41] = true, [14] = true, [81] = true}, 				-- Destructive Skyfire Diamond, meta, 14 spellcrit, 1% spellreflect
	[25895] = {["r"] = 3, [101] = true, [41] = true, [14] = true, [72] = true},				-- Enigmatic Skyfire Diamond, meta, 12 crit, 5% snare and root resist
	[25901]	= {["r"] = 3, [101] = true, [42] = true, [14] = true, [64] = true},				-- Insightful Earthstorm Diamond, meta, 12 int, chance to restore mana on spellcast
	[25893] = {["r"] = 3, [101] = true, [41] = true, [14] = true},		 				-- Mystical Skyfire Diamond, meta, 2% on spellcast - next spell instant cast
	[25896] = {["r"] = 3, [101] = true, [42] = true, [14] = true, [63] = true},				-- Powerful Earthstorm Diamond, meta, 18 stam, 5% stun resist
	[25894] = {["r"] = 3, [101] = true, [41] = true, [14] = true, [73] = true},				-- Swift Skyfire Diamond, 24 atk power, minor run speed increase
	[25898]	= {["r"] = 3, [101] = true, [42] = true, [14] = true, [75] = true},				-- Tenacious Earthstorm Diamond, meta, 12 def, chance to restore health on hit

	-- Enchanter Created
	[22460] = {["r"] = 3, [102] = true, [11] = true, [12] = true, [13] = true, [86] = true},		-- Prismatic Sphere, red, yellow, blue, 3 resist all
	[22459] = {["r"] = 4, [102] = true, [11] = true, [12] = true, [13] = true, [86] = true},		-- Void Sphere, red, yellow, blue, 4 resist all

	-- PvP Purchased Rare Meta Gems (Terrokar Spirit Towers)
	[28557] = {["r"] = 3, [103] = true, [14] = true, [83] = true},						-- Swift Starfire Diamond, meta, 12 spelldmg, minor run speed increase
	[28556] = {["r"] = 3, [103] = true, [14] = true, [73] = true},						-- Swift Windfire Diamond, meta, 20 atk power, minor run speed increase

	-- PvP Purchased Gems (Nagrand, Halaa)
	[27679]	= {["r"] = 4, [103] = true, [13] = true, [66] = true},						-- Sublime Mystic Dawnstone, yellow, 10 resilience
	[30598] = {["r"] = 3, [103] = true, [12] = true, [61] = true},						-- Don Amancio's Heart, red, 8 str

	-- PvP Purchased Epic Gems (Honor Points)
	[28362] = {["r"] = 4, [103] = true, [12] = true, [73] = true},						-- Bold Ornate Ruby, red, 20 atk power
	[28120] = {["r"] = 4, [103] = true, [13] = true, [81] = true},						-- Gleaming Ornate Dawnstone, yellow, 10 spellcrit
	[28363] = {["r"] = 4, [103] = true, [12] = true, [13] = true, [73] = true, [72] = true},		-- Inscribed Ornate Topaz, red, yellow, 10 atk power, 5 crit
	[28123] = {["r"] = 4, [103] = true, [12] = true, [13] = true, [83] = true, [81] = true},		-- Potent Ornate Topaz, red, yellow, 6 spelldmg, 5 spellcrit
	[28118] = {["r"] = 4, [103] = true, [12] = true, [83] = true},						-- Runed Ornate Ruby, red, 12 spelldmg
	[28119] = {["r"] = 4, [103] = true, [13] = true, [72] = true},						-- Smooth Ornate Dawnstone, yellow, 10 crit

	-- PvP Puchased Rare Gems (Honor Hold/Thrallmar)
	-- Honor Hold itemIDs
	[27809] = {["r"] = 3, [103] = true, [13] = true, [11] = true, [63] = true, [72] = true},		-- Barbed Deep Peridot, yellow, blue, 3 stam, 4 crit
	[28361] = {["r"] = 3, [103] = true, [12] = true, [73] = true},						-- Mighty Blood Garnet, red, 14 atk power
	[27820] = {["r"] = 3, [103] = true, [13] = true, [11] = true, [63] = true, [81] = true},		-- Notched Deep Peridot, yellow, blue, 3 stam, 4 spellcrit
	[27812] = {["r"] = 3, [103] = true, [12] = true, [83] = true},						-- Stark Blood Garnet, red, 8 spelldmg

	--Thrallmar duplicates, different itemIDs
	--[27786] = {["r"] = 3, [103] = true, [13] = true, [11] = true, [63] = true, [72] = true},		-- Barbed Deep Peridot, yellow, blue, 3 stam, 4 crit
	--[28360] = {["r"] = 3, [103] = true, [12] = true, [73] = true},					-- Mighty Blood Garnet, red, 14 atk power
	--[27785] = {["r"] = 3, [103] = true, [13] = true, [11] = true, [63] = true, [81] = true},		-- Notched Deep Peridot, yellow, blue, 3 stam, 4 spellcrit
	--[27777] = {["r"] = 3, [103] = true, [12] = true, [83] = true},					-- Stark Blood Garnet, red, 8 spelldmg

	-- Vendor Purchased (Common Gems)
	[28458] = {["r"] = 1, [103] = true, [12] = true, [61] = true},						-- Bold Tourmaline, red, 4 str
	[28462] = {["r"] = 1, [103] = true, [12] = true, [73] = true},						-- Bright Tourmaline, red, 8 atk power
	[28466] = {["r"] = 1, [103] = true, [13] = true, [64] = true},						-- Brilliant Amber, yellow, 4 int
	[28459] = {["r"] = 1, [103] = true, [12] = true, [62] = true},						-- Delicate Tourmaline, red, 4 agi
	[28469] = {["r"] = 1, [103] = true, [13] = true, [81] = true},						-- Gleaming Amber, yellow, 4 spellcrit
	[28465] = {["r"] = 1, [103] = true, [11] = true, [85] = true},						-- Lustrous Zircon, blue, 1 mp5
	[28468] = {["r"] = 1, [103] = true, [13] = true, [71] = true},						-- Rigid Amber, yellow, 4 hit
	[28461] = {["r"] = 1, [103] = true, [12] = true, [83] = true},						-- Runed Tourmaline, red, 5 spelldmg
	[28467] = {["r"] = 1, [103] = true, [13] = true, [72] = true},						-- Smooth Amber, yellow, 4 crit
	[28463] = {["r"] = 1, [103] = true, [11] = true, [63] = true},						-- Solid Zircon, blue, 6 stam
	[28464] = {["r"] = 1, [103] = true, [11] = true, [65] = true},						-- Sparkling Zircon, blue, 4 spi
	[28460] = {["r"] = 1, [103] = true, [12] = true, [84] = true},						-- Teardrop Tourmaline, red, 9 heal
	[28470] = {["r"] = 1, [103] = true, [13] = true, [75] = true},						-- Thick Amber, yellow, 4 def

	-- Instance Epic Gem Drops
	[30565] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [72] = true, [74] = true},		-- Assassin's Fire Opal, red, yellow, 6 crit, 5 dodge
	[30601] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [74] = true, [66] = true},		-- Beaming Fire Opal, red, yellow, 5 dodge, 4 resilience
	[30574] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [73] = true, [63] = true},		-- Brutal Tanzanite, red, blue, 10 atk power, 6 stam
	[30587] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [61] = true, [75] = true},		-- Champion's Fire Opal, red, yellow, 5 str, 4 def
	[30566] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [76] = true, [63] = true},		-- Defender's Tanzanite, red, blue, 5 parry, 6 stam
	[30594] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [75] = true, [85] = true},		-- Effulgent Chrysoprase, yellow, blue, 5 def, 2 mp5
	[30584] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [61] = true, [72] = true},		-- Enscribed Fire Opal, red, yellow, 5 str, 4 crit
	[30559] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [61] = true, [71] = true},		-- Etched Fire Opal, red, yellow, 5 str, 4 hit
	[30600] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [83] = true, [65] = true},		-- Fluorescent Tanzanite, red, blue, 6 spelldmg, 4 spi
	[30558] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [76] = true, [75] = true},		-- Glimmering Fire Opal, red, yellow, 5 parry, 4 def
	[30556] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [62] = true, [71] = true},		-- Glinting Fire Opal, red, yellow, 5 agi, 4 hit
	[30585] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [62] = true, [75] = true},		-- Glistening Fire Opal, red, yellow, 4 agi, 5 def
	[30555]	= {["r"] = 4, [104] = true, [12] = true, [11] = true, [83] = true, [63] = true},		-- Glowing Tanzanite, red, blue, 6 spelldmg, 6 stam
	[31116] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [83] = true, [63] = true},		-- Infused Amethyst, red, blue, 6 spelldmg, 6 stam
	[30551] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [83] = true, [64] = true},		-- Infused Fire Opal, red, yellow, 6 spelldmg, 4 int
	[30593] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [84] = true, [81] = true},		-- Iridescent Fire Opal, red, yellow, 11 heal, 4 spellcrit
	[30602] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [63] = true, [72] = true},		-- Jagged Chrysoprase, yellow, blue, 6 stam, 5 crit
	[30606] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [80] = true, [85] = true},		-- Lambent Chrysophrase, yellow, blue, 5 spellhit, 2 mp5
	[30547] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [84] = true, [64] = true},		-- Luminous Fire Opal, red, yellow, 11 heal, 4 int
	[30548] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [63] = true, [81] = true},		-- Polished Chrysoprase, yellow, blue, 6 stam, 5 spellcrit
	[30553] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [73] = true, [71] = true},		-- Pristine Fire Opal, red, yellow, 10 atk power, 4 hit
	[31118] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [73] = true, [63] = true},		-- Pulsing Amethyst, red, blue, 10 atk power, 6 stam
	[30608] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [81] = true, [82] = true},		-- Radiant Chrysoprase, yellow, blue, 5 spellcrit, 5 spellpenet
	[30563]	= {["r"] = 4, [104] = true, [12] = true, [11] = true, [74] = true, [63] = true},		-- Regal Tanzanite, red, blue, 5 dodge, 6 stam
	[30604] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [61] = true, [66] = true},		-- Resplendent Fire Opal, red, yellow, 5 str, 4 resilience
	[30603]	= {["r"] = 4, [104] = true, [12] = true, [11] = true, [84] = true, [85] = true},		-- Royal Tanzanite, red, blue, 11 heal, 2 mp5
	[30586] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [64] = true, [65] = true},		-- Seer's Chrysoprase, yellow, blue, 4 int, 5 spi
	[30549] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [61] = true, [62] = true},		-- Shifting Tanzanite, red, blue, 5 str, 4 agi
	[30564] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [83] = true, [80] = true},		-- Shining Fire Opal, red, yellow, 6 spelldmg, 5 spellhit
	[31117] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [84] = true, [63] = true},		-- Soothing Amethyst, red, blue, 11 heal, 6 stam
	[30546]	= {["r"] = 4, [104] = true, [12] = true, [11] = true, [61] = true, [63]	= true},		-- Sovereign Tanzanite, red, blue, 5 str, 6 stam
	[30607] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [76] = true, [66] = true},		-- Splendid Fire Opal, red, yellow, 5 parry, 4 resilience
	[30554] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [75] = true, [74] = true},		-- Stalwart Fire Opal, red, yellow, 5 def, 4 dodge
	[30592] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [63] = true, [66] = true},		-- Steady Chrysoprase, yellow, blue, 6 stam, 5 resilience
	[30550] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [72] = true, [85] = true},		-- Sundered Chrysoprase, yellow, blue, 5 crit, 2 mp5
	[30583] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [64] = true, [63] = true},		-- Timeless Chrysoprase, yellow, blue, 5 int, 6 stam
	[30605] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [80] = true, [63] = true},		-- Vivid Chrysoprase, yellow, blue, 5 spellhit, 6 stam

	-- Added in Gem Helper v1.1
	[30552] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [84] = true, [63] = true},		-- Blessed Tanzanite, red, blue, 11 heal, 6 stam
	[30589] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [64] = true, [85] = true},		-- Dazzling Chrysoprase, yellow, blue, 5 int, 2 mp5
	[30582] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [73] = true, [72] = true},		-- Deadly Fire Opal, red, yellow, 8 atk power, 5 crit
	[30581] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [84] = true, [66] = true},		-- Durable Fire Opal, red, yellow, 11 heal, 4 resilience
	[30591] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [73] = true, [66] = true},		-- Empowered Fire Opal, red, yellow, 8 atk power, 5 resilience
	[30590] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [63] = true, [75] = true},		-- Enduring Chrysoprase, yellow, blue, 6 stam, 5 def
	[30572] = {["r"] = 4, [104] = true, [12] = true, [11] = true, [65] = true, [84] = true},		-- Imperial Tanzanite, red, blue, 5 spi, 9 heal
	[30573] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [83] = true, [82] = true},		-- Mysterious Fire Opal, red, yellow, 6 spelldmg, 5 spellpenet
	[30575] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [74] = true, [71] = true},		-- Nimble Fire Opal, red, yellow, 5 dodge, 4 hit
	[30588] = {["r"] = 4, [104] = true, [12] = true, [13] = true, [83] = true, [81] = true},		-- Potent Fire Opal, red, yellow, 6 spelldmg, 4 spellcrit
	[30560] = {["r"] = 4, [104] = true, [13] = true, [11] = true, [81] = true, [85] = true},		-- Rune Covered Chrysoprase, yellow, blue, 5 spellcrit, 2 mp5

	-- Added in Gem Helper v1.2 (patch 2.1.1)
	[31863] = {["r"] = 3, [101] = true, [36] = true, [12] = true, [11] = true, [73] = true, [63] = true},	-- Balanced Nightseye, red, blue, 8 atk power, 6 stam
	[31861] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [80] = true},				-- Great Dawnstone, yellow, 8 spellhit
	[31865] = {["r"] = 3, [101] = true, [36] = true, [12] = true, [11] = true, [73] = true, [85] = true},	-- Infused Nightseye, red, blue, 8 atk power, 2 mp5
	[31867] = {["r"] = 3, [101] = true, [35] = true, [13] = true, [12] = true, [80] = true, [83] = true},	-- Veiled Noble Topaz, red, yellow, 4 spellhit, 6 spelldmg
	[31868] = {["r"] = 3, [101] = true, [35] = true, [13] = true, [12] = true, [72] = true, [73] = true},	-- Wicked Noble Topaz, red, yellow, 4 crit, 8 atk power
	[32836] = {["r"] = 3, [101] = true, [37] = true, [12] = true, [11] = true, [84] = true, [65] = true},	-- Purified Shadow Pearl, red, blue, 9 heal, 4 spi
	[32833] = {["r"] = 2, [101] = true, [27] = true, [12] = true, [11] = true, [84] = true, [65] = true},	-- Purified Jaggal Pearl, red, blue, 7 heal, 3 spi
	[32409] = {["r"] = 3, [101] = true, [42] = true, [14] = true, [62] = true},				-- Relentless Earthstorm Diamond, meta, 12 agi, 3% increased critical damage
	[32410] = {["r"] = 3, [101] = true, [41] = true, [14] = true},						-- Thundering Skyfire Diamond, meta, Chance to increase melee/ranged attack speed

	-- Added in Gem Helper v1.3 (patch 2.1.3)
	[24053] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [66] = true},			-- Mystic Dawnstone, yellow, 8 res
	[32634] = {["r"] = 3, [103] = true, [12] = true, [11] = true, [73] = true, [63] = true},	-- Unstable Amethyst, red, blue, 8 atk power, 6 stam
	[32635] = {["r"] = 3, [103] = true, [13] = true, [11] = true, [64] = true, [63] = true},	-- Unstable Peridot, yellow, blue, 4 int, 6 stam
	[32636] = {["r"] = 3, [103] = true, [12] = true, [11] = true, [84] = true, [65] = true},	-- Unstable Sapphire, red, blue, 9 heal, 4 spi
	[32637] = {["r"] = 3, [103] = true, [12] = true, [13] = true, [73] = true, [72] = true},	-- Unstable Citrine, red, yellow, 8 atk power, 4 crit
	[32638] = {["r"] = 3, [103] = true, [12] = true, [13] = true, [83] = true, [64] = true},	-- Unstable Topaz, red, yellow, 5 spelldmg, 4 int
	[32639] = {["r"] = 3, [103] = true, [11] = true, [13] = true, [63] = true, [81] = true},	-- Unstable Talasite, blue, yellow, 4 stam, 4 spellcrit
	[32640] = {["r"] = 3, [103] = true, [14] = true, [73] = true},					-- Potent Unstable Diamond, meta, 24 atk power, 5% stun resist
	[32641] = {["r"] = 3, [103] = true, [14] = true, [83] = true},					-- Imbued Unstable Diamond, meta, 14 spelldmg, 5% stun resist

	-- Added in Gem Helper v1.3 (patch 2.1.3)
	-- The following gems are crafted from epic gem drops in Black Temple/Hyjal
	[32193] = {["r"] = 4, [101] = true, [52] = true, [12] = true, [61] = true},				-- Bold Crimson Spinel, red, 10 str
	[32194] = {["r"] = 4, [101] = true, [52] = true, [12] = true, [62] = true},				-- Delicate Crimson Spinel, red, 10 agi
	[32195] = {["r"] = 4, [101] = true, [52] = true, [12] = true, [84] = true},				-- Teardrop Crimson Spinel, red, 22 heal
	[32196] = {["r"] = 4, [101] = true, [52] = true, [12] = true, [83] = true},				-- Runed Crimson Spinel, red, 12 spelldmg
	[32197] = {["r"] = 4, [101] = true, [52] = true, [12] = true, [73] = true},				-- Bright Crimson Spinel, red, 20 atk power
	[32198] = {["r"] = 4, [101] = true, [52] = true, [12] = true, [74] = true},				-- Subtle Crimson Spinel, red, 10 dodge
	[32199] = {["r"] = 4, [101] = true, [52] = true, [12] = true, [76] = true},				-- Flashing Crimson Spinel, red, 10 parry
	[32200] = {["r"] = 4, [101] = true, [51] = true, [11] = true, [63] = true},				-- Solid Empyrean Sapphire, blue, 15 stam
	[32201] = {["r"] = 4, [101] = true, [51] = true, [11] = true, [65] = true},				-- Sparkling Empyrean Sapphire, blue, 10 spi
	[32202] = {["r"] = 4, [101] = true, [51] = true, [11] = true, [85] = true},				-- Lustrous Empyrean Sapphire, blue, 4 mp5
	[32203] = {["r"] = 4, [101] = true, [51] = true, [11] = true, [82] = true},				-- Stormy Empyrean Sapphire, blue, 13 spellpene
	[32204] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [64] = true},				-- Brilliant Lionseye, yellow, 10 int
	[32205] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [72] = true},				-- Smooth Lionseye, yellow, 10 crit
	[32206] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [71] = true},				-- Rigid Lionseye, yellow, 10 hit
	[32207] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [81] = true},				-- Gleaming Lionseye, yellow, 10 spellcrit
	[32208] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [75] = true},				-- Thick Lionseye, yellow, 10 def
	[32209] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [66] = true},				-- Mystic Lionseye, yellow, 10 res
	[32210] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [80] = true},				-- Great Lionseye, yellow, 10 spellhit
	[32211] = {["r"] = 4, [101] = true, [56] = true, [12] = true, [11] = true, [61] = true, [63] = true},	-- Sovereign Shadowsong Amethyst, red, blue, 5 str, 7 stam
	[32212] = {["r"] = 4, [101] = true, [56] = true, [12] = true, [11] = true, [62] = true, [63] = true},	-- Shifting Shadowsong Amethyst, red, blue, 5 agi, 7 stam
	[32213] = {["r"] = 4, [101] = true, [56] = true, [12] = true, [11] = true, [73] = true, [63] = true},	-- Balanced Shadowsong Amethyst, red, blue, 10 atk power, 7 stam
	[32214] = {["r"] = 4, [101] = true, [56] = true, [12] = true, [11] = true, [73] = true, [85] = true},	-- Infused Shadowsong Amethyst, red, blue, 10 atk power, 2 mp5
	[32215] = {["r"] = 4, [101] = true, [56] = true, [12] = true, [11] = true, [83] = true, [63] = true},	-- Glowing Shadowsong Amethyst, red, blue, 6 spelldmg, 7 stam
	[32216] = {["r"] = 4, [101] = true, [56] = true, [12] = true, [11] = true, [84] = true, [85] = true},	-- Royal Shadowsong Amethyst, red, blue, 11 heal, 2 mp5
	[32217] = {["r"] = 4, [101] = true, [55] = true, [12] = true, [13] = true, [72] = true, [61] = true},	-- Inscribed Pyrestone, red, yellow, 5 crit, 5 str
	[32218] = {["r"] = 4, [101] = true, [55] = true, [12] = true, [13] = true, [81] = true, [83] = true},	-- Potent Pyrestone, red, yellow, 5 spellcrit, 6 spelldmg
	[32219] = {["r"] = 4, [101] = true, [55] = true, [12] = true, [13] = true, [84] = true, [64] = true},	-- Luminous Pyrestone, red, yellow, 11 heal, 5 int
	[32220] = {["r"] = 4, [101] = true, [55] = true, [12] = true, [13] = true, [71] = true, [62] = true},	-- Glinting Pyrestone, red, yellow, 5 hit, 5 agi
	[32221] = {["r"] = 4, [101] = true, [55] = true, [12] = true, [13] = true, [80] = true, [83] = true},	-- Veiled Pyrestone, red, yellow, 5 spellhit, 6 spelldmg
	[32222] = {["r"] = 4, [101] = true, [55] = true, [12] = true, [13] = true, [72] = true, [73] = true},	-- Wicked Pyrestone, red, yellow, 5 crit, 10 atk power
	[32223] = {["r"] = 4, [101] = true, [54] = true, [11] = true, [13] = true, [75] = true, [63] = true},	-- Enduring Seaspray Emerald, blue, yellow, 5 def, 7 stam
	[32224] = {["r"] = 4, [101] = true, [54] = true, [11] = true, [13] = true, [81] = true, [82] = true},	-- Radiant Seaspray Emerald, blue, yellow, 5 spellcrit, 6 spellpene
	[32225] = {["r"] = 4, [101] = true, [54] = true, [11] = true, [13] = true, [64] = true, [85] = true},	-- Dazzling Seaspray Emerald, blue, yellow, 5 int, 2 mp5
	[32226] = {["r"] = 4, [101] = true, [54] = true, [11] = true, [13] = true, [72] = true, [63] = true},	-- Jagged Seaspray Emerald, blue, yellow, 5 crit, 7 stam

	-- Added in Gem Helper v1.4 (patch 2.2.0)
	[33131] = {["r"] = 4, [101] = true, [32] = true, [12] = true, [73] = true},				-- Crimson Sun, red, 24 ap
	[33133] = {["r"] = 4, [101] = true, [32] = true, [12] = true, [83] = true},				-- Don Julio's Heart, red, 14 spelldmg
	[33134] = {["r"] = 4, [101] = true, [32] = true, [12] = true, [84] = true},				-- Kailee's Rose, red, 26 heal
	[33135] = {["r"] = 4, [101] = true, [31] = true, [11] = true, [63] = true},				-- Falling Star, blue, 18 sta
	[33140] = {["r"] = 4, [101] = true, [33] = true, [13] = true, [81] = true},				-- Blood of Ember, yellow, 12 spellcrit
	[33143] = {["r"] = 4, [101] = true, [33] = true, [13] = true, [72] = true},				-- Stone of Blades, yellow, 12 crit
	[33144] = {["r"] = 4, [101] = true, [33] = true, [13] = true, [75] = true},				-- Facet of Eternity, yellow, 12 def
	[33782] = {["r"] = 3, [101] = true, [34] = true, [13] = true, [11] = true, [66] = true, [63] = true},	-- Steady Talasite, yellow, blue, 4 res, 6 stam

	-- Added in Gem Helper v1.41 (patch 2.2.2)
	[31862] = {["r"] = 2, [101] = true, [26] = true, [12] = true, [11] = true, [73] = true, [63] = true},	-- Balanced Shadow Draenite, red, blue, 6 atk power, 4 stam
	[31860] = {["r"] = 2, [101] = true, [23] = true, [13] = true, [80] = true},				-- Great Golden Draenite, yellow, 6 spellhit
	[31864] = {["r"] = 2, [101] = true, [26] = true, [12] = true, [11] = true, [73] = true, [85] = true},	-- Infused Shadow Draenite, red, blue, 6 atk power, 1 mp5
	[31866] = {["r"] = 2, [101] = true, [25] = true, [13] = true, [12] = true, [80] = true, [83] = true},	-- Veiled Flame Spessarite, red, yellow, 3 spellhit, 4 spelldmg
	[31869] = {["r"] = 2, [101] = true, [25] = true, [13] = true, [12] = true, [72] = true, [73] = true},	-- Wicked Flame Spessarite, red, yellow, 3 crit, 6 atk power

	-- Added in Gem Helper v1.5 (patch 2.3.0)
	[34220] = {["r"] = 3, [101] = true, [41] = true, [14] = true, [81] = true},	-- Chaotic Skyfire Diamond, meta, +12 spellcrit, +3% spell crit damage
	[34256] = {["r"] = 4, [104] = true, [11] = true, [63] = true},			-- Charmed Amani Jewel, blue, 15 stam

	-- Added in Gem Helper v1.6 (patch 2.4.0)
	[35503] = {["r"] = 3, [101] = true, [41] = true, [14] = true, [83] = true, [64] = true},	-- Ember Skyfire Diamond, meta, +14 spelldmg, +2% int
	[35501] = {["r"] = 3, [101] = true, [42] = true, [14] = true, [75] = true},	-- Eternal Earthstorm Diamond, meta, +12 def, +10% shieldblock
	[35707] = {["r"] = 3, [101] = true, [36] = true, [12] = true, [11] = true, [74] = true, [63] = true},	-- Regal Nightseye, red, blue, 4 dodge, 6 stam
	[34831] = {["r"] = 3, [104] = true, [11] = true, [63] = true},				-- Eye of the Sea, blue, 15 stam
	[35758] = {["r"] = 4, [101] = true, [54] = true, [11] = true, [13] = true, [66] = true, [63] = true},	-- Steady Seaspray Emerald, blue, yellow, 5 res, 7 stam
	[35759] = {["r"] = 4, [101] = true, [54] = true, [11] = true, [13] = true, [70] = true, [63] = true},	-- Forceful Seaspray Emerald, blue, yellow, 5 spellhaste, 7 stam
	[35760] = {["r"] = 4, [101] = true, [55] = true, [12] = true, [13] = true, [70] = true, [83] = true},	-- Reckless Pyrestone, red, yellow, 5 spellhaste, 6 spelldmg
	[35761] = {["r"] = 4, [101] = true, [53] = true, [13] = true, [70] = true},				-- Quick Lionseye, yellow, 10 spellhaste

	-- Added in Gem Helper v1.7 (patch 2.4.2)
	[37503] = {["r"] = 4, [101] = true, [56] = true, [12] = true, [11] = true, [84] = true, [65] = true},	-- Purified Shadowsong Amethyst, red, blue, 11 heal, 5 spi
	[35315] = {["r"] = 3, [101] = true, [33] = true, [13] = true, [70] = true},				-- Quick Dawnstone, yellow, 8 spellhaste
	[35316] = {["r"] = 3, [101] = true, [35] = true, [13] = true, [12] = true, [70] = true, [83] = true},	-- Reckless Noble Topaz, red, yellow, 4 spellhaste, 5 spelldmg
	[35318] = {["r"] = 3, [101] = true, [34] = true, [13] = true, [11] = true, [70] = true, [63] = true},	-- Forceful Talasite, yellow, blue, 4 spellhaste, 6 stam

	--[[
	The following epic quality gems exist in game (you can sniff their itemIDs), but nobody knows how to obtain the recipes to craft them.
	[33132]-- Delicate Fire Ruby, red, 12 agi
	[33136]-- Nothing
	[33137]-- Sparkling Falling Star, blue, 12 spi
	[33138]-- Mystic Bladestone, yellow, 12 res
	[33139]-- Brilliant Bladestone, yellow, 12 int
	[33141]-- Great Bladestone, yellow, 12 spellhit
	[33142]-- Rigid Bladestone, yellow, 12 hit
	]]
};
