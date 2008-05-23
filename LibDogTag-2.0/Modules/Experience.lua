local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

DogTag:AddTag("CurXP", {
	[[if ${unit} == "pet" then
		value = GetPetExperience()
	else
	 	value = UnitXP(${unit})
	end]],
	ret = "number",
	events = "UNIT_PET_EXPERIENCE;PLAYER_XP_UPDATE",
	globals = "GetPetExperience;UnitXP",
	doc = L["Return the current experience of unit"],
	example = '[CurXP] => "8540"',
	category = L["Experience"]
})

DogTag:AddTag("MaxXP", {
	[[if ${unit} == "pet" then
		local _,max = GetPetExperience()
		value = max
	else
	 	value = UnitXPMax(${unit})
	end]],
	ret = "number",
	events = "UNIT_PET_EXPERIENCE;PLAYER_XP_UPDATE",
	globals = "GetPetExperience;UnitXP",
	doc = L["Return the maximum experience of unit"],
	example = '[MaxXP] => "10000"',
	category = L["Experience"]
})

DogTag:AddTag("FractionalXP", {
	[[local cur, max
	if ${unit} == "pet" then
		cur, max = GetPetExperience()
	else
	 	cur, max = UnitXP(${unit}), UnitXPMax(${unit})
	end
	value = cur .. '/' .. max]],
	fakeAlias = "Text([CurXP]/[MaxXP])",
	ret = "string",
	events = "UNIT_PET_EXPERIENCE;PLAYER_XP_UPDATE",
	globals = "GetPetExperience;UnitXP;UnitXPMax",
	doc = L["Return the current and maximum experience of unit"],
	example = '[FractionalXP] => "8540/10000"',
	category = L["Experience"]
})

DogTag:AddTag("PercentXP", {
	[[if ${unit} == "pet" then
		local cur, max = GetPetExperience()
		if max > 0 then
			value = math_floor(1000 * cur/max + 0.5) / 10
		else
			value = 0
		end
	else
	 	local max = UnitXPMax(${unit})
		if max > 0 then
			local cur = UnitXP(${unit})
			value = math_floor(1000 * cur/max + 0.5) / 10
		else
			value = 0
		end
	end]],
	fakeAlias = "[CurXP / MaxXP * 100]:Round(1)",
	ret = "number",
	events = "UNIT_PET_EXPERIENCE;PLAYER_XP_UPDATE",
	globals = "GetPetExperience;UnitXP;math.floor",
	doc = L["Return the percentage experience of unit"],
	example = '[PercentXP] => "85.4"; [PercentXP:Percent] => "85.4%"',
	category = L["Experience"]
})

DogTag:AddTag("MissingXP", {
	[[if ${unit} == "pet" then
		local cur, max = GetPetExperience()
		value = max - cur
	else
	 	value = UnitXPMax(${unit}) - UnitXP(${unit})
	end]],
	fakeAlias = "MaxXP - CurXP",
	ret = "number",
	events = "UNIT_PET_EXPERIENCE;PLAYER_XP_UPDATE",
	globals = "GetPetExperience;UnitXPMax;UnitXP",
	doc = L["Return the missing experience of unit"],
	example = '[MissingXP] => "1460"',
	category = L["Experience"]
})

DogTag:AddTag("RestXP", {
	[[value = UnitIsUnit(${unit}, "player") and GetXPExhaustion() or 0]],
	ret = "number",
	events = "PLAYER_XP_UPDATE",
	globals = "UnitIsUnit;GetXPExhaustion",
	doc = L["Return the accumulated rest experience of unit"],
	example = '[RestXP] => "5000"',
	category = L["Experience"]
})

DogTag:AddTag("PercentRestXP", {
	[[local max = UnitXPMax(${unit})
	if max > 0 then
		local rest = UnitIsUnit(${unit}, "player") and GetXPExhaustion() or 0
		value = math_floor(1000 * rest/max + 0.5) / 10
	else
		value = 0
	end]],
	fakeAlias = "[RestXP / MaxXP * 100]:Round(1)",
	ret = "number",
	events = "PLAYER_XP_UPDATE",
	globals = "UnitIsUnit;GetXPExhaustion;UnitXPMax;math.floor",
	doc = L["Return the percentage accumulated rest experience of unit"],
	example = '[PercentRestXP] => "50"; [PercentRestXP:Percent] => "50%"',
	category = L["Experience"]
})

end
