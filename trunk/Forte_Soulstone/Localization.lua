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
	FW.L.CREATE_SOULSTONE = "Cr閍tion de Pierre d'鈓e";
	FW.L.BUFF_SOULSTONE = "Pierre d'鈓e";
	FW.L.BUFF_SPIRIT_OF_REDEMPTION = "Esprit de r閐emption";
	FW.L.BUFF_DIVINE_INTERVENTION = "Intervention Divine";
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SOULSTONE_TRACKER = "Soulstone Tracker";
FW.L.SHOW_ALL_ABILITIES = "Show all class abilities (oRA/CTRA)";
FW.L.SHOW_ALL_ABILITIES_TT = "When enabled, you will be able to see all class ability cooldowns supported by oRA/CTRA.";
FW.L.SHOW_READY = "Show ready abilities";
FW.L.SHOW_READY_TT = "This will set the tracker to not only show abilities on cooldown, but also any abilities that are ready."; 
FW.L.SHOW_SOULSTONE_MESSAGES = "Show soulstone messages";
FW.L.SHOW_SOULSTONE_MESSAGES_TT = "Shows messages for expired soulstones and similar.";
FW.L.SOULSTONE_MESSAGES_COLOR = "Soulstone messages";
FW.L.SS_FULL = "Soulstone full";
FW.L.SS_EMPTY = "Soulstone empty";
FW.L.RESURRECT = "Resurrect";
FW.L.DEAD_OFFLINE_MIXING = "Dead/offline mixing";
FW.L.WARLOCK = "Warlock";
FW.L.DRUID = "Druid";
FW.L.PALADIN = "Paladin";
FW.L.SHAMAN = "Shaman";	
FW.L.DEAD_OFFLINE_MIXING_TT = "The class color is mixed with the dead or offline color with this ratio. 1.0 means the color will be completely class color. 0.0 means the color will be the dead or offline color only.";

FW.L.SS_ENABLE_TT = "Enable the Soulstone Tracker.";

FW.L.DI_GAIN = "%s got Divine Intervention.";
FW.L.DI_FADE = "Divine Intervention faded from %s.";
FW.L.SS_EXPIRE = "Soulstone expired on %s.";
FW.L.SS_EXPIRE_YOUR = "Your Soulstone expired on %s.";
FW.L.SS_EXPIRE_OTHER = "%s's Soulstone expired on %s.";
FW.L.SS_DIED = "%s died with a Soulstone on.";
FW.L.SS_DIED_YOUR = "%s died with your Soulstone on.";
FW.L.SS_DIED_OTHER = "%s died with %s's Soulstone on.";

FW.L.SHORT_READY = "rdy";
FW.L.READY_TO_RES = "ready to res";
FW.L.NO_SS_UP = "no ss up";

FW.L.FLAG_SOULSTONE = "<Soulstone>";
FW.L.FLAG_REBIRTH = "<Rebirth>";
FW.L.FLAG_DIVINE_INTERVENTION = "<Divine Int>";
FW.L.FLAG_ANKH = "<Ankh>";

FW.L.DELAY_MAX_SS_BUFF = "Delay max soulstone buff";

-- DE 
elseif GetLocale() == "deDE" then
	FW.L.CREATE_SOULSTONE = "Seelenstein herstellen";
	FW.L.BUFF_SOULSTONE = "Seelensteinauferstehung";
	FW.L.BUFF_SPIRIT_OF_REDEMPTION = "Geist der Erl鰏ung";
	FW.L.BUFF_DIVINE_INTERVENTION = "G鰐tliches Eingreifen";
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SOULSTONE_TRACKER = "Soulstone Tracker";
FW.L.SHOW_ALL_ABILITIES = "Show all class abilities (oRA/CTRA)";
FW.L.SHOW_ALL_ABILITIES_TT = "When enabled, you will be able to see all class ability cooldowns supported by oRA/CTRA.";
FW.L.SHOW_READY = "Show ready abilities";
FW.L.SHOW_READY_TT = "This will set the tracker to not only show abilities on cooldown, but also any abilities that are ready."; 
FW.L.SHOW_SOULSTONE_MESSAGES = "Show soulstone messages";
FW.L.SHOW_SOULSTONE_MESSAGES_TT = "Shows messages for expired soulstones and similar.";
FW.L.SOULSTONE_MESSAGES_COLOR = "Soulstone messages";
FW.L.SS_FULL = "Soulstone full";
FW.L.SS_EMPTY = "Soulstone empty";
FW.L.RESURRECT = "Resurrect";
FW.L.DEAD_OFFLINE_MIXING = "Dead/offline mixing";
FW.L.WARLOCK = "Warlock";
FW.L.DRUID = "Druid";
FW.L.PALADIN = "Paladin";
FW.L.SHAMAN = "Shaman";	
FW.L.DEAD_OFFLINE_MIXING_TT = "The class color is mixed with the dead or offline color with this ratio. 1.0 means the color will be completely class color. 0.0 means the color will be the dead or offline color only.";

FW.L.SS_ENABLE_TT = "Enable the Soulstone Tracker.";

FW.L.DI_GAIN = "%s got Divine Intervention.";
FW.L.DI_FADE = "Divine Intervention faded from %s.";
FW.L.SS_EXPIRE = "Soulstone expired on %s.";
FW.L.SS_EXPIRE_YOUR = "Your Soulstone expired on %s.";
FW.L.SS_EXPIRE_OTHER = "%s's Soulstone expired on %s.";
FW.L.SS_DIED = "%s died with a Soulstone on.";
FW.L.SS_DIED_YOUR = "%s died with your Soulstone on.";
FW.L.SS_DIED_OTHER = "%s died with %s's Soulstone on.";

FW.L.SHORT_READY = "rdy";
FW.L.READY_TO_RES = "ready to res";
FW.L.NO_SS_UP = "no ss up";

FW.L.FLAG_SOULSTONE = "<Soulstone>";
FW.L.FLAG_REBIRTH = "<Rebirth>";
FW.L.FLAG_DIVINE_INTERVENTION = "<Divine Int>";
FW.L.FLAG_ANKH = "<Ankh>";

FW.L.DELAY_MAX_SS_BUFF = "Delay max soulstone buff";

-- SPANISH
elseif GetLocale() == "esES" then
	FW.L.CREATE_SOULSTONE = "Crear piedra de alma";
	FW.L.BUFF_SOULSTONE = "Resurreci髇 con piedra de alma";
	FW.L.BUFF_SPIRIT_OF_REDEMPTION = "Spirit of Redemption";
	FW.L.BUFF_DIVINE_INTERVENTION = "Intervenci髇";
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SOULSTONE_TRACKER = "Soulstone Tracker";
FW.L.SHOW_ALL_ABILITIES = "Show all class abilities (oRA/CTRA)";
FW.L.SHOW_ALL_ABILITIES_TT = "When enabled, you will be able to see all class ability cooldowns supported by oRA/CTRA.";
FW.L.SHOW_READY = "Show ready abilities";
FW.L.SHOW_READY_TT = "This will set the tracker to not only show abilities on cooldown, but also any abilities that are ready."; 
FW.L.SHOW_SOULSTONE_MESSAGES = "Show soulstone messages";
FW.L.SHOW_SOULSTONE_MESSAGES_TT = "Shows messages for expired soulstones and similar.";
FW.L.SOULSTONE_MESSAGES_COLOR = "Soulstone messages";
FW.L.SS_FULL = "Soulstone full";
FW.L.SS_EMPTY = "Soulstone empty";
FW.L.RESURRECT = "Resurrect";
FW.L.DEAD_OFFLINE_MIXING = "Dead/offline mixing";
FW.L.WARLOCK = "Warlock";
FW.L.DRUID = "Druid";
FW.L.PALADIN = "Paladin";
FW.L.SHAMAN = "Shaman";	
FW.L.DEAD_OFFLINE_MIXING_TT = "The class color is mixed with the dead or offline color with this ratio. 1.0 means the color will be completely class color. 0.0 means the color will be the dead or offline color only.";

FW.L.SS_ENABLE_TT = "Enable the Soulstone Tracker.";

FW.L.DI_GAIN = "%s got Divine Intervention.";
FW.L.DI_FADE = "Divine Intervention faded from %s.";
FW.L.SS_EXPIRE = "Soulstone expired on %s.";
FW.L.SS_EXPIRE_YOUR = "Your Soulstone expired on %s.";
FW.L.SS_EXPIRE_OTHER = "%s's Soulstone expired on %s.";
FW.L.SS_DIED = "%s died with a Soulstone on.";
FW.L.SS_DIED_YOUR = "%s died with your Soulstone on.";
FW.L.SS_DIED_OTHER = "%s died with %s's Soulstone on.";

FW.L.SHORT_READY = "rdy";
FW.L.READY_TO_RES = "ready to res";
FW.L.NO_SS_UP = "no ss up";

FW.L.FLAG_SOULSTONE = "<Soulstone>";
FW.L.FLAG_REBIRTH = "<Rebirth>";
FW.L.FLAG_DIVINE_INTERVENTION = "<Divine Int>";
FW.L.FLAG_ANKH = "<Ankh>";

FW.L.DELAY_MAX_SS_BUFF = "Delay max soulstone buff";

-- simple chinese
elseif GetLocale() == "zhCN" then
	FW.L.CREATE_SOULSTONE = "制造灵魂石";
	FW.L.BUFF_SOULSTONE = "灵魂石复活";
	FW.L.BUFF_SPIRIT_OF_REDEMPTION = "救赎之魂";
	FW.L.BUFF_DIVINE_INTERVENTION = "神圣干涉";

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SOULSTONE_TRACKER = "灵魂石助手";
FW.L.SHOW_ALL_ABILITIES = "显示其他职业技能CD(oRA/CTRA)";
FW.L.SHOW_ALL_ABILITIES_TT = "开启此功能,你可以看见oRA/CTRA支持的其他职业技能的CD.";
FW.L.SHOW_READY = "显示可用技能";
FW.L.SHOW_READY_TT = "此功能不仅显示CD中的技能,而且显示CD完成后的技能."; 
FW.L.SHOW_SOULSTONE_MESSAGES = "显示灵魂石信息";
FW.L.SHOW_SOULSTONE_MESSAGES_TT = "显示过期或者相似的灵魂石信息.";
FW.L.SOULSTONE_MESSAGES_COLOR = "灵魂石信息";
FW.L.SS_FULL = "灵魂石开始";
FW.L.SS_EMPTY = "灵魂石失效";
FW.L.RESURRECT = "复活";
FW.L.DEAD_OFFLINE_MIXING = "死亡/下线";
FW.L.WARLOCK = "术士";
FW.L.DRUID = "德鲁伊";
FW.L.PALADIN = "圣骑士";
FW.L.SHAMAN = "萨满祭司";	
FW.L.DEAD_OFFLINE_MIXING_TT = "职业颜色和死亡/掉线颜色按此比例混合. 1.0表示完全为职业颜色. 0.0 表示完全为死亡/掉线颜色.";

FW.L.SS_ENABLE_TT = "开始灵魂石助手.";

FW.L.DI_GAIN = "%s 获得了神圣干涉.";
FW.L.DI_FADE = "神圣干涉从 %s 身上消失了.";
FW.L.SS_EXPIRE = "%s 的灵魂石过期了.";
FW.L.SS_EXPIRE_YOUR = "你给 %s 的灵魂石过期了.";
FW.L.SS_EXPIRE_OTHER = "%s 给 %s 的灵魂石过期了.";
FW.L.SS_DIED = "%s 带着灵魂石挂了.";
FW.L.SS_DIED_YOUR = "%s 带着你的灵魂石挂了.";
FW.L.SS_DIED_OTHER = "%s 带着 %s 的灵魂石挂了.";

FW.L.SHORT_READY = "准备";
FW.L.READY_TO_RES = "可以释放";
FW.L.NO_SS_UP = "没有灵魂石";

FW.L.FLAG_SOULSTONE = "<灵魂石>";
FW.L.FLAG_REBIRTH = "<复生>";
FW.L.FLAG_DIVINE_INTERVENTION = "<神圣干涉>";
FW.L.FLAG_ANKH = "<十字章>";

FW.L.DELAY_MAX_SS_BUFF = "灵魂石buff最大延迟";

-- tradition chinese
elseif GetLocale() == "zhTW" then
	FW.L.CREATE_SOULSTONE = "製造靈魂石";
	FW.L.BUFF_SOULSTONE = "靈魂石復活";
	FW.L.BUFF_SPIRIT_OF_REDEMPTION = "救贖之魂";
	FW.L.BUFF_DIVINE_INTERVENTION = "神聖干涉";

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SOULSTONE_TRACKER = "靈魂石助手";
FW.L.SHOW_ALL_ABILITIES = "顯示其他職業技能CD(oRA/CTRA)";
FW.L.SHOW_ALL_ABILITIES_TT = "開啟此功能,你可以看見oRA/CTRA支援的其他職業技能的CD.";
FW.L.SHOW_READY = "顯示可用技能";
FW.L.SHOW_READY_TT = "此功能不僅顯示CD中的技能,而且顯示CD完成後的技能."; 
FW.L.SHOW_SOULSTONE_MESSAGES = "顯示靈魂石資訊";
FW.L.SHOW_SOULSTONE_MESSAGES_TT = "顯示過期或者相似的靈魂石資訊.";
FW.L.SOULSTONE_MESSAGES_COLOR = "靈魂石資訊";
FW.L.SS_FULL = "靈魂石開始";
FW.L.SS_EMPTY = "靈魂石失效";
FW.L.RESURRECT = "復活";
FW.L.DEAD_OFFLINE_MIXING = "死亡/下線";
FW.L.WARLOCK = "術士";
FW.L.DRUID = "德魯伊";
FW.L.PALADIN = "聖騎士";
FW.L.SHAMAN = "薩滿祭司";	
FW.L.DEAD_OFFLINE_MIXING_TT = "職業顏色和死亡/掉線顏色按此比例混合. 1.0表示完全為職業顏色. 0.0 表示完全為死亡/掉線顏色.";

FW.L.SS_ENABLE_TT = "開始靈魂石助手.";

FW.L.DI_GAIN = "%s 獲得了神聖干涉.";
FW.L.DI_FADE = "神聖干涉從 %s 身上消失了.";
FW.L.SS_EXPIRE = "%s 的靈魂石過期了.";
FW.L.SS_EXPIRE_YOUR = "你給 %s 的靈魂石過期了.";
FW.L.SS_EXPIRE_OTHER = "%s 給 %s 的靈魂石過期了.";
FW.L.SS_DIED = "%s 帶著靈魂石掛了.";
FW.L.SS_DIED_YOUR = "%s 帶著你的靈魂石掛了.";
FW.L.SS_DIED_OTHER = "%s 帶著 %s 的靈魂石掛了.";

FW.L.SHORT_READY = "準備";
FW.L.READY_TO_RES = "可以釋放";
FW.L.NO_SS_UP = "沒有靈魂石";

FW.L.FLAG_SOULSTONE = "<靈魂石>";
FW.L.FLAG_REBIRTH = "<複生>";
FW.L.FLAG_DIVINE_INTERVENTION = "<神聖干涉>";
FW.L.FLAG_ANKH = "<十字章>";

FW.L.DELAY_MAX_SS_BUFF = "靈魂石buff最大延遲";


-- ENGLISH
else
	FW.L.CREATE_SOULSTONE = "Create Soulstone";
	FW.L.BUFF_SOULSTONE = "Soulstone Resurrection";
	FW.L.BUFF_SPIRIT_OF_REDEMPTION = "Spirit of Redemption";
	FW.L.BUFF_DIVINE_INTERVENTION = "Divine Intervention";

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SOULSTONE_TRACKER = "Soulstone Tracker";
FW.L.SHOW_ALL_ABILITIES = "Show all class abilities (oRA/CTRA)";
FW.L.SHOW_ALL_ABILITIES_TT = "When enabled, you will be able to see all class ability cooldowns supported by oRA/CTRA.";
FW.L.SHOW_READY = "Show ready abilities";
FW.L.SHOW_READY_TT = "This will set the tracker to not only show abilities on cooldown, but also any abilities that are ready."; 
FW.L.SHOW_SOULSTONE_MESSAGES = "Show soulstone messages";
FW.L.SHOW_SOULSTONE_MESSAGES_TT = "Shows messages for expired soulstones and similar.";
FW.L.SOULSTONE_MESSAGES_COLOR = "Soulstone messages";
FW.L.SS_FULL = "Soulstone full";
FW.L.SS_EMPTY = "Soulstone empty";
FW.L.RESURRECT = "Resurrect";
FW.L.DEAD_OFFLINE_MIXING = "Dead/offline mixing";
FW.L.WARLOCK = "Warlock";
FW.L.DRUID = "Druid";
FW.L.PALADIN = "Paladin";
FW.L.SHAMAN = "Shaman";	
FW.L.DEAD_OFFLINE_MIXING_TT = "The class color is mixed with the dead or offline color with this ratio. 1.0 means the color will be completely class color. 0.0 means the color will be the dead or offline color only.";

FW.L.SS_ENABLE_TT = "Enable the Soulstone Tracker.";

FW.L.DI_GAIN = "%s got Divine Intervention.";
FW.L.DI_FADE = "Divine Intervention faded from %s.";
FW.L.SS_EXPIRE = "Soulstone expired on %s.";
FW.L.SS_EXPIRE_YOUR = "Your Soulstone expired on %s.";
FW.L.SS_EXPIRE_OTHER = "%s's Soulstone expired on %s.";
FW.L.SS_DIED = "%s died with a Soulstone on.";
FW.L.SS_DIED_YOUR = "%s died with your Soulstone on.";
FW.L.SS_DIED_OTHER = "%s died with %s's Soulstone on.";

FW.L.SHORT_READY = "rdy";
FW.L.READY_TO_RES = "ready to res";
FW.L.NO_SS_UP = "no ss up";

FW.L.FLAG_SOULSTONE = "<Soulstone>";
FW.L.FLAG_REBIRTH = "<Rebirth>";
FW.L.FLAG_DIVINE_INTERVENTION = "<Divine Int>";
FW.L.FLAG_ANKH = "<Ankh>";

FW.L.DELAY_MAX_SS_BUFF = "Delay max soulstone buff";

end


