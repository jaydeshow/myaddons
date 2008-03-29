if GetLocale() ~= "frFR" then return end

-- fr translations provided by pingouin47
-- Updated by Pettigrow
CappingLocale:CreateLocaleTable({
	-- battlegrounds
	["Alterac Valley"] = "Vallée d'Alterac", 
	["Arathi Basin"] = "Bassin d'Arathi", 
	["Warsong Gulch"] = "Goulet des Chanteguerres",
	["Arena"] = "Arène",
	["Eye of the Storm"] = "L'Œil du cyclone",

	-- factions
	["Alliance"] = "Alliance",
	["Horde"] = "Horde",

	-- options menu
	["Enable"] = "Activer",
	["Auto quest turnins"] = "Rendre auto. les quêtes",
	["Enable Alterac Valley automatic quest turnins"] = "Rend automatiquement les objets de quêtes à la Vallée d'Alterac.",
	["Bar"] = "Barre",
	["Statusbar options"] = "Option concernant les barres de statut.",
	["Font size"] = "Taille de la police",
	["Change statusbar font size"] = "Change la taille de la police des barres de statut.",
	["Width"] = "Longueur",
	["Change statusbar width"] = "Change la longueur des barres de statut.",
	["Height"] = "Hauteur",
	["Change statusbar thickness"] = "Change la hauteur des barres de statut.",
	["Scale"] = "Échelle",
	["Change statusbar scale"] = "Change l'échelle des barres de statut.",
	["Texture"] = "Texture",
	["Statusbar textures"] = "Textures des barre de statut",
	["Other"] = "Autre",
	["Other options"] = "Options diverses.",
	["Auto show map"] = "Afficher auto. la carte",
	["Auto show the battlefield minimap on entry"] = "Affiche automatiquement la carte tactique à l'entrée des champs de bataille.",
	["Map scale"] = "Echelle de la carte",
	["Hide border"] = "Masquer la bordure",
	["Change the default scale of the battlefield minimap"] = "Change l'échelle par défaut de la carte tactique.",
	["Port Timer"] = "Délais de téléportation",
	["Enable timers for port expiration"] = "Affiche les délais avant l'expiration de la téléportation vers les champs de bataille.",
	["Wait Timer"] = "Délais d'attente",
	["Enable timers for queue wait time"] = "Affiche les délais avant d'entrer dans les champs de bataille.",
	["Show/Hide Anchor"] = "Montrer/Masquer l'ancre",
	["Show/Hide the bars anchor (can also left-click a statusbar)"] = "Affiche/Masque l'ancre des barres (ou clic-gauche sur une barre de statut).",
	["Toggle class color"] = "Affiche ou non la couleur de classe.",
	["Enable/disable class color indicators on the scoreboard"] = "Active/Désactive les indicateurs de couleur des classes sur le tableau des scores.",
	["Narrow map mode"] = "Carte locale réduite",
	["Narrow the battlefield minimap, removing some empty space"] = "Réduit la carte locale du champ de bataille en enlevant certains espaces vides.",
	["Test"] = "Test",
	["Start a test bar"] = "Lance quelques barres de test.",
	["Reverse fill"] = "Remplir les barres",
	["Set statusbars to fill up instead of depleting"] = "Remplis les barres de statut au lieu de les vider.",
	--["Flip growth"] = true,
	["Set objective timers to grow up and misc timers to grow down"] = "Ajoute les délais des objectifs vers le haut et les délais divers vers le bas.",
	["Reposition Scoreboard"] = "Repositionner le tableau de score",
	["Move the scoreboard to the Capping anchor's CURRENT position"] = "Place le tableau de score sur la position ACTUELLE de l'ance de Capping",
	["Battlefield Minimap"] = "Carte locale",
	["Options for the battlefield minimap"] = "Options concernant la carte locale.",
	["Colors"] = "Couleurs",
	["Icons"] = "Icônes",
	["Bar icons display options"] = "Options concernant l'affichage des icônes.",
	["Spacing"] = "Espacement",
	["Request sync"] = "Demander une synchro",
	["LEFT"] = "GAUCHE",
	["RIGHT"] = "DROITE",
	["HIDE"] = "MASQUER",

	-- etc timers
	["Port: %s"] = "Port : %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "File : %s",
	["Battleground Begins"] = "Début du champ de bataille", -- bar text for bg gates opening (why can't they all be the same?)
	["1 minute"] = "1 minute",
	["30 seconds"] = "30 secondes",
	["One minute until"] = "commence dans une minute",
	["Thirty seconds until"] = "commence dans trente secondes",
	["Fifteen seconds until"] = "commence dans quinze secondes",
	["%s: %s - %d:%02d remaining"] = "%s : %s - %d:%02d restantes", -- chat message after shift left-clicking a bar

	-- AB
	["Bases: (%d+)  Resources: (%d+)/2000"] = "Bases : (%d+)  Ressources: (%d+)/2000",
	["Farm"] = "Ferme",
	["Lumber Mill"] = "Scierie",
	["Blacksmith"] = "Forge",
	["Gold Mine"] = "Mine d'or",
	["Stables"] = "Écurie",
	["Southern Farm"] = "Ferme du sud",
	["Mine"] = "Mine",
	["has assaulted"] = "a attaqué",
	["claims the"] = "a pris",
	["has taken the"] = "s'est emparée",
	["has defended the"] = "a défendu",
	["Final: 2000 - %d"] = "Final : 2000 - %d", -- final score text
	["wins 2000-%d"] = "Victoire 2000 - %d", -- final score chat message

	-- WSG
	["was picked up by (.+)!"] = "a été ramassé par (.+) !",
	["dropped"] = "a été lâché",
	["captured the"] = "a pris le drapeau de",
	["Flag respawns"] = "Réapparition drapeau(x)",
	["%s's flag carrier: %s (%s)"] = "Porteur du drapeau %s : %s (%s)", -- chat message

	-- AV
	-- NPC
	["Smith Regzar"] = "Forgeron Regzar",
	["Murgot Deepforge"] = "Murgot Forge-profonde",
	["Primalist Thurloga"] = "Primaliste Thurloga",
	["Arch Druid Renferal"] = "Archidruide Ranfarouche",
	["Stormpike Ram Rider Commander"] = "Commandant Chevaucheur de bélier Foudrepique",
	["Frostwolf Wolf Rider Commander"] = "Commandant Chevaucheur de loup Loup-de-givre ",

	-- patterns
	["avunderattack"] = "^(.+) est .* ! Si personne n'intervient,",
	["avtaken"] = "^(.+) a été pris",
	["avdestroyed"] = "^(.+) a été détruit",
	["The "] = "L(%w) ",
	["Snowfall Graveyard"] = "Cimetière des neiges",
	["Tower"] = "Tour",
	["Bunker"] = "Fortin",
	-- ["Upgrade to"] = true, -- the option to upgrade units in AV
	-- ["Wicked, wicked, mortals!"] = true, -- what Ivus says after being summoned
	["Ivus begins moving"] = "Ivus commence à bouger",
	["WHO DARES SUMMON LOKHOLAR"] = "QUI OSE INVOQUER LOKHOLAR", -- what Lok says after being summoned -- à vérifier
	["The Ice Lord has arrived!"] = "Le seigneur des glaces est arrivé !",
	["Lokholar begins moving"] = "Lokholar commence à bouger",

	-- EotS
	["^(.+) has taken the flag!"] = "^(.+) a pris le drapeau !",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "Bases : (%d+)  Points de victoire : (%d+)/2000",
})
