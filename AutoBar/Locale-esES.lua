--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Spanish translation by shiftos
--

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")

L:RegisterTranslations("esES", function() return {
		["AutoBar"] = "AutoBar",
		["CONFIG_WINDOW"] = "Ventana de Configuraci\195\179n",
		["SLASHCMD_LONG"] = "/autobar",
		["SLASHCMD_SHORT"] = "/atb",
		["Button"] = "Bot\195\179n",
		["EDITSLOT"] = "Editar Casilla",
		["VIEWSLOT"] = "Ver Casilla",
		["LOAD_ERROR"] = "|cff00ff00Error al cargar AutoBarConfig. Aseg\195\186rate de que lo tienes instalado y activado.|r Error: ",
		["Toggle the config panel"] = "Toggle the config panel",
		["Empty"] = "Empty",


		-- Waterfall
	["Padding"] = "Padding",
	["Change the padding of the bar."] = "Cambia el padding de la barra",
	["Scale"] = "Escala",
	["Change the scale of the bar."] = "Cambia la escala de la barra",
	["Alpha"] = "Transparencia",
	["Change the alpha of the bar."] = "Cambia el \195\173ndice de transparencia de la barra",
	["Style"] = "Estilo",
	["Change the style of the bar."] = "Cambia el estilo de la barra",
	["Enabled"] = "Activado",
	["Enable %s."] = "Activa %s",
	["Macro Text"] = "Texto de Macro",
	["Show the button Macro Text"] = "Muestra el texto de la macro del bot\195\179n",
	["Show Hotkey Text"] = "Muestra la Tecla r\195\161pida del bot\195\179n",
	["Show Hotkey Text for %s"] = "Muestra la Tecla r\195\161pida del bot\195\179n for %s",
	["Show Grid"] = "Mostrar Rejilla",
	["Show the grid of the bar even while locked."] = "Muestra la rejilla de la barra mientras est\195\161 bloqueada",
		["Reset"] = "Reestablecer";
		["Align Buttons"] = "Alinear Botones";
		["Always Show"] = "Always Show";
		["Always Show %s, even if empty."] = "Always Show %s, even if empty.";
		["Buttons"] = "Botones";
		["Battlegrounds only"] = "Solo Campos de Batalla";
		["Non Combat Only"] = "Solo Sin Combate";
		["Docked to"] = "Anclado a";
		["Not directly usable"] = "No usable de forma directa";
		["Show Count Text"] = "Mostrar el Texto del\nContador";
		["Show Count Text for %s"] = "Mostrar el Texto del\nContador for %s";
		["Show Empty Buttons"] = "Mostrar los Botones Vac\195\173os";
		["Show Empty Buttons for %s"] = "Mostrar los Botones Vac\195\173os %s";
		["Targeted"] = "Seleccionado.";
		["Location"] = "Lugar: ";

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
		["FuBarPlugin Config"] = "Configuraci\195\179n del Plugin de FuBar",
		["Configure the FuBar Plugin"] = "Configura el plugin de FuBar",
		["Button lock"] = "Bloqueo de Bot\195\179n",
		["Bar lock"] = "Bloqueo de Barra",
		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55fDoble-Clic|r para abrir la interfaz de configuraci\195\179n.\n|cffeda55fCtrl-Clic|r para bloquear los botones. |cffeda55fMay\195\186sculas-Clic|r para bloquear las barras.",

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
		["EMPTY"] = "Vac\195\173o";
		["Default"] = "Por defecto",
		["Zoomed"] = "Agrandado",
		["Dreamlayout"] = "Dreamlayout",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "Desactivar Autolanzado con ClicDerecho";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Eliminar la Categor\195\173a Actual";
		["Rows"] = "Filas";
		["Columns"] = "Columnas";
		["AUTOBAR_CONFIG_GAPPING"] = "Espacio entre Iconos";
		["AUTOBAR_CONFIG_ALPHA"] = "Transparencia de Iconos";
		["Button Width"] = "Anchura del Bot\195\179n";
		["Button Height"] = "Altura del Bot\195\179n";
		["Shift Dock Left/Right"] = "Mover ancla horizontalmente";
		["Shift Dock Up/Down"] = "Mover ancla verticalmente";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Altura del Bot\195\179n\ny Anchura Desbloqueados";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Mostrar Iconos de Categorias";
		["Show Tooltips"] = "Mostrar los Tooltips";
		["Show Tooltips for %s"] = "Mostrar los Tooltips for %s";
		["Popup Direction"] = "Direcci\195\179n de la ventana emergente de los botones";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Ventana emergente con tecla de\nMay\195\186sculas";
		["No Popup"] = "Sin Ventana Emergente";
		["No Popup for %s"] = "Sin Ventana Emergente %s";
		["Rearrange Order on Use"] = "Reajustar el orden al usar";
		["Rearrange Order on Use for %s"] = "Reajustar el orden al usar for %s";
		["Right Click Targets Pet"] = "Clic-Derecho cambia objetivo a la Mascota";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "Ninguno";
		["AUTOBAR_CONFIG_BT3BAR"] = "Barra de BarTender3 ";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Men\195\186 Principal";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Ventana de Chat";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Men\195\186 de la Ventana de Chat";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Barra de Acci\195\179n";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Men\195\186 de Botones";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(No encontrado: Objeto ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " Capa (clic para editar)";
		["AUTOBAR_CONFIG_CHARACTER"] = "Personaje";
		["AUTOBAR_CONFIG_SHARED"] = "Compartido";
		["AUTOBAR_CONFIG_CLASS"] = "Clase";
		["AUTOBAR_CONFIG_BASIC"] = "B\195\161sico";
		["AUTOBAR_CONFIG_USECHARACTER"] = "Usar la capa de Personaje";
		["AUTOBAR_CONFIG_USESHARED"] = "Usar la capa Compartida";
		["AUTOBAR_CONFIG_USECLASS"] = "Usar la capa de Clase";
		["AUTOBAR_CONFIG_USEBASIC"] = "Usar la capa B\195\161sica";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "Ocultar los Tooltips de\nConfiguraci\195\179n";
		["AUTOBAR_CONFIG_OSKIN"] = "Usar oSkin";
		["Log Performance"] = "Log Performance";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "Distribuci\195\179n de Personaje";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "Distribuci\195\179n de Compartido";
		["AUTOBAR_CONFIG_SHARED1"] = "Compartido 1";
		["AUTOBAR_CONFIG_SHARED2"] = "Compartido 2";
		["AUTOBAR_CONFIG_SHARED3"] = "Compartido 3";
		["AUTOBAR_CONFIG_SHARED4"] = "Compartido 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "Editar la capa de\nPersonaje";
		["AUTOBAR_CONFIG_EDITSHARED"] = "Editar la capa\nCompartida";
		["AUTOBAR_CONFIG_EDITCLASS"] = "Editar la capa de Clase";
		["AUTOBAR_CONFIG_EDITBASIC"] = "Editar la capa B\195\161sica";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "Fuegos artificiales",
		["Tradeskill.Tool.Fishing.Lure"] = "Cebos de Pesca",
		["Tradeskill.Tool.Fishing.Gear"] = "Equipo de Pesca",
		["Tradeskill.Tool.Fishing.Tool"] = "Ca\195\177as de Pescar",

		["Consumable.Food.Bonus"] = "Comida: Bonificaci\195\179n";
		["Consumable.Food.Buff.Strength"] = "Comida: Bonificaci\195\179n de Fuerza";
		["Consumable.Food.Buff.Agility"] = "Comida: Bonificaci\195\179n de Agilidad";
		["Consumable.Food.Buff.Attack Power"] = "Food: Attack Power Bonus";
		["Consumable.Food.Buff.Healing"] = "Food: Healing Bonus";
		["Consumable.Food.Buff.Spell Damage"] = "Food: Spell Damage Bonus";
		["Consumable.Food.Buff.Stamina"] = "Comida: Bonificaci\195\179n de Aguante";
		["Consumable.Food.Buff.Intellect"] = "Comida: Bonificaci\195\179n de Inteligencia";
		["Consumable.Food.Buff.Spirit"] = "Comida: Bonificaci\195\179n de Esp\195\173ritu";
		["Consumable.Food.Buff.Mana Regen"] = "Comida: Bonificaci\195\179n de Regeneraci\195\179n de Man\195\161";
		["Consumable.Food.Buff.HP Regen"] = "Comida: Bonificaci\195\179n de Regeneraci\195\179n de Salud";
		["Consumable.Food.Buff.Other"] = "Comida: Otros";

		["Consumable.Buff.Health"] = "Buff de Health";
		["Consumable.Buff.Armor"] = "Buff de Armor";
		["Consumable.Buff.Regen Health"] = "Buff de Regen Health";
		["Consumable.Buff.Agility"] = "Buff de Agility";
		["Consumable.Buff.Intellect"] = "Buff de Intellect";
		["Consumable.Buff.Protection"] = "Buff de Protection";
		["Consumable.Buff.Spirit"] = "Buff de Spirit";
		["Consumable.Buff.Stamina"] = "Buff de Stamina";
		["Consumable.Buff.Strength"] = "Buff de Strength";
		["Consumable.Buff.Attack Power"] = "Buff de Potencia de Ataque";
		["Consumable.Buff.Attack Speed"] = "Buff de Velocidad de Ataque";
		["Consumable.Buff.Dodge"] = "Buff de Esquiva";
		["Consumable.Buff.Resistance"] = "Buff de Resistance";

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
		["Misc.Usable.Quest"] = "Objetos de Misi\195\179n";	-- "Usable Quest Items"
		["Misc.Usable.Replenished"] = "Replenished Items";

		["Consumable.Cooldown.Potion.Health.Basic"] = "Pociones de Curaci\195\179n";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "Heal Potions: Blades Edge";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "Heal Potions: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Health.PvP"] = "Pociones de Salud de Campos de Batalla";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "Heal Potions: Tempest Keep";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "Pociones de Man\195\161";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "Mana Potions: Blades Edge";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "Mana Potions: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "Pociones de Campos de Batalla";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "Mana Potions: Tempest Keep";

		["Consumable.Weapon Buff.Poison.Crippling"] = "Veneno de Ralentizaci\195\179n";  -- check
		["Consumable.Weapon Buff.Poison.Deadly"] = "Veneno Mortal";
		["Consumable.Weapon Buff.Poison.Instant"] = "Veneno Instant\195\161neo";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "Veneno de entumecimiento mental";   -- check
		["Consumable.Weapon Buff.Poison.Wound"] = "Veneno Hiriente";                  -- check
		["Consumable.Weapon Buff.Oil.Mana"] = "Aceite de encantamiento: Regeneraci\195\179n de Man\195\161";
		["Consumable.Weapon Buff.Oil.Wizard"] = "Aceite de encantamiento: Bonificaci\195\179n a Da\195\177o/Curaci\195\179n";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "Piedras de afilar creadas por Herrero";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "Piedras de peso creadas por Herrero";

		["Consumable.Bandage.Basic"] = "Vendas";
		["Consumable.Bandage.Battleground.Alterac Valley"] = "Vendas de Alterac";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "Vendas de Grito de Guerra";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "Vendas de Arathi";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "Comida: Sin Bonificaci\195\179n";
		["Consumable.Food.Percent.Basic"] = "Comida: % aumento de salud";
		["Consumable.Food.Percent.Bonus"] = "Comida: % Regeneraci\195\179n de Salud (buff de bien alimentado)";
		["Consumable.Food.Combo Percent"] = "Comida: % aumento de salud y man\195\161";
		["Consumable.Food.Combo Health"] = "Combinaci\195\179n de Comida y Agua";
		["Consumable.Food.Edible.Bread.Conjured"] = "Comida: Conjurada por Mago";
		["Consumable.Food.Conjure"] = "Conjure Food";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "Comida: Cuenca de Arathi";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "Comida: Garganta Grito de Guerra";

		["Consumable.Food.Pet.Bread"] = "Comida: Pan para Mascota";
		["Consumable.Food.Pet.Cheese"] = "Comida: Queso para Mascota";
		["Consumable.Food.Pet.Fish"] = "Comida: Pescado para Mascota";
		["Consumable.Food.Pet.Fruit"] = "Comida: Fruta para Mascota";
		["Consumable.Food.Pet.Fungus"] = "Comida: Hongo para Mascota";
		["Consumable.Food.Pet.Meat"] = "Comida: Carne para Mascota";

		["Consumable.Buff Pet"] = "Buff: Mascota";

		["Custom"] = "Personalizado";
		["Misc.Minipet.Normal"] = "Mascota";
		["Misc.Minipet.Snowball"] = "Mascota de Festividad";
		["AUTOBAR_CLASS_UNGORORESTORE"] = "Un'Goro: Cristal de Recuperaci\195\179n";

		["Consumable.Anti-Venom"] = "Anti-Veneno";

		["Consumable.Cooldown.Stone.Health.Warlock"] = "Piedras de Salud";
		["Spell.Warlock.Create Firestone"] = "Create Firestone";
		["Spell.Warlock.Create Healthstone"] = "Create Healthstone";
		["Spell.Warlock.Create Soulstone"] = "Create Soulstone";
		["Spell.Warlock.Create Spellstone"] = "Create Spellstone";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "Piedras de Man\195\161";
		["Consumable.Mage.Conjure Mana Stone"] = "Conjure Manastones";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "Poci\195\179n de letargo sin sueños";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "Pociones de Rejuvenecimiento";
		["Consumable.Cooldown.Stone.Health.Statue"] = "Est\195\161tuas de piedra";
		["Consumable.Leatherworking.Drums"] = "Drums";
		["Consumable.Tailor.Net"] = "Nets";

		["Misc.Battle Standard.Battleground"] = "Estandarte de Batalla";
		["Misc.Battle Standard.Alterac Valley"] = "Estandarte de Batalla VdA";
		["Consumable.Cooldown.Stone.Health.Other"] = "Heal Items: Other";
		["Consumable.Cooldown.Stone.Mana.Other"] = "Runas Oscuras y Demon\195\173acas";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "Protecci\195\179n contra arcano";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "Protecci\195\179n contra Fuego";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "Protecci\195\179n contra Escarcha";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "Protecci\195\179n contra Naturaleza";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "Protecci\195\179n contra Sombra";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "Protecci\195\179n contra Hechizo";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "Protecci\195\179n contra Sagrado";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "Pociones de Invulnerabilidad";
		["Consumable.Buff.Free Action"] = "Poci\195\179n de Acci\195\179n Libre";

		["Misc.Lockboxes"] = LOCKED;
		["Gear.Trinket"] = INVTYPE_TRINKET;

		["Spell.Aura"] = "Aura / Aspect";
		["Spell.Buff.Weapon"] = "Buff Spells: Weapon";
		["Spell.Class.Buff"] = "Class Buff";
		["Spell.Class.Pet"] = "Class Pet";
		["Spell.Crafting"] = "Crafting";
		["Spell.Fishing"] = "Fishing";
		["Spell.Portals"] = "Portals and Teleports";
		["Spell.Sting"] = "Sting";
		["Spell.Stance"] = "Stance";
		["Spell.Totem.Earth"] = "Earth Totem";
		["Spell.Totem.Air"] = "Air Totem";
		["Spell.Totem.Fire"] = "Fire Totem";
		["Spell.Totem.Water"] = "Water Totem";
		["Spell.Track"] = "Track";
		["Spell.Trap"] = "Trap";
		["Misc.Hearth"] = "Piedra de hogar";
		["Misc.Booze"] = "Alcohol";
		["Consumable.Water.Basic"] = "Agua";
		["Consumable.Water.Percentage"] = "Agua: % aumento de man\195\161";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "Agua: Conjurada por Mago";
		["Consumable.Water.Conjure"] = "Conjure Water";
		["Consumable.Water.Buff.Spirit"] = "Agua: Bonificaci\195\179n de Esp\195\173ritu";
		["Consumable.Water.Buff"] = "Agua: Bonificaci\195\179n";
		["Consumable.Buff.Rage"] = "Pociones de Rabia";
		["Consumable.Buff.Energy"] = "Pociones de Energ\195\173a";
		["Consumable.Buff.Speed"] = "Pociones de Velocidad";
		["AUTOBAR_CLASS_SOULSHARDS"] = "Fragmentos de Alma";
		["Reagent.Ammo.Arrow"] = "Flechas";
		["Reagent.Ammo.Bullet"] = "Balas";
		["Reagent.Ammo.Thrown"] = "Armas Arrojadizas";
		["Misc.Explosives"] = "Explosivos";
		["Misc.Mount.Normal"] = "Monturas";
		["Misc.Mount.Summoned"] = "Monturas: Summoned";
		["Misc.Mount.Ahn'Qiraj"] = "Monturas: Qiraji";
		["Misc.Mount.Flying"] = "Monturas: Flying";

		["Revert"] = "Revertir";
		["Done"] = "Hecho";
	}
end);


if (GetLocale() == "esES") then

--AUTOBAR_CHAT_MESSAGE1 = "La configuraci\195\179n para este personaje es de una versi\195\179n anterior. Borrando. No se intentar\195\161 actualizar la configuraci\195\179n actual.";
--AUTOBAR_CHAT_MESSAGE2 = "Actualizando el bot\195\179n de multi-objetos #%d objeto #%d para usar el itemid en vez del nombre del objeto.";
--AUTOBAR_CHAT_MESSAGE3 = "Actualizando el bot\195\179n de objeto \195\186nico #%d para usar el itemid en vez del nombre del objeto.";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_VIEWTEXT = "Para editar una casilla selecci\195\179nala en la secci\195\179n Edici\195\179n de casillas\nen la parte baja de la pesta\195\177a de Casillas";
--AUTOBAR_CONFIG_SLOTVIEWTEXT = "Vista de Capa Combinada (no editable) ";
--AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Clic+May\195\186sculas para explorar la Categor\195\173a)";
--AUTOBAR_CONFIG_DRAGHANDLE = "Clic-Izquierdo+Arrastrar para mover AutoBar\nClic-izquierdo para Bloquearlo / Desbloquearlo\nClic-Derecho para las opciones";
--AUTOBAR_CONFIG_EMPTYSLOT = "Casilla Vac\195\173a";
--AUTOBAR_CONFIG_CLEARSLOT = "Limpiar Casilla";
--AUTOBAR_CONFIG_SETSHARED = "Perfil Compartido:";
--AUTOBAR_CONFIG_SETSHAREDTIP = "Elige el perfil compartido que usar\195\161 este personaje.\nLos cambios a un perfil compartido afectar\195\161n a todos los personajes que lo usen";
--
--AUTOBAR_CONFIG_TAB_SLOTS = "Casillas";
--AUTOBAR_CONFIG_TAB_BAR = "Barra";
--AUTOBAR_CONFIG_TAB_POPUP = "Vent. Emergente";
--AUTOBAR_CONFIG_TAB_PROFILE = "Perfil";
--AUTOBAR_CONFIG_TAB_KEYS = "Teclas";
--
--AUTOBAR_TOOLTIP1 = " (Cantidad: ";
--AUTOBAR_TOOLTIP2 = " [Objeto Personalizado]";
--AUTOBAR_TOOLTIP6 = " [Uso Limitado]";
--AUTOBAR_TOOLTIP7 = " [Enfriamiento]";
AUTOBAR_TOOLTIP8 = "\n(Clic-Izquierdo para aplicar como arma de la mano principal\nClic-Derecho para aplicar como arma de la mano secundaria)";
--
--AUTOBAR_CONFIG_USECHARACTERTIP = "Los objetos de la capa de Personaje son espec\195\173ficos para este personaje.";
--AUTOBAR_CONFIG_USESHAREDTIP = "Los objetos de la capa Compartida son compartidos con otros personajes que tambi\195\169n usan la misma capa Compartida\nLa capa espec\195\173fica puede ser elegida en la pesa\195\177a de Perfil.";
--AUTOBAR_CONFIG_USECLASSTIP = "Los objetos de la capa de Clase son compartidos por todos los personajes de la misma clase que usan la capa de Clase.";
--AUTOBAR_CONFIG_USEBASICTIP = "Los objetos de la capa B\195\161sica son compartidos por todos los personajes que usan la capa B\195\161sica.";
--AUTOBAR_CONFIG_CHARACTERLAYOUTTIP = "Los cambios a la distribuci\195\179n visual solo afectan a este personaje.";
--AUTOBAR_CONFIG_SHAREDLAYOUTTIP = "Los cambios a la distribuci\195\179n visual afectan a todos los personajes que usan el mismo perfil compartido.";
--AUTOBAR_CONFIG_TIPOVERRIDE = "Los objetos en una casilla de esta capa se superpondr\195\161n a los objetos de esta casilla en capas inferiores.\n";
--AUTOBAR_CONFIG_TIPOVERRIDDEN = "Los objetos en una casilla de esta capa ser\195\161n superpuestos por objetos de capas superiores.\n";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "Los cambios afectan solo a este personaje.";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "Los cambios afectan a todos los personajes.";
--AUTOBAR_CONFIG_SETUPSINGLE = "Configuraci\195\179n \195\154nica";
--AUTOBAR_CONFIG_SETUPSHARED = "Configuraci\195\179n Compartida";
--AUTOBAR_CONFIG_SETUPSTANDARD = "Configuraci\195\179n Est\195\161ndar";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "Desde cero";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "Clic para una configuraci\195\179n de personaje \195\186nico similar al AutoBar cl\195\161sico.";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "Clic para una configuraci\195\179n compartida.\nPermite tanto capas de un personaje en particular como capas compartidas";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "Activa la edici\195\179n y uso de todas las capas.";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "Limpia las casillas compartidas y de personaje.";
--AUTOBAR_CONFIG_RESETSINGLETIP = "Clic para reestablecer la configuraci\195\179n por defecto de Personaje \195\154nico.";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "Clic para reestablecer la configuraci\195\179n por defecto de los Personajes Compartidos.\nLas casillas de clase son copiadas a la capa de Personaje.\nLas casillas por defecto son copiadas a la capa Compartida.";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "Pulsa para reestablecer la configuraci\195\179n est\195\161ndar.\nLas casillas de clase se colocan en la capa de Clase.\nLas casillas por defecto son colocadas en la capa B\195\161sica.\nLas capas de Personaje y Compartido son limpiadas.";
--
----  AutoBarConfig.lua
--AUTOBAR_TOOLTIP9 = "Bot\195\179n Multi Categor\195\173a\n";
--AUTOBAR_TOOLTIP10 = " (Objeto Personalizado por ID)";
--AUTOBAR_TOOLTIP11 = "\n(ID de objeto no reconocida)";
--AUTOBAR_TOOLTIP12 = " (Objeto Personalizado por Nombre)";
--AUTOBAR_TOOLTIP13 = "Bot\195\179n de Categor\195\173a \195\154nica\n\n";
--AUTOBAR_TOOLTIP15 = "\nArma Objetivo\n(Clic-Izquierdo arma principal\nClic-Derecho arma secundaria.)"; -- check
AUTOBAR_TOOLTIP17 = "\nSolo sin combate.";
AUTOBAR_TOOLTIP18 = "\nSolo en combate.";
--AUTOBAR_TOOLTIP20 = "\nUso Limitado: "
--AUTOBAR_TOOLTIP21 = "Requiere Recuperaci\195\179n de Salud";
--AUTOBAR_TOOLTIP22 = "Requiere Recuperaci\195\179n de Man\195\161";
--AUTOBAR_TOOLTIP23 = "Bot\195\179n de Objeto \195\154nico\n\n";

end