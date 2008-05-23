local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 60085 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

-- This is where you can start coding, keep the above the same

-- let's say you want to make a new modifier that squares a number

DogTag:AddModifier("Square", { -- give it a name, then the data table
	-- we're just doing an alias, so [Tag:Square] will translate into [Tag:Pow(2)]
	alias = "Pow(2)",
	-- documentation must be supplied
	-- Note: wrap in L[] to allow for localization
	-- `number_value` is what you refer to the value operating on if it is a number, use `value` if it can be a string
	doc = L["Return the square of number_value"],
	-- example of how it's used, try to show basic case and edge cases if applicable
	-- list separated by semicolons, left side wrapped in square brackets, right in quotes, even if it's a number.
	example = '[3:Square] => "9"; [4:Square] => "16"',
	-- category should always be supplied, can be any string
	category = L["Mathematics"],
})

-- now let's say you want to make a modifer that cubes a number, but not use an alias (just as an example)

DogTag:AddModifier("Cube", {
	-- value is what you were provided, and it is also what should be set.
	[[value = value*value*value]],
	-- always specify what will be returned as a semicolon-separated list
	-- can be "number", "string", "nil", "number;string", "number;nil", "string;nil", or "number;string;nil"
	ret = "number",
	-- always specify what kind of value is expected as a semicolon-separated list, can be "number", "string", or "number;string"
	-- If you request a number and a string or nil is provided, the modifier will not be run. If you request a string and a number is provided, it will be converted, but it will never run on nil.
	value = "number",
	-- you can specify what argument you can receive, which can be used in the code with ${arg}
--	arg = "nil",
	-- as before, specify doc, example, and category
	doc = L["Return the cube of number_value"],
	example = '[3:Cube] => "27"; [4:Cube] => "64"',
	category = L["Mathematics"],
})

-- now for a real tag that can be used in a real life situation, the current mana/rage/energy

DogTag:AddTag("CurMP", {
	-- same code style as before.
	-- notice the use of ${unit}, it will be replaced with the appropriate unit.
	[[value = UnitMana(${unit})]],
	-- returning a number, as expected
	ret = "number",
	-- the events at which the tag should be updated. This is a semicolon-separated list of events.
	-- non-Blizzard events can be used, will show how to further on
	events = "UNIT_MANA;UNIT_RAGE;UNIT_FOCUS;UNIT_ENERGY;UNIT_MAXMANA;UNIT_MAXRAGE;UNIT_MAXFOCUS;UNIT_MAXENERGY;UNIT_DISPLAYPOWER",
	-- the global variables that are used in this tag.
	-- you can also specify libraries to be used and fake globals provided, will show how to further on
	globals = "UnitMana",
	-- documentation as before
	doc = L["Return the current mana/rage/energy of unit"],
	example = '[CurMP] => "52"',
	category = L["Power"]
})

-- events can also be used in modifiers without issue

-- there are 3 events that are provided for you by default but are not Blizzard events: FastUpdate, Update, and SlowUpdate.
-- FastUpdate updates every 0.05 seconds, Update every 0.15 seconds, and SlowUpdate every 10 seconds. Do not rely on these specific times, though, it may be slightly faster or slower depending on the situation.

-- to see how fake globals can work with LibDogTag-2.0, we'll make one that doubles a string or number

local function double(value)
	if type(value) == "string" then
		return value .. value
	else -- number
		return value * 2
	end
end
DogTag:AddFakeGlobal("double", double) -- provide the name of it and the function (or table)

DogTag:AddModifier("Double", {
	-- used in the form DogTag___givenName
	[[value = DogTag___double(value)]],
	value = "number;string",
	ret = "number;string",
	-- must be referenced here as DogTag.__givenName to be able to use it
	globals = "DogTag.__double",
	-- documentation as before
	doc = L["Return value multiplied by two if a number, otherwise concatenate with itself"],
	example = '[1234:Double] => "2468"; [Text(Hello):Double] => "HelloHello"',
	category = L["Miscellaneous"]
})

-- if you want a tag/modifier combo, typically used for colors, the following can be used:

DogTag:AddTagAndModifier("Sage", {
	function(data)
		if data.isMod then -- working with a modifier
			return [[value = "|cff007f00" .. value .. "|r"]]
		else -- tag
			return [[value = "|cff007f00"]]
		end
	end,
	ret = "string",
	value = "string", -- affects the modifier only, not the tag
	doc = L["Return the color or wrap value with sage color"],
	example = '[Text(Hello):Sage] => "|cff007f00Hello|r"; [Text([Sage]Hello)] => "|cff007f00Hello"',
	category = L["Miscellaneous"]
})

-- now let's say you're going to tie some tags to a library, in this case the mythical library LibMonkey-1.0

local LibMonkey
-- add an addon finder
-- this will check for an addon or library until it is found
-- first argument is the type, can be "_G" for a global variable that appears, "LibStub" for a LibStub-based library, "AceLibrary" for an AceLibrary-based library, or "Rock" for a Rock-based library.
-- the second argument is the name of the addon or library
-- the third argument is the function that is called when the addon or library is found. It is only called once.
DogTag:AddAddonFinder("LibStub", "LibMonkey-1.0", function(lib)
	-- lib holds the reference to the library
	LibMonkey = lib
	-- you could do more stuff here, but we're just checking for existence.
end)

DogTag:AddTag("Bananas", {
	function(data)
		if not LibMonkey then
			-- if LibMonkey-1.0 isn't found, then we just want a nil value
			return [[]]
		else
			-- if LibMonkey-1.0 is found, then we can access it in the tag
			return [[value = LibMonkey:GetNumBananas(${unit})]],
				'globals', "LibMonkey-1.0", -- add easy library access
				'events', "Update" -- add Update event to check every 0.15 seconds
		end
	end,
	ret = "number;nil",
	doc = L["Return the number of bananas of unit, if LibMonkey-1.0 is available"],
	example = '[Bananas] => "5"; [Bananas] => ""',
	category = L["Miscellaneous"]
})

-- to get easy access to events, to be able to use them in local functions or otherwise,

DogTag:AddEventHandler("SOME_BLIZZARD_EVENT_NAME", function(...)
	-- now this will be called whenever SOME_BLIZZARD_EVENT_NAME is dispatched
end)

-- for a timer,

DogTag:AddTimerHandler(function(num, currentTime)
	-- this will be called roughly every 0.05 seconds.
	-- num starts at 1 and increases by 1 every time it is called.
	-- currentTime is the time as returned by GetTime()
end)

-- now, to create your own pseudo-event, say one that fires roughly every second,

local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local toUpdate = DogTag.toUpdate

local nextTime = 0
DogTag:AddTimerHandler(function(num, currentTime)
	if nextTime > currentTime then
		return
	end
	nextTime = currentTime + 1
	
	if not hasEvent.MyFunUpdate then
		 -- check to see if someone has the event, leave early if they don't
		return
	end
	
	for text, unit in pairs(eventData.MyFunUpdate) do
		-- go through everything that has the event
		-- text is the FontString
		-- unit is the unit involved
		toUpdate[text] = true -- set text to update
	end
end)

DogTag:AddTag("MyRandom", {
	[[value = math_floor(math_random()*${arg}) + 1]],
	arg = "number",
	ret = "number",
	events = "MyFunUpdate", -- use the event you made
	globals = "math.floor;math.random",
	doc = L["Return a random value between 1 and arg, updating every second"],
	example = '[MyRandom(5)] => "3"; [MyRandom(10)] => "10"',
	category = L["Miscellaneous"],
})

-- you could make the event fire whenever you want, in reaction to a library, an event, an update, anything.

end