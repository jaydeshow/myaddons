local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Cartographer_QuestInfo")

L:AddTranslations("zhCN", function() return {

-- Core.lua
	["Export"] = "汇出资料",
	["Export quest data to other addon."] = "汇出任务数据到别的插件模块。",
	["Quests"] = "任务起始",
	["Export quest data to Cartographer Quests."] = "汇出任务数据到「任务起始」模块。",
	["Export data"] = "汇出任务数据",
	["Export quest data, this will take huge space."] = "汇出任务数据，这将会占用很大的内存空间。",
	["Clear exported data"] = "清除已汇出资料",
	["Clear exported data."] = "清除已汇出资料。",
	["Quest Objectives"] = "任务目标",
	["Export quest data to Cartographer QuestObjectives."] = "汇出任务数据到「任务目标」模块。",
	["Icon alpha"] = "图示透明度",
	["Alpha transparency of the icon."] = "地图上的图示透明度。",
	["Icon size"] = "图示大小",
	["Size of the icons on the map."] = "地图上的图示大小。",
	["Show minimap icons"] = "在小地图上显示",
	["Show quest icons on the minimap."] = "在小地图上显示任务图标。",
	["Show world map button"] = "显示'任务信息'按钮",
	["Show button on the world map."] = "在世界地图上显示'任务信息'的设定按钮。",
	["Show quest level"] = "显示任务等级",
	["Show quest level in quest log and NPC dialog."] = "在任务窗口及对话框显示任务等级。",
	["Make quest log double wide"] = "加宽任务窗口",
	["Make the quest log window double wide, this will require UI reload."] = "加宽显示任务窗口，注意:这功能需要重载UI后才能改变。",
	["Quest Info"] = "任务信息",
	["Module description"] = "提供任务数据",
	["Exporting %d quest givers..."] = "已汇出 %d 个任务起始点...",
	["Total %d quest givers have been exported."] = "总计汇出 %d 个任务起始点。",
	["Clear old exported quest givers first."] = "首先清除旧的任务起始点。",
	["Begin exporting new quest givers."] = "开始汇出新的任务起始点。",
	["Exporting %d quest objects..."] = "已汇出 %d 个任务目标...",
	["Total %d quest objects have been exported."] = "总计汇出 %d 个任务目标。",
	["Clear old exported objectives first."] = "首先清除旧的任务目标。",
	["Begin exporting new quest objectives."] = "开始汇出新的任务目标。",

-- LocationFrame.lua
	["Close"] = "关闭",

-- Map.lua
	["Quest Start"] = "任务开始",
	["Quest End"] = "任务结束",
	["Quest Giver"] = "任务委托人",
	["Quest Objective"] = "任务目标",
	["Show active quests"] = "标示目前任务",
	["Show all info of active quests in current map."] = "在目前地图上标示进行中的任务目标。",
	["Show available quests"] = "标示可接的任务",
	["Show the givers of available quests in current map."] = "在目前地图上标示可接的任务委托人。",
	["Clear quest icons"] = "清除任务图标",
	["Clear quest icons generated by QuestInfo"] = "清除由任务信息所产生的图标。",
	["Open QuestInfo menu"] = "开启任务信息选项",
	["Alt-Click: "] = "Alt-点击: ",
	["Shift-Click: "] = "Shift-点击: ",
	["Elite"] = "精英",
	["Rare Elite"] = "稀有精英",
	["Boss"] = "首领",
	["Name:"] = "名称:",
	["Objective:"] = "目标:",
	["Source:"] = "来源:",
	["Level:"] = "等级:",
	["Location:"] = "坐标:",
	["Quests:"] = "任务:",
	["%d Quests"] = "%d个任务",

-- QuestFuPatch.lua
	["(done)"] = "(完成)",

-- QuestLogPatch.lua
	[" ..."] = " …",
	["... more"] = "… 还有更多",

-- SeriesFrame.lua
	["Quest Series"] = "系列任务",
	["Requires:"] = "需要等级:",
	["Sharable"] = "可分享",
	["Series:"] = "任务系列:",

} end)
