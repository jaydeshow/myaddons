-- AtlasLoot loot tables deDE locale file
-- NOTE: THIS FILE IS AUTO-GENERATED BY A TOOL, ANY MANUALLY CHANGE MIGHT BE OVERWRITTEN.
-- $Id$

if GetLocale() == "deDE" then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootRepItems"][category] or #AtlasLoot_Data["AtlasLootRepItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootRepItems"][category][i][3] = data[i] end end data = nil end
Process("AQBroodRings",21,{"","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","","","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","","","","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms","=q4=Siegelring des bronzenen Drachenschwarms"})
Process("Aldor1",27,{"","=q2=Vorlage: Schimmernder Golddraenit","=q1=Pläne: Flammenbannarmschienen","=q1=Muster: Flammenherzarmschienen","","","","","","","","","","","","","=q3=Roben des Anachoret","=q2=Inschrift der Disziplin","=q2=Inschrift des Glaubens","=q2=Inschrift der Rache","=q2=Inschrift des Schutzes","=q2=Vorlage: Königlicher Schattendraenit","=q1=Pläne: Flammenbannhandschuhe","=q1=Muster: Lohenschildgürtel","=q1=Muster: Flammenschuppengürtel","=q1=Muster: Flammenherzhandschuhe","=q1=Muster: Silberner Zauberfaden"})
Process("Aldor2",28,{"","=q3=Halsberge des Verteidigers","=q3=Band des Lichtwächters","=q3=Stab der Auchenai","=q3=Vorlage: Anhänger der Schattenneige","=q1=Pläne: Flammenbannbrustplatte","=q1=Muster: Lohenschildstiefel","=q1=Muster: Flammenschuppenstiefel","=q1=Muster: Rüstungsset des Verteidigers","","","","","","","","=q4=Medaillon des Lichtjüngers","=q4=Glanz des Verteidigers","=q3=Große Inschrift der Disziplin","=q3=Große Inschrift des Glaubens","=q3=Große Inschrift der Rache","=q3=Große Inschrift des Schutzes","=q1=Pläne: Flammenbannhelm","=q1=Muster: Lohenschildhose","=q1=Muster: Flammenschuppengamaschen","=q1=Muster: Goldener Zauberfaden","=q1=Muster: Flammenherzweste","=q1=Wappenrock der Aldor"})
Process("Argent1",25,{"=q3=Geweihter Lederhelm","=q3=Gamaschen des Seuchenjägers","=q3=Band der Frömmigkeit","=q3=Band der Resolution","=q3=Verimondes letzter Ausweg","=q3=Vorratstasche","","=q3=Schattenwächter","","=q2=Insignie der Dämmerung","","","","","","=q4=Armschienen der Hoffnung","=q4=Armschienen der Täuschung","=q4=Amulett der Dämmerung","=q4=Medaillon der Dämmerung","=q4=Talisman der Überlegenheit","=q4=Der Läuterer","","=q3=Eiswächter","","=q2=Insignie des Kreuzzugs"})
Process("Argent2",30,{"","=q1=Angereicherter Manakeks","","","=q2=Rezept: Luft zu Feuer transmutieren","=q1=Pläne: Gurt der Dämmerung","=q1=Formel: Armschiene - Manaregeneration","=q1=Formel: Mächtiges Gegengift","=q1=Muster: Stiefel der Dämmerung","=q1=Muster: Argentumstiefel","","","","=q2=Ehrenmarke der Argentumdämmerung","","","=q2=Arkaner Mantel der Dämmerung","=q2=Flammenmantel der Dämmerung","=q2=Frostmantel der Dämmerung","=q2=Naturmantel der Dämmerung","=q2=Schattenmantel der Dämmerung","=q1=Pläne: Handschuhe der Dämmerung","=q1=Formel: Armschiene - Heilung","=q1=Muster: Goldener Mantel der Dämmerung","=q1=Muster: Argentumschultern","=q1=Gesegnete Sonnenfrucht","=q1=Gesegneter Sonnenfruchtsaft","","","=q2=Chromatischer Mantel der Dämmerung"})
Process("Ashtongue1",25,{"","=q1=Pläne: Dämmerstahlgurt","=q1=Pläne: Dämmerstahlarmschienen","=q1=Muster: Sattelgurt der erlösten Seele","=q1=Muster: Beinschützer der erlösten Seele","=q1=Muster: Armschienen der gefangenen Seelen","=q1=Muster: Stiefel der gefangenen Seelen","=q1=Muster: Gurt der Seelenwache","=q1=Muster: Armschienen der Seelenwache","","","","","","","","=q1=Pläne: Dämmerstahlbeinschützer","=q1=Pläne: Dämmerstahlschuhe","=q1=Muster: Mokassins der erlösten Seele","=q1=Muster: Handgelenksschutz der erlösten Seele","=q1=Muster: Schienbeinschützer der gefangenen Seelen","=q1=Muster: Taillenschutz der gefangenen Seelen","=q1=Muster: Nachtend","=q1=Muster: Gamaschen der Seelenwache","=q1=Muster: Schuhe der Seelenwache"})
Process("Ashtongue2",10,{"","=q4=Aschenzungentalisman der Ausgeglichenheit","=q4=Aschenzungentalisman der Schnelligkeit","=q4=Aschenzungentalisman der Einsicht","=q4=Aschenzungentalisman des Eifers","=q4=Aschenzungentalisman des Scharfsinns","=q4=Aschenzungentalisman der Tödlichkeit","=q4=Aschenzungentalisman der Weitsicht","=q4=Aschenzungentalisman der Schatten","=q4=Aschenzungentalisman der Ehre"})
Process("Bloodsail1",8,{"","=q1=Blutsegelhemd","=q1=Blutsegelschärpe","=q1=Blutsegelhose","=q1=Blutsegelstiefel","","","=q2=Blutsegeladmiralshut"})
Process("CExpedition1",29,{"","=q3=Muster: Schwere Grollhufstiefel","=q2=Pfeil des Spähers","=q1=Bauplan: Grünes Rauchsignal","=q1=Expeditionsleuchtfeuer","","","","","","","","","","","","=q3=Halsberge des Aufsehers","=q3=Knüppel des Bewahrers","=q3=Wanderstab des Forschers","=q3=Muster: Schwere Grollhufweste","=q3=Muster: Schwere Grollhufgamaschen","=q2=Glyphe des Naturschutzes","=q1=Rezept: Erdsturmdiamanten transmutieren","=q1=Rezept: Erdelixier","=q1=Pläne: Adamantitwetzstein","=q1=Pläne: Adamantitgewichtsstein","=q1=Pläne: Große Rune des Schutzes","=q1=Muster: Grollbalgbeinrüstung","=q1=Schlüssel des Kessels"})
Process("CExpedition2",27,{"","=q4=Pläne: Helm der Wildwacht","=q4=Pläne: Gamaschen der Wildwacht","=q3=Gugel des Behüters","=q3=Stärke des Ungezähmten","=q3=Pfeil des Aufsehers","=q3=Vorlage: Nachtaugenpanther","=q2=Glyphe der Wildheit","=q2=Rezept: Urwasser zu Luft transmutieren","=q2=Formel: Handschuhe - Zauberschlag","","","","","","","=q4=Cenarischer Kriegshippogryph","=q4=Kugel des Windrufers","=q4=Ashyens Gabe","=q4=Erdenwächter","=q4=Pläne: Brustplatte der Wildwacht","=q4=Vorlage: Der Schutz der Natur","=q3=Formel: Umhang - Verstohlenheit","=q2=Rezept: Fläschchen der destillierten Weisheit","=q1=Rezept: Erheblicher Naturschutztrank","=q1=Muster: Netherkluftbeinrüstung","=q1=Wappenrock der Expedition des Cenarius"})
Process("Cenarion1",26,{"=q1=Pläne: Schwerer Obsidiangürtel","=q1=Pläne: Eisenrankengürtel","=q1=Formel: Umhang - Großer Feuerwiderstand","=q1=Muster: Dornenholzgürtel","=q1=Muster: Sandpirscherarmschienen","=q1=Muster: Feuerspuckerarmschienen","=q1=Muster: Sylvanschultern","=q1=Muster: Cenarische Kräutertasche","","=q2=Cenarisches Gefechtsabzeichen","=q2=Cenarisches Versorgungsabzeichen","=q2=Mal von Remulos","","","","","=q3=Erdgewebeumhang","=q3=Handschuhe der Erdstärke","=q3=Band des Erdzorns","","","","","","=q2=Cenarisches Strategieabzeichen","=q2=Mal des Cenarius"})
Process("Cenarion2",19,{"=q1=Pläne: Eisenrankenhandschuhe","=q1=Pläne: Leichter Obsidiangürtel","=q1=Formel: Umhang - Großer Naturwiderstand","=q1=Muster: Dornenholzstiefel","=q1=Muster: Sandpirscherstulpen","=q1=Muster: Feuerspuckerstulpen","=q1=Muster: Sylvankrone","","","","","","","","","","=q3=Erdmachtweste","=q3=Band der Erdmacht","=q3=Erdanmut"})
Process("Cenarion3",20,{"=q1=Pläne: Eisenrankenbrustplatte","=q1=Pläne: Gezackter Obsidianschild","=q1=Muster: Dornenholzhelm","=q1=Muster: Sandpirscherbrustplatte","=q1=Muster: Feuerspuckerbrustplatte","=q1=Muster: Gaeas Umarmung","=q1=Muster: Cenarischer Ranzen","=q1=Muster: Sylvanweste","","","","","","","","","=q4=Felszornarmschienen","=q4=Tiefsteinarmschienen","=q4=Macht des Cenarius","=q4=Kugel der Erdruhe"})
Process("Cenarion4",19,{"=q1=Pläne: Obsidianpanzertunika","=q1=Muster: Traumschuppenbrustplatte","","","","","","","","","","","","","","","=q4=Zorn des Cenarius","=q4=Erdschlag","=q4=Faust des Cenarius"})
Process("Consortium1",27,{"","=q3=Muster: Teufelslederhandschuhe","=q2=Formel: Umhang - Zauberdurchschlagskraft","=q2=Vorlage: Unbeständiger Schattendraenit","=q2=Vorlage: Glänzender Flammenspessarit","","","","","","","","","","","","=q3=Nethersplitter","=q3=Gabe der Astralen","=q3=Munitionsbeutel des Schmugglers","=q3=Muster: Teufelslederstiefel","=q2=Vorlage: Feingeschliffener Blutgranat","=q2=Vorlage: Irisierender Azurmondstein","=q2=Vorlage: Kompakter Golddraenit","=q1=Formel: Waffe - Erhebliches Schlagen","=q1=Vorlage: Flüchtiger Himmelsfeuerdiamant","=q1=Vorlage: Mächtiger Erdsturmdiamant","=q1=Muster: Juwelenbeutel"})
Process("Consortium2",21,{"","=q3=Weste der Sturmsäule","=q3=Gamaschen des Nomaden","=q3=Konsortiumblaster","=q3=Vorlage: Anhänger der Nullrune","=q3=Muster: Teufelsledergamaschen","=q1=Formel: Ring - Schlagen","=q1=Bauplan: Elementare Zephyriumladung","=q1=Vorlage: Starker Erdsturmdiamant","=q1=Vorlage: Blutrote Sonne","=q1=Vorlage: Don Julios Herz","","","","","","=q4=Gugel des Netherläufers","=q4=Haramads Handel","=q4=List von Khoraazi","=q3=Vorlage: Unerbittlicher Erdsturmdiamant","=q1=Wappenrock des Konsortiums"})
Process("Darkmoon1",21,{"=q4=Amulett des Dunkelmonds","=q4=Kugel des Dunkelmonds","=q2=Großer Dunkelmond-Preis","=q2=Geringer Dunkelmond-Preis","=q2=Kleiner Dunkelmond-Preis","=q1=Dunkelmond-Lagerbehälter","=q1=Hammel des letzten Jahres","=q1=Bauplan: Dampfpanzersteuerung","=q1=Hammel des letzten Monats","=q1=Dunkelmond-Blume","","=q1=Gewinnlos des Dunkelmond-Jahrmarkts","","","","=q3=Dunkelmond-Halskette","=q3=Dunkelmond-Ring","","=q1=Baumfroschkasten","=q1=Waldfroschkasten","=q1=Das kleine Zuhause eines Jublings"})
Process("Darkmoon2",26,{"=q4=Bestienkartenset","=q4=Dunkelmond-Karte: Blauer Drache","","=q4=Elementarkartenset","=q4=Dunkelmond-Karte: Maelstrom","","=q4=Kriegsfürstenkartenset","=q4=Dunkelmond-Karte: Heldentum","","=q4=Portalkartenset","=q4=Dunkelmond-Karte: Wirbelnder Nether","","","","","=q4=Furienkartenset","=q4=Dunkelmond-Karte: Vergeltung","","=q4=Sturmkartenset","=q4=Dunkelmond-Karte: Zorn","","=q4=Segenskartenset","=q4=Dunkelmond-Karte: Kreuzzug","","=q4=Deliriumkartenset","=q4=Dunkelmond-Karte: Wahnsinn"})
Process("Defilers",2,{"","=q1=Wappenrock der Entweihten"})
Process("Frostwolf1",19,{"=q4=Abzeichen der Frostwölfe Rang 6","=q3=Abzeichen der Frostwölfe Rang 5","=q3=Abzeichen der Frostwölfe Rang 4","=q2=Abzeichen der Frostwölfe Rang 3","=q2=Abzeichen der Frostwölfe Rang 2","=q2=Abzeichen der Frostwölfe Rang 1","","","","","","","","","","=q3=Kaltgeschmiedeter Hammer","=q3=Eisstachelspeer","=q3=Zauberstab der beißenden Kälte","=q3=Blutsucher"})
Process("GelkisClan1",3,{"","=q2=Marodeurskette der Gelkis","=q2=Utheks Finger"})
Process("HonorHold1",25,{"","=q3=Muster: Gürtel des Teufelspirschers","=q2=Vorlage: Robuster Tiefenperidot","=q1=Formel: Armschiene - Überragende Heilung","=q1=Wasserschlauch des Fußsoldaten","=q1=Trockenpilzration","","","","","","","","","","","=q3=Band des Weisen","=q3=Fußsoldatenlangschwert","=q3=Muster: Armschienen des Teufelspirschers","=q3=Muster: Brustplatte des Teufelspirschers","=q2=Glyphe des Feuerschutzes","=q1=Rezept: Himmelsfeuerdiamanten transmutieren","=q1=Rezept: Elixier der erheblichen Beweglichkeit","=q1=Muster: Kobrahautbeinrüstung","=q1=Flammengeschmiedeter Schlüssel"})
Process("HonorHold2",23,{"","=q3=Ring der Genesung","=q3=Höllengeschmiedete Hellebarde","=q3=Teufelsbannpatronen","=q3=Vorlage: Dämmersteinkrebs","=q2=Glyphe der Erneuerung","=q1=Formel: Brust - Außergewöhnliche Werte","=q1=Muster: Munitionsbeutel aus Netherschuppen","","","","","","","","","=q4=Klinge des Erzmagiers","=q4=Ruf der Ehre","=q4=Muskete des Veteranen","=q3=Formel: Umhang - Feingefühl","=q1=Pläne: Teufelsstahlschildstachel","=q1=Muster: Netherkobrabeinrüstung","=q1=Wappenrock der Ehrenfeste"})
Process("KeepersofTime1",30,{"","=q2=Glyphe des Frostschutzes","=q2=Formel: Handschuhe - Erhebliche Zaubermacht","=q1=Formel: Ring - Zaubermacht","=q1=Vorlage: Rätselhafter Himmelsfeuerdiamant","=q1=Vorlage: Facette der Ewigkeit","=q1=Muster: Trommeln der Panik","=q1=Schlüssel der Zeit","","","","","","","","","=q3=Gamaschen des Zeitwächters","=q3=Kontinuumklinge","=q3=Vorlage: Lebendige Rubinschlange","=q3=Vorlage: Anhänger der Eisflamme","=q2=Glyphe des Verteidigers","=q1=Vorlage: Stein der Klingen","","","=q4=Bindungen des Zeitwandlers","=q4=Zeitraffersplitter","=q4=Rissklinge","=q3=Formel: Handschuhe - Überragende Beweglichkeit","=q2=Rezept: Fläschchen der obersten Macht","=q1=Wappenrock der Hüter der Zeit"})
Process("Kurenai1",30,{"","=q3=Muster: Netherzorngürtel","","","=q3=Worgbalgköcher","=q3=Muster: Netherzorngamaschen","=q1=Muster: Trommeln der Wiederherstellung","=q1=Muster: Trommeln des Tempos","=q1=Muster: Verstärkte Bergbautasche","","","=q3=Geschwärzte Lederschiftung","=q3=Kilt der Kurenai","=q3=Band der Elementargeister","=q3=Muster: Netherzornstiefel","=q2=Rezept: Urfeuer zu Urerde transmutieren","","","=q4=Zügel des kobaltblauen Kriegstalbuks","=q4=Zügel des silbernen Kriegstalbuks","=q4=Zügel des braunen Kriegstalbuks","=q4=Zügel des weißen Kriegstalbuks","=q4=Zügel des kobaltblauen Reittalbuks","=q4=Zügel des silbernen Reittalbuks","=q4=Zügel des braunen Reittalbuks","=q4=Zügel des weißen Reittalbuks","=q3=Umhang der Ahnengeister","=q3=Helm des Weissagers","=q3=Arechrons Gabe","=q1=Wappenrock der Kurenai"})
Process("LeagueofArathor",2,{"","=q1=Wappenrock der Arathor"})
Process("LowerCity1",28,{"","=q2=Vorlage: Mächtiger Flammenspessarit","","","=q3=Gamaschen des Exils von Skettis","=q3=Halsberge des Erretters","=q3=Gebetbuch des unteren Viertels","=q3=Vorlage: Teufelsstahleber","=q3=Vorlage: Anhänger des Tauens","=q2=Glyphe der Verstoßenen","=q2=Rezept: Elixier der erheblichen Schattenmacht","=q1=Vorlage: Sternschnuppe","=q1=Muster: Köcher der tausend Federn","","","","=q2=Glyphe des Schattenschutzes","=q1=Formel: Ring - Werte","=q1=Muster: Umhang der Arkanflucht","=q1=Schlüssel der Auchenai","","","=q4=Siegel des Gestaltwandlers","=q4=Hammer der aufgedeckten Geheimnisse","=q4=Dreizack des verstoßenen Stammes","=q3=Formel: Umhang - Ausweichen","=q2=Rezept: Fläschchen des chromatischen Widerstands","=q1=Wappenrock des unteren Viertels"})
Process("Maghar1",30,{"","=q3=Muster: Netherzorngürtel","","","=q3=Grollhufbalgköcher","=q3=Muster: Netherzorngamaschen","=q1=Muster: Trommeln der Wiederherstellung","=q1=Muster: Trommeln des Tempos","=q1=Muster: Verstärkte Bergbautasche","","","=q3=Talbukbalgschiftung","=q3=Gamaschen des Sturms","=q3=Band der Ahnengeister","=q3=Muster: Netherzornstiefel","=q2=Rezept: Urfeuer zu Erde transmutieren","","","=q4=Zügel des kobaltblauen Kriegstalbuks","=q4=Zügel des silbernen Kriegstalbuks","=q4=Zügel des braunen Kriegstalbuks","=q4=Zügel des weißen Kriegstalbuks","=q4=Zügel des kobaltblauen Reittalbuks","=q4=Zügel des silbernen Reittalbuks","=q4=Zügel des braunen Reittalbuks","=q4=Zügel des weißen Reittalbuks","=q3=Zeremonielle Bedeckung","=q3=Kopfputz des Erdenrufers","=q3=Höllschreis Wille","=q1=Wappenrock der Mag'har"})
Process("MagramClan1",3,{"","=q2=Zeremonielle Zentaurendecke","=q2=Jägergürtel der Magram"})
Process("Netherwing1",22,{"","=q2=Abzeichen des Aufsehers","","","=q3=Abzeichen des Hauptmanns","=q3=Peitsche der Himmelsteiler","","","=q3=Abzeichen des Kommandanten","","","","","","","","=q4=Zügel des azurblauen Drachen der Netherschwingen","=q4=Zügel des kobaltblauen Drachen der Netherschwingen","=q4=Zügel des onyxfarbenen Drachen der Netherschwingen","=q4=Zügel des lila Drachen der Netherschwingen","=q4=Zügel des viridiangrünen Drachen der Netherschwingen","=q4=Zügel des violetten Drachen der Netherschwingen"})
Process("Ogrila1",29,{"","=q1=Rotes Ogerspezialgebräu","=q1=Blaues Ogerspezialgebräu","","","=q1=Rotes Ogergebräu","=q1=Blaues Ogergebräu","","","","","","","=q3=Apexiskristall","","","=q3=Apexisumhang","=q3=Kristallgeschmiedetes Schmuckstück","=q3=Aegis von Ogri'la","=q3=Himmelblaue Kristallrute","","","=q4=Splittergebundene Armschienen","=q4=Vortexwandlerstiefel","=q4=Kristallkugel der Erleuchtung","=q4=Kristallarmbrust","=q1=Wappenrock von Ogri'la","","=q1=Apexissplitter"})
Process("ScaleSands1",24,{"=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band des ewigen Champions","","=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band des ewigen Verteidigers","","","","","","","=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band des ewigen Weisen","","=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band der Ewigkeit","=q4=Band des ewigen Bewahrers"})
Process("ScaleSands2",29,{"","=q4=Vorlage: Klobiger Purpurspinell","=q4=Vorlage: Heller Purpurspinell","=q4=Vorlage: Feingeschliffener Purpurspinell","=q4=Vorlage: Runenverzierter Purpurspinell","=q4=Vorlage: Fragiler Purpurspinell","=q4=Vorlage: Tränenförmiger Purpurspinell","=q4=Vorlage: Irisierender Engelssaphir","=q4=Vorlage: Gediegener Engelssaphir","=q4=Vorlage: Funkelnder Engelssaphir","=q4=Vorlage: Brillantiertes Löwenauge","=q4=Vorlage: Schimmerndes Löwenauge","=q4=Vorlage: Glattes Löwenauge","=q4=Vorlage: Kompaktes Löwenauge","","","=q4=Vorlage: Spiegelndes Löwenauge","=q4=Vorlage: Glitzernder Pyrostein","=q4=Vorlage: Glänzender Pyrostein","=q4=Vorlage: Mächtiger Pyrostein","=q4=Vorlage: Tollkühner Pyrostein","=q4=Vorlage: Ausbalancierter Schattensangamethyst","=q4=Vorlage: Leuchtender Schattensangamethyst","=q4=Vorlage: Energieerfüllter Schattensangamethyst","=q4=Vorlage: Schillernder Gischtsmaragd","=q4=Vorlage: Kraftvoller Gischtsmaragd","=q4=Vorlage: Gezackter Gischtsmaragd","=q4=Vorlage: Strahlender Gischtsmaragd","=q4=Vorlage: Beständiger Gischtsmaragd"})
Process("ScaleSands3",9,{"","=q4=Zeitloser Pfeil","=q4=Zeitlose Patrone","","","=q4=Vorlage: Massives Löwenauge","=q4=Vorlage: Tückischer Pyrostein","=q4=Vorlage: Robuster Gischtsmaragd","=q4=Vorlage: Königlicher Schattensangamethyst"})
Process("Scryer1",25,{"","=q2=Vorlage: Runenverzierter Blutgranat","=q1=Pläne: Verzauberter Adamantitgürtel","","","","","","","","","","","","","","=q2=Inschrift der Klinge","=q2=Inschrift des Ritters","=q2=Inschrift des Orakels","=q2=Inschrift des Gestirns","=q2=Vorlage: Schillernder Tiefenperidot","=q1=Pläne: Verzauberte Adamantitstiefel","=q1=Muster: Verzauberte Grollschuppenstiefel","=q1=Muster: Verzauberte Teufelsschuppenhandschuhe","=q1=Muster: Mystischer Zauberfaden"})
Process("Scryer2",27,{"","=q3=Gamaschen des Anhängers","=q3=Stulpen des Auserwählten","=q3=Blutjuwel der Seher","=q3=Stock des Sehers","=q3=Vorlage: Anhänger des Erlöschens","=q2=Rezept: Elixier der erheblichen Feuermacht","=q1=Pläne: Verzauberte Adamantitbrustplatte","=q1=Muster: Verzauberte Grollhufhandschuhe","=q1=Muster: Verzauberte Teufelsschuppenstiefel","=q1=Muster: Rüstungsset des Magisters","","","","","","=q4=Siegel des Sehers","=q4=Klinge des Anhängers","=q3=Große Inschrift der Klinge","=q3=Große Inschrift des Ritters","=q3=Große Inschrift des Orakels","=q3=Große Inschrift des Gestirns","=q1=Pläne: Verzauberte Adamantitgamaschen","=q1=Muster: Verzauberte Grollhufgamaschen","=q1=Muster: Verzauberte Teufelsschuppengamaschen","=q1=Muster: Runenverzierter Zauberfaden","=q1=Wappenrock der Seher"})
Process("Shatar1",30,{"","=q1=Vorlage: Bemerkenswerter Erdsturmdiamant","","","=q3=Gesegneter Schuppengurt","=q3=Xi'ris Gabe","=q3=Vorlage: Talasiteule","=q2=Glyphe der Macht","=q2=Rezept: Urluft zu Feuer transmutieren","=q2=Formel: Waffe - Erhebliche Heilung","=q1=Rezept: Alchimistenstein","=q1=Formel: Ring - Heilkraft","=q1=Vorlage: Bernsteinblut","","","","=q3=Vorlage: Ring des Arkanschutzes","=q2=Glyphe des Arkanschutzes","=q2=Formel: Handschuhe - Erhebliche Heilung","=q1=Vorlage: Kailees Rose","=q1=Muster: Trommeln der Schlacht","=q1=Warpgeschmiedeter Schlüssel","","","=q4=A'dals Gebot","=q4=Hammer des reinen Lichts","=q4=Wappen der Sha'tar","=q3=Formel: Handschuhe - Bedrohung","=q2=Rezept: Fläschchen der Titanen","=q1=Wappenrock der Sha'tar"})
Process("ShattrathFlasks1",4,{"=q1=Fläschchen der Stärkung von Shattrath","=q1=Fläschchen der mächtigen Wiederherstellung von Shattrath","=q1=Fläschchen des unerbittlichen Angriffs von Shattrath","=q1=Fläschchen der obersten Macht von Shattrath"})
Process("Skyguard1",25,{"","=q1=Angereicherter Terozapfensaft","","","=q1=Rationen der Himmelswache","","","=q3=Himmelswachentuch","=q3=Himmelshexertuch","","","","","","","","=q4=Silberkreuz der Himmelswache","=q4=Luftfahrerschleife des Edelmuts","=q4=Blauer Reitnetherrochen","=q4=Grüner Reitnetherrochen","=q4=Roter Reitnetherrochen","=q4=Lila Reitnetherrochen","=q4=Silberner Reitnetherrochen","","=q1=Wappenrock der Himmelswache"}) --Missing: 38628
Process("Sporeggar1",25,{"","=q1=Rezept: Sporlingschmaus","=q1=Rezept: Muschelriegel","=q1=Langstielpilz","=q1=Marschflechte","","","=q3=Schlammbedecktes Tuch","=q3=Versteinerte Schutzflechte","=q1=Roter Fliegenpilz","","=q1=Glühkappe","","","","","=q3=Gehärteter Steinsplitter","=q3=Feuerstab des Sporlings","=q2=Rezept: Urerde zu Wasser transmutieren","","","","=q3=Winziger Sporensegler","=q2=Rezept: Verschleierungstrank","=q1=Wappenrock von Sporeggar"}) --Missing: 38229
Process("Stormpike1",19,{"=q4=Abzeichen der Sturmlanzen Rang 6","=q3=Abzeichen der Sturmlanzen Rang 5","=q3=Abzeichen der Sturmlanzen Rang 4","=q2=Abzeichen der Sturmlanzen Rang 3","=q2=Abzeichen der Sturmlanzen Rang 2","=q2=Abzeichen der Sturmlanzen Rang 1","","","","","","","","","","=q3=Kaltgeschmiedeter Hammer","=q3=Eisstachelspeer","=q3=Zauberstab der beißenden Kälte","=q3=Blutsucher"})
Process("SunOffensive1",27,{"","=q1=Vorlage: Klobiger Purpurspinell","=q1=Vorlage: Strahlender Gischtsmaragd","=q1=Vorlage: Brillantiertes Löwenauge","=q1=Vorlage: Feingeschliffener Purpurspinell","=q1=Vorlage: Schimmerndes Löwenauge","=q1=Vorlage: Irisierender Engelssaphir","=q1=Vorlage: Runenverzierter Purpurspinell","=q1=Vorlage: Glattes Löwenauge","=q1=Vorlage: Gediegener Engelssaphir","=q1=Vorlage: Funkelnder Engelssaphir","=q1=Vorlage: Fragiler Purpurspinell","=q1=Vorlage: Tränenförmiger Purpurspinell","=q1=Vorlage: Kompaktes Löwenauge","=q1=Ration der Naaru","","=q1=Vorlage: Ausbalancierter Schattensangamethyst","=q1=Vorlage: Schillernder Gischtsmaragd","=q1=Vorlage: Glitzernder Pyrostein","=q1=Vorlage: Leuchtender Schattensangamethyst","=q1=Vorlage: Energieerfüllter Schattensangamethyst","=q1=Vorlage: Gezackter Gischtsmaragd","=q1=Vorlage: Glänzender Pyrostein","=q1=Vorlage: Mächtiger Pyrostein","=q1=Vorlage: Strahlender Gischtsmaragd","=q1=Formel: Brust - Verteidigung","=q1=Formel: Brechung der Leere"})
Process("SunOffensive2",26,{"=q4=Vorlage: Kraftvoller Gischtsmaragd","=q4=Vorlage: Spiegelndes Löwenauge","=q4=Vorlage: Tollkühner Pyrostein","=q4=Vorlage: Beständiger Gischtsmaragd","=q1=Vorlage: Robuster Gischtsmaragd","=q1=Vorlage: Massives Löwenauge","=q1=Vorlage: Königlicher Schattensangamethyst","=q1=Vorlage: Tückischer Pyrostein","=q3=Klinge des Bombardiers","=q3=Arglist des Erzmagiers","=q3=Inuuros Klinge","=q3=Der Sonnenbrecher","=q3=K'irus Prophezeiung","=q3=Hammer des Suchenden","=q3=Legionsbann","=q3=Armbrust der Treffsicherheit","=q2=Glyphe des Gladiators","","=q1=Vorlage: Majestätisches Nachtauge","=q1=Vorlage: Glimmender Himmelsfeuerdiamant","=q1=Vorlage: Ewiger Erdsturmdiamant","=q1=Vorlage: Figur - Scharlachrote Schlange","=q1=Vorlage: Figur - Himmlische Schildkröte","=q1=Vorlage: Figur - Khoriumeber","=q1=Vorlage: Figur - Gischtalbatross","=q1=Vorlage: Figur - Schattensangpanther"})
Process("SunOffensive3",23,{"=q3=Vorlage: Spiegelnder Dämmerstein","=q3=Vorlage: Tollkühner Edeltopas","=q3=Vorlage: Kraftvoller Talasit","=q4=Scharfsinnsanhänger der Zerschmetterten Sonne","=q4=Machtanhänger der Zerschmetterten Sonne","=q4=Entschlossenheitsanhänger der Zerschmetterten Sonne","=q4=Wiederherstellungsanhänger der Zerschmetterten Sonne","=q4=Dämmerungsgeschmiedeter Verteidiger","=q4=Sonnengewandtes Wappen","=q1=Vorlage: Scheinender Purpurspinell","=q1=Vorlage: Großes Löwenauge","=q1=Vorlage: Gravierter Pyrostein","=q1=Vorlage: Mystisches Löwenauge","=q1=Vorlage: Geläuterter Schattensangamethyst","=q1=Vorlage: Unbeständiger Schattensangamethyst","=q1=Vorlage: Stattlicher Schattensangamethyst","=q1=Vorlage: Stürmischer Engelssaphir","=q1=Vorlage: Verschleierter Pyrostein","=q1=Rezept: Alchimistenstein des Assassinen","=q1=Rezept: Alchimistenstein des Wächters","=q1=Rezept: Alchimistenstein des Erlösers","=q1=Rezept: Alchimistenstein des Zauberhexers","=q1=Wappenrock der Zerschmetterten Sonne"})
Process("Thorium1",25,{"","=q3=Pläne: Dunkeleisenarmschienen","=q1=Rezept: Elementarfeuer transmutieren","=q1=Formel: Waffe - Stärke","=q1=Muster: Schmelzhelm","=q1=Muster: Kernhundstiefel","=q1=Muster: Flimmerkernhandschuhe","","","","","","","","","","=q3=Pläne: Dunkeleisenzerstörer","=q3=Pläne: Dunkeleisenhäscher","=q3=Pläne: Feuriger Kettengurt","=q1=Pläne: Dunkeleisenhelm","=q1=Formel: Waffe - Mächtige Willenskraft","=q1=Muster: Schwarze Drachenschuppenstiefel","=q1=Muster: Lavagürtel","=q1=Muster: Flimmerkernmantel","=q1=Muster: Flimmerkernrobe"})
Process("Thorium2",20,{"","=q4=Pläne: Sulfuronhammer","=q3=Pläne: Dunkeleisengamaschen","=q3=Pläne: Feurige Kettenschultern","=q1=Pläne: Schattenzorn","=q1=Pläne: Schwarze Amnestie","=q1=Pläne: Dunkeleisenstulpen","=q1=Formel: Waffe - Mächtige Intelligenz","=q1=Muster: Chromatische Stulpen","=q1=Muster: Kernhundgürtel","=q1=Muster: Geschmolzener Gürtel","=q1=Muster: Flimmerkerngamaschen","","","","","=q1=Pläne: Finsterer Streiter","=q1=Pläne: Dunkeleisenstiefel","=q1=Pläne: Ebenholzhand","=q1=Pläne: Nachtlauer"})
Process("Thrallmar1",25,{"","=q3=Muster: Gürtel des Teufelspirschers","=q2=Vorlage: Robuster Tiefenperidot","=q1=Formel: Armschiene - Überragende Heilung","=q1=Wasserschlauch des Grunzers","=q1=Trockenobstration","","","","","","","","","","","=q3=Band des Weissagers","=q3=Kriegsaxt des Grunzers","=q3=Muster: Armschienen des Teufelspirschers","=q3=Muster: Brustplatte des Teufelspirschers","=q2=Glyphe des Feuerschutzes","=q1=Rezept: Himmelsfeuerdiamanten transmutieren","=q1=Rezept: Elixier der erheblichen Beweglichkeit","=q1=Muster: Kobrahautbeinrüstung","=q1=Flammengeschmiedeter Schlüssel"})
Process("Thrallmar2",23,{"","=q3=Ahnenband","=q3=Geschwärzter Speer","=q3=Höllenfeuergeschoss","=q3=Vorlage: Dämmersteinkrebs","=q2=Glyphe der Erneuerung","=q1=Formel: Brust - Außergewöhnliche Werte","=q1=Muster: Munitionsbeutel aus Netherschuppen","","","","","","","","","=q4=Sturmrufer","=q4=Kriegsbringer","=q4=Bogen des Schützen","=q3=Formel: Umhang - Feingefühl","=q1=Pläne: Teufelsstahlschildstachel","=q1=Muster: Netherkobrabeinrüstung","=q1=Wappenrock von Thrallmar"})
Process("Timbermaw",23,{"","=q2=Rezept: Erde zu Wasser transmutieren","=q1=Formel: Zweihandwaffe - Beweglichkeit","=q1=Muster: Kriegsbärenwollwäsche","=q1=Muster: Kriegsbärenharnisch","","","=q2=Medizinbeutel der Furbolgs","=q2=Medizintotem der Furbolgs","=q1=Pläne: Schwerer Gürtel der Holzschlundfeste","=q1=Formel: Waffe - Beweglichkeit","=q1=Muster: Macht der Holzschlundfeste","=q1=Muster: Weisheit der Holzschlundfeste","","","","=q1=Pläne: Schwere Stiefel der Holzschlundfeste","=q1=Muster: Kampfhandschuhe der Holzschlundfeste","=q1=Muster: Mantel der Holzschlundfeste","","","","=q4=Verteidiger der Holzschlundfeste"})
Process("Tranquillien1",23,{"","=q2=Stiefel des Lehrlings","=q2=Stiefel des Moorläufers","=q2=Schienenbeinschützer des Opferbereiten","=q2=Flamberg von Tristessa","","","=q2=Gürtelbund des Apothekers","=q2=Fledermaushautgürtel","=q2=Verteidigergurt von Tristessa","","","","","","","=q2=Robe des Apothekers","=q2=Weste des Todespirschers","=q2=Halsberge der Sonnenkrone","","","","=q3=Umhang des Champions von Tristessa"})
Process("VioletEye1",26,{"","=q3=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel des meisterlichen Auftragsmörders","","","=q3=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel des Erzmagiers","","","","","","=q3=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel des großen Bewahrers","","","=q3=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel","=q4=Violettes Siegel des großen Beschützers"})
Process("VioletEye2",18,{"","=q4=Violettes Abzeichen","=q4=Pläne: Helm der Eiswache","=q4=Pläne: Brustplatte der Eiswache","=q4=Vorlage: Das gefrorene Auge","=q2=Inschrift der Belastbarkeit","=q2=Rezept: Fläschchen des chromatischen Wunders","","","=q4=Mysteriöser Pfeil","=q4=Mysteriöse Patrone","=q4=Pläne: Gamaschen der Eiswache","=q4=Muster: Brustschutz des Schattenschleichers","","","","=q3=Muster: Umhang der Dunkelheit","=q1=Formel: Waffe - Große Beweglichkeit"})
Process("WaterLords1",7,{"","=q3=Meeresbrise","=q3=Gezeitenschleife","=q1=Wässrige Quintessenz","","","=q1=Ewige Quintessenz"})
Process("Wintersaber1",2,{"","=q4=Zügel des Winterquellfrostsäblers"})
Process("Zandalar1",25,{"","=q1=Rezept: Großer Trank des traumlosen Schlafs","=q1=Pläne: Blutseelenstulpen","=q1=Pläne: Dunkelseelenschultern","=q1=Formel: Hervorragendes Manaöl","=q1=Bauplan: Blutrebenlinse","=q1=Muster: Urzeitliche Fledermaushautarmschienen","=q1=Muster: Blutrebenstiefel","","","","=q2=Zandalarianische Ehrenmünze","","","","","=q1=Rezept: Erheblicher Trollbluttrank","=q1=Pläne: Blutseelenschultern","=q1=Pläne: Dunkelseelengamaschen","=q1=Formel: Hervorragendes Zauberöl","=q1=Bauplan: Blutrebenschutzbrille","=q1=Muster: Bluttigerschultern","=q1=Muster: Urzeitliche Fledermaushauthandschuhe","=q1=Muster: Blutrebengamaschen","=q1=Essenzmango"})
Process("Zandalar2",20,{"","=q2=Zanzas Glanz","=q2=Zanzas Geist","=q2=Zanzas Schnelligkeit","=q1=Rezept: Magierbluttrank","=q1=Pläne: Blutseelenbrustplatte","=q1=Pläne: Dunkelseelenbrustplatte","=q1=Muster: Bluttigerbrustplatte","=q1=Muster: Urzeitliches Fledermaushautwams","=q1=Muster: Blutrebenweste","","","","","","","=q3=Zandalarianisches Siegel der Macht","=q3=Zandalarianisches Siegel des Mojo","=q3=Zandalarianisches Siegel der inneren Ruhe","=q1=Rezept: Trank der lebhaften Aktion"})
end