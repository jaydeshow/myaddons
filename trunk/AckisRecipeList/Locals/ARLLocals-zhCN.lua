﻿--[[
****************************************************************************************

ARLLocals-zhCN.lua

zhCN localization strings for Ackis Recipe List

$Date: 2008-06-07 17:28:24 -0400 (Sat, 07 Jun 2008) $
$Rev: 76230 $

Original translated by: iCat (msn: lucifer_icat@hotmail.com)
Currently maintaince by: Kurax, 冰焱妩魅 @ CWDG

Thank you all translators! (From Ackis)

****************************************************************************************
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("AckisRecipeList", "zhCN", false);
if not L then return end

-- Addon Info
L["Version"] = "版本: "
L["Author"] = "Ackis 伊利丹(美服) 部落"
L["Wiki"] = "Wiki: "
L["Website"] = "网站: "
L["Credits"] = "致谢: "
L["Locals"] = "兼容: "

-- Options Categories
L["Display"] = "显示"
L["DISPLAY_OPTIONS"] = "显示选项"
L["DISPLAY_OPTIONS_LONG"] = "允许你自定义图形界面的行为。"
L["Filter"] = "过滤"
L["FILTER_OPTIONS"] = "过滤器选项"
L["FILTER_OPTIONS_LONG"] = "允许你自定义要过滤哪些配方。"
L["Reputation"] = "声望"
L["REP_OPTIONS"] = "声望选项"
L["REP_OPTIONS_LONG"] = "允许你自定义要在扫描里包含哪些声望。"
L["Obtain"] = "获取"
L["OBTAIN_OPTIONS"] = "获取选项"
L["OBTAIN_OPTIONS_LONG"] = "允许你自定义要在扫描里包含哪种方式所获取的配方。"
L["Sort"] = "排序"
L["SORT_OPTIONS"] = "排序选项"
L["SORT_OPTIONS_LONG"] = "允许你自定义如何排序及显示所遗失的配方。"
L["Profile"] = "配置文件"

-- Display Options
L["Use GUI"] = "使用图形界面"
L["GUI_TOGGLE"] = "开/关使用图形界面。"
L["Include Filtered"] = "包含已过滤的"
L["FILTERCOUNT_TOGGLE"] = "把过滤的配方包含在总共配方的数目中。"
L["Close GUI"] = "关闭图形界面"
L["CLOSEGUI_TOGGLE"] = "当交易技能窗口关闭也同时关闭ARL窗口。"

-- Filtering Options
L["Faction"] = "阵营"
L["FACTION_TOGGLE"] = "扫描中包含联盟和部落共有的配方。"
L["Classes"] = "职业"
L["CLASS_TOGGLE"] = "扫描中包含职业限定的配方。"
L["Specialities"] = "技能专业"
L["SPECIALITY_TOGGLE"] = "扫描中包含所有交易技能专业。"
L["Skill"] = "技能"
L["SKILL_TOGGLE"] = "包含所有配方，而不管你当前的技能等级是多少。"

-- Obtain Filter Options
L["BOEFilter"] = "装备绑定"
L["BOE_TOGGLE"] = "扫描中包含产物装备绑定的配方。"
L["BOPFilter"] = "拾取绑定"
L["BOP_TOGGLE"] = "扫描中包含产物拾取绑定的配方。"
L["PVP_TOGGLE"] = "扫描中包含通过PvP途径获取的配方。"
L["RAID_TOGGLE"] = "扫描中包含那些只能在团队副本中获取的配方。"
L["SEASONAL_TOGGLE"] = "扫描中包含只能在节日活动中所获取的配方。"
L["TRAINER_TOGGLE"] = "扫描中包含可从训练师那里习得的配方。"
L["VENDOR_TOGGLE"] = "扫描中包含可从商人处购买的配方。"
L["INSTANCE_TOGGLE"] = "扫描中包含从副本掉落的配方。"
L["QUEST_TOGGLE"] = "扫描中包含任务奖励获得的配方。"

-- Sorting options
L["Name"] = "名称"
L["Skill"] = "技能"
L["Aquisition"] = "获取"

-- Reputation Toggles
L["SPECIFIC_REP_TOGGLE"] = "包含%s阵营。"

-- Non-gui text
L["MissingFromDB"] = "：不在插件的数据库中. \n请将该卷轴的信息提供给作者，谢谢。"
L["MissingRecipePrefix"] = "遗漏： "
L["InitiateScan"] = "在%s[ %s ]中扫描遗漏的卷轴\n"
L["InitiateScanSpecial"] = "在%s - %s[ %s ]中扫描遗漏的卷轴\n"
L["RecipeListSummary"] = "\n已经学会 %s 个，总数 %s 个 (%s%%)\n遗漏了 %s 个卷轴。"
L["UnknownTradeSkill"] = "您打开了一个插件不支持的交易技能窗口。这个交易技能插件是 %s 。请向作者提供该信息，谢谢。"
L["OpenTradeSkillWindow"] = "请先打开一个想要扫描的交易技能。"

-- GUI Text
L["Close"] = "关闭"
L["ScanButton"] = "扫描配方"
L["Scan Skills"] = "扫描"
L["FILTER_OPEN"] = "过滤 >>>"
L["FILTER_CLOSE"] = "<<< 过滤"
L["Reset"] = "重置"
L["Sort"] = "排序"
L["World Drop"] = "世界掉落"
L["Mob Drop"] = "怪物掉落"
L["Quest"] = "任务"
L["Reputation"] = "声望"
L["Instance"] = "副本"
L["BoPMenu"] = "拾取绑定"
L["Horde"] = "部落" 
L["Alliance"] = "联盟"
L["Known"] = "已知"
L["Unknown"] = "未知"

-- Tooltip Text
L["Scan Skills Long"] = "使用Ackis Recipe List扫描遗漏的配方"
L["Close Window"] = "关闭ARL窗口"
L["Expand All"] = "展开所有的配方"
L["Collapse All"] = "折叠所有的配方"
L["FILTER_OPEN_TT"] = "打开过滤选项面板"
L["FILTER_CLOSE_TT"] = "关闭过滤选项面板"
L["RESET_TT"] = "重置搜索的关键字"
L["SORT_TT"] = "更改列表的排列顺序"
L["VENDOR_TT"] = "选中则在列表中包含商人出售的配方"
L["TRAINER_TT"]= "选中则在列表中包含训练师可学的配方"
L["WORLD_TT"] = "选中则在列表中包含世界掉落的配方"
L["MOB_TT"] = "选中则在列表中包含怪物掉落的配方"
L["QUEST_TT"] = "选中则在列表中包含任务奖励的配方"
L["SEASON_TT"] = "选中则在列表中包含节日活动才出现的配方"
L["REP_TT"] = "选中则在列表中包含声望奖励的配方"
L["INSTANCE_TT"] = "选中则在列表中包含副本掉落的配方"
L["BOP_TT"] = "选中则在列表中包含拾取绑定的配方"
L["HORDE_TT"] = "选中则在列表中包含部落独有的配方"
L["ALLIANCE_TT"] = "选中则在列表中包含联盟独有的配方"
L["KNOWN_TT"] = "选中则在列表中包含已知配方"
L["UNKNOWN_TT"] = "选中则在列表中包含未知配方"

-- Recipe Database
L["Trainer"] = "训练师"
L["LimitedSupply"] = "限量供应"
L["Vendor"] = "商人"
L["Discovery"] = "领悟"
L["PVP"] = "PvP"
L["Raid"] = "Raid"

--Skillup Levels
L["Journeyman"] = "中级"
L["Expert"] = "高级"
L["Artisan"] = "专家级"
L["Master"] = "大师级"

-- Common ways to obtain recipes
L["UZD"] = "不常见区域掉落: "
L["CWD"] = "常见世界掉落"
L["UWD"] = "不常见世界掉落"
L["RWD"] = "罕见世界掉落"
L["EWD"] = "超罕见世界掉落"
L["BoE"] = "装绑: "
L["BoP"] = "拾绑: "
L["QuestReward"] = "任务奖励: "

-- Common quests/drops
L["DMCACHE"] = "诺特·希姆加克的箱子"
L["Gordok Ogre Suit"] = "戈多克食人魔装"
L["Gordok Ogre Suit Obt"] = "戈多克食人魔装"
L["Spectral Essence Obt"] = "传令官基尔图诺斯 (让你能看到通灵学院附近的商人玛格努斯·霜鸣)"
L["TrueBelieverQuest"] = "真正的信徒 - 从 被破译的《真正的信徒》剪报中稀有掉落"

-- Raid Drop Obtain Info
L["ADNaxx"] = "训练师: 从纳克萨玛斯死亡骑士区的大工匠奥玛里恩处学到"
L["MOLTENCORE"] = "团队拾绑: 熔火之心首领随机掉落"
L["AQ20/AQ40"] = "团队拾绑: 安其拉废墟/安其拉神殿首领随机掉落"
L["SSC/TKBoP"] = "团队拾绑: 毒蛇神殿/风暴要塞随机掉落"
L["SSC/TKBoE"] = "团队装绑: 毒蛇神殿/风暴要塞随机掉落"
L["BT/HYJALBoP"] = "团队拾绑: 海加尔/黑暗神庙随机掉落"
L["HYJALBoP"] = "团队拾绑: 海加尔首领随机掉落"
L["SunwellBoP"] = "团队拾绑: 太阳井随机掉落"
L["SunwellBoE"] = "团队装绑: 太阳井随机掉落"
L["BT/HYJALBoE"] = "团队装绑: 海加尔/黑暗神庙随机掉落"
L["ZA"] = "团队拾绑: 祖阿曼首领随机掉落"
L["Unknown"] = "该配方掉落来源未知，你可以于 www.wowace.com/forums 论坛中Ackis Recipe List的官方帖中帮助提供掉落信息。"

-- Faction info
L["WintersVeil"] = "冬幕节"
L["Lunar Festival"] = "春节"
L["Darkmoon Faire"] = "暗月马戏团"
L["Seasonal"] = "节日活动"

-- Alchemy Obtain Information
L["Discovery - Flasks/Potions"] = "领悟: 通过制作包含外域草药的合剂/药剂/药水领悟到"
L["Discovery - Protection Potions"] = "领悟: 通过制作大部分守护药剂领悟到"
L["Discovery - Transmutes"] = "领悟: 通过转化包含外域材料的物品领悟到"
L["Goblin Rocket Fuel Obt"] = "制造：这个配方是地精工程师制作出来的"
L["Gurubashi Mojo Madness Obt"] = "团队: 于祖尔格拉布的疯狂之缘区域点击石头桌子学到"
L["Mighty Trolls Blood Potion Obt"] = "训练师: 与剃刀高地的亨利·斯特恩对话"
-- Mob Drop
L["Elixir of Greater Firepower Obt"] = "黑铁奴隶贩子, 黑铁巡逻兵, 黑铁工头"
L["Elixir of the Mongoose Obt"] = "碧火盗贼, 雷加斯盗贼"
L["Elixir of the Sages Obt"] = "血色巫术师, 血色宣教士, 血色助理牧师, 血色大法师, 血色审查官"
L["Fel Mana Potion Obt"] = "日蚀士兵, 日蚀血护卫, 日蚀血骑士, 日蚀缚法者, 日蚀法师, 日蚀百夫长, 日蚀骑兵, 托洛斯, 伊利达雷监视者"
L["Fel Regeneration Potion Obt"] = "死亡熔炉小鬼, 死亡熔炉守护者, 死亡熔炉铁匠, 死亡熔炉杂役"
L["Fel Strength Elixir Obt"] = "莫尔葛武器匠, 恐怖主宰, 天罚行者, 暗影议会术士"
L["Gift of Arthas Obt"] = "骷髅剥皮者, 被奴役的食尸鬼"
L["Greater Arcane Protection Potion Obt"] = "深蓝龙人法师"
L["Greater Fire Protection Potion Obt"] = "火印祈求者, 火印炎术师"
L["Greater Frost Protection Potion Obt"] = "霜槌巨人"
L["Greater Nature Protection Potion Obt"] = "枯萎的恐兽, 腐烂的巨兽"
L["Greater Shadow Protection Potion Obt"] = "黑暗教徒, 暗影法师"
L["Major Arcane Protection Potion Obt"] = "维尔埃尼奥术师"
L["Major Fire Protection Potion Obt"] = "寻日者星术师"
L["Major Holy Protection Potion Obt"] = "深渊烈焰使者"
L["Major Shadow Protection Potion Obt"] = "暗影议会术士"
L["Mighty Rage Potion Obt"] = "黑石杀戮者"
L["Wildvine Potion Obt"] = "各种巨魔怪物"
-- Quest
L["Discolored Healing Potion Obt"] = "荒野之心"
L["Elixir of Brute Force Obt"] = "完成“达丹加饿了！”任务有机率获得"
L["Lesser Stoneshield Potion Obt"] = "卢希恩的药水"
L["Restorative Potion Obt"] = "奥达曼的蘑菇"

-- Blacksmithin Obtain Information
L["Inlaid Mithril Cylinder Obt"] = "制造：这个配方是侏儒工程师制作出来的"
L["Blacksmithing Plans"] = "从锻造配方物品随机掉落"
-- Mob Drop
L["Dark Iron Sunderer Obt"] = "持铁锤的顾客, 雷布里的亲信"
L["Felsteel Gloves Obt"] = "奥金尼僧侣"
L["Felsteel Helm Obt"] = "秘教狂热者"
L["Felsteel Leggings Obt"] = "摆脱束缚的厄运使者"
L["Frostguard Obt"] = "工头玛希瑞德"
L["Greater Ward of Shielding Obt"] = "日怒血卫士"
L["Khorium Belt Obt"] = "暗血掠夺者"
L["Khorium Boots Obt"] = "空洞的保护者"
L["Khorium Pants Obt"] = "死亡熔炉守护者"
L["Ragesteel Breastplate Obt"] = "灰舌战士"
L["Ragesteel Gloves Obt"] = "石拳战士"
L["Ragesteel Helm Obt"] = "怒火卫士"
L["Ragesteel Shoulders Obt"] = "愤怒的地灵, 愤怒的气灵, 愤怒的火灵, 愤怒的水灵"
L["Runic Breastplate Obt"] = "斯塔莎兹侍从"
L["Runic Plate Boots Obt"] = "血色骑兵"
L["Runic Plate Helm Obt"] = "斯塔莎兹战士"
L["Runic Plate Leggings Obt"] = "血色铁匠"
L["Runic Plate Shoulders Obt"] = "斯塔莎兹毒蛇守卫"
L["Swiftsteel Gloves Obt"] = "节点潜行者"
L["Volcanic Hammer Obt"] = "沃尔查"
-- Quest
L["Barbaric Iron Boots Obt"] = "踩在脚下"
L["Barbaric Iron Breastplate Obt"] = "野人装甲"
L["Barbaric Iron Gloves Obt"] = "沃姆什的喜悦"
L["Barbaric Iron Helm Obt"] = "疯狂之角"
L["Barbaric Iron Shoulders Obt"] = "铁肩铠"
L["Blazing Rapier Obt"] = "腐蚀"
L["Dawn's Edge Obt"] = "沃什加斯的蛇石"
L["Demon Forged Breastplate Obt"] = "恶魔熔炉"
L["Enchanted Battlehammer Obt"] = "甜美的平静"
L["Enchanted Thorium Breastplate Obt"] = "魔化瑟银板甲：第一卷"
L["Enchanted Thorium Helm Obt"] = "魔化瑟银板甲：第三卷"
L["Enchanted Thorium Leggings Obt"] = "魔化瑟银板甲：第二卷"
L["Fiery Plate Gauntlets Obt"] = "炽热板甲护手"
L["Golden Scale Gauntlets Obt"] = "锻造的本源"
L["Heavy Copper Longsword Obt"] = "前线的补给"
L["Imperial Plate Belt Obt"] = "君王板甲腰带"
L["Imperial Plate Boots Obt"] = "君王板甲战靴"
L["Imperial Plate Bracers Obt"] = "君王板甲护腕"
L["Imperial Plate Chest Obt"] = "君王板甲护胸"
L["Imperial Plate Helm Obt"] = "君王板甲头盔"
L["Imperial Plate Leggings Obt"] = "君王板甲护腿"
L["Imperial Plate Shoulders Obt"] = "君王板甲护肩"
L["Ironforge Breastplate Obt"] = "赤脊山的补给"
L["Orcish War Leggings Obt"] = "古老的技艺"
L["Ornate Mithril Gloves Obt"] = "白花花的银子"
L["Ornate Mithril Helm Obt"] = "铸造护甲的艺术"
L["Ornate Mithril Pants Obt"] = "铁匠必修课"
L["Ornate Mithril Shoulder Obt"] = "罩帽和护肩"
L["Sulfuron Hammer Obt"] = "瑟银兄弟会契约"

-- Cooking Obtain Information
L["Fishing Daily"] = "任务奖励: 钓鱼每日任务随机奖励"
L["Cooking Daily"] = "任务奖励: 烹饪每日任务随机奖励"
L["Goldthorn Tea Obt"] = "与剃刀高地的亨利·斯特恩对话"
L["Stewed Trout Obt"] = "训练师: 凯蕾妮"
-- Mob Drop
L["Runn Tum Tuber Surprise Obt"] = "普希林"
-- Quest
L["Barbecued Buzzard Wing Obt"] = "烧烤秃鹰翅膀"
L["Beer Basted Boar Ribs Obt"] = "啤酒烤猪排"
L["Big Bear Steak Obt"] = "拯救行动"
L["Blood Sausage Obt"] = "塞尔萨玛血肠"
L["Buzzard Bites Obt"] = "万无一失"
L["Crocolisk Gumbo Obt"] = "学徒的职责"
L["Crocolisk Steak Obt"] = "捕猎鳄鱼"
L["Crunchy Serpent Obt"] = "莫克纳萨的美味"
L["Crunchy Spider Surprise Obt"] = "松脆蜘蛛腿"
L["Curiously Tasty Omelet Obt"] = "奥莫尔的复仇"
L["Dig Rat Stew Obt"] = "掘地鼠炖肉"
L["Dirge's Kickin' Chimaerok Chops Obt"] = "迪尔格的超美味奇美拉肉片"
L["Gooey Spider Cake Obt"] = "黑蟹蛋糕"
L["Goretusk Liver Pie Obt"] = "猪肝馅饼"
L["Hot Lion Chops Obt"] = "痛苦药剂"
L["Kaldorei Spider Kabob Obt"] = "卡多雷的菜谱"
L["Murloc Fin Soup Obt"] = "卖鱼"
L["Redridge Goulash Obt"] = "赤脊山炖肉"
L["Roasted Moongraze Tenderloin Obt"] = "狩猎月痕鹿"
L["Seasoned Wolf Kabob Obt"] = "干烤狼肉串"
L["Smoked Desert Dumplings Obt"] = "沙漠食谱"
L["Soothing Turtle Bisque Obt"] = "海龟汤"
L["Strider Stew Obt"] = "炖陆行鸟"
L["Tasty Lion Steak Obt"] = "损失惨重"
L["Thistle Tea Ally Obt"] = "克拉文之塔"
L["Thistle Tea Horde Obt"] = "任务: 基本不可能的任务"
L["Westfall Stew Obt"] = "杂味炖肉"

-- Enchanting Obtain Information
L["Enchant 2H Weapon - Major Agility Obt"] = "艾瑞达死亡使者"
L["Enchant 2H Weapon - Major Intellect Obt"] = "红衣法术师"
L["Enchant 2H Weapon - Major Spirit Obt"] = "通灵学院专家"
L["Enchant 2H Weapon - Savagery Obt"] = "碎手百夫长"
L["Enchant 2H Weapon - Superior Impact Obt"] = "黑手精英"
L["Enchant Boots - Dexterity Obt"] = "暴怒的骷髅"
L["Enchant Boots - Fortitude Obt"] = "虚灵牧师"
L["Enchant Boots - Surefooted Obt"] = "幻影舞台工人"
L["Enchant Bracer - Fortitude Obt"] = "盘牙先知"
L["Enchant Bracer - Major Defense Obt"] = "复仇军消除者"
L["Enchant Bracer - Spellpower Obt"] = "血槌地卜师"
L["Enchant Bracer - Superior Strength Obt"] = "逆风术士"
L["Enchant Cloak - Greater Arcane Resistance Obt"] = "日蚀法师"
L["Enchant Cloak - Greater Shadow Resistance Obt"] = "空灵尖啸者"
L["Enchant Cloak - Lesser Agility Obt"] = "辛迪加刺客"
L["Enchant Cloak - Lesser Agility Obt1"] = "废土刺客, 废土暴徒"
L["Enchant Gloves - Advanced Herbalism Obt"] = "泥沼之王, 摩塔索恩, 沼泽漫步者, 沼泽漫步者长老, 纠缠恐兽"
L["Enchant Gloves - Advanced Mining Obt"] = "风险投资公司露天矿工"
L["Enchant Gloves - Fishing Obt"] = "斯卡基尔, 碎鳍滩行鱼人, 碎鳍智者, 碎鳍泥浆鱼人, 碎鳍潮行鱼人"
L["Enchant Gloves - Herbalism Obt"] = "疯狂的古树, 干枯的古树"
L["Enchant Gloves - Herbalism Obt1"] = "狂怒的树人, 黑色古树, 烧焦的树人"
L["Enchant Gloves - Mining Obt"] = "黑铁矮人, 黑铁爆破手, 黑铁隧道工, 黑铁破坏者, 邪恶的巴尔加拉斯"
L["Enchant Gloves - Skinning Obt"] = "屠戮者尼玛尔, 枯木狂战士, 枯木猎头者, 枯木暗影猎手"
L["Enchant Weapon - Crusader Obt"] = "血色缚法者"
L["Enchant Weapon - Deathfrost Obt"] = "埃霍恩领主 - 仲夏火焰节"
L["Enchant Weapon - Fiery Weapon Obt"] = "控火师罗格雷恩"
L["Enchant Weapon - Icy Chill Obt"] = "痛苦的上层精灵"
L["Enchant Weapon - Lifestealing Obt"] = "鬼灵研究员"
L["Enchant Weapon - Major Intellect Obt"] = "日怒研究员"
L["Enchant Weapon - Major Spellpower Obt"] = "巴什伊尔法术窃贼"
L["Enchant Weapon - Superior Striking Obt"] = "尖石军阀"
L["Enchant Weapon - Unholy Weapon Obt"] = "图萨丁暗影法师"
L["Smoking Heart of the Mountain Obt"] = "洛考尔"

-- Engineering Obtain Information
L["ENG_MEMBERSHIP_BENEFITS"] = "随机任务奖励：会员的奖励"
L["Field Repair Bot 74A Obt"] = "Boss身边可以点击的卷轴"
L["Minor Recombobulator Obt"] = "在矩阵打卡器3005-A上使用白色穿孔卡片，然后在矩阵打卡器3005-B上使用黄色穿孔卡片。"
L["Discombobulator Ray Obt"] = "在D机器上使用秘密数据存取卡"
-- Mob Drop
L["Adamantite Arrow Maker Obt"] = "日怒射手"
L["Arcanite Dragonling Obt"] = "深蓝龙人法师"
L["Dark Iron Rifle Obt"] = "厄炉工匠"
L["Felsteel Boomstick Obt"] = "末日熔炉技师"
L["Field Repair Bot 110G Obt"] = "甘尔葛分析师"
L["Flawless Arcanite Rifle Obt"] = "烂苔暗影猎手"
L["Hyper-Vision Goggles Obt"] = "莫尔葛武器匠"
L["Khorium Scope Obt"] = "日怒弓箭手"
L["Major Recombobulator Obt"] = "戈多克的贡品箱子"
L["Weapon Technician"] = "武器技师"
L["Crimson Inquisitor"] = "红衣审查者"
-- Quest
L["Flash Bomb Obt"] = "闪光弹的制法"
L["Steam Tonk Controller Obt"] = "40张奖券 - 高级奖品 (暗月马戏团)"
L["Zapthrottle Mote Extractor Obt"] = "气阀微粒提取器!"

-- First Aid Obtain Information
-- Nothing here needed yet

-- Jewelcrafting Obtain Information
L["Blades Edge Summon Bosses"] = "奥格瑞拉召唤的首领"
-- Mob Drop
L["Arcane Khorium Band Obt"] = "法师杀手"
L["Chaotic Skyfire Diamond Obt"] = "库斯卡女妖"
L["Coronet of the Verdant Flame Obt"] = "寻日者植物学家"
L["Khorium Band of Frost Obt"] = "盘牙巫师"
L["Khorium Band of Leaves Obt"] = "维克鸦巢恐怖卫士"
L["Khorium Band of Shadows Obt"] = "黑暗教团暗影法师"
-- Quest

-- Leatheworking Obtain Information
-- Mob Drop
L["Bag of Many Hides Obt"] = "戈杜尼断脊者, 戈杜尼劈颅者, 戈杜尼元素师, 戈杜尼裂魂者"
L["Anvilrage Captain"] = "铁怒上尉"
L["Blue Dragonscale Shoulders Obt"] = "峭壁击碎者"
L["Devilsaur Leggings Obt"] = "克隆软泥怪, 胶质软泥怪"
L["Flame Armor Kit Obt"] = "巨型深渊火魔"
L["Frostsaber Gloves Obt"] = "冬泉图腾师"
L["Frostsaber Leggings Obt"] = "冬泉巢穴守卫"
L["Frostsaber Tunic Obt"] = "冬泉巨熊怪"
L["Green Dragonscale Leggings Obt"] = "黑暗虫"
L["Heavy Scorpid Leggings Obt"] = "黑石杀戮者"
L["Heavy Scorpid Shoulders Obt"] = "黑石军官"
L["Heavy Scorpid Vest Obt"] = "传送门搜寻者"
L["Ironfeather Breastplate Obt"] = "邪枝剥皮者"
L["Living Breastplate Obt"] = "枯萎的恐兽"
L["Living Leggings Obt"] = "死木萨满祭司"
L["Shadow Armor Kit Obt"] = "迷失的暗影法师"
L["Stormshroud Armor Obt"] = "亚考兰智者"
L["Stormshroud Gloves Obt"] = "烈风掠夺者"
L["Stormshroud Gloves Obt1"] = "泰比斯蒂亚公主, 冬泉谷"
L["Stormshroud Shoulders Obt"] = "亚考罗克之子"
L["Stylin' Adventure Hat Obt"] = "敦霍尔德火枪手"
L["Stylin' Crimson Hat Obt"] = "塞泰克鸦人卫士"
L["Stylin' Jungle Hat Obt"] = "裂隙领主, 裂隙守卫者"
L["Tough Scorpid Boots Obt"] = "废土游荡者"
L["Tough Scorpid Bracers Obt"] = "废土暗法师"
L["Tough Scorpid Breastplate Obt"] = "废土强盗"
L["Tough Scorpid Gloves Obt"] = "废土窃贼"
L["Tough Scorpid Helm Obt"] = "安德雷·费尔比德, 废土暴徒"
L["Tough Scorpid Leggings Obt"] = "废土游荡者"
L["Volcanic Breastplate Obt"] = "火印步兵"
L["Volcanic Leggings Obt"] = "火腹蛮兵"
L["Volcanic Shoulders Obt"] = "火印军团战士"
-- Quest
L["Deviate Scale Belt Obt"] = "清除变异者"
L["Kodo Hide Bag Obt"] = "科多兽皮包"
L["Moonglow Vest Obt"] = "月光外衣"
L["Onyxia Scale Cloak Obt"] = "一切才刚刚开始 (上交奥妮克西亚头颅后)"
L["Wild Leather Boots Obt"] = "蛮皮战靴"
L["Wild Leather Cloak Obt"] = "蛮皮护甲大师"
L["Wild Leather Helmet Obt"] = "蛮皮头盔"
L["Wild Leather Leggings Obt"] = "蛮皮护腿"
L["Wild Leather Shoulders Obt"] = "蛮皮护肩"
L["Wild Leather Vest Obt"] = "蛮皮外衣"

-- Smelting Obtain Information
L["Dark Iron Obt"] = "需要20个金锭, 2个红宝石, 10个真银锭, 跟黑石深渊七贤处的格鲁雷尔对话"
L["Elementium Obt"] = "精神控制BWL大元素师克里希克，使用宠物栏一个技能学得"

-- Rogue Poison Obtain Information
-- Nothing here needed yet

-- Tailoring Obtain Information
L["Arcanoweave Boots Obt"] = "寻日者星术师"
L["Arcanoweave Bracers Obt"] = "禁魔监狱斥候"
L["Black Silk Pack Obt"] = "辛迪加间谍"
L["Black Silk Pack Obt1"] = "塞拉摩间谍"
L["Black Silk Pack Obt2"] = "暗影刺客"
L["Cindercloth Cloak Obt"] = "索瑞森驭火者"
L["Cindercloth Gloves Obt"] = "暮光火焰卫士"
L["Cindercloth Pants Obt"] = "索瑞森驭火者"
L["Cindercloth Vest Obt"] = "暮光火焰卫士"
L["Cloak of Fire Obt"] = "征服者派隆"
L["Felcloth Bag Obt"] = "杀死詹迪斯·巴罗夫后出现的书中获得"
L["Ghostweave Belt Obt"] = "徘徊的上层精灵"
L["Ghostweave Gloves Obt"] = "徘徊的上层精灵"
L["Ghostweave Gloves Obt1"] = "无影仆从"
L["Ghostweave Pants Obt"] = "鬼魂市民"
L["Ghostweave Vest Obt"] = "无影仆从"
L["Mooncloth Boots Obt"] = "神圣的月布"
L["Robe of the Archmage Obt"] = "火印炎术师"
L["Robe of Winter Night Obt"] = "深蓝龙人法师"
L["Robes of Arcana Obt"] = "暗滩唤魔师"
L["Robes of Arcana Obt1"] = "迪菲亚附魔师"
L["Shadoweave Mask Obt"] = "黑市交易"
L["Soulcloth Shoulders Obt"] = "幻影随从"
L["Soulcloth Vest Obt"] = "幻影仆从"
L["Wizardweave Leggings Obt"] = "黑暗召唤师"
L["Wizardweave Robe Obt"] = "黑暗法师"
L["Wizardweave Turban Obt"] = "黑暗法师"

-- Beast Training Obtain Information
L["Rare"] = "稀有"
L["Elite"] = "精英"
-- Beasts which have training skills Localized by 冰焱妩魅 @ CWDG
L["Agam'ar"] = "阿迦玛"
L["Aku'mai Fisher"] = "阿库麦尔食鱼龟"
L["Aku'mai Snapjaw"] = "阿库麦尔钳嘴龟"
L["Angerclaw Mauler"] = "怒爪巨熊"
L["Arash-ethis"] = "阿拉瑟希斯"
L["Ashenvale Bear"] = "灰谷熊"
L["Ashmane Boar"] = "灰鬃野猪"
L["Barbed Crustacean"] = "刺毛甲壳蟹"
L["Barnabus"] = "巴纳布斯"
L["Battleboar"] = "斗猪"
L["Bellygrub"] = "贝利格拉布"
L["Besseleth"] = "贝瑟莱斯"
L["Bhag'thera"] = "巴尔瑟拉"
L["Bjarn"] = "游荡的冰爪熊"
L["Black Bear Patriarch"] = "黑熊首领"
L["Black Ravager Mastiff"] = "巨型黑色破坏者"
L["Black Ravager"] = "黑色破坏者"
L["Blackrock Worg"] = "黑石座狼"
L["Blackwind Warp Chaser"] = "黑风追迹者"
L["Blisterpaw Hyena"] = "疱爪土狼"
L["Bloodaxe Worg"] = "血斧座狼"
L["Bloodfalcon"] = "血隼"
L["Bloodmaul Battle Worg"] = "血槌战斗座狼"
L["Bloodmaul Dire Wolf"] = "血槌巨狼"
L["Bloodsnout Worg"] = "血牙座狼"
L["Bonepaw Hyena"] = "骨爪土狼"
L["Bristleback Battleboar"] = "刺背斗猪"
L["Broken Tooth"] = "断牙"
L["Carrion Vulture"] = "食腐秃鹫"
L["Cave Creeper"] = "洞穴爬行者"
L["Chatter"] = "查特"
L["Clack the Reaver"] = "掠夺者科拉克"
L["Clattering Crawler"] = "巨钳蟹"
L["Cleft Scorpid"] = "裂隙沙漠蝎"
L["Cloud Serpent"] = "风蛇"
L["Cobalt Serpent"] = "蓝色毒蛇"
L["Coilskar Cobra"] = "库斯卡眼镜蛇"
L["Corrupted Mottled Boar"] = "堕落的杂斑野猪"
L["Corrupted Scorpid"] = "堕落蝎"
L["Coyote Packleader"] = "山狗首领"
L["Coyote"] = "山狗"
L["Crag Boar"] = "峭壁野猪"
L["Crag Coyote"] = "峭壁山狗"
L["Crag Stalker"] = "峭壁捕猎者"
L["Crazed Dragonhawk"] = "疯狂的龙鹰"
L["Creepthess"] = "克雷普塞斯"
L["Dark Screecher"] = "黑暗尖啸者"
L["Dark Worg"] = "黑暗座狼"
L["Darkfang Creeper"] = "暗牙爬行者"
L["Deadly Cleft Scorpid"] = "致命的裂隙沙漠蝎"
L["Deadmire"] = "死沼巨鳄"
L["Death Flayer"] = "死亡毒蝎"
L["Death Howl"] = "死亡之嚎"
L["Deathlash Scorpid"] = "死鞭蝎"
L["Deathstrike Tarantula"] = "死亡狼蛛"
L["Deep Stinger"] = "深渊钉刺者"
L["Deepmoss Creeper"] = "深苔爬行者"
L["Deepmoss Webspinner"] = "深苔结网蛛"
L["Den Mother"] = "雌蓟熊"
L["Deviate Adder"] = "无毒飞蛇"
L["Deviate Coiler Hatchling"] = "变异风蛇幼崽"
L["Deviate Coiler"] = "变异曲蛇"
L["Deviate Crocolisk"] = "变异鳄鱼"
L["Deviate Dreadfang"] = "变异尖牙风蛇"
L["Deviate Moccasin"] = "弱毒飞蛇"
L["Deviate Stinglash"] = "变异刺鞭蛇"
L["Deviate Venomwing"] = "变异剧毒风蛇"
L["Deviate Viper"] = "剧毒飞蛇"
L["Dire Mottled Boar"] = "可怕的杂斑野猪"
L["Diseased Grizzly"] = "生病的灰熊"
L["Diseased Wolf"] = "生病的狼"
L["Dread Flyer"] = "恐怖飞鸟"
L["Dread Ripper"] = "恐怖撕裂者"
L["Dreadfang Lurker"] = "巨牙潜伏者"
L["Dreadfang Widow"] = "巨牙寡妇蛛"
L["Dreadmaw Crocolisk"] = "巨齿鳄鱼"
L["Drywallow Crocolisk"] = "尘泥鳄鱼"
L["Drywallow Daggermaw"] = "尘泥利齿鳄鱼"
L["Drywallow Snapper"] = "尘泥钳嘴鳄鱼"
L["Durotar Tiger"] = "杜隆塔尔猛虎"
L["Eclipsion Dragonhawk"] = "日蚀龙鹰"
L["Elder Ashenvale Bear"] = "老灰谷熊"
L["Elder Cloud Serpent"] = "老风蛇"
L["Elder Crag Boar"] = "老峭壁野猪"
L["Elder Crag Coyote"] = "老峭壁山狗"
L["Elder Mistvale Gorilla"] = "老迈的薄雾谷猩猩"
L["Elder Moss Creeper"] = "老食苔蛛"
L["Elder Mottled Boar"] = "老杂斑野猪"
L["Elder Mountain Boar"] = "老山猪"
L["Elder Plainstrider"] = "老平原陆行鸟"
L["Elder Shadowmaw Panther"] = "老年深喉猎豹"
L["Elder Shardtooth"] = "老碎齿熊"
L["Elder Springpaw"] = "老魔泉豹"
L["Encrusted Surf Crawler"] = "硬壳海浪蟹"
L["Enraged Ravager"] = "被激怒的掠食者"
L["Felpaw Ravager"] = "魔爪掠夺者"
L["Felpaw Wolf"] = "魔爪狼"
L["Felsworn Scalewing"] = "魔誓鳞翼风蛇"
L["Feral Crag Coyote"] = "野生峭壁山狗"
L["Feral Dragonhawk Hatchling"] = "龙鹰雏鸟"
L["Feral Mountain Lion"] = "野生山地狮"
L["Ferocious Grizzled Bear"] = "凶猛的灰斑熊"
L["Fire Roc"] = "火鹏"
L["Firetail Scorpid"] = "火尾蝎"
L["Flatland Cougar"] = "平原狮"
L["Fleeting Plainstrider"] = "敏捷的平原陆行鸟"
L["Forest Lurker"] = "森林潜伏者"
L["Forest Moss Creeper"] = "森林食苔蛛"
L["Forest Spider"] = "森林蜘蛛"
L["Foreststrider Fledgling"] = "森林陆行鸟雏鸟"
L["Frostsaber Cub"] = "霜刃豹幼崽"
L["Frostsaber Huntress"] = "霜刃雌豹"
L["Frostsaber Stalker"] = "霜刃捕食者"
L["Ghamoo-ra"] = "加摩拉"
L["Ghost Saber"] = "幽灵豹"
L["Ghostclaw Lynx"] = "鬼爪山猫"
L["Ghostclaw Ravager"] = "鬼爪破坏者"
L["Ghostpaw Alpha"] = "幽爪前锋"
L["Ghostpaw Runner"] = "幽爪奔跑者"
L["Giant Foreststrider"] = "凶猛的森林陆行鸟"
L["Giant Moss Creeper"] = "巨型食苔蛛"
L["Giant Plains Creeper"] = "巨型平原狼蛛"
L["Giant Webwood Spider"] = "巨型树林蜘蛛"
L["Giant Wetlands Crocolisk"] = "巨型湿地鳄鱼"
L["Githyiss the Vile"] = "邪恶的基塞伊斯"
L["Goretusk"] = "血牙野猪"
L["Gray Bear"] = "灰熊"
L["Gray Forest Wolf"] = "森林灰狼"
L["Great Goretusk"] = "巨型血牙野猪"
L["Greater Duskbat"] = "巨型夜行蝙蝠"
L["Greater Firebird"] = "巨型火鸟"
L["Greater Fleshripper"] = "大碎尸鸟"
L["Greater Kraul Bat"] = "巨型沼泽蝙蝠"
L["Greater Tarantula"] = "巨型狼蛛"
L["Greater Thunderhawk"] = "大型雷鹰"
L["Greater Windroc"] = "大型风鹏"
L["Green Recluse"] = "绿色独行蛛"
L["Groddoc Thunderer"] = "格罗多克大猩猩"
L["Grovestalker Lynx "] = "林地山猫"
L["Grunter"] = "格朗特"
L["Gutripper"] = "裂肠者"
L["Hakkar'i Frostwing"] = "哈卡莱霜翼飞蛇"
L["Hakkar'i Sapper"] = "哈卡莱挖掘者"
L["Ice Claw Bear"] = "冰爪熊"
L["Ironback"] = "铁背龟"
L["Ironbeak Hunter"] = "铁喙狩猎者"
L["Ironbeak Owl"] = "铁喙猫头鹰"
L["Ironbeak Screecher"] = "铁喙尖啸者"
L["Ironfur Bear"] = "铁鬃熊"
L["Ironfur Patriarch"] = "铁鬃熊王"
L["Jaguero Stalker"] = "丛林猎豹"
L["Jungle Thunderer"] = "丛林大猩猩"
L["Juvenile Snow Leopard"] = "雪豹幼崽"
L["Kaliri Matriarch"] = "卡利鸟女王"
L["Kaliri Swooper"] = "卡利鸟飞扑者"
L["King Bangalash"] = "虎王邦加拉什"
L["Kraul Bat"] = "沼泽蝙蝠"
L["Krellack"] = "克里拉克"
L["Kresh"] = "克雷什"
L["Kurzen War Tiger"] = "库尔森战虎"
L["Lady Sathrah"] = "萨丝拉"
L["Large Crag Boar"] = "大峭壁野猪"
L["Large Loch Crocolisk"] = "大型洛克鳄"
L["Leech Widow"] = "吸血寡妇"
L["Loch Crocolisk"] = "洛克鳄"
L["Longsnout"] = "长鼻野猪"
L["Longtooth Howler"] = "长牙嚎叫者"
L["Longtooth Runner"] = "长牙奔跑者"
L["Lost Torranche"] = "迷失的步行鸟"
L["Lupos"] = "鲁伯斯s"
L["Magram Bonepaw"] = "玛格拉姆骨爪土狼"
L["Male Kaliri Hatchling"] = "雄性小卡利鸟"
L["Mangeclaw"] = "癞爪"
L["Mangy Mountain Boar"] = "癞皮山猪"
L["Mazzranache"] = "马兹拉纳其"
L["Mesa Buzzard"] = "山地秃鹰"
L["Mist Howler"] = "迷雾嚎叫者"
L["Mistvale Gorilla"] = "薄雾谷猩猩"
L["Mongress"] = "莫戈雷斯"
L["Monstrous Crawler"] = "巨型淤泥蟹"
L["Monstrous Plaguebat"] = "巨型瘟疫蝙蝠"
L["Moonstalker Runt"] = "月夜猛虎幼崽"
L["Moonstalker Sire"] = "月夜雄虎"
L["Mottled Boar"] = "杂斑野猪"
L["Mottled Drywallow Crocolisk"] = "尘泥杂斑鳄鱼"
L["Mountain Boar"] = "山猪"
L["Mountain Lion"] = "山地狮"
L["Mudrock Snapjaw"] = "泥石钳嘴龟"
L["Murk Slitherer"] = "黑暗滑行虫"
L["Murk Spitter"] = "黑暗粘液虫"
L["Naraxis"] = "纳拉克西斯"
L["Night Web Matriarch"] = "夜行雌蜘蛛"
L["Night Web Spider"] = "夜行蜘蛛"
L["Nightsaber"] = "夜刃豹"
L["Noxious Plaguebat"] = "毒性瘟疫蝙蝠"
L["Oasis Snapjaw"] = "绿洲钳嘴龟"
L["Ol' Sooty"] = "奥尔苏迪"
L["Old Cliff Jumper"] = "海崖奔跳者"
L["Old Grizzlegut"] = "灰腹老熊"
L["Olm the Wise"] = "智者奥尔姆"
L["Ornery Plainstrider"] = "暴躁的平原陆行鸟"
L["Panther"] = "黑豹"
L["Phoenix-Hawk Hatchling"] = "凤鹰幼崽"
L["Plague Lurker"] = "瘟疫潜伏者"
L["Plaguebat"] = "瘟疫蝙蝠"
L["Plagued Swine"] = "瘟疫野猪"
L["Plains Creeper"] = "平原狼蛛"
L["Porcine Entourage"] = "公主的随从"
L["Prairie Stalker"] = "草原捕食者"
L["Prairie Wolf Alpha"] = "草原狼前锋"
L["Prairie Wolf"] = "草原狼"
L["Princess"] = "公主"
L["Prowler"] = "觅食的灰狼"
L["Pygmy Surf Crawler"] = "小海浪蟹"
L["Quillfang Ravager"] = "钢牙掠食者"
L["Quillfang Skitterer"] = "钢牙飞掠者"
L["Rabid Blisterpaw"] = "疯狂的疱爪土狼"
L["Rabid Crag Coyote"] = "疯狂的峭壁山狗"
L["Ragged Scavenger"] = "蓬毛食腐狼"
L["Raging Agam'ar"] = "暴怒的阿迦玛"
L["Rak'Shiri"] = "拉克西里"
L["Ravage"] = "毁灭"
L["Ravager Specimen"] = "成型的掠食者"
L["Ravenous Windroc"] = "饥饿的风鹏"
L["Razorfang Hatchling"] = "刃齿幼崽"
L["Razzashi Adder"] = "拉扎什蝰蛇"
L["Razzashi Cobra"] = "拉扎什眼镜蛇"
L["Razzashi Serpent"] = "拉扎什毒蛇"
L["Rekk'tilac"] = "雷克提拉克"
L["Rema"] = "雷玛"
L["Ridge Huntress"] = "山脊雌豹"
L["Ridge Stalker Patriarch"] = "山脊雄豹"
L["Ridge Stalker"] = "山脊巡行者"
L["Rip-Blade Ravager"] = "裂刃剥石者"
L["Ripfang Lynx"] = "锋牙山猫"
L["Ripscale"] = "雷普斯凯尔"
L["Roc"] = "大鹏"
L["Rockhide Boar"] = "石皮野猪"
L["Rogue Vale Screecher"] = "游荡的山谷尖啸者"
L["Rotting Agam'ar"] = "腐烂的阿迦玛"
L["Salt Flats Vulture"] = "盐湖秃鹫"
L["Saltwater Snapjaw"] = "海水钳嘴龟"
L["Sandfury Guardian"] = "沙怒守护者"
L["Sarkoth"] = "萨科斯"
L["Savannah Patriarch"] = "草原狮王"
L["Sawtooth Snapper"] = "盐齿钳嘴鳄"
L["Scalewing Serpent"] = "鳞翼飞蛇"
L["Scarlet Tracking Hound"] = "血色捕猎犬"
L["Scarred Crag Boar"] = "有伤疤的峭壁野猪"
L["Scarshield Worg"] = "裂盾座狼"
L["Scorchshell Pincer"] = "灼壳蝎"
L["Scorpashi Lasher"] = "荒土鞭尾蝎"
L["Scorpashi Snapper"] = "荒土巨钳蝎"
L["Scorpashi Venomlash"] = "荒土毒尾蝎"
L["Scorpid Bonecrawler"] = "噬骨蝎"
L["Scorpid Duneburrower"] = "沙漠掘洞蝎"
L["Scorpid Dunestalker"] = "沙漠疾行蝎"
L["Scorpid Hunter"] = "沙漠猎食蝎"
L["Scorpid Reaver"] = "恐蝎劫掠者"
L["Scorpid Tail Lasher"] = "沙漠鞭尾蝎"
L["Scorpid Terror"] = "恐蝎"
L["Scorpid Worker"] = "蝎子"
L["Scorpok Stinger"] = "厚甲毒刺蝎"
L["Searing Roc"] = "炎鹏"
L["Shadow Panther"] = "暗影黑豹"
L["Shadowmaw Panther"] = "深喉猎豹"
L["Shadowwing Owl"] = "暗翼猫头鹰"
L["Shanda the Spinner"] = "纺织者杉达"
L["Shardtooth Bear"] = "碎齿熊"
L["Shore Crawler"] = "滩行蟹"
L["Shrike Bat"] = "利齿蝙蝠"
L["Silithid Creeper"] = "异种爬行者"
L["Silithid Swarmer"] = "异种群居蝎"
L["Silt Crawler"] = "淤泥蟹"
L["Silvermane Howler"] = "银鬃嗥狼"
L["Silvermane Stalker"] = "银鬃捕猎者"
L["Silvermane Wolf"] = "银鬃狼"
L["Sin'Dall"] = "辛达尔"
L["Skettis Kaliri"] = "斯克提斯卡利鸟"
L["Skittering Crustacean"] = "滑腻的甲壳蟹"
L["Small Crag Boar"] = "小型峭壁野猪"
L["Snapjaw"] = "钳嘴龟"
L["Snapping Crustacean"] = "巨钳甲壳蟹"
L["Snarler"] = "咆哮者"
L["Snow Tracker Wolf"] = "雪狼"
L["Son of Hakkar"] = "哈卡之子"
L["Soulflayer"] = "灵魂掠夺者"
L["Sparkleshell Snapper"] = "盐壳钳嘴龟"
L["Spawn of Hakkar"] = "哈卡的后代"
L["Spiteflayer"] = "斯比弗雷尔"
L["Spot"] = "斑斑"
L["Starving Blisterpaw"] = "饥饿的疱爪土狼"
L["Starving Mountain Lion"] = "饥饿的山地狮"
L["Starving Winter Wolf"] = "饥饿的冬狼"
L["Stonelash Flayer"] = "石鞭掠夺者"
L["Stonelash Pincer"] = "石鞭巨钳蝎"
L["Stonelash Scorpid"] = "石鞭蝎"
L["Stonetusk Boar"] = "石牙野猪"
L["Stranglethorn Tiger"] = "荆棘谷猛虎"
L["Strigid Hunter"] = "巨翼猎枭"
L["Strigid Owl"] = "巨翼枭"
L["Swamp Jaguar"] = "沼泽虎"
L["Swiftwing Shredder"] = "迅翼撕裂者"
L["Tarantula"] = "狼蛛"
L["Thistle Bear"] = "蓟熊"
L["Thistle Boar"] = "草刺野猪"
L["Thornfang Ravager"] = "棘牙掠食者"
L["Thornfang Venomspitter"] = "棘牙喷毒者"
L["Thunderhawk Cloudscraper"] = "雷鹰破云者"
L["Thunderhawk Hatchling"] = "雷鹰雏鸟"
L["Tide Crawler"] = "潮行蟹"
L["Timber Worg"] = "森林座狼"
L["Timber"] = "狂暴的冬狼"
L["Timberweb Recluse"] = "林木隐匿者"
L["Twilight Runner"] = "夜行虎"
L["U'cha"] = "尤尔查"
L["Uhk'loc"] = "乌卡洛克"
L["Un'Goro Thunderer"] = "安戈洛大猩猩"
L["Vale Screecher"] = "山谷尖啸者"
L["Venomlash Scorpid"] = "毒鞭蝎"
L["Venomous Cloud Serpent"] = "毒性风蛇"
L["Venomtail Scorpid"] = "毒尾蝎"
L["Venomtip Scorpid"] = "毒尖蝎"
L["Vicious Night Web Spider"] = "邪恶的夜行蜘蛛"
L["Vile Sting"] = "邪刺恐蝎"
L["Vilebranch Raiding Wolf"] = "邪枝巨狼"
L["Warp Chaser"] = "迁跃追迹者"
L["Warp Hunter"] = "迁跃猎手"
L["Warp Stalker"] = "迁跃捕猎者"
L["Washte Pawne"] = "瓦希塔帕恩"
L["Wayward Buzzard"] = "游荡的秃鹫"
L["Webwood Silkspinner"] = "树林结网蛛"
L["Webwood Venomfang"] = "树林毒蜘蛛"
L["Wildthorn Lurker"] = "野棘潜伏者"
L["Windroc Hunter"] = "雄性狩猎风鹏"
L["Windroc Huntress"] = "雌性狩猎风鹏"
L["Windroc Matriarch"] = "风鹏皇后"
L["Windroc"] = "风鹏"
L["Winter Wolf"] = "冬狼"
L["Winterspring Owl"] = "冬泉巨枭"
L["Winterspring Screecher"] = "冬泉鸣枭"
L["Wood Lurker"] = "林木潜伏者"
L["Worg"] = "座狼"
L["Young Forest Bear"] = "森林熊幼崽"
L["Young Goretusk"] = "幼年血牙野猪"
L["Young Mesa Buzzard"] = "山地秃鹰幼崽"
L["Young Panther"] = "猎豹幼崽"
L["Young Stranglethorn Tiger"] = "荆棘谷猛虎幼崽"
L["Young Thistle Boar"] = "草刺野猪幼崽"
L["Zaricotl"] = "扎里科特"
L["Zulian Panther"] = "祖利安雌猎虎"
L["Zulian Stalker"] = "祖利安捕猎者"

-- Vendor Names Localized by 冰焱妩魅 @ CWDG
L["Aaron Hollman"] = "埃隆·霍尔曼"
L["Abigail Shiel"] = "阿比盖尔·沙伊尔"
L["Aged Dalaran Wizard"] = "老迈的达拉然巫师"
L["Alchemist Gribble"] = "炼金师格里比"
L["Alchemist Pestlezugg"] = "炼金师匹斯特苏格"
L["Aldraan"] = "阿尔德兰"
L["Alexandra Bolero"] = "亚历山德拉·波利罗"
L["Algernon"] = "奥格诺恩"
L["Altaa"] = "奥泰恩"
L["Amy Davenport"] = "艾米·达文波特"
L["Andrew Hilbert"] = "安德鲁·希尔伯特"
L["Andrion Darkspinner"] = "安迪恩·达克斯宾"
L["Androd Fadran"] = "安多德·法德兰"
L["Apothecary Antonivich"] = "药剂师安东尼维奇"
L["Aresella"] = "阿蕾瑟拉"
L["Arras"] = "阿尔拉斯"
L["Arred"] = "阿尔雷德"
L["Arrond"] = "阿隆德"
L["Asarnan"] = "阿萨纳"
L["Balai Lok'Wein"] = "巴莱·洛克维"
L["Bale"] = "拜尔"
L["Banalash"] = "巴纳拉什"
L["Blimo Gadgetspring"] = "布里莫"
L["Blixrez Goodstitch"] = "布里克雷兹·古斯提"
L["Blizrik Buckshot"] = "布雷兹里克·巴克舒特"
L["Bliztik"] = "布里兹提克"
L["Bombus Finespindle"] = "伯布斯·钢轴"
L["Borto"] = "波尔图"
L["Borya"] = "博亚"
L["Brienna Starglow"] = "布琳娜·星光"
L["Bro'kin"] = "布洛金"
L["Bronk"] = "布隆克"
L["Burbik Gearspanner"] = "巴比克·齿轮"
L["Burko"] = "布尔库"
L["Captured Gnome"] = "被俘虏的侏儒"
L["Catherine Leland"] = "凯瑟琳·利兰"
L["Christoph Jeffcoat"] = "克里斯托弗·杰弗寇特"
L["Clyde Ranthal"] = "克莱德·兰萨尔"
L["Constance Brisboise"] = "康斯坦茨·布里斯博埃斯"
L["Cookie McWeaksauce"] = "“曲奇”米维克索斯"
L["Cookie One-Eye"] = "独眼曲奇"
L["Coreiel"] = "克蕾伊尔"
L["Corporal Bluth"] = "布鲁斯下士"
L["Cowardly Crosby"] = "怯懦的克罗斯比"
L["Crazk Sparks"] = "克拉赛·斯巴克斯"
L["Cro Threadstrong"] = "克鲁·粗线"
L["Daga Ramba"] = "达加·拉姆巴"
L["Daggle Ironshaper"] = "达格尔·塑铁"
L["Dalria"] = "达利亚"
L["Daniel Bartlett"] = "丹尼尔·巴特莱特"
L["Danielle Zipstitch"] = "丹尼勒·希普斯迪"
L["Darian Singh"] = "达利安·辛格"
L["Darnall"] = "旅店老板达纳尔"
L["Dealer Malij"] = "商人玛里耶"
L["Defias Profiteer"] = "迪菲亚奸商"
L["Deneb Walker"] = "德尼布·沃克"
L["Derak Nightfall"] = "德拉克·奈特弗"
L["Deynna"] = "德伊娜"
L["Dirge Quikcleave"] = "迪尔格·奎克里弗"
L["Doba"] = "度巴"
L["Drac Roughcut"] = "德拉克·卷刃"
L["Drake Lindgren"] = "德拉克·林格雷"
L["Drovnar Strongbrew"] = "德鲁纳·烈酒"
L["Edna Mullby"] = "巴比克·齿轮"
L["Egomis"] = "艾苟米斯"
L["Eiin"] = "伊恩"
L["Elynna"] = "艾琳娜"
L["Emrul Riknussun"] = "埃姆鲁尔·里克努斯"
L["Eriden"] = "恩里德"
L["Erika Tate"] = "艾瑞卡·塔特"
L["Erilia"] = "艾瑞丽亚"
L["Feera"] = "菲拉"
L["Felannia"] = "菲兰妮娅"
L["Felicia Doan"] = "菲利希亚·杜安"
L["Felika"] = "菲利卡"
L["Fradd Swiftgear"] = "弗拉德"
L["Fyldan"] = "菲尔丹"
L["Gagsprocket"] = "加格斯普吉特"
L["Gambarinka"] = "加巴林卡"
L["Gearcutter Cogspinner"] = "考格斯宾"
L["Gelanthis"] = "基兰希斯"
L["George Candarte"] = "乔治·坎达特"
L["Gharash"] = "卡尔拉什"
L["Ghok'kah"] = "格鲁克卡恩"
L["Gidge Spellweaver"] = "金吉·斯比维尔"
L["Gigget Zipcoil"] = "吉盖特·火油"
L["Gikkix"] = "吉科希斯"
L["Gina MacGregor"] = "吉娜·马克葛瑞格"
L["Gloria Femmel"] = "格劳瑞亚·菲米尔"
L["Glyx Brewright"] = "格里克斯·布鲁维特"
L["Gnaz Blunderflame"] = "格纳兹·枪焰"
L["Gretta Ganter"] = "格雷塔·甘特"
L["Grimtak"] = "格瑞姆塔克"
L["Haalrun"] = "海尔伦"
L["Haferet"] = "哈弗雷特"
L["Hagrus"] = "哈格鲁斯"
L["Hammon Karwn"] = "哈蒙·卡文"
L["Harggan"] = "哈尔甘"
L["Harklan Moongrove"] = "哈克兰·月林"
L["Harlown Darkweave"] = "哈鲁恩·暗纹"
L["Harn Longcast"] = "哈恩·长线"
L["Heldan Galesong"] = "海尔丹·风歌"
L["Helenia Olden"] = "海伦妮亚·奥德恩"
L["Himmik"] = "西米克"
L["Hula'mahi"] = "哈拉玛"
L["Innkeeper Biribi"] = "旅店老板贝莉比"
L["Innkeeper Fizzgrimble"] = "旅店老板菲兹格瑞博"
L["Innkeeper Grilka"] = "旅店老板格里尔卡"
L["Jabbey"] = "加贝"
L["Jandia"] = "詹迪亚"
L["Janet Hommers"] = "詹奈特·霍莫斯"
L["Jangdor Swiftstrider"] = "杉多尔·迅蹄"
L["Jannos Ironwill"] = "加诺斯·铁心"
L["Jaquilina Dramet"] = "加奎琳娜·德拉米特"
L["Jase Farlane"] = "贾斯·法拉恩"
L["Jazzrik"] = "加兹里克"
L["Jeeda"] = "基达"
L["Jennabink Powerseam"] = "吉娜比克·铁线"
L["Jessara Cordell"] = "杰萨拉·考迪尔"
L["Jim Saltit"] = "吉姆·萨迪特"
L["Jinky Twizzlefixxit"] = "金克·铁钩"
L["Johan Barnes"] = "乔汉·巴内斯"
L["Joseph Moore"] = "约瑟夫·摩尔"
L["Jubie Gadgetspring"] = "朱比"
L["Jun'ha"] = "祖恩哈"
L["Juno Dufrain"] = "基诺·杜弗莱"
L["Jutak"] = "祖塔克"
L["Kaita Deepforge"] = "凯塔·深炉"
L["Kalaen"] = "卡莱恩"
L["Kalldan Felmoon"] = "卡尔丹·暗月"
L["Kania"] = "卡妮亚"
L["Keena"] = "基纳"
L["Kelsey Yance"] = "凯尔希·杨斯"
L["Kendor Kabonka"] = "肯多尔·卡邦卡"
L["Khara Deepwater"] = "卡拉·深水"
L["Kiknikle"] = "吉克尼库"
L["Killian Sanatha"] = "基利恩·萨纳森"
L["Kilxx"] = "基尔克斯"
L["Kireena"] = "基瑞娜"
L["Kithas"] = "基萨斯"
L["Knaz Blunderflame"] = "克纳兹·枪焰"
L["Kor'geld"] = "考吉尔德"
L["Krek Cragcrush"] = "克雷格·碎岩"
L["Kriggon Talsone"] = "克雷贡·塔尔松"
L["Krinkle Goodsteel"] = "克林科·古德斯迪尔"
L["Kulwia"] = "库尔维亚"
L["Kzixx"] = "卡兹克斯"
L["Laird"] = "莱尔德"
L["Landraelanis"] = "兰达兰尼斯"
L["Lardan"] = "拉尔丹"
L["Lebowski"] = "莱布斯基"
L["Leeli Longhaggle"] = "莉莉·朗哈格"
L["Leo Sarn"] = "雷欧·萨恩"
L["Leonard Porter"] = "莱纳德·波特"
L["Lilly"] = "莉蕾"
L["Lindea Rabonne"] = "林迪·拉波尼"
L["Lizbeth Cromwell"] = "莉兹白·克伦威尔"
L["Logannas"] = "洛加纳斯"
L["Loolruna"] = "卢尔鲁娜"
L["Lorelae Wintersong"] = "罗莱尔·冬歌"
L["Lyna"] = "琳娜"
L["Madame Ruby"] = "卢比夫人"
L["Mahu"] = "曼胡"
L["Mallen Swain"] = "玛林·斯万"
L["Malygen"] = "玛里甘"
L["Mari Stonehand"] = "玛里·石拳"
L["Maria Lumere"] = "玛丽亚·卢米尔"
L["Martine Tramblay"] = "马丁·塔布雷"
L["Masat T'andr"] = "马萨特·坦德"
L["Master Chef Mouldier"] = "大厨师莫迪尔"
L["Mathar G'ochar"] = "玛萨·格卡尔"
L["Mavralyn"] = "马弗拉林"
L["Mazk Snipeshot"] = "玛兹克·斯奈普沙特"
L["Melaris"] = "梅拉瑞斯"
L["Micha Yance"] = "米沙·杨斯"
L["Millie Gregorian"] = "米利尔·格里高利"
L["Mishta"] = "米什塔"
L["Mixie Farshot"] = "米希·法索"
L["Montarr"] = "莫塔尔"
L["Muheru the Weaver"] = "编织者姆赫鲁"
L["Muuran"] = "穆尔兰"
L["Mythrin'dir"] = "迈斯林迪尔"
L["Naal Mistrunner"] = "纳尔·迷雾行者"
L["Namdo Bizzfizzle"] = "纳姆杜"
L["Nandar Branson"] = "南达·布拉森"
L["Narkk"] = "纳尔克"
L["Nasmara Moonsong"] = "纳丝玛拉·月歌"
L["Nata Dawnstrider"] = "纳塔·黎明行者"
L["Neal Allen"] = "尼尔·奥雷"
L["Neii"] = "奈伊"
L["Nergal"] = "奈尔加"
L["Nerrist"] = "耐里斯特"
L["Nessa Shadowsong"] = "尼莎·影歌"
L["Nina Lightbrew"] = "妮娜·莱特布鲁"
L["Nioma"] = "尼奥玛"
L["Nula the Butcher"] = "屠夫努尔拉"
L["Nyoma"] = "奈欧玛"
L["Ogg'marr"] = "奥克玛尔"
L["Otho Moji'ko"] = "奥索·莫吉克"
L["Outfitter Eric"] = "埃瑞克"
L["Phea"] = "菲恩"
L["Plugger Spazzring"] = "普拉格"
L["Pratt McGrubben"] = "普拉特·马克格鲁比"
L["Qia"] = "琦亚"
L["Quartermaster Davian Vaclav"] = "军需官达维安·瓦克拉弗"
L["Quartermaster Jaffrey Noreliqe"] = "军需官亚弗雷·诺雷里克"
L["Quelis"] = "奎尔里斯"
L["Ranik"] = "拉尼克"
L["Rann Flamespinner"] = "拉恩·火翼"
L["Rartar"] = "拉尔塔"
L["Rathis Tomber"] = "拉提斯·托博尔"
L["Rikqiz"] = "雷克奇兹"
L["Rizz Loosebolt"] = "里兹·飞矢"
L["Rohok"] = "罗霍克"
L["Ronald Burch"] = "罗纳德·伯奇"
L["Rungor"] = "伦格尔"
L["Ruppo Zipcoil"] = "鲁普·火油"
L["Saenorion"] = "塞诺里奥"
L["Seer Janidi"] = "先知亚尼迪"
L["Sewa Mistrunner"] = "苏瓦·迷雾行者"
L["Shadi Mistrunner"] = "沙迪·迷雾行者"
L["Shankys"] = "山吉斯"
L["Sheendra Tallgrass"] = "希恩德拉·深草"
L["Shen'dralar Provisioner"] = "辛德拉圣职者"
L["Sheri Zipstitch"] = "舍瑞·希普斯迪"
L["Sid Limbardi"] = "希德·利巴迪"
L["Skreah"] = "斯克雷亚"
L["Soolie Berryfizz"] = "苏雷·浆泡"
L["Sovik"] = "索维克"
L["Stuart Fleming"] = "斯图亚特·弗雷明"
L["Sumi"] = "苏米"
L["Super-Seller 680"] = "超级商人680型"
L["Supply Officer Mills"] = "供给官米尔斯"
L["Tamar"] = "达玛尔"
L["Tansy Puddlefizz"] = "坦斯·泥泡"
L["Tarban Hearthgrain"] = "塔班·熟麦"
L["Tari'qa"] = "塔里查"
L["Tatiana"] = "塔蒂亚娜"
L["Thaddeus Webb"] = "萨德乌斯·韦伯"
L["Tharynn Bouden"] = "萨瑞恩·博丁"
L["Thomas Yance"] = "托马斯·杨斯"
L["Tilli Thistlefuzz"] = "提尔利·草须"
L["Truk Wildbeard"] = "特鲁克·蛮鬃"
L["Tunkk"] = "吞克"
L["Ulthaan"] = "尤萨恩"
L["Ulthir"] = "尤希尔"
L["Uriku"] = "乌利库"
L["Uthok"] = "尤索克"
L["Vaean"] = "维安"
L["Valdaron"] = "瓦尔达隆"
L["Veenix"] = "维尼克斯"
L["Vendor-Tron 1000"] = "贸易机器人1000型"
L["Vharr"] = "维哈尔"
L["Viggz Shinesparked"] = "维格兹·沙斯巴克"
L["Vivianna"] = "薇薇安娜"
L["Vizzklick"] = "维兹格里克"
L["Vodesiin"] = "沃德辛"
L["Wenna Silkbeard"] = "温纳·银须"
L["Werg Thickblade"] = "维尔格·厚刃"
L["Wik'Tar"] = "维克塔"
L["Wind Trader Lathrai"] = "星界商人拉斯莱"
L["Wrahk"] = "瓦尔克"
L["Wulan"] = "乌兰"
L["Wunna Darkmane"] = "温纳·黑鬃"
L["Xandar Goodbeard"] = "山达·细须"
L["Xen'to"] = "克森图"
L["Xizk Goodstitch"] = "希兹克·古斯提"
L["Xizzer Fizzbolt"] = "希兹尔·菲兹波特"
L["Yatheon"] = "亚瑟恩"
L["Yonada"] = "犹纳达"
L["Yuka Screwspigot"] = "尤卡·斯库比格特"
L["Yurial Soulwater"] = "尤利安·魂水"
L["Zan Shivsproket"] = "萨恩·刀链"
L["Zannok Hidepiercer"] = "扎诺克"
L["Zansoa"] = "詹苏尔"
L["Zaralda"] = "萨拉尔达"
L["Zarena Cromwind"] = "萨瑞娜·克罗姆温德"
L["Zixil"] = "吉克希尔"
L["Zorbin Fandazzle"] = "索尔宾·范达瑟"
L["Zurai"] = "祖莱"
L["Narj Deepslice"] = "纳尔基·长刀"
L["Fazu"] = "法苏"
L["Zargh"] = "扎尔夫"
L["Smudge Thunderwood"] = "斯穆德·雷木"
L["Sassa Weldwell"] = "萨莎·焊井"
