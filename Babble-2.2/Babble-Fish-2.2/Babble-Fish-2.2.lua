﻿--[[
Name: Babble-Fish-2.2
Revision: $Rev: 79692 $
Authors(s): kagaro (sal.scotto@gmail.com)
Website: www.wowace.com
Documentation: http://www.wowace.com/wiki/Babble-Fish-2.2
SVN: http://svn.wowace.com/root/branch/Babble-2.2/Babble-Fish-2.2
Dependencies: AceLibrary, AceLocale-2.2
License: MIT
]]

local MAJOR_VERSION = "Babble-Fish-2.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 79692 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:HasInstance("AceLocale-2.2") then error(MAJOR_VERSION .. " requires AceLocale-2.2") end

local _, x = AceLibrary("AceLocale-2.2"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleFish = AceLibrary("AceLocale-2.2"):new(MAJOR_VERSION)

BabbleFish:RegisterTranslations("enUS", function() return {
-- Fishing Node
	["Floating Wreckage"] = true,
	["Patch of Elemental Water"] = true,
	["Floating Debris"] = true,
	["Oil Spill"] = true,
	["Firefin Snapper School"] = true,
	["Greater Sagefish School"] = true,
	["Oily Blackmouth School"] = true,
	["Sagefish School"] = true,
	["School of Deviate Fish"] = true,
	["Stonescale Eel Swarm"] = true,
	["Muddy Churning Water"] = true,
	["Highland Mixed School"] = true,  
	["Pure Water"] = true,            
	["Bluefish School"] = true,
	["Feltail School"] = true, 
	["Mudfish School"] = true, 
	["School of Darter"] = true, 
	["Sporefish School"] = true,  
	["Steam Pump Flotsam"] = true, 
	["School of Tastyfish"] = true,
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = true,
	["Savage Coast Blue Sailfin"] = true,
	["Misty Reed Mahi Mahi"] = true,
	["Feralas Ahi"] = true,
	["Spotted Sunfish"] = true,
	["Lightning Eel"] = true,
--["Oil Covered Fish"] = true,
	["Plated Armorfish"] = true,
	["Darkshore Grouper"] = true,
	["Electropeller"] = true,
	["Gaffer Jack"] = true,
	["Speckled Tastyfish"] = true,
	["Keefer's Angelfish"] = true,
	["Dezian Queenfish"] = true,
	["Brownell's Blue Striped Racer"] = true,
-- Normal Fish
	["Stonescale Eel"] = true,
	["Oily Blackmouth"] = true,
	["Firefin Snapper"] = true,
	["Oil Covered Fish"] = true,
	["Sickly Looking Fish"] = true,
	["Raw Brilliant Smallfish"] = true,
	["Raw Bristle Whisker Catfish"] = true,
	["Raw Glossy Mightfish"] = true,
	["Raw Greater Sagefish"] = true,
	["Raw Loch Frenzy"] = true,
	["Raw Longjaw Mud Snapper"] = true,
	["Raw Mithril Head Trout"] = true,
	["Raw Nightfin Snapper"] = true,
	["Raw Rainbow Fin Albacore"] = true,
	["Raw Redgill"] = true,
	["Raw Rockscale Cod"] = true,
	["Raw Sagefish"] = true,
	["Raw Slitherskin Mackerel"] = true,
	["Raw Spotted Yellowtail"] = true,
	["Raw Summer Bass"] = true,
	["Raw Sunscale Salmon"] = true,
	["Raw Whitescale Salmon"] = true,
	["Darkclaw Lobster"] = true,
	["Deviate Fish"] = true,
	["Large Raw Mightfish"] = true,
	["Winter Squid"] = true,
	["Felblood Snapper"] = true,
	["Figluster's Mudfish"] = true,
	["Furious Crawdad"] = true,
	["Golden Darter"] = true,
	["Icefin Bluefish"] = true,
	["Spotted Feltail"] = true,
	["Zangarian Sporefish"] = true,
	["Goldenscale Vendorfish"] = true,
	["Crescent-Tail Skullfish"] = true,
	["Bloodfin Catfish"] = true,
}
end)

BabbleFish:RegisterTranslations("koKR", function() return {
-- Fishing Node
	["Floating Wreckage"] = "표류하는 잔해",
	["Patch of Elemental Water"] = "정기가 흐르는 물 웅덩이",
	["Floating Debris"] = "표류하는 파편",
	["Oil Spill"] = "떠다니는 기름",
	["Firefin Snapper School"] = "불지느러미퉁돔 떼",
	["Greater Sagefish School"] = "대형 총명어 떼",
	["Oily Blackmouth School"] = "기름기 많은 아귀 떼",
	["Sagefish School"] = "총명어 떼",
	["School of Deviate Fish"] = "돌연변이 물고기 떼",
	["Stonescale Eel Swarm"] = "돌비늘뱀장어 떼",
	["Muddy Churning Water"] = "거품이는 진흙탕물",
	["Highland Mixed School"] = "고원의 물고기 떼",
	["Pure Water"] = "깨끗한 물",
	["Bluefish School"] = "게르치 떼",
	["Feltail School"] = "지옥꼬리퉁돔 떼",
	["Mudfish School"] = "미꾸라지 떼",
	["School of Darter"] = "검은 물고기 떼",
	["Sporefish School"] = "포자물고기 떼",
	["Steam Pump Flotsam"] = "증기 양수기 표류물",
	["School of Tastyfish"] = "맛둥어 떼",
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = "살데리스 아귀",
	["Savage Coast Blue Sailfin"] = "폭풍 해안 푸른도루묵",
	["Misty Reed Mahi Mahi"] = "안개갈대 황새치",
	["Feralas Ahi"] = "페랄라스 참치",
	["Spotted Sunfish"] = "점박이 개복치",
	["Lightning Eel"] = "번개뱀장어",
	["Oil Covered Fish"] = "기름으로 범벅된 물고기",
	["Plated Armorfish"] = "무쇠비늘 철갑어",
	["Darkshore Grouper"] = "어둠의해안 농어",
	["Electropeller"] = "전력추진기",
	["Gaffer Jack"] = "개퍼 잭",
	["Speckled Tastyfish"] = "점박이맛둥어",
	["Keefer's Angelfish"] = "키퍼의 천사돔",
	["Dezian Queenfish"] = "데지안 여왕물고기",
	["Brownell's Blue Striped Racer"] = "브로넬의 푸른줄무늬날치",
-- Normal Fish
	["Stonescale Eel"] = "돌비늘뱀장어",
	["Oily Blackmouth"] = "기름기 많은 아귀",
	["Firefin Snapper"] = "불지느러미퉁돔",
	["Oil Covered Fish"] = "기름으로 범벅된 물고기",
	["Sickly Looking Fish"] = "병들어 보이는 물고기",
	["Raw Brilliant Smallfish"] = "비단잉어",
	["Raw Bristle Whisker Catfish"] = "표범메기",
	["Raw Glossy Mightfish"] = "빛깔좋은 망둥어",
	["Raw Greater Sagefish"] = "대형 총명어",
	["Raw Loch Frenzy"] = "호수프렌지",
	["Raw Longjaw Mud Snapper"] = "긴주둥이진흙퉁돔",
	["Raw Mithril Head Trout"] = "미스릴송어",
	["Raw Nightfin Snapper"] = "밤비늘퉁돔",
	["Raw Rainbow Fin Albacore"] = "무지개날개다랑어",
	["Raw Redgill"] = "붉은퉁돔",
	["Raw Rockscale Cod"] = " 돌비늘대구",
	["Raw Sagefish"] = "총명어",
	["Raw Slitherskin Mackerel"] = " 줄무늬고등어",
	["Raw Spotted Yellowtail"] = "점박이놀래기",
	["Raw Summer Bass"] = "넙치농어",
	["Raw Sunscale Salmon"] = "해비늘연어",
	["Raw Whitescale Salmon"] = " 유리비늘연어 ",
	["Darkclaw Lobster"] = "검은발톱 랍스터",
	["Deviate Fish"] = "돌연변이 물고기",
	["Large Raw Mightfish"] = "큰 망둥어",
	["Winter Squid"] = "겨울오징어",
	["Felblood Snapper"] = "지옥피퉁돔",
	["Figluster's Mudfish"] = "피글루스터 미꾸라지",
	["Furious Crawdad"] = "사나운 가재",
	["Golden Darter"] = "황금 화살고기",
	["Icefin Bluefish"] = "얼음지느러미게르치",
	["Spotted Feltail"] = "점박이지옥꼬리통돔",
	["Zangarian Sporefish"] = "장가리안 포자물고기",
	["Goldenscale Vendorfish"] = "황금비늘 장사꾼고기",
	["Crescent-Tail Skullfish"] = "초승달꼬리 해골물고기",
	["Bloodfin Catfish"] = "피지느러미 메기",
}
end)

BabbleFish:RegisterTranslations("deDE", function() return {
-- Fishing Node
	["Floating Wreckage"] = "Treibende Wrackteile",
	["Patch of Elemental Water"] = "Stelle mit Elementarwasser",
	["Floating Debris"] = "Schwimmende Trümmer",
	["Oil Spill"] = "Ölfleck", 
	["Firefin Snapper School"] = "Feuerflossenschnapperschwarm",
	["Greater Sagefish School"] = "Schwarm großer Weisenfische",
	["Oily Blackmouth School"] = "Schwarm öliger Schwarzmaulfische",
	["Sagefish School"] = "Weisenfischschwarm",
	["School of Deviate Fish"] = "Deviatfischschwarm",
	["Stonescale Eel Swarm"] = "Steinschuppenaalschwarm",
	["Muddy Churning Water"] = "Schlammiges aufgewühltes Gewässer",
	["Highland Mixed School"] = "Mischschwarm des Hochlands",
	["Pure Water"] = "Reines Wasser",
	["Bluefish School"] = "Blauflossenschwarm",
	["Feltail School"] = "Teufelsfinnenschwarm",
	["Mudfish School"] = "Matschflosserschwarm",
	["School of Darter"] = "Stachelflosserschwarm",
	["Sporefish School"] = "Sporenfischschwarm",
	["Steam Pump Flotsam"] = "Treibgut der Dampfpumpe",
	["School of Tastyfish"] = "Leckerfischschwarm",
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = "Sar'therisbarsch",
	["Savage Coast Blue Sailfin"] = "Blauwimpel von der ungezähmten Küste",
	["Misty Reed Mahi Mahi"] = "Nebelschilf-Mahi-Mahi",
	["Feralas Ahi"] = "Feralas Ahi",
	["Spotted Sunfish"] = "Gefleckter Sonnenfisch",
	["Lightning Eel"] = "Zitteraal",
	["Oil Covered Fish"] = "Ölbedeckter Fisch",
	["Plated Armorfish"] = "Panzerfisch",
	["Darkshore Grouper"] = "Dunkelküstenbarsch",
	["Electropeller"] = "Elektropeller",
	["Gaffer Jack"] = "Klemmmuffen",
	["Speckled Tastyfish"] = "Gesprenkelter Leckerfisch",
	["Keefer's Angelfish"] = "Kiefers Engelfisch",
	["Dezian Queenfish"] = "Dezianischer Königinnenfisch",
	["Brownell's Blue Striped Racer"] = "Braunells blaugestreifter Flitzerfisch",
-- Normal Fish
	["Stonescale Eel"] = "Steinschuppenaal",
	["Oily Blackmouth"] = "Öliges Schwarzmaul",
	["Firefin Snapper"] = "Feuerflossenschnapper",
--["Oil Covered Fish"] = ,
	["Sickly Looking Fish"] = "Krank aussehender Fisch",
	["Raw Brilliant Smallfish"] = "Roher glänzender Kleinfisch",
	["Raw Bristle Whisker Catfish"] = "Roher Stoppelfühlerwels",
	["Raw Glossy Mightfish"] = "Roher glänzender Machtfisch",
	["Raw Greater Sagefish"] = "Roher großer Weisenfisch",
	["Raw Loch Frenzy"] = "Roher Lochfrenzy",
	["Raw Longjaw Mud Snapper"] = "Roher langzahniger Matschschnapper",
	["Raw Mithril Head Trout"] = "Rohe Mithrilkopfforelle",
	["Raw Nightfin Snapper"] = "Roher Nachtflossenschnapper",
	["Raw Rainbow Fin Albacore"] = "Roher Regenbogenflossenthunfisch",
	["Raw Redgill"] = "Roher Regenbogenflossenthunfisch",
	["Raw Rockscale Cod"] = "Roher Steinschuppenkabeljau",
	["Raw Sagefish"] = "Roher Weisenfisch",
	["Raw Slitherskin Mackerel"] = "Rohe Glitschhautmakrele",
	["Raw Spotted Yellowtail"] = "Roher Tüpfelgelbschwanz",
	["Raw Summer Bass"] = "Roher Sommerbarsch",
	["Raw Whitescale Salmon"] = "Roher Weißschuppenlachs",
	["Raw Sunscale Salmon"] = "Roher Sonnenschuppenlachs",
	["Darkclaw Lobster"] = "Dunkelklauenhummer",
	["Deviate Fish"] = "Deviatfisch",
	["Large Raw Mightfish"] = "Großer roher Machtfisch",
	["Winter Squid"] = "Winterkalmar",
	["Felblood Snapper"] = "Teufelsblutschnapper",
	["Figluster's Mudfish"] = "Feigenschimmers Matschflosser",
	["Furious Crawdad"] = "Grimmiger Flusskrebs",
	["Golden Darter"] = "Goldener Stachelflosser",
	["Icefin Bluefish"] = "Eisblauflosse",
	["Spotted Feltail"] = "Tüpfelteufelsfinne",
	["Zangarian Sporefish"] = "Zangarischer Sporenfisch",
	["Goldenscale Vendorfish"] = "Goldschuppenfisch",
	["Crescent-Tail Skullfish"] = "Mondschädelfisch",
	["Bloodfin Catfish"] = "Blutflossenwels",
}
end)

BabbleFish:RegisterTranslations("frFR", function() return {
-- Fishing Node
	["Floating Wreckage"] = "Débris flottants",
	["Patch of Elemental Water"] = "Remous d'eau élémentaire",
	["Floating Debris"] = "Débris flottant",
	["Oil Spill"] = "Nappe de pétrole",
	["Firefin Snapper School"] = "Banc de lutjans de nagefeu",
	["Greater Sagefish School"] = "Banc de grandes sagerelles",
	["Oily Blackmouth School"] = "Banc de bouches-noires huileux",
	["Sagefish School"] = "Banc de sagerelles",
	["School of Deviate Fish"] = "Banc de poissons déviants",
	["Stonescale Eel Swarm"] = "Banc d'anguilles pierre-écaille",
	["Muddy Churning Water"] = "Eaux troubles et agitées",
	["Highland Mixed School"] = "Banc mixte des Hautes-terres",
	["Pure Water"] = "Eau pure",
	["Bluefish School"] = "Banc de tassergals",
	["Feltail School"] = "Banc de gangre-queues",
	["Mudfish School"] = "Banc de poissons-boues",
	["School of Darter"] = "Banc de dards",
	["Sporefish School"] = "Banc de poissons-spores",
	["Steam Pump Flotsam"] = "Détritus de la pompe à vapeur",
	["School of Tastyfish"] = "Banc de courbine",
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = "Frappeur Sar'theris",
	["Savage Coast Blue Sailfin"] = "Sailfin bleu de la Côte sauvage",
	["Misty Reed Mahi Mahi"] = "Mahi Mahi de Brumejonc",
	["Feralas Ahi"] = "Ahi de Féralas",
	["Spotted Sunfish"] = "Poisson-lune",
	["Lightning Eel"] = "Anguille électrique",
--["Oil Covered Fish"] = true,
	["Plated Armorfish"] = "Poisson cuirassé",
	["Darkshore Grouper"] = "Mérou de Sombrivage",
	["Electropeller"] = "Electropeller",
	["Gaffer Jack"] = "Rouage électrique",
	["Speckled Tastyfish"] = "Courbine",
	["Keefer's Angelfish"] = "Scalaire de Keefer",
	["Dezian Queenfish"] = "Talang dezien",
	["Brownell's Blue Striped Racer"] = "Tassergal à dos rayé",
-- Normal Fish
	["Stonescale Eel"] = "Anguille pierre-écaille",
	["Oily Blackmouth"] = "Bouche-noire huileux",
	["Firefin Snapper"] = "Lutjan de nagefeu",
	["Oil Covered Fish"] = "Poisson huileux",
	["Sickly Looking Fish"] = "Poisson maladif",
	["Raw Brilliant Smallfish"] = "Goujon brillant cru",
	["Raw Bristle Whisker Catfish"] = "Poisson-chat moustachu cru",
	["Raw Glossy Mightfish"] = "Barracuda luisant cru",
	["Raw Greater Sagefish"] = "Grande sagerelle crue",
	["Raw Loch Frenzy"] = "Furie du loch crue",
	["Raw Longjaw Mud Snapper"] = "Lutjan à longue mâchoire cru",
	["Raw Mithril Head Trout"] = "Truite tête-mithril crue",
	["Raw Nightfin Snapper"] = "Lutjan nagenuit cru",
	["Raw Rainbow Fin Albacore"] = "Thon arc-en-ciel cru",
	["Raw Redgill"] = "Rouget cru",
	["Raw Rockscale Cod"] = "Morue rochécaille crue",
	["Raw Sagefish"] = "Sagerelle crue",
	["Raw Slitherskin Mackerel"] = "Maquereau ombré cru",
	["Raw Spotted Yellowtail"] = "Jaune-queue tacheté cru",
	["Raw Summer Bass"] = "Perche estivale crue",
	["Raw Sunscale Salmon"] = "Saumon solécaille cru",
	["Raw Whitescale Salmon"] = "Saumon Blanchécaille cru",
	["Darkclaw Lobster"] = "Homard Pince-noire",
	["Deviate Fish"] = "Poisson déviant",
	["Large Raw Mightfish"] = "Grand barracuda cru",
	["Winter Squid"] = "Calmar hivernal",
	["Felblood Snapper"] = "Lutjan gangresang",
	["Figluster's Mudfish"] = "Ablette de Figluster",
	["Furious Crawdad"] = "Ecrevisse furieuse",
	["Golden Darter"] = "Dard doré",
	["Icefin Bluefish"] = "Tassergal nageglace",
	["Spotted Feltail"] = "Gangre-queue tacheté",
	["Zangarian Sporefish"] = "Poisson-spore zangarien",
	["Goldenscale Vendorfish"] = "Poisson orécaille",
	["Crescent-Tail Skullfish"] = "Poisson-crâne à queue en croissant",
	["Bloodfin Catfish"] = "Poisson-chat aileron-de-sang",
}
end)

BabbleFish:RegisterTranslations("esES", function() return {
-- Fishing Node
	["Floating Wreckage"] = "Restos de un naufragio",  
	["Patch of Elemental Water"] = "Patch of Elemental Water",   -- fix
	["Floating Debris"] = "Restos flotando",   
	["Oil Spill"] = "Vertido de petr\195\179leo", 
	["Firefin Snapper School"] = "Banco de pargos de fuego",
	["Greater Sagefish School"] = "Banco de sabiolas superiores",
	["Oily Blackmouth School"] = "banco de bocanegra graso",
	["Sagefish School"] = "Banco de sabiolas",
	["School of Deviate Fish"] = "Banco de peces descarriados",
	["Stonescale Eel Swarm"] = "Banco de anguilas Escama Tormentosa",
	["Muddy Churning Water"] = "Muddy Churning Water",  -- fix
	["Highland Mixed School"] = "Banco mezclado de las Tierras Altas",  -- check  
	["Pure Water"] = "Agua pura",
	["Bluefish School"] = "Banco de pezazules",  
	["Feltail School"] = "Banco de colaviles",
	["Mudfish School"] = "Banco de peces barro",  
	["School of Darter"] = "Banco de dardos", -- check
	["Sporefish School"] = "Sporefish School",  -- fix
	["Steam Pump Flotsam"] = "Restos flotantes de bomba de vapor",
	["School of Tastyfish"] = "Banco de pezricos",
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = "Golpeador Sar'theris",
	["Savage Coast Blue Sailfin"] = "Latipinia azul de La Costa Salvaje",  
	["Misty Reed Mahi Mahi"] = "Mahi mahi de Juncobruma",
	["Feralas Ahi"] = "Ahi de Feralas", 
	["Spotted Sunfish"] = "Pez luna moteado",
	["Lightning Eel"] = "Anguila rel\195\161mpago",
--["Oil Covered Fish"] = true,
	["Plated Armorfish"] = "Pez coraza de placas",
	["Darkshore Grouper"] = "Mero de Costa Oscura",
	["Electropeller"] = "Electromuelle",
	["Gaffer Jack"] = "Mecanismo el\195\169ctrico",
	["Speckled Tastyfish"] = "Pezrico moteado",
	["Keefer's Angelfish"] = "Pez \195\161ngel de Keefer",
	["Dezian Queenfish"] = "Pez reina de Dezian",
	["Brownell's Blue Striped Racer"] = "Corredor a rayas azules de Brownell",
-- Normal Fish
	["Stonescale Eel"] = "Anguila escama tormentosa",
	["Oily Blackmouth"] = "Bocanegra graso",
	["Firefin Snapper"] = "Pargo de Fuego",
	["Oil Covered Fish"] = "Pescado cubierto de aceite",
	["Sickly Looking Fish"] = "Pescado con mala pinta",
	["Raw Brilliant Smallfish"] = "Pececito luminoso crudo",
	["Raw Bristle Whisker Catfish"] = "Siluro mostacherizo crudo",
	["Raw Glossy Mightfish"] = "Vigorpez lustroso crudo",
	["Raw Greater Sagefish"] = "Sabiola cruda superior",
	["Raw Loch Frenzy"] = "Frenes\195\173 del lago crudo",
	["Raw Longjaw Mud Snapper"] = "Pargo de lodo boquilargo crudo",
	["Raw Mithril Head Trout"] = "Trucha cabeza de mitril cruda",
	["Raw Nightfin Snapper"] = "Pargo nocturno crudo",
	["Raw Rainbow Fin Albacore"] = "At\195\186n blanco arco iris crudo",
	["Raw Redgill"] = "Branquirrojo crudo",
	["Raw Rockscale Cod"] = "Bacalao Piedrescama crudo",
	["Raw Sagefish"] = "Sabiola cruda",
	["Raw Slitherskin Mackerel"] = "Caballa suave cruda",
	["Raw Spotted Yellowtail"] = "Serviola moteada cruda",
	["Raw Summer Bass"] = "Lubina cruda",
	["Raw Sunscale Salmon"] = "Salm\195\179n escama de sol crudo",
	["Raw Whitescale Salmon"] = "Salm\195\179n escama blanca crudo",
	["Darkclaw Lobster"] = "Langosta pinza oscura",
	["Deviate Fish"] = "Pez descarriado",
	["Large Raw Mightfish"] = "Vigorpez crudo grande",
	["Winter Squid"] = "Calamar de invierno",
	["Felblood Snapper"] = "Pargo de sangre vil",  
	["Figluster's Mudfish"] = "Pezfango de Figluster",
	["Furious Crawdad"] = "Cigala furiosa",
	["Golden Darter"] = "Dardo dorado", 
	["Icefin Bluefish"] = "Pezazul de aleta healda",   
	["Spotted Feltail"] = "Colavil con manchas",
	["Zangarian Sporefish"] = "Pecespora de Zangar",
	["Goldenscale Vendorfish"] = "Pez de escamas doradas", 
	["Crescent-Tail Skullfish"] = "Crescent-Tail Skullfish", -- needs translation
	["Bloodfin Catfish"] = "Bloodfin Catfish", -- needs translation
}
end)

BabbleFish:RegisterTranslations("zhCN", function() return {
-- Fishing Node
	["Floating Wreckage"] = "漂浮的残骸",
	["Patch of Elemental Water"] = "元素之水",
	["Floating Debris"] = "漂浮的碎片",
	["Oil Spill"] = "油井",
	["Firefin Snapper School"] = "火鳞鳝鱼群",
	["Greater Sagefish School"] = "大型鼠尾鱼群",
	["Oily Blackmouth School"] = "黑口鱼群",
	["Sagefish School"] = "鼠尾鱼群",
	["School of Deviate Fish"] = "变异鱼群",
	["Stonescale Eel Swarm"] = "石鳞鳗群",
	["Muddy Churning Water"] = "混浊的水",	
	["Highland Mixed School"] = "高地杂鱼群", --add
	["Pure Water"] = "纯水",            
	["Bluefish School"] = "蓝鱼群",
	["Feltail School"] = "魔尾鱼群", 
	["Mudfish School"] = "泥鱼群", 
	["School of Darter"] = "金镖鱼群", 
	["Sporefish School"] = "孢子鱼群",  
	["Steam Pump Flotsam"] = "蒸汽泵废料",
	["School of Tastyfish"] = "可口鱼",
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = "萨瑟里斯虎鱼",
	["Savage Coast Blue Sailfin"] = "野人海岸蓝色叉牙鱼",
	["Misty Reed Mahi Mahi"] = "芦苇海岸大马哈鱼",
	["Feralas Ahi"] = "菲拉斯草鱼",
	["Spotted Sunfish"] = "斑点太阳鱼",
	["Lightning Eel"] = "电鳗",
	["Oil Covered Fish"] = "滑腻的鱼",
	["Plated Armorfish"] = "板鳞鱼",
	["Darkshore Grouper"] = "黑海岸石斑鱼",
	["Electropeller"] = "导电器",
	["Gaffer Jack"] = "小齿轮",
	["Speckled Tastyfish"] = "斑点可口鱼",
	["Keefer's Angelfish"] = "基佛天使鱼",
	["Dezian Queenfish"] = "迪森皇后鱼",
	["Brownell's Blue Striped Racer"] = "布隆奈尔蓝斑鱼",
-- Normal Fish
	["Stonescale Eel"] = "石鳞鳗",
	["Oily Blackmouth"] = "黑口鱼",
	["Firefin Snapper"] = "火鳞鳝鱼",
	["Oil Covered Fish"] = "滑腻的鱼",
	["Sickly Looking Fish"] = "病怏怏的鱼",
	["Raw Brilliant Smallfish"] = "新鲜的美味小鱼",
	["Raw Bristle Whisker Catfish"] = "新鲜的刺须鲶鱼",
	["Raw Glossy Mightfish"] = "新鲜的光滑大鱼",
	["Raw Greater Sagefish"] = "新鲜的大鼠尾鱼",
	["Raw Loch Frenzy"] = "新鲜的洛克湖狂鱼",
	["Raw Longjaw Mud Snapper"] = "新鲜的长嘴泥鳅",
	["Raw Mithril Head Trout"] = "新鲜的银头鲑鱼",
	["Raw Nightfin Snapper"] = "新鲜的夜鳞鲷鱼",
	["Raw Rainbow Fin Albacore"] = "新鲜的彩鳍鱼",
	["Raw Redgill"] = "新鲜的红腮鱼",
	["Raw Rockscale Cod"] = "新鲜的石鳞鳕鱼",
	["Raw Sagefish"] = "新鲜的鼠尾鱼",
	["Raw Slitherskin Mackerel"] = "新鲜的滑皮鲭鱼",
	["Raw Spotted Yellowtail"] = "新鲜的斑点黄尾鱼",
	["Raw Summer Bass"] = "新鲜的夏日鲈鱼",
	["Raw Sunscale Salmon"] = "新鲜的阳鳞鲑鱼",
	["Raw Whitescale Salmon"] = "新鲜的白鳞鲑鱼",
	["Darkclaw Lobster"] = "黑爪龙虾",
	["Deviate Fish"] = "变异鱼",
	["Large Raw Mightfish"] = "新鲜的大鱼",
	["Winter Squid"] = "冬鱿鱼",
	["Felblood Snapper"] = "邪血钳鱼",
	["Figluster's Mudfish"] = "菲格鲁泥鱼",
	["Furious Crawdad"] = "狂暴龙虾",
	["Golden Darter"] = "金镖鱼",
	["Icefin Bluefish"] = "冰鳞蓝鱼",
	["Spotted Feltail"] = "斑点魔尾鱼",
	["Zangarian Sporefish"] = "赞加孢子鱼",
	["Goldenscale Vendorfish"] = "金鳞卖店鱼",
	["Crescent-Tail Skullfish"] = "弯尾骨鱼",  --thanks to rochuang@wowtigu.org
	["Bloodfin Catfish"] = "血鳞鲶鱼",  --thanks to rochuang@wowtigu.org
}
end)

BabbleFish:RegisterTranslations("zhTW", function() return {
-- Fishing Node
	["Floating Wreckage"] = "漂浮的殘骸",
	["Patch of Elemental Water"] = "元素之水",
	["Floating Debris"] = "漂浮的碎片",
	["Oil Spill"] = "油井",
	["Firefin Snapper School"] = "火鰭鯛魚群",
	["Greater Sagefish School"] = "大型鼠尾魚魚群",
	["Oily Blackmouth School"] = "黑口魚魚群",
	["Sagefish School"] = "鼠尾魚魚群",
	["School of Deviate Fish"] = "變異魚魚群",
	["Stonescale Eel Swarm"] = "石鱗鰻魚群",
	["Muddy Churning Water"] = "混濁的水",
	["Highland Mixed School"] = "高地綜合魚群",  
	["Pure Water"] = "純水",            
	["Bluefish School"] = "藍魚群",
	["Feltail School"] = "魔尾魚群", 
	["Mudfish School"] = "泥鰍群", 
	["School of Darter"] = "淡水魚群", 
	["Sporefish School"] = "孢子魚群",  
	["Steam Pump Flotsam"] = "蒸汽幫浦漂浮殘骸", 
	["School of Tastyfish"] = "斑點可口魚魚群",
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = "薩瑟里斯虎魚",
	["Savage Coast Blue Sailfin"] = "野人海岸藍色叉牙魚",
	["Misty Reed Mahi Mahi"] = "蘆葦海岸大馬哈魚",
	["Feralas Ahi"] = "菲拉斯草魚",
	["Spotted Sunfish"] = "斑點太陽魚",
	["Lightning Eel"] = "電鰻",
--["Oil Covered Fish"] = "滑膩的魚",
	["Plated Armorfish"] = "板鱗魚",
	["Darkshore Grouper"] = "黑海岸石斑魚",
	["Electropeller"] = "導電器",
	["Gaffer Jack"] = "小齒輪",
	["Speckled Tastyfish"] = "斑點可口魚",
	["Keefer's Angelfish"] = "基佛天使魚",
	["Dezian Queenfish"] = "迪森皇后魚",
	["Brownell's Blue Striped Racer"] = "布隆奈爾藍斑魚",
-- Normal Fish
	["Stonescale Eel"] = "石鱗鰻",
	["Oily Blackmouth"] = "黑口魚",
	["Firefin Snapper"] = "火鰭鯛",
	["Oil Covered Fish"] = "滑膩的魚",
	["Sickly Looking Fish"] = "病怏怏的魚",
	["Raw Brilliant Smallfish"] = "新鮮的美味小魚",
	["Raw Bristle Whisker Catfish"] = "新鮮的刺鬚鯰魚",
	["Raw Glossy Mightfish"] = "新鮮的光滑大魚",
	["Raw Greater Sagefish"] = "新鮮的大鼠尾魚",
	["Raw Loch Frenzy"] = "新鮮的洛克湖狂魚",
	["Raw Longjaw Mud Snapper"] = "新鮮的長嘴泥鰍",
	["Raw Mithril Head Trout"] = "新鮮的銀頭鮭魚",
	["Raw Nightfin Snapper"] = "新鮮的夜鱗鯛魚",
	["Raw Rainbow Fin Albacore"] = "新鮮的彩鰭魚",
	["Raw Redgill"] = "新鮮的紅腮魚",
	["Raw Rockscale Cod"] = "新鮮的石鱗鱈魚",
	["Raw Sagefish"] = "新鮮的鼠尾魚",
	["Raw Slitherskin Mackerel"] = "新鮮的滑皮鯖魚",
	["Raw Spotted Yellowtail"] = "新鮮的斑點黃尾魚",
	["Raw Summer Bass"] = "新鮮的夏日鱸魚",
	["Raw Sunscale Salmon"] = "新鮮的陽鱗鮭魚",
	["Raw Whitescale Salmon"] = "新鮮的白鱗鮭魚",
	["Darkclaw Lobster"] = "黑爪龍蝦",
	["Deviate Fish"] = "變異魚",
	["Large Raw Mightfish"] = "新鮮的大魚",
	["Winter Squid"] = "冬魷魚",
	["Felblood Snapper"] = "惡魔血鯛魚",
	["Figluster's Mudfish"] = "微光泥鰍",
	["Furious Crawdad"] = "狂暴小龍蝦",
	["Golden Darter"] = "金色淡水小魚",
	["Icefin Bluefish"] = "冰鰭藍魚",
	["Spotted Feltail"] = "斑點魔尾",
	["Zangarian Sporefish"] = "贊格里安孢子魚",
	["Goldenscale Vendorfish"] = "金鱗小販魚",
	["Crescent-Tail Skullfish"] = "月尾鯨",
	["Bloodfin Catfish"] = "血鰭鯰魚",
}
end)
-- Translator: sadsmile (Updater: StingerSoft)
BabbleFish:RegisterTranslations("ruRU", function() return {
-- Fishing Node
	["Floating Wreckage"] = "Плавающие обломки",
	["Patch of Elemental Water"] = "Patch of Elemental Water",
	["Floating Debris"] = "Floating Debris",
	["Oil Spill"] = "Oil Spill",
	["Firefin Snapper School"] = "Косяк огнеперого снеппера",
	["Greater Sagefish School"] = "Большой косяк шалфокуня",
	["Oily Blackmouth School"] = "Косяк масляного черноротика",
	["Sagefish School"] = "Косяк шалфокуня",
	["School of Deviate Fish"] = "Косяк искаженной рыба",
	["Stonescale Eel Swarm"] = "Stonescale Eel Swarm",
	["Muddy Churning Water"] = "Muddy Churning Water",
	["Highland Mixed School"] = "Highland Mixed School",
	["Pure Water"] = "Чистая вода",
	["Bluefish School"] = "Косяк луфаря",
	["Feltail School"] = "Косяк сквернохвоста",
	["Mudfish School"] = "Косяк ильной рыбы",
	["School of Darter"] = "Косяк змеешейки",
	["Sporefish School"] = "Косяк спорорыбы",
	["Steam Pump Flotsam"] = "Steam Pump Flotsam",
	["School of Tastyfish"] = "Косяк вкуснорыбы",
-- Quest Fish + Fished Loot for Quests
	["Sar'theris Striker"] = "Ударник Сартериса",
	["Savage Coast Blue Sailfin"] = "Синий плавник Дикого Берега",
	["Misty Reed Mahi Mahi"] = "Махи-махи с берега Туманных Тростников",
	["Feralas Ahi"] = "Фералас-ахи",
	["Spotted Sunfish"] = "Пятнистая рыба-луна",
	["Lightning Eel"] = "Молниевый угорь",
	["Oil Covered Fish"] = "Рыба в масле",
	["Plated Armorfish"] = "Латная бронерыба",
	["Darkshore Grouper"] = "Окунь с Темного берега",
	["Electropeller"] = "Электропеллер",
	["Gaffer Jack"] = "Суперразъем",
	["Speckled Tastyfish"] = "Крапчатая вкуснорыба",
	["Keefer's Angelfish"] = "Рыба-ангел Кифера",
	["Dezian Queenfish"] = "Дезийская ставрида",
	["Brownell's Blue Striped Racer"] = "Синий полосатик Браунелла",
-- Normal Fish
	["Stonescale Eel"] = "Каменный угорь",
	["Oily Blackmouth"] = "Масляный черноротик",
	["Firefin Snapper"] = "Огнеперый снеппер",
	["Oil Covered Fish"] = "Рыба в масле",
	["Sickly Looking Fish"] = "Хилая рыбка",
	["Raw Brilliant Smallfish"] = "Сырая блестящая рыбка",
	["Raw Bristle Whisker Catfish"] = "Сырая зубатка ощетиненная",
	["Raw Glossy Mightfish"] = "Сырая блестящая мощь-рыба",
	["Raw Greater Sagefish"] = "Сырой большой шалфокунь",
	["Raw Loch Frenzy"] = "Сырой деликатес из бешенки",
	["Raw Longjaw Mud Snapper"] = "Сырой илистый луциан",
	["Raw Mithril Head Trout"] = "Сырая мифрилоголовая форель",
	["Raw Nightfin Snapper"] = "Сырой черноперый луциан",
	["Raw Rainbow Fin Albacore"] = "Сырой радужный тунец",
	["Raw Redgill"] = "Сырая краснобородка",
	["Raw Rockscale Cod"] = "Сырая каменношкурая треска",
	["Raw Sagefish"] = "Сырой шалфокунь",
	["Raw Slitherskin Mackerel"] = "Сырая скользкая скумбрия",
	["Raw Spotted Yellowtail"] = "Сырой пятнистый желохвост",
	["Raw Summer Bass"] = "Сырой летний окунь",
	["Raw Sunscale Salmon"] = "Сырой радужный лосось",
	["Raw Whitescale Salmon"] = "Сырой белочешуйный лосось",
	["Darkclaw Lobster"] = "Темноклешневый омар",
	["Deviate Fish"] = "Искаженная рыба",
	["Large Raw Mightfish"] = "Сырая мощь-рыба",
	["Winter Squid"] = "Зимний кальмар",
	["Felblood Snapper"] = "Сквернокровный луциан",
	["Figluster's Mudfish"] = "Ильная рыба Фиглюстера",
	["Furious Crawdad"] = "Разъяренный речной рак",
	["Golden Darter"] = "Золотая змеешейка",
	["Icefin Bluefish"] = "Ледоперый луфарь",
	["Spotted Feltail"] = "Пятнистый сквернохвост",
	["Zangarian Sporefish"] = "Зангарская спорорыба",
	["Goldenscale Vendorfish"] = "Золотая рыбка-монетка",
	["Crescent-Tail Skullfish"] = "Серпохвостая рыба-череп",
	["Bloodfin Catfish"] = "Зубатка афиохаракс",
}
end)

BabbleFish:Debug()
BabbleFish:SetStrictness(true)

AceLibrary:Register(BabbleFish, MAJOR_VERSION, MINOR_VERSION)
BabbleFish = nil
