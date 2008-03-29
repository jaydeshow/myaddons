	local MAJOR_VERSION = "Threat-1.0"
local MINOR_VERSION = tonumber(("$Revision: 61753 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then
	_G.ThreatLib_MINOR_VERSION = MINOR_VERSION
end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

local ThreatLib = _G.ThreatLib

local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()

ThreatLib:GetModule("NPCCore"):RegisterModule(BB["Supremus"], function(Supremus)

	Supremus:RegisterTranslation("enUS", function() return {
		["Supremus punches the ground in anger!"] = "Supremus punches the ground in anger!"
	} end)
	Supremus:RegisterTranslation("deDE", function() return {
		["Supremus punches the ground in anger!"] = "Supremus schlägt wütend auf den Boden!",
	} end)
	Supremus:RegisterTranslation("koKR", function() return {
		["Supremus punches the ground in anger!"] = "궁극의 심연이 분노하여 땅을 내리찍습니다!",
	} end)
	Supremus:RegisterTranslation("frFR", function() return {
		["Supremus punches the ground in anger!"] = "De rage, Supremus frappe le sol !"
	} end)
	Supremus:RegisterTranslation("zhTW", function() return {
		["Supremus punches the ground in anger!"] = "瑟普莫斯憤怒的捶擊地面!"
	} end)
	Supremus:RegisterTranslation("zhCN", function() return {
		["Supremus punches the ground in anger!"] = "苏普雷姆斯愤怒地击打着地面！"
	} end)

	local phaseTransition = Supremus:GetTranslation("Supremus punches the ground in anger!")

	Supremus:UnregisterTranslations()

	function Supremus:Init()
		self:RegisterCombatant(BB["Supremus"], true)
	end

	function Supremus:StartFight()
		self:SetNumberOfMobs(1)
	end

	function Supremus:OnEnable()
		ThreatLib:GetModule("NPCCore").modulePrototype.OnEnable(self)
		self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	end

	function Supremus:CHAT_MSG_RAID_BOSS_EMOTE(msg)
		if msg == phaseTransition then
			self:WipeAllRaidThreat()
		end
	end
end)

table.insert(ThreatLib.UpvalueFixers, function(lib)
	ThreatLib = lib
end)

end
