---------------------------------------------------------
------ French localization by Trralzz (Hyjal, EU) -------
if (GetLocale() == "frFR") then

GEMHELPER_VERSION_TEXT		= "Gem Helper v1.7"
GEMHELPER_DONE_TEXT		= "Ok"

GEMHELPER_ERRORTOOLTIP_L1	= "Objet invalide"
GEMHELPER_ERRORTOOLTIP_L2	= "ObjetID: "
GEMHELPER_ERRORTOOLTIP_L3	= "Cet objet n'est pas fiable.\nPour voir cet objet sans risque de déconnexion, vous devez l'avoir déjà vu une fois dans le jeu.\nCette restriction est imposée par Blizzard depuis la mise à jour 1.10."
GEMHELPER_ERRORTOOLTIP_L4	= "Un clic-droit permet de tenter d'interroger le serveur.\nVous pouvez être déconnecté."
GEMHELPER_QUERY_MESSAGE		= "requête serveur pour "

GEMHELPER_OPENJC_TEXT		= "Ouvrir/Fermer la fenêtre de Joaillerie d'origine."
GEMHELPER_CHANGEBGCOLOR_TEXT	= "Change the background color."

-- GEMHELPER_JEWELCRAFTING_TEXT must match the text written on the top of default Jewelcrafting UI
-- window, which should also be the same as the text written in your Character --> Skills -->
-- Professions panel because this string is used to check whether a player has Jewelcrafting as
-- a profession as well as whether the Jewelcrafting default UI window is about to be open.
GEMHELPER_JEWELCRAFTING_TEXT	= "Joaillerie"


GEMHELPER_CHECKBUTTON_TEXT	= {
	[1]	= "Filtrer par couleur de Gemme",
	[2]	= "Filtrer par composants",
	[3]	= "Filtrer par caractéristique",

	[11]	= "Gemmes Bleue",
	[12]	= "Gemmes Rouge",
	[13]	= "Gemmes Jaune",
	[14]	= "Méta-Gemmes",

	[21]	= "Pierre de lune azur (B)",
	[22]	= "Grenat sanguin (R)",
	[23]	= "Draénite dorée (J)",
	[24]	= "Olivine (J/B)",
	[25]	= "Spessarite de flamme (J/R)",
	[26]	= "Draénite ombreuse (R/B)",
	[27]	= "Perle de jaggale (R/B)",

	[31]	= "Etoile d'Elune (B)",
	[32]	= "Rubis vivant (R)",
	[33]	= "Pierre d'aube (J)",
	[34]	= "Talasite (J/B)",
	[35]	= "Topaze noble (J/R)",
	[36]	= "Oeil de nuit (R/B)",
	[37]	= "Perle d'ombre (R/B)",

	[41]	= "Dia. brûleciel (M)",
	[42]	= "Dia. tonneterre (M)",

	[51]	= "Saphir empyréen (B)",
	[52]	= "Spinelle cramoisi (R)",
	[53]	= "Oeil de lion (J)",
	[54]	= "Emeraude d'écume (J/B)",
	[55]	= "Pyrolithe (J/R)",
	[56]	= "Améthyste chante. (R/B)",

	[61]	= "Force",
	[62]	= "Agilité",
	[63]	= "Endurance",
	[64]	= "Intelligence",
	[65]	= "Esprit",
	[66]	= "Résilience",

	[70]	= "Score de hâte des sorts",
	[71]	= "Score de toucher",
	[72]	= "Score de coup critique",
	[73]	= "Puissance d'attaque",
	[74]	= "Score d'esquive",
	[75]	= "Score de défense",
	[76]	= "Score de parade",

	[80]	= "Score de toucher des sorts",
	[81]	= "Score de critique des sorts",
	[82]	= "Pénétration des sorts",
	[83]	= "Dégâts des sorts",
	[84]	= "Soin",
	[85]	= "Mana toutes les 5 s",
	[86]	= "Toute résistance",

	[101]	= "Voir les Gemmes de Joaillerie",
	[1011]	= "Dont j'ai les composants",
	[1012]	= "Que %s peut tailler",
	[102]	= "Voir les Gemmes d'Enchanteur",
	[103]	= "Voir les Gemmes des Vendeurs",
	[104]	= "Voir les Gemmes trouvées en instance",

	[111]	= "Remplacer l'interface",
}

GemHelper_GemLocaleData = {
	-- Crafté Uncommon Quality Gems
	[23095] = {["n"] = "Grenat sanguin soutenu",				["d"] = "Crafté, 1 Grenat sanguin"},
	[28595] = {["n"] = "Grenat sanguin éclatant",			["d"] = "Crafté, 1 Grenat sanguin"},
	[23113] = {["n"] = "Draénite dorée brillante",		["d"] = "Crafté, 1 Draénite dorée"},
	[23106] = {["n"] = "Olivine éblouissante",			["d"] = "Crafté, 1 Olivine (Clairvoyants)"},
	[23097] = {["n"] = "Grenat sanguin délicat",			["d"] = "Crafté, 1 Grenat sanguin"},
	[23105] = {["n"] = "Olivine durcie",					["d"] = "Crafté, 1 Olivine"},
	[23114] = {["n"] = "Draénite dorée resplendissante",	["d"] = "Crafté, 1 Draénite dorée"},
	[23100] = {["n"] = "Spessarite de flamme luisante",			["d"] = "Crafté, 1 Spessarite de flamme"},
	[23108] = {["n"] = "Draénite ombreuse luminescente",		["d"] = "Crafté, 1 Draénite ombreuse"},
	[23098] = {["n"] = "Spessarite de flamme intaillée",		["d"] = "Crafté, 1 Spessarite de flamme"},
	[23104] = {["n"] = "Olivine dentelée",				["d"] = "Crafté, 1 Olivine"},
	[23099] = {["n"] = "Spessarite de flamme lumineuse",			["d"] = "Crafté, 1 Spessarite de flamme"},
	[23121] = {["n"] = "Pierre de lune azur satinée",		["d"] = "Crafté, 1 Pierre de lune azur"},
	[23101] = {["n"] = "Spessarite de flamme toute-puissante",		["d"] = "Crafté, 1 Spessarite de flamme"},
	[23103] = {["n"] = "Olivine radieuse",					["d"] = "Crafté, 1 Olivine"},
	[23116] = {["n"] = "Draénite dorée rigide",		["d"] = "Crafté, 1 Draénite dorée"},
	[23109] = {["n"] = "Draénite ombreuse royale",			["d"] = "Crafté, 1 Draénite ombreuse (Aldor)"},
	[23096] = {["n"] = "Grenat sanguin runique",				["d"] = "Crafté, 1 Grenat sanguin"},
	[23110] = {["n"] = "Draénite ombreuse changeante",		["d"] = "Crafté, 1 Draénite ombreuse"},
	[28290] = {["n"] = "Draénite dorée lisse",		["d"] = "Crafté, 1 Draénite dorée"},
	[23118] = {["n"] = "Pierre de lune azur solide",			["d"] = "Crafté, 1 Pierre de lune azur"},
	[23111] = {["n"] = "Draénite ombreuse souveraine",		["d"] = "Crafté, 1 Draénite ombreuse"},
	[23119] = {["n"] = "Pierre de lune azur étincelante",		["d"] = "Crafté, 1 Pierre de lune azur"},
	[23120] = {["n"] = "Pierre de lune azur orageuse",			["d"] = "Crafté, 1 Pierre de lune azur"},
	[23094] = {["n"] = "Larme de grenat sanguin",				["d"] = "Crafté, 1 Grenat sanguin"},
	[23115] = {["n"] = "Draénite dorée bombée",	["d"] = "Crafté, 1 Draénite dorée"},

	-- Crafté Rare Quality Gems
	[24027] = {["n"] = "Rubis vivant soutenu",			["d"] = "Crafté, 1 Rubis vivant"},
	[24031] = {["n"] = "Rubis vivant éclatant",		["d"] = "Crafté, 1 Rubis vivant"},
	[24047] = {["n"] = "Pierre d'aube brillante",			["d"] = "Crafté, 1 Pierre d'aube"},
	[24065] = {["n"] = "Talasite éblouissante",		["d"] = "Crafté, 1 Talasite"},
	[24028] = {["n"] = "Rubis vivant délicat",		["d"] = "Crafté, 1 Rubis vivant"},
	[24062] = {["n"] = "Talasite durcie",				["d"] = "Crafté, 1 Talasite"},
	[24036] = {["n"] = "Rubis vivant miroitant",			["d"] = "Crafté, 1 Rubis vivant"},
	[24050] = {["n"] = "Pierre d'aube resplendissante",		["d"] = "Crafté, 1 Pierre d'aube"},
	[24061] = {["n"] = "Topaze noble luisante",			["d"] = "Crafté, 1 Topaze noble"},
	[24056] = {["n"] = "Oeil de nuit luminescent",			["d"] = "Crafté, 1 Oeil de nuit"},
	[24058] = {["n"] = "Topaze noble intaillée",		["d"] = "Crafté, 1 Topaze noble"},
	[24067] = {["n"] = "Talasite dentelée",			["d"] = "Crafté, 1 Talasite"},
	[24060] = {["n"] = "Topaze noble lumineuse",			["d"] = "Crafté, 1 Topaze noble"},
	[24037] = {["n"] = "Etoile d'Elune satinée",		["d"] = "Crafté, 1 Etoile d'Elune"},
	[24059] = {["n"] = "Topaze noble toute-puissante",		["d"] = "Crafté, 1 Topaze noble"},
	[24066] = {["n"] = "Talasite radieuse",				["d"] = "Crafté, 1 Talasite"},
	[24051] = {["n"] = "Pierre d'aube rigide",			["d"] = "Crafté, 1 Pierre d'aube"},
	[24057] = {["n"] = "Oeil de nuit royal",			["d"] = "Crafté, 1 Oeil de nuit"},
	[24030] = {["n"] = "Rubis vivant runique",			["d"] = "Crafté, 1 Rubis vivant"},
	[24055] = {["n"] = "Oeil de nuit changeant",			["d"] = "Crafté, 1 Oeil de nuit"},
	[24048] = {["n"] = "Pierre d'aube lisse",			["d"] = "Crafté, 1 Pierre d'aube"},
	[24033] = {["n"] = "Etoile d'Elune solide",			["d"] = "Crafté, 1 Etoile d'Elune"},
	[24054] = {["n"] = "Oeil de nuit souverain",			["d"] = "Crafté, 1 Oeil de nuit"},
	[24035] = {["n"] = "Etoile d'Elune étincelante",		["d"] = "Crafté, 1 Etoile d'Elune"},
	[24039] = {["n"] = "Etoile d'Elune orageuse",			["d"] = "Crafté, 1 Etoile d'Elune"},
	[24032] = {["n"] = "Rubis vivant subtil",			["d"] = "Crafté, 1 Rubis vivant"},
	[24029] = {["n"] = "Larme de rubis vivant",			["d"] = "Crafté, 1 Rubis vivant"},
	[24052] = {["n"] = "Pierre d'aube bombée",		["d"] = "Crafté, 1 Pierre d'aube"},

	-- Crafté Rare Meta Gems
	[25897] = {["n"] = "Diamant tonneterre de fringance",			["d"] = "Crafté, 1 Diamant tonneterre"},
	[25899]	= {["n"] = "Diamant tonneterre de brutalité",		["d"] = "Crafté, 1 Diamant tonneterre"},
	[25890] = {["n"] = "Diamant brûleciel de destruction",		["d"] = "Crafté, 1 Diamant brûleciel"},
	[25895] = {["n"] = "Diamant brûleciel de mystère",	["d"] = "Crafté, 1 Diamant brûleciel"},
	[25901]	= {["n"] = "Diamant tonneterre de perspicacité",		["d"] = "Crafté, 1 Diamant tonneterre"},
	[25893] = {["n"] = "Diamant brûleciel de mysticisme",		["d"] = "Crafté, 1 Diamant brûleciel"},
	[25896] = {["n"] = "Diamant tonneterre de puissance",			["d"] = "Crafté, 1 Diamant tonneterre"},
	[25894] = {["n"] = "Diamant brûleciel de rapidité",	["d"] = "Crafté, 1 Diamant brûleciel"},
	[25898]	= {["n"] = "Diamant tonneterre de ténacité",	["d"] = "Crafté, 1 Diamant tonneterre"},

	-- Enchanter Created
	[22460] = {["n"] = "Sphère prismatique",				["d"] = "Craft Enchanteur, 4 Grand éclat prismatique"},
	[22459] = {["n"] = "Sphère de vide",				["d"] = "Craft Enchanteur, 2 Cristal de vide"},

	-- PvP Purchased Rare Meta Gems (Terrokar Spirit Towers)
	[28557] = {["n"] = "Diamant brûlétoile de rapidité",	["d"] = "Vendeur, 8 Eclat d'esprit (Bastion Allérien/Fort des Brise-pierres)"},
	[28556] = {["n"] = "Diamant brûlevent de rapidité",		["d"] = "Vendeur, 8 Eclat d'esprit (Bastion Allérien/Fort des Brise-pierres)"},

	-- PvP Purchased Gems (Nagrand, Halaa)
	[27679]	= {["n"] = "Pierre d'aube mystique sublime",			["d"] = "Vendeur, 100 Gage de bataille de Halaa (Halaa, Nagrand)"},
	[30598] = {["n"] = "Coeur de Don Amanci", 				["d"] = "Vendeur, 14o 9a 72c (Stock limité (1)) (Halaa, Nagrand)"},

	-- PvP Purchased Epic Gems (Honneur Points)
	[28362] = {["n"] = "Rubis orné soutenu",				["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des légendes)"},
	[28120] = {["n"] = "Pierre d'aube ornée resplendissante",	["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des légendes)"},
	[28363] = {["n"] = "Topaze ornée intaillée",		["d"] = "Vendeur, 10000 Honneur (Hall des Champions/Hall des légendes)"},
	[28123] = {["n"] = "Topaze ornée toute-puissante",		["d"] = "Vendeur, 10000 Honneur (Hall des Champions/Hall des légendes)"},
	[28118] = {["n"] = "Rubis orné runique",				["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des légendes)"},
	[28119] = {["n"] = "Pierre d'aube ornée lisse",			["d"] = "Vendeur, 8100 Honneur (Hall des Champions/Hall des légendes)"},

	-- PvP Puchased Rare Gems (Honneur Hold/Thrallmar)
	-- Honneur Hold itemIDs
	[27809] = {["n"] = "Olivine barbelée", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},
	[28361] = {["n"] = "Grenat sanguin puissant", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},
	[27820] = {["n"] = "Olivine entaillée", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},
	[27812] = {["n"] = "Grenat sanguin sobre", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},

	--Thrallmar duplicates, different itemIDs
	--[27786] = {["n"] = "Olivine barbelée", 		["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},
	--[28360] = {["n"] = "Grenat sanguin puissant", 		["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},
	--[27785] = {["n"] = "Olivine entaillée",		["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},
	--[27777] = {["n"] = "Grenat sanguin sobre", 			["d"] = "Vendeur, 10 Marque du bastion de l'Honneur/Thrallmar (Péninsule des flammes infernales)"},

	-- Vendeur Purchased (Common Gems)
	[28458] = {["n"] = "Tourmaline soutenue", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28462] = {["n"] = "Tourmaline éclatante", 			["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28466] = {["n"] = "Ambre brillant", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28459] = {["n"] = "Tourmaline délicate", 			["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28469] = {["n"] = "Ambre resplendissant", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28465] = {["n"] = "Ziron satiné", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28468] = {["n"] = "Ambre rigide", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28461] = {["n"] = "Tourmaline runique", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28467] = {["n"] = "Ambre lisse", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28463] = {["n"] = "Zircon solide", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28464] = {["n"] = "Zircon étincelant", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28460] = {["n"] = "Larme de tourmaline", 			["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},
	[28470] = {["n"] = "Ambre bombé", 				["d"] = "Gem Vendeur, 2o (Shattrath, Foudreflèche, Bastion de l'Honneur, Thrallmar)"},

	-- Instance Epic Gem Drops
	[30565] = {["n"] = "Opale de feu d'assassin",			["d"] = "Le Mechanar - Héroïque"},
	[30601] = {["n"] = "Opale de feu flambante",			["d"] = "La Fournaise du Sang - Héroïque"},
	[30574] = {["n"] = "Tanzanite brutale",				["d"] = "Botanica - Héroïque"},
	[30587] = {["n"] = "Opale de feu de champion", 			["d"] = "Cryptes Auchenai - Héroïque"},
	[30566] = {["n"] = "Tanzanite de défenseur",		["d"] = "Le Mechanar - Héroïque"},
	[30594] = {["n"] = "Chrysoprase nitescente",			["d"] = "Remparts des flammes infernales - Héroïque"},
	[30584] = {["n"] = "Opale de feu intaillée",		["d"] = "Tombe-mana - Héroïque"},
	[30559] = {["n"] = "Opale de feu gravée", 		["d"] = "Labyrinthe des Ombres - Héroïque"},
	[30600] = {["n"] = "Tanzanite fluorescente", 			["d"] = "La Fournaise du Sang - Héroïque"},
	[30558] = {["n"] = "Opale de feu rougoyante",			["d"] = "Le noir marécage - Héroïque"},
	[30556] = {["n"] = "Opale de feu luisante",			["d"] = "Le noir marécage - Héroïque"},
	[30585] = {["n"] = "Opale de feu scintillante",			["d"] = "Tombe-mana - Héroïque"},
	[30555]	= {["n"] = "Tanzanite luminescente",			["d"] = "Le noir marécage - Héroïque"},
	[31116] = {["n"] = "Améthyste infusée",		["d"] = "Récompense Quête - Plaie-de-nuit, Karazhan"},
	[30551] = {["n"] = "Opale de feu infusée",		["d"] = "Le caveau de la vapeur - Héroïque"},
	[30593] = {["n"] = "Opale de feu iridescente",			["d"] = "Remparts des flammes infernales - Héroïque"},
	[30602] = {["n"] = "Chrysoprase dentelée",		["d"] = "La Fournaise du Sang - Héroïque"},
	[30606] = {["n"] = "Chrysoprase diaprée",		["d"] = "La basse tourbière - Héroïque"},
	[30547] = {["n"] = "Opale de feu lumineuse",			["d"] = "Les salles brisées - Héroïque"},
	[30548] = {["n"] = "Chrysoprase polie",				["d"] = "Les salles brisées - Héroïque"},
	[30553] = {["n"] = "Opale de feu en parfait état",	["d"] = "Salle de Sethekk - Héroïque"},
	[31118] = {["n"] = "Améthyste vibrante",			["d"] = "Récompense Quête - Plaie-de-nuit, Karazhan"},
	[30608] = {["n"] = "Chrysoprase radieuse",			["d"] = "La basse tourbière - Héroïque"},
	[30563]	= {["n"] = "Tanzanite régale",			["d"] = "Labyrinthe des Ombres - Héroïque"},
	[30604] = {["n"] = "Opale de feu resplendissante",		["d"] = "L'enclos des esclaves - Héroïque"},
	[30603]	= {["n"] = "Tanzanite royale",				["d"] = "L'enclos des esclaves - Héroïque"},
	[30586] = {["n"] = "Chrysoprase de prophète",		["d"] = "Cryptes Auchenai - Héroïque"},
	[30549] = {["n"] = "Tanzanite changeante",			["d"] = "Le caveau de la vapeur - Héroïque"},
	[30564] = {["n"] = "Opale de feu rayonnante",			["d"] = "Le Mechanar - Héroïque"},
	[31117] = {["n"] = "Améthyste apaisante",		["d"] = "Récompense Quête - Plaie-de-nuit, Karazhan"},
	[30546] = {["n"] = "Tanzanite souveraine",			["d"] = "Les salles brisées - Héroïque"},
	[30607] = {["n"] = "Opale de feu splendide",			["d"] = "La basse tourbière - Héroïque"},
	[30554] = {["n"] = "Opale de feu infrangible", 			["d"] = "Salle de Sethekk - Héroïque"},
	[30592] = {["n"] = "Chrysoprase stable",			["d"] = "Remparts des flammes infernales - Héroïque"},
	[30550] = {["n"] = "Chrysoprase scindée",		["d"] = "Le caveau de la vapeur - Héroïque"},
	[30583] = {["n"] = "Chrysoprase intemporelle", 			["d"] = "Tombe-mana - Héroïque"},
	[30605] = {["n"] = "Chrysoprase vive",	 			["d"] = "L'enclos des esclaves - Héroïque"},

	-- Added in Gem Helper v1.1
	[30552] = {["n"] = "Tanzanite bénie",			["d"] = "Salle de Sethekk - Héroïque"},
	[30589] = {["n"] = "Chrysoprase éblouissante",		["d"] = "Les contreforts d'Hautebrande d'antan - Héroïque"},
	[30582] = {["n"] = "Opale de feu mortelle",			["d"] = "l'Arcatraz - Héroïque"},
	[30581] = {["n"] = "Opale de feu solide",			["d"] = "l'Arcatraz - Héroïque"},
	[30591] = {["n"] = "Opale de feu surpuissante",			["d"] = "Les contreforts d'Hautebrande d'antan - Héroïque"},
	[30590] = {["n"] = "Chrysoprase durcie",			["d"] = "Les contreforts d'Hautebrande d'antan - Héroïque"},
	[30572] = {["n"] = "Tanzanite impériale",		["d"] = "Botanica - Héroïque"},
	[30573] = {["n"] = "Opale de feu mystérieuse",		["d"] = "Botanica - Héroïque"},
	[30575] = {["n"] = "Opale de feu agile",			["d"] = "l'Arcatraz - Héroïque"},
	[30588] = {["n"] = "Opale de feu toute-puissante",		["d"] = "Cryptes Auchenai - Héroïque"},
	[30560] = {["n"] = "Chrysoprase couverte de runes",		["d"] = "Labyrinthe des Ombres - Héroïque"},

	-- Added in Gem Helper v1.2
	[31863] = {["n"] = "Oeil de nuit équilibré",	["d"] = "Crafté, 1 Oeil de nuit"},
	[31861] = {["n"] = "Grande pierre d'aube",			["d"] = "Crafté, 1 Pierre d'aube"},
	[31865] = {["n"] = "Oeil de nuit infusé",		["d"] = "Crafté, 1 Oeil de nuit"},
	[31867] = {["n"] = "Topaze noble voilée",		["d"] = "Crafté, 1 Topaze noble"},
	[31868] = {["n"] = "Topaze noble pernicieuse",			["d"] = "Crafté, 1 Topaze noble"},
	[32836] = {["n"] = "Perle d'ombre purifiée",		["d"] = "Crafté, 1 Perle d'ombre, 1 Eau de Draenor purifiée"},
	[32833] = {["n"] = "Perle de jaggale purifiée",		["d"] = "Crafté, 1 Perle de jaggale, 1 Eau de Draenor purifiée"},
	[32409]	= {["n"] = "Diamant tonneterre implacable",		["d"] = "Crafté, 1 Diamant tonneterre"},
	[32410] = {["n"] = "Diamant brûleciel foudroyant",		["d"] = "Crafté, 1 Diamant brûleciel"},

	-- Added in Gem Helper v1.3
	[24053] = {["n"] = "Pierre d'aube mystique",			["d"] = "Crafté, 1 Pierre d'aube"},
	[32634] = {["n"] = "Améthyste instable",			["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32635] = {["n"] = "Olivine instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32636] = {["n"] = "Saphir instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32637] = {["n"] = "Citrine instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32638] = {["n"] = "Topaze instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32639] = {["n"] = "Talasite instable",				["d"] = "Vendeur, 40 Eclat apogide (Les Tranchantes)"},
	[32640] = {["n"] = "Diamant instable tout-puissant",		["d"] = "Vendeur, 160 Eclat apogide (Les Tranchantes)"},
	[32641] = {["n"] = "Diamant instable imprégné",	["d"] = "Vendeur, 160 Eclat apogide (Les Tranchantes)"},

	-- Added in Gem Helper v1.3
	-- The following gems are crafted from epic gem drops in Black Temple/Hyjal
	[32193] = {["n"] = "Spinelle cramoisi soutenu",					["d"] = "Crafté, 1 Spinelle cramoisi"},
	[32194] = {["n"] = "Spinelle cramoisi délicat",				["d"] = "Crafté, 1 Spinelle cramoisi"},
	[32195] = {["n"] = "Larme de spinelle cramoisi",				["d"] = "Crafté, 1 Spinelle cramoisi"},
	[32196] = {["n"] = "Spinelle cramoisi runique",					["d"] = "Crafté, 1 Spinelle cramoisi"},
	[32197] = {["n"] = "Spinelle cramoisi éclatant",				["d"] = "Crafté, 1 Spinelle cramoisi"},
	[32198] = {["n"] = "Spinelle cramoisi subtil",					["d"] = "Crafté, 1 Spinelle cramoisi"},
	[32199] = {["n"] = "Spinelle cramoisi miroitant",				["d"] = "Crafté, 1 Spinelle cramoisi"},
	[32200] = {["n"] = "Saphir empyréen solide",				["d"] = "Crafté, 1 Saphir empyréen"},
	[32201] = {["n"] = "Saphir empyréen étincelant",			["d"] = "Crafté, 1 Saphir empyréen"},
	[32202] = {["n"] = "Saphir empyréen satiné",			["d"] = "Crafté, 1 Saphir empyréen"},
	[32203] = {["n"] = "Saphir empyréen orageuse",				["d"] = "Crafté, 1 Saphir empyréen"},
	[32204] = {["n"] = "Oeil de lion brillant",					["d"] = "Crafté, 1 Oeil de lion"},
	[32205] = {["n"] = "Oeil de lion lisse",					["d"] = "Crafté, 1 Oeil de lion"},
	[32206] = {["n"] = "Oeil de lion rigide",					["d"] = "Crafté, 1 Oeil de lion"},
	[32207] = {["n"] = "Oeil de lion resplendissant",				["d"] = "Crafté, 1 Oeil de lion"},
	[32208] = {["n"] = "Oeil de lion bombé",					["d"] = "Crafté, 1 Oeil de lion"},
	[32209] = {["n"] = "Oeil de lion mystique",					["d"] = "Crafté, 1 Oeil de lion"},
	[32210] = {["n"] = "Oeil de lion grande",					["d"] = "Crafté, 1 Oeil de lion"},
	[32211] = {["n"] = "Améthyste chantelombre souverain",			["d"] = "Crafté, 1 Améthyste chantelombre"},
	[32212] = {["n"] = "Améthyste chantelombre changeante",			["d"] = "Crafté, 1 Améthyste chantelombre"},
	[32213] = {["n"] = "Améthyste chantelombre équilibrée",	["d"] = "Crafté, 1 Améthyste chantelombre"},
	[32214] = {["n"] = "Améthyste chantelombre infusée",		["d"] = "Crafté, 1 Améthyste chantelombre"},
	[32215] = {["n"] = "Améthyste chantelombre luminescente",		["d"] = "Crafté, 1 Améthyste chantelombre"},
	[32216] = {["n"] = "Améthyste chantelombre royale",			["d"] = "Crafté, 1 Améthyste chantelombre"},
	[32217] = {["n"] = "Pyrolithe intaillée",				["d"] = "Crafté, 1 Pyrolithe"},
	[32218] = {["n"] = "Pyrolithe toute-puissante",					["d"] = "Crafté, 1 Pyrolithe"},
	[32219] = {["n"] = "Pyrolithe lumineuse",					["d"] = "Crafté, 1 Pyrolithe"},
	[32220] = {["n"] = "Pyrolithe luisante",					["d"] = "Crafté, 1 Pyrolithe"},
	[32221] = {["n"] = "Pyrolithe voilée",					["d"] = "Crafté, 1 Pyrolithe"},
	[32222] = {["n"] = "Pyrolithe pernicieuse",					["d"] = "Crafté, 1 Pyrolithe"},
	[32223] = {["n"] = "Emeraude d'écume durcie",				["d"] = "Crafté, 1 Emeraude d'écume"},
	[32224] = {["n"] = "Emeraude d'écume radieuse",				["d"] = "Crafté, 1 Emeraude d'écume"},
	[32225] = {["n"] = "Emeraude d'écume éblouissante",		["d"] = "Crafté, 1 Emeraude d'écume"},
	[32226] = {["n"] = "Emeraude d'écume dentelée",			["d"] = "Crafté, 1 Emeraude d'écume"},

	-- Added in Gem Helper v1.4
	[33131] = {["n"] = "Soleil cramoisi",			["d"] = "Crafté, 1 Rubis vivant"},
	[33133] = {["n"] = "Coeur de don Julio",		["d"] = "Crafté, 1 Rubis vivant"},
	[33134] = {["n"] = "Rose de Kailee",			["d"] = "Crafté, 1 Rubis vivant"},
	[33135] = {["n"] = "Etoile filante",			["d"] = "Crafté, 1 Etoile d'Elune"},
	[33140] = {["n"] = "Sang d'ambre",			["d"] = "Crafté, 1 Pierre d'aube"},
	[33143] = {["n"] = "Pierre des lames",			["d"] = "Crafté, 1 Pierre d'aube"},
	[33144] = {["n"] = "Facette d'éternité",	["d"] = "Crafté, 1 Pierre d'aube"},
	[33782] = {["n"] = "Talasite stable",			["d"] = "Crafté, 1 Talasite"},

	-- Added in Gem Helper v1.41 (patch 2.2.2)
	[31862] = {["n"] = "Draénite ombreuse équilibrée",		["d"] = "Crafté, 1 Draénite ombreuse"},
	[31860] = {["n"] = "Grande draénite dorée",	["d"] = "Crafté, 1 Draénite dorée"},
	[31864] = {["n"] = "Draénite ombreuse infusée",		["d"] = "Crafté, 1 Draénite ombreuse"},
	[31866] = {["n"] = "Spessarite de flamme voilée",		["d"] = "Crafté, 1 Spessarite de flamme"},
	[31869] = {["n"] = "Spessarite de flamme pernicieuse",		["d"] = "Crafté, 1 Spessarite de flamme"},

	-- Added in Gem Helper v1.5 (patch 2.3.0)
	[34220] = {["n"] = "Diamant brûleciel chaotique",	["d"] = "Crafté, 1 Diamant brûleciel"},
	[34256] = {["n"] = "Joyau d'amani charmé",	["d"] = "Récompense Quête - Zul'Aman"},

	-- Added in Gem Helper v1.6 (patch 2.4.0)
	[35503] = {["n"] = "Diamant brûleciel brasillé",	["d"] = "Crafté, 1 Diamant brûleciel"},
	[35501] = {["n"] = "Diamant tonneterre éternel",	["d"] = "Crafté, 1 Diamant tonneterre"},
	[35707] = {["n"] = "Oeil de nuit régalien",			["d"] = "Crafté, 1 Oeil de nuit"},
	[34831] = {["n"] = "Oeil de la mer",	["d"] = "Récompense Quête - Fishing Daily"},
	[35758] = {["n"] = "Emeraude d'écume stable",		["d"] = "Crafté, 1 Emeraude d'écume"},
	[35759] = {["n"] = "Emeraude d'écume énergique",		["d"] = "Crafté, 1 Emeraude d'écume"},
	[35760] = {["n"] = "Pyrolithe téméraire",			["d"] = "Crafté, 1 Pyrolithe"},
	[35761] = {["n"] = "Oeil de lion rapide",		["d"] = "Crafté, 1 Oeil de lion"},

	-- Added in Gem Helper v1.7 (patch 2.4.2)
	[37503] = {["n"] = "Purified Shadowsong Amethyst",		["d"] = "Crafté, 1 Améthyste chantelombre"},
	[35315] = {["n"] = "Pierre d'aube rapide",		["d"] = "Crafté, 1 Pierre d'aube"},
	[35316] = {["n"] = "Topaze noble téméraire",			["d"] = "Crafté, 1 Topaze noble"},
	[35318] = {["n"] = "Talasite énergique",		["d"] = "Crafté, 1 Talasite"},
}

end
