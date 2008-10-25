-- $Rev: 424 $

-- Parrot localization information
-- Translation by Next96, Fenlis, Omosiro, SayClub
local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot")
L:AddTranslations("koKR", function() return {
		["Parrot"] = "Parrot",
		["Floating Combat Text of awesomeness. Caw. It'll eat your crackers."] = "Floating Combat Text of awesomeness. Caw. It'll eat your crackers",
		["Inherit"] = "상속",
		["Parrot Configuration"] = "Parrot 설정",
		["Waterfall-1.0 is required to access the GUI."] = "GUI 환경 설정을 위해 Waterfall-1.0이 필요합니다.",
		["General"] = "전체",
		["General settings"] = "전체 설정",
		["Game damage"] = "게임 공격력",
		["Whether to show damage over the enemy's heads."] = "적의 머리위에 공격력을 표시합니다.",
		["Game healing"] = "게임 치유량",
		["Whether to show healing over the enemy's heads."] = "적의 머리위에 치유량을 표시합니다.",
		["|cffffff00Left-Click|r to change settings with a nice GUI configuration."] = "GUI 환경 설정으로 설정을 변경하려면 |cffffff00좌-클릭|r하세요.",
		["|cffffff00Right-Click|r to change settings with a drop-down menu."] = "드롭-다운 메뉴로 설정을 변경하려면 |cffffff00우-클릭|r하세요.",
		["Show guardian events"] = "수호물 이벤트 표시",
		["Whether events involving your guardian(s) (totems, ...) should be displayed"] =  "당신의 수호물 (토템, ...)을 포함시킨 이벤트를 표시합니다.",
}end)

local L_CombatEvents = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents")
L_CombatEvents:AddTranslations("koKR", function() return {
		["[Text] (crit)"] = "[Text] (치명타)",
		["[Text] (crushing)"] = "[Text] (강타당함)",
		["[Text] (glancing)"] = "[Text] (빗맞음)",
		[" ([Amount] absorbed)"] = " ([Amount] 흡수됨)",
		[" ([Amount] blocked)"] = " ([Amount] 피해 방어)",
		[" ([Amount] resisted)"] = " ([Amount] 저항함)",
		[" ([Amount] vulnerable)"] = " ([Amount] 약점)",
		[" ([Amount] overheal)"] = " ([Amount] 초과 치유)",
		["Events"] = "이벤트",
		["Change event settings"] = "이벤트 설정을 변경합니다.",
		["Incoming"] = "받는 메시지",
		["Incoming events are events which a mob or another player does to you."] = "받는 이벤트는 몹 혹은 다른 플레이어가 당신에게 행하는 이벤트입니다.",
		["Outgoing"] = "보내는 메시지",
		["Outgoing events are events which you do to a mob or another player."] = "보내는 이벤트는 당신이 몹 혹은 다른 플레이어에게 행하는 이벤트입니다.",
		["Notification"] = "알림 메시지",
		["Notification events are available to notify you of certain actions."] = "알림 이벤트는 당신의 특정 행동 알림에 이용할 수 있습니다.",
		["Event modifiers"] = "이벤트 수정자",
		["Options for event modifiers."] = "이벤트 수정자에 대한 설정입니다.",
		["Color"] = "색상",
		["Whether to color event modifiers or not."] = "이벤트 수정자에 따른 색상 사용을 선택합니다.",
		["Damage types"] = "피해 유형",
		["Options for damage types."] = "피해 유형에 대한 설정입니다.",
		["Whether to color damage types or not."] = "피해 유형에 따른 색상 사용을 선택합니다.",
		["Sticky crits"] = "접착성 치명타",
		["Enable to show crits in the sticky style."] = "접착성 형태로 치명타를 표시합니다.",
		["Throttle events"] = "이벤트 조절",
		["Whether to merge mass events into single instances instead of excessive spam."] = "많은 이벤트로 인한 지나친 메시지 대신 단 하나의 메시지를 표시합니다.",
		["Filters"] = "필터",
		["Filters to be checked for a minimum amount of damage/healing/etc before showing."] = "화면에 표시할 데미지/치유량/기타 등의 최소값을 설정할 수 있습니다.",
		["Shorten spell names"] = "주문 이름 줄임",
		["How or whether to shorten spell names."] = "주문 이름을 짧게 표시합니다.",
		["Style"] = "스타일",
		["How or whether to shorten spell names."] = "주문 이름을 짧게 표시합니다.",
		["None"] = "없음",
		["Abbreviate"] = "약어",
		["Truncate"] = "생략",
		["Do not shorten spell names."] = "주문명을 줄이지 않습니다.",
		["Gift of the Wild => GotW."] = "야생의 선물 => 야선",
		["Gift of the Wild => Gift of t..."] = "야생의 선물 => 야생의 ...",
		["Length"] = "길이",
		["The length at which to shorten spell names."] = "텍스트 길이가 몇글자 이상일때 주문명 줄이기를 적용할지 정합니다.",
		["Critical hits/heals"] = "치명타/극대화",
		["Crushing blows"] = "강타 알림",
		["Glancing hits"] = "빗맞은 타격",
		["Partial absorbs"] = "부분적인 흡수",
		["Partial blocks"] = "부분적인 방어",
		["Partial resists"] = "부분적인 저항",
		["Vulnerability bonuses"] = "약점 보너스",
		["Overheals"] = "초과 치유",
		["<Text>"] = "<문자>",
		["Enabled"] = "사용",
		["Whether to enable showing this event modifier."] = "해당 이벤트 수정자 표시 사용을 선택합니다.",
		["What color this event modifier takes on."] = "받은 해당 이벤트 수정자의 색상을 선택합니다.",
		["Text"] = "문자",
		["What text this event modifier shows."] = "해당 이벤트 수정자 표시 문자를 선택합니다.",
		["Physical"] = "물리",
		["Holy"] = "신성",
		["Fire"] = "화염",
		["Nature"] = "자연",
		["Frost"] = "냉기",
		["Shadow"] = "암흑",
		["Arcane"] = "비전",
		["What color this damage type takes on."] = "받은 해당 피해 유형의 색상을 선택합니다.",
		["Inherit"] = "상속",
		["Thin"] = "얇게",
		["Thick"] = "두껍게",
		["<Tag>"] = "<태그>",
		["Uncategorized"] = "분류",
		["Tag"] = "태그",
		["Tag to show for the current event."] = "현재 이벤트 표시를 위한 태그입니다.",
		["Color of the text for the current event."] = "현재 이벤트에 대한 글자의 색상입니다.",
		["Sound"] = "소리",
		["What sound to play when the current event occurs."] = "현재 이벤트 발생시 재생할 소리를 선택하세요.",
		["Sticky"] = "접착성",
		["Whether the current event should be classified as \"Sticky\""] = "현재 이벤트를 \"접착성\"으로 표시 할 지를 선택합니다.",
		["Custom font"] = "사용자 글꼴",
		["Font face"] = "글꼴체",
		["Inherit font size"] = "일반 상속 글꼴 크기",
		["Font size"] = "글꼴 크기",
		["Font outline"] = "글꼴 외각선",
		["Enable the current event."] = "현재 이벤트를 사용합니다.",
		["Scroll area"] = "스크롤 영역",
		["Which scroll area to use."] = "사용할 스크롤 영역을 선택합니다.",
		["What timespan to merge events within.\nNote: a time of 0s means no throttling will occur."] = "지정한 시간안에 발생하는 트리거를 합쳐서 표현 할지 정합니다.\n팁: 값을 '0'으로 할 경우 트리거 합치기는 작동하지 않습니다.",
		["What amount to filter out. Any amount below this will be filtered.\nNote: a value of 0 will mean no filtering takes place."] = "필터링할 최소 값을 정합니다. 얼마든지 정해진 이하의 값을 가진 데이터는 출력하지 않습니다.\n'0'값은 필터링을 하지 않습니다.",
		["The amount of damage absorbed."] = "흡수된 피해량 입니다.",
		["The amount of damage blocked."] = "방어한 피해량 입니다.",
		["The amount of damage resisted."] = "저항한 피해량 입니다.",
		["The amount of vulnerability bonus."] = "약점 보너스 피해량 입니다.",
		["The amount of overhealing."] = "초과 치유량 입니다.",
		["The normal text."] = "일반 글자입니다.",
}end)

local L_Display = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Display")
L_Display:AddTranslations("koKR", function() return {
		["None"] = "없음",
		["Thin"] = "얇게",
		["Thick"] = "두껍게",
		["Text transparency"] = "문자 투명도",
		["How opaque/transparent the text should be."] = "문자들의 투명도를 조절합니다.",
		["Icon transparency"] = "아이콘 투명도",
		["How opaque/transparent icons should be."] = "아이콘들의 투명도를 조절합니다.",
		["Enable icons"] = "아이콘 사용",
		["Set whether icons should be enabled or disabled altogether."] = "아이콘 기능을 사용할지 여부를 선택하세요.",
		["Master font settings"] = "기본 글꼴 설정",
		["Normal font"] = "일반 글꼴",
		["Normal font face."] = "일반 글꼴체입니다.",
		["Normal font size"] = "일반 글꼴 크기",
		["Normal outline"] = "일반 외곽선",
		["Sticky font"] = "접착성 글꼴",
		["Sticky font face."] = "접착성 글꼴체입니다.",
		["Sticky font size"] = "접착성 글꼴 크기",
		["Sticky outline"] = "접착성 외곽선",

}end)

local L_ScrollAreas = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_ScrollAreas")
L_ScrollAreas:AddTranslations("koKR", function() return {
		["Incoming"] = "받는 메시지",
		["Outgoing"] = "보내는 메시지",
		["Notification"] = "알림 메시지",
		["New scroll area"] = "새 스크롤 영역",
		["Inherit"] = "상속",
		["None"] = "없음",
		["Thin"] = "얇게",
		["Thick"] = "두껍게",
		["Left"] = "좌측",
		["Right"] = "우측",
		["Disable"] = "사용 안함",
		["Options for this scroll area."] = "해당 스크롤 영역에 대한 설정입니다.",
		["Name"] = "이름",
		["Name of the scroll area."] = "스크롤 영역의 이름입니다.",
		["<Name>"] = "<이름>",
		["Remove"] = "제거",
		["Remove this scroll area."] = "해당 스크롤 영역을 제거합니다.",
		["Icon side"] = "아이콘 표시",
		["Set the icon side for this scroll area or whether to disable icons entirely."] = "스크롤 텍스트에 아이콘을 표시합니다.",
		["Test"] = "테스트",
		["Send a test message through this scroll area."] = "해당 스크롤 영역을 통해 테스트 메세지를 보냅니다.",
		["Normal"] = "일반",
		["Send a normal test message."] = "일반 테스트 메세지를 보냅니다.",
		["Sticky"] = "접착성",
		["Send a sticky test message."] = "접착성 테스트 메세지를 보냅니다.",
		["Direction"] = "방향",
		["Which direction the animations should follow."] = "문자의 스크롤 방향을 설정합니다.",
		["Direction for normal texts."] = "일반 문자의 방향을 설정합니다.",
		["Direction for sticky texts."] = "접착성 텍스트의 방향을 설정합니다.",
		["Animation style"] = "애니메이션 스타일",
		["Which animation style to use."] = "사용할 애니메이션 스타일을 선택합니다.",
		["Animation style for normal texts."] = "일반 문자에 대한 애니메이션 형태입니다.",
		["Animation style for sticky texts."] = "접착성 문자에 대한 애니메이션 형태입니다.",
		["Position: horizontal"] = "위치: 수평",
		["The position of the box across the screen"] = "박스가 화면에서 위치할 수평값을 정하세요.",
		["Position: vertical"] = "위치: 수직",
		["The position of the box up-and-down the screen"] = "박스가 화면에서 위치할 수직값을 정하세요.",
		["Size"] = "크기",
		["How large of an area to scroll."] = "스크롤 할 영역의 크기를 설정합니다.",
		["Scrolling speed"] = "스크롤 속도",
		["How fast the text scrolls by."] = "문자 스크롤의 속도를 설정합니다.",
		["Seconds for the text to complete the whole cycle, i.e. larger numbers means slower."] = "문자가 1주기를 완료하는데 걸리는 시간(초)입니다. 큰 숫자일수록 느려집니다.",
		["Custom font"] = "사용자 글꼴",
		["Normal font face"] = "일반 글꼴체",
		["Normal inherit font size"]  = "일반 상속 글꼴 크기",
		["Normal font size"] = "일반 글꼴 크기",
		["Normal font outline"] = "일반 글꼴 외곽선",
		["Sticky font face"] = "접착성 글꼴체",
		["Sticky inherit font size"] = "접착성 상속 글꼴 크기",
		["Sticky font size"] = "접착성 글꼴 크기",
		["Sticky font outline"] = "접착성 글꼴 외곽선",
		["Click and drag to the position you want."]  = "원하는 위치로 이동하려면 클릭 후 드래그 하세요.",
		["Scroll area: %s"] = "스크롤 영역: %s",
		["Position: %d, %d"] = "위치: %d，%d",
		["Scroll areas"] = "스크롤 영역",
		["Options regarding scroll areas."] = "스크롤 영역에 관한 설정입니다.",
		["Configuration mode"] = "환경설정 모드",
		["Enter configuration mode, allowing you to move around the scroll areas and see them in action."] = "스크롤 영역을 이동할 수 있는 환경 설정 모드로 변경합니다.",
		["New scroll area"] = "새 스크롤 영역",
		["Add a new scroll area."] = "새로운 스크롤 영역을 추가합니다.",
		["Center of screen"] = "화면의 중앙",
  	 	["Edge of screen"] = "화면의 가장자리",
  	 	["Create"] = "생성",
  	 	["Are you sure?"] = "정말로 하시겠습니까?",
  	 	["Send"] = "보냄",
}end)

local L_Suppressions = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Suppressions")
L_Suppressions:AddTranslations("koKR", function() return {
		["New suppression"] = "새로운 차단",
		["Edit"] = "편집",
		["Edit search string"] = "검색 문자열을 편집합니다.",
		["<Any text> or <Lua search expression>"] = "<문자열> 혹은 <Lua 검색 표현식>",
		["Lua search expression"] = "Lua 검색 표현식",
		["Whether the search string is a lua search expression or not."] = "Whether the search string is a lua search expression or not.",
		["Remove"] = "제거",
		["Remove suppression"] = "차단 제거",
		["Suppressions"] = "차단",
		["List of strings that will be squelched if found."] = "차단할 문자열을 등록합니다.",
		["Add a new suppression."] = "새로운 차단을 추가합니다.",
		["Create"] = "생성",
		["Are you sure?"] = "정말로 하시겠습니까?",
}end)

local L_Triggers = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Triggers")
L_Triggers:AddTranslations("koKR", function() return {
		["%s!"] = "%s!",
		["Low Health!"] = "생명력 낮음!",
		["Low Mana!"] = "마나 낮음!",
		["Low Pet Health!"] = "소환수 생명력 낮음!",
		["Free %s!"] = "자유 %s!",
		["Trigger cooldown"] = "재사용 시간 트리거",
		["Check every XX seconds"] = "매 XX 초마다 체크합니다.",
		["Triggers"] = "트리거",
		["New trigger"] = "새로운 트리거",
		["Create a new trigger"] = "새로운 트리거를 생성합니다.",
		["Inherit"] = "상속",
		["None"] = "없음",
		["Thin"] = "얇게",
		["Thick"] = "두껍게",
		["Druid"] = "드루이드",
		["Rogue"] = "도적",
		["Shaman"] = "주술사",
		["Paladin"] = "성기사",
		["Mage"] = "마법사",
		["Warlock"] = "흑마법사",
		["Priest"] = "사제",
		["Warrior"] = "전사",
		["Hunter"] = "사냥꾼",
		["Output"] = "출력",
		["The text that is shown"] = "표시할 문자",
		['<Text to show>'] = "<표시할 문자>",
		["Icon"] = "아이콘",
		["The icon that is shown"] = "표시할 아이콘",
		['<Spell name> or <Item name> or <Path> or <SpellId>'] = "<주문명> 또는 <아이템 이름> 또는 <경로> 또는 <SpellId>",--need locale
		["Enabled"] = "사용",
		["Whether the trigger is enabled or not."] = "트리거를 사용하거나 사용하지 않습니다.",
		["Remove trigger"] = "트리거 제거",
		["Remove this trigger completely."] = "해당 트리거를 완전히 제거합니다.",
		["Color"] = "색상",
		["Color of the text for this trigger."] = "해당 트리거에 대한 문자의 색상입니다.",
		["Sticky"] = "접착성",
		["Whether to show this trigger as a sticky."] = "해당 트리거를 접착성으로 표시합니다.",
		["Classes"] = "직업",
		["Classes affected by this trigger."] = "해당 트리거를 적용할 직업입니다.",
		["Scroll area"] = "스크롤 영역",
		["Which scroll area to output to."] = "출력할 스크롤 영역을 선택합니다.",
		["Sound"] = "소리",
		["What sound to play when the trigger is shown."] = "트리거 작동시 출력할 소리를 정합니다.",
		["Test"] = "테스트",
		["Test how the trigger will look and act."] = "현재 트리거 작동시 보여지는 것을 미리 확인 하세요.",
		["Custom font"] = "사용자 글꼴",
		["Font face"] = "글꼴체",
		["Inherit font size"] = "상속 글꼴 크기",
		["Font size"] = "글꼴 크기",
		["Font outline"] = "글꼴 외곽선",
		["Primary conditions"] = "1차 조건",
		["When any of these conditions apply, the secondary conditions are checked."] = "트리거가 작동할 첫번째 조건을 선택하세요.",
		["New condition"] = "새로운 조건",
		["Add a new primary condition"] = "새로운 1차 조건을 추가합니다.",
		["Remove condition"] = "조건 제거",
		["Remove a primary condition"] = "1차 조건을 제거합니다.",
		["Secondary conditions"] = "2차 조건",
		["When all of these conditions apply, the trigger will be shown."] = "트리거가 작동할 두번째 조건을 선택하세요.",
		["Add a new secondary condition"] = "새로운 2차 조건을 추가합니다.",
		["Remove a secondary condition"] = "2차 조건을 제거합니다.",
  	 	["Create"] = "생성",
  	 	["Remove"] = "제거",
  	 	["Are you sure?"] = "정말로 하시겠습니까?",

}end)

local L_AnimationStyles = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_AnimationStyles")
L_AnimationStyles:AddTranslations("koKR", function() return {
		["Straight"] = "직선",
		["Up, left-aligned"] = "위로, 좌측 정렬",
		["Up, right-aligned"] = "위로, 우측 정렬",
		["Up, center-aligned"] = "위로, 가운데 정렬",
		["Down, left-aligned"] = "아래로, 좌측 정렬",
		["Down, right-aligned"] = "아래로, 우측 정렬",
		["Down, center-aligned"] = "아래로, 가운데 정렬",
		["Parabola"] = "곡선",
		["Up, left"] = "위로, 좌측",
		["Up, right"] = "위로, 우측",
		["Up, alternating"] = "위로, 교차",
		["Down, left"] = "아래로, 좌측",
		["Down, right"] = "아래로, 우측",
		["Down, alternating"] = "아래로, 교차",
		["Semicircle"] = "반원",
		["Pow"] = "지진",
		["Static"] = "고정",
		["Rainbow"] = "무지개",
		["Horizontal"] = "수평",
		["Left"] = "좌측",
		["Right"] = "우측",
		["Alternating"] = "교차",
		["Action"] = "액션",
		["Action Sticky"] = "고정 고정",
		["Angled"] = "모서리",
		["Sprinkler"] = "스프링클러",
		["Up, clockwise"] = "위로, 시계방향" ,
		["Down, clockwise"] = "아래로, 시계방향",
		["Left, clockwise"] = "좌측, 시계방향",
		["Right, clockwise"] = "우측, 시계방향",
		["Up, counter-clockwise"] = "위로, 반시계방향",
		["Down, counter-clockwise"] = "아래로, 반시계방향",
		["Left, counter-clockwise"] = "좌측, 반시계방향",
		["Right, counter-clockwise"] = "우측, 반시계방향",

}end)

local L_Auras = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Auras")
L_Auras:AddTranslations("koKR", function() return {
		["Auras"] = "오라",
		["Debuff gains"] = "디버프 획득",
		["The name of the debuff gained."] = "획득한 디버프 이름",
		["Buff gains"] = "버프 획득",
		["The name of the buff gained."] = "획득한 버프 이름",
		["Item buff gains"] = "아이템 버프 획득",
		["The name of the item buff gained."] = "획득한 아이템 버프 이름",
		["The name of the item, the buff has been applied to."] = "아이템, 버프의 이름 적용",
		-- ["The rank of the item buff gained."] = "획득한 아이템 버프 레벨",
		["Debuff fades"] = "디버프 사라짐",
		["The name of the debuff lost."] = "사라진 디버프 이름",
		["Buff fades"] = "버프 사라짐",
		["The name of the buff lost."] = "사라진 버프 이름",
		["Item buff fades"] = "아이템 버프 사라짐",
		["The name of the item buff lost."] = "사라진 아이템 버프 이름",
		["The name of the item, the buff has faded from."] = "아이템, 버프의 이름 점점 사라짐" ,
		-- ["The rank of the item buff lost."] = "사라진 아이템 버프 레벨",
		
		["Self buff gain"] = "자신 버프 획득",
		["<Buff name>"] = "<버프 이름>",
		["Self buff fade"] = "자신 버프 사라짐",
		["Self debuff gain"] = "자신 디버프 획득",
		["<Debuff name>"] = "<디버프 이름>",
		["Self debuff fade"] = "자신 디버프 사라짐",
		["Self item buff gain"] = "자신 아이템 버프 획득",
		["<Item buff name>"] = "<아이템 버프 이름>",
		["Self item buff fade"] = "자신 아이템 버프 사라짐",
		["Target buff gain"] = "대상 버프 획득",
		["Target debuff gain"] = "대상 디버프 획득",
		["Buff inactive"] = "활동하지 않는 버프",
		["Buff active"] = "버프 발동",
		["Focus buff gain"] = "주시 대상 버프 획득",
		["Focus debuff gain"] = "주시 대상 디버프 획득",
		["Target buff fade"] = "대상 버프 사라짐",
		["Target debuff fade"] = "대상 디버프 사라짐",
		["Focus buff fade"] = "주시 대상 버프 사라짐",
		["Focus debuff fade"] = "주시 대상 디버프 사라짐",
		["Buff stack gains"] = "버프 중첩 획득",
		["Debuff stack gains"] = "디버프 중첩 획득",
		["New Amount of stacks of the buff."] = "새로운 버프 중첩입니다.",
		["New Amount of stacks of the debuff."] = "새로운 디버프 중첩입니다.",
		["The name of the unit that gained the buff."] = "버프를 획득한 유닛의 이름입니다.",
		["Target buff stack gains"] = "대상 버프 중첩 획득",
		["Target buff gains"] = "대상 버프 획득",

}end)

local L_CombatEvents_Data = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents_Data")
L_CombatEvents_Data:AddTranslations("koKR", function() return {
		["Incoming damage"] = "들어오는 데미지",
		["Melee damage"] = "근접 피해",
		["Melee"] = "근접",
		["The name of the enemy that attacked you."] = "당신을 공격한 적의 이름입니다.",
		["The amount of damage done."] = "입힌 피해량입니다.",
		[" (%d hit, %d crit)"] = " (%d 타격, %d 치명타)",
		[" (%d hit, %d crits)"] = " (%d 타격, %d 치명타)",
		[" (%d hits, %d crit)"] = " (%d 타격, %d 치명타)",
		[" (%d hits, %d crits)"] = " (%d 타격, %d 치명타)",
		[" (%d crits)"] = " (%d 치명타)",
		[" (%d hits)"] = " (%d 타격)",
		["Multiple"] = "복합",
		["Melee misses"] = "근접 빗맞힘",
		["Miss!"] = "빗맞힘!",
		["Melee dodges"] = "근접 회피",
		["Dodge!"] = "피함!",
		["Melee parries"] = "근접 막음",
		["Parry!"] = "막음!",
		["Melee blocks"] = "근접 방어",
		["Block!"] = "방어!",
		["Melee absorbs"] = "근접 흡수",
		["Absorb!"] = "흡수!",
		["Melee immunes"] = "근접 면역",
		["Immune!"] = "면역!",
		["Melee evades"] = "근접 빗나감",
		["Evade!"] = "빗나감!",
		["Skills"] = "기술",
		["Skill damage"] = "기술 피해",
		["The type of damage done."] = "입힌 피해의 유형입니다.",
		["The spell or ability that the enemy attacked you with."] = "당신을 공격한 적의 주문 혹은 기술입니다.",
		["DoTs and HoTs"] = "지속적인 피해/치유",
		["Skill DoTs"] = "기술 주기적인 피해",
		["Reactive skills"] = "기술 사용 가능 여부",
		["Ability misses"] = "기술 빗맞힘",
		["Ability dodges"] = "기술 피함",
		["Ability parries"] = "기술 막음",
		["Ability blocks"] = "기술 방어",
		["Spell resists"] = "주문 저항",
		["Resist!"] = "저항!",
		["Skill absorbs"] = "기술 흡수",
		["Skill immunes"] = "기술 면역",
		["Skill reflects"] = "기술 반사",
		["Reflect!"] = "반사!",
		["Skill interrupts"] = "기술 차단",
		["Interrupt!"] = "차단!",
		["Incoming heals"] = "들어오는 치유",
		["Heals"] = "치유",
		["The name of the ally that healed you."] = "당신을 치유한 아군의 이름입니다.",
		["The spell or ability that the ally healed you with."] = "당신을 치유한 아군의 주문 혹은 기술입니다.",
		["The amount of healing done."] = "치유량입니다.",
		[" (%d heal, %d crit)"] = " (%d 치유，%d 극대화)",
		[" (%d heal, %d crits)"] = " (%d 치유，%d 극대화)",
		[" (%d heals, %d crit)"] = " (%d 치유，%d 극대화)",
		[" (%d heals, %d crits)"] = " (%d 치유，%d 극대화)",
		[" (%d heals)"] = " (%d 치유)",
		["Heals over time"] = "지속적인 치유",
		["Environmental damage"] = "환경 피해",
		["Outgoing damage"] = "나가는 데미지",
		["The name of the enemy you attacked."] = "당신이 공격한 적의 이름입니다.",
		["The spell or ability that you used."] = "당신이 사용한 주문 혹은 기술입니다.",
		["Skill evades"] = "기술 빗나감",
		["Outgoing heals"] = "나가는 치유",
		["The name of the ally you healed."] = "당신이 치유한 아군의 이름입니다.",
		["Pet melee"] = "소환수 근접",
		["Pet melee damage"] = "소환수 근접 피해",
		["(Pet) -[Amount]"] = "(소환수) -[Amount]",
		["(Pet) +[Amount]"] = "(소환수) +[Amount]",
		["Pet heals"] = "소환수 치유",
		["The name of the enemy your pet attacked."] = "당신의 소환수가 공격한 적의 이름입니다.",
		["Pet melee misses"] = "소환수 근접 빗맞힘",
		["Pet Miss!"] = "소환수 빗맞힘!",
		["Pet melee dodges"] = "소환수 근접 피함",
		["Pet Dodge!"] = "소환수 피함!",
		["Pet melee parries"] = "소환수 근접 막음",
		["Pet Parry!"] = "소환수 막음!",
		["Pet melee blocks"] = "소환수 근접 방어",
		["Pet Block!"] = "소환수 방어!",
		["Pet melee absorbs"] = "소환수 근접 흡수",
		["Pet Absorb!"] = "소환수 흡수!",
		["Pet melee immunes"] = "소환수 근접 면역",
		["Pet Immune!"] = "소환수 면역!",
		["Pet melee evades"] = "소환수 근접 빗나감",
		["Pet Evade!"] = "소환수 빗나감!",
		["Pet skills"] = "소환수 기술",
		["Pet skill"] = "소환수 기술",
		["Pet skill damage"] = "소환수 기술 피해",
		["Pet [Amount] ([Skill])"] = "소환수 [Amount] ([Skill])",
		["The ability or spell your pet used."] = "당신의 소환수가 사용한 기술 혹은 주문입니다.",
		["Pet ability misses"] = "소환수 기술 빗맞힘",
		["Pet ability dodges"] = "수환수 기술 피함",
		["Pet ability parries"] = "소환수 기술 막음",
		["Pet ability blocks"] = "소환수 기술 방어",
		["Pet spell resists"] = "소환수 주문 저항",
		["Pet Resist!"] = "소환수 저항!",
		["Pet skill absorbs"] = "소환수 기술 흡수",
		["Pet skill immunes"] = "소환수 기술 면역",
		["Pet skill reflects"] = "소환수 기술 반사",
		["Pet Reflect!"] = "소환수 반사!",
		["Pet skill evades"] = "소환수 기술 빗나감",
		["Pet heals over time"] = "소환수 지속 치유",
		["Combat status"] = "전투 상황",
		["Enter combat"] = "전투 시작",
		["Leave combat"] = "전투 종료",
		["Power gain/loss"] = "파워 획득/손실",
		["Power change"] = "파워 변동",
		["Power gain"] = "파워 획득",
		["+[Amount] [Type]"] = "+[Amount] [Type]",
		["The amount of power gained."] = "획득한 파워 수치입니다.",
		["The type of power gained (Mana, Rage, Energy)."] = "파워 획득 유형입니다. (마나, 분노, 기력)",
		["The ability or spell used to gain power."] = "파워 획득에 사용된 기술 혹은 주문입니다.",
		["The character that the power comes from."] = "파워를 빼앗은 케릭터입니다.",
		[" (%d gains)"] = " (%d 획득)",
		["Power loss"] = "파워 손실",
		["-[Amount] [Type]"] = "-[Amount] [Type]",
		["The amount of power lost."] = "손실된 파워 수치입니다.",
		["The type of power lost (Mana, Rage, Energy)."] = "파워 손실 유형입니다. (마나, 분노, 기력)",
		["The ability or spell take away your power."] = "당신의 파워를 뺏앗아 간 기술 혹은 주문입니다.",
		["The character that caused the power loss."] = "파워 손실을 일으킨 캐릭터입니다",
		[" (%d losses)"] = " (%d 손실)",
		["Combo points"] = "연계 포인트",
		["Combo point gain"] = "연계 포인트 획득",
		["[Num] CP"] = "[Num] 연계",
		["The current number of combo points."] = "현재 연계 포인트 개수입니다.",
		["Combo points full"] = "연계 포인트 충만",
		["[Num] CP Finish It!"] = "[Num] 연계 포인트 마무리!",
		["Honor gains"] = "명예 획득",
		["The amount of honor gained."] = "획득한 명예 수치입니다.",
		["The name of the enemy slain."] = "죽인 적의 이름입니다.",
		["The rank of the enemy slain."] = "죽인 적의 계급입니다.",
		["Reputation"] = "평판",
		["Reputation gains"] = "평판 획득",
		["The amount of reputation gained."] = "획득한 평판 수치입니다.",
		["The name of the faction."] = "진영명입니다.",
		["Reputation losses"] = "평판 손실",
		["The amount of reputation lost."] = "손실된 평판 수치입니다.",
		["Skill gains"] = "기술 획득",
		["The skill which experienced a gain."] = "경험치를 획득한 기술입니다.",
		["The amount of skill points currently."] = "현재 스킬 포인트입니다.",
		["Experience gains"] = "경험치 획득",
		["The name of the enemy slain."] = "죽인 적의 이름입니다.",
		["The amount of experience points gained."] = "획득한 경험치 수치입니다.",
		["Killing blows"] = "결정타",
		["Player killing blows"] = "플레이어 죽임 알림",
		["Killing Blow!"] = "죽임!",
		["The spell or ability used to slay the enemy."] = "적을 죽인 주문 혹은 기술입니다.",
		["NPC killing blows"] = "NPC 죽임 알림",
		["Soul shard gains"] = "영혼석 획득",
		["The name of the soul shard."] = "영혼석 이름 입니다.",
		["Extra attacks"] = "추가 공격",
		["%s!"] = "%s!",
		["The name of the spell or ability which provided the extra attacks."] = "추가 공격을 제공한 주문 혹은 기술명 입니다.",
		["Self heals"] = "자신 치유",
		["Self heals over time"] = "자신의 지속 치유 ",
		["Pet skill DoTs"] = "소환수 DOT 스킬",
		["Skill you were interrupted in casting"] = "당신이 시전 방해 받은 기술",
		["The spell you interrupted"] = "당신이 방해한 주문",
		-- Schools
		["Physical"] = "물리",
		["Holy"] = "신성",
		["Fire"] = "화염",
		["Nature"] = "자연",
		["Frost"] = "냉기",
		["Shadow"] = "암흑",
		["Arcane"] = "비전",

		["The name of the enemy that attacked your pet."] = "당신의 소환수를 공격한 적의 이름",
		["The spell or ability that the enemy attacked your pet with."] = "적이 당신의 소환수를 공격한 능력이나 주문",
		["The name of the ally that healed your pet."] = "당신의 소환수를 치유한 대상의 이름",
		["The spell or ability that the ally healed your pet with."] = "당신의 소환수를 치유한 대상의 능력이나 주문",
		["The spell or ability that your pet used."] = "당신의 소환수가 사용한 능력이나 주문",
		["The name of the unit that your pet healed."] = "당신의 소환수를 치유한 유닛의 이름",
		["The spell or ability that the pet used to heal."] = "소환수를 치유하기 위해 사용한 능력이나 주문",
}end)

local L_Cooldowns = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Cooldowns")
L_Cooldowns:AddTranslations("koKR", function() return {
		["Cooldowns"] = "재사용 대기시간",
		["Skill cooldown finish"] = "기술 재사용 대기시간 완료",
		["[[Skill] ready!]"] = "> [Skill] 사용 가능! <",
		["The name of the spell or ability which is ready to be used."] = "사용할 준비가 된 주문이나 능력의 이름",
		["Traps"] = "덫류",
		["Shocks"] = "충격류",
		["Divine Shield"] = "천상의 보호막",
		["%s Tree"] = "%s 계열",
		["Spell ready"] = "주문/스킬 준비 완료",
		["<Spell name>"] = "<주문 이름>",
}end)

local L_Loot = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Loot")
L_Loot:AddTranslations("koKR", function() return {
		["Loot"] = "획득",
		["Loot items"] = "아이템 획득",
		["Loot [Name] +[Amount]([Total])"] = "[Name] +[Amount]([Total]) 획득",
		["The name of the item."] = "아이템의 이름",
		["The amount of items looted."] = "획득한 아이템의 수량",
		["The total amount of items in inventory."] = "가방에 있는 아이템의 총 수량",
		["Loot money"] = "골드 획득",
		["Loot +[Amount]"] = "+[Amount] 획득",
		["The amount of gold looted."] = "획득한 골드의 양",

}end)

local L_TriggerConditions_Data = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_TriggerConditions_Data")
L_TriggerConditions_Data:AddTranslations("koKR", function() return {
	-- Parrot_TriggerConditions_Data
		["Enemy target health percent"] = "적대적 대상 생명력 백분율",
		["Friendly target health percent"] = "우호적 대상 생명력 백분율",
		["Self health percent"] = "자신의 생명력 백분율",
		["Self mana percent"] = "자신의 마나 백분율",
		["Pet health percent"] = "소환수의 생명력 백분율",
		["Pet mana percent"] = "소환수 마나 백분율",
		["Incoming block"] = "들어오는 방어",
		["Incoming crit"] = "들어오는 치명타",
		["Incoming dodge"] = "들어오는 회피",
		["Incoming parry"] = "들어오는 막음",
		["Outgoing block"] = "나가는 방어",
		["Outgoing crit"] = "나가는 치명타",
		["Outgoing dodge"] = "나가는 회피",
		["Outgoing parry"] = "나가는 막음",
		["Outgoing cast"] = "나가는 주문",
		["<Skill name>"] = "<주문 이름>",
		["Incoming cast"] = "들어오는 주문",
		["Minimum power amount"] = "최소 파워 수치",
		["Warrior stance"] = "전사 태세",
		["Not in warrior stance"] = "전투태세 아닐때",
		["Druid Form"] = "드루이드 변신",
		["Not in Druid Form"] = "드루이드 변신 아닐때",
}end)

local L_CombatStatus = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatStatus")
L_CombatStatus:AddTranslations("koKR", function() return {
		["Combat status"] = "전투 상황",
		["Enter combat"] = "전투 시작",
		["+Combat"] = "+전투",
		["Leave combat"] = "전투 종료",
		["-Combat"] = "-전투",
		["In combat"] = "전투중",
		["Not in combat"] = "비전투중",
} end)