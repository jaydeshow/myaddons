--[[
	KeyBound localization file
		Traditional Chinese by ?
--]]

if (GetLocale() ~= "zhTW") then
	return
end
local LKB = LibStub("LibKeyBound-1.0")

LKB.locale = {
	Enabled = "按鍵綁定模式已啟用";
	Disabled = "按鍵綁定模式已停用";
	ClearTip = format("按 %s 清除所有綁定", GetBindingText("ESCAPE", "KEY_"));
	NoKeysBoundTip = "目前没有綁定按鍵";
	ClearedBindings = "從 %s 移除按鍵綁定";
	BoundKey = "設置 %s 到 %s";
	UnboundKey = "取消綁定 %s 从 %s";
	CannotBindInCombat = "不能在戰鬥狀態綁定按鍵";
	CombatBindingsEnabled = "離開戰鬥狀態, 按鍵綁定模式已啟用";
	CombatBindingsDisabled = "進入戰鬥狀態, 按鍵綁定模式已停用";
	BindingsHelp = "將滑鼠停留在按鈕上, 然後按下指定快捷鍵之後就能榜定。  要清除目前榜定的按鈕請按 %s.";
}