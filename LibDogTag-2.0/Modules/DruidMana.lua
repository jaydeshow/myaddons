local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

local isDruid = select(2, UnitClass("player")) == "DRUID"

local DruidMana
if isDruid then
	local hasEvent = DogTag.hasEvent
	local eventData = DogTag.eventData
	local toUpdate = DogTag.toUpdate
	
	DogTag:AddAddonFinder("LibStub", "LibDruidMana-1.0", function(v)
		DruidMana = v
		v:AddListener(function(currMana, maxMana)
			if not hasEvent.DruidMana then
				return
			end
			for text, unit in pairs(eventData.DruidMana) do
				toUpdate[text] = true
			end
		end)
	end)
end

DogTag:AddTag("CurDruidMP", {
	function(data)
		if not DruidMana then
			return [[]]
		else
			return [[if ${unit} == "player" then
				value = LibDruidMana:GetCurrentMana()
			end]], 'globals', "LibDruidMana-1.0"
		end
	end,
	ret = "number;nil",
	events = "DruidMana",
	doc = L["Return the current mana of unit if unit is you and you are a druid"],
	example = ('[CurDruidMP] => "%d"'):format(UnitManaMax("player")*.632),
	category = L["Druid"],
})

DogTag:AddTag("MaxDruidMP", {
	function(data)
		if not DruidMana then
			return [[]]
		else
			return [[if ${unit} == "player" then
				value = LibDruidMana:GetMaximumMana()
			end]], 'globals', "LibDruidMana-1.0"
		end
	end,
	ret = "number;nil",
	events = "DruidMana",
	doc = L["Return the maximum mana of unit if unit is you and you are a druid"],
	example = ('[MaxDruidMP] => "%d"'):format(UnitManaMax("player")),
	category = L["Druid"],
})

DogTag:AddTag("PercentDruidMP", {
	alias = "[CurDruidMP / MaxDruidMP * 100]:Round(1)",
	ret = "number;nil",
	events = "DruidMana",
	globals = "math.floor",
	doc = L["Return the percentage mana of unit if unit is you and you are a druid"],
	example = '[PercentDruidMP] => "63.2"; [PercentDruidMP:Percent] => "63.2%"',
	category = L["Druid"],
})

DogTag:AddTag("MissingDruidMP", {
	alias = "MaxDruidMP - CurDruidMP",
	doc = L["Return the missing mana of unit if unit is you and you are a druid"],
	example = ('[MissingDruidMP] => "%d"'):format(UnitManaMax("player")*.368),
	category = L["Druid"]
})

DogTag:AddTag("FractionalDruidMP", {
	alias = "Text([CurDruidMP]/[MaxDruidMP])",
	doc = L["Return the current and maximum mana of unit if unit is you and you are a druid"],
	example = ('[FractionalDruidMP] => "%d/%d"'):format(UnitManaMax("player")*.632, UnitManaMax("player")),
	category = L["Druid"]
})

DogTag:AddTag("IsMaxDruidMP", {
	alias = "CurDruidMP = MaxDruidMP",
	doc = L["Return the max mana of unit if at max mana, unit is you, and you are a druid"],
	example = ('[IsMaxDruidMP] => %q; [IsMaxDruidMP] => ""'):format(UnitManaMax("player")),
	category = L["Druid"]
})


end