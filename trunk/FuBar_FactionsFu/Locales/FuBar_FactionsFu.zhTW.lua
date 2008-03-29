local L = AceLibrary("AceLocale-2.2"):new("FuBar_FactionsFu")

L:RegisterTranslations("zhTW", function() return {
	TOOLTIP_HINT = "\n|cffeda55f左擊: |r變更監察的陣營。\n|cffeda55fShift-左擊: |r往聊天輸入框發送資料。\n|cffeda55fAlt-左擊: |r設定此陣營為這地區的自動監察陣營。",

	["Text"] = "文字",
	["Text Settings"] = "文字設定",
	["Show Name"] = "顯示名稱",
	["Toggles display of watched faction's name"] = "切換顯示陣營名稱",
	["Show Standing"] = "顯示聲望階級",
	["Toggles display of watched faction's current standing"] = "切換顯示陣營聲望等級",
	["Show Progress"] = "顯示進度",
	["Toggles display of watched faction's progress toward next standing"] = "切換顯示陣營聲望到下一等級的進度",
	["Show Progress (in percent)"] = "顯示進度百分比",
	["Toggles display of watched faction's progress toward next standing (in percent)"] = "切換顯示陣營聲望到下一等級的進度百分比",
	["Color"] = "顏色",
	["Color Settings"] = "顏色設定",
	["Name"] = "名稱",
	["Sets color of the faction name"] = "設定陣營名稱顏色",
	["Reputation"] = "聲望",
	["Sets color of the faction reputation"] = "設定陣營聲望的顏色",
	["standing"] = "聲望階級",
	["Sets color of the faction standing"] = "設定陣營聲望階級的顏色",
	["Other"] = "其他",
	["Other Settings"] = "其他設定",
	["Auto-Zone"] = "自動依所在地區",
	["Toggles automatical adjustment of watched faction on zone change"] = "自動依所在地區換所要觀察的陣營",
	["Auto-Gain"] = "自動依聲望取得",
	["Toggles automatical adjustment of watched faction on faction gain"] = "自動依聲望取得換所要觀察的陣營",

	["None"] = "無",
	["War Condition"] = "戰爭狀態",
	["Blizzard's Default"] = "系統預設",
	["Incremental"] = "漸進",
} end)
