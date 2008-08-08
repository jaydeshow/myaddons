--[[

$Revision: 70437 $

(C) Copyright 2007 Bethink (bethink at naef dot com)

This file is part of Analyst.

Analyst is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Analyst is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Leser General Public License
along with Analyst. If not, see <http://www.gnu.org/licenses/>.

Compliance

- GetSellValue API [http://www.wowwiki.com/GetSellValue]

]]


----------------------------------------------------------------------
-- Subsystem

-- One-time initialization
function Analyst:InitializeVendorValue ()
	-- Initialize table as needed
	if not self.db.account.vendorValues then
		self.db.account.vendorValues = { }
	end
end

-- Handles (re-)enabling of the capture subsystem
function Analyst:EnableVendorValue ()
	-- Hook or set the API
	if getglobal("GetSellValue") then
		self:Hook("GetSellValue", "GetVendorValue")
	else
		setglobal("GetSellValue", function (item) return Analyst:GetVendorValue(item) end)
	end
end

-- Handles disabling of the vendor value subsystem
function Analyst:DisableVendorValue ()
end


----------------------------------------------------------------------
-- Vendor value

-- Returns the vendor value of item.
function Analyst:GetVendorValue (item)
	-- Get the item ID
	local itemId
	if type(item) == "number" then
		itemId = item
	else
		local _, itemLink = GetItemInfo(item)
		if not itemLink then
			return nil
		end
		itemId = self:GetItemId(self:GetItemString(itemLink))
	end
	
	-- Query own database
	if self.db.account.vendorValues[itemId] then
		return self.db.account.vendorValues[itemId]
	end
	
	-- Query hook chain
	if self.hooks["GetSellValue"] then
		return self.hooks["GetSellValue"](itemId)
	end
	
	-- Not found
	return nil
end

-- Registers a vendor value
function Analyst:RegisterVendorValue (itemId, value)
	self.db.account.vendorValues[itemId] = value;
end




