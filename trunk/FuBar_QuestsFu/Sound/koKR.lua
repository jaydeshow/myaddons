local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Sound")
L:RegisterTranslations("koKR", function() return {
	["Sound"] = "효과음",
	["Enabled"] = "사용",
	["Play sounds in response to quest events"] = "퀘스트 이벤트시 효과음을 알림니다.",
	["Sound on complete"] = "완료시 효과음",
	["Play a sound when all a quests' objectives are complete"] = "모든 퀘스트의 목표를 완료하면 효과음을 재생합니다.",
	["Sound on progress"] = "진행시 효과음",
	["Play a sound when a one objective of a multi-part quest is completed"] = "다수의 목표 중 하나의 목표가 완료되면 효과음을 재생합니다.",
	["Sounds are..."] = "효과음...",
--	["Faction"] = true,
--	["Peon"] = true,
--	["Peasant"] = true,
	["Random"] = "무작위",
} end)
