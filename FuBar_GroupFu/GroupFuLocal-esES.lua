local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("esES", function() return {
	["Solo"] = "Solo",
	group = "Grupo",
	master = "Maestro despojador",
	freeforall = "Modo libre",
	roundrobin = "Equitativo",
	needbeforegreed = "Necesidad antes que codicia",
	["ML (%s)"] = "MD (%s)",
	["No rolls"] = "Sin tiradas",

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = "Las tiradas finalizan en 5 segundo, registrada(s) %d de %d tiradas.",

	["Winner: %s."] = "Ganador: %s",
	["Tie: %s are tied at %d."] = "Empate: %s han empatado a %d",
	["%s (%d/%d)"] = "%s (%d/%d)",
	["%s [%s]"] = "%s [%s]",
	["%d of expected %d rolls recorded."] = "%d de las %d tiradas esperadas registradas",

	["Perform roll when clicked"] = "Realizar una tirada cuando se hace clic",
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = "Realiza una tirada estándar de 1-100 cuando se hace clic en el plugin de FuBar",
	["Announce"] = "Anunciar",
	["Only accept 1-100"] = "Aceptar sólo 1-100",
	["Accept standard (1-100) rolls only."] = "Sólo acepta tiradas estándar (1-100)",
	["Loot type"] = "Tipo de botín",
	["Set the loot type."] = "Establece el tipo de botín",
	["Loot threshold"] = "Límite de botín",
	["Set the loot threshold."] = "Establece el límite del botín",

	["Where to output roll results."] = "Dónde mostrar los resultados de las tiradas",
	["Auto (based on group type)"] = "Automático (basado en el tipo de grupo)",
	["Local"] = "Local",
	["Say"] = "Decir",
	["Party"] = "Grupo",
	["Raid"] = "Banda",
	["Guild"] = "Hermandad",
	["Don't announce"] = "No anunciar",

	["Roll clearing"] = "Limpiar tiradas",
	["When to clear the rolls."] = "Cuándo limpiar las tiradas",
	["Never"] = "Nunca",
	["15 seconds"] = "15 segundos",
	["30 seconds"] = "30 segundos",
	["45 seconds"] = "45 segundos",
	["60 seconds"] = "60 segundos",

	["Roll"] = "Tirar",
	["Player"] = "Jugador",
	["Loot method"] = "Método de botín",
	["Master looter"] = "Maestro despojador",
	["Leader"] = "Líder",
	["Officers"] = "Oficiales",
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fClic|r para tirar, |cffeda55fCtrl-Clic|r para mostrar ganador, |cffeda55fMayúsculas-Clic|r para limpiar la lista.",
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fCtrl-Clic|r para mostrar ganador, |cffeda55fMayúsculas-Clic|r para limpiar la lista.",

	["Pass"] = "Pasar",
	["Everyone passed."] = "Todo el mundo ha pasado.",

	--["Leave Party"] = true,
	--["Leave your current party or raid."] = true,

	--["Reset Instances"] = true,
	--["Reset all available instance the group leader has active."] = true,
} end)

