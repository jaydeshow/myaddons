local L = AceLibrary("AceLocale-2.2"):new("XLootMonitor")

L:RegisterTranslations("zhCN", function()
	return {
		catGrowth = "行增长",
		catLoot = "拾取",
		catPosSelf = "锚点...",
		catPosTarget = "到...",
		catPosOffset = "框体偏移...",
		catModules = "模块",
		
		moduleHistory = "拾取纪录",
		moduleActive = "激活",
		
		historyTime = "按时间顺序查询",
		historyPlayer = "按玩家顺序查询",
		["View by item"] = "按物品顺序查询",
		historyClear = "清除当前纪录",
		historyEmpty = "没有纪录",
		historyTrunc = "物品最大宽度",
		historyMoney = "金钱拾取",
		["Export history"] = "导出记录",
		["No export handlers found"] = "未导出记录查询",
		["Simple XML copy-export"] = "简单的XML格式输出",
		["Copy-Paste Pipe Separated List"] = "复制-粘贴为单独的清单",
		["Press Control-C to copy the log"] = "按CTRL-C复制记录",
		
		["Loot Monitor"] = "Loot Monitor", 
		["Display Options"] = "显示设置",
		
		optStacks = "分堆/锚点",
		optLockAll = "锁定所有窗体",
		optPositioning = "位置",
		optMonitor = "XLoot Monitor",
		optAnchor = "显示锚点",
		optPosVert = "垂直",
		optPosHoriz = "水平",
		optTimeout = "超时",
		optDirection = "方向",
		optThreshold = "分堆界限",
		optQualThreshold = "品质界限",
		optSelfQualThreshold = "自己的品质界限",
		optUp = "上",
		optDown = "下",
		optMoney = "显示拾取的金币",
		["Show countdown text"] = "显示数量文字",
		["Show totals of your items"] = "显示当前物品的总数",
		["Show small text beside the item indicating how much time remains"] = "物品旁边显示可使用次数",
		["Trim item names to..."] = "物品名称长度限制为...",
		["Length in characters to trim item names to"] = "物品名称的最大长度(2字节为一汉字)",
		["Show winning group loot"] = "显示队员赢得的物品",
		["Show group roll choices"] = "显示小队ROLL点时的选择(放弃/贪婪/需求)",
		
		descStacks = "设置项目的显示方式,如显示位置,方向,一定时间自动清除等",--Set options for each individual stack, such as anchor visibility or timeout.
		descPositioning = "项目的显示位置及附着点",--Position and attachment of rows in the stack
		descMonitor = "XLootMonitor-物品监视器-插件设置",--XLootMonitor plugin configuration
		descAnchor = "显示锚点",--Show anchor for this stack
		descPosVert = "项目相对你选择锚点的垂直偏移量.",--Offset the row vertically from the point you choose to anchor it to by a specific amount
		descPosHoriz = "项目相对你选择锚点的水平偏移量",--Offset the row horizontally from the point you choose to anchor it to by a specific amount
		descTimeout = "每行保持显示直至清除的时间.|cFFFF5522设为0则保持显示不做清除.",--Time before each row fades. Setting this to 0 disables timed fading entirely
		descDirection = "项目所显示的方向",--Direction stacks grow
		descThreshold = "可显示的最大项目数(超过此数则最早的那行消失)",--Maximum number of rows displayed at any given time		
		descQualThreshold = "监视器所显示物品的最低品质. ",--The lowest quality of everyone else's that will be shown by the monitor		
		descSelfQualThreshold = "监视器所显示的你自己拾取物品的最低品质.",--The lowest quality of your own loot that will be shown by the monitor		
		descMoney = "显示团队中打完怪所分得的钱币|cFFFF0000注意并不包括你在SOLO怪时候的钱币拾取D|r",--[[Show share of coins looted while in a group,Does NOT include solo coins yet.]]-- 
		
		optPos = {
			TOPLEFT = "左上角",
			TOP = "上",
			TOPRIGHT = "右上角",
			RIGHT = "右",
			BOTTOMRIGHT = "右下角",
			BOTTOM = "下",
			BOTTOMLEFT = "左下角",
			LEFT = "左",
			TOPLEFT = "左上角",
		},
		
		linkErrorLength = "警告:链接太长,信息将不能完全显示.你可以继续发送或者清楚掉输入的文字再重试一下.",
		--Linking would make the message too long. Send or clear the current message and try again.
		playerself = "你", 
	}
end)

