﻿local L = AceLibrary("AceLocale-2.2"):new("Omen")

L:RegisterTranslations("koKR", function() return {
	["Active With Pet"] = "소환수 있을시 사용",
	["Activate Omen when you have a pet"] = "자신의 소환수가 있을시 Omen을 사용합니다.",
	["Active When Solo"] = "솔로잉시 사용",
	["Activate Omen when solo or in a battlegroups (testing purposes only)"] = "솔로잉 또는 전장에서 Omen을 사용합니다. (테스트 용도)",
	["Aggro Gain"] = "어그로 획득",
	["Alpha"] = "투명도",
	["Allow Omen to send threat data to people using KLH Threat Meter."] = "KLHThreatMeter을 사용하는 유저에게 Omen의 위협 데이터를 보내도록 허락합니다.",
	["Always show Omen"] = "항상 Omen 표시",
	["Prevents Omen from hiding itself when ThreatLib is disabled"] = "Threatlib이 사용되지 않을때 Omen을 숨기지 못합니다.",
	["Always show self"] = "항상 자신 표시",
	["Always show your position on the meter, even if you aren't in the top X slots."] = "자신이 상위 X 슬롯에 없어도 항상 미터기에 자신을 표시합니다.",
	["Animate Bars"] = "움직이는 바",
	["Arrows"] = "화살표",
	["Bars"] = "바",
	["Background Color"] = "배경 색상",
	["Bar Height"] = "바 높이",
	["Bar Texture"] = "바 무늬",
	["Bar Color"] = "바 색상",
	["Border Color"] = "테두리 색상",
	["Classes"] = "직업",
	["Clear Threat"] = "위협 초기화",
	["Clears the raid's threat lists. May only be used if you are a raid leader or assistant."] = "공격대의 위협 수준 목록을 초기화 합니다. 공격대장이거나 승급자여야 합니다.",
	["Columns"] = "컬럼",
	["Color"] = "색상",
	["Compare Threat Velocity"] = "위협 속도 비교",
	["Custom Color"] = "사용자 색상",
	["Display"] = "표시",
	["Display options"] = "표시 옵션",
	["Disables warnings while you are in Defensive Stance, Bear Form, or have Righteous Fury"] = "방어 태세, 곰 변신, 정의의 격노 시 경고를 사용하지 않습니다.",
	["Disable While Tanking"] = "탱킹시 사용 안함",
	["E-TPS"] = "E-TPS",
	["Fade out"] = "점점 사라짐",
	["Font"] = "글꼴",
	["Grow Upwards"] = "위로 확장",
	["Left-click and drag to create a pullout bar\ncomparing your threat to "] = "새로운 바를 꺼내기 위해 좌-클릭후 이동 시킵니다.\n당신과의 위협 수치 비교: ",
	["Lock"] = "잠금",
	["Lock the Omen window so that it may not be moved"] = "Omen 창이 이동하지 않도록 잠금니다.",
	["Make numbers greater than 1,000 shorter; i.e., show 4,302 as '4.3k'"] = "1,000 단위가 넘어가는 숫자는 간단히 표시합니다; 예., 4,302를 '4.3k'로 표시합니다.",
	["Name"] = "이름",
	["None"] = "없음",
	["No target"] = "타겟 없음",
	["No tank"] = "탱커 없음",
	["Number of bars"] = "바의 갯수",
	["Offset"] = "간격",
	["Outlining"] = "글꼴 효과",
	["Outline"] = "외각선",
	["p1"] = "p1",
	["p1 speed description"] = "TPS 데이터의 움직임을 조정합니다. 낮은 값일 수록 데이타의 업데이트가 빨리 이루어집니다.",
	["Player's Bar Color"] = "플레이어 바 색상",
	["Pin/Unpin the Omen window"] = "Omen 창을 고정시키거나 이동시킵니다.",
	["Precision"] = "정밀도",
	["Publish to KTM"] = "KTM에 알림",
	["Pullout Threat Bar"] = "위협 바 꺼내기",
	["Remove"] = "제거",
	["Reset Position"] = "위치 초기화",
	["Resets Omen to the center of the screen"] = "Omen 창의 위치를 다시 화면 중앙에 표시합니다.",
	["Right-click to set properties for"] = "획득자 설정 우-클릭: ",
	["Save current skin as..."] = "현재 스킨  저장...",
	["Scale"] = "크기",
	["Select the skin to use"] = "사용할 스킨 선택",
	["Select which classes to show on the threat meter"] = "위협 미터기 위에 표시할 직업을 선택합니다.",
	["Shorten Numbers"] = "간단한 숫자 표시",
	["Shift-right-click to open the Omen menu"] = "Omen의 메뉴를 열려면 Shift-우-클릭 하세요.",
	["Show"] = "표시",
	["Show Self"] = "자신 표시",
	["Self Color"] = "자신 색상",
	["Show Aggro"] = "어그로 표시",
	["Aggro Color"] = "어그로 색상",
	["Show Aggro Gain"] = "어그로 획득 표시",
	["Show Column Headings"] = "컬럼 제목 표시",
	["Show KTM Data"] = "KTM 데이터 표시",
	["Show party revisions"] = "파티원 개정 표시",
	["Show data coming from people using KLHThreatMeter rather than ThreatLib. People using KTM will be denoted with a *"] = "ThreatLib가 아닌 KLHThreatMeter를 사용하는 유저의 데이터를 보여줍니다. KTM을 사용하고 있는 유저는 *로 표시합니다.",
	["Show Version Number"] = "버전 숫자 표시",
	["Show Warnings"] = "경고 표시",
	["Show Warning Message"] = "경고 메시지 표시",
	["Flash Screen"] = "화면 반짝임",
	["Show Test Bars"] = "테스트 바 표시",
	["Show Title"] = "타이틀 표시",
	["Show TPS"] = "TPS 표시",
	["Size"] = "크기",
	["Skins"] = "스킨",
	["Skin Settings"] = "스킨 설정",
	["Sound to play on threat warning. Hold CTRL when selecting to hear the sound played."] = "위협 경고 소리를 선택합니다. 소리를 재생했는지 듣기 위해 선택할때 CTRL키를 유지합니다.",
	["Stretch Bar Textures"] = "바 무늬 늘림",
	["Thick Outline"] = "두꺼운 외각선",
	["Threat"] = "위협",
	["Toggle Omen"] = "Omen 토글",
	["TPS"] = "TPS",
	["TPS Update Frequency"] = "TPS 업데이트 빈도",
	["Threat Per Second"] = "초당 위협 수치",
	["Update Frequency"] = "업데이트 빈도",
	["Use Custom Bar Color"] = "사용자 바 색상 사용",
	["Use Default Color"] = "기본 색상 사용",
	["Use Default Texture"] = "기본 무늬 사용",
	["Use Default Bar Height"] = "기본 바 높이 사용",
	["Use skin..."] = "스킨 사용...",
	["Warnings"] = "경고",
	["Warning: Passed %2.0f%% of %s's threat!"] = "경고: %2$s 위협 수준의 %1$2.0f%% 초과함!",
	["Warning Threshold"] = "경고 경계값",
	["Sets the the threshold at which you will be warned of your threat level. When your threat is greater than this percentage of the aggro holder's threat, you will be warned."] = "자신의 위협을 경고할 경계값을 설정합니다. 자신의 위협이 어그로 보유자의 위협 백분율보다 더 높을 경우 경고합니다.",
	["Warning Sound"] = "경고 소리",
	["Width"] = "너비",

	["Click|r to toggle the Omen window"] = "클릭|r Omen 창 토글",
	["Ctrl-Click|r to open the options menu"] = "Ctrl-클릭|r 옵션 메뉴 열기",
	["Shift-Click|r to issue a threat clear request"] = "Shift-클릭|r 위협 수치 초기화",
} end)