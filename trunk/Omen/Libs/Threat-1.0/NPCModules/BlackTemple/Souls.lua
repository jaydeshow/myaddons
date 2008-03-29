-- Author: brotherhobbes@gmail.com

local MAJOR_VERSION = "Threat-1.0"
local MINOR_VERSION = tonumber(("$Revision: 64724 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then
	_G.ThreatLib_MINOR_VERSION = MINOR_VERSION
end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

local ThreatLib = _G.ThreatLib

local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()

ThreatLib:GetModule("NPCCore"):RegisterModule(BB["Essence of Anger"], BB["Essence of Desire"], BB["Essence of Suffering"], function(Souls)

	Souls:RegisterTranslation("enUS", function() return {
		["Pain and suffering are all that await you!"] = "Pain and suffering are all that await you!",
		["You can have anything you desire... for a price."] = "You can have anything you desire... for a price.",
		["Beware. I live!"] = "Beware. I live!",
	} end)

	Souls:RegisterTranslation("koKR", function() return {
		["Pain and suffering are all that await you!"] = "너희를 기다리는 건 고통과 슬픔뿐이야!",
		["You can have anything you desire... for a price."] = "선택은 자유지만... 대가는 치러야 하는 법.",
		["Beware. I live!"] = "각오해라. 내가 살아났다!",
	} end)

	Souls:RegisterTranslation("frFR", function() return {
		["Pain and suffering are all that await you!"] = "Douleur et souffrance, voilà tout ce qui vous attend !",
		["You can have anything you desire... for a price."] = "Vous pouvez avoir tout ce que vous désirez... en y mettant le prix.",
		["Beware. I live!"] = "Prenez garde : je suis vivant !",
	} end)

	Souls:RegisterTranslation("deDE", function() return {
		["Pain and suffering are all that await you!"] = "Auf Euch warten nur Schmerz und Leid!",
		["You can have anything you desire... for a price."] = "Ihr könnt alles haben, was Ihr wollt... doch es hat einen Preis.",
		["Beware. I live!"] = "Seid auf der Hut, ich lebe!",
	} end)

	Souls:RegisterTranslation("zhCN", function() return {
		["Pain and suffering are all that await you!"] = "等待你们的只有痛苦与折磨！",
		["You can have anything you desire... for a price."] = "你可以获得任何你想要的东西……只要付得起代价。",
		["Beware. I live!"] = "当心吧，我复活了！", 
	} end)

	Souls:RegisterTranslation("zhTW", function() return {
		["Pain and suffering are all that await you!"] = "等待你們的只有痛苦與折磨﹗",
		["You can have anything you desire... for a price."] = "你可以得到任何你想要的東西……只要付得起代價。",
		["Beware. I live!"] = "當心吧，我復活了﹗",
	} end)

	local sufferingPhase = Souls:GetTranslation("Pain and suffering are all that await you!")
	local desirePhase = Souls:GetTranslation("You can have anything you desire... for a price.")
	local angerPhase = Souls:GetTranslation("Beware. I live!")

	Souls:UnregisterTranslations()

	function Souls:Init()
		self:RegisterCombatant(BB["Essence of Anger"], true)
		self:RegisterCombatant(BB["Essence of Desire"], true)
		self:RegisterCombatant(BB["Essence of Suffering"], true)

		self:RegisterChatEvent("yell", BB["Essence of Anger"], sufferingPhase, self.phaseTransition)
		self:RegisterChatEvent("yell", BB["Essence of Desire"], desirePhase, self.phaseTransition)
		self:RegisterChatEvent("yell", BB["Essence of Suffering"], angerPhase, self.phaseTransition)
	end

	function Souls:StartFight()
		self:SetNumberOfMobs(1)
	end

	function Souls:phaseTransition()
		self:WipeAllRaidThreat()
	end
end)

table.insert(ThreatLib.UpvalueFixers, function(lib)
	ThreatLib = lib
end)

end