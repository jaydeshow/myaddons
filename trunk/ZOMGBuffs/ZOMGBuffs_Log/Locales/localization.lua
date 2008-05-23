local L = LibStub("AceLocale-2.2"):new("ZOMGLog")

L:RegisterTranslations("enUS", function() return {
	["Log"] = true,
	["Event Logging"] = true,
	["Open"] = true,
	["View the log"] = true,
	["Clear"] = true,
	["Clear the log"] = true,
	["Behaviour"] = true,
	["Log behaviour"] = true,
	["Merge"] = true,
	["Merge similar entries within 15 seconds. Avoids confusion with cycling through buffs to get to desired one giving multiple log entries."] = true,

	["Generated automatic template"]			= true,
	["%s %s's template - %s from %s to %s"]		= true,
	["%s %s's exception - %s from %s to %s"]	= true,
	["Remotely changed"]						= true,
	["Changed"]									= true,
	["Cleared %s's exceptions for %s"]			= true,

	["Changed %s's template - %s from %s to %s"]		= true,
	["Changed %s's exception - %s from %s to %s"]		= true,
	["Loaded template '%s'"]							= true,
	["Saved template '%s'"]								= true,

} end)
