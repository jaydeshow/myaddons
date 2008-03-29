assert(oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAParticipant")
local BS = LibStub("LibBabble-Spell-3.0"):GetLookupTable()

local buffs = {
	[BS["Power Word: Fortitude"]] = { 1, 1},
	[BS["Prayer of Fortitude"]] = {1, 2},
	[BS["Mark of the Wild"]] = {2, 1},
	[BS["Gift of the Wild"]] = {2, 2},
	[BS["Arcane Intellect"]] = {3, 1},
	[BS["Arcane Brilliance"]] = {3, 2},
	-- 4 missing from CTRA as well.
	[BS["Shadow Protection"]] = {5, 1},
	[BS["Prayer of Shadow Protection"]] = {5, 2},
	[BS["Power Word: Shield"]] = {6, 0},
	[BS["Soulstone Resurrection"]] = {7, 0},
	[BS["Divine Spirit"]] = {8, 1},
	[BS["Prayer of Spirit"]] = {8, 2},
	[BS["Thorns"]] = {9, 0},
	[BS["Fear Ward"]] = {10, 0},
	[BS["Blessing of Might"]] = {11, 1},
	[BS["Greater Blessing of Might"]] = {11, 2},
	[BS["Blessing of Wisdom"]] = {12, 1},
	[BS["Greater Blessing of Wisdom"]] = {12, 2},
	[BS["Blessing of Kings"]] = {13, 1},
	[BS["Greater Blessing of Kings"]] = {13, 2},
	[BS["Blessing of Salvation"]] = {14, 1},
	[BS["Greater Blessing of Salvation"]] = {14, 2},
	[BS["Blessing of Light"]] = {15, 1},
	[BS["Greater Blessing of Light"]] = {15, 2},
	[BS["Blessing of Sanctuary"]] = {16, 1},
	[BS["Greater Blessing of Sanctuary"]] = {16, 2},
	[BS["Renew"]] = {17, 0},
	[BS["Rejuvenation"]] = {18, 0},
	[BS["Regrowth"]] = {19, 0},
	[BS["Amplify Magic"]] = {20, 0},
	[BS["Dampen Magic"]] = {21, 0},
}

local spells = {
	[BS["Rebirth"]] = true,
	[BS["Resurrection"]] = true,
	[BS["Redemption"]] = true,
	[BS["Ancestral Spirit"]] = true,
	[BS["Reincarnation"]] = true,
}

local iscasting = nil
local mousedowntarget = nil
local ankhs = nil
local shamanResTime = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Participant"] = true,
	["^Corpse of (.+)$"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["^Corpse of (.+)$"] = "^([^%s]+)의 시체",
} end)

L:RegisterTranslations("zhCN", function() return {
	["^Corpse of (.+)$"] = "^(.+)的尸体",
} end)

L:RegisterTranslations("zhTW", function() return {
	["^Corpse of (.+)$"] = "^(.+)的屍體",
} end)

L:RegisterTranslations("frFR", function() return {
	-- Can be "Cadavre de (nickname)" or "Cadavre d'(nickname)"
	["^Corpse of (.+)$"] = "^Cadavre d[e'] ?(.+)$",
} end)

L:RegisterTranslations("deDE", function() return {
	["^Corpse of (.+)$"] = "^Leiche von (.+)$",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("ParticipantPassive", "AceHook-2.1")

mod.participant = true
mod.name = L["Participant"]

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	-- Buffs gained / Lost / refreshed
	self:RegisterEvent("SpecialEvents_PlayerBuffGained", "SpecialEvents_PlayerBuff")
	self:RegisterEvent("SpecialEvents_PlayerBuffLost")
	self:RegisterEvent("SpecialEvents_PlayerBuffRefreshed", "SpecialEvents_PlayerBuff")
	-- CoolDowns
	local _, c = UnitClass("player")
	if c == "DRUID" or c == "WARLOCK" or c == "PALADIN" then
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	elseif c == "SHAMAN" then
		self:RegisterEvent("PLAYER_ALIVE")
		self:RegisterBucketEvent("BAG_UPDATE", 0.5)
	end
	-- durability
	self:RegisterCheck("DURC", "oRA_DurabilityCheck")
	-- resistance check
	self:RegisterCheck("RSTC", "oRA_ResistanceCheck")
	-- latency check
	self:RegisterCheck("LATC", "oRA_LatencyCheck")
	-- resurrection stuff
	iscasting = nil
	mousedowntarget = nil
	ankhs = GetItemCount(17030)
	shamanResTime = GetTime()
	self:HookAndRegisterResurrection()
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:SpecialEvents_PlayerBuff(buff, index, count, icon, rank, duration, timeleft)
	if buffs[buff] then
		oRA:SendMessage("RN " .. floor((timeleft or 0) + .5) .. " " .. buffs[buff][1] .. " " .. buffs[buff][2])
	end
end

function mod:SpecialEvents_PlayerBuffLost(buff)
	if buffs[buff] then
		-- we send 1 second left on this buff.
		oRA:SendMessage("RN 1 ".. buffs[buff][1] .. " " .. buffs[buff][2])
	end
end

function mod:PLAYER_ALIVE()
	shamanResTime = GetTime()
end

function mod:BAG_UPDATE()
	if (GetTime() - (shamanResTime or 0)) > 1 then
		return
	end

	local newankhs = GetItemCount(17030)
	if newankhs == (ankhs - 1) then
		local cooldown = 60
		for tab = 1, GetNumTalentTabs(), 1 do
			for talent = 1, GetNumTalents(tab), 1 do
				local name, _, _, _, rank = GetTalentInfo(tab, talent)
				if name == BS["Improved Reincarnation"] then
					cooldown = cooldown - (rank*10)
					break
				end
			end
		end	
		oRA:SendMessage("CD 2 " .. cooldown)
	end
	ankhs = newankhs
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spell, rank)
	if spell == BS["Rebirth"] then
		oRA:SendMessage("CD 1 20")
	elseif spell == BS["Soulstone Resurrection"] then
		oRA:SendMessage("CD 3 30")
	elseif spell == BS["Divine Intervention"] then
		oRA:SendMessage("CD 4 60", true) -- only oRA2 clients will receive this cooldown I just numbered on.
	end
	-- call for resurrection check
	self:SpellStopped(unit)
end

function mod:UNIT_SPELLCAST_SENT(unit, spell, rank, target)
	if not target or target == "" then target = mousedowntarget end -- set from worldframeonmousedown
	if unit == "player" and spells[spell] and target then
		iscasting = true
		oRA:SendMessage("RES " .. target)
	end
end

function mod:SpellStopped(unit)
	if unit == "player" and iscasting then
		iscasting = nil
		mousedowntarget = nil
		oRA:SendMessage("RESNO")
	end
end

function mod:oRA_DurabilityCheck(msg, author)
	local cur, max, broken = self:GetDurability()
	oRA:SendMessage(string.format("DUR %s %s %s %s", cur, max, broken, author))
end

function mod:oRA_LatencyCheck(msg, author)
	local _, _, latency = GetNetStats()
	oRA:SendMessage(string.format("LAT %s %s", latency, author))
end

function mod:oRA_ResistanceCheck(msg, author)
	local resiststr = ""
	for i = 2, 6, 1 do
		local res = select(2, UnitResistance("player", i))
		resiststr = resiststr .." " .. res
	end
	oRA:SendMessage(string.format("RST%s %s", resiststr, author))
end

---------------
--   Hooks   --
---------------

function mod:WorldFrameOnMouseDown(...)
	if GameTooltipTextLeft1:IsVisible() then
		local name = select(3, GameTooltipTextLeft1:GetText():find(L["^Corpse of (.+)$"]))
		if name then
			mousedowntarget = name
		end
	end
	self.hooks[WorldFrame]["OnMouseDown"](...)
end

------------------------------
--    Utility Functions     --
------------------------------

function mod:GetDurability()
	local cur, max, broken = 0, 0, 0
	for i=1,18 do
		local imin, imax = GetInventoryItemDurability(i)
		if imin and imax then
			imin, imax = tonumber(imin), tonumber(imax)
			if imin == 0 then broken = broken + 1 end
			cur = cur + imin
			max = max + imax
		end
		
	end
	return cur, max, broken
end

function mod:HookAndRegisterResurrection()
	local c = select(2, UnitClass("player"))
	if c == "DRUID" or c == "PRIEST" or c == "SHAMAN" or c == "PALADIN" then
	
		self:RegisterEvent("UNIT_SPELLCAST_SENT")
		
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "SpellStopped")
		self:RegisterEvent("UNIT_SPELLCAST_FAILED", "SpellStopped")
		self:RegisterEvent("UNIT_SPELLCAST_STOP", "SpellStopped")
		-- this is registered by default for cooldowns. SpellStopped will be called from there.
		-- self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "SpellStopped")

		self:HookScript(WorldFrame, "OnMouseDown", "WorldFrameOnMouseDown")
	end

	self:Hook(StaticPopupDialogs["DEATH"], "OnShow", function()
			self.hooks[StaticPopupDialogs["DEATH"]].OnShow()
			if HasSoulstone() then oRA:SendMessage("CANRES") end end, true)

	self:Hook(StaticPopupDialogs["RESURRECT"], "OnShow", function()
			self.hooks[StaticPopupDialogs["RESURRECT"]].OnShow()
			oRA:SendMessage("RESSED") end, true)

	self:Hook(StaticPopupDialogs["RESURRECT_NO_SICKNESS"], "OnShow", function()
			self.hooks[StaticPopupDialogs["RESURRECT_NO_SICKNESS"]].OnShow()
			oRA:SendMessage("RESSED") end, true)

	self:Hook(StaticPopupDialogs["RESURRECT_NO_TIMER"], "OnShow", function()
			self.hooks[StaticPopupDialogs["RESURRECT_NO_TIMER"]].OnShow()
			oRA:SendMessage("RESSED") end, true)

	-- hrmf we can't hook the OnHide's normally, since they are not there. But
	-- blizzard will fire the OnHide if it finds it.
	-- so some more magic to get this working. And be friendly if someone else created
	-- an OnHide already.

	if not StaticPopupDialogs["RESURRECT"].OnHide then
		StaticPopupDialogs["RESURRECT"].OnHide = function() oRA:SendMessage("NORESSED") end
	else 
		self:Hook(StaticPopupDialogs["RESURRECT"], "OnHide", function()
			self.hooks[StaticPopupDialogs["RESURRECT"]].OnHide()
			oRA:SendMessage("NORESSED") end, true)
	end
	if not StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnHide then
		StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnHide = function() oRA:SendMessage("NORESSED") end
	else
		self:Hook(StaticPopupDialogs["RESURRECT_NO_SICKNESS"], "OnHide", function()
			self.hooks[StaticPopupDialogs["RESURRECT_NO_SICKNESS"]].OnHide()
			oRA:SendMessage("NORESSED") end, true)
	end
	if not StaticPopupDialogs["RESURRECT_NO_TIMER"].OnHide then
		StaticPopupDialogs["RESURRECT_NO_TIMER"].OnHide = function() 
			if not StaticPopup_FindVisible("DEATH") then oRA:SendMessage("NORESSED") end
		end
	else
		self:Hook(StaticPopupDialogs["RESURRECT_NO_TIMER"], "OnHide", function()
			self.hooks[StaticPopupDialogs["RESURRECT_NO_TIMER"]].OnHide()
			if not StaticPopup_FindVisible("DEATH") then oRA:SendMessage("NORESSED") end end, true)
	end
end

