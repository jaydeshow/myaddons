Outfitter._QuickSlots = {}
Outfitter._QuickSlotButton = {}

Outfitter.cIgnoredQuickslotItems = 
{
	[2901] = "Mining Pick",
	[5956] = "Blacksmith hammer",
	[6219] = "Arclight Spanner",
	[7005] = "Skinning Knife",
}

function Outfitter.InitializeQuickSlots()
	local vName = "OutfitterQuickSlots"
	
	Outfitter.QuickSlots = CreateFrame("Frame", vName, PaperDollFrame)

	Outfitter.InitializeFrame(Outfitter.QuickSlots, Outfitter._ButtonBar, Outfitter._QuickSlots)
	Outfitter.QuickSlots:Construct(vName, 1, 1, Outfitter._QuickSlotButton, "OutfitterQuickSlotItemTemplate")
end

function Outfitter._QuickSlots:Construct(...)
	Outfitter._ButtonBar.Construct(self, ...)
	
	self:HookPaperDollFrame()
	self:EnableMouse(true)
	
	-- self:SetFrameStrata("DIALOG")
	Outfitter.SetFrameLevel(self, PaperDollFrame:GetFrameLevel() + 10)
	
	self:SetScript("OnShow", function () this:OnShow() end)
	self:SetScript("OnHide", function () this:OnHide() end)
	
end

function Outfitter._QuickSlots:HookPaperDollFrame()
	for _, vSlotName in ipairs(Outfitter.cSlotNames) do
		local	vSlotButton = getglobal("Character"..vSlotName)
		
		Outfitter.HookScript(vSlotButton, "PreClick", Outfitter.PaperDollItemSlotButton_PreClick)
		Outfitter.HookScript(vSlotButton, "PostClick", Outfitter.PaperDollItemSlotButton_PostClick)
		Outfitter.HookScript(vSlotButton, "OnDragStart", Outfitter.PaperDollItemSlotButton_OnDragStart)
		Outfitter.HookScript(vSlotButton, "OnDragStop", Outfitter.PaperDollItemSlotButton_OnDragStop)
	end
end

function Outfitter._QuickSlots:Open(pSlotName)
	local	vPaperDollSlotName = "Character"..pSlotName
	
	-- Hide the tooltip so that it isn't in the way
	
	GameTooltip:Hide()
	
	-- Position the window
	
	if pSlotName == "MainHandSlot"
	or pSlotName == "SecondaryHandSlot"
	or pSlotName == "RangedSlot"
	or pSlotName == "AmmoSlot" then
		self:SetPoint("TOPLEFT", vPaperDollSlotName, "BOTTOMLEFT", 0, 0)
	else
		self:SetPoint("TOPLEFT", vPaperDollSlotName, "TOPRIGHT", 5, 6)
	end
	
	self.SlotName = pSlotName
	
	-- Populate the items
	
	local vItems = Outfitter:FindItemsInBagsForSlot(pSlotName)
	local vNumButtons = 0
	local vEmptyBagSlotInfo
	
	if vItems then
		for vIndex, vItemInfo in ipairs(vItems) do
			if not Outfitter.cIgnoredQuickslotItems[vItemInfo.Code] then
				vNumButtons = vNumButtons + 1
			end
		end
	end
	
	if not Outfitter:InventorySlotIsEmpty(pSlotName) then
		vEmptyBagSlotInfo = Outfitter:GetEmptyBagSlot()
		
		if vEmptyBagSlotInfo then
			vNumButtons = vNumButtons + 1
		end
	end
	
	self:SetDimensions(vNumButtons, 1)
	
	if vItems then
		local vButtonIndex = 1
		
		for _, vItemInfo in ipairs(vItems) do
			if not Outfitter.cIgnoredQuickslotItems[vItemInfo.Code] then
				self:SetSlotToBag(vButtonIndex, vItemInfo.BagIndex, vItemInfo.BagSlotIndex)
				vButtonIndex = vButtonIndex + 1
			end
		end
	end
	
	if vEmptyBagSlotInfo then
		self:SetSlotToBag(vNumButtons, vEmptyBagSlotInfo.BagIndex, vEmptyBagSlotInfo.BagSlotIndex)
	end
	
	if vNumButtons == 0 then
		self:Hide()
	else
		self:Show()
	end
end

function Outfitter._QuickSlots:Close()
	self:Hide()
end

function Outfitter._QuickSlots:InventoryChanged(pOnlyAmmoChanged)
	if self.SlotName == "AmmoSlot"
	or pOnlyAmmoChanged then
		return
	end
	
	self:Close()
end
		
function Outfitter._QuickSlots:OnShow()
	Outfitter:BeginMenu(self)
	Outfitter.SetFrameLevel(self, PaperDollFrame:GetFrameLevel() + 10)
end

function Outfitter._QuickSlots:OnHide()
	Outfitter:EndMenu(self)
end

function Outfitter._QuickSlots:SetSlotToBag(pQuickSlotIndex, pBagIndex, pBagSlotIndex)
	local vButton = self:GetIndexedButton(pQuickSlotIndex)
	
	vButton:SetID(pBagIndex)
	vButton.ItemButton:SetID(pBagSlotIndex)
	
	ContainerFrame_Update(vButton)
end

function Outfitter.QuickSlotItem_OnShow()
	this:RegisterEvent("BAG_UPDATE")
	this:RegisterEvent("BAG_UPDATE_COOLDOWN")
	this:RegisterEvent("ITEM_LOCK_CHANGED")
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS")
end

function Outfitter.QuickSlotItem_OnHide()
	this:UnregisterEvent("BAG_UPDATE")
	this:UnregisterEvent("BAG_UPDATE_COOLDOWN")
	this:UnregisterEvent("ITEM_LOCK_CHANGED")
	this:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
end

function Outfitter.QuickSlotItemButton_OnEnter(pButton)
	GameTooltip:SetOwner(pButton, "ANCHOR_RIGHT")
	
	local	vBagIndex = pButton:GetParent():GetID()
	local	vBagSlotIndex = pButton:GetID()
	
	local	vHasItem, vHasCooldown, vRepairCost
	
	if vBagIndex == -1 then
		vHasItem, vHasCooldown, vRepairCost = GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(vBagSlotIndex))
	else
		vHasCooldown, vRepairCost = GameTooltip:SetBagItem(vBagIndex, vBagSlotIndex)
	end
	
	if ( InRepairMode() and (vRepairCost and vRepairCost > 0) ) then
		GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1)
		SetTooltipMoney(GameTooltip, vRepairCost)
		GameTooltip:Show()
	elseif this.readable or (IsControlKeyDown() and pButton.hasItem) then
		ShowInspectCursor()
	elseif MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 1 then
		ShowContainerSellCursor(pButton:GetParent():GetID(), pButton:GetID())
	else
		ResetCursor()
	end
end

function Outfitter:QuickSlotItemButton_OnUpdate()
end

----------------------------------------
-- Outfitter._QuickSlotButton
----------------------------------------

function Outfitter._QuickSlotButton:Construct()
	self.size = 1
	self.ItemButton = getglobal(self:GetName().."Item1")
	
	Outfitter.SetFrameLevel(self, Outfitter.QuickSlots:GetFrameLevel() + 1)
end

function Outfitter._QuickSlotButton:OnShow()
end

function Outfitter._QuickSlotButton:OnHide()
end

----------------------------------------
-- Outfitter.PaperDollItemSlotButton
----------------------------------------

function Outfitter.PaperDollItemSlotButton_PreClick(self, pButton, pDown)
	Outfitter.QuickSlots.CurrentInventorySlot = Outfitter.cSlotIDToInventorySlot[self:GetID()]
	Outfitter.QuickSlots.CurrentSlotIsEmpty = GetInventoryItemLink("player", self:GetID()) == nil
end

function Outfitter.PaperDollItemSlotButton_PostClick(self, pButton, pDown)
	-- If there's an item on the cursor then open the slots otherwise
	-- make sure they're closed
	
	if not Outfitter.QuickSlots:IsVisible()
	and (CursorHasItem() or Outfitter.QuickSlots.CurrentSlotIsEmpty) then
		-- Hide the tooltip so that it isn't in the way
		
		GameTooltip:Hide()
		
		-- Open QuickSlots
		
		Outfitter.QuickSlots:Open(Outfitter.QuickSlots.CurrentInventorySlot)
	else
		Outfitter.QuickSlots:Close()
	end
end

function Outfitter.PaperDollItemSlotButton_OnDragStart(self)
	Outfitter.QuickSlots.CurrentInventorySlot = Outfitter.cSlotIDToInventorySlot[self:GetID()]
	Outfitter.QuickSlots.CurrentSlotIsEmpty = false

	-- Open the QuickSlots
	
	Outfitter.QuickSlots:Open(Outfitter.QuickSlots.CurrentInventorySlot)
end

function Outfitter.PaperDollItemSlotButton_OnDragStop(self)
	Outfitter.QuickSlots:Close()
end

Outfitter:RegisterOutfitEvent("OUTFITTER_INIT", function () Outfitter.InitializeQuickSlots() end)
