local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63783 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local toUpdate = DogTag.toUpdate
local oldLib = DogTag.oldLib

function DogTag:OnReputationUpdate()
	if not hasEvent.Reputation then
		return
	end
	for text, unit in pairs(eventData.Reputation) do
		toUpdate[text] = true
	end
end

if not oldLib or not oldLib.hookedRep then
	hooksecurefunc("ReputationWatchBar_Update", function()
		LibStub(MAJOR_VERSION):OnReputationUpdate()
	end)
end
DogTag.hookedRep = true

DogTag:AddTagAndModifier("RepColor", {
	function(data)
		return [[local repname, repreaction, repmin, repmax, repvalue
		]] .. (not data.arg and [[
		repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo()
		]] or [[
		for i = 1, GetNumFactions() do
			local _, name
			name, _, repreaction, repmin, repmax, repvalue = GetFactionInfo(i)
			if name == ${arg} then
				repname = name
				break
			end
		end
		]]) .. [[
		if not repname then
		]] .. (data.isMod and [[
			value = "|r" .. value
		]] or [[
			value = "|r"
		]]) .. [[
		else
			local info = FACTION_BAR_COLORS[repreaction]
		]] .. (data.isMod and [[
			value = ("|cff%02x%02x%02x%s|r"):format(info.r * 255, info.g * 255, info.b * 255, value)
		]] or [[
			value = ("|cff%02x%02x%02x"):format(info.r * 255, info.g * 255, info.b * 255)
		]]) .. [[
		end]]
	end,
	events = "Reputation",
	ret = "string",
	globals = "GetWatchedFactionInfo;FACTION_BAR_COLORS;GetFactionInfo;GetNumFactions",
	arg = "string;nil",
	doc = L["Return the color or wrap value with the color associated with either the currently watched faction or the given argument"],
	example = ('[Text(Hello):RepColor] => "|cff7f0000Hello|r"; [Text(Hello):RepColor(%s)] => "|cff007f00Hello|r"; [Text([RepColor(%s)]Hello)] => "|cff007f00Hello"'):format(L["Exodar"], L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("CurRep",{
	function(data)
		if not data.arg then
			return [[local repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo()
			if repname then
				value = repvalue - repmin
			end]], 'globals', "GetWatchedFactionInfo"
		else
			return [[for i = 1, GetNumFactions() do
				local name, _, _, repmin, repmax, repvalue = GetFactionInfo(i)
				if name == ${arg} then
					value = repvalue - repmin
					break
				end
			end]], 'globals', "GetNumFactions;GetFactionInfo"
		end
	end,
	ret = "number;nil",
	events = "Reputation",
	arg = "string;nil",
	doc = L["Return the current reputation of the watched faction or argument"],
	example = ('[CurRep] => "1234"; [CurRep(%s)] => "2345"'):format(L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("MaxRep", {
	function(data)
		if not data.arg then
			return [[local repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo()
			if repname then
				value = repmax - repmin
			end]], 'globals', "GetWatchedFactionInfo"
		else
			return [[for i = 1, GetNumFactions() do
				local name, _, _, repmin, repmax, repvalue = GetFactionInfo(i)
				if name == ${arg} then
					value = repmax - repmin
					break
				end
			end]], 'globals', "GetNumFactions;GetFactionInfo"
		end
	end,
	ret = "number;nil",
	events = "Reputation",
	arg = "string;nil",
	doc = L["Return the maximum reputation of the currently watched faction or argument"],
	example = ('[MaxRep] => "12000"; [MaxRep(%s)] => "21000"'):format(L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("FractionalRep", {
	function(data)
		if not data.arg then
			return [[local repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo()
			if repname then
				repvalue = repvalue - repmin
				repmax = repmax - repmin
				value = repvalue .. '/' .. repmax
			end]], 'globals', "GetWatchedFactionInfo"
		else
			return [[for i = 1, GetNumFactions() do
				local name, _, _, repmin, repmax, repvalue = GetFactionInfo(i)
				if name == ${arg} then
					repvalue = repvalue - repmin
					repmax = repmax - repmin
					value = repvalue .. '/' .. repmax
					break
				end
			end]], 'globals', "GetNumFactions;GetFactionInfo"
		end
	end,
	fakeAlias = "Text([CurRep]/[MaxRep])",
	ret = "string;nil",
	events = "Reputation",
	arg = "string;nil",
	doc = L["Return the current and maximum reputation of the currently watched faction or argument"],
	example = ('[FractionalRep] => "1234/12000"; [FractionalRep(%s)] => "2345/21000"'):format(L["Exodar"], L["Exodar"], L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("PercentRep", {
	function(data)
		if not data.arg then
			return [[local repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo()
			if repname then
				repvalue = repvalue - repmin
				repmax = repmax - repmin
				value = math_floor(1000 * repvalue/repmax + 0.5) / 10
			end]], 'globals', "GetWatchedFactionInfo"
		else
			return [[for i = 1, GetNumFactions() do
				local name, _, _, repmin, repmax, repvalue = GetFactionInfo(i)
				if name == ${arg} then
					repvalue = repvalue - repmin
					repmax = repmax - repmin
					value = math_floor(1000 * repvalue/repmax + 0.5) / 10
					break
				end
			end]], 'globals', "GetNumFactions;GetFactionInfo"
		end
	end,
	fakeAlias = "[CurRep / MaxRep * 100]:Round(1)",
	ret = "number;nil",
	events = "Reputation",
	arg = "string;nil",
	globals = "math.floor",
	doc = L["Return the percentage reputation of the currently watched faction or argument"],
	example = ('[PercentRep] => "10.3"; [PercentRep:Percent] => "10.3%%"; [PercentRep(%s)] => "11.2"; [PercentRep(%s):Percent] => "11.2%%"'):format(L["Exodar"], L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("MissingRep", {
	function(data)
		if not data.arg then
			return [[local repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo()
			if repname then
				value = repmax - repvalue
			end]], 'globals', "GetWatchedFactionInfo"
		else
			return [[for i = 1, GetNumFactions() do
				local name, _, _, repmin, repmax, repvalue = GetFactionInfo(i)
				if name == ${arg} then
					value = repmax - repvalue
					break
				end
			end]], 'globals', "GetNumFactions;GetFactionInfo"
		end
	end,
	ret = "number;nil",
	fakeAlias = "MaxRep - CurRep",
	events = "Reputation",
	arg = "string;nil",
	doc = L["Return the missing reputation of the currently watched faction or argument"],
	example = ('[MissingRep] => "10766"; [MissingRep(%s)] => "18655"'):format(L["Exodar"], L["Exodar"], L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("RepName", {
	[[value = GetWatchedFactionInfo()]],
	ret = "number;nil",
	events = "Reputation",
	events = "Reputation",
	globals = "GetWatchedFactionInfo",
	doc = L["Return the name of the currently watched faction"],
	example = ('[RepName] => %q'):format(L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("RepReaction", {
	function(data)
		if not data.arg then
			return [[local repname, repreaction = GetWatchedFactionInfo()
			if repname then
				value = _G["FACTION_STANDING_LABEL"..repreaction]
			end]], 'globals', "GetWatchedFactionInfo"
		else
			return [[for i = 1, GetNumFactions() do
				local repname, _, repreaction = GetFactionInfo(i)
				if repname == ${arg} then
					value = _G["FACTION_STANDING_LABEL"..repreaction]
					break
				end
			end]], 'globals', "GetNumFactions;GetFactionInfo"
		end
	end,
	ret = "number;nil",
	events = "Reputation",
	globals = "_G",
	arg = "string;nil",
	doc = L["Return your current reputation rank with the watched faction or argument"],
	example = ('[RepReaction] => %q; [RepReaction(%s)] => %q'):format(_G.FACTION_STANDING_LABEL5, "Exodar", _G.FACTION_STANDING_LABEL6),
	category = L["Reputation"]
})

end
