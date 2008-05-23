local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

local newList, del = DogTag.newList, DogTag.del

DogTag:AddModifier("Prepend", {
	[[value = ${arg} .. value]],
	value = "number;string",
	arg = "string", ret = "string",
	doc = L["Prepend argument to the beginning of value"],
	example = '[Text(llo):Prepend(He)] => "Hello"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Append", {
	[[value = value .. ${arg}]],
	value = "number;string",
	arg = "string", ret = "string",
	doc = L["Append argument to the end of value"],
	example = '[Text(Hel):Append(lo)] => "Hello"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Percent", {
	[[value = value .. '%']],
	value = "number",
	ret = "string",
	doc = L["Append a percentage sign to the end of number_value"],
	example = '[50:Percent] => "50%"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Short", {
	[[if type(value) ~= "number" then
		local a,b = value:match("^(%d+)/(%d+)")
		if a then
			a, b = tonumber(a), tonumber(b)
			if b >= 10000000 or b <= -10000000 then
				b = ("%.1fm"):format(b / 1000000)
			elseif b >= 1000000 or b <= -1000000 then
				b = ("%.2fm"):format(b / 1000000)
			elseif b >= 100000 or b <= -100000 then
				b = ("%.0fk"):format(b / 1000)
			elseif b >= 10000 or b <= -10000 then
				b = ("%.1fk"):format(b / 1000)
			end
			if a >= 10000000 or a <= -10000000 then
				a = ("%.1fm"):format(a / 1000000)
			elseif a >= 1000000 or a <= -1000000 then
				a = ("%.2fm"):format(a / 1000000)
			elseif a >= 100000 or a <= -100000 then
				a = ("%.0fk"):format(a / 1000)
			elseif a >= 10000 or a <= -10000 then
				a = ("%.1fk"):format(a / 1000)
			end
			value = a.."/"..b
		end
	else
		if value >= 10000000 or value <= -10000000 then
			value = ("%.1fm"):format(value / 1000000)
		elseif value >= 1000000 or value <= -1000000 then
			value = ("%.2fm"):format(value / 1000000)
		elseif value >= 100000 or value <= -100000 then
			value = ("%.0fk"):format(value / 1000)
		elseif value >= 10000 or value <= -10000 then
			value = ("%.1fk"):format(value / 1000)
		else
			value = math_floor(value+0.5)
		end
	end]],
	value = "number;string",
	ret = "same;nil",
	globals = "math.floor",
	doc = L["Shorten value to have at maximum 3 decimal places showing"],
	example = '[1234:Short] => "1.23k"; [12345678:Short] => "12.3m"; [Text(1234/2345):Short] => "1.23k/2.35k"',
	category = L["Text manipulation"],
})

DogTag:AddModifier("VeryShort", {
	[[if type(value) ~= "number" then
		local a,b = value:match("^(%d+)/(%d+)")
		if a then
			a, b = tonumber(a), tonumber(b)
			if b >= 1000000 or b <= -1000000 then
				b = ("%.0fm"):format(b / 1000000)
			elseif b >= 1000 or b <= -1000 then
				b = ("%.0fk"):format(b / 1000)
			end
			if a >= 1000000 or a <= -1000000 then
				a = ("%.0fm"):format(a / 1000000)
			elseif a >= 1000 or a <= -1000 then
				a = ("%.0fk"):format(a / 1000)
			end
			value = a.."/"..b
		end
	else
		if value >= 1000000 or value <= -1000000 then
			value = ("%.0fm"):format(value / 1000000)
		elseif value >= 1000 or value <= -1000 then
			value = ("%.0fk"):format(value / 1000)
		else
			value = math_floor(value+0.5)
		end
	end]],
	value = "number;string",
	ret = "same;nil",
	globals = "math.floor",
	doc = L["Shorten value to its closest denomination"],
	example = '[1234:VeryShort] => "1k"; [123456:VeryShort] => "123k"; [Text(12345/23456):VeryShort] => "12k/23k"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Upper", {
	[[value = value:upper()]],
	value = "string",
	ret = "string",
	doc = L["Turn value into an uppercase string"],
	example = '[Text(Hello):Upper] => "HELLO"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Lower", {
	[[value = value:lower()]],
	value = "string",
	ret = "string",
	doc = L["Turn value into a lowercase string"],
	example = '[Text(Hello):Lower] => "hello"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Bracket", {
	[[value = '[' .. value .. ']']],
	value = "number;string",
	ret = "string",
	doc = L["Wrap value with square brackets"],
	example = '[Text(Hello):Bracket] => "[Hello]"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Angle", {
	[[value = '<' .. value .. '>']],
	value = "number;string",
	ret = "string",
	doc = L["Wrap value with angle brackets"],
	example = '[Text(Hello):Bracket] => "<Hello>"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Brace", {
	[[value = '{' .. value .. '}']],
	value = "number;string",
	ret = "string",
	doc = L["Wrap value with braces"],
	example = '[Text(Hello):Bracket] => "{Hello}"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Paren", {
	[[value = '(' .. value .. ')']],
	value = "number;string",
	ret = "string",
	doc = L["Wrap value with parentheses"],
	example = '[Text(Hello):Paren] => "(Hello)"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Trunc", {
	[[local len = 0
	for i = 1, ${arg} do
		local b = value:byte(len+1)
		if not b then
			break
		elseif b <= 127 then
			len = len + 1
		elseif b <= 223 then
			len = len + 2
		elseif b <= 239 then
			len = len + 3
		else
			len = len + 4
		end
	end
	value = value:sub(1, len)]],
	arg = "number",
	value = "string",
	ret = "string",
	doc = L["Truncate value to the length specified by number"],
	example = '[Text(Hello):Trunc(3)] => "Hel"',
	category = L["Abbreviations"]
})

DogTag:AddModifier("TruncEllipsis", {
	[[local len = 0
	local shortened = true
	for i = 1, ${arg} do
		local b = value:byte(len+1)
		if not b then
			shortened = false
			break
		elseif b <= 127 then
			len = len + 1
		elseif b <= 223 then
			len = len + 2
		elseif b <= 239 then
		 	len = len + 3
		else
			len = len + 4
		end
	end
	value = value:sub(1, len)
	if shortened then
		value = value .. '...'
	end]],
	arg = "number",
	value = "string",
	ret = "string",
	doc = L["Truncate value to the length specified by number and add ellipsis to the end if actually truncated"],
	example = '[Text(Hello):TruncEllipsis(3)] => "Hel..."; [Text(Hello):TruncEllipsis(5)] => "Hello"',
	category = L["Abbreviations"]
})

DogTag:AddModifier("Rep", {
	[[value = value:rep(${arg})
	if value == "" then
		value = nil
	end]],
	arg = "number",
	value = "string",
	ret = "string;nil",
	doc = L["Repeat value number times"],
	example = '[Text(Hello):Rep(3)] => "HelloHelloHello"',
	category = L["Text manipulation"]
})

DogTag:AddModifier("Len", {
	[[local len = 0
	while true do
		local b = value:byte(len+1)
		if not b then
			break
		elseif b <= 127 then
			len = len + 1
		elseif b <= 223 then
			len = len + 2
		elseif b <= 239 then
		 	len = len + 3
		else
			len = len + 4
		end
	end
	value = len]],
	value = "string",
	ret = "number",
	doc = L["Return the length of value"],
	example = '[Text(Hello):Len] => "5"; [Text(Hi guys)] => "7"',
	category = L["Text manipulation"]
})

local romanizationData = {
	{"M", 1000},
	{"CM", 900},
	{"D", 500},
	{"CD", 400},
	{"C", 100},
	{"XC", 90},
	{"L", 50},
	{"XL", 40},
	{"X", 10},
	{"IX", 9},
	{"V", 5},
	{"IV", 4},
	{"I", 1}
}
local function romanize(value)
	if value >= 5000000 or value <= -5000000 then
		return tostring(value)
	end
	
	value = math.floor(value + 0.5)
	if value == 0 then
		return "N"
	end

	local t = newList()
	local neg = value < 0
	if neg then
		value = -value
		t[1] = "-"
	end
	
	if value >= 5000 then
		t[#t+1] = "("
		for i = 1, #romanizationData-2 do
			local v = romanizationData[i]
			while value >= v[2]*1000 do
				t[#t+1] = v[1]
				value = value - v[2]*1000
			end
		end
		t[#t+1] = ")"
	end
	
	for i,v in ipairs(romanizationData) do
		while value >= v[2] do
			t[#t+1] = v[1]
			value = value - v[2]
		end
	end
	local result = table.concat(t)
	t = del(t)
	return result
end
DogTag:AddFakeGlobal("romanize", romanize)
DogTag:AddModifier("Romanize", {
	[[value = DogTag___romanize(value)]],
	ret = "string",
	value = "number",
	globals = "DogTag.__romanize",
	doc = L["Turn number_value into a roman numeral."],
	example = '[1666:Romanize] => "MDCLXVI"',
	category = L["Text manipulation"]
})

end
