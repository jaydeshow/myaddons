-- german localization
-- credit to Borlox, kunda
local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate","deDE")
if not L then return end
-- Spell names for Collector module
L["Mining"] = "Bergbau"
L["Fishing"] = "Angeln"
L["Herb Gathering"] = "Kräutersammeln"
L["Extract Gas"] = "Gas extrahieren"
L["Herbalism"] = "Kräuterkunde"
L["Engineering"] = "Ingenieurskunst"
L["Opening"] = "Öffnen"
L["Pick Lock"] = "Schloss knacken"
-- Display module
L["GatherMate Pin Options"] = "GatherMate Pin Optionen"
L["Delete: "] = "Löschen: "
L["Add this location to Cartographer_Waypoints"] = "Diese Stelle zu Cartographer_Waypoints hinzufügen"

L["Always show"] = "Immer anzeigen"
L["Only with profession"] = "Nur mit Beruf"
L["Only while tracking"] = "Nur wenn gesucht wird"
L["Never show"] = "Niemals anzeigen"


-- Config modules
L["GatherMate"] = true
L["gathermate"] = true -- slash command
---- Display Filters tree
L["Display Settings"] = "Anzeige Einstellungen"
------ General subtree
L["General"] = "Allgemein"
L["Show Databases"] = "Datenbanken anzeigen"
L["Selected databases are shown on both the World Map and Minimap."] = "Gewählte Datenbanken werden auf der Weltkarte und auf der Minikarte angezeigt."
L["Show Mining Nodes"] = "Bergbau Knoten anzeigen"
L["Toggle showing mining nodes."] = "Anzeige der Bergbau Knoten ein-/ausschalten."
L["Show Herbalism Nodes"] = "Kräuterkunde Knoten anzeigen"
L["Toggle showing herbalism nodes."] = "Anzeige der Kräuterkunde Knoten ein-/ausschalten."
L["Show Fishing Nodes"] = "Angel Knoten anzeigen"
L["Toggle showing fishing nodes."] = "Anzeige der Angel Knoten ein-/ausschalten."
L["Show Gas Clouds"] = "Gas Wolken anzeigen"
L["Toggle showing gas clouds."] = "Anzeige der Gas Wolken ein-/ausschalten."
L["Show Treasure Nodes"] = "Schatz Knoten anzeigen"
L["Toggle showing treasure nodes."] = "Anzeige der Schatz Knoten ein-/ausschalten."
L["Icons"] = "Icons"
L["Control various aspects of node icons on both the World Map and Minimap."] = "Kontrolliert verschiedene Einstellungen der Icons auf der Weltkarte und der Minikarte."
L["Show Minimap Icons"] = "Minikarten Icons anzeigen"
L["Toggle showing Minimap icons."] = "Anzeige der Minikarten Icons ein-/ausschalten."
L["Show World Map Icons"] = "Weltkarten Icons anzeigen"
L["Toggle showing World Map icons."] = "Anzeige der Weltkarten Icons ein-/aussschalten."
L["Icon Scale"] = "Icongröße"
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = "Größe der Icons auf der Weltkarte und der Minikarte verändern."
L["Icon Alpha"] = "Icontransparenz"
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = "Tranzparenz der Icons verändern. Nur Weltkarte."
L["Miscellaneous"] = "Verschiedenes"
-- Cleanup subtree
L["Cleanup_Desc"] = "Nach einer gewissen Zeit kann Deine Datenbank 'zugemüllt' sein. 'Datenbank aufräumen' sucht nach Knoten eines Berufs die nah zusammen liegen und ermittelt ob diese zu einem einzigen Knoten zusammengefasst werden können."
L["Cleanup radius"] = "Aufräumradius"
L["CLEANUP_RADIUS_DESC"] = "Radius (in Meter) in dem doppelte Knoten gelöscht werden sollen. Standard ist |cFFFFFFFF50m|r für Gas extrahieren und |cFFFFFFFF15m|r für alles andere. Diese Einstellungen werden auch benutzt wenn Knoten hinzugefügt werden."
L["Cleanup Database"] = "Datenbank aufräumen"
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = "Räumt die Datenbank auf indem doppelte Einträge gelöscht werden. Der Vorgang dauert ein paar Momente." 
L["Processing "] = "In Bearbeitung: "
L["Cleanup Complete."] = "Aufräumen abgeschlossen."
-- Tracking options
L["Tracking Circle Color"] = "Anzeigekreis Farbe"
L["Color of the tracking circle."] = "Farbe der Anzeigekreise."
L["Tracking Distance"] = "Anzeigeentfernung"
L["The distance in yards to a node before it turns into a tracking circle"] = "Die Entfernung in Meter zu einem Knoten, bevor dieser zu einem Kreis wird"
L["Show Tracking Circle"] = "Anzeigekreis anzeigen"
L["Toggle showing the tracking circle."] = "Anzeige der Anzeigekreise ein-/ausschalten."
L["Show Nodes on Minimap Border"] = "Zeige Knotenpunkte am Rand der Minikarte"
L["Shows more Nodes that are currently out of range on the minimap's border."] = "Zeigt Knotenpunkte die momentan außer Reichweite sind am Rand der Minikarte."
------ Filters subtree
L["Filters"] = "Filter"
L["Herb filter"] = "Pflanzen Filter"
L["Select the herb nodes you wish to display."] = "Wähle die Pflanzen aus, die angezeigt werden sollen."
L["Mine filter"] = "Minen Filter"
L["Select the mining nodes you wish to display."] = "Wähle die Minen aus, die angezeigt werden sollen."
L["Fish filter"] = "Fisch Filter"
L["Select the fish nodes you wish to display."] = "Wähle die Fische aus, die angezeigt werden solllen."
L["Gas filter"] = "Gas Filter"
L["Select the gas clouds you wish to display."] = "Wähle die Gaswolken aus, die angezeigt werden sollen."
L["Treasure filter"] = "Schatz Filter"
L["Select the treasure you wish to display."] = "Wähle die Schätze aus, die angezeigt werden sollen."
L["Select All"] = "Alle auswählen"
L["Select all nodes"] = "Alle Knoten auswählen"
L["Clear node selections"] = "Auswahl löschen"
L["Select None"] = "Nichts auswählen"
L["Gas Clouds"] = "Gas Wolken"
L["Fishes"] = "Fische"
L["Mineral Veins"] = "Erzvorkommen"
L["Herb Bushes"] = "Pflanzen"
L["Treasure"] = "Schatz"
L["Filter_Desc"] = "Ausgewählte Typen werden auf der Weltkarte und auf der Minikarte angezeigt. Nicht ausgewählte werden trotzdem in der Datenbank gespeichert."               
---- Import tree
L["Import Data"] = "Daten importieren"
L["Import GatherMateData"] = "Importieren"
L["Importing_Desc"] = "Die Importfunktion ermöglicht, daß GatherMate auch Daten von anderen Quellen anzeigt, als nur die selbst entdeckten Stellen. Nach dem Import sollte unter Umständen die Datenbank aufgeräumt werden."
L["Load GatherMateData and import the data to your database."] = "GatherMateData laden und in Deine Datenbank importieren."
L["GatherMateData has been imported."] = "GatherMateData wurde importiert."
L["Failed to load GatherMateData due to "] = "Fehler beim Laden von GatherMateData aufgrund von "
L["Merge"] = "Zusammenführen"
L["Overwrite"] = "Überschreiben"
L["Import Style"] = "Importierungsart"
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = "'Zusammenführen' wird Daten von GatherMateData zu Deiner Datenbank hinzufügen. 'Überschreiben' wird Deine Datenbank mit Daten von GatherMateData überschreiben."
L["Databases to Import"] = "Datenbanken zum Importieren"
L["Databases you wish to import"] = "Datenbanken, die importiert werden sollen."
L["Auto Import"] = "Automatisch importieren"
L["Automatically import when ever you update your data module, your current import choice will be used."] = "Immer automatisch importieren wenn das Datenmodul aktualisiert wurde. Die momentanen Importeinstellungen werden dabei benutzt."
L["Auto import complete for addon "] = "Automatischer Import abgeschlossen. Quelle: "
L["BC Data Only"] = "nur BC Daten"
L["Only import Burning Crusade data from WoWHead"] = "Nur Burning Crusade Daten von WoWHead importieren"
--- profile settings
L["Default"] = "Standard"
L["Char:"] = "Charakter:"
L["Realm:"] = "Realm:"
L["Class:"] = "Klasse:"
L["Profiles"] = "Profile"
L["Manage Profiles"] = "Profile verwalten"
L["You can change the active database profile of GatherMate, so you can have different settings and filters for every character, which will allow a very flexible configuration for everyones needs."] = "Hier kannst Du die aktiven Datenbankprofile von GatherMate ändern, damit Du verschiedene Einstellungen und Filter für jeden Charakter erstellen kannst. Dies erlaubt eine flexible Konfiguration für jeden Bedarf." 
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = "Setzt das momentane Profil auf Standardwerte zurück, für den Fall das mit der Konfiguration etwas schief lief oder weil du einfach neu starten willst."
L["You can create a new profile by entering a new name in the editbox, or choosing one of the already exisiting profiles."] = "Du kannst ein neues Profil erstellen, indem Du einen neuen Namen in der Eingabebox 'Neu' eingibst. Oder wähle ein vorhandenes Profil aus."
L["Reset Profile"] = "Profil zurücksetzen"
L["Reset the current profile to the default"] = "Das aktuelle Profil auf Standard zurücksetzen."
L["New"] = "Neu"
L["Create a new empty profile."] = "Ein neues leeren Profil erstellen."
L["Current"] = "Momentan"
L["Select one of your currently available profiles."] = "Wählt ein momentanes Profil aus."
L["Copy the settings from one existing profile into the currently active profile."] = "Kopiere die Einstellungen von einem vorhandenen Profil in das momentan aktive Profil."
L["Copy From"] = "Kopiere von"
L["Copy the settings from another profile into the active profile."] = "Kopiert Einstellungen von einem anderen Profil in das momentan aktive Profil."
L["Delete existing and unused profiles from the database to save space, and cleanup the GatherMate SavedVariables file."] = "Lösche vorhandene und unbenutzte Profile aus der Datenbank um Platz zu sparen und um die GatherMate SavedVariables Datei 'sauber' zu halten."
L["Delete a Profile"] = "Profil löschen"
L["Deletes a profile from the database."] = "Löscht ein Profil aus der Datenbank."
L["Are you sure you want to delete the selected profile?"] = "Willst du wirklich das ausgewählte Profil löschen?"
-- FAQ
L["FAQ"] = "FAQ"
L["Frequently Asked Questions"] = "Häufig gestellte Fragen (FAQ)"
L["FAQ_TEXT"] = [[
|cFFFFFFFF
Ich habe gerade GatherMate installiert, sehe aber keine Knoten auf meiner Karte. Was mache ich falsch?
|r
GatherMate kommt standardmäßig ohne Daten. Wenn Du Kräuter, Erze, Gase oder Fische sammelst fügt GatherMate diese umgehend der Karte zu und aktualisiert die Karte. Überprüft auch Deine 'Anzeige Einstellungen'.
|cFFFFFFFF
Ich sehe Knoten auf der Weltkarte, aber nicht auf der Minikarte! Was mache ich falsch?
|r
|cffffff78Minimap Button Bag|r (und möglicherweise ähnliche Addons) löscht gerne alle Buttons. Deaktiviere solche Addons.
|cFFFFFFFF
Wie oder woher kann ich bereits vorhandene Daten bekommen?
|r
Du kannst vorhandene Daten auf folgende Arten importieren:

1. |cffffff78GatherMate_Data|r - Dieses LoD (wird beim Benutzen in den Speicher geladen) Addon enthält eine von WoWHead gesaugte Kopie aller Knoten die wöchentlich aktualisiert wird. Dafür gibt es automatische Aktualisierungsoptionen.

2. |cffffff78GatherMate_CartImport|r - Dieses Addon erlaubt Dir den Import vorhandener Datenbanken aus |cffffff78Cartographer_<Profession>|r Modulen in GatherMate. Damit dies funktioniert müssen die |cffffff78Cartographer_<Profession>|r Module und GatherMate_CartImport geladen und aktiviert sein.

Beachte, dass das Importieren von Daten in GatherMate kein automatisierter Prozess ist. Du mußt in 'Daten importieren' den Button 'Importieren' klicken. 

Dies unterscheidet sich von |cffffff78Cartographer_Data|r dahingehend, daß dem Benutzer die Wahl gegeben wird zu entscheiden wie und wann er seine Daten ändern will. |cffffff78Cartographer_Data|r überschreibt einfach Deine vorhandene Datenbank ohne Warnung und zerstört alle von Dir neu gefundenen Knoten.
|cFFFFFFFF
Könnt ihr Standorte für Postfächer, Flugmeister und dergleichen unterstützen?
|r
Die Antwort ist nein. Wie auch immer, andere Addon Autoren können Addons oder Module für diese Zwecke machen. Das Basis GatherMate Addon wird dies nicht tun.
|cFFFFFFFF
Ich hab einen Fehler gefunden! Wo kann ich das melden?
|r
Du kannst Fehler oder Vorschläge hier melden: |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r

Alternativ kannst Du uns hier finden: |cffffff78irc://irc.freenode.org/wowace|r

Wenn Du einen Fehler meldest, gib bitte folgendes an: |cffffff78Hinweise (am besten Schritt für Schritt)|r mit der man den Fehler reproduzieren kann, eine |cffffff78Fehlermeldung|r (z.B. von BugGrabber/BugSack), die |cffffff78Revisionsnummer|r von GatherMate die das Problem verursacht hat und ob du den |cffffff78englischen Client oder einem anderen (z.B.: deDE)|r benutzt.
|cFFFFFFFF
Wer hat dieses coole Addon geschrieben?
|r
Kagaro, Xinhuan, Nevcairiel and Ammo
]]



local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes","deDE")
if not NL then return end
-- fish schools
NL["Floating Wreckage"] = "Treibende Wrackteile"
NL["Patch of Elemental Water"] = "Stelle mit Elementarwasser"
NL["Floating Debris"] = "Schwimmende Trümmer"
NL["Oil Spill"] = "Ölfleck" 
NL["Firefin Snapper School"] = "Feuerflossenschnapperschwarm"
NL["Greater Sagefish School"] = "Schwarm großer Weisenfische"
NL["Oily Blackmouth School"] = "Schwarm öliger Schwarzmaulfische"
NL["Sagefish School"] = "Weisenfischschwarm"
NL["School of Deviate Fish"] = "Deviatfischschwarm"
NL["Stonescale Eel Swarm"] = "Steinschuppenaalschwarm"
--NL["Muddy Churning Water"] = "Schlammiges aufgewühltes Gewässer" ZG only
NL["Highland Mixed School"] = "Mischschwarm des Hochlands"
NL["Pure Water"] = "Reines Wasser"
NL["Bluefish School"] = "Blauflossenschwarm"
NL["Feltail School"] = "Teufelsfinnenschwarm"
NL["Mudfish School"] = "Matschflosserschwarm"
NL["School of Darter"] = "Stachelflosserschwarm"
NL["Sporefish School"] = "Sporenfischschwarm"
NL["Steam Pump Flotsam"] = "Treibgut der Dampfpumpe"
NL["School of Tastyfish"] = "Leckerfischschwarm"

-- mine nodes
NL["Copper Vein"] = "Kupfervorkommen"
NL["Tin Vein"] = "Zinnvorkommen"
NL["Iron Deposit"] = "Eisenvorkommen"
NL["Silver Vein"] = "Silbervorkommen"
NL["Gold Vein"] = "Goldvorkommen"
NL["Mithril Deposit"] = "Mithrilablagerung"
NL["Ooze Covered Mithril Deposit"] = "Brühschlammbedeckte Mithrilablagerung"
NL["Truesilver Deposit"] = "Echtsilberablagerung"
NL["Ooze Covered Silver Vein"] = "Brühschlammbedecktes Silbervorkommen"
NL["Ooze Covered Gold Vein"] = "Brühschlammbedecktes Goldvorkommen"
NL["Ooze Covered Truesilver Deposit"] = "Brühschlammbedeckte Echtsilberablagerung"
NL["Ooze Covered Rich Thorium Vein"] = "Brühschlammbedecktes reiches Thoriumvorkommen"
NL["Ooze Covered Thorium Vein"] = "Brühschlammbedecktes Thoriumvorkommen"
NL["Small Thorium Vein"] = "Kleines Thoriumvorkommen"
NL["Rich Thorium Vein"] = "Reiches Thoriumvorkommen"
--NL["Hakkari Thorium Vein"] = "Hakkari Thoriumvorkommen" ZG only
NL["Dark Iron Deposit"] = "Dunkeleisenablagerung"
NL["Lesser Bloodstone Deposit"] = "Geringe Blutsteinablagerung"
NL["Incendicite Mineral Vein"] = "Pyrophormineralvorkommen"
NL["Indurium Mineral Vein"] = "Induriummineralvorkommen"
NL["Fel Iron Deposit"] = "Teufelseisenvorkommen"
NL["Adamantite Deposit"] = "Adamantitablagerung"
NL["Rich Adamantite Deposit"] = "Reiche Adamantitablagerung"
NL["Khorium Vein"] = "Khoriumvorkommen"
--NL["Large Obsidian Chunk"] = "Großer Obsidianbrocken" AQ 40
--NL["Small Obsidian Chunk"] = "Kleiner Obsidianbrocken" AQ 20/40
NL["Nethercite Deposit"] = "Netheritablagerung"

-- gas clouds
NL["Windy Cloud"] = "Windige Wolke"
NL["Swamp Gas"] = "Sumpfgas"
NL["Arcane Vortex"] = "Arkanvortex"
NL["Felmist"] = "Teufelsnebel"

-- herb bushes
NL["Peacebloom"] = "Friedensblume"
NL["Silverleaf"] = "Silberblatt"
NL["Earthroot"] = "Erdwurzel"
NL["Mageroyal"] = "Maguskönigskraut"
NL["Briarthorn"] = "Wilddornrose"
--NL["Swiftthistle"] = "Flitzdistel" found in other sources
NL["Stranglekelp"] = "Würgetang"
NL["Bruiseweed"] = "Beulengras"
NL["Wild Steelbloom"] = "Wildstahlblume"
NL["Grave Moss"] = "Grabmoos"
NL["Kingsblood"] = "Königsblut"
NL["Liferoot"] = "Lebenswurz"
NL["Fadeleaf"] = "Blassblatt"
NL["Goldthorn"] = "Golddorn"
NL["Khadgar's Whisker"] = "Khadgars Schnurrbart"
NL["Wintersbite"] = "Winterbiss"
NL["Firebloom"] = "Feuerblüte"
NL["Purple Lotus"] = "Lila Lotus"
--NL["Wildvine"] = "Wildranke" found in purple lotus
NL["Arthas' Tears"] = "Arthas’ Tränen" -- in deDE: ’ (punctuation apostrophe Unicode: U+2019)!
NL["Sungrass"] = "Sonnengras"
NL["Blindweed"] = "Blindkraut"
NL["Ghost Mushroom"] = "Geisterpilz"
NL["Gromsblood"] = "Gromsblut"
NL["Golden Sansam"] = "Goldener Sansam"
NL["Dreamfoil"] = "Traumblatt"
NL["Mountain Silversage"] = "Bergsilbersalbei"
NL["Plaguebloom"] = "Pestblüte"
NL["Icecap"] = "Eiskappe"
--NL["Bloodvine"] = "Blutrebe" ZG only not needed atm
NL["Black Lotus"] = "Schwarzer Lotus"
NL["Felweed"] = "Teufelsgras"
NL["Dreaming Glory"] = "Traumwinde"
NL["Terocone"] = "Terozapfen"
--NL["Ancient Lichen"] = "Urflechte" instance only
NL["Bloodthistle"] = "Blutdistel"
NL["Mana Thistle"] = "Manadistel"
NL["Netherbloom"] = "Netherblüte"
NL["Nightmare Vine"] = "Alptraumranke"
NL["Ragveil"] = "Zottelkappe"
NL["Flame Cap"] = "Flammenkappe"
NL["Netherdust Bush"] = "Netherstaubbusch"
-- Treasure
NL["Giant Clam"] = "Riesenmuschel"
NL["Battered Chest"] = "Ramponierte Truhe"
NL["Tattered Chest"] = "Ramponierte Truhe" -- in deDE: same as Battered Chest
NL["Solid Chest"] = "Robuste Truhe"
NL["Large Iron Bound Chest"] = "Große eisenbeschlagene Truhe"
NL["Large Solid Chest"] = "Große robuste Truhe"
NL["Large Battered Chest"] = "Große ramponierte Truhe"
NL["Buccaneer's Strongbox"] = "Geldkassette des Bukaniers"
NL["Large Mithril Bound Chest"] = "Große mithrilbeschlagene Truhe"
NL["Large Darkwood Chest"] = "Große Dunkelholztruhe"
NL["Un'Goro Dirt Pile"] = "Erdhaufen von Un'Goro"
NL["Bloodpetal Sprout"] = "Blutblütensprösslinge"
NL["Blood of Heroes"] = "Blut von Helden"
NL["Practice Lockbox"] = "Übungsschließkassette"
NL["Battered Footlocker"] = "Ramponierte Schließkiste"
NL["Waterlogged Footlocker"] = "Durchnässte Schließkiste"
NL["Dented Footlocker"] = "Verbeulte Schließkiste"
NL["Mossy Footlocker"] = "Moosbedeckte Schließkiste"
NL["Scarlet Footlocker"] = "Scharlachrote Schließkiste"
NL["Burial Chest"] = "Grabtruhe"
NL["Fel Iron Chest"] = "Teufelseisentruhe"
NL["Heavy Fel Iron Chest"] = "Schwere Teufelseisentruhe"
NL["Adamantite Bound Chest"] = "Adamantitbeschlagene Truhe"
NL["Felsteel Chest"] = "Teufelsstahltruhe"
NL["Glowcap"] = "Glühkappe"
NL["Wicker Chest"] = "Weidentruhe"
NL["Primitive Chest"] = "Primitive Truhe"
NL["Solid Fel Iron Chest"] = "Robuste Teufelseisentruhe"
NL["Bound Fel Iron Chest"] = "Beschlagene Teufelseisentruhe"
NL["Bound Adamantite Chest"] = "Beschlagene Adamantittruhe"
NL["Netherwing Egg"] = "Ei der Netherschwingen"