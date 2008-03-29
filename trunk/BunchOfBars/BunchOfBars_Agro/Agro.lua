

local moduleName = "Agro"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Agro Monitor",

	["Check frequency"] = true,
	["Frequency in seconds."] = true,

	["Sound Warning"] = true,
	["Play a sound when you get agro."] = true,
} end)

--------------------
--   汉化：iCat   --
--------------------
L:RegisterTranslations("zhCN", function() return {
	[moduleName] = "仇恨监视器",

	["Check frequency"] = "更新频率",
	["Frequency in seconds."] = "单位:秒",

	["Sound Warning"] = "音效提示",
	["Play a sound when you get agro."] = "OT后播放音效",
}end)
--#end

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "어그로 알림이",

	["Check frequency"] = "빈도 체크",
	["Frequency in seconds."] = "초당 빈도수",

	["Sound Warning"] = "소리 경고",
	["Play a sound when you get agro."] = "어그로 획득시 소리로 알립니다.",
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local lookup = { } -- table for name to unit id lookups
local myunit

local sound = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav"
-- "Sound\\Spells\\PVPFlagTakenHorde.wav"


-- localize these functions to speed up the main loop a bit
local UnitExists = UnitExists
local UnitIsEnemy = UnitIsEnemy
local UnitIsUnit = UnitIsUnit



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 52507 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		frequency = {
			type = "range",
			name = L["Check frequency"],
			desc = L["Frequency in seconds."],
			min = 0.1,
            max = 2.0,
            step = 0.05,
            get = "GetSetFrequency",
            set = "GetSetFrequency",
		},
		sound = {
			type = "toggle",
			name = L["Sound Warning"],
			desc = L["Play a sound when you get agro."],
            get  = "GetSetSound",
            set  = "GetSetSound"
		}
	}
}

plugin.defaultDB = {
	frequency = 0.25,
	sound     = true
}


plugin.agro = {} -- can't be local since other modules need access



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	self:ScheduleRepeatingEvent("BunchOfBars_AgroUpdate", self.Update, self.db.profile.frequency, self)
end


function plugin:OnUpdate(frame)
	lookup[UnitName(frame.unit)] = frame.unit

	if UnitIsUnit(frame.unit, "player") then
		myunit = frame.unit
	end
end


function plugin:Update()
	for unit in pairs(self.core.frames) do
		if UnitExists(unit.."target") and UnitCanAttack(unit.."target", "player") and UnitExists(unit.."targettarget") then

			-- did I just get agro?
			if self.db.profile.sound and not self.agro[myunit] and UnitIsUnit(unit.."targettarget", "player") then
				PlaySoundFile(sound)
			end

			local tunit = lookup[UnitName(unit.."targettarget")]
			if tunit then -- check if the person is in out party/raid
				self.agro[tunit] = self.db.profile.frequency + 1.5
			end
		end
	end

	for unit in pairs(self.agro) do
		self.agro[unit] = self.agro[unit] - self.db.profile.frequency

		if self.agro[unit] < 0 then
			self.agro[unit] = nil
		end

		self:TriggerEvent("BunchOfBars_Agro", unit)
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


function plugin:GetSetSound(v)
	if type(v) == "nil" then return self.db.profile.sound end

	self.db.profile.sound = v

	if v then PlaySoundFile(sound) end
end
