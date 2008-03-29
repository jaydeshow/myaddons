local L = AceLibrary("AceLocale-2.2"):new("FuBar_WhisperFu")

L:RegisterTranslations("zhTW", function() return {
	["Whisper"] = "密語",
	
	["Options"] = "選項",
	["Colours"] = "顏色",
	["Set the Text Colours"] = "設定文字顏色",
	
	["Send Colour"] = "發送顏色",
	["Sets the color of text for whispers sent"] = "設定發送密語顏色",

	["Receive Colour"] = "接收顏色",
	["Sets the color of text for whispers receieved"] = "設定接收密語顏色",
	
	["HintText"] = "\n點選項此人發送密語.\nAlt-Click 來邀請此人加入隊伍.\nShift-Click 來查詢此人資訊.\nCtrl-Click 來選擇此人.",
	["PlayerDesc"] = "密語發送/接收給 %s",
	["WhisperDesc"] = "向 %s 發送密語",
	
	["Purge"] = "清除所有密語",
	["PurgeDesc"] = "清除所有記錄的密語",
	
	["Player Limit"] = "人數上限",
	["Maximum number of players to store messages for."] = "紀錄密語人數上限",
	
	["Message Limit"] = "訊息上限",
	["Maximum number of messages to store per player."] = "紀錄密語訊息數上限",

	["Show Times"] = "顯示時間",
	["Show time of whispers in tooltip."] = "在提示中顯示密語時間",

	["Show Hint"] = "顯示提示",
	["Show hint at the bottom of the tooltip."] = "在提示最底下顯示hint"
} end)
