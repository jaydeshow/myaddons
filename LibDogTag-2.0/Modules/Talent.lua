local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63342 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local toUpdate = DogTag.toUpdate
local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local newList = DogTag.newList
local del = DogTag.del
local GetNameServer = DogTag.GetNameServer

local RockComm, talentReceptor
DogTag:AddAddonFinder("Rock", "LibRockComm-1.0", function(v)
	RockComm = v
	RockComm:AddTalentReceptor(talentReceptor)
end)

local talentSpecs, talentSpecNames
local addonVersionReceptor

local triedTalentWhisper = {} -- don't whisper twice
local lastInspectTime = 0 -- based on GetTime()
local lastInspectName = nil
local lastInspectClass = nil
local inspectionQueue = {}

local function QueryTalents(name)
	-- assume talentSpecs[".current"] is a proper unit and UnitIsPlayer(unit)
	local unit = talentSpecs[".current"]
	
	if RockComm and not triedTalentWhisper[name] then
		triedTalentWhisper[name] = true
		if UnitIsFriend("player", unit) then
			RockComm:QueryTalents("WHISPER", name)
		end
	end
	
	inspectionQueue[name] = true
	if (not InspectFrame or not InspectFrame.unit) and UnitIsVisible(unit) and UnitIsConnected(unit) and (GetTime() - lastInspectTime > 15 or not lastInspectName) then
		lastInspectName = name
		local _
		_, lastInspectClass = UnitClass(unit)
		lastInspectTime = GetTime()
		NotifyInspect(unit)
	end
end

local mt = {__index = function(self, key)
	QueryTalents(key)
	return rawget(self, key) or false
end}
talentSpecs = setmetatable({}, mt)
talentSpecNames = setmetatable({}, mt)
DogTag:AddFakeGlobal("talentSpecs", talentSpecs)
DogTag:AddFakeGlobal("talentSpecNames", talentSpecNames)

local isMaxLevel = UnitLevel("player") == _G.MAX_PLAYER_LEVEL and _G.MAX_PLAYER_LEVEL

local function better_UnitLevel(unit)
	local level = UnitLevel(unit)
	if level > 0 then
		return level
	end
	if not UnitIsPlayer(unit) then
		if isMaxLevel then
			-- if you're at the max level and something is higher than you, it's 3 levels higher.
			return isMaxLevel + 3
		elseif UnitClassification(unit) == "worldboss" then
			return UnitLevel("player") + 3
		else
			return level
		end
	end
	local name, server = UnitName(unit)
	if server and server ~= "" then
		name = name .. "-" .. server
	end
	talentSpecs[".current"] = unit
	local value = talentSpecs[name]
	if not value then
		return 0
	end
	local a, b, c = value:match("^(%d+)/(%d+)/(%d+)$")
	if not a then
		return 0
	end
	local total = a + b + c
	return total + 9
end
DogTag:AddFakeGlobal("better_UnitLevel", better_UnitLevel)

local function getTalentSpecName(class, nums)
	class = class:sub(1, 1) .. class:sub(2):lower()
	if nums[1] == 0 and nums[2] == 0 and nums[3] == 0 then
		return _G.NONE or "None"
	else
		local first, second, third
		if nums[1] >= nums[2] then
			if nums[1] >= nums[3] then
				first = 1
				if nums[2] >= nums[3] then
					second = 2
					third = 3
				else
					second = 3
					third = 2
				end
			else
				first = 3
				second = 1
				third = 2
			end
		else
			if nums[2] >= nums[3] then
				first = 2
				if nums[1] >= nums[3] then
					second = 1
					third = 3
				else
					second = 3
					third = 1
				end
			else
				first = 3
				second = 2
				third = 1
			end
		end
		local first_num = nums[first]
		local second_num = nums[second]
		if first_num*3/4 <= second_num then
			if first_num*3/4 <= nums[third] then
				-- all three balanced out
				return L["Hybrid"]
			else
				return L[class .. "_Tree_" .. first] .. "/" .. L[class .. "_Tree_" .. second]
			end
		else
			return L[class .. "_Tree_" .. first]
		end
	end
end

function talentReceptor(sender, data)
	local nums = newList()
	for i,v in ipairs(data) do
		local num = 0
		for j,u in ipairs(v) do
			num = num + u
		end
		nums[i] = num
	end
	inspectionQueue[sender] = nil
	talentSpecs[sender] = ("%d/%d/%d"):format(nums[1], nums[2], nums[3])
	talentSpecNames[sender] = getTalentSpecName(data.class, nums)
	nums = del(nums)
	-- trigger "Talent" event
	if not hasEvent.Talent then
		return
	end
	for text, unit in pairs(eventData.Talent) do
		toUpdate[text] = true
	end
end

local nextInspectionCheck = 0
local function checkInspectionQueue()
	if not next(inspectionQueue) then
		return
	end
	if InspectFrame and InspectFrame.unit then
		return
	end
	local name = GetNameServer(UnitName("player"))
	if inspectionQueue[name] then
		NotifyInspect("player")
		return
	end
	
	local found
	local name = UnitExists("mouseover") and UnitIsPlayer("mouseover") and GetNameServer(UnitName("mouseover"))
	if inspectionQueue[name] then
		found = true
	 	if UnitIsVisible("mouseover") and UnitIsConnected("mouseover") then
			NotifyInspect("mouseover")
			return
		end
	end

	local name = UnitExists("target") and UnitIsPlayer("target") and GetNameServer(UnitName("target"))
	if inspectionQueue[name] then
		found = true
	 	if UnitIsVisible("target") and UnitIsConnected("target") then
			NotifyInspect("target")
			return
		end
	end

	local name = UnitExists("focus") and UnitIsPlayer("focus") and GetNameServer(UnitName("focus"))
	if inspectionQueue[name] then
		found = true
	 	if UnitIsVisible("focus") and UnitIsConnected("focus") then
			NotifyInspect("focus")
			return
		end
	end

	local numRaid = GetNumRaidMembers()
	if numRaid > 0 then
		for i = 1, numRaid do
			local unit = "raid" .. i
			local name = UnitExists(unit) and GetNameServer(UnitName(unit))
			if inspectionQueue[name] then
				found = true
				if UnitIsVisible(unit) and UnitIsConnected(unit) then
					NotifyInspect(unit)
					return
				end
			end
		end
		for i = 1, numRaid do
			local unit = "raid" .. i .. "target"
			local name = UnitExists(unit) and UnitIsPlayer(unit) and GetNameServer(UnitName(unit))
			if inspectionQueue[name] then
				found = true
				if UnitIsVisible(unit) and UnitIsConnected(unit) then
					NotifyInspect(unit)
					return
				end
			end
		end
	else
		local numParty = GetNumPartyMembers()
		for i = 1, numParty do
			local unit = "party" .. i
			local name = UnitExists(unit) and GetNameServer(UnitName(unit))
			if inspectionQueue[name] then
				found = true
			 	if UnitIsVisible(unit) and UnitIsConnected(unit) then
					NotifyInspect(unit)
					return
				end
			end
		end
		for i = 1, numParty do
			local unit = "party" .. i .. "target"
			local name = UnitExists(unit) and UnitIsPlayer(unit) and GetNameServer(UnitName(unit))
			if inspectionQueue[name] then
				found = true
			 	if UnitIsVisible(unit) and UnitIsConnected(unit) then
					NotifyInspect(unit)
					return
				end
			end
		end
	end
	
	if not found then
		for k in pairs(inspectionQueue) do
			inspectionQueue[k] = nil
		end
	end
end

DogTag:AddTimerHandler(function(num, currentTime)
	if currentTime > nextInspectionCheck then
		nextInspectionCheck = currentTime + 30
		checkInspectionQueue()
	end
end)

DogTag:AddEventHandler("INSPECT_TALENT_READY", function()
	local unit = InspectFrame and InspectFrame.unit
	local name, class
	if not unit then
		if not lastInspectName or GetTime() - lastInspectTime > 15 then
			return
		end
		name = lastInspectName
		class = lastInspectClass
	else
		if not UnitExists(unit) or not UnitIsPlayer(unit) or not UnitIsVisible(unit) or not UnitIsConnected(unit) then
			return
		end
		name = GetNameServer(UnitName(unit))
		local _
		_, class = UnitClass(unit)
	end
	lastInspectName = nil
	inspectionQueue[name] = nil
	
	local nums = newList()
	for i = 1, GetNumTalentTabs(true) do
		local total = 0
		for j = 1, GetNumTalents(i, true) do
			total = total + select(5, GetTalentInfo(i, j, true))
		end
		nums[i] = total
	end
	
	talentSpecs[name] = ("%d/%d/%d"):format(nums[1], nums[2], nums[3])
	talentSpecNames[name] = getTalentSpecName(class, nums)
	nums = del(nums)
	
	-- trigger "Talent" event
	if hasEvent.Talent then
		for text, unit in pairs(eventData.Talent) do
			toUpdate[text] = true
		end
	end
	
	checkInspectionQueue()
end)

DogTag:AddTag("TalentSpec", {
	[[if UnitIsPlayer(${unit}) then
		local name, server = UnitName(${unit})
		if server and server ~= "" then
			name = name .. "-" .. server
		end
		DogTag___talentSpecs[".current"] = ${unit}
		value = DogTag___talentSpecs[name]
	end]],
	ret = "string;nil",
	events = "Talent",
	globals = "DogTag.__talentSpecs;UnitIsPlayer;UnitName",
	doc = L["Return the talent spec of unit if available"],
	example = '[TalentSpec] => "30/31/0"',
	category = L["Characteristics"]
})

DogTag:AddTag("TalentTree", {
	[[if UnitIsPlayer(${unit}) then
		local name, server = UnitName(${unit})
		if server and server ~= "" then
			name = name .. "-" .. server
		end
		DogTag___talentSpecs[".current"] = ${unit}
		value = DogTag___talentSpecNames[name]
	end]],
	ret = "string;nil",
	events = "Talent",
	globals = "DogTag.__talentSpecs;DogTag.__talentSpecNames;UnitIsPlayer;UnitName",
	doc = L["Return the talent tree of unit if available"],
	example = ('[TalentTree] => %q'):format(L["Paladin_Tree_1"] .. "/" .. L["Paladin_Tree_2"]),
	category = L["Characteristics"]
})

end