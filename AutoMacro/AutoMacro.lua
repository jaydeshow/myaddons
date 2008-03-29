local function __Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg,192,0,192,0)
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
		local match=strfind(fullname,spell);
		if not match then
			local texture=GetSpellTexture(i,BOOKTYPE_SPELL)
			match=strfind(texture,spell);
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

function IsSpellCastable(spell)

	local index,count=__GetSpellIndex(spell)
	if index then
		if IsUsableSpell(index,BOOKTYPE_SPELL) and IsSpellInRange(index,BOOKTYPE_SPELL)~=0 then
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

function UnitHasSpellEffect(unit,spell)
	if not UnitExists(unit) then
		return nil
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
		if texture==iconTexture and timeLeft~=nil then
			return timeLeft
		end
		local name, rank, iconTexture, count, debuffType, duration, timeLeft = UnitDebuff(unit, i);
		if texture==iconTexture and timeLeft~=nil then
			return timeLeft
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


local function HandleCondition(type,msg)
	if type=="" or not type then
		return CalcCondition(msg)
	end
	if type=="CAST" or type=="CASTABLE" then
		return IsSpellCastable(msg)
	end
	if type=="TB" then
		if not UnitExists("target") then
			return nil
		end
		if not UnitHasSpellEffect("target",msg) then
			return 1
		end
		return nil
	end
	if type=="PB" then
		if not UnitHasSpellEffect("player",msg) then
			return 1
		end
		return nil
	end
	return 1; --unknown condition maybe parse error..
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
		if not scope.result then
			scope.result=result
		end
	else
		__Print(" do not use /elseif without /if ");
	end
	return true;
end
local function HandleLine(command,msg)
	if command=="/SKIPNONE" then
		scope.skipline=0;
		return true;
	end
	if strmatch(command,"/IF([^%s]*)") then
		HandleLineIf(HandleCondition(strmatch(command,"/IF([^%s]*)"),msg))
		return true;
	end
	if strmatch(command,"/ELSEIF([^%s]*)") then
		HandleLineElseIf(HandleCondition(strmatch(command,"/ELSEIF([^%s]*)"),msg))
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
		scope.skipline=scope.skipline-1;
		return true;
	end

	if command=="/CAST" then
		local action, target = SecureCmdOptionParse(msg);
		if not action then
			return true
		end

		if not IsSpellCastable(action) then
			return true
		end

		local condition,type,spell = strmatch(msg, "^%[([a-z]+):%d+([a-z]+)%]%s+(.*)");
		if spell then
			if not type then
				return false
			end
			if HandleCondition(strupper(type),spell) then
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
	if _ChatEdit_HandleChatType_(editBox, msg, command, send) then
		return true;
	end
	if not send then
		return false
	end
	if editBox:GetName()~="MacroEditBox" then
		return false;
	end
	if HandleLine(command,msg) then
		ChatEdit_OnEscapePressed(editBox)
		return true;
	end

	--__Print("continue "..editBox:GetText());

	return false;
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

SlashCmdList["SKIPLINEIF"]=SKIPLINEIF;
SLASH_SKIPLINEIF1="/SKIPLINEIF";
SlashCmdList["SKIPIF"]=SKIPIF;
SLASH_SKIPIF1="/SKIPIF";





local nextaction=nil;

function Next(line,callback,...)
	local item={};
	action.line=line;
	action.func=callback;
	local i;
	local n=select("#",...);
	for i=1,n do
		action["arg"..i]=select(i,...);
	end
	if nextaction==nil then
		nextaction=action;
	else
		nextaction.next=action;
	end
end

local function ActionBegin(msg)
	nextaction=nil;
	if msg~="" then
		local func=getglobal(msg);
		if func then
			func();
		end
	end
end
local function ActionNext(msg)
	if not nextaction then
		return nil;
	end
	_call_action=nextaction;
	nextaction=nextaction.next;
	return _call_action.line;
end
local function ActionNextButton(msg)
	if not nextaction then
		return nil;
	end
	return "/click NextMacroButton";
end




local function macrobox_Translate_Text(text)

	local cmd = strmatch(text, "^(/[^%s]+)");
	if not cmd then
		return nil
	end

	local msg = "";
	if ( cmd ~= text ) then
		msg = strsub(text, strlen(cmd) + 2);
	end

	cmd = strupper(cmd);

	local scriptcmd=strmatch(cmd,"^(/[^%s]+)!SCRIPT$");
	if scriptcmd then
		cmd=scriptcmd;
		if msg~="" then
			msg=CalcExpression(msg)
		end
	end


	if cmd=="/BEGIN" then
		return ActionBegin(msg) or "";
	elseif cmd=="/NEXT" then
		return ActionNext(msg) or "";
	elseif cmd=="/NEXTBUTTON" then
		return ActionNextButton(msg) or "";
	end

	if cmd=="/CASTABLE" then
		local spell=FindCastableSpell(strsplit(",",msg))
		if spell then
			return "/cast "..spell;
		else
			return "";
		end
	end
	if cmd=="/TODOCOMMAND" then
			
	end

	local func=ReplaceCmdList[strsub(cmd,2)];
	if func then
		return func(msg);
	end


	if scriptcmd then
		if msg=="" then
			return scriptcmd;
		end
		return scriptcmd.." "..msg;
	end
end

local function pre_MacroLine(box,text)

	_call_action=nil;

	if strfind(text,"/")~=1 then return end;
	if box._setting_text_ then return end;
	local newtext=macrobox_Translate_Text(text)
	if newtext then
__Print("override .. "..newtext);
--TODO:very important here, how to set the text with secure?
		box._setting_text_=true;
		box:SetMultiLine(true)
		box:SetText(newtext.."\n\n\n");
		box:SetMultiLine(false)
		box._setting_text_=false;
	end
end
local function post_MacroLine(editBox, send)
	if editBox:GetName()~="MacroEditBox" then
		return;
	end
	local action=_call_action;
	_call_action=nil;
	if action and action.func then
		action.func(action.arg1,action.arg2,action.arg3,action.arg4,action.arg5,action.arg6,action.arg7,action.arg8,action.arg9,action.arg10,action.arg11,action.arg12);
	end
end

--hooksecurefunc(macrobox,"SetText",pre_MacroLine);
--hooksecurefunc("ChatEdit_ParseText",post_MacroLine);



--a good reason for use XueXing..
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




function AM_InRange(spell)
	local index,count=__GetSpellIndex(spell)
	if index then
		if IsSpellInRange(index,BOOKTYPE_SPELL)~=0 then
			return true
		end
	end
end
AM__GetSpellIndex=__GetSpellIndex;