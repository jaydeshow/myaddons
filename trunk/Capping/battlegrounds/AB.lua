local Capping = Capping
local self = Capping
local L = CappingLocale

local nodes = {
	[ L["Lumber Mill"] ] 	= "lumbermill",
	[ L["Blacksmith"] ]		= "blacksmith",
	[ L["Gold Mine"] ] 		= "mine",
	[ L["Mine"] ] 			= "mine",
	[ L["Stables"] ] 		= "stables",
	[ L["Southern Farm"] ] 	= "farm", 
	[ L["Farm"] ] 			= "farm", 
}

local BGPatternReplacements = (GetLocale() == "zhTW") and {
	[ L["Mine"] ] = L["Gold Mine"],
	[ L["Southern Farm"] ] = L["Farm"],
} or {}

--------------------------
function Capping:StartAB()
--------------------------
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_HORDE", "HAssault")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", "AAssault")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")
	
	self:NewEstimator(1)
	self:RegisterTempEvent("UPDATE_WORLD_STATES")
end

-----------------------------
function Capping:HAssault(a1)
-----------------------------
	self:ABAssault(a1, "horde")
end

-----------------------------
function Capping:AAssault(a1)
-----------------------------
	self:ABAssault(a1, "alliance")
end

---------------------------------------
function Capping:ABAssault(a1, faction)
---------------------------------------
	local text = strlower(a1)
	for value,icon in pairs(nodes) do
		if strfind(text, strlower(value)) then
			if strfind(text, L["has assaulted"]) or strfind(text, L["claims the"]) then
				self:StopBar(BGPatternReplacements[value] or value)
				self:StartBar(BGPatternReplacements[value] or value, 63.5, self:GetIconData(faction, icon), faction)
				return
			elseif strfind(text, L["has defended the"]) or strfind(text, L["has taken the"]) then
				self:StopBar(BGPatternReplacements[value] or value)
				return
			end
		end
	end
end			
