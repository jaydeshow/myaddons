-- FuBar_GroupFu localization information
-- Korean Locale
-- Translation by savageox
-- Date 2007/01/15
local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("koKR", function() return {
	["Solo"] = "솔로잉",
	group = "주사위 굴림",
	master = "담당자가 획득",
	freeforall = "자유 획득",
	roundrobin = "차례대로 획득",
	needbeforegreed = "주사위 굴림(착용자 우선)",
	["ML (%s)"] = "담당자 (%s)",
	["No rolls"] = "주사위 없음",

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = "주사위 굴리기가 5초 안에 종료됩니다. %d/%d 주사위 굴림.",

	["Winner: %s."] = "우승자는 %s님 입니다.",
	["Tie: %s are tied at %d."] = "%s (%d/%d)",
	["%s (%d/%d)"] = "%s (%d/%d)",
	["%s [%s]"] = "%s [%s]",
	["%d of expected %d rolls recorded."] = "%d / %d 를 기록했습니다.",

	["Perform roll when clicked"] = "클릭했을때 주사위 굴림",
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = "클릭했을때 1-100의 표준 주사위를 굴립니다.",
	["Announce"] = "카운트 후 결과 표시",
	["Only accept 1-100"] = "1-100만 인정",
	["Accept standard (1-100) rolls only."] = "표준 주사위(1-100)만 인정합니다.",
	["Loot type"] = "아이템 획득 방식",
	["Set the loot type."] = "아이템 획득 방식을 변경합니다.",
	["Loot threshold"] = "아이템 획득 등급",
	["Set the loot threshold."] = "아이템 획득 등급을 변경합니다.",

	["Where to output roll results."] = "결과 표시 위치를 선택해 주세요.",
	["Auto (based on group type)"] = "자동 (파티 및 공격대에 따라 자동)",
	["Local"] = "개인 화면에 표시",
	["Say"] = "일반창에 표시",
	["Party"] = "파티창에 표시",
	["Raid"] = "공격대창에 표시",
	["Guild"] = "길드창에 표시",
	["Don't announce"] = "표시하지 않음",

	["Roll clearing"] = "주사위 리스트 제거",
	["When to clear the rolls."] = "주사위 리스트를 언제 제거할지 설정합니다.",
	["Never"] = "없음",
	["15 seconds"] = "15 초",
	["30 seconds"] = "30 초",
	["45 seconds"] = "45 초",
	["60 seconds"] = "60 초",

	["Roll"] = "주사위",
	["Player"] = "플레이어",
	["Loot method"] = "아이템 획득 방법",
	["Master looter"] = "아이템 담당자",
	["Leader"] = "공격대장",
	["Officers"] = "지휘관",
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55f클릭|r - 주사위 굴리기 , |cffeda55fCtrl-클릭|r - 우승자 출력, |cffeda55fShift-Click|r -주사위 리스트 제거",
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fCtrl-클릭|r - 우승자 출력, |cffeda55fShift-Click|r -주사위 리스트 제거",

	["Pass"] = "패스",
	["Everyone passed."] = "모두 패스합니다.",

	["Leave Party"] = "파티 탈퇴",
	["Leave your current party or raid."] = "당신의 현재 파티나 공격대를 떠납니다.",

	["Reset Instances"] = "인스턴스 초기화",
	["Reset all available instance the group leader has active."] = "공격대장이거나 파티장일때 모든 인스턴스 초기화 기능을 사용합니다.",

} end)

