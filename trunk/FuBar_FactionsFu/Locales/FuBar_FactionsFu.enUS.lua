local L = AceLibrary("AceLocale-2.2"):new("FuBar_FactionsFu")

L:RegisterTranslations("enUS", function() return {
	TOOLTIP_HINT = "\n|cffeda55fClick|r to change watched faction.\n|cffeda55fShift-Click|r to insert data into chat edit box.\n|cffeda55fAlt-Click|r to set faction as automatic zone faction for current zone.\n|cffeda55fCtrl-Click|r to toggle faction's inactive state.",

	["Text"] = true,
	["Text Settings"] = true,
	["Show Name"] = true,
	["Toggles display of watched faction's name"] = true,
	["Show Standing"] = true,
	["Toggles display of watched faction's current standing"] = true,
	["Show Progress"] = true,
	["Toggles display of watched faction's progress toward next standing"] = true,
	["Show Progress (in percent)"] = true,
	["Toggles display of watched faction's progress toward next standing (in percent)"] = true,
	["Color"] = true,
	["Color Settings"] = true,
	["Name"] = true,
	["Sets color of the faction name"] = true,
	["Reputation"] = true,
	["Sets color of the faction reputation"] = true,
	["standing"] = true,
	["Sets color of the faction standing"] = true,
	["Other"] = true,
	["Other Settings"] = true,
	["Auto-Zone"] = true,
	["Toggles automatical adjustment of watched faction on zone change"] = true,
	["Auto-Gain"] = true,
	["Toggles automatical adjustment of watched faction on faction gain"] = true,

	["None"] = true,
	["War Condition"] = true,
	["Blizzard's Default"] = true,
	["Incremental"] = true,
} end)
