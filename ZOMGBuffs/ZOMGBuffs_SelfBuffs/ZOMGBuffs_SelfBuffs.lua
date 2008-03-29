if (ZOMGSelfBuffs) then
	z:Print("Installation error, duplicate copy of ZOMGBuffs_SelfBuffs (Addons\ZOMGBuffs\ZOMGBuffs_SelfBuffs and Addons\ZOMGBuffs_SelfBuffs)")
	return
end

local L = LibStub("AceLocale-2.2"):new("ZOMGSelfBuffs")
local R = LibStub("AceLocale-2.2"):new("ZOMGReagents")
local BabbleSpell = LibStub("LibBabble-Spell-3.0")
local BS = BabbleSpell:GetLookupTable()
local roster = LibStub("Roster-2.1")
local playerClass, playerName
local template

-- TODO
--   Feed Pet

local z = ZOMGBuffs
local zs = z:NewModule("ZOMGSelfBuffs")
ZOMGSelfBuffs = zs

z:CheckVersion("$Revision: 66552 $")

local new, del, deepDel, copy = z.new, z.del, z.deepDel, z.copy

local function getOption(v)
	return zs.db.char[v]
end

local function setOption(v, n, s)
	zs.db.char[v] = n
	if (s) then
		z:CheckForChange(zs)
	end
end

local function getPrelude(k)
	return zs.db.char.rebuff[k] or 0
end

local function setPrelude(k, v)
	if ((not v or v == 0) and k ~= "default") then
		zs.db.char.rebuff[k] = nil
	else
		zs.db.char.rebuff[k] = v
	end
end

zs.consoleCmd = L["Self"]
zs.options = {
	type = "group",
	order = 1,
	name = "|cFFFF8080Z|cFFFFFF80O|cFF80FF80M|cFF8080FFG|cFFFFFFFFSelfBuffs|r",
	desc = L["Self Buff Configuration"],
	handler = zs,
	args = {
		template = {
			type = "group",
			name = L["Templates"],
			desc = L["Template configuration"],
			order = 10,
			hidden = function() return not zs:IsModuleActive() end,
			args = {
			}
		},
		behaviour = {
			type = "group",
			name = L["Behaviour"],
			desc = L["Self buffing behaviour"],
			order = 201,
			hidden = function() return not zs:IsModuleActive() end,
			args = {
				combatnotice = {
					type = "toggle",
					name = L["Combat Warnings"],
					desc = L["Warn about expiring buffs in combat. Note that auto buffing cannot be done in combat, this is simply a reminder"],
					get = getOption,
					set = function(k,v) setOption(k, v, true) end,
					passValue = "combatnotice",
					order = 5,
				},
				rebuff = {
					type = "range",
					name = L["Expiry Prelude"],
					desc = L["Default rebuff prelude for all self buffs"],
					func = timeFunc,
					order = 2,
					get = getPrelude,
					set = setPrelude,
					passValue = "default",
					min = 0,
					max = 15 * 60,
					step = 5,
					bigStep = 60,
					order = 10,
				},
				useauto = {
					type = "toggle",
					name = L["Auto buffs"],
					desc = L["Use auto-intelligent buffs such as Crusader Aura when mounted"],
					get = getOption,
					set = function(k,v) setOption(k, v, true) end,
					passValue = "useauto",
					order = 15,
				},
				info = {
					type = 'toggle',
					name = L["Reagent Reminder"],
					desc = L["Show message when spells requiring reagents are used"],
					get = getOption,
					set = setOption,
					passValue = "reagentNotices",
					order = 20,
				},
			},
		},
	}
}
zs.moduleOptions = zs.options

-- GetMyBuffs
function zs:GetMyBuffs()
	local myBuffs
	for i = 1,40 do
		local name, rank, buff, count, max, dur = UnitBuff("player", i)
		if (not name) then
			break
		end
		if (max) then
			if (not myBuffs) then
				myBuffs = new()
			end
			myBuffs[name] = (max > 0 and dur) or 99999
		else
			if (not z.zoneFlag) then	-- We can't warn immediately on zoning because time info often not available immediately
				local t = self.classBuffs[name]
				if (t) then
					if (t.checkdups) then
						if (template[name]) then
							-- Another paladin using our defined aura
							if (not myBuffs) then
								myBuffs = new()
							end
							myBuffs[name] = 99999	-- We won't buff it because we have what we think we want
						end
					end
				end
			end
		end
	end

	return myBuffs
end

-- GetExistingItemWithSequence
local function GetExistingItemWithSequence(k, v)
	if (k and v) then
		local n = k
		if (v.sequence) then
			for i = #v.sequence,1,-1 do
				local temp = k..v.sequence[i]
				local c = GetItemCount(temp)
				if (c > 0) then
					return temp
				end
			end
		else
			return GetItemCount(k) > 0 and k
		end
	end
end

-- SetupForItem
function zs:SetupForItem(slot, itemName)
	local spell, item
	local t1, t2 = IsUsableSpell(itemName)
	spell = (t1 or t2) and itemName
	if (not spell) then
		item = GetExistingItemWithSequence(itemName, self.classBuffs[itemName])
	end
	if (spell or item) then
		z:SetupForItem(slot, item, self, spell, item and 4 or nil)	-- 4 for when casting poisons onto weapons, we need more than 1.5 secs for next check
		self.activeEnchant = GetTime()
		lastEnchantSet = spell or item
		return true
	end
end

-- GetCurrentItemEnchant
do
	local tempTip, durMatch, encMatchHour, encMatchMin, encMatchSec
	function zs:GetCurrentItemEnchant(slot)
		local hasEnchant, Expiration, Charges = select(1 + (3 * (slot - 16)), GetWeaponEnchantInfo())
		if (hasEnchant) then
			local tipName = "ZOMGBuffTempTip"
			-- See what enchant is, so we can make sure it's the right one

			if (not tempTip) then
				tempTip = CreateFrame("GameTooltip", tipName, UIParent, "GameTooltipTemplate")
			end

			if (not durMatch) then
				durMatch = DURABILITY_TEMPLATE:gsub("%%d", "(%%d+)")
				encMatchHour = ITEM_ENCHANT_TIME_LEFT_HOURS:gsub("%%d", "(%%d+)"):gsub("%%s", "\.*")
				encMatchMin = ITEM_ENCHANT_TIME_LEFT_MIN:gsub("%%d", "(%%d+)"):gsub("%%s", "\.*")
				encMatchSec = ITEM_ENCHANT_TIME_LEFT_MIN:gsub("%%d", "(%%d+)"):gsub("%%s", "\.*")
			end

			tempTip:SetOwner(UIParent, "ANCHOR_NONE")
			local ok, cd = tempTip:SetInventoryItem("player", slot)
			if (ok and cd) then
				local left, prev
				for i = 1,200 do
					left = getglobal(format("%sTextLeft%d", tipName, i))
					if (not left) then
						break
					end
					left = left:GetText()
					if (not left) then
						break
					end
					if (strfind(left, durMatch)) then
						left = prev
						break
					end
					prev = left
					left = nil
				end
				tempTip:Hide()

				if (left) then
					local spellFind, timeLeft = strmatch(left, encMatchHour)
					if (spellFind) then
						timeLeft = timeLeft * 60 * 60
					else
						spellFind, timeLeft = strmatch(left, encMatchMin)
						if (spellFind) then
							timeLeft = timeLeft * 60
						else
							spellFind, timeLeft = strmatch(left, encMatchSec)
						end
					end
					if (spellFind) then
						return spellFind, timeLeft
					end
				end
			end
			tempTip:Hide()
		end
	end
end

-- CheckEnchant
function zs:CheckEnchant(slot, spellOrItem)
	if (spellOrItem) then
		if (not self.activeEnchant or self.activeEnchant < GetTime() - 4) then
			local hasEnchant, Expiration, Charges = select(1 + (3 * (slot - 16)), GetWeaponEnchantInfo())
			if (hasEnchant) then
				local enc, timeLeft = self:GetCurrentItemEnchant(slot)
				if (enc) then
					if (enc ~= spellOrItem) then
						CancelItemTempEnchantment(slot - 15)		-- 16 = 1, 17 = 2
						hasEnchant = nil
					end
				end
			end

			if (not hasEnchant or Expiration / 1000 < self.db.char.rebuff.default) then
				if (InCombatLockdown() or self:SetupForItem(slot, spellOrItem)) then
					local itemLink = GetInventoryItemLink("player", slot)
					local itemName
					if (itemLink) then
						itemName = GetItemInfo(itemLink)
					end
					if (not itemName) then
						itemName = (slot == 16 and L["Main Hand"]) or L["Off Hand"]
					end
					z:Notice(format(L["You need %s on |c00FFFF80%s|r"], z:LinkSpell(spellOrItem, nil, true), itemName), "buffreminder")
					return true
				end
			end
		end
	end
end

-- CheckWeaponBuff
function zs:CheckWeaponBuffs()
	return self:CheckEnchant(16, template.mainhand) or (OffhandHasWeapon() and self:CheckEnchant(17, template.offhand))
end

-- CheckBuffs
function zs:CheckBuffs()
	if (not self.classBuffs) then
		return
	end

	local myBuffs
	if (self.db.char.useauto and not InCombatLockdown()) then
		if (z.globalCooldownEnd > GetTime()) then
			z:GlobalCDSchedule()
			return
		end

		-- Special case for Crusader Aura when mounted, and Aspect of Cheetah when resting
		myBuffs = self:GetMyBuffs()
		for k,v in pairs(self.classBuffs) do
			if (v.auto) then
				if (not myBuffs or not myBuffs[k]) then
					if (v.auto()) then
						if (not UnitOnTaxi("player")) then
							z:SetupForSpell()
							z:SetupForSpell("player", k, self)
							z:Notice(format(L["You need %s"], z:LinkSpell(k, nil, true)), "buffreminder")
							z.icon.autospell = true
							del(myBuffs)
							return
						end
					end
				end
			end
		end
	end

	if (not z:CanCheckBuffs(self.db.char.combatnotice, true)) then
		if (self.mounted and not z.db.profile.notmounted) then
			z:SetupForSpell()
		end
		del(myBuffs)
		return
	end

	if (z.icon.autospell) then
		if (not InCombatLockdown()) then
			z:SetupForSpell()
		end
	end

	local any
	if (not myBuffs) then
		myBuffs = self:GetMyBuffs()
	end

	local minTimeLeft
	for k,v in pairs(template) do
		if (v) then
			local cb = self.classBuffs[k]
			if (cb and (cb.who == "self" or cb.who == "single" or cb.who == "party")) then		-- self.trackingBuffs[k] or
				local timeLeft = myBuffs and myBuffs[k]
				local requiredTimeLeft = self.db.char.rebuff[(cb and cb.rebuff) or k] or self.db.char.rebuff.default
				if (not timeLeft or timeLeft < requiredTimeLeft) then
					-- Need recast
					local start, duration, enable = GetSpellCooldown(k)
					if ((start == 0 or start + duration <= GetTime()) and enable == 1 and IsUsableSpell(k)) then
						if (not InCombatLockdown() or not cb.nocombatnotice) then
							z:Notice(format(L["You need %s"], z:LinkSpell(k, nil, true)), "buffreminder")
						end
						if (not InCombatLockdown()) then
							z:SetupForSpell("player", k, self)
						end
						any = true
						break
					elseif (start ~= 0) then
						local temp = (start + duration) - GetTime()
						if (not minTimeLeft or temp < minTimeLeft) then
							minTimeLeft = temp	-- Soon to cooldown spells caught here
						end
					end
				elseif (timeLeft and timeLeft < 10000) then
					local t = timeLeft - requiredTimeLeft
					if (not minTimeLeft or t < minTimeLeft) then
						minTimeLeft = t
					end
				end
			end
		end
	end

	if (not any and (template.mainhand or template.offhand)) then
		if (self:CheckWeaponBuffs()) then
			any = true
		end
	end

	self:CancelScheduledEvent("ZOMGBuffs_SelfCheckBuffs")
	if (not any and minTimeLeft) then
		self:ScheduleEvent("ZOMGBuffs_SelfCheckBuffs", self.CheckBuffs, minTimeLeft, self)
	end

	del(myBuffs)
end

-- GetClassBuffs
function zs:GetClassBuffs()
	if (playerClass == "DRUID") then
		self.classBuffs = {
			[BS["Omen of Clarity"]]		= {o = 2, duration = 30, who = "self", c = "80A0FF", noauto = true},
			[BS["Barkskin"]]			= {o = 5, duration = 0.25, who = "self", c = "A0A020", noauto = true, nocombatnotice = true},
			[BS["Nature's Grasp"]]		= {o = 6, duration = 0.75, who = "self", c = "80FF80", noauto = true},
			[BS["Tiger's Fury"]]		= {o = 7, duration = 0.1, who = "self", c = "FF8080", noauto = true},
		}
		self.reagents = {
			[R["Maple Seed"]]			= {20, 1, 50, maxLevel = 29},
			[R["Stranglethorn Seed"]]	= {20, 1, 50, maxLevel = 39},
			[R["Ashwood Seed"]]			= {20, 1, 50, maxLevel = 49},
			[R["Hornbeam Seed"]]		= {20, 1, 50, maxLevel = 59},
			[R["Ironwood Seed"]]		= {20, 1, 50, maxLevel = 69},
			[R["Flintweed Seed"]]		= {20, 1, 50, maxLevel = 79},
		}
		self.notifySpells = {
			[BS["Rebirth"]] = {
				R["Maple Seed"],
				R["Stranglethorn Seed"],
				R["Ashwood Seed"],
				R["Hornbeam Seed"],
				R["Ironwood Seed"],
				R["Flintweed Seed"],
			},
		}

	elseif (playerClass == "MAGE") then
		self.classBuffs = {
			[BS["Frost Armor"]]			= {o = 4,  duration = 30,   who = "self", c = "0000FF", exclude = function() return IsUsableSpell(BS["Ice Armor"]) end},
			[BS["Molten Armor"]]		= {o = 5,  duration = 30,   who = "self", dup = 2, c = "FF0000"},
			[BS["Ice Armor"]]			= {o = 6,  duration = 30,   who = "self", dup = 2, c = "0050FF"},
			[BS["Mage Armor"]]			= {o = 7,  duration = 30,   who = "self", dup = 2, c = "8080FF"},
			[BS["Ice Barrier"]]			= {o = 9,  duration = 1,    who = "self", c = "B0B0FF", noauto = true, cancancel = true},
			[BS["Fire Ward"]]			= {o = 10,  duration = 0.5,  who = "self", noauto = true, dup = 3, c = "FF5050", cancancel = true},
			[BS["Frost Ward"]]			= {o = 11, duration = 0.5,  who = "self", noauto = true, dup = 3, c = "5050FF", cancancel = true},
			[BS["Mana Shield"]]			= {o = 12, duration = 1,    who = "self", noauto = true, c = "FFB0B0", cancancel = true},
		}
		self.reagents = {
			[R["Rune of Portals"]]		= {20, 1, 100},
			[R["Rune of Teleportation"]] = {20, 1, 100},
		}
		local singlePort = R["Rune of Teleportation"]
		local groupPort = R["Rune of Portals"]
		self.notifySpells = {
			[BS["Teleport: Darnassus"]]		= singlePort,
			[BS["Teleport: Exodar"]]		= singlePort,
			[BS["Teleport: Ironforge"]]		= singlePort,
			[BS["Teleport: Orgrimmar"]]		= singlePort,
			[BS["Teleport: Shattrath"]]		= singlePort,
			[BS["Teleport: Silvermoon"]]	= singlePort,
			[BS["Teleport: Stormwind"]]		= singlePort,
			[BS["Teleport: Thunder Bluff"]]	= singlePort,
			[BS["Teleport: Undercity"]]		= singlePort,
			[BS["Portal: Darnassus"]]		= groupPort,
			[BS["Portal: Exodar"]]			= groupPort,
			[BS["Portal: Ironforge"]]		= groupPort,
			[BS["Portal: Orgrimmar"]]		= groupPort,
			[BS["Portal: Shattrath"]]		= groupPort,
			[BS["Portal: Silvermoon"]]		= groupPort,
			[BS["Portal: Stormwind"]]		= groupPort,
			[BS["Portal: Thunder Bluff"]]	= groupPort,
			[BS["Portal: Undercity"]]		= groupPort,
		}

	elseif (playerClass == "PRIEST") then
		self.classBuffs = {
			[BS["Power Word: Shield"]]		= {o = 1, duration = 0.5, who = "single", noauto = true, c = "C0C0FF"},
			[BS["Inner Fire"]]				= {o = 2, duration = 10, who = "self", c = "FFA080"},
			[BS["Shadowguard"]]				= {o = 3, duration = 10, who = "self", c = "FF80FF"},
			[BS["Touch of Weakness"]]		= {o = 4, duration = 10, who = "self", c = "206080", nocombatnotice = true},
			[BS["Elune's Grace"]]			= {o = 5, duration = 0.25, who = "self", c = "8080FF", nocombatnotice = true},
			[BS["Fear Ward"]]				= {o = 6, duration = 3, who = "single", noauto = true, c = "80FF80"},
			[BS["Feedback"]]				= {o = 7, duration = 0.25, who = "self", c = "204060", nocombatnotice = true},
			[BS["Shadowform"]]				= {o = 9, duration = -1, who = "self", c = "A020A0"},
		}

	elseif (playerClass == "WARLOCK") then
		self.classBuffs = {
			[BS["Demon Armor"]]				= {o = 1, duration = 30, who = "self", dup = 1, c = "FF80FF"},
			[BS["Demon Skin"]]				= {o = 2, duration = 30, who = "self", dup = 1, c = "FF20FF", exclude = function() return IsUsableSpell(BS["Demon Armor"]) end},
			[BS["Fel Armor"]]				= {o = 3, duration = 30, who = "self", dup = 1, c = "FF8080"},
			[BS["Shadow Ward"]]				= {o = 6, duration = 0.5, who = "self", noauto = true, c = "FF60FF"},
			[BS["Soul Link"]]				= {o = 7, duration = -1, who = "self", noauto = true, c = "20FF80"},
		}
		local shoulShard = R["Soul Shard"]
		self.notifySpells = {
			[BS["Create Firestone"]]	= shoulShard,
			[BS["Create Soulstone"]]	= shoulShard,
			[BS["Create Spellstone"]]	= shoulShard,
			[BS["Create Healthstone"]]	= shoulShard,
			[BS["Enslave Demon"]]		= shoulShard,
			[BS["Ritual of Souls"]]		= shoulShard,
			[BS["Ritual of Summoning"]]	= shoulShard,
			[BS["Shadowburn"]]			= shoulShard,
			[BS["Soul Fire"]]			= shoulShard,
			[BS["Soulshatter"]]			= shoulShard,
			[BS["Summon Felguard"]]		= shoulShard,
			[BS["Summon Felhunter"]]	= shoulShard,
			[BS["Summon Succubus"]]		= shoulShard,
			[BS["Summon Voidwalker"]]	= shoulShard,
		}

	elseif (playerClass == "HUNTER") then
		self.classBuffs = {
			[BS["Trueshot Aura"]]			= {o = 1, duration = -1, who = "self", c = "FFFFFF"},
			[BS["Aspect of the Viper"]]		= {o = 3, duration = -1, who = "self", dup = 1, c = "B080FF"},
			[BS["Aspect of the Hawk"]]		= {o = 4, duration = -1, who = "self", dup = 1, c = "4090FF"},
			[BS["Aspect of the Cheetah"]]	= {o = 5, duration = -1, who = "self", dup = 1, c = "FFFF80", auto = function() return IsResting() and z.db.profile.notresting and not IsMounted() end},
			[BS["Aspect of the Pack"]]		= {o = 6, duration = -1, who = "self", dup = 1, c = "B0B0B0"},
			[BS["Aspect of the Wild"]]		= {o = 7, duration = -1, who = "self", dup = 1, c = "20FF20"},
			[BS["Aspect of the Beast"]]		= {o = 8, duration = -1, who = "self", dup = 1, c = "FFA0FF"},
			[BS["Aspect of the Monkey"]]	= {o = 9, duration = -1, who = "self", dup = 1, c = "808020"},
		}

	elseif (playerClass == "SHAMAN") then
		local onEnableShield = function() 
			local btr = ZOMGBuffTehRaid
			if (btr) then
				local who = btr:ExclusiveTarget("EARTHSHIELD")
				if (who and UnitIsUnit(who, "player")) then
					btr:ModifyTemplate("EARTHSHIELD", nil)
				end
			end
		end

		self.classBuffs = {
			[BS["Lightning Shield"]]		= {o = 1, duration = 10, who = "self", c = "8080FF", onEnable = onEnableShield},
			[BS["Water Shield"]]			= {o = 4, duration = 10, who = "self", noauto = true, c = "4040FF", onEnable = onEnableShield},
			[BS["Windfury Weapon"]]			= {o = 1, duration = 30, who = "weapon", c = "FFFFFF", dup = 1},
			[BS["Flametongue Weapon"]]		= {o = 2, duration = 30, who = "weapon", c = "FF8080", dup = 1},
			[BS["Frostbrand Weapon"]]		= {o = 3, duration = 30, who = "weapon", c = "8080FF", dup = 1},
			[BS["Rockbiter Weapon"]]		= {o = 4, duration = 30, who = "weapon", c = "FFFF80", dup = 1},
		}
		self.reagents = {
			[R["Ankh"]] = {10, 1, 50},
		}
		self.notifySpells = {
			[R["Ankh"]] = R["Ankh"],
		}

	elseif (playerClass == "WARRIOR") then
		self.classBuffs = {
			[BS["Battle Shout"]]			= {o = 1, duration = 2, dup = 1, who = "self", c = "FF4040", checkdups = true},
			[BS["Commanding Shout"]]		= {o = 2, duration = 2, dup = 1, who = "self", c = "40FF40", checkdups = true},
			[BS["Berserker Rage"]]			= {o = 4, duration = 0.165, who = "self", noauto = true, c = "FFFF40"},
			[BS["Bloodrage"]]				= {o = 5, duration = 0.165, who = "self", noauto = true, c = "FF0000"},
		}

	elseif (playerClass == "ROGUE") then
		self.classBuffs = {
			[BS["Instant Poison"]]			= {o = 1, dup = 1, duration = 30, who = "weapon", c = "40F040", sequence = {"", " II", " III", " IV", " V", " VI", " VII"}},
			[BS["Deadly Poison"]]			= {o = 2, dup = 1, duration = 30, who = "weapon", c = "40E040", sequence = {"", " II", " III", " IV", " V", " VI", " VII"}},
			[BS["Crippling Poison"]]		= {o = 3, dup = 1, duration = 30, who = "weapon", c = "40C020", sequence = {"", " II"}},
			[BS["Mind-numbing Poison"]]		= {o = 4, dup = 1, duration = 30, who = "weapon", c = "40B040", sequence = {"", " II", " III"}},
			[BS["Wound Poison"]]			= {o = 5, dup = 1, duration = 30, who = "weapon", c = "A0A040", sequence = {"", " II", " III", " IV", " V"}},
			[BS["Anesthetic Poison"]]		= {o = 6, dup = 1, duration = 30, who = "weapon", c = "209080"},
		}
		self.reagents = {
			[R["Flash Powder"]] = {20, 1, 100},
		}
		self.notifySpells = {
			[BS["Vanish"]] = R["Flash Powder"],
		}

	elseif (playerClass == "PALADIN") then
		self.classBuffs = {
			[BS["Seal of Righteousness"]]	= {o = 1,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "C0C0FF", rebuff = L["Seals"]},
			[BS["Seal of Command"]]			= {o = 2,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "FFD010", rebuff = L["Seals"]},
			[BS["Seal of Wisdom"]]			= {o = 3,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "6070FF", rebuff = L["Seals"]},
			[BS["Seal of Light"]]			= {o = 4,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "FFA040", rebuff = L["Seals"]},
			[BS["Seal of Justice"]]			= {o = 5,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "FFD020", rebuff = L["Seals"]},
			[BS["Seal of the Crusader"]]	= {o = 6,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "FFFF30", rebuff = L["Seals"]},
			[BS["Seal of Blood"]]			= {o = 7,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "FFA0A0", rebuff = L["Seals"]},
			[BS["Seal of Vengeance"]]		= {o = 8,  duration = 0.5, who = "self", dup = 1, noauto = true, c = "FFA0A0", rebuff = L["Seals"]},
			[BS["Righteous Fury"]]			= {o = 10, duration = 30, who = "self", c = "FFD020", cancancel = true},
			[BS["Holy Shield"]]				= {o = 11, duration = 0.165, who = "self", c = "FFF0E0", noauto = true},
			[BS["Devotion Aura"]]			= {o = 13, duration = -1, who = "self", dup = 2, mounted = true, c = "8090C0", checkdups = true},
			[BS["Retribution Aura"]]		= {o = 14, duration = -1, who = "self", dup = 2, mounted = true, c = "D040D0", checkdups = true},
			[BS["Concentration Aura"]]		= {o = 15, duration = -1, who = "self", dup = 2, mounted = true, c = "C020E0", checkdups = true},
			[BS["Shadow Resistance Aura"]]	= {o = 16, duration = -1, who = "self", dup = 2, mounted = true, c = "8020FF", checkdups = true},
			[BS["Frost Resistance Aura"]]	= {o = 17, duration = -1, who = "self", dup = 2, mounted = true, c = "2020FF", checkdups = true},
			[BS["Fire Resistance Aura"]]	= {o = 18, duration = -1, who = "self", dup = 2, mounted = true, c = "E06020", checkdups = true},
			[BS["Sanctity Aura"]]			= {o = 19, duration = -1, who = "self", dup = 2, mounted = true, c = "FFFF90", checkdups = true},
			[BS["Crusader Aura"]]			= {o = 20, duration = -1, who = "self", dup = 2, mounted = true, noauto = true, auto = function(v) return (IsMounted() or zs.mounted) end, c = "FFFFFF"},
		}
		self.notifySpells = {
			[BS["Divine Intervention"]] = R["Symbol of Divinity"],
		}
	end

	local altList = new()
	for k,v in pairs(self.classBuffs) do
		tinsert(altList, v)
	end

	local setLearnable = not self.db.char.notlearnable
	if (setLearnable) then
		self.db.char.notlearnable = {}
	end

	for k,v in pairs(self.classBuffs) do
		if (setLearnable and v.noauto) then
			self.db.char.notlearnable[k] = true
		end

		if (v.who == "self" or v.who == "single" or v.who == "party") then
			--local t1, t2 = IsUsableSpell(k)
			local t1 = GetSpellCooldown(k)
			if (not t1) then	--not (t1 or t2)) then
				-- Remove any spells we don't have
				local o = v.o
				self.classBuffs[k] = nil

				for i = 1,#altList do
					if (altList[i].o > o) then
						altList[i].o = altList[i].o - 1
					end
				end
			end
		end
	end

	del(altList)
end

-- OneOfYours
function zs:OneOfYours(spell)
	return self.classBuffs[spell]
end

-- MakeSpellOptions
do
	local function setFunc(k)
		-- Untick any marked as 'dup' (Mutually exclusive buffs, such as Paladin Seals & Hunter Aspects)
		local b = zs.classBuffs[k]
		if (b) then
			local old = template[k]
			if (b.dup) then
				for i,s in pairs(zs.classBuffs) do
					if (b.dup == s.dup) then
						zs:ModifyTemplate(i, nil)
					end
				end
			end
			zs:ModifyTemplate(k, not old)
		end
		z:SetupForSpell()
		zs:CheckBuffs()
	end

	local function getLearnable(k)
		return not zs.db.char.notlearnable or not zs.db.char.notlearnable[k]
	end

	local function setLearnable(k, v)
		if (v == false) then
			if (not zs.db.char.notlearnable) then
				zs.db.char.notlearnable = {}
			end
			zs.db.char.notlearnable[k] = true
		else
			if (zs.db.char.notlearnable) then
				zs.db.char.notlearnable[k] = nil
				-- Don't nil this array, else next time we startup the defaults will be reset from the noauto values
			end
		end
	end

	function zs:MakeSpellOptions()
		local any
		local args = {}

		local order = 1
		local notDone, needBreak
		for i = 1,25 do
			local done
			for k,v in pairs(self.classBuffs) do
				if (v.o == i and (v.who == "self" or v.who == "single" or v.who == "party")) then
					if (not v.exclude or not v.exclude()) then
						if (needBreak and any) then
							args["header"..order] = {
								type = "header",
								name = " ",
								order = order,
							}
							order = order + 1
						end
						needBreak = nil

						any = true
						notDone = nil
						done = true
						local cName
						if (v.c) then
							cName = format("|cFF%s%s|r", v.c, k)
						else
							cName = k
						end

						args[k] = {
							type = "group",
							name = cName,
							desc = cName,
							order = order,
								isChecked = function() return template[k] end,
							onClick = setFunc,
							passValue = k,
							args = {
								header = {
									type = "header",
									name = cName,
									order = 1,
								},
								nolearn = {
									type = "toggle",
									name = L["Learnable"],
									desc = L["Remember this spell when it's cast manually?"],
									order = 3,
									get = getLearnable,
									set = setLearnable,
									passValue = k,
								}
							}
						}

						if ((v.duration or 0) > 0) then
							args[k].args.rebuff = {
								type = "range",
								name = L["Expiry Prelude"],
								desc = format(L["Rebuff prelude for %s (0=Module default)"], v.rebuff or cName),
								func = timeFunc,
								order = 2,
								get = getPrelude,
								set = setPrelude,
								passValue = v.rebuff or k,
								min = 0,
								max = (v.duration / 2) * 60,
								step = (v.duration <= 60 and 1) or 5,
								bigStep = (v.duration <= 60 and 5) or 60,
								order = 2,
							}
						end

						order = order + 1
						break
					end
				end
			end

			if (not done and not notDone) then
				needBreak = true
			end
		end

		if (any) then
			if (not zs.options.args.spells) then
				zs.options.args.spells = {
					type = "group",
					name = L["Class Spells"],
					desc = L["Class spell configuration"],
					order = 1,
					hidden = function() return not zs:IsModuleActive() end,
					args = {
					}
				}
			end
			zs.options.args.spells.args = args
		end

		del(list)
	end
end

-- MakeItemOptions
function zs:MakeItemOptions()
	local any
	local args = {
	}

	local function getFunc(k)
		local a,b = strmatch(k, "^(%a+):(.+)$")
		if (a == "mainhand") then
			return b == template.mainhand
		elseif (a == "offhand") then
			return b == template.offhand
		end
	end
	local function setFunc(k,v)
		local a,b = strmatch(k, "^(%a+):(.+)$")
		self.activeEnchant = nil
		self:ModifyTemplate(a, v and b)
	end

	local function hideOHWeapon()
		return GetInventoryItemLink("player", 17) == nil
	end

	for k,v in pairs(self.classBuffs) do
		if (v.who == "weapon") then
			local spell, item
			local t1, t2 = IsUsableSpell(k)
			spell = (t1 or t2) and k
			if (not spell) then
				item = GetExistingItemWithSequence(k,v)
			end
			if (spell or item) then
				local e1, e2, e3
				e1 = "mainhand:"..k
				e2 = "offhand:"..k
				e3 = "both:"..k

				local spellIcon
				if (item) then
					spellIcon = select(10, GetItemInfo(item))
				else
					spellIcon = BabbleSpell:GetSpellIcon(spell)
				end

				any = true
				args[k] = {
					type = "group",
					name = spell or item,
					desc = spell or item,
					order = v.o,
					get = function(k) return template[spell or item] end,
					set = function(k,v) end,
					icon = spellIcon,
					passValue = k,
					args = {
						mainhand = {
							type = "toggle",
							name = L["Main Hand"],
							desc = L["Use this item or spell on the main hand weapon"],
							order = 1,
							get = getFunc,
							set = setFunc,
							passValue = e1,
						},
						offhand = {
							type = "toggle",
							name = L["Off Hand"],
							desc = L["Use this item or spell on the off hand weapon"],
							order = 1,
							hidden = hideOHWeapon,
							get = getFunc,
							set = setFunc,
							passValue = e2,
						},
					}
				}
			end
		end
	end

	if (any) then
		if (not zs.options.args.item) then
			zs.options.args.item = {
				type = "group",
				name = L["Items"],
				desc = L["Item configuration"],
				order = 2,
				hidden = function() return not zs:IsModuleActive() end,
				args = {
				}
			}
		end
		zs.options.args.item.args = args
	end

	del(list)
end

-- SelectTemplate
function zs:OnSelectTemplate(templateName)
	template = self.db.char.templates.current

	for key,buff in pairs(self.classBuffs) do
		if (template[key]) then
			if (buff.onEnable) then
				buff.onEnable()
			end
		end
	end
end

-- OnModifyTemplate
function zs:OnModifyTemplate(key, value)
	if (value) then
		local buff = self.classBuffs[key]
		if (buff and buff.onEnable) then
			buff.onEnable()
		end
	end
end

-- UNIT_SPELLCAST_FAILED
function zs:SpellCastFailed(spell, rank, manual)
	if (not manual) then
		if (spell == lastEnchantSet) then
			self.activeEnchant = nil
		end
		self:CheckBuffs()
	end
end

-- UNIT_AURA
function zs:UNIT_AURA(unit)
	if (unit == "player") then
		z:CheckForChange(self)
	end
end

-- UNIT_AURA
function zs:PLAYER_AURAS_CHANGED()
	local m = IsMounted()
	if (self.mounted ~= m) then
		self.mounted = m
		if (m) then
			z:SetupForSpell()
			self:CheckBuffs()
			return
		end
	end

	z:CheckForChange(self)
end

-- UNIT_INVENTORY_CHANGED
function zs:UNIT_INVENTORY_CHANGED(unit)
	if (unit == "player") then
		self.activeEnchant = nil
		self:CheckBuffs()
	end
end

-- SPELLS_CHANGED
function zs:SPELLS_CHANGED()
	playerName = UnitName("player")
	playerClass = select(2, UnitClass("player"))
	self:GetClassBuffs()

	self:MakeSpellOptions()
	self:MakeItemOptions()

	z:CheckForChange(self)
end

-- SpellCastSucceeded
function zs:SpellCastSucceeded(spell, rank, target, manual)
	if (spell == lastEnchantSet and target == UnitName("player")) then
		self.activeEnchant = nil
	end

	if (manual) then
		if (z:CanLearn() and (not zs.db.char.notlearnable or not zs.db.char.notlearnable[spell])) then
			local ours
			-- Manual cast buffs will override the current template and mark it as modified.
			local buff = self.classBuffs[spell]
			if (buff) then
				if (buff.who == "self") then
					-- Manual buff override
					if (buff.dup) then
						for k,v in pairs(self.classBuffs) do
							if (v.dup == buff.dup) then
								self:ModifyTemplate(k, nil)
							end
						end
					end
					ours = true
				end
			end

			if (ours) then
				z:CheckForChange(self)
				self:ModifyTemplate(spell, true)
			end
		end
	end

	-- Check for a spell used with a consumable reagent not covered in raid/blessings
	if (self.notifySpells and self.db.char.reagentNotices) then
		local found = self.notifySpells[spell]
		if (found) then
			local reagent
			if (type(found) == "table") then
				reagent = found[rank]
				if (not reagent) then
					reagent = found[#found]
				end
			else
				reagent = found
			end

			if (reagent) then
				local count = GetItemCount(reagent)
				local colourCount
				if (count < 2) then
					colourCount = "|cFFFF4040"
				elseif (count < 5) then
					colourCount = "|cFFFFFF40"
				else
					colourCount = "|cFF40FF40"
				end

				self:Print(L["%s, %s%d|r %s remain"], spell, colourCount, count - 1, reagent)
			end
		end
	end
end

-- TooltipOnClick
function zs:TooltipOnClick(name)
	if (name) then
		if (IsShiftKeyDown()) then
			self:ModifyTemplate(name, nil)
		else
			local b
			if (name == "mainhand" or name == "offhand") then
				b = self.classBuffs[template[name]]
			else
				b = self.classBuffs[name]
			end

			local nextOne, firstOne, replaceTo
			local lowest = 99
			if (b and b.dup) then
				for find,s in pairs(self.classBuffs) do
					if (not s.exclude or s.exclude()) then
						if (b.dup == s.dup) then
							if (s.o < lowest) then
								lowest = s.o
								firstOne = find
							end
							if (s.o == b.o + 1) then
								replaceTo = find
							end
						end
					end
				end
			end

			if (replaceTo or firstOne) then
				if (name == "mainhand" or name == "offhand") then
					self.activeEnchant = nil
					self:ModifyTemplate(name, replaceTo or firstOne)
				else
					if (name ~= (replaceTo or firstOne)) then
						self:ModifyTemplate(name, nil)
						self:ModifyTemplate(replaceTo or firstOne, true)
					end
				end
			end
		end
	end
end

-- AddItem
function zs:AddItem(cat, which, item)
	local name = (which == "mainhand" and L["Main Hand"]) or L["Off Hand"]
	local itemName = GetExistingItemWithSequence(item, self.classBuffs[item])
	local checkIcon
	if (itemName) then
		item = itemName
		checkIcon = select(10, GetItemInfo(itemName))
	end

	cat:AddLine(
		"text", name,
		"textR", 0.5,
		"textG", 1,
		"textB", 0.5,
		"text2", item,
		"text2R", 1,
		"text2G", 1,
		"text2B", 0.5,
		"func", "TooltipOnClick",
		"arg1", self,
		"arg2", which,
		"hasCheck", checkIcon and true,
		"checked", checkIcon and true,
		"checkIcon", checkIcon
	)
end

-- SortedBuffList
function zs:SortedBuffList()
	local list = new()
	for name,info in pairs(self.classBuffs) do
		if (info.who == "self") then
			local insertPos = #list + 1
			for i,key in ipairs(list) do
				if (self.classBuffs[key].who == "self" and self.classBuffs[key].o > info.o) then
					insertPos = i
					break
				end
			end
			tinsert(list, insertPos, name)
		end
	end
	return list
end

-- TooltipUpdate
function zs:TooltipUpdate(cat)
	if (template and self.classBuffs) then
		cat:AddLine('text', " ")
		cat:AddLine(
			"text", L["Self Buffs Template: "].."|cFFFFFFFF"..(zs.db.char.selectedTemplate or L["none"]),
			"text2", (template and template.modified and "|cFFFF4040"..L["(modified)"].."|r") or ""
		)

		if (template.mainhand) then
			self:AddItem(cat, "mainhand", template.mainhand)
		end
		if (template.offhand) then
			self:AddItem(cat, "offhand", template.offhand)
		end

		local list = self:SortedBuffList()
		for i,key in ipairs(list) do
			local buff = self.classBuffs[key]

			if (template[key]) then
				local checkIcon = BabbleSpell:GetSpellIcon(key)
				local c = "|cFF"..((buff and buff.c) or "FFFF80")

				cat:AddLine(
					"text", c..key,
					"func", "TooltipOnClick",
					"arg1", self,
					"arg2", key,
					"hasCheck", checkIcon and true,
					"checked", checkIcon and true,
					"checkIcon", checkIcon
				)
			end
		end
		del(list)
	end
end

-- OnModuleInitialize
function zs:OnModuleInitialize()
	self.db = z:AcquireDBNamespace("SelfBuffs")
	z:RegisterDefaults("SelfBuffs", "char", {
		useauto = true,
		templates = {},
		reagents = {},
		combatnotice = true,
		rebuff = {
			default = 30,
			[L["Seals"]] = 5,
		},
		reagentNotices = true,
	} )
	z:RegisterChatCommand({"/zomgself", "/zomgselfbuffs"}, zs.options)
	self.OnMenuRequest = self.options
	z.options.args.ZOMGSelfBuffs = self.options

	template = zs.db.char.templates.current
	if (not template) then
		template = {}
		zs.db.char.templates.current = template
	end

	self.OnModuleInitialize = nil
end

-- OnResetDB
function zs:OnResetDB()
	template = self.db.char.templates.current
end

-- hookCancelPlayerBuff
local function hookCancelPlayerBuff(name, rank)
	if (z:IsActive() and z:IsModuleActive(zs)) then
		if (type(name) == "number") then
			name = GetPlayerBuffName(name)
		end

		if (type(name) == "string") then
			local buff = z.classBuffs and z.classBuffs[name]
			if (buff and buff.cancancel) then
				if (template[name]) then
					zs:ModifyTemplate(name, nil)
				end
			end
		end
	end
end

-- OnModuleEnable
function zs:OnModuleEnable()
	self:OnResetDB()

	playerName = UnitName("player")
	playerClass = select(2, UnitClass("player"))

	if (playerClass == "ROGUE") then
		if (self.db.char.reagents.flashpowder == nil) then
			self.db.char.reagents.flashpowder = 20
		end
	end
	z:MakeOptionsReagentList()

	self:SPELLS_CHANGED()

	self.mounted = IsMounted()

	self:RegisterEvent("SPELLS_CHANGED")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:RegisterBucketEvent("PLAYER_AURAS_CHANGED", 0.2)
	z:CheckForChange(self)

	if (not self.hooked) then
		self.hooked = true
		hooksecurefunc("CancelPlayerBuff", hookCancelPlayerBuff)
	end
end

-- OnModuleDisable
function zs:OnModuleDisable()
	z:CheckForChange(self)
	playerName = nil
	self.classBuffs = nil
	self.activeEnchant = nil
end
