﻿--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Courtesy of PDI175, lostcup
--

if (GetLocale() == "esMX") then
	AutoBar.locale = {
		["AutoBar"] = "AutoBar",
		["CONFIG_WINDOW"] = "Ventana de Configuración",
		["SLASHCMD_LONG"] = "/autobar",
		["SLASHCMD_SHORT"] = "/atb",
		["Button"] = "Botón",
		["EDITSLOT"] = "Editar Casilla",
		["VIEWSLOT"] = "Ver Casilla",
		["LOAD_ERROR"] = "|cff00ff00Error al cargar AutoBarConfig. Asegúrate de que lo tienes instalado y activado.|r Error: ",
		["Toggle the config panel"] = "Alternar el panel de configuración",
		["Empty"] = "Vacío",

		-- Waterfall
		["Alpha"] = "Transparencia",
		["Change the alpha of the bar."] = "Cambia el índice de transparencia de la barra",
		["Add Button"] = "Añadir Botón",
		["Align Buttons"] = "Alinear Botones",
		["Always Show"] = "Mostrar Siempre";
		["Always Show %s, even if empty."] = "Mostrar Siempre %s, aún estando vacío.";
		["Announce to Party"] = "Announce to Party",
		["Announce to Raid"] = "Announce to Raid",
		["Announce to Say"] = "Announce to Say",
		["Bars"] = "Barras",
		["Battlegrounds only"] = "Solo en Campos de Batalla",
		["Button Width"] = "Anchura del Botón";
		["Change the button width."] = "Cambia el ancho del botón.",
		["Button Height"] = "Altura del Botón";
		["Change the button height."] = "Cambia el alto del botón.",
		["Category"] = "Categoría",
		["Categories"] = "Categorías",
		["Categories for %s"] = "Categorías para %s",
		["Clamp Bars to screen"] = "Limitar Barras a la pantalla",
		["Clamped Bars can not be positioned off screen"] = "Barras Limitadas no pueden ser posicionadas fuera de la pantalla",
		["Collapse Buttons"] = "Colapsar Botones",
		["Collapse Buttons that have nothing in them."] = "Colapsar Botones que no tienen nada.",
		["Configuration for %s"] = "Configuración para %s",
		["Delete this Custom Button completely"] = "Eliminar este Botón Personalizado completamente",
		["Dialog"] = "Dialogo",
		["Disable Conjure Button"] = "Desactivar Botón de Conjuro",
		["Docked to"] = "Anclado a";
		["Done"] = "Hecho";
		["Enabled"] = "Activado",
		["Enable %s."] = "Activa %s",
		["FadeOut"] = "Desvanecer",
		["Fade out the Bar when not hovering over it."] = "Desvanece la Barra cuando no estás sobre ella.",
		["FadeOut Time"] = "Duración de Desvanecer",
		["FadeOut takes this amount of time."] = "El tiempo que tarde en desvanecerse",
		["FadeOut Alpha"] = "Alfa de Desvanecer",
		["FadeOut stops at this Alpha level."] = "Desvanecer se detiene en este nivel de Alfa.",
		["FadeOut Cancels in combat"] = "Cancelar Desvanecer en combate",
		["FadeOut is cancelled when entering combat."] = "Desvanecer es cancelado cuando entras en combate.",
		["FadeOut Cancels on Shift"] = "Cancelar Desvanecer al pulsar Shift",
		["FadeOut is cancelled when holding down the Shift key."] = "Desvanecer se cancela al pulsar la tecla Shift.",
		["FadeOut Cancels on Ctrl"] = "Cancelar Desvanecer al pulsar Ctrl",
		["FadeOut is cancelled when holding down the Ctrl key."] = "Desvanecer se cancela al pulsar la tecla Ctrl.",
		["FadeOut Cancels on Alt"] = "Cancelar Desvanecer al pulsar Alt",
		["FadeOut is cancelled when holding down the Alt key."] = "Desvanecer se cancela al pulsar la tecla Alt.",
		["Frame Level"] = "Nivel del Marco",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "Ajusta el Nivel del Marco de la Barra y sus Botones Emergentes aparecerán encima o debajo de otros objectos del UI",
		["General"] = "General",
		["Hide"] = "Ocultar",
		["Hide %s"] = "Ocultar %s",
		["Item"] = "Objeto",
		["Items"] = "Objetos",
		["Location"] = "Localización",
		["Macro Text"] = "Texto de Macro",
		["Show the button Macro Text"] = "Muestra el texto de la macro del botón",
		["Medium"] = "Medio",
		["Name"] = "Nombre",
		["New"] = "Nuevo",
		["New Macro"] = "New Macro",
		["No Popup"] = "Sin Ventana Emergente";
		["No Popup for %s"] = "Sin Ventana Emergente %s";
		["Non Combat Only"] = "Solo Fuera de Combate",
		["Not directly usable"] = "No utilizable de forma directa",
		["Number of columns for %s"] = "Número de columnas para %s",
		["Dropdown UI"] = "Dropdown UI",
		["Options GUI"] = "Options GUI",
		["Skin the Buttons"] = "Skin the Buttons",
		["Order"] = "Orden",
		["Change the order of %s in the Bar"] = "Cambia el orden de %s en la Barra",
		["Padding"] = "Separación",
		["Change the padding of the bar."] = "Cambia la separación en la barra",
		["Popup Direction"] = "Dirección de Ventana Emergente de botones",
		["Refresh"] = "Actualizar",
		["Refresh all the bars & buttons"] = "Actualizar todas las barras y botones",
		["Remove"] = "Eliminar",
		["Remove this Button from the Bar"] = "Eliminar este Botón de la Barra",
		["Reset"] = "Reestablecer",
		["Reset Bars"] = "Reiniciar Barras",
		["Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged."] = "Reinicia todo a su valor por defecto para todos los caracteres.  Barras Personalizadas, Botones y Categorías permanecen sin cambios.",
		["Reset the Bars to default Bar settings"] = "Reinicia las Barras a su configuración por defecto",
		["Revert"] = "Deshacer";
		["Right Click casts "] = "Click-Derecho lanza ",
		["Rows"] = "Filas";
		["Number of rows for %s"] = "Número de filas para %s",
		["RightClick SelfCast"] = "Click-Derecho lanzar a uno mismo",
		["SelfCast using Right click"] = "Lanzar hechizos sobre uno mismo haciendo click Derecho",
		["Key Bindings"] = KEY_BINDINGS,
		["Assign Bindings for Buttons on your Bars."] = "Assign Bindings for Buttons on your Bars.",
		["Scale"] = "Escala",
		["Change the scale of the bar."] = "Cambia la escala de la barra",
		["Shared Layout"] = "Compartir Estilo",
		["Share the Bar Visual Layout"] = "Comparte el Estilo Visual de la Barra",
		["Shared Buttons"] = "Compartir Botones",
		["Share the Bar Button List"] = "Comparte la Lista de Botones de la Barra",
		["Shared Position"] = "Compartir Posición",
		["Share the Bar Position"] = "Comparte la Posición de la Barra",
		["Shift Dock Left/Right"] = "Mover ancla horizontalmente";
		["Shift Dock Up/Down"] = "Mover ancla verticalmente";
		["Show Count Text"] = "Mostrar el Texto del\nContador";
		["Show Count Text for %s"] = "Mostrar el Texto del\nContador for %s";
		["Show Empty Buttons"] = "Mostrar los Botones Vacíos";
		["Show Empty Buttons for %s"] = "Mostrar los Botones Vacíos %s";
		["Show Extended Tooltips"] = "Show Extended Tooltips";
		["Show Hotkey Text"] = "Muestra la Tecla rápida del botón",
		["Show Hotkey Text for %s"] = "Muestra la Tecla rápida del botón for %s",
		["Show Tooltips"] = "Mostrar los Tooltips";
		["Show Tooltips for %s"] = "Mostrar los Tooltips para %s";
		["Show Tooltips in Combat"] = "Mostrar los Tooltips en Combate";
		["Shuffle"] = "Shuffle",
		["Shuffle replaces depleted items during combat with the next best item"] = "Shuffle replaces depleted items during combat with the next best item",
		["Snap Bars while moving"] = "Barras Pegajosas al moverse",
		["Sticky Frames"] = "Paneles Acoplables",
		["Style"] = "Estilo",
		["Change the style of the bar.  Requires ButtonFacade for non-Blizzard styles."] = "Cambia el estilo de la barra.  Requires ButtonFacade for non-Blizzard styles.",
		["Targeted"] = "Seleccionado.";
		["<Any String>"] = "<Alguna Cadena>",
		["Move the Bars"] = "Mover las Barras",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "Arrastra una barra para moverla, click izquierdo para ocultar (rojo) o mostrar (verde) la barra, click derecho para configurar la barra.",
		["Move the Buttons"] = "Mover los Botones",
		["Drag a Button to move it, right click to configure the Button."] = "Arrastra un Botón para moverlo, click derecho para configurar el Botón.",

		["{circle}"] = "{círculo}",
		["{diamond}"] = "{diamante}",
		["{skull}"] = "{calavera}",
		["{square}"] = "{square}",
		["{star}"] = "{estrella}",
		["{triangle}"] = "{triángulo}",

		["TOPLEFT"] = "Arriba Izquierda",
		["LEFT"] = "Izquierda",
		["BOTTOMLEFT"] = "Abajo Izquierda",
		["TOP"] = "Arriba",
		["CENTER"] = "Centro",
		["BOTTOM"] = "Abajo",
		["TOPRIGHT"] = "Arriba Derecha",
		["RIGHT"] = "Derecha",
		["BOTTOMRIGHT"] = "Abajo Derecha",

		-- AutoBarFuBar
--		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55fDoble-Clic|r para abrir la interfaz de configuración.\n|cffeda55fCtrl-Clic|r para bloquear los botones. |cffeda55fMayúsculas-Clic|r para bloquear las barras.",

		["\n|cffffffff%s:|r %s"] = "\n|cffffffff%s:|r %s",
		["Left-Click"] = "Left-Click",
		["Right-Click"] = "Right-Click",
		["Alt-Click"] = "Alt-Click",
		["Ctrl-Click"] = "Ctrl-Click",
		["Shift-Click"] = "Shift-Click",
		["Ctrl-Shift-Click"] = "Ctrl-Shift-Click",
		["ButtonFacade is required to Skin the Buttons"] = "ButtonFacade is required to Skin the Buttons",
		["Waterfall-1.0 is required to access the GUI"] = "Waterfall-1.0 es necesario para acceder al GUI",

		-- Bar Names
		["AutoBarClassBarBasic"] = "Básica",
		["AutoBarClassBarExtras"] = "Extras",
		["AutoBarClassBarDruid"] = "Druida",
		["AutoBarClassBarHunter"] = "Cazador",
		["AutoBarClassBarMage"] = "Mago",
		["AutoBarClassBarPaladin"] = "Paladín",
		["AutoBarClassBarPriest"] = "Sacerdote",
		["AutoBarClassBarRogue"] = "Pícaro",
		["AutoBarClassBarShaman"] = "Chaman",
		["AutoBarClassBarWarlock"] = "Brujo",
		["AutoBarClassBarWarrior"] = "Guerrero",

		-- Button Names
		["Buttons"] = "Botones",
		["AutoBarButtonHeader"] = "Nombre de Botones de AutoBar",
		["AutoBarCooldownHeader"] = "Reutilización Poción y Piedra",

		["AutoBarButtonAura"] = "Aura / Aspecto",
		["AutoBarButtonBandages"] = "Vendas",
		["AutoBarButtonBattleStandards"] = "Normas de Batalla",
		["AutoBarButtonBuff"] = "Buff",
		["AutoBarButtonBuffWeapon1"] = "Buff: Arma Mano Principal",
		["AutoBarButtonBuffWeapon2"] = "Buff: Arma Otra Mano",
		["AutoBarButtonCharge"] = "Charge",
		["AutoBarButtonClassBuff"] = "Buff: Clase",
		["AutoBarButtonClassPet"] = "Mascota de Clase",
		["AutoBarButtonConjure"] = "Conjuro",
		["AutoBarButtonCooldownDrums"] = "Reutilización: Sueños",
		["AutoBarButtonCooldownPotionHealth"] = "Reutilización: Salud",
		["AutoBarButtonCooldownPotionMana"] = "Reutilización: Maná",
		["AutoBarButtonCooldownPotionRejuvenation"] = "Reutilización: Rejuvenecer",
		["AutoBarButtonCooldownStoneHealth"] = "Reutilización: Piedra Salud",
		["AutoBarButtonCooldownStoneMana"] = "Reutilización: Piedra Maná",
		["AutoBarButtonCooldownStoneRejuvenation"] = "Reutilización: Piedra Rejuvenecer",
		["AutoBarButtonCrafting"] = "Profesiones",
		["AutoBarButtonElixirBattle"] = "Elixir: Batalla",
		["AutoBarButtonElixirGuardian"] = "Elixir: Guardian",
		["AutoBarButtonElixirBoth"] = "Elixir: Batalla y Guardian",
		["AutoBarButtonER"] = "ER",
		["AutoBarButtonExplosive"] = "Explosivo",
		["AutoBarButtonFishing"] = "Pesca",
		["AutoBarButtonFood"] = "Comida",
		["AutoBarButtonFoodBuff"] = "Comida: Buff",
		["AutoBarButtonFoodCombo"] = "Comida: Combinada",
		["AutoBarButtonFoodPet"] = "Comida: Mascota",
		["AutoBarButtonFreeAction"] = "Acción Libre",
		["AutoBarButtonHeal"] = "Salud",
		["AutoBarButtonSpell1"] = "Magia 1",
		["AutoBarButtonSpell2"] = "Magia 2",
		["AutoBarButtonSpell3"] = "Magia 3",
		["AutoBarButtonSpell4"] = "Magia 4",
		["AutoBarButtonHearth"] = "Corazón",
		["AutoBarButtonPickLock"] = "Coger Cerradura",
		["AutoBarButtonMount"] = "Montar",
		["AutoBarButtonPets"] = "Mascotas",
		["AutoBarButtonQuest"] = "Misiones",
		["AutoBarButtonRecovery"] = "Maná / Ira / Energía",
		["AutoBarButtonRotationDrums"] = "Rotación: Sueños",
		["AutoBarButtonSpeed"] = "Velocidad",
		["AutoBarButtonStance"] = "Postura",
		["AutoBarButtonStealth"] = "Sigilo",
		["AutoBarButtonSting"] = "Picadura",
		["AutoBarButtonTotemEarth"] = "Totem de Tierra",
		["AutoBarButtonTotemAir"] = "Totem de Aire",
		["AutoBarButtonTotemFire"] = "Totem de Fuego",
		["AutoBarButtonTotemWater"] = "Totem de Agua",
		["AutoBarButtonTrack"] = "Pista",
		["AutoBarButtonTrap"] = "Trampa",
		["AutoBarButtonTrinket1"] = "Abalorio 1",
		["AutoBarButtonTrinket2"] = "Abalorio 2",
		["AutoBarButtonWarlockStones"] = "Piedras de Brujo",
		["AutoBarButtonWater"] = "Agua",
		["AutoBarButtonWaterBuff"] = "Agua: Buff",

		["AutoBarButtonBear"] = "Oso",
		["AutoBarButtonBoomkinTree"] = "Arbol de Vida / Boomkin",
		["AutoBarButtonCat"] = "Gato",
		["AutoBarButtonTravel"] = "Viajar",
		["AutoBarButtonFlight"] = "Volar",
		["AutoBarButtonNormal"] = "Normal",

		-- AutoBarClassButton.lua
		["Num Pad "] = "Teclado Numerico ",
		["Mouse Button "] = "Botón Ratón ",
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
		["Sp"] = "Suprimir",
		["De"] = "De",
		["Ho"] = "Inicio",
		["En"] = "Fin",
		["Ins"] = "Ins",
		["Pu"] = "RePag",
		["Pd"] = "AvPag",
		["D"] = "Arr",
		["U"] = "Aba",
		["L"] = "Izq",
		["R"] = "Der",

		--  AutoBarConfig.lua
		["EMPTY"] = "Vacío";
		["Default"] = "Por defecto",
		["Zoomed"] = "Agrandado",
		["Dreamlayout"] = "Dreamlayout",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "Desactivar Autolanzar con Click-Derecho";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Eliminar la Categoría Actual";
		["Columns"] = "Columnas";
		["AUTOBAR_CONFIG_GAPPING"] = "Espacio entre Iconos";
		["AUTOBAR_CONFIG_ALPHA"] = "Transparencia de Iconos";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Altura del Botón\ny Anchura Desbloqueados";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Mostrar Iconos de Categorias";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Ventana emergente con tecla de\nMayúsculas";
		["Rearrange Order on Use"] = "Reajustar el orden al usar";
		["Rearrange Order on Use for %s"] = "Reajustar el orden al usar para %s";
		["Right Click Targets Pet"] = "Click-Derecho cambia objetivo a Mascota";
		["None"] = "Ninguno";
		["AUTOBAR_CONFIG_BT3BAR"] = "Barra de BarTender3 ";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Menú Principal";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Ventana de Chat";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Menú de la Ventana de Chat";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Barra de Acción";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menú de Botones";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(No encontrado: Objeto ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " Capa (click para editar)";
		["AUTOBAR_CONFIG_CHARACTER"] = "Personaje";
		["Shared"] = "Compartido";
		["Account"] = "Cuenta";
		["Class"] = "Clase";
		["AUTOBAR_CONFIG_BASIC"] = "Básico";
		["AUTOBAR_CONFIG_USECHARACTER"] = "Usar la capa de Personaje";
		["AUTOBAR_CONFIG_USESHARED"] = "Usar la capa Compartida";
		["AUTOBAR_CONFIG_USECLASS"] = "Usar la capa de Clase";
		["AUTOBAR_CONFIG_USEBASIC"] = "Usar la capa Básica";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "Ocultar los Tooltips de\nConfiguración";
		["AUTOBAR_CONFIG_OSKIN"] = "Usar oSkin";
		["Log Events"] = "Log Events";
		["Log Performance"] = "Registro de la Ejecución";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "Distribución de Personaje";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "Distribución de Compartido";
		["AUTOBAR_CONFIG_SHARED1"] = "Compartido 1";
		["AUTOBAR_CONFIG_SHARED2"] = "Compartido 2";
		["AUTOBAR_CONFIG_SHARED3"] = "Compartido 3";
		["AUTOBAR_CONFIG_SHARED4"] = "Compartido 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "Editar la capa de\nPersonaje";
		["AUTOBAR_CONFIG_EDITSHARED"] = "Editar la capa\nCompartida";
		["AUTOBAR_CONFIG_EDITCLASS"] = "Editar la capa de Clase";
		["AUTOBAR_CONFIG_EDITBASIC"] = "Editar la capa Básica";
		["Share the config"] = "Share the config";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "Fuegos artificiales",
		["Tradeskill.Tool.Fishing.Lure"] = "Cebos de Pesca",
		["Tradeskill.Tool.Fishing.Gear"] = "Equipo de Pesca",
		["Tradeskill.Tool.Fishing.Other"] = "Artículos de Pesca",
		["Tradeskill.Tool.Fishing.Tool"] = "Cañas de Pescar",

		["Consumable.Food.Bonus"] = "Comida: Bonificación";
		["Consumable.Food.Buff.Strength"] = "Comida: Bonificación de Fuerza";
		["Consumable.Food.Buff.Agility"] = "Comida: Bonificación de Agilidad";
		["Consumable.Food.Buff.Attack Power"] = "Comida: Bonificación de Poder de Ataque";
		["Consumable.Food.Buff.Healing"] = "Comida: Bonificación de Curación";
		["Consumable.Food.Buff.Spell Damage"] = "Comida: Bonificación de Daños de Hechizo";
		["Consumable.Food.Buff.Stamina"] = "Comida: Bonificación de Aguante";
		["Consumable.Food.Buff.Intellect"] = "Comida: Bonificación de Inteligencia";
		["Consumable.Food.Buff.Spirit"] = "Comida: Bonificación de Espíritu";
		["Consumable.Food.Buff.Mana Regen"] = "Comida: Bonificación de Regeneración de Maná";
		["Consumable.Food.Buff.HP Regen"] = "Comida: Bonificación de Regeneración de Salud";
		["Consumable.Food.Buff.Other"] = "Comida: Otros";

		["Consumable.Buff.Health"] = "Buff: Salud";
		["Consumable.Buff.Armor"] = "Buff: Armadura";
		["Consumable.Buff.Regen Health"] = "Buff: Regenerar Salud";
		["Consumable.Buff.Agility"] = "Buff: Agilidad";
		["Consumable.Buff.Intellect"] = "Buff:l Intelecto";
		["Consumable.Buff.Protection"] = "Buff: Protección";
		["Consumable.Buff.Spirit"] = "Buff: Espíritu";
		["Consumable.Buff.Stamina"] = "Buff: Estamina";
		["Consumable.Buff.Strength"] = "Buff: Fuerza";
		["Consumable.Buff.Attack Power"] = "Buff: Potencia de Ataque";
		["Consumable.Buff.Attack Speed"] = "Buff: Velocidad de Ataque";
		["Consumable.Buff.Dodge"] = "Buff: Esquivar";
		["Consumable.Buff.Resistance"] = "Buff: Resistencia";

		["Consumable.Buff Group.General.Self"] = "Buff: General";
		["Consumable.Buff Group.General.Target"] = "Buff: Objetivo General";
		["Consumable.Buff Group.Caster.Self"] = "Buff: Caster";
		["Consumable.Buff Group.Caster.Target"] = "Buff: Objetivo Caster";
		["Consumable.Buff Group.Melee.Self"] = "Buff: Cuerpo a Cuerpo";
		["Consumable.Buff Group.Melee.Target"] = "Buff: Objetivo Cuerpo a Cuerpo";
		["Consumable.Buff.Other.Self"] = "Buff: Otro";
		["Consumable.Buff.Other.Target"] = "Buff: Otro Objetivo";
		["Consumable.Buff.Chest"] = "Buff: Pecho";
		["Consumable.Buff.Shield"] = "Buff: Escudo";
		["Consumable.Weapon Buff"] = "Buff: Arma";

		["Misc.Usable.BossItem"] = "Boss Items";
		["Misc.Usable.Permanent"] = "Objetos Usados Permanentemente";
		["Misc.Usable.Quest"] = "Objetos de Misión";
		["Misc.Usable.Replenished"] = "Artículos Reponibles";

		["Consumable.Cooldown.Potion.Health.Basic"] = "Pociones de Curación";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "Pociones de Curación: Blades Edge";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "Pociones de Curación: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Health.PvP"] = "Pociones de Salud de Campos de Batalla";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "Pociones de Curación: Tempestad";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "Pociones de Maná";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "Pociones de Maná: Blades Edge";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "Pociones de Maná: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "Pociones de Campos de Batalla";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "Pociones de Maná: Tempestad";

		["Consumable.Weapon Buff.Poison.Crippling"] = "Veneno de Ralentización";
		["Consumable.Weapon Buff.Poison.Deadly"] = "Veneno Mortal";
		["Consumable.Weapon Buff.Poison.Instant"] = "Veneno Instantáneo";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "Veneno de entumecimiento mental";
		["Consumable.Weapon Buff.Poison.Wound"] = "Veneno Hiriente";
		["Consumable.Weapon Buff.Oil.Mana"] = "Aceite de encantamiento: Regeneración de Maná";
		["Consumable.Weapon Buff.Oil.Wizard"] = "Aceite de encantamiento: Bonificación a Daño/Curación";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "Piedras de afilar creadas por Herrero";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "Piedras de peso creadas por Herrero";

		["Consumable.Bandage.Basic"] = "Vendas";
		["Consumable.Bandage.Battleground.Alterac Valley"] = "Vendas de Alterac";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "Vendas de Grito de Guerra";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "Vendas de Arathi";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "Comida: Sin Bonificación";
		["Consumable.Food.Percent.Basic"] = "Comida: % aumento de salud";
		["Consumable.Food.Percent.Bonus"] = "Comida: % Regeneración de Salud (buff de bien alimentado)";
		["Consumable.Food.Edible.Combo.Non-Conjured"] = "Comida: combo de ganancia de salud y maná, no conjurado";
		["Consumable.Food.Edible.Combo.Conjured"] = "Comida: combo de ganancia de salud y maná, conjurado";
		["Consumable.Food.Combo Percent"] = "Comida: % aumento de salud y maná";
		["Consumable.Food.Combo Health"] = "Combinación de Comida y Agua";
		["Consumable.Food.Edible.Bread.Conjured"] = "Comida: Conjurada por Mago";
		["Consumable.Food.Conjure"] = "Comida Conjurada";
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
		["AUTOBAR_CLASS_UNGORORESTORE"] = "Un'Goro: Cristal de Recuperación";

		["Consumable.Anti-Venom"] = "Anti-Veneno";

		["Consumable.Warlock.Firestone"] = "Piedra de Fuego";
		["Consumable.Warlock.Soulstone"] = "Piedra del Alma";
		["Consumable.Warlock.Spellstone"] = "Piedra de Magia";
		["Consumable.Cooldown.Stone.Health.Warlock"] = "Piedras de Salud";
		["Spell.Warlock.Create Firestone"] = "Crear Piedra de Fuego";
		["Spell.Warlock.Create Healthstone"] = "Crear Piedra de Salud";
		["Spell.Warlock.Create Soulstone"] = "Crear Piedra del Alma";
		["Spell.Warlock.Create Spellstone"] = "Crear Piedra de Magia";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "Piedras de Maná";
		["Spell.Mage.Conjure Mana Stone"] = "Conjurar Piedras de Maná";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "Poción de letargo sin sueños";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "Pociones de Rejuvenecimiento";
		["Consumable.Cooldown.Stone.Health.Statue"] = "Estátuas de piedra";
		["Consumable.Cooldown.Drums"] = "Reutilización: Sueños";
		["Consumable.Cooldown.Potion"] = "Reutilización: Pociónn";
		["Consumable.Cooldown.Stone"] = "Reutilización: Piedra";
		["Consumable.Leatherworking.Drums"] = "Sueños";
		["Consumable.Tailor.Net"] = "Redes";

		["Misc.Battle Standard.Battleground"] = "Estandarte de Batalla";
		["Misc.Battle Standard.Alterac Valley"] = "Estandarte de Batalla VdA";
		["Consumable.Cooldown.Stone.Health.Other"] = "Objetos de Curación: Otros";
		["Consumable.Cooldown.Stone.Mana.Other"] = "Runas Oscuras y Demoníacas";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "Protección contra arcano";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "Protección contra Fuego";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "Protección contra Escarcha";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "Protección contra Naturaleza";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "Protección contra Sombra";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "Protección contra Hechizo";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "Protección contra Sagrado";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "Pociones de Invulnerabilidad";
		["Consumable.Buff.Free Action"] = "Poción de Acción Libre";

		["Misc.Lockboxes"] = LOCKED;
		["Gear.Trinket"] = INVTYPE_TRINKET;

		["Spell.Aura"] = "Aura / Aspecto";
		["Spell.Buff.Weapon"] = "Buff Magias: Arma";
		["Spell.Class.Buff"] = "Buff: Clase";
		["Spell.Class.Pet"] = "Mascota de Clase";
		["Spell.Crafting"] = "Fabricar";
		["Spell.Fishing"] = "Pesca";
		["Spell.Portals"] = "Portales y Teleportales";
		["Spell.Sting"] = "Picadura";
		["Spell.Stance"] = "Postura";
		["Spell.Totem.Earth"] = "Totem de Tierra";
		["Spell.Totem.Air"] = "Totem de Aire";
		["Spell.Totem.Fire"] = "Totem de Fuego";
		["Spell.Totem.Water"] = "Totem de Agua";
		["Spell.Track"] = "Pista";
		["Spell.Trap"] = "Trampa";
		["Misc.Hearth"] = "Piedra de hogar";
		["Misc.Booze"] = "Alcohol";
		["Consumable.Water.Basic"] = "Agua";
		["Consumable.Water.Percentage"] = "Agua: % aumento de maná";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "Agua: Conjurada por Mago";
		["Consumable.Water.Conjure"] = "Agua Conjurada";
		["Consumable.Water.Buff.Spirit"] = "Agua: Bonificación de Espíritu";
		["Consumable.Water.Buff"] = "Agua: Bonificación";
		["Consumable.Buff.Rage"] = "Pociones de Rabia";
		["Consumable.Buff.Energy"] = "Pociones de Energía";
		["Consumable.Buff.Speed"] = "Pociones de Velocidad";
		["Consumable.Buff Type.Battle"] = "Buff: Elixir de Batalla";
		["Consumable.Buff Type.Guardian"] = "Buff: Elixir del Guardian";
		["Consumable.Buff Type.Flask"] = "Buff: Flask";
		["AUTOBAR_CLASS_SOULSHARDS"] = "Fragmentos del Alma";
		["Misc.Reagent.Ammo.Arrow"] = "Flechas";
		["Misc.Reagent.Ammo.Bullet"] = "Balas";
		["Misc.Reagent.Ammo.Thrown"] = "Armas Arrojadizas";
		["Misc.Explosives"] = "Explosivos";
		["Misc.Mount.Normal"] = "Monturas";
		["Misc.Mount.Summoned"] = "Monturas: Invocada";
		["Misc.Mount.Ahn'Qiraj"] = "Monturas: Qiraji";
		["Misc.Mount.Flying"] = "Monturas: Volando";
	}

--AUTOBAR_CHAT_MESSAGE1 = "La configuración para este personaje es de una versión anterior. Borrando. No se intentará actualizar la configuración actual.";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_TAB_BAR = "Barra";
--AUTOBAR_CONFIG_TAB_POPUP = "Vent. Emergente";
--AUTOBAR_CONFIG_TAB_PROFILE = "Perfil";
--AUTOBAR_CONFIG_TAB_KEYS = "Teclas";

--AUTOBAR_TOOLTIP1 = " (Cantidad: ";
--AUTOBAR_TOOLTIP2 = " [Objeto Personalizado]";
--AUTOBAR_TOOLTIP6 = " [Uso Limitado]";
--AUTOBAR_TOOLTIP7 = " [Reutilización]";
AUTOBAR_TOOLTIP8 = "\n(Clic-Izquierdo para aplicar como arma de la mano principal\nClic-Derecho para aplicar como arma de la mano secundaria)";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "Los cambios afectan solo a este personaje.";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "Los cambios afectan a todos los personajes.";
--AUTOBAR_CONFIG_SETUPSINGLE = "Configuración Única";
--AUTOBAR_CONFIG_SETUPSHARED = "Configuración Compartida";
--AUTOBAR_CONFIG_SETUPSTANDARD = "Configuración Estándar";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "Desde cero";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "Clic para una configuración de personaje único similar al AutoBar clásico.";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "Clic para una configuración compartida.\nPermite tanto capas de un personaje en particular como capas compartidas";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "Activa la edición y uso de todas las capas.";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "Limpia las casillas compartidas y de personaje.";
--AUTOBAR_CONFIG_RESETSINGLETIP = "Clic para reestablecer la configuración por defecto de Personaje Único.";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "Clic para reestablecer la configuración por defecto de los Personajes Compartidos.\nLas casillas de clase son copiadas a la capa de Personaje.\nLas casillas por defecto son copiadas a la capa Compartida.";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "Pulsa para reestablecer la configuración estándar.\nLas casillas de clase se colocan en la capa de Clase.\nLas casillas por defecto son colocadas en la capa Básica.\nLas capas de Personaje y Compartido son limpiadas.";

----  AutoBarConfig.lua
--AUTOBAR_TOOLTIP9 = "Botón Multi Categoría\n";
--AUTOBAR_TOOLTIP10 = " (Objeto Personalizado por ID)";
--AUTOBAR_TOOLTIP11 = "\n(ID de objeto no reconocida)";
--AUTOBAR_TOOLTIP12 = " (Objeto Personalizado por Nombre)";
--AUTOBAR_TOOLTIP13 = "Botón de Categoría Única\n\n";
--AUTOBAR_TOOLTIP15 = "\nArma Objetivo\n(Clic-Izquierdo arma principal\nClic-Derecho arma secundaria.)"; -- check
AUTOBAR_TOOLTIP17 = "\nSolo sin combate.";
AUTOBAR_TOOLTIP18 = "\nSolo en combate.";
--AUTOBAR_TOOLTIP20 = "\nUso Limitado: "
--AUTOBAR_TOOLTIP21 = "Requiere Recuperación de Salud";
--AUTOBAR_TOOLTIP22 = "Requiere Recuperación de Maná";

end
