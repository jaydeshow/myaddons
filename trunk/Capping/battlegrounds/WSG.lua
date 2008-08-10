local Capping = Capping
local self = Capping
local L = CappingLocale

local wsgicon, playerfaction
local af, aftext, aftexthp, acarrier, aclass
local hf, hftext, hftexthp, hcarrier, hclass
local ahealth, hhealth = 0, 0
local elap1, elap2, found, lastsync = 0, 0, 0, 0
local unknownhp = "|cff777777??%|r"

local UnitExists, UnitIsEnemy, UnitName, GetTime = UnitExists, UnitIsEnemy, UnitName, GetTime

local function SetCarrier(faction, carrier, class)  -- setup carrier frames
	if faction == 0 then
		hcarrier, hclass, hf.car = carrier, class, carrier
		hftext:SetFormattedText("|cff%s%s|r", self:GetClassColorHex(class), carrier or "")
		hhealth = 0
		hftexthp:SetText((carrier and unknownhp) or "")
		hf:SetAlpha(0.6)
	else
		acarrier, aclass, af.car = carrier, class, carrier
		aftext:SetFormattedText("|cff%s%s|r", self:GetClassColorHex(class), carrier or "")
		ahealth = 0
		aftexthp:SetText((carrier and unknownhp) or "")
		af:SetAlpha(0.6)
	end
end
local function UpdateHealth(faction, u, synchp)  -- Carrier's health text formatting
	if faction == "Alliance" then
		if not acarrier then return end
		local ahealth_before = ahealth
		ahealth = synchp or min(floor(100 * UnitHealth(u)/UnitHealthMax(u)), 100)
		aftexthp:SetFormattedText("|cff%s%d%%|r", (ahealth < ahealth_before and "ff2222") or "dddddd", ahealth)
		return ahealth
	else
		if not hcarrier then return end
		local hhealth_before = hhealth
		hhealth = synchp or min(floor(100 * UnitHealth(u)/UnitHealthMax(u)), 100)
		hftexthp:SetFormattedText("|cff%s%d%%|r", (hhealth < hhealth_before and "ff2222") or "dddddd", hhealth)
		return hhealth
	end
end
local function ScanRaid(friendcarrier, enemycarrier, enemyfaction, enemytext)  -- function to get carriers' health
	local efound, ffound
	for i = 1, GetNumRaidMembers(), 1 do
		if UnitExists("raid"..i) then
			-- scan each raid member's target to check for enemy carrier's health
			if enemycarrier and not efound then
				local t = "raid"..i.."target"
				if UnitExists(t) and UnitIsEnemy(t, "player") and UnitName(t) == enemycarrier then
					local hp = UpdateHealth(enemyfaction, t, nil)
					found, efound = 0, true
					if lastsync + 1.5 < GetTime() then-- sync enemy's health
						SendAddonMessage("cap", hp, "BATTLEGROUND")
						lastsync = GetTime()
					end
				end
			end
			-- scan own raid to get own carrier's health
			if friendcarrier and not ffound and UnitName("raid"..i) == friendcarrier then
				UpdateHealth(playerfaction, "raid"..i, nil)
				ffound = true
			end
		end
	end

	-- enemy's carrier health is ?? after 6 seconds of being unknown
	found = found + 1
	if enemycarrier and found > 6 then
		enemytext:SetText(unknownhp)
	end
end
-- props to "Fedos" and the ICU mod
-- updates a carrier's frame secure stuff, button will be slightly transparent if button cannot update (in combat)
local function SetWSGCarrierAttribute()
	af:SetAlpha(1)
	af:SetAttribute("macrotext", format("/target %s", acarrier or ""))
	af:SetPoint("LEFT", UIParent, "BOTTOMLEFT", AlwaysUpFrame1:GetRight() + 38, AlwaysUpFrame1:GetTop())
	hf:SetAlpha(1)
	hf:SetAttribute("macrotext", format("/target %s", hcarrier or ""))
	hf:SetPoint("LEFT", UIParent, "BOTTOMLEFT", AlwaysUpFrame2:GetRight() + 38, AlwaysUpFrame2:GetTop())
end
local function CarrierOnClick(this)  -- sends basic carrier info to battleground chat
	if IsControlKeyDown() then
		local carrier, class = acarrier, aclass
		if this.faction == "Horde" then
			carrier, class = hcarrier, hclass
		end
		if carrier then
			SendChatMessage(format(L["%s's flag carrier: %s (%s)"], L[this.faction], carrier, class), "BATTLEGROUND")
		end
	end
end
local function CreateCarrierFrame(faction)  -- create carriers' frames
	local b = self:CreateCarrierButton("CappingTarget"..faction, 132, 18, CarrierOnClick)
	local text = self:CreateText(b, 14, "LEFT", b, 29, 0, b, 0, 0)
	local texthp = self:CreateText(b, 10, "RIGHT", b, -4, 0, b, 28 - b:GetWidth(), 0)
	b.faction = faction
	b.text = text
	self:AddFrameToHide(b)
	return b, text, texthp
end
local function CreateWSGFrame()  -- create all frames
	af, aftext, aftexthp = CreateCarrierFrame("Alliance")
	hf, hftext, hftexthp = CreateCarrierFrame("Horde")

	af:SetScript("OnUpdate", function(this, a1)
		elap1 = elap1 + a1
		elap2 = elap2 + a1
		if elap1 > 10 then  -- updates scoreboard data
			elap1 = 0
			RequestBattlefieldScoreData()
		end
		if (acarrier or hcarrier) and elap2 > 1 then  -- health check and display
			elap2 = 0
			if playerfaction == "Alliance" then
				ScanRaid(acarrier, hcarrier, "Horde", hftexthp)
			else
				ScanRaid(hcarrier, acarrier, "Alliance", aftexthp)
			end
		end
	end)
end
local function Bulk()  -- stuff to do at the beginning of every wsg, but after combat
	SetCarrier(0)
	SetCarrier(1)
	af:Show()
	hf:Show()
	SetWSGCarrierAttribute()

	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_HORDE", "WSGFlagCarrier")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", "WSGFlagCarrier")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")
	self:RegisterTempEvent("CHAT_MSG_ADDON", "WSGSync")

	-- makes sure GetBattlefieldScore will return correct values since UPDATE_BATTLEFIELD_SCORE is too slow
	RequestBattlefieldScoreData()
end

---------------------------
function Capping:StartWSG()
---------------------------
	if not af then  -- init some data and create carrier frames
		playerfaction = UnitFactionGroup("player")
		wsgicon = strlower(playerfaction)
		self:CheckCombat(CreateWSGFrame)
	end
	self:CheckCombat(Bulk)
end

-----------------------------------
function Capping:WSGFlagCarrier(a1)  -- carrier detection and setup
-----------------------------------
	if strmatch(a1, L["was picked up by (.+)!"]) then  -- flag was picked up
		local name = strmatch(a1, L["was picked up by (.+)!"])
		local faction = strfind(a1, L["Horde"]) and 1 or 0
		SetCarrier(faction, name, self:GetClassByName(name, faction))
		self:CheckCombat(SetWSGCarrierAttribute)
	elseif strmatch(a1, L["was picked up by (.+)!2"]) then  -- flag was picked up - another version
		local name = strmatch(a1, L["was picked up by (.+)!2"])
		local faction = strfind(a1, L["Horde"]) and 1 or 0
		SetCarrier(faction, name, self:GetClassByName(name, faction))
		self:CheckCombat(SetWSGCarrierAttribute)
	elseif strfind(a1, L["dropped"]) then  -- flag was dropped, reset for that carrier
		SetCarrier((strfind(a1, L["Horde"]) and 1) or 0)
		self:CheckCombat(SetWSGCarrierAttribute)
	elseif strfind(a1, L["captured the"]) then  -- flag was captured, reset all carriers
		SetCarrier(0)
		SetCarrier(1)
		self:CheckCombat(SetWSGCarrierAttribute)
		self:StartBar(L["Flag respawns"], 23, 23, self:GetIconData(wsgicon, "flag"), "info2")
	end
end

-------------------------------------------------------
function Capping:WSGSync(prefix, message, chan, sender)  -- experimental WSG syncing
-------------------------------------------------------
	if prefix == "cap" and chan == "BATTLEGROUND" and sender ~= UnitName("player") then
		if lastsync + 1.5 < GetTime() then
			found = 0
			UpdateHealth((playerfaction == "Alliance" and "Horde") or "Alliance", nil, tonumber(message))
		end
		lastsync = GetTime()
	end
end
