﻿local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Tracker")
L:RegisterTranslations("deDE", function() return {
	["Tracker"] = "Questüberwachung",
	["Autowatch"] = "Autoüberwachen",
	["Automatically add quests to the tracker when appropriate"] = "Automatisch ein Quest zur Questüberwachung hinzufügen wenn genug Platz ist.",
	["Use own tracker"] = "Benutze eigenes Questdetail Fenster",
	["Replace the default quest tracker with a slightly more featureful one"] = "Zeigt die Questdetails in dem erweiterten Fenster von QuestFu.",
	["Login"] = "Login",
	["Re-add quests you were watching before you logged out"] = "Wieder hinzufügen von Quest die Überwacht wurden bevor du ausgeloggt bist.",
	["Zone"] = "Zone",
	["Add quests to the tracker when you enter their zone"] = "Quests zur Questüberwachung hinzufügen wenn du die Questzone betrittst.",
	["Subzone"] = "Unterzone",
	["Add quests to the tracker when you enter their subzone"] = "Quests zur Questüberwachung hinzufügen wenn du die Unterzone betrittst.",
	["Gained"] = "Bei Erhalt",
	["Add quests to the tracker when they are first gained"] = "Quest zur Questüberwachung hinzüfügen bei erhalt der Quest.",
	["Progress"] = "Bei Fortschritt",
	["Add quests to the tracker when you make progress on them"] = "Quest zur Questüberwachung hinzufügen bei Fortschritt in der Quest.",
	["Remove completed"] = "Entferne Vollendet",
	["Remove quests from the tracker when you complete their objectives"] = "Entferne Quest aus der Questüberwachung, wenn ihre Quest-Ziele vollendet wurden.",
} end)
