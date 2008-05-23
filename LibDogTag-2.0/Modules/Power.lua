local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

DogTag:AddTag("CurMP", {
	[[value = UnitMana(${unit})]],
	ret = "number",
	events = "UNIT_MANA;UNIT_RAGE;UNIT_FOCUS;UNIT_ENERGY;UNIT_MAXMANA;UNIT_MAXRAGE;UNIT_MAXFOCUS;UNIT_MAXENERGY;UNIT_DISPLAYPOWER",
	globals = "UnitMana",
	doc = L["Return the current mana/rage/energy of unit"],
	example = ('[CurMP] => "%d"'):format(UnitManaMax("player")*.632),
	category = L["Power"]
})

DogTag:AddTag("MaxMP", {
	[[value = UnitManaMax(${unit})]],
	ret = "number",
	events = "UNIT_MANA;UNIT_RAGE;UNIT_FOCUS;UNIT_ENERGY;UNIT_MAXMANA;UNIT_MAXRAGE;UNIT_MAXFOCUS;UNIT_MAXENERGY;UNIT_DISPLAYPOWER",
	globals = "UnitManaMax",
	doc = L["Return the maximum mana/rage/energy of unit"],
	example = ('[MaxMP] => "%d"'):format(UnitManaMax("player")),
	category = L["Power"]
})

DogTag:AddTag("PercentMP", {
	alias = "[CurMP / MaxMP * 100]:Round(1)",
	doc = L["Return the percentage mana/rage/energy of unit"],
	example = '[PercentMP] => "63.2"; [PercentMP:Percent] => "63.2%"',
	category = L["Power"]
})

DogTag:AddTag("MissingMP", {
	alias = "MaxMP - CurMP",
	doc = L["Return the missing mana/rage/energy of unit"],
	example = ('[MissingMP] => "%d"'):format(UnitManaMax("player")*.368),
	category = L["Power"]
})

DogTag:AddTag("FractionalMP", {
	alias = "Text([CurMP]/[MaxMP])",
	doc = L["Return the current and maximum mana/rage/energy of unit"],
	example = ('[FractionalMP] => "%d/%d"'):format(UnitManaMax("player")*.632, UnitManaMax("player")),
	category = L["Power"]
})

DogTag:AddTag("TypePower", {
	([[local p = UnitPowerType(${unit})
	if p == 1 then
		value = %q
	elseif p == 2 then
		value = %q
	elseif p == 3 then
		value = %q
	else
		value = %q
	end]]):format(L["Rage"], L["Focus"], L["Energy"], L["Mana"]),
	ret = "string",
	events = "UNIT_DISPLAYPOWER",
	globals = "UnitPowerType",
	doc = L["Return whether unit currently uses Rage, Focus, Energy, or Mana"],
	example = ('[TypePower] => %q; [TypePower] => %q'):format(L["Rage"], L["Mana"]),
	category = L["Power"]
})

DogTag:AddTag("IsPowerType", {
	function(data)
		local arg = data.arg:lower()
		if arg == "rage" then
			return ([[value = UnitPowerType(${unit}) == 1 and %q]]):format(L["Rage"])
		elseif arg == "focus" then
			return ([[value = UnitPowerType(${unit}) == 2 and %q]]):format(L["Focus"])
		elseif arg == "energy" then
			return ([[value = UnitPowerType(${unit}) == 3 and %q]]):format(L["Energy"])
		elseif arg == "mana" then
			return ([[value = UnitPowerType(${unit}) == 0 and %q]]):format(L["Mana"])
		elseif arg:find("%[") and arg:find("%]") then
			return ([[
				local arg = (${arg}):lower()
				if arg == "rage" then
					value = UnitPowerType(${unit}) == 1 and %q
				elseif arg == "focus" then
					value = UnitPowerType(${unit}) == 2 and %q
				elseif arg == "energy" then
					value = UnitPowerType(${unit}) == 3 and %q
				elseif arg == "mana" then
					value = UnitPowerType(${unit}) == 0 and %q
				end
			]]):format(L["Rage"], L["Focus"], L["Energy"], L["Mana"])
		else
			return [[value = nil]]
		end
	end,
	arg = "string",
	ret = "nil;string",
	events = "UNIT_DISPLAYPOWER",
	globals = "UnitPowerType",
	doc = L["Return True if unit currently uses the power of argument"],
	example = ('[HasPower(Rage)] => %q; [HasPower(Energy)] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("IsRage", {
	alias = "IsPowerType(Rage)",
	doc = L["Return True if unit currently uses rage"],
	example = ('[IsRage] => %q; [IsRage] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("IsFocus", {
	alias = "IsPowerType(Focus)",
	doc = L["Return True if unit currently uses focus"],
	example = ('[IsFocus] => %q; [IsFocus] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("IsEnergy", {
	alias = "IsPowerType(Energy)",
	doc = L["Return True if unit currently uses energy"],
	example = ('[IsEnergy] => %q; [IsEnergy] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("IsMana", {
	alias = "IsPowerType(Mana)",
	doc = L["Return True if unit currently uses mana"],
	example = ('[IsMana] => %q; [IsMana] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("IsMaxMP", {
	([[value = UnitMana(${unit}) == UnitManaMax(${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "UNIT_MANA;UNIT_RAGE;UNIT_FOCUS;UNIT_ENERGY;UNIT_MAXMANA;UNIT_MAXRAGE;UNIT_MAXFOCUS;UNIT_MAXENERGY;UNIT_DISPLAYPOWER",
	globals = "UnitMana;UnitManaMax",
	doc = L["Return True if unit is at full rage/mana/energy"],
	example = ('[IsMaxMP] => %q; [IsMaxMP] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTag("HasNoMP", {
	([[value = UnitManaMax(${unit}) == 0 and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "UNIT_MANA;UNIT_RAGE;UNIT_FOCUS;UNIT_ENERGY;UNIT_MAXMANA;UNIT_MAXRAGE;UNIT_MAXFOCUS;UNIT_MAXENERGY;UNIT_DISPLAYPOWER",
	globals = "UnitManaMax",
	doc = L["Return True if unit has no power type at all"],
	example = ('[HasNoMP] => %q; [HasNoMP] => ""'):format(L["True"]),
	category = L["Power"]
})

DogTag:AddTagAndModifier("PowerColor", {
	function(data)
		return [[do
			local powerType = UnitPowerType(${unit})
			local r,g,b
			if powerType == 0 then
				r,g,b = unpack(colors.mana)
			elseif powerType == 1 then
				r,g,b = unpack(colors.rage)
			elseif powerType == 2 then
				r,g,b = unpack(colors.focus)
			elseif powerType == 3 then
				r,g,b = unpack(colors.energy)
			else
				r,g,b = unpack(colors.unknown)
			end
		]] .. (data.isMod and [[
			value = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		]] or [[
			value = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		]]) .. [[
		end]]
	end,
	value = "number;string",
	ret = "string",
	events = "UNIT_DISPLAYPOWER",
	globals = "unpack;UnitPowerType",
	doc = L["Return the color or wrap value with current power color of unit, whether rage, mana, or energy"],
	example = '[Text(Hello):PowerColor] => "|cff3071bfHello|r"; [Text([PowerColor]Hello)] => "|cff3071bfHello"',
	category = L["Power"]
})

end
