﻿--[[
--AtlasLoot loot tables zhCN localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--NOTE-zhCN: 本文件是由程序自动生成的，请勿人工干预，任何手动更改都可能会被覆盖！
--$Date: 2008-06-08 03:26:14 -0400 (Sun, 08 Jun 2008) $
--]]
if (GetLocale() == "zhCN") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootSetItems"][category] or #AtlasLoot_Data["AtlasLootSetItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootSetItems"][category][i][3] = data[i] end end data = nil end
Process("AQ20Druid",4,{"","=q4=不灭生命之锤","=q4=不灭生命披风","=q4=不灭生命之戒"})
Process("AQ20Hunter",4,{"","=q4=隐秘通途之镰","=q4=隐秘通途披风","=q4=隐秘通途之戒"})
Process("AQ20Mage",4,{"","=q4=魔法秘密之刃","=q4=魔法秘密披风","=q4=魔法秘密之戒"})
Process("AQ20Paladin",4,{"","=q4=永恒公正长剑","=q4=永恒公正斗篷","=q4=永恒公正之戒"})
Process("AQ20Priest",4,{"","=q4=无尽智慧之锤","=q4=无尽智慧披风","=q4=无尽智慧之戒"})
Process("AQ20Rogue",4,{"","=q4=笼罩阴影匕首","=q4=笼罩阴影披风","=q4=笼罩阴影之戒"})
Process("AQ20Shaman",4,{"","=q4=聚集风暴之锤","=q4=聚集风暴披风","=q4=聚集风暴之戒"})
Process("AQ20Warlock",4,{"","=q4=禁断邪语短剑","=q4=禁断邪语披风","=q4=禁断邪语之戒"})
Process("AQ20Warrior",4,{"","=q4=坚定力量之镰","=q4=坚定力量披风","=q4=坚定力量之戒"})
Process("AQ40Druid",6,{"","=q4=起源外套","=q4=起源头盔","=q4=起源长裤","=q4=起源护肩","=q4=起源长靴"})
Process("AQ40Hunter",6,{"","=q4=攻击者的护甲","=q4=攻击者的王冠","=q4=攻击者的护腿","=q4=攻击者的护肩","=q4=攻击者的足甲"})
Process("AQ40Mage",6,{"","=q4=神秘长袍","=q4=神秘头饰","=q4=神秘护腿","=q4=神秘肩垫","=q4=神秘长靴"})
Process("AQ40Paladin",6,{"","=q4=复仇者的胸甲","=q4=复仇者的王冠","=q4=复仇者的护腿","=q4=复仇者的护肩","=q4=复仇者的胫甲"})
Process("AQ40Priest",6,{"","=q4=神谕者的外套","=q4=神谕者的皇冠","=q4=神谕者的长裤","=q4=神谕者的衬肩","=q4=神谕者的裹足"})
Process("AQ40Rogue",6,{"","=q4=死亡执行者的胸甲","=q4=死亡执行者的头盔","=q4=死亡执行者的护腿","=q4=死亡执行者的护肩","=q4=死亡执行者的长靴"})
Process("AQ40Shaman",6,{"","=q4=风暴召唤者的护甲","=q4=风暴召唤者的王冠","=q4=风暴召唤者的护腿","=q4=风暴召唤者的肩甲","=q4=风暴召唤者的足甲"})
Process("AQ40Warlock",6,{"","=q4=厄运召唤者的长袍","=q4=厄运召唤者的头饰","=q4=厄运召唤者的长裤","=q4=厄运召唤者的衬肩","=q4=厄运召唤者的裹足"})
Process("AQ40Warrior",6,{"","=q4=征服者的胸甲","=q4=征服者的皇冠","=q4=征服者的腿铠","=q4=征服者的肩铠","=q4=征服者的胫甲"})
Process("BlizzardCollectables1",8,{"=q3=鱼人服装","=q3=乐奇的蛋","=q3=蓝色鱼人卵","=q3=粉色鱼人卵","=q3=熊猫项圈","=q3=破坏神之石","=q3=跳虫绳索","=q3=虚空龙宝宝项圈"})
Process("CardGame1",30,{"","=q4=烈焰徽章","=q4=角鹰兽宝宝","=q4=乌龟坐骑","","","=q3=猴子护符","=q3=午餐篮","=q3=球中的小鬼","","","=q4=迅捷幽灵虎缰绳","=q3=幽灵虎缰绳","=q3=钓鱼椅","=q3=地精杂烩煲","","=q4=风筝龙","=q3=火箭鸡","=q3=纸飞机工具包","","","=q4=X-51虚空火箭特别加强版","=q3=X-51虚空火箭","=q4=地精天气制造机 - 原型机01-B","=q3=修默老爹的宠物饼干"})
Process("CardGame2",4,{"","=q4=冰霜徽章","=q4=永久紫色焰火","=q4=食人魔玩偶"})
Process("DS3Assassin",5,{"=q3=刺杀头盔","=q3=刺杀护肩","=q3=刺杀外套","=q3=刺杀手套","=q3=刺杀护腿"})
Process("DS3Beast",5,{"=q3=巨兽之王头盔","=q3=巨兽之王肩甲","=q3=巨兽之王胸甲","=q3=巨兽之王护手","=q3=巨兽之王护腿"})
Process("DS3Bold",5,{"=q3=鲁莽战盔","=q3=鲁莽肩甲","=q3=鲁莽胸甲","=q3=鲁莽护手","=q3=鲁莽腿铠"})
Process("DS3Desolation",5,{"=q3=荒芜头盔","=q3=荒芜肩甲","=q3=荒芜胸甲","=q3=荒芜手套","=q3=荒芜腿甲"})
Process("DS3Doom",5,{"=q3=末日板甲战盔","=q3=末日板甲护肩","=q3=末日板甲护胸","=q3=末日板甲手套","=q3=末日板甲护腿"})
Process("DS3Hallowed",5,{"=q3=圣徒头冠","=q3=圣徒护肩","=q3=圣徒外衣","=q3=圣徒裹手","=q3=圣徒长裤"})
Process("DS3Incanter",5,{"=q3=魔咒师兜帽","=q3=魔咒师护肩","=q3=魔咒师长袍","=q3=魔咒师手套","=q3=魔咒师长裤"})
Process("DS3Mana",5,{"=q3=法力蚀刻皇冠","=q3=法力蚀刻肩甲","=q3=法力蚀刻外衣","=q3=法力蚀刻手套","=q3=法力蚀刻长裤"})
Process("DS3Moonglade",5,{"=q3=月光林地罩帽","=q3=月光林地护肩","=q3=月光林地长袍","=q3=月光林地裹手","=q3=月光林地短裤"})
Process("DS3Oblivion",5,{"=q3=湮灭兜帽","=q3=湮灭护肩","=q3=湮灭长袍","=q3=湮灭手套","=q3=湮灭长裤"})
Process("DS3Right",5,{"=q3=正义头盔","=q3=正义肩铠","=q3=正义胸铠","=q3=正义护手","=q3=正义腿铠"})
Process("DS3Tidefury",5,{"=q3=潮汐之怒头盔","=q3=潮汐之怒护肩","=q3=潮汐之怒胸甲","=q3=潮汐之怒护手","=q3=潮汐之怒褶裙"})
Process("DS3Wastewalker",5,{"=q3=废土行者头盔","=q3=废土行者肩甲","=q3=废土行者外套","=q3=废土行者手套","=q3=废土行者护腿"})
Process("HardModeAccessories",30,{"","=q4=灵巧胸针","=q4=邪恶意图项圈","=q4=永恒希冀项链","=q4=崇神项链","=q4=法力涌动坠饰","=q4=光晕指环","=q4=阿拉希督军之戒","=q4=沉睡梦境之戒","=q4=不屈力量之戒","","=q3=源生虚空","=q4=天蓝宝石","=q4=焚石","=q4=狮眼石","=q4=战斗大师的活跃","=q4=战斗大师的勇猛","=q4=战斗大师的残暴","=q4=战斗大师的堕落","=q4=战斗大师的决心","=q4=战斗大师的坚定","=q4=嗜血胸针","=q4=殉难者精华","=q4=诺莫瑞根自动格挡器600型","=q4=银色新月徽记","","=q4=虚空漩涡","=q4=海浪翡翠","=q4=影歌紫玉","=q4=赤尖石"})
Process("HardModeAccessories2",5,{"","=q4=安格莉丝塔的复仇","=q4=安薇娜的触摸","=q4=虚空精华指环","=q4=坚定卫士指环"})
Process("HardModeCloaks",11,{"","=q4=主教披风","=q4=血骑士作战披风","=q4=奥法敏锐披风","=q4=压制能量披风","=q4=缓痛披风","=q4=多莉的拥抱","=q4=远行者卫士披风","=q4=卡尔玛的希望披风","=q4=变幻机遇披风","=q4=斯里克的安抚披风"})
Process("HardModeCloth",25,{"","=q4=纳鲁祝福兜帽","=q4=魔法束缚罩帽","=q4=符印法术护腕","=q4=静谧思绪护腕","=q4=光明祝福裹手","=q4=谨慎护手","=q4=巫毒纹路腰带","=q4=奥法毁灭长裤","=q4=纳鲁的素色长裤","","","","","","","=q4=灵魂奇迹法衣","=q4=罗雷尼尔长袍","=q4=苦痛魔魂长袍","=q4=末日卫士的灵魂之握","=q4=天神纹饰护腿","=q4=腐蚀魂织长裤","=q4=炽焰护腿","=q4=魔咒长靴","=q4=忠诚治愈之鞋"})
Process("HardModeLeather",22,{"","=q4=野性怒火兜帽","=q4=原始能量面具","=q4=欺诈者面具","=q4=纠结铁木肩甲","=q4=部族怒火肩甲","=q4=神圣艾露恩宝石外套","=q4=休眠胸甲","=q4=卡多雷保卫者护臂","=q4=迅捷豹爪护腕","=q4=加尔贡的平静休眠护腕","=q4=刺杀大师护腕","=q4=枭兽之握","=q4=诡计手套","=q4=星火腰带","","=q4=巨兽腰带","=q4=疾速恢复短裤","=q4=浅坟长裤","=q4=狂野侵略护足","=q4=奈加恩的长靴","=q4=月行者"})
Process("HardModeLeather2",13,{"","=q4=永恒勇武护胸","=q4=星光之拥","=q4=自然和谐外衣","=q4=黑暗时刻外套","=q4=先知的荆棘手套","=q4=侵掠手套","=q4=橡叶护手","=q4=寂静路途腰带","=q4=晶风护腿","=q4=巡林者护腿","=q4=桀骜长裤","=q4=占星者侍从长裤"})
Process("HardModeMail",30,{"","=q4=风暴大师头盔","=q4=星界猎手头盔","=q4=愤怒元素肩铠","=q4=狂怒元素套甲","=q4=地震护腕","=q4=闪烁土灵护腕","=q4=平稳护腕","=q4=狙击护手","=q4=自然愤怒之握","=q4=抛光水鳞手套","=q4=曼金杜腰带","=q4=风暴之束","=q4=战羽之环","=q4=自然生命护腿","=q4=狡诈伪装短裤","=q4=鸣雷战靴","=q4=生命之路长靴","","","","=q4=龙皮鳞甲","=q4=涡流之怒外套","=q4=生命波浪胸甲","=q4=迅急手套","=q4=余震腰带","=q4=抚慰轻风腰带","=q4=追击护腿","=q4=符文古鳞护腿","=q4=疾速风暴褶裙"})
Process("HardModePlate",21,{"","=q4=阿曼尼死亡面具","=q4=决心面甲","=q4=坚定勇士头盔","=q4=恐怖命运肩铠","=q4=自律守护者胸甲","=q4=上古方阵护腕","=q4=恒金怒火护腕","=q4=纳鲁臂铠","=q4=骨拳护手","=q4=愤怒死亡护手","=q4=圣殿骑士护手","=q4=怒火释放之链","=q4=保卫者束带","=q4=铁牙束带","","=q4=嗜血者的胫甲","=q4=最高审判者腿铠","=q4=坚毅护腿","=q4=警觉卫士战靴","=q4=正义防御者战靴"})
Process("HardModePlate2",13,{"","=q4=愤恨胸铠","=q4=淡泊胸铠","=q4=神职者的胸甲","=q4=沙塔斯护卫胸铠","=q4=沸腾怒气护腰","=q4=无畏者腰带","=q4=弥补腰带","=q4=镇静腿甲","=q4=奥尔多铭文腿铠","=q4=无尽怒火腿铠","=q4=太阳卫士腿铠","=q4=正义卫士胫甲"})
Process("HardModeRelic",20,{"","=q4=四季鲜花神像","=q4=新生神像","=q4=恐惧神像","=q4=隐月神像","","=q4=天鸣图腾","=q4=碎石图腾","=q4=活水图腾","=q4=地脉图腾","","","","","","","=q4=神圣裁决圣契","=q4=神圣意志圣契","=q4=治愈圣契","=q4=悔改圣契"})
Process("HardModeResist",26,{"","=q4=地狱炎纹长袍","=q4=地狱炎纹手套","=q4=地狱炎纹护腿","=q4=地狱炎纹长靴","","","=q4=炼狱硬化护胸","=q4=炼狱硬化手套","=q4=炼狱硬化护腿","=q4=炼狱硬化战靴","","=q4=公正徽章","","","","=q4=炼狱熔铸胸甲","=q4=炼狱熔铸手套","=q4=炼狱熔铸护腿","=q4=炼狱熔铸战靴","","","=q4=炼狱淬火胸甲","=q4=炼狱淬火护手","=q4=炼狱淬火护腿","=q4=炼狱淬火战靴"})
Process("HardModeWeapons",27,{"","=q4=灼热阳炎之刃","=q4=雕刻过的巫医之杖","=q4=麦索瑞尔荣耀之盾","=q4=光明信仰之盾","=q4=考达拉碧空之盾","=q4=原始神灵雕像","=q4=焰舌封印","=q4=卡德加的背包","=q4=食魂者宝珠","=q4=萨菲隆的翼骨","=q4=卡雷苟斯符咒","=q4=天堂之泪","=q4=巫毒搅拌器","","","=q4=锯刃","=q4=纳鲁赐福之槌","=q4=占星者的聚焦匕首","=q4=瓦尼尔的残忍右拳套","=q4=瓦尼尔的残忍左拳套","=q4=瓦尼尔的野蛮左拳套","=q4=无常","=q4=毁伤","=q4=先兆","=q4=森林之王的法杖","=q4=无情打击之弩"})
Process("Legendaries",26,{"=q5=安杜尼苏斯，灵魂的收割者","=q5=雷霆之怒，逐风者的祝福之剑","=q5=萨弗拉斯，炎魔拉格纳罗斯之手","=q5=黑色其拉共鸣水晶","","=q5=埃提耶什，守护者的传说之杖","=q5=埃提耶什，守护者的传说之杖","=q5=埃提耶什，守护者的传说之杖","=q5=埃提耶什，守护者的传说之杖","","","","","","","=q5=埃辛诺斯战刃","=q5=埃辛诺斯战刃","","=q5=无尽之刃","=q5=迁跃切割者","=q5=宇宙灌注者","=q5=毁灭","=q5=瓦解法杖","=q5=相位壁垒","=q5=灵弦长弓","=q5=虚空尖刺"})
Process("RareMounts1",12,{"=q5=黑色其拉共鸣水晶","","=q4=死亡军马的缰绳","=q4=拉扎什迅猛龙","=q4=迅捷祖利安猛虎","=q4=冬泉霜刃豹缰绳","=q4=乌龟坐骑","","=q3=蓝色其拉共鸣水晶","=q3=绿色其拉共鸣水晶","=q3=红色其拉共鸣水晶","=q3=黄色其拉共鸣水晶"})
Process("RareMounts2",26,{"=q4=迅捷虚空幼龙","=q4=残酷角斗士的虚空幼龙","","=q4=奥的灰烬","=q4=炽热战马的缰绳","=q4=乌鸦之神的缰绳","=q4=阿曼尼战熊","","=q4=迅捷幽灵虎缰绳","=q3=幽灵虎缰绳","=q4=X-51虚空火箭特别加强版","=q3=X-51虚空火箭","","","","=q4=涡轮加速飞行器控制台","=q3=飞行器控制台","","=q4=迅捷美酒节赛羊","=q3=美酒节赛羊","","=q4=迅捷飞行扫帚","=q4=迅捷魔法扫帚","=q3=飞行扫帚","=q3=旧魔法扫帚","=q2=摇摇晃晃的魔法扫帚"})
Process("T0Druid",24,{"","=q3=野性之心兜帽","=q3=野性之心肩甲","=q3=野性之心外衣","=q3=野性之心护腕","=q3=野性之心手套","=q3=野性之心腰带","=q3=野性之心褶裙","=q3=野性之心长靴","","","","","","","","=q4=狂野之心罩帽","=q3=狂野之心肩甲","=q4=狂野之心外套","=q3=狂野之心护腕","=q4=狂野之心手套","=q3=狂野之心腰带","=q3=狂野之心褶裙","=q4=狂野之心长靴"})
Process("T0Hunter",24,{"","=q3=野兽追猎者之帽","=q3=野兽追猎者衬肩","=q3=野兽追猎者外套","=q3=野兽追猎者护腕","=q3=野兽追猎者手套","=q3=野兽追猎者腰带","=q3=野兽追猎者短裤","=q3=野兽追猎者长靴","","","","","","","","=q4=兽王罩帽","=q3=兽王护肩","=q4=兽王外套","=q3=兽王护腕","=q4=兽王手套","=q3=兽王腰带","=q3=兽王短裤","=q4=兽王长靴"})
Process("T0Mage",24,{"","=q3=博学者头冠","=q3=博学者衬肩","=q3=博学者长袍","=q3=博学者腕轮","=q3=博学者手套","=q3=博学者腰带","=q3=博学者护腿","=q3=博学者长靴","","","","","","","","=q4=巫师头冠","=q3=巫师衬肩","=q4=巫师长袍","=q3=巫师护腕","=q4=巫师手套","=q3=巫师的腰带","=q3=巫师护腿","=q4=巫师软靴"})
Process("T0Paladin",24,{"","=q3=光铸头盔","=q3=光铸肩铠","=q3=光铸胸甲","=q3=光铸护腕","=q3=光铸护手","=q3=光铸腰带","=q3=光铸腿铠","=q3=光铸战靴","","","","","","","","=q4=魂铸头盔","=q3=魂铸肩铠","=q4=魂铸胸甲","=q3=魂铸护腕","=q4=魂铸护手","=q3=魂铸腰带","=q3=魂铸腿甲","=q4=魂铸战靴"})
Process("T0Priest",24,{"","=q3=虔诚头冠","=q3=虔诚衬肩","=q3=虔诚长袍","=q3=虔诚护腕","=q3=虔诚护手","=q3=虔诚腰带","=q3=虔诚长裙","=q3=虔诚软鞋","","","","","","","","=q4=坚贞头冠","=q3=坚贞衬肩","=q4=坚贞长袍","=q3=坚贞护腕","=q4=坚贞手套","=q3=坚贞腰带","=q3=坚贞长裙","=q4=坚贞便鞋"})
Process("T0Rogue",24,{"","=q3=迅影罩帽","=q3=迅影肩甲","=q3=迅影外套","=q3=迅影护腕","=q3=迅影手套","=q3=迅影腰带","=q3=迅影短裤","=q3=迅影长靴","","","","","","","","=q4=暗幕皮帽","=q3=暗幕肩甲","=q4=暗幕外套","=q3=暗幕护腕","=q4=暗幕手套","=q3=暗幕腰带","=q3=暗幕短裤","=q4=暗幕长靴"})
Process("T0Shaman",24,{"","=q3=元素罩帽","=q3=元素护肩","=q3=元素外衣","=q3=元素腕轮","=q3=元素护手","=q3=元素束腰","=q3=元素护腿","=q3=元素长靴","","","","","","","","=q4=五雷罩帽","=q3=五雷肩甲","=q4=五雷外套","=q3=五雷护腕","=q4=五雷护手","=q3=五雷腰带","=q3=五雷褶裙","=q4=五雷长靴"})
Process("T0Warlock",24,{"","=q3=鬼雾面具","=q3=鬼雾衬肩","=q3=鬼雾长袍","=q3=鬼雾护腕","=q3=鬼雾手套","=q3=鬼雾腰带","=q3=鬼雾护腿","=q3=鬼雾便鞋","","","","","","","","=q4=死雾面具","=q3=死雾衬肩","=q4=死雾长袍","=q3=死雾护腕","=q4=死雾裹手","=q3=死雾腰带","=q3=死雾护腿","=q4=死雾便鞋"})
Process("T0Warrior",24,{"","=q3=勇气头盔","=q3=勇气肩甲","=q3=勇气胸甲","=q3=勇气护腕","=q3=勇气护手","=q3=勇气腰带","=q3=勇气腿铠","=q3=勇气战靴","","","","","","","","=q4=英勇头盔","=q3=英勇肩铠","=q4=英勇胸甲","=q3=英勇护腕","=q4=英勇护手","=q3=英勇腰带","=q3=英勇腿铠","=q4=英勇长靴"})
Process("T1Druid",9,{"","=q4=塞纳里奥头盔","=q4=塞纳里奥肩甲","=q4=塞纳里奥胸甲","=q4=塞纳里奥护腕","=q4=塞纳里奥手套","=q4=塞纳里奥腰带","=q4=塞纳里奥护腿","=q4=塞纳里奥长靴"})
Process("T1Hunter",9,{"","=q4=巨人追猎者头盔","=q4=巨人追猎者肩饰","=q4=巨人追猎者胸甲","=q4=巨人追猎者护腕","=q4=巨人追猎者手套","=q4=巨人追猎者腰带","=q4=巨人追猎者护腿","=q4=巨人追猎者长靴"})
Process("T1Mage",9,{"","=q4=奥术师头冠","=q4=奥术师衬肩","=q4=奥术师长袍","=q4=奥术师护腕","=q4=奥术师手套","=q4=奥术师腰带","=q4=奥术师护腿","=q4=奥术师便鞋"})
Process("T1Paladin",9,{"","=q4=秩序之源头盔","=q4=秩序之源肩铠","=q4=秩序之源胸甲","=q4=秩序之源护腕","=q4=秩序之源护手","=q4=秩序之源腰带","=q4=秩序之源腿铠","=q4=秩序之源战靴"})
Process("T1Priest",9,{"","=q4=预言头饰","=q4=预言衬肩","=q4=预言法袍","=q4=预言臂甲","=q4=预言手套","=q4=预言束带","=q4=预言短裤","=q4=预言之靴"})
Process("T1Rogue",9,{"","=q4=夜幕杀手头巾","=q4=夜幕杀手护肩","=q4=夜幕杀手胸甲","=q4=夜幕杀手护腕","=q4=夜幕杀手手套","=q4=夜幕杀手腰带","=q4=夜幕杀手短裤","=q4=夜幕杀手长靴"})
Process("T1Shaman",9,{"","=q4=大地之怒头盔","=q4=大地之怒肩饰","=q4=大地之怒外衣","=q4=大地之怒护腕","=q4=大地之怒护手","=q4=大地之怒腰带","=q4=大地之怒腿甲","=q4=大地之怒长靴"})
Process("T1Warlock",9,{"","=q4=恶魔之心角饰","=q4=恶魔之心护肩","=q4=恶魔之心长袍","=q4=恶魔之心护腕","=q4=恶魔之心手套","=q4=恶魔之心腰带","=q4=恶魔之心短裤","=q4=恶魔之心便鞋"})
Process("T1Warrior",9,{"","=q4=力量头盔","=q4=力量肩铠","=q4=力量胸甲","=q4=力量护腕","=q4=力量护手","=q4=力量腰带","=q4=力量腿铠","=q4=力量马靴"})
Process("T2Druid",9,{"","=q4=怒风头巾","=q4=怒风肩甲","=q4=怒风胸甲","=q4=怒风护腕","=q4=怒风护手","=q4=怒风腰带","=q4=怒风腿甲","=q4=怒风长靴"})
Process("T2Hunter",9,{"","=q4=巨龙追猎者头盔","=q4=巨龙追猎者肩甲","=q4=巨龙追猎者胸甲","=q4=巨龙追猎者护腕","=q4=巨龙追猎者护手","=q4=巨龙追猎者腰带","=q4=巨龙追猎者腿甲","=q4=巨龙追猎者胫甲"})
Process("T2Mage",9,{"","=q4=灵风头冠","=q4=灵风衬肩","=q4=灵风长袍","=q4=灵风束腕","=q4=灵风手套","=q4=灵风腰带","=q4=灵风短裤","=q4=灵风长靴"})
Process("T2Paladin",9,{"","=q4=审判头冠","=q4=审判肩铠","=q4=审判胸甲","=q4=审判束腕","=q4=审判护手","=q4=审判腰带","=q4=审判腿铠","=q4=审判马靴"})
Process("T2Priest",9,{"","=q4=卓越之环","=q4=卓越肩铠","=q4=卓越法袍","=q4=卓越束腕","=q4=卓越护手","=q4=卓越腰带","=q4=卓越护腿","=q4=卓越长靴"})
Process("T2Rogue",9,{"","=q4=血牙头巾","=q4=血牙肩甲","=q4=血牙胸甲","=q4=血牙护腕","=q4=血牙手套","=q4=血牙腰带","=q4=血牙短裤","=q4=血牙长靴"})
Process("T2Shaman",9,{"","=q4=无尽风暴头盔","=q4=无尽风暴肩饰","=q4=无尽风暴胸甲","=q4=无尽风暴护腕","=q4=无尽风暴护手","=q4=无尽风暴腰带","=q4=无尽风暴护腿","=q4=无尽风暴胫甲"})
Process("T2Warlock",9,{"","=q4=复仇骨帽","=q4=复仇肩铠","=q4=复仇法袍","=q4=复仇护腕","=q4=复仇手套","=q4=复仇腰带","=q4=复仇护腿","=q4=复仇战靴"})
Process("T2Warrior",9,{"","=q4=愤怒头盔","=q4=愤怒肩铠","=q4=愤怒胸甲","=q4=愤怒护腕","=q4=愤怒护手","=q4=愤怒腰带","=q4=愤怒腿铠","=q4=愤怒马靴"})
Process("T3Druid",10,{"","=q4=梦游者头饰","=q4=梦游者肩饰","=q4=梦游者外套","=q4=梦游者腕甲","=q4=梦游者护手","=q4=梦游者束带","=q4=梦游者护腿","=q4=梦游者长靴","=q4=梦游者之戒"})
Process("T3Hunter",10,{"","=q4=地穴追猎者头饰","=q4=地穴追猎者肩甲","=q4=地穴追猎者外套","=q4=地穴追猎者护腕","=q4=地穴追猎者护手","=q4=地穴追猎者束带","=q4=地穴追猎者护腿","=q4=地穴追猎者长靴","=q4=地穴追猎者指环"})
Process("T3Mage",10,{"","=q4=霜火头饰","=q4=霜火肩垫","=q4=霜火长袍","=q4=霜火腕轮","=q4=霜火手套","=q4=霜火腰带","=q4=霜火护腿","=q4=霜火便鞋","=q4=霜火之戒"})
Process("T3Paladin",10,{"","=q4=救赎头饰","=q4=救赎肩铠","=q4=救赎外套","=q4=救赎护腕","=q4=救赎护手","=q4=救赎束带","=q4=救赎腿甲","=q4=救赎长靴","=q4=救赎之戒"})
Process("T3Priest",10,{"","=q4=信仰头环","=q4=信仰肩垫","=q4=信仰长袍","=q4=信仰腕轮","=q4=信仰手套","=q4=信仰腰带","=q4=信仰护腿","=q4=信仰便鞋","=q4=信仰之戒"})
Process("T3Rogue",10,{"","=q4=骨镰头盔","=q4=骨镰肩铠","=q4=骨镰胸甲","=q4=骨镰护腕","=q4=骨镰护手","=q4=骨镰护腰","=q4=骨镰腿甲","=q4=骨镰马靴","=q4=骨镰之戒"})
Process("T3Shaman",10,{"","=q4=碎地者头饰","=q4=碎地者肩饰","=q4=碎地者外套","=q4=碎地者护腕","=q4=碎地者护手","=q4=碎地者束带","=q4=碎地者腿甲","=q4=碎地者长靴","=q4=碎地者之戒"})
Process("T3Warlock",10,{"","=q4=瘟疫之心头饰","=q4=瘟疫之心肩垫","=q4=瘟疫之心长袍","=q4=瘟疫之心腕轮","=q4=瘟疫之心手套","=q4=瘟疫之心腰带","=q4=瘟疫之心护腿","=q4=瘟疫之心便鞋","=q4=瘟疫之心指环"})
Process("T3Warrior",10,{"","=q4=无畏头盔","=q4=无畏肩铠","=q4=无畏胸甲","=q4=无畏护腕","=q4=无畏手套","=q4=无畏腰带","=q4=无畏腿铠","=q4=无畏马靴","=q4=无畏之戒"})
Process("T4Druid",21,{"","=q4=玛洛恩鹿盔","=q4=玛洛恩衬肩","=q4=玛洛恩胸甲","=q4=玛洛恩护手","=q4=玛洛恩腿甲","","","=q4=玛洛恩头冠","=q4=玛洛恩护肩","=q4=玛洛恩护胸","=q4=玛洛恩手甲","=q4=玛洛恩护腿","","","","=q4=玛洛恩鹿角","=q4=玛洛恩肩甲","=q4=玛洛恩胸衣","=q4=玛洛恩手套","=q4=玛洛恩长裤"})
Process("T4Hunter",6,{"","=q4=恶魔追猎者巨盔","=q4=恶魔追猎者护肩","=q4=恶魔追猎者外套","=q4=恶魔追猎者护手","=q4=恶魔追猎者护胫"})
Process("T4Mage",6,{"","=q4=奥尔多头饰","=q4=奥尔多护肩","=q4=奥尔多外衣","=q4=奥尔多手套","=q4=奥尔多护腿"})
Process("T4Paladin",21,{"","=q4=公正面甲","=q4=公正肩铠","=q4=公正护胸","=q4=公正手甲","=q4=公正腿铠","","","=q4=公正头冠","=q4=公正护肩","=q4=公正胸铠","=q4=公正护手","=q4=公正腿甲","","","","=q4=公正王冠","=q4=公正肩甲","=q4=公正胸甲","=q4=公正手套","=q4=公正护腿"})
Process("T4Priest",13,{"","=q4=化身光明之环","=q4=化身光明护肩","=q4=化身长袍","=q4=化身裹手","=q4=化身长裤","","","=q4=化身灵魂之环","=q4=化身灵魂护肩","=q4=化身外衣","=q4=化身手套","=q4=化身护腿"})
Process("T4Rogue",6,{"","=q4=虚空刀锋面具","=q4=虚空刀锋护肩","=q4=虚空刀锋护胸","=q4=虚空刀锋手套","=q4=虚空刀锋长裤"})
Process("T4Shaman",21,{"","=q4=飓风头盔","=q4=飓风肩甲","=q4=飓风胸甲","=q4=飓风护手","=q4=飓风战裙","","","=q4=飓风头饰","=q4=飓风肩垫","=q4=飓风外套","=q4=飓风手套","=q4=飓风褶裙","","","","=q4=飓风面甲","=q4=飓风护肩","=q4=飓风护胸","=q4=飓风手甲","=q4=飓风护腿"})
Process("T4Warlock",6,{"","=q4=虚空之心头冠","=q4=虚空之心衬肩","=q4=虚空之心长袍","=q4=虚空之心手套","=q4=虚空之心护腿"})
Process("T4Warrior",13,{"","=q4=战神巨盔","=q4=战神护肩","=q4=战神胸甲","=q4=战神护手","=q4=战神护腿","","","=q4=战神头盔","=q4=战神肩铠","=q4=战神护胸","=q4=战神手套","=q4=战神胫甲"})
Process("T5Druid",21,{"","=q4=诺达希尔头饰","=q4=诺达希尔野性护肩","=q4=诺达希尔胸甲","=q4=诺达希尔手甲","=q4=诺达希尔野性褶裙","","","=q4=诺达希尔头盔","=q4=诺达希尔生命护肩","=q4=诺达希尔护胸","=q4=诺达希尔手套","=q4=诺达希尔生命褶裙","","","","=q4=诺达希尔头巾","=q4=诺达希尔愤怒护肩","=q4=诺达希尔胸衣","=q4=诺达希尔护手","=q4=诺达希尔愤怒褶裙"})
Process("T5Hunter",6,{"","=q4=裂隙追猎者头盔","=q4=裂隙追猎者护肩","=q4=裂隙追猎者胸甲","=q4=裂隙追猎者护手","=q4=裂隙追猎者护腿"})
Process("T5Mage",6,{"","=q4=提瑞斯法兜帽","=q4=提瑞斯法护肩","=q4=提瑞斯法长袍","=q4=提瑞斯法手套","=q4=提瑞斯法护腿"})
Process("T5Paladin",21,{"","=q4=晶铸面甲","=q4=晶铸肩铠","=q4=晶铸护胸","=q4=晶铸手甲","=q4=晶铸腿甲","","","=q4=晶铸战盔","=q4=晶铸护肩","=q4=晶铸胸铠","=q4=晶铸护手","=q4=晶铸护胫","","","","=q4=晶铸巨盔","=q4=晶铸肩甲","=q4=晶铸胸甲","=q4=晶铸手套","=q4=晶铸护腿"})
Process("T5Priest",13,{"","=q4=神使兜帽","=q4=神使护肩","=q4=神使外衣","=q4=神使手套","=q4=神使长裤","","","=q4=神使头巾","=q4=神使之翼","=q4=神使长袍","=q4=神使护手","=q4=神使护腿"})
Process("T5Rogue",6,{"","=q4=死亡阴影头盔","=q4=死亡阴影护肩","=q4=死亡阴影胸甲","=q4=死亡阴影护手","=q4=死亡阴影护腿"})
Process("T5Shaman",21,{"","=q4=灾难头盔","=q4=灾难肩铠","=q4=灾难胸铠","=q4=灾难护手","=q4=灾难腿铠","","","=q4=灾难头甲","=q4=灾难肩甲","=q4=灾难胸甲","=q4=灾难手套","=q4=灾难腿甲","","","","=q4=灾难头饰","=q4=灾难护肩","=q4=灾难护胸","=q4=灾难手甲","=q4=灾难护腿"})
Process("T5Warlock",6,{"","=q4=腐蚀者罩帽","=q4=腐蚀者衬肩","=q4=腐蚀者长袍","=q4=腐蚀者手套","=q4=腐蚀者护腿"})
Process("T5Warrior",13,{"","=q4=毁灭者巨盔","=q4=毁灭者护肩","=q4=毁灭者护胸","=q4=毁灭者手甲","=q4=毁灭者护腿","","","=q4=毁灭者战盔","=q4=毁灭者肩刃","=q4=毁灭者胸甲","=q4=毁灭者护手","=q4=毁灭者护胫"})
Process("T6Druid",24,{"","=q4=雷霆之心罩帽","=q4=雷霆之心护肩","=q4=雷霆之心胸甲","=q4=雷霆之心腕甲","=q4=雷霆之心手甲","=q4=雷霆之心护腰","=q4=雷霆之心护腿","=q4=雷霆之心战靴","","","","","","","","=q4=雷霆之心头盔","=q4=雷霆之心肩甲","=q4=雷霆之心外套","=q4=雷霆之心护腕","=q4=雷霆之心手套","=q4=雷霆之心腰带","=q4=雷霆之心腿甲","=q4=雷霆之心长靴"})
Process("T6Druid2",9,{"","=q4=雷霆之心头饰","=q4=雷霆之心肩垫","=q4=雷霆之心外衣","=q4=雷霆之心腕环","=q4=雷霆之心护手","=q4=雷霆之心束腰","=q4=雷霆之心短裤","=q4=雷霆之心裹足"})
Process("T6Hunter",9,{"","=q4=戈隆追猎者头盔","=q4=戈隆追猎者护肩","=q4=戈隆追猎者护胸","=q4=戈隆追猎者护腕","=q4=戈隆追猎者手套","=q4=戈隆追猎者腰带","=q4=戈隆追猎者护腿","=q4=戈隆追猎者长靴"})
Process("T6Mage",9,{"","=q4=风暴兜帽","=q4=风暴衬肩","=q4=风暴长袍","=q4=风暴护腕","=q4=风暴手套","=q4=风暴腰带","=q4=风暴护腿","=q4=风暴长靴"})
Process("T6Paladin",24,{"","=q4=光明使者面甲","=q4=光明使者肩铠","=q4=光明使者护胸","=q4=光明使者腕甲","=q4=光明使者手甲","=q4=光明使者束腰","=q4=光明使者腿甲","=q4=光明使者战靴","","","","","","","","=q4=光明使者战盔","=q4=光明使者肩甲","=q4=光明使者胸铠","=q4=光明使者腕环","=q4=光明使者护手","=q4=光明使者护腰","=q4=光明使者腿铠","=q4=光明使者长靴"})
Process("T6Paladin2",9,{"","=q4=光明使者巨盔","=q4=光明使者护肩","=q4=光明使者胸甲","=q4=光明使者护腕","=q4=光明使者手套","=q4=光明使者腰带","=q4=光明使者护腿","=q4=光明使者轻靴"})
Process("T6Priest",24,{"","=q4=赦免兜帽","=q4=赦免衬肩","=q4=赦免外衣","=q4=赦免裹腕","=q4=赦免手套","=q4=赦免腰带","=q4=赦免长裤","=q4=赦免长靴","","","","","","","","=q4=赦免头巾","=q4=赦免肩垫","=q4=赦免法衣","=q4=赦免护腕","=q4=赦免护手","=q4=赦免护腰","=q4=赦免护腿","=q4=赦免软靴"})
Process("T6Rogue",9,{"","=q4=刺杀者头盔","=q4=刺杀者护肩","=q4=刺杀者胸甲","=q4=刺杀者护腕","=q4=刺杀者护手","=q4=刺杀者腰带","=q4=刺杀者护腿","=q4=刺杀者战靴"})
Process("T6Shaman",24,{"","=q4=破天罩盔","=q4=破天护肩","=q4=破天外套","=q4=破天腕甲","=q4=破天手甲","=q4=破天束腰","=q4=破天长裤","=q4=破天胫甲","","","","","","","","=q4=破天头盔","=q4=破天肩垫","=q4=破天护胸","=q4=破天护腕","=q4=破天手套","=q4=破天腰带","=q4=破天护腿","=q4=破天长靴"})
Process("T6Shaman2",9,{"","=q4=破天面盔","=q4=破天衬肩","=q4=破天胸甲","=q4=破天腕环","=q4=破天护手","=q4=破天裹腰","=q4=破天腿甲","=q4=破天轻靴"})
Process("T6Warlock",9,{"","=q4=凶星头巾","=q4=凶星衬肩","=q4=凶星长袍","=q4=凶星护腕","=q4=凶星手套","=q4=凶星腰带","=q4=凶星护腿","=q4=凶星长靴"})
Process("T6Warrior",24,{"","=q4=冲锋巨盔","=q4=冲锋护肩","=q4=冲锋护胸","=q4=冲锋腕甲","=q4=冲锋手甲","=q4=冲锋束腰","=q4=冲锋腿甲","=q4=冲锋战靴","","","","","","","","=q4=冲锋战盔","=q4=冲锋肩刃","=q4=冲锋胸甲","=q4=冲锋护腕","=q4=冲锋护手","=q4=冲锋腰带","=q4=冲锋护腿","=q4=冲锋胫甲"})
Process("TBCAzzinothBlades",3,{"","=q5=埃辛诺斯战刃","=q5=埃辛诺斯战刃"})
Process("TBCLatrosFlurry",3,{"","=q3=拉托恩的乱舞之刃","=q3=拉托恩的狡诈之剑"})
Process("TBCTwinStars",3,{"","=q4=夏洛特的长青藤","=q4=萝拉之夜"})
Process("Tabards1",31,{"=q4=烈焰徽章","=q4=冰霜徽章","=q3=夏日天空徽章","=q3=夏日烈焰徽章","","","=q1=奥尔多徽章","=q1=塞纳里奥远征队徽章","=q1=荣耀堡战袍","=q1=时光守护者徽章","=q1=贫民窟徽章","=q1=奥格瑞拉徽章","=q1=沙塔尔徽章","=q1=孢子村徽章","=q1=阿古斯之手徽章","=q1=破碎残阳战袍","=q2=绿色伊利达雷徽章","=q2=紫色伊利达雷徽章","=q2=血色十字军徽章","=q1=冠军徽章","","","=q1=血骑士战袍","=q1=星界财团徽章","=q1=库雷尼徽章","=q1=玛格汉徽章","=q1=占星者徽章","=q1=天空卫队徽章","=q1=银色黎明徽章","=q1=保卫者的战袍","=q1=萨尔玛徽章"})
Process("Tabards2",21,{"","=q1=列兵徽章","=q1=骑士彩带","=q1=阿拉索战袍","=q1=雷矛军服","=q1=银翼军服","","","","","","","","","","","=q1=斥候的徽章","=q1=石守卫的纹章","=q1=污染者军旗","=q1=霜狼军服","=q1=战歌军服"})
Process("VWOWBlackrockD",6,{"","=q3=野蛮角斗士头盔","=q4=野蛮角斗士链甲","=q3=野蛮角斗士护手","=q3=野蛮角斗士护腿","=q3=野蛮角斗士护胫"})
Process("VWOWDalRend",3,{"","=q3=雷德的神圣控诉者","=q3=雷德的部族护卫者"})
Process("VWOWDeadmines",6,{"","=q3=黑暗迪菲亚护甲","=q2=黑暗迪菲亚手套","=q3=黑暗迪菲亚腰带","=q2=黑暗迪菲亚护腿","=q2=黑暗迪菲亚长靴"})
Process("VWOWHakkariBlades",3,{"","=q4=哈卡莱战刃","=q4=哈卡莱战刃"})
Process("VWOWIronweave",9,{"","=q3=铁纹罩帽","=q3=铁纹衬肩","=q3=铁纹长袍","=q3=铁纹护腕","=q3=铁纹手套","=q3=铁纹腰带","=q3=铁纹短裤","=q3=铁纹长靴"})
Process("VWOWPrimalBlessing",3,{"","=q4=塞卡尔之握","=q4=娅尔罗之握"})
Process("VWOWScarletM",7,{"","=q3=血色十字军护胸","=q2=血色十字军腕甲","=q2=血色十字军护手","=q2=血色十字军腰带","=q3=血色十字军护腿","=q3=血色十字军战靴"})
Process("VWOWScholoCloth",6,{"","=q3=骨堆衬肩","=q3=骨堆长袍","=q3=骨堆腕轮","=q3=骨堆护腿","=q3=骨堆长靴"})
Process("VWOWScholoLeather",6,{"","=q3=苍白护甲","=q3=苍白手套","=q3=苍白腰带","=q3=苍白护腿","=q3=苍白长靴"})
Process("VWOWScholoMail",6,{"","=q3=血链锁甲","=q3=血链护手","=q3=血链腰带","=q3=血链护腿","=q3=血链战靴"})
Process("VWOWScholoPlate",6,{"","=q3=亡骨胸甲","=q3=亡骨护手","=q3=亡骨束带","=q3=亡骨腿甲","=q3=亡骨马靴"})
Process("VWOWScourgeInvasion",24,{"","=q3=亡灵净化之袍","=q3=亡灵净化护腕","=q3=亡灵净化手套","","","=q3=亡灵杀手外套","=q3=亡灵毁灭腕轮","=q3=亡灵毁灭裹手","","","","","","","","=q3=亡灵毁灭护胸","=q3=亡灵毁灭腕甲","=q3=亡灵毁灭护手","","","=q3=亡灵毁灭胸甲","=q3=亡灵毁灭护腕","=q3=亡灵毁灭手套"})
Process("VWOWShardOfGods",3,{"","=q4=烈焰碎片","=q4=龙鳞碎片"})
Process("VWOWSpiderKiss",3,{"","=q3=水晶蜘蛛之牙","=q3=喷毒者"})
Process("VWOWSpiritofEskhandar",5,{"","=q4=艾斯卡达尔的毛皮","=q4=艾斯卡达尔的项圈","=q4=艾斯卡达尔的右爪","=q4=艾斯卡达尔的左爪"})
Process("VWOWStrat",6,{"","=q3=邮差头环","=q3=邮差外套","=q3=邮差长裤","=q3=邮差的布靴","=q3=邮差徽记"})
Process("VWOWWailingC",6,{"","=q3=尖牙铠甲","=q3=尖牙手套","=q3=尖牙腰带","=q3=尖牙护腿","=q3=尖牙足垫"})
Process("VWOWZGRings",22,{"","=q3=巨魔族长徽记","=q3=巨魔族长指环","","","=q3=督军的红色指环","=q3=督军的玛瑙指环","","","","","","","","","","=q3=始祖徽记","=q3=首领指环","","","=q3=赞吉尔指环","=q3=赞吉尔的徽记"})
Process("WorldEpics1",22,{"=q4=圣力手套","=q4=冰鳞甲","=q4=地狱指环","","","","","","","","","","","","","=q4=眩光","=q4=夜刃","=q4=炽炎战斧","=q4=热情监护者","=q4=乔丹法杖","=q4=绿塔","=q4=灼热弓"})
Process("WorldEpics2",28,{"=q4=烈焰之眼","=q4=洞察法袍","=q4=剑师护手","=q4=碎石护手","=q4=闪避之靴","=q4=百合","=q4=寒冰指环","=q4=救世之戒","","","","","","","","=q4=断肠","=q4=影刃","=q4=血刃","=q4=风暴战斧","=q4=斩首者康恩","=q4=北风","=q4=碎冰者","=q4=亮木法杖","=q4=典狱官法杖","=q4=黑颅","=q4=亡者之墙","=q4=飓风","=q4=精确校准过的火枪"})
Process("WorldEpics3",26,{"=q4=烈焰披风","=q4=怜悯","=q4=纳尔维之盔","=q4=牢狱肩甲","=q4=踏云腿甲","=q4=凯维恩的珠宝护符","=q4=麦耶的坠饰","=q4=侍从的徽记","=q4=生命徽章","=q4=暴风雄狮号角","","","","","","=q4=提布的炽炎长剑","=q4=亚考尔的阳炎刀","=q4=克罗之刃","=q4=汉娜之刃","=q4=命运","=q4=密林战斧","=q4=碎灵","=q4=爱德华之手","=q4=元素法杖","=q4=骨火","=q4=矮人手持火炮"})
Process("WorldEpics4",24,{"=q4=生命活力披风","=q4=爱德华的意志","=q4=卡麦伊的天蓝裙","=q4=守夜者","=q4=闪电皇冠","=q4=野兽主宰护腿","=q4=生命活力短裤","=q4=流放胸甲","=q4=夏洛特的长青藤","=q4=悔恨之链","=q4=无懈防御指环","=q4=萝拉之夜","=q4=强击戒指","","","=q4=夜色之刃","=q4=巫术之刃","=q4=一闪","=q4=歌唱水晶战斧","=q4=苏美的上古权杖","=q4=命运之锤","=q4=自然愤怒法杖","=q4=断骨者","=q4=桑托斯的著名猎枪"})
Process("ZGDruid",6,{"","=q4=乌苏雷的自然护符","=q4=原始南海魔化海藻","=q4=赞达拉占卜师外套","=q4=赞达拉占卜师腰带","=q4=赞达拉占卜师护腕"})
Process("ZGHunter",6,{"","=q4=雷纳塔基的野兽护符","=q4=漩涡之怒","=q4=赞达拉捕猎者衬肩","=q4=赞达拉捕猎者腰带","=q4=赞达拉捕猎者护腕"})
Process("ZGMage",6,{"","=q4=哈扎拉尔的魔法护符","=q4=卡亚罗的珠宝","=q4=赞达拉幻术师长袍","=q4=赞达拉幻术师衬肩","=q4=赞达拉幻术师裹布"})
Process("ZGPaladin",6,{"","=q4=格里雷克的勇气护符","=q4=英雄的烙印","=q4=赞达拉思考者胸甲","=q4=赞达拉思考者腰带","=q4=赞达拉思考者护臂"})
Process("ZGPriest",6,{"","=q4=哈扎拉尔的治疗护符","=q4=祖达萨全视之眼","=q4=赞达拉忏悔者衬肩","=q4=赞达拉忏悔者腰带","=q4=赞达拉忏悔者裹布"})
Process("ZGRogue",6,{"","=q4=雷纳塔基的狡诈护符","=q4=赞达拉暗影大师坠饰","=q4=赞达拉狂妄者外套","=q4=赞达拉狂妄者衬肩","=q4=赞达拉狂妄者护腕"})
Process("ZGShaman",6,{"","=q4=乌苏雷的灵魂护符","=q4=完美巫毒幻象","=q4=赞达拉预言者外套","=q4=赞达拉预言者腰带","=q4=赞达拉预言者护腕"})
Process("ZGWarlock",6,{"","=q4=哈扎拉尔的毁灭护符","=q4=科赞的强力玷污","=q4=赞达拉恶魔师长袍","=q4=赞达拉恶魔师衬肩","=q4=赞达拉恶魔师裹带"})
Process("ZGWarrior",6,{"","=q4=格里雷克的力量护符","=q4=穆贾巴之怒","=q4=赞达拉辩护者胸甲","=q4=赞达拉辩护者腰带","=q4=赞达拉辩护者护臂"})
end
