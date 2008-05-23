local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63783 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local registry = DogTag.registry
local newList = DogTag.newList
local del = DogTag.del
local toUpdate = DogTag.toUpdate
local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local IsNormalUnit = DogTag.IsNormalUnit

local BS2
DogTag:AddAddonFinder("AceLibrary", "Babble-Spell-2.2", function(v) BS2 = v end)
local BS3
DogTag:AddAddonFinder("LibStub", "LibBabble-Spell-3.0", function(v) BS3 = v end)

local currentAuras, currentDebuffTypes, currentAuraTimes, currentNumDebuffs
local function func(self, unit)
	local t = newList()
	local u = newList()
	local v = newList()
	for i = 1, 40 do
		local name, _, _, count, _, timeLeft = UnitBuff(unit, i)
		if not name then
			break
		end
		if count == 0 then
			count = 1
		end
		t[name] = (t[name] or 0) + count
		if timeLeft and timeLeft > 0 and (not v[name] or v[name] > timeLeft) then
			v[name] = timeLeft
		end
	end
	local numDebuffs = 0
	local isFriend = UnitIsFriend("player", unit)
	for i = 1, 40 do
		local name, _, _, count, dispelType, _, timeLeft = UnitDebuff(unit, i)
		if not name then
			break
		end
		if count == 0 then
			count = 1
		end
		numDebuffs = numDebuffs + 1
		t[name] = (t[name] or 0) + count
		if isFriend and dispelType then
			u[dispelType] = true
		end
		if timeLeft and timeLeft > 0 and (not v[name] or v[name] > timeLeft) then
			v[name] = timeLeft
		end
	end
	currentAuras[unit] = t
	currentDebuffTypes[unit] = u
	local currentTime = GetTime()
	for name, timeLeft in pairs(v) do
		v[name] = timeLeft + currentTime
	end
	currentAuraTimes[unit] = v
	currentNumDebuffs[unit] = numDebuffs
	return self[unit]
end

local x = {__index=func}
currentAuras = setmetatable({},x)
currentDebuffTypes = setmetatable({},x)
currentAuraTimes = setmetatable({},x)
currentNumDebuffs = setmetatable({},x)
x = nil
DogTag:AddFakeGlobal("currentAuras", currentAuras)
DogTag:AddFakeGlobal("currentDebuffTypes", currentDebuffTypes)
DogTag:AddFakeGlobal("currentAuraTimes", currentAuraTimes)
DogTag:AddFakeGlobal("currentNumDebuffs", currentNumDebuffs)

local auraQueue = {}

DogTag:AddUpdateAllForUnitHandler(function(unit)	
	if rawget(currentAuras, unit) then
		currentAuras[unit] = del(currentAuras[unit])
		currentDebuffTypes[unit] = del(currentDebuffTypes[unit])
		currentNumDebuffs[unit] = nil
		auraQueue[unit] = true
	end
end)

local function UNIT_AURA(unit)
	auraQueue[unit] = true
end
DogTag:AddEventHandler("UNIT_AURA", UNIT_AURA)

local function PARTY_MEMBERS_CHANGED()
	for k, v in pairs(currentAuras) do
		currentAuras[k] = del(v)
		currentDebuffTypes[k] = del(currentDebuffTypes[k])
		currentAuraTimes[k] = del(currentAuraTimes[k])
		currentNumDebuffs[k] = nil
	end
	
	for text, unit in pairs(registry) do
		auraQueue[unit] = true
	end
end
DogTag:AddEventHandler("PARTY_MEMBERS_CHANGED", PARTY_MEMBERS_CHANGED)
DogTag:AddEventHandler("PLAYER_ENTERING_WORLD", PARTY_MEMBERS_CHANGED)
DogTag:AddEventHandler("UNIT_PET", PARTY_MEMBERS_CHANGED)

DogTag:AddTimerHandler(function(num, currentTime)
	if num%5 == 0 and hasEvent.Aura then
		if num%20 == 0 then
			for unit, v in pairs(currentAuras) do
				if not IsNormalUnit[unit] then
					currentAuras[unit] = del(v)
					currentDebuffTypes[unit] = del(currentDebuffTypes[unit])
					currentAuraTimes[unit] = del(currentAuraTimes[unit])
					currentNumDebuffs[unit] = nil
				end
			end
		end
		for unit in pairs(auraQueue) do
			auraQueue[unit] = nil
			local t = newList()
			local u = newList()
			local v = newList()
			for i = 1, 40 do
				local name, _, _, count, _, timeLeft = UnitBuff(unit, i)
				if not name then
					break
				end
				if count == 0 then
					count = 1
				end
				t[name] = (t[name] or 0) + count
				if timeLeft and timeLeft > 0 and (not v[name] or v[name] > timeLeft) then
					v[name] = timeLeft
				end
			end
			local numDebuffs = 0
			local isFriend = UnitIsFriend("player", unit)
			for i = 1, 40 do
				local name, _, _, count, dispelType, _, timeLeft = UnitDebuff(unit, i)
				if not name then
					break
				end
				if count == 0 then
					count = 1
				end
				numDebuffs = numDebuffs + 1
				t[name] = (t[name] or 0) + count
				if isFriend and dispelType then
					u[dispelType] = true
				end
				if timeLeft and timeLeft > 0 and (not v[name] or v[name] > timeLeft) then
					v[name] = timeLeft
				end
			end
			for k, time in pairs(v) do
				v[k] = time + currentTime
			end
			local old = rawget(currentAuras, unit) or newList()
			local oldType = rawget(currentDebuffTypes, unit) or newList()
			local oldTimes = rawget(currentAuraTimes, unit) or newList()
			local changed = newList()
			local changedDebuffTypes = newList()
			for k, num in pairs(t) do
				if not old[k] then
					changed[k] = true
				else
					if num ~= old[k] then
						changed[k] = true
					end
					old[k] = nil
				end
			end
			for k in pairs(old) do
				changed[k] = true
			end
			for k in pairs(u) do
				if not oldType[k] then
					changedDebuffTypes[k] = true
				else
					oldType[k] = nil
				end
			end
			for k in pairs(oldType) do
				changedDebuffTypes[k] = true
			end
			for k, time in pairs(v) do
				if not oldTimes[k] then
					changed[k] = true
				else
					if math.abs(time - oldTimes[k]) > 0.2 then
						changed[k] = true
					end
					oldTimes[k] = nil
				end
			end
			for k, time in pairs(oldTimes) do
				changed[k] = true
			end
			currentAuras[unit] = t
			currentDebuffTypes[unit] = u
			currentAuraTimes[unit] = v
			local oldNumDebuffs = currentNumDebuffs[unit]
			currentNumDebuffs[unit] = numDebuffs
			if oldNumDebuffs ~= numDebuffs then
				if hasEvent.NumDebuffs then
					for text in pairs(eventData.NumDebuffs) do
						toUpdate[text] = true
					end
				end
			end
			old = del(old)
			oldType = del(oldType)
			oldTimes = del(oldTimes)
			for name in pairs(changed) do
				if hasEvent["Aura"] and hasEvent["Aura"][name] then
					for text in pairs(eventData["Aura{" .. name .. "}"]) do
						toUpdate[text] = true
					end
				end
			end
			for dispelType in pairs(changedDebuffTypes) do
				if hasEvent["Aura"] and hasEvent["Aura"][dispelType] then
					for text in pairs(eventData["Aura{" .. dispelType .. "}"]) do
						toUpdate[text] = true
					end
				end
			end
			changed = del(changed)
			changedDebuffTypes = del(changedDebuffTypes)
		end
	end
end)

DogTag:AddTag("DruidForm", {
	function(data)
		if not BS2 and not BS3 then
			return ([[local _,c = UnitClass(${unit})
			if c == "DRUID" then
				local power = UnitPowerType(${unit})
				if power == 1 then
					value = %q
				elseif power == 3 then
					value = %q
				end
			end]]):format(L["Bear"], L["Cat"]), 'events', "UNIT_DISPLAYPOWER"
		else
			local BSL = BS3 and BS3:GetLookupTable() or BS2
			return ([[local _,c = UnitClass(${unit})
			if c == "DRUID" then
				local power = UnitPowerType(${unit})
				if power == 1 then
					value = %q
				elseif power == 3 then
					value = %q
				else
					local auras = DogTag___currentAuras[${unit}]
					if auras[%q] then
						value = %q
					elseif auras[%q] then
						value = %q
					elseif auras[%q] or auras[%q] then
						value = %q
					elseif auras[%q] then
						value = %q
					elseif auras[%q] and auras[%q] >= 2 then
						value = %q
					end
				end
			end]]):format(L["Bear"], L["Cat"], BSL["Moonkin Form"], L["Moonkin"], BSL["Aquatic Form"], L["Aquatic"], BSL["Flight Form"], BSL["Swift Flight Form"], L["Flight"], BSL["Travel Form"], L["Travel"], BSL["Tree of Life"], BSL["Tree of Life"], L["Tree"]), 'events', "UNIT_DISPLAYPOWER;Aura{" .. ("};Aura{"):join(BSL["Moonkin Form"], BSL["Aquatic Form"], BSL["Flight Form"], BSL["Swift Flight Form"], BSL["Travel Form"], BSL["Tree of Life"]) .. "}"
		end
	end,
	ret = "string;nil",
	globals = "UnitClass;UnitPowerType;DogTag.__currentAuras",
	doc = L["Return the shapeshift form the unit is in if unit is a druid"],
	example = ('[DruidForm] => %q; [DruidForm] => %q; [DruidForm] => ""'):format(L["Bear"], L["Cat"]),
	category = L["Auras"]
})

DogTag:AddTag("ShortDruidForm", {
	alias = "DruidForm:ShortDruidForm",
	doc = L["Return the shortened shapeshift form the unit is in if unit is a druid"],
	example = ('[ShortDruidForm] => %q; [ShortDruidForm] => %q; [ShortDruidForm] => ""'):format(L["Bear_short"], L["Cat_short"]),
	category = L["Auras"]
})

DogTag:AddTag("NumDebuffs", {
	[=[value = DogTag___currentNumDebuffs[${unit}]]=],
	ret = "number",
	globals = "DogTag.__currentNumDebuffs",
	events = "NumDebuffs",
	doc = L["Return the total number of debuffs that unit has"],
	example = '[NumDebuffs] => "5"; [NumDebuffs] => "40"',
	category = L["Auras"]
})

DogTag:AddTag("HasAura", {
	function(data)
		if data.arg:find("%[") and data.arg:find("%]") then
			return [[value = "HasAura cannot support dynamic arguments."]]
		end
		if BS3 then
			local arg = data.arg
			arg = BS3:GetUnstrictLookupTable()[arg] or arg
			return ([[value = DogTag___currentAuras[${unit}][%q] and %q]]):format(arg, arg), 'events', "Aura{" .. arg .. "}"
		elseif BS2 then
			local arg = data.arg
			arg = BS2:HasTranslation(arg) and BS2[arg] or arg
			return ([[value = DogTag___currentAuras[${unit}][%q] and %q]]):format(arg, arg), 'events', "Aura{" .. arg .. "}"
		else
			return [[value = DogTag___currentAuras[${unit}][${arg}] and ${arg}]], 'events', "Aura{" .. data.arg .. "}"
		end
	end,
	arg = "string",
	ret = "string;nil",
	globals = "DogTag.__currentAuras",
	doc = L["Return the aura name if unit has the aura argument"],
	example = ('[HasAura(Shadowform)] => %q; [HasAura(Shadowform)] => ""'):format("Shadowform"),
	category = L["Auras"]
})

DogTag:AddTag("NumAura", {
	function(data)
		if data.arg:find("%[") and data.arg:find("%]") then
			return [[value = "NumAura cannot support dynamic arguments."]]
		end
		if BS3 then
			local arg = data.arg
			arg = BS3:GetUnstrictLookupTable()[arg] or arg
			return ([[value = DogTag___currentAuras[${unit}][%q] or 0]]):format(arg), 'events', "Aura{" .. arg .. "}"
		elseif BS2 then
			local arg = data.arg
			arg = BS2:HasTranslation(arg) and BS2[arg] or arg
			return ([[value = DogTag___currentAuras[${unit}][%q] or 0]]):format(arg), 'events', "Aura{" .. arg .. "}"
		else
			return [[value = DogTag___currentAuras[${unit}][${arg}] or 0]], 'events', "Aura{" .. data.arg .. "}"
		end
	end,
	arg = "string",
	ret = "number",
	globals = "DogTag.__currentAuras",
	doc = L["Return the number of total aura charges of unit of aura argument"],
	example = '[NumAura(Renew)] => "2"; [NumAura(Sunder)] => "5"',
	category = L["Auras"],
})

DogTag:AddTag("AuraFinishTime", {
	function(data)
		if data.arg:find("%[") and data.arg:find("%]") then
			return [[value = "AuraFinishTime cannot support dynamic arguments."]]
		end
		if BS3 then
			local arg = data.arg
			arg = BS3:GetUnstrictLookupTable()[arg] or arg
			return ([=[value = DogTag___currentAuraTimes[${unit}][%q]]=]):format(arg), 'events', "Aura{" .. arg .. "}"
		elseif BS2 then
			local arg = data.arg
			arg = BS2:HasTranslation(arg) and BS2[arg] or arg
			return ([=[value = DogTag___currentAuraTimes[${unit}][%q]]=]):format(arg), 'events', "Aura{" .. arg .. "}"
		else
			return [=[value = DogTag___currentAuraTimes[${unit}][${arg}]]=], 'events', "Aura{" .. data.arg .. "}"
		end
	end,
	arg = "string",
	ret = "number;nil",
	globals = "DogTag.__currentAuraTimes",
	doc = L["Return the absolute time that aura argument will finish, or blank if no aura or time is not known"],
	example = ('[AuraFinishTime(Renew)] => "%s"'):format(GetTime()+10),
	category = L["Auras"],
})

DogTag:AddTag("AuraTimeLeft", {
	alias = "AuraFinishTime(arg) - CurrentTime",
	doc = L["Return the time left in seconds that aura argument will finish"],
	example = '[AuraTimeLeft(Renew)] => "10.37863487"',
	category = L["Auras"],
})

DogTag:AddTag("IsShadowform", {
	alias = "HasAura(Shadowform)",
	doc = L["Return Shadowform if the unit has the shadowform buff"],
	example = ('[IsShadowform] => %q; [IsShadowform] => ""'):format(L["Shadowform"]),
	category = L["Auras"]
})

DogTag:AddTag("IsFeignedDeath", {
	function(data)
		if BS3 then
			return ([[value = UnitIsFeignDeath(${unit}) and %q]]):format(BS3:GetLookupTable()["Feign Death"])
		elseif BS2 then
			return ([[value = UnitIsFeignDeath(${unit}) and %q]]):format(BS2["Feign Death"])
		else
			return ([[value = UnitIsFeignDeath(${unit}) and %q]]):format(L["Feigned Death"])
		end
	end,
	ret = "string;nil",
	globals = "UnitIsFeignDeath",
	doc = L["Return Feigned Death if unit is currently feigning death"],
	example = ('[IsFeignedDeath] => %q; [IsFeignedDeath] => ""'):format(L["Feigned Death"]),
	category = L["Auras"]
})

DogTag:AddTag("IsStealthed", {
	alias = ("HasAura(Stealth) || HasAura(Shadowmeld) || HasAura(Prowl) ? Text(%s)"):format(L["Stealthed"]),
	doc = L["Return Stealthed if the unit is stealthed in some way"],
	example = ('[IsStealthed] => %q; [IsStealthed] => ""'):format(L["Stealthed"]),
	category = L["Auras"]
})

DogTag:AddTag("HasShieldWall", {
	alias = "HasAura(Shield Wall)",
	doc = L["Return Shield Wall if the unit has the Shield Wall buff"],
	example = ('[HasShieldWall] => %q; [HasShieldWall] => ""'):format(L["Shield Wall"]),
	category = L["Auras"]
})

DogTag:AddTag("HasLastStand", {
	alias = "HasAura(Last Stand)",
	doc = L["Return Last Stand if the unit has the Last Stand buff"],
	example = ('[HasLastStand] => %q; [HasLastStand] => ""'):format(L["Last Stand"]),
	category = L["Auras"]
})

DogTag:AddTag("HasSoulstone", {
	alias = ("HasAura(Soulstone) || HasAura(Soulstone Resurrection) ? Text(%q)"):format(L["Soulstoned"]),
	doc = L["Return Soulstoned if the unit has the Soulstone buff"],
	example = ('[HasSoulstone] => %q; [HasSoulstone] => ""'):format(L["Soulstoned"]),
	category = L["Auras"]
})

DogTag:AddTag("HasMisdirection", {
	alias = "HasAura(Misdirection)",
	doc = L["Return Misdirection if the unit has the Misdirection buff"],
	example = ('[HasMisdirection] => %q; [HasMisdirection] => ""'):format(L["Misdirection"]),
	category = L["Auras"]
})

DogTag:AddTag("HasIceBlock", {
	alias = "HasAura(Ice Block)",
	doc = L["Return Ice Block if the unit has the Ice Block buff"],
	example = ('[HasIceBlock] => %q; [HasIceBlock] => ""'):format(L["Ice Block"]),
	category = L["Auras"]
})

DogTag:AddTag("HasInvisibility", {
	alias = "HasAura(Invisibility)",
	doc = L["Return Invisibility if the unit has the Invisibility buff"],
	example = ('[HasInvisibility] => %q; [HasInvisibility] => ""'):format(L["Invisibility"]),
	category = L["Auras"]
})

DogTag:AddTag("HasDivineIntervention", {
	alias = "HasAura(Divine Intervention)",
	doc = L["Return Divine Intervention if the unit has the Divine Intervention buff"],
	example = ('[HasDivineIntervention] => %q; [HasDivineIntervention] => ""'):format(L["Divine Intervention"]),
	category = L["Auras"]
})

DogTag:AddTag("HasDebuffType", {
	function(data)
		if data.arg:find("%[") and data.arg:find("%]") then
			return [[value = "HasDebuffType cannot support dynamic arguments."]]
		end
		return [[value = DogTag___currentDebuffTypes[${unit}][${arg}] and ${arg}]], 'events', "Aura{" .. data.arg .. "}"
	end,
	arg = "string",
	ret = "string;nil",
	globals = "DogTag.__currentDebuffTypes",
	doc = L["Return argument if friendly unit is has a debuff of argument type"],
	example = ('[HasDebuffType(Poison)] => %q; [HasDebuffType(Poison)] => ""'):format(L["Poison"]),
	category = L["Auras"]
})

DogTag:AddTag("HasMagicDebuff", {
	alias = "HasDebuffType(Magic)",
	doc = L["Return Magic if the unit has a Magic debuff"],
	example = ('[HasMagicDebuff] => %q; [HasMagicDebuff] => ""'):format(L["Magic"]),
	category = L["Auras"]
})

DogTag:AddTag("HasCurseDebuff", {
	alias = "HasDebuffType(Curse)",
	doc = L["Return Curse if the unit has a Curse debuff"],
	example = ('[HasCurseDebuff] => %q; [HasCurseDebuff] => ""'):format(L["Curse"]),
	category = L["Auras"]
})

DogTag:AddTag("HasPoisonDebuff", {
	alias = "HasDebuffType(Poison)",
	doc = L["Return Poison if the unit has a Poison debuff"],
	example = ('[HasPoisonDebuff] => %q; [HasPoisonDebuff] => ""'):format(L["Poison"]),
	category = L["Auras"]
})

DogTag:AddTag("HasDiseaseDebuff", {
	alias = "HasDebuffType(Disease)",
	doc = L["Return Disease if the unit has a Disease debuff"],
	example = ('[HasDiseaseDebuff] => %q; [HasDiseaseDebuff] => ""'):format(L["Disease"]),
	category = L["Auras"]
})

end
