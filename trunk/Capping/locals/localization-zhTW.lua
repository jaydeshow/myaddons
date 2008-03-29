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
	["Enable"] = "啟用",
	["Auto quest turnins"] = "自動回報任務",
	["Enable Alterac Valley automatic quest turnins"] = "啟用奧特蘭克山谷自動回報任務",
	["Bar"] = "狀態條",
	["Statusbar options"] = "狀態條選項",
	["Font size"] = "字型大小",
	["Change statusbar font size"] = "調整狀態條字型大小",
	["Width"] = "寬度",
	["Change statusbar width"] = "調整狀態條寬度",
	["Height"] = "高度",
	["Change statusbar thickness"] = "調整狀態條高度",
	["Scale"] = "縮放",
	["Change statusbar scale"] = "調整狀態條縮放比例",
	["Texture"] = "紋理",
	["Statusbar textures"] = "狀態條的紋理",
	["Other"] = "其他",
	["Other options"] = "其他設定",
	["Auto show map"] = "自動顯示地圖",
	["Auto show the battlefield minimap on entry"] = "進入戰場時自動顯示迷你地圖",
	["Map scale"] = "地圖縮放",
	["Hide border"] = "隱藏邊框",
	["Change the default scale of the battlefield minimap"] = "調整迷你地圖縮放比例",
	["Port Timer"] = "傳送計時",
	["Enable timers for port expiration"] = "啟用傳送過期計時條",
	["Wait Timer"] = "等待計時條",
	["Enable timers for queue wait time"] = "啟用等待計時條來紀錄等待時間",
	["Show/Hide Anchor"] = "顯示/隱藏錨點",
	["Show/Hide the bars anchor (can also left-click a statusbar)"] = "顯示/隱藏計時條的錨點 (也可在計時條上點選左鍵)",
	["Toggle class color"] = "開關職業顏色",
	["Enable/disable class color indicators on the scoreboard"] = "啟用/停用記分板上的職業顏色標記",
	["Narrow map mode"] = "精簡地圖模式",
	["Narrow the battlefield minimap, removing some empty space"] = "精簡迷你地圖，去除多餘空間",
	["Test"] = "測試",
	["Start a test bar"] = "啟動一個測試狀態條",
	["Reverse fill"] = "反向填充",
	["Set statusbars to fill up instead of depleting"] = "使狀態條填滿而不是減小",
	["Flip growth"] = "反轉增長",
	["Set objective timers to grow up and misc timers to grow down"] = "使戰場目標狀態條向上增長而其他狀態條向下",
	["Reposition Scoreboard"] = "重設記分板位置",
	["Move the scoreboard to the Capping anchor's CURRENT position"] = "移動記分板到 Capping 錨點「目前」位置",
	["Battlefield Minimap"] = "迷你地圖",
	["Options for the battlefield minimap"] = "迷你地圖的選項",
	["Colors"] = "顏色",
	["Icons"] = "圖示",
	["Bar icons display options"] = "計時器圖示顯示設定",
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
