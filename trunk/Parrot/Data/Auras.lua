local VERSION = tonumber(("$Revision: 74580 $"):match("%d+"))

local Parrot = Parrot
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2008-05-20 17:46:59 -0400 (Tue, 20 May 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Auras")

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Debuff gains",
	localName = L["Debuff gains"],
	defaultTag = "([Name])",
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerDebuffGained",
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
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
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerBuffGained",
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
	},
	tagTranslationsHelp = {
		Name = L["The name of the buff gained."],
	},
	color = "b2b200", -- dark yellow
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Target buff gains",
	localName = L["Target buff gains"],
	defaultTag = "[Unitname] gains [Buffname]",
	tagTranslations = {
		Buffname = "abilityName",
		Icon = "icon",
		Unitname = "dstName",
	},
	tagTranslationsHelp = {
		Buffname = L["The name of the buff gained."],
		Unitname = L["The name of the unit that gained the buff."],
	},
	color = "b2b200", -- dark yellow
	defaultDisabled = true,
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Target buff stack gains",
	localName = L["Target buff stack gains"],
	defaultTag = "[Unitname] gains [Buffname] -[Amount]-)",
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerBuffGained",
	tagTranslations = {
		Buffname = "abilityName",
		Icon = "icon",
		Amount = "amount",
		Unitname = "dstName",
	},
	tagTranslationsHelp = {
		Buffname = L["The name of the buff gained."],
		Amount = L["New Amount of stacks of the buff."],
		Unitname = L["The name of the unit that gained the buff."],
	},
	color = "b2b200", -- dark yellow
	defaultDisabled = true,
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Buff stack gains",
	localName = L["Buff stack gains"],
	defaultTag = "([Name] -[Amount]-)",
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerBuffGained",
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
		Amount = "amount",
	},
	tagTranslationsHelp = {
		Name = L["The name of the buff gained."],
		Name = L["New Amount of stacks of the buff."],
	},
	color = "b2b200", -- dark yellow
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Debuff stack gains",
	localName = L["Debuff stack gains"],
	defaultTag = "([Name] -[Amount]-)",
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerDebuffGained",
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
		Amount = "amount",
	},
	tagTranslationsHelp = {
		Name = L["The name of the debuff gained."],
		Name = L["New Amount of stacks of the debuff."],
	},
	color = "007f7f", -- dark cyan
}



Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Item buff gains",
	localName = L["Item buff gains"],
	defaultTag = "([Name])",
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerItemBuffGained",
	tagTranslations = {
		Name = "abilityName",
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
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerDebuffLost",
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
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
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerBuffLost",
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
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
-- 	blizzardEvent = "LibSpecialEvents-Aura-3.0;PlayerItemBuffLost",
	tagTranslations = {
		Name = "abilityName",
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
-- 	events = {
-- 		--["LibSpecialEvents-Aura-3.0;PlayerBuffGained"] = true
-- 	},
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self buff fade",
	localName = L["Self buff fade"],
-- 	events = {
-- 		["LibSpecialEvents-Aura-3.0;PlayerBuffLost"] = true
-- 	},
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self debuff gain",
	localName = L["Self debuff gain"],
-- 	events = {
-- 		["LibSpecialEvents-Aura-3.0;PlayerDebuffGained"] = true
-- 	},
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self debuff fade",
	localName = L["Self debuff fade"],
-- 	events = {
-- 		["LibSpecialEvents-Aura-3.0;PlayerDebuffLost"] = true
-- 	},
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self item buff gain",
	localName = L["Self item buff gain"],
-- 	events = {
-- 		["LibSpecialEvents-Aura-3.0;PlayerItemBuffGained"] = true
-- 	},
	param = {
		type = 'string',
		usage = L["<Item buff name>"],
	},
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Self item buff fade",
	localName = L["Self item buff fade"],
-- 	events = {
-- 		["LibSpecialEvents-Aura-3.0;PlayerItemBuffLost"] = true
-- 	},
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
	parserArg = 'abilityName',
}


Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Target buff fade",
	localName = L["Target buff fade"],
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
	parserArg = 'abilityName',
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Target debuff fade",
	localName = L["Target debuff fade"],
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
	},
	parserArg = 'abilityName',
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Focus buff gain",
	localName = L["Focus buff gain"],
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
	parserArg = 'abilityName',
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Focus debuff gain",
	localName = L["Focus debuff gain"],
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
	},
	parserArg = 'abilityName',
}


Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Focus buff fade",
	localName = L["Focus buff fade"],
	param = {
		type = 'string',
		usage = L["<Buff name>"],
	},
	parserArg = 'abilityName',
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Focus debuff fade",
	localName = L["Focus debuff fade"],
	param = {
		type = 'string',
		usage = L["<Debuff name>"],
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
		return not GetPlayerBuffName(param)
	end,
}
