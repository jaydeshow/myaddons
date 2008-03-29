local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("zhTW", function() return {
	["Solo"] = "單練",
	group = "隊伍分配",
	master = "隊長分配",
	freeforall = "自由拾取",
	roundrobin = "輪流拾取",
	needbeforegreed = "需求優先",
	["ML (%s)"] = "隊長 (%s)",
	["No rolls"] = "無人擲骰",

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = "擲骰5秒內結束，記錄了%d/%d組擲骰者。",

	["Winner: %s."] = "優勝: %s。",
	[", "] = "，",
	["Tie: %s are tied at %d."] = "同分: %s都%d點。",
	["%s (%d/%d)"] = "%s (%d/%d)",
	["%s [%s]"] = "%s [%s]",
	["%d of expected %d rolls recorded."] = "已記錄%d/%d位擲骰者。",

	["Perform roll when clicked"] = "左擊擲骰",
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = "左擊時使用標準擲骰 (1-100)。",
	["Announce"] = "發表擲骰結果",
	["Only accept 1-100"] = "只接受1-100",
	["Accept standard (1-100) rolls only."] = "只接受標準擲骰 (1-100)。",
	["Loot type"] = "拾取方式",
	["Set the loot type."] = "設定拾取方式。",
	["Loot threshold"] = "物品分配界限",
	["Set the loot threshold."] = "設定物品分配界限。",

	["Where to output roll results."] = "設定何處顯示擲骰結果。",
	["Auto (based on group type)"] = "自動 (依組隊狀態)",
	["Local"] = "聊天視窗",
	["Say"] = "說",
	["Party"] = "隊伍",
	["Raid"] = "團隊",
	["Guild"] = "公會",
	["Don't announce"] = "不發表",

	["Roll clearing"] = "清除結果",
	["When to clear the rolls."] = "設定何時清除擲骰結果。",
	["Never"] = "絕不",
	["15 seconds"] = "15秒",
	["30 seconds"] = "30秒",
	["45 seconds"] = "45秒",
	["60 seconds"] = "60秒",

	["Roll"] = "擲骰",
	["Player"] = "玩家",
	["Loot method"] = "拾取方式",
	["Master looter"] = "隊長分配",
	["Leader"] = "團隊隊長",
	["Officers"] = "團隊副手",
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "\n|cffeda55f左擊: |r擲骰。\n|cffeda55fCtrl-左擊: |r輸出贏家。\n|cffeda55fShift-左擊: |r清除列表。",
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "\n|cffeda55fCtrl-左擊: |r輸出贏家。\n|cffeda55fShift-左擊: |r清除列表。",

	["Pass"] = "放棄",
	["Everyone passed."] = "全部人都已放棄。",

	["Leave Party"] = "離開組隊",
	["Leave your current party or raid."] = "離開你目前的隊伍或團隊。",
	
--	["Reset Instances"] = true,
--	["Reset all available instance the group leader has active."] = true,
	
} end)

