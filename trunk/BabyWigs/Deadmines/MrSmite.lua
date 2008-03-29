------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mr. Smite"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local stomp1announced = nil
local stomp2announced = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "MrSmite",
	
	--engage_trigger1 = "You there, check out that noise!",
	--engage_trigger2 = "We're under attack! A vast, ye swabs! Repel the invaders!",
	engage_message = "%s Engaged",
	
	stomp_warning = "Stun Incoming",
	stun_timer = "Stunned",
	
	stomp = "Stomp Warning",
	stomp_desc = "Incoming Stomp Warning",
	
	stun = "Stun Timer",
	stun_desc = "Stun Timer",
} end )


----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "The Deadmines"
mod.zonename = BZ["The Deadmines"]
mod.enabletrigger = boss
mod.toggleoptions = {"stomp","stun","bosskill"}
mod.revision = tonumber(("$Revision: 66126 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")

    self:AddCombatListener("SPELL_CAST_SUCCESS", "Stomp", 6432)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Stomp()
	if self.db.profile.stun then
		self:Message(L["stun_timer"], "Positive")
		self:Bar(L["stun_timer"], 9.75, 6432)
	end
end


function mod:UNIT_HEALTH(msg)
	if UnitName(msg) == boss then
		local health = UnitHealth(msg)
		if health > 57 and health <= 65 and not stomp1announced and self.db.profile.stomp then
			self:Message(L["stomp_warning"], "Urgent", nil, "Alert")
			stomp1announced = true
		elseif health > 27 and health <= 35 and not stomp2announced and self.db.profile.stomp then
			self:Message(L["stomp_warning"], "Urgent", nil, "Alert")
			stomp2announced = true
		elseif health > 80 and (stomp1announced or stomp2announced) then
			stomp1announced = false
			stomp2announced = false
		end
	end
end
