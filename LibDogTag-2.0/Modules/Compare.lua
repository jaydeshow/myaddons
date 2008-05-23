local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63783 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

DogTag:AddModifier("IsEqual", {
	[[if tostring(value) ~= ${arg:string} then
		value = nil
	end]],
	value = "number;string",
	arg = "number;string",
	ret = "same;nil",
	globals = "tostring",
	doc = L["Compare argument and value, hide if not equal"],
	example = '[Text(Hello):IsEqual(Hello)] => "Hello"; [Text(Hello):IsEqual(Howdy)] => ""; [Text(Hello)=Text(Hello)] => "Hello"',
	category = L["Comparisons"]
})

DogTag:AddModifier("IsLess", {
	[[local value_num = tonumber(value)
	local arg_num = tonumber(${arg})
	if value_num and arg_num then
		if value_num >= arg_num then
			value = nil
		end
	else
		if tostring(value) >= ${arg:string} then
			value = nil
		end
	end]],
	value = "number;string",
	arg = "number;string",
	ret = "same;nil",
	globals = "tonumber;tostring",
	doc = L["Compare argument and value, hide if argument isn't less than value"],
	example = '[50:IsLess(100)] => "50"; [50:IsLess(25)] => ""; [50<100] => "50"',
	category = L["Comparisons"]
})

DogTag:AddModifier("IsLessEqual", {
	[[local value_num = tonumber(value)
	local arg_num = tonumber(${arg})
	if value_num and arg_num then
		if value_num > arg_num then
			value = nil
		end
	else
		if tostring(value) > ${arg:string} then
			value = nil
		end
	end]],
	value = "number;string",
	arg = "number;string",
	ret = "same;nil",
	globals = "tonumber;tostring",
	doc = L["Compare argument and value, hide if argument isn't less than or equal to value"],
	example = '[50:IsLessEqual(50)] => "50"; [50:IsLessEqual(49)] => ""; [50<=50] => "50"',
	category = L["Comparisons"]
})

DogTag:AddModifier("IsGreater", {
	alias = "~IsLessEqual",
	doc = L["Compare argument and value, hide if argument isn't greater than value"],
	example = '[100:IsGreater(50)] => "100"; [25:IsGreater(50)] => ""; [100>50] => "100"',
	category = L["Comparisons"]
})

DogTag:AddModifier("IsGreaterEqual", {
	alias = "~IsLess",
	doc = L["Compare argument and value, hide if argument isn't greater than or equal value"],
	example = '[50:IsGreaterEqual(50)] => "50"; [49:IsGreater(50)] => ""; [50>=50] => "50"',
	category = L["Comparisons"]
})

DogTag:AddModifier("IsNotEqual", {
	alias = "~IsEqual",
	doc = L["Compare argument and value, hide if argument is equal to value"],
	example = '[Text(Hello):IsNotEqual(Howdy)] => "Hello"; [Hello:IsNotEqual(Hello)] => ""; [Text(Hello)~=Text(Howdy)] => "Hello"',
	category = L["Comparisons"]
})

DogTag:AddModifier("Hide", {
	alias = "~IsEqual",
	doc = L["Compare argument and value, hide if argument is equal to value"],
	example = '[50:Hide(49)] => "50"; [50:Hide(50)] => ""',
	category = L["Comparisons"]
})

DogTag:AddModifier("HideLess", {
	alias = "~IsLess",
	doc = L["Compare argument and value, hide if argument is less than value"],
	example = '[50:HideLess(25)] => "50"; [50:HideLess(75)] => ""',
	category = L["Comparisons"]
})

DogTag:AddModifier("HideGreater", {
	alias = "~IsGreater",
	doc = L["Compare argument and value, hide if argument is greater than value"],
	example = '[50:HideGreater(25)] => ""; [50:HideGreater(75)] => "50"',
	category = L["Comparisons"]
})

DogTag:AddModifier("HideLessEqual", {
	alias = "~IsLessEqual",
	doc = L["Compare argument and value, hide if argument is less than or equal to value"],
	example = '[50:HideLessEqual(25)] => "50"; [50:HideLessEqual(50)] => ""',
	category = L["Comparisons"]
})

DogTag:AddModifier("HideGreaterEqual", {
	alias = "~IsGreaterEqual",
	doc = L["Compare argument and value, hide if argument is greater than or equal to value"],
	example = '[50:HideGreaterEqual(75)] => "50"; [50:HideGreaterEqual(50)] => ""',
	category = L["Comparisons"]
})

DogTag:AddModifier("HideUnless", {
	alias = "~IsNotEqual",
	doc = L["Compare argument and value, hide if argument is not equal to value"],
	example = '[50:Hide(49)] => ""; [50:Hide(50)] => "50"',
	category = L["Comparisons"]
})

DogTag:AddModifier("HideZero", {
	alias = "~IsEqual(0)",
	doc = L["Hide if value is equal to 0"],
	example = '[50:HideZero] => "50"; [0:HideZero] => ""',
	category = L["Comparisons"]
})

DogTag:AddModifier("Contains", {
	[[if not value:find(${arg}) then
		value = nil
	end]],
	value = "string",
	arg = "string",
	ret = "string;nil",
	doc = L["Check if value contains argument, hide if not contained"],
	example = '[Text(Hello):Contains(ell)] => "Hello"; [Text(Hello):Contains(owd)] => ""',
	category = L["Comparisons"]
})

DogTag:AddModifier("HideContains", {
	alias = "~Contains",
	doc = L["Check if value contains argument, hide if contained"],
	example = '[Text(Hello):HideContains(ell)] => ""; [Text(Hello):HideContains(owd)] => "Hello"',
	category = L["Comparisons"]
})

end
