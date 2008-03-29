local L = AceLibrary("AceLocale-2.2"):new("FuBar_FactionsFu")

L:RegisterTranslations("frFR", function() return {
	TOOLTIP_HINT = "\n|cffeda55fCliquer|r pour changer la faction surveill\195\169e.\n|cffeda55fShift-Clique|r pour ins\195\169rer les donn\195\169es dans la boite de dialogue.\n|cffeda55fAlt-Clique|r pour sélectionner la faction comme faction de zone automatique pour cette zone.",
	
	["Text"] = "Texte",
	["Text Settings"] = "Formatage du texte",
	["Show Name"] = "Afficher le nom",
	["Toggles display of watched faction's name"] = "Affiche, ou non, le nom de la faction surveill\195\169e",
	["Show Standing"] = "Afficher l'alignement",
	["Toggles display of watched faction's current standing"] = "Affiche, ou non, votre alignement avec la faction surveill\195\169e",
	["Show Progress"] = "Afficher l'avancement",
	["Toggles display of watched faction's progress toward next standing"] = "Affiche, ou non, l'avancement jusqu'au prochain aligement avec la faction surveill\195\169e",
	["Show Progress (in percent)"] = "Afficher l'avancement (en pourcent)",
	["Toggles display of watched faction's progress toward next standing (in percent)"] = "Affiche, ou non, l'avancement jusqu'au prochain aligement avec la faction surveill\195\169e (en pourcent)",
	["Color"] = "Couleur",
	["Color Settings"] = "Param\195\169trage des couleurs",
	["Name"] = "Nom",
	["Sets color of the faction name"] = "Couleur du nom des factions",
	["Reputation"] = "R\195\169putation",
	["Sets color of the faction reputation"] = "Couleur de la r\195\169putation aupr\195\168s des factions",
	["standing"] = "Alignement",
	["Sets color of the faction standing"] = "Couleur de l'alignement aupr\195\168s des factions",
	["Other"] = "Autres",
	["Other Settings"] = "Autres param\195\168tres",
	["Auto-Zone"] = "Zone-automatique",
	["Toggles automatical adjustment of watched faction on zone change"] = "Selection automatique de la faction surveill\195\169e lors d'un changement de zone",
	["Auto-Gain"] = "Gain-automatqiue",
	["Toggles automatical adjustment of watched faction on faction gain"] = "Selection automatique de la faction surveill\195\169e lors d'un gain de r\195\169putation",

	["None"] = "Aucun",
	["War Condition"] = "En guerre",
	["Blizzard's Default"] = "Type Blizzard",
	["Incremental"] = "Incr\195\169mentale",
} end)
