if (ZOMGPortalz) then
	ZOMGBuffs:Print("Installation error, duplicate copy of ZOMGBuffs_Portalz (Addons\ZOMGBuffs\ZOMGBuffs_Portalz and Addons\ZOMGBuffs_Portalz)")
	return
end

local L = LibStub("AceLocale-2.2"):new("ZOMGPortalz")
local R = LibStub("AceLocale-2.2"):new("ZOMGReagents")
local SM = LibStub("LibSharedMedia-3.0")
local playerClass

local cos, sin = cos, sin

BINDING_HEADER_ZOMGBUFFS_PORTALZ	= L["ZOMGBUFFS_PORTALZ"]
BINDING_NAME_ZOMGBUFFS_PORTAL_KEY	= L["ZOMGBUFFS_PORTAL_KEY"]

local z = ZOMGBuffs
local module = z:NewModule("ZOMGPortalz")
local portalBinding
ZOMGPortalz = module

z:CheckVersion("$Revision: 82089 $")

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

local function getOption(k)
	return module.db.char[k]
end
local function setOption(k, v)
	module.db.char[k] = v
end

do
	module.consoleCmd = "ZOMGPortalz"
	module.options = {
		type = 'group',
		order = 15,
		name = "|cFFFF8080Z|cFFFFFF80O|cFF80FF80M|cFF8080FFG|cFFFFFFFFPortalz|r",
		desc = L["Portal Configuration"],
		handler = module,
		args = {
			showall = {
				type = 'toggle',
				name = L["Show All"],
				desc = L["Show all portal spells, even if you have not learnt them yet."],
				get = function() return module.db.char.showall end,
				set = function(n) module.db.char.showall = n end,
				order = 1,
			},
			anchor = {
				type = 'toggle',
				name = L["Locked"],
				desc = L["Unlocked, the portals can be dragged using the |cFF00FF00Right Mouse Button|r"],
				get = function() return module.db.char.locked end,
				set = function(n) module.db.char.locked = n end,
				order = 5,
			},
			pattern = {
				type = 'text',
				name = L["Pattern"],
				desc = L["Select the arrangement layout for the portals"],
				validate = {circle = L["Circle"], horz = L["Horizontal"], vert = L["Vertical"], arc = L["Arc"]},
				get = function() return module.db.char.pattern end,
				set = function(n) module.db.char.pattern = n module:SetPoints() module:Draw() end,
				order = 10,
			},
			scale = {
				type = 'range',
				name = L["Scale"],
				desc = L["Adjust the scale of the portals"],
				func = timeFunc,
				get = function() return module.db.char.scale end,
				set = function(n)
					module.db.char.scale = n
					if (module.frame) then
						module.frame:SetScale(n)
						module.frame.text:SetText(L["Portal Spell"])
						module.frame.reagents:SetText(L["Reagent information"])
					end
				end,
				min = 0.2,
				max = 2,
				isPercent = true,
				step = 0.01,
				bigStep = 0.05,
				order = 20,
			},
			spacer = {
				type = 'header',
				name = " ",
				order = 99,
			},
			keybinding = {
				type = 'text',
				name = L["Key-Binding"],
				desc = L["Define the key used for portal popup"],
				validate = "keybinding",
				get = function()
					return GetBindingKey("ZOMGBUFFS_PORTAL")
				end,
				set = function(n)
					local old = GetBindingAction(n)
					if (old and old ~= "") then
						module:Print(KEY_UNBOUND_ERROR, old)
					end

					SetBinding(n, "ZOMGBUFFS_PORTAL")
					SaveBindings(GetCurrentBindingSet())
				end,
				order = 100,
			},
			sticky = {
				type = 'toggle',
				name = L["Sticky"],
				desc = L["When sticky, the portals open on one keypress and close on another. When disabled, you are required to hold the key whilst making your selection."],
				get = function() return module.db.char.sticky end,
				set = function(n) module.db.char.sticky = n end,
				order = 120,
			},
		},
	}
end

-- InitFrames
function module:InitFrames()
	local frame = CreateFrame("Frame", "ZOMGPortalzAnchor", UIParent)
	self.frame = frame
	frame:SetHeight(1)
	frame:SetWidth(1)
	frame:SetMovable(true)

	if (self.db.char.anchorPoint) then
		frame:SetPoint(unpack(self.db.char.anchorPoint))
	else
		frame:SetPoint("CENTER", 0, 155)
	end

	frame:SetScript("OnUpdate",
		function(self, elapsed)
			if (module.mode) then
				module.mode(module, elapsed)
			end
		end)

	frame.text = frame:CreateFontString(nil, "OVERLAY", "ZoneTextFont")
	frame.reagents = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.warning = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.text:SetTextColor(1, 0.9294, 0.7607)
	frame.reagents:SetTextColor(0.7, 0.7, 0.7)
	frame.warning:SetTextColor(1, 0, 0)

	self:SetScale()

	frame:Hide()
end

-- Keybinding
function module:Keybinding(keystate)
	if (InCombatLockdown()) then
		return
	end

	if (self.db.char.sticky) then
		if (keystate == "down") then
			if (module.mode == module.OnUpdateOpening or module.mode == module.OnUpdate) then
				module.mode = module.OnUpdateClosing
			else
				module.mode = module.OnUpdateOpening
				self.frame:Show()
			end
		end
	else
		if (keystate == "down") then
			module.mode = module.OnUpdateOpening
			self.frame:Show()
		else
			module.mode = module.OnUpdateClosing
		end
	end
end

do
	local function buttonOnEnter(self)
		module:OnEnterButton(self)
	end
	local function buttonOnLeave(self)
		module:OnLeaveButton(self)
	end
	local function buttonOnDragStart(self)
		if (not module.db.char.locked) then
			module.frame:StartMoving()
		end
	end
	local function buttonOnDragStop(self)
		module.frame:StopMovingOrSizing()
		module.db.char.anchorPoint = {module.frame:GetPoint(1)}
	end

	-- CreateButton
	function module:CreateButton(city, single, spell, texture)
		local b = CreateFrame("Frame", "ZOMGPortalszButton"..city..(single and "Single" or "Group"), self.frame)
		b:SetWidth(1)
		b:SetHeight(1)

		local d = CreateFrame("Button", nil, b, "SecureActionButtonTemplate")
		b.drawFrame = d
		d:SetFrameLevel(self.frame:GetFrameLevel() - 1)
		d:SetPoint("CENTER")
		d:SetWidth(self.sizeX)
		d:SetHeight(self.sizeY)

		b.single = single
		b.group = not single
		d.single = single
		d.group = not single

		b.tex = b.drawFrame:CreateTexture(nil, "BACKGROUND")
		b.tex:SetTexture(texture)
		b.tex:SetAllPoints()

		d:SetAttribute("*type1", "spell")
		d:SetAttribute("spell", spell)

		d.highlight1 = b.drawFrame:CreateTexture(nil, "OVERLAY")
		d.highlight1:SetBlendMode("ADD")
		d.highlight1:SetAllPoints()
		d.highlight1.angleMod = -2
		d.highlight2 = b.drawFrame:CreateTexture(nil, "OVERLAY")
		d.highlight2:SetBlendMode("ADD")
		d.highlight2:SetAllPoints()
		d.highlight2.angleMod = -2.4
		d.highlight3 = b.drawFrame:CreateTexture(nil, "OVERLAY")
		d.highlight3:SetBlendMode("ADD")
		d.highlight3:SetAllPoints()
		d.highlight3:SetTexture("World\\GENERIC\\ACTIVEDOODADS\\SpellPortals\\Flare")
		d.highlight3:Hide()
		d.highlight3.angleMod = 3.33

		d:SetScript("OnEnter", buttonOnEnter)
		d:SetScript("OnLeave", buttonOnLeave)
		d:SetScript("OnDragStart", buttonOnDragStart)
		d:SetScript("OnDragStop", buttonOnDragStop)
		d:RegisterForDrag("RightButton")

		return b
	end
end

local cycle = {
	"SPELLS\\SHOCKWAVE10",
	"SPELLS\\Shockwave10a",
	"SPELLS\\SHOCKWAVE10B",
	"SPELLS\\SHOCKWAVE10D",
}

local function rotate(angle)
	local zpftA = 0.5 * cos(angle)
	local mzpftA = -zpftA
	local zpftB = 0.5 * sin(angle)
	local mzpftB = -zpftB
	local ULx, ULy = mzpftA - mzpftB, mzpftB + mzpftA
	local LLx, LLy = mzpftA - zpftB, mzpftB + zpftA
	local URx, URy = zpftA - mzpftB, zpftB + mzpftA
	local LRx, LRy = zpftA - zpftB, zpftB + zpftA
	return ULx+0.5, ULy+0.5, LLx+0.5, LLy+0.5, URx+0.5, URy+0.5, LRx+0.5, LRy+0.5
end

-- buttonOnUpdateHighlight
local function buttonOnUpdateHighlight(self, elapsed)
	if (self.dir == 0) then
		self:SetTexture(cycle[self.phase])
		self.dir = 1
	end

	if (self.dir == 1) then
		self.alpha = self.alpha + elapsed
		if (self.alpha > 1) then
			self.alpha = 1
			self.dir = -1
		end
	else
		self.alpha = self.alpha - elapsed
		if (self.alpha <= 0) then
			self.alpha = 0
			self.dir = 1

			if (self.phase ~= -1) then
				self.phase = self.phase + 1
				if (self.phase > #cycle) then
					self.phase = 1
				end
				self:SetTexture(cycle[self.phase])
			end
		end
	end
	
	self.angle = (self.angle or 0) + (elapsed * self.angleMod)
	if (self.angle >= 360) then
		self.angle = self.angle - 360
	end

	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = rotate(self.angle)
	self:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)

	self:SetVertexColor(self.alpha, self.alpha, self.alpha)
end

local function buttonOnUpdate(self, elapsed)
	buttonOnUpdateHighlight(self.highlight1, elapsed)
	buttonOnUpdateHighlight(self.highlight2, elapsed)
	buttonOnUpdateHighlight(self.highlight3, elapsed)
end

-- OnEnterButton
function module:OnEnterButton(button)
	button.highlight1.phase = 1
	button.highlight1.alpha = 0
	button.highlight1.dir = 0
	button.highlight2.phase = 2
	button.highlight2.alpha = 0.5
	button.highlight2.dir = 0
	button.highlight3.dir = 1
	button.highlight3.phase = -1
	button.highlight3.alpha = 0.3
	button.highlight3:Show()
	button:SetScript("OnUpdate", buttonOnUpdate)

	self.frame.text:SetText(button:GetAttribute("spell"))

	local r = button.single and 17031 or 17032
	local count = GetItemCount(r)
	local colourCount
	if (count < 2) then
		colourCount = "|cFFFF4040"
	elseif (count < 5) then
		colourCount = "|cFFFFFF40"
	else
		colourCount = "|cFF40FF40"
	end
	self.frame.reagents:SetFormattedText("Reagents: %s%d|r %s", colourCount, count, GetItemInfo(r))

	self:CheckForWarning(button)
end

-- OnEnterButton
function module:OnLeaveButton(button)
	button:SetScript("OnUpdate", nil)
	button.highlight1:SetTexture(nil)
	button.highlight2:SetTexture(nil)
	button.highlight3:Hide()

	self.frame.text:SetText("")
	self.frame.reagents:SetText("")
	self.frame.warning:SetText("")
end

-- CheckForWarning
function module:CheckForWarning(button)
	local any
	if (button.group) then
		if (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) then
			for unit,unitname in z:IterateRoster(true) do
				if (UnitIsConnected(unit) and UnitIsVisible(unit)) then
					any = true
				end
			end
		end
	end

	if (any) then
		self.frame.warning:SetText(L["Are you sure you're not leaving your friends behind?!"])
	else
		self.frame.warning:SetText("")
	end
end

-- CreatePortal
function module:CreatePortal(info, single, city)
	local spell = single and info.single or info.group
	local show = self.db.char.showall or GetSpellInfo(spell)

	local button = single and info.singleButton or info.groupButton
	if (not button) then
		button = self:CreateButton(city, true, spell, info.tex)
		self:UpdateCooldown(button)
		if (single) then
			info.singleButton = button
		else
			info.groupButton = button
		end
	else
		if (show) then
			button:Show()
			self:UpdateCooldown(button)
		else
			button:Hide()
		end
	end
end

-- CreatePortals
function module:CreatePortals()
	for city,info in pairs(self.portals) do
		self:CreatePortal(info, true, city)
		self:CreatePortal(info, false, city)
	end
end

-- SetScale
function module:SetScale()
	local frame = self.frame
	if (frame) then
		local s = self.db.char.scale
		frame:SetScale(s)

	    local h = min(33, 100 * s)
		frame.text:SetFont("Fonts\\FRIZQT__.TTF", h, "OUTLINE")

		frame.text:SetTextColor(1, 0.9294, 0.7607)
		frame.reagents:SetTextColor(0.7, 0.7, 0.7)
	end
end

-- SetPoints
function module:SetPoints()
	local list = new()
	for city,info in pairs(self.portals) do
		if (self.db.char.showall or GetSpellCooldown(info.single)) then
			tinsert(list, city)
		end
	end
	sort(list)

	local angle, seperatingAngle, offsetX, offsetY

	self.frame.text:ClearAllPoints()
	self.frame.reagents:ClearAllPoints()
	if (self.db.char.pattern == "circle") then
		angle = 0
		seperatingAngle = 360 / #list

		self.frame.text:SetPoint("CENTER")
		self.frame.text:SetJustifyH("CENTER")
		self.frame.text:SetJustifyV("MIDDLE")
		self.frame.reagents:SetPoint("TOP", self.frame.text, "BOTTOM")
		self.frame.warning:SetPoint("TOP", self.frame.reagents, "BOTTOM")

	elseif (self.db.char.pattern == "arc") then
		angle = -30
		seperatingAngle = 60 / (#list - 1)

		self.frame.text:SetPoint("CENTER", 0, -self.distance)
		self.frame.text:SetJustifyH("CENTER")
		self.frame.text:SetJustifyV("TOP")
		self.frame.reagents:SetPoint("TOP", self.frame.text, "BOTTOM")
		self.frame.warning:SetPoint("TOP", self.frame.reagents, "BOTTOM")

	elseif (self.db.char.pattern == "horz") then
		offsetX = -(self.sizeX * ((#list - 1) / 2) * 1.1)
		offsetY = -(self.sizeY / 2)

		self.frame.text:SetPoint("TOP", self.frame, "CENTER", 0, -self.sizeY * 1.1)
		self.frame.text:SetJustifyH("CENTER")
		self.frame.text:SetJustifyV("TOP")
		self.frame.reagents:SetPoint("TOP", self.frame.text, "BOTTOM")
		self.frame.warning:SetPoint("TOP", self.frame.reagents, "BOTTOM")

	elseif (self.db.char.pattern == "vert") then
		offsetX = -(self.sizeX / 2)
		offsetY = -(self.sizeY * ((#list - 1) / 2) * 1.1)

		self.frame.text:SetPoint("LEFT", self.sizeX * 1.1, 0)
		self.frame.text:SetJustifyH("LEFT")
		self.frame.text:SetJustifyV("MIDDLE")
		self.frame.reagents:SetPoint("TOPLEFT", self.frame.text, "BOTTOMLEFT")
		self.frame.warning:SetPoint("TOPLEFT", self.frame.reagents, "BOTTOMLEFT")
	end

	for i = 1,#list do
		local info = self.portals[list[i]]
		assert(info)

		if (self.db.char.pattern == "circle") then
			info.angle = angle
			info.pos = {
				[1] = {
					x = sin(angle) * self.distance * 1.1,
					y = cos(angle) * self.distance * 1.1,
				},
				[2] = {
					x = sin(angle) * self.distance * 2,
					y = cos(angle) * self.distance * 2,
				}
			}
			angle = angle + seperatingAngle

		elseif (self.db.char.pattern == "arc") then
			info.angle = angle
			info.pos = {
				[1] = {
					x = sin(angle) * self.distance * 4,
					y = cos(angle) * self.distance * 4 - (self.distance * 4),
				},
				[2] = {
					x = sin(angle) * self.distance * 5,
					y = cos(angle) * self.distance * 5 - (self.distance * 4),
				}
			}
			angle = angle + seperatingAngle

		elseif (self.db.char.pattern == "horz") then
			info.pos = {
				[1] = {
					x = offsetX,
					y = offsetY,
				},
				[2] = {
					x = offsetX,
					y = offsetY + self.distance,
				}
			}
			offsetX = offsetX + self.sizeX * 1.1

		elseif (self.db.char.pattern == "vert") then
			info.pos = {
				[1] = {
					x = offsetX,
					y = offsetY,
				},
				[2] = {
					x = offsetX + self.distance,
					y = offsetY,
				}
			}
			offsetY = offsetY + self.sizeY * 1.1
		end
	end

	del(list)
end

-- OnUpdateOpening
function module:OnUpdateOpening(elapsed)
	local s = self.expandingState
	if (not s) then
		self.expandingState = true
		self.frame:Show()

		self:CreatePortals()
		self:SetPoints()

		self.scale = 0.001
	end

	self.scale = min(1, self.scale + elapsed * 2)
	if (self.scale >= 1) then
		self.scale = 1
		self.expandingState = nil
		self.mode = self.OnUpdate
	end

	self:Draw()
end

-- Draw
function module:Draw()
	local mx, my = self:GetMouseXY()

	for city,info in pairs(self.portals) do
		if (info.singleButton) then
			if (info.pos and info.singleButton:IsShown()) then
				info.singleButton:SetPoint("CENTER", info.pos[1].x, info.pos[1].y)
				info.singleButton.drawFrame:SetScale(self.scale)
				self:CheckDistance(info.singleButton, mx, my)
				self:OnUpdateCheckCooldown(info.singleButton)
			end
		end
		if (info.groupButton) then
			if (info.pos and info.groupButton:IsShown()) then
				info.groupButton:SetPoint("CENTER", info.pos[2].x, info.pos[2].y)
				info.groupButton.drawFrame:SetScale(self.scale)
				self:CheckDistance(info.groupButton, mx, my)
				self:OnUpdateCheckCooldown(info.groupButton)
			end
		end
	end
end

-- OnUpdateClosing
function module:OnUpdateClosing(elapsed)
	self.expandingState = nil

	local s = self.contractingState
	if (not s) then
		self.contractingState = true
	end

	self.scale = self.scale - elapsed * 2
	if (self.scale <= 0) then
		self.contractingState = nil
		self.scale = 1
		self.frame:Hide()
		self.mode = nil
		return
	end

	self:Draw()
end

-- GetMouseXY
function module:GetMouseXY()
	local mx, my = GetCursorPosition()
    local x, y = self.frame:GetCenter()
    if (mx and x) then
    	x = x * UIParent:GetEffectiveScale()
    	y = y * UIParent:GetEffectiveScale()
	    return mx - x, my - y
	end
end

-- GetMouseXY
function module:GetFrameXY(frame)
	local px, py = self.frame:GetCenter()
	local x, y = frame:GetCenter()
	if (px and x) then
		x = x - px
		y = y - py
		x = x * UIParent:GetEffectiveScale()
		y = y * UIParent:GetEffectiveScale()
	end
	return x, y
end

-- CheckDistance
function module:CheckDistance(frame, mx, my)
	if (not frame or not frame:IsShown()) then
		return
	end

	local x, y = self:GetFrameXY(frame)
	if (x) then
		local distance = abs(x - mx) + abs(y - my)

		if (distance > 100 or frame.drawFrame:IsEnabled() == 0) then
			frame.drawFrame:SetScale(self.scale)
		else
			local factor = (100 - distance) / 100
			local scale = self.scale + ((self.scale * 0.6) * factor)
			frame.drawFrame:SetScale(scale)
		end
	end
end

-- OnUpdate
function module:OnUpdate(elapsed)
	local x, y = self:GetMouseXY()

	if (x) then
		for city,info in pairs(self.portals) do
			self:CheckDistance(info.singleButton, x, y)
			self:CheckDistance(info.groupButton, x, y)
			self:OnUpdateCheckCooldown(info.singleButton)
			self:OnUpdateCheckCooldown(info.groupButton)
		end
	end
end

-- OnUpdateCheckCooldown
function module:OnUpdateCheckCooldown(button)
	if (button and button.endTime) then
		if (GetTime() > button.endTime) then
			button.endTime = nil
			button.drawFrame:Enable()
			button.tex:SetDesaturated(false)
			button.tex:SetVertexColor(1, 1, 1)
		end
	end
end

-- UpdateCooldown
function module:UpdateCooldown(button)
	if (button) then
		local spell = button.drawFrame:GetAttribute("spell")
		local start, dur

		if (spell) then
			start, dur = GetSpellCooldown(spell)
		end

		if (start == 0) then
			button.endTime = nil
			button.drawFrame:Enable()
			button.tex:SetDesaturated(false)
			button.tex:SetVertexColor(1, 1, 1)
		else
			button.endTime = start and start + dur

			button.drawFrame:Disable()

			if (not button.tex:SetDesaturated(true)) then
				button.tex:SetVertexColor(0.5, 0.5, 0.5)
			end
		end
	end
end

-- SPELL_UPDATE_COOLDOWN
function module:SPELL_UPDATE_COOLDOWN()
	for name, info in pairs(self.portals) do
		self:UpdateCooldown(info.singleButton)
		self:UpdateCooldown(info.groupButton)
	end
end

-- PLAYER_REGEN_DISABLED
function module:PLAYER_REGEN_DISABLED()
	self.frame:Hide()
	self.mode = nil
end

-- UNIT_SPELLCAST_START
function module:UNIT_SPELLCAST_SENT(x)
	module.mode = module.OnUpdateClosing
end

-- OnModuleInitialize
function module:OnModuleInitialize()
	playerClass = select(2, UnitClass("player"))
	if (playerClass ~= "MAGE") then
		return
	end

	self.db = z:AcquireDBNamespace("Portalz")
	z:RegisterDefaults("Portalz", "char", {
		pattern = "arc",
		locked = true,
		scale = 1,
		showall = false,
	})

	z:RegisterChatCommand({"/zomgportalz", "/zomgport"}, self.options)
	self.OnMenuRequest = self.options
	z.options.args.ZOMGPortalz = self.options

	if (UnitFactionGroup("player") == "Horde") then
		self.portals = {
			["Dalaran"]			= {group = 53142, single = 53140,	tex = "Interface\\Addons\\ZOMGBuffs\\Textures\\MagePortal_Dalaran"},
			["Shattrath"]		= {group = 35717, single = 35715,	tex = "Interface\\Addons\\ZOMGBuffs\\Textures\\MagePortal_Shattrath"},
			["Orgrimmar"]		= {group = 11417, single = 3567,	tex = "SPELLS\\Ogrimmar_Portal"},
			["Undercity"]		= {group = 11418, single = 3563,	tex = "SPELLS\\Undercity_Portal"},
			["Thunder Bluff"]	= {group = 11420, single = 3566,	tex = "SPELLS\\ThunderBluff_Portal"},
			["Silvermoon"]		= {group = 32267, single = 32272, 	tex = "Interface\\Addons\\ZOMGBuffs\\Textures\\MagePortal_Silvermoon"},
			["Stonard"]			= {group = 49361, single = 49358, 	tex = "World\\GENERIC\\ACTIVEDOODADS\\SpellPortals\\Stonard_Portal"},
		}
	else
		self.portals = {
			["Dalaran"]			= {group = 53142, single = 53140,	tex = "Interface\\Addons\\ZOMGBuffs\\Textures\\MagePortal_Dalaran"},
			["Shattrath"]		= {group = 33691, single = 33690, 	tex = "Interface\\Addons\\ZOMGBuffs\\Textures\\MagePortal_Shattrath"},
			["Stormwind"]		= {group = 10059, single = 3561, 	tex = "World\\GENERIC\\ACTIVEDOODADS\\MAGEPORTALS\\STORMWIND_PORTAL"},
			["Ironforge"]		= {group = 11416, single = 3562, 	tex = "SPELLS\\Ironforge_Portal"},
			["Darnassus"]		= {group = 11419, single = 3565, 	tex = "SPELLS\\Darnassus_Portal"},
			["Exodar"]			= {group = 32266, single = 32271, 	tex = "Interface\\Addons\\ZOMGBuffs\\Textures\\MagePortal_Exodar"},
			["Theramore"]		= {group = 49360, single = 49359, 	tex = "Interface\\Addons\\ZOMGBuffs\\Textures\\MagePortal_Theramore"},
		}
	end

	for name, info in pairs(self.portals) do
		local s = GetSpellInfo(info.single)
		if (s) then
			info.single = GetSpellInfo(info.single)
			info.group = GetSpellInfo(info.group)
		else
			self.portals[name] = nil	-- Removes unknown spells (ie: running on live WoW will not know about Dalaran portal)
		end
	end

	self.OnModuleInitialize = nil
end

-- OnModuleEnable
function module:OnModuleEnable()
	self.distance = 100
	self.sizeX = 80
	self.sizeY = 100

	if (self.db) then
		local class = select(2, UnitClass("player"))
		if (class ~= playerClass and self.OnModuleInitialize) then
			self:OnModuleInitializ()
		end
		if (class ~= "MAGE") then
			return
		end

		self:InitFrames()

		self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("UNIT_SPELLCAST_SENT")
	end
end

-- OnDisable
function module:OnDisable()
end
