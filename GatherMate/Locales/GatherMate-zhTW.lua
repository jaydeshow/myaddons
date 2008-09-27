--[[
-- zhTW Localization file, by NightOwl (天明, 眾星之子)
]]
local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate","zhTW")
if not L then return end
-- Spell names for Collector module
L["Mining"] = "採礦"
L["Fishing"] = "釣魚"
L["Herb Gathering"] = "採集草藥"
L["Extract Gas"] = "提煉氣體雲"
L["Herbalism"] = "草藥學"
L["Engineering"] = "工程學"
L["Opening"] = "開啟"
L["Pick Lock"] = "開鎖"
-- Display module
L["GatherMate Pin Options"] = "GatherMate Pin選項"
L["Delete: "] = "刪除："
L["Add this location to Cartographer_Waypoints"] = "將該地點加入 Cartographer_Waypoints"
L["Add this location to TomTom waypoints"] = "將該地點加入 TomTom waypoints"

L["Always show"] = "總是顯示"
L["Only with profession"] = "僅顯示專業相關"
L["Only while tracking"] = "僅顯示追蹤相關"
L["Never show"] = "從不顯示"


-- Config modules
L["GatherMate"]="GatherMate"
L["gathermate"]="gathermate" -- slash command
---- Display Filters tree
L["Display Settings"] = "顯示設置"
------ General subtree
L["General"] = "一般設置"
L["Show Databases"] = "顯示數據庫"
L["Selected databases are shown on both the World Map and Minimap."] = "選擇在世界地圖和小地圖上顯示數據庫。"
L["Show Mining Nodes"]="顯示礦脈"
L["Toggle showing mining nodes."]="切換顯示礦脈採集點。"
L["Show Herbalism Nodes"]="顯示草藥"
L["Toggle showing herbalism nodes."]="切換顯示草藥採集點。"
L["Show Fishing Nodes"]="顯示魚群"
L["Toggle showing fishing nodes."]="切換顯示魚群垂釣點。"
L["Show Gas Clouds"]="顯示氣雲"
L["Toggle showing gas clouds."]="切換顯示氣雲(微粒採集點)。"
L["Show Treasure Nodes"]="顯示寶藏"
L["Toggle showing treasure nodes."]="切換顯示財寶地點。"
L["Icons"] = "圖示"
L["Control various aspects of node icons on both the World Map and Minimap."] = "控制你想要在世界地圖和小地圖上顯示的多種節點圖示。"
L["Show Minimap Icons"]="顯示小地圖圖示"
L["Toggle showing Minimap icons."] = "切換顯示圖示與否(在小地圖上)。"
L["Show World Map Icons"] = "顯示世界地圖圖示"
L["Toggle showing World Map icons."] = "切換顯示圖示與否(在世界地圖上)。"
L["Keybind to toggle Minimap Icons"] = "設定熱鍵切換顯示小地圖的圖示與否"
L["Icon Scale"] = "圖示縮放"
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = "圖示縮放，這個選項讓你把世界地圖和小地圖上的圖示放大或縮小。"
L["Icon Alpha"] = "圖示透明度"
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = "圖示透明度，這個選項讓你更改圖示的透明度，僅作用於世界地圖！"
L["Miscellaneous"] = "雜項"
-- Cleanup subtree (now Database Maintenance)
L["Database Maintenance"] = "數據庫維護"
L["Cleanup_Desc"] = "經過一段時間後，你的數據庫可能會非常大，清理資料可以讓你的相同專業的在一定範圍內的資料合併為一個，以避免重複。"
L["Cleanup radius"] = "清理半徑"
L["CLEANUP_RADIUS_DESC"] = "設置以碼為單位的半徑，在半徑內的資料將被清除。預設值設置為 |cffffd20050|r 碼（氣雲）/ |cffffd20015|r 碼（其他採集資料）。這些設置也被用於增加的節點。"
L["Cleanup Database"] = "清理資料"
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = "清理你的數據庫，移除重復資料。這個過程可能持續幾分鐘，請耐心等待。"
L["Processing "] = "正在處理……"
L["Cleanup Complete."] = "清理結束！"
L["Delete Specific Nodes"] = "刪除選定的資源點"
L["DELETE_SPECIFIC_DESC"] = "從選定的區域刪除所有選定的資源點. 您必須停用數據庫鎖定才能運作."
L["Select Database"] = "選擇數據庫"
L["Select Node"] = "選擇資源點"
L["Select Zone"] = "選擇地區"
L["Delete"] = "刪除"
L["Delete selected node from selected zone"] = "從選定的區域刪除所有選定的資源點"
L["Are you sure you want to delete all of the selected node from the selected zone?"] = "您確定要從選定的區域刪除所有選定的資源點嗎?"
L["Delete Entire Database"] = "刪除整個數據庫"
L["DELETE_ENTIRE_DESC"] = "這將會忽略數據庫鎖定並從選定的數據庫內所有的區域刪除所有的資源點."
L["Are you sure you want to delete all nodes from this database?"] = "您確定要刪除這數據庫所有的資源點嗎?"
L["Database Locking"] = "數據庫鎖定"
L["DATABASE_LOCKING_DESC"] = "數據庫鎖定功能可讓您凍結一個數據庫的狀態。一旦鎖定您將不再能夠添加，刪除或修改數據庫。這包括清理和輸入。"
L["Database locking"] = "數據庫鎖定"

-- Tracking options
L["Tracking Circle Color"] = "追蹤環顏色"
L["Color of the tracking circle."] = "追蹤環的顏色。"
L["Tracking Distance"] = "追蹤距離"
L["The distance in yards to a node before it turns into a tracking circle"] = "在一個節點變成追蹤環之前的距離。"
L["Show Tracking Circle"] = "顯示追蹤環"
L["Toggle showing the tracking circle."] = "切換是否顯示追蹤環。"
L["Show Nodes on Minimap Border"] = "小地圖邊界顯示"
L["Shows more Nodes that are currently out of range on the minimap's border."] = "在小地圖邊界上顯示哪些超出小地圖的節點。"
------ Filters subtree
L["Filters"] = "過濾"
L["Herb filter"] = "草藥過濾"
L["Select the herb nodes you wish to display."]= "選擇你想要顯示的草藥節點。"
L["Mine filter"] = "礦脈過濾"
L["Select the mining nodes you wish to display."] = "選擇你想要顯示的礦脈節點。"
L["Fish filter"] = "魚群過濾"
L["Select the fish nodes you wish to display."] = "選擇你想要顯示的魚群節點。"
L["Gas filter"] = "氣雲過濾"
L["Select the gas clouds you wish to display."] = "選擇你想要顯示的氣雲節點。"
L["Treasure filter"] = "寶藏過濾"
L["Select the treasure you wish to display."] = "選擇你想要顯示的寶藏節點。"
L["Select All"] = "全部選擇"
L["Select all nodes"] = "選擇全部節點"
L["Clear node selections"] = "清除選擇的節點"
L["Select None"] = "清空選擇"
L["Gas Clouds"]= "氣雲"
L["Fishes"] = "魚群"
L["Mineral Veins"] = "礦脈"
L["Herb Bushes"] = "草藥"
L["Treasure"] = "財寶"
L["Filter_Desc"] = "選擇你想要在世界地圖和小地圖上顯示的節點類型，不選擇的類型將僅記錄在數據庫中。"
---- Import tree
L["Import Data"] = "匯入資料"
L["Import GatherMateData"] = "匯入 GatherMateData"
L["Importing_Desc"] = "匯入允許 GatherMate 從其他來源獲取節點資料。匯入結束後，你最好進行一次資料清理。"
L["Load GatherMateData and import the data to your database."] = "載入 GatherMateData 並把其中的資料匯入你的數據庫"
L["GatherMateData has been imported."] = "GatherMateData 已經被匯入。"
L["Failed to load GatherMateData due to "] = "載入 GatherMateData 失敗："
L["Merge"] = "合併"
L["Overwrite"] = "覆蓋"
L["Import Style"] = "匯入模式"
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = "合併將 GatherMateDate 資料加入你的數據庫，覆蓋將用 GatherMateData 中的資料替換你現有的數據庫"
L["Databases to Import"] = "匯入的數據庫"
L["Databases you wish to import"] = "你想要匯入的數據庫"
L["Auto Import"] = "自動匯入"
L["Automatically import when ever you update your data module, your current import choice will be used."] = "當你升級你的資料模組的時候自動匯入升級後的資料，你目前的匯入選項將控制匯入的資料類型。"
L["Auto import complete for addon "] = "自動匯入資料源："
L["BC Data Only"] = "僅燃燒遠征的資料"
L["Only import Burning Crusade data from WoWHead"] = "僅匯入燃燒遠征的資料(WoWHead版本)"
--- profile settings
L["Default"] = "預設值"
L["Char:"] = "人物："
L["Realm:"] = "伺服器："
L["Class:"] = "職業："
L["Profiles"] = "配置"
L["Manage Profiles"] = "管理配置"
L["You can change the active database profile of GatherMate, so you can have different settings and filters for every character, which will allow a very flexible configuration for everyones needs."] = "你可以更改 GaterMate 啟用的配置，方便你為不同的人物進行設置，這將會給你帶來非常彈性的配置方法。"
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = "重置你目前的配置，僅在配置檔出錯或者你想要重新配置的時候選擇！"
L["You can create a new profile by entering a new name in the editbox, or choosing one of the already exisiting profiles."] = "你可以在一下的編輯框中建立一個新的配置，或者選擇一個已經建立的配置"
L["Reset Profile"] = "重置配置"
L["Reset the current profile to the default"] = "把目前的配置重設為預設值"
L["New"] = "新配置"
L["Create a new empty profile."] = "建立一個新的配置檔"
L["Current"] = "目前配置"
L["Select one of your currently available profiles."] = "選擇一個你想要起作用的配置"
L["Copy the settings from one existing profile into the currently active profile."] = "從其他配置檔中複製一個到目前配置檔"
L["Copy From"] = "複製於："
L["Copy the settings from another profile into the active profile."] = "從其他配置檔複製到目前配置檔"
L["Delete existing and unused profiles from the database to save space, and cleanup the GatherMate SavedVariables file."] = "刪除位元使用的配置，以清理 GatherMate 的 SavedVariables 檔。"
L["Delete a Profile"] = "刪除配置"
L["Deletes a profile from the database."] = "從數據庫中刪除一個配置"
L["Are you sure you want to delete the selected profile?"] = "你確定要刪除該配置？"
-- FAQ
L["FAQ"] = "常見問題"
L["Frequently Asked Questions"] = "常見問題解答"
L["FAQ_TEXT"] = [[
|cffffd200
我剛剛安裝好 GatherMate, 為什麼在地圖上沒看到資源點?
|r
GatherMate 本身沒有內建的資料. 當你在進行採集之後, GatherMate 便會增加及更新你地圖上的資源點. 還有, 請撿查一下顯示設置.

|cffffd200
為什麼在地圖上有的資源點, 但小地圖上卻沒有?
|r
|cffffff78Minimap Button Bag|r (也可能是其它類似的插件) 會覆蓋小地圖上的按鈕. 請關上它.

|cffffd200
怎樣可取得現成的資料?
|r
你可用三種方法把現成的資料匯入GatherMate:

1. |cffffff78GatherMate_Data|r - 這個是 LoD (按需要時載入)的插件,包含了 WowHead 收集的資源點並每周會作資料更新. 提供自動更新的選項

2. |cffffff78GatherMate_CartImport|r - 這插件讓你把現存 |cffffff78Cartographer_<Profession>|r 的數據庫匯入到 GatherMate. 但一定要 |cffffff78Cartographer_<Profession>|r 模組和 GatherMate_CartImport 一起載入運作才能順利匯入資料.

注意:匯入資料到 GatherMate 並非自動運作. 你要自己按匯入資料的按鈕.

這不同於 |cffffff78Cartographer_Data|r 能容許你作個別的修改資料, 當載入 |cffffff78Cartographer_Data|r 時會覆寫你現存的數據庫和已發現的資源點.

|cffffd200
會否加入其它的顯示, 如郵箱和飛行管理員等等?
|r
答案是不會. 不過, 有些其它的插件作者可能會製作這樣的插件或模組, GatherMate 核心程式不會考慮加入這些.

|cffffd200
我發現有臭蟲! 在那裡可以舉報?
|r
你可以在 |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r 裡貼文關於臭蟲或建議(不過要用英文). 

另外, 你可以在 |cffffff78irc://irc.freenode.org/wowace|r 找到我們(也是要用英文).

當舉報臭蟲時, 請詳細說明|cffffff78引至錯誤的動作|r, 提供 |cffffff78error messages|r , GatherMate 的|cffffff78板本|r 和你在在使用什麼語言系統|cffffff78英文或其它語言|r.

|cffffd200
誰人製作這超酷的插件?
|r
Kagaro, Xinhuan, Nevcairiel and Ammo

|cffffd200
誰人那麼無聊做這些艱難的翻譯?
|r
|cffffff78天明|r 眾星之子
]]

--[[
We have a second translation list to handle just nodes, this needs to be in REVERSE translation order since AceLocale-3.0 no longer supports reverse translations
]]


local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes","zhTW")
if not NL then return end
-- fish schools
NL["Floating Wreckage"] = "漂浮的殘骸"
NL["Patch of Elemental Water"] = "元素之水"
NL["Floating Debris"] = "漂浮的碎片"
NL["Oil Spill"] = "油井"
NL["Firefin Snapper School"] = "火鰭鯛魚群"
NL["Greater Sagefish School"] = "大型鼠尾魚魚群"
NL["Oily Blackmouth School"] = "黑口魚魚群"
NL["Sagefish School"] = "鼠尾魚魚群"
NL["School of Deviate Fish"] = "變異魚魚群"
NL["Stonescale Eel Swarm"] = "石鱗鰻魚群"
--NL["Muddy Churning Water"] = "混濁的水" ZG only
NL["Highland Mixed School"] = "高地綜合魚群"
NL["Pure Water"] = "純水"
NL["Bluefish School"] = "藍魚群"
NL["Feltail School"] = "魔尾魚群"
NL["Mudfish School"] = "泥鰍群"
NL["School of Darter"] = "淡水魚群"
NL["Sporefish School"] = "孢子魚群"
NL["Steam Pump Flotsam"] = "蒸汽幫浦漂浮殘骸"
NL["School of Tastyfish"] = "斑點可口魚魚群"

-- mine nodes
NL["Copper Vein"] = "銅礦"
NL["Tin Vein"] = "錫礦"
NL["Iron Deposit"] = "鐵礦石"
NL["Silver Vein"] = "銀礦"
NL["Gold Vein"] = "金礦石"
NL["Mithril Deposit"] = "秘銀礦脈"
NL["Ooze Covered Mithril Deposit"] = "軟泥覆蓋的秘銀礦脈"
NL["Truesilver Deposit"] = "真銀礦石"
NL["Ooze Covered Silver Vein"] = "軟泥覆蓋的銀礦脈"
NL["Ooze Covered Gold Vein"] = "軟泥覆蓋的金礦脈"
NL["Ooze Covered Truesilver Deposit"] = "軟泥覆蓋的真銀礦脈"
NL["Ooze Covered Rich Thorium Vein"] = "軟泥覆蓋的富瑟銀礦脈"
NL["Ooze Covered Thorium Vein"] = "軟泥覆蓋的瑟銀礦脈"
NL["Small Thorium Vein"] = "瑟銀礦脈"
NL["Rich Thorium Vein"] = "富瑟銀礦"
--NL["Hakkari Thorium Vein"] = "哈卡萊瑟銀礦脈" ZG only
NL["Dark Iron Deposit"] = "黑鐵礦脈"
NL["Lesser Bloodstone Deposit"] = "次級血石礦脈"
NL["Incendicite Mineral Vein"] = "火岩礦脈"
NL["Indurium Mineral Vein"] = "精鐵礦脈"
NL["Fel Iron Deposit"] = "魔鐵礦床"
NL["Adamantite Deposit"] = "堅鋼礦床"
NL["Rich Adamantite Deposit"] = "豐沃的堅鋼礦床"
NL["Khorium Vein"] = "克銀礦脈"
--NL["Large Obsidian Chunk"] = "大型黑曜石礦" AQ 40
--NL["Small Obsidian Chunk"] = "小型黑曜石礦" AQ 20/40
NL["Nethercite Deposit"] = "虛空傳喚礦床"

-- gas clouds
NL["Windy Cloud"] = "多風之雲"
NL["Swamp Gas"] = "沼氣"
NL["Arcane Vortex"] = "秘法漩渦"
NL["Felmist"] = "魔化霧"
NL["Steam Cloud"] = "Steam Cloud"
NL["Cinder Cloud"] = "Cinder Cloud"
NL["Arctic Cloud"] = "Arctic Cloud"

-- herb bushes
NL["Peacebloom"] = "寧神花"
NL["Silverleaf"] = "銀葉草"
NL["Earthroot"] = "地根草"
NL["Mageroyal"] = "魔皇草"
NL["Briarthorn"] = "石南草"
--NL["Swiftthistle"] = "雨燕草" found in other sources
NL["Stranglekelp"] = "荊棘藻"
NL["Bruiseweed"] = "跌打草"
NL["Wild Steelbloom"] = "野鋼花"
NL["Grave Moss"] = "墓地苔"
NL["Kingsblood"] = "皇血草"
NL["Liferoot"] = "活根草"
NL["Fadeleaf"] = "枯葉草"
NL["Goldthorn"] = "金棘草"
NL["Khadgar's Whisker"] = "卡德加的鬍鬚"
NL["Wintersbite"] = "冬刺草"
NL["Firebloom"] = "火焰花"
NL["Purple Lotus"] = "紫蓮花"
--NL["Wildvine"] = "野葡萄藤" found in purple lotus
NL["Arthas' Tears"] = "阿薩斯之淚"
NL["Sungrass"] = "太陽草"
NL["Blindweed"] = "盲目草"
NL["Ghost Mushroom"] = "鬼魂菇"
NL["Gromsblood"] = "格羅姆之血"
NL["Golden Sansam"] = "黃金蔘"
NL["Dreamfoil"] = "夢葉草"
NL["Mountain Silversage"] = "山鼠草"
NL["Plaguebloom"] = "瘟疫花"
NL["Icecap"] = "冰蓋草"
--NL["Bloodvine"] = "血藤" ZG only not needed atm
NL["Black Lotus"] = "黑蓮花"
NL["Felweed"] = "魔獄草"
NL["Dreaming Glory"] = "譽夢草"
NL["Terocone"] = "泰魯草"
--NL["Ancient Lichen"] = "古老青苔" instance only
NL["Bloodthistle"] = "血薊"
NL["Mana Thistle"] = "法力薊"
NL["Netherbloom"] = "虛空花"
NL["Nightmare Vine"] = "夢魘根"
NL["Ragveil"] = "拉格維花"
NL["Flame Cap"] = "火帽花"
--NL["Fel Lotus"] = "魔獄蓮花" found in other nodes
NL["Netherdust Bush"] = "虛空之塵灌木"
-- Treasure
NL["Giant Clam"] = "巨型蚌殼"
NL["Battered Chest"] = "破損的箱子"
NL["Tattered Chest"] = "破爛的箱子"
NL["Solid Chest"] = "堅固的箱子"
NL["Large Iron Bound Chest"] = "大型鐵箍儲物箱"
NL["Large Solid Chest"] = "堅固的大箱子"
NL["Large Battered Chest"] = "破碎的大箱子" --need check
NL["Buccaneer's Strongbox"] = "海盜的保險箱"
NL["Large Mithril Bound Chest"] = "大型秘銀儲物箱"
NL["Large Darkwood Chest"] = "大型黑木箱" --need check
NL["Practice Lockbox"] = "練習用帶鎖箱"
NL["Battered Footlocker"] = "破碎的提箱"
NL["Waterlogged Footlocker"] = "浸水的提箱"
NL["Dented Footlocker"] = "被砸過的箱子"
NL["Mossy Footlocker"] = "生苔的提箱"
NL["Scarlet Footlocker"] = "血色十字軍提箱"
NL["Burial Chest"] = "埋葬箱"
NL["Fel Iron Chest"] = "魔鐵箱"
NL["Heavy Fel Iron Chest"] = "沉重的魔鐵箱"
NL["Adamantite Bound Chest"] = "堅鋼裝訂箱"
NL["Felsteel Chest"] = "魔鋼箱"
NL["Wicker Chest"] = "柳條箱"
NL["Primitive Chest"] = "遠古箱子"
NL["Solid Fel Iron Chest"] = "堅固的魔鐵箱"
NL["Bound Fel Iron Chest"] = "受封的魔鐵箱"
--NL["Bound Adamantite Chest"] = "受封的堅鋼箱子" -- Only appears in instances
-- New added
--NL["Cabal Chest"] = "秘教寶箱"
--NL["Ornate Chest"] = "華麗的箱子"
--NL["Massive Treasure Chest"] = "大型寶箱"
--NL["Reinforced Fel Iron Chest"] = "強化魔鐵箱"
--NL["Primitive Chest"] = "粗糙的箱子"
--NL["Dust Covered Chest"] = "灰塵覆蓋的箱子"
--other
NL["Un'Goro Dirt Pile"] = "安戈落泥土堆"
NL["Bloodpetal Sprout"] = "血瓣花苗"
NL["Blood of Heroes"] = "英雄之血"
NL["Glowcap"] = "白閃菇"
NL["Netherwing Egg"] = "虛空之翼蛋"
--NL["Un'Goro Power Crystal"] = "安戈落能量水晶"
--NL["Night Dragon's Breath"] = "夜龍之息"
--NL["Whipper Root Tuber"] = "鞭根塊莖"
--NL["Windblossom Berries"] = "風花果"
--NL["SongFlower"] = "輕歌花"
--NL["Oshu'gun Crystal Fragment"] = "沃舒古水晶碎片"
--NL["Apexis Shard Formation"] = "埃匹希斯碎片簇"
--NL["Mature Spore Sac"] = "成熟的孢子囊"
