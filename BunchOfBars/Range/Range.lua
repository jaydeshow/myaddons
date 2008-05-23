

local moduleName = "RangeCheck"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Range Check",

	["Check frequency"] = true,
	["Frequency in seconds."] = true
} end)

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "거리 체크",

	["Check frequency"] = "빈도 체크",
	["Frequency in seconds."] = "초당 빈도수"
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local InRange


local IsSpellInRange = IsSpellInRange
local CheckInteractDistance = CheckInteractDistance



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 55604 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		frequency = {
			type = "range",
			name = L["Check frequency"],
			desc = L["Frequency in seconds."],
			min  = 0.1,
            max  = 5.0,
            step = 0.1,
            get  = "GetSetFrequency",
            set  = "GetSetFrequency",
		}
	}
}

plugin.defaultDB = {
	frequency = 0.5
}



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnInitialize()
	local BS    = AceLibrary("Babble-Spell-2.2")
	local class = select(2, UnitClass("player"))

	-- 40 yard range check
	if class == "PRIEST" then
		InRange = function(unit) return IsSpellInRange(BS["Lesser Heal"], unit) == 1 end 
	elseif class == "DRUID" then
		InRange = function(unit) return IsSpellInRange(BS["Healing Touch"], unit) == 1 end
	elseif class == "PALADIN" then
		InRange = function(unit) return IsSpellInRange(BS["Holy Light"], unit) == 1 end
	elseif class == "SHAMAN" then
		InRange = function(unit) return IsSpellInRange(BS["Healing Wave"], unit) == 1 end
	elseif class == "HUNTER" and UnitLevel("player") == 70 then
		InRange = function(unit) return IsSpellInRange(BS["Misdirection"], unit) == 1 end -- 100 yards
	else
		InRange = function(unit) return CheckInteractDistance(unit, 1) end -- ~28 yards
	end
end


function plugin:OnEnable()
	self:ScheduleRepeatingEvent("BunchOfBars_RangeUpdate", self.UpdateAll, self.db.profile.frequency, self)
end


function plugin:OnUpdate(frame)
	if InRange(frame.unit) then -- this will also hide dead and offline players
		frame:SetAlpha(1.0)
	elseif frame:GetAlpha() == 1.0 then
		frame:SetAlpha(0.3)
	end
end



----------------------------------
--      Option Handlers         --
----------------------------------

function plugin:GetSetFrequency(value)
	if type(value) == "nil" then return self.db.profile.frequency end

	-- this check is to assure we don't reschedule the event to often
	if self.db.profile.frequency ~= value then
		self.db.profile.frequency = value
		
		self:OnEnable()
	end
end
