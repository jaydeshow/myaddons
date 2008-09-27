local L = LibStub("AceLocale-2.2"):new("ZOMGPortalz")

L:RegisterTranslations("zhCN", function() return {
	["Portal Configuration"]					= "传送门配置",
	["Key-Binding"]							 	= "按键绑定",
	["Define the key used for portal popup"]	= "给传送门弹出框定义一个按键",

	-- Bindings
	["ZOMGBUFFS_PORTALZ"]						= "ZOMGBuffs传送门模块",
	["ZOMGBUFFS_PORTAL_KEY"]					= "传送门热键",

	["Locked"]									= "已锁定",
	["Unlocked, the portals can be dragged using the |cFF00FF00Right Mouse Button|r"] = "未锁定，可以使用|cFF00FF00鼠标右键|r拖拽传送门",

	["Pattern"]									= "模板",
	["Select the arrangement layout for the portals"] = "为传送门选择摆放布局",
	["Circle"]									= "圆形",
	["Horizontal"]								= "横向",
	["Vertical"]								= "纵向",
	["Arc"]										= "弧形",
	["Sticky"]									= "固定",
	["When sticky, the portals open on one keypress and close on another. When disabled, you are required to hold the key whilst making your selection."] = "当处于固定模式时，按键按一次时传送门窗口会打开，再按一次会关闭。当禁用的时候，你必须按住按键才能选择传送门。",
	["Scale"]									= "缩放",
	["Adjust the scale of the portals"]			= "调整传送门的缩放",
	["Portal Spell"]							= "传送门法术",
	["Reagent information"]						= "施法材料信息",
	["Show All"]								= "显示全部",
	["Show all portal spells, even if you have not learnt them yet."] = "显示全部的传送门法术，包括你还没有学会的。",

} end)

