local _G = getfenv(0)
local strformat, strfind = string.format, string.find
local temp, temp2, temp3
local _,i


--**设置tootip背景颜色
function Icetip:setBackdropColor(unit)
	if (GetGuildInfo(unit) and GetGuildInfo(unit) == GetGuildInfo("player")) then
		GameTooltip:SetBackdropColor(0.0,0.3,0.0);
	else
		if (UnitFactionGroup(unit) and UnitFactionGroup(unit) == UnitFactionGroup("player")) then
			GameTooltip:SetBackdropColor(0.0,0.0,0.5);
		elseif (UnitFactionGroup(unit) and UnitFactionGroup(unit) ~= UnitFactionGroup("player")) then
			GameTooltip:SetBackdropColor(0.5,0.0,0.0);
		else
			GameTooltip:SetBackdropColor(0.09, 0.09,0.18);
		end
	end	
end