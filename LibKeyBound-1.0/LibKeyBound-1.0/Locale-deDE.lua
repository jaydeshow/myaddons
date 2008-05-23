--[[
	LibKeyBound-1.0 localization file
		Deutch by Gamefaq
--]]

if (GetLocale() ~= "deDE") then
	return
end
local LKB = LibStub("LibKeyBound-1.0")

LKB.locale = {
	Enabled = "Tastenzuweisung Modus aktiviert";
	Disabled = "Tastenzuweisung Modus deaktiviert";
	ClearTip = format("Drücke %s um alle Tastenzuweisungen zu löschen", GetBindingText("ESCAPE", "KEY_"));
	NoKeysBoundTip = "Keine Tasten zugewiesen";
	ClearedBindings = "Entferne alle Zuweisungen von %s";
	BoundKey = "Setze %s zu %s";
	UnboundKey = "Entferne %s von %s";
	CannotBindInCombat = "Kann Tasten nicht im Kampf zuweisen";
	CombatBindingsEnabled = "Verlasse Kampf, Tastenzuweisung Modus aktiviert";
	CombatBindingsDisabled = "Beginne Kampf, Tastenzuweisung Modus deaktiviert";
	BindingsHelp = "Schwebe mit der Maus über einem Schalter. Drück dann eine Taste um sie zuzuweisen. Um die Belegung der Taste wieder zu löschen drück %s.";
}