local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_PlayerNotify")
L:RegisterTranslations("deDE", function() return {
	["Player status"] = "Spieler Benachrichtigung",
	["Report on player quest status"] = "Benachrichtige wenn der Spieler, Ziele seiner Quests erfüllt.",
	["Quest Completion"] = "Quest Abschluss",
	["Notify of quest completion"] = "Benachrichtigen bei Quest Abschluss.",
	["Objective Completion"] = "Aufgaben Abschluss",
	["Notify of individual objective completion"] = "Benachrichtigen bei Aufgaben innerhalb einer Quest die Abgeschlossen werden.",
	["Objective Progress"] = "Aufgaben Fortschritt",
	["Notify of any progress on an objective"] = "Benachrichtigung bei Fortschritt innerhalb einer Aufgabe.",
	["Show quest names"] = "Questnamen Anzeigen",
	["Show the names of quests in output"] = "Questnamen mit Anzeigen bei der Ausgabe.",
	["Suppress Blizzard output"] = "Blizzard Nachrichten unterdrücken",
	["Hide quest messages that would display in the UIErrorsFrame"] = "Verhindert das Anzeigen der Blizzard eigenen Questnachrichten im Blizzard's UIErrrorFenster.",
} end)
