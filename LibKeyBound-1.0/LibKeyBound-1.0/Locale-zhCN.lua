--[[
	KeyBound localization file
		Chinese Simplified by ondh - http://www.ondh.cn
--]]

if (GetLocale() ~= "zhCN") then
	return
end
local LKB = LibStub("LibKeyBound-1.0")

LKB.locale = {
	Enabled = "按键绑定模式已启用";
	Disabled = "按键绑定模式已禁用";
	ClearTip = format("按 %s 清除所有绑定", GetBindingText("ESCAPE", "KEY_"));
	NoKeysBoundTip = "当前没有绑定按键";
	ClearedBindings = "从 %s 移除按键绑定";
	BoundKey = "设置 %s 到 %s";
	UnboundKey = "取消绑定 %s 从 %s";
	CannotBindInCombat = "不能在战斗状态绑定按键";
	CombatBindingsEnabled = "离开战斗状态, 按键绑定模式已启用";
	CombatBindingsDisabled = "进入战斗状态, 按键绑定模式已禁用";
	BindingsHelp = "将鼠标停留在按钮上, 然后按下指定快捷键之后就能榜定。  要清除目前榜定的按钮请按";
}