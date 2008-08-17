local VERSION = tonumber(("$Revision: 80487 $"):match("%d+"))

local Parrot = Parrot
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2008-08-15 10:25:35 -0400 (Fri, 15 Aug 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local mod = Parrot:NewModule("CombatEventsData", "LibRockEvent-1.0")

local _, playerClass = _G.UnitClass("player")

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents_Data")

local newList, del = Rock:GetRecyclingFunctions("Parrot", "newList", "del")

local SchoolParser =
{
	[1] = "Physical",
	[2] = "Holy",
	[4] = "Fire",
	[8] = "Nature",
	[16] = "Frost",
	[32] = "Shadow",
	[64] = "Arcane"
}

local EnvironmentalParser =
{
	["DROWNING"] = "Drowning",
	["FALLING"] = "Falling",
	["FATIGUE"] = "Fatigue",
	["FIRE"] = "Fire",
	["LAVA"] = "Lava",
	["SLIME"] = "Slime"
}

local MANA = _G.MANA
local RAGE = _G.RAGE
local FOCUS = _G.FOCUS
local ENERGY = _G.ENERGY
local HAPPINESS = _G.HAPPINESS

local PowerTypeParser = {
	[0] = MANA,
	[1] = RAGE,
	[2] = FOCUS,
	[3] = ENERGY,
	[4] = HAPPINESS,
}

local onEnableFuncs = {}
function mod:OnEnable()
	for _,v in ipairs(onEnableFuncs) do
		v()
	end
end

------------------------------------------------------------------------------
-- Incoming events -----------------------------------------------------------
------------------------------------------------------------------------------
local coloredDamageAmount = function(info)
	local db = Parrot:GetModule("CombatEvents").db.profile.damageTypes
	if db.color and db[info.damageType] then
		return "|cff" .. db[info.damageType] .. info.amount .. "|r"
	else
		return info.amount
	end
end

local damageTypeString = function(info)
	if info.damageType then
		return L[info.damageType]
	else
		return ""
	end

end

Parrot:RegisterFilterType("Incoming damage", L["Incoming damage"], 0)
Parrot:RegisterThrottleType("Melee damage", L["Melee damage"], 0.1, true)

local bit_bor = bit.bor
local bit_band = bit.band
local GUARDIAN_FLAGS = bit_bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE,
	COMBATLOG_OBJECT_CONTROL_PLAYER,
	COMBATLOG_OBJECT_TYPE_GUARDIAN
	)

local function checkFlags(flags1, flags2)
	return (bit_band(flags1, flags2) == flags2)
end

Parrot:RegisterCombatEvent{
	category = "Incoming",
	subCategory = L["Melee"],
	name = "Melee damage",
	localName = L["Melee damage"],
	defaultTag = "([Name]) -[Amount]",
	combatLogEvents = {
		{
			eventType = "SWING_DAMAGE",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			
				if dstGUID ~= UnitGUID("player") then
					return nil
				end
					
				local info = {}
				info.damageType = SchoolParser[school]
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.amount = amount
				info.absorbAmount = absorbed or 0
				info.blockAmount = blocked or 0
				info.resistAmount = resisted or 0
				info.isCrit = (critical ~= nil)
				info.isCrushing = (crushing ~= nil)
				info.isGlancing = (glancing ~= nil)
				
				return info
			end,
		},
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
	defaultTag = MISS .. "!",
	combatLogEvents = {
		{
			eventType = "SWING_MISSED",
			func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
				if dstGUID ~= UnitGUID("player") or missType ~= "MISS" then
					return nil
				end
				
				local info = newList()
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
			
				return info
			end,
		},
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
	defaultTag = DODGE .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			
			if dstGUID ~= UnitGUID("player") or missType ~= "DODGE" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName

		
			return info
		end,
		},
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
	defaultTag = PARRY .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			
			if dstGUID ~= UnitGUID("player") or missType ~= "PARRY" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = BLOCK .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			
			if dstGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = ABSORB .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			
			if dstGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = IMMUNE .. "!",
	combatLogEvents = {
		{
			eventType = "SWING_MISSED",
			func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
				
				if dstGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
					return nil
				end
				
				local info = newList()
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				
			
				return info
			end,
		},
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
	name = "Reactive skills",
	localName = L["Reactive skills"],
	defaultTag = "([Name]) -[Amount]",
	combatLogEvents = {
		{
			eventType = "DAMAGE_SHIELD",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if dstGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.sourceName = srcName
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			
			return info
		end,
		},
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
			else -- >= 2O
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
	subCategory = L["Skills"],
	name = "Skill damage",
	localName = L["Skill damage"],
	defaultTag = "([Name]) -[Amount]",
	combatLogEvents = {
		{
		eventType = "SPELL_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if dstGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			
			info.isDoT = false
			
			return info
		end,
		},
		{
			eventType = "RANGE_DAMAGE",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if dstGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			info.isDoT = false
			
			return info
			end,
		},
		{
			eventType = "DAMAGE_SPLIT",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if dstGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			info.isDoT = false
			
			return info
			end,
		}
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
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_DAMAGE",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType, extraAmount )
			
			if dstGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			-- Shadowword: Death feedback damage workaround
			if( spellId == 32409 and srcName == nil ) then
				info.sourceName = dstName
			else
				info.sourceName = srcName
			end
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.amount = amount + (extraAmount or 0)
			
			info.isDoT = true
			
			return info
		end,
		},
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
	defaultTag = "([Skill]) " .. MISS .. "!",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if dstGUID ~= UnitGUID("player") or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if dstGUID ~= UnitGUID("player") or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "MISS" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = "([Skill]) " .. DODGE .. "!",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "DODGE" then
					return nil
				end
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "DODGE" then
					return nil
				end
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "DODGE" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = "([Skill]) " .. PARRY .. "!",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "PARRY" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "PARRY" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "PARRY" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = "([Skill]) " .. BLOCK .. "!",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = "([Skill]) " .. RESIST .. "!",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "RESIST" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "RESIST" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "RESIST" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = "([Skill]) " .. ABSORB .. "!",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = "([Skill]) " .. IMMUNE .. "!",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = "([Skill]) " .. REFLECT .. "!",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "REFLECT" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "RANGE_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "REFLECT" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if dstGUID ~= UnitGUID("player") or missType ~= "REFLECT" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	name = "Skill interrupts",
	localName = L["Skill interrupts"],
	defaultTag = "([Skill]) " .. INTERRUPT .. "! {[ExtraSkill]}",
	combatLogEvents = {
		{
		eventType = "SPELL_INTERRUPT",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool)
			if dstGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.extraSpellID = extraSpellId
			info.damageType = SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.extraAbilityName = extraSpellName
			
			info.isDoT = false
			
			return info
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if dstGUID ~= UnitGUID("player") or srcGUID == UnitGUID("player") or srcGUID == UnitGUID("pet") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( dstName )) or (UnitPlayerControlled( dstName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = false
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if dstGUID ~= UnitGUID("player") or srcGUID ~= UnitGUID("player") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = false
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if dstGUID ~= UnitGUID("player") or srcGUID == UnitGUID("player") or srcGUID == UnitGUID("pet") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = true
			info.overhealAmount = overHeal
			
			return info
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if dstGUID ~= UnitGUID("player") or srcGUID ~= UnitGUID("player") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = true
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "ENVIRONMENTAL_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, enviromentalType, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if dstGUID ~= UnitGUID("player") then
				return nil
			end
			local info = newList()
			info.damageType = SchoolParser[school]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.hazardTypeLocal = EnvironmentalParser[enviromentalType]
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			
			return info
		end,
		},
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
	defaultTag = PET .. " -[Amount]",
	combatLogEvents = {
		{
		eventType = "SWING_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if checkFlags(dstFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
				
			local info = {}
			info.damageType = SchoolParser[school]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, MISS),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "MISS" then
				return nil
			elseif checkFlags(dstFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, DODGE),
		combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "DODGE" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, PARRY),
		combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "PARRY" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, BLOCK),
		combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "BLOCK" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, ABSORB),
		combatLogEvents = {
		{
			eventType = "SWING_MISSED",
			func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
				if missType ~= "ABSORB" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				
			
				return info
			end,
		},
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
	defaultTag = string.format("%s %s!", PET, IMMUNE),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "IMMUNE" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = PET .. " -[Amount]",
	combatLogEvents = {
		{
		eventType = "SPELL_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			
			if checkFlags(dstFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			info.isDoT = false
			
			return info
		end,
		},
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
	defaultTag = PET .. " -[Amount]",
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_DAMAGE",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType, extraAmount )
			
			if checkFlags(dstFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif dstGUID ~= UnitGUID("pet") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.amount = amount + (extraAmount or 0)
			
			info.isDoT = true
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, MISS),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "MISS" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "MISS" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, DODGE),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "DODGE" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "DODGE" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, PARRY),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "PARRY" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "PARRY" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, BLOCK),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "BLOCK" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "BLOCK" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, RESIST),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "RESIST" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "RESIST" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, ABSORB),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "ABSORB" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "ABSORB" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, IMMUNE),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "IMMUNE" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
			{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "IMMUNE" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, REFLECT),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "REFLECT" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "REFLECT" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, EVADE),
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "EVADE" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if missType ~= "EVADE" then
					return
				end
				if checkFlags(srcFlags, GUARDIAN_FLAGS) then
					if not Parrot.db.profile.totemDamage then
						return nil
					end
				elseif dstGUID ~= (UnitGUID("pet") or 0) then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				info.abilityName = spellName
				
				
				return info
			end,
		},
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
	defaultTag = PET .. " +[Amount]",
	combatLogEvents = {
		{
		eventType = "SPELL_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = false
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
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
	subCategory = L["Pet heals"],
	name = "Pet heals over time",
	localName = L["Pet heals over time"],
	defaultTag = PET .. " ([Skill] - [Name]) +[Amount]",
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if dstGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = true
			info.overhealAmount = overHeal
			
			return info
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SWING_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if srcGUID ~= UnitGUID("player") then
				return nil
			end
				
			local info = {}
			info.damageType = SchoolParser[school]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			
			return info
		end,
		},
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
	defaultTag = MISS .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if srcGUID ~= UnitGUID("player") or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = DODGE .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if srcGUID ~= UnitGUID("player") or missType ~= "DODGE" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = PARRY .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if srcGUID ~= UnitGUID("player") or missType ~= "PARRY" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = BLOCK .. "!",
		combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if srcGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = ABSORB .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if srcGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = IMMUNE .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if srcGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			
		
			return info
		end,
		},
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
	defaultTag = EVADE .. "!",
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if srcGUID ~= UnitGUID("player") or missType ~= "EVADE" then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	name = "Reactive skills",
	localName = L["Reactive skills"],
	defaultTag = "[Amount] ([Skill])",
	combatLogEvents = {
		{
			eventType = "DAMAGE_SHIELD",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if srcGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.sourceName = srcName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			
			return info
		end,
		},
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
	filterType = { "Outgoing damage", 'amount' },
	
}

Parrot:RegisterCombatEvent{
	category = "Outgoing",
	subCategory = L["Skills"],
	name = "Skill damage",
	localName = L["Skill damage"],
	defaultTag = "[Amount] ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			-- 2nd condition is to prevent self-damage shown as outgoing
			if srcGUID ~= UnitGUID("player") or dstGUID == UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = drcName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			info.isDoT = false
			
			return info
		end,
		},
		{
			eventType = "RANGE_DAMAGE",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
				if srcGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			info.isDoT = false
			
			return info
			end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_DAMAGE",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType, extraAmount )
			
			if srcGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.amount = amount + (extraAmount or 0)
			
			info.isDoT = true
			
			return info
		end,
		},
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
	defaultTag = MISS .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = DODGE .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "DODGE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "DODGE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "DODGE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = PARRY .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "PARRY" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "PARRY" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "PARRY" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = BLOCK .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "BLOCK" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = RESIST .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "RESIST" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "RESIST" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "RESIST" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = ABSORB .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "ABSORB" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = IMMUNE .. "! ([Skill])",
	combatLogEvents = {
		{
			eventType = "SPELL_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if srcGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.abilityName = spellName
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				
				
				return info
			end,
		},
		{
			eventType = "SPELL_PERIODIC_MISSED",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
				if srcGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
					return nil
				end
				
				local info = newList()
				info.spellID = spellId
				info.abilityName = spellName
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceID = srcGUID
				info.sourceName = srcName
				
				
				return info
			end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "IMMUNE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = REFLECT .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "REFLECT" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "REFLECT" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "REFLECT" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	defaultTag = "([Skill]) " .. INTERRUPT .. "! {[ExtraSkill]}",
	combatLogEvents = {
		{
		eventType = "SPELL_INTERRUPT",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool)
			if srcGUID ~= UnitGUID("player") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.extraSpellID = extraSpellId
			info.damageType = SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.extraAbilityName = extraSpellName
			
			info.isDoT = false
			
			return info
		end,
		},
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
	defaultTag = EVADE .. "! ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "EVADE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "EVADE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
		{
		eventType = "RANGE_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= UnitGUID("player") or missType ~= "EVADE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.abilityName = spellName
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
			
			return info
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if srcGUID ~= UnitGUID("player") or dstGUID == UnitGUID("player") or dstGUID == UnitGUID("pet") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local uhm = UnitHealthMax(dstName)
				-- TODO make more accurate, when is the UnithHealth really known
				if uhm > 0 and uhm ~= 100 then
					local hp_delta = uhm - UnitHealth(dstName)
					if (amount > hp_delta) then
						overHeal = amount-hp_delta
					end
				end
				-- else assume the Unithealth is not known
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = false
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if srcGUID ~= UnitGUID("player") or dstGUID ~= UnitGUID("player") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = false
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if srcGUID ~= UnitGUID("player") or dstGUID == UnitGUID("player") or dstGUID == UnitGUID("pet") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = true
			info.overhealAmount = overHeal
			
			return info
		end,
		},
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
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if dstGUID ~= UnitGUID("player") or srcGUID ~= UnitGUID("player") then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = true
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
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
	defaultTag = PET .. " [Amount]",
	combatLogEvents = {
		{
		eventType = "SWING_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
				
			local info = {}
			info.damageType = SchoolParser[school]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			
			return info
		end,
		},
	},
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
	defaultTag = string.format("%s %s!", PET, MISS),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "MISS" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, DODGE),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "DODGE" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, PARRY),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "PARRY" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, BLOCK),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "BLOCK" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, ABSORB),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "ABSORB" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, IMMUNE),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "IMMUNE" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = string.format("%s %s!", PET, EVADE),
	combatLogEvents = {
		{
		eventType = "SWING_MISSED",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType )
			if missType ~= "EVADE" then
				return
			end
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			
		
			return info
		end,
		},
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
	defaultTag = PET .. " [Amount] ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_DAMAGE",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing)
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[school] or SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.absorbAmount = absorbed or 0
			info.blockAmount = blocked or 0
			info.resistAmount = resisted or 0
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			info.isDoT = false
			
			return info
		end,
		},
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
	defaultTag = PET .. "[Amount] ([Skill])",
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_DAMAGE",
		func = function( srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType, extraAmount )
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage then
					return nil
				end
			elseif srcGUID ~= UnitGUID("pet") then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[spellSchool]
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.amount = amount + (extraAmount or 0)
			
			info.isDoT = true
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, MISS),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage or missType ~= "MISS" then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if checkFlags(srcFlags, GUARDIAN_FLAGS) then
				if not Parrot.db.profile.totemDamage or missType ~= "MISS" then
					return nil
				end
			elseif srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "MISS" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, DODGE),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "DODGE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "DODGE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, PARRY),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "PARRY" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "PARRY" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, BLOCK),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "BLOCK" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "BLOCK" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, RESIST),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "RESIST" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "RESIST" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, ABSORB),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "ABSORB" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "ABSORB" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, IMMUNE),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "IMMUNE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "IMMUNE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, REFLECT),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "REFLECT" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "REFLECT" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = string.format("%s %s! ([Skill])", PET, EVADE),
	combatLogEvents = {
		{
		eventType = "SPELL_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "EVADE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
		{
		eventType = "SPELL_PERIODIC_MISSED",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType)
			if srcGUID ~= (UnitGUID("pet") or 0) or missType ~= "EVADE" then
				return nil
			end
			
			local info = newList()
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.abilityName = spellName
			
			
			return info
		end,
		},
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
	defaultTag = PET .. " +[Amount]",
	combatLogEvents = {
		{
		eventType = "SPELL_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = false
			info.overhealAmount = overHeal
			
			return info
			
		end,
		},
	},
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
	subCategory = L["Pet heals"],
	name = "Pet heals over time",
	localName = L["Pet heals over time"],
	defaultTag = PET .. " ([Skill] - [Name]) +[Amount]",
	combatLogEvents = {
		{
		eventType = "SPELL_PERIODIC_HEAL",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, critical)
			if srcGUID ~= (UnitGUID("pet") or 0) then
				return nil
			end
			
			local overHeal = 0;
			if (UnitIsPlayer( srcName )) or (UnitPlayerControlled( srcName )) then
				local hp_delta = UnitHealthMax(dstName) - UnitHealth(dstName)
				if (amount > hp_delta) then
					overHeal = amount-hp_delta
				end
			end
			
			local info = newList()
			info.damageType = SchoolParser[school]
			info.spellID = spellId
			info.recipientID = dstGUID
			info.recipientName = dstName
			info.sourceID = srcGUID
			info.sourceName = srcName
			info.amount = amount
			info.realAmount = amount-overHeal
			info.abilityName = spellName
			info.isCrit = (critical ~= nil)
			
			info.isHoT = true
			info.overhealAmount = overHeal
			
			return info
		end,
		},
	},
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
	defaultTag = "+[Amount] [Type]",
	combatLogEvents = {
		{
			eventType = "SPELL_ENERGIZE",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType)
				if dstGUID ~= UnitGUID("player") then
					return nil
				end
					
				local info = newList()
				info.spellID = spellId
				info.damageType = SchoolParser[spellSchool]
				info.recipientID = srcGUID
				info.sourceName = srcName
				info.sourceID = srcGUID
				info.abilityName = spellName
				info.attributeLocal = PowerTypeParser[powerType]
				info.amount = amount
				info.isCrit = (critical ~= nil)
				info.isCrushing = (crushing ~= nil)
				info.isGlancing = (glancing ~= nil)
				
				info.isDoT = false
				
				return info
			
			end,
		},
		{
			eventType = "SPELL_PERIODIC_ENERGIZE",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType)
				if dstGUID ~= UnitGUID("player") then
					return nil
				end
					
				local info = newList()
				info.spellID = spellId
				info.damageType = SchoolParser[spellSchool]
				info.recipientID = srcGUID
				info.sourceName = srcName
				info.sourceID = srcGUID
				info.abilityName = spellName
				info.attributeLocal = PowerTypeParser[powerType]
				info.amount = amount
				info.isCrit = (critical ~= nil)
				info.isCrushing = (crushing ~= nil)
				info.isGlancing = (glancing ~= nil)
				
				info.isDoT = false
				
				return info
			
			end,
		},
		{
			eventType = "SPELL_LEECH",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType)
				if srcGUID ~= UnitGUID("player") then
					return nil
				end
					
				local info = newList()
				info.spellID = spellId
				info.damageType = SchoolParser[spellSchool]
				info.recipientID = srcGUID
				info.sourceName = srcName
				info.sourceID = srcGUID
				info.abilityName = spellName
				info.attributeLocal = PowerTypeParser[powerType]
				info.amount = amount
				info.isCrit = (critical ~= nil)
				info.isCrushing = (crushing ~= nil)
				info.isGlancing = (glancing ~= nil)
				
				info.isDoT = false
				
				return info
			
			end,
		},
		{
			eventType = "SPELL_PERIODIC_LEECH",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType)
				if srcGUID ~= UnitGUID("player") then
					return nil
				end
					
				local info = newList()
				info.spellID = spellId
				info.damageType = SchoolParser[spellSchool]
				info.recipientID = srcGUID
				info.sourceName = srcName
				info.sourceID = srcGUID
				info.abilityName = spellName
				info.attributeLocal = PowerTypeParser[powerType]
				info.amount = amount
				info.isCrit = (critical ~= nil)
				info.isCrushing = (crushing ~= nil)
				info.isGlancing = (glancing ~= nil)
				
				info.isDoT = false
				
				return info
			
			end,
		},
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

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Power change"],
	name = "Power loss",
	localName = L["Power loss"],
	defaultTag = "-[Amount] [Type]",
	combatLogEvents = {
		{
		eventType = "SPELL_DRAIN",
		func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType)
			if dstGUID ~= UnitGUID("player") then
				return nil
			end
				
			local info = newList()
			info.spellID = spellId
			info.damageType = SchoolParser[spellSchool]
			info.recipientID = srcGUID
			info.sourceName = srcName
			info.sourceID = srcGUID
			info.abilityName = spellName
			info.attributeLocal = PowerTypeParser[powerType]
			info.amount = amount
			info.isCrit = (critical ~= nil)
			info.isCrushing = (crushing ~= nil)
			info.isGlancing = (glancing ~= nil)
			
			info.isDoT = false
			
			return info
		
		end,
		},
		{
			eventType = "SPELL_LEECH",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType)
				if dstGUID ~= UnitGUID("player") then
					return nil
				end
					
				local info = newList()
				info.spellID = spellId
				info.damageType = SchoolParser[spellSchool]
				info.recipientID = srcGUID
				info.sourceName = srcName
				info.sourceID = srcGUID
				info.abilityName = spellName
				info.attributeLocal = PowerTypeParser[powerType]
				info.amount = amount
				info.isCrit = (critical ~= nil)
				info.isCrushing = (crushing ~= nil)
				info.isGlancing = (glancing ~= nil)
				
				info.isDoT = false
				
				return info
			
			end,
		},
		{
			eventType = "SPELL_PERIODIC_LEECH",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, powerType)
				if dstGUID ~= UnitGUID("player") then
					return nil
				end
					
				local info = newList()
				info.spellID = spellId
				info.damageType = SchoolParser[spellSchool]
				info.recipientID = srcGUID
				info.sourceName = srcName
				info.sourceID = srcGUID
				info.abilityName = spellName
				info.attributeLocal = PowerTypeParser[powerType]
				info.amount = amount
				info.isCrit = (critical ~= nil)
				info.isCrushing = (crushing ~= nil)
				info.isGlancing = (glancing ~= nil)
				
				info.isDoT = false
				
				return info
			
			end,
		},
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
	combatLogEvents = {
		{
			eventType = "PARTY_KILL",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
				if srcGUID ~= UnitGUID("player") or not UnitIsPVP(dstName) then
					return nil
				end
				local info = newList()
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceName = srcName
				info.sourceID = srcGUID
				
				
				return info
			end
		}
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
	combatLogEvents = {
		{
			eventType = "PARTY_KILL",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
				if srcGUID ~= UnitGUID("player") or UnitIsPVP(dstName) then
					return nil
				end
				local info = newList()
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceName = srcName
				info.sourceID = srcGUID
				
				
				return info
			end
		}
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
	combatLogEvents = {
		{
			eventType = "SPELL_EXTRA_ATTACKS",
			func = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount)
				if srcGUID ~= UnitGUID("player") then
					return nil
				end
				local info = newList()
				info.spellID = spellId
				info.recipientID = dstGUID
				info.recipientName = dstName
				info.sourceName = srcName
				info.sourceID = srcGUID
				info.abilityName = spellName
				info.damageType = SchoolParser[spellSchool]
				info.amount = amount
				
				
				return info
				
			end,
		},
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
