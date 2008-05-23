﻿local L = AceLibrary("AceLocale-2.2"):new("QuestsFu")

L:RegisterTranslations("enUS", function() return {
	["(done)"] = true,
	["(failed)"] = true,

	["Toggle whether the %s module is active"] = true,
	["Modules"] = true,
	["Toggle whether the %s module is active"] = true,

	["Strata"] = true,
	["Adjust the strata of this panel (takes effect after you reload your UI)"] = true,
	["Max height"] = true,
	["Adjust the maximum height of this panel, in pixels (takes effect after you reload your UI)"] = true,
	["Minimum width"] = true,
	["Adjust the minimum width of this panel, in pixels (takes effect after you reload your UI)"] = true,
	['BACKGROUND'] = true,
	['LOW'] = true,
	['MEDIUM'] = true,
	['HIGH'] = true,

	["Lock"] = true,
	["Lock or unlock this panel"] = true,

	TOOLTIP_HINT = "|cffeda55fClick|r to open the quest log. |cffeda55fShift-Click|r to insert quest into chat edit box. |cffeda55fShift-Ctrl-Click|r to insert objectives into the chat edit box. |cffeda55fAlt-Click|r to add to the tracker.",
	["FuBar Tablet"] = true,
	["Settings for the main FuBar tablet"] = true,
	["Show"] = true,
	["Choose what information to display"] = true,
	["Text"] = true,
	["Toolbar text"] = true,
	["Current"] = true,
	["Show current # of quests"] = true,
	["Completed"] = true,
	["Show # of quests completed"] = true,
	["Total"] = true,
	["Show total possible quests"] = true,
	["Last message"] = true,
	["Show last quest status message"] = true,
	["Levels"] = true,
	["Show quest levels"] = true,
	["In QuestsFu"] = true,
	["Show quest levels in the QuestsFu tooltip"] = true,
	["Zone"] = true,
	["Show zone levels in the QuestsFu tooltip"] = true,
	["Impossible quests"] = true,
	["Show impossible (red) quests"] = true,
	["Show quest zones"] = true,
	["Current area only"] = true,
	["Only show quests for the current zone"] = true,
	["Class quests always"] = true,
	["Always show class quests"] = true,
	["Details"] = true,
	["Show quest details"] = true,
	["Current area details only"] = true,
	["Show details for current area quests only"] = true,
	["Completed objectives"] = true,
	["Show completed objectives"] = true,
	["Objectives"] = true,
	["Color objective completion status"] = true,
	["Wrap quest titles"] = true,
	["Wrap long quest titles on to multiple lines"] = true,

	["Color zone names by suggested level"] = true,
	["Color"] = true,
	["Color settings"] = true,
	["Title"] = true,
	["Color the quest title by difficulty"] = true,
	["Level"] = true,
	["Color the quest level by difficulty"] = true,

	["Colors"] = true,
	["Choose custom colors"] = true,
	["Difficulty"] = true,
	["Trivial"] = true,
	["Standard"] = true,
	["Difficult"] = true,
	["Very difficult"] = true,
	["Impossible"] = true,
	["Header"] = true,
	["Completion"] = true,
	["Not started"] = true,
	["Underway"] = true,
	["Done"] = true,
	["Other"] = true,
} end)
