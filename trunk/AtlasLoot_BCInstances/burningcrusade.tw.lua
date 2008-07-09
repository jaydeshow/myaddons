-- AtlasLoot loot tables zhTW locale file
-- NOTE: THIS FILE IS AUTO-GENERATED BY A TOOL, ANY MANUALLY CHANGE MIGHT BE OVERWRITTEN.
-- $Id$

if GetLocale() == "zhTW" then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootExpansionItems"][category] or #AtlasLoot_Data["AtlasLootExpansionItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootExpansionItems"][category][i][3] = data[i] end end data = nil end
Process("AuchCryptsAvatar",7,{"=q3=奧奇奈死亡罩氅","=q3=自然修補裹手","=q3=亡靈主教的意志","=q3=破天者","=q3=德萊尼野杖","","=q3=荒行肩墊"})
Process("AuchCryptsExarch",8,{"=q3=沉著軟靴","=q3=黑暗守護面罩","=q3=摩克納薩爾野獸面罩","=q3=主教之戒","=q3=墮落者神像","=q3=新生鐵法杖","","=q2=綠色冬帽"})
Process("AuchCryptsExarchHEROIC",20,{"=q4=正義徽章","=q4=聖光之觸捨己披肩","=q4=秘法幻象束帶","=q4=音浪束腰","","=q3=不義之靴","=q3=瑪拉達爾的祝福念珠","=q3=剛毅靈魂牧者指環","=q3=主教的鑽石指環","=q3=靈魂收穫者","","=q2=綠色冬帽","","=q1=主教的靈魂寶石","","=q4=勇士火焰蛋白石","=q4=高效火焰蛋白石","=q4=先知綠玉髓","","=q3=末日戰甲腿甲"})
Process("AuchCryptsShirrak",5,{"=q3=統率頭帶","=q3=烏鴉之心頭飾","=q3=希望持有者頭盔","=q3=隱密注視之眼","=q3=次等夏阿爾德之劍"})
Process("AuchCryptsShirrakHEROIC",11,{"=q4=正義徽章","=q4=勇士火焰蛋白石","=q4=高效火焰蛋白石","=q4=先知綠玉髓","","=q3=洞察之火花頭飾","=q3=死亡注視者手套","=q3=辛瑞克護腕","=q3=熔岩羽飾靴","=q3=扇刃肩鎧","=q3=看守者之爪"})
Process("AuchCryptsTrash",3,{"=q3=設計圖:魔鋼手套","","=q2=公式:附魔靴子 - 靈巧"})
Process("AuchManaNexusPrince",10,{"=q3=伊斯利天行者之靴","=q3=迷霧之魂","=q3=活力之奈薩斯護腕","=q3=薩法爾符印","=q3=長途行者戒環","=q3=伊斯利曲弓","","=q2=配方:極效冰霜防護藥水","","=q1=薩法爾裹腕"})
Process("AuchManaNexusPrinceHEROIC",28,{"=q4=正義徽章","=q4=對立手環","=q4=森林漫步者褶裙","=q4=泰洛戈莎鈷藍指環","=q4=惡魔屏障","","=q3=不赦披肩","=q3=雕紋繩束帶","=q3=清晰夢境護腕","=q3=止水束腰","=q3=迅捷獎懲肩鎧","=q3=辯白護手","","=q1=薩法爾的奇妙護符","=q1=薩法爾裹腕","=q4=刻劃火焰蛋白石","=q4=閃亮的火焰蛋白石","=q4=永恆綠玉髓","","=q3=荒行護腿","","=q3=扭曲甲蟲胸針","=q3=扭曲風暴戰刃","=q3=奈薩斯王之斧","=q3=薩塔權杖","=q3=奈薩斯王的大權杖","","=q2=配方:極效冰霜防護藥水"})
Process("AuchManaPandemonius",6,{"=q3=外域者之靴","=q3=信念懷抱者護手","=q3=爪形塑像","=q3=戰慄武器","=q3=虛無之盾","=q3=虛無之火焰魔杖"})
Process("AuchManaPandemoniusHEROIC",11,{"=q4=正義徽章","=q4=刻劃火焰蛋白石","=q4=閃亮的火焰蛋白石","=q4=永恆綠玉髓","","=q3=心靈之怒肩鎧","=q3=新月星袍","=q3=巨像之靴","=q3=星風圖騰","=q3=精準雙刃","=q3=星光長弓"})
Process("AuchManaTavarok",6,{"=q3=復甦披風","=q3=虛空暗影之靴","=q3=電光權杖肩鎧","=q3=奈薩斯捕獵者短彎刀","=q3=優良夏阿爾德之劍","=q3=極性法杖"})
Process("AuchManaTavarokHEROIC",11,{"=q4=正義徽章","=q4=刻劃火焰蛋白石","=q4=閃亮的火焰蛋白石","=q4=永恆綠玉髓","","=q3=渾沌黑暗長袍","=q3=奢華的怨恨之靴","=q3=掠奪手套","=q3=海狼披肩","=q3=裂殼胸甲","=q3=水晶勇氣指環"})
Process("AuchManaTrash",3,{"=q3=設計圖:迅鋼手套","","=q2=公式:附魔靴子 - 堅韌"})
Process("AuchManaYor",18,{"=q4=正義徽章","=q4=奈薩斯王子的平衡之戒","=q4=薩法爾的蠻橫指環","=q4=猶爾的崩塌指環","=q4=衝突倖存之戒","=q4=結晶虛無指環","=q4=猶爾的復仇之戒","","=q3=導風者外套","=q3=天行者外套","=q3=霧幕外套","=q3=岩鋼胸甲","","","","=q4=刻劃火焰蛋白石","=q4=閃亮的火焰蛋白石","=q4=永恆綠玉髓"})
Process("AuchSethekkDarkweaver",10,{"=q3=輕織軟靴","=q3=月行者之靴","=q3=天獵迅捷之靴","=q3=希斯手環","=q3=永恆安息聖契","=q3=塞司克羽毛飛鏢","","=q3=設計圖:克銀地獄火指環","","=q1=泰洛克面罩"})
Process("AuchSethekkDarkweaverHEROIC",19,{"=q4=正義徽章","=q4=原始火焰蛋白石","=q4=堅實火焰蛋白石","=q4=受祝福的丹泉石","","=q3=輕織軟靴","=q3=月行者之靴","=q3=天獵迅捷之靴","=q3=希斯手環","=q3=永恆安息聖契","=q3=塞司克羽毛飛鏢","","","","","=q3=設計圖:克銀地獄火指環","","=q1=泰洛克面罩","=q1=遺忘之名魔典"})
Process("AuchSethekkRavenGod",11,{"=q4=正義徽章","=q4=烏鴉領主韁繩","=q4=原始火焰蛋白石","=q4=堅實火焰蛋白石","=q4=受祝福的丹泉石","","=q3=烏鴉領主腰帶","=q3=公正剛毅之靴","=q3=嚴寒元素指環","=q3=安祖之爪","=q3=火槍"})
Process("AuchSethekkTalonKing",20,{"=q3=鳥人羽毛披風","=q3=塞司克神諭者披風","=q3=亡鑄束腰","=q3=鴉爪指環","=q3=泰洛克黑夜之錘","=q3=烏鴉之翼收割斧","","=q1=泰洛克羽毛","","","=q1=暗影迷宮鑰匙","","","","","=q3=失落長褲","=q3=魔法使的長褲","=q3=神聖儀祭長褲","=q3=暗殺肩墊","=q3=哀傷之鏈護脛"})
Process("AuchSethekkTalonKingHEROIC",27,{"=q4=正義徽章","=q4=善行手環","=q4=巡狩護腕","=q4=戰狂肩甲","=q4=泰洛克暗影法杖","","=q3=鳥人羽毛披風","=q3=塞司克神諭者披風","=q3=亡鑄束腰","=q3=鴉爪指環","=q3=泰洛克黑夜之錘","=q3=烏鴉之翼收割斧","","","=q1=暗影迷宮鑰匙","=q4=原始火焰蛋白石","=q4=堅實火焰蛋白石","=q4=受祝福的丹泉石","","=q3=失落長褲","=q3=魔法使的長褲","=q3=神聖儀祭長褲","=q3=暗殺肩墊","=q3=哀傷之鏈護脛","","=q1=泰洛克羽毛","=q1=伊奇斯的冠羽"})
Process("AuchSethekkTheSagaofTerokk",1,{"=q1=泰洛克的傳說"})
Process("AuchSethekkTrash",3,{"=q3=圖樣:造型紅色帽","","=q2=圖樣:暗影護甲片"})
Process("AuchShadowBlackheart",16,{"=q3=煽動者披風","=q3=尊敬之華麗護腿","=q3=提升高效胸針","=q3=極堅刻像","=q3=虛空之翼魔杖","","=q3=圖樣:造型紫色帽","","=q1=惡魔之名寶典","","","","","","","=q3=月光林地裹手"})
Process("AuchShadowBlackheartHEROIC",16,{"=q4=正義徽章","=q4=華貴的丹泉石","=q4=蝕刻火焰蛋白石","=q4=符文表面的綠玉髓","","=q3=煽動者披風","=q3=尊敬之華麗護腿","=q3=提升高效胸針","=q3=極堅刻像","=q3=虛空之翼魔杖","","=q3=圖樣:造型紫色帽","","=q1=惡魔之名寶典","","=q3=月光林地裹手"})
Process("AuchShadowFirstFragmentGuardian",1,{"=q1=第一塊鑰匙碎片"})
Process("AuchShadowGrandmaster",16,{"=q3=恩典滿溢胸甲","=q3=有吸引力的神秘珠寶","=q3=黑暗權杖","=q3=怒火手持火砲","","=q2=綠色冬帽","","=q1=惡魔詞典","","","","","","","","=q3=神聖儀祭肩鎧"})
Process("AuchShadowGrandmasterHEROIC",16,{"=q4=正義徽章","=q4=華貴的丹泉石","=q4=蝕刻火焰蛋白石","=q4=符文表面的綠玉髓","","=q3=恩典滿溢胸甲","=q3=有吸引力的神秘珠寶","=q3=黑暗權杖","=q3=怒火手持火砲","","=q2=綠色冬帽","","=q1=惡魔詞典","","","=q3=神聖儀祭肩鎧"})
Process("AuchShadowHellmaw",6,{"=q3=碧火殲滅手套","=q3=夢翼頭盔","=q3=神化華麗之靴","=q3=祖母綠皇后塑像","=q3=悍勇白金盾牌","=q3=奧多爾靈魂魔杖"})
Process("AuchShadowHellmawHEROIC",11,{"=q4=正義徽章","=q4=華貴的丹泉石","=q4=蝕刻火焰蛋白石","=q4=符文表面的綠玉髓","","=q3=碧火殲滅手套","=q3=夢翼頭盔","=q3=神化華麗之靴","=q3=祖母綠皇后塑像","=q3=悍勇白金盾牌","=q3=奧多爾靈魂魔杖"})
Process("AuchShadowMurmur",21,{"=q4=圖樣:法擊便褲","","=q3=冥想沉默軟靴","=q3=深流背心","=q3=耳語屠殺之刃","=q3=恐怖夢境之劍","=q3=音速之矛","=q3=銀月羽飾盾牌","","","","","","","","=q3=失落肩甲","=q3=失落長袍","=q3=神聖儀祭服飾","=q3=暗殺護腿","=q3=惡潮褶裙","=q3=勇猛肩衛"})
Process("AuchShadowMurmurHEROIC",28,{"=q4=正義徽章","=q4=肯瑞托大師長褲","=q4=大師級竊盜手套","=q4=兇猛束腰","=q4=震浪之錘","","=q3=冥想沉默軟靴","=q3=深流背心","=q3=耳語屠殺之刃","=q3=恐怖夢境之劍","=q3=音速之矛","=q3=銀月羽飾盾牌","","=q1=莫爾墨的精華","","=q4=華貴的丹泉石","=q4=蝕刻火焰蛋白石","=q4=符文表面的綠玉髓","=q4=圖樣:法擊便褲","","=q3=失落肩甲","=q3=失落長袍","=q3=神聖儀祭服飾","=q3=暗殺護腿","=q3=惡潮褶裙","=q3=勇猛肩衛","","=q1=莫爾墨的低語"})
Process("AuchShadowTrash",1,{"=q3=設計圖:魔鋼頭盔"})
Process("BCKeys",24,{"","=q1=暗影迷宮鑰匙","=q1=破碎大廳鑰匙","=q1=亞克崔茲鑰匙","","","=q1=火鑄之鑰","=q1=火鑄之鑰","=q1=蓄湖之鑰","=q1=奧奇奈鑰匙","=q1=時光之鑰","=q1=扭曲鍛造鑰匙","","","","","=q4=卡拉伯爾勳章","=q1=風暴之鑰","=q1=大師之鑰","","","=q3=哈拉瑪德之眼","=q1=燻黑的骨灰甕","=q1=精華灌注的月亮石"})
Process("BTAkama",17,{"=q4=輝煌光明襯肩","=q4=法力集中束腕","=q4=神聖權力腕環","=q4=暗影行者之索","=q4=永恆自然褶裙","=q4=隱藏捕獵者護肩","=q4=靈魂行者護手","=q4=爍火束腰","=q4=搜捕者腕甲","=q4=寂靜正義手套","=q4=禁衛腿甲","=q4=侍從足靴","","","","=q4=欺詐意圖指環","=q4=盲目先知塑像"})
Process("BTBloodboil",20,{"=q4=饒恕罩氅","=q4=血咒肩墊","=q4=節制外衣","=q4=原始權威腰帶","=q4=座乘襲擊上衣","=q4=堅定決心束腰","=q4=穩固束腰","=q4=神聖懲戒護腿","","","","","","","","=q4=強勁侵略者指環","=q4=影月徽記","=q4=命運使者匕首","=q4=純淨復甦法杖","=q4=稜彩專注魔杖"})
Process("BTCouncil",18,{"=q4=伊利達瑞議會披風","=q4=神聖引導腰帶","=q4=曲葉肩甲","=q4=森林徘徊者頭盔","=q4=伊利達瑞粉碎者頭盔","=q4=背叛者的狂熱","","","","","","","","","","=q4=遺忘征服者護腿","=q4=遺忘保衛者護腿","=q4=遺忘防禦者護腿"})
Process("BTEssencofSouls",20,{"=q4=無窮信心手套","=q4=月神加持護腕","=q4=非難手套","=q4=自然守護足靴","=q4=波浪治癒者披肩","=q4=骨織束腰","=q4=強能命運之冠","=q4=軍團恐懼之靴","","","","","","","","=q4=清澈法術絲線頸鍊","=q4=泰坦項鍊","=q4=靈光之觸","=q4=詛咒之錘","=q4=那魯祝福生命魔杖"})
Process("BTGorefiend",19,{"=q4=影月毀滅者披氅","=q4=恩慈風帽","=q4=暗影議會長袍","=q4=隱伏手環","=q4=植物學家的生長手套","=q4=追蹤輕步之靴","=q4=強制護手","=q4=羅德隆陷落束腰","","","","","","","","=q4=先祖引導圖騰","=q4=靈魂斬斧","=q4=沙拉克雙絞飛刃","=q4=歸隱監護者步槍"})
Process("BTIllidanStormrage",24,{"=q4=精靈貴族罩氅","=q4=伊利達瑞高階領主風帽","=q4=薩格拉斯的詛咒幻象","=q4=不破面甲","=q4=怒風璽戒","=q4=古爾丹之顱","=q4=泰蘭妲的紀念","","=q5=埃辛諾斯戰刃","=q5=埃辛諾斯戰刃","","","","","","=q4=遺忘征服者護胸","=q4=遺忘保衛者護胸","=q4=遺忘防禦者護胸","","=q4=埃辛諾斯裂刺","=q4=卡拉伯爾水晶尖錘","=q4=札頓姆，吞噬者之杖","=q4=埃辛諾斯壁壘","=q4=背叛者黑弓"})
Process("BTNajentus",20,{"=q4=海浪召喚者軟靴","=q4=潮汐潛伏者面罩","=q4=黑暗披肩","=q4=順流頭盔","=q4=穆葛亞拳甲","=q4=海洋憤怒之靴","=q4=恆金外殼護腕","=q4=珍珠鑲飾長靴","=q4=潮汐踐踏者護脛","","","","","","","=q4=浪靜指環","=q4=俘虜風暴指環","=q4=漩渦之怒匕首","=q4=潮起之斧","=q4=荒漠長戟"})
Process("BTPatterns",19,{"=q4=設計圖:黎明鋼鐵護腕","=q4=設計圖:黎明鋼鐵護肩","=q4=設計圖:迅鋼護腕","=q4=設計圖:迅鋼護肩","=q4=圖樣:電光反射束腕","=q4=圖樣:生命再生護腕","=q4=圖樣:大地生命束腕","=q4=圖樣:大地生命護肩","=q4=圖樣:電光反射護肩","=q4=圖樣:生命再生肩墊","=q4=圖樣:迅擊護腕","=q4=圖樣:迅擊護肩","","","","=q4=圖樣:靈機護腕","=q4=圖樣:靈機披肩","=q4=圖樣:速癒披肩","=q4=圖樣:速癒裹帶"})
Process("BTShahraz",18,{"=q4=荒廢護腿","=q4=暗影大師之靴","=q4=碎心胸甲","=q4=娜迪納的貞潔墜飾","=q4=光明使者法典","=q4=兇蠻之刃","","","","","","","","","","=q4=遺忘征服者肩鎧","=q4=遺忘保衛者肩鎧","=q4=遺忘防禦者肩鎧"})
Process("BTSupremus",22,{"=q4=無盡裹腰","=q4=虛空暗影外套","=q4=風暴前夕手環","=q4=精確飛行裹帶","=q4=自然學家的保護繫腰","=q4=深淵憤怒肩鎧","","","","","","","","","","=q4=無盡夢魘頸飾","=q4=深淵領主指環","=q4=白鹿塑像","=q4=殘暴者","=q4=納斯雷茲姆虹吸之錘","=q4=魔石壁壘","=q4=軍團擊殺十字弩"})
Process("BTTrash",28,{"=q4=虛無披風","=q4=最終之刻罩氅","=q4=神聖光芒之靴","=q4=獸穴之后足靴","=q4=無情暴風護胸","=q4=掠取者護手","=q4=光明先驅者束腰","=q4=鋸齒之刃頸圈","=q4=地獄火墜飾","=q4=蹂躪指環","=q4=卡拉伯爾祝福指環","=q4=上古知識指環","","","","=q4=審判之錘","=q4=迅鋼棍棒","=q4=伊利達瑞符文盾","","=q4=蒼穹藍寶石","=q4=焚石","=q4=獅眼石","=q4=海泉綠寶石","=q4=影歌紫水晶","=q4=赤紅尖晶石","","=q3=黑暗之心","=q2=伊利達瑞的印記"})
Process("CFRSerpentHydross",21,{"=q4=憎恨回音長袍","=q4=純淨裹帶","=q4=變換夢魘之靴","=q4=怪異肩墊","=q4=黑暗深淵戰爭手環","=q4=首席遊俠護胸","=q4=正義明亮頭盔","=q4=戰鬥舞者肩鎧","","","","","","","","=q4=致命之戒","=q4=惡意侵略指環","=q4=野性之心生命根源","=q4=移位寶石","=q4=深淵石","=q4=新月女神塑像"})
Process("CFRSerpentKarathress",18,{"=q4=靈魂行者之靴","=q4=血海盜賊的外衣","=q4=浸濕的磨損拴繩","=q4=潮行者深淵胸針","=q4=亂流之測量儀","=q4=世界破擊者","","","","","","","","","","=q4=征服勇士護腿","=q4=征服防衛者護腿","=q4=征服英雄護腿"})
Process("CFRSerpentLeotheras",18,{"=q4=逆戟鯨皮之靴","=q4=珊瑚鉤肩墊","=q4=精準遠行者手環","=q4=無敵束腰","=q4=海嘯護符","=q4=海巨獸毒牙","","","","","","","","","","=q4=征服勇士手套","=q4=征服防衛者手套","=q4=征服英雄手套"})
Process("CFRSerpentLurker",21,{"=q4=驚嘆恐懼之索","=q4=守護者絲絨之靴","=q4=雷姆洛斯樹叢手環","=q4=便戰之靴","=q4=暴風行者之靴","=q4=真實閃光胸甲","=q4=消滅護腕","","","","","","","","","=q4=獸性狂怒頸飾","=q4=先祖征服之戒","=q4=丹札拉之印","=q4=精神冥想耳環","=q4=絕對真相聖契","=q4=潮汐之錘"})
Process("CFRSerpentMorogrim",21,{"=q4=鋒利鱗片戰爭披風","=q4=伊利達瑞肩墊","=q4=先祖糾結護軀","=q4=堅韌追蹤者披肩","=q4=召汐束腰","=q4=銀色哨兵肩鎧","=q4=遺忘戰靴","","","","","","","","","=q4=迷失歲月墜飾","=q4=靈魂分裂之戒","=q4=警覺指環","=q4=蛇圍繩帶","=q4=艾薩拉之爪","=q4=那魯冷光魔棒"})
Process("CFRSerpentTrash",27,{"=q4=無盡驍勇之靴","=q4=冒險墜飾","=q4=隱藏艦隊的小望遠鏡","=q4=漩渦圖騰","=q4=野性之怒法杖","=q4=毒蛇神殿手裏劍","","=q4=設計圖:紅色浩劫長靴","=q4=設計圖:紅色戰鬥腰帶","=q4=設計圖:保衛者之靴","=q4=設計圖:守衛者腰帶","=q4=圖樣:衝擊腰帶","=q4=圖樣:衝擊之靴","=q4=圖樣:長路之靴","=q4=圖樣:長路腰帶","=q4=圖樣:颶風長靴","=q4=圖樣:季風腰帶","=q4=圖樣:自然之擁之靴","=q4=圖樣:紅鷹之靴","=q4=圖樣:絕對黑暗之靴","=q4=圖樣:自然之力腰帶","=q4=圖樣:黑鷹腰帶","=q4=圖樣:暗影深淵腰帶","","=q4=虛空漩渦","","=q2=伊利達瑞的印記"})
Process("CFRSerpentVashj",20,{"=q4=海巫法衣","=q4=符文圖騰披肩","=q4=百亡腰帶","=q4=眼鏡蛇鞭長靴","=q4=海怪之心胸甲","=q4=羞慚的光榮護手","=q4=無盡線圈之戒","=q4=復甦珊瑚指環","=q4=靜心棱鏡","=q4=瓦許毒牙","=q4=聖光深淵錘杖","=q4=蛇脊長弓","","","","=q4=征服勇士頭盔","=q4=征服防衛者頭盔","=q4=征服英雄頭盔","","=q1=瓦許的殘存之瓶"})
Process("CFRSlaveMennu",7,{"=q3=奢華統治護腿","=q3=生命電光外衣","=q3=追蹤者的腰帶","=q3=荒行剃刃","=q3=魔焰長劍","","=q2=圖樣:自然護甲片"})
Process("CFRSlaveMennuHEROIC",13,{"=q4=正義徽章","=q4=光輝火焰蛋白石","=q4=鮮艷的綠玉髓","=q4=皇家的丹泉石","","=q3=信念之索","=q3=曼紐的綴鱗護腿","=q3=破碎者箭術腰帶","=q3=背叛套索","=q3=人工生長圖騰","=q3=星光匕首","","=q2=圖樣:自然護甲片"})
Process("CFRSlaveQuagmirran",5,{"=q3=盈孢披風","=q3=靈巧手甲","=q3=工蠍之刺披肩","=q3=無疤胸甲","=q3=藍色鎧甲護脛"})
Process("CFRSlaveQuagmirranHEROIC",27,{"=q4=正義徽章","=q4=褻瀆之靴","=q4=午夜腿甲","=q4=野性魔法肩鎧","=q4=極堅不壞項鍊","","=q3=奎克米瑞的手銬","=q3=大地靈魂馬褲","=q3=正義之怒胸甲","=q3=靜止束腰","=q3=法師之怒束腰","","=q1=奎克米瑞之心","","","=q4=光輝火焰蛋白石","=q4=鮮艷的綠玉髓","=q4=皇家的丹泉石","","=q3=法力蝕刻肩甲","=q3=哀傷之鏈肩鎧","","=q3=烏索指環","=q3=奎克米瑞之眼","=q3=水光燈籠","=q3=磷光刃","=q3=血之谷戰錘"})
Process("CFRSlaveRokmar",5,{"=q3=泥沼閃擊鱗片披風","=q3=符文菌帽","=q3=盤牙恢復之錘","=q3=冷靜孢子蘆葦","=q3=盤牙縫衣針"})
Process("CFRSlaveRokmarHEROIC",11,{"=q4=正義徽章","=q4=光輝火焰蛋白石","=q4=鮮艷的綠玉髓","=q4=皇家的丹泉石","","=q3=鐵鱗戰爭披風","=q3=冷語之索","=q3=騙子之索","=q3=怒浪長靴","=q3=祝福滿盈束腰","=q3=戰怒骷髏項鍊"})
Process("CFRSteamSecondFragmentGuardian",1,{"=q1=第二塊鑰匙碎片"})
Process("CFRSteamSteamrigger",7,{"=q3=地幔裹手","=q3=苦行面罩","=q3=勇氣蒸汽絞鍊圈","=q3=蛇峰生命法杖","=q3=X-54型無後座力火箭撕裂砲","","=q3=結構圖:火箭靴極限版"})
Process("CFRSteamSteamriggerHEROIC",12,{"=q4=正義徽章","=q4=碎裂綠玉髓","=q4=灌能火焰蛋白石","=q4=移形的丹泉石","","=q3=地幔裹手","=q3=苦行面罩","=q3=勇氣蒸汽絞鍊圈","=q3=蛇峰生命法杖","=q3=X-54型無後座力火箭撕裂砲","","=q3=結構圖:火箭靴極限版"})
Process("CFRSteamThespia",16,{"=q3=低語貝殼披風","=q3=坦然護胸","=q3=月怒束腰","=q3=火花珊瑚指環","","=q2=圖樣:寒冰護甲片","","=q1=瓶裝地獄土壤","","","","","","","","=q3=魔法使的手套"})
Process("CFRSteamThespiaHEROIC",16,{"=q4=正義徽章","=q4=碎裂綠玉髓","=q4=灌能火焰蛋白石","=q4=移形的丹泉石","","=q3=低語貝殼披風","=q3=坦然護胸","=q3=月怒束腰","=q3=火花珊瑚指環","","=q2=圖樣:寒冰護甲片","","=q1=瓶裝地獄土壤","","","=q3=魔法使的手套"})
Process("CFRSteamTrash",6,{"=q3=設計圖:冰霜克銀指環","","=q2=公式:附魔護腕 - 堅韌","","=q1=瓦許女士的命令","=q1=盤牙裝備"})
Process("CFRSteamWarlord",22,{"=q4=圖樣:戰放兜帽","","=q3=惡魔鯊魚斗篷","=q3=朱紅支配長袍","=q3=巨蛇束帶","=q3=深淵之心護手","=q3=銀手之戒","","","","","","","","","=q3=魔法使的肩鎧","=q3=月光林地護肩","=q3=野獸之王披肩","=q3=惡潮護手","=q3=野獸之王護腿","=q3=公正胸甲","=q3=勇猛護手"})
Process("CFRSteamWarlordHEROIC",28,{"=q4=正義徽章","=q4=教皇褶裙","=q4=怒浪臂鎧","=q4=侵略者的琥珀手環","=q4=怒潮長弓","","=q3=惡魔鯊魚斗篷","=q3=朱紅支配長袍","=q3=巨蛇束帶","=q3=深淵之心護手","=q3=銀手之戒","","=q1=卡利斯瑞的三叉戟","=q1=督軍的論述","","=q4=圖樣:戰放兜帽","=q4=碎裂綠玉髓","=q4=灌能火焰蛋白石","=q4=移形的丹泉石","","","=q3=魔法使的肩鎧","=q3=月光林地護肩","=q3=野獸之王披肩","=q3=惡潮護手","=q3=野獸之王護腿","=q3=公正胸甲","=q3=勇猛護手"})
Process("CFRUnderGhazan",5,{"=q3=治療光披風","=q3=釘甲貞德束腰","=q3=堅毅護符","=q3=洞察夜光珍珠","=q3=仇恨者"})
Process("CFRUnderGhazanHEROIC",11,{"=q4=正義徽章","=q4=柔光綠玉髓","=q4=絢麗火焰蛋白石","=q4=輻光的綠玉髓","","=q3=沙丘之風束帶","=q3=浪潮頭飾","=q3=英豪束腰","=q3=海蛇牙項鍊","=q3=暗影深處之戒","=q3=海巨獸大法杖"})
Process("CFRUnderHungarfen",5,{"=q3=法力火花手套","=q3=星光護手","=q3=萊庫血手環","=q3=雷首圖騰","=q3=針葉飛鏢"})
Process("CFRUnderHungarfenHEROIC",11,{"=q4=正義徽章","=q4=柔光綠玉髓","=q4=絢麗火焰蛋白石","=q4=輻光的綠玉髓","","=q3=奧金徽記手環","=q3=飢餓皮護手","=q3=持續燃燒束腰","=q3=忠誠長衣","=q3=厄索克塑像","=q3=泥沼脊椎指節"})
Process("CFRUnderStalker",7,{"=q3=占兆師長袍","=q3=鑿顱者護腿","=q3=搖晃之皮護胸","=q3=蠻力肩鎧","=q3=捕獵者毒牙","","=q1=黑色捕獵者的大腦"})
Process("CFRUnderStalkerHEROIC",27,{"=q4=正義徽章","=q4=樹皮碎片長靴","=q4=風暴之歌褶裙","=q4=靜行者之眼","=q4=黑色獵捕魔杖","","=q3=惡魔毒牙儀式頭盔","=q3=永恆之謎神諭腰帶","=q3=山貓領主之野性面罩","=q3=野人裹腿","=q3=白骨枷鎖項鍊","=q3=假象之戒","=q3=地獄火力量淨化物","=q3=阿古斯式羅盤","","=q4=柔光綠玉髓","=q4=絢麗火焰蛋白石","=q4=輻光的綠玉髓","","=q3=法力蝕刻窄褲","=q3=末日戰甲肩衛","","=q3=終結者之劍","=q3=恢復之風暴盾牌","","=q1=黑色捕獵者的大腦","=q1=黑色捕獵者的蛋"})
Process("CFRUnderSwamplord",5,{"=q3=耐久敏捷披風","=q3=守夜外套","=q3=真理肩衛","=q3=鐵守衛護脛","=q3=贊格之牙短刃"})
Process("CFRUnderSwamplordHEROIC",11,{"=q4=正義徽章","=q4=柔光綠玉髓","=q4=絢麗火焰蛋白石","=q4=輻光的綠玉髓","","=q3=太陽護手","=q3=森林之王頭冠","=q3=驕傲裹臂","=q3=沼石項鍊","=q3=風化的沼澤之王指環","=q3=泥沼搶奪者"})
Process("CoTHillsbradAgedDalaranWizard",1,{"=q1=公式:附魔盾牌 - 智力"})
Process("CoTHillsbradDrake",5,{"=q3=衝動披風","=q3=暴掠暗影褶裙","=q3=鴉翼肩鎧","=q3=烏瑟的儀式戰靴","=q3=堅固鐵指環"})
Process("CoTHillsbradDrakeHEROIC",11,{"=q4=正義徽章","=q4=燦爛的綠玉髓","=q4=強能火焰蛋白石","=q4=耐久的綠玉髓","","=q3=埃蘭的巫術便褲","=q3=月蝕手套","=q3=摩克納薩爾戰鬥面罩","=q3=中尉的羅德隆徽記","=q3=羅德隆醫療指導","=q3=血顱摧毀者"})
Process("CoTHillsbradHunter",7,{"=q4=設計圖:秘法之力頭環","","=q3=容忍肩鎧","=q3=匹瑞諾德披肩","=q3=復發鑽石稜柱","=q3=布洛克斯的勇氣之戒","=q3=時光之盾匕首"})
Process("CoTHillsbradHunterHEROIC",26,{"=q4=正義徽章","=q4=崇聖之索","=q4=夜暮腕甲","=q4=大師級竊盜手套","=q4=龍鱗護脛","=q4=殉難者護脛","","=q3=紀元私語繫腰","=q3=龍怒肩鎧","=q3=璀璨希望項鍊","=q3=光榮響亮之戒","=q3=閃光秘法戒指","=q3=秘法師之石","=q3=時光分割者","=q3=無盡搶奪者","=q4=燦爛的綠玉髓","=q4=強能火焰蛋白石","=q4=耐久的綠玉髓","=q4=設計圖:秘法之力頭環","","=q3=法力蝕刻法衣","=q3=荒行頭盔","=q3=哀傷之鏈鍊衫","=q3=末日戰甲頭盔","","=q1=紀元狩獵者的頭顱"})
Process("CoTHillsbradSkarloc",9,{"=q3=風暴之緣護手","=q3=耐性綴鱗護脛","=q3=杜洛坦的戰鬥背心","=q3=阿曼尼毒斧","=q3=北郡戰錘","","=q2=紅色冬帽","","=q2=配方:鐵盾藥水"})
Process("CoTHillsbradSkarlocHEROIC",15,{"=q4=正義徽章","=q4=燦爛的綠玉髓","=q4=強能火焰蛋白石","=q4=耐久的綠玉髓","","=q3=預言主教窄褲","=q3=月冠鹿角","=q3=綠鱗護脛","=q3=警戒之心之靴","=q3=塔倫米爾活力小墜子","=q3=達索漢的儀式之錘","","=q2=紅色冬帽","","=q2=配方:鐵盾藥水"})
Process("CoTHillsbradThomasYance",1,{"=q1=圖樣:騎乘馬鞭"})
Process("CoTHillsbradTrash",1,{"=q3=圖樣:造型冒險帽"})
Process("CoTMorassAeonus",21,{"=q3=無罪風帽","=q3=原浪護腕","=q3=赤紅飛行肩鎧","=q3=無盡迴圈寶石","=q3=拉托的移形長劍","=q3=血火大法杖","","","","","","","","","","=q3=法力蝕刻之冠","=q3=暗殺纏手","=q3=月光林地便褲","=q3=哀傷之鏈頭盔","=q3=勇猛腿鎧","=q3=公正腿鎧"})
Process("CoTMorassAeonusHEROIC",25,{"=q4=正義徽章","=q4=神秘長褲","=q4=死靈束腰","=q4=悍勇功蹟束腰","=q4=量子刃","","=q3=無罪風帽","=q3=原浪護腕","=q3=赤紅飛行肩鎧","=q3=無盡迴圈寶石","=q3=拉托的移形長劍","=q3=血火大法杖","","=q1=艾奧那斯的沙漏","","=q4=閃光火焰蛋白石","=q4=閃爍的火焰蛋白石","=q4=發光的丹泉石","","=q3=法力蝕刻之冠","=q3=暗殺纏手","=q3=月光林地便褲","=q3=哀傷之鏈頭盔","=q3=勇猛腿鎧","=q3=公正腿鎧"})
Process("CoTMorassDeja",8,{"=q3=時間轉移斗篷","=q3=三大恐懼披肩","=q3=鍍陽護肩","=q3=心靈之火頭盔","=q3=心靈專注之戒","=q3=梅爾摩塔之微光長弓","","=q2=圖樣:秘法護甲片"})
Process("CoTMorassDejaHEROIC",13,{"=q4=正義徽章","=q4=閃光火焰蛋白石","=q4=閃爍的火焰蛋白石","=q4=發光的丹泉石","","=q3=時間轉移斗篷","=q3=三大恐懼披肩","=q3=鍍陽護肩","=q3=心靈之火頭盔","=q3=心靈專注之戒","=q3=梅爾摩塔之微光長弓","","=q2=圖樣:秘法護甲片"})
Process("CoTMorassTemporus",6,{"=q3=誓絕之卡德加褶裙","=q3=訕笑骷髏戰爭背心","=q3=破壞者沙漏","=q3=星心提燈","=q3=千禧之刃","=q3=紀元修補權杖"})
Process("CoTMorassTemporusHEROIC",11,{"=q4=正義徽章","=q4=閃光火焰蛋白石","=q4=閃爍的火焰蛋白石","=q4=發光的丹泉石","","=q3=誓絕之卡德加褶裙","=q3=訕笑骷髏戰爭背心","=q3=破壞者沙漏","=q3=星心提燈","=q3=千禧之刃","=q3=紀元修補權杖"})
Process("CoTMorassTrash",1,{"=q3=圖樣:造型叢林帽"})
Process("GruulGruul",23,{"=q4=丘加利頭帶","=q4=自然氣息風帽","=q4=古羅縫製束腰","=q4=屠龍者護手","=q4=風剪長靴","=q4=火星完美護手","=q4=戈魯爾之牙","=q4=戈魯爾之眼","=q4=龍脊戰利品","","=q1=土靈徽記","","","","","=q4=逝往勇士護腿","=q4=逝往防衛者護腿","=q4=逝往英雄護腿","","=q4=血喉魔導師之刃","=q4=古羅王之斧","=q4=奧多爾遺產防衛者","=q4=否定手裏劍"})
Process("GruulsLairHighKingMaulgar",18,{"=q4=野蠻巨魔僧侶披風","=q4=神聖鼓舞腰帶","=q4=暗影邪惡面罩","=q4=莫卡爾的戰爭頭盔","=q4=劍刃氏族戰爭手環","=q4=那魯之錘","","","","","","","","","","=q4=逝往勇士肩鎧","=q4=逝往防衛者肩鎧","=q4=逝往英雄肩鎧"})
Process("HCFurnaceBreaker",5,{"=q3=神聖權威衣飾","=q3=心靈之火腰環","=q3=暮色居民披肩","=q3=復仇外衣","=q3=戰歌咆哮之斧"})
Process("HCFurnaceBreakerHEROIC",26,{"=q4=正義徽章","=q4=暗擁披肩","=q4=浪峰行者之靴","=q4=鷹頂戰靴","=q4=擊碎者護符","","=q3=騰光長袍","=q3=頑固護腿","=q3=世界盡頭護腕","=q3=翡翠之眼護腕","=q3=正義紅寶石頭盔","=q3=血誓戰靴","=q3=士兵的識別證","=q3=不屈驍勇塑像","","=q4=發光的火焰蛋白石","=q4=螢光丹泉石","=q4=鋸齒的綠玉髓","","=q3=荒行外套","=q3=末日戰甲護手","","=q3=破志者","=q3=極堅強弩","","=q1=凱利丹的羽飾手杖"})
Process("HCFurnaceBroggok",5,{"=q3=拱狀護腕","=q3=染血的外科醫生長手套","=q3=夜行者褶裙","=q3=奧斯雷的聖光引導器","=q3=軍團喇叭槍"})
Process("HCFurnaceBroggokHEROIC",10,{"=q4=正義徽章","=q4=發光的火焰蛋白石","=q4=螢光丹泉石","=q4=鋸齒的綠玉髓","","=q3=鑲邊法葬長靴","=q3=月兒護腿","=q3=貞潔先驅者臂鎧","=q3=安寧之戒","=q3=火炬戰斧"})
Process("HCFurnaceMaker",5,{"=q3=颶風束腰","=q3=鐵刃護手","=q3=戰爭貪欲墜飾","=q3=逝者聖契","=q3=鑽石核心大錘"})
Process("HCFurnaceMakerHEROIC",10,{"=q4=正義徽章","=q4=發光的火焰蛋白石","=q4=螢光丹泉石","=q4=鋸齒的綠玉髓","","=q3=鑲邊神秘斗篷","=q3=火焰風暴之法師頭帶","=q3=月觸手環","=q3=血領主腿鎧","=q3=報怨聖契"})
Process("HCHallsExecutioner",1,{"=q1=劊子手的廢棄之斧"})
Process("HCHallsKargath",21,{"=q3=粉碎者護脛","=q3=巨像之偶","=q3=光輝霍特斯徽印","=q3=惡魔之血除取者","=q3=聖光之誓大錘","=q3=奈薩斯火炬","","=q1=大酋長卡加斯之手","","","","","","","","=q3=神聖儀祭裹手","=q3=失落手套","=q3=荒行手套","=q3=野獸之王手甲","=q3=哀傷之鏈護手","=q3=公正護手"})
Process("HCHallsKargathHEROIC",25,{"=q4=正義徽章","=q4=純化魔法手環","=q4=森林之心護腕","=q4=正義之路之靴","=q4=刃拳","","=q3=粉碎者護脛","=q3=巨像之偶","=q3=光輝霍特斯徽印","=q3=惡魔之血除取者","=q3=聖光之誓大錘","=q3=奈薩斯火炬","","=q1=大酋長卡加斯之手","=q1=刃拳的徽印","=q4=拋光的綠玉髓","=q4=夜光的火焰蛋白石","=q4=尊貴的丹泉石","","=q3=神聖儀祭裹手","=q3=失落手套","=q3=荒行手套","=q3=野獸之王手甲","=q3=哀傷之鏈護手","=q3=公正護手"})
Process("HCHallsNethekurse",11,{"=q4=圖樣:法擊兜帽","","=q3=敵意披風","=q3=奈德克斯手環","=q3=泰拉蕊狩獵束腰","=q3=堅固巨盔","=q3=月神的象牙塑像","","=q2=綠色冬帽","","=q1=大術士的護符"})
Process("HCHallsNethekurseHEROIC",16,{"=q4=正義徽章","=q4=圖樣:法擊兜帽","=q4=拋光的綠玉髓","=q4=夜光的火焰蛋白石","=q4=尊貴的丹泉石","","=q3=敵意披風","=q3=奈德克斯手環","=q3=泰拉蕊狩獵束腰","=q3=堅固巨盔","=q3=月神的象牙塑像","","=q1=大術士的護符","=q1=黑暗之書","","=q2=綠色冬帽"})
Process("HCHallsOmrogg",16,{"=q3=崇聖寶石之靴","=q3=符歌匕首","=q3=毀滅火槌","=q3=天火鷹弓","","=q1=大地之母的眼淚","","","","","","","","","","=q3=惡潮肩衛"})
Process("HCHallsOmroggHEROIC",16,{"=q4=正義徽章","=q4=拋光的綠玉髓","=q4=夜光的火焰蛋白石","=q4=尊貴的丹泉石","","=q3=崇聖寶石之靴","=q3=符歌匕首","=q3=毀滅火槌","=q3=天火鷹弓","","=q1=大地之母的眼淚","","","","","=q3=惡潮肩衛"})
Process("HCHallsPorung",10,{"=q4=正義徽章","=q4=拋光的綠玉髓","=q4=夜光的火焰蛋白石","=q4=尊貴的丹泉石","","=q3=灼熱怒氣窄褲","=q3=輕巧足跡足靴","=q3=流動思緒腰帶","=q3=殺戮肩甲","=q3=血衛士兇殘項鍊"})
Process("HCHallsTrash",1,{"=q2=公式:附魔雙手武器 - 兇蠻"})
Process("HCMagtheridon",26,{"=q4=地窖潛行者披風","=q4=嗜魂者裹手","=q4=騙子的口才手套","=q4=恐怖陷阱束腰","=q4=雷霆巨盔","=q4=無盡圈套束腰","=q4=瑪瑟里頓之眼","=q4=卡拉伯爾護符","","=q4=競技場之寬刃","=q4=水晶之心搏動法杖","=q4=復仇者聖禦盾","=q4=埃雷達爾忘卻法杖","","=q2=黑色寶石袋","=q4=逝往勇士護胸","=q4=逝往防衛者護胸","=q4=逝往英雄護胸","","=q4=瑪瑟里頓之首","=q4=頑強之戒","=q4=那魯光明護衛指環","=q4=赤紅狂怒指環","=q4=阿達歐的防禦徽記","","=q4=深淵領主的背包"})
Process("HCRampFelIronChest",10,{"=q3=摩克納薩爾迷霧披風","=q3=生命馬褲","=q3=午夜變換束帶","=q3=轟雷褶裙","=q3=鐵底重靴","=q3=復原指環","=q3=巫魅指環","=q3=摩克納薩爾之戒","=q3=地獄搶奪者","=q3=烏索之爪"})
Process("HCRampFelIronChestHEROIC",21,{"=q4=正義徽章","=q4=樹林修補者腰帶","=q4=狂怒灌注護手","=q4=獅心束腰","=q4=邪齒除取者","","=q3=聖光刻劃手環","=q3=徘徊者護胸","=q3=自然之息衣飾","=q3=熔岩肩鎧","=q3=海洋之歌褶裙","=q3=鐵龍面甲","=q3=膽量臂鎧","=q3=生命背負者護手","","=q4=彩虹火焰蛋白石","=q4=光輝的綠玉髓","=q4=穩固的綠玉髓","","=q3=艾弗林的殺戮戒指","=q3=搶奪者指環"})
Process("HCRampNazan",1,{"=q1=納桑之顱"})
Process("HCRampOmor",8,{"=q3=血污劫毀者護手","=q3=堅韌防衛者","=q3=扼環頸鏈","=q3=心血祈禱珠串","=q3=心火戰錘","=q3=水晶火焰法杖","","=q1=歐瑪爾的蹄子"})
Process("HCRampOmorHEROIC",20,{"=q4=正義徽章","","=q3=敏捷頭飾","=q3=赤紅陰暗護腕","=q3=沉默行者長靴","=q3=詛咒觸發束腰","=q3=正義背負者肩鎧","=q3=赤紅鍛造胸甲","=q3=歐瑪爾的不屈意志","=q3=多稜指環","=q3=法奧的淨化徽記","=q3=恐懼烈焰匕首","=q3=地獄之錘","","=q1=歐瑪爾的蹄子","=q4=彩虹火焰蛋白石","=q4=光輝的綠玉髓","=q4=穩固的綠玉髓","","=q3=法力蝕刻手套"})
Process("HCRampVazruden",1,{"=q1=不祥的信件"})
Process("HCRampWatchkeeper",7,{"=q3=秘法狂怒肩鎧","=q3=手段護腕","=q3=爭鬥者鱗片護腿","=q3=聖光之觸胸甲","=q3=暗影撕裂長刃","","=q1=卡爾古瑪之手"})
Process("HCRampWatchkeeperHEROIC",12,{"=q4=正義徽章","=q4=彩虹火焰蛋白石","=q4=光輝的綠玉髓","=q4=穩固的綠玉髓","","=q3=永生者披風","=q3=黑暗行者之靴","=q3=野行者之靴","=q3=公平獎勵護腕","=q3=血騎士防衛者","","=q1=卡爾古瑪之手"})
Process("KaraAran",22,{"=q4=黑暗搶奪者披氅","=q4=奪心魔披肩","=q4=地獄火集會之靴","=q4=廉正之靴","=q4=惡霸之靴","=q4=鋼刺面甲","=q4=正義尋求者肩鎧","","=q4=正義徽章","","=q1=麥迪文的日記","","","","","=q4=虎爪護符","=q4=謝爾曼納偉大之戒","=q4=紫羅蘭之眼墜飾","=q4=埃蘭的舒緩藍寶石","=q4=提里斯法權勢魔杖","","=q3=公式:附魔武器 - 烈日火焰"})
Process("KaraAttumen",21,{"=q4=先驅者手環","=q4=流動思緒裹手","=q4=聖使祝福手套","=q4=白雄鹿護腕","=q4=敏捷操作手套","=q4=旋風護腕","=q4=獵捕者戰鬥手環","=q4=驍勇臂鎧","=q4=希望重燃護手","","=q4=正義徽章","","","","","=q4=狼爪項鍊","=q4=經絡鬼靈指環","=q4=鋼鷹之弩","=q4=熾炎戰馬韁繩","","=q3=結構圖:穩固恆金瞄準鏡"})
Process("KaraCharredBoneFragment",1,{"=q1=燒焦的白骨碎片"})
Process("KaraChess",19,{"=q4=高階君主頭飾","=q4=無情刀刃肩墊","=q4=叛節束腰","=q4=森林之王行者之靴","=q4=心火護腿","=q4=屠魔之靴","=q4=無罪腿鎧","=q4=戰傷長靴","","=q4=正義徽章","","","","","","=q4=英氣秘銀項鍊","=q4=回憶之戒","=q4=君王防衛者","=q4=上古三連盾"})
Process("KaraCurator",18,{"=q4=慰藉給予者肩鎧","=q4=森林之風肩墊","=q4=龍震肩衛","=q4=烏瑞恩王朝護脛","=q4=迦羅娜的璽戒","=q4=無限奧義法杖","","=q4=正義徽章","","","","","","","","=q4=逝往勇士手套","=q4=逝往防衛者手套","=q4=逝往英雄手套"})
Process("KaraIllhoof",22,{"=q4=電鍍瑟銀披風","=q4=灌注之影藤披風","=q4=意志環帶","=q4=邪惡束腰","=q4=自然生計之索","=q4=宵小束腰","=q4=聖光捆縛者胸甲","","=q4=正義徽章","","","","","","","=q4=修補者之心型指環","=q4=電光相容器","=q4=蠢人毒藥","=q4=泰瑞斯提安抑制法杖","=q4=薩維亞短劍","","=q3=公式:附魔武器 - 靈魂冰霜"})
Process("KaraKeannaLog",1,{"=q1=琪安娜的日誌"})
Process("KaraMaiden",18,{"=q4=內心手環","=q4=惡毒手環","=q4=預示之靴","=q4=恨惡護腕","=q4=樹林修補者長手套","=q4=核心手套","=q4=復甦手套","=q4=正義護腕","=q4=初新鐵護手","","=q4=正義徽章","","","","","=q4=倒刺懲罰頸飾","=q4=治癒大雨圖騰","=q4=善潔裂片"})
Process("KaraMoroes",22,{"=q4=阿拉希諸王皇家披風","=q4=達拉然暗影披風","=q4=虛空裂片束腰","=q4=邊緣行者長靴","=q4=強力腰帶","=q4=不撓的赤紅束腰","=q4=剛勇之靴","","=q4=正義徽章","","","","","","","=q4=不滅狂怒胸針","=q4=摩洛的幸運懷錶","=q4=堅信之戒","=q4=鳥類之心塑像","=q4=綠寶石匕首","","=q3=公式:附魔武器 - 貓鼬"})
Process("KaraNamed",20,{"","=q4=潛伏者之索","=q4=潛伏者之握","=q4=潛伏者腰帶","=q4=潛伏者束腰","","","=q4=劫毀者腕輪","=q4=劫毀者裹腕","=q4=劫毀者手環","=q4=劫毀者護腕","","","","","","=q4=滑行裹足","=q4=滑行的靴子","=q4=滑行脛甲","=q4=滑行護脛"})
Process("KaraNetherspite",19,{"=q4=獨心頭飾","=q4=悔悟窄褲","=q4=藐視風帽","=q4=躲藏護脛","=q4=大地之血護胸","=q4=破碎撕掠者護腿","=q4=亞伯拉彌斯披肩","=q4=真實束腰","","=q4=正義徽章","","","","","","=q4=冥界之光亮項鍊","=q4=無疤秘銀指環","=q4=無限可能珠寶","=q4=憤怒之刃"})
Process("KaraNightbane",20,{"=q4=古老符號長袍","=q4=石化樹幹上衣","=q4=共謀者護胸","=q4=屠殺綴鱗胸甲","=q4=兇猛迅足靴","=q4=潘札薩爾胸甲","=q4=緊急鐵行者之靴","","=q4=正義徽章","","=q1=熾烈徽記","=q1=微弱的秘法精華","","","","=q4=餘燼馬刺護符","=q4=暗夜毒物護符","=q4=永生黑夜之杖","=q4=龍心火焰盾牌","=q4=深沉黑暗之盾"})
Process("KaraOperaEvent",28,{"","=q4=正義徽章","=q4=火焰試煉長褲","=q4=大地靈魂護腿","=q4=野獸深淵肩鎧","=q4=恆金巨盔","=q4=奉獻綬帶","=q4=贖救靈魂聖契","","","=q4=邪惡女巫之帽","=q4=紅寶石軟靴","=q4=繼承之斧","=q4=藍鑽石女巫魔杖","","","=q4=潛藏禮袍","=q4=羅慕歐的毒藥瓶","=q4=無報之刃","=q4=絕望之劍","","","","","=q4=小紅帽披風","=q4=大野狼的頭顱","=q4=大野狼的爪子","=q4=屠狼者狙擊步槍"})
Process("KaraPrince",18,{"=q4=純潔之心無垢披風","=q4=神秘紅寶石披氅","=q4=遠行者迷惑披風","=q4=偷取的靈魂飾物","=q4=永生玉戒","=q4=千印之戒","","=q4=納斯雷茲姆心靈之刃","=q4=莫克辛匕首","=q4=斬首者","=q4=血吼之斧","=q4=聖光正義之錘","=q4=日怒鳳凰之弓","","=q4=正義徽章","=q4=逝往勇士頭盔","=q4=逝往防衛者頭盔","=q4=逝往英雄頭盔"})
Process("KaraTrash",21,{"=q4=正義披氅","=q4=亡者之握","=q4=地獄之索","=q4=靈巧之握手套","=q4=吉爾哈特遺失的足靴","=q4=追蹤者腰帶","=q4=迴避之靴","","=q1=山脈之王傳說","=q1=狼人的折磨","=q1=亡者救贖","=q1=泰坦之怒","","=q1=靈魂精華","","=q4=雷特辛失落墜飾","=q4=無情風暴之戒","","=q4=圖樣:靈魂布護肩","=q4=圖樣:靈魂布外衣","=q2=公式:附魔靴子 - 穩固"})
Process("MountHyjalAnetheron",19,{"=q4=怨怒披肩","=q4=安納塞隆的束縛","=q4=大主教的軟靴","=q4=阿里漢多先生的金幣腰帶","=q4=附魔皮便鞋","=q4=恢復之金色胸扣","=q4=迅行者底鞋","=q4=微光鐵甲披肩","","","","","","","","=q4=堅韌意志之劍","=q4=惡名之刃","=q4=殘暴之柱","=q4=聖光堡壘"})
Process("MountHyjalArchimonde",18,{"=q4=羅甯長袍","=q4=永恆護腿","=q4=午夜護胸","=q4=狂熱追蹤鎖甲","=q4=救主之握","=q4=無盡憤怒腿甲","=q4=淨化權杖","","=q4=混沌風暴之劍","=q4=裂地之鋒","=q4=阿古斯使徒","=q4=安東尼達斯的專注聖禦盾","=q4=刺皮打擊","","","=q4=遺忘征服者頭盔","=q4=遺忘保衛者頭盔","=q4=遺忘防禦者頭盔"})
Process("MountHyjalAzgalor",18,{"=q4=羅吉哥先生的斗篷","=q4=暗中主使者窄褲","=q4=蝴蝶結護腿","=q4=防衛者的榮耀","=q4=希望束腰","=q4=無限痛苦","","","","","","","","","","=q4=遺忘征服者手套","=q4=遺忘保衛者手套","=q4=遺忘防禦者手套"})
Process("MountHyjalKazrogal",17,{"=q4=安潔莉絲塔束帶","=q4=元素傳導護腿","=q4=藍色麂皮輕鞋","=q4=尖銳怒氣披肩","=q4=新月腰帶","=q4=黑羽輕靴","=q4=野獸馴服師護肩","=q4=溪谷行者束腰","=q4=日觸鍊甲護腿","=q4=沸騰狂怒腰帶","","","","","","=q4=贖罪之錘","=q4=卡茲洛加堅固之心"})
Process("MountHyjalTrash",23,{"=q4=虛無披風","=q4=派普的和解罩氅","=q4=神聖光芒之靴","=q4=無情暴風護胸","=q4=鋸齒之刃頸圈","=q4=地獄火墜飾","=q4=審判之錘","=q4=熔岩狂怒之爪","=q4=熔岩狂怒拳套","","=q3=黑暗之心","=q2=伊利達瑞的印記","","","","=q4=設計圖:閃光的赤紅尖晶石","=q4=設計圖:絕佳的獅眼石","=q4=設計圖:雕刻的焚石","=q4=設計圖:神秘的獅眼石","=q4=設計圖:移形的影歌紫水晶","=q4=設計圖:尊貴的影歌紫水晶","=q4=設計圖:激烈的蒼穹藍寶石","=q4=設計圖:矇矓的焚石"})
Process("MountHyjalWinterchill",19,{"=q4=殉難護腕","=q4=荒廢腕輪","=q4=致命的腕輪","=q4=回春護腕","=q4=探路者護腕","=q4=哀嚎之風護腕","=q4=止水之靴","=q4=血污肩鎧","=q4=受祝福的堅鋼護腕","=q4=狂暴鐐銬","","","","","","=q4=追蹤者之刃","=q4=黑暗秘密記事","","=q1=時間定相骨匣"})
Process("SMTDelrissa",8,{"=q3=背叛披風","=q3=聖暮披肩","=q3=寧靜波濤護手","=q3=殺戮護腕","=q3=高階女祭司戰鬥釘錘","=q3=夜之擊","","=q3=公式:附魔披風 - 鋼紋"})
Process("SMTDelrissaHEROIC",8,{"=q4=正義徽章","=q4=凱爾薩斯的禮讚","=q4=太陽之井晶瓶","=q4=廷巴爾的聚焦水晶","=q4=蔑視裂片","","=q3=公式:附魔披風 - 鋼紋","=q3=辛多雷寶珠"})
Process("SMTFireheart",6,{"=q3=迅捷修補披風","=q3=狂怒之火束腕","=q3=背叛護腿","=q3=巡林者的護腕","=q3=神聖祝福護手","=q3=日鑄斬斧"})
Process("SMTFireheartHEROIC",7,{"=q4=正義徽章","=q4=永歌腕輪","=q4=永恆痛楚重肩甲","=q4=玉晶匕首","=q4=分心繁刃","","=q3=辛多雷寶珠"})
Process("SMTKaelthas",22,{"=q4=逆刃披風","=q4=秘法敏銳手套","=q4=日狂足靴","=q4=戰爭使者鍊衫","=q4=逐日者戰靴","=q4=卡瑪的命運之戒","","=q3=結構圖:法力藥水注射器","=q3=設計圖:堅固的伊露恩之星","","=q1=凱爾薩斯的頭顱","","","","","=q3=復原之索","=q3=夏焰長袍","=q3=崇聖盔帽","=q3=迅敏指環","=q3=繁夢碎盡之斧","=q3=烈日灌注集中法杖","=q3=鳳凰寶寶"})
Process("SMTKaelthasHEROIC",15,{"=q4=正義徽章","=q4=緋紅辛多雷長袍","=q4=銀月保持者肩墊","=q4=遊俠領主外套","=q4=虛空之力胸鎧","=q4=懺悔騎士護脛","=q4=聖儀鬥棍","=q4=王子的激發之刃","=q4=慧星衝擊","=q4=迅捷白色陸行鷹","","=q3=鳳凰寶寶","","=q3=結構圖:法力藥水注射器","=q3=設計圖:堅固的伊露恩之星"})
Process("SMTTrash",1,{"=q3=日觸背包"})
Process("SMTVexallus",6,{"=q3=近晚披風","=q3=神聖導注護腕","=q3=復甦長靴","=q3=秘法敏捷指環","=q3=決斷指環","=q3=拉托的躍舞之刃"})
Process("SMTVexallusHEROIC",7,{"=q4=正義徽章","=q4=魔痕披肩","=q4=殘酷生存胸甲","=q4=壓迫之鋒","=q4=閃耀光芒權杖","","=q3=辛多雷寶珠"})
Process("SPBrutallus",18,{"=q4=災禍護腿","=q4=魔怒腿鎧","=q4=魔化力量腿鎧","=q4=深淵領主項圈","=q4=終歿之攫","=q4=深淵之心","=q4=悲慘君臨","","","","","","","","","=q4=遺忘征服者腰帶","=q4=遺忘保衛者腰帶","=q4=遺忘防禦者腰帶"})
Process("SPEredarTwins",28,{"=q4=救贖之魂罩氅","=q4=赤紅典範罩篷","=q4=召集者襯肩","=q4=奇觀披巾","=q4=知識追求肩墊","=q4=悔改肩甲","=q4=荒廢肩甲","=q4=烈怒肩墊","=q4=惡魔之牙肩墊","=q4=黃金森林披肩","=q4=至衡肩冑","=q4=爆發肩冑","=q4=堅忍肩鎧","=q4=狂暴肩鎧","","=q4=薩拉斯救主肩甲","=q4=薩拉斯防衛者肩甲","=q4=辛多雷征服墜飾","=q4=辛多雷拯救墜飾","=q4=辛多雷凱旋墜飾","=q4=無約束魔法護符","=q4=有害慾望指環","=q4=精靈貴族聖歌集","=q4=噬血剃刃","=q4=執政官裁決槌","=q4=瑪洛諾斯之握","=q4=原始本能支柱","=q4=奎爾薩拉斯金弓"})
Process("SPFelmyst",18,{"=q4=邊地要塞之握","=q4=不朽之夜護腿","=q4=永恆野獸護腿","=q4=劇烈暴風連結鎖鍊","=q4=性靈復原褶裙","=q4=精靈貴族的胸針","=q4=破劍者壁壘","=q4=大博學者的洪流之杖","","","","","","","","=q4=遺忘征服者長靴","=q4=遺忘保衛者長靴","=q4=遺忘防禦者長靴"})
Process("SPKalecgos",18,{"=q4=冷靜之擊窄褲","=q4=衝突滋長窄褲","=q4=自然侵略馬褲","=q4=自然光輝馬褲","=q4=星辰行者腿甲","=q4=神聖狂熱腿鎧","=q4=執法官腿甲","=q4=透明光柱指環","=q4=卡雷苟斯之牙","=q4=龍鱗鑲嵌長刃","","","","","","=q4=遺忘征服者護腕","=q4=遺忘保衛者護腕","=q4=遺忘防禦者護腕"})
Process("SPKiljaeden",30,{"=q4=無法寬恕之罪披風","=q4=安東尼達斯的破斗篷","=q4=光之純淨風帽","=q4=秘法純淨盔帽","=q4=黑暗咒術師頭帶","=q4=黎明手甲","=q4=泰利之力手套","=q4=褻瀆諸界手甲","=q4=欺瞞偽裝","=q4=狂怒獵人面具","=q4=睿智的厄索珥頭罩","=q4=強大的厄索克頭罩","=q4=艾蘭里亞罩盔","=q4=古爾丹風帽","=q4=耐祖奧酋長綸巾","=q4=薩拉斯遊俠護手","=q4=燃燒正義頭盔","=q4=烏瑟決心之盔","=q4=安納斯提安之冠","=q4=達斯雷瑪之冠","=q4=邊地疼痛之握","","=q5=索瑞達爾，眾星之怒","","=q4=天啟十字","=q4=亞玻萊昂，靈魂撕裂者","=q4=崇聖之錘","=q4=欺詐者之手","=q4=日耀焰光","=q4=辛多雷黃金之杖"})
Process("SPMuru",28,{"=q4=魔化征服者衣飾","=q4=衰退之光長袍","=q4=鬼魅仇恨長袍","=q4=日耀外衣","=q4=伊露恩的和諧外套","=q4=肉體本能背心","=q4=帶刃混沌外套","=q4=爆發暗影護手","=q4=森林漂泊者手套","=q4=平靜海岸服飾","=q4=崩解海岸服飾","=q4=兇惡陸行鷹鍊衫","=q4=狂莽之怒作戰背心","=q4=痛苦憎惡胸甲","=q4=平靜之魂護手","=q4=英雄執法官護胸","=q4=貴族執法官護胸","=q4=堅定決心之戒","=q4=全能之戒","=q4=辛多雷支配指環","=q4=辛多雷拯救指環","=q4=辛多雷凱旋指環","=q4=黑染的那魯稜片","=q4=微光的那魯稜片","=q4=移形的那魯稜片","=q4=鋼鐵的那魯稜片","=q4=村正","=q4=天使命運聖禦盾"})
Process("SPPatterns",29,{"=q4=圖樣:太陽皮甲護手","=q4=圖樣:太陽皮甲護胸","=q4=圖樣:鳳凰弓匠手套","=q4=圖樣:鳳凰之擁","=q4=圖樣:不朽之暮手套","=q4=圖樣:日與影之殼","=q4=圖樣:沁日鱗甲手套","=q4=圖樣:沁日鱗甲護胸","=q4=圖樣:日炎裹手","=q4=圖樣:日炎長袍","=q4=圖樣:永恆之光手套","=q4=圖樣:永恆之光長袍","=q4=設計圖:鍛能戒環","=q4=設計圖:日炎墜飾","=q4=設計圖:流動生命戒指","=q4=設計圖:流動生命護符","=q4=設計圖:特硬克銀指環","=q4=設計圖:特硬克銀頸飾","=q4=結構圖:殲滅者環視鏡","=q4=結構圖:正義使者3000眼鏡","=q4=結構圖:能量治癒9000鏡片","=q4=結構圖:超放大月光眼鏡","=q4=結構圖:奇跡治癒XT68遮光鏡","=q4=結構圖:原始調和護目鏡","=q4=結構圖:閃電蝕刻眼鏡","=q4=結構圖:絕對打擊護目鏡v3.0","=q4=結構圖:暴行投影護目鏡","=q4=結構圖:特硬克銀護目鏡","=q4=結構圖:四倍死亡打擊X44護目鏡"})
Process("SPTrash",26,{"=q4=寧靜威嚴裹帶","=q4=寧靜月光裹帶","=q4=上古暗月護手","=q4=上古霜狼護手","=q4=和諧之美戒指","=q4=粉碎魔脊","=q4=報復展開","=q4=生命的必然性之刃","=q4=淨化之光魔杖","=q4=惡魔之魂魔杖","","=q3=高級熔煉論文","","=q3=太陽微粒","","=q4=蒼穹藍寶石","=q4=焚石","=q4=獅眼石","=q4=海泉綠寶石","=q4=影歌紫水晶","=q4=赤紅尖晶石","","=q4=設計圖:太陽祝福護手","=q4=設計圖:太陽祝福胸甲","=q4=設計圖:特硬克銀戰拳","=q4=設計圖:特硬克銀戰甲"})
Process("TKArcDalliah",7,{"=q4=圖樣:白癒便褲","","=q3=世界之火護胸","=q3=薩堤亞自我懲戒護手","=q3=安寧和祥提燈","=q3=反射之刃","=q3=虛空核心之支配魔棒"})
Process("TKArcDalliahHEROIC",11,{"=q4=正義徽章","=q4=致命的火焰蛋白石","=q4=靈巧火焰蛋白石","=q4=持久火焰蛋白石","=q4=圖樣:白癒便褲","","=q3=世界之火護胸","=q3=薩堤亞自我懲戒護手","=q3=安寧和祥提燈","=q3=反射之刃","=q3=虛空核心之支配魔棒"})
Process("TKArcHarbinger",21,{"=q3=金邊符印之靴","=q3=流動思慮頸飾","=q3=源質哨兵指環","=q3=薩法爾之奈薩斯號角","=q3=安寧光輝提燈","=q3=飢餓裂脊匕首","","","","","","","","","","=q3=失落兜帽","=q3=神聖儀祭之冠","=q3=暗殺頭盔","=q3=惡潮護軀","=q3=末日戰甲護胸","=q3=勇猛胸甲"})
Process("TKArcHarbingerHEROIC",25,{"=q4=正義徽章","=q4=墮落腰帶","=q4=暗影足跡行者之靴","=q4=尊嚴護腕","=q4=背叛者之邪惡短刃","","=q3=金邊符印之靴","=q3=流動思慮頸飾","=q3=源質哨兵指環","=q3=薩法爾之奈薩斯號角","=q3=安寧光輝提燈","=q3=飢餓裂脊匕首","","=q1=史蓋力司卷軸","","=q4=致命的火焰蛋白石","=q4=靈巧火焰蛋白石","=q4=持久火焰蛋白石","","=q3=失落兜帽","=q3=神聖儀祭之冠","=q3=暗殺頭盔","=q3=惡潮護軀","=q3=末日戰甲護胸","=q3=勇猛胸甲"})
Process("TKArcScryer",5,{"=q3=解放手套","=q3=沉睡之索","=q3=雷恩寇的精妙指環","=q3=光明灌注戰槌","=q3=餘燼鷹之弩"})
Process("TKArcScryerHEROIC",10,{"=q4=正義徽章","=q4=致命的火焰蛋白石","=q4=靈巧火焰蛋白石","=q4=持久火焰蛋白石","","=q3=解放手套","=q3=沉睡之索","=q3=雷恩寇的精妙指環","=q3=光明灌注戰槌","=q3=餘燼鷹之弩"})
Process("TKArcThirdFragmentGuardian",1,{"=q1=第三塊鑰匙碎片"})
Process("TKArcTrash",5,{"=q3=設計圖:魔鋼護腿","","=q2=公式:附魔雙手武器 - 極效敏捷","=q2=圖樣:烈焰護甲片","=q2=圖樣:奧紋護腕"})
Process("TKArcUnbound",5,{"=q3=閃爍光環披風","=q3=法力氛圍肩衛","=q3=外域行者之靴","=q3=燃石戰鬥束腰","=q3=野獸暗影塑像"})
Process("TKArcUnboundHEROIC",10,{"=q4=正義徽章","=q4=致命的火焰蛋白石","=q4=靈巧火焰蛋白石","=q4=持久火焰蛋白石","","=q3=閃爍光環披風","=q3=法力氛圍肩衛","=q3=外域行者之靴","=q3=燃石戰鬥束腰","=q3=野獸暗影塑像"})
Process("TKBotFreywinn",11,{"=q3=能量裹臂","=q3=黑曜石無情踏靴","=q3=附魔瑟銀項鍊","=q3=暴掠戰刃","=q3=太陽鳥聖禦盾","","=q3=設計圖:大地和平胸甲","","=q2=紅色冬帽","","=q1=植物學家的野地指南"})
Process("TKBotFreywinnHEROIC",18,{"=q4=正義徽章","=q4=粗暴的丹泉石","=q4=帝國丹泉石","=q4=神秘火焰蛋白石","","=q3=能量裹臂","=q3=黑曜石無情踏靴","=q3=附魔瑟銀項鍊","=q3=暴掠戰刃","=q3=太陽鳥聖禦盾","","=q2=紅色冬帽","","","","=q3=設計圖:大地和平胸甲","","=q1=植物學家的野地指南"})
Process("TKBotLaj",16,{"=q3=深綠秘銀披風","=q3=惡魔縫製護腿","=q3=秋天披肩","=q3=流沙之靴","","","","","","","","","","","","=q3=公正肩甲"})
Process("TKBotLajHEROIC",16,{"=q4=正義徽章","=q4=粗暴的丹泉石","=q4=帝國丹泉石","=q4=神秘火焰蛋白石","","=q3=深綠秘銀披風","=q3=惡魔縫製護腿","=q3=秋天披肩","=q3=流沙之靴","","","","","","","=q3=公正肩甲"})
Process("TKBotSarannis",7,{"=q3=薩瑞尼斯謎樣的華服","=q3=修補稜彩手套","=q3=巡狩卓越披肩","=q3=光明使者聖契","=q3=復仇者","","=q1=拱心石"})
Process("TKBotSarannisHEROIC",10,{"=q4=正義徽章","=q4=粗暴的丹泉石","=q4=帝國丹泉石","=q4=神秘火焰蛋白石","","=q3=薩瑞尼斯謎樣的華服","=q3=修補稜彩手套","=q3=巡狩卓越披肩","=q3=光明使者聖契","=q3=復仇者"})
Process("TKBotSplinter",20,{"=q4=圖樣:白癒兜帽","","=q3=虛空之怒斗篷","=q3=曲能灌注外衣","=q3=扭曲鱗片護腿","=q3=鋸齒青褐墜飾","=q3=無盡祝福手鐲","=q3=扭曲分裂者之刺","=q3=遺棄者幻象之劍","=q3=秘法之扭曲法杖","","=q1=亞克崔茲鑰匙的頂部裂片","","","","=q3=魔法使的長袍","=q3=月光林地風帽","=q3=惡潮頭盔","=q3=野獸之王胸衣","=q3=勇猛頭盔"})
Process("TKBotSplinterHEROIC",27,{"=q4=正義徽章","=q4=伊斯利操作之靴","=q4=無盡狩獵之靴","=q4=分歧護手","=q4=鞭叱之野性法杖","=q4=圖樣:白癒兜帽","","=q3=虛空之怒斗篷","=q3=曲能灌注外衣","=q3=扭曲鱗片護腿","=q3=鋸齒青褐墜飾","=q3=無盡祝福手鐲","=q3=扭曲分裂者之刺","=q3=遺棄者幻象之劍","=q3=秘法之扭曲法杖","=q4=粗暴的丹泉石","=q4=帝國丹泉石","=q4=神秘火焰蛋白石","","=q3=魔法使的長袍","=q3=月光林地風帽","=q3=惡潮頭盔","=q3=野獸之王胸衣","=q3=勇猛頭盔","","=q1=亞克崔茲鑰匙的頂部裂片","=q1=扭曲分裂者的剪枝"})
Process("TKBotThorngrin",7,{"=q4=圖樣:戰放便褲","","=q3=殘酷意念護手","=q3=秘法虛空指環","=q3=陰影厄運之戒","=q3=符文撫慰匕首","=q3=睡夢龍杖"})
Process("TKBotThorngrinHEROIC",11,{"=q4=正義徽章","=q4=粗暴的丹泉石","=q4=帝國丹泉石","=q4=神秘火焰蛋白石","=q4=圖樣:戰放便褲","","=q3=殘酷意念護手","=q3=秘法虛空指環","=q3=陰影厄運之戒","=q3=符文撫慰匕首","=q3=睡夢龍杖"})
Process("TKBotTrash",1,{"=q4=設計圖:翠綠之火頭冠"})
Process("TKEyeAlar",19,{"=q4=鳳凰之翼披風","=q4=心靈風暴腕環","=q4=灼熱掌握手套","=q4=火羽胸甲","=q4=歐爾指環","=q4=重生鳳凰之翼","=q4=歐爾之爪","=q4=火焰救贖寶典","=q4=太陽之王護符","","","","","","","=q4=鳳凰之爪","=q4=鳳凰之掌","=q4=虛空死亡之斧","=q4=奧金蒸汽手槍"})
Process("TKEyeKaelthas",28,{"=q4=逐日者皇家披風","=q4=浴陽光明披風","=q4=薩拉斯迷霧披風","=q4=太陽王冠","=q4=太陽之王護手","=q4=致命意圖護腿","=q4=太陽之鷹護腿","=q4=銀月皇家護手","=q4=遊俠領袖指環","=q4=鳳凰之雙刃劍","=q4=太陽之王權杖","=q4=奈薩斯關鍵法杖","","","","=q4=征服勇士護胸","=q4=征服防衛者護胸","=q4=征服英雄護胸","","=q4=歐爾灰燼","","=q4=嫩綠球體","=q4=桑古納爾領主的頸鏈","=q4=泰隆尼卡斯的暴行墜飾","=q4=晦暗者之握","=q4=太陽之王的墜飾","","=q1=凱爾薩斯的殘存之瓶"})
Process("TKEyeLegendaries",8,{"=q5=無盡之刃","=q5=扭曲分割者","=q5=宇宙灌溉者","=q5=毀滅","=q5=瓦解之杖","=q5=相位壁壘","=q5=虛空之絃長弓","=q5=虛空之刺"})
Process("TKEyeSolarian",20,{"=q4=星靈馬褲","=q4=星術師長褲","=q4=終末臂鎧","=q4=世界風暴護手","=q4=逐星者之靴","=q4=正道束腰","=q4=血守衛護脛","=q4=彈力之靴","","","","","","","","=q4=索拉瑞恩藍寶石","=q4=虛無之星飾物","=q4=撕心匕首","=q4=伊斯利恩生命法杖","=q4=被遺忘之星魔杖"})
Process("TKEyeTrash",27,{"=q4=精靈王披肩","=q4=魔導師火焰之索","=q4=古老智慧的樹皮手套","=q4=神聖射手手環","=q4=殞星束腰","=q4=堤里斯佛倫之第七指環","","=q4=設計圖:紅色浩劫長靴","=q4=設計圖:紅色戰鬥腰帶","=q4=設計圖:保衛者之靴","=q4=設計圖:守衛者腰帶","=q4=圖樣:衝擊腰帶","=q4=圖樣:衝擊之靴","=q4=圖樣:長路之靴","=q4=圖樣:長路腰帶","=q4=圖樣:颶風長靴","=q4=圖樣:季風腰帶","=q4=圖樣:自然之擁之靴","=q4=圖樣:紅鷹之靴","=q4=圖樣:絕對黑暗之靴","=q4=圖樣:自然之力腰帶","=q4=圖樣:黑鷹腰帶","=q4=圖樣:暗影深淵腰帶","","=q4=虛空漩渦","","=q2=伊利達瑞的印記"})
Process("TKEyeVoidReaver",18,{"=q4=大工程師風帽","=q4=札爾塔束腰","=q4=虛無搶奪者護脛","=q4=魔鋼戰爭頭盔","=q4=果決腕甲","=q4=惡魔搶奪者活塞","=q4=扭曲彈簧線圈","","","","","","","","","=q4=征服勇士肩鎧","=q4=征服防衛者肩鎧","=q4=征服英雄肩鎧"})
Process("TKMechCacheoftheLegion",7,{"=q4=正義徽章","","=q3=卡帕希特斯的測定披風","=q3=維斯提亞之精神恩典肩鎧","=q3=殲滅血長袍","=q3=持劍者之靴","=q3=虛無圖騰"})
Process("TKMechCalc",20,{"=q3=巴巴的秘法披風","=q3=熔岩大地褶裙","=q3=達斯雷瑪防禦之戒","=q3=暴力機會算盤","=q3=神力之怒","=q3=寰宇邊際之鋒","=q3=望遠鏡刺耳火槍","","=q2=圖樣:奧紋長袍","","=q1=亞克崔茲鑰匙的底部裂片","","","","","=q3=魔法使的風帽","=q3=月光林地長袍","=q3=暗殺外套","=q3=野獸之王頭盔","=q3=公正頭盔"})
Process("TKMechCalcHEROIC",27,{"=q4=正義徽章","=q4=虔誠之靴","=q4=穩固手甲","=q4=征服者腿鎧","=q4=食日者","","=q3=巴巴的秘法披風","=q3=熔岩大地褶裙","=q3=達斯雷瑪防禦之戒","=q3=暴力機會算盤","=q3=神力之怒","=q3=寰宇邊際之鋒","=q3=望遠鏡刺耳火槍","","=q2=圖樣:奧紋長袍","=q4=刺客的火焰蛋白石","=q4=防衛者的丹泉石","=q4=閃亮火焰蛋白石","","=q3=魔法使的風帽","=q3=月光林地長袍","=q3=暗殺外套","=q3=野獸之王頭盔","=q3=公正頭盔","","=q1=帕薩里歐的投映器","=q1=亞克崔茲鑰匙的底部裂片"})
Process("TKMechCapacitus",7,{"=q3=瑟銀編織披風","=q3=月爪肩鎧","=q3=星移工程師之稜彩項鍊","=q3=懺悔之錘","=q3=漿鼠超長鐮刀","","=q3=結構圖:輕巧型火箭靴極限版"})
Process("TKMechCapacitusHEROIC",12,{"=q4=正義徽章","=q4=刺客的火焰蛋白石","=q4=防衛者的丹泉石","=q4=閃亮火焰蛋白石","","=q3=瑟銀編織披風","=q3=月爪肩鎧","=q3=星移工程師之稜彩項鍊","=q3=懺悔之錘","=q3=漿鼠超長鐮刀","","=q3=結構圖:輕巧型火箭靴極限版"})
Process("TKMechGyro",1,{"=q1=藍色鋸齒水晶"})
Process("TKMechIron",1,{"=q1=紅色鋸齒水晶"})
Process("TKMechOverchargedManacell",1,{"=q1=滿溢的法力容器"})
Process("TKMechSepethrea",9,{"=q3=玉顱胸甲","=q3=宇宙生命指環","=q3=虛空術師寶典","=q3=星斧","=q3=虛空飛鏢","","=q2=紅色冬帽","","=q2=配方:極效火焰防護藥水"})
Process("TKMechSepethreaHEROIC",14,{"=q4=正義徽章","=q4=刺客的火焰蛋白石","=q4=防衛者的丹泉石","=q4=閃亮火焰蛋白石","","=q3=玉顱胸甲","=q3=宇宙生命指環","=q3=虛空術師寶典","=q3=星斧","=q3=虛空飛鏢","","=q2=紅色冬帽","","=q2=配方:極效火焰防護藥水"})
Process("TKMechTrash",2,{"=q2=配方:極效火焰防護藥水","=q2=圖樣:奧紋長靴"})
Process("ZAAkilZon",10,{"=q4=正義徽章","=q4=魔精修補者面具","=q4=血染的精靈戰鬥外衣","=q4=隱匿意圖護胸","=q4=自然仁慈胸針","=q4=上古魔法徽記","=q4=阿奇爾森的爪刃","=q4=阿曼尼懲戒之錘","","=q3=公式:附魔武器 - 處決者"})
Process("ZAHalazzi",10,{"=q4=正義徽章","=q4=過往靈魂之袍","=q4=刃舞肩墊","=q4=閃光毛皮外衣","=q4=雪崩護腿","=q4=擁護者肩甲","=q4=碎顱戰靴","=q4=野蠻頸飾","","=q3=公式:附魔武器 - 處決者"})
Process("ZAJanAlai",10,{"=q4=正義徽章","=q4=瘋狂薄靴","=q4=自然再生頭盔","=q4=影牙食人妖皮胸衣","=q4=箭墜護胸","=q4=烏伯的詛咒妖術刃","=q4=阿曼尼帝國壁壘","=q4=魔精琺瑯碟","","=q3=公式:附魔武器 - 處決者"})
Process("ZAMalacrass",22,{"=q4=正義徽章","=q4=遠古儀式披風","=q4=妖術兜帽","=q4=第三眼兜帽","=q4=叢林獵捕者罩盔","=q4=妖術領主的巫毒肩鎧","=q4=鬥爭牙衛","=q4=激流堡希望束腰","","=q3=公式:附魔武器 - 處決者","","","","","","=q4=妖術皺縮人頭","=q4=小巫毒面具","=q4=惡魔治療典籍","=q4=壞魔精之匕","=q4=徘徊者擊刃","=q4=冷酷無心","=q4=原初狂怒法杖"})
Process("ZANalorakk",10,{"=q4=正義徽章","=q4=天堂意志之袍","=q4=熊族之怒","=q4=劍刃天使的金錢腰帶","=q4=原初狂怒肩鎧","=q4=反省面具","=q4=叢林踏靴","=q4=狂怒","","=q3=公式:附魔武器 - 處決者"})
Process("ZATimedChest",25,{"","=q4=惡魔披風","=q4=暗影施法者披氅","=q4=邪惡意圖披肩","=q4=食人妖髮辮之索","=q4=生命步履腰帶","=q4=月神韌化護腿","=q4=暗影獵手足靴","=q4=堅石決心肩鎧","","=q4=法力同調指環","=q4=永恆生命的徽記","=q4=原始之怒徽記","=q4=最終防衛者的徽記","=q4=沉靜森林徽記","","=q4=暴怒","=q4=陰影剃刃","=q4=食人妖剋星","=q4=黑暗修補之杖","=q4=阿曼尼預言法杖","=q4=碎牙者","","","=q4=阿曼尼戰熊"})
Process("ZATrash",7,{"=q3=莫巧","","=q2=阿曼尼妖術短棍","=q2=阿曼尼放血者符咒","=q2=阿曼尼巫醫符咒","=q2=阿曼尼強力魔精符咒","=q2=阿曼尼狂怒防衛者符咒"})
Process("ZAZuljin",22,{"=q4=正義徽章","=q4=兩趾便鞋","=q4=邪笑面甲","=q4=帝國勇士鍊衫","=q4=督軍護胸","=q4=詛咒骸骨迴圈","=q4=上古亞基神器","=q4=狂戰士的吶喊","","=q3=公式:附魔武器 - 處決者","","","","","","=q4=扭曲幻象之刃","=q4=金羅克，偉大的天啟之劍","=q4=難恕斬斧","=q4=黑暗祝福","=q4=上古阿曼尼長弓","","=q4=祖爾金之血"})
end