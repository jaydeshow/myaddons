--[[
Name: LibDogTag-2.0
Revision: $Rev: 66504 $
Author: Cameron Kenneth Knight (ckknight@gmail.com)
Inspired By: WatchDog by Vika
Website: http://www.wowace.com/
Documentation: http://www.wowace.com/wiki/LibDogTag-2.0
SVN: svn://svn.wowace.com/wowace/trunk/LibDogTag-2.0
Description: A library to provide a markup syntax for unit frame FontStrings
Dependencies: Rock (optional), MobHealth3/MobHealth2/MobInfo2 (optional), LibBabble-Spell-3.0/Babble-Spell-2.2 (optional), Threat-1.0 (optional), RangeCheck-1.0 (optional), LibDruidMana-1.0 (optional)
License: LGPL v2.1
]]

-------------------------------------------------------------------
-- FOR TAG INFORMATION SEE http://www.wowace.com/wiki/DogTag-2.0 --
-------------------------------------------------------------------

local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 66504 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local DogTag = _G.DogTag

-- #AUTODOC_NAMESPACE DogTag

local oldLib
if next(DogTag) ~= nil then
	oldLib = {}
	for k,v in pairs(DogTag) do
		oldLib[k] = v
		DogTag[k] = nil
	end
end
DogTag.oldLib = oldLib
local L = DogTag__L
DogTag.L = L

local _G = _G
local string_gsub = string.gsub
local math_floor = math.floor
local table_sort = table.sort
local table_concat = table.concat

local function GetNameServer(name, server)
	if name then
		if server and server ~= "" then
			return name .. "-" .. server
		else
			return name
		end
	else
		return nil
	end
end
DogTag.GetNameServer = GetNameServer

local newList, newDict, newSet, del
do
	local pool = setmetatable({}, {__mode='k'})
	function newList(...)
		local t = next(pool)
		if t then
			pool[t] = nil
			for i = 1, select('#', ...) do
				t[i] = select(i, ...)
			end
		else
			t = { ... }
		end
		return t
	end
	function newDict(...)
		local t = next(pool)
		if t then
			pool[t] = nil
		else
			t = {}
		end
		for i = 1, select('#', ...), 2 do
			t[select(i, ...)] = select(i+1, ...)
		end
		return t
	end
	function newSet(...)
		local t = next(pool)
		if t then
			pool[t] = nil
		else
			t = {}
		end
		for i = 1, select('#', ...) do
			t[select(i, ...)] = true
		end
		return t
	end
	function del(t)
		if not t then
			error("Bad argument #1 to `del'. Expected table, got nil.", 2)
		end
		pool[t] = true
		for k in pairs(t) do
			t[k] = nil
		end
		t[''] = true
		t[''] = nil
		return nil
	end
end
DogTag.newList, DogTag.newDict, DogTag.newSet, DogTag.del = newList, newDict, newSet, del

local colors = {}
for class, data in pairs(_G.RAID_CLASS_COLORS) do
	colors[class] = { data.r, data.g, data.b, }
end
colors.unknown = { 0.8, 0.8, 0.8 }
colors.hostile = { 226/255, 45/255, 75/255 }
colors.neutral = { 1, 1, 34/255 }
colors.friendly = { 0.2, 0.8, 0.15 }
colors.civilian = { 48/255, 113/255, 191/255 }
colors.tapped = { 0.5, 0.5, 0.5 }
colors.dead = { 0.6, 0.6, 0.6 }
colors.disconnected = { 0.7, 0.7, 0.7 }
colors.inCombat = { 1, 0, 0 }
colors.petHappy = { 0, 1, 0 }
colors.petNeutral = { 1, 1, 0 }
colors.petAngry = { 1, 0, 0 }
colors.rage = { 226/255, 45/255, 75/255 }
colors.energy = { 1, 220/255, 25/255 }
colors.focus = { 1, 210/255, 0 }
colors.mana = { 48/255, 113/255, 191/255 }
colors.minHP = { 1, 0, 0 }
colors.midHP = { 1, 1, 0 }
colors.maxHP = { 0, 1, 0 }

local lastMouseFocus

local IsLegitimateUnit = {player=true,pet=true,target=true,focus=true,mouseover=true}
DogTag.IsLegitimateUnit = IsLegitimateUnit
for i = 1, 4 do
	IsLegitimateUnit['party' .. i] = true
	IsLegitimateUnit['partypet' .. i] = true
end
for i = 1, 40 do
	IsLegitimateUnit['raid' .. i] = true
	IsLegitimateUnit['raidpet' .. i] = true
end
local IsNormalUnit = {}
DogTag.IsNormalUnit = IsNormalUnit
for k in pairs(IsLegitimateUnit) do
	IsNormalUnit[k] = true
end
setmetatable(IsLegitimateUnit, {__index=function(self, unit)
	if type(unit) ~= "string" then
		return false
	end
	if not unit:find("target$") then
		self[unit] = false
		return false
	end
	local nonTarget = unit:sub(1, -7)
	local good = self[nonTarget]
	self[unit] = good
	return good
end})

local function sortStringList(s)
	if not s then
		return nil
	end
	local list = newList((";"):split(s))
	table_sort(list)
	local q = table_concat(list, ';')
	list = del(list)
	return q
end

local Modifiers = {}
local Tags = {}

local unpackNamespaceList = setmetatable({}, {__index = function(self, key)
	local t = newList((";"):split(key))
	self[key] = t
	return t
end, __call = function(self, key)
	return unpack(self[key])
end})

local function getTag(tag, data, nsList)
	for i, ns in ipairs(unpackNamespaceList[nsList]) do
		local Tags_ns = Tags[ns]
		if Tags_ns then
			local Tags_ns_tag = Tags_ns[tag]
			if Tags_ns_tag then
				if data then
					return Tags_ns_tag[data]
				else
					return Tags_ns_tag
				end
			end
		end
	end
	return nil
end
_G.getTag = getTag
_G.Tags = Tags
local function getModifier(tag, data, nsList)
	for i, ns in ipairs(unpackNamespaceList[nsList]) do
		local Modifiers_ns = Modifiers[ns]
		if Modifiers_ns then
			local Modifiers_ns_tag = Modifiers_ns[tag]
			if Modifiers_ns_tag then
				if data then
					return Modifiers_ns_tag[data]
				else
					return Modifiers_ns_tag
				end
			end
		end
	end
	return nil
end

local function getNamespaceList(...)
	local n = select('#', ...)
	if n == 0 then
		return "Base"
	end
	local t = newList()
	t["Base"] = true
	for i = 1, n do
		local v = select(i, ...)
		t[v] = true
	end
	local u = newList()
	for k in pairs(t) do
		u[#u+1] = k
	end
	t = del(t)
	table.sort(u)
	local value = table.concat(u, ';')
	u = del(u)
	return value
end

local correctCasing = setmetatable({},{__mode='kv',__index=function(self, tag)
	if not tag then
		return nil
	end
	
	local tag_lower = tag:lower()
	for ns, data in pairs(Tags) do
		for k in pairs(data) do
			if k:lower() == tag_lower then
				self[tag] = k
				return k
			end
		end
	end
	for ns, data in pairs(Modifiers) do
		for k in pairs(data) do
			if k:lower() == tag_lower then
				self[tag] = k
				return k
			end
		end
	end
	self[tag] = tag
	return tag
end})

local function toliteral(value)
	if type(value) == "number" then
		return ("(%s)"):format(value)
	else
		return ("(%q)"):format(value)
	end
end

local function unpackAndDel(t, start, finish)
	if not start then
		start = 1
	elseif not finish then
		finish = #t
	end
	if start > finish then
		t = del(t)
		return
	end
	return t[start], unpackAndDel(t, start + 1, finish)
end

local ops = {
	{ ["^"] = "Pow" },
	{ ["*"] = "Mult", ["/"] = "Div", ["%"] = "Mod" },
	{ ["+"] = "Add", ["-"] = "Sub" },
	{ ["<"] = "IsLess", [">"] = "IsGreater", ["<="] = "IsLessEqual", [">="] = "IsGreaterEqual", ["="] = "IsEqual", ["~="] = "IsNotEqual" }
}
local opSet = { ["!"] = true, ["?"] = true, ["||"] = true }
for _, opList in ipairs(ops) do
	for k in pairs(opList) do
		opSet[k] = true
	end
end

local function splitCode(code, inner)
	code = code:trim()
	if code:sub(1, 1) == "[" then
		local alpha, bravo, charlie = code:match("^(%b[])%s*([<>]=)%s*(.+)$")
		if not alpha then
			alpha, bravo, charlie = code:match("^(%b[])%s*(~=)%s*(.+)$")
		end
		if not alpha then
			alpha, bravo, charlie = code:match("^(%b[])%s*(||)%s*(.+)$")
		end
		if not alpha then
			alpha, bravo, charlie = code:match("^(%b[])%s*([:!%?%+%-%*/^%%<>=])%s*(.+)$")
		end
		if alpha then
			return "_(" .. alpha:trim() .. ")", bravo:trim(), splitCode(charlie, true)
		end
		local alpha = code:match("^(%b[])$")
		if alpha then
			if inner then
				return "_(" .. alpha:trim() .. ")"
			else
				return splitCode(alpha:sub(2, -2):trim())
			end
		end
	end
	local front, nextSymbol, rest = code:match("^%s*(..-)%s*([<>]=)%s*(.+)%s*$")
	local front_, nextSymbol_, rest_ = code:match("^%s*(..-)%s*([:!%?%+%-%*/^%%<>=%(])%s*(.+)%s*$")
	if front_ and (not front or #front_ < #front) then
		front = front_
		nextSymbol = nextSymbol_
		rest = rest_
	end
	local front_, nextSymbol_, rest_ = code:match("^%s*(..-)%s*(~=)%s*(.+)%s*$")
	if front_ and (not front or #front_ < #front) then
		front = front_
		nextSymbol = nextSymbol_
		rest = rest_
	end
	front_, nextSymbol_, rest_ = code:match("^%s*(..-)%s*(||)%s*(.+)%s*$")
	if front_ and (not front or #front_ < #front) then
		front = front_
		nextSymbol = nextSymbol_
		rest = rest_
	end
	if nextSymbol == "(" then
		local alpha, bravo, charlie = code:match("^([^%(]+%b())%s*([<>]=)%s*(.+)$")
		if not alpha then
			alpha, bravo, charlie = code:match("^([^%(]+%b())%s*(~=)%s*(.+)$")
		end
		if not alpha then
			alpha, bravo, charlie = code:match("^([^%(]+%b())%s*(||)%s*(.+)$")
		end
		if not alpha then
			alpha, bravo, charlie = code:match("^([^%(]+%b())%s*([:!%?%+%-%*/^%%<>=])%s*(.+)$")
		end
		if alpha then
			return alpha:trim(), bravo:trim(), splitCode(charlie, true)
		end
		local alpha = code:match("^([^%(]+%b())$")
		if alpha then
			return alpha:trim()
		end
	end
	if not front then
		return code
	end
	if rest:sub(1, 1) == "[" then
		for _, oplist in ipairs(ops) do
			if oplist[nextSymbol] then
				return front, nextSymbol, rest
			end
		end
	end
	return front, nextSymbol, splitCode(rest, true)
end

local FixCodeStyle

local function _splitParam(code)
	code = code:trim()
	local negate, tag, param = code:match("^(~*)%s*([a-zA-Z_#0-9%s]+)%s*(%b())$")
	if param then
		param = param:sub(2, -2)
	end
	if tag then
		local t, unit = tag:match("^([a-zA-Z_]+)%s*#%s*([a-zA-Z0-9_]+)$")
		if t then
			return t:trim(), param, ((negate:len() % 2) == 1 and true or false), unit:trim():lower()
		else
			return tag:trim(), param, ((negate:len() % 2) == 1 and true or false), nil
		end
	else
		negate, tag = code:match("^(~*)%s*(.+)$")
		if tag then
			local t, unit = tag:match("^([a-zA-Z_]+)%s*#%s*([a-zA-Z0-9_]+)$")
			if t then
				return t:trim(), nil, ((negate:len() % 2) == 1 and true or false), unit:trim():lower()
			else
				return tag:trim(), nil, ((negate:len() % 2) == 1 and true or false), nil
			end
		else
			return code:trim(), nil, nil, nil
		end
	end
end
local function splitParam(code, nsList)
	local code, param, negate, unit = _splitParam(code)
	code = correctCasing[code]
	if type(param) == "string" and param:find("%[.*%]") then
		param = FixCodeStyle(param, nil, nsList)
	end
	if negate then
		local neg_code = '~' .. code
		if getTag(neg_code, nil, nsList) or getModifier(neg_code, nil, nsList) then
			return neg_code, param, false, unit
		end
	end
	return code, param, negate, unit
end

local function joinParam(tag, param, negate, unit)
	if tag == "_" and param and param:find("^%[.*%]$") then
		local inner = param:sub(2, -2)
		if not inner:find("[%[%]:!%?%+%-%*/^%%<>=]") and not inner:find("~=") and not inner:find("||") then
			return inner
		end
		return param
	end
	local t = newList()
	if negate then
		t[#t+1] = "~"
	end
	t[#t+1] = tag
	if unit then
		t[#t+1] = "#"
		t[#t+1] = unit
	end
	if param then
		t[#t+1] = "("
		t[#t+1] = param
		t[#t+1] = ")"
	end
	local s = table_concat(t)
	t = del(t)
	return s
end

local parse, compileTree
local function _compileTree(code, globals, cachedTags, doneCachedTags, lastPossibleReturns, nsList)
	if type(code) == "string" then
		return code, 0, lastPossibleReturns
	end
	local ends
	local tmp
	code[1], ends, tmp = _compileTree(code[1], globals, cachedTags, doneCachedTags, lastPossibleReturns, nsList)
	if not code[1] then
		code = del(code)
		lastPossibleReturns = del(lastPossibleReturns)
		return nil, ends
	end
	lastPossibleReturns = tmp
	local t = newList()
	local finalPossibleReturns = newList()
	if not code[2] then
		local tag, param, negate, unit = splitParam(code[1], nsList)

		local func = getTag(tag, 'code', nsList)
		if func then
			local hasCache = false
			local firstCache = not doneCachedTags[code[1]]
			if cachedTags[code[1]] then
				hasCache = cachedTags[code[1]]
				doneCachedTags[code[1]] = true
				if not firstCache then
					t[#t+1] = "if "
					t[#t+1] = hasCache
					t[#t+1] = " ~= NIL then value = "
					t[#t+1] = hasCache
					t[#t+1] = ";"
					t[#t+1] = " else "
				end
			elseif code[1]:find("^~") and cachedTags[code[1]:sub(2)] then
				hasCache = cachedTags[code[1]:sub(2)]
				if tag:find("^~") then
					tag = tag:sub(2)
					negate = not negate
					func = Tags[tag]
					assert(func)
				end
				doneCachedTags[code[1]:sub(2)] = true
				if not firstCache then
					t[#t+1] = "if "
					t[#t+1] = hasCache
					t[#t+1] = " ~= NIL then value = not "
					t[#t+1] = hasCache
					t[#t+1] = " and "
					t[#t+1] = ("%q"):format(L["True"])
					t[#t+1] = "; else "
				end
			end
			local tag_arg = getTag(tag, 'arg', nsList)
			if param then
				if not tag_arg then
					t = del(t)
					code = del(code)
					lastPossibleReturns = del(lastPossibleReturns)
					finalPossibleReturns = del(finalPossibleReturns)
					return nil, ("%q Unexpected parameter to %q"):format(param, tag)
				end
				if tag_arg:find("number") then
					param = tonumber(param) or param
					if type(param) ~= "number" and not tag_arg:find("string") and not param:find("%[.*%]") then
						-- must be number
						t = del(t)
						code = del(code)
						lastPossibleReturns = del(lastPossibleReturns)
						finalPossibleReturns = del(finalPossibleReturns)
						return nil, ("%q Bad param to %q. Expected number."):format(param, tag)
					end
				end
			else
				if tag_arg and not tag_arg:find("nil") then
					t = del(t)
					code = del(code)
					lastPossibleReturns = del(lastPossibleReturns)
					finalPossibleReturns = del(finalPossibleReturns)
					return nil, ("%q Expected parameter"):format(tag)
				end
			end
			if unit and unit ~= "player" then
				if not IsLegitimateUnit[unit] then
					t = del(t)
					code = del(code)
					lastPossibleReturns = del(lastPossibleReturns)
					finalPossibleReturns = del(finalPossibleReturns)
					return nil, ("%q Unknown unit"):format(unit)
				end
				t[#t+1] = "if UnitExists('"
				t[#t+1] = unit
				t[#t+1] = "') then "
				ends = ends + 1
			end
			local tag_ret = getTag(tag, 'ret', nsList)
			if negate and not tag_ret:find("nil") then
				if hasCache then
					t[#t+1] = " end;"
				end
				t[#t+1] = "value = nil;"
				finalPossibleReturns["nil"] = true
			else
				local g = getTag(tag, 'globals', nsList)
				if g then
					g = newList((";"):split(g))
					for _,v in ipairs(g) do
						globals[v] = true
					end
					g = del(g)
				end

				if type(func) == "function" then
					local data = newList()
					data.isMod = false
					data.unit = unit
					data.unit_str = unit and ("(%q)"):format(unit) or "(unit)"
					data.arg = param
					data.arg_str = param and toliteral(param) or "(nil)"
					data.arg_string = param and ("(%q)"):format(param) or '("nil")'
					data.argtype = ("(%q)"):format(type(param))
					local hash = newDict('func', func(data))
					func = hash.func
					if hash.globals then
						g = newList((";"):split(hash.globals))
						for _,v in ipairs(g) do
							globals[v] = true
						end
						g = del(g)
					end
					hash = del(hash)
					data = del(data)
				end
				if param then
					if type(param) == "string" and param:find("%[.*%]") then
						local single = param:find("^%[[^%[%]]+%]$") and tag ~= "_"
						local possibleReturns

						if not single then
							if tag ~= "_" then
								t[#t+1] = "local v = value;"
							end
							
							local t_id = #t
							local madeT = false
							local t_numstart = math.random(1, 10000000)
							local t_num = t_numstart
							local t_literal = newList()
							local st = 1
							t[#t+1] = [[do ]]
							while st <= param:len() do
								local start, fin, left, literal = param:find("^(.-)(%b[])", st)
								if not start then
									local rest = param:sub(st)
									if rest:len() > 0 then
										if not madeT then
											t[#t+1] = "value = "
											t[#t+1] = ("%q"):format(rest)
											if possibleReturns then
												possibleReturns = del(possibleReturns)
											end
											possibleReturns = newSet("string")
										else
											t_literal[t_num+1] = rest
										end
									end
									break
								end
								if not madeT and (left:len() > 0 or start ~= 1 or fin ~= param:len()) then
									madeT = true
								end
								local inner = literal:sub(2, -2)
								st = fin+1
								if left:len() > 0 then
									t_literal[t_num] = left
								end

								if madeT then
									t[#t+1] = "do "
								end
								t[#t+1] = "value = nil;"

								local result, ret = compileTree(parse(splitCode(inner)), globals, cachedTags, doneCachedTags, nsList)
								for i,v in ipairs(result) do
									t[#t+1] = v
								end
								result = del(result)

								if madeT then
									t_num = t_num + 1
									t[#t+1] = "t_"
									t[#t+1] = t_num
									t[#t+1] = " = value or '';"
									t[#t+1] = [[end;]]
									if ret then
										ret = del(ret)
									end
								else
									possibleReturns = ret
								end
							end
							if madeT then
								for i = 1, t_num - t_numstart do
									table.insert(t, t_id + i*3 - 2, "local t_")
									table.insert(t, t_id + i*3 - 1, i + t_numstart)
									table.insert(t, t_id + i*3, " = '';")
								end
								t[#t+1] = [[value = ]]
								if t_literal[t_numstart] then
									t[#t+1] = ("%q"):format(t_literal[t_numstart])
									t[#t+1] = " .. "
								end
								for i = t_numstart+1, t_num+1 do
									if i <= t_num then
										t[#t+1] = "t_"
										t[#t+1] = i
										t[#t+1] = " .. "
									end
									if t_literal[i] then
										t[#t+1] = ("%q"):format(t_literal[i])
										t[#t+1] = " .. "
									end
								end
								t[#t] = [[;]]

								possibleReturns = newSet("string")
							end
							t_literal = del(t_literal)
							t[#t+1] = [[end;]]
						end
						if tag ~= "_" then
							if single then
								local result, ret = compileTree(parse(splitCode(param:sub(2, -2))), globals, cachedTags, doneCachedTags, nsList)
								t[#t+1] = "local arg;"
								for i,v in ipairs(result) do
									t[#t+1] = v:gsub("%f[A-Za-z0-9_]value%f[^A-Za-z0-9_]", "arg")
								end
								result = del(result)
								possibleReturns = ret
							else
								t[#t+1] = "local arg = value;"
							end
							local set = newSet((";"):split(getTag(tag, 'arg', nsList) or 'nil'))
							if set["nil"] then
								if set.number then
									if set.string then
										-- do nothing
									else
										if (not possibleReturns["nil"] and not possibleReturns.number) or possibleReturns.string then
											t[#t+1] = "arg = tonumber(arg);"
										end
									end
								else
									if set.string then
										if possibleReturns.number then
											if possibleReturns["nil"] then
												t[#t+1] = "if arg then arg = tostring(arg) end;"
											else
												t[#t+1] = "arg = tostring(arg);"
											end
										end
									else
										error(("Bad argument list. Can't just return nil. %q"):format(tag))
									end
								end
							else
								if set.number then
									if set.string then
										if possibleReturns["nil"] then
											t[#t+1] = "if not arg then arg = '' end;"
										end
									else
										if possibleReturns["nil"] or possibleReturns.string then
											t[#t+1] = "arg = tonumber(arg) or 0;"
										end
									end
								else
									if set.string then
										if not possibleReturns["nil"] then
											if possibleReturns.number then
												t[#t+1] = "arg = tostring(arg);"
											end
										else
											if possibleReturns.number then
												t[#t+1] = "if arg then arg = tostring(arg) else arg = '' end;"
											else
												t[#t+1] = "if not arg then arg = '' end;"
											end
										end
									else
										error(("Bad argument list. Can't just return nil. %q"):format(tag))
									end
								end
							end
							set = del(set)
							t[#t+1] = "value = v;"
						end
						if possibleReturns then
							possibleReturns = del(possibleReturns)
						end
						func = func:gsub("${arg}", "(arg)")
						func = func:gsub("%(${arg}%)", "(arg)")
						local pos = func:find("${arg:string}")
						if pos and func:find("${arg:string}", pos+1) then
							t[#t+1] = "local arg_string = tostring(arg);"
							func = func:gsub("%(${arg:string}%)", "(arg_string)")
							func = func:gsub("${arg:string}", "(arg_string)")
						else
							func = func:gsub("%(${arg:string}%)", "(tostring(arg))")
							func = func:gsub("${arg:string}", "(tostring(arg))")
						end
						local pos = func:find("${argtype}")
						if pos and func:find("${argtype}", pos+1) then
							t[#t+1] = "local argtype = type(arg);"
							func = func:gsub("%(${argtype}%)", "(argtype)")
							func = func:gsub("${argtype}", "(argtype)")
						else
							func = func:gsub("%(${argtype}%)", "(type(arg))")
							func = func:gsub("${argtype}", "(type(arg))")
						end
					else
						func = func:gsub("%(${arg}%)", toliteral(param))
						func = func:gsub("${arg}", toliteral(param))
						func = func:gsub("%(${arg:string}%)", ("(%q)"):format(param))
						func = func:gsub("${arg:string}", ("(%q)"):format(param))
						func = func:gsub("%(${argtype}%)", ("(%q)"):format(type(param)))
						func = func:gsub("${argtype}", ("(%q)"):format(type(param)))
					end
				else
					func = func:gsub("%(${arg}%)", "(nil)")
					func = func:gsub("${arg}", "(nil)")
					func = func:gsub("%(${arg:string}%)", '("nil")')
					func = func:gsub("${arg:string}", '("nil")')
					func = func:gsub("%(${argtype}%)", '("nil")')
					func = func:gsub("${argtype}", '("nil")')
				end
				if unit then
					func = func:gsub("%(${unit}%)", ("(%q)"):format(unit))
					func = func:gsub("${unit}", ("(%q)"):format(unit))
				else
					func = func:gsub("%(${unit}%)", "(unit)")
					func = func:gsub("${unit}", "(unit)")
				end
				if tag ~= "_" then
					t[#t+1] = " do "
					t[#t+1] = func
					if func ~= "" then
						t[#t+1] = ";"
					end
					t[#t+1] = " end;"
				end
				if hasCache then
					t[#t+1] = hasCache
					t[#t+1] = " = value;"
				end
				if negate then
					t[#t+1] = "value = not value and "
					t[#t+1] = ("%q"):format(L["True"])
					t[#t+1] = ";"
					finalPossibleReturns["string"] = true
					finalPossibleReturns["nil"] = true
				else
					local tagRet = newList((';'):split(getTag(tag, 'ret', nsList)))
					for _,v in ipairs(tagRet) do
						finalPossibleReturns[v] = true
					end
					tagRet = del(tagRet)
				end
				if hasCache and not firstCache then
					t[#t+1] = " end;"
				end
			end
		else
			t = del(t)
			code = del(code)
			lastPossibleReturns = del(lastPossibleReturns)
			finalPossibleReturns = del(finalPossibleReturns)
			return nil, ("%q Unknown tag"):format(tag)
		end
	elseif code[2] == "?" then
		if type(code[1]) == "string" then
			t[#t+1] = code[1]
		else
			for i,v in ipairs(code[1]) do
				t[#t+1] = v
			end
			code[1] = del(code[1])
		end
		t[#t+1] = ("if value then value = nil;")
		local q, e = _compileTree(code[3], globals, cachedTags, doneCachedTags, newSet("nil"), nsList)
		if not q then
			t = del(t)
			code = del(code)
			lastPossibleReturns = del(lastPossibleReturns)
			finalPossibleReturns = del(finalPossibleReturns)
			return nil, e
		end
		for i,v in ipairs(q) do
			t[#t+1] = v
		end
		q = del(q)
		for i = 1, e do
			t[#t+1] = "end;"
		end
		if code[4] == "!" then
			t[#t+1] = ("else ")
			local q, e = _compileTree(code[5], globals, cachedTags, doneCachedTags, newSet("nil"), nsList)
			if not q then
				t = del(t)
				code = del(code)
				lastPossibleReturns = del(lastPossibleReturns)
				finalPossibleReturns = del(finalPossibleReturns)
				return nil, e
			end
			for i,v in ipairs(q) do
				t[#t+1] = v
			end
			q = del(q)
			for i = 1, e do
				t[#t+1] = "end;"
			end
		end
		t[#t+1] = ("end;")
	elseif code[2] == "||" then
		if type(code[1]) == "string" then
			t[#t+1] = code[1]
		else -- table
			for i,v in ipairs(code[1]) do
				t[#t+1] = v
			end
			code[1] = del(code[1])
		end
		local tag, param, negate, unit = splitParam(code[3], nsList)
		local func = getTag(tag, 'code', nsList)
		if func then
			local hasCache = false
			local firstCache = not doneCachedTags[code[3]]
			if param then
				local arg = getTag(tag, 'arg', nsList)
				if not arg then
					t = del(t)
					code = del(code)
					lastPossibleReturns = del(lastPossibleReturns)
					finalPossibleReturns = del(finalPossibleReturns)
					return nil, ("%q Unexpected param to %q"):format(param, tag)
				end

				if arg:find("number") then
					param = tonumber(param) or param
					if type(param) ~= "number" and not arg:find("string") and not param:find("%[.*%]") then
						-- must be number
						t = del(t)
						code = del(code)
						lastPossibleReturns = del(lastPossibleReturns)
						finalPossibleReturns = del(finalPossibleReturns)
						return nil, ("%q Bad param to %q. Expected number."):format(param, tag)
					end
				end
			else
				local arg = getTag(tag, 'arg', nsList)
				if arg and not arg:find("nil") then
					t = del(t)
					code = del(code)
					lastPossibleReturns = del(lastPossibleReturns)
					finalPossibleReturns = del(finalPossibleReturns)
					return nil, ("%q Expected parameter"):format(tag)
				end
			end
			if unit and not IsLegitimateUnit[unit] then
				t = del(t)
				code = del(code)
				lastPossibleReturns = del(lastPossibleReturns)
				finalPossibleReturns = del(finalPossibleReturns)
				return nil, ("%q Unknown unit"):format(unit)
			end
			
			t[#t+1] = "if not value "
			if unit and unit ~= "player" then
				t[#t+1] = "and UnitExists('"
				t[#t+1] = unit
				t[#t+1] = "') "
			end
			t[#t+1] = "then "
			ends = ends + 1
		
			if cachedTags[code[3]] then
				hasCache = cachedTags[code[3]]
				doneCachedTags[code[3]] = true
				if not firstCache then
					t[#t+1] = "if "
					t[#t+1] = hasCache
					t[#t+1] = " ~= NIL then value = "
					t[#t+1] = hasCache
					t[#t+1] = ";"
					t[#t+1] = " else "
				end
			elseif code[3]:find("^~") and cachedTags[code[3]:sub(2)] then
				hasCache = cachedTags[code[3]:sub(2)]
				if tag:find("^~") then
					tag = tag:sub(2)
					negate = not negate
					func = getTag(tag, 'code', nsList)
					assert(func)
				end
				doneCachedTags[code[3]:sub(2)] = true
				if not firstCache then
					t[#t+1] = "if "
					t[#t+1] = hasCache
					t[#t+1] = " ~= NIL then value = not "
					t[#t+1] = hasCache
					t[#t+1] = " and "
					t[#t+1] = ("%q"):format(L["True"])
					t[#t+1] = "; else "
				end
			end
			if not negate or getTag(tag, 'ret', nsList):find("nil") then
				local g = getTag(tag, 'globals', nsList)
				if g then
					g = newList((";"):split(g))
					for _,v in ipairs(g) do
						globals[v] = true
					end
					g = del(g)
				end
				if type(func) == "function" then
					local data = newList()
					data.isMod = false
					data.unit = unit
					data.unit_str = unit and ("(%q)"):format(unit) or "(unit)"
					data.arg = param
					data.arg_str = param and toliteral(param) or "(nil)"
					data.arg_string = param and ("(%q)"):format(param) or '("nil")'
					data.argtype = ("(%q)"):format(type(param))
					local hash = newDict('func', func(data))
					func = hash.func
					if hash.globals then
						g = newList((";"):split(hash.globals))
						for _,v in ipairs(g) do
							globals[v] = true
						end
						g = del(g)
					end
					hash = del(hash)
					data = del(data)
				end
				if param then
					if type(param) == "string" and param:find("%[.*%]") then
						local single = param:find("^%[[^%[%]]+%]$") and tag ~= "_"
						local possibleReturns
						if not single then
							if tag ~= "_" then
								t[#t+1] = "local v = value;"
							end

							local t_id = #t
							local madeT = false
							local t_numstart = math.random(0, 10000000)
							local t_num = t_numstart
							local t_literal = newList()
							local st = 1
							t[#t+1] = [[do ]]
							while st <= param:len() do
								local start, fin, left, literal = param:find("^(.-)(%b[])", st)
								if not start then
									local rest = param:sub(st)
									if rest:len() > 0 then
										if not madeT then
											t[#t+1] = "value = "
											t[#t+1] = ("%q"):format(rest)
											if possibleReturns then
												possibleReturns = del(possibleReturns)
											end
											possibleReturns = newSet("string")
										else
											t_literal[t_num+1] = rest
										end
									end
									break
								end
								if not madeT and (left:len() > 0 or start ~= 1 or fin ~= param:len()) then
									madeT = true
								end
								local inner = literal:sub(2, -2)
								st = fin+1
								if left:len() > 0 then
									t_literal[t_num] = left
								end
							
								if madeT then
									t[#t+1] = "do "
								end
								t[#t+1] = "value = nil;"

								local result, ret = compileTree(parse(splitCode(inner)), globals, cachedTags, doneCachedTags, nsList)
								for i,v in ipairs(result) do
									t[#t+1] = v
								end
								result = del(result)
							
								if madeT then
									t_num = t_num + 1
									t[#t+1] = "t_"
									t[#t+1] = t_num
									t[#t+1] = " = value or '';"
									t[#t+1] = [[end;]]
								else
									possibleReturns = ret
								end
							end
							if madeT then
								for i = 1, t_num - t_numstart do
									table.insert(t, t_id + i*3 - 2, "local t_")
									table.insert(t, t_id + i*3 - 1, i + t_numstart)
									table.insert(t, t_id + i*3, " = '';")
								end
								t[#t+1] = [[value = ]]
								if t_literal[t_numstart] then
									t[#t+1] = ("%q"):format(t_literal[t_numstart])
									t[#t+1] = " .. "
								end
								for i = t_numstart+1, t_num+1 do
									if i <= t_num then
										t[#t+1] = "t_"
										t[#t+1] = i
										t[#t+1] = " .. "
									end
									if t_literal[i] then
										t[#t+1] = ("%q"):format(t_literal[i])
										t[#t+1] = " .. "
									end
								end
								t[#t] = [[;]]
								possibleReturns = newSet("string")
							end
							t_literal = del(t_literal)
							t[#t+1] = [[end;]]
						end
						if tag ~= "_" then
							if single then
								local result, ret = compileTree(parse(splitCode(param:sub(2, -2))), globals, cachedTags, doneCachedTags, nsList)
								t[#t+1] = "local arg;"
								for i,v in ipairs(result) do
									t[#t+1] = v:gsub("%f[A-Za-z0-9_]value%f[^A-Za-z0-9_]", "arg")
								end
								result = del(result)
								possibleReturns = ret
							else
								t[#t+1] = "local arg = value;"
							end
							local set = newSet((";"):split(getTag(tag, 'arg', nsList) or 'nil'))
							if set["nil"] then
								if set.number then
									if set.string then
										-- do nothing
									else
										if (not possibleReturns["nil"] and not possibleReturns.number) or possibleReturns.string then
											t[#t+1] = "arg = tonumber(arg);"
										end
									end
								else
									if set.string then
										if possibleReturns.number then
											if possibleReturns["nil"] then
												t[#t+1] = "if arg then arg = tostring(arg) end;"
											else
												t[#t+1] = "arg = tostring(arg);"
											end
										end
									else
										error(("Bad argument list. Can't just return nil. %q"):format(tag))
									end
								end
							else
								if set.number then
									if set.string then
										if possibleReturns["nil"] then
											t[#t+1] = "if not arg then arg = '' end;"
										end
									else
										if possibleReturns["nil"] or possibleReturns.string then
											t[#t+1] = "arg = tonumber(arg) or 0;"
										end
									end
								else
									if set.string then
										if not possibleReturns["nil"] then
											if possibleReturns.number then
												t[#t+1] = "arg = tostring(arg);"
											end
										else
											if possibleReturns.number then
												t[#t+1] = "if arg then arg = tostring(arg) else arg = '' end;"
											else
												t[#t+1] = "if not arg then arg = '' end;"
											end
										end
									else
										error(("Bad argument list. Can't just return nil. %q"):format(tag))
									end
								end
							end
							set = del(set)
							if not single then
								t[#t+1] = "value = v;"
							end
						end
						if possibleReturns then
							possibleReturns = del(possibleReturns)
						end
						func = func:gsub("%(${arg}%)", "(arg)")
						func = func:gsub("${arg}", "(arg)")
						local pos = func:find("${arg:string}")
						if pos and func:find("${arg:string}", pos+1) then
							t[#t+1] = "local arg_string = tostring(arg);"
							func = func:gsub("%(${arg:string}%)", "(arg_string)")
							func = func:gsub("${arg:string}", "(arg_string)")
						else
							func = func:gsub("%(${arg:string}%)", "(tostring(arg))")
							func = func:gsub("${arg:string}", "(tostring(arg))")
						end
						local pos = func:find("${argtype}")
						if pos and func:find("${argtype}", pos+1) then
							t[#t+1] = "local argtype = type(arg);"
							func = func:gsub("%(${argtype}%)", "(argtype)")
							func = func:gsub("${argtype}", "(argtype)")
						else
							func = func:gsub("%(${argtype}%)", "(type(arg))")
							func = func:gsub("${argtype}", "(type(arg))")
						end
					else
						func = func:gsub("%(${arg}%)", toliteral(param))
						func = func:gsub("${arg}", toliteral(param))
						func = func:gsub("%(${arg:string}%)", ("(%q)"):format(param))
						func = func:gsub("${arg:string}", ("(%q)"):format(param))
						func = func:gsub("%(${argtype}%)", ("(%q)"):format(type(param)))
						func = func:gsub("${argtype}", ("(%q)"):format(type(param)))
					end
				else
					func = func:gsub("%(${arg}%)", "(nil)")
					func = func:gsub("${arg}", "(nil)")
					func = func:gsub("%(${arg:string}%)", '("nil")')
					func = func:gsub("${arg:string}", '("nil")')
					func = func:gsub("%(${argtype}%)", '("nil")')
					func = func:gsub("${argtype}", '("nil")')
				end
				if unit then
					func = func:gsub("%(${unit}%)", ("(%q)"):format(unit))
					func = func:gsub("${unit}", ("(%q)"):format(unit))
				else
					func = func:gsub("%(${unit}%)", "(unit)")
					func = func:gsub("${unit}", "(unit)")
				end
				if tag ~= "_" then
					t[#t+1] = func
					if func ~= "" then
						t[#t+1] = ";"
					end
				end
				if hasCache then
					t[#t+1] = hasCache
					t[#t+1] = " = value;"
				end
				if hasCache and not firstCache then
					t[#t+1] = " end;"
				end
				if negate then
					t[#t+1] = "value = not value and "
					t[#t+1] = ("%q"):format(L["True"])
					t[#t+1] = ";"
					finalPossibleReturns["string"] = true
					finalPossibleReturns["nil"] = true
				end
				if not negate then
					local rets = newSet((';'):split(getTag(tag, 'ret', nsList)))
					if rets.same then
						rets.same = nil
						if not lastPossibleReturns.number and not lastPossibleReturns.string then
							finalPossibleReturns.number = true
							finalPossibleReturns.string = true
						else
							finalPossibleReturns.number = lastPossibleReturns.number
							finalPossibleReturns.string = lastPossibleReturns.string
						end
					end
					for v in pairs(rets) do
						finalPossibleReturns[v] = true
					end
					if lastPossibleReturns["nil"] then
						finalPossibleReturns["nil"] = true
					end
					if lastPossibleReturns.number then
						finalPossibleReturns.number = true -- FIXME
					end
					if lastPossibleReturns.string then
						finalPossibleReturns.string = true -- FIXME
					end
					rets = del(rets)
				end
			else
				t[#t+1] = "value = nil;"
			end
		else
			t = del(t)
			code = del(code)
			lastPossibleReturns = del(lastPossibleReturns)
			finalPossibleReturns = del(finalPossibleReturns)
			return nil, ("%q Unknown tag"):format(tag)
		end
	elseif code[2] == ":" then
		if type(code[1]) == "string" then
			t[#t+1] = code[1]
		else -- table
			for i,v in ipairs(code[1]) do
				t[#t+1] = v
			end
			code[1] = del(code[1])
		end
		local mod, param, negate, unit = splitParam(code[3], nsList)
		local func = getModifier(mod, 'code', nsList)
		if func then
			local hasCache = false
			local firstCache = not doneCachedTags[code[3]]
			if param then
				local arg = getModifier(mod, 'arg', nsList)
				if not arg then
					t = del(t)
					code = del(code)
					lastPossibleReturns = del(lastPossibleReturns)
					finalPossibleReturns = del(finalPossibleReturns)
					return nil, ("%q Unexpected param to %q"):format(param, mod)
				end

				if arg:find("number") then
					param = tonumber(param) or param
					if type(param) ~= "number" and not arg:find("string") and not param:find("%[.*%]") then
						-- must be number
						t = del(t)
						code = del(code)
						lastPossibleReturns = del(lastPossibleReturns)
						finalPossibleReturns = del(finalPossibleReturns)
						return nil, ("%q Bad param to %q. Expected number."):format(param, mod)
					end
				end
			else
				local arg = getModifier(mod, 'arg', nsList)
				if arg and not arg:find("nil") then
					t = del(t)
					code = del(code)
					lastPossibleReturns = del(lastPossibleReturns)
					finalPossibleReturns = del(finalPossibleReturns)
					return nil, ("%q Expected parameter"):format(mod)
				end
			end
			if unit and not IsLegitimateUnit[unit] then
				t = del(t)
				code = del(code)
				lastPossibleReturns = del(lastPossibleReturns)
				finalPossibleReturns = del(finalPossibleReturns)
				return nil, ("%q Unknown unit"):format(unit)
			end
			local val = getModifier(mod, 'value', nsList)
			if val and ((val == "number" and lastPossibleReturns["string"]) or (val == "string" and lastPossibleReturns["number"])) then
				t[#t+1] = [[if type(value) == "]]
				t[#t+1] = val
				t[#t+1] = [[" ]]
				if unit and unit ~= "player" then
					t[#t+1] = "and UnitExists('"
					t[#t+1] = unit
					t[#t+1] = "') "
				end
				t[#t+1] = "then "
				if val == "number" then
					if lastPossibleReturns.string then
						finalPossibleReturns.string = true
					end
				else
					if lastPossibleReturns.number then
						finalPossibleReturns.number = true
					end
				end
			elseif lastPossibleReturns["nil"] then
				t[#t+1] = "if value "
				if unit and unit ~= "player" then
					t[#t+1] = "and UnitExists('"
					t[#t+1] = unit
					t[#t+1] = "') "
				end
				t[#t+1] = "then "
			elseif unit and unit ~= "player" then
				t[#t+1] = "if UnitExists('"
				t[#t+1] = unit
				t[#t+1] = "') "
				t[#t+1] = "then "
			else
				t[#t+1] = "do "
			end
			if not negate or getModifier(mod, 'ret', nsList):find("nil") then
				if negate then
					t[#t+1] = "local old_value = value;"
				end
				local g = getModifier(mod, 'globals', nsList)
				if g then
					g = newList((";"):split(g))
					for _,v in ipairs(g) do
						globals[v] = true
					end
					g = del(g)
				end
				if type(func) == "function" then
					local data = newList()
					data.isMod = true
					data.unit = unit
					data.unit_str = unit and ("(%q)"):format(unit) or "(unit)"
					data.arg = param
					data.arg_str = param and toliteral(param) or "(nil)"
					data.arg_string = param and ("(%q)"):format(param) or '("nil")'
					data.argtype = ("(%q)"):format(type(param))
					local hash = newDict('func', func(data))
					func = hash.func
					if hash.globals then
						g = newList((";"):split(hash.globals))
						for _,v in ipairs(g) do
							globals[v] = true
						end
						g = del(g)
					end
					hash = del(hash)
					data = del(data)
				end
				if param then
					if type(param) == "string" and param:find("%[.*%]") then
						local single = param:find("^%[[^%[%]]+%]$")
						local possibleReturns
						if not single then
							t[#t+1] = "local v = value;"

							local t_id = #t
							local madeT = false
							local t_numstart = math.random(0, 10000000)
							local t_num = t_numstart
							local t_literal = newList()
							local st = 1
							t[#t+1] = [[do ]]
							while st <= param:len() do
								local start, fin, left, literal = param:find("^(.-)(%b[])", st)
								if not start then
									local rest = param:sub(st)
									if rest:len() > 0 then
										if not madeT then
											t[#t+1] = "value = "
											t[#t+1] = ("%q"):format(rest)
											if possibleReturns then
												possibleReturns = del(possibleReturns)
											end
											possibleReturns = newSet("string")
										else
											t_literal[t_num+1] = rest
										end
									end
									break
								end
								if not madeT and (left:len() > 0 or start ~= 1 or fin ~= param:len()) then
									madeT = true
								end
								local inner = literal:sub(2, -2)
								st = fin+1
								if left:len() > 0 then
									t_literal[t_num] = left
								end
								
								if madeT then
									t[#t+1] = "do "
								end
								t[#t+1] = "value = nil;"

								local result, ret = compileTree(parse(splitCode(inner)), globals, cachedTags, doneCachedTags, nsList)
								for i,v in ipairs(result) do
									t[#t+1] = v
								end
								result = del(result)
								
								if madeT then
									t_num = t_num + 1
									t[#t+1] = "t_"
									t[#t+1] = t_num
									t[#t+1] = " = value or '';"
									t[#t+1] = [[end;]]
								else
									possibleReturns = ret
								end
							end
							if madeT then
								for i = 1, t_num - t_numstart do
									table.insert(t, t_id + i*3 - 2, "local t_")
									table.insert(t, t_id + i*3 - 1, i + t_numstart)
									table.insert(t, t_id + i*3, " = '';")
								end
								t[#t+1] = [[value = ]]
								if t_literal[t_numstart] then
									t[#t+1] = ("%q"):format(t_literal[t_numstart])
									t[#t+1] = " .. "
								end
								for i = t_numstart+1, t_num+1 do
									if i <= t_num then
										t[#t+1] = "t_"
										t[#t+1] = i
										t[#t+1] = " .. "
									end
									if t_literal[i] then
										t[#t+1] = ("%q"):format(t_literal[i])
										t[#t+1] = " .. "
									end
								end
								t[#t] = [[;]]
								possibleReturns = newSet("string")
							end
							t_literal = del(t_literal)
							t[#t+1] = [[end;]]
						end
						if single then
							local result, ret = compileTree(parse(splitCode(param:sub(2, -2))), globals, cachedTags, doneCachedTags, nsList)
							t[#t+1] = "local arg;"
							for i,v in ipairs(result) do
								t[#t+1] = v:gsub("%f[A-Za-z0-9_]value%f[^A-Za-z0-9_]", "arg")
							end
							result = del(result)
							possibleReturns = ret
						else
							t[#t+1] = "local arg = value;"
						end
						local set = newSet((";"):split(getModifier(mod, 'arg', nsList) or 'nil'))
						if set["nil"] then
							if set.number then
								if set.string then
									-- do nothing
								else
									if (not possibleReturns["nil"] and not possibleReturns.number) or possibleReturns.string then
										t[#t+1] = "arg = tonumber(arg);"
									end
								end
							else
								if set.string then
									if possibleReturns.number then
										if possibleReturns["nil"] then
											t[#t+1] = "if arg then arg = tostring(arg) end;"
										else
											t[#t+1] = "arg = tostring(arg);"
										end
									end
								else
									error(("Bad argument list. Can't just return nil. %q"):format(mod))
								end
							end
						else
							if set.number then
								if set.string then
									if possibleReturns["nil"] then
										t[#t+1] = "if not arg then arg = '' end;"
									end
								else
									if possibleReturns["nil"] or possibleReturns.string then
										t[#t+1] = "arg = tonumber(arg) or 0;"
									end
								end
							else
								if set.string then
									if not possibleReturns["nil"] then
										if possibleReturns.number then
											t[#t+1] = "arg = tostring(arg);"
										end
									else
										if possibleReturns.number then
											t[#t+1] = "if arg then arg = tostring(arg) else arg = '' end;"
										else
											t[#t+1] = "if not arg then arg = '' end;"
										end
									end
								else
									error(("Bad argument list. Can't just return nil. %q"):format(mod))
								end
							end
						end
						set = del(set)
						if not single then
							t[#t+1] = "value = v;"
						end
						if possibleReturns then
							possibleReturns = del(possibleReturns)
						end
						func = func:gsub("%(${arg}%)", "(arg)")
						func = func:gsub("${arg}", "(arg)")
						local pos = func:find("${arg:string}")
						if pos and func:find("${arg:string}", pos+1) then
							t[#t+1] = "local arg_string = tostring(arg);"
							func = func:gsub("%(${arg:string}%)", "(arg_string)")
							func = func:gsub("${arg:string}", "(arg_string)")
						else
							func = func:gsub("%(${arg:string}%)", "(tostring(arg))")
							func = func:gsub("${arg:string}", "(tostring(arg))")
						end
						local pos = func:find("${argtype}")
						if pos and func:find("${argtype}", pos+1) then
							t[#t+1] = "local argtype = type(arg);"
							func = func:gsub("%(${argtype}%)", "(argtype)")
							func = func:gsub("${argtype}", "(argtype)")
						else
							func = func:gsub("%(${argtype}%)", "(type(arg))")
							func = func:gsub("${argtype}", "(type(arg))")
						end
					else
						func = func:gsub("%(${arg}%)", toliteral(param))
						func = func:gsub("${arg}", toliteral(param))
						func = func:gsub("%(${arg:string}%)", ("(%q)"):format(param))
						func = func:gsub("${arg:string}", ("(%q)"):format(param))
						func = func:gsub("%(${argtype}%)", ("(%q)"):format(type(param)))
						func = func:gsub("${argtype}", ("(%q)"):format(type(param)))
					end
				else
					func = func:gsub("%(${arg}%)", "(nil)")
					func = func:gsub("${arg}", "(nil)")
					func = func:gsub("%(${arg:string}%)", '("nil")')
					func = func:gsub("${arg:string}", '("nil")')
					func = func:gsub("%(${argtype}%)", '("nil")')
					func = func:gsub("${argtype}", '("nil")')
				end
				if unit then
					func = func:gsub("%(${unit}%)", ("(%q)"):format(unit))
					func = func:gsub("${unit}", ("(%q)"):format(unit))
				else
					func = func:gsub("%(${unit}%)", "(unit)")
					func = func:gsub("${unit}", "(unit)")
				end
				t[#t+1] = func
				if func ~= "" then
					t[#t+1] = ";"
				end
				if hasCache then
					t[#t+1] = hasCache
					t[#t+1] = " = value;"
				end
				if hasCache and not firstCache then
					t[#t+1] = " end;"
				end
				if negate then
					t[#t+1] = "value = not value and old_value end;"
					finalPossibleReturns["string"] = true
					finalPossibleReturns["nil"] = true
				else
					t[#t+1] = " end;"
				end
				if not negate then
					local rets = newSet((';'):split(getModifier(mod, 'ret', nsList)))
					if rets.same then
						rets.same = nil
						if not lastPossibleReturns.number and not lastPossibleReturns.string then
							finalPossibleReturns.number = true
							finalPossibleReturns.string = true
						else
							finalPossibleReturns.number = lastPossibleReturns.number
							finalPossibleReturns.string = lastPossibleReturns.string
						end
					end
					for v in pairs(rets) do
						finalPossibleReturns[v] = true
					end
					if lastPossibleReturns["nil"] then
						finalPossibleReturns["nil"] = true
					end
					if lastPossibleReturns.number then
						finalPossibleReturns.number = true -- FIXME
					end
					if lastPossibleReturns.string then
						finalPossibleReturns.string = true -- FIXME
					end
					rets = del(rets)
				end
			else
				t[#t+1] = "value = nil;"
				t[#t+1] = "end;"
			end
		else
			t = del(t)
			code = del(code)
			lastPossibleReturns = del(lastPossibleReturns)
			finalPossibleReturns = del(finalPossibleReturns)
			return nil, ("%q Unknown modifier"):format(mod)
		end
	else
		t = del(t)
		local code_2 = code[2]
		code = del(code)
		lastPossibleReturns = del(lastPossibleReturns)
		finalPossibleReturns = del(finalPossibleReturns)
		return nil, ("%q Unknown separator"):format(code_2)
	end
	code = del(code)
	lastPossibleReturns = del(lastPossibleReturns)
	return t, ends, finalPossibleReturns
end

function compileTree(code, globals, cachedTags, doneCachedTags, nsList)
	local madeDoneCachedTags = not doneCachedTags
	if madeDoneCachedTags then
		doneCachedTags = newList()
	end
	local q, e, possibleReturns = _compileTree(code, globals, cachedTags, doneCachedTags, newSet("nil"), nsList)
	if not q then
		return newList(("value = %q;"):format(e)), newSet("string")
	end
	for i = 1, e do
		q[#q+1] = "end;"
	end
	if madeDoneCachedTags then
		doneCachedTags = del(doneCachedTags)
	end
	return q, possibleReturns
end

local function select2(min, max, ...)
	if min <= max then
		return select(min, ...), select2(min+1, max, ...)
	end
end

function parse(...)
	local n = select('#', ...)
	if n == 1 then
		return newList((...))
	end
	local q_num = 0
	local q_pos
	local x_pos
	for i = 1, n do
		if select(i, ...) == "?" then
			q_num = q_num + 1
			if not q_pos then
				q_pos = i
			end
		elseif select(i, ...) == "!" then
			q_num = q_num - 1
			if q_num == 0 then
				x_pos = i
				break
			end
		end
	end
	if q_pos then
		if not x_pos then
			return newList(parse(select2(1, q_pos - 1, ...)), "?", parse(select(q_pos + 1, ...)))
		else
			return newList(parse(select2(1, q_pos - 1, ...)), "?", parse(select2(q_pos + 1, x_pos - 1, ...)), "!", parse(select(x_pos + 1, ...)))
		end
	end
	return newList(parse(select2(1, n - 2, ...)), select(n-1, ...))
end

local function cleanText(text)
	while true do
		local lastText = text
		text = string_gsub(text, " +$", "")
		text = string_gsub(text, "^ +", "")
		text = string_gsub(text, "  +", " ")
		text = string_gsub(text, "|| ||", "||")
		text = string_gsub(text, "^||", "")
		text = string_gsub(text, "||$", "")
		if text == lastText then
			if text == "" then
				return " "
			end
			return text
		end
	end
end

local UnitToLocale = {player = L["Player"], target = L["Target"], pet = L["%s's pet"]:format(L["Player"]), focus = L["Focus-target"], mouseover = L["Mouse-over"]}
setmetatable(UnitToLocale, {__index=function(self, unit)
	if unit:find("pet$") then
		local nonPet = unit:sub(1, -4)
		self[unit] = L["%s's pet"]:format(self[nonPet])
		return self[unit]
	elseif not unit:find("target$") then
		if unit:find("^party%d$") then
			local num = unit:match("^party(%d)$")
			self[unit] = L["Party member #%d"]:format(num)
			return self[unit]
		elseif unit:find("^raid%d%d?$") then
			local num = unit:match("^raid(%d%d?)$")
			self[unit] = L["Raid member #%d"]:format(num)
			return self[unit]
		elseif unit:find("^partypet%d$") then
			local num = unit:match("^partypet(%d)$")
			self[unit] = UnitToLocale["party" .. num .. "pet"]
			return self[unit]
		elseif unit:find("^raidpet%d%d?$") then
			local num = unit:match("^raidpet(%d%d?)$")
			self[unit] = UnitToLocale["raid" .. num .. "pet"]
			return self[unit]
		end
		self[unit] = unit
		return unit
	end
	local nonTarget = unit:sub(1, -7)
	self[unit] = L["%s's target"]:format(self[nonTarget])
	return self[unit]
end})

local figureCachedTags
do
	local _figureCachedTags
	local function __figureCachedTags(code, data)
		for i = 1, #code, 2 do
			local v = code[i]
			if type(v) == "table" then
				__figureCachedTags(v, data)
			else
				local tag, param, negate, unit = splitParam(v, "Base") -- keep this Base
				if param and param:find("%[.*%]") then
					_figureCachedTags(v, data)
				else
					local good = false
					for ns, data in pairs(Tags) do
						if data[tag] then
							good = true
						end
					end
					if good and tag ~= "Text" then
						data[v] = (data[v] or 0) + 1
					end
				end
			end
		end
	end
	function _figureCachedTags(code, data)
		local st = 1
		while st <= code:len() do
			local start, fin, left, literal = code:find("^(.-)(%b[])", st)
			if not start then
				break
			end
			local inner = literal:sub(2, -2)
			st = fin+1
			local tree = parse(splitCode(inner))
			__figureCachedTags(tree, data)
		end
	end
	function figureCachedTags(code)
		local data = newList()
		_figureCachedTags(code, data)
		for k, v in pairs(data) do
			if k:find("^~") and data[k:sub(2)] then
				data[k:sub(2)] = data[k:sub(2)] + v
				data[k] = nil
			end
		end
		for k, v in pairs(data) do
			if v == 1 then
				data[k] = nil
			else
				data[k] = "cache_" .. k:gsub("[^A-Za-z0-9_]", "_")
			end
		end
		return data
	end
end

local antiAlias
local antiAliasNamespace
do
	local antiAliasWithUnit
	local handler__unit = nil
	local handler__nsList = nil
	local function handler(literal)
		local inner = literal:sub(2,-2)
		local code = newList(splitCode(inner))
		for i = 1, #code, 2 do
			local bit = code[i]
			if tonumber(bit) then
				code[i] = "Text(" .. bit .. ")"
			end
			
			local bit, param, negate, unit = splitParam(code[i], handler__nsList)
			if code[i-1] == ":" and getTag(bit, nil, handler__nsList) and not getModifier(bit, nil, handler__nsList) then
				code[i-1] = "||"
			end
		end
		for _, opList in ipairs(ops) do
			for i = 2, #code-1, 2 do
				local op = code[i]
				if opList[op] then
					local nextOp_pos
					for j = i+2, #code-1, 2 do
						local nextOp = code[j]
						if opSet[op] then
							nextOp_pos = j
							break
						end
					end
					code[i] = ":" .. opList[op] .. "(["
					if nextOp_pos then
						table.insert(code, nextOp_pos, "])")
					else
						code[#code+1] = "])"
					end
					table.insert(code, 1, "[")
					code[#code+1] = "]"
					local text = table.concat(code)
					code = del(code)
					return handler(text)
				end
			end
		end
		local real = newList()
		for i = 1, #code, 2 do
			local bit, param, negate, unit = splitParam(code[i], handler__nsList)
			if not unit then
				unit = handler__unit
			end
			local func
			local isMod = false
			if code[i-1] ~= ":" then
				func = not getTag(bit, 'code', handler__nsList) and getTag(bit, 'alias', handler__nsList)
			else
				func = not getModifier(bit, 'code', handler__nsList) and getModifier(bit, 'alias', handler__nsList)
				isMod = true
			end
			if i == 1 then
				real[1] = "["
			else
				real[#real+1] = code[i-1]
			end
			if negate then
				real[#real+1] = "~"
			end
			if type(param) == "string" and param:find("%[.*%]") then
				if param:match("^%[(%d+)%]$") then
					param = param:match("^%[(%d+)%]$")
				else
					param = antiAliasWithUnit(param, unit, handler__nsList)
				end
			end
			if func then
				local group = not isMod and (func:find("[:!%?%+%-%*/^%%<>=]") or func:find("~=") or func:find("||"))
				if group then
					if negate then
						real[#real+1] = "Text(["
					else
						real[#real+1] = "_(["
					end
				end
				if param and (func:find("[%(:!%?%+%-%*/^%%<>=]") or func:find("~=") or func:find("||")) then
					if func:find("%(arg%)") then
						real[#real+1] = func:gsub("%(arg%)", "(" .. param .. ")")
					else
						real[#real+1] = joinParam(bit, param, nil, unit)
					end
				elseif unit and func:find("#") then
					real[#real+1] = joinParam(bit, param, nil, unit)
				elseif not func:find("[:!%?%+%-%*/^%%<>=]") and not func:find("~=") and not func:find("||") then
					local fbit, fparam, fnegate, funit = splitParam(func, handler__nsList)
					real[#real+1] = joinParam(fbit, antiAliasWithUnit(fparam, unit, handler__nsList) or param, fnegate, funit or unit)
				elseif unit then
					if param then
						real[#real+1] = joinParam(bit, param, nil, unit)
					else
						local fcode = newList(splitCode(func))
						for j = 1, #fcode, 2 do
							if j > 1 then
								real[#real+1] = fcode[j-1]
							end
							local fbit, fparam, fnegate, funit = splitParam(fcode[j], handler__nsList)
							real[#real+1] = joinParam(fbit, antiAliasWithUnit(fparam, unit, handler__nsList), fnegate, unit)
						end
					end
				else
					real[#real+1] = func
					if param then
						real[#real+1] = "("
						real[#real+1] = param
						real[#real+1] = ")"
					end
				end
				if group then
					real[#real+1] = "])"
				end
			else
				real[#real+1] = joinParam(bit, param, nil, unit)
			end
		end
		code = del(code)

		real[#real+1] = ']'
		local str = table_concat(real):gsub("~~", "")
		real = del(real)
		return str
	end
	function antiAliasWithUnit(key, unit, nsList)
		if key == nil then
			return nil
		end
		if unit == nil then
			local value = rawget(antiAliasNamespace[nsList], key)
			if value then
				return value
			end
		end
		local value = key:gsub("~~", "")
		while true do
			local lastValue = value
			local last_handler__unit = handler__unit
			local last_handler__nsList = handler__nsList
			handler__unit = unit
			handler__nsList = nsList
			value = lastValue:gsub("(%b[])", handler)
			handler__unit = last_handler__unit
			handler__nsList = last_handler__nsList
			if value == lastValue then
				break
			end
		end
		if unit == nil then
			antiAliasNamespace[nsList][key] = value
		end
		return value
	end
	local mt = {__index = function(self, key)
		local nsList = self[0]
		return antiAliasWithUnit(key, nil, nsList)
	end, __mode = 'k'}
	antiAliasNamespace = setmetatable({}, {__index = function(self, key)
		self[key] = setmetatable({[0] = key}, mt)
		return self[key]
	end})
	function antiAlias(key, nsList)
		if key == nil then
			return nil
		end
		return antiAliasNamespace[nsList][key]
	end
end

--[[
Notes:
	Some tags are mere aliases of others, UnaliasCode can turn these into the proper form as seen on the backend. It is unlikely this would need to be called by most addons.
Arguments:
	string - a tag sequence
	tuple - tuple of extra namespaces used
Returns:
	string - an unalised form of the given tag sequence
]]
function DogTag:UnaliasCode(code, ...)
	if type(code) ~= "string" then
		error(("Bad argument #2 to `UnaliasCode'. Expected %q, got %q"):format("string", type(code)), 2)
	end
	for i = 1, select('#', ...) do
		if type(select(i, ...)) ~= "string" then
			error(("Bad argument #%d to `UnaliasCode'. Expected %q, got %q"):format(i+2, "string", type(select(i, ...))), 2)
		end
	end
	return antiAlias(code, getNamespaceList(...))
end

local function enumLines(text)
	local lines = newList(('\n'):split(text))
	local t = newList()
	local indent = 0
	for i, v in ipairs(lines) do
		if v:match("end;?$") or v:match("else$") or v:match("^ *elseif") then
			indent = indent - 1
		end
		for j = 1, indent do
			t[#t+1] = "    "
		end
		t[#t+1] = v
		t[#t+1] = " -- "
		t[#t+1] = i
		t[#t+1] = "\n"
		if v:match("then$") or v:match("do$") or v:match("else$") then
			indent = indent + 1
		end
	end
	lines = del(lines)
	local s = table_concat(t)
	t = del(t)
	return s
end

--[[
Notes:
	This is mostly used for debugging purposes
Arguments:
	string - a tag sequence
	tuple - tuple of extra namespaces
Returns:
	string - a block of code which could have loadstring called on it.
]]
function DogTag:CreateFunctionFromCode(code, ...)
	if type(code) ~= "string" then
		error(("Bad argument #2 to `CreateFunctionFromCode'. Expected %q, got %q."):format("string", type(code)), 2)
	end
	local notDebug = (...) == true
	local nsList
	if notDebug then
		nsList = getNamespaceList(select(2, ...))
	else
		for i = 1, select('#', ...) do
			if type(select(i, ...)) ~= "string" then
				error(("Bad argument #%d to `CreateFunctionFromCode'. Expected %q, got %q"):format(i+2, "string", type(select(i, ...))), 2)
			end
		end
		nsList = getNamespaceList(...)
	end
	code = antiAlias(code, nsList)
	if cleanText(code) == "" then
		return ""
	end
	local cachedTags = figureCachedTags(code)
	local t = newList()
	t[#t+1] = ([[local DogTag = LibStub(%q);]]):format(MAJOR_VERSION)
	t[#t+1] = [[local colors = DogTag.__colors;]]
	t[#t+1] = [[local NIL = DogTag.__NIL;]]
	t[#t+1] = [[local cleanText = DogTag.__cleanText;]]
	t[#t+1] = [[return function(unit) ]]
	for k, v in pairs(cachedTags) do
		t[#t+1] = "local "
		t[#t+1] = v
		t[#t+1] = " = NIL;"
	end
	t[#t+1] = "local opacity;"
	t[#t+1] = [[if not UnitExists(unit) then return ]]
	local globals = newList()
	globals['table.concat'] = true
	globals['string.gsub'] = true
	globals['type'] = true
	globals['tonumber'] = true
	globals['UnitExists'] = true
	if code:find("[%[:!%?%+%-%*/^%%<>=~|][Nn][Aa][Mm][Ee][%]:!%?%+%-%*/^%%<>=~|]") then
		t[#t+1] = [=[DogTag___UnitToLocale[unit]]=]
		globals['DogTag.__UnitToLocale'] = true
	else
		t[#t+1] = [[""]]
	end
	t[#t+1] = [[; end;]]
	local tmp_id = #t
	local madeTmp = false
	local tmp_num = 0
	local tmp_literal = newList()
	local st = 1
	while st <= code:len() do
		local start, fin, left, literal = code:find("^(.-)(%b[])", st)
		if not start then
			local rest = code:sub(st)
			if rest:len() > 0 then
				if not madeTmp then
					t[#t+1] = ("return %q"):format(rest)
				else
					tmp_literal[tmp_num+1] = rest
				end
			end
			break
		end
		if not madeTmp and (left:len() > 0 or start ~= 1 or fin ~= code:len()) then
			madeTmp = true
		end
		local inner = literal:sub(2, -2)
		st = fin+1
		if left:len() > 0 then
			tmp_literal[tmp_num] = left
		end
		if st < code:len() then
			madeTmp = true
		end

		t[#t+1] = "do local value;"

		local result, ret = compileTree(parse(splitCode(inner)), globals, cachedTags, nil, nsList)
		if ret then
			ret = del(ret)
		end
		for i,v in ipairs(result) do
			t[#t+1] = v
		end
		result = del(result)
		if not madeTmp then
			t[#t+1] = [[return cleanText(value or ''), opacity;]]
		else
			tmp_num = tmp_num + 1
			t[#t+1] = "tmp_"
			t[#t+1] = tmp_num
			t[#t+1] = " = value or '';"
		end
		t[#t+1] = [[end;]]
	end
	for i = 1, tmp_num do
		table.insert(t, tmp_id + i*3 - 2, "local tmp_")
		table.insert(t, tmp_id + i*3 - 1, i)
		table.insert(t, tmp_id + i*3, " = '';")
	end
	local u = newList()
	for k in pairs(globals) do
		if k:find("[A-Za-z%-]*%-%d%.%d") then
			if Rock then
				Rock(k, false, true) -- try to load
			end
			if AceLibrary then
				AceLibrary:HasInstance(k) -- try to load
			end
			if LibStub(k, true) then
				-- catches Rock and AceLibrary
				u[#u+1] = "local "
				u[#u+1] = k:gsub("%-.*", "")
				if not k:find("^Lib") then
					u[#u+1] = "Lib"
				end
				u[#u+1] = " = LibStub('"
				u[#u+1] = k
				u[#u+1] = "');"
			elseif AceLibrary then
				-- non-LibStub AceLibrary libs.
				u[#u+1] = "local "
				u[#u+1] = k:gsub("%-.*", "")
				if not k:find("^Lib") then
					u[#u+1] = "Lib"
				end
				u[#u+1] = " = AceLibrary and AceLibrary:HasInstance('"
				u[#u+1] = k
				u[#u+1] = "') and AceLibrary('"
				u[#u+1] = k
				u[#u+1] = "');"
			end
		else
			u[#u+1] = "local "
			u[#u+1] = k:gsub("%.", "_")
			u[#u+1] = " = "
			u[#u+1] = k
			u[#u+1] = ";"
		end
	end
	globals = del(globals)
	for i,v in ipairs(u) do
		table.insert(t, i+2, v)
	end
	u = del(u)
	if tmp_num > 0 then
		t[#t+1] = [[return cleanText(]]
		if tmp_literal[0] then
			t[#t+1] = ("%q"):format(tmp_literal[0])
			t[#t+1] = " .. "
		end
		for i = 1, tmp_num+1 do
			if i <= tmp_num then
				t[#t+1] = [[tmp_]]
				t[#t+1] = i
				t[#t+1] = " .. "
			end
			if tmp_literal[i] then
				t[#t+1] = ("%q"):format(tmp_literal[i])
				t[#t+1] = " .. "
			end
		end
		t[#t] = [[), opacity;]]
	end
	tmp_literal = del(tmp_literal)
	t[#t+1] = [[end;]]
	cachedTags = del(cachedTags)
	local s = table_concat(t)
	t = del(t)
	if not notDebug then
		s = enumLines(s:gsub(";", ";\n"):gsub("\r\n", "\n"):gsub("\t", "    "):gsub("%f[A-Za-z_]do%f[^A-Za-z_]", "do\n"):gsub("%f[A-Za-z_]then%f[^A-Za-z_]", "then\n"):gsub("%f[A-Za-z_]else%f[^A-Za-z_]", "else\n"):gsub("\n *", "\n")) -- avoid interning the new string if not debugging
	end
	return s
end

local FakeGlobals = {}
DogTag.FakeGlobals = FakeGlobals

local mt
local codeToFunction = setmetatable({}, {__index = function(self, nsList)
	local t = setmetatable(newList(), mt)
	t[0] = nsList
	self[nsList] = t
	return t
end, __mode = 'k'})

mt = {__index=function(self, key)
	if not key then
		key = ""
	end
	local nsList = self[0]
	local code = antiAlias(key, nsList)
	if code ~= key then
		self[key] = self[code]
		return self[key]
	end
	local s = DogTag:CreateFunctionFromCode(code, true, unpackNamespaceList(nsList))
	for i, ns in ipairs(unpackNamespaceList[nsList]) do
		local data = FakeGlobals[ns]
		if data then
			for k, v in pairs(data) do
				DogTag[k] = v
			end
		end
	end
	local func, err = loadstring(s)
	local val
	if not func then
		geterrorhandler()(("%s: Error (%s) loading code %q. Please inform ckknight."):format(MAJOR_VERSION, err, code))
		val = self[""]
	else
		local status, result = pcall(func)
		if not status then
			geterrorhandler()(("%s: Error (%s) running code %q. Please inform ckknight."):format(MAJOR_VERSION, result, code))
			val = self[""]
		else
			val = result
		end
	end
	for i, ns in ipairs(unpackNamespaceList[nsList]) do
		local data = FakeGlobals[ns]
		if data then
			for k in pairs(data) do
				DogTag[k] = nil
			end
		end
	end
	self[code] = val
	return val
end, __mode='k'}

local mt
local codeToEventList = setmetatable({}, {__index = function(self, nsList)
	local t = newList()
	t[0] = nsList
	setmetatable(t, mt)
	self[nsList] = t
	return t
end, __mode = 'k'})

mt = {__index = function(self, realkey)
	local nsList = self[0]
	local key = antiAlias(realkey, nsList)
	if key ~= realkey then
		self[realkey] = self[key]
		return self[realkey]
	end
	local t = newList()
	local len = key:len()
	local st = 1
	while st <= len do
		local start, fin, left, literal = key:find("^(.-)(%b[])", st)
		if not start then
			break
		end
		local inner = literal:sub(2, -2)
		st = fin+1
		local code = newList(splitCode(inner))
		for i = 1, #code, 2 do
			local bit, param, negate, unit = splitParam(code[i], nsList)
			local func, arg
			local isMod = false
			if code[i-1] ~= ":" then
				func = getTag(bit, 'code', nsList)
				arg = getTag(bit, 'arg', nsList)
			else
				isMod = true
				func = getModifier(bit, 'code', nsList)
				arg = getTag(bit, 'arg', nsList)
			end
			local eventList = (isMod and getModifier(bit, 'events', nsList)) or (not isMod and getTag(bit, 'events', nsList))
			if type(func) == "function" then
				local data = newList()
				data.isMod = isMod
				data.unit = unit
				data.unit_str = unit and ("(%q)"):format(unit) or "(unit)"
				if arg == "string" then
					param = param and tostring(param) or ""
				elseif arg == "number" then
					param = tonumber(param) or 0
				elseif arg == "number;string" then
					param = tonumber(param) or param and tostring(param) or ""
				elseif arg == "nil;string" then
					param = param and tostring(param) or ""
				elseif arg == "nil;number" then
					param = tonumber(param)
				end
				data.arg = param
				data.arg_str = param and toliteral(param) or "(nil)"
				data.arg_string = param and ("(%q)"):format(param) or '("nil")'
				data.argtype = ("(%q)"):format(type(param))
				local hash = newDict('func', func(data))
				data = del(data)
				if hash.events then
					if eventList then
						eventList = eventList .. ";" .. hash.events
					else
						eventList = hash.events
					end
				end
				hash = del(hash)
			end
			if unit == true then
				unit = nil
			end
			if unit and not IsNormalUnit[unit] then
				if eventList then
					eventList = eventList .. ";" .. "Update"
				else
					eventList = "Update"
				end
			end
			if eventList then
				local events = newList((";"):split(eventList))
				for _,event in ipairs(events) do
					if event == "Special_IsUnit" then
						if param == "player" or param == "pet" or param == "target" or param == "focus" or param == "mouseover" or param:find("^party%d$") or param:find("^partypet%d$") or param:find("^raid%d+$") or param:find("^raidpet%d+$") then
							t[event .. "=" .. param] = true
						else
							t["Update=" .. param] = true
						end
						if unit then
							t[event .. "=" .. unit] = true
						else
							t[event] = true
						end
					else
						local e, u = event:match("([A-Z_]+)%(([a-z]+)%)")
						if not e then
							e, u = event, unit
						end
						if u then
							t[e .. "=" .. u] = true
						else
							t[e] = true
						end
					end
				end
				events = del(events)
			end
			if type(param) == "string" and param:find("%[.*%]") then
				for k, v in pairs(self[param]) do
					t[k] = v
				end
			end
		end
		code = del(code)
	end
	self[key] = t
	return t
end, __mode = 'k'}

local eventData = setmetatable({}, {__index = function(self, event)
	local t = newList()
	self[event] = t
	if event:find("^[A-Z_]+$") then
		DogTag.frame:RegisterEvent(event)
	end
	return t
end})
DogTag.eventData = eventData
local buckets = setmetatable({}, {__index = function(self, event)
	local t = newList()
	self[event] = t
	return t
end})

local registry
local codeHash

local frameToText = {}
local textToFrame = {}
local textToNamespaceList = {}

local toUpdate, quickUpdate = {}, {}
DogTag.toUpdate = toUpdate
DogTag.quickUpdate = quickUpdate

local function updateText(text, code, unit, nsList)
	local success, ret, alpha = pcall(codeToFunction[nsList][code], unit)
	if success then
		toUpdate[text] = nil
		quickUpdate[text] = nil
		text:SetText(ret)
		if alpha then
			alpha = tonumber(alpha) or 1
			if alpha < 0 then
				alpha = 0
			elseif alpha > 1 then
				alpha = 1
			end
			text:SetAlpha(alpha)
		end
	else
		geterrorhandler()(("%s.%d: Error with code %q%s on %q. %s"):format(MAJOR_VERSION, MINOR_VERSION, code, nsList == "Base" and "" or " (" .. nsList .. ")", unit, ret))
	end
end

local runUpdate

local hasEvent = {}
DogTag.hasEvent = hasEvent
local shouldRecheckEventData = false
local function RecheckEventData()
	shouldRecheckEventData = false
	for k,v in pairs(hasEvent) do
		if type(v) == "table" then
			del(v)
		end
		hasEvent[k] = nil
	end
	for k in pairs(eventData) do
		if type(hasEvent[k]) == "table" then
			hasEvent[k] = del(hasEvent[k])
		end
		local main, sub = k:match("^(.*){(.*)}$")
		if main then
			if not hasEvent[main] then
				hasEvent[main] = newList()
			end
			hasEvent[main][sub] = true
		else
			hasEvent[k] = true
		end
	end
end

--[[
Notes:
	Adds a FontString to LibDogTag-2.0's registry, which will be updated automatically.
	You can add twice without removing. It will just overwrite the previous registration.
	This will not update tags of units that Blizzard does not have events for, e.g. targettarget, mouseovertarget, partyNtarget
Arguments:
	frame - the FontString to register
	frame - the Frame which holds the FontString
	string - the unit associated with the FontString
	string - the tag sequence
	tuple - extra namespaces
]]
function DogTag:AddFontString(text, frame, unit, code, ...)
	if type(text) ~= "table" then
		error(("Bad argument #2 to `AddFontString'. Expected %q, got %q."):format("table", type(text)), 2)
	end
	if type(frame) ~= "table" then
		error(("Bad argument #3 to `AddFontString'. Expected %q, got %q."):format("table", type(frame)), 2)
	end
	if type(unit) ~= "string" then
		error(("Bad argument #4 to `AddFontString'. Expected %q, got %q."):format("string", type(unit)), 2)
	end
	if type(code) ~= "string" then
		error(("Bad argument #5 to `AddFontString'. Expected %q, got %q."):format("string", type(code)), 2)
	end
	for i = 1, select('#', ...) do
		if type(select(i, ...)) ~= "string" then
			error(("Bad argument #%d to `AddFontString'. Expected %q, got %q"):format(i+5, "string", type(select(i, ...))), 2)
		end
	end
	local nsList = getNamespaceList(...)
	if not IsLegitimateUnit[unit] then
		code = ""
	end
	local outline = ""
	if code:find("^%[[Oo][Uu][Tt][Ll][Ii][Nn][Ee]%]") then
		code = code:sub(10)
		outline = "OUTLINE"
	elseif code:find("^%[[Tt][Hh][Ii][Cc][Kk][Oo][Uu][Tt][Ll][Ii][Nn][Ee]%]") then
		code = code:sub(15)
		outline = "OUTLINE, THICKOUTLINE"
	end
	if codeHash[text] then
		if codeHash[text] == code and registry[text] == unit and textToFrame[text] == frame and select(3, text:GetFont()) == outline then
			toUpdate[text] = true
			return
		end
		self:RemoveFontString(text)
	end
	codeHash[text] = code
	registry[text] = unit
	if IsNormalUnit[unit] then
		local events = codeToEventList[nsList][code]
		
		for event in pairs(events) do
			local event, u = ("="):split(event, 2)
			if not u then
				u = unit
			end
			if eventData[event][text] and eventData[event][text] ~= u then
				if type(eventData[event][text]) == "string" then
					local old = eventData[event][text]
					eventData[event][text] = newList()
					eventData[event][text][old] = true
				end
				eventData[event][text][u] = true
			else
				eventData[event][text] = u
			end
		end
	end
	registry[text] = unit

	shouldRecheckEventData = true

	if not frameToText[frame] then
		frameToText[frame] = newList()
	end
	frameToText[frame][text] = unit
	textToFrame[text] = frame
	textToNamespaceList[text] = nsList

	local font, fontsize = text:GetFont()
	text:SetFont(font, fontsize, outline)
	DogTag.__isMouseOver = textToFrame[text] == lastMouseFocus
	updateText(text, code, unit, nsList)
end

local EventHandlers = {}
--[[
Notes:
	Removes a registered FontString from LibDogTag-2.0's registry.
	You can remove twice without issues.
Arguments:
	frame - the FontString previously registered
]]
function DogTag:RemoveFontString(text)
	if type(text) ~= "table" then
		error(("Bad argument #2 to `RemoveFontString'. Expected %q, got %q"):format("table", type(text)), 2)
	end
	local code = codeHash[text]
	if not code then
		return
	end

	local unit = registry[text]
	registry[text] = nil
	codeHash[text] = nil
	local nsList = textToNamespaceList[text]
	textToNamespaceList[text] = nil
	if IsNormalUnit[unit] then
		local events = codeToEventList[nsList][code]

		for event in pairs(events) do
			local t = eventData[event]
			if type(t[text]) == "table" then
				del(t[text])
			end
			t[text] = nil
			if not next(t) then
				eventData[event] = del(t)
				if event:find("^[A-Z_]+$") then
					if not EventHandlers[event] then
						self.frame:UnregisterEvent(event)
					end
					buckets[event] = del(buckets[event])
				end
			end
		end

		shouldRecheckEventData = true
	end

	local frame = textToFrame[text]
	textToFrame[text] = nil
	frameToText[frame][text] = nil
	if not next(frameToText[frame]) then
		frameToText[frame] = del(frameToText[frame])
	end
end

--[[
Notes:
	Manually updates a FontString previously registered.
	This is necessary to call on FontStrings whose units have no associated Blizzard events, e.g. targettarget, mouseovertarget, partyNtarget.
Arguments:
	frame - the FontString previously registered
]]
function DogTag:UpdateFontString(text)
	if type(text) ~= "table" then
		error(("Bad argument #2 to `UpdateFontString'. Expected %q, got %q"):format("table", type(text)), 2)
	end
	local unit = registry[text]

	if unit then
		DogTag.__isMouseOver = textToFrame[text] == lastMouseFocus
		updateText(text, codeHash[text], unit, textToNamespaceList[text])
	end
end

local UpdateAllForUnitHandlers = {}
--[[
Notes:
	Manually updates all FontStrings for a specified unit.
	You shouldn't need to call this from addons.
Arguments:
	string - the unit to update
]]
function DogTag:UpdateAllForUnit(unit)
	if type(unit) ~= "string" then
		error(("Bad argument #2 to `RemoveFontString'. Expected %q, got %q"):format("string", type(unit)), 2)
	end
	if not IsLegitimateUnit[unit] then
		return
	end
	
	for _, func in ipairs(UpdateAllForUnitHandlers) do
		func(unit)
	end
	
	for text, u in pairs(registry) do
		if u == unit then
			toUpdate[text] = true
		end
	end
	for event, data in pairs(eventData) do
		for text, u in pairs(data) do
			if u == unit or data[u] then
				toUpdate[text] = true
			end
		end
	end

	runUpdate()
end

--[[
Notes:
	Manually updates all FontStrings on a specified frame.
Arguments:
	frame - the frame which to update all FontStrings on
]]
function DogTag:UpdateAllForFrame(frame)
	if type(frame) ~= "table" then
		error(("Bad argument #2 to `UpdateAllForFrame'. Expected %q, got %q"):format("table", type(frame)), 2)
	end
	if not frame:IsShown() then
		return
	end

	local list = frameToText[frame]
	if not list then
		return
	end

	for text, unit in pairs(list) do
		toUpdate[text] = true
	end

	runUpdate()
end

--[[
Arguments:
	string - the unit associated with the tag sequence
	string - the tag sequence to compile and evaluate
	tuple - tuple of extra namespaces
Returns:
	string - the resultant generated text
	number or nil - the expected opacity of the generated text, specified by the [Alpha(num)] tag. nil if not specified.
]]
function DogTag:Evaluate(unit, code, ...)
	if type(unit) ~= "string" then
		error(("Bad argument #2 to `Evaluate'. Expected %q, got %q"):format("string", type(unit)), 2)
	end
	if type(code) ~= "string" then
		error(("Bad argument #3 to `Evaluate'. Expected %q, got %q"):format("string", type(code)), 2)
	end
	for i = 1, select('#', ...) do
		if type(select(i, ...)) ~= "string" then
			error(("Bad argument #%d to `Evaluate'. Expected %q, got %q"):format(i+3, "string", type(select(i, ...))), 2)
		end
	end
	local nsList = getNamespaceList(...)
	if not IsLegitimateUnit[unit] then
		return ""
	end
	DogTag.__isMouseOver = false

	local success, text, opacity = pcall(codeToFunction[nsList][code], unit)
	if success then
		if opacity then
			if opacity > 1 then
				opacity = 1
			elseif opacity < 0 then
				opacity = 0
			end
		end
		return text, opacity
	else
		geterrorhandler()(("%s.%d: Error with code %q%s on %q. %s"):format(MAJOR_VERSION, MINOR_VERSION, code, nsList == "Base" and "" or " (" .. nsList .. ")", unit, text))
	end
end

function DogTag:AddTagCallback(unit, code, func)
	if type(unit) ~= "string" then
		error(("Bad argument #2 to `AddTagCallback'. Expected %q, got %q"):format("string", type(unit)), 2)
	end
	if type(code) ~= "string" then
		error(("Bad argument #3 to `AddTagCallback'. Expected %q, got %q"):format("string", type(code)), 2)
	end
	if type(func) ~= "function" then
		error(("Bad argument #4 to `AddTagCallback'. Expected %q, got %q"):format("function", type(func)), 2)
	end
	tagCallbacks[newList(unit, code, func)] = true
end

function DogTag:RemoveTagCallback(unit, code, func)
	if type(unit) ~= "string" then
		error(("Bad argument #2 to `RemoveTagCallback'. Expected %q, got %q"):format("string", type(unit)), 2)
	end
	if type(code) ~= "string" then
		error(("Bad argument #3 to `RemoveTagCallback'. Expected %q, got %q"):format("string", type(code)), 2)
	end
	if type(func) ~= "function" then
		error(("Bad argument #4 to `RemoveTagCallback'. Expected %q, got %q"):format("function", type(func)), 2)
	end
	local good = false
	for k in pairs(tagCallbacks) do
		if k[1] == unit and k[2] == code and k[3] == func then
			tagCallbacks[k] = del(k)
			good = true
		end
	end
	return good
end

do
	local FixCodeStyle__external = false
	local FixCodeStyle__nsList
	local function handler(literal)
		local inner = literal:sub(2, -2)
		local code = newList(splitCode(inner))
		if FixCodeStyle__external then
			local num_q = 0
			for i = 2, #code, 2 do
				if code[i] == "?" then
					num_q = num_q + 1
				end
			end	
			for h = num_q, 1, -1 do
				local start_pos, end_pos
				local q_pos, x_pos
				local q_count = 0
				if h == 1 then
					start_pos = 0
				end
				for i = 2, #code, 2 do
					local op = code[i]
					if op == "?" then
						q_count = q_count + 1
						if q_count == h then
							q_pos = i
							break
						elseif q_count == h-1 and not start_pos then
							start_pos = i
						end
					elseif op == "!" then
						if q_count == h-1 then
							start_pos = i
						end
					end
				end
				local n = 1
				for i = q_pos+2, #code, 2 do
					local op = code[i]
					if op == "?" then
						n = n + 1
					elseif op == "!" then
						n = n - 1
						if n == 0 and not x_pos then
							x_pos = i
						elseif n == -1 and x_pos then
							end_pos = i
							break
						end
					end
				end
				if not end_pos then
					end_pos = #code+1
				end
				assert(code[q_pos] == "?")
				if x_pos then
					assert(code[x_pos] == "!")
				end
				if not x_pos then
					x_pos, end_pos = end_pos, nil
				end
				
				if end_pos then
					local good = false
					for i = x_pos+2, end_pos-2, 2 do
						if code[i] ~= ":" then
							good = true
						end
					end
					if good then
						local newStr = "_([" .. table.concat(code, "", x_pos+1, end_pos-1) .. "])"
						code[x_pos+1] = newStr
						for i = end_pos-1, x_pos+2, -1 do
							table.remove(code, i)
						end
					end
				end
				
				do
					local good = false
					for i = q_pos+2, x_pos-2, 2 do
						if code[i] ~= ":" and (code[i] ~= "?" or end_pos) then
							good = true
						end
					end
					if good then
						local newStr = "_([" .. table.concat(code, "", q_pos+1, x_pos-1) .. "])"
						code[q_pos+1] = newStr
						for i = x_pos-1, q_pos+2, -1 do
							table.remove(code, i)
						end
					end
				end
				
				do
					local good = false
					for i = q_pos+2, start_pos-2, 2 do
						if code[i] ~= ":" then
							good = true
						end
					end
					if good then
						local newStr = "_([" .. table.concat(code, "", start_pos+1, q_pos-1) .. "])"
						code[start_pos+1] = newStr
						for i = q_pos-1, start_pos+2, -1 do
							table.remove(code, i)
						end
					end
				end
			end
			for i = 1, #code, 2 do
				local op = code[i-1]
				local bit, param, negate, unit = splitParam(code[i], FixCodeStyle__nsList)
				local negated_bit = negate and "~" .. bit or bit
				if op == ":" then
					for _,opList in ipairs(ops) do
						for op_, mod in pairs(opList) do
							if mod == negated_bit then
								local t = newList()
								t[#t+1] = "["
								for j = 1, i-3 do
									t[#t+1] = code[j]
								end
								t[#t+1] = "["
								t[#t+1] = code[i-2]
								t[#t+1] = op_
								t[#t+1] = joinParam("Text", param, negate, unit)
								t[#t+1] = "]"
								for j = i+1, #code do
									t[#t+1] = code[j]
								end
								t[#t+1] = "]"
								local result = table.concat(t)
								code = del(code)
								t = del(t)
								return handler(result)
							end
						end
					end
				elseif negated_bit == "Text" then
					if tonumber(param) then
						code[i] = param
					elseif param then
						if param:match("^(%b[])$") then
							code[i] = joinParam("_", param, negate, unit)
						end
					end
				end
			end
		end
		local t = newList()
		for i = 1, #code, 2 do
			local bit, param, negate, unit = splitParam(code[i], FixCodeStyle__nsList)
			
			if i == 1 then
				t[1] = "["
			else
				if code[i-1] == ":" and getTag(bit, nil, FixCodeStyle__nsList) and not getModifier(bit, nil, FixCodeStyle__nsList) then
					code[i-1] = "||"
				end
				local isMod = code[i-1] == ":"
				if not isMod then
					t[#t+1] = " "
				end
				t[#t+1] = code[i-1]
				if not isMod then
					t[#t+1] = " "
				end
			end
			
			local x = joinParam(bit, param, negate, unit)
			if x:find("^%[") and i == 1 then
				t[#t+1] = " "
			end
			t[#t+1] = x
		end
		code = del(code)
		if t[#t]:find("%]$") then
			t[#t+1] = " "
		end
		t[#t+1] = "]"
		local str = table_concat(t):gsub("~~", "")
		t = del(t)
		return str
	end
	
	function FixCodeStyle(code, external, nsList)
		code = code:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
		local outline = ""
		if code:find("^%[[Oo][Uu][Tt][Ll][Ii][Nn][Ee]%]") then
			code = code:sub(10)
			outline = "[Outline]"
		elseif code:find("^%[[Tt][Hh][Ii][Cc][Kk][Oo][Uu][Tt][Ll][Ii][Nn][Ee]%]") then
			code = code:sub(15)
			outline = "[ThickOutline]"
		end
		local last_FixCodeStyle__external = FixCodeStyle__external
		local last_FixCodeStyle__nsList = FixCodeStyle__nsList
		FixCodeStyle__external = external or last_FixCodeStyle__external
		FixCodeStyle__nsList = nsList
		local result = outline .. (code:gsub("(%b[])", handler))
		FixCodeStyle__external = last_FixCodeStyle__external
		FixCodeStyle__nsList = last_FixCodeStyle__nsList
		return result
	end
	
	--[[
	Notes:
		This takes a tag sequence that a user can enter and updates it for style purposes.
		e.g. [name] => [Name], [5:Sub(12)] => [5 - 12]
	Arguments:
		string - the tag sequence to check
		tuple - tuple of extra namespaces
	Returns:
		string - the same tag sequence, corrected for style.
	]]
	function DogTag:FixCodeStyle(code, ...)
		if type(code) ~= "string" then
			error(("Bad argument #2 to `FixCodeStyle'. Expected %q, got %q"):format("string", type(code)), 2)
		end
		for i = 1, select('#', ...) do
			if type(select(i, ...)) ~= "string" then
				error(("Bad argument #%d to `FixCodeStyle'. Expected %q, got %q"):format(i+2, "string", type(select(i, ...))), 2)
			end
		end
		return FixCodeStyle(code, true, getNamespaceList(...))
	end
	DogTag.FixCasing = DogTag.FixCodeStyle
end

do
	local colors = {
		tag = "00ffff", -- cyan
		number = "ff00ff", -- fushcia
		modifier = "00ff00", -- green
		literal = "ff7f7f", -- pink
		operator = "7f7fff", -- light blue
		unit = "ff0000", -- red
		result = "ffffff", -- white
	}
	
	local handler__nsList
	local function handler(literal)
		local inner = literal:sub(2, -2)
		local t = newList()
		local code = newList(splitCode(inner))
		for i = 1, #code, 2 do
			local bit, param, negate, unit = splitParam(code[i], handler__nsList)
			if code[i-1] == ":" and getTag(bit, nil, handler__nsList) and not getModifier(bit, nil, handler__nsList) then
				code[i-1] = "||"
			end
			t[#t+1] = "|cff"
			t[#t+1] = colors.operator
			if i == 1 then
				t[#t+1] = "["
			else
				local isMod = code[i-1] == ":"
				if not isMod then
					t[#t+1] = " "
				end
				t[#t+1] = code[i-1]
				if not isMod then
					t[#t+1] = " "
				end
			end	
			t[#t+1] = "|r"
			if tonumber(bit) then
				-- Number
				t[#t+1] = "|cff"
				t[#t+1] = colors.number
			elseif i == 1 or code[i-1] ~= ":" then
				-- Tag
				t[#t+1] = "|cff"
				t[#t+1] = colors.tag
			else
				-- Modifier?
				local proper_bit = correctCasing[bit]
				if getTag(proper_bit, nil, handler__nsList) and not getModifier(proper_bit, nil, handler__nsList) then
					t[#t+1] = "|cff"
					t[#t+1] = colors.tag
				else
					t[#t+1] = "|cff"
					t[#t+1] = colors.modifier
				end
			end
			if bit ~= "_" or not param then
				if negate then
					t[#t+1] = "~"
				end
				t[#t+1] = bit
				t[#t+1] = "|r"
				if unit then
					t[#t+1] = "|cff"
					t[#t+1] = colors.operator
					t[#t+1] = "#"
					t[#t+1] = "|r"
					t[#t+1] = "|cff"
					t[#t+1] = colors.unit
					t[#t+1] = unit
					t[#t+1] = "|r"
				end
				if param then
					t[#t+1] = "|cff"
					t[#t+1] = colors.operator
					t[#t+1] = "("
					t[#t+1] = "|r"
					if tonumber(param) then
						t[#t+1] = "|cff"
						t[#t+1] = colors.number
						t[#t+1] = param
						t[#t+1] = "|r"
					else
						t[#t+1] = DogTag:ColorizeCode(param, unpackNamespaceList(handler__nsList))
					end
					t[#t+1] = "|cff"
					t[#t+1] = colors.operator
					t[#t+1] = ")"
					t[#t+1] = "|r"
				end
			else	
				if tonumber(param) then
					t[#t+1] = "|cff"
					t[#t+1] = colors.number
					t[#t+1] = param
					t[#t+1] = "|r"
				else
					t[#t+1] = DogTag:ColorizeCode(param, unpackNamespaceList(handler__nsList))
				end
			end
		end
		t[#t+1] = "|cff"
		t[#t+1] = colors.operator
		t[#t+1] = "]"
		t[#t+1] = "|r"
		local result = table.concat(t)
		t = del(t)
		return result
	end
	
	--[[
	Notes:
		This colorizes a tag sequence by syntax to make it easier to understand.
	Arguments:
		string - the tag sequence to check
		tuple - tuple of extra namespaces
	Returns:
		string - the same tag sequence, with colors applied.
	]]
	function DogTag:ColorizeCode(code, ...)
		if type(code) ~= "string" then
			error(("Bad argument #2 to `ColorizeCode'. Expected %q, got %q"):format("string", type(code)), 2)
		end
		if not code then
			return nil
		end
		for i = 1, select('#', ...) do
			if type(select(i, ...)) ~= "string" then
				error(("Bad argument #%d to `ColorizeCode'. Expected %q, got %q"):format(i+2, "string", type(select(i, ...))), 2)
			end
		end
		local nsList = getNamespaceList(...)
		code = code:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
		local t = newList()
		
		local last = 1
		while true do
			local alpha, bravo, literal = code:find("(%b[])", last)
			if not alpha then
				break
			end
			if alpha ~= last then
				t[#t+1] = "|cff"
				t[#t+1] = colors.literal
				t[#t+1] = code:sub(last, alpha-1)
				t[#t+1] = "|r"
			end
			local last_handler__nsList = handler__nsList
			handler__nsList = nsList
			t[#t+1] = handler(literal)
			handler__nsList = last_handler__nsList
			last = bravo + 1
		end
		
		if last <= code:len() then
			t[#t+1] = "|cff"
			t[#t+1] = colors.literal
			t[#t+1] = code:sub(last)
			t[#t+1] = "|r"
		end
		
		local result = table.concat(t)
		t = del(t)
		return result
	end
	DogTag.ColorizeTag = DogTag.ColorizeCode
end

local function callModules_PARTY_MEMBERS_CHANGED()
	if EventHandlers.PARTY_MEMBERS_CHANGED then
		for _, func in ipairs(EventHandlers.PARTY_MEMBERS_CHANGED) do
			func()
		end
	end
end
function DogTag:PARTY_MEMBERS_CHANGED()
	for text, unit in pairs(registry) do
		toUpdate[text] = true
	end
	
	runUpdate()
end
DogTag.PLAYER_ENTERING_WORLD = DogTag.PARTY_MEMBERS_CHANGED
DogTag.UNIT_PET = DogTag.PARTY_MEMBERS_CHANGED

function DogTag:PLAYER_TARGET_CHANGED()
	self:UpdateAllForUnit('target')
end

function DogTag:PLAYER_FOCUS_CHANGED()
	self:UpdateAllForUnit('focus')
end

function DogTag:PLAYER_PET_CHANGED()
	self:UpdateAllForUnit('pet')
end

local inMouseover = false
function DogTag:UPDATE_MOUSEOVER_UNIT()
	inMouseover = true
	self:UpdateAllForUnit('mouseover')
end

local function clearCodes()
	for ns, data in pairs(codeToFunction) do
		for k,v in pairs(data) do
			if k ~= 0 then
				data[k] = nil
			end
		end
	end
	for ns, data in pairs(codeToEventList) do
		for k,v in pairs(data) do
			if k ~= 0 then
				data[k] = nil
			end
		end
	end
	for k in pairs(antiAliasNamespace) do
		antiAliasNamespace[k] = nil
	end
	for k, v in pairs(eventData) do
		eventData[k] = del(v)
	end
	for k, v in pairs(buckets) do
		buckets[k] = del(v)
	end
	for ns, data in pairs(Tags) do
		for k,v in pairs(data) do
			if v.aliasFunc then
				v.alias = v.aliasFunc()
			end
		end
	end
	for ns, data in pairs(Modifiers) do
		for k,v in pairs(data) do
			if v.aliasFunc then
				v.alias = v.aliasFunc()
			end
		end
	end

	local self = DogTag
	self.frame:UnregisterAllEvents()
	for k in pairs(EventHandlers) do
		self.frame:RegisterEvent(k)
	end

	DogTag:PARTY_MEMBERS_CHANGED()
	callModules_PARTY_MEMBERS_CHANGED()
end

local AddonFinders = {}
function DogTag:ADDON_LOADED()
	-- for extra addons' help, such as MobHealth3 or MobInfo2
	AceLibrary = _G.AceLibrary
	local good = false
	local tmp_AddonFinders = AddonFinders
	AddonFinders = newList()
	for k in pairs(tmp_AddonFinders) do
		local kind, name, func = k[1], k[2], k[3]
		if kind == "_G" then
			if _G[name] then
				tmp_AddonFinders[k] = nil
				func(_G[name])
				good = true
			end
		elseif kind == "AceLibrary" then
			if AceLibrary and AceLibrary:HasInstance(name) then
				tmp_AddonFinders[k] = nil
				func(AceLibrary(name))
				good = true
			end
		elseif kind == "Rock" then
			if Rock and Rock:HasLibrary(name) then
				tmp_AddonFinders[k] = nil
				func(Rock:GetLibrary(name))
				good = true
			end
		elseif kind == "LibStub" then
			if Rock then
				Rock:HasLibrary(name) -- try to load
			end
			if AceLibrary then
				AceLibrary:HasInstance(name) -- try to load
			end
			if LibStub:GetLibrary(name, true) then
				tmp_AddonFinders[k] = nil
				func(LibStub:GetLibrary(name))
				good = true
			end
		end
	end
	for k in pairs(tmp_AddonFinders) do
		AddonFinders[k] = true
	end
	tmp_AddonFinders = del(tmp_AddonFinders)
	if not good then
		return
	end
	clearCodes()
	return true
end

function DogTag:PLAYER_LOGIN()
	if not self:ADDON_LOADED() then
		self:PARTY_MEMBERS_CHANGED()
		callModules_PARTY_MEMBERS_CHANGED()
	end
end

--[[
Notes:
	This allows addons to set the color scheme for LibDogTag-2.0.
	If one addon sets the color constant table, it affect all addons that use LibDogTag-2.0.
Arguments:
	table - a table which holds all the colors
]]
function DogTag:SetColorConstantTable(t)
	if type(t) ~= "table" then
		error(("Bad argument #2 to `SetColorConstantTable'. Expected %q, got %q"):format("table", type(t)), 2)
	end
	colors = t
	FakeGlobals.Base.__colors = colors
	-- need to update the colors reference in the functions
	clearCodes()
end

function DogTag:OnMouseoverUpdate()
end

local TimerHandlers = {}
local namesChecked = {}
local num = 0
local nextTime = GetTime()
function runUpdate()
	num = num + 1
	local currentTime = GetTime()
	for _, func in ipairs(TimerHandlers) do
		func(num, currentTime)
	end
	
	for text in pairs(toUpdate) do
		toUpdate[text] = nil
		quickUpdate[text] = nil
		local unit = registry[text]
		if unit and text:IsVisible() and text:GetNumPoints() > 0 then
			DogTag.__isMouseOver = textToFrame[text] == lastMouseFocus
			updateText(text, codeHash[text], unit, textToNamespaceList[text])
		end
	end
end
DogTag.runUpdate = runUpdate

DogTag.frame = oldLib and oldLib.frame or CreateFrame("Frame", MAJOR_VERSION .. "_Frame")
local frame = DogTag.frame
frame:UnregisterAllEvents()

frame:SetScript("OnEvent", function(this, event, ...)
	local EventHandlers_event = EventHandlers[event]
	if EventHandlers_event then
		for _, func in ipairs(EventHandlers_event) do
			func(...)
		end
	end
	buckets[event][(...) or false] = true
end)

local timePassed = 0
local firstTime = true
frame:SetScript("OnUpdate", function(this, elapsed)
	timePassed = timePassed + elapsed
	
	local mouseFocus = GetMouseFocus()
	if lastMouseFocus ~= mouseFocus then
		local list, list2 = frameToText[lastMouseFocus], frameToText[mouseFocus]
		lastMouseFocus = mouseFocus
		if hasEvent.Mouseover then
			if list then
				if list2 then
					for text, unit in pairs(eventData.Mouseover) do
						if list[text] or list2[text] then
							quickUpdate[text] = true
						end
					end
				else
					for text, unit in pairs(eventData.Mouseover) do
						if list[text] then
							quickUpdate[text] = true
						end
					end
				end
			elseif list2 then
				for text, unit in pairs(eventData.Mouseover) do
					if list2[text] then
						quickUpdate[text] = true
					end
				end
			end
		end

		for text, u in pairs(registry) do
			if u == "mouseover" or u.mouseover then
				quickUpdate[text] = true
			end
		end
		for event, data in pairs(eventData) do
			for text, u in pairs(data) do
				if u == "mouseover" or u.mouseover then
					quickUpdate[text] = true
				end
			end
		end
	
		if not UnitExists("mouseover") then
			for text in pairs(quickUpdate) do
				if registry[text] == "mouseover" then
					quickUpdate[text] = nil
				end
			end
		end
	end
	
	if timePassed > 0.05 then
		if firstTime then
			firstTime = false
			DogTag:PARTY_MEMBERS_CHANGED()
			callModules_PARTY_MEMBERS_CHANGED()
		end
		if shouldRecheckEventData then
			RecheckEventData()
		end
		timePassed = 0
		runUpdate()
	end
	
	for text in pairs(quickUpdate) do
		toUpdate[text] = nil
		quickUpdate[text] = nil
		local unit = registry[text]
		if unit and text:IsVisible() and text:GetNumPoints() > 0 then
			DogTag.__isMouseOver = textToFrame[text] == lastMouseFocus
			updateText(text, codeHash[text], unit, textToNamespaceList[text])
		end
	end
end)

registry = {}
DogTag.registry = registry
codeHash = {}
DogTag.codeHash = codeHash

if oldLib then
	for text, unit in pairs(oldLib.registry) do
		DogTag:AddFontString(text, unit, oldLib.codeHash[text])
	end
end

local helpFrame
--[[
Notes:
	This opens the in-game documentation, which provides information to users on syntax as well as the available tags and modifiers.
]]
function DogTag:OpenHelp()
	if not helpFrame then
		helpFrame = CreateFrame("Frame", MAJOR_VERSION .. "_HelpFrame", UIParent)
		helpFrame:SetWidth(600)
		helpFrame:SetHeight(300)
		helpFrame:SetPoint("CENTER", UIParent, "CENTER")
		helpFrame:EnableMouse(true)
		helpFrame:SetMovable(true)
		helpFrame:SetResizable(true)
		helpFrame:SetMinResize(600, 300)
		helpFrame:SetFrameLevel(50)
		helpFrame:SetFrameStrata("FULLSCREEN_DIALOG")

		local bg = newDict(
			'bgFile', [[Interface\DialogFrame\UI-DialogBox-Background]],
			'edgeFile', [[Interface\DialogFrame\UI-DialogBox-Border]],
			'tile', true,
			'tileSize', 32,
			'edgeSize', 32,
			'insets', newDict(
				'left', 5,
				'right', 6,
				'top', 5,
				'bottom', 6
			)
		)
		helpFrame:SetBackdrop(bg)
		bg.insets = del(bg.insets)
		bg = del(bg)
		helpFrame:SetBackdropColor(0, 0, 0)
		helpFrame:SetClampedToScreen(true)
		
		local header = CreateFrame("Frame", helpFrame:GetName() .. "_Header", helpFrame)
		helpFrame.header = header
		header:SetHeight(34.56)
		header:SetClampedToScreen(true)
		local left = header:CreateTexture(header:GetName() .. "_TextureLeft", "ARTWORK")
		header.left = left
		left:SetPoint("TOPLEFT")
		left:SetPoint("BOTTOMLEFT")
		left:SetWidth(11.54)
		left:SetTexture([[Interface\DialogFrame\UI-DialogBox-Header]])
		left:SetTexCoord(0.235, 0.28, 0.04, 0.58)
		local right = header:CreateTexture(header:GetName() .. "_TextureRight", "ARTWORK")
		header.right = right
		right:SetPoint("TOPRIGHT")
		right:SetPoint("BOTTOMRIGHT")
		right:SetWidth(11.54)
		right:SetTexture([[Interface\DialogFrame\UI-DialogBox-Header]])
		right:SetTexCoord(0.715, 0.76, 0.04, 0.58)
		local center = header:CreateTexture(header:GetName() .. "_TextureCenter", "ARTWORK")
		header.center = center
		center:SetPoint("TOPLEFT", left, "TOPRIGHT")
		center:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")
		center:SetTexture([[Interface\DialogFrame\UI-DialogBox-Header]])
		center:SetTexCoord(0.28, 0.715, 0.04, 0.58)
		
		local closeButton = CreateFrame("Button", helpFrame:GetName() .. "_CloseButton", helpFrame, "UIPanelCloseButton")
		helpFrame.closeButton = closeButton
		closeButton:SetFrameLevel(helpFrame:GetFrameLevel()+5)
		closeButton:SetScript("OnClick", function(this)
			this:GetParent():Hide()
		end)
		closeButton:SetPoint("TOPRIGHT", helpFrame, "TOPRIGHT", -5, -5)
		
		header:EnableMouse(true)
		header:RegisterForDrag("LeftButton")
		header:SetScript("OnDragStart", function(this)
			isDragging = true
			this:GetParent():StartMoving()
		end)
		header:SetScript("OnDragStop", function(this)
			isDragging = false
			this:GetParent():StopMovingOrSizing()
		end)

		local titleText = header:CreateFontString(header:GetName() .. "_FontString", "OVERLAY", "GameFontNormal")
		helpFrame.titleText = titleText
		titleText:SetText(L["DogTag Help"])
		titleText:SetPoint("CENTER", helpFrame, "TOP", 0, -8)
		titleText:SetHeight(26)
		titleText:SetShadowColor(0, 0, 0)
		titleText:SetShadowOffset(1, -1)

		header:SetPoint("LEFT", titleText, "LEFT", -32, 0)
		header:SetPoint("RIGHT", titleText, "RIGHT", 32, 0)
		
		local sizer_se = CreateFrame("Frame", helpFrame:GetName() .. "_SizerSoutheast", helpFrame)
		helpFrame.sizer_se = sizer_se
		sizer_se:SetPoint("BOTTOMRIGHT", helpFrame, "BOTTOMRIGHT", 0, 0)
		sizer_se:SetWidth(25)
		sizer_se:SetHeight(25)
		sizer_se:EnableMouse(true)
		sizer_se:RegisterForDrag("LeftButton")
		sizer_se:SetScript("OnDragStart", function(this)
			isDragging = true
			this:GetParent():StartSizing("BOTTOMRIGHT")
		end)
		sizer_se:SetScript("OnDragStop", function(this)
			isDragging = false
			this:GetParent():StopMovingOrSizing()
		end)
		local line1 = sizer_se:CreateTexture(sizer_se:GetName() .. "_Line1", "BACKGROUND")
		line1:SetWidth(14)
		line1:SetHeight(14)
		line1:SetPoint("BOTTOMRIGHT", -10, 10)
		line1:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
		local x = 0.1 * 14/17
		line1:SetTexCoord(1/32 - x, 0.5, 1/32, 0.5 + x, 1/32, 0.5 - x, 1/32 + x, 0.5)

		local line2 = sizer_se:CreateTexture(sizer_se:GetName() .. "_Line2", "BACKGROUND")
		line2:SetWidth(11)
		line2:SetHeight(11)
		line2:SetPoint("BOTTOMRIGHT", -10, 10)
		line2:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
		local x = 0.1 * 11/17
		line2:SetTexCoord(1/32 - x, 0.5, 1/32, 0.5 + x, 1/32, 0.5 - x, 1/32 + x, 0.5)

		local line3 = sizer_se:CreateTexture(sizer_se:GetName() .. "_Line3", "BACKGROUND")
		line3:SetWidth(8)
		line3:SetHeight(8)
		line3:SetPoint("BOTTOMRIGHT", -10, 10)
		line3:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
		local x = 0.1 * 8/17
		line3:SetTexCoord(1/32 - x, 0.5, 1/32, 0.5 + x, 1/32, 0.5 - x, 1/32 + x, 0.5)
		
		local mainPane = CreateFrame("Frame", helpFrame:GetName() .. "_MainPane", helpFrame)
		helpFrame.mainPane = mainPane
		local bg = newDict(
			'bgFile', [[Interface\Buttons\WHITE8X8]],
			'edgeFile', [[Interface\Tooltips\UI-Tooltip-Border]],
			'tile', true,
			'tileSize', 16,
			'edgeSize', 16,
			'insets', newDict(
				'left', 3,
				'right', 3,
				'top', 3,
				'bottom', 3
			)
		)
		mainPane:SetBackdrop(bg)
		bg.insets = del(bg.insets)
		bg = del(bg)
		mainPane:SetBackdropBorderColor(0.6, 0.6, 0.6)
		mainPane:SetBackdropColor(0, 0, 0)
		mainPane:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 12, -35)
		mainPane:SetPoint("BOTTOMRIGHT", helpFrame, "BOTTOMRIGHT", -12, 30)
		
		local scrollFrame = CreateFrame("ScrollFrame", mainPane:GetName() .. "_ScrollFrame", mainPane)
		local scrollChild = CreateFrame("Frame", mainPane:GetName() .. "_ScrollChild", scrollFrame)
		local scrollBar = CreateFrame("Slider", mainPane:GetName() .. "_ScrollBar", scrollFrame, "UIPanelScrollBarTemplate")
		mainPane.scrollFrame = scrollFrame
		mainPane.scrollChild = scrollChild
		mainPane.scrollBar = scrollBar

		scrollFrame:SetScrollChild(scrollChild)
		scrollFrame:SetPoint("TOPLEFT", mainPane, "TOPLEFT", 9, -9)
		scrollFrame:SetPoint("BOTTOMRIGHT", mainPane, "BOTTOMRIGHT", -28, 12)
		scrollFrame:EnableMouseWheel(true)
		scrollFrame:SetScript("OnMouseWheel", function(this, change)
			local childHeight = scrollChild:CalculateHeight()
			local frameHeight = scrollFrame:GetHeight()
			if childHeight <= frameHeight then
				return
			end

			nextFreeScroll = GetTime() + 1

			local diff = childHeight - frameHeight

			local delta = 1
			if change > 0 then
				delta = -1
			end

			local value = scrollBar:GetValue() + delta*24/diff
			if value < 0 then
				value = 0
			elseif value > 1 then
				value = 1
			end
			scrollBar:SetValue(value) -- will trigger OnValueChanged
		end)

		scrollChild:SetHeight(10)
		scrollChild:SetWidth(10)

		local first = true
		function scrollChild:CalculateHeight()
			local html = self.html
			local t = newList(html:GetRegions())
			local top, bottom
			for i,v in ipairs(t) do
				if v:GetTop() and (not top or top < v:GetTop()) then
					top = v:GetTop()
				end
				if v:GetBottom() and (not bottom or bottom > v:GetBottom()) then
					bottom = v:GetBottom()
				end
			end
			t = del(t)
			return top and (top - bottom) or 10
		end
		_G.scrollChild = scrollChild

		scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 0, -16)
		scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 0, 16)
		scrollBar:SetMinMaxValues(0, 1)
		scrollBar:SetValueStep(1e-5)
		scrollBar:SetValue(0)
		scrollBar:SetWidth(16)
		scrollBar:SetScript("OnValueChanged", function(this)
			local max = scrollChild:CalculateHeight() - scrollFrame:GetHeight()

			local val = scrollBar:GetValue() * max
			
			if math.abs(scrollFrame:GetVerticalScroll() - val) < 1 then
				return
			end

			scrollFrame:SetVerticalScroll(val)

			scrollFrame:UpdateScrollChildRect()
		end)
		scrollBar:EnableMouseWheel(true)
		scrollBar:SetScript("OnMouseWheel", function(this, ...)
			scrollFrame:GetScript("OnMouseWheel")(scrollFrame, ...)
		end)
		
		local html = CreateFrame("SimpleHTML", scrollChild:GetName() .. "_HTML", scrollChild)
		scrollChild.html = html
		html:SetFontObject('p', GameFontNormal)
		html:SetSpacing('p', 3)
		
		html:SetFontObject('h1', GameFontHighlightLarge)
		local font, height, flags = GameFontHighlightLarge:GetFont()
		height = height * 1.25
		html:SetFont('h1', font, height, flags)
		html:SetSpacing('h1', height/2)
		
		html:SetFontObject('h2', GameFontHighlightLarge)
		local _, height = GameFontHighlightLarge:GetFont()
		html:SetSpacing('h2', height/2)
		
		html:SetFontObject('h3', GameFontHighlightNormal)
		local _, height = GameFontHighlightLarge:GetFont()
		html:SetSpacing('h3', height/2)
		
		html:SetHeight(1)
		html:SetWidth(400)
		html:SetPoint("TOPLEFT", 0, 0)
		html:SetJustifyH("LEFT")
		html:SetJustifyV("TOP")
		
		local editBox = CreateFrame("EditBox", helpFrame:GetName() .. "_EditBox", helpFrame)
		editBox:SetFontObject(ChatFontNormal)
		editBox:SetHeight(17)
		editBox:SetWidth(200)
		editBox:SetAutoFocus(false)
		
		local editBox_line1 = editBox:CreateTexture(editBox:GetName() .. "_Line1", "BACKGROUND")
		editBox_line1:SetTexture([[Interface\Buttons\WHITE8X8]])
		editBox_line1:SetHeight(1)
		editBox_line1:SetPoint("TOPLEFT", editBox, "BOTTOMLEFT", 0, 1)
		editBox_line1:SetPoint("TOPRIGHT", editBox, "BOTTOMRIGHT", 0, 1)
		editBox_line1:SetVertexColor(3/4, 3/4, 3/4, 1)
		
		local editBox_line2 = editBox:CreateTexture(editBox:GetName() .. "_Line2", "BACKGROUND")
		editBox_line2:SetTexture([[Interface\Buttons\WHITE8X8]])
		editBox_line2:SetWidth(1)
		editBox_line2:SetPoint("TOPLEFT", editBox, "TOPRIGHT", -1, 0)
		editBox_line2:SetPoint("BOTTOMLEFT", editBox, "BOTTOMRIGHT", -1, 0)
		editBox_line2:SetVertexColor(3/4, 3/4, 3/4, 1)
		
		local editBox_line3 = editBox:CreateTexture(editBox:GetName() .. "_Line3", "BACKGROUND")
		editBox_line3:SetTexture([[Interface\Buttons\WHITE8X8]])
		editBox_line3:SetHeight(1)
		editBox_line3:SetPoint("BOTTOMLEFT", editBox, "TOPLEFT", 0, -1)
		editBox_line3:SetPoint("BOTTOMRIGHT", editBox, "TOPRIGHT", 0, -1)
		editBox_line3:SetVertexColor(3/8, 3/8, 3/8, 1)
		
		local editBox_line4 = editBox:CreateTexture(editBox:GetName() .. "_Line4", "BACKGROUND")
		editBox_line4:SetTexture([[Interface\Buttons\WHITE8X8]])
		editBox_line4:SetWidth(1)
		editBox_line4:SetPoint("TOPRIGHT", editBox, "TOPLEFT", 1, 0)
		editBox_line4:SetPoint("BOTTOMRIGHT", editBox, "BOTTOMLEFT", 1, 0)
		editBox_line4:SetVertexColor(3/8, 3/8, 3/8, 1)
		
		local currentUnit = "player"
		
		local fontString = helpFrame:CreateFontString(helpFrame:GetName() .. "_FontString", "ARTWORK")
		fontString:SetPoint("LEFT", editBox, "RIGHT", 20, 0)
		fontString:SetPoint("BOTTOMRIGHT", helpFrame, "BOTTOMRIGHT", -20, 13)
		fontString:SetHeight(17)
		fontString:SetFontObject(ChatFontNormal)
		
		editBox:SetScript("OnEscapePressed", function(this)
			this:ClearFocus()
			this:SetText(DogTag:FixCodeStyle(this:GetText()))
		end)
		
		editBox:SetScript("OnEnterPressed", editBox:GetScript("OnEscapePressed"))
		
		editBox:SetScript("OnTextChanged", function(this)
			DogTag:AddFontString(fontString, helpFrame, currentUnit, editBox:GetText())
		end)
		
		editBox:SetText("[Name]")
		
		local dropdown = CreateFrame("Frame", helpFrame:GetName() .. "_DropDown", helpFrame, "UIDropDownMenuTemplate")
		
		local function dropdown_OnClick()
			UIDropDownMenu_SetSelectedValue(dropdown, this.value)
			currentUnit = this.value
			DogTag:AddFontString(fontString, helpFrame, currentUnit, editBox:GetText())
		end
		UIDropDownMenu_Initialize(dropdown, function()
			local info = newList()
			info.text = L["Player"]
			info.value = "player"
			info.func = dropdown_OnClick
			UIDropDownMenu_AddButton(info)
			info = del(info)
			
			local info = newList()
			info.text = L["Target"]
			info.value = "target"
			info.func = dropdown_OnClick
			UIDropDownMenu_AddButton(info)
			info = del(info)
			
			local info = newList()
			info.text = L["Pet"]
			info.value = "pet"
			info.func = dropdown_OnClick
			UIDropDownMenu_AddButton(info)
			info = del(info)
		end)
		UIDropDownMenu_SetSelectedValue(dropdown, currentUnit)
		
		scrollFrame:SetScript("OnSizeChanged", function(this)
			html:SetWidth(this:GetWidth())
			html:SetText(html.text)
			editBox:SetWidth(this:GetWidth()*1/2 - 20)
		end)
		
		dropdown:SetPoint("BOTTOMLEFT", helpFrame, "BOTTOMLEFT", -5, 6)
		editBox:SetPoint("LEFT", _G[dropdown:GetName() .. "Button"], "RIGHT", 5, 0)
		
		local function _fix__handler(text)
			if text:sub(1, 2) == "{{" and text:sub(-2) == "}}" then
				if text:len() == 5 and not text:sub(3, 3):find("[A-Za-z0-9_]") then
					if text:sub(3, 3) == "~" then
						local x = "[~One]"
						x = DogTag:ColorizeCode(x)
						x = x:match("^|cff%x%x%x%x%x%x%[|r(|cff%x%x%x%x%x%x~One|r)|cff%x%x%x%x%x%x%]|r$")
						return x:gsub("One", "")
					end
					local x = "[One" .. text:sub(3, 3) .. "Two]"
					x = DogTag:ColorizeCode(x)
					return x:match("^|cff%x%x%x%x%x%x%[|r|cff%x%x%x%x%x%xOne|r(.*)|cff%x%x%x%x%x%xTwo|r|cff%x%x%x%x%x%x%]|r$")
				elseif text:sub(3, 3) == ":" or text:sub(3, 3) == "#" then
					local x = "[___" .. text:sub(3, -3) .. "]"
					x = DogTag:ColorizeCode(x)
					return x:match("^|cff%x%x%x%x%x%x%[|r|cff%x%x%x%x%x%x___|r(.*)|cff%x%x%x%x%x%x%]|r$")
				else
					local x = "[" .. text:sub(3, -3) .. "]"
					x = DogTag:ColorizeCode(x)
					return x:match("^|cff%x%x%x%x%x%x%[|r(.*)|cff%x%x%x%x%x%x%]|r$")
				end
			end
			return DogTag:ColorizeCode(text:sub(2, -2))
		end
		local function fix__handler(text)
			return _fix__handler(text):gsub("<", "&lt;"):gsub(">", "&gt;")
		end
		local function fix__handler2(text)
			return "|cffffffff" .. text:sub(1, -2) .. '|cffffffff"|r'
		end
		local function fix(text)
			return text:gsub('(%b"")', fix__handler2):gsub("(%b{})", fix__handler):gsub("&lbrace;", "{"):gsub("&rbrace;", "}")
		end
		
		local function dataToHTML(data)
			local t = newList()
			t[#t+1] = "<html>"
			t[#t+1] = "<body>"
			for _,h1 in ipairs(data) do
				local title = h1[1]
				t[#t+1] = "<h1>"
				t[#t+1] = fix(title)
				t[#t+1] = "</h1>"
				local description = type(h1[2]) == "string" and h1[2]
				if description then
					t[#t+1] = "<p>"
					t[#t+1] = fix(description)
					t[#t+1] = "</p>"
					t[#t+1] = "<br />"
				end
				for i = description and 3 or 2, #h1 do
					local h2 = h1[i]
					local title = h2[1]
					local description = type(h2[2]) == "string" and h2[2]
					t[#t+1] = "<h2>"
					t[#t+1] = fix(title)
					t[#t+1] = "</h2>"
					if description then
						t[#t+1] = "<p>"
						t[#t+1] = fix(description)
						t[#t+1] = "</p>"
						t[#t+1] = "<br />"
					end
					for j = description and 3 or 2, #h2 do
						local h3 = h2[j]
						local title = h3[1]
						t[#t+1] = "<h2>"
						t[#t+1] = fix(title)
						t[#t+1] = "</h2>"
						for k = 2, #h3 do
							local description = h3[k]
							t[#t+1] = "<p>"
							t[#t+1] = fix(description)
							t[#t+1] = "</p>"
							t[#t+1] = "<br />"
						end
					end
				end
			end
			while t[#t] == "<br />" do
				t[#t] = nil
			end
			t[#t+1] = "</body>"
			t[#t+1] = "</html>"
			local result = table.concat(t)
			t = del(t)
			return result
		end
		
		local syntaxHTML = dataToHTML({
			{
				L["Syntax"], [=[Syntax is in the standard form {alpha [Tag] bravo} where {alpha} is a literal word, {bravo} is a literal word and {[Tag]} will be replaced by the associated dynamic text. All tags and modifiers are case-insensitive, but will be corrected to proper casing if the tags are legal.]=],
				{ L["Modifiers"], [=[Modifiers can change how a tag's output looks. For example, the {{:HideZero}} modifier will hide the result if it is equal to the number {{0}}, so {[CurHP:HideZero]} will show the current health except when it's equal to {{0}}, at which point it will be blank. You can chain together multiple modifiers as well, e.g. {[MissingHP:HideZero:Negate]} will show the missing health as a negative and not show it if it's equal to {{0}}.]=] },
				{ L["Arguments"], [=[Tags and modifiers can also take an argument, and can be fed in in a syntax similar to {[Tag(argument)]} or {[Tag:Modifier(argument)]}. You do not need to wrap in quotes for strings, this is done for you.]=] },
				{ L["Logic Branching (if statements)"], [=[
				* The {{?}} as used by DogTag serves as a boolean AND.<br />
				* The {{!}} as used by DogTag serves as an else, to complement {{?}}.<br />
				* The {{||}} as used by DogTag serves as a boolean OR.
				]=],
					{ L["Examples"], [=[
						{[Status || SureHP || PercentHP]}<br />
						Will return one of the following (but only one): <br /><br />
						* "Dead", "Offline", "Ghost", etc -- no further information since the OR indicates that there is already a legitimate return<br />
						* "3560/8490" or "130/6575" (but not "62/100" unless the target in fact has {{100}} hit points) -- and not "0/2340" or "0/3592" because that would mean it is dead and that would have already been taken care of by the first tag in the sequence<br />
						* "25" or "35" or "72" (percent health) -- if the unit is not dead, offline, etc, and your addon is uncertain of your target's maximum and current health, it will display percent health.<br /><br />
						{[Status || [SureHP ? CurHP] || PercentHP:Percent]} will deliver similar returns as to that above, but in a slightly different format which should be fairly apparent already.<br /><br />
						But to clarify, the nested {[SureHP?CurHP]} uses a boolean AND which means that if {{SureHP}} is nil or blank, the whole value is taken to be nil or blank, and if you've read this far you deserve a cookie. If {{SureHP}} is not nil or blank, the actual returned value of this nested expression is actually the term following the AND -- in this case, {{CurHP}}. So this will show {{CurHP}} if {{SureHP}} is found non-blank (that is, if your addon knows how much health the unit has).
					]=], [=[
						{[IsFriend?MissingHP:Negate:Green!CurHP:Red]}<br /> 
						Will return one of the following (but only one):<br /><br />
						* If the unit is friendly, it will display the amount of health they must be healed to meet their maximum. It will be displayed in green, and with a negative sign in front of it.<br /> 
						* If the unit is an enemy, it will display their current health. As this sequence is written, it will not consider whether it is a valid health value or not. On enemies where the health value is uncertain, it will show a percentage (but without a percent sign), until a more reliable value can be determined. This value will be displayed in red.
					]=]}
				},
				{ "Unit specification", [=[
					Units are typically pre-specified by the addon which uses DogTag, whether {{#player}}, {{#mouseover}}, or otherwise. You can override the unit a specific tag or modifier operates on by using the form {[Tag#unit]} or {[Tag:Modifier#unit]}
				]=], { L["Examples"], [=[
					* {[CurHP#target]} - gets the current health of your target
					]=] },
					{ "List of example units", [=[
					* {{#player}} - your character<br />
					* {{#target}} - your target<br />
					* {{#targettarget}} - your target's target<br />
					* {{#pet}} - your pet<br />
					* {{#mouseover}} - the unit you are currently hovering over<br />
					* {{#focus}} - your focus unit<br />
					* {{#party1}} - the first member of your party<br />
					* {{#partypet2}} - the pet of the second member of your party<br />
					* {{#raid3}} - the third member of your raid<br />
					* {{#raidpet4}} - the pet of the fourth member of your raid<br />
					]=] }
				},
				{ "Negation of tags", [=[
				You can negate a tag or modifier by prefixing it with {{~}}. For tags, any non-blank value will turn blank and any blank value will turn into "True". For modifiers, any non-blank value will turn blank and any blank value will turn into the previous value (which in and of itself was non-blank). Thus, {[CurHP:~IsEqual(50)]} will hide any value not equal to {{50}} and {[~Offline]} will return "True" when online.
				]=]},
				{ "Internal expressions", [=[
				It is possible to embed DogTag sequences within other sequences. For example, {[Text([Level] [Class])]} is functionally equivalent to {[Level] [Class]}. This can be useful in certain tags such as {[Level:IsLess([Level#player])]}. It is also possible to embed sequences within the core sequence itself, e.g. {[[Status:CurHP]:Green]} will highlight the result of {[Status:CurHP]} green, whereas {[Status:CurHP:Green]} would actually only highlight the result of {[CurHP]}.
				]=]},
				{ "Arithmetic operators", [=[
				You can use arithmetic operators in your DogTag sequences without issue, they function as expected with proper order-of-operations. {[1+2*3]} is functionally equivalent to {[1:Add([2:Mult(3)])]}<br /><br />
				* {{+}} - Addition<br />
				* {{-}} - Subtraction<br />
				* {{*}} - Multiplication<br />
				* {{/}} - Division<br />
				* {{%}} - Modulus<br />
				* {{^}} - Exponentiation
				]=]},
				{ "Comparison operators", [=[
				You can use comparison operators in your DogTag very similarly to arithmetic operators. {[1+2=3]} is functionally equivalent to {[1:Add([2]):IsEqual(3)]}<br /><br />
				* {{=}} - Equality<br />
				* {{~=}} - Inequality<br />
				* {{<}} - Less than<br />
				* {{>}} - Greater than<br />
				* {{<=}} - Less than or equal<br />
				* {{>=}} - Greater than or equal
				]=]}
			}
		})
		
		local function wrapWhite(text)
			return "|cffffffff" .. text .. "|r"
		end
		
		local function highlightWords(text)
			text = text:gsub("%f[A-Za-z0-9_](unit)%f[^A-Za-z0-9_]", wrapWhite)
			text = text:gsub("%f[A-Za-z0-9_](argument)%f[^A-Za-z0-9_]", wrapWhite)
			text = text:gsub("%f[A-Za-z0-9_](value)%f[^A-Za-z0-9_]", wrapWhite)
			text = text:gsub("%f[A-Za-z0-9_](number_value)%f[^A-Za-z0-9_]", wrapWhite)
			text = text:gsub("%f[A-Za-z0-9_](number)%f[^A-Za-z0-9_]", wrapWhite)
			return text
		end
		
		local tagsData = { 
			{L["Tags"], }
		}
		local tags = newList()
		local tagCategories_tmp = newSet(L["Miscellaneous"])
		for k,v in pairs(Tags["Base"]) do
			if v.doc then
				tags[#tags+1] = k
			end
		end
		table.sort(tags)
		for k,v in pairs(Tags["Base"]) do
			if v.category then
				tagCategories_tmp[v.category] = true
			end
		end
		local tagCategories = newList()
		for k in pairs(tagCategories_tmp) do
			tagCategories[#tagCategories+1] = k
		end
		tagCategories_tmp = del(tagCategories_tmp)
		table.sort(tagCategories)
		for _,category in ipairs(tagCategories) do
			local t = newList()
			for _,k in ipairs(tags) do
				if getTag(k, 'category', "Base") == category or (category == L["Miscellaneous"] and not getTag(k, 'category', "Base")) then
					local v = getTag(k, 'doc', "Base")
					local arg = getTag(k, 'arg', "Base")
					if getTag(k, 'alias', "Base") and not getTag(k, 'code', "Base") then
						-- alias
						local alias = getTag(k, 'alias', "Base")
						if not alias:find("[%(:!%?%+%-%*/^%%<>=]") and not alias:find("~=") and not alias:find("||") then
							local code, param, negate, unit = splitParam(alias, "Base")
							while getTag(code, 'alias', "Base") do
								local a = getTag(code, 'alias', "Base")
								if a:find("[%(:!%?%+%-%*/^%%<>=]") or a:find("~=") or a:find("||") then
									param = true
									break
								end
								local newParam, newNegate, newUnit
								code, newParam, newNegate, newUnit = splitParam(getTag(code, 'alias', "Base"), "Base")
								if not param then
									param = newParam
								end
								if newNegate then
									negate = not negate
								end
								if not unit then
									unit = newUnit
								end
							end
							if param then
								arg = nil
							else
								arg = getTag(code, 'arg', "Base")
							end
						else
							arg = nil
						end
					end
					if not arg or arg:find("nil") then
						t[#t+1] = "{["
						t[#t+1] = k
						t[#t+1] = "]}"
					end
					if arg then
						if arg:find("nil") then
							t[#t+1] = " or "
						end
						t[#t+1] = "{["
						t[#t+1] = k
						t[#t+1] = "("
						if arg:find("string") then
							t[#t+1] = L["argument"]
						else -- number
							t[#t+1] = L["number"]
						end
						t[#t+1] = ")]}"
					end
					t[#t+1] = " - "
					t[#t+1] = highlightWords(v)
					if getTag(k, 'alias', "Base") then
						t[#t+1] = " - "
						t[#t+1] = L["alias for "]
						t[#t+1] = "{["
						t[#t+1] = getTag(k, 'alias', "Base")
						t[#t+1] = "]}"
					end
					t[#t+1] = "<br />"
					t[#t+1] = L["e.g. "]
					local examples = newList((";"):split(getTag(k, 'example', "Base")))
					for i, u in ipairs(examples) do
						if i > 1 then
							t[#t+1] = ", "
						end
						local tag, result = u:trim():match("(.*) => (.*)")
						t[#t+1] = "{"
						t[#t+1] = tag
						t[#t+1] = "}"
						t[#t+1] = " => "
						t[#t+1] = result
					end
					examples = del(examples)
					t[#t+1] = "<br />"
					t[#t+1] = "<br />"
				end
			end
			while t[#t] == "<br />" do
				t[#t] = nil
			end
			local result = table.concat(t)
			t = del(t)
			if result:len() > 0 then
				tagsData[1][#tagsData[1]+1] = { category, result }
			end
		end
		tagCategories = del(tagCategories)
		tags = del(tags)
		local tagsHTML = dataToHTML(tagsData)
		tagsData = nil
		
		local modifiersData = { 
			{L["Modifiers"], }
		}
		local modifiers = newList()
		for k, v in pairs(Modifiers["Base"]) do
			if v.doc then
				modifiers[#modifiers+1] = k
			end
		end
		table.sort(modifiers)
		local modifierCategories_tmp = newSet(L["Miscellaneous"])
		for k, v in pairs(Modifiers["Base"]) do
			if v.category then
				modifierCategories_tmp[v.category] = true
			end
		end
		local modifierCategories = newList()
		for k in pairs(modifierCategories_tmp) do
			modifierCategories[#modifierCategories+1] = k
		end
		modifierCategories_tmp = del(modifierCategories_tmp)
		table.sort(modifierCategories)
		for _,category in ipairs(modifierCategories) do
			local t = newList()
			for _,k in ipairs(modifiers) do
				if getModifier(k, 'category', "Base") == category or (category == L["Miscellaneous"] and not getModifier(k, 'category', "Base")) then
					local v = getModifier(k, 'doc', "Base")
					local value = getModifier(k, 'value', "Base")
					local arg = getModifier(k, 'arg', "Base")
					local k_ = k
					if getModifier(k, 'alias', "Base") then
						-- alias
						local alias = getModifier(k, 'alias', "Base")
						local code, param, negate, unit = splitParam(alias, "Base")
						while getModifier(code, 'alias', "Base") do
							local newParam, newNegate, newUnit
							code, newParam, newNegate, newUnit = splitParam(getModifier(code, 'alias', "Base"), "Base")
							if not param then
								param = newParam
							end
							if newNegate then
								negate = not negate
							end
							if not unit then
								unit = newUnit
							end
						end
						k_ = joinParam(code, param, negate, unit)
						value = getModifier(code, 'value', "Base")
						if param then
							arg = nil
						else
							arg = getModifier(code, 'arg', "Base")
						end
					end
					if not arg or arg:find("nil") then
						t[#t+1] = "{["
						if value == "number" then
							t[#t+1] = L["number_value"]
						else
							t[#t+1] = L["value"]
						end
						t[#t+1] = ":"
						t[#t+1] = k
						t[#t+1] = "]}"
					end
					if arg then
						if arg:find("nil") then
							t[#t+1] = " or "
						end
						t[#t+1] = "{["
						if value == "number" then
							t[#t+1] = L["number_value"]
						else
							t[#t+1] = L["value"]
						end
						t[#t+1] = ":"
						t[#t+1] = k
						t[#t+1] = "("
						if arg:find("string") then
							t[#t+1] = L["argument"]
						else -- number
							t[#t+1] = L["number"]
						end
						t[#t+1] = ")]}"
						
						if k_ == "Add" or k_ == "Sub" or k_ == "Mult" or k_ == "Div" or k_ == "Mod" or k_ == "Pow" then
							t[#t+1] = " or "
							t[#t+1] = "{["
							t[#t+1] = L["number_value"]
							if k_ == "Add" then
								t[#t+1] = "+"
							elseif k_ == "Sub" then
								t[#t+1] = "-"
							elseif k_ == "Mult" then
								t[#t+1] = "*"
							elseif k_ == "Div" then
								t[#t+1] = "/"
							elseif k_ == "Mod" then
								t[#t+1] = "%"
							elseif k_ == "Pow" then
								t[#t+1] = "^"
							end
							t[#t+1] = L["number"]
							t[#t+1] = "]}"
						elseif k_ == "IsEqual" or k_ == "~IsEqual" or k_ == "IsLess" or k_ == "IsLessEqual" or k_ == "~IsLessEqual" or k_ == "~IsLess" then
							t[#t+1] = " or "
							t[#t+1] = "{["
							t[#t+1] = L["value"]
							if k_ == "Add" then
							elseif k_ == "IsEqual" then
								t[#t+1] = "="
							elseif k_ == "~IsEqual" then
								t[#t+1] = "~="
							elseif k_ == "IsLess" then
								t[#t+1] = "<"
							elseif k_ == "IsLessEqual" then
								t[#t+1] = "<="
							elseif k_ == "~IsLessEqual" then
								t[#t+1] = ">"
							elseif k_ == "~IsLess" then
								t[#t+1] = ">="
							end
							t[#t+1] = L["argument"]
							t[#t+1] = "]}"
						end
					end
					t[#t+1] = " - "
					t[#t+1] = highlightWords(v)
					if getModifier(k, 'alias', "Base") then
						t[#t+1] = " - "
						t[#t+1] = L["alias for "]
						t[#t+1] = "{{:"
						t[#t+1] = getModifier(k, 'alias', "Base")
						t[#t+1] = "}}"
					end
					t[#t+1] = "<br />"
			
					t[#t+1] = "e.g. "
					local examples = newList((";"):split(getModifier(k, 'example', "Base")))
					for i, u in ipairs(examples) do
						if i > 1 then
							t[#t+1] = ", "
						end
						local tag, result = u:trim():match("(.*) => (.*)")
						t[#t+1] = "{"
						t[#t+1] = tag
						t[#t+1] = "}"
						t[#t+1] = " => "
						t[#t+1] = result:gsub("{", "&lbrace;"):gsub("}", "&rbrace;"):gsub("<", "&lt;"):gsub(">", "&gt;")
					end
					examples = del(examples)
			
					t[#t+1] = "<br />"
					t[#t+1] = "<br />"
				end
			end
			
			while t[#t] == "<br />" do
				t[#t] = nil
			end
			local result = table.concat(t)
			t = del(t)
			if result:len() > 0 then
				modifiersData[1][#modifiersData[1]+1] = { category, result }
			end
		end
		modifiers = del(modifiers)
		modifierCategories = del(modifierCategories)
		local modifiersHTML = dataToHTML(modifiersData)
		modifiersData = nil
		
		local tabCount = 0
		local function makeTab(name)
			tabCount = tabCount + 1
			local tab = CreateFrame("Button", helpFrame:GetName() .. "Tab" .. tabCount, helpFrame, "TabButtonTemplate")
			tab:SetText(name)
			PanelTemplates_TabResize(0, tab)
			tab:SetID(tabCount)
			tab:SetScript("OnClick", function(this)
				PanelTemplates_SetTab(this:GetParent(), this:GetID())
				if this.Select then
					this:Select()
				end
				scrollBar:SetValue(0)
			end)
			tab:SetFrameLevel(tab:GetFrameLevel()+10)
			return tab
		end
		local tab1, tab2, tab3 = makeTab(L["Syntax"]), makeTab(L["Tags"]), makeTab(L["Modifiers"])
		
		tab1:SetPoint("TOPLEFT", 30, -5)
		tab2:SetPoint("LEFT", tab1, "RIGHT")
		tab3:SetPoint("LEFT", tab2, "RIGHT")
		
		PanelTemplates_SetNumTabs(helpFrame, 3)
		helpFrame.selectedTab = 1
		PanelTemplates_SetTab(helpFrame, 1)
		
		function tab1:Select()
			html.text = syntaxHTML
			html:SetText(syntaxHTML)
		end
		
		function tab2:Select()
			html.text = tagsHTML
			html:SetText(tagsHTML)
		end
		
		function tab3:Select()
			html.text = modifiersHTML
			html:SetText(modifiersHTML)
		end
		
		tab1:Select()
	end
	function DogTag:OpenHelp()
		helpFrame:Show()
	end
end

local requireNamespace = false

--[[
Notes:
	Adds a fake global value that can be easily accessed by a tag or modifier.
	Though adding with the key "something", it is accessed by "DogTag___something" and defined as a global with "DogTag.__something"
Arguments:
	string - namespace to add the fake global to
	string - name of the fake global
	table or function - value of the fake global
]]
function DogTag:AddFakeGlobal(ns, key, value)
	if not requireNamespace then
		ns, key, value = "Base", ns, key
	end
	if type(ns) ~= "string" then
		error(("Bad argument #2 to `AddFakeGlobal'. Expected %q, got %q"):format("string", type(ns)), 2)
	end
	if type(key) ~= "string" then
		error(("Bad argument #3 to `AddFakeGlobal'. Expected %q, got %q"):format("string", type(key)), 2)
	end
	if type(value) ~= "table" and type(value) ~= "function" then
		error(("Bad argument #4 to `AddFakeGlobal'. Expected %q or %q, got %q"):format("table", "function", type(value)), 2)
	end
	if not FakeGlobals[ns] then
		FakeGlobals[ns] = newList()
	end
	FakeGlobals[ns]["__" .. key] = value
end

--[[
Notes:
	Adds a simplistic event handler.
	You should likely manage your own event handler if adding tags from an external addon.
Arguments:
	string - name of the Blizzard event
	table or function - object that method exists on or function to call
	[optional] string - name of the method on object
]]
function DogTag:AddEventHandler(event, tab, method)
	if type(event) ~= "string" then
		error(("Bad argument #2 to `AddEventHandler'. Expected %q, got %q"):format("string", type(event)), 2)
	end
	local func
	if type(tab) == "table" then
		if type(method) ~= "string" then
			error(("Bad argument #4 to `AddEventHandler'. Expected %q, got %q"):format("string", type(method)), 2)
		end
		if type(tab[method]) ~= "function" then
			error(("Bad argument #4 to `AddEventHandler'. Expected method, got %q"):format(type(tab[method])), 2)
		end
		func = function(...)
			return tab[method](tab, ...)
		end
	else
		if type(tab) ~= "function" then
			error(("Bad argument #3 to `AddEventHandler'. Expected %q or %q, got %q"):format("table", "function", type(tab)), 2)
		end
		func = tab
	end
	if not EventHandlers[event] then
		EventHandlers[event] = newList()
		DogTag.frame:RegisterEvent(event)
	end
	table.insert(EventHandlers[event], 1, func)
end

--[[
Notes:
	Adds a simplistic timer handler, called roughly every 0.05 seconds, right before texts are updated.
	You should likely manage your own timer handler if adding tags from an external addon.
Arguments:
	table or function - object that method exists on or function to call
	[optional] string - name of the method on object
]]
function DogTag:AddTimerHandler(tab, method)
	local func
	if type(tab) == "table" then
		if type(method) ~= "string" then
			error(("Bad argument #3 to `AddEventHandler'. Expected %q, got %q"):format("string", type(method)), 2)
		end
		if type(tab[method]) ~= "function" then
			error(("Bad argument #3 to `AddEventHandler'. Expected method, got %q"):format(type(tab[method])), 2)
		end
		func = function(...)
			return tab[method](tab, ...)
		end
	else
		if type(tab) ~= "function" then
			error(("Bad argument #2 to `AddTimerHandler'. Expected %q or %q, got %q"):format("table", "function", type(tab)), 2)
		end
		func = tab
	end
	table.insert(TimerHandlers, 1, func)
end

--[[
Notes:
	Adds a handler to be called when a unit is completely refreshed
Arguments:
	table or function - object that method exists on or function to call
	[optional] string - name of the method on object
]]
function DogTag:AddUpdateAllForUnitHandler(tab, method)
	local func
	if type(tab) == "table" then
		if type(method) ~= "string" then
			error(("Bad argument #3 to `AddUpdateAllForUnitHandler'. Expected %q, got %q"):format("string", type(method)), 2)
		end
		if type(tab[method]) ~= "function" then
			error(("Bad argument #3 to `AddUpdateAllForUnitHandler'. Expected method, got %q"):format(type(tab[method])), 2)
		end
		func = function(...)
			return tab[method](tab, ...)
		end
	else
		if type(tab) ~= "function" then
			error(("Bad argument #2 to `AddUpdateAllForUnitHandler'. Expected %q or %q, got %q"):format("table", "function", type(tab)), 2)
		end
		func = tab
	end
	table.insert(UpdateAllForUnitHandlers, 1, func)
end

--[[
Notes:
	Adds a handler to be called when an addon or library comes into being
Arguments:
	string - "_G" for a value on the global table or "LibStub", "Rock", "AceLibrary" for a library of the specified type
	string - name of the addon or library
	function - function to be called when addon or library is found
]]
function DogTag:AddAddonFinder(kind, name, func)
	if type(kind) ~= "string" then
		error(("Bad argument #2 to `AddAddonFinder'. Expected %q, got %q"):format("string", type(kind)), 2)
	end
	if kind ~= "_G" and kind ~= "LibStub" and kind ~= "Rock" and kind ~= "AceLibrary" then
		error(("Bad argument #2 to `AddAddonFinder'. Expected %q, %q, %q or %q, got %q"):format("_G", "LibStub", "Rock", "AceLibrary", kind), 2)
	end
	if type(name) ~= "string" then
		error(("Bad argument #3 to `AddAddonFinder'. Expected %q, got %q"):format("string", type(name)), 2)
	end
	if type(func) ~= "function" then
		error(("Bad argument #4 to `AddAddonFinder'. Expected %q, got %q"):format("function", type(func)), 2)
	end
	AddonFinders[{kind, name, func}] = true
end

--[[
Notes:
	Adds a modifier to the specified namespace
Arguments:
	string - namespace to add to
	string - name of the modifier
	table - data of the modifier, see Modules\Example.lua for more details
]]
function DogTag:AddModifier(ns, mod, data)
	if not requireNamespace then
		ns, mod, data = "Base", ns, mod
	end
	if type(ns) ~= "string" then
		error(("Bad argument #2 to `AddModifier'. Expected %q, got %q"):format("string", type(ns)), 2)
	end
	if type(mod) ~= "string" then
		error(("Bad argument #3 to `AddModifier'. Expected %q, got %q"):format("string", type(mod)), 2)
	end
	if type(data) ~= "table" and type(data) ~= "string" and type(data) ~= "function" then
		error(("Bad argument #4 to `AddModifier'. Expected %q, %q, or %q, got %q"):format("table", "string", "function", type(data)), 2)
	end
	if not Modifiers[ns] then
		Modifiers[ns] = newList()
	end
	if Modifiers["Base"][mod] or Modifiers[ns][mod] then
		error(("Bad argument #3 to `AddModifier'. %q already registered"):format(mod), 2)
	end
	local modData = newList()
	Modifiers[ns][mod] = modData
	
	if type(data) == "table" then
		if data.alias then
			if type(data.alias) == "string" then
				modData.alias = data.alias
			else -- function
				modData.alias = data.alias()
				modData.aliasFunc = data.alias
			end
		else
			local arg = sortStringList(data.arg)
			if arg and arg ~= "nil" then
				modData.arg = arg
				local a,b,c = (";"):split(arg)
				if a ~= "nil" and a ~= "number" and a ~= "string" then
					error("arg must have nil, number, or string", 2)
				end
				if b and b ~= "nil" and b ~= "number" and b ~= "string" then
					error("arg must have nil, number, or string", 2)
				end
				if c and c ~= "nil" and c ~= "number" and c ~= "string" then
					error("arg must have nil, number, or string", 2)
				end
			end
			modData.ret = sortStringList(data.ret)
			if data.ret then
				local a,b,c = (";"):split(data.ret)
				if a ~= "nil" and a ~= "number" and a ~= "string" and a ~= "same" then
					error("ret must have same, nil, number, or string", 2)
				end
				if b and b ~= "nil" and b ~= "number" and b ~= "string" and b ~= "same" then
					error("ret must have same, nil, number, or string", 2)
				end
				if c and c ~= "nil" and c ~= "number" and c ~= "string" and c ~= "same" then
					error("ret must have same, nil, number, or string", 2)
				end
			end
			local value = sortStringList(data.value)
			if value and value ~= "number;string" then
				modData.value = value
				local a,b = (";"):split(value)
				if a ~= "number" and a ~= "string" then
					error("value must have number or string", 2)
				end
				if b and b ~= "number" and b ~= "string" then
					error("value must have number or string", 2)
				end
			end
			modData.events = sortStringList(data.events)
			modData.globals = sortStringList(data.globals)
			if modData.globals then
				local globals = newList((';'):split(modData.globals))
				for _,v in ipairs(globals) do
					if not v:find("%.") and not _G[v] then
						error("Unknown global: %q"):format(v)
					end
				end
				globals = del(globals)
			end
			modData.alias = data.fakeAlias
		end
		modData.doc = data.doc
		modData.example = data.example
		modData.category = data.category
		local func = data[1]
		del(data)
		if not data.alias then
			modData.code = func
		end
	elseif type(data) == "string" then
		modData.alias = data
	elseif type(data) == "function" then
		modData.alias = data()
		modData.aliasFunc = data
	end
end

--[[
Notes:
	Adds a tag to the specified namespace
Arguments:
	string - namespace to add to
	string - name of the tag
	table - data of the tag, see Modules\Example.lua for more details
]]
function DogTag:AddTag(ns, tag, data, withMod)
	if not requireNamespace then
		ns, tag, data, withMod = "Base", ns, tag, data
	end
	if type(ns) ~= "string" then
		error(("Bad argument #2 to `AddTag'. Expected %q, got %q"):format("string", type(ns)), 2)
	end
	if type(tag) ~= "string" then
		error(("Bad argument #3 to `AddTag'. Expected %q, got %q"):format("string", type(tag)), 2)
	end
	if type(data) ~= "table" and type(data) ~= "string" and type(data) ~= "function" then
		error(("Bad argument #4 to `AddModifier'. Expected %q, %q, or %q, got %q"):format("table", "string", "function", type(data)), 2)
	end
	if not Tags[ns] then
		Tags[ns] = newList()
	end
	if Tags["Base"][tag] or Tags[ns][tag] then
		error(("Bad argument #3 to `AddTag'. %q already registered"):format(tag), 2)
	end
	local tagData = newList()
	Tags[ns][tag] = tagData
	
	if type(data) == "table" then
		if data.alias then
			if type(data.alias) == "string" then
				tagData.alias = data.alias
			else -- function
				tagData.alias = data.alias()
				tagData.aliasFunc = data.alias
			end
		else
			local arg = sortStringList(data.arg)
			if arg and arg ~= "nil" then
				tagData.arg = arg
				local a,b,c = (";"):split(arg)
				if a ~= "nil" and a ~= "number" and a ~= "string" then
					error("arg must have nil, number, or string", 2)
				end
				if b and b ~= "nil" and b ~= "number" and b ~= "string" then
					error("arg must have nil, number, or string", 2)
				end
				if c and c ~= "nil" and c ~= "number" and c ~= "string" then
					error("arg must have nil, number, or string", 2)
				end
			end
			tagData.ret = sortStringList(data.ret)
			if data.ret then
				local a,b,c = (";"):split(data.ret)
				if a ~= "nil" and a ~= "number" and a ~= "string" and a ~= "same" then
					error("ret must have same, nil, number, or string", 2)
				end
				if b and b ~= "nil" and b ~= "number" and b ~= "string" and b ~= "same" then
					error("ret must have same, nil, number, or string", 2)
				end
				if c and c ~= "nil" and c ~= "number" and c ~= "string" and c ~= "same" then
					error("ret must have same, nil, number, or string", 2)
				end
			end
			tagData.events = sortStringList(data.events)
			tagData.globals = sortStringList(data.globals)
			if tagData.globals then
				local globals = newList((';'):split(tagData.globals))
				for _,v in ipairs(globals) do
					if not v:find("%.") and not _G[v] then
						error(("Unknown global: %q"):format(v))
					end
				end
				globals = del(globals)
			end
			tagData.alias = data.fakeAlias
		end
		tagData.doc = data.doc
		tagData.example = data.example
		tagData.category = data.category
		local func = data[1]
		if not withMod then
			del(data)
		end
		if not data.alias then
			tagData.code = func
		end
	elseif type(data) == "string" then
		tagData.alias = data
	elseif type(data) == "function" then
		tagData.alias = data()
		tagData.aliasFunc = data
	end
end

--[[
Notes:
	Adds a tag/modifier combination to the specified namespace
Arguments:
	string - namespace to add to
	string - name of the tag/modifier
	table - data of the tag/modifier, see Modules\Example.lua for more details
]]
function DogTag:AddTagAndModifier(ns, name, data)
	if not requireNamespace then
		self:AddTag(ns, name, true)
		self:AddModifier(ns, name)
	else
		self:AddTag(ns, name, data, true)
		self:AddModifier(ns, name, data)
	end
end

DogTag_funcs[#DogTag_funcs+1] = function()
	_G.DogTag = nil
	requireNamespace = true
	--[[
	DogTag.AddModifier = nil
	DogTag.AddTag = nil
	DogTag.AddTagAndModifier = nil
	DogTag.AddFakeGlobal = nil
	DogTag.AddAddonFinder = nil
	DogTag.AddEventHandler = nil
	DogTag.AddTimerHandler = nil
	DogTag.newList = nil
	DogTag.newDict = nil
	DogTag.newSet = nil
	DogTag.del = nil
	DogTag.IsLegitimateUnit = nil
	DogTag.IsNormalUnit = nil
	DogTag.hasEvent = nil
	DogTag.eventData = nil
	DogTag.oldLib = nil
	DogTag.toUpdate = nil
	DogTag.quickUpdate = nil
	DogTag.GetNameServer = nil
	DogTag.FakeGlobals = nil
	DogTag.runUpdate = nil
	]]
end

DogTag:AddTag("_", {
	[[value = "_ tag referenced improperly"]],
	arg = "string;number;nil",
	ret = "string;number;nil"
})

DogTag:AddFakeGlobal("colors", colors)
DogTag:AddFakeGlobal("cleanText", cleanText)
DogTag:AddFakeGlobal("NIL", {})
DogTag:AddFakeGlobal("UnitToLocale", UnitToLocale)

DogTag:AddEventHandler("PARTY_MEMBERS_CHANGED", DogTag, "PARTY_MEMBERS_CHANGED")
DogTag:AddEventHandler("PLAYER_ENTERING_WORLD", DogTag, "PLAYER_ENTERING_WORLD")
DogTag:AddEventHandler("PLAYER_TARGET_CHANGED", DogTag, "PLAYER_TARGET_CHANGED")
DogTag:AddEventHandler("PLAYER_FOCUS_CHANGED", DogTag, "PLAYER_FOCUS_CHANGED")
DogTag:AddEventHandler("PLAYER_PET_CHANGED", DogTag, "PLAYER_PET_CHANGED")
DogTag:AddEventHandler("UPDATE_MOUSEOVER_UNIT", DogTag, "UPDATE_MOUSEOVER_UNIT")
DogTag:AddEventHandler("UNIT_PET", DogTag, "UNIT_PET")
DogTag:AddEventHandler("ADDON_LOADED", DogTag, "ADDON_LOADED")
DogTag:AddEventHandler("PLAYER_LOGIN", DogTag, "PLAYER_LOGIN")

DogTag:AddTimerHandler(function(num, currentTime)
	local noMouseover = not UnitExists("mouseover")
	if inMouseover and noMouseover then
		inMouseover = false
		for event, data in pairs(eventData) do
			for text, u in pairs(data) do
				if u == "mouseover" or u.mouseover then
					toUpdate[text] = true
				end
			end
		end
	end
	if noMouseover then
		for text in pairs(toUpdate) do
			if registry[text] == "mouseover" then
				toUpdate[text] = nil
				quickUpdate[text] = nil
			end
		end
	end
end)

DogTag:AddTimerHandler(function(num, currentTime)
	local mouseoverIsTarget = UnitIsUnit("target", "mouseover")
	for event, units in pairs(buckets) do
		if hasEvent[event] then
			if units[false] then
				for text in pairs(eventData[event]) do
					toUpdate[text] = true
				end
			else
				if mouseoverIsTarget and not units.mouseover then
					units.mouseover = units.target
				end
				for text, unit in pairs(eventData[event]) do
					if not toUpdate[text] then
						if units[unit] then
							toUpdate[text] = true
						elseif type(unit) == "table" then
							for u in pairs(unit) do
								if units[u] then
									toUpdate[text] = true
								end
							end
						end
					end
				end
			end
		end
		buckets[event] = del(units)
	end
end)

DogTag:AddTimerHandler(function(num, currentTime)
	if hasEvent.FastUpdate then
		for text in pairs(eventData.FastUpdate) do
			toUpdate[text] = true
		end
	end
end)

DogTag:AddTimerHandler(function(num, currentTime)
	if num%3 == 0 and hasEvent.Update then
		for text in pairs(eventData.Update) do
			toUpdate[text] = true
		end
	end
end)

DogTag:AddTimerHandler(function(num, currentTime)
	if num%200 == 0 and hasEvent.SlowUpdate then
		for text in pairs(eventData.SlowUpdate) do
			toUpdate[text] = true
		end
	end
end)

if not LibStub("LibDogTag-3.0", true) then
	_G.SlashCmdList.DOGTAG = function()
		DogTag:OpenHelp()
	end

	_G.SLASH_DOGTAG1 = "/dogtag"
	_G.SLASH_DOGTAG2 = "/dog"
	_G.SLASH_DOGTAG3 = "/dt"
end

end