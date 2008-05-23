

local moduleName = "Buffs"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Buffs",

	["Always"] = true,
	["Enable/Disable buffs which are always shown."] = true,

	["Out Of Combat"] = true,
	["Enable/Disable Out of combat buffs."] = true,

	["Text Color"] = true,
	["Change the text color."] = true,

	["Enable/Disable showing of "] = true
} end)

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "Buffs",

	["Always"] = "항상",
	["Enable/Disable buffs which are always shown."] = "버프를 항상 표시할 것인지 선택합니다.",

	["Out Of Combat"] = "전투종료",
	["Enable/Disable Out of combat buffs."] = "전투종료를 표시할 것인지 선택합니다.",

	["Text Color"] = "글자 색상",
	["Change the text color."] = "글자의 색상을 변경합니다.",

	["Enable/Disable showing of "] = "보기설정 : "
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local BS = AceLibrary("Babble-Spell-2.2")

local buffs = {
	{"DRUID", true , BS["Rejuvenation"]},
	{"DRUID", true , BS["Regrowth"]},
	{"DRUID", true , BS["Lifebloom"]},
	{"DRUID", false, BS["Mark of the Wild"]},
	{"DRUID", false, BS["Gift of the Wild"]},
	{"DRUID", false, BS["Thorns"]},
	{"DRUID", true , BS["Innervate"]},
	{"DRUID", false, BS["Tree of Life"]},
	{"DRUID", true , BS["Frenzied Regeneration"]},
	{"DRUID", true , BS["Abolish Poison"]},
	{"DRUID", true , BS["Barkskin"]},

	{"PRIEST", false, BS["Power Word: Fortitude"]},
	{"PRIEST", false, BS["Prayer of Fortitude"]},
	{"PRIEST", true , BS["Power Word: Shield"]},
	{"PRIEST", true , BS["Renew"]},
	{"PRIEST", false, BS["Shadow Protection"]},
	{"PRIEST", false, BS["Prayer of Shadow Protection"]},
	{"PRIEST", false, BS["Divine Spirit"]},
	{"PRIEST", false, BS["Prayer of Spirit"]},
	{"PRIEST", true , BS["Fear Ward"]},
	{"PRIEST", true , BS["Prayer of Mending"]},
	{"PRIEST", true , BS["Abolish Disease"]},
	{"PRIEST", true , BS["Gift of the Naaru"]},

	{"PALADIN", true , BS["Blessing of Freedom"]},
	{"PALADIN", false, BS["Blessing of Kings"]},
	{"PALADIN", false, BS["Blessing of Light"]},
	{"PALADIN", false, BS["Blessing of Might"]},
	{"PALADIN", true , BS["Blessing of Protection"]},
	{"PALADIN", false, BS["Blessing of Sacrifice"]},
	{"PALADIN", false, BS["Blessing of Salvation"]},
	{"PALADIN", false, BS["Blessing of Sanctuary"]},
	{"PALADIN", false, BS["Blessing of Wisdom"]},
	{"PALADIN", false, BS["Greater Blessing of Kings"]},
	{"PALADIN", false, BS["Greater Blessing of Light"]},
	{"PALADIN", false, BS["Greater Blessing of Might"]},
	{"PALADIN", false, BS["Greater Blessing of Salvation"]},
	{"PALADIN", false, BS["Greater Blessing of Sanctuary"]},
	{"PALADIN", false, BS["Greater Blessing of Wisdom"]},
	{"PALADIN", true , BS["Lay on Hands"]},

	{"MAGE", false, BS["Arcane Intellect"]},
	{"MAGE", false, BS["Arcane Brilliance"]},
	{"MAGE", true , BS["Ice Block"]},
	{"MAGE", true , BS["Ice Barrier"]},
	{"MAGE", true , BS["Mana Shield"]},

	{"WARLOCK", false, BS["Soulstone Resurrection"]},
	{"WARLOCK", false, BS["Blood Pact"]},

	{"WARRIOR", true, BS["Shield Wall"]},
	{"WARRIOR", true, BS["Last Stand"]},

	{"HUNTER", true, BS["Misdirection"]},
	{"HUNTER", true, BS["Feign Death"]},

	{"SHAMAN", true , BS["Earth Shield"]},
	{"SHAMAN", false, BS["Heroism"]},

	{"ROGUE", true, BS["Evasion"]}
}

local incombat = false

-- localize these functions to speed up our main loop
local UnitBuff = UnitBuff
local UnitAffectingCombat = UnitAffectingCombat



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 63398 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		always = {
			type = "group",
			name = L["Always"],
			desc = L["Enable/Disable buffs which are always shown."],
			args = { }
		},
		ooc = {
			type = "group",
			name = L["Out Of Combat"],
			desc = L["Enable/Disable Out of combat buffs."],
			args = { }
		},
		color = {
			type = "color",
			name = L["Text Color"],
			desc = L["Change the text color."],
			get = "GetSetColor",
			set = "GetSetColor"
		}
	}
}

plugin.defaultDB = {
	position = 3,

	always = {}, -- these are automatically filled
	ooc    = {},
	color  = {
		r = 1,
		g = 1,
		b = 0
	}
}


do -- let's not pollute our name space
	local _,class = UnitClass("player")

	for i,a in ipairs(buffs) do
		local cname = "|cff"..string.format("%02x%02x%02x", RAID_CLASS_COLORS[a[1]].r * 255, RAID_CLASS_COLORS[a[1]].g * 255, RAID_CLASS_COLORS[a[1]].b * 255)..a[3].."|r"

		plugin.options.args.always.args[a[3]] = {
			type  = "toggle",
			name  = cname,
			desc  = L["Enable/Disable showing of "]..a[3],
			get   = function() return plugin.db.profile.always[a[3]] end,
			set   = function(v)
						plugin.db.profile.always[a[3]] = v

						if v then
							plugin.db.profile.ooc[a[3]] = false
						end
					end,
			order = i
		}

		plugin.options.args.ooc.args[a[3]] = {
			type  = "toggle",
			name  = cname,
			desc  = L["Enable/Disable showing of "]..a[3],
			get   = function() return plugin.db.profile.ooc[a[3]] end,
			set   = function(v)
						plugin.db.profile.ooc[a[3]] = v

						if v then
							plugin.db.profile.always[a[3]] = false
						end
					end,
			order = i
		}

		if a[2] then
			plugin.defaultDB.always[a[3]] = true
			plugin.defaultDB.ooc[a[3]]    = false
		elseif a[1] == class then
		    plugin.defaultDB.always[a[3]] = false
			plugin.defaultDB.ooc[a[3]]    = true
		else
			plugin.defaultDB.always[a[3]] = false
			plugin.defaultDB.ooc[a[3]]    = false
		end
	end
end



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	self:ScheduleRepeatingEvent(self.Update, 0.5, self) -- can't use UNIT_AURA cause we need to update timers
end


function plugin:OnCreate(frame)
	local buffbar = CreateFrame("Frame", nil, frame)
	buffbar:SetWidth(4 * (16 + 1))
	buffbar:SetHeight(18)

	return buffbar
end


function plugin:CreateBuff(buffbar, n)
	local t = buffbar:CreateTexture(nil, "ARTWORK")
	t:SetHeight(18)
	t:SetWidth(15)
	t:SetVertexColor(1, 1, 1, 0.6)
	t:SetTexCoord(0.2, 0.8, 0.1, 0.9)
	t:ClearAllPoints()
	t:SetPoint("LEFT", buffbar, "LEFT", (n - 1) * 16, 0)
	t:Hide()

	local font = buffbar:CreateFontString(nil, "OVERLAY")
	font:SetFontObject(GameFontNormalSmall)
	font:SetTextColor(self.db.profile.color.r, self.db.profile.color.g, self.db.profile.color.b, 1)
	font:ClearAllPoints()
	font:SetAllPoints(t)
	font:Hide()
	t.tfont = font

	font = buffbar:CreateFontString(nil, "OVERLAY")
	font:SetFontObject(GameFontNormalSmall)
	font:SetTextHeight(10)
	font:SetTextColor(1, 0, 0, 0.6)
	font:ClearAllPoints()
	font:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 0, 0)
	font:Hide()
	t.afont = font

	buffbar[n] = t
end


function plugin:OnUpdate(frame, buffbar)
	local n = 1

	for i = 1,32 do
		local name, _, texture, applications, duration, timeleft = UnitBuff(frame.unit, i)

		if not name then break end

		if self.db.profile.always[name] or (not incombat and self.db.profile.ooc[name]) then
			if not buffbar[n] then
				self:CreateBuff(buffbar, n)
			end

			buffbar[n]:SetTexture(texture)
			buffbar[n]:Show()

			if timeleft and timeleft > 0 then
				if timeleft > 60 then timeleft = timeleft / 60 end
				timeleft = math.floor(timeleft)

				buffbar[n].tfont:SetText(timeleft)
				buffbar[n].tfont:Show()
			else
				buffbar[n].tfont:Hide()
			end

			if applications > 0 then
				buffbar[n].afont:SetText(applications)
				buffbar[n].afont:Show()
			else
				buffbar[n].afont:Hide()
			end

			n = n + 1
		end
	end

	while buffbar[n] do
		buffbar[n]:Hide()
		buffbar[n].tfont:Hide()
		buffbar[n].afont:Hide()
		n = n + 1
	end
end


function plugin:Update()
	incombat = UnitAffectingCombat("player") or UnitAffectingCombat("target")

	self:UpdateAll()
end



----------------------------------
--      Option Handlers         --
----------------------------------

function plugin:GetSetColor(r, g, b)
	if type(r) == "nil" then return self.db.profile.color.r, self.db.profile.color.g, self.db.profile.color.b end

	self.db.profile.color.r = r
	self.db.profile.color.g = g
	self.db.profile.color.b = b

	for _,frame in pairs(self.core.frames) do
		local buffbar, n = frame.parts[self.name], 1

		while buffbar[n] do
			buffbar[n].font:SetTextColor(self.db.profile.color.r ,self.db.profile.color.g, self.db.profile.color.b, 1)
			n = n + 1
		end
	end
end
