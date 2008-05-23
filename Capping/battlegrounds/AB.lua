local Capping = Capping
local self = Capping
local L = CappingLocale

local nodes = {  -- node name = icon key
	[ L["Lumber Mill"] ] 	= "lumbermill",
	[ L["Blacksmith"] ]		= "blacksmith",
	[ L["Gold Mine"] ] 		= "mine",
	[ L["Mine"] ] 			= "mine",
	[ L["Stables"] ] 		= "stables",
	[ L["Southern Farm"] ] 	= "farm", 
	[ L["Farm"] ] 			= "farm", 
}

local ABReplaceText = ( GetLocale() == "zhTW" and { [ L["Mine"] ] = L["Gold Mine"], [ L["Southern Farm"] ] = L["Farm"], } )
	or {}

local function ABAssault(a1, faction)
	local text = strlower(a1)
	for value,icon in pairs(nodes) do
		if strfind(text, strlower(value)) then
			if strfind(text, L["has assaulted"]) or strfind(text, L["claims the"]) then
				self:StartBar(ABReplaceText[value] or value, 63.5, 63.5, self:GetIconData(faction, icon), faction)
				return
			elseif strfind(text, L["has defended the"]) or strfind(text, L["has taken the"]) then
				self:StopBar(ABReplaceText[value] or value)
				return
			end
		end
	end
end

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
	ABAssault(a1, "horde")
end
-----------------------------
function Capping:AAssault(a1)
-----------------------------
	ABAssault(a1, "alliance")
end

	
