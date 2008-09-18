local wow3 = GetBuildInfo() >= "3.0.0"

if (ZOMGBuffTehRaid) then
	z:Print("Installation error, duplicate copy of ZOMGBuffs_BuffTehRaid (Addons\ZOMGBuffs\ZOMGBuffs_BuffTehRaid and Addons\ZOMGBuffs_BuffTehRaid)")
	return
end

local L = LibStub("AceLocale-2.2"):new("ZOMGBuffTehRaid")
local R = LibStub("AceLocale-2.2"):new("ZOMGReagents")
local SM = LibStub("LibSharedMedia-3.0")
local playerClass
local template

local z = ZOMGBuffs
local zg = z:NewModule("ZOMGBuffTehRaid")
ZOMGBuffTehRaid = zg

z:CheckVersion("$Revision: 81802 $")

local new, del, deepDel, copy = z.new, z.del, z.deepDel, z.copy
local InCombatLockdown	= InCombatLockdown
local IsUsableSpell		= IsUsableSpell
local GetSpellCooldown	= GetSpellCooldown
local GetSpellInfo		= GetSpellInfo
local UnitBuff			= UnitBuff
local UnitCanAssist		= UnitCanAssist
local UnitClass			= UnitClass
local UnitIsConnected	= UnitIsConnected
local UnitInParty		= UnitInParty
local UnitIsPVP			= UnitIsPVP
local UnitInRaid		= UnitInRaid
local UnitIsUnit		= UnitIsUnit
local UnitPowerType		= UnitPowerType

--local kiru = GetSpellInfo(46302)			-- Counts as both STA and INT

local function getOption(k)
	return zg.db.char[k]
end

local function setOption(k, v, update)
	if (not v or v == 0) then
		zg.db.char[k] = nil
	else
		zg.db.char[k] = v
	end
	if (update) then
		z:CheckForChange(zg)
	end
end

local function getPrelude(k)
	return zg.db.char.rebuff[k] or 0
end

local function setPrelude(k, v)
	if (not v or v == 0) then
		zg.db.char.rebuff[k] = nil
	else
		zg.db.char.rebuff[k] = v
	end
	z:CheckForChange(zg)
end

do
	local function trackerDisabled()
		return not zg.db.char.tracker
	end
	
	zg.consoleCmd = "ZOMGBuffTehRaid"
	zg.options = {
		type = 'group',
		order = 2,
		name = "|cFFFF8080Z|cFFFFFF80O|cFF80FF80M|cFF8080FFG|cFFFFFFFFBuffTehRaid|r",
		desc = L["Group Buff Configuration"],
		handler = zg,
		args = {
			groups = {
				type = 'group',
				name = L["Groups"],
				desc = L["Select the groups to buff"],
				order = 5,
				hidden = function() return not zg:IsModuleActive() or not zg:HasAnyNonExclusiveBuffs() end,
				args = {
					auto = {
						type = 'toggle',
						name = L["Auto-Assign"],
						desc = L["Auto assign sensible group assignment based the order of your name alphabilically compared to others of your class. All going well, and all using ZOMGBuffs and everyone should end up with different assignments without need for discussion"],
						get = getOption,
						set = function(k,v) setOption(k,v) zg:AutoGroupAssignment() end,
						passValue = "autogroups",
						order = 1,
					},
					space = {
						type = 'header',
						name = " ",
						order = 2,
					},
				},
			},
			template = {
				type = 'group',
				name = L["Templates"],
				desc = L["Template configuration"],
				order = 50,
				hidden = function() return not zg:IsModuleActive() end,
				args = {
				}
			},
			spacer = {
				type = 'header',
				name = " ",
				hidden = function() return not zg:IsModuleActive() end,
				order = 51,
			},
			tracker = {
				type = 'group',
				name = L["Tracker"],
				desc = L["Tracker Icon for single target exclusive buffs"],
				hidden = function() return not zg:IsModuleActive() end,
				order = 100,
				args = {
					tracker = {
						type = 'toggle',
						name = L["Enable"],
						desc = L["Create a tracking icon for certain exclusive spells (Earth Shield, Fear Ward). Note that the icon can always display the correct status of the spell, but if you change targets in combat then the click action will be to the player who it was last set to before entering combat"],
						get = getOption,
						set = setOption,
						passValue = "tracker",
						order = 1,
					},
					sound = {
						type = 'text',
						name = L["Sound"],
						desc = L["Select a soundfile to play when player's tracked buff expires"],
						get = getOption,
						set = function(k,v)
							setOption(k,v)
							PlaySoundFile(SM:Fetch("sound", v))
						end,
						validate = SM:List("sound"),
						disabled = function() return not SM or not zg.db.char.tracker end,
						passValue = "tracksound",
						order = 20,
					},
					spacer = {
						type = 'header',
						name = " ",
						order = 100,
					},
					keybinding = {
						type = 'text',
						name = L["Key-Binding"],
						desc = L["Define the key used for auto buffing from Spell Tracker (FIRST icon only)"],
						validate = "keybinding",
						get = getOption,
						set = function(v,n)
							if (zg.db.char.keybinding) then
								SetBinding(zg.db.char.keybinding, nil)
							end
							zg.db.char.keybinding = n
							zg:SetTrackerKeyBindings()
						end,
						passValue = "keybinding",
						order = 101,
					},
					scale = {
						type = 'range',
						name = L["Scale"],
						desc = L["Adjust the scale of the tracking icon"],
						func = timeFunc,
						get = getOption,
						set = function(k,v)
							setOption(k,v)
							if (zg.trackIcon) then
								zg.trackIcon:SetPosition()
							end
						end,
						disabled = trackerDisabled,
						passValue = "trackerscale",
						min = 0,
						max = 2,
						isPercent = true,
						step = 0.05,
						order = 150,
					},
					reset = {
						type = 'execute',
						name = L["Reset"],
						desc = L["Reset the position of the tracker icon"],
						order = 200,
						disabled = trackerDisabled,
						func = function() zg.db.char.postracker = nil end,
					}
				}
			},
			behaviour = {
				type = 'group',
				name = L["Behaviour"],
				desc = L["Group buffing behaviour"],
				order = 201,
				hidden = function() return not zg:IsModuleActive() end,
				args = {
					groupcast = {
						type = 'range',
						name = L["Minimum Group"],
						desc = L["How many players of a group must need a buff before the group version is cast"],
						get = getOption,
						set = function(k,v) setOption(k,v,true) end,
						passValue = "groupcast",
						order = 99,
						min = 1,
						max = 5,
						step = 1,
					},
					rebuff = {
						type = 'range',
						name = L["Expiry Prelude"],
						desc = L["Default rebuff prelude for all group buffs"],
						func = timeFunc,
						order = 2,
						get = getPrelude,
						set = setPrelude,
						passValue = "default",
						min = 0,
						max = 15 * 60,
						step = 5,
						bigStep = 60,
						order = 100,
					},
				},
			},
		}
	}
end

do
	local disfunc = function() return zg.db.char.autogroups end
	local getG = function(i) return zg.db.char.groups[i] end
	local setG = function(i,n) zg.db.char.groups[i] = n and true or nil z:CheckForChange(zg) end
	local args = zg.options.args.groups.args
	for i = 1,8 do
		args[i] = {
			type = 'toggle',
			name = format(L["Group %d"], i),
			desc = L["Enable buffing of this group"],
			order = i + 10,
			get = getG,
			set = setG,
			disabled = disfunc,
			passValue = i,
		}
	end
end

local function getOption(v)
	return zg.db.char[v]
end

local function setOption(v, n)
	zg.db.char[v] = n
end

-- ColourSpellFromKey(key)
local function ColourSpellFromKey(key)
	local name = key.name or key.list[1]
	local colour = z:HexColour(unpack(key.colour or {1, 1, 1}))
	return format("%s%s|r", colour, name), colour
end

-- ToggleKeyType
local function ToggleKeyType(keytype, onoff)
	if (onoff == nil) then
		onoff = not template[keytype]
	end

	if (onoff) then
		local dup = zg.buffs[keytype].dup
		if (dup) then
			for j,z in pairs(zg.buffs) do
				if (z.dup == dup) then
					zg:ModifyTemplate(j, nil)
				end
			end
		end

		zg:ModifyTemplate(keytype, true)
		z:SetupForSpell()
		zg:CheckBuffs()
		if (not z:IsSpellReady()) then
			z:RequestSpells()
		end
	else
		zg:ModifyTemplate(keytype, nil)
		z:CheckForChange(zg)
	end
end

-- OnModifyTemplate
function zg:ExclusiveTarget(key)
	if (template[key]) then
		local buff = self.buffs[key]
		if (buff and buff.exclusive) then
			local list = template.limited and template.limited[key]
			if (list) then
				return (next(list))
			end
		end
	end
end

-- OnModifyTemplate
function zg:OnModifyTemplate(key, value)
	local buff = self.buffs[key]
	if (buff) then
		if (buff.limited) then
			if (value) then
				if (buff.onEnable) then
					buff.onEnable()
				end

				self:RegisterTickColumn(key)

				if (not template.limited or not template.limited[key]) then
					if (not template.limited) then
						template.limited = new()
					end
					if (not template.limited[key]) then
						template.limited[key] = new()
					end

					if (buff.exclusive) then
						if (not buff.notself) then
							template.limited[key][UnitName("player")] = true
						end
					else
						for unit, unitname, unitclass, subgroup, index in z:IterateRoster() do
							template.limited[key][unitname] = true
						end
					end
				end

				if (buff.exclusive) then
					if (template.limited and template.limited[key]) then
						local name = next(template.limited[key])
						if (name) then
							if (UnitInParty(name) or UnitInRaid(name)) then
								self:AddSpellTracker(key, name)
							end
						end
					end
				end
			else
				self:UnregisterTickColumn(key)
				self:StopSpellTracker(key)
			end
		end
	end
end

-- SetMenu
function zg:MakeSpellOptions()
	if (self.options.args.singlespells or self.options.args.groupspells) then
		return
	end

	local function getLearnable(k)
		return not zg.db.char.notlearnable or not zg.db.char.notlearnable[k]
	end
	local function setLearnable(k, v)
		if (v == false) then
			if (not zg.db.char.notlearnable) then
				zg.db.char.notlearnable = {}
			end
			zg.db.char.notlearnable[k] = true
		else
			if (zg.db.char.notlearnable) then
				zg.db.char.notlearnable[k] = nil
				-- Don't nil this array, else next time we startup the defaults will be reset from the noauto values
			end
		end
	end
	
	local groupArgs, singleArgs

	local list = self:SortedBuffList()
	for i,key in ipairs(list) do
		local info = self.buffs[key]
		if (GetSpellInfo(info.list[1])) then		-- GetSpellCooldown(info.list[1])) then
			local name = info.name or info.list[1]
			local cName = ColourSpellFromKey(info)
			local menu = {
				type = "group",
				name = cName,
				desc = cName,
				order = i,
				isChecked = function(k) return template[key] end,
				onClick = ToggleKeyType,
				passValue = key,
				args = {
					header = {
						type = "header",
						name = cName,
						order = 1,
					},
					rebuff = {
						type = "range",
						name = L["Expiry Prelude"],
						desc = format(L["Rebuff prelude for %s (0=Module default)"], cName),
						func = timeFunc,
						order = 2,
						get = getPrelude,
						set = setPrelude,
						passValue = key,
						min = 0,
						max = 30 * 60,
						step = 15,
						bigStep = 60,
						order = 2,
					},
				}
			}

			if (info.limited) then
				menu.args.nolearn = {
					type = "toggle",
					name = L["Learnable"],
					desc = L["Remember this spell when it's cast manually?"],
					order = 3,
					get = getLearnable,
					set = setLearnable,
					passValue = key,
				}

				if (not singleArgs) then
					local menu = {
						type = 'group',
						name = L["Single Spells"],
						desc = L["Single spell configuration"],
						order = 2,
						args = {
							spacer = {
								type = 'header',
								name = " ",
								order = 999,
							},
							reset = {
								type = 'toggle',
								name = L["Reset on Clear"],
								desc = L["If noone is selected for this buff when you disable it, then the next time it is enabled, everyone will default to ON. If disabled, the last settings will be remembered"],
								get = getOption,
								set = setOption,
								passValue = "resetOnClear",
								order = 1000,
							}
						}
					}
					self.options.args.singlespells = menu
					singleArgs = menu.args
				end

				singleArgs[name] = menu
			else
				if (not groupArgs) then
					local menu = {
						type = 'group',
						name = L["Group Spells"],
						desc = L["Group spell configuration"],
						order = 1,
						args = {
						}
					}
					
					self.options.args.groupspells = menu
					groupArgs = menu.args
				end

				groupArgs[name] = menu
			end
		end
	end
	del(list)
end

-- TickInitForTemplate
function zg:TickInitForTemplate()
	self:MakeTickLookup()

	for Type,buff in pairs(self.buffs) do
		if (buff.limited) then
			if (template[Type]) then
				if (buff.onEnable) then
					buff.onEnable()
				end

				self:RegisterTickColumn(Type)

				if (buff.exclusive) then
					if (template.limited and template.limited[Type]) then
						local name = next(template.limited[Type])
						if (name) then
							if (not buff.notself or not UnitIsUnit(name, "player")) then
								if (UnitInParty(name) or UnitInRaid(name)) then
									self:AddSpellTracker(Type, name)
								end
							end
						end
					end
				end
			else
				self:UnregisterTickColumn(Type)
				self:StopSpellTracker(Type)
			end
		end
	end

	if (z.icon and z.members) then
		z:DrawGroupNumbers()
		z:DrawAllCells()
	end
end

-- SelectTemplate
function zg:OnSelectTemplate(templateName)
	template = self.db.char.templates.current
	self:TickInitForTemplate()
end

-- GetBuffedMembers
function zg:GetBuffedMembers()
	local temp = new()
	local totals = new(0, 0, 0, 0, 0, 0, 0, 0)
	local groupTotal = new(0, 0, 0, 0, 0, 0, 0, 0)
	local groupPresent = new(0, 0, 0, 0, 0, 0, 0, 0)
	local skipGroups = new()
	local dbGroups = self.db.char.groups
	local minTimeLeft
	local totalMembers, totalPresent = 0, 0
	local anyBlacklisted
	local notInRaid = not UnitInRaid("player")

	for unitid, unitname, unitclass, grp, index in z:IterateRoster() do
		anyBlacklisted = anyBlacklisted or z:IsBlacklisted(unitname)
		totalMembers = totalMembers + 1
		groupTotal[grp] = groupTotal[grp] + 1

		if (dbGroups[grp] or notInRaid) then
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
				local foundBuffs
				local manaUser = UnitPowerType(unitid) == 0
				groupPresent[grp] = groupPresent[grp] + 1
				totalPresent = totalPresent + 1
				
				if (not manaUser) then
					foundBuffs = new()
				end

				totals[grp] = totals[grp] + 1
				for i = 1,40 do
					local name, rank, buff, count, _, maxDuration, endTime, untilCancelled = z:UnitBuff(unitid, i)
					if (not name) then
						break
					end
					
					local buff = self.lookup[name]
					--if (not buff) then
					--	if (name == kiru) then		-- K'iru's Song of Victory overrides both STA & INT
					--		if (playerClass == "PRIEST") then
					--			buff = self.buffs.STA
					--		elseif (playerClass == "MAGE") then
					--			buff = self.buffs.INT
					--		end
					--	end
					--end
					if (buff) then
						local dur = endTime and (endTime - GetTime())
						if (template[buff.type]) then
							if (not manaUser) then
								foundBuffs[buff.type] = true
							end

							local requiredTimeLeft = (self.db.char.rebuff and self.db.char.rebuff[buff.type]) or self.db.char.rebuff.default
							local needsBuff = not buff.onlyManaUsers or manaUser
							if (not needsBuff or (not requiredTimeLeft or not dur or dur > requiredTimeLeft)) then
								if (not temp[buff.type]) then
									temp[buff.type] = new(0, 0, 0, 0, 0, 0, 0, 0)
								end
								temp[buff.type][grp] = temp[buff.type][grp] + 1
							end

							if (needsBuff and dur and (not minTimeLeft or dur - requiredTimeLeft < minTimeLeft)) then
								minTimeLeft = dur - requiredTimeLeft
							end
						end
					end
				end

				if (not manaUser) then
					for key,info in pairs(self.buffs) do
						if (info.onlyManaUsers and not foundBuffs[key]) then
							if (not temp[key]) then
								temp[key] = new(0, 0, 0, 0, 0, 0, 0, 0)
							end
							temp[key][grp] = temp[key][grp] + 1
						end
					end
					del(foundBuffs)
				end

			elseif (absent) then
				totalPresent = totalPresent + 1
				groupPresent[grp] = groupPresent[grp] + 1
				totals[grp] = totals[grp] + 1
				for code,info in pairs(self.buffs) do
					if (not temp[code]) then
						temp[code] = new(0, 0, 0, 0, 0, 0, 0, 0)
					end
					temp[code][grp] = temp[code][grp] + 1
				end
			end
		end
	end

	z.waitingForClass = nil
	if (z.db.profile.waitforclass and self.groupBuffer) then
		for i = 1,8 do
			if (groupTotal[i] > 0 and groupPresent[i] < groupTotal[i]) then
				z.waitingForClass = (z.waitingForClass or "") .. ((z.waitingForClass and ", ") or "") .. z:ColourGroup(i)
				skipGroups[i] = true
			end
		end
	end

	del(groupPresent)
	del(groupTotal)

	return temp, totals, minTimeLeft, totalPresent / totalMembers, skipGroups, anyBlacklisted
end

-- FindUnitInRangeMissing
function zg:FindUnitInRangeMissing(group, typ)
	local t = self.buffs[typ]
	if (not t) then
		error(format("Unrecognised type %q", tostring(typ)), 2)
	end
	local buffEveryone = not t.onlyManaUsers
	local list = t.list
	local rangeCheckSpell = list[1]
	local limitedPeople = t.limited and template.limited and template.limited[typ]

	local requiredTimeLeft = (self.db.char.rebuff and self.db.char.rebuff[typ]) or self.db.char.rebuff.default

	for unitid, unitname, unitclass, subgroup, index in z:IterateRoster() do
		if (buffEveryone or UnitPowerType(unitid) == 0) then
			if (not t.limited or (limitedPeople and limitedPeople[unitname])) then
				if (subgroup == group and not z:IsBlacklisted(unitname)) then
					if (UnitIsConnected(unitid) and UnitCanAssist("player", unitid) and IsSpellInRange(rangeCheckSpell, unitid) == 1 and ((not z.db.profile.skippvp or not UnitIsPVP(unitid)) or UnitIsPVP("player"))) then
						local got
						for i = 1,40 do
							local name, rank, buff, count, _, max, endTime = z:UnitBuff(unitid, i)
							if (not name) then
								break
							end

							local buff = self.lookup[name]
							--if (not buff) then
							--	if (name == kiru) then		-- K'iru's Song of Victory overrides both STA & INT
							--		if (playerClass == "PRIEST") then
							--			buff = self.buffs.STA
							--		elseif (playerClass == "MAGE") then
							--			buff = self.buffs.INT
							--		end
							--	end
							--end
							if (buff and buff.type == typ) then
								local dur = endTime and (endTime - GetTime())
								if (dur and dur < requiredTimeLeft) then
									return unitid
								end
								got = true
								break
							end
						end

						if (not got) then
							return unitid
						end
					end
				end
			end
		end
	end
end

-- CheckBuffs
function zg:CheckBuffs()
	if (not self.db or not template or not z:CanCheckBuffs()) then
		return
	end

	-- First build a list of total group counts, and total numbers of players who have each buff in each group
	local temp, totals, minTimeLeft, percentPresent, skipGroups, anyBlacklisted = self:GetBuffedMembers()
	local skipClassBuffs = z.db.profile.singlesAlways or (z.db.profile.singlesInBG and select(2, IsInInstance()) == "pvp") or (z.db.profile.singlesInArena and select(2, IsInInstance()) == "arena")
	local db = self.db.char

	if (z.db.profile.waitforraid > 0 and not skipClassBuffs and self.groupBuffer) then
		-- See if enough of raid present
		if (percentPresent < z.db.profile.waitforraid) then	-- Wait for % of raid before buffing
			z.waitingForRaid = floor(percentPresent * 100)
			self:ScheduleEvent("ZOMGBuffTehRaid_CheckBuffs", self.CheckBuffs, 5, self)
			return
		end
	end
	z.waitingForRaid = nil

	-- Now go through this and find anything we need to buff
	local dbGroups = db.groups
	local notInRaid = GetNumRaidMembers() == 0
	local any
	for i = 1,8 do								-- i == group
		local canBuffGroup = notInRaid or (dbGroups[i] and not skipGroups[i])

		local players = totals[i]
		if (players > 0) then
			for k,v in pairs(template) do			-- k = spellType (INT, STA etc.), v = buff data for that type
				if (k ~= "modified" and k ~= "state" and k ~= "limited") then
					local typeSpec = self.buffs[k]
					if (typeSpec and (canBuffGroup or not typeSpec.group)) then
						local spell = typeSpec.list[1]
						local start, dur = GetSpellCooldown(spell)
						local now, later = IsUsableSpell(spell)
						if (now and (start == 0 or GetTime() - 0.5 > start + dur)) then
							local gotBuff = (temp[k] and temp[k][i]) or 0
							if (not gotBuff or gotBuff < players) then
								local missingBuff = players - gotBuff
	
								local unit = self:FindUnitInRangeMissing(i, k)
								if (unit) then
									local buffSpec = typeSpec.list
									local t1, t2
									if (buffSpec[2]) then
										t1, t2 = IsUsableSpell(buffSpec[2])
									end
									
									local colour = typeSpec.colour and z:HexColour(unpack(typeSpec.colour))
									if (skipClassBuffs or (missingBuff < db.groupcast or not (t1 or t2))) then
										-- Do single buff
										z:Notice(format(L["%s needs %s"], z:ColourUnit(unit), z:LinkSpell(buffSpec[1], colour, true, z.db.profile.short and typeSpec.name)), "buffreminder")
										z:SetupForSpell(unit, buffSpec[1], self)
										any = true
										break
									else
										-- Do group buff
										z:Notice(format(L["%s needs %s"], z:ColourGroup(i), z:LinkSpell(buffSpec[2], colour, true, z.db.profile.short and typeSpec.name)), "buffreminder")
										z:SetupForSpell(unit, buffSpec[2], self)
										any = true
										break
									end
								end
							end
						else
							if (not now) then
								minTimeLeft = 10		-- Check again in 10 secs, not enough mana atm
							else
								-- Set min time left to cooldown end for this spell
								minTimeLeft = min((start + dur) - GetTime(), minTimeLeft or 0)
							end
						end
					end
				end
			end
			if (any) then
				break
			end
		end
	end

	if (not any and z.db.profile.buffpets) then
		-- Catch any pets that missed the group buffing
		for unitid, unitname, unitclass, subgroup, index in z:IterateRoster(true) do
			if (unitclass == "PET" and UnitIsVisible(unitid) and UnitCanAssist("player", unitid) and IsSpellInRange(rangeCheckSpell, unitid)) then
 				if (db.groups[subgroup]) then
 					local manaUser = UnitPowerType(unitid) == 0
					for i = 1,40 do
						local name, rank, buff, count, _, max, endTime = z:UnitBuff(unitid, i)
						if (not name) then
							break
						end

						local buff = self.lookup[name]
						if (buff) then
							local dur = endTime and (endTime - GetTime())
							if (template[buff.type]) then
								local requiredTimeLeft = (db.rebuff and db.rebuff[buff.type]) or db.rebuff.default
								if ((not requiredTimeLeft or not dur or dur > requiredTimeLeft) and (buff.onlyManaUsers and not manaUser)) then
									local colour = buff.colour and z:HexColour(unpack(buff.colour))
									z:Notice(format(L["%s needs %s"], z:ColourUnit(unitid), z:LinkSpell(buff.list[1], colour, true, z.db.profile.short and buff.name)), "buffreminder")
									z:SetupForSpell(unit, buff.list[1], self)
									any = true
									break
								end

								if (dur and (not minTimeLeft or dur - requiredTimeLeft < minTimeLeft)) then
									minTimeLeft = dur - requiredTimeLeft
								end
							end
						end
					end
					if (any) then
						break
					end
				end
			end
		end
	end

	self:CancelScheduledEvent("ZOMGBuffTehRaid_CheckBuffs")
	if (anyBlacklisted) then
		minTimeLeft = 1.5
	end
	if (any) then
		z.waitingForRaid = nil
		z.waitingForClass = nil
	else
		if (z.waitingForClass) then
			self:ScheduleEvent("ZOMGBuffTehRaid_CheckBuffs", self.CheckBuffs, 5, self)
		else
			self:ScheduleEvent("ZOMGBuffTehRaid_CheckBuffs", self.CheckBuffs, minTimeLeft or 60, self)
		end
	end

	deepDel(temp)
	deepDel(groups)
	del(totals)
	del(skipGroups)
end

-- UNIT_AURA
function zg:UNIT_AURA(unit)
	if (not InCombatLockdown()) then
		if (UnitInParty(unit) or UnitInRaid(unit)) then
			local spell = z.icon and z.icon:GetAttribute("spell")
			if (spell) then
				local buff = self.lookup[spell]
				if (buff) then
					local queuedUnit = z.icon and z.icon:GetAttribute("unit")
					if (queuedUnit) then
						local match
						if (buff.group) then
							match = z:GetGroupNumber(queuedUnit) == z:GetGroupNumber(unit)
						else
							match = UnitIsUnit(unit, queuedUnit)
						end

						if (match) then
							local found
							for i = 1,40 do
								local name = UnitBuff(unitid, i)
								if (not name) then
									break
								end

								local buff2 = self.lookup[name]
								if (buff2) then
									if (buff2.type == buff.type) then
										found = true
									end
								end
							end

							if (found) then
								-- They have just been buffed with what we have queued, so clear this queue item and re-check
								z:SetupForSpell()
								self:CheckBuffs()
							end
						end
					end
				end
			end
		end
	end
end

-- GetActions
function zg:GetActions()
	if (self.buffs and not self.actions) then
		self.actions = {}

		local list = self:SortedBuffList()
		for i,key in ipairs(list) do
			local buff = self.buffs[key]

			if (buff.list and GetSpellInfo(buff.list[1])) then		-- GetSpellCooldown(buff.list[1])) then
				if (buff.keycode) then
					if (buff.group and buff.list[2]) then
						for j = 1,#buff.list do
							tinsert(self.actions, {name = buff.list[j], type = buff.keycode..j})
						end
					else
						tinsert(self.actions, {name = buff.list[1], type = buff.keycode})
					end
				end
			end
		end

		del(list)
	end
	return self.actions
end

-- ResetActions
function zg:ResetActions()
	self.actions = nil
end

-- RebuffQuery
function zg:RebuffQuery(unit)
	if (self.db and template and UnitIsConnected(unit) and UnitCanAssist("player", unit) and not UnitIsDeadOrGhost(unit)) then
		local got = new()

		for i = 1,40 do
			local name = UnitBuff(unit, i)
			if (not name) then
				break
			end

			local info = self.lookup[name]
			if (info) then
				got[info.type] = true
			end
		end

		local manaUser = UnitPowerType(unit) == 0
		local limited = template.limited
		for key,info in pairs(self.buffs) do
			if (template[key] and not got[key]) then
				if (not info.onlyManaUsers or manaUser) then
					if (info.limited) then
						if (limited and limited[key] and limited[key][UnitName(unit)]) then
							del(got)
							return true
						end
					else
						del(got)
						return true
					end
				end
			end
		end

		del(got)
	end

	return
end

-- OnModuleInitialize
function zg:OnModuleInitialize()
	playerClass = select(2, UnitClass("player"))

	if (playerClass == "PRIEST") then
		local spirit = GetSpellInfo(39234)
		local t1, t2 = IsUsableSpell(spirit)
		self.buffs = {
			STA = {
				o = 1,
				name = SPELL_STAT3_NAME,
				ids = {25389, 25392},				-- Power Word: Fortitude, Prayer of Fortitude
				group = true,
				reagents = {nil, {
						[1] = R["Holy Candle"],
						[2] = R["Sacred Candle"],
						[3] = R["Sacred Candle"],
					},
				},
				required = true,
				colour = {0.7, 0.7, 1},
				keycode = "stamina",
			},
			SPIRIT = {
				o = 2,
				name = SPELL_STAT5_NAME,
				ids = {25312, 32999},				-- Divine Spirit, Prayer of Spirit
				group = true,
				reagents = {nil, R["Sacred Candle"]},
				required = t1 or t2,
				onlyManaUsers = true,
				colour = {0.3, 0.5, 1},
				keycode = "spirit",
			},
			SHADOWPROT = {
				o = 3,
				ids = {25433, 39374},				-- Shadow Protection, Prayer of Shadow Protection
				group = true,
				reagents = {nil, R["Sacred Candle"]},
				colour = {0.7, 0.2, 0.7},
				keycode = "shadowprot",
			},
			FEARWARD = {
				o = 4,
				ids = {6346},						-- Fear Ward
				colour = {1, 0.7, 0.3},
				limited = true,						-- Allow limited targets config
				exclusive = true,					-- Can only be cast on 1 target
				keycode = "fearward",
			}
		}
		self.reagents = {
			[R["Holy Candle"]] = {0, 1, 500, maxLevel = 59},
			[R["Sacred Candle"]] = {0, 1, 500},
		}

	elseif (playerClass == "DRUID") then
		self.buffs = {
			MARK = {
				o = 1,
				name = L["Mark"],
				ids = {26990, 26991},				-- Mark of the Wild, Gift of the Wild
				group = true,
				reagents = {nil, {
						[1] = R["Wild Berries"],
						[2] = R["Wild Thornroot"],
						[3] = R["Wild Quillvine"],
					},
				},
				required = true,
				colour = {0.9, 0.5, 0.9},
				keycode = "mark",
			},
			THORNS = {
				o = 2,
				ids = {26992},						-- Thorns
				colour = {0.7, 0.7, 0.3},
				limited = true,						-- Allow limited targets config
				keycode = "thorns",
			}
		}
		self.reagents = {
			[R["Wild Berries"]] = {0, 1, 500},
			[R["Wild Thornroot"]] = {0, 1, 500},
			[R["Wild Quillvine"]] = {0, 1, 500}
		}

	elseif (playerClass == "MAGE") then
		self.buffs = {
			INT = {
				o = 1,
				name = SPELL_STAT4_NAME,
				ids = {27126, 27127},				-- Arcane Intellect, Arcane Brilliance
				group = true,
				reagents = {nil, R["Arcane Powder"]},
				required = true,
				onlyManaUsers = true,
				colour = {0.3, 0.3, 1},
				keycode = "int"
			},
			DAMPEN = {
				o = 2,
				ids = {33944},						-- Dampen Magic
				dup = 1,
				colour = {0.3, 1, 0.8},
				limited = true,						-- Allow limited targets config
				keycode = "dampen",
			},
			AMPLIFY = {
				o = 3,
				ids = {33946},						-- Amplify Magic
				dup = 1,
				colour = {1, 1, 0.25},
				limited = true,						-- Allow limited targets config
				keycode = "amplify",
			}
		}
		self.reagents = {
			[R["Arcane Powder"]] = {(UnitLevel("player") >= 56 and 20) or 0, 1, 500},
		}
	elseif (playerClass == "SHAMAN") then
		self.buffs = {
			EARTHSHIELD = {
				o = 1,
				ids = {32594},						-- Earth Shield
				onEnable = function()
					local zs = ZOMGSelfBuffs
					if (zs) then
						zs:ModifyTemplate((GetSpellInfo(41151)), nil)		-- Lightning Shield
						zs:ModifyTemplate((GetSpellInfo(37432)), nil)		-- Water Shield
					end
				end,
				colour = {0.7, 0.7, 0.2},
				limited = true,						-- Allow limited targets config
				exclusive = true,					-- Can only be cast on 1 target
				stacks = 6,							-- So, we had to hard code this eventually anyway huh..
				keycode = "earthshield",
			},
			WATERWALK = {
				o = 2,
				ids = {546},						-- Water Walking
				reagents = {17058},					-- Fish Oil
				colour = {0.5, 0.5, 1},
				limited = true,						-- Allow limited targets config
				keycode = "water",
			},
			WATERBREATH = {
				o = 2,
				ids = {131},						-- Water Breathing
				reagents = {17057},					-- Shiny Fish Scales
				colour = {0.2, 0.8, 1},
				limited = true,						-- Allow limited targets config
				keycode = "breath",
			}
		}
	
	elseif (playerClass == "WARLOCK") then
		self.buffs = {
			SEEINVIS = {
				o = 1,
				ids = {132},						-- Detect Invisibility
				colour = {0.7, 0.2, 0.2},
				limited = true,						-- Allow limited targets config
				keycode = "seeinvis",
			},
			WATERBREATH = {
				o = 2,
				ids = {5697},						-- Unending Breath
				colour = {0.5, 1, 0.5},
				limited = true,						-- Allow limited targets config
				keycode = "breath",
			}
		}

	elseif (playerClass == "PALADIN") then
		self.buffs = {
			FREEDOM = {
				o = 1,
				ids = {1044},						-- Blessing of Freedom
				colour = {1, 0.8, 0.1},
				limited = true,						-- Allow limited targets config
				exclusive = true,
				keycode = "freedom",
			},
			SACRIFICE = {
				o = 2,
				ids = {wow3 and 6940 or 27148},		-- Blessing of Sacrifice
				colour = {1, 0, 0},
				limited = true,						-- Allow limited targets config
				exclusive = true,
				notself = true,
				keycode = "sacrifice",
			}
		}	
	end

	if (not self.buffs) then
		return
	end

	self.keycodeLookup = del(self.keycodeLookup)
	self.keycodeLookup = new()
	self.spellIcons = new()
	for key,info in pairs(self.buffs) do
		info.list = new()
		for i,id in ipairs(info.ids) do
			local name, _, icon = GetSpellInfo(id)
			if (not name) then
				error("No spell info for SpellID "..id)
			end
			tinsert(info.list, name)
			self.spellIcons[name] = icon
		end
		self.keycodeLookup[info.keycode] = key
	end
	
	z:RegisterSetClickSpells(self, function(self, cell)
		if (zg.actions) then
			for i,action in ipairs(zg.actions) do
				local Mod, button = z:GetActionClick(action.type)
				if (button) then
					local key = self.keycodeLookup[action.type]
					local buff = key and self.buffs[key]
					if (not buff or not buff.notself) then
						z:SetACellSpell(cell, Mod, button, action.name)
					end
				end
			end
		end
	end)

	self.groupBuffer = nil
	local defaultForClass = {Default = {}}
	for k,v in pairs(self.buffs) do
		if (v.group) then
			self.groupBuffer = true
		end
		if (v.required) then
			defaultForClass.Default[k] = true
		end
	end

	self.db = z:AcquireDBNamespace("BuffTehRaid")
	z:RegisterDefaults("BuffTehRaid", "char", {
		reagents = {},
		templates = defaultForClass,
		defaultTemplate = "Default",
		groupcast = 2,
		groups = {true, true, true, true, true, true, true, true},
		autogroups = false,
		rebuff = {
			default = 30,
		},
		resetOnClear = true,
		tracker = true,
		trackerscale = 1,
		tracksound = "Gong",
		notlearnable = {},
	} )
	z:RegisterChatCommand({"/zomgraid", "/zomgbufftehraid"}, zg.options)
	self.OnMenuRequest = self.options
	z.options.args.ZOMGBuffTehRaid = self.options

	self.lookup = {}
	self.required = 0
	for k,v in pairs(self.buffs) do
		v.type = k
		for i,buff in pairs(v.list) do
			self.lookup[buff] = v
		end
	end

	--z.OnCommReceive.AUTOGROUPASSIGNED = function(self, prefix, sender, channel, class, displayList)
	--	if (not zg.db.char.autogroups and class == playerClass) then
	--		if (not zg.autoGroupWarned) then
	--			zg.autoGroupWarned = true
	--			self:Print(L["Warning: %s has auto-assigned themselves to buff groups %s, but you have the Auto Group Assignment option disabled"], z:ColourUnitByName(sender), table.concat(displayList, ", "))
	--		end
	--	end
	--end

	for k,buff in pairs(self.buffs) do
		if (buff.limited) then
			self:RegisterTickHandler(k, self, zg.TickColumnCallback, buff.list[1], buff.ids[1])
		end
	end

	z:RegisterBuffer(self)

	self.OnModuleInitialize = nil
end

-- GetSpellIcon
function zg:GetSpellIcon(spell)
	return self.spellIcons[spell]
end

-- TickColumnCallback
function zg:TickColumnCallback(unit, key, enable)
	local handler = self.tickHandlers[key]
	if (not handler) then
		error(format("No handler for key %q", tostring(key)), 2)
	end
	local column = self.tickColumnLookup[key]
	if (not column) then
		error(format("No column for key %q", tostring(key)), 2)
	end
	if (column) then
		local name = UnitName(unit)
		if (name) then
			if (enable == nil) then
				local list = template.limited and template.limited[key]
				return (list and list[name] and 1) or nil
			else
				if (enable) then
					self:AddLimitedSpell(name, key)
				else
					self:RemoveLimitedSpell(name, key)
				end
			end
		end
	end
end

-- RegisterTickHandler
function zg:RegisterTickHandler(id, Module, Func, spellname, spellid)
	if (not self.tickHandlers) then
		self.tickHandlers = {}
	end
	self.tickHandlers[id] = {module = Module, func = Func, spell = spellname, spellID = spellid}
end

-- RegisterTickColumn
function zg:RegisterTickColumn(key)
	if (not self:IsTickColumnRegistered(key)) then
		if (not self.tickHandlers[key]) then
			error(format("No handler for key %q", tostring(key)), 2)
		end
		if (not self.tickColumns) then
			self.tickColumns = {}
		end
		tinsert(self.tickColumns, key)
		self.anyTickColumns = true

		self:MakeTickLookup()

		if (z.icon and z.members) then
			z:DrawGroupNumbers()
			z:DrawAllCells()
		end
	end
end

-- MakeTickLookup
function zg:MakeTickLookup()
	if (self.tickColumns) then
		del(self.tickColumnLookup)
		self.tickColumnLookup = new()
		for i,key in ipairs(self.tickColumns) do
			self.tickColumnLookup[key] = i
		end
	end
end

-- RegisterTickColumn
function zg:UnregisterTickColumn(key)
	local index = self:IsTickColumnRegistered(key)
	if (index) then
		tremove(self.tickColumns, index)

		if (z.icon and z.members) then
			z:DrawGroupNumbers()
			z:DrawAllCells()
		end
	end
end

-- IsTickColumnRegistered
function zg:IsTickColumnRegistered(id)
	if (self.tickColumns) then
		for i,key in ipairs(self.tickColumns) do
			if (key == id) then
				return i
			end
		end
	end
end

-- tickOnClick
local function tickOnClick(self, button)
	if (not zg.tickColumns) then
		-- Shouldn't be happening
		return
	end
	local index = self:GetID()
	local parent = self:GetParent()
	local unitid = parent:GetAttribute("unit")
	local key = zg.tickColumns[index]
	local handler = zg.tickHandlers[key]
	local buff = zg.buffs[key]
	if (not key) then
		error(format("No key for column %s", tostring(index)))
	end
	if (not handler) then
		error(format("No handler for %q", tostring(key)))
	end
	if (not buff) then
		error(format("No buff for %q", tostring(key)))
	end

	if (buff.notself and UnitIsUnit("player", unitid)) then
		self:SetChecked(nil)
	else
		local enable = self:GetChecked() and true or false
		if (not buff.exclusive and button == "LeftButton" and IsAltKeyDown()) then
			local class = select(2, UnitClass(unitid))
			zg:TickSome(index, function(unit) return select(2, UnitClass(unit)) == class end, enable)	-- Tick all of this class

		elseif (not buff.exclusive and button == "LeftButton" and IsShiftKeyDown()) then
			local group = z:GetGroupNumber(unitid)
			zg:TickSome(index, function(unit)
				local g1 = z:GetGroupNumber(unit)
				return g1 and g1 == group
			end, enable)

		elseif (not buff.exclusive and button == "RightButton") then
			zg:TickSome(index, nil, enable)												-- Tick everyone

		else
			zg:TickOne(index, UnitName(unitid), enable)									-- Tick this one
		end

		z:DrawAllCells()
	end
end

-- tickOnEnter
local function tickOnEnter(self)
	local index = self:GetID()
	local parent = self:GetParent()
	local unitid = parent:GetAttribute("unit")
	local key = zg.tickColumns[index]
	local handler = zg.tickHandlers[key]
	local buff = zg.buffs[key]

	if (not buff.exclusive) then
		local cgroup = z:ColourGroup(z:GetGroupNumber(unitid))
		local cclass = z:ColourClass(select(2, UnitClass(unitid)))
		local done
		for i = 1,20 do
			local help = L:HasTranslation("TICKCLICKHELP"..i) and L["TICKCLICKHELP"..i]
			if (not help) then
				break
			end
			if (not done) then
				done = true
				GameTooltip:SetOwner(self, "ANCHOR_TOP")
				GameTooltip:SetText(format(L["%s on %s"], ColourSpellFromKey(buff), z:ColourUnitByName(UnitName(unitid))))
			end
			help = help:gsub("$class", cclass)
			help = help:gsub("$party", cgroup)
			GameTooltip:AddLine(help)
		end

		if (done) then
			GameTooltip:Show()
		end
	end
end

-- gttOnLeave
local function gttOnLeave()
	GameTooltip:Hide()
end

-- TickOne
function zg:TickOne(index, unitname, enable)
	local key = self.tickColumns[index]
	if (not key) then
		error(format("No key for column %s", tostring(index)), 2)
	end
	local handler = self.tickHandlers[key]
	if (not handler) then
		error(format("No handler for %s", tostring(key)), 2)
	end

	handler.func(handler.module, unitname, key, enable)
end

-- TickSome
function zg:TickSome(index, matchfunc, enable)
	for unitid, unitname, unitclass, subgroup in z:IterateRoster() do
		if (not matchfunc or matchfunc(unitid)) then
			self:TickOne(index, unitname, enable)
		end
	end
end

-- CreateTick
function zg:CreateTick()
	local tick = CreateFrame("CheckButton")
	tick:SetHeight(z.db.char.height)
	tick:SetWidth(z.db.char.height)
	tick:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	tick:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	tick:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD")
	tick:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	tick:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	tick:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	tick:SetScript("OnClick", tickOnClick)
	tick:SetScript("OnEnter", tickOnEnter)
	tick:SetScript("OnLeave", gttOnLeave)

	return tick
end

-- AquireTick
function zg:AquireTick(cell)
	if (not self.freeTicks) then
		self.freeTicks = {}
	end
	local tick = tremove(self.freeTicks, 1)
	if (not tick) then
		tick = self:CreateTick()
	end

	if (not cell.ticks) then
		cell.ticks = {}
	end
	tinsert(cell.ticks, tick)
	tick:SetParent(cell)
	tick:Show()
	tick:SetID(#cell.ticks)
	tick:Enable()

	if (#cell.ticks == 1) then
		tick:SetPoint("LEFT")
	else
		tick:SetPoint("LEFT", cell.ticks[#cell.ticks - 1], "RIGHT")
	end

	return tick
end

-- KillTick
function zg:KillTick(cell)
	local tick = tremove(cell.ticks, #cell.ticks)
	if (tick) then
		tinsert(self.freeTicks, tick)
		tick:Hide()
		tick:SetParent(nil)
	end
end

-- CheckTickColumns
function zg:CheckTickColumns(cell)
	local count = (self.tickColumns and #self.tickColumns) or 0
	-- Add any more we need
	while (not cell.ticks or #cell.ticks < count) do
		local tick = self:AquireTick(cell)
	end
	-- Remove any to be recycled
	while (cell.ticks and #cell.ticks > count) do
		self:KillTick(cell)
	end

	local b = z.buffs[1] and cell.buff and cell.buff[1]
	if (not b and z.classcount.PALADIN > 0) then
		b = cell.palaIcon[1]
	end
	if (b) then
		b:ClearAllPoints()
		if (count == 0) then
			b:SetPoint("TOPLEFT", 0, 0)
		else
			b:SetPoint("TOPLEFT", cell.ticks[count], "TOPRIGHT")
		end
	else
		if (count > 0) then
			cell.bar:ClearAllPoints()
			cell.bar:SetPoint("TOPLEFT", cell.ticks[count], "TOPRIGHT")
			cell.bar:SetPoint("BOTTOMRIGHT")
		end
	end

	if (self.tickColumns) then
		-- Go thru the ticks we have and assign them their values
		local unit = cell:GetAttribute("unit")
		local myself = UnitIsUnit("player", unit)
		local any
		for index,key in ipairs(self.tickColumns) do
			local handler = self.tickHandlers[key]
			if (type(handler) ~= "table" or not handler.func or not handler.module) then
				error(format("No handler for %q", tostring(key)))
			end
			local tick = cell.ticks[index]
			if (myself and self.buffs[key].notself) then
				tick:SetChecked(nil)
				tick:Disable()
			else
				tick:Enable()
				tick:SetChecked(handler.func(handler.module, unit, key))
			end
			any = true
		end

		if (not any) then
			self.tickColumns = del(self.tickColumns)
		end
	end
end

-- CheckTickTitles
function zg:CheckTickTitles(members)
	local topChild = members:GetAttribute("child1")
	if (topChild) then
		local show = topChild:IsShown()

		if (self.tickColumns) then
			for i,key in ipairs(self.tickColumns) do
				local relative = topChild.ticks and topChild.ticks[i]
				if (relative) then
					local handler = self.tickHandlers[key]
					if (not handler) then
						error(format("No handler for %q", tostring(key)))
					end

					if (not members.limitedIcons) then
						members.limitedIcons = {}
					end
					local icons = members.limitedIcons

					local icon = icons[i]
					if (not icon) then
						icon = members:CreateTexture(nil, "BORDER")
						icons[i] = icon
					end
					icon:SetWidth(z.db.char.height)
					icon:SetHeight(z.db.char.height)
					local name, rank, tex = GetSpellInfo(handler.spellID)
					icon:SetTexture(tex)

					icon:ClearAllPoints()
					icon:SetPoint("BOTTOM", relative, "TOP", 0, (self.db.char.border and 3) or 1)
					if show then
						icon:Show()
					else
						icon:Hide()
					end
				end
			end
			if (members.limitedIcons) then
				for i = #self.tickColumns + 1,#members.limitedIcons do
					members.limitedIcons[i]:Hide()
				end
			end
		else
			if (members.limitedIcons) then
				for i,icon in ipairs(members.limitedIcons) do
					icon:Hide()
				end
			end
		end
	end
end

-- HasGroupBuffs
function zg:HasGroupBuffs()
	if (self.buffs) then
		for key,info in pairs(self.buffs) do
			if (info.group) then
				return true
			end
		end
	end
end

-- HasAnyNonExclusiveBuffs
function zg:HasAnyNonExclusiveBuffs()
	if (self.buffs) then
		for key,info in pairs(self.buffs) do
			if (not info.exclusive) then
				return true
			end
		end
	end
end

-- AutoGroupAssignment
function zg:AutoGroupAssignment()
	if (not self.db or not self.db.char.autogroups) then
		return
	end
	if (not self:HasGroupBuffs()) then
		return
	end

	local playerName = UnitName("player")
	local count = z.classcount[playerClass]
	local list = new()
	local maxGroup = 1
	if (GetNumRaidMembers() > 0) then
		for i = 1,GetNumRaidMembers() do
			local name, rank, subgroup, level, _, class = GetRaidRosterInfo(i)
			if (class == playerClass) then
				tinsert(list, name)
			end
			if (subgroup > maxGroup) then
				maxGroup = subgroup
			end
		end
	end
	sort(list)

	local myIndex = 1
	for i,name in ipairs(list) do
		if (name == playerName) then
			myIndex = i
			break
		end
	end

	local displayList = new()
	if (maxGroup == 1 or count == 1) then
		for i = 1,8 do
			self.db.char.groups[i] = true
		end
		z:CheckForChange(self)
		return
	end

	local anyChange
	local each = maxGroup / count
	local start = (myIndex - 1) * each + 1
	for groupNo = 1,maxGroup do
		local shouldBuff = groupNo >= start and groupNo < start + each
		if (shouldBuff) then
			tinsert(displayList, tostring(groupNo))
		end
		if (shouldBuff ~= self.db.char.groups[groupNo]) then
			self.db.char.groups[groupNo] = shouldBuff
			anyChange = true
		end
	end
	if (not next(displayList)) then
		for i = 1,8 do
			self.db.char.groups[i] = true
		end
		z:CheckForChange(self)
		return
	end

	if (anyChange) then
		if (GetNumRaidMembers() > 0 and z.db.profile.info) then
			self:Print(L["You are now responsible for Groups %s"], table.concat(displayList, ", ", 1, max(1, #displayList - 1))..((#displayList > 1 and L[" and "]..displayList[#displayList]) or ""))
		end
		z:CheckForChange(self)
		z:SendCommMessage("GROUP", "AUTOGROUPASSIGNED", playerClass, displayList)
	end

	del(list)
	del(displayList)
end

-- CheckRoster
function zg:CheckRoster()
	if (self.db) then
		self:AutoGroupAssignment()
	end
end

-- ShowBuffBar
function zg:ShowBuffBar(cell, name)
	if (self.lookup) then
		local prefix = SecureButton_GetModifierPrefix(cell)
		for button = 1,5 do
			local spell = cell:GetAttribute(prefix, "spell", button)
			if (spell == name) then
				return true
			else
				local find = self.lookup[spell]
				if (find) then
					for i,search in ipairs(find.list) do
						if (search == name) then
							return true
						end
					end
				end
			end
		end
	end
end

-- GetSpellColour
function zg:GetSpellColour(spellName)
	local def = self.lookup and self.lookup[spellName]
	if (def) then
		return z:HexColour(unpack(def.colour))
	end
end

-- OneOfYours
function zg:OneOfYours(spell)
	return self.lookup[spell]
end

-- SayWhatWeDid
function zg:SayWhatWeDid(icon, spell, name, rank)
	if (not z.db.profile.info) then
		return
	end

	local s = spell or icon:GetAttribute("spell")
	if (s) then
		local found = self.lookup[s]
		if (found) then
			local _, colour = ColourSpellFromKey(found)
			local index
			if (spell == found.list[2]) then
				index = 2
			else
				index = 1
			end
			local r = found.reagents and found.reagents[index]
			local reagentString
			if (r) then
				local reagent
				if (type(r) == "table") then
					if (r[rank]) then
						reagent = r[rank]
					else
						reagent = r[#r]
					end
				else
					reagent = r
				end

				local count = GetItemCount(reagent)
				local colourCount
				if (count < 5) then
					colourCount = "|cFFFF4040"
				elseif (count < 10) then
					colourCount = "|cFFFFFF40"
				else
					colourCount = "|cFF40FF40"
				end
				reagentString = format(" (%s%d|r)", colourCount, count - 1)
			else
				reagentString = ""
			end

			if (found.group and spell == found.list[2] and (UnitInRaid(name) or UnitInParty(name))) then
				local unitid = z:GetUnitID(name)
				local subgroup = z:GetGroupNumber(unitid)
	      		self:Print(L["%s on %s%s"], z:LinkSpell(s, colour, true, z.db.profile.short and found.name), z:ColourGroup(subgroup), reagentString)
			else
				self:Print(L["%s on %s%s"], z:LinkSpell(s, colour, true, z.db.profile.short and found.name), z:ColourUnitByName(name), reagentString)
			end
		end
	end
end

-- OnRegenEnabled
function zg:OnRegenEnabled()
	if (self.stopSpellTracking) then
		for i,key in ipairs(self.stopSpellTracking) do
			self:StopSpellTracker(key)
		end
		self.stopSpellTracking = del(self.stopSpellTracking)
	end

	if (self.trackIcons) then
		for i,icon in ipairs(self.trackIcons) do
			icon:SetAlpha(1)
			if (icon:IsShown()) then
				if (icon.dummy) then
					self:SwitchTrackIconForReal(icon)
				else
					local unit = icon:GetAttribute("unit")
					if (not UnitIsUnit(icon.target, unit)) then
						icon:SetTrackerAttributes(icon.target, icon.key)
						icon:UpdateAura()
					end
				end
			end
		end
	end
end

do
	-- SmoothColour
	local function SmoothColour(percentage)
		local r, g
		if (percentage < 0.5) then
			g = min(1, max(0, 2 * percentage))
			r = 1
		else
			g = 1
			r = min(1, max(0, 2 * (1 - percentage)))
		end
		return r, g, 0
	end

	local function iconUpdateCooldown(self)
		local start, duration, enable = GetSpellCooldown(self.spell)
		CooldownFrame_SetTimer(self.cooldown, start, duration, enable)
	end

	local function iconGetSpellFromUnit(self)
		for i = 1,40 do
			local name, rank, buff, count, _, maxDuration, endTime = z:UnitBuff(self.target, i)
			if (not name) then
				return
			end
			if (name == self.spell) then
				if (endTime) then
					self.timeLeft = endTime - GetTime()
					self.maxTime = maxDuration
				end
				return name ~= nil, count, endTime, maxDuration
			end
		end
		self.timeLeft = nil
	end

	local function iconUpdateAura(self)
		local got, count, endTime, maxDuration = self:GetSpellFromUnit()
		if (got) then
			if (endTime) then
				self.timeLeft = endTime - GetTime()
			end

			self.stacks = count
			self.count:SetText(count)

			if (not UnitIsVisible(self.target) or not self.initialStacks or self.initialStacks < 2) then
				self.count:Hide()
			else
				self.count:Show()
				local r, g, b = SmoothColour(self.stacks / self.initialStacks)
				self.count:SetTextColor(r, g, b)
			end
			self.swirl:Hide()
			self.had = true
			return
		else
			self.timeLeft = nil
		end

		if (self.had) then
			if (UnitIsVisible(self.target)) then
				self.had = nil
				local buff = zg.buffs[self.key]

				if (self.temp) then
					zg:StopSpellTracker(self.key)
					return
				end

				z:Notice(format(L["%s has expired on %s"], ColourSpellFromKey(buff), z:ColourUnitByName(self.target)))
				PlaySoundFile(SM:Fetch("sound", zg.db.char.tracksound))
			end
		end

		self.name:Hide()
		self.stacks = 0
		self.count:SetText("0")
		self.count:SetTextColor(1, 0, 0)
		self.swirl:Show()
	end

	local function iconUpdateTooltip(self)
		local got, count, endTime, maxDuration = self:GetSpellFromUnit()
		local buff = zg.buffs[self.key]
		local buffColour = z:HexColour(unpack(buff.colour))
		local keyb
		if (zg.db.char.keybinding and self.keybinding) then
			keyb = format(" (|cFF80FF80%s|r)", zg.db.char.keybinding)
		else
			keyb = ""
		end

		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(format("%s %s", z.titleColour, L["Spell Tracker"]), 1, 1, 1)
		GameTooltip:AddLine(format(L["%s on %s%s"], ColourSpellFromKey(buff), z:ColourUnitByName(self.target), keyb))

		if (not got) then
			GameTooltip:AddLine(L["MISSING!"], 1, 0, 0)
		else
			local r, g, b
			if (self.stacks and self.initialStacks and self.initialStacks > 1) then
				r, g, b = SmoothColour(self.stacks / self.initialStacks)
				GameTooltip:AddLine(format(L["%d of %d stacks remain"], self.stacks or 0, self.initialStacks or 0), r, g, b)
			end
			if (endTime) then
				local r, g, b = SmoothColour((endTime - GetTime()) / maxDuration)
				GameTooltip:AddLine(format("%s remains", date("%M:%S", duration - GetTime())), r, g, b)
			end
		end

		local unit = self:GetAttribute("unit")
		if (unit and not UnitIsUnit(self.target, unit)) then
			GameTooltip:AddLine(format(L["WARNING: The intended target for this icon has changed since you entered combat. (Was %s)"], z:ColourUnit(unit)), 1, 0.5, 0.5, 1)
		end

		if (self.dummy) then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L["This button is not clickable because it was created after you entered combat"], 0.5, 1, 0.5, 1)
		end

		GameTooltip:Show()
	end

	local function iconOnDragStart(self)
			self:StartMoving()
	end

	local function iconOnDragStop(self)
		self:StopMovingOrSizing()
		if (self.posindex) then
			if (not zg.db.char.postracker) then
				zg.db.char.postracker = {}
			end
			zg.db.char.postracker[self.posindex] = z:GetPosition(self)
		end
	end

	local function iconOnUpdate(self, elapsed)
		if (self.timeLeft) then
			self.timeLeft = self.timeLeft - elapsed
			if (self.timeLeft > 0) then
				self.name:SetText(date("%M:%S", self.timeLeft):gsub("^0", ""))
				local r, g, b = SmoothColour(self.timeLeft / self.maxTime)
				self.name:SetTextColor(r, g, b)
				self.name:Show()
			else
				self.timeLeft = nil
			end
		else
			self.name:Hide()
		end
	end

	local function iconOnEvent(self, event, unit, ...)
		if (event == "UNIT_AURA") then
			if (UnitIsUnit(unit, self.target)) then
				self:UpdateAura()
			end
		elseif (event == "ACTIONBAR_UPDATE_COOLDOWN") then
			self:UpdateCooldown()
		end
	end

	local function iconOnShow(self)
		self:RegisterEvent("UNIT_AURA")
		self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
		self:SetPosition()
		self:UpdateAura()
		self:UpdateCooldown()
		zg:SetTrackerKeyBindings()
	end

	local function iconOnHide(self)
		self:UnregisterEvent("UNIT_AURA")
		self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	end

	local function iconSetPosition(self)
		self:SetPoint("CENTER")
		self:SetScale(zg.db.char.trackerscale)
		if (type(zg.db.char.postracker) == "table") then
			pos = zg.db.char.postracker[self.posindex]
			if (pos) then
				z:RestorePosition(self, pos)
			end
		end
	end

	-- SetTrackerAttributes
	local function iconSetTrackerAttributes(self, target, key)
		local buff = zg.buffs[key]
		local spell = buff.list[1]
		self.target = target
		self.key = key
		self.spell = spell
		self.initialStacks = buff.stacks
		self.count:Hide()
		self.name:Hide()
		local name, rank, tex = GetSpellInfo(buff.ids[1])
		self.icon:SetTexture(tex)

		local oldUnit = self:GetAttribute("unit")
		if (oldUnit and not UnitIsUnit(oldUnit, target)) then
			self.timeLeft = nil
			self.had = nil
		end

		if (not self.dummy and not InCombatLockdown()) then
			self:SetAttribute("unit", self.target)
			self:SetAttribute("type", "spell")
			self:SetAttribute("spell", self.spell)
		end

		local newUnit = self:GetAttribute("unit")
		if (newUnit and not UnitIsUnit(newUnit, target)) then
			self.icon:SetVertexColor(1, 0, 0)
		else
			self.icon:SetVertexColor(1, 1, 1)
		end
	end

	-- CreateTrackIcon
	function zg:CreateTrackIcon()
		local iname, inh

		if (InCombatLockdown()) then
			self.dummytrackIconIndex = (self.dummytrackIconIndex or 0) + 1
			inh = "ActionButtonTemplate"
			iname = "ZOMGDummyTrackIcon"..self.dummytrackIconIndex
		else
			self.trackIconIndex = (self.trackIconIndex or 0) + 1
			inh = "SecureActionButtonTemplate,ActionButtonTemplate"
			iname = "ZOMGTrackIcon"..self.trackIconIndex
		end

		local icon = CreateFrame("Button", iname, UIParent, inh)
		icon.dummy = InCombatLockdown() or nil

		if (not self.trackIcons) then
			self.trackIcons = {}
		end
		tinsert(self.trackIcons, icon)

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
		icon.name:SetFontObject("NumberFontNormal")

		icon.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
		icon.border:SetVertexColor(0, 1, 0, 0.6)
		icon.normal:SetVertexColor(1, 1, 1, 0.5)
		icon:SetWidth(36)
		icon:SetHeight(36)
		
		if (wow3) then
			icon.swirl = CreateFrame("Frame", iname.."Swirl", icon, "AutoCastShineTemplate")
			icon.swirl:Hide()
			icon.swirl:SetAllPoints()
			AutoCastShine_AutoCastStart(icon.swirl, 1, 0.5, 0.5)
		else
			icon.swirl = CreateFrame("Model", nil, icon)
			icon.swirl:SetModel("Interface\\Buttons\\UI-AutoCastButton.mdx")
			icon.swirl:Hide()
			icon.swirl:SetAllPoints()
			icon.swirl:SetSequence(0)
			icon.swirl:SetSequenceTime(0, 0)
			icon.swirl:SetScale(1.4)
		end

		icon:RegisterForClicks("AnyUp")
		icon:RegisterForDrag("LeftButton")
		icon:SetMovable(true)

		icon.UpdateCooldown = iconUpdateCooldown
		icon.GetSpellFromUnit = iconGetSpellFromUnit
		icon.UpdateAura = iconUpdateAura
		icon.UpdateTooltip = iconUpdateTooltip
		icon.SetPosition = iconSetPosition
		icon.SetTrackerAttributes = iconSetTrackerAttributes

		icon:SetScript("OnDragStart", iconOnDragStart)
		icon:SetScript("OnDragStop", iconOnDragStop)
		icon:SetScript("OnUpdate", iconOnUpdate)
		icon:SetScript("OnEvent", iconOnEvent)
		icon:SetScript("OnEnter", icon.UpdateTooltip)
		icon:SetScript("OnLeave", gttOnLeave)
		icon:SetScript("OnShow", iconOnShow)
		icon:SetScript("OnHide", iconOnHide)

		icon:Hide()

		self.trackIcon = icon
		return icon
	end
end

-- SetTrackerKeyBindings
function zg:SetTrackerKeyBindings()
	if (self.db.char.keybinding and not InCombatLockdown()) then
		SetBinding(self.db.char.keybinding, nil)
		if (self.trackIcons) then
			for i,icon in ipairs(self.trackIcons) do
				if (icon:IsShown() and icon.posindex == 1) then
					SetBindingClick(self.db.char.keybinding, icon:GetName(), "LeftButton")
					icon.keybinding = true
				else
					icon.keybinding = nil
				end
			end
		end
	end
end

-- AddSpellTracker
function zg:AddSpellTracker(key, target)
	if (not self.db.char.tracker) then
		return
	end
	local buff = self.buffs[key]
	if (not buff) then
		return
	end

	if (buff.notself and UnitIsUnit("player", target)) then
		return
	end

	local icon = self:IsSpellTracking(key)

	if (icon) then
		if (UnitIsUnit(icon.target, target)) then
			return
		end
	else
		icon = self:GetFreeTrackIcon()
	end

	icon:SetTrackerAttributes(target, key)

	icon.posindex = self:GetNewIconIndex()
	if (not InCombatLockdown() or icon.dummy) then
		icon:Show()
	end
	icon:UpdateAura()

	return icon
end

-- SwitchTrackIconForReal
function zg:SwitchTrackIconForReal(icon)
	if (icon.dummy) then
		local target, key, spell, pos = icon.target, icon.key, icon.spell, icon.posindex
		zg:FreeIconIndex(icon.posindex)
		icon:Hide()
		icon.posindex = nil
		
		local newIcon = self:AddSpellTracker(key, target)
		newIcon:SetPosition()
	end
end

-- GetFreeTrackIcon
function zg:GetFreeTrackIcon()
	local dummy = InCombatLockdown() or nil
	if (self.trackIcons) then
		for i,icon in ipairs(self.trackIcons) do
			if (not icon.key and dummy == icon.dummy) then
				icon.remove = nil
				icon.temp = nil
				icon.had = nil
				icon.spell = nil
				icon.key = nil
				icon.target = nil
				return icon
			end
		end
	end
	return self:CreateTrackIcon()
end

-- StopSpellTracker
function zg:StopSpellTracker(key)
	local icon = self:IsSpellTracking(key)
	if (icon) then
		if (not icon.dummy and InCombatLockdown()) then
			if (not self.stopSpellTracking) then
				self.stopSpellTracking = new()
			end
			tinsert(self.stopSpellTracking, key)
		else
			zg:FreeIconIndex(icon.posindex)
			icon.posindex = nil
			icon:Hide()
		end

		if (not InCombatLockdown()) then
			z:RequestSpells()
		end
	end
end

-- IsSpellTracking
function zg:IsSpellTracking(key)
	local needDummy = InCombatLockdown()
	if (self.trackIcons) then
		for i,icon in ipairs(self.trackIcons) do
			if (icon.key == key and icon:IsShown()) then
				return icon
			end
		end
	end
end

-- IsTrackingPlayer
function zg:IsTrackingPlayer(unitname)
	if (self.trackIcons) then
		for i,icon in ipairs(self.trackIcons) do
			if (not icon.dummy and not icon.temp and icon:IsShown()) then
				return true
			end
		end
	end
end

-- GetNewIconIndex
function zg:GetNewIconIndex()
	if (not self.trackerIndices) then
		self.trackerIndices = new(1)
		return 1
	else
		for i,index in ipairs(self.trackerIndices) do
			if (i ~= index) then
				tinsert(self.trackerIndices, i, i)
				return i
			end
		end

		local last = self.trackerIndices[#self.trackerIndices]
		if (last) then
			last = last + 1
		else
			last = 1
		end

		tinsert(self.trackerIndices, last)
		return last
	end
end

-- FreeIconIndex
function zg:FreeIconIndex(index)
	if (self.trackerIndices) then
		for i,find in ipairs(self.trackerIndices) do
			if (find == index) then
				tremove(self.trackerIndices, i)
				if (not next(self.trackerIndices)) then
					self.trackerIndices = del(self.trackerIndices)
				end
				return
			end
		end
	end
end
   
-- SpellCastSucceeded
function zg:SpellCastSucceeded(spell, rank, target, manual, listClick)
	if (z:CanLearn()) then
		local info = self.lookup and self.lookup[spell]
		if (info) then
			if (UnitInRaid(target) or UnitInParty(target)) then
				if (not self.db.char.notlearnable[info.type]) then
					if (info.exclusive) then
						self:ModifyTemplate(info.type, true)
						self:AddLimitedSpell(target, info.type)			-- Always add for things like Earth Shield, Fear Ward

					elseif (info.limited and (manual or listClick)) then
						self:AddLimitedSpell(target, info.type)
					end
				--elseif (info.exclusive) then
				--	local icon = self:AddSpellTracker(info.type, target)
				--	if (icon) then
				--		icon.temp = true
				--	end
				end
			end
		end
	end
end

-- AddLimitedSpell
function zg:AddLimitedSpell(name, key)
	if (not self.tickHandlers[key]) then
		error(format("No handler for %q", tostring(key)), 2)
	end

	local buff = self.buffs[key]
	if (not buff) then
		error(format("No self.buff for %q", key))
	end

	if (not template.limited) then
		template.limited = new()
	end

	if (buff.exclusive or not template.limited[key]) then
		del(template.limited[key])
		template.limited[key] = new()
	end

	if (not template.limited[key][name]) then
		template.limited[key][name] = true
	end

	--z:CheckForChange(self)
	z:SetupForSpell()
	z:RequestSpells()

	if (buff.exclusive) then
		self:AddSpellTracker(key, name)
	end
end

-- RemoveLimitedSpell
function zg:RemoveLimitedSpell(name, key)
	local part = template.limited and template.limited[key]
	if (part) then
		if (part[name]) then
			part[name] = nil
			z:CheckForChange(self)
		end

		if (not next(part) and self.buffs[key].exclusive) then
			self:StopSpellTracker(key)
		end

		if (self.db.char.resetOnClear) then
			if (not next(part)) then
				template.limited[key] = del(template.limited[key])
			end
			if (not next(template.limited)) then
				template.limited = del(template.limited)
			end
		end
	end
end

-- UNIT_SPELLCAST_FAILED
function zg:SpellCastFailed(spell, name, manual)
	if (not manual) then
		if (self.lookup[spell]) then
			z:Blacklist(name)
		end
	end
end

-- SPELLS_CHANGED
function zg:SPELLS_CHANGED()
	if (not z.zoneFlag) then
		self.actions = nil
		self:GetActions()
		z:UpdateCellSpells()
		self:MakeSpellOptions()

		z:CheckForChange(self)
	end
end

-- SortedBuffList
function zg:SortedBuffList()
	local list = new()
	for Type,info in pairs(self.buffs) do
		local o = info.o
		local insertPos = #list + 1
		for i,k in ipairs(list) do
			if (self.buffs[k].o > o) then
				insertPos = i
				break
			end
		end
		tinsert(list, insertPos, Type)
	end
	return list
end

-- TooltipUpdate
function zg:TooltipUpdate(cat)
	if (template) then
		cat:AddLine('text', " ")
		cat:AddLine(
			"text", L["Group Template: "].."|cFFFFFFFF"..(self.db.char.selectedTemplate or L["none"]),
			"text2", (template and template.modified and "|cFFFF4040"..L["(modified)"].."|r") or ""
		)

		local list = self:SortedBuffList()
		for i,k in ipairs(list) do
			local key = self.buffs[k]
			if (GetSpellInfo(key.list[1])) then		-- GetSpellCooldown(key.list[1])) then
				local endis
				if (template[key.type]) then
					endis = "|cFF80FF80"..L["Enabled"].."|r"
				else
					endis = "|cFFFF8080"..L["Disabled"].."|r"
				end

				local name, rank, tex = GetSpellInfo(key.ids[1])
				local checkIcon = tex

				cat:AddLine(
					"text", ColourSpellFromKey(key),
					"text2", endis,
					"func", ToggleKeyType,
					"arg1", key.type,
					"hasCheck", checkIcon and true,
					"checked", checkIcon and true,
					"checkIcon", checkIcon
				)
			end
		end
		del(list)
	end
end

-- OnResetDB
function zg:OnResetDB()
	if (self.db) then
		template = self.db.char.templates.current

		for k,v in pairs(template) do
			if (k ~= "modified" and k ~= "state" and k ~= "limited") then
				if (not self.buffs[k]) then
					template[k] = nil
				end
			end
		end

		self:TickInitForTemplate()
	end
end

-- OnModuleEnable
function zg:OnModuleEnable()
	if (self.db) then
		local class = select(2, UnitClass("player"))
		if (class ~= playerClass and self.OnModuleInitialize) then
			self:OnModuleInitialize()
		end

		z:MakeOptionsReagentList()
		self:OnResetDB()
		
		self:SPELLS_CHANGED()
		self:MakeSpellOptions()

		self:RegisterBucketEvent("UNIT_AURA", 0.2)				-- We don't care who
		self:RegisterBucketEvent("SPELLS_CHANGED", 2)
		z:CheckForChange(self)
	end
end

-- OnDisable
function zg:OnDisable()
	z:CheckForChange(self)
end
