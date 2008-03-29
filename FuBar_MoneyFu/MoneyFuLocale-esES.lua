local L = AceLibrary("AceLocale-2.2"):new("MoneyFu")

L:RegisterTranslations("esES", function() return {
	["NAME"] = "FuBar - MoneyFu",
	["DESCRIPTION"] = "Informa sobre tu dinero actual y el del resto de tus personajes en un reino.",
	["COMMANDS"] = {"/monfu", "/moneyfu"},
	["TEXT_TOTAL"] = "Total",
	["TEXT_SESSION_RESET"] = "Reiniciar Sesi\195\179n",
	["TEXT_THIS_SESSION"] = "Esta sesi\195\179n",
	["TEXT_GAINED"] = "Ganado",
	["TEXT_SPENT"] = "Gastado",
	["TEXT_AMOUNT"] = "Cantidad",
	["TEXT_PER_HOUR"] = "Por hora",
	["This Week"] = "Esta Semana", 


	["ARGUMENT_RESETSESSION"] = "resetSession",

	["MENU_RESET_SESSION"] = "Reiniciar Sesi\195\179n",
	["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "Mostrar el dinero de este personaje en particular",
	["MENU_PURGE"] = "Purgar",
	["MENU_SHOW_GRAPHICAL"] = "Mostrar con monedas",
	["MENU_SHOW_FULL"] = "Mostrar estilo completo",
	["MENU_SHOW_SHORT"] = "Mostrar estilo abreviado",
	["MENU_SHOW_CONDENSED"] = "Mostrar estilo condensado",
	["SIMPLIFIED_TOOLTIP"] = "Tooltip simplificado",
	["SHOW_PER_HOUR_CASHFLOW"] = "Mostrar flujo de dinero por hora",

	["TEXT_SESSION_RESET"] = "Sesi\195\179n reiniciada.",
	["TEXT_CHARACTERS"] = "Personajes",
	["TEXT_PROFIT"] = "Beneficio",
	["TEXT_LOSS"] = "P\195\169rdida",

	["HINT"] = "Clic para coger dinero"
} end)
