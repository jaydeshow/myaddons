local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("deDE", function() return {
	["Solo"] = "Solo",
	group = "Gruppe",
	master = "Plündermeister",
	freeforall = "Jeder gegen Jeden",
	roundrobin = "Reihum",
	needbeforegreed = "Bedarf vor Gier",
	["ML (%s)"] = "PM (%s)",
	["No rolls"] = "Keine Würfe",

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = "Würfeln endet in 5 Sekunden, registriert %d aus erwarteten %d Würfen.",

	["Winner: %s."] = "Gewinner: %s.",
	["Tie: %s are tied at %d."] = "Unentschieden: %s haben ein Unentschieden mit jeweils einer %d.",
	["%s (%d/%d)"] = "%s (%d/%d)",
	["%s [%s]"] = "%s [%s]",
	["%d of expected %d rolls recorded."] = "%d aus erwarteten %d Würfen registriert.",

	["Perform roll when clicked"] = "Durch Anklicken würfeln",
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = "Einen Standart 1-100 Wurf ausführen wenn auf das FuBar Plugin geklickt wird.",
	["Announce"] = "Ankündigen",
	["Only accept 1-100"] = "Nur 1-100 akzeptieren",
	["Accept standard (1-100) rolls only."] = "Nur Standard (1-100) Würfe akzeptieren",
	["Loot type"] = "Loot Typ",
	["Set the loot type."] = "Stellt den Loot Typ ein.",
	["Loot threshold"] = "Plündern Schwelle",
	["Set the loot threshold."] = "Plündern Schwelle ändern.",

	["Where to output roll results."] = "Wo das Ergebnis ausgegeben wird.",
	["Auto (based on group type)"] = "Automatisch (basierend auf dem gegenwärtigen gruppentyp)",
	["Local"] = "Lokal",
	["Say"] = "Sagen",
	["Party"] = "Gruppe",
	["Raid"] = "Schlachtgruppe",
	["Guild"] = "Gilde",
	["Don't announce"] = "Ergebnisse nicht ankündigen",

	["Roll clearing"] = "Verwerfen der Würfe",
	["When to clear the rolls."] = "Wann die Würfe verworfen werden.",
	["Never"] = "Nie",
	["15 seconds"] = "15 Sekunden",
	["30 seconds"] = "30 Sekunden",
	["45 seconds"] = "45 Sekunden",
	["60 seconds"] = "60 Sekunden",

	["Roll"] = "Würfe",
	["Player"] = "Spieler",
	["Loot method"] = "Plündern Methode",
	["Master looter"] = "Plündermeister",
	["Leader"] = "Leiter",
	["Officers"] = "Offiziere",
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fKlicken|r um zu Würfeln, |cffeda55fStrg-Klick|r um Gewinner auszugeben, |cffeda55fShift-Klick|r um die Liste zu löschen.",
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fStrg-Klick|r um den Gewinner anzuzeigen, |cffeda55fShift-Klick|r um die Liste zu löschen.",

	["Pass"] = "Passe",
	["Everyone passed."] = "Alle haben gepasst",
	
	["Leave Party"] = "Gruppe verlassen",
	["Leave your current party or raid."] = "Verlasse die aktuelle Gruppe oder Raid",
	
	["Reset Instances"] = "Alle Instanzen zurücksetzen",
	["Reset all available instance the group leader has active."] = "Setzt alle Instanzen zurück, die für den Gruppenleiter aktiv sind",
	
} end)

