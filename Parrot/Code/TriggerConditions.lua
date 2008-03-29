local VERSION = tonumber(("$Revision: 48210 $"):match("%d+"))

local Parrot = Parrot
local Parrot_TriggerConditions = Parrot:NewModule("TriggerConditions", "LibRockEvent-1.0", "LibParser-4.0")
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2007-09-05 05:05:20 -0400 (Wed, 05 Sep 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

-- #AUTODOC_NAMESPACE Parrot_TriggerConditions

local RockEvent = Rock("LibRockEvent-1.0")
local RockTimer = Rock("LibRockTimer-1.0")
local Parser = Rock("LibParser-4.0")

local L = Parrot:L("Parrot_TriggerConditions")

local _,playerClass = UnitClass("player")

local conditions = {}
local lastStates = {}
local secondaryConditions = {}

local primaryChoices = {}
local secondaryChoices = {}

local onEnableFuncs = {}
local Parrot_Triggers
function Parrot_TriggerConditions:OnEnable()
	Parrot_Triggers = Parrot:GetModule("Triggers")
	for k, v in pairs(conditions) do
		if v.getCurrent then
			lastStates[k] = v.getCurrent()
		end
	end
	
	for _,v in ipairs(onEnableFuncs) do
		v()
	end
end

local onDisableFuncs = {}
function Parrot_TriggerConditions:OnDisable()
	for _,v in ipairs(onDisableFuncs) do
		v()
	end
end

local function RefreshEvents()
	local self = Parrot_TriggerConditions
	self:RemoveAllEventListeners()
	self:RemoveAllParserListeners()
	if not Parrot:IsModuleActive(self) then
		return
	end
	for k, v in pairs(conditions) do
		if v.events then
			for event in pairs(v.events) do
				local event_ns, event_ev = (";"):split(event, 2)
				if not event_ev then
					event_ns, event_ev = "Blizzard", event_ns
				end
				self:AddEventListener(event_ns, event_ev, "EventHandler")
			end
		elseif v.parserEvent then	
			self:AddParserListener(v.parserEvent, "ParserEventHandler", v)
		end
	end
end

-- #NODOC
function Parrot_TriggerConditions:EventHandler(namespace, event, arg1)
	local fullEvent = namespace == "Blizzard" and event or namespace .. ";" .. event
	for k, v in pairs(conditions) do
		if v.events then
			local arg = v.events[fullEvent]
			if arg == true or (arg1 ~= nil and arg == arg1) then
				if v.getCurrent then
					local state = v.getCurrent()
					local name = v.name
					local oldState = lastStates[name]
					lastStates[name] = state
					if state ~= nil and state ~= oldState then
						self:FirePrimaryTriggerCondition(name, state, -RockEvent.currentUID)
					end
				else
					self:FirePrimaryTriggerCondition(v.name, arg1, -RockEvent.currentUID)
				end
			end
		end
	end
end

-- #NODOC
function Parrot_TriggerConditions:ParserEventHandler(data, info)
	self:FirePrimaryTriggerCondition(data.name, info[data.parserArg], info.uid)
end

--[[----------------------------------------------------------------------------------
Arguments:
	string - the name of the trigger condition to fire, in English.
	[optional] string or number - a vital argument to provide information about the trigger condition.
Notes:
	* You have to register a trigger condition with :RegisterPrimaryTriggerCondition(data) first.
	* In most cases, if you use normal events in the registration or Parser-3.0, this shouldn't need to be called.
Example:
	Parrot:FirePrimaryTriggerCondition("My trigger condition", 50)
------------------------------------------------------------------------------------]]
function Parrot_TriggerConditions:FirePrimaryTriggerCondition(name, arg, uid)
	self = Parrot_TriggerConditions -- in case someone calls Parrot:FirePrimaryTriggerCondition
	
	if Parrot_Triggers and Parrot:IsModuleActive(Parrot_Triggers) then
		if not uid then
			if RockEvent.currentUID then
				uid = -RockEvent.currentUID
			elseif RockTimer.currentUID then
				uid = -RockTimer.currentUID - 1e10
			else
				local info = Parser:GetCurrentParserEvent()
				if info then
					uid = info.uid
				end
			end
		end
		Parrot_Triggers:OnTriggerCondition(name, arg, uid)
	end
end
Parrot.FirePrimaryTriggerCondition = Parrot_TriggerConditions.FirePrimaryTriggerCondition

--[[----------------------------------------------------------------------------------
Arguments:
	table - a data table holding the details of a primary trigger condition.
Notes:
	The data table is of the following style:
	<pre>{
		name = "Name of the condition in English",
		localName = "Name of the condition in the current locale",
		events = { -- this is optional
			NAME_OF_EVENT = value, -- where NAME_OF_EVENT is the event to check, only works when value is equal to arg1. Also, value could be true in which case it is always checked.
			-- there can be multiple events.
		},
		getCurrent = function() -- this is optional and to be used with events.
			if not SomeCondition() then
				return nil -- condition won't fire.
			else
				return value -- numeric value.
			end
		end,
		parserEvent = { -- this is optional and cannot be used in tandem with events.
			eventType = "Some eventType",
			-- see Parser-3.0 for more details.
		},
		parserArg = 'argName', -- this is optional and can be used with parserEvent. It will fill the arg when firing the trigger condition.
		param = {
			-- AceOptions argument here.
			-- do not specify get, set, name, or desc.
		}
	}</pre>
Example:
	Parrot:RegisterPrimaryTriggerCondition {
		name = "Incoming block",
		localName = L["Incoming block"],
		parserEvent = {
			eventType = "Miss",
			missType = "Block",
			recipientID = "player",
		},
	}
------------------------------------------------------------------------------------]]
function Parrot_TriggerConditions:RegisterPrimaryTriggerCondition(data)
	self = Parrot_TriggerConditions -- in case someone calls Parrot:RegisterPrimaryTriggerCondition
--	AceLibrary.argCheck(self, data, 2, "table") -- TODO
	local name = data.name
	if type(name) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. name must be a %q, got %q."):format("string", type(name)), 2)
	end
	local localName = data.localName
	if type(localName) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. localName must be a %q, got %q."):format("string", type(localName)), 2)
	end
	local events = data.events
	local parserEvent = data.parserEvent
	if events then
		if type(events) ~= "table" then
			error(("Bad argument #2 to `RegisterCombatEvent'. localName must be a %q, got %q."):format("table", type(events)), 2)
		end
		local getCurrent = data.getCurrent
		if type(getCurrent) ~= "function" and type(getCurrent) ~= "nil" then
			error(("Bad argument #2 to `RegisterCombatEvent'. localName must be a %q or nil, got %q."):format("function", type(check)), 2)
		end
	elseif parserEvent then
		if type(parserEvent) ~= "table" then
			error(("Bad argument #2 to `RegisterCombatEvent'. localName must be a %q, got %q."):format("table", type(parserEvent)), 2)
		end
	end
	if conditions[name] then
		error(("Trigger condition %q already registered"):format(name), 2)
	end
	conditions[name] = data
	primaryChoices[name] = localName
	RefreshEvents()
end
Parrot.RegisterPrimaryTriggerCondition = Parrot_TriggerConditions.RegisterPrimaryTriggerCondition

--[[----------------------------------------------------------------------------------
Arguments:
	table - a data table holding the details of a secondary trigger condition.
Notes:
	The data table is of the following style:
	<pre>{
		name = "Name of the condition in English",
		localName = "Name of the condition in the current locale",
		check = function(param)
			return GetSomeValue() == param
		end,
		defaultParam = 0.5, -- the default value
		param = {
			-- AceOptions argument here.
			-- do not specify get, set, name, or desc.
		}
	}</pre>
Example:
	Parrot:RegisterSecondaryTriggerCondition {
		name = "Minimum power amount",
		localName = L["Minimum power amount"],
		defaultParam = 0.5,
		param = {
			type = 'range',
			min = 0,
			max = 10000,
			step = 1,
			bigStep = 50,
		},
		check = function(param)
			if UnitIsDeadOrGhost("player") then
				return false
			end
			return UnitMana("player")/UnitManaMax("player") >= param
		end,
	}
------------------------------------------------------------------------------------]]
function Parrot_TriggerConditions:RegisterSecondaryTriggerCondition(data)
	self = Parrot_TriggerConditions -- in case someone calls Parrot:RegisterSecondaryTriggerCondition
--	AceLibrary.argCheck(self, data, 2, "table") -- TODO
	local name = data.name
	if type(name) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. name must be a %q, got %q."):format("string", type(name)), 2)
	end
	local localName = data.localName
	if type(localName) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. localName must be a %q, got %q."):format("string", type(localName)), 2)
	end
	secondaryConditions[name] = data
	secondaryChoices[name] = localName
	local notLocalName = data.notLocalName
	if type(notLocalName) == "string" then
		secondaryChoices["~" .. name] = notLocalName
	end
end
Parrot.RegisterSecondaryTriggerCondition = Parrot_TriggerConditions.RegisterSecondaryTriggerCondition

-- #NODOC
function Parrot_TriggerConditions:GetPrimaryConditionChoices()
	return primaryChoices
end

-- #NODOC
function Parrot_TriggerConditions:GetSecondaryConditionChoices()
	return secondaryChoices
end

-- #NODOC
function Parrot_TriggerConditions:GetPrimaryConditionParamDetails(name)
--	AceLibrary.argCheck(self, name, 2, "string") -- TODO
	
	local data = conditions[name]
	if not data then
		return
	end
	return data.param, data.defaultParam
end

-- #NODOC
function Parrot_TriggerConditions:GetSecondaryConditionParamDetails(name)
--	AceLibrary.argCheck(self, name, 2, "string") -- TODO
	
	local data = secondaryConditions[name]
	if not data then
		if name:find("^~") then
			data = secondaryConditions[name:sub(2)]
		end
		if not data then
			return
		end
	end
	return data.param, data.defaultParam
end

-- #NODOC
function Parrot_TriggerConditions:DoesSecondaryTriggerConditionPass(name, arg)
--	AceLibrary.argCheck(self, name, 2, "string") -- TODO
	local notted = false
	if name:find("^~") then
		notted = true
		name = name:sub(2)
	end
	local data = secondaryConditions[name]
	if not data then
		return false
	end
	if not arg and data.param then
		return false
	end
	local value = data.check(arg)
	if notted then
		return not value
	else
		return value
	end
end
