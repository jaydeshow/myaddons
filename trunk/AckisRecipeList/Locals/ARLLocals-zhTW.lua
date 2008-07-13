--[[
****************************************************************************************

ARLLocals-zhTW.lua

zhTW localization strings for Ackis Recipe List

$Date: 2008-07-11 13:55:14 -0400 (Fri, 11 Jul 2008) $
$Rev: 78247 $

Original translated by: iCat (msn: lucifer_icat@hotmail.com)
Currently maintaince by: apa1102, zhucc

Thank you all translators! (From Ackis)

Please make sure you update the ToC file with any translations.

ToC needs translation update for Notes please. (remove this if it's done)

****************************************************************************************
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Ackis Recipe List", "zhTW", false);
if not L then return end

-- Addon Info
L["Version"] = "版本："

-- Options Categories
L["Display"] = "顯示"
L["DISPLAY_OPTIONS"] = "顯示選項"
L["DISPLAY_OPTIONS_LONG"] = "允許你自訂圖形介面的顯示。"
L["Filter"] = "過濾"
L["FILTER_OPTIONS"] = "過濾選項"
L["FILTER_OPTIONS_LONG"] = "允許你自訂要過濾哪些配方。"
L["Reputation"] = "聲望"
L["REP_OPTIONS"] = "聲望選項"
L["REP_OPTIONS_LONG"] = "允許你自訂要在掃瞄裡包含哪些聲望。"
L["Obtain"] = "取得"
L["OBTAIN_OPTIONS"] = "取得選項"
L["OBTAIN_OPTIONS_LONG"] = "允許你自訂要在掃瞄裡包含哪些取得方式。"
L["Sort"] = "排序"
L["SORT_OPTIONS"] = "排序選項"
L["SORT_OPTIONS_LONG"] = "允許你自訂如何排序及顯示所缺少的配方。"
L["Profile"] = "設定檔"

-- Display Options
L["Use GUI"] = "使用圖形介面"
L["GUI_TOGGLE"] = "開/關使用圖形介面。"
L["Include Filtered"] = "包含已過濾"
L["FILTERCOUNT_TOGGLE"] = "把過濾的配方包含在總共配方的數目中。"
L["Close GUI"] = "關閉圖形介面"
L["CLOSEGUI_TOGGLE"] = "當交易技能視窗關閉也同時關閉ARL視窗。"

-- Filtering Options
L["Faction"] = "陣營"
L["FACTION_TOGGLE"] = "掃瞄中同時包含部落及聯盟的陣營配方。"
L["Classes"] = "職業"
L["CLASS_TOGGLE"] = "掃瞄中包含擁有職業限定的配方。"
L["Specialities"] = "技能專業"
L["SPECIALITY_TOGGLE"] = "掃瞄中包含所有交易技能專業技能。"
L["Skill"] = "技能"
L["SKILL_TOGGLE"] = "包含所有配方，而不管你當前的技能等級是多少。"

-- Obtain Filter Options
L["BOEFilter"] = "裝備後綁定"
L["BOE_TOGGLE"] = "掃瞄中包含裝備後綁定的配方。"
L["BOPFilter"] = "拾取後綁定"
L["BOP_TOGGLE"] = "掃瞄中包含拾取後綁定的配方。"
L["PVP_TOGGLE"] = "掃瞄中包含通過PvP途徑獲得的配方。"
L["RAID_TOGGLE"] = "掃瞄中包含那些很難獲得（只能在團隊副本中獲得）的配方。"
L["SEASONAL_TOGGLE"] = "在該掃瞄裡包含節日活動所獲取的配方。"
L["TRAINER_TOGGLE"] = "掃瞄中包含訓練師的配方。"
L["VENDOR_TOGGLE"] = "掃瞄中包含商人的配方。"
L["INSTANCE_TOGGLE"] = "掃瞄中包含副本取得的配方。"
L["QUEST_TOGGLE"] = "掃瞄中包含任務獎勵的配方。"
L["Cloth"] = "布衣"
L["CLOTH_TOGGLE"] = "掃瞄中包含製造出布衣物品的配方。"
L["Leather"] = "皮甲"
L["LEATHER_TOGGLE"] = "掃瞄中包含製造出皮甲物品的配方。"
L["Mail"] = "鎖甲"
L["MAIL_TOGGLE"] = "掃瞄中包含製造出鎖甲物品的配方。"
L["Plate"] = "鎧甲"
L["PLATE_TOGGLE"] = "掃瞄中包含製造出鎧甲物品的配方。"
L["Melee"] = "物理輸出"
L["MELEE_TOGGLE"] = "掃瞄中包含用於物理輸出的配方。"
L["Caster DPS"] = "法術輸出"
L["CASTERDPS_TOGGLE"] = "掃瞄中包含用於法術輸出的配方。"
L["Tanking"] = "坦克"
L["TANKING_TOGGLE"] = "掃瞄中包含用於坦克的配方。"
L["Healing"] = "治療"
L["HEALING_TOGGLE"] = "掃瞄中包含用於治療的配方。"

-- Sorting options
L["Name"] = "名稱"
L["Skill"] = "技能"
L["Aquisition"] = "獲取"

-- Reputation Toggles
L["SPECIFIC_REP_TOGGLE"] = "包含%s陣營。"

-- Non-gui text
L["MissingFromDB"] = "：不在外掛程式的數據庫中。\n請將該配方的訊息提供給作者，謝謝。"
L["MissingRecipePrefix"] = "遺漏： "
L["InitiateScan"] = "在%s[ %s ]中掃瞄遺漏的配方。\n"
L["InitiateScanSpecial"] = "在%s - %s[ %s ]中掃瞄遺漏的配方。\n"
L["RecipeListSummary"] = "\n已經學會 %s 個，總數 %s 個 (%s%%)\n遺漏了 %s 個配方。"
L["UnknownTradeSkill"] = "您打開了一個外掛程式不支援的交易技能視窗。這個交易技能外掛程式是 %s 。請向作者提供該訊息，謝謝。"
L["OpenTradeSkillWindow"] = "請先打開一個想要掃瞄的交易技能。"

-- GUI Text
L["Close"] = "關閉"
L["ScanButton"] = "掃瞄配方"
L["Scan Skills"] = "掃瞄"
L["FILTER_OPEN"] = "過濾 >>>"
L["FILTER_CLOSE"] = "<<< 過濾"
L["Reset"] = "重置"
L["Sort"] = "排序"
L["World Drop"] = "世界掉落"
L["Mob Drop"] = "怪物掉落"
L["Quest"] = "任務"
L["Reputation"] = "聲望"
L["Instance"] = "副本"
L["BoPMenu"] = "拾取後綁定"
L["Horde"] = "部落" 
L["Alliance"] = "聯盟"
L["Known"] = "已知"
L["Unknown"] = "未知"

-- Tooltip Text
L["Scan Skills Long"] = "使用Ackis Recipe List掃瞄遺漏的配方。"
L["Close Window"] = "關閉ARL視窗。"
L["Expand All"] = "展開所有的配方。"
L["Collapse All"] = "折疊所有的配方。"
L["FILTER_OPEN_TT"] = "打開過濾選項面板。"
L["FILTER_CLOSE_TT"] = "關閉過濾選項面板。"
L["RESET_TT"] = "重置搜尋的關鍵字。"
L["SORT_TT"] = "更改清單的排列順序。"
L["VENDOR_TT"] = "選取後在列表中包含商人出售的配方。"
L["TRAINER_TT"]= "選取後在列表中包含訓練師可學的配方。"
L["WORLD_TT"] = "選取後在列表中包含世界掉落的配方。"
L["MOB_TT"] = "選取後在列表中包含怪物掉落的配方。"
L["QUEST_TT"] = "選取後在列表中包含任務獎勵的配方。"
L["SEASON_TT"] = "選取後在列表中包含節日活動才出現的配方。"
L["REP_TT"] = "選取後在列表中包含聲望獎勵的配方。"
L["INSTANCE_TT"] = "選取後在列表中包含副本掉落的配方。"
L["BOP_TT"] = "選取後在列表中包含拾取綁定的配方。"
L["HORDE_TT"] = "選取後在列表中包含部落獨有的配方。"
L["ALLIANCE_TT"] = "選取後在列表中包含聯盟獨有的配方。"
L["KNOWN_TT"] = "選取後在列表中包含已知配方。"
L["UNKNOWN_TT"] = "選取後在列表中包含未知配方。"

-- Recipe Database
L["Trainer"] = "訓練師"
L["LimitedSupply"] = "限量供應"
L["Vendor"] = "商人"
L["Discovery"] = "發現"
L["PVP"] = "PvP"
L["Raid"] = "團隊"

--Skillup Levels
L["Journeyman"] = "中級"
L["Expert"] = "高級"
L["Artisan"] = "專家級"
L["Master"] = "大師級"

-- Common ways to obtain recipes
L["UZD"] = "區域掉落 - 優秀："
L["CWD"] = "世界掉落 - 一般："
L["UWD"] = "世界掉落 - 優秀："
L["RWD"] = "世界掉落 - 精良："
L["EWD"] = "世界掉落 - 史詩："
L["BoE"] = "裝備後綁定掉落："
L["BoP"] = "拾取後綁定掉落："
L["QuestReward"] = "任務獎勵："

-- Common quests/drops
L["DMCACHE"] = "諾特·希姆加克的箱子"
L["Gordok Ogre Suit"] = "戈多克巨魔裝"
L["Gordok Ogre Suit Obt"] = "任務獎勵：戈多克巨魔裝"
L["Spectral Essence Obt"] = "任務獎勵：傳令官基爾圖諾斯 (能讓你能看到通靈學院附近的商人瑪格努斯·霜鳴)"
L["TrueBelieverQuest"] = "任務獎勵：真實信仰者 - 從被解譯的《真實信仰者》剪報中稀有掉落"

-- Raid Drop Obtain Info
L["ADNaxx"] = "從納克薩瑪斯死亡騎士區的工匠大師歐瑪利安學到"
L["MOLTENCORE"] = "團隊拾取後綁定：熔火之心首領隨機掉落"
L["AQ20/AQ40"] = "團隊拾取後綁定：安其拉廢墟/安其拉神廟首領隨機掉落"
L["SSC/TKBoP"] = "團隊拾取後綁定：毒蛇神殿/風暴要塞隨機掉落"
L["SSC/TKBoE"] = "團隊裝備後綁定：毒蛇神殿/風暴要塞隨機掉落"
L["BT/HYJALBoP"] = "團隊拾取後綁定：海加爾/黑暗神廟隨機掉落"
L["HYJALBoP"] = "團隊拾取後綁定：海加爾首領隨機掉落"
L["SunwellBoP"] = "團隊拾取後綁定：太陽之井隨機掉落"
L["SunwellBoE"] = "團隊裝備後綁定：太陽之井隨機掉落"
L["BT/HYJALBoE"] = "團隊裝備後綁定：海加爾/黑暗神廟隨機掉落"
L["ZA"] = "團隊拾取後綁定：祖阿曼首領隨機掉落"
L["Unknown"] = "該配方掉落來源未知，你可以於 www.wowace.com/forums 論壇中Ackis Recipe List的官方帖中幫助提供掉落訊息。"

-- Faction info
L["WintersVeil"] = "冬幕節"
L["Lunar Festival"] = "春節"
L["Darkmoon Faire"] = "暗月馬戲團"
L["Seasonal"] = "週期性節日"

-- Alchemy Obtain Information
L["Discovery - Flasks/Potions"] = "發現 - 精煉/藥劑"
L["Discovery - Protection Potions"] = "發現 - 守護藥劑"
L["Discovery - Transmutes"] = "發現 - 轉化"
L["Goblin Rocket Fuel Obt"] = "製造：這個配方是哥布林工程師製作出來的"
L["Gurubashi Mojo Madness Obt"] = "團隊：你可以在祖爾格拉布的瘋狂之緣裡點石頭學到"
L["Mighty Trolls Blood Potion Obt"] = "訓練師：剃刀高地的亨利·斯特恩"
-- Mob Drop
L["Elixir of Greater Firepower Obt"] = "黑鐵奴隸販子，黑鐵巡邏兵，黑鐵監工"
L["Elixir of the Mongoose Obt"] = "費伍德森林：碧火盜賊，艾薩拉：雷加斯盜賊"
L["Elixir of the Sages Obt"] = "東瘟疫之地：血色附魔師，血色宣教士，血色助理牧師，血色大法師，血色審查官"
L["Fel Mana Potion Obt"] = "影月谷：伊克利普森士兵，伊克利普森血守衛，伊克利普森血騎士，伊克利普森縛法者，伊克利普森大法師，伊克利普森百夫長，伊克利普森騎士，托洛斯莊嚴者，伊利達瑞看守者"
L["Fel Regeneration Potion Obt"] = "影月谷：死亡熔爐小鬼，死亡熔爐守護者，死亡熔爐鐵匠，死亡熔爐技工"
L["Fel Strength Elixir Obt"] = "影月谷：莫阿格武器鐵匠，恐懼大師，怒行者，暗影議會術士"
L["Gift of Arthas Obt"] = "西瘟疫之地：骷髏撕掠者，被奴役的食屍鬼"
L["Greater Arcane Protection Potion Obt"] = "冬泉谷：深藍色龍人法師"
L["Greater Fire Protection Potion Obt"] = "黑石塔(下)：火印塑能師，火印炎術師"
L["Greater Frost Protection Potion Obt"] = "冬泉谷：霜槌巨人"
L["Greater Nature Protection Potion Obt"] = "西瘟疫之地：枯萎的恐獸，腐爛的巨獸"
L["Greater Shadow Protection Potion Obt"] = "東瘟疫之地：黑暗教徒，暗影法師"
L["Major Arcane Protection Potion Obt"] = "納葛蘭：梵安尼秘法師"
L["Major Fire Protection Potion Obt"] = "麥克那爾：尋日星法師"
L["Major Holy Protection Potion Obt"] = "劍刃山脈：冥淵火烈焰使者"
L["Major Shadow Protection Potion Obt"] = "影月谷：暗影議會術士"
L["Mighty Rage Potion Obt"] = "燃燒平原：黑石殺戮者"
L["Wildvine Potion Obt"] = "辛特蘭、荊棘谷：各種食人妖怪物"
-- Quest
L["Discolored Healing Potion Obt"] = "荒野之心"
L["Elixir of Brute Force Obt"] = "安戈洛環形山：達丹加餓了!(隨機獎勵)"
L["Lesser Stoneshield Potion Obt"] = "盧希恩的藥水"
L["Restorative Potion Obt"] = "奧達曼的蘑菇(自動學習)"
--Adds
--L["Major Frost Protection Potion Obt"] = "法力墓地：奈薩斯王子薩法爾"

-- Blacksmithin Obtain Information
L["Inlaid Mithril Cylinder Obt"] = "製造：這個配方是地精工程師製作出來的"
L["Blacksmithing Plans"] = "黑石深淵、斯坦索姆：鍛造配方物品隨機掉落"
-- Mob Drop
L["Dark Iron Sunderer Obt"] = "黑石深淵：持鐵錘的顧客，雷布裡的親信"
L["Felsteel Gloves Obt"] = "奧奇奈地穴：奧奇奈僧侶"
L["Felsteel Helm Obt"] = "暗影迷宮：卡巴狂熱者"
L["Felsteel Leggings Obt"] = "亞克崔茲：無束縛的摧毀者"
L["Frostguard Obt"] = "西瘟疫之地：工頭瑪希瑞德"
L["Greater Ward of Shielding Obt"] = "虛空風暴：日怒血守衛"
L["Khorium Belt Obt"] = "納葛蘭：黑暗之血劫掠者"
L["Khorium Boots Obt"] = "虛空風暴：虛實的保衛者"
L["Khorium Pants Obt"] = "影月谷：死亡熔爐守護者"
L["Ragesteel Breastplate Obt"] = "影月谷：灰舌戰士"
L["Ragesteel Gloves Obt"] = "納葛蘭：石拳戰士"
L["Ragesteel Helm Obt"] = "劍刃山脈：煉冶場守衛"
L["Ragesteel Shoulders Obt"] = "影月谷：暴怒的大地之靈，暴怒的風之靈，暴怒的火焰之靈，暴怒的水之靈"
L["Runic Breastplate Obt"] = "塵泥沼澤(奧卡茲島)：斯塔莎茲侍從"
L["Runic Plate Boots Obt"] = "西瘟疫之地：血色騎兵"
L["Runic Plate Helm Obt"] = "塵泥沼澤(奧卡茲島)：斯塔莎茲戰士"
L["Runic Plate Leggings Obt"] = "西瘟疫之地：血色鐵匠"
L["Runic Plate Shoulders Obt"] = "塵泥沼澤(奧卡茲島)：斯塔莎茲毒蛇守衛"
L["Swiftsteel Gloves Obt"] = "法力墓地：奈薩斯捕獵者"
L["Volcanic Hammer Obt"] = "燃燒平原：沃爾查"
-- Quest
L["Barbaric Iron Boots Obt"] = "踩在腳底下"
L["Barbaric Iron Breastplate Obt"] = "野人裝甲"
L["Barbaric Iron Gloves Obt"] = "沃姆什的喜悅"
L["Barbaric Iron Helm Obt"] = "瘋狂之角"
L["Barbaric Iron Shoulders Obt"] = "鐵肩鎧"
L["Blazing Rapier Obt"] = "腐蝕"
L["Dawn's Edge Obt"] = "沃許加斯的菊石"
L["Demon Forged Breastplate Obt"] = "惡魔熔爐"
L["Enchanted Battlehammer Obt"] = "甜美的平靜"
L["Enchanted Thorium Breastplate Obt"] = "附魔瑟銀鎧甲:第一卷"
L["Enchanted Thorium Helm Obt"] = "附魔瑟銀鎧甲:第三卷"
L["Enchanted Thorium Leggings Obt"] = "附魔瑟銀鎧甲:第二卷"
L["Fiery Plate Gauntlets Obt"] = "熾熱鎧甲護手"
L["Golden Scale Gauntlets Obt"] = "鍛造的起源"
L["Heavy Copper Longsword Obt"] = "前線的補給"
L["Imperial Plate Belt Obt"] = "君王鎧甲腰帶"
L["Imperial Plate Boots Obt"] = "君王鎧甲靴"
L["Imperial Plate Bracers Obt"] = "君王鎧甲護腕"
L["Imperial Plate Chest Obt"] = "君王鎧甲護胸"
L["Imperial Plate Helm Obt"] = "君王鎧甲頭盔"
L["Imperial Plate Leggings Obt"] = "君王鎧甲護腿"
L["Imperial Plate Shoulders Obt"] = "君王鎧甲護肩"
L["Ironforge Breastplate Obt"] = "支援赤脊山"
L["Orcish War Leggings Obt"] = "古老的技藝"
L["Ornate Mithril Gloves Obt"] = "白花花的銀子"
L["Ornate Mithril Helm Obt"] = "護甲鍛造師的藝術"
L["Ornate Mithril Pants Obt"] = "鐵匠必修課"
L["Ornate Mithril Shoulder Obt"] = "罩帽和護肩"
L["Sulfuron Hammer Obt"] = "一份必需遵守的契約"
--Adds
--L["Annihilator Obt"] = "裝綁：黑石塔(下)：裂盾軍需官"
--L["Arcanite Champion Obt"] = "裝綁：黑石塔(下)：古拉魯克"
--L["Arcanite Reaper Obt"] = "裝綁：黑石塔(下)：班諾克·巨斧"
--L["Black Grasp of the Destroyer Obt"] = "拾綁：安其拉廢墟：莫阿姆"
--L["Dark Iron Plate Obt"] = "裝綁：黑石深淵：雷布裡·斯庫比格特"
--L["Dark Iron Pulverizer Obt"] = "裝綁：黑石深淵：格裡茲爾"
--L["Earthpeace Breastplate Obt"] = "拾綁：波塔尼卡：大植物學家費瑞衛恩"
--L["Hammer of the Titans Obt"] = "裝綁：斯坦索姆：蒼白的瑪勒基"
--L["Heartseeker Obt"] = "裝綁：斯坦索姆：砲手威利"
--L["Invulnerable Mail Obt"] = "裝綁：黑石塔(上)：古拉魯克"
--L["Masterwork Stormhammer Obt"] = "裝綁：黑石塔(上)：古拉魯克"
--L["Thick Obsidian Breastplate Obt"] = "拾綁：安其拉廢墟：預言者斯克拉姆"

-- Cooking Obtain Information
L["Fishing Daily"] = "任務獎勵：釣魚每日任務隨機獎勵。"
L["Cooking Daily"] = "任務獎勵：烹飪每日任務隨機獎勵。"
L["Goldthorn Tea Obt"] = "與剃刀高地的亨利·斯特恩對話"
L["Stewed Trout Obt"] = "訓練師：凱歐妮"
-- Mob Drop
L["Runn Tum Tuber Surprise Obt"] = "普希林"
-- Quest
L["Barbecued Buzzard Wing Obt"] = "燒烤禿鷲翅膀"
L["Beer Basted Boar Ribs Obt"] = "啤酒烤豬排"
L["Big Bear Steak Obt"] = "拯救行動"
L["Blood Sausage Obt"] = "塞爾薩瑪血腸"
L["Buzzard Bites Obt"] = "技術高超"
L["Crocolisk Gumbo Obt"] = "學徒的職責"
L["Crocolisk Steak Obt"] = "捕獵鱷魚"
L["Crunchy Serpent Obt"] = "摩克納薩爾的款待"
L["Crunchy Spider Surprise Obt"] = "香脆料理"
L["Curiously Tasty Omelet Obt"] = "奧莫爾的復仇"
L["Dig Rat Stew Obt"] = "掘地鼠燉肉"
L["Dirge's Kickin' Chimaerok Chops Obt"] = "迪爾格的超美味奇美拉肉片"
L["Gooey Spider Cake Obt"] = "黑蟹蛋糕"
L["Goretusk Liver Pie Obt"] = "豬肝餡餅"
L["Hot Lion Chops Obt"] = "痛苦藥劑"
L["Kaldorei Spider Kabob Obt"] = "卡多雷的食譜"
L["Murloc Fin Soup Obt"] = "賣魚"
L["Redridge Goulash Obt"] = "赤脊山燉肉"
L["Roasted Moongraze Tenderloin Obt"] = "獵捕牧月成鹿"
L["Seasoned Wolf Kabob Obt"] = "烤狼肉串"
L["Smoked Desert Dumplings Obt"] = "沙漠食譜"
L["Soothing Turtle Bisque Obt"] = "海龜湯"
L["Strider Stew Obt"] = "燉陸行鳥"
L["Tasty Lion Steak Obt"] = "損失慘重"
L["Thistle Tea Ally Obt"] = "克拉文之塔"
L["Thistle Tea Horde Obt"] = "任務：基本不可能的任務"
L["Westfall Stew Obt"] = "雜味燉肉"

-- Enchanting Obtain Information
L["Enchant 2H Weapon - Major Agility Obt"] = "埃雷達爾死亡召喚者"
L["Enchant 2H Weapon - Major Intellect Obt"] = "紅衣巫士"
L["Enchant 2H Weapon - Major Spirit Obt"] = "通靈學院專家"
L["Enchant 2H Weapon - Savagery Obt"] = "破碎之手百夫長"
L["Enchant 2H Weapon - Superior Impact Obt"] = "黑手精英"
L["Enchant Boots - Dexterity Obt"] = "狂怒的骷髏"
L["Enchant Boots - Fortitude Obt"] = "伊斯利牧師"
L["Enchant Boots - Surefooted Obt"] = "魅影舞臺助手"
L["Enchant Bracer - Fortitude Obt"] = "盤牙神諭者"
L["Enchant Bracer - Major Defense Obt"] = "伊斯利恩淨化者"
L["Enchant Bracer - Spellpower Obt"] = "血槌地卜師"
L["Enchant Bracer - Superior Strength Obt"] = "逆風術士"
L["Enchant Cloak - Greater Arcane Resistance Obt"] = "伊克利普森大法師"
L["Enchant Cloak - Greater Shadow Resistance Obt"] = "虛無尖嘯者"
L["Enchant Cloak - Lesser Agility Obt"] = "辛迪加刺客"
L["Enchant Cloak - Lesser Agility Obt1"] = "廢土刺客，廢土暴徒"
L["Enchant Gloves - Advanced Herbalism Obt"] = "泥沼之王，摩塔索恩，沼澤漫步者，沼澤漫步者長老，糾纏恐獸"
L["Enchant Gloves - Advanced Mining Obt"] = "風險投資公司露天礦工"
L["Enchant Gloves - Fishing Obt"] = "斯卡基爾，碎鰭灘行魚人，碎鰭神諭者，碎鰭泥漿魚人，碎鰭潮行魚人"
L["Enchant Gloves - Herbalism Obt"] = "瘋狂的古樹，枯萎的古樹"
L["Enchant Gloves - Herbalism Obt1"] = "狂怒的樹人，黑色古樹，燒焦的樹人"
L["Enchant Gloves - Mining Obt"] = "黑鐵矮人，黑鐵爆破手，黑鐵隧道工，黑鐵破壞者，邪惡的巴爾加拉斯"
L["Enchant Gloves - Skinning Obt"] = "『屠戮者』尼瑪爾，枯木狂戰士，枯木獵頭者，枯木暗影獵手"
L["Enchant Weapon - Crusader Obt"] = "血色縛法者"
L["Enchant Weapon - Crusader Obt1"] = "血色大法師"
L["Enchant Weapon - Deathfrost Obt"] = "艾胡恩 - 仲夏火焰節"
L["Enchant Weapon - Fiery Weapon Obt"] = "控火師羅格雷恩"
L["Enchant Weapon - Icy Chill Obt"] = "痛苦的精靈貴族"
L["Enchant Weapon - Lifestealing Obt"] = "鬼靈研究員"
L["Enchant Weapon - Major Intellect Obt"] = "日怒調查員"
L["Enchant Weapon - Major Spellpower Obt"] = "貝許爾法術竊取者"
L["Enchant Weapon - Superior Striking Obt"] = "尖石軍閥"
L["Enchant Weapon - Unholy Weapon Obt"] = "圖薩丁暗影施法者"
L["Smoking Heart of the Mountain Obt"] = "洛考爾"

-- Engineering Obtain Information
L["ENG_MEMBERSHIP_BENEFITS"] = "任務獎勵：會員的獎勵"
L["Field Repair Bot 74A Obt"] = "黑石深淵傀儡統帥阿格曼奇旁可點擊的捲軸"
L["Minor Recombobulator Obt"] = "諾莫瑞根：在矩陣打卡器3005-A上使用白色穿孔卡片，然後在矩陣打卡器3005-B上使用黃色穿孔卡片。"
L["Discombobulator Ray Obt"] = "諾姆瑞根：在矩陣打卡器3005-D上使用秘密資料存取卡。"
-- Mob Drop
L["Adamantite Arrow Maker Obt"] = "虛空風暴：日怒弓箭手"
L["Arcanite Dragonling Obt"] = "冬泉谷：深藍色龍人法師"
L["Dark Iron Rifle Obt"] = "黑石深淵：末日之爐工匠"
L["Felsteel Boomstick Obt"] = "劍刃山脈：末日之爐工程師"
L["Field Repair Bot 110G Obt"] = "劍刃山脈：甘納格分解者"
L["Flawless Arcanite Rifle Obt"] = "東瘟疫之地：爛苔暗影獵手"
L["Hyper-Vision Goggles Obt"] = "影月谷：莫阿格武器鐵匠"
L["Khorium Scope Obt"] = "虛空風暴：日怒射手"
L["Major Recombobulator Obt"] = "厄運之槌(北)戈多克貢品箱子"
L["Weapon Technician"] = "黑石深淵：武器技師"
L["Crimson Inquisitor"] = "斯坦索姆：紅衣審判官"
-- Quest
L["Flash Bomb Obt"] = "閃光彈的製法"
L["Steam Tonk Controller Obt"] = "40張獎券 - 高級獎品(暗月馬戲團)"
L["Zapthrottle Mote Extractor Obt"] = "快速節流微粒吸取器!"
--Adds
L["Discombobulator Ray Obt"] = "諾姆瑞根：麥克尼爾·瑟瑪普拉格"

-- First Aid Obtain Information
-- Nothing here needed yet

-- Jewelcrafting Obtain Information
L["Blades Edge Summon Bosses"] = "劍刃山脈召喚的首領"
--Mob Drop
L["Arcane Khorium Band Obt"] = "虛空風暴：法師殺手"
L["Chaotic Skyfire Diamond Obt"] = "影月谷：考斯卡海妖"
L["Coronet of the Verdant Flame Obt"] = "波塔尼卡：尋日植物學家"
L["Khorium Band of Frost Obt"] = "蒸汽洞窟：盤牙巫女"
L["Khorium Band of Leaves Obt"] = "劍刃山脈：維克尼爾厄鷹"
L["Khorium Band of Shadows Obt"] = "影月谷：黑暗議會暗影術師"
--Adds
--L["Khorium Inferno Band Obt"] = "塞斯克大廳：暗法師希斯"
--L["Circlet of Arcane Might Obt"] = "舊希爾斯布萊德丘陵：紀元狩獵者"
--L["Dark Iron Scorpid Obt"] = "黑石深淵：傀儡統帥阿格曼奇"
--L["Figurine - Black Diamond Crab Obt"] = "黑石塔(下)：軍需官茲格雷斯"
--Quest

-- Leatheworking Obtain Information
--Mob Drop
L["Bag of Many Hides Obt"] = "阻礙之丘的巨魔"
L["Anvilrage Captain"] = "鐵怒上尉"
L["Blue Dragonscale Shoulders Obt"] = "艾薩拉：峭壁擊碎者"
L["Devilsaur Leggings Obt"] = "安戈洛環形山：克隆軟泥怪，黏稠的軟泥怪，原生軟泥怪，膠質軟泥怪"
L["Flame Armor Kit Obt"] = "亞克崔茲：巨型冥淵火"
L["Frostsaber Gloves Obt"] = "冬泉谷：冬泉圖騰師"
L["Frostsaber Leggings Obt"] = "冬泉谷：冬泉巢穴守衛"
L["Frostsaber Tunic Obt"] = "冬泉谷：冬泉巨熊怪"
L["Green Dragonscale Leggings Obt"] = "沉沒的神廟：黑暗蟲"
L["Heavy Scorpid Leggings Obt"] = "燃燒平原：黑石殺戮者"
L["Heavy Scorpid Shoulders Obt"] = "燃燒平原：黑石軍官"
L["Heavy Scorpid Vest Obt"] = "詛咒之地：傳送門搜尋者"
L["Ironfeather Breastplate Obt"] = "辛特蘭：邪枝剝皮者"
L["Living Breastplate Obt"] = "西瘟疫之地：枯萎的恐獸"
L["Living Leggings Obt"] = "費伍德森林：死木薩滿"
L["Shadow Armor Kit Obt"] = "塞斯克大廳：迷失的暗影法師"
L["Stormshroud Armor Obt"] = "艾薩拉：阿克蘭智者"
L["Stormshroud Gloves Obt"] = "希利蘇斯：烈風掠奪者"
L["Stormshroud Gloves Obt1"] = "冬泉谷：泰比斯蒂亞公主"
L["Stormshroud Shoulders Obt"] = "艾薩拉：亞考羅克之子"
L["Stylin' Adventure Hat Obt"] = "舊希爾斯布萊德丘陵：敦霍爾德槍手"
L["Stylin' Crimson Hat Obt"] = "塞斯克大廳：塞司克烏鴉護衛"
L["Stylin' Jungle Hat Obt"] = "黑色沼澤：裂縫領主，裂縫看守者"
L["Tough Scorpid Boots Obt"] = "塔納利斯：廢土遊蕩者"
L["Tough Scorpid Bracers Obt"] = "塔納利斯：廢土暗影法師"
L["Tough Scorpid Breastplate Obt"] = "塔納利斯：廢土強盜"
L["Tough Scorpid Gloves Obt"] = "塔納利斯：廢土竊賊"
L["Tough Scorpid Helm Obt"] = "塔納利斯：安德雷·火鬍，廢土暴徒，廢土刺客"
L["Tough Scorpid Leggings Obt"] = "塔納利斯：廢土遊蕩者"
L["Volcanic Breastplate Obt"] = "黑石塔(下)：火印步兵"
L["Volcanic Leggings Obt"] = "燃燒平原：火腹蠻卒"
L["Volcanic Shoulders Obt"] = "黑石塔(下)：火印軍團戰士"
--Quest
L["Deviate Scale Belt Obt"] = "清除變異者"
L["Kodo Hide Bag Obt"] = "科多獸皮包"
L["Moonglow Vest Obt"] = "月光外衣"
L["Onyxia Scale Cloak Obt"] = "一切才剛剛開始"
L["Wild Leather Boots Obt"] = "蠻皮戰靴"
L["Wild Leather Cloak Obt"] = "蠻皮披風"
L["Wild Leather Helmet Obt"] = "蠻皮盔帽"
L["Wild Leather Leggings Obt"] = "蠻皮護腿"
L["Wild Leather Shoulders Obt"] = "蠻皮護肩"
L["Wild Leather Vest Obt"] = "蠻皮外衣"
--Adds
--L["Arcane Armor Kit Obt"] = "拾綁 - 黑色沼澤：時間領主迪賈"
--L["Black Dragonscale Leggings Obt"] = "裝綁 - 黑石深淵：鐵怒上尉"
--L["Black Dragonscale Shoulders Obt"] = "裝綁 - 黑石深淵：鐵怒上尉"
--L["Frost Armor Kit Obt"] = "拾綁 - 蒸汽洞窟：海法師希斯比亞"
--L["Nature Armor Kit Obt"] = "拾綁 - 奴隸監獄：背叛者門努"
--L["Red Dragonscale Breastplate Obt"] = "裝綁 - 黑石塔(上)：達基薩斯將軍"
--L["Runic Leather Armor Obt"] = "裝綁 - 通靈學院：通靈學院黑暗召喚師"
--L["Runic Leather Bracers Obt"] = "裝綁 - 費伍德森林：加德納爾祭司"
--L["Runic Leather Shoulders Obt"] = "裝綁 - 斯坦索姆：紅衣戰鬥法師"
--L["Stylin' Purple Hat Obt"] = "拾綁 - 暗影迷宮：煽動者黑心"
--L["Tough Scorpid Shoulders Obt"] = "裝綁 - 塔納利斯：安德雷·火鬍，廢土暴徒，廢土刺客"
--L["Wicked Leather Armor Obt"] = "裝綁 - 通靈學院：鬼靈研究員"
--L["Wicked Leather Belt Obt"] = "裝綁 - 斯坦索姆：食屍搶奪者"
--L["Wicked Leather Bracers Obt"] = "裝綁 - 艾薩拉：雷加斯盜賊"
--L["Wicked Leather Headband Obt"] = "裝綁 - 費伍德森：碧火欺詐者林"

-- Smelting Obtain Information
L["Dark Iron Obt"] = "黑石深淵七賢處的格魯雷爾，需要20個金錠，2個紅寶石，10個真銀錠"
L["Elementium Obt"] = "精神控制BWL大元素師克裡希克，使用寵物欄一個技能學得"

-- Rogue Poison Obtain Information
-- Nothing here needed yet

-- Tailoring Obtain Information
L["Arcanoweave Boots Obt"] = "尋日者星法師"
L["Arcanoweave Bracers Obt"] = "亞克崔茲哨兵"
L["Black Silk Pack Obt"] = "辛迪加間諜"
L["Black Silk Pack Obt1"] = "塞拉摩間諜"
L["Black Silk Pack Obt2"] = "幽暗刺客"
L["Cindercloth Cloak Obt"] = "索瑞森馭火者"
L["Cindercloth Gloves Obt"] = "暮光火焰衛士"
L["Cindercloth Pants Obt"] = "索瑞森馭火者"
L["Cindercloth Vest Obt"] = "暮光火焰衛士"
L["Cloak of Fire Obt"] = "征服者派隆"
L["Felcloth Bag Obt"] = "殺死詹迪斯·巴羅夫後出現的書中獲得"
L["Ghostweave Belt Obt"] = "徘徊的精靈貴族"
L["Ghostweave Gloves Obt"] = "徘徊的精靈貴族"
L["Ghostweave Gloves Obt1"] = "無影僕從"
L["Ghostweave Pants Obt"] = "鬼靈居民"
L["Ghostweave Vest Obt"] = "無影僕從"
L["Mooncloth Boots Obt"] = "神聖的月布"
L["Robe of the Archmage Obt"] = "火印炎術師"
L["Robe of Winter Night Obt"] = "深藍色龍人法師"
L["Robes of Arcana Obt"] = "暗灘喚魔師"
L["Robes of Arcana Obt1"] = "迪菲亞附魔師"
L["Shadoweave Mask Obt"] = "黑市交易"
L["Soulcloth Shoulders Obt"] = "魅影侍者"
L["Soulcloth Vest Obt"] = "魅影侍者"
L["Wizardweave Leggings Obt"] = "黑暗召喚師"
L["Wizardweave Robe Obt"] = "黑暗法師"
L["Wizardweave Turban Obt"] = "黑暗法師"

-- Beast Training Obtain Information
L["Rare"] = "稀有"
L["Elite"] = "精英"
-- Beasts which have training skills
L["Agam'ar"] = "阿迦瑪"
L["Aku'mai Fisher"] = "阿庫麥爾食魚龜"
L["Aku'mai Snapjaw"] = "阿庫麥爾鉗嘴龜"
L["Angerclaw Mauler"] = "怒爪巨熊"
L["Arash-ethis"] = "阿拉瑟希斯"
L["Ashenvale Bear"] = "梣谷熊"
L["Ashmane Boar"] = "灰鬃野豬"
L["Barbed Crustacean"] = "刺毛甲殼蟹"
L["Barnabus"] = "巴納布斯"
L["Battleboar"] = "鬥豬"
L["Bellygrub"] = "貝利格拉布"
L["Besseleth"] = "貝瑟萊斯"
L["Bhag'thera"] = "巴爾瑟拉"
L["Bjarn"] = "遊蕩的冰爪熊"
L["Black Bear Patriarch"] = "黑熊族王"
L["Black Ravager Mastiff"] = "巨型黑色劫毀者"
L["Black Ravager"] = "黑色劫毀者"
L["Blackrock Worg"] = "黑石座狼"
L["Blackwind Warp Chaser"] = "黑風扭曲追趕者"
L["Blisterpaw Hyena"] = "皰爪土狼"
L["Bloodaxe Worg"] = "血斧座狼"
L["Bloodfalcon"] = "血鷹"
L["Bloodmaul Battle Worg"] = "血槌作戰座狼"
L["Bloodmaul Dire Wolf"] = "血槌恐狼"
L["Bloodsnout Worg"] = "血牙座狼"
L["Bonepaw Hyena"] = "骨爪土狼"
L["Bristleback Battleboar"] = "刺背鬥豬"
L["Broken Tooth"] = "斷牙"
L["Carrion Vulture"] = "食腐禿鷹"
L["Cave Creeper"] = "洞穴爬行者"
L["Chatter"] = "查特"
L["Clack the Reaver"] = "『搶奪者』科拉克"
L["Clattering Crawler"] = "巨鉗蟹"
L["Cleft Scorpid"] = "裂隙沙漠蠍"
L["Cloud Serpent"] = "風蛇"
L["Cobalt Serpent"] = "深藍色巨蛇"
L["Coilskar Cobra"] = "考斯卡眼鏡蛇"
L["Corrupted Mottled Boar"] = "墮落的雜斑野豬"
L["Corrupted Scorpid"] = "墮落蠍"
L["Coyote Packleader"] = "山狗首領"
L["Coyote"] = "山狗"
L["Crag Boar"] = "峭壁野豬"
L["Crag Coyote"] = "峭壁山狗"
L["Crag Stalker"] = "峭壁捕獵者"
L["Crazed Dragonhawk"] = "瘋狂的龍鷹"
L["Creepthess"] = "克雷普塞斯"
L["Dark Screecher"] = "黑暗尖嘯者"
L["Dark Worg"] = "黑色座狼"
L["Darkfang Creeper"] = "暗牙爬行者"
L["Deadly Cleft Scorpid"] = "致命的裂隙沙漠蠍"
L["Deadmire"] = "死沼巨鱷"
L["Death Flayer"] = "死亡毒蠍"
L["Death Howl"] = "死亡之嚎"
L["Deathlash Scorpid"] = "死鞭蠍"
L["Deathstrike Tarantula"] = "死亡狼蛛"
L["Deep Stinger"] = "深淵釘刺者"
L["Deepmoss Creeper"] = "深苔爬行者"
L["Deepmoss Webspinner"] = "深苔結網蛛"
L["Den Mother"] = "雌薊熊"
L["Deviate Adder"] = "無毒飛蛇"
L["Deviate Coiler Hatchling"] = "小變異曲蛇"
L["Deviate Coiler"] = "變異曲蛇"
L["Deviate Crocolisk"] = "變異鱷魚"
L["Deviate Dreadfang"] = "變異尖牙風蛇"
L["Deviate Moccasin"] = "弱毒飛蛇"
L["Deviate Stinglash"] = "變異刺鞭蛇"
L["Deviate Venomwing"] = "變異劇毒風蛇"
L["Deviate Viper"] = "劇毒飛蛇"
L["Dire Mottled Boar"] = "可怕的雜斑野豬"
L["Diseased Grizzly"] = "生病的灰熊"
L["Diseased Wolf"] = "生病的狼"
L["Dread Flyer"] = "恐怖飛鳥"
L["Dread Ripper"] = "恐怖撕裂者"
L["Dreadfang Lurker"] = "懼牙潛伏者"
L["Dreadfang Widow"] = "懼牙寡婦"
L["Dreadmaw Crocolisk"] = "巨齒鱷魚"
L["Drywallow Crocolisk"] = "塵泥鱷魚"
L["Drywallow Daggermaw"] = "塵泥利齒鱷魚"
L["Drywallow Snapper"] = "塵泥鉗嘴鱷魚"
L["Durotar Tiger"] = "杜洛塔猛虎"
L["Eclipsion Dragonhawk"] = "伊克利普森龍鷹"
L["Elder Ashenvale Bear"] = "老梣谷熊"
L["Elder Cloud Serpent"] = "老風蛇"
L["Elder Crag Boar"] = "老峭壁野豬"
L["Elder Crag Coyote"] = "老峭壁山狗"
L["Elder Mistvale Gorilla"] = "老邁的迷霧谷猩猩"
L["Elder Moss Creeper"] = "老食苔蛛"
L["Elder Mottled Boar"] = "老雜斑野豬"
L["Elder Mountain Boar"] = "老山豬"
L["Elder Plainstrider"] = "老平原陸行鳥"
L["Elder Shadowmaw Panther"] = "老年深喉獵豹"
L["Elder Shardtooth"] = "老裂齒熊"
L["Elder Springpaw"] = "年長的泉爪山貓"
L["Encrusted Surf Crawler"] = "硬殼海浪蟹"
L["Enraged Ravager"] = "暴怒的劫毀者"
L["Felpaw Ravager"] = "魔爪劫毀者"
L["Felpaw Wolf"] = "魔爪狼"
L["Felsworn Scalewing"] = "魔誓鱗翼"
L["Feral Crag Coyote"] = "野生峭壁山狗"
L["Feral Dragonhawk Hatchling"] = "野生小龍鷹"
L["Feral Mountain Lion"] = "野生山地獅"
L["Ferocious Grizzled Bear"] = "兇猛的灰斑熊"
L["Fire Roc"] = "火鵬"
L["Firetail Scorpid"] = "火尾蠍"
L["Flatland Cougar"] = "平原獅"
L["Fleeting Plainstrider"] = "敏捷的平原陸行鳥"
L["Forest Lurker"] = "森林潛伏者"
L["Forest Moss Creeper"] = "森林食苔蛛"
L["Forest Spider"] = "森林蜘蛛"
L["Foreststrider Fledgling"] = "森林陸行鳥雛鳥"
L["Frostsaber Cub"] = "小霜刃豹"
L["Frostsaber Huntress"] = "霜刃雌豹"
L["Frostsaber Stalker"] = "霜刃捕食者"
L["Ghamoo-ra"] = "加摩拉"
L["Ghost Saber"] = "鬼魂豹"
L["Ghostclaw Lynx"] = "鬼爪暗殺者"
L["Ghostclaw Ravager"] = "鬼爪劫毀者"
L["Ghostpaw Alpha"] = "幽爪前鋒"
L["Ghostpaw Runner"] = "幽爪奔跑者"
L["Giant Foreststrider"] = "兇猛的森林陸行鳥"
L["Giant Moss Creeper"] = "巨型食苔蛛"
L["Giant Plains Creeper"] = "巨型平原狼蛛"
L["Giant Webwood Spider"] = "巨型樹林蜘蛛"
L["Giant Wetlands Crocolisk"] = "巨型濕地鱷魚"
L["Githyiss the Vile"] = "邪惡的基塞伊斯"
L["Goretusk"] = "血牙野豬"
L["Gray Bear"] = "灰熊"
L["Gray Forest Wolf"] = "森林灰狼"
L["Great Goretusk"] = "巨型血牙野豬"
L["Greater Duskbat"] = "巨型夜行蝙蝠"
L["Greater Firebird"] = "巨型火鳥"
L["Greater Fleshripper"] = "大碎屍鳥"
L["Greater Kraul Bat"] = "巨型沼澤蝙蝠"
L["Greater Tarantula"] = "巨型狼蛛"
L["Greater Thunderhawk"] = "巨型雷鷹"
L["Greater Windroc"] = "巨型風翼貓頭鷹"
L["Green Recluse"] = "綠色獨行蛛"
L["Groddoc Thunderer"] = "格羅多克大猩猩"
L["Grovestalker Lynx"] = "森林山貓"
L["Grunter"] = "格朗特"
L["Gutripper"] = "卡特瑞普"
L["Hakkar'i Frostwing"] = "哈卡萊霜翼飛蛇"
L["Hakkar'i Sapper"] = "哈卡萊挖掘者"
L["Ice Claw Bear"] = "冰爪熊"
L["Ironback"] = "鐵背龜"
L["Ironbeak Hunter"] = "鐵喙狩獵者"
L["Ironbeak Owl"] = "鐵喙貓頭鷹"
L["Ironbeak Screecher"] = "鐵喙尖嘯者"
L["Ironfur Bear"] = "鐵鬃熊"
L["Ironfur Patriarch"] = "鐵鬃熊族王"
L["Jaguero Stalker"] = "叢林獵豹"
L["Jungle Thunderer"] = "叢林大猩猩"
L["Juvenile Snow Leopard"] = "小雪豹"
L["Kaliri Matriarch"] = "卡里瑞族母"
L["Kaliri Swooper"] = "卡里瑞猛鷲"
L["King Bangalash"] = "虎王邦加拉西"
L["Kraul Bat"] = "沼澤蝙蝠"
L["Krellack"] = "克里拉克"
L["Kresh"] = "克雷什"
L["Kurzen War Tiger"] = "庫爾森戰虎"
L["Lady Sathrah"] = "薩絲拉女士"
L["Large Crag Boar"] = "大峭壁野豬"
L["Large Loch Crocolisk"] = "大型洛克鱷"
L["Leech Widow"] = "吸血寡婦"
L["Loch Crocolisk"] = "洛克鱷"
L["Longsnout"] = "長鼻野豬"
L["Longtooth Howler"] = "長牙嚎叫者"
L["Longtooth Runner"] = "長牙奔跑者"
L["Lost Torranche"] = "失落的巨行鳥"
L["Lupos"] = "魯伯斯"
L["Magram Bonepaw"] = "瑪格拉姆骨爪土狼"
L["Male Kaliri Hatchling"] = "公卡里瑞幼鳥"
L["Mangeclaw"] = "癩爪"
L["Mangy Mountain Boar"] = "癩皮山豬"
L["Mazzranache"] = "馬茲拉納其"
L["Mesa Buzzard"] = "岩地禿鷲"
L["Mist Howler"] = "迷霧嚎叫者"
L["Mistvale Gorilla"] = "迷霧谷猩猩"
L["Mongress"] = "莫戈雷斯"
L["Monstrous Crawler"] = "巨型淤泥蟹"
L["Monstrous Plaguebat"] = "巨型瘟疫蝙蝠"
L["Moonstalker Runt"] = "小月夜猛虎"
L["Moonstalker Sire"] = "月夜雄虎"
L["Mottled Boar"] = "雜斑野豬"
L["Mottled Drywallow Crocolisk"] = "塵泥雜斑鱷魚"
L["Mountain Boar"] = "山豬"
L["Mountain Lion"] = "山地獅"
L["Mudrock Snapjaw"] = "泥石鉗嘴龜"
L["Murk Slitherer"] = "黑暗滑行蟲"
L["Murk Spitter"] = "黑暗粘液蟲"
L["Naraxis"] = "納拉克西斯"
L["Night Web Matriarch"] = "夜行雌蜘蛛"
L["Night Web Spider"] = "夜行蜘蛛"
L["Nightsaber"] = "夜刃豹"
L["Noxious Plaguebat"] = "毒性瘟疫蝙蝠"
L["Oasis Snapjaw"] = "綠洲鉗嘴龜"
L["Ol' Sooty"] = "奧爾蘇迪"
L["Old Cliff Jumper"] = "海崖奔跳者"
L["Old Grizzlegut"] = "灰腹老熊"
L["Olm the Wise"] = "『智者』奧爾姆"
L["Ornery Plainstrider"] = "暴躁的平原陸行鳥"
L["Panther"] = "黑豹"
L["Phoenix-Hawk Hatchling"] = "小鳳鷹"
L["Plague Lurker"] = "瘟疫潛伏者"
L["Plaguebat"] = "瘟疫蝙蝠"
L["Plagued Swine"] = "瘟疫野豬"
L["Plains Creeper"] = "平原狼蛛"
L["Porcine Entourage"] = "隨行小豬"
L["Prairie Stalker"] = "草原捕食者"
L["Prairie Wolf Alpha"] = "草原狼前鋒"
L["Prairie Wolf"] = "草原狼"
L["Princess"] = "公主"
L["Prowler"] = "覓食的灰狼"
L["Pygmy Surf Crawler"] = "小海浪蟹"
L["Quillfang Ravager"] = "惡毒的劫毀者"
L["Quillfang Skitterer"] = "羽牙掠過者"
L["Rabid Blisterpaw"] = "瘋狂的皰爪土狼"
L["Rabid Crag Coyote"] = "瘋狂的峭壁山狗"
L["Ragged Scavenger"] = "蓬毛食腐狼"
L["Raging Agam'ar"] = "暴怒的阿迦瑪"
L["Rak'Shiri"] = "拉克西里"
L["Ravage"] = "毀滅"
L["Ravager Specimen"] = "劫毀者活體標本"
L["Ravenous Windroc"] = "飢餓的風翼貓頭鷹"
L["Razorfang Hatchling"] = "小銳牙劫毀者"
L["Razzashi Adder"] = "拉札希奎蛇"
L["Razzashi Cobra"] = "拉沙希眼鏡蛇"
L["Razzashi Serpent"] = "拉沙希毒蛇"
L["Rekk'tilac"] = "雷克提拉克"
L["Rema"] = "瑞瑪"
L["Ridge Huntress"] = "山脊雌豹"
L["Ridge Stalker Patriarch"] = "山脊巡行者族王"
L["Ridge Stalker"] = "山脊巡行者"
L["Rip-Blade Ravager"] = "裂刃劫毀者"
L["Ripfang Lynx"] = "裂牙山貓"
L["Ripscale"] = "雷普斯凱爾"
L["Roc"] = "大鵬"
L["Rockhide Boar"] = "石皮野豬"
L["Rogue Vale Screecher"] = "遊蕩的山谷尖嘯者"
L["Rotting Agam'ar"] = "腐爛的阿迦瑪"
L["Salt Flats Vulture"] = "鹽湖禿鷹"
L["Saltwater Snapjaw"] = "海水鉗嘴龜"
L["Sandfury Guardian"] = "沙怒守護者"
L["Sarkoth"] = "薩科斯"
L["Savannah Patriarch"] = "草原獅族王"
L["Sawtooth Snapper"] = "鹽齒鉗嘴鱷"
L["Scalewing Serpent"] = "鱗翼風蛇"
L["Scarlet Tracking Hound"] = "血色捕獵犬"
L["Scarred Crag Boar"] = "有傷疤的峭壁野豬"
L["Scarshield Worg"] = "裂盾座狼"
L["Scorchshell Pincer"] = "熱殼螯蝎"
L["Scorpashi Lasher"] = "荒土鞭尾蠍"
L["Scorpashi Snapper"] = "荒土巨鉗蠍"
L["Scorpashi Venomlash"] = "荒土毒尾蠍"
L["Scorpid Bonecrawler"] = "爬骨蝎子"
L["Scorpid Duneburrower"] = "沙漠掘洞蠍"
L["Scorpid Dunestalker"] = "沙漠疾行蠍"
L["Scorpid Hunter"] = "沙漠獵食蠍"
L["Scorpid Reaver"] = "恐蠍搶奪者"
L["Scorpid Tail Lasher"] = "沙漠鞭尾蠍"
L["Scorpid Terror"] = "恐蠍"
L["Scorpid Worker"] = "蠍子"
L["Scorpok Stinger"] = "厚甲毒刺蠍"
L["Searing Roc"] = "炎鵬"
L["Shadow Panther"] = "暗影黑豹"
L["Shadowmaw Panther"] = "深喉獵豹"
L["Shadowwing Owl"] = "暗影之翼貓頭鷹"
L["Shanda the Spinner"] = "紡織者杉達"
L["Shardtooth Bear"] = "裂齒熊"
L["Shore Crawler"] = "灘行蟹"
L["Shrike Bat"] = "利齒蝙蝠"
L["Silithid Creeper"] = "異種爬行者"
L["Silithid Swarmer"] = "異種群居蠍"
L["Silt Crawler"] = "淤泥蟹"
L["Silvermane Howler"] = "銀鬃嗥狼"
L["Silvermane Stalker"] = "銀鬃捕獵者"
L["Silvermane Wolf"] = "銀鬃狼"
L["Sin'Dall"] = "辛達爾"
L["Skettis Kaliri"] = "司凱堤斯卡里瑞"
L["Skittering Crustacean"] = "滑膩的甲殼蟹"
L["Small Crag Boar"] = "小型峭壁野豬"
L["Snapjaw"] = "鉗嘴龜"
L["Snapping Crustacean"] = "巨鉗甲殼蟹"
L["Snarler"] = "咆哮者"
L["Snow Tracker Wolf"] = "雪狼"
L["Son of Hakkar"] = "哈卡之子"
L["Soulflayer"] = "奪魂者"
L["Sparkleshell Snapper"] = "鹽殼鉗嘴龜"
L["Spawn of Hakkar"] = "哈卡的後代"
L["Spiteflayer"] = "斯比弗雷爾"
L["Spot"] = "斑斑"
L["Starving Blisterpaw"] = "饑餓的皰爪土狼"
L["Starving Mountain Lion"] = "饑餓的山地獅"
L["Starving Winter Wolf"] = "饑餓的冬狼"
L["Stonelash Flayer"] = "石鞭撕掠者"
L["Stonelash Pincer"] = "石鞭巨鉗蠍"
L["Stonelash Scorpid"] = "石鞭蠍"
L["Stonetusk Boar"] = "石牙野豬"
L["Stranglethorn Tiger"] = "荊棘谷猛虎"
L["Strigid Hunter"] = "巨翼獵梟"
L["Strigid Owl"] = "巨翼梟"
L["Swamp Jaguar"] = "沼澤虎"
L["Swiftwing Shredder"] = "迅翼絞碎者"
L["Tarantula"] = "狼蛛"
L["Thistle Bear"] = "薊熊"
L["Thistle Boar"] = "草刺野豬"
L["Thornfang Ravager"] = "棘牙劫毀者"
L["Thornfang Venomspitter"] = "棘牙吐毒者"
L["Thunderhawk Cloudscraper"] = "雷鷹破雲者"
L["Thunderhawk Hatchling"] = "雷鷹雛鳥"
L["Tide Crawler"] = "潮行蟹"
L["Timber Worg"] = "灰座狼"
L["Timber"] = "狂暴的冬狼"
L["Timberweb Recluse"] = "林木隱匿者"
L["Twilight Runner"] = "夜行虎"
L["U'cha"] = "尤爾查"
L["Uhk'loc"] = "烏卡洛克"
L["Un'Goro Thunderer"] = "安戈洛大猩猩"
L["Vale Screecher"] = "山谷尖嘯者"
L["Venomlash Scorpid"] = "毒鞭蠍"
L["Venomous Cloud Serpent"] = "毒性風蛇"
L["Venomtail Scorpid"] = "毒尾蠍"
L["Venomtip Scorpid"] = "毒尖蠍"
L["Vicious Night Web Spider"] = "邪惡的夜行蜘蛛"
L["Vile Sting"] = "邪刺恐蠍"
L["Vilebranch Raiding Wolf"] = "邪枝巨狼"
L["Warp Chaser"] = "扭曲追趕者"
L["Warp Hunter"] = "扭曲獵者"
L["Warp Stalker"] = "扭曲行者"
L["Washte Pawne"] = "瓦希塔帕恩"
L["Wayward Buzzard"] = "遊蕩的禿鷲"
L["Webwood Silkspinner"] = "樹林結網蛛"
L["Webwood Venomfang"] = "樹林毒蜘蛛"
L["Wildthorn Lurker"] = "野棘潛伏者"
L["Windroc Hunter"] = "風翼獵鷹"
L["Windroc Huntress"] = "雌性風翼獵鷹"
L["Windroc Matriarch"] = "風翼族母"
L["Windroc"] = "風翼貓頭鷹"
L["Winter Wolf"] = "冬狼"
L["Winterspring Owl"] = "冬泉巨梟"
L["Winterspring Screecher"] = "冬泉鳴梟"
L["Wood Lurker"] = "林木潛伏者"
L["Worg"] = "座狼"
L["Young Forest Bear"] = "小森林熊"
L["Young Goretusk"] = "幼年血牙野豬"
L["Young Mesa Buzzard"] = "小岩地禿鷲"
L["Young Panther"] = "小獵豹"
L["Young Stranglethorn Tiger"] = "小荊棘谷猛虎"
L["Young Thistle Boar"] = "小草刺野豬"
L["Zaricotl"] = "札里科特"
L["Zulian Panther"] = "祖利安雌獵虎"
L["Zulian Stalker"] = "祖利安捕獵者"

-- Vendor Names
L["Aaron Hollman"] = "艾朗·赫曼"
L["Abigail Shiel"] = "阿比蓋爾·沙伊爾"
L["Aged Dalaran Wizard"] = "年邁的達拉然法師"
L["Alchemist Gribble"] = "鍊金師古利伯"
L["Alchemist Pestlezugg"] = "鍊金師匹斯特蘇格"
L["Aldraan"] = "阿爾德蘭"
L["Alexandra Bolero"] = "亞歷山卓·波利羅"
L["Algernon"] = "奧格諾恩"
L["Altaa"] = "艾歐塔"
L["Amy Davenport"] = "艾米·達文波特"
L["Andrew Hilbert"] = "安德魯·希爾伯特"
L["Andrion Darkspinner"] = "安德利恩·暗紋紡織者"
L["Androd Fadran"] = "安多德·法德蘭"
L["Apothecary Antonivich"] = "藥劑師安拓維奇"
L["Aresella"] = "艾瑞斯拉"
L["Arras"] = "阿拉斯"
L["Arred"] = "阿瑞德"
L["Arrond"] = "阿羅德"
L["Asarnan"] = "阿薩南"
L["Balai Lok'Wein"] = "巴萊·洛克維"
L["Bale"] = "拜爾"
L["Banalash"] = "巴納拉許"
L["Blimo Gadgetspring"] = "布里莫"
L["Blixrez Goodstitch"] = "布里克雷茲·古斯提"
L["Blizrik Buckshot"] = "布雷茲里克·巴克舒特"
L["Bliztik"] = "布里茲提克"
L["Bombus Finespindle"] = "伯布斯·鋼軸"
L["Borto"] = "波爾土"
L["Borya"] = "博亞"
L["Brienna Starglow"] = "布琳娜·星光"
L["Bro'kin"] = "布洛金"
L["Bronk"] = "布隆克"
L["Burbik Gearspanner"] = "巴比克·齒輪"
L["Burko"] = "波爾寇"
L["Captured Gnome"] = "捕獲的地精"
L["Catherine Leland"] = "凱薩琳·利蘭"
L["Christoph Jeffcoat"] = "克里斯多夫·傑弗寇特"
L["Clyde Ranthal"] = "克萊德·蘭薩爾"
L["Constance Brisboise"] = "康斯坦茨·布里斯博埃斯"
L["Cookie McWeaksauce"] = "『小廚』麥克威醬"
L["Cookie One-Eye"] = "獨眼廚師"
L["Coreiel"] = "寇瑞歐"
L["Corporal Bluth"] = "布魯斯下士"
L["Cowardly Crosby"] = "怯懦的克羅斯比"
L["Crazk Sparks"] = "克拉賽·斯巴克斯"
L["Cro Threadstrong"] = "克洛·絲壯"
L["Daga Ramba"] = "達卡·萊芭"
L["Daggle Ironshaper"] = "達茍·煉鐵者"
L["Dalria"] = "達利亞"
L["Daniel Bartlett"] = "丹尼爾·巴特萊特"
L["Danielle Zipstitch"] = "丹尼勒·希普斯迪"
L["Darian Singh"] = "達利安·辛格"
L["Darnall"] = "旅店老闆達納爾"
L["Dealer Malij"] = "商人瑪力吉"
L["Defias Profiteer"] = "迪菲亞奸商"
L["Deneb Walker"] = "德尼布·沃克"
L["Derak Nightfall"] = "德拉克·奈特弗"
L["Deynna"] = "笛娜"
L["Dirge Quikcleave"] = "戴格·迅斬"
L["Doba"] = "杜巴"
L["Drac Roughcut"] = "德拉克·卷刃"
L["Drake Lindgren"] = "崔克·林格雷"
L["Drovnar Strongbrew"] = "德魯納·烈酒"
L["Edna Mullby"] = "艾德娜·穆比"
L["Egomis"] = "伊歐糜斯"
L["Eiin"] = "伊恩"
L["Elynna"] = "愛琳娜"
L["Emrul Riknussun"] = "埃姆盧爾·里克努斯"
L["Eriden"] = "艾利丹"
L["Erika Tate"] = "艾瑞卡·塔特"
L["Erilia"] = "艾瑞麗雅"
L["Feera"] = "菲娜"
L["Felannia"] = "菲蘭妮雅"
L["Felicia Doan"] = "菲利希亞·杜安"
L["Felika"] = "菲利卡"
L["Fradd Swiftgear"] = "弗拉德"
L["Fyldan"] = "菲爾丹"
L["Gagsprocket"] = "加格斯普吉特"
L["Gambarinka"] = "坎巴利卡"
L["Gearcutter Cogspinner"] = "考格斯賓"
L["Gelanthis"] = "吉藍迪斯"
L["George Candarte"] = "喬治·坎達特"
L["Gharash"] = "卡爾拉什"
L["Ghok'kah"] = "格魯克卡恩"
L["Gidge Spellweaver"] = "蓋吉·術法編織者"
L["Gigget Zipcoil"] = "吉蓋特·火油"
L["Gikkix"] = "吉科希斯"
L["Gina MacGregor"] = "吉娜·馬克葛瑞格"
L["Gloria Femmel"] = "格勞瑞亞·菲米爾"
L["Glyx Brewright"] = "格里克斯·布魯維特"
L["Gnaz Blunderflame"] = "格納茲·槍焰"
L["Gretta Ganter"] = "格雷塔·甘特"
L["Grimtak"] = "格瑞姆塔克"
L["Haalrun"] = "哈爾隆恩"
L["Haferet"] = "哈弗瑞"
L["Hagrus"] = "哈格魯斯"
L["Hammon Karwn"] = "哈蒙·卡文"
L["Harggan"] = "哈爾甘"
L["Harklan Moongrove"] = "哈克蘭·月林"
L["Harlown Darkweave"] = "哈魯恩·暗紋"
L["Harn Longcast"] = "哈恩·長線"
L["Haughty Modiste"] = "傲慢的店主"
L["Heldan Galesong"] = "海爾丹·風歌"
L["Helenia Olden"] = "海倫妮亞·奧德恩"
L["Himmik"] = "西米克"
L["Hula'mahi"] = "哈拉瑪"
L["Innkeeper Biribi"] = "旅店老闆畢瑞比"
L["Innkeeper Fizzgrimble"] = "旅店老闆菲茲格瑞博"
L["Innkeeper Grilka"] = "旅店老闆格瑞伊卡"
L["Jabbey"] = "加貝"
L["Jandia"] = "詹迪亞"
L["Janet Hommers"] = "詹奈特·霍莫斯"
L["Jangdor Swiftstrider"] = "杉多爾·迅蹄"
L["Jannos Ironwill"] = "加諾斯·鐵心"
L["Jaquilina Dramet"] = "加奎琳娜·德拉米特"
L["Jase Farlane"] = "賈斯·法拉恩"
L["Jazzrik"] = "加茲里克"
L["Jeeda"] = "基達"
L["Jennabink Powerseam"] = "吉娜比克·鐵線"
L["Jessara Cordell"] = "傑薩拉·考迪爾"
L["Jim Saltit"] = "吉姆·沙提"
L["Jinky Twizzlefixxit"] = "金克·鐵鉤"
L["Johan Barnes"] = "裘汗·巴奈斯"
L["Joseph Moore"] = "約瑟夫·摩爾"
L["Jubie Gadgetspring"] = "朱比"
L["Jun'ha"] = "祖恩哈"
L["Juno Dufrain"] = "喬諾·杜伏恩"
L["Jutak"] = "祖塔克"
L["Kaita Deepforge"] = "凱塔·深爐"
L["Kalaen"] = "卡連恩"
L["Kalldan Felmoon"] = "卡爾丹·暗月"
L["Kania"] = "卡妮亞"
L["Keena"] = "基納"
L["Kelsey Yance"] = "凱爾希·楊斯"
L["Kendor Kabonka"] = "肯多爾·卡邦卡"
L["Khara Deepwater"] = "卡拉·深水"
L["Kiknikle"] = "吉克尼庫"
L["Killian Sanatha"] = "基利恩·薩納森"
L["Kilxx"] = "基爾克斯"
L["Kireena"] = "基瑞娜"
L["Kithas"] = "基薩斯"
L["Knaz Blunderflame"] = "克納茲·槍焰"
L["Kor'geld"] = "考吉爾德"
L["Krek Cragcrush"] = "克瑞克·碎岩"
L["Kriggon Talsone"] = "克雷貢·塔爾松"
L["Krinkle Goodsteel"] = "克林科·古德斯迪爾"
L["Kulwia"] = "庫爾維亞"
L["Kzixx"] = "卡茲克斯"
L["Laird"] = "賴爾德"
L["Landraelanis"] = "藍卓阿蘭妮絲"
L["Lardan"] = "拉爾丹"
L["Lebowski"] = "樂柏斯基"
L["Leeli Longhaggle"] = "莉利·長爭"
L["Leo Sarn"] = "雷歐·薩恩"
L["Leonard Porter"] = "萊納德·波特"
L["Lilly"] = "莉蕾"
L["Lindea Rabonne"] = "林迪·拉波尼"
L["Lizbeth Cromwell"] = "莉茲白·克倫威爾"
L["Logannas"] = "洛加納斯"
L["Loolruna"] = "路歐露娜"
L["Lorelae Wintersong"] = "羅賴爾·冬歌"
L["Lyna"] = "萊娜"
L["Madame Ruby"] = "魯比夫人"
L["Mahu"] = "曼胡"
L["Mallen Swain"] = "瑪林·斯萬"
L["Malygen"] = "瑪里甘"
L["Mari Stonehand"] = "瑪利·石手"
L["Maria Lumere"] = "瑪麗亞·盧米爾"
L["Martine Tramblay"] = "馬丁·塔布雷"
L["Masat T'andr"] = "馬薩特·坦德"
L["Master Chef Mouldier"] = "大廚師瑪戴爾"
L["Mathar G'ochar"] = "瑪沙爾·葛歐洽"
L["Mavralyn"] = "馬弗拉林"
L["Mazk Snipeshot"] = "瑪茲克·斯奈普沙特"
L["Melaris"] = "米拉瑞斯"
L["Micha Yance"] = "米莎·楊斯"
L["Millie Gregorian"] = "米利爾·格里高利"
L["Mishta"] = "米希塔"
L["Mixie Farshot"] = "扎米·費雪"
L["Montarr"] = "莫塔爾"
L["Muheru the Weaver"] = "『編織者』姆賀魯"
L["Muuran"] = "莫爾蘭"
L["Mythrin'dir"] = "邁斯林迪爾"
L["Naal Mistrunner"] = "納爾·迷霧行者"
L["Namdo Bizzfizzle"] = "納姆杜"
L["Nandar Branson"] = "南達·布拉森"
L["Narkk"] = "納爾克"
L["Nasmara Moonsong"] = "那斯馬拉·月歌"
L["Nata Dawnstrider"] = "納塔·晨行者"
L["Neal Allen"] = "尼爾·奧雷"
L["Neii"] = "奈伊"
L["Nergal"] = "奈爾加"
L["Nerrist"] = "耐里斯特"
L["Nessa Shadowsong"] = "奈莎·影歌"
L["Nina Lightbrew"] = "妮娜·萊特布魯"
L["Nioma"] = "尼奧瑪"
L["Nula the Butcher"] = "屠夫奴拉"
L["Nyoma"] = "奈歐瑪"
L["Ogg'marr"] = "奧克瑪爾"
L["Otho Moji'ko"] = "奧索·莫吉克"
L["Outfitter Eric"] = "埃瑞克"
L["Phea"] = "菲亞"
L["Plugger Spazzring"] = "普拉格"
L["Pratt McGrubben"] = "普拉特·馬克格魯比"
L["Qia"] = "琪亞"
L["Quartermaster Davian Vaclav"] = "軍需官戴夫恩·瓦克拉夫"
L["Quartermaster Jaffrey Noreliqe"] = "軍需官傑夫利·諾利克"
L["Quelis"] = "奎利斯"
L["Ranik"] = "拉尼克"
L["Rann Flamespinner"] = "拉恩·火翼"
L["Rartar"] = "拉爾塔"
L["Rathis Tomber"] = "拉提斯·土柏"
L["Rikqiz"] = "雷克奇茲"
L["Rizz Loosebolt"] = "里茲·飛矢"
L["Rohok"] = "洛赫克"
L["Ronald Burch"] = "羅奈爾得·伯奇"
L["Rungor"] = "阮勾爾"
L["Ruppo Zipcoil"] = "魯普·火油"
L["Saenorion"] = "塞諾里奧"
L["Seer Janidi"] = "先知賈尼迪"
L["Sewa Mistrunner"] = "蘇瓦·迷霧行者"
L["Shadi Mistrunner"] = "沙迪·迷霧行者"
L["Shankys"] = "山吉斯"
L["Sheendra Tallgrass"] = "希恩德拉·深草"
L["Shen'dralar Provisioner"] = "辛德拉物資供應者"
L["Sheri Zipstitch"] = "舍瑞·希普斯迪"
L["Sid Limbardi"] = "希德·琳巴迪"
L["Skreah"] = "史卡瑞"
L["Soolie Berryfizz"] = "蘇雷·漿泡"
L["Sovik"] = "索維克"
L["Stuart Fleming"] = "斯圖亞特·弗雷明"
L["Sumi"] = "蘇米"
L["Super-Seller 680"] = "超級商人680型"
L["Supply Officer Mills"] = "物資商人米歐斯"
L["Tamar"] = "達瑪爾"
L["Tansy Puddlefizz"] = "坦斯·泥泡"
L["Tarban Hearthgrain"] = "塔班·熟麥"
L["Tari'qa"] = "塔里查"
L["Tatiana"] = "塔蒂安娜"
L["Thaddeus Webb"] = "薩德烏斯·韋伯"
L["Tharynn Bouden"] = "薩瑞恩·博丁"
L["Thomas Yance"] = "湯瑪斯·陽斯"
L["Tilli Thistlefuzz"] = "提爾利·草鬚"
L["Truk Wildbeard"] = "特魯克·蠻鬃"
L["Tunkk"] = "吞克"
L["Ulthaan"] = "尤薩恩"
L["Ulthir"] = "尤希爾"
L["Uriku"] = "烏銳庫"
L["Uthok"] = "尤索克"
L["Vaean"] = "維安"
L["Valdaron"] = "瓦爾達隆"
L["Veenix"] = "維尼克斯"
L["Vendor-Tron 1000"] = "貿易機器人1000型"
L["Vharr"] = "維哈爾"
L["Viggz Shinesparked"] = "維格斯·亮星"
L["Vivianna"] = "薇薇安娜"
L["Vizzklick"] = "維茲格里克"
L["Vodesiin"] = "伏德希恩"
L["Wenna Silkbeard"] = "溫納·銀鬚"
L["Werg Thickblade"] = "維爾格·厚刃"
L["Wik'Tar"] = "維克塔"
L["Wind Trader Lathrai"] = "風之貿易者拉斯蕊"
L["Wrahk"] = "瓦爾克"
L["Wulan"] = "烏蘭"
L["Wunna Darkmane"] = "溫納·黑鬃"
L["Xandar Goodbeard"] = "山達·細鬚"
L["Xen'to"] = "克森圖"
L["Xizk Goodstitch"] = "希茲克·古斯提"
L["Xizzer Fizzbolt"] = "希茲爾·菲茲波特"
L["Yatheon"] = "亞斯恩"
L["Yonada"] = "猶納達"
L["Yuka Screwspigot"] = "尤卡·斯庫比格特"
L["Yurial Soulwater"] = "優立歐·靈魂之水"
L["Zan Shivsproket"] = "薩恩·刀鏈"
L["Zannok Hidepiercer"] = "札諾克"
L["Zansoa"] = "詹蘇爾"
L["Zaralda"] = "莎拉達"
L["Zarena Cromwind"] = "薩瑞娜·克羅姆溫德"
L["Zixil"] = "吉克希爾"
L["Zorbin Fandazzle"] = "索爾賓·范達瑟"
L["Zurai"] = "祖瑞伊"
L["Narj Deepslice"] = "納爾基·長刀"
L["Fazu"] = "法蘇"
L["Zargh"] = "札爾夫"
L["Smudge Thunderwood"] = "斯穆德·雷木"
L["Sassa Weldwell"] = "莎紗·威德衛爾"