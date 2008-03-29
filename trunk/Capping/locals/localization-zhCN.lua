if GetLocale() ~= "zhCN" then return end

--translate by BestSteve
CappingLocale:CreateLocaleTable({
	-- battlegrounds
	["Alterac Valley"] = "奥特兰克山谷", 
	["Arathi Basin"] = "阿拉希盆地", 
	["Warsong Gulch"] = "战歌峡谷",
	["Arena"] = "竞技场",
	["Eye of the Storm"] = "风暴之眼",

	-- factions
	["Alliance"] = "联盟",
	["Horde"] = "部落",
	
	-- options menu
	["Enable"] = "启用",
	["Auto quest turnins"] = "自动完成任务",
	["Enable Alterac Valley automatic quest turnins"] = "启用奥特兰克山谷自动完成任务",
	["Bar"] = "状态条",
	["Statusbar options"] = "计时条选项",
	["Font size"] = "字体大小",
	["Change statusbar font size"] = "调整计时条字体大小",
	["Width"] = "宽度",
	["Change statusbar width"] = "调整计时条宽度",
	["Height"] = "高度",
	["Change statusbar thickness"] = "调整计时条宽度",
	["Scale"] = "缩放",
	["Change statusbar scale"] = "调整计时条缩放比例",
	["Texture"] = "材质",
	["Statusbar textures"] = "选择计时条材质",
	["Other"] = "其它",
	["Other options"] = "其它选项",
	["Auto show map"] = "自动显示地图",
	["Auto show the battlefield minimap on entry"] = "进入战场自动显示迷你地图",
	["Map scale"] = "地图缩放",
	["Hide border"] = "隐藏边框",
	["Change the default scale of the battlefield minimap"] = "调整迷你地图缩放比例",
	["Port Timer"] = "传送计时条",
	["Enable timers for port expiration"] = "启用传送过程计时条",
	["Wait Timer"] = "等待计时条",
	["Enable timers for queue wait time"] = "启用等待计时条",
	["Show/Hide Anchor"] = "显示/隐藏锚点",
	["Show/Hide the bars anchor (can also left-click a statusbar)"] = "显示/隐藏计时条锚点(也可以左击状态条)",
	["Toggle class color"] = "使用职业颜色",
	["Enable/disable class color indicators on the scoreboard"] = "启用/停用记分板职业颜色",
	["Narrow map mode"] = "精简地图模式",
	["Narrow the battlefield minimap, removing some empty space"] = "精简迷你地图",
	["Test"] = "测试",
	["Start a test bar"] = "启动一个测试计时条",
	["Reverse fill"] = "反向填充",
	["Set statusbars to fill up instead of depleting"] = "使用填充模式",
	["Flip growth"] = "反向",
	["Set objective timers to grow up and misc timers to grow down"] = "使战场目标计时器向上增长",
	["Reposition Scoreboard"] = "重新设置记分板位置",
	["Move the scoreboard to the Capping anchor's CURRENT position"] = "移动记分板到当前位置",
	["Battlefield Minimap"] = "迷你地图",
	["Options for the battlefield minimap"] = "迷你地图选项",
	["Colors"] = "颜色",
	["Icons"] = "图标",
	["Bar icons display options"] = "计时器图标选项",
	["Spacing"] = "间隔",
	--["Request sync"] = true,
	["LEFT"] = "左",
	["RIGHT"] = "右",
	["HIDE"] = "中",
	
	-- etc timers
	["Port: %s"] = "传送：%s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "队列中：%s",
	["Battleground Begins"] = "战斗即将开始", -- bar text for bg gates opening (why can't they all be the same?)
	["1 minute"] = "1分钟",
	["30 seconds"] = "30秒",
	["One minute until"] = "一分钟",
	["Thirty seconds until"] = "三十秒",
	["Fifteen seconds until"] = "十五秒",
	["%s: %s - %d:%02d remaining"] = "%s: %s - 剩余 %d:%02d", -- chat message after shift left-clicking a bar
	
	-- AB	
	["Bases: (%d+)  Resources: (%d+)/2000"] = "基地：(%d+) 资源：(%d+)/2000", -- arathi basin scoreboard
	["Farm"] = "农场",
	["Lumber Mill"] = "伐木场",
	["Blacksmith"] = "铁匠铺",
	["Mine"] = "矿洞",
	["Stables"] = "兽栏",
	["has assaulted"] = "突袭了",
	["claims the"] = "攻占了",
	["has taken the"] = "夺取了",
	["has defended the"] = "守住了",
	["Final: 2000 - %d"] = "最终：2000 - %d", -- final score text
	["wins 2000-%d"] = "胜利 2000 - %d", -- final score chat message
	
	-- WSG
	["was picked up by (.+)!"] = "旗帜被([^%s]+)拔起了！",
	["dropped"] = "丢掉了",
	["captured the"] = "夺取",
	["Flag respawns"] = "旗帜即将刷新",
	["%s's flag carrier: %s (%s)"] = "%s的旗子携带者：%s (%s)", -- chat message
	
	-- AV
	 -- NPC
	["Smith Regzar"] = "铁匠雷格萨",
	["Murgot Deepforge"] = "莫高特·深炉",
	["Primalist Thurloga"] = "指挥官瑟鲁加",
	["Arch Druid Renferal"] = "大德鲁伊雷弗拉尔",
	["Stormpike Ram Rider Commander"] = "雷矛山羊骑兵指挥官",
	["Frostwolf Wolf Rider Commander"] = "霜狼骑兵指挥官",

	 -- patterns
	["avunderattack"] = "([^%s]+)受到攻击！如果我们不尽快采取措施",
	["avtaken"] = "([^%s]+)被([^%s]+)占领了！",
	["avdestroyed"] = "([^%s]+)被([^%s]+)摧毁了！",
	--["The "] = "",
	["Snowfall Graveyard"] = "雪落墓地",
	["Tower"] = "哨塔",
	["Bunker"] = "碉堡",
	["Upgrade to"] = "升级到", -- the option to upgrade units in AV
	["Wicked, wicked, mortals!"] = "邪恶,太邪恶了,人类", -- what Ivus says after being summoned
	--["Ivus begins moving"] = "Ivus begins moving",
	["WHO DARES SUMMON LOKHOLAR"] = "谁敢召唤冰雪之王洛克霍拉？", -- what Lok says after being summoned
	--["The Ice Lord has arrived!"] = "The Ice Lord has arrived!",
	--["Lokholar begins moving"] = "Lokholar begins moving",
	
	
	-- EotS
	["^(.+) has taken the flag!"] = "^(.+)已经夺走了旗帜!",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "基地：(%d+) 胜利点数：(%d+)/2000",
	
})
