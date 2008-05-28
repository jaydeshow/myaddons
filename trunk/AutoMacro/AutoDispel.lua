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


local macrobutton=CreateFrame("Button","AutoDispelMacroButton",UIParent,"SecureActionButtonTemplate")

local function InitializeMacroButton()
	local str="/script AutoDispel_Start()"
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
	str=str.."\n".."/script AutoDispel_End()"
	
	macrobutton:SetAttribute("type","macro")
	macrobutton:SetAttribute("macrotext",str)
end

InitializeMacroButton()


local _shouldcastdispel=nil;
local _dispeltype=nil;
local _dispelname=nil;
local _isrunning=nil;
local _targetok=nil;

function InitAutoDispel(type,spell)
	_dispeltype=type
	_dispelname=spell
end

function AutoDispel_Start()
	_isrunning=true
	_shouldcastdispel=nil;
	_targetok=nil;
end
function AutoDispel_End()
	_isrunning=false
end

function CanDispelNow()
	return _shouldcastdispel
end


local _AM_HandleCondition_=AM_HandleCondition
function AM_HandleCondition(type,msg,target)
	if type=="DISPEL" then
		return _shouldcastdispel
	end
	return _AM_HandleCondition_(type,msg,target)
end

local function ShouldDoNextTargetCommand(target)
	if _targetok then
		return false
	end
	if not UnitExists(target) then
		return false
	end
	if not UnitIsVisible(target) then
		return false
	end
	if not UnitIsFriend(target,"player") then
		return false
	end
	if not IsSpellCastable(_dispelname,target) then
		return false
	end
	local i;
	for i=1,16 do
		local name, rank, iconTexture, count,debuffType, duration, timeLeft = UnitDebuff(target, i);
		if name and debuffType and _strcontains(_dispeltype,debuffType) then
			--__Print("Dispel - ["..UnitName(target).."] - "..debuffType..":"..name)
			_targetok=true
			_shouldcastdispel=true;
			return true
		end
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