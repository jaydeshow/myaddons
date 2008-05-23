--[[
	LibKeyBound-1.0 localization file
		Deutch by ?
--]]

if (GetLocale() ~= "deDE") then
	return
end
local LKB = LibStub("LibKeyBound-1.0")

LKB.locale = {
	Enabled = "Bindings mode enabled";
	Disabled = "Bindings mode disabled";
	ClearTip = format("Press %s to clear all bindings", GetBindingText("ESCAPE", "KEY_"));
	NoKeysBoundTip = "No current bindings";
	ClearedBindings = "Removed all bindings from %s";
	BoundKey = "Set %s à %s";
	UnboundKey = "Unbound %s from %s";
	CannotBindInCombat = "Cannot bind keys in combat";
	CombatBindingsEnabled = "Exiting combat, keybinding mode enabled";
	CombatBindingsDisabled = "Entering combat, keybinding mode disabled";
	BindingsHelp = "Hover over a button, then press a key to set its binding.  To clear a button's current keybinding, press %s.";
}