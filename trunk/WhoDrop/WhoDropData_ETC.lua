--[[ 데이터 추가 방법

기본적으로 테이블을 추가하는 방법은...
가장 큰 분류는 대륙명칭으로 나뉩니다.
Babble-Zone-2.2 라이브러리를 사용하기 때문에 영문으로 표기합니다..
그 하위로 인스턴스와 각 지역이 나뉩니다...

인스턴스는 인스턴스 이름 -> 몹 이름 -> 드랍 아이템의 순서로 테이블이 진행됩니다.

예제)
["인스턴스 이름(영문) 추가적으로 인던 종류(-Hero를 붙이면 영웅 인던 |R을 붙이면 공격대 인던)과 테이블 순서(|숫자로 표시)"] = {
	["몹 이름(영문) 추가적으로 몬스터 종류(|B를 붙이면 보스몬스터, |N를 붙일 경우는 네임드)와 테이블 순서(|숫자로 표시)"] = {
		["필드번호"] = "아이템ID",
		...
	},
},

이런식으로 추가할 수 있습니다.

단 순서를 지정하는 |숫자는 항상 맨 끝부분에 와야 합니다..

이름(영던인지여부)(|추가정보)(|테이블순서)의 순서입니다..

만약 특정한 설명이 필요한 아이템이라면..

WhoDropNote 테이블에 아이템 ID 별로 추가를 하면 됩니다.

예제)
WhoDropNote = {
	["아이템ID"] = "설명할 내용...",
	..
}

각 지역별로 나뉘는 분류에 대해서는..

예제)
["지역명(영문)"] = {
	["NPC이름(영문) 추가적으로 진영 표시(|H 나 |A, 중립에 대해서는 표시할 필요가 없습니다.)와 테이블 순서(|숫자로 표시)"] = {
		["퀘스트이름,또는 평판 상인의 경우에는 평판, 교환 아이템의 경우에는 교환가치(영문)"] = {
			["필드번호"] = "아이템ID",
			..
		},
	},
},

이렇게 추가할 수 있습니다.

인스턴스정보와 마찬가지로..

이름(추가정보-진영)(테이블순서)의 단계로 표시되어야 합니다.

지역별 구분이 한 단계가 더 많은 이유는.. 인스턴스는 ["Instance"]라는 다른 분류의 테이블로 구성되기 때문입니다.

로컬지원은..

우선적으로 로컬 파일 상에 해당 단어가 있는지 그 다음으로 Babble-Boss-2.2 다음으로 Babble-Zone-2.2, Babble-Quest-2.2를

확인해서 로컬이 존재하는지 찾고.. 그 중에서 발견되지 않을 경우 본문 그대로를 사용합니다.

만약 Babble-Zone-2.2나 Babble-Boss-2.2, Babble-Quest-2.2에 등록되지 않은 문구의 경우에는 로컬에 추가하셔도 됩니다.


]]

local L = AceLibrary("AceLocale-2.2"):new("WhoDrop")
local BF = AceLibrary("Babble-Faction-2.2")
local BB = AceLibrary("Babble-Boss-2.2")
local BZ = AceLibrary("Babble-Zone-2.2")

WhoDropEtcData = {
	["Reputaion|4"] = {
		["Original"] = {
			["Argent Dawn|1"] = {
				["Warrior|E"] = {
					22418,
					22419,
					22416,
					22423,
					22421,
					22422,
					22417,
					22420,
					23059,
				},
				["Rogue|E"] = {
					22478,
					22479,
					22476,
					22483,
					22481,
					22482,
					22477,
					22480,
					23060,
				},
				["Priest|E"] = {
					22514,
					22515,
					22512,
					22519,
					22517,
					22518,
					22513,
					22516,
					23061,
				},
				["Paladin|E"] = {
					22428,
					22429,
					22425,
					22424,
					22426,
					22431,
					22427,
					22430,
					23066,
				},
				["Mage|E"] = {
					22498,
					22499,
					22496,
					22503,
					22501,
					22502,
					22497,
					22500,
					23062,
				},
				["Shaman|E"] = {
					22466,
					22467,
					22464,
					22471,
					22469,
					22470,
					22465,
					22468,
					23065,
				},
				["Hunter|E"] = {
					22438,
					22439,
					22436,
					22443,
					22441,
					22442,
					22437,
					22440,

				},
				["Warlock|E"] = {
					22506,
					22507,
					22504,
					22511,
					22509,
					22510,
					22505,
					22508,
					23063,
				},
				["Druid|E"] = {
					22490,
					22491,
					22488,
					22495,
					22493,
					22494,
					22489,
					22492,
					23064,
				},
				["Blacksmithing|1"] = {
					19203,
					19205,
				},
				["Leatherworking|2"] = {
					19328,
					19329,
				},
				["Tailoring|3"] = {
					19216,
					19217,
				},
				["Enchanting|4"] = {
					19446,
					19447,
				},
				["Alchemy|5"] = {
					13482,
				},
				["First Aid|6"] = {
					19442,
				},
			},
			["Zandalar Tribe|2"] = {
				["Priest"] = {
					"19843|"..L["Primal Hakkari Stanchion"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19842|"..L["Primal Hakkari Sash"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"19841|"..L["Primal Hakkari Aegis"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19594,
					19958,
				},
				["Paladin"] = {
					"19827|"..L["Primal Hakkari Bindings"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19826|"..L["Primal Hakkari Shawl"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"19825|"..L["Primal Hakkari Tabard"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19952,
					19588,
				},
				["Mage"] = {
					"19846|"..L["Primal Hakkari Bindings"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19845|"..L["Primal Hakkari Shawl"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"20034|"..L["Primal Hakkari Kossack"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19601,
					19959,
				},
				["Warlock"] = {
					"19848|"..L["Primal Hakkari Stanchion"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19849|"..L["Primal Hakkari Sash"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"20033|"..L["Primal Hakkari Kossack"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19605,
					19957,
				},
				["Druid"] = {
					"19840|"..L["Primal Hakkari Stanchion"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19839|"..L["Primal Hakkari Sash"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"19838|"..L["Primal Hakkari Tabard"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19613,
					19955,
				},
				["Warrior"] = {
					"19824|"..L["Primal Hakkari Armsplint"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19823|"..L["Primal Hakkari Girdle"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"19822|"..L["Primal Hakkari Kossack"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19577,
					19951,
				},
				["Rogue"] = {
					"19836|"..L["Primal Hakkari Armsplint"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19835|"..L["Primal Hakkari Girdle"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"19834|"..L["Primal Hakkari Aegis"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19617,
					19954,
				},
				["Hunter"] = {
					"19833|"..L["Primal Hakkari Bindings"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19832|"..L["Primal Hakkari Shawl"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"19831|"..L["Primal Hakkari Aegis"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19621,
					19953,
				},
				["Shaman"] = {
					"19830|"..L["Primal Hakkari Armsplint"]..", "..BF["Zandalar Tribe"].." "..BF["Friendly"],
					"19829|"..L["Primal Hakkari Girdle"]..", "..BF["Zandalar Tribe"].." "..BF["Honored"],
					"19828|"..L["Primal Hakkari Tabard"]..", "..BF["Zandalar Tribe"].." "..BF["Revered"],
					19609,
					19956,
				},
				["Tailoring|1"] = {
					19766,
					19765,
					19764,
				},
				["Leatherworking|2"] = {
					19771,
					19770,
					19773,
					19769,
					19772,
				},
				["Blacksmithing|3"] = {
					19778,
					19781,
					19777,
					19780,
					19776,
					19779,

				},
				["Engineering|4"] = {
					20001,
					20000,
				},
				["Alchemy|5"] = {
					20012,
					20014,
					20011,
					20013,
				},
				["Enchanting|6"] = {
					20757,
					20756,
				},
				["Vendor|7"] = {
				},
			},
			["Thorium Brotherhood|3"] = {
				["Blacksmithing|1"] = {
					17051,
					19206,
					17059,
					17060,
					17052,
					19207,
					20040,
					17049,
					17053,
					19208,
					19209,
					19211,
					19210,
					19212,
				},
				["Leatherworking|2"] = {
					17023,
					19331,
					19330,
					19333,
					17025,
					17022,
					19332,
				},
				["Tailoring|3"] = {
					17018,
					19219,
					17017,
					19220,
				},
				["Enchanting|4"] = {
					19444,
					19448,
					19449,
				},
				["Alchemy|5"] = {
					20761,
				},
			},
			["Cenarion Circle|4"] = {
				["Warrior"] = {
					"21394|"..L["Qiraji Martial Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
					"21392|"..L["Qiraji Spiked Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
					"21393|"..L["Qiraji Magisterial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
				},
				["Rogue"] = {
					"21405|"..L["Qiraji Ceremonial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21404|"..L["Qiraji Spiked Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
					"21406|"..L["Qiraji Martial Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
				},
				["Mage"] = {
					"21414|"..L["Qiraji Magisterial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21413|"..L["Qiraji Ornate Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
					"21415|"..L["Qiraji Martial Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
				},
				["Priest"] = {
					"21412|"..L["Qiraji Ceremonial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
					"21411|"..L["Qiraji Magisterial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21410|"..L["Qiraji Ornate Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
				},
				["Paladin"] = {
					"21397|"..L["Qiraji Regal Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
					"21396|"..L["Qiraji Magisterial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21395|"..L["Qiraji Spiked Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
				},
				["Shaman"] = {
					"21400|"..L["Qiraji Regal Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
					"21399|"..L["Qiraji Magisterial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21398|"..L["Qiraji Spiked Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
				},
				["Hunter"] = {
					"21402|"..L["Qiraji Ceremonial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21403|"..L["Qiraji Regal Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
					"21401|"..L["Qiraji Spiked Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
				},
				["Warlock"] = {
					"21417|"..L["Qiraji Ceremonial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21416|"..L["Qiraji Ornate Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
					"21418|"..L["Qiraji Regal Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
				},
				["Druid"] = {
					"21408|"..L["Qiraji Regal Drape"].."/"..BF["Cenarion Circle"].." "..BF["Revered"],
					"21409|"..L["Qiraji Magisterial Ring"].."/"..BF["Cenarion Circle"].." "..BF["Honored"],
					"21407|"..L["Qiraji Ornate Hilt"].."/"..BF["Cenarion Circle"].." "..BF["Exalted"],
				},
				["Blacksmithing|1"] = {
					22766,
					22767,
					22768,
					22214,
					22209,
					22219,
					22221,
				},
				["Leatherworking|2"] = {
					22771,
					22770,
					22769,
					20508,
					20507,
					20506,
					20511,
					20510,
					20509,
					20382,
				},
				["Tailoring|3"] = {
					22773,
					22774,
					22772,
					22683,
					22310,
					22312,
				},
				["Enchanting|4"] = {
					20732,
					20733,
				},
			},
			["Timbermaw Hold|5"] = {
				["Blacksmithing|1"] = {
					19202,
					19204,
				},
				["Leatherworking|2"] = {
					20253,
					20254,
					19326,
					19327,
				},
				["Tailoring|3"] = {
					19215,
					19218,
				},
				["Enchanting|4"] = {
					19445,
					22392,
				},
				["Alchemy|5"] = {
					13484,
				},
				["Vendor|6"] = {
					21326,
				},
			},
			["Brood of Nozdormu|6"] = {
				["Warrior"] = {
					"21330|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21333|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21329|"..BB["Emperor Vek'nilash"],
					"21332|"..BB["Ouro"],
					"21331|"..BB["C'Thun"],
				},
				["Rogue"] = {
					"21361|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21359|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21360|"..BB["Emperor Vek'lor"],
					"21362|"..BB["Ouro"],
					"21364|"..BB["C'Thun"],
				},
				["Priest"] = {
					"21350|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21349|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21352|"..BB["Ouro"],
					"21348|"..BB["Emperor Vek'nilash"],
					"21351|"..BB["C'Thun"],
				},
				["Paladin"] = {
					"21391|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21388|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21387|"..BB["Emperor Vek'nilash"],
					"21390|"..BB["Ouro"],
					"21389|"..BB["C'Thun"],
				},
				["Mage"] = {
					"21345|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21344|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21346|"..BB["Ouro"],
					"21347|"..BB["Emperor Vek'nilash"],
					"21343|"..BB["C'Thun"],
				},
				["Shaman"] = {
					"21376|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21373|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21375|"..BB["Ouro"],
					"21372|"..BB["Emperor Vek'nilash"],
					"21374|"..BB["C'Thun"],
				},
				["Hunter"] = {
					"21367|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21365|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21366|"..BB["Emperor Vek'lor"],
					"21368|"..BB["Ouro"],
					"21370|"..BB["C'Thun"],
				},
				["Druid"] = {
					"21354|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21355|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21356|"..BB["Ouro"],
					"21353|"..BB["Emperor Vek'lor"],
					"21357|"..BB["C'Thun"],
				},
				["Warlock"] = {
					"21335|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21338|"..BB["Princess Huhuran"].."/"..BB["Viscidus"],
					"21336|"..BB["Ouro"],
					"21337|"..BB["Emperor Vek'nilash"],
					"21334|"..BB["C'Thun"],
				},
				["Ring|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					21201,
					21202,
					21203,
					21204,
					21205,
					L["Tanking"],
					21196,
					21197,
					21198,
					21199,
					21200,
					L["Dealing"].."("..L["Cast"]..")",
					21206,
					21207,
					21208,
					21209,
					21210,
				},
			},
			["Darkmoon Faire|7"] = {
				["Trinket|U|1"] = {
					L["Original"],
					19287,
					19288,
					19289,
					19290,
					L["Expantion"],
					31859,
					31857,
					31858,
					31856,
				},
			},
			["Wintersaber Trainers|8"] = {
			},
		},
		["Expantion"] = {
			["The Aldor|1"] = {
				["Inscription|1"] = {
					"28878|"..L["Holy Dust"].." 2",
					"28881|"..L["Holy Dust"].." 2",
					"28882|"..L["Holy Dust"].." 2",
					"28885|"..L["Holy Dust"].." 2",
					"28887|"..L["Holy Dust"].." 8",
					"28886|"..L["Holy Dust"].." 8",
					"28889|"..L["Holy Dust"].." 8",
					"28888|"..L["Holy Dust"].." 8",
				},
				["Leatherworking|2"] = {
					29693,
					29691,
					29689,
					29704,
					29703,
					29702,
					25721,
				},
				["Blacksmithing|3"] = {
					23601,
					23603,
					23604,
					23602,
				},
				["Jewelcrafting|4"] = {
					23149,
					23145,
					24177,
				},
				["Tailoring|5"] = {
					30842,
					30843,
					30844,
					24293,
					24295,
				},
				["Vendor|6"] = {
					29129,
					29130,
					29127,
					29128,
					29123,
					29124,
					31779,
				},
			},
			["The Scryers|2"] = { -- 점술가 길드
				["Inscription|1"] = {
					"28904|"..L["Arcane Rune"].." 2",
					"28903|"..L["Arcane Rune"].." 2",
					"28908|"..L["Arcane Rune"].." 2",
					"28907|"..L["Arcane Rune"].." 2",
					"28912|"..L["Arcane Rune"].." 8",
					"28909|"..L["Arcane Rune"].." 8",
					"28911|"..L["Arcane Rune"].." 8",
					"28910|"..L["Arcane Rune"].." 8",
				},
				["Leatherworking|2"] = {
					29682,
					29684,
					29677,
					29701,
					29700,
					29698,
					25722,
				},
				["Blacksmithing|3"] = {
					23597,
					23598,
					23599,
					23600,
				},
				["Alchemy|4"] = {
					22908,
				},
				["Jewelcrafting|5"] = {
					23133,
					23143,
					24176,
				},
				["Tailoring|6"] = {
					24292,
					24294,
				},
				["Vendor|7"] = {
					29133,
					29134,
					29131,
					29132,
					29125,
					29126,
					31780,
				},
			},
			["Honor Hold|A|3"] = {
				["Leatherworking|1"] = {
					29213,
					29214,
					34218,
					29215,
					29719,
					29722,
				},
				["Blacksmithing|2"] = {
					23619,
				},
				["Alchemy|3"] = {
					22905,
					25870,
				},
				["Jewelcrafting|4"] = {
					23142,
					24180,
				},
				["Enchanting|5"] = {
					22531,
					22547,
					33150,
				},
				["Inscription|6"] = {
					29196,
					29189,
				},
				["Vendor|7"] = {
					24008,
					24007,
					25825,
					25826,
					29166,
					29169,
					29151,
					29153,
					29156,
					23999,
					29166,
				},
				["Key|8"] = {
					30622,
				},
			},
			["Thrallmar|H|3"] = {
				["Leatherworking|1"] = {
					25738,
					31361,
					25739,
					25740,
					31362,
					34201,
				},
				["Blacksmithing|2"] = {
					24002,
				},
				["Alchemy|3"] = {
					24001,
					29232,
				},
				["Jewelcrafting|4"] = {
					31359,
					31358,
				},
				["Enchanting|5"] = {
					24000,
					24003,
					33151,
				},
				["Inscription|6"] = {
					29190,
					29197,
				},
				["Vendor|7"] = {
					24009,
					24006,
					25824,
					25823,
					29168,
					29167,
					29155,
					29152,
					29165,
					24004,
					32882,
				},
				["Key|8"] = {
					30637,
				},
			},
			["Cenarion Expedition|4"] = {
				["Leatherworking|1"] = {
					25737,
					25736,
					25735,
					29720,
					29721,
				},
				["Blacksmithing|2"] = {
					31392,
					31391,
					31390,
					23618,
					25526,
					28632,
				},
				["Alchemy|3"] = {
					32070,
					31356,
					22922,
					22918,
					25869,
				},
				["Jewelcrafting|4"] = {
					24183,
					31402,
				},
				["Enchanting|5"] = {
					28271,
					33149,
				},
				["Engineering|6"] = {
					23814,
				},
				["Vendor|7"] = {
					24429,
					24417,
					24412,
					25838,
					25835,
					25836,
					29173,
					29174,
					29172,
					29170,
					29171,
					31804,
				},
				["Key|9"] = {
					30623,
				},
				["Inscription|8"] = {
					29194,
					29192,
				},
				["Mount|9"] = {
					33999,
				},
			},
			["The Sha'tar|5"] = {
				["Leatherworking|1"] = {
					29717,
				},
				["Alchemy|2"] = {
					13517,
					31354,
					22915,
				},
				["Jewelcrafting|3"] = {
					25904,
					30826,
					24182,
					33155,
					33159,
				},
				["Enchanting|4"] = {
					28273,
					28281,
					22537,
					33153,
				},
				["Vendor|5"] = {
					29179,
					29180,
					29175,
					29176,
					29177,
					31781,
				},
				["Inscription|6"] = {
					29195,
					29191,
				},
				["Key|7"] = {
					30634,
				},
			},
			["Lower City|6"] = {
				["Alchemy|1"] = {
					31357,
					22910,
				},
				["Jewelcrafting|2"] = {
					23138,
					24175,
					24179,
					33157,
				},
				["Leatherworking|3"] = {
					34200,
				},
				["Tailoring|4"] = {
					30833,
				},
				["Enchanting|5"] = {
					22538,
					33148,
				},
				["Vendor|6"] = {
					30836,
					30841,
					30835,
					30832,
					30830,
					30834,
					31778,
				},
				["Inscription|7"] = {
					29199,
					30846,
				},
				["Key|8"] = {
					30633,
				},
				["Outcast's Cache|9"] = {
					28491,
					28492,
					28493,
					28494,
					28496,
					28495,
					28498,
--					"",
				},
			},
			["Keepers of Time|7"] = {
				["Leatherworking|1"] = {
					29713,
				},
				["Alchemy|2"] = {
					31355,
				},
				["Jewelcrafting|3"] = {
					25910,
					24174,
					24181,
					33158,
					33160,
				},
				["Enchanting|4"] = {
					28272,
					22536,
					33152,
				},
				["Inscription|5"] = {
					29198,
					29186,
				},
				["Vendor|6"] = {
					29184,
					29185,
					29181,
					29182,
					29183,
				},
				["Key|7"] = {
					30635,
				},
			},
			["The Mag'har|H|8"] = {
				["Leatherworking|1"] = {
					25741,
					25742,
					29664,
					25743,
					34173,
					34175,
				},
				["Alchemy|2"] = {
					22917,
				},
				["Mount|3"] = {
					31829,
					31831,
					31833,
					31835,
					29102,
					29104,
					29105,
					29103,
				},
				["Vendor|4"] = {
					29143,
					29141,
					29145,
					29147,
					29139,
					29137,
					29135,
					31773,
				},
			},
			["Kurenai|A|8"] = {
				["Leatherworking|1"] = {
					29217,
					29219,
					29218,
					30444,
				},
				["Alchemy|2"] = {
					30443,
				},
				["Mount|3"] = {
					29230,
					31834,
					29227,
					31830,
					29229,
					31832,
					29231,
					31836,
				},
				["Vendor|4"] = {
					29142,
					29146,
					29136,
					29138,
					29140,
					31774,
					29144,
					29148,
				},
			},
			["Sporeggar|9"] = {
				["Alchemy|1"] = {
					22916, -- 25개
					22906, -- 30개
				},
				["Vendor|2"] = {
					31775, -- 10개
					25548, -- 1개
					25539,
					25550,
					25827,
					25828,
					29149,
					29150,
				},
				["Cooking|3"] = {
					30156, -- 1개
					27689, -- 2개
				},
				["Quest Reward"] = {
					BF["Sporeggar"].." "..BF["Exalted"],
					25538,
					25536,
					25537,
				},
				["Pet"] = {
					34478,--30개
				},
			},
			["The Consortium|10"] = {
				["Leatherworking|1"] = {
					25732,
					25733,
					25734,
				},
				["Enchanting|2"] = {
					28274,
					22552,
					22535,
				},
				["Jewelcrafting|3"] = {
					23155,
					23136,
					23150,
					23134,
					23146,
					25908,
					24178,
					32412,
					25902,
					25903,
					33305,
					33156,
				},
				["Tailoring|4"] = {
					24314,
				},
				["Engineering|5"] = {
					23874,
				},
				["Vendor|6"] = {
					29457,
					31776,
					29117,
					29456,
					29115,
					29121,
					29119,
					29122,
					29116,
					29118,
				},
			},
			["The Scale of the Sands|11"] = {
--[[				["Enchanting|1"] = {
					22538,
				},]]
				["Arrow|2"] = {
					31737,
					31735,
				},
				["Jewelcrafting|U|3"] = {
					 L["Crimson Spinel"],
					32274,
					32282,
					32283,
					32277,
					32281,
					32284,
					L["Empyrean Sapphire"],
					32288,
					32286,
					32287,
					L["Lionseye"],
					32290,
					32293,
					32291,
					32294,
					L["Shadowsong Amethyst"],
					32299,
					32300,
					32301,
					32302,
					L["Pyrestone"],
					32306,
					32305,
					32304,
					32308,
					L["Seaspray Emerald"],
					32311,
					32309,
					32312,
					32310,
				},
				["Quest Reward|U|4"] = {
					L["Dealing"].."("..L["Cast"]..")",
					29302,
					29303,
					29304,
					29305,
					L["Healing"],
					29306,
					29307,
					29308,
					29309,
					L["Dealing"].."("..L["Melee"]..")",
					29298,
					29299,
					29300,
					29301,
					L["Tanking"],
					29294,
					29295,
					29296,
					29297,
				},
			},
			["The Violet Eye|12"] = {
				["Inscription|1"] = {
					29187,
				},
				["Jewelcrafting|2"] = {
					31401,
				},
				["Blacksmithing|3"] = {
					31395,
					31393,
					31394,
				},
				["Enchanting|4"] = {
					33165,
				},
				["Leatherworking|5"] = {
					33124,
					33205,
				},
				["Alchemy|6"] = {
					33209,
				},
				["Quest Reward|U|7"] = {
					L["Healing"],
					"29288|"..BF["The Violet Eye"].." "..BF["Friendly"],
					"29289|"..BF["The Violet Eye"].." "..BF["Honored"],
					"29291|"..BF["The Violet Eye"].." "..BF["Revered"],
					"29290|"..BF["The Violet Eye"].." "..BF["Exalted"],
					L["Dealing"].."("..L["Cast"]..")",
					"29284|"..BF["The Violet Eye"].." "..BF["Friendly"],
					"29285|"..BF["The Violet Eye"].." "..BF["Honored"],
					"29286|"..BF["The Violet Eye"].." "..BF["Revered"],
					"29287|"..BF["The Violet Eye"].." "..BF["Exalted"],
					L["Tanking"],
					"29276|"..BF["The Violet Eye"].." "..BF["Friendly"],
					"29277|"..BF["The Violet Eye"].." "..BF["Honored"],
					"29278|"..BF["The Violet Eye"].." "..BF["Revered"],
					"29279|"..BF["The Violet Eye"].." "..BF["Exalted"],
					L["Dealing"].."("..L["Melee"]..")",
					"29280|"..BF["The Violet Eye"].." "..BF["Friendly"],
					"29281|"..BF["The Violet Eye"].." "..BF["Honored"],
					"29282|"..BF["The Violet Eye"].." "..BF["Revered"],
					"29283|"..BF["The Violet Eye"].." "..BF["Exalted"],
				},
			},
			["Tranquillien|13"] = {
				["Friendly|1"] = {
					22991,
					22992,
					22993,
					28164,
				},
				["Honored|2"] = {
					28155,
					28158,
					28162,
				},
				["Revered|3"] = {
					22986,
					22987,
					22985,
				},
				["Exalted|4"] = {
					22990,
				},
			},
			["Sha'tari Skyguard|14"] = {
				["Vendor|1"] = {
					32722,
					32721,
					32538,
					32539,
					32771,
					32770,
					32445,
				},
				["Mount|2"] = {
					32319,
					32314,
					32317,
					32318,
					32316,
				},
				["Quest Reward|U|3"] = {
					32829,
					32830,
					32831,
					32832,
				},
				["The descendants of Terokk|U|4"] = {
					31555,
					31558,
					31563,
					31566,
					31571,
					31574,
					31579,
					31582,
					32529,
					32514,
					32532,
					32531,
					L["Elite"].." "..L["Level"].." 72 "..L["Beast"].." \n- "..L["Gezzarak the Huntress"]..","..L["Darkscreecher Akkarai"]..","..L["Karrog"]..","..L["Vakkiz the Windrager"],
				},
				["Terokk|5"] = {
					32540,
					32541,
					32536,
					32537,
					32534,

					31556,
					31564,
					31572,
					31580,
				},
			},
			["Netherwing|15"] = {
				["Trinket"] = {
					32694,
					32695,
					32864,
				},
				["Mount"] = {
					32857,
					32858,
					32859,
					32860,
					32861,
					32862,
				},
				["Quest Reward|3"] = {
					31490,
					31491,
					31492,
					31494,
					31493,
					32863,
				},
			},
			["Ashtongue Deathsworn|16"] = {
				["Trinket|1"] = {
					32485,
					32486,
					32487,
					32488,
					32489,
					32490,
					32491,
					32492,
					32493,
				},
				["Blacksmithing|2"] = {
					32441,
					32442,
					32443,
					32444,
				},
				["Leatherworking|3"] = {
					32429,
					32430,
					32431,
					32432,

					32433,
					32434,
					32435,
					32436,
				},
				["Tailoring|4"] = {
					32447,
					32437,
					32438,
					32439,
					32440,
				},
			},


		},
	},
	["Item Set|U|6"] = {
		["Crafted"] = {
			["Blacksmithing"] = {
				["Adamantite Battlegear"] = {
					23507,
					23508,
					23506,
				},
				["Bloodsoul Embrace"] = {
					19690,
					19691,
					19692,
				},
				["Burning Rage"] = {
					23522,
					23521,
					23520,
				},
				["Enchanted Adamantite Armor"] = {
					23509,
					23512,
					23511,
					23510,
				},
				["Faith in Felsteel"] = {
					23519,
					23518,
					23517,
				},
				["Fel Iron Chain"] = {
					23490,
					23491,
					23493,
					23494,
				},
				["Fel Iron Plate"] = {
					23489,
					23488,
					23487,
					23482,
					23484,
				},
				["Imperial Plate"] = {
					12424,
					12426,
					12425,
					12422,
					12427,
					12429,
					12428,
				},
				["Khorium Ward"] = {
					23523,
					23525,
					23524,
				},
				["Shadow Guard"] = {
					23513,
					23516,
					23514,
					23515,
				},
				["The Darksoul"] = {
					19693,
					19694,
					19695,
				},
			},
			["Tailoring"] = {
				["Arcanoweave Vestments"] = {
					21868,
					21866,
					21867,
				},
				["Battlecast Garb"] = {
					24267,
					24263,
				},
				["Bloodvine Garb"] = {
					19682,
					19683,
					19684,
				},
				["Imbued Netherweave"] = {
					21862,
					21861,
					21859,
					21860,
				},
				["Netherweave Vestments"] = {
					21855,
					21854,
					21852,
					21851,
					21849,
					21853,
					21850,
				},
				["Primal Mooncloth"] = {
					21630,
					21874,
					21873,
				},
				["Shadow's Embrace"] = {
					21871,
					21869,
					21870,
				},
				["Soulcloth Embrace"] = {
					21865,
					21864,
					21863,
				},
				["Spellstrike Infusion"] = {
					24266,
					24262,
				},
				["The Unyielding"] = {
					24255,
					24249,
				},
				["Whitemend Wisdom"] = {
					24264,
					24261,
				},
				["Wrath of Spellfire"] = {
					21848,
					21847,
					21846,
				},
			},
			["Leatherworking"] = {
				["Black Dragon Mail"] = {
					16984,
					15050,
					15052,
					15051,
				},
				["Blue Dragon Mail"] = {
					15048,
					20295,
					15049,
				},
				["Blood Tiger Harness"] = {
					19688,
					19689,
				},
				["Devilsaur Armor"] = {
					15062,
					15063,
				},
				["Fel Skin"] = {
					25685,
					25686,
					25687,
				},
				["Felscale Armor"] = {
					25657,
					25656,
					25655,
					25654,
				},
				["Felstalker Armor"] = {
					25695,
					25697,
					25696,
				},
				["Fury of the Nether"] = {
					25694,
					25693,
					25692,
				},
				["Green Dragon Mail"] = {
					15045,
					15046,
					20296,
				},
				["Ironfeather Armor"] = {
					15066,
					15067,
				},
				["Netherscale Armor"] = {
					29516,
					29517,
					29515,
				},
				["Netherstrike Armor"] = {
					29521,
					29520,
					29519,
				},
				["Primal Batskin"] = {
					19685,
					19687,
					19686,
				},
				["Primal Intent"] = {
					29527,
					29526,
					29525,
				},
				["Scaled Draenic Armor"] = {
					25661,
					25659,
					25662,
					25660,
				},
				["Stormshroud Armor"] = {
					15056,
					15057,
					15058,
					21278,
				},
				["Strength of the Clefthoof"] = {
					25691,
					25690,
					25689,
				},
				["Thick Draenic Armor"] = {
					25668,
					25669,
					25670,
					25671,
				},
				["Volcanic Armor"] = {
					15053,
					15054,
					15055,
				},
				["Wild Draenish Armor"] = {
					25673,
					25674,
					25675,
					25676,
				},
				["Windhawk Armor"] = {
					29523,
					29524,
					29522,
				},
			},
		},
		["Dungeon"] = {
			["Scarlet Monastery|E"] = {
				["Chain of the Scarlet Crusade|E"] = {
					10330,
					10328,
					10331,
					10329,
					10332,
					10333,
				},
			},
			["Upper Blackrock Spire|E"] = {
				["Dal'Rend's Arms"] = {
					12940,
					12939,
				},
			},
			["Blackrock Depths|E"] = {
				["The Gladiator"] = {
					11726,
					11728,
					11729,
					11730,
					11731,
				},
			},
			["Lower Blackrock Spire|E"] ={
				["Spider's Kiss"] = {
					13183,
					13218,
				},
			},
			["Stratholme|E"] = {
				["The Postmaster"] = {
					13388,
					13389,
					13390,
					13391,
					13392,
				},
			},
			["Scholomance|E"] = {
				["Cadaverous Garb"] = {
					14636,
					14637,
					14638,
					14640,
					14641,
				},
				["Necropile Raiment"] = {
					14626,
					14629,
					14631,
					14632,
					14633,
				},
				["Bloodmail Regalia"]	= {
					14614,
					14616,
					14615,
					14611,
					14612,
				},
				["Deathbone Guardian"] = {
					14624,
					14622,
					14620,
					14623,
					14621,
				},
			},
			["The Deadmines|E"] = {
				["Defias Leather"] = {
					10399,
					10403,
					10402,
					10401,
					10400,
				},
			},
			["Ragefire Chasm|E"] = {
				["Embrace of the Viper"] = {
					10412,
					10411,
					10413,
					10410,
					6473,
				},
			},
			["Zul'Gurub|E"] = {
				["Major Mojo Infusion"] = {
					19898,
					19925,
				},
				["Overlord's Resolution"] = {
					19873,
					19912,
				},
				["Prayer of the Primal"] = {
					19863,
					19920,
				},
				["Primal Blessing"] = {
					19896,
					19910,
				},
				["The Twin Blades of Hakkari"] = {
					19865,
					19866,
				},
				["Zanzil's Concentration"] = {
					19905,
					19893,
				},
			},
			["World Drop"] = {
				["Ironweave Battlesuit|E"] = {
					22306,
					22311,
					22313,
					22302,
					22304,
					22305,
					22303,
					22301,
				},
				["Shard of the Gods|E"] = {
					17082,
					17064,
				},
				["Spirit of Eskhandar|E"] = {
					18203,
					18202,
					18204,
					18205,
				},
				["The Twin Stars"] = {
					31339,
					31338,
				},
			},
			["Event|E"] = {
				["Battlegear of Undead Slaying"]	= {
					23090,
					23087,
					23078,
				},
				["Garb of the Undead Slayer"] = {
					23088,
					23082,
					23092,
				},
				["Regalia of Undead Cleansing"] = {
					23091,
					23084,
					23085,
				},
				["Undead Slayer's Armor"] = {
					23081,
					23089,
					23093,
				},
			},
			["Silithus|E"] = {
				["Twilight Trappings"] = {
					20406,
					20408,
					20407,
				},
			},

			["T1|E|7"] = {
				["Druid"] = {
					16716,
					16715,
					16714,
					16720,
					16706,
					16718,
					16719,
					16717,
				},
				["Hunter"] = {
					16680,
					16675,
					16681,
					16677,
					16674,
					16678,
					16679,
					16676,
				},
				["Mage"] = {
					16685,
					16683,
					16686,
					16684,
					16687,
					16689,
					16688,
					16682,
				},
				["Paladin"] = {
					16723,
					16725,
					16722,
					16726,
					16724,
					16728,
					16729,
					16727,
				},
				["Priest"] = {
					16696,
					16691,
					16697,
					16693,
					16692,
					16695,
					16694,
					16690,
				},
				["Rogue"] = {
					16713,
					16711,
					16710,
					16721,
					16708,
					16709,
					16712,
					16707,
				},
				["Shaman"] = {
					16673,
					16670,
					16671,
					16667,
					16672,
					16668,
					16669,
					16666,
				},
				["Warlock"] = {
					16702,
					16703,
					16699,
					16701,
					16700,
					16704,
					16698,
					16705,
				},
				["Warrior"] = {
					16736,
					16734,
					16735,
					16730,
					16737,
					16731,
					16732,
					16733,
				},
			},
			["T2|E|7"] = {
				["Druid"] = {
					22106,
					22107,
					22108,
					22109,
					22110,
					22111,
					22112,
					22113,
				},
				["Hunter"] = {
					22010,
					22011,
					22061,
					22013,
					22015,
					22016,
					22017,
					22060,
				},
				["Mage"] = {
					22062,
					22063,
					22064,
					22065,
					22066,
					22067,
					22068,
					22069,
				},
				["Paladin"] = {
					22086,
					22087,
					22088,
					22089,
					22090,
					22091,
					22092,
					22093,
				},
				["Priest"] = {
					22078,
					22079,
					22080,
					22081,
					22082,
					22083,
					22084,
					22085,
				},
				["Rogue"] = {
					22002,
					22003,
					22004,
					22005,
					22006,
					22007,
					22008,
					22009,
				},
				["Shaman"] = {
					22095,
					22096,
					22097,
					22098,
					22099,
					22100,
					22101,
					22102,
				},
				["Warlock"] = {
					22070,
					22071,
					22072,
					22073,
					22074,
					22075,
					22076,
					22077,
				},
				["Warrior"] = {
					21994,
					21995,
					21996,
					21997,
					21998,
					21999,
					22000,
					22001,
				},
			},
			["T3|E|7"] = {
				["Priest"] = {
					28413,
					27775,
					28230,
					27536,
					27875,
				},
				["Paladin"] = {
					28285,
					27739,
					28203,
					27535,
					27839,
				},
				["Mage"] = {
					28278,
					27738,
					28229,
					27508,
					27838,
				},
				["Warlock"] = {
					28415,
					27778,
					28232,
					27537,
					27948,
				},
				["Druid"] = {
					28348,
					27737,
					28202,
					27468,
					27873,
				},
				["Warrior"] = {
					28350,
					27803,
					28205,
					27475,
					27977,
				},
				["Rogue"] = {
					28414,
					27776,
					28204,
					27509,
					27908,
				},
				["Hunter"] = {
					28275,
					27801,
					28228,
					27474,
					27874,
				},
				["Shaman"] = {
					28349,
					27802,
					28231,
					27510,
					27909,
				},
				["Cloth|10"] = {
					28193,
					27796,
					28191,
					27465,
					27907,
				},
				["Leather|11"] = {
					28224,
					27797,
					28264,
					27531,
					27837,
				},
				["Mail|12"] = {
					28192,
					27713,
					28401,
					27528,
					27936,
				},
				["Plate|13"] = {
					28225,
					27771,
					28403,
					27497,
					27870,
				},
			},
		},
		["Raid"] = {
			["T1|E|1"] = {
				["Priest"] = {
					16813,
					16816,
					16815,
					16819,
					16812,
					16817,
					16814,
					16811,
				},
				["Paladin"] = {
					16854,
					16856,
					16853,
					16857,
					16860,
					16858,
					16855,
					16859,
				},
				["Mage"] = {
					16795,
					16797,
					16798,
					16799,
					16801,
					16802,
					16796,
					16800,
				},
				["Warlock"] = {
					16808,
					16807,
					16809,
					16804,
					16805,
					16806,
					16810,
					16803,
				},
				["Druid"] = {
					16834,
					16836,
					16833,
					16830,
					16831,
					16828,
					16835,
					16829,
				},
				["Warrior"] = {
					16866,
					16868,
					16865,
					16861,
					16863,
					16864,
					16867,
					16862,
				},
				["Rogue"] = {
					16821,
					16823,
					16820,
					16825,
					16826,
					16827,
					16822,
					16824,
				},
				["Hunter"] = {
					16846,
					16848,
					16845,
					16850,
					16852,
					16851,
					16847,
					16849,
				},
				["Shaman"] = {
					16842,
					16844,
					16841,
					16840,
					16839,
					16838,
					16843,
					16837,
				},
			},
			["T2|E|2"] = {
				["Priest"] = {
					16921,
					16924,
					16923,
					16926,
					16920,
					16925,
					16922,
					16919,
				},
				["Paladin"] = {
					16955,
					16953,
					16958,
					16951,
					16956,
					16952,
					16954,
					16957,
				},
				["Mage"] = {
					16914,
					16917,
					16916,
					16918,
					16913,
					16818,
					16915,
					16912,
				},
				["Warlock"] = {
					16929,
					16932,
					16931,
					16934,
					16928,
					16933,
					16930,
					16927,
				},
				["Druid"] = {
					16900,
					16902,
					16897,
					16904,
					16899,
					16903,
					16901,
					16898,
				},
				["Warrior"] = {
					16963,
					16961,
					16966,
					16959,
					16964,
					16960,
					16962,
					16965,
				},
				["Rogue"] = {
					16908,
					16832,
					16905,
					16911,
					16907,
					16910,
					16909,
					16906,
				},
				["Hunter"] = {
					16939,
					16937,
					16942,
					16935,
					16940,
					16936,
					16938,
					16941,
				},
				["Shaman"] = {
					16947,
					16945,
					16950,
					16943,
					16948,
					16944,
					16946,
					16949,
				},
			},
			["T2~5|E|3"] = {
				["Priest"] = {
					"21348|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'nilash"],
					"21350|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21351|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21352|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21349|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Paladin"] = {
					"21387|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'nilash"],
					"21391|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21389|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21390|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21388|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Mage"] = {
					"21347|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'nilash"],
					"21345|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21343|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21346|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21344|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Warlock"] = {
					"21337|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'nilash"],
					"21335|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21334|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21336|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21338|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Druid"] = {
					"21353|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'lor"],
					"21354|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21357|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21356|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21355|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Warrior"] = {
					"21329|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'nilash"],
					"21330|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21331|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21332|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21333|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Rogue"] = {
					"21360|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'lor"],
					"21361|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21364|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21362|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21359|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Hunter"] = {
					"21366|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'lor"],
					"21367|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21370|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21368|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21365|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
				["Shaman"] = {
					"21372|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Emperor Vek'nilash"],
					"21376|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
					"21374|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["C'Thun"],
					"21375|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Ouro"],
					"21373|"..BZ["Temple of Ahn'Qiraj"].."-"..BB["Princess Huhuran"],
				},
			},
			["T3|4"] = {
				["Priest"] = {
					"22514|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22515|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22512|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22519|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22517|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22518|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22513|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22516|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23061|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Paladin"] = {
					"22428|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22429|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22425|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22424|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22426|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22431|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22427|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22430|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23066|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Mage"] = {
					"22498|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22499|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22496|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22503|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22501|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22502|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22497|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22500|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23062|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Warlock"] = {
					"22506|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22507|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22504|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22511|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22509|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22510|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22505|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22508|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23063|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Druid"] = {
					"22490|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22491|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22488|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22495|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22493|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22494|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22489|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22492|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23064|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Warrior"] = {
					"22418|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22419|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22416|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22423|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22421|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22422|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22417|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22420|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23059|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Rogue"] = {
					"22478|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22479|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22476|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22483|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22481|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22482|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22477|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22480|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23060|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Hunter"] = {
					"22438|"..BZ["Naxxramas"].."-"..BB["Thaddius"],
					"22439|"..BZ["Naxxramas"].."-"..BB["Patchwerk"].."/"..BB["Grobbulus"].."/"..BB["Gluth"],
					"22436|"..BZ["Naxxramas"].."-"..BB["The Four Horsemen"],
					"22443|"..BZ["Naxxramas"].."-"..BB["Anub'Rekhan"].."/"..BB["Grand Widow Faerlina"].."/"..BB["Gluth"],
					"22441|"..BZ["Naxxramas"].."-"..BB["Maexxna"],
					"22442|"..BZ["Naxxramas"].."-"..BB["Noth the Plaguebringer"].."/"..BB["Heigan the Unclean"].."/"..BB["Gluth"],
					"22437|"..BZ["Naxxramas"].."-"..BB["Loatheb"],
					"22440|"..BZ["Naxxramas"].."-"..BB["Instructor Razuvious"].."/"..BB["Gothik the Harvester"].."/"..BB["Gluth"],
					"23067|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
				["Shaman|E"] = {
					22466,
					22467,
					22464,
					22471,
					22469,
					22470,
					22465,
					22468,
					"23065|"..BZ["Naxxramas"].."-"..BB["Kel'Thuzad"],
				},
			},
			["T4|5"] = {
				["Priest|U"] = {
					L["Healing"],
					"29049|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29054|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29050|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29055|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29053|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Dealing"],
					"29058|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29060|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29056|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29057|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29059|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Paladin|U"] = {
					L["Healing"],
					"29061|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29064|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29062|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29065|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29063|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Dealing"],
					"29073|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29075|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29071|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29072|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29074|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Tanking"],
					"29068|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29070|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29068|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29067|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29069|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Mage"] = {
					"29076|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29079|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29077|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29080|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29078|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Warlock"] = {
					"28963|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"28967|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"28964|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"28968|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"28966|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Druid|U"] = {
					L["Healing"],
					"29086|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29089|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29087|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29090|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29088|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Dealing"].."("..L["Melee"]..")",
					"29098|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29100|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29096|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29097|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29099|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Dealing"].."("..L["Cast"]..")",
					"29093|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29095|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29091|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29092|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29094|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Warrior|U"] = {
					L["Tanking"],
					"29011|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29016|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29012|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29017|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29015|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Dealing"],
					"29021|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29023|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29019|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29020|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29022|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Rogue"] = {
					"29044|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29047|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29045|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29048|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29046|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Hunter"] = {
					"29081|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29084|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29082|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29085|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29083|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
				["Shaman|U"] = {
					L["Healing"],
					"29028|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29031|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29029|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29032|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29030|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Dealing"].."("..L["Melee"]..")",
					"29040|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29043|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29038|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29039|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29042|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
					L["Dealing"].."("..L["Cast"]..")",
					"29035|"..BZ["Karazhan"].."-"..BB["Prince Malchezaar"],
					"29037|"..BZ["Gruul's Lair"].."-"..BB["High King Maulgar"],
					"29033|"..BZ["Magtheridon's Lair"].."-"..BB["Magtheridon"],
					"29034|"..BZ["Karazhan"].."-"..BB["The Curator"],
					"29036|"..BZ["Gruul's Lair"].."-"..BB["Gruul the Dragonkiller"],
				},
			},
			["T5|6"] = {
				["Priest|U"] = {
					L["Healing"],
					"30152|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30154|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30150|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30151|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30153|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Dealing"],
					"30161|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30163|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30159|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30160|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30162|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Paladin|U"] = {
					L["Healing"],
					"30136|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30138|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30134|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30135|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30137|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Dealing"],
					"30125|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30127|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30123|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30124|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30126|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Tanking"],
					"30131|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30133|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30129|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30130|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30132|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Mage"] = {
					"30206|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30210|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30196|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30205|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30207|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Warlock"] = {
					"30212|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30215|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30214|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30211|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30213|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Druid|U"] = {
					L["Healing"],
					"30219|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30221|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30216|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30217|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30220|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Dealing"].."("..L["Melee"]..")",
					"30228|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30230|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30222|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30223|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30229|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Dealing"].."("..L["Cast"]..")",
					"30233|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30235|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30231|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30232|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30234|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Warrior|U"] = {
					L["Tanking"],
					"30115|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30117|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30113|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30114|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30116|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Dealing"],
					"30120|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30122|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30118|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30119|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30121|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Rogue"] = {
					"30146|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30149|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30144|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30145|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30148|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Hunter"] = {
					"30141|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30143|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30139|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30140|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30142|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
				["Shaman|U"] = {
					L["Healing"],
					"30166|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30168|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30164|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30165|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30167|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Dealing"].."("..L["Melee"]..")",
					"30190|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30194|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30185|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30189|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30192|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
					L["Dealing"].."("..L["Cast"]..")",
					"30171|"..BZ["Serpentshrine Cavern"].."-"..BB["Lady Vashj"],
					"30173|"..BZ["Tempest Keep"].."-"..BB["Void Reaver"],
					"30169|"..BZ["Tempest Keep"].."-"..BB["Kael'thas Sunstrider"],
					"30170|"..BZ["Serpentshrine Cavern"].."-"..BB["Leotheras the Blind"],
					"30172|"..BZ["Serpentshrine Cavern"].."-"..BB["Fathom-Lord Karathress"],
				},
			},
			["T6|7"] = {
				["Warrior|U"] = {
					L["Tanking"],
					"30974|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"30980|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"30976|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"30970|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"30978|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Dealing"],
					"30972|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"30979|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"30975|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"30969|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"30977|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Paladin|U"] = {
					L["Dealing"],
					"30989|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"30997|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"30990|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"30982|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"30993|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Tanking"],
					"30987|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"30998|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"30991|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"30985|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"30995|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Healing"],
					"30988|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"30996|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"30992|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"30983|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"30994|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Shaman|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"31015|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31024|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31018|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31011|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31021|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Dealing"].."("..L["Cast"]..")",
					"31014|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31023|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31017|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31008|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31020|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Healing"],
					"31012|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31022|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31016|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31007|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31019|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Hunter"] = {
					"31003|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31006|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31004|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31001|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31005|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Rogue"] = {
					"31027|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31030|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31028|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31026|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31029|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Druid|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"31039|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31048|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31042|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31034|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31044|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Dealing"].."("..L["Cast"]..")",
					"31040|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31049|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31043|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31035|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31046|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Healing"],
					"31037|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31047|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31041|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31032|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31045|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Priest|U"] = {
					L["Healing"],
					"31063|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31069|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31066|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31060|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31068|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					L["Dealing"],
					"31064|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31070|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31065|"..BZ["Black Temple"].." - "..BB["Illidan Stormrage"],
					"31061|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31067|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Mage"] = {
					"31056|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31059|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31057|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					"31055|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31058|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
				["Warlock"] = {
					"31051|"..BZ["Hyjal Summit"].." - "..BB["Archimonde"],
					"31054|"..BZ["Black Temple"].." - "..BB["Mother Shahraz"],
					"31052|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
					"31050|"..BZ["Hyjal Summit"].." - "..BB["Azgalor"],
					"31053|"..BZ["Black Temple"].." - "..BB["Illidari Council"],
				},
			},
		},
	},
	["PvP|U|5"] = {
		["Arena"] = {
			["Season 1|1"] = {
				["Warrior"] = {
					"24545|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"24546|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"24544|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"24549|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"24547|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Paladin|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"27881|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"27883|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"27879|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"27880|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"27882|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					L["Dealing"].."("..L["Cast"]..")",
					"27704|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"27706|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"27702|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"27703|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"27705|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					L["Healing"],
					"31616|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"31619|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"31613|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"31614|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"31618|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Shaman|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"25998|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"25999|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"25997|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"26000|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"26001|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					L["Dealing"].."("..L["Cast"]..")",
					"27471|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"27473|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"27469|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"27470|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"27472|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					L["Healing"],
					"31400|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"31407|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"31396|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"31397|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"31406|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Hunter"] = {
					"28331|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"28333|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"28334|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"28335|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"28332|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Rogue"] = {
					"25830|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"25832|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"25831|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"25834|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"25833|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Druid|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"28127|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"28129|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"28130|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"28126|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"28128|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					L["Dealing"].."("..L["Cast"]..")",
					"28137|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"28139|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"28140|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"28136|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"28138|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					L["Healing"],
					"31376|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"31378|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"31379|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"31375|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"31377|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Priest|U"] = {
					L["Healing"],
					"31410|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"31412|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"31413|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"31409|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"31411|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					L["Dealing"],
					"27708|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"27710|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"27711|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"27707|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"27709|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Mage|U"] = {
					"25855|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"25854|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"25856|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"25857|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"25858|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Warlock|U"] = {
					"Affliction",
					"24553|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"24554|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"24552|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"24556|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"24555|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
					"Destruction",
					"30187|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30",
					"30186|"..L["PvP"].." "..L["Point"].." 11250"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20",
					"30200|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30",
					"30188|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20",
					"30201|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30",
				},
				["Weapon|10"] = {
					"28305|"..L["PvP"].." "..L["Point"].." 18000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28313|"..L["PvP"].." "..L["Point"].." 18000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28308|"..L["PvP"].." "..L["Point"].." 18000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28295|"..L["PvP"].." "..L["Point"].." 18000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28312|"..L["PvP"].." "..L["Point"].." 18000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28476|"..L["PvP"].." "..L["Point"].." 27000"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40",
					"28299|"..L["PvP"].." "..L["Point"].." 27000"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40",
					"28298|"..L["PvP"].." "..L["Point"].." 27000"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40",
					"24550|"..L["PvP"].." "..L["Point"].." 27000"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40",
					"24557|"..L["PvP"].." "..L["Point"].." 27000"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40",
					"28297|"..L["PvP"].." "..L["Point"].." 25200"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28300|"..L["PvP"].." "..L["Point"].." 27000"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40",
					"32450|"..L["PvP"].." "..L["Point"].." 25200"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"32451|"..L["PvP"].." "..L["Point"].." 25200"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
				},
				["Ranged weapon|11"] = {
					"28294|"..L["PvP"].." "..L["Point"].." 27000"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40",
				},
				["Off Hand|12"] = {
					"28302|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28309|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28314|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28307|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28310|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"28358|"..L["PvP"].." "..L["Point"].." 14500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 30",
				},
				["Held in Off-Hand|13"] = {
					"28346|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
					"32452|"..L["PvP"].." "..L["Point"].." 10500"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 20",
				},
				["Relic|14"] = {
					"28357|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10",
					"28355|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10",
					"28356|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10",
					"28319|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10",
					"28320|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10",
					"33945|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 검투사의 결의의 우상
					"33942|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 검투사의 불변의 우상
					"33936|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 검투사의 인내의 성서
					"33948|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 검투사의 복수의 성서
					"33939|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 검투사의 불굴의 토템
					"33951|"..L["PvP"].." "..L["Point"].." 8000"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 검투사의 생존의 토템
				},
			},
			["Season 2|2"] = {
				["Warrior"] = {
					"30488|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"30490|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"30486|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"30487|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"30489|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Paladin|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"32041|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32043|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32039|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32040|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32042|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					L["Dealing"].."("..L["Cast"]..")",
					"31997|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31996|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"31992|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31993|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31995|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					L["Healing"],
					"32022|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32024|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32020|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32021|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32023|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Shaman|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"32006|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32008|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32004|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32005|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32007|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					L["Dealing"].."("..L["Cast"]..")",
					"32011|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32013|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32009|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32010|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32012|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					L["Healing"],
					"32031|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32033|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32029|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32030|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32032|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Hunter"] = {
					"31962|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31964|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"31960|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31961|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31963|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],

				},
				["Rogue"] = {
					"31999|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32001|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32002|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31998|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32000|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Druid|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					"31968|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31971|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"31972|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31967|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31969|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					L["Dealing"].."("..L["Cast"]..")",
					"32057|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32059|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32060|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32056|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32058|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					L["Healing"],
					"31988|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31990|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"31991|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31987|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31989|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Priest|U"] = {
					L["Healing"],
					"32016|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32018|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32019|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32015|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32017|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					L["Dealing"],
					"32035|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32037|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32038|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32034|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32036|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Mage|U"] = {
					"32048|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32047|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"32050|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"32049|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32051|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],

				},
				["Warlock|U"] = {
					"Affliction",
					"31974|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31976|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"31977|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31973|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31975|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"Destruction",
					"31980|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31979|"..L["Arena"].." "..L["Point"].." 1304"..L["p"],
					"31982|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"31981|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31983|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Weapon|10"] = {
					"31984|"..L["Arena"].." "..L["Point"].." 3261"..L["p"],
					"31959|"..L["Arena"].." "..L["Point"].." 3261"..L["p"],
					"31966|"..L["Arena"].." "..L["Point"].." 3261"..L["p"],
					"32025|"..L["Arena"].." "..L["Point"].." 3261"..L["p"],
					"32014|"..L["Arena"].." "..L["Point"].." 3261"..L["p"],
					"32052|"..L["Arena"].." "..L["Point"].." 2283"..L["p"],
					"31965|"..L["Arena"].." "..L["Point"].." 2283"..L["p"],
					"32026|"..L["Arena"].." "..L["Point"].." 2283"..L["p"],
					"32028|"..L["Arena"].." "..L["Point"].." 2283"..L["p"],
					"32044|"..L["Arena"].." "..L["Point"].." 2283"..L["p"],
					"32963|"..L["Arena"].." "..L["Point"].." 3150"..L["p"],
					"32964|"..L["Arena"].." "..L["Point"].." 3150"..L["p"],
					"32053|"..L["Arena"].." "..L["Point"].." 3150"..L["p"],
					"32055|"..L["Arena"].." "..L["Point"].." 3261"..L["p"],
				},
				["Ranged weapon|11"] = {
					"31986|"..L["Arena"].." "..L["Point"].." 3261"..L["p"],
					"32054|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"32962|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
				},
				["Off Hand|12"] = {
					"32027|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32046|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31958|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"31985|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32003|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32045|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"33313|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
					"33309|"..L["Arena"].." "..L["Point"].." 1630"..L["p"],
				},
				["Held in Off-Hand|13"] = {
					"31978|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
					"32961|"..L["Arena"].." "..L["Point"].." 978"..L["p"],
				},
				["Relic|14"] = {
					"33076|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33937|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33946|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33943|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33949|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33077|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33940|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33952|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
					"33078|"..L["Arena"].." "..L["Point"].." 870"..L["p"],
				},
			},
			["Season 3|3"] = {
				["Warrior"] = {
					-- 전사(전투의 복수심에 불타는 검투사 갑옷)-무분
					"33730|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 판금 투구
					"33732|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 판금 어깨보호구
					"33728|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 판금 흉갑
					"33729|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 판금 건틀릿
					"33731|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 판금 다리보호대
				},
				["Paladin|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					-- 성기사(비호의 복수심에 불타는 검투사 방어구)-징벌
					"33751|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 미늘 투구
					"33753|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 미늘 어깨보호구
					"33749|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 미늘 흉갑
					"33750|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 미늘 건틀릿
					"33752|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 미늘 다리보호대
					L["Dealing"].."("..L["Cast"]..")",
					-- 성기사(심판의 복수심에 불타는 검투사 전투장비)-신성[뎀증]
					"33697|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 강철 투구
					"33699|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 강철 어깨보호구
					"33695|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 강철 흉갑
					"33696|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 강철 건틀릿
					"33698|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 강철 다리보호대
					L["Healing"],
					-- 성기사(구원의 복수심에 불타는 검투사 방어구)-신성[힐증]
					"33724|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 문장 면갑
					"33726|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 문장 어깨갑옷
					"33722|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 문장 가슴보호구
					"33723|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 문장 장갑
					"33725|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 문장 다리갑옷
				},
				["Shaman|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					-- 주술사(지각변동의 복수심에 불타는 검투사 방어구)-고양
					"33708|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 사슬매듭 투구
					"33710|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 사슬매듭 어깨갑옷
					"33706|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 사슬매듭 갑옷
					"33707|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 사슬매듭 건틀릿
					"33709|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 사슬매듭 다리보호구
					L["Dealing"].."("..L["Cast"]..")",
					-- 주술사(천둥주먹의 복수심에 불타는 검투사 방어구)-정기
					"33713|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 쇠사슬 투구
					"33715|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 쇠사슬 어깨갑옷
					"33711|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 쇠사슬 갑옷
					"33712|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 쇠사슬 건틀릿
					"33714|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 쇠사슬 다리보호구
					L["Healing"],
					-- 주술사(전세의 복수심에 불타는 검투사 방어구)-복원
					"33740|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 고리사슬 투구
					"33742|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 고리사슬 어깨갑옷
					"33738|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 고리사슬 갑옷
					"33739|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 고리사슬 건틀릿
					"33741|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 고리사슬 다리보호구
				},
				["Hunter"] = {
					-- 사냥꾼(추적의 복수심에 불타는 검투사 장비)
					"33666|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 사슬 투구
					"33668|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 사슬 어깨갑옷
					"33664|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 사슬 갑옷
					"33665|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 사슬 건틀릿
					"33667|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 사슬 다리보호구
				},
				["Rogue"] = {
					-- 도적(암살의 복수심에 불타는 검투사 제복)
					"33701|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 가죽 투구
					"33703|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 가죽 어깨갑옷
					"33704|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 가죽 튜닉
					"33700|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 가죽 장갑
					"33702|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 가죽 다리보호대
				},
				["Druid|U"] = {
					L["Dealing"].."("..L["Melee"]..")",
					-- 드루이드(성역의 복수심에 불타는 검투사 의복)-야성
					"33672|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 용가죽 투구
					"33674|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 용가죽 어깨갑옷
					"33675|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 용가죽 튜닉
					"33671|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 용가죽 장갑
					"33673|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 용가죽 다리보호대
					L["Dealing"].."("..L["Cast"]..")",
					-- 드루이드(야생의 복수심에 불타는 검투사 방어구)-조화
					"33768|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 고룡가죽 투구
					"33770|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 고룡가죽 어깨갑옷
					"33771|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 고룡가죽 튜닉
					"33767|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 고룡가죽 장갑
					"33769|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 고룡가죽 다리보호대
					L["Healing"],
					-- 드루이드(위안의 복수심에 불타는 검투사 의복)-회복
					"33691|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 코도가죽 투구
					"33693|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 코도가죽 어깨갑옷
					"33694|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 코도가죽 조끼
					"33690|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 코도가죽 장갑
					"33692|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 코도가죽 다리보호대
				},
				["Priest|U"] = {
					L["Healing"],
					-- 사제(신탁의 복수심에 불타는 검투사 예복)-신성
					"33718|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 달빛매듭 두건
					"33720|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 달빛매듭 어깨보호대
					"33721|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 달빛매듭 로브
					"33717|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 달빛매듭 장갑
					"33719|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 달빛매듭 다리보호구
					L["Dealing"],
					-- 사제(믿음의 복수심에 불타는 검투사 예복)-암흑
					"33745|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 명주 두건
					"33747|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 명주 어깨보호대
					"33748|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 명주 로브
					"33744|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 명주 장갑
					"33746|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 명주 다리보호구
				},
				["Mage|U"] = {
					-- 마법사(비전의 복수심에 불타는 검투사 의복)
					"33758|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 비단 두건
					"33757|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 비단 아미스
					"33760|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 비단 의복
					"33759|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 비단 손보호대
					"33761|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 비단 바지
				},
				["Warlock|U"] = {
					"Affliction",
					-- 흑마법사(공포의 복수심에 불타는 검투사 전투장비)-[뎀증]
					"33677|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 공포매듭 두건
					"33679|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 공포매듭 어깨보호대
					"33680|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 공포매듭 로브
					"33676|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 공포매듭 장갑
					"33678|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 공포매듭 다리보호구
					"Destruction",
					-- 흑마법사(악마의 복수심에 불타는 검투사 수의)-[극대]
					"33683|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 지옥매듭 두건
					"33682|"..L["Arena"].." "..L["Point"].." 1500"..L["p"],  -- 복수심에 불타는 검투사의 지옥매듭 아미스
					"33685|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 지옥매듭 의복
					"33684|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 지옥매듭 장갑
					"33686|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 지옥매듭 바지
				},
				["Weapon|10"] = {
					-- 무기
					"33688|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 대검
					"33663|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 해골망치
					"33670|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 참수도끼
					"33727|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 내릴톱
					"33762|"..L["Arena"].." "..L["Point"].." 2625"..L["p"],  -- 복수심에 불타는 검투사의 절단검
					"33669|"..L["Arena"].." "..L["Point"].." 2625"..L["p"],  -- 복수심에 불타는 검투사의 클레버
					"33733|"..L["Arena"].." "..L["Point"].." 2625"..L["p"],  -- 복수심에 불타는 검투사의 뾰족철퇴
					"33737|"..L["Arena"].." "..L["Point"].." 2625"..L["p"],  -- 복수심에 불타는 검투사의 오른갈퀴
					"33754|"..L["Arena"].." "..L["Point"].." 2625"..L["p"],  -- 복수심에 불타는 검투사의 단도
					"33687|"..L["Arena"].." "..L["Point"].." 3150"..L["p"],  -- 복수심에 불타는 검투사의 망치
					"33743|"..L["Arena"].." "..L["Point"].." 3150"..L["p"],  -- 복수심에 불타는 검투사의 구원봉
					"33763|"..L["Arena"].." "..L["Point"].." 3150"..L["p"],  -- 복수심에 불타는 검투사의 마법검
					"33766|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 전쟁 지팡이
					"34540|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 전투 지팡이
					"33716|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 지팡이
					"34014|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 전투도끼
				},
				["Ranged weapon|11"] = {
					-- 원거리
					"34529|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 장궁
					"33006|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 강화석궁
					"34530|"..L["Arena"].." "..L["Point"].." 3750"..L["p"],  -- 복수심에 불타는 검투사의 라이플
					"33765|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 투척용 도끼
					"33764|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 타도의 손길
					"34066|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 사무치는 손길
					"34059|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 빛의 지휘봉
				},
				["Off Hand|12"] = {
					-- 보조장비
					"33734|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 쾌검
					"33756|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 비수
					"33801|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 선구자의 난도질 검
					"33662|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 파쇄기
					"33705|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 왼갈퀴
					"34016|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 왼손 분쇄기
					"33755|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 철벽 방패
					"33661|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 방벽 방패
					"33735|"..L["Arena"].." "..L["Point"].." 1875"..L["p"],  -- 복수심에 불타는 검투사의 보루 방패
					"34015|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 도끼
					"33689|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 톱날도끼
				},
				["Held in Off-Hand|13"] = {
					-- 보조장비
					"33681|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 병법서
					"33736|"..L["Arena"].." "..L["Point"].." 1125"..L["p"],  -- 복수심에 불타는 검투사의 구원서
				},
				["Relic|14"] = {
					-- 성물
					"33841|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 인내의 우상
					"33947|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 결의의 우상
					"33944|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 불변의 우상
					"33938|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 인내의 성서
					"33950|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 복수의 성서
					"33842|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 정의의 성서
					"33941|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 불굴의 토템
					"33953|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 생존의 토템
					"33843|"..L["Arena"].." "..L["Point"].." 1000"..L["p"],  -- 복수심에 불타는 검투사의 다시 부는 바람의 토템
				},
			},

		},
		["BattleGround"] = {
			["Frostwolf Clan|H|1"] = {
				["Vendor"] = {
					"19031|"..L["Alterac Valley Mark of Honor"].." 60", -- 서리늑대 전투휘장
					"19083|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 서리늑대 용사의 망토
					"19085|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 서리늑대 조언가의 망토
					"19095|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 서리늑대 용사의 펜던트
					"19096|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 서리늑대 조언가의 펜던트
					"19087|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 서리늑대 판금 허리띠
					"19088|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 서리늑대 사슬 허리띠
					"19089|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 서리늑대 가죽 허리띠
					"19090|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 서리늑대 천 허리띠
					"19046|"..L["Alterac Valley Mark of Honor"].." 30", -- 서리늑대 전투깃발
					"19103|"..L["PvP"].." "..L["Point"].." 2380"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 얼음이빨
					"19099|"..L["PvP"].." "..L["Point"].." 2380"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 빙하의 칼날
					"19101|"..L["PvP"].." "..L["Point"].." 2720"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 15", -- 극지의 지팡이
					"19029|"..L["Alterac Valley Mark of Honor"].." 50", -- 전투서리늑대 뿔피리
					"19323|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 단호의 철퇴
					"19321|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 불굴의 방패
					"19324|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 절개의 단검
					"19312|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 구원의 꽃다발
					"19315|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 테라제인의 손길
					"19309|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 검은 마력의 고서
					"19310|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 얼음 군주의 고서
					"19325|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 돈 훌리오의 고리
					"21563|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 돈 로드리고의 고리
					"19308|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 신비한 비전술의 고서
					"19311|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 불타는 아르카나의 고서
					"19320|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 놀 가죽 탄띠
					"19319|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 하피 가죽 화살통
				},
				["Quest Reward|U"] = {
					17690,
					17905,
					17906,
					17907,
					17908,
					17909,
					"",
					19108,
					19107,
					19106,
					20648,
					17410,
				},
			},
			["Stormpike Guard|A|2"] = {
				["Vendor"] = {
					"19032|"..L["Alterac Valley Mark of Honor"].." 60", -- 스톰파이크 전투휘장
					"19084|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 스톰파이크 병사의 망토
					"19086|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 스톰파이크 현자의 망토
					"19097|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 스톰파이크 병사의 펜던트
					"19098|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 스톰파이크 현자의 펜던트
					"19091|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 스톰파이크 판금 벨트
					"19092|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 스톰파이크 사슬 벨트
					"19093|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 스톰파이크 가죽 벨트
					"19094|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 스톰파이크 천 벨트
					"19045|"..L["Alterac Valley Mark of Honor"].." 30", -- 스톰파이크 전투깃발
					"19100|"..L["PvP"].." "..L["Point"].." 2380"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 충격의 단검
					"19102|"..L["PvP"].." "..L["Point"].." 2720"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 15", -- 일격의 지팡이
					"19104|"..L["PvP"].." "..L["Point"].." 2380"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 폭풍강타 망치
					"19030|"..L["Alterac Valley Mark of Honor"].." 50", -- 스톰파이크 전투산양 고삐
					"19323|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 단호의 철퇴
					"19321|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 불굴의 방패
					"19324|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 절개의 단검
					"19312|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 구원의 꽃다발
					"19315|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 테라제인의 손길
					"19309|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 검은 마력의 고서
					"19310|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 얼음 군주의 고서
					"19325|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 돈 훌리오의 고리
					"21563|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 돈 로드리고의 고리
					"19308|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 신비한 비전술의 고서
					"19311|"..L["PvP"].." "..L["Point"].." 4760"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 25", -- 불타는 아르카나의 고서
					"19320|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 놀 가죽 탄띠
					"19319|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 하피 가죽 화살통
				},
				["Quest Reward|U"] = {
					17691,
					17900,
					17901,
					17902,
					17903,
					17904,
					"",
					19108,
					19107,
					19106,
					20648,
					17384,
				},
			},
			["The Defilers|H|5"] = {
				["Cloth|1"] = {
					"20164|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 벨트
					"20166|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 벨트
					"20165|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 벨트
					"20163|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 벨트
					"",
					"20162|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 장화
					"20161|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 장화
					"20160|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 장화
					"20159|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 헝겊 장화
					"",
					"20176|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 파멸단 견장
				},
				["Leather|2"] = {
					"20172|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 벨트
					"20173|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 벨트
					"20174|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 벨트
					"20171|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 벨트
					"",
					"20191|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 벨트
					"20192|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 벨트
					"20193|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 벨트
					"20190|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 벨트
					"",
					"20169|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 장화
					"20168|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 장화
					"20170|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 장화
					"20167|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 도마뱀가죽 장화
					"",
					"20188|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 장화
					"20187|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 장화
					"20189|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 장화
					"20186|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 가죽 장화
					"",
					"20175|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 파멸단 도마뱀가죽 어깨보호구
					"20194|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 파멸단 가죽 어깨보호구
				},
				["Mail|3"] = {
					"20152|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 벨트--가죽..이름변경 가능성
					"20153|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 벨트
					"20151|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 벨트
					"20150|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 벨트
					"",
					"20157|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 경갑
					"20156|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 경갑
					"20155|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 경갑
					"20154|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 사슬 경갑
					"",
					"20197|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 통가죽 벨트
					"20198|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 벨트
					"20196|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 벨트
					"20195|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 벨트
					"",
					"20201|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 경갑--가죽..이름변경 가능성
					"20200|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 경갑
					"20202|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 경갑
					"20199|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 경갑
					"",
					"20158|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 파멸단 사슬 어깨갑옷
					"20203|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 파멸단 쇠사슬 어깨갑옷
				},
				["Plate|4"] = {
					"20178|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 벨트--성기사
					"20180|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 벨트
					"20179|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 벨트
					"20177|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 벨트
					"",
					"20182|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 경갑--성기사
					"20183|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 경갑
					"20185|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 경갑
					"20181|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 강철 경갑
					"",
					"20207|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 벨트--전사/성기사
					"20206|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 판금 벨트
					"20205|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 판금 벨트
					"20204|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 판금 벨트
					"",
					"20210|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 쇠사슬 경갑--전사/성기사
					"20209|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 판금 경갑
					"20211|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 판금 경갑
					"20208|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 파멸단 판금 경갑
					"",
					"20184|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 파멸단 강철 어깨갑옷--성기사
					"20212|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 파멸단 판금 어깨갑옷--전사/성기사
				},
				["Cloak|5"] = {
					"20068|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 죽음의 경비대 망토
				},
				["Trinket|6"] = {
					"21120|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 파멸단 부적
					"21116|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 파멸단 부적
					"21115|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 파멸단 부적
					"20072|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 파멸단 부적
				},
				["Weapon|7"] = {
					"20214|"..L["PvP"].." "..L["Point"].." 8160"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 의식의 송곳니
					"20069|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 무쇠껍질 지팡이
				},
			},
			["The League of Arathor|A|6"] = {
				["Cloth|1"] = {
					"20099|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 벨트
					"20098|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 벨트
					"20097|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 벨트
					"20047|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 벨트
					"",
					"20096|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 장화
					"20095|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 장화
					"20094|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 장화
					"20054|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 헝겊 장화
					"",
					"20061|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 산악연대 견장
				},
				["Leather|2"] = {
					"20105|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 벨트
					"20104|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 벨트
					"20103|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 벨트
					"20046|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 벨트
					"",
					"20117|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 벨트
					"20116|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 벨트
					"20115|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 벨트
					"20045|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 벨트
					"",
					"20102|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 장화
					"20101|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 장화
					"20100|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 장화
					"20053|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 도마뱀가죽 장화
					"",
					"20114|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 장화
					"20113|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 장화
					"20112|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 장화
					"20052|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 가죽 장화
					"",
					"20060|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 산악연대 도마뱀가죽 어깨보호구
					"20059|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 산악연대 가죽 어깨보호구
				},
				["Mail|3"] = {
					"20090|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 통가죽 벨트
					"20089|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 사슬 벨트
					"20088|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 사슬 벨트
					"20043|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 사슬 벨트
					"",
					"20093|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 통가죽 경갑
					"20092|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 사슬 경갑
					"20091|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 사슬 경갑
					"20050|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 사슬 경갑
					"",
					"20055|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 산악연대 사슬 어깨갑옷
				},
				["Plate|4"] = {
					"20108|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 벨트--성기사
					"20107|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 벨트
					"20106|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 벨트
					"20042|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 벨트
					"",
					"20111|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 경갑--성기사
					"20110|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 경갑
					"20109|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 경갑
					"20049|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 강철 경갑
					"",
					"20126|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 쇠사슬 벨트--전사/성기사
					"20125|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 판금 벨트
					"20124|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 판금 벨트
					"20041|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 판금 벨트
					"",
					"20129|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 쇠사슬 경갑--전사/성기사
					"20128|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 판금 경갑
					"20127|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 판금 경갑
					"20048|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 산악연대 판금 경갑
					"",
					"20058|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 산악연대 강철 어깨갑옷--성기사
					"20057|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 산악연대 판금 어깨갑옷--전사/성기사
				},
				["Cloak|5"] = {
					"20073|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 의장대 망토
				},
				["Trinket|6"] = {
					"21119|"..L["PvP"].." "..L["Point"].." 175"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 아라소르 부적
					"21118|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 아라소르 부적
					"21117|"..L["PvP"].." "..L["Point"].." 382"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 아라소르 부적
					"20071|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 아라소르 부적
				},
				["Weapon|7"] = {
					"20070|"..L["PvP"].." "..L["Point"].." 8160"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 현자의 발톱
					"20069|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 무쇠껍질 지팡이
				},
			},
			["Silverwing Sentinels|A|4"] = {
				["Weapon|1"] = {
					"20443|"..L["PvP"].." "..L["Point"].." 214"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 파수꾼의 칼날
					"19549|"..L["PvP"].." "..L["Point"].." 316"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 파수꾼의 칼날
					"19548|"..L["PvP"].." "..L["Point"].." 469"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 파수꾼의 칼날
					"19547|"..L["PvP"].." "..L["Point"].." 694"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 파수꾼의 칼날
					"19546|"..L["PvP"].." "..L["Point"].." 5100"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 파수꾼의 칼날
					"",
					"20440|"..L["PvP"].." "..L["Point"].." 214"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수호자의 검--착귀파템과 이름동일
					"19557|"..L["PvP"].." "..L["Point"].." 316"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수호자의 검
					"19556|"..L["PvP"].." "..L["Point"].." 469"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수호자의 검
					"19555|"..L["PvP"].." "..L["Point"].." 694"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수호자의 검
					"19554|"..L["PvP"].." "..L["Point"].." 5100"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수호자의 검
					"",
					"20434|"..L["PvP"].." "..L["Point"].." 428"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 현자의 지팡이
					"19573|"..L["PvP"].." "..L["Point"].." 632"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 현자의 지팡이
					"19572|"..L["PvP"].." "..L["Point"].." 938"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 현자의 지팡이
					"19571|"..L["PvP"].." "..L["Point"].." 1387"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 현자의 지팡이
					"19570|"..L["PvP"].." "..L["Point"].." 10200"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 현자의 지팡이
				},
				["Ranged weapon"] = {
					"20438|"..L["PvP"].." "..L["Point"].." 214"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 길잡이의 활
					"19565|"..L["PvP"].." "..L["Point"].." 316"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 길잡이의 활
					"19564|"..L["PvP"].." "..L["Point"].." 469"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 길잡이의 활
					"19563|"..L["PvP"].." "..L["Point"].." 694"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 길잡이의 활
					"19562|"..L["PvP"].." "..L["Point"].." 5100"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 길잡이의 활
				},
				["Neck|9"] = {
					"20444|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 파수꾼의 메달
					"19541|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 파수꾼의 메달
					"19540|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 파수꾼의 메달
					"19539|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 파수꾼의 메달
					"19538|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 파수꾼의 메달
				},
				["Ring|8"] = {
					"20439|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 수호자의 고리-- 검은늪 퀘보상템과 아이템명 동일
					"19517|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 수호자의 고리
					"19515|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 수호자의 고리
					"19516|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 수호자의 고리
					"19514|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 수호자의 고리
					"",
					"20431|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 현자의 반지
					"19525|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 현자의 반지
					"19524|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 현자의 반지
					"19523|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 현자의 반지
					"19522|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 현자의 반지
				},
				["Cloak|5"] = {
					"20428|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 청지기의 단망토
					"19533|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 청지기의 단망토
					"19532|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 청지기의 단망토
					"19531|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 청지기의 단망토
					"19530|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 청지기의 단망토
				},
				["Cloth|1"] = {
					-- 구입(얼라)-일반
					"19597|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 드리아드의 손목띠
					"19596|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 드리아드의 손목띠
					"19595|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 드리아드의 손목띠
					"",
					"22752|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 파수꾼의 비단 다리보호구
				},
				["Leather|2"] = {
					"19590|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 숲추적자의 팔보호구
					"19589|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 숲추적자의 팔보호구
					"19587|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 숲추적자의 팔보호구
					"",
					"22750|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 파수꾼의 도마뱀가죽 바지
					"22749|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 파수꾼의 가죽 바지
				},
				["Mail|3"] = {
					"19584|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 바람지기의 손목보호대
					"19583|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 바람지기의 손목보호대
					"19582|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 바람지기의 손목보호대
					"",
					"22748|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 파수꾼의 사슬 다리보호구
					"22753|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 파수꾼의 강철 다리보호대
				},
				["Plate|4"] = {
					"19581|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 광전사의 팔보호구
					"19580|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 광전사의 팔보호구
					"19578|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 광전사의 팔보호구
					"",
					"22672|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 파수꾼의 판금 다리보호대
					"30497|"..L["PvP"].." "..L["Point"].." 7905"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 60", -- 파수꾼의 쇠사슬 다리보호구
				},
				["Vendor|7"] = {
					"19506|"..L["Warsong Gulch Mark of Honor"].." 60", -- 은빛날개 전투 휘장
				},
				["Trinket|6"] = {
					"21568|"..L["PvP"].." "..L["Point"].." 118"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 의무의 룬
					"21567|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 의무의 룬
					"",
					"21566|"..L["PvP"].." "..L["Point"].." 118"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 완수의 룬
					"21565|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 완수의 룬
				},

			},
			["Warsong Outriders|H|3"] = {
				["Weapon|1"] = {
					-- 구입(호드)-18렙
					-- 구입(호드)-28렙
					-- 구입(호드)-38렙
					-- 구입(호드)-48렙
					-- 구입(호드)-58렙
					"20441|"..L["PvP"].." "..L["Point"].." 214"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 정찰병의 칼날
					"19545|"..L["PvP"].." "..L["Point"].." 316"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 정찰병의 칼날
					"19544|"..L["PvP"].." "..L["Point"].." 469"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 정찰병의 칼날
					"19543|"..L["PvP"].." "..L["Point"].." 694"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 정찰병의 칼날
					"19542|"..L["PvP"].." "..L["Point"].." 5100"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 정찰병의 칼날
					"",
					"20430|"..L["PvP"].." "..L["Point"].." 214"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 검
					"19553|"..L["PvP"].." "..L["Point"].." 316"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 검
					"19552|"..L["PvP"].." "..L["Point"].." 469"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 검
					"19551|"..L["PvP"].." "..L["Point"].." 694"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 검
					"19550|"..L["PvP"].." "..L["Point"].." 10200"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 검
					"",
					"20425|"..L["PvP"].." "..L["Point"].." 428"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 조언자의 옹이진 지팡이
					"19569|"..L["PvP"].." "..L["Point"].." 632"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 조언자의 옹이진 지팡이
					"19568|"..L["PvP"].." "..L["Point"].." 938"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 조언자의 옹이진 지팡이
					"19567|"..L["PvP"].." "..L["Point"].." 1387"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 조언자의 옹이진 지팡이
					"19566|"..L["PvP"].." "..L["Point"].." 10200"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 조언자의 옹이진 지팡이
				},
				["Ranged weapon"] = {
					"20437|"..L["PvP"].." "..L["Point"].." 214"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수색병의 활
					"19561|"..L["PvP"].." "..L["Point"].." 316"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수색병의 활
					"19560|"..L["PvP"].." "..L["Point"].." 469"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수색병의 활
					"19559|"..L["PvP"].." "..L["Point"].." 694"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수색병의 활
					"19558|"..L["PvP"].." "..L["Point"].." 5100"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 수색병의 활
				},
				["Neck|9"] = {
					"20442|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정찰병의 메달
					"19537|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정찰병의 메달
					"19536|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정찰병의 메달
					"19535|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정찰병의 메달
					"19534|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정찰병의 메달
				},
				["Ring|8"] = {
					"20429|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 용사의 고리
					"19513|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 용사의 고리
					"19512|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 용사의 고리
					"19511|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 용사의 고리
					"19510|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 용사의 고리
					"",
					"20426|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 조언자의 반지
					"19521|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 조언자의 반지
					"19520|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 조언자의 반지
					"19519|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 조언자의 반지
					"19518|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 조언자의 반지
				},
				["Cloak|5"] = {
					"20427|"..L["PvP"].." "..L["Point"].." 65"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 전투치유사의 망토
					"19529|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 전투치유사의 망토
					"19528|"..L["PvP"].." "..L["Point"].." 141"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 전투치유사의 망토
					"19527|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 전투치유사의 망토
					"19526|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 10", -- 전투치유사의 망토
				},
				["Cloth|1"] = {
					-- 구입(호드)-일반
					"19597|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 드리아드의 손목띠
					"19596|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 드리아드의 손목띠
					"19595|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 드리아드의 손목띠
					"",
					"22747|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 수색병의 비단 다리보호구
				},
				["Leather|2"] = {
					"19590|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 숲추적자의 팔보호구
					"19589|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 숲추적자의 팔보호구
					"19587|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 숲추적자의 팔보호구
					"",
					"22741|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 수색병의 도마뱀가죽 바지
					"22740|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 수색병의 가죽 바지
				},
				["Mail|3"] = {
					"19584|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 바람지기의 손목보호대
					"19583|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 바람지기의 손목보호대
					"19582|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 바람지기의 손목보호대
					"",
					"22676|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 수색병의 쇠사슬 다리보호구
					"22673|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 수색병의 사슬 다리보호구
				},
				["Plate|4"] = {
					"19581|"..L["PvP"].." "..L["Point"].." 422"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 광전사의 팔보호구
					"19580|"..L["PvP"].." "..L["Point"].." 624"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 광전사의 팔보호구
					"19578|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 광전사의 팔보호구
					"",
					"22651|"..L["PvP"].." "..L["Point"].." 8925"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 40", -- 수색병의 판금 다리보호대
					"30498|"..L["PvP"].." "..L["Point"].." 7905"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 60", -- 수색병의 강철 다리갑옷
				},
				["Vendor|7"] = {
					"19505|"..L["Warsong Gulch Mark of Honor"].." 60", -- 전쟁노래 전투 휘장
				},
				["Trinket|6"] = {
					"21568|"..L["PvP"].." "..L["Point"].." 118"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 의무의 룬
					"21567|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 의무의 룬
					"",
					"21566|"..L["PvP"].." "..L["Point"].." 118"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 완수의 룬
					"21565|"..L["PvP"].." "..L["Point"].." 258"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 완수의 룬
				},
			},
		},
		["PvP Point - Original|1"] = {
			["Champions' Hall|A|1"] = {
				["Warrior|U"] = {
					-- 전사(얼라이언스)
					"23286|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 판금 건틀릿
					"23287|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 판금 경갑
					"23301|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 판금 다리보호구
					"23300|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 판금 갑옷
					"23314|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 판금 투구-- 호드와 이름 동일
					"23315|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 판금 어깨보호구-- 호드와 이름 동일
					"",
					"16484|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 판금 건틀릿
					"16479|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 판금 다리보호대
					"16483|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 판금 장화
					"16478|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 판금 투구
					"16480|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 판금 어깨갑옷
					"16477|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 판금 갑옷
				},
				["Paladin|U"] = {
					-- 성기사(얼라이언스)
					"23274|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 강철 건틀릿
					"23275|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 강철 발덮개
					"23272|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 강철 흉갑
					"23273|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 강철 다리보호구
					"23276|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 강철 머리보호구--호드와 동일이름
					"23277|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 강철 어깨보호구--호드와 동일이름
					"",
					"16472|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 강철 장화
					"16471|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 강철 장갑
					"16475|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 강철 다리갑옷
					"16473|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 강철 흉갑
					"16474|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 강철 면갑
					"16476|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 강철 어깨갑옷
				},
				["Shaman|U"] = {
					-- 주술사(얼라이언스)
					"29594|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 쇠사슬 경갑
					"29595|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 쇠사슬 장갑
					"29596|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 쇠사슬 갑옷
					"29597|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 쇠사슬 다리보호구
					"29598|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 쇠사슬 머리보호구--호드와 이름 동일
					"29599|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 쇠사슬 어깨갑옷--호드와 이름 동일
					"",
					"29606|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 쇠사슬 장화
					"29607|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 쇠사슬 건틀릿
					"29608|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 쇠사슬 다리보호구
					"29609|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 쇠사슬 갑옷
					"29610|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 쇠사슬 투구
					"29611|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 쇠사슬 어깨갑옷
				},
				["Hunter|U"] = {
					-- 사냥꾼(얼라이언스)
					"23278|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 사슬 경갑
					"23279|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 사슬 장갑
					"23292|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 사슬 갑옷
					"23293|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 사슬 다리갑옷
					"23306|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 사슬 면갑
					"23307|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 사슬 어깨보호구--호드와 이름 동일
					"",
					"16462|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 사슬 장화
					"16463|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 사슬 장갑
					"16467|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 사슬 다리보호대
					"16466|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 사슬 흉갑
					"16465|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 사슬 투구
					"16468|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 사슬 어깨갑옷
				},
				["Rogue|U"] = {
					-- 도적(얼라이언스)
					"23285|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 가죽 덧신
					"23284|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 가죽 손보호구
					"23298|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 가죽 흉갑
					"23299|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 가죽 다리보호대
					"23313|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 가죽 어깨보호구
					"23312|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 가죽 면갑
					"",
					"16446|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 가죽 경갑
					"16454|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 가죽 장갑
					"16456|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 가죽 다리보호구
					"16453|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 가죽 흉갑
					"16457|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 가죽 견장
					"16455|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 가죽 복면
				},
				["Druid|U"] = {
					-- 드루이드(얼라이언스)
					"23281|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 용가죽 발보호대
					"23280|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 용가죽 고리장갑
					"23295|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 용가죽 다리보호구
					"23294|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 용가죽 흉갑
					"23309|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 용가죽 어깨보호구--호드와 이름 동일
					"23308|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 용가죽 머리보호구--호드와 이름 동일
					"",
					"16459|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 용가죽 장화
					"16448|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 용가죽 건틀릿
					"16450|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 용가죽 다리보호대
					"16452|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 용가죽 흉갑
					"16451|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 용가죽 투구
					"16449|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 용가죽 어깨갑옷
				},
				["Priest|U"] = {
					-- 사제(얼라이언스)
					"23289|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 명주 덧신
					"23288|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 명주 손보호구
					"23303|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 명주 튜닉
					"23302|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 명주 다리보호대
					"23316|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 명주 두건
					"23317|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 명주 어깨보호대--호드와 이름 동일
					"",
					"17603|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 명주 바지
					"17608|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 명주 장갑
					"17607|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 명주 샌들
					"17605|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 명주 의복
					"17604|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 명주 어깨보호대
					"17602|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 머리장식
				},
				["Mage|U"] = {
					-- 마법사(얼라이언스)
					"23291|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 비단 덧신
					"23290|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 비단 손보호구
					"23305|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 비단 튜닉
					"23304|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 비단 다리보호대
					"23318|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 비단 두건
					"23319|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 비단 어깨보호대-- 호드와 이름 동일
					"",
					"16437|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 비단 장화
					"16440|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 비단 장갑
					"16442|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 비단 다리보호구
					"16441|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 화관--얼라흑마와 이름 동일
					"16444|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 비단 어깨갑옷
					"16443|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 60", -- 야전사령관의 비단 의복
				},
				["Warlock|U"] = {
					-- 흑마법사(얼라이언스)
					"23282|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 상급기사의 공포매듭 손보호구
					"23283|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 상급기사의 공포매듭 덧신
					"23296|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 기사대장의 공포매듭 다리보호대
					"23297|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 기사대장의 공포매듭 튜닉
					"23310|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 공포매듭 두건
					"23311|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 공포매듭 어깨갑옷
					"",
					"17583|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 작전사령관의 공포매듭 장화
					"17584|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 작전사령관의 공포매듭 장갑
					"17579|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 작전사령관의 공포매듭 다리보호구
					"17581|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 야전사령관의 공포매듭 로브
					"17580|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 야전사령관의 공포매듭 어깨보호구
					"17578|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 야전사령관의 화관--얼라마법사와 이름 동일
				},
				["Weapon|U|8"] = {
					-- 무기류(얼라이언스)
					"12584|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 장검
					"18865|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 분쇄기
					"18827|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 손도끼
					"18838|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 더크
					"18843|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 오른손칼날
					"18847|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 왼손칼날
					"18876|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 최고사령관의 클레이모어
					"18867|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 최고사령관의 전투 망치
					"18830|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 최고사령관의 전투도끼
					"18869|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 최고사령관의 글레이브
					"18833|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 최고사령관의 장궁
					"18836|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 최고사령관의 석궁
					"18855|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 최고사령관의 손대포
					"18873|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 최고사령관의 지팡이
					"18825|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 아이기스
					"23451|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 마법검
					"23454|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 전투해머
					"23455|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 최고사령관의 파괴자
					"23456|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 쾌검					-- 명예(70)템과 아이템명 동일
					"23452|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 마력의 고서
					"23453|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 최고사령관의 회복의 고서
				},
				["Vendor"] = {
					-- 아이템(얼라이언스)
					"32455|"..L["PvP"].." "..L["Point"].." 1"..L["p"].."/".." 12", -- 별의 슬픔
					"32453|"..L["PvP"].." "..L["Point"].." 2"..L["p"].."/".." 25", -- 별의 눈물
					"15196|"..L["Arathi Basin Mark of Honor"].." 3/"..L["Warsong Gulch Mark of Honor"].." 3", -- 정찰병의 휘장
					"15198|"..L["Alterac Valley Mark of Honor"].." 20/"..L["Arathi Basin Mark of Honor"].." 20/"..L["Warsong Gulch Mark of Honor"].." 20", -- 기사의 제복
					"18606|"..L["PvP"].." "..L["Point"].." 15300", -- 얼라이언스 전투 깃발
				},
				["Cloak"] = {
					"18440|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 10", -- 근위병의 단망토
					"18441|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 10", -- 근위병의 단망토
					"16342|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 10", -- 근위병의 단망토
				},
				["Neck|U|8"] = {
					"18442|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정예근위병의 계급장
					"18444|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정예근위병의 계급장
					"18443|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정예근위병의 계급장
				},
				["Trinket|6"] = {
					-- 계급장(얼라이언스)
					"18854|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--전사
					"18864|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--성기사
					"29593|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--주술사
					"18856|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--사냥꾼
					"18857|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--도적
					"18863|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--드루이드
					"18862|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--사제
					"18859|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--마법사
					"18858|"..L["PvP"].." "..L["Point"].." 2805", -- 얼라이언스 계급장--흑마법사
				},
				["Mount|11"] = {
					-- 탈것(얼라이언스)
					"29465|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 검은 전투기계타조 조종기
					"29467|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 검은 전투산양 고삐
					"29468|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 검은 전투군마 마구
					"29471|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 검은 전투호랑이 고삐
				},
			},
			["Hall of Legends|H"] = {
				["Warrior|U"] = {
					-----------------------------
					-- 전사(호드)
					"22858|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 판금 경갑
					"22868|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 판금 건틀릿
					"22872|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 판금 흉갑
					"22873|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 판금 다리보호구
					"23244|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 판금 투구-- 얼라와 이름 동일
					"23243|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 판금 어깨보호구-- 얼라와 이름 동일
					"",
					"16548|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 판금 건틀릿
					"16543|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 판금 다리보호구
					"16545|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 판금 장화
					"16542|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 판금 투구
					"16544|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 판금 어깨보호구
					"16541|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 판금 갑옷
				},
				["Paladin|U"] = {
					-- 성기사(호드)
					"29600|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 강철 건틀릿
					"29601|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 강철 발덮개
					"29602|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 강철 흉갑
					"29603|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 강철 다리보호구
					"29604|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 강철 머리보호구--얼라와 이름 동일
					"29605|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 강철 어깨보호구--얼라와 동일이름
					"",
					"29612|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 강철 장화
					"29613|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 강철 장갑
					"29614|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 강철 다리갑옷
					"29615|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 강철 가슴갑옷
					"29616|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 강철 면갑
					"29617|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 강철 어깨갑옷
				},
				["Shaman|U"] = {
					-- 주술사(호드)
					"22867|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 쇠사슬 손보호구
					"22857|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 쇠사슬 경갑
					"22876|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 쇠사슬 갑옷
					"22887|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 쇠사슬 다리보호대
					"23259|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 쇠사슬 머리보호구--얼라와 이름 동일
					"23260|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 쇠사슬 어깨갑옷--얼라와 이름 동일
					"",
					"16573|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 쇠사슬 장화
					"16574|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 쇠사슬 건틀릿
					"16579|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 쇠사슬 다리보호구
					"16577|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 쇠사슬 갑옷
					"16578|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 쇠사슬 투구
					"16580|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 쇠사슬 어깨갑옷
				},
				["Hunter|U"] = {
					-- 사냥꾼(호드)
					"22843|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 사슬 경갑
					"22862|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 사슬 장갑
					"22874|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 사슬 갑옷
					"22875|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 사슬 다리보호대
					"23251|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 사슬 투구
					"23252|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 사슬 어깨보호구--얼라와 이름 동일
					"",
					"16569|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 사슬 장화
					"16571|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 사슬 장갑
					"16567|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 사슬 다리보호대
					"16565|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 사슬 흉갑
					"16566|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 사슬 투구
					"16568|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 사슬 어깨보호구
				},
				["Rogue|U"] = {
					-- 도적(호드)
					"16498|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 가죽 장화
					"16499|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 가죽 장갑
					"16505|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 가죽 갑옷
					"22880|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 가죽 다리보호대
					"16506|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 가죽 머리보호구
					"16507|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 가죽 어깨보호대
					"",
					"16564|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 가죽 다리보호대
					"16560|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 가죽 장갑
					"16558|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 가죽 장화
					"16563|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 가죽 흉갑
					"16561|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 가죽 투구
					"16562|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 가죽 어깨갑옷
				},
				["Druid|U"] = {
					-- 드루이드(호드)
					"22852|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 용가죽 신발
					"22863|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 용가죽 장갑
					"22877|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 용가죽 갑옷
					"22878|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 용가죽 다리보호구
					"23253|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 용가죽 머리보호구--얼라와 이름 동일
					"23254|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 용가죽 어깨보호구--얼라와 이름 동일
					"",
					"16554|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 용가죽 장화--명예(70) 일반과 이름동일
					"16555|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 용가죽 장갑
					"16552|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 용가죽 다리보호구
					"16551|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 용가죽 견장
					"16549|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 용가죽 갑옷
					"16550|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 용가죽 투구
				},
				["Priest|U"] = {
					-- 사제(호드)
					"22859|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 명주 발보호구
					"22869|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 명주 손보호구
					"22885|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 명주 튜닉
					"22882|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 명주 다리보호대
					"23261|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 명주 머리보호구
					"23262|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 명주 어깨보호대-- 얼라와 이름 동일
					"",
					"17625|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 명주 다리보호구
					"17618|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 명주 장화
					"17620|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 명주 장갑
					"17623|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 명주 두건
					"17622|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 명주 어깨보호대
					"17624|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 명주 로브
				},
				["Mage|U"] = {
					-- 마법사(호드)
					"22860|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 비단 발보호구
					"22870|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 비단 손보호구
					"22886|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 비단 튜닉
					"22883|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 비단 다리보호대
					"23263|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 비단 머리보호구
					"23264|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 비단 어깨보호대--얼라와 이름 동일
					"",
					"16539|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 비단 장화
					"16540|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 비단 장갑
					"16534|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 비단 바지
					"16536|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 비단 아미스
					"16533|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 비단 두건
					"16535|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 비단 의복
				},
				["Warlock|U"] = {
					-- 흑마법사(호드)
					"22855|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 혈투사의 공포매듭 발보호구
					"22865|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 혈투사의 공포매듭 손보호구
					"22884|"..L["PvP"].." "..L["Point"].." 4590"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 용사의 공포매듭 튜닉
					"22881|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 용사의 공포매듭 다리보호대
					"23255|"..L["PvP"].." "..L["Point"].." 4335"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 부사령관의 공포매듭 머리보호구
					"23256|"..L["PvP"].." "..L["Point"].." 2805"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 부사령관의 공포매듭 어깨보호대
					"",
					"17586|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 전투사령관의 공포매듭 장화
					"17588|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 20", -- 전투사령관의 공포매듭 장갑
					"17593|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 30", -- 전투사령관의 공포매듭 바지
					"17591|"..L["PvP"].." "..L["Point"].." 13005"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 30", -- 장군의 공포매듭 두건
					"17590|"..L["PvP"].." "..L["Point"].." 8415"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 장군의 공포매듭 어깨보호대
					"17592|"..L["PvP"].." "..L["Point"].." 13770"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 30", -- 장군의 공포매듭 로브
				},
				["Weapon|U|8"] = {
					-----------------------------
					-- 무기류(호드)
					"18871|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 대장군의 장창
					"18835|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 대장군의 곡궁
					"18874|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 대장군의 전쟁 지팡이--명예(70)템과 아이템명 동일
					"18828|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 클레버--명예(70)템과 아이템명 동일
					"18826|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 철벽방패
					"18868|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 대장군의 분쇄기
					"18860|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 대장군의 장총
					"18831|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 대장군의 전투도끼
					"18848|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 왼발톱
					"18866|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 곤봉
					"18877|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 대장군의 대검
					"16345|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 장검
					"18837|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 대장군의 석궁
					"18840|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 비수
					"18844|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 오른발톱
					"23467|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 쾌검					-- 명예(70)템과 아이템명 동일
					"23466|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 마법검
					"23464|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 전투철퇴
					"23468|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 파괴의 고서
					"23469|"..L["PvP"].." "..L["Point"].." 12240"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 대장군의 치유의 고서
					"23465|"..L["PvP"].." "..L["Point"].." 24480"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 40", -- 대장군의 파괴자
				},
				["Vendor"] = {
					-- 아이템(호드)
					"32455|"..L["PvP"].." "..L["Point"].." 1"..L["p"].."/".." 12", -- 별의 슬픔
					"32453|"..L["PvP"].." "..L["Point"].." 2"..L["p"].."/".." 25", -- 별의 눈물
					"15197|"..L["Arathi Basin Mark of Honor"].." 3/"..L["Warsong Gulch Mark of Honor"].." 3", -- 척후병의 휘장
					"15199|"..L["Alterac Valley Mark of Honor"].." 20/"..L["Arathi Basin Mark of Honor"].." 20/"..L["Warsong Gulch Mark of Honor"].." 20", -- 투사의 문장
					"18607|"..L["PvP"].." "..L["Point"].." 15300", -- 호드 전투 깃발
				},
				["Cloak"] = {
					"18427|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 10", -- 수호병의 망토
					"16341|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 10", -- 수호병의 망토
					"18461|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 10", -- 수호병의 망토
				},
				["Neck|U|8"] = {
					"15200|"..L["PvP"].." "..L["Point"].." 95"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정예수호병의 계급장
					"18428|"..L["PvP"].." "..L["Point"].." 208"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정예수호병의 계급장
					"16335|"..L["PvP"].." "..L["Point"].." 1530"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 정예수호병의 계급장
				},
				["Trinket|6"] = {
					-- 계급장(호드)
					"18834|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--전사
					"29592|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--성기사
					"18845|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--주술사
					"18846|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--사냥꾼
					"18849|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--도적
					"18853|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--드루이드
					"18851|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--사제
					"18850|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--마법사
					"18852|"..L["PvP"].." "..L["Point"].." 2805", -- 호드 계급장--흑마법사
				},
				["Mount|11"] = {
					-- 탈것(호드)
					"29466|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 검은 전투코도 발굽
					"29469|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 검은 전투늑대 뿔피리
					"29470|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 붉은 전투해골마 마구
					"29472|"..L["Alterac Valley Mark of Honor"].." 30/"..L["Arathi Basin Mark of Honor"].." 30/"..L["Warsong Gulch Mark of Honor"].." 30", -- 검은 전투랩터 호루라기
				},
			},
		},
		["PvP Point - Expantion|2"] = {
			["Champions' Hall|A|1"] = {
				["Cloth|U"] = {
					L["Sold Out"],
					-- 천(얼라이언스)
					"29002|"..L["Sold Out"], -- 작전사령관의 비단 소매장식
					"29001|"..L["Sold Out"], -- 작전사령관의 비단 허리띠
					"29003|"..L["Sold Out"], -- 작전사령관의 비단 경갑
					"",
					-- 천-비단[극대]
					"32820|"..L["Sold Out"], -- 역전용사의 비단 소매장식
					"32807|"..L["Sold Out"], -- 역전용사의 비단 허리띠
					"32795|"..L["Sold Out"], -- 역전용사의 비단 장화
					L["Now Sales"],
					"33913|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 비단 소매장식
					"33912|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 비단 허리띠
					"33914|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 비단 장화
					"==================",
					L["Sold Out"],
					"28981|"..L["Sold Out"], -- 작전사령관의 공포매듭 소매장식
					"28980|"..L["Sold Out"], -- 작전사령관의 공포매듭 허리띠
					"28982|"..L["Sold Out"], -- 작전사령관의 공포매듭 덧신
					"",
					-- 천-공포매듭[뎀증]
					"32811|"..L["Sold Out"], -- 역전용사의 공포매듭 소매장식
					"32799|"..L["Sold Out"], -- 역전용사의 공포매듭 허리띠
					"32787|"..L["Sold Out"], -- 역전용사의 공포매듭 장화
					L["Now Sales"],
					"33883|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 공포매듭 소매장식
					"33882|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 공포매듭 허리띠
					"33884|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 공포매듭 덧신
					"==================",
					L["Sold Out"],
					-- 천-달빛매듭[힐증]
					"32980|"..L["Sold Out"], -- 역전용사의 달빛매듭 소매장식
					"32979|"..L["Sold Out"], -- 역전용사의 달빛매듭 허리띠
					"32981|"..L["Sold Out"], -- 역전용사의 달빛매듭 덧신
					L["Now Sales"],
					"33901|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 달빛매듭 소매장식
					"33900|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 달빛매듭 허리띠
					"33902|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 달빛매듭 덧신
				},
				["Leather|U"] = {
					L["Sold Out"],
					-- 가죽(얼라이언스)
					"28988|"..L["Sold Out"], -- 작전사령관의 가죽 팔보호구
					"28986|"..L["Sold Out"], -- 작전사령관의 가죽 허리띠
					"28987|"..L["Sold Out"], -- 작전사령관의 가죽 장화
					"",
					-- 가죽-가죽[도적/표범]
					"32814|"..L["Sold Out"], -- 역전용사의 가죽 팔보호구
					"32802|"..L["Sold Out"], -- 역전용사의 가죽 허리띠
					"32790|"..L["Sold Out"], -- 역전용사의 가죽 장화
					L["Now Sales"],
					"33893|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 가죽 팔보호구
					"33891|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 가죽 허리띠
					"33892|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 가죽 장화
					"==================",
					L["Sold Out"],
					"28978|"..L["Sold Out"], -- 작전사령관의 용가죽 팔보호구
					"28976|"..L["Sold Out"], -- 작전사령관의 용가죽 허리띠
					"28977|"..L["Sold Out"], -- 작전사령관의 용가죽 장화--드루 명예(60)과 아이템명 동일
					"",
					-- 가죽-용가죽[곰-힐증]
					"32810|"..L["Sold Out"], -- 역전용사의 용가죽 팔보호구
					"32798|"..L["Sold Out"], -- 역전용사의 용가죽 허리띠
					"32786|"..L["Sold Out"], -- 역전용사의 용가죽 장화
					L["Now Sales"],
					"33881|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 용가죽 팔보호구
					"33879|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 용가죽 허리띠
					"33880|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 용가죽 장화
					"==================",
					L["Sold Out"],
					"29006|"..L["Sold Out"], -- 작전사령관의 고룡가죽 팔보호구
					"29004|"..L["Sold Out"], -- 작전사령관의 고룡가죽 허리띠
					"29005|"..L["Sold Out"], -- 작전사령관의 고룡가죽 장화
					"",
					-- 가죽-고룡가죽[조화-뎀증]
					"32821|"..L["Sold Out"], -- 역전용사의 고룡가죽 팔보호구
					"32808|"..L["Sold Out"], -- 역전용사의 고룡가죽 허리띠
					"32796|"..L["Sold Out"], -- 역전용사의 고룡가죽 장화
					L["Now Sales"],
					"33917|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 고룡가죽 팔보호구
					"33915|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 고룡가죽 허리띠
					"33916|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 고룡가죽 장화
					"==================",
					L["Sold Out"],
					"31599|"..L["Sold Out"], -- 작전사령관의 코도가죽 팔보호구
					"31596|"..L["Sold Out"], -- 작전사령관의 코도가죽 허리띠
					"31597|"..L["Sold Out"], -- 작전사령관의 코도가죽 장화
					"",
					-- 가죽-코도가죽[회복-힐증]
					"32812|"..L["Sold Out"], -- 역전용사의 코도가죽 팔보호구
					"32800|"..L["Sold Out"], -- 역전용사의 코도가죽 허리띠
					"32788|"..L["Sold Out"], -- 역전용사의 코도가죽 장화
					L["Now Sales"],
					"33887|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 코도가죽 팔보호구
					"33885|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 코도가죽 허리띠
					"33886|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 코도가죽 장화
				},
				["Mail|U"] = {
					L["Sold Out"],
					-- 사슬(얼라이언스)
					"28973|"..L["Sold Out"], -- 작전사령관의 사슬 팔보호구
					"28974|"..L["Sold Out"], -- 작전사령관의 사슬 벨트
					"28975|"..L["Sold Out"], -- 작전사령관의 사슬 발덮개
					"",
					-- 사슬-사슬[사냥꾼/고양]
					"32809|"..L["Sold Out"], -- 역전용사의 사슬 팔보호구
					"32797|"..L["Sold Out"], -- 역전용사의 사슬 벨트
					"32785|"..L["Sold Out"], -- 역전용사의 사슬 발덮개
					L["Now Sales"],
					"33876|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 사슬 팔보호구
					"33877|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 사슬 벨트
					"33878|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 사슬 발덮개
					"==================",
					L["Sold Out"],
					"28989|"..L["Sold Out"], -- 작전사령관의 사슬매듭 팔보호구
					"28990|"..L["Sold Out"], -- 작전사령관의 사슬매듭 벨트
					"28991|"..L["Sold Out"], -- 작전사령관의 사슬매듭 발덮개
					"",
					-- 사슬-사슬매듭[고양]
					"32816|"..L["Sold Out"], -- 역전용사의 사슬매듭 팔보호구
					"32803|"..L["Sold Out"], -- 역전용사의 사슬매듭 벨트
					"32791|"..L["Sold Out"], -- 역전용사의 사슬매듭 발덮개
					L["Now Sales"],
					"33894|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 사슬매듭 팔보호구
					"33895|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 사슬매듭 벨트
					"33896|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 사슬매듭 발덮개
					"==================",
					L["Sold Out"],
					"28992|"..L["Sold Out"], -- 작전사령관의 쇠사슬 팔보호구
					"28993|"..L["Sold Out"], -- 작전사령관의 쇠사슬 벨트
					"28994|"..L["Sold Out"], -- 작전사령관의 쇠사슬 발덮개
					"",
					-- 사슬-쇠사슬[정기-뎀증]
					"32817|"..L["Sold Out"], -- 역전용사의 쇠사슬 팔보호구
					"32804|"..L["Sold Out"], -- 역전용사의 쇠사슬 벨트
					"32792|"..L["Sold Out"], -- 역전용사의 쇠사슬 발덮개
					L["Now Sales"],
					"33897|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 쇠사슬 팔보호구
					"33898|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 쇠사슬 벨트
					"33899|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 쇠사슬 발덮개
					"==================",
					L["Sold Out"],
					-- 사슬-고리사슬[복원-힐증]
					"32997|"..L["Sold Out"], -- 역전용사의 고리사슬 팔보호구
					"32998|"..L["Sold Out"], -- 역전용사의 고리사슬 벨트
					"32999|"..L["Sold Out"], -- 역전용사의 고리사슬 발덮개
					L["Now Sales"],
					"33906|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 고리사슬 팔보호구
					"33907|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 고리사슬 벨트
					"33908|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 고리사슬 발덮개
				},
				["Plate|U"] = {
					L["Sold Out"],
					-- 판금(얼라이언스)
					"28996|"..L["Sold Out"], -- 작전사령관의 판금 팔보호구
					"28995|"..L["Sold Out"], -- 작전사령관의 판금 허리띠
					"28997|"..L["Sold Out"], -- 작전사령관의 판금 경갑
					"",
					-- 판금-판금[전사/징벌]
					"32818|"..L["Sold Out"], -- 역전용사의 판금 팔보호구
					"32805|"..L["Sold Out"], -- 역전용사의 판금 허리띠
					"32793|"..L["Sold Out"], -- 역전용사의 판금 경갑
					L["Now Sales"],
					"33813|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 판금 팔보호구
					"33811|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 판금 허리띠
					"33812|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 판금 경갑
					"==================",
					L["Sold Out"],
					"28998|"..L["Sold Out"], -- 작전사령관의 미늘 허리띠
					"29000|"..L["Sold Out"], -- 작전사령관의 미늘 경갑
					"28999|"..L["Sold Out"], -- 작전사령관의 미늘 팔보호구
					"",
					-- 판금-미늘[징벌-뎀증]
					"32819|"..L["Sold Out"], -- 역전용사의 미늘 팔보호구
					"32806|"..L["Sold Out"], -- 역전용사의 미늘 허리띠
					"32794|"..L["Sold Out"], -- 역전용사의 미늘 경갑
					L["Now Sales"],
					"33910|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 미늘 팔보호구
					"33909|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 미늘 허리띠
					"33911|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 미늘 경갑
					"==================",
					L["Sold Out"],
					"28984|"..L["Sold Out"], -- 작전사령관의 강철 팔보호구
					"28983|"..L["Sold Out"], -- 작전사령관의 강철 허리띠
					"28985|"..L["Sold Out"], -- 작전사령관의 강철 경갑
					"",
					-- 판금-강철[신성-뎀증]
					"32813|"..L["Sold Out"], -- 역전용사의 강철 팔보호구
					"32801|"..L["Sold Out"], -- 역전용사의 강철 허리띠
					"32789|"..L["Sold Out"], -- 역전용사의 강철 경갑
					L["Now Sales"],
					"33889|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 강철 팔보호구
					"33888|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 강철 허리띠
					"33890|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 강철 경갑
					"==================",
					L["Sold Out"],
					-- 판금-문장[신성-힐증]
					"32989|"..L["Sold Out"], -- 역전용사의 문장 팔보호구
					"32988|"..L["Sold Out"], -- 역전용사의 문장 허리띠
					"32990|"..L["Sold Out"], -- 역전용사의 문장 경갑
					L["Now Sales"],
					"33904|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 문장 팔보호구
					"33903|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 문장 허리띠
					"33905|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 문장 경갑
				},
				["Warrior|U"] = {
					-- 전사(얼라이언스)
					"28701|"..L["Sold Out"], -- 최고사령관의 판금 투구
					"28700|"..L["Sold Out"], -- 최고사령관의 판금 건틀릿
					"28703|"..L["Sold Out"], -- 최고사령관의 판금 어깨보호구
					"28702|"..L["Sold Out"], -- 최고사령관의 판금 다리보호대
					"28699|"..L["Sold Out"], -- 최고사령관의 판금 흉갑
				},
				["Paladin|U"] = {
					-- 성기사(얼라이언스)
					"28681|"..L["Sold Out"], -- 최고사령관의 강철 투구
					"28680|"..L["Sold Out"], -- 최고사령관의 강철 건틀릿
					"28683|"..L["Sold Out"], -- 최고사령관의 강철 어깨보호구
					"28724|"..L["Sold Out"], -- 최고사령관의 강철 다리보호대
					"28679|"..L["Sold Out"], -- 최고사령관의 강철 흉갑
					"",
					"28711|"..L["Sold Out"], -- 최고사령관의 미늘 투구
					"28710|"..L["Sold Out"], -- 최고사령관의 미늘 건틀릿
					"28713|"..L["Sold Out"], -- 최고사령관의 미늘 어깨보호구
					"28712|"..L["Sold Out"], -- 최고사령관의 미늘 다리보호대
					"28709|"..L["Sold Out"], -- 최고사령관의 미늘 흉갑
					"",
					"31632|"..L["Sold Out"], -- 최고사령관의 문장 머리보호구
					"31631|"..L["Sold Out"], -- 최고사령관의 문장 장갑
					"31634|"..L["Sold Out"], -- 최고사령관의 문장 어깨갑옷
					"31633|"..L["Sold Out"], -- 최고사령관의 문장 다리보호구
					"31630|"..L["Sold Out"], -- 최고사령관의 문장 가슴갑옷
				},
				["Shaman|U"] = {
					-- 주술사(얼라이언스)
					"28691|"..L["Sold Out"], -- 최고사령관의 사슬매듭 투구
					"28690|"..L["Sold Out"], -- 최고사령관의 사슬매듭 건틀릿
					"28693|"..L["Sold Out"], -- 최고사령관의 사슬매듭 어깨갑옷
					"28692|"..L["Sold Out"], -- 최고사령관의 사슬매듭 다리보호구
					"28689|"..L["Sold Out"], -- 최고사령관의 사슬매듭 갑옷
					"",
					"28696|"..L["Sold Out"], -- 최고사령관의 쇠사슬 투구
					"28695|"..L["Sold Out"], -- 최고사령관의 쇠사슬 건틀릿
					"28698|"..L["Sold Out"], -- 최고사령관의 쇠사슬 어깨갑옷
					"28697|"..L["Sold Out"], -- 최고사령관의 쇠사슬 다리보호구
					"28694|"..L["Sold Out"], -- 최고사령관의 쇠사슬 갑옷
					"",
					"31642|"..L["Sold Out"], -- 최고사령관의 고리사슬 머리보호구
					"31641|"..L["Sold Out"], -- 최고사령관의 고리사슬 장갑
					"31644|"..L["Sold Out"], -- 최고사령관의 고리사슬 어깨보호구
					"31643|"..L["Sold Out"], -- 최고사령관의 고리사슬 다리보호대
					"31640|"..L["Sold Out"], -- 최고사령관의 고리사슬 가슴보호구
				},
				["Hunter|U"] = {
					-- 사냥꾼(얼라이언스)
					"28615|"..L["Sold Out"], -- 최고사령관의 사슬 투구
					"28614|"..L["Sold Out"], -- 최고사령관의 사슬 건틀릿
					"28617|"..L["Sold Out"], -- 최고사령관의 사슬 어깨갑옷
					"28616|"..L["Sold Out"], -- 최고사령관의 사슬 다리보호구
					"28613|"..L["Sold Out"], -- 최고사령관의 사슬 갑옷
				},
				["Rogue|U"] = {
					-- 도적(얼라이언스)
					"28684|"..L["Sold Out"], -- 최고사령관의 가죽 장갑
					"28687|"..L["Sold Out"], -- 최고사령관의 가죽 어깨갑옷
					"28686|"..L["Sold Out"], -- 최고사령관의 가죽 다리보호대
					"28685|"..L["Sold Out"], -- 최고사령관의 가죽 투구
					"28688|"..L["Sold Out"], -- 최고사령관의 가죽 튜닉
				},
				["Druid|U"] = {
					-- 드루이드(얼라이언스)
					"28619|"..L["Sold Out"], -- 최고사령관의 용가죽 투구
					"28618|"..L["Sold Out"], -- 최고사령관의 용가죽 장갑
					"28622|"..L["Sold Out"], -- 최고사령관의 용가죽 어깨갑옷
					"28620|"..L["Sold Out"], -- 최고사령관의 용가죽 다리보호대
					"28623|"..L["Sold Out"], -- 최고사령관의 용가죽 튜닉
					"",
					"28720|"..L["Sold Out"], -- 최고사령관의 고룡가죽 투구
					"28719|"..L["Sold Out"], -- 최고사령관의 고룡가죽 장갑
					"28722|"..L["Sold Out"], -- 최고사령관의 고룡가죽 어깨갑옷
					"28721|"..L["Sold Out"], -- 최고사령관의 고룡가죽 다리보호대
					"28723|"..L["Sold Out"], -- 최고사령관의 고룡가죽 튜닉
					"",
					"31590|"..L["Sold Out"], -- 최고사령관의 코도가죽 투구
					"31589|"..L["Sold Out"], -- 최고사령관의 코도가죽 장갑
					"31592|"..L["Sold Out"], -- 최고사령관의 코도가죽 어깨갑옷
					"31591|"..L["Sold Out"], -- 최고사령관의 코도가죽 다리보호대
					"31593|"..L["Sold Out"], -- 최고사령관의 코도가죽 튜닉
				},
				["Priest|U"] = {
					-- 사제(얼라이언스)
					"28705|"..L["Sold Out"], -- 최고사령관의 명주 두건
					"28704|"..L["Sold Out"], -- 최고사령관의 명주 장갑
					"28707|"..L["Sold Out"], -- 최고사령관의 명주 어깨보호대
					"28706|"..L["Sold Out"], -- 최고사령관의 명주 다리보호구
					"28708|"..L["Sold Out"], -- 최고사령관의 명주 로브
					"",
					"31622|"..L["Sold Out"], -- 최고사령관의 달빛매듭 두건
					"31620|"..L["Sold Out"], -- 최고사령관의 달빛매듭 장갑
					"31624|"..L["Sold Out"], -- 최고사령관의 달빛매듭 어깨보호구
					"31623|"..L["Sold Out"], -- 최고사령관의 달빛매듭 다리보호대
					"31625|"..L["Sold Out"], -- 최고사령관의 달빛매듭 의복
				},
				["Mage|U"] = {
					-- 마법사(얼라이언스)
					"28715|"..L["Sold Out"], -- 최고사령관의 비단 두건
					"28716|"..L["Sold Out"], -- 최고사령관의 비단 손보호대
					"28714|"..L["Sold Out"], -- 최고사령관의 비단 아미스
					"28718|"..L["Sold Out"], -- 최고사령관의 비단 바지
					"28717|"..L["Sold Out"], -- 최고사령관의 비단 의복
				},
				["Warlock|U"] = {
					-- 흑마법사(얼라이언스)
					"28625|"..L["Sold Out"], -- 최고사령관의 공포매듭 두건
					"28624|"..L["Sold Out"], -- 최고사령관의 공포매듭 장갑
					"28627|"..L["Sold Out"], -- 최고사령관의 공포매듭 어깨보호대
					"28626|"..L["Sold Out"], -- 최고사령관의 공포매듭 다리보호구
					"28628|"..L["Sold Out"], -- 최고사령관의 공포매듭 로브
				},
				["Weapon|U|8"] = {
					-- 무기류(얼라)
					"28943|"..L["Sold Out"], -- 최고사령관의 전투검
					"28945|"..L["Sold Out"], -- 최고사령관의 참수도끼
					"28942|"..L["Sold Out"], -- 최고사령관의 해골망치
					"28949|"..L["Sold Out"], -- 최고사령관의 내릴톱
					"28948|"..L["Sold Out"], -- 최고사령관의 마울
					"28960|"..L["Sold Out"], -- 최고사령관의 강화석궁
					"28956|"..L["Sold Out"], -- 최고사령관의 절단검
					"28952|"..L["Sold Out"], -- 최고사령관의 쾌검 -- 명예(60)과 아이템명 동일
					"28944|"..L["Sold Out"], -- 최고사령관의 클레버
					"28946|"..L["Sold Out"], -- 최고사령관의 톱날도끼
					"28951|"..L["Sold Out"], -- 최고사령관의 뾰족철퇴
					"28950|"..L["Sold Out"], -- 최고사령관의 파쇄기
					"28953|"..L["Sold Out"], -- 최고사령관의 오른갈퀴
					"28947|"..L["Sold Out"], -- 최고사령관의 왼갈퀴
					"28954|"..L["Sold Out"], -- 최고사령관의 단도
					"28955|"..L["Sold Out"], -- 최고사령관의 비수
					"28959|"..L["Sold Out"], -- 최고사령관의 전쟁 지팡이
					"28957|"..L["Sold Out"], -- 최고사령관의 마법단검
					"28941|"..L["Sold Out"], -- 최고사령관의 전투 고서
					"28940|"..L["Sold Out"], -- 최고사령관의 보루 방패
				},
				["Trinket|6"] = {
					-- 장신구(얼라)
					"30350|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--전사
					"28236|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--성기사
					"30351|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--주술사
					"28237|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--사냥꾼
					"28234|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--도적
					"28235|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--드루이드
					"30349|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--사제
					"28238|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--마법사
					"30348|"..L["PvP"].." "..L["Point"].." 16983", -- 얼라이언스의 메달--흑마법사
					"25829|"..L["PvP"].." "..L["Point"].." 22950"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 얼라이언스의 부적
				},
				["Cloak"] = {
					-- 망토(얼라)
					"28380|"..L["PvP"].." "..L["Point"].." 7548"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 근위병의 두꺼운 망토
					"28379|"..L["PvP"].." "..L["Point"].." 7548"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 근위병의 두꺼운 외투
				},
				["Neck|U|8"] = {
					L["Sold Out"],
					-- 반지/목걸이(일반)
					"28244|"..L["Sold Out"], -- 승리의 펜던트
					"28245|"..L["Sold Out"], -- 지배의 펜던트
					"",
					-- 반지/목걸이(역전용사)
					"33065|"..L["Sold Out"], -- 지배의 역전용사 펜던트
					"33068|"..L["Sold Out"], -- 구조의 역전용사 펜던트
					"33067|"..L["Sold Out"], -- 정복의 역전용사 펜던트
					"33066|"..L["Sold Out"], -- 승리의 역전용사 펜던트
					L["Now Sales"],
					-- 반지/목걸이(구원자)
					"33921|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 지배의 구원자 펜던트
					"33922|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 구조의 구원자 펜던트
					"33920|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 정복의 구원자 펜던트
					"33923|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 승리의 구원자 펜던트
				},
				["Ring"] = {
					-- 반지/목걸이(일반)
					"28246|"..L["PvP"].." "..L["Point"].." 9547"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 승리의 고리
					"28247|"..L["PvP"].." "..L["Point"].." 9547"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 지배의 고리
					"",
					-- 반지/목걸이(역전용사)
					"33056|"..L["PvP"].." "..L["Point"].." 11934"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 지배의 역전용사 고리
					"33064|"..L["PvP"].." "..L["Point"].." 11934"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 구조의 역전용사 고리
					"33057|"..L["PvP"].." "..L["Point"].." 11934"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 승리의 역전용사 고리
					"",
					-- 반지/목걸이(구원자)
					"33853|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 지배의 구원자 고리
					"33918|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 구조의 구원자 고리
					"33919|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 승리의 구원자 고리
				},
				["Gems"] = {
					-- 보석(공통)
					"28362|"..L["PvP"].." "..L["Point"].." 6885", -- 굵은 화려한 루비
					"28118|"..L["PvP"].." "..L["Point"].." 6885", -- 룬이 새겨진 화려한 루비
					"28119|"..L["PvP"].." "..L["Point"].." 6885", -- 매끄러운 화려한 여명석
					"28120|"..L["PvP"].." "..L["Point"].." 6885", -- 번뜩이는 화려한 여명석
					"28363|"..L["PvP"].." "..L["Point"].." 8500", -- 문자가 새겨진 화려한 토파즈
					"28123|"..L["PvP"].." "..L["Point"].." 8500", -- 마력이 담긴 화려한 황옥
				},
			},
			["Hall of Legends|H"] = {
				["Cloth|U"] = {
					L["Sold Out"],
					-- 천(호드)
					"28411|"..L["Sold Out"], -- 전투사령관의 비단 소매장식
					"28409|"..L["Sold Out"], -- 전투사령관의 비단 허리띠
					"28410|"..L["Sold Out"], -- 전투사령관의 비단 경갑
					"",
					-- 천-비단[극대]
					"32820|"..L["Sold Out"], -- 역전용사의 비단 소매장식
					"32807|"..L["Sold Out"], -- 역전용사의 비단 허리띠
					"32795|"..L["Sold Out"], -- 역전용사의 비단 장화
					L["Now Sales"],
					"33913|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 비단 소매장식
					"33912|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 비단 허리띠
					"33914|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 비단 장화
					"==================",
					L["Sold Out"],
					"28405|"..L["Sold Out"], -- 전투사령관의 공포매듭 소매장식
					"28404|"..L["Sold Out"], -- 전투사령관의 공포매듭 허리띠
					"28402|"..L["Sold Out"], -- 전투사령관의 공포매듭 덧신
					"",
					-- 천-공포매듭[뎀증]
					"32811|"..L["Sold Out"], -- 역전용사의 공포매듭 소매장식
					"32799|"..L["Sold Out"], -- 역전용사의 공포매듭 허리띠
					"32787|"..L["Sold Out"], -- 역전용사의 공포매듭 장화
					L["Now Sales"],
					"33883|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 공포매듭 소매장식
					"33882|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 공포매듭 허리띠
					"33884|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 공포매듭 덧신
					"==================",
					L["Sold Out"],
					-- 천-달빛매듭[힐증]
					"32980|"..L["Sold Out"], -- 역전용사의 달빛매듭 소매장식
					"32979|"..L["Sold Out"], -- 역전용사의 달빛매듭 허리띠
					"32981|"..L["Sold Out"], -- 역전용사의 달빛매듭 덧신
					L["Now Sales"],
					"33901|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 달빛매듭 소매장식
					"33900|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 달빛매듭 허리띠
					"33902|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 달빛매듭 덧신
				},
				["Leather|U"] = {
					L["Sold Out"],
					-- 가죽(호드)
					-- 가죽-가죽[도적/표범]
					"32814|"..L["Sold Out"], -- 역전용사의 가죽 팔보호구
					"32802|"..L["Sold Out"], -- 역전용사의 가죽 허리띠
					"32790|"..L["Sold Out"], -- 역전용사의 가죽 장화
					L["Now Sales"],
					"33893|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 가죽 팔보호구
					"33891|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 가죽 허리띠
					"33892|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 가죽 장화
					"==================",
					L["Sold Out"],
					-- 가죽-용가죽[곰-힐증]
					"28445|"..L["Sold Out"], -- 전투사령관의 용가죽 팔보호구
					"28443|"..L["Sold Out"], -- 전투사령관의 용가죽 허리띠
					"28444|"..L["Sold Out"], -- 전투사령관의 용가죽 장화--명예(60) 드루(호드)와 이름동일
					"",
					"32810|"..L["Sold Out"], -- 역전용사의 용가죽 팔보호구
					"32798|"..L["Sold Out"], -- 역전용사의 용가죽 허리띠
					"32786|"..L["Sold Out"], -- 역전용사의 용가죽 장화
					L["Now Sales"],
					"33881|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 용가죽 팔보호구
					"33879|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 용가죽 허리띠
					"33880|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 용가죽 장화
					"==================",
					L["Sold Out"],
					"28448|"..L["Sold Out"], -- 전투사령관의 고룡가죽 팔보호구
					"28446|"..L["Sold Out"], -- 전투사령관의 고룡가죽 허리띠
					"28447|"..L["Sold Out"], -- 전투사령관의 고룡가죽 장화
					"",
					-- 가죽-고룡가죽[조화-뎀증]
					"32821|"..L["Sold Out"], -- 역전용사의 고룡가죽 팔보호구
					"32808|"..L["Sold Out"], -- 역전용사의 고룡가죽 허리띠
					"32796|"..L["Sold Out"], -- 역전용사의 고룡가죽 장화
					L["Now Sales"],
					"33917|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 고룡가죽 팔보호구
					"33915|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 고룡가죽 허리띠
					"33916|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 고룡가죽 장화
					"==================",
					L["Sold Out"],
					"31598|"..L["Sold Out"], -- 전투사령관의 코도가죽 팔보호구
					"31594|"..L["Sold Out"], -- 전투사령관의 코도가죽 허리띠
					"31595|"..L["Sold Out"], -- 전투사령관의 코도가죽 장화
					"",
					-- 가죽-코도가죽[회복-힐증]
					"32812|"..L["Sold Out"], -- 역전용사의 코도가죽 팔보호구
					"32800|"..L["Sold Out"], -- 역전용사의 코도가죽 허리띠
					"32788|"..L["Sold Out"], -- 역전용사의 코도가죽 장화
					L["Now Sales"],
					"33887|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 코도가죽 팔보호구
					"33885|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 코도가죽 허리띠
					"33886|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 코도가죽 장화
				},
				["Mail|U"] = {
					L["Sold Out"],
					-- 사슬(호드)
					"28451|"..L["Sold Out"], -- 전투사령관의 사슬 팔보호구
					"28450|"..L["Sold Out"], -- 전투사령관의 사슬 벨트
					"28449|"..L["Sold Out"], -- 전투사령관의 사슬 발덮개
					"",
					-- 사슬-사슬[사냥꾼/고양]
					"32809|"..L["Sold Out"], -- 역전용사의 사슬 팔보호구
					"32797|"..L["Sold Out"], -- 역전용사의 사슬 벨트
					"32785|"..L["Sold Out"], -- 역전용사의 사슬 발덮개
					L["Now Sales"],
					"33876|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 사슬 팔보호구
					"33877|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 사슬 벨트
					"33878|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 사슬 발덮개
					"==================",
					L["Sold Out"],
					"28605|"..L["Sold Out"], -- 전투사령관의 사슬매듭 팔보호구
					"28629|"..L["Sold Out"], -- 전투사령관의 사슬매듭 벨트
					"28630|"..L["Sold Out"], -- 전투사령관의 사슬매듭 발덮개
					"",
					-- 사슬-사슬매듭[고양]
					"32816|"..L["Sold Out"], -- 역전용사의 사슬매듭 팔보호구
					"32803|"..L["Sold Out"], -- 역전용사의 사슬매듭 벨트
					"32791|"..L["Sold Out"], -- 역전용사의 사슬매듭 발덮개
					L["Now Sales"],
					"33894|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 사슬매듭 팔보호구
					"33895|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 사슬매듭 벨트
					"33896|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 사슬매듭 발덮개
					"==================",
					L["Sold Out"],
					"28638|"..L["Sold Out"], -- 전투사령관의 쇠사슬 팔보호구
					"28639|"..L["Sold Out"], -- 전투사령관의 쇠사슬 벨트
					"28640|"..L["Sold Out"], -- 전투사령관의 쇠사슬 발덮개
					"",
					-- 사슬-쇠사슬[정기-뎀증]
					"32817|"..L["Sold Out"], -- 역전용사의 쇠사슬 팔보호구
					"32804|"..L["Sold Out"], -- 역전용사의 쇠사슬 벨트
					"32792|"..L["Sold Out"], -- 역전용사의 쇠사슬 발덮개
					L["Now Sales"],
					"33897|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 쇠사슬 팔보호구
					"33898|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 쇠사슬 벨트
					"33899|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 쇠사슬 발덮개
					"==================",
					L["Sold Out"],
					-- 사슬-고리사슬[복원-힐증]
					"32997|"..L["Sold Out"], -- 역전용사의 고리사슬 팔보호구
					"32998|"..L["Sold Out"], -- 역전용사의 고리사슬 벨트
					"32999|"..L["Sold Out"], -- 역전용사의 고리사슬 발덮개
					L["Now Sales"],
					"33906|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 고리사슬 팔보호구
					"33907|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 고리사슬 벨트
					"33908|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 고리사슬 발덮개
				},
				["Plate|U"] = {
					L["Sold Out"],
					-- 판금(호드)
					"28381|"..L["Sold Out"], -- 전투사령관의 판금 팔보호구
					"28385|"..L["Sold Out"], -- 전투사령관의 판금 허리띠
					"28383|"..L["Sold Out"], -- 전투사령관의 판금 경갑
					"",
					-- 판금-판금[전사/징벌]
					"32818|"..L["Sold Out"], -- 역전용사의 판금 팔보호구
					"32805|"..L["Sold Out"], -- 역전용사의 판금 허리띠
					"32793|"..L["Sold Out"], -- 역전용사의 판금 경갑
					L["Now Sales"],
					"33813|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 판금 팔보호구
					"33811|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 판금 허리띠
					"33812|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 판금 경갑
					"==================",
					L["Sold Out"],
					"28646|"..L["Sold Out"], -- 전투사령관의 미늘 팔보호구
					"28644|"..L["Sold Out"], -- 전투사령관의 미늘 허리띠
					"28645|"..L["Sold Out"], -- 전투사령관의 미늘 경갑
					"",
					-- 판금-미늘[징벌-뎀증]
					"32819|"..L["Sold Out"], -- 역전용사의 미늘 팔보호구
					"32806|"..L["Sold Out"], -- 역전용사의 미늘 허리띠
					"32794|"..L["Sold Out"], -- 역전용사의 미늘 경갑
					L["Now Sales"],
					"33910|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 미늘 팔보호구
					"33909|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 미늘 허리띠
					"33911|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 미늘 경갑
					"==================",
					L["Sold Out"],
					"28643|"..L["Sold Out"], -- 전투사령관의 강철 팔보호구
					"28641|"..L["Sold Out"], -- 전투사령관의 강철 허리띠
					"28642|"..L["Sold Out"], -- 전투사령관의 강철 경갑
					"",
					-- 판금-강철[신성-뎀증]
					"32813|"..L["Sold Out"], -- 역전용사의 강철 팔보호구
					"32801|"..L["Sold Out"], -- 역전용사의 강철 허리띠
					"32789|"..L["Sold Out"], -- 역전용사의 강철 경갑
					L["Now Sales"],
					"33889|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 강철 팔보호구
					"33888|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 강철 허리띠
					"33890|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 강철 경갑
					"==================",
					L["Sold Out"],
					-- 판금-문장[신성-힐증]
					"32989|"..L["Sold Out"], -- 역전용사의 문장 팔보호구
					"32988|"..L["Sold Out"], -- 역전용사의 문장 허리띠
					"32990|"..L["Sold Out"], -- 역전용사의 문장 경갑
					L["Now Sales"],
					"33904|"..L["PvP"].." "..L["Point"].." 11794"..L["p"].."/"..L["Warsong Gulch Mark of Honor"].." 20", -- 구원자의 문장 팔보호구
					"33903|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 40", -- 구원자의 문장 허리띠
					"33905|"..L["PvP"].." "..L["Point"].." 17850"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 40", -- 구원자의 문장 경갑
				},
				["Warrior|U"] = {
					-- 전사(호드)
					"28853|"..L["Sold Out"], -- 대장군의 판금 투구
					"28852|"..L["Sold Out"], -- 대장군의 판금 건틀릿
					"28855|"..L["Sold Out"], -- 대장군의 판금 어깨보호구
					"28854|"..L["Sold Out"], -- 대장군의 판금 다리보호대
					"28851|"..L["Sold Out"], -- 대장군의 판금 흉갑
				},
				["Paladin|U"] = {
					-- 성기사(호드)
					"28833|"..L["Sold Out"], -- 대장군의 강철 투구
					"28832|"..L["Sold Out"], -- 대장군의 강철 건틀릿
					"28835|"..L["Sold Out"], -- 대장군의 강철 어깨보호구
					"28834|"..L["Sold Out"], -- 대장군의 강철 다리보호대
					"28831|"..L["Sold Out"], -- 대장군의 강철 흉갑
					"",
					"28863|"..L["Sold Out"], -- 대장군의 미늘 투구
					"28862|"..L["Sold Out"], -- 대장군의 미늘 건틀릿
					"28865|"..L["Sold Out"], -- 대장군의 미늘 어깨보호구
					"28864|"..L["Sold Out"], -- 대장군의 미늘 다리보호대
					"28861|"..L["Sold Out"], -- 대장군의 미늘 흉갑
					"",
					"31637|"..L["Sold Out"], -- 대장군의 문장 머리보호구
					"31636|"..L["Sold Out"], -- 대장군의 문장 장갑
					"31639|"..L["Sold Out"], -- 대장군의 문장 어깨갑옷
					"31638|"..L["Sold Out"], -- 대장군의 문장 다리보호구
					"31635|"..L["Sold Out"], -- 대장군의 문장 가슴갑옷
				},
				["Shaman|U"] = {
					-- 주술사(호드)
					"28843|"..L["Sold Out"], -- 대장군의 사슬매듭 투구
					"28842|"..L["Sold Out"], -- 대장군의 사슬매듭 건틀릿
					"28845|"..L["Sold Out"], -- 대장군의 사슬매듭 어깨갑옷
					"28844|"..L["Sold Out"], -- 대장군의 사슬매듭 다리보호구
					"28841|"..L["Sold Out"], -- 대장군의 사슬매듭 갑옷
					"",
					"28848|"..L["Sold Out"], -- 대장군의 쇠사슬 투구
					"28847|"..L["Sold Out"], -- 대장군의 쇠사슬 건틀릿
					"28850|"..L["Sold Out"], -- 대장군의 쇠사슬 어깨갑옷
					"28849|"..L["Sold Out"], -- 대장군의 쇠사슬 다리보호구
					"28846|"..L["Sold Out"], -- 대장군의 쇠사슬 갑옷
					"",
					"31648|"..L["Sold Out"], -- 대장군의 고리사슬 머리보호구
					"31647|"..L["Sold Out"], -- 대장군의 고리사슬 장갑
					"31650|"..L["Sold Out"], -- 대장군의 고리사슬 어깨보호구
					"31649|"..L["Sold Out"], -- 대장군의 고리사슬 다리보호대
					"31646|"..L["Sold Out"], -- 대장군의 고리사슬 가슴보호구
				},
				["Hunter|U"] = {
					-- 사냥꾼(호드)
					"28807|"..L["Sold Out"], -- 대장군의 사슬 투구
					"28806|"..L["Sold Out"], -- 대장군의 사슬 건틀릿
					"28809|"..L["Sold Out"], -- 대장군의 사슬 어깨갑옷
					"28808|"..L["Sold Out"], -- 대장군의 사슬 다리보호구
					"28805|"..L["Sold Out"], -- 대장군의 사슬 갑옷
				},
				["Rogue|U"] = {
					-- 도적(호드)
					"28837|"..L["Sold Out"], -- 대장군의 가죽 투구
					"28836|"..L["Sold Out"], -- 대장군의 가죽 장갑
					"28839|"..L["Sold Out"], -- 대장군의 가죽 어깨갑옷
					"28838|"..L["Sold Out"], -- 대장군의 가죽 다리보호대
					"28840|"..L["Sold Out"], -- 대장군의 가죽 튜닉
				},
				["Druid|U"] = {
					-- 드루이드(호드)
					"28812|"..L["Sold Out"], -- 대장군의 용가죽 투구
					"28811|"..L["Sold Out"], -- 대장군의 용가죽 장갑
					"28814|"..L["Sold Out"], -- 대장군의 용가죽 어깨갑옷
					"28813|"..L["Sold Out"], -- 대장군의 용가죽 다리보호대
					"28815|"..L["Sold Out"], -- 대장군의 용가죽 튜닉
					"",
					"28872|"..L["Sold Out"], -- 대장군의 고룡가죽 투구
					"28871|"..L["Sold Out"], -- 대장군의 고룡가죽 장갑
					"28874|"..L["Sold Out"], -- 대장군의 고룡가죽 어깨갑옷
					"28873|"..L["Sold Out"], -- 대장군의 고룡가죽 다리보호대
					"28875|"..L["Sold Out"], -- 대장군의 고룡가죽 튜닉
					"",
					"31585|"..L["Sold Out"], -- 대장군의 코도가죽 투구
					"31584|"..L["Sold Out"], -- 대장군의 코도가죽 장갑
					"31587|"..L["Sold Out"], -- 대장군의 코도가죽 어깨갑옷
					"31586|"..L["Sold Out"], -- 대장군의 코도가죽 다리보호대
					"31588|"..L["Sold Out"], -- 대장군의 코도가죽 튜닉
				},
				["Priest|U"] = {
					-- 사제(호드)
					"28857|"..L["Sold Out"], -- 대장군의 명주 두건
					"28856|"..L["Sold Out"], -- 대장군의 명주 장갑
					"28859|"..L["Sold Out"], -- 대장군의 명주 어깨보호대
					"28858|"..L["Sold Out"], -- 대장군의 명주 다리보호구
					"28860|"..L["Sold Out"], -- 대장군의 명주 로브
					"",
					"31626|"..L["Sold Out"], -- 대장군의 달빛매듭 두건
					"31621|"..L["Sold Out"], -- 대장군의 달빛매듭 장갑
					"31628|"..L["Sold Out"], -- 대장군의 달빛매듭 어깨보호구
					"31627|"..L["Sold Out"], -- 대장군의 달빛매듭 다리보호대
					"31629|"..L["Sold Out"], -- 대장군의 달빛매듭 의복
				},
				["Mage|U"] = {
					-- 마법사(호드)
					"28867|"..L["Sold Out"], -- 대장군의 비단 두건
					"28868|"..L["Sold Out"], -- 대장군의 비단 손보호대
					"28866|"..L["Sold Out"], -- 대장군의 비단 아미스
					"28870|"..L["Sold Out"], -- 대장군의 비단 바지
					"28869|"..L["Sold Out"], -- 대장군의 비단 의복
				},
				["Warlock|U"] = {
					-- 흑마법사(호드)
					"28818|"..L["Sold Out"], -- 대장군의 공포매듭 두건
					"28817|"..L["Sold Out"], -- 대장군의 공포매듭 장갑
					"28820|"..L["Sold Out"], -- 대장군의 공포매듭 어깨보호대
					"28819|"..L["Sold Out"], -- 대장군의 공포매듭 다리보호구
					"28821|"..L["Sold Out"], -- 대장군의 공포매듭 로브
				},
				["Weapon|U|8"] = {
					-- 무기류(호드)
					"28293|"..L["Sold Out"], -- 대장군의 클레이모어
					"28918|"..L["Sold Out"], -- 대장군의 참수도끼
					"28917|"..L["Sold Out"], -- 대장군의 해골망치
					"28923|"..L["Sold Out"], -- 대장군의 내릴톱
					"28919|"..L["Sold Out"], -- 대장군의 마울
					"28933|"..L["Sold Out"], -- 대장군의 강화석궁
					"28937|"..L["Sold Out"], -- 대장군의 절단검
					"28926|"..L["Sold Out"], -- 대장군의 쾌검 -- 명예(60)과 아이템명 동일
					"28920|"..L["Sold Out"], -- 대장군의 클레버 -- 명예(60)과 아이템명 동일
					"28921|"..L["Sold Out"], -- 대장군의 톱날도끼
					"28925|"..L["Sold Out"], -- 대장군의 뾰족철퇴
					"28924|"..L["Sold Out"], -- 대장군의 파쇄기
					"28928|"..L["Sold Out"], -- 대장군의 오른갈퀴
					"28922|"..L["Sold Out"], -- 대장군의 왼갈퀴
					"28929|"..L["Sold Out"], -- 대장군의 단도
					"28930|"..L["Sold Out"], -- 대장군의 단검
					"28935|"..L["Sold Out"], -- 대장군의 전쟁 지팡이 -- 명예(60)과 아이템명 동일
					"28931|"..L["Sold Out"], -- 대장군의 마법검 -- 명예(60)과 아이템명 동일
					"28938|"..L["Sold Out"], -- 대장군의 전투 고서
					"28939|"..L["Sold Out"], -- 대장군의 보루 방패
				},
				["Trinket|6"] = {
					-- 장신구(호드)
					"30344|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--전사
					"28242|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--성기사
					"30345|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--주술사
					"28243|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--사냥꾼
					"28240|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--도적
					"28241|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--드루이드
					"30346|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--사제
					"28239|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--마법사
					"30343|"..L["PvP"].." "..L["Point"].." 16983", -- 호드의 메달--흑마법사
					"24551|"..L["PvP"].." "..L["Point"].." 22950"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 호드의 부적
				},
				["Cloak"] = {
					-- 망토(호드)
					"28377|"..L["PvP"].." "..L["Point"].." 7548"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 수호병의 두꺼운 망토
					"28378|"..L["PvP"].." "..L["Point"].." 7548"..L["p"].."/"..L["Arathi Basin Mark of Honor"].." 20", -- 수호병의 두꺼운 외투
				},
				["Neck|U"] = {
					L["Sold Out"],
					-- 반지/목걸이(일반)
					"28244|"..L["Sold Out"], -- 승리의 펜던트
					"28245|"..L["Sold Out"], -- 지배의 펜던트
					"",
					-- 반지/목걸이(역전용사)
					"33065|"..L["Sold Out"], -- 지배의 역전용사 펜던트
					"33068|"..L["Sold Out"], -- 구조의 역전용사 펜던트
					"33067|"..L["Sold Out"], -- 정복의 역전용사 펜던트
					"33066|"..L["Sold Out"], -- 승리의 역전용사 펜던트
					L["Now Sales"],
					-- 반지/목걸이(구원자)
					"33921|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 지배의 구원자 펜던트
					"33922|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 구조의 구원자 펜던트
					"33920|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 정복의 구원자 펜던트
					"33923|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Eye of the Storm Mark of Honor"].." 10", -- 승리의 구원자 펜던트
				},
				["Ring"] = {
					-- 반지/목걸이(일반)
					"28246|"..L["PvP"].." "..L["Point"].." 9547"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 승리의 고리
					"28247|"..L["PvP"].." "..L["Point"].." 9547"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 지배의 고리
					"",
					-- 반지/목걸이(역전용사)
					"33056|"..L["PvP"].." "..L["Point"].." 11934"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 지배의 역전용사 고리
					"33064|"..L["PvP"].." "..L["Point"].." 11934"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 구조의 역전용사 고리
					"33057|"..L["PvP"].." "..L["Point"].." 11934"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 승리의 역전용사 고리
					"",
					-- 반지/목걸이(구원자)
					"33853|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 지배의 구원자 고리
					"33918|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 구조의 구원자 고리
					"33919|"..L["PvP"].." "..L["Point"].." 15300"..L["p"].."/"..L["Alterac Valley Mark of Honor"].." 10", -- 승리의 구원자 고리
				},
				["Gems"] = {
					-- 보석(공통)
					"28362|"..L["PvP"].." "..L["Point"].." 6885", -- 굵은 화려한 루비
					"28118|"..L["PvP"].." "..L["Point"].." 6885", -- 룬이 새겨진 화려한 루비
					"28119|"..L["PvP"].." "..L["Point"].." 6885", -- 매끄러운 화려한 여명석
					"28120|"..L["PvP"].." "..L["Point"].." 6885", -- 번뜩이는 화려한 여명석
					"28363|"..L["PvP"].." "..L["Point"].." 8500", -- 문자가 새겨진 화려한 토파즈
					"28123|"..L["PvP"].." "..L["Point"].." 8500", -- 마력이 담긴 화려한 황옥
				},
			},
		},
	},
	["Exchange|7"] = {
		["Shattrath City|1"] = {
			["G'eras|1"] = {
				["Neck|U|1"] = {
					"29386|"..L["Badge of Justice"].." 25",
					"29374|"..L["Badge of Justice"].." 25",
					"29368|"..L["Badge of Justice"].." 25",
					"29381|"..L["Badge of Justice"].." 25",
					"",
					"33296|"..L["Badge of Justice"].." 35 - V 2.3",
				},
				["Cloak|U|2"] = {
					"29385|"..L["Badge of Justice"].." 25",
					"29375|"..L["Badge of Justice"].." 25",
					"29369|"..L["Badge of Justice"].." 25",
					"29382|"..L["Badge of Justice"].." 25",
					"",
					"33593|"..L["Badge of Justice"].." 35 - V 2.3",
					"33333|"..L["Badge of Justice"].." 60 - V 2.3",
					"33304|"..L["Badge of Justice"].." 60 - V 2.3",
					"33484|"..L["Badge of Justice"].." 60 - V 2.3",
				},
				["Ring|U|3"] = {
					"29384|"..L["Badge of Justice"].." 25",
					"29373|"..L["Badge of Justice"].." 25",
					"29367|"..L["Badge of Justice"].." 25",
					"29379|"..L["Badge of Justice"].." 25",
				},
				["Trinket|U|4"] = {
					"29387|"..L["Badge of Justice"].." 41",
					"29376|"..L["Badge of Justice"].." 41",
					"29370|"..L["Badge of Justice"].." 41",
					"29383|"..L["Badge of Justice"].." 41",
					"",
					"33832|"..L["Badge of Justice"].." 75 - V 2.3",
					"34050|"..L["Badge of Justice"].." 75 - V 2.3",
					"34049|"..L["Badge of Justice"].." 75 - V 2.3",
					"34163|"..L["Badge of Justice"].." 75 - V 2.3",
					"34162|"..L["Badge of Justice"].." 75 - V 2.3",
				},
				["Off Hand"] = {
					"29266|"..L["Badge of Justice"].." 33",
					"29267|"..L["Badge of Justice"].." 33",
					"29268|"..L["Badge of Justice"].." 33",
					"29275|"..L["Badge of Justice"].." 25",
				},
				["Held in Off-Hand|U|5"] = {
					"29274|"..L["Badge of Justice"].." 25",
					"29271|"..L["Badge of Justice"].." 25",
					"29272|"..L["Badge of Justice"].." 25",
					"29269|"..L["Badge of Justice"].." 25",
					"29273|"..L["Badge of Justice"].." 25",
					"29270|"..L["Badge of Justice"].." 25",
					"",
					"33334|"..L["Badge of Justice"].." 35 - V 2.3",
					"33325|"..L["Badge of Justice"].." 35 - V 2.3",
				},
				["Ranged weapon"] = {
					"33192|"..L["Badge of Justice"].." 25 - V 2.3",
				},
				["Relic|U"] = {
					"29390|"..L["Badge of Justice"].." 15",
					"29388|"..L["Badge of Justice"].." 15",
					"29389|"..L["Badge of Justice"].." 15",
					"",
					"33509|"..L["Badge of Justice"].." 20 - V 2.3",
					"33508|"..L["Badge of Justice"].." 20 - V 2.3",
					"33510|"..L["Badge of Justice"].." 20 - V 2.3",
					"",
					"33503|"..L["Badge of Justice"].." 20 - V 2.3",
					"33504|"..L["Badge of Justice"].." 20 - V 2.3",
					"33502|"..L["Badge of Justice"].." 20 - V 2.3",
					"",
					"33506|"..L["Badge of Justice"].." 20 - V 2.3",
					"33507|"..L["Badge of Justice"].." 20 - V 2.3",
					"33505|"..L["Badge of Justice"].." 20 - V 2.3",
				},
				["Cloth|U|6"] = {
					"30762|"..L["Badge of Justice"].." 30",
					"30764|"..L["Badge of Justice"].." 20",
					"30761|"..L["Badge of Justice"].." 30",
					"30763|"..L["Badge of Justice"].." 20",
					"32089|"..L["Badge of Justice"].." 50",
					"32090|"..L["Badge of Justice"].." 50",
					"",
					"33588|"..L["Badge of Justice"].." 35 - V 2.3",
					"33584|"..L["Badge of Justice"].." 75 - V 2.3",
					"33586|"..L["Badge of Justice"].." 60 - V 2.3",
					"33291|"..L["Badge of Justice"].." 60 - V 2.3",
					"33585|"..L["Badge of Justice"].." 75 - V 2.3",
					"33587|"..L["Badge of Justice"].." 60 - V 2.3",
					"33589|"..L["Badge of Justice"].." 35 - V 2.3",
				},
				["Leather|U|7"] = {
					"30776|"..L["Badge of Justice"].." 30",
					"30780|"..L["Badge of Justice"].." 20",
					"30778|"..L["Badge of Justice"].." 30",
					"30779|"..L["Badge of Justice"].." 20",
					"32087|"..L["Badge of Justice"].." 50",
					"32088|"..L["Badge of Justice"].." 50",
					"",
					"33540|"..L["Badge of Justice"].." 35 - V 2.3",
					"33538|"..L["Badge of Justice"].." 75 - V 2.3",
					"33222|"..L["Badge of Justice"].." 60 - V 2.3",
					"33539|"..L["Badge of Justice"].." 60 - V 2.3",
					"33578|"..L["Badge of Justice"].." 35 - V 2.3",
					"33580|"..L["Badge of Justice"].." 35 - V 2.3",
					"33566|"..L["Badge of Justice"].." 75 - V 2.3",
					"33582|"..L["Badge of Justice"].." 60 - V 2.3",
					"33577|"..L["Badge of Justice"].." 60 - V 2.3",
					"33287|"..L["Badge of Justice"].." 60 - V 2.3",
					"33552|"..L["Badge of Justice"].." 75 - V 2.3",
					"33557|"..L["Badge of Justice"].." 35 - V 2.3",
					"33974|"..L["Badge of Justice"].." 60 - V 2.3",
					"33973|"..L["Badge of Justice"].." 60 - V 2.3",
					"33559|"..L["Badge of Justice"].." 60 - V 2.3",
					"33972|"..L["Badge of Justice"].." 75 - V 2.3",
					"33579|"..L["Badge of Justice"].." 75 - V 2.3",
					"33583|"..L["Badge of Justice"].." 60 - V 2.3",
				},
				["Mail|U|8"] = {
					"30773|"..L["Badge of Justice"].." 30",
					"30774|"..L["Badge of Justice"].." 20",
					"30772|"..L["Badge of Justice"].." 30",
					"30770|"..L["Badge of Justice"].." 20",
					"32085|"..L["Badge of Justice"].." 50",
					"32086|"..L["Badge of Justice"].." 50",
					"",
					"33528|"..L["Badge of Justice"].." 60 - V 2.3",
					"33527|"..L["Badge of Justice"].." 75 - V 2.3",
					"33280|"..L["Badge of Justice"].." 60 - V 2.3",
					"33529|"..L["Badge of Justice"].." 35 - V 2.3",
					"33535|"..L["Badge of Justice"].." 35 - V 2.3",
					"33965|"..L["Badge of Justice"].." 75 - V 2.3",
					"33970|"..L["Badge of Justice"].." 60 - V 2.3",
					"33532|"..L["Badge of Justice"].." 35 - V 2.3",
					"33534|"..L["Badge of Justice"].." 60 - V 2.3",
					"33386|"..L["Badge of Justice"].." 60 - V 2.3",
					"33530|"..L["Badge of Justice"].." 75 - V 2.3",
					"33324|"..L["Badge of Justice"].." 60 - V 2.3",
					"33531|"..L["Badge of Justice"].." 60 - V 2.3",
					"33536|"..L["Badge of Justice"].." 60 - V 2.3",
					"33537|"..L["Badge of Justice"].." 60 - V 2.3",

				},
				["Plate|U|9"] = {
					"30769|"..L["Badge of Justice"].." 30",
					"30767|"..L["Badge of Justice"].." 20",
					"30766|"..L["Badge of Justice"].." 30",
					"30768|"..L["Badge of Justice"].." 20",
					"32083|"..L["Badge of Justice"].." 50",
					"32084|"..L["Badge of Justice"].." 50",
					"",
					"33810|"..L["Badge of Justice"].." 75 - V 2.3",
					"33501|"..L["Badge of Justice"].." 75 - V 2.3",
					"33517|"..L["Badge of Justice"].." 60 - V 2.3",
					"33279|"..L["Badge of Justice"].." 60 - V 2.3",
					"33516|"..L["Badge of Justice"].." 35 - V 2.3",
					"33513|"..L["Badge of Justice"].." 35 - V 2.3",
					"33331|"..L["Badge of Justice"].." 60 - V 2.3",
					"33512|"..L["Badge of Justice"].." 60 - V 2.3",
					"33514|"..L["Badge of Justice"].." 60 - V 2.3",
					"33515|"..L["Badge of Justice"].." 75 - V 2.3",
					"33522|"..L["Badge of Justice"].." 75 - V 2.3",
					"33524|"..L["Badge of Justice"].." 60 - V 2.3",
					"33519|"..L["Badge of Justice"].." 60 - V 2.3",
					"33518|"..L["Badge of Justice"].." 75 - V 2.3",
					"33207|"..L["Badge of Justice"].." 60 - V 2.3",
					"33523|"..L["Badge of Justice"].." 60 - V 2.3",
					"33520|"..L["Badge of Justice"].." 35 - V 2.3",


				},
			},
		},
		["Allerian Stronghold|A|3"] = {
			["Spirit Sage Zran|1"] = {
				["Meta Gem|1"] = {
					"28556|"..L["Spirit Shard"].." 8",
					"28557|"..L["Spirit Shard"].." 8",
				},
				["Ring|2"] = {
					"28553|"..L["Spirit Shard"].." 50",
					"28555|"..L["Spirit Shard"].." 50",
				},
				["Head|3"] = {
					"28759|"..L["Spirit Shard"].." 18",
					"28760|"..L["Spirit Shard"].." 18",
					"28561|"..L["Spirit Shard"].." 18",
					"28574|"..L["Spirit Shard"].." 18",
					"28575|"..L["Spirit Shard"].." 18",
					"28576|"..L["Spirit Shard"].." 18",
					"28577|"..L["Spirit Shard"].." 18",
					"28758|"..L["Spirit Shard"].." 18",
					"28559|"..L["Spirit Shard"].." 18",
					"28560|"..L["Spirit Shard"].." 18",
					"28761|"..L["Spirit Shard"].." 18",
				},
			},
		},
		["Stonebreaker Hold|H|2"] = {
			["Spirit Sage Gartok|1"] = {
				["Meta Gem|1"] = {
					"28556|"..L["Spirit Shard"].." 8",
					"28557|"..L["Spirit Shard"].." 8",
				},
				["Ring|2"] = {
					"28553|"..L["Spirit Shard"].." 50",
					"28555|"..L["Spirit Shard"].." 50",
				},
				["Head|3"] = {
					"28759|"..L["Spirit Shard"].." 18",
					"28760|"..L["Spirit Shard"].." 18",
					"28561|"..L["Spirit Shard"].." 18",
					"28574|"..L["Spirit Shard"].." 18",
					"28575|"..L["Spirit Shard"].." 18",
					"28576|"..L["Spirit Shard"].." 18",
					"28577|"..L["Spirit Shard"].." 18",
					"28758|"..L["Spirit Shard"].." 18",
					"28559|"..L["Spirit Shard"].." 18",
					"28560|"..L["Spirit Shard"].." 18",
					"28761|"..L["Spirit Shard"].." 18",
				},
			},
		},
		["Halaa|4"] = {
			["Quartermaster Jaffrey Noreliqe|H|1"] ={
				["Cloth|1"] = {
					"27638|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27649|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Leather|2"] = {
					"27637|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27645|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27650|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
					"27648|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Mail|3"] = {
					"27646|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27643|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27647|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
					"27652|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Plate|4"] = {
					"27639|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27644|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27654|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
					"27653|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Bag"] = {
					"27680|"..L["Halaa Research Token"].." 8",
				},
				["Gem"] = {
					"27679|"..L["Halaa Battle Token"].." 100",
				},
				["Alchemy|5"] = {
					"32071|"..L["Halaa Research Token"].." 2",
				},
			},
			["Quartermaster Davian Vaclav|A|2"] ={
				["Cloth|1"] = {
					"27638|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27649|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Leather|2"] = {
					"27637|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27645|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27650|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
					"27648|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Mail|3"] = {
					"27646|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27643|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27647|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
					"27652|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Plate|4"] = {
					"27639|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27644|"..L["Halaa Battle Token"].." 20/"..L["Halaa Research Token"].." 1",
					"27654|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
					"27653|"..L["Halaa Battle Token"].." 40/"..L["Halaa Research Token"].." 2",
				},
				["Bag"] = {
					"27680|"..L["Halaa Research Token"].." 8",
				},
				["Gem"] = {
					"27679|"..L["Halaa Battle Token"].." 100",
				},
				["Alchemy|5"] = {
					"32071|"..L["Halaa Research Token"].." 2",
				},
			},
			["Coreiel|H|3"] = {
				["Weapon|1"] = {
					30568,
					30570,
				},
				["Gem|2"] ={
					30571,
				},
				["Mount|3"] = {
					"28915|"..L["Halaa Battle Token"].." 70/"..L["Halaa Research Token"].." 15",
					"29228|"..L["Halaa Battle Token"].." 100/"..L["Halaa Research Token"].." 20",
				},
				["Jewelcrafting|4"] = {
					24208,
				},
			},
			["Aldraan|A|4"] = {
				["Weapon|1"] = {
					30599,
					30597,
				},
				["Gem|2"] ={
					30598,
				},
				["Mount|3"] = {
					"28915|"..L["Halaa Battle Token"].." 70/"..L["Halaa Research Token"].." 15",
					"29228|"..L["Halaa Battle Token"].." 100/"..L["Halaa Research Token"].." 20",
				},
				["Jewelcrafting|4"] = {
					24208,
				},
			},
			["Tasaldan|H|5"] = {
				["Arrow"] = {
					30611,
					30612,
				},
			},
			["Banro|A|6"] = {
				["Arrow"] = {
					30611,
					30612,
				},
			},
		},
		["Hellfire Peninsula"] = {
			["Battlecryer Blackeye|H|1"] = {
				["Ring"] = {
					"27832|"..L["Mark of Thrallmar"].." 15",
					"27830|"..L["Mark of Thrallmar"].." 15",
				},
				["Gem"] = {
					"27786|"..L["Mark of Thrallmar"].." 10",
					"28360|"..L["Mark of Thrallmar"].." 10",
					"27785|"..L["Mark of Thrallmar"].." 10",
					"27777|"..L["Mark of Thrallmar"].." 10",
				},
				["Use"] = {
					"24522|"..L["Mark of Thrallmar"].." 5",
				},
			},
			["Warrant Officer Tracy Proudwell|A|2"] = {
				["Ring"] = {
					"27833|"..L["Mark of Honor Hold"].." 15",
					"27834|"..L["Mark of Honor Hold"].." 15",
				},
				["Gem"] = {
					"27809|"..L["Mark of Honor Hold"].." 10",
					"28361|"..L["Mark of Honor Hold"].." 10",
					"27820|"..L["Mark of Honor Hold"].." 10",
					"27812|"..L["Mark of Honor Hold"].." 10",
				},
				["Use"] = {
					"24520|"..L["Mark of Honor Hold"].." 5",
				},
			},
		},
		["Zangarmarsh"] = {
			["Horde Field Scout|H|1"] = {
				["Relic"] = {
					"27989|"..L["Mark of Thrallmar"].." 15", -- 성물
					"27949|"..L["Mark of Thrallmar"].." 15", -- 성물
					"27947|"..L["Mark of Thrallmar"].." 15", -- 성물
				},
				["Trinket"] = {
					"27920|"..L["Mark of Thrallmar"].." 30", -- 장신구
					"27924|"..L["Mark of Thrallmar"].." 30", -- 장신구
					"27926|"..L["Mark of Thrallmar"].." 30", -- 장신구
				},
				["Weapon"] = {
					"27939|"..L["Mark of Thrallmar"].." 15", -- 마법봉
					"27930|"..L["Mark of Thrallmar"].." 15", -- 활
					"27928|"..L["Mark of Thrallmar"].." 15", -- 투척무기
				},
			},
			["Alliance Field Scout|A|2"] = {
				["Relic"] ={
					"27990|"..L["Mark of Honor Hold"].." 15", -- 성물
					"27983|"..L["Mark of Honor Hold"].." 15", -- 성물
					"27984|"..L["Mark of Honor Hold"].." 15", -- 성물
				},
				["Trinket"] ={
					"27921|"..L["Mark of Honor Hold"].." 30", -- 장신구
					"27922|"..L["Mark of Honor Hold"].." 30", -- 장신구
					"27927|"..L["Mark of Honor Hold"].." 30", -- 장신구
				},
				["Weapon"] = {
					"27942|"..L["Mark of Honor Hold"].." 15", -- 마법봉
					"27931|"..L["Mark of Honor Hold"].." 15", -- 활
					"27929|"..L["Mark of Honor Hold"].." 15", -- 투척무기
				},
			},
		},
		["Ogri'la|100"] = {
			["Jho'nass"] = {
				["Potion"] = {
					"32783|"..L["Apexis Shard"].." 3",
					"32784|"..L["Apexis Shard"].." 2",
					"33934|"..L["Apexis Shard"].." 50",
					"33935|"..L["Apexis Shard"].." 50",
				},
				["Tabard"] = {
					"32828|"..L["Apexis Shard"].." 10",
				},
				["Cloak"] ={
					"32653|"..L["Apexis Crystal"].." 1/"..L["Apexis Shard"].." 50",
				},
				["Trinket"] = {
					"32654|"..L["Apexis Crystal"].." 1/"..L["Apexis Shard"].." 50",
				},
				["Wand"] = {
					"32650|"..L["Apexis Crystal"].." 1/"..L["Apexis Shard"].." 50",
				},
				["Crossbow"] = {
					"32645|"..L["Apexis Crystal"].." 4/"..L["Apexis Shard"].." 100",
				},
				["Plate"] = {
					"32648|"..L["Apexis Crystal"].." 4/"..L["Apexis Shard"].." 100",
				},
				["Leather"] = {
					"32647|"..L["Apexis Crystal"].." 4/"..L["Apexis Shard"].." 100",
				},
				["Off Hand"] = {
					"32652|"..L["Apexis Crystal"].." 1/"..L["Apexis Shard"].." 50",
				},
				["Held in Off-Hand"] = {
					"32651|"..L["Apexis Crystal"].." 4/"..L["Apexis Shard"].." 100",
				},
			},
			["Quest Reward"] = {
				["Stitch Scales "] = {
					31942, -- 데스윙 혈족 망토 : [70] 하늘의 패권\n▶인시디온/퓨리윙/리븐다크/옵시디아 비늘 합체\n - 퀘스트
				},
			},
			["Exchange"] = {
				["Normal|1"] = {
					"32601|"..L["Apexis Crystal"].." 10", -- 불안정한 마술사의 영약 : \n바쉬르 수정괴철로(54,11) - 교환
					"32598|"..L["Apexis Crystal"].." 10", -- 불안정한 야수의 영약 : \n지옥 수정괴철로(29,81) - 교환
				},
				["Phase1|2"] = {
					"32596|"..L["Apexis Crystal"].." 10", -- 불안정한 장로의 영약 :  - 판매(1단계 전투후)
					"32597|"..L["Apexis Crystal"].." 10", -- 불안정한 병사의 영약 :  - 판매(1단계 전투후)
					"32599|"..L["Apexis Crystal"].." 10", -- 불안정한 약탈자의 영약 :  - 판매(1단계 전투후)
					"32600|"..L["Apexis Crystal"].." 10", -- 불안정한 의술사의 영약 :  - 판매(1단계 전투후)
				},
				["Phase2|3"] = {
					"32634|"..L["Apexis Crystal"].." 40", -- 불안정한 자수정 :  - 판매(2단계 전투후)
					"32637|"..L["Apexis Crystal"].." 40", -- 불안정한 황수정 :  - 판매(2단계 전투후)
					"32635|"..L["Apexis Crystal"].." 40", -- 불안정한 감람석 :  - 판매(2단계 전투후)
					"32638|"..L["Apexis Crystal"].." 40", -- 불안정한 토파즈 :  - 판매(2단계 전투후)
					"32636|"..L["Apexis Crystal"].." 40", -- 불안정한 사파이어 :  - 판매(2단계 전투후)
					"32639|"..L["Apexis Crystal"].." 40", -- 불안정한 탈라사이트 :  - 판매(2단계 전투후)
				},
				["Phase3|4"] = {
					"32640|"..L["Apexis Crystal"].." 160", -- 마력이 담긴 불안정한 다이아몬드 :  - 판매(3단계 전투후)
					"32641|"..L["Apexis Crystal"].." 160", -- 마력이 깃든 불안정한 다이아몬드 :  - 판매(3단계 전투후)
					"32759|"..L["Apexis Crystal"].." 35", -- 가속장치 모듈 :  - 판매(3단계 전투후)
					--"32627", -- 마력이 담긴 작은 구리 정동석 : ▶요구사항:에펙시스 수정(3) - 판매(3단계 전투후) -- 사슬
					--"32626", -- 마력이 담긴 큰 구리 정동석 : ▶요구사항:에펙시스 수정(4) - 판매(3단계 전투후) -- 사슬
					--"32629", -- 마력이 담긴 큰 금 정동석 : ▶요구사항:에펙시스 수정(4) - 판매(3단계 전투후) -- 천
				},
			},
			["Apexis Crystal Infusion|U"] = {
				["Depleted Cloth Bracers"] = {
					32676, -- 마력이 고갈된 천 팔보호구 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32655|"..L["Apexis Crystal"].." 50 + "..L["Depleted Cloth Bracers"], -- 수정매듭 팔보호구 :
				},
				["Depleted Mail Gauntlets"] = {
					32675, -- 마력이 고갈된 사슬 건틀릿 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32656|"..L["Apexis Crystal"].." 50 + "..L["Depleted Mail Gauntlets"], -- 수정껍질 장갑 :
				},
				["Depleted Ring"] = {
					32678, -- 마력이 고갈된 반지 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32664|"..L["Apexis Crystal"].." 50 + "..L["Depleted Ring"], -- 꿈수정 고리 :
				},
				["Depleted Badge"] = {
					32672, -- 마력이 고갈된 배지 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32658|"..L["Apexis Crystal"].." 50 + "..L["Depleted Badge"], -- 불굴의 배지 :
				},
				["Depleted Cloak"] = {
					32677, -- 마력이 고갈된 망토 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32665|"..L["Apexis Crystal"].." 50 + "..L["Depleted Cloak"], -- 수정매듭 단망토 :
				},
				["Depleted Mace"] = {
					32671, -- 마력이 고갈된 둔기 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32661|"..L["Apexis Crystal"].." 50 + "..L["Depleted Mace"], -- 에펙시스 수정 철퇴 :
				},
				["Depleted Staff"] = {
					32679, -- 마력이 고갈된 지팡이 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32662|"..L["Apexis Crystal"].." 50 + "..L["Depleted Staff"], -- 이글거리는 석영 지팡이 :
				},
				["Depleted Two-Handed Axe"] = {
					32670, -- 마력이 고갈된 양손 도끼 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32663|"..L["Apexis Crystal"].." 50 + "..L["Depleted Two-Handed Axe"], -- 에펙시스 도끼 :
				},
				["Depleted Dagger"] = {
					32673, -- 마력이 고갈된 단검 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32659|"..L["Apexis Crystal"].." 50 + "..L["Depleted Dagger"], -- 수정이 주입된 비수 :
				},
				["Depleted Sword"] = {
					32674, -- 마력이 고갈된 검 : 칼날고원몹 랜덤드랍 - 마력이 고갈된 시리즈
					"32660|"..L["Apexis Crystal"].." 50 + "..L["Depleted Sword"], -- 수정으로 벼려낸 검 :
				},
			},
			["Drop"] = {
				["Shartuul"] = {
					32941, -- 타락자의 인장 : 드랍 - 샤툴
					32942, -- 감독관의 반지 : 드랍 - 샤툴
				},
			},
		},
	},
}

