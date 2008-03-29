local VERSION = tonumber(("$Revision: 48210 $"):match("%d+"))

local Parrot = Parrot
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2007-09-05 05:05:20 -0400 (Wed, 05 Sep 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local L = Parrot:L("Parrot_Auras")

local SEAura = Rock("LibSpecialEvents-Aura-3.0")

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Debuff gains",
	localName = L["Debuff gains"],
	defaultTag = "([Name])",
	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerDebuffGained",
	tagTranslations = {
		Name = 1,
		Icon = 4,
	},
	tagTranslationsHelp = {
		Name = L["The name of the debuff gained."],
	},
	color = "007f7f", -- dark cyan
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Buff gains",
	localName = L["Buff gains"],
	defaultTag = "([Name])",
	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerBuffGained",
	tagTranslations = {
		Name = 1,
		Icon = 4,
	},
	tagTranslationsHelp = {
		Name = L["The name of the buff gained."],
	},
	color = "b2b200", -- dark yellow
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Item buff gains",
	localName = L["Item buff gains"],
	defaultTag = "([Name])",
	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerItemBuffGained",
	tagTranslations = {
		Name = 1,
		Rank = 2,
		Icon = function(info)
			return GetInventoryItemTexture("player", GetInventorySlotInfo(info[3] and "MainHandSlot" or "SecondaryHandSlot"))
		end,
	},
	tagTranslationsHelp = {
		Name = L["The name of the item buff gained."],
		Rank = L["The rank of the item buff gained."],
	},
	color = "b2b2b2", -- gray
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Debuff fades",
	localName = L["Debuff fades"],
	defaultTag = "-([Name])",
	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerDebuffLost",
	tagTranslations = {
		Name = 1,
		Icon = 4,
	},
	tagTranslationsHelp = {
		Name = L["The name of the debuff lost."],
	},
	color = "00d8d8", -- cyan
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Buff fades",
	localName = L["Buff fades"],
	defaultTag = "-([Name])",
	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerBuffLost",
	tagTranslations = {
		Name = 1,
		Icon = 3,
	},
	tagTranslationsHelp = {
		Name = L["The name of the buff lost."],
	},
	color = "e5e500", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Item buff fades",
	localName = L["Item buff fades"],
	defaultTag = "-([Name])",
	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerItemBuffLost",
	tagTranslations = {
		Name = 1,
		Rank = 2,
		Icon = function(info)
			return GetInventoryItemTexture("player", GetInventorySlotInfo(info[3] and "MainHandSlot" or "SecondaryHandSlot"))
		end,
	},
	tagTranslationsHelp = {
		Name = L["The name of the item buff lost."],
		Rank = L["The rank of the item buff lost."],
	},
	color = "e5e5e5", -- light gray
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self buff gain",
	localName = L["Self buff gain"],
	events = {
		["LibSpecialEvents-Aura-3.0;PlayerBuffGained"] = true
	},
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self buff fade",
	localName = L["Self buff fade"],
	events = {
		["LibSpecialEvents-Aura-3.0;PlayerBuffLost"] = true
	},
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self debuff gain",
	localName = L["Self debuff gain"],
	events = {
		["LibSpecialEvents-Aura-3.0;PlayerDebuffGained"] = true
	},
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self debuff fade",
	localName = L["Self debuff fade"],
	events = {
		["LibSpecialEvents-Aura-3.0;PlayerDebuffLost"] = true
	},
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self item buff gain",
	localName = L["Self item buff gain"],
	events = {
		["LibSpecialEvents-Aura-3.0;PlayerItemBuffGained"] = true
	},
	param = {
		type = 'string',
		usage = L["<Item buff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self item buff fade",
	localName = L["Self item buff fade"],
	events = {
		["LibSpecialEvents-Aura-3.0;PlayerItemBuffLost"] = true
	},
	param = {
		type = 'string',
		usage = L["<Item buff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Target buff gain",
	localName = L["Target buff gain"],
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
	parserEvent = {
		eventType = "Aura",
		isBuff = true,
		recipientName = function() return UnitName("target") end,
	},
	parserArg = 'abilityName',
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Target debuff gain",
	localName = L["Target debuff gain"],
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
	},
	parserEvent = {
		eventType = "Aura",
		isBuff = false,
		recipientName = function() return UnitName("target") end,
	},
	parserArg = 'abilityName',
}

Parrot:RegisterSecondaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Buff inactive",
	localName = L["Buff inactive"],
	notLocalName = L["Buff active"],
	param = {
		type = 'string',
		usage = "<Buff name>",
	},
	check = function(param)
		return not SEAura:UnitHasBuff("player", param)
	end,
}
