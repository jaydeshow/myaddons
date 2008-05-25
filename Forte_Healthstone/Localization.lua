-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x

--[[
"frFR": French
"deDE": German
"esES": Spanish
"enUS": American english
"enGB": British english

!! Make sure to keep this saved as UTF-8 format !!

]]

--[[>> still needs translating]]

-- FR
if GetLocale() == "frFR" then

-- DE 
elseif GetLocale() == "deDE" then

-- SPANISH
elseif GetLocale() == "esES" then

-- ENGLISH
else

end


-- Simple Chinese
if GetLocale() == "zhCN" then
	
	
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.GET_HS_UPDATE = "扫描糖果数据.只有装了FW的同志拥有团队权限才能实现所有功能";
FW.L.UPDATE_AND_RITUAL = "扫描糖果 / 灵魂仪式";

FW.L.HEALTHSTONE_SPY = "糖果助手";
FW.L.LITTLE_HS = "糖果少";
FW.L.MANY_HS = "糖果多";
FW.L.SHOW_MISSING = "显示缺少的糖果";
FW.L.SHOW_MISSING_TT = "糖果条上显示的是缺少的糖果,而不是团队中现有的糖果.";
FW.L.NUM_TYPES = "监视糖果类型";
FW.L.NUM_TYPES_TT = "最多监视糖果类型.";
FW.L.ONLY_TOP_RANK = "只显示顶级糖果";
FW.L.ONLY_TOP_RANK_TT = "开启此功能,插件不会监视其他级别的糖果. 禁用此功能,插件显示所有类型糖果.";

FW.L.HS_ENABLE_TT = "启用糖果助手.";

FW.L.YOU_HAVE_ = "你现有:";

FW.L.HEALTHSTONE_CHECK_TIME = "治疗石检查";
FW.L.HEALTHSTONE_DRAW_INTERVAL = "治疗石扫描间隔";


-- trdition Chinese
elseif GetLocale() == "zhTW" then
	
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.GET_HS_UPDATE = "掃描糖果資料.只有裝了FW的同志擁有團隊許可權才能實現所有功能";
FW.L.UPDATE_AND_RITUAL = "掃描糖果 / 靈魂儀式";

FW.L.HEALTHSTONE_SPY = "糖果助手";
FW.L.LITTLE_HS = "糖果少";
FW.L.MANY_HS = "糖果多";
FW.L.SHOW_MISSING = "顯示缺少的糖果";
FW.L.SHOW_MISSING_TT = "糖果條上顯示的是缺少的糖果,而不是團隊中現有的糖果.";
FW.L.NUM_TYPES = "監視糖果類型";
FW.L.NUM_TYPES_TT = "最多監視糖果類型.";
FW.L.ONLY_TOP_RANK = "只顯示頂級糖果";
FW.L.ONLY_TOP_RANK_TT = "開啟此功能,插件不會監視其他級別的糖果. 禁用此功能,插件顯示所有類型糖果.";

FW.L.HS_ENABLE_TT = "啟用糖果助手.";

FW.L.YOU_HAVE_ = "你現有:";

FW.L.HEALTHSTONE_CHECK_TIME = "治療石檢查";
FW.L.HEALTHSTONE_DRAW_INTERVAL = "治療石掃描間隔";

-- ENGLISH
else
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.GET_HS_UPDATE = "Get an update of healthstone status now. Will only fully work when someone with the addon is promoted!";
FW.L.UPDATE_AND_RITUAL = "Update Now / Ritual of Souls";

FW.L.HEALTHSTONE_SPY = "Healthstone Spy";
FW.L.LITTLE_HS = "Little Healthstones";
FW.L.MANY_HS = "Many Healthstones";
FW.L.SHOW_MISSING = "Show missing";
FW.L.SHOW_MISSING_TT = "Instead of the number of healthstones present in the raid, the bars will show the number of missing healthstones.";
FW.L.NUM_TYPES = "Number of types to track";
FW.L.NUM_TYPES_TT = "The maximum number of Healthstone types to track.";
FW.L.ONLY_TOP_RANK = "Only show top rank";
FW.L.ONLY_TOP_RANK_TT = "With this enabled, the spy will not show healthstones of different ranks. Disabled, it will always display the number of types you specified.";

FW.L.HS_ENABLE_TT = "Enable the Healthstone Spy.";

FW.L.YOU_HAVE_ = "You have:";

FW.L.HEALTHSTONE_CHECK_TIME = "Healthstone check";
FW.L.HEALTHSTONE_DRAW_INTERVAL = "Healthstone draw interval";

end