--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 - 2008 Dan Gilbert
	Email me at loglow@gmail.com

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

Atlas_DropDownLayouts_Order = {
	[1] = ATLAS_DDL_CONTINENT;
	[2] = ATLAS_DDL_LEVEL;
	[3] = ATLAS_DDL_PARTYSIZE;
	[4] = ATLAS_DDL_EXPANSION;
	[5] = ATLAS_DDL_TYPE;
	[ATLAS_DDL_CONTINENT] = {
		[1] = ATLAS_DDL_CONTINENT_EASTERN;
		[2] = ATLAS_DDL_CONTINENT_KALIMDOR;
		[3] = ATLAS_DDL_CONTINENT_OUTLAND;
	};
	[ATLAS_DDL_LEVEL] = {
		[1] = ATLAS_DDL_LEVEL_UNDER45;
		[2] = ATLAS_DDL_LEVEL_45TO60;
		[3] = ATLAS_DDL_LEVEL_60TO70;
		[4] = ATLAS_DDL_LEVEL_70PLUS;
	};
	[ATLAS_DDL_PARTYSIZE] = {
		[1] = ATLAS_DDL_PARTYSIZE_5;
		[2] = ATLAS_DDL_PARTYSIZE_10;
		[3] = ATLAS_DDL_PARTYSIZE_20TO40;
	};
	[ATLAS_DDL_EXPANSION] = {
		[1] = ATLAS_DDL_EXPANSION_OLD_AO;
		[2] = ATLAS_DDL_EXPANSION_OLD_PZ;
		[3] = ATLAS_DDL_EXPANSION_BC;
	};
	[ATLAS_DDL_TYPE] = {
		[1] = ATLAS_DDL_TYPE_INSTANCE_AK;
		[2] = ATLAS_DDL_TYPE_INSTANCE_MZ;
		[3] = ATLAS_DDL_TYPE_ENTRANCE;
	};
};

Atlas_DropDownLayouts = {
	[ATLAS_DDL_CONTINENT] = {
		[ATLAS_DDL_CONTINENT_EASTERN] = {
			"BlackrockDepths",
			"BlackrockSpireEnt",
			"BlackrockSpireLower",
			"BlackrockSpireUpper",
			"BlackwingLair",
			"Gnomeregan",
			"GnomereganEnt",
			"KarazhanEnd",
			"KarazhanEnt",
			"KarazhanStart",
			"MagistersTerrace",
			"MoltenCore",
			"Naxxramas",
			"Scholomance",
			"ShadowfangKeep",
			"SMArmory",
			"SMCathedral",
			"SMEnt",
			"SMGraveyard",
			"SMLibrary",
			"Stratholme",
			"SunwellPlateau",
			"TheDeadmines",
			"TheDeadminesEnt",
			"TheStockade",
			"TheSunkenTemple",
			"TheSunkenTempleEnt",
			"Uldaman",
			"UldamanEnt",
			"ZulAman",
			"ZulGurub",
		},
		[ATLAS_DDL_CONTINENT_KALIMDOR] = {
			"BlackfathomDeeps",
			"BlackfathomDeepsEnt",
			"CoTBlackMorass",
			"CoTEnt",
			"CoTHyjal",
			"CoTOldHillsbrad",
			"DireMaulEast",
			"DireMaulEnt",
			"DireMaulNorth",
			"DireMaulWest",
			"Maraudon",
			"MaraudonEnt",
			"OnyxiasLair",
			"RagefireChasm",
			"RazorfenDowns",
			"RazorfenKraul",
			"TheRuinsofAhnQiraj",
			"TheTempleofAhnQiraj",
			"WailingCaverns",
			"WailingCavernsEnt",
			"ZulFarrak",
		},
		[ATLAS_DDL_CONTINENT_OUTLAND] = {
			"AuchAuchenaiCrypts",
			"AuchindounEnt",
			"AuchManaTombs",
			"AuchSethekkHalls",
			"AuchShadowLabyrinth",
			"BlackTempleBasement",
			"BlackTempleStart",
			"BlackTempleTop",
			"CFRSerpentshrineCavern",
			"CFRTheSlavePens",
			"CFRTheSteamvault",
			"CFRTheUnderbog",
			"CoilfangReservoirEnt",
			"GruulsLair",
			"HCBloodFurnace",
			"HCHellfireRamparts",
			"HCMagtheridonsLair",
			"HCTheShatteredHalls",
			"TempestKeepArcatraz",
			"TempestKeepBotanica",
			"TempestKeepMechanar",
			"TempestKeepTheEye",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_UNDER45] = {
			"BlackfathomDeeps",
			"BlackfathomDeepsEnt",
			"Gnomeregan",
			"GnomereganEnt",
			"RagefireChasm",
			"RazorfenDowns",
			"RazorfenKraul",
			"ShadowfangKeep",
			"SMArmory",
			"SMCathedral",
			"SMEnt",
			"SMGraveyard",
			"SMLibrary",
			"TheDeadmines",
			"TheDeadminesEnt",
			"TheStockade",
			"Uldaman",
			"UldamanEnt",
			"WailingCaverns",
			"WailingCavernsEnt",
		},
		[ATLAS_DDL_LEVEL_45TO60] = {
			"BlackrockDepths",
			"BlackrockSpireEnt",
			"BlackrockSpireLower",
			"BlackrockSpireUpper",
			"DireMaulEast",
			"DireMaulEnt",
			"DireMaulNorth",
			"DireMaulWest",
			"Maraudon",
			"MaraudonEnt",
			"Scholomance",
			"Stratholme",
			"TheSunkenTemple",
			"TheSunkenTempleEnt",
			"ZulFarrak",
		},
		[ATLAS_DDL_LEVEL_60TO70] = {
			"AuchAuchenaiCrypts",
			"AuchindounEnt",
			"AuchManaTombs",
			"AuchSethekkHalls",
			"AuchShadowLabyrinth",
			"BlackrockSpireEnt",
			"BlackwingLair",
			"CFRTheSlavePens",
			"CFRTheSteamvault",
			"CFRTheUnderbog",
			"CoilfangReservoirEnt",
			"CoTBlackMorass",
			"CoTEnt",
			"CoTOldHillsbrad",
			"HCBloodFurnace",
			"HCHellfireRamparts",
			"HCTheShatteredHalls",
			"MoltenCore",
			"Naxxramas",
			"OnyxiasLair",
			"TempestKeepArcatraz",
			"TempestKeepBotanica",
			"TempestKeepMechanar",
			"TheRuinsofAhnQiraj",
			"TheTempleofAhnQiraj",
			"ZulGurub",
		},
		[ATLAS_DDL_LEVEL_70PLUS] = {
			"BlackTempleBasement",
			"BlackTempleStart",
			"BlackTempleTop",
			"CFRSerpentshrineCavern",
			"CoTEnt",
			"CoTHyjal",
			"GruulsLair",
			"HCMagtheridonsLair",
			"KarazhanEnd",
			"KarazhanEnt",
			"KarazhanStart",
			"MagistersTerrace",
			"SunwellPlateau",
			"TempestKeepTheEye",
			"ZulAman",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"AuchAuchenaiCrypts",
			"AuchindounEnt",
			"AuchManaTombs",
			"AuchSethekkHalls",
			"AuchShadowLabyrinth",
			"BlackrockDepths",
			"BlackrockSpireEnt",
			"CFRTheSlavePens",
			"CFRTheSteamvault",
			"CFRTheUnderbog",
			"CoilfangReservoirEnt",
			"CoTBlackMorass",
			"CoTEnt",
			"CoTOldHillsbrad",
			"DireMaulEast",
			"DireMaulEnt",
			"DireMaulNorth",
			"DireMaulWest",
			"HCBloodFurnace",
			"HCHellfireRamparts",
			"HCTheShatteredHalls",
			"MagistersTerrace",
			"Scholomance",
			"Stratholme",
			"TempestKeepArcatraz",
			"TempestKeepBotanica",
			"TempestKeepMechanar",
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"BlackfathomDeeps",
			"BlackfathomDeepsEnt",
			"BlackrockSpireEnt",
			"BlackrockSpireLower",
			"BlackrockSpireUpper",
			"Gnomeregan",
			"GnomereganEnt",
			"KarazhanEnd",
			"KarazhanEnt",
			"KarazhanStart",
			"Maraudon",
			"MaraudonEnt",
			"RagefireChasm",
			"RazorfenDowns",
			"RazorfenKraul",
			"ShadowfangKeep",
			"SMArmory",
			"SMCathedral",
			"SMEnt",
			"SMGraveyard",
			"SMLibrary",
			"TheDeadmines",
			"TheDeadminesEnt",
			"TheStockade",
			"TheSunkenTemple",
			"TheSunkenTempleEnt",
			"Uldaman",
			"UldamanEnt",
			"WailingCaverns",
			"WailingCavernsEnt",
			"ZulAman",
			"ZulFarrak",
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"BlackrockSpireEnt",
			"BlackTempleBasement",
			"BlackTempleStart",
			"BlackTempleTop",
			"BlackwingLair",
			"CFRSerpentshrineCavern",
			"CoilfangReservoirEnt",
			"CoTEnt",
			"CoTHyjal",
			"GruulsLair",
			"HCMagtheridonsLair",
			"MoltenCore",
			"Naxxramas",
			"OnyxiasLair",
			"SunwellPlateau",
			"TempestKeepTheEye",
			"TheRuinsofAhnQiraj",
			"TheTempleofAhnQiraj",
			"ZulGurub",
		},
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_OLD_AO] = {
			"BlackfathomDeeps",
			"BlackfathomDeepsEnt",
			"BlackrockDepths",
			"BlackrockSpireEnt",
			"BlackrockSpireLower",
			"BlackrockSpireUpper",
			"BlackwingLair",
			"DireMaulEast",
			"DireMaulEnt",
			"DireMaulNorth",
			"DireMaulWest",
			"Gnomeregan",
			"GnomereganEnt",
			"Maraudon",
			"MaraudonEnt",
			"MoltenCore",
			"Naxxramas",
			"OnyxiasLair",
			"TheDeadmines",
			"TheDeadminesEnt",
		},
		[ATLAS_DDL_EXPANSION_OLD_PZ] = {
			"RagefireChasm",
			"RazorfenDowns",
			"RazorfenKraul",
			"Scholomance",
			"ShadowfangKeep",
			"SMArmory",
			"SMCathedral",
			"SMEnt",
			"SMGraveyard",
			"SMLibrary",
			"Stratholme",
			"TheRuinsofAhnQiraj",
			"TheStockade",
			"TheSunkenTemple",
			"TheSunkenTempleEnt",
			"TheTempleofAhnQiraj",
			"Uldaman",
			"UldamanEnt",
			"WailingCaverns",
			"WailingCavernsEnt",
			"ZulFarrak",
			"ZulGurub",
		},
		[ATLAS_DDL_EXPANSION_BC] = {
			"AuchAuchenaiCrypts",
			"AuchindounEnt",
			"AuchManaTombs",
			"AuchSethekkHalls",
			"AuchShadowLabyrinth",
			"BlackTempleBasement",
			"BlackTempleStart",
			"BlackTempleTop",
			"CFRSerpentshrineCavern",
			"CFRTheSlavePens",
			"CFRTheSteamvault",
			"CFRTheUnderbog",
			"CoilfangReservoirEnt",
			"CoTBlackMorass",
			"CoTEnt",
			"CoTHyjal",
			"CoTOldHillsbrad",
			"GruulsLair",
			"HCBloodFurnace",
			"HCHellfireRamparts",
			"HCMagtheridonsLair",
			"HCTheShatteredHalls",
			"KarazhanEnd",
			"KarazhanEnt",
			"KarazhanStart",
			"MagistersTerrace",
			"SunwellPlateau",
			"TempestKeepArcatraz",
			"TempestKeepBotanica",
			"TempestKeepMechanar",
			"TempestKeepTheEye",
			"ZulAman",
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE_AK] = {
			"AuchAuchenaiCrypts",
			"AuchManaTombs",
			"AuchSethekkHalls",
			"AuchShadowLabyrinth",
			"BlackfathomDeeps",
			"BlackrockDepths",
			"BlackrockSpireLower",
			"BlackrockSpireUpper",
			"BlackTempleBasement",
			"BlackTempleStart",
			"BlackTempleTop",
			"BlackwingLair",
			"CFRSerpentshrineCavern",
			"CFRTheSlavePens",
			"CFRTheSteamvault",
			"CFRTheUnderbog",
			"CoTBlackMorass",
			"CoTHyjal",
			"CoTOldHillsbrad",
			"DireMaulEast",
			"DireMaulNorth",
			"DireMaulWest",
			"Gnomeregan",
			"GruulsLair",
			"HCBloodFurnace",
			"HCHellfireRamparts",
			"HCMagtheridonsLair",
			"HCTheShatteredHalls",
			"KarazhanEnd",
			"KarazhanStart",
			"TheDeadmines",
		},
		[ATLAS_DDL_TYPE_INSTANCE_MZ] = {
			"MagistersTerrace",
			"Maraudon",
			"MoltenCore",
			"Naxxramas",
			"OnyxiasLair",
			"RagefireChasm",
			"RazorfenDowns",
			"RazorfenKraul",
			"Scholomance",
			"ShadowfangKeep",
			"SMArmory",
			"SMCathedral",
			"SMGraveyard",
			"SMLibrary",
			"Stratholme",
			"SunwellPlateau",
			"TempestKeepArcatraz",
			"TempestKeepBotanica",
			"TempestKeepMechanar",
			"TempestKeepTheEye",
			"TheRuinsofAhnQiraj",
			"TheStockade",
			"TheSunkenTemple",
			"TheTempleofAhnQiraj",
			"Uldaman",
			"WailingCaverns",
			"ZulAman",
			"ZulFarrak",
			"ZulGurub",
		},
		[ATLAS_DDL_TYPE_ENTRANCE] = {
			"AuchindounEnt",
			"BlackfathomDeepsEnt",
			"BlackrockSpireEnt",
			"CoilfangReservoirEnt",
			"CoTEnt",
			"DireMaulEnt",
			"GnomereganEnt",
			"KarazhanEnt",
			"MaraudonEnt",
			"SMEnt",
			"TheDeadminesEnt",
			"TheSunkenTempleEnt",
			"UldamanEnt",
			"WailingCavernsEnt",
		},
	},
};
