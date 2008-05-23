local StatLogic = AceLibrary("StatLogic-1.0");

ExScanner = {
	Tip = CreateFrame("GameTooltip","ExScannerTip",nil,"GameTooltipTemplate"),

	ItemLinkPattern = "^.+|H(item:[^|]+)|h%[.+$",

	Slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot",
		"RangedSlot",
		--"AmmoSlot", -- Only available for 'player'
	},

	StatRatingBaseTable = {
		["EXPERTISE_RATING"] = 2.5,
		["MELEE_HASTE_RATING"] = 10,
		["SPELL_HASTE_RATING"] = 10,
		["MELEE_HIT_RATING"] = 10,
		["MELEE_CRIT_RATING"] = 14,
		["SPELL_HIT_RATING"] = 8,
		["SPELL_CRIT_RATING"] = 14,
		["DEFENSE_RATING"] = 1.5,
		["DODGE_RATING"] = 12,
		["PARRY_RATING"] = 15,
		["BLOCK_RATING"] = 5,
		["RESILIENCE_RATING"] = 25,
	},
};

ExScanner.Tip:SetOwner(UIParent,"ANCHOR_NONE");

--------------------------------------------------------------------------------------------------------
--          Scan all items and set bonuses on given 'unit' (Make sure the tables are reset)           --
--------------------------------------------------------------------------------------------------------
function ExScanner:ScanUnitItems(unit, statTable, setTable)
	if not unit or not UnitExists(unit) then return end

	for _, slotName in ipairs(self.Slots) do
		local itemLink = GetInventoryItemLink(unit, GetInventorySlotInfo(slotName));
		self:ScanItemLink(itemLink, statTable, setTable);
	end
end

--------------------------------------------------------------------------------------------------------
--        Scans a single item given by 'itemLink', stats are added to the 'statTable' variable        --
--------------------------------------------------------------------------------------------------------
function ExScanner:ScanItemLink(itemLink, statTable, scannedSets)
	if itemLink then
		local itemSum = {}
		StatLogic:GetSum(itemLink, itemSum, scannedSets);
		for k, v in pairs(itemSum) do
			if type(v) == "number" then
				statTable[k] = v + (statTable[k] or 0);
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                      Convert Rating to Percent                                     --
--------------------------------------------------------------------------------------------------------
function ExScanner:GetRatingInPercent(stat,rating,level)
	-- Check Base Rating
	if (not self.StatRatingBaseTable[stat] or not rating or not level) then
		return;
	end
	-- Calc Depending on Level
	if (level < 60) then
		return rating / (self.StatRatingBaseTable[stat] * ((level >= 10 and level or 10) - 8) / 52);
	elseif (level < 70) then
		return rating / (self.StatRatingBaseTable[stat] * 82 / (262 - 3 * level));
	else
		return rating / (self.StatRatingBaseTable[stat] * (level + 12) / 52);
	end
end