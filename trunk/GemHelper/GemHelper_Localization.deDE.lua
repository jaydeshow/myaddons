-- German localization by
-- Naitsabes, Jenina (Lothar, EU), Cutter (Blackmoore, EU), kunda

if (GetLocale() == "deDE") then

GEMHELPER_VERSION_TEXT		= "Gem Helper v1.7"
GEMHELPER_DONE_TEXT		= "Fertig"

GEMHELPER_ERRORTOOLTIP_L1	= "Unsicherer Gegenstand"
GEMHELPER_ERRORTOOLTIP_L2	= "Gegenstand-ID: "
GEMHELPER_ERRORTOOLTIP_L3	= "Dieser Gegenstand ist unsicher. Um diesen Gegenstand sehen zu können ohne einen Verbindungsabbruch zu riskieren, musst Du ihn zunächst irgendwo im Spiel gesehen haben. Blizzard schreibt diese Einschränkung seit Patch 1.10 vor."
GEMHELPER_ERRORTOOLTIP_L4	= "Du kannst versuchen per Rechtsklick eine Anfrage an den Server zu senden. Dies kann zu einem Verbindungsabbruch führen."
GEMHELPER_QUERY_MESSAGE		= "Sende Anfrage an den Server für "

GEMHELPER_OPENJC_TEXT		= "Öffne/Schließe normales JS Handelsfenster."
GEMHELPER_CHANGEBGCOLOR_TEXT	= "Hintergrundfarbe ändern."

-- GEMHELPER_JEWELCRAFTING_TEXT must match the text written on the top of default Jewelcrafting UI
-- window, which should also be the same as the text written in your Character --> Skills -->
-- Professions panel because this string is used to check whether a player has Jewelcrafting as
-- a profession as well as whether the Jewelcrafting default UI window is about to be open.
--
-- GEMHELPER_JEWELCRAFTING_TEXT muss dem Text im original Berufsfenster und der Beschreibung
-- im Fenster Carakter -> Fertigkeiten -> Berufe entsprechen. Dieser Text wird abgefragt um
-- festzustellen ob der Spieler Juwelenschleifen gelernt hat und ob das original Berufsfenster
-- gerade geöffnet ist.
GEMHELPER_JEWELCRAFTING_TEXT	= "Juwelenschleifen"

GEMHELPER_CHECKBUTTON_TEXT	= {
	[1] = "Nach Farbe filtern",
	[2] = "Nach Material filtern",
	[3] = "Nach Eigenschaften filtern",

	[11] = "Blaue Steine",
	[12] = "Rote Steine",
	[13] = "Gelbe Steine",
	[14] = "Meta Steine",

	[21] = "Azurmondstein (B)",
	[22] = "Blutgranat (R)",
	[23] = "Golddraenit (G)",
	[24] = "Tiefenperidot (G/B)",
	[25] = "Flammenspessarit (G/R)",
	[26] = "Schattendraenit (R/B)",
	[27] = "Jaggalperle (R/B)",

	[31] = "Stern der Elune (B)",
	[32] = "Lebendiger Rubin (R)",
	[33] = "Dämmerstein (G)",
	[34] = "Talasit (G/B)",
	[35] = "Edeltopas (G/R)",
	[36] = "Nachtauge (R/B)",
	[37] = "Schattenperle (R/B)",

	[41] = "Himmelsfeuerdiamant (M)",
	[42] = "Erdsturmdiamant (M)",

	[51] = "Engelssaphir (B)",
	[52] = "Purpurspinell (R)",
	[53] = "Löwenauge (G)",
	[54] = "Gischtsmaragd (G/B)",
	[55] = "Pyrostein (G/R)",
	[56] = "Schattensangamet. (R/B)", -- Text zu lang / String too long: "Schattensangamethyst"

	[61] = "Stärke",
	[62] = "Beweglichkeit",
	[63] = "Ausdauer",
	[64] = "Intelligenz",
	[65] = "Willenskraft",
	[66] = "Abhärtungswertung",

	[70] = "Zaubertempowertung",
	[71] = "Trefferwertung",
	[72] = "Kritische Trefferwertung",
	[73] = "Angriffskraft",
	[74] = "Ausweichwertung",
	[75] = "Verteidigungswertung",
	[76] = "Parierwertung",

	[80] = "Zaubertrefferwertung",
	[81] = "Krit. Zaubertrefferw.", -- Text zu lang / String too long: "Kritische Zaubertrefferwertung"
	[82] = "Zauberdurchschlagskr.", -- Text zu lang / String too long: "Zauberdurchschlagskraft"
	[83] = "Zauberschaden",
	[84] = "Heilung",
	[85] = "Mana alle 5 Sek",
	[86] = "Alle Widerstandsarten",

	[101] = "Zeige Juwelenschleifer Steine",
	[1011] = "für vorhandenes Material",
	[1012] = "die %s herstellen kann",
	[102] = "Zeige Verzauberer Steine",
	[103] = "Zeige Händler Steine",
	[104] = "Zeige Instanzloot Steine",

	[111] = "Original UI ersetzen",
}

-- Data for German localization
GemHelper_GemLocaleData = {
	-- Herstellbar Uncommon Quality Gems
	[23095] = {["n"] = "Klobiger Blutgranat",				["d"] = "Herstellbar, 1 Blutgranat"},
	[28595] = {["n"] = "Heller Blutgranat",					["d"] = "Herstellbar, 1 Blutgranat"},
	[23113] = {["n"] = "Brilliantierter Golddraenit",			["d"] = "Herstellbar, 1 Golddraenit"},
	[23106] = {["n"] = "Schillernder Tiefenperidot",			["d"] = "Herstellbar, 1 Tiefenperidot (nur Sehen)"},
	[23097] = {["n"] = "Feingeschliffener Blutgranat",			["d"] = "Herstellbar, 1 Blutgranat"},
	[23105] = {["n"] = "Robuster Tiefenperidot",				["d"] = "Herstellbar, 1 Tiefenperidot"},
	[23114] = {["n"] = "Schimmernder Golddraenit",				["d"] = "Herstellbar, 1 Golddraenit"},
	[23100] = {["n"] = "Glitzernder Flammenspessarit",			["d"] = "Herstellbar, 1 Flame Spessarite"},
	[23108] = {["n"] = "Leuchtender Schattendraenit",			["d"] = "Herstellbar, 1 Schattendraenit"},
	[23098] = {["n"] = "Gravierter Flammenspessarit",			["d"] = "Herstellbar, 1 Flammenspessarit"},
	[23104] = {["n"] = "Gezackter Tiefenperidot",				["d"] = "Herstellbar, 1 Tiefenperidot"},
	[23099] = {["n"] = "Glänzender Flammenspessarit",			["d"] = "Herstellbar, 1 Flammenspessarit"},
	[23121] = {["n"] = "Irisierender Azurmondstein",			["d"] = "Herstellbar, 1 Azurmondstein"},
	[23101] = {["n"] = "Mächtiger Flammenspessarit",			["d"] = "Herstellbar, 1 Flammenspessarit"},
	[23103] = {["n"] = "Strahlender Tiefenperidot",				["d"] = "Herstellbar, 1 Tiefenperidot"},
	[23116] = {["n"] = "Massiver Golddraenit",				["d"] = "Herstellbar, 1 Golddraenit"},
	[23109] = {["n"] = "Königlicher Schattendraenit",			["d"] = "Herstellbar, 1 Schattendraenit (nur Aldor)"},
	[23096] = {["n"] = "Runenverzierter Blutgranat",			["d"] = "Herstellbar, 1 Blutgranat"},
	[23110] = {["n"] = "Unbeständiger Schattendraenit",			["d"] = "Herstellbar, 1 Schattendraenit"},
	[28290] = {["n"] = "Glatter Golddraenit",				["d"] = "Herstellbar, 1 Golddraenit"},
	[23118] = {["n"] = "Gediegener Azurmondstein",				["d"] = "Herstellbar, 1 Azurmondstein"},
	[23111] = {["n"] = "Stattlicher Schattendraenit",			["d"] = "Herstellbar, 1 Schattendraenit"},
	[23119] = {["n"] = "Funkelnder Azurmondstein",				["d"] = "Herstellbar, 1 Azurmondstein"},
	[23120] = {["n"] = "Stürmischer Azurmondstein",				["d"] = "Herstellbar, 1 Azurmondstein"},
	[23094] = {["n"] = "Tränenförmiger Blutgranat",				["d"] = "Herstellbar, 1 Blutgranat"},
	[23115] = {["n"] = "Kompakter Golddraenit",				["d"] = "Herstellbar, 1 Golddraenit"},

	-- Herstellbare Seltene Edelstein
	[24027] = {["n"] = "Klobiger lebendiger Rubin",				["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[24031] = {["n"] = "Heller lebendiger Rubin",				["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[24047] = {["n"] = "Brilliantierter Dämmerstein",			["d"] = "Herstellbar, 1 Dämmerstein"},
	[24065] = {["n"] = "Schillernder Talasit",				["d"] = "Herstellbar, 1 Talasit"},
	[24028] = {["n"] = "Feingeschliffener lebendiger Rubin",		["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[24062] = {["n"] = "Robuster Talasit",					["d"] = "Herstellbar, 1 Talasit"},
	[24036] = {["n"] = "Glitzernder lebendiger Rubin",			["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[24050] = {["n"] = "Schimmernder Dämmerstein",				["d"] = "Herstellbar, 1 Dämmerstein"},
	[24061] = {["n"] = "Glitzernder Edeltopas",				["d"] = "Herstellbar, 1 Edeltopas"},
	[24056] = {["n"] = "Leuchtendes Nachtauge",				["d"] = "Herstellbar, 1 Nachtauge"},
	[24058] = {["n"] = "Gravierter Edeltopas",				["d"] = "Herstellbar, 1 Edeltopas"},
	[24067] = {["n"] = "Gezackter Talasit",					["d"] = "Herstellbar, 1 Talasit"},
	[24060] = {["n"] = "Glänzender Edeltopas",				["d"] = "Herstellbar, 1 Edeltopas"},
	[24037] = {["n"] = "Irisierender Stern der Elune",			["d"] = "Herstellbar, 1 Stern der Elune"},
	[24059] = {["n"] = "Mächtiger Edeltopas",				["d"] = "Herstellbar, 1 Edeltopas"},
	[24066] = {["n"] = "Strahlender Talasit",				["d"] = "Herstellbar, 1 Talasit"},
	[24051] = {["n"] = "Massiver Dämmerstein",				["d"] = "Herstellbar, 1 Dämmerstein"},
	[24057] = {["n"] = "Königliches Nachtauge",				["d"] = "Herstellbar, 1 Nachtauge"},
	[24030] = {["n"] = "Runenverzierter lebendiger Rubin",			["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[24055] = {["n"] = "Unbeständiges Nachtauge",				["d"] = "Herstellbar, 1 Nachtauge"},
	[24048] = {["n"] = "Glatter Dämmerstein",				["d"] = "Herstellbar, 1 Dämmerstein"},
	[24033] = {["n"] = "Gediegener Stern der Elune",			["d"] = "Herstellbar, 1 Stern der Elune"},
	[24054] = {["n"] = "Stattliches Nachtauge",				["d"] = "Herstellbar, 1 Nachtauge"},
	[24035] = {["n"] = "Funkelnder Stern der Elune",			["d"] = "Herstellbar, 1 Stern der Elune"},
	[24039] = {["n"] = "Stürmischer Stern der Elune",			["d"] = "Herstellbar, 1 Stern der Elune"},
	[24032] = {["n"] = "Fragiler lebendiger Rubin",				["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[24029] = {["n"] = "Tränenförmiger lebendiger Rubin",			["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[24052] = {["n"] = "Kompakter Dämmerstein",				["d"] = "Herstellbar, 1 Dämmerstein"},

	-- Herstellbar Rare Meta Gems
	[25897] = {["n"] = "Starker Erdsturmdiamant",				["d"] = "Herstellbar, 1 Erdsturmdiamant"},
	[25899] = {["n"] = "Grober Erdsturmdiamant",				["d"] = "Herstellbar, 1 Erdsturmdiamant"},
	[25890] = {["n"] = "Zerstörerischer Himmelsfeuerdiamant",		["d"] = "Herstellbar, 1 Himmelsfeuerdiamant"},
	[25895] = {["n"] = "Rätselhafter Himmelsfeuerdiamant",			["d"] = "Herstellbar, 1 Himmelsfeuerdiamant"},
	[25901] = {["n"] = "Bemerkenswerter Erdsturmdiamant",			["d"] = "Herstellbar, 1 Erdsturmdiamant"},
	[25893] = {["n"] = "Mystischer Himmelsfeuerdiamant",			["d"] = "Herstellbar, 1 Himmelsfeuerdiamant"},
	[25896] = {["n"] = "Mächtiger Erdsturmdiamant",				["d"] = "Herstellbar, 1 Erdsturmdiamant"},
	[25894] = {["n"] = "Flüchtiger Himmelsfeuerdiamant",			["d"] = "Herstellbar, 1 Himmelsfeuerdiamant"},
	[25898] = {["n"] = "Harter Erdsturmdiamant",				["d"] = "Herstellbar, 1 Erdsturmdiamant"},

	-- Enchanter Created
	[22460] = {["n"] = "Prismasphäre",				["d"] = "Verzauberbar, 4 Große Prismasplitter"},
	[22459] = {["n"] = "Sphäre der Leere",				["d"] = "Verzauberbar, 2 Kristall der Leere"},

	-- PvP Purchased Rare Meta Gems (Terrokar Spirit Towers)
	[28557] = {["n"] = "Flüchtiger Sternenfeuerdiamant",		["d"] = "Händler, 8 Geistsplitter (Allerias Feste/Steinbrecherfeste)"},
	[28556] = {["n"] = "Flüchtiger Windfeuerdiamant",		["d"] = "Händler, 8 Geistsplitter (Allerias Feste/Steinbrecherfeste)"},

	-- PvP Purchased Gems (Nagrand, Halaa)
	[27679] = {["n"] = "Mystischer Edeldämmerstein",		["d"] = "Händler, 100 Kampfmarken von Halaa (Halaa, Nagrand)"},
	[30598] = {["n"] = "Don Amancio's Herz", 			["d"] = "Händler, 14g 9s 72c (Begrenzt Verfügbar (1)) (Aldraan, Halaa, Nagrand)"},

	-- PvP Purchased Epic Gems (Ehrenpunkte Points)
	[28362] = {["n"] = "Klobiger Schmuckrubin",			["d"] = "Händler, 8100 Ehrenpunkte (Offiziersbaracke)"},
	[28120] = {["n"] = "Schimmernder Schmuckdämmerstein",		["d"] = "Händler, 8100 Ehrenpunkte (Offiziersbaracke)"},
	[28363] = {["n"] = "Gravierter Schmucktopas",			["d"] = "Händler, 10000 Ehrenpunkte (Offiziersbaracke)"},
	[28123] = {["n"] = "Mächtiger Schmucktopas",			["d"] = "Händler, 10000 Ehrenpunkte (Offiziersbaracke)"},
	[28118] = {["n"] = "Runenverzierter Schmuckrubin",		["d"] = "Händler, 8100 Ehrenpunkte (Offiziersbaracke)"},
	[28119] = {["n"] = "Glatter Schmuckdämmerstein",		["d"] = "Händler, 8100 Ehrenpunkte (Offiziersbaracke)"},

	-- PvP Puchased Rare Gems (Ehrenfeste/Thrallmar)
	-- Ehrenfeste itemIDs
	[27809] = {["n"] = "Scharfkantiger Tiefenperidot", 		["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},
	[28361] = {["n"] = "Mächtiger Blutgranat", 			["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},
	[27820] = {["n"] = "Gekerbter Tiefenperidot", 			["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},
	[27812] = {["n"] = "Reiner Blutgranat", 			["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},

	--Thrallmar duplicates, different itemIDs
	--[27786] = {["n"] = "Scharfkantiger Tiefenperidot", 		["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},
	--[28360] = {["n"] = "Mächtiger Blutgranat", 			["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},
	--[27785] = {["n"] = "Gekerbter Tiefenperidot", 		["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},
	--[27777] = {["n"] = "Reiner Blutgranat", 			["d"] = "Händler, 10 Abzeichen der Ehrenfeste/Thrallmar (Höllenfeuerhalbinsel)"},

       -- Händler Purchased (Common Gems)
	[28458] = {["n"] = "Klobiger Turmalin",				["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28462] = {["n"] = "Heller Turmalin",				["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28466] = {["n"] = "Brillantierter Bernstein",			["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28459] = {["n"] = "Feingeschliffener Turmalin",		["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28469] = {["n"] = "Schimmernder Bernstein",			["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28465] = {["n"] = "Irisierender Zirkon",			["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28468] = {["n"] = "Massiver Bernstein",			["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28461] = {["n"] = "Runenverzierter Turmalin",			["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28467] = {["n"] = "Glatter Bernstein",				["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28463] = {["n"] = "Gediegener Zirkon",				["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28464] = {["n"] = "Funkelnder Zirkon",				["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28460] = {["n"] = "Tränenförmiger Turmalin",			["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},
	[28470] = {["n"] = "Kompakter Bernstein",			["d"] = "Händler, 2g (Shattrath, Sturmsäule, Ehrenfeste, Thrallmar)"},

	-- Instance Epic Gem Drops - Heroic
	[30565] = {["n"] = "Feueropal des Assassinen",			["d"] = "Mechanar - Heroisch"},
	[30601] = {["n"] = "Blitzender Feueropal",			["d"] = "Blutkessel - Heroisch"},
	[30574] = {["n"] = "Grober Tansanit",				["d"] = "Botanikum - Heroisch"},
	[30587] = {["n"] = "Feueropal des Champions", 			["d"] = "Auchenaikrypta - Heroisch"},
	[30566] = {["n"] = "Tansanit des Verteidigers",			["d"] = "Mechanar - Heroisch"},
	[30594] = {["n"] = "Prächtiger Chrysopras",			["d"] = "Höllenfeuerzitadelle - Heroisch"},
	[30584] = {["n"] = "Gravierter Feueropal",			["d"] = "Managruft - Heroisch"},
	[30559] = {["n"] = "Geätzter Feueropal", 			["d"] = "Schattenlabyrinth - Heroisch"},
	[30600] = {["n"] = "Fluoreszierender Tansanit", 		["d"] = "Blutkessel - Heroisch"},
	[30558] = {["n"] = "Flimmernder Feueropal",			["d"] = "Der schwarze Morast - Heroisch"},
	[30556] = {["n"] = "Glitzernder Feueropal",			["d"] = "Der schwarze Morast - Heroisch"},
	[30585] = {["n"] = "Gleißender Feueropal",			["d"] = "Managruft - Heroisch"},
	[30555] = {["n"] = "Leuchtender Tansanit",			["d"] = "Der schwarze Morast - Heroisch"},
	[31116] = {["n"] = "Energieerfüllter Amethyst",			["d"] = "Questbelohnung - Schrecken der Nacht, Karazhan"},
	[30551] = {["n"] = "Energieerfüllter Feueropal",		["d"] = "Dampfkammer - Heroisch"},
	[30593] = {["n"] = "Regenbogenfarbener Feueropal",		["d"] = "Höllenfeuerzitadelle - Heroisch"},
	[30602] = {["n"] = "Gezackter Chrysopras",			["d"] = "Blutkessel - Heroisch"},
	[30606] = {["n"] = "Flackernsder Chrysopras",			["d"] = "Der Tiefensumpf - Heroisch"},
	[30547] = {["n"] = "Glänzender Feueropal",			["d"] = "Die zerschmetterten Hallen - Heroisch"},
	[30548] = {["n"] = "Polierter Chrysopras",			["d"] = "Die zerschmetterten Hallen - Heroisch"},
	[30553] = {["n"] = "Makelloser Feueropal",			["d"] = "Sethekkhallen - Heroisch"},
	[31118] = {["n"] = "Pulsierender Amethyst",			["d"] = "Questbelohnung - Schrecken der Nacht, Karazhan"},
	[30608] = {["n"] = "Strahlender Chrysopras",			["d"] = "Der Tiefensumpf - Heroisch"},
	[30563] = {["n"] = "Majestätischer Tansanit",			["d"] = "Schattenlabyrinth - Heroisch"},
	[30604] = {["n"] = "Prunkvoller Feueropal",			["d"] = "Sklavenunterkünfte - Heroisch"},
	[30603] = {["n"] = "Königlicher Tansanit",			["d"] = "Sklavenunterkünfte - Heroisch"},
	[30586] = {["n"] = "Chrysopras des Sehers",			["d"] = "Auchenaikrypta - Heroisch"},
	[30549] = {["n"] = "Unbeständiger Tansanit",			["d"] = "Dampfkammer - Heroisch"},
	[30564] = {["n"] = "Bestechender Feueropal",			["d"] = "Mechanar - Heroisch"},
	[31117] = {["n"] = "Bruhigender Amethyst",			["d"] = "Questbelohnung - Schrecken der Nacht, Karazhan"},
	[30546] = {["n"] = "Stattlicher Tansanit",			["d"] = "Die zerschmetterten Hallen - Heroisch"},
	[30607] = {["n"] = "Herrlicher Feueropal",			["d"] = "Der Tiefensumpf - Heroisch"},
	[30554] = {["n"] = "Bruchfester Feueropal", 			["d"] = "Sethekkhallen - Heroisch"},
	[30592] = {["n"] = "Gleichförmiger Chrysopras",			["d"] = "Höllenfeuerzitadelle - Heroisch"},
	[30550] = {["n"] = "Unreiner Chrysopras",			["d"] = "Dampfkammer - Heroisch"},
	[30583] = {["n"] = "Zeitloser Chrysopras",	 		["d"] = "Managruft - Heroisch"},
	[30605] = {["n"] = "Klarer Chrysopras",				["d"] = "Sklavenunterkünfte - Heroisch"},

	-- Added in Gem Helper v1.1
	[30552] = {["n"] = "Gesegneter Tansanit",			["d"] = "Sethekkhallen - Heroisch"},
	[30589] = {["n"] = "Schillernder Chrysopras", 			["d"] = "Höhlen der Zeit I - Heroisch"},
	[30582] = {["n"] = "Tödlicher Feueropal", 			["d"] = "Arkatraz - Heroisch"},
	[30581] = {["n"] = "Solider Feueropal", 			["d"] = "Arkatraz - Heroisch"},
	[30591] = {["n"] = "Machterfüllter Chrysopras", 		["d"] = "Höhlen der Zeit I - Heroisch"},
	[30590] = {["n"] = "Robuster Chrysopras", 			["d"] = "Höhlen der Zeit I - Heroisch"},
	[30572] = {["n"] = "Kaiserlicher Tansanit", 			["d"] = "Botanikum - Heroisch"},
	[30573] = {["n"] = "Geheimnisvoller Feueropal",			["d"] = "Botanikum - Heroisch"},
	[30575] = {["n"] = "Wuchtiger Feueropal",			["d"] = "Arkatraz - Heroisch"},
	[30588] = {["n"] = "Mächtiger Feueropal", 			["d"] = "Auchenaikrypta - Heroisch"},
	[30560] = {["n"] = "Runenbesetzter Chrysopras", 		["d"] = "Schattenlabyrinth - Heroisch"},

	-- Added in Gem Helper v1.2
	[31863] = {["n"] = "Ausbalanciertes Nachtauge",			["d"] = "Herstellbar, 1 Nachtauge"},
	[31861] = {["n"] = "Großer Dämmerstein",			["d"] = "Herstellbar, 1 Dämmerstein"},
	[31865] = {["n"] = "Energieerfülltes Nachtauge",		["d"] = "Herstellbar, 1 Nachtauge"},
	[31867] = {["n"] = "Verschleierter Edeltopas",			["d"] = "Herstellbar, 1 Edeltopas"},
	[31868] = {["n"] = "Tückischer Edeltopas",			["d"] = "Herstellbar, 1 Edeltopas"},
	[32836] = {["n"] = "Geläuterte Schattenperle",			["d"] = "Herstellbar, 1 Schattenperle, 1 Geläutertes draenisches Wasser"},
	[32833] = {["n"] = "Geläuterte Jaggalperle",			["d"] = "Herstellbar, 1 Jaggalperle, 1 Geläutertes draenisches Wasser"},
	[32409]	= {["n"] = "Unerbittlicher Erdsturmdiamant",		["d"] = "Herstellbar, 1 Erdsturmdiamant"},
	[32410] = {["n"] = "Donnernder Himmelsfeuerdiamant",		["d"] = "Herstellbar, 1 Himmelsfeuerdiamant"},

	-- Added in Gem Helper v1.3
	[24053] = {["n"] = "Mystischer Dämmerstein",			["d"] = "Herstellbar, 1 Dämmerstein"},
	[32634] = {["n"] = "Instabiler Amethyst",			["d"] = "Händler, 40 Apexissplitter (Schergrat)"},
	[32635] = {["n"] = "Instabiler Peridot",			["d"] = "Händler, 40 Apexissplitter (Schergrat)"},
	[32636] = {["n"] = "Instabiler Saphir",				["d"] = "Händler, 40 Apexissplitter (Schergrat)"},
	[32637] = {["n"] = "Instabiler Citrin",				["d"] = "Händler, 40 Apexissplitter (Schergrat)"},
	[32638] = {["n"] = "Instabiler Topas",				["d"] = "Händler, 40 Apexissplitter (Schergrat)"},
	[32639] = {["n"] = "Instabiler Talasit",			["d"] = "Händler, 40 Apexissplitter (Schergrat)"},
	[32640] = {["n"] = "Mächtiger instabiler Diamant",		["d"] = "Händler, 160 Apexissplitter (Schergrat)"},
	[32641] = {["n"] = "Magieerfüllter instabiler Diamant",		["d"] = "Händler, 160 Apexissplitter (Schergrat)"},

	-- Added in Gem Helper v1.3
	-- The following gems are crafted from epic gem drops in Black Temple/Hyjal
	[32193] = {["n"] = "Klobiger Purpurspinell",				["d"] = "Herstellbar, 1 Purpurspinell"},
	[32194] = {["n"] = "Feingeschliffener Purpurspinell",			["d"] = "Herstellbar, 1 Purpurspinell"},
	[32195] = {["n"] = "Tränenförmiger Purpurspinell",			["d"] = "Herstellbar, 1 Purpurspinell"},
	[32196] = {["n"] = "Runenverzierter Purpurspinell",			["d"] = "Herstellbar, 1 Purpurspinell"},
	[32197] = {["n"] = "Heller Purpurspinell",				["d"] = "Herstellbar, 1 Purpurspinell"},
	[32198] = {["n"] = "Fragiler Purpurspinell",				["d"] = "Herstellbar, 1 Purpurspinell"},
	[32199] = {["n"] = "Glitzernder Purpurspinell",				["d"] = "Herstellbar, 1 Purpurspinell"},
	[32200] = {["n"] = "Gediegener Engelssaphir",				["d"] = "Herstellbar, 1 Engelssaphir"},
	[32201] = {["n"] = "Funkelnder Engelssaphir",				["d"] = "Herstellbar, 1 Engelssaphir"},
	[32202] = {["n"] = "Irisierender Engelssaphir",				["d"] = "Herstellbar, 1 Engelssaphir"},
	[32203] = {["n"] = "Stürmischer Engelssaphir",				["d"] = "Herstellbar, 1 Engelssaphir"},
	[32204] = {["n"] = "Brillantiertes Löwenauge",				["d"] = "Herstellbar, 1 Löwenauge"},
	[32205] = {["n"] = "Glattes Löwenauge",					["d"] = "Herstellbar, 1 Löwenauge"},
	[32206] = {["n"] = "Massiver Löwenauge",				["d"] = "Herstellbar, 1 Löwenauge"},
	[32207] = {["n"] = "Schimmerndes Löwenauge",				["d"] = "Herstellbar, 1 Löwenauge"},
	[32208] = {["n"] = "Kompaktes Löwenauge",				["d"] = "Herstellbar, 1 Löwenauge"},
	[32209] = {["n"] = "Mystisches Löwenauge",				["d"] = "Herstellbar, 1 Löwenauge"},
	[32210] = {["n"] = "Großer Löwenauge",					["d"] = "Herstellbar, 1 Löwenauge"},
	[32211] = {["n"] = "Stattlicher Schattensangamethyst",			["d"] = "Herstellbar, 1 Schattensangamethyst"},
	[32212] = {["n"] = "Unbeständiger Schattensangamethyst",		["d"] = "Herstellbar, 1 Schattensangamethyst"},
	[32213] = {["n"] = "Ausbalancierter Schattensangamethyst",		["d"] = "Herstellbar, 1 Schattensangamethyst"},
	[32214] = {["n"] = "Energieerfüllter Schattensangamethyst",		["d"] = "Herstellbar, 1 Schattensangamethyst"},
	[32215] = {["n"] = "Leuchtender Schattensangamethyst",			["d"] = "Herstellbar, 1 Schattensangamethyst"},
	[32216] = {["n"] = "Königlicher Schattensangamethyst",			["d"] = "Herstellbar, 1 Schattensangamethyst"},
	[32217] = {["n"] = "Gravierter Pyrostein",				["d"] = "Herstellbar, 1 Pyrostein"},
	[32218] = {["n"] = "Mächtiger Pyrostein",				["d"] = "Herstellbar, 1 Pyrostein"},
	[32219] = {["n"] = "Glänzender Pyrostein",				["d"] = "Herstellbar, 1 Pyrostein"},
	[32220] = {["n"] = "Glitzernder Pyrostein",				["d"] = "Herstellbar, 1 Pyrostein"},
	[32221] = {["n"] = "Verschleierter Pyrostein",				["d"] = "Herstellbar, 1 Pyrostein"},
	[32222] = {["n"] = "Tückischer Pyrostein",				["d"] = "Herstellbar, 1 Pyrostein"},
	[32223] = {["n"] = "Robuster Gischtsmaragd",				["d"] = "Herstellbar, 1 Gischtsmaragd"},
	[32224] = {["n"] = "Strahlender Gischtsmaragd",				["d"] = "Herstellbar, 1 Gischtsmaragd"},
	[32225] = {["n"] = "Schillernder Gischtsmaragd",			["d"] = "Herstellbar, 1 Gischtsmaragd"},
	[32226] = {["n"] = "Gezackter Gischtsmaragd",				["d"] = "Herstellbar, 1 Gischtsmaragd"},

	-- Added in Gem Helper v1.4
	[33131] = {["n"] = "Blutrote Sonne",			["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[33133] = {["n"] = "Don Julios Herz",			["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[33134] = {["n"] = "Kailees Rose",			["d"] = "Herstellbar, 1 Lebendiger Rubin"},
	[33135] = {["n"] = "Sternschnuppe",			["d"] = "Herstellbar, 1 Stern der Elune"},
	[33140] = {["n"] = "Bernsteinblut",			["d"] = "Herstellbar, 1 Dämmerstein"},
	[33143] = {["n"] = "Stein der Klingen",			["d"] = "Herstellbar, 1 Dämmerstein"},
	[33144] = {["n"] = "Facette der Ewigkeit",		["d"] = "Herstellbar, 1 Dämmerstein"},
	[33782] = {["n"] = "Beständiger Talasit",		["d"] = "Herstellbar, 1 Talasit"},

	-- Added in Gem Helper v1.41 (patch 2.2.2)
	[31862] = {["n"] = "Ausbalancierter Schattendraenit",		["d"] = "Herstellbar, 1 Schattendraenit"},
	[31860] = {["n"] = "Großer Golddraenit",			["d"] = "Herstellbar, 1 Golddraenit"},
	[31864] = {["n"] = "Energieerfüllter Schattendraenit",		["d"] = "Herstellbar, 1 Schattendraenit"},
	[31866] = {["n"] = "Verschleierter Flammenspessarit",		["d"] = "Herstellbar, 1 Flammenspessarit"},
	[31869] = {["n"] = "Tückischer Flammenspessarit",		["d"] = "Herstellbar, 1 Flammenspessarit"},

	-- Added in Gem Helper v1.5 (patch 2.3.0)
	[34220] = {["n"] = "Wechselhafter Himmelsfeuerdiamant",	["d"] = "Herstellbar, 1 Himmelsfeuerdiamant"},
	[34256] = {["n"] = "Bezaubertes Juwel der Amani",	["d"] = "Questbelohnung - Zul'Aman"},

	-- Added in Gem Helper v1.6 (patch 2.4.0)
	[35503] = {["n"] = "Glimmender Himmelsfeuerdiamant",	["d"] = "Herstellbar, 1 Himmelsfeuerdiamant"},
	[35501] = {["n"] = "Ewiger Erdsturmdiamant",	["d"] = "Herstellbar, 1 Erdsturmdiamant"},
	[35707] = {["n"] = "Majestätisches Nachtauge",			["d"] = "Herstellbar, 1 Nachtauge"},
	[34831] = {["n"] = "Auge des Meeres",	["d"] = "Questbelohnung - Tägliche Angelquest"},
	[35758] = {["n"] = "Beständiger Gischtsmaragd",		["d"] = "Herstellbar, 1 Gischtsmaragd"},
	[35759] = {["n"] = "Kraftvoller Gischtsmaragd",		["d"] = "Herstellbar, 1 Gischtsmaragd"},
	[35760] = {["n"] = "Tollkühner Pyrostein",			["d"] = "Herstellbar, 1 Pyrostein"},
	[35761] = {["n"] = "Spiegelndes Löwenauge",		["d"] = "Herstellbar, 1 Löwenauge"},

	-- Added in Gem Helper v1.7 (patch 2.4.2)
	[37503] = {["n"] = "Geläuterter Schattensangamethyst",		["d"] = "Herstellbar, 1 Schattensangamethyst"},
	[35315] = {["n"] = "Spiegelnder Dämmerstein",		["d"] = "Herstellbar, 1 Dämmerstein"},
	[35316] = {["n"] = "Tollkühner Edeltopas",			["d"] = "Herstellbar, 1 Edeltopas"},
	[35318] = {["n"] = "Kraftvoller Talasit",		["d"] = "Herstellbar, 1 Talasit"},
}

end
