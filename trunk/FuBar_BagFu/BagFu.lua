BagFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0")
local BagFu = BagFu

BagFu.hasIcon = true
BagFu.cannotDetachTooltip = true
BagFu.defaultPosition = "RIGHT"

local L = AceLibrary("AceLocale-2.2"):new("FuBar_BagFu")
local _G = _G

local Tablet = AceLibrary("Tablet-2.0")
local Crayon = AceLibrary("Crayon-2.0")

local options = {
	type = "group",
	pass = true,
	get = function(key)
		return BagFu.db.profile[key]
	end,
	set = function(key, val)
		BagFu.db.profile[key] = val
		BagFu:Update()
	end,
	args = {
		includeAmmo = {
			type = "toggle",
			name = L["Ammo/Soul Bags"],
			desc = L["Include ammo/soul bags"],
		},
		includeProfession = {
			type = "toggle",
			name = L["Profession Bags"],
			desc = L["Include profession bags"],
		},
		showDepletion = {
			type = "toggle",
			name = L["Bag Depletion"],
			desc = L["Show depletion of bags"],
		},
		showTotal = {
			type = "toggle",
			name = L["Bag Total"],
			desc = L["Show total amount of space in bags"],
		},
		openBagsAtBank = {
			type = "toggle",
			name = L["Open Bags at Bank"],
			desc = L["Open all of your bags when you're at the bank"],
			set = function(v)
				BagFu.db.profile.openBagsAtBank = v
				if v then
					BagFu:RegisterEvent("BANKFRAME_OPENED", function() OpenAllBags(true) end)
				else
					BagFu:UnregisterEvent("BANKFRAME_OPENED")
				end
			end,
			get = function() return BagFu.db.profile.openBagsAtBank end,
		},
		openBagsAtVendor = {
			type = "toggle",
			name = L["Open Bags at Vendor"],
			desc = L["Open all of your bags when you're at a vendor"],
			set = function(v)
				BagFu.db.profile.openBagsAtVendor = v
				if v then
					BagFu:RegisterEvent("MERCHANT_SHOW", function() OpenAllBags(true) end)
					BagFu:RegisterEvent("MERCHANT_CLOSED", function() CloseAllBags() end)
				else
					BagFu:UnregisterEvent("MERCHANT_SHOW")
					BagFu:UnregisterEvent("MERCHANT_CLOSED")
				end
			end,
			get = function() return BagFu.db.profile.openBagsAtVendor end,
		},
	}
}

function BagFu:OnInitialize()
	self:RegisterDB("BagFuDB")
	self:RegisterDefaults('profile', {
		showDepletion = false,
		includeProfession = true,
		includeAmmo = false,
		showTotal = true,
		openBagsAtBank = false,
		openBagsAtVendor = false,
	})
	self.OnMenuRequest = options
end

function BagFu:OnEnable()
	self:RegisterBucketEvent("BAG_UPDATE", 5, "Update")
	if self.db.profile.openBagsAtBank then
		self:RegisterEvent("BANKFRAME_OPENED", function() OpenAllBags(true) end)
	end
	if self.db.profile.openBagsAtVendor then
		self:RegisterEvent("MERCHANT_SHOW", function() OpenAllBags(true) end)
		self:RegisterEvent("MERCHANT_CLOSED", function() CloseAllBags() end)
	end
end

function BagFu:OnTextUpdate()
	local totalSlots = 0
	local takenSlots = 0
	for i = 0, 4 do
		local usable = true
		if i >= 1 then
			local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
			if link ~= nil then
				local subtype = select(7, GetItemInfo(link))
				if not self.db.profile.includeAmmo and (subtype == L["Soul Bag"] or subtype == L["Ammo Pouch"] or subtype == L["Quiver"]) then
					usable = false
				elseif not self.db.profile.includeProfession and (subtype == L["Enchanting Bag"] or subtype == L["Herb Bag"] or subtype == L["Engineering Bag"] or subtype == L["Mining Bag"] or subtype == L["Gem Bag"]) then
					usable = false
				end
			end
		end
		if usable then
			local size = GetContainerNumSlots(i)
			if size ~= nil and size > 0 then
				totalSlots = totalSlots + size
				takenSlots = takenSlots + (size - GetContainerNumFreeSlots(i))
			end
		end
	end
	
	local color = Crayon:GetThresholdHexColor((totalSlots - takenSlots) / totalSlots)
	
	if self.db.profile.showDepletion then
		takenSlots = totalSlots - takenSlots
	end
	
	if self.db.profile.showTotal then
		self:SetText(string.format("|cff%s%d/%d|r", color, takenSlots, totalSlots))
	else
		self:SetText(string.format("|cff%s%d|r", color, takenSlots))
	end
end

function BagFu:OnTooltipUpdate()
	Tablet:SetHint(L["Click to open your bags"])
end

function BagFu:OnClick()
	if not ContainerFrame1:IsShown() then
		for i = 1, 4 do
			if _G["ContainerFrame" .. (i + 1)]:IsShown() then
				_G["ContainerFrame" .. (i + 1)]:Hide()
			end
		end
		ToggleBackpack()
		if ContainerFrame1:IsShown() then
			for i = 1, 4 do
				local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
				if link ~= nil then
					local subtype = select(7, GetItemInfo(link))
					local usable = true
					if not self.db.profile.includeAmmo and (subtype == L["Soul Bag"] or subtype == L["Ammo Pouch"] or subtype == L["Quiver"]) then
						usable = false
					elseif not self.db.profile.includeProfession and (subtype == L["Enchanting Bag"] or subtype == L["Herb Bag"] or subtype == L["Engineering Bag"] or subtype == L["Mining Bag"] or subtype == L["Gem Bag"]) then
						usable = false
					end
					if usable then
						ToggleBag(i)
					end
				end
			end
		end
	else
		for i = 0, 4 do
			if _G["ContainerFrame" .. (i + 1)]:IsShown() then
				_G["ContainerFrame" .. (i + 1)]:Hide()
			end
		end
	end
end
