local L = AceLibrary("AceLocale-2.2"):new("Omen")

L:RegisterTranslations("frFR", function() return {
	["Active With Pet"] = "Activer avec familier",
	["Activate Omen when you have a pet"] = "Active Omen quand vous avez un familier.",
	["Active When Solo"] = "Activer en solo",
	["Activate Omen when solo or in a battlegroups (testing purposes only)"] = "Active Omen en solo ou dans les champs de bataille (à des fins de test uniquement).",
	["Aggro Gain"] = "Prise d'aggro",
	["Alpha"] = "Transparence",
	["Allow Omen to send threat data to people using KLH Threat Meter."] = "Autorise Omen à envoyer vos données aux joueurs utilisant KLH Threat Meter.",
	["Always show Omen"] = "Toujours afficher Omen",
	["Prevents Omen from hiding itself when ThreatLib is disabled"] = "Empêche Omen de se cacher de lui-même quand ThreatLib est désactivé.",
	["Always show self"] = "Toujours afficher soi-même",
	["Always show your position on the meter, even if you aren't in the top X slots."] = "Affiche en permanence votre position, même si vous n'êtes pas dans les X premiers.",
	["Animate Bars"] = "Barres animées",
	["Arrows"] = "Flèches",
	["Bars"] = "Barres",
	["Background Color"] = "Couleur de l'arrière-plan",
	["Bar Height"] = "Hauteur de(s) barre(s)",
	["Bar Texture"] = "Texture de(s) barre(s)",
	["Bar Color"] = "Couleur de(s) barre(s)",
	["Border Color"] = "Couleur de la bordure",
	["Classes"] = "Classes",
	["Clear Threat"] = "Effacer la menace",
	["Clears the raid's threat lists. May only be used if you are a raid leader or assistant."] = "Efface la liste des menaces du raid. Seuls le chef du raid et ses assistants peuvent utiliser cette commande.",
	["Columns"] = "Colonnes",
	["Color"] = "Couleur",
	["Compare Threat Velocity"] = "Comparer la vélocité de la menace",
	["Custom Color"] = "Couleur perso",
	["Display"] = "Affichage",
	["Display options"] = "Options concernant l'affichage.",
	["Disables warnings while you are in Defensive Stance, Bear Form, or have Righteous Fury"] = "Désactive les avertissements quand vous êtes en posture défensive, en forme d'ours, ou quand vous avez la Fureur vertueuse.", 
	["Disable While Tanking"] = "Désactiver (Tank)",
	["E-TPS"] = "R-MPS",
	["Fade out"] = "Fondu",
	["Font"] = "Police d'écriture",
	["Grow Upwards"] = "Ajouter vers le haut",
	["Left-click and drag to create a pullout bar\ncomparing your threat to "] = "Clic gauche et saisir pour extraire une barre\ncomparant votre menace avec celle de ",
	["Lock"] = "Verrouiller",
	["Lock the Omen window so that it may not be moved"] = "Verrouille la fenêtre de Omen afin qu'elle ne puisse pas être déplacée.",
	["Make numbers greater than 1,000 shorter; i.e., show 4,302 as '4.3k'"] = "Affiche d'une façon plus courte les nombres supérieurs à 1000 ; par ex., affiche 4302 comme ceci : '4.3k'.",
	["Name"] = "Nom",
	["None"] = "Aucun",
	["No target"] = "Pas de cible",
	["No tank"] = "Pas de tank",
	["Number of bars"] = "Nombre de barres",
	["Offset"] = "Décalage",
	["Outlining"] = "Type de contour",
	["Outline"] = "Contour simple",
	["p1"] = "p1",
	["p1 speed description"] = "Modifie la fluidité des données MPS. Une valeur basse engendre des données plus souvent mises à jour.",
	["Player's Bar Color"] = "Couleur de la barre du joueur",
	["Pin/Unpin the Omen window"] = "Epingler/Libérer la fenêtre de Omen",
	["Precision"] = "Précision",
	["Publish to KTM"] = "Envoyer à KTM",
	["Pullout Threat Bar"] = "Extraire la barre de menace",
	["Remove"] = "Enlever",
	["Reset Position"] = "Réinitialiser la position",
	["Resets Omen to the center of the screen"] = "Replace Omen au centre de l'écran.",
	["Right-click to set properties for"] = "Clic droit pour définir les propriétés de",
	["Save current skin as..."] = "Enregistrer le skin actuel sous...",
	["Scale"] = "Echelle",
	["Select the skin to use"] = "Choississez le skin à utiliser.",
	["Select which classes to show on the threat meter"] = "Choississez les classes à afficher.",
	["Shorten Numbers"] = "Nombres courts",
	["Shift-right-click to open the Omen menu"] = "Shift+clic-droit pour ouvrir le menu de Omen.",
	["Show"] = "Afficher",
	["Show Self"] = "Afficher votre flèche",
	["Self Color"] = "Couleur de votre flèche",
	["Show Aggro"] = "Afficher la flèche d'aggro",
	["Aggro Color"] = "Couleur de la flèche d'aggro",
	["Show Aggro Gain"] = "Afficher la prise d'aggro",
	["Show Column Headings"] = "Afficher les en-têtes des colonnes",
	["Show KTM Data"] = "Afficher les données de KTM",
	["Show party revisions"] = "Afficher les versions du groupe",
	["Show data coming from people using KLHThreatMeter rather than ThreatLib. People using KTM will be denoted with a *"] = "Affiche les données provenant des joueurs utilisant KLHThreatMeter au lieu de ThreatLib. Les gens utilisant KTM seront marqués d'un astérisque (*).",
	["Show Version Number"] = "Afficher votre version",
	["Show Warnings"] = "Afficher les avertissements",
	["Show Warning Message"] = "Afficher les messages d'avertissements",
	["Flash Screen"] = "Faire flasher l'écran",
	["Show Test Bars"] = "Afficher les barres de test",
	["Show Title"] = "Afficher le titre",
	["Show TPS"] = "Afficher la MPS",
	["Size"] = "Taille",
	["Skins"] = "Skins",
	["Skin Settings"] = "Paramètres du skin",
	["Sound to play on threat warning. Hold CTRL when selecting to hear the sound played."] = "Détermine le son à jouer lors des avertissements sur la menace. Maintenez la touche CTRL enfoncée pour entendre le son sélectionné.",
	["Stretch Bar Textures"] = "Etirer la texture des barres",
	["Threat"] = "Menace",
	["Thick Outline"] = "Contour épais",
	["Toggle Omen"] = "Afficher/Masquer Omen",
	["TPS"] = "MPS",
	["TPS Update Frequency"] = "Fréquence des MÀJ de la MPS",
	["Threat Per Second"] = "Menace par seconde",
	["Update Frequency"] = "Fréquence des MÀJ",
	["Use Custom Bar Color"] = "Utiliser la couleur perso des barres",
	["Use Default Color"] = "Utiliser la couleur par défaut",
	["Use Default Texture"] = "Utiliser la texture par défaut",
	["Use Default Bar Height"] = "Utiliser la hauteur par défaut",
	["Use skin..."] = "Utiliser le skin...",
	["Warnings"] = "Avertissements",
	["Warning: Passed %2.0f%% of %s's threat!"] = "Attention : dépassement des %2.0f%% de la menace |2 %s !",
	["Warning Threshold"] = "Seuil d'avertissement",
	["Sets the the threshold at which you will be warned of your threat level. When your threat is greater than this percentage of the aggro holder's threat, you will be warned."] = "Détermine le seuil à partir duquel vous serez averti de votre niveau de menace. Quand votre menace est supérieure à ce pourcentage de la menace du tank actuel, vous serez averti.",
	["Warning Sound"] = "Son d'avertissement",
	["Width"] = "Longueur",

	["Click|r to toggle the Omen window"] = "Clic|r pour afficher/masquer la fenêtre de Omen.",
	["Ctrl-Click|r to open the options menu"] = "Ctrl-Clic|r pour ouvrir le menu des options.",
	["Shift-Click|r to issue a threat clear request"] = "Shift-Clic|r pour demander une réinitialisation des menaces.",
} end)