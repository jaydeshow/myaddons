local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("zhCN", function() return {
	["Solo"] = "未组队",
	group = "队伍分配",
	master = "队长分配",
	freeforall = "自由拾取",
	roundrobin = "轮流拾取",
	needbeforegreed = "需求优先",
	["ML (%s)"] = "物品分配 (%s)",
	["No rolls"] = "无Roll",

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = "Roll 5秒后结束！已记录：%d/%d组纪录。",

	["Winner: %s."] = "胜利者: %s。",
	[", "] = "，",
	["Tie: %s are tied at %d."] = "平手: %s 掷出 %d。",
	["%s (%d/%d)"] = "%s (%d/%d)",
	["%s [%s]"] = "%s [%s]",
	["%d of expected %d rolls recorded."] = "共有 %d / %d位Roll 已记录。",

	["Perform roll when clicked"] = "点击进行Roll",
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = "点击完成一次标准1-100的Roll。",
	["Announce"] = "宣布胜利者",
	["Only accept 1-100"] = "只接受 1-100 Roll",
	["Accept standard (1-100) rolls only."] = "只接受标准的 Roll(1-100)。",
	["Loot type"] = "拾取模式",
	["Set the loot type."] = "设定拾取模式。",
	["Loot threshold"] = "品质界定",
	["Set the loot threshold."] = "设定物品Roll品质界定。",

	["Where to output roll results."] = "选择在哪儿贴出Roll结果。",
	["Auto (based on group type)"] = "自动选择贴出频道(根据组队情况)",
	["Local"] = "显示结果在屏幕上",
	["Say"] = "显示结果到说话(/s)频道",
	["Party"] = "显示结果到队伍(/p)频道",
	["Raid"] = "显示结果到团队(/ra)频道",
	["Guild"] = "显示结果到公会(/g)频道",
	["Don't announce"] = "不宣布结果",

	["Roll clearing"] = "自动清除Roll记录",
	["When to clear the rolls."] = "选择自动清除Roll记录的时间。",
	["Never"] = "从不",
	["15 seconds"] = "15秒",
	["30 seconds"] = "30秒",
	["45 seconds"] = "45秒",
	["60 seconds"] = "60秒",

	["Roll"] = "Roll",
	["Player"] = "参与者",
	["Loot method"] = "分配方式",
	["Master looter"] = "队长分配",
	["Leader"] = "团长",
	["Officers"] = "官员",
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55f点击|r 进行Roll, |cffeda55fCtrl-点击|r 显示胜利者, |cffeda55fShift-点击|r 清除记录列表.",
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fCtrl-点击|r 显示胜利者, |cffeda55fShift-点击|r 清除记录列表.",

	["Pass"] = "放弃",
	["Everyone passed."] = "所有人都已放弃",

	["Leave Party"] = "离开队伍",
	["Leave your current party or raid."] = "离开你当前的队伍或者团队。",

	["Reset Instances"] = "重置副本",
	["Reset all available instance the group leader has active."] = "重置所有队长所开启的副本。",
} end)

