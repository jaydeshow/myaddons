--[[ CmdHelp -- Generic command help system.
    Written by Vincent of Blackhand, (copyright (c) 2006 by D.A.Down)
    Version history:
    0.9.1 - Updated 'for' loops for Lua 5.1
    0.9 - WoW 1.12 update.
    0.8.2 - Added help argument list to most displays.
    0.8.1 - Added 'help' to every argument list.
    0.8 - Initial release.

Usage: CmdHelp(<help table>,<command string>,<argument string> [,<print function>])
	If no print function if given the internal default will be used.
Arguments:
	'help' - lists the commands defined in the <help table>.
	'help?' - describes the commands defined in the <help table>.
	'?' - lists the arguments defined for the command <command string>.
	'<arg>?' - describes the argument <arg> for the command <command string>.
	'??' - describes all arguments for the command <command string>.
Returns: <nil> the the argument isn't a recognized help request, else 1.

]]
local Print
-- Default print function
local function PRINT(msg) SELECTED_CHAT_FRAME:AddMessage(msg) end

-- Iterative function for a sorted table
local function sorted(tb,comp)
	local ix = {}
	for key in pairs(tb) do
	  tinsert(ix,key)
	end
	sort(ix,comp)
	local iter = function (state,key)
	  state.ky,key = next(state.ix,state.ky)
	  return key,state.tb[key]
	end
	return iter,{ix=ix,tb=tb}
end

local function Help(tbl,cmd,full)
	local pre,list,desc = cmd=='/' and "'/" or "'"
	for name,data in sorted(tbl) do
	  if name=='?' then
	  elseif full=='?' then
	    desc = type(data)=='string' and data or data['?'] or data[''] or '??'
	    Print(format("%s%s - %s.",cmd,name,desc))
	  else list = (list and list..', ' or '')..pre..name.."'"
	  end
	end
	if list then
	  Print((cmd=='/' and 'Commands' or cmd)..': '..list)
	end
end

function CmdHelp(tbl,cmd,arg,print)
	Print = print or PRINT
	if not tbl then
	  Print("错误: 从 CmdHelp() 未找到帮助表.")
	  return 1
	end
	if not cmd then
	  Print("错误: 从 CmdHelp() 未找到此标签.")
	  return 1
	end
	local name = tbl['?'] or "'/"..cmd.."'"
	if not arg then 
	Print(name.." 此命令, 输入 '/"..cmd.." 获取帮助'.") return end
	if arg~='' and arg~='help' and strsub(arg,-1,-1)~='?' then return end
	Print(name.." 从 CmdHelp 获取帮助 '"..arg.."':")
	local _,_,arg,full = strfind(arg,"^(..-)(%??)$")
	if not tbl[cmd] then
	  Print("错误: 命令 '"..cmd.."' 不存在于帮助表中.")
	elseif not arg then
	  Print("'/"..cmd.." help' 可打开定义帮助表.")
	  Print("'/<cmd> ?' 列出命令说明 <cmd>.")
	  Print("'/<cmd> <arg>?' <cmd>的描述是<arg> .")
	  return 1
	elseif arg=='help' then Help(tbl,'/',full)
	elseif arg=='?' then
	  tbl[cmd].help = "列出定义的命令行"
	  Help(tbl[cmd],'/'..cmd..' ',full)
	elseif tbl[cmd][arg] then
	  Print(format("/%s %s - %s.",cmd,arg,tbl[cmd][arg]))
	else Print("未定义: '/"..cmd..' '..arg.."'.") end
	Print("描述帮助: '?', '??'. 'help' or 'help?'.")
	return 1
end
