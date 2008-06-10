local L = AceLibrary("AceLocale-2.2"):new("XLoot")

L:RegisterTranslations("esES", function()
	return {
		catSnap = "Comportamiento de la Ventana",
		catLoot = "Comportamiento del Botín",
		catFrame = "Opciones de Ventana",
		catInfo = "Información de Botín",
		catGeneralAppearance = "Apariencia General",
		catFrameAppearance = "Apariencia de la Ventana",
		catLootAppearance = "Apariencia del Botín",
		catExtras = "Extras",
		
		optLock = "Bloquear Ventana",
		optOptions = "Opciones de Interfaz",
		optBehavior = "Opciones de Comportamiento",
		optCursor = "Pegar la ventana de XLoot al cursor",
		optSmartsnap = "Sólo pegar verticalmente",
		optSnapoffset = "Offset del pegado",
		optCollapse = "Ocultar botones de botín vacíos",
		optDragborder = "Borde Arrastrable",
		optLootexpand = "Ajustar la anchura de la ventana a los nombres del botín",
		optAltoptions = "Mostrar menú con Alt+ClicDerecho",
		optSwiftloot = "Ocultar ventana cuando se despoja automáticamente",
		optQualitytext = "Mostrar el texto de la calidad del objeto",
		optInfotext = "Mostrar el texto de la información del objeto",
		["Show BoP/BoE/BoU"] =  "Mostrar BoP/BoE/BoU",
		["Show Bind on Pickup/Bind on Equip/Bind on Use text opposite stack size for items"] = "Muestra el texto de Se liga al Recogerlo/Se liga al Equiparlo/Se liga al Usarlo en el lado contrario del tamaño de lote para objetos", -- this makes no	sense
		optLinkAll = "Botón de Enlazar Todo",
		optLinkAllVis = "Visible: ",
		optLinkAllThreshold = "Límite de enlaces",
		optLinkAllChannels = "Siempre enlazar en...",
		optAppearance = "Apariencia",
		optQualityborder = "Colorear el borde según la calidad",
		optQualityframe = "Colorear ventana según la calidad",
		optLootqualityborder = "Colorear el borde según la calidad",
		optBgcolor = "Color de Fondo",
		optBordercolor = "Color del Borde",
		optTexColor = "Colorear icono según su calidad",
		optHighlightLoot = "Resaltar según su calidad",
		optHighlightThreshold = "Límite de resaltado", 
		optLootbgcolor = "Color de fondo",
		optLootbordercolor = "Color del borde",
		optInfoColor = "Color del texto de información",
		optScale = "Escala",
		optAdvanced = "Opciones Avanzadas",
		optDebug = "Mensajes de Depuración",
		optDefaults = "Reestablecer a valores por defecto",
		
		descLock = "Impide que se pueda mover la ventana de botín",
		descOptions = "Muestra el menú de opciones",
		descBehavior = "Cambia cómo se comporta XLoot",
		descCursor = "Pega la ventana de botín al cursor cuando saqueas algo",
		descSmartsnap = "Pega la ventana de botín sólo verticalmente al cursor para que no empiece a dar saltos mientras vas saqueando",
		descSnapoffset = "Establece la distancia a la que pegarse horizontalmente desde la mitad del primer icono del botín",
		descCollapse = "Oculta los botones saqueados (vacíos) y coloca el cursor sobre la siguiente ventana si la opción Pegar está activada.",
		descDragborder = "Permite que la ventana de botín se pueda desplazar al arrastrar su borde, en vez de tan sólo los botones, que podrán ser pulsados a través",
		descLootexpand = "Cambia la anchura de la ventana para ajustarse a los nombres del botín. Los nombres cortos crearán ventanas estrechas y los nombres largos más anchas",
		descAltoptions = "Te permite hacer Alt+ClicDerecho en el botín para mostrar el menú de XLoot. Puede ser desactivado para no perjudicar a otros accesorios.",
		descSwiftloot = "Previene un poco de lag que se produce al saquear objetos automáticamente, ya sea a través de los ajustes de las Opciones de Interfaz o al mantener pulsada la tecla elegida (también establecido en las opciones de Interfaz)",
		descQualitytext = "Muestra una línea adicional sobre el nombre del objeto con la calidad del objeto",
		descInfotext = "Muestra una línea adicional bajo el nombre del objeto con la información del objeto",
		descLinkAll = "El botón de Enlazar Todo, un botón que muestra un menú con todos los canales disponibles, permitiéndote enviar el contenido del botín a cualquiera de ellos.",
		descLinkAllVis = "Cuándo debe ser visible el botón de Enlazar Todo",
		descLinkAllThreshold = "Solo enlazar objetos mayores que el límite establecido.",
		descLinkAllChannels = "Siempre enlazar a estos canales cuando se hace clic en Enlazar Todo. |cFFFF0000Si no se ha seleccionado ninguno, al hacer clic en Enlazar Todo se mostrará el menú por defecto.|r",
		descAppearance = "Coloreado, escala y skin de la ventana de XLoot y cada botón de botín",
		descQualityborder = "Colorea el borde de la ventana de botín según el objeto de mayor calidad",
		descQualityframe = "Colorea el fondo de la ventana de botín según el objeto de mayor calidad",
		descLootqualityborder = "Colorea los bordes del botín según su calidad",
		descHighlightLoot = "Resalta cada ventana de botín según su calidad",
		descHighlightThreshold = "La calidad mínima a la que las ventanas de botín serán resaltadas",
		descBgcolor = "Cambia el color de fondo de la ventana de botín",
		descBordercolor = "Cambia el color del borde de la ventana de botín",
		descTexColor = "Colorea el borde del icono/textura del objeto actual según su calidad",
		descLootbgcolor = "Cambia el color de fondo para todos los objetos del botín",
		descLootbordercolor = "Cambia el color del borde para todos los objetos del botín",
		descInfoColor = "Cambia el color del texto de información",
		descScale = "Escala de la ventana de botín",
		descAdvanced = "Opciones con las que puede que no quieras trastear, pero puedes, de todos modos.",
		descDebug = "Muestra los mensajes de depuración",
		descDefaults = "Reestablece la base de datos que viene con XLoot y establece todas las opciones a sus valores por defecto",
		
		qualityQuest = "Misceláneo",
		
		["BoP"] = "BoP",
		["BoE"] = "BoE",
		["BoU"] = "BoU",
		
		guiTitle = "Opciones de XLoot",
		
		itemWeapon = "Arma",
		
		evHerbs = "Recolección de hierbas",
		evOpenNT = "",
		evOpen = "Abriendo",
		
		linkallloot = "Enlazar Todo...",
		linkallchanneldesc = "Enlaza el botín automáticamente en %s cuando haces clic en Enlazar Todo",
	}
end)