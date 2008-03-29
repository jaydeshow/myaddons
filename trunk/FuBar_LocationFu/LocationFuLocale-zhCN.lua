--Chinese  Local : CWDG Translation Team feilang999
--$Rev$
--$Date$

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("FuBar_LocationFu")

L:AddTranslations("zhCN", function() return {
	["Open world map"] = "打开世界地图",
	["Open Atlas"] = "打开 Atlas 副本地图",
	["Show coordinates"] = "显示坐标",
	["Toggle the coordinates in the text of this plugin"] = "开启显示坐标",
	["Show subzone name"] = "显示子地区名称",
	["Show zone name"] = "显示地区名称",
	["Toggle the zone name in the text of this plugin"] = "开启显示地区名称",
	["Show level range"] = "显示等级范围",
	["Show minimap bar"] = "显示小地图栏",
	["Show the bar above the minimap that tells the location and allows you to close minimap"] = "显示小地图栏上的位置条",
	["Show recommended zones"] = "显示推荐地区",
	["Show your recommended zones in the tooltip"] = "在提示里显示推荐的地区",
	["Zone:"] = "地区：",
	["Subzone:"] = "子地区：",
	["Arena"] = "PvP区域",
	["Friendly"] = "友好",
	["Contested"] = "争夺中",
	["Hostile"] = "敌对",
	["Status:"] = "状态：",
	["Sanctuary"] = "圣殿",
	["Coordinates:"] = "坐标：",
	["Level range:"] = "等级范围：",
	["Instances"] = "副本",
	["Recommended zones"] = "推荐地区",
	["Recommended instances"] = "推荐副本",
	["Continent:"] = "大陆：",
	
	["    Walk path from %s to %s:"] = "    从 %s 到 %s 的行走路线：",
	["    No path found"] = "    找不到路线",
	
	["%d-man"] = "%d 人副本", -- as in a 40-man raid
	
	["Atlas-hint"] = "|cffeda55f点击|r打开 Atlas 副本地图",
	["Standard-hint"] = "|cffeda55f点击|r打开世界地图",
	["Shift-hint"] = "|cffeda55fShift-点击|r往聊天窗口插入坐标",
	["Ctrl-hint"] = "|cffeda55fCtrl-点击|r打开世界地图",
	["Ctrl-Atlas-hint"] = "|cffeda55fCtrl-点击|r打开 Atlas 副本地图",
	
	["AceConsole-options"] = {"/locfu", "/locationfu"},
} end)
