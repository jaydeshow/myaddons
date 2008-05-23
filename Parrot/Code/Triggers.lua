local VERSION = tonumber(("$Revision: 74535 $"):match("%d+"))

local Parrot = Parrot
local Parrot_Triggers = Parrot:NewModule("Triggers", "LibRockTimer-1.0")
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2008-05-20 09:57:38 -0400 (Tue, 20 May 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

-- local L = Parrot:L("Parrot_Triggers")
-- TODO make modular
local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Triggers")

local newList, newSet, newDict, del, unpackDictAndDel = Rock:GetRecyclingFunctions("Parrot", "newList", "newSet", "newDict", "del", "unpackDictAndDel")

local _,playerClass = UnitClass("player")

local SharedMedia = Rock("LibSharedMedia-3.0")

Parrot_Triggers.db = Parrot:GetDatabaseNamespace("Triggers")
Parrot:SetDatabaseNamespaceDefaults("Triggers", 'profile', {})

local effectiveRegistry = {}
local function rebuildEffectiveRegistry()
	for i = 1, #effectiveRegistry do
		effectiveRegistry[i] = nil
	end
	for _,v in ipairs(Parrot_Triggers.db.profile.triggers) do
		if not v.disabled then
			local classes = newSet((';'):split(v.class))
			if classes[playerClass] then
				effectiveRegistry[#effectiveRegistry+1] = v
			end
			classes = del(classes)
		end
	end
end

-- so triggers can be enabled/disabled from outside
function Parrot_Triggers:setTriggerEnabled(triggerindex, enabled)
	self.db.profile.triggers[triggerindex].disabled = not enabled
	rebuildEffectiveRegistry()
end

local cooldowns = {}
local currentTrigger
local Parrot_TriggerConditions
local Parrot_Display
local Parrot_ScrollAreas
local Parrot_CombatEvents
function Parrot_Triggers:OnInitialize()
	Parrot_Display = Parrot:GetModule("Display")
	Parrot_ScrollAreas = Parrot:GetModule("ScrollAreas")
	Parrot_TriggerConditions = Parrot:GetModule("TriggerConditions")
	Parrot_CombatEvents = Parrot:GetModule("CombatEvents")
end

function Parrot_Triggers:OnEnable(first)
	if not self.db.profile.triggers then
		self.db.profile.triggers = {
			{
				-- 34939 = Backlash
				name = L["%s!"]:format(GetSpellInfo(34939)),
				icon = 34939,
				class = "WARLOCK",
				conditions = {
					["Self buff gain"] = GetSpellInfo(34939),
				},
				sticky = true,
				color = "ff00ff",
			},
			{
				-- 15326 = Blackout
				name = L["%s!"]:format(GetSpellInfo(15326)),
				icon = 15326,
				class = "PRIEST",
				conditions = {
					["Target debuff gain"] = GetSpellInfo(15326),
				},
				sticky = true,
				color = "ff00ff",
			},
			{
				-- 34754 = Clearcasting (Priest) TODO
				name = L["%s!"]:format(GetSpellInfo(34754)),
				icon = 34754,
				class = "MAGE;PRIEST;SHAMAN",
				conditions = {
					["Self buff gain"] = GetSpellInfo(34754),
				},
				sticky = true,
				color = "ffff00",
			},
			{
				-- 27067 = Counterattack
				name = L["%s!"]:format(GetSpellInfo(27067)),
				icon = 27067,
				class = "HUNTER",
				conditions = {
					["Incoming parry"] = true,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(27067),
				},
				sticky = true,
				color = "ffff00",
			},
			{
				-- 25236 = Execute
				name = L["%s!"]:format(GetSpellInfo(25236)),
				icon = 25236,
				class = "WARRIOR",
				conditions = {
					["Enemy target health percent"] = 0.2,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(25236),
				},
				sticky = true,
				color = "ffff00",
			},
			{
				-- Frostbite = 12497
				name = L["%s!"]:format(GetSpellInfo(12497)),
				icon = 12497,
				class = "MAGE",
				conditions = {
					["Target debuff gain"] = GetSpellInfo(12497),
				},
				sticky = true,
				color = "0000ff",
			},
			{
				-- 27180 - Hammer of Wrath
				name = L["%s!"]:format(GetSpellInfo(27180)),
				icon = 27180,
				class = "PALADIN",
				conditions = {
					["Enemy target health percent"] = 0.2,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(27180),
				},
				sticky = true,
				color = "ffff00",
			},
			{
				-- Impact = 12360
				name = L["%s!"]:format(GetSpellInfo(12360)),
				icon = 12360,
				class = "MAGE",
				conditions = {
					["Target debuff gain"] = GetSpellInfo(12360),
				},
				sticky = true,
				color = "ff0000",
			},
			{
				-- Kill Command = 34026
				name = L["%s!"]:format(GetSpellInfo(34026)),
				icon = 34026,
				class = "HUNTER",
				conditions = {
					["Outgoing crit"] = true,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(34026),
				},
				sticky = true,
				color = "ff0000",
				disabled = true,
			},
			{
				name = L["Low Health!"],
				class = "DRUID;HUNTER;MAGE;PALADIN;PRIEST;ROGUE;SHAMAN;WARLOCK;WARRIOR",
				conditions = {
					["Self health percent"] = 0.4,
				},
				secondaryConditions = {
					["Trigger cooldown"] = 3,
				},
				sticky = true,
				color = "ff7f7f",
			},
			{
				name = L["Low Mana!"],
				class = "DRUID;HUNTER;MAGE;PALADIN;PRIEST;SHAMAN;WARLOCK",
				conditions = {
					["Self mana percent"] = 0.35,
				},
				secondaryConditions = {
					["Trigger cooldown"] = 3,
				},
				sticky = true,
				color = "7f7fff",
			},
			{
				name = L["Low Pet Health!"],
				class = "HUNTER;MAGE;WARLOCK",
				conditions = {
					["Pet health percent"] = 0.4,
				},
				secondaryConditions = {
					["Trigger cooldown"] = 3,
				},
				color = "ff7f7f",
			},
			{
				-- Mongoose Bite = 36916
				name = L["%s!"]:format(GetSpellInfo(36916)),
				icon = 36916,
				class = "HUNTER",
				conditions = {
					["Incoming dodge"] = true,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(36916),
				},
				sticky = true,
				color = "ffff00",
			},
			{
				-- 18095 = Nightfall
				name = L["%s!"]:format(GetSpellInfo(18095)),
				icon = 18095,
				class = "WARLOCK",
				conditions = {
					-- 17941 = Shadow Trance
					["Self buff gain"] = GetSpellInfo(17941),
				},
				sticky = true,
				color = "7f007f",
			},
			{
				-- Smite = 25364 
				name = L["Free %s!"]:format(GetSpellInfo(25364)),
				icon = 25364,
				class = "PRIEST",
				conditions = {
					-- Surge of Light =33154
					["Self buff gain"] = GetSpellInfo(33154),
				},
				sticky = true,
				disabled = true,
				color = "ff0000",
			},			
			{
				-- Overpower = 11585
				name = L["%s!"]:format(GetSpellInfo(11585)),
				icon = 11585,
				class = "WARRIOR",
				conditions = {
					["Outgoing dodge"] = true,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(11585),
				},
				sticky = true,
				color = "7f007f",
			},
			{
				-- Rampage = 30033
				name = L["%s!"]:format(GetSpellInfo(30033)),
				icon = 30033,
				class = "WARRIOR",
				conditions = {
					["Outgoing crit"] = true,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(30033),
					["Buff inactive"] = GetSpellInfo(30033),
					["Minimum power amount"] = 20,
				},
				sticky = true,
				color = "ff0000",
			},
			{
				-- Revenge = 30357
				name = L["%s!"]:format(GetSpellInfo(30357)),
				icon = 30357,
				class = "WARRIOR",
				conditions = {
					["Incoming block"] = true,
					["Incoming dodge"] = true,
					["Incoming parry"] = true,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(30357),
					["Warrior stance"] = "Defensive Stance",
				},
				sticky = true,
				color = "ffff00",
				disabled = true,
			},
			{
				-- Riposte = 14251
				name = L["%s!"]:format(GetSpellInfo(14251)),
				icon = 14251,
				class = "ROGUE",
				conditions = {
					["Incoming parry"] = true,
				},
				secondaryConditions = {
					["Spell ready"] = GetSpellInfo(14251),
				},
				sticky = true,
				color = "ffff00",
			},
		}
	end
	self:AddRepeatingTimer(0.1, function()
		Parrot:FirePrimaryTriggerCondition("Check every XX seconds")
	end)
	if first then
		Parrot_TriggerConditions:RegisterSecondaryTriggerCondition {
			name = "Trigger cooldown",
			localName = L["Trigger cooldown"],
			defaultParam = 3,
			param = {
				type = "number",
				min = 0,
				max = 60,
				step = 0.1,
				bigStep = 1,
			},
			check = function(param)
				if not cooldowns[currentTrigger] then
					return true
				end
				local now = GetTime()
				return now - cooldowns[currentTrigger] > param
			end,
		}
		
		Parrot:RegisterPrimaryTriggerCondition {
			name = "Check every XX seconds",
			localName = L["Check every XX seconds"],
			defaultParam = 3,
			param = {
				type = 'number',
				min = 0,
				max = 60,
				step = 0.1,
				bigStep = 1,
			},
		}
		
		for _,data in ipairs(self.db.profile.triggers) do
			local t = newList()
			for k,v in pairs(data.conditions) do
				t[k] = v
				data.conditions[k] = nil
			end
			local choices = Parrot_TriggerConditions:GetPrimaryConditionChoices()
			for k,v in pairs(t) do
				if choices[k] then
					data.conditions[k] = v
					t[k] = nil
				else
					local k_lower = k:lower()
					for l,u in pairs(choices) do
						if l:lower() == k_lower then
							data.conditions[l] = v
							t[k] = nil
						end
					end
					if t[k] then
						data.conditions[k] = v
						t[k] = nil
					end
				end
			end
			t = del(t)
			if data.secondaryConditions then
				local t = newList()
				for k,v in pairs(data.secondaryConditions) do
					t[k] = v
					data.secondaryConditions[k] = nil
				end
				local choices = Parrot_TriggerConditions:GetSecondaryConditionChoices()
				for k,v in pairs(t) do
					if choices[k] then
						data.secondaryConditions[k] = v
						t[k] = nil
					else
						local k_lower = k:lower()
						for l,u in pairs(choices) do
							if l:lower() == k_lower then
								data.secondaryConditions[l] = v
								t[k] = nil
							end
						end
						if t[k] then
							data.secondaryConditions[k] = v
							t[k] = nil
						end
					end
				end
				t = del(t)
			end
		end
	end
	
	rebuildEffectiveRegistry()
end

local function hexColorToTuple(color)
	local num = tonumber(color, 16)
	return math.floor(num / 256^2)/255, math.floor((num / 256)%256)/255, (num%256)/255
end

local oldIconName = {
	["Backlash"] = 34939,
	["Nightfall"] = 18095,
	["Stormstrike"] = 17364,
}

-- to find the icon for old saved variables

local oldIconName = {
	["Backlash"] = 34939,
	["Blackout"] = 15326,
	["Clearcasting"] = 34754,
	["Counterattack"] = 27067,
	-- ["Execute"] = 25236, -- not needed
	["Frostbite"] = 12497,
	["Impact"] = 12360,
	["Kill Command"] = 34026,
	["Mongoose Bite"] = 36916,
	["Nightfall"] = 18095,
	-- ["Smite"] = 25364, -- not needed
	["Overpower"] = 11585,
	["Rampage"] = 30033,
	["Revenge"] = 30357,
	["Riposte"] = 14251,
	
}

local function figureIconPath(icon)
	if not icon then
		return nil
	end

	local path
	
	-- if the icon is a number, it's most likly a spellid
	local spellId = tonumber(icon)
	if spellId then
		path = select(3,GetSpellInfo(spellId))
		return path
	end
	
	-- if the spell is in the spellbook, the icon can be retrieved that way
	path = select(3, GetSpellInfo(icon))
	if path then
		return path
	end
	
	-- the last chance is, that it's an option saved by an old parrot version
	-- the strings from the default-options can be resolved by the table provided above
	local oldIcon = oldIconName[icon]
	if oldIcon then
		path = select(3, GetSpellInfo(oldIcon))
		if path then
			return path
		end
	end
	
	-- perhaps it's an item
	local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(icon)
	if texture then
		return texture
	end
	-- nothing worked, either it's a path or a spell where the icon cannot be retrieved
	return icon
end

local numberedConditions = {}
local timerCheck = {}

function Parrot_Triggers:OnTriggerCondition(name, arg, uid)
	if UnitIsDeadOrGhost("player") then
		return
	end
	for _,v in ipairs(effectiveRegistry) do
		local conditions = v.conditions
		if conditions then
			local param = conditions[name]
			if param then
				local good = false
				if param == true then
				 	good = true
				elseif type(arg) == "string" then
					good = param == arg
				elseif type(arg) == "number" then
					if not numberedConditions[v] then
						numberedConditions[v] = newList()
					end
					good = arg <= param and (not numberedConditions[v][name] or numberedConditions[v][name] > param)
					numberedConditions[v][name] = arg
				elseif name == "Check every XX seconds" then
					local val = timerCheck[name]
					if not val then
						val = 0
					end
					if param == 0 then
						val = 0
					else
						val = (val + 0.1) % param
					end
					timerCheck[name] = val
					if val < 0.1 then
						good = true
					end
				end
				if good then
					local secondaryConditions = v.secondaryConditions
					if secondaryConditions then
						currentTrigger = v.name
						for k, v in pairs(secondaryConditions) do
							if not Parrot_TriggerConditions:DoesSecondaryTriggerConditionPass(k, v) then
								good = false
								break
							end
						end
					end
					if good and Parrot_TriggerConditions:DoesSecondaryTriggerConditionPass("Trigger cooldown", 0.1) then
						cooldowns[v.name] = GetTime()
						local r, g, b = hexColorToTuple(v.color or 'ffffff')
						local icon = figureIconPath(v.icon)
						-- getIconById(v.iconSpellId) or figureIconPath(v.icon)
						
						Parrot_Display:ShowMessage(v.name, v.scrollArea or "Notification", v.sticky, r, g, b, v.font, v.fontSize, v.outline, icon)
						
						if v.sound then
							local sound = SharedMedia:Fetch('sound', v.sound)
							if sound then
								PlaySoundFile(sound)
							end
						end
						if uid then
							Parrot_CombatEvents:CancelEventsWithUID(uid)
						end
					end
				end
			end
		end
	end
end

function Parrot_Triggers:OnOptionsCreate()
	local makeOption
	local triggers_opt = {
		type = 'group',
		name = L["Triggers"],
		desc = L["Triggers"],
		disabled = function()
			return not self:IsActive()
		end,
		args = {
			{
				type = 'execute',
				buttonText = L["Create"],
				name = L["New trigger"],
				desc = L["Create a new trigger"],
				func = function()
					local t = {
						name = L["New trigger"],
						class = "DRUID;HUNTER;MAGE;PALADIN;PRIEST;ROGUE;SHAMAN;WARLOCK;WARRIOR",
						conditions = {},
					}
					local registry = self.db.profile.triggers
					registry[#registry+1] = t
					makeOption(t)
					rebuildEffectiveRegistry()
				end,
				disabled = function()
					if not self.db.profile.triggers then
						return true
					end
					for _,v in ipairs(self.db.profile.triggers) do
						if v.name == L["New trigger"] then
							return true
						end
					end
					return false
				end
			}
		}
	}
	Parrot:AddOption('triggers', triggers_opt)
	
	local function getFontFace(t)
		local font = t.font
		if font == nil then
			return L["Inherit"]
		else
			return font
		end
	end
	local function setFontFace(t, value)
		if value == L["Inherit"] then
			value = nil
		end
		t.font = value
	end
	local function getFontSize(t)
		return t.fontSize
	end
	local function setFontSize(t, value)
		t.fontSize = value
	end
	local function getFontSizeInherit(t)
		return t.fontSize == nil
	end
	local function setFontSizeInherit(t, value)
		if value then
			t.fontSize = nil
		else
			t.fontSize = 18
		end
	end
	local function getFontOutline(t)
		local outline = t.fontOutline
		if outline == nil then
			return L["Inherit"]
		else
			return outline
		end
	end
	local function setFontOutline(t, value)
		if value == L["Inherit"] then
			value = nil
		end
		t.fontOutline = value
	end
	local fontOutlineChoices = {
		NONE = L["None"],
		OUTLINE = L["Thin"],
		THICKOUTLINE = L["Thick"],
		[L["Inherit"]] = L["Inherit"],
	}
	local function getEnabled(t)
		return not t.disabled
	end
	local function setEnabled(t, value)
		t.disabled = not value or nil
		rebuildEffectiveRegistry()
	end
	local function getScrollArea(t)
		return t.scrollArea or "Notification"
	end
	local function setScrollArea(t, value)
		if value == "Notification" then
			value = nil
		end
		t.scrollArea = value
	end
	local function remove(t)
		triggers_opt.args[tostring(t)] = nil
		for i,v in ipairs(self.db.profile.triggers) do
			if v == t then
				table.remove(self.db.profile.triggers, i)
				break
			end
		end
		rebuildEffectiveRegistry()
	end
	local function getSticky(t)
		return t.sticky
	end
	local function setSticky(t, value)
		t.sticky = value or nil
	end
	local function getName(t)
		return t.name
	end
	local function setName(t, value)
		t.name = value
		local opt = triggers_opt.args[tostring(t)]
		opt.name = value
		opt.desc = value
		opt.order = value == L["New trigger"] and -110 or -100
	end
	
	local function getIcon(t)
		return t.icon or ''
	end
	local function setIcon(t, value)
		if value == '' then
			value = nil
		end
		t.icon = value
	end
	
	local function tupleToHexColor(r, g, b)
		return ("%02x%02x%02x"):format(r * 255, g * 255, b * 255)
	end
	
	local function getColor(t)
		return hexColorToTuple(t.color or "ffffff")
	end
	local function setColor(t, r, g, b)
		local color = tupleToHexColor(r, g, b)
		if color == "ffffff" then
			color = nil
		end
		t.color = color
	end
	
	local function getClass(t, class)
		local tmp = newSet((";"):split(t.class))
		local value = tmp[class]
		tmp = del(tmp)
		return value
	end
	
	local function setClass(t, class, value)
		local tmp = newSet((";"):split(t.class))
		tmp[class] = value or nil
		local tmp2 = newList()
		for k in pairs(tmp) do
			tmp2[#tmp2+1] = k
		end
		tmp = del(tmp)
		t.class = table.concat(tmp2, ";")
		tmp2 = del(tmp2)
		if class == playerClass then
			rebuildEffectiveRegistry()
		end
	end
	
	local function getSound(t)
		return t.sound or "None"
	end
	
	local function setSound(t, value)
		PlaySoundFile(SharedMedia:Fetch('sound', value))
		if value == "None" then
			value = nil
		end
		t.sound = value
	end
	
	local function test(t)
		local r, g, b = hexColorToTuple(t.color or 'ffffff')
		--TODO
		Parrot_Display:ShowMessage(t.name, t.scrollArea or "Notification", t.sticky, r, g, b, t.font, t.fontSize, t.outline, figureIconPath(t.icon))
		if t.sound then
			local sound = SharedMedia:Fetch('sound', t.sound)
			if sound then
				PlaySoundFile(sound)
			end
		end
	end
	
	local classChoices = {
		DRUID = L["Druid"],
		ROGUE = L["Rogue"],
		SHAMAN = L["Shaman"],
		PALADIN = L["Paladin"],
		MAGE = L["Mage"],
		WARLOCK = L["Warlock"],
		PRIEST = L["Priest"],
		WARRIOR = L["Warrior"],
		HUNTER = L["Hunter"],
	}
	
	local function addPrimaryCondition(t, name, localName)
		local opt = triggers_opt.args[tostring(t)].args.primary
		local param, default = Parrot_TriggerConditions:GetPrimaryConditionParamDetails(name)
		if not param then
			opt.args[name] = newDict(
				'type', 'execute',
				'buttonText', "---",
				'name', localName,
				'desc', localName,
				'func', function() end,
				'order', -100
			)
			return true
		else
			local tmp = newDict(
				'name', localName,
				'desc', localName,
				'get', function()
					return t.conditions[name]
				end,
				'set', function(value)
					t.conditions[name] = value
				end,
				'order', -100
			)
			for k, v in pairs(param) do
				tmp[k] = v
			end
			opt.args[name] = tmp
			if default then
				return default
			end
			if type(param.min) == "number" and type(param.max) == "number" then
				return (param.max + param.min) / 2
			end
			return false
		end
	end
	local function newPrimaryCondition(t, name)
		local opt = triggers_opt.args[tostring(t)].args.primary
		local localName = Parrot_TriggerConditions:GetPrimaryConditionChoices()[name]
		t.conditions[name] = addPrimaryCondition(t, name, localName)
	end
	local function removePrimaryCondition(t, name)
		local opt = triggers_opt.args[tostring(t)].args.primary
		opt.args[name] = del(opt.args[name])
		t.conditions[name] = nil
	end
	local function hasNoPrimaryConditions(t)
		return next(t.conditions) == nil
	end
	local function hasAllPrimaryConditions(t)
		for k,v in pairs(Parrot_TriggerConditions:GetPrimaryConditionChoices()) do
			if t.conditions[k] == nil then
				return false
			end
		end
		return true
	end
	local function getAvailablePrimaryConditions(t)
		local tmp = newList()
		for k,v in pairs(Parrot_TriggerConditions:GetPrimaryConditionChoices()) do
			if not t.conditions[k] then
				tmp[k] = v
			end
		end
		return "@dict", unpackDictAndDel(tmp)
	end
	local function getUsedPrimaryConditions(t)
		local tmp = newList()
		for k,v in pairs(Parrot_TriggerConditions:GetPrimaryConditionChoices()) do
			if t.conditions[k] then
				tmp[k] = v
			end
		end
		return "@dict", unpackDictAndDel(tmp)
	end
	
	local function addSecondaryCondition(t, name, localName)
		local opt = triggers_opt.args[tostring(t)].args.secondary
		local param, default = Parrot_TriggerConditions:GetSecondaryConditionParamDetails(name)
		if not param then
			opt.args[name] = newDict(
				'type', 'execute',
				'buttonText', "---",
				'name', localName,
				'desc', localName,
				'func', function() end,
				'order', -100
			)
			return true
		else
			local tmp = newDict(
				'name', localName,
				'desc', localName,
				'get', function()
					return t.secondaryConditions[name]
				end,
				'set', function(value)
					t.secondaryConditions[name] = value
				end,
				'order', -100
			)
			for k, v in pairs(param) do
				tmp[k] = v
			end
			opt.args[name] = tmp
			if default then
				return default
			end
			if type(param.min) == "number" and type(param.max) == "number" then
				return (param.max + param.min) / 2
			end
			return false
		end
	end
	local function newSecondaryCondition(t, name)
		local opt = triggers_opt.args[tostring(t)].args.secondary
		local localName = Parrot_TriggerConditions:GetSecondaryConditionChoices()[name]
		if not t.secondaryConditions then
			t.secondaryConditions = newList()
		end
		t.secondaryConditions[name] = addSecondaryCondition(t, name, localName)
	end
	local function removeSecondaryCondition(t, name)
		local opt = triggers_opt.args[tostring(t)].args.secondary
		opt.args[name] = del(opt.args[name])
		t.secondaryConditions[name] = nil
		if next(t.secondaryConditions) == nil then
			t.secondaryConditions = del(t.secondaryConditions)
		end
	end
	local function hasNoSecondaryConditions(t)
		return not t.secondaryConditions
	end
	local function hasAllSecondaryConditions(t)
		if not t.secondaryConditions then
			return false
		end
		for k,v in pairs(Parrot_TriggerConditions:GetSecondaryConditionChoices()) do
			if t.secondaryConditions[k] == nil then
				return false
			end
		end
		return true
	end
	local function getAvailableSecondaryConditions(t)
		local tmp = newList()
		for k,v in pairs(Parrot_TriggerConditions:GetSecondaryConditionChoices()) do
			if not t.secondaryConditions or not t.secondaryConditions[k] then
				tmp[k] = v
			end
		end
		return "@dict", unpackDictAndDel(tmp)
	end
	local function getUsedSecondaryConditions(t)
		local tmp = newList()
		for k,v in pairs(Parrot_TriggerConditions:GetSecondaryConditionChoices()) do
			if t.secondaryConditions and t.secondaryConditions[k] then
				tmp[k] = v
			end
		end
		return "@dict", unpackDictAndDel(tmp)
	end
	
	function makeOption(t)
		local opt = {
			type = 'group',
			name = t.name,
			desc = t.name,
			order = t.name == L["New trigger"] and -110 or -100,
			args = {
				output = {
					type = 'string',
					name = L["Output"],
					desc = L["The text that is shown"],
					usage = L['<Text to show>'],
					get = getName,
					set = setName,
					passValue = t,
					order = 1,
				},
				icon = {
					type = 'string',
					name = L["Icon"],
					desc = L["The icon that is shown"],--Note: Spells that are not in the Spellbook (i.e. some Talents) can only be identified by SpellId (retrievable at www.wowhead.com, looking at the URL)
					usage = L['<Spell name> or <Item name> or <Path> or <SpellId>'],
					get = getIcon,
					set = setIcon,
					passValue = t,
				},
				enabled = {
					type = 'boolean',
					name = L["Enabled"],
					desc = L["Whether the trigger is enabled or not."],
					get = getEnabled,
					set = setEnabled,
					passValue = t,
					order = -1,
				},
				remove = {
					type = 'execute',
					buttonText = L["Remove"],
					name = L["Remove trigger"],
					desc = L["Remove this trigger completely."],
					func = remove,
					passValue = t,
					confirm = L["Are you sure?"],
					order = -2,
				},
				color = {
					name = L["Color"],
					desc = L["Color of the text for this trigger."],
					type = 'color',
					get = getColor,
					set = setColor,
					passValue = t,
				},
				sticky = {
					type = 'boolean',
					name = L["Sticky"],
					desc = L["Whether to show this trigger as a sticky."],
					get = getSticky,
					set = setSticky,
					passValue = t,
				},
				classes = {
					type = 'multichoice',
					choices = classChoices,
					name = L["Classes"],
					desc = L["Classes affected by this trigger."],
					get = getClass,
					set = setClass,
					passValue = t,
				},
				scrollArea = {
					type = 'choice',
					choices = Parrot_ScrollAreas:GetScrollAreasChoices(),
					name = L["Scroll area"],
					desc = L["Which scroll area to output to."],
					get = getScrollArea,
					set = setScrollArea,
					passValue = t,
				},
				sound = {
					type = 'choice',
					choices = SharedMedia:List("sound"),
					name = L["Sound"],
					desc = L["What sound to play when the trigger is shown."],
					get = getSound,
					set = setSound,
					passValue = t,
				},
				test = {
					type = 'execute',
					buttonText = L["Test"],
					name = L["Test"],
					desc = L["Test how the trigger will look and act."],
					func = test,
					passValue = t,
				},
				font = {
					type = 'group',
					groupType = 'inline',
					name = L["Custom font"],
					desc = L["Custom font"],
					args = {
						fontface = {
							type = 'choice',
							name = L["Font face"],
							desc = L["Font face"],
							choices = Parrot.inheritFontChoices,
							choiceFonts = SharedMedia:HashTable('font'),
							get = getFontFace,
							set = setFontFace,
							passValue = t,
							order = 1,
						},
						fontSizeInherit = {
							type = 'boolean',
							name = L["Inherit font size"],
							desc = L["Inherit font size"],
							get = getFontSizeInherit,
							set = setFontSizeInherit,
							passValue = t,
							order = 2,
						},
						fontSize = {
							type = 'number',
							name = L["Font size"],
							desc = L["Font size"],
							min = 12,
							max = 30,
							step = 1,
							get = getFontSize,
							set = setFontSize,
							disabled = getFontSizeInherit,
							passValue = t,
							order = 3,
						},
						fontOutline = {
							type = 'choice',
							name = L["Font outline"],
							desc = L["Font outline"],
							get = getFontOutline,
							set = setFontOutline,
							choices = fontOutlineChoices,
							passValue = t,
							order = 4,
						},
					},
				},
				primary = {
					type = 'group',
					groupType = 'inline',
					name = L["Primary conditions"],
					desc = L["When any of these conditions apply, the secondary conditions are checked."],
					args = {
						{
							type = 'choice',
							name = L["New condition"],
							desc = L["Add a new primary condition"],
							choices = getAvailablePrimaryConditions,
							get = false,
							set = newPrimaryCondition,
							disabled = hasAllPrimaryConditions,
							passValue = t,
							order = 1,
						},
						{
							type = 'choice',
							name = L["Remove condition"],
							desc = L["Remove a primary condition"],
							choices = getUsedPrimaryConditions,
							get = false,
							set = removePrimaryCondition,
							disabled = hasNoPrimaryConditions,
							passValue = t,
							order = 2,
						}
					}
				},
				secondary = {
					type = 'group',
					groupType = 'inline',
					name = L["Secondary conditions"],
					desc = L["When all of these conditions apply, the trigger will be shown."],
					args = {
						{
							type = 'choice',
							name = L["New condition"],
							desc = L["Add a new secondary condition"],
							choices = getAvailableSecondaryConditions,
							get = false,
							set = newSecondaryCondition,
							disabled = hasAllSecondaryConditions,
							passValue = t,
							order = 1,
						},
						{
							type = 'choice',
							name = L["Remove condition"],
							desc = L["Remove a secondary condition"],
							choices = getUsedSecondaryConditions,
							get = false,
							set = removeSecondaryCondition,
							disabled = hasNoSecondaryConditions,
							passValue = t,
							order = 2,
						}
					}
				},
			}
		}
		triggers_opt.args[tostring(t)] = opt
		for k,v in pairs(Parrot_TriggerConditions:GetPrimaryConditionChoices()) do
			if t.conditions[k] then
				addPrimaryCondition(t, k, v)
			end
		end
		for k,v in pairs(Parrot_TriggerConditions:GetSecondaryConditionChoices()) do
			if t.secondaryConditions and t.secondaryConditions[k] then
				addSecondaryCondition(t, k, v)
			end
		end
	end
	
	for _,t in ipairs(self.db.profile.triggers) do
		makeOption(t)
	end
end