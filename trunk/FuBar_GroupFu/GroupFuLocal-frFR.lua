local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("frFR", function() return {
	["Solo"] = "Solo",
	group = "Butin de groupe",
	master = "Responsable du butin",
	freeforall = "Accès libre",
	roundrobin = "Chacun son tour",
	needbeforegreed = "Besoin avant Cupidité",
	-- ["ML (%s)"] = "ML (%s)",
	["No rolls"] = "Pas de jet de dés",

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = "Jet de dés finit dans 5 secondes, enregistré %d jet sur %d.",

	["Winner: %s."] = "Gagnant: %s.",
	["Tie: %s are tied at %d."] = "Egalité : %s sont à égalité à %d.",
	-- ["%s (%d/%d)"] = "%s (%d/%d)",
	-- ["%s [%s]"] = "%s [%s]",
	["%d of expected %d rolls recorded."] = "%d jets enregistrés sur %d attendus.",

	["Perform roll when clicked"] = "Cliquez pour lancer les dès",
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = "Réalise un jet 1-100 standard quand le plugin Fubar est cliqué.",
	["Announce"] = "Annonce",
	["Only accept 1-100"] = "Accepte seulement des jets 1-100",
	["Accept standard (1-100) rolls only."] = "Accepte seulement des jets standards (1-100)",
	["Loot type"] = "Type de Butin",
	["Set the loot type."] = "Configure le type de butin.",
	["Loot threshold"] = "Seuil du Butin",
	["Set the loot threshold."] = "Configure le seuil du butin.",

	["Where to output roll results."] = "Où indiquez les résultats du jet.",
	["Auto (based on group type)"] = "Auto (basé sur le type de groupe)",
	["Local"] = "Local",
	["Say"] = "Dire",
	["Party"] = "Groupe",
	["Raid"] = "Raid",
	["Guild"] = "Guilde",
	["Don't announce"] = "Ne pas annoncer",

	["Roll clearing"] = "Effacement des jets",
	["When to clear the rolls."] = "Quand la liste des jets est effacée.",
	["Never"] = "Jamais",
	["15 seconds"] = "15 secondes",
	["30 seconds"] = "30 secondes",
	["45 seconds"] = "45 secondes",
	["60 seconds"] = "60 secondes",

	["Roll"] = "Jet",
	["Player"] = "Joueur",
	["Loot method"] = "Méthode de Butin",
	["Master looter"] = "Chef du Butin",
	["Leader"] = "Chef",
	["Officers"] = "Officiers",
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fClic|r pour faire un jet, |cffeda55fCtrl-Clic|r pour indiquer le gagnant, |cffeda55fShift-Clic|r pour effacer le liste.",
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fCtrl-Clic|r pour indiquer le gagnant, |cffeda55fShift-Clic|r pour effacer le liste.",

	["Pass"] = "Passer",
	["Everyone passed."] = "Tout le monde a passé.",

	--["Leave Party"] = true,
	--["Leave your current party or raid."] = true,

	--["Reset Instances"] = true,
	--["Reset all available instance the group leader has active."] = true,
} end)

