local _G = getfenv(0)
local strformat, strfind = string.format, string.find
local temp, temp2, temp3
local _,i


local x, y, uiscale, tipscale
function Icetip:SetDefaultAnchor(parent)
	self:SetOwner(parent, "ANCHOR_NONE")
	
	if IcetipDB.OrigPosX and IcetipDB.OrigPoxY then
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -IcetipDB.OrigPosX-13,IcetipDB.OrigPosY)
	else
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y);
	end
	
	
	if IcetipDB.Anchor then
		if parent == UIParent then
			if IcetipDB.Anchor == 0 or IcetipDB.Anchor == 3 then
				Icetip.AnchorType = 1
			elseif IcetipDB.Anchor == 2 or IcetipDB.Anchor == 5 then
				Icetip.AnchorType = 2
			end
			if UnitExists("mouseover") then
				if IcetipDB.Anchor == 1 or IcetipDB.Anchor == 4 then
					Icetip.AnchorType = nil
					uiscale = UIParent:GetScale()
					tipscale = GameTooltip:GetScale()
					x = IcetipDB.OffsetX/ tipscale / uiscale
					y = IcetipDB.OffsetX/ tipscale / uiscale
					self:ClearAllPoints()
					self:SetPoint("TOP", UIParent, "TOP", x, -y)
				else
				end
			else
				self:SetOwner(parent, "ANCHOR_CURSOR")
			end
		else
			if IcetipDB.Anchor > 2  or parent.unit then
				self:SetOwner(parent, "ANCHOR_CURSOR")
			else
			end
		end
	else
	
	end
end