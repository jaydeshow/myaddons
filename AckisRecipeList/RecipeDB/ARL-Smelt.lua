--[[

ARL-Smelt.lua

Smelting data for all of AckisRecipeList

$Date: 2008-05-18 15:56:45 -0400 (Sun, 18 May 2008) $
$Rev: 74325 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("AckisRecipeList")

local addon = AckisRecipeList

function addon:InitSmelting()

	self:addTradeSkillSpell(2657, 1, L["Trainer"])
	self:addTradeSkillSpell(3304, 65, L["Trainer"])
	self:addTradeSkillSpell(2659, 65, L["Trainer"])
	self:addTradeSkillSpell(2658, 75, L["Trainer"])
	self:addTradeSkillSpell(3307, 125, L["Trainer"])
	self:addTradeSkillSpell(3308, 155, L["Trainer"])
	self:addTradeSkillSpell(3569, 165, L["Trainer"])
	self:addTradeSkillSpell(10097, 175, L["Trainer"])
	self:addTradeSkillSpell(14891, 230, L["Dark Iron Obt"])
	self:addTradeSkillSpell(10098, 230, L["Trainer"])
	self:addTradeSkillSpell(16153, 250, L["Trainer"])
	self:addTradeSkillSpell(22967, 270, L["Elementium Obt"], {L["Raid"]})
	self:addTradeSkillSpell(35750, 300, L["Trainer"])
	self:addTradeSkillSpell(35751, 300, L["Trainer"])
	self:addTradeSkillSpell(29356, 300, L["Trainer"])
	self:addTradeSkillSpell(29358, 325, L["Trainer"])
	self:addTradeSkillSpell(29359, 350, L["Trainer"])
	self:addTradeSkillSpell(29360, 350, L["Trainer"])
	self:addTradeSkillSpell(29361, 375, L["Trainer"])
	self:addTradeSkillSpell(29686, 375, L["Trainer"])
	self:addTradeSkillSpell(46353, 375, L["SunwellBoP"])

end
