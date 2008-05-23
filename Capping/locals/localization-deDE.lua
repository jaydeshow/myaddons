if GetLocale() ~= "deDE" then return end

-- de translations provided by Farook
CappingLocale:CreateLocaleTable({
	-- battlegrounds
	["Alterac Valley"] = "Alteractal", 
	["Arathi Basin"] = "Arathibecken", 
	["Warsong Gulch"] = "Kriegshymnenschlucht",
	["Arena"] = "Arena",
	["Eye of the Storm"] = "Auge des Sturms",
	
	-- factions
	["Alliance"] = "Allianz",
	["Horde"] = "Horde",

	-- options menu
	["Auto quest turnins"] = "Autom. Questabgabe",
	["Bar"] = "Leiste",
	["Width"] = "Breite",
	["Height"] = "Höhe",
	["Texture"] = "Textur",
	["Other"] = "Anderes",
	["Other options"] = "Weitere Optionen",
	["Auto show map"] = "Karte autom. anzeigen",
	["Map scale"] = "Kartenskalierung",
	["Hide border"] = "Rahmen ausblenden",
	["Port Timer"] = "Port Timer",
	["Wait Timer"] = "Wartezeit Timer",
	["Show/Hide Anchor"] = "Anker anzeigen/verstecken",
	["Narrow map mode"] = "Karte verkleinern",
	["Test"] = "Test",
	["Flip growth"] = "Anstieg umdrehen",
	["Reposition Scoreboard"] = "Scoreboard repositionieren",
	["Battlefield Minimap"] = "Schlachtfeld-Minikarte",
	["Icons"] = "Symbole",
	["Spacing"] = "Abstand",
	["Request sync"] = "Synchronisation anfragen",
	["LEFT"] = "LINKS",
	["RIGHT"] = "RECHTS",
	["HIDE"] = "VERSTECKEN",
	["Fill grow"] = "Füllung anwachsend",
	["Fill right"] = "Füllung nach rechts",
	["Font"] = "Schriftart",
	["Time position"] = "Zeitposition",
	["Border width"] = "Randbreite",
	["Send to BG"] = "Zum SCHLACHTFELD senden",
	["Or <Ctrl-left-click> a timer"] = "...oder <Strg-Linksklick> auf einen Timer",
	["Send to SAY"] = "Zu SAGEN senden",
	["Or <Shift-left-click> a timer"] = "...oder <Shift-Linksklick> auf einen Timer",
	["Cancel timer"] = "Timer abbrechen",
	["Or <Ctrl-right-click> a timer"] = "...oder <Strg-Rechtsklick> auf einen Timer",
	["Reposition Capture Bar"] = "Fortschrittsleiste repositionieren",

	-- etc timers
	["Port: %s"] = "Port: %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "Warteschlange: %s",
	["Battleground Begins"] = "Schlachtfeld beginnt", -- bar text for bg gates opening
	["2 minutes"] = "2 Minuten",
	["1 minute"] = "1 Minute",
	["30 seconds"] = "30 Sekunden",
	["One minute until"] = "Eine Minute bis",
	["Thirty seconds until"] = "Dreißig Sekunden bis",
	["Fifteen seconds until"] = "Fünfzehn Sekunden bis",
	["%s: %s - %d:%02d remaining"] = "%s: %s - %d:%02d verbleibend", -- chat message after shift left-clicking a bar

	-- AB
	["Bases: (%d+)  Resources: (%d+)/2000"] = "Basen: (%d+)  Ressourcen: (%d+)/2000", -- arathi basin scoreboard
	["Farm"] = "Hof",
	["Lumber Mill"] = "Sägewerk",
	["Blacksmith"] = "Schmiede",
	["Gold Mine"] = "Goldmine",
	["Stables"] = "Ställe",
	["Southern Farm"] = "Südlicher Hof",
	["Mine"] = "Mine",
	["has assaulted"] = "angegriffen!",
	["claims the"] = "besetzt!",
	["has taken the"] = "eingenommen!",
	["has defended the"] = "verteidigt!",
	["Final: 2000 - %d"] = "Endstand: 2000 - %d", -- final score text
	["wins 2000-%d"] = "siegt 2000-%d", -- final score chat message

	-- WSG
	["was picked up by (.+)!"] = "(.+) hat die Flagge der (%a+) aufgenommen!",
	["dropped"] = "fallen lassen!",
	["captured the"] = "errungen!",
	["Flag respawns"] = "Die Flaggen werden jetzt wieder an ihren Stützpunkten aufgestellt.",
	["%s's flag carrier: %s (%s)"] = "%s's Flaggenträger: %s (%s)",

	-- AV
	 -- NPC
	["Smith Regzar"] = "Schmied Regzar",
	["Murgot Deepforge"] = "Murgot Tiefenschmied",
	["Primalist Thurloga"] = "Primalistin Thurloga",
	["Arch Druid Renferal"] = "Erzdruide Renferal",
	["Stormpike Ram Rider Commander"] = "Kommandant der Sturmlanzenwidderreiter",		
	["Frostwolf Wolf Rider Commander"] = "Wolfsreiterkommandant der Frostwölfe", 

	 -- patterns
	["avunderattack"] = "(.+) wird angegriffen.*wird die ",
	["avtaken"] = "(.+) wurde von der (.+) erobert",
	["avdestroyed"] = "(.+) wurde von der (.+) zerstört",
	["The "] = "", --	empty string because of different articles in german language
	["Snowfall Graveyard"] = "Schneewehenfriedhof",
	["Tower"] = "Turm",
	["Bunker"] = "Bunker",
	--["Upgrade to"] = "Upgrade to", -- the option to upgrade units in AV	 === NEEDS TO BE CHECKED ===
	["Wicked, wicked, mortals!"] = "Böse, böse sterbliche Wesen!", -- what Ivus says after being summoned
	["Ivus begins moving"] = "Ivus setzt sich in Bewegung",
	["WHO DARES SUMMON LOKHOLAR"] = "WER WAGT ES, LOKHOLAR ZU BESCHWÖREN", -- what Lok says after being summoned
	["The Ice Lord has arrived!"] = "Der Eislord ist da!",
	["Lokholar begins moving"] = "Lokholar setzt sich in Bewegung",


	-- EotS
	["^(.+) has taken the flag!"] = "^(.+) hat die Fahne erobert!",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "Basen: (%d+)  Siegespunkte: (%d+)/2000",
})