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
	--zones
	FW.L.COILFANG_RESERVOIR = "Caverne du sanctuaire du Serpent";
-- DE 
elseif GetLocale() == "deDE" then
	--zones
	FW.L.COILFANG_RESERVOIR = "H鰄le des Schlangenschreins";
-- SPANISH
elseif GetLocale() == "esES" then
	--zones
	FW.L.COILFANG_RESERVOIR = "Caverna Santuario Serpiente";
-- simple chinese
elseif GetLocale() == "zhCN" then
	--zones
	FW.L.COILFANG_RESERVOIR = "毒蛇神殿";
-- tradition chinese
elseif GetLocale() == "zhTW" then
		--zones
	FW.L.COILFANG_RESERVOIR = "毒蛇神殿洞穴";
-- ENGLISH
else
	--zones
	FW.L.COILFANG_RESERVOIR = "Serpentshrine Cavern";
end

-- simple chinese
if GetLocale() == "zhCN" then

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.CAST_RITUAL_OF_SUMMONING = "施法召唤仪式";
FW.L.CAST_RITUAL_OF_SUMMONING_TT = "就是召唤仪式而已....";

FW.L.SUMMON_ASSISTANT = "召唤助手";
FW.L.SU_HINT1 = "召唤助手仅raid且非战斗时可见.";
FW.L.SU_HINT2 = "左键单击名字选中/召唤. 右键单击移除10秒.";

FW.L.SHOW_CLOSE = "显示30码外所有人";
FW.L.SHOW_CLOSE_TT = "开启此选项,将显示30码外所有队友,否则它将显示半个地图外或可视距离外的队友.";
FW.L.QUEUE_SUMMON = "请求召唤关键词";
FW.L.QUEUE_SUMMON_TT = "队友请求召唤时M你的关键词. 关闭选项将禁用密语.";
FW.L.SHOW_MEETING_STONE = "显示集合石召唤";
FW.L.SHOW_MEETING_STONE_TT = "此选项将监视团队队友的集合石召唤. 你不在集合石附近可以将其关闭.";
FW.L.OLD_SUMMONING_MODE = "旧排队模式";
FW.L.OLD_SUMMONING_MODE_TT = "With this setting enabled, it will queue people as before, when you couldn't summon people from outside into your instance. So only people that are in your instance, and far away. And people not inside an instance when you yourself are not, and far away.";

FW.L.PLAYER_FAR = "队友远";
FW.L.PLAYER_CLOSE = "队友近";
FW.L.BEING_SUMMONED = "正在被召唤";
FW.L.WHISPERED = "M语请求的";

FW.L.SU_ENABLE_TT = "启用召唤助手.";

FW.L.SUMMON_REQUEST_BLOCK = "^<< 请求召唤 ";
FW.L.SUMMON_REQUEST = "<< 接受请求 >>";
FW.L.SUMMON_REQUEST_FOR = "<< %s 请求召唤>>";
FW.L.SUMMON_REQUEST_BY = "<< 要求 %s 召唤>>";

FW.L.FAR_ = "远距离 ";
FW.L._ALL = " 全部";

FW.L.UPDATE_INTERVAL_SUMMON = "召唤助手更新间隔";

-- tradition chinese
elseif GetLocale() == "zhTW" then

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.CAST_RITUAL_OF_SUMMONING = "施法召喚儀式";
FW.L.CAST_RITUAL_OF_SUMMONING_TT = "就是召喚儀式而已....";

FW.L.SUMMON_ASSISTANT = "召喚助手";
FW.L.SU_HINT1 = "召喚助手僅raid且非戰鬥時可見.";
FW.L.SU_HINT2 = "左鍵單擊名字選中/召喚. 右鍵單擊移除10秒.";

FW.L.SHOW_CLOSE = "顯示30碼外所有人";
FW.L.SHOW_CLOSE_TT = "開啟此選項,將顯示30碼外所有隊友,否則它將顯示半個地圖外或可視距離外的隊友.";
FW.L.QUEUE_SUMMON = "請求召喚關鍵字";
FW.L.QUEUE_SUMMON_TT = "隊友請求召喚時M你的關鍵字. 關閉選項將禁用密語.";
FW.L.SHOW_MEETING_STONE = "顯示集合石召喚";
FW.L.SHOW_MEETING_STONE_TT = "此選項將監視團隊隊友的集合石召喚. 你不在集合石附近可以將其關閉.";
FW.L.OLD_SUMMONING_MODE = "舊列隊模式";
FW.L.OLD_SUMMONING_MODE_TT = "With this setting enabled, it will queue people as before, when you couldn't summon people from outside into your instance. So only people that are in your instance, and far away. And people not inside an instance when you yourself are not, and far away.";

FW.L.PLAYER_FAR = "隊友遠";
FW.L.PLAYER_CLOSE = "隊友近";
FW.L.BEING_SUMMONED = "正在被召喚";
FW.L.WHISPERED = "M語請求的";

FW.L.SU_ENABLE_TT = "啟用召喚助手.";

FW.L.SUMMON_REQUEST_BLOCK = "^<< 請求召喚 ";
FW.L.SUMMON_REQUEST = "<< 接受請求 >>";
FW.L.SUMMON_REQUEST_FOR = "<< %s 請求召喚>>";
FW.L.SUMMON_REQUEST_BY = "<< 要求 %s 召喚>>";

FW.L.FAR_ = "遠距離 ";
FW.L._ALL = " 全部";

FW.L.UPDATE_INTERVAL_SUMMON = "召喚助手更新間隔";


else
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.CAST_RITUAL_OF_SUMMONING = "Cast Ritual of Summoning";
FW.L.CAST_RITUAL_OF_SUMMONING_TT = "Cast Ritual of Summoning like you would normally do.";

FW.L.SUMMON_ASSISTANT = "Summon Assistant";
FW.L.SU_HINT1 = "The Summon Assistant is only visible outside of combat and in a party or raid.";
FW.L.SU_HINT2 = "Left-click a name to select/summon. Right-click to remove for 10 seconds.";

FW.L.SHOW_CLOSE = "Show all outside 30 yards";
FW.L.SHOW_CLOSE_TT = "When this is checked, the summon assistant will queue everybody outside ~30 yards range. Otherwise it will queue people that are either out of visual range in an instance, or are about half a zone away outside.";
FW.L.QUEUE_SUMMON = "Queue summon keyword";
FW.L.QUEUE_SUMMON_TT = "The keyword players can whisper to you to request a summon. Uncheck to disable using whispers.";
FW.L.SHOW_MEETING_STONE = "Show Meeting Stone summons";
FW.L.SHOW_MEETING_STONE_TT = "This will also track meeting stone summons from raid members. Probably best kept off if you're not around a meeting stone.";
FW.L.OLD_SUMMONING_MODE = "Old Queue Mode";
FW.L.OLD_SUMMONING_MODE_TT = "With this setting enabled, it will queue people as before, when you couldn't summon people from outside into your instance. So only people that are in your instance, and far away. And people not inside an instance when you yourself are not, and far away.";

FW.L.PLAYER_FAR = "Player far";
FW.L.PLAYER_CLOSE = "Player close";
FW.L.BEING_SUMMONED = "Being summoned";
FW.L.WHISPERED = "Whispered";

FW.L.SU_ENABLE_TT = "Enable the Summon Assistant.";

FW.L.SUMMON_REQUEST_BLOCK = "^<< Summon Requested ";
FW.L.SUMMON_REQUEST = "<< Summon Requested >>";
FW.L.SUMMON_REQUEST_FOR = "<< Summon Requested for %s >>";
FW.L.SUMMON_REQUEST_BY = "<< Summon Requested by %s >>";

FW.L.FAR_ = "far ";
FW.L._ALL = " all";

FW.L.UPDATE_INTERVAL_SUMMON = "Update interval summon assistant";
end