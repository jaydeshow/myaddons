--此功能用来输出buff/debuff

local _G = getfenv(0)
local strformat, strfind = string.format, string.find
local temp, temp2, temp3
local _,i

function Icetip:getBuffIcon(unit)
	for i= 1, 40, 1 do
		Icebuff,_,icebufficon = UnitBuff(unit, i)
		if Icebuff == nil then
			break
		else
			--Iceprint(icebufficon)
			icebufficon = gsub(icebufficon, "\\", "\\\\")
			Iceprint(icebufficon)
			GameTooltip:AddLine("\""..icebufficon.."\"")
		end
	end
	
end