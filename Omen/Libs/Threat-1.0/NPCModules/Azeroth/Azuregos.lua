﻿local MAJOR_VERSION = "Threat-1.0"
local MINOR_VERSION = tonumber(("$Revision: 61753 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then
	_G.ThreatLib_MINOR_VERSION = MINOR_VERSION
end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

local ThreatLib = _G.ThreatLib

local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()

ThreatLib:GetModule("NPCCore"):RegisterModule(BB["Azuregos"], function(Azuregos)
	Azuregos:RegisterTranslation("enUS", function() return {
		["Come, little ones. Face me!"] = "Come, little ones. Face me!",
	} end)

	Azuregos:RegisterTranslation("koKR", function() return {
		["Come, little ones. Face me!"] = "오너라, 조무래기들아! 덤벼봐라!",
	} end)

	Azuregos:RegisterTranslation("zhTW", function() return {
		["Come, little ones. Face me!"] = "來吧，小子。面對我!",
	} end)
	
	Azuregos:RegisterTranslation("zhCN", function() return {
		["Come, little ones. Face me!"] = "来吧，小子。面对我！",
	} end)

	local teleport = Azuregos:GetTranslation("Come, little ones. Face me!")

	Azuregos:UnregisterTranslations()

	function Azuregos:Init()
		self:RegisterCombatant(BB["Azuregos"], true)

		self:RegisterChatEvent("yell", BB["Azuregos"], teleport, self:WipeAllRaidThreat())
	end

	function Azuregos:StartFight()
		self:SetNumberOfMobs(1)
	end
end)

table.insert(ThreatLib.UpvalueFixers, function(lib)
	ThreatLib = lib
end)

end
