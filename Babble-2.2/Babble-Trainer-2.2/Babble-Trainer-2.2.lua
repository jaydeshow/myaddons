﻿--[[
Name: Babble-Trainer-2.2
Revision: $Rev: 73267 $
Authors(s): Kodewulf (kodewulf@gmail.com)
Website: www.wowace.com
Documentation: http://www.wowace.com/wiki/Babble-Trainer-2.2
Dependencies: AceLibrary, AceLocale-2.2
License: MIT
]]

local MAJOR_VERSION = "Babble-Trainer-2.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 73267 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:HasInstance("AceLocale-2.2") then error(MAJOR_VERSION .. " requires AceLocale-2.2") end

local _, x = AceLibrary("AceLocale-2.2"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleTrainer = AceLibrary("AceLocale-2.2"):new(MAJOR_VERSION)

BabbleTrainer:RegisterTranslations("enUS", function() return {
	-- Trainer types
	["Armor Crafter"] = true,
	["Artisan Alchemist"] = true,
	["Artisan Blacksmith"] = true,
	["Artisan Enchanter"] = true,
	["Artisan Engineer"] = true,
	["Artisan Leatherworker"] = true,
	["Artisan Tailor"] = true,
	["Bael'dun Chief Engineer"] = true,
	["Bat Handler"] = true,
	["Blacksmith"] = true,
	["Chief Engineer"] = true,
	["Cooking Trainer"] = true,
	["Demon Trainer"] = true,
	["Druid Trainer"] = true,
	["Engineer"] = true,
	["Engineering Trainer"] = true,
	["Expert Alchemist"] = true,
	["Expert Blacksmith"] = true,
	["Expert Enchanter"] = true,
	["Expert Engineer"] = true,
	["Expert Jewelcrafter"] = true,
	["Expert Leatherworker"] = true,
	["Expert Tailor"] = true,
	["Explorers' League"] = true,
	["First Aid Trainer"] = true,
	["Fishing Trainer"] = true,
	["Goblin Engineering Trainer"] = true,
	["Grand Master Alchemist"] = true,
	["Grand Master Blacksmith"] = true,
	["Grand Master Enchanter"] = true,
	["Grand Master Engineer"] = true,
	["Grand Master Jewelcrafter"] = true,
	["Grand Master Leatherworker"] = true,
	["Grand Master Skinner"] = true,
	["Grand Master Tailor"] = true,
	["Head Eco-Dome Engineer"] = true,
	["Herbalism Trainer"] = true,
	["Horse Riding Instructor"] = true,
	["Hunter Trainer"] = true,
	["Journeyman Alchemist"] = true,
	["Journeyman Alchemist Trainer"] = true,
	["Journeyman Blacksmith"] = true,
	["Journeyman Enchanter"] = true,
	["Journeyman Engineer"] = true,
	["Journeyman Jewelcrafter"] = true,
	["Journeyman Leatherworker"] = true,
	["Journeyman Tailor"] = true,
	["Kodo Riding Instructor"] = true,
	["Leatherworking Trainer"] = true,
	["Mage Trainer"] = true,
	["Master Alchemist"] = true,
	["Master Blacksmith"] = true,
	["Master Dragonscale Leatherworker"] = true,
	["Master Elemental Leatherworker"] = true,
	["Master Enchanter"] = true,
	["Master Engineer"] = true,
	["Master Gnome Engineer"] = true,
	["Master Goblin Engineer"] = true,
	["Master Jewelcrafter"] = true,
	["Master Leatherworker"] = true,
	["Master Leatherworking Trainer"] = true,
	["Master Shadoweave Tailor"] = true,
	["Master Tailor"] = true,
	["Master Tribal Leatherworker"] = true,
	["Mining Trainer"] = true,
	["Nightsaber Riding Instructor"] = true,
	["Owl Trainer"] = true,
	["Paladin Trainer"] = true,
	["Pet Trainer"] = true,
	["Portal Trainer"] = true,
	["Priest Trainer"] = true,
	["Ram Riding Instructor"] = true,
	["Raptor Handler"] = true,
	["Raptor Riding Trainer"] = true,
	["Riding Instructor"] = true,
	["Rogue Trainer"] = true,
	["Royal Apothecary Society"] = true,
	["Saber Handler"] = true,
	["Shaman Trainer"] = true,
	["Skinner"] = true,
	["Skinning Trainer"] = true,
	["Speciality Engineer"] = true,
	["Superior Leatherworker"] = true,
	["Transportation Engineer"] = true,
	["Trauma Surgeon"] = true,
	["Tribal Leatherworking Trainer"] = true,
	["Unbalanced Engineer"] = true,
	["Undead Horse Riding Instructor"] = true,
	["Warlock Trainer"] = true,
	["Warrior Trainer"] = true,
	["Weapon Master"] = true,
	["Wolf Riding Instructor"] = true,
} end)

BabbleTrainer:RegisterTranslations("deDE", function() return {
   -- Trainer types
   ["Artisan Alchemist"] = "Alchimiefachmann",
   ["Artisan Blacksmith"] = "Schmiedekunstfachmann",
   ["Artisan Enchanter"] = "Verzauberkunstfachmann",
   ["Artisan Engineer"] = "Ingenieurfachmann",
   ["Artisan Leatherworker"] = "Lederverarbeitungsfachmann",
   ["Artisan Tailor"] = "Schneiderfachmann",
   ["Bael'dun Chief Engineer"] = "Bael'duns Chefingenieur",
   ["Bat Handler"] = "Fledermausf\195\188hrer",
   ["Blacksmith"] = "Schmied",
   ["Chief Engineer"] = "Chefingenieur",
   ["Cooking Trainer"] = "Kochkunstlehrer",
   ["Demon Trainer"] = "D\195\164monenausbilder",
   ["Druid Trainer"] = "Druidenlehrer",
   ["Engineer"] = "Ingenieur",
   ["Expert Alchemist"] = "Alchimieexperte",
   ["Expert Blacksmith"] = "Schmiedekunstexperte",
   ["Expert Enchanter"] = "Verzauberkunstexperte",
   ["Expert Engineer"] = "Ingenieursexperte",
   ["Expert Leatherworker"] = "Lederverarbeitungsexperte",
   ["Expert Tailor"] = "Schneiderexperte",
   ["Explorers' League"] = "Forscherliga",
   ["First Aid Trainer"] = "Lehrer f\195\188r Erste Hilfe",
   ["Fishing Trainer"] = "Angellehrer",
   ["Grand Master Alchemist"] = "Alchimiegro\195\159meister",
   ["Grand Master Blacksmith"] = "Gro\195\159meisterschmied",
   ["Grand Master Enchanter"] = "Verzauberkunstgro\195\159meister",
   ["Grand Master Engineer"] = "Gro\195\159meisteringenieur",
   ["Grand Master Jewelcrafter"] = "Juwelenschleifergro\195\159meister",
   ["Grand Master Leatherworker"] = "Lederverarbeitungsgro\195\159meister",
   ["Grand Master Tailor"] = "Schneidergro\195\159meister",
   ["Head Eco-Dome Engineer"] = "Leitender Ingenieur der Biokuppel",
   ["Herbalism Trainer"] = "Kr\195\164uterkundelehrer",
   ["Horse Riding Instructor"] = "Pferdereitlehrer",
   ["Hunter Trainer"] = "J\195\164gerlehrer",
   ["Journeyman Alchemist"] = "Alchimiegeselle",
   ["Journeyman Alchemist Trainer"] = "Alchimiegesellenlehrer",
   ["Journeyman Blacksmith"] = "Schmiedekunstgeselle",
   ["Journeyman Enchanter"] = "Verzauberkunstgeselle",
   ["Journeyman Engineer"] = "Ingenieursgeselle",
   ["Journeyman Jewelcrafter"] = "Juwelenschleifergeselle",
   ["Journeyman Leatherworker"] = "Lederverarbeitungsgeselle",
   ["Journeyman Tailor"] = "Schneidergeselle",
   ["Kodo Riding Instructor"] = "Kodoreitlehrer",
   ["Leatherworking Trainer"] = "Lederverarbeitungslehrer",
   ["Mage Trainer"] = "Magielehrer",
   ["Master Alchemist"] = "Alchimiemeister",
   ["Master Blacksmith"] = "Meisterschmied",
   ["Master Dragonscale Leatherworker"] = "Drachenlederverarbeitungsmeister",
   ["Master Elemental Leatherworker"] = "Elementarlederverarbeitungsmeister",
   ["Master Enchanter"] = "Verzauberkunstmeister",
   ["Master Engineer"] = "Meisteringenieur",
   ["Master Gnome Engineer"] = "Gnomischer Meisteringenieur",
   ["Master Goblin Engineer"] = "Goblinmeisteringenieur",
   ["Master Jewelcrafter"] = "Juwelenschleifermeister",
   ["Master Leatherworker"] = "Lederverarbeitungsmeister",
   ["Master Leatherworking Trainer"] = "Lederverarbeitungsmeisterlehrer",
   ["Master Shadoweave Tailor"] = "Schattengewebeschneidermeister",
   ["Master Tailor"] = "Schneidermeister",
   ["Master Tribal Leatherworker"] = "Stammeslederverarbeitungsmeister",
   ["Mining Trainer"] = "Bergbaulehrer",
   ["Nightsaber Riding Instructor"] = "Nachtsäblerreitlehrer",
   ["Owl Trainer"] = "Eulenausbilder",
   ["Paladin Trainer"] = "Paladinlehrer",
   ["Pet Trainer"] = "Tierausbilder",
   ["Portal Trainer"] = "Portallehrer",
   ["Priest Trainer"] = "Priesterlehrer",
   ["Ram Riding Instructor"] = "Widderreitlehrer",
   ["Raptor Handler"] = "Raptorf\195\188hrer",
   ["Raptor Riding Trainer"] = "Raptorreitlehrer",
   ["Riding Instructor"] = "Reitlehrer",
   ["Rogue Trainer"] = "Schurkenlehrer",
   ["Royal Apothecary Society"] = "K\195\182nigliche Apothekervereinigung",
   ["Saber Handler"] = "S\195\164belf\195\188hrer",
   ["Shaman Trainer"] = "Schamanenlehrer",
   ["Skinning Trainer"] = "K\195\188rschnerlehrer",
   ["Speciality Engineer"] = "Spezialingenieur",
   ["Superior Leatherworker"] = "\195\156berragender Lederer",
   ["Transportation Engineer"] = "Transportingenieur",
   ["Trauma Surgeon"] = "Traumachirurg",
   ["Tribal Leatherworking Trainer"] = "Stammeslederverarbeitungslehrer",
   ["Unbalanced Engineer"] = "Unausgeglichener Ingenieur",
   ["Undead Horse Riding Instructor"] = "Untote Pferdereitlehrer",
   ["Warlock Trainer"] = "Hexenmeisterlehrer",
   ["Warrior Trainer"] = "Kriegerlehrer",
   ["Weapon Master"] = "Waffenmeister",
   ["Wolf Riding Instructor"] = "Wolfreitlehrer",
} end)

BabbleTrainer:RegisterTranslations("frFR", function() return {
	-- Trainer types
	["Artisan Alchemist"] = "Alchimiste - Artisan",
	["Artisan Blacksmith"] = "Forgeron - Artisan",
	["Artisan Enchanter"] = "Enchanteur - Artisan",
	["Artisan Engineer"] = "Ingénieur - Artisan",
	["Artisan Leatherworker"] = "Artisan du cuir - Artisan",
	["Artisan Tailor"] = "Tailleur - Artisan",
	["Bael'dun Chief Engineer"] = "Ingénieur en chef de Bael'dun",
	["Bat Handler"] = "Éleveur de chauve-souris",
	["Blacksmith"] = "Forgeron",
	["Chief Engineer"] = "Ingénieur en chef",
	["Cooking Trainer"] = "Maître des cuisiniers",
	["Demon Trainer"] = "Maître des démons",
	["Druid Trainer"] = "Maître des druides",
	["Engineer"] = "Ingénieur",
	["Expert Alchemist"] = "Alchimiste - Expert",
	["Expert Blacksmith"] = "Forgeron - Expert",
	["Expert Enchanter"] = "Enchanteur - Expert",
	["Expert Engineer"] = "Ingénieur - Expert",
	["Expert Leatherworker"] = "Artisan du cuir - Expert",
	["Expert Tailor"] = "Tailleur - Expert",
	["Explorers' League"] = "Ligue des explorateurs",
	["First Aid Trainer"] = "Maître des premiers soins",
	["Fishing Trainer"] = "Maître des pêcheurs",
	["Grand Master Alchemist"] = "Grand maître des alchimistes",
	["Grand Master Blacksmith"] = "Grand maître des forgerons",
	["Grand Master Enchanter"] = "Grand maître des enchanteurs",
	["Grand Master Engineer"] = "Grand maître des ingénieurs",
	["Grand Master Jewelcrafter"] = "Grand maître des joailliers",
	["Grand Master Leatherworker"] = "Grand maître des alchimistes",
	["Grand Master Tailor"] = "Grand maître des tailleurs",
	["Head Eco-Dome Engineer"] = "Ingénieur en chef de l'Écodôme",
	["Herbalism Trainer"] = "Maître des herboristes",
	["Horse Riding Instructor"] = "Instructeur d'équitation",
	["Hunter Trainer"] = "Maître des chasseurs",
	["Journeyman Alchemist"] = "Alchimiste - Compagnon",
	["Journeyman Alchemist Trainer"] = "Maître des alchimistes - Compagnon",
	["Journeyman Blacksmith"] = "Forgeron - Compagnon",
	["Journeyman Enchanter"] = "Enchanteur - Compagnon",
	["Journeyman Engineer"] = "Ingénieur - Compagnon",
	["Journeyman Jewelcrafter"] = "Joaillier - Compagnon",
	["Journeyman Leatherworker"] = "Artisan du cuir - Compagnon",
	["Journeyman Tailor"] = "Tailleur - Compagnon",
	["Kodo Riding Instructor"] = "Instructeur de monte de kodo",
	["Leatherworking Trainer"] = "Maître des Artisans du cuir",
	["Mage Trainer"] = "Maître des mages",
	["Master Alchemist"] = "Alchimiste - Maître",
	["Master Blacksmith"] = "Forgeron - Maître",
	["Master Dragonscale Leatherworker"] = "Artisan du cuir - Maître écailles de dragon",
	["Master Elemental Leatherworker"] = "Artisan du cuir - Maître élémentaire",
	["Master Enchanter"] = "Enchanteur - Maître",
	["Master Engineer"] = "Ingénieur - Maître",
	["Master Gnome Engineer"] = "Maître-ingénieur gnome",
	["Master Goblin Engineer"] = "Ingénieur - Maître gobelin",
	["Master Jewelcrafter"] = "Joaillier - Maître",
	["Master Leatherworker"] = "Artisan du cuir - Maître",
	["Master Leatherworking Trainer"] = "Maître des Artisans du cuir - Maître",
	["Master Shadoweave Tailor"] = "Tailleur - Maître tisse-ombre",
	["Master Tailor"] = "Tailleur - Maître",
	["Master Tribal Leatherworker"] = "Artisan du cuir - Maître tribal",
	["Mining Trainer"] = "Maître des mineurs",
	["Nightsaber Riding Instructor"] = "Instructeur de monte de tigre à dents de sabre",
	["Owl Trainer"] = "Entraîneur de chouettes",
	["Paladin Trainer"] = "Maître des paladins",
	["Pet Trainer"] = "Maître des familiers",
	["Portal Trainer"] = "Maître des portails",
	["Priest Trainer"] = "Maître des prêtres",
	["Ram Riding Instructor"] = "Instructeur de monte de bélier",
	["Raptor Handler"] = "Dresseur de raptors",
	["Raptor Riding Trainer"] = "Instructrice de monte de raptor",
	["Riding Instructor"] = "Instructeur de monte",
	["Rogue Trainer"] = "Maître des voleurs",
	["Royal Apothecary Society"] = "Société royale des apothicaires",
	["Saber Handler"] = "Dresseur de dents de sabre",
	["Shaman Trainer"] = "Maître des chamans",
	["Skinning Trainer"] = "Maître des dépeceurs",
	["Speciality Engineer"] = "Ingénieur spécialiste",
	["Superior Leatherworker"] = "Excellent artisan du cuir",
	["Transportation Engineer"] = "Ingénieur en charge du transporteur",
	["Trauma Surgeon"] = "Chirurgien",
	["Tribal Leatherworking Trainer"] = "Maître des artisans du cuir tribal",
	["Unbalanced Engineer"] = "Ingénieur déséquilibré",
	["Undead Horse Riding Instructor"] = "Instructeur d'équitation mort-vivant",
	["Warlock Trainer"] = "Maître des démonistes",
	["Warrior Trainer"] = "Maître des guerriers",
	["Weapon Master"] = "Maître d'armes",
	["Wolf Riding Instructor"] = "Instructeur de monte de loup",
} end)

BabbleTrainer:RegisterTranslations("koKR", function() return {
	-- Trainer types
	["Artisan Alchemist"] = "전문 연금술사",
	["Artisan Blacksmith"] = "전문 대장장이",
	["Artisan Enchanter"] = "전문 마법부여사",
	["Artisan Engineer"] = "전문 기술자",
	["Artisan Leatherworker"] = "전문 가죽세공인",
	["Artisan Tailor"] = "전문 재봉사",
	["Bael'dun Chief Engineer"] = "바엘던 선임기술자",
	["Bat Handler"] = "Bat Handler", -- check
	["Blacksmith"] = "대장장이",
	["Chief Engineer"] = "선임기술자",
	["Cooking Trainer"] = "전문 요리사",
	["Demon Trainer"] = "악마 훈련사",
	["Druid Trainer"] = "상급 드루이드",
	["Engineer"] = "기술자",
	["Expert Alchemist"] = "숙련 연금술사",
	["Expert Blacksmith"] = "숙련 대장장이",
	["Expert Enchanter"] = "숙련 마법부여사",
	["Expert Engineer"] = "숙련 기술자",
	["Expert Leatherworker"] = "숙련 가죽세공인",
	["Expert Tailor"] = "숙련 재봉사",
	["Explorers' League"] = "Explorers' League", -- check
	["First Aid Trainer"] = "전문 응급치료사",
	["Fishing Trainer"] = "전문 낚시꾼",
	["Grand Master Alchemist"] = "연금술의 거장",
	["Grand Master Blacksmith"] = "대장기술의 거장",
	["Grand Master Enchanter"] = "마법부여의 거장",
	["Grand Master Engineer"] = "기계공학의 거장",
	["Grand Master Jewelcrafter"] = "보석세공의 거장",
	["Grand Master Leatherworker"] = "가죽세공의 거장",
	["Grand Master Tailor"] = "재봉술의 거장",
	["Head Eco-Dome Engineer"] = "수석 생태지구 기술자",
	["Herbalism Trainer"] = "전문 약초채집사",
	["Horse Riding Instructor"] = "전문 승마 기수",
	["Hunter Trainer"] = "상급 사냥꾼",
	["Journeyman Alchemist"] = "수습 연금술사",
	["Journeyman Alchemist Trainer"] = "수습 연금술사",
	["Journeyman Blacksmith"] = "수습 대장장이",
	["Journeyman Enchanter"] = "수습 마법부여사",
	["Journeyman Engineer"] = "수습 기술자",
	["Journeyman Jewelcrafter"] = "수습 보석세공인",
	["Journeyman Leatherworker"] = "수습 가죽세공인",
	["Journeyman Tailor"] = "수습 재봉사",
	["Kodo Riding Instructor"] = "전문 코도 기수",
	["Leatherworking Trainer"] = "전문 가죽세공인",
	["Mage Trainer"] = "상급 마법사",
	["Master Alchemist"] = "연금술의 대가",
	["Master Blacksmith"] = "대장기술의 대가",
	["Master Dragonscale Leatherworker"] = "용비늘 가죽세공의 대가",
	["Master Elemental Leatherworker"] = "원소 가죽세공의 대가",
	["Master Enchanter"] = "마법부여의 대가",
	["Master Engineer"] = "기계공학의 대가",
	["Master Gnome Engineer"] = "노움 기술자 조합장",
	["Master Goblin Engineer"] = "고블린 기술자 조합장",
	["Master Jewelcrafter"] = "보석세공의 거장", -- check
	["Master Leatherworker"] = "가죽세공의 대가",
	["Master Leatherworking Trainer"] = "가죽세공의 대가",
	["Master Shadoweave Tailor"] = "그림자 재봉술의 대가",
	["Master Tailor"] = "재봉술의 대가",
	["Master Tribal Leatherworker"] = "전통 가죽세공의 대가",
	["Mining Trainer"] = "전문 광부",
	["Nightsaber Riding Instructor"] = "Nightsaber Riding Instructor", -- check
	["Owl Trainer"] = "올빼미 조련사",
	["Paladin Trainer"] = "상급 성기사",
	["Pet Trainer"] = "야수 조련사",
	["Portal Trainer"] = "순간이동 전문 마법사",
	["Priest Trainer"] = "상급 사제",
	["Ram Riding Instructor"] = "전문 산양 기수",
	["Raptor Handler"] = "Raptor Handler", -- check
	["Raptor Riding Trainer"] = "랩터 조련사",
	["Riding Instructor"] = "전문 기수",
	["Rogue Trainer"] = "상급 도적",
	["Royal Apothecary Society"] = "왕립 연금술 학회",
	["Saber Handler"] = "Saber Handler", -- check
	["Shaman Trainer"] = "상급 주술사",
	["Skinning Trainer"] = "전문 무두장이",
	["Speciality Engineer"] = "Speciality Engineer", -- check
	["Superior Leatherworker"] = "최상급 가죽세공인",
	["Transportation Engineer"] = "순간이동 기술자",
	["Trauma Surgeon"] = "군의관",
	["Tribal Leatherworking Trainer"] = "전통 가죽세공인",
	["Unbalanced Engineer"] = "정신나간 기술자",
	["Undead Horse Riding Instructor"] = "언데드 말 전문기수",
	["Warlock Trainer"] = "상급 흑마법사",
	["Warrior Trainer"] = "상급 전사",
	["Weapon Master"] = "무기 전문가",
	["Wolf Riding Instructor"] = "전문 늑대 기수",
} end)

BabbleTrainer:RegisterTranslations("zhCN", function() return {
-- Trainer types
	["Artisan Alchemist"] = "高级炼金师",
	["Artisan Blacksmith"] = "高级铁匠",
	["Artisan Enchanter"] = "高级附魔师",
	["Artisan Engineer"] = "高级技师",
	["Artisan Leatherworker"] = "高级制皮训练师",
	["Artisan Tailor"] = "高级裁缝",
	["Bael'dun Chief Engineer"] = "巴尔丹首席技师",
	["Bat Handler"] = "蝙蝠管理员",
	["Blacksmith"] = "铁匠",
	["Chief Engineer"] = "首席技师",
	["Cooking Trainer"] = "烹饪训练师",
	["Demon Trainer"] = "恶魔训练师",
	["Druid Trainer"] = "德鲁伊训练师",
	["Engineer"] = "技师",
	["Expert Alchemist"] = "初级炼金师",
	["Expert Blacksmith"] = "初级铁匠",
	["Expert Enchanter"] = "初级附魔师",
	["Expert Engineer"] = "初级技师",
	["Expert Leatherworker"] = "初级制皮师",
	["Expert Tailor"] = "初级裁缝",
	["Explorers' League"] = "探险者协会",
	["First Aid Trainer"] = "急救训练师",
	["Fishing Trainer"] = "钓鱼训练师",
	["Grand Master Alchemist"] = "宗师级炼金师",
	["Grand Master Blacksmith"] = "宗师级铁匠",
	["Grand Master Enchanter"] = "宗师级附魔师",
	["Grand Master Engineer"] = "宗师级技师",
	["Grand Master Jewelcrafter"] = "宗师级珠宝匠",
	["Grand Master Leatherworker"] = "宗师级制皮师",
	["Grand Master Tailor"] = "宗师级裁缝",
	["Head Eco-Dome Engineer"] = "生态圆顶首席技师",
	["Herbalism Trainer"] = "草药学训练师",
	["Horse Riding Instructor"] = "马骑术训练师",
	["Hunter Trainer"] = "猎人训练师",
	["Journeyman Alchemist"] = "初级炼金师",
	["Journeyman Alchemist Trainer"] = "初级炼金术训练师",
	["Journeyman Blacksmith"] = "初级铁匠",
	["Journeyman Enchanter"] = "初级附魔师",
	["Journeyman Engineer"] = "初级技师",
	["Journeyman Jewelcrafter"] = "初级珠宝匠",
	["Journeyman Leatherworker"] = "初级制皮师",
	["Journeyman Tailor"] = "初级裁缝",
	["Kodo Riding Instructor"] = "科多兽骑术训练师",
	["Leatherworking Trainer"] = "龙鳞制皮师",
	["Mage Trainer"] = "法师训练师",
	["Master Alchemist"] = "大师级炼金师",
	["Master Blacksmith"] = "大师级铁匠",
	["Master Dragonscale Leatherworker"] = "大师级龙鳞制皮师",
	["Master Elemental Leatherworker"] = "大师级元素制皮师",
	["Master Enchanter"] = "大师级附魔师",
	["Master Engineer"] = "大师级技师",
	["Master Gnome Engineer"] = "大师级侏儒技师",
	["Master Goblin Engineer"] = "大师级地精技师",
	["Master Jewelcrafter"] = "大师级珠宝匠",
	["Master Leatherworker"] = "大师级制皮训练师",
	["Master Leatherworking Trainer"] = "大师级制皮训练师",	--check
	["Master Shadoweave Tailor"] = "大师级暗纹裁缝",
	["Master Tailor"] = "大师级裁缝",
	["Master Tribal Leatherworker"] = "大师级部族制皮师",
	["Mining Trainer"] = "采矿训练师",
	["Nightsaber Riding Instructor"] = "夜刃豹骑术训练师",
	["Owl Trainer"] = "猫头鹰训练师",
	["Paladin Trainer"] = "圣骑士训练师",
	["Pet Trainer"] = "宠物训练师",
	["Portal Trainer"] = "传送门训练师",
	["Priest Trainer"] = "牧师训练师",
	["Ram Riding Instructor"] = "山羊骑术训练师",
	["Raptor Handler"] = "迅猛龙饲养员",
	["Raptor Riding Trainer"] = "迅猛龙骑术训练师",
	["Riding Instructor"] = "骑术训练师",	--check
	["Rogue Trainer"] = "盗贼训练师",
	["Royal Apothecary Society"] = "皇家药剂师学会",
	["Saber Handler"] = "驯豹人",
	["Shaman Trainer"] = "萨满祭司训练师",
	["Skinning Trainer"] = "剥皮训练师",
	["Speciality Engineer"] = "特殊工程学货物",
	["Superior Leatherworker"] = "高级皮匠",
	["Transportation Engineer"] = "传送器工程师",
	["Trauma Surgeon"] = "外科医疗队",
	["Tribal Leatherworking Trainer"] = "部族制皮训练师",
	["Unbalanced Engineer"] = "精神失常的技师",
	["Undead Horse Riding Instructor"] = "亡灵马骑术训练师",
	["Warlock Trainer"] = "术士训练师",
	["Warrior Trainer"] = "战士训练师",
	["Weapon Master"] = "武器大师",
	["Wolf Riding Instructor"] = "狼骑术训练师",
} end)

BabbleTrainer:RegisterTranslations("zhTW", function() return {
	-- Trainer types
	["Armor Crafter"] = "護甲師",
	["Artisan Alchemist"] = "專家級鍊金師",
	["Artisan Blacksmith"] = "專家級鐵匠",
	["Artisan Enchanter"] = "專家級附魔師",
	["Artisan Engineer"] = "專家級技師",
	["Artisan Leatherworker"] = "專家級製皮師",
	["Artisan Tailor"] = "專家級裁縫",
	["Bael'dun Chief Engineer"] = "巴爾丹首席工程師",
	["Bat Handler"] = "蝙蝠管理員",
	["Blacksmith"] = "鐵匠",
	["Chief Engineer"] = "首席工程師",
	["Cooking Trainer"] = "烹飪訓練師",
	["Demon Trainer"] = "惡魔訓練師",
	["Druid Trainer"] = "德魯伊訓練師",
	["Engineer"] = "工程師",
	["Engineering Trainer"] = "工程學訓練師",
	["Expert Alchemist"] = "高級鍊金師",
	["Expert Blacksmith"] = "高級鐵匠",
	["Expert Enchanter"] = "高級附魔師",
	["Expert Engineer"] = "高級技師",
	["Expert Jewelcrafter"] = "高級珠寶設計訓練師",
	["Expert Leatherworker"] = "高級製皮師",
	["Expert Tailor"] = "高級裁縫",
	["Explorers' League"] = "探險者協會",
	["First Aid Trainer"] = "急救訓練師",
	["Fishing Trainer"] = "釣魚訓練師",
	["Goblin Engineering Trainer"] = "哥布林工程學訓練師",
	["Grand Master Alchemist"] = "大鍊金術師",
	["Grand Master Blacksmith"] = "大鐵匠",
	["Grand Master Enchanter"] = "大附魔師",
	["Grand Master Engineer"] = "大工程師",
	["Grand Master Jewelcrafter"] = "寶石設計大師",
	["Grand Master Leatherworker"] = "大製皮師",
	["Grand Master Skinner"] = "大剝皮師",
	["Grand Master Tailor"] = "大裁縫師",
	["Head Eco-Dome Engineer"] = "秘境首席工程師",
	["Herbalism Trainer"] = "草藥學訓練師",
	["Horse Riding Instructor"] = "馬騎術訓練師",
	["Hunter Trainer"] = "獵人訓練師",
	["Journeyman Alchemist"] = "中級鍊金師",
	["Journeyman Alchemist Trainer"] = "中級鍊金師",
	["Journeyman Blacksmith"] = "中級鐵匠",
	["Journeyman Enchanter"] = "中級附魔師",
	["Journeyman Engineer"] = "中級技師",
	["Journeyman Jewelcrafter"] = "珠寶設計師",
	["Journeyman Leatherworker"] = "中級製皮師",
	["Journeyman Tailor"] = "中級裁縫",
	["Kodo Riding Instructor"] = "科多獸騎術訓練師",
	["Leatherworking Trainer"] = "製皮訓練師",
	["Mage Trainer"] = "法師訓練師",
	["Master Alchemist"] = "大師級鍊金師",
	["Master Blacksmith"] = "大師級鐵匠",
	["Master Dragonscale Leatherworker"] = "大師級龍鱗製皮師",
	["Master Elemental Leatherworker"] = "大師級元素製皮師",
	["Master Enchanter"] = "大師級附魔師",
	["Master Engineer"] = "大師級技師",
	["Master Gnome Engineer"] = "大師級地精技師",
	["Master Goblin Engineer"] = "大師級哥布林技師",
	["Master Jewelcrafter"] = "大師級寶石設計",
	["Master Leatherworker"] = "大師級製皮者",
	["Master Leatherworking Trainer"] = "大師級製皮訓練師",
	["Master Shadoweave Tailor"] = "大師級暗紋裁縫",
	["Master Tailor"] = "大師級裁縫",
	["Master Tribal Leatherworker"] = "大師級部族製皮師",
	["Mining Trainer"] = "採礦訓練師",
	["Nightsaber Riding Instructor"] = "夜刃豹騎術訓練師",
	["Owl Trainer"] = "貓頭鷹訓練師",
	["Paladin Trainer"] = "聖騎士訓練師",
	["Pet Trainer"] = "寵物訓練師",
	["Portal Trainer"] = "傳送門訓練師",
	["Priest Trainer"] = "牧師訓練師",
	["Ram Riding Instructor"] = "山羊騎術訓練師",
	["Raptor Handler"] = "迅猛龍飼養員",
	["Raptor Riding Trainer"] = "迅猛龍騎術訓練師",
	["Riding Instructor"] = "騎術訓練師",
	["Rogue Trainer"] = "盜賊訓練師",
	["Royal Apothecary Society"] = "皇家藥劑師學會",
	["Saber Handler"] = "馴豹人",
	["Shaman Trainer"] = "薩滿訓練師",
	["Skinner"] = "剝皮師",
	["Skinning Trainer"] = "剝皮訓練師",
	["Speciality Engineer"] = "特殊工程學貨物",
	["Superior Leatherworker"] = "高級皮匠",
	["Transportation Engineer"] = "傳送工程師",
	["Trauma Surgeon"] = "外科醫療隊",
	["Tribal Leatherworking Trainer"] = "部族製皮訓練師",
	["Unbalanced Engineer"] = "精神失常的技師",
	["Undead Horse Riding Instructor"] = "亡靈馬騎術訓練師",
	["Warlock Trainer"] = "術士訓練師",
	["Warrior Trainer"] = "戰士訓練師",
	["Weapon Master"] = "武器大師",
	["Wolf Riding Instructor"] = "狼騎術訓練師",
} end)

BabbleTrainer:RegisterTranslations("esES", function() return {
	-- Trainer types
	["Armor Crafter"] = "Fabricante de armaduras",
	["Artisan Alchemist"] = "Artesano alquimista",
	["Artisan Blacksmith"] = "Artesano herrero",
	["Artisan Enchanter"] = "Artesano encantador",
	["Artisan Engineer"] = "Artesano ingeniero",
	["Artisan Leatherworker"] = "Artesano peletero",
	["Artisan Tailor"] = "Artesano sastre",
	["Bael'dun Chief Engineer"] = "Ingeniero jefe Bael'dun",
	["Bat Handler"] = "Cuidador de murciélagos",
	["Blacksmith"] = "Herrero",
	["Chief Engineer"] = "Ingeniero jefe",
	["Cooking Trainer"] = "Instructor de cocina",
	["Demon Trainer"] = "Instructor de demonios",
	["Druid Trainer"] = "Instructor de druidas",
	["Engineer"] = "Ingeniero",
	["Engineering Trainer"] = "Entrenador de ingeniería",
	["Expert Alchemist"] = "Experto alquimista",
	["Expert Blacksmith"] = "Experto herrero",
	["Expert Enchanter"] = "Experto encantador",
	["Expert Engineer"] = "Experto ingeniero",
	["Expert Jewelcrafter"] = "Experto joyero",
	["Expert Leatherworker"] = "Experto peletero",
	["Expert Tailor"] = "Experto sastre",
	["Explorers' League"] = "Liga de Expedicionarios",
	["First Aid Trainer"] = "Instructor de primeros auxilios",
	["Fishing Trainer"] = "Instructor de pesca",
	["Goblin Engineering Trainer"] = "Entrenador de ingeniería goblin",
	["Grand Master Alchemist"] = "Gran maestro alquimista",
	["Grand Master Blacksmith"] = "Gran maestro herrero",
	["Grand Master Enchanter"] = "Gran maestro encantador",
	["Grand Master Engineer"] = "Gran maestro ingeniero",
	["Grand Master Jewelcrafter"] = "Gran maestro joyero",
	["Grand Master Leatherworker"] = "Gran maestro peletero",
	["Grand Master Skinner"] = "Gran maestro desollador",
	["Grand Master Tailor"] = "Gran maestro sastre",
	["Head Eco-Dome Engineer"] = "Ingeniero jefe del Ecodomo",
	["Herbalism Trainer"] = "Instructor de herboristería",
	["Horse Riding Instructor"] = "Instructor de equitación",
	["Hunter Trainer"] = "Instructor de caza",
	["Journeyman Alchemist"] = "Oficial alquimista",
	["Journeyman Alchemist Trainer"] = "Instructor de oficiales alquimistas",
	["Journeyman Blacksmith"] = "Oficial herrero",
	["Journeyman Enchanter"] = "Oficial encantador",
	["Journeyman Engineer"] = "Oficial ingeniero",
	["Journeyman Jewelcrafter"] = "Oficial joyero",
	["Journeyman Leatherworker"] = "Oficial peletero",
	["Journeyman Tailor"] = "Oficial sastre",
	["Kodo Riding Instructor"] = "Instructor de jinetes de kodos",
	["Leatherworking Trainer"] = "Instructor de peletería",
	["Mage Trainer"] = "Instructor de magos",
	["Master Alchemist"] = "Maestro alquimista",
	["Master Blacksmith"] = "Maestro herrero",
	["Master Dragonscale Leatherworker"] = "Maestro peletero de escamas de dragón",
	["Master Elemental Leatherworker"] = "Maestro Peletero elemental",
	["Master Enchanter"] = "Maestro encantador",
	["Master Engineer"] = "Maestro ingeniero",
	["Master Gnome Engineer"] = "Maestro ingeniero gnomo",
	["Master Goblin Engineer"] = "Maestro ingeniero goblin",
	["Master Jewelcrafter"] = "Maestro joyero",
	["Master Leatherworker"] = "Maestro peletero",
	["Master Leatherworking Trainer"] = "Instructor maestro de peletería",
	["Master Shadoweave Tailor"] = "Maestro sastre de tejido de sombra",
	["Master Tailor"] = "Maestro sastre",
	["Master Tribal Leatherworker"] = "Maestro Peletero tribal",
	["Mining Trainer"] = "Instructor de minería",
	["Nightsaber Riding Instructor"] = "Instructor de jinetes de sables de la noche",
	["Owl Trainer"] = "Instructor de búhos",
	["Paladin Trainer"] = "Instructor de paladines",
	["Pet Trainer"] = "Instructor de mascotas",
	["Portal Trainer"] = "Instructor de portal",
	["Priest Trainer"] = "Instructor de sacerdotes",
	["Ram Riding Instructor"] = "Instructor de jinetes de carneros",
	["Raptor Handler"] = "Cuidador de raptores",
	["Raptor Riding Trainer"] = "Instructor de jinetes de raptor",
	["Riding Instructor"] = "Instructor de equitación",
	["Rogue Trainer"] = "Instructor de pícaros",
	["Royal Apothecary Society"] = "Sociedad Real de Boticarios",
	["Saber Handler"] = "Cuidador de sables",
	["Shaman Trainer"] = "Instructor de chamanes",
	["Skinner"] = "Desollador",
	["Skinning Trainer"] = "Instructor de desuello",
	["Speciality Engineer"] = "Ingeniero especialista",
	["Superior Leatherworker"] = "Peletero superior",
	["Transportation Engineer"] = "Ingeniero de transportes",
	["Trauma Surgeon"] = "Cirujano del dispensario",
	["Tribal Leatherworking Trainer"] = "Instructor de Peletería tribal",
	["Unbalanced Engineer"] = "Ingeniero trastornado",
	["Undead Horse Riding Instructor"] = "Instructor de equitación no-muerto",
	["Warlock Trainer"] = "Instructor de brujos",
	["Warrior Trainer"] = "Instructor de guerreros",
	["Weapon Master"] = "Maestro armero",
	["Wolf Riding Instructor"] = "Instructor de jinetes de lobos",
} end)

BabbleTrainer:Debug()
BabbleTrainer:SetStrictness(true)

AceLibrary:Register(BabbleTrainer, MAJOR_VERSION, MINOR_VERSION)
BabbleTrainer = nil