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
	["Auto quest turnins"] = "Rendre auto. les quêtes",
	["Bar"] = "Barres",
	["Width"] = "Longueur",
	["Height"] = "Hauteur",
	["Texture"] = "Texture",
	["Other"] = "Autre",
	["Other options"] = "Autres options",
	["Auto show map"] = "Afficher auto. la carte",
	["Map scale"] = "Échelle de la carte",
	["Hide border"] = "Masquer la bordure",
	["Port Timer"] = "Délais de téléportation",
	["Wait Timer"] = "Délais d'attente",
	["Show/Hide Anchor"] = "Montrer/Masquer l'ancre",
	["Narrow map mode"] = "Carte locale réduite",
	["Test"] = "Test",
	["Flip growth"] = "Séparer par type",
	["Reposition Scoreboard"] = "Repositionner le tableau de score",
	["Battlefield Minimap"] = "Carte locale",
	["Icons"] = "Icônes",
	["Spacing"] = "Espacement",
	["Request sync"] = "Demander une synchro",
	["LEFT"] = "GAUCHE",
	["RIGHT"] = "DROITE",
	["HIDE"] = "MASQUER",
	["Fill grow"] = "Remplir au lieu de vider",
	["Fill right"] = "Inverser le sens",
	["Font"] = "Police d'écriture",
	["Time position"] = "Position de la durée",
	["Border width"] = "Largeur de bordure",
	["Send to BG"] = "Envoyer au canal CdB",
	["Or <Ctrl-left-click> a timer"] = "Ou <Ctrl-clic-gauche> sur un délai.",
	["Send to SAY"] = "Envoyer au canal Dire",
	["Or <Shift-left-click> a timer"] = "Ou <Shift-clic-gauche> sur un délai.",
	["Cancel timer"] = "Annuler le délai",
	["Or <Ctrl-right-click> a timer"] = "Ou <Ctrl-clic-droit> sur un délai.",
	["Reposition Capture Bar"] = "Repositionner la barre de capture",

	-- etc timers
	["Port: %s"] = "Port : %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "File : %s",
	["Battleground Begins"] = "Début du champ de bataille", -- bar text for bg gates opening (why can't they all be the same?)
	["2 minutes"] = "2 minutes",
	["1 minute"] = "1 minute",
	["30 seconds"] = "30 secondes",
	["One minute until"] = "commence dans une minute",
	["Thirty seconds until"] = "commence dans trente secondes",
	["Fifteen seconds until"] = "commence dans quinze secondes",
	["%s: %s - %d:%02d remaining"] = "%s : %s - %d:%02d restantes", -- chat message after shift left-clicking a bar

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
	["Final: 2000 - %d"] = "Final : 2000 - %d", -- final score text
	["wins 2000-%d"] = "Victoire 2000 - %d", -- final score chat message

	-- WSG
	["was picked up by (.+)!"] = "a été ramassé par (.+) !",
	["dropped"] = "a été lâché",
	["captured the"] = "a pris le drapeau de",
	["Flag respawns"] = "Réapparition drapeau(x)",
	["%s's flag carrier: %s (%s)"] = "Porteur du drapeau %s : %s (%s)", -- chat message

	-- AV
	-- NPC
	["Smith Regzar"] = "Forgeron Regzar",
	["Murgot Deepforge"] = "Murgot Forge-profonde",
	["Primalist Thurloga"] = "Primaliste Thurloga",
	["Arch Druid Renferal"] = "Archidruide Ranfarouche",
	["Stormpike Ram Rider Commander"] = "Commandant Chevaucheur de bélier Foudrepique",
	["Frostwolf Wolf Rider Commander"] = "Commandant Chevaucheur de loup Loup-de-givre ",

	-- patterns
	["avunderattack"] = "Le (.+) est attaqué ! Si personne n'intervient,",
	["avunderattack2"] = "La (.+) est attaquée ! Si personne n'intervient,",
	["avtaken"] = "Le (.+) a été pris par",
	["avtaken2"] = "La (.+) a été prise par",
	["avdestroyed"] = "Le (.+) a été détruit par",
	["avdestroyed2"] = "La (.+) a été détruite par",
	["Snowfall Graveyard"] = "Cimetière des neiges",
	["Tower"] = "Tour",
	["Bunker"] = "Fortin",
	-- ["Upgrade to"] = true, -- the option to upgrade units in AV
	-- ["Wicked, wicked, mortals!"] = true, -- what Ivus says after being summoned
	["Ivus begins moving"] = "Ivus commence à bouger",
	["WHO DARES SUMMON LOKHOLAR"] = "QUI OSE INVOQUER LOKHOLAR", -- what Lok says after being summoned -- à vérifier
	["The Ice Lord has arrived!"] = "Le seigneur des glaces est arrivé !",
	["Lokholar begins moving"] = "Lokholar commence à bouger",

	-- EotS
	["^(.+) has taken the flag!"] = "^(.+) a pris le drapeau !",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "Bases : (%d+)  Points de victoire : (%d+)/2000",
})
