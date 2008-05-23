--[[
	KeyBound localization file
		Korean by damjau
--]]

if (GetLocale() ~= "koKR") then
	return
end
local LKB = LibStub("LibKeyBound-1.0")

LKB.locale = {
	Enabled = '단축키 설정 기능 사용 가능';
	Disabled = '단축키 설정 기능 사용 불가';
	ClearTip = format('%s키를 누르면 모든 단축키가 초기화됩니다', GetBindingText('ESCAPE', 'KEY_'));
	NoKeysBoundTip = '현재 단축키 없음';
	ClearedBindings = '%s의 모든 단축키가 초기화 되었습니다';
	BoundKey = '%2$s의 단축키로 %1$s|1을;를; 설정합니다.';
	UnboundKey = '%2$s에서 %1$s의 단축키가 삭제되었습니다';
	CannotBindInCombat = '전투 중에는 단축키를 지정할 수 없습니다';
	CombatBindingsEnabled = '전투 종료. 단축키 설정이 가능해집니다';
	CombatBindingsDisabled = '전투 시작. 단축키 설정이 불가능합니다';
	BindingsHelp = "버튼 위에 마우스를 올려 놓고 지정할 키를 누르세요.  버튼의 현재 단축키를 삭제하시려면 %s|1을;를; 누르세요.";
}