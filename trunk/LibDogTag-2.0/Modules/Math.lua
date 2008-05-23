local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

DogTag:AddModifier("Negate", {
	alias = "Mult(-1)",
	doc = L["Turn positive number_value into negative or vice-versa"],
	example = '[50:Negate] => "-50"; [0:Negate] => "0"; [Text(-50):Negate] => "50"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Round", {
	function(data)
		if type(data.arg) ~= "string" then
			local arg = math.floor((data.arg or 0) + 0.5)
			if arg == 0 then
				return [[value = math_floor(value + 0.5)]]
			else
				return [[value = math_floor(value * (10^]] .. arg .. [[) + 0.5) / (10^]] .. arg .. [[)]]
			end
		else -- dynamic
			return [[value = math_floor(value * (10^${arg}) + 0.5) / (10^${arg})]]
		end
	end,
	arg = "nil;number",
	value = "number",
	ret = "number",
	globals = "math.floor",
	doc = L["Round number_value to the one's place or the place specified by number"],
	example = '[1234.5:Round] => "1235"; [1234:round(-2)] => "1200"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Add", {
	[[value = value + ${arg}]],
	arg = "number",
	value = "number",
	ret = "number",
	doc = L["Add number to number_value"],
	example = '[100:Add(50)] => "150"; [100+50] => "150"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Sub", {
	[[value = value - ${arg}]],
	arg = "number",
	value = "number",
	ret = "number",
	doc = L["Subtract number from number_value"],
	example = '[100:Sub(25)] => "75"; [100-25] => "75"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Mult", {
	function(data)
		if data.arg == 1 then
			return [[]]
		elseif data.arg == -1 then
			return [[if value ~= 0 then
				value = -value
			end]]
		end
		return [[if value ~= 0 then
			value = value * ${arg}
		end]]
	end,
	arg = "number",
	value = "number",
	ret = "number",
	doc = L["Multiply number_value by number"],
	example = '[10:Mult(25)] => "250"; [10*25] => "250"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Div", {
	function(data)
		if data.arg == 1 then
			return [[]]
		elseif data.arg == -1 then
			return [[if value ~= 0 then
				value = -value
			end]]
		end
		return [[if value ~= 0 then
			value = value / ${arg}
		end]]
	end,
	arg = "number",
	value = "number",
	ret = "number",
	doc = L["Divide number_value by number"],
	example = '[75:Div(50)] => "1.5"; [75/50] => "1.5"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Pow", {
	[[value = value ^ ${arg}]],
	arg = "number",
	value = "number",
	ret = "number",
	doc = L["Raise number_value to the power of number"],
	example = '[2:Pow(4)] => "16"; [2^4] => "16"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Mod", {
	[[value = value % ${arg}]],
	arg = "number",
	value = "number",
	ret = "number",
	doc = L["Return number_value modulo number"],
	example = '[15:Mod(4)] => "3"; [15%4] => "3"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Floor", {
	[[value = math_floor(value)]],
	value = "number",
	ret = "number",
	globals = "math.floor",
	doc = L["Take the floor of number_value"],
	example = '[9.876:Floor] => "9"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Ceil", {
	[[value = math_ceil(value)]],
	value = "number",
	ret = "number",
	globals = "math.ceil",
	doc = L["Take the ceiling of number_value"],
	example = '[1.234:Ceil] => "2"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Abs", {
	[[value = math_abs(value)]],
	value = "number",
	ret = "number",
	globals = "math.abs",
	doc = L["Take the absolute value of number_value"],
	example = '[5:Abs] => "5"; [-5:Abs] => "5"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Sign", {
	[[if value < 0 then
		value = -1
	elseif value == 0 then
		value = 0
	else
		value = 1
	end]],
	value = "number",
	ret = "number",
	doc = L["Take the signum of number_value"],
	example = '[5:Sign] => "1"; [-5:Sign] => "-1"; [0:Sign] => "0"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Max", {
	[[value = math_max(value, ${arg})]],
	value = "number",
	ret = "number",
	arg = "number",
	globals = "math.max",
	doc = L["Return the greater of number_value and number"],
	example = '[1:Max(2)] => "2"; [1:Max(0)] => "1"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Min", {
	[[value = math_min(value, ${arg})]],
	value = "number",
	ret = "number",
	arg = "number",
	globals = "math.min",
	doc = L["Return the lesser of number_value and number"],
	example = '[1:Max(2)] => "1"; [1:Max(0)] => "0"',
	category = L["Mathematics"]
})

DogTag:AddTag("Pi", {
	([[value = %.52f]]):format(math.pi),
	ret = "number",
	doc = (L["Return the mathematical number π, or %s"]):format(math.pi),
	example = ('[Pi] => "%s"'):format(math.pi),
	category = L["Mathematics"]
})

DogTag:AddModifier("Deg", {
	[[value = math_deg(value)]],
	fakeAlias = "Mult(180):Div([Pi])",
	value = "number",
	ret = "number",
	globals = "math.deg",
	doc = L["Convert the radian number_value into degrees"],
	example = '[0:Deg] => "0"; [Pi:Deg] => "180"; [[Pi/2]:Deg] => "90"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Rad", {
	[[value = math_rad(value)]],
	fakeAlias = "Div(180):Mult([Pi])",
	value = "number",
	ret = "number",
	globals = "math.rad",
	doc = L["Convert the degree number_value into radians"],
	example = ('[0:Rad] => "0"; [180:Rad] => "%s"; [90:Rad] => "%s"'):format(math.pi, math.pi/2),
	category = L["Mathematics"]
})

DogTag:AddModifier("Cos", {
	[[value = math_cos(value)]],
	value = "number",
	ret = "number",
	globals = "math.cos",
	doc = L["Return the cosine of the radian number_value"],
	example = ('[0:Cos] => "1"; [[Pi/4]:Cos] => "%s"; [[Pi/2]:Cos] => "0"'):format(math.cos(math.pi/4)),
	category = L["Mathematics"]
})

DogTag:AddModifier("Sin", {
	[[value = math_sin(value)]],
	value = "number",
	ret = "number",
	globals = "math.sin",
	doc = L["Return the sine of the radian number_value"],
	example = ('[0:Sin] => "0"; [[Pi/4]:Sin] => "%s"; [[Pi/2]:Sin] => "1"'):format(math.cos(math.pi/4)),
	category = L["Mathematics"]
})

DogTag:AddTag("E", {
	([[value = %.52f]]):format(math.exp(1)),
	ret = "number",
	doc = (L["Return the mathematical number e, or %s"]):format(math.exp(1)),
	example = ('[E] => "%s"'):format(math.exp(1)),
	category = L["Mathematics"]
})

DogTag:AddModifier("Ln", {
	[[value = math_log(value)]],
	value = "number",
	ret = "number",
	globals = "math.log",
	doc = L["Return the natural log of number_value"],
	example = '[1:Ln] => "0"; [E:Ln] => "1"; [[E^2]:Ln] => "2"',
	category = L["Mathematics"]
})

DogTag:AddModifier("Log", {
	[[value = math_log10(value)]],
	value = "number",
	ret = "number",
	globals = "math.log10",
	doc = L["Return the log base 10 of number_value"],
	example = '[1:Ln] => "0"; [10:Ln] => "1"; [100:Ln] => "2"',
	category = L["Mathematics"]
})

end
