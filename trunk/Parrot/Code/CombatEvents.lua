local VERSION = tonumber(("$Revision: 51679 $"):match("%d+"))

local Parrot = Parrot
local Parrot_CombatEvents = Parrot:NewModule("CombatEvents", "LibParser-4.0", "LibRockEvent-1.0", "LibRockTimer-1.0")
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2007-10-10 23:54:07 -0400 (Wed, 10 Oct 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end
	
-- #AUTODOC_NAMESPACE Parrot_CombatEvents

local L = Parrot:L("Parrot_CombatEvents")

local RockEvent = Rock("LibRockEvent-1.0")
local RockTimer = Rock("LibRockTimer-1.0")

local SharedMedia = Rock("LibSharedMedia-2.0")

local _G = _G
local UNKNOWN = _G.UNKNOWN
if type(UNKNOWN) ~= "string" then
	UNKNOWN = "Unknown"
end

local _,playerClass = _G.UnitClass("player")

local newList, del, newDict = Rock:GetRecyclingFunctions("Parrot", "newList", "del", "newDict")

Parrot_CombatEvents.db = Parrot:GetDatabaseNamespace("CombatEvents")
Parrot:SetDatabaseNamespaceDefaults("CombatEvents", "profile", {
	['*'] = {
		['*'] = {}
	},
	filters = {},
	throttles = {},
	abbreviateStyle = "abbreviate",
	abbreviateLength = 30,
	stickyCrit = true,
	damageTypes = {
		color = true,
		["Physical"] = "ffffff",
		["Holy"] = "ffff7f",
		["Fire"] = "ff7f7f",
		["Nature"] = "7fff7f",
		["Frost"] = "7f7fff",
		["Shadow"] = "7f007f",
		["Arcane"] = "ff7fff",
	},
	modifier = {
		color = true,
		crit = {
			enabled = false,
			color = "ffffff",
			tag = L["[Text] (crit)"],
		},
		crushing = {
			enabled = true,
			color = "7f0000",
			tag = L["[Text] (crushing)"],
		},
		glancing = {
			enabled = true,
			color = "ff0000",
			tag = L["[Text] (glancing)"],
		},
		absorb = {
			enabled = true,
			color = "ffff00",
			tag = L[" ([Amount] absorbed)"],
		},
		block = {
			enabled = true,
			color = "7f00ff",
			tag = L[" ([Amount] blocked)"],
		},
		resist = {
			enabled = true,
			color = "7f007f",
			tag = L[" ([Amount] resisted)"],
		},
		vulnerable = {
			enabled = true,
			color = "7f7fff",
			tag = L[" ([Amount] vulnerable)"],
		},
		overheal = {
			enabled = true,
			color = "00af7f",
			tag = L[" ([Amount] overheal)"],
		},
	},
})

local combatEvents = {}

local Parrot_Display
local Parrot_ScrollAreas

function Parrot_CombatEvents:OnInitialize()
	Parrot_Display = Parrot:GetModule("Display")
	Parrot_ScrollAreas = Parrot:GetModule("ScrollAreas")
end

local onEnableFuncs = {}
local enabled = false
function Parrot_CombatEvents:OnEnable(first)
	enabled = true
	
	if first then
		local tmp = newList("Notification", "Incoming", "Outgoing")
		for _,category in ipairs(tmp) do
			local t = newList()
			for name, data in pairs(self.db.profile[category]) do
				t[name] = data
				self.db.profile[category][name] = nil
			end
			for name, data in pairs(t) do
				if combatEvents[name] then
					self.db.profile[category][name] = data
					t[name] = nil
				else
					local name_lower = name:lower()
					for k,v in pairs(combatEvents[category]) do
						if k:lower() == name_lower then
							self.db.profile[category][k] = data
							t[name] = nil
							break
						end
					end
					if not t[name] then
						self.db.profile[category][name] = data
					end
				end
			end
			t = del(t)
		end
		tmp = del(tmp)
	end
	
	for _,v in ipairs(onEnableFuncs) do
		v()
	end
end

local onDisableFuncs = {}
function Parrot_CombatEvents:OnDisable()
	enabled = false
	for _,v in ipairs(onDisableFuncs) do
		v()
	end
end

local function utf8trunc(text, num)
	local len = 0
	local i = 1
	local text_len = #text
	while len < num and i <= text_len do
		len = len + 1
		local b = text:byte(i)
		if b <= 127 then
			i = i + 1
		elseif b <= 223 then
			i = i + 2
		elseif b <= 239 then
			i = i + 3
		else
			i = i + 4
		end
	end
	return text:sub(1, i-1)
end

function Parrot_CombatEvents:GetAbbreviatedSpell(name)
	local style = self.db.profile.abbreviateStyle
	if style == "none" then
		return name
	end
	local len = 0
	local i = 1
	local name_len = #name
	while i <= name_len do
		len = len + 1
		local b = name:byte(i)
		if b <= 127 then
			i = i + 1
		elseif b <= 223 then
			i = i + 2
		elseif b <= 239 then
			i = i + 3
		else
			i = i + 4
		end
	end
	local neededLen = self.db.profile.abbreviateLength
	if len < neededLen then
		return name
	end
	if style == "abbreviate" then
		if name:find("[%(%)]") then
			name = name:gsub("%b()", ""):gsub("  +", " "):gsub("^ +", ""):gsub(" +$", "")
		end
		local t = newList((" "):split(name))
		if #t == 1 then
			t = del(t)
			return name
		end
		local i = 0
		while i < #t do
			i = i + 1
			if t[i] == '' then
				table.remove(t, i)
				i = i - 1
			end
		end
		if #t == 1 then
			t = del(t)
			return name
		end
		for i = 1, #t do
			local len
			local b = t[i]:byte(1)
			if b <= 127 then
				len = 1
			elseif b <= 223 then
				len = 2
			elseif b <= 239 then
				len = 3
			else
				len = 4
			end
			if len then
				local alpha, bravo = t[i]:sub(1, len), t[i]:sub(len+1)
				if bravo:find(":") then
					t[i] = alpha .. ":"
				else
					t[i] = alpha
				end
			else
				t[i] = ''
			end
		end
		local s = table.concat(t)
		t = del(t)
		return s
	elseif style == "truncate" then
		local num = neededLen-3
		if num < 3 then
			num = 3
		end
		return utf8trunc(name, neededLen) .. "..."
	end
	return name
end

local function refreshEventRegistration(category, name)
	if not enabled then
		return
	end
	local data = combatEvents[category][name]
	local db = Parrot_CombatEvents.db.profile[category][name]
	local disabled = db.disabled
	if disabled == nil then
		disabled = data.defaultDisabled
	end
	local blizzardEvent = data.blizzardEvent
	local blizzardEvent_ns, blizzardEvent_ev
	if blizzardEvent then
		blizzardEvent_ns, blizzardEvent_ev = (";"):split(blizzardEvent, 2)
		if not blizzardEvent_ev then
			blizzardEvent_ns, blizzardEvent_ev = "Blizzard", blizzardEvent_ns
		end
	end
	local parserEvent = data.parserEvent
	if disabled then
		if blizzardEvent then
			Parrot_CombatEvents:RemoveEventListener(blizzardEvent_ns, blizzardEvent_ev)
		elseif parserEvent then
			Parrot_CombatEvents:RemoveParserListener(parserEvent)
		end
	else
		if blizzardEvent then
			Parrot_CombatEvents:AddEventListener(blizzardEvent_ns, blizzardEvent_ev, function(ns, event, ...)
				local info = newList(...)
				info.namespace = ns
				info.event = event
				info.uid = -RockEvent.currentUID
				Parrot_CombatEvents:TriggerCombatEvent(category, name, info)
				info = del(info)
			end)
		elseif parserEvent then
			Parrot_CombatEvents:AddParserListener(parserEvent, Parrot_CombatEvents.TriggerCombatEvent, Parrot_CombatEvents, category, name)
		end
	end
end

onEnableFuncs[#onEnableFuncs+1] = function()
	assert(enabled)
	for category, q in pairs(combatEvents) do
		for name, data in pairs(q) do
			refreshEventRegistration(category, name)
		end
	end
end

local modifierTranslationHelps

local throttleTypes = {}
local throttleDefaultTimes = {}
local throttleWaitStyles = {}

local filterTypes = {}
local filterDefaults = {}

local function createOption() end
local function createThrottleOption() end
local function createFilterOption() end

local function hexColorToTuple(color)
	local num = tonumber(color, 16)
	return math.floor(num / 256^2)/255, math.floor((num / 256)%256)/255, (num%256)/255
end

function Parrot_CombatEvents:OnOptionsCreate()
	local events_opt
	events_opt = {
		type = 'group',
		name = L["Events"],
		desc = L["Change event settings"],
		disabled = function()
			return not self:IsActive()
		end,
		args = {
			Incoming = {
				type = 'group',
				name = L["Incoming"],
				desc = L["Incoming events are events which a mob or another player does to you."],
				args = {},
				order = 1,
			},
			Outgoing = {
				type = 'group',
				name = L["Outgoing"],
				desc = L["Outgoing events are events which you do to a mob or another player."],
				args = {},
				order = 1,
			},
			Notification = {
				type = 'group',
				name = L["Notification"],
				desc = L["Notification events are available to notify you of certain actions."],
				args = {},
				order = 1,
			},
--			spacer = {
--				type = 'header',
--				order = 3,
--			},
			modifier = {
				type = 'group',
				name = L["Event modifiers"],
				desc = L["Options for event modifiers."],
				args = {
					color = {
						order = 1,
						type = 'boolean',
						name = L["Color"],
						desc = L["Whether to color event modifiers or not."],
						get = function()
							return self.db.profile.modifier.color
						end,
						set = function(value)
							self.db.profile.modifier.color = value
						end
					}
				}
			},
			damageTypes = {
				type = 'group',
				name = L["Damage types"],
				desc = L["Options for damage types."],
				args = {
					color = {
						order = 1,
						type = 'boolean',
						name = L["Color"],
						desc = L["Whether to color damage types or not."],
						get = function()
							return self.db.profile.damageTypes.color
						end,
						set = function(value)
							self.db.profile.damageTypes.color = value
						end
					}
				}
			},
			stickyCrit = {
				type = 'boolean',
				name = L["Sticky crits"],
				desc = L["Enable to show crits in the sticky style."],
				get = function()
					return self.db.profile.stickyCrit
				end,
				set = function(value)
					self.db.profile.stickyCrit = value
				end,
			},
			throttle = {
				type = 'group',
				name = L["Throttle events"],
				desc = L["Whether to merge mass events into single instances instead of excessive spam."],
				args = {},
				hidden = function()
					return not next(events_opt.args.throttle.args)
				end,
			},
			filters = {
				type = 'group',
				name = L["Filters"],
				desc = L["Filters to be checked for a minimum amount of damage/healing/etc before showing."],
				args = {},
				hidden = function()
					return not next(events_opt.args.filters.args)
				end,
			},
			abbreviate = {
				type = 'group',
				name = L["Shorten spell names"],
				desc = L["How or whether to shorten spell names."],
				args = {
					style = {
						type = 'choice',
						name = L["Style"],
						desc = L["How or whether to shorten spell names."],
						get = function()
							return self.db.profile.abbreviateStyle
						end,
						set = function(value)
							self.db.profile.abbreviateStyle = value
						end,
						choices = {
							none = L["None"],
							abbreviate = L["Abbreviate"],
							truncate = L["Truncate"],
						},
						choiceDescs = {
							none = L["Do not shorten spell names."],
							abbreviate = L["Gift of the Wild => GotW."],
							truncate = L["Gift of the Wild => Gift of t..."],
						},
					},
					length = {
						type = 'number',
						name = L["Length"],
						desc = L["The length at which to shorten spell names."],
						get = function()
							return self.db.profile.abbreviateLength
						end,
						set = function(value)
							self.db.profile.abbreviateLength = value
						end,
						disabled = function()
							return self.db.profile.abbreviateStyle == "none"
						end,
						min = 1,
						max = 30,
						step = 1,
					},
				}
			},
		}
	}
	Parrot:AddOption('events', events_opt)
	local tmp = newDict(
		'crit', L["Critical hits/heals"],
		'crushing', L["Crushing blows"],
		'glancing', L["Glancing hits"],
		'absorb', L["Partial absorbs"],
		'block', L["Partial blocks"],
		'resist', L["Partial resists"],
		'vulnerable', L["Vulnerability bonuses"],
		'overheal', L["Overheals"]
	)
	local function getEnabled(passValue)
		return self.db.profile.modifier[passValue].enabled
	end
	local function setEnabled(passValue, value)
		self.db.profile.modifier[passValue].enabled = value
	end
	local function tupleToHexColor(r, g, b)
		return ("%02x%02x%02x"):format(r * 255, g * 255, b * 255)
	end
	local function getTag(passValue)
		return self.db.profile.modifier[passValue].tag
	end
	
	local handler__tagTranslations
	local function handler(literal)
		local inner = literal:sub(2, -2)
		if handler__tagTranslations[inner] then
			return literal
		end
		local inner_lower = inner:lower()
		for k in pairs(handler__tagTranslations) do
			if k:lower() == inner_lower then
				return "[" .. k .. "]"
			end
		end
		return "[" .. inner:gsub("(%b[])", handler) .. "]"
	end
	local function setTag(passValue, value)
		handler__tagTranslations = modifierTranslationHelps[passValue]
		self.db.profile.modifier[passValue].tag = value:gsub("(%b[])", handler)
		handler__tagTranslations = nil
	end
	local function getColor(passValue)
		return hexColorToTuple(self.db.profile.modifier[passValue].color)
	end
	local function setColor(passValue, r, g, b)
		self.db.profile.modifier[passValue].color = tupleToHexColor(r, g, b)
	end
	for k,v in pairs(tmp) do
		local usageT = newList(L["<Text>"])
		local translationHelp = modifierTranslationHelps[k]
		if translationHelp then
			local tmp = newList()
			for k in pairs(translationHelp) do
				tmp[#tmp+1] = k
			end
			table.sort(tmp)
			for _, k in ipairs(tmp) do
				usageT[#usageT+1] = "\n"
				usageT[#usageT+1] = "["
				usageT[#usageT+1] = k
				usageT[#usageT+1] = "] => "
				usageT[#usageT+1] = translationHelp[k]
			end
			tmp = del(tmp)
		end
		local usage = table.concat(usageT)
		usageT = del(usageT)
		events_opt.args.modifier.args[k] = {
			type = 'group',
			name = v,
			desc = v,
			args = {
				enabled = {
					type = 'boolean',
					name = L["Enabled"],
					desc = L["Whether to enable showing this event modifier."],
					get = getEnabled,
					set = setEnabled,
					order = -1,
					passValue = k,
				},
				color = {
					type = 'color',
					name = L["Color"],
					desc = L["What color this event modifier takes on."],
					get = getColor,
					set = setColor,
					passValue = k,
				},
				tag = {
					type = 'string',
					name = L["Text"],
					desc = L["What text this event modifier shows."],
					usage = usage,
					get = getTag,
					set = setTag,
					passValue = k,
				},
			}
		}
	end
	tmp = del(tmp)
	
	local tmp = newDict(
		"Physical", L["Physical"],
		"Holy", L["Holy"],
		"Fire", L["Fire"],
		"Nature", L["Nature"],
		"Frost", L["Frost"],
		"Shadow", L["Shadow"],
		"Arcane", L["Arcane"]
	)
	local function getColor(passValue)
		return hexColorToTuple(self.db.profile.damageTypes[passValue])
	end
	local function setColor(passValue, r, g, b)
		self.db.profile.damageTypes[passValue] = tupleToHexColor(r, g, b)
	end
	for k,v in pairs(tmp) do
		events_opt.args.damageTypes.args[k] = {
			type = 'color',
			name = v,
			desc = L["What color this damage type takes on."],
			get = getColor,
			set = setColor,
			passValue = k,
		}
	end
	tmp = del(tmp)
	local function getTag(category, name)
		return self.db.profile[category][name].tag or combatEvents[category][name].defaultTag
	end
	local function setTag(category, name, value)
		handler__tagTranslations = combatEvents[category][name].tagTranslations
		value = value:gsub("(%b[])", handler)
		handler__tagTranslations = nil
		if combatEvents[category][name].defaultTag == value then
			value = nil
		end
		self.db.profile[category][name].tag = value
	end
	
	local function getColor(category, name)
		return hexColorToTuple(self.db.profile[category][name].color or combatEvents[category][name].color)
	end
	local function setColor(category, name, r, g, b)
		local color = tupleToHexColor(r, g, b)
		local combatEvent = combatEvents[category][name]
		if combatEvent.color == color then
			color = nil
		end
		self.db.profile[category][name].color = color
	end

	local function getSticky(category, name)
		local sticky = self.db.profile[category][name].sticky
		if sticky ~= nil then
			return sticky
		else
			return combatEvents[category][name].sticky
		end
	end
	local function setSticky(category, name, value)
		if (not not combatEvents[category][name].sticky) == value then
			value = nil
		end
		self.db.profile[category][name].sticky = value
	end

	local function getFontFace(category, name)
		local font = self.db.profile[category][name].font
		if font == nil then
			return L["Inherit"]
		else
			return font
		end
	end
	local function setFontFace(category, name, value)
		if value == L["Inherit"] then
			value = nil
		end
		self.db.profile[category][name].font = value
	end
	local function getFontSize(category, name)
		return self.db.profile[category][name].fontSize
	end
	local function setFontSize(category, name, value)
		self.db.profile[category][name].fontSize = value
	end
	local function getFontSizeInherit(category, name)
		return self.db.profile[category][name].fontSize == nil
	end
	local function setFontSizeInherit(category, name, value)
		if value then
			self.db.profile[category][name].fontSize = nil
		else
			self.db.profile[category][name].fontSize = 18
		end
	end
	local function getFontOutline(category, name)
		local outline = self.db.profile[category][name].fontOutline
		if outline == nil then
			return L["Inherit"]
		else
			return outline
		end
	end
	local function setFontOutline(category, name, value)
		if value == L["Inherit"] then
			value = nil
		end
		self.db.profile[category][name].fontOutline = value
	end
	local fontOutlineChoices = {
		NONE = L["None"],
		OUTLINE = L["Thin"],
		THICKOUTLINE = L["Thick"],
		[L["Inherit"]] = L["Inherit"],
	}
	local function getEnable(category, name)
		local disabled = self.db.profile[category][name].disabled
		if disabled == nil then
			disabled = combatEvents[category][name].defaultDisabled
		end
		return not disabled
	end
	local function setEnable(category, name, value)
		local disabled = not value
		if (not not combatEvents[category][name].defaultDisabled) == disabled then
			disabled = nil
		end
		self.db.profile[category][name].disabled = disabled

		refreshEventRegistration(category, name)
	end
	local function getScrollArea(category, name)
		local scrollArea = self.db.profile[category][name].scrollArea
		if scrollArea == nil then
			scrollArea = category
		end
		return scrollArea
	end
	local function setScrollArea(category, name, value)
		if value == category then
			value = nil
		end
		self.db.profile[category][name].scrollArea = value
	end
	local function getSound(category, name)
		return self.db.profile[category][name].sound or "None"
	end
	local function setSound(category, name, value)
		PlaySoundFile(SharedMedia:Fetch('sound', value))
		if value == "None" then
			value = nil
		end
		self.db.profile[category][name].sound = value
	end
	local function resortOptions(category)
		local args = events_opt.args[category].args
		local subcats = newList()
		for k,v in pairs(args) do
			if v.type == "header" then
				subcats[#subcats+1] = k:sub(8)
			end
		end
		table.sort(subcats)
		local num_subcats = #subcats
		local subcatOrders = newList()
		for i,v in ipairs(subcats) do
			subcats[i] = nil
			subcatOrders[v] = i*2-1
		end
		local data = combatEvents[category]
		for k,v in pairs(args) do
			if v.type == "header" then
				v.order = subcatOrders[k:sub(8)]
				v.hidden = num_subcats == 1 or nil
			else
				v.order = subcatOrders[data[k].subCategory]+1
			end
		end
	end
	function createOption(category, name)
		local localName = combatEvents[category][name].localName
		local tagTranslationsHelp = combatEvents[category][name].tagTranslationsHelp
		local usageT = newList(L["<Tag>"])
		if tagTranslationsHelp then
			local tmp = newList()
			for k, v in pairs(tagTranslationsHelp) do
				tmp[#tmp+1] = k
			end
			table.sort(tmp)
			for _, k in ipairs(tmp) do
				usageT[#usageT+1] = "\n"
				usageT[#usageT+1] = "["
				usageT[#usageT+1] = k
				usageT[#usageT+1] = "] => "
				usageT[#usageT+1] = tagTranslationsHelp[k]
			end
		end
		local usage = table.concat(usageT)
		usageT = del(usageT)
		if not events_opt.args[category] then
			events_opt.args[category] = {
				type = 'group',
				name = category,
				desc = category,
				args = {},
				order = 2,
			}
		end
		local subcat = combatEvents[category][name].subCategory
		if not events_opt.args[category].args['subcat_' .. subcat] then
			local name = subcat ~= L["Uncategorized"] and subcat or nil
			events_opt.args[category].args['subcat_' .. subcat] = {
				type = 'header',
				name = name,
				desc = name,
			}
		end
		events_opt.args[category].args[name] = {
			type = 'group',
			name = localName,
			desc = localName,
			args = {
				tag = {
					name = L["Tag"],
					desc = L["Tag to show for the current event."],
					type = 'string',
					usage = usage,
					get = getTag,
					set = setTag,
					passValue = category,
					passValue2 = name,
					order = 1,
				},
				color = {
					name = L["Color"],
					desc = L["Color of the text for the current event."],
					type = 'color',
					get = getColor,
					set = setColor,
					passValue = category,
					passValue2 = name,
				},
				sound = {
					type = 'choice',
					choices = SharedMedia:List("sound"),
					name = L["Sound"],
					desc = L["What sound to play when the current event occurs."],
					get = getSound,
					set = setSound,
					passValue = category,
					passValue2 = name,
				},
				sticky = {
					name = L["Sticky"],
					desc = L["Whether the current event should be classified as \"Sticky\""],
					type = 'boolean',
					get = getSticky,
					set = setSticky,
					passValue = category,
					passValue2 = name,
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
							choiceFonts = SharedMedia:HashTable("font"),
							get = getFontFace,
							set = setFontFace,
							passValue = category,
							passValue2 = name,
							order = 1,
						},
						fontSizeInherit = {
							type = 'boolean',
							name = L["Inherit font size"],
							desc = L["Inherit font size"],
							get = getFontSizeInherit,
							set = setFontSizeInherit,
							passValue = category,
							passValue2 = name,
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
							passValue = category,
							passValue2 = name,
							order = 3,
						},
						fontOutline = {
							type = 'choice',
							name = L["Font outline"],
							desc = L["Font outline"],
							get = getFontOutline,
							set = setFontOutline,
							choices = fontOutlineChoices,
							passValue = category,
							passValue2 = name,
							order = 4,
						},
					}
				},
				enable = {
					order = -1,
					type = 'boolean',
					name = L["Enabled"],
					desc = L["Enable the current event."],
					get = getEnable,
					set = setEnable,
					passValue = category,
					passValue2 = name,
				},
				scrollArea = {
					type = 'choice',
					name = L["Scroll area"],
					desc = L["Which scroll area to use."],
					choices = Parrot_ScrollAreas:GetScrollAreasChoices(),
					get = getScrollArea,
					set = setScrollArea,
					passValue = category,
					passValue2 = name,
				},
			}
		}
		resortOptions(category)
	end
	
	local function getTimespan(throttleType)
		return self.db.profile.throttles[throttleType] or throttleDefaultTimes[throttleType]
	end
	local function setTimespan(throttleType, value)
		if value == throttleDefaultTimes[throttleType] then
			value = nil
		end
		self.db.profile.throttles[throttleType] = value
	end
	function createThrottleOption(throttleType)
		local localName = throttleTypes[throttleType]
		events_opt.args.throttle.args[throttleType] = {
			type = 'number',
			name = localName,
			desc = L["What timespan to merge events within.\nNote: a time of 0s means no throttling will occur."],
			min = 0,
			max = 15,
			step = 0.1,
			bigStep = 1,
			get = getTimespan,
			set = setTimespan,
			passValue = throttleType
		}
	end
	
	local function getAmount(filterType)
		return self.db.profile.filters[filterType] or filterDefaults[filterType]
	end
	local function setAmount(filterType, value)
		if value == filterDefaults[filterType] then
			value = nil
		end
		self.db.profile.filters[filterType] = value
	end
	function createFilterOption(filterType)
		local localName = filterTypes[filterType]
		events_opt.args.filters.args[filterType] = {
			type = 'number',
			name = localName,
			desc = L["What amount to filter out. Any amount below this will be filtered.\nNote: a value of 0 will mean no filtering takes place."],
			min = 0,
			max = 1000,
			step = 1,
			bigStep = 20,
			get = getAmount,
			set = setAmount,
			passValue = filterType
		}
	end
	
	for category, q in pairs(combatEvents) do
		for name, data in pairs(q) do
			createOption(category, name)
		end
	end
	for throttleType in pairs(throttleTypes) do
		createThrottleOption(throttleType)
	end
	for filterType in pairs(filterTypes) do
		createFilterOption(filterType)
	end
end

--[[----------------------------------------------------------------------------------
Arguments:
	table - a data table holding the details of a combat event.
Notes:
	The data table is of the following style:
	<pre>{
		category = "Name of the category in English",
		name = "Name of the condition in English",
		localName = "Name of the condition in the current locale",
		defaultTag = "The default tagstring in the current locale", -- this can and should include relevant tags.
		parserEvent = { -- optional, will cause it to trigger when the filter passes.
			eventType = "Some eventType",
			-- see Parser-3.0 for more details.
		},
		blizzardEvent = "NAME_OF_EVENT", -- optional, will cause it to trigger when the event fires. Incompatible with parserEvent.
		color = "7f7fff", -- some color in the form of "rrggbb",
		tagTranslations = { -- optional, highly recommended
			Amount = "amount",
			Name = "sourceName", -- equivalent to function(info) return info.sourceName end
			Value = function(info)
				return "|cffff0000" .. info.value .. "|r"
			end,
			-- these are mappings of Tag to info table key (or to a function that will be called).
		},
		tagTranslationsHelp = { -- optional
			Amount = "The description of the [Amount] tag in the current locale.",
			Name = "The description of the [Name] tag in the current locale.",
			Value = "The description of the [Value] tag in the current locale.",
		},
		canCrit = true, -- or false/nil. Will cause the event to go sticky on critical.
		throttle = { -- optional
			"Throttle type in English",
			'infoTableKey', -- the key with which to categorize by.
			'throttleCount', -- the key which will be filled based on how many throttled events are in the single instance.
			sourceName = L["Multiple"] -- any key-value mappings will change the info table if there are multiple throttled events.
		},
		filterType = { -- optional
			"Filter type in English",
			'infoTableKey', -- the numeric key with which to check the filter against.
		},
	}</pre>
Example:
	Parrot:RegisterCombatEvent{
		category = "Outgoing",
		name = "Melee dodges",
		localName = L["Melee dodges"],
		defaultTag = L["Dodge!"],
		parserEvent = {
			eventType = "Miss",
			missType = "Dodge",
			sourceID = "player",
			recipientID_not = "player",
			abilityName = false,
		},
		tagTranslations = {
			Name = "recipientName",
		},
		tagTranslationsHelp = {
			Name = L["The name of the enemy you attacked."],
		},
		color = "ffffff", -- white
	}
------------------------------------------------------------------------------------]]
function Parrot_CombatEvents:RegisterCombatEvent(data)
	self = Parrot_CombatEvents -- so people can do Parrot:RegisterCombatEvent
--	AceLibrary.argCheck(self, data, 2, "table") -- TODO
	local category = data.category
	if type(category) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. category must be a %q, got %q."):format("string", type(category)), 2)
	end
	if not data.subCategory then
		-- REMOVE ME LATER
		data.subCategory = L["Uncategorized"]
	end
	local subCategory = data.subCategory
	if type(subCategory) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. subCategory must be a %q, got %q."):format("string", type(subCategory)), 2)
	end
	local name = data.name
	if type(name) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. name must be a %q, got %q."):format("string", type(name)), 2)
	end
	local localName = data.localName
	if type(localName) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. localName must be a %q, got %q."):format("string", type(localName)), 2)
	end
	local defaultTag = data.defaultTag
	if type(defaultTag) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. defaultTag must be a %q, got %q."):format("string", type(defaultTag)), 2)
	end
	local parserEvent = data.parserEvent
	if parserEvent and type(parserEvent) ~= "table" then
		error(("Bad argument #2 to `RegisterCombatEvent'. parserEvent must be a %q or nil, got %q."):format("table", type(parserEvent)), 2)
	end
	local blizzardEvent = data.blizzardEvent
	if blizzardEvent and type(blizzardEvent) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. blizzardEvent must be a %q or nil, got %q."):format("string", type(blizzardEvent)), 2)
	end
	if parserEvent and blizzardEvent then
		error("Bad argument #2 to `RegisterCombatEvent'. blizzardEvent and parserEvent cannot coexist.", 2)
	end
	local tagTranslations = data.tagTranslations
	if tagTranslations and type(tagTranslations) ~= "table" then
		error(("Bad argument #2 to `RegisterCombatEvent'. tagTranslations must be a %q or nil, got %q."):format("table", type(tagTranslations)), 2)
	end
	local tagTranslationsHelp = data.tagTranslationsHelp
	if tagTranslationsHelp and type(tagTranslationsHelp) ~= "table" then
		error(("Bad argument #2 to `RegisterCombatEvent'. tagTranslationsHelp must be a %q or nil, got %q."):format("table", type(tagTranslationsHelp)), 2)
	end
	local color = data.color
	if type(color) ~= "string" then
		error(("Bad argument #2 to `RegisterCombatEvent'. color must be a %q, got %q."):format("string", type(color)), 2)
	end
	if not combatEvents[category] then
		combatEvents[category] = newList()
	end
	combatEvents[category][name] = data
	refreshEventRegistration(category, name)
	
	createOption(category, name)
end
Parrot.RegisterCombatEvent = Parrot_CombatEvents.RegisterCombatEvent

--[[----------------------------------------------------------------------------------
Arguments:
	string - the name of the throttle type in English.
	string - the name of the throttle type in the current locale.
	number - the default duration in seconds.
	boolean - whether to wait for the duration before firing (true) or to fire as long as it hasn't fired in the past duration (false).
Notes:
	waitStyle is good to be set to true in events where you expect multiple hits at once and don't want to show the first hit and then the rest of the hits in one conglomerate chunk. waitStyle is good to be set to false in events where you expect a steady stream but not necessarily one that is coming from a single source.
Example:
	Parrot:RegisterThrottleType("DoTs and HoTs", L["DoTs and HoTs"], 2)
------------------------------------------------------------------------------------]]
function Parrot_CombatEvents:RegisterThrottleType(name, localName, duration, waitStyle)
	self = Parrot_CombatEvents -- for people who want to Parrot:RegisterThrottleType
	
	if type(name) ~= "string" then
		error(("Bad argument #2 to `RegisterThrottleType'. Expected %q, got %q."):format("string", type(name)), 2)
	end
	if type(localName) ~= "string" then
		error(("Bad argument #3 to `RegisterThrottleType'. Expected %q, got %q."):format("string", type(localName)), 2)
	end
	if type(duration) ~= "number" then
		error(("Bad argument #4 to `RegisterThrottleType'. Expected %q, got %q."):format("number", type(duration)), 2)
	end
	
	throttleTypes[name] = localName
	throttleDefaultTimes[name] = duration
	throttleWaitStyles[name] = not not waitStyle
	
	createThrottleOption(name)
end
Parrot.RegisterThrottleType = Parrot_CombatEvents.RegisterThrottleType

--[[----------------------------------------------------------------------------------
Arguments:
	string - the name of the throttle type in English.
	string - the name of the throttle type in the current locale.
	number - the default filter amount.
Notes:
	Filters work by suppressing messages that do not live up to a certain minimum amount.
Example:
	Parrot_CombatEvents:RegisterFilterType("Incoming heals", L["Incoming heals"], 0)
	-- allows for a filter on incoming heals, so that if you don't want to see small heals, it's easy to suppress.
------------------------------------------------------------------------------------]]
function Parrot_CombatEvents:RegisterFilterType(name, localName, default)
	self = Parrot_CombatEvents -- for people who want to Parrot:RegisterFilterType
	
	if type(name) ~= "string" then
		error(("Bad argument #2 to `RegisterFilterType'. Expected %q, got %q."):format("string", type(name)), 2)
	end
	if type(localName) ~= "string" then
		error(("Bad argument #3 to `RegisterFilterType'. Expected %q, got %q."):format("string", type(localName)), 2)
	end
	if type(default) ~= "number" then
		error(("Bad argument #4 to `RegisterFilterType'. Expected %q, got %q."):format("number", type(default)), 2)
	end
	
	filterTypes[name] = localName
	filterDefaults[name] = default
	
	createThrottleOption(name)
end
Parrot.RegisterFilterType = Parrot_CombatEvents.RegisterFilterType

local handler__translation
local handler__info
local function handler(literal)
	local inner = literal:sub(2, -2)
	local value = handler__translation[inner]
	if value then
		if type(value) == "function" then
			return tostring(value(handler__info) or UNKNOWN)
		else
			return tostring(handler__info[value] or UNKNOWN)
		end
	else
		return "[" .. inner:gsub("(%b[])", handler) .. "]"
	end
end

local modifierTranslations = {
	absorb = { Amount = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|cff" .. db.absorb.color .. info.absorbAmount .. "|r"
		else
			return info.absorbAmount
		end
	end },
	block = { Amount = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|cff" .. db.block.color .. info.blockAmount .. "|r"
		else
			return info.blockAmount
		end
	end },
	resist = { Amount = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|cff" .. db.resist.color .. info.resistAmount .. "|r"
		else
			return info.resistAmount
		end
	end },
	vulnerable = { Amount = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|cff" .. db.vulnerable.color .. info.vulnerableAmount .. "|r"
		else
			return info.vulnerableAmount
		end
	end },
	overheal = { Amount = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|cff" .. db.overheal.color .. info.overhealAmount .. "|r"
		else
			return info.overhealAmount
		end
	end },
	glancing = { Text = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|r" .. info[1] .. "|cff" .. db.glancing.color
		else
			return info[1]
		end
	end },
	crushing = { Text = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|r" .. info[1] .. "|cff" .. db.crushing.color
		else
			return info[1]
		end
	end },
	crit = { Text = function(info)
		local db = Parrot_CombatEvents.db.profile.modifier
		if db.color then
			return "|r" .. info[1] .. "|cff" .. db.crit.color
		else
			return info[1]
		end
	end },
}
modifierTranslationHelps = {
	absorb = { Amount = L["The amount of damage absorbed."] },
	block = { Amount = L["The amount of damage blocked."] },
	resist = { Amount = L["The amount of damage resisted."] },
	vulnerable = { Amount = L["The amount of vulnerability bonus."] },
	overheal = { Amount = L["The amount of overhealing."] },
	glancing = { Text = L["The normal text."] },
	crushing = { Text = L["The normal text."] },
	crit = { Text = L["The normal text."] },
}

local throttleData = {}

onEnableFuncs[#onEnableFuncs+1] = function()
	Parrot_CombatEvents:AddRepeatingTimer(0.05, "RunThrottle")
end

local LAST_TIME = _G.newproxy() -- cheaper than {}
local NEXT_TIME = _G.newproxy() -- cheaper than {}

-- #NODOC
function Parrot_CombatEvents:RunThrottle(force)
	local now = GetTime()
	for throttleType,w in pairs(throttleData) do
		local goodTime = now
		local waitStyle = throttleWaitStyles[throttleType]
		if not waitStyle then
			local throttleTime = self.db.profile.throttles[throttleType] or throttleDefaultTimes[throttleType]
			goodTime = now - throttleTime
		end
		for category,v in pairs(w) do
			for name,u in pairs(v) do
				for id,info in pairs(u) do
					if not waitStyle then
						if force or goodTime >= info[LAST_TIME] then
							if next(info) == LAST_TIME and next(info, LAST_TIME) == nil then
								u[id] = del(info)
							else
								self:TriggerCombatEvent(category, name, info, true)
							end
						end
					else
						if force or goodTime >= info[NEXT_TIME] then
							self:TriggerCombatEvent(category, name, info, true)
							u[id] = del(info)
						end
					end
				end
				if not next(u) then
					v[name] = del(u)
				end
			end
			if not next(v) then
				w[category] = del(v)
			end
		end
		if not next(w) then
			throttleData[throttleType] = del(w)
		end
	end
end

local nextFrameCombatEvents = {}
local runCachedEvents
local cancelUIDSoon = {}

--[[----------------------------------------------------------------------------------
Arguments:
	string - the name of the category in English
	string - the name of the event in English
	table - the info table to pass in
	boolean - internal value
Notes:
	info can be any table and is meant to be recycled. The values within it will be exportable through the tagTranslations provided by :RegisterCombatEvent.
Example:
	local tmp = newList()
	tmp.value = 50
	Parrot:TriggerCombatEvent("Notification", "My event", tmp)
	tmp = del(tmp)
------------------------------------------------------------------------------------]]
function Parrot_CombatEvents:TriggerCombatEvent(category, name, info, throttleDone)
	self = Parrot_CombatEvents -- so people can do Parrot:TriggerCombatEvent
	if not Parrot:IsModuleActive(self) then
		return
	end
	if UnitIsDeadOrGhost("player") then
		return
	end
	if cancelUIDSoon[info.uid] then
		return
	elseif not info.uid then
		local uid
		if RockEvent.currentUID then
			uid = -RockEvent.currentUID
		elseif RockTimer.currentUID then
			uid = -RockTimer.currentUID - 1e10
		end
		if cancelUIDSoon[uid] then
			return
		end
	end
	if type(category) ~= "string" then
		error(("Bad argument #2 to `TriggerCombatEvent'. %q expected, got %q."):format("string", type(category)), 2)
		return
	end
	local data = combatEvents[category]
	if not data then
		error(("Bad argument #2 to `TriggerCombatEvent'. %q is an unknown category."):format(category), 2)
		return
	end
	if type(name) ~= "string" then
		error(("Bad argument #3 to `TriggerCombatEvent'. %q expected, got %q."):format("string", type(name)), 2)
		return
	end
	data = data[name]
	if not data then
		error(("Bad argument #3 to `TriggerCombatEvent'. %q is an unknown name for category %q."):format(name, category), 2)
		return
	end
	
	local db = self.db.profile[category][name]
	local disabled = db.disabled
	if disabled == nil then
		disabled = data.defaultDisabled
	end
	if disabled then
		return
	end
	
	if type(info) ~= "table" then
		error(("Bad argument #4 to `TriggerCombatEvent'. %q expected, got %q."):format("table", type(info)), 2)
		return
	end

	local filterType = data.filterType
	if filterType then
		local actualType = filterType[1]
		local filterKey = filterType[2]
		local base = self.db.profile.filters[actualType] or filterDefaults[actualType]
		local info_filterKey
		if type(filterKey) == "function" then
			info_filterKey = filterKey(info)
		else
			info_filterKey = info[filterKey]
		end
		if info_filterKey < base then
			return
		end
	end
	
	if throttleDone then
		if throttleWaitStyles[data.throttle[1]] then
			info[NEXT_TIME] = nil
		else
			info[LAST_TIME] = GetTime()
		end
	elseif data.throttle then	
		local throttle = data.throttle
		local throttleType = throttle[1]
		if (self.db.profile.throttles[throttleType] or throttleDefaultTimes[throttleType]) > 0 then
			if not throttleData[throttleType] then
				throttleData[throttleType] = newList()
			end
			if not throttleData[throttleType][category] then
				throttleData[throttleType][category] = newList()
			end
			if not throttleData[throttleType][category][name] then
				throttleData[throttleType][category][name] = newList()
			end
			local throttleKey = throttle[2]
			local info_throttleKey
			if type(throttleKey) == "function" then
				info_throttleKey = throttleKey(info)
			else
				info_throttleKey = info[throttleKey]
			end
			local throttleCountData = throttle[3]
			local throttleCountKey = throttleCountData[1]
			for i = 2, #throttleCountData-1 do
				local v = throttleCountData[i]
				throttleCountKey = throttleCountKey .. "_" .. v .. "_" .. tostring(info[v])
			end
			local t = throttleData[throttleType][category][name][info_throttleKey]
			if next(info) == nil and getmetatable(info) then
				info = getmetatable(info).__raw
			end
			if t then
				for k, v in pairs(info) do
					if k ~= LAST_TIME and k ~= NEXT_TIME then
						if t[k] == nil then
							t[k] = v
						elseif throttle[k] and t[k] ~= v then
							t[k] = throttle[k]
					 	elseif type(v) == "number" then
							t[k] = t[k] + v
						end
					end
				end
				t[throttleCountKey] = (t[throttleCountKey] or 0) + 1
				return
			else
				t = newList()
				if throttleWaitStyles[throttleType] then
					t[NEXT_TIME] = GetTime() + (self.db.profile.throttles[throttleType] or throttleDefaultTimes[throttleType])
				else
					t[LAST_TIME] = 0
				end
				throttleData[throttleType][category][name][info_throttleKey] = t
				for k, v in pairs(info) do
					t[k] = v
				end
				t[throttleCountKey] = 1
				return
			end
		end
	end
	
	local infoCopy = newList()
	if next(info) == nil and getmetatable(info) then
		info = getmetatable(info).__raw
	end
	for k, v in pairs(info) do
		infoCopy[k] = v
	end
	if not infoCopy.uid then
		local uid
		if RockEvent.currentUID then
			uid = -RockEvent.currentUID
		elseif RockTimer.currentUID then
			uid = -RockTimer.currentUID - 1e10
		end
		infoCopy.uid = uid
	end

	if throttleDone then
		for k in pairs(info) do
			if k ~= LAST_TIME then
				info[k] = nil
			end
		end
	end
	
	if #nextFrameCombatEvents == 0 then
		Parrot_CombatEvents:AddRepeatingTimer("Parrot_CombatEvents-runCachedEvents", 0, runCachedEvents)
	end
	
	nextFrameCombatEvents[#nextFrameCombatEvents+1] = newList(category, name, infoCopy)
end
Parrot.TriggerCombatEvent = Parrot_CombatEvents.TriggerCombatEvent

local function runEvent(category, name, info)
	local db = Parrot_CombatEvents.db.profile[category][name]
	local data = combatEvents[category][name]
	
	local throttle = data.throttle
	local throttleSuffix
	if throttle then
		local throttleType = throttle[1]
		if (Parrot_CombatEvents.db.profile.throttles[throttleType] or throttleDefaultTimes[throttleType]) > 0 then
			local throttleCountData = throttle[3]
			if throttleCountData then
				local func = throttleCountData[#throttleCountData]
				throttleSuffix = func(info)
			end
		end
	end
	
	local sticky = false
	if data.canCrit then
		sticky = info.isCrit and Parrot_CombatEvents.db.profile.stickyCrit
	end
	if not sticky then
		sticky = db.sticky
		if sticky == nil then
			sticky = data.sticky
		end
	end
	local text = db.tag or data.defaultTag
	handler__translation = data.tagTranslations
	handler__info = info
	local icon
	if handler__translation then
		text = text:gsub("(%b[])", handler)
		
		icon = handler__translation.Icon
		if icon then
			if type(icon) == "function" then
				icon = icon(info)
			else
				icon = info[icon]
			end
		end
	end
	
	local t = newList(text)
	local overhealAmount = info.overhealAmount
	local modifierDB = Parrot_CombatEvents.db.profile.modifier
	if overhealAmount and overhealAmount >= 1 then
		if modifierDB.overheal.enabled then
			handler__translation = modifierTranslations.overheal
			t[#t+1] = modifierDB.overheal.tag:gsub("(%b[])", handler)
		end
		text = table.concat(t)
	else
		if modifierDB.absorb.enabled then
			local absorbAmount = info.absorbAmount
			if absorbAmount and absorbAmount >= 1 then
				handler__translation = modifierTranslations.absorb
				t[#t+1] = modifierDB.absorb.tag:gsub("(%b[])", handler)
			end
		end
		if modifierDB.block.enabled then
			local blockAmount = info.blockAmount
			if blockAmount and blockAmount >= 1 then
				handler__translation = modifierTranslations.block
				t[#t+1] = modifierDB.block.tag:gsub("(%b[])", handler)
			end
		end
		if modifierDB.resist.enabled then
			local resistAmount = info.resistAmount
			if resistAmount and resistAmount >= 1 then
				handler__translation = modifierTranslations.resist
				t[#t+1] = modifierDB.resist.tag:gsub("(%b[])", handler)
			end
		end
		if modifierDB.vulnerable.enabled then
			local vulnerableAmount = info.vulnerableAmount
			if vulnerableAmount and vulnerableAmount >= 1 then
				handler__translation = modifierTranslations.vulnerable
				t[#t+1] = modifierDB.vulnerable.tag:gsub("(%b[])", handler)
			end
		end
		text = table.concat(t)
		if info.isGlancing then
			if modifierDB.glancing.enabled then
				handler__translation = modifierTranslations.glancing
				handler__info = newList(text)
				if modifierDB.color then
					text = "|cff" .. modifierDB.glancing.color .. modifierDB.glancing.tag:gsub("(%b[])", handler)
				else
					text = modifierDB.glancing.tag:gsub("(%b[])", handler)
				end
				handler__info = del(handler__info)
			end
		elseif info.isCrushing then
			if modifierDB.crushing.enabled then
				handler__translation = modifierTranslations.crushing
				handler__info = newList(text)
				if modifierDB.color then
					text = "|cff" .. modifierDB.crushing.color .. modifierDB.crushing.tag:gsub("(%b[])", handler)
				else
					text = modifierDB.crushing.tag:gsub("(%b[])", handler)
				end
				handler__info = del(handler__info)
			end
		end
	end
	if info.isCrit then
		if modifierDB.crit.enabled then
			handler__translation = modifierTranslations.crit
			handler__info = newList(text)
			if modifierDB.color then
				text = "|cff" .. modifierDB.crit.color .. modifierDB.crit.tag:gsub("(%b[])", handler)
			else
				text = modifierDB.crit.tag:gsub("(%b[])", handler)
			end
			handler__info = del(handler__info)
		end
	end
	t = del(t)
	handler__translation = nil
	handler__info = nil
	local r, g, b = hexColorToTuple(db.color or data.color)
	
	if throttleSuffix then
		text = text .. throttleSuffix
	end
	Parrot_Display:ShowMessage(text, db.scrollArea or category, sticky, r, g, b, db.font, db.fontSize, db.fontOutline, icon)
	if db.sound then
		PlaySoundFile(SharedMedia:Fetch('sound', db.sound))
	end
end

function runCachedEvents()
	for i,v in ipairs(nextFrameCombatEvents) do
		nextFrameCombatEvents[i] = nil
		runEvent(unpack(v))
		del(v[3])
		del(v)
	end
	
	Parrot_CombatEvents:RemoveTimer("Parrot_CombatEvents-runCachedEvents")
	
	for k in pairs(cancelUIDSoon) do
		cancelUIDSoon[k] = nil
	end
end

function Parrot_CombatEvents:CancelEventsWithUID(uid)
	local i = #nextFrameCombatEvents
	while i >= 1 do
		local v = nextFrameCombatEvents[i]
		if v and uid == v[3].uid then
			table.remove(nextFrameCombatEvents, i)
		end
		i = i - 1
	end
	cancelUIDSoon[uid] = true
end
