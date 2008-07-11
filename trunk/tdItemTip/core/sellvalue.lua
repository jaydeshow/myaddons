--[[
	this is from SellFish
--]]

local ItemPrice, IP_Version
if LibStub then
	ItemPrice, IP_Version = LibStub("ItemPrice-1.1", true)
else
	return
end

-- save db
local SellValue = {}

local function ToID(link)
	if link then
		return tonumber(link) or tonumber(link:match("item:(%d+)") or tonumber(select(2, GetItemInfo(link)):match("item:(%d+)")))
	end
end

local _GetSellValue = GetSellValue
function GetSellValue(link)
	assert(link, "Usage: GetSellValue(itemID|\"name\"|\"itemLink\")")

	if link then
		return SellValue:GetCost(ToID(link))
	end

	return _GetSellValue and _GetSellValue(link)
end

function SellValue:GetItemValue(bag, slot)
	self.tip.lastCost = nil

	local repairCost = (select(2, self.tip:SetBagItem(bag, slot)))
	if (repairCost or 0) == 0 then
		return self.tip.lastCost or 0
	end
end

--saves the price to newVals if its not the same as the one in the database
function SellValue:SaveCost(id, cost)
	if cost ~= self:GetCost(id) then
		tdItemTipDB.newVals[id] = cost
	end
end

function SellValue:GetCost(id)
	if tdItemTipDB.newVals[id] then
		return tdItemTipDB.newVals[id]
	else
		return ItemPrice and ItemPrice:GetPriceById(id)
	end
end

function SellValue:ScanPrices()
	local tip = self.tip

	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link then
				local cost = self:GetItemValue(bag, slot)
				if cost then
					local count = (select(2, GetContainerItemInfo(bag, slot)))
					self:SaveCost(ToID(link), cost/count)
				end
			end
		end
	end
end

function SellValue:Load()
	local tip = CreateFrame("GameTooltip", "tdItemTipSellValueTip", UIParent, "GameTooltipTemplate")
	tip:SetScript("OnTooltipAddMoney", function(self, cost) self.lastCost = cost end)

	tip:SetScript("OnEvent", function(self, event, arg1)
		if event == "MERCHANT_SHOW" then
			SellValue:ScanPrices()
		elseif event == "ADDON_LOADED" then
			if(arg1 == "tdItemTip") then
				self:UnregisterEvent("ADDON_LOADED")
				if tdItemTipDB.ipversion ~= IP_Version then
					tdItemTipDB.newVals = {}
					tdItemTipDB.ipversion = IP_Version
				else
					tdItemTipDB.newVals = tdItemTipDB.newVals or {}
				end
			end
		end
	end)
	tip:RegisterEvent("MERCHANT_SHOW")
	tip:RegisterEvent("ADDON_LOADED")
	self.tip = tip
end

local icons = "|TInterface\\AddOns\\tdItemTip\\Icons\\UI-%sIcon:0|t"
local GOLD_TEXT = format(icons, "Gold")
local SILVER_TEXT = format(icons, "Silver")
local COPPER_TEXT = format(icons, "Copper")

local tdItemTip = tdItemTip
local L = TDITEMTIP_LOCALE

local function MoneyToGSC(money)
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD))
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
	local copper = money % COPPER_PER_SILVER

	return gold, silver, copper
end

local function GSCToString(gold, silver, copper)
	local str, text
	if gold > 0 then
		str = format("|cffffffff%d|r%s", gold, GOLD_TEXT)
		text = text and text .. str or str
	end
	if silver > 0 then
		str = format(" |cffffffff%d|r%s", silver, SILVER_TEXT)
		text = text and text .. str or str
	end
	if copper > 0 then
		str = format(" |cffffffff%d|r%s", copper, COPPER_TEXT)
		text = text and text .. str or str
	end
	return text
end

local function AddMoneyToTooltip_Short(tip, cost, count)
	local text = GSCToString(MoneyToGSC(cost))

	if count and count > 1 then
		tip:AddDoubleLine(format(L.SellsForMany, count), text, 0, 1, 1, 1, 1, 1, 0)
	else
		tip:AddDoubleLine(L.SellsFor, text, 0, 1, 1, 1, 1, 1, 0)
	end
end

local function AddMoneyToTooltip_Compact(tip, cost, count)
	local costText
	if cost >= 10000 then
		costText = format("|cffffffff%.2f|r%s", cost/10000, GOLD_TEXT)
	elseif cost >= 100 then
		costText = format("|cffffffff%.2f|r%s", cost/100, SILVER_TEXT)
	else
		costText = format("|cffffffff%d|r%s", cost, COPPER_TEXT)
	end

	if count and count > 1 then
		tip:AddDoubleLine(format(L.SellsForMany, count), costText, 0, 1, 1, 1, 1, 1, 0)
	else
		tip:AddDoubleLine(L.SellsFor, costText, 0, 1, 1, 1, 1, 1, 0)
	end
end

local function AddMoneyToTooltip(tip, link, count)
	local price = GetSellValue(link)
	if not price or (count and count == 0) then return end
	if price == 0 then
		tip:AddLine(ITEM_UNSELLABLE, 0, 1, 1)
	else
		local cost = price * (count or 1)
		if cost > 0 then
			local style = tdItemTipDB.svstyle

			if style == 2 then
				AddMoneyToTooltip_Compact(tip, cost, count)
			elseif style == 3 then
				AddMoneyToTooltip_Short(tip, cost, count)
			else
				tip:AddLine(" "..GSCToString(MoneyToGSC(cost)), 1, 1, 1)
			end
		end
	end
	tip:Show()
end

local function IsBagSlot(slot)
	return slot >= 20 and slot <= 23 or slot >= 68
end

local countfuncs = {
	SetHyperlink = function(link, count)
		if GetItemInfo(link) then
			return count
		end
	end,

	SetBagItem = function(bag, slot)
		if not MerchantFrame:IsVisible() then
			return select(2, GetContainerItemInfo(bag, slot))
		end
		return 0
	end,

	SetInventoryItem = function(unit, slot)
		return not(IsBagSlot(slot)) and GetInventoryItemCount(unit, slot)
	end,

	SetLootItem = function(slot)
		if LootSlotIsItem(slot) then
			return select(3, GetLootSlotInfo(slot))
		end
	end,

	SetLootRollItem = function(slot)
		return select(3, GetLootRollItemInfo(slot))
	end,

	SetAuctionItem = function(type, index)
		return select(3, GetAuctionItemInfo(type, index))
	end,

	SetAuctionSellItem = function()
		return select(3, GetAuctionSellItemInfo())
	end,

	SetCraftItem = function(skill, id)
		return select(3, GetCraftReagentInfo(skill, id))
	end,

	SetTradeSkillItem = function(skill, id)
		if id then
			return select(3, GetTradeSkillReagentInfo(skill, id))
		end
		return GetTradeSkillNumMade(skill)
	end,

	SetQuestItem = function(type, index)
		return select(3, GetQuestItemInfo(type, index))
	end,

	SetQuestLogItem = function(type, index)
		if type == "choice" then
			return select(3, GetQuestLogChoiceInfo(index))
		end
		return select(3, GetQuestLogRewardInfo(index))
	end,

	SetTradePlayerItem = function(id)
		return select(3, GetTradePlayerItemInfo(id))
	end,

	SetTradeTargetItem = function(id)
		return select(3, GetTradeTargetItemInfo(id))
	end,

	SetInboxItem = function(id)
		return select(3, GetInboxItem(id))
	end,

	SetSendMailItem = function(id)
		return select(3, GetSendMailItem(id))
	end,

	SetGuildBankItem = function(tab, slot)
		return select(2, GetGuildBankItemInfo(tab, slot))
	end,

	SetMerchantCostItem = function(index, item)
		return select(2, GetMerchantItemCostItem(index, item))
	end,

	SetSocketGem = function()
		return 1
	end,

	SetExistingSocketGem = function()
		return 1
	end,

	SetHyperlinkCompareItem = function()
		return 1
	end,
}

local function hook(tip, method)
	if not tip or not method or not countfuncs[method] then return end
	hooksecurefunc(tip, method, function(self, ...)
		if not tdItemTipDB.sellvalue then return end
		local link = select(2, self:GetItem())
		if link then
			AddMoneyToTooltip(tip, link, countfuncs[method](...))
		end
	end)
end
tinsert(tdItemTip.hooks, hook)
SellValue:Load()