local L = LibStub("AceLocale-2.2"):new("ZOMGLog")

L:RegisterTranslations("zhCN", function() return {
	["Log"] = "日志",
	["Event Logging"] = "开启日志记录",
	["Open"] = "打开",
	["View the log"] = "查看日志",
	["Clear"] = "清除",
	["Clear the log"] = "清除日志",
	["Behaviour"] = "行为",
	["Log behaviour"] = "记录行为",
	["Merge"] = "合并",
	["Merge similar entries within 15 seconds. Avoids confusion with cycling through buffs to get to desired one giving multiple log entries."] = "合并15秒以内类似的条目。以避免在Buff中循环为了找到一个合适的Buff而导致的多条日志信息。",

	["Generated automatic template"]			= "自动模板已生成",
	["%s %s's template - %s from %s to %s"]		= "%s %s的模板 - %s 来自 %s 给 %s",
	["%s %s's exception - %s from %s to %s"]	= "%s %s的例外 - %s 来自 %s 给 %s",
	["Remotely changed"]						= "已远端更改",
	["Changed"]									= "已更改",
	["Cleared %s's exceptions for %s"]			= "清除了%s的例外给%s",

	["Changed %s's template - %s from %s to %s"]		= "%s的模板已更改 - %s从%s到%s",
	["Changed %s's exception - %s from %s to %s"]		= "%s的例外已更改 - %s从%s到%s",
	["Loaded template '%s'"]							= "模板“%s”已载入",
	["Saved template '%s'"]								= "模板“%s”已保存",

} end)
