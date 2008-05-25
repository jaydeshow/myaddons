--[[
Name: LibKeyBound-1.0
Revision: $Rev: 75093 $
Author(s): Gello, Maul, Toadkiller, Tuller
Website: http://www.wowace.com/wiki/LibKeyBound-1.0
Documentation: http://www.wowace.com/wiki/LibKeyBound-1.0
SVN: http://svn.wowace.com/wowace/trunk/LibKeyBound-1.0
Description: An intuitive keybindings system: mouseover frame, click keys or buttons.
Dependencies: CallbackHandler-1.0
--]]

local MAJOR = "LibKeyBound-1.0"
local MINOR = "$Revision: 75093 $"

--[[
	LibKeyBound-1.0
		ClickBinder by Gello and TrinityBinder by Maul -> keyBound by Tuller -> LibKeyBound library by Toadkiller

		Functions needed to implement
			button:GetHotkey() - returns the current hotkey assigned to the given button

		Functions to implement if using a custom keybindings system:
			button:SetKey(key) - binds the given key to the given button
			button:FreeKey(key) - unbinds the given key from all other buttons
			button:ClearBindings() - removes all keys bound to the given button
			button:GetBindings() - returns a string listing all bindings of the given button
			button:GetActionName() - what we're binding to, used for printing
--]]

local LibKeyBound, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not LibKeyBound then return end -- no upgrade needed

local _G = _G

-- CallbackHandler
LibKeyBound.events = LibKeyBound.events or _G.LibStub("CallbackHandler-1.0"):New(LibKeyBound)

local L
LibKeyBound.Binder = {}

-- #NODOC
function LibKeyBound:Initialize()
	L = self.locale

	do
		local f = CreateFrame("Frame", "KeyboundDialog", UIParent)
		f:SetFrameStrata("DIALOG")
		f:SetToplevel(true); f:EnableMouse(true)
		f:SetWidth(320); f:SetHeight(96)
		f:SetBackdrop{
			bgFile="Interface\\DialogFrame\\UI-DialogBox-Background" ,
			edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true,
			insets = {left = 11, right = 12, top = 12, bottom = 11},
			tileSize = 32,
			edgeSize = 32,
		}
		f:SetPoint("TOP", 0, -24)
		f:Hide()

		local tr = f:CreateTitleRegion()
		tr:SetAllPoints(f)
		f:SetClampedToScreen(true)

		local text = f:CreateFontString("ARTWORK")
		text:SetFontObject("GameFontHighlight")
		text:SetPoint("TOP", 0, -16)
		text:SetWidth(252); text:SetHeight(0)
		text:SetText(format(L.BindingsHelp, GetBindingText("ESCAPE", "KEY_")))

		local close = CreateFrame("Button", f:GetName() .. "Close", f, "UIPanelCloseButton")
		close:SetPoint("TOPRIGHT", -3, -3)

		-- per character bindings checkbox
		local perChar = CreateFrame("CheckButton", "KeyboundDialogCheck", f, "OptionsCheckButtonTemplate")
		getglobal(perChar:GetName() .. "Text"):SetText(CHARACTER_SPECIFIC_KEYBINDINGS)
		perChar:SetPoint("BOTTOMLEFT", 12, 8)

		perChar:SetScript("OnShow", function(self)
			self.current = GetCurrentBindingSet()
			self:SetChecked(GetCurrentBindingSet() == 2)
		end)

		perChar:SetScript("OnHide", function(self)
			LibKeyBound:Deactivate()

			if InCombatLockdown() then
				self:RegisterEvent("PLAYER_REGEN_ENABLED")
			else
				SaveBindings(self.current)
			end
		end)

		perChar:SetScript("OnEvent", function(self, event)
			SaveBindings(self.current)
			self:UnregisterEvent(event)
		end)

		perChar:SetScript("OnClick", function(self)
			self.current = (self:GetChecked() and 2) or 1
			LoadBindings(self.current)
		end)

		self.dialog = f
	end

	SlashCmdList["LibKeyBoundSlashCOMMAND"] = function() self:Toggle() end
	SLASH_LibKeyBoundSlashCOMMAND1 = "/keybound"
	SLASH_LibKeyBoundSlashCOMMAND2 = "/kb"
	SLASH_LibKeyBoundSlashCOMMAND3 = "/lkb"

	LibKeyBound.initialized = true
end


-- Default color to indicate bindable frames in your mod.
LibKeyBound.colorKeyBoundMode = LibKeyBound.colorKeyBoundMode or { 0, 1, 1, 0.5 }

--[[
LibKeyBound:SetColorKeyBoundMode([r][, g][, b][, a])
--]]
--[[
Notes:
*Returns the color to use on your participating buttons during KeyBound Mode
*Values are unpacked and ready to use as color arguments
Arguments:
	number - red, default 0
	number - green, default 0
	number - blue, default 0
	number - alpha, default 1
Example:
	if (MyMod.keyBoundMode) then
		overlayFrame:SetBackdropColor(LibKeyBound:GetColorKeyBoundMode())
	end
	...
	local r, g, b, a = LibKeyBound:GetColorKeyBoundMode()
--]]
function LibKeyBound:SetColorKeyBoundMode(r, g, b, a)
	r, g, b, a = r or 0, g or 0, b or 0, a or 1
	LibKeyBound.colorKeyBoundMode[1] = r
	LibKeyBound.colorKeyBoundMode[2] = g
	LibKeyBound.colorKeyBoundMode[3] = b
	LibKeyBound.colorKeyBoundMode[4] = a
	LibKeyBound.events:Fire("LIBKEYBOUND_MODE_COLOR_CHANGED")
end

--[[
Notes:
*Returns the color to use on your participating buttons during KeyBound Mode
*Values are unpacked and ready to use as color arguments
Returns:
	* number - red
	* number - green
	* number - blue
	* number - alpha
Example:
	if (MyMod.keyBoundMode) then
		overlayFrame:SetBackdropColor(LibKeyBound:GetColorKeyBoundMode())
	end
	...
	local r, g, b, a = LibKeyBound:GetColorKeyBoundMode()
--]]
function LibKeyBound:GetColorKeyBoundMode()
	return unpack(LibKeyBound.colorKeyBoundMode)
end


function LibKeyBound:PLAYER_REGEN_ENABLED()
	if self.enabled then
		UIErrorsFrame:AddMessage(L.CombatBindingsEnabled, 1, 0.3, 0.3, 1, UIERRORS_HOLD_TIME)
		self.dialog:Hide()
	end
end

function LibKeyBound:PLAYER_REGEN_DISABLED()
	if self.enabled then
		self:Set(nil)
		UIErrorsFrame:AddMessage(L.CombatBindingsDisabled, 1, 0.3, 0.3, 1, UIERRORS_HOLD_TIME)
		self.dialog:Show()
	end
end


--[[
Notes:
 Switches KeyBound Mode between on and off

Example:
	local LibKeyBound = LibStub("LibKeyBound-1.0")
 	LibKeyBound:Toggle()
--]]
function LibKeyBound:Toggle()
	if (LibKeyBound:IsShown()) then
		LibKeyBound:Deactivate()
	else
		LibKeyBound:Activate()
	end
end


--[[
Notes:
 Switches KeyBound Mode to on

Example:
	local LibKeyBound = LibStub("LibKeyBound-1.0")
 	LibKeyBound:Activate()
--]]
function LibKeyBound:Activate()
	if not self:IsShown() then
		if InCombatLockdown() then
			UIErrorsFrame:AddMessage(L.CannotBindInCombat, 1, 0.3, 0.3, 1, UIERRORS_HOLD_TIME)
		else
			self.enabled = true
			if not self.frame then
				self.frame = LibKeyBound.Binder:Create()
			end
			self:Set(nil)
			self.dialog:Show()
			self.events:Fire("LIBKEYBOUND_ENABLED")
		end
	end
end


--[[
Notes:
 Switches KeyBound Mode to off

Example:
	local LibKeyBound = LibStub("LibKeyBound-1.0")
 	LibKeyBound:Deactivate()
--]]
function LibKeyBound:Deactivate()
	if self:IsShown() then
		self.enabled = nil
		self:Set(nil)
		self.dialog:Hide()

		self.events:Fire("LIBKEYBOUND_DISABLED")
	end
end


--[[
Notes:
 Is KeyBound Mode currently on
Returns:
	boolean - true if KeyBound Mode is currently on
Example:
	local LibKeyBound = LibStub("LibKeyBound-1.0")
 	local isKeyBoundMode = LibKeyBound:IsShown()
 	if (isKeyBoundMode) then
 		-- Do something
 	else
 		-- Do another thing
 	end
--]]
function LibKeyBound:IsShown()
	return self.enabled
end


--[[
Notes:
 * Sets up button for keybinding
 * Current bindings are shown in the tooltip
 * Primary binding is shown in green in the button text

Arguments:
	table - the button frame

Example:
function MyButtonClass:OnEnter()
	local button = self.buttonFrame
	if (button.GetHotkey) then
		LibKeyBound:Set(button)
	end
end
--]]
function LibKeyBound:Set(button)
	local bindFrame = self.frame

	if button and self:IsShown() and not InCombatLockdown() then
		bindFrame.button = button
		bindFrame:SetAllPoints(button)

		bindFrame.text:SetFontObject("GameFontNormalLarge")
		bindFrame.text:SetText(button:GetHotkey())
		if bindFrame.text:GetStringWidth() > bindFrame:GetWidth() then
			bindFrame.text:SetFontObject("GameFontNormal")
		end
		bindFrame:Show()
		bindFrame:OnEnter()
	elseif bindFrame then
		bindFrame.button = nil
		bindFrame:ClearAllPoints()
		bindFrame:Hide()
	end
end


--[[
Notes:
 * Shortens the key text (returned from GetBindingKey etc.)
 * Result is suitable for display on a button
 * Can be used for your button:GetHotkey() return value

Arguments:
	string - the keyString to shorten

Returns:
	string - the shortened displayString

Example:
function MyButton:GetHotkey()
	local button = self
	local key1 = GetBindingKey(button:GetName())
	local displayKey = LibKeyBound:ToShortKey(key1)
	return displayKey
end
--]]
function LibKeyBound:ToShortKey(key)
	if key then
		key = key:upper()
		key = key:gsub(" ", "")
		key = key:gsub("ALT%-", "A")
		key = key:gsub("CTRL%-", "C")
		key = key:gsub("SHIFT%-", "S")

		key = key:gsub("NUMPAD", "N")

		key = key:gsub("BACKSPACE", "BS")
		key = key:gsub("PLUS", "%+")
		key = key:gsub("MINUS", "%-")
		key = key:gsub("MULTIPLY", "%*")
		key = key:gsub("DIVIDE", "%/")
		key = key:gsub("HOME", "HN")
		key = key:gsub("INSERT", "Ins")
		key = key:gsub("DELETE", "Del")
		key = key:gsub("BUTTON3", "M3")
		key = key:gsub("BUTTON4", "M4")
		key = key:gsub("BUTTON5", "M5")
		key = key:gsub("MOUSEWHEELDOWN", "WD")
		key = key:gsub("MOUSEWHEELUP", "WU")
		key = key:gsub("PAGEDOWN", "PD")
		key = key:gsub("PAGEUP", "PU")

		return key
	end
end


--[[ Binder Widget ]]--

function LibKeyBound.Binder:Create()
	local binder = CreateFrame("Button")
	binder:RegisterForClicks("anyUp")
	binder:SetFrameStrata("DIALOG")
	binder:EnableKeyboard(true)
	binder:EnableMouseWheel(true)

	for k,v in pairs(self) do
		binder[k] = v
	end

	local bg = binder:CreateTexture()
	bg:SetTexture(0, 0, 0, 0.5)
	bg:SetAllPoints(binder)

	local text = binder:CreateFontString("OVERLAY")
	text:SetFontObject("GameFontNormalLarge")
	text:SetTextColor(0, 1, 0)
	text:SetAllPoints(binder)
	binder.text = text

	binder:SetScript("OnClick", self.OnKeyDown)
	binder:SetScript("OnKeyDown", self.OnKeyDown)
	binder:SetScript("OnMouseWheel", self.OnMouseWheel)
	binder:SetScript("OnEnter", self.OnEnter)
	binder:SetScript("OnLeave", self.OnLeave)
	binder:SetScript("OnHide", self.OnHide)
	binder:Hide()

	return binder
end

function LibKeyBound.Binder:OnHide()
	LibKeyBound:Set(nil)
end

function LibKeyBound.Binder:OnKeyDown(key)
	local button = self.button
	if not button then return end

	if (key == "UNKNOWN" or key == "LSHIFT" or key == "RSHIFT" or
		key == "LCTRL" or key == "RCTRL" or key == "LALT" or key == "RALT" or
		key == "LeftButton" or key == "RightButton") then
		return
	end

	local screenshotKey = GetBindingKey("SCREENSHOT")
	if screenshotKey and key == screenshotKey then
		Screenshot()
		return
	end

	local openChatKey = GetBindingKey("OPENCHAT")
	if openChatKey and key == openChatKey then
		ChatFrameEditBox:Show()
		return
	end

	if key == "MiddleButton" then
		key = "BUTTON3"
	elseif key == "Button4" then
		key = "BUTTON4"
	elseif key == "Button5" then
		key = "BUTTON5"
	end

	if key == "ESCAPE" then
		self:ClearBindings(button)
		LibKeyBound:Set(button)
		return
	end

	if IsShiftKeyDown() then
		key = "SHIFT-" .. key
	end
	if IsControlKeyDown() then
		key = "CTRL-" .. key
	end
	if IsAltKeyDown() then
		key = "ALT-" .. key
	end

	if MouseIsOver(button) then
		self:SetKey(button, key)
		LibKeyBound:Set(button)
	end
end

function LibKeyBound.Binder:OnMouseWheel(arg1)
	if arg1 > 0 then
		self:OnKeyDown("MOUSEWHEELUP")
	else
		self:OnKeyDown("MOUSEWHEELDOWN")
	end
end

function LibKeyBound.Binder:OnEnter()
	local button = self.button
	if button and not InCombatLockdown() then
		if self:GetRight() >= (GetScreenWidth() / 2) then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		end

		if button.GetActionName then
			GameTooltip:SetText(button:GetActionName(), 1, 1, 1)
		else
			GameTooltip:SetText(button:GetName(), 1, 1, 1)
		end

		local bindings = self:GetBindings(button)
		if bindings then
			GameTooltip:AddLine(bindings, 0, 1, 0)
			GameTooltip:AddLine(L.ClearTip)
		else
			GameTooltip:AddLine(L.NoKeysBoundTip, 0, 1, 0)
		end
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end

function LibKeyBound.Binder:OnLeave()
	LibKeyBound:Set(nil)
	GameTooltip:Hide()
end


--[[ Update Functions ]]--

function LibKeyBound.Binder:ToBinding(button)
	return format("CLICK %s:LeftButton", button:GetName())
end

function LibKeyBound.Binder:FreeKey(button, key)
	local msg
	if button.FreeKey then
		local action = button:FreeKey(key)
		if button:FreeKey(key) then
			msg = format(L.UnboundKey, GetBindingText(key, "KEY_"), action)
		end
	else
		local action = GetBindingAction(key)
		if action and action ~= "" and action ~= self:ToBinding(button) then
			msg = format(L.UnboundKey, GetBindingText(key, "KEY_"), action)
		end
	end

	if msg then
		UIErrorsFrame:AddMessage(msg, 1, 0.82, 0, 1, UIERRORS_HOLD_TIME)
	end
end

function LibKeyBound.Binder:SetKey(button, key)
	if InCombatLockdown() then
		UIErrorsFrame:AddMessage(L.CannotBindInCombat, 1, 0.3, 0.3, 1, UIERRORS_HOLD_TIME)
	else
		self:FreeKey(button, key)

		if button.SetKey then
			button:SetKey(key)
		else
			SetBindingClick(key, button:GetName(), "LeftButton")
		end

		local msg
		if button.GetActionName then
			msg = format(L.BoundKey, GetBindingText(key, "KEY_"), button:GetActionName())
		else
			msg = format(L.BoundKey, GetBindingText(key, "KEY_"), button:GetName())
		end
		SaveBindings(GetCurrentBindingSet())
		UIErrorsFrame:AddMessage(msg, 1, 1, 1, 1, UIERRORS_HOLD_TIME)
	end
end

function LibKeyBound.Binder:ClearBindings(button)
	if InCombatLockdown() then
		UIErrorsFrame:AddMessage(L.CannotBindInCombat, 1, 0.3, 0.3, 1, UIERRORS_HOLD_TIME)
	else
		if button.ClearBindings then
			button:ClearBindings()
		else
			local binding = self:ToBinding(button)
			while GetBindingKey(binding) do
				SetBinding(GetBindingKey(binding), nil)
			end
		end

		local msg
		if button.GetActionName then
			msg = format(L.ClearedBindings, button:GetActionName())
		else
			msg = format(L.ClearedBindings, button:GetName())
		end
		SaveBindings(GetCurrentBindingSet())
		UIErrorsFrame:AddMessage(msg, 1, 1, 1, 1, UIERRORS_HOLD_TIME)
	end
end

function LibKeyBound.Binder:GetBindings(button)
	if button.GetBindings then
		return button:GetBindings()
	end

	local keys
	local binding = self:ToBinding(button)
	for i = 1, select("#", GetBindingKey(binding)) do
		local hotKey = select(i, GetBindingKey(binding))
		if keys then
			keys = keys .. ", " .. GetBindingText(hotKey, "KEY_")
		else
			keys = GetBindingText(hotKey, "KEY_")
		end
	end

	return keys
end


if (LibKeyBound.MacroButton) then
	return
end

local MacroButton = CreateFrame("Frame")
LibKeyBound.MacroButton = MacroButton

function MacroButton:Load()
	local i = 1
	local button
	repeat
		button = getglobal(format("MacroButton%d", i))
		if button then
			local OnEnter = button:GetScript("OnEnter")
			button:SetScript("OnEnter", function(self)
				LibKeyBound:Set(self)
				return OnEnter and OnEnter(self)
			end)

			button.GetBindAction = self.GetBindAction
			button.GetActionName = self.GetActionName
			button.SetKey = self.SetKey
			button.GetHotkey = self.GetHotkey
			button.ClearBindings = self.ClearBindings
			button.GetBindings = self.GetBindings
			i = i + 1
		end
	until not button
end

function MacroButton:OnEnter()
	LibKeyBound:Set(self)
end

function MacroButton:GetActionName()
	return GetMacroInfo(MacroFrame.macroBase + self:GetID())
end

-- returns the keybind action of the given button
function MacroButton:GetBindAction()
	return format("MACRO %d", MacroFrame.macroBase + self:GetID())
end

-- binds the given key to the given button
function MacroButton:SetKey(key)
	SetBindingMacro(key, MacroFrame.macroBase + self:GetID())
end

-- removes all keys bound to the given button
function MacroButton:ClearBindings()
	local binding = self:GetBindAction()
	while GetBindingKey(binding) do
		SetBinding(GetBindingKey(binding), nil)
	end
end

-- returns a string listing all bindings of the given button
function MacroButton:GetBindings()
	local keys
	local binding = self:GetBindAction()
	for i = 1, select("#", GetBindingKey(binding)) do
		local hotKey = select(i, GetBindingKey(binding))
		if keys then
			keys = keys .. ", " .. GetBindingText(hotKey, "KEY_")
		else
			keys = GetBindingText(hotKey, "KEY_")
		end
	end
	return keys
end

function MacroButton:GetHotkey()
	return LibKeyBound:ToShortKey(GetBindingKey(self:GetBindAction()))
end

do
	MacroButton:SetScript("OnEvent", function(self, event, addon)
		if (event == "PLAYER_REGEN_DISABLED") then
			LibKeyBound:PLAYER_REGEN_DISABLED()
		elseif (event == "PLAYER_REGEN_ENABLED") then
			LibKeyBound:PLAYER_REGEN_ENABLED()
		elseif (event == "PLAYER_LOGIN" and not LibKeyBound.initialized) then
			LibKeyBound:Initialize()
			MacroButton:UnregisterEvent("PLAYER_LOGIN")
		end
		if addon == "Blizzard_MacroUI" then
			self:UnregisterEvent("ADDON_LOADED")
			self:Load()
		end
	end)
	MacroButton:RegisterEvent("ADDON_LOADED")
	MacroButton:RegisterEvent("PLAYER_LOGIN")
	MacroButton:RegisterEvent("PLAYER_REGEN_ENABLED")
	MacroButton:RegisterEvent("PLAYER_REGEN_DISABLED")
end


local CastButton = {}

function CastButton:Load()
	local i = 1
	local button
	repeat
		button = getglobal('SpellButton' .. i)
		if button then
			button:HookScript('OnEnter', self.OnEnter)

			button.GetBindAction = self.GetBindAction
			button.GetActionName = self.GetActionName
			button.SetKey = self.SetKey
			button.GetHotkey = self.GetHotkey
			button.ClearBindings = self.ClearBindings
			button.GetBindings = self.GetBindings
			i = i + 1
		end
	until not button
end

function CastButton:OnEnter()
	local id = SpellBook_GetSpellID(self:GetID())
	local bookType = SpellBookFrame.bookType

	if not(bookType == BOOKTYPE_PET or IsPassiveSpell(id, bookType)) then
		LibKeyBound:Set(self)
	end
end

function CastButton:GetActionName()
	local name, subName = GetSpellName(SpellBook_GetSpellID(self:GetID()), SpellBookFrame.bookType)
	if(subName and subName ~= '') then
		return format('%s(%s)', name, subName)
	end
	return name
end

-- returns the keybind action of the given button
function CastButton:GetBindAction()
	return format('SPELL %s', self:GetActionName())
end

-- binds the given key to the given button
function CastButton:SetKey(key)
	SetBindingSpell(key, self:GetActionName())
end

-- removes all keys bound to the given button
function CastButton:ClearBindings()
	local binding = self:GetBindAction()
	while GetBindingKey(binding) do
		SetBinding(GetBindingKey(binding), nil)
	end
end

-- returns a string listing all bindings of the given button
function CastButton:GetBindings()
	local keys
	local binding = self:GetBindAction()
	for i = 1, select('#', GetBindingKey(binding)) do
		local hotKey = select(i, GetBindingKey(binding))
		if keys then
			keys = keys .. ', ' .. GetBindingText(hotKey, 'KEY_')
		else
			keys = GetBindingText(hotKey, 'KEY_')
		end
	end
	return keys
end

function CastButton:GetHotkey()
	return LibKeyBound:ToShortKey(GetBindingKey(self:GetBindAction()))
end

CastButton:Load()