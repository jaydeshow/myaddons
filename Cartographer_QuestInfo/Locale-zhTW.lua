local L = AceLibrary("AceLocale-2.2"):new("Cartographer_QuestInfo");

L:RegisterTranslations("zhTW", function() return {

	["Quest Event"] = "任務事件",
	["Quest Monster"] = "任務怪物",
	["Quest Item"] = "任務物品",
	["Quest Object"] = "任務物件",
	["Quest Objective"] = "任務目標",
	["Quest Start"] = "任務開始",
	["Quest End"] = "任務結束",
	["Export"] = "匯出資料",
	["Export quest data to other addon."] = "匯出任務資料到別的插件模組。",
	["Export to QuestObjectives"] = "匯出至任務目標",
	["Export quest data to Cartographer QuestObjectives, this will take huge space."] = "匯出資料給任務目標模組，這會佔據很大空間。",
	["Remove from QuestObjectives"] = "移除匯出的資料",
	["Remove exported data from Cartographer QuestObjectives."] = "將匯出的資料自任務目標模組中移除。",
	["Icon style"] = "圖示樣式",
	["Style of the icon."] = "地圖上圖示的樣式",
	["Default"] = "預設", 
	["Object"] = "物件", 
	["Mark"] = "標誌",
	["Icon alpha"] = "圖示透明度",
	["Alpha transparency of the icon."] = "地圖上的圖示透明度。",
	["Icon size"] = "圖示大小",
	["Size of the icons on the map."] = "地圖上的圖示大小。",
	["Show minimap icons"] = "在小地圖上顯示",
	["Show quest icons on the minimap."] = "在小地圖上顯示任務圖示。",
	["Show world map button"] = "顯示設定按鈕",
	["Show button on the world map."] = "在世界地圖上顯示'任務資訊'的設定按鈕。",
	["Quest Info"] = "任務資訊",
	["Module description"] = "提供任務資料",
	["Show active quests"] = "標示目前任務",
	["Show all info of active quests in current map."] = "在目前地圖上標示進行中的任務目標。",
	["Show available quests"] = "標示可接的任務",
	["Show the givers of available quests in current map."] = "在目前地圖上標示可接的任務委託人。",
	["Clear quest icons"] = "清除任務圖示",
	["Clear quest icons generated by QuestInfo"] = "清除由任務資訊所產生的圖示。",
	["Open QuestInfo menu"] = "開啟任務資訊選項",
	["Clear old exported data first."] = "首先清除舊有匯出的任務資料。",
	["Begin export new quest data."] = "開始重新匯出任務資料。",
	["Total %d quest objects have been exported."] = "總計匯出 %d 個任務物件。",
	["legacy-data"] = { "任務資料庫", "任務分享庫" },
	["objective-filter"] = "^已殺死(.+)$",
	[":.+$"] = ":.+$",
	["... more"] = "... 還有更多",
	["Close"] = "關閉",
	["Objective:"] = "目標:",
	["Name:"] = "名稱:",
	["Source:"] = "來源:",
	["Location:"] = "座標:",

} end)
