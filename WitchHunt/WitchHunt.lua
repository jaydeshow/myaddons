------------------------------
--      Are you local?      --
------------------------------

local times = {}
local L = LibStub("AceLocale-3.0"):GetLocale("WitchHunt")
local db
local frame, sizehandle, msgframe, sizetexture, dragtext
local learned = {} -- contains learned spellIDs for filtering purposes
local formats = {}
local texts = {
	format_cast = L["text_cast"],
	format_spell = L["text_spell"],
	format_gain = L["text_gain"],
	format_fade = L["text_fade"],
	format_dispel = L["text_dispel"],
	format_totem = L["text_totem"],
}

-- local upvales
local fmt = string.format
local bitband = bit.band
local gsb = string.gsub

local function rgb2hex( r, g, b )
	return fmt("|cff%02x%02x%02x", r*255, g*255, b*255)
end

---------------------------------
--      Addon Declaration      --
---------------------------------

WitchHunt = LibStub("AceAddon-3.0"):NewAddon("WitchHunt", "AceEvent-3.0", "LibSink-2.0")
local WitchHunt = WitchHunt

local defaults = {
	profile = {
		combatonly = false,
		targetonly = false,
		font = "normal",
		lock = true,
		insertmode = "TOP",
		sinkOptions = {
			sink20OutputSink = "Witch"
		},
		width = 200,
		height = 160,
		learn = true,
		filtered = {},
		mfiltered = {
			format_cast = true
		},
		colors = {
			format_cast = {
				text = { r =1, g = 1, b = 0 },
				["*"] = { r = 1, g = 1, b = 1 },
			},
			format_spell = {
				text = { r = 1, g = 0, b = 1 },
				["*"] = { r =1, g = 1, b = 1 },
			},
			format_totem = {
				text = { r = 0, g = 1, b = 0 },
				["*"] = { r =1, g = 1, b = 1 },
			},
			format_gain = {
				text = { r = 0, g = 1, b = 1 },
				["*"] = { r =1, g = 1, b = 1 },
			},
			format_fade = {
				text = { r = 0, g = 0, b = 1 },
				["*"] = { r =1, g = 1, b = 1 },
			},
			format_dispel = {
				text = { r = 1, g = 0, b = 0 },
				["*"] = { r =1, g = 1, b = 1 },
			},
		},
	}
}

local function giveColorGroup( messageformat, caster, effect, spellType, order )
	local t = {
		type = "group", inline = true, order = order,
		name = "",
		args = {
			title = {
				type = "header",
				name = function() return WitchHunt:GetFormatted( messageformat, caster, effect) end,
				order = 0,
			},
			character = {
				type = "color",
				name = L["Character"],
				width = "half",
				order = 1,
			},
			text = {
				type = "color",
				name = L["Text"],
				width = "half",
				order = 2,
			},
			spell = {
				type = "color",
				name = spellType,
				width = "half",
				order = 3,
			},
		},
	}
	return t
end

local function giveColors()
	local colors = {
		type = "group",
		name = L["Message Colors"],
		get = function( info )
			local key = info[#info]
			local pkey = info[#info-1]
			return db.colors[pkey][key].r, db.colors[pkey][key].g, db.colors[pkey][key].b, db.colors[pkey][key].a 
		end,
		set = function( info, r, g, b, a )
			local key = info[#info]
			local pkey = info[#info-1]
			db.colors[pkey][key].r = r
			db.colors[pkey][key].g = g
			db.colors[pkey][key].b = b
			db.colors[pkey][key].a = a
			WitchHunt:BuildFormat(pkey)
		end,		
		args = {
			title = {
				type = "description", order = 0,
				name = L["You can change the color for the various messages below."],
			},
		},
	}
	colors.args.format_cast = giveColorGroup("format_cast", "Ammo", "Powers of Death", L["Spell"], 1)
	colors.args.format_spell = giveColorGroup("format_spell", "Ammo", "Powers of Death", L["Spell"], 2)
	colors.args.format_totem = giveColorGroup("format_totem", "Ammo", "Totem of Death", L["Totem"], 3)
	colors.args.format_gain = giveColorGroup("format_gain", "Ammo", "Aura of Death", L["Aura"], 4)
	colors.args.format_fade = giveColorGroup("format_fade", "Ammo", "Aura of Death", L["Aura"], 5)
	colors.args.format_dispel = giveColorGroup("format_dispel", "Ammo", "Aura of Death", L["Aura"], 6)
	return colors
end

local function giveOptions()
	local options = {
		type = "group",
		name = L["Witch Hunt"],
		desc = L["Simple spell alert."],
		get = function( k ) return db[k.arg] end,
		set = function( k, v )
			db[k.arg] = v
			if k.arg == "lock" or k.arg == "font" or k.arg == "insertmode" then
				WitchHunt:UpdateDisplay()
			end
		end,	
		args = {
			descoggle = {
				type = "description", order = 5,
				name = L["You can control the basic behaviour of Witch Hunt using the toggles below."],
			},
			combatonly = {
				name = L["Combat Only"], type = "toggle",
				desc = L["Toggle combat only mode."],
				arg = "combatonly",
				order = 10,
			},
			targetonly = {
				name = L["Target Only"], type = "toggle",
				desc = L["Toggle target only mode."],
				arg = "targetonly",
				order = 20,
			},
			learn = {
				name = L["Learning Mode"], type = "toggle",
				desc = L["Learning mode, when enabled will fill the Spell Filter with spells Witch Hunt has detected. You can turn this off once you're satisfied with your filter."],
				arg = "learn",
				order = 30,
			},
			descframe = {
				name = L["The options below affect the built in Witch Hunt message frame. To select messages sent to this frame select the Message Display option from the tree on the left."],
				type = "description",
				order = 40,
			},
			insertmode = {
				name = L["Insert Mode"], type = "select",
				desc = L["Set the insert mode for the Default frame."],
				values = { TOP = L["Top"], BOTTOM = L["Bottom"]},
				arg = "insertmode",
				order = 60,
			},
			font = {
				name = L["Font"], type = "select",
				desc = L["Set the font for the display of messages in the Default frame."],
				values = {small = L["Small"], normal = L["Normal"], large = L["Large"], huge = L["Huge"]},
				arg = "font",
				order = 70,
			},
			lock = {
				name = L["Lock"], type = "toggle",
				desc = L["Toggle locking of the WitchHunt frame."],
				arg = "lock",
				order = 80,
			},
			desctest = {
				name = L["Click the Test button to send a test message with your current settings."], 
				type = "description",
				order = 90,
			},
			test = {
				name = L["Test"], type = "execute",
				desc = L["Test with a dummy WitchHunt message."],
				func = function()
					WitchHunt:SendMessage("WitchHunt_Message", WitchHunt:GetFormatted("format_cast", "Ammo", "Doom"))
					WitchHunt:SendMessage("WitchHunt_Message", WitchHunt:GetFormatted("format_gain", "Ammo", "Doom"))
				end,
				order= 100,
			}
		}	
	}
	return options
end

local function giveOutput()
	local output = {
		name = L["Message Output"],
		type = "group",
		args ={
			desc = {
				type = "description",
				name = L["You can select where you want Witch Hunt messages displayed from this screen."],
				order = 0,
			},
			sink = WitchHunt:GetSinkAce3OptionsDataTable(),
		}
	}
	-- haxy tricks to make this look good
	output.args.sink.order = 1
	output.args.sink.inline = true
	output.args.sink.name = ""
	return output
end

local filter -- local to the file to access it if needed
local filterArgs
local function giveOneFilter(spellID)
	if not filter then return end
	local name, rank, icon = GetSpellInfo(spellID)
	if rank ~= "" then rank = "("..rank..")" end
	filterArgs["s"..spellID] = {
		order = spellID,
		name = fmt("[%d] %s %s", spellID, name, rank),
		icon = icon,
		type = "toggle",
		arg = spellID,
	}
end

local function giveFilter()
	filter = {
		name = L["Spell Filter"],
		type = "group",
		args = {
			filterdesc = {
				order = 0,
				type = "description",
				name = L["You can select spells to be ignored in future messages from the list below. This list is automatically filled with currently filtered spells and spells you encountered during this session."],
			},
			filters = {
				order = 1, type = "group", name = "", inline = true,
				get = function( k ) return db.filtered[k.arg] end,
				set = function( k, v ) db.filtered[k.arg] = v and v or nil end, -- do not set to false, we cleanup this way since nil values are actually removed
				args = {},
			},
		},
	}
	-- make sure we learn all filtered spells.
	for k, v in pairs(db.filtered) do
		learned[k] = true
	end
	-- fill filter args
	filterArgs = filter.args.filters.args
	for k, v in pairs( learned ) do
		giveOneFilter(k)
	end
	return filter
end

local function giveMFilter()
	local filter = {
		name = L["Message Filter"],
		type = "group",
		args = {
			filterdesc = {
				order = 0,
				type = "description",
				name = L["You can select message types to ignore below."],
			},
			filters = {
				order = 1, type = "group", name = "", inline = true,
				get = function( k ) return db.mfiltered[k.arg] end,
				set = function( k, v ) db.mfiltered[k.arg] = v and v or nil end,
				args = {},
			},
		},
	}
	for k, v in pairs(texts) do
		filter.args.filters.args[k] = {
			type = "toggle",
			name = function()
				if k == "format_totem" then
					return WitchHunt:GetFormatted(k, "Ammo", "Totem of Doom")
				else
					return WitchHunt:GetFormatted(k, "Ammo", "Doom")
				end
			end,
			arg = k,
			width = "full",
		}
	end
	return filter
end

local function giveProfiles()
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(WitchHunt.db)
	return profiles
end

------------------------------
--      Initialization      --
------------------------------

function WitchHunt:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("WitchHunt3DB", defaults, "Default")
	db = self.db.profile

	self:BuildFormats()
	
	self.db.RegisterCallback(self, "OnProfileChanged", "UpdateProfile")
	self.db.RegisterCallback(self, "OnProfileCopied", "UpdateProfile")
	self.db.RegisterCallback(self, "OnProfileReset", "UpdateProfile")	
	
	self:SetSinkStorage(self.db.profile.sinkOptions)
	self:RegisterSink("Witch", L["Witch Hunt"], nil, "WHFramePrint")

	local acreg = LibStub("AceConfigRegistry-3.0")
	
	acreg:RegisterOptionsTable("Witch Hunt", giveOptions)
	acreg:RegisterOptionsTable("Witch Hunt Output", giveOutput)
	acreg:RegisterOptionsTable("Witch Hunt Filter", giveFilter)
	acreg:RegisterOptionsTable("Witch Hunt Profiles", giveProfiles)
	acreg:RegisterOptionsTable("Witch Hunt Colors", giveColors)
	acreg:RegisterOptionsTable("Witch Hunt MFilter", giveMFilter)
	
	local acdia = LibStub("AceConfigDialog-3.0")
	
	acdia:AddToBlizOptions("Witch Hunt", L["Witch Hunt"])
	-- Add them ass backwards to get them in the right order
	acdia:AddToBlizOptions("Witch Hunt Profiles", L["Profiles"], L["Witch Hunt"])
	acdia:AddToBlizOptions("Witch Hunt Filter", L["Spell Filter"], L["Witch Hunt"])
	acdia:AddToBlizOptions("Witch Hunt MFilter", L["Message Filter"], L["Witch Hunt"])
	acdia:AddToBlizOptions("Witch Hunt Output", L["Message Output"], L["Witch Hunt"])
	acdia:AddToBlizOptions("Witch Hunt Colors", L["Message Colors"], L["Witch Hunt"])


end

function WitchHunt:OnEnable()
	-- Register our own events
	self:RegisterMessage("WitchHunt_Message")
	-- Register the WoW events
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	
	-- unlocked frame should be visible
	if not db.lock then self:UpdateDisplay() end
end

function WitchHunt:GetFormatted( format, caster, effect )
	if not formats[format] then self:BuildFormat(format) end
	return gsb( gsb( formats[format], "$c", caster), "$e", effect)
end

function WitchHunt:BuildFormats()
	for k, v in pairs(texts) do
		self:BuildFormat(k)
	end
end

function WitchHunt:BuildFormat( format )
	local t = L[format]
	t = gsb(t, "$t", rgb2hex(db.colors[format].text.r, db.colors[format].text.g, db.colors[format].text.b) .. texts[format] .. "|r")
	t = gsb(t, "$c", rgb2hex(db.colors[format].character.r, db.colors[format].character.g, db.colors[format].character.b) .."$c|r")
	t = gsb(t, "$e", rgb2hex(db.colors[format].spell.r, db.colors[format].spell.g, db.colors[format].spell.b) .."$e|r")
	formats[format] = t
end

function WitchHunt:UpdateProfile()
	db = self.db.profile
	-- make sure we learn all filtered spells.
	for k, v in pairs(db.filtered) do
		learned[k] = true
	end
	self:UpdateDisplay()
	self:RestorePosition()
	self:BuildFormats()
end

function WitchHunt:UpdateDisplay()
	if not msgframe then self:SetupFrames() end
	frame:SetWidth(db.width)
	frame:SetHeight(db.height)
	self:UpdateLock()
	self:SetFont()
	msgframe:SetInsertMode(db.insertmode)
end

function WitchHunt:SetFont()
	if not msgframe then self:SetupFrames() end
	if db.font == "huge" then
		msgframe:SetFontObject(GameFontNormalHuge)
	elseif db.font == "small" then
		msgframe:SetFontObject(GameFontNormalSmall)
	elseif db.font == "large" then
		msgframe:SetFontObject(GameFontNormalLarge)
	else
		msgframe:SetFontObject(GameFontNormal)
	end
end

local function sizeMouseDown()
	frame.isResizing = true
	frame:StartSizing("BOTTOMRIGHT")
end

local function sizeMouseUp()
	frame:StopMovingOrSizing()
	WitchHunt:SaveSize()
	frame.isResizing = false
end

function WitchHunt:SaveSize()
	if not frame.isResizing then return end -- don't do anything on frame creation
	
	db.width = frame:GetWidth()
	db.height = frame:GetHeight()
	
end

function WitchHunt:SetupFrames()
	if frame then return end
	
	frame = CreateFrame("Frame", nil, UIParent)
	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"})
	frame:SetFrameStrata("BACKGROUND")
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	frame:SetBackdropColor(0,1,0)
	frame:SetWidth(db.width)
	frame:SetHeight(db.height)
	frame:Show()
	frame:SetScript("OnDragStart", function() this:StartMoving() end)
	frame:SetScript("OnDragStop", function()
		this:StopMovingOrSizing()
		self:SavePosition()
	end)
	frame:SetClampedToScreen(true)
	frame:SetMinResize(50,20)
	
	sizehandle = CreateFrame("Frame", nil, frame)
	sizehandle:Show()
	sizehandle:SetFrameLevel(frame:GetFrameLevel() + 10) -- place this above everything
	sizehandle:SetWidth(16)
	sizehandle:SetHeight(16)
	sizehandle:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1)
	sizehandle:EnableMouse(true)
	
	sizehandle:SetScript("OnMouseDown", sizeMouseDown)
	sizehandle:SetScript("OnMouseUp", sizeMouseUp)

	sizetexture = sizehandle:CreateTexture(nil,"BACKGROUND")
	sizetexture:SetTexture("Interface\\AddOns\\WitchHunt\\resize")
	sizetexture:SetWidth(16)
	sizetexture:SetHeight(16)
	sizetexture:SetBlendMode("ADD")
	sizetexture:SetPoint("CENTER", sizehandle, "CENTER", 0, 0)
	sizetexture:Show()

	dragtext = frame:CreateFontString(nil,"OVERLAY")
	dragtext:SetFont(GameFontNormal:GetFont())
	dragtext:SetPoint("CENTER", frame, "CENTER")
	dragtext:SetJustifyH("CENTER")
	dragtext:SetJustifyV("MIDDLE")
	dragtext:SetText(L["Witch Hunt"])
	dragtext:Show()
	
	msgframe = CreateFrame("MessageFrame", nil, frame)
	msgframe:ClearAllPoints()
	msgframe:SetAllPoints(frame)
	msgframe:Show()
	msgframe:SetInsertMode(db.insertmode)
	msgframe:SetFrameStrata("HIGH")
	msgframe:SetToplevel(true)

	self:UpdateLock()
	self:SetFont()

	self:RestorePosition()
	
end


function WitchHunt:UpdateLock()
	if db.lock then
		frame:RegisterForDrag()
		frame:EnableMouse(false)
		frame:SetMovable(false)
		frame:SetResizable(false)
		sizehandle:EnableMouse(false)
		frame:SetBackdropColor(0,1,0,0)
		sizetexture:Hide()
		dragtext:Hide()
	else
		frame:RegisterForDrag("LeftButton")
		frame:SetBackdropColor(0,1,0,1)
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:SetResizable(true)
		sizehandle:EnableMouse(true)
		sizetexture:Show()
		dragtext:Show()
	end
end


function WitchHunt:SavePosition()
	if not frame then return end

	if not db.pos then db.pos = {} end
	
	local pos = db.pos
	
	local point, parent, relPoint, x, y = frame:GetPoint()
	local s = frame:GetEffectiveScale()
	x, y = x*s, y*s
	pos.x, pos.y = x, y
	pos.point, pos.relPoint = point, relPoint
end

function WitchHunt:RestorePosition()
	if not frame then return end
	if not db.pos then return end

	local pos = db.pos

	local x, y, s = pos.x, pos.y, frame:GetEffectiveScale()
	local point, relPoint = pos.point, pos.relPoint
	x, y = x/s, y/s
	frame:ClearAllPoints()
	frame:SetPoint(point, UIParent, relPoint, x, y)

end

-- Burn the witch!
function WitchHunt:Burn(caster, effect, format, spellID)
	if not caster or not effect then return end
	if spellID and db.filtered[spellID] then return end
	if format and db.mfiltered[format] then return end
	
	if spellID and db.learn and not learned[spellID] then
		learned[spellID] = true
		giveOneFilter(spellID)
	end

	local text = self:GetFormatted(format, caster, effect)

	local t = GetTime()
	if ( not times[text] ) or ( times[text] and (times[text] + 3) <= t ) then
		times[text] = t
		self:SendMessage("WitchHunt_Message", text)
	end
end

-- Our Sink interface
function WitchHunt:WHFramePrint(addon, message, r, g, b, _, _, _, _, _, icon)
	if not msgframe then self:SetupFrames() end
	msgframe:AddMessage(message, r, g, b, 1, UIERRORS_HOLD_TIME)
end

-- event handlers
function WitchHunt:WitchHunt_Message(event, msg, icon)
	if not msg then return end
	self:Pour(msg, 1, 1, 1, nil, nil, nil, nil, nil, icon)
end

function WitchHunt:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID, spellName, spellSchool, auraType)
	if db.combatonly and not UnitAffectingCombat("player") then return end
	
	local isSourceEnemy = (bitband(srcFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE)
	local isDestEnemy = (bitband(dstFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE)

	if db.targetonly  then
		local isSourceTarget = (bitband(srcFlags, COMBATLOG_OBJECT_TARGET) == COMBATLOG_OBJECT_TARGET)
		local isDestTarget = (bitband(dstFlags, COMBATLOG_OBJECT_TARGET) == COMBATLOG_OBJECT_TARGET)
		-- evil but it'll make sure it bails out afterwards :)
		if isSourceEnemy and not isSourceTarget then isSourceEnemy = false end
		if isDestEnemy and not isDestTarget then isDestEnemy = false end
	end
	
	if not isDestEnemy and not isSourceEnemy then return end

	if eventType == "SPELL_AURA_APPLIED" and isDestEnemy and auraType == "BUFF" then
		self:Burn( dstName, spellName, "format_gain", spellID )
	elseif eventType == "SPELL_AURA_REMOVED" and isDestEnemy and auraType == "BUFF" then
		self:Burn( dstName, spellName, "format_fade", spellID )
	elseif isDestEnemy and (eventType == "SPELL_AURA_DISPELLED" or eventType == "SPELL_AURA_STOLEN") then
		self:Burn( dstName, spellName, "format_dispel", spellID )
	elseif eventType == "SPELL_CAST_START" and isSourceEnemy then
		self:Burn( srcName, spellName, "format_cast", spellID )
    elseif eventType == "SPELL_CAST_SUCCESS" and isSourceEnemy then
		if spellName:find(L["Totem"]) then
			self:Burn( srcName, spellName, "format_totem", spellID )
		else
			self:Burn( srcName, spellName, "format_spell", spellID )
		end
	end
end

