--[[
French
]]
local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate","frFR") if not L then return end
-- Spell names for Collector module
L["Mining"] = "Minage"
L["Fishing"] = "Pêche"
L["Herb Gathering"] = "Cueillette"
L["Extract Gas"] = "Extraction de gaz"
L["Herbalism"] = "Herboristerie"
L["Engineering"] = "Ingénierie"
L["Opening"] = "Ouverture"
L["Pick Lock"] = "Crochetage"
-- Display module
L["GatherMate Pin Options"] = "Options des points GatherMate"
L["Delete: "] = "Supprimer : "
L["Add this location to Cartographer_Waypoints"] = "Ajouter cette position à Cartographer_Waypoints"
L["Add this location to TomTom waypoints"] = "Ajouter cette position aux points de navigation de TomTom"

L["Always show"] = "Toujours afficher"
L["Only with profession"] = "Si j'ai le métier"
L["Only while tracking"] = "Si le suivi est activé"
L["Never show"] = "Ne jamais afficher"


-- Config modules
L["GatherMate"]= "GatherMate"
L["gathermate"]= "gathermate" -- slash command
---- Display Filters tree
L["Display Settings"] = "Affichage"
------ General subtree
L["General"] = "Général"
L["Show Databases"] = "Bases de données à afficher"
L["Selected databases are shown on both the World Map and Minimap."] = "Les bases de données sélectionnées sont affichées sur la carte du monde et la minicarte."
L["Show Mining Nodes"]= "Nœuds de minage"
L["Toggle showing mining nodes."]= "Affiche ou non les nœuds de minage"
L["Show Herbalism Nodes"]= "Nœuds d'herboristerie"
L["Toggle showing herbalism nodes."]= "Affiche ou non les nœuds d'herboristerie."
L["Show Fishing Nodes"]= "Nœuds de pêche"
L["Toggle showing fishing nodes."]= "Affiche ou non les nœuds de pêche."
L["Show Gas Clouds"]= "Nuages de gaz"
L["Toggle showing gas clouds."]= "Affiche ou non les nuages de gaz."
L["Show Treasure Nodes"]= "Nœuds de trésor"
L["Toggle showing treasure nodes."]= "Affiche ou non les nœuds de trésor."
L["Icons"] = "Icônes"
L["Control various aspects of node icons on both the World Map and Minimap."] = "Contrôle divers aspects des icônes des nœuds affichés sur la carte du monde et la minicarte."
L["Show Minimap Icons"]= "Icônes sur la minicarte"
L["Toggle showing Minimap icons."] = "Affiche ou non les icônes sur la minicarte."
L["Show World Map Icons"] = "Icônes carte du monde"
L["Toggle showing World Map icons."] = "Affiche ou non les icônes sur la carte du monde."
L["Keybind to toggle Minimap Icons"] = "Raccourci pour afficher/masquer les icônes"
L["Icon Scale"]= "Échelle des icônes"
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."]= "Permet d'agrandir ou de rétrécir les icônes affichées sur la carte du monde et la minicarte."
L["Icon Alpha"]= "Transparence des icônes"
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."]= "Permet de changer la valeur de transparence des icônes. S'applique uniquement à la carte du monde."
L["Miscellaneous"] = "Divers"
-- Cleanup subtree (now Database Maintenance)
L["Database Maintenance"] = "Maintenance BdD"
L["Cleanup_Desc"] = "Au fil du temps, votre base de données risque de devenir surchargée. Nettoyer votre base de données permet de vérifier les nœuds du même type de métier qui sont très proches les uns des autres et de déterminer s'il faut les rassembler en un seul nœud ou non."
L["Cleanup radius"] = "Rayon de nettoyage"
L["CLEANUP_RADIUS_DESC"] = "Le rayon en mètres où les nœuds dupliqués doivent être enlevés. La valeur par défaut est de |cffffd20050|r mètres pour l'extraction de gaz et de |cffffd20015|r mètres pour tout le reste. Ces paramètres sont également utilisés lors de l'ajout de nœuds."
L["Cleanup Database"] = "Nettoyer la base"
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = "Nettoye votre base de données en enlevant les doublons. Ceci peut prendre un petit moment, soyez patient."
L["Processing "] = "Traitement de "
L["Cleanup Complete."] = "Nettoyage terminé."
L["Delete Specific Nodes"] = "Supprimer des nœuds spécifiques"
L["DELETE_SPECIFIC_DESC"] = "Supprime tous les nœuds sélectionnés de la zone sélectionnée. Vous devez désactiver le Verrouillage des bases de données pour que ceci fonctionne."
L["Select Database"] = "Sélection de la base"
L["Select Node"] = "Sélection des nœuds"
L["Select Zone"] = "Sélection de la zone"
L["Delete"] = "Supprimer"
L["Delete selected node from selected zone"] = "Supprime les nœuds sélectionnés de la zone sélectionnée"
L["Are you sure you want to delete all of the selected node from the selected zone?"] = "Êtes-vous sûr de vouloir supprimer tous les nœuds sélectionnés de la zone sélectionnée ?"
L["Delete Entire Database"] = "Supprimer toute la base de données"
L["DELETE_ENTIRE_DESC"] = "Ceci ignorera le Verrouillage des bases de données et enlèvera tous les nœuds de toutes les zones de la base de données sélectionnée."
L["Are you sure you want to delete all nodes from this database?"] = "Êtes-vous sûr de vouloir supprimer tous les nœuds de cette base de données ?"
L["Database Locking"] = "Verrouillage des bases de données"
L["DATABASE_LOCKING_DESC"] = "Le verrouillage de base de données vous permet de figer l'état d'une base de données. Une fois verrouillée, il vous est impossible d'ajouter, de supprimer ou de modifier la base de données en question. Cela comprend le nettoyage et les importations."
L["Database locking"] = "Verrouille cette base de données si cochée."

-- Tracking options
L["Tracking Circle Color"] = "Couleur du cercle de suivi"
L["Color of the tracking circle."] = "Détermine la couleur du cercle de suivi."
L["Tracking Distance"] = "Distance de suivi"
L["The distance in yards to a node before it turns into a tracking circle"] = "Détermine la distance en mètres entre vous et le nœud avant que ce dernier ne se transforme en cercle de suivi."
L["Show Tracking Circle"] = "Affichage du cercle de suivi"
L["Toggle showing the tracking circle."] = "Affiche ou non le cercle de suivi."
L["Show Nodes on Minimap Border"] = "Afficher les nœuds sur les bords de la minicarte"
L["Shows more Nodes that are currently out of range on the minimap's border."] = "Affiche les nœuds qui sont actuellement hors de portée sur les bords de la minicarte."
------ Filters subtree
L["Filters"] = "Filtres"
L["Herb filter"] = "Filtre des herbes"
L["Select the herb nodes you wish to display."]= "Sélectionnez les nœuds d'herboristerie que vous souhaitez afficher."
L["Mine filter"] = "Filtre des mines"
L["Select the mining nodes you wish to display."] = "Sélectionnez les nœuds de minage que vous souhaitez afficher."
L["Fish filter"] = "Filtre des poissons"
L["Select the fish nodes you wish to display."] = "Sélectionnez les nœuds de pêche que vous souhaitez afficher."
L["Gas filter"] = "Filtre des gaz"
L["Select the gas clouds you wish to display."] = "Sélectionnez les nuages de gaz que vous souhaitez afficher."
L["Treasure filter"] = "Filtre des trésors"
L["Select the treasure you wish to display."] = "Sélectionnez les nœuds de trésor que vous souhaitez afficher."
L["Select All"] = "Tout sélectionner"
L["Select all nodes"] = "Sélectionne tous les nœuds."
L["Clear node selections"] = "Efface toute sélection de nœud."
L["Select None"] = "Ne rien sélectionner"
L["Gas Clouds"]= "Nuages de gaz"
L["Fishes"] = "Poissons"
L["Mineral Veins"] = "Veines de minerai"
L["Herb Bushes"] = "Buissons d'herbe"
L["Treasure"] = "Trésors"
L["Filter_Desc"] = "Sélectionnez les types de nœuds que vous souhaitez voir affichés sur la carte du monde et la minicarte. Les types de nœuds non sélectionnés continueront cependant à être enregistrés dans la base de données."
---- Import tree
L["Import Data"] = "Importation données"
L["Import GatherMateData"] = "Importer GatherMateData"
L["Importing_Desc"] = "L'importation permet à GatherMate d'obtenir de nouveau nœuds à partir de sources autres que vos propres récoltes dans le jeu. Après avoir importé des données, il est conseillé d'effectuer un nettoyage de la base de données."
L["Load GatherMateData and import the data to your database."] = "Charge GatherMate_Data et importe ses données dans votre base de données."
L["GatherMateData has been imported."] = "GatherMateData a été importé."
L["Failed to load GatherMateData due to "] = "Échec du chargement de GatherMateData suite à "
L["Merge"] = "Fusionner"
L["Overwrite"] = "Écraser"
L["Import Style"] = "Type d'importation"
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = "La fusion ajoutera GatherMateData dans votre base de données. L'écrasement remplacera votre base de données par les données contenues dans GatherMateData."
L["Databases to Import"] = "Bases de données à importer"
L["Databases you wish to import"] = "Bases de données que vous souhaitez importer."
L["Auto Import"] = "Importation auto."
L["Automatically import when ever you update your data module, your current import choice will be used."] = "Importe automatiquement quand vous mettez à jour votre module de données, en utilisant votre type d'importation actuel."
L["Auto import complete for addon "] = "Importation automatique terminée pour l'addon "
L["BC Data Only"] = "Données de BC uniquement"
L["Only import Burning Crusade data from WoWHead"] = "Importe uniquement les données de WowHead de Burning Crusade."
--- profile settings
L["Default"] = "Défaut"
L["Char:"] = "Perso :"
L["Realm:"] = "Royaume :"
L["Class:"] = "Classe :"
L["Profiles"] = "Profils"
L["Manage Profiles"] = "Gestion des profils"
L["You can change the active database profile of GatherMate, so you can have different settings and filters for every character, which will allow a very flexible configuration for everyones needs."] = "Vous pouvez changer le profil actif de GatherMate afin d'avoir des paramètres et des filtres différents pour chaque personnage, permettant ainsi d'avoir une configuration flexible adaptée aux besoins de chacun."
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = "Réinitialise le profil actuel au cas où votre configuration est corrompue ou si vous voulez tout simplement faire table rase."
L["You can create a new profile by entering a new name in the editbox, or choosing one of the already exisiting profiles."] = "Vous pouvez créer un nouveau profil en entrant un nouveau nom dans la boîte de saisie, ou choisir un des profils déjà existants."
L["Reset Profile"] = "Réinitialiser le profil"
L["Reset the current profile to the default"] = "Réinitialise le profil actuel avec les paramètres par défaut."
L["New"] = "Nouveau"
L["Create a new empty profile."] = "Créée un nouveau profil vierge."
L["Current"] = "Actuel"
L["Select one of your currently available profiles."] = "Permet de choisir un des profils déjà disponibles."
L["Copy the settings from one existing profile into the currently active profile."] = "Copie les paramètres d'un profil existant dans le profil actif."
L["Copy From"] = "Copier à partir de"
L["Copy the settings from another profile into the active profile."] = "Copie les paramètres d'un autre profil dans le profil actif."
L["Delete existing and unused profiles from the database to save space, and cleanup the GatherMate SavedVariables file."] = "Supprime les profils inutilisés de la base de données afin de gagner de la place et de nettoyer le fichier SavedVariables de GatherMate."
L["Delete a Profile"] = "Supprimer un profil"
L["Deletes a profile from the database."] = "Supprime un profil de la base de données."
L["Are you sure you want to delete the selected profile?"] = "Êtes-vous sûr de vouloir supprimer le profil sélectionné ?"
-- FAQ
L["FAQ"] = "FAQ"
L["Frequently Asked Questions"] = "Foire aux questions"
L["FAQ_TEXT"] = [[
|cffffd200
Je viens juste d'installer GatherMate, mais je ne vois aucun nœud sur mes cartes !
|r
GatherMate ne contient aucune donnée en l'état. Quand vous récoltez des herbes, des minerais, des gaz ou des poissons, GatherMate ajoutera et mettra à jour votre carte en conséquence. De plus, vérifiez vos paramètres d'affichage.

|cffffd200
Je vois des nœuds sur ma carte du monde mais pas sur ma minicarte !
|r
|cffffff78Minimap Button Bag|r (et sans doute d'autres addons similaires) aime phagocyter tous les boutons que nous plaçons sur la minicarte. Désactivez-le.

|cffffd200
Comment ou où puis-je obtenir des données déjà existantes ?
|r
Vous pouvez importer des données déjà existantes dans GatherMate des façons suivantes :

1. |cffffff78GatherMate_Data|r - Cet addon LoD (chargeable à la demande) contient des données extraites de WowHead de tous les nœuds et est mis à jour toutes les semaines. Il y a des options de mise à jour automatique.

2. |cffffff78GatherMate_CartImport|r - Cet addon vous permet d'importer vos bases de données des modules |cffffff78Cartographer_<Métier>|r dans GatherMate. Pour que cela fonctionne, le(s) module(s) |cffffff78Cartographer_<Métier>|r et GatherMate_CartImport doivent être chargés et activés.

Notez que l'importation de données dans GatherMate n'est pas un processus automatique. Vous devez aller dans la section "Importation données" et cliquer sur le bouton "Importer".

La différence avec |cffffff78Cartographer_Data|r est que l'utilisateur a le choix de la façon dont (et du moment où) les données sont modifiées. |cffffff78Cartographer_Data|r, une fois chargé, écrase simplement vos bases de données existantes sans avertissement et détruit tous les nouveaux nœuds que vous avez trouvé.

|cffffd200
Pouvez-vous ajouter le support de l'affichage des positions de choses telles que les boîtes aux lettres et les maîtres de vol ?
|r
À nouveau, la réponse est non. Cependant, un autre auteur a le droit de créer un addon ou un module à cet effet. Le cœur de l'addon GatherMate ne le fera jamais.

|cffffd200
J'ai trouvé un bogue ! Où puis-je le signaler ?
|r
Vous pouvez signaler des bogues ou faire des suggestions sur |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r

Vous pouvez également nous trouver sur |cffffff78irc://irc.freenode.org/wowace|r

Quand vous voulez signaler un bogue, essayez de fournir les |cffffff78étapes à suivre pour reproduire ce bogue|r, indiquez les |cffffff78messages d'erreur|r que vous avez vus, donnez le |cffffff78numéro de révision|r de GatherMate où le problème a été découvert et précisez également la |cffffff78langue de votre jeu|r.

|cffffd200
Qui a écrit cet addon qui déchire ?
|r
Kagaro, Xinhuan, Nevcairiel et Ammo.
]]




local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes","frFR") if not NL then return end
-- fish schools
NL["Floating Wreckage"] = "Débris flottants"
NL["Patch of Elemental Water"] = "Remous d'eau élémentaire"
NL["Floating Debris"] = "Débris flottant"
NL["Oil Spill"] = "Nappe de pétrole"
NL["Firefin Snapper School"] = "Banc de lutjans de nagefeu"
NL["Greater Sagefish School"] = "Banc de grandes sagerelles"
NL["Oily Blackmouth School"] = "Banc de bouches-noires huileux"
NL["Sagefish School"] = "Banc de sagerelles"
NL["School of Deviate Fish"] = "Banc de poissons déviants"
NL["Stonescale Eel Swarm"] = "Banc d'anguilles pierre-écaille"
--NL["Muddy Churning Water"] = "Eaux troubles et agitées"
NL["Highland Mixed School"] = "Banc mixte des Hautes-terres"
NL["Pure Water"] = "Eau pure"
NL["Bluefish School"] = "Banc de tassergals"
NL["Feltail School"] = "Banc de gangre-queues"
NL["Brackish Mixed School"] = "Banc mixte des eaux saumâtres"
NL["Mudfish School"] = "Banc d'éperlans"
NL["School of Darter"] = "Banc de dards"
NL["Sporefish School"] = "Banc de poissons-spores"
NL["Steam Pump Flotsam"] = "Détritus de la pompe à vapeur"
NL["School of Tastyfish"] = "Banc de courbine"
NL["Borean Man O' War School"] = "Banc de poissons-méduses boréens"
NL["Deep Sea Monsterbelly School"] = "Banc de baudroies abyssales"
NL["Dragonfin Angelfish School"] = "Banc de demoiselles aileron-de-dragon"
NL["Fangtooth Herring School"] = "Banc de harengs crocs-pointus"
NL["Floating Wreckage Pool"] = true
NL["Glacial Salmon School"] = "Banc de saumons glaciaires"
NL["Glassfin Minnow School"] = "Banc de vairons nageverres"
NL["Imperial Manta Ray School"] = "Banc de raies manta impériales"
NL["Moonglow Cuttlefish School"] = "Banc de seiches lueur-de-lune"
NL["Musselback Sculpin School"] = "Banc de rascasses dos-de-moule"
NL["Nettlefish School"] = "Banc de méduses"
NL["Strange Pool"] = "Bassin étrange"
NL["Schooner Wreckage"] = "Débris de goélette"
NL["Waterlogged Wreckage"] = "Débris trempés"
NL["Bloodsail Wreckage"] = "Débris de la Voile sanglante"
NL["Lesser Sagefish School"] = true
NL["Lesser Oily Blackmouth School"] = true
NL["Sparse Oily Blackmouth School"] = true
NL["Abundant Oily Blackmouth School"] = true
NL["Teeming Oily Blackmouth School"] = true
NL["Lesser Firefin Snapper School"] = true
NL["Sparse Firefin Snapper School"] = true
NL["Abundant Firefin Snapper School"] = true
NL["Teeming Firefin Snapper School"] = true
NL["Lesser Floating Debris"] = true
NL["Sparse Schooner Wreckage"] = true
NL["Abundant Bloodsail Wreckage"] = true
NL["Teeming Floating Wreckage"] = true

-- mine nodes
NL["Copper Vein"] = "Filon de cuivre"
NL["Tin Vein"] = "Filon d'étain"
NL["Iron Deposit"] = "Gisement de fer"
NL["Silver Vein"] = "Filon d'argent"
NL["Gold Vein"] = "Filon d'or"
NL["Mithril Deposit"] = "Gisement de mithril"
NL["Ooze Covered Mithril Deposit"] = "Gisement de mithril couvert de vase"
NL["Truesilver Deposit"] = "Gisement de vrai-argent"
NL["Ooze Covered Silver Vein"] = "Filon d'argent couvert de limon"
NL["Ooze Covered Gold Vein"] = "Filon d'or couvert de limon"
NL["Ooze Covered Truesilver Deposit"] = "Gisement de vrai-argent couvert de vase"
NL["Ooze Covered Rich Thorium Vein"] = "Riche filon de thorium couvert de limon"
NL["Ooze Covered Thorium Vein"] = "Filon de thorium couvert de limon"
NL["Small Thorium Vein"] = "Petit filon de thorium"
NL["Rich Thorium Vein"] = "Riche filon de thorium"
--NL["Hakkari Thorium Vein"] = "Filon de thorium Hakkari"
NL["Dark Iron Deposit"] = "Gisement de sombrefer"
NL["Lesser Bloodstone Deposit"] = "Gisement de pierre de sang inférieure"
NL["Incendicite Mineral Vein"] = "Filon d'incendicite"
NL["Indurium Mineral Vein"] = "Filon d'indurium"
NL["Fel Iron Deposit"] = "Gisement de gangrefer"
NL["Adamantite Deposit"] = "Gisement d'adamantite"
NL["Rich Adamantite Deposit"] = "Riche gisement d'adamantite"
NL["Khorium Vein"] = "Filon de khorium"
--NL["Large Obsidian Chunk"] = "Grand morceau d'obsidienne"
--NL["Small Obsidian Chunk"] = "Petit morceau d'obsidienne"
NL["Nethercite Deposit"] = "Gisement de néanticite"
NL["Cobalt Node"] = "Gisement de cobalt"
NL["Rich Cobalt Node"] = "Riche gisement de cobalt"
NL["Titanium Node"] = "Gisement de titanium"
NL["Saronite Node"] = "Gisement de saronite"
NL["Rich Saronite Node"] = "Riche gisement de saronite"

-- gas clouds
NL["Windy Cloud"] = "Nuage venteux"
NL["Swamp Gas"] = "Gaz des marais"
NL["Arcane Vortex"] = "Vortex arcanique"
NL["Felmist"] = "Gangrebrume"
NL["Steam Cloud"] = "Steam Cloud"
NL["Cinder Cloud"] = "Cinder Cloud"
NL["Arctic Cloud"] = "Arctic Cloud"

-- herb bushes
NL["Peacebloom"] = "Pacifique"
NL["Silverleaf"] = "Feuillargent"
NL["Earthroot"] = "Terrestrine"
NL["Mageroyal"] = "Mage royal"
NL["Briarthorn"] = "Eglantine"
--NL["Swiftthistle"] = "Chardonnier"
NL["Stranglekelp"] = "Etouffante"
NL["Bruiseweed"] = "Doulourante"
NL["Wild Steelbloom"] = "Aciérite sauvage"
NL["Grave Moss"] = "Tombeline"
NL["Kingsblood"] = "Sang-royal"
NL["Liferoot"] = "Vietérule"
NL["Fadeleaf"] = "Pâlerette"
NL["Goldthorn"] = "Dorépine"
NL["Khadgar's Whisker"] = "Moustache de Khadgar"
NL["Wintersbite"] = "Hivernale"
NL["Firebloom"] = "Fleur de feu"
NL["Purple Lotus"] = "Lotus pourpre"
--NL["Wildvine"] = "Sauvageonne"
NL["Arthas' Tears"] = "Larmes d'Arthas"
NL["Sungrass"] = "Soleillette"
NL["Blindweed"] = "Aveuglette"
NL["Ghost Mushroom"] = "Champignon fantôme"
NL["Gromsblood"] = "Gromsang"
NL["Golden Sansam"] = "Sansam doré"
NL["Dreamfoil"] = "Feuillerêve"
NL["Mountain Silversage"] = "Sauge-argent des montagnes"
NL["Plaguebloom"] = "Fleur de peste"
NL["Icecap"] = "Calot de glace"
--NL["Bloodvine"] = "Vignesang"
NL["Black Lotus"] = "Lotus noir"
NL["Felweed"] = "Gangrelette"
NL["Dreaming Glory"] = "Glaurier"
NL["Terocone"] = "Terocône"
--NL["Ancient Lichen"] = "Lichen ancien"
NL["Bloodthistle"] = "Chardon sanglant"
NL["Mana Thistle"] = "Chardon de mana"
NL["Netherbloom"] = "Néantine"
NL["Nightmare Vine"] = "Cauchemardelle"
NL["Ragveil"] = "Voile-misère"
NL["Flame Cap"] = "Chapeflamme"
NL["Netherdust Bush"] = "Buisson de pruinéante"
NL["Adder's Tongue"] = "Verpérenne"
NL["Constrictor Grass"] = "Pythonelle"
NL["Deadnettle"] = "Ortie blanche"
NL["Goldclover"] = "Trèfle doré"
NL["Icethorn"] = "Glacépine"
NL["Lichbloom"] = "Fleur-de-liche"
NL["Talandra's Rose"] = "Rose de Talandra"
NL["Tiger Lily"] = "Lys tigré"
NL["Firethorn"] = "Epine de feu"
NL["Frozen Herb"] = "Herbe gelée"

-- Treasure
NL["Giant Clam"] = "Palourde géante"
NL["Battered Chest"] = "Coffre endommagé"
NL["Tattered Chest"] = "Coffre en morceaux"
NL["Solid Chest"] = "Coffre solide"
NL["Large Iron Bound Chest"] = "Grand coffre cerclé de fer"
NL["Large Solid Chest"] = "Grand coffre solide"
NL["Large Battered Chest"] = "Grand coffre endommagé"
NL["Buccaneer's Strongbox"] = "Coffre des boucaniers" -- à vérifier
NL["Large Mithril Bound Chest"] = "Grand coffre cerclé de mithril"
NL["Large Darkwood Chest"] = "Grand coffre de sombrebois"
NL["Un'Goro Dirt Pile"] = "Tas de poussière d'Un'Goro"
NL["Bloodpetal Sprout"] = "Pousse de Pétale-de-sang"
NL["Blood of Heroes"] = "Sang des héros"
NL["Practice Lockbox"] = "Coffret d'apprentissage" -- à vérifier
NL["Battered Footlocker"] = "Cantine endommagée"
NL["Waterlogged Footlocker"] = "Cantine détrempée"
NL["Dented Footlocker"] = "Cantine abîmée"
NL["Mossy Footlocker"] = "Cantine moisie"
NL["Scarlet Footlocker"] = "Cantine écarlate"
NL["Burial Chest"] = "Coffre funéraire" -- à vérifier
NL["Fel Iron Chest"] = "Coffre en gangrefer"
NL["Heavy Fel Iron Chest"] = "Coffre lourd en gangrefer"
NL["Adamantite Bound Chest"] = "Coffre cerclé d'adamantite"
NL["Felsteel Chest"] = "Coffre en gangracier"
NL["Glowcap"] = "Chapeluisant"
NL["Wicker Chest"] = "Coffre en osier"
NL["Primitive Chest"] = "Coffre primitif" -- à vérifier
NL["Solid Fel Iron Chest"] = "Coffre solide en gangrefer"
NL["Bound Fel Iron Chest"] = "Coffre cerclé de gangrefer"
--NL["Bound Adamantite Chest"] = "Coffre cerclé d'adamantite" -- Only appears in instances, and also conflicting reverse lookup table with 7 lines up.
NL["Netherwing Egg"] = "Oeuf de l'Aile-du-Néant"
