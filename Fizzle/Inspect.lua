﻿local mod = Fizzle:NewModule("Inspect", "AceHook-3.0", "AceEvent-3.0")
local _G = _G
local ipairs, smatch, tonumber = ipairs, string.match, tonumber
local slots = {
	"Head",
	"Shoulder",
	"Chest",
	"Waist",
	"Legs",
	"Feet",
	"Wrist",
	"Hands",
	"MainHand",
	"SecondaryHand",
	"Ranged",
	"Ammo",
	"Neck",
	"Back",
	"Finger0",
	"Finger1",
	"Trinket0",
	"Trinket1",
	"Relic",
	"Tabard",
}
local booted = false
-- Make some blizz functions more local
local UnitIsPlayer = UnitIsPlayer
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetInventoryItemLink = GetInventoryItemLink
local L = LibStub("AceLocale-3.0"):GetLocale("Fizzle")
mod.modName = L["Inspect"]

function mod:OnInitialize()
	self.db = Fizzle.db:RegisterNamespace("Inspect")
end

function mod:OnEnable()
	if IsAddOnLoaded("Blizzard_InspectUI") then
		self:SecureHook("InspectFrame_OnShow")
		self:SecureHook("InspectFrame_OnHide")
		self:InspectFrame_OnShow()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end

function mod:OnDisable()
	-- Hide all borders if we get disabled.
	for _, item in ipairs(slots) do
		local border = _G[item .."FizzspectB"]
		if border then
			border:Hide()
		end
	end
end

function mod:CreateBorders()
	for _, item in ipairs(slots) do
		-- Create borders
		Fizzle:CreateBorder("Inspect", item, "Fizzspect", false)
	end
	booted = true
end

local function GetItemID(link)
	return tonumber(smatch(link, "item:(%d+)") or smatch(link, "%d+"))
end

function mod:UpdateBorders()
	if not InspectFrame:IsVisible() then return end
	if not UnitIsPlayer("target") then return end
	if not self:IsHooked("InspectFrame_UnitChanged") then
		self:SecureHook("InspectFrame_UnitChanged", "UpdateBorders")
	end
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "UpdateBorders")
	for _, item in ipairs(slots) do
		local id
		if _G["Character".. item .."Slot"] then
			id = _G["Character".. item .."Slot"]:GetID()
		end
		if id then
			local link = GetInventoryItemLink("target", id)
			local border = _G[item .."FizzspectB"]
			if link then
				local itemID = GetItemID(link)
				local quality = select(3, GetItemInfo(itemID))
				
				if quality then
					local r, g, b = GetItemQualityColor(quality)
					border:SetVertexColor(r, g, b)
					border:Show()
				else
					border:Hide()
				end
			else
				if border then
					border:Hide()
				end
			end
		end
	end
end

function mod:ADDON_LOADED()
	-- If the Blizzard InspectUI is loading, fire up the addon!
	if arg1 == "Blizzard_InspectUI" then
		self:SecureHook("InspectFrame_OnShow")
		self:SecureHook("InspectFrame_OnHide")
		self:UnregisterEvent("ADDON_LOADED")
		self:InspectFrame_OnShow()
	end
end

function mod:InspectFrame_OnShow()
	-- Create the borders if we're just loading.
	if not booted then
		self:CreateBorders()
	end
	
	-- Update the borders
	self:UpdateBorders()
end

function mod:InspectFrame_OnHide()
	self:Unhook("InspectFrame_UnitChanged")
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end
