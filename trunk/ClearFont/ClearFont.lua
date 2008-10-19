-- /////////////////////////////////////////////////////////////////////////////
-- =============================================================================
--  ClearFont v2.30a 增强模式
--  （根据ClearFont v20000-2 版本汉化修改）
--  原作者：KIRKBURN
--  官方网页：http://www.clearfont.co.uk/
--  汉化修改：五区 元素之力 逆袭的蓝
--  发布页面：http://bbs.game.mop.com/viewthread.php?tid=1503056
--  发布日期：07.11.23
-- -----------------------------------------------------------------------------
--  CLEARFONT.LUA - STANDARD WOW UI FONTS
--	A. ClearFont 框架 及为了以后代码的简洁而预先定义字体位置
--	B. 标准的WOW用户界面部分
--	C. 每当一个插件载入时都重新载入的功能
--	D. 第一次启动时应用以上设定
-- =============================================================================
-- /////////////////////////////////////////////////////////////////////////////




-- =============================================================================
--  A. ClearFont 框架 及为了以后代码的简洁而预先定义字体位置
--  你可以根据例子添加属于自己的字体
-- =============================================================================

	ClearFont = CreateFrame("Frame", "ClearFont");

-- 指出在哪里寻找字体
	local CLEAR_FONT_BASE = "Fonts\\";

-- 生命条、经验条上显示的英文和数字
	local CLEAR_FONT_NUMBER = CLEAR_FONT_BASE .. "ARIALN.TTF";
-- 任务说明和书信、石碑的正文字体
	local CLEAR_FONT_QUEST = CLEAR_FONT_BASE .. "FZBWJW.TTF";
-- 战斗伤害数值提示
	local CLEAR_FONT_DAMAGE = CLEAR_FONT_BASE .. "ZYKai_C.TTF";
-- 游戏界面中的主要字体
	local CLEAR_FONT = CLEAR_FONT_BASE .. "ZYKai_T.TTF";
-- 物品、技能的说明字体
	local CLEAR_FONT_ITEM = CLEAR_FONT_BASE .. "FZXHJW.TTF";
-- 聊天字体
	local CLEAR_FONT_CHAT = CLEAR_FONT_BASE .. "ZYHei.TTF";

-- 添加属于自己的字体 （例子）
--	local YOUR_FONT_STYLE = CLEAR_FONT_BASE .. "YourFontName.ttf";

-- 字体的比例 - 比如：你想把所有字体缩小到80%，那么可以将"1.0"改成"0.8"
	local CF_SCALE = 1.0



-- -----------------------------------------------------------------------------
-- 检查存在的字体并改变它们
-- -----------------------------------------------------------------------------

	local function CanSetFont(object) 
	   return (type(object)=="table" 
		   and object.SetFont and object.IsObjectType 
		      and not object:IsObjectType("SimpleHTML")); 
	end




-- =============================================================================
--  B. 标准的WOW用户界面部分
-- =============================================================================
--  这是需要编辑的最重要的部分  
--  主要的字体被预先列出，其余部分字体按照字母表顺序排列 
--  如果在补丁改变的情况下，声明可能会有所忽略
-- -----------------------------------------------------------------------------
--  举个例子：游戏初始字体如下：SetFont(CLEAR_FONT, 13 * CF_SCALE)
--  在括号里的第一部分是字体类型，第二部分是字体大小
--  根据个人所需而改变
-- =============================================================================


	function ClearFont:ApplySystemFonts()


-- -----------------------------------------------------------------------------
-- 整体环境、3D NamePlates等 (Dark Imakuni)
-- -----------------------------------------------------------------------------


-- 聊天泡泡
	STANDARD_TEXT_FONT = CLEAR_FONT_CHAT;

-- 头像上的名字
	UNIT_NAME_FONT = CLEAR_FONT;
	NAMEPLATE_FONT = CLEAR_FONT;

-- 显示在被攻击目标头上的数值 (和插件SCT/SDT无关)
	DAMAGE_TEXT_FONT = CLEAR_FONT_DAMAGE;

-- UI菜单字体大小
	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12 * CF_SCALE;


-- -----------------------------------------------------------------------------
-- Raid 等级色彩 （默认禁止）
-- -----------------------------------------------------------------------------

--	RAID_CLASS_COLORS = {
--		["HUNTER"] = { r = 0.67, g = 0.83, b = 0.45 },
--		["WARLOCK"] = { r = 0.58, g = 0.51, b = 0.79 },
--		["PRIEST"] = { r = 1.0, g = 1.0, b = 1.0 },
--		["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73 },
--		["MAGE"] = { r = 0.41, g = 0.8, b = 0.94 },
--		["ROGUE"] = { r = 1.0, g = 0.96, b = 0.41 },
--		["DRUID"] = { r = 1.0, g = 0.49, b = 0.04 },
--		["SHAMAN"] = { r = 0.14, g = 0.35, b = 1.0 },
--		["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43 }
--	};


-- -----------------------------------------------------------------------------
-- 系统字体
-- -----------------------------------------------------------------------------

   if (CanSetFont(SystemFont)) then 			SystemFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- 默认值：16


-- -----------------------------------------------------------------------------
-- 主游戏字体: 随处可见的主要的字体
-- -----------------------------------------------------------------------------

   if (CanSetFont(GameFontNormal)) then 		GameFontNormal:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- 默认值：15
   if (CanSetFont(GameFontHighlight)) then 		GameFontHighlight:SetFont(CLEAR_FONT, 14 * CF_SCALE); end

   if (CanSetFont(GameFontDisable)) then 		GameFontDisable:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontDisable)) then 		GameFontDisable:SetTextColor(0.6, 0.6, 0.6); end

   if (CanSetFont(GameFontGreen)) then 			GameFontGreen:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontRed)) then 			GameFontRed:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontBlack)) then 			GameFontBlack:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- 默认值：13
   if (CanSetFont(GameFontWhite)) then 			GameFontWhite:SetFont(CLEAR_FONT, 12 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- 小字体：经常用小字体的地方，也用在 Titan Panel
-- -----------------------------------------------------------------------------

   if (CanSetFont(GameFontNormalSmall)) then 		GameFontNormalSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- 默认值：15

   if (CanSetFont(GameFontHighlightSmall)) then 	GameFontHighlightSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontHighlightSmallOutline)) then 	GameFontHighlightSmallOutline:SetFont(CLEAR_FONT, 12 * CF_SCALE, "OUTLINE"); end

   if (CanSetFont(GameFontDisableSmall)) then 		GameFontDisableSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontDisableSmall)) then 		GameFontDisableSmall:SetTextColor(0.6, 0.6, 0.6); end

   if (CanSetFont(GameFontDarkGraySmall)) then 		GameFontDarkGraySmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontDarkGraySmall)) then 		GameFontDarkGraySmall:SetTextColor(0.4, 0.4, 0.4); end

   if (CanSetFont(GameFontGreenSmall)) then 		GameFontGreenSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontRedSmall)) then 		GameFontRedSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- 大字体：标题
-- -----------------------------------------------------------------------------

   if (CanSetFont(GameFontNormalLarge)) then 		GameFontNormalLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- 默认值：17
   if (CanSetFont(GameFontHighlightLarge)) then 	GameFontHighlightLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end

   if (CanSetFont(GameFontDisableLarge)) then 		GameFontDisableLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontDisableLarge)) then 		GameFontDisableLarge:SetTextColor(0.6, 0.6, 0.6); end

   if (CanSetFont(GameFontGreenLarge)) then 		GameFontGreenLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontRedLarge)) then 		GameFontRedLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- 极大字体：Raid警报
-- -----------------------------------------------------------------------------

   if (CanSetFont(GameFontNormalHuge)) then 		GameFontNormalHuge:SetFont(CLEAR_FONT, 21 * CF_SCALE); end	-- 默认值：20


-- -----------------------------------------------------------------------------
-- 战斗文字: 集成 SCT-style 信息
-- -----------------------------------------------------------------------------

   if (CanSetFont(CombatTextFont)) then 		CombatTextFont:SetFont(CLEAR_FONT, 25 * CF_SCALE); end		-- 默认值：25


-- -----------------------------------------------------------------------------
-- 数字字体: 拍卖行，金币，按键绑定，物品堆叠数量
-- -----------------------------------------------------------------------------

   if (CanSetFont(NumberFontNormal)) then 		NumberFontNormal:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE, "OUTLINE"); end		-- 默认值：12
   if (CanSetFont(NumberFontNormalYellow)) then 	NumberFontNormalYellow:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE); end

   if (CanSetFont(NumberFontNormalSmall)) then 		NumberFontNormalSmall:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE, "OUTLINE"); end		-- 默认值：11
   if (CanSetFont(NumberFontNormalSmallGray)) then 	NumberFontNormalSmallGray:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE, "THICKOUTLINE"); end

   if (CanSetFont(NumberFontNormalLarge)) then 		NumberFontNormalLarge:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end		-- 默认值：14

   if (CanSetFont(NumberFontNormalHuge)) then 		NumberFontNormalHuge:SetFont(CLEAR_FONT_DAMAGE, 20 * CF_SCALE, "THICKOUTLINE"); end	-- 默认值：20
   if (CanSetFont(NumberFontNormalHuge)) then 		NumberFontNormalHuge:SetAlpha(30); end


-- -----------------------------------------------------------------------------
-- 聊天窗口字体和聊天窗口输入字体
-- -----------------------------------------------------------------------------

   if (CanSetFont(ChatFontNormal)) then 		ChatFontNormal:SetFont(CLEAR_FONT_CHAT, 14 * CF_SCALE); end	-- 默认值：14

	CHAT_FONT_HEIGHTS = {
		[1] = 7,
		[2] = 8,
		[3] = 9,
		[4] = 10,
		[5] = 11,
		[6] = 12,
		[7] = 13,
		[8] = 14,
		[9] = 15,
		[10] = 16,
		[11] = 17,
		[12] = 18,
		[13] = 19,
		[14] = 20,
		[15] = 21,
		[16] = 22,
		[17] = 23,
		[18] = 24
	};

   if (CanSetFont(ChatFontSmall)) then 		ChatFontNormal:SetFont(CLEAR_FONT_CHAT, 13 * CF_SCALE); end	-- 默认值：12


-- -----------------------------------------------------------------------------
-- 任务日志: 任务日志、书籍等
-- -----------------------------------------------------------------------------

   if (CanSetFont(QuestTitleFont)) then 		QuestTitleFont:SetFont(CLEAR_FONT_QUEST, 17 * CF_SCALE); end	-- 默认值：17
   if (CanSetFont(QuestTitleFont)) then 		QuestTitleFont:SetShadowColor(0.54, 0.4, 0.1); end		-- 默认值：(0.49, 0.35, 0.5)

   if (CanSetFont(QuestFont)) then 		   	QuestFont:SetFont(CLEAR_FONT_QUEST, 14 * CF_SCALE); end		-- 默认值：14
   if (CanSetFont(QuestFont)) then 		   	QuestFont:SetTextColor(0.15, 0.09, 0.04); end			-- 默认值：(0, 0, 0)

   if (CanSetFont(QuestFontNormalSmall)) then 		QuestFontNormalSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- 默认值：14
   if (CanSetFont(QuestFontNormalSmall)) then 		QuestFontNormalSmall:SetShadowColor(0.54, 0.4, 0.1); end	-- 默认值：(0.3, 0.18, 0)

   if (CanSetFont(QuestFontHighlight)) then 		QuestFontHighlight:SetFont(CLEAR_FONT_QUEST, 13 * CF_SCALE); end	-- 默认值：13


-- -----------------------------------------------------------------------------
-- 对话框按钮："同意"等字样
-- -----------------------------------------------------------------------------

   if (CanSetFont(DialogButtonNormalText)) then 	DialogButtonNormalText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end	-- 默认值：13
   if (CanSetFont(DialogButtonHighlightText)) then 	DialogButtonHighlightText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- 错误字体："另一个动作正在进行中"等字样
-- -----------------------------------------------------------------------------

   if (CanSetFont(ErrorFont)) then 	   		ErrorFont:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- 默认值：17
   if (CanSetFont(ErrorFont)) then 	   		ErrorFont:SetAlpha(60); end


-- -----------------------------------------------------------------------------
-- 物品信息: 框架内的综合使用形式（大概包括任务物品的版面字体，比如可以携带的书籍）
-- -----------------------------------------------------------------------------

   if (CanSetFont(ItemTextFontNormal)) then 	   	ItemTextFontNormal:SetFont(CLEAR_FONT_ITEM, 15 * CF_SCALE); end		-- 默认值：15


-- -----------------------------------------------------------------------------
-- 邮件和发货单字体：游戏中邮件和拍卖行发货单
-- -----------------------------------------------------------------------------

   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetFont(CLEAR_FONT_QUEST, 14 * CF_SCALE); end	-- 默认值：15
   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetTextColor(0.15, 0.09, 0.04); end		-- 默认值：(0.18, 0.12, 0.06)
   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetShadowColor(0.54, 0.4, 0.1); end
   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetShadowOffset(1, -1); end

   if (CanSetFont(InvoiceTextFontNormal)) then 	   	InvoiceTextFontNormal:SetFont(CLEAR_FONT_QUEST, 12 * CF_SCALE); end	-- 默认值：12
   if (CanSetFont(InvoiceTextFontNormal)) then 	   	InvoiceTextFontNormal:SetTextColor(0.15, 0.09, 0.04); end	-- 默认值：(0.18, 0.12, 0.06)

   if (CanSetFont(InvoiceTextFontSmall)) then 	   	InvoiceTextFontSmall:SetFont(CLEAR_FONT_QUEST, 12 * CF_SCALE); end	-- 默认值：10
   if (CanSetFont(InvoiceTextFontSmall)) then 	   	InvoiceTextFontSmall:SetTextColor(0.15, 0.09, 0.04); end	-- 默认值：(0.18, 0.12, 0.06)


-- -----------------------------------------------------------------------------
-- 技能书：技能副标题
-- -----------------------------------------------------------------------------

   if (CanSetFont(SubSpellFont)) then 	   		SubSpellFont:SetFont(CLEAR_FONT_QUEST, 12 * CF_SCALE); end	-- 默认值：12


-- -----------------------------------------------------------------------------
-- 状态栏：单位框架的数字、Damage Meters
-- -----------------------------------------------------------------------------

   if (CanSetFont(TextStatusBarText)) then 	   	TextStatusBarText:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE, "OUTLINE"); end	-- 默认值：12
   if (CanSetFont(TextStatusBarTextSmall)) then 	TextStatusBarTextSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end


-- -----------------------------------------------------------------------------
-- 提示框
-- -----------------------------------------------------------------------------

   if (CanSetFont(GameTooltipText)) then 	   	GameTooltipText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end		-- 默认值：13
   if (CanSetFont(GameTooltipTextSmall)) then 	   	GameTooltipTextSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end	-- 默认值：12
   if (CanSetFont(GameTooltipHeaderText)) then 	   	GameTooltipHeaderText:SetFont(CLEAR_FONT, 14 * CF_SCALE, "OUTLINE"); end	-- 默认值：16


-- -----------------------------------------------------------------------------
-- 世界地图：位置标题
-- -----------------------------------------------------------------------------

   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetFont(CLEAR_FONT, 102 * CF_SCALE, "THICKOUTLINE"); end	-- 默认值：102
   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetShadowColor(0, 0, 0); end	-- 默认值：(1.0, 0.9294, 0.7607)
   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetShadowOffset(1, -1); end
   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetAlpha(40); end


-- -----------------------------------------------------------------------------
-- 区域切换显示：在屏幕中央通知
-- -----------------------------------------------------------------------------

   if (CanSetFont(ZoneTextFont)) then 	   		ZoneTextFont:SetFont(CLEAR_FONT, 112 * CF_SCALE, "THICKOUTLINE"); end		-- 默认值：112
   if (CanSetFont(ZoneTextFont)) then 	   		ZoneTextFont:SetShadowColor(0, 0, 0); end	-- 默认值：(1.0, 0.9294, 0.7607)
   if (CanSetFont(ZoneTextFont)) then 	   		ZoneTextFont:SetShadowOffset(1, -1); end

   if (CanSetFont(SubZoneTextFont)) then 	   	SubZoneTextFont:SetFont(CLEAR_FONT, 26 * CF_SCALE, "THICKOUTLINE"); end		-- 默认值：26


-- -----------------------------------------------------------------------------
-- 战斗纪录文字
-- -----------------------------------------------------------------------------

   if (CanSetFont(CombatLogFont)) then 			CombatLogFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end	-- 默认值：16


-- -----------------------------------------------------------------------------
-- PVP信息（“争夺中的领土”、“联盟领地”等）
-- -----------------------------------------------------------------------------

   if (CanSetFont(PVPInfoTextFont)) then 		PVPInfoTextFont:SetFont(CLEAR_FONT, 22 * CF_SCALE, "THICKOUTLINE"); end		-- 默认值：22


	end




-- =============================================================================
--  C. 每当一个插件载入时都重新载入的功能
--  他们真喜欢搞乱我的插件！
-- =============================================================================

	ClearFont:SetScript("OnEvent",
		    function() 
		       if (event == "ADDON_LOADED") then
			  ClearFont:ApplySystemFonts()
		       end
		    end);

	ClearFont:RegisterEvent("ADDON_LOADED");




-- =============================================================================
--  D. 第一次启动时应用以上设定
--  让球能够滚起来
-- =============================================================================

	ClearFont:ApplySystemFonts()
