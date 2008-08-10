local L = AceLibrary("AceLocale-2.2"):new("GroupFu")

L:RegisterTranslations("enUS", function() return {
	["Solo"] = true,
	group = "Group",
	master = "Master Looter",
	freeforall = "Free for all",
	roundrobin = "Round Robin",
	needbeforegreed = "Need before greed",
	["ML (%s)"] = true,
	["No rolls"] = true,

	["Roll ending in 5 seconds, recorded %d of %d rolls."] = true,

	["Winner: %s."] = true,
	[", "] = true,
	["Tie: %s are tied at %d."] = true,
	["%s (%d/%d)"] = true,
	["%s [%s]"] = true,
	["%d of expected %d rolls recorded."] = true,

	["Perform roll when clicked"] = true,
	["Perform a standard 1-100 roll when the FuBar plugin is clicked."] = true,
	["Announce"] = true,
	["Only accept 1-100"] = true,
	["Accept standard (1-100) rolls only."] = true,
	["Loot type"] = true,
	["Set the loot type."] = true,
	["Loot threshold"] = true,
	["Set the loot threshold."] = true,

	["Where to output roll results."] = true,
	["Auto (based on group type)"] = true,
	["Local"] = true,
	["Say"] = true,
	["Party"] = true,
	["Raid"] = true,
	["Guild"] = true,
	["Don't announce"] = true,

	["Roll clearing"] = true,
	["When to clear the rolls."] = true,
	["Never"] = true,
	["10 seconds"] = true,
	["15 seconds"] = true,
	["30 seconds"] = true,
	["45 seconds"] = true,
	["60 seconds"] = true,

	["Roll"] = true,
	["Player"] = true,
	["Loot method"] = true,
	["Master looter"] = true,
	["Leader"] = true,
	["Officers"] = true,
	["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = true,
	["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = true,

	["Pass"] = true,
	["Everyone passed."] = true,
	
	["Leave Party"] = true,
	["Leave your current party or raid."] = true,
	
	["Reset Instances"] = true,
	["Reset all available instance the group leader has active."] = true,
	
} end)

