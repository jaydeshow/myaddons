--[[
	Chinese Local : CWDG Translation Team 昏睡墨鱼 (Thomas Mo)
	CWDG site: http://Cwowaddon.com
	$Rev: 804 $
	$Date: 2007-06-23 02:04:15 +0800 (六, 23 六月 2007) $
]]
local L = AceLibrary("AceLocale-2.2"):new("beql")

L:RegisterTranslations("zhTW", function() return{

	["Bayi's Extended Quest Log"] = "增強任務日誌",
	["No Objectives!"] = "無目標!",
	["(Done)"] = "(已完成)",
	["Click to open Quest Log"] = "點擊打開任務日誌",
	["Completed!"] = "完成!",
	[" |cffff0000Disabled by|r"] = "|cffff0000禁止於|r",
	["Reload UI ?"] = "是否重新載入UI?",
	["FubarPlugin Config"] = "Fubar 插件設定",
	["Requires Interface Reload"] = "需要重新載入界面",

	["Quest Log Options"] = "任務日誌選項",
	["Options related to the Quest Log"] = "任務日誌選項設定",
	["Lock Quest Log"] = "鎖定",
	["Makes the quest log unmovable"] = "鎖定任務日誌",
	["Always Open Minimized"] = "最小化",
	["Force the quest log to open minimized"] = "強制最小化打開任務日誌",
	["Always Open Maximized"] = "最大化",
	["Force the quest log to open maximized"] = "強制最大化打開任務日誌",
	["Show Quest Level"] = "任務等級",
	["Shows the quests level"] = "顯示任務的等級",
	["Info on Quest Completion"] = "任務完成資訊",
	["Shows a message and plays a sound when you complete a quest"] = "當完成任務時顯示資訊並播放聲音",
	["Auto Complete Quest"] = "自動完成任務",
	["Automatically Complete Quests"] = "自動完成任務",
	["Mob Tooltip Quest Info"] = "怪物提示",
	["Show quest info in mob tooltips"] = "在怪物提示中顯示任務資訊",
	["Item Tooltip Quest Info"] = "物品提示",
	["Show quest info in item tooltips"] = "在物品提示中顯示任務資訊",
	["Simple Quest Log"] = "精簡日誌",
	["Uses the default Blizzard Quest Log"] = "使用 Blizzard 預設任務日誌",
	["Quest Log Alpha"] = "日誌透明度",
	["Sets the Alpha of the Quest Log"] = "設定任務日誌的透明度",

	["Quest Tracker"] = "任務追蹤",
	["Quest Tracker Options"] = "任務追蹤器選項",
	["Options related to the Quest Tracker"] = "任務追蹤器選項設定",
	["Lock Tracker"] = "鎖定",
	["Makes the quest tracker unmovable"] = "鎖定任務追蹤器",
	["Show Tracker Header"] = "標題",
	["Shows the trackers header"] = "顯示任務追蹤器標題",
	["Hide Completed Objectives"] = "隱藏已完成目標",
	["Automatical hide completed objectives in tracker"] = "自動隱藏追蹤器中已完成的目標",
	["Remove Completed Quests"] = "移除已完成任務",
	["Automatical remove completed quests from tracker"] = "自動從追蹤器中移除已完成的任務",
	["Font Size"] = "字體大小",
	["Changes the font size of the tracker"] = "更改任務追蹤器的字體大小",
	["Sort Tracker Quests"] = "任務排序",
	["Sort the quests in tracker"] = "對追蹤器中的任務進行排序",
	["Show Quest Zones"] = "區域",
	["Show the quests zone it belongs to above its name"] = "顯示任務所在地區",
	["Add New Quests"] = "添加新任務",
	["Automatical add new Quests to tracker"] = "自動在追蹤器中添加新任務",
	["Add Untracked"] = "添加",
	["Automatical add quests with updated objectives to tracker"] = "獲取任務物品後自動將相關任務添加至追蹤列表",
	["Reset tracker position"] = "重置追蹤列表位置",
	["Active Tracker"] = "活躍列表",
	["Showing on mouseover tooltips, clicking opens the tracker, rightclicking removes the quest from tracker"] = "顯示滑鼠提示訊息，左鍵點擊打開追蹤列表，右鍵點擊把任務從列表中移除。",
	["Hide Objectives for Completed only"] = "隱藏完成任務目標",
	["Hide objectives only for completed quests"] = "僅隱藏已完成任務的目標",

	["Markers"] = "標記",
	["Customize the Objective/Quest Markers"] = "自訂目標/任務標記",
	["Show Objective Markers"] = "顯示目標標記",
	["Display Markers before objectives"] = "在目標前顯示標記",
	["Use Listing"] = "使用列表",
	["User Listing rather than symbols"] = "以清單替代符號",
	["List Type"] = "列表類型",
	["Set the type of listing"] = "設定列表的類型",
	["Symbol Type"] = "符號類型",
	["Set the type of symbol"] = "設定符號的類型",

	["Colors"] = "顏色",
	["Set tracker Colors"] = "設定追蹤器顏色",
	["Background"] = "背景",
	["Use Background"] = "使用背景",
	["Custom Background Color"] = "自訂背景顏色",
	["Use custom color for background"] = "背景使用自訂顏色",
	["Background Color"] = "背景",
	["Sets the Background Color"] = "設定背景顏色",
	["Background Corner Color"] = "角落",
	["Sets the Background Corner Color"] = "設定背景角落顏色",
	["Use Quest Level Colors"] = "等級",
	["Use the colors to indicate quest difficulty"] = "使用顏色顯示任務難度",
	["Custom Zone Color"] = "自訂區域顏色",
	["Use custom color for Zone names"] = "區域名稱使用自訂顏色",
	["Zone Color"] = "區域",
	["Sets the zone color"] = "設定區域顏色",
	["Fade Colors"] = "淡出",
	["Fade the objective colors"] = "目標顏色淡出",
	["Custom Objective Color"] = "自訂目標顏色",
	["Use custom color for objective text"] = "目標文字使用自訂顏色",
	["Objective Color"] = "目標",
	["Sets the color for objectives"] = "設定目標顏色",
	["Completed Objective Color"] = "完成目標",
	["Sets the color for completed objectives"] = "設定已完成目標顏色",
	["Custom Header Color"] = "自訂標題顏色",
	["Use custom color for headers"] = "標題使用自訂顏色",
	["Completed Header Color"] = "完成標題",
	["Sets the color for completed headers"] = "設定已完成標題顏色",
	["Failed Header Color"] = "失敗標題顏色",
	["Sets the color for failed quests"] = "為失敗的任務設定顏色",
	["Header Color"] = "標題",
	["Sets the color for headers"] = "設定標題顏色",
	["Disable Tracker"] = "關閉追蹤列表",
	["Disable the Tracker"] = "關閉追蹤列表",
	["Quest Tracker Alpha"] = "任務追蹤透明度",
	["Sets the Alpha of the Quest Tracker"] = "設定任務追蹤列表的透明度",
	["Auto Resize Tracker"] = "自動修正追蹤列表尺寸",
	["Automatical resizes the tracker depending on the lenght of the text in it"] = "依此處參數長度自動修正追蹤列表",
	["Fixed Tracker Width"] = "固定追蹤列表寬度",
	["Sets the fixed width of the tracker if auto resize is disabled"] = "設定追蹤列表固定寬度在自動修正關閉的情況下",

	["Pick Locale"] = "語言選擇",
	["Change Locale (needs Interface Reload)"] = "更改語言 (需要重載介面)",

	["|cffffffffQuests|r"] = "|cffffffff任務|r",
	["|cffff8000Tracked Quests|r"] = "|cffff8000追蹤任務|r",
	["|cff00d000Completed Quests|r"] = "|cff00d000完成任務|r",
	["|cffeda55fClick|r to open Quest Log and |cffeda55fShift+Click|r to open Waterfall config"] = "|cffeda55f點擊|r打開任務日誌|cffeda55f按住 Shift 點擊|r打開 Waterfall 樣式設定界面",
	
	["Tooltip"] = "提示訊息",
	["Tooltip Options"] = "提示選項",
	["Tracker Tooltip"] = "追蹤提示",
	["Showing mouseover tooltips in tracker"] = "滑鼠經過時在追蹤列表上顯示提示訊息",
	["Quest Description in Tracker Tooltip"] = "提示任務描述",
	["Displays the actual quest's description in the tracker tooltip"] = "在追蹤提示上顯示完全的任務描述",
	["Party Quest Progression info"] = "小隊任務進度",
	["Displays Party members quest status in the tooltip - Quixote must be installed on the partymembers client"] = "在提示訊息上顯示小隊成員任務狀態 - 隊友必須也安裝了 Quixote 庫才能獲取訊息",
	["Enable Left Click"] = "允許左擊",
	["Left clicking a quest in the tracker opens the Quest Log"] = "左鍵點擊追蹤列表中的任務來打開任務日誌",
	["Enable Right Click"] = "允許右擊",
	["Right clicking a quest in the tracker removes it from the tracker"] = "右鍵點擊追蹤列表中的任務以將其從列表移除",
	["Quest Log Scale"] = "任務日誌縮放",
	["Sets the Scale of the Quest Log"] = "設定任務日誌的縮放比例",
	["Force Tracker Unlock"] = "強制解鎖",
	["Make the Tracker movable even with CTMod loaded. Please check your CTMod config before using it"] = "即使載入了 CTMod 依舊可以移動追蹤列表，使用前請檢查 CTMod 的設定",
	["Quest Progression to Party Chat"] = "報告任務進度",
	["Prints the Quest Progression Status to the Party Chat"] = "將任務進度報告到小隊頻道",
	["Completion Sound"] = "完成音效",
	["Select the sound to be played when a quest is completed"] = "選擇任務完成時所播放的音效",
	
	["Quest Description Color"] = "任務描述顏色",
	["Sets the color for the Quest description"] = "設定任務描述的顏色",
	["Party Member Color"] = "隊友顏色",
	["Party Member with Quixote Color"] = "使用 Quixote 庫的隊友顏色",
	["Sets the color for Party member"] = "為隊友設定顏色",

} end )

if GetLocale() == "zhTW" then

BEQL_COMPLETE = "%(完成%)"
BEQL_QUEST_ACCEPTED = "接受任務: "

end