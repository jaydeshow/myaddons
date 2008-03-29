--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Courtesy of Teodred, curexx
--

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")

L:RegisterTranslations("deDE", function() return {
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
	["Padding"] = "Abstand",
	["Change the padding of the bar."] = "Den Abstand zwischen den Tasten einstellen.",
	["Scale"] = "Skalierung",
	["Change the scale of the bar."] = "Die Skalierung der Leiste einstellen.",
	["Alpha"] = "Transparenz",
	["Change the alpha of the bar."] = "Die Transparenz der Leiste einstellen.",
	["Style"] = "Design",
	["Change the style of the bar."] = "Das Design der Leiste einstellen.",
	["Enabled"] = "Aktiviert",
	["Enable %s."] = "Aktiviere %s.",
	["Macro Text"] = "Makronamen",
	["Show the button Macro Text"] = "Makronamen auf den Tasten anzeigen.",
	["Show Hotkey Text"] = "Zeige die Tastenbelegungen in der Leiste.",
	["Show Hotkey Text for %s"] = "Zeige die Tastenbelegungen in der Leiste. for %s",
	["Show Grid"] = "Zeige Raster",
	["Show the grid of the bar even while locked."] = "Zeige das Raster der Leiste, auch wenn sie gesperrt ist.",
		["Align Buttons"] = "Align Buttons";
		["Always Show"] = "Always Show";
		["Always Show %s, even if empty."] = "Always Show %s, even if empty.";
		["Reset"] = "Zur\195\188cksetzen";
		["Buttons"] = "Felder";
		["Battlegrounds only"] = "Nur in Schlachtfeldern";
		["Non Combat Only"] = "Nur au\195\159erhalb des Kampfes";
		["Docked to"] = "Docked to";
		["Not directly usable"] = "Nicht direkt verwendbar";
		["Show Count Text"] = "Anzahl verbergen";
		["Show Count Text for %s"] = "Anzahl verbergen for %s";
		["Show Empty Buttons"] = "Leere Felder anzeigen";
		["Show Empty Buttons for %s"] = "Leere Felder anzeigen %s";
		["Targeted"] = "\nZiel ausgew\195\164hlt.";
		["Location"] = "Position: ";

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
		["Button lock"] = "Tasten sperren",
		["Bar lock"] = "Leisten sperren",
		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55fDoppel-Klick|r um die Konfigurations-GUI zu öffnen.\n|cffeda55fStrg-Klick|r und die Tastensperre zu aktivieren. |cffeda55fShift-Klick|r um die Leistensperre zu aktivieren.",
		["Waterfall-1.0 is required to access the GUI."] = "Waterfall-1.0 wird vorrausgesetzt um das GUI öffnen zu können.",

		-- Bar Names
		["AutoBarClassBarBasic"] = "Basic",
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
		["Buttons"] = "Buttons",
		["AutoBarButtonHeader"] = "AutoBar Named Buttons",
		["AutoBarCooldownHeader"] = "Potion & Stone Cooldown",

		["AutoBarButtonAura"] = "Aura / Aspect",
		["AutoBarButtonBandages"] = "Bandages",
		["AutoBarButtonBattleStandards"] = "Battle Standards",
		["AutoBarButtonBuff"] = "Buff",
		["AutoBarButtonBuffWeapon1"] = "Buff Weapon Main Hand",
		["AutoBarButtonBuffWeapon2"] = "Buff Weapon Off Hand",
		["AutoBarButtonClassBuff"] = "Class Buff",
		["AutoBarButtonClassPet"] = "Class Pet",
		["AutoBarButtonConjure"] = "Conjure",
		["AutoBarButtonCooldownPotionHealth"] = "Potion Cooldown: Health",
		["AutoBarButtonCooldownPotionMana"] = "Potion Cooldown: Mana",
		["AutoBarButtonCooldownPotionRejuvenation"] = "Potion Cooldown: Rejuvenation",
		["AutoBarButtonCooldownStoneHealth"] = "Stone Cooldown: Health",
		["AutoBarButtonCooldownStoneMana"] = "Stone Cooldown: Mana",
		["AutoBarButtonCooldownStoneRejuvenation"] = "Stone Cooldown: Rejuvenation",
		["AutoBarButtonCrafting"] = "Crafting",
		["AutoBarButtonElixirBattle"] = "Battle Elixir",
		["AutoBarButtonElixirGuardian"] = "Guardian Elixir",
		["AutoBarButtonElixirBoth"] = "Battle and Guardian Elixir",
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
		["Middle Mouse"] = "Middle Mouse",
		["Backspace"] = "Backspace",
		["Spacebar"] = "Spacebar",
		["Delete"] = "Delete",
		["Home"] = "Home",
		["End"] = "End",
		["Insert"] = "Insert",
		["Page Up"] = "Page Up",
		["Page Down"] = "Page Down",
		["Down Arrow"] = "Down Arrow",
		["Up Arrow"] = "Up Arrow",
		["Left Arrow"] = "Left Arrow",
		["Right Arrow"] = "Right Arrow",
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
		["Rows"] = "Zeilen";
		["Columns"] = "Spalten";
		["AUTOBAR_CONFIG_GAPPING"] = "Symbolabstand";
		["AUTOBAR_CONFIG_ALPHA"] = "Symboltranparenz";
		["Button Width"] = "Feldbreite";
		["Button Height"] = "Feldh\195\182he";
		["Shift Dock Left/Right"] = "Verankern: rechts/links";
		["Shift Dock Up/Down"] = "Verankern: oben/unten";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Feldbreite/Feldh\195\182he gleichsetzen";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Show Category Icons";
		["Show Tooltips"] = "InfoFenster anzeigen";
		["Show Tooltips for %s"] = "InfoFenster anzeigen for %s";
		["Popup Direction"] = "Popup Direction";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Popup on Shift Key";
		["No Popup"] = "No Popup";
		["No Popup for %s"] = "No Popup for %s";
		["Rearrange Order on Use"] = "Rearrange Order on Use";
		["Rearrange Order on Use for %s"] = "Rearrange Order on Use for %s";
		["Right Click Targets Pet"] = "Right Click Targets Pet";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "None";
		["AUTOBAR_CONFIG_BT3BAR"] = "BarTender3 Bar";
	 	["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Verankern am Men\195\188";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Chat Frame";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Chat Frame Menu";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Action Bar";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu Buttons";
	 	["AUTOBAR_CONFIG_NOTFOUND"] = "(Nicht gefunden: Gegenstand ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " Layer (click to edit)";
		["AUTOBAR_CONFIG_CHARACTER"] = "Character";
		["AUTOBAR_CONFIG_SHARED"] = "Shared";
		["AUTOBAR_CONFIG_CLASS"] = "Class";
		["AUTOBAR_CONFIG_BASIC"] = "Basic";
		["AUTOBAR_CONFIG_USECHARACTER"] = "Use Character Layer";
		["AUTOBAR_CONFIG_USESHARED"] = "Use Shared Layer";
		["AUTOBAR_CONFIG_USECLASS"] = "Use Class Layer";
		["AUTOBAR_CONFIG_USEBASIC"] = "Use Basic Layer";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "Hide Config Tooltips";
		["AUTOBAR_CONFIG_OSKIN"] = "Use oSkin";
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

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "Fireworks",
		["Tradeskill.Tool.Fishing.Lure"] = "Fishing Lures",
		["Tradeskill.Tool.Fishing.Gear"] = "Fishing Gear",
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

		["Consumable.Cooldown.Stone.Health.Warlock"] = "Gesundheitssteine";
		["Spell.Warlock.Create Firestone"] = "Create Firestone";
		["Spell.Warlock.Create Healthstone"] = "Create Healthstone";
		["Spell.Warlock.Create Soulstone"] = "Create Soulstone";
		["Spell.Warlock.Create Spellstone"] = "Create Spellstone";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "Manasteine";
		["Consumable.Mage.Conjure Mana Stone"] = "Manasteine herbeizaubern";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "Traumloser Schlaf";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "Verj\195\188ngungstr\195\164nke";
		["Consumable.Cooldown.Stone.Health.Statue"] = "Stone Statues";
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
		["Spell.Fishing"] = "Fishing";
		["Spell.Portals"] = "Portale und Teleportartionen";
		["Spell.Sting"] = "Sting";
		["Spell.Stance"] = "Stance";
		["Spell.Totem.Earth"] = "Earth Totem";
		["Spell.Totem.Air"] = "Air Totem";
		["Spell.Totem.Fire"] = "Fire Totem";
		["Spell.Totem.Water"] = "Water Totem";
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
		["AUTOBAR_CLASS_SOULSHARDS"] = "Seelensteine";
		["Reagent.Ammo.Arrow"] = "Pfeile";
		["Reagent.Ammo.Bullet"] = "Patronen";
		["Reagent.Ammo.Thrown"] = "Wurfwaffen";
		["Misc.Explosives"] = "Sprengstoffe";
		["Misc.Mount.Normal"] = "Reittier";
		["Misc.Mount.Summoned"] = "Reittier： Summoned";
		["Misc.Mount.Ahn'Qiraj"] = "Reittier: Qiraji";
		["Misc.Mount.Flying"] = "Reittier: Fliegend";

		["Revert"] = "Revert";
		["Done"] = "Fertig";
	}
end);


if (GetLocale() == "deDE") then

--AUTOBAR_CHAT_MESSAGE1 = "Veraltete Einstellungen wurden gefunden und gel\195\182scht. Standardeinstellungen werden wieder hergestellt.";
--AUTOBAR_CHAT_MESSAGE2 = "Benutze im Mehrfachfeld #%d f\195\188r den Gegenstand #%d die zugeh\195\182rige ItemID anstelle den Namen.";
--AUTOBAR_CHAT_MESSAGE3 = "Benutze f\195\188r den Gegenstand #%d die zugeh\195\182rige ItemID anstelle den Namen.";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_VIEWTEXT = "To edit a slot select it from the Slot edit section\nat the bottom of the Slots tab.";
--AUTOBAR_CONFIG_SLOTVIEWTEXT = "Combined Layer View (not editable)";
--AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Gro\195\159schreiben+Links-Klick um Kategorien zu durchsuchen)";
--AUTOBAR_CONFIG_DRAGHANDLE = "Linke Maustaste: AutoBar verschieben\nLinksklick: AutoBar sperren / entsperren\nRechtsklick: Einstellungen";
--AUTOBAR_CONFIG_EMPTYSLOT = "Empty Slot";
--AUTOBAR_CONFIG_CLEARSLOT = "Clear Slot";
--AUTOBAR_CONFIG_SETSHARED = "Shared Profile:";
--AUTOBAR_CONFIG_SETSHAREDTIP = "Select the shared profile for this Character to use.\nChanges to a shared profile affect all Characters using it";
--
--AUTOBAR_CONFIG_TAB_SLOTS = "Schlitze";
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
--
--AUTOBAR_CONFIG_USECHARACTERTIP = "Character Layer items are specific to this Character.";
--AUTOBAR_CONFIG_USESHAREDTIP = "Shared Layer items are shared by other Characters that use the same Shared Layer.\nThe specific layer can be chosen on the Profile Tab.";
--AUTOBAR_CONFIG_USECLASSTIP = "Class Layer items are shared by all Characters of the same class that use the Class Layer.";
--AUTOBAR_CONFIG_USEBASICTIP = "Basic Layer items are shared by all Characters using the Basic Layer.";
--AUTOBAR_CONFIG_CHARACTERLAYOUTTIP = "Changes to visual layout only affect this Character.";
--AUTOBAR_CONFIG_SHAREDLAYOUTTIP = "Changes to visual layout affect all Characters using the same shared profile.";
--AUTOBAR_CONFIG_TIPOVERRIDE = "Items in a slot on this layer override items in that slot on lower layers.\n";
--AUTOBAR_CONFIG_TIPOVERRIDDEN = "Items in a slot on this layer are overidden by items on higher layers.\n";
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
--AUTOBAR_TOOLTIP23 = "Einzelfeld\n\n";

end