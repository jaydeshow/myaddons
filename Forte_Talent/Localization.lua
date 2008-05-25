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

-- simple chinese
if GetLocale() == "zhCN" then

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.TS = "天赋助手";
FW.L.TS_USE = "在你的天赋窗口有新的下拉菜单使用.";
FW.L.TS_HINT = "你必须要观察那些没有装此插件的人,以保存其天赋.";
FW.L.TALENT_OFFSETX = "菜单水平偏移";
FW.L.TALENT_OFFSETY = "菜单垂直偏移";
FW.L.TALENT_OFFSET_TT = "此选项是为了你使用自定义天赋窗口,需要移动下拉菜单和按钮准备的";

-- tradition chinese
elseif GetLocale() == "zhTW" then
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.TS = "天賦助手";
FW.L.TS_USE = "在你的天賦視窗有新的下拉功能表使用.";
FW.L.TS_HINT = "你必須要觀察那些沒有裝此插件的人,以保存其天賦.";
FW.L.TALENT_OFFSETX = "菜單水準偏移";
FW.L.TALENT_OFFSETY = "菜單垂直偏移";
FW.L.TALENT_OFFSET_TT = "此選項是為了你使用自定義天賦視窗,需要移動下拉功能表和按鈕準備的";

-- ENGLISH
else
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.TS = "Talent Spy";
FW.L.TS_USE = "You can use the new spy dropdown menu from your Talent frame.";
FW.L.TS_HINT = "For now you have to inspect people that aren't using the addon to store their talents.";
FW.L.TALENT_OFFSETX = "X-offset dropdown";
FW.L.TALENT_OFFSETY = "Y-offset dropdown";
FW.L.TALENT_OFFSET_TT = "Use this in case you're using a customized Talent Frame and need to change the position of the dropdown and buttons.";
end
