if (ZOMGBlessings) then
	z:Print("Installation error, duplicate copy of ZOMGBuffs_Blessings (Addons\ZOMGBuffs\ZOMGBuffs_Blessings and Addons\ZOMGBuffs_Blessings)")
	return
end

local L = LibStub("AceLocale-2.2"):new("ZOMGBlessings")
local R = LibStub("AceLocale-2.2"):new("ZOMGReagents")
local BabbleSpell = LibStub("LibBabble-Spell-3.0")
local BS = BabbleSpell:GetLookupTable()
local roster = LibStub("Roster-2.1")
local SM = LibStub("LibSharedMedia-3.0")
local dewdrop
local playerClass
local template
local clickList
local singleRangeTest = BS["Blessing of Might"]		-- Earliest spell we get

-- Make it future proof for additional classes (eg: Death Knight)

--local symbolOfKings = R["Symbol of Kings"]

local z = ZOMGBuffs
local zb = z:NewModule("ZOMGBlessings")
ZOMGBlessings = zb

z:CheckVersion("$Revision: 66552 $")

local new, del, deepDel, copy = z.new, z.del, z.deepDel, z.copy
local classOrder, classIndex = z.classOrder, z.classIndex

local classOrder = {"WARRIOR", "ROGUE", "HUNTER", "DRUID", "SHAMAN", "PALADIN", "PRIEST", "MAGE", "WARLOCK"}

local function DefaultTemplates()
	return {
		[L["DPS"]] = {
			WARRIOR = "BOM",
			ROGUE = "BOM",
			HUNTER = "BOM",
			DRUID = "BOM",
			SHAMAN = "BOM",
			PALADIN = "BOW",
			PRIEST = "BOW",
			MAGE = "BOW",
			WARLOCK = "BOW",
		},
		[L["5-Man"]] = {
			WARRIOR = "BOK",
			ROGUE = "BOS",
			HUNTER = "BOS",
			DRUID = "BOS",
			SHAMAN = "BOS",
			PALADIN = "BOW",
			PRIEST = "BOS",
			MAGE = "BOS",
			WARLOCK = "BOS",
		},
		[L["Kings"]] = {
			WARRIOR = "BOK",
			ROGUE = "BOK",
			HUNTER = "BOK",
			DRUID = "BOK",
			SHAMAN = "BOK",
			PALADIN = "BOK",
			PRIEST = "BOK",
			MAGE = "BOK",
			WARLOCK = "BOK",
		},
	}
end

local function getOption(v)
	return zb.db.char[v]
end

local function setOption(v, n)
	zb.db.char[v] = n
	z:CheckForChange(zb)
end

-- MakeTemplateDescription
function zb:MakeTemplateDescription(templateName, lastText)
	local str = (lastText and lastText.."\r") or nil
	local t = zb.db.char.templates[templateName]
	if (t) then
		for i = 1,#classOrder do
			local c = classOrder[i]
			local blessing = t[c]
			str = format("%s%s - %s", (str and str.."\r") or "", z:ColourClass(c), z:ColourBlessing(blessing))
		end

		local newline = "\r"
		for k,v in pairs(t) do
			if (k ~= "default" and k ~= "modified" and k ~= "state" and not classIndex[k]) then
				str = format("%s%s\r%s - %s", str, newline, z:ColourUnitByName(k), z:ColourBlessing(v))
				newline = ""
			end
		end
	end
	return str or ""
end

-- NoExceptionIcons
local function NoExceptionIcons()
	return not zb.db.char.icons
end

zb.consoleCmd = L["Blessings"]
zb.options = {
	type = 'group',
	order = 3,
	name = "|cFFFF8080Z|cFFFFFF80O|cFF80FF80M|cFF8080FFG|cFFFFFFFFBlessings|r",
	desc = L["Blessings Configuration"],
	handler = zb,
	args = {
		template = {
			type = 'group',
			name = L["Templates"],
			desc = L["Template configuration"],
			order = 1,
			hidden = function() return not zb:IsModuleActive() end,
			args = {
			}
		},
		greater = {
			type = 'group',
			name = L["Greater Blessings"],
			desc = L["Choose when to use Greater Blessings"],
			order = 20,
			hidden = function() return not zb:IsModuleActive() end,
			args = {
				min = {
					type = 'range',
					name = L["Minimum"],
					desc = L["How many members of a class should there be to use Greater Blessings"],
					get = getOption,
					set = setOption,
					passValue = "min",
					min = 1,
					max = 40,
					step = 1,
					bigStep = 5,
					order = 1
				},
				solo = {
					type = 'toggle',
					name = L["Solo"],
					desc = L["Use Greater Blessings when solo"],
					get = getOption,
					set = setOption,
					passValue = "solo",
					order = 20,
				},
				party = {
					type = 'toggle',
					name = L["Party"],
					desc = L["Use Greater Blessings when in a party"],
					get = getOption,
					set = setOption,
					passValue = "party",
					order = 30,
				},
				raid = {
					type = 'toggle',
					name = L["Raid"],
					desc = L["Use Greater Blessings when in a raid"],
					get = getOption,
					set = setOption,
					passValue = "raid",
					order = 40,
				},
			},
		},
		expire = {
			type = 'group',
			name = L["Expiry Prelude"],
			desc = L["How long before buff expires to rebuff"],
			order = 21,
			hidden = function() return not zb:IsModuleActive() end,
			args = {
				single = {
					type = 'range',
					name = L["Single"],
					desc = L["How many minutes before single blessing expires to rebuff"],
					get = getOption,
					set = setOption,
					passValue = "single",
					min = 0,
					max = 5,
					step = 0.25,
					bigStep = 1,
					order = 1
				},
				greater = {
					type = 'range',
					name = L["Greater"],
					desc = L["How many minutes before greater blessing expires to rebuff"],
					get = getOption,
					set = setOption,
					passValue = "greater",
					min = 0,
					max = 15,
					step = 0.25,
					bigStep = 1,
					order = 1
				},
			},
		},
		icons = {
			type = 'group',
			name = L["Exception Icons"],
			desc = L["Icons that show at start of combat for easy rebuffing during long fights"],
			order = 50,
			hidden = function() return not zb:IsModuleActive() end,
			args = {
				enable = {
					type = 'toggle',
					name = L["Enable"],
					desc = L["Show single buff exception icons when in combat for easy rebuffing"],
					get = getOption,
					set = setOption,
					passValue = "icons",
					order = 1,
				},
				anchor = {
					type = 'text',
					name = L["Anchor"],
					desc = L["Anchor"],
					get = getOption,
					set = function(k,v) setOption(k,v) zb:ShowIconsFor5Secs() end,
					passValue = "iconanchor",
					validate = {LEFT = L["Left"], RIGHT = L["Right"]},
					disabled = InCombatLockdown,
					hidden = NoExceptionIcons,
					order = 9
				},
				scale = {
					type = 'range',
					name = L["Scale"],
					desc = L["Scale"],
					get = getOption,
					set = function(k,v) setOption(k,v) zb:ShowIconsFor5Secs() end,
					passValue = "iconscale",
					disabled = InCombatLockdown,
					hidden = NoExceptionIcons,
					min = 0.3,
					max = 2,
					step = 0.01,
					bigStep = 0.1,
					order = 10
				},
				faded = {
					type = 'range',
					name = L["Faded Alpha"],
					desc = L["Adjust how faded the exception icons are when the players have plenty of time left on their buffs"],
					get = getOption,
					set = function(k,v) setOption(k,v) zb:ShowIconsFor5Secs() end,
					passValue = "iconfade",
					hidden = NoExceptionIcons,
					min = 0,
					max = 1,
					step = 0.05,
					order = 12
				},
				reset = {
					type = 'execute',
					name = L["Reset"],
					desc = L["Reset default position of exception icon anchor"],
					func = function(k,v) zb:ResetExceptionIcons() end,
					disabled = InCombatLockdown,
					hidden = NoExceptionIcons,
					order = 100,
				},
			},
		},
	},
}
zb.moduleOptions = zb.options

-- CanChangeState
function zb:CanChangeState()
	return not self.db or self.db.char.selectedTemplate ~= "-"
end

-- OnSelectTemplate
function zb:OnSelectTemplate(templateName)
	template = self.db.char.templates.current
	self:ValidateTemplate(template)
	z:Log("bless", nil, "select", templateName)
end

-- SaveTemplate
function zb:OnSaveTemplate(templateName, t)
	z:Log("bless", nil, "save", templateName)
end

-- GetUnitPalaBuffs
local function GetUnitPalaBuffs(unitid, other)
	local myBuff, otherBuffs, myBuffTimeLeft, myBuffTimeMax
	for i = 1,40 do
		local name, rank, buff, count, max, dur = UnitBuff(unitid, i)
		if (not name) then
			break
		end

		local b = z.blessings[name]
		if (b) then
			if (max) then
				myBuff = b
				myBuffTimeLeft = dur
				myBuffTimeMax = max
			elseif (other) then
				if (not otherBuffs) then
					otherBuffs = new()
				end
				otherBuffs[b.type] = b
			end
		end
	end
	return myBuff, otherBuffs, myBuffTimeLeft, myBuffTimeMax
end

-- RebuffQuery
-- Do we need to highlight this cell to signal a rebuff needed?
function zb:RebuffQuery(unit)
	if (template and self.db and UnitIsConnected(unit) and UnitIsVisible(unit) and not UnitIsDeadOrGhost(unit) and not UnitIsCharmed(unit)) then
		local name = UnitName(unit)
		local class = select(2, UnitClass(unit))
		if (name) then
			local needType = template[name] or template[class]
			if (needType) then
				local myBuff, otherBuffs, myBuffTimeLeft = GetUnitPalaBuffs(unit)

				if (needType ~= (myBuff and myBuff.type) or (myBuff and (myBuff.class and myBuffTimeLeft < self.db.char.greater * 60) or (not myBuff.class and myBuffTimeLeft < self.db.char.single * 60))) then
					return true
				end
			end
		end
	end
end

-- GetActions
function zb:GetActions()
	if (not self.actions and playerClass == "PALADIN") then
		self.actions = {
			{name = L["Single Blessings"], type = "singleblessing"},
			{name = L["Greater Blessings"], type = "greaterblessing"},
		}
	end
	return self.actions
end

-- ResetActions
function zb:ResetActions()
	self.actions = nil
end

-- CheckBuffs
local hadSymbols = true
function zb:CheckBuffs()
	if (not template) then
		return
	end

	if (not z:CanCheckBuffs()) then
		--self:Print("Can't check buffs: "..tostring(select(2, z:CanCheckBuffs()) or nil))
		return
	end

	local gotSymbols = GetItemCount(21177) > 0		-- symbolOfKings
	local inRaid = GetNumRaidMembers() > 0
	local inParty = GetNumPartyMembers() > 0
	local getClassBuff = (inRaid and self.db.char.raid) or (inParty and self.db.char.party) or self.db.char.solo
	local limitToClass			-- Means we're looking for more people of same class
	local ltcSpell				-- And the spell we're looking for
	local ltcCount = 0			-- And how many we find
	local ltcUnits				-- And on who
	local ltcType				-- The blessing type found for class spell (BOM, BOL, BOW etc)
	local singleNeedSpell			-- What to use if noone else close
	local singleNeedUnit                    -- And on who
	local singleNeedType			-- Blessing type for singles
	local spellDone
	local minTimeLeft
	local unitList = new()
	local classesCheckPresent = new()
	local totalPresent = 0
	local classNeedCount = 0
	local skipGreater = z.db.profile.singlesInBG and select(2, IsInInstance()) == "pvp"

	if (hadSymbols and not gotSymbols) then
		if (not z.zoneFlag) then
			hadSymbols = nil
			z:ReagentExpired(21177)		-- symbolOfKings
		end
	end

	self.outOfRange = del(self.outOfRange)

	local playerZone = GetRealZoneText()

	-- Quick first pass to get a list of players in range and such
	for unit in roster:IterateRoster() do
		local unitclass = unit.class
		if (not bm or unit.subgroup <= bm.db.profile.groups) then
			local unitid = unit.unitid
			if (select(2, UnitClass(unitid)) ~= unitclass) then
				-- Class mismatch happens between RAID_ROSTER_UPDATE and RosterLib_RosterChanged
				self:ScheduleEvent("ZOMGBlessings_CheckBuffs", self.CheckBuffs, 1, self)
				del(unitList)
				del(classesCheckPresent)
				return
			end

			local pvpBlock = (z.db.profile.skippvp and UnitIsPVP(unitid)) and not UnitIsPVP("player")
			local present = UnitIsConnected(unitid) and UnitCanAssist("player", unitid) and not pvpBlock
			local absent						-- They're not in zone, afk, or offline
			if (not present and z.db.profile.ignoreabsent and z.db.profile.waitforclass) then
				if (pvpBlock) then
					absent = true
				elseif (not UnitIsConnected(unitid)) then
					absent = true
				elseif (UnitIsAFK(unitid)) then
					absent = true
				else
					local inZone = true
					if (id) then
						local _, _, _, _, _, _, zone = GetRaidRosterInfo((strmatch(unitid, "(%d+)") or 0) + 0)
						if (zone and zone ~= playerZone) then
							absent = true
						end
					end
				end
			end

			if (present) then
				if (not UnitIsDeadOrGhost(unitid)) then
					if (IsSpellInRange(singleRangeTest, unitid) == 1) then
						classesCheckPresent[unitclass] = (classesCheckPresent[unitclass] or 0) + 1
						totalPresent = totalPresent + 1
						unitList[unitid] = unitclass			-- This is the list of valid cast targets
					else
						if (not self.outOfRange) then
							self.outOfRange = new()
						end
						self.outOfRange[unit.name] = true
					end
				end
			elseif (absent) then
				if (UnitIsConnected(unitid) and not IsSpellInRange(singleRangeTest, unitid) == 1) then
					if (not self.outOfRange) then
						self.outOfRange = new()
					end
					self.outOfRange[unit.name] = true
				end

				classesCheckPresent[unitclass] = (classesCheckPresent[unitclass] or 0) + 1
				totalPresent = totalPresent + 1
			end
		else
			classesCheckPresent[unitclass] = (classesCheckPresent[unitclass] or 0) + 1
			totalPresent = totalPresent + 1
		end
	end

	if (z.db.profile.waitforraid > 0) then
		-- See if enough of raid present
		local count = GetNumRaidMembers()
		if (count > 0) then
			if (totalPresent < count * z.db.profile.waitforraid) then	-- Wait for % of raid before buffing
				z.waitingForRaid = floor(totalPresent / count * 100)
				del(unitList)
				del(classesCheckPresent)
				return
			end
		end
	end

	z.waitingForRaid = nil
	z.waitingForClass = nil

	if (z.db.profile.waitforclass) then
		-- TODO Test: 1 in range, but all IsVisible(), because catch range on blessings is huge (80+ yards)   ??????
		-- Currently it waits for all to be in range, which has some issues if extra people are in raid but not attending

		-- If waiting for class, then remove any classes entirely that are no present, so we can focus on others
		for i,class in pairs(classOrder) do
			if ((classesCheckPresent[class] or 0) < (z.classcount[class] or 0)) then
				z.waitingForClass = (z.waitingForClass or "") .. ((z.waitingForClass and ", ") or "") .. z:ColourClass(class)
				for k,v in pairs(unitList) do
					if (v == class) then
						unitList[k] = nil
					end
				end
			end
		end
	end

	local btr = ZOMGBuffTehRaid
	-- Now go through this list and see what's missing
	for unitid,unitclass in pairs(unitList) do
		local unitname = UnitName(unitid)

		local needType = template[unitname] or template[unitclass]
		if (needType) then
			local myBuff, otherBuffs, myBuffTimeLeft = GetUnitPalaBuffs(unitid, true)
			local ignore
			if (myBuff == "BOP" or myBuff == "BOF" or myBuff == "SAC") then
				ignore = true
			elseif (btr) then
				if (btr:IsTrackingPlayer(unitname)) then
					-- BOP, BOF or SAC expected on this person
					ignore = true
				end
			end

			if (not ignore and ((needType and needType ~= (myBuff and myBuff.type)) or (myBuff and (myBuff.class and myBuffTimeLeft < zb.db.char.greater * 60) or (not myBuff.class and myBuffTimeLeft < zb.db.char.single * 60)))) then
				-- Doesn't have ours, or ours is soon to expire
				if (not otherBuffs or not otherBuffs[needType]) then
					-- Has noone else's buff of same type
					local singleSpell, classSpell = z:GetBlessingFromType(needType)

					if (unitclass == limitToClass) then
						if (template[unitname] and myBuff and myBuff.type == needType and myBuffTimeLeft >= max(zb.db.char.single,2) * 60) then
							ltcUnits[unitid] = false
							-- classNotNeedCount = classNotNeedCount + 1
						else
							-- Found another of same class needing this buff
							ltcUnits[unitid] = true
							classNeedCount = classNeedCount + 1
						end
					else
						-- Check this LTC bit:
						-- Was bugged because if all of 1 class was out of range,
						-- then a single was cast on the first of the next class in range

						if (gotSymbols and getClassBuff and classSpell and not template[unitname] and not skipGreater) then
							-- First found that needs buffing
							limitToClass = unitclass
							ltcSpell = classSpell
							ltcType = needType
							ltcUnits = new()
							ltcUnits[unitid] = true
							classNeedCount = 1
						end

						if (singleSpell) then
							singleNeedUnit = unitid
							singleNeedSpell = singleSpell
							singleNeedType = needType
						end
					end
				end
			else
				if (myBuff) then
					-- We find earliest expiring buff on anyone in group and set the scheduled event
					-- to fire when it's due for a rebuff, rather than periodically checking
					local t = myBuffTimeLeft
					if (myBuff.class) then
						t = t - (self.db.char.greater * 60)
					else
						t = t - (self.db.char.single * 60)
					end
					if (not minTimeLeft or t < minTimeLeft) then
						minTimeLeft = t
					end
				end
			end

			del(otherBuffs)
		end

		if (singleNeedUnit and not getClassBuff) then
			break
		end
	end

	if (not singleNeedUnit and not limitToClass and z.db.char.buffpets) then
		-- Check if any pets are missing the appropriate buffs
		-- Warlock pets should get their master's buffs
		-- Huntard pets should get warrior buffs

		for unit in roster:IterateRoster(true) do
			if (unit.class == "PET") then		--  and UnitClassification(unit.unitid) ~= "elite" -- chess event
				local masterUnit = unit.unitid:gsub("pet", "")
				if (UnitExists(masterUnit) and UnitIsVisible(unit.unitid) and UnitCanAssist("player", unit.unitid)) then
					local masterClass = select(2, UnitClass(masterUnit))
					if (masterClass == "HUNTER") then
						masterClass = "WARRIOR"
					end
					if (masterClass) then
						if ((classesCheckPresent[masterClass] or 0) == (z.classcount[masterClass] or 0)) then
							-- Only buff pets if all of master class present,
							-- which implies they're buffed if we got this far

							local needType = template[masterClass]
							if (needType) then
								local myBuff, otherBuffs, myBuffTimeLeft = GetUnitPalaBuffs(unit.unitid, true)
								if ((needType and needType ~= (myBuff and myBuff.type)) or (myBuff and (myBuff.class and myBuffTimeLeft < self.db.char.greater * 60) or (not myBuff.class and myBuffTimeLeft < self.db.char.single * 60))) then
									if (IsSpellInRange(singleRangeTest, unit.unitid) == 1) then
										-- Doesn't have ours, or ours is soon to expire
										if (not otherBuffs or not otherBuffs[needType]) then
											if (not z:IsBlacklisted(unit.name)) then
												-- Has noone else's buff of same type
												singleNeedUnit = unit.unitid
												singleNeedSpell = z:GetBlessingFromType(needType)
												singleNeedType = needType
												del(otherBuffs)
												break
											end
										end
									else
										if (not self.outOfRange) then
											self.outOfRange = new()
										end
										self.outOfRange[unit.name] = true
									end
								else
									if (myBuff) then
										-- We find earliest expiring buff on anyone in group and set the scheduled event
										-- to fire when it's due for a rebuff, rather than periodically checking
										local t = myBuffTimeLeft
										if (myBuff.class) then
											t = t - (self.db.char.greater * 60)
										else
											t = t - (self.db.char.single * 60)
										end
										if (not minTimeLeft or t < minTimeLeft) then
											minTimeLeft = t
										end
									end
								end
								del(otherBuffs)
							end
						end
					end
				end
			end
		end
	end

	del(unitList)

	if (limitToClass and classNeedCount >= zb.db.char.min) then
		for unitid,needed in pairs(ltcUnits) do
			if (select(2,UnitClass(unitid)) ~= limitToClass) then
				--	self:Print("Class mismatch (2) with "..z:ColourUnit(unitid).." in list for class "..z:ColourClass(limitToclass))
				break
			end
			local unitname = UnitName(unitid)
			local failedRecently = unitname and z:IsBlacklisted(unitname)
			if (not failedRecently and IsSpellInRange(ltcSpell, unitid) == 1) then
				z:Notice(format(L["Class %s needs %s"], z:ColourClass(limitToClass), z:ColourBlessing(ltcType, true, nil, true)), "buffreminder")
				z:SetupForSpell(unitid, ltcSpell, self, GetItemCount(21177))		-- symbolOfKings
				z:TriggerClickUpdate(unitid)		-- And also trigger a list click update
				spellDone = true
				break
			end
		end

	elseif (singleNeedSpell) then
		z:Notice(format(L["%s needs %s"], z:ColourUnit(singleNeedUnit), z:ColourBlessing(singleNeedType, nil, nil, true)), "buffreminder")
		z:SetupForSpell(singleNeedUnit, singleNeedSpell, self)
		z:TriggerClickUpdate(singleNeedUnit)		-- And also trigger a list click update
		spellDone = true
	end

	self:CancelScheduledEvent("ZOMGBlessings_OutOfRangeCheck")
	self:CancelScheduledEvent("ZOMGBlessings_CheckBuffs")

	if (spellDone) then
		z.waitingForRaid = nil
		z.waitingForClass = nil
	else
		if (self.outOfRange and (not minTimeLeft or minTimeLeft > 5)) then
			-- Setup periodic check for people out of range
			self:ScheduleEvent("ZOMGBlessings_OutOfRangeCheck", self.OutOfRangeCheck, 5, self)
		elseif (z:AnyBlacklisted()) then
			-- Setup check because noone who needed buff was not on line-of-sight blacklist
			minTimeLeft = 5
		end
	end

	if (minTimeLeft) then
		-- Schedule a check for when the first buff is due to expire
		self:ScheduleEvent("ZOMGBlessings_CheckBuffs", self.CheckBuffs, minTimeLeft, self)
	end

	del(ltcUnits)
	del(classesCheckPresent)

	return spellDone
end

-- GetSpellColour
function zb:GetSpellColour(spellName)
	local def = z.blessings and z.blessings[spellName]
	if (def) then
		return z.blessingColour[def.type]
	end
end

-- ShowBuffBar
function zb:ShowBuffBar(cell, name)
	return z.blessings[name] ~= nil
end

-- OutOfRangeCheck
function zb:OutOfRangeCheck()
	for name in pairs(self.outOfRange) do
		local unit = roster:GetUnitObjectFromName(name)
		if (unit and IsSpellInRange(singleRangeTest, unit.unitid) == 1) then
			self:CheckBuffs()
			break
		end
	end
end

-- MyBuffOnUnit
local function MyBuffOnUnit(partyid)
	local list
	for i = 1,40 do
		local name, rank, buff, count, max, dur = UnitBuff(partyid, i)
		if (not name) then
			return
		end
		if (max and z.blessings[name]) then
			return name, rank, buff, count, max, dur
		end
	end
end

-- OnModifyTemplate
function zb:OnModifyTemplate(class, type, response)
	if (not self.noBroadcast) then
		z:SendCommMessage("GROUP", "MODIFIEDTEMPLATE", template, response)
		if (ZOMGBlessingsManager) then
			ZOMGBlessingsManager:OnReceiveTemplate(UnitName("player"), template, true)
		end
	end
end

-- SetTemplateTypeClass(class, type)
function zb:SetTemplateTypeClass(unit, type)
	local class = unit.class
	local mod

	if (template[class] ~= type) then
		z:Log("bless", nil, "change", UnitName("player"), class, template[class], type)

		self:ModifyTemplate(class, type)
		mod = true
	end

	-- Scan through and remove any single overrides for this class,
	-- because we've manually cast a whole class blessing
	for search in roster:IterateRoster() do
		if (search.class == class) then
			if (template[search.name]) then
				self:ModifyTemplate(search.name, nil)
				mod = true
			end
			z:TriggerClickUpdate(search.unitid)		-- And also trigger a list click update
		end
	end

	if (mod and z.db.profile.info) then
		self:Print(L["Modified template: %s: %s"], z:ColourClass(unit.class), z:ColourBlessing(type, nil, true, true))
	end
end

-- SetTemplateTypeSingle
function zb:SetTemplateTypeSingle(unit, type)
	-- See if all of this class have same buff from me, and then remove the single exceptions if so
	local difference

	local class = unit.class
	local name = unit.name
	local unitid = unit.unitid

	for search in roster:IterateRoster(true) do
		local sclass = search.class
		local sname = search.name
		if (sclass == class) then
			if (sname ~= name) then
				if ((template[sname] or template[class]) ~= type) then
					difference = true
					break
				end
			end
		end
	end

	if (difference and z.classcount[class] > 1) then
		if (template[name] ~= type) then
			z:Log("bless", nil, "exception", UnitName("player"), name, template[name], type)

			self:ModifyTemplate(name, type)

			if (z.db.profile.info) then
				self:Print(L["Modified template: %s: %s"], z:ColourUnit(unitid), z:ColourBlessing(type, nil, true, true))
			end

			if (unitid) then
				z:TriggerClickUpdate(unitid)
			end
		end
	else
		self:SetTemplateTypeClass(unit, type)
	end
end

-- BlessingCastOn
-- This only gets called for manually cast blessings
function zb:BlessingCastOn(name, blessing)
	local unit = roster:GetUnitObjectFromName(name)
	if (not unit or not UnitIsPlayer(unit.unitid)) then
		return
	end

	if (blessing.noTemplate) then
		-- Don't change template for Blessing of Protection, Freedom, Sacrifice
		return
	end

	if (blessing.class) then
		self:SetTemplateTypeClass(unit, blessing.type)
	else
		self:SetTemplateTypeSingle(unit, blessing.type)
	end
end

-- OneOfYours
-- See if a manual cast spell is one of ours, in which case the main module will need to reset things
function zb:OneOfYours(spell)
	return z.blessings[spell]
end

-- SayWhatWeDid
function zb:SayWhatWeDid(icon, spell, name)
	local s = spell or icon:GetAttribute("spell")
	if (s) then
		local b = z.blessings[s]
		if (b) then
			local unitid
			if (name) then
				local unit = roster:GetUnitObjectFromName(strmatch(name, "[^-]+"))
				unitid = unit and unit.unitid
			end
			if (not unitid) then
				unitid = icon:GetAttribute("unit")
			end

			if (b.class) then
				local count = GetItemCount(21177) - 1		-- symbolOfKings
				local colourCount
				if (count < 20) then
					colourCount = "|cFFFF4040"
				elseif (count < 60) then
					colourCount = "|cFFFFFF40"
				else
					colourCount = "|cFF40FF40"
				end

				if (unitid) then
					self:Print(L["%s on %s (%s%d|r)"], z:ColourBlessing(b.type, true, nil, true), z:ColourClassUnit(unitid), colourCount, count)

					-- Now check for any single overrides which need to be done because we did a class buff
					local unitclass = select(2, UnitClass(unitid))
					for unit in roster:IterateRoster() do
						if (unit.class == unitclass) then
							local unitNeed = template[unit.name]
							if (unitNeed) then
								if (unitNeed ~= b.type) then
									self:Print(L[" %s now needs %s"], z:ColourUnit(unit.unitid), z:ColourBlessing(unitNeed, nil, nil, true))
								else
									-- For some reason the exception buff matches the group buff, so we'll remove it and skip it
									self:ModifyTemplate(unit.name, nil)
								end
							end
						end
					end
					return
				end
			end
			self:Print(L["%s on %s"], z:ColourBlessing(b.type, nil, nil, true), tostring(z:ColourUnit(unitid)))
		end
	end
end

-- RosterUnitRemoved
function zb:RosterUnitChanged(newID, newName, newClass, newGroup, newRank, oldName, oldID, oldClass, oldGroup, oldRank)
	if (not newName and oldName) then
		self:ModifyTemplate(oldName, nil)

	elseif (oldName and not newName) then
		z:CheckForChange(zb)
	end
end

-- OnRaidRosterUpdate
function zb:OnRaidRosterUpdate()
	if (template) then
		z:CheckForChange(zb)		-- Because raid IDs can change
		z:SendClass("PALADIN", "HELLO", z.version)
	end
end

-- zb:UNIT_SPELLCAST_SUCCEEDED
function zb:SpellCastSucceeded(spell, rank, target, manual)
	if (manual and z:CanLearn()) then
		local blessing = z.blessings[spell]
		if (blessing) then
			self:BlessingCastOn(target, blessing)
		end
	end
end

-- UNIT_SPELLCAST_FAILED
function zb:SpellCastFailed(spell, name, manual)
	if (not manual) then
		local blessing = z.blessings[spell]
		if (blessing) then
			z:Blacklist(name)
		end
	end
end

-- SmoothColour
local function SmoothColour(percentage)
	local r, g
	if (percentage < 0.5) then
		g = 2*percentage
		r = 1
	else
		g = 1
		r = 2*(1 - percentage)
	end
	if (r < 0) then r = 0 elseif (r > 1) then r = 1 end
	if (g < 0) then g = 0 elseif (g > 1) then g = 1 end
	return r, g, 0
end

-- MakeIconBar
function zb:MakeIconBar()
	local bar = CreateFrame("Frame", nil, UIParent)
	self.iconbar = bar
	bar:Hide()
	bar.timer = 0

	bar.title = bar:CreateFontString(nil, "BORDER", "GameFontNormalSmall")
	bar.title:SetPoint("TOPLEFT")
	bar:EnableMouse(true)
	bar:SetMovable(true)
	bar:RegisterForDrag("LeftButton")

	bar.UpdateCooldowns = function(self)
		for k,v in pairs(self.icons) do
			v:UpdateCooldown()
		end
	end

	bar.UpdateAura = function(self, unit)
		for k,v in pairs(self.icons) do
			if (v:IsShown()) then
				if (UnitIsUnit(v:GetAttribute("unit"), unit)) then
					v:UpdateAura()
					break
				end
			end
		end
	end

	bar.UpdateAllAuras = function(self)
		for k,v in pairs(self.icons) do
			if (self.demo) then
				v.timer:SetMinMaxValues(0, 600)
				v.timer:SetValue(zb.db.char.single * k * 45)
				v.timer:Show()
				v:UpdateBar()
			else
				v:UpdateAura()
			end
		end
	end

	bar:SetScript("OnMouseUp",
		function(self, button)
			if (button == "RightButton") then
				if (not dewdrop) then
					dewdrop = LibStub("Dewdrop-2.0")
				end
				dewdrop:Open(self, "children", zb.options.args.icons, 'cursorX', true, 'cursorY', true)
			end
		end)

	bar:SetScript("OnDragStart",
		function(self)
			self:StartMoving()
			zb:CancelScheduledEvent("ZOMG_ShowExceptionIcons")
		end)

	bar:SetScript("OnDragStop",
		function(self)
			self:StopMovingOrSizing()
			zb.db.char.posexceptions = z:GetPosition(self)
			if (not InCombatLockdown()) then
				zb:ShowIconsFor5Secs()
			end
		end)

	bar:SetScript("OnUpdate",
		function(self, elapsed)
			self.timer = self.timer + elapsed
			if (self.timer > 5) then
				for k,v in pairs(self.icons) do
					if (v:IsShown()) then
						if (v.timer:IsShown()) then
							v.timer:SetValue(max(0, v.timer:GetValue() - self.timer))
							v:UpdateBar()
						end
					end
				end
				self.timer = 0
			end
		end)

	bar:SetScript("OnShow",
		function(self)
			self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
			self:RegisterEvent("UNIT_AURA")
			self:UpdateCooldowns()
			self:UpdateAllAuras()
		end)

	bar:SetScript("OnHide",
		function(self)
			self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
			self:UnregisterEvent("UNIT_AURA")
		end)

	bar:SetScript("OnEvent",
		function(self, event, unit)
			if (event == "ACTIONBAR_UPDATE_COOLDOWN") then
				self:UpdateCooldowns()
			elseif (event == "UNIT_AURA") then
				self:UpdateAura(unit)
			end
		end)

	bar:SetPoint("TOP", 0, -150)

	bar:SetHeight(50)
	bar:SetWidth(36)
	bar.icons = {}

	z:RestorePosition(bar, self.db.char.posexceptions)

	self.MakeIconBar = nil
end

-- exceptionOnClick
local function exceptionOnClick(self, button)
	z.clickCast = true
end

-- ResetExceptionIcons
function zb:ResetExceptionIcons()
	zb:ShowIconsFor5Secs()
	self.iconbar:SetPoint("TOP", 0, -150)
end

do
	-- buttonUpdateAura
	local function buttonUpdateAura(self)
		if (self:IsShown()) then
			local unit = self:GetAttribute("unit")
			if (unit) then
				if (UnitCanAssist("player", unit)) then
					local myBuff, otherBuffs, myBuffTimeLeft, myBuffTimeMax = GetUnitPalaBuffs(unit)
					if (myBuff and myBuff.type == self.needType and myBuffTimeLeft and myBuffTimeMax) then
						self.timer:SetMinMaxValues(0, myBuffTimeMax)
						self.timer:SetValue(myBuffTimeLeft)
						self.timer:Show()
						self:UpdateBar()
						return
					end
				end

				self.timer:Hide()
				self:SetAlpha(1)
			end
		end
	end

	-- buttonUpdateBar
	local function buttonUpdateBar(self)
		local Min, Max = self.timer:GetMinMaxValues()
		local a = self.timer:GetValue()

		if (a < zb.db.char.single * 60) then
			self:SetAlpha(1)
		else
			self:SetAlpha(zb.db.char.iconfade)
		end

		local r, g, b = SmoothColour(a / Max)
		self.timer:SetStatusBarColor(r, g, b)
	end

	-- buttonUpdateCooldown
	local function buttonUpdateCooldown(self)
		local spell = self:GetAttribute("spell")
		if (spell) then
			local start, duration, enable = GetSpellCooldown(spell)
			CooldownFrame_SetTimer(self.cooldown, start, duration, enable)
		end
	end

	-- ShowExceptionIcons
	function zb:ShowExceptionIcons(show, demo)
		if (show and self.db and self.db.char.icons) then
			local list
			local demoSpells
			if (demo) then
				list = new("Demo1", "Demo2", "Demo3")
				demoSpells = {"BOM", "BOW", "BOK"}
			else
				list = new()
				for name,stuff in pairs(template) do
					if (name ~= "modified" and name ~= "state" and not classIndex[name]) then
						local unit = roster:GetUnitObjectFromName(name)
						if (unit and (not bm or unit.subgroup <= bm.db.profile.groups)) then
							tinsert(list, name)
						end
					end
				end
			end

			if (#list > 0) then
				if (not self.iconbar) then
					self:MakeIconBar()
				end
				self.iconbar.demo = demo

				sort(list)
				local icons = self.iconbar.icons

				-- We can't use a template header with a nameList because if the
				-- roster changes the spell's per unitid will become out of sync,
				-- so we're making a fixed list and referencing the units by name
				for i,name in ipairs(list) do
					local unit = roster:GetUnitObjectFromName(name)

					local icon = icons[i]
					if (not icon) then
						local iname = "ZOMGBlessingsIcon"..i
						icon = CreateFrame("Button", iname, self.iconbar, "SecureActionButtonTemplate,ActionButtonTemplate")
						icons[i] = icon

						icon:RegisterForDrag(nil)

						icon.icon = getglobal(iname.."Icon")
						icon.border = getglobal(iname.."Border")
						icon.normal = getglobal(iname.."NormalTexture")
						icon.flash = getglobal(iname.."Flash")
						icon.hotkey = getglobal(iname.."HotKey")
						icon.name = getglobal(iname.."Name")
						icon.count = getglobal(iname.."Count")
						icon.cooldown = getglobal(iname.."Cooldown")

						icon.name:ClearAllPoints()
						icon.name:SetPoint("TOPLEFT")
						icon.name:SetPoint("BOTTOMRIGHT", icon, "TOPRIGHT", 0, -20)
						icon.name:SetJustifyV("TOP")
						icon.name:SetNonSpaceWrap(true)
						icon.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
						icon.border:SetVertexColor(0, 1, 0, 0.6)
						icon.normal:SetVertexColor(1, 1, 1, 0.5)

						icon.timer = CreateFrame("StatusBar", nil, icon)
						icon.timer:SetPoint("BOTTOMLEFT")
						icon.timer:SetPoint("TOPRIGHT", icon, "BOTTOMRIGHT", 0, 8)
						icon.timer:SetStatusBarTexture(SM and SM:Fetch("statusbar", z.db.profile.bartexture) or "Interface\\AddOns\\ZOMGBuffs\\Textures\\BantoBar")
						icon.timer:SetStatusBarColor(1, 1, 1)

						icon:HookScript("OnClick", exceptionOnClick)

						icon:RegisterForClicks("AnyUp")
						
						icon.UpdateBar = buttonUpdateBar
						icon.UpdateAura = buttonUpdateAura
						icon.UpdateCooldown = buttonUpdateCooldown
					end

					icon:ClearAllPoints()
					if (i == 1) then
						if (self.db.char.iconanchor == "RIGHT") then
							icon:SetPoint("TOPRIGHT", 0, -14)
						else
							icon:SetPoint("TOPLEFT", 0, -14)
						end
					else
						if (self.db.char.iconanchor == "RIGHT") then
							icon:SetPoint("TOPRIGHT", icons[i - 1], "TOPLEFT", 0, 0)
						else
							icon:SetPoint("TOPLEFT", icons[i - 1], "TOPRIGHT", 0, 0)
						end
					end

					local singleSpell
					if (demo) then
						singleSpell = z:GetBlessingFromType(demoSpells[i])
					else
						singleSpell = z:GetBlessingFromType(template[name])
					end

					icon:SetAttribute("unit", name)		-- Name instead of ID, to allow for roster changes
					icon:SetAttribute("type", "spell")
					icon:SetAttribute("spell", singleSpell)
					icon.needType = template[name]

					icon.icon:SetTexture(BabbleSpell:GetSpellIcon(singleSpell))

					if (demo) then
						icon.name:SetText(name)
					else
						icon.name:SetText(z:ColourUnit(unit.unitid))
					end

					icon:Show()
				end

				if (#list > 2) then
					self.iconbar.title:SetText(L["ZOMG Exceptions"])
				else
					self.iconbar.title:SetText(L["ZOMG"])
				end

				for i = #list + 1, #icons do
					if (icons[i]) then
						icons[i]:Hide()
					end
				end

				self.iconbar.timer = 0
				self.iconbar:Show()
				self.iconbar:SetScale(self.db.char.iconscale)

				self.iconbar.title:ClearAllPoints()
				if (self.db.char.iconanchor == "RIGHT") then
					self.iconbar.title:SetPoint("TOPRIGHT")
				else
					self.iconbar.title:SetPoint("TOPLEFT")
				end
				
				if (demo) then
					self.iconbar:UpdateAllAuras()
				end
				
				del(list)
				return
			end

			del(list)
		end

		if (self.iconbar) then
			self.iconbar:Hide()
		end
	end
end

-- ShowIconsFor5Secs
function zb:ShowIconsFor5Secs()
	self:ShowExceptionIcons(true, true)
	self:ScheduleEvent("ZOMG_ShowExceptionIcons", self.ShowExceptionIcons, 5, self)
end

-- OnRegenDisabled
function zb:OnRegenDisabled()
	self:ShowExceptionIcons(true)
end

-- OnRegenEnabled
function zb:OnRegenEnabled()
	self:ShowExceptionIcons()
end

-- UNIT_AURA
function zb:UNIT_AURA(unit)
	self:CheckBuffs()
end

-- UNIT_INVENTORY_CHANGED
function zb:UNIT_INVENTORY_CHANGED()
	local count = GetItemCount(21177)	-- Symbol of Kings
	if (count ~= self.OldKingsCount) then
		self.OldKingsCount = count
		z:SendCommMessage("GROUP", "SYMBOLCOUNT", count)
		if (ZOMGBlessingsManager) then
			-- Group addon messages do not come to ourself:
			ZOMGBlessingsManager:OnReceiveSymbolCount(UnitName("player"), count)
		end
		if (ZOMGBlessingsPP) then
			-- PallyPower symbol count send
			ZOMGBlessingsPP:SendSymCount()
		end
	end
end

-- ValidateTemplate
function zb:ValidateTemplate(template, tell)
	if (template) then
		local any
		for className,buff in pairs(template) do
			local single,class = z:GetBlessingFromType(buff)
			if (single) then
				if (not IsSpellInRange(single, "player")) then
					if (buff == "BOK") then
						newBuff = "BOM"
					else
						newBuff = "BOS"
					end
					local newSingle = z:GetBlessingFromType(newBuff)
					if (not IsSpellInRange(newSingle, "player")) then	-- Is only <no value> if it doesn't exist, else it's 1 or 0
						newSingle = nil
					end
					if (not any) then
						any = true
						if (tell) then
							self:Print(L["You can no longer do certain buffs as defined in your template, these have been replaced."])
						end
					end
					if (tell) then
						if (newBuff) then
							self:Print(L["Replaced %s with %s"], z:ColourBlessing(buff), z:ColourBlessing(newBuff))
						else
							self:Print(L["Removed %s"], z:ColourBlessing(buff))
						end
					end

					template[className] = newBuff
				end
			end
		end
		if (any) then
			z:CheckForChange(self)
		end
	end
end

-- SPELLS_CHANGED
function zb:SPELLS_CHANGED()
	clickList = nil
	self:ValidateTemplate(template, true)
	z:CheckForChange(self)
	if (not z.zoneFlag) then
		z:SendCommMessage("GROUP", "SPELLS_CHANGED")
	end
end

-- TooltipOnClickException
function zb:TooltipOnClickException(name)
	if (name) then
		if (IsShiftKeyDown()) then
			z:Log("bless", nil, "exception", UnitName("player"), name, template[name])
			self:ModifyTemplate(name, nil)
		else
			local t = template[name]
			if (not clickList) then
				clickList = {}
				for k,v in pairs(z.blessings) do
					if (v.class and IsSpellInRange(k, "player")) then
						tinsert(clickList, v.type)
					end
				end
			end

			local index = 1
			for i = 1,#clickList do
				if (clickList[i] == template[name]) then
					index = i
					break
				end
			end

			local newType
			for i = 1, 10 do
				if (index == #clickList) then
					newType = clickList[1]
				else
					newType = clickList[index + 1]
				end
				
				local single = z:GetBlessingFromType(newType)
				if (IsSpellInRange(single, "player")) then
					break
				end
			end

			z:Log("bless", nil, "change", UnitName("player"), name, template[name], newType)

			self:ModifyTemplate(name, newType)
		end

		z:CheckForChange(self)
		z:UpdateCellSpells()
	end
end

-- TooltipUpdate
function zb:TooltipUpdate(cat)
	if (template) then
		cat:AddLine('text', " ")
		cat:AddLine(
			"text", L["Blessings Template: "].."|cFFFFFFFF"..(((zb.db.char.selectedTemplate == "-" and L["Blessings Manager"]) or zb.db.char.selectedTemplate) or L["none"]),
			"text2", (template and template.modified and "|cFFFF4040"..L["(modified)"].."|r") or ""
		)

		for i = 1,#classOrder do
			local c = classOrder[i]
			local blessing = template[c]
			cat:AddLine(
				"text", z:ColourClass(c),
				"text2", z:ColourBlessing(blessing),
				"func", "TooltipOnClickException",
				"arg1", self,
				"arg2", c
			)
		end

		local any
		for k,v in pairs(template) do
			if (k ~= "default" and k ~= "modified" and k ~= "state" and not classIndex[k]) then
				local unit = roster:GetUnitObjectFromName(k)
				if (unit) then		-- Only show exceptions for people in group
					if (not any) then
						any = true
						cat:AddLine('text', " ")
						cat:AddLine(
							"text", L["Exceptions:"]
						)
					end

					cat:AddLine(
						"text", z:ColourUnitByName(k),
						"text2", z:ColourBlessing(v),
						"func", "TooltipOnClickException",
						"arg1", self,
						"arg2", k
					)
				end
			end
		end
	end
end

-- OnModuleInitialize
function zb:OnModuleInitialize()
	playerClass = select(2, UnitClass("player"))
	if (playerClass ~= "PALADIN") then
		return
	end

	self.db = z:AcquireDBNamespace("Blessings")
	z:RegisterDefaults("Blessings", "char", {
		single = 1,			-- 1 minute
		greater = 2,		-- 2 minutes
		min = 1,			-- At least N of class needing buff before we use class version
		solo = 1,			-- Use group blessings when solo
		party = 1,			-- Use group blessings when in party
		raid = 1,			-- Use group blessings when in raid
		icons = false,		-- Show exception icons in-combat?
		iconscale = 1,		-- Scale for exception icons in-combat
		iconanchor = "LEFT",
		iconfade = 0.3,		-- How much to fade the icons when they're not needing a rebuff
		templates = DefaultTemplates(),
		defaultTemplate = L["5-Man"],
		reagents = {},
	} )
	z:RegisterChatCommand({"/zomgb", "/zomgbless", "/zomgblessing", "/zomgblessings"}, self.options)
	self.OnMenuRequest = self.options
	z.options.args.ZOMGBlessings = self.options

	z:RegisterSetClickSpells(self, function(self, cell)
		local t = zb.db.char.templates.current
		local partyid = cell:GetAttribute("unit")
		local unit = partyid and roster:GetUnitObjectFromUnit(partyid)
		if (unit) then
			local need = t[unit.name]
			local singleMod, singleButton = z:GetActionClick("singleblessing")
			local greaterMod, greaterButton = z:GetActionClick("greaterblessing")

			if (need) then
				z:SetACellSpell(cell, singleMod, singleButton, z:GetBlessingFromType(need))
				z:SetACellSpell(cell, greaterMod, greaterButton, z:GetBlessingFromType(need))
				return
			else
				need = t[unit.class]
				if (need) then
					z:SetACellSpell(cell, singleMod, singleButton, z:GetBlessingFromType(need))
					z:SetACellSpell(cell, greaterMod, greaterButton, select(2, z:GetBlessingFromType(need)))
					return
				end
			end
		end

		z:ClearClickSpells(cell)
	end)

	z.OnCommReceive.GIVETEMPLATE = function(self, prefix, sender, channel, newTemplate, quiet, playerRequested)
		local senderUnit = roster:GetUnitObjectFromName(sender)
		if (senderUnit.class == "PALADIN" or senderUnit.rank > 0) then
			if (not quiet) then
				zb:Print(L["Received Blessings Manager template from %s"], z:ColourUnitByName(sender))
			end

			if (template.modified) then
				zb:SaveTemplate(L["Autosave"])
			end

			template = copy(newTemplate)
			template.modified = nil
			if (not playerRequested) then
				zb.db.char.selectedTemplate = "-"
			end
			zb.db.char.templates.current = template
			zb:MakeTemplateOptions()
			z:CheckForChange(zb)
			z:UpdateCellSpells()

			z:UpdateTooltip()

			zb:OnModifyTemplate(class, type, true)	-- Need to do this so that other non-paladins will see the update in manager
			z:SendCommMessage("WHISPER", sender, "ACK", nil)
		end
	end
	
	z.OnCommReceive.REQUESTTEMPLATE = function(self, prefix, sender, channel)
		if (sender == UnitName("player")) then
			local bm = ZOMGBlessingsManger
			if (bm) then
				bm:OnReceiveTemplate(sender, template)
				bm:OnReceiveSymbolCount(sender, GetItemCount(21177))
				return
			end
		end
		z:SendCommMessage("WHISPER", sender, "TEMPLATE", template)
		z:SendCommMessage("WHISPER", sender, "SYMBOLCOUNT", GetItemCount(21177))	-- symbolOfKings))
	end

	if (not self.db.char.templates.current or not self.db.char.selectedTemplate) then
		if (not self:SelectTemplate(L["5-Man"]) and not self:SelectTemplate(L["DPS"]) and not self:SelectTemplate(L["Kings"])) then
			self.db.char.selectedTemplate = nil
			self.db.char.templates.current = {}
		end
	end
	template = zb.db.char.templates.current

	self.OnModuleInitialize = nil
end

-- OnReceiveTemplatePart
function zb:OnReceiveTemplatePart(sender, name, class, buff)
	if (name == playerName) then
		local unit = roster:GetUnitObjectFromName(sender)
		if (unit.class == "PALADIN" or unit.rank > 0) then
			self.noBroadcast = true
			self:ModifyTemplate(class, buff)
			self.noBroadcast = nil
		end
	end
end

-- OnLogEnabled
function zb:OnLogEnabled()
	ZOMGLog:Register("bless",
		function(code, a, b, c, d)
			if (code == "change") then
				return format(L["Changed %s's template - %s from %s to %s"], z:ColourUnitByName(a), z:ColourClass(b), (c and z:ColourBlessing(c,nil,true)) or "none", (d and z:ColourBlessing(d,nil,true)) or "none")
			elseif (code == "exception") then
				return format(L["Changed %s's exception - %s from %s to %s"], z:ColourUnitByName(a), z:ColourUnitByName(b), (c and z:ColourBlessing(c,nil,true)) or "none", (d and z:ColourBlessing(d,nil,true)) or "none")
			elseif (code == "select") then
				return format(L["Loaded template '%s'"], tostring(a))
			elseif (code == "save") then
				return format(L["Saved template '%s'"], tostring(a))
			end
		end
	)
end

-- OnResetDB
function zb:OnResetDB()
	if (self.db) then
		template = self.db.char.templates.current
	end
end

-- OnModuleEnable
function zb:OnModuleEnable()
	local class = select(2, UnitClass("player"))
	if (class ~= playerClass and class == "PALADIN") then
		self:OnModuleInitialize()
		return
	else
		self.OnModuleInitialize = nil
	end

	self:OnResetDB()

	self.reagents = {
		[R["Symbol of Kings"]] = {100, 20, 1000},		-- Stack size, min, max
		[R["Symbol of Divinity"]] = {5, 1, 50},			-- Stack size, min, max
	}
	z:MakeOptionsReagentList()

	if (select(2, UnitClass("player")) == "PALADIN") then
		self:RegisterBucketEvent("UNIT_AURA", 0.2)				-- We don't care who
		self:RegisterEvent("RosterLib_UnitChanged", "RosterUnitChanged")
		self:RegisterBucketEvent("UNIT_INVENTORY_CHANGED", 0.2)
		self:RegisterBucketEvent("SPELLS_CHANGED", 0.2)
	end
	z:CheckForChange(self)

	if (ZOMGBlessingsPP) then
		ZOMGBlessingsPP:SendSelf()
	end
end

-- OnModuleDisable
function zb:OnModuleDisable()
	z:CheckForChange(self)
	self.reagents = nil
	clickList = nil
end
