
-------------------------------------------------------------------------------
--- Function declarations. ----------------------------------------------------

local function ValuationUI_AddInfoToTooltip(frame, value, amount)
	if (Valuation["styles"][ValuationCfg["style"]]) then
		Valuation["styles"][ValuationCfg["style"]].Draw(frame, value, amount);
	end
end

local function ValuationUI_Hook(table, name, hook)
	hooksecurefunc(table, name, function (_, ...)
		local link, amount, repair = hook(...);
		repair = repair or 0;
		
		local ID    = link and tonumber(link:match("item:(%d+)"));
		local price = ID   and GetSellValue(ID);
		
		if (price) then
			price = price * amount;
			
			if (repair < price) then
				price = price - repair;
			elseif (price > 0) then
				price = 1;
			end
			
			ValuationUI_AddInfoToTooltip(table, price, amount);
		end
	end);
end

-------------------------------------------------------------------------------
--- User Interface hooks. -----------------------------------------------------

ValuationUI_Hook(ItemRefTooltip, "SetHyperlink", function (link)
	return link, 1;
end);

ValuationUI_Hook(GameTooltip, "SetBagItem", function (...)
	if (not MerchantFrame:IsVisible()) then
		local repair = select(2, ValuationTooltip:SetBagItem(...));
		
		return GetContainerItemLink(...), select(2, GetContainerItemInfo(...)), repair;
	end
end);

ValuationUI_Hook(GameTooltip, "SetInventoryItem", function (target, slot)
	local link = GetInventoryItemLink(target, slot);
	local repair = select(3, ValuationTooltip:SetInventoryItem(target, slot));
	
	if (slot >= 20 and slot <= 23 or slot >= 68 and slot <= 74) then
		return link, 1, repair;
	elseif (slot >= 40 and slot <= 67 or slot >= 87 and slot <= 119 or slot <= 19) then
		if (not MerchantFrame:IsVisible()) then
			return link, math.max(GetInventoryItemCount(target, slot), 1), repair;
		end
	end
end);

ValuationUI_Hook(GameTooltip, "SetLootItem", function (...)
	if (LootSlotIsItem(...)) then
		return GetLootSlotLink(...), select(3, GetLootSlotInfo(...)), nil;
	end
end);

ValuationUI_Hook(GameTooltip, "SetLootRollItem", function (...)
	return GetLootRollItemLink(...), select(3, GetLootRollItemInfo(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetQuestItem", function (...)
	return GetQuestItemLink(...), select(3, GetQuestItemInfo(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetQuestLogItem", function (type, slot)
	local link = GetQuestLogItemLink(type, slot);
	
	if (type == "choice") then
		return link, select(3, GetQuestLogChoiceInfo(slot)), nil;
	end
	
	return link, select(3, GetQuestLogRewardInfo(slot)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetAuctionItem", function (...)
	return GetAuctionItemLink(...), select(3, GetAuctionItemInfo(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetAuctionSellItem", function (...)
	return select(2, GetItemInfo(GetAuctionSellItemInfo(...))), select(3, GetAuctionSellItemInfo(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetTradePlayerItem", function (...)
	local repair = select(2, ValuationTooltip:SetTradePlayerItem(...));
	
	return GetTradePlayerItemLink(...), select(3, GetTradePlayerItemInfo(...)), repair;
end);

ValuationUI_Hook(GameTooltip, "SetTradeTargetItem", function (...)
	local repair = select(2, ValuationTooltip:SetTradeTargetItem(...));
	
	return GetTradeTargetItemLink(...), select(3, GetTradeTargetItemInfo(...)), repair;
end);

ValuationUI_Hook(GameTooltip, "SetTradeSkillItem", function (craft, reagent)
	if (reagent) then
		return GetTradeSkillReagentItemLink(craft, reagent), select(3, GetTradeSkillReagentInfo(craft, reagent)), nil;
	end
	
	return GetTradeSkillItemLink(craft), GetTradeSkillNumMade(craft), nil;
end);

ValuationUI_Hook(GameTooltip, "SetCraftItem", function (...)
	return GetCraftReagentItemLink(...), select(3, GetCraftReagentInfo(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetCraftSpell", function (...)
	return GetCraftItemLink(...), 1;
end);

ValuationUI_Hook(GameTooltip, "SetSocketGem", function (...)
	return GetNewSocketLink(...), 1;
end);

ValuationUI_Hook(GameTooltip, "SetExistingSocketGem", function (...)
	return GetExistingSocketLink(...), 1;
end);

ValuationUI_Hook(GameTooltip, "SetTrainerService", function (...)
	return GetTrainerServiceItemLink(...) or select(2, GameTooltip:GetItem()), 1;
end);

ValuationUI_Hook(GameTooltip, "SetMerchantItem", function (...)
	return GetMerchantItemLink(...), select(4, GetMerchantItemInfo(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetMerchantCostItem", function (...)
	return select(2, GameTooltip:GetItem()), select(2, GetMerchantItemCostItem(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetSendMailItem", function (...)
	return select(2, GetItemInfo(GetSendMailItem(...))), select(3, GetSendMailItem(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetInboxItem", function (...)
	return GetInboxItemLink(...), select(3, GetInboxItem(...)), nil;
end);

ValuationUI_Hook(GameTooltip, "SetGuildBankItem", function (...)
	return GetGuildBankItemLink(...), select(2, GetGuildBankItemInfo(...)), nil;
end);

-------------------------------------------------------------------------------
--- Generic clean-up. ---------------------------------------------------------

ValuationUI_Hook = nil;

