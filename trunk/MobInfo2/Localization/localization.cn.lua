-- 
-- Chinese(Simplified) Localisation for MobInfo
--
-- created by wangmarsfa@cwdg
--


MI2_Locale = GetLocale()

if ( MI2_Locale == "zhCN" ) then

MI2_SpellSchools = { ["奥术"]="ar", ["火焰"]="fi", ["冰霜"]="fr", ["暗影"]="sh", ["神圣"]="ho", ["自然"]="na" } 

MI_TXT_WELCOME          = "欢迎使用 MobInfo 2"
MI_DESCRIPTION		= "添加目标的详细信息到提示框, 并且在目标状态栏显示生命和魔法数据"
MI_TXT_GENERAL_OPTIONS	= "本页面为MobInfo插件的主控制面板。\n其他面板用来配置详细的参数。"

MI_TXT_GOLD   = 	" 金"
MI_TXT_SILVER = 	" 银"
MI_TXT_COPPER = 	" 铜"

MI_TXT_OPEN = 		"开启"
MI_TXT_COMBINED	= 	"等级范围: "
MI_TXT_MOB_DB_SIZE		= "MobInfo 数据库:  "
MI_TXT_HEALTH_DB_SIZE	= "怪物生命值数据库:  "
MI_TXT_PLAYER_DB_SIZE	= "玩家生命值数据库:  "
MI_TXT_ITEM_DB_SIZE		= "物品数据库:  "
MI_TXT_CUR_TARGET		= "当前目标:  "
MI_TXT_MH_DISABLED		= "MobInfo 警告: 发现其他的 MobHealth 插件。本插件自带的 MobHealth 功能已禁用, 请删除其他MobHealth插件以启用本插件全部功能。"
MI_TXT_MH_DISABLED2		= (MI_TXT_MH_DISABLED.."\n\n 当 MobHealth 功能禁用时, MOBInfo-2将不能准确的获取目标完整信息.\n\n这有益于目标生命值和魔法值的动态显示及调整字体的相关设定")
MI_TXT_CLR_ALL_CONFIRM	= "你确认要执行以下删除操作吗 ?"
MI_TXT_SEARCH_LEVEL		= "目标等级:"
MI_TXT_SEARCH_MOBTYPE	= "目标类型:"
MI_TXT_SEARCH_LOOTS		= "次数:"
MI_TXT_TRIM_DOWN_CONFIRM = "警告: 此项操作为永久性删除。/n你确定要删除所有未选择的目标数据么？"
MI_TXT_CLAM_MEAT		= "蚌肉"
MI_TXT_SHOWING			= "显示列表: "
MI_TXT_DROPPED_BY		= "掉落: "
MI_TXT_IMMUNE			= "免疫:"
MI_TXT_RESIST			= "抗性:"
MI_TXT_DEL_SEARCH_CONFIRM = "您确认要从资料库中, 删除搜索结果中的 %d 条目标的数据？"
MI_TXT_WRONG_LOC		= "错误：MobInfo数据库语言与你wow的客户端语言不符，MobInfo数据库将停止工作！"
MI_TXT_WRONG_DBVER		= "错误：你的MobInfo数据库太陈旧或者与本版本不兼容。\n\nMobInfo将全部删除你的旧数据库。"
MI_TXT_PRICE			= "出售地点: "
MI_TXT_TOOLTIP_MOVE		= "如果要移动提示锚点\n点击并拖拽到一个新位置即可"
MI_TXT_ITEMFILTER = "列表过滤"

MI2_CHAT_MOBRUNS = "转身逃跑"
MI2_TXT_MOBRUNS = "*逃跑！*"

BINDING_HEADER_MI2HEADER	= "MobInfo 2"
BINDING_NAME_MI2CONFIG	= "开启 MobInfo2 设置面板"

MI2_FRAME_TEXTS = {}
MI2_FRAME_TEXTS["MI2_FrmTooltipContent"]	= "目标提示相关"
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]		= "目标生命值选项"
MI2_FRAME_TEXTS["MI2_FrmDatabaseOptions"]	= "数据库选项"
MI2_FRAME_TEXTS["MI2_FrmHealthValueOptions"]	= "生命值"
MI2_FRAME_TEXTS["MI2_FrmManaValueOptions"]	= "法力值"
MI2_FRAME_TEXTS["MI2_FrmSearchOptions"]		= "搜索选项"
MI2_FRAME_TEXTS["MI2_FrmImportDatabase"]	= "导入 MobInfo 外部数据库"
MI2_FRAME_TEXTS["MI2_FrmItemTooltip"]		= "物品提示选项"
MI2_FRAME_TEXTS["MI2_FrmTooltipLayout"]		= "MobInfo提示层级"


---------------------------
-- Tooltip Options/Content
---------------------------

MI_TXT_HEALTH		= "生命值"
MI_HLP_HEALTH		= "显示目标生命值信息(当前/最大)"
MI_TXT_MANA		= "法力值"
MI_HLP_MANA		= "显示目标法力值/怒气值/精力值信息(当前/最大)"
MI_TXT_KILLS		= "击杀"
MI_HLP_KILLS		= "显示你对该目标的击杀次数\n击杀次数将分角色记录"
MI_TXT_LOOTS		= "拾取"
MI_HLP_LOOTS		= "显示目标被拾取的次数"
MI_TXT_COINS		= "金钱掉落"
MI_HLP_COINS		= "显示每个种类目标平均掉落的金钱数目\n掉落的金钱总数除以拾取次数\n(拾取为0时不显示)"
MI_TXT_ITEMVAL		= "物品价值"
MI_HLP_ITEMVAL		= "显示每个该种目标掉落物品的平均价值\n掉落物品的价值总量除以拾取次数\n(拾取为0时不显示)"
MI_TXT_MOBVAL		= "总价值"
MI_HLP_MOBVAL		= "显示每个目标的平均总价值\n将按照平均金钱加平均物品价值计算"
MI_TXT_XP		= "经验"
MI_HLP_XP		= "显示当前目标可获取经验数\n按照以前该目标给你的经验计算。\n(对于灰名目标不显示)"
MI_TXT_TO_LEVEL		= "升级需要"
MI_HLP_TO_LEVEL		= "显示你要杀多少该类型怪物才能升级\n(对于灰名目标不显示)"
MI_TXT_EMPTY_LOOTS	= "无效拾取"
MI_HLP_EMPTY_LOOTS	= "显示发现空尸体的次数(次数/百分比)\n当你拾取空尸体的时候将计算。"
MI_TXT_CLOTH_DROP	= "布料掉率"
MI_HLP_CLOTH_DROP	= "显示目标的布料掉率"
MI_TXT_CLASS		= "目标类别"
MI_HLP_CLASS		= "显示目标的类别"
MI_TXT_DAMAGE		= "伤害"
MI_HLP_DAMAGE		= "显示目标的伤害值范围 (最小/最大)和DPS (每秒伤害)\n伤害值范围和DPS是按每个玩家角色\n来单独计算和存储的。\nDPS信息更新较慢但是会随着每次战斗而增加。"
MI_TXT_QUALITY		= "拾取质量"
MI_OPT_QUALITY		= "物品拾取列表"
MI_HLP_QUALITY		= "显示战利品质量计数和百分比\n按品质类别统计显示杀死目标获得的战利品数目.\n没有掉落过物品的类别将不显示.\n百分比表示该类物品从该目标掉落的几率."
MI_TXT_LOCATION		= "地区"
MI_HELP_LOCATION	= "显示目标能被找到的地区\n要使这项起作用必须开启记录地区数据"
MI_TXT_LOWHEALTH	= "逃逸指示"
MI_HELP_LOWHEALTH	= "在目标低生命企图逃逸时显示指示器\n指示器将以红色文字提示方式显示\n仅在会逃逸的目标提示中显示"
MI_OPT_RESISTS		= "抗性与免疫"
MI_TXT_RESISTS		= "抗性"
MI_TXT_IMMUN		= "免疫"
MI_HELP_RESISTS		= "在提示信息中显示目标的抗性及免疫力\n对于目标已记录的法术类别、抗性、免疫类别等将在提示中显示"
MI_TXT_ITEMLIST		= "拾取列表"
MI_HELP_ITEMLIST	= "显示所有基本拾取物品名称和数量\n基本拾取物品是除了布和皮拾取外的所有拾取的物品.\n要使这个选项起作用必须开启记录拾取物品数据选项"
MI_TXT_CLOTHSKIN	= "布皮拾取"
MI_HELP_CLOTHSKIN	= "显示所有布和皮拾取物品名称和数量\n要使这个选项起作用必须开启记录拾取物品数据选项"


--------------------
-- General Options
--------------------
MI2_OPTIONS = {};

MI2_OPTIONS["MI2_OptSaveBasicInfo"] = 
{ text = "记录基本目标信息";
help = "基本目标信息包括: 经验值, 目标类型; 计算值包括: 拾取, 空拾取, 皮与布, 金钱, 物品的价值等。" }

MI2_OPTIONS["MI2_OptShowMobInfo"] = 
{ text = "提示信息"; 
help = "在目标提示中显示MobInfo相关信息" }

MI2_OPTIONS["MI2_OptUseGameTT"] = 
{ text = "使用内建提示替代MobInfo提示"; 
help = "使用游戏内置的提示替代MobInfo自带的提示" }

MI2_OPTIONS["MI2_OptShowItemInfo"] = 
{ text = "显示物品信息"; 
help = "显示或关闭物品相关信息的提示" }

MI2_OPTIONS["MI2_OptShowTargetInfo"] = 
{ text = "在目标窗体上显示MobInfo(生命值、法力值等)"; 
help = "用MobInfo的数据显示目标的生命值、法力值等相关信息" }

MI2_OPTIONS["MI2_OptShowMMButton"] = 
{ text = "显示迷你地图按钮"; 
help = "显示/隐藏MobInfo迷你地图按钮" }

MI2_OPTIONS["MI2_OptMMButtonPos"] = 
{ text = "迷你地图按钮方位"; 
help = "使用下面的滑杆定位你的MobInfo迷你地图按钮的位置" }


--------------------
-- Other Options
--------------------

MI2_OPTIONS["MI2_OptShowIGrey"] = 
{ text = ""; help = "在提示中显示灰色（劣质）物品。" }

MI2_OPTIONS["MI2_OptShowIWhite"] = 
{ text = ""; help = "在提示中显示白色（普通）物品。" }

MI2_OPTIONS["MI2_OptShowIGreen"] = 
{ text = ""; help = "在提示中显示绿色（精良）物品。" }

MI2_OPTIONS["MI2_OptShowIBlue"] = 
{ text = ""; help = "在提示中显示蓝色（稀有）物品。" }

MI2_OPTIONS["MI2_OptShowIPurple"] = 
{ text = ""; help = "在提示中显示紫色（史诗）物品。" }

MI2_OPTIONS["MI2_OptMouseTooltip"] = 
{ text = "跟随鼠标"; help = "MobInfo提示信息将在鼠标悬停处显示\n并跟随鼠标的移动而移动。" }

MI2_OPTIONS["MI2_OptHideAnchor"] = 
{ text = "隐藏提示锚点"; help = "隐藏MobInfo的'MI'提示锚点。\n该锚点在打开选项窗口且该选项禁用时可见。" }

MI2_OPTIONS["MI2_OptShowCombined"] = 
{ text = "整合怪物信息"; help = "显示整合信息于提示中\n当该选项启用时，将显示该类型怪物的等级范围。" }

MI2_OPTIONS["MI2_OptSmallFont"] = 
{ text = "使用小字体"; help = "在提示中使用小字体。" }

MI2_OPTIONS["MI2_OptTooltipMode"] = 
{ text = "提示位置"; help = "MobInfo提示与提示锚点的位置关系。";
choice1 = "左上"; choice2 = "左下"; choice3 = "右上"; choice4 = "右下" }

MI2_OPTIONS["MI2_OptCompactMode"] =
{ text = "两列提示"; help = "以两列的方式显示提示信息\n此方式将使提示变宽变短\n但总宽度将被严格显示，太长的信息将另起一行。" }

MI2_OPTIONS["MI2_OptOtherTooltip"] =
{ text = "隐藏其他提示"; help = "当显示怪物信息时隐藏其他提示信息。" }

MI2_OPTIONS["MI2_OptSearchMinLevel"] = 
{ text = "最小"; help = "搜索选项的目标等级下限。"; }

MI2_OPTIONS["MI2_OptSearchMaxLevel"] = 
{ text = "最大"; help = "搜索选项的目标等级上限(必须小于66)。"; }

MI2_OPTIONS["MI2_OptSearchNormal"] = 
{ text = "普通"; help = "搜索结果包含普通目标。"; }

MI2_OPTIONS["MI2_OptSearchElite"] = 
{ text = "精英"; help = "搜索结果包含精英目标。"; }

MI2_OPTIONS["MI2_OptSearchBoss"] = 
{ text = "首领"; help = "搜索结果包含首领目标。"; }

MI2_OPTIONS["MI2_OptSearchMinLoots"] = 
{ text = "最少拾取"; help = "怪物最少被拾取的次数\n低于该值的信息将不包含在搜索结果中。"; }

MI2_OPTIONS["MI2_OptSearchMaxLoots"] = 
{ text = "最多拾取"; help = "怪物最多被拾取的次数。"; }

MI2_OPTIONS["MI2_OptSearchMobName"] = 
{ text = "目标名称"; help = "部分或者全部的目标名称。";
info = '留空将不搜索特定目标\n键入"*"选择所有目标。'; }

MI2_OPTIONS["MI2_OptSearchItemName"] = 
{ text = "物品名称"; help = "部分或者完整的物品名称。";
info = '留空选择所有物品。'; }

MI2_OPTIONS["MI2_OptSortByValue"] = 
{ text = "按收益"; help = "按照目标收益列出搜索结果。";
info = '按照杀死目标的收益来排列搜索结果。'; }

MI2_OPTIONS["MI2_OptSortByItem"] = 
{ text = "按物品掉落"; help = "按照物品掉落率来排列结果。";
info = '按照目标对指定物品的掉落率来排列'; }

MI2_OPTIONS["MI2_OptItemTooltip"] =
{ text = "物品提示目标"; help = "在物品提示中显示哪些目标掉落该物品。";
info = "在物品提示中显示哪些怪物掉落该物品\n该列表按照目标掉落几率排序。" }

MI2_OPTIONS["MI2_OptShowItemPrice"] =
{ text = "显示商人售价"; help = "在提示中显示商人的出售价格。" }

MI2_OPTIONS["MI2_OptCombinedMode"] = 
{ text = "整合目标"; help = "整合同名目标的数据。";
info = "整合模式将整合同名但不同级别的目标的数据\n当启用本项时，提示中将出现等级范围。" }

MI2_OPTIONS["MI2_OptKeypressMode"] = 
{ text = "ALT显示模式"; help = "只有按下ALT才会在提示框显示目标信息。"; }

MI2_OPTIONS["MI2_OptItemFilter"] = 
{ text = "掉落物品过滤"; help = "设置提示信息里显示的拾取物品的过滤条件。";
info = "只在提示信息中显示那些包含过滤文本的物品。\n例如输入'布'将只显示物品名称包含'布'的物品。\n不输入任何文字查看所有物品。" }

MI2_OPTIONS["MI2_OptSavePlayerHp"] = 
{ text = "永久储存玩家生命值"; help = "永久储存在PVP战斗中获得的玩家生命值数据。";
info = "通常情况下PVP战斗结束\n后玩家生命值数据将被丢弃\n这个选项允许你记录该数据。" }

MI2_OPTIONS["MI2_OptAllOn"] = 
{ text = "选项全开"; help = "将所有的显示选项打开。"; }

MI2_OPTIONS["MI2_OptAllOff"] = 
{ text = "选项全关"; help = "将所有的显示选项关闭。"; }

MI2_OPTIONS["MI2_OptDefault"] = 
{ text = "缺省模式"; help = "显示默认的目标信息。"; }

MI2_OPTIONS["MI2_OptBtnDone"] = 
{ text = "确 定"; help = "关闭 MobInfo 选项对话框。"; }

MI2_OPTIONS["MI2_OptTargetHealth"] = 
{ text = "显示生命值"; help = "在目标框中显示生命值。"; }

MI2_OPTIONS["MI2_OptTargetMana"] = 
{ text = "显示魔法值"; help = "在目标框中显示魔法值。"; }

MI2_OPTIONS["MI2_OptHealthPercent"] = 
{ text = "生命百分比"; help = "在目标框中添加生命值百分比。"; }

MI2_OPTIONS["MI2_OptManaPercent"] = 
{ text = "法力百分比"; help = "在目标框添中加法力值百分比。"; }

MI2_OPTIONS["MI2_OptHealthPosX"] = 
{ text = "水平位置"; help = "调整生命值的水平位置。"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
{ text = "垂直位置"; help = "调整生命值的垂直位置。"; }

MI2_OPTIONS["MI2_OptManaPosX"] = 
{ text = "水平位置"; help = "调整法力值的水平位置。"; }

MI2_OPTIONS["MI2_OptManaPosY"] = 
{ text = "垂直位置"; help = "调整法力值的垂直位置。"; }

MI2_OPTIONS["MI2_OptTargetFont"] = 
{ text = "字体"; help = "设置目标窗体的生命值/法力值字体。";
choice1= "数字字体"; choice2="游戏字体"; choice3="物品文字字体" }

MI2_OPTIONS["MI2_OptTargetFontSize"] = 
{ text = "字体大小"; help = "设置提示的生命值/法力值字体大小。"; }

MI2_OPTIONS["MI2_OptClearTarget"] = 
{ text = "清除数据"; help = "清除当前目标的数据。"; }

MI2_OPTIONS["MI2_OptClearMobDb"] = 
{ text = "清除数据"; help = "清除全部目标信息数据。"; }

MI2_OPTIONS["MI2_OptClearHealthDb"] = 
{ text = "清除数据"; help = "清除全部目标生命值数据。"; }

MI2_OPTIONS["MI2_OptClearPlayerDb"] = 
{ text = "清除数据"; help = "清除全部玩家生命值数据。"; }

MI2_OPTIONS["MI2_OptSaveItems"] = 
{ text = "物品最低质量级别: "; help = "开启后记录所有从目标身上拾取的物品详细数据。";
info = "你可以选择需被记录物品的最低质量级别。"; }

MI2_OPTIONS["MI2_OptSaveCharData"] = 
{ text = "记录角色相关的目标数据"; help = "开启后记录所有和玩家角色有关的目标信息数据.";
info = "开启或关闭保存以下数据: \n击杀次数, 最大/最小伤害, DPS(每秒伤害值)\n\n这些数据将按玩家角色分开保存. \n这几项数据只能同时保存或禁止保存。"; }

MI2_OPTIONS["MI2_OptSaveResist"] = 
{ text = "保存目标抗性与免疫力数据"; help = "纪录目标对哪些类型的法术有抗性或者免疫。";
info = "按照法术类型来记录哪些攻击是被减免的，哪些攻击是有效的。"; }

MI2_OPTIONS["MI2_OptItemsQuality"] = 
{ text = ""; help = "记录指定品质或以上的物品详细信息.";
choice1 = "质量高于灰色"; choice2="质量高于白色"; choice3="质量高于绿色" }

MI2_OPTIONS["MI2_OptTrimDownMobData"] = 
{ text = "优化目标数据库"; help = "通过移除重复的数据, 优化目标数据库。";
info = "过剩的数据是指数据库里未被设置为需要记录的全部数据。"; }

MI2_OPTIONS["MI2_OptImportMobData"] = 
{ text = "导入目标数据库"; help = "将其他MI2目标数据库导入到当前数据库中。";
info = "警告: 请在导入数据之前备份当前数据库资料！"; }

MI2_OPTIONS["MI2_OptDeleteSearch"] = 
{ text = "清除"; help = "从数据库中删除搜索结果列表。";
info = "警告: 此操作为永久性删除, 请备份你的数据库资料再执行此操作。"; }

MI2_OPTIONS["MI2_OptImportOnlyNew"] = 
{ text = "仅导入未知目标信息"; help = "只导入不存在于你当前数据库中的目标信息。";
info = "启用本项将仅导入未知目标的数据，已知目标的数据将不被覆盖。"; }

MI2_OPTIONS["MI2_SearchResultFrameTab1"] = 
{ text = "目标列表"; help = ""; }

MI2_OPTIONS["MI2_SearchResultFrameTab2"] = 
{ text = "物品列表"; help = ""; }

MI2_OPTIONS["MI2_OptionsTabFrameTab1"] = 
{ text = "提示信息"; help = "设置在提示信息里面显示的目标信息选项。"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab2"] = 
{ text = "生命/法力"; help = "设置目标框中显示 生命值/法力值 的选项。"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab3"] = 
{ text = "数据库"; help = "数据库管理选项。"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab4"] = 
{ text = "搜索"; help = "搜索目标数据库。"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab5"] = 
{ text = "全局"; help = "MobInfo插件全局选项。"; }

end
