--[[
Chinese simplified
]]
local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate","zhCN")
if not L then return end
-- Spell names for Collector module
L["Mining"] = "采矿"
L["Fishing"] = "钓鱼"
L["Herb Gathering"] = "采集草药"
L["Extract Gas"] = "提炼气体"
L["Herbalism"] = "草药学"
L["Engineering"] = "工程学"
L["Opening"] = "打开"
L["Pick Lock"] = "开锁"
-- Display module
L["GatherMate Pin Options"] = "GatherMate Pin选项"
L["Delete: "] = "删除："
L["Add this location to Cartographer_Waypoints"] = "将该地点加入Cartographer_Waypoints"
L["Add this location to TomTom waypoints"] = "将该地点加入TomTom节点"

L["Always show"] = "总是显示"
L["Only with profession"] = "仅显示专业相关"
L["Only while tracking"] = "仅显示追踪相关"
L["Never show"] = "从不显示"

-- Config modules
L["GatherMate"]="GatherMate"
L["gathermate"]="gathermate" -- slash command
---- Display Filters tree
L["Display Settings"] = "显示设置"
------ General subtree
L["General"] = "一般设置"
L["Show Databases"] = "显示数据"
L["Selected databases are shown on both the World Map and Minimap."] = "选择在世界地图和迷你地图上显示数据。"
L["Show Mining Nodes"]="显示矿脉"
L["Toggle showing mining nodes."]="切换显示矿脉采集点。"
L["Show Herbalism Nodes"]="显示草药"
L["Toggle showing herbalism nodes."]="切换显示草药采集点。"
L["Show Fishing Nodes"]="显示鱼群"
L["Toggle showing fishing nodes."]="切换显示鱼群垂钓点。"
L["Show Gas Clouds"]="显示气云"
L["Toggle showing gas clouds."]="切换显示气云(微粒采集点)。"
L["Show Treasure Nodes"]="显示宝藏"
L["Toggle showing treasure nodes."]="切换显示财宝地点。"
L["Icons"] = "图标"
L["Control various aspects of node icons on both the World Map and Minimap."] = "控制你想要在世界地图和迷你地图上显示的多种节点图标。"
L["Show Minimap Icons"]="显示迷你地图图标"
L["Toggle showing Minimap icons."] = "切换显示图标与否(在小地图上)。"
L["Show World Map Icons"] = "显示世界地图图标"
L["Toggle showing World Map icons."] = "切换显示图标与否(在世界地图上)。"
L["Keybind to toggle Minimap Icons"] = "给迷你地图图标的显示设置按键绑定。"
L["Icon Scale"] = "图标缩放"
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = "图标缩放，这个选项让你把世界地图和迷你地图上的图标放大或缩小。"
L["Icon Alpha"] = "图标透明度"
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = "图标透明度，这个选项让你更改图标的透明度，仅作用于世界地图！"
L["Miscellaneous"] = "杂项"
-- Cleanup subtree (now Database Maintenance)
L["Database Maintenance"] = "数据库选项"
L["Cleanup_Desc"] = "经过一段时间后，你的数据库可能会非常大，清理数据可以让你的相同专业的在一定范围内的数据合并为一个，以避免重复。"
L["Cleanup radius"] = "清理半径"
L["CLEANUP_RADIUS_DESC"] = "设置以码为单位的半径，在半径内的数据将被清除。默认设置为 |cffffd20050|r 码(气体云雾)/ |cffffd20015|r 码（其他采集数据）。这些设置也被用于增加的节点。"
L["Cleanup Database"] = "清理数据"
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = "清理你的数据库，移除重复数据。这个过程可能持续几分钟，请耐心等待。"
L["Processing "] = "处理 "
L["Cleanup Complete."] = "清理结束！"
L["Delete Specific Nodes"] = ""
L["DELETE_SPECIFIC_DESC"] = "Remove all of the selected node from the selected zone. You must disable Database Locking for this to work."
L["Select Database"] = "选择数据库"
L["Select Node"] = "选择节点"
L["Select Zone"] = "选择地区"
L["Delete"] = "删除"
L["Delete selected node from selected zone"] = "从选择的地区删除选择的节点"
L["Are you sure you want to delete all of the selected node from the selected zone?"] = "你确认要删除已选中地区的所有已选中的节点？"
L["Delete Entire Database"] = "删除整个数据库"
L["DELETE_ENTIRE_DESC"] = "这个选项将会忽略数据库的锁定设置，删除所有选中的数据库的数据！"
L["Are you sure you want to delete all nodes from this database?"] = "你确认你想要删除这个数据库的所有数据？"
L["Database Locking"] = "数据库锁定"
L["DATABASE_LOCKING_DESC"] = "锁定数据库选项将冻结你的数据库状态。一旦你锁定了数据库，对其任何操作(增加节点、删除节点、修改节点包括清理数据库和导入数据库)均不可用。"
L["Database locking"] = "数据库已被锁定"

-- Tracking options
L["Tracking Circle Color"] = "追踪环颜色"
L["Color of the tracking circle."] = "追踪环的颜色。"
L["Tracking Distance"] = "追踪距离"
L["The distance in yards to a node before it turns into a tracking circle"] = "在一个节点变成追踪环之前的距离。"
L["Show Tracking Circle"] = "显示追踪环"
L["Toggle showing the tracking circle."] = "切换是否显示追踪环。"
L["Show Nodes on Minimap Border"] = "迷你地图边界显示"
L["Shows more Nodes that are currently out of range on the minimap's border."] = "在迷你地图边界上显示哪些超出迷你地图的节点。"
------ Filters subtree
L["Filters"] = "过滤"
L["Herb filter"] = "草药过滤"
L["Select the herb nodes you wish to display."]= "选择你想要显示的草药节点。"
L["Mine filter"] = "矿脉过滤"
L["Select the mining nodes you wish to display."] = "选择你想要显示的矿脉节点。"
L["Fish filter"] = "渔点过滤"
L["Select the fish nodes you wish to display."] = "选择你想要显示的渔点节点。"
L["Gas filter"] = "气体云雾过滤"
L["Select the gas clouds you wish to display."] = "选择你想要显示的气体云雾节点。"
L["Treasure filter"] = "财宝过滤"
L["Select the treasure you wish to display."] = "选择你想要显示的财宝节点。"
L["Select All"] = "全部选择"
L["Select all nodes"] = "选择全部节点"
L["Clear node selections"] = "清除选择的节点"
L["Select None"] = "清空选择"
L["Gas Clouds"]= "气体云雾"
L["Fishes"] = "渔点"
L["Mineral Veins"] = "矿脉"
L["Herb Bushes"] = "草药"
L["Treasure"] = "财宝"
L["Filter_Desc"] = "选择你想要在世界地图和迷你地图上显示的节点类型，不选择的类型将仅记录在数据库中。"
---- Import tree
L["Import Data"] = "导入数据"
L["Import GatherMateData"] = "导入GatherMateData"
L["Importing_Desc"] = "导入允许GatherMate从其他来源获取节点数据。导入结束后，你最好进行一次数据清理。"
L["Load GatherMateData and import the data to your database."] = "载入GatherMateData并把其中的数据导入你的数据库"
L["GatherMateData has been imported."] = "GatherMateData已经被导入。"
L["Failed to load GatherMateData due to "] = "载入GatherMateData失败："
L["Merge"] = "合并"
L["Overwrite"] = "覆盖"
L["Import Style"] = "导入模式"
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = "合并将GatherMateDate数据加入你的数据库，覆盖将用GatherMateData中的数据替换你现有的数据库"
L["Databases to Import"] = "导入的数据库"
L["Databases you wish to import"] = "你想要导入的数据库"
L["Auto Import"] = "自动导入"
L["Automatically import when ever you update your data module, your current import choice will be used."] = "当你升级你的数据模块的时候自动导入升级后的数据，你当前的导入选项将控制导入的数据类型。"
L["Auto import complete for addon "] = "自动导入数据源："
L["BC Data Only"] = "仅燃烧远征的数据"
L["Only import Burning Crusade data from WoWHead"] = "仅导入燃烧远征的数据(WoWHead版本)"
--- profile settings
L["Default"] = "默认"
L["Char:"] = "人物："
L["Realm:"] = "国度："
L["Class:"] = "职业："
L["Profiles"] = "配置"
L["Manage Profiles"] = "管理配置"
L["You can change the active database profile of GatherMate, so you can have different settings and filters for every character, which will allow a very flexible configuration for everyones needs."] = "你可以更改GaterMate启用的配置，方便你为不同的人物进行设置，这将会给你带来非常弹性的配置方法。"
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = "重置你当前的配置，仅在配置文件出错或者你想要重新配置的时候选择！"
L["You can create a new profile by entering a new name in the editbox, or choosing one of the already exisiting profiles."] = "你可以在一下的编辑框中创建一个新的配置，或者选择一个已经创建的配置"
L["Reset Profile"] = "重置配置"
L["Reset the current profile to the default"] = "把当前的配置重设为默认值"
L["New"] = "新配置"
L["Create a new empty profile."] = "创建一个新的配置文件"
L["Current"] = "当前配置"
L["Select one of your currently available profiles."] = "选择一个你想要起作用的配置"
L["Copy the settings from one existing profile into the currently active profile."] = "从其他配置文件中拷贝一个到当前配置文件"
L["Copy From"] = "拷贝于："
L["Copy the settings from another profile into the active profile."] = "从其他配置文件拷贝到当前配置文件"
L["Delete existing and unused profiles from the database to save space, and cleanup the GatherMate SavedVariables file."] = "删除位使用的配置，以清理GatherMate的SavedVariables文件。"
L["Delete a Profile"] = "删除配置"
L["Deletes a profile from the database."] = "从数据库中删除一个配置"
L["Are you sure you want to delete the selected profile?"] = "你确认要删除该配置？"
-- FAQ
L["FAQ"] = "FAQ"
L["Frequently Asked Questions"] = "常见问题解答"
L["FAQ_TEXT"] = [[
|cffffd200
我安装了GatherMate，但是却不能在地图上看见任何节点，这是怎么回事？
|r
GatherMate本身是不包含任何数据的，你如果想要数据，可以安装GatherMate_Data并导入数据库。GatherMate的工作原理是，当你采集任何资源，包括草药，矿脉，采集气体或者钓鱼的时候将该点记录下来，然后在地图上标出。另外，你也要查看你的显示选项是否设置正确。

|cffffd200
我在世界地图上看到了节点，但是在迷你地图上却没有，这是为什么？
|r
|cffffff78Minimap Button Bag|r (或者类似的插件) 很可能会把你所有的迷你地图按钮收起，禁用它们！

|cffffd200
我在哪里可以找到数据库下载啊？
|r
你可以通过以下途径获取GatherMate的数据库:

1. |cffffff78GatherMate_Data|r - 这个插件是WoWHead网站的数据库的GatherMate版本，它每周都更新一次，你可以打开自动更新选项，在其更新后，自动更新你的数据库。

2. |cffffff78GatherMate_CartImport|r - 这个插件将导入 |cffffff78Cartographer_<Profession>|r 已存在的数据库到GatherMate。你必须保证GatherMate_CartImport和 |cffffff78Cartographer_<Profession>|r 同时启用才可进行导入工作。

注意：该导入动作不是自动进行的，你必须进入“导入数据”选项，然后点击“导入”按钮。

如果 |cffffff78Cartographer_Data|r 中的数据和GatherMate数据不符，用户将被提示选择数据库修改的方式, |cffffff78Cartographer_Data|r载入时，可能会导致你新建立的节点在不被警告的自动覆盖！

|cffffd200
你可以增加邮箱或者飞行管理员的数据支持么？
|r
不，我不会。尽管可能会有其他的作者以插件的形式支持，但是GatherMate的核心组件将不会支持该功能。

|cffffd200
我发现一处Bug！我到哪里去报告啊？
|r
你可以到如下网址反应Bug和提供建议: |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r

你也可以在这里找到我们： |cffffff78irc://irc.freenode.org/wowace|r

当反应Bug的时候，请确认你在|cffffff78何种步骤|r下产生的该Bug，并尽可能提供所有的|cffffff78错误信息|r，并请提供出错的GatherMate|cffffff78版本号|r，以及你当是使用的|cffffff78魔兽世界的客户端语言|r。

|cffffd200
谁写出了这么Cool的插件？
|r
Kagaro, Xinhuan, Nevcairiel 以及 Ammo
]]

--[[
We have a second translation list to handle just nodes, this needs to be in REVERSE translation order since AceLocale-3.0 no longer supports reverse translations
]]


local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes","zhCN")
if not NL then return end
-- fish schools
NL["Floating Wreckage"] = "漂浮的残骸"
NL["Patch of Elemental Water"] = "元素之水"
NL["Floating Debris"] = "漂浮的碎片"
NL["Oil Spill"] = "油井"
NL["Firefin Snapper School"] = "火鳞鳝鱼群"
NL["Greater Sagefish School"] = "大型鼠尾鱼群"
NL["Oily Blackmouth School"] = "黑口鱼群"
NL["Sagefish School"] = "鼠尾鱼群"
NL["School of Deviate Fish"] = "变异鱼群"
NL["Stonescale Eel Swarm"] = "石鳞鳗群"
--NL["Muddy Churning Water"] = "混浊的水" ZG Only
NL["Highland Mixed School"] = "高地杂鱼群"
NL["Pure Water"] = "纯水"
NL["Bluefish School"] = "蓝鱼群"
--NL["Feltail School"] = "魔尾鱼群" no longer exist in 2.4
NL["Brackish Mixed School"] = "混水鱼类"
NL["Mudfish School"] = "泥鱼群"
NL["School of Darter"] = "金镖鱼群"
NL["Sporefish School"] = "孢子鱼群"
NL["Steam Pump Flotsam"] = "蒸汽泵废料"
NL["School of Tastyfish"] = "可口鱼"

-- mine nodes
NL["Copper Vein"] = "铜矿"
NL["Tin Vein"] = "锡矿"
NL["Iron Deposit"] = "铁矿石"
NL["Silver Vein"] = "银矿"
NL["Gold Vein"] = "金矿石"
NL["Mithril Deposit"] = "秘银矿脉"
NL["Ooze Covered Mithril Deposit"] = "软泥覆盖的秘银矿脉"
NL["Truesilver Deposit"] = "真银矿石"
NL["Ooze Covered Silver Vein"] = "软泥覆盖的银矿脉"
NL["Ooze Covered Gold Vein"] = "软泥覆盖的金矿脉"
NL["Ooze Covered Truesilver Deposit"] = "软泥覆盖的真银矿脉"
NL["Ooze Covered Rich Thorium Vein"] = "软泥覆盖的富瑟银矿脉"
NL["Ooze Covered Thorium Vein"] = "软泥覆盖的瑟银矿脉"
NL["Small Thorium Vein"] = "瑟银矿脉"
NL["Rich Thorium Vein"] = "富瑟银矿"
--NL["Hakkari Thorium Vein"] = "哈卡莱瑟银矿脉" ZG only
NL["Dark Iron Deposit"] = "黑铁矿脉"
NL["Lesser Bloodstone Deposit"] = "次级血石矿脉"
NL["Incendicite Mineral Vein"] = "火岩矿脉"
NL["Indurium Mineral Vein"] = "精铁矿脉"
NL["Fel Iron Deposit"] = "魔铁矿脉"
NL["Adamantite Deposit"] = "精金矿脉"
NL["Rich Adamantite Deposit"] = "富精金矿脉"
NL["Khorium Vein"] = "氪金矿脉"
--NL["Large Obsidian Chunk"] = "大型黑曜石碎块" AQ 40
--NL["Small Obsidian Chunk"] = "小型黑曜石碎块" AQ 20/40
NL["Nethercite Deposit"] = "虚空矿脉"

-- gas clouds
NL["Windy Cloud"] = "气体云雾"
NL["Swamp Gas"] = "沼泽毒气"
NL["Arcane Vortex"] = "奥术漩涡"
NL["Felmist"] = "魔雾"
NL["Steam Cloud"] = "Steam Cloud"
NL["Cinder Cloud"] = "Cinder Cloud"
NL["Arctic Cloud"] = "Arctic Cloud"

-- herb bushes
NL["Peacebloom"] = "宁神花"
NL["Silverleaf"] = "银叶草"
NL["Earthroot"] = "地根草"
NL["Mageroyal"] = "魔皇草"
NL["Briarthorn"] = "石南草"
--NL["Swiftthistle"] = "雨燕草" found in other sources
NL["Stranglekelp"] = "荆棘藻"
NL["Bruiseweed"] = "跌打草"
NL["Wild Steelbloom"] = "野钢花"
NL["Grave Moss"] = "墓地苔"
NL["Kingsblood"] = "皇血草"
NL["Liferoot"] = "活根草"
NL["Fadeleaf"] = "枯叶草"
NL["Goldthorn"] = "金棘草"
NL["Khadgar's Whisker"] = "卡德加的胡须"
NL["Wintersbite"] = "冬刺草"
NL["Firebloom"] = "火焰花"
NL["Purple Lotus"] = "紫莲花"
--NL["Wildvine"] = "野葡萄藤" found in purple lotus
NL["Arthas' Tears"] = "阿尔萨斯之泪"
NL["Sungrass"] = "太阳草"
NL["Blindweed"] = "盲目草"
NL["Ghost Mushroom"] = "幽灵菇"
NL["Gromsblood"] = "格罗姆之血"
NL["Golden Sansam"] = "黄金参"
NL["Dreamfoil"] = "梦叶草"
NL["Mountain Silversage"] = "山鼠草"
NL["Plaguebloom"] = "瘟疫花"
NL["Icecap"] = "冰盖草"
--NL["Bloodvine"] = "血藤" ZG only not needed atm
NL["Black Lotus"] = "黑莲花"
NL["Felweed"] = "魔草"
NL["Dreaming Glory"] = "梦露花"
NL["Terocone"] = "泰罗果"
--NL["Ancient Lichen"] = "远古苔" instance only
NL["Bloodthistle"] = "血蓟"
NL["Mana Thistle"] = "法力蓟"
NL["Netherbloom"] = "虚空花"
NL["Nightmare Vine"] = "噩梦藤"
NL["Ragveil"] = "邪雾草"
NL["Flame Cap"] = "烈焰菇"
--NL["Fel Lotus"] = "魔莲花" found in other nodes
NL["Netherdust Bush"] = "灵尘灌木丛"
-- Treasure
NL["Giant Clam"] = "巨型贝壳"
NL["Battered Chest"] = "破损的箱子"
NL["Tattered Chest"] = "联盟宝箱"
--NL["Tattered Chest"] = "部落储物箱" --??have 2 trans in zhCN
NL["Solid Chest"] = "坚固的箱子"
NL["Large Iron Bound Chest"] = "大型铁箍储物箱"
NL["Large Solid Chest"] = "坚固的大箱子"
NL["Large Battered Chest"] = "破损的大箱子" --need check
NL["Buccaneer's Strongbox"] = "海盗的保险箱"
NL["Large Mithril Bound Chest"] = "大型秘银储物箱"
NL["Large Darkwood Chest"] = "大型黑木箱" --need check
NL["Practice Lockbox"] = "练习用保险箱"
NL["Battered Footlocker"] = "破碎的提箱"
NL["Waterlogged Footlocker"] = "浸水的提箱"
NL["Dented Footlocker"] = "凹陷的提箱"
NL["Mossy Footlocker"] = "生苔的提箱"
NL["Scarlet Footlocker"] = "血色十字军提箱"
NL["Burial Chest"] = "埋起来的箱子"
NL["Fel Iron Chest"] = "魔铁宝箱"
NL["Heavy Fel Iron Chest"] = "重型魔铁宝箱"
NL["Adamantite Bound Chest"] = "加固精金宝箱"
NL["Felsteel Chest"] = "魔钢宝箱"
NL["Wicker Chest"] = "柳条箱"
NL["Primitive Chest"] = "粗糙的箱子"
NL["Solid Fel Iron Chest"] = "坚固的魔铁宝箱"
NL["Bound Fel Iron Chest"] = "加固魔铁宝箱"
--NL["Bound Adamantite Chest"] = "加固精金宝箱" -- Only appears in instances, and also conflicting reverse lookup table with 7 lines up.
-- New added
--NL["Cabal Chest"] = "秘教宝箱"
--NL["Ornate Chest"] = "华丽的箱子"
--NL["Massive Treasure Chest"] = "大型宝箱"
--NL["Reinforced Fel Iron Chest"] = "强化魔铁箱"
--NL["Primitive Chest"] = "粗糙的箱子"
--NL["Dust Covered Chest"] = "灰尘覆盖的箱子"
--NL["Old Treasure Chest"] = "旧宝藏箱"
--NL["Coilskar Chest"] = "库斯卡宝箱"
--NL["Solid Adamantite Chest"] = "坚固的精金宝箱"
--NL["Storage Chest"] = "储物箱"
--NL["Reinforced Fel Iron Chest"] = "强化魔铁箱"
--NL["Worn Chest"] = "旧箱子"
--NL["Waterlogged Chest"] = "浸水的箱子"
--other
NL["Un'Goro Dirt Pile"] = "安戈落泥土堆"
NL["Bloodpetal Sprout"] = "血瓣花苗"
NL["Blood of Heroes"] = "英雄之血"
NL["Glowcap"] = "亮顶蘑菇"
NL["Netherwing Egg"] = "灵翼龙卵"
--NL["Un'Goro Power Crystal"] = "安戈落能量水晶"
--NL["Night Dragon's Breath"] = "夜龙之息"
--NL["Whipper Root Tuber"] = "鞭根块茎"
--NL["Windblossom Berries"] = "风花果"
--NL["SongFlower"] = "轻歌花"
--NL["Oshu'gun Crystal Fragment"] = "沃舒古水晶碎片"
--NL["Apexis Shard Formation"] = "埃匹希斯碎片簇"
--NL["Mature Spore Sac"] = "成熟的孢子囊"
