local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local runUpdate = DogTag.runUpdate
local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local toUpdate = DogTag.toUpdate

DogTag:AddEventHandler("MODIFIER_STATE_CHANGED", function(key)
	local eventName
	if key == "ALT" then
		eventName = "AltKey"
	elseif key == "CTRL" then
		eventName = "CtrlKey"
	elseif key == "SHIFT" then
		eventName = "ShiftKey"
	else
		return
	end	
	if not hasEvent[eventName] then
		return
	end
	
	for text in pairs(eventData[eventName]) do
		toUpdate[text] = true
	end
	runUpdate()
end)

DogTag:AddTag("Alt", {
	([[value = IsAltKeyDown() and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "AltKey",
	globals = "IsAltKeyDown",
	doc = L["Return True if the Alt key is held down"],
	example = ('[Alt] => %q; [Alt] => ""'):format(L["True"]),
	category = L["Miscellaneous"]
})

DogTag:AddTag("Shift", {
	([[value = IsShiftKeyDown() and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "ShiftKey",
	globals = "IsShiftKeyDown",
	doc = L["Return True if the Shift key is held down"],
	example = ('[Shift] => %q; [Shift] => ""'):format(L["True"]),
	category = L["Miscellaneous"]
})

DogTag:AddTag("Ctrl", {
	([[value = IsControlKeyDown() and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "CtrlKey",
	globals = "IsControlKeyDown",
	doc = L["Return True if the Ctrl key is held down"],
	example = ('[Ctrl] => %q; [Ctrl] => ""'):format(L["True"]),
	category = L["Miscellaneous"]
})

DogTag:AddTag("Text", {
	function(data)
		local arg = data.arg
		if tonumber(arg) then
			return ("value = %s"):format(tonumber(arg))
		elseif arg:find("%[") and arg:find("%]") then
			return "if ${arg} ~= '' then value = tonumber(${arg}) or ${arg} end"
		elseif arg == '' then
			return "value = nil"
		else
			return "value = ${arg}"
		end
	end,
	arg = "number;string",
	ret = "number;string;nil",
	doc = L["Return the argument"],
	example = '[Text(Hello)] => "Hello"',
	category = L["Miscellaneous"]
})

DogTag:AddTag("CurrentTime", {
	[[value = GetTime()]],
	ret = "number",
	events = "FastUpdate",
	globals = "GetTime",
	doc = L["Return the current time in seconds, specified by WoW's internal format"],
	example = ('[CurrentTime] => "%s"'):format(GetTime()),
	category = L["Miscellaneous"]
})

DogTag:AddTag("Alpha", {
	[[opacity = ${arg}]],
	ret = "string;number;nil",
	arg = "number",
	doc = L["Set the transparency of the FontString according to argument"],
	example = '[Alpha(1)] => "Bright"; [Alpha(0)] => "Dim"',
	category = L["Miscellaneous"]
})

DogTag:AddTag("IsMouseOver", {
	([[value = DogTag.__isMouseOver and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "Mouseover",
	doc = L["Return True if currently mousing over the Frame the FontString is harbored in"],
	example = ('[IsMouseOver] => %q; [IsMouseOver] => ""'):format(L["True"]),
	category = L["Miscellaneous"]
})

DogTag:AddTag("Combos", {
	[[value = GetComboPoints()]],
	ret = "number",
	events = "PLAYER_COMBO_POINTS",
	globals = "GetComboPoints",
	doc = L["Return the number of combo points you have"],
	example = '[Combos] => "5"',
	category = L["Miscellaneous"]
})

DogTag:AddTag("ComboSymbols", {
	function(data)
		return [[do
			local num = GetComboPoints()
			if num > 0 then
				value = (]] .. (data.arg and "${arg}" or '"@"') .. [[):rep(num)
			end
		end]]
	end,
	arg = "string;nil",
	ret = "string;nil",
	events = "PLAYER_COMBO_POINTS",
	globals = "GetComboPoints",
	doc = L["Return @ or argument repeated by the number of combo points you have"],
	example = '[ComboSymbols] => "@@@@@"; [ComboSymbols(X)] => "XXXXX"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Color", {
	function(data)
		local arg = data.arg:lower()
		if arg:find("%[") and arg:find("%]") then -- dynamic
			return [[local arg = ${arg}
			if not arg:match("^%x%x%x%x%x%x$") then
				arg = "ffffff"
			end
			value = "|cff" .. arg]] .. (data.isMod and [[ .. value .. "|r"]] or "")
		else
			if not arg:match("^%x%x%x%x%x%x$") then
				arg = "ffffff"
			end
			if data.isMod then
				return [[value = "|cff]] .. arg .. [[" .. value .. "|r"]]
			else
				return [[value = "|cff]] .. arg .. [["]]
			end
		end
	end,
	arg = "string",
	value = "number;string",
	ret = "string",
	doc = L["Return the color or wrap value with the rrggbb color of argument"],
	example = '[Text(Hello):Color(00ff00)] => "|cff00ff00Hello|r"; [Text([Color(00ff00)]Hello)] => "|cff00ff00Hello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("White", {
	alias = "Color(ffffff)",
	doc = L["Return the color or wrap value with white color"],
	example = '[Text(Hello):White] => "|cffffffffHello|r"; [Text([White]Hello)] => "|cffffffffHello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Red", {
	alias = "Color(ff0000)",
	doc = L["Return the color or wrap value with red color"],
	example = '[Text(Hello):Red] => "|cffff0000Hello|r"; [Text([Red]Hello)] => "|cffff0000Hello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Green", {
	alias = "Color(00ff00)",
	doc = L["Return the color or wrap value with green color"],
	example = '[Text(Hello):Green] => "|cff00ff00Hello|r"; [Text([Green]Hello)] => "|cff00ff00Hello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Blue", {
	alias = "Color(0000ff)",
	doc = L["Return the color or wrap value with blue color"],
	example = '[Text(Hello):Blue] => "|cff0000ffHello|r"; [Text([Blue]Hello)] => "|cff0000ffHello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Cyan", {
	alias = "Color(00ffff)",
	doc = L["Return the color or wrap value with cyan color"],
	example = '[Text(Hello):Cyan] => "|cff00ffffHello|r"; [Text([Cyan]Hello)] => "|cff00ffffHello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Fuchsia", {
	alias = "Color(ff00ff)",
	doc = L["Return the color or wrap value with fuchsia color"],
	example = '[Text(Hello):Fuchsia] => "|cffff00ffHello|r"; [Text([Fuchsia]Hello)] => "|cffff00ffHello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Yellow", {
	alias = "Color(ffff00)",
	doc = L["Return the color or wrap value with yellow color"],
	example = '[Text(Hello):Yellow] => "|cffffff00Hello|r"; [Text([Yellow]Hello)] => "|cffffff00Hello"',
	category = L["Miscellaneous"]
})

DogTag:AddTagAndModifier("Gray", {
	alias = "Color(afafaf)",
	doc = L["Return the color or wrap value with gray color"],
	example = '[Text(Hello):Gray] => "|cffafafafHello|r"; [Text([Gray]Hello)] => "|cffafafafHello"',
	category = L["Miscellaneous"]
})

end