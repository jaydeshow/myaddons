local function _strcontains(str,find)
	str=strlower(str);
	find=strlower(find)
	if str==find then
		return 1
	end
	return strfind(str,find,1,true)
end

local function __Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg,192,0,192,0)
end


local macrobutton=CreateFrame("Button","AutoHealMacroButton",UIParent,"SecureActionButtonTemplate")

local function InitializeMacroButton()
	local str="/script AutoHeal_Start()"
	str=str.."\n".."/target target"
	str=str.."\n".."/target player"
	str=str.."\n".."/target targettarget"
	local i
	for i=1,5 do
		str=str.."\n".."/target party"..i
	end
	for i=1,40 do
		str=str.."\n".."/target raid"..i
	end
	str=str.."\n".."/script AutoHeal_End()"
	
	macrobutton:SetAttribute("type","macro")
	macrobutton:SetAttribute("macrotext",str)
end

InitializeMacroButton()


local _shouldcastheal=nil;
local _healtype=nil;
local _healname=nil;
local _isrunning=nil;
local _targetok=nil;
local _targetid=nil;

function InitAutoHeal(type,spell)
	_healtype=type
	_healname=spell
end

local function CalcTargetHealth(target)
	local health=100*UnitHealth(target)/UnitHealthMax(target)
	if target=="player" or target=="target" or target=="targettarget" then
		health=health-20
	end
	if strsub(target,1,5)=="party" then
		health=health-10
	end
	return health;
end
local function CheckTarget(target)
	if not UnitExists(target) then
		return false
	end
	if not UnitIsVisible(target) then
		return false
	end
	if not UnitIsFriend(target,"player") then
		return false
	end
	if UnitIsDead(target) or UnitIsGhost(target) then
		return false;
	end
	if not IsSpellCastable(_healname,target) then
		return false
	end
	local health=CalcTargetHealth(target)
	if health<_healtype then
		if _targetid then
			if health > CalcTargetHealth(_targetid) then
				return false
			end
		end
		_targetid=target
		return true;
	end
	return false
end

function AutoHeal_Start()
	_isrunning=true
	_shouldcastheal=nil;
	_targetok=nil;
	_targetid=nil;
	CheckTarget("target");
	CheckTarget("player");
	CheckTarget("targettarget");
	local i
	for i=1,5 do
		CheckTarget("party"..i)
	end
	for i=1,40 do
		CheckTarget("raid"..i)
	end
	if _targetid then
		if 100*UnitHealth(_targetid)/UnitHealthMax(_targetid)>_healtype then
			_targetid=nil;
		else
			--__Print("heal..".._targetid);
		end
	end
end
function AutoHeal_End()
	_isrunning=false
end

function CanHealNow()
	return _shouldcastheal
end


local _AM_HandleCondition_=AM_HandleCondition
function AM_HandleCondition(type,msg,target)
	if type=="HEAL" then
		return _shouldcastheal
	end
	return _AM_HandleCondition_(type,msg,target)
end

local function ShouldDoNextTargetCommand(target)
	if _targetid and target==_targetid then
		_shouldcastheal=true;
		_targetok=true;
		return true
	end
	return false
end

local _AM_HandleLine_=AM_HandleLine
function AM_HandleLine(command,msg)
	if _isrunning and command=="/TARGET" then
		if not ShouldDoNextTargetCommand(msg) then
			return true -- handled,skip it.
		end
		return false
	end
	return _AM_HandleLine_(command,msg)
end