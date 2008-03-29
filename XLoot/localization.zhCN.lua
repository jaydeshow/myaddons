local L = AceLibrary("AceLocale-2.2"):new("XLoot")

L:RegisterTranslations("zhCN", function() 
	return {
		catSnap = "窗口跟随",
		catLoot = "拾取设定",
		catFrame = "框架选项",
		catInfo = "拾取信息",
		catGeneralAppearance = "一般外观",
		catFrameAppearance = "窗口外观",
		catLootAppearance = "拾取外观",
		catExtras = "其他",

--		["2.0 compatability"] = true, -- DEPRICATED
--		["If you're getting errors with table.setn, enable this"] = true, -- DEPRICATED
--		["Disable Tooltip Scanning"] = true, -- DEPRICATED
--		["Enable this to skip scanning item tooltips for BoP/BoE/BoU information. This is most likely causing the 'Attempt to index field Rlines' error."] = true, -- DEPRICATED
		
		optLock = "锁定框架",
		optOptions = "选项界面",
		optBehavior = "行为选项",
		optCursor = "鼠标跟随",
		optSmartsnap = "智能跟随",
		optSnapoffset = "跟随偏移",
		optCollapse = "空拾取按钮隐藏",
		optDragborder = "可拖拽边框",
		optLootexpand = "根据拾取名称长度调整边框",
		optAltoptions = "Alt+右击显示菜单",
		optSwiftloot = "自动拾取时隐藏窗口",
		optQualitytext = "显示物品品质",
		optInfotext = "显示物品信息",
		["Show BoP/BoE/BoU"] =  "显示BoP/BoE/BoU",
		["Show Bind on Pickup/Bind on Equip/Bind on Use text opposite stack size for items"] = "在物品上显示拾取绑定/装备绑定/使用绑定信息",
		optLinkAll = "链接所有物品",
		optLinkAllVis = "可见的：",
		optLinkAllThreshold = "链接限定",
		optLinkAllChannels = "总是链接至",
		optAppearance = "外观",
		optQualityborder = "根据品质显示边框颜色",
		optQualityframe = "根据品质显示窗口颜色",
		optLootqualityborder = "根据品质显示边框颜色",
		optBgcolor = "背景颜色",
		optBordercolor = "边框颜色",
		optTexColor = "根据品质显示图标颜色",
		optHighlightLoot = "根据品质高亮显示",
		optHighlightThreshold = "高亮显示限定", 
		optLootbgcolor = "背景颜色",
		optLootbordercolor = "边框颜色",
		optInfoColor = "信息颜色",
		optScale = "缩放",
		optAdvanced = "高级选项",
		optDebug = "除错信息",
		optDefaults = "恢复默认值",
		
		descLock = "固定拾取窗口",
		descOptions = "显示下拉选项",
		descBehavior = "改变XLoot的行为方式",
		descCursor = "让拾取窗口在你拾取物品时跟随着鼠标。",
		descSmartsnap = "让拾取窗口只是在垂直方向跟随着鼠标，这样在你拾取了一个物品后窗口不会跟着乱跑。",
		descSnapoffset = "设定跟随点到第一个拾取物品图标的纵向距离。",
		descCollapse = "隐藏拾取按钮，如果跟随选项打开，则将鼠标移动至下一个窗口。",
		descDragborder = "允许通过拖拽边框来移动拾取窗口，否则只能拖拽按钮来移动，可能会导致误点击。",
		descLootexpand = "改变窗口的宽度以和物品名称长度匹配，名称短则窗口窄，名称长则窗口宽。",
		descAltoptions = "让你通过Alt-右击显示XLoot菜单，可以禁用以避免和其他插件的冲突。",
		descSwiftloot = "避免在自动拾取物品时所产生的些许延迟，你可以在界面选项中设定自动拾取或通过按下特定按键（同样可在界面选项中设定）来自动拾取。",
		descQualitytext = "在物品名称上方显示该物品的品质。",
		descInfotext = "在物品名称的下方显示物品的信息。",
		descLinkAll = "链接所有物品的按钮，它会弹出一个包含当前所有可用频道的菜单，让你把当前的拾取列表发送过去。",
		descLinkAllVis = "切换链接所有物品按钮是否可见。",
		descLinkAllThreshold = "仅链接高于限定品质的物品。",
		descLinkAllChannels = "点击链接所有物品时总是发送链接至这些频道。|cFFFF0000如果没有选择频道，点击链接所有物品将显示菜单。|r",
		descAppearance = "设定XLoot窗口和各个拾取按钮的颜色，大小，皮肤。",
		descQualityborder = "以最高品质的物品颜色为拾取窗口着色。",
		descQualityframe = "以最高品质的物品颜色为拾取窗口的背景着色。",
		descLootqualityborder = "以品质的颜色为物品边框着色。",
		descHighlightLoot = "以品质来高亮每个拾取窗口。",
		descHighlightThreshold = "选择会被高亮的拾取窗口的最低品质。",
		descBgcolor = "改变拾取窗口本身的背景颜色。",
		descBordercolor = "改变窗口本身的边框颜色。",
		descTexColor = "以品质的颜色为物品图标/贴图的边框上色。",
		descLootbgcolor = "改变所有可拾取物品的背景颜色。",
		descLootbordercolor = "改变所有可拾取物品的边框颜色。",
		descInfoColor = "改变信息文字颜色",
		descScale = "缩放拾取窗口",
		descAdvanced = "一些并不建议被改变的选项，但也可以试试看。",
		descDebug = "显示除错信息",
		descDefaults = "重置XLoot的数据库并将所有设置恢复到默认值",
		
		qualityQuest = "任务物品",
		
--		["BoP"] = "BoP,
--		["BoE"] = "BoE",
--		["BoU"] = "BoU",
		
		guiTitle = "XLoot选项",
		
		itemWeapon = "武器",
		
		evHerbs = "采集草药",
		evOpenNT = "打开 - 无文本",
		evOpen = "打开",
		
		linkallloot = "报告物品",
		linkallchanneldesc = "点击链接所有物品时自动发送至%s频道",
	}
end)