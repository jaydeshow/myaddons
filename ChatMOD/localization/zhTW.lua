-- 繁體中文化: Duke 2008/04/09

if ( GetLocale() == "zhTW" ) then
        BINDING_HEADER_SCCNKEY			= "|r|CFFCC9933[聊天]|r聊天功能增強";
	SCCN_INIT_CHANNEL_LOCAL			= "一般";
	SCCN_GUI_HIGHLIGHT1				= "在這對話輸入您要 SCCN 顯示的詞。每行輸入一個詞";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "術士";
	SCCN_LOCAL_CLASS["HUNTER"] 	= "獵人";
	SCCN_LOCAL_CLASS["PRIEST"] 	= "牧師";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "聖騎士";
	SCCN_LOCAL_CLASS["MAGE"] 	= "法師";
	SCCN_LOCAL_CLASS["ROGUE"] 	= "盜賊";
	SCCN_LOCAL_CLASS["DRUID"] 	= "德魯伊";
	SCCN_LOCAL_CLASS["SHAMAN"] 	= "薩滿";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "戰士";
	-- Zones, Translation Needed
	SCCN_LOCAL_ZONE["Alterac"]	= "奧特蘭克山谷";
	SCCN_LOCAL_ZONE["warsong"]	= "戰歌峽谷";
	SCCN_LOCAL_ZONE["arathi"]	= "阿拉希盆地";
	SCCN_CONFAB			= "|cffff0000您有安裝Confab。為了相容性，SCCN的輸入框相關功能取消!";
	SCCN_HELP[1]			= "Sol's Color chat Nicks - 指令說明:";
	SCCN_HELP[2]			= "|cff68ccef".."/chatmod hidechanname".."|cffffffff".." 隱藏頻道名稱";
	SCCN_HELP[3]			= "|cff68ccef".."/chatmod colornicks".."|cffffffff".." 以職業的顏色來顯示玩家的名字";
	SCCN_HELP[4]			= "|cff68ccef".."/chatmod purge".."|cffffffff".." 整理SCCN資料庫 |r|cFF00FF00(每次載入此插件時都會自動做這個動作)|r";
	SCCN_HELP[5]			= "|cff68ccef".."/chatmod killdb".."|cffffffff".." 完整的把SCCN資料庫清除 (無法復原)";
	SCCN_HELP[6]			= "|cff68ccef".."/chatmod mousescroll".."|cffffffff".." 用滑鼠滾輪來捲動對話框內容 |r|cFF00FF00(<Shift>+滑鼠滾輪=快捲、<Ctrl>+滑鼠滾輪=捲至盡頭)|r";
	SCCN_HELP[7]			= "|cff68ccef".."/chatmod topeditbox".."|cffffffff".." 對話輸入框顯示在聊天視窗的最上頭";	
	SCCN_HELP[8]			= "|cff68ccef".."/chatmod timestamp".."|cffffffff".." 顯示時間戳記在每列訊息之前。鍵入|r|cFF00FF00 /chatmod timestamp ? 顯示更改格式說明|r";
	SCCN_HELP[9]			= "|cff68ccef".."/chatmod colormap".."|cffffffff".." 迷你地圖上的團隊成員以職業顏色標記";	
	SCCN_HELP[10]			= "|cff68ccef".."/chatmod hyperlink".."|cffffffff".." 讓對話訊息中的網頁連結可以被點選後複製";
	SCCN_HELP[11]			= "|cff68ccef".."/chatmod selfhighlight".."|cffffffff".." 在對話訊息中把自己名字明顯標示";
	SCCN_HELP[12]			= "|cff68ccef".."/chatmod clickinvite".."|cffffffff".." 讓對話訊息中的 [邀請] 能直接被點選以加入您的隊伍";	
	SCCN_HELP[13] 			= "|cff68ccef".."/chatmod editboxkeys".."|cffffffff".." 在對話輸入框裡不需按住<Alt>鍵就能用方向鍵做編輯 & 歷史記錄緩衝區增加至256行";
	SCCN_HELP[14] 			= "|cff68ccef".."/chatmod chatstring".."|cffffffff".." 簡化悄悄話字串";
	SCCN_HELP[15] 			= "|cff68ccef".."/chatmod selfhighlightmsg".."|cffffffff".." 包含自己名字的對話訊息會另外顯示在螢幕上方，須開啟 /chatmod selfhighlight";	
	SCCN_HELP[16]			= "|cff68ccef".."/chatmod hidechatbuttons".."|cffffffff".." 隱藏聊天按鈕";	
	SCCN_HELP[17]			= "|cff68ccef".."/chatmod highlight".."|cffffffff".." 在聊天中高亮顯示自定義詞";	
	SCCN_HELP[18]			= "|cff68ccef".."/chatmod AutoBGMap".."|cffffffff".." 自動開啟戰場迷你地圖";	
	SCCN_HELP[19] = "|cff68ccef".."/chatmod shortchanname ".."|cffffffff".." 顯示簡略頻道名稱";	
	SCCN_HELP[20] = "|cff68ccef".."/chatmod autogossipskip ".."|cffffffff".." 自動跳過閒聊視窗 |r|cFF00FF00(按住 <Ctrl> 則取消跳過)|r";
	SCCN_HELP[21] = "|cff68ccef".."/chatmod autodismount ".."|cffffffff".." 與飛行管理員對話時自動解散坐騎";	
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod inchathighlight ".."|cffffffff".."高亮已知的暱稱";
	SCCN_HELP[23]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."保留上次的對話記錄";	
	SCCN_HELP[24]					= "|cff68ccef".."/chatmod initchan <channelname>".."|cffffffff".."啟動時設定指定的<頻道名稱>在預設聊天框中";		
	SCCN_HELP[25]					= "|cff68ccef".."/chatmod nofade".."|cffffffff".."關閉聊天文字淡出";
	SCCN_HELP[26]					= "|cff68ccef".."/chatmod chaticon".."|cffffffff".."顯示/關閉聊天框中右下角的文字捲動圖示";
	SCCN_HELP[27]					= "|cff68ccef".."/chatmod showlevel".."|cffffffff".."顯示/關閉玩家名字後面顯示的等級";
	SCCN_HELP[28]					= "|cff68ccef".."/chatmod chatcolorname".."|cffffffff".."顯示/關閉高亮名字";
	SCCN_HELP[99]			= "|cff68ccef".."/chatmod status".."|cffffffff".." 顯示目前的設定";
	SCCN_TS_HELP  			= "|cff68ccef".."/chatmod timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = 小時 (0-24) \n$t = 小時 (0-12) \n$m = 分鐘 \n$s = 秒 \n$p = 午前/午後 (am / pm)\n".."|cff909090Example: /chatmod timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]		= "隱藏頻道名稱:";
	SCCN_CMDSTATUS[2]		= "以職業顏色顯示名字:";
	SCCN_CMDSTATUS[3]		= "使用滑鼠滾輪捲動聊天視窗:";
	SCCN_CMDSTATUS[4]		= "對話輸入欄置頂:";
	SCCN_CMDSTATUS[5]		= "加入訊息時間:";
	SCCN_CMDSTATUS[6]		= "小地圖上的隊伍成員以職業顏色標記:";
	SCCN_CMDSTATUS[7]		= "網頁連結可點選複製:";
	SCCN_CMDSTATUS[8]		= "明顯標示自己的名字:";
	SCCN_CMDSTATUS[9]		= "對話欄中的邀請訊息可被點選:";
	SCCN_CMDSTATUS[10]		= "對話編輯時不需按住<Alt>:";
	SCCN_CMDSTATUS[11]		= "自定悄悄話訊息:";
	SCCN_CMDSTATUS[12]		= "額外顯示包含自己名字的訊息:";
	SCCN_CMDSTATUS[13]		= "隱藏聊天按鈕:";
	SCCN_CMDSTATUS[14] 		= "戰場中自動開啟小地圖:";
	SCCN_CMDSTATUS[15] 		= "自定義高亮:";
	SCCN_CMDSTATUS[16] 		= "簡略頻道名稱:";
	SCCN_CMDSTATUS[17]				= "閒聊自動跳過:";
	SCCN_CMDSTATUS[18]				= "自動解散坐騎:";	
	SCCN_CMDSTATUS[19]				= "聊天中高亮:";	
	SCCN_CMDSTATUS[20]				= "記憶上次聊天內容(黏貼):";	
	SCCN_CMDSTATUS[21]				= "不使用聊天文字自動淡出:";
	SCCN_CMDSTATUS[22]				= "聊天捲動圖示:";
	SCCN_CMDSTATUS[23]				= "名字後面顯示等級:";
	SCCN_CMDSTATUS[24]      = "聊天文字中名字著色:";
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0]		= "++";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM		= "%s悄悄地說：";
	SCCN_CUSTOM_CHT_TO		= "發送給%s：";
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]		= "公會";
	SCCN_STRIPCHAN[2]		= "團隊";
	SCCN_STRIPCHAN[3]		= "小隊";
        SCCN_STRIPCHAN[4]               = "本地防務";
        SCCN_STRIPCHAN[5]               = "世界防務";
        SCCN_STRIPCHAN[6]		= "尋求組隊";
	SCCN_STRIPCHAN[7]		= "交易";
	SCCN_STRIPCHAN[8]		= "綜合";
	SCCN_STRIPCHAN[9]		= "戰場";

-- ItemLink Channels
    SCCN_ILINK[1]                   = "綜合 -"
    SCCN_ILINK[2]                   = "交易 -"
    SCCN_ILINK[3]                   = "尋求組隊 -"
    SCCN_ILINK[4]                   = "本地防務 -"
    SCCN_ILINK[5]                   = "世界防務"
	-- some general channel name translation for the GUI
	SCCN_TRANSLATE[1]				= "公會";
	SCCN_TRANSLATE[2]				= "理事";
	SCCN_TRANSLATE[3]				= "小隊";
	SCCN_TRANSLATE[4]				= "團隊";
	SCCN_TRANSLATE[5]				= "悄悄話";
	SCCN_Highlighter				= "ChatMOD 高亮";
	SCCN_Config						= "|r|CFFCC9933[聊天]|r聊天功能增強";
	SCCN_Changelog					= "ChatMOD 更新日誌";	
	SCCN_NewVer                     = "現在有 ChatMOD 的新版本，請至 www.solariz.de 下載最新版!";
end;