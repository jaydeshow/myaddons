--[[

ARL-FirstAId.lua

First Aid data for all of AckisRecipeList

$Date: 2008-06-03 13:54:39 -0400 (Tue, 03 Jun 2008) $
$Rev: 75918 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("AckisRecipeList")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()

local addon = AckisRecipeList

function addon:InitFirstAid()
 
	-- Trainer Recipes
	self:addTradeSkillSpell(3275, 1, L["Trainer"])
	self:addTradeSkillSpell(3276, 40, L["Trainer"])
	self:addTradeSkillSpell(3277, 80, L["Trainer"])
	self:addTradeSkillSpell(7934, 80, L["Trainer"])
	self:addTradeSkillSpell(3278, 115, L["Trainer"])
	self:addTradeSkillSpell(7928, 150, L["Trainer"])
	self:addTradeSkillSpell(10841, 240, L["Trainer"])
	self:addTradeSkillSpell(18629, 260, L["Trainer"])
	self:addTradeSkillSpell(18630, 290, L["Trainer"])

	-- Vendor Recipes
	self:addTradeSkillSpell(7929, 180, self:CombineVendors(165, 166, false))
	self:addTradeSkillSpell(10840, 210, self:CombineVendors(165, 166, false))
	self:addTradeSkillSpell(27032, 330, self:CombineVendors(167, 168, false))
	self:addTradeSkillSpell(27033, 360, self:CombineVendors(167, 168, false))

	-- World Drops
	self:addTradeSkillSpell(7935, 130, L["UWD"])

	-- Reputations
	self:addTradeSkillSpell(23787, 300, self:AddSingleReputation(2, BFAC["Argent Dawn"]), BFAC["Argent Dawn"])

end
