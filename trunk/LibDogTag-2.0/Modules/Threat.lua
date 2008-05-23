local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 60184 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local toUpdate = DogTag.toUpdate

local Threat
DogTag:AddAddonFinder("AceLibrary", "Threat-1.0", function(v) Threat = v end)

local function Threat_ThreatUpdated(unitName, unitID, targetHash, threatValue)
	if not Threat or not hasEvent.Threat then
		return
	end
	for text, unit in pairs(eventData.Threat) do
		if not toUpdate[text] then
			local name = UnitName(unit)
			if (unit == unitID or unit[unitID] or (name and Threat:UnitIsUnit(name, targetHash))) then
				toUpdate[text] = true
			end
		end
	end
end
DogTag:AddAddonFinder("AceLibrary", "AceEvent-2.0", function(v)
	v:RegisterEvent("Threat_ThreatUpdated", Threat_ThreatUpdated)
end)

DogTag:AddTag("Threat", {
	function(data)
		if not Threat then
			return [[]]
		else
			return ([[if UnitIsFriend("player", ${unit}) then
				if UnitExists("target") then
					value = math_floor(ThreatLib:GetThreat(UnitName(${unit}), UnitName("target"))+0.5)
				else
					value = 0
				end
			else
				value = math_floor(ThreatLib:GetThreat(%q, UnitName(${unit}))+0.5)
			end]]):format(UnitName("player")), 'globals', "Threat-1.0;UnitName;UnitExists;math.floor;UnitIsFriend"
		end
	end,
	ret = "number;nil",
	events = "PLAYER_TARGET_CHANGED(target);Threat",
	doc = L["Return the current threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"],
	example = '[Threat] => "50"',
	category = L["Threat"]
})

DogTag:AddTag("MaxThreat", {
	function(data)
		if not Threat then
			return [[]]
		else
			return [[if UnitIsFriend("player", ${unit}) then
				if UnitExists("target") then
					value = math_floor(ThreatLib:GetMaxThreatOnTarget(UnitName("target"))+0.5)
				else
					value = 0
				end
			else
				value = math_floor(ThreatLib:GetMaxThreatOnTarget(UnitName(${unit}))+0.5)
			end]], 'globals', "Threat-1.0;UnitName;math.floor;UnitExists;UnitIsFriend"
		end
	end,
	ret = "number;nil",
	events = "Threat;Threat(target)",
	doc = L["Return the maximum threat that group members have against enemy unit or that group members have against your target, if ThreatLib is available"],
	example = '[MaxThreat] => "80"',
	category = L["Threat"]
})

DogTag:AddTag("PercentThreat", {
	function(data)
		if not Threat then
			return [[]]
		else
			return ([[if UnitIsFriend("player", ${unit}) then
				if UnitExists("target") then
					local target = UnitName("target")
					local max = ThreatLib:GetMaxThreatOnTarget(target)
					if max == 0 then
						value = 0
					else
						value = math_floor(1000 * ThreatLib:GetThreat(UnitName(${unit}), target) / max + 0.5) / 10
					end
				else
					value = 0
				end
			else
				local name = UnitName(${unit})
				local max = ThreatLib:GetMaxThreatOnTarget(name)
				if max == 0 then
					value = 0
				else
					value = math_floor(1000 * ThreatLib:GetThreat(%q, name) / max + 0.5) / 10
				end
			end]]):format(UnitName("player"), UnitName("player")), 'globals', "Threat-1.0;UnitName;UnitExists;math.floor;UnitIsFriend"
		end
	end,
	fakeAlias = "[MaxThreat / Threat * 100]:Round(1)",
	ret = "number;nil",
	events = "PLAYER_TARGET_CHANGED(target);Threat",
	doc = L["Return the percentage threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"],
	example = '[PercentThreat] => "62.5"; [PercentThreat:Percent] => "62.5%"',
	category = L["Threat"]
})

DogTag:AddTag("MissingThreat", {
	alias = "MaxThreat - Threat",
	doc = L["Return the missing threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"],
	example = '[MissingThreat] => "30"',
	category = L["Threat"]
})

DogTag:AddTag("FractionalThreat", {
	alias = "Text([Threat]/[MaxThreat])",
	doc = L["Return the current and maximum threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"],
	example = '[FractionalThreat] => "50/80"',
	category = L["Threat"]
})

DogTag:AddTag("HasNoThreat", {
	function(data)
		if not Threat then
			return ([[value = %q]]):format(L["True"])
		else
			return ([[if UnitIsFriend("player", ${unit}) then
				if UnitExists("target") then
					value = ThreatLib:GetThreat(UnitName(${unit}), UnitName("target")) == 0 and %q
				else
					value = %q
				end
			else
				value = ThreatLib:GetThreat(%q, UnitName(${unit})) == 0 and %q
			end]]):format(L["True"], L["True"], UnitName("player"), L["True"]), 'globals', "Threat-1.0;UnitName;UnitExists"
		end
	end,
	ret = "string;nil",
	events = "PLAYER_TARGET_CHANGED(target);Threat",
	doc = L["Return True if you have no threat against enemy unit, friendly unit has no threat against your target, or if ThreatLib is unavailable"],
	example = ('[HasNoThreat] => %q; [HasNoThreat] => ""'):format(L["True"]),
	category = L["Threat"]
})

end