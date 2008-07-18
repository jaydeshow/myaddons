DROODFOCUS_VERSION	= "2.2.20b";
DROODFOCUS		= "Drood Focus "..DROODFOCUS_VERSION;
DROODFOCUS_WELCOME	= "Drood Focus "..DROODFOCUS_VERSION.."(edit mod by yleaf) - Type /droodfocus or /df for options.";
DROODFOCUS_SCALE	= "Scale";
DROODFOCUS_LOW		= "Low";
DROODFOCUS_HIGH		= "High";
DROODFOCUS_LOCK		= "Locked.";
--DROODFOCUS_CLAWS	= "Claws/blood on critical strike."
DROODFOCUS_CLAWS	= "##########";
DROODFOCUS_TRACKER	= "Show debuffs bar."
DROODFOCUS_CONTX	= "X"
DROODFOCUS_CONTY	= "Y"
DROODFOCUS_MINI		= "Min."
DROODFOCUS_MAXI		= "Max."
DROODFOCUS_ENABLE	= "Enabled."
--DROODFOCUS_ALPHA	= "Alpha."
DROODFOCUS_ALPHA	= "##########";


if (GetLocale() == "zhCN") then
	-- locale by Jiyun@CWDG
	-- 2008-7-7 DROOD FOCUS v2.2.19b
	--DROODFOCUS_VERSION	= "2.2.19b";
	--DROODFOCUS		= "Drood Focus "..DROODFOCUS_VERSION;
	DROODFOCUS_WELCOME	= "Drood Focus "..DROODFOCUS_VERSION.."(修改版 by yleaf) - 键入 /droodfocus 或 /df 打开设置.";
	DROODFOCUS_SCALE	= "缩放";
	DROODFOCUS_LOW		= "低";
	DROODFOCUS_HIGH		= "高";
	DROODFOCUS_LOCK		= "锁定.";
	--DROODFOCUS_CLAWS	= "爆击时显示爪痕/血腥效果.";
	DROODFOCUS_CLAWS	= "##########";
	DROODFOCUS_TRACKER	= "显示减益栏.";
	--DROODFOCUS_CONTX	= "X";
	--DROODFOCUS_CONTY	= "Y";
	DROODFOCUS_MINI		= "最小.";
	DROODFOCUS_MAXI		= "最大.";
	DROODFOCUS_ENABLE	= "开启.";
	--DROODFOCUS_ALPHA	= "血腥效果.";
	DROODFOCUS_ALPHA	= "##########";

elseif (GetLocale() == "zhTW") then
	-- locale by Jiyun@CWDG
	-- 2008-7-7 DROOD FOCUS v2.2.19b
	--DROODFOCUS_VERSION = "2.2.19b";
	--DROODFOCUS = "Drood Focus "..DROODFOCUS_VERSION;
	DROODFOCUS_WELCOME = "Drood Focus "..DROODFOCUS_VERSION.."(修改版 by yleaf) - 鍵入 /droodfocus 或 /df 打開設置.";
	DROODFOCUS_SCALE = "縮放";
	DROODFOCUS_LOW = "低";
	DROODFOCUS_HIGH = "高";
	DROODFOCUS_LOCK = "鎖定.";
	--DROODFOCUS_CLAWS = "致命一击時顯示爪痕/血腥效果.";
	DROODFOCUS_CLAWS = "##########";
	DROODFOCUS_TRACKER = "顯示減益欄.";
	--DROODFOCUS_CONTX = "X";
	--DROODFOCUS_CONTY = "Y";
	DROODFOCUS_MINI = "最小.";
	DROODFOCUS_MAXI = "最大.";
	DROODFOCUS_ENABLE = "開啟.";
	DROODFOCUS_ALPHA = "血腥效果.";
	DROODFOCUS_ALPHA = "##########";
end