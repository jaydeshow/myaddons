﻿local L = AceLibrary("AceLocale-2.2"):new("FreeRefills")

L:RegisterTranslations("zhCN", function() return {
	["Add"] = "添加",
	["Add an item to the refill list. (Usage: /freerefills add [Item Link] #)"] = "添加一个物品到补购列表。(用法：/freerefills add [物品链接] 数量)",
	["[Item Link] <number of items>"] = "[物品链接] <数量>",
	["Add Stack"] = "以组添加",
	["Add an item to the refill list by stack. (Usage: /freerefills addstack [Item Link] #)"] = "以组为单位添加物品到补购列表。(用法：/freerefills addstack [物品链接] 数量)",
	["[Item Link] <number of stacks>"] = "[物品链接] <组的数量>",
	["Remove"] = "删除",
	["Remove an item from the refill list. (Usage: /freerefills del [Item Link])"] = "从补购列表删除某个物品。(用法：/freerefills del [物品链接])",
	["[Item Link]"] = "[物品链接]",
	["Overstock"] = "过量补购",
	["Toggle Overstocking.  If an item is sold in stacks and cannot meet your exact requested amount, you can opt to buy slightly more (Overstock)."] = "切换过量补购。假如某件物品是以组形式售卖的，并且无法恰好满足你的要求数量时，你可以选择稍微多买一点(过量补购)。",
	["Process Merchant"] = "从商人补充",
	["Toggle Merchant Looting."] = "当开启商人窗口时自动补充物品。",
	["Process Bank"] = "从银行补充",
	["Toggle Bank Looting."] = "当开启银行窗口时自动补充物品。",
	["Clear"] = "清除列表",
	["Clear the refill list completely."] = "将补购列表完全清除。",
	["List"] = "查看列表",
	["List the items in the refill list."] = "列出补购列表中存在的物品。",
	["Added %s - Amount:%d"] = "已添加%s - 数量：%d",
	["Removed %s."] = "已删除%s。",
	["Item List Cleared"] = "补购列表已清除",
	["Refill List: "] = "补购列表：",
	["     None"] = "     无内容",
	["Invalid input; input must be '<item> #'."] = "命令不正确，必须是“<物品> 数量”的形式。",
}
end)
