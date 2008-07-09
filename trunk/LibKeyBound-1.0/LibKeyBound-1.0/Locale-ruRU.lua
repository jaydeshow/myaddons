--[[
	KeyBound localization file
		Russian by ?
--]]

if (GetLocale() ~= "ruRU") then
	return
end

local REVISION = tonumber(("$Revision: 78109 $"):match("%d+"))
if (LibKeyBoundLocale10 and REVISION <= LibKeyBoundLocale10.REVISION) then
	return
end

LibKeyBoundLocale10 = {
	REVISION = REVISION;
	Enabled = 'Bindings mode enabled';
	Disabled = 'Bindings mode disabled';
	ClearTip = format('Press %s to clear all bindings', GetBindingText('ESCAPE', 'KEY_'));
	NoKeysBoundTip = 'No current bindings';
	ClearedBindings = 'Removed all bindings from %s';
	BoundKey = 'Set %s to %s';
	UnboundKey = 'Unbound %s from %s';
	CannotBindInCombat = 'Cannot bind keys in combat';
	CombatBindingsEnabled = 'Exiting combat, keybinding mode enabled';
	CombatBindingsDisabled = 'Entering combat, keybinding mode disabled';
	BindingsHelp = "Hover over a button, then press a key to set its binding.  To clear a button's current keybinding, press %s.";

	-- This is the short display version you see on the Button
	["Alt"] = "A",
	["Ctrl"] = "C",
	["Shift"] = "S",
	["NumPad"] = "N",

	["Backspace"] = "BS",
	["Button1"] = "B1",
	["Button2"] = "B2",
	["Button3"] = "B3",
	["Button4"] = "B4",
	["Button5"] = "B5",
	["Capslock"] = "Cp",
	["Clear"] = "Cl",
	["Delete"] = "Del",
	["End"] = "En",
	["Home"] = "HM",
	["Insert"] = "Ins",
	["Mouse Wheel Down"] = "WD",
	["Mouse Wheel Up"] = "WU",
	["Num Lock"] = "NL",
	["Page Down"] = "PD",
	["Page Up"] = "PU",
	["Scroll Lock"] = "SL",
	["Spacebar"] = "Sp",
	["Tab"] = "Tb",

	["Down Arrow"] = "Dn",
	["Left Arrow"] = "Lf",
	["Right Arrow"] = "Rt",
	["Up Arrow"] = "Up",
}
setmetatable(LibKeyBoundLocale10, {__index = LibKeyBoundBaseLocale10})
