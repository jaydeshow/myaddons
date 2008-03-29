local L = AceLibrary("AceLocale-2.2"):new("FuBar_WhisperFu")

L:RegisterTranslations("zhCN", function() return {
	["On"] = "开启",
	["Off"] = "关闭",
	["Spam Blocker:"] = "阻挡垃圾",
	["Blocked Messages:"] = "被阻信息：",

	["Whisper"] = "密语",

	["Options"] = "选项",
	["Colours"] = "颜色",
	["Set the Text Colours"] = "设置文本颜色",

	["Send Colour"] = "发送颜色",
	["Sets the color of text for whispers sent"] = "设置发送密语的颜色",

	["Receive Colour"] = "接收颜色",
	["Sets the color of text for whispers receieved"] = "设置接收密语的颜色",

	["HintText"] = "|cffeda55f单击|r这里发送一条密语。\n|cffeda55fAlt-左键|r邀请这个人加入你的队伍。\n|cffeda55fShift-左键|r查询这个人的信息。\n|cffeda55fCtrl-左键|r清除所有密语。",
	["PlayerDesc"] = "和%s交流的密语",
	["WhisperDesc"] = "发送密语给%s",

	["Purge"] = "清除密语",
	["PurgeDesc"] = "清除本插件保存的所有密语",

	["Player Limit"] = "玩家上限",
	["Maximum number of players to store messages for."] = "插件所保存密语的玩家人数上限。",

	["Message Limit"] = "信息上限",
	["Maximum number of messages to store per player."] = "插件为每个玩家保存密语的数量上限。",

	["Wrap Length"] = "换行长度",
	["Wrap messages longer than this number of characters."] = "当信息超过这个这个长度时自动换行。",

	["Show Times"] = "显示时间",
	["Show time of whispers in tooltip."] = "显示密语的时间。",

	["Show Menu Times"] = "显示时间于菜单",
	["Show time of whispers in menus."] = "在菜单中显示密语的时间。",

	["Play Whisper Sound"] = "密语声音",
	["Play a sound each time you receive a message."] = "每次接收到密语时声音提示。",

	["Show Hint"] = "显示窍门",
	["Show hint at the bottom of the tooltip."] = "在提示的底部显示窍门。",

	--["Spam"] = true,
	--["Spam Settings"] = true,

	["Spam"] = "垃圾信息",
	["View blocked spam messages."] = "察看被阻挡的垃圾信息。",

	["Spam Options"] = "垃圾选项",
	["Spam blocking options."] = "垃圾信息的阻挡选项。",

	["-Report this user-"] = "> 上报这个玩家 <",
	["Report this user as a spammer and attempt to get justice for their griefing!"] = "将这个玩家作为垃圾信息发送者上报，让他得到应有的惩戒！",
	["Are you sure you want to report %s?"] = "你确定要上报 %s 么？",

	[" was not found."] = "没有找到。",
	["I am reporting the user %s for attempting to sell me gold or leveling service for real money.  The following are messages captured, quoting the user's violation of WoW TOS:\n\n"] = "我要举报玩家> %s <，因为他叫卖金币或代练，下面是他违反魔兽世界 TOS 的相关信息：\n\n",
	["You already have a GM ticket open."] = "你已经有一个 GM 请求了。",

	["Block Spam"] = "阻挡垃圾",
	["Block incoming spam messages."] = "阻挡发送过来的垃圾信息。",

	["Play Spam Sound"] = "垃圾提示",
	["Play a sound each time WhisperFu catches a spam message."] = "每次插件捕捉到垃圾信息时都用声音提示。",

	["Show Spams This Session"] = "显示垃圾",
	["Shows a counter in the addon title for spams blocked this session."] = "在插件标题上显示本次被阻挡的垃圾信息条数。",

	["Reset Spam Tally"] = "重置垃圾",
	["Resets intercepted spam tally to 0.\nCurrent tally is %d."] = "重置拦截的垃圾条数至0。\n当前条数为%d。",

	["Delete Spam Log"] = "删除垃圾记录",
	["Deletes all of your spam messages"] = "删除所有垃圾信息",
	["Spam Log has been cleared."] = "垃圾信息记录已清除。",

	["Keyword Options"] = "关键字选项",

	["Add Keyword"] = "增加关键字",
	["Add a new keyword to ignore."] = "添加一条新的忽略关键字。",
	[" already exists."] = "已经存在了。",

	["Add Keyword Group"] = "增加关键字组合",
	["Add a new keyword group to ignore.\nEx: To ignore any messages with the words: \"join\" and \"guild\" you would enter: \"join^guild^\""] = "增加一个想要忽略的关键字组。\n例如：想要忽略所有包含 加入 和 公会 的信息，输入 加入^公会^",
	["Enter a keyword group to ignore"] = "输入一个想要忽略的关键字组合",
	["word1^word2^etc^"] = "关键字1^关键字2^等等^",
	["That intelligent key group already exists"] = "这个关键字组合已经存在了",
	
	["Found an old spam message, spam log is being reset to update to new system."] = "发现一条旧的垃圾信息，垃圾信息记录已重置以更新到新系统。",
	["Generating GM ticket for: "] = "生成 GM 请求：",

	["Reinstate Keyword Defaults"] = "恢复默认关键字",
	["This will reinstate the default keywords while keeping any you've added intact."] = "恢复默认关键字，但你所增加的也依然会被保留。",

	["Reinstate Keyword Group Defaults"] = "恢复默认关键字组",
	["This will reinstate the default keyword groups while keeping any you've added intact."] = "恢复默认关键字组，但你所增加的也依然会被保留。",

	["Remove Keyword(s)"] = "移除关键字",
	["Click a keyword to remove it from the spam list.\nCurrent keyword total: %s"] = "点击一个关键字以将它从垃圾信息表中移除。\n当前关键字数量：%s",

	["Remove Keyword Group"] = "移除关键字组",
	["Click a keyword group to remove it from the spam list.\nCurrent keyword group total: %s"] = "点击一个关键字组以将它从垃圾信息表中移除。\n当前关键字组数量：%s",

	["Remove keyword: "] = "移除关键字：",
	["Remove keyword group: "] = "移除关键字组：",

	["Enter a keyword to ignore"] = "输入想要忽略的关键字",
	["New Keyword"] = "新关键字",
	["Please enter a valid keyword"] = "请输入一个有效的关键字",

	["Delete All Spam Key Groups"] = "删除所有垃圾关键字组",
	["|cffff3333!This will purge all spam key groups!|r\nYou should not do this unless you are planning on reinstating keyword group defaults afterwards."] = "|cffff3333!这将清除所有垃圾关键字组！|r\n你应该只有在想要恢复默认关键字组前才这么做。",
	["Are you sure you want to purge all of your keywords?"] = "你确认你想清除所有关键字么？",

	["Delete All Spam Keys"] = "删除所有垃圾关键字",
	["|cffff3333!This will purge all spam keys!|r\nYou should not do this unless you are planning on reinstating keyword defaults afterwards."] = "|cffff3333!这将清除所有垃圾关键字！|r\n你应该只有在想要恢复默认关键字前才这么做。",
	["Are you sure you want to purge all of your keyword groups?"] = "你确认你想清除所有关键字组么？"
} end)
