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

-- FR missing
if GetLocale() == "frFR" then

-- DE missing
elseif GetLocale() == "deDE" then
	
-- SPANISH - mising
elseif GetLocale() == "esES" then

-- ENGLISH
else	-- standard english version

end

-- simple chinese
if GetLocale() == "zhCN" then

FW.L.BATTLE_SHOUT = "战斗怒吼";
FW.L.COMMANDING_SHOUT = "命令怒吼";	
FW.L.ENRAGE = "激怒";	
FW.L.RAMPAGE = "暴跳如雷";	
FW.L.RAGE_OF_THE_UNRAVELLER = "瓦解者之怒";
FW.L.FEROCITY = "凶暴";	
FW.L.SWEEPING_STRIKES = "横扫攻击";	
FW.L.LIGHTNING_SPEED = "闪电之速";	
FW.L.SUNDER_ARMOR = "破甲攻击";
FW.L.LUST_FOR_BATTLE = "战斗欲望";
FW.L.HASTE = "加速";
FW.L.BURNING_HATRED = "燃烧之恨";
FW.L.ANCIENT_POWER = "上古能量";

FW.L.MORTAL_STRIKE = "致死打击";
FW.L.REND = "撕裂";
FW.L.HAMSTRING = "断筋";
FW.L.BLOODRAGE = "血性狂暴";
FW.L.THUNDER_CLAP = "雷霆一击";
FW.L.DEMORALIZING_SHOUT = "挫志怒吼";
FW.L.SHIELD_BASH = "盾击";
FW.L.DEATH_WISH = "死亡之愿";

-- tradition chinese
elseif GetLocale() == "zhTW" then

FW.L.BATTLE_SHOUT = "戰鬥怒吼";
FW.L.COMMANDING_SHOUT = "命令之吼";	
FW.L.ENRAGE = "狂怒";	
FW.L.RAMPAGE = "暴怒";	
FW.L.RAGE_OF_THE_UNRAVELLER = "破壞者之怒";
FW.L.FEROCITY = "兇暴";	
FW.L.SWEEPING_STRIKES = "橫掃攻擊";	
FW.L.LIGHTNING_SPEED = "閃電速度";	
FW.L.SUNDER_ARMOR = "破甲攻擊";
FW.L.LUST_FOR_BATTLE = "戰鬥慾望";
FW.L.HASTE = "加速";
FW.L.BURNING_HATRED = "燃燒憎恨";
FW.L.ANCIENT_POWER = "上古能量";

FW.L.MORTAL_STRIKE = "致死打擊";
FW.L.REND = "撕裂";
FW.L.HAMSTRING = "斷筋";
FW.L.BLOODRAGE = "血性狂暴";
FW.L.THUNDER_CLAP = "雷霆一擊";
FW.L.DEMORALIZING_SHOUT = "挫志怒吼";
FW.L.SHIELD_BASH = "盾擊";
FW.L.DEATH_WISH = "死亡之願";

else

FW.L.BATTLE_SHOUT = "Battle Shout";
FW.L.COMMANDING_SHOUT = "Commanding Shout";    
FW.L.ENRAGE = "Enrage";    
FW.L.RAMPAGE = "Rampage";    
FW.L.RAGE_OF_THE_UNRAVELLER = "Rage of the Unraveller";
FW.L.FEROCITY = "Ferocity";    
FW.L.SWEEPING_STRIKES = "Sweeping Strikes";    
FW.L.LIGHTNING_SPEED = "Lightning Speed";    
FW.L.SUNDER_ARMOR = "Sunder Armor";
FW.L.LUST_FOR_BATTLE = "Lust for Battle";
FW.L.HASTE = "Haste";
FW.L.BURNING_HATRED = "Burning Hatred";
FW.L.ANCIENT_POWER = "Ancient Power";

FW.L.MORTAL_STRIKE = "Mortal Strike";
FW.L.REND = "Rend";
FW.L.HAMSTRING = "Hamstring";
FW.L.BLOODRAGE = "Bloodrage";
FW.L.THUNDER_CLAP = "Thunder Clap";
FW.L.DEMORALIZING_SHOUT = "Demoralizing Shout";
FW.L.SHIELD_BASH = "Shield Bash";
FW.L.DEATH_WISH = "Death Wish";

end