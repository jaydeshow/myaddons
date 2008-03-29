-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x

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
	FW.L.RITUAL_OF_SUMMONING = "Rituel d'invocation";
	FW.L.MEETING_STONE_SUMMON = "Invocation  la pierre de rencontre";
	FW.L.SOULSTONE_RESURRECTION = "Pierre d'me";	
	FW.L.DELAY_MAX_FAIL = "Delay max resist/immune/evade";
	FW.L.DELAY_MAX_FASTCAST = "Delay max fastcast fail-success";

-- DE 
elseif GetLocale() == "deDE" then
	FW.L.RITUAL_OF_SUMMONING = "Ritual der Beschwrung";
	FW.L.MEETING_STONE_SUMMON = "Versammlungssteinbeschwrung";
	FW.L.SOULSTONE_RESURRECTION = "Seelensteinauferstehung";
	FW.L.DELAY_MAX_FAIL = "Delay max resist/immune/evade";
	FW.L.DELAY_MAX_FASTCAST = "Delay max fastcast fail-success";
	
-- SPANISH 2 Missing
elseif GetLocale() == "esES" then
	FW.L.RITUAL_OF_SUMMONING = "Ritual de invocacin";
--[[>>]]FW.L.MEETING_STONE_SUMMON = "Meeting Stone Summon";
--[[>>]]FW.L.SOULSTONE_RESURRECTION = "Soulstone Resurrection";
	FW.L.DELAY_MAX_FAIL = "Delay max resist/immune/evade";
	FW.L.DELAY_MAX_FASTCAST = "Delay max fastcast fail-success";

-- Simple Chinese
elseif GetLocale() == "zhCN" then
	FW.L.RITUAL_OF_SUMMONING = "召唤仪式";
	FW.L.MEETING_STONE_SUMMON = "集合石召唤";
	FW.L.SOULSTONE_RESURRECTION = "灵魂石复活";
	FW.L.DELAY_MAX_FAIL = "抵抗/免疫/闪避最大延迟";
	FW.L.DELAY_MAX_FASTCAST = "施法成功判断最大延迟";

-- tradition Chinese
elseif GetLocale() == "zhTW" then
	FW.L.RITUAL_OF_SUMMONING = "召喚儀式";
	FW.L.MEETING_STONE_SUMMON = "集合石召喚";
	FW.L.SOULSTONE_RESURRECTION = "靈魂石復活";
	FW.L.DELAY_MAX_FAIL = "抵抗/免疫/閃避最大延遲";
	FW.L.DELAY_MAX_FASTCAST = "施法成功判斷最大延遲";

-- ENGLISH
else
	FW.L.RITUAL_OF_SUMMONING = "Ritual of Summoning";
	FW.L.MEETING_STONE_SUMMON = "Meeting Stone Summon";
	FW.L.SOULSTONE_RESURRECTION = "Soulstone Resurrection";
	FW.L.DELAY_MAX_FAIL = "Delay max resist/immune/evade";
	FW.L.DELAY_MAX_FASTCAST = "Delay max fastcast fail-success";

end

