-- russian localization
-- credit to Dr. Jet Cheshirsky
local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate","ruRU")
if not L then return end

-- Spell names for Collector module
L["Mining"] = "Горное дело"
L["Fishing"] = "Рыбная ловля"
L["Herb Gathering"] = "Сбор трав"
L["Extract Gas"] = "Извлечение газа"
L["Herbalism"] = "Травничество"
L["Engineering"] = "Инженерное дело"
L["Opening"] = "Открывание"
L["Pick Lock"] = "Взлом замков"
-- Display module
L["GatherMate Pin Options"] = "Настройки точек GatherMate"
L["Delete: "] = "Удалить: "
L["Add this location to Cartographer_Waypoints"] = "Добавить эту локацию к точкам маршрута Cartographer"
L["Add this location to TomTom waypoints"] = "Добавить эту локацию к точкам маршрута TomTom"

L["Always show"] = "Всегда показывать"
L["Only with profession"] = "По наличию профессии"
L["Only while tracking"] = "Только при поиске"
L["Never show"] = "Не показывать"


-- Config modules
L["GatherMate"]=true
L["gathermate"]=true -- slash command
---- Display Filters tree
L["Display Settings"] = "Внешний вид"
------ General subtree
L["General"] = "Основные"
L["Show Databases"] = "Показать базы данных"
L["Selected databases are shown on both the World Map and Minimap."] = "Выбранные базы данных отображаются как на карте мира, так и на миникарте."
L["Show Mining Nodes"]="Поиск минералов"
L["Toggle showing mining nodes."]="Вкл/Выкл показ минералов."
L["Show Herbalism Nodes"]="Поиск трав"
L["Toggle showing herbalism nodes."]="Вкл/Выкл показ трав."
L["Show Fishing Nodes"]="Рыбные места"
L["Toggle showing fishing nodes."]="Вкл/Выкл показ рыбных мест."
L["Show Gas Clouds"]="Газовые облака"
L["Toggle showing gas clouds."]="Вкл/Выкл показ газовых облаков."
L["Show Treasure Nodes"]="Сокровища"
L["Toggle showing treasure nodes."]="Вкл/Выкл показ сокровищ."
L["Icons"] = "Иконки"
L["Control various aspects of node icons on both the World Map and Minimap."] = "Различные параметры отображения иконок на карте мира и миникарте"
L["Show Minimap Icons"]="Иконки на миникарте."
L["Toggle showing Minimap icons."]="Вкл/Выкл показ иконок на миникарте."
L["Show World Map Icons"]="Иконки на карте мира"
L["Toggle showing World Map icons."]="Вкл/Выкл показ иконок на карте мира."
L["Keybind to toggle Minimap Icons"] = "Привязка клавиши на отображение иконок"
L["Icon Scale"] = "Масштаб иконок"
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = "Позволяет выбрать масштаб иконок на карте мира и миникарте."
L["Icon Alpha"] = "Прозрачность иконок"
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = "Позволяет выбрать прозрачность иконок. Только на карте мира."
L["Miscellaneous"] = "Разное"
-- Cleanup subtree (now Database Maintenance)
L["Database Maintenance"] = "Обслуживание БД"
L["Cleanup_Desc"] = "Со временем, ваша база может неимоверно разрастись. Может помочь очистка базы, в процессе которой удаляются записи о нодах, находящихся слишком близко друг к другу, которые фактически являются одним и тем же нодом."
L["Cleanup radius"] = "Радиус очистки"
L["CLEANUP_RADIUS_DESC"] = "Радиус в ярдах, в пределах которого ноды считаются дупами и будут очищены. по умолчанию это |cffffd20050|r ярдов для Extract Gas и |cffffd20015|r ярдов для всего остального. Эти же настройки используются при добавлении новых нодов."
L["Cleanup Database"] = "Очистка БД"
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = "Очищаю вашу базу от дупов. Это займёт некоторое время, потерпите пожалуйста."
L["Processing "] = "В процессе "
L["Cleanup Complete."] = "Очистка закончена."
L["Delete Specific Nodes"] = "Удаляем специфические ноды"
L["DELETE_SPECIFIC_DESC"] = "Удаляет все выбранные ноды из выбранной зоны. Вы должны отключить Закрытие Базы чтобы это работало."
L["Select Database"] = "Выбрать БД"
L["Select Node"] = "Выбрать ноду"
L["Select Zone"] = "Выбрать зону"
L["Delete"] = "Удалить"
L["Delete selected node from selected zone"] = "Удалить выбранные ноды из выбранной зоны"
L["Are you sure you want to delete all of the selected node from the selected zone?"] = "Вы действительно хотите удалить все выбранные ноды из выбранной зоны?"
L["Delete Entire Database"] = "Удалить всю базу данных"
L["DELETE_ENTIRE_DESC"] = "Закрытие Базы будет проигнорировано и все ноды во всех зонах этой базы будут удалены."
L["Are you sure you want to delete all nodes from this database?"] = "Вы действительно хотите стереть все ноды из этой базы?"
L["Database Locking"] = "Закрытие базы"
L["DATABASE_LOCKING_DESC"] = "Закрытие базы данных даёт вам возможность заморозить её теккущее состояние. Ноды не будут добавляться, удаляться или изменяться. Это касается и операций очистки и импорта."
L["Database locking"] = "Закрытие базы"

-- Tracking options
L["Tracking Circle Color"] = "Цвет метки слежения"
L["Color of the tracking circle."] = "Задаёт цвет метки слежения"
L["Tracking Distance"] = "Радиус радара"
L["The distance in yards to a node before it turns into a tracking circle"] = "Расстояние в ярдах до ноды, на котором вокруг неё появится круг - метка слежения"
L["Show Tracking Circle"] = "Показать метку слежения"
L["Toggle showing the tracking circle."] = "Вкл/выкл отображение метки слежения"
L["Show Nodes on Minimap Border"] = "Ноды на границе миникарты"
L["Shows more Nodes that are currently out of range on the minimap's border."] = "Показывает ноды, фактически находящиеся ЗА границами миникарты."
------ Filters subtree
L["Filters"] = "Фильтры"
L["Herb filter"] = "Фильтр трав"
L["Select the herb nodes you wish to display."]="Выберите ноды трав для отображения"
L["Mine filter"] = "Фильтр руды"
L["Select the mining nodes you wish to display."] ="Выберите ноды руды для отображения"
L["Fish filter"] = "Фильтр рыбы"
L["Select the fish nodes you wish to display."] = "Выберите ноды рыбы для отображения"
L["Gas filter"] = "Фильтр газа"
L["Select the gas clouds you wish to display."] ="Выберите газовые облака для отображения"
L["Treasure filter"] = "Фильтр сокровищ"
L["Select the treasure you wish to display."] = "Выберите сокровища для отображения"
L["Select All"] = "Выбрать все"
L["Select all nodes"] = "Выбирает все ноды"
L["Clear node selections"] = "Отмена выбора нод"
L["Select None"] = "Отменить выбор"
L["Gas Clouds"]= "Газовые облака"
L["Fishes"] = "Рыбы"
L["Mineral Veins"] = "Рудные жилы"
L["Herb Bushes"] = "Травы"
L["Treasure"] = "Сокровища"
L["Filter_Desc"] = "Выберите типы нод, которые вы хотите видеть на карте мира и миникарте. Не выбранные ноды всё равно будут записываться в базу."
---- Import tree
L["Import Data"] = "Импорт данных"
L["Import GatherMateData"] = "Импортировать GatherMateData"
L["Importing_Desc"] = "Импортирование позволяет GatherMate получать данные нод из других источников помимо того, что вы сами находите в игре. После импотирования, вам возможно придётся провести операцию очистки."
L["Load GatherMateData and import the data to your database."] = "Загрузить GatherMateData и импортировать данные в вашу БД."
L["GatherMateData has been imported."] = "GatherMateData был импортирован."
L["Failed to load GatherMateData due to "] = "Не могу загрузить GatherMateData, по причине "
L["Merge"] = "Слить"
L["Overwrite"] = "Перезаписать"
L["Import Style"] = "Вид импорта"
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = "Слияние допишет данные GatherMateData в вашу базу данных. Перезапись заменит вашу базу данных на данные GatherMateData."
L["Databases to Import"] = "Базы для импортирования"
L["Databases you wish to import"] = "Базы, из которых вы хотите импортировать"
L["Auto Import"] = "Авто-импорт"
L["Automatically import when ever you update your data module, your current import choice will be used."] = "Автоматически импортирует при обновлении модуля данных, будут использованы текущие настройки."
L["Auto import complete for addon "] = "Завершено автоматическое импортирование для аддона"
L["BC Data Only"] = "Только данные БК"
L["Only import Burning Crusade data from WoWHead"] = "Импортировать только данные Burning Crusade с сайта WoWHead"
--- profile settings
L["Default"] = "Обычный"
L["Char:"] = "Перс:"
L["Realm:"] = "Мир:"
L["Class:"] = "Класс:"
L["Profiles"] = "Профили"
L["Manage Profiles"] = "Управление профилями"
L["You can change the active database profile of GatherMate, so you can have different settings and filters for every character, which will allow a very flexible configuration for everyones needs."] = "Вы можете изменить активный профиль базы данных GatherMate, так что у вас будут отдельные настройки и фильтры для каждого персонажа, что позволяет очень гибкую настройку для нужд любого игрока."
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = "Сбрасывает текущий профиль к настройкам по-умолчанию, если ваша конфигурация испорчена или вы хотите начать заново."
L["You can create a new profile by entering a new name in the editbox, or choosing one of the already exisiting profiles."] = "Вы можете создать новый профиль, введя новое имя в строку редактирования, или выбрав один из уже существующих профилей."
L["Reset Profile"] = "Сбросить профиль"
L["Reset the current profile to the default"] = "Сбрасывает текущий профиль к настройкам по умолчанию"
L["New"] = "Новый"
L["Create a new empty profile."] = "Создать новый пустой профиль."
L["Current"] = "Текущий"
L["Select one of your currently available profiles."] = "Выберите один из доступных профилей."
L["Copy the settings from one existing profile into the currently active profile."] = "Копирует настройки из одного из существующих профилей в активный профиль."
L["Copy From"] = "Копировать из"
L["Copy the settings from another profile into the active profile."] = "Копирует настройки из другого профиля в активный профиль."
L["Delete existing and unused profiles from the database to save space, and cleanup the GatherMate SavedVariables file."] = "Удаляет существующие, но неиспользованные профили из базы данных, чтобы сэкономить место и очистить файл GatherMate SavedVariables."
L["Delete a Profile"] = "Удалить профиль"
L["Deletes a profile from the database."] = "Удаляет профиль из вашей базы данных"
L["Are you sure you want to delete the selected profile?"] = "Вы действительно хотите удалить выбранный профиль?"
-- FAQ
L["FAQ"] = "ЧаВо"
L["Frequently Asked Questions"] = "Часто Задаваемые Вопросы"
L["FAQ_TEXT"] = [[
|cffffd200
Я только что поставил GatherMate, но на карте нет ни одной ноды. Что не так?
|r
GatherMate не поставляется вместе с данными. По мере того, как вы собираете травы, добываете полезные ископаемые или рыбачите, GatherMate будет добавлять новые записи на карту. Также, проверьте настройки Внешнего вида.

|cffffd200
Я вижу ноды на карте мира, но не вижу на миникарте! Теперь-то что не так?
|r
|cffffff78Minimap Button Bag|r (а возможно и другие аддоны) съедают все иконки, расположенные GatherMate-ом на миникарте. Выключите их.

|cffffd200
Как и где мне получить актуальную базу?
|r
Вы можете импортировать актуальную базу в GatherMate следующими способами:

1. |cffffff78GatherMate_Data|r - это LoD аддон содержит копию данных, добытых скриптами с WowHead (обновляется еженедельно). Есть опции автообновления

2. |cffffff78GatherMate_CartImport|r - Этот аддон позволяет вам импортировать модулей |cffffff78Cartographer_<Profession>|r в GatherMate. Чтобы заработало, и |cffffff78Cartographer_<Profession>|r modules и GatherMate_CartImport должны быть загружены и активны.

Заметьте, что импорт базы в GatherMate процесс не автоматический. Вам придётся самостоятельно залезть в раздел Импорт Данных и щелкнуть по кнопке "Импорт".

ОТличия от |cffffff78Cartographer_Data|r в том, что пользователю даётся выбор того, как и когда модифицировать данные, |cffffff78Cartographer_Data|r при загрузке просто перезапишет существующие базы без предупреждения и уничтожить все свеженайденные ноды.

|cffffd200
Вы можете добавить отображение локаций почтовых ящиков и мастеров полёта?
|r
Ответ - нет. Другой аддон или модуль от другого автора могут это сделать, ядро GatherMate этого делать не будет.

|cffffd200
Я нашёл баг! Куда слать багрепорт?
|r
Приём багов, жалоб и предложений - на |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r

Также можете найти нас на |cffffff78irc://irc.freenode.org/wowace|r

Когда сообщаете о баге, убедитесь, что описали |cffffff78алгоритм воспроизведения бага|r, предоставили все |cffffff78сообщения об ошибках|r с трассировкой стека, если это возможно, предоставили |cffffff78номер ревизии|r GatherMate, в которой произошла проблема и информацию о том, |cffffff78какую языковую версию клиента вы используете|r.

Примечание: баги русификации постить сюда: |cffffff78http://forums.playhard.ru/index.php?showtopic=27192|r, авторы аддона ей не занимаются.

|cffffd200
Кто написал эту прелесть?
|r
Kagaro, Xinhuan, Nevcairiel and Ammo (поддержка русского от Dr.Jet Cheshirsky)
]]

--[[
We have a second translation list to handle just nodes, this needs to be in REVERSE translation order since AceLocale-3.0 no longer supports reverse translations
]]
local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes","ruRU")
if not NL then return end
-- fish schools
NL["Floating Wreckage"] = "Плавающий мусор"
NL["Patch of Elemental Water"] = true -- нет данных
NL["Floating Debris"] = true -- нет данных
NL["Oil Spill"] = true -- нет данных
NL["Firefin Snapper School"] = "Косяк огнеперого снеппера"
NL["Greater Sagefish School"] = "Большой косяк шалфокуня"
NL["Oily Blackmouth School"] = "Косяк масляного черноротика"
NL["Sagefish School"] = "Косяк шалфокуня"
NL["School of Deviate Fish"] = "Косяк искаженной рыба"
NL["Stonescale Eel Swarm"] = true -- нет данных
--NL["Muddy Churning Water"] = true ZG only
NL["Highland Mixed School"] = "Смешанная школа Нагорья"
NL["Pure Water"] = "Чистая вода"
NL["Bluefish School"] = "Косяк луфаря"
NL["Feltail School"] = "Косяк сквернохвоста"
NL["Brackish Mixed School"] = true -- нет данных
NL["Mudfish School"] = "Косяк ильной рыбы"
NL["School of Darter"] = "Косяк змеешейки"
NL["Sporefish School"] = "Косяк спорорыбы"
NL["Steam Pump Flotsam"] = "Смытый в море паровой насос"
NL["School of Tastyfish"] = "Косяк вкуснорыбы"
-- mine nodes
NL["Copper Vein"] = "Медная жила"
NL["Tin Vein"] = "Оловянная Жила"
NL["Iron Deposit"] = "Залежи железа"
NL["Silver Vein"] = "Серебряная жила"
NL["Gold Vein"] = "Золотая жила"
NL["Mithril Deposit"] = "Мифриловые залежи"
NL["Ooze Covered Mithril Deposit"] = "Покрытые слизью мифриловые залежи"
NL["Truesilver Deposit"] = "Залежи истинного серебра"
NL["Ooze Covered Silver Vein"] = "Покрытая слизью серебрянная жила"
NL["Ooze Covered Gold Vein"] = "Покрытая слизью золотая жила"
NL["Ooze Covered Truesilver Deposit"] = "Покрытые слизью залежи истинного серебра"
NL["Ooze Covered Rich Thorium Vein"] = "Покрытая слизью богатая ториевая жила"
NL["Ooze Covered Thorium Vein"] = "Покрытая слизью ториевая жила"
NL["Small Thorium Vein"] = "Малая ториевая жила"
NL["Rich Thorium Vein"] = "Богатая ториевая жила"
--NL["Hakkari Thorium Vein"] = true ZG only
NL["Dark Iron Deposit"] = "Залежи Темной Стали"
NL["Lesser Bloodstone Deposit"] = "Малое месторождение кровавого камня"
NL["Incendicite Mineral Vein"] = "Ароматитовая жила"
NL["Indurium Mineral Vein"] = "Индарилиевая жила"
NL["Fel Iron Deposit"] = "Месторождение оскверненного железа"
NL["Adamantite Deposit"] = "Залежи адамантита"
NL["Rich Adamantite Deposit"] = "Богатые залежи адамантита"
NL["Khorium Vein"] = "Кориевая жила"
--NL["Large Obsidian Chunk"] = true AQ 40
--NL["Small Obsidian Chunk"] = true AQ 20/40
NL["Nethercite Deposit"] = "Месторождение хаотита"

-- gas clouds
NL["Windy Cloud"] = "Грозовое облако"
NL["Swamp Gas"] = "Болотный газ"
NL["Arcane Vortex"] = "Волбшебное завихрение"
NL["Felmist"] = "Туман Скверны"
NL["Steam Cloud"] = "Steam Cloud"
NL["Cinder Cloud"] = "Cinder Cloud"
NL["Arctic Cloud"] = "Arctic Cloud"

-- herb bushes
NL["Peacebloom"] = "Мироцвет"
NL["Silverleaf"] = "Сребролист"
NL["Earthroot"] = "Землекорень"
NL["Mageroyal"] = "Магороза"
NL["Briarthorn"] = "Остротерн"
--NL["Swiftthistle"] = true found in other sources
NL["Stranglekelp"] = "Удавник"
NL["Bruiseweed"] = "Синячник"
NL["Wild Steelbloom"] = "Дикий сталецвет"
NL["Grave Moss"] = "Могильный мох"
NL["Kingsblood"] = "Королевская кровь"
NL["Liferoot"] = "Жизнекорень"
NL["Fadeleaf"] = "Бледнолист"
NL["Goldthorn"] = "Златошип"
NL["Khadgar's Whisker"] = "Кадгаров ус"
NL["Wintersbite"] = "Зимник"
NL["Firebloom"] = "Огненный Цветок"
NL["Purple Lotus"] = "Пурпурный лотос"
--NL["Wildvine"] = true found in purple lotus
NL["Arthas' Tears"] = "Слезы Артаса"
NL["Sungrass"] = "Солнечник"
NL["Blindweed"] = "Слепырник"
NL["Ghost Mushroom"] = "Призрачная поганка"
NL["Gromsblood"] = "Кровь Грома"
NL["Golden Sansam"] = "Золотой сансам"
NL["Dreamfoil"] = "Снолист"
NL["Mountain Silversage"] = "Горный серебряный шалфей"
NL["Plaguebloom"] = "Чумоцвет"
NL["Icecap"] = "Льдяник"
--NL["Bloodvine"] = true ZG only not needed atm
NL["Black Lotus"] = "Черный лотос"
NL["Felweed"] = "Скверноплевел"
NL["Dreaming Glory"] = "Соннославник"
NL["Terocone"] = "Терошишка"
--NL["Ancient Lichen"] = true instance only
NL["Bloodthistle"] =  "Кровопийка"
NL["Mana Thistle"] = "Манрепейник"
NL["Netherbloom"] = "Пустоцвет"
NL["Nightmare Vine"] = "Лозный кошмарник"
NL["Ragveil"] = "Кисейница"
NL["Flame Cap"] = "Огнеголовик"
NL["Netherdust Bush"] = "Пыльник хаотический"
-- Treasure
NL["Giant Clam"] = "Гигантский моллюск"
NL["Battered Chest"] = "Побитый сундук"
NL["Tattered Chest"] = "Побитый сундук"
NL["Solid Chest"] = "Добротный сундук"
NL["Large Iron Bound Chest"] = "Большой сундук, окованный железом"
NL["Large Solid Chest"] = "Большой добротный сундук"
NL["Large Battered Chest"] = "Большой побитый сундук"
NL["Buccaneer's Strongbox"] = "Сейф буканьера"
NL["Large Mithril Bound Chest"] = "Большой сундук, окованный мифрилом"
NL["Large Darkwood Chest"] = true -- нет данных
NL["Un'Goro Dirt Pile"] = "Куча грязи из Ун'Горо"
NL["Bloodpetal Sprout"] = "Побег кровоцвета"
NL["Blood of Heroes"] = "Кровь Героев"
NL["Practice Lockbox"] = "Учебный денежный ящик"
NL["Battered Footlocker"] = "Побитый сундучок"
NL["Waterlogged Footlocker"] = "Затопленный сундучок"
NL["Dented Footlocker"] = "Проломленный сундучок"
NL["Mossy Footlocker"] = "Замшелый сундучок"
NL["Scarlet Footlocker"] = true -- нет данных
NL["Burial Chest"] = "Погребальный сундук"
NL["Fel Iron Chest"] = "Сундук из оскверненного железа"
NL["Heavy Fel Iron Chest"] = "Тяжелый Сундук из оскверненного железа"
NL["Adamantite Bound Chest"] = "Сундук, окованный адамантитом"
NL["Felsteel Chest"] = true -- нет данных
NL["Glowcap"] = "Пламеневик"
NL["Wicker Chest"] = "Ларец из лозы"
NL["Primitive Chest"] = "Примитивный сундук"
NL["Solid Fel Iron Chest"] = true -- нет данных
NL["Bound Fel Iron Chest"] = true -- нет данных
-- NL["Bound Adamantite Chest"] = true -- Only appears in instances, also has conflicting reverse lookup issues
NL["Netherwing Egg"] = "Яйцо дракона из стаи Крыльев Пустоты"
