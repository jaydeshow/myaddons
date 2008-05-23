--[[
	LibKeyBound-1.0 localization file
		French by ?
--]]

if (GetLocale() ~= "frFR") then
	return
end
local LKB = LibStub("LibKeyBound-1.0")

LKB.locale = {
	Enabled = "Bindings mode enabled";
	Disabled = "Bindings mode disabled";
	ClearTip = format("Appuyer sur %s pour effacer tous les bindings", GetBindingText("ESCAPE", "KEY_"));
	NoKeysBoundTip = "No current bindings";
	ClearedBindings = "Suppression de tous les binding de %s";
	BoundKey = "Définir %s à %s";
	UnboundKey = "Unbound %s depuis %s";
	CannotBindInCombat = "Cannot bind keys in combat";
	CombatBindingsEnabled = "Sortie de combat, keybinding mode activé";
	CombatBindingsDisabled = "Entrée en combat, keybinding mode désactivé";
	BindingsHelp = "Hover over a button, then press a key to set its binding.  To clear a button's current keybinding, press %s.";
}