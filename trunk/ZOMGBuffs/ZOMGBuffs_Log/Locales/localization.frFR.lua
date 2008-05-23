local L = LibStub("AceLocale-2.2"):new("ZOMGLog")

L:RegisterTranslations("frFR", function() return {
	["Log"] = "Journal",
	["Event Logging"] = "Journalisation des évènements",
	["Open"] = "Ouvrir",
	["View the log"] = "Voir le journal",
	["Clear"] = "Vider",
	["Clear the log"] = "Vider le journal",
	["Behaviour"] = "Comportement",
	["Log behaviour"] = "Comportement du journal",
	["Merge"] = "Fusionner",
	["Merge similar entries within 15 seconds. Avoids confusion with cycling through buffs to get to desired one giving multiple log entries."] = "Fusionne les entrées similaires sur 15s successive. Evite les problèmes de confusion avec les cycles de buffs afin d'obtenir le buff désiré.",

	["Generated automatic template"] = "Génération automatique du modèle",
	["%s %s's template - %s from %s to %s"] = "%s Modèle de %s - %s de %s à %s",
	["%s %s's exception - %s from %s to %s"] = "%s Exception de %s - %s de %s à %s",
	["Remotely changed"] = "Changé à distance",
	["Changed"] = "Changé",
	["Cleared %s's exceptions for %s"] = "Exception de %s vidé pour %s",

	["Changed %s's template - %s from %s to %s"] = "Modèle de %s modifié - %s de %s à %s",
	["Changed %s's exception - %s from %s to %s"] = "Exception de %s modifié - %s de %s à %s",
	["Loaded template '%s'"] = "Modèle '%s' chargé",
	["Saved template '%s'"] = "Modèle '%s' sauvegardé",
} end)
