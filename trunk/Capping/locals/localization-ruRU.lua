if GetLocale() ~= "ruRU" then return end

-- de translations provided by Farook
CappingLocale:CreateLocaleTable({
	-- battlegrounds
	["Alterac Valley"] = "Альтеракская долина",
	["Arathi Basin"] = "Низина Арати",
	["Warsong Gulch"] = "Ущелье Песни Войны",
	["Arena"] = "Арена",
	["Eye of the Storm"] = "Око Бури",

	-- factions
	["Alliance"] = "Альянс",
	["Horde"] = "Орда",

	-- options menu
	["Auto quest turnins"] = "Авто сдача квестов",
	["Bar"] = "Полоса",
	["Width"] = "Ширина",
	["Height"] = "Высота",
	["Texture"] = "Текстура",
	["Other"] = "Другое",
	["Other options"] = "Другие Опции",
	["Auto show map"] = "Автоматически показывать карту",
	["Map scale"] = "Масштаб карты",
	["Hide border"] = "Скрыть кромку",
	["Port Timer"] = "Время телепортации",
	["Wait Timer"] = "Время ожидания",
	["Show/Hide Anchor"] = "Показать/скрыть якорёк",
	["Narrow map mode"] = "Обрезанная карта",
	["Test"] = "Тест",
	["Flip growth"] = "Перевернуть",
	["Reposition Scoreboard"] = "Переместить табло",
	["Battlefield Minimap"] = "Миникарта поля боя",
	["Icons"] = "Иконки",
	["Spacing"] = "Расстояние",
	["Request sync"] = "Запросить синхронизацию",
	["LEFT"] = "СЛЕВА",
	["RIGHT"] = "СПРАВА",
	["HIDE"] = "СКРЫТЬ",
	["Fill grow"] = "Заполнять выростая",
	["Fill right"] = "Заполнять направо",
	["Font"] = "Шрифт",
	["Time position"] = "Расположение времени",
	["Border width"] = "Ширина кромки",
	["Send to BG"] = "Писать в BG",
	["Or <Ctrl-left-click> a timer"] = "...или <Ctrl-левый-клик> по Таймеру",
	["Send to SAY"] = "Писать в SAY",
	["Or <Shift-left-click> a timer"] = "...или <Shift-левый-клик> по таймеру",
	["Cancel timer"] = "Отменить Таймер",
	["Or <Ctrl-right-click> a timer"] = "...или <Ctrl-правый-клик> по Таймеру",
	["Reposition Capture Bar"] = "Переместить Таймер Захвата",

	-- etc timers
	["Port: %s"] = "На БГ: %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "Очередь: %s",
	["Battleground Begins"] = "Начало сражения", -- bar text for bg gates opening
	["2 minutes"] = "2 Минуты",
	["1 minute"] = "Минуту",
	["30 seconds"] = "30 Секунд",
	["One minute until"] = "Одна минута до",
	["Thirty seconds until"] = "через 30 секунд",
	["Fifteen seconds until"] = "Пятнадцать секунд до",
	["%s: %s - %d:%02d remaining"] = "%s: %s - через %d:%02d", -- chat message after shift left-clicking a bar

	-- AB
	["Bases: (%d+)  Resources: (%d+)/2000"] = "Базы: (%d+) Ресурсы: (%d+)/2000", -- arathi basin scoreboard
	["Farm"] = "Ферм",
	["Lumber Mill"] = "Лесопилк",
	["Blacksmith"] = "Кузниц",
	["Gold Mine"] = "Золотой рудник",
	["Stables"] = "Стойла",
	["Southern Farm"] = "Южная Ферма",
	["Mine"] = "Рудник",
	["has assaulted"] = "штурмует",
	["claims the"] = "через 1 минуту",
	["has taken the"] = "захватил",
	["has defended the"] = "отразил",
	["Final: 2000 - %d"] = "Финал: 2000 - %d", -- final score text
	["wins 2000-%d"] = "выиграет 2000-%d", -- final score chat message

	-- WSG
	["was picked up by (.+)!"] = "(.+) несет флаг",
	["dropped"] = "уронил",
	["captured the"] = "захватил",
	["Flag respawns"] = "Появление Флагов",
	["%s's flag carrier: %s (%s)"] = "%s Флагоносец: %s (%s)",

	-- AV
	 -- NPC
	["Smith Regzar"] = "Кузнец Регзар",
	["Murgot Deepforge"] = "Мургот Подземная Кузня",
	["Primalist Thurloga"] = "Старейшина Турлога",  -- same as default
	["Arch Druid Renferal"] = "Верховный друид Дикая Лань",
	["Stormpike Ram Rider Commander"] = "Командир наездников на баранах из клана Грозовой Вершины",
	["Frostwolf Wolf Rider Commander"] = "Командир наездников на волках из клана Северного Волка",

	 -- patterns
	["avunderattack"] = "На (.+) напали! Если",
	["avunderattack2"] = "(.+) атаковано! Если",
	["avtaken"] = "(.+) захвачен",
	["avdestroyed"] = "(.+) разрушен",
	["Snowfall Graveyard"] = "Кладбище Снегопада",
	["Tower"] = "башня",
	["Bunker"] = "оплот",
	["Upgrade to"] = true, -- the option to upgrade units in AV
	["Wicked, wicked, mortals!"] = true, -- what Ivus says after being summoned
	["Ivus begins moving"] = true,
	["WHO DARES SUMMON LOKHOLAR"] = true, -- what Lok says after being summoned
	["The Ice Lord has arrived!"] = true,
	["Lokholar begins moving"] = true,


	-- EotS
	["^(.+) has taken the flag!"] = "^(.+) захватывает флаг!",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "Базы: (%d+)  Очки победы: (%d+)/2000",
})