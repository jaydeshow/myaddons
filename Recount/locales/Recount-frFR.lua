local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Recount", "frFR", true)
if not L then return end

	L["Sync"] = "Sync"
	L["sync"] = "sync"
	L["Toggles sending synchronization messages"] = "Activer/Désactiver l'envoi de messages de synchronisation"
	L["Reset"] = "Réinitialiser"
	L["reset"] = "reinitialiser"
	L["Resets the data"] = "Réinitialiser les données"
	L["VerChk"] = "Vérification de la version"
	L["verChk"] = "verVrf"
	L["Displays the versions of players in the raid"] = "Afficher les versions des joueurs dans le raid"
	L["Displaying Versions"] = "Affichage des versions"
	L["Show"] = "Afficher"
	L["show"] = "afficher"
	L["Shows the main window"] = "Afficher la fenêtre principale"
	L["Hide"] = "Cacher"
	L["Hides the main window"] = "Cacher la fenêtre principale"
	L["Toggle"] = "Basculer"
	L["Toggles the main window"] = "Basculer la fenêtre principale"
	L["Report"] = "Rapport"
	L["Allows the data of a window to be reported"] = "Autoriser les données d'une fenêtre à être rapportées"
	L["Detail"] = "Detail"
	L["Report the Detail Window Data"] = "Afficher le rapport de la fenêtre détaillée des données"
	L["Main"] = "Principal"
	L["Report the Main Window Data"] = "Afficher le rapport de la fenêtre principale des données"
	L["Config"] = "Configuration"
	L["Shows the config window"] = "Afficher la fenêtre de configuration"
	L["ResetPos"] = "ReinitPos"
	L["Resets the positions of the detail, graph, and main windows"] = "Réinitialiser la position des fenêtres principales, des détails et des graphiques"
	L["Lock"] = "Bloquer"
	L["Toggles windows being locked"] = "Basculer le bloquage des fenêtres"
	L["|cffff4040Disabled|r"] = "|cffff4040Désactivé|r"
	L["|cff40ff40Enabled|r"] = "|cff40ff40Activé|r"
	L["Unknown Spells"] = "Sorts inconnus"
	L["Shows found unknown spells in BabbleSpell"] = "Afficher les sorts inconnus de BabbleSpell trouvés"
	L["Unknown Spells:"] = "Sorts inconnus:"
	L["Realtime"] = "Temps réel"
	L["Specialized Realtime Graphs"] = "Graphiques spécialisés dans le temps réel"
	L["FPS"] = "IPS"
	L["Starts a realtime window tracking your FPS"] = "Démarrer une fenêtre temps réel affichant votre IPS"
	L["Lag"] = "Latence"
	L["Starts a realtime window tracking your latency"] = "Démarrer une fenêtre temps réel affichant votre latence"
	L["Upstream Traffic"] = "Traffic à l'envoi"
	L["Starts a realtime window tracking your upstream traffic"] = "Démarrer une fenêtre temps réel affichant votre traffic à l'envoi"
	L["Downstream Traffic"] = "Traffic à la réception"
	L["Starts a realtime window tracking your downstream traffic"] = "Démarrer une fenêtre temps réel affichant votre traffic à la réception"
	L["Available Bandwidth"] = "Bande passante disponible"
	L["Starts a realtime window tracking amount of available AceComm bandwidth left"] = "Démarrer une fenêtre temps réel affichant votre bande passante AceComm encore disponible"
	L["Raid"] = "Raid"
	L["Tracks your entire raid"] = "Analyser le raid entier"
	L["DPS"] = "DPS"
	L["Tracks Raid Damage Per Second"] = "Enregistrer les dégâts par seconde du raid"
	L["DTPS"] = "DRPS"
	L["Tracks Raid Damage Taken Per Second"] = "Enregistrer les dégâts reçus par le raid par seconde"
	L["HPS"] = "SPS"
	L["Tracks Raid Healing Per Second"] = "Enregistrer les soins pas seconde du raid"
	L["HTPS"] = "SRPS"
	L["Tracks Raid Healing Taken Per Second"] = "Enregistrer les soins reçus par seconde du raid"
	L["Pet"] = "Familier"
	L["Mob"] = "Monstre"
	L["Title"] = "Titre"
	L["Background"] = "Arrière-plan"
	L["Show previous main page"] = "Afficher la fenêtre principale précédente" -- Elsia: And even more stuff not yet fully localized.
	L["Show next main page"] = "Afficher la fenêtre principale suivante"
	L["Display"] = "Affichage"
	L["Damage Done"] = "Dégâts faits"
	L["Friendly Fire"] = "Dégâts aux alliés"
	L["Damage Taken"] = "Dégâts reçus"
	L["Healing Done"] = "Soins faits"
	L["Healing Taken"] = "Soins reçus"
	L["Overhealing Done"] = "Soins en trop"
	L["Deaths"] = "Morts"
	L["DOT Uptime"] = "Temps d'activité des dégâts indirects"
	L["HOT Uptime"] = "Temps d'activité des soins indirects"
	L["Dispels"] = "Dissipations faites"
	L["Dispelled"] = "Dissipations reçues"
	L["Interrupts"] = "Interruptions"
	L["Ressers"] = "Résurrecteurs"
	L["CC Breakers"] = "Sorts cassés"
	L["Activity"] = "Activité"
	L["Threat"] = "Menace"
	L["Mana Gained"] = "Mana récupéré"
	L["Energy Gained"] = "Energie récupérée"
	L["Rage Gained"] = "Rage récupérée"
	L["Network Traffic(by Player)"]="Trafic réseau (par Joueur)"
	L["Network Traffic(by Prefix)"]="Trafic réseau (par Préfixe)"