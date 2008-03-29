local L = AceLibrary("AceLocale-2.2"):new("FuBar_GuildFu")

L:RegisterTranslations("zhCN", function() return {
	["Group"] = "队伍",
	["Name"] = "姓名",
	["Class"] = "职业",
	["Level"] = "等级",
	["Zone"] = "地区",
	["Notes"] = "注释",
	["Rank"] = "级别",
	["Show"] = "显示",
	["Align"] = "对齐",
	["Color"] = "颜色",
	["None"] = "无",
	["Left"] = "左",
	["Center"] = "中",
	["Right"] = "右",
	["No Guild"] = "无公会",
	["Updating..."] = "更新中...",
	["You aren't in a guild."] = "你不在一个公会里。",
	["All guild mates offline or filtered."] = "所有离线或过滤的公会成员。",
	["Text"] = "文本",
	["Text Settings"] = "文本设置",
	["Show Guild Name"] = "显示公会名称",
	["Toggles display of the guild name"] = "开关是否显示公会名称",
	["Show Displayed"] = "显示未过滤",
	["Toggles display of number of unfiltered guildmates"] = "开关是否显示没过滤公会成员的数量",
	["Show Online"] = "显示在线",
	["Toggles display of number of online guildmates"] = "开关是否显示在线公会成员的数量",
	["Show Total"] = "显示所有",
	["Toggles display of number of total guildmates"] = "开关是否显示所有公会成员的数量",
	["Tooltip"] = "提示",
	["Tooltip Settings"] = "提示设置",
	["MOTD"] = "今日信息",
	["MOTD Settings"] = "今日信息设置",
	["Toggles display of guild MOTD"] = "开关是否显示公会MOTD",
	["Sort"] = "排序",
	["Sets sorting"] = "设置排序",
	["Group Indicator Settings"] = "队伍指示设置",
	["Toggles display of group indicators"] = "开关是否显示队伍指示",
	["Name Column Settings"] = "好名栏设置",
	["Sets color of name column"] = "设置姓名栏颜色",
	["Status"] = "状态",
	["Toggles display of status"] = "开关状态显示",
	["Class Column Settings"] = "职业栏设置",
	["Toggles display of class column"] = "开关是否显示职业栏",
	["Sets alignment of class column"] = "设置职业栏对齐方式",
	["Level Column Settings"] = "等级栏设置",
	["Toggles display of level column"] = "开关是否显示等级栏",
	["Sets alignment of level column"] = "设置等级栏对齐方式",
	["Sets color of level column"] = "设置等级栏颜色",
	["Relative"] = "关系",
	["Zone Column Settings"] = "地区栏设置",
	["Toggles display of zone column"] = "开关是否显示地区栏",
	["Sets alignment of zone column"] = "设置地区栏对齐方式",
	["Sets color of zone column"] = "设置地区栏颜色",
	["Faction"] = "注释",
	["Notes Column Settings"] = "注释栏设置",
	["Show Public"] = "显示公共",
	["Toggles diplay of public notes"] = "开关是否显示公共注释",
	["Show Officer"] = "显示官员",
	["Toggles display of officer notes"] = "开关是否显示官员注释",
	["Show AuldLangSyne"] = "显示AuldLangSyne",
	["Toggles display of AuldLangSyne notes"] = "开关显示ALS注释",
	["Show CT_PlayerNotes"] = "显示CT_PlayerNotes",
	["Toggles display of CT_PlayerNotes notes"] = "开关显示CT_PlayerNotes注释",
	["Sets alignment of notes column"] = "设置注释栏对齐方式",
	["Rank Column Settings"] = "级别栏设置",
	["Toggles display of rank column"] = "开关级别栏显示",
	["Sets alignment of rank column"] = "设置级别栏对齐方式",
	["Filter"] = "过滤",
	["Filter Settings"] = "过滤设置",
	["Class Filter Settings"] = "职业过滤设置",
	["Druid"] = "德鲁伊",
	["Toggles display of Druids"] = "开关是否显示德鲁伊",
	["Hunter"] = "猎人",
	["Toggles display of Hunters"] = "开关是否显示猎人",
	["Mage"] = "法师",
	["Toggles display of Mages"] = "开关是否显示法师",
	["Paladin"] = "圣骑士",
	["Toggles display of Paladins"] = "开关是否显示圣骑士",
	["Priest"] = "牧师",
	["Toggles display of Priests"] = "开关是否显示牧师",
	["Rogue"] = "盗贼",
	["Toggles display of Rogues"] = "开关是否显示盗贼",
	["Shaman"] = "萨满祭司",
	["Toggles display of Shamans"] = "开关是否显示萨满祭司",
	["Warlock"] = "术士",
	["Toggles display of Warlocks"] = "开关是否显示术士",
	["Warrior"] = "战士",
	["Toggles display of Warriors"] = "开关是否显示战士",
	["Level Filter Settings"] = "等级过滤设置",
	[" 1- 9"] = " 1- 9",
	["Toggles display of level 1 to 9 chars"] = "开关是否显示1－9级的角色",
	["10-19"] = "10-19",
	["Toggles display of level 10 to 19 chars"] = "开关是否显示10－19级的角色",
	["20-29"] = "20-29",
	["Toggles display of level 20 to 29 chars"] = "开关是否显示20－29级的角色",
	["30-39"] = "30-39",
	["Toggles display of level 30 to 39 chars"] = "开关是否显示30－39级的角色",
	["40-49"] = "40-49",
	["Toggles display of level 40 to 49 chars"] = "开关是否显示40－49级的角色",
	["50-59"] = "50-59",
	["Toggles display of level 50 to 59 chars"] = "开关是否显示50－59级的角色",
	["60-69"] = "60-69",
	["Toggles display of level 60 to 69 chars"] = "开关是否显示60－69级的角色",
	["70"] = "70",
	["Toggles display of level 70 chars"] = "开关是否显示70级的角色",
	["Zone Filter Settings"] = "地区过滤设置",
	["In Battleground"] = "在战场",
	["Toggles display of chars in battlegrounds"] = "开关是否显示在战场的角色",
	["In Instance"] = "在副本",
	["Toggles display of chars in instances"] = "开关是否显示在副本的角色",
	["In Open Field"] = "在野外",
	["Toggles display of chars in open field"] = "开关是否显示在野外的角色",
} end)
