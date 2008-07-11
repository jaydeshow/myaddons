
tdItemTip = CreateFrame("Frame")
local tdItemTip = tdItemTip

-- options
tdItemTipDB = {
	chatshowtip = true,
	chatshowequip = true,
	chatshift = true,
	actionshowequip = nil,
	refshowequip = true,
	shift = nil,
	rating = true,
	itemlevel = true,
	itemid = true,
	itemstack = true,
	sellvalue = true,
	svstyle = 3,
}

tdItemTip.buttons = {
	{var = "chatshowtip",     },
	{var = "chatshowequip",   move = 1,},
	{var = "chatshift",       move = 2,},
	{var = "actionshowequip", },
	{var = "refshowequip",    },
	{var = "shift",           },
	{var = "rating",          loaded = {"RatingBuster"},},
	{var = "locklevel",	move = 1,},
	{var = "itemlevel",       loaded = {"RatingBuster"},},
	{var = "itemid",          loaded = {"RatingBuster"},},
	{var = "itemstack",},
	{var = "itemref",},
	{var = "sellvalue",},
}
tdItemTip.hooks = {}

tdItemTip.methods = {
	"SetHyperlink",
	"SetBagItem",
	"SetInventoryItem",
	"SetAuctionItem",
	"SetAuctionSellItem",
	"SetLootItem",
	"SetLootRollItem",
	"SetCraftSpell",
	"SetCraftItem",
	"SetTradeSkillItem",
	"SetTrainerService",
	"SetInboxItem",
	"SetSendMailItem",
	"SetQuestItem",
	"SetQuestLogItem",
	"SetTradePlayerItem",
	"SetTradeTargetItem",
	"SetMerchantItem",
	"SetBuybackItem",
	"SetSocketGem",
	"SetExistingSocketGem",
	"SetHyperlinkCompareItem",
	"SetGuildBankItem",
	"SetMerchantCostItem",
};

function tdItemTip:HookFrameScript(frame, script, func)
	if not frame or not script or not func then return end
	if frame:GetScript(script) then
		frame:HookScript(script, func)
	else
		frame:SetScript(script, func)
	end
end

function tdItemTip:TestAddOn(loaded, unloaded, loadedfunc, unloadedfunc, ...)
	local found
	if loaded then
		for i, addon in ipairs(loaded) do
			if IsAddOnLoaded(addon) then
				found = loadedfunc and loadedfunc(i, addon, ...)
				found = true
			end
		end
	end
	if unloaded then
		for i, addon in ipairs(unloaded) do
			if not IsAddOnLoaded(addon) then
				found = unloadedfunc and unloadedfunc(i, addon, ...)
				found = true
			end
		end
	end
	return found
end

function tdItemTip:HookFrameMethod(tip, method)
	if not tip then return end
	if method then
		for i, hook in ipairs(self.hooks) do
			hook(tip, method)
		end
	else
		for i, v in ipairs(self.methods) do
			for j, hook in ipairs(self.hooks) do
				hook(tip, v)
			end
		end
	end
end

function tdItemTip:Event(event, ...)
	if event == "VARIABLES_LOADED" then
		for i, button in ipairs(self.buttons) do
			self:TestAddOn(button.loaded, button.unloaded,
				function(i, addon, var) tdItemTipDB[var] = nil end,
				function(i, addon, var) tdItemTipDB[var] = nil end,
				button.var
			)
		end
		self:HookFrameMethod(GameTooltip)
		self:HookFrameMethod(ItemRefTooltip, "SetHyperlink");
		self:HookFrameMethod(AtlasLootTooltip, "SetHyperlink");
		self:HookFrameMethod(ShoppingTooltip1, "SetHyperlinkCompareItem");
		self:HookFrameMethod(ShoppingTooltip1, "SetExistingSocketGem")
		self:HookFrameMethod(ShoppingTooltip2, "SetHyperlinkCompareItem");
		self:HookFrameMethod(GameTooltip3, "SetHyperlinkCompareItem");
		self:HookFrameMethod(GameTooltip4, "SetHyperlinkCompareItem");
		if self.SetGuildBank then
			self:RegisterEvent("ADDON_LOADED")
		end
	elseif event == "ADDON_LOADED" and arg1 == "Blizzard_GuildBankUI" then
		self:SetGuildBank()
		self:UnregisterEvent(event)
	end
end

tdItemTip:SetScript("OnEvent", tdItemTip.Event)
tdItemTip:RegisterEvent("VARIABLES_LOADED")