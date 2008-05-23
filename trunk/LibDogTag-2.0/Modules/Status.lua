local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63783 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local IsLegitimateUnit = DogTag.IsLegitimateUnit
local GetNameServer = DogTag.GetNameServer
local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local toUpdate = DogTag.toUpdate
local registry = DogTag.registry

local offlineTimes = {}
local afkTimes = {}
local deadTimes = {}

local function PARTY_MEMBERS_CHANGED()
	local unitType, max = "raid", GetNumRaidMembers()
	if max == 0 then
		unitType, max = "party", GetNumPartyMembers()
	end

	for i = 0, max do
		local unit = unitType .. i
		if i == 0 then
			unit = "player"
		end
		if not UnitExists(unit) then
			break
		end
		local name = GetNameServer(UnitName(unit))
		if not UnitIsConnected(unit) then
			if not offlineTimes[name] then
				offlineTimes[name] = time()
			end
			afkTimes[name] = nil
		else
			offlineTimes[name] = nil
			if UnitIsAFK(unit) then
				if not afkTimes[name] then
					afkTimes[name] = time()
				end
			else
				afkTimes[name] = nil
			end
		end
		if UnitIsDeadOrGhost(unit) then
			if not deadTimes[name] then
				deadTimes[name] = time()
			end
		else
			deadTimes[name] = nil
		end
	end
end
DogTag:AddEventHandler("PARTY_MEMBERS_CHANGED", PARTY_MEMBERS_CHANGED)
DogTag:AddEventHandler("PLAYER_ENTERING_WORLD", PARTY_MEMBERS_CHANGED)

local function GetAFKTime(unit)
	local name = GetNameServer(UnitName(unit))
	local t = afkTimes[name]
	if not t then
		return nil
	end
	local time_diff = time() - t
	if time_diff < 3600 then
		return ("%d:%02d"):format(time_diff/60, time_diff%60)
	else
		return ("%d:%02d:%02d"):format(time_diff/3600, time_diff%3600/60, time_diff%60)
	end
end
DogTag:AddFakeGlobal("GetAFKTime", GetAFKTime)

local function GetDeadTime(unit)
	local name = GetNameServer(UnitName(unit))
	local t = deadTimes[name]
	if not t then
		return nil
	end
	local time_diff = time() - t
	if time_diff < 3600 then
		return ("%d:%02d"):format(time_diff/60, time_diff%60)
	else
		return ("%d:%02d:%02d"):format(time_diff/3600, time_diff%3600/60, time_diff%60)
	end
end
DogTag:AddFakeGlobal("GetDeadTime", GetDeadTime)

local function GetOfflineTime(unit)
	local name = GetNameServer(UnitName(unit))
	local t = offlineTimes[name]
	if not t then
		return nil
	end
	local time_diff = time() - t
	if time_diff < 3600 then
		return ("%d:%02d"):format(time_diff/60, time_diff%60)
	else
		return ("%d:%02d:%02d"):format(time_diff/3600, time_diff%3600/60, time_diff%60)
	end
end
DogTag:AddFakeGlobal("GetOfflineTime", GetOfflineTime)

local function PLAYER_FLAGS_CHANGED(unit)
	local name, server = UnitName(unit)
	if not name then
		return
	end
	if server and server ~= "" then
		name = name .. '-' .. server
	end
	local isAFK = UnitIsAFK(unit)

	if isAFK then
		if afkTimes[name] then
			return
		end
		afkTimes[name] = time()
	else
		if not afkTimes[name] then
			return
		end
		afkTimes[name] = nil
	end
	
	if hasEvent.AFKTime then
		for text, u in pairs(eventData.AFKTime) do
			if not toUpdate[text] then
				local n, server = UnitName(unit)
				if n then
					if server and server ~= "" then
						n = n .. '-' .. server
					end
					if n == name then
						toUpdate[text] = true
					end
				end
			end
		end
	end
end
DogTag:AddEventHandler("PLAYER_FLAGS_CHANGED", PLAYER_FLAGS_CHANGED)
DogTag:AddEventHandler("PLAYER_LOGIN", function()
	PLAYER_FLAGS_CHANGED("player")
end)

local namesChecked = {}
local nextTime = GetTime()
DogTag:AddTimerHandler(function(num, currentTime)
	if currentTime > nextTime then
		nextTime = nextTime + 1
		if hasEvent.AFKTime then
			for text in pairs(eventData.AFKTime) do
				local unit = registry[text]
				local name = GetNameServer(UnitName(unit))
				if name then
					if UnitIsVisible(unit) then
						if afkTimes[name] then
							toUpdate[text] = true
						end
					else
						if UnitIsAFK(unit) then
							if not afkTimes[name] then
								afkTimes[name] = time()
							end
							toUpdate[text] = true
						else
							if afkTimes[name] then
								afkTimes[name] = nil
								toUpdate[text] = true
							end
						end
					end
				end
			end
		end
		if hasEvent.OfflineTime then
			for text in pairs(eventData.OfflineTime) do
				if not toUpdate[text] then
					local unit = registry[text]
					local name, server = GetNameServer(UnitName(unit))
					if name then
						if offlineTimes[name] then
							toUpdate[text] = true
						end
					end
				end
			end
		end
		if hasEvent.DeadTime then
			for text in pairs(eventData.DeadTime) do
				local unit = registry[text]
				if UnitInRaid(unit) or UnitInParty(unit) then
					local name = GetNameServer(UnitName(unit))
					if name then
						if not namesChecked[name] then
							if UnitIsDeadOrGhost(unit) then
								if not deadTimes[name] then
									deadTimes[name] = time()
								end
								namesChecked[name] = true
								toUpdate[text] = true
							else
								if deadTimes[name] then
									deadTimes[name] = nil
									namesChecked[name] = true
									toUpdate[text] = true
								end
							end
						else
							toUpdate[text] = true
						end
					end
				elseif UnitIsDeadOrGhost(unit) then
					toUpdate[text] = true
				end
			end
			for k in pairs(namesChecked) do
				namesChecked[k] = nil
			end
		end
	end
end)

DogTag:AddTag("Status", {
	alias = "Offline || HasDivineIntervention || [Dead ? IsFeignedDeath || HasSoulstone || Dead]",
	doc = L["Return whether unit is offline, has divine intervention, is dead, feigning death, or has a soulstone while dead"],
	example = ('[Status] => "Offline"; [Status] => "Dead"; [Status] => ""'),
	category = L["Status"]
})

DogTag:AddTag("StatusGone", "Status")

DogTag:AddTag("OfflineTime", {
	[[value = DogTag___GetOfflineTime(${unit})]],
	ret = "string;nil",
	events = "OfflineTime",
	globals = "DogTag.__GetOfflineTime",
	doc = L["Return the time offline if unit is offline"],
	example = ('[OfflineTime] => "2:45"; [OfflineTime] => ""'),
	category = L["Status"]
})

DogTag:AddTag("Offline", {
	alias = ("OfflineTime:Paren:Prepend(%s )"):format(L["Offline"]),
	doc = L["Return Offline and the time offline if unit is offline"],
	example = ('[Offline] => "%s (2:45)"; [Offline] => ""'):format(L["Offline"]),
	category = L["Status"]
})

DogTag:AddTag("DeadTime", {
	[[value = DogTag___GetDeadTime(${unit})]],
	ret = "string;nil",
	events = "DeadTime",
	globals = "DogTag.__GetDeadTime",
	events = "DeadTime",
	doc = L["Return the time dead if unit is dead and time is known, unit can be dead and have an unknown time of death"],
	example = ('[DeadTime] => "1:34"; [DeadTime] => ""'),
	category = L["Status"]
})

DogTag:AddTag("DeadType", {
	([[value = UnitIsGhost(${unit}) and %q or UnitIsDead(${unit}) and %q]]):format(L["Ghost"], L["Dead"]),
	ret = "string;nil",
	globals = "DogTag.__GetDeadTime;UnitIsDead;UnitIsGhost",
	events = "DeadTime",
	doc = L["Return Dead or Ghost if unit is dead"],
	example = ('[DeadType] => "%s"; [DeadType] => "%s"; [DeadType] => ""'):format(L["Dead"], L["Ghost"]),
	category = L["Status"]
})

DogTag:AddTag("Dead", {
	alias = "Text([DeadType][DeadTime:Paren:Prepend( )])",
	doc = L["Return Dead or Ghost and the time dead if unit is dead"],
	example = ('[Dead] => "%s (1:34)"; [Dead] => "%s"; [Dead] => ""'):format(L["Dead"], L["Ghost"]),
	category = L["Status"]
})

DogTag:AddTag("AFKTime", {
	[[value = DogTag___GetAFKTime(${unit})]],
	ret = "string;nil",
	events = "AFKTime",
	globals = "DogTag.__GetAFKTime",
	doc = L["Return the time AFK if unit is AFK"],
	example = ('[AFKTime] => "2:12"; [AFKTime] => ""'),
	category = L["Status"]
})

DogTag:AddTag("AFK", {
	alias = ("AFKTime:Paren:Prepend(%s )"):format(L["AFK"]),
	doc = L["Return AFK and the time AFK if unit is AFK"],
	example = ('[AFK] => "%s (2:12)"; [AFK] => ""'):format(L["AFK"]),
	category = L["Status"]
})

DogTag:AddTag("DND", {
	([[value = UnitIsDND(${unit}) and %q]]):format(L["DND"]),
	ret = "string;nil",
	events = "PLAYER_FLAGS_CHANGED",
	globals = "UnitIsDND",
	doc = L["Return DND if the unit has specified DND"],
	example = ('[DND] => %q; [DND] => ""'):format(L["DND"]),
	category = L["Status"]
})

DogTag:AddTag("AFKDND", "AFK || DND")

DogTag:AddTag("PvP", {
	([[value = UnitIsPVPFreeForAll(${unit}) and %q or UnitIsPVP(${unit}) and %q]]):format(L["FFA"], L["PvP"]),
	ret = "string;nil",
	globals = "UnitIsPVP;UnitIsPVPFreeForAll",
	doc = L["Return PvP or FFA if the unit is PvP-enabled"],
	example = ('[PvP] => %q; [PvP] => %q; [PvP] => ""'):format(L["PvP"], L["FFA"]),
	category = L["Status"]
})

DogTag:AddTag("~PvP", {
	([[value = not UnitIsPVP(${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	globals = "UnitIsPVP"
})

DogTag:AddTag("Resting", {
	([[value = IsResting() and %q]]):format(L["Resting"]),
	ret = "string;nil",
	events = "PLAYER_UPDATE_RESTING",
	globals = "IsResting",
	doc = L["Return Resting if you are in an inn or capital city"],
	example = ('[Resting] => %q; [Resting] => ""'):format(L["Resting"]),
	category = L["Status"]
})

DogTag:AddTag("Leader", {
	([[value = UnitIsPartyLeader(${unit}) and %q]]):format(L["Leader"]),
	ret = "string;nil",
	globals = "UnitIsPartyLeader",
	doc = L["Return Leader if unit is a party leader"],
	example = ('[Leader] => %q; [Leader] => ""'):format(L["Leader"]),
	category = L["Status"]
})

DogTag:AddTag("LeaderShort", "Leader:Trunc(1)")

DogTag:AddTag("HappyNum", {
	[[value = GetPetHappiness() or 0]],
	ret = "number",
	events = "UNIT_HAPPINESS",
	globals = "GetPetHappiness",
	doc = L["Return the happiness number of your pet"],
	example = '[HappyNum] => "3"',
	category = L["Status"]
})

DogTag:AddTag("HappyText", {
	[=[value = _G["PET_HAPPINESS" .. (GetPetHappiness() or 0)]]=],
	ret = "string;nil",
	events = "UNIT_HAPPINESS",
	globals = "_G;GetPetHappiness",
	doc = L["Return a description of how happy your pet is"],
	example = ('[HappyText] => %q'):format(_G.PET_HAPPINESS3),
	category = L["Status"]
})

DogTag:AddTag("HappyIcon", {
	[[local happy = GetPetHappiness()
	if happy == 3 then
		value = ":D"
	elseif happy == 2 then
		value = ":I"
	elseif happy == 1 then
		value = "B("
	end]],
	ret = "string;nil",
	events = "UNIT_HAPPINESS",
	globals = "GetPetHappiness",
	doc = L["Return an icon representative of how happy your pet is"],
	example = ('[HappyIcon] => ":D"; [HappyIcon] => ":I"; [HappyIcon] => "B("'),
	category = L["Status"]
})

DogTag:AddTag("TappedByMe", {
	[[value = UnitIsTappedByPlayer(${unit}) and "*"]],
	ret = "string;nil",
	events = "Update",
	globals = "UnitIsTappedByPlayer",
	doc = L["Return * if unit is tapped by you"],
	example = '[TappedByMe] => "*"; [TappedByMe] => ""',
	category = L["Status"]
})

DogTag:AddTag("IsTapped", {
	([[value = UnitIsTapped(${unit}) and not UnitIsTappedByPlayer(${unit}) and %q]]):format(L["Tapped"]),
	ret = "string;nil",
	events = "Update",
	globals = "UnitIsTapped;UnitIsTappedByPlayer",
	doc = L["Return * if unit is tapped, but not by you"],
	example = ('[IsTapped] => %q; [IsTapped] => ""'):format(L["Tapped"]),
	category = L["Status"]
})

DogTag:AddTag("InCombat", {
	([[value = UnitAffectingCombat(${unit}) and %q]]):format(L["Combat"]),
	ret = "string;nil",
	events = "Update",
	globals = "UnitAffectingCombat",
	doc = L["Return True if unit is in combat"],
	example = ('[InCombat] => %q; [InCombat] => ""'):format(L["True"]),
	category = L["Status"]
})

DogTag:AddTag("FKey", {
	[[local fkey
	if UnitIsUnit(${unit}, "player") then
		fkey = 0
	else
		for i = 1, 4 do
			if UnitIsUnit(${unit}, "party" .. i) then
				fkey = i
				break
			end
		end
	end
	if fkey then
		value = "F" .. (fkey + 1)
	end]],
	ret = "string;nil",
	globals = "UnitIsUnit",
	doc = L["Return the function key to press to select unit"],
	example = '[FKey] => "F5"',
	category = L["Status"]
})

DogTag:AddTag("RaidGroup", {
	[[local n, s = UnitName(${unit})
	if s and s ~= "" then
		n = n .. "-" .. s
	end
	for i = 1, GetNumRaidMembers() do
		local name, rank, subgroup = GetRaidRosterInfo(i)
		if name == n then
			value = subgroup
			break
		end
	end]],
	ret = "string;nil",
	globals = "GetNumRaidMembers;GetRaidRosterInfo;UnitName",
	doc = L["Return the raid group that unit is in"],
	example = '[RaidGroup] => "3"',
	category = L["Status"]
})

DogTag:AddTag("MasterLooter", {
	([[local n, s = UnitName(${unit})
	if s and s ~= "" then
		n = n .. "-" .. s
	end
	for i = 1, GetNumRaidMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
		if name == n then
			value = isML and %q or nil
			break
		end
	end]]):format(L["True"]),
	ret = "string;nil",
	globals = "GetNumRaidMembers;GetRaidRosterInfo;UnitName",
	doc = L["Return True if unit is the master looter for your raid"],
	example = ('[MasterLooter] => %q; [MasterLooter] => ""'):format(L["True"]),
	category = L["Status"]
})

DogTag:AddTag("Target", {
	[[local u = unit .. "target"
	if UnitExists(u) then
		value = UnitName(u)
	end]],
	ret = "string;nil",
	events = "UNIT_TARGET",
	globals = "UnitExists;UnitName",
	doc = L["Return the name of unit's target"],
	example = ('[Target] => %q'):format(L["Grommash"]),
	category = L["Status"]
})

DogTag:AddTag("TargetTarget", {
	[[local u = unit .. "targettarget"
	if UnitExists(u) then
		value = UnitName(u)
	end]],
	ret = "string;nil",
	events = "UNIT_TARGET",
	globals = "UnitExists;UnitName",
	doc = L["Return the name of unit's target's target"],
	example = ('[Target] => %q'):format(L["Thrall"]),
	category = L["Status"]
})

DogTag:AddTag("NumTargeting", {
	[[value = 0
	local raid = GetNumRaidMembers()
	if raid > 0 then
		for i = 1, raid do
			if UnitIsUnit("raid" .. i .. "target", ${unit}) then
				value = value + 1
			end
		end
	else
		if UnitIsUnit("target", ${unit}) then
			value = value + 1
		end
		for i = 1, GetNumPartyMembers() do
			if UnitIsUnit("party" .. i .. "target", ${unit}) then
				value = value + 1
			end
		end
	end]],
	ret = "number",
	events = "UNIT_TARGET;Update",
	globals = "UnitIsUnit;GetNumRaidMembers;GetNumPartyMembers", 
	doc = L["Return the number of group members currently targeting unit"],
	example = '[NumTargeting] => "2"',
	category = L["Status"]
})

DogTag:AddTag("TargetingList", {
	[[local DogTag___TargetingList_tmp = DogTag.__TargetingList_tmp
	if not DogTag___TargetingList_tmp then
		DogTag___TargetingList_tmp = {}
		DogTag.__TargetingList_tmp = DogTag___TargetingList_tmp
	end
	local raid = GetNumRaidMembers()
	if raid > 0 then
		for i = 1, raid do
			if UnitIsUnit("raid" .. i .. "target", ${unit}) then
				local name, server = UnitName("raid" .. i)
				if server and server ~= "" then
					DogTag___TargetingList_tmp[#DogTag___TargetingList_tmp+1] = name .. "-" .. server
				else
					DogTag___TargetingList_tmp[#DogTag___TargetingList_tmp+1] = name
				end
			end
		end
	else
		if UnitIsUnit("target", ${unit}) then
			DogTag___TargetingList_tmp[#DogTag___TargetingList_tmp+1] = UnitName("player")
		end
		for i = 1, GetNumPartyMembers() do
			if UnitIsUnit("party" .. i .. "target", ${unit}) then
				DogTag___TargetingList_tmp[#DogTag___TargetingList_tmp+1] = UnitName("party" .. i)
			end
		end
	end
	table_sort(DogTag___TargetingList_tmp)
	if #DogTag___TargetingList_tmp >= 1 then
		value = table_concat(DogTag___TargetingList_tmp, ", ")
	end
	for i = 1, #DogTag___TargetingList_tmp do
		DogTag___TargetingList_tmp[i] = nil
	end]],
	ret = "string;nil",
	events = "UNIT_TARGET;Update",
	globals = "UnitIsUnit;GetNumRaidMembers;GetNumPartyMembers;UnitName;table.sort;table.concat",
	doc = L["Return an alphabetized, comma-separated list of group members currently targeting unit"],
	example = '[TargetingList] => "Grommash, Thrall"',
	category = L["Status"]
})

DogTag:AddTag("InGroup", {
	([[value = (GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0) and %q]]):format(L["True"]),
	ret = "string;nil",
	globals = "GetNumRaidMembers;GetNumPartyMembers",
	doc = L["Return True if you are in a party or raid"],
	example = ('[InGroup] => %q; [InGroup] => ""'):format(L["True"]),
	category = L["Status"]
})

DogTag:AddTag("IsUnit", {
	function(data)
		local arg = data.arg:lower()
		if not arg:find("%[") and not arg:find("%]") and not IsLegitimateUnit[arg] then
			return ("value = nil")
		end
		local unit = data.unit
		if unit then
			if not IsLegitimateUnit[unit] then
				return ("value = nil")
			end
			if unit == arg then
				return ("value = %q"):format(L["True"])
			end
			if (unit == "player" or unit == "pet" or unit:find("^party%d$") or unit:find("^partypet%d$")) and (arg == "player" or arg == "pet" or arg:find("^party%d$") or arg:find("^partypet%d$")) then
				return ("value = nil")
			elseif unit:find("^raid%d+") and (arg == "pet" or arg:find("^partypet%d$") or arg:find("^raidpet%d+$")) then
				return ("value = nil")
			elseif unit:find("^raidpet%d+") and (arg == "player" or arg:find("^party%d$") or arg:find("^raid%d+$")) then
				return ("value = nil")
			end
			return ("value = UnitIsUnit(${unit}, ${arg}) and %q"):format(L["True"])
		else
			return ("value = ((${unit} == ${arg}) or UnitIsUnit(${unit}, ${arg})) and %q"):format(L["True"])
		end
	end,
	arg = "string",
	ret = "string;nil",
	events = "Special_IsUnit",
	doc = L["Return True if unit is the same as argument"],
	example = ('[IsUnit(target)] => %q; [IsUnit(party1)] => ""'):format(L["True"]),
	category = L["Status"]
})

DogTag:AddTag("IsCharmed", {
	([[value = UnitIsCharmed(${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	globals = "UnitIsCharmed",
	doc = L["Return True if unit is under mind control"],
	example = ('[IsCharmed] => %q; [IsCharmed] => ""'):format(L["True"]),
	category = L["Status"]
})

DogTag:AddTagAndModifier("StatusColor", {
	function(data)
		return [[local r,g,b
		if not UnitIsConnected(${unit}) then
			r,g,b = unpack(colors.disconnected)
		elseif UnitIsDeadOrGhost(${unit}) then
			r,g,b = unpack(colors.dead)
		else
		]] .. (data.isMod and [[
			value = "|r" .. value
		]] or [[
			value = "|r"
		]]) .. [[
		end
		if r then
		]] .. (data.isMod and [[
			value = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		]] or [[
			value = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		]]) .. [[
		end]]
	end,
	value = "number;string",
	ret = "string",
	events = "DeadTime",
	globals = "unpack;UnitIsConnected;UnitIsDeadOrGhost",
	doc = L["Return the color or wrap value with the color associated with unit's current status"],
	example = '[Text(Hello):StatusColor] => "|cff7f7f7fHello|r"; [Text([StatusColor]Hello)] => "|cff7f7f7fHello"',
	category = L["Status"]
})

DogTag:AddTagAndModifier("HappyColor", {
	function(data)
		return [[local x = GetPetHappiness()
		local r,g,b
		if x == 3 then
			r,g,b = unpack(colors.petHappy)
		elseif x == 2 then
			r,g,b = unpack(colors.petNeutral)
		elseif x == 1 then
			r,g,b = unpack(colors.petAngry)
		else
		]] .. (data.isMod and [[
			value = "|r" .. value
		]] or [[
			value = "|r"
		]]) .. [[
		end
		if r then
		]] .. (data.isMod and [[
			value = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		]] or [[
			value = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		]]) .. [[
		end]]
	end,
	value = "number;string",
	ret = "string",
	events = "UNIT_HAPPINESS",
	globals = "unpack;GetPetHappiness",
	doc = L["Return the color or wrap value with the color associated with your pet's happiness"],
	example = '[Text(Hello):HappyColor] => "|cff00ff00Hello|r"; [Text([HappyColor]Hello)] => "|cff00ff00Hello"',
	category = L["Status"]
})

DogTag:AddTagAndModifier("CombatColor", {
	function(data)
		return [[
			if UnitAffectingCombat(${unit}) then
				local r,g,b = unpack(colors.inCombat)
		]] .. (data.isMod and [[
				value = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		]] or [[
				value = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		]]) .. [[
			else
		]] .. (data.isMod and [[
				value = "|r" .. value
			]] or [[
				value = "|r"
		]]) .. [[
			end
		]]
	end,
	value = "number;string",
	ret = "string",
	events = "Update",
	globals = "unpack;UnitAffectingCombat",
	doc = L["Return the color or wrap value with red if unit is in combat, otherwise no color"],
	example = '[Text(Hello):CombatColor] => "|cffff0000Hello|r"; [Text([CombatColor]Hello)] => "|cffff0000Hello"',
	category = L["Status"]
})

DogTag:AddTag("IsVisible", {
	([[value = UnitIsVisible(${unit}) and %q]]):format(L["True"]),
	ret = "string",
	events = "UNIT_PORTRAIT_UPDATE",
	globals = "UnitIsVisible",
	doc = L["Return True if unit is in visible range"],
	example = ('[IsVisible] => %q; [IsVisible] => ""'):format(L["True"]),
	category = L["Status"]
})

end