--------------------------
-- TRACKER DATA 2.2.20b --
--------------------------------------------------------------------
-- BE CAREFULL, DONT CHANGE ANYTHING IF YOU DONT KNOW WHAT YOU DO --
--------------------------------------------------------------------
--
--      example with the Mangle (Cat) spell
--
--	abiId = 33983, 							-- abiId: SpellID - Look at Wow Wiki to find ID
--	abiTimer = 12,							-- abiTimer: Spell period (in second)
									-- -1 -> Aura debuff like faeryfire or demoralize roar (ie no timer / no damage for tracker)
--	abiPersonnal = false, 						-- False: the spell can comes from any druids - true: accept spells comes from player only
--	abiDot= false,							-- true for periodic spell (like rake or rip dot)
--	abiStack= 1,							-- for spell like lacerate
--	abiCombo= false,						-- 1 stack = 1 combo point (like lacerate)
--	abiEvent = "SPELL_DAMAGE",					-- Events require to trigger this spell
									-- Can be "SPELL_DAMAGE" - for spell like mangle
									--     or "SPELL_PERIODIC_DAMAGE" - for spell like rake & rip (dot)
									--     or "SPELL_AURA_APPLIED"	- for spell like fearyfire, demoralize roar and rake & rip (aura)
--	abiUseobj = -1, 						-- -1: Use is own obj, or the number of icon to use (example with mangle bear that use this icon)
									-- if another icon is use for this obj, the datas below are not use
--	abiX = -3 * 22,							-- the position (relative to the center of main frame)
--	abiY = -10,
--	abiW = 20,							-- Width and height of the icon
--	abiH = 20,
--	abiObj = "DruidFocusMangle", 					-- Name for the frame (anything you want, not use at the moment)
--	abiImg = "Interface\\AddOns\\DroodFocus\\arts\\img_mangle",	-- The image for the background
--	abiMode = "BLEND",						-- Fusion mode
--	abiScale = 0.10,						-- DONT TOUCH !
--	abiScaleAdd = 0,						-- DONT TOUCH !
--	abiState = 0,							-- DONT TOUCH !
--	abiAmount = 0,							-- DONT TOUCH !
--	abiName = "",							-- DONT TOUCH !
--	abiGerer = false						-- DONT TOUCH !
--

abilities = {};

abilities[1] = {
	abiId = 33983, -- id mangle cat
	abiTimer = 12,
	abiPersonnal = false, 
	abiDot= false,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_DAMAGE",
	abiUseobj = -1, 
	abiX = 0 * 22,
	abiY = -10,
	abiW = 20,
	abiH = 20,
	abiObj = "DruidFocusMangleCat", 
	abiImg = "Interface\\AddOns\\DroodFocus\\arts\\img_mangle",
	abiMode = "BLEND",
	abiScale = 0.10,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};

abilities[2] = {
	abiId = 33987, -- id mangle bear
	abiTimer = 12,
	abiPersonnal = false, 
	abiDot= false,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_DAMAGE",
	abiUseobj = 1, 
	abiX = 0,
	abiY = 0,
	abiW = 0,
	abiH = 0,
	abiObj = "", 
	abiImg = "",
	abiMode = "",
	abiScale = 0,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};

abilities[3] = {
	abiId = 16857, -- fearyfire féral
	abiTimer = -1,
	abiPersonnal = false, 
	abiDot= false,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_AURA_APPLIED",
	abiUseobj = -1, 
	abiX = -3*22,
	abiY = -10,
	abiW = 20,
	abiH = 20,
	abiObj = "DruidFocusFeary", 
	abiImg = "Interface\\AddOns\\DroodFocus\\arts\\img_fearie",
	abiMode = "BLEND",
	abiScale = 0.10,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};
--[[
abilities[4] = {
	abiId = 1822, -- rake
	abiTimer = 9, 
	abiPersonnal = true, 
	abiDot= true,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_AURA_APPLIED",
	abiUseobj = -1, 
	abiX = 2*22,
	abiY = -10,
	abiW = 20,
	abiH = 20,
	abiObj = "DruidFocusRake", 
	abiImg = "Interface\\AddOns\\DroodFocus\\arts\\img_rake",
	abiMode = "BLEND",
	abiScale = 0.10,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};

abilities[5] = {
	abiId = 1822, -- rake
	abiTimer = 4, -- real time is 3 (for 1 tick) - 1 second more to handle lag
	abiPersonnal = true, 
	abiDot= false,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_PERIODIC_DAMAGE",
	abiUseobj = 4, 
	abiX = 0,
	abiY = -10,
	abiW = 0,
	abiH = 0,
	abiObj = "", 
	abiImg = "",
	abiMode = "",
	abiScale = 0,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};
]]
--abilities[6] = {
abilities[4] = {
	abiId = 1079, -- rip
	abiTimer = 12,
	abiPersonnal = true,
	abiDot= true,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_AURA_APPLIED",
	abiUseobj = -1, 
	abiX = 1*22,
	abiY = -10,
	abiW = 20,
	abiH = 20,
	abiObj = "DruidFocusRip", 
	abiImg = "Interface\\AddOns\\DroodFocus\\arts\\img_rip",
	abiMode = "BLEND",
	abiScale = 0.10,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};

abilities[5] = {
--abilities[7] = {
	abiId = 1079, -- rip
	abiTimer = 3, -- real time is 2 (for 1 tick) - 1 second more to handle lag
	abiPersonnal = true,
	abiDot= false,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_PERIODIC_DAMAGE",
	abiUseobj = 6, 
	abiX = 0,
	abiY = -10,
	abiW = 0,
	abiH = 0,
	abiObj = "", 
	abiImg = "",
	abiMode = "",
	abiScale = 0,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};

--abilities[8] = {
abilities[6] = {
	abiId = 99, -- Demoralizing Roar
	abiTimer = -1,
	abiPersonnal = false, 
	abiDot= false,
	abiStack= 1,
	abiCombo= false,
	abiEvent = "SPELL_AURA_APPLIED",
	abiUseobj = -1, 
	abiX = -2*22,
	abiY = -10,
	abiW = 20,
	abiH = 20,
	abiObj = "DruidFocusRoar", 
	abiImg = "Interface\\AddOns\\DroodFocus\\arts\\img_roar",
	abiMode = "BLEND",
	abiScale = 0.10,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};

--abilities[9] = {
abilities[7] = {
	abiId = 33745, -- Lacerate
	abiTimer = 15,
	abiPersonnal = true, 
	abiDot= false,
	abiStack= 5,
	abiCombo= true,
	abiEvent = "SPELL_DAMAGE",
	abiUseobj = -1, 
	abiX = -1*22,
	abiY = -10,
	abiW = 20,
	abiH = 20,
	abiObj = "DruidFocusLacerate", 
	abiImg = "Interface\\AddOns\\DroodFocus\\arts\\img_lacerate",
	abiMode = "BLEND",
	abiScale = 0.10,
	abiScaleAdd = 0,
	abiState = 0,
	abiAmount = 0,
	abiName = "",
	abiGerer = false
};

nbAbilities = getn(abilities);

