--[[
HoloFriends addon created by Holo, continued by Zappster

Get the latest version at www.curse-gaming.com

See HoloFriends_friends.lua for more informations  
]]

--[[

This file defines the localisation data

]]

-- english localisation
HOLOFRIENDS_LOADED = "Holo\'s Friends AddOn v%.2f loaded";
HOLOFRIENDS_UNKNOWN = "?";
HOLOFRIENDS_INVALIDLISTVERSION = "Your HoloFriends data was written by a newer version of HoloFriends (%s) - to prevent any corruption of your data, nothing will be saved or loaded";

HOLOFRIENDS_DELETECHARDLG = "Do you really want to delete all data of |cffffd200%s|r?";
HOLOFRIENDS_DELETECHARNOTFOUND = "%s not found, please check the correct spelling";
HOLOFRIENDS_DELETECHARDONE = "deleted %s's data";

HOLOFRIENDS_ADDCOMMENT = "Add Comment";
HOLOFRIENDS_ADDCOMMENT_LONG = "Comment for %s";
HOLOFRIENDS_ADDGROUP = "Add Group";
HOLOFRIENDS_REMOVEGROUP = "Remove Group";
HOLOFRIENDS_RENAMEGROUP = "Rename Group";
HOLOFRIENDS_SCAN = "/who scan";
HOLOFRIENDS_SCANSTOP = "stop scan";
HOLOFRIENDS_SCAN_STARTMSG = "%d friends will be scanned. This will take about %f seconds to complete.  /who requests will not work during this time.";
HOLOFRIENDS_SCAN_STOPMSG = "Scan stopped";
HOLOFRIENDS_SCAN_DONEMSG = "Done scanning extra friends.";

HOLOFRIENDS_SHOWOFFLINE = "Show Offline Friends";
HOLOFRIENDS_ONLINE = "Friends Online:";
HOLOFRIENDS_ONLINE_STATUS_ENABLED = "Online state monitoring of %s enabled.";
HOLOFRIENDS_ONLINE_STATUS_DISABLED = "Online state monitoring of %s disabled.";
HOLOFRIENDS_LIMITALERT = "You can only monitor 50 friends!";
HOLOFRIENDS_WHOREQUEST = "Who Request";

HOLOFRIENDS_NEVERSEEN = "Never seen";
HOLOFRIENDS_LASTSEEN = "Last seen";
HOLOFRIENDS_DATEFORMAT = "%m.%d.%Y %H:%M";
HOLOFRIENDS_WHORESULTFORMAT = "|Hplayer:[^|]+|h%[[^%]]+%]|h: Level";
HOLOFRIENDS_WHOTOTALFORMAT = "(%d+) players? total";

HOLOFRIENDS_SHARETITLE = "Share friends";
HOLOFRIENDS_SHARESOURCE = "Select friends:"
HOLOFRIENDS_SHARETARGET = "Share with:"
HOLOFRIENDS_SHARENOTICE = "NOTICE: use |cffffd200/holofriends delete name|r to\ndelete data from non-existing characters";
HOLOFRIENDS_SHAREBTNTOOLTIP = "Share your friendlist across other chars";

HOLOFRIENDS_CLASS_ICON_TCOORDS = {
	["WARRIOR"]	= {0, 0.25, 0, 0.25},
	["MAGE"]	= {0.25, 0.49609375, 0, 0.25},
	["ROGUE"]	= {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"]	= {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"]	= {0, 0.25, 0.25, 0.5},
	["SHAMAN"]	= {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"]	= {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"]	= {0, 0.25, 0.5, 0.75}
};

-- german localisation
if( GetLocale() == "deDE" ) then
HOLOFRIENDS_LOADED = "HoloFriends v%.2f wurde geladen";
HOLOFRIENDS_UNKNOWN = "?";
HOLOFRIENDS_INVALIDLISTVERSION = "Die HoloFriends Daten wurden mit einer neueren Version von HoloFriends (%s) erzeugt - um die Daten nicht zu besch\195\164digen, werden keine Informationen geladen oder gespeichert";

HOLOFRIENDS_DELETECHARDLG = "Willst Du wirklich alle Daten von |cffffd200%s|r l\195\182schen?";
HOLOFRIENDS_DELETECHARNOTFOUND = "%s wurde nicht gefunden, bitte \195\188berpr\195\188fe die genaue Schreibweise";
HOLOFRIENDS_DELETECHARDONE = "Alle Daten von %s wurden gel\195\182scht";

HOLOFRIENDS_ADDCOMMENT = "Kommentar hinzu";
HOLOFRIENDS_ADDCOMMENT_LONG = "Kommentar f\195\188r %s";
HOLOFRIENDS_ADDGROUP = "Gruppe hinzu";
HOLOFRIENDS_REMOVEGROUP = "Gruppe entfernen";
HOLOFRIENDS_RENAMEGROUP = "Gruppe Umbenennen";
HOLOFRIENDS_SCAN = "/who Scan";
HOLOFRIENDS_SCANSTOP = "Scan stoppen";
HOLOFRIENDS_SCAN_STARTMSG = "%d Eintr\195\164ge werden \195\188berpr\195\188ft. Der Vorgang dauert ca. %f Sekunden. /who wird w\195\164hrend dieser Zeit nicht funktionieren.";
HOLOFRIENDS_SCAN_STOPMSG = "Scan abgebrochen";
HOLOFRIENDS_SCAN_DONEMSG = "Scan beendet.";

HOLOFRIENDS_SHOWOFFLINE = "Offline-Freunde anzeigen";
HOLOFRIENDS_ONLINE = "Freunde Online:";
HOLOFRIENDS_ONLINE_STATUS_ENABLED = "Online Status \195\156berwachung von %s aktiviert.";
HOLOFRIENDS_ONLINE_STATUS_DISABLED = "Online Status \195\156berwachung von %s deaktiviert.";
HOLOFRIENDS_LIMITALERT = "Sie k\195\182nnen nur 50 Spieler \195\156berwachen!";
HOLOFRIENDS_WHOREQUEST = "Who Abfrage";

HOLOFRIENDS_NEVERSEEN = "bisher nicht gesehen";
HOLOFRIENDS_LASTSEEN = "Zuletzt gesehen";
HOLOFRIENDS_DATEFORMAT = "%d.%m.%Y %H:%M";
HOLOFRIENDS_WHORESULTFORMAT = "|Hplayer:[^|]+|h%[[^%]]+%]|h: Stufe";
HOLOFRIENDS_WHOTOTALFORMAT = "(%d+) Spieler gesamt";

HOLOFRIENDS_SHARETITLE = "Freunde \195\188bertragen";
HOLOFRIENDS_SHARESOURCE = "Freunde ausw\195\164hlen:"
HOLOFRIENDS_SHARETARGET = "\195\156bertrage an:"
HOLOFRIENDS_SHARENOTICE = "HINWEIS:\num Daten von bereits gel\195\182schten\nCharakteren zu entfernen, gib\n|cffffd200/holofriends delete name|r ein";
HOLOFRIENDS_SHAREBTNTOOLTIP = "\195\156bertrage Deine Freundesliste auf andere Charaktere";

HOLOFRIENDS_CLASS_ICON_TCOORDS = {
	["KRIEGER"]	= {0, 0.25, 0, 0.25},
	["MAGIER"]	= {0.25, 0.49609375, 0, 0.25},
	["SCHURKE"]	= {0.49609375, 0.7421875, 0, 0.25},
	["DRUIDE"]	= {0.7421875, 0.98828125, 0, 0.25},
	["J\195\132GER"]= {0, 0.25, 0.25, 0.5},
	["SCHAMANE"]	= {0.25, 0.49609375, 0.25, 0.5},
	["PRIESTER"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["HEXENMEISTER"]= {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"]	= {0, 0.25, 0.5, 0.75}
};
end

-- french localisation by Feu
if( GetLocale() == "frFR" ) then
HOLOFRIENDS_LOADED = "Holo\'s Friends AddOn v%.2f charg\195\169";
HOLOFRIENDS_UNKNOWN = "?";
HOLOFRIENDS_INVALIDLISTVERSION = "Your HoloFriends data was written by a newer version of HoloFriends (%s) - to prevent any corruption of your data, nothing will be saved or loaded";

HOLOFRIENDS_DELETECHARDLG = "Do you really want to delete all data of |cffffd200%s|r?";
HOLOFRIENDS_DELETECHARNOTFOUND = "%s not found, please check the correct spelling";
HOLOFRIENDS_DELETECHARDONE = "deleted %s's data";

HOLOFRIENDS_ADDCOMMENT = "Ajouter note";
HOLOFRIENDS_ADDCOMMENT_LONG = "Note pour %s";
HOLOFRIENDS_ADDGROUP = "Ajouter groupe";
HOLOFRIENDS_REMOVEGROUP = "Supprimer groupe";
HOLOFRIENDS_RENAMEGROUP = "Rename Group";
HOLOFRIENDS_SCAN = "/who scan";
HOLOFRIENDS_SCANSTOP = "stop scan";
HOLOFRIENDS_SCAN_STARTMSG = "%d friends will be scanned. This will take about %f seconds to complete.  /who requests will not work during this time.";
HOLOFRIENDS_SCAN_STOPMSG = "Scan stopped";
HOLOFRIENDS_SCAN_DONEMSG = "Done scanning extra friends.";

HOLOFRIENDS_SHOWOFFLINE = "Afficher les amis hors ligne";
HOLOFRIENDS_ONLINE = "Friends Online:";
HOLOFRIENDS_ONLINE_STATUS_ENABLED = "Online state monitoring of %s enabled.";
HOLOFRIENDS_ONLINE_STATUS_DISABLED = "Online state monitoring of %s disabled.";
HOLOFRIENDS_LIMITALERT = "You can only monitor 50 friends!";
HOLOFRIENDS_WHOREQUEST = "Who Request";

HOLOFRIENDS_NEVERSEEN = "Never seen";
HOLOFRIENDS_LASTSEEN = "Last seen";
HOLOFRIENDS_DATEFORMAT = "%d.%m.%Y %H:%M";
HOLOFRIENDS_WHORESULTFORMAT = "|Hplayer:[^|]+|h%[[^%]]+%]|h: Niveau";
HOLOFRIENDS_WHOTOTALFORMAT = "(%d+) joueurs? au total";

HOLOFRIENDS_SHARETITLE = "Share friends";
HOLOFRIENDS_SHARESOURCE = "Select friends:"
HOLOFRIENDS_SHARETARGET = "Share with:"
HOLOFRIENDS_SHARENOTICE = "NOTICE: use |cffffd200/holofriends delete name|r to\ndelete data from non-existing characters";
HOLOFRIENDS_SHAREBTNTOOLTIP = "Share your friendlist across other chars";

HOLOFRIENDS_CLASS_ICON_TCOORDS = {
  ["GUERRIER"] = {0, 0.25, 0, 0.25},
  ["MAGE"] = {0.25, 0.49609375, 0, 0.25},
  ["VOLEUR"] = {0.49609375, 0.7421875, 0, 0.25},
  ["DRUIDE"] = {0.7421875, 0.98828125, 0, 0.25},
  ["CHASSEUR"] = {0, 0.25, 0.25, 0.5},
  ["CHAMAN"] = {0.25, 0.49609375, 0.25, 0.5},
  ["PR\195\138TRE"] = {0.49609375, 0.7421875, 0.25, 0.5},
  ["D\195\137MONISTE"] = {0.7421875, 0.98828125, 0.25, 0.5},
  ["PALADIN"] = {0, 0.25, 0.5, 0.75}
};
end

--简体中文版翻译: 冷血凝月
if( GetLocale() == "zhCN" ) then
HOLOFRIENDS_LOADED = "Holo的好友插件 v%.2f 已载入! 简体中文版翻译: 冷血凝月";
HOLOFRIENDS_UNKNOWN = "?";

HOLOFRIENDS_INVALIDLISTVERSION = "您的HoloFriends插件数据会被新版本的HoloFriends(%s) - 为了防止您的数据被破坏，不会进行任何储存或者载入操作!";
HOLOFRIENDS_DELETECHARDLG = "您确定要删除所有的|cffffd200%s|r的资料吗?";
HOLOFRIENDS_DELETECHARNOTFOUND = "%s 未找到，请确认玩家名称的拼写";
HOLOFRIENDS_DELETECHARDONE = "%s的资料被删除了";

HOLOFRIENDS_ADDCOMMENT = "加入注记";
HOLOFRIENDS_ADDCOMMENT_LONG = "加入注记: %s";
HOLOFRIENDS_ADDGROUP = "新增群组";
HOLOFRIENDS_REMOVEGROUP = "删除群组";
HOLOFRIENDS_RENAMEGROUP = "重新命名群组";

HOLOFRIENDS_SCAN = "查找玩家";
HOLOFRIENDS_SCANSTOP = "停止查询";
HOLOFRIENDS_SCAN_STARTMSG = "将要查询%d个好友，这大约会在%f秒后完成。在查询的期间内 /who 的指令将不会有任何的作用。";
HOLOFRIENDS_SCAN_STOPMSG = "停止扫描";
HOLOFRIENDS_SCAN_DONEMSG = "扫描其他好友完成";

HOLOFRIENDS_SHOWOFFLINE = "显示离线好友";
HOLOFRIENDS_ONLINE = "好友在线人数:";
HOLOFRIENDS_ONLINE_STATUS_ENABLED = "开启对 %s 的在线监控";
HOLOFRIENDS_ONLINE_STATUS_DISABLED = "关闭对 %s 的在线监控";
HOLOFRIENDS_LIMITALERT = "您只能同时对50个好友在线监控!";
HOLOFRIENDS_WHOREQUEST = "显示玩家信息";

HOLOFRIENDS_NEVERSEEN = "|r|CFF99FFCC最后在线:|r |r|cFF00FF00未知|r";
HOLOFRIENDS_LASTSEEN = "|r|CFF99FFCC最后在线|r";
HOLOFRIENDS_DATEFORMAT = "%Y/%m/%d %H:%M";
HOLOFRIENDS_WHORESULTFORMAT = "|Hplayer:[^|]+|h%[[^%]]+%]|h: Level";
HOLOFRIENDS_WHOTOTALFORMAT = "(%d+) 位玩家? 总共";

HOLOFRIENDS_SHARETITLE = "复制好友列表";
HOLOFRIENDS_SHARESOURCE = "选择好友:"
HOLOFRIENDS_SHARETARGET = "选择要复制好友的角色:"
HOLOFRIENDS_SHARENOTICE = "|r|CFF990000注意:|r用 |cffffd200/holofriends delete name|r 来清除不存在\n的人物";
HOLOFRIENDS_SHAREBTNTOOLTIP = "为您的其他角色共享目前的好友列表";

HOLOFRIENDS_CLASS_ICON_TCOORDS = {
	["战士"]	= {0, 0.25, 0, 0.25},
	["法师"]	= {0.25, 0.49609375, 0, 0.25},
	["潜行者"]	= {0.49609375, 0.7421875, 0, 0.25},
	["德鲁伊"]	= {0.7421875, 0.98828125, 0, 0.25},
	["猎人"]	= {0, 0.25, 0.25, 0.5},
	["萨满祭司"]	= {0.25, 0.49609375, 0.25, 0.5},
	["牧师"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["术士"]	= {0.7421875, 0.98828125, 0.25, 0.5},
	["圣骑士"]	= {0, 0.25, 0.5, 0.75}
};
HOLOFRIENDS_CLASS_COLOR_KEY = {
	["战士"]	= "WARRIOR",
	["法师"]	= "MAGE",
	["潜行者"]	= "ROGUE",
	["德鲁伊"]	= "DRUID",
	["猎人"]	= "HUNTER",
	["萨满祭司"]	= "SHAMAN",
	["牧师"]	= "PRIEST",
	["术士"]	= "WARLOCK",
	["圣骑士"]	= "PALADIN"
}
HOLOFRIENDS_LIST_TEMPLATE = "%1$s|CFF99FFCC(|r%2$s|CFF99FFCC)|r - |cffffffff%3$s|r";
HOLOFRIENDS_LIST_OFFLINE_TEMPLATE = "|cff999999%1$s(%2$s) - %3$s|r";
HOLOFRIENDS_LEVEL_TEMPLATE = "|CFF99FFCC等级|r %s %2$s";
HOLOFRIENDS_LEVEL_TEMPLATE_OFFLINE = "|CFF999999等级 %s %2$s";
end

-- 繁體中文化: Duke
if( GetLocale() == "zhTW" ) then
HOLOFRIENDS_LOADED = "Holo\'s Friends AddOn v%.2f 已載入! 繁體中文化:Duke";
HOLOFRIENDS_UNKNOWN = "?";
HOLOFRIENDS_INVALIDLISTVERSION = "您的 |r|CFF99FFCC[其他]|r好友名單管理 是更新的版本所儲存的，為了防止您的數據錯誤，沒有任何操作會被儲存或是載入!";

HOLOFRIENDS_DELETECHARDLG = "您確定要刪除所有的|cffffd200%s|r的資料嗎?";
HOLOFRIENDS_DELETECHARNOTFOUND = "%s 未找到，請確認玩家名稱";
HOLOFRIENDS_DELETECHARDONE = "刪除%s的資料";

HOLOFRIENDS_ADDCOMMENT = "加入注記";
HOLOFRIENDS_ADDCOMMENT_LONG = "加入注記: %s";
HOLOFRIENDS_ADDGROUP = "新增群組";
HOLOFRIENDS_REMOVEGROUP = "刪除群組";
HOLOFRIENDS_RENAMEGROUP = "重新命名群組";

HOLOFRIENDS_SHOWOFFLINE = "顯示離線好友";
HOLOFRIENDS_ONLINE = "線上好友人數:";
HOLOFRIENDS_ONLINE_STATUS_ENABLED = "開啟對 %s 的線上監控";
HOLOFRIENDS_ONLINE_STATUS_DISABLED = "關閉對 %s 的線上監控";
HOLOFRIENDS_LIMITALERT = "您只能同時對50個好友線上監控!";
HOLOFRIENDS_WHOREQUEST = "顯示玩家資訊";

HOLOFRIENDS_SHARETITLE = "|r|CFF99FFCC[其他]|r好友名單管理";
HOLOFRIENDS_SHARESOURCE = "選擇好友:"
HOLOFRIENDS_SHARETARGET = "選擇要複製好友的角色:"
HOLOFRIENDS_SHARENOTICE = "|r|CFF990000注意:|r用 |cffffd200/holofriends delete name|r 來清除不存在\n的人物";
HOLOFRIENDS_SHAREBTNTOOLTIP = "為您的其他角色共享目前的好友列表";

HOLOFRIENDS_SCAN = "區域查詢";
HOLOFRIENDS_SCANSTOP = "停止查詢";
HOLOFRIENDS_SCAN_STARTMSG = "查詢了%d個好友，這大約會在%f秒後完成。在查詢的期間內 /who 的指令將不會有任何的作用。";
HOLOFRIENDS_SCAN_STOPMSG = "停止掃描";
HOLOFRIENDS_SCAN_DONEMSG = "掃描其他好友完成";

HOLOFRIENDS_NEVERSEEN = "|r|CFF99FFCC最後在線時間:|r |r|cFF00FF00未知|r";
HOLOFRIENDS_LASTSEEN = "|r|CFF99FFCC最後在線時間|r";
HOLOFRIENDS_DATEFORMAT = "%m.%d.%Y %H:%M";
HOLOFRIENDS_WHORESULTFORMAT = "|Hplayer:[^|]+|h%[[^%]]+%]|h: Level";
HOLOFRIENDS_WHOTOTALFORMAT = "(%d+) players? total";

HOLOFRIENDS_CLASS_ICON_TCOORDS = {
	["戰士"]	= {0, 0.25, 0, 0.25},
	["法師"]	= {0.25, 0.49609375, 0, 0.25},
	["盜賊"]	= {0.49609375, 0.7421875, 0, 0.25},
	["德魯伊"]	= {0.7421875, 0.98828125, 0, 0.25},
	["獵人"]	= {0, 0.25, 0.25, 0.5},
	["薩滿"]	= {0.25, 0.49609375, 0.25, 0.5},
	["牧師"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["術士"]	= {0.7421875, 0.98828125, 0.25, 0.5},
	["聖騎士"]	= {0, 0.25, 0.5, 0.75}
};
end