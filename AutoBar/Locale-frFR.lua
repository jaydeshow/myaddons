--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Courtesy of Cinedelle
--

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")

L:RegisterTranslations("frFR", function() return {
	    ["AutoBar"] = "AutoBar",
	    ["CONFIG_WINDOW"] = "Fen\195\170tre de configuration",
	    ["SLASHCMD_LONG"] = "/autobar",
	    ["SLASHCMD_SHORT"] = "/atb",
	    ["Button"] = "Bouton",
	    ["EDITSLOT"] = "Editer l'emplacement",
	    ["VIEWSLOT"] = "Voir l'emplacement",
		["LOAD_ERROR"] = "|cff00ff00Erreur de chargement d'AutoBarConfig. Assurez-vous qu'il soit présent et activé.|r Error: ",
		["Toggle the config panel"] = "Toggle the config panel",
		["Empty"] = "Empty",

		-- Waterfall
		["Macro Text"] = "Nom des macros",
		["Show the button Macro Text"] = "Affiche les noms des macros sur les boutons.",
		["Show Hotkey Text"] = "Affiche le raccourci.",
		["Show Hotkey Text for %s"] = "Affiche le raccourci du %s",
		["Show Grid"] = "Afficher la grille",
		["Show the grid of the bar even while locked."] = "Affiche la grille même quand la barre est verrouillée.",
		["Alpha"] = "Transparence",
		["Change the alpha of the bar."] = "Modifie la transparence de la barre.",
		["Align Buttons"] = "Alignement des boutons",
		["Always Show"] = "Toujours visible";
		["Always Show %s, even if empty."] = "Toujours voir %s, même si vide.";
		["Bars"] = "Barres",
		["Battlegrounds only"] = "En champs de bataille seulement",
		["Button Width"] = "Largeur du bouton",
		["Change the button width."] = "Changer la largeur des boutons",
		["Button Height"] = "Hauteur du bouton",
		["Change the button height."] = "Changer la hauteur des boutons",
		["Category"] = "Catégorie",
		["Categories"] = "Catégories",
		["Categories for %s"] = "Catégories pour %s",
		["Collapse Buttons"] = "Réduction des boutons",
		["Collapse Buttons that have nothing in them."] = "Efface les boutons qui n'ont plus aucun objet",
		["Configuration for %s"] = "Configuration pour %s",
		["Delete"] = "Effacer",
		["Dialog"] = "Dialogue",
		["Docked to"] = "Ancrer à",
		["Enabled"] = "Activé",
		["Enable %s."] = "Activ %s.",
		["No Popup"] = "Pas de déploiement";
		["No Popup for %s"] = "Pas de déploiement pour %s";
		["Show Count Text"] = "Afficher la quantité";
		["Show Count Text for %s"] = "Afficher la quantité pour %s";
		["Show Empty Buttons"] = "Afficher les boutons vide";
		["Show Empty Buttons for %s"] = "Afficher les boutons vide pour %s";
		["Number of columns for %s"] = "Nombre de colonnes pour %s",
		["FadeOut"] = "Fondu",
		["Fade out the Bar when not hovering over it."] = "Effectue un fondu de la barre si elle n'est pas survolée",
		["Frame Level"] = "Plan d'affichage",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "Ajuste le plan d'affichage de la barre et des boutons déployés afin qu'ils apparaissent sur ou sous les éléments de l'interface",
		["General"] = "Général",
		["Hide"] = "Cacher",
		["Hide %s"] = "Cache %s",
		["Item"] = "Objet",
		["Items"] = "Objets",
		["Location"] = "Localisation",
		["Medium"] = "Moyen",
		["Name"] = "Nom",
		["New"] = "Nouveau",
		["Non Combat Only"] = "Hors combat seulement",
		["Not directly usable"] = "Indirectement utilisable",
		["Order"] = "Ordonner",
		["Change the order of %s in the Bar"] = "Modifie l'ordre de %s dans la barre",
		["Padding"] = "Espacement",
		["Change the padding of the bar."] = "Modifie l'espacement entre les boutons.",
		["Popup Direction"] = "Orientation du déploiement des boutons",
		["Refresh"] = "Rafraîchir",
		["Refresh all the bars & buttons"] = "Rafraîchie toutes les barres et boutons",
		["Reset"] = "Réinitialisation",
		["Reset Bars"] = "Réinitialiser les barres",
		["Reset the Bars to default Bar settings"] = "Réinitialise les barres à la configuartion par défaut",
		["Rows"] = "Lignes",
		["Number of rows for %s"] = "Nombre de ligne pour %s",
		["Scale"] = "Echelle",
		["Change the scale of the bar."] = "Modifie l'échelle de la barre.",
		["Shift Dock Left/Right"] = "Inversion de l'ancrage gauche/droite";
		["Shift Dock Up/Down"] = "Inversion de l'ancrage haut/bas";
		["Snap Bars while moving"] = "Unifie les barres en un bloc lors d'un déplacement",
		["Sticky Frames"] = "Fenêtres magnétiques",
		["Style"] = "Style",
		["Change the style of the bar."] = "Modifie le style de la barres",
		["Targeted"] = "Ciblé",
		["Waterfall-1.0 is required to access the GUI."] = "Waterfall-1.0 est nécessaire pour utiliser le GUI",
		["<Any String>"] = "<Toutes chaînes>",
		["Move the Bars"] = "Déplacer les barres",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "Déplacer la barre pour la bouger, clique-gauche pour la cacher (rouge) ou la montrer (vert), clique-droit pour la configurer",
		["Move the Buttons"] = "Déplacer les boutons",
		["Drag a Button to move it, right click to configure the Button."] = "Déplacer le bouton pour le bouger, clique-droit pour le configurer",

		["TOPLEFT"] = "Haut gauche",
		["LEFT"] = "Gauche",
		["BOTTOMLEFT"] = "Bas gauche",
		["TOP"] = "Haut",
		["CENTER"] = "Centre",
		["BOTTOM"] = "Bas",
		["TOPRIGHT"] = "Haut droit",
		["RIGHT"] = "droit",
		["BOTTOMRIGHT"] = "Bas droit",

		-- AutoBarFuBar
		["FuBarPlugin Config"] = "Configuration du plugin FuBar",
		["Configure the FuBar Plugin"] = "Configurer le plugin FuBar",
		["Button lock"] = "Verrouiller les boutons",
		["Bar lock"] = "Verrouiller les barres",
		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55fDouble-Clic|r pour ouvrir le GUI de configuration.\n|cffeda55fCtrl-Clic|r pour (dé)verrouiller les boutons. |cffeda55fShift-Clic|r pour (dé)verrouiller les barres.",
		["Waterfall-1.0 is required to access the GUI."] = "Waterfall-1.0 est nécessaire pour utiliser le GUI",

		["Self Casting"] = "Lancement sur soi",
		["Configure Self Casting options"] = "Configure le lancement sur soi",
		["Modifier SelfCast"] = "Modificateur pour le lancement sur soi",
		["SelfCast using the Interface SelfCast Modifier"] = "Lancement sur soi en utilisant le modificateur choisi",
		["RightClick SelfCast"] = "Clique-droit pour lancer sur soi",
		["SelfCast using Right click"] = "Lancement sur soi en cliqaunt droit",

		-- Bar Names
		["AutoBarClassBarBasic"] = "Basic",
		["AutoBarClassBarDruid"] = "Druide",
		["AutoBarClassBarHunter"] = "Chasseur",
		["AutoBarClassBarMage"] = "Mage",
		["AutoBarClassBarPaladin"] = "Paladin",
		["AutoBarClassBarPriest"] = "Prêtre",
		["AutoBarClassBarRogue"] = "Voleur",
		["AutoBarClassBarShaman"] = "Chaman",
		["AutoBarClassBarWarlock"] = "Démoniste",
		["AutoBarClassBarWarrior"] = "Guerrier",

		-- Button Names
		["Buttons"] = "Boutons",
		["AutoBarButtonHeader"] = "Nom des boutons de l'AutoBar",
		["AutoBarCooldownHeader"] = "Cooldown des potions et pierres",

		["AutoBarButtonAura"] = "Aura / Aspect",
		["AutoBarButtonBandages"] = "Bandages",
		["AutoBarButtonBattleStandards"] = "Etendards de bataille",
		["AutoBarButtonBuff"] = "Buff",
		["AutoBarButtonBuffWeapon1"] = "Buff d'arme main droite",
		["AutoBarButtonBuffWeapon2"] = "Buff d'arme main gauche",
		["AutoBarButtonClassBuff"] = "Buff de classe",
		["AutoBarButtonClassPet"] = "Familier de classe",
		["AutoBarButtonConjure"] = "Conjuration",
		["AutoBarButtonCooldownPotionHealth"] = "Cooldown de potion : Vie",
		["AutoBarButtonCooldownPotionMana"] = "Cooldown de potion : Mana",
		["AutoBarButtonCooldownPotionRejuvenation"] = "Cooldown de potion : Restauration",
		["AutoBarButtonCooldownStoneHealth"] = "Cooldown de pierre : Vie",
		["AutoBarButtonCooldownStoneMana"] = "Cooldown de pierre : Mana",
		["AutoBarButtonCooldownStoneRejuvenation"] = "Cooldown de pierre : Restauration",
		["AutoBarButtonCrafting"] = "Artisanat",
		["AutoBarButtonElixirBattle"] = "Elixir de bataille",
		["AutoBarButtonElixirGuardian"] = "Elixir du Guardien",
		["AutoBarButtonElixirBoth"] = "Elixir de bataille et du Gardien",
		["AutoBarButtonER"] = "ER",
		["AutoBarButtonExplosive"] = "Explosif",
		["AutoBarButtonFishing"] = "Pêche",
		["AutoBarButtonFood"] = "Nourriture",
		["AutoBarButtonFoodBuff"] = "Nourriture apportant un Buff",
		["AutoBarButtonFoodCombo"] = "Nourriture Vie/Mana",
		["AutoBarButtonFoodPet"] = "Nourriture pour familier",
		["AutoBarButtonFreeAction"] = "Action Libre",
		["AutoBarButtonHeal"] = "Soin",
		["AutoBarButtonSpell1"] = "Sort 1",
		["AutoBarButtonSpell2"] = "Sort 2",
		["AutoBarButtonSpell3"] = "Sort 3",
		["AutoBarButtonSpell4"] = "Sort 4",
		["AutoBarButtonHearth"] = "Pierre de foyer",
		["AutoBarButtonPickLock"] = "Crochetage",
		["AutoBarButtonMount"] = "Monture",
		["AutoBarButtonPets"] = "Animaux de compagnie",
		["AutoBarButtonQuest"] = "Quête",
		["AutoBarButtonRecovery"] = "Mana / Rage / Energie",
		["AutoBarButtonSpeed"] = "Vitesse",
		["AutoBarButtonStance"] = "Stance",
		["AutoBarButtonStealth"] = "Camouflage",
		["AutoBarButtonSting"] = "Piqure",
		["AutoBarButtonTotemEarth"] = "Totem de terre",
		["AutoBarButtonTotemAir"] = "Totem d'air",
		["AutoBarButtonTotemFire"] = "Totem de feu",
		["AutoBarButtonTotemWater"] = "Totem d'eau",
		["AutoBarButtonTrack"] = "Pistage",
		["AutoBarButtonTrap"] = "Piège",
		["AutoBarButtonTrinket1"] = "Bijou 1",
		["AutoBarButtonTrinket2"] = "Bijou 2",
		["AutoBarButtonWater"] = "Eau",
		["AutoBarButtonWaterBuff"] = "Eau apportant un Buff",

		["AutoBarButtonBear"] = "Ours",
		["AutoBarButtonBoomkinTree"] = "Arbre de vie / Sélénien",
		["AutoBarButtonCat"] = "Chat",
		["AutoBarButtonTravel"] = "Voyage",
		["AutoBarButtonFlight"] = "Vol",
		["AutoBarButtonNormal"] = "Normal",


		-- AutoBarClassButton.lua
		["Num Pad "] = "Pavé num ",
		["Mouse Button "] = "Bouton de la souri ",
		["Middle Mouse"] = "Bouton du milieu",
		["Backspace"] = "Effacement",
		["Spacebar"] = "Barre d'espace",

		["Home"] = "Home",
		["End"] = "Fin",
		["Insert"] = "Inser",
		["Page Up"] = "Page Up",
		["Page Down"] = "Page Down",
		["Down Arrow"] = "Flèche basse",
		["Up Arrow"] = "Flèche haute",
		["Left Arrow"] = "Flèche gauche",
		["Right Arrow"] = "Flèche droite",
		["|c00FF9966C|r"] = "|c00FF9966C|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["|c009966CCA|r"] = "|c009966CCA|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["NP"] = "PN",
		["M"] = "S",
		["MM"] = "SM",
		["Bs"] = "Bs",
		["Sp"] = "Es",
		["De"] = "De",
		["Ho"] = "Ho",
		["En"] = "En",
		["Ins"] = "Ins",
		["Pu"] = "Pu",
		["Pd"] = "Pd",
		["D"] = "B",
		["U"] = "H",
		["L"] = "G",
		["R"] = "D",

		--  AutoBarConfig.lua
		["EMPTY"] = "Vide";
		["Default"] = "Défaut",
		["Zoomed"] = "Zoomé",
		["Dreamlayout"] = "Dreamlayout",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "Désactive le lancement sur soi par clique-droit";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Effacer la catégorie actuelle";
		["Rows"] = "Lignes";
		["Columns"] = "Colonnes";
		["AUTOBAR_CONFIG_GAPPING"] = "Espacement des icones";
		["AUTOBAR_CONFIG_ALPHA"] = "Transparence dee icones";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Hauteur et Largeur \ndes boutons non proportionnelle";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Afficher les icones de catégorie";
		["Show Tooltips"] = "Afficher les bulles d'aides";
		["Show Tooltips for %s"] = "Afficher les bulles d'aides pour %s";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Déploiement uniquement \navec la touche Shift(MAJ)";
		["Rearrange Order on Use"] = "Réorganise l'ordre \nlors d'une utilisation";
		["Rearrange Order on Use for %s"] = "Réorganise l'ordre de %s lors d'une utilisation";
		["Right Click Targets Pet"] = "Clique-droit cible le familier";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "Aucun";
		["AUTOBAR_CONFIG_BT3BAR"] = "BarTender3 Bar";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Menu principal";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Fenêtre de chat";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Menu des fenêtre de chat";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Barre d'action";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu des boutons";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(Objet : non trouvé ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " Set (cliquer pour éditer)";
		["AUTOBAR_CONFIG_CHARACTER"] = "Personnage :";
		["AUTOBAR_CONFIG_SHARED"] = "Partagé";
		["AUTOBAR_CONFIG_CLASS"] = "Classe";
		["AUTOBAR_CONFIG_BASIC"] = "Base";
		["AUTOBAR_CONFIG_USECHARACTER"] = "Utiliser le set personnage";
		["AUTOBAR_CONFIG_USESHARED"] = "Utiliser le set partagé";
		["AUTOBAR_CONFIG_USECLASS"] = "Utiliser le set de classe";
		["AUTOBAR_CONFIG_USEBASIC"] = "Utiliser le set de base";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "Cacher les bulles d'aide de configuration";
		["AUTOBAR_CONFIG_OSKIN"] = "Utiliser oSkin";
		["Log Performance"] = "Enregistrer les perfomances";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "Organisation pour le personnage";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "Organisation partagée";
		["AUTOBAR_CONFIG_SHARED1"] = "Partage 1";
		["AUTOBAR_CONFIG_SHARED2"] = "Partage 2";
		["AUTOBAR_CONFIG_SHARED3"] = "Partage 3";
		["AUTOBAR_CONFIG_SHARED4"] = "Partage 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "Editer le set personnage";
		["AUTOBAR_CONFIG_EDITSHARED"] = "Editer le set partagé";
		["AUTOBAR_CONFIG_EDITCLASS"] = "Editer le set de classe";
		["AUTOBAR_CONFIG_EDITBASIC"] = "Editer le set de base";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "Feu d'artifice",
		["Tradeskill.Tool.Fishing.Lure"] = "Leurres de pêche",
		["Tradeskill.Tool.Fishing.Gear"] = "Equipement de pêche",
		["Tradeskill.Tool.Fishing.Tool"] = "Cannes à pêche",

		["Consumable.Food.Bonus"] = "Nourriture: Tout bonus";
		["Consumable.Food.Buff.Strength"] = "Nourriture : Bonus de force";
		["Consumable.Food.Buff.Agility"] = "Nourriture : Bonus d'agilité";
		["Consumable.Food.Buff.Attack Power"] = "Nourriture : Bonus de puissance d'attaque";
		["Consumable.Food.Buff.Healing"] = "Nourriture : Bonus de soin";
		["Consumable.Food.Buff.Spell Damage"] = "Nourriture : Bonus de dégat de sorts";
		["Consumable.Food.Buff.Stamina"] = "Nourriture : Bonus d'endurance";
		["Consumable.Food.Buff.Intellect"] = "Nourriture : Bonus d'intelligence";
		["Consumable.Food.Buff.Spirit"] = "Nourriture : Bonus d'esprit";
		["Consumable.Food.Buff.Mana Regen"] = "Nourriture : Bonus de régération de mana";
		["Consumable.Food.Buff.HP Regen"] = "Nourriture : Bonus de régération de vie";
		["Consumable.Food.Buff.Other"] = "Nourriture : Autre";

		["Consumable.Buff.Health"] = "Buff : Vie";
		["Consumable.Buff.Armor"] = "Buff : Armure";
		["Consumable.Buff.Regen Health"] = "Buff : Régénration de vie";
		["Consumable.Buff.Agility"] = "Buff : Agilité";
		["Consumable.Buff.Intellect"] = "Buff : Intelligence";
		["Consumable.Buff.Protection"] = "Buff : Protection";
		["Consumable.Buff.Spirit"] = "Buff : Esprit";
		["Consumable.Buff.Stamina"] = "Buff : Endurance";
		["Consumable.Buff.Strength"] = "Buff : Force";
		["Consumable.Buff.Attack Power"] = "Buff : puissance d'attaque";
		["Consumable.Buff.Attack Speed"] = "Buff : vitesse d'attaque";
		["Consumable.Buff.Dodge"] = "Buff : Esquive";
		["Consumable.Buff.Resistance"] = "Buff : Résistance";

		["Consumable.Buff Group.General.Self"] = "Buff: Général";
		["Consumable.Buff Group.General.Target"] = "Buff: Cible générale";
		["Consumable.Buff Group.Caster.Self"] = "Buff: Lanceur";
		["Consumable.Buff Group.Caster.Target"] = "Buff: Cible du lanceur";
		["Consumable.Buff Group.Melee.Self"] = "Buff: C.A.C.";
		["Consumable.Buff Group.Melee.Target"] = "Buff: Cible du C.A.C.";
		["Consumable.Buff.Other.Self"] = "Buff : Autre";
		["Consumable.Buff.Other.Target"] = "Buff : Autre cible";
		["Consumable.Buff.Chest"] = "Buff : Torse";
		["Consumable.Buff.Shield"] = "Buff : Bouclier";
		["Consumable.Weapon Buff"] = "Buff : Arme";

		["Misc.Usable.Permanent"] = "Objets utilisables en permanance";
		["Misc.Usable.Quest"] = "Objets de quête utilisables";
		["Misc.Usable.Replenished"] = "Objets empilables";

		["Consumable.Cooldown.Potion.Health.Basic"] = "Potions de soin";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "Potions de soin : Les Tranchantes";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "Potions de soin : Réservoir de Glissecroc";
		["Consumable.Cooldown.Potion.Health.PvP"] = "Potions de soin : Champs de bataille";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "Potions de soin: Donjon de la tempête";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "Potions de mana";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "Potions de mana : Les Tranchantes";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "Potions de mana : Réservoir de Glissecroc";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "Potions de mana : Champs de bataille";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "Potions de mana : Donjon de la tempête";

		["Consumable.Weapon Buff.Poison.Crippling"] = "Poison affaiblissant";
		["Consumable.Weapon Buff.Poison.Deadly"] = "Poison mortel";
		["Consumable.Weapon Buff.Poison.Instant"] = "Poison instantan\195\169";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "Poison de distraction mentale";
		["Consumable.Weapon Buff.Poison.Wound"] = "Poison douloureux";
		["Consumable.Weapon Buff.Oil.Mana"] = "Huile de mana";
		["Consumable.Weapon Buff.Oil.Wizard"] = "Huile de sorcier";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "Pierres à aiguiser";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "Contre-poids";

		["Consumable.Bandage.Basic"] = "Bandages";
			["Consumable.Bandage.Battleground.Alterac Valley"] = "Bandages d'Alterac";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "Bandages du goulet";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "Bandages d'Arathi";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "Nourriture : Aucun Bonus";
		["Consumable.Food.Percent.Basic"] = "Nourriture : gain de vie en %";
		["Consumable.Food.Percent.Bonus"] = "Nourriture : Gain de vie en % (Buff : bien nourri)";
		["Consumable.Food.Combo Percent"] = "Nourriture : Gain de vie et mana en %";
		["Consumable.Food.Combo Health"] = "Nourriture et eau / vie et mana";
		["Consumable.Food.Edible.Bread.Conjured"] = "Nourriture : Conjuré par les Mages";
		["Consumable.Food.Conjure"] = "Nourriture conjuré";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "Nourriture : Bassin d'Arathi";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "Nourriture : Goulet des Chanteguerres";

		["Consumable.Food.Pet.Bread"] = "Nourriture : Pain pour familier";
		["Consumable.Food.Pet.Cheese"] = "Nourriture : Fromage pour familier";
		["Consumable.Food.Pet.Fish"] = "Nourriture : Poisson pour familier";
		["Consumable.Food.Pet.Fruit"] = "Nourriture : Fruit pour familier";
		["Consumable.Food.Pet.Fungus"] = "Nourriture : Champignon pour familier";
		["Consumable.Food.Pet.Meat"] = "Nourriture : Viande pour familier";

		["Consumable.Buff Pet"] = "Buff: Familier";

		["Custom"] = "Personnaliser";
		["Misc.Minipet.Normal"] = "Animaux de compagnie";
		["Misc.Minipet.Snowball"] = "Animaux de compagnie hivernal";
		["AUTOBAR_CLASS_UNGORORESTORE"] = "Cristal de restauration - Un'Goro";

		["Consumable.Anti-Venom"] = "Anti-Venin";

		["Consumable.Cooldown.Stone.Health.Warlock"] = "Pierre de soin";
		["Spell.Warlock.Create Firestone"] = "Créer une Pierre de feu";
		["Spell.Warlock.Create Healthstone"] = "Créer une Pierre de soin";
		["Spell.Warlock.Create Soulstone"] = "Créer une Pierre d'âme";
		["Spell.Warlock.Create Spellstone"] = "Créer une Pierre de sort";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "Pierres de mana";
		["Consumable.Mage.Conjure Mana Stone"] = "Conjurer une Pierre de mana";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "Sommeil sans rêve";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "Potions de régénération";
		["Consumable.Cooldown.Stone.Health.Statue"] = "Statues de pierre";
		["Consumable.Leatherworking.Drums"] = "Tambours";
		["Consumable.Tailor.Net"] = "Filets";

		["Misc.Battle Standard.Battleground"] = "Etendard de bataille";
		["Misc.Battle Standard.Alterac Valley"] = "Etendard de bataille (VA)";
		["Consumable.Cooldown.Stone.Health.Other"] = "Objet de soin : Autre";
		["Consumable.Cooldown.Stone.Mana.Other"] = "Runes démoniaques et ténébreuses";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "Protection : Arcane";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "Protection : Feu";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "Protection : Givre";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "Protection : Nature";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "Protection : Ombre";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "Protection : Sorts";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "Protection : Sacré";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "Potions d'invulnérabilité";
		["Consumable.Buff.Free Action"] = "Buff : Libre action";

		["Misc.Lockboxes"] = LOCKED;
		["Gear.Trinket"] = INVTYPE_TRINKET;

		["Spell.Aura"] = "Aura / Aspect";
		["Spell.Buff.Weapon"] = "Sorts de Buff : Arme";
		["Spell.Class.Buff"] = "Class Buff";
		["Spell.Class.Pet"] = "Class Pet";
		["Spell.Crafting"] = "Artisanat";
		["Spell.Fishing"] = "Pêche";
		["Spell.Portals"] = "Portaille et téléportation";
		["Spell.Sting"] = "Piqure";
		["Spell.Stance"] = "Stance";
		["Spell.Totem.Earth"] = "Totem de terre";
		["Spell.Totem.Air"] = "Totem d'air";
		["Spell.Totem.Fire"] = "Totem de feu";
		["Spell.Totem.Water"] = "Totem d'eau";
		["Spell.Track"] = "Pistage";
		["Spell.Trap"] = "Piège";
		["Misc.Hearth"] = "Pierre de foyer";
		["Misc.Booze"] = "Bibine";
		["Consumable.Water.Basic"] = "Eau";
		["Consumable.Water.Percentage"] = "Eau : gain de mana en %";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "Eau : Conjurée par les Mages";
		["Consumable.Water.Conjure"] = "Eau conjurée";
		["Consumable.Water.Buff.Spirit"] = "Eau : Bonus d'esprit";
		["Consumable.Water.Buff"] = "Eau : Bonus";
		["Consumable.Buff.Rage"] = "Potions de Rage";
		["Consumable.Buff.Energy"] = "Potions d'énergie";
		["Consumable.Buff.Speed"] = "Potions de rapidité";
		["Consumable.Buff Type.Battle"] = "Buff: Elixirs de bataille";
		["Consumable.Buff Type.Guardian"] = "Buff: Elixirs du Guardien";
		["Consumable.Buff Type.Both"] = "Buff: Elixirs de bataille et du Guardien réunis";
		["AUTOBAR_CLASS_SOULSHARDS"] = "Fragment d'âmes";
		["Reagent.Ammo.Arrow"] = "Flèches";
		["Reagent.Ammo.Bullet"] = "Balles";
		["Reagent.Ammo.Thrown"] = "Armes de jet";
		["Misc.Explosives"] = "Explosifs";
		["Misc.Mount.Normal"] = "Monture";
		["Misc.Mount.Summoned"] = "Monture： Invoquée";
		["Misc.Mount.Ahn'Qiraj"] = "Monture: Qiraji";
		["Misc.Mount.Flying"] = "Monture: Volante";

		["Revert"] = "Inverser";
		["Done"] = "OK";
	}
end);


if (GetLocale() == "frFR") then

--AUTOBAR_CHAT_MESSAGE1 = "La configuration pour ce personnage vient d'une ancienne version. Effacer. Aucune tentative de mise \195\160 jour n'a \195\169t\195\169 tent\195\169.";
--AUTOBAR_CHAT_MESSAGE2 = "Mise \195\160 jour du bouton multi-objet #%d objet #%d afin d'utiliser l'ID \195\160 la place du nom de l'objet.";
--AUTOBAR_CHAT_MESSAGE3 = "Mise à jour du bouton mono-objet #%d objet #%d afin d'utiliser l'ID \195\160 la place du nom de l'objet.";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_VIEWTEXT = "Pour éditer un bouton, sélectionner le dans la section \nd'édition, en bas de la feuille Emplacements.";
--AUTOBAR_CONFIG_SLOTVIEWTEXT = "Vue des sets combin\195\169s (non \195\169ditable)";
--AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Shift+Clique explore la cat\195\169gorie)";
--AUTOBAR_CONFIG_DRAGHANDLE = "Bouton gauche maintenu pour d\195\169placer AutoBar\nClique gauche pour v\195\169rouiller/d\195\169v\195\169rouiller\nClique droit pour les options";
--AUTOBAR_CONFIG_EMPTYSLOT = "RAZ";
--AUTOBAR_CONFIG_CLEARSLOT = "Bouton vide";
--AUTOBAR_CONFIG_SETSHARED = "Partager le profile:";
--AUTOBAR_CONFIG_SETSHAREDTIP = "S\195\169lectionner le profile partag\195\169 \195\160 utiliser pour ce personnage.\nLes modifications apport\195\169es \195\160 un profile partag\195\169 touchent tous les personnage l'utilisant";
--
--AUTOBAR_CONFIG_TAB_SLOTS = "Emplacements";
--AUTOBAR_CONFIG_TAB_BAR = "Barre";
--AUTOBAR_CONFIG_TAB_POPUP = "D\195\169ploiement";
--AUTOBAR_CONFIG_TAB_PROFILE = "Profile";
--AUTOBAR_CONFIG_TAB_KEYS = "Keys";
--
--AUTOBAR_TOOLTIP1 = " (Qauntit\195\169 : ";
--AUTOBAR_TOOLTIP2 = " [Objet personnalis\195\169]";
--AUTOBAR_TOOLTIP6 = " [Utilisation limit\195\169]";
--AUTOBAR_TOOLTIP7 = " [Cooldown]";
AUTOBAR_TOOLTIP8 = "\n(Clique gauche pour application sur l'arme main droite\nClique droit pour application sur l'arme main gauche)";
--
--AUTOBAR_CONFIG_USECHARACTERTIP = "Les objets de ce set de personnage sont spécifique à ce personnage.";
--AUTOBAR_CONFIG_USESHAREDTIP = "Les objets d'un set partag\195\169 sont partag\195\169s par les personnages utilisant le m\195\170me set partag\195\169.\nLe set sp\195\169cifique peut \195\170tre d\195\169sign\195\169 dans l'onglet Profile.";
--AUTOBAR_CONFIG_USECLASSTIP = "Les objets d'un set de classe sont partag\195\169s par les personnages de même classe utilisant le set de classe.";
--AUTOBAR_CONFIG_USEBASICTIP = "Les objets du set de base sont partag\195\169s par les personnages utilisant le set de base.";
--AUTOBAR_CONFIG_CHARACTERLAYOUTTIP = "Les modifications de l'organisation visuelle ne touchent que ce personnage.";
--AUTOBAR_CONFIG_SHAREDLAYOUTTIP = "Les modifications de l'organisation visuelle touchent tous les personnage utilisant le même profile partag\195\169.";
--AUTOBAR_CONFIG_TIPOVERRIDE = "Les boutons de ce set sont prioritaires sur les boutons des sets inf\195\169rieurs.\n";
--AUTOBAR_CONFIG_TIPOVERRIDDEN = "Les boutons de ce set seront cacher par les sets supérieurs.\n";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "Les modifications ne touchent que ce personnage.";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "Les modifications touchent tous les personnages.";
--AUTOBAR_CONFIG_SETUPSINGLE = "Configuration unique";
--AUTOBAR_CONFIG_SETUPSHARED = "Configuration partag\195\169e";
--AUTOBAR_CONFIG_SETUPSTANDARD = "Configuration standard";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "Remise \195\160 blanc";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "Cliquer pour obtenir une configuration de personnage unique, similaire \195\160 AutoBar classique.";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "Cliquer pour obtenir une configuration partag\195\169.\nActive les sets partag\195\169s et sp\195\169cifiques \195\160 un personnage.";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "Active l'\195\169diton et l'utilisation de tous les sets.";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "Efface l'ensemble des boutons des sets partag\195\169s et de personnages.";
--AUTOBAR_CONFIG_RESETSINGLETIP = "Cliquer pour r\195\169initialiser la configuration de personnage unique.";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "Cliquer pour r\195\169initialiser la configuration partag\195\169.\nLe set de classe est copi\195\169 vers le set de personnage.\nLe set par d\195\169faut est copi\195\169 vers le set partag\195\169.";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "Cliquer pour r\195\169initialiser la configuration standard.\nLes boutons de classe sont dans le set de classe.\nLes boutons par d\195\169faut sont dans le set de base.\nLes sets partag\195\169s et de personnages sont r\195\169initialis\195\169s.";
--
----  AutoBarConfig.lua
--AUTOBAR_TOOLTIP9 = "Bouton multi cat\195\169gorie\n";
--AUTOBAR_TOOLTIP10 = " (Objet personnalis\195\169 par ID)";
--AUTOBAR_TOOLTIP11 = "\n(ID de l'objet inconnu)";
--AUTOBAR_TOOLTIP12 = " (Objet personnalis\195\169 par nom)";
--AUTOBAR_TOOLTIP13 = "Bouton de cat\195\169gorie unique\n\n";
--AUTOBAR_TOOLTIP15 = "\nCible une arme\n(Clique gauche pour l'arme main droite\nClique droit pour l'arme main gauche)";
AUTOBAR_TOOLTIP17 = "\nHors-combat seulement.";
AUTOBAR_TOOLTIP18 = "\nCombat seulement.";
--AUTOBAR_TOOLTIP20 = "\nUtilisation limit\195\169 : "
--AUTOBAR_TOOLTIP21 = "Requi\195\168re une restauration de PV";
--AUTOBAR_TOOLTIP22 = "Requi\195\168re une restauration de mana";
--AUTOBAR_TOOLTIP23 = "Bouton pour objet unique\n\n";

end
