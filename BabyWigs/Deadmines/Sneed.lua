------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Sneed's Shredder"]
local boss1 = BB["Sneed"];
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss1)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")
local stomp1announced = nil
local stomp2announced = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Sneed",
	
	engage_message = "%s Engaged",
	
	stomp_warning = "Stomp Incoming",
	stun_timer = "Stunned",
	
	terrify = "Terrify",
	terrify_desc = "Terrify",
	terrify_message = "%s is terrified",
	
	eject = "Eject",
	eject_desc = "Sneed Ejected",
	eject_message = "%s defeated, %s ejected",
	
	stun = "Stun Timer",
	stun_desc = "Stun Timer",
	
	defeat = "%s has been defeated",
} end )


----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss1)
mod.partyContent = true
mod.otherMenu = "The Deadmines"
mod.zonename = BZ["The Deadmines"]
mod.enabletrigger = boss
mod.toggleoptions = {"terrify","eject","bosskill"}
mod.revision = tonumber(("$Revision: 66126 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "UNIT_DIED")
	
	self:AddCombatListener("SPELL_AURA_APPLIED", "Terrify", 7399)
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_DIED(mob)
	if not mob then return end
	if mob == boss and self.db.profile.eject then
		self:Message(L["eject_message"]:format(boss,boss1), "Attention")
	elseif mob == boss1 and self.db.profile.bosskill then
		self:Message(L["defeat"]:format(boss1), "Bosskill", nil, "Victory")
		BigWigs:ToggleModuleActive(self, false)
	end
end

function mod:Terrify(player)
	if player and self.db.profile.terrify then
		self:Message(fmt(L["terrify_message"], player), "Attention")
	end
end
