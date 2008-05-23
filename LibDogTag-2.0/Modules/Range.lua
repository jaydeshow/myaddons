local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 60184 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

local RangeCheck
DogTag:AddAddonFinder("AceLibrary", "RangeCheck-1.0", function(v) RangeCheck = v end)

DogTag:AddTag("Range", {
	alias = "IsVisible ? ~DeadType ? Text([MinRange][MaxRange:Prepend( - ) || Text(+)])",
	doc = L["Return the approximate range of unit, if RangeCheck-1.0 is available"],
	example = '[Range] => "5 - 15"; [Range] => "30+"; [Range] => ""',
	category = L["Status"]
})

DogTag:AddTag("MinRange", {
	function(data)
		if not RangeCheck then
			return [[]]
		else
			return [[value = RangeCheckLib:getRange(${unit})]], 'globals', "RangeCheck-1.0", 'events', "Update"
		end
	end,
	ret = "number;nil",
	doc = L["Return the approximate minimum range of unit, if RangeCheck-1.0 is available"],
	example = '[MinRange] => "5"; [MinRange] => ""',
	category = L["Status"]
})

DogTag:AddTag("MaxRange", {
	function(data)
		if not RangeCheck then
			return [[]]
		else
			return [[local _
			_, value = RangeCheckLib:getRange(${unit})]], 'globals', "RangeCheck-1.0", 'events', "Update"
		end
	end,
	ret = "number;nil",
	doc = L["Return the approximate maximum range of unit, if RangeCheck-1.0 is available"],
	example = '[MaxRange] => "15"; [MaxRange] => ""',
	category = L["Status"]
})

end