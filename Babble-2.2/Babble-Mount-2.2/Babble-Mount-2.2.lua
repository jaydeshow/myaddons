﻿--[[
Name: Babble-Mount-2.2
Revision: $Rev: 66632 $
Authors(s): sbu (sbuehl@gmail.com)
Website: www.wowace.com
Documentation: http://www.wowace.com/wiki/Babble-Mount-2.2
SVN: http://svn.wowace.com/root/branch/Babble-2.2/Babble-Mount-2.2
Dependencies: AceLibrary, AceLocale-2.2
License: MIT
]]

local MAJOR_VERSION = "Babble-Mount-2.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 30000$", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:HasInstance("AceLocale-2.2") then error(MAJOR_VERSION .. " requires AceLocale-2.2") end

local _, x = AceLibrary("AceLocale-2.2"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleMount = AceLibrary("AceLocale-2.2"):new(MAJOR_VERSION)

BabbleMount:RegisterTranslations("enUS", function() return {
	-- Mounts
	["Arctic Wolf"] = true,
	["Black Battlestrider"] = true,
	["Black Hawkstrider"] = true,
	["Black Ram"] = true,
	["Black Stallion"] = true,
	["Black War Kodo"] = true,
	["Black War Ram"] = true,
	["Black War Raptor"] = true,
	["Black War Steed"] = true,
	["Black War Tiger"] = true,
	["Black War Wolf"] = true,
	["Blue Hawkstrider"] = true,
	["Blue Mechanostrider"] = true,
	["Blue Skeletal Horse"] = true,
	["Brown Elekk"] = true,
	["Brown Horse"] = true,
	["Brown Kodo"] = true,
	["Brown Ram"] = true,
	["Brown Skeletal Horse"] = true,
	["Brown Wolf"] = true,
	["Chestnut Mare"] = true,
	["Cobalt Riding Talbuk"] = true,
	["Cobalt War Talbuk"] = true,
	["Dark Riding Talbuk"] = true,
	["Dark War Talbuk"] = true,
	["Deathcharger"] = true,
	["Dire Wolf"] = true,
	["Emerald Raptor"] = true,
	["Fiery Warhorse"] = true,
	["Frost Ram"] = true,
	["Frostsaber"] = true,
	["Frostwolf Howler"] = true,
	["Gray Elekk"] = true,
	["Gray Kodo"] = true,
	["Gray Ram"] = true,
	["Gray Wolf"] = true,	-- add
	["Great Blue Elekk"] = true,
	["Great Brown Kodo"] = true,
	["Great Elite Elekk"] = true,	-- add
	["Great Gray Kodo"] = true,
	["Great Green Elekk"] = true,
	["Great Purple Elekk"] = true,
	["Great White Kodo"] = true,
	["Green Kodo"] = true,
	["Green Mechanostrider"] = true,
	["Green Skeletal Warhorse"] = true,
	["Icy Blue Mechanostrider"] = true,
	["Ivory Raptor"] = true,
	["Mottled Red Raptor"] = true,
	["Nightsaber"] = true,
	["Palomino Stallion"] = true,
	["Pinto Horse"] = true,
	["Purple Elekk"] = true,
	["Purple Hawkstrider"] = true,
	["Purple Mechanostrider"] = true,	-- add
	["Purple Skeletal Warhorse"] = true,
	["Raven Lord"] = true,
	["Red Hawkstrider"] = true,
	["Red Mechanostrider"] = true,
	["Red Skeletal Horse"] = true,
	["Red Skeletal Warhorse"] = true,
	["Red Wolf"] = true,
	["Riding Turtle"] = true,
	["Silver Riding Talbuk"] = true,
	["Silver War Talbuk"] = true,
	["Spotted Frostsaber"] = true,
	["Spotted Panther"] = true,	-- add
	["Stormpike Battle Charger"] = true,
	["Striped Frostsaber"] = true,
	["Striped Nightsaber"] = true,
	["Summon Black Qiraji Battle Tank"] = true,
	["Summon Blue Qiraji Battle Tank"] = true,
	["Summon Green Qiraji Battle Tank"] = true,
	["Summon Red Qiraji Battle Tank"] = true,
	["Summon Yellow Qiraji Battle Tank"] = true,
	["Swift Blue Raptor"] = true,
	["Swift Brown Ram"] = true,
	["Swift Brown Steed"] = true,
	["Swift Brown Wolf"] = true,
	["Swift Dawnsaber"] = true, --add
	["Swift Frostsaber"] = true,
	["Swift Gray Ram"] = true,
	["Swift Gray Wolf"] = true,
	["Swift Green Hawkstrider"] = true,
	["Swift Green Mechanostrider"] = true,
	["Swift Mistsaber"] = true,
	["Swift Olive Raptor"] = true,
	["Swift Orange Raptor"] = true,
	["Swift Palomino"] = true,
	["Swift Pink Hawkstrider"] = true,
	["Swift Purple Hawkstrider"] = true,
	["Swift Razzashi Raptor"] = true,
	["Swift Stormsaber"] = true,
	["Swift Timber Wolf"] = true,
	["Swift War Hawkstrider"] = true,	-- add
	["Swift White Mechanostrider"] = true,
	["Swift White Ram"] = true,
	["Swift White Steed"] = true,
	["Swift Yellow Mechanostrider"] = true,
	["Swift Zulian Tiger"] = true,
	["Tan Riding Talbuk"] = true,
	["Tan War Talbuk"] = true,
	["Teal Kodo"] = true,
	["Large Timber Wolf"] = true,
	["Turquoise Raptor"] = true,
	["Unpainted Mechanostrider"] = true,
	["Violet Raptor"] = true,
	["White Mechanostrider"] = true,
	["White Ram"] = true,
	["White Riding Talbuk"] = true,
	["White Stallion"] = true,
	["White War Talbuk"] = true,
	["Winterspring Frostsaber"] = true,
	-- Flying Mounts
	["Azure Netherwing Drake"] = true,
	["Blue Riding Nether Ray"] = true,
	["Blue Windrider"] = true,
	["Cobalt Netherwing Drake"] = true,
	["Ebon Gryphon Mount"] = true,
	["Golden Gryphon"] = true,
	["Green Riding Nether Ray"] = true,
	["Green Windrider"] = true,
	["Onyx Netherwing Drake"] = true,
	["Purple Riding Nether Ray"] = true,
	["Purple Netherwing Drake"] = true,
	["Red Riding Nether Ray"] = true,
	["Silver Riding Nether Ray"] = true,
	["Snowy Gryphon Mount"] = true,
	["Swift Blue Gryphon"] = true,
	["Swift Green Gryphon"] = true,
	["Swift Green Windrider"] = true,
	["Swift Nether Drake"] = true,	-- add
	["Swift Purple Gryphon"] = true,
	["Swift Purple Windrider"] = true,
	["Swift Red Gryphon"] = true,
	["Swift Red Windrider"] = true,
	["Swift Yellow Windrider"] = true,
	["Tawny Windrider"] = true,
	["Veridian Netherwing Drake"] = true,
	["Violet Netherwing Drake"] = true,
}
end)

--Chinese Translate by 月色狼影@CWDG
--CWDG site: http://Cwowaddon.com
BabbleMount:RegisterTranslations("zhCN", function() return {
	-- Mounts 座骑
	["Arctic Wolf"] = "极地冰狼",
	["Black Battlestrider"] = "黑色作战机械陆行鸟",
	["Black Hawkstrider"] = "黑色陆行鸟",--tbc
	["Black Ram"] = "黑山羊",
	["Black Stallion"] = "黑马",
	["Black War Kodo"] = "黑色作战科多兽",
	["Black War Ram"] = "黑色战羊",
	["Black War Raptor"] = "黑色作战迅猛龙",
	["Black War Steed"] = "黑色战驹",--check
	["Black War Tiger"] = "黑色战豹",
	["Black War Wolf"] = "黑色战狼",
	["Blue Hawkstrider"] = "蓝色陆行鸟",
	["Blue Mechanostrider"] = "蓝色机械陆行鸟",
	["Blue Skeletal Horse"] = "蓝色骸骨军马",
	["Brown Elekk"] = "棕色雷象",
	["Brown Horse"] = "棕马",
	["Brown Kodo"] = "棕色科多兽",
	["Brown Ram"] = "棕山羊",
	["Brown Skeletal Horse"] = "棕色骸骨军马",
	["Brown Wolf"] = "暗棕狼",
	["Chestnut Mare"] = "栗色马",
	["Cobalt Riding Talbuk"] = "蓝色骑乘塔布羊",
	["Cobalt War Talbuk"] = "蓝色作战塔布羊",
	["Dark Riding Talbuk"] = "褐色骑乘塔布羊",
	["Dark War Talbuk"] = "褐色作战塔布羊",
	["Deathcharger"] = "黑色骷髅战马",--check
	["Dire Wolf"] = "暗灰狼",
	["Emerald Raptor"] = "绿色迅猛龙",
	["Fiery Warhorse"] = "火焰战马",
	["Frost Ram"] = "霜山羊",
	["Frostsaber"] = "霜刃豹",
	["Frostwolf Howler"] = "霜狼嗥叫者",
	["Gray Elekk"] = "灰色雷象",
	["Gray Kodo"] = "灰色科多兽",
	["Gray Ram"] = "灰山羊",
	["Gray Wolf"] = "灰狼",
	["Great Blue Elekk"] = "重型蓝色雷象",
	["Great Brown Kodo"] = "迅捷棕色科多兽",
	["Great Elite Elekk"] = "重型精英雷象",--check
	["Great Gray Kodo"] = "迅捷灰色科多兽",
	["Great Green Elekk"] = "重型绿色雷象",
	["Great Purple Elekk"] = "重型紫色雷象",
	["Great White Kodo"] = "迅捷白色科多兽",
	["Green Kodo"] = "绿色科多兽",
	["Green Mechanostrider"] = "绿色机械陆行鸟",
	["Green Skeletal Warhorse"] = "绿色骸骨战马",
	["Icy Blue Mechanostrider"] = "冰蓝色机械陆行鸟",
	["Ivory Raptor"] = "白色迅猛龙",
	["Mottled Red Raptor"] = "红色迅猛龙",
	["Nightsaber"] = "夜刃豹",
	["Palomino Stallion"] = "褐色马",
	["Pinto Horse"] = "杂色马",
	["Purple Elekk"] = "紫色雷象",
	["Purple Hawkstrider"] = "紫色陆行鸟",
	["Purple Mechanostrider"] = "紫色机械陆行鸟",
	["Purple Skeletal Warhorse"] = "紫色骷髅战马",
	["Raven Lord"] = "乌鸦之神",
	["Red Hawkstrider"] = "红色陆行鸟",
	["Red Mechanostrider"] = "红色机械陆行鸟",
	["Red Skeletal Horse"] = "红色骸骨军马",
	["Red Skeletal Warhorse"] = "红色骷髅战马",
	["Red Wolf"] = "赤狼",
	["Riding Turtle"] = "骑乘乌龟",
	["Silver Riding Talbuk"] = "银色骑乘塔布羊",
	["Silver War Talbuk"] = "银色作战塔布羊",
	["Spotted Frostsaber"] = "斑点霜刃豹",
	["Spotted Panther"] = "白斑黑豹",
	["Stormpike Battle Charger"] = "雷矛军用坐骑",
	["Striped Frostsaber"] = "条纹霜刃豹",
	["Striped Nightsaber"] = "条纹夜刃豹",
	["Summon Black Qiraji Battle Tank"] = "召唤黑色其拉作战坦克",
	["Summon Blue Qiraji Battle Tank"] = "召唤蓝色其拉作战坦克",
	["Summon Green Qiraji Battle Tank"] = "召唤绿色其拉作战坦克",
	["Summon Red Qiraji Battle Tank"] = "召唤红色其拉作战坦克",
	["Summon Yellow Qiraji Battle Tank"] = "召唤黄色其拉作战坦克",
	["Swift Blue Raptor"] = "迅捷蓝色迅猛龙",
	["Swift Brown Ram"] = "迅捷棕山羊",
	["Swift Brown Steed"] = "迅捷棕马",
	["Swift Brown Wolf"] = "迅捷棕狼",
	["Swift Dawnsaber"] = "迅捷晨刃豹",
	["Swift Frostsaber"] = "迅捷霜刃豹",
	["Swift Gray Ram"] = "迅捷灰山羊",
	["Swift Gray Wolf"] = "迅捷灰狼",
	["Swift Green Hawkstrider"] = "迅捷绿色陆行鸟",
	["Swift Green Mechanostrider"] = "迅捷绿色机械陆行鸟",
	["Swift Mistsaber"] = "迅捷雾刃豹",
	["Swift Olive Raptor"] = "迅捷绿色迅猛龙",
	["Swift Orange Raptor"] = "迅捷橙色迅猛龙",
	["Swift Palomino"] = "迅捷褐色马",
	["Swift Pink Hawkstrider"] = "迅捷粉色陆行鸟",
	["Swift Purple Hawkstrider"] = "迅捷紫色陆行鸟",
	["Swift Razzashi Raptor"] = "拉卡什迅猛龙",
	["Swift Stormsaber"] = "迅捷雷刃豹",
	["Swift Timber Wolf"] = "迅捷森林狼",
	["Swift War Hawkstrider"] = "迅捷作战陆行鸟",
	["Swift White Mechanostrider"] = "迅捷白色机械陆行鸟",
	["Swift White Ram"] = "迅捷白山羊",
	["Swift White Steed"] = "迅捷白马",
	["Swift Yellow Mechanostrider"] = "迅捷黄色机械陆行鸟",
	["Swift Zulian Tiger"] = "迅捷祖利安猛虎",
	["Tan Riding Talbuk"] = "褐色骑乘塔布羊",
	["Tan War Talbuk"] = "褐色作战塔布羊",
	["Teal Kodo"] = "蓝色科多兽",
	["Large Timber Wolf"] = "棕狼",
	["Turquoise Raptor"] = "青色迅猛龙",
	["Unpainted Mechanostrider"] = "未涂色的机械陆行鸟",
	["Violet Raptor"] = "紫色迅猛龙",
	["White Mechanostrider"] = "白色机械陆行鸟",
	["White Ram"] = "白山羊",
	["White Riding Talbuk"] = "白色骑乘塔布羊",
	["White Stallion"] = "白马",
	["White War Talbuk"] = "白色作战塔布羊",
	["Winterspring Frostsaber"] = "冬泉霜刃豹",
	-- Flying Mounts
	["Azure Netherwing Drake"] = "青色灵翼幼龙",
	["Blue Riding Nether Ray"] = "蓝色骑乘虚空鳐",
	["Blue Windrider"] = "蓝色驭风者",
	["Cobalt Netherwing Drake"] = "蓝色灵翼幼龙",
	["Ebon Gryphon Mount"] = "黑色狮鹫",
	["Golden Gryphon"] = "金色狮鹫",
	["Green Riding Nether Ray"] = "绿色骑乘虚空鳐",
	["Green Windrider"] = "绿色驭风者",
	["Onyx Netherwing Drake"] = "黑色灵翼幼龙",
	["Purple Riding Nether Ray"] = "紫色骑乘虚空鳐",
	["Purple Netherwing Drake"] = "紫色灵翼幼龙",
	["Red Riding Nether Ray"] = "红色骑乘虚空鳐",
	["Silver Riding Nether Ray"] = "银色骑乘虚空鳐",
	["Snowy Gryphon Mount"] = "雪色狮鹫",
	["Swift Blue Gryphon"] = "迅捷蓝色狮鹫",
	["Swift Green Gryphon"] = "迅捷绿色狮鹫",
	["Swift Green Windrider"] = "迅捷绿色驭风者",
	["Swift Nether Drake"] = "迅捷虚空幼龙",
	["Swift Purple Gryphon"] = "迅捷紫色狮鹫",
	["Swift Purple Windrider"] = "迅捷紫色驭风者",
	["Swift Red Gryphon"] = "迅捷红色狮鹫",
	["Swift Red Windrider"] = "迅捷红色驭风者",
	["Swift Yellow Windrider"] = "迅捷黄色驭风者",
	["Tawny Windrider"] = "茶色驭风者",
	["Veridian Netherwing Drake"] = "绿色灵翼幼龙",
	["Violet Netherwing Drake"] = "红色灵翼幼龙",
}
end)

BabbleMount:RegisterTranslations("deDE", function() return {
	-- Mounts
	["Arctic Wolf"] = "Arktischer Wolf",
	["Black Battlestrider"] = "Schwarzer Schlachtenschreiter",
	["Black Hawkstrider"] = "Schwarzer Falkenschreiter",
	["Black Ram"] = "Schwarzer Widder",
--	["Black Stallion"] = true,
	["Black War Kodo"] = "Schwarzer Kriegskodo",
	["Black War Ram"] = "Schwarzer Kriegswidder",
--	["Black War Raptor"] = true,
--	["Black War Steed"] = true,
--	["Black War Tiger"] = true,
--	["Black War Wolf"] = true,
--	["Blue Hawkstrider"] = true,
--	["Blue Mechanostrider"] = true,
	["Blue Skeletal Horse"] = "Blaues Skelettpferd",
--	["Brown Elekk"] = true,
--	["Brown Horse"] = true,
--	["Brown Kodo"] = true,
--	["Brown Ram"] = true,
	["Brown Skeletal Horse"] = "Braunes Skelettpferd",
--	["Brown Wolf"] = true,
--	["Chestnut Mare"] = true,
--	["Cobalt Riding Talbuk"] = true,
--	["Cobalt War Talbuk"] = true,
--	["Dark Riding Talbuk"] = true,
--	["Dark War Talbuk"] = true,
--	["Deathcharger"] = true,
--	["Dire Wolf"] = true,
--	["Emerald Raptor"] = true,
--	["Fiery Warhorse"] = true,
--	["Frost Ram"] = true,
--	["Frostsaber"] = true,
--	["Frostwolf Howler"] = true,
--	["Gray Elekk"] = true,
--	["Gray Kodo"] = true,
--	["Gray Ram"] = true,
--	["Gray Wolf"] = true	-- add
--	["Great Blue Elekk"] = true,
--	["Great Brown Kodo"] = true,
--	["Great Elite Elekk"] = true,	-- add
--	["Great Gray Kodo"] = true,
--	["Great Green Elekk"] = true,
--	["Great Purple Elekk"] = true,
--	["Great White Kodo"] = true,
--	["Green Kodo"] = true,
--	["Green Mechanostrider"] = true,
--	["Green Skeletal Warhorse"] = true,
--	["Icy Blue Mechanostrider"] = true,
--	["Ivory Raptor"] = true,
--	["Mottled Red Raptor"] = true,
--	["Nightsaber"] = true,
--	["Palomino Stallion"] = true,
--	["Pinto Horse"] = true,
--	["Purple Elekk"] = true,
--	["Purple Hawkstrider"] = true,
--	["Purple Mechanostrider"] = true,	-- add
--	["Purple Skeletal Warhorse"] = true,
--	["Raven Lord"] = true,
--	["Red Hawkstrider"] = true,
--	["Red Mechanostrider"] = true,
--	["Red Skeletal Horse"] = true,
--	["Red Skeletal Warhorse"] = true,
--	["Red Wolf"] = true,
--	["Riding Turtle"] = true,
--	["Silver Riding Talbuk"] = true,
--	["Silver War Talbuk"] = true,
--	["Spotted Frostsaber"] = true,
--	["Spotted Panther"] = true,	-- add
--	["Stormpike Battle Charger"] = true,
--	["Striped Frostsaber"] = true,
--	["Striped Nightsaber"] = true,
--	["Summon Black Qiraji Battle Tank"] = true,
--	["Summon Blue Qiraji Battle Tank"] = true,
--	["Summon Green Qiraji Battle Tank"] = true,
--	["Summon Red Qiraji Battle Tank"] = true,
--	["Summon Yellow Qiraji Battle Tank"] = true,
--	["Swift Blue Raptor"] = true,
--	["Swift Brown Ram"] = true,
--	["Swift Brown Steed"] = true,
--	["Swift Brown Wolf"] = true,
--	["Swift Dawnsaber"] = true, --add
--	["Swift Frostsaber"] = true,
--	["Swift Gray Ram"] = true,
--	["Swift Gray Wolf"] = true,
--	["Swift Green Hawkstrider"] = true,
--	["Swift Green Mechanostrider"] = true,
--	["Swift Mistsaber"] = true,
--	["Swift Olive Raptor"] = true,
--	["Swift Orange Raptor"] = true,
--	["Swift Palomino"] = true,
--	["Swift Pink Hawkstrider"] = true,
--	["Swift Purple Hawkstrider"] = true,
--	["Swift Razzashi Raptor"] = true,
--	["Swift Stormsaber"] = true,
--	["Swift Timber Wolf"] = true,
--	["Swift War Hawkstrider"] = true,	-- add
--	["Swift White Mechanostrider"] = true,
--	["Swift White Ram"] = true,
--	["Swift White Steed"] = true,
--	["Swift Yellow Mechanostrider"] = true,
--	["Swift Zulian Tiger"] = true,
--	["Tan Riding Talbuk"] = true,
--	["Tan War Talbuk"] = true,
--	["Teal Kodo"] = true,
--	["Large Timber Wolf"] = true,
--	["Turquoise Raptor"] = true,
--	["Unpainted Mechanostrider"] = true,
--	["Violet Raptor"] = true,
--	["White Mechanostrider"] = true,
--	["White Ram"] = true,
--	["White Riding Talbuk"] = true,
--	["White Stallion"] = true,
--	["White War Talbuk"] = true,
--	["Winterspring Frostsaber"] = true,
	-- Flying Mounts
--	["Azure Netherwing Drake"] = true,
--	["Blue Riding Nether Ray"] = true,
--	["Blue Windrider"] = true,
--	["Cobalt Netherwing Drake"] = true,
--	["Ebon Gryphon Mount"] = true,
--	["Golden Gryphon"] = true,
--	["Green Riding Nether Ray"] = true,
--	["Green Windrider"] = true,
--	["Onyx Netherwing Drake"] = true,
--	["Purple Riding Nether Ray"] = true,
--	["Purple Netherwing Drake"] = true,
--	["Red Riding Nether Ray"] = true,
--	["Silver Riding Nether Ray"] = true,
--	["Snowy Gryphon Mount"] = true,
--	["Swift Blue Gryphon"] = true,
--	["Swift Green Gryphon"] = true,
--	["Swift Green Windrider"] = true,
--	["Swift Nether Drake"] = true,	-- add
--	["Swift Purple Gryphon"] = true,
--	["Swift Purple Windrider"] = true,
--	["Swift Red Gryphon"] = true,
--	["Swift Red Windrider"] = true,
--	["Swift Yellow Windrider"] = true,
--	["Tawny Windrider"] = true,
--	["Veridian Netherwing Drake"] = true,
--	["Violet Netherwing Drake"] = true,
}
end)

BabbleMount:RegisterTranslations("zhTW", function() return {
	-- Mounts
	["Arctic Wolf"] = "極地冰狼",
	["Black Battlestrider"] = "黑色作戰陸行鳥",
	["Black Hawkstrider"] = "黑色陸行鷹",
	["Black Ram"] = "黑山羊",
	["Black Stallion"] = "黑馬",
	["Black War Kodo"] = "黑色作戰科多獸",
	["Black War Ram"] = "黑色戰羊",
	["Black War Raptor"] = "黑色戰鬥迅猛龍",
	["Black War Steed"] = "黑色戰駒",
	["Black War Tiger"] = "黑色戰虎",
	["Black War Wolf"] = "黑色戰狼",
	["Blue Hawkstrider"] = "藍色陸行鷹",
	["Blue Mechanostrider"] = "藍色機械陸行鳥",
	["Blue Skeletal Horse"] = "藍色骸骨戰馬",
	["Brown Elekk"] = "棕色伊萊克",
	["Brown Horse"] = "棕馬",
	["Brown Kodo"] = "棕色科多獸",
	["Brown Ram"] = "棕山羊",
	["Brown Skeletal Horse"] = "棕色骸骨戰馬",
	["Brown Wolf"] = "暗棕狼",
	["Chestnut Mare"] = "栗色馬",
	["Cobalt Riding Talbuk"] = "深藍色塔巴克坐騎",
	["Cobalt War Talbuk"] = "深藍色塔巴克戰騎",
	["Dark Riding Talbuk"] = "黑色塔巴克坐騎",
	["Dark War Talbuk"] = "黑色塔巴克戰騎",
	["Deathcharger"] = "骷髏戰馬",
	["Dire Wolf"] = "恐狼",
	["Emerald Raptor"] = "綠色迅猛龍",
	["Fiery Warhorse"] = "熾炎戰馬",
	["Frost Ram"] = "霜山羊",
	["Frostsaber"] = "霜刃豹",
	["Frostwolf Howler"] = "霜狼嗥叫者",
	["Gray Elekk"] = "灰色伊萊克",
	["Gray Kodo"] = "灰色科多獸",
	["Gray Ram"] = "灰山羊",
	["Gray Wolf"] = "灰狼",	-- add
	["Great Blue Elekk"] = "大型藍色伊萊克",
	["Great Brown Kodo"] = "迅捷棕色科多獸",
	["Great Elite Elekk"] = "大型精英伊萊克",	-- add
	["Great Gray Kodo"] = "大型灰色科多獸",
	["Great Green Elekk"] = "大型綠色伊萊克",
	["Great Purple Elekk"] = "大型紫色伊萊克",
	["Great White Kodo"] = "大型白色科多獸",
	["Green Kodo"] = "綠色科多獸",
	["Green Mechanostrider"] = "綠色機械陸行鳥",
	["Green Skeletal Warhorse"] = "綠色骷髏戰馬",
	["Icy Blue Mechanostrider"] = "冰藍色機械陸行鳥",
	["Ivory Raptor"] = "白色迅猛龍",
	["Mottled Red Raptor"] = "紅色迅猛龍",
	["Nightsaber"] = "夜刃豹",
	["Palomino Stallion"] = "褐色馬",
	["Pinto Horse"] = "雜色馬",
	["Purple Elekk"] = "紫色伊萊克",
	["Purple Hawkstrider"] = "紫色陸行鷹",
	["Purple Mechanostrider"] = "紫色機械陸行鳥",	-- add
	["Purple Skeletal Warhorse"] = "紫色骷髏戰馬",
	["Raven Lord"] = "烏鴉領主",
	["Red Hawkstrider"] = "紅色陸行鷹",
	["Red Mechanostrider"] = "紅色機械陸行鳥",
	["Red Skeletal Horse"] = "紅色骸骨戰馬",
	["Red Skeletal Warhorse"] = "紅色骷髏戰馬",
	["Red Wolf"] = "赤狼",
	["Riding Turtle"] = "烏龜坐騎",
	["Silver Riding Talbuk"] = "銀色塔巴克坐騎",
	["Silver War Talbuk"] = "銀色塔巴克戰騎",
	["Spotted Frostsaber"] = "斑點霜刃豹",
	["Spotted Panther"] = "黑斑黃豹",	-- add
	["Stormpike Battle Charger"] = "雷矛軍用坐騎",
	["Striped Frostsaber"] = "條紋霜刃豹",
	["Striped Nightsaber"] = "條紋夜刃豹",
	["Summon Black Qiraji Battle Tank"] = "召喚黑色其拉作戰坦克",
	["Summon Blue Qiraji Battle Tank"] = "召喚藍色其拉作戰坦克",
	["Summon Green Qiraji Battle Tank"] = "召喚綠色其拉作戰坦克",
	["Summon Red Qiraji Battle Tank"] = "召喚紅色其拉作戰坦克",
	["Summon Yellow Qiraji Battle Tank"] = "召喚黃色其拉作戰坦克",
	["Swift Blue Raptor"] = "迅捷藍色迅猛龍",
	["Swift Brown Ram"] = "迅捷棕山羊",
	["Swift Brown Steed"] = "迅捷棕馬",
	["Swift Brown Wolf"] = "迅捷棕狼",
	["Swift Dawnsaber"] = "迅捷晨刃豹", --add
	["Swift Frostsaber"] = "迅捷霜刃豹",
	["Swift Gray Ram"] = "迅捷灰山羊",
	["Swift Gray Wolf"] = "迅捷灰狼",
	["Swift Green Hawkstrider"] = "迅捷綠色陸行鷹",
	["Swift Green Mechanostrider"] = "迅捷綠色機械陸行鳥",
	["Swift Mistsaber"] = "迅捷霧刃豹",
	["Swift Olive Raptor"] = "迅捷綠色迅猛龍",
	["Swift Orange Raptor"] = "迅捷橙色迅猛龍",
	["Swift Palomino"] = "迅捷褐色馬",
	["Swift Pink Hawkstrider"] = "迅捷粉紅色陸行鷹",
	["Swift Purple Hawkstrider"] = "迅捷紫色陸行鷹",
	["Swift Razzashi Raptor"] = "迅捷拉札希迅猛龍",
	["Swift Stormsaber"] = "迅捷雷刃豹",
	["Swift Timber Wolf"] = "迅捷森林狼",
	["Swift War Hawkstrider"] = "迅捷戰鬥陸行鷹",	-- add
	["Swift White Mechanostrider"] = "迅捷白色機械陸行鳥",
	["Swift White Ram"] = "迅捷白山羊",
	["Swift White Steed"] = "迅捷白馬",
	["Swift Yellow Mechanostrider"] = "迅捷黃色機械陸行鳥",
	["Swift Zulian Tiger"] = "迅捷祖利安猛虎",
	["Tan Riding Talbuk"] = "古銅色塔巴克坐騎",
	["Tan War Talbuk"] = "古銅色塔巴克戰騎",
	["Teal Kodo"] = "藍色科多獸",
	["Large Timber Wolf"] = "棕狼",
	["Turquoise Raptor"] = "青色迅猛龍",
	["Unpainted Mechanostrider"] = "未塗色的機械陸行鳥",
	["Violet Raptor"] = "紫色迅猛龍",
	["White Mechanostrider"] = "白色機械陸行鳥",
	["White Ram"] = "白山羊",
	["White Riding Talbuk"] = "白色塔巴克坐騎",
	["White Stallion"] = "白馬",
	["White War Talbuk"] = "白色塔巴克戰騎",
	["Winterspring Frostsaber"] = "冬泉霜刃豹",
	-- Flying Mounts
	["Azure Netherwing Drake"] = "藍色虛空之翼龍",
	["Blue Riding Nether Ray"] = "藍色虛空鰭刺坐騎",
	["Blue Windrider"] = "藍色的雙足飛龍",
	["Cobalt Netherwing Drake"] = "深藍色虛空之翼龍",
	["Ebon Gryphon Mount"] = "黑檀獅鷲獸坐騎",
	["Golden Gryphon"] = "金色獅鷲獸",
	["Green Riding Nether Ray"] = "綠色虛空鰭刺坐騎",
	["Green Windrider"] = "綠色雙足飛龍",
	["Onyx Netherwing Drake"] = "粉色虛空之翼龍",
	["Purple Riding Nether Ray"] = "紫色虛空鰭刺坐騎",
	["Purple Netherwing Drake"] = "紫色虛空之翼龍",
	["Red Riding Nether Ray"] = "紅色虛空鰭刺坐騎",
	["Silver Riding Nether Ray"] = "銀色虛空鰭刺坐騎",
	["Snowy Gryphon Mount"] = "雪白獅鷲獸坐騎",
	["Swift Blue Gryphon"] = "迅捷藍色獅鷲獸",
	["Swift Green Gryphon"] = "迅捷綠色獅鷲獸",
	["Swift Green Windrider"] = "迅捷綠色雙足飛龍",
	["Swift Nether Drake"] = "迅捷虛空龍",	-- add
	["Swift Purple Gryphon"] = "迅捷紫色獅鷲獸",
	["Swift Purple Windrider"] = "迅捷紫色雙足飛龍",
	["Swift Red Gryphon"] = "迅捷紅色獅鷲獸",
	["Swift Red Windrider"] = "迅捷紅色雙足飛龍",
	["Swift Yellow Windrider"] = "迅捷黃色雙足飛龍",
	["Tawny Windrider"] = "黃褐色的雙足飛龍",
	["Veridian Netherwing Drake"] = "翠綠色虛空之翼龍",
	["Violet Netherwing Drake"] = "紫紅色虛空之翼龍",
}
end)

BabbleMount:RegisterTranslations("koKR", function() return {
	-- Mounts
	["Arctic Wolf"] = "북극 늑대",
	["Black Battlestrider"] = "검은 전투기계타조",
	["Black Hawkstrider"] = "검은 매타조",
	["Black Ram"] = "검은 산양",
	["Black Stallion"] = "흑마",
	["Black War Kodo"] = "검은 전투코도",
	["Black War Ram"] = "검은 전투산양",
	["Black War Raptor"] = "검은 전투랩터",
	["Black War Steed"] = "검은 전투군마",
	["Black War Tiger"] = "검은 전투호랑이",
	["Black War Wolf"] = "검은 전투늑대",
	["Blue Hawkstrider"] = "푸른 매타조",
	["Blue Mechanostrider"] = "푸른 기계타조",
	["Blue Skeletal Horse"] = "푸른 해골마",
	["Brown Elekk"] = "갈색 엘레크",
	["Brown Horse"] = "갈색마",
	["Brown Kodo"] = "갈색 코도",
	["Brown Ram"] = "갈색 산양",
	["Brown Skeletal Horse"] = "갈색 해골마",
	["Brown Wolf"] = "갈색 늑대",
	["Chestnut Mare"] = "적토마",
	["Cobalt Riding Talbuk"] = "암청색 탈부크",
	["Cobalt War Talbuk"] = "암청색 전투 탈부크",
	["Dark Riding Talbuk"] = "암흑 탈부크",
	["Dark War Talbuk"] = "암흑 전투 탈부크",
	["Deathcharger"] = "죽음의 군마",
	["Dire Wolf"] = "광포한 늑대",
	["Emerald Raptor"] = "녹색 랩터",
	["Fiery Warhorse"] = "불타는 전투마",
	["Frost Ram"] = "서리 산양",
	["Frostsaber"] = "빙호",
	["Frostwolf Howler"] = "전투 서리늑대",
	["Gray Elekk"] = "회색 엘레크",
	["Gray Kodo"] = "회색 코도",
	["Gray Ram"] = "회색 산양",
	["Gray Wolf"] = "회색 늑대",	-- add
	["Great Blue Elekk"] = "거대한 푸른색 엘레크",
	["Great Brown Kodo"] = "거대한 갈색 코도",
	["Great Elite Elekk"] = "거대한 정예 엘레크",
	["Great Gray Kodo"] = "거대한 회색 코도",
	["Great Green Elekk"] = "거대한 녹색 엘레크",
	["Great Purple Elekk"] = "거대한 보라색 엘레크",
	["Great White Kodo"] = "거대한 흰색 코도",
	["Green Kodo"] = "녹색 코도",
	["Green Mechanostrider"] = "녹색 기계타조",
	["Green Skeletal Warhorse"] = "녹색 해골군마",
	["Icy Blue Mechanostrider"] = "투명청색 기계타조",
	["Ivory Raptor"] = "상아색 랩터",
	["Mottled Red Raptor"] = "붉은 점박이 랩터",
	["Nightsaber"] = "흑호",
	["Palomino Stallion"] = "황토마",
	["Pinto Horse"] = "적마",
	["Purple Elekk"] = "보라색 엘레크",
	["Purple Hawkstrider"] = "보라색 매타조",
	["Purple Mechanostrider"] = "보라색 기계타조",	-- add
	["Purple Skeletal Warhorse"] = "보라색 해골 군마",
--	["Raven Lord"] = true,
	["Red Hawkstrider"] = "붉은 매타조",
	["Red Mechanostrider"] = "빨간 기계타조",
	["Red Skeletal Horse"] = "붉은 해골마",
	["Red Skeletal Warhorse"] = "붉은 전투해골마",
	["Red Wolf"] = "붉은 늑대",
	["Riding Turtle"] = "거북이 타기",
	["Silver Riding Talbuk"] = "은빛 탈부크",
	["Silver War Talbuk"] = "은빛 전투 탈부크",
	["Spotted Frostsaber"] = "점박이빙호",
	["Spotted Panther"] = "점박이흑호",	-- add
	["Stormpike Battle Charger"] = "스톰파이크 전투산양",
	["Striped Frostsaber"] = "줄무늬빙호",
	["Striped Nightsaber"] = "줄무늬흑호",
	["Summon Black Qiraji Battle Tank"] = "검은 퀴라지 전차",
	["Summon Blue Qiraji Battle Tank"] = "푸른 퀴라지 전차",
	["Summon Green Qiraji Battle Tank"] = "녹색 퀴라지 전차",
	["Summon Red Qiraji Battle Tank"] = "붉은 퀴라지 전차",
	["Summon Yellow Qiraji Battle Tank"] = "노란 퀴라지 전차",
	["Swift Blue Raptor"] = "날쌘 푸른 랩터",
	["Swift Brown Ram"] = "날쌘 갈색 산양",
	["Swift Brown Steed"] = "날쌘 갈색마",
	["Swift Brown Wolf"] = "날쌘 갈색 늑대",
	["Swift Dawnsaber"] = "날쌘 여명호랑이", --add
	["Swift Frostsaber"] = "날쌘 겨울빙호",
	["Swift Gray Ram"] = "날쌘 회색 산양",
	["Swift Gray Wolf"] = "날쌘 회색 늑대",
	["Swift Green Hawkstrider"] = "날쌘 녹색 매타조",
	["Swift Green Mechanostrider"] = "날쌘 녹색 기계타조",
	["Swift Mistsaber"] = "날쌘 안개호랑이",
	["Swift Olive Raptor"] = "날쌘 녹색 랩터",
	["Swift Orange Raptor"] = "날쌘 주황색 랩터",
	["Swift Palomino"] = "날쌘 황토마",
	["Swift Pink Hawkstrider"] = "날쌘 분홍색 매타조",
	["Swift Purple Hawkstrider"] = "날쌘 보라색 매타조",
	["Swift Razzashi Raptor"] = "날쌘 래즈자쉬 랩터",
	["Swift Stormsaber"] = "날쌘 폭풍호랑이",
	["Swift Timber Wolf"] = "날쌘 회갈색 늑대",
	["Swift War Hawkstrider"] = "날쌘 전투 매타조",	-- add
	["Swift White Mechanostrider"] = "날쌘 흰색 기계타조",
	["Swift White Ram"] = "날쌘 흰색 산양",
	["Swift White Steed"] = "날쌘 백마",
	["Swift Yellow Mechanostrider"] = "날쌘 노란색 기계타조",
	["Swift Zulian Tiger"] = "날쌘 줄리안 호랑이",
	["Tan Riding Talbuk"] = "갈색 탈부크",
	["Tan War Talbuk"] = "갈색 전투 탈부크",
	["Teal Kodo"] = "청색 코도",
	["Large Timber Wolf"] = "회갈색 늑대",
	["Turquoise Raptor"] = "청록색 랩터",
	["Unpainted Mechanostrider"] = "강철 기계타조",
	["Violet Raptor"] = "보라색 랩터",
	["White Mechanostrider"] = "흰색 기계타조",
	["White Ram"] = "흰색 산양",
	["White Riding Talbuk"] = "흰색 탈부크",
	["White Stallion"] = "백마",
	["White War Talbuk"] = "흰색 전투 탈부크",
	["Winterspring Frostsaber"] = "겨울빙호",
	-- Flying Mounts
--	["Azure Netherwing Drake"] = true,
--	["Blue Riding Nether Ray"] = true,
	["Blue Windrider"] = "푸른색 와이번",
--	["Cobalt Netherwing Drake"] = true,
	["Ebon Gryphon Mount"] = "칠흑의 그리핀",
	["Golden Gryphon"] = "황금빛 그리핀",
--	["Green Riding Nether Ray"] = true,
	["Green Windrider"] = "녹색 와이번",
--	["Onyx Netherwing Drake"] = true,
--	["Purple Riding Nether Ray"] = true,
--	["Purple Netherwing Drake"] = true,
--	["Red Riding Nether Ray"] = true,
--	["Silver Riding Nether Ray"] = true,
	["Snowy Gryphon Mount"] = "순백의 그리핀",
	["Swift Blue Gryphon"] = "날쌘 푸른색 그리핀",
	["Swift Green Gryphon"] = "날쌘 녹색 그리핀",
	["Swift Green Windrider"] = "날쌘 녹색 와이번",
	["Swift Nether Drake"] = "날쌘 황천의 비룡",	-- add
	["Swift Purple Gryphon"] = "날쌘 보라색 그리핀",
	["Swift Purple Windrider"] = "날쌘 보라색 와이번",
	["Swift Red Gryphon"] = "날쌘 붉은색 그리핀",
	["Swift Red Windrider"] = "날쌘 붉은색 와이번",
	["Swift Yellow Windrider"] = "날쌘 노란색 와이번",
	["Tawny Windrider"] = "황갈색 와이번",
--	["Veridian Netherwing Drake"] = true,
--	["Violet Netherwing Drake"] = true,
}
end)

BabbleMount:Debug()
BabbleMount:SetStrictness(true)

AceLibrary:Register(BabbleMount, MAJOR_VERSION, MINOR_VERSION)
BabbleMount = nil