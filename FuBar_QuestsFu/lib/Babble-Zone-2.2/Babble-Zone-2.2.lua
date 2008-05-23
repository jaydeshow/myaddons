﻿--[[
Name: Babble-Zone-2.2
Revision: $Rev: 70863 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Babble-Zone-2.2
SVN: http://svn.wowace.com/root/trunk/Babble-2.2/Babble-Zone-2.2
Description: A library to provide localizations for zones.
Dependencies: AceLibrary, AceLocale-2.2
License: MIT
]]

local MAJOR_VERSION = "Babble-Zone-2.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 70863 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end

if not AceLibrary:HasInstance("AceLocale-2.2") then error(MAJOR_VERSION .. " requires AceLocale-2.2") end

local _, x = AceLibrary("AceLocale-2.2"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleZone = AceLibrary("AceLocale-2.2"):new(MAJOR_VERSION)

-- uncomment below for debug information
-- BabbleZone:EnableDebugging()

BabbleZone:RegisterTranslations("enUS", function()
	return {
		["Azeroth"] = true,
		["Eastern Kingdoms"] = true,
		["Kalimdor"] = true,
		["Outland"] = true,
		["Cosmic map"] = true,

		["Ahn'Qiraj"] = true,
		["Alterac Mountains"] = true,
		["Alterac Valley"] = true,
		["Arathi Basin"] = true,
		["Arathi Highlands"] = true,
		["Ashenvale"] = true,
		["Auberdine"] = true,
		["Azshara"] = true,
		["Badlands"] = true,
		["The Barrens"] = true,
		["Blackfathom Deeps"] = true,
		["Blackrock Depths"] = true,
		["Blackrock Mountain"] = true,
		["Blackrock Spire"] = true,
		["Blackwing Lair"] = true,
		["Blasted Lands"] = true,
		["Booty Bay"] = true,
		["Burning Steppes"] = true,
		["Darkshore"] = true,
		["Darnassus"] = true,
		["The Deadmines"] = true,
		["Deadwind Pass"] = true,
		["Deeprun Tram"] = true,
		["Desolace"] = true,
		["Dire Maul"] = true,
		["Dire Maul (East)"] = true,
		["Dire Maul (West)"] = true,
		["Dire Maul (North)"] = true,
		["Dun Morogh"] = true,
		["Durotar"] = true,
		["Duskwood"] = true,
		["Dustwallow Marsh"] = true,
		["Eastern Plaguelands"] = true,
		["Elwynn Forest"] = true,
		["Everlook"] = true,
		["Felwood"] = true,
		["Feralas"] = true,
		["The Forbidding Sea"] = true,
		["Gadgetzan"] = true,
		["Gates of Ahn'Qiraj"] = true,
		["Gnomeregan"] = true,
		["The Great Sea"] = true,
		["Grom'gol Base Camp"] = true,
		["Hall of Legends"] = true,
		["Hillsbrad Foothills"] = true,
		["The Hinterlands"] = true,
		["Hyjal"] = true,
		["Hyjal Summit"] = true,
		["Ironforge"] = true,
		["Loch Modan"] = true,
		["Lower Blackrock Spire"] = true,
		["Maraudon"] = true,
		["Menethil Harbor"] = true,
		["Molten Core"] = true,
		["Moonglade"] = true,
		["Mulgore"] = true,
		["Naxxramas"] = true,
		["Onyxia's Lair"] = true,
		["Orgrimmar"] = true,
		["Ratchet"] = true,
		["Ragefire Chasm"] = true,
		["Razorfen Downs"] = true,
		["Razorfen Kraul"] = true,
		["Redridge Mountains"] = true,
		["Ruins of Ahn'Qiraj"] = true,
		["Scarlet Monastery"] = true,
		["Scholomance"] = true,
		["Searing Gorge"] = true,
		["Shadowfang Keep"] = true,
		["Silithus"] = true,
		["Silverpine Forest"] = true,
		["The Stockade"] = true,
		["Stonetalon Mountains"] = true,
		["Stormwind City"] = true,
		["Stranglethorn Vale"] = true,
		["Stratholme"] = true,
		["Swamp of Sorrows"] = true,
		["Tanaris"] = true,
		["Teldrassil"] = true,
		["Temple of Ahn'Qiraj"] = true,
		["The Temple of Atal'Hakkar"] = true,
		["Theramore Isle"] = true,
		["Thousand Needles"] = true,
		["Thunder Bluff"] = true,
		["Tirisfal Glades"] = true,
		["Uldaman"] = true,
		["Un'Goro Crater"] = true,
		["Undercity"] = true,
		["Upper Blackrock Spire"] = true,
		["Wailing Caverns"] = true,
		["Warsong Gulch"] = true,
		["Western Plaguelands"] = true,
		["Westfall"] = true,
		["Wetlands"] = true,
		["Winterspring"] = true,
		["Zul'Farrak"] = true,
		["Zul'Gurub"] = true,

		["Champions' Hall"] = true,
		["Blade's Edge Arena"] = true,
		["Nagrand Arena"] = true,
		["Ruins of Lordaeron"] = true,
		["Twisting Nether"] = true,
		["The Veiled Sea"] = true,
		["The North Sea"] = true,
		["Armory"] = true,
		["Library"] = true,
		["Cathedral"] = true,
		["Graveyard"] = true,

		-- Burning Crusade

		-- Subzones used for displaying instances.
		["Plaguewood"] = true,
		["Hellfire Citadel"] = true,
		["Auchindoun"] = true,
		["The Bone Wastes"] = true, -- Substitute for Auchindoun, since this is what shows on the minimap.
		["Ring of Observance"] = true,
		["Coilfang Reservoir"] = true,
		["Amani Pass"] = true,

		["Azuremyst Isle"] = true,
		["Bloodmyst Isle"] = true,
		["Eversong Woods"] = true,
		["Ghostlands"] = true,
		["The Exodar"] = true,
		["Silvermoon City"] = true,
		["Shadowmoon Valley"] = true,
		["Black Temple"] = true,
		["Terokkar Forest"] = true,
		["Auchenai Crypts"] = true,
		["Mana-Tombs"] = true,
		["Shadow Labyrinth"] = true,
		["Sethekk Halls"] = true,
		["Hellfire Peninsula"] = true,
		["The Dark Portal"] = true,
		["Hellfire Ramparts"] = true,
		["The Blood Furnace"] = true,
		["The Shattered Halls"] = true,
		["Magtheridon's Lair"] = true,
		["Nagrand"] = true,
		["Zangarmarsh"] = true,
		["The Slave Pens"] = true,
		["The Underbog"] = true,
		["The Steamvault"] = true,
		["Serpentshrine Cavern"] = true,
		["Blade's Edge Mountains"] = true,
		["Gruul's Lair"] = true,
		["Netherstorm"] = true,
		["Tempest Keep"] = true,
		["The Mechanar"] = true,
		["The Botanica"] = true,
		["The Arcatraz"] = true,
		["The Eye"] = true,
		["Eye of the Storm"] = true,
		["Shattrath City"] = true,
		["Karazhan"] = true,
		["Caverns of Time"] = true,
		["Old Hillsbrad Foothills"] = true,
		["The Black Morass"] = true,
		["Night Elf Village"] = true,
		["Horde Encampment"] = true,
		["Alliance Base"] = true,
		["Zul'Aman"] = true,
		["Quel'thalas"] = true,
		["Isle of Quel'Danas"] = true,
		["Sunwell Plateau"] = true,
		["Magisters' Terrace"] = true,
	}
end)

BabbleZone:RegisterTranslations("zhCN", function()
	return {
		["Azeroth"] = "艾泽拉斯",
		["Eastern Kingdoms"] = "东部王国",
		["Kalimdor"] = "卡利姆多",
		["Outland"] = "外域",
		["Cosmic map"] = "全部地图",

		["Ahn'Qiraj"] = "安其拉",
		["Alterac Mountains"] = "奥特兰克山脉",
		["Alterac Valley"] = "奥特兰克山谷",
		["Arathi Basin"] = "阿拉希盆地",
		["Arathi Highlands"] = "阿拉希高地",
		["Ashenvale"] = "灰谷",
		["Auberdine"] = "奥伯丁",
		["Azshara"] = "艾萨拉",
		["Badlands"] = "荒芜之地",
		["The Barrens"] = "贫瘠之地",
		["Blackfathom Deeps"] = "黑暗深渊",
		["Blackrock Depths"] = "黑石深渊",
		["Blackrock Mountain"] = "黑石山",
		["Blackrock Spire"] = "黑石塔",
		["Blackwing Lair"] = "黑翼之巢",
		["Blasted Lands"] = "诅咒之地",
		["Booty Bay"] = "藏宝海湾",
		["Burning Steppes"] = "燃烧平原",
		["Darkshore"] = "黑海岸",
		["Darnassus"] = "达纳苏斯",
		["The Deadmines"] = "死亡矿井",
		["Deadwind Pass"] = "逆风小径",
		["Deeprun Tram"] = "矿道地铁",
		["Desolace"] = "凄凉之地",
		["Dire Maul"] = "厄运之槌",
		["Dire Maul (East)"] = "厄运之槌(东)",
		["Dire Maul (West)"] = "厄运之槌(西)",
		["Dire Maul (North)"] = "厄运之槌(北)",
		["Dun Morogh"] = "丹莫罗",
		["Durotar"] = "杜隆塔尔",
		["Duskwood"] = "暮色森林",
		["Dustwallow Marsh"] = "尘泥沼泽",
		["Eastern Plaguelands"] = "东瘟疫之地",
		["Elwynn Forest"] = "艾尔文森林",
		["Everlook"] = "永望镇",
		["Felwood"] = "费伍德森林",
		["Feralas"] = "菲拉斯",
		["The Forbidding Sea"] = "禁忌之海",
		["Gadgetzan"] = "加基森",
		["Gates of Ahn'Qiraj"] = "安其拉之门",
		["Gnomeregan"] = "诺莫瑞根",
		["The Great Sea"] = "无尽之海",
		["Grom'gol Base Camp"] = "格罗姆高营地",
		["Hall of Legends"] = "传说大厅",
		["Hillsbrad Foothills"] = "希尔斯布莱德丘陵",
		["The Hinterlands"] = "辛特兰",
		["Hyjal"] = "海加尔山",
		["Hyjal Summit"] = "海加尔峰",
		["Ironforge"] = "铁炉堡",
		["Loch Modan"] = "洛克莫丹",
		["Lower Blackrock Spire"] = "黑石塔（下层）",
		["Maraudon"] = "玛拉顿",
		["Menethil Harbor"] = "米奈希尔港",
		["Molten Core"] = "熔火之心",
		["Moonglade"] = "月光林地",
		["Mulgore"] = "莫高雷",
		["Naxxramas"] = "纳克萨玛斯",
		["Onyxia's Lair"] = "奥妮克希亚的巢穴",
		["Orgrimmar"] = "奥格瑞玛",
		["Ratchet"] = "棘齿城",
		["Ragefire Chasm"] = "怒焰裂谷",
		["Razorfen Downs"] = "剃刀高地",
		["Razorfen Kraul"] = "剃刀沼泽",
		["Redridge Mountains"] = "赤脊山",
		["Ruins of Ahn'Qiraj"] = "安其拉废墟",
		["Scarlet Monastery"] = "血色修道院",
		["Scholomance"] = "通灵学院",
		["Searing Gorge"] = "灼热峡谷",
		["Shadowfang Keep"] = "影牙城堡",
		["Silithus"] = "希利苏斯",
		["Silverpine Forest"] = "银松森林",
		["The Stockade"] = "监狱",
		["Stonetalon Mountains"] = "石爪山脉",
		["Stormwind City"] = "暴风城",
		["Stranglethorn Vale"] = "荆棘谷",
		["Stratholme"] = "斯坦索姆",
		["Swamp of Sorrows"] = "悲伤沼泽",
		["Tanaris"] = "塔纳利斯",
		["Teldrassil"] = "泰达希尔",
		["Temple of Ahn'Qiraj"] = "安其拉神殿",
		["The Temple of Atal'Hakkar"] = "阿塔哈卡神庙",
		["Theramore Isle"] = "塞拉摩岛",
		["Thousand Needles"] = "千针石林",
		["Thunder Bluff"] = "雷霆崖",
		["Tirisfal Glades"] = "提瑞斯法林地",
		["Uldaman"] = "奥达曼",
		["Un'Goro Crater"] = "安戈洛环形山",
		["Undercity"] = "幽暗城",
		["Upper Blackrock Spire"] = "黑石塔（上层）",
		["Wailing Caverns"] = "哀嚎洞穴",
		["Warsong Gulch"] = "战歌峡谷",
		["Western Plaguelands"] = "西瘟疫之地",
		["Westfall"] = "西部荒野",
		["Wetlands"] = "湿地",
		["Winterspring"] = "冬泉谷",
		["Zul'Farrak"] = "祖尔法拉克",
		["Zul'Gurub"] = "祖尔格拉布",

		["Champions' Hall"] = "勇士大厅",
		["Blade's Edge Arena"] = "刀锋山竞技场",
		["Nagrand Arena"] = "纳格兰竞技场",
		["Ruins of Lordaeron"] = "洛丹伦废墟",
		["Twisting Nether"] = "扭曲虚空",
		["The Veiled Sea"] = "迷雾之海",
		["The North Sea"] = "北海",
		["Armory"] = "军械库",
		["Library"] = "图书馆",
		["Cathedral"] = "教堂",
		["Graveyard"] = "墓地",

		-- Burning Crusade

		-- Subzones used for displaying instances.
		["Plaguewood"] = "病木林",
		["Hellfire Citadel"] = "地狱火堡垒",
		["Auchindoun"] = "奥金顿",
		["The Bone Wastes"] = "白骨荒野",
		["Ring of Observance"] = "仪式广场",
		["Coilfang Reservoir"] = "盘牙水库",
		["Amani Pass"] = "阿曼尼小径",

		["Azuremyst Isle"] = "秘蓝岛",
		["Bloodmyst Isle"] = "秘血岛",
		["Eversong Woods"] = "永歌森林",
		["Ghostlands"] = "幽魂之地",
		["The Exodar"] = "埃索达",
		["Silvermoon City"] = "银月城",
		["Shadowmoon Valley"] = "影月谷",
		["Black Temple"] = "黑暗神殿",
		["Terokkar Forest"] = "泰罗卡森林",
		["Auchenai Crypts"] = "奥金尼地穴",
		["Mana-Tombs"] = "法力陵墓",
		["Shadow Labyrinth"] = "暗影迷宫",
		["Sethekk Halls"] = "塞泰克大厅",
		["Hellfire Peninsula"] = "地狱火半岛",
		["The Dark Portal"] = "黑暗之门",
		["Hellfire Ramparts"] = "地狱火城墙",
		["The Blood Furnace"] = "鲜血熔炉",
		["The Shattered Halls"] = "破碎大厅",
		["Magtheridon's Lair"] = "玛瑟里顿的巢穴",
		["Nagrand"] = "纳格兰",
		["Zangarmarsh"] = "赞加沼泽",
		["The Slave Pens"] = "奴隶围栏",
		["The Underbog"] = "幽暗沼泽",
		["The Steamvault"] = "蒸汽地窟",
		["Serpentshrine Cavern"] = "毒蛇神殿",
		["Blade's Edge Mountains"] = "刀锋山",
		["Gruul's Lair"] = "格鲁尔的巢穴",
		["Netherstorm"] = "虚空风暴",
		["Tempest Keep"] = "风暴要塞",
		["The Mechanar"] = "能源舰",
		["The Botanica"] = "生态船",
		["The Arcatraz"] = "禁魔监狱",
		["The Eye"] = "风暴要塞",
		["Eye of the Storm"] = "风暴之眼",
		["Shattrath City"] = "沙塔斯城",
		["Karazhan"] = "卡拉赞",
		["Caverns of Time"] = "时光之穴",
		["Old Hillsbrad Foothills"] = "旧希尔斯布莱德丘陵",
		["The Black Morass"] = "黑色沼泽",
		["Night Elf Village"] = "暗夜精灵村庄",
		["Horde Encampment"] = "部落营地",
		["Alliance Base"] = "联盟基地",
		["Zul'Aman"] = "祖阿曼",
		["Quel'thalas"] = "奎尔萨拉斯",
		["Isle of Quel'Danas"] = "奎尔丹纳斯岛",
		["Sunwell Plateau"] = "太阳之井高地",
		["Magisters' Terrace"] = "魔导师平台",
	}
end)

BabbleZone:RegisterTranslations("zhTW", function()
	return {
		["Azeroth"] = "艾澤拉斯",
		["Eastern Kingdoms"] = "東部王國",
		["Kalimdor"] = "卡林多",
		["Outland"] = "外域",
		["Cosmic map"] = "宇宙地圖",

		["Ahn'Qiraj"] = "安其拉",
		["Alterac Mountains"] = "奧特蘭克山脈",
		["Alterac Valley"] = "奧特蘭克山谷",
		["Arathi Basin"] = "阿拉希盆地",
		["Arathi Highlands"] = "阿拉希高地",
		["Ashenvale"] = "梣谷",
		["Auberdine"] = "奧伯丁",
		["Azshara"] = "艾薩拉",
		["Badlands"] = "荒蕪之地",
		["The Barrens"] = "貧瘠之地",
		["Blackfathom Deeps"] = "黑暗深淵",
		["Blackrock Depths"] = "黑石深淵",
		["Blackrock Mountain"] = "黑石山",
		["Blackrock Spire"] = "黑石塔",
		["Blackwing Lair"] = "黑翼之巢",
		["Blasted Lands"] = "詛咒之地",
		["Booty Bay"] = "藏寶海灣",
		["Burning Steppes"] = "燃燒平原",
		["Darkshore"] = "黑海岸",
		["Darnassus"] = "達納蘇斯",
		["The Deadmines"] = "死亡礦坑",
		["Deadwind Pass"] = "逆風小徑",
		["Deeprun Tram"] = "礦道地鐵",
		["Desolace"] = "淒涼之地",
		["Dire Maul"] = "厄運之槌",
		["Dire Maul (East)"] = "厄運之槌 - 東",
		["Dire Maul (West)"] = "厄運之槌 - 西",
		["Dire Maul (North)"] = "厄運之槌 - 北",
		["Dun Morogh"] = "丹莫洛",
		["Durotar"] = "杜洛塔",
		["Duskwood"] = "暮色森林",
		["Dustwallow Marsh"] = "塵泥沼澤",
		["Eastern Plaguelands"] = "東瘟疫之地",
		["Elwynn Forest"] = "艾爾文森林",
		["Everlook"] = "永望鎮",
		["Felwood"] = "費伍德森林",
		["Feralas"] = "菲拉斯",
		["The Forbidding Sea"] = "禁忌之海",
		["Gadgetzan"] = "加基森",
		["Gates of Ahn'Qiraj"] = "安其拉之門",
		["Gnomeregan"] = "諾姆瑞根",
		["The Great Sea"] = "無盡之海",
		["Grom'gol Base Camp"] = "格羅姆高營地",
		["Hall of Legends"] = "傳說大廳",
		["Hillsbrad Foothills"] = "希爾斯布萊德丘陵",
		["The Hinterlands"] = "辛特蘭",
		["Hyjal"] = "海加爾山",
		["Hyjal Summit"] = "海加爾山",
		["Ironforge"] = "鐵爐堡",
		["Loch Modan"] = "洛克莫丹",
		["Lower Blackrock Spire"] = "低階黑石塔",
		["Maraudon"] = "瑪拉頓",
		["Menethil Harbor"] = "米奈希爾港",
		["Molten Core"] = "熔火之心",
		["Moonglade"] = "月光林地",
		["Mulgore"] = "莫高雷",
		["Naxxramas"] = "納克薩瑪斯",
		["Onyxia's Lair"] = "奧妮克希亞的巢穴",
		["Orgrimmar"] = "奧格瑪",
		["Ratchet"] = "棘齒城",
		["Ragefire Chasm"] = "怒焰裂谷",
		["Razorfen Downs"] = "剃刀高地",
		["Razorfen Kraul"] = "剃刀沼澤",
		["Redridge Mountains"] = "赤脊山",
		["Ruins of Ahn'Qiraj"] = "安其拉廢墟",
		["Scarlet Monastery"] = "血色修道院",
		["Scholomance"] = "通靈學院",
		["Searing Gorge"] = "灼熱峽谷",
		["Shadowfang Keep"] = "影牙城堡",
		["Silithus"] = "希利蘇斯",
		["Silverpine Forest"] = "銀松森林",
		["The Stockade"] = "監獄",
		["Stonetalon Mountains"] = "石爪山脈",
		["Stormwind City"] = "暴風城",
		["Stranglethorn Vale"] = "荊棘谷",
		["Stratholme"] = "斯坦索姆",
		["Swamp of Sorrows"] = "悲傷沼澤",
		["Tanaris"] = "塔納利斯",
		["Teldrassil"] = "泰達希爾",
		["Temple of Ahn'Qiraj"] = "安其拉神廟",
		["The Temple of Atal'Hakkar"] = "阿塔哈卡神廟",
		["Theramore Isle"] = "塞拉摩島",
		["Thousand Needles"] = "千針石林",
		["Thunder Bluff"] = "雷霆崖",
		["Tirisfal Glades"] = "提里斯法林地",
		["Uldaman"] = "奧達曼",
		["Un'Goro Crater"] = "安戈洛環形山",
		["Undercity"] = "幽暗城",
		["Upper Blackrock Spire"] = "高階黑石塔",
		["Wailing Caverns"] = "哀嚎洞穴",
		["Warsong Gulch"] = "戰歌峽谷",
		["Western Plaguelands"] = "西瘟疫之地",
		["Westfall"] = "西部荒野",
		["Wetlands"] = "濕地",
		["Winterspring"] = "冬泉谷",
		["Zul'Farrak"] = "祖爾法拉克",
		["Zul'Gurub"] = "祖爾格拉布",

		["Champions' Hall"] = "勇士大廳",
		["Blade's Edge Arena"] = "劍刃競技場",
		["Nagrand Arena"] = "納葛蘭競技場",
		["Ruins of Lordaeron"] = "羅德隆廢墟",
		["Twisting Nether"] = "扭曲虛空",
		["The Veiled Sea"] = "迷霧之海",
		["The North Sea"] = "北方海岸",
		["Armory"] = "軍械庫",
		["Library"] = "圖書館",
		["Cathedral"] = "教堂",
		["Graveyard"] = "墓地",

		-- Burning Crusade

		-- Subzones used for displaying instances.
		["Plaguewood"] = "病木林",
		["Hellfire Citadel"] = "地獄火堡壘",
		["Auchindoun"] = "奧齊頓",
		["The Bone Wastes"] = "白骨荒野", -- Substitute for Auchindoun, since this is what shows on the minimap.
		["Ring of Observance"] = "儀式競技場",
		["Coilfang Reservoir"] = "盤牙洞穴",
		["Amani Pass"] = "阿曼尼小徑",

		["Azuremyst Isle"] = "藍謎島",
		["Bloodmyst Isle"] = "血謎島",
		["Eversong Woods"] = "永歌森林",
		["Ghostlands"] = "鬼魂之地",
		["The Exodar"] = "艾克索達",
		["Silvermoon City"] = "銀月城",
		["Shadowmoon Valley"] = "影月谷",
		["Black Temple"] = "黑暗神廟",
		["Terokkar Forest"] = "泰洛卡森林",
		["Auchenai Crypts"] = "奧奇奈地穴",
		["Mana-Tombs"] = "法力墓地",
		["Shadow Labyrinth"] = "暗影迷宮",
		["Sethekk Halls"] = "塞司克大廳",
		["Hellfire Peninsula"] = "地獄火半島",
		["The Dark Portal"] = "黑暗之門",
		["Hellfire Ramparts"] = "地獄火壁壘",
		["The Blood Furnace"] = "血熔爐",
		["The Shattered Halls"] = "破碎大廳",
		["Magtheridon's Lair"] = "瑪瑟里頓的巢穴",
		["Nagrand"] = "納葛蘭",
		["Zangarmarsh"] = "贊格沼澤",
		["The Slave Pens"] = "奴隸監獄",
		["The Underbog"] = "深幽泥沼",
		["The Steamvault"] = "蒸汽洞窟",
		["Serpentshrine Cavern"] = "毒蛇神殿洞穴",
		["Blade's Edge Mountains"] = "劍刃山脈",
		["Gruul's Lair"] = "戈魯爾之巢",
		["Netherstorm"] = "虛空風暴",
		["Tempest Keep"] = "風暴要塞",
		["The Mechanar"] = "麥克納爾",
		["The Botanica"] = "波塔尼卡",
		["The Arcatraz"] = "亞克崔茲",
		["The Eye"] = "風暴要塞",
		["Eye of the Storm"] = "暴風之眼",
		["Shattrath City"] = "撒塔斯城",
		["Karazhan"] = "卡拉贊",
		["Caverns of Time"] = "時光之穴",
		["Old Hillsbrad Foothills"] = "希爾斯布萊德丘陵舊址",
		["The Black Morass"] = "黑色沼澤",
		["Night Elf Village"] = "夜精靈村",
		["Horde Encampment"] = "部落營地",
		["Alliance Base"] = "聯盟營地",
		["Zul'Aman"] = "祖阿曼",
		["Quel'thalas"] = "奎爾薩拉斯",
		["Isle of Quel'Danas"] = "奎爾達納斯之島",
		["Sunwell Plateau"] = "太陽之井高地",
		["Magisters' Terrace"] = "博學者殿堂",
	}
end)

BabbleZone:Debug()
BabbleZone:SetStrictness(true)

AceLibrary:Register(BabbleZone, MAJOR_VERSION, MINOR_VERSION)
BabbleZone = nil