------------------------------
--      Are you local?      --
------------------------------

local name = BZ["The Deadmines"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)

local boss = BB["Rhahk'Zor"]
local boss1 = BB["Sneed"]
local boss2 = BB["Gilnid"]
local boss3 = BB["Edwin VanCleef"]

L:RegisterTranslations("enUS", function() return {
	cmd = "Deadmines",

	pat = "Patrol Spawns",
	pat_desc = "Announce patrol spawns after boss kills.",
	pat_warning = "Patrol Spawned, Look Behind You.",
	
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(name)
mod.partyContent = true
mod.otherMenu = "The Deadmines"
mod.synctoken = "The Deadmines"
mod.zonename = BZ["The Deadmines"]
mod.enabletrigger = {boss,boss1,boss2}
mod.toggleoptions = {"pat"}
mod.revision = tonumber(("$Revision: 65992 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "UNIT_DIED")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_DIED(mob)
	if not mob then return end
	if mob == boss3 then
		BigWigs:ToggleModuleActive(self, false)
	end
	if mob ~= boss and mob ~= boss1 and mob ~= boss2 then return end
	if self.db.profile.pat then
		self:Message(L["pat_warning"], "Attention")
	end	
end
