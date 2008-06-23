﻿--[[
--AtlasLoot loot tables zhTW localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--NOTE-zhTW: 本檔是由程式自動生成的，請勿人工干預，任何手動更改都可能會被覆蓋！
--$Date: 2008-06-21 12:22:45 -0400 (Sat, 21 Jun 2008) $
--]]
if (GetLocale() == "zhTW") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootRepItems"][category] or #AtlasLoot_Data["AtlasLootRepItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootRepItems"][category][i][3] = data[i] end end data = nil end
Process("AQBroodRings",21,{"","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","","","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","","","","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒","=q4=青銅龍軍團的徽記之戒"})
Process("Aldor1",27,{"","=q2=設計圖:微光的黃金卓奈石","=q1=設計圖:烈焰毀滅護腕","=q1=圖樣:烈焰之心護腕","","","","","","","","","","","","","=q3=隱士長袍","=q2=紀律銘文","=q2=信念銘文","=q2=復仇銘文","=q2=防護銘文","=q2=設計圖:皇家的暗影卓奈石","=q1=設計圖:烈焰毀滅手套","=q1=圖樣:爆烈守衛腰帶","=q1=圖樣:火鱗腰帶","=q1=圖樣:烈焰之心手套","=q1=圖樣:銀色法術絲線"})
Process("Aldor2",28,{"","=q3=復仇者鍊衫","=q3=光明看護者指環","=q3=奧奇奈法杖","=q3=設計圖:絕影墜飾","=q1=設計圖:烈焰毀滅胸甲","=q1=圖樣:爆烈守衛長靴","=q1=圖樣:火鱗長靴","=q1=圖樣:復仇者護甲片","","","","","","","","=q4=光明先驅者勳章","=q4=復仇者佩劍","=q3=強效紀律銘文","=q3=強效信念銘文","=q3=強效復仇銘文","=q3=強效防護銘文","=q1=設計圖:烈焰毀滅頭盔","=q1=圖樣:爆烈守衛便褲","=q1=圖樣:火鱗護腿","=q1=圖樣:金色法術絲線","=q1=圖樣:烈焰之心外衣","=q1=奧多爾外袍"})
Process("Argent1",25,{"=q3=聖療皮頭盔","=q3=瘟疫獵人護腿","=q3=虔誠指環","=q3=堅決指環","=q3=法雷盟的最後計畫","=q3=補給袋","","=q3=暗影守護者","","=q2=黎明徽記","","","","","","=q4=希望護腕","=q4=狡猾護腕","=q4=黎明護符","=q4=黎明勳章","=q4=權勢護符","=q4=淨化者","","=q3=冰霜守護者","","=q2=十字軍徽記"})
Process("Argent2",30,{"","=q1=可口的魔法點心","","","=q2=配方:轉氣成火","=q1=設計圖:黎明束腰","=q1=公式:附魔護腕 - 法力恢復","=q1=配方:特強抗毒藥劑","=q1=圖樣:黎明皮靴","=q1=圖樣:銀色長靴","","","","=q2=銀色黎明勇氣勳章","","","=q2=秘法黎明披肩","=q2=火焰黎明披肩","=q2=冰霜黎明披肩","=q2=自然黎明披肩","=q2=暗影黎明披肩","=q1=設計圖:黎明手套","=q1=公式:附魔護腕 - 治療","=q1=圖樣:金色黎明披肩","=q1=圖樣:銀色護肩","=q1=受祝福的太陽果","=q1=受祝福的太陽果汁","","","=q2=炫彩黎明披肩"})
Process("Ashtongue1",25,{"","=q1=設計圖:影堅束腰","=q1=設計圖:影堅護腕","=q1=圖樣:救贖之魂繫腰","=q1=圖樣:救贖之魂腿甲","=q1=圖樣:束縛之魂護腕","=q1=圖樣:束縛之魂長靴","=q1=圖樣:靈魂守護束腰","=q1=圖樣:靈魂守護護腕","","","","","","","","=q1=設計圖:影堅護脛","=q1=設計圖:影堅戰靴","=q1=圖樣:救贖之魂底鞋","=q1=圖樣:救贖之魂腕甲","=q1=圖樣:束縛之魂護脛","=q1=圖樣:束縛之魂護腰","=q1=圖樣:夜幕之終","=q1=圖樣:靈魂守護護腿","=q1=圖樣:靈魂守護軟靴"})
Process("Ashtongue2",10,{"","=q4=灰舌平衡護符","=q4=灰舌迅捷護符","=q4=灰舌洞察護符","=q4=灰舌熱誠護符","=q4=灰舌銳敏護符","=q4=灰舌致命護符","=q4=灰舌幻象護符","=q4=灰舌暗影護符","=q4=灰舌勇氣護符"})
Process("Bloodsail1",8,{"","=q1=血帆襯衣","=q1=血帆束帶","=q1=血帆便褲","=q1=血帆皮靴","","","=q2=血帆上將之帽"})
Process("CExpedition1",29,{"","=q3=圖樣:重型裂蹄長靴","=q2=斥候之箭","=q1=結構圖:綠色煙霧照明彈","=q1=遠征隊信號彈","","","","","","","","","","","","=q3=守衛者鍊衫","=q3=保衛者鬥棍","=q3=探險者的手杖","=q3=圖樣:重型裂蹄外衣","=q3=圖樣:重型裂蹄護腿","=q2=自然結界雕紋","=q1=配方:轉化大地風暴鑽石","=q1=配方:地化藥劑","=q1=設計圖:堅鋼磨刀石","=q1=設計圖:堅鋼平衡石","=q1=設計圖:強效結界符文","=q1=圖樣:裂蹄皮護腿片","=q1=蓄湖之鑰"})
Process("CExpedition2",27,{"","=q4=設計圖:野性看守者頭盔","=q4=設計圖:野性看守者護腿","=q3=觀察者風帽","=q3=狂野之力","=q3=守衛者之箭","=q3=設計圖:夜眼石獵豹","=q2=殘暴雕紋","=q2=配方:原始之水轉化原始空氣","=q2=公式:附魔手套 - 法術打擊","","","","","","","=q4=塞納里奧戰爭角鷹獸","=q4=喚風者寶珠","=q4=艾斯炎的禮物","=q4=大地看守者","=q4=設計圖:野性看守者胸甲","=q4=設計圖:自然守衛","=q3=公式:附魔披風 - 潛行","=q2=配方:智慧精煉藥劑","=q1=配方:極效自然防護藥水","=q1=圖樣:虛空裂蹄護腿片","=q1=塞納里奧遠征外袍"})
Process("Cenarion1",26,{"=q1=設計圖:厚重黑曜石腰帶","=q1=設計圖:鐵藤腰帶","=q1=公式:附魔披風 - 強效火焰抗性","=q1=圖樣:木藤腰帶","=q1=圖樣:沙行者護腕","=q1=圖樣:飛火護腕","=q1=圖樣:森林護肩","=q1=圖樣:塞納里奧草藥包","","=q2=塞納里奧作戰徽章","=q2=塞納里奧後勤徽章","=q2=雷姆洛斯印記","","","","","=q3=地紋披風","=q3=土靈力量手套","=q3=大地憤怒指環","","","","","","=q2=塞納里奧戰術徽章","=q2=塞納留斯印記"})
Process("Cenarion2",19,{"=q1=設計圖:鐵藤手套","=q1=設計圖:輕巧黑曜石腰帶","=q1=公式:附魔披風 - 強效自然抗性","=q1=圖樣:木藤靴子","=q1=圖樣:沙行者護手","=q1=圖樣:飛火護手","=q1=圖樣:森林之冠","","","","","","","","","","=q3=大地能量外衣","=q3=大地力量指環","=q3=大地之優雅"})
Process("Cenarion3",20,{"=q1=設計圖:鐵藤胸甲","=q1=設計圖:鋸齒黑曜石之盾","=q1=圖樣:木藤頭盔","=q1=圖樣:沙行者胸甲","=q1=圖樣:飛火胸甲","=q1=圖樣:蓋亞之擁","=q1=圖樣:塞納留斯的背包","=q1=圖樣:森林外衣","","","","","","","","","=q4=岩石怒火護腕","=q4=深岩護腕","=q4=塞納留斯之力","=q4=大地寧靜寶珠"})
Process("Cenarion4",19,{"=q1=設計圖:黑曜石鎖甲外套","=q1=圖樣:夢幻龍鱗胸甲","","","","","","","","","","","","","","","=q4=塞納留斯之怒","=q4=大地之擊","=q4=塞納留斯之拳"})
Process("Consortium1",27,{"","=q3=圖樣:惡魔皮手套","=q2=公式:附魔披風 - 法術穿透","=q2=設計圖:移形的暗影卓奈石","=q2=設計圖:夜光的火石榴石","","","","","","","","","","","","=q3=虛空裂刺","=q3=伊斯利的禮物","=q3=走私者彈藥包","=q3=圖樣:惡魔皮靴","=q2=設計圖:精緻的血石榴石","=q2=設計圖:光輝的藍月石","=q2=設計圖:厚重的黃金卓奈石","=q1=公式:附魔武器 - 極效打擊","=q1=設計圖:迅捷的天火鑽石","=q1=設計圖:強力的大地風暴鑽石","=q1=圖樣:寶石包"})
Process("Consortium2",21,{"","=q3=風暴之尖外衣","=q3=牧民護腿","=q3=聯合團爆破槍","=q3=設計圖:零符墜飾","=q3=圖樣:惡魔皮護腿","=q1=公式:附魔戒指 - 打擊","=q1=結構圖:元素爆鹽炸藥","=q1=設計圖:振奮的大地風暴鑽石","=q1=設計圖:赤紅之日","=q1=設計圖:胡力歐之心","","","","","","=q4=虛空行者風帽","=q4=哈拉瑪德的便宜貨","=q4=科瑞希的狡猾小刀","=q3=設計圖:不懈的大地風暴鑽石","=q1=聯合團外袍"})
Process("Darkmoon1",21,{"=q4=暗月護符","=q4=暗月寶珠","=q2=一等暗月獎","=q2=二等暗月獎","=q2=三等暗月獎","=q1=暗月收藏箱","=q1=去年的羊肉","=q1=結構圖:蒸汽坦克遙控器","=q1=上個月的羊肉","=q1=暗月之花","","=q1=暗月馬戲團獎品券","","","","=q3=暗月項鍊","=q3=暗月戒指","","=q1=樹蛙盒","=q1=林蛙盒","=q1=加布林的小窩"})
Process("Darkmoon2",26,{"=q4=野獸套卡","=q4=暗月卡:藍龍","","=q4=元素套卡","=q4=暗月卡:漩渦","","=q4=督軍套卡","=q4=暗月卡:英雄","","=q4=傳送門套卡","=q4=暗月卡:虛空","","","","","=q4=狂怒套卡","=q4=暗月卡:復仇","","=q4=風暴套卡","=q4=暗月卡:狂怒","","=q4=祝福套卡","=q4=暗月卡:聖戰","","=q4=失心套卡","=q4=暗月卡:瘋狂"})
Process("Defilers",2,{"","=q1=污染者軍服"})
Process("Frostwolf1",19,{"=q4=6級霜狼徽記","=q3=5級霜狼徽記","=q3=4級霜狼徽記","=q2=3級霜狼徽記","=q2=2級霜狼徽記","=q2=1級霜狼徽記","","","","","","","","","","=q3=冰冷鑄錘","=q3=冰刺長矛","=q3=骨寒魔杖","=q3=覓血者"})
Process("GelkisClan1",3,{"","=q2=吉爾吉斯掠奪者鍊甲","=q2=烏泰克的手指"})
Process("HonorHold1",25,{"","=q3=圖樣:惡魔捕獵者腰帶","=q2=設計圖:耐久的翠綠橄欖石","=q1=公式:附魔護腕 - 超強治療","=q1=步卒水袋","=q1=乾蘑菇","","","","","","","","","","","=q3=賢者指環","=q3=步卒長劍","=q3=圖樣:惡魔捕獵者護腕","=q3=圖樣:惡魔捕獵者胸甲","=q2=火焰結界雕紋","=q1=配方:轉化天火鑽石","=q1=配方:極效敏捷藥劑","=q1=圖樣:眼鏡蛇皮護腿片","=q1=火鑄之鑰"})
Process("HonorHold2",23,{"","=q3=恢復之戒","=q3=地獄鍛造之戟","=q3=魔化毀滅彈藥","=q3=設計圖:黎明石蟹","=q2=恢復雕紋","=q1=公式:附魔胸甲 - 特殊屬性","=q1=圖樣:虛空鱗彈藥袋","","","","","","","","","=q4=大法師之刃","=q4=榮譽召喚","=q4=精兵火槍","=q3=公式:附魔披風 - 狡詐","=q1=設計圖:魔鋼盾刺","=q1=圖樣:虛空眼鏡蛇護腿片","=q1=榮譽堡外袍"})
Process("KeepersofTime1",30,{"","=q2=冰霜結界雕紋","=q2=公式:附魔手套 - 極效法術能量","=q1=公式:附魔戒指 - 法術能量","=q1=設計圖:謎般的天火鑽石","=q1=設計圖:永恆切面","=q1=圖樣:驚慌之鼓","=q1=時光之鑰","","","","","","","","","=q3=時光守護者護腿","=q3=連續之刃","=q3=設計圖:生命紅寶石巨蛇","=q3=設計圖:霜炎墜飾","=q2=防衛者雕紋","=q1=設計圖:眾刃之石","","","=q4=時間行者束腕","=q4=時光流逝裂片","=q4=裂縫分裂者","=q3=公式:附魔手套 - 超強敏捷","=q2=配方:超級能量精煉藥劑","=q1=時光守望者外袍"})
Process("Kurenai1",30,{"","=q3=圖樣:虛空之怒腰帶","","","=q3=座狼皮箭袋","=q3=圖樣:虛空之怒護腿","=q1=圖樣:恢復之鼓","=q1=圖樣:速度之鼓","=q1=圖樣:強化礦石包","","","=q3=黑染皮肩甲","=q3=卡爾奈褶裙","=q3=元素之靈指環","=q3=圖樣:虛空之怒長靴","=q2=配方:原始之火轉化原始大地","","","=q4=深藍色塔巴克戰騎韁繩","=q4=銀色塔巴克戰騎韁繩","=q4=古銅色塔巴克戰騎韁繩","=q4=白色塔巴克戰騎韁繩","=q4=深藍色塔巴克坐騎韁繩","=q4=銀色塔巴克坐騎韁繩","=q4=古銅色塔巴克坐騎韁繩","=q4=白色塔巴克坐騎韁繩","=q3=古靈披風","=q3=先知頭盔","=q3=阿爾克隆的禮物","=q1=卡爾奈外袍"})
Process("LeagueofArathor",2,{"","=q1=阿拉索軍服"})
Process("LowerCity1",28,{"","=q2=設計圖:高效的火石榴石","","","=q3=司凱堤斯流亡護腿","=q3=援助者鍊衫","=q3=陰鬱城祈禱者之書","=q3=設計圖:魔鋼野豬","=q3=設計圖:融解墜飾","=q2=放逐雕紋","=q2=配方:極效暗影之力藥劑","=q1=設計圖:殞落之星","=q1=圖樣:千羽箭袋","","","","=q2=暗影結界雕紋","=q1=公式:附魔戒指 - 屬性","=q1=圖樣:秘法迴避披風","=q1=奧奇奈鑰匙","","","=q4=移形者徽記","=q4=顯密裁決槌","=q4=流亡部族之戟","=q3=公式:附魔披風 - 閃躲","=q2=配方:多重抗性精煉藥劑","=q1=陰鬱城外袍"})
Process("Maghar1",30,{"","=q3=圖樣:虛空之怒腰帶","","","=q3=裂蹄皮箭袋","=q3=圖樣:虛空之怒護腿","=q1=圖樣:恢復之鼓","=q1=圖樣:速度之鼓","=q1=圖樣:強化礦石包","","","=q3=塔巴克皮肩甲","=q3=暴風護腿","=q3=先祖靈魂指環","=q3=圖樣:虛空之怒長靴","=q2=配方:原始之火轉化原始大地","","","=q4=深藍色塔巴克戰騎韁繩","=q4=銀色塔巴克戰騎韁繩","=q4=古銅色塔巴克戰騎韁繩","=q4=白色塔巴克戰騎韁繩","=q4=深藍色塔巴克坐騎韁繩","=q4=銀色塔巴克坐騎韁繩","=q4=古銅色塔巴克坐騎韁繩","=q4=白色塔巴克坐騎韁繩","=q3=儀式罩篷","=q3=大地召喚者頭飾","=q3=地獄吼意志","=q1=瑪格哈外袍"})
Process("MagramClan1",3,{"","=q2=半人馬儀式披毯","=q2=瑪格拉姆獵人腰帶"})
Process("Netherwing1",22,{"","=q2=監督者的徽章","","","=q3=隊長的徽章","=q3=破天者皮鞭","","","=q3=指揮官徽章","","","","","","","","=q4=藍色虛空之翼龍韁繩","=q4=深藍色虛空之翼龍韁繩","=q4=粉色虛空之翼龍韁繩","=q4=紫色虛空之翼龍韁繩","=q4=翠綠色虛空之翼龍韁繩","=q4=紫紅色虛空之翼龍韁繩"})
Process("Ogrila1",29,{"","=q1=紅色巨魔特殊啤酒","=q1=藍色巨魔特殊啤酒","","","=q1=紅色巨魔啤酒","=q1=藍色巨魔啤酒","","","","","","","=q3=頂尖水晶","","","=q3=頂尖披風","=q3=晶鑄墜飾","=q3=歐格利拉聖禦盾","=q3=天藍水晶魔杖","","","=q4=鑲殼護腕","=q4=漩渦行走長靴","=q4=啟示水晶寶珠","=q4=結晶十字弩","=q1=歐格利拉外袍","","=q1=頂尖裂片"})
Process("ScaleSands1",24,{"=q4=永恆指環","=q4=永恆指環","=q4=永恆指環","=q4=永恆勇士指環","","=q4=永恆指環","=q4=永恆指環","=q4=永恆指環","=q4=永恆防衛者指環","","","","","","","=q4=永恆指環","=q4=永恆指環","=q4=永恆指環","=q4=永恆聖人指環","","=q4=永恆指環","=q4=永恆指環","=q4=永恆指環","=q4=永恆修復者指環"})
Process("ScaleSands2",29,{"","=q4=設計圖:清晰的赤紅尖晶石","=q4=設計圖:明亮的赤紅尖晶石","=q4=設計圖:精緻的赤紅尖晶石","=q4=設計圖:符文的赤紅尖晶石","=q4=設計圖:精巧的赤紅尖晶石","=q4=設計圖:淚滴的赤紅尖晶石","=q4=設計圖:光輝的蒼穹藍寶石","=q4=設計圖:堅固的蒼穹藍寶石","=q4=設計圖:閃亮的蒼穹藍寶石","=q4=設計圖:明亮的獅眼石","=q4=設計圖:微光的獅眼石","=q4=設計圖:光滑的獅眼石","=q4=設計圖:厚重的獅眼石","","","=q4=設計圖:迅速的獅眼石","=q4=設計圖:閃爍的焚石","=q4=設計圖:夜光的焚石","=q4=設計圖:高效焚石","=q4=設計圖:魯莽焚石","=q4=設計圖:平衡的影歌紫水晶","=q4=設計圖:發光的影歌紫水晶","=q4=設計圖:灌能的影歌紫水晶","=q4=設計圖:燦爛的海泉綠寶石","=q4=設計圖:堅強的海泉綠寶石","=q4=設計圖:鋸齒的海泉綠寶石","=q4=設計圖:輻光的海泉綠寶石","=q4=設計圖:穩固的海泉綠寶石"})
Process("ScaleSands3",9,{"","=q4=永恆之箭","=q4=永恆子彈","","","=q4=設計圖:堅硬的獅眼石","=q4=設計圖:邪惡的焚石","=q4=設計圖:耐久的海泉綠寶石","=q4=設計圖:皇家的影歌紫水晶"})
Process("Scryer1",25,{"","=q2=設計圖:符文的血石榴石","=q1=設計圖:附魔堅鋼腰帶","","","","","","","","","","","","","","=q2=劍刃銘文","=q2=騎士銘文","=q2=神諭銘文","=q2=寶珠銘文","=q2=設計圖:燦爛的翠綠橄欖石","=q1=設計圖:附魔堅鋼長靴","=q1=圖樣:附魔裂蹄長靴","=q1=圖樣:附魔魔鱗手套","=q1=圖樣:神秘法術絲線"})
Process("Scryer2",27,{"","=q3=保持者護腿","=q3=命定護手","=q3=占卜者血寶石","=q3=先知法杖","=q3=設計圖:枯萎墜飾","=q2=配方:極效火焰之力藥劑","=q1=設計圖:附魔堅鋼胸甲","=q1=圖樣:附魔裂蹄手套","=q1=圖樣:附魔魔鱗長靴","=q1=圖樣:博學者護甲片","","","","","","=q4=先知徽章","=q4=保持者之刃","=q3=強效劍刃銘文","=q3=強效騎士銘文","=q3=強效神諭銘文","=q3=強效寶珠銘文","=q1=設計圖:附魔堅鋼護腿","=q1=圖樣:附魔裂蹄護腿","=q1=圖樣:附魔魔鱗護腿","=q1=圖樣:符文法術絲線","=q1=占卜者外袍"})
Process("Shatar1",30,{"","=q1=設計圖:洞察的大地風暴鑽石","","","=q3=祝福之鱗束腰","=q3=希瑞的禮物","=q3=設計圖:泰拉寶石貓頭鷹","=q2=能量雕紋","=q2=配方:原始空氣轉化原始之火","=q2=公式:附魔武器 - 極效治療","=q1=配方:鍊金石","=q1=公式:附魔戒指 - 治療能量","=q1=設計圖:琥珀之血","","","","=q3=設計圖:秘法護盾戒指","=q2=秘法結界雕紋","=q2=公式:附魔手套 - 極效治療","=q1=設計圖:凱麗之薔","=q1=圖樣:戰鬥之鼓","=q1=扭曲鍛造鑰匙","","","=q4=阿達歐的命令","=q4=淨光裁決槌","=q4=薩塔紋章盾","=q3=公式:附魔手套 - 威脅","=q2=配方:泰坦精煉藥劑","=q1=薩塔外袍"})
Process("ShattrathFlasks1",4,{"=q1=撒塔斯防禦壁壘精煉藥劑","=q1=撒塔斯強力恢復精煉藥劑","=q1=撒塔斯無情攻擊精煉藥劑","=q1=撒塔斯極效法傷精煉藥劑"})
Process("Skyguard1",25,{"","=q1=濃縮泰魯草汁","","","=q1=禦天者口糧","","","=q3=禦天者披氅","=q3=飛天女巫披氅","","","","","","","","=q4=禦天者銀十字徽章","=q4=空軍英豪綬帶","=q4=藍色虛空鰭刺坐騎","=q4=綠色虛空鰭刺坐騎","=q4=紅色虛空鰭刺坐騎","=q4=紫色虛空鰭刺坐騎","=q4=銀色虛空鰭刺坐騎","","=q1=禦天者外袍"}) --Missing: 38628
Process("Sporeggar1",25,{"","=q1=食譜:小孢子點心","=q1=食譜:蛤蜊條","=q1=長梗蘑菇","=q1=沼澤地衣","","","=q3=覆泥披氅","=q3=石化地衣防禦者","=q1=紅帽傘菌","","=q1=白閃菇","","","","","=q3=硬化石裂片","=q3=孢子火焰魔杖","=q2=配方:原始大地轉化原始之水","","","","=q3=小型孢子蝙蝠","=q2=配方:漸隱藥水","=q1=斯博格爾外袍"}) --Missing: 38229
Process("Stormpike1",19,{"=q4=6級雷矛徽記","=q3=5級雷矛徽記","=q3=4級雷矛徽記","=q2=3級雷矛徽記","=q2=2級雷矛徽記","=q2=1級雷矛徽記","","","","","","","","","","=q3=冰冷鑄錘","=q3=冰刺長矛","=q3=骨寒魔杖","=q3=覓血者"})
Process("SunOffensive1",27,{"","=q1=設計圖:清晰的赤紅尖晶石","=q1=設計圖:輻光的海泉綠寶石","=q1=設計圖:明亮的獅眼石","=q1=設計圖:精緻的赤紅尖晶石","=q1=設計圖:微光的獅眼石","=q1=設計圖:光輝的蒼穹藍寶石","=q1=設計圖:符文的赤紅尖晶石","=q1=設計圖:光滑的獅眼石","=q1=設計圖:堅固的蒼穹藍寶石","=q1=設計圖:閃亮的蒼穹藍寶石","=q1=設計圖:精巧的赤紅尖晶石","=q1=設計圖:淚滴的赤紅尖晶石","=q1=設計圖:厚重的獅眼石","=q1=那魯口糧","","=q1=設計圖:平衡的影歌紫水晶","=q1=設計圖:燦爛的海泉綠寶石","=q1=設計圖:閃爍的焚石","=q1=設計圖:發光的影歌紫水晶","=q1=設計圖:灌能的影歌紫水晶","=q1=設計圖:鋸齒的海泉綠寶石","=q1=設計圖:夜光的焚石","=q1=設計圖:高效焚石","=q1=設計圖:輻光的海泉綠寶石","=q1=公式:附魔胸甲 - 防禦","=q1=公式:虛無碎裂"})
Process("SunOffensive2",26,{"=q4=設計圖:堅強的海泉綠寶石","=q4=設計圖:迅速的獅眼石","=q4=設計圖:魯莽焚石","=q4=設計圖:穩固的海泉綠寶石","=q1=設計圖:耐久的海泉綠寶石","=q1=設計圖:堅硬的獅眼石","=q1=設計圖:皇家的影歌紫水晶","=q1=設計圖:邪惡的焚石","=q3=投彈手之刃","=q3=大法師的狡詐","=q3=因努羅之刃","=q3=破日者","=q3=基魯的預言","=q3=追尋者裁決槌","=q3=軍團之敵","=q3=強擊之弩","=q2=鬥士雕紋","","=q1=設計圖:華貴的夜眼石","=q1=設計圖:餘燼的天火鑽石","=q1=設計圖:永恆的大地風暴鑽石","=q1=設計圖:刻像 - 赤紅巨蛇","=q1=設計圖:刻像 - 蒼穹巨龜","=q1=設計圖:刻像 - 克銀野豬","=q1=設計圖:刻像 - 海泉信天翁","=q1=設計圖:刻像 - 影歌獵豹"})
Process("SunOffensive3",23,{"=q3=設計圖:迅速的黎明石","=q3=設計圖:魯莽的皇家黃寶石","=q3=設計圖:堅強的泰拉寶石","=q4=破碎之日銳敏墜飾","=q4=破碎之日力量墜飾","=q4=破碎之日決心墜飾","=q4=破碎之日恢復墜飾","=q4=曦鑄防衛者","=q4=日衛紋章盾","=q1=設計圖:閃光的赤紅尖晶石","=q1=設計圖:絕佳的獅眼石","=q1=設計圖:雕刻的焚石","=q1=設計圖:神秘的獅眼石","","=q1=設計圖:移形的影歌紫水晶","=q1=設計圖:尊貴的影歌紫水晶","=q1=設計圖:激烈的蒼穹藍寶石","=q1=設計圖:矇矓的焚石","=q1=配方:刺客鍊金石","=q1=配方:守護者鍊金石","=q1=配方:救贖者鍊金石","=q1=配方:巫士鍊金石","=q1=破碎之日外袍"}) --Missing: 37504
Process("Thorium1",25,{"","=q3=設計圖:黑鐵護腕","=q1=配方:轉化元素火焰","=q1=公式:附魔武器 - 力量","=q1=圖樣:熔鑄頭盔","=q1=圖樣:熔核犬皮靴","=q1=圖樣:光核手套","","","","","","","","","","=q3=設計圖:黑鐵戰斧","=q3=設計圖:黑鐵掠刃","=q3=設計圖:熾熱鍊甲束腰","=q1=設計圖:黑鐵頭盔","=q1=公式:附魔武器 - 強力精神","=q1=圖樣:黑色龍鱗長靴","=q1=圖樣:熔岩腰帶","=q1=圖樣:光核披肩","=q1=圖樣:光核長袍"})
Process("Thorium2",20,{"","=q4=設計圖:薩弗隆戰錘","=q3=設計圖:黑鐵護腿","=q3=設計圖:熾熱鍊甲護肩","=q1=設計圖:黑色怒火","=q1=設計圖:黑色赦免者","=q1=設計圖:黑鐵護手","=q1=公式:附魔武器 - 強力智力","=q1=圖樣:炫彩護手","=q1=圖樣:熔核犬皮腰帶","=q1=圖樣:熔火腰帶","=q1=圖樣:光核護腿","","","","","=q1=設計圖:黑色衛士","=q1=設計圖:黑鐵長靴","=q1=設計圖:黑檀之手","=q1=設計圖:夜幕"})
Process("Thrallmar1",25,{"","=q3=圖樣:惡魔捕獵者腰帶","=q2=設計圖:耐久的翠綠橄欖石","=q1=公式:附魔護腕 - 超強治療","=q1=蠻兵的水袋","=q1=乾果糧","","","","","","","","","","","=q3=先知指環","=q3=蠻兵的戰斧","=q3=圖樣:惡魔捕獵者護腕","=q3=圖樣:惡魔捕獵者胸甲","=q2=火焰結界雕紋","=q1=配方:轉化天火鑽石","=q1=配方:極效敏捷藥劑","=q1=圖樣:眼鏡蛇皮護腿片","=q1=火鑄之鑰"})
Process("Thrallmar2",23,{"","=q3=先祖指環","=q3=變黑的長矛","=q3=地獄火射擊彈藥","=q3=設計圖:黎明石蟹","=q2=恢復雕紋","=q1=公式:附魔胸甲 - 特殊屬性","=q1=圖樣:虛空鱗彈藥袋","","","","","","","","","=q4=風暴召喚者","=q4=戰爭使者","=q4=神射手的弓","=q3=公式:附魔披風 - 狡詐","=q1=設計圖:魔鋼盾刺","=q1=圖樣:虛空眼鏡蛇護腿片","=q1=索爾瑪外袍"})
Process("Timbermaw",23,{"","=q2=配方:轉土成水","=q1=公式:附魔雙手武器 - 敏捷","=q1=圖樣:戰熊毛褲","=q1=圖樣:戰熊背心","","","=q2=熊怪醫療包","=q2=熊怪醫療圖騰","=q1=設計圖:重型木喉腰帶","=q1=公式:附魔武器 - 敏捷","=q1=圖樣:木喉之力","=q1=圖樣:木喉之智","","","","=q1=設計圖:重型木喉長靴","=q1=圖樣:木喉作戰手套","=q1=圖樣:木喉披肩","","","","=q4=木喉防衛者"})
Process("Tranquillien1",23,{"","=q2=學徒長靴","=q2=泥沼探險者長靴","=q2=自願者護脛","=q2=安寧地焰刃劍","","","=q2=藥劑師腰環","=q2=蝙蝠皮腰帶","=q2=安寧地防衛者束腰","","","","","","","=q2=藥劑師長袍","=q2=亡靈哨兵外衣","=q2=炎冠鍊衫","","","","=q3=安寧地勇士披風"})
Process("VioletEye1",26,{"","=q3=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=刺客大師之紫羅蘭徽記","","","=q3=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=大法師之紫羅蘭徽記","","","","","","=q3=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=大治癒者之紫羅蘭徽記","","","=q3=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=紫羅蘭徽記","=q4=偉大保衛者之紫羅蘭徽記"})
Process("VioletEye2",18,{"","=q4=紫羅蘭徽章","=q4=設計圖:冰霜守衛頭盔","=q4=設計圖:冰霜守衛胸甲","=q4=設計圖:冰凍之眼","=q2=耐力銘文","=q2=配方:炫彩驚奇精煉藥劑","","","=q4=神秘之箭","=q4=神秘彈藥","=q4=設計圖:冰霜守衛護腿","=q4=圖樣:暗影徘徊者護胸","","","","=q3=圖樣:黑暗披風","=q1=公式:附魔武器 - 強效敏捷"})
Process("WaterLords1",7,{"","=q3=海洋之風","=q3=潮汐戒環","=q1=水之精萃","","","=q1=永恆精華"})
Process("Wintersaber1",2,{"","=q4=冬泉霜刃豹韁繩"})
Process("Zandalar1",25,{"","=q1=配方:強效昏睡藥水","=q1=設計圖:血魂護手","=q1=設計圖:黑暗之魂護肩","=q1=公式:卓越法力之油","=q1=結構圖:血藤鏡片","=q1=圖樣:原始蝙蝠皮護腕","=q1=圖樣:血藤長靴","","","","=q2=贊達拉榮譽勳章","","","","","=q1=配方:極效食人妖之血藥水","=q1=設計圖:血魂護肩","=q1=設計圖:黑暗之魂護腿","=q1=公式:卓越巫師之油","=q1=結構圖:血藤護目鏡","=q1=圖樣:血虎護肩","=q1=圖樣:原始蝙蝠皮手套","=q1=圖樣:血藤護腿","=q1=美味芒果"})
Process("Zandalar2",20,{"","=q2=贊札之光","=q2=贊札之靈","=q2=贊札之速","=q1=配方:魔血藥水","=q1=設計圖:血魂胸甲","=q1=設計圖:黑暗之魂胸甲","=q1=圖樣:血虎胸甲","=q1=圖樣:原始蝙蝠皮上衣","=q1=圖樣:血藤外衣","","","","","","","=q3=贊達拉力量徽記","=q3=贊達拉魔精徽記","=q3=贊達拉寧靜徽記","=q1=配方:活力行動藥水"})
end
