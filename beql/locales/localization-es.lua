local L = AceLibrary("AceLocale-2.2"):new("beql")
L:RegisterTranslations("esES", function() return{

	["Bayi's Extended Quest Log"] = "Bayi's Extended Quest Log",
	["No Objectives!"] = "Sin Objetivos",
	["(Done)"] = "(Hecho)",
	["Click to open Quest Log"] = "Haz click para abrir el Registro de Misiones",
	["Completed!"] = "Completada!",
	[" |cffff0000Disabled by|r"] = " |cffff0000Desactivado por|r",
	["Reload UI ?"] = "Recargar Interfaz ?",	
	["FubarPlugin Config"] = "Configuraci\195\179n FubarPlugin",
	["Requires Interface Reload"] = "Requiere recargar el interfaz",	
	
	["Quest Log Options"] = "Opciones de Registro de Misiones",
	["Options related to the Quest Log"] = "Opciones relacionadas con el Registro de Misiones",
	["Lock Quest Log"] = "Bloquear Registro de Misiones",
	["Makes the quest log unmovable"] = "Impide que pueda moverse el Registro de Misiones",
	["Always Open Minimized"] = "Siempre abrir minimizado",	
	["Force the quest log to open minimized"] = "Fuerza el registro de misiones para abrirse siempre minimizado",
	["Always Open Maximized"] = "Siempre abrir maximizado",
	["Force the quest log to open maximized"] = "Fuerza el registro de misiones para abrirse siempre maximizado",
	["Show Quest Level"] = "Mostrar nivel de misi\195\179n",
	["Shows the quests level"] = "Mostrar el nivel de las misiones",
	["Info on Quest Completion"] = "Informa al completar misi\195\179n",
	["Shows a message and plays a sound when you complete a quest"] = "Muestra un mensaje y reproduce un sonido cuando completas una misi\195\179n",
	["Auto Complete Quest"] = "Autocompletar misi\195\179n",
	["Automatically Complete Quests"] = "Completa las misiones autom\195\161ticamente",	
	["Mob Tooltip Quest Info"] = "Informaci\195\179n Misi\195\179n Tooltip Monstruo",
	["Show quest info in mob tooltips"] = "Muestra informaci\195\179n sobre la misi\195\179n en los cuadros de datos de los monstruos",
	["Item Tooltip Quest Info"] = "Informaci\195\179n Misi\195\179n Tooltip Objeto",
	["Show quest info in item tooltips"] = "Muestra informaci\195\179n sobre la misi\195\179n en los cuadros de datos de los objetos",
	["Simple Quest Log"] = "Registro de Misiones Simple",
	["Uses the default Blizzard Quest Log"] = "Utiliza el registro de misiones por defecto de Blizzard",	
	["Quest Log Alpha"] = "Transparencia Registro Misiones",
	["Sets the Alpha of the Quest Log"] = "Ajusta la transparencia del registro de misiones",

	["Quest Tracker"] = "Rastreador de Misiones",
	["Quest Tracker Options"] = "Opciones del rastreador de misiones",
	["Options related to the Quest Tracker"] = "Opciones relacionadas con el rastreador de misiones",
	["Lock Tracker"] = "Bloquear Rastreador",
	["Makes the quest tracker unmovable"] = "Impide que pueda moverse el rastreador de misiones",	
	["Show Tracker Header"] = "Mostrar cabecera del rastreador",
	["Shows the trackers header"] = "Muestra la cabecera del rastreador",
	["Hide Completed Objectives"] = "Ocultar Objetivos Completados",
	["Automatical hide completed objectives in tracker"] = "Ocultar autom\195\161ticamente los objetivos completados en el rastreador",	
	["Remove Completed Quests"] = "Borrar Misiones Completadas",
	["Automatical remove completed quests from tracker"] = "Borrar autom\195\161ticamente las misiones completadas del rastreador",	
	["Font Size"] = "Tama\195\177o de Fuente",
	["Changes the font size of the tracker"] = "Cambia el tama\195\177o de la fuente del rastreador",
	["Sort Tracker Quests"] = "Ordena Misiones del Rastreador",
	["Sort the quests in tracker"] = "Ordena las misiones en el rastreador",	
	["Show Quest Zones"] = "Mostrar Zonas",
	["Show the quests zone it belongs to above its name"] = "Muestra la zona de la misi\195\179n a la que pertenece sobre su nombre",
	["Add New Quests"] = "A\195\177ade Nuevas Misiones",
	["Automatical add new Quests to tracker"] = "A\195\177ade nuevas misiones autom\195\161ticamente al rastreador",
	["Add Untracked"] = "A\195\177ade No Rastreadas",
	["Automatical add quests with updated objectives to tracker"] = "A\195\177ade autom\195\161ticamente las misiones con objetivos actualizados al rastreador",	
	["Reset tracker position"] = "Resetear Posici\195\179n Rastreador",	
	["Active Tracker"] = "Rastreador Activo",
	["Showing on mouseover tooltips, clicking opens the tracker, rightclicking removes the quest from tracker"] = "Muestra el tooltip al pasar el rat\195\179n por encima, haciendo click abre el rastreador, bot\195\179n derecho elimina la misi\195\179n del rastreador",
	["Hide Objectives for Completed only"] = "Oculta Objetivos S\195\179lo Completadas",
	["Hide objectives only for completed quests"] = "Oculta los objetivos s\195\179lo para las misiones completadas",
	
	["Markers"] = "Marcadores",
	["Customize the Objective/Quest Markers"] = "Personaliza los marcadores del objetivo/misi\195\179n",
	["Show Objective Markers"] = "Muestra Marcadores Objetivo",
	["Display Markers before objectives"] = "Muestra los marcadores antes de los objetivos",
	["Use Listing"] = "Utilizar Listado",
	["User Listing rather than symbols"] = "Utiliza un listado en vez de los s\195\173mbolos",
	["List Type"] = "Tipo de Listado",
	["Set the type of listing"] = "Ajusta el tipo de listado",
	["Symbol Type"] = "Tipo de S\195\173mbolo",
	["Set the type of symbol"] = "Ajusta el tipo de s\195\173mbolo",

	["Colors"] = "Colores",
	["Set tracker Colors"] = "Ajusta los colores del rastreador",
	["Background"] = "Fondo",
	["Use Background"] = "Utilizar fondo",
	["Custom Background Color"] = "Color de Fondo Personalizado",
	["Use custom color for background"] = "Utiliza un color personalizado para el fondo",
	["Background Color"] = "Color de Fondo",
	["Sets the Background Color"] = "Ajusta el color de fondo",
	["Background Corner Color"] = "Color de Fondo de Bordes",
	["Sets the Background Corner Color"] = "Ajusta el color de fondo de los bordes",	
	["Use Quest Level Colors"] = "Utilizar Colores de Nivel Misiones",
	["Use the colors to indicate quest difficulty"] = "Utiliza los colores para indicar la dificultad de la misi\195\179n",	
	["Custom Zone Color"] = "Color de Zona Personalizado",
	["Use custom color for Zone names"] = "Utiliza un color personalizado para los nombres de zona",
	["Zone Color"] = "Color de zona",
	["Sets the zone color"] = "Ajusta el color de zona",	
	["Fade Colors"] = "Colores Atenuado",
	["Fade the objective colors"] = "Aten\195\186a los colores del objetivo",
	["Custom Objective Color"] = "Color de Objetivo Personalizado",
	["Use custom color for objective text"] = "Utiliza un color personalizado para el texto de objetivo",	
	["Objective Color"] = "Color de Objetivo",
	["Sets the color for objectives"] = "Ajusta el color para los objetivos",	
	["Completed Objective Color"] = "Color Objetivo Completado",
	["Sets the color for completed objectives"] = "Ajusta el color para los objetivos completados",	
	["Custom Header Color"] = "Color Cabecera Personalizado",
	["Use custom color for headers"] = "Utiliza un color personalizado para las cabeceras",
	["Completed Header Color"] = "Color Cabecera Completada",
	["Sets the color for completed headers"] = "Ajusta el color para las cabeceras completadas",
	["Header Color"] = "Color Cabecera",
	["Sets the color for headers"] = "Ajusta el color para las cabeceras",
	["Disable Tracker"] = "Desactiva RastreadorDisable Tracker",
	["Disable the Tracker"] = "Desactiva el rastreador",
	["Quest Tracker Alpha"] = "Transparencia Rastreador",
	["Sets the Alpha of the Quest Tracker"] = "Ajusta la transparencia del rastreador de misiones",
	["Auto Resize Tracker"] = "Auto Resize Tracker",
	["Automatical resizes the tracker depending on the lenght of the text in it"] = "Automatical resizes the tracker depending on the lenght of the text in it",
	["Fixed Tracker Width"] = "Fixed Tracker Width",
	["Sets the fixed width of the tracker if auto resize is disabled"] = "Sets the fixed width of the tracker if auto resize is disabled",		
	
	["Pick Locale"] = "Selecciona Idioma",
	["Change Locale (needs Interface Reload)"] = "Cambiar idioma (necesita recargar el interfaz)",
	
	["|cffffffffQuests|r"] = "|cffffffffMisiones|r",
	["|cffff8000Tracked Quests|r"] = "|cffff8000Misiones|r Supervisadas",
	["|cff00d000Completed Quests|r"] = "|cff00d000Misiones|r Completadas",
	["|cffeda55fClick|r to open Quest Log and |cffeda55fShift+Click|r to open Waterfall config"] = "|cffeda55fHaz click|r para abrir el registro de misiones y |cffeda55fhaz click + mays|r para abrir la configuraci\195\179n de Waterfall",
	
	["Tooltip"] = "Tooltip",
	["Tooltip Options"] = "Tooltip Options",
	["Tracker Tooltip"] = "Tracker Tooltip",
	["Showing mouseover tooltips in tracker"] = "Showing mouseover tooltips in tracker",
	["Quest Description in Tracker Tooltip"] = "Quest Description in Tracker Tooltip",
	["Displays the actual quest's description in the tracker tooltip"] = "Displays the actual quest's description in the tracker tooltip",
	["Party Quest Progression info"] = "Party Quest Progression info",
	["Displays Party members quest status in the tooltip - Quixote must be installed on the partymembers client"] = "Displays Party members quest status in the tooltip - Quixote must be installed on the partymembers client",
	["Enable Left Click"] = "Enable Left Click",
	["Left clicking a quest in the tracker opens the Quest Log"] = "Left clicking a quest in the tracker opens the Quest Log",
	["Enable Right Click"] = "Enable Right Click",
	["Right clicking a quest in the tracker removes it from the tracker"] = "Right clicking a quest in the tracker removes it from the tracker",
	["Quest Log Scale"] = "Quest Log Scale",
	["Sets the Scale of the Quest Log"] = "Sets the Scale of the Quest Log",
	["Force Tracker Unlock"] = "Force Tracker Unlock",
	["Make the Tracker movable even with CTMod loaded. Please check your CTMod config before using it"] = "Make the Tracker movable even with CTMod loaded. Please check your CTMod config before using it",	
	["Quest Progression to Party Chat"] = "Quest Progression to Party Chat",
	["Prints the Quest Progression Status to the Party Chat"] = "Prints the Quest Progression Status to the Party Chat",		
	["Completion Sound"] = "Completion Sound",
	["Select the sound to be played when a quest is completed"] = "Select the sound to be played when a quest is completed",
	
	["Quest Description Color"] = "Quest Description Color",
	["Sets the color for the Quest description"] = "Sets the color for the Quest description",
	["Party Member Color"] = "Party Member Color",
	["Party Member with Quixote Color"] = "Party Member with Quixote Color",
	["Sets the color for Party member"] = "Sets the color for Party member",	
} end )

if GetLocale() == "esES" then

BEQL_COMPLETE = "%(Completada%)"
BEQL_QUEST_ACCEPTED = "Has aceptado la misi\195\179n:"

end