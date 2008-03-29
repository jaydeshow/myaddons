------------------------------
--      Are you local?      --
------------------------------

local withcore = {}
local asleader = {}

------------------------------
--    Addon Declaration     --
------------------------------

oRALoD = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")

------------------------------
--      Initialization      --
------------------------------

function oRALoD:OnInitialize()
	local numAddons = GetNumAddOns()
	for i = 1, numAddons do
		if not IsAddOnLoaded(i) and IsAddOnLoadOnDemand(i) then
			local meta = GetAddOnMetadata(i, "X-oRA-LoadAsLeader")
			if meta then
				table.insert(asleader, i)
			end
			meta = GetAddOnMetadata(i, "X-oRA-LoadWithCore")
			if meta then
				-- register this addon for loading with core
				table.insert(withcore, i)
			end
		end
	end
end

function oRALoD:OnEnable()
	self:RegisterEvent("oRA_CoreEnabled")
	self:RegisterEvent("oRA_PlayerPromoted")
	self:RegisterEvent("RAID_ROSTER_UPDATE")

	self:ScheduleRepeatingEvent("oRALoDCheckPromote", self.CheckPromoted, 5, self)
	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() then
		self:CheckPromoted()
	else
		self:RegisterEvent("AceEvent_FullyInitialized", "CheckPromoted")
	end
end

------------------------------
--     Event Handlers       --
------------------------------

function oRALoD:oRA_CoreEnabled()
	if not withcore then return end

	local loaded = false
	for k,v in ipairs(withcore) do
		if not IsAddOnLoaded(v) then
			loaded = true
			LoadAddOn(v)
		end
	end	

	withcore = nil

	if loaded then
		self:TriggerEvent("oRA_ModulePackLoaded")
		-- Just collect garbage right away, since we will discard lots of unused
		-- translations.
		collectgarbage("collect")
	end
end

do
	local inRaid = false
	function oRALoD:RAID_ROSTER_UPDATE()
		local isInRaidNow = UnitInRaid("player")
		if not inRaid and isInRaidNow then
			oRA:ToggleActive(true)
			inRaid = true
		elseif inRaid and not isInRaidNow then
			oRA:ToggleActive(false)
			inRaid = false
		end
	end
end

function oRALoD:oRA_PlayerPromoted()
	if not asleader then return end
	local loaded = false
	for k,v in ipairs(asleader) do
		if not IsAddOnLoaded(v) then
			loaded = true
			LoadAddOn(v)
		end
	end	

	asleader = nil

	if loaded then
		self:TriggerEvent("oRA_ModulePackLoaded")
		self:TriggerEvent("oRA_JoinedRaid")
		-- Just collect garbage right away, since we will discard lots of unused
		-- translations.
		collectgarbage("collect")
	end
end

function oRALoD:CheckPromoted()
	if (IsRaidLeader() or IsRaidOfficer()) and GetNumRaidMembers() > 0 then
		if self:IsEventScheduled("oRALoDCheckPromote") then self:CancelScheduledEvent("oRALoDCheckPromote") end
		self:TriggerEvent("oRA_PlayerPromoted")
	end
end

