local L = AceLibrary("AceLocale-2.2"):new("Mendeleev")

L:RegisterTranslations("koKR", function() return {
	["Toggle sets."] = "설정 전환.",
	["Toggle sets from showing information in the tooltip."] = "툴팁에 표시할 정보 설정을 전환합니다.",
	["Toggle sets in the %s category."] = "%s 분류 설정을 전환합니다.",
	["Toggle %s."] = "%s 전환.",
	["Show item level"] = "아이템 등급 표시",
	["Toggle showing the item level in the tooltip."] = "툴팁에 아이템 등급을 표시합니다.",
	["Show item identifier"] = "아이템 식별자 표시",
	["Toggle showing the item identifier in the tooltip."] = "툴팁에 아이템 식별자를 표시합니다.",
	["Show stack size"] = "묶음 크기 표시",
	["Toggle showing the stack size in the tooltip."] = "툴팁에 묶음 크기를 표시합니다.",
	["Show 'used in' tree"] = "'사용처' 목록 표시",
	["Toggle showing the 'used in' tree in the tooltip."] = "툴팁에 '사용처' 목록을 표시합니다.",
	["Limit 'used in' tree to craftable"] = "제작가능한 것에만 '사용처' 목록 제한",
	["Toggle limiting the 'used in' tree to items the char can craft."] = "케릭터가 제작할 수 있는 아이템에만 사용처 목록을 표시하도록 제한합니다.",
	["Item ID"] = "아이템 ID",
	["iLevel"] = "아이템 레벨",
	["Stacksize"] = "묶음크기",

	["Crafted by"] = "제작 기술",
	["Component in"] = "재료 용도",

	["Recipe source"] = "도안 출처",
	["Lockpicking"] = "자물쇠따기",
	["Gathering skills"] = "채집 기술",
	["Mine Gems"] = "보석 광맥",
	["Trade skills"] = "전문 기술",
	["Class Reagents"] = "직업 재료",
	["Food type"] = "음식류",
	["Booze"] = "술류",
	["Elemental bosses"] = "속성 보스류",
	["Outdoor bosses"] = "야외 보스류",
	["Outdoor bosses - Outland"] = "야외 보스류 - 아웃랜드",
	["Four Dragons"] = "네마리 용류",

	["Gathered by"] = "채집됨",
	["Used by"] = "사용자",
	["Classes"] = "직업",
	["Darkmoon Faire"] = "다크문 유랑단",
	["Darkmoon Faire Card"] = "다크문 유랑단 카드",
	["Found in"] = "발견 장소",
	["Dropped by"] = "드롭됨",
	["Used in"] = "사용처",

	["Fish"] = "물고기",
	["Meat"] = "고기",
	["Bread"] = "빵",
	["Conjured"] = "창조",
	["Cheese"] = "치즈",
	["Fruit"] = "과일",
	["Misc"] = "기타",
	["Fungus"] = "곰팡이류",

	-- Darkmoon Faire
	["Junk Items"] = "잡동사니",
	["Leather"] = "가죽",
	["Blue Dragon Card"] = "푸른용 카드",
	["Heroism Card"] = "영웅심 카드",
	["Twisting Nether Card"] = "뒤틀린 황천 카드",
	["Maelstrom Card"] = "혼돈의 소용돌이 카드",
	["Crusade Card"] = "성전 카드",
	["Vengeance Card"] = "앙갚음 카드",
	["Madness Card"] = "광기 카드",
	["Wrath Card"] = "진노 카드",

	-- Sources
	["Drop"] = "드롭",
	["Vendor"] = "상인",
	["Quest"] = "퀘스트",
	["Crafted"] = "제작",

	["UBRS"] = "첨탑 상층",
	["LBRS"] = "첨탑 하층",
	
	["Heroic"] = "(영웅)",
	
	-- Tier Sets
	["Tier 1 Set"] = "1 단계 셋트(화심)",
	["Tier 2 Set"] = "2 단계 세트(검둥)",
	["Tier 2.5 Set"] = "2.5 단계 셋트(사원)",
	["Tier 3 Set"] = "3 단계 셋트(낙스)",
	["Tier 4 Set"] = "4 단계 셋트(카라잔 등)",
	["Tier 5 Set"] = "5 단계 셋트(검은사원 등)",
	["Tier 6 Set"] = "6 단계 셋트(?)",
	
	-- Arena Sets
	["Arena - Season 1 Set"] = "투기장 - 시즌 1 셋트",
	["Arena - Season 2 Set"] = "투기장 - 시즌 2 셋트",
	["Arena - Season 3 Set"] = "투기장 - 시즌 3 셋트",
	
	["%d%% alc/vol (%d proof)"] = "%d%% alc/vol (%d 도)",
	[" (%d tickets)"] = " (%d 티켓)",

	-- Categories
	["Consumable"] = "소비용품",
	["Gear"] = "장비",
	["GearSet"] = "세트장비",
	["InstanceLoot"] = "던전획득",
	["InstanceLootHeroic"] = "영웅던전획득",
	["Misc"] = "기타",
	["QuestMats"] = "퀘스트재료",
	["Reagent"] = "재료",
	["Tradeskill"] = "전문기술",
	
	["Badge of Justice"] = "정의의 휘장",
	["G'eras"] = "게라스",
	["Smith Hauthaa"] = "Smith Hauthaa", -- check
}end)
