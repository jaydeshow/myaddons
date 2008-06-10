﻿local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Tracker")
L:RegisterTranslations("zhCN", function() return {
	["Tracker"] = "任务跟踪模块",
	["Autowatch"] = "自动跟踪任务",
	["Automatically add quests to the tracker when appropriate"] = "自动将适当的任务增加到跟踪模块中",
	["Use own tracker"] = "使用自带的任务跟踪模块",
	["Replace the default quest tracker with a slightly more featureful one"] = "使用自带的跟踪模块取代系统默认跟踪模块",
	["Login"] = "登入",
	["Re-add quests you were watching before you logged out"] = "自动跟踪上次等出时的任务",
	["Zone"] = "区域",
	["Add quests to the tracker when you enter their zone"] = "自动跟踪所在区域的任务",
	["Subzone"] = "子区域",
	["Add quests to the tracker when you enter their subzone"] = "自动跟踪所在子区域的任务",
	["Gained"] = "取得",
	["Add quests to the tracker when they are first gained"] = "自动跟踪刚取得的任务",
	["Progress"] = "进度",
	["Add quests to the tracker when you make progress on them"] = "自动跟踪有任务进度的任务",
	["Remove completed"] = "移除已完成",
	["Remove quests from the tracker when you complete their objectives"] = "自动移除已完成所有目标的任务",
} end)