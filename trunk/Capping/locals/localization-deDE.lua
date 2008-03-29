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
	["Enable"] = "Aktivieren",
	["Auto quest turnins"] = "Autom. Questabgabe",
	["Enable Alterac Valley automatic quest turnins"] = "Automatische Questabgabe im Alteractal aktivieren",
	["Bar"] = "Leiste",
	["Statusbar options"] = "Optionen Statusleiste",
	["Font size"] = "Schriftgr\195\182\195\159e",
	["Change statusbar font size"] = "Die Schriftgr\195\182\195\159e der Statusleiste \195\164ndern",
	["Width"] = "Breite",
	["Change statusbar width"] = "Die Breite der Statusleiste \195\164ndern",
	["Height"] = "H\195\182he",
	["Change statusbar thickness"] = "Die Dicke der Statusleiste \195\164ndern",
	["Scale"] = "Skalierung",
	["Change statusbar scale"] = "Die Skalierung der Statusleiste \195\164ndern",
	["Texture"] = "Textur",
	["Statusbar textures"] = "Die Textur der Statusleiste",
	["Other"] = "Anderes",
	["Other options"] = "Weitere Optionen",
	["Auto show map"] = "Karte autom. anzeigen",
	["Auto show the battlefield minimap on entry"] = "Die Schlachtfeld-Minikarte beim Betreten automatisch anzeigen",
	["Map scale"] = "Kartenskalierung",
	["Hide border"] = "Rahmen ausblenden",
	["Change the default scale of the battlefield minimap"] = "Die Standardskalierung der Schlachtfeld-Minikarte \195\164ndern",
	["Port Timer"] = "Port-Timer",
	["Enable timers for port expiration"] = "Die Timer f\195\188r den Port-Ablauf aktivieren",
	["Wait Timer"] = "Wartezeit Timer",
	["Enable timers for queue wait time"] = "Die Timer f\195\188r BG-Warteschlangen aktivieren",
	["Show/Hide Anchor"] = "Anker anzeigen/verstecken",
	["Show/Hide the bars anchor (can also left-click a statusbar)"] = "Den Leistenanker anzeigen/verstecken (auch mit Linksklick auf Statusleiste)",
	["Toggle class color"] = "Klassenfarbe an/aus",
	["Enable/disable class color indicators on the scoreboard"] = "Die Klassenfarbe auf dem Scoreboard aktivieren/deaktivieren",
	["Narrow map mode"] = "Karte verkleinern",
	["Narrow the battlefield minimap, removing some empty space"] = "Verkleinern der Schlachtfeld-Minikarte (entfernt leeren Raum)",
	["Test"] = "Test",
	["Start a test bar"] = "Testleisten starten",
	["Reverse fill"] = "F\195\188llung umkehren",
	["Set statusbars to fill up instead of depleting"] = "Die Statusleisten f\195\188llen sich aufw\195\164rts (nach rechts), nicht umgekehrt (nach links)",
	["Flip growth"] = "Anstieg umdrehen",
	["Set objective timers to grow up and misc timers to grow down"] = "Richtet die Ziel-Timer nach oben, und die Misc-Timer nach unten aus",
	["Reposition Scoreboard"] = "Scoreboard repositionieren",
	["Move the scoreboard to the Capping anchor's CURRENT position"] = "Richtet das Scoreboard am AKTUELLEN Anker von Capping neu aus",
	["Battlefield Minimap"] = "Schlachtfeld-Minikarte",
	["Options for the battlefield minimap"] = "Optionen f\195\188r die Schlachtfeld-Minikarte",
	["Colors"] = "Farben",
	["Icons"] = "Symbole",
	["Bar icons display options"] = "Anzeigeoptionen der Leistensymbole",
	["Spacing"] = "Abstand",
	["Request sync"] = "Synchronisation anfragen",
	["LEFT"] = "LINKS",
	["RIGHT"] = "RECHTS",
	["HIDE"] = "VERSTECKEN",

	-- etc timers
	["Port: %s"] = "Port: %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "Warteschlange: %s",
	["Battleground Begins"] = "Schlachtfeld beginnt", -- bar text for bg gates opening
	["1 minute"] = "1 Minute",
	["30 seconds"] = "30 Sekunden",
	["One minute until"] = "Eine Minute bis",
	["Thirty seconds until"] = "Drei\195\159ig Sekunden bis",
	["Fifteen seconds until"] = "F\195\188nfzehn Sekunden bis",
	["%s: %s - %d:%02d remaining"] = "%s: %s - %d:%02d verbleibend", -- chat message after shift left-clicking a bar

	-- AB	
	["Bases: (%d+)  Resources: (%d+)/2000"] = "Basen: (%d+)  Ressourcen: (%d+)/2000", -- arathi basin scoreboard
	["Farm"] = "Hof",
	["Lumber Mill"] = "S\195\164gewerk",
	["Blacksmith"] = "Schmiede",
	["Mine"] = "Mine",
	["Stables"] = "St\195\164lle",
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
	["Flag respawns"] = "Die Flaggen werden jetzt wieder an ihren St\195\188tzpunkten aufgestellt.",
	["%s's flag carrier: %s (%s)"] = "%s's Flaggentr\195\164ger: %s (%s)",

	-- AV
	 -- NPC
	["Smith Regzar"] = "Schmied Regzar",
	["Murgot Deepforge"] = "Murgot Tiefenschmied",
	["Primalist Thurloga"] = "Primalistin Thurloga",
	["Arch Druid Renferal"] = "Erzdruide Renferal",
	["Stormpike Ram Rider Commander"] = "Kommandant der Sturmlanzenwidderreiter",		
	["Frostwolf Wolf Rider Commander"] = "Wolfsreiterkommandant der Frost\195\182lfe", 

	-- patterns
	["avunderattack"] = "(.+) wird angegriffen.*wird die ",
	["avtaken"] = "(.+) wurde von der (.+) erobert",
	["avdestroyed"] = "(.+) wurde von der (.+) zerst\195\182rt",
	--["The "] = "Der ", --	 === NEEDS TO BE CHECKED ===
	["Snowfall Graveyard"] = "Schneewehenfriedhof",
	["Tower"] = "Turm",
	["Bunker"] = "Bunker",
	--["Upgrade to"] = "Upgrade to", -- the option to upgrade units in AV	 === NEEDS TO BE CHECKED ===
	["Wicked, wicked, mortals!"] = "B\195\182se, b\195\182se sterbliche Wesen!", -- what Ivus says after being summoned
	["Ivus begins moving"] = "Ivus setzt sich in Bewegung",
	["WHO DARES SUMMON LOKHOLAR"] = "WER WAGT ES, LOKHOLAR ZU BESCHW\195\150REN", -- what Lok says after being summoned
	["The Ice Lord has arrived!"] = "Der Eislord ist da!",
	["Lokholar begins moving"] = "Lokholar setzt sich in Bewegung",

	-- EotS
	["^(.+) has taken the flag!"] = "^(.+) hat die Fahne erobert!",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "Basen: (%d+)  Siegespunkte: (%d+)/2000",
})