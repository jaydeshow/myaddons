﻿--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Courtesy of Teodred, curexx
--

if (GetLocale() == "deDE") then
	AutoBar.locale = {
	    ["AutoBar"] = "AutoBar",
	    ["CONFIG_WINDOW"] = "Einstellungen",
	    ["SLASHCMD_LONG"] = "/autobar",
	    ["SLASHCMD_SHORT"] = "/atb",
	    ["Button"] = "Feld",
	    ["EDITSLOT"] = "Bearbeiten",
	    ["VIEWSLOT"] = "Blick",
		["LOAD_ERROR"] = "|cff00ff00Error Loading AutoBarConfig. Make sure you have it and it is enabled.|r Error: ",
		["Toggle the config panel"] = "Toggle the config panel",
		["Empty"] = "Empty",

		-- Waterfall
		["Alpha"] = "Transparenz",
		["Change the alpha of the bar."] = "Die Transparenz der Leiste einstellen.",
		["Add Button"] = "Add Button",
		["Align Buttons"] = "Align Buttons";
		["Always Show"] = "Always Show";
		["Always Show %s, even if empty."] = "Always Show %s, even if empty.";
		["Announce to Party"] = "Announce to Party",
		["Announce to Raid"] = "Announce to Raid",
		["Announce to Say"] = "Announce to Say",
		["Bar Location"] = "Bar Location",
		["Bar the Button is located on"] = "Bar the Button is located on",
		["Bars"] = "Bars",
		["Battlegrounds only"] = "Nur in Schlachtfeldern";
		["Button Width"] = "Feldbreite";
		["Change the button width."] = "Change the button width.",
		["Button Height"] = "Feldh\195\182he";
		["Change the button height."] = "Change the button height.",
		["Category"] = "Category",
		["Categories"] = "Categories",
		["Categories for %s"] = "Categories for %s",
		["Clamp Bars to screen"] = "Clamp Bars to screen",
		["Clamped Bars can not be positioned off screen"] = "Clamped Bars can not be positioned off screen",
		["Collapse Buttons"] = "Collapse Buttons",
		["Collapse Buttons that have nothing in them."] = "Collapse Buttons that have nothing in them.",
		["Configuration for %s"] = "Configuration for %s",
		["Delete this Custom Button completely"] = "Delete this Custom Button completely",
		["Dialog"] = "Dialog",
		["Disable Conjure Button"] = "Disable Conjure Button",
		["Docked to"] = "Docked to";
		["Done"] = "Fertig";
		["Enabled"] = "Aktiviert",
		["Enable %s."] = "Aktiviere %s.",
		["FadeOut"] = "FadeOut",
		["Fade out the Bar when not hovering over it."] = "Fade out the Bar when not hovering over it.",
		["FadeOut Time"] = "FadeOut Time",
		["FadeOut takes this amount of time."] = "FadeOut takes this amount of time",
		["FadeOut Alpha"] = "FadeOut Alpha",
		["FadeOut stops at this Alpha level."] = "FadeOut stops at this Alpha level.",
		["FadeOut Cancels in combat"] = "FadeOut Cancels in combat",
		["FadeOut is cancelled when entering combat."] = "FadeOut is cancelled when entering combat.",
		["FadeOut Cancels on Shift"] = "FadeOut Cancels on Shift",
		["FadeOut is cancelled when holding down the Shift key."] = "FadeOut is cancelled when holding down the Shift key.",
		["FadeOut Cancels on Ctrl"] = "FadeOut Cancels on Ctrl",
		["FadeOut is cancelled when holding down the Ctrl key."] = "FadeOut is cancelled when holding down the Ctrl key.",
		["FadeOut Cancels on Alt"] = "FadeOut Cancels on Alt",
		["FadeOut is cancelled when holding down the Alt key."] = "FadeOut is cancelled when holding down the Alt key.",
		["Frame Level"] = "Frame Level",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects",
		["General"] = "General",
		["Hide"] = "Hide",
		["Hide %s"] = "Hide %s",
		["Item"] = "Item",
		["Items"] = "Items",
		["Location"] = "Position";
		["Macro Text"] = "Makronamen",
		["Show the button Macro Text"] = "Makronamen auf den Tasten anzeigen.",
		["Medium"] = "Medium",
		["Name"] = "Name",
		["New"] = "New",
		["New Macro"] = "New Macro",
		["No Popup"] = "No Popup";
		["No Popup for %s"] = "No Popup for %s";
		["Non Combat Only"] = "Nur au\195\159erhalb des Kampfes";
		["Not directly usable"] = "Nicht direkt verwendbar";
		["Number of columns for %s"] = "Number of columns for %s",
		["Dropdown UI"] = "Dropdown UI",
		["Options GUI"] = "Options GUI",
		["Skin the Buttons"] = "Skin the Buttons",
		["Order"] = "Order",
		["Change the order of %s in the Bar"] = "Change the order of %s in the Bar",
		["Padding"] = "Abstand",
		["Change the padding of the bar."] = "Den Abstand zwischen den Tasten einstellen.",
		["Popup Direction"] = "Popup Direction";
		["Refresh"] = "Refresh",
		["Refresh all the bars & buttons"] = "Refresh all the bars & buttons",
		["Remove"] = "Remove",
		["Remove this Button from the Bar"] = "Remove this Button from the Bar",
		["Reset"] = "Zur\195\188cksetzen";
		["Reset Bars"] = "Reset Bars",
		["Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged."] = "Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged.",
		["Reset the Bars to default Bar settings"] = "Reset the Bars to default Bar settings",
		["Revert"] = "Revert";
		["Right Click casts "] = "Right Click casts ",
		["Rows"] = "Zeilen";
		["Number of rows for %s"] = "Number of rows for %s",
		["RightClick SelfCast"] = "RightClick SelfCast",
		["SelfCast using Right click"] = "SelfCast using Right click",
		["Key Bindings"] = KEY_BINDINGS,
		["Assign Bindings for Buttons on your Bars."] = "Assign Bindings for Buttons on your Bars.",
		["Scale"] = "Skalierung",
		["Change the scale of the bar."] = "Die Skalierung der Leiste einstellen.",
		["Shared Layout"] = "Shared Layout",
		["Share the Bar Visual Layout"] = "Share the Bar Visual Layout",
		["Shared Buttons"] = "Shared Buttons",
		["Share the Bar Button List"] = "Share the Bar Button List",
		["Shared Position"] = "Shared Position",
		["Share the Bar Position"] = "Share the Bar Position",
		["Shift Dock Left/Right"] = "Verankern: rechts/links";
		["Shift Dock Up/Down"] = "Verankern: oben/unten";
		["Show Count Text"] = "Anzahl verbergen";
		["Show Count Text for %s"] = "Anzahl verbergen for %s";
		["Show Empty Buttons"] = "Leere Felder anzeigen";
		["Show Empty Buttons for %s"] = "Leere Felder anzeigen %s";
		["Show Extended Tooltips"] = "InfoFenster anzeigen mit Extended";
		["Show Hotkey Text"] = "Zeige die Tastenbelegungen in der Leiste.",
		["Show Hotkey Text for %s"] = "Zeige die Tastenbelegungen in der Leiste. for %s",
		["Show Tooltips"] = "InfoFenster anzeigen";
		["Show Tooltips for %s"] = "InfoFenster anzeigen fur %s";
		["Show Tooltips in Combat"] = "InfoFenster anzeigen im Kombat";
		["Shuffle"] = "Shuffle",
		["Shuffle replaces depleted items during combat with the next best item"] = "Shuffle replaces depleted items during combat with the next best item",
		["Snap Bars while moving"] = "Snap Bars while moving",
		["Sticky Frames"] = "Sticky Frames",
		["Style"] = "Design",
		["Change the style of the bar.  Requires ButtonFacade for non-Blizzard styles."] = "Das Design der Leiste einstellen.  Benugtigen ButtonFacade fur nein-Blizzard einstellen.",
		["Targeted"] = "\nZiel ausgew\195\164hlt.";
		["<Any String>"] = "<Any String>",
		["Move the Bars"] = "Move the Bars",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar.",
		["Move the Buttons"] = "Move the Buttons",
		["Drag a Button to move it, right click to configure the Button."] = "Drag a Button to move it, right click to configure the Button.",

		["{circle}"] = "{sz2}",
		["{diamond}"] = "{sz3}",
		["{skull}"] = "{sz8}",
		["{square}"] = "{square}",
		["{star}"] = "{sz1}",
		["{triangle}"] = "{sz4}",

		["TOPLEFT"] = "Top Left",
		["LEFT"] = "Left",
		["BOTTOMLEFT"] = "Bottom Left",
		["TOP"] = "Top",
		["CENTER"] = "Center",
		["BOTTOM"] = "Bottom",
		["TOPRIGHT"] = "Top Right",
		["RIGHT"] = "Right",
		["BOTTOMRIGHT"] = "Bottom Right",

		-- AutoBarFuBar
		["FuBarPlugin Config"] = "FubarPlugin-Konfiguration",
		["Configure the FuBar Plugin"] = "Konfiguriert das Fubar-Plugin.",
--		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55fDoppel-Klick|r um die Konfigurations-GUI zu öffnen.\n|cffeda55fStrg-Klick|r und die Tastensperre zu aktivieren. |cffeda55fShift-Klick|r um die Leistensperre zu aktivieren.",

		["\n|cffffffff%s:|r %s"] = "\n|cffffffff%s:|r %s",
		["Left-Click"] = "Left-Click",
		["Right-Click"] = "Right-Click",
		["Alt-Click"] = "Alt-Click",
		["Ctrl-Click"] = "Ctrl-Click",
		["Shift-Click"] = "Shift-Click",
		["Ctrl-Shift-Click"] = "Ctrl-Shift-Click",
		["ButtonFacade is required to Skin the Buttons"] = "ButtonFacade is required to Skin the Buttons",
		["Waterfall-1.0 is required to access the GUI"] = "Waterfall-1.0 wird vorrausgesetzt um das GUI öffnen zu können",

		-- Bar Names
		["AutoBarClassBarBasic"] = "Basic",
		["AutoBarClassBarExtras"] = "Extras",
		["AutoBarClassBarDruid"] = "Druid",
		["AutoBarClassBarHunter"] = "Hunter",
		["AutoBarClassBarMage"] = "Mage",
		["AutoBarClassBarPaladin"] = "Paladin",
		["AutoBarClassBarPriest"] = "Priest",
		["AutoBarClassBarRogue"] = "Rogue",
		["AutoBarClassBarShaman"] = "Shaman",
		["AutoBarClassBarWarlock"] = "Warlock",
		["AutoBarClassBarWarrior"] = "Warrior",

		-- Button Names
		["Buttons"] = "Felder";
		["AutoBarButtonHeader"] = "AutoBar Named Felder",
		["AutoBarCooldownHeader"] = "Potion & Stone Cooldown",
		["AutoBarClassBarHeader"] = "Class bar",

		["AutoBarButtonAura"] = "Aura / Aspect",
		["AutoBarButtonBandages"] = "Bandages",
		["AutoBarButtonBattleStandards"] = "Battle Standards",
		["AutoBarButtonBuff"] = "Buff",
		["AutoBarButtonBuffWeapon1"] = "Buff Weapon Main Hand",
		["AutoBarButtonBuffWeapon2"] = "Buff Weapon Off Hand",
		["AutoBarButtonCharge"] = "Charge",
		["AutoBarButtonClassBuff"] = "Class Buff",
		["AutoBarButtonClassPet"] = "Class Pet",
		["AutoBarButtonConjure"] = "Conjure",
		["AutoBarButtonCooldownDrums"] = "Cooldown: Drums",
		["AutoBarButtonCooldownPotionHealth"] = "Potion Cooldown: Health",
		["AutoBarButtonCooldownPotionMana"] = "Potion Cooldown: Mana",
		["AutoBarButtonCooldownPotionRejuvenation"] = "Potion Cooldown: Rejuvenation",
		["AutoBarButtonCooldownStoneHealth"] = "Stone Cooldown: Health",
		["AutoBarButtonCooldownStoneMana"] = "Stone Cooldown: Mana",
		["AutoBarButtonCooldownStoneRejuvenation"] = "Stone Cooldown: Rejuvenation",
		["AutoBarButtonCrafting"] = "Crafting",
		["AutoBarButtonDebuff"] = "Debuff",
		["AutoBarButtonElixirBattle"] = "Battle Elixir",
		["AutoBarButtonElixirGuardian"] = "Guardian Elixir",
		["AutoBarButtonElixirBoth"] = "Flask",
		["AutoBarButtonER"] = "ER",
		["AutoBarButtonExplosive"] = "Explosive",
		["AutoBarButtonFishing"] = "Fishing",
		["AutoBarButtonFood"] = "Food",
		["AutoBarButtonFoodBuff"] = "Food Buff",
		["AutoBarButtonFoodCombo"] = "Food Combo",
		["AutoBarButtonFoodPet"] = "Pet Food",
		["AutoBarButtonFreeAction"] = "Free Action",
		["AutoBarButtonHeal"] = "Heal",
		["AutoBarButtonSpell1"] = "Spell 1",
		["AutoBarButtonSpell2"] = "Spell 2",
		["AutoBarButtonSpell3"] = "Spell 3",
		["AutoBarButtonSpell4"] = "Spell 4",
		["AutoBarButtonHearth"] = "Hearth",
		["AutoBarButtonPickLock"] = "Pick Lock",
		["AutoBarButtonMount"] = "Mount",
		["AutoBarButtonPets"] = "Pets",
		["AutoBarButtonQuest"] = "Quest",
		["AutoBarButtonRecovery"] = "Recovery",
		["AutoBarButtonRotationDrums"] = "Rotation: Drums",
		["AutoBarButtonSpeed"] = "Speed",
		["AutoBarButtonStance"] = "Stance",
		["AutoBarButtonStealth"] = "Stealth",
		["AutoBarButtonSting"] = "Sting",
		["AutoBarButtonTotemEarth"] = "Earth Totem",
		["AutoBarButtonTotemAir"] = "Air Totem",
		["AutoBarButtonTotemFire"] = "Fire Totem",
		["AutoBarButtonTotemWater"] = "Water Totem",
		["AutoBarButtonTrack"] = "Track",
		["AutoBarButtonTrap"] = "Trap",
		["AutoBarButtonTrinket1"] = "Trinket 1",
		["AutoBarButtonTrinket2"] = "Trinket 2",
		["AutoBarButtonWarlockStones"] = "Warlock Stones",
		["AutoBarButtonWater"] = "Water",
		["AutoBarButtonWaterBuff"] = "Water Buff",

		["AutoBarButtonBear"] = "Bear",
		["AutoBarButtonBoomkinTree"] = "Tree of Life / Boomkin",
		["AutoBarButtonCat"] = "Cat",
		["AutoBarButtonTravel"] = "Travel",
		["AutoBarButtonFlight"] = "Flight",
		["AutoBarButtonNormal"] = "Normal",

		-- AutoBarClassButton.lua
		["Num Pad "] = "Num Pad ",
		["Mouse Button "] = "Mouse Button ",
		["Middle Mouse"] = KEY_BUTTON3,
		["Backspace"] = KEY_BACKSPACE,
		["Spacebar"] = KEY_SPACE,
		["Delete"] = KEY_DELETE,
		["Home"] = KEY_HOME,
		["End"] = KEY_END,
		["Insert"] = KEY_INSERT,
		["Page Up"] = KEY_PAGEUP,
		["Page Down"] = KEY_PAGEDOWN,
		["Down Arrow"] = KEY_DOWN,
		["Up Arrow"] = KEY_UP,
		["Left Arrow"] = KEY_LEFT,
		["Right Arrow"] = KEY_RIGHT,
		["|c00FF9966C|r"] = "|c00FF9966C|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["|c009966CCA|r"] = "|c009966CCA|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["NP"] = "NP",
		["M"] = "M",
		["MM"] = "MM",
		["Bs"] = "Bs",
		["Sp"] = "Sp",
		["De"] = "De",
		["Ho"] = "Ho",
		["En"] = "En",
		["Ins"] = "Ins",
		["Pu"] = "Pu",
		["Pd"] = "Pd",
		["D"] = "D",
		["U"] = "U",
		["L"] = "L",
		["R"] = "R",

		--  AutoBarConfig.lua
		["EMPTY"] = "Leer";
		["Default"] = "Standard",
		["Zoomed"] = "Vergrößerte Symbole",
		["Dreamlayout"] = "Dreamlayout",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "Deaktiviere Rechtsklick-Selbstanwendung";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Aktuelle Kategorie l\195\182schen";
		["Columns"] = "Spalten";
		["AUTOBAR_CONFIG_GAPPING"] = "Symbolabstand";
		["AUTOBAR_CONFIG_ALPHA"] = "Symboltranparenz";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Feldbreite/Feldh\195\182he gleichsetzen";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Show Category Icons";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Popup on Shift Key";
		["Rearrange Order on Use"] = "Rearrange Order on Use";
		["Rearrange Order on Use for %s"] = "Rearrange Order on Use for %s";
		["Right Click Targets Pet"] = "Right Click Targets Pet";
		["None"] = "None";
		["AUTOBAR_CONFIG_BT3BAR"] = "BarTender3 Bar";
	 	["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Verankern am Men\195\188";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Chat Frame";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Chat Frame Menu";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Action Bar";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu Buttons";
	 	["AUTOBAR_CONFIG_NOTFOUND"] = "(Nicht gefunden: Gegenstand ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " Layer (click to edit)";
		["AUTOBAR_CONFIG_CHARACTER"] = "Character";
		["Shared"] = "Shared";
		["Account"] = "Account";
		["Class"] = "Klasse";
		["AUTOBAR_CONFIG_BASIC"] = "Basic";
		["AUTOBAR_CONFIG_USECHARACTER"] = "Use Character Layer";
		["AUTOBAR_CONFIG_USESHARED"] = "Use Shared Layer";
		["AUTOBAR_CONFIG_USECLASS"] = "Use Class Layer";
		["AUTOBAR_CONFIG_USEBASIC"] = "Use Basic Layer";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "Hide Config Tooltips";
		["AUTOBAR_CONFIG_OSKIN"] = "Use oSkin";
		["Log Events"] = "Log Events";
		["Log Performance"] = "Log Performance";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "Character Layout";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "Shared Layout";
		["AUTOBAR_CONFIG_SHARED1"] = "Shared 1";
		["AUTOBAR_CONFIG_SHARED2"] = "Shared 2";
		["AUTOBAR_CONFIG_SHARED3"] = "Shared 3";
		["AUTOBAR_CONFIG_SHARED4"] = "Shared 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "Edit Character Layer";
		["AUTOBAR_CONFIG_EDITSHARED"] = "Edit Shared Layer";
		["AUTOBAR_CONFIG_EDITCLASS"] = "Edit Class Layer";
		["AUTOBAR_CONFIG_EDITBASIC"] = "Edit Basic Layer";
		["Share the config"] = "Share the config";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "Fireworks",
		["Tradeskill.Tool.Fishing.Lure"] = "Fishing Lures",
		["Tradeskill.Tool.Fishing.Gear"] = "Fishing Gear",
		["Tradeskill.Tool.Fishing.Other"] = "Fishing Stuff",
		["Tradeskill.Tool.Fishing.Tool"] = "Fishing Poles",

		["Consumable.Food.Bonus"] = "Nahrung: Alle Bonus";
		["Consumable.Food.Buff.Strength"] = "Nahrung: St\195\164rkebonus";
		["Consumable.Food.Buff.Agility"] = "Nahrung: Beweglichkeitbonus";
		["Consumable.Food.Buff.Attack Power"] = "Nahrung: Angriffskraftbonus";
		["Consumable.Food.Buff.Healing"] = "Nahrung: Heilbonus";
		["Consumable.Food.Buff.Spell Damage"] = "Nahrung: Zauberschadenbonus";
		["Consumable.Food.Buff.Stamina"] = "Nahrung: Ausdauerbonus";
		["Consumable.Food.Buff.Intellect"] = "Nahrung: Intelligenzbonus";
		["Consumable.Food.Buff.Spirit"] = "Nahrung: Willenskraftbonus";
		["Consumable.Food.Buff.Mana Regen"] = "Nahrung: Manawiederherstellungsbonus";
		["Consumable.Food.Buff.HP Regen"] = "Nahrung: Gesundheitswiederherstellungsbonus";
		["Consumable.Food.Buff.Other"] = "Nahrung: Andere";

		["Consumable.Buff.Health"] = "Buff Health";
		["Consumable.Buff.Armor"] = "Buff Armor";
		["Consumable.Buff.Regen Health"] = "Buff Regen Health";
		["Consumable.Buff.Agility"] = "Buff of Agility";
		["Consumable.Buff.Intellect"] = "Buff of Intellect";
		["Consumable.Buff.Protection"] = "Buff of Protection";
		["Consumable.Buff.Spirit"] = "Buff of Spirit";
		["Consumable.Buff.Stamina"] = "Buff of Stamina";
		["Consumable.Buff.Strength"] = "Buff of Strength";
		["Consumable.Buff.Attack Power"] = "Buff Attack Power";
		["Consumable.Buff.Attack Speed"] = "Buff Attack Speed";
		["Consumable.Buff.Dodge"] = "Buff Dodge";
		["Consumable.Buff.Resistance"] = "Buff Resistance";

		["Consumable.Buff Group.General.Self"] = "Buff: General";
		["Consumable.Buff Group.General.Target"] = "Buff: General Target";
		["Consumable.Buff Group.Caster.Self"] = "Buff: Caster";
		["Consumable.Buff Group.Caster.Target"] = "Buff: Caster Target";
		["Consumable.Buff Group.Melee.Self"] = "Buff: Melee";
		["Consumable.Buff Group.Melee.Target"] = "Buff: Melee Target";
		["Consumable.Buff.Other.Self"] = "Buff: Other";
		["Consumable.Buff.Other.Target"] = "Buff: Other Target";
		["Consumable.Buff.Chest"] = "Buff: Chest";
		["Consumable.Buff.Shield"] = "Buff: Shield";
		["Consumable.Weapon Buff"] = "Buff: Weapon";

		["Misc.Usable.BossItem"] = "Boss Items";
		["Misc.Usable.Permanent"] = "Permanently Usable Items";
		["Misc.Usable.Quest"] = "Questgegenst\195\164nde";	-- "Usable Quest Items"
		["Misc.Usable.Replenished"] = "Replenished Items";

		["Consumable.Cooldown.Potion.Health.Basic"] = "Heiltr\195\164nke";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "Heal Potions: Blades Edge";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "Heal Potions: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Health.PvP"] = "Schlachtfeld-Heiltr\195\164nke";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "Heal Potions: Tempest Keep";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "Manatr\195\164nke";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "Mana Potions: Blades Edge";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "Mana Potions: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "Schlachtfeld Mana Tr\195\164nke";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "Mana Potions: Tempest Keep";

		["Consumable.Weapon Buff.Poison.Crippling"] = "Verkr\195\188ppelndes Gift";
		["Consumable.Weapon Buff.Poison.Deadly"] = "T\195\182dliches Gift";
		["Consumable.Weapon Buff.Poison.Instant"] = "Sofortwirkendes Gift";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "Gedankenbenebelndes Gift";
		["Consumable.Weapon Buff.Poison.Wound"] = "Verwundendes Gift";
		["Consumable.Weapon Buff.Oil.Mana"] = "Zauber\195\182le: Mana Regeneration";
		["Consumable.Weapon Buff.Oil.Wizard"] = "Zauber\195\182le: Schaden/Heilung";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "Hergestellte Wetzsteine";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "Hergestellte Gewichtssteine";

		["Consumable.Bandage.Basic"] = "Verb\195\164nde";
		["Consumable.Bandage.Battleground.Alterac Valley"] = "Alterac Verb\195\164nde";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "Warsong Verb\195\164nde";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "Arathi Verb\195\164nde";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "Nahrung: kein Bonus";
		["Consumable.Food.Percent.Basic"] = "Food: % health gain";
		["Consumable.Food.Percent.Bonus"] = "Food: % HP Regen (well fed buff)";
		["Consumable.Food.Edible.Combo.Non-Conjured"] = "Food: combo health & mana gain, non-conjured";
		["Consumable.Food.Edible.Combo.Conjured"] = "Food: combo health & mana gain, conjured";
		["Consumable.Food.Combo Percent"] = "Food: % health & mana gain";
		["Consumable.Food.Combo Health"] = "Wasser & Nahrungskombination";
		["Consumable.Food.Edible.Bread.Conjured"] = "Nahrung: herbeigezaubert";
		["Consumable.Food.Conjure"] = "Conjure Food";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "Nahrung: Arathibecken";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "Nahrung: Warsongschlucht";

		["Consumable.Food.Pet.Bread"] = "Nahrung: Begleiter Brot";
		["Consumable.Food.Pet.Cheese"] = "Nahrung: Begleiter K\195\164se";
		["Consumable.Food.Pet.Fish"] = "Nahrung: Begleiter Fisch";
		["Consumable.Food.Pet.Fruit"] = "Nahrung: Begleiter Fr\195\188chte";
		["Consumable.Food.Pet.Fungus"] = "Nahrung: Begleiter Pilze";
		["Consumable.Food.Pet.Meat"] = "Nahrung: Begleiter Fleisch";

		["Consumable.Buff Pet"] = "Buff: Begleiter";

		["Custom"] = "Benutzerdefiniert";
		["Misc.Minipet.Normal"] = "Pet";
		["Misc.Minipet.Snowball"] = "Holiday Pet";
		["AUTOBAR_CLASS_UNGORORESTORE"] = "Un'Goro: Kristallflicker";

		["Consumable.Anti-Venom"] = "Gegengift";

		["Consumable.Warlock.Firestone"] = "Firestone";
		["Consumable.Warlock.Soulstone"] = "Soulstone";
		["Consumable.Warlock.Spellstone"] = "Spellstone";
		["Consumable.Cooldown.Stone.Health.Warlock"] = "Gesundheitssteine";
		["Spell.Warlock.Create Firestone"] = "Create Firestone";
		["Spell.Warlock.Create Healthstone"] = "Create Healthstone";
		["Spell.Warlock.Create Soulstone"] = "Create Soulstone";
		["Spell.Warlock.Create Spellstone"] = "Create Spellstone";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "Manasteine";
		["Spell.Mage.Conjure Mana Stone"] = "Manasteine herbeizaubern";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "Traumloser Schlaf";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "Verj\195\188ngungstr\195\164nke";
		["Consumable.Cooldown.Stone.Health.Statue"] = "Stone Statues";
		["Consumable.Cooldown.Drums"] = "Cooldown: Drums";
		["Consumable.Cooldown.Potion"] = "Cooldown: Potion";
		["Consumable.Cooldown.Stone"] = "Cooldown: Stone";
		["Consumable.Leatherworking.Drums"] = "Drums";
		["Consumable.Tailor.Net"] = "Nets";

		["Misc.Battle Standard.Battleground"] = "Schlachtstandarte";
		["Misc.Battle Standard.Alterac Valley"] = "Schlachtstandarte Alteractal";
		["Consumable.Cooldown.Stone.Health.Other"] = "Heal Items: Other";
		["Consumable.Cooldown.Stone.Mana.Other"] = "D\195\164monische und Dunkle Runen";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "Arkanschutz";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "Feuerschutz";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "Frostschutz";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "Naturschutz";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "Schattenschutz";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "Zauberschutz";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "Heiligschutz";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "Unverwundbarkeitstr\195\164nke";
		["Consumable.Buff.Free Action"] = "Bewegungsbefreiende Tr\195\164nke";

		["Misc.Lockboxes"] = LOCKED;
		["Gear.Trinket"] = INVTYPE_TRINKET;

		["Spell.Aura"] = "Aura / Aspect";
		["Spell.Buff.Weapon"] = "Buff Spells: Weapon";
		["Spell.Class.Buff"] = "Class Buff";
		["Spell.Class.Pet"] = "Class Pet";
		["Spell.Crafting"] = "Crafting";
		["Spell.Debuff.Multiple"] = "Debuff: Multiple";
		["Spell.Debuff.Single"] = "Debuff: Single";
		["Spell.Fishing"] = "Fishing";
		["Spell.Portals"] = "Portale und Teleportartionen";
		["Spell.Sting"] = "Sting";
		["Spell.Stance"] = "Stance";
		["Spell.Totem.Earth"] = "Earth Totem";
		["Spell.Totem.Air"] = "Air Totem";
		["Spell.Totem.Fire"] = "Fire Totem";
		["Spell.Totem.Water"] = "Water Totem";
		["Spell.Seal"] = "Seal";
		["Spell.Track"] = "Track";
		["Spell.Trap"] = "Trap";
		["Misc.Hearth"] = "Ruhestein";
		["Misc.Booze"] = "Alkoholische Getr?nke";
		["Consumable.Water.Basic"] = "Wasser";
		["Consumable.Water.Percentage"] = "Water: % mana gain";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "Wasser: herbeigezaubert";
		["Consumable.Water.Conjure"] = "Conjure Water";
		["Consumable.Water.Buff.Spirit"] = "Wasser: Willenskraftbonus";
		["Consumable.Water.Buff"] = "Wasser: Bonus";
		["Consumable.Buff.Rage"] = "Wuttr\195\164nke";
		["Consumable.Buff.Energy"] = "Energietr\195\164nke";
		["Consumable.Buff.Speed"] = "Beweglichkeits Tr\195\164nke";
		["Consumable.Buff Type.Battle"] = "Buff: Battle Elixir";
		["Consumable.Buff Type.Guardian"] = "Buff: Guardian Elixir";
		["Consumable.Buff Type.Flask"] = "Buff: Flask";
		["AUTOBAR_CLASS_SOULSHARDS"] = "Seelensteine";
		["Misc.Reagent.Ammo.Arrow"] = "Pfeile";
		["Misc.Reagent.Ammo.Bullet"] = "Patronen";
		["Misc.Reagent.Ammo.Thrown"] = "Wurfwaffen";
		["Misc.Explosives"] = "Sprengstoffe";
		["Misc.Mount.Normal"] = "Reittier";
		["Misc.Mount.Summoned"] = "Reittier： Summoned";
		["Misc.Mount.Ahn'Qiraj"] = "Reittier: Qiraji";
		["Misc.Mount.Flying"] = "Reittier: Fliegend";
	}

--AUTOBAR_CHAT_MESSAGE1 = "Veraltete Einstellungen wurden gefunden und gel\195\182scht. Standardeinstellungen werden wieder hergestellt.";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_TAB_BAR = "Balken";
--AUTOBAR_CONFIG_TAB_POPUP = "Popup";
--AUTOBAR_CONFIG_TAB_PROFILE = "Profil";
--AUTOBAR_CONFIG_TAB_KEYS = "Keys";
--
--AUTOBAR_TOOLTIP1 = " (Anzahl: ";
--AUTOBAR_TOOLTIP2 = " [Benutzerdefiniertes Objekt]";
--AUTOBAR_TOOLTIP6 = " [Begrenzte Verwendung]";
--AUTOBAR_TOOLTIP7 = " [Abklingzeit]";
AUTOBAR_TOOLTIP8 = "\n(Links-Klick f\195\188r Waffenhand.\nRechts-Klick f\195\188r Schildhand)";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "Changes affect only this Character.";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "Changes affect all Characters.";
--AUTOBAR_CONFIG_SETUPSINGLE = "Single Setup";
--AUTOBAR_CONFIG_SETUPSHARED = "Shared Setup";
--AUTOBAR_CONFIG_SETUPSTANDARD = "Standard Setup";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "Blank Slate";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "Click for Single Character settings similar to the classic AutoBar.";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "Click for shared settings.\nEnables the character specific as well as shared layers.";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "Enable editing and use of all layers.";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "Clear out all character and shared slots.";
--AUTOBAR_CONFIG_RESETSINGLETIP = "Click to reset to the Single Character defaults.";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "Click to reset to the Shared Character defaults.\nClass specific slots are copied to the Character layer.\nDefault slots are copied to the Shared layer.";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "Click to reset to the standard defaults.\nClass specific slots are in the Class layer.\nDefault slots are in the Basic layer.\nShared and Character layers are cleared.";
--
----  AutoBar_Config.lua
--AUTOBAR_TOOLTIP9 = "Mehrfachfeld\n";
--AUTOBAR_TOOLTIP10 = " (Benutzerdefinifierter Gegenstand aus ItemID)";
--AUTOBAR_TOOLTIP11 = "\n(ItemID nicht erkannt)";
--AUTOBAR_TOOLTIP12 = " (Benutzerdefinierter Gegenstand aus Name)";
--AUTOBAR_TOOLTIP13 = "Einzelfeld\n\n";
--AUTOBAR_TOOLTIP15 = "\nWaffenziel\n(Links-Klick f\195\188r Waffenhand.\nRechts-Klick f\195\188r Schildhand)";
AUTOBAR_TOOLTIP17 = "\nNur au\195\159erhalb Kampf.";
AUTOBAR_TOOLTIP18 = "\nNur in Kampf.";
--AUTOBAR_TOOLTIP20 = "\nBegrenzte Verwendung: "
--AUTOBAR_TOOLTIP21 = "Verwendung bei fehlender Gesundheit";
--AUTOBAR_TOOLTIP22 = "Verwendung bei fehlendem Mana";

end