local VERSION = tonumber(("$Revision: 76936 $"):match("%d+"))

local Parrot = Parrot
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2008-06-17 11:59:04 -0400 (Tue, 17 Jun 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local mod = Parrot:NewModule("CombatEventsData", "LibRockEvent-1.0")

local _, playerClass = _G.UnitClass("player")

-- local L = Parrot:L("Parrot_CombatEvents_Data", {
-- 	["Miss!"] = MISS .. "!",
-- 	["Dodge!"] = DODGE .. "!",
-- 	["Parry!"] = PARRY .. "!",
-- 	["Block!"] = BLOCK .. "!",
-- 	["Absorb!"] = ABSORB .. "!",
-- 	["Immune!"] = IMMUNE .. "!",
-- 	["Resist!"] = RESIST .. "!",
-- 	["Reflect!"] = REFLECT .. "!",
-- 	["Interrupt!"] = INTERRUPT .. "!",
-- 	["Pet Miss!"] = PET .. " " .. MISS .. "!",
-- 	["Pet Dodge!"] = PET .. " " .. DODGE .. "!",
-- 	["Pet Parry!"] = PET .. " " .. PARRY .. "!",
-- 	["Pet Block!"] = PET .. " " .. BLOCK .. "!",
-- 	["Pet Absorb!"] = PET .. " " .. ABSORB .. "!",
-- 	["Pet Immune!"] = PET .. " " .. IMMUNE .. "!",
-- 	["Pet Resist!"] = PET .. " " .. RESIST .. "!",
-- 	["Pet Reflect!"] = PET .. " " .. REFLECT .. "!",
-- 	["Pet Interrupt!"] = PET .. " " .. INTERRUPT .. "!",
-- })

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents_Data")

local newList, del = Rock:GetRecyclingFunctions("Parrot", "newList", "del")

local onEnableFuncs = {}
function mod:OnEnable()
	-- not needed anymore
	--assert(Rock("LibSpecialEvents-Aura-3.0")) -- force a load
	
	for _,v in ipairs(onEnableFuncs) do
		v()
	end
end

------------------------------------------------------------------------------
-- Incoming events -----------------------------------------------------------
------------------------------------------------------------------------------
local coloredDamageAmount = function(info)
	local db = Parrot:GetModule("CombatEvents").db.profile.damageTypes
	if db.color then
		return "|cff" .. db[info.damageType] .. info.amount .. "|r"
	else
		return info.amount
	end
end

local damageTypeString = function(info)
	return L[info.damageType]

end

Parrot:RegisterFilterType("Incoming damage", L["Incoming damage"], 0)
Parrot:RegisterThrottleType("Melee damage", L["Melee damage"], 0.1, true)

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee damage",
	localName = L["Melee damage"],
	defaultTag = "([Name]) -[Amount]",
	parserEvent = {
		eventType = "Damage",
		recipientID = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Amount = coloredDamageAmount,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Amount = L["The amount of damage done."],
	},
	color = "ff0000", -- red
	canCrit = true,
	filterType = { "Incoming damage", 'amount' },
	throttle = { "Melee damage", 'recipientID', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee misses",
	localName = L["Melee misses"],
	defaultTag = L["Miss!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		recipientID = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee dodges",
	localName = L["Melee dodges"],
	defaultTag = L["Dodge!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		recipientID = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee parries",
	localName = L["Melee parries"],
	defaultTag = L["Parry!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		recipientID = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee blocks",
	localName = L["Melee blocks"],
	defaultTag = L["Block!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		recipientID = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee absorbs",
	localName = L["Melee absorbs"],
	defaultTag = L["Absorb!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		recipientID = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee immunes",
	localName = L["Melee immunes"],
	defaultTag = L["Immune!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		recipientID = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
	},
	color = "ffff00", -- yellow
}

local function retrieveAbilityName(info)
	return Parrot:GetModule("CombatEvents"):GetAbbreviatedSpell(info.abilityName)
end

local function retrieveExtraAbilityName(info)
	return Parrot:GetModule("CombatEvents"):GetAbbreviatedSpell(info.extraAbilityName)
end


-- this table is needed because some spells emit Spellids 
-- to the combatlog that have wrong icons
-- maps the spellid emitted by the comabat log to the spellID from the spell with the icon
local dumbIconOverride = {
	[31818] = select(3, GetSpellInfo(27222)), -- Life Tap
	[22482] = select(3, GetSpellInfo(13877)), -- Blade Flurry
}

local function retrieveIconFromAbilityName(info)
	
	local icon

	if(info.spellID) then
		icon = dumbIconOverride[info.spellID] or select(3, GetSpellInfo(info.spellID))
	else
		--shouldn't be needed though, but to be sure
		icon = select(3, GetSpellInfo(info.abilityName))
	end

	return icon
end


Parrot:RegisterThrottleType("Skill damage", L["Skill damage"], 0.1, true)

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Skill damage",
	localName = L["Skill damage"],
	defaultTag = "([Name]) -[Amount]",
	parserEvent = {
		eventType = "Damage",
		recipientID = "player",
		abilityName_not = false,
		isDoT = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "ff0000", -- red
	canCrit = true,
	throttle = { "Skill damage", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
	filterType = { "Incoming damage", 'amount' },
}

Parrot:RegisterThrottleType("DoTs and HoTs", L["DoTs and HoTs"], 2)

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Skill DoTs",
	localName = L["Skill DoTs"],
	defaultTag = "([Name]) -[Amount]",
	parserEvent = {
		eventType = "Damage",
		recipientID = "player",
		abilityName_not = false,
		isDoT = true,
	},
	tagTranslations = {
		Name = "sourceName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "ff0000", -- red
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else -- >= 2
			return L[" (%d hits)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Ability misses",
	localName = L["Ability misses"],
	defaultTag = "([Skill]) " .. L["Miss!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Ability dodges",
	localName = L["Ability dodges"],
	defaultTag = "([Skill]) " .. L["Dodge!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Ability parries",
	localName = L["Ability parries"],
	defaultTag = "([Skill]) " .. L["Parry!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Ability blocks",
	localName = L["Ability blocks"],
	defaultTag = "([Skill]) " .. L["Block!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Spell resists",
	localName = L["Spell resists"],
	defaultTag = "([Skill]) " .. L["Resist!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Resist",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "7f007f", -- purple
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Skill absorbs",
	localName = L["Skill absorbs"],
	defaultTag = "([Skill]) " .. L["Absorb!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Skill immunes",
	localName = L["Skill immunes"],
	defaultTag = "([Skill]) " .. L["Immune!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Skill reflects",
	localName = L["Skill reflects"],
	defaultTag = "([Skill]) " .. L["Reflect!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Reflect",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
	},
	color = "7f007f", -- purple
	canCrit = true,
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Skills"],
	name = "Spell interrupts",
	localName = L["Skill interrupts"],
	defaultTag = "([Skill]) " .. L["Interrupt!"] .. "{[ExtraSkill]}",
	parserEvent = {
		eventType = "Interrupt",
		recipientID = "player",
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		ExtraSkill = retrieveExtraAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked you."],
		Skill = L["The spell or ability that the enemy attacked you with."],
		ExtraSkill = L["Skill you were interrupted in casting"]
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterFilterType("Incoming heals", L["Incoming heals"], 0)
Parrot:RegisterThrottleType("Heals", L["Heals"], 0.1, true)

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Heals"],
	name = "Heals",
	localName = L["Heals"],
	defaultTag = "([Skill] - [Name]) +[Amount]",
	parserEvent = {
		eventType = "Heal",
		recipientID = "player",
		isHoT = false,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally that healed you."],
		Skill = L["The spell or ability that the ally healed you with."],
		Amount = L["The amount of healing done."],
	},
	color = "00ff00", -- green
	canCrit = true,
	filterType = { "Incoming heals", 'realAmount' },
	throttle = { "Heals", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d heal, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d heal, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d heals, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d heals)"]:format(numNorm)
			else -- >= 2
				return L[" (%d heals, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Heals"],
	name = "Self heals",
	localName = L["Self heals"],
	defaultTag = "([Skill]) +[Amount]",
	parserEvent = {
		eventType = "Heal",
		recipientID = "player",
		isHoT = false,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally that healed you."],
		Skill = L["The spell or ability that the ally healed you with."],
		Amount = L["The amount of healing done."],
	},
	color = "00ff00", -- green
	canCrit = true,
	filterType = { "Incoming heals", 'realAmount' },
	throttle = { "Heals", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d heal, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d heal, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d heals, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d heals)"]:format(numNorm)
			else -- >= 2
				return L[" (%d heals, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Heals"],
	name = "Heals over time",
	localName = L["Heals over time"],
	defaultTag = "([Skill] - [Name]) +[Amount]",
	parserEvent = {
		eventType = "Heal",
		recipientID = "player",
		isHoT = true,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally that healed you."],
		Skill = L["The spell or ability that the ally healed you with."],
		Amount = L["The amount of healing done."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else
			return L[" (%d heals)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"] },
	color = "00ff00", -- green
	filterType = { "Incoming heals", 'realAmount' },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Heals"],
	name = "Self heals over time",
	localName = L["Self heals over time"],
	defaultTag = "([Skill]) +[Amount]",
	parserEvent = {
		eventType = "Heal",
		recipientID = "player",
		isHoT = true,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally that healed you."],
		Skill = L["The spell or ability that the ally healed you with."],
		Amount = L["The amount of healing done."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else
			return L[" (%d heals)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"] },
	color = "00ff00", -- green
	filterType = { "Incoming heals", 'realAmount' },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	name = "Environmental damage",
	localName = L["Environmental damage"],
	defaultTag = "-[Amount] [Type]",
	parserEvent = {
		eventType = "Environmental",
		recipientID = "player",
	},
	tagTranslations = {
		Amount = coloredDamageAmount,
		Type = "hazardTypeLocal",
	},
	tagTranslationsHelp = {
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
	},
	color = "ff0000", -- red
}

-------------------------------------------------------------------------------
--incoming Pet events----------------------------------------------------------
-------------------------------------------------------------------------------

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet melee"],
	name = "Pet melee damage",
	localName = L["Pet melee damage"],
	defaultTag = "(Pet) -[Amount]",
	parserEvent = {
		eventType = "Damage",
		recipientID = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Amount = coloredDamageAmount,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
		Amount = L["The amount of damage done."],
	},
	color = "ff0000", -- red
	canCrit = true,
	filterType = { "Incoming damage", 'amount' },
	throttle = { "Melee damage", 'recipientID', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}



Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet melee"],
	name = "Pet melee misses",
	localName = L["Pet melee misses"],
	defaultTag = L["Pet Miss!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		recipientID = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet melee"],
	name = "Pet melee dodges",
	localName = L["Pet melee dodges"],
	defaultTag = L["Pet Dodge!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		recipientID = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet melee"],
	name = "Pet melee parries",
	localName = L["Pet melee parries"],
	defaultTag = L["Pet Parry!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		recipientID = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet melee"],
	name = "Pet melee blocks",
	localName = L["Pet melee blocks"],
	defaultTag = L["Pet Block!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		recipientID = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet melee"],
	name = "Pet melee absorbs",
	localName = L["Pet melee absorbs"],
	defaultTag = L["Pet Absorb!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		recipientID = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet melee"],
	name = "Pet melee immunes",
	localName = L["Pet melee immunes"],
	defaultTag = L["Pet Immune!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		recipientID = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "sourceName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet skill damage",
	localName = L["Pet skill damage"],
	defaultTag = "(Pet) -[Amount]",
	parserEvent = {
		eventType = "Damage",
		recipientID = "pet",
		abilityName_not = false,
		isDoT = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The spell or ability that the enemy attacked your pet with."],
	},
	color = "ff0000", -- red
	canCrit = true,
	throttle = { "Skill damage", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
	filterType = { "Incoming damage", 'amount' },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet skill DoTs",
	localName = L["Pet skill DoTs"],
	defaultTag = "(Pet) -[Amount]",
	parserEvent = {
		eventType = "Damage",
		recipientID = "pet",
		abilityName_not = false,
		isDoT = true,
	},
	tagTranslations = {
		Name = "sourceName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy that attacked your pet."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The spell or ability that the enemy attacked your pet with."],
	},
	color = "ff0000", -- red
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else -- >= 2
			return L[" (%d hits)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"] },
}


Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet ability misses",
	localName = L["Pet ability misses"],
	defaultTag = L["Pet Miss!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet ability dodges",
	localName = L["Pet ability dodges"],
	defaultTag = L["Pet Dodge!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet ability parries",
	localName = L["Pet ability parries"],
	defaultTag = L["Pet Parry!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet ability blocks",
	localName = L["Pet ability blocks"],
	defaultTag = L["Pet Block!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet spell resists",
	localName = L["Pet spell resists"],
	defaultTag = L["Pet Resist!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Resist",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fb2", -- blue-gray
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet skill absorbs",
	localName = L["Pet skill"],
	defaultTag = L["Pet Absorb!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fff", -- light blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet skill immunes",
	localName = L["Pet skill immunes"],
	defaultTag = L["Pet Immune!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fff", -- light blue
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet skill reflects",
	localName = L["Pet skill reflects"],
	defaultTag = L["Pet Reflect!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Reflect",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fff", -- light blue
	canCrit = true,
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet skills"],
	name = "Pet skill evades",
	localName = L["Pet skill evades"],
	defaultTag = L["Evade!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Evade",
		recipientID = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "ff7fff", -- pink
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Pet heals"],
	name = "Pet heals",
	localName = L["Pet heals"],
	defaultTag = L["(Pet) +[Amount]"],
	parserEvent = {
		eventType = "Heal",
		recipientID = "pet",
		isHoT = false,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "destName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally that healed your pet."],
		Skill = L["The spell or ability that the ally healed your pet with."],
		Amount = L["The amount of healing done."],
	},
	color = "00ff00", -- green
	canCrit = true,
	filterType = { "Incoming heals", 'realAmount' },
	throttle = { "Heals", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d heal, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d heal, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d heals, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d heals)"]:format(numNorm)
			else -- >= 2
				return L[" (%d heals, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Heals"],
	name = "Pet heals over time",
	localName = L["Pet heals over time"],
	defaultTag = "([Skill] - [Name]) +[Amount]",
	parserEvent = {
		eventType = "Heal",
		recipientID = "player",
		isHoT = true,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "sourceName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally that healed your pet."],
		Skill = L["The spell or ability that the ally healed your pet with."],
		Amount = L["The amount of healing done."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else
			return L[" (%d heals)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"] },
	color = "00ff00", -- green
	filterType = { "Incoming heals", 'realAmount' },
}

------------------------------------------------------------------------------
-- Outgoing events -----------------------------------------------------------
------------------------------------------------------------------------------
Parrot:RegisterFilterType("Outgoing damage", L["Outgoing damage"], 0)

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee damage",
	localName = L["Melee damage"],
	defaultTag = "[Amount]",
	parserEvent = {
		eventType = "Damage",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Amount = coloredDamageAmount,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Amount = L["The amount of damage done."],
	},
	color = "ffffff", -- white
	canCrit = true,
	filterType = { "Outgoing damage", 'amount' },
	throttle = { "Melee damage", 'sourceID', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, recipientName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee misses",
	localName = L["Melee misses"],
	defaultTag = L["Miss!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
	},
	color = "ffffff", -- white
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee dodges",
	localName = L["Melee dodges"],
	defaultTag = L["Dodge!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
	},
	color = "ffffff", -- white
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee parries",
	localName = L["Melee parries"],
	defaultTag = L["Parry!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
	},
	color = "ffffff", -- white
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee blocks",
	localName = L["Melee blocks"],
	defaultTag = L["Block!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
	},
	color = "ffffff", -- white
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee absorbs",
	localName = L["Melee absorbs"],
	defaultTag = L["Absorb!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee immunes",
	localName = L["Melee immunes"],
	defaultTag = L["Immune!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Melee"],
	name = "Melee evades",
	localName = L["Melee evades"],
	defaultTag = L["Evade!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Evade",
		sourceID = "player",
		recipientID_not = "player",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
	},
	color = "ff7f00", -- orange
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Skill damage",
	localName = L["Skill damage"],
	defaultTag = "[Amount] ([Skill])",
	parserEvent = {
		eventType = "Damage",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
		isDoT = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffff00", -- yellow
	canCrit = true,
	throttle = { "Skill damage", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, recipientName = L["Multiple"] },
	filterType = { "Outgoing damage", 'amount' },
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Skill DoTs",
	localName = L["Skill DoTs"],
	defaultTag = "[Amount] ([Skill])",
	parserEvent = {
		eventType = "Damage",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
		isDoT = true,
	},
	tagTranslations = {
		Name = "recipientName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The spell or ability that you used."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else
			return L[" (%d hits)"]:format(numNorm)
		end
	end }, recipientName = L["Multiple"] },
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Ability misses",
	localName = L["Ability misses"],
	defaultTag = L["Miss!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffffff", -- white
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Ability dodges",
	localName = L["Ability dodges"],
	defaultTag = L["Dodge!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffffff", -- white
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Ability parries",
	localName = L["Ability parries"],
	defaultTag = L["Parry!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffffff", -- white
}


Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Ability blocks",
	localName = L["Ability blocks"],
	defaultTag = L["Block!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffffff", -- white
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Spell resists",
	localName = L["Spell resists"],
	defaultTag = L["Resist!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Resist",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "7f7fb2", -- blue-gray
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Skill absorbs",
	localName = L["Skill absorbs"],
	defaultTag = L["Absorb!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Skill immunes",
	localName = L["Skill immunes"],
	defaultTag = L["Immune!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Skill reflects",
	localName = L["Skill reflects"],
	defaultTag = L["Reflect!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Reflect",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ffff00", -- yellow
	canCrit = true,
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Spell interrupts",
	localName = L["Skill interrupts"],
	defaultTag = L["Interrupt!"] .. " ([Skill]) {[ExtraSkill]}",
	parserEvent = {
		eventType = "Interrupt",
		sourceID = "player",
		recipientID_not = "player",
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		ExtraSkill = retrieveExtraAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
		ExtraSkill = L["The spell you interrupted"]
	},
	color = "ffff00", -- yellow
}


Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Skill evades",
	localName = L["Skill evades"],
	defaultTag = L["Evade!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Evade",
		sourceID = "player",
		recipientID_not = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy you attacked."],
		Skill = L["The spell or ability that you used."],
	},
	color = "ff7f00", -- orange
}

Parrot:RegisterFilterType("Outgoing heals", L["Outgoing heals"], 0)

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Heals"],
	name = "Heals",
	localName = L["Heals"],
	defaultTag = "+[Amount] ([Skill] - [Name])",
	parserEvent = {
		eventType = "Heal",
		sourceID = "player",
		recipientID_not = "player",
		isHoT = false,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally you healed."],
		Skill = L["The spell or ability that you used."],
		Amount = L["The amount of healing done."],
	},
	color = "00ff00", -- green
	canCrit = true,
	filterType = { "Outgoing heals", 'realAmount' },
	throttle = { "Heals", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d heal, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d heal, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d heals, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d heals)"]:format(numNorm)
			else -- >= 2
				return L[" (%d heals, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}


Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Heals"],
	name = "Self heals",
	localName = L["Self heals"],
	defaultTag = "+[Amount] ([Skill])",
	parserEvent = {
		eventType = "Heal",
		sourceID = "player",
		recipientID_not = "player",
		isHoT = false,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally you healed."],
		Skill = L["The spell or ability that you used."],
		Amount = L["The amount of healing done."],
	},
	color = "00ff00", -- green
	canCrit = true,
	defaultDisabled = true,
	filterType = { "Outgoing heals", 'realAmount' },
	throttle = { "Heals", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d heal, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d heal, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d heals, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d heals)"]:format(numNorm)
			else -- >= 2
				return L[" (%d heals, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Heals"],
	name = "Heals over time",
	localName = L["Heals over time"],
	defaultTag = "+[Amount] ([Skill] - [Name])",
	parserEvent = {
		eventType = "Heal",
		sourceID = "player",
		recipientID_not = "player",
		isHoT = true,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally you healed."],
		Skill = L["The spell or ability that you used."],
		Amount = L["The amount of healing done."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one heal
			return nil
		else -- >= 2
			return L[" (%d heals)"]:format(numNorm)
		end
	end }, recipientName = L["Multiple"] },
	color = "00ff00", -- green
	filterType = { "Outgoing heals", 'realAmount' },
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Heals"],
	name = "Self heals over time",
	localName = L["Self heals over time"],
	defaultTag = "+[Amount] ([Skill])",
	
	parserEvent = {
		eventType = "Heal",
		sourceID = "player",
		recipientID_not = "player",
		isHoT = true,
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the ally you healed."],
		Skill = L["The spell or ability that you used."],
		Amount = L["The amount of healing done."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one heal
			return nil
		else -- >= 2
			return L[" (%d heals)"]:format(numNorm)
		end
	end }, recipientName = L["Multiple"] },
	color = "00ff00", -- green
	filterType = { "Outgoing heals", 'realAmount' },
	defaultDisabled = true,
}


Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee damage",
	localName = L["Pet melee damage"],
	defaultTag = L["Pet [Amount]"],
	tagTranslations = {
		Name = "recipientName",
		Amount = "amount",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Amount = L["The amount of damage done."],
	},
	color = "ff7f00", -- orange
	canCrit = true,
	throttle = { "Melee damage", 'sourceID', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, recipientName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee misses",
	localName = L["Pet melee misses"],
	defaultTag = L["Pet Miss!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
	},
	color = "ff7f00", -- orange
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee dodges",
	localName = L["Pet melee dodges"],
	defaultTag = L["Pet Dodge!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
	},
	color = "ff7f00", -- orange
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee parries",
	localName = L["Pet melee parries"],
	defaultTag = L["Pet Parry!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
	},
	color = "ff7f00", -- orange
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee blocks",
	localName = L["Pet melee blocks"],
	defaultTag = L["Pet Block!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
	},
	color = "ff7f00", -- orange
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee absorbs",
	localName = L["Pet melee absorbs"],
	defaultTag = L["Pet Absorb!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
	},
	color = "7f7fff", -- light blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee immunes",
	localName = L["Pet melee immunes"],
	defaultTag = L["Pet Immune!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
	},
	color = "7f7fff", -- light blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet melee"],
	name = "Pet melee evades",
	localName = L["Pet melee evades"],
	defaultTag = L["Pet Evade!"],
	parserEvent = {
		eventType = "Miss",
		missType = "Evade",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName = false,
	},
	tagTranslations = {
		Name = "recipientName",
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
	},
	color = "ff7fff", -- pink
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet skill damage",
	localName = L["Pet skill damage"],
	defaultTag = L["Pet [Amount] ([Skill])"],
	parserEvent = {
		eventType = "Damage",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
	canCrit = true,
	throttle = { "Skill damage", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d hit, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d hit, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d hits, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				return L[" (%d hits)"]:format(numNorm)
			else -- >= 2
				return L[" (%d hits, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, recipientName = L["Multiple"] },
	filterType = { "Outgoing damage", 'amount' },
	
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Pet skill DoTs",
	localName = L["Pet skill DoTs"],
	defaultTag = "[Amount] ([Skill])",
	parserEvent = {
		eventType = "Damage",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
		isDoT = true,
	},
	tagTranslations = {
		Name = "recipientName",
		Amount = coloredDamageAmount,
		Type = damageTypeString,
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Amount = L["The amount of damage done."],
		Type = L["The type of damage done."],
		Skill = L["The spell or ability that your pet used."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else
			return L[" (%d hits)"]:format(numNorm)
		end
	end }, recipientName = L["Multiple"] },
	color = "ffff00", -- yellow
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet ability misses",
	localName = L["Pet ability misses"],
	defaultTag = L["Pet Miss!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Miss",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet ability dodges",
	localName = L["Pet ability dodges"],
	defaultTag = L["Pet Dodge!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Dodge",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet ability parries",
	localName = L["Pet ability parries"],
	defaultTag = L["Pet Parry!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Parry",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet ability blocks",
	localName = L["Pet ability blocks"],
	defaultTag = L["Pet Block!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Block",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "0000ff", -- blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet spell resists",
	localName = L["Pet spell resists"],
	defaultTag = L["Pet Resist!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Resist",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fb2", -- blue-gray
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet skill absorbs",
	localName = L["Pet skill"],
	defaultTag = L["Pet Absorb!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Absorb",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fff", -- light blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet skill immunes",
	localName = L["Pet skill immunes"],
	defaultTag = L["Pet Immune!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Immune",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fff", -- light blue
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet skill reflects",
	localName = L["Pet skill reflects"],
	defaultTag = L["Pet Reflect!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Reflect",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "7f7fff", -- light blue
	canCrit = true,
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet skills"],
	name = "Pet skill evades",
	localName = L["Pet skill evades"],
	defaultTag = L["Evade!"] .. " ([Skill])",
	parserEvent = {
		eventType = "Miss",
		missType = "Evade",
		sourceID = "pet",
		recipientID_not = "pet",
		abilityName_not = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the enemy your pet attacked."],
		Skill = L["The ability or spell your pet used."],
	},
	color = "ff7fff", -- pink
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Pet heals"],
	name = "Pet heals",
	localName = L["Pet heals"],
	defaultTag = L["(Pet) +[Amount]"],
	tagTranslations = {
		Name = "destName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the unit that your pet healed."],
		Skill = L["The spell or ability that the pet used to heal."],
		Amount = L["The amount of healing done."],
	},
	color = "00ff00", -- green
	canCrit = true,
	filterType = { "Outgoing heals", 'realAmount' },
	throttle = { "Heals", 'abilityName', { 'throttleCount', 'isCrit', function(info)
		local numNorm = info.throttleCount_isCrit_false or 0
		local numCrit = info.throttleCount_isCrit_true or 0
		info.isCrit = numCrit > 0
		if numNorm == 1 then
			if numCrit == 1 then
				return L[" (%d heal, %d crit)"]:format(1, 1)
			elseif numCrit == 0 then
				-- just one hit
				return nil
			else -- >= 2
				return L[" (%d heal, %d crits)"]:format(1, numCrit)
			end
		elseif numNorm == 0 then
			if numCrit == 1 then
				-- just one crit
				return nil
			else -- >= 2
				return L[" (%d crits)"]:format(numCrit)
			end
		else -- >= 2
			if numCrit == 1 then
				return L[" (%d heals, %d crit)"]:format(numNorm, 1)
			elseif numCrit == 0 then
				-- just one hit
				return L[" (%d heals)"]:format(numNorm)
			else -- >= 2
				return L[" (%d heals, %d crits)"]:format(numNorm, numCrit)
			end
		end
	end }, sourceName = L["Multiple"] },
}
Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Heals"],
	name = "Pet heals over time",
	localName = L["Pet heals over time"],
	defaultTag = "([Skill] - [Name]) +[Amount]",
	tagTranslations = {
		Name = "destName",
		Skill = retrieveAbilityName,
		Amount = "realAmount",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Name = L["The name of the unit that your pet healed."],
		Skill = L["The spell or ability that the pet used to heal."],
		Amount = L["The amount of healing done."],
	},
	throttle = { "DoTs and HoTs", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one hit
			return nil
		else
			return L[" (%d heals)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"] },
	color = "00ff00", -- green
	filterType = { "Incoming heals", 'realAmount' },
}

------------------------------------------------------------------------------
-- Notification events -------------------------------------------------------
------------------------------------------------------------------------------

Parrot:RegisterThrottleType("Power gain/loss", L["Power gain/loss"], 3)
Parrot:RegisterFilterType("Power gain", L["Power gain"], 0)

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Power change"],
	name = "Power gain",
	localName = L["Power gain"],
	defaultTag = L["+[Amount] [Type]"],
	parserEvent = {
		eventType = "Gain",
		attribute_in = { "Mana", "Focus", "Rage", "Energy" },
		recipientID = "player",
	},
	tagTranslations = {
		Amount = function(info)
			return info.amountGained or info.amount
		end,
		Type = function(info)
			return info.attributeGainedLocal or info.attributeLocal
		end,
		Skill = retrieveAbilityName,
		Name = function(info)
			return info.sourceGainedName and info.recipientName or info.sourceName
		end,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Amount = L["The amount of power gained."],
		Type = L["The type of power gained (Mana, Rage, Energy)."],
		Skill = L["The ability or spell used to gain power."],
		Name = L["The character that the power comes from."],
	},
	color = "ffff00", -- yellow
	throttle = { "Power gain/loss", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one gain
			return nil
		else -- >= 2
			return L[" (%d gains)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"], recipientName = L["Multiple"] },
	filterType = { "Power gain", function(info)
		return info.amountGained or info.amount
	end}
}

onEnableFuncs[#onEnableFuncs+1] = function()
	--[[ Parser is deprecated. FIXME.
	mod:AddParserListener({
		eventType = "Leech",
		sourceGainedID = "player",
		attributeGained_in = { "Mana", "Focus", "Rage", "Energy" },
	}, function(info)
		Parrot:TriggerCombatEvent("Notification", "Power gain", info)
	end)
	--]]
end

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Power change"],
	name = "Power loss",
	localName = L["Power loss"],
	defaultTag = L["-[Amount] [Type]"],
	parserEvent = {
		eventType_in = { "Drain", "Leech" },
		attribute_in = { "Mana", "Focus", "Rage", "Energy" },
		recipientID = "player",
	},
	tagTranslations = {
		Amount = "amount",
		Type = "attributeLocal",
		Skill = retrieveAbilityName,
		Name = "sourceName",
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationsHelp = {
		Amount = L["The amount of power lost."],
		Type = L["The type of power lost (Mana, Rage, Energy)."],
		Skill = L["The ability or spell take away your power."],
		Name = L["The character that caused the power loss."],
	},
	color = "ffff00", -- yellow
	throttle = { "Power gain/loss", 'abilityName', { 'throttleCount', function(info)
		local numNorm = info.throttleCount or 0
		if numNorm == 1 then
			-- just one loss
			return nil
		else -- >= 2
			return L[" (%d losses)"]:format(numNorm)
		end
	end }, sourceName = L["Multiple"] },
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Combo points"],
	name = "Combo point gain",
	localName = L["Combo point gain"],
	defaultTag = L["[Num] CP"],
	tagTranslations = {
		Num = 1
	},
	tagTranslationHelp = {
		Num = L["The current number of combo points."]
	},
	color = "ff7f00", -- orange
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Combo points"],
	name = "Combo points full",
	localName = L["Combo points full"],
	defaultTag = L["[Num] CP Finish It!"],
	tagTranslations = {
		Num = 1
	},
	tagTranslationHelp = {
		Num = L["The current number of combo points."]
	},
	color = "ff7f00", -- orange
}

onEnableFuncs[#onEnableFuncs+1] = function()
	mod:AddEventListener("PLAYER_COMBO_POINTS", function()
		local num = GetComboPoints()
		if num == 0 then
			return
		end
		local info = newList(num)
		Parrot:TriggerCombatEvent("Notification", num == 5 and "Combo points full" or "Combo point gain", info)
		info = del(info)
	end)
end

Parrot:RegisterCombatEvent{
	category = "Notification",
	name = "Honor gains",
	localName = L["Honor gains"],
	defaultTag = "+[Amount] " .. HONOR_CONTRIBUTION_POINTS,
	
	tagTranslations = {
		Amount = "amount",
-- 		Name = "sourceName", -- not supported anymore
-- 		Rank = "sourceRank", -- not supported anymore
	},
	tagTranslationHelp = {
		Amount = L["The amount of honor gained."],
		-- Name = L["The name of the enemy slain."],
		-- Rank = L["The rank of the enemy slain."],
	},
	color = "7f7fb2", -- blue-gray
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Reputation"],
	name = "Reputation gains",
	localName = L["Reputation gains"],
	defaultTag = "+[Amount] " .. REPUTATION .. " ([Faction])",
	parserEvent = {
		eventType = "Reputation",
		amount_gt = 0,
	},
	tagTranslations = {
		Amount = "amount",
		Faction = "faction",
	},
	tagTranslationHelp = {
		Amount = L["The amount of reputation gained."],
		Faction = L["The name of the faction."],
	},
	color = "7f7fb2", -- blue-gray
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Reputation"],
	name = "Reputation losses",
	localName = L["Reputation losses"],
	defaultTag = "-[Amount] " .. REPUTATION .. " ([Faction])",
	parserEvent = {
		eventType = "Reputation",
		amount_lt = 0,
	},
	tagTranslations = {
		Amount = function(info) return info.amount end,
		Faction = "faction",
	},
	tagTranslationHelp = {
		Amount = L["The amount of reputation lost."],
		Faction = L["The name of the faction."],
	},
	color = "7f7fb2", -- blue-gray
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	name = "Skill gains",
	localName = L["Skill gains"],
	defaultTag = "[Skill]: [Amount]",
	parserEvent = {
		eventType = "Skill",
	},
	tagTranslations = {
		Skill = retrieveAbilityName,
		Amount = "amount",
	},
	tagTranslationHelp = {
		Skill = L["The skill which experienced a gain."],
		Amount = L["The amount of skill points currently."]
	},
	color = "5555ff", -- semi-light blue
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	name = "Experience gains",
	localName = L["Experience gains"],
	defaultTag = "[Amount] " .. XP,
	parserEvent = {
		eventType = "Experience",
		recipientID = "player",
	},
	tagTranslations = {
		-- Name = "sourceName", -- not supported anymore by the event
		Amount = "amount",
	},
	tagTranslationHelp = {
		-- Name = L["The name of the enemy slain."], not supported anymore by the event
		Amount = L["The amount of experience points gained."]
	},
	color = "bf4ccc", -- magenta
	sticky = true,
	defaultDisabled = true,
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Killing blows"],
	name = "Player killing blows",
	localName = L["Player killing blows"],
	defaultTag = L["Killing Blow!"] .. " ([Name])",
	parserEvent = {
		eventType = "Death",
		sourceID = "player",
		recipientID_not = "player",
		recipientPvP = true,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = function(info) return info.abilityName or PLAYERSTAT_MELEE_COMBAT end,
	},
	tagTranslationHelp = {
		Name = L["The name of the enemy slain."],
		Skill = L["The spell or ability used to slay the enemy."],
	},
	color = "5555ff", -- semi-light blue
	sticky = true,
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Killing blows"],
	name = "NPC killing blows",
	localName = L["NPC killing blows"],
	defaultTag = L["Killing Blow!"] .. " ([Name])",
	parserEvent = {
		eventType = "Death",
		sourceID = "player",
		recipientID_not = "player",
		recipientPvP = false,
	},
	tagTranslations = {
		Name = "recipientName",
		Skill = function(info) return info.abilityName or PLAYERSTAT_MELEE_COMBAT end,
	},
	tagTranslationHelp = {
		Name = L["The name of the enemy slain."],
		Skill = L["The spell or ability used to slay the enemy."],
	},
	color = "5555ff", -- semi-light blue
	sticky = true,
}

if playerClass == "WARLOCK" then
	Parrot:RegisterCombatEvent{
		category = "Notification",
		name = "Soul shard gains",
		localName = L["Soul shard gains"],
		defaultTag = "+[Name]",
		tagTranslations = {
			Name = "itemName",
			Icon = function(info)
				local itemLink = info.itemLink
				if itemLink then
					local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(itemLink)
					return texture
				end
			end
		},
		tagTranslationHelp = {
			Name = L["The name of the soul shard."],
		},
		color = "990099", -- purple
		sticky = true,
	}
end

Parrot:RegisterCombatEvent{
	category = "Notification",
	name = "Extra attacks",
	localName = L["Extra attacks"],
	defaultTag = L["%s!"]:format("[Skill]"),
	parserEvent = {
		eventType = "Extra Attack",
		recipientID = "player",
		abilityName_not = false,
	},
	tagTranslations = {
		Skill = retrieveAbilityName,
		Icon = retrieveIconFromAbilityName,
	},
	tagTranslationHelp = {
		Skill = L["The name of the spell or ability which provided the extra attacks."],
	},
	color = "ffff00", -- yellow
	sticky = true,
}
