local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Tracker")
L:RegisterTranslations("koKR", function() return {
	["Tracker"] = "트래커",
	["Autowatch"] = "자동 추적",
	["Automatically add quests to the tracker when appropriate"] = "퀘스트 획득 시 자동으로 알림이에 추가합니다.",
	["Use own tracker"] = "트래커 사용",
	["Replace the default quest tracker with a slightly more featureful one"] = "기본 퀘스트 트래커를 좀더 강화된 기능을 하는 것으로 대체합니다",
	["Login"] = "로그인",
	["Re-add quests you were watching before you logged out"] = "로그아웃 하기전에 보고 있었던 퀘스트를 다시 추가합니다.",  -- 체크
	["Zone"] = "지역",
	["Add quests to the tracker when you enter their zone"] = "해당 지역에 도착했을 경우 자동으로 퀘스트 알림이에 추가합니다.",
	["Subzone"] = "세부 지역",
	["Add quests to the tracker when you enter their subzone"] = "해당 세부 지역에 도착했을 경우 자동으로 퀘스트 알림이에 추가합니다.",
	["Gained"] = "획득",
	["Add quests to the tracker when they are first gained"] = "퀘스트 아이템을 획득할 경우 자동으로 퀘스트 알림이에 추가합니다.",
	["Progress"] = "진행 상황",
	["Add quests to the tracker when you make progress on them"] = "진행 상황이 있을 경우 자동으로 퀘스트 알림이에 추가합니다.",
	["Remove completed"] = "완료시 제거",
	["Remove quests from the tracker when you complete their objectives"] = "목표를 모두 획득할 경우 퀘스트 트래커에서 제거합니다.",
} end)
