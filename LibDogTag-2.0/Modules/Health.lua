local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

local LibMobHealth, MobHealth3, MobHealth_PPP
DogTag:AddAddonFinder("LibStub", "LibMobHealth-4.0", function(v) LibMobHealth = v end)
DogTag:AddAddonFinder("_G", "MobHealth3", function(v) MobHealth3 = v end)
DogTag:AddAddonFinder("_G", "MobHealth_PPP", function(v) MobHealth_PPP = v end)

DogTag:AddTag("CurHP", {
	function(data)
		if LibMobHealth then
			return [[value = LibMobHealth:GetUnitCurrentHP(${unit})]], 'globals', 'LibMobHealth-4.0'
		elseif MobHealth3 then
			return [[local currValue = UnitHealth(${unit})
			if currValue == 0 then
				value = 0
			else
				if not UnitIsFriend("player", ${unit}) then
					local maxValue = UnitHealthMax(${unit})
					local curr, max, MHfound = MobHealth3:GetUnitHealth(${unit}, currValue, maxValue)
					if MHfound then
						value = curr
					end
				end
				if not value then
					value = currValue
				end
			end]], 'globals', 'UnitHealth;MobHealth3;UnitIsFriend;UnitHealthMax'
		elseif MobHealth_PPP then
			return [[local currValue = UnitHealth(${unit})
			if currValue == 0 then
				value = 0
			else
				if not UnitIsFriend("player", ${unit}) then
					local name = UnitName(${unit})
					local level = UnitLevel(${unit})
					local ppp = MobHealth_PPP(name..":"..level)
					if ppp > 0 then
						value = math_floor(currValue * ppp + 0.5)
					end
				end
				if not value then
					value = currValue
				end
			end]], 'globals', 'UnitHealth;UnitIsFriend;UnitName;UnitLevel;MobHealth_PPP;math.floor'
		else
			return [[value = UnitHealth(${unit})]], 'globals', 'UnitHealth'
		end
	end,
	ret = "number",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	doc = L["Return the current health of unit, will use MobHealth if found"],
	example = ('[CurHP] => "%d"'):format(UnitHealthMax("player")*.758),
	category = L["Health"]
})

DogTag:AddTag("MaxHP", {
	function(data)
		if LibMobHealth then
			return [[value = LibMobHealth:GetUnitMaxHP(${unit})]], 'globals', 'LibMobHealth-4.0'
		elseif MobHealth3 then
			return [[local maxValue = UnitHealthMax(${unit})
			if maxValue == 0 then
				value = 0
			else
				if not UnitIsFriend("player", ${unit}) then
					local curr, max, MHfound = MobHealth3:GetUnitHealth(${unit}, 1, maxValue)
					if MHfound then
						value = max
					end
				end
				if not value then
					value = maxValue
				end
			end]], 'globals', "UnitHealthMax;UnitIsFriend;MobHealth3"
		elseif MobHealth_PPP then
			return [[if not UnitIsFriend("player", ${unit}) then
				local name = UnitName(${unit})
				local level = UnitLevel(${unit})
				local ppp = MobHealth_PPP(name..":"..level)
				if ppp > 0 then
					value = math_floor(100 * ppp + 0.5)
				end
			end
			if not value then
				value = UnitHealthMax(${unit})
			end]], 'globals', "UnitIsFriend;UnitName;UnitLevel;MobHealth_PPP;math.floor;UnitHealthMax"
		else
			return [[value = UnitHealthMax(${unit})]], 'globals', "UnitHealthMax"
		end
	end,
	ret = "number",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	doc = L["Return the maximum health of unit, will use MobHealth if found"],
	example = ('[MaxHP] => "%d"'):format(UnitHealthMax("player")),
	category = L["Health"]
})

DogTag:AddTag("PercentHP", {
	[[value = math.floor(UnitHealth(${unit})/UnitHealthMax(${unit}) * 1000+0.5) / 10]],
	fakeAlias = "[CurHP / MaxHP * 100]:Round(1)",
	ret = "number",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	globals = "UnitHealth;UnitHealthMax;math.floor",
	doc = L["Return the percentage health of unit"],
	example = '[PercentHP] => "75.8"; [PercentHP:Percent] => "75.8%"',
	category = L["Health"]
})

DogTag:AddTag("MissingHP", {
	function(data)
		if LibMobHealth then
			return [[local cur, max = LibMobHealth:GetUnitHealth(${unit})
			value = max - cur]], 'globals', 'LibMobHealth-4.0'
		elseif MobHealth3 then
			return [[local maxValue = UnitHealthMax(${unit})
			if maxValue == 0 then
				value = 0
			else
				local currValue = UnitHealth(${unit})
				if not UnitIsFriend("player", ${unit}) then
					local curr, max, MHfound = MobHealth3:GetUnitHealth(${unit}, currValue, maxValue)
					if MHfound then
						value = max - curr
					end
				end
				if not value then
					value = maxValue - currValue
				end
			end]], 'globals', "UnitHealthMax;UnitHealth;UnitIsFriend;MobHealth3"
		elseif MobHealth_PPP then
			return [[local currValue = UnitHealth(${unit})
			if currValue == 0 then
				value = 0
			else
				if not UnitIsFriend("player", ${unit}) then
					local name = UnitName(${unit})
					local level = UnitLevel(${unit})
					local ppp = MobHealth_PPP(name..":"..level)
					if ppp > 0 then
						value = math_floor((100 - currValue) * ppp + 0.5)
					end
				end
				if not value then
					value = UnitHealthMax(${unit}) - currValue
				end
			end]], "UnitHealth;UnitIsFriend;UnitName;UnitLevel;MobHealth_PPP;math.floor;UnitHealthMax"
		else
			return [[value = UnitHealthMax(${unit}) - UnitHealth(${unit})]], 'globals', "UnitHealthMax;UnitHealth"
		end
	end,
	fakeAlias = "MaxHP - CurHP",
	ret = "number",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	doc = L["Return the missing health of unit, will use MobHealth if found"],
	example = ('[MissingHP] => "%d"'):format(UnitHealthMax("player")*.242),
	category = L["Health"]
})

DogTag:AddTag("FractionalHP", {
	function(data)
		if LibMobHealth then
			return [[local cur, max = LibMobHealth:GetUnitHealth(${unit})
			value = cur .. "/" .. max]], 'globals', 'LibMobHealth-4.0'
		elseif MobHealth3 then
			return [[local maxValue = UnitHealthMax(${unit})
			if maxValue == 0 then
				value = "0/0"
			else
				local currValue = UnitHealth(${unit})
				if maxValue == 100 and not UnitIsFriend("player", ${unit}) then
					local curr, max, MHfound = MobHealth3:GetUnitHealth(${unit}, currValue, maxValue)
					if MHfound then
						value = curr.."/"..max
					end
				end
				if not value then
					value = currValue.."/"..maxValue
				end
			end]], 'globals', "UnitHealthMax;UnitHealth;MobHealth3;UnitIsFriend"
		elseif MobHealth_PPP then
			return [[local currValue = UnitHealth(${unit})
			if not UnitIsFriend("player", ${unit}) then
				local name = UnitName(${unit})
				local level = UnitLevel(${unit})
				local ppp = MobHealth_PPP(name..":"..level)
				if ppp > 0 then
					value = math_floor(currValue * ppp + 0.5) .. "/" .. math_floor(100 * ppp + 0.5)
				end
			end
			if not value then
				value = currValue .. "/" .. UnitHealthMax(${unit})
			end]], 'globals', "UnitHealth;UnitIsFriend;UnitName;UnitLevel;MobHealth_PPP;math.floor;UnitHealthMax"
		else
			return [[value = UnitHealth(${unit}).."/"..UnitHealthMax(${unit})]], 'globals', "UnitHealth;UnitHealthMax"
		end
	end,
	fakeAlias = "Text([CurHP]/[MaxHP])",
	ret = "string",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	doc = L["Return the current health and maximum health of unit, will use MobHealth if found"],
	example = ('[FractionalHP] => "%d/%d"'):format(UnitHealthMax("player")*.758, UnitHealthMax("player")),
	category = L["Health"]
})

DogTag:AddTag("SureHP", {
	function(data)
		if LibMobHealth then
			return [[local cur, max, sure = LibMobHealth:GetUnitHealth(${unit})
			if sure then
				value = cur .. "/" .. max
			end]], 'globals', 'LibMobHealth-4.0'
		elseif MobHealth3 then
			return [[local maxValue = UnitHealthMax(${unit})
			if maxValue ~= 0 then
				if maxValue ~= 100 then
					value = UnitHealth(${unit}).."/"..maxValue
				elseif not UnitIsFriend("player", ${unit}) then
					local curr, max, MHfound = MobHealth3:GetUnitHealth(${unit}, UnitHealth(${unit}), maxValue)
					if MHfound then
						value = curr.."/"..max
					end
				end
			end]], 'globals', "UnitHealthMax;UnitHealth;MobHealth3;UnitIsFriend"
		elseif MobHealth_PPP then
			return [[if not UnitIsFriend("player", ${unit}) then
				local name = UnitName(${unit})
				local level = UnitLevel(${unit})
				local ppp = MobHealth_PPP(name..":"..level)
				if ppp > 0 then
					value = math_floor(UnitHealth(${unit}) * ppp + 0.5) .. "/" .. math_floor(100 * ppp + 0.5)
				end
			else
				local maxValue = UnitHealthMax(${unit})
				if maxValue ~= 100 then
					value = UnitHealth(${unit}).."/"..maxValue
				end
			end]], 'globals', "UnitIsFriend;UnitName;UnitLevel;MobHealth_PPP;UnitHealth;math.floor;UnitHealthMax"
		else
			return [[local maxValue = UnitHealthMax(${unit})
			if maxValue ~= 0 and maxValue ~= 100 then
				value = UnitHealth(${unit}).."/"..maxValue
			end]], 'globals', "UnitHealthMax;UnitHealth"
		end
	end,
	ret = "string;nil",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	doc = L["Return the current and maximum health of unit, but only if properly found through MobHealth"],
	example = ('[SureHP] => "%d/%d"; [SureHP] => ""'):format(UnitHealthMax("player")*.758,
	UnitHealthMax("player")),
	category = L["Health"]
})

DogTag:AddTag("SmartHP", {
	alias = "SureHP || PercentHP:Percent",
	doc = L["Return the current and maximum health of unit, but only if properly found through MobHealth, otherwise show the percentage health"],
	example = ('[SureHP] => "%d/%d"; [SureHP] => "75.8%%"'):format(UnitHealthMax("player")*.758, UnitHealthMax("player")),
	category = L["Health"]
})

DogTag:AddTag("IsMaxHP", {
	([[value = UnitHealth(${unit}) == UnitHealthMax(${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	globals = "UnitHealthMax;UnitHealth",
	doc = L["Return True if unit is at full health"],
	example = ('[IsMaxHP] => %q; [IsMaxHP] => ""'):format(L["True"]),
	category = L["Health"]
})

DogTag:AddTagAndModifier("HPColor", {
	function(data)
		return [[local perc = UnitHealth(${unit}) / UnitHealthMax(${unit})
		local r1, g1, b1
		local r2, g2, b2
		if perc <= 0.5 then
			perc = perc * 2
			r1, g1, b1 = unpack(colors.minHP)
			r2, g2, b2 = unpack(colors.midHP)
		else
			perc = perc * 2 - 1
			r1, g1, b1 = unpack(colors.midHP)
			r2, g2, b2 = unpack(colors.maxHP)
		end
		local r, g, b = r1 + (r2-r1)*perc, g1 + (g2-g1)*perc, b1 + (b2-b1)*perc
		]] .. (data.isMod and [[
		value = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		]] or [[
		value = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		]])
	end,
	value = "number;string",
	ret = "string",
	events = "UNIT_HEALTH;UNIT_MAXHEALTH",
	globals = "UnitHealth;UnitHealthMax;unpack",
	doc = L["Return the color or wrap value with the health color of unit"],
	example = '[Text(Hello):HPColor] => "|cffff7f00Hello|r"; [Text([HPColor]Hello)] => "|cffff7f00Hello"',
	category = L["Health"]
})

DogTag:AddTag("SmartMissingHP", "MissingHP:HideZero:Negate")

end