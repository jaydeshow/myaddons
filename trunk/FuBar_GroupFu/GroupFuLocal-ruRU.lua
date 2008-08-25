--ruRU by Star_Hobbit
local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("ruRU", function() return {
	["Solo"] = "Один",
	group = "Группа",
	master = "Ответственный за добычу",
	freeforall = "Каждый за себя",
	roundrobin = "По очереди",
	needbeforegreed = "Приоритет по нужности",
	["ML (%s)"] = "МЛ (%s)",
	["No rolls"] = "Ни кто не бросал",

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = "Roll закончился через 5 секунд, записано %d из %d бросаний.",

	["Winner: %s."] = "Победитель: %s.",
	[", "] = ", ",
	["Tie: %s are tied at %d."] = "Поровну: %s выкинули по %d.",
	["%s (%d/%d)"] = "%s (%d/%d)",
	["%s [%s]"] = "%s [%s]",
	["%d of expected %d rolls recorded."] = "%d из ожидаемых %d бросаний записаны.",

	["Perform roll when clicked"] = "Бросить кости, при нажатии",
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = "Начать стандартный 1-100 ролл при клике на FuBar плагин.",
	["Announce"] = "Объявление",
	["Only accept 1-100"] = "Принимать только 1-100",
	["Accept standard (1-100) rolls only."] = "Принемаются только стандартные броски (1-100)",
	["Loot type"] = "Обыск",
	["Set the loot type."] = "Установить тип обыска",
	["Loot threshold"] = "Качество добычи",
	["Set the loot threshold."] = "Установить качество добычи",

	["Where to output roll results."] = "Куда выводить результаты бросков",
	["Auto (based on group type)"] = "Автоматически (как при групповой очереди)",
	["Local"] = "Локально",
	["Say"] = "Сказать",
	["Party"] = "Группа",
	["Raid"] = "Рейд",
	["Guild"] = "Гильдия",
	["Don't announce"] = "Не объявлять",

	["Roll clearing"] = "Очистить броски",
	["When to clear the rolls."] = "Когда очистить броски",
	["Never"] = "Никогда",
	["15 seconds"] = "15 сек.",
	["30 seconds"] = "30 сек.",
	["45 seconds"] = "45 сек.",
	["60 seconds"] = "60 сек.",

	["Roll"] = "Число",
	["Player"] = "Игрок",
	["Loot method"] = "Метод добычи",
	["Master looter"] = "Ответственный за добычу",
	["Leader"] = "Лидер",
	["Officers"] = "Оффицеры",
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fClick|r для броска, |cffeda55fCtrl-Click|r для показа победителя, |cffeda55fShift-Click|r для очистки бросков.",
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fCtrl-Click|r для показа победителя, |cffeda55fShift-Click|r для очитски бросков.",

	["Pass"] = "Отказаться",
	["Everyone passed."] = "Все отказались",
	
	["Leave Party"] = "Покинуть группу",
	["Leave your current party or raid."] = "Покинуть вашу группу или рейд",
	
	["Reset Instances"] = "Обновить все зоны-инстансы",
	["Reset all available instance the group leader has active."] = "Обновить все зоны-инстансы, активные у лидера.",
	
} end)

