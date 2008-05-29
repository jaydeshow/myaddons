local L = LibStub("AceLocale-2.2"):new("ZOMGBuffs")

L:RegisterTranslations("enUS", function() return {
	["TITLE"]				= "ZOMGBuffs",
	["TITLECOLOUR"]			= "|cFFFF8080Z|cFFFFFF80O|cFF80FF80M|cFF8080FFG|cFEFFFFFFBuffs|r",
	["HINT"]				= "|cffeda55fClick|r to toggle auto-casting, |cffeda55fRight-Click|r for options, |cffeda55fClick|r item to change, |cffeda55fShift-Click|r item to remove from self buffs template",
	["HINTBM"]				= "|cffeda55fClick|r to toggle auto-casting, |cffeda55fAlt-Click|r to toggle Blessings Manager, |cffeda55fRight-Click|r for options, |cffeda55fClick|r item to change, |cffeda55fShift-Click|r item to remove from self buffs template",
	["Auto-casting %s"]		= true,
	["|cFF80FF80Enabled"]	= true,
	["|cFFFF8080Disabled"]	= true,
	["%s blacklisted for 10 seconds"] = true,
	["FIND_FLASK"]			= "^Flask of ",
	["FIND_POT"]			= "^Elixir of ",
	["Well Fed"]			= true,
	["Flask"]				= true,
	["Is player flasked or potted"] = true,
	["Light"]				= true,
	["Salvation"]			= true,
	["Wisdom"]				= true,
	["Might"]				= true,
	["Kings"]				= true,
	["Sanctuary"]			= true,
	["Anchor"]				= true,
	["Choose the anchor to use for the player list"] = true,
	["Relative Point"]		= true,
	["Choose the relative point for the anchor"] = true,
	["Invert"]				= true,
	["Invert the need/got alpha values"] = true,
	["Mousewheel Buff"]		= true,
	["Use mousewheel to trigger auto buffing"] = true,
	["Key-Binding"]			= true,
	["Define the key used for auto buffing"] = true,
	["%s%s%s|r to cast %s%s|r%s"] = true,
	["%s%s%s|r to target"]	= true,
	[" on %s"]				= true,
	["|cFF808080%s|r [|Hplayer:%s|h%s|h's pet]"] = true,
	["Reminders"]			= true,
	["Options to help you notice when things need doing"] = true,
	["Notice"]				= true,
	["Show notice on screen for buff needs"] = true,
	["Notice Anchor"]		= true,
	["Show the Notice area anchor"] = true,
	["Rebuff Sound"]		= true,
	["Give audible feedback when someone needs rebuffing"] = true,
	["Finish"]				= true,
	["Information"]			= true,
	["Give feedback about events"] = true,
	["Display"]				= true,
	["Display options"]		= true,
	["Always Load Manager"]	= true,
	["Always load the Blessings Manager, even when not eligable to modify blessings"] = true,
	["Shift-"]				= true,
	["Ctrl-"]				= true,
	["Alt-"]				= true,
	["Left Button"]			= true,
	["Right Button"]		= true,
	["Middle Button"]		= true,
	["Button Four"]			= true,
	["Button Five"]			= true,
	["Behaviour"]			= true,
	["General buffing behaviour"] = true,
	["Not When Resting"]	= true,
	["Don't auto buff when Resting"] = true,
	["Not When Mounted"]	= true,
	["Don't auto buff when Mounted"] = true,
	["Not When Stealthed"]	= true,
	["Don't auto buff when Stealthed"] = true,
	["Not When Shapeshifted"] = true,
	["Don't auto buff when Shapeshifted"] = true,
	["Sort Order"]			= true,
	["Select sorting order for buff overview (can't be changed during combat)"] = true,
	["Bar Texture"]			= true,
	["Set the texture for the buff timer bars"] = true,
	["Auto Buy Reagents"]	= true,
	["Automatically purchase required reagents from Reagents Vendor"] = true,
	["Reagents Levels"]		= true,
	["Purchase levels for reagents"] = true,
	["Bought |cFF80FF80%d|cFFFFFF80 %s|r from vendor, you now have |cFF80FF80%d|r"] = true,
	["Minimum Mana %"]		= true,
	["How much mana should you have before considering auto buffing"] = true,
	["Waiting for %d%% of raid to arrive before buffing commences (%d%% currently present)"] = true,
	["Waiting for these groups or classes to arrive: %s"] = true,
	["Wait for Raid"]		= true,
	["Wait for certain amount of the raid to arrive before group and class buffing commences. Zero to always buff."] = true,
	["Wait for Class/Group"] = true,
	["Wait for all of a class or group to arrive before buffing them"] = true,
	["|cFFFF8080Waiting for these groups or classes to arrive:"] = true,
	["Report Missing"]		= true,
	["Report raid buffs currently missing"] = true,
	["Report"]				= true,
	["Report options"]		= true,
	["<ZOMG> Missing %s: %s"] = true,
	["Mark"]				= true,
	["Stamina"]				= true,
	["Intellect"]			= true,
	["Spirit"]				= true,
	["Blessings"]			= true,
	["Channel"]				= true,
	["Output channel selection"] = true,
	["Group %d"]			= true,
	["|cFF%02X%02X%02XGroup %d|r"] = true,
	["Alphabetical"]		= true,
	["Class"]				= true,
	["Group"]				= true,
	["Unsorted"]			= true,
	["Skip PVP Players"]	= true,
	["Don't directly buff PVP flagged players, unless you're already flagged for PVP"] = true,
	["You have run out of %q, now using single target buffs"] = true,
	["Lock"]				= true,
	["Lock floating icon position"] = true,

	-- Suspsended reasons for floating icon
	["Suspended"]			= true,
	["Not Refreshing because %s"] = true,
	["ZONED"]				= "you have recently zoned, please wait a few seconds",
	["DEAD"]				= "you are dead",
	["ERRORICON"]			= "ERROR: Missing self.icon",
	["DISABLED"]			= "ZOMGBuffs is disabled",
	["TAXI"]				= "you are on a taxi",
	["COMBAT"]				= "you are in combat",
	["MOUNTED"]				= "you are mounted and the |cFFFFFF80Not When Mounted|r option is enabled",
	["RESTING"]				= "you are resting and the |cFFFFFF80Not When Resting|r option is enabled",
	["MANA"]				= "your |cFFFFFF80mana|r is below the minimum configured threshold for auto buffing",
	["EATING"]				= "you are eating",
	["DRINKING"]			= "you are drinking",
	["CHANNELING"]			= "you are channeling a spell",
	["SPIRITTAP"]			= "You have Spirit Tap and the |cFFFFFF80Not with Spirit Tap|r option is enabled",
	["REMOTECONTROL"]		= "You don't feel like yourself",
	["NOCONTROL"]			= "You are not in your right mind",
	["STEALTHED"]			= "You are stealthed and the |cFFFFFF80Not When Stealthed|r option is enabled",
	["SHAPESHIFTED"]		= "You are shapeshifted and the |cFFFFFF80Not When Shapeshifted|r option is enabled",

	["Last"]				= true,
	["Revert to the previously unsaved template"] = true,
	["Save"]				= true,
	["Save current setup as a new template"] = true,
	["<template name>"]		= true,
	["Rename"]				= true,
	["Rename this template"] = true,
	["<new name>"]			= true,
	["Renamed template |cFFFFFF80%s|r to |cFFFFFF80%s|r"] = true,
	["Delete"]				= true,
	["Delete this template"] = true,
	["Saved template %q"]	= true,
	["Switched to template %q"] = true,
	["Switched to template %q because %s"] = true,
	["Auto purchase level for %s (will not exceed this amount)"] = true,
	["Load"]				= true,
	["Load this template"]	= true,
	["Group Number"]		= true,
	["Show the group number next to list"] = true,
	["Out-of-date spell (should be %s). Will be updated when combat ends"] = true,
	["Empty"]				= true,
	["Buff Target"]			= true,
	["Also buff current target (assuming they're not in your party or raid"] = true,
	["Autosave"]			= true,
	["You are now in a battleground"] = true,
	["You are now in an arena"] = true,
	["You are now in a raid"] = true,
	["You are now in a party"] = true,
	["You are now solo"]	= true,
	["Auto Switch"]			= true,
	["Automatically switch to this template"] = true,
	["Never"]				= true,
	["Solo"]				= true,
	["Party"]				= true,
	["Raid"]				= true,
	["Arena"]				= true,
	["Battleground"]		= true,
	["Show"]				= true,
	["Visiblity options"]	= true,
	["Show the popup raid list when you are not in a raid or party"] = true,
	["Show the popup raid list when you are in a party"] = true,
	["Show the popup raid list when you in a raid"] = true,
	["Width"]				= true,
	["Adjust width of unit list"] = true,
	["Bar Height"]			= true,
	["Adjust height of the bars"] = true,
	["Font"]				= true,
	["Size"]				= true,
	["Outlining"]			= true,
	["None"]				= true,
	["Outline"]				= true,
	["Thick Outline"]		= true,
	["Reset Icon Position"]	= true,
	["Reset the icon position to the centre of the screen"] = true,
	["Icon Size"]			= true,
	["Size of main icon"]	= true,
	["Border"]				= true,
	["Enable border on the icon"] = true,
	["Enable border on the list"] = true,
	["Icon"]				= true,
	["Settings for the mouseover icon used by the popup player buff list"] = true,
	["Enable"]				= true,
	["Display the mouseover icon used by the popup player buff list"] = true,
	["List"]				= true,
	["Settings for the popup buff list"] = true,
	["Columns"]				= true,
	["Columns to show in buff list"] = true,
	["Not with Spirit Tap"]	= true,
	["Don't auto buff when you have Spirit Tap, so you can maximise your regeneration"] = true,
	["Buff Pets"]			= true,
	["Perform extra checks for pets in case any missed the group buffs when they were done"] = true,
	["Position the notification area"] = true,
	["Learning"]			= true,
	["Setup spell learning behaviour"] = true,
	["Out of Combat"]		= true,
	["Learn buff changes out of combat"] = true,
	["In-Combat"]			= true,
	["Learn buff changes in combat"] = true,
	["Actions"]				= true,
	["Miscelaneous actions"] = true,
	["Wipe Talent Cache"]	= true,
	["Clear talent cache to force refresh"] = true,
	["Ignore Absent"]		= true,
	["If players are offline, AFK or in another instance, count them as being present and buff everyone else"] = true,
	["Singles Always"]		= true,
	["Only use single target buffs"] = true,
	["Singles in BGs"]		= true,
	["Only use single target buffs in battlegrounds"] = true,
	["Singles in Arena"]	= true,
	["Only use single target buffs in arenas"] = true,
	["Click Config"]		= true,
	["Configure popup raid list click behaviour"] = true,
	["Define the mouse click to use for |cFFFFFF80%s|r"] = true,
	["Target"]				= true,
	["Targetting"]			= true,
	["Defaults"]			= true,
	["Restore default keybindings"] = true,
	["Class Icon"]			= true,
	["Uses your main ZOMGBuffs spell for the floating icon, instead of the ZOMGBuffs default"] = true,
	["Sink Output"]			= true,
	["Route notification messages through SinkLib"] = true,
	["Load Raid Module"]	= true,
	["Load the Raid Buff module. Usually for Mages, Druids & Priests, this module can also track single target spells such as Earth Shield & Blessing of Sacrifice, and allow raid buffing of Undending Breath and so on"] = true,
	["Buff Timer"]			= true,
	["Show buff time remaining with bar"] = true,
	["Timer Size"]			= true,
	["Adjust the size of the timer text"] = true,
	["Timer Threshold"]		= true,
	["Buff times over this number of minutes will not be shown"] = true,
	["Spell Icons"]			= true,
	["Show spell icons with spell names in messages"] = true,
	["Short Names"]			= true,
	["Use short spell names where appropriate"] = true,
	["Show Roles"]			= true,
	["Show player role icons"] = true,
	["Auto-casting is disabled"] = true,
	["You can re-enable it by single clicking the ZOMGBuffs minimap/fubar icon"] = true,

	["CHATMATCH1"]			= "!buff",
	["CHATMATCH2"]			= "!zomg",
	["CHATMATCH3"]			= "!buffs",
	["CHATANSWER"]			= "<ZOMG>",
	["PERSONDIES"]			= "^([^%s]+) dies%.$",
	
	ABOUT				=	"All in one buffing mod for all classes. Paladin buff generated assignments based on Paladin capabilities and raid member sub-classes (druid tank vs. druid healer etc.). Plus overview of important raid buffs, and instant access rebuff on right click.\r\r"..
							"Author: {Author}\r"..
							"Category: {X-Category}\r"..
							"E-mail: {X-Email}\r"..
							"Website: {X-Website}\r"..
							"License: {X-License}\r"
} end)
