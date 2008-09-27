local L = LibStub("AceLocale-2.2"):new("ZOMGPortalz")

L:RegisterTranslations("enUS", function() return {
	["Portal Configuration"]					= true,
	["Key-Binding"]							 	= true,
	["Define the key used for portal popup"]	= true,

	-- Bindings
	["ZOMGBUFFS_PORTALZ"]						= "ZOMGBuffs Portalz",
	["ZOMGBUFFS_PORTAL_KEY"]					= "Portalz Hotkey",

	["Locked"]									= true,
	["Unlocked, the portals can be dragged using the |cFF00FF00Right Mouse Button|r"] = true,

	["Pattern"]									= true,
	["Select the arrangement layout for the portals"] = true,
	["Circle"]									= true,
	["Horizontal"]								= true,
	["Vertical"]								= true,
	["Arc"]										= true,
	["Sticky"]									= true,
	["When sticky, the portals open on one keypress and close on another. When disabled, you are required to hold the key whilst making your selection."] = true,
	["Scale"]									= true,
	["Adjust the scale of the portals"]			= true,
	["Portal Spell"]							= true,
	["Reagent information"]						= true,
	["Show All"]								= true,
	["Show all portal spells, even if you have not learnt them yet."] = true,

} end)

