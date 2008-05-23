﻿

local moduleName = "Dispel"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Dispel",

	["Debuffs"] = true,
	["Enable/Disable debuffs."] = true,

	["Add debuff"] = true,
	["Add a debuff to show. Must match the exact name of the debuff, including capital case."] = true,

	["Sound Warning"] = true,
	["Play a sound when there is something to dispel."] = true,

	["Enable/Disable this debuff. Shift click to remove it completly."] = true,
	["|cffff0000%s|r added to the debuff list."] = true,
	["|cffff0000%s|r removed from the debuff list."] = true
} end)

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "디버프",

	["Debuffs"] = "디버프",
	["Enable/Disable debuffs."] = "디버프 보기 설정",

	["Add debuff"] = "디버프 추가",
	["Add a debuff to show. Must match the exact name of the debuff, including capital case."] = "표시할 디버프를 추가합니다. 디버프의 이름을 정확하게 입력해야 합니다.",

	["Sound Warning"] = "소리 경고",
	["Play a sound when there is something to dispel."] = "디버프가 표시됐을 때, 소리로 알립니다.",


	["|cffff0000%s|r added to the debuff list."] = "리스트에 추가된 |cffff0000%s|r",
	["|cffff0000%s|r removed from the debuff list."] = "리스트에 삭제된 |cffff0000%s|r"
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local BS = AceLibrary("Babble-Spell-2.2")

local candispel = {
	["WARRIOR"] = { },
	["ROGUE"] = { },
	["HUNTER"] = { },
	["MAGE"] = {
		["Curse"] = true
	},
	["WARLOCK"] = { },
	["DRUID"] = { 
		["Curse"] = true,
		["Poison"] = true
	},
	["PALADIN"] = {
		["Magic"] = true,
		["Poison"] = true,
		["Disease"] = true
	},
	["PRIEST"] = {
		["Magic"] = true,
		["Disease"] = true
	},
	["SHAMAN"] = {
		["Disease"] = true,
		["Poison"] = true
	}
}

do
	local class = select(2, UnitClass("player"))
	candispel = candispel[class] -- let's hope the rest of the candispel table is garbage collected after this
	candispel["none"] = true
end


local ignore = {
	-- debuffs here should never be dispelled
	[BS["Dreamless Sleep"]] = true,
	[BS["Greater Dreamless Sleep"]] = true,
	[BS["Major Dreamless Sleep"]] = true,

	[BS["Delusions of Jin'do"]] = true,

	[BS["Unstable Affliction"]] = true,

	[BS["Upset Tummy"]] = true, -- because it's very annoying

	-- debuffs here can be ignored
	["WARRIOR"] = {
		[BS["Ancient Hysteria"]] = true, -- Spirit reduced by 50%, Intellect reduced by 50%.
		[BS["Ignite Mana"]] = true, -- 400 mana burned every 3 sec.
		[BS["Tainted Mind"]] = true, -- Intellect reduced by 20%.
		[BS["Curse of Tongues"]] = true -- Casting speed reduced by 75%.
	},
	["ROGUE"] = {
		[BS["Ancient Hysteria"]] = true, -- Spirit reduced by 50%, Intellect reduced by 50%.
		[BS["Ignite Mana"]] = true, -- 400 mana burned every 3 sec.
		[BS["Tainted Mind"]] = true, -- Intellect reduced by 20%.
		[BS["Curse of Tongues"]] = true, -- Casting speed reduced by 75%.
		[BS["Silence"]] = true, -- Cannot cast spells.
		[BS["Sonic Burst"]] = true -- Cannot cast spells.
	},
	["HUNTER"] = {
	},
	["MAGE"] = {
		[BS["Dust Cloud"]] = true, -- Chance to hit reduced by 30%.
		[BS["Banshee Curse"]] = true -- Reduces an enemy's chance to hit by 10%.
	},
	["WARLOCK"] = {
		[BS["Dust Cloud"]] = true, -- Chance to hit reduced by 30%.
		[BS["Banshee Curse"]] = true -- Reduces an enemy's chance to hit by 10%.
	},
	["DRUID"] = {
	},
	["PALADIN"] = {
	},
	["PRIEST"] = {
		[BS["Dust Cloud"]] = true, -- Chance to hit reduced by 30%.
		[BS["Banshee Curse"]] = true -- Reduces an enemy's chance to hit by 10%.
	},
	["SHAMAN"] = {
	}
}


-- we have a local colors table so we can adjust it
local colors = { 
	-- stolen from FrameXML/BuffFrame.lua
	["none"]    = {0.8, 0  , 0  },
	["Magic"]	= {0.2, 0.6, 1  },
	["Curse"]	= {0.6, 0  , 1  },
	["Disease"]	= {0.6, 0.4, 0  },
	["Poison"]	= {0  , 0.6, 0  }
}


local sound = "Sound\\Doodad\\BellTollNightElf.wav" -- Simple ding

-- localize these functions to speed up the main loop a bit
local UnitClass = UnitClass
local UnitDebuff = UnitDebuff
local DebuffTypeColor = DebuffTypeColor


local debuffs = {}



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 64946 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		debuffs = {
			type = "group",
			name = L["Debuffs"],
			desc = L["Enable/Disable debuffs."],
			args = { }
		},
		add = {
			type  = "text",
			name  = L["Add debuff"],
			desc  = L["Add a debuff to show. Must match the exact name of the debuff, including capital case."],
			usage = "",
			get   = function() return "" end,
			set   = "NewDebuff"
		},
		sound = {
			type = "toggle",
			name = L["Sound Warning"],
			desc = L["Play a sound when there is something to dispel."],
            get  = "GetSetSound",
            set  = "GetSetSound"
		}
	}
}

plugin.defaultDB = {
	sound   = true,
	debuffs2 = { -- UnitDebuff returns a count of 0 in case something doesn't stack
		[BS["Water Tomb"]]				 = 1, -- Hydros
		[BS["Watery Grave"]]			 = 1, -- Morogrim
		[BS["Frost Blast"]]				 = 1, -- Kel'thuzad
		[BS["Garrote"]]					 = 1, -- Moroes
		[BS["Mortal Strike"]]			 = 1,
		[BS["Whirlwind"]]				 = 1, -- Leotheras the Blind
		[BS["Insidious Whisper"]]		 = 1, -- Leotheras the Blind
		[BS["Static Charge"]]			 = 1, -- Lady Vashj
		[BS["Panic"]]					 = 1, -- Lady Vashj Striders
		[BS["Wrath of the Astromancer"]] = 1, -- High Astromancer Solarian
		[BS["Conflagration"]]			 = 1, -- Kael'thas Sunstrider
		[BS["Remote Toy"]]				 = 1, -- Kael'thas Sunstrider
		[BS["Incinerate"]]				 = 1, -- Teron Gorefiend
		[BS["Shadow of Death"]]			 = 1, -- Teron Gorefiend
		[BS["Melt Armor"]]				 = 1, -- Al'ar
		[BS["Divine Wrath"]]			 = 1, -- Illidari Council
		[BS["Deadly Poison"]]			 = 1, -- Illidari Council
		[BS["Fatal Attraction"]]		 = 1, -- Mother Shahraz
		[BS["Vile Beam"]]				 = 1, -- Mother Shahraz
		[BS["Impaling Spine"]]			 = 1, -- High Warlord Naj'entus
		[BS["Doomfire"]]				 = 1, -- Archimonde
		[BS["Parasitic Shadowfiend"]]	 = 1, -- Illidan Stormrage
		[BS["Agonizing Flames"]]		 = 1, -- Illidan Stormrage
		[BS["Shear"]]					 = 1, -- Illidan Stormrage
		[BS["Dark Barrage"]]			 = 1, -- Illidan Stormrage
		[BS["Creeping Paralysis"]]		 = 1, -- Zul'jin
		[BS["Grievous Throw"]]			 = 1, -- Zul'jin
		[BS["Bloodboil"]]				 = 2  -- Gurtogg Bloodboil (having one of these debuffs is pretty normal here, 2 or more isn't)
	}
}


----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	-- this code is here to copy the debuffs from the old format to the new one (will only be run once and should be removed in the future)
	if self.db.profile.debuffs then
		for n,v in pairs(self.db.profile.debuffs) do
			if v == true and not plugin.defaultDB.debuffs2[n] then
				self.db.profile.debuffs2[n] = 1
			end
		end

		self.db.profile.debuffs = nil
	end


	-- TODO: Need to reset the menu on profile reset
	for n,v in pairs(self.db.profile.debuffs2) do
		if v >= 0 then
			self:NewDebuff(n, true)
		end
	end

	self:RegisterBucketEvent("UNIT_AURA", 0.5, "UpdateUnits")
end


function plugin:OnCreate(frame)
	local highlight = frame:CreateTexture(nil, "BACKGROUND")
	highlight:SetTexture("Interface/Tooltips/UI-Tooltip-Background")
	highlight:ClearAllPoints()
	highlight:SetAllPoints(frame)
	highlight:SetAlpha(0.8)
	highlight:Hide()

	return highlight
end


function plugin:OnUpdate(frame, highlight)
	local class = select(2, UnitClass(frame.unit))

	local hadone = highlight:IsShown()
	highlight:Hide()

	for k in pairs(debuffs) do debuffs[k] = nil end -- TODO: debuffs is a local variable which seems to decrease memory usage by a lot, verify this.

	for i = 1,32 do
		local name, _, _, count, type = UnitDebuff(frame.unit, i)

		if not name then break end

		if not count or count < 1 then count = 1 end

		if candispel[type] then
			if ignore[name] then
				debuffs[type] = "nodispel"
			elseif not ignore[class][name] and debuffs[type] ~= "nodispel" then
				debuffs[type] = name
			end
		elseif self.db.profile.debuffs2[name] and count >= self.db.profile.debuffs2[name] then
			debuffs["none"] = name
		end
	end

	for type in pairs(candispel) do
		if debuffs[type] and debuffs[type] ~= "nodispel" then
			highlight:SetVertexColor(unpack(colors[type]))
			highlight:Show()

			if not hadone and self.db.profile.sound then
				PlaySoundFile(sound)
			end
			return
		end
	end
end



----------------------------------
--      Option Handlers         --
----------------------------------

function plugin:NewDebuff(n, menuonly)
	n = strtrim(n)

	if n ~= "" then
		self.options.args.debuffs.args[n] = {
			type = "toggle",
			name = n,
			desc = L["Enable/Disable this debuff. Shift click to remove it completly."],
			get   = "ToggleDebuff",
			set   = "ToggleDebuff",
			passValue = n
		}

		if not menuonly then
			self.db.profile.debuffs2[n] = 1

			self.core:Print(string.format(L["|cffff0000%s|r added to the debuff list."], n))
		end
	end
end


function plugin:GetSetSound(v)
	if type(v) == "nil" then return self.db.profile.sound end

	self.db.profile.sound = v

	if v then PlaySoundFile(sound) end
end


function plugin:ToggleDebuff(n, v)
	if type(v) == "nil" then return plugin.db.profile.debuffs2[n] >= 1 end

	if IsShiftKeyDown() then
		if self.defaultDB.debuffs2[n] then
			plugin.db.profile.debuffs2[n] = -1
		else
			plugin.db.profile.debuffs2[n] = nil
		end

		self.options.args.debuffs.args[n] = nil

		self.core:Print(string.format(L["|cffff0000%s|r removed from the debuff list."], n))
	else
		if v then
			if self.defaultDB.debuffs2[n] then
				plugin.db.profile.debuffs2[n] = self.defaultDB.debuffs2[n]
			else
				plugin.db.profile.debuffs2[n] = 1
			end
		else
			plugin.db.profile.debuffs2[n] = 0
		end
	end
end
