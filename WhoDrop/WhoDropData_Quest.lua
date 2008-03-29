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
			....
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

WhoDropFieldData = {
	["Quest Reward|1"] = { 
		["Eastern Kingdoms|1"] = { -- 동부 왕국
			["Alterac Mountains"] = {
	--[[			["Archmage Alturus"] = {
					["The New Directive"] = {
						"Violet Badge",
					},
				},
				["Lieutenant Haggerdin|A"] = {
					["Korrak the Bloodrager"] = {
						"Bloodseeker",
						"Ice Barbed Spear",
						"Wand of Biting Cold",
						"Rune of Recall",
					},
					["The Eye of Command|H"] = {
						"Frostwolf Insignia Rank 6",
					},
					["Proving Grounds"] = {
						"Stormpike Insignia Rank 1The Frostwolf Artichoke",
					},
					["Rise and Be Recognized"] = {
						"Stormpike Insignia Rank 2",
					},
					["Honored Amongst the Guard"] = {
						"Stormpike Insignia Rank 3",
					},
					["Earned Reverence"] = {
						"Stormpike Insignia Rank 4",
					},
					["Legendary Heroes"] = {
						"Stormpike Insignia Rank 5",
					},
					["The Eye of Command"] = {
						"Stormpike Insignia Rank 6",
					},
				},
				["Medivh"] = {
					["Return to Khadgar"] = {
						"The Master's Key",
					},
				},
				["Voggah Deathgrip|H"] = {
					["Hero of the Frostwolf"] = {
						"Bloodseeker",
						"Ice Barbed Spear",
						"Wand of Biting Cold",
						"Cold Forged Hammer",
					},
				},
				["Warmaster Laggrond|H"] = {
					["Proving Grounds"] = {
						"Frostwolf Insignia Rank 1Peeling the Onion",
					},
					["Rise and Be Recognized"] = {
						"Frostwolf Insignia Rank 2",
					},
					["Honored Amongst the Clan"] = {
						"Frostwolf Insignia Rank 3",
					},
					["Earned Reverence"] = {
						"Frostwolf Insignia Rank 4",
					},
					["Legendary Heroes"] = {
						"Frostwolf Insignia Rank 5",
					},
					["The Legend of Korrak"] = {
						"Bloodseeker",
						"Ice Barbed Spear",
						"Wand of Biting Cold",
						"Rune of Recall",
					},
				},
				["Weldon Barov|A"] = {
					["The Last Barov"] = {
						"Barov Peasant Caller",
					},
				},]]
			},
		},
		["Kalimdor|2"] ={ -- 칼림도어
		},
		["Outland|3"] = { -- 아웃랜드
			["Hellfire Peninsula|1"] = {  -- 지옥불 반도
				["Sergeant Shatterskull|H|1"] = {  -- 퀘스트 NPC, 상인명칭, 이름 뒤에 |H(호드)나 |A(얼라이언스) 붙여서 진영을 표시한다.
					["Felspark Ravine"] ={   --- 퀘스트 이름..
						29908,
						29909,
						29910,
						29913,
						29911,
					},
				},
				["Forward Commander To'arch|H|2"] = {
					["Disrupt Their Reinforcements"] = {
						29946,
						29927,
						29939,
						29935,
						29932,
					},
					["Mission: Gateways Murketh and Shaadraz"] = {
						29944,
						29929,
						29937,
						29942,
					},
					["Mission: The Abyssal Shelf"] = {
						29926,
						29940,
						29936,
						29933,
					},
				},
				["Vurtok Axebreaker|H|3"] = {
					["Bonechewer Blood"] = {
						29915,
						29919,
						29914,
						29917,
						29916,
					},
				},
				["Apothecary Antonivich|H|4"] = {
					["The Demoniac Scryer"] = {
						31715,
					},
				},
				["Nazgrel|H|5"] = {
					["The Foot of the Citadel"] = {
						31720,
						31719,
						31717,
						31718,
					},
					["Cruel's Intentions"] = {
						28040,
						28041,
						28042,
					},
				},
				["Gorkan Bloodfist|H|6"] = {
					["Envoy to the Mag'har"] = {
						25510,
						25512,
						25511,
						25513,
					},
				},
				["Megzeg Nukklebust|H|7"] = {
					["I Work~~~ For the Horde!"] = {
						29945,
						29931,
						29938,
						29943,
					},
					["Burn It Up~~~ For the Horde!"] = {
						29928,
						29930,
						29934,
						29941,
					},
				},
				["Ranger Captain Venn'ren|H|8"] = {
					["Marking the Path"] = {
						25502,
						25502,
						25504,
					},
				},
				["Ryathen the Somber|H|9"] = {
					["The Cleansing Must Be Stopped"] = {
						25500,
						25501,
						25499,
					},
				},
				["Magistrix Carinda|H|10"] = {
					["Arelion's Mistress"] = {
						25505,
					},
				},
				["Apothecary Azethen|H|11"] = {
					["Source of the Corruption"] = {
						25914,
						25915,
						25913,
					},
				},
				["Taleris Dawngazer|H|12"] = {
					["A Pilgrim's Plight"] = {
						25781,
						25782,
						25783,
					},
				},
				["Wanted Poster|H|13"] = {
					["Wanted: Blacktalon the Savage"] = {
						27732,
						27731,
					},
				},
				["Zezzak|H|14"] = {
					["Grillok \"Darkeye\""] = {
						28057,
						28051,
						28050,
						28052,
						28055,
					},
				},
				["Ogath the Mad|H|15"] = {
					["From the Abyss"] = {
						29399,
						29398,
						29400,
					},
				},
				["Althen the Historian|H|16"] = {
					["Honor the Fallen"] = {
						29108,
						29109,
					},
				},
				["Earthcaller Ryga|H|17"] = {
					["Administering the Salve"] = {
						25492,
						25494,
						25495,
						25496,
						29212,
					},
				},
				["Sergeant Altumus|A|18"] = {
					["The Path of Anguish"] ={
						29908,
						29909,
						29910,
						29913,
						29911,
					},
				},
				["Forward Commander Kingston|A|19"] = {
					["Disrupt Their Reinforcements"] = {
						29946,
						29927,
						29939,
						29935,
						29932,
					},
				},
				["Lieutenant Amadi|A|20"] = {
					["Fel Orc Scavengers"] = {
						29915,
						29919,
						29914,
						29917,
						29916,
					},
				},
				["Force Commander Danath Trollbane|A|21"] = {
					["Drill the Drillmaster"] = {
						31720,
						31719,
						31717,
						31718,
					},
				},
				["Dumphry|A|22"] = {
					["Waste Not, Want Not"] = {
						29945,
						29931,
						29938,
						29943,
					},
					["Laying Waste to the Unwanted"] = {
						29928,
						29930,
						29934,
						29941,
					},
				},
				["Warp-Scryer Kryv|A|23"] = {
					["Overlord"] = {
						28040,
						28041,
						28042,
					},
				},
				["Wing Commander Dabir'ee|A|24"] = {
					["Zeth'Gor Must Burn!"] = {
						28057,
						28051,
						28050,
						28052,
						28055,
					},
				},
				["Honor Guard Wesilow|A|25"] = {
					["Looking to the Leadership"] = {
						25989,
						25992,
						25993,
					},
				},
				["Foreman Biggums|A|26"] = {
					["A Job for an Intelligent Man"] = {
						25785,
						25784,
					},
					["The Mastermind"] = {
						25984,
						25982,
						25983,
					},
				},
				["Makuru|A|27"] = {
					["Makuru's Vengeance"] = {
						25920,
						25919,
						25921,
					},
				},
				["Amaan the Wise|A|28"] = {
					["The Seer's Relic"] = {
						25508,
						25506,
						25507,
					},
					["Cleansing the Waters"] = {
						25484,
						25485,
						25486,
					},
				},
				["Ikan|A|29"] = {
					["The Rock Flayer Matriarch"] = {
						25480,
						25479,
						25478,
					},
				},
				["Mirren Longbeard|A|30"] = {
					["The Finest Down"] = {
						23587,
					},
				},
				["Foreman Razelcraz|31"] = {
					["Beneath Thrallmar"] = {
						30855,
						30856,
						30857,
					},
				},
				["Thiah Redmane|32"] = {
					["Testing the Antidote"] = {
						25985,
						25986,
						25987,
					},
				},
				["Tola'thion|33"] = {
					["Colossal Menace"] = {
						28064,
						28062,
						28065,
						28063,
						28066,
					},
				},
				["\"Screaming\" Screed Luckheed|34"] = {
					["In Case of Emergency~~~"] = {
						25980,
						25981,
						25979,
					},
					["Voidwalkers Gone Wild"] = {
						25786,
						25787,
					},
				},
				["Avruu's Orb|35"] = {
					["Avruu's Orb"] = {
						25489,
						25488,
						25487,
					},
				},
				["Earthbinder Galandria Nightbreeze|36"] = {
					["Natural Remedies"] = {
						28069,
						28070,
						28074,
						28075,
					},
				},
			},
			["Zangarmarsh|2"] = {
				["Zurjaya|H"] = {
					["Pursuing Terrorclaw"] = {
						25924,
						25923,
						25922,
						25925,
					},
				},
				["Ikuti|A"] = {
					["Overlord Gorefist"] = {
						25619,
						25618,
						31770,
					},
				},
				["Witch Doctor Tor'gash|H"] = {
					["Have You Ever Seen One of These?"] = {
						25611,
						25612,
						25610,
					},
				},
				["Drain Schematics"] = {
					["Drain Schematics"] = {
						27734,
						27735,
						27733,
						27730,
					},
				},
				["Amythiel Mistwalker"] = {
					["Return to the Marsh"] = {
						25524,
						25523,
						25522,
					},
				},
				["Kayra Longmane"] = {
					["Escape from Umbrafen"] = {
						25518,
						25517,
						25519,
					},
				},
				["Wanted Poster"] = {
					["Leader of the Bloodscale"] = {
						27724,
						27722,
						27723,
						27721,
					},
					["Leader of the Darkcrest"] = {
						27728,
						27725,
						27727,
						27726,
					},
				},
				["Puluu|A"] = {
					["Lines of Communication"] = {
						27753,
						27754,
						27756,
					},
					["The Terror of Marshlight Lake"] = {
						25924,
						25923,
						25922,
						25925,
					},
				},
				["Reavij|H"] = {
					["Nothin' Says Lovin' Like a Big Stinger"] ={
						31786,
						31787,
						31788,
						31789,
					},
				},
				["Gzhun'tt"] = {
					["Now That We're Friends~~~"] = {
						27749,
						27751,
						27750,
						27752,
					},
				},
				["T'shu"] = {
					["Oh, It's On!"] = {
						28111,
					},
				},
				["Timothy Daniels|A"] = {
					["Secrets of the Daggerfen"] = {
						25616,
						27553,
					},
				},
				["Seer Janidi|H"] = {
					["A Spirit Ally?"] = {
						25620,
						25621,
						31770,
					},
				},
				["Gambarinka|H"] = {
					["The Sharpest Blades"] = {
						27756,
						27753,
						27754,
					},
				},
				["Anchorite Ahuurn|A"] = {
					["Messenger to the Feralfen"] = {
						25613,
						25614,
						25615,
						31660,
					},
				},
				["Vindicator Idaar|A"] = {
					["An Unnatural Drought"] = {
						25599,
						25598,
						25597,
						31659,
					},
				},
				["Ikeyen"] = {
					["A Damp, Dark Place"] = {
						25516,
						25515,
						25514,
						27716,
					},
				},
				["Lauranna Thar'well"] = {
					["Saving the Sporeloks"] = {
						27717,
						31657,
						27715,
						31658,
					},
				},
				["Mack Diver|H"] = {
					["The Zapthrottle Mote Extractor!"] = {
						23888,
					},
				},
				["K~ Lee Smallfry|A"] = {
					["The Zapthrottle Mote Extractor!"] = {
						23888,
					},
				},
				["Zurai|H"] = {
					["Jyoba's Report"] = {
						25600,
						25601,
						25602,
						31768,
					},
				},
				["Prospector Conall"] = {
					["Blacksting's Bane"] = {
						31786,
						31787,
						31788,
						31789,
					},
				},
				["Shadow Hunter Denjai|H"] = {
					["Us or Them"] = {
						25617,
						27553,
					},
				},
				["Watcher Leesa'oh"] = {
					["Stealing Back the Mushrooms"] = {
						25525,
						25534,
						25530,
						31661,
					},
				},
			},
			["Shadowmoon Valley"] = {
	--[[			[""] = {
					["A Distraction for Akama"] = {
						32649,
					},
				},]]
				["Overlord Mor'ghor"] = {
					["A Job Unfinished~~~"] = {
						32866,
						32867,
						32865,
						32868,
					},
				},
				["Akama"] = {
					["Akama's Promise"] = {
						30932,
						30999,
						31000,
						30943,
						30984,
						31417,
					},
				},
	--[[			[""] = {
					["Battle of the Crimson Watch"] = {
						31380,
						31381,
						31382,
						31383,
						31408,
					},
				},]]
				["Wing Commander Nuainn|A"] = {
					["Blast the Infernals!"] = {
						30986,
						30947,
						30946,
						30929,
					},
				},
				["Plexi|A"] = {
					["News of Victory"] = {
						30973,
						30924,
						31025,
						31033,
						31031,
					},
				},
				["Blood Guard Gulmok|H"] = {
					["Blast the Infernals!"] = {
						30986,
						30947,
						30946,
						30929,
					},
				},
				["Nakansi|H"] = {
					["News of Victory"] = {
						30973,
						30924,
						31025,
						31033,
						31031,
					},
				},
				["Grokom Deatheye|H"] = {
					["Capture the Weapons"] = {
						30926,
						30938,
						30950,
						30966,
					},
				},
				["Earthmender Torlok"] = {
					["Enraged Spirits of Air"] = {
						30953,
						30930,
						30942,
						30964,
					},
				},
				["Oronok Torn-Heart"] = {
					["I Was A Lot Of Things~~~"] = {
						30357,
						30358,
						30359,
						30361,
					},
				},
				["Grom'tor, Son of Oronok"] = {
					["The Cipher of Damnation - The First Fragment Recov"] = {
						30945,
						30923,
						30981,
						30956,
					},
				},
				["Spirit of Ar'tor"] = {
					["The Cipher of Damnation - The Second Fragment Reco"] = {
						30936,
						30931,
						30957,
						30971,
						30959,
					},
				},
				["Earthmender Wilda"] = {
					["Escape from Coilskar Cistern"] = {
						30927,
						30952,
						30937,
						30968,
					},
				},
				["Ordinn Thunderfist|A"] = {
					["Capture the Weapons"] = {
						30926,
						30938,
						30950,
						30966,
					},
				},
				["Vindicator Aluumen |A"] = {
					["Reclaiming Holy Grounds"] = {
						30940,
						30961,
						30922,
						30958,
					},
				},
				["Varen the Reclaimer"] = {
					["The Great Retribution"] = {
						30940,
						30961,
						30922,
						30958,
					},
				},
				["Wildhammer Gryphon Rider|A"] = {
					["Dissention Amongst the Ranks~~~"] = {
						31075,
						31077,
						31076,
						31078,
					},
				},
				["Parshah"] = {
					["Thwart the Dark Conclave"] = {
						30941,
						30955,
						30960,
						30928,
					},
				},
				["Wanted Poster|A"] = {
					["Wanted: Uvuros, Scourge of Shadowmoon"] = {
						31112,
						31114,
						31111,
						31115,
					},
				},
				["Wanted Poster|H"] = {
					["Wanted: Uvuros, Scourge of Shadowmoon"] = {
						31112,
						31114,
						31111,
						31115,
					},
				},
			},
			["Netherstorm"] = {
				["Caledis Brightdawn"] = {
					["Information Gathering"] = {
						30397,
						30383,
						30384,
						30386,
					},
				},
				["Magistrix Larynna"] = {
					["Kick Them While They're Down"] = {
						30395,
						30394,
						30396,
						30522,
					},
				},
				["Voren'thal the Seer"] = {
					["Turning Point"] = {
						30375,
						30372,
						30373,
						30374,
					},
				},
				["Spymaster Thalodien"] = {
					["Shutting Down Manaforge Ara"] = {
						30366,
						30378,
					},
				},
				["Custodian Dieworth"] = {
					["A Fate Worse Than Death"] = {
						29955,
						29954,
						30401,
						29959,
					},
				},
				["Tyri"] = {
					["Securing the Celestial Ridge"] = {
						29808,
						29810,
						29811,
						29812,
					},
				},
				["Agent Ya-six"] = {
					["Arconus the Insatiable"] = {
						30329,
						30328,
						30330,
						30517,
					},
				},
				["Wanted Poster"] = {
					["Breaking Down Netherock"] = {
						30314,
						31313,
						30315,
						30312,
					},
					["Wanted: Annihilator Servo!"] = {
						30295,
						30296,
						30294,
					},
				},
				["Lieutenant-Sorcerer Morran"] = {
					["Building a Perimeter"] = {
						29785,
						29784,
						29786,
						30398,
					},
				},
				["Papa Wheeler"] = {
					["Pick Your Part"] = {
						30275,
						30274,
						30276,
					},
				},
				["Mama Wheeler"] = {
					["Declawing Doomclaw"] = {
						30279,
						30278,
						30277,
					},
				},
				["Doctor Vomisa, Ph~T~"] = {
					["Back to the Chief!"] = {
						30019,
						30016,
						30014,
						30847,
					},
				},
				["Nether-Stalker Khay'ji"] = {
					["Warp-Raider Nesaad"] = {
						30266,
						30265,
						30267,
					},
				},
				["Gahruj"] = {
					["Rightful Repossession"] = {
						30273,
						30272,
						30271,
					},
				},
				["Special Delivery to Shattrath City"] = {
					["Special Delivery to Shattrath City"] = {
						30258,
						30256,
						30257,
					},
				},
				["A'dal"] = {
					["How to Break Into the Arcatraz"] = {
						31465,
						31461,
						31464,
						31462,
						31460,
						31084,
					},
					["Harbinger of Doom"] = {
						31747,
						31749,
						31748,
					},
				},
				["Foreman Sundown"] = {
					["Dealing with the Overmaster"] = {
						30003,
						30004,
						30005,
						30006,
					},
				},
				["Exarch Orelis"] = {
					["Measuring Warp Energies"] = {
						30362,
						30363,
						30364,
						30521,
					},
				},
				["Kaylaan"] = {
					["Aldor No More"] = {
						30382,
						30379,
						30381,
						30380,
					},
				},
				["Drijya"] = {
					["Sabotage the Warp-Gate!"] = {
						29978,
						29980,
						29979,
					},
				},
				["Captured Protectorate Vanguard"] = {
					["Escape from the Staging Grounds"] = {
						30331,
						30332,
						30333,
						30334,
					},
				},
				["Nether-Stalker Nauthis"] = {
					["Teleport This!"] = {
						31701,
						31700,
						31703,
						31699,
					},
				},
				["Zuben Elgenubi"] = {
					["Hitting the Motherlode"] = {
						29813,
						29814,
						29815,
					},
				},
				["Apprentice Andrethan"] = {
					["Master Smith Rhonsus"] = {
						29787,
						29788,
						29789,
						29791,
					},
				},
				["Deathblow to the Legion"] = {
					["Deathblow to the Legion"] = {
						30368,
						30369,
						30370,
						30371,
						30860,
					},
				},
				["N~ D~ Meancamp"] = {
					["It's a Fel Reaver, But with Heart"] = {
						30268,
						30270,
						30269,
					},
				},
				["Audi the Needle"] = {
					["Retrieving the Goods"] = {
						30284,
						30402,
						30285,
						30286,
					},
				},
				["Custodian Dieworth"] = {
					["Destroy Naberius!"] = {
						29780,
						29781,
						29782,
						29783,
					},
				},
				["Maxx A~ Million Mk~ V"] = {
					["Mark V is Alive!"] = {
						30226,
						30227,
						30252,
					},
				},
				["Bessy"] = {
					["When the Cows Come Home"] = {
						29804,
						29806,
						29807,
						30400,
						30523,
					},
				},
				["Professor Dabiri"] = {
					["Dimensius the All-Devouring"] = {
						30297,
						30300,
						30299,
						30298,
					},
				},
				["Tashar"] = {
					["Success!"] = {
						30293,
						30290,
						30291,
						30520,
					},
				},
				["Boots"] = {
					["That Little Extra Kick"] = {
						29999,
						30002,
						30001,
						30000,
					},
				},
				["Anchorite Karja"] = {
					["Shutting Down Manaforge Ara"] = {
						30377,
						30365,
					},
				},
				["Zephyrion"] = {
					["Surveying the Ruins"] = {
						30255,
						30253,
						30254,
					},
				},
				["Image of Archmage Vargoth"] = {
					["The Sigil of Krasus"] = {
						29771,
						29772,
						29773,
						29774,
					},
					["Ar'kelos the Guardian"] = {
						29775,
						29776,
						29777,
						29779,
					},
				},
				["The Image of Commander Ameer"] = {
					["Delivering the Message"] = {
						30335,
						30337,
						30336,
						30518,
					},
					["Nexus-King Salhadaar"] = {
						30011,
						30012,
						30010,
						30013,
						30009,
					},
				},
				["Agent Araxes"] = {
					["The Flesh Lies	~~~"] = {
						30352,
						30341,
						30342,
						30519,
					},
				},
				["Vial of Void Horror Ooze|H"] = {
					["The Horrors of Pollution"] = {
						30338,
						30339,
						30340,
					},
				},
				["Custodian Dieworth"] = {
					["Down With Daellis"] = {
						29792,
						29793,
						30399,
						29794,
					},
				},
				["Rocket-Chief Fuselage"] = {
					["You're Hired!"] = {
						30225,
						30224,
						30218,
						30515,
					},
				},
				["Chief Engineer Trep"] = {
					["Elemental Power Extraction"] = {
						30264,
						30263,
						30262,
						30516,
					},
				},
				["Lead Sapper Blastfizzle"] = {
					["Dr~ Boom!"] = {
						29969,
						29968,
						29967,
						30514,
					},
				},
			},
			["Blade's Edge Mountains"] = {
	--[[			[""] = {
					["A Crystalforged Darkrune"] = {
						32602,
					},
				},]]
				["Chu'a'lor"] = {
					["A Special Thank You"] = {
						32835,
					},
				},
				["Samia Inkling"] = {
					["Whelps of the Wyrmcult"] = {
						31509,
						31513,
						31515,
						31519,
					},
				},
				["Tree Warden Chawn"] = {
					["~~~and a Time for Action"] = {
						31510,
						31512,
						31516,
						31521,
					},
				},
				["Lieutenant Fairweather|A"] = {
					["Crush the Bloodmaul Camp!"] = {
						31537,
						31538,
						31539,
						31540,
					},
				},
				["Nickwinkle the Metro-Gnome|A"] = {
					["Gauging the Resonant Frequency"] = {
						31444,
						31443,
						31445,
						31442,
					},
				},
				["Legion Communicator"] = {
					["You're Fired!"] = {
						31793,
						31792,
						31790,
						31791,
					},
				},
				["Evergrove Druid"] = {
					["The Hound-Master"] = {
						31693,
						31696,
						31695,
						31692,
						31691,
						31694,
					},
				},
				["Tree Warden Chawn"] = {
					["Maxnar Must Die!"] = {
						31508,
						31511,
						31514,
						31520,
					},
				},
				["Baron Sablemane|A"] = {
					["Into the Churning Gulch"] = {
						31535,
					},
				},
				["Commander Haephus Stonewall|A"] = {
					["Gorgrom the Dragon-Eater"] = {
						31542,
						31541,
						31543,
					},
				},
				["Baron Sablemane|A"] = {
					["Showdown"] = {
						31546,
						31544,
						31545,
						31547,
						31549,
						31548,
					},
				},
				["Wanted Poster|H"] = {
					["Felling an Ancient Tree"] = {
						31486,
						31487,
						31488,
						31485,
					},
				},
				["Leoroxx|H"] = {
					["There Can Be Only One Response"] = {
						31687,
						31688,
						31689,
						31690,
					},
				},
				["Bronwyn Stouthammer|A"] = {
					["Into the Draenethyst Mine"] = {
						31429,
						31431,
						31430,
						31432,
					},
				},
				["Mosswood the Ancient"] = {
					["From the Ashes"] = {
						31414,
						31416,
						31415,
					},
				},
				["Matron Varah|H"] = {
					["Mok'Nathal Treats"] = {
						31674,
						31672,
						31673,
						31675,
					},
				},
				["Dizzy Dina|A"] = {
					["Ridgespine Menace"] = {
						31449,
						31450,
					},
				},
				["Razak Ironsides|A"] = {
					["Cutting Your Teeth"] = {
						31446,
						31447,
						31448,
					},
				},
				["Toshley|A"] = {
					["Ride the Lightning"] = {
						31452,
						31453,
						31454,
						31455,
						31451,
					},
					["Show Them Gnome Mercy!"] = {
						31456,
						31457,
						31458,
						31459,
						30690,
					},
				},
				["Leoroxx|H"] = {
					["Slay the Brood Mother"] = {
						31683,
						31685,
						31684,
						31686,
					},
				},
				["Tor'chunk Twoclaws|H"] = {
					["The Bloodmaul Ogres"] = {
						31477,
						31479,
						31478,
						31480,
					},
				},
				["Commander Skyshadow|A"] = {
					["The Bladespire Ogres"] = {
						31425,
						31426,
						31427,
						31428,
					},
				},
				["Wanted Poster|A"] = {
					["The Den Mother"] = {
						31423,
						31422,
						31424,
					},
				},
				["Gor'drek|H"] = {
					["Protecting Our Own"] = {
						31481,
						31482,
						31483,
						31484,
					},
				},
				["Rina Moonspring|A"] = {
					["Protecting Our Own"] = {
						31418,
						31419,
						31420,
						31421,
					},
				},
				["Timeon"] = {
					["Whispers of the Raven God"] = {
						31531,
						31532,
						31533,
						31534,
					},
				},
				["Spiritcaller Dohgar|H	"] = {
					["Spirit Calling"] = {
						31711,
						31713,
						31712,
						31714,
						31743,
					},
				},
				["Vindicator Vuuleen|A"] = {
					["Planting the Banner"] = {
						31433,
						31434,
						31435,
						31436,
					},
				},
				["Treebole"] = {
					["Exorcising the Trees"] = {
						31526,
						31527,
						31523,
						31528,
					},
				},
				["T'chali the Witch Doctor|H"] = {
					["A Curse Upon Both of Your Clans!"] = {
						31470,
						31471,
						31472,
						31473,
					},
				},
				["Rokgah Bloodgrip|H"] = {
					["The Thunderspike"] = {
						31475,
						31476,
						31474,
					},
				},
				["Baron Sablemane|H"] = {
					["Into the Churning Gulch"] = {
						31535,
					},
				},
				["Tor'chunk Twoclaws|H"] = {
					["Crush the Bloodmaul Camp"] = {
						31537,
						31538,
						31539,
						31540,
					},
				},
				["Rexxar|H"] = {
					["Gorgrom the Dragon-Eater"] = {
						31542,
						31541,
						31543,
					},
					["Showdown"] = {
						31546,
						31544,
						31545,
						31547,
						31549,
						31548,
					},
				},
				["Fizit \"Doc\" Clocktock|A"] = {
					["What Came First, the Drake or the Egg?"] = {
						31438,
						31439,
						31440,
						31441,
						31437,
					},
				},
			},
			["Nagrand"] = {
				["Altruis the Sufferer"] = {
					["Forge Camp: Annihilated"] = {
						25822,
						25821,
						25820,
						25819,
					},
				},
				["Arechron|A"] = {
					["Corki's Gone Missing Again!"] = {
						25631,
						25632,
						25633,
					},
					["Ortor My Old Friend~~~"] = {
						25583,
						25584,
						25585,
					},
				},
				["Chief Researcher Amereldine|H"] = {
					["Oshu'gun Crystal Powder"] = {
						26044,
					},
				},
				["Chief Researcher Kartos|A"] = {
					["Oshu'gun Crystal Powder"] = {
						26044,
					},
				},
				["Corki|A"] = {
					["Cho'war the Pillager"] = {
						25777,
						25776,
						25775,
					},
				},
				["Elder Yorley|H"] = {
					["Cho'war the Pillager"] = {
						25777,
						25776,
						25775,
					},
				},
				["Elementalist Lo'ap"] = {
					["A Rare Bean"] = {
						24421,
					},
					["The Spirit Polluted"] = {
						25558,
						25557,
						25556,
					},
					["Muck Diving"] = {
						25560,
						25561,
						25559,
					},
				},
				["Elementalist Morgh"] = {
					["Murkblood Corrupters"] = {
						25566,
						25565,
						25567,
					},
				},
				["Elkay'gan the Mystic|H"] = {
					["Bleeding Hollow Supply Crates"] = {
						25630,
						25629,
						25628,
					},
				},
				["Exarch Onaala"] = {
					["Varedis Must Be Stopped"] = {
						31013,
						30933,
						31010,
						31002,
						30948,
						31009,
					},
				},
				["Farseer Kurkush|H"] = {
					["Vile Idolatry"] = {
						25570,
						25568,
						25569,
					},
				},
				["Farseer Margadesh|H"] = {
					["Murkblood Leaders~~~"] = {
						25583,
						25585,
						25584,
					},
				},
				["Finding the Survivors|H"] = {
					["Finding the Survivors"] = {
						25778,
						25779,
						25780,
					},
				},
				["Gordawg"] = {
					["Gurok the Usurper"] = {
						25563,
						25564,
						25562,
					},
				},
				["Gurgthock"] = {
					["The Ring of Blood: The Final Challenge"] = {
						25762,
						25760,
						25763,
						25761,
						25764,
						25759,
					},
				},
				["Harold Lane"] = {
					["Talbuk Mastery"] = {
						25543,
						25636,
						25545,
					},
				},
				["Hemet Nesingwary"] = {
					["Clefthoof Mastery"] = {
						25591,
						25592,
						25589,
					},
					["The Ultimate Bloodsport"] = {
						25640,
						29211,
						25639,
						25643,
						25644,
						25645,
					},
				},
				["Huntress Kima|A"] = {
					["The Ravaged Caravan"] = {
						25778,
						25779,
						25780,
					},
				},
				["Jorin Deadeye|H"] = {
					["An Audacious Advance"] = {
						25622,
						25623,
						25624,
					},
				},
				["Lantresor of the Blade|H"] = {
					["Message to Garadar"] = {
						25607,
						25608,
						25609,
					},
				},
				["Lantresor of the Blade|A"] = {
					["Message to Telaar"] = {
						25607,
						25608,
						25609,
					},
				},
				["Larissa Sunstrike"] = {
					["Varedis Must Be Stopped"] = {
						31013,
						30933,
						31010,
						31002,
						30948,
						31009,
					},
				},
				["Mo'mor the Breaker|A"] = {
					["The Twin Clefts of Nagrand"] = {
						25623,
						25624,
						25622,
					},
				},
				["Otonbu the Sage|A"] = {
					["Stopping the Spread"] = {
						25570,
						25568,
						25569,
					},
				},
				["Poli'lukluk the Wiser|A"] = {
					["Solving the Problem"] = {
						25577,
						25578,
						25579,
					},
				},
				["Shado 'Fitz' Farstrider"] = {
					["Windroc Mastery"] = {
						25595,
						25594,
						25593,
					},
				},
				["Warden Bullrok|H"] = {
					["Wanted: Durn the Hungerer"] = {
						25774,
						25773,
						25772,
					},
				},
				["Warden Iolol|A"] = {
					["Wanted: Durn the Hungerer"] = {
						25774,
						25773,
						25772,
					},
				},
				["Wazat"] = {
					["I Must Have Them!"] = {
						27808,
					},
				},
				["Wazat"] = {
					["Bring Me The Egg!"] = {
						28030,
						28032,
						28031,
					},
				},
				["Zerid"] = {
					["Gava'xi"] = {
						25637,
						25634,
						25544,
					},
				},
			},
			["Terokkar Forest"] = {
				["Advisor Faila|H"] = {
					["Kill the Shadow Council!"] = {
						25933,
						25935,
						25934,
					},
				},
				["Akuno"] = {
					["Escaping the Tomb"] = {
						31733,
						31734,
						31731,
						31732,
					},
				},
				["Bertelm|A"] = {
					["The Elusive Ironjaw"] = {
						25974,
						25976,
						25977,
						25975,
					},
				},
				["Commander Ra'vaj"] = {
					["The Fallen Exarch"] = {
						31798,
						31797,
						31796,
						31794,
					},
				},
				["Defender Grashna"] = {
					["The Skettis Offensive"] = {
						31727,
						31726,
					},
				},
				["Dwarfowitz"] = {
					["The Big Bone Worm"] = {
						31756,
						31758,
						31759,
					},
				},
				["Ethan"] = {
					["Missing Friends"] = {
						31666,
					},
				},
				["Greatfather Aldrimus"] = {
					["Everything Will Be Alright"] = {
						29341,
						29340,
						29339,
						29337,
					},
				},
				["High Priest Orglum"] = {
					["The Vengeful Harbinger"] = {
						31617,
						31615,
					},
				},
				["Isfar"] = {
					["Brother Against Brother"] = {
						29333,
						29334,
						29335,
						29336,
					},
					["Terokk's Legacy"] = {
						29330,
						29332,
						29329,
					},
				},
				["Isla Starmane"] = {
					["Escape from Firewing Point!"] = {
						25918,
						25917,
						25916,
					},
				},
				["Jenai Starwhisper|A"] = {
					["Letting Earthbinder Tavgren Know"] = {
						25931,
						25930,
						25932,
						25929,
					},
				},
				["Kirrik the Awakened"] = {
					["Veil Rhaze: Unliving Evil"] = {
						31761,
						31762,
					},
					["Veil Lithic: Preemptive Strike"] = {
						25959,
						25961,
						25958,
						25960,
					},
					["Veil Shalas: Signal Fires"] = {
						25966,
						25965,
						25963,
					},
				},
				["Kokorek"] = {
					["The Final Reagents"] = {
						25966,
						25965,
						25963,
					},
				},
				["Lieutenant Meridian|A"] = {
					["The Final Code"] = {
						31785,
						31782,
						31784,
						31783,
					},
				},
				["Lookout Nodak|H"] = {
					["Rescue Dugar!"] = {
						25967,
						25969,
						25970,
						25968,
					},
				},
				["Malukaz|H"] = {
					["Welcoming the Wolf Spirit"] = {
						25974,
						25976,
						25977,
						25975,
					},
				},
				["Mawg Grimshot|H"] = {
					["Torgos!"] = {
						25937,
						25936,
					},
				},
				["Mekeda"] = {
					["The Shadow Tomb"] = {
						"Heirloom Signet of Convalescence",
						"Heirloom Signet of Valor",
						"Heirloom Signet of Willpower",
					},
				},
				["Nexus-Prince Haramad"] = {
					["Undercutting the Competition"] = {
						"Haramad's Leggings of the Third Coin",
						"Consortium Plated Legguards",
						"Haramad's Leg Wraps",
						"Haramad's Linked Chain Pantaloons",
					},
				},
				["Nitrin the Learned"] = {
					["Levixus the Soul Caller"] = {
						"Cover of Righteous Fury",
						"Earthbreaker's Greaves",
						"Gloves of Penitence",
						"Leggings of the Third Coin",
					},
				},
				["Oakun"] = {
					["Evil Draws Near"] = {
						"Dragonbone Greatsword",
						"Dragonbone Shoulders",
						"Dragonbone Talisman",
					},
				},
				["Private Weeks|A"] = {
					["Kill the Shadow Council!"] = {
						25933,
						25935,
						25934,
					},
				},
				["Prospector Balmoral|A"] = {
					["Rescue Deirom!"] = {
						25967,
						25969,
						25970,
						25968,
					},
				},
				["Ramdor the Mad"] = {
					["Helping the Lost Find Their Way"] = {
						25948,
						25949,
						25951,
						31725,
					},
				},
				["Ros'eleth|A"] = {
					["A Dandy's Best Friend"] = {
						28499,
					},
				},
				["Sergeant Chawni|H"] = {
					["The Final Code"] = {
						31785,
						31782,
						31784,
						31783,
					},
				},
				["Shadowstalker Kaide|H"] = {
					["What Happens in Terokkar Stays in Terokkar"] = {
						25973,
						25972,
						25971,
					},
				},
				["Skyguard Prisoner"] = {
					["Escape from Skettis"] = {
						28100,
						28101,
					},
				},
				["Skywing"] = {
					["Skywing"] = {
						31760,
						31766,
						31765,
						31764,
					},
				},
				["Spy To'gun"] = {
					["The Soul Devices"] = {
						28174,
						28171,
						28170,
						28167,
					},
				},
				["Stolen Cargo|H"] = {
					["Return to Rokag"] = {
						25959,
						25961,
						25958,
						25960,
					},
				},
				["Taela Everstride|A"] = {
					["Torgos!"] = {
						25937,
						25936,
					},
				},
				["The Codex of Blood"] = {
					["Into the Heart of the Labyrinth"] = {
						28179,
						28178,
						28177,
						28176,
					},
				},
				["Theloria Shadecloak|A"] = {
					["Thinning the Ranks"] = {
						25973,
						25972,
						25971,
					},
				},
				["Tooki|H"] = {
					["Letting Earthbinder Tavgren Know"] = {
						25931,
						25930,
						25932,
						25929,
					},
				},
				["Vekax"] = {
					["The Outcast's Plight"] = {
						31800,
					},
				},
				["Vindicator Haylen|A"] = {
					["Terokkarantula"] = {
						31821,
						31820,
						31819,
						31823,
					},
				},
				["Warden Treelos"] = {
					["It's Watching You!"] = {
						25542,
						28028,
						28026,
						28027,
						31723,
					},
				},
				["Wind Trader Lathrai"] = {
					["A Personal Favor"] = {
						25927,
						25926,
						25928,
						31724,
					},
				},
	--[[			[""] = {
					["Adversarial Blood"] = {
						32720,
					},
				},
				["|A"] = {
					["Return to Thander"] = {
						25959,
						25961,
						25958,
						25960,
					},
				},]]
			},
		},
	},
}
