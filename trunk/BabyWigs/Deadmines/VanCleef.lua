------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Edwin VanCleef"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local addsannounced = false;

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "VanCleef",
	
	engage_trigger = "None may challenge the Brotherhood!",
	engage_message = "%s Engaged",
	
	adds = "Adds",
	adds_desc = "Adds",
	adds_trigger = "%s calls more of his allies out of the shadows.",
	adds_message = "Adds Spawned",
	adds_soon_message = "Adds Spawning Soon",
} end )


----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "The Deadmines"
mod.zonename = BZ["The Deadmines"]
mod.enabletrigger = boss
mod.toggleoptions = {"adds","bosskill"}
mod.revision = tonumber(("$Revision: 65992 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")

	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if self.db.profile.adds and msg == L["adds_trigger"] then
		self:Message(L["adds_message"], "Urgent", nil, "Alert")
	elseif msg == L["engage_trigger"] then
		self:Message(L["engage_message"]:format(boss), "Positive")
	end
end

function mod:UNIT_HEALTH(msg)
	if UnitName(msg) == boss then
		local health = UnitHealth(msg)
		if health > 47 and health <= 60 and not addsannounced and self.db.profile.adds then
			self:Message(L["adds_soon_message"], "Attention", nil, "Alert")
			addsannounced = true
		elseif health > 80 and addsannounced then
			addsannounced = false
		end
	end
end
