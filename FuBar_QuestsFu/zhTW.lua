local L = AceLibrary("AceLocale-2.2"):new("QuestsFu")

L:RegisterTranslations("zhTW", function() return {
	["(done)"] = "(完成)",
	["(failed)"] = "(失敗)",

	["Toggle whether the %s module is active"] = "切換%s模組是否啟用",
	["Modules"] = "模組",
-- duplicated entry	["Toggle whether the %s module is active"] = true,

	["Strata"] = "層級",
	["Adjust the strata of this panel (takes effect after you reload your UI)"] = "調整框架顯示層級 (需要重載使用者介面)",
	["Max height"] = "最大高度",
	["Adjust the maximum height of this panel, in pixels (takes effect after you reload your UI)"] = "調整框架的最大高度 (需要重載使用者介面)",
	["Minimum width"] = "最大寬度",
	["Adjust the minimum width of this panel, in pixels (takes effect after you reload your UI)"] = "調整框架的最大寬度 (需要重載使用者介面)",
	['BACKGROUND'] = "背景",
	['LOW'] = "低",
	['MEDIUM'] = "中",
	['HIGH'] = "高",

	["Lock"] = "鎖定",
	["Lock or unlock this panel"] = "鎖定或解鎖本框架",

	TOOLTIP_HINT = "\n|cffeda55f左擊: |r打開任務日誌。\n|cffeda55fShift-左擊: |r往聊天輸入框發送任務名稱。\n|cffeda55fShift-Ctrl-左擊: |r往聊天輸入框發送任務目標。\n|cffeda55fAlt-左擊: |r追蹤任務。",
	["FuBar Tablet"] = "FuBar 提示訊息",
	["Settings for the main FuBar tablet"] = "設定 FuBar 提示訊息",
	["Show"] = "顯示",
	["Choose what information to display"] = "選擇要顯示的資訊",
	["Text"] = "FuBar 文字",
	["Toolbar text"] = "FuBar 文字",
	["Current"] = "當前",
	["Show current # of quests"] = "顯示當前任務數目",
	["Completed"] = "已完成",
	["Show # of quests completed"] = "顯示已完成任務數目",
	["Total"] = "全部",
	["Show total possible quests"] = "顯示全部任務數目",
	["Last message"] = "最後任務資訊",
	["Show last quest status message"] = "顯示最後一個任務的狀態資訊",
	["Levels"] = "等級",
	["Show quest levels"] = "顯示任務等級",
	["In QuestsFu"] = "於 QuestsFu",
	["Show quest levels in the QuestsFu tooltip"] = "在 QuestsFu 的提示訊息中顯示任務等級",
	["Zone"] = "區域",
	["Show zone levels in the QuestsFu tooltip"] = "在 QuestsFu 的提示訊息中顯示區域等級",
	["Impossible quests"] = "超級困難任務",
	["Show impossible (red) quests"] = "顯示超級困難 (紅色) 任務",
	["Show quest zones"] = "顯示任務區域",
	["Current area only"] = "僅當前區域任務",
	["Only show quests for the current zone"] = "只顯示當前區域的任務",
	["Class quests always"] = "始終顯示職業任務",
	["Always show class quests"] = "始終顯示職業任務",
	["Details"] = "詳情",
	["Show quest details"] = "顯示任務詳情",
	["Current area details only"] = "僅當前區域任務詳情",
	["Show details for current area quests only"] = "只顯示當前區域的任務詳情",
	["Completed objectives"] = "已完成目標",
	["Show completed objectives"] = "顯示已完成目標",
	["Objectives"] = "目標完成狀態顏色",
	["Color objective completion status"] = "任務目標完成狀態顏色顯示",
	["Wrap quest titles"] = "標題自動換行",
	["Wrap long quest titles on to multiple lines"] = "對過長的任務標題自動換行",

	["Color zone names by suggested level"] = "依照建議等級上色區域名稱",
	["Color"] = "顏色",
	["Color settings"] = "顏色設定",
	["Title"] = "標題",
	["Color the quest title by difficulty"] = "依照困難度上色標題",
	["Level"] = "等級",
	["Color the quest level by difficulty"] = "依照困難度上色等級",
	
	["Colors"] = "顏色",
	["Choose custom colors"] = "選擇自訂的顏色",
	["Difficulty"] = "困難度",
	["Trivial"] = "非常容易",
	["Standard"] = "普通",
	["Difficult"] = "困難",
	["Very difficult"] = "非常困難",
	["Impossible"] = "超級困難",
	["Header"] = "標題",
	["Completion"] = "完成度",
	["Not started"] = "尚未開始",
	["Underway"] = "正在進行",
	["Done"] = "完成",
	["Other"] = "其他",
} end)
