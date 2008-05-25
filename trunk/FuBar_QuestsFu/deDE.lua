﻿local L = AceLibrary("AceLocale-2.2"):new("QuestsFu")

L:RegisterTranslations("deDE", function() return {
	["(done)"] = "(Fertig)",
	["(failed)"] = "(Fehlgeschlagen)",

	["Toggle whether the %s module is active"] = "Bestimmt ob das %s Modul aktiv ist.",
	["Modules"] = "Module",
	["Toggle whether the %s module is active"] = "Bestimmt ob das %s Modul aktiv ist.",

	["Strata"] = "Strata",
	["Adjust the strata of this panel (takes effect after you reload your UI)"] = "Stell die Höhenebene dieses Fensters ein. (Jeh nach eingestellten Wert werden andere UI/Addonfenster darüber oder darunter angezeigt werden - diese Option wird erst aktiv wenn das UI neu geladen wurde)",
	["Max height"] = "Max H\195\182he",
	["Adjust the maximum height of this panel, in pixels (takes effect after you reload your UI)"] = "Stellt die Maximale H\195\182he dieses Panels ein, in Pixel (wird aktiv nachdem du dein UI neugeladen hast).",
	["Minimum width"] = "Min Breite",
	["Adjust the minimum width of this panel, in pixels (takes effect after you reload your UI)"] = "Stellt die Minimale Breite dieses Panels ein, in Pixel (wird aktiv nachdem du dein UI neugeladen hast).",

	["Lock"] = "Sperren",
	["Lock or unlock this panel"] = "Sperre oder entsperre das Fenster.",

	TOOLTIP_HINT = "Klicken um Questlog zu öffnen\nShift-Klick um Quest in das Chateingabefeld einzufügen\nShift-Strg-Klick um die Missions Aufgaben in das Chateingabefeld einzufügen\nAlt-Klick um Quest zur Questverfolgung hinzuzufügen",
	["FuBar Tablet"] = "FuBar Block",
	["Settings for the main FuBar tablet"] = "Einstellungen für den FuBar Block.",
	["Show"] = "Zeige",
	["Choose what information to display"] = "Wähle aus welche Informationen Angezeigt werden sollen.",
	["Text"] = "Text",
	["Toolbar text"] = "Hilfsleisten Text.",
	["Current"] = "Gegenwärtig",
	["Show current # of quests"] = "Zeige gegenwärtige # von Quest's.",
	["Completed"] = "Abgeschlossen",
	["Show # of quests completed"] = "Zeige # von abgeschlossenen Quest's.",
	["Total"] = "Gesammt",
	["Show total possible quests"] = "Zeige maximal mögliche Quest's.",
	["Last message"] = "Letzte Nachricht",
	["Show last quest status message"] = "Zeige die letzte Queststatus Nachricht.",
	["Levels"] = "Levels",
	["Show quest levels"] = "Zeige die Quest Level.",
	["In QuestsFu"] = "In QuestFu",
	["Show quest levels in the QuestsFu tooltip"] = "Zeige Questlevel im QuestFu Tooltip.",
	["Zone"] = "Zone",
	["Show zone levels in the QuestsFu tooltip"] = "Zeige Zonen Level im QuestFu Tooltip.",
	["Impossible quests"] = "Unmögliche Quests",
	["Show impossible (red) quests"] = "Zeige unmögliche (rote) Quests.",
	["Show quest zones"] = "Zeige Quest Zonen.",
	["Current area only"] = "Nur gegenwärtige Zone",
	["Only show quests for the current zone"] = "Zeige nur Quests für die gegenwärtige Zone.",
	["Class quests always"] = "Immer Klassenquests",
	["Always show class quests"] = "Immer Klassenquests anzeigen.",
	["Details"] = "Deteils",
	["Show quest details"] = "Zeige Questdetails.",
	["Current area details only"] = "Nur gegenwärtige Bereich Details",
	["Show details for current area quests only"] = "Zeige nur Deteils für die gegenwärtigen Bereichsquest's.",
	["Completed objectives"] = "Fertiggestellte Missions Aufgaben",
	["Show completed objectives"] = "Zeige fertiggestellte Missions Aufgaben.",
	["Objectives"] = "Misssions Aufgaben",
	["Color objective completion status"] = "Färbe Misssions Aufgaben anhand des fortschritts.",
	["Wrap quest titles"] = "Breche Quest Namen",
	["Wrap long quest titles on to multiple lines"] = "Breche lange Questnamen in mehrere Zeilen.",

	["Color zone names by suggested level"] = "Färbe Zonennamen nach vorgeschlagenen Level.",
	["Color"] = "Einfärben",
	["Color settings"] = "Farben Einstellungen.",
	["Title"] = "Titel",
	["Color the quest title by difficulty"] = "Färbe den Quest Namen nach Schwierigkeitsgrad.",
	["Level"] = "Level",
	["Color the quest level by difficulty"] = "Färbe den Quest Level nach Schwierigkeitsgrad.",

	["Colors"] = "Farben",
	["Choose custom colors"] = "Farbschema w\195\164hlen.",
	["Difficulty"] = "Schwierigkeit",
	["Trivial"] = "Trivial",
	["Standard"] = "Normal",
	["Difficult"] = "Schwer",
	["Very difficult"] = "Sehr Schwer",
	["Impossible"] = "Unmöglich",
	["Header"] = "\195\156berschrift",
	["Completion"] = "Abschluss",
	["Not started"] = "Nicht angefangen",
	["Underway"] = "Im Gange",
	["Done"] = "Fertig",
	["Other"] = "Andere",
} end)
