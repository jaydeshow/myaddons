﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Rokmar the Crackler"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil
local enrageannounced = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Rokmar",

	enrage = "Enrage (Heroic)",
	enrage_desc = "Warn befor Rokmar enrages",
	enrage_message = "Enraged Soon!",
} end )

L:RegisterTranslations("frFR", function() return {
	enrage = "Enrager (Héroïque)",
	enrage_desc = "Préviens quand Rokmar est sûr le point de devenir enragé.",
	enrage_message = "Bientôt enragé !",
} end )

L:RegisterTranslations("koKR", function() return {
	enrage = "격노 (영웅)",
	enrage_desc = "로크마르 격노에 대해 알립니다.",
	enrage_message = "잠시후 격노!",
} end )

L:RegisterTranslations("zhCN", function() return {
	enrage = "激怒（英雄）",
	enrage_desc = "当激怒时发出警报。",
	enrage_message = "巨钳鲁克玛尔 激怒！",
} end )

L:RegisterTranslations("zhTW", function() return {
       enrage = "狂怒（英雄）",
       enrage_desc = "當爆裂者洛克瑪狂怒時發出警報",
       enrage_message = "爆裂者洛克瑪 狂怒!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Slave Pens"]
mod.enabletrigger = boss
mod.toggleoptions = {"enrage", "bosskill"}
mod.revision = tonumber(("$Revision: 71633 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	enrageannounced = nil
	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_HEALTH(arg1)
	if not db.enrage or GetInstanceDifficulty() ~= 2 then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	if UnitName(arg1) == boss then
		local health = UnitHealth(arg1)
		if health > 18 and health <= 24 and not enrageannounced then
			enrageannounced = true
			self:Message(L["enrage_message"], "Important")
		elseif health > 28 and enrageannounced then
			enrageannounced = nil
		end
	end
end
