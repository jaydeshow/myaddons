if GetLocale() ~= "zhTW" then return end

--translate by BestSteve
CappingLocale:CreateLocaleTable({
	-- battlegrounds
	["Alterac Valley"] = "奧特蘭克山谷", 
	["Arathi Basin"] = "阿拉希盆地", 
	["Warsong Gulch"] = "戰歌峽谷",
	["Arena"] = "競技場",
	["Eye of the Storm"] = "暴風之眼",

	-- factions
	["Alliance"] = "聯盟",
	["Horde"] = "部落",
	
	-- options menu
	["Auto quest turnins"] = "自動回報任務",
	["Bar"] = "狀態條",
	["Width"] = "寬度",
	["Height"] = "高度",
	["Texture"] = "紋理",
	["Other"] = "其他",
	["Other options"] = "其他設定",
	["Auto show map"] = "自動顯示地圖",
	["Map scale"] = "地圖縮放",
	["Hide border"] = "隱藏邊框",
	["Port Timer"] = "傳送計時",
	["Wait Timer"] = "等待計時條",
	["Show/Hide Anchor"] = "顯示/隱藏錨點",
	["Narrow map mode"] = "精簡地圖模式",
	["Test"] = "測試",
	["Flip growth"] = "反轉增長",
	["Reposition Scoreboard"] = "重設記分板位置",
	["Battlefield Minimap"] = "迷你地圖",
	["Icons"] = "圖示",
	["Spacing"] = "間隔",
	["Request sync"] = "要求同步",
	["LEFT"] = "左",
	["RIGHT"] = "右",
	["HIDE"] = "隱藏",
	
	-- etc timers
	["Port: %s"] = "傳送: %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "佇列: %s",
	["Battleground Begins"] = "開始", -- bar text for bg gates opening (why can't they all be the same?)
	["1 minute"] = "1分鐘",
	["30 seconds"] = "30秒",
	["One minute until"] = "1分鐘",
	["Thirty seconds until"] = "30秒",
	["Fifteen seconds until"] = "15秒",
	["%s: %s - %d:%02d remaining"] = "%s: %s - 還有 %d:%02d", -- chat message after shift left-clicking a bar
	
	-- AB	
	["Bases: (%d+)  Resources: (%d+)/2000"] = "基地:(%d+) 資源:(%d+)/2000", -- arathi basin scoreboard
	["Farm"] = "農場",
	["Lumber Mill"] = "伐木場",
	["Blacksmith"] = "鐵匠舖",
	["Gold Mine"] = "金礦",
	["Stables"] = "獸欄",
	["Southern Farm"] = "南邊的農場",
	["Mine"] = "礦坑",
	["has assaulted"] = "突襲了",
	["claims the"] = "攻佔了",
	["has taken the"] = "奪取了",
	["has defended the"] = "守住了",
	["Final: 2000 - %d"] = "估計最終比數: 2000 - %d", -- final score text
	["wins 2000-%d"] = "勝利 (2000-%d)", -- final score chat message
	
	-- WSG
	["was picked up by (.+)!"] = "被(.+)拔掉了!",
	["dropped"] = "丟掉了",
	["captured the"] = "佔據了",
	["Flag respawns"] = "旗幟已重置",
	["%s's flag carrier: %s (%s)"] = "%s的旗幟攜帶者: %s (%s)", -- chat message
	
	-- AV
	 -- NPC
	["Smith Regzar"] = "鐵匠雷格薩",
	["Murgot Deepforge"] = "莫高特·深爐",
	["Primalist Thurloga"] = "原獵者瑟魯加",
	["Arch Druid Renferal"] = "大德魯伊雷弗拉爾",
	["Stormpike Ram Rider Commander"] = "雷矛山羊騎兵指揮官",
	["Frostwolf Wolf Rider Commander"] = "霜狼騎兵指揮官",

	 -- patterns
	["avunderattack"] = "^(.+)受到攻擊!.+不採取措施",
	["avtaken"] = "^(.+)被.+佔領了!",
	["avdestroyed"] = "^(.+)被.+摧毀了!",
	-- no need to translate ["The "] = true,
	["Snowfall Graveyard"] = "落雪墓地",
	["Tower"] = "哨塔",
	["Bunker"] = "碉堡",
	["Upgrade to"] = "升級成", -- the option to upgrade units in AV
	["Wicked, wicked, mortals!"] = "邪惡,太邪惡了,人類!", -- what Ivus says after being summoned
	["Ivus begins moving"] = "伊弗斯開始移動",
	["WHO DARES SUMMON LOKHOLAR"] = "誰敢召喚冰雪之王洛克霍拉?", -- what Lok says after being summoned
	["The Ice Lord has arrived!"] = "冰雪之王來了!",
	["Lokholar begins moving"] = "洛克霍拉開始移動",
	
	
	-- EotS
	["^(.+) has taken the flag!"] = "^(.+)已經奪走了旗幟!",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "基地:(%d+) 勝利點數:(%d+)/2000",
})
