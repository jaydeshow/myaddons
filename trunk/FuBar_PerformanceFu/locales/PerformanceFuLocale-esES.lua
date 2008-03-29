local L = AceLibrary("AceLocale-2.2"):new("FuBar_PerformanceFu")

L:RegisterTranslations("esES", function() return {
	scriptProfiling = "Tienes activado el registro de CPU.\n\nTen en cuenta que cuando lo ejecutas con bibliotecas incrustadas en tus accesorios su uso de CPU y memoria se mostrará como perteneciente a ese accesorio, lo que no es totalmente cierto si usas otros accesorios que usan las mismas bibliotecas.",
	["Never show this message again."] = "No volver a mostrar este mensaje.",

	["Force garbage collection"] = "Forzar recogida de basura",
	["Force a garbage collection to happen right now, clearing up unused memory."] = "Fuerza una recogida de basura ahora mismo, limpiando la memoria no usada",

	["Enable CPU profiling"] = "Activar registro de CPU",
	["Toggles CPU profiling. Note that this will reload your user interface."] = "Activa el registro de CPU. Esto recargará tu interfaz de usuario",

	-- Text options
	["Text"] = "Texto",

	["Show framerate"] = "Mostrar velocidad de imágenes",
	["Toggle whether to show the current frames per second."] = "Muestra tus imágenes por segundo actuales",

	["Show latency"] = "Mostrar latencia",
	["Toggle whether to show latency (lag)."] = "Muestra la latencia (lag)",

	["Show memory usage"] = "Mostrar uso de memoria",
	["Toggle whether to show memory usage."] = "Muestra el uso de memoria",

	["Show increasing rate"] = "Mostrar tasa de incremento",
	["Toggle whether to show increasing rate of memory usage."] = "Muestra la tasa de incremento del uso de memoria",

	-- Tooltip options
	["Tooltip"] = "Tooltip",

	["Number of addons"] = "Cantidad de accesorios",
	["Set the number of addons to list in the tooltip."] = "Establece la cantidad de accesorios a mostrar en el tooltip",

	["Show addon usage"] = "Mostrar uso de accesorios",
	["Show addon memory and CPU usage in the tooltip."] = "Muestra en el tooltip el uso de memoria y CPU de los accesorios",

	["Show network usage"] = "Mostrar uso de red",
	["Show latency and bandwidth in the tooltip."] = "Muestra en el tooltip la latencia y el ancho de banda",

	["Sort addons by"] = "Ordenar accesorios por",
	["Set what to sort the addon list by."] = "Determina cómo se ordenan la lista de accesorios",
	["Total CPU"] = "CPU total",
	["Memory"] = "Memoria",
	["CPU per second"] = "CPU por segundo",

	-- Tooltip strings
	["Framerate"] = "Velocidad de imágenes",
	["Network status"] = "Estado de la red",
	["Latency"] = "Latencia",
	["Bandwidth in"] = "Ancho de banda entrante",
	["Bandwidth out"] = "Ancho de banda saliente",
	["Memory usage"] = "Uso de memoria",
	["Current memory"] = "Memoria actual",
	["Initial memory"] = "Memoria inicial",
	["Increasing rate"] = "Tasa de incremento",
	["Average increasing rate"] = "Promedio de tasa de incremento",
	["Addon memory usage"] = "Uso de memoria de accesorios",
	["Total addon memory"] = "Memoria total de accesorios",
	["Addon memory/CPU usage"] = "Uso de memoria/CPU de accesorios",
	["Total addon CPU usage"] = "Uso de CPU total de accesorios",
	--["Last garbage collect"] = true,

	["Hint"] = "Haz clic para forzar una recogida de basura.",
} end)
