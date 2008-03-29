---- global made local ----
local Capping = Capping
local self = Capping
local L = CappingLocale
local UnitExists, UnitIsEnemy, UnitName, GetTime = UnitExists, UnitIsEnemy, UnitName, GetTime

---- local variables ----
local wsgicon, playerfaction
local af, aftext, aftexthp, acarrier, aclass
local hf, hftext, hftexthp, hcarrier, hclass
local ahealth, hhealth = 0, 0
local elap, throt, found, lastsync = 0, 0, 0, 0

---- local functions ----
-- set alliance carrier data and text
local function SetACarrier(carrier, class)
	acarrier = carrier
	aclass = class
	aftext:SetFormattedText("|cff%s%s|r", self:GetClassColorHex(class), carrier or "")
	if not carrier then
		aftexthp:SetText("")
		ahealth = 0
	end
end
-- set horde carrier data and text
local function SetHCarrier(carrier, class)
	hcarrier = carrier
	hclass = class
	hftext:SetFormattedText("|cff%s%s|r", self:GetClassColorHex(class), carrier or "")
	if not carrier then
		hftexthp:SetText("")
		hhealth = 0
	end
end

-- needed so that AlwaysUpFrame is not forced to be secure
local function SetWSGCarrierPositions()
	af:SetPoint("LEFT", UIParent, "BOTTOMLEFT", AlwaysUpFrame1:GetRight() + 38, AlwaysUpFrame1:GetTop())
	hf:SetPoint("LEFT", UIParent, "BOTTOMLEFT", AlwaysUpFrame2:GetRight() + 38, AlwaysUpFrame2:GetTop())
end

-- props to "Fedos" and the ICU mod
-- updates the button to target by name
-- button will be slightly transparent if button cannot update (in combat)
local function SetWSGCarrierAttribute()
	af:SetAlpha(1)
	hf:SetAlpha(1)
	af:SetAttribute("macrotext", acarrier and format("/target %s", acarrier) or "")
	hf:SetAttribute("macrotext", hcarrier and format("/target %s", hcarrier) or "")

	SetWSGCarrierPositions()
end

-- sends basic carrier info to battleground chat
local function CarrierOnClick(this)
	if IsControlKeyDown() then 
		local faction = this.faction
		local carrier = (faction == "Horde" and hcarrier) or acarrier
		if carrier then
			SendChatMessage(format(L["%s's flag carrier: %s (%s)"], L[faction], carrier, (faction == "Horde" and hclass) or aclass), "BATTLEGROUND")
		end
	end 
end

-- create carriers' frames
local function CreateCarrierFrame(faction)
	local f = CreateFrame("Button", "CappingTarget"..faction, UIParent, "SecureActionButtonTemplate")
	f:SetHeight(18)
	f:SetWidth(124)
	f:RegisterForClicks("LeftButtonUp")
	f:SetAttribute("type1", "macro")
	f:SetAttribute("macrotext", "")
	f.faction = faction
	f:SetScript("PostClick", CarrierOnClick)

	f.text = f:CreateFontString(nil, "BACKGROUND")
	f.text:SetFont(GameFontHighlightSmall:GetFont(), 14)
	f.text:SetJustifyH("LEFT")
	f.text:SetPoint("TOPLEFT", f, "TOPLEFT", 29, 0)
	f.text:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
	f.text:SetShadowColor(0,0,0)
	f.text:SetShadowOffset(1,-1)
	
	f.texthp = f:CreateFontString(nil, "BACKGROUND")
	f.texthp:SetFont(GameFontHighlightSmall:GetFont(), 10)
	f.texthp:SetJustifyH("RIGHT")
	f.texthp:SetPoint("TOPLEFT", f, "TOPLEFT", -4, 0)
	f.texthp:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 28 - f:GetWidth(), 0)
	f.texthp:SetShadowColor(0,0,0)
	f.texthp:SetShadowOffset(1,-1)
	
	self:AddFrameToHide(f)
	return f, f.text, f.texthp
end

-- Carrier's health text formatting
local function UpdateHealth(faction, u, synchp)
	if faction == "Alliance" then
		local ahealth_before = ahealth
		ahealth = synchp or min(floor(100 * UnitHealth(u)/UnitHealthMax(u)), 100)
		aftexthp:SetFormattedText("|cff%s%d%%|r", (ahealth < ahealth_before and "ff2222") or "dddddd", ahealth)
		return ahealth
	else
		local hhealth_before = hhealth
		hhealth = synchp or min(floor(100 * UnitHealth(u)/UnitHealthMax(u)), 100)
		hftexthp:SetFormattedText("|cff%s%d%%|r", (hhealth < hhealth_before and "ff2222") or "dddddd", hhealth)
		return hhealth
	end
end

-- function to get carriers' health
local function ScanRaid(friendcarrier, enemycarrier, enemyfaction, enemytext)
	local efound, ffound
	for i = 1, GetNumRaidMembers(), 1 do
		if UnitExists("raid"..i) then
			-- scan each raid member's target to check for enemy carrier's health
			if enemycarrier and not efound then
				local t = "raid"..i.."target"
				if UnitExists(t) and UnitIsEnemy(t, "player") and UnitName(t) == enemycarrier then
					local hp = UpdateHealth(enemyfaction, t, nil)
					found = 0
					efound = true
					-- sync enemy's health
					if lastsync + 1.5 < GetTime() then
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
		enemytext:SetText("|cff777777??%|r")
	end
end

-- throttle function to refresh roster data and carrier's health
local function OnUpdate(this, a1)
	elap = elap + a1
	throt = throt + a1
	if elap > 10 then
		elap = 0
		RequestBattlefieldScoreData()
	end
	
	-- health check and display
	if (acarrier or hcarrier) and throt > 1 then
		throt = 0
		if playerfaction == "Alliance" then
			ScanRaid(acarrier, hcarrier, "Horde", hftexthp)
		else
			ScanRaid(hcarrier, acarrier, "Alliance", aftexthp)
		end
	end
end

local function CreateWSGFrame()
	af, aftext, aftexthp = CreateCarrierFrame("Alliance")
	hf, hftext, hftexthp = CreateCarrierFrame("Horde")
	
	af:SetScript("OnUpdate", OnUpdate)
	SetWSGCarrierPositions()
end

-- stuff to do at the beginning of every wsg (but wait til after combat)
local function Bulk()
	SetACarrier()
	SetHCarrier()
	af:Show()
	hf:Show()
	SetWSGCarrierAttribute()
	
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_HORDE", "WSGFlagCarrier")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", "WSGFlagCarrier")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")
	self:RegisterTempEvent("CHAT_MSG_ADDON", "WSGSync")
	
	-- makes sure GetBattlefieldScore will return correct values
	-- note: waiting for UPDATE_BATTLEFIELD_SCORE is just too slow (1-3 secs)
	RequestBattlefieldScoreData()
end



---------------------------
function Capping:StartWSG()
---------------------------
	-- init some data and create carrier frames
	if not af then
		playerfaction = UnitFactionGroup("player")
		wsgicon = strlower(playerfaction)
		self:CheckCombat(CreateWSGFrame)
	end
	self:CheckCombat(Bulk)
end

-- carrier detection and setup
-----------------------------------
function Capping:WSGFlagCarrier(a1)
-----------------------------------
	-- flag was picked up
	if strfind(a1, L["was picked up by (.+)!"]) then
		local _,_,name = strfind(a1, L["was picked up by (.+)!"])
		if strfind(a1, L["Horde"]) then 
			faction = 1  -- alliance carrier
		else 
			faction = 0  -- horde carrier
		end
		if faction == 1 then
			SetACarrier(name, self:GetClassByName(name, faction))
			af:SetAlpha(0.5)
		else
			SetHCarrier(name, self:GetClassByName(name, faction))
			hf:SetAlpha(0.5)
		end
		self:CheckCombat(SetWSGCarrierAttribute)
	-- flag was dropped, reset for that carrier
	elseif strfind(a1, L["dropped"]) then
		if strfind(a1, L["Horde"]) then
			SetACarrier()
		else
			SetHCarrier()
		end
		self:CheckCombat(SetWSGCarrierAttribute)
	-- flag was captured, reset all carriers
	elseif strfind(a1, L["captured the"]) then
		SetACarrier()
		SetHCarrier()
		self:CheckCombat(SetWSGCarrierAttribute)
		self:StartBar(L["Flag respawns"], 23, self:GetIconData(wsgicon, "flag"), "info1")
	end
end

-- experimental WSG syncing
-------------------------------------------------------
function Capping:WSGSync(prefix, message, chan, sender)
-------------------------------------------------------
	if prefix == "cap" and chan == "BATTLEGROUND" and sender ~= UnitName("player") then
		-- request or fulfill a request for carriers' names
		if lastsync + 1.5 < GetTime() then
			found = 0
			UpdateHealth((playerfaction == "Alliance" and "Horde") or "Alliance", nil, tonumber(message))
		end
		lastsync = GetTime()
	end
end
