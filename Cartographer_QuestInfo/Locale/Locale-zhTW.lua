local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Cartographer_QuestInfo")

L:AddTranslations("zhTW", function() return {

-- Core.lua
	["Export"] = "匯出資料",
	["Export quest data to other addon."] = "匯出任務資料到別的插件模組。",
	["Quests"] = "任務起始",
	["Export quest data to Cartographer Quests."] = "匯出任務資料到「任務起始」模組。",
	["Export data"] = "匯出任務資料",
	["Export quest data, this will take huge space."] = "匯出任務資料，這將會佔用很大的記憶體空間。",
	["Clear exported data"] = "清除已匯出資料",
	["Clear exported data."] = "清除已匯出資料。",
	["Quest Objectives"] = "任務目標",
	["Export quest data to Cartographer QuestObjectives."] = "匯出任務資料到「任務目標」模組。",
	["Icon alpha"] = "圖示透明度",
	["Alpha transparency of the icon."] = "地圖上的圖示透明度。",
	["Icon size"] = "圖示大小",
	["Size of the icons on the map."] = "地圖上的圖示大小。",
	["Show minimap icons"] = "在小地圖上顯示",
	["Show quest icons on the minimap."] = "在小地圖上顯示任務圖示。",
	["Show world map button"] = "顯示'任務資訊'按鈕",
	["Show button on the world map."] = "在世界地圖上顯示'任務資訊'的設定按鈕。",
	["Make quest log double wide"] = "加寬任務視窗",
	["Make the quest log window double wide, this will require UI reload."] = "加寬顯示任務視窗，注意:這功能需要重載UI後才能改變。",
	["Quest Info"] = "任務資訊",
	["Module description"] = "提供任務資料",
	["Exporting %d quest givers..."] = "已匯出 %d 個任務起始點...",
	["Total %d quest givers have been exported."] = "總計匯出 %d 個任務起始點。",
	["Clear old exported quest givers first."] = "首先清除舊的任務起始點。",
	["Begin exporting new quest givers."] = "開始匯出新的任務起始點。",
	["Exporting %d quest objects..."] = "已匯出 %d 個任務目標...",
	["Total %d quest objects have been exported."] = "總計匯出 %d 個任務目標。",
	["Clear old exported objectives first."] = "首先清除舊的任務目標。",
	["Begin exporting new quest objectives."] = "開始匯出新的任務目標。",

-- LocationFrame.lua
	["Close"] = "關閉",

-- Map.lua
	["Quest Start"] = "任務開始",
	["Quest End"] = "任務結束",
	["Quest Giver"] = "任務委託人",
	["Quest Objective"] = "任務目標",
	["Show active quests"] = "標示目前任務",
	["Show all info of active quests in current map."] = "在目前地圖上標示進行中的任務目標。",
	["Show available quests"] = "標示可接的任務",
	["Show the givers of available quests in current map."] = "在目前地圖上標示可接的任務委託人。",
	["Clear quest icons"] = "清除任務圖示",
	["Clear quest icons generated by QuestInfo"] = "清除由任務資訊所產生的圖示。",
	["Open QuestInfo menu"] = "開啟任務資訊選項",
	["Alt-Click: "] = "Alt-點擊: ",
	["Shift-Click: "] = "Shift-點擊: ",
	["Elite"] = "精英",
	["Rare Elite"] = "稀有精英",
	["Boss"] = "首領",
	["Name:"] = "名稱:",
	["Objective:"] = "目標:",
	["Source:"] = "來源:",
	["Level:"] = "等級:",
	["Location:"] = "座標:",
	["Quests:"] = "任務:",
	["%d Quests"] = "%d個任務",

-- QuestFuPatch.lua
	["(done)"] = "(完成)",

-- QuestLogPatch.lua
	[" ..."] = " …",
	["... more"] = "… 還有更多",

-- SeriesFrame.lua
	["Quest Series"] = "系列任務",
	["Requires:"] = "需要等級:",
	["Sharable"] = "可分享",
	["Series:"] = "任務系列:",

} end)
