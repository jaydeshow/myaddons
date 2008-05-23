--[[
	LibKeyBound-1.0 localization file
		Spanish by StiviS
--]]

if (GetLocale() ~= "esES") then
	return
end
local LKB = LibStub("LibKeyBound-1.0")

LKB.locale = {
	Enabled = 'Modo Atajos activado';
	Disabled = 'Modo Atajos desactivado';
	ClearTip = format('Pulsa %s para limpiar todos los atajos', GetBindingText('ESCAPE', 'KEY_'));
	NoKeysBoundTip = 'No existen atajos';
	ClearedBindings = 'Eliminados todos los atajos de %s';
	BoundKey = 'Establecer %s a %s';
	UnboundKey = 'Quitado atajo %s de %s';
	CannotBindInCombat = 'No se pueden atajar teclas en combate';
	CombatBindingsEnabled = 'Saliendo de combate, modo de Atajos de Teclado activado';
	CombatBindingsDisabled = 'Entrando en combate, modo de Atajos de Teclado desactivado';
	BindingsHelp = "Sitúese en un botón, entonces pulse una tecla para establecer su atajo.  Para limpiar el Atajo del botón actual, pulse %s.";
}
