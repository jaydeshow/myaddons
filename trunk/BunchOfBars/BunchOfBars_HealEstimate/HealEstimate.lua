
-- This code is based on PitBull EstimatedHeals so credits go to Nymbia


local moduleName = "zHealEstimate" -- The 'z' is a dirty hax to make sure this addon's frames are craeted after HealthBar



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Heal Estimate",
	["Using simple heal estimate calculations. For more accurate please install DrDamage."] = true
} end)

--------------------
--   汉化：iCat   --
--------------------
L:RegisterTranslations("zhCN", function() return {
	[moduleName] = "治疗预估",
	["Using simple heal estimate calculations. For more accurate please install DrDamage."] = "使用简单的预估治疗计算，想要获得更准确的数值，请安装DrDamage"
}end)
--#end

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "치유 평가"
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local BS = AceLibrary("Babble-Spell-2.2")

local watch = {
	["PRIEST"] = {
		[BS["Heal"]]              = true,
		[BS["Lesser Heal"]]       = true,
		[BS["Greater Heal"]]      = true,
		[BS["Circle of Healing"]] = true,
		[BS["Flash Heal"]]        = true,
		[BS["Binding Heal"]]      = true
	},
	["DRUID"] = {
		[BS["Healing Touch"]] = true,
		[BS["Regrowth"]]      = true
	},
	["SHAMAN"] = {
		[BS["Lesser Healing Wave"]] = true,
		[BS["Healing Wave"]]        = true,
		[BS["Chain Heal"]]          = true
	},
	["PALADIN"] = {
		[BS["Holy Light"]]     = true,
		[BS["Flash of Light"]] = true
	}
}
BS = nil

do
	local class = select(2, UnitClass("player"))
	if not watch[class] then return end
	watch = watch[class] -- let's hope the rest of the watch table is garbage collected after this
end


local plugin


spellamount = setmetatable({}, {
	__index = function(self, key)
		self[key] = setmetatable({}, {
			__index = function(t, k)
				local avg = nil

				if DrDamage then
					-- Use the average heal amount non-crit
					avg = select(5, DrDamage:RawNumbers(DrDamage:GetSpellInfo(key, k), key))
				else
					if plugin.spells[key] and plugin.spells[key][k]then
						local f = (plugin.spells[key][k][3] + 11) / UnitLevel("player")
						avg = (plugin.spells[key][k][1] + plugin.spells[key][k][2]) / 2
						avg = avg + GetSpellBonusHealing() * plugin.spells[key][0] * f
					end
				end				

				t[k] = avg
				return avg
			end
		})
		return self[key]
	end
})


local target = nil
local amount = 0



----------------------------------
--      Module Declaration      --
----------------------------------


plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 52894 $"):match("%d+"))

BunchOfBars_HealEstimate = plugin



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SENT")
	self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_STOP")

	if DrDamage then
		self:RegisterEvent("DrDamage_Update")
	else
		self.core:Print(L["Using simple heal estimate calculations. For more accurate please install DrDamage."])
		self:ScheduleRepeatingEvent("BunchOfBars_SpellUpdate", self.DrDamage_Update, 30, self)
	end

	self:RegisterBucketEvent({"UNIT_HEALTH", "UNIT_MAXHEALTH"}, 0.25, "UpdateUnits")
end


function plugin:OnCreate(frame)
	local bar = CreateFrame("StatusBar", nil, frame)
	bar:SetStatusBarTexture("Interface/Tooltips/UI-Tooltip-Background")
	bar:SetStatusBarColor(0, 1, 0, 0.4)
	bar:SetWidth(200)
	bar:SetHeight(18)
	bar:ClearAllPoints()
	bar:SetPoint("BOTTOMLEFT", frame.parts["HealthBar"], "BOTTOMLEFT", 0, 0)
	bar:Hide()

	local level = frame.parts["HealthBar"]:GetFrameLevel()
	frame.parts["HealthBar"]:SetFrameLevel(level+1)
	bar:SetFrameLevel(level)

	return bar
end


function plugin:OnUpdate(frame, bar)
	if target and UnitName(frame.unit) == target then
		local m = UnitHealthMax(frame.unit)
		local c = UnitHealth(frame.unit)

		bar:SetMinMaxValues(0, m*2)

		if self.core:GetModule("HealthBar").db.profile.deficit then
			bar:SetValue(amount)
		else
			bar:SetValue(c + amount)
		end

		bar:Show()
	else
		bar:Hide()
	end
end


function plugin:UNIT_SPELLCAST_SENT(casterid, spellname, spellrank, targetname)
	if casterid ~= "player" then return end

	if watch[spellname] then
		spellrank = tonumber(spellrank:match("(%d+)$"))
		
		amount = spellamount[spellname][spellrank]

		if amount then
			target = targetname
			self:UpdateAll()
		end
	end
end

function plugin:UNIT_SPELLCAST_STOP(casterid)
	if casterid ~= "player" then return end

	target = nil
	self:UpdateAll()
end


function plugin:DrDamage_Update()
	for k in pairs(spellamount) do
		spellamount[k] = nil
	end
end
