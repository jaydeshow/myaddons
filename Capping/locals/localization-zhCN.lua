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
	["Auto quest turnins"] = "自动完成任务",
	["Bar"] = "计时条",
	["Width"] = "宽度",
	["Height"] = "高度",
	["Texture"] = "材质",
	["Other"] = "其它",
	["Other options"] = "其它选项",
	["Auto show map"] = "自动显示地图",
	["Map scale"] = "地图缩放",
	["Hide border"] = "隐藏边框",
	["Port Timer"] = "传送计时条",
	["Wait Timer"] = "等待计时条",
	["Show/Hide Anchor"] = "显示/隐藏锚点",
	["Narrow map mode"] = "精简地图模式",
	["Test"] = "测试",
	["Flip growth"] = "反向",
	["Reposition Scoreboard"] = "重新设置记分板位置",
	["Battlefield Minimap"] = "迷你地图",
	["Icons"] = "图标",
	["Spacing"] = "间隔",
	["Request sync"] = "要求同步",
	["LEFT"] = "左",
	["RIGHT"] = "右",
	["HIDE"] = "隐藏",
	["Fill grow"] = "填充增长",
	["Fill right"] = "填充右部",
	["Font"] = "字体",
	["Time position"] = "时间位置",
	["Border width"] = "边缘宽度",
	["Send to BG"] = "发送到战场频道",
	["Or <Ctrl-left-click> a timer"] = "或<Ctrl+单击>一个计时条",
	["Send to SAY"] = "发送到说",
	["Or <Shift-left-click> a timer"] = "或<Shift+单击>一个计时条",
	["Cancel timer"] = "取消计时条",
	["Or <Ctrl-right-click> a timer"] = "或<Ctrl+右击>一个计时条",
	["Reposition Capture Bar"] = "复位计时条",
	
	-- etc timers
	["Port: %s"] = "传送：%s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "队列中：%s",
	["Battleground Begins"] = "战斗即将开始", -- bar text for bg gates opening (why can't they all be the same?)
	["2 minutes"] = "2分钟",
	["1 minute"] = "1分钟",
	["30 seconds"] = "30秒",
	["One minute until"] = "一分钟",
	["Thirty seconds until"] = "三十秒",
	["Fifteen seconds until"] = "十五秒",
	["%s: %s - %d:%02d remaining"] = "%s：%s - 剩余 %d：%02d", -- chat message after shift left-clicking a bar
	
	-- AB	
	["Bases: (%d+)  Resources: (%d+)/2000"] = "基地：(%d+) 资源：(%d+)/2000", -- arathi basin scoreboard
	["Farm"] = "农场",
	["Lumber Mill"] = "伐木场",
	["Blacksmith"] = "铁匠铺",
	["Gold Mine"] = "金矿洞",--?
	["Stables"] = "兽栏",
	["Southern Farm"] = "南部农场",--?
	["Mine"] = "矿洞",
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
	["Snowfall Graveyard"] = "雪落墓地",
	["Tower"] = "哨塔",
	["Bunker"] = "碉堡",
	["Upgrade to"] = "升级到", -- the option to upgrade units in AV
	["Wicked, wicked, mortals!"] = "邪恶，太邪恶了，人类", -- what Ivus says after being summoned
	["Ivus begins moving"] = "伊弗斯开始移动",
	["WHO DARES SUMMON LOKHOLAR"] = "谁敢召唤冰雪之王洛克霍拉？", -- what Lok says after being summoned
	["The Ice Lord has arrived!"] = "冰雪之王到来！",
	["Lokholar begins moving"] = "洛克霍拉开始移动",
	
	
	-- EotS
	["^(.+) has taken the flag!"] = "^(.+)夺走了旗帜！",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "基地：(%d+) 胜利点数：(%d+)/2000",
	
})
