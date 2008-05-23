if not strtrim then
	function strtrim(str, chars)
		if not chars then chars = " \t" end
		local s, e = 1, #str
		while s < e and string.find(chars, string.sub(str, s, s), 1, 1) do
			s = s + 1
		end
		while s < e and string.find(chars, string.sub(str, e, e), 1, 1) do
			e = e - 1
		end
		return string.sub(str, s, e)
	end
end

dofile("../../Ace3/LibStub/LibStub.lua")
dofile("../../Ace3/CallbackHandler-1.0/CallbackHandler-1.0.lua")

local widget_methods = {
	UnregisterAllEvents = function () end,
	SetScript = function (frame, event, handler)
		frame.handlers[event] = handler
	end,
	Show = function () end,
	AddMessage = function (frame, msg) print(msg) end,
	CreateFontString = function () return CreateFrame() end,
	SetFontObject = function () end,
	AddFontStrings = function () end,
}

CreateFrame = function (name)
	return setmetatable({name = name, handlers = {}}, {__index = widget_methods})
end
ChatFrame1 = CreateFrame()
GetInventorySlotInfo = function (slot) return slot end

GetLocale = function () return "enUS" end
WEAPON_SPEED = "Speed"
ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:"
EMPTY_SOCKET_BLUE = "Blue Socket"
EMPTY_SOCKET_META = "Meta Socket"
EMPTY_SOCKET_RED = "Red Socket"
EMPTY_SOCKET_YELLOW = "Yellow Socket"

DEBUG_ItemBonusLib = true

dofile("core.lua")
dofile("locales/enUS.lua")
dofile("locales/frFR.lua")
dofile("postprocess.lua")

LibStub("LibItemBonus-2.0"):OnInitialize()

local testbonuses

function test(noprint)
	local ibl = LibStub("LibItemBonus-2.0")
	local count, total = 0, 0
	
	for _, p in ipairs(testbonuses) do
		local bonus = {}
		ibl:AddBonusInfo(bonus, p.pattern)
		local correct = true
		local error = ""
		for k, v in pairs(p.expects) do
			if bonus[k] ~= v then
				correct = false
				if bonus[k] then
					error = error.." *"..k..":"..v..":"..bonus[k]
				else
					error = error.." -"..k..":"..v
				end
			end
			bonus[k] = nil
		end
		for k, v in pairs(bonus) do
			correct = false
			error = error.." +"..k..":"..v
		end
		if not noprint and not correct then
			print(string.format("pattern [%s] failed : %s", p.pattern, error))
		else
			count = count + 1
		end
		total = total + 1
	end
	print(string.format("Test performed, %d over %d passed successfully", count, total))
end

local clock = os.clock

local debug_times = {}
local debug_stack = {}

local function debug_hook(event)
	local t = clock()
	if event == "call" then
		local name = debug.getinfo(2, "n").name
		local index = #debug_stack + 1
		debug_stack[index] = { name = name, time = t, ctime = 0 }
		if not debug_times[name] then
			debug_times[name] = { time = 0, count = 0, ctime = 0 }
		end
	elseif event == "return" or event == "tail return" then
		local index = #debug_stack
		if index == 0 then return end
		local i = debug_stack[index]
		debug_stack[index] = nil
		t = t - i.time
		local rt = t - i.ctime
		for i = 1, index - 1 do
			local v = debug_stack[i]
			v.ctime = v.ctime + rt
		end
		local v = debug_times[i.name]
		v.time = v.time + t
		v.count = v.count + 1
		v.ctime = v.ctime + i.ctime
	end
end

function test_time(iterations)
	local ibl = LibStub("LibItemBonus-2.0")
	local o = ibl.Debug
	ibl.Debug = function () end
	local test = function ()
		for _, p in ipairs(testbonuses) do
			ibl:AddBonusInfo({}, p.pattern)
		end
	end
	local sethook = debug.sethook
	local start = clock()
	sethook(debug_hook, "rc")
	for i = 1, iterations do test() end
	sethook()
	local elapsed = clock() - start
	print(string.format("Iterations  : %d, time : %f, time per iteration : %f", iterations, elapsed, elapsed / iterations))
	ibl.Debug = o
	
	local names = {}
	for name in pairs(debug_times) do
		names[#names + 1] = name
	end
	
	table.sort(names, function (a, b)
		local ta, tb = debug_times[a].time, debug_times[b].time
		return ta > tb
	end)
	
	for _, name in ipairs(names) do
		local v = debug_times[name]
		print(name, v.count, v.time, v.time - v.ctime)
	end
end

testbonuses = {
	{ pattern = "+31 Healing and 5 mana per 5 sec.", expects = {HEAL= 31, MANAREG = 5}},
	{ pattern = "+6 All Stats", expects = {AGI=6, SPI=6, INT=6, STR=6, STA=6}},
	{ pattern = "Stamina +16 and Armor +100", expects = {STA = 16, ARMOR=100}},
	{ pattern = "Minor Speed and +9 Stamina", expects = {STA = 9}},
	{ pattern = "+35 Healing Spells", expects = {HEAL = 35}},
	{ pattern = "+2 Weapon Damage", expects = {MELEEDMG = 2}},
	{ pattern = "Savagery", expects = {ATTACKPOWER = 70}},

	-- META GEMS
	{ pattern = "+26 healing Spells & 2% Reduced Threat", expects = {HEAL= 26, THREATREDUCTION=2}},
	{ pattern = "+3 Melee Damage & Chance to Stun Target", expects = {MELEEDMG = 3}},
	{ pattern = "+14 Spell Crit Rating and 1% Spell Reflect", expects = {CR_SPELLCRIT = 14}},
	{ pattern = "+12 Critical Strike Rating & 5% Snare and Root Resist", expects = {CR_CRIT = 12}},
	{ pattern = "+12 Intellect & Chance to restore mana on spellcast", expects = {INT = 12}},
	{ pattern = "5% on spellcast - next spell cast in half time", expects = {}},
	{ pattern = "2% on spellcast - next spell instant cast.", expects = {}},
	{ pattern = "+18 Stamina & 5% Stun Resist", expects = {STA = 18}},
	{ pattern = "+24 Attack Power and Minor Run Speed Increase", expects = {ATTACKPOWER = 24}},
	{ pattern = "+12 Spell Damage and Minor Run Speed Increase", expects = {DMG = 12, HEAL = 12}},
	{ pattern = "+20 Attack Power and Minor Run Speed Increase", expects = {ATTACKPOWER = 20}},
	{ pattern = "+12 Defense Rating & Chance to Restore Health on hit", expects = {CR_DEFENSE = 12}},

	-- RED GEMS
	{ pattern = "+20 Attack Power", expects = {ATTACKPOWER = 20}},
	{ pattern = "+12 Spell Damage", expects = {DMG = 12, HEAL = 12}},
	{ pattern = "+8 Strength", expects = {STR = 8}},
	{ pattern = "+8 Agility", expects = {AGI = 8}},
	{ pattern = "+8 Parry rating", expects = {CR_PARRY = 8}},
	{ pattern = "+8 Dodge rating", expects = {CR_DODGE = 8}},
	{ pattern = "+18 Healing", expects = {HEAL = 18}},

	-- YELLOW GEMS
	{ pattern = "+10 Spell Critical Strike Rating", expects = {CR_SPELLCRIT = 10}},
	{ pattern = "+10 Critical Strike Rating", expects = {CR_CRIT = 10}},
	{ pattern = "+10 Resilience", expects = {CR_RESILIENCE = 10}},
	{ pattern = "+8 Intellect", expects = {INT = 8}},
	{ pattern = "+8 Spell Critical Rating", expects = {CR_SPELLCRIT = 8}},
	{ pattern = "+8 Hit Rating", expects = {CR_HIT = 8}},
	{ pattern = "+8 Defense Rating", expects = {CR_DEFENSE = 8}},
	
	-- BLUE GEMS
	{ pattern = "+3 Mana every 5 seconds", expects = {MANAREG = 3}},
	{ pattern = "+12 Stamina", expects = {STA = 12}},
	{ pattern = "+8 Spirit", expects = {SPI = 8}},
	{ pattern = "+10 Spell Penetration", expects = {SPELLPEN = 10}},
	
	-- ORANGE GEMS
	{ pattern = "Critical Rating +6 and Dodge Rating +5", expects = { CR_CRIT = 6, CR_DODGE = 5}},
	{ pattern = "Dodge Rating +5 and Resilience Rating +4", expects = {CR_DODGE = 5, CR_RESILIENCE = 4 }},
	{ pattern = "Strength +5 and Defense +4", expects = {STR = 5, CR_DEFENSE = 4}},
	{ pattern = "Attack Power +8 and Critical Rating +5", expects = {ATTACKPOWER = 8, CR_CRIT = 5}},
	{ pattern = "Healing +11 and Resilience Rating +4", expects = {HEAL = 11, CR_RESILIENCE = 4}},
	{ pattern = "Attack Power +8 and Resilience Rating +5", expects = {ATTACKPOWER = 8, CR_RESILIENCE = 5}},
	{ pattern = "Strength +5 and Critical Rating +5", expects = {STR = 5, CR_CRIT = 5}},
	{ pattern = "Strength +5 and Hit Rating +4", expects = {STR = 5, CR_HIT = 4}},
	{ pattern = "Parry Rating +5 and Defense Rating +4", expects = {CR_PARRY = 5, CR_DEFENSE = 4}},
	{ pattern = "Agility +5 and Hit Rating +4", expects = {AGI = 5, CR_HIT = 4}},
	{ pattern = "Agility +4 and Defense Rating +5", expects = {AGI = 4, CR_DEFENSE = 5}},
	{ pattern = "Spell Damage +6 and Intellect +4", expects = { DMG = 6, INT = 4, HEAL = 6}},
	{ pattern = "+10 Attack Power, +5 Critical Strike Rating", expects = {ATTACKPOWER = 10, CR_CRIT = 5 }},
	{ pattern = "Healing +11 and Spell Critical Rating +4", expects = {HEAL = 11, CR_SPELLCRIT = 4 }},
	{ pattern = "Healing +11 and Intellect +4", expects = {HEAL = 11, INT = 4}},
	{ pattern = "Spell Damage +6 and Spell Penetration +5", expects = {DMG = 6, HEAL = 6, SPELLPEN = 5}},
	{ pattern = "Dodge Rating +5 and Hit Rating +4", expects = {CR_DODGE = 5, CR_HIT = 4 }},
	{ pattern = "Spell Damage +6 and Spell Critical Rating +4", expects = {DMG = 6, HEAL = 6, CR_SPELLCRIT = 4}},
	{ pattern = "+6 Spell Damage, +5 Spell Crit Rating", expects = {DMG = 6, HEAL = 6, CR_SPELLCRIT = 5}},
	{ pattern = "Attack Power +10 and Hit Rating +4", expects = {ATTACKPOWER = 10, CR_HIT = 4}},
	{ pattern = "Strength +5 and Resilience Rating +4", expects = {STR = 5, CR_RESILIENCE = 4}},
	{ pattern = "Spell Damage +6 and Spell Hit Rating +5", expects = {DMG = 6, HEAL = 6, CR_SPELLHIT = 5}},
	{ pattern = "Parry Rating +5 and Resilience Rating +4", expects = {CR_PARRY = 5, CR_RESILIENCE = 4}},
	{ pattern = "Defense Rating +5 and Dodge Rating +4", expects = {CR_DEFENSE = 5, CR_DODGE = 4}},
	-- blue
	{ pattern = "+4 Hit Rating and +4 Agility", expects = {CR_HIT = 4, AGI = 4}},
	{ pattern = "+4 Critical Strike Rating and +4 Strength", expects = {CR_CRIT = 4, STR = 4}},
	{ pattern = "+9 Healing Spells and +4 Intellect", expects = {HEAL = 9, INT = 4 }},
	{ pattern = "+4 Spell Critical Rating and +5 Spell Damage", expects = {CR_SPELLCRIT = 4, DMG = 5, HEAL = 5}},
	
	-- GREEN GEMS
	{ pattern = "Intellect +5 and 2 mana per 5 sec.", expects = {INT = 5, MANAREG = 2}},
	{ pattern = "Defense Rating +5 and 2 mana per 5 sec.", expects = {CR_DEFENSE = 5, MANAREG = 2}},
	{ pattern = "Stamina +6 and Defense Rating +5", expects = {STA = 6, CR_DEFENSE = 5 }},
	{ pattern = "Stamina +6 and Crit Rating +5", expects = {STA = 6, CR_CRIT = 5 }},
	{ pattern = "Spell Hit Rating +5 and 2 mana per 5 sec.", expects = {CR_SPELLHIT = 5, MANAREG = 2}},
	{ pattern = "Stamina +6 and Spell Crit Rating +5", expects = {STA = 6, CR_SPELLCRIT = 5}},
	{ pattern = "Spell Critical Rating +5 and Spell Penetration +5", expects = {CR_SPELLCRIT = 5, SPELLPEN = 5}},
	{ pattern = "Spell Critical Rating +5 and 2 mana per 5 sec.", expects = {CR_SPELLCRIT = 5, MANAREG = 2}},
	{ pattern = "Intellect +4 and Spirit +5", expects = {INT = 4, SPI = 5}},
	{ pattern = "Stamina +6 and Resilience Rating +5", expects = {STA = 6, CR_RESILIENCE = 5}},
	{ pattern = "Critical Rating +5 and 2 mana per 5 sec.", expects = {CR_CRIT = 5, MANAREG = 2}},
	{ pattern = "Intellect +5 and Stamina +6", expects = {INT = 5, STA = 6}},
	{ pattern = "Spell Hit Rating +5 and Stamina +6", expects = {CR_SPELLHIT = 5, STA = 6}},
	-- blue
	{ pattern = "+3 Stamina, +4 Critical Strike Rating", expects = {STA = 3, CR_CRIT = 4}},
	{ pattern = "+4 Intellect and +2 Mana every 5 seconds", expects = {INT = 4, MANAREG = 2}},
	{ pattern = "+4 Defense Rating and +6 Stamina", expects = {CR_DEFENSE = 4, STA = 6}},
	{ pattern = "+4 Critical Strike Rating and +6 Stamina", expects = {CR_CRIT = 4, STA = 6}},
	{ pattern = "+3 Stamina, +4 Spell Critical Strike Rating", expects = {STA = 3, CR_SPELLCRIT = 4}},
	{ pattern = "+4 Spell Critical Rating and +5 Spell Penetration", expects = {CR_SPELLCRIT = 4, SPELLPEN = 5}},
	{ pattern = "+1 Mana every 5 Sec and 3 Intellect", expects = {INT = 3, MANAREG = 1}},
	
	-- PURPLE GEMS
	{ pattern = "Healing +11 and Stamina +6", expects = {HEAL = 11, STA = 6 }},
	{ pattern = "Attack Power +10 and Stamina +6", expects = {ATTACKPOWER = 10, STA = 6 }},
	{ pattern = "Parry Rating +5 and Stamina +6", expects = {CR_PARRY = 5, STA = 6}},
	{ pattern = "Spell Damage +6 and Spirit +4", expects = {DMG = 6, HEAL = 6, SPI = 4}},
	{ pattern = "Spell Damage +6 and Stamina +6", expects = {DMG = 6, HEAL = 6, STA = 6}},
	{ pattern = "Spirit +5 and Healing +9", expects = {SPI = 5, HEAL = 9}},
	{ pattern = "Dodge Rating +5 and Stamina +6", expects = {CR_DODGE = 5, STA = 6 }},
	{ pattern = "Healing +11 and 2 mana per 5 sec.", expects = {HEAL = 11, MANAREG = 2}},
	{ pattern = "Strength +5 and Agility +4", expects = {STR = 5, AGI = 4}},
	{ pattern = "Strength +5 and Stamina +6", expects = {STR = 5, STA = 6}},
	-- blue
	{ pattern = "+5 Spell Damage and +6 Stamina", expects = {DMG = 5, HEAL = 5, STA = 6}},
	{ pattern = "+9 Healing Spells and +2 Mana every 5 seconds", expects = { HEAL = 9, MANAREG = 2}},
	{ pattern = "+4 Agility and +6 Stamina", expects = {AGI = 4, STA = 6}},
	{ pattern = "+4 Strength and +6 Stamina", expects = {STR = 4, STA = 6}},
	{ pattern = "+7 Healing Spells & +1 Mana per 5 Seconds", expects = { HEAL = 7, MANAREG = 1}},
	
	-- PRISMATIC GEMS
	{ pattern = "+4 Resist All", expects = {ARCANERES = 4, FROSTRES=4, NATURERES=4, FIRERES=4, SHADOWRES=4}},
	
	-- HEAL_AND_DMG
	{ pattern = "Equip: Increases damage and healing done by magical spells and effects by up to 299.", expects = {HEAL=299, DMG=299}},
	
	-- Enchantments
	{ pattern = "+22 Spell Power and +14 Spell Hit Rating", expects = {DMG=22, HEAL=22, CR_SPELLHIT=14}},
	
	{ pattern = "Vitality", expects = {MANAREG=4, HEALTHREG=4}},
	
	-- skill rating
	{ pattern = "Increases your hit rating by 56.", expects = {CR_HIT=56}},
	{ pattern = "Increases two-handed sword skill rating by 16.", expects = {CR_WEAPON_SWORD_2H=16}},
	{ pattern = "Improves spell critical strike rating by 32.", expects = {CR_SPELLCRIT=32}},
	{ pattern = "Improves your resilience rating by 7.", expects = {CR_RESILIENCE=7}},
	
	-- misc
	{ pattern = "Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3.", expects = {CR_DEFENSE=5, SHADOWRES=10, HEALTHREG_P=3}},
	-- armor
	{ pattern = "319 Armor", expects = {BASE_ARMOR=319}},
	{ pattern = "+5 Spell Haste Rating and +6 Spell Damage", expects = {DMG=6, HEAL=6, CR_SPELLHASTE=5}},
	-- healing
	{ pattern = "Increases healing done by up to 415 and damage done by up to 138 for all magical spells and effects.", expects = {HEAL=415,DMG=138}},
	{ pattern = "+81 Healing Spells and +27 Damage Spells", expects = {HEAL=81,DMG=27}},
}

if arg[1] and tonumber(arg[1]) then
	test_time(tonumber(arg[1]))
else
	test()
end
