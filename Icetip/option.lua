local _G = getfenv(0)
local strformat, strfind = string.format, string.find
local temp, temp2, temp3
local _,i

function Icetip:SlashCmd(ICEcmd)
	if (ICEcmd == "") then
		Iceprint("欢迎使用小巧玲珑的IceTip.");
		Iceprint("|cFF34A2F7-version|r  获取当前版本号");
		Iceprint("|cFF34A2F7-reset|r    重置配置")
		Iceprint("|cFF34A2F7-gui|r  打开设置界面")
	end

	if (ICEcmd == "version") then
		Iceprint("<Icetip>当前版本为: "..addonRev.."."..svnrev.."欢迎访问http://cwowaddon.com获取更多插件信息");
	end
	

	if (ICEcmd == "reset") then
		IcetipDB = Icetip:GetDefault()
		Iceprint("<Icetip> 配置重置成功!")
	end

	if (ICEcmd == "gui") then
		self:ShowGUI();
	end	
end