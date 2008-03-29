---------------------------------------------------------
------ French localization by Trralzz (Hyjal, EU) -------
if (GetLocale() == "frFR") then

GEMHELPER_VERSION_TEXT		= "Gem Helper v1.5";
GEMHELPER_DONE_TEXT		= "Ok";

GEMHELPER_ERRORTOOLTIP_L1	= "Objet invalide";
GEMHELPER_ERRORTOOLTIP_L2	= "ObjetID: ";
GEMHELPER_ERRORTOOLTIP_L3	= "Cet objet n'est pas fiable.\nPour voir cet objet sans risque de d\195\169connexion, vous devez l'avoir d\195\169j\195\160 vu une fois dans le jeu.\nCette restriction est impos\195\169e par Blizzard depuis la mise \195\160 jour 1.10.";
GEMHELPER_ERRORTOOLTIP_L4	= "Un clic-droit permet de tenter d'interroger le serveur.\nVous pouvez \195\170tre d\195\169connect\195\169.";
GEMHELPER_QUERY_MESSAGE		= "requ\195\170te serveur pour ";

GEMHELPER_OPENJC_TEXT		= "Ouvrir/Fermer la fen\195\170tre de Joaillerie d'origine.";
GEMHELPER_CHANGEBGCOLOR_TEXT	= "Change the background color.";

-- GEMHELPER_JEWELCRAFTING_TEXT must match the text written on the top of default Jewelcrafting UI
-- window, which should also be the same as the text written in your Character --> Skills -->
-- Professions panel because this string is used to check whether a player has Jewelcrafting as
-- a profession as well as whether the Jewelcrafting default UI window is about to be open.
GEMHELPER_JEWELCRAFTING_TEXT	= "Joaillerie";


GEMHELPER_CHECKBUTTON_TEXT	= {
	[1]	= "Filtrer par couleur de Gemme",
	[2]	= "Filtrer par composants",
	[3]	= "Filtrer par caract\195\169ristique",

	[11]	= "Gemmes Bleue",
	[12]	= "Gemmes Rouge",
	[13]	= "Gemmes Jaune",
	[14]	= "M\195\169ta-Gemmes",

	[21]	= "Pierre de lune azur (B)",
	[22]	= "Grenat sanguin (R)",
	[23]	= "Dra\195\169nite dor\195\169e (J)",
	[24]	= "Olivine (J/B)",
	[25]	= "Spessarite de flamme (J/R)",
	[26]	= "Dra\195\169nite ombreuse (R/B)",
	[27]	= "Perle de jaggale (R/B)",

	[31]	= "Etoile d'Elune (B)",
	[32]	= "Rubis vivant (R)",
	[33]	= "Pierre d'aube (J)",
	[34]	= "Talasite (J/B)",
	[35]	= "Topaze noble (J/R)",
	[36]	= "Oeil de nuit (R/B)",
	[37]	= "Perle d'ombre (R/B)",

	[41]	= "Dia. br\195\187leciel (M)",
	[42]	= "Dia. tonneterre (M)",

	[51]	= "Saphir empyr\195\169en (B)",
	[52]	= "Spinelle cramoisi (R)",
	[53]	= "Oeil de lion (J)",
	[54]	= "Emeraude d'\195\169cume (J/B)",
	[55]	= "Pyrolithe (J/R)",
	[56]	= "Am\195\169thyste chante. (R/B)",

	[61]	= "Force",
	[62]	= "Agilit\195\169",
	[63]	= "Endurance",
	[64]	= "Intelligence",
	[65]	= "Esprit",
	[66]	= "R\195\169silience",

	[71]	= "Score de toucher",
	[72]	= "Score de coup critique",
	[73]	= "Puissance d'attaque",
	[74]	= "Score d'esquive",
	[75]	= "Score de d\195\169fense",
	[76]	= "Score de parade",

	[80]	= "Score de toucher des sorts",
	[81]	= "Score de critique des sorts",
	[82]	= "P\195\169n\195\169tration des sorts",
	[83]	= "D\195\169g\195\162ts des sorts",
	[84]	= "Soin",
	[85]	= "Mana toutes les 5 s",
	[86]	= "Toute r\195\169sistance",

	[101]	= "Voir les Gemmes de Joaillerie",
	[1011]	= "Dont j'ai les composants",
	[1012]	= "Que %s peut tailler",
	[102]	= "Voir les Gemmes d'Enchanteur",
	[103]	= "Voir les Gemmes des Vendeurs",
	[104]	= "Voir les Gemmes trouv\195\169es en instance",

	[111]	= "Remplacer l'interface",
};

GemHelper_GemLocaleData = {
	-- Craft\195\169 Uncommon Quality Gems
	[23095] = {["n"] = "Grenat sanguin soutenu",				["d"] = "Craft\195\169, 1 Grenat sanguin"},
	[28595] = {["n"] = "Grenat sanguin \195\169clatant",			["d"] = "Craft\195\169, 1 Grenat sanguin"},
	[23113] = {["n"] = "Dra\195\169nite dor\195\169e brillante",		["d"] = "Craft\195\169, 1 Dra\195\169nite dor\195\169e"},
	[23106] = {["n"] = "Olivine \195\169blouissante",			["d"] = "Craft\195\169, 1 Olivine (Clairvoyants)"},
	[23097] = {["n"] = "Grenat sanguin d\195\169licat",			["d"] = "Craft\195\169, 1 Grenat sanguin"},
	[23105] = {["n"] = "Olivine durcie",					["d"] = "Craft\195\169, 1 Olivine"},
	[23114] = {["n"] = "Dra\195\169nite dor\195\169e resplendissante",	["d"] = "Craft\195\169, 1 Dra\195\169nite dor\195\169e"},
	[23100] = {["n"] = "Spessarite de flamme luisante",			["d"] = "Craft\195\169, 1 Spessarite de flamme"},
	[23108] = {["n"] = "Dra\195\169nite ombreuse luminescente",		["d"] = "Craft\195\169, 1 Dra\195\169nite ombreuse"},
	[23098] = {["n"] = "Spessarite de flamme intaill\195\169e",		["d"] = "Craft\195\169, 1 Spessarite de flamme"},
	[23104] = {["n"] = "Olivine dentel\195\169e",				["d"] = "Craft\195\169, 1 Olivine"},
	[23099] = {["n"] = "Spessarite de flamme lumineuse",			["d"] = "Craft\195\169, 1 Spessarite de flamme"},
	[23121] = {["n"] = "Pierre de lune azur satin\195\169e",		["d"] = "Craft\195\169, 1 Pierre de lune azur"},
	[23101] = {["n"] = "Spessarite de flamme toute-puissante",		["d"] = "Craft\195\169, 1 Spessarite de flamme"},
	[23103] = {["n"] = "Olivine radieuse",					["d"] = "Craft\195\169, 1 Olivine"},
	[23116] = {["n"] = "Dra\195\169nite dor\195\169e rigide",		["d"] = "Craft\195\169, 1 Dra\195\169nite dor\195\169e"},
	[23109] = {["n"] = "Dra\195\169nite ombreuse royale",			["d"] = "Craft\195\169, 1 Dra\195\169nite ombreuse (Aldor)"},
	[23096] = {["n"] = "Grenat sanguin runique",				["d"] = "Craft\195\169, 1 Grenat sanguin"},
	[23110] = {["n"] = "Dra\195\169nite ombreuse changeante",		["d"] = "Craft\195\169, 1 Dra\195\169nite ombreuse"},
	[28290] = {["n"] = "Dra\195\169nite dor\195\169e lisse",		["d"] = "Craft\195\169, 1 Dra\195\169nite dor\195\169e"},
	[23118] = {["n"] = "Pierre de lune azur solide",			["d"] = "Craft\195\169, 1 Pierre de lune azur"},
	[23111] = {["n"] = "Dra\195\169nite ombreuse souveraine",		["d"] = "Craft\195\169, 1 Dra\195\169nite ombreuse"},
	[23119] = {["n"] = "Pierre de lune azur \195\169tincelante",		["d"] = "Craft\195\169, 1 Pierre de lune azur"},
	[23120] = {["n"] = "Pierre de lune azur orageuse",			["d"] = "Craft\195\169, 1 Pierre de lune azur"},
	[23094] = {["n"] = "Larme de grenat sanguin",				["d"] = "Craft\195\169, 1 Grenat sanguin"},
	[23115] = {["n"] = "Dra\195\169nite dor\195\169e bomb\195\169e",	["d"] = "Craft\195\169, 1 Dra\195\169nite dor\195\169e"},

	-- Craft\195\169 Rare Quality Gems
	[24027] = {["n"] = "Rubis vivant soutenu",			["d"] = "Craft\195\169, 1 Rubis vivant"},
	[24031] = {["n"] = "Rubis vivant \195\169clatant",		["d"] = "Craft\195\169, 1 Rubis vivant"},
	[24047] = {["n"] = "Pierre d'aube brillante",			["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[24065] = {["n"] = "Talasite \195\169blouissante",		["d"] = "Craft\195\169, 1 Talasite"},
	[24028] = {["n"] = "Rubis vivant d\195\169licat",		["d"] = "Craft\195\169, 1 Rubis vivant"},
	[24062] = {["n"] = "Talasite durcie",				["d"] = "Craft\195\169, 1 Talasite"},
	[24036] = {["n"] = "Rubis vivant miroitant",			["d"] = "Craft\195\169, 1 Rubis vivant"},
	[24050] = {["n"] = "Pierre d'aube resplendissante",		["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[24061] = {["n"] = "Topaze noble luisante",			["d"] = "Craft\195\169, 1 Topaze noble"},
	[24056] = {["n"] = "Oeil de nuit luminescent",			["d"] = "Craft\195\169, 1 Oeil de nuit"},
	[24058] = {["n"] = "Topaze noble intaill\195\169e",		["d"] = "Craft\195\169, 1 Topaze noble"},
	[24067] = {["n"] = "Talasite dentel\195\169e",			["d"] = "Craft\195\169, 1 Talasite"},
	[24060] = {["n"] = "Topaze noble lumineuse",			["d"] = "Craft\195\169, 1 Topaze noble"},
	[24037] = {["n"] = "Etoile d'Elune satin\195\169e",		["d"] = "Craft\195\169, 1 Etoile d'Elune"},
	[24059] = {["n"] = "Topaze noble toute-puissante",		["d"] = "Craft\195\169, 1 Topaze noble"},
	[24066] = {["n"] = "Talasite radieuse",				["d"] = "Craft\195\169, 1 Talasite"},
	[24051] = {["n"] = "Pierre d'aube rigide",			["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[24057] = {["n"] = "Oeil de nuit royal",			["d"] = "Craft\195\169, 1 Oeil de nuit"},
	[24030] = {["n"] = "Rubis vivant runique",			["d"] = "Craft\195\169, 1 Rubis vivant"},
	[24055] = {["n"] = "Oeil de nuit changeant",			["d"] = "Craft\195\169, 1 Oeil de nuit"},
	[24048] = {["n"] = "Pierre d'aube lisse",			["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[24033] = {["n"] = "Etoile d'Elune solide",			["d"] = "Craft\195\169, 1 Etoile d'Elune"},
	[24054] = {["n"] = "Oeil de nuit souverain",			["d"] = "Craft\195\169, 1 Oeil de nuit"},
	[24035] = {["n"] = "Etoile d'Elune \195\169tincelante",		["d"] = "Craft\195\169, 1 Etoile d'Elune"},
	[24039] = {["n"] = "Etoile d'Elune orageuse",			["d"] = "Craft\195\169, 1 Etoile d'Elune"},
	[24032] = {["n"] = "Rubis vivant subtil",			["d"] = "Craft\195\169, 1 Rubis vivant"},
	[24029] = {["n"] = "Larme de rubis vivant",			["d"] = "Craft\195\169, 1 Rubis vivant"},
	[24052] = {["n"] = "Pierre d'aube bomb\195\169e",		["d"] = "Craft\195\169, 1 Pierre d'aube"},

	-- Craft\195\169 Rare Meta Gems
	[25897] = {["n"] = "Diamant tonneterre de fringance",			["d"] = "Craft\195\169, 1 Diamant tonneterre"},
	[25899]	= {["n"] = "Diamant tonneterre de brutalit\195\169",		["d"] = "Craft\195\169, 1 Diamant tonneterre"},
	[25890] = {["n"] = "Diamant br\195\187leciel de destruction",		["d"] = "Craft\195\169, 1 Diamant br\195\187leciel"},
	[25895] = {["n"] = "Diamant br\195\187leciel de myst\195\168re",	["d"] = "Craft\195\169, 1 Diamant br\195\187leciel"},
	[25901]	= {["n"] = "Diamant tonneterre de perspicacit\195\169",		["d"] = "Craft\195\169, 1 Diamant tonneterre"},
	[25893] = {["n"] = "Diamant br\195\187leciel de mysticisme",		["d"] = "Craft\195\169, 1 Diamant br\195\187leciel"},
	[25896] = {["n"] = "Diamant tonneterre de puissance",			["d"] = "Craft\195\169, 1 Diamant tonneterre"},
	[25894] = {["n"] = "Diamant br\195\187leciel de rapidit\195\169",	["d"] = "Craft\195\169, 1 Diamant br\195\187leciel"},
	[25898]	= {["n"] = "Diamant tonneterre de t\195\169nacit\195\169",	["d"] = "Craft\195\169, 1 Diamant tonneterre"},

	-- Enchanter Created
	[22460] = {["n"] = "Sph\195\168re prismatique",				["d"] = "Craft Enchanteur, 4 Grand \195\169clat prismatique"},
	[22459] = {["n"] = "Sph\195\168re de vide",				["d"] = "Craft Enchanteur, 2 Cristal de vide"},

	-- PvP Purchased Rare Meta Gems (Terrokar Spirit Towers)
	[28557] = {["n"] = "Diamant br\195\187l\195\169toile de rapidit\195\169",	["d"] = "Vendeur, 8 Eclat d'esprit (Bastion All\195\169rien/Fort des Brise-pierres)"},
	[28556] = {["n"] = "Diamant br\195\187levent de rapidit\195\169",		["d"] = "Vendeur, 8 Eclat d'esprit (Bastion All\195\169rien/Fort des Brise-pierres)"},

	-- PvP Purchased Gems (Nagrand, Halaa)
	[27679]	= {["n"] = "Pierre d'aube mystique sublime",			["d"] = "Vendeur, 100 Gage de bataille de Halaa (Halaa, Nagrand)"},
	[30598] = {["n"] = "Coeur de Don Amanci", 				["d"] = "Vendeur, 14o 9a 72c (Stock limit\195\169 (1)) (Halaa, Nagrand)"},

	-- PvP Purchased Epic Gems (Honneur Points)
	[28362] = {["n"] = "Rubis orn\195\169 soutenu",				["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des l\195\169gendes)"},
	[28120] = {["n"] = "Pierre d'aube orn\195\169e resplendissante",	["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des l\195\169gendes)"},
	[28363] = {["n"] = "Topaze orn\195\169e intaill\195\169e",		["d"] = "Vendeur, 10000 Honneur (Hall des Champions/Hall des l\195\169gendes)"},
	[28123] = {["n"] = "Topaze orn\195\169e toute-puissante",		["d"] = "Vendeur, 10000 Honneur (Hall des Champions/Hall des l\195\169gendes)"},
	[28118] = {["n"] = "Rubis orn\195\169 runique",				["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des l\195\169gendes)"},
	[28119] = {["n"] = "Pierre d'aube orn\195\169e lisse",			["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des l\195\169gendes)"},

	-- PvP Puchased Rare Gems (Honneur Hold/Thrallmar)
	-- Honneur Hold itemIDs
	[27809] = {["n"] = "Olivine barbel\195\169e", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},
	[28361] = {["n"] = "Grenat sanguin puissant", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},
	[27820] = {["n"] = "Olivine entaill\195\169e", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},
	[27812] = {["n"] = "Grenat sanguin sobre", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},

	--Thrallmar duplicates, different itemIDs
	--[27786] = {["n"] = "Olivine barbel\195\169e", 		["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},
	--[28360] = {["n"] = "Grenat sanguin puissant", 		["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},
	--[27785] = {["n"] = "Olivine entaill\195\169e",		["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},
	--[27777] = {["n"] = "Grenat sanguin sobre", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (P\195\169ninsule des flammes infernales)"},

	-- Vendeur Purchased (Common Gems)
	[28458] = {["n"] = "Bold Tourmaline", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28462] = {["n"] = "Bright Tourmaline", 			["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28466] = {["n"] = "Brilliant Amber", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28459] = {["n"] = "Delicate Tourmaline", 			["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28469] = {["n"] = "Gleaming Amber", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28465] = {["n"] = "Lustrous Zircon", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28468] = {["n"] = "Rigid Amber", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28461] = {["n"] = "Runed Tourmaline", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28467] = {["n"] = "Smooth Amber", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28463] = {["n"] = "Solid Zircon", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28464] = {["n"] = "Sparkling Zircon", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28460] = {["n"] = "Teardrop Tourmaline", 			["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},
	[28470] = {["n"] = "Thick Amber", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudrefl\195\168che, Bastion de l'Honneur, Thrallmar)"},

	-- Instance Epic Gem Drops
	[30565] = {["n"] = "Opale de feu d'assassin",			["d"] = "Le Mechanar - H\195\169ro\195\175que"},
	[30601] = {["n"] = "Opale de feu flambante",			["d"] = "La Fournaise du Sang - H\195\169ro\195\175que"},
	[30574] = {["n"] = "Tanzanite brutale",				["d"] = "Botanica - H\195\169ro\195\175que"},
	[30587] = {["n"] = "Opale de feu de champion", 			["d"] = "Cryptes Auchenai - H\195\169ro\195\175que"},
	[30566] = {["n"] = "Tanzanite de d\195\169fenseur",		["d"] = "Le Mechanar - H\195\169ro\195\175que"},
	[30594] = {["n"] = "Chrysoprase nitescente",			["d"] = "Remparts des flammes infernales - H\195\169ro\195\175que"},
	[30584] = {["n"] = "Opale de feu intaill\195\169e",		["d"] = "Tombe-mana - H\195\169ro\195\175que"},
	[30559] = {["n"] = "Opale de feu grav\195\169e", 		["d"] = "Labyrinthe des Ombres - H\195\169ro\195\175que"},
	[30600] = {["n"] = "Tanzanite fluorescente", 			["d"] = "La Fournaise du Sang - H\195\169ro\195\175que"},
	[30558] = {["n"] = "Opale de feu rougoyante",			["d"] = "Le noir mar\195\169cage - H\195\169ro\195\175que"},
	[30556] = {["n"] = "Opale de feu luisante",			["d"] = "Le noir mar\195\169cage - H\195\169ro\195\175que"},
	[30585] = {["n"] = "Opale de feu scintillante",			["d"] = "Tombe-mana - H\195\169ro\195\175que"},
	[30555]	= {["n"] = "Tanzanite luminescente",			["d"] = "Le noir mar\195\169cage - H\195\169ro\195\175que"},
	[31116] = {["n"] = "Am\195\169thyste infus\195\169e",		["d"] = "R\195\169compense Qu\195\170te - Plaie-de-nuit, Karazhan"},
	[30551] = {["n"] = "Opale de feu infus\195\169e",		["d"] = "Le caveau de la vapeur - H\195\169ro\195\175que"},
	[30593] = {["n"] = "Opale de feu iridescente",			["d"] = "Remparts des flammes infernales - H\195\169ro\195\175que"},
	[30602] = {["n"] = "Chrysoprase dentel\195\169e",		["d"] = "La Fournaise du Sang - H\195\169ro\195\175que"},
	[30606] = {["n"] = "Chrysoprase diapr\195\169e",		["d"] = "La basse tourbi\195\168re - H\195\169ro\195\175que"},
	[30547] = {["n"] = "Opale de feu lumineuse",			["d"] = "Les salles bris\195\169es - H\195\169ro\195\175que"},
	[30548] = {["n"] = "Chrysoprase polie",				["d"] = "Les salles bris\195\169es - H\195\169ro\195\175que"},
	[30553] = {["n"] = "Opale de feu en parfait \195\169tat",	["d"] = "Salle de Sethekk - H\195\169ro\195\175que"},
	[31118] = {["n"] = "Am\195\169thyste vibrante",			["d"] = "R\195\169compense Qu\195\170te - Plaie-de-nuit, Karazhan"},
	[30608] = {["n"] = "Chrysoprase radieuse",			["d"] = "La basse tourbi\195\168re - H\195\169ro\195\175que"},
	[30563]	= {["n"] = "Tanzanite r\195\169gale",			["d"] = "Labyrinthe des Ombres - H\195\169ro\195\175que"},
	[30604] = {["n"] = "Opale de feu resplendissante",		["d"] = "L'enclos des esclaves - H\195\169ro\195\175que"},
	[30603]	= {["n"] = "Tanzanite royale",				["d"] = "L'enclos des esclaves - H\195\169ro\195\175que"},
	[30586] = {["n"] = "Chrysoprase de proph\195\168te",		["d"] = "Cryptes Auchenai - H\195\169ro\195\175que"},
	[30549] = {["n"] = "Tanzanite changeante",			["d"] = "Le caveau de la vapeur - H\195\169ro\195\175que"},
	[30564] = {["n"] = "Opale de feu rayonnante",			["d"] = "Le Mechanar - H\195\169ro\195\175que"},
	[31117] = {["n"] = "Am\195\169thyste apaisante",		["d"] = "R\195\169compense Qu\195\170te - Plaie-de-nuit, Karazhan"},
	[30546] = {["n"] = "Tanzanite souveraine",			["d"] = "Les salles bris\195\169es - H\195\169ro\195\175que"},
	[30607] = {["n"] = "Opale de feu splendide",			["d"] = "La basse tourbi\195\168re - H\195\169ro\195\175que"},
	[30554] = {["n"] = "Opale de feu infrangible", 			["d"] = "Salle de Sethekk - H\195\169ro\195\175que"},
	[30592] = {["n"] = "Chrysoprase stable",			["d"] = "Remparts des flammes infernales - H\195\169ro\195\175que"},
	[30550] = {["n"] = "Chrysoprase scind\195\169e",		["d"] = "Le caveau de la vapeur - H\195\169ro\195\175que"},
	[30583] = {["n"] = "Chrysoprase intemporelle", 			["d"] = "Tombe-mana - H\195\169ro\195\175que"},
	[30605] = {["n"] = "Chrysoprase vive",	 			["d"] = "L'enclos des esclaves - H\195\169ro\195\175que"},

	-- Added in Gem Helper v1.1
	[30552] = {["n"] = "Tanzanite b\195\169nie",			["d"] = "Salle de Sethekk - H\195\169ro\195\175que"},
	[30589] = {["n"] = "Chrysoprase \195\169blouissante",		["d"] = "Les contreforts d'Hautebrande d'antan - H\195\169ro\195\175que"},
	[30582] = {["n"] = "Opale de feu mortelle",			["d"] = "l'Arcatraz - H\195\169ro\195\175que"},
	[30581] = {["n"] = "Opale de feu solide",			["d"] = "l'Arcatraz - H\195\169ro\195\175que"},
	[30591] = {["n"] = "Opale de feu surpuissante",			["d"] = "Les contreforts d'Hautebrande d'antan - H\195\169ro\195\175que"},
	[30590] = {["n"] = "Chrysoprase durcie",			["d"] = "Les contreforts d'Hautebrande d'antan - H\195\169ro\195\175que"},
	[30572] = {["n"] = "Tanzanite imp\195\169riale",		["d"] = "Botanica - H\195\169ro\195\175que"},
	[30573] = {["n"] = "Opale de feu myst\195\169rieuse",		["d"] = "Botanica - H\195\169ro\195\175que"},
	[30575] = {["n"] = "Opale de feu agile",			["d"] = "l'Arcatraz - H\195\169ro\195\175que"},
	[30588] = {["n"] = "Opale de feu toute-puissante",		["d"] = "Cryptes Auchenai - H\195\169ro\195\175que"},
	[30560] = {["n"] = "Chrysoprase couverte de runes",		["d"] = "Labyrinthe des Ombres - H\195\169ro\195\175que"},

	-- Added in Gem Helper v1.2
	[31863] = {["n"] = "Oeil de nuit \195\169quilibr\195\169",	["d"] = "Craft\195\169, 1 Oeil de nuit"},
	[31861] = {["n"] = "Grande pierre d'aube",			["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[31865] = {["n"] = "Oeil de nuit infus\195\169",		["d"] = "Craft\195\169, 1 Oeil de nuit"},
	[31867] = {["n"] = "Topaze noble voil\195\169e",		["d"] = "Craft\195\169, 1 Topaze noble"},
	[31868] = {["n"] = "Topaze noble pernicieuse",			["d"] = "Craft\195\169, 1 Topaze noble"},
	[32836] = {["n"] = "Perle d'ombre purifi\195\169e",		["d"] = "Craft\195\169, 1 Perle d'ombre, 1 Eau de Draenor purifi\195\169e"},
	[32833] = {["n"] = "Perle de jaggale purifi\195\169e",		["d"] = "Craft\195\169, 1 Perle de jaggale, 1 Eau de Draenor purifi\195\169e"},
	[32409]	= {["n"] = "Diamant tonneterre implacable",		["d"] = "Craft\195\169, 1 Diamant tonneterre"},
	[32410] = {["n"] = "Diamant br\195\187leciel foudroyant",		["d"] = "Craft\195\169, 1 Diamant br\195\187leciel"},

	-- Added in Gem Helper v1.3
	[24053] = {["n"] = "Pierre d'aube mystique",			["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[32634] = {["n"] = "Am\195\169thyste instable",			["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32635] = {["n"] = "Olivine instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32636] = {["n"] = "Saphir instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32637] = {["n"] = "Citrine instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32638] = {["n"] = "Topaze instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32639] = {["n"] = "Talasite instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32640] = {["n"] = "Diamant instable tout-puissant",		["d"] = "Vendeur, 160 Eclat apogide (Les Tranchantes)"},
	[32641] = {["n"] = "Diamant instable impr\195\169gn\195\169",	["d"] = "Vendeur, 160 Eclat apogide (Les Tranchantes)"},

	-- Added in Gem Helper v1.3
	-- The following gems are crafted from epic gem drops in Black Temple/Hyjal
	[32193] = {["n"] = "Spinelle cramoisi soutenu",					["d"] = "Craft\195\169, 1 Spinelle cramoisi"},
	[32194] = {["n"] = "Spinelle cramoisi d\195\169licat",				["d"] = "Craft\195\169, 1 Spinelle cramoisi"},
	[32195] = {["n"] = "Larme de spinelle cramoisi",				["d"] = "Craft\195\169, 1 Spinelle cramoisi"},
	[32196] = {["n"] = "Spinelle cramoisi runique",					["d"] = "Craft\195\169, 1 Spinelle cramoisi"},
	[32197] = {["n"] = "Spinelle cramoisi \195\169clatant",				["d"] = "Craft\195\169, 1 Spinelle cramoisi"},
	[32198] = {["n"] = "Spinelle cramoisi subtil",					["d"] = "Craft\195\169, 1 Spinelle cramoisi"},
	[32199] = {["n"] = "Spinelle cramoisi miroitant",				["d"] = "Craft\195\169, 1 Spinelle cramoisi"},
	[32200] = {["n"] = "Saphir empyr\195\169en solide",				["d"] = "Craft\195\169, 1 Saphir empyr\195\169en"},
	[32201] = {["n"] = "Saphir empyr\195\169en \195\169tincelant",			["d"] = "Craft\195\169, 1 Saphir empyr\195\169en"},
	[32202] = {["n"] = "Saphir empyr\195\169en satin\195\169",			["d"] = "Craft\195\169, 1 Saphir empyr\195\169en"},
	[32203] = {["n"] = "Saphir empyr\195\169en orageuse",				["d"] = "Craft\195\169, 1 Saphir empyr\195\169en"},
	[32204] = {["n"] = "Oeil de lion brillant",					["d"] = "Craft\195\169, 1 Oeil de lion"},
	[32205] = {["n"] = "Oeil de lion lisse",					["d"] = "Craft\195\169, 1 Oeil de lion"},
	[32206] = {["n"] = "Oeil de lion rigide",					["d"] = "Craft\195\169, 1 Oeil de lion"},
	[32207] = {["n"] = "Oeil de lion resplendissant",				["d"] = "Craft\195\169, 1 Oeil de lion"},
	[32208] = {["n"] = "Oeil de lion bomb\195\169",					["d"] = "Craft\195\169, 1 Oeil de lion"},
	[32209] = {["n"] = "Oeil de lion mystique",					["d"] = "Craft\195\169, 1 Oeil de lion"},
	[32210] = {["n"] = "Oeil de lion grande",					["d"] = "Craft\195\169, 1 Oeil de lion"},
	[32211] = {["n"] = "Am\195\169thyste chantelombre souverain",			["d"] = "Craft\195\169, 1 Am\195\169thyste chantelombre"},
	[32212] = {["n"] = "Am\195\169thyste chantelombre changeante",			["d"] = "Craft\195\169, 1 Am\195\169thyste chantelombre"},
	[32213] = {["n"] = "Am\195\169thyste chantelombre \195\169quilibr\195\169e",	["d"] = "Craft\195\169, 1 Am\195\169thyste chantelombre"},
	[32214] = {["n"] = "Am\195\169thyste chantelombre infus\195\169e",		["d"] = "Craft\195\169, 1 Am\195\169thyste chantelombre"},
	[32215] = {["n"] = "Am\195\169thyste chantelombre luminescente",		["d"] = "Craft\195\169, 1 Am\195\169thyste chantelombre"},
	[32216] = {["n"] = "Am\195\169thyste chantelombre royale",			["d"] = "Craft\195\169, 1 Am\195\169thyste chantelombre"},
	[32217] = {["n"] = "Pyrolithe intaill\195\169e",				["d"] = "Craft\195\169, 1 Pyrolithe"},
	[32218] = {["n"] = "Pyrolithe toute-puissante",					["d"] = "Craft\195\169, 1 Pyrolithe"},
	[32219] = {["n"] = "Pyrolithe lumineuse",					["d"] = "Craft\195\169, 1 Pyrolithe"},
	[32220] = {["n"] = "Pyrolithe luisante",					["d"] = "Craft\195\169, 1 Pyrolithe"},
	[32221] = {["n"] = "Pyrolithe voil\195\169e",					["d"] = "Craft\195\169, 1 Pyrolithe"},
	[32222] = {["n"] = "Pyrolithe pernicieuse",					["d"] = "Craft\195\169, 1 Pyrolithe"},
	[32223] = {["n"] = "Emeraude d'\195\169cume durcie",				["d"] = "Craft\195\169, 1 Emeraude d'\195\169cume"},
	[32224] = {["n"] = "Emeraude d'\195\169cume radieuse",				["d"] = "Craft\195\169, 1 Emeraude d'\195\169cume"},
	[32225] = {["n"] = "Emeraude d'\195\169cume \195\169blouissante",		["d"] = "Craft\195\169, 1 Emeraude d'\195\169cume"},
	[32226] = {["n"] = "Emeraude d'\195\169cume dentel\195\169e",			["d"] = "Craft\195\169, 1 Emeraude d'\195\169cume"},

	-- Added in Gem Helper v1.4
	[33131] = {["n"] = "Soleil cramoisi",			["d"] = "Craft\195\169, 1 Rubis vivant"},
	[33133] = {["n"] = "Coeur de don Julio",		["d"] = "Craft\195\169, 1 Rubis vivant"},
	[33134] = {["n"] = "Rose de Kailee",			["d"] = "Craft\195\169, 1 Rubis vivant"},
	[33135] = {["n"] = "Etoile filante",			["d"] = "Craft\195\169, 1 Etoile d'Elune"},
	[33140] = {["n"] = "Sang d'ambre",			["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[33143] = {["n"] = "Pierre des lames",			["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[33144] = {["n"] = "Facette d'\195\169ternit\195\169",	["d"] = "Craft\195\169, 1 Pierre d'aube"},
	[33782] = {["n"] = "Talasite stable",			["d"] = "Craft\195\169, 1 Talasite"},

	-- Added in Gem Helper v1.41 (patch 2.2.2)
	[31862] = {["n"] = "Balanced Shadow Draenite (U)",		["d"] = "Craft\195\169, 1 Dra\195\169nite ombreuse"},
	[31860] = {["n"] = "Grande dra\195\169nite dor\195\169e",	["d"] = "Craft\195\169, 1 Dra\195\169nite dor\195\169e"},
	[31864] = {["n"] = "Infused Shadow Draenite (U)",		["d"] = "Craft\195\169, 1 Dra\195\169nite ombreuse"},
	[31866] = {["n"] = "Veiled Flame Spessarite (U)",		["d"] = "Craft\195\169, 1 Spessarite de flamme"},
	[31869] = {["n"] = "Wicked Flame Spessarite (U)",		["d"] = "Craft\195\169, 1 Spessarite de flamme"},

	-- Added in Gem Helper v1.5 (patch 2.3.0)
	[34220] = {["n"] = "Diamant br\195\187leciel chaotique",	["d"] = "Craft\195\169, 1 Diamant br\195\187leciel"},
	[34256] = {["n"] = "Charmed Amani Jewel",	["d"] = "R\195\169compense Qu\195\170te - Zul'Aman"},
};

end

--[[
 à: C3 A0 - \195\160
 â: C3 A2 - \195\162
 ç: C3 A7 - \185\167
 è: C3 A8 - \195\168
 é: C3 A9 - \195\169
 ê: C3 AA - \195\170
 ë: C3 AB - \195\171
 î: C3 AE - \195\174
 ô: C3 B4 - \195\180
 û: C3 BB - \195\187
 œ: C5 93 - \197\147
--]]
