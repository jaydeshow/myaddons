--[[
	Below are constants needed for DB storage and retrieval
	The core of gathermate handles adding new node that collector finds
	data shared between Collector and Display also live in GatherMate for sharing like zone_data for sizes, and node ids with reverses for display and comparison
	Credit to Astrolabe (http://www.gathereraddon.com) for lookup tables used in GatherMate. Astrolabe is licensed LGPL
]]
local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate")
local NL = LibStub("AceLocale-3.0"):GetLocale("GatherMateNodes",true)

--[[
	Zone data for heigth, width, and gathermate ID
]]
local zone_data = { -- {width, height, zoneID}
	Arathi = {3599.78645678886,2399.85763785924,1,},
	Ogrimmar = {1402.563051365538,935.042034243692,2,},
	--EasternKingdoms = {37649.15159852673,25099.43439901782,3,},
	Undercity = {959.3140238076666,639.5426825384444,4,},
	Barrens = {10132.98626357964,6755.32417571976,5,},
	Darnassis = {1058.300884213672,705.5339228091146,6,},
	AzuremystIsle = {4070.691916244019, 2713.794610829346,7,},
	UngoroCrater = {3699.872808671186,2466.581872447457,8,},
	BurningSteppes = {2928.988452241535,1952.658968161023,9,},
	Wetlands = {4135.166184805389,2756.777456536926,10,},
	Winterspring = {7099.756078049357,4733.170718699571,11,},
	Dustwallow = {5249.824712249077,3499.883141499384,12,},
	Darkshore = {6549.780280774227,4366.520187182819,13,},
	LochModan = {2758.158752877019,1838.772501918013,14,},
	BladesEdgeMountains = {5424.84803598309,3616.56535732206,15,},
	Durotar = {5287.285801274457,3524.857200849638,16,},
	Silithus = {3483.224287356748,2322.149524904499,17,},
	ShattrathCity = {1306.210386847456,870.8069245649707,18,},
	Ashenvale = {5766.471113365881,3844.314075577254,19,},
	--Azeroth = {44531.82907938571,29687.8860529238,20,},
	Nagrand = {5524.827295176373,3683.218196784248,21,},
	TerokkarForest = {5399.832305361811,3599.888203574541,22,},
	EversongWoods = {4924.70470173181,3283.136467821207,23,},
	SilvermoonCity = {1211.384457945605,807.5896386304033,24,},
	Tanaris = {6899.765399158026,4599.843599438685,25,},
	Stormwind = {1344.138055148283,896.092036765522,26,},
	SwampOfSorrows = {2293.606089974149,1529.070726649433,27,},
	EasternPlaguelands = {3870.596078314358,2580.397385542905,28,},
	BlastedLands = {3349.808966078055,2233.20597738537,29,},
	Elwynn = {3470.62593362794,2313.750622418627,30,},
	DeadwindPass = {2499.848163715574,1666.565442477049,31,},
	DunMorogh = {4924.664537147015,3283.109691431343,32,},
	TheExodar = {1056.732317707213,704.4882118048087,33,},
	Felwood = {5749.8046476606,3833.2030984404,34,},
	Silverpine = {4199.739879721531,2799.826586481021,35,},
	ThunderBluff = {1043.762849319158,695.8418995461053,36,},
	Hinterlands = {3849.77134323942,2566.51422882628,37,},
	StonetalonMountains = {4883.173287670144,3255.448858446763,38,},
	Mulgore = {5137.32138887616,3424.88092591744,39,},
	Hellfire = {5164.421615455519,3442.947743637013,40,},
	Ironforge = {790.5745810546713,527.0497207031142,41,},
	ThousandNeedles = {4399.86408093722,2933.242720624814,42,},
	Stranglethorn = {6380.866711475876,4253.911140983918,43,},
	Badlands = {2487.343589680943,1658.229059787295,44,},
	Teldrassil = {5091.467863261982,3394.311908841321,45,},
	Moonglade = {2308.253559286662,1538.835706191108,46,},
	ShadowmoonValley = {5499.827432644566,3666.551621763044,47,},
	Tirisfal = {4518.469744413802,3012.313162942535,48,},
	Aszhara = {5070.669448432522,3380.446298955014,49,},
	Redridge = {2170.704876735185,1447.136584490123,50,},
	BloodmystIsle = {3262.385067990556,2174.92337866037,51,},
	WesternPlaguelands = {4299.7374000546,2866.4916000364,52,},
	Alterac = {2799.820894040741,1866.547262693827,53,},
	Westfall = {3499.786489780177,2333.190993186784,54,},
	Duskwood = {2699.837284973949,1799.891523315966,55,},
	Netherstorm = {5574.82788866266,3716.551925775107,56,},
	Ghostlands = {3299.755735439147,2199.837156959431,57,},
	Zangarmarsh = {5026.925554043871,3351.283702695914,58,},
	Desolace = {4495.726850591814,2997.151233727876,59,},
	--Kalimdor = {36798.56388065484,24532.37592043656,60,},
	SearingGorge = {2231.119799153945,1487.413199435963,61,},
	--Expansion01 = {17463.5328406368,11642.3552270912,62,},
	Feralas = {6949.760203962193,4633.173469308129,63,},
	Hilsbrad = {3199.802496078764,2133.201664052509,64,},
	Sunwell = {3327.0830078125,2218.7490234375,65,},
	-- Wrath Zones
	--[[ These valus derived from the dbc client files, they may change and/or are not final
	UtgardeKeep = {0.0,0.0},
	Nexus = {0.0,0.0},
	Dalaran = {0.0,0.0},
	--]]	
	Northrend = {17751.3984375,11834.2650146484,66,},
	BoreanTundra = {5764.5830088,3843.749878,67,},
	Dragonblight = {5608.33312988281,3739.58337402344,68,},
	GrizzlyHills = {5249.999878,3499.999878,69,},
	HowlingFjord = {6045.83288574219,4031.24981689453,70,},
	IcecrownGlacier = {5199.99967193604,3466.666015625,71,},
	SholazarBasin = {4356.25,2904.166504,72,},
	TheStormPeaks = {7112.49963378906,4741.666015625,73,},
	ZulDrak = {4993.75,3329.166504,74,},
	LakeWintergrasp = {3166.666382,2110.416748,75,},
	ScarletEnclave = {3162.5,2108.333374,76,},
	CrystalsongForest = {2722.91662597656,1814.5830078125,77,},
	LakeWintergrasp = {2974.99987792969,1983.33325195312,78,},
	StrandoftheAncients = {2339.58325195312,1560.41668701172,79,},
}
-- meta table to return 0 for all unknown zones, instances, and what not
local emptyZoneTbl = {0,0,0}
setmetatable(zone_data, { __index = function(t, k) ChatFrame1:AddMessage("GatherMate is missing data for "..k); return emptyZoneTbl end })


-- empty continents include -1 for the universe, and 0 for eastern kingdoms (meta continents so to speak)
local emptyCont = {}
local continentList = setmetatable({ GetMapContinents() }, {__index = function() return emptyCont end})
local zoneList = setmetatable({}, { __index = function() return emptyZoneTbl end})
for continent in pairs(continentList) do
	local zones = { GetMapZones(continent) }
	continentList[continent] = zones
	for zone, name in pairs(zones) do
		SetMapZoom(continent, zone)
		-- Temporary fix, the map "ScarletEnclave" and "EasternPlaguelands"
		-- both have the same English display name as "Eastern Plaguelands"
		-- so we ignore the new Death Knight starting zone for now.
		if GetMapInfo() ~= "ScarletEnclave" then
			zoneList[name] = zone_data[GetMapInfo()]
		end
	end
end

GatherMate.zoneData = zoneList
GatherMate.continentData = continentList
zone_data = nil
--[[
	Node Identifiers
]]
local node_ids = {
	["Fishing"] = {
		[NL["Floating Wreckage"]] 				= 101, -- treasure.tga
		[NL["Patch of Elemental Water"]] 		= 102, -- purewater.tga
		[NL["Floating Debris"]] 				= 103, -- debris.tga
		[NL["Oil Spill"]] 						= 104, -- oilspill.tga
		[NL["Firefin Snapper School"]] 			= 105, -- firefin.tga
		[NL["Greater Sagefish School"]] 		= 106, -- greatersagefish.tga
		[NL["Oily Blackmouth School"]] 			= 107, -- oilyblackmouth.tga
		[NL["Sagefish School"]] 				= 108, -- sagefish.tga
		[NL["School of Deviate Fish"]] 			= 109, -- firefin.tga
		[NL["Stonescale Eel Swarm"]] 			= 110, -- eel.tga
		--[NL["Muddy Churning Water"]] 			= 111, -- ZG only fishing node
		[NL["Highland Mixed School"]] 			= 112, -- fishhook.tga 
		[NL["Pure Water"]] 						= 113, -- purewater.tga           
		[NL["Bluefish School"]] 				= 114, -- bluefish,tga
		--[NL["Feltail School"]] 					= 115, -- feltail.tga
		[NL["Brackish Mixed School"]]         	= 115, -- feltail.tga
		[NL["Mudfish School"]] 					= 116, -- mudfish.tga
		[NL["School of Darter"]] 				= 117, -- darter.tga
		[NL["Sporefish School"]] 				= 118, -- sporefish.tga
		[NL["Steam Pump Flotsam"]] 				= 119, -- steampump.tga
		[NL["School of Tastyfish"]] 			= 120, -- net.tga
	},
	["Mining"] = {
		[NL["Copper Vein"]] 					= 201,
		[NL["Tin Vein"]] 						= 202,
		[NL["Iron Deposit"]] 					= 203,
		[NL["Silver Vein"]] 					= 204,
		[NL["Gold Vein"]] 						= 205,
		[NL["Mithril Deposit"]] 				= 206,
		[NL["Ooze Covered Mithril Deposit"]]	= 207,
		[NL["Truesilver Deposit"]] 				= 208,
		[NL["Ooze Covered Silver Vein"]] 		= 209,
		[NL["Ooze Covered Gold Vein"]] 			= 210,
		[NL["Ooze Covered Truesilver Deposit"]] = 211,
		[NL["Ooze Covered Rich Thorium Vein"]] 	= 212,
		[NL["Ooze Covered Thorium Vein"]] 		= 213,
		[NL["Small Thorium Vein"]] 				= 214,
		[NL["Rich Thorium Vein"]] 				= 215,
		--[NL["Hakkari Thorium Vein"]] 			= 216, -- found on in ZG
		[NL["Dark Iron Deposit"]] 				= 217,
		[NL["Lesser Bloodstone Deposit"]] 		= 218,
		[NL["Incendicite Mineral Vein"]] 		= 219,
		[NL["Indurium Mineral Vein"]]			= 220,
		[NL["Fel Iron Deposit"]] 				= 221,
		[NL["Adamantite Deposit"]] 				= 222,
		[NL["Rich Adamantite Deposit"]] 		= 223,
		[NL["Khorium Vein"]] 					= 224,
		--[NL["Large Obsidian Chunk"]] 			= 225, -- found only in AQ20/40
		--[NL["Small Obsidian Chunk"]] 			= 226, -- found only in AQ20/40
		[NL["Nethercite Deposit"]] 				= 227,
		-- Wrath place holders
		[NL["Cobalt Node"]]						= 228,
		[NL["Rich Cobalt Node"]]				= 229,
		[NL["Titanium Node"]]					= 230,
		[NL["Saronite Node"]]					= 231,
		[NL["Rich Saronite Node"]]				= 232,
	},
	["Extract Gas"] = {
		[NL["Windy Cloud"]] 					= 301,
		[NL["Swamp Gas"]] 						= 302,
		[NL["Arcane Vortex"]] 					= 303,
		[NL["Felmist"]] 						= 304,
	},
	["Herb Gathering"] = {
		[NL["Peacebloom"]] 						= 401,
		[NL["Silverleaf"]] 						= 402,
		[NL["Earthroot"]] 						= 403,
		[NL["Mageroyal"]] 						= 404,
		[NL["Briarthorn"]] 						= 405,
		--[NL["Swiftthistle"]] 					= 406, -- found it briathorn nodes
		[NL["Stranglekelp"]] 					= 407,
		[NL["Bruiseweed"]] 						= 408,
		[NL["Wild Steelbloom"]] 				= 409,
		[NL["Grave Moss"]] 						= 410,
		[NL["Kingsblood"]] 						= 411,
		[NL["Liferoot"]] 						= 412,
		[NL["Fadeleaf"]] 						= 413,
		[NL["Goldthorn"]] 						= 414,
		[NL["Khadgar's Whisker"]] 				= 415,
		[NL["Wintersbite"]] 					= 416,
		[NL["Firebloom"]] 						= 417,
		[NL["Purple Lotus"]] 					= 418,
		--[NL["Wildvine"]] 						= 419, -- found in purple lotus nodes
		[NL["Arthas' Tears"]] 					= 420,
		[NL["Sungrass"]] 						= 421,
		[NL["Blindweed"]] 						= 422,
		[NL["Ghost Mushroom"]] 					= 423,
		[NL["Gromsblood"]] 						= 424,
		[NL["Golden Sansam"]] 					= 425,
		[NL["Dreamfoil"]] 						= 426,
		[NL["Mountain Silversage"]] 			= 427,
		[NL["Plaguebloom"]] 					= 428,
		[NL["Icecap"]] 							= 429,
		--[NL["Bloodvine"]] 					= 430, -- zg bush loot
		[NL["Black Lotus"]] 					= 431,
		[NL["Felweed"]] 						= 432,
		[NL["Dreaming Glory"]] 					= 433,
		[NL["Terocone"]] 						= 434,
		--[NL["Ancient Lichen"]] 				= 435, -- instance only node
		[NL["Bloodthistle"]] 					= 436,
		[NL["Mana Thistle"]] 					= 437,
		[NL["Netherbloom"]] 					= 438,
		[NL["Nightmare Vine"]] 					= 439,
		[NL["Ragveil"]] 						= 440,
		[NL["Flame Cap"]] 						= 441,
		[NL["Netherdust Bush"]] 				= 442,
		-- Wrath herbs
		[NL["Adder's Tongue"]]					= 443,
		[NL["Constrictor Grass"]]				= 444,
		[NL["Deadnettle"]]						= 445,
		[NL["Goldclover"]]						= 446,
		[NL["Icethorn"]]						= 447,
		[NL["Lickbloom"]]						= 448,
		[NL["Talandra's Rose"]]					= 449,
		[NL["Tiger Lily"]]						= 450,
	},
	["Treasure"] = {
		[NL["Giant Clam"]] 						= 501,
		[NL["Battered Chest"]] 					= 502,
		[NL["Tattered Chest"]] 					= 503,
		[NL["Solid Chest"]] 					= 504,
		[NL["Large Iron Bound Chest"]] 			= 505,
		[NL["Large Solid Chest"]] 				= 506,
		[NL["Large Battered Chest"]]			= 507,
		[NL["Buccaneer's Strongbox"]] 			= 508,
		[NL["Large Mithril Bound Chest"]] 		= 509,
		[NL["Large Darkwood Chest"]] 			= 510,
		[NL["Un'Goro Dirt Pile"]] 				= 511,
		[NL["Bloodpetal Sprout"]] 				= 512,
		[NL["Blood of Heroes"]] 				= 513,
		[NL["Practice Lockbox"]] 				= 514,
		[NL["Battered Footlocker"]] 			= 515,
		[NL["Waterlogged Footlocker"]] 			= 516,
		[NL["Dented Footlocker"]] 				= 517,
		[NL["Mossy Footlocker"]] 				= 518,
		[NL["Scarlet Footlocker"]] 				= 519,
		[NL["Burial Chest"]] 					= 520,
		[NL["Fel Iron Chest"]] 					= 521,
		[NL["Heavy Fel Iron Chest"]] 			= 522,
		[NL["Adamantite Bound Chest"]] 			= 523,
		[NL["Felsteel Chest"]] 					= 524,
		[NL["Glowcap"]] 						= 525,
		[NL["Wicker Chest"]] 					= 526,
		[NL["Primitive Chest"]] 				= 527,
		[NL["Solid Fel Iron Chest"]] 			= 528,
		[NL["Bound Fel Iron Chest"]] 			= 529,
		--[NL["Bound Adamantite Chest"]] 		= 530, -- instance only node
		[NL["Netherwing Egg"]] 					= 531,
	},
}
GatherMate.nodeIDs = node_ids
local reverse = {}
for k,v in pairs(node_ids) do
	reverse[k] = GatherMate:CreateReversedTable(v)
end
GatherMate.reverseNodeIDs = reverse
--[[
	Collector data for rare spawn determination
]]
local Collector = GatherMate:GetModule("Collector")
--[[
	Rare spawns are formatted as such the rareid = [nodes it replaces]
]]
local rare_spawns = {
	[204] = {[202]=true,[203]=true}, -- silver
	[205] = {[203]=true,[206]=true}, -- gold
	[208] = {[206]=true,[214]=true,[215]=true}, -- truesilver
	[209] = {[212]=true,[213]=true,[207]=true}, -- oozed covered silver
	[210] = {[212]=true,[213]=true,[207]=true}, -- ooze covered gold
	[211] = {[212]=true,[213]=true,[207]=true}, -- oozed covered true silver
	[217] = {[206]=true,[214]=true,[215]=true}, -- dark iron
	[224] = {[222]=true,[223]=true,[221]=true}, -- khorium
	[223] = {[222]=true}, -- rich adamantite
	[441] = {[440]=true} --flame cap
}
Collector.rareNodes = rare_spawns

--[[
	Below are Display Module Constants
]]
local Display = GatherMate:GetModule("Display")
local icon_path = "Interface\\AddOns\\GatherMate\\Artwork\\"
Display.trackingCircle = icon_path.."track_circle.tga"

local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate")

Display:SetSkillTracking("Mining", "Interface\\Icons\\Spell_Nature_Earthquake")
Display:SetSkillTracking("Herb Gathering", "Interface\\Icons\\INV_Misc_Flower_02")
Display:SetSkillTracking("Fishing", "Interface\\Icons\\INV_Misc_Fish_02")
Display:SetSkillTracking("Treasure", "Interface\\Icons\\Racial_Dwarf_FindTreasure")

Display:SetSkillProfession("Herb Gathering", L["Herbalism"])
Display:SetSkillProfession("Mining", L["Mining"])
Display:SetSkillProfession("Fishing", L["Fishing"])
Display:SetSkillProfession("Extract Gas", L["Engineering"])
--[[
	Textures for display
]]
local node_textures = {
	["Fishing"] = {
		[101] = icon_path.."Fish\\treasure.tga",
		[102] = icon_path.."Fish\\purewater.tga",
		[103] = icon_path.."Fish\\debris.tga",
		[104] = icon_path.."Fish\\oilspill.tga",
		[105] = icon_path.."Fish\\firefin.tga",
		[106] = icon_path.."Fish\\greater_sagefish.tga",
		[107] = icon_path.."Fish\\oilyblackmouth.tga",
		[108] = icon_path.."Fish\\sagefish.tga",
		[109] = icon_path.."Fish\\firefin.tga",
		[110] = icon_path.."Fish\\eel.tga",
		[111] = icon_path.."Fish\\net.tga",
		[112] = icon_path.."Fish\\fish_hook.tga",
		[113] = icon_path.."Fish\\purewater.tga",
		[114] = icon_path.."Fish\\bluefish.tga",
		[115] = icon_path.."Fish\\feltail.tga",
		[116] = icon_path.."Fish\\mudfish.tga",
		[117] = icon_path.."Fish\\darter.tga",
		[118] = icon_path.."Fish\\sporefish.tga",
		[119] = icon_path.."Fish\\steampump.tga",
		[120] = icon_path.."Fish\\net.tga",
	},
	["Mining"] = {
		[201] = icon_path.."Mine\\copper.tga",
		[202] = icon_path.."Mine\\tin.tga",
		[203] = icon_path.."Mine\\iron.tga",
		[204] = icon_path.."Mine\\silver.tga",
		[205] = icon_path.."Mine\\gold.tga",
		[206] = icon_path.."Mine\\mithril.tga",
		[207] = icon_path.."Mine\\mithril.tga",
		[208] = icon_path.."Mine\\truesilver.tga",
		[209] = icon_path.."Mine\\silver.tga",
		[210] = icon_path.."Mine\\gold.tga",
		[211] = icon_path.."Mine\\truesilver.tga",
		[212] = icon_path.."Mine\\rich_thorium.tga",
		[213] = icon_path.."Mine\\thorium.tga",
		[214] = icon_path.."Mine\\thorium.tga",
		[215] = icon_path.."Mine\\rich_thorium.tga",
		[216] = icon_path.."Mine\\rich_thorium.tga",
		[217] = icon_path.."Mine\\darkiron.tga",
		[218] = icon_path.."Mine\\blood_iron.tga",
		[219] = icon_path.."Mine\\darkiron.tga",
		[220] = icon_path.."Mine\\blood_iron.tga",
		[221] = icon_path.."Mine\\feliron.tga",
		[222] = icon_path.."Mine\\adamantium.tga",
		[223] = icon_path.."Mine\\rich_adamantium.tga",
		[224] = icon_path.."Mine\\khorium.tga",
		[225] = icon_path.."Mine\\ethernium.tga",
		[226] = icon_path.."Mine\\ethernium.tga",
		[227] = icon_path.."Mine\\ethernium.tga",
		-- place holder graphic
		[228] = icon_path.."Mine\\ethernium.tga",
		[229] = icon_path.."Mine\\ethernium.tga",
		[230] = icon_path.."Mine\\ethernium.tga",
		[231] = icon_path.."Mine\\ethernium.tga",
		[232] = icon_path.."Mine\\ethernium.tga",
	},
	["Extract Gas"] = {
		[301] = icon_path.."Gas\\windy_cloud.tga",
		[302] = icon_path.."Gas\\swamp_gas.tga",
		[303] = icon_path.."Gas\\arcane_vortex.tga",
		[304] = icon_path.."Gas\\felmist.tga",
	},
	["Herb Gathering"] = {
		[401] = icon_path.."Herb\\peacebloom.tga",
		[402] = icon_path.."Herb\\silverleaf.tga",
		[403] = icon_path.."Herb\\earthroot.tga",
		[404] = icon_path.."Herb\\mageroyal.tga",
		[405] = icon_path.."Herb\\briarthorn.tga",
		[406] = icon_path.."Herb\\earthroot.tga",
		[407] = icon_path.."Herb\\stranglekelp.tga",
		[408] = icon_path.."Herb\\bruiseweed.tga",
		[409] = icon_path.."Herb\\wild_steelbloom.tga",
		[410] = icon_path.."Herb\\grave_moss.tga",
		[411] = icon_path.."Herb\\kingsblood.tga",
		[412] = icon_path.."Herb\\liferoot.tga",
		[413] = icon_path.."Herb\\fadeleaf.tga",
		[414] = icon_path.."Herb\\goldthorn.tga",
		[415] = icon_path.."Herb\\khadgars_whisker.tga",
		[416] = icon_path.."Herb\\wintersbite.tga",
		[417] = icon_path.."Herb\\firebloom.tga",
		[418] = icon_path.."Herb\\purple_lotus.tga",
		[419] = icon_path.."Herb\\purple_lotus.tga",
		[420] = icon_path.."Herb\\arthas_tears.tga",
		[421] = icon_path.."Herb\\sungrass.tga",
		[422] = icon_path.."Herb\\blindweed.tga",
		[423] = icon_path.."Herb\\ghost_mushroom.tga",
		[424] = icon_path.."Herb\\gromsblood.tga",
		[425] = icon_path.."Herb\\golden_sansam.tga",
		[426] = icon_path.."Herb\\dreamfoil.tga",
		[427] = icon_path.."Herb\\mountain_silversage.tga",
		[428] = icon_path.."Herb\\plaguebloom.tga",
		[429] = icon_path.."Herb\\icecap.tga",
		[430] = icon_path.."Herb\\purple_lotus.tga",
		[431] = icon_path.."Herb\\black_lotus.tga",
		[432] = icon_path.."Herb\\felweed.tga",
		[433] = icon_path.."Herb\\dreaming_glory.tga",
		[434] = icon_path.."Herb\\terocone.tga",
		[435] = icon_path.."Herb\\ancient_lichen.tga",
		[436] = icon_path.."Herb\\stranglekelp.tga",
		[437] = icon_path.."Herb\\mana_thistle.tga",
		[438] = icon_path.."Herb\\netherbloom.tga",
		[439] = icon_path.."Herb\\nightmare_vine.tga",
		[440] = icon_path.."Herb\\ragveil.tga",
		[441] = icon_path.."Herb\\flame_cap.tga",
		[442] = icon_path.."Herb\\netherdust.tga",
		-- place holder graphic
		[443] = icon_path.."Herb\\felweed.tga",
		[444] = icon_path.."Herb\\felweed.tga",
		[445] = icon_path.."Herb\\felweed.tga",
		[446] = icon_path.."Herb\\felweed.tga",
		[447] = icon_path.."Herb\\felweed.tga",
		[448] = icon_path.."Herb\\felweed.tga",
		[449] = icon_path.."Herb\\felweed.tga",
		[450] = icon_path.."Herb\\felweed.tga",
	},
	["Treasure"] = {
		[501] = icon_path.."Treasure\\clam.tga",
		[502] = icon_path.."Treasure\\chest.tga",
		[503] = icon_path.."Treasure\\chest.tga",
		[504] = icon_path.."Treasure\\chest.tga",
		[505] = icon_path.."Treasure\\chest.tga",
		[506] = icon_path.."Treasure\\chest.tga",
		[507] = icon_path.."Treasure\\hest.tga",
		[508] = icon_path.."Treasure\\chest.tga",
		[509] = icon_path.."Treasure\\chest.tga",
		[510] = icon_path.."Treasure\\chest.tga",
		[511] = icon_path.."Treasure\\soil.tga",
		[512] = icon_path.."Treasure\\sprout.tga",
		[513] = icon_path.."Treasure\\blood.tga",
		[514] = icon_path.."Treasure\\footlocker.tga",
		[515] = icon_path.."Treasure\\footlocker.tga",
		[516] = icon_path.."Treasure\\footlocker.tga",
		[517] = icon_path.."Treasure\\footlocker.tga",
		[518] = icon_path.."Treasure\\footlocker.tga",
		[519] = icon_path.."Treasure\\footlocker.tga",
		[520] = icon_path.."Treasure\\chest.tga",
		[521] = icon_path.."Treasure\\treasure.tga",
		[522] = icon_path.."Treasure\\treasure.tga",
		[523] = icon_path.."Treasure\\treasure.tga",
		[524] = icon_path.."Treasure\\treasure.tga",
		[525] = icon_path.."Treasure\\mushroom.tga",
		[526] = icon_path.."Treasure\\treasure.tga",
		[527] = icon_path.."Treasure\\treasure.tga",
		[528] = icon_path.."Treasure\\tresure.tga",
		[529] = icon_path.."Treasure\\treasure.tga",
		[530] = icon_path.."Treasure\\treasure.tga",
		[531] = icon_path.."Treasure\\egg.tga",		
	},
}
GatherMate.nodeTextures = node_textures
--[[
	Minimap scale settings for zoom
]]
local minimap_size = {
	indoor = {
		[0] = 300, -- scale
		[1] = 240, -- 1.25
		[2] = 180, -- 5/3
		[3] = 120, -- 2.5
		[4] = 80,  -- 3.75
		[5] = 50,  -- 6
	},
	outdoor = {
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}
Display.minimapSize = minimap_size
--[[
	Minimap shapes lookup table to determine round of not
	borrowed from strolobe for faster lookups
]]
local minimap_shapes = {
	-- { upper-left, lower-left, upper-right, lower-right }
	["SQUARE"]                = { false, false, false, false },
	["CORNER-TOPLEFT"]        = { true,  false, false, false },
	["CORNER-TOPRIGHT"]       = { false, false, true,  false },
	["CORNER-BOTTOMLEFT"]     = { false, true,  false, false },
	["CORNER-BOTTOMRIGHT"]    = { false, false, false, true },
	["SIDE-LEFT"]             = { true,  true,  false, false },
	["SIDE-RIGHT"]            = { false, false, true,  true },
	["SIDE-TOP"]              = { true,  false, true,  false },
	["SIDE-BOTTOM"]           = { false, true,  false, true },
	["TRICORNER-TOPLEFT"]     = { true,  true,  true,  false },
	["TRICORNER-TOPRIGHT"]    = { true,  false, true,  true },
	["TRICORNER-BOTTOMLEFT"]  = { true,  true,  false, true },
	["TRICORNER-BOTTOMRIGHT"] = { false, true,  true,  true },
}
Display.minimapShapes = minimap_shapes