-----------------------------------------------------------------------------
--                                                                         --
--  localization.lua - Language translations for strings.                  --
--                                                                         --
-----------------------------------------------------------------------------

-- Version info:
-- $Author: shen $
-- $Date: 2008-01-30 10:57:52 -0500 (Wed, 30 Jan 2008) $
-- $Revision: 59743 $
-- $HeadURL: svn://dev.wowace.com/wowace/trunk/PoliteWhisper/localization.lua $

-- Based on work by gre7g

-- This module is a list of strings used by the mod and what text should be
-- used based on language.

function PoliteWhisper_GermanClasses()
		PW_D_DRUID              = "Druide";
		PW_D_HUNTER             = "J\195\164ger";
		PW_D_MAGE               = "Magier";
		PW_D_PALADIN            = "Paladin";
		PW_D_PRIEST             = "Priester";
		PW_D_ROGUE              = "Schurke";
		PW_D_SHAMAN             = "Schamane";
		PW_D_WARLOCK            = "Hexenmeister";
		PW_D_WARRIOR            = "Krieger";
end
function PoliteWhisper_GermanUI()
		PW_TITLE              = "Polite Whisper Extended";
		PW_INVITE_TO          = "Spieler einladen f\195\188r:";
		PW_LEVEL_COLON        = "Level:";
		PW_HYPHEN             = "-";
		PW_SEARCH_CLASSES     = "Suche nach Klassen:";
		PW_NAME               = "Name";
		PW_CLASS              = "Klasse";
		PW_LEVEL              = "Level";
		PW_ZONE               = "Zone";
		PW_GUILD              = "Gilde";
		PW_SEARCH             = "Suchen";
		PW_STOP_SEARCH        = "Suche anhalten";
		PW_WHO_DO_WE_HAVE     = "Wen haben wir bereits?";
		PW_INVITE             = "Einladen";
		PW_USER_DECLINED      = "Spieler hat abgelehnt";
		PW_IGNORE_WARN1       = "Indem man Spieler zu dieser Liste " ..
				"hinzuf\195\188gt  verhindert man, dass sie bei der";
		PW_IGNORE_WARN2       = "Gruppensuche  erscheinen. Das ist wesentlich " ..
				"netter als sie auf die Ignore-Liste zu";
		PW_IGNORE_WARN3       = "setzen.";
		PW_ADD                = "Hinzuf\195\188gen";
		PW_DELETE             = "Entfernen";
		PW_MINIMAP_BUTTON     = "Minimap Button:";
		PW_ENABLE             = "Aktivieren";
		PW_POSITION           = "Position";
		PW_DISTANCE           = "Distanz";
		PW_PARTY_FINDER       = "Gruppen-Finder";
		PW_DO_NOT_INVITE      = "NICHT einladen";
		PW_CONFIGURATION      = "Konfiguration";
		PW_SLASH_COMMAND      = "/pw";
		PW_STARTUP_TEXT       = "Schreib \"/pw\" um Polite Whisper zu " ..
				"\195\182ffnen";
		PW_NO_DUNGEON_ERR     = "Spieler wozu einladen?";
		PW_NO_MIN_ERR         = "Ab welchem Level?";
		PW_NO_MAX_ERR         = "Bis zu welchem Level?";
		PW_NO_RESP_ERR        = "Der Server hat deine /who-Anfrage nicht " ..
				"beantwortet.";
		PW_REASK              = "Nochmal fragen";
		PW_ASK                = "Fragen";
		PW_CHAT               = "Chatten";
		PW_NO_USER_ADD_ERR    = "Wer soll auf die \"Nicht-einladen-Liste\"?";
		PW_USER_ON_LIST_ERR   = "Dieser Spieler ist schon auf der Liste.";
		PW_NO_USER_DEL_ERR    = "Wen sollen wir von der " ..
				"\"Nicht-einladen-Liste\" streichen?";
		PW_USER_NOT_ON_ERR    = "Dieser Spieler ist nicht auf der Liste.";
		PW_INCOME_WHISPER     = "[%s] fl\195\188stert: %s";
		PW_OUTGOING_WHISPER   = "Zu [%s]: %s";
		PW_DUNGEON            = "Dungeon";
		PW_AFK                = "AFK";
		PW_DELETED            = "Gel\195\182scht";
		PW_PENDING            = "W\195\164hrend dessen";
		PW_DECLINE            = "Ablehnen";
		PW_NOTES              = "Notizen";
		PW_IGNORE_GROUP_WARN1 = "Achtung!  Du bist gerade mit %s in einer " ..
				"Gruppe, welche(r) auf deiner nicht-einladen Liste ist.  Bist du " ..
				"sicher, dass du das m\195\182chtest?"
		PW_IGNORE_GROUP_WARN2 = "Achtung!  Du bist gerade mit %s in einer " ..
				"Gruppe, welche(r) auf deiner nicht-einladen Liste ist.  Du hast " ..
				"folgende Notiz dazu erstellt: %s"
		PW_OTHER_LABEL        = "Anderes...";
		PW_SLOT_LABEL         = "Platz ist belegt";
		PW_PARTY_LABEL        = "Gruppe ist voll";
		PW_PARTY              = "Gruppe";
		PW_PARTY1             = "Dies ist ein experimentelles Notizfeld, um diverse Eigenschaften von Gruppen";
		PW_PARTY2             = "mitgliedern zu notieren. Es gehört nicht zur Hauptaufgabe von Polite Whisper.";
		PW_PARTY3             = "Wenn man mit manchen Leuten öfter zusammen spielt, mag es einfach";
		PW_PARTY4             = "erscheinen sich zu merken wer einen extra Heiler ben?tigt, oder wer nicht die";
		PW_PARTY5             = "Gruppenführung übernehmen sollte. Aber bei Leuten, mit denen man selten";
		PW_PARTY6             = "etwas unternimmt, ist es praktischer sich ein paar Notizen zu machen. Eventuell";
		PW_PARTY7             = "ist es so einfacher sich Notizen zu machen, als alles auf Papier festzuhalten.";
		PW_REMEMBER_QUEST     = "Merke diese Frage";
		PW_NO_QUEST           = "Enter a question to remember and then select " ..
				"that  option.";
		PW_NOTES              = "Notizen";
		PW_CUSTOMWHISPERS     = "Eigene Nachrichten";
		PW_CUSTOM1            = "Normaler Fragesatz";
		PW_CUSTOM2            = "Spezieller Fragesatz (bei der Suche einer speziellen Skillung)";
		PW_CUSTOM3            = "Antwort, wenn der Spieler ablehnt";
		PW_CUSTOM4            = "Request to group leader to invite the player";
		PW_CUSTOM5            = "Welche Klassen und Level haben die Gruppenmitglieder";
		PW_CUSTOM6            = "Informationsnachricht, dass der Gruppenanführer gefragt wurde";
		PW_CUSTOM7            = "Platz belegt";
		PW_CUSTOM8            = "Gruppe vollständig";
		PW_TAG_P_DESC         = "|cFF80FF80$P|r = Name des Spielers, der angeschrieben wird";
		PW_TAG_L_DESC         = "|cFF80FF80$L|r = Level des Spielers, der angeschrieben wird";
		PW_TAG_C_DESC         = "|cFF80FF80$C|r = Klasse des Spielers, der angeschrieben wird";
		PW_TAG_D_DESC         = "|cFF80FF80$R|r = Gewünschte Rolle des Spielers, z.B. Tank, Heiler, DD, Offtank usw.";
		PW_TAG_R_DESC         = "|cFF80FF80$D|r = Name der Zielzone oder -instanz";
		PW_TAG_N_DESC         = "|cFF80FF80$N|r  = Anzahl der Spieler in der Gruppe";
		PW_TAG_B_DESC         = "|cFF80FF80$B|r  = Name des Gruppenanführers";
		PW_TAG_G_DESC         = "|cFF80FF80$G|r  = Gruppenaufstellung (Klassen und Level)";
		PW_TEST               = "Test";
		PW_RESET              = "Zurücksetzen";
end
function PoliteWhisper_GermanWhispers()
		PW_INVITATION_WHISPER = "Verzeiht  meine St\195\182rung, doch " ..
				"h\195\164ttet Ihr vielleicht  Interesse, uns in die Instanz: $D " ..
				"zu  begleiten?";
		PW_SPECIAL_INVITE     = "Verzeiht  meine St\195\182rung, aber unsere " ..
				"Gruppe  sucht noch nach einem $R. H\195\164ttet Ihr vielleicht " ..
				"Interesse,  uns in die Instanz: $D zu begleiten?";
		PW_APOLOGY            = "Gar kein  Problem, entschuldige bitte die " ..
				"St\195\182rung.";
		PW_INVITE_REQUEST     = "Ich h\195\164tte  einen Level $L $C gefunden " ..
				"der mitkommen w\195\188rde  als $R! K\195\182nntet ihr bitte $P einladen? " ..
				"Danke!";
		PW_PARTY_MAKEUP1      = "Bis jetzt sind  wir $G";
		PW_PARTY_MAKEUP2      = "ein %s  (%d)";
		PW_PARTY_MAKEUP3      = ", ein %s  (%d)";
		PW_INVITE_WARNING     = "Ich werde jetzt $B anfl\195\188stern damit er " ..
				"dich einl\195\164dt.";
		PW_SLOT_FULL          = "Es tut mir Leid, aber wir haben diesen Platz " ..
				"gerade  gef\195\188llt. Vielleicht k\195\182nnt Ihr das " ..
				"n\195\164chste  Mal mitkommen.";
		PW_PARTY_FULL         = "Es  tut mir Leid, aber unsere Gruppe ist " ..
				"soeben  voll geworden. Vielleicht k\195\182nnt Ihr das " ..
				"n\195\164chste  Mal mitkommen.";

		-- Specializations
		PW_SPECIALIZE = {};
		PW_SPECIALIZE[PW_DRUID]   = {{"Druide", "Druiden"},
				{"Heiler", "Druiden (als Heiler"}, {"Tank", "Druiden (als Tank)"},
				{"DD", "Druiden (als DD)"}};
		PW_SPECIALIZE[PW_HUNTER]  = {{"J\195\164ger", "J\195\164ger"},
				{"Off-Tank", "J\195\164ger (als Off-Tank)"},
				{"DPS", "J\195\164ger (als DD)"}};
		PW_SPECIALIZE[PW_PALADIN] = {{"Paladin", "Paladin"},
				{"Heiler", "Paladin (als Heiler)"}, {"Tank", "Paladin (als Tank)"}};
		PW_SPECIALIZE[PW_PRIEST]  = {{"Priester", "Priester"},
				{"Heiler", "Priester (als Heiler)"}, {"DPS", "Priester (als DD)"}};
		PW_SPECIALIZE[PW_SHAMAN]  = {{"Schamane", "Schamane"},
				{"Heiler", "Schamanen (als Heiler)"}, {"DPS", "Schamanen (als DD)"}};
		PW_SPECIALIZE[PW_WARRIOR] = {{"Krieger", "Krieger"},
				{"Tank", "Krieger (als Tank)"}, {"DPS", "Krieger (als DD)"}};
		PW_SPECIALIZE_OTHER_PREPEND = "";
		PW_SPECIALIZE_OTHER_APPEND = "";

		-- Dungeons
		PW_DUNGEONS =
		{
				{"Auchindoun - Auchenaikrypta",                              65, 67},
				{"Auchindoun - Managruft",                                   64, 66},
				{"Auchindoun - Schattenlabyrinth",                           70, 70},
				{"Auchindoun - Sethekkhallen",                               67, 69},
				{"Burg Schattenfang",                                        20, 26},
				{"D\195\188sterbruch (Nord)",                                60, 63},
				{"D\195\188sterbruch (Ost)",                                 58, 62},
				{"D\195\188sterbruch (West)",                                60, 63},
				{"Das scharlachrote Kloster",                                38, 42},
				{"Das Verlies",                                              25, 29},
				{"Der Echsenkessel - Der Tiefensumpf",                       63, 65},
				{"Der Echsenkessel - Die Dampfkammer",                       70, 70},
				{"Der Echsenkessel - Die Sklavenunterk\195\188nfte",         62, 64},
				{"Der Flammenschlund",                                       13, 18},
				{"Der schwarze Morast",                                      68, 70},
				{"Der Tempel von Atal'Hakkar",                               50, 55},
				{"Die H\195\182hlen des Wehklagens",                         17, 24},
				{"Die Todesminen",                                           15, 22},
				{"Die zerschmetterten Hallen",                               70, 70},
				{"Festung der St\195\188rme - Arkatraz",                     70, 70},
				{"Festung der St\195\188rme - Botanikum",                    70, 70},
				{"Festung der St\195\188rme - Mechanar",                     70, 70},
				{"Gnomeregan",                                               30, 35},
				{"H\195\182llenfeuerhalbinsel",                              58, 63},
				{"H\195\182llenfeuerzitadelle - Der Blutkessel",             60, 62},
				{"H\195\182llenfeuerzitadelle - H\195\182llenfeuerbollwerk", 60, 62},
				{"H\195\188gel der Klingenhauer",                            38, 42},
				{"Kral der Klingenhauer",                                    29, 34},
				{"Maraudon",                                                 45, 51},
				{"Nagrand",                                                  64, 67},
				{"Nethersturm",                                              67, 70},
				{"Obere Schwarzfelsspitze",                                  60, 63},
				{"Schattenmondtal",                                          67, 70},
				{"Schergrat",                                                65, 68},
				{"Scholomance",                                              60, 63},
				{"Schwarzfelstiefen",                                        52, 60},
				{"(Live) Stratholme",                                        58, 62},
				{"(Untot) Stratholme",                                       58, 62},
				{"Tiefschwarze Grotte",                                      22, 28},
				{"Uldaman",                                                  36, 45},
				{"Untere Schwarzfelsspitze",                                 57, 61},
				{"Vorgebirge des Alten H\195\188gellands",                   66, 68},
				{"W\195\164lder von Terokkar",                               62, 65},
				{"Zangarmarschen",                                           60, 64},
				{"Zul'Farrak",                                               40, 47}
		};
		PW_HEROIC_DUNGEONS =
		{
				{"Auchindoun  - Auchenaikrypta",                70, 70},
				{"Auchindoun - Managruft",                      70, 70},
				{"Auchindoun - Schattenlabyrinth",              70, 70},
				{"Auchindoun - Sethekkhallen",                  70, 70},
				{"Caverns of Time - Escape from Durnholde Keep",70, 70},
				{"Caverns of Time - Opening the Dark Portal",   70, 70},
				{"Der Echsenkessel - Der Tiefensumpf",          70, 70},
				{"Der Echsenkessel - Die Dampfkammer",          70, 70},
				{"Der Echsenkessel - Die Sklavenunterk\195\188nfte",    70, 70},
				{"Festung der St\195\188rme - Arkatraz",                70, 70},
				{"Festung der St\195\188rme - Botanikum",               70, 70},
				{"Festung der St\195\188rme - Mechanar",                70, 70},
				{"H\195\182llenfeuerhalbinsel",                 70, 70},
				{"H\195\182llenfeuerzitadelle - Der Blutkessel",        70, 70},
				{"H\195\182llenfeuerzitadelle - H\195\182llenfeuerbollwerk",      70, 70}

		};
end
-- French version (by Kubik)
-- � \195\160
-- ޽ \195\162
-- 垽 \195\167
-- 枽 \195\168
-- 瞽 \195\169
-- 螽 \195\170
-- 잽 \195\174
-- ힽ \195\175
-- 򞻠\195\180
-- �195\187
function PoliteWhisper_FrenchClasses()
		PW_D_DRUID              = "Druide";
		PW_D_HUNTER             = "Chasseur";
		PW_D_MAGE               = "Mage";
		PW_D_PALADIN            = "Paladin";
		PW_D_PRIEST             = "Pr\195\170tre";
		PW_D_ROGUE              = "Voleur";
		PW_D_SHAMAN             = "Chaman";
		PW_D_WARLOCK            = "D\195\169moniste";
		PW_D_WARRIOR            = "Guerrier";
end
function PoliteWhisper_FrenchUI()
		PW_TITLE              = "Polite Whisper Extended";
		PW_INVITE_TO          = "Inviter joueurs \195\160:";
		PW_LEVEL_COLON        = "Niveau:";
		PW_HYPHEN             = "-";
		PW_SEARCH_CLASSES     = "Classes \195\160 chercher:";
		PW_NAME               = "Nom";
		PW_CLASS              = "Classe";
		PW_LEVEL              = "Niveau";
		PW_ZONE               = "Zone";
		PW_GUILD              = "Guilde";
		PW_SEARCH             = "Rech.";
		PW_STOP_SEARCH        = "Stop Rech.";
		PW_WHO_DO_WE_HAVE     = "Qui avons nous ?";
		PW_INVITE             = "Inviter";
		PW_USER_DECLINED      = "Refus du joueur";
		PW_IGNORE_WARN1       = "L'ajout de joueurs dans cette liste " ..
				"\195\169vite de les voir dans la liste ";
		PW_IGNORE_WARN2       = "de recherche. Entrer un commentaire permet de";
		PW_IGNORE_WARN3       = "se souvenir de la raison.";
		PW_ADD                = "Ajouter";
		PW_DELETE             = "Effacer";
		PW_MINIMAP_BUTTON     = "Bouton Minimap:";
		PW_ENABLE             = "Activer";
		PW_POSITION           = "Position";
		PW_DISTANCE           = "Distance";
		PW_PARTY_FINDER       = "Recherche";
		PW_DO_NOT_INVITE      = "NE PAS Inviter";
		PW_CONFIGURATION      = "Configuration";
		PW_SLASH_COMMAND      = "/pw";
		PW_STARTUP_TEXT       = "Taper \"/pw\" pour ouvrir Polite Whisper";
		PW_NO_DUNGEON_ERR     = "Inviter pour quoi ?";
		PW_NO_MIN_ERR         = "Niveau minimum des joueurs �nviter ?";
		PW_NO_MAX_ERR         = "Niveau maximum des joueurs �nviter ?";
		PW_NO_RESP_ERR        = "Le serveur ne r\195\169pond pas \195\160 la " ..
				"requ\195\170te /who.";
		PW_REASK              = "Re-Demander";
		PW_ASK                = "Demander";
		PW_CHAT               = "Chatter";
		PW_NO_USER_ADD_ERR    = "Qui ajouter �a liste 'ne pas inviter' ?";
		PW_USER_ON_LIST_ERR   = "Ce joueur est d\195\169j\195\160 dans la liste.";
		PW_NO_USER_DEL_ERR    = "Qui effacer de la liste 'ne pas inviter' ?"
		PW_USER_NOT_ON_ERR    = "Ce joueur n'est pas dans la liste.";
		PW_INCOME_WHISPER     = "[%s] chuchote: %s";
		PW_OUTGOING_WHISPER   = "A [%s]: %s";
		PW_DUNGEON            = "Donjon";
		PW_AFK                = "AFK";
		PW_DELETED            = "Effac\195\169";
		PW_PENDING            = "En attente";
		PW_DECLINE            = "D\195\169cliner";
		PW_NOTES              = "Notes";
		PW_IGNORE_GROUP_WARN1 = "Attention!  Tu as group\195\169 %s, qui est " ..
				"dans la liste 'ne pas inviter'. Es-tu s\195\187r de ton choix ?"
		PW_IGNORE_GROUP_WARN2 = "Attention!  Tu as group\195\169 %s, qui est " ..
				"dans la liste 'ne pas inviter'. La note sur ce joueur est: %s"
		PW_OTHER_LABEL        = "Autre...";
		PW_SLOT_LABEL         = "La place est prise.";
		PW_PARTY_LABEL        = "Le groupe est complet.";
		PW_PARTY              = "Groupe";
		PW_PARTY1             = "C'est un onglet experimental pour garder une " ..
				"trace des joueurs groupes.";
		PW_PARTY2             = " ";
		PW_PARTY3             = " ";
		PW_PARTY4             = " ";
		PW_PARTY5             = " ";
		PW_PARTY6             = " ";
		PW_PARTY7             = " ";
		PW_REMEMBER_QUEST     = "Se rappeler cette question.";
		PW_NO_QUEST           = "Entrer une question \195\160 se rappeler et " ..
				"s\195\169lectionner cette option.";
		PW_NOTES              = "Notes";
		PW_CUSTOMWHISPERS     = "Custom Whispers";
		PW_TEST               = "Test";
		PW_RESET              = "Reset";
end
function PoliteWhisper_FrenchWhispers()
		PW_INVITATION_WHISPER = "D\195\169sol\195\169 de d\195\169ranger, " ..
				"serais tu interess\195\169 de nous rejoindre pour $D?";
		PW_SPECIAL_INVITE     = "D\195\169sol\195\169 de d\195\169ranger, " ..
				"notre groupe recherche $R. Es-tu int\195\169ress\195\169 pour $D?";
		PW_APOLOGY            = "Pas de probl\195\168me. D\195\169sol\195\169 de " ..
				"t'avoir d\195\169rang\195\169.";
		PW_INVITE_REQUEST     = "J'ai trouv\195\169 un ($L) $C comme $R. " ..
				"Peux tu inviter $P? Merci!";
		PW_PARTY_MAKEUP1      = "Nous sommes $G.";
		PW_PARTY_MAKEUP2      = "un %s (%d)";
		PW_PARTY_MAKEUP3      = ", un %s (%d)";
		PW_INVITE_WARNING     = "Je whisp $B pour qu'il t'invite.";
		PW_SLOT_FULL          = "D\195\169sol\195\169, la place vient " ..
				"d'\195\170tre prise. Peut-\195\170tre une autre fois.";
		PW_PARTY_FULL         = "D\195\169sol\195\169, le groupe est complet. " ..
				"Peut-\195\170tre une autre fois.";

		-- Specializations
		PW_SPECIALIZE = {};
		PW_SPECIALIZE[PW_DRUID]   = {{"Druide", "un druide"},
				{"Healer", "un healer"}, {"Tank", "un tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_HUNTER]  = {{"Chasseur", "un chasseur"},
				{"Off-Tank", "un off-tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_PALADIN] = {{"Paladin", "un paladin"},
				{"Healer", "un healer"}, {"Tank", "un tank"}};
		PW_SPECIALIZE[PW_PRIEST]  = {{"Pr\195\170tre", "un pr\195\170tre"},
				{"Healer", "un healer"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_SHAMAN]  = {{"Chaman", "un chaman"},
				{"Healer", "un healer"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_WARRIOR] = {{"Guerrier", "un guerrier"},
				{"Tank", "un tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE_OTHER_PREPEND = "un ";
		PW_SPECIALIZE_OTHER_APPEND = "";

		-- Dungeons
		PW_DUNGEONS =
		{
				{"Les Cryptes Auchena\195\175",                 65, 67},
				{"Tombes Mana",                                 64, 66},
				{"Les Salles de Sethekk",                       67, 69},
				{"Le Labyrinthe des Ombres",                    70, 70},
				{"Les Profondeurs de Brassenoire",              22, 28},
				{"Les Profondeurs de Rochenoire",               52, 60},
				{"Les Tranchantes",                             65, 68},
				{"Glissecroc - Les enclos aux esclaves",        62, 64},
				{"Glissecroc - Le Caveau de la vapeur",         70, 70},
				{"Glissecroc - La Basse-tourbi\195\168re",      63, 65},
				{"Hache-Tripes - Est",                          58, 62},
				{"Hache-Tripes - Nord",                         60, 63},
				{"Hache-Tripes - Ouest",                        60, 63},
				{"Gnomeregan",                                  30, 35},
				{"La Fournaise du sang",                        60, 62},
				{"Les Remparts",                                60, 62},
				{"La P\195\169ninsule des Flammes Infernales",  58, 63},
				{"Stratholme",                                  58, 62},
				{"Le Pic Rochenoire (bas)",                     57, 61},
				{"Maraudon",                                    45, 51},
				{"Nagrand",                                     64, 67},
				{"Raz-de-N\195\169ant",                         67, 70},
				{"Hautebrande d'Antan",                         66, 68},
				{"Le Gouffre de Ragefeu",                       13, 18},
				{"Les Souilles de Tranchebauge",                38, 42},
				{"Kraal de Tranchebauge",                       29, 34},
				{"Le Monast籥 Ecarlate",                       38, 42},
				{"Scholomance",                                 60, 63},
				{"Shadowfang Keep",                             20, 26},
				{"Vall\195\169e d'Ombrelune",                   67, 70},
				{"Le Temple Englouti",                          50, 55},
				{"L'Arcatraz",                                  70, 70},
				{"La Botanica",                                 70, 70},
				{"Le M\195\169chanar",                          70, 70},
				{"La For\195\170t de Terokkar",                 62, 65},
				{"Le Noir Mar\195\169cage ",                    68, 70},
				{"Fort de Durn ",                               68, 70},
				{"Les Mortemines",                              15, 22},
				{"Les Salles bris\195\169es",                   70, 70},
				{"La Prison",                                   25, 29},
				{"Uldaman",                                     36, 45},
				{"Stratholme",                                  58, 62},
				{"Le Pic Rochenoire (haut)",                    60, 63},
				{"Les Cavernes des Lamentations",               17, 24},
				{"Le Mar\195\169cage de Zangar",                60, 64},
				{"Zul'Farrak",                                  40, 47}
		};
		-- Fin Fran栩s VT
end
function PoliteWhisper_ItalianClasses()
		PW_D_DRUID   = "Druid";
		PW_D_HUNTER  = "Hunter";
		PW_D_MAGE    = "Mage";
		PW_D_PALADIN = "Paladin";
		PW_D_PRIEST  = "Priest";
		PW_D_ROGUE   = "Rogue";
		PW_D_SHAMAN  = "Shaman";
		PW_D_WARLOCK = "Warlock";
		PW_D_WARRIOR = "Warrior";
end
function PoliteWhisper_ItalianUI()
		PW_TITLE              = "Polite Whisper Extended";
		PW_INVITE_TO          = "Invita utenti a:";
		PW_LEVEL_COLON        = "Livello:";
		PW_HYPHEN             = "-";
		PW_SEARCH_CLASSES     = "Classi da cercare:";
		PW_NAME               = "Nome";
		PW_CLASS              = "Classe";
		PW_LEVEL              = "Livello";
		PW_ZONE               = "Zona";
		PW_GUILD              = "Gilda";
		PW_SEARCH             = "Cerca";
		PW_STOP_SEARCH        = "Ferma Ricerca";
		PW_WHO_DO_WE_HAVE     = "Chi abbiamo?";
		PW_INVITE             = "Invita";
		PW_USER_DECLINED      = "L'utente ha rifiutato";
		PW_IGNORE_WARN1       = "I giocatori aggiunti a questa lista verranno " ..
				"esclusi dalla ricerca di membri del party.";
		PW_IGNORE_WARN2       = "Questo metodo non \195\168 severo come " ..
				"mettere nominativi nella lista Ignore. Aggiungere";
		PW_IGNORE_WARN3       = "un commento ti aiuter\195\160 a ricordare " ..
				"perch\195\169 non vuoi fare gruppo con questi giocatori.";
		PW_ADD                = "Aggiungi";
		PW_DELETE             = "Elimina";
		PW_MINIMAP_BUTTON     = "Pulsante Minimap:";
		PW_ENABLE             = "Abilita";
		PW_POSITION           = "Posizione";
		PW_DISTANCE           = "Distanza";
		PW_PARTY_FINDER       = "Cerca Party";
		PW_DO_NOT_INVITE      = "NON Invitare";
		PW_CONFIGURATION      = "Configurazione";
		PW_SLASH_COMMAND      = "/pw";
		PW_STARTUP_TEXT       = "Scrivi \"/pw\" per aprire Polite Whisper";
		PW_NO_DUNGEON_ERR     = "Invita Utenti ad unirsi per fare cosa?";
		PW_NO_MIN_ERR         = "Quale \195\168 il livello minimo dei " ..
				"giocatori da invitare?";
		PW_NO_MAX_ERR         = "Quale \195\168 il livello massimo dei " ..
				"giocatori da invitare?";
		PW_NO_RESP_ERR        = "Il server non ha risposto alla nostra " ..
				"richiesta /who.";
		PW_REASK              = "Chiedi-ancora";
		PW_ASK                = "Chiedi";
		PW_CHAT               = "Chat";
		PW_NO_USER_ADD_ERR    = "Chi dovremo aggiungere alla lista NON INVITARE?";
		PW_USER_ON_LIST_ERR   = "Quel giocatore \195\168 gi\195\160 nella lista.";
		PW_NO_USER_DEL_ERR    = "Chi dovremo cancellare dalla lista NON INVITARE?";
		PW_USER_NOT_ON_ERR    = "Quel giocatore non \195\168 nella lista.";
		PW_INCOME_WHISPER     = "[%s] whispers: %s";
		PW_OUTGOING_WHISPER   = "To [%s]: %s";
		PW_DUNGEON            = "Dungeon";
		PW_AFK                = "AFK";
		PW_DELETED            = "Cancellato";
		PW_PENDING            = "Attesa";
		PW_DECLINE            = "Rifiutato";
		PW_NOTES              = "Note";
		PW_IGNORE_GROUP_WARN1 = "Attenzione! Hai appena gruppato con %s, che " ..
				"\195\168 nella lista NON INVITARE. Sei sicuro di volerlo fare?"
		PW_IGNORE_GROUP_WARN2 = "Attenzione! Hai appena gruppato con %s, che " ..
				"\195\168 nella lista NON INVITARE. Ti eri scritto la seguente " ..
				"nota: %s"
		PW_OTHER_LABEL        = "Altro...";
		PW_SLOT_LABEL         = "Lo slot \195\168 occupato";
		PW_PARTY_LABEL        = "Il party \195\168 completo";
		PW_PARTY              = "Party";
		PW_PARTY1             = "Questa \195\168 una funzione sperimentale " ..
				"per tenere traccia  delle persone con cui";
		PW_PARTY2             = "hai gruppato. E' una funzione legata solo a " ..
				"Polite Whisper. Dovrebbe essere";
		PW_PARTY3             = "facile ricordarsi le caratteristiche di un " ..
				"giocatore con cui fai gruppo tutti i";
		PW_PARTY4             = "giorni; ma per utenti con cui fai gruppo " ..
				"raramente, pu\195\178 essere d'aiuto tenere";
		PW_PARTY5             = "qualche nota. Spero che troverai questo " ..
				"pannello pi\195\185 conveniente che";
		PW_PARTY6             = "prendere note su un pezzo di carta.";
		PW_PARTY7             = " ";
		PW_REMEMBER_QUEST     = "Ricordati questa domanda";
		PW_NO_QUEST           = "Inserisci una domanda da ricordare e quindi " ..
				"seleziona questa opzione.";
		PW_NOTES              = "Note";
		PW_CUSTOMWHISPERS     = "Custom Whispers";
		PW_TEST               = "Test";
		PW_RESET              = "Reset";
end
function PoliteWhisper_ItalianWhispers()
		PW_INVITATION_WHISPER = "Scusa se disturbo; ti interessa unirti a noi " ..
				"per fare $D?";
		PW_SPECIAL_INVITE     = "Scusa se disturbo; Il nostro gruppo cerca $R. " ..
				"Ti interessa unirti a noi per fare $D?";
		PW_APOLOGY            = "No problem. Scusa se ti ho disturbato.";
		PW_INVITE_REQUEST     = "Hey, Ho trovato un livello $L $C che vorrebbe " ..
				"unirsi a noi come $R. Potresti invitare $P? Grazie!";
		PW_PARTY_MAKEUP1      = "Finora, abbiamo $G.";
		PW_PARTY_MAKEUP2      = "un %s (%d)";
		PW_PARTY_MAKEUP3      = ", un %s (%d)";
		PW_INVITE_WARNING     = "Ora whispo $B per invitarti subito.";
		PW_SLOT_FULL          = "Mi spiace, ma abbiamo appena riempito lo " ..
				"slot. Magari grupperemo la prossima volta.";
		PW_PARTY_FULL         = "Mi spiace, ma il gruppo \195\168 appena stato " ..
				"riempito. Magari grupperemo la prossima volta.";

		-- Specializations
		PW_SPECIALIZE = {};
		PW_SPECIALIZE[PW_DRUID] = {{"Druid", "un druido"},
				{"Healer", "un healer"}, {"Tank", "un tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_HUNTER] = {{"Hunter", "un hunter"},
				{"Off-Tank", "un off-tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_PALADIN] = {{"Paladin", "un paladino"},
				{"Healer", "un healer"}, {"Tank", "un tank"}};
		PW_SPECIALIZE[PW_PRIEST] = {{"Priest", "un prete"},
				{"Healer", "un healer"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_SHAMAN] = {{"Shaman", "uno shamano"},
				{"Healer", "un healer"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_WARRIOR] = {{"Warrior", "un warrior"},
				{"Tank", "un tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE_OTHER_PREPEND = "un ";
		PW_SPECIALIZE_OTHER_APPEND = "";

		-- Dungeons
		PW_DUNGEONS =
		{
				{"Auchindoun - Auchenai Crypts",        65, 67},
				{"Auchindoun - Mana Tombs",             64, 66},
				{"Auchindoun - Sethekk Halls",          67, 69},
				{"Auchindoun - Shadow Labyrinth",       70, 70},
				{"Blackfathom Depths",                  22, 28},
				{"Blackrock Depths",                    52, 60},
				{"Blade's Edge Mountains",              65, 68},
				{"Coilfang Reservoir - Slave Pens",     62, 64},
				{"Coilfang Reservoir - The Steamvault", 70, 70},
				{"Coilfang Reservoir - The Underbog",   63, 65},
				{"Dire Maul - East",                    58, 62},
				{"Dire Maul - North",                   60, 63},
				{"Dire Maul - West",                    60, 63},
				{"Gnomeregan",                          30, 35},
				{"Hellfire Citadel - Blood Furnace",    60, 62},
				{"Hellfire Citadel - Ramparts",         60, 62},
				{"Hellfire Peninsula",                  58, 63},
				{"Live Stratholme",                     58, 62},
				{"Lower Blackrock Spire",               57, 61},
				{"Maraudon",                            45, 51},
				{"Nagrand",                             64, 67},
				{"Netherstorm",                         67, 70},
				{"Old Hillsbrad Foothills",             66, 68},
				{"Ragefire Chasm",                      13, 18},
				{"Razorfen Downs",                      38, 42},
				{"Razorfen Kraul",                      29, 34},
				{"Scarlet Monestary",                   38, 42},
				{"Scholomance",                         60, 63},
				{"Shadowfang Keep",                     20, 26},
				{"Shadowmoon Valley",                   67, 70},
				{"Sunken Temple",                       50, 55},
				{"Tempest Keep - The Arcatraz",         70, 70},
				{"Tempest Keep - The Botanica",         70, 70},
				{"Tempest Keep - The Mechanar",         70, 70},
				{"Terokkar Forest",                     62, 65},
				{"The Black Morass",                    68, 70},
				{"The Deadmines",                       15, 22},
				{"The Shattered Halls",                 70, 70},
				{"The Stockades",                       25, 29},
				{"Uldaman",                             36, 45},
				{"Undead Stratholme",                   58, 62},
				{"Upper Blackrock Spire",               60, 63},
				{"Wailing Caverns",                     17, 24},
				{"Zangarmarsh",                         60, 64},
				{"Zul'Farrak",                          40, 47}
		};
end

function PoliteWhisper_ChineseClasses()
		PW_D_DRUID              = "德鲁伊";
		PW_D_HUNTER             = "猎人";
		PW_D_MAGE               = "法师";
		PW_D_PALADIN            = "圣骑士";
		PW_D_PRIEST             = "牧师";
		PW_D_ROGUE              = "潜行者";
		PW_D_SHAMAN             = "萨满祭司";
		PW_D_WARLOCK            = "术士";
		PW_D_WARRIOR            = "战士";
end
function PoliteWhisper_ChineseUI()
		PW_TITLE              = "组队盒子 Ex汉化版";
		PW_INVITE_TO          = "选择副本:";
		PW_LEVEL_COLON        = "等级:";
		PW_HYPHEN             = "-";
		PW_SEARCH_CLASSES     = "搜索玩家职业:";
		PW_NAME               = "名字";
		PW_CLASS              = "职业";
		PW_LEVEL              = "等级";
		PW_ZONE               = "地区";
		PW_GUILD              = "公会";
		PW_SEARCH             = "搜索";
		PW_STOP_SEARCH        = "停止";
		PW_WHO_DO_WE_HAVE     = "我们有?";
		PW_INVITE             = "邀请";
		PW_USER_DECLINED      = "拒绝的人";
		PW_IGNORE_WARN1       = "添加玩家到这个列表," ..
				"插件将不会再搜索并询问他们.";
		PW_IGNORE_WARN2       = "如果你想日后提醒自己," ..
				"请输入一些方便你记忆这个人的备注";
		PW_IGNORE_WARN3       = "你确定以后不想和他们" ..
				"组队吗?";
		PW_ADD                = "添加";
		PW_DELETE             = "删除";
		PW_MINIMAP_BUTTON     = "小地图按钮:";
		PW_ENABLE             = "启用";
		PW_POSITION           = "位置";
		PW_DISTANCE           = "距离";
		PW_PARTY_FINDER       = "搜索队友";
		PW_DO_NOT_INVITE      = "不要邀请";
		PW_CONFIGURATION      = "设置";
		PW_SLASH_COMMAND      = "/pw";
		PW_STARTUP_TEXT       = "输入 \"/pw\" 打开 Polite Whisper Extended";
		PW_NO_DUNGEON_ERR     = "请选择要去的副本";
		PW_NO_MIN_ERR         = "请输入最小邀请等级";
		PW_NO_MAX_ERR         = "请输入最大邀请等级";
		PW_NO_RESP_ERR        = "服务器没有回应 /who 命令.";
		PW_REASK              = "再次询问";
		PW_ASK                = "询问";
		PW_CHAT               = "对话";
		PW_NO_USER_ADD_ERR    = "添加谁到[不要邀请]列表?";
		PW_USER_ON_LIST_ERR   = "这个玩家已经在列表了!";
		PW_NO_USER_DEL_ERR    = "从[不要邀请]列表中 " ..
				"删除谁?";
		PW_USER_NOT_ON_ERR    = "这个玩家不在列表中!";
		PW_INCOME_WHISPER     = "[%s] 密: %s";
		PW_OUTGOING_WHISPER   = "密 [%s]: %s";
		PW_DUNGEON            = "副本";
		PW_AFK                = "AFK";
		PW_DELETED            = "已删除";
		PW_PENDING            = "未决的";
		PW_DECLINE            = "拒绝的";
		PW_NOTES              = "备注";
		PW_IGNORE_GROUP_WARN1 = "注意! %s 在[不要邀请]列表中 " ..
				"你确定要和他组队吗?"
		PW_IGNORE_GROUP_WARN2 = "注意! %s 在[不要邀请]列表中 " ..
				"你对他的评论是: %s"
		PW_OTHER_LABEL        = "其他";
		PW_SLOT_LABEL         = "职业满";
		PW_PARTY_LABEL        = "队伍满";
		PW_PARTY              = "队友";
		PW_PARTY1             = "这是一个实验面板, 你可以记录与你组队的人的信息 " ..
        "你可以随便写些什么";
		PW_PARTY2             = "你写在这里的东西不会对插件有影响" ..
        "只是为了方便你记忆与你一起组过队的人";
		PW_PARTY3             = "so-n-so needs a back-up healer or shouldn't " ..
				"be allowed to pull if you were";
		PW_PARTY4             = "to group with them every day; but for those " ..
				"people you group with rarely,";
		PW_PARTY5             = "it is handy to keep some notes. Hopefully you " ..
				"will find this panel to be more";
		PW_PARTY6             = "convenient than taking notes on scrap paper.";
		PW_PARTY7             = " ";
		PW_REMEMBER_QUEST     = "记住这个问题";
		PW_NO_QUEST           = "Enter a question to remember and then select " ..
				"that option.";
		PW_NOTES              = "备注";
		PW_CUSTOMWHISPERS     = "自定义密语";
		PW_CUSTOM1            = "一般邀请密语";
		PW_CUSTOM2            = "特殊邀请密语 (搜索例如治疗这样确定的队友时)";
		PW_CUSTOM3            = "回复拒绝的玩家";
		PW_CUSTOM4            = "请求队长邀请玩家";
		PW_CUSTOM5            = "队伍里玩家的职业等级";
		PW_CUSTOM6            = "通知请求队长邀请的玩家";
		PW_CUSTOM7            = "职业满了";
		PW_CUSTOM8            = "队伍满了";
		PW_TAG_P_DESC         = "|cFF80FF80$P|r = 被密的玩家名字";
		PW_TAG_L_DESC         = "|cFF80FF80$L|r = 被密的玩家等级";
		PW_TAG_C_DESC         = "|cFF80FF80$C|r = 被密的玩家职业";
		PW_TAG_D_DESC         = "|cFF80FF80$R|r = 被密玩家在队伍中的角色, 例如: 坦克, 治疗, dps, 副坦克 等等";
		PW_TAG_R_DESC         = "|cFF80FF80$D|r = 目标副本名字";
		PW_TAG_N_DESC         = "|cFF80FF80$N|r = 队伍里的玩家人数";
		PW_TAG_B_DESC         = "|cFF80FF80$B|r = 队长的名字";
		PW_TAG_G_DESC         = "|cFF80FF80$G|r = 队伍组成 (职业和等级)";
		PW_TEST               = "测试";
		PW_RESET              = "重置";
		PW_HEROIC_MODE        = "英雄模式";
end
function PoliteWhisper_ChineseWhispers()
		PW_INVITATION_WHISPER = "组队提示: " ..
				" $D? 来吗? 来请打1,不来请忽略这个信息,谢谢!";
		PW_SPECIAL_INVITE     = "组队提示: 我们的队伍需要 " ..
				"$R. 去 $D. 来吗? 来请打1,不来请忽略这个信息,谢谢!";
		PW_APOLOGY            = "组队提示: 没关系";
		PW_INVITE_REQUEST     = "组队提示: 有一个 $L级的$C想来" ..
				"做$R. 麻烦你加下 $P? 谢谢!";
		PW_PARTY_MAKEUP1      = "组队提示: 我们有$G.";
		PW_PARTY_MAKEUP2      = " %s (%d)";
		PW_PARTY_MAKEUP3      = ", %s (%d)";
		PW_INVITE_WARNING     = "组队提示: 我让 $B 加你.";
		PW_SLOT_FULL          = "组队提示: 这个职业满了" ..
				"不好意思.";
		PW_PARTY_FULL         = "组队提示: 队伍已经满了" ..
				"不好意思.";

		-- Specializations
		PW_SPECIALIZE = {};
		PW_SPECIALIZE[PW_DRUID]   = {{"德鲁伊", "德鲁伊"}, {"治疗", "治疗"},
				{"野D(做T)", "野D(做T)"}, {"野D(DPS)", "野D(DPS)"}};
		PW_SPECIALIZE[PW_HUNTER]  = {{"猎人", "猎人"},
				{"兽王猎人", "兽王猎人"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_PALADIN] = {{"圣骑士", "圣骑士"},
				{"治疗", "治疗"}, {"防骑", "防骑"}};
		PW_SPECIALIZE[PW_PRIEST]  = {{"牧师", "牧师"},
				{"治疗", "治疗"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_SHAMAN]  = {{"萨满祭司", "萨满祭司"},
				{"治疗", "治疗"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_WARRIOR] = {{"战士", "战士"}, {"防战", "防战"},
				{"DPS", "DPS"}};
		PW_SPECIALIZE_OTHER_PREPEND = "a ";
		PW_SPECIALIZE_OTHER_APPEND = "";

		-- Dungeons
		PW_DUNGEONS =
		{
				{"地狱火半岛 - 鲜血熔炉",                                     60, 62},
				{"地狱火半岛 - 地狱火城墙",                                   60, 62},
				{"地狱火半岛 - 破碎大厅",                                     69, 70},
				{"盘牙水库 - 奴隶围栏",                                       62, 64},
				{"盘牙水库 - 蒸汽地窖",                                       70, 70},
				{"盘牙水库 - 幽暗沼泽",                                       63, 65},
				{"奥金顿 - 奥金尼地穴",                                       65, 67},
				{"奥金顿 - 法力墓穴",                                         64, 66},
				{"奥金顿 - 塞泰克大厅",                                       67, 69},
				{"奥金顿 - 暗影迷宫",                                         70, 70},
				{"风暴要塞 - 禁魔监狱",                                       70, 70},
				{"风暴要塞 - 生态船",                                         70, 70},
				{"风暴要塞 - 能源舰",                                         70, 70},
				{"时光之穴 - 敦霍尔德",                                       66, 68},
				{"时光之穴 - 黑暗之门",                                       66, 70},
				{"怒焰裂谷",                                                  13, 18},
				{"死亡矿井",                                                  15, 22},
				{"哀嚎洞穴",                                                  17, 24},
				{"影牙城堡",                                                  20, 26},
				{"黑暗深渊",                                                  22, 28},
				{"暴风城 监狱",                                               25, 29},
				{"剃刀沼泽",                                                  29, 34},
				{"诺莫瑞根",                                                  30, 35},
				{"奥达曼",                                                    36, 45},
				{"剃刀高地",                                                  38, 42},
				{"血色修道院",                                                38, 42},
				{"祖尔法拉克",                                                40, 47},
                                {"沉没的神庙",                                                50, 55},
				{"玛拉顿",                                                    45, 51},
				{"通灵学院",                                                  60, 63},
				{"斯塔索姆",                                                  58, 62},
				{"黑石深渊",                                                  52, 60},
				{"厄运之槌 - 东",                                             58, 62},
				{"厄运之槌 - 北",                                             60, 63},
				{"厄运之槌 - 西",                                             60, 63},
				{"黑石塔 (下层)",                                             57, 61},
				{"黑石塔 (上层)",                                             60, 63}
				
		};
		PW_HEROIC_DUNGEONS =
		{
				{"地狱火半岛 - 鲜血熔炉",                       70, 70},
				{"地狱火半岛 - 地狱火城墙",                     70, 70},
				{"地狱火半岛 - 破碎大厅",                       70, 70},
				{"盘牙水库 - 奴隶围栏",                         70, 70},
				{"盘牙水库 - 蒸汽地窖",                         70, 70},
				{"盘牙水库 - 幽暗沼泽",                         70, 70},
				{"奥金顿 - 奥金尼地穴",                         70, 70},
				{"奥金顿 - 法力墓穴",                           70, 70},
				{"奥金顿 - 塞泰克大厅",                         70, 70},
				{"奥金顿 - 暗影迷宫",                           70, 70},
				{"时光之穴 - 敦霍尔德",                         70, 70},
				{"时光之穴 - 黑暗之门",                         70, 70},
				{"风暴要塞 - 禁魔监狱",                         70, 70},
				{"风暴要塞 - 生态船",                           70, 70},
				{"风暴要塞 - 能源舰",                           70, 70}
		};
end

function PoliteWhisper_EnglishClasses()
		PW_D_DRUID              = "Druid";
		PW_D_HUNTER             = "Hunter";
		PW_D_MAGE               = "Mage";
		PW_D_PALADIN            = "Paladin";
		PW_D_PRIEST             = "Priest";
		PW_D_ROGUE              = "Rogue";
		PW_D_SHAMAN             = "Shaman";
		PW_D_WARLOCK            = "Warlock";
		PW_D_WARRIOR            = "Warrior";
end
function PoliteWhisper_EnglishUI()
		PW_TITLE              = "Polite Whisper Extended";
		PW_INVITE_TO          = "Invite users to:";
		PW_LEVEL_COLON        = "Level:";
		PW_HYPHEN             = "-";
		PW_SEARCH_CLASSES     = "Search player classes:";
		PW_NAME               = "Name";
		PW_CLASS              = "Class";
		PW_LEVEL              = "Level";
		PW_ZONE               = "Zone";
		PW_GUILD              = "Guild";
		PW_SEARCH             = "Search";
		PW_STOP_SEARCH        = "Stop Search";
		PW_WHO_DO_WE_HAVE     = "Who Do We Have?";
		PW_INVITE             = "Invite";
		PW_USER_DECLINED      = "User Declined Us";
		PW_IGNORE_WARN1       = "Adding players to this list will keep them " ..
				"from appearing in the party finder.";
		PW_IGNORE_WARN2       = "This is not quite as harsh as putting them on " ..
				"your ignore list. Entering a comment";
		PW_IGNORE_WARN3       = "will help you remember why you didn't want to " ..
				"group with them.";
		PW_ADD                = "Add";
		PW_DELETE             = "Delete";
		PW_MINIMAP_BUTTON     = "Minimap button:";
		PW_ENABLE             = "Enable";
		PW_POSITION           = "Position";
		PW_DISTANCE           = "Distance";
		PW_PARTY_FINDER       = "Party Finder";
		PW_DO_NOT_INVITE      = "Do NOT Invite";
		PW_CONFIGURATION      = "Configuration";
		PW_SLASH_COMMAND      = "/pw";
		PW_STARTUP_TEXT       = "Type \"/pw\" to open Polite Whisper Extended";
		PW_NO_DUNGEON_ERR     = "Invite people to join you doing what?";
		PW_NO_MIN_ERR         = "What's the minimum level character to invite?";
		PW_NO_MAX_ERR         = "What's the maximum level character to invite?";
		PW_NO_RESP_ERR        = "The server did not respond to our /who query.";
		PW_REASK              = "Re-Ask";
		PW_ASK                = "Ask";
		PW_CHAT               = "Chat";
		PW_NO_USER_ADD_ERR    = "Who should we add to the do not invite list?";
		PW_USER_ON_LIST_ERR   = "That player is already on the list.";
		PW_NO_USER_DEL_ERR    = "Who should we delete from the do not invite " ..
				"list?";
		PW_USER_NOT_ON_ERR    = "That player is not on the list.";
		PW_INCOME_WHISPER     = "[%s] whispers: %s";
		PW_OUTGOING_WHISPER   = "To [%s]: %s";
		PW_DUNGEON            = "Dungeon";
		PW_AFK                = "AFK";
		PW_DELETED            = "Deleted";
		PW_PENDING            = "Pending";
		PW_DECLINE            = "Decline";
		PW_NOTES              = "Notes";
		PW_IGNORE_GROUP_WARN1 = "Warning!  You just grouped with %s, who is on " ..
				"your do not invite list.  Are you sure you want to do this?"
		PW_IGNORE_GROUP_WARN2 = "Warning!  You just grouped with %s, who is on " ..
				"your do not invite list.  You left yourself the following note: %s"
		PW_OTHER_LABEL        = "Other...";
		PW_SLOT_LABEL         = "Slot Is Full";
		PW_PARTY_LABEL        = "Party Is Full";
		PW_PARTY              = "Party";
		PW_PARTY1             = "This is an experimental panel for keeping " ..
				"track of the people you group with.";
		PW_PARTY2             = "It is only loosely tied to Polite Whisper.  " ..
				"It may be easy to remember if";
		PW_PARTY3             = "so-n-so needs a back-up healer or shouldn't " ..
				"be allowed to pull if you were";
		PW_PARTY4             = "to group with them every day; but for those " ..
				"people you group with rarely,";
		PW_PARTY5             = "it is handy to keep some notes. Hopefully you " ..
				"will find this panel to be more";
		PW_PARTY6             = "convenient than taking notes on scrap paper.";
		PW_PARTY7             = " ";
		PW_REMEMBER_QUEST     = "Remember This Question";
		PW_NO_QUEST           = "Enter a question to remember and then select " ..
				"that option.";
		PW_NOTES              = "Notes";
		PW_CUSTOMWHISPERS     = "Custom Whispers";
		PW_CUSTOM1            = "Normal invite whisper";
		PW_CUSTOM2            = "Special invite whisper (when looking for a certain build)";
		PW_CUSTOM3            = "Response when player declines";
		PW_CUSTOM4            = "Request to group leader to invite the player";
		PW_CUSTOM5            = "What classes and levels in group";
		PW_CUSTOM6            = "Notification to player that group leader has been asked";
		PW_CUSTOM7            = "Slot full";
		PW_CUSTOM8            = "Group full";
		PW_TAG_P_DESC         = "|cFF80FF80$P|r = name of target player being whispered";
		PW_TAG_L_DESC         = "|cFF80FF80$L|r = level of target player being whispered";
		PW_TAG_C_DESC         = "|cFF80FF80$C|r = class of target player being whispered";
		PW_TAG_D_DESC         = "|cFF80FF80$R|r = desired role of whispered player in group, eg. tank, healer, dps, offtank etc";
		PW_TAG_R_DESC         = "|cFF80FF80$D|r = name of destination zone/instance";
		PW_TAG_N_DESC         = "|cFF80FF80$N|r = number of players in group";
		PW_TAG_B_DESC         = "|cFF80FF80$B|r = name of group leader";
		PW_TAG_G_DESC         = "|cFF80FF80$G|r = group makeup (classes and levels)";
		PW_TEST               = "Test";
		PW_RESET              = "Reset";
		PW_HEROIC_MODE        = "Heroic mode";
end
function PoliteWhisper_EnglishWhispers()
		PW_INVITATION_WHISPER = "Hi, wanna come to " ..
				" $D?";
		PW_SPECIAL_INVITE     = "Hey, we need a " ..
				"$R. Wanna come to $D?";
		PW_APOLOGY            = "Alright, thanks.";
		PW_INVITE_REQUEST     = "Hey, I found a level $L $C who's willing to " ..
				"join us as $R. Could you please invite $P? Thanks!";
		PW_PARTY_MAKEUP1      = "So far, we have $G.";
		PW_PARTY_MAKEUP2      = "a %s (%d)";
		PW_PARTY_MAKEUP3      = ", a %s (%d)";
		PW_INVITE_WARNING     = "I'll go whisper $B to invite you now.";
		PW_SLOT_FULL          = "I'm sorry, but we just filled that slot. " ..
				"Perhaps you can join us next time.";
		PW_PARTY_FULL         = "Sorry, group just filled up" ..
				"Maybe next time.";

		-- Specializations
		PW_SPECIALIZE = {};
		PW_SPECIALIZE[PW_DRUID]   = {{"Druid", "a druid"}, {"Healer", "a healer"},
				{"Tank", "a tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_HUNTER]  = {{"Hunter", "a hunter"},
				{"Off-Tank", "an off-tank"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_PALADIN] = {{"Paladin", "a paladin"},
				{"Healer", "a healer"}, {"Tank", "a tank"}};
		PW_SPECIALIZE[PW_PRIEST]  = {{"Priest", "a priest"},
				{"Healer", "a healer"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_SHAMAN]  = {{"Shaman", "a shaman"},
				{"Healer", "a healer"}, {"DPS", "DPS"}};
		PW_SPECIALIZE[PW_WARRIOR] = {{"Warrior", "a warrior"}, {"Tank", "a tank"},
				{"DPS", "DPS"}};
		PW_SPECIALIZE_OTHER_PREPEND = "a ";
		PW_SPECIALIZE_OTHER_APPEND = "";

		-- Dungeons
		PW_DUNGEONS =
		{
				{"Auchindoun - Auchenai Crypts",                              65, 67},
				{"Auchindoun - Mana Tombs",                                   64, 66},
				{"Auchindoun - Sethekk Halls",                                67, 69},
				{"Auchindoun - Shadow Labyrinth",                             70, 70},
				{"Blackfathom Depths",                                        22, 28},
				{"Blackrock Depths",                                          52, 60},
				{"Blade's Edge Mountains",                                    65, 68},
				{"Caverns of Time - Escape from Durnholde Keep",              66, 68},
				{"Caverns of Time - Old Hillsbrad Foothills",                 66, 68},
				{"Caverns of Time - The Dark Portal",                         66, 70},
				{"Coilfang Reservoir - Slave Pens",                           62, 64},
				{"Coilfang Reservoir - The Steamvault",                       70, 70},
				{"Coilfang Reservoir - The Underbog",                         63, 65},
				{"Dire Maul - East",                                          58, 62},
				{"Dire Maul - North",                                         60, 63},
				{"Dire Maul - West",                                          60, 63},
				{"Gnomeregan",                                                30, 35},
				{"Hellfire Citadel - Blood Furnace",                          60, 62},
				{"Hellfire Citadel - Ramparts",                               60, 62},
				{"Hellfire Citadel - Shattered Halls",                        69, 70},
				{"Hellfire Peninsula",                                        58, 63},
				{"Lower Blackrock Spire",                                     57, 61},
				{"Maraudon",                                                  45, 51},
				{"Nagrand",                                                   64, 67},
				{"Netherstorm",                                               67, 70},
				{"Ragefire Chasm",                                            13, 18},
				{"Razorfen Downs",                                            38, 42},
				{"Razorfen Kraul",                                            29, 34},
				{"Scarlet Monestary",                                         38, 42},
				{"Scholomance",                                               60, 63},
				{"Shadowfang Keep",                                           20, 26},
				{"Shadowmoon Valley",                                         67, 70},
				{"Live Stratholme",                                           58, 62},
				{"Undead Stratholme",                                         58, 62},
				{"Sunken Temple",                                             50, 55},
				{"Tempest Keep - The Arcatraz",                               70, 70},
				{"Tempest Keep - The Botanica",                               70, 70},
				{"Tempest Keep - The Mechanar",                               70, 70},
				{"Terokkar Forest",                                           62, 65},
				{"The Black Morass",                                          68, 70},
				{"The Deadmines",                                             15, 22},
				{"The Stockades",                                             25, 29},
				{"Uldaman",                                                   36, 45},
				{"Upper Blackrock Spire",                                     60, 63},
				{"Wailing Caverns",                                           17, 24},
				{"Zangarmarsh",                                               60, 64},
				{"Zul'Farrak",                                                40, 47}
		};
		PW_HEROIC_DUNGEONS =
		{
				{"Auchindoun - Auchenai Crypts",                70, 70},
				{"Auchindoun - Mana Tombs",                     70, 70},
				{"Auchindoun - Sethekk Halls",                  70, 70},
				{"Auchindoun - Shadow Labyrinth",               70, 70},
				{"Caverns of Time - Escape from Durnholde Keep",70, 70},
				{"Caverns of Time - Opening the Dark Portal",   70, 70},
				{"Coilfang Reservoir - Slave Pens",             70, 70},
				{"Coilfang Reservoir - The Steamvault",         70, 70},
				{"Coilfang Reservoir - The Underbog",           70, 70},
				{"Hellfire Citadel - Blood Furnace",            70, 70},
				{"Hellfire Citadel - Ramparts",                 70, 70},
				{"Hellfire Citadel - Shattered Halls",          70, 70},
				{"Tempest Keep - The Arcatraz",                 70, 70},
				{"Tempest Keep - The Botanica",                 70, 70},
				{"Tempest Keep - The Mechanar",                 70, 70}
		};
end

function PoliteWhisper_CopyClasses()
		PW_DRUID              = PW_D_DRUID;
		PW_HUNTER             = PW_D_HUNTER;
		PW_MAGE               = PW_D_MAGE;
		PW_PALADIN            = PW_D_PALADIN;
		PW_PRIEST             = PW_D_PRIEST;
		PW_ROGUE              = PW_D_ROGUE;
		PW_SHAMAN             = PW_D_SHAMAN;
		PW_WARLOCK            = PW_D_WARLOCK;
		PW_WARRIOR            = PW_D_WARRIOR;
end

if (GetLocale() == "deDE")
then
		PoliteWhisper_GermanClasses();
		PoliteWhisper_CopyClasses();
		PoliteWhisper_GermanUI();
		PoliteWhisper_GermanWhispers();
elseif (GetLocale() == "frFR")
then
		PoliteWhisper_FrenchClasses();
		PoliteWhisper_CopyClasses();
		PoliteWhisper_FrenchUI();
		PoliteWhisper_FrenchWhispers();
elseif (GetLocale() == "itIT")
then
		PoliteWhisper_ItalianClasses();
		PoliteWhisper_CopyClasses();
		PoliteWhisper_ItalianUI();
		PoliteWhisper_ItalianWhispers();
elseif (GetLocale() == "zhCN")
then
		PoliteWhisper_ChineseClasses();
		PoliteWhisper_CopyClasses();
		PoliteWhisper_ChineseUI();
		PoliteWhisper_ChineseWhispers();

else
		PoliteWhisper_EnglishClasses();
		PoliteWhisper_CopyClasses();
		PoliteWhisper_EnglishUI();
		PoliteWhisper_EnglishWhispers();
end

-- Do you use one client but speak another language?  If so, uncomment the
-- appropriate lines below by removing the "--" before it.
--PoliteWhisper_GermanClasses();
--PoliteWhisper_GermanUI();
--PoliteWhisper_GermanWhispers();
--PoliteWhisper_FrenchClasses();
--PoliteWhisper_FrenchUI();
--PoliteWhisper_FrenchWhispers();
--PoliteWhisper_ItalianClasses();
--PoliteWhisper_ItalianUI();
--PoliteWhisper_ItalianWhispers();
PoliteWhisper_ChineseClasses();
PoliteWhisper_ChineseUI();
PoliteWhisper_ChineseWhispers();
--PoliteWhisper_EnglishClasses();
--PoliteWhisper_EnglishUI();
--PoliteWhisper_EnglishWhispers();
