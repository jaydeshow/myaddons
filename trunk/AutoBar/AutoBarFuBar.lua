--
-- AutoBarFuBar
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- FuBar support for AutoBar
-- http://code.google.com/p/autobar/
--
--[[ $Id: AutoBarFuBar.lua 40066 2007-06-15 5:16:47Z Toadkiller $ ]]

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 559 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

AutoBarFuBar = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AutoBarConsole-1.0", "FuBarPlugin-2.0")
local AutoBarFuBar = AutoBarFuBar

local L = AutoBar.locale

AutoBarFuBar.name = AutoBar.name
AutoBarFuBar.version = AutoBar.version
AutoBarFuBar.revision = AutoBar.revision
AutoBarFuBar.date = AutoBar.date
AutoBarFuBar.hasIcon = "Interface\\Icons\\INV_Ingot_Eternium"
AutoBarFuBar.hasNoColor = true
AutoBarFuBar.defaultMinimapPosition = 265
AutoBarFuBar.clickableTooltip = false
AutoBarFuBar.hideWithoutStandby = true
AutoBarFuBar.independentProfile = true
AutoBarFuBar.cannotDetachTooltip = true

local LibKeyBound = LibStub:GetLibrary("LibKeyBound-1.0")
local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0")

function AutoBarFuBar:OnInitialize()
	self.db = AutoBar:AcquireDBNamespace("fubar")

	AutoBar.options.args.fubarSpacer = {
		order = 160,
		type = "header",
	}
	AutoBar.options.args.fubar = {
		order = 161,
		type = "group",
		name = L["FuBarPlugin Config"],
		desc = L["Configure the FuBar Plugin"],
		args = {},
	}
	AceLibrary("AutoBarConsole-1.0"):InjectAceOptionsTable(self, AutoBar.options.args.fubar)

	-- Delete irrelevant and dangerous options
	AutoBar.options.args.profile = nil
	if (AutoBar:IsActive()) then
		AutoBar.options.args.standby = nil
	end

	self.OnMenuRequest = AutoBar.options
end
-- /script AutoBar:Print(AutoBar:IsActive())

local Tablet = AceLibrary("Tablet-2.0")
local hintText
-- FuBar Stuff
function AutoBarFuBar:OnTooltipUpdate()
	local cat = Tablet:AddCategory("columns", 2)
	if (not hintText) then
		hintText = table.concat({
			L["\n|cffffffff%s:|r %s"]:format(L["Left-Click"], L["Options GUI"]),
			L["\n|cffffffff%s:|r %s"]:format(L["Right-Click"], L["Dropdown UI"]),
			L["\n|cffffffff%s:|r %s"]:format(L["Alt-Click"], L["Key Bindings"]),
			L["\n|cffffffff%s:|r %s"]:format(L["Ctrl-Click"], L["Move the Buttons"]),
			L["\n|cffffffff%s:|r %s"]:format(L["Shift-Click"], L["Move the Bars"]),
			L["\n|cffffffff%s:|r %s"]:format(L["Ctrl-Shift-Click"], L["Skin the Buttons"]),
	})
	end
	Tablet:SetHint(hintText)
end

function AutoBarFuBar:OnClick(button)
	if (IsControlKeyDown() and IsShiftKeyDown()) then
		AutoBar:SkinModeToggle()
	elseif (IsShiftKeyDown()) then
		AutoBar:MoveBarModeToggle()
	elseif (IsControlKeyDown()) then
		AutoBar:MoveButtonsModeToggle()
	elseif (IsAltKeyDown()) then
		LibKeyBound:Toggle()
	else
		if (waterfall) then
			AutoBar:ConfigToggle()
		else
			self:Print(L["Waterfall-1.0 is required to access the GUI"])
		end
	end
	self:UpdateDisplay()
end
