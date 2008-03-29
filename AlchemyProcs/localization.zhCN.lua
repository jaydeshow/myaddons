if( GetLocale() == "zhCN" ) then

	AlchemyProcsLocals = {

		["Addon Loaded"] = "AlchemyProcs 载入成功",
		["Invalid command"] = "%s是一个无效的指令",
		
		["Alchemy"] = "炼金术",
		["Elixir Master"] = "药剂大师",
		["Potion Master"] = "药水大师",
		["Transmutation Master"] = "转化大师",
	
		["Item"] = "物品",
		["Created"] = "制造数量",
		["Made"] = "制造次数",
		["Procs"] = "爆击次数",
		
		["Proc"] = {
			"+1","+2","+3","+4",
			[0] = "未爆击",
		},
	
		["Total"] = "总计",
	
		["All data cleared"] = "所有记录已清除",
		["Data removed"] = "%s的记录已清除",
		["No such data"] = "无此记录",
		["Data"] = " %s的记录:",
	
		["Data updated"] = "|cfffff468 你的数据是由过去某个版本保存的.它们已经转换为当前版本所使用的格式|r",
		["GUI reseted"] = "你的窗口设置是由过去某个版本保存的. 它们将转换为当前版本所使用的格式",

		["Help"] = {
			"AlchemyProcs 命令行帮助",
			"|cfffff468 格式:|r /AlchemyProcs 或 /ap [命令] [参数]",
			"|cfffff468 /ap |r打开GUI界面",
			"|cfffff468 /ap l[ist] all|<物品链接>|<物品名称>|<物品Id>  |r 在聊天窗口显示所有|指定物品记录",
			"|cfffff468 /ap r[emove] <物品链接>|<物品名称>|<物品Id>  |r 清除指定物品记录",
			"|cfffff468 /ap clear  |r 清除所有物品记录",
			"|cfffff468 /ap h[elp]|?  |r 显示帮助信息",
		},
	}

end
