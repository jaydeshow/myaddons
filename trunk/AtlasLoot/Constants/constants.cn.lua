﻿-- [[
-- Last Updated: 7/9/2008
-- Initial translation by: 560889223
-- Maintained by: Diablohu
-- Credits to: Kurax Kuang (gmmgmm at gmail.com)
-- http://www.dreamgen.cn
-- ]]

local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

AL:RegisterTranslations("zhCN", function() return {
    --Text strings for UI objects
    --["AtlasLoot"] = "",
    ["No match found for"] = "未找到物品",
    ["Search"] = "搜索",
    ["Clear"] = "重置",
    ["Select Loot Table"] = "选择掉落表",
    ["Select Sub-Table"] = "选择二级表",
    ["Drop Rate: "] = "掉落率: ",
    ["DKP"] = "DKP",
    ["Priority:"] = "优先: ",
    ["Click boss name to view loot."] = "点击首领名以浏览掉落",
    ["Various Locations"] = "多个位置",
    ["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "该窗口只是一个掉落浏览器。若想同时查看地图，请安装 Atlas 或 Alphamap 插件。",
    ["Toggle AL Panel"] = "AtlasLoot 面板",
    [" is safe."] = "的连接是安全的。",
    ["Server queried for "] = "已向服务器申请查询",
    [".  Right click on any other item to refresh the loot page."] = "。右键点击其他物品可刷新物品列表。",
    ["Back"] = "返回",
    ["Level 60"] = "等级 60",
    ["Level 70"] = "等级 70",
    ["|cffff0000(unsafe)"] = "|cffff0000(不安全)",
    ["Misc"] = "其他",
    ["Rewards"] = "奖励",
    ["Heroic Mode"] = "英雄模式",
    ["Normal Mode"] = "普通模式",
    ["Raid"] = "团队",
    ["Factions - Azeroth"] = "阵营 - 艾泽拉斯",
    ["Factions - Outland"] = "阵营 - 外域",
    ["Factions - Shattrath City"] = "阵营 - 沙塔斯城",
    ["Pre-Burning Crusade"] = "《燃烧的远征》之前",
    ["Post-Burning Crusade"] = "《燃烧的远征》之后",
    ["Choose Table ..."] = "请选择……",
    ["Close Menu"] = "关闭",
    ["Unknown"] = "未知",
    ["Skill Required:"] = "需要技能：",
    ["QuickLook"] = "快捷浏览",
    ["Add to QuickLooks:"] = "添加到快捷浏览",
    ["Assign this loot table\n to QuickLook"] = "将该掉落表添加到快捷浏览中",
	["Req. Rating:"] = "需要等级",  --Shorthand for 'Required Rating' for the personal/team ratings in Arena S4
    ["Query Server"] = "查询物品",
    ["Classic Instances"] = "旧世界副本",
    ["BC Instances"] = "燃烧的远征副本",
    ["Burning Crusade"] = "燃烧的远征",

    --Text for Options Panel
    ["Atlasloot Options"] = "Atlasloot 设置",
    ["Safe Chat Links |cff1eff00(recommended)|r"] = "使用安全物品连接 |cff1eff00(推荐)|r",
    ["Enable all Chat Links |cffff0000(use at own risk)|r"] = "使用所有连接 |cffff0000(有掉线风险)|r",
    ["Default Tooltips"] = "默认提示样式",
    ["Lootlink Tooltips"] = "Lootlink 提示样式",
    ["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dLootlink 提示样式",
    ["ItemSync Tooltips"] = "ItemSync 提示样式",
    ["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dItemSync 提示样式|r",
    ["Use EquipCompare"] = "使用装备对比",
    ["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9d使用装备对比|r",
    ["Show Comparison Tooltips"] = "显示装备对比",
    ["Make Loot Table Opaque"] = "禁用物品列表背景透明",
    ["Show itemIDs at all times"] = "永远显示物品ID",
    ["Hide AtlasLoot Panel"] = "隐藏 AtlasLoot 面板",
    ["Show Minimap Button"] = "显示小地图图标",
    ["Set Minimap Button Position"] = "设置小地图图标位置",
    ["Suppress text spam when querying items"] = "查询物品时不显示提示信息",
    ["Notify me when a LoD Module is loaded"] = "当物品数据模块载入时进行提示",
    ["Load all loot modules at startup"] = "在启动时载入所有物品数据模块",
    ["AutoQuery items on loot tables |cffff0000(disconnection risk)|r"] = "打开掉落表后自动进行查询 |cffff0000(有掉线风险)|r",
    ["Done"] = "确定",
    ["WishList"] = "装备需求表",
    ["Search Result: %s"] = "搜索结果：%s",
    ["Last Result"] = "上次搜索",
    ["Search on"] = "搜索于",
    ["All modules"] = "全部模块",
    ["If checked, AtlasLoot will load and search across all the modules."] = "如果选中，AtlasLoot会载入并扫描所有的模块。",
    ["Search options"] = "搜索选项",
    ["Partial matching"] = "部分匹配",
    ["If checked, AtlasLoot search item names for a partial match."] = "如果选中，AtlasLoot会将输入文字作为物品名称的一部分进行匹配。",
    ["You don't have any module selected to search on!"] = "你没有选择任何用于搜索的模块。",
    --The next 4 lines are the tooltip for the Server Query Button
    --The translation doesn't have to be literal, just re-write the
    --sentences as you would naturally and break them up into 4 roughly
    --equal lines.
    ["Queries the server for all items"] = "向服务器查询本页",
    ["on this page. The items will be"] = "中的所有物品链接",
    ["refreshed when you next mouse"] = "物品将会在鼠标",
    ["over them."] = "下次滑过时刷新",

    --Slash commands
    ["reset"] = "reset",
    ["options"] = "options",
    ["Reset complete!"] = "重置完成",

    --Error Messages and warnings
    ["AtlasLoot Error!"] = "AtlasLoot 发生错误！",
    ["WishList Full!"] = "装备需求表已满！",
    [" added to the WishList."] = " 被添加到装备需求表",
    [" already in the WishList!"] = " 已经在装备需求表里了",
    [" deleted from the WishList."] = " 已从装备需求表删除",

    --Incomplete Table Registry error message
    [" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = "没有被列出，请将该错误信息发送到 AtlasLoot 官方论坛：http://www.atlasloot.net。",

    --LoD Module disabled or missing
    [" is unavailable, the following load on demand module is required: "] = "不可用，需要以下需求时载入型模块：",

    --LoD Module load sequence could not be completed
    ["Status of the following module could not be determined: "] = "以下模块的类型不可被确定：",

    --LoD Module required has loaded, but loot table is missing
    [" could not be accessed, the following module may be out of date: "] = "无法进行操作，以下模块可能已过期：",

	--LoD module loaded successfully
    ["sucessfully loaded."] = "已成功载入",

    --Need a big dataset for searching
    ["Loading available tables for searching"] = "在已载入的物品数据中进行搜索",

    --All Available modules loaded
    ["All Available Modules Loaded"] = "所有可用数据模块已载入",

    --Minimap Button
    ["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00单击|r 浏览掉落表",
    ["|cffff0000Right-Click|r View Options"] = "|cffff0000右键点击|r 进行设置",
    ["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shift-单击|r 进行设置",
    ["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffcccccc左键拖动|r 移动小地图按钮",

    --AtlasLoot Panel
    ["Options"] = "设置",
    ["Collections"] = "套装/收藏",
    ["Factions"] = "阵营",
    ["World Events"] = "世界事件",
    ["Load Modules"] = "载入所有数据",
    ["Crafting"] = "制造的物品",

    --First time user
    ["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = "欢迎使用 Atlasloot Enhanced，请花少许时间进行参数设置",
    ["New feature in 4.02.01: Type '/atlasloot options' to bring up the options menu and '/atlasloot reset' to reset AtlasLoot after a disconnect."] = "在4.02.01以上版本: 输入 '/atlasloot options'可以打开设置菜单，输入'/atlasloot reset'可以在登出游戏后重置AtlasLoot",
    ["New feature in 4.03.00: Introducing the Wishlist!  Simply alt-click on any item to add it to the wishlist.  To delete an item from the wishlist, open up your wishlist and alt-click the item to remove it.  It's that simple.  Buttons to view the wishlist have been added to the Atlas interface and the loot browser."] = "在4.03.00版本中添加了装备需求表！你可以按住Alt并点击任何物品的链接来添加它到装备需求表中。打开装备需求表，按住Alt并点击物品链接可以将它从表中删除。你可以点击Atlas界面内掉落浏览器上的相应按钮来打开装备需求表。",
    ["New feature in 4.05.00: Advanced searching functionality is now available. You can type in a partial item name, for example typing 'elixir' gives all items in the database with 'elixir' in the name.  Big thanks to Kurax for his help."] = "4.05.00新功能：高级搜索功能。现在可以使用模糊搜索方式，如在搜索框中输入“药剂”即可搜索艘有物品名中带有“药剂”字样的物品。非常感谢 Kurax 的帮助。",
    ["New feature in 4.05.00: All professions are now included in the AtlasLoot_Crafting module."] = "4.05.00新功能：所有专业技能信息现在都包含在 AtlasLoot_Crafting 模块中。",
    ["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = "欢迎使用 Atlasloot Enhanced。请花少许时间进来设置提示与物品连接的方式。\n\n  以后可以输入“/atlasloot”再次显示该设置窗口。",
    ["Setup"] = "设置",

    --Old Atlas Detected
    ["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "AtlasLoot 检测到您正在使用的 Atlas 插件的版本与 AtlasLoot 需要的版本（",
    [").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = "）不符。该情况下可能会频繁出现插件错误信息。鉴于此，请您立刻访问 http://www.atlasmod.com 或 http://www.dreamgen.cn 更新您的 Atlas 版本。",
    ["OK"] = "确定",
    ["Incompatible Atlas Detected"] = "检测到不兼容的 Atlas",

    --Unsafe item tooltip
    ["Unsafe Item"] = "不安全的物品",
    ["Item Unavailable"] = "物品不可用",
    ["ItemID:"] = "itemID: ",
    ["This item is not available on your server or your battlegroup yet."] = "该物品尚未在你所在的服务器或战场组中出现。",
    ["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] = "该物品连接不安全。若想得知此物品的属性又想避免掉线问题，您需要在游戏内见过一次该物品。这是暴雪在1.10版本中做出的强制性改动。",
    ["You can right-click to attempt to query the server.  You may be disconnected."] = "您可以右键点击该物品以向服务器查询，但这样做有可能会与服务器断开连接。",

    --Misc Inventory related words
    ["Mount"] = "坐骑",
    ["Enchant"] = "附魔",
    ["Trade Goods"] = "杂货",
    ["Scope"] = "瞄准镜",
    ["Pet"] = "宠物",
    ["Darkmoon Faire Card"] = "暗月马戏团卡片",
    ["Book"] = "书籍",
    ["Banner"] = "旗帜",
    ["Set"] = "套装",
    ["Token"] = "兑换物",
    ["Crafting Reagent"] = "商业原料",
    ["Skinning Knife"] = "剥皮刀",
    ["Herbalism Knife"] = "采药刀",
    ["Fish"] = "鱼",
    ["Combat Pet"] = "战斗宠物",
    ["Fireworks"] = "焰火",
	    
    --Extra inventory stuff
    ["Cloak"] = "披风",
    ["Weapons"] = "武器",

    --Labels for loot descriptions
    ["Classes:"] = "职业:",
    ["This Item Begins a Quest"] = "将触发一个任务",
    ["Quest Item"] = "任务物品",
    ["Quest Reward"] = "任务奖励",
    ["Shared"] = "共享掉落",
    ["Unique"] = "唯一",
    ["Right Half"] = "右半部分",
    ["Left Half"] = "左半部分",
    ["28 Slot Soul Shard"] = "28格灵魂袋",
    ["20 Slot"] = "20格",
    ["18 Slot"] = "18格",
    ["16 Slot"] = "16格",
    ["10 Slot"] = "10格",
    ["(has random enchantment)"] = "(随机附魔)",
    ["Use to purchase rewards"] = "用以购买奖励",
    ["Use to purchase rewards (Horde)"] = "用以购买奖励 (部落)",
    ["Use to purchase rewards (Alliance)"] = "用以购买奖励 (联盟)",
    ["World Bosses"] = "世界首领",
    ["Reputation Factions"] = "声望阵营",
    ["Sets/Collections"] = "套装/收藏",
    ["Card Game Item"] = "卡片游戏奖品",
    ["Tier 1"] = "等级1套装",
    ["Tier 2"] = "等级2套装",
    ["Tier 4"] = "等级4套装",
    ["Tier 5"] = "等级5套装",
    ["Tier 6"] = "等级6套装",
    ["Arena Reward"] = "竞技场奖励",
    ["Conjured Item"] = "魔法制造的物品",
    ["Used to summon boss"] = "用以召唤首领",
    ["Phase 1"] = "第一阶段",
    ["Phase 2"] = "第二阶段",
    ["Phase 3"] = "第三阶段",
    ["Fire"] = "火",
    ["Water"] = "水",
    ["Wind"] = "风",
    ["Earth"] = "地",
    ["Master Angler"] = "钓鱼大师",
    ["First Prize"] = "第一名奖励",
    ["Rare Fish Rewards"] = "稀有鱼种奖励",
    ["Rare Fish"] = "稀有鱼种",
    ["Tradable against sunmote + item above"] = "用太阳之尘和上个物品兑换得到",
	["Rare"] = "稀有",
	["Heroic"] = "英雄模式",
	["Summon"] = "召唤",
	["Random"] = "随机",
	["Weapons"] = "武器",

    --Card Game Decks and descriptions
    ["Upper Deck Card Game Items"] = "集换式卡牌游戏奖品",
    ["Heroes of Azeroth"] = "艾泽拉斯英雄传",
    --["Through The Dark Portal"] = true,
    --["Fires of Outland"] = true,
	--["Servants of the Betrayer"] = true,
    --["Hunt for Illidan"] = true,
	--["Drums of Wars"] = true,
    ["Loot Card Items"] = "刮刮卡奖品",
    ["UDE Items"] = "UDE积分奖品",
    ["Landro Longshot"] = "远射兰铎",
    ["Thunderhead Hippogryph"] = "雷首角鹰兽",
    ["Saltwater Snapjaw"] = "海水钳嘴龟",
    ["King Mukla"] = "穆克拉",
    ["Rest and Relaxation"] = "休息与放松",
    ["Fortune Telling"] = "算命",
    ["Goblin Gumbo"] = "地精杂烩",
    --["Gone Fishin'"] = true,
    ["Spectral Tiger"] = "幽灵虎",
	--["March of the Legion"] = true,
	["Kiting"] = "风筝",
	["Robotic Homing Chicken"] = "自动导航机器小鸡",
	["Paper Airplane"] = "纸飞机",
    ["Papa Hummel's Old-fashioned Pet Biscuit"] = "修默老爹的宠物饼干",
    ["Personal Weather Machine"] = "个人天气制造机",
    ["X-51 Nether-Rocket"] = "X-51虚空火箭",
    ["The Footsteps of Illidan"] = "伊利丹的脚步",
    --["Disco Inferno!"] = true,
    --["Ethereal Plunderer"] = true,

    --Battleground Brackets
    ["Misc. Rewards"] = "其他奖励",
    ["Superior Rewards"] = "精良级别奖励",
    ["Epic Rewards"] = "史诗级别奖励",
    ["Level 10-19 Rewards"] = "等级10-19奖励",
    ["Level 20-29 Rewards"] = "等级20-29奖励",
    ["Level 30-39 Rewards"] = "等级30-39奖励",
    ["Level 40-49 Rewards"] = "等级40-49奖励",
    ["Level 50-59 Rewards"] = "等级50-59奖励",
    ["Level 60 Rewards"] = "等级60奖励",

    --Brood of Nozdormu Paths
    ["Path of the Conqueror"] = "征服者之路",
    ["Path of the Invoker"] = "祈求者之路",
    ["Path of the Protector"] = "保护者之路",

    --Violet Eye Paths
    ["Path of the Violet Protector"] = "紫罗兰庇护者之路",
    ["Path of the Violet Mage"] = "紫罗兰大法师之路",
    ["Path of the Violet Assassin"] = "紫罗兰刺客之路",
    ["Path of the Violet Restorer"] = "紫罗兰治愈者之路",

    --AQ Opening Event
    ["Red Scepter Shard"] = "红色节杖碎片",
    ["Blue Scepter Shard"] = "蓝色节杖碎片",
    ["Green Scepter Shard"] = "绿色节杖碎片",
    ["Scepter of the Shifting Sands"] = "流沙节杖",

    --World PvP
    ["Hellfire Fortifications"] = "防御工事",
    ["Twin Spire Ruins"] = "双塔废墟",
    ["Spirit Towers"] = "灵魂之塔",
    ["Halaa"] = "哈兰",

    --Karazhan Opera Event Headings
    ["Shared Drops"] = "共享掉落",
    ["Romulo & Julianne"] = "罗密欧与朱丽叶",
    ["Wizard of Oz"] = "绿野仙踪",
    ["Red Riding Hood"] = "小红帽",

    --Karazhan Animal Boss Types
    ["Spider"] = "蜘蛛",
    ["Darkhound"] = "黑暗猎犬",
    ["Bat"] = "蝙蝠",

    --ZG Tokens
    ["Primal Hakkari Kossack"] = "原始哈卡莱套索",
    ["Primal Hakkari Shawl"] = "原始哈卡莱披肩",
    ["Primal Hakkari Bindings"] = "原始哈卡莱护腕",
    ["Primal Hakkari Sash"] = "原始哈卡莱腰带",
    ["Primal Hakkari Stanchion"] = "原始哈卡莱直柱",
    ["Primal Hakkari Aegis"] = "原始哈卡莱之盾",
    ["Primal Hakkari Girdle"] = "原始哈卡莱束带",
    ["Primal Hakkari Armsplint"] = "原始哈卡莱护臂",
    ["Primal Hakkari Tabard"] = "原始哈卡莱徽章",

    --AQ20 Tokens
    ["Qiraji Ornate Hilt"] = "其拉装饰刀柄",
    ["Qiraji Martial Drape"] = "其拉军用披风",
    ["Qiraji Magisterial Ring"] = "其拉将领戒指",
    ["Qiraji Ceremonial Ring"] = "其拉典礼戒指",
    ["Qiraji Regal Drape"] = "其拉帝王披风",
    ["Qiraji Spiked Hilt"] = "其拉尖刺刀柄",

    --AQ40 Tokens
    ["Qiraji Bindings of Dominance"] = "其拉统御腕轮",
    ["Qiraji Bindings of Command"] = "其拉命令腕轮",
    ["Vek'nilash's Circlet"] = "维克尼拉斯的头饰",
    ["Vek'lor's Diadem"] = "维克洛尔的王冠",
    ["Ouro's Intact Hide"] = "奥罗的外皮",
    ["Skin of the Great Sandworm"] = "巨型沙虫的皮",
    ["Husk of the Old God"] = "上古之神的外鞘",
    ["Carapace of the Old God"] = "上古之神的甲壳",

    --Blacksmithing Crafted Sets
    ["Imperial Plate"] = "君王板甲",
    ["The Darksoul"] = "黑暗之魂",
    ["Fel Iron Plate"] = "魔铁板甲",
    ["Adamantite Battlegear"] = "精金战甲",
    ["Flame Guard"] = "烈焰卫士",
    ["Enchanted Adamantite Armor"] = "魔化精金套装",
    ["Khorium Ward"] = "氪金套装",
    ["Faith in Felsteel"] = "魔钢的信仰",
    ["Burning Rage"] = "钢铁之怒",
    ["Bloodsoul Embrace"] = "血魂的拥抱",
    ["Fel Iron Chain"] = "魔铁链甲",

    --Tailoring Crafted Sets
    ["Bloodvine Garb"] = "血藤",
    ["Netherweave Vestments"] = "灵纹套装",
    ["Imbued Netherweave"] = "魔化灵纹套装",
    ["Arcanoweave Vestments"] = "奥法交织套装",
    ["The Unyielding"] = "不屈的力量",
    ["Whitemend Wisdom"] = "白色治愈",
    ["Spellstrike Infusion"] = "法术打击",
    ["Battlecast Garb"] = "战斗施法套装",
    ["Soulcloth Embrace"] = "灵魂布之拥",
    ["Primal Mooncloth"] = "原始月布",
    ["Shadow's Embrace"] = "暗影之拥",
    ["Wrath of Spellfire"] = "魔焰之怒",

    --Leatherworking Crafted Sets
    ["Volcanic Armor"] = "火山",
    ["Ironfeather Armor"] = "铁羽护甲",
    ["Stormshroud Armor"] = "雷暴",
    ["Devilsaur Armor"] = "魔暴龙护甲",
    ["Blood Tiger Harness"] = "血虎",
    ["Primal Batskin"] = "原始蝙蝠皮套装",
    ["Wild Draenish Armor"] = "野性德莱尼套装",
    ["Thick Draenic Armor"] = "厚重德莱尼套装",
    ["Fel Skin"] = "魔能之肤",
    ["Strength of the Clefthoof"] = "裂蹄之力",
    ["Green Dragon Mail"] = "绿龙锁甲",
    ["Blue Dragon Mail"] = "蓝龙锁甲",
    ["Black Dragon Mail"] = "黑龙锁甲",
    ["Scaled Draenic Armor"] = "缀鳞德拉诺套装",
    ["Felscale Armor"] = "魔鳞套装",
    ["Felstalker Armor"] = "魔能猎手",
    ["Fury of the Nether"] = "虚空之怒",
    ["Primal Intent"] = "原始打击",
    ["Windhawk Armor"] = "风鹰",
    ["Netherscale Armor"] = "虚空之鳞",
    ["Netherstrike Armor"] = "虚空打击",

    --Vanilla WoW Sets
    ["Defias Leather"] = "迪菲亚皮甲",
    ["Embrace of the Viper"] = "毒蛇的拥抱",
    ["Chain of the Scarlet Crusade"] = "血色十字军链甲",
    ["The Gladiator"] = "角斗士",
    ["Ironweave Battlesuit"] = "铁纹作战套装",
    ["Necropile Raiment"] = "骨堆",
    ["Cadaverous Garb"] = "苍白",
    ["Bloodmail Regalia"] = "血链",
    ["Deathbone Guardian"] = "亡者之骨",
    ["The Postmaster"] = "邮差",
    ["Scourge Invasion"] = "天灾入侵",
    ["Regalia of Undead Cleansing"] = "亡灵净化者",
    ["Undead Slayer's Armor"] = "亡灵屠戮者的护甲",
    ["Garb of the Undead Slayer"] = "亡灵屠戮者的装备",
    ["Battlegear of Undead Slaying"] = "亡灵毁灭者",
    ["Shard of the Gods"] = "天神碎片",
    ["Zul'Gurub Rings"] = "祖尔格拉布戒指",
    ["Major Mojo Infusion"] = "极效魔精套装",
    ["Overlord's Resolution"] = "督军的决心",
    ["Prayer of the Primal"] = "远古祷言",
    ["Zanzil's Concentration"] = "赞吉尔的专注",
    ["Spirit of Eskhandar"] = "艾斯卡达尔之魂",
    ["The Twin Blades of Hakkari"] = "哈卡莱双刃",
    ["Primal Blessing"] = "原始祝福",
    ["Dal'Rend's Arms"] = "雷德双刀",
    ["Spider's Kiss"] = "蜘蛛之吻",

    --The Burning Crusade Sets
    ["Latro's Flurry"] = "拉托恩的狂怒",
    ["The Twin Stars"] = "双子星",
    ["The Twin Blades of Azzinoth"] = "艾辛洛斯双刃",

    --ZG Sets
    ["Haruspex's Garb"] = "占卜师套装",
    ["Predator's Armor"] = "捕猎者套装",
    ["Illusionist's Attire"] = "幻术师套装",
    ["Freethinker's Armor"] = "思考者护甲",
    ["Confessor's Raiment"] = "忏悔者衣饰",
    ["Madcap's Outfit"] = "狂妄者套装",
    ["Augur's Regalia"] = "预言者套装",
    ["Demoniac's Threads"] = "恶魔师护甲",
    ["Vindicator's Battlegear"] = "辩护者重甲",

    --AQ20 Sets
    ["Symbols of Unending Life"] = "不灭的生命",
    ["Trappings of the Unseen Path"] = "隐秘的通途",
    ["Trappings of Vaulted Secrets"] = "魔法的秘密",
    ["Battlegear of Eternal Justice"] = "永恒的公正",
    ["Finery of Infinite Wisdom"] = "无尽的智慧",
    ["Emblems of Veiled Shadows"] = "笼罩的阴影",
    ["Gift of the Gathering Storm"] = "聚集的风暴",
    ["Implements of Unspoken Names"] = "禁断的邪语",
    ["Battlegear of Unyielding Strength"] = "坚定的力量",

    --AQ40 Sets
    ["Genesis Raiment"] = "起源套装",
    ["Striker's Garb"] = "攻击者",
    ["Enigma Vestments"] = "神秘套装",
    ["Avenger's Battlegear"] = "复仇者",
    ["Garments of the Oracle"] = "神谕者",
    ["Deathdealer's Embrace"] = "死亡执行者的拥抱",
    ["Stormcaller's Garb"] = "风暴召唤者",
    ["Doomcaller's Attire"] = "厄运召唤者",
    ["Conqueror's Battlegear"] = "征服者",

    --Dungeon 1 Sets
    ["Wildheart Raiment"] = "野性之心",
    ["Beaststalker Armor"] = "野兽追猎者",
    ["Magister's Regalia"] = "博学者的徽记",
    ["Lightforge Armor"] = "光铸护甲",
    ["Vestments of the Devout"] = "虔诚",
    ["Shadowcraft Armor"] = "迅影",
    ["The Elements"] = "元素",
    ["Dreadmist Raiment"] = "鬼雾",
    ["Battlegear of Valor"] = "勇气",

    --Dungeon 2 Sets
    ["Feralheart Raiment"] = "狂野之心",
    ["Beastmaster Armor"] = "兽王",
    ["Sorcerer's Regalia"] = "巫师",
    ["Soulforge Armor"] = "魂铸",
    ["Vestments of the Virtuous"] = "坚贞",
    ["Darkmantle Armor"] = "暗幕",
    ["The Five Thunders"] = "五雷",
    ["Deathmist Raiment"] = "死雾",
    ["Battlegear of Heroism"] = "英勇",

    --Dungeon 3 Sets
    ["Hallowed Raiment"] = "圣徒",
    ["Incanter's Regalia"] = "魔咒师",
    ["Mana-Etched Regalia"] = "法力蚀刻魔装",
    ["Oblivion Raiment"] = "湮灭",
    ["Assassination Armor"] = "刺杀",
    ["Moonglade Raiment"] = "月光林地",
    ["Wastewalker Armor"] = "废土行者",
    ["Beast Lord Armor"] = "巨兽之王",
    ["Desolation Battlegear"] = "荒芜战甲",
    ["Tidefury Raiment"] = "潮汐之怒",
    ["Bold Armor"] = "鲁莽套装",
    ["Doomplate Battlegear"] = "末日板甲",
    ["Righteous Armor"] = "正义",

    --Tier 1 Sets
    ["Cenarion Raiment"] = "塞纳里奥",
    ["Giantstalker Armor"] = "巨人追猎者",
    ["Arcanist Regalia"] = "奥术师",
    ["Lawbringer Armor"] = "秩序之源",
    ["Vestments of Prophecy"] = "预言",
    ["Nightslayer Armor"] = "夜幕杀手",
    ["The Earthfury"] = "大地之怒",
    ["Felheart Raiment"] = "恶魔之心",
    ["Battlegear of Might"] = "力量",

    --Tier 2 Sets
    ["Stormrage Raiment"] = "怒风",
    ["Dragonstalker Armor"] = "巨龙追猎者",
    ["Netherwind Regalia"] = "灵风",
    ["Judgement Armor"] = "审判",
    ["Vestments of Transcendence"] = "卓越",
    ["Bloodfang Armor"] = "血牙",
    ["The Ten Storms"] = "无尽风暴",
    ["Nemesis Raiment"] = "复仇",
    ["Battlegear of Wrath"] = "愤怒",

    --Tier 3 Sets
    ["Dreamwalker Raiment"] = "梦游者",
    ["Cryptstalker Armor"] = "地穴追猎者",
    ["Frostfire Regalia"] = "霜火",
    ["Redemption Armor"] = "救赎",
    ["Vestments of Faith"] = "信仰",
    ["Bonescythe Armor"] = "骨镰",
    ["The Earthshatterer"] = "碎地者",
    ["Plagueheart Raiment"] = "瘟疫之心",
    ["Dreadnaught's Battlegear"] = "无畏",

    --Tier 4 Sets
    ["Malorne Harness"] = "玛洛恩甲胄",
    ["Malorne Raiment"] = "玛洛恩圣装",
    ["Malorne Regalia"] = "玛洛恩法衣",
    ["Demon Stalker Armor"] = "恶魔追猎者",
    ["Aldor Regalia"] = "奥尔多魔装",
    ["Justicar Armor"] = "公正护甲",
    ["Justicar Battlegear"] = "公正战甲",
    ["Justicar Raiment"] = "公正圣装",
    ["Incarnate Raiment"] = "化身圣装",
    ["Incarnate Regalia"] = "化身法衣",
    ["Netherblade Set"] = "虚空刀锋",
    ["Cyclone Harness"] = "飓风甲胄",
    ["Cyclone Raiment"] = "飓风圣装",
    ["Cyclone Regalia"] = "飓风法衣",
    ["Voidheart Raiment"] = "虚空之心",
    ["Warbringer Armor"] = "战神护甲",
    ["Warbringer Battlegear"] = "战神战甲",

    --Tier 5 Sets
    ["Nordrassil Harness"] = "诺达希尔甲胄",
    ["Nordrassil Raiment"] = "诺达希尔圣装",
    ["Nordrassil Regalia"] = "诺达希尔法衣",
    ["Rift Stalker Armor"] = "裂隙追猎者",
    ["Tirisfal Regalia"] = "提瑞斯法",
    ["Crystalforge Armor"] = "晶铸护甲",
    ["Crystalforge Battlegear"] = "晶铸战甲",
    ["Crystalforge Raiment"] = "晶铸圣装",
    ["Avatar Raiment"] = "神使圣装",
    ["Avatar Regalia"] = "神使法衣",
    ["Deathmantle Set"] = "死亡阴影",
    ["Cataclysm Harness"] = "灾难甲胄",
    ["Cataclysm Raiment"] = "灾难圣装",
    ["Cataclysm Regalia"] = "灾难法衣",
    ["Corruptor Raiment"] = "腐蚀者",
    ["Destroyer Armor"] = "毁灭者护甲",
    ["Destroyer Battlegear"] = "毁灭者战甲",

    --Tier 6 Sets
    ["Thunderheart Harness"] = "雷霆之心甲胄",
    ["Thunderheart Raiment"] = "雷霆之心圣服",
    ["Thunderheart Regalia"] = "雷霆之心法衣",
    ["Gronnstalker's Armor"] = "戈隆追猎者",
    ["Tempest Regalia"] = "风暴",
    ["Lightbringer Armor"] = "光明使者护甲",
    ["Lightbringer Battlegear"] = "光明使者战甲",
    ["Lightbringer Raiment"] = "光明使者圣服",
    ["Vestments of Absolution"] = "赦免法衣",
    ["Absolution Regalia"] = "赦免圣装",
    ["Slayer's Armor"] = "刺杀者",
    ["Skyshatter Harness"] = "破天甲胄",
    ["Skyshatter Raiment"] = "破天圣服",
    ["Skyshatter Regalia"] = "破天法衣",
    ["Malefic Raiment"] = "凶星",
    ["Onslaught Armor"] = "冲锋护甲",
    ["Onslaught Battlegear"] = "冲锋战甲",

    --Arathi Basin Sets - Alliance
    ["The Highlander's Intent"] = "高地人的专注",
    ["The Highlander's Purpose"] = "高地人的毅力",
    ["The Highlander's Will"] = "高地人的意志",
    ["The Highlander's Determination"] = "高地人的果断",
    ["The Highlander's Fortitude"] = "高地人的坚韧",
    ["The Highlander's Resolution"] = "高地人的决心",
    ["The Highlander's Resolve"] = "高地人的执着",

    --Arathi Basin Sets - Horde
    ["The Defiler's Intent"] = "污染者的专注",
    ["The Defiler's Purpose"] = "污染者的毅力",
    ["The Defiler's Will"] = "污染者的意志",
    ["The Defiler's Determination"] = "污染者的果断",
    ["The Defiler's Fortitude"] = "污染者的坚韧",
    ["The Defiler's Resolution"] = "污染者的决心",

    --PvP Level 60 Rare Sets - Alliance
    ["Lieutenant Commander's Refuge"] = "少校的庇护",
    ["Lieutenant Commander's Pursuance"] = "少校的职责",
    ["Lieutenant Commander's Arcanum"] = "少校的秘密",
    ["Lieutenant Commander's Redoubt"] = "少校的壁垒",
    ["Lieutenant Commander's Investiture"] = "少校的授权",
    ["Lieutenant Commander's Guard"] = "少校的护卫",
    ["Lieutenant Commander's Stormcaller"] = "少校的震撼暴",
    ["Lieutenant Commander's Dreadgear"] = "少校的鬼纹",
    ["Lieutenant Commander's Battlearmor"] = "少校的战铠",

    --PvP Level 60 Rare Sets - Horde
    ["Champion's Refuge"] = "勇士的庇护",
    ["Champion's Pursuance"] = "勇士的职责",
    ["Champion's Arcanum"] = "勇士的秘密",
    ["Champion's Redoubt"] = "勇士的壁垒",
    ["Champion's Investiture"] = "勇士的授权",
    ["Champion's Guard"] = "勇士的套装",
    ["Champion's Stormcaller"] = "勇士的风暴",
    ["Champion's Dreadgear"] = "勇士的鬼纹",
    ["Champion's Battlearmor"] = "勇士的战铠",

    --PvP Level 60 Epic Sets - Alliance
    ["Field Marshal's Sanctuary"] = "元帅的圣装",
    ["Field Marshal's Pursuit"] = "元帅的猎装",
    ["Field Marshal's Regalia"] = "元帅的法衣",
    ["Field Marshal's Aegis"] = "元帅的庇护",
    ["Field Marshal's Raiment"] = "元帅的神服",
    ["Field Marshal's Vestments"] = "元帅的制服",
    ["Field Marshal's Earthshaker"] = "元帅的震撼",
    ["Field Marshal's Threads"] = "元帅的魔装",
    ["Field Marshal's Battlegear"] = "元帅的战甲",

    --PvP Level 60 Epic Sets - Horde
    ["Warlord's Sanctuary"] = "督军的圣装",
    ["Warlord's Pursuit"] = "督军的猎装",
    ["Warlord's Regalia"] = "督军的法衣",
    ["Warlord's Aegis"] = "督军的庇护",
    ["Warlord's Raiment"] = "督军的神服",
    ["Warlord's Vestments"] = "督军的制服",
    ["Warlord's Earthshaker"] = "督军的震撼",
    ["Warlord's Threads"] = "督军的魔装",
    ["Warlord's Battlegear"] = "督军的战甲",

    --Outland Faction Reputation PvP Sets
    ["Dragonhide Battlegear"] = "龙皮套装",
    ["Wyrmhide Battlegear"] = "蟒皮套装",
    ["Kodohide Battlegear"] = "科多皮套装",
    ["Stalker's Chain Battlegear"] = "潜伏者的链甲套装",
    ["Evoker's Silk Battlegear"] = "祈求者的丝质套装",
    ["Crusader's Scaled Battledgear"] = "十字军的板鳞甲套装",
    ["Crusader's Ornamented Battledgear"] = "十字军的雕饰板甲套装",
    ["Satin Battlegear"] = "绸缎套装",
    ["Mooncloth Battlegear"] = "月布套装",
    ["Opportunist's Battlegear"] = "机遇者的套装",
    ["Seer's Linked Battlegear"] = "先知的鳞甲套装",
    ["Seer's Mail Battlegear"] = "先知的锁甲套装",
    ["Seer's Ringmail Battlegear"] = "先知的环甲套装",
    ["Dreadweave Battlegear"] = "鬼纹套装",
    ["Savage's Plate Battlegear"] = "残暴者的板甲套装",

    --Arena Epic Sets
    ["Gladiator's Sanctuary"] = "角斗士的圣装",
    ["Gladiator's Wildhide"] = "角斗士的野性之皮",
    ["Gladiator's Refuge"] = "角斗士的庇护",
    ["Gladiator's Pursuit"] = "角斗士的猎装",
    ["Gladiator's Regalia"] = "角斗士的法衣",
    ["Gladiator's Aegis"] = "角斗士的保护",
    ["Gladiator's Vindication"] = "角斗士的辩护",
    ["Gladiator's Redemption"] = "角斗士的救赎",
    ["Gladiator's Raiment"] = "角斗士的神服",
    ["Gladiator's Investiture"] = "角斗士的天职",
    ["Gladiator's Vestments"] = "角斗士的套装",
    ["Gladiator's Earthshaker"] = "角斗士的震撼",
    ["Gladiator's Thunderfist"] = "角斗士的雷霆之拳",
    ["Gladiator's Wartide"] = "角斗士的战争之潮",
    ["Gladiator's Dreadgear"] = "角斗士的鬼纹",
    ["Gladiator's Felshroud"] = "角斗士的魔能套装",
    ["Gladiator's Battlegear"] = "角斗士的战甲",

    --Set Labels
    ["Set: Embrace of the Viper"] = "套装：毒蛇的拥抱",
    ["Set: Defias Leather"] = "套装：迪菲亚皮甲",
    ["Set: The Gladiator"] = "套装：角斗士",
    ["Set: Chain of the Scarlet Crusade"] = "套装：血色十字军链甲",
    ["Set: The Postmaster"] = "套装：邮差",
    ["Set: Necropile Raiment"] = "套装：骨堆",
    ["Set: Cadaverous Garb"] = "套装：苍白",
    ["Set: Bloodmail Regalia"] = "套装：血链",
    ["Set: Deathbone Guardian"] = "套装：亡者之骨",
    ["Set: Dal'Rend's Arms"] = "套装：雷德双刀",
    ["Set: Spider's Kiss"] = "套装：蜘蛛之吻",
    ["Temple of Ahn'Qiraj Sets"] = "安其拉神殿职业套装",
    ["AQ40 Class Sets"] = "安其拉神殿职业套装",
    ["Ruins of Ahn'Qiraj Sets"] = "安其拉废墟职业套装",
    ["AQ20 Class Sets"] = "安其拉废墟职业套装",
    ["AQ Enchants"] = "安其拉掉落的附魔公式",
    ["AQ Opening Quest Chain"] = "安其拉之门任务奖励",
    ["Pre 60 Sets"] = "60级之前的套装",
    ["Crafted Sets"] = "制造出的套装",
    ["Crafted Epic Weapons"] = "制造出的史诗武器",
    ["Zul'Gurub Sets"] = "祖尔格拉布职业套装",
    ["ZG Class Sets"] = "祖尔格拉布职业套装",
    ["ZG Enchants"] = "祖尔格拉布的附魔",
    ["Dungeon 1/2 Sets"] = "地下城套装1/2",
    ["Dungeon Set 1"] = "地下城套装1",
    ["Dungeon Set 2"] = "地下城套装2",
    ["Dungeon Set 3"] = "地下城套装3",
    ["Dungeon 3 Sets"] = "地下城套装3",
    ["Tier 1/2 Sets"] = "等级1/2套装",
    ["Tier 3 Sets"] = "等级3套装",
    ["Tier 4 Sets"] = "等级4套装",
    ["Tier 5 Sets"] = "等级5套装",
    ["Tier 6 Sets"] = "等级6套装",
    ["PvP Sets (Level 60)"] = "PvP奖励套装 (等级 60)",
    ["PvP Sets (Level 70)"] = "PvP奖励套装 (等级 70)",
    ["PvP Reputation Sets (Level 70)"] = "PvP声望套装 (等级 70)",
    ["PvP Rewards (Level 60)"] = "PvP奖励 (等级 60)",
    ["PvP Rewards (Level 70)"] = "PvP奖励 (等级 70)",
    ["PvP Accessories (Level 60)"] = "PvP奖励杂物 (等级 60)",
    ["PvP Accessories - Alliance (Level 60)"] = "PvP奖励杂物 - 联盟 (等级 60)",
    ["PvP Accessories - Horde (Level 60)"] = "PvP奖励杂物 - 部落 (等级 60)",
    ["PvP Accessories (Level 70)"] = "PvP奖励杂物 (等级 70)",
    ["PvP Rewards"] = "PvP奖励",
    ["PvP Armor Sets"] = "PvP奖励套装",
    ["PvP Weapons"] = "PvP奖励武器",
    ["PvP Weapons (Level 60)"] = "PvP奖励武器 (等级 60)",
    ["PvP Weapons (Level 70)"] = "PvP奖励武器 (等级 60)",
    ["PvP Accessories"] = "PvP奖励杂物",
    ["PvP Non-Set Epics"] = "PvP奖励非套装史诗级部件",
    ["PvP Honor System"] = "PvP荣誉系统",
    ["PvP Reputation Sets"] = "PvP声望套装",
    ["Arena PvP Sets"] = "竞技场奖励套装",
    ["Arena 2 PvP Sets"] = "竞技场第二赛季奖励套装",
    ["Arena 3 PvP Sets"] = "竞技场第三赛季奖励套装",
    ["Arena 4 PvP Sets"] = "竞技场第四赛季奖励套装",
    ["Arena PvP Weapons"] = "竞技场奖励武器",
    ["Arena 2 PvP Weapons"] = "竞技场第二赛季奖励武器",
    ["Arena 3 PvP Weapons"] = "竞技场第三赛季奖励武器",
    ["Arena 4 PvP Weapons"] = "竞技场第四赛季奖励武器",
    ["Arena PvP System"] = "竞技场系统",
    ["Arena Season 1 Weapons"] = "竞技场第一赛季奖励武器",
    ["Arena Season 2 Weapons"] = "竞技场第二赛季奖励武器",
    ["Arena Season 3 Weapons"] = "竞技场第三赛季奖励武器",
    ["Arena Season 4 Weapons"] = "竞技场第四赛季奖励武器",
    ["Season 1"] = "第一赛季",
    ["Season 2"] = "第二赛季",
    ["Season 3"] = "第三赛季",
    ["Season 4"] = "第四赛季",
    ["Arathi Basin Sets"] = "阿拉希盆地套装",
    ["Class Books"] = "职业书籍",
    ["Tribute Run"] = "贡品",
    ["Dire Maul Books"] = "厄运之槌书籍",
    ["Random Boss Loot"] = "首领随机掉落物品",
    ["Class Set Pieces"] = "职业套装部件",
    ["Epic Set"] = "史诗级套装",
    ["Rare Set"] = "精良级套装",
    ["Legendary Items"] = "传奇物品",
    ["Badge of Justice Rewards"] = "公正徽章兑换奖励",
    ["Accesories and Weapons"] = "杂物与武器",
    ["Accessories"] = "杂物",
    ["Armor and Weapons"] = "护甲与武器",
    ["Fire Resistance Gear"] = "火焰抗性装备",
    ["Arcane Resistance Gear"] = "奥术抗性装备",
    ["Nature Resistance Gear"] = "自然抗性装备",
    ["Frost Resistance Gear"] = "冰霜抗性装备",
    ["Shadow Resistance Gear"] = "暗影抗性装备",
    ["Rare Mounts"] = "稀有坐骑",
    ["Tabards"] = "徽章",
    ["Token Hand-Ins"] = "需要兑换的奖励",
    ["Heroic Mode Keys"] = "英雄模式钥匙",
    ["Legendary Items for Kael'thas Fight"] = "凯尔萨斯一役使用到的传奇物品",
    ["BoE World Epics"] = "世界掉落的史诗装备",
    ["World Epics"] = "世界掉落的史诗装备",
    ["Level 30-39"] = "等级 30-39",
    ["Level 40-49"] = "等级 40-49",
    ["Level 50-60"] = "等级 50-60",
    ["BT Patterns/Plans"] = "黑暗神殿掉落的图纸",
    ["Hyjal Summit Designs"] = "海加尔峰掉落的图纸",
    ["SP Patterns/Plans"] = "太阳之井高地掉落图纸",

    --NPCs missing from BabbleBoss
    ["Trash Mobs"] = "普通怪物",
    ["Dungeon Set 2 Summonable"] = "地下城套装2任务首领",
    ["Highlord Kruul"] = "魔王库鲁尔",
    ["Theldren"] = "塞尔德林",
    ["Sothos and Jarien"] = "索托斯/亚雷恩",
    ["Druid of the Fang"] = "尖牙德鲁伊",
    ["Defias Strip Miner"] = "迪菲亚赤膊矿工",
    ["Defias Overseer/Taskmaster"] = "迪菲亚监工/工头",
    ["Scarlet Defender/Myrmidon"] = "血色防御者/仆从",
    ["Scarlet Champion"] = "血色勇士",
    ["Scarlet Centurion"] = "血色百夫长",
    ["Scarlet Trainee"] = "血色预备兵",
    ["Herod/Mograine"] = "赫洛德/莫格莱尼",
    ["Scarlet Protector/Guardsman"] = "血色保卫者/卫兵",
    ["Shadowforge Flame Keeper"] = "暗炉持火者",
    ["Olaf"] = "奥拉夫",
    ["Eric 'The Swift'"] = "艾瑞克",
    ["Shadow of Doom"] = "末日之影",
    ["Bone Witch"] = "骨巫",
    ["Lumbering Horror"] = "笨拙的憎恶",
    ["Avatar of the Martyred"] = "殉难者的化身",
    ["Yor"] = "尤尔",
    ["Nexus Stalker"] = "节点潜行者",
    ["Auchenai Monk"] = "奥金尼僧侣",
    ["Cabal Fanatic"] = "秘教狂热者",
    ["Unchained Doombringer"] = "摆脱束缚的厄运使者",
    ["Crimson Sorcerer"] = "红衣法术师",
    ["Thuzadin Shadowcaster"] = "图萨丁暗影法师",
    ["Crimson Inquisitor"] = "红衣审查者",
    ["Crimson Battle Mage"] = "红衣战斗法师",
    ["Ghoul Ravener"] = "食尸抢夺者",
    ["Spectral Citizen"] = "鬼魂市民",
    ["Spectral Researcher"] = "鬼灵研究员",
    ["Scholomance Adept"] = "通灵学院专家",
    ["Scholomance Dark Summoner"] = "通灵学院黑暗召唤师",
    ["Blackhand Elite"] = "黑手精英",
    ["Blackhand Assassin"] = "黑手刺客",
    ["Firebrand Pyromancer"] = "火印炎术师",
    ["Firebrand Invoker"] = "火印祈求者",
    ["Firebrand Grunt"] = "火印步兵",
    ["Firebrand Legionnaire"] = "火印军团战士",
    ["Spirestone Warlord"] = "尖石军阀",
    ["Spirestone Mystic"] = "尖石秘法师",
    ["Anvilrage Captain"] = "铁怒上尉",
    ["Anvilrage Marshal"] = "铁怒队长",
    ["Doomforge Arcanasmith"] = "厄炉魔匠",
    ["Weapon Technician"] = "武器技师",
    ["Doomforge Craftsman"] = "厄炉工匠",
    ["Murk Worm"] = "黑暗虫",
    ["Atal'ai Witch Doctor"] = "阿塔莱巫医",
    ["Raging Skeleton"] = "暴怒的骷髅",
    ["Ethereal Priest"] = "虚灵牧师",
    ["Sethekk Ravenguard"] = "塞泰克鸦人卫士",
    ["Time-Lost Shadowmage"] = "迷失的暗影法师",
    ["Coilfang Sorceress"] = "盘牙巫师",
    ["Coilfang Oracle"] = "盘牙先知",
    ["Shattered Hand Centurion"] = "碎手百夫长",
    ["Eredar Deathbringer"] = "艾瑞达死亡使者",
    ["Arcatraz Sentinel"] = "禁魔监狱斥候",
    ["Gargantuan Abyssal"] = "巨型深渊火魔",
    ["Sunseeker Botanist"] = "寻日者植物学家",
    ["Sunseeker Astromage"] = "寻日者星术师",
    ["Durnholde Rifleman"] = "敦霍尔德火枪手",
    ["Rift Keeper/Rift Lord"] = "裂隙守卫者/领主",
    ["Crimson Templar"] = "赤红圣殿骑士",
    ["Azure Templar"] = "碧蓝圣殿骑士",
    ["Hoary Templar"] = "苍白圣殿骑士",
    ["Earthen Templar"] = "土色圣殿骑士",
    ["The Duke of Cynders"] = "灰烬公爵",
    ["The Duke of Fathoms"] = "深渊公爵",
    ["The Duke of Zephyrs"] = "微风公爵",
    ["The Duke of Shards"] = "碎石公爵",
    ["Aether-tech Assistant"] = "以太技师助理",
    ["Aether-tech Adept"] = "资深以太技师",
    ["Aether-tech Master"] = "高级以太技师",
    ["Trelopades"] = "特雷洛帕兹",
    ["King Dorfbruiser"] = "多弗布鲁瑟国王",
    ["Gorgolon the All-seeing"] = "全视者格苟尔隆",
    ["Matron Li-sahar"] = "里萨哈",
    ["Solus the Eternal"] = "永恒者索鲁斯",
    ["Balzaphon"] = "巴尔萨冯",
    ["Lord Blackwood"] = "布莱克伍德公爵",
    ["Revanchion"] = "雷瓦克安",
    ["Scorn"] = "瑟克恩",
    ["Sever"] = "塞沃尔",
    ["Lady Falther'ess"] = "法瑟蕾丝夫人",
    ["Smokywood Pastures Vendor"] = "烟林牧场商人",
    ["Shartuul"] = "沙图尔",
    ["Darkscreecher Akkarai"] = "黑暗尖啸者阿克卡莱",
    ["Karrog"] = "卡尔洛格",
    ["Gezzarak the Huntress"] = "猎手吉萨拉克",
    ["Vakkiz the Windrager"] = "风怒者瓦克奇斯",
    ["Terokk"] = "泰罗克",
    ["Armbreaker Huffaz"] = "断臂者霍法斯",
    ["Fel Tinkerer Zortan"] = "魔能工匠索尔坦",
    ["Forgosh"] = "弗尔高什",
    ["Gul'bor"] = "古尔博",
    ["Malevus the Mad"] = "疯狂的玛尔弗斯",
    ["Porfus the Gem Gorger"] = "掘钻者波弗斯",
    ["Wrathbringer Laz-tarash"] = "天罚使者拉塔莱什",
    ["Bash'ir Landing Stasis Chambers"] = "巴什伊尔码头静止间",
    ["Templars"] = "圣殿骑士",
    ["Dukes"] = "公爵",
    ["High Council"] = "议会高层",
    ["Headless Horseman"] = "无头骑士",
    ["Barleybrew Brewery"] = "麦酒佳酿",
    ["Thunderbrew Brewery"] = "雷酒佳酿",
    ["Gordok Brewery"] = "戈多克佳酿",
    ["Drohn's Distillery"] = "德罗恩的佳酿",
    ["T'chali's Voodoo Brewery"] = "塔卡里的佳酿",
    ["Scarshield Quartermaster"] = "裂盾军需官",
    ["Overmaster Pyron"] = "征服者派隆",
    ["Father Flame"] = "烈焰之父",
    ["Thomas Yance"] = "托马斯·杨斯",
    ["Knot Thimblejack"] = "诺特·希姆加克",
    ["Shen'dralar Provisioner"] = "辛德拉圣职者",
    ["Namdo Bizzfizzle"] = "纳姆杜",
    ["The Nameles Prophet"] = "无名预言者",
    ["Zelemar the Wrathful"] = "愤怒者塞雷玛尔",
    ["Henry Stern"] = "亨利·斯特恩",
    ["Aggem Thorncurse"] = "阿格姆",
    ["Roogug"] = "鲁古格",
    ["Rajaxx's Captains"] = "拉贾克斯的副官",
    ["Razorfen Spearhide"] = "剃刀沼泽刺鬃守卫",
    ["Rethilgore"] = "雷希戈尔",
    ["Kalldan Felmoon"] = "卡尔丹·暗月",
	["Magregan Deepshadow"] = "马格雷甘·深影",
    ["Lord Ahune"] = "埃霍恩",
    ["Coren Direbrew"] = "科伦·恐酒",
    ["Don Carlos"] = "唐·卡洛斯",
	
    --Zones
    ["World Drop"] = "世界掉落",
	["Sunwell Isle"] = "太阳之井",

	--Shortcuts for Bossname files
    --["LBRS"] = true,
    --["UBRS"] = true,
    --["CoT1"] = true,
    --["CoT2"] = true,
    --["Scholo"] = true,
    --["Strat"] = true,
    ["Serpentshrine"] = "SSC",

    --Chests, etc
    ["Dark Coffer"] = "黑暗宝箱",
    ["The Secret Safe"] = "秘密保险箱",
    ["The Vault"] = "黑色宝库",
    ["Ogre Tannin Basket"] = "食人魔鞣酸篮",
    ["Fengus's Chest"] = "芬古斯的箱子",
    ["The Prince's Chest"] = "王子的箱子",
    ["Doan's Strongbox"] = "杜安的保险箱",
    ["Frostwhisper's Embalming Fluid"] = "莱斯·霜语的防腐液",
    ["Unforged Rune Covered Breastplate"] = "未铸造的符文覆饰胸甲",
    ["Malor's Strongbox"] = "玛洛尔的保险箱",
    ["Unfinished Painting"] = "未完成的油画",
    ["Felvine Shard"] = "魔藤碎片",
    ["Baelog's Chest"] = "巴尔洛戈的箱子",
    ["Lorgalis Manuscript"] = "洛迦里斯手稿",
    ["Fathom Core"] = "深渊之核",
    ["Conspicuous Urn"] = "显眼的石罐",
    ["Gift of Adoration"] = "爱慕的礼物",
    ["Box of Chocolates"] = "一盒巧克力",
    ["Treat Bag"] = "糖果包",
    ["Gaily Wrapped Present"] = "微微震动的礼物",
    ["Festive Gift"] = "节日礼物",
    ["Ticking Present"] = "条纹礼物盒",
    ["Gently Shaken Gift"] = "精美的礼品",
    ["Carefully Wrapped Present"] = "精心包裹的礼物",
    ["Winter Veil Gift"] = "冬幕节礼物",
    ["Smokywood Pastures Extra-Special Gift"] = "烟林牧场的超级特殊礼物",
    ["Brightly Colored Egg"] = "复活节彩蛋",
    ["Lunar Festival Fireworks Pack"] = "春节烟花包",
    ["Lucky Red Envelope"] = "红包",
    ["Small Rocket Recipes"] = "小型烟花设计图",
    ["Large Rocket Recipes"] = "大型烟花设计图",
    ["Cluster Rocket Recipes"] = "烟花束设计图",
    ["Large Cluster Rocket Recipes"] = "大型烟花束设计图",
    ["Timed Reward Chest"] = "限时击杀首领奖励",
    ["Timed Reward Chest 1"] = "限时击杀首领奖励1",
    ["Timed Reward Chest 2"] = "限时击杀首领奖励2",
    ["Timed Reward Chest 3"] = "限时击杀首领奖励3",
    ["Timed Reward Chest 4"] = "限时击杀首领奖励4",
    ["The Talon King's Coffer"] = "利爪之王的宝箱",
    ["Krom Stoutarm's Chest"] = "克罗姆·粗臂的箱子",
    ["Garrett Family Chest"] = "加勒特的宝箱",
	["Reinforced Fel Iron Chest"] = "强化魔铁箱",
	["DM North Tribute Chest"] = "厄运之槌北区贡品",
	
    --World Events
    ["Abyssal Council"] = "深渊议会",
    ["Bash'ir Landing Skyguard Raid"] = "巴什伊尔码头",
    ["Brewfest"] = "美酒节",
    ["Children's Week"] = "儿童周",
    ["Elemental Invasion"] = "元素入侵",
    ["Ethereum Prison"] = "复仇军监狱",
    ["Feast of Winter Veil"] = "冬幕节",
    ["Gurubashi Arena Booty Run"] = "古拉巴什竞技场",
    ["Hallow's End"] = "万圣节",
    ["Harvest Festival"] = "收获节",
    ["Love is in the Air"] = "情人节",
    ["Lunar Festival"] = "春节",
    ["Midsummer Fire Festival"] = "仲夏火焰节",
    ["Noblegarden"] = "彩蛋节",
    ["Skettis"] = "斯克提斯",
    ["Stranglethorn Fishing Extravaganza"] = "荆棘谷钓鱼大赛",

} end)
