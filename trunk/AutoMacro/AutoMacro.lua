
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

local function __test()
end

--TODO:cache the result!
local function __GetSpellIndex(spell)

	local index=0
	local count=0
	local i;
	for i=1,MAX_SPELLS,1 do
		local name,rank=GetSpellName(i,BOOKTYPE_SPELL)
		if not name then
			break
		end
		local fullname = name.."("..rank..")";
		local match=_strcontains(fullname,spell);
		if not match then
			local texture=GetSpellTexture(i,BOOKTYPE_SPELL)
			match=_strcontains(texture,spell);
		end
		if match then
			if index==0 then
				index=i
				count=1
			else
				count=count+1
			end
		else
			if index~=0 then
				break
			end
		end
	end
	
	if index==0 then
		--__Print("__GetSpellIndex not found :"..spell)
		return nil,nil
	end
	
	return index,count
end
function AM_InRange(spell)
	local index,count=__GetSpellIndex(spell)
	if index then
		if IsSpellInRange(index,BOOKTYPE_SPELL)~=0 then
			return true
		end
	end
end
function AM_InCD(spell)
	local index,count=__GetSpellIndex(spell)
	if index then
		local start,duration,enable=GetSpellCooldown(index,BOOKTYPE_SPELL)
		if (start>0 and duration>2) then
			return true
		end
	else
		return true
	end
end
function IsSpellCastable(spell,target)

	local index,count=__GetSpellIndex(spell)
	if index then
		if IsUsableSpell(index,BOOKTYPE_SPELL,target) and IsSpellInRange(index,BOOKTYPE_SPELL,target)~=0 then
			local start,duration,enable=GetSpellCooldown(index,BOOKTYPE_SPELL)
			if not (start>0 and duration>2) then
				return spell;
			end
		end
		return
	end

	local item,bag,slot;
	item=GetItemInfo(spell)
	if not item then
		item,bag,slot=SecureCmdItemParse(spell)
	end
	if item then
		if GetItemCooldown(item)>0 then
			return
		end
		return item;
	end

end
function FindCastableSpell(...)
	local i;
	for i=1,select("#",...) do
		local spell=IsSpellCastable(select(i,...));
		if spell then
			return spell
		end
	end
end

function UnitBuffIndex(unit,nameoricon)
	local i=0
	for i=1,16 do
		local name, rank, iconTexture, count, duration, timeLeft = UnitBuff(unit, i);
		if name and iconTexture then
			if _strcontains(name,nameoricon) then
				return i,name, rank, iconTexture, count, duration, timeLeft
			end
			if _strcontains(iconTexture,nameoricon) then
				return i,name, rank, iconTexture, count, duration, timeLeft
			end
		end
	end
end

function UnitDebuffIndex(unit,nameoricon,notimecheck)
	local i=0
	for i=1,16 do
		local name, rank, iconTexture, count,debuffType, duration, timeLeft = UnitDebuff(unit, i);
		if name and iconTexture then
			if _strcontains(name,nameoricon) then
				return i,name, rank, iconTexture, count,debuffType, duration, timeLeft
			end
			if _strcontains(iconTexture,nameoricon) then
				return i,name, rank, iconTexture, count,debuffType, duration, timeLeft
			end
		end
	end
end

function UnitDebuffStack(unit,nameoricon,notimecheck)
	local i=0
	for i=1,16 do
		local name, rank, iconTexture, count,debuffType, duration, timeLeft = UnitDebuff(unit, i);
		if name and iconTexture then
			if _strcontains(name,nameoricon) and (notimecheck or timeLeft~=nil) then
				return count
			end
			if _strcontains(iconTexture,nameoricon) and (notimecheck or timeLeft~=nil) then
				return count
			end
		end
	end
end

function UnitHasSpellEffect(unit,spell,notimecheck)
	if not UnitExists(unit) then
		return nil
	end
	local index,name, rank, iconTexture, count, duration, timeLeft=UnitBuffIndex(unit,spell,notimecheck)
	if index then
		return timeLeft or notimecheck or 20
	end
	local index,name, rank, iconTexture, count,debuffType, duration, timeLeft=UnitDebuffIndex(unit,spell,notimecheck)
	if index then
		return timeLeft or notimecheck or 20
	end
	
	local index,count=__GetSpellIndex(spell)
	if not index then
		return nil
	end
	local texture=GetSpellTexture(index,0)
	if not texture then
		return nil
	end
	local i=0
	for i=1,16 do
		local name, rank, iconTexture, count, duration, timeLeft = UnitBuff(unit, i);
		if texture==iconTexture and (notimecheck or timeLeft~=nil) then
			return timeLeft or notimecheck
		end
		local name, rank, iconTexture, count, debuffType, duration, timeLeft = UnitDebuff(unit, i);
		if texture==iconTexture and (notimecheck or timeLeft~=nil) then
			return timeLeft or notimecheck
		end
	end
	return nil
end

ReplaceCmdList={};

--NOTE:/next function is not done!
NextMacroButton=CreateFrame("CheckButton","NextMacroButton",UIParent,"SecureActionButtonTemplate");
NextMacroButton:Hide();
NextMacroButton:SetAttribute("type","macro");
NextMacroButton:SetAttribute("macrotext","/next\n/next\n/next\n/next\n/next\n/next\n/next\n/next\n/nextbutton");

local _call_action=nil;

local macrobox=getglobal("MacroEditBox");

local scope;

local function CreateScope()
	local s={};
	s.skipline=0;
	return s;
end

--TODO: maybe we need fix this for the command /click buttonName .
function after_UseAction()
	scope=CreateScope();
end
after_UseAction()
hooksecurefunc("UseAction",after_UseAction)


function CalcExpressionFunction()
end
function CalcExpression(exp)
	RunScript("function CalcExpressionFunction() return "..exp.." end");
	return CalcExpressionFunction()
end

function CalcConditionFunction()
end
function CalcCondition(exp)
	if exp and strlen(exp)>0 then
		RunScript("function CalcConditionFunction() if "..exp.." then return true else return false end end");
		return CalcConditionFunction()
	end
end


function AM_HandleCondition(type,msg,target)
	if type=="" or not type then
		return CalcCondition(msg)
	end
	if type=="CAST" or type=="CASTABLE" then
		return IsSpellCastable(msg)
	end
	if type=="RANGE" then
		return AM_InRange(msg)
	end
	if type=="CD" then
		return AM_InCD(msg)
	end
	if type=="FB" or type=="ADDFB" or type=="FBX" or type=="ADDFBX" then
		if target then
			if not UnitExists(target) then
				return nil
			end
		else
			if UnitExists("target") and UnitIsFriend("target","player") then
				target="target"
			else
				target="player"
			end
		end
		if type=="FBX" or type=="ADDFBX" then
			if not UnitHasSpellEffect(target,msg,20) then
				return 1
			end
		else
			if not UnitHasSpellEffect(target,msg) then
				return 1
			end
		end
		return nil
	end
	if type=="TB" or type=="ADDTB" or type=="TBX" or type=="ADDTBX" then
		if not target then
			target="target"
		end
		if not UnitExists(target) then
			return nil
		end
		if type=="TBX" or type=="ADDTBX" then
			if not UnitHasSpellEffect(target,msg,20) then
				return 1
			end
		else
			if not UnitHasSpellEffect(target,msg) then
				return 1
			end
		end
		return nil
	end
	if type=="PB" or type=="ADDPB" then
		if not UnitHasSpellEffect("player",msg) then
			return 1
		end
		return nil
	end
	if type=="PBX" or type=="ADDPBX" then
		if not UnitHasSpellEffect("player",msg,20) then
			return 1
		end
		return nil
	end
	local numtype,num=strmatch(type,"([a-zA-Z])([0-9]+)")
	if numtype and num then
		if numtype=="R" then
			if UnitMana("player")>=tonumber(num) then
				return 1
			end
		end
		if numtype=="L" then
			if UnitHealth("player")*100/UnitHealthMax("player")<=tonumber(num) then
				return 1
			end
		end
		return nil
	end
	return 1; --unknown condition maybe parse error..
end
local function HandleConditions(msg,target,...)
	local i
	for i=1,select("#", ...) do
		if not AM_HandleCondition(select(i,...),msg,target) then
			return nil
		end
	end
	return true
end

local function HandleLineIf(result)
	local ns=CreateScope();
	ns.isif=true;
	ns.parent=scope;
	scope=ns;
	scope.result=result;
	return true;
end
local function HandleLineElseIf(result)
	if scope.isif then
		scope.result=result
	else
		__Print(" do not use /elseif without /if ");
	end
	return true;
end
function AM_HandleLine(command,msg)
	if command=="/SKIPNONE" then
		scope.skipline=0;
		return true;
	end
	if strmatch(command,"/IF([^%s]*)") then
		HandleLineIf(AM_HandleCondition(strmatch(command,"/IF([^%s]*)"),msg))
		return true;
	end
	if strmatch(command,"/ELSEIF([^%s]*)") then
		HandleLineElseIf(AM_HandleCondition(strmatch(command,"/ELSEIF([^%s]*)"),msg))
		return true;
	end
	if command=="/ELSE" then
		if scope.isif then
			if scope.result then
				scope.result=false
			else
				scope.result=true
			end
		else
			__Print(" do not use /else without /if ");
		end
		return true;
	end
	if command=="/END" then
		if scope.isif then
			scope=scope.parent;
		else
			__Print(" do not use /end without /if ");
		end

		return true;
	end


	local ns=scope;
	while ns and ns.isif do
		if not ns.result then
			--if the condition is not true , then skip the line.
			return true;
		end
		ns=ns.parent;
	end
	

	if scope.skipline>0 then
--__Print("skiping line.."..scope.skipline);
--		__Print("skipline.."..command..msg)
		scope.skipline=scope.skipline-1;
		return true;
	end

	if command=="/CAST" then
		local action, target = SecureCmdOptionParse(msg);
		if not action then
			return true
		end

		if not IsSpellCastable(action,target) then
			return true
		end
		
		if target then
			if not UnitExists(target) then
				return true
			end
		else
			--target="target"
		end

		local types = strmatch(msg, ":%d?([a-zA-Z][a-zA-Z0-9%+]+)");
		if types then
			if HandleConditions(action,target,strsplit("+",strupper(types))) then
				return false
			end
			return true
		end

		--unknown command , do not skip it.
		return false

	end


	return false;
end

local _ChatEdit_HandleChatType_=ChatEdit_HandleChatType;
function ChatEdit_HandleChatType(editBox, msg, command, send)

	if send and editBox:GetName()=="MacroEditBox" then
		if AM_HandleLine(command,msg) then
			ChatEdit_OnEscapePressed(editBox)
			return 1;
		end
	end

	return _ChatEdit_HandleChatType_(editBox, msg, command, send)
end

function SkipLine(line)
	scope.skipline=tonumber(line) or 0;
end

function SKIPLINEIF(msg)
	local count,exp = strmatch(msg, "^(%d+)%s+(.*)");
	if exp then
		if CalcCondition(exp) then
			SkipLine(count);
		end
	else
		__Print("usage: /skiplineif N Condition()");
	end
end
function SKIPIF(msg)
	if msg then
		if CalcCondition(msg) then
				SkipLine(1)
		end
	end
end
function DOIF(msg)
	if msg then
		if not CalcCondition(msg) then
			SkipLine(1)
		end
	end
end

SlashCmdList["SKIPLINEIF"]=SKIPLINEIF;
SLASH_SKIPLINEIF1="/SKIPLINEIF";
SlashCmdList["SKIPIF"]=SKIPIF;
SLASH_SKIPIF1="/SKIPIF";

SlashCmdList["DOIF"]=DOIF;
SLASH_DOIF1="/DOIF";







function IF_XUEXING()
	if not UnitAffectingCombat("player") then
		return false;
	end
	if not (UnitMana("player")<15) then
		return false;
	end
	if not (UnitExists("target") and UnitCanAttack("player","target")) then
		return false;
	end
	if not (UnitHealth("target")/UnitHealthMax("target")>0.2) then
		return false;
	end
	if IsSpellCastable("Ability_Racial_BloodRage") then
		return true
	end
end

--if target is casting or channaling spell.
function IF_CSPELL(spell)
	if (UnitChannelInfo("target") or UnitCastingInfo("target")) then
		if spell then
			return IsSpellCastable(spell)
		end
		return true
	end
end

function IF_CHAOFENG()
	if not UnitExists("target") then
		return false
	end
	if UnitIsPlayer("target") then
		return false
	end
	if UnitIsFriend("target","player") then
		return false
	end
	if not UnitIsFriend("targettarget","player") then
		return false
	end
	if UnitIsUnit("targettarget","player") then
		return false
	end
	return true;
end

function IF_WEISUO()
	if not UnitExists("target") then
		return false
	end
	if UnitIsPlayer("target") then
		return false
	end
	if UnitIsFriend("target","player") then
		return false
	end
	if UnitIsUnit("targettarget","player") then
		return true
	end
	return false
end

AM__GetSpellIndex=__GetSpellIndex;




function PrintBuffs()
	local i=0
	for i=1,16 do
		local name, rank, iconTexture, count, duration, timeLeft = UnitBuff("player", i);
		if name and iconTexture then
			__Print(name..":"..iconTexture)
		end
	end
end

function message(msg)
	__Print(msg)
end
function SetUIPanel()
end

__Print("AutoMacro Loaded.");