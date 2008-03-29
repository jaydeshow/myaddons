--[[ $Id: BagFuLocale-zhCN.lua 54491 2007-11-13 15:02:02Z cwdg $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("FuBar_BagFu")

L:RegisterTranslations("zhCN", function() return {
	["Ammo/Soul Bags"] = "弹药袋/灵魂袋",
	["Profession Bags"] = "专业背包",
	["Bag Depletion"] = "背包已使用状态",
	["Include ammo/soul bags"] = "包括弹药袋/灵魂袋",
	["Include profession bags"] = "包括专业背包",
	["Show depletion of bags"] = "显示背包剩余空间",
	["Bag Total"] = "背包总容量",
	["Show total amount of space in bags"] = "显示背包总容量大小",

	["Soul Bag"] = "灵魂袋",
	["Enchanting Bag"] = "附魔材料袋",
	["Herb Bag"] = "草药袋",
	["Engineering Bag"] = "工程学材料袋",
	["Quiver"] = "箭袋",
	["Ammo Pouch"] = "弹药袋",
	["Mining Bag"] = "矿物包",
	["Gem Bag"] = "珠宝袋",

	["Click to open your bags"] = "点击打开你的背包",
	["Open Bags at Bank"] = "打开银行同时打开背包",
	["Open all of your bags when you're at the bank"] = "当你打开银行的时候,同时打开所有背包"
} end)
