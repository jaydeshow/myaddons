﻿--[[
--AtlasLoot loot tables zhTW localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--NOTE-zhTW: 本檔是由程式自動生成的，請勿人工干預，任何手動更改都可能會被覆蓋！
--$Date: 2008-06-08 03:26:14 -0400 (Sun, 08 Jun 2008) $
--]]
if (GetLocale() == "zhTW") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootSetItems"][category] or #AtlasLoot_Data["AtlasLootSetItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootSetItems"][category][i][3] = data[i] end end data = nil end
Process("AQ20Druid",4,{"","=q4=不滅生命之錘","=q4=不滅生命披風","=q4=不滅生命指環"})
Process("AQ20Hunter",4,{"","=q4=隱秘通途之鐮","=q4=隱秘通途披風","=q4=隱秘通途之戒"})
Process("AQ20Mage",4,{"","=q4=魔法秘密之刃","=q4=魔法秘密披氅","=q4=魔法秘密指環"})
Process("AQ20Paladin",4,{"","=q4=永恆公正之刃","=q4=永恆公正斗篷","=q4=永恆公正之戒"})
Process("AQ20Priest",4,{"","=q4=無盡智慧裁決槌","=q4=無盡智慧罩氅","=q4=無盡智慧之戒"})
Process("AQ20Rogue",4,{"","=q4=矇矓之影匕首","=q4=矇矓之影披風","=q4=矇矓之影指環"})
Process("AQ20Shaman",4,{"","=q4=聚集風暴之錘","=q4=聚集風暴披風","=q4=聚集風暴之戒"})
Process("AQ20Warlock",4,{"","=q4=禁斷邪語短劍","=q4=禁斷邪語罩氅","=q4=禁斷邪語之戒"})
Process("AQ20Warrior",4,{"","=q4=不屈力量之鐮","=q4=不屈力量披氅","=q4=不屈力量之戒"})
Process("AQ40Druid",6,{"","=q4=起源外衣","=q4=起源頭盔","=q4=起源長褲","=q4=起源肩墊","=q4=起源長靴"})
Process("AQ40Hunter",6,{"","=q4=打擊者鍊衫","=q4=打擊者冠冕","=q4=打擊者的護腿","=q4=打擊者的肩鎧","=q4=打擊者的護足"})
Process("AQ40Mage",6,{"","=q4=謎團長袍","=q4=神秘頭環","=q4=謎團護腿","=q4=謎團肩墊","=q4=謎團長靴"})
Process("AQ40Paladin",6,{"","=q4=復仇者的胸甲","=q4=復仇者之冠","=q4=復仇者的腿甲","=q4=復仇者的肩鎧","=q4=復仇者的護脛"})
Process("AQ40Priest",6,{"","=q4=神諭者的法衣","=q4=神諭者的冠冕","=q4=神諭者的長褲","=q4=神諭者的披肩","=q4=神諭者的裹足"})
Process("AQ40Rogue",6,{"","=q4=死亡執行者的外衣","=q4=死亡執行者的頭盔","=q4=死亡執行者的護腿","=q4=死亡執行者的肩甲","=q4=死亡執行者的靴子"})
Process("AQ40Shaman",6,{"","=q4=風暴召喚者鍊衫","=q4=風暴召喚者冠冕","=q4=風暴召喚者的護腿","=q4=風暴召喚者的肩鎧","=q4=風暴召喚者的護足"})
Process("AQ40Warlock",6,{"","=q4=厄運召喚者的長袍","=q4=厄運召喚者的頭環","=q4=厄運召喚者的長褲","=q4=厄運召喚者的披肩","=q4=厄運召喚者的裹足"})
Process("AQ40Warrior",6,{"","=q4=征服者的胸甲","=q4=征服者之冠","=q4=征服者的腿甲","=q4=征服者的肩甲","=q4=征服者的護脛"})
Process("BlizzardCollectables1",8,{"=q3=魚人裝束","","=q3=藍色魚人卵","=q3=粉紅魚人蛋","=q3=熊貓項圈","=q3=破壞神之石","=q3=跳蟲繩索","=q3=虛空幼龍項圈"}) --Missing: 30360
Process("CardGame1",30,{"","=q4=烈焰外袍","=q4=角鷹獸寶寶","=q4=烏龜坐騎","","","=q3=巴那納斯符咒","=q3=午餐籃","=q3=球中的小鬼","","","=q4=迅捷鬼靈之虎韁繩","=q3=鬼靈之虎韁繩","=q3=釣魚椅","=q3=哥布林燴肉罐","","=q4=飛龍風箏","=q3=火箭雞","=q3=紙飛行器工具組","","","=q4=X51型虛空火箭極限版","=q3=X51型虛空火箭","=q4=哥布林天氣機 - 原型機 01-B","=q3=休莫爾老爹的老派寵物軟餅"})
Process("CardGame2",4,{"","=q4=冰霜外袍","=q4=無止境的紫色煙火","=q4=巨魔塑像"})
Process("DS3Assassin",5,{"=q3=暗殺頭盔","=q3=暗殺肩墊","=q3=暗殺外套","=q3=暗殺纏手","=q3=暗殺護腿"})
Process("DS3Beast",5,{"=q3=野獸之王頭盔","=q3=野獸之王披肩","=q3=野獸之王胸衣","=q3=野獸之王手甲","=q3=野獸之王護腿"})
Process("DS3Bold",5,{"=q3=勇猛頭盔","=q3=勇猛肩衛","=q3=勇猛胸甲","=q3=勇猛護手","=q3=勇猛腿鎧"})
Process("DS3Desolation",5,{"=q3=哀傷之鏈頭盔","=q3=哀傷之鏈肩鎧","=q3=哀傷之鏈鍊衫","=q3=哀傷之鏈護手","=q3=哀傷之鏈護脛"})
Process("DS3Doom",5,{"=q3=末日戰甲頭盔","=q3=末日戰甲肩衛","=q3=末日戰甲護胸","=q3=末日戰甲護手","=q3=末日戰甲腿甲"})
Process("DS3Hallowed",5,{"=q3=神聖儀祭之冠","=q3=神聖儀祭肩鎧","=q3=神聖儀祭服飾","=q3=神聖儀祭裹手","=q3=神聖儀祭長褲"})
Process("DS3Incanter",5,{"=q3=魔法使的風帽","=q3=魔法使的肩鎧","=q3=魔法使的長袍","=q3=魔法使的手套","=q3=魔法使的長褲"})
Process("DS3Mana",5,{"=q3=法力蝕刻之冠","=q3=法力蝕刻肩甲","=q3=法力蝕刻法衣","=q3=法力蝕刻手套","=q3=法力蝕刻窄褲"})
Process("DS3Moonglade",5,{"=q3=月光林地風帽","=q3=月光林地護肩","=q3=月光林地長袍","=q3=月光林地裹手","=q3=月光林地便褲"})
Process("DS3Oblivion",5,{"=q3=失落兜帽","=q3=失落肩甲","=q3=失落長袍","=q3=失落手套","=q3=失落長褲"})
Process("DS3Right",5,{"=q3=公正頭盔","=q3=公正肩甲","=q3=公正胸甲","=q3=公正護手","=q3=公正腿鎧"})
Process("DS3Tidefury",5,{"=q3=惡潮頭盔","=q3=惡潮肩衛","=q3=惡潮護軀","=q3=惡潮護手","=q3=惡潮褶裙"})
Process("DS3Wastewalker",5,{"=q3=荒行頭盔","=q3=荒行肩墊","=q3=荒行外套","=q3=荒行手套","=q3=荒行護腿"})
Process("HardModeAccessories",30,{"","=q4=靈巧胸針","=q4=邪惡意圖頸飾","=q4=永恆希望項鍊","=q4=狂熱項鍊","=q4=法力奔騰墜飾","=q4=光圈指環","=q4=阿拉希督軍之戒","=q4=隱秘夢境之戒","=q4=不屈之力指環","","=q3=原始虛空","=q4=蒼穹藍寶石","=q4=焚石","=q4=獅眼石","=q4=戰鬥大師之敏捷","=q4=戰鬥大師之無懼","=q4=戰鬥大師之殘虐","=q4=戰鬥大師之邪墮","=q4=戰鬥大師之決斷","=q4=戰鬥大師之堅忍","=q4=嗜血胸針","=q4=殉難者精華","=q4=諾姆瑞根自動格擋器600型","=q4=銀色弦月塑像","","=q4=虛空漩渦","=q4=海泉綠寶石","=q4=影歌紫水晶","=q4=赤紅尖晶石"})
Process("HardModeAccessories2",5,{"","=q4=安潔莉絲塔的復仇","=q4=安薇娜之觸","=q4=虛空熔合指環","=q4=堅實防衛者之戒"})
Process("HardModeCloaks",11,{"","=q4=主教的披風","=q4=血騎士戰爭披風","=q4=秘法敏捷披風","=q4=屈服之力披風","=q4=迅捷暫緩披風","=q4=朵莉之擁","=q4=遠行者防禦披風","=q4=卡瑪的希望罩氅","=q4=或然恆變披巾","=q4=思力克的安撫披風"})
Process("HardModeCloth",25,{"","=q4=那魯祈福風帽","=q4=禁法者風帽","=q4=符文法術腕輪","=q4=寧靜思緒護腕","=q4=聖光祝福手套","=q4=勤學裹手","=q4=巫毒編織腰帶","=q4=秘法滅絕窄褲","=q4=那魯的無色長褲","","","","","","","=q4=心靈奇蹟禮袍","=q4=洛倫尼爾罩衣","=q4=苦難魔魂長袍","=q4=役衛魂握","=q4=敬飾超凡裹腿","=q4=腐化的靈魂布窄褲","=q4=悶焰裹腿","=q4=咒術長靴","=q4=責任修補軟靴"})
Process("HardModeLeather",22,{"","=q4=怒獸者風帽","=q4=原始之力面具","=q4=欺詐者面罩","=q4=多節鐵木肩鎧","=q4=部族之怒肩鎧","=q4=受祝福的月神罩袍","=q4=休眠法衣","=q4=卡林多保衛者裹臂","=q4=迅捷之爪手環","=q4=靜眠之石妖護腕","=q4=刺客大師裹腕","=q4=月梟之握","=q4=狡詐指套","=q4=星火腰環","","=q4=偉大野獸護腰","=q4=驚人復原便褲","=q4=淺墓長褲","=q4=野性侵蝕裹足","=q4=寧賈的塔比之靴","=q4=月行步靴"})
Process("HardModeLeather2",13,{"","=q4=恆久無畏之擁","=q4=星光之擁","=q4=自然和諧罩衣","=q4=黑暗之刻外套","=q4=賢者倒刺手套","=q4=侵略者裹手","=q4=橡葉編織手甲","=q4=寂靜之途腰帶","=q4=晶風護腿","=q4=林地行者護腿","=q4=難馴馬褲","=q4=占卜者侍從長褲"})
Process("HardModeMail",30,{"","=q4=風暴大師的盔帽","=q4=扭曲行者頭盔","=q4=狂暴元素肩鎧","=q4=狂暴元素鍊衫","=q4=地震護腕","=q4=微光土靈護腕","=q4=沉著護腕","=q4=狙擊護手","=q4=自然憤怒之握","=q4=拋光水鱗手套","=q4=曼金度腰帶","=q4=風暴纏繞腰帶","=q4=戰爭羽飾之環","=q4=自然生命護腿","=q4=變換迷彩便褲","=q4=轟然雷鳴足靴","=q4=生命之徑足靴","","","","=q4=綴鱗龍皮護胸","=q4=狂旋之怒鍊衫","=q4=生命波動護胸","=q4=疾速護手","=q4=餘震護腰","=q4=柔和微風之攫","=q4=追擊護腿","=q4=上古符文綴鱗","=q4=奔騰風暴褶裙"})
Process("HardModePlate",21,{"","=q4=阿曼尼死亡面具","=q4=果決面甲","=q4=堅定勇士盔帽","=q4=可怖命運肩鎧","=q4=淡泊守護者護胸","=q4=上古方陣兵護腕","=q4=恆金狂怒鐐銬","=q4=那魯臂鎧","=q4=骨拳護手","=q4=狂暴死亡之握","=q4=聖殿騎士手甲","=q4=狂怒釋放之鍊","=q4=保衛者束腰","=q4=鐵牙束腰","","=q4=血嗜者戰脛","=q4=高階審判者腿鎧","=q4=不移腿甲","=q4=無情守衛脛甲","=q4=公正防衛者脛甲"})
Process("HardModePlate2",13,{"","=q4=忿怒胸甲","=q4=禁慾淡泊胸鎧","=q4=教士胸衣","=q4=撒塔斯護國者胸甲","=q4=沸騰怒火束腰","=q4=無懼的束腰","=q4=修復護腰","=q4=和解護脛","=q4=奧多爾銘文腿鎧","=q4=無盡憤怒腿鎧","=q4=太陽護衛腿鎧","=q4=布魯的公正守護者護脛"})
Process("HardModeRelic",20,{"","=q4=繁花塑像","=q4=生命新芽塑像","=q4=恐懼塑像","=q4=隱月塑像","","=q4=天喚圖騰","=q4=碎石者圖騰","=q4=活水圖騰","=q4=震地圖騰","","","","","","","=q4=神聖審判聖契","=q4=神聖意圖聖契","=q4=修補聖契","=q4=悔悟聖契"})
Process("HardModeResist",26,{"","=q4=地獄火織長袍","=q4=地獄火織手套","=q4=地獄火織護腿","=q4=地獄火織長靴","","","=q4=地獄硬化護胸","=q4=地獄硬化手套","=q4=地獄硬化護腿","=q4=地獄硬化長靴","","=q4=正義徽章","","","","=q4=地獄鍛造鍊衫","=q4=地獄鍛造手套","=q4=地獄鍛造護腿","=q4=地獄鍛造長靴","","","=q4=地獄淬鍊護胸","=q4=地獄淬鍊護手","=q4=地獄淬鍊護腿","=q4=地獄淬鍊長靴"})
Process("HardModeWeapons",27,{"","=q4=灼熱日光之刃","=q4=雕紋巫醫棍","=q4=麥索瑞爾榮譽之盾","=q4=聖光背負者的信念盾牌","=q4=寇達拉的藍色盾牌","=q4=原始神靈神像","=q4=火舌封印","=q4=卡德加的背包","=q4=嗜魂者寶珠","=q4=薩菲隆之翼骨","=q4=卡雷苟斯護符","=q4=天堂之淚","=q4=巫毒搖鼓","","","=q4=鋸突之刃","=q4=那魯祝福裁決槌","=q4=占卜者專注之刃","=q4=法尼爾的蠻橫右拳","=q4=法尼爾的蠻橫左拳","=q4=法尼爾的兇蠻左拳","=q4=無常迅刃","=q4=毀壞者","=q4=先驅者之刃","=q4=森林之王法杖","=q4=連擊之弩"})
Process("Legendaries",26,{"","=q5=雷霆之怒，逐風者的祝福之刃","=q5=薩弗拉斯，炎魔拉格納羅斯之手","=q5=黑色其拉共鳴水晶","","=q5=阿泰絲,守護者之杖","=q5=阿泰絲,守護者之杖","=q5=阿泰絲,守護者之杖","=q5=阿泰絲,守護者之杖","","","","","","","=q5=埃辛諾斯戰刃","=q5=埃辛諾斯戰刃","","=q5=無盡之刃","=q5=扭曲分割者","=q5=宇宙灌溉者","=q5=毀滅","=q5=瓦解之杖","=q5=相位壁壘","=q5=虛空之絃長弓","=q5=虛空之刺"}) --Missing: 22736
Process("RareMounts1",12,{"=q5=黑色其拉共鳴水晶","","=q4=骷髏戰馬韁繩","=q4=迅捷拉札希迅猛龍","=q4=迅捷祖利安猛虎","=q4=冬泉霜刃豹韁繩","=q4=烏龜坐騎","","=q3=藍色其拉共鳴水晶","=q3=綠色其拉共鳴水晶","=q3=紅色其拉共鳴水晶","=q3=黃色其拉共鳴水晶"})
Process("RareMounts2",26,{"=q4=迅捷虛空龍","=q4=殘忍虛空龍","","=q4=歐爾灰燼","=q4=熾炎戰馬韁繩","=q4=烏鴉領主韁繩","=q4=阿曼尼戰熊","","=q4=迅捷鬼靈之虎韁繩","=q3=鬼靈之虎韁繩","=q4=X51型虛空火箭極限版","=q3=X51型虛空火箭","","","","=q4=渦輪增壓飛行器控制裝置","=q3=飛行器控制裝置","","=q4=迅捷啤酒節山羊","=q3=啤酒節山羊","","=q4=迅捷飛行掃帚","=q4=迅捷魔法掃帚","=q3=飛行掃帚","=q3=老舊的魔法掃帚","=q2=不牢固的魔法掃帚"})
Process("T0Druid",24,{"","=q3=野性之心風帽","=q3=野性之心肩甲","=q3=野性之心外衣","=q3=野性之心護腕","=q3=野性之心手套","=q3=野性之心腰帶","=q3=野性之心褶裙","=q3=野性之心長靴","","","","","","","","=q4=野獸之心風帽","=q3=野獸之心肩甲","=q4=野獸之心外衣","=q3=野獸之心護腕","=q4=野獸之心手套","=q3=野獸之心腰帶","=q3=野獸之心褶裙","=q4=野獸之心長靴"})
Process("T0Hunter",24,{"","=q3=馭獸者軟帽","=q3=馭獸者披肩","=q3=馭獸者外套","=q3=馭獸者束腕","=q3=馭獸者手套","=q3=馭獸者腰帶","=q3=馭獸者便褲","=q3=馭獸者的靴子","","","","","","","","=q4=獸王軟帽","=q3=獸王披肩","=q4=獸王外套","=q3=獸王束腕","=q4=獸王手套","=q3=獸王腰帶","=q3=獸王褲裝","=q4=獸王的靴子"})
Process("T0Mage",24,{"","=q3=博學者之冠","=q3=博學者披肩","=q3=博學者長袍","=q3=博學者束腕","=q3=博學者手套","=q3=博學者腰帶","=q3=博學者護腿","=q3=博學者的靴子","","","","","","","","=q4=巫士之冠","=q3=巫士的披肩","=q4=巫士的長袍","=q3=巫士束腕","=q4=巫士的手套","=q3=巫士腰帶","=q3=巫士護腿","=q4=巫士之靴"})
Process("T0Paladin",24,{"","=q3=光鑄頭盔","=q3=光鑄肩甲","=q3=光鑄胸甲","=q3=光鑄護腕","=q3=光鑄護手","=q3=光鑄腰帶","=q3=光鑄腿鎧","=q3=光鑄長靴","","","","","","","","=q4=靈鑄頭盔","=q3=靈鑄肩甲","=q4=靈鑄胸甲","=q3=靈鑄護腕","=q4=靈鑄護手","=q3=靈鑄腰帶","=q3=靈鑄腿鎧","=q4=靈鑄長靴"})
Process("T0Priest",24,{"","=q3=虔誠之冠","=q3=虔誠披肩","=q3=虔誠長袍","=q3=虔誠護腕","=q3=虔誠手套","=q3=虔誠腰帶","=q3=虔誠長裙","=q3=虔誠便鞋","","","","","","","","=q4=善潔之冠","=q3=善潔披肩","=q4=善潔長袍","=q3=善潔護腕","=q4=善潔手套","=q3=善潔腰帶","=q3=善潔褶裙","=q4=善潔便鞋"})
Process("T0Rogue",24,{"","=q3=迅影軟帽","=q3=迅影肩甲","=q3=迅影外套","=q3=迅影護腕","=q3=迅影手套","=q3=迅影腰帶","=q3=迅影便褲","=q3=迅影長靴","","","","","","","","=q4=闇影軟帽","=q3=闇影肩甲","=q4=闇影外套","=q3=闇影護腕","=q4=闇影手套","=q3=闇影腰帶","=q3=闇影便褲","=q4=闇影長靴"})
Process("T0Shaman",24,{"","=q3=元素罩盔","=q3=元素肩鎧","=q3=元素外衣","=q3=元素束腕","=q3=元素護手","=q3=元素之索","=q3=元素褶裙","=q3=元素之靴","","","","","","","","=q4=五雷罩盔","=q3=五雷肩鎧","=q4=五雷外衣","=q3=五雷束腕","=q4=五雷護手","=q3=五雷之索","=q3=五雷褶裙","=q4=五雷之靴"})
Process("T0Warlock",24,{"","=q3=鬼霧面具","=q3=鬼霧披肩","=q3=鬼霧長袍","=q3=鬼霧護腕","=q3=鬼霧裹手","=q3=鬼霧腰帶","=q3=鬼霧護腿","=q3=鬼霧便鞋","","","","","","","","=q4=亡霧面具","=q3=亡霧披肩","=q4=亡霧長袍","=q3=亡霧護腕","=q4=亡霧裹手","=q3=亡霧腰帶","=q3=亡霧護腿","=q4=亡霧便鞋"})
Process("T0Warrior",24,{"","=q3=勇氣頭盔","=q3=勇氣肩甲","=q3=勇氣胸甲","=q3=勇氣護腕","=q3=勇氣護手","=q3=勇氣腰帶","=q3=勇氣腿鎧","=q3=勇氣之靴","","","","","","","","=q4=英氣頭盔","=q3=英氣肩甲","=q4=英氣胸甲","=q3=英氣護腕","=q4=英氣護手","=q3=英氣腰帶","=q3=英氣腿鎧","=q4=英氣之靴"})
Process("T1Druid",9,{"","=q4=塞納里奧頭盔","=q4=塞納里奧肩甲","=q4=塞納里奧法衣","=q4=塞納里奧護腕","=q4=塞納里奧手套","=q4=塞納里奧腰帶","=q4=塞納里奧護腿","=q4=塞納里奧長靴"})
Process("T1Hunter",9,{"","=q4=巨獸之王盔帽","=q4=巨獸之王肩冑","=q4=巨獸之王胸甲","=q4=巨獸之王護腕","=q4=巨獸之王手套","=q4=巨獸之王腰帶","=q4=巨獸之王護腿","=q4=巨獸之王的靴子"})
Process("T1Mage",9,{"","=q4=秘法師之冠","=q4=秘法師披肩","=q4=秘法師長袍","=q4=秘法師束腕","=q4=秘法師手套","=q4=秘法師腰帶","=q4=秘法師護腿","=q4=秘法師便鞋"})
Process("T1Paladin",9,{"","=q4=秩序之源頭盔","=q4=秩序之源肩甲","=q4=秩序之源護胸","=q4=秩序之源護腕","=q4=秩序之源護手","=q4=秩序之源腰帶","=q4=秩序之源腿鎧","=q4=秩序之源長靴"})
Process("T1Priest",9,{"","=q4=預言頭環","=q4=預言披肩","=q4=預言長袍","=q4=預言臂鎧","=q4=預言手套","=q4=預言束腰","=q4=預言便褲","=q4=預言之靴"})
Process("T1Rogue",9,{"","=q4=黑夜殺手頭罩","=q4=黑夜殺手墊肩","=q4=黑夜殺手護軀","=q4=黑夜殺手手鐲","=q4=黑夜殺手手套","=q4=黑夜殺手腰帶","=q4=黑夜殺手便褲","=q4=黑夜殺手長靴"})
Process("T1Shaman",9,{"","=q4=大地之怒盔帽","=q4=大地之怒肩冑","=q4=大地之怒法衣","=q4=大地之怒護腕","=q4=大地之怒護手","=q4=大地之怒腰帶","=q4=大地之怒腿甲","=q4=大地之怒長靴"})
Process("T1Warlock",9,{"","=q4=惡魔之心軟帽","=q4=惡魔之心墊肩","=q4=惡魔之心長袍","=q4=惡魔之心護腕","=q4=惡魔之心手套","=q4=惡魔之心腰帶","=q4=惡魔之心便褲","=q4=惡魔之心軟靴"})
Process("T1Warrior",9,{"","=q4=力量頭盔","=q4=力量肩鎧","=q4=力量胸甲","=q4=力量護腕","=q4=力量護手","=q4=力量腰帶","=q4=力量腿鎧","=q4=力量脛甲"})
Process("T2Druid",9,{"","=q4=怒風頭罩","=q4=怒風肩鎧","=q4=怒風護胸","=q4=怒風護腕","=q4=怒風手甲","=q4=怒風腰帶","=q4=怒風腿甲","=q4=怒風長靴"})
Process("T2Hunter",9,{"","=q4=馭龍者頭盔","=q4=馭龍者肩甲","=q4=馭龍者胸甲","=q4=馭龍者護腕","=q4=馭龍者護手","=q4=馭龍者腰帶","=q4=馭龍者腿甲","=q4=馭龍者護脛"})
Process("T2Mage",9,{"","=q4=靈風之冠","=q4=靈風披肩","=q4=靈風長袍","=q4=靈風束腕","=q4=靈風手套","=q4=靈風腰帶","=q4=靈風便褲","=q4=靈風長靴"})
Process("T2Paladin",9,{"","=q4=審判之冠","=q4=審判肩甲","=q4=審判胸甲","=q4=審判束腕","=q4=審判護手","=q4=審判腰帶","=q4=審判腿鎧","=q4=審判脛甲"})
Process("T2Priest",9,{"","=q4=卓越輝環","=q4=卓越肩鎧","=q4=卓越長袍","=q4=卓越束腕","=q4=卓越手甲","=q4=卓越腰帶","=q4=卓越護腿","=q4=卓越之靴"})
Process("T2Rogue",9,{"","=q4=血牙兜帽","=q4=血牙肩甲","=q4=血牙護軀","=q4=血牙護腕","=q4=血牙手套","=q4=血牙腰帶","=q4=血牙便褲","=q4=血牙長靴"})
Process("T2Shaman",9,{"","=q4=無盡風暴盔帽","=q4=無盡風暴肩冑","=q4=無盡風暴胸甲","=q4=無盡風暴護腕","=q4=無盡風暴護手","=q4=無盡風暴腰帶","=q4=無盡風暴腿鎧","=q4=無盡風暴護脛"})
Process("T2Warlock",9,{"","=q4=復仇顱帽","=q4=復仇肩甲","=q4=復仇長袍","=q4=復仇護腕","=q4=復仇手套","=q4=復仇腰帶","=q4=復仇護腿","=q4=復仇長靴"})
Process("T2Warrior",9,{"","=q4=憤怒頭盔","=q4=憤怒肩鎧","=q4=憤怒胸甲","=q4=憤怒手鐲","=q4=憤怒護手","=q4=憤怒腰環","=q4=憤怒腿鎧","=q4=憤怒脛甲"})
Process("T3Druid",10,{"","=q4=夢行者首盔","=q4=夢行者肩甲","=q4=夢行者外套","=q4=夢行者腕甲","=q4=夢行者手甲","=q4=夢行者束腰","=q4=夢行者腿甲","=q4=夢行者長靴","=q4=夢行者戒指"})
Process("T3Hunter",10,{"","=q4=地穴行者首盔","=q4=地穴行者肩甲","=q4=地穴行者外套","=q4=地穴行者腕甲","=q4=地穴行者手甲","=q4=地穴行者束腰","=q4=地穴行者腿甲","=q4=地穴行者長靴","=q4=地穴行者戒指"})
Process("T3Mage",10,{"","=q4=霜火頭環","=q4=霜火肩墊","=q4=霜火長袍","=q4=霜火束腕","=q4=霜火手套","=q4=霜火腰帶","=q4=霜火護腿","=q4=霜火便鞋","=q4=霜火戒指"})
Process("T3Paladin",10,{"","=q4=救贖首盔","=q4=救贖肩甲","=q4=救贖外套","=q4=救贖腕甲","=q4=救贖手甲","=q4=救贖束腰","=q4=救贖腿甲","=q4=救贖長靴","=q4=救贖戒指"})
Process("T3Priest",10,{"","=q4=信仰頭環","=q4=信仰肩墊","=q4=信仰長袍","=q4=信仰束腕","=q4=信仰手套","=q4=信仰腰帶","=q4=信仰護腿","=q4=信仰便鞋","=q4=信仰戒指"})
Process("T3Rogue",10,{"","=q4=骨鐮盔帽","=q4=骨鐮肩鎧","=q4=骨鐮胸甲","=q4=骨鐮護腕","=q4=骨鐮護手","=q4=骨鐮護腰","=q4=骨鐮腿鎧","=q4=骨鐮脛甲","=q4=骨鐮之戒"})
Process("T3Shaman",10,{"","=q4=粉碎大地首盔","=q4=粉碎大地肩甲","=q4=粉碎大地外套","=q4=粉碎大地腕甲","=q4=粉碎大地手甲","=q4=粉碎大地束腰","=q4=粉碎大地腿甲","=q4=粉碎大地長靴","=q4=粉碎大地戒指"})
Process("T3Warlock",10,{"","=q4=瘟疫之心頭環","=q4=瘟疫之心肩墊","=q4=瘟疫之心長袍","=q4=瘟疫之心束腕","=q4=瘟疫之心手套","=q4=瘟疫之心腰帶","=q4=瘟疫之心護腿","=q4=瘟疫之心便鞋","=q4=瘟疫之心戒指"})
Process("T3Warrior",10,{"","=q4=無畏盔帽","=q4=無畏肩鎧","=q4=無畏胸甲","=q4=無畏護腕","=q4=無畏護手","=q4=無畏護腰","=q4=無畏腿鎧","=q4=無畏脛甲","=q4=無畏戒指"})
Process("T4Druid",21,{"","=q4=瑪洛尼戰馭鹿盔","=q4=瑪洛尼戰馭披肩","=q4=瑪洛尼戰馭胸甲","=q4=瑪洛尼戰馭護手","=q4=瑪洛尼戰馭護脛","","","=q4=瑪洛尼儀祭之冠","=q4=瑪洛尼儀祭肩衛","=q4=瑪洛尼儀祭護胸","=q4=瑪洛尼儀祭手甲","=q4=瑪洛尼儀祭腿甲","","","","=q4=瑪洛尼戰衣角盔","=q4=瑪洛尼戰衣肩鎧","=q4=瑪洛尼戰衣護軀","=q4=瑪洛尼戰衣手套","=q4=瑪洛尼戰衣馬褲"})
Process("T4Hunter",6,{"","=q4=惡魔獵者巨盔","=q4=惡魔獵者肩衛","=q4=惡魔獵者背心","=q4=惡魔獵者護手","=q4=惡魔獵者護脛"})
Process("T4Mage",6,{"","=q4=奧多爾頭帶","=q4=奧多爾肩鎧","=q4=奧多爾法衣","=q4=奧多爾手套","=q4=奧多爾裹腿"})
Process("T4Paladin",21,{"","=q4=審判者防禦面甲","=q4=審判者防禦肩衛","=q4=審判者防禦護胸","=q4=審判者防禦手甲","=q4=審判者防禦腿甲","","","=q4=審判者戰甲之冠","=q4=審判者戰甲重肩甲","=q4=審判者戰甲胸甲","=q4=審判者戰甲護手","=q4=審判者戰甲護脛","","","","=q4=審判者神聖冠冕","=q4=審判者神聖肩鎧","=q4=審判者神聖護軀","=q4=審判者神聖手套","=q4=審判者神聖護腿"})
Process("T4Priest",13,{"","=q4=聖軀儀祭神光頭帶","=q4=聖軀儀祭神光披肩","=q4=聖軀儀祭長袍","=q4=聖軀儀祭裹手","=q4=聖軀儀祭長褲","","","=q4=聖軀戰衣靈魂頭帶","=q4=聖軀戰衣靈魂披肩","=q4=聖軀戰衣罩衣","=q4=聖軀戰衣手套","=q4=聖軀戰衣護腿"})
Process("T4Rogue",6,{"","=q4=虛空之刃面罩","=q4=虛空之刃肩墊","=q4=虛空之刃護軀","=q4=虛空之刃手套","=q4=虛空之刃長褲"})
Process("T4Shaman",21,{"","=q4=颶風戰馭頭盔","=q4=颶風戰馭重肩甲","=q4=颶風戰馭胸甲","=q4=颶風戰馭護手","=q4=颶風戰馭褶裙","","","=q4=颶風儀祭頭飾","=q4=颶風儀祭肩墊","=q4=颶風儀祭鍊衫","=q4=颶風儀祭手套","=q4=颶風儀祭褶裙","","","","=q4=颶風戰衣面甲","=q4=颶風戰衣肩衛","=q4=颶風戰衣護胸","=q4=颶風戰衣手甲","=q4=颶風戰衣腿甲"})
Process("T4Warlock",6,{"","=q4=虛無之心頭冠","=q4=虛無之心披肩","=q4=虛無之心長袍","=q4=虛無之心手套","=q4=虛無之心護腿"})
Process("T4Warrior",13,{"","=q4=戰爭使者防禦巨盔","=q4=戰爭使者防禦肩衛","=q4=戰爭使者防禦護胸","=q4=戰爭使者防禦手甲","=q4=戰爭使者防禦腿甲","","","=q4=戰爭使者鬥盔","=q4=戰爭使者戰甲重肩甲","=q4=戰爭使者戰甲胸甲","=q4=戰爭使者戰甲護手","=q4=戰爭使者戰甲護脛"})
Process("T5Druid",21,{"","=q4=諾達希爾野性頭飾","=q4=諾達希爾野性披肩","=q4=諾達希爾野性胸鎧","=q4=諾達希爾野性纏手","=q4=諾達希爾野性褶裙","","","=q4=諾達希爾生命護盔","=q4=諾達希爾生命披肩","=q4=諾達希爾生命護胸","=q4=諾達希爾生命手套","=q4=諾達希爾生命褶裙","","","","=q4=諾達希爾憤怒首盔","=q4=諾達希爾憤怒披肩","=q4=諾達希爾憤怒護軀","=q4=諾達希爾憤怒護手","=q4=諾達希爾憤怒褶裙"})
Process("T5Hunter",6,{"","=q4=裂隙行者頭盔","=q4=裂隙行者披肩","=q4=裂隙行者鍊衫","=q4=裂隙行者護手","=q4=裂隙行者護腿"})
Process("T5Mage",6,{"","=q4=提里斯法風帽","=q4=提里斯法披肩","=q4=提里斯法長袍","=q4=提里斯法手套","=q4=提里斯法護腿"})
Process("T5Paladin",21,{"","=q4=晶鑄防禦面甲","=q4=晶鑄防禦肩衛","=q4=晶鑄防禦護胸","=q4=晶鑄防禦手甲","=q4=晶鑄防禦腿甲","","","=q4=晶鑄戰甲戰盔","=q4=晶鑄戰甲護肩","=q4=晶鑄戰甲胸甲","=q4=晶鑄戰甲護手","=q4=晶鑄戰甲護脛","","","","=q4=晶鑄神聖巨盔","=q4=晶鑄神聖肩鎧","=q4=晶鑄神聖護軀","=q4=晶鑄神聖手套","=q4=晶鑄神聖護腿"})
Process("T5Priest",13,{"","=q4=聖者儀祭風帽","=q4=聖者儀祭披肩","=q4=聖者儀祭法衣","=q4=聖者儀祭手套","=q4=聖者儀祭長褲","","","=q4=聖者戰衣頭飾","=q4=聖者戰衣翼肩","=q4=聖者戰衣罩衣","=q4=聖者戰衣手甲","=q4=聖者戰衣護腿"})
Process("T5Rogue",6,{"","=q4=死神傳承頭盔","=q4=死神傳承肩墊","=q4=死神傳承護胸","=q4=死神傳承手甲","=q4=死神傳承腿甲"})
Process("T5Shaman",21,{"","=q4=裂地戰馭頭盔","=q4=裂地戰馭重肩甲","=q4=裂地戰馭胸鎧","=q4=裂地戰馭護手","=q4=裂地戰馭腿鎧","","","=q4=裂地儀祭護盔","=q4=裂地儀祭肩衛","=q4=裂地儀祭護胸","=q4=裂地儀祭手套","=q4=裂地儀祭腿甲","","","","=q4=裂地戰衣首盔","=q4=裂地戰衣肩墊","=q4=裂地戰衣護軀","=q4=裂地戰衣纏手","=q4=裂地戰衣護腿"})
Process("T5Warlock",6,{"","=q4=墮落者兜帽","=q4=墮落者披肩","=q4=墮落者長袍","=q4=墮落者手套","=q4=墮落者護腿"})
Process("T5Warrior",13,{"","=q4=毀滅者防禦巨盔","=q4=毀滅者防禦肩衛","=q4=毀滅者防禦護胸","=q4=毀滅者防禦手甲","=q4=毀滅者防禦腿甲","","","=q4=毀滅者戰甲鬥盔","=q4=毀滅者戰甲肩刃","=q4=毀滅者戰甲胸甲","=q4=毀滅者戰甲護手","=q4=毀滅者戰甲護脛"})
Process("T6Druid",24,{"","=q4=雷霆之心戰馭頭罩","=q4=雷霆之心戰馭肩鎧","=q4=雷霆之心戰馭護胸","=q4=雷霆之心戰馭腕甲","=q4=雷霆之心戰馭護手","=q4=雷霆之心戰馭護腰","=q4=雷霆之心戰馭護腿","=q4=雷霆之心戰馭足靴","","","","","","","","=q4=雷霆之心儀祭盔帽","=q4=雷霆之心儀祭肩甲","=q4=雷霆之心儀祭外套","=q4=雷霆之心儀祭腕甲","=q4=雷霆之心儀祭手套","=q4=雷霆之心儀祭腰帶","=q4=雷霆之心儀祭腿甲","=q4=雷霆之心儀祭長靴"})
Process("T6Druid2",9,{"","=q4=雷霆之心戰衣護盔","=q4=雷霆之心戰衣肩墊","=q4=雷霆之心戰衣外衣","=q4=雷霆之心戰衣腕甲","=q4=雷霆之心戰衣手甲","=q4=雷霆之心戰衣之索","=q4=雷霆之心戰衣便褲","=q4=雷霆之心戰衣裹足"})
Process("T6Hunter",9,{"","=q4=古羅行者的盔帽","=q4=古羅行者的肩甲","=q4=古羅行者的護胸","=q4=古羅行者護腕","=q4=古羅行者的手套","=q4=古羅行者腰帶","=q4=古羅行者的護腿","=q4=古羅行者長靴"})
Process("T6Mage",9,{"","=q4=風暴風帽","=q4=風暴披肩","=q4=風暴長袍","=q4=風暴護腕","=q4=風暴手套","=q4=風暴腰帶","=q4=風暴護腿","=q4=風暴長靴"})
Process("T6Paladin",24,{"","=q4=光明使者防禦面甲","=q4=光明使者防禦肩衛","=q4=光明使者防禦護胸","=q4=光明使者防禦腕甲","=q4=光明使者防禦手甲","=q4=光明使者防禦護腰","=q4=光明使者防禦腿甲","=q4=光明使者踏靴","","","","","","","","=q4=光明使者戰甲戰盔","=q4=光明使者戰甲肩甲","=q4=光明使者戰甲胸甲","=q4=光明使者戰甲手環","=q4=光明使者戰甲護手","=q4=光明使者戰甲束腰","=q4=光明使者戰甲護脛","=q4=光明使者戰甲長靴"})
Process("T6Paladin2",9,{"","=q4=光明使者神聖頭盔","=q4=光明使者神聖肩鎧","=q4=光明使者神聖護軀","=q4=光明使者神聖護腕","=q4=光明使者神聖手套","=q4=光明使者神聖腰帶","=q4=光明使者神聖護腿","=q4=光明使者神聖足靴"})
Process("T6Priest",24,{"","=q4=赦免儀祭風帽","=q4=赦免儀祭披肩","=q4=赦免儀祭法衣","=q4=赦免儀祭腕輪","=q4=赦免儀祭手套","=q4=赦免儀祭腰帶","=q4=赦免儀祭長褲","=q4=赦免儀祭長靴","","","","","","","","=q4=赦免戰衣兜帽","=q4=赦免戰衣肩墊","=q4=赦免戰衣罩衣","=q4=赦免戰衣護腕","=q4=赦免戰衣手甲","=q4=赦免戰衣之索","=q4=赦免戰衣護腿","=q4=赦免戰衣足靴"})
Process("T6Rogue",9,{"","=q4=殺戮者頭盔","=q4=殺戮者肩墊","=q4=殺戮者護胸","=q4=殺戮者護腕","=q4=殺戮者手甲","=q4=殺戮者腰帶","=q4=殺戮者腿甲","=q4=殺戮者長靴"})
Process("T6Shaman",24,{"","=q4=碎天者戰馭頭罩","=q4=碎天者戰馭肩鎧","=q4=碎天者戰馭外套","=q4=碎天者戰馭腕甲","=q4=碎天者戰馭之握","=q4=碎天者戰馭束腰","=q4=碎天者戰馭便褲","=q4=碎天者戰馭護脛","","","","","","","","=q4=碎天者儀祭盔帽","=q4=碎天者儀祭肩墊","=q4=碎天者儀祭護胸","=q4=碎天者儀祭護腕","=q4=碎天者儀祭手套","=q4=碎天者儀祭腰帶","=q4=碎天者儀祭護腿","=q4=碎天者儀祭長靴"})
Process("T6Shaman2",9,{"","=q4=碎天者戰衣護盔","=q4=碎天者戰衣披肩","=q4=碎天者戰衣胸甲","=q4=碎天者戰衣手環","=q4=碎天者戰衣護手","=q4=碎天者戰衣之索","=q4=碎天者戰衣腿甲","=q4=碎天者戰衣足靴"})
Process("T6Warlock",9,{"","=q4=邪惡戰衣頭環","=q4=邪惡戰衣披肩","=q4=邪惡戰衣長袍","=q4=邪惡戰衣護腕","=q4=邪惡戰衣手套","=q4=邪惡戰衣腰帶","=q4=邪惡戰衣護腿","=q4=邪惡戰衣長靴"})
Process("T6Warrior",24,{"","=q4=猛擊防禦巨盔","=q4=猛擊防禦肩衛","=q4=猛擊防禦護胸","=q4=猛擊防禦腕甲","=q4=猛擊防禦手甲","=q4=猛擊防禦護腰","=q4=猛擊防禦腿甲","=q4=猛擊防禦長靴","","","","","","","","=q4=猛擊戰甲鬥盔","=q4=猛擊戰甲肩刃","=q4=猛擊戰甲胸甲","=q4=猛擊戰甲護腕","=q4=猛擊戰甲護手","=q4=猛擊戰甲腰帶","=q4=猛擊戰甲護脛","=q4=猛擊戰甲足靴"})
Process("TBCAzzinothBlades",3,{"","=q5=埃辛諾斯戰刃","=q5=埃辛諾斯戰刃"})
Process("TBCLatrosFlurry",3,{"","=q3=拉托的躍舞之刃","=q3=拉托的移形長劍"})
Process("TBCTwinStars",3,{"","=q4=夏綠蒂的常春藤","=q4=蘿拉之夜"})
Process("Tabards1",31,{"=q4=烈焰外袍","=q4=冰霜外袍","","","","","=q1=奧多爾外袍","=q1=塞納里奧遠征外袍","=q1=榮譽堡外袍","=q1=時光守望者外袍","=q1=陰鬱城外袍","=q1=歐格利拉外袍","=q1=薩塔外袍","=q1=斯博格爾外袍","=q1=阿格斯之手外袍","=q1=破碎之日外袍","=q2=綠色伊利達瑞戰利外袍","=q2=伊利達瑞紫色勝利外袍","=q2=血色十字軍外袍","=q1=冠軍外袍","","","=q1=血騎士外袍","=q1=聯合團外袍","=q1=卡爾奈外袍","=q1=瑪格哈外袍","=q1=占卜者外袍","=q1=禦天者外袍","=q1=銀色黎明外袍","=q1=保衛者外袍","=q1=索爾瑪外袍"}) --Missing: 35279, 35280
Process("Tabards2",21,{"","=q1=士兵外袍","=q1=騎士彩帶","=q1=阿拉索軍服","=q1=雷矛軍服","=q1=銀翼軍服","","","","","","","","","","","=q1=斥候外袍","=q1=石守衛的紋章","=q1=污染者軍服","=q1=霜狼軍服","=q1=戰歌軍服"})
Process("VWOWBlackrockD",6,{"","=q3=野蠻角鬥士頭盔","=q4=野蠻角鬥士鍊甲","=q3=野蠻角鬥士護手","=q3=野蠻角鬥士護腿","=q3=野蠻角鬥士護脛"})
Process("VWOWDalRend",3,{"","=q3=雷德的神聖控訴者","=q3=雷德的部族護衛者"})
Process("VWOWDeadmines",6,{"","=q3=黑暗迪菲亞護甲","=q2=黑暗迪菲亞手套","=q3=黑暗迪菲亞腰帶","=q2=黑暗迪菲亞護腿","=q2=黑暗迪菲亞長靴"})
Process("VWOWHakkariBlades",3,{"","=q4=哈卡萊戰刃","=q4=哈卡萊戰刃"})
Process("VWOWIronweave",9,{"","=q3=鐵織風帽","=q3=鐵織披肩","=q3=鐵織長袍","=q3=鐵織護腕","=q3=鐵織手套","=q3=鐵織腰帶","=q3=鐵織便褲","=q3=鐵織長靴"})
Process("VWOWPrimalBlessing",3,{"","=q4=塞卡爾之握","=q4=婭爾羅之握"})
Process("VWOWScarletM",7,{"","=q3=血色十字軍護軀","=q2=血色十字軍腕甲","=q2=血色十字軍護手","=q2=血色十字軍腰帶","=q3=血色十字軍護腿","=q3=血色十字軍長靴"})
Process("VWOWScholoCloth",6,{"","=q3=骨堆披肩","=q3=骨堆長袍","=q3=骨堆腕輪","=q3=骨堆護腿","=q3=骨堆長靴"})
Process("VWOWScholoLeather",6,{"","=q3=蒼白護甲","=q3=蒼白手套","=q3=蒼白腰帶","=q3=蒼白護腿","=q3=蒼白步靴"})
Process("VWOWScholoMail",6,{"","=q3=血鏈鍊衫","=q3=血鏈護手","=q3=血鏈腰帶","=q3=血鏈腿甲","=q3=血鏈長靴"})
Process("VWOWScholoPlate",6,{"","=q3=亡骨胸鎧","=q3=亡骨護手","=q3=亡骨束腰","=q3=亡骨腿甲","=q3=亡骨脛甲"})
Process("VWOWScourgeInvasion",24,{"","=q3=淨妖長袍","=q3=淨妖護腕","=q3=淨妖手套","","","=q3=弒妖外套","=q3=弒妖裹腕","=q3=弒妖裹手","","","","","","","","=q3=弒妖護胸","=q3=弒妖腕甲","=q3=弒妖手甲","","","=q3=弒妖胸甲","=q3=弒妖護腕","=q3=弒妖護手"})
Process("VWOWShardOfGods",3,{"","=q4=烈焰裂片","=q4=龍鱗裂片"})
Process("VWOWSpiderKiss",3,{"","=q3=水晶蜘蛛之牙","=q3=噴毒者"})
Process("VWOWSpiritofEskhandar",5,{"","=q4=艾斯卡達爾的毛皮","=q4=艾斯卡達爾的項圈","=q4=艾斯卡達爾的右爪","=q4=艾斯卡達爾的左爪"})
Process("VWOWStrat",6,{"","=q3=郵差護腕","=q3=郵差外套","=q3=郵差長褲","=q3=郵差的足靴","=q3=郵差徽印"})
Process("VWOWWailingC",6,{"","=q3=尖牙鎧甲","=q3=尖牙手套","=q3=尖牙腰帶","=q3=尖牙護腿","=q3=尖牙薄靴"})
Process("VWOWZGRings",22,{"","=q3=金度的徽印","=q3=金度的指環","","","=q3=霸主紅色指環","=q3=霸主瑪瑙指環","","","","","","","","","","=q3=原獵者的徽印","=q3=原獵者指環","","","=q3=贊吉爾指環","=q3=贊吉爾的徽印"})
Process("WorldEpics1",22,{"=q4=聖力手套","=q4=冰鍊上衣","=q4=地獄指環","","","","","","","","","","","","","=q4=眩光","=q4=黑夜刀刃","=q4=熾炎戰斧","=q4=熱情監護者","=q4=喬丹法杖","=q4=綠塔","=q4=灼熱弓"})
Process("WorldEpics2",28,{"=q4=烈焰之眼","=q4=洞察長袍","=q4=劍師手甲","=q4=碎石護手","=q4=閃避之靴","=q4=百合","=q4=寒冰指環","=q4=救世之戒","","","","","","","","=q4=斷腸","=q4=影刃","=q4=血刃","=q4=風暴戰斧","=q4=斬首者康恩","=q4=北風之錘","=q4=碎冰者","=q4=亮木法杖","=q4=典獄官法杖","=q4=黑顱","=q4=亡者之牆","=q4=颶風","=q4=精確校準過的火槍"})
Process("WorldEpics3",26,{"=q4=烈焰披風","=q4=憐憫束帶","=q4=納爾維之盔","=q4=牢獄肩鎧","=q4=踏雲腿鎧","=q4=凱威恩的珠寶護符","=q4=麥耶女士的墜飾","=q4=侍從的徽記","=q4=生命徽章","=q4=暴風雄獅號角","","","","","","=q4=提布的熾炎長劍","=q4=亞考爾的陽炎刀","=q4=克羅之刃","=q4=漢娜之刃","=q4=命運","=q4=密林戰斧","=q4=碎靈","=q4=愛德華之手","=q4=元素法杖","=q4=骨火","=q4=矮人手持火砲"})
Process("WorldEpics4",24,{"=q4=生命授予披風","=q4=愛德華之願","=q4=卡媚的天藍色裙子","=q4=暗夜守衛者","=q4=電光之冠","=q4=野獸統御護腿","=q4=成長便褲","=q4=流亡護胸","=q4=夏綠蒂的常春藤","=q4=悔悟頸飾","=q4=頑固防禦指環","=q4=蘿拉之夜","=q4=強擊指環","","","=q4=暗夜之刃","=q4=巫術之刃","=q4=閃現打擊","=q4=歌唱水晶之斧","=q4=蘇冥上古錘杖","=q4=命運之錘","=q4=自然之怒法杖","=q4=裂脊","=q4=桑朵先生的知名獵槍"})
Process("ZGDruid",6,{"","=q4=烏蘇雷的自然符咒","=q4=原始附魔南海海藻","=q4=贊達拉占卜師外套","=q4=贊達拉占卜師腰帶","=q4=贊達拉占卜師護腕"})
Process("ZGHunter",6,{"","=q4=雷納塔基的野獸符咒","=q4=漩渦之怒","=q4=贊達拉捕獵者披肩","=q4=贊達拉捕獵者腰帶","=q4=贊達拉捕獵者護腕"})
Process("ZGMage",6,{"","=q4=哈札拉爾的魔法符咒","=q4=卡亞羅的珠寶","=q4=贊達拉幻術師長袍","=q4=贊達拉幻術師披肩","=q4=贊達拉幻術師裹帶"})
Process("ZGPaladin",6,{"","=q4=格里雷克的勇氣符咒","=q4=英雄的烙印","=q4=贊達拉思考者胸甲","=q4=贊達拉思考者腰帶","=q4=贊達拉思考者護臂"})
Process("ZGPriest",6,{"","=q4=哈札拉爾的治療符咒","=q4=祖達薩的全視之眼","=q4=贊達拉懺悔者披肩","=q4=贊達拉懺悔者腰帶","=q4=贊達拉懺悔者裹帶"})
Process("ZGRogue",6,{"","=q4=雷納塔基的狡詐符咒","=q4=贊達拉暗影大師墜飾","=q4=贊達拉狂妄者外套","=q4=贊達拉狂妄者披肩","=q4=贊達拉狂妄者護腕"})
Process("ZGShaman",6,{"","=q4=烏蘇雷的靈魂符咒","=q4=完美巫毒幻象","=q4=贊達拉占兆師鍊衫","=q4=贊達拉占兆師腰帶","=q4=贊達拉占兆師護腕"})
Process("ZGWarlock",6,{"","=q4=哈札拉爾的毀滅符咒","=q4=科贊的強力玷污","=q4=贊達拉惡魔師長袍","=q4=贊達拉惡魔師披肩","=q4=贊達拉惡魔師裹帶"})
Process("ZGWarrior",6,{"","=q4=格里雷克的力量符咒","=q4=穆賈巴之怒","=q4=贊達拉辯護者胸甲","=q4=贊達拉辯護者腰帶","=q4=贊達拉辯護者護臂"})
end
