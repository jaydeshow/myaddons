FreeRefills = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FreeRefills")


function FreeRefills:OnInitialize()
	local defaults = {
		overstock = false,
		merchant = true,
		bank = true,
		refills = {},
	}

	local args = {
		type = 'group',
		handler = self,
		args = {
			add = {
				name = L["Add"], type = 'text',
			    desc = L["Add an item to the refill list. (Usage: /freerefills add [Item Link] #)"],
				get = false,
			    set = "AddRefillItem",
				usage = L["[Item Link] <number of items>"],
				guiHidden = true
			},
			addstack = {
				name = L["Add Stack"], type = 'text',
			    desc = L["Add an item to the refill list by stack. (Usage: /freerefills addstack [Item Link] #)"],
			    get = false,
				set = "AddRefillItemStack",
				usage = L["[Item Link] <number of stacks>"],
				guiHidden = true
			},
			del = {
				name = L["Remove"], type = 'text',
			    desc = L["Remove an item from the refill list. (Usage: /freerefills del [Item Link])"],
				get = false,
			    set = "RemoveRefillItem",
				usage = L["[Item Link]"],
				guiHidden = true
			},
			overstock = {
				name = L["Overstock"], type = 'toggle',
				desc = L["Toggle Overstocking.  If an item is sold in stacks and cannot meet your exact requested amount, you can opt to buy slightly more (Overstock)."],
				get = function() return self.db.profile.overstock end,
				set = function(v) self.db.profile.overstock = v end
			},
			merchant = {
				name = L["Process Merchant"], type = 'toggle',
				desc = L["Toggle Merchant Looting."],
				get = function() return self.db.profile.merchant end,
				set = function()
					if self.db.profile.merchant == true then
						self:UnregisterEvent("MERCHANT_SHOW")
						self.db.profile.merchant = false
					elseif self.db.profile.merchant == false then
						self:RegisterEvent("MERCHANT_SHOW")
						self.db.profile.merchant = true
					end
				end
			},
			bank = {
				name = L["Process Bank"], type = 'toggle',
				desc = L["Toggle Bank Looting."],
				get = function() return self.db.profile.bank end,
				set = function()
					if self.db.profile.bank == true then
						self:UnregisterEvent("BANKFRAME_OPENED")
						self.db.profile.bank = false
					elseif self.db.profile.bank == false then
						self:RegisterEvent("BANKFRAME_OPENED")
						self.db.profile.bank = true
					end
				end
			},
			reset = {
				name = L["Clear"], type = 'execute',
			    desc = L["Clear the refill list completely."],
			    func = "ClearRefills",
			},
			list = {
				name = L["List"], type = 'execute',
			    desc = L["List the items in the refill list."],
			    func = "List",
			}
		}
	}

	self:RegisterDB("FreeRefillsDB", nil, "char")
	self:RegisterDefaults('profile', defaults )

	self:RegisterChatCommand("/freerefills", "/fr", args, "FREEREFILLS")
end

function FreeRefills:OnEnable()
	if self.db.profile.merchant then self:RegisterEvent("MERCHANT_SHOW") end
	if self.db.profile.bank then self:RegisterEvent("BANKFRAME_OPENED") end
end

function FreeRefills:debug(msg)
	-- self:Print("|cff0099CC"..msg.."|r")
end

--[[--------------------------------------------------------------------------------
  Merchant Processing
-----------------------------------------------------------------------------------]]

function FreeRefills:MERCHANT_SHOW()
	self:debug("Merchant Opened")
	for itemID, amount in pairs(self.db.profile.refills) do
		local merchSlot = self:ItemInStock(itemID)
		if merchSlot then
			self:debug("Item Found in Merchant Slot #"..merchSlot)
			local amountInBags = GetItemCount(itemID)
			if amountInBags >= amount then
				self:debug("Already have enough in bags.")
			else
				local stackCycle, stackRem = self:CalculateNeeded(amount, amountInBags, merchSlot)
				if stackCycle then self:debug("Need to buy "..stackCycle.." more full stacks.") end
				if stackRem then self:debug("Need to buy "..stackRem.." item(s) (Remainder stack)") end
				local numAvailable = select(5, GetMerchantItemInfo(merchSlot))
				if stackCycle then
					if stackCycle*GetMerchantItemMaxStack(merchSlot) > numAvailable and numAvailable > 0 then
						self:debug("Can only buy "..numAvailable)
						BuyMerchantItem(merchSlot, numAvailable)
					else
						for i = 1, stackCycle do
							BuyMerchantItem(merchSlot, GetMerchantItemMaxStack(merchSlot))
						end
					end
				end
				if stackRem then
					if stackRem > numAvailable and numAvailable > 0 then
						self:debug("Can only buy "..numAvailable)
						stackRem = numAvailable
					end
					BuyMerchantItem(merchSlot, stackRem)
				end
			end
		end
	end
end

function FreeRefills:ItemInStock(itemLink)
	self:debug("Searching for Item: "..itemLink)
	local itemToFind = GetItemInfo(itemLink)
	local numItems = GetMerchantNumItems()
	for i = 1, numItems do
		local merchantItemLink = GetMerchantItemLink(i)
		if merchantItemLink then
			local item = GetItemInfo(merchantItemLink)
			if item == itemToFind then
				return i
			end
		end
	end
end

function FreeRefills:CalculateNeeded(amount, amountInBags, merchSlot)
	-- more detailed logic regauding stacks should be taken care of here
	local amountNeeded
	local stackSize = select(4, GetMerchantItemInfo(merchSlot))
	local stackedAmount
	local stackedNeeded
	local maxBuy = GetMerchantItemMaxStack(merchSlot)
	local stackCycle
	local stackRem

	self:debug("Stacksize: "..stackSize)

	if stackSize ~= 1 then
		stackedAmount = amount / stackSize
		stackedNeeded = amountInBags / stackSize
		amountNeeded = stackedAmount - stackedNeeded
		self:debug("Unrounded Needed: "..amountNeeded)
		if self.db.profile.overstock == true then
			stackCycle = math.ceil(amountNeeded)
		else
			stackCycle = math.floor(amountNeeded)
		end
	else
		local finalNeeded = amount - amountInBags
		self:debug("Need to buy "..finalNeeded.." more.  Merchant sells in max stacks of "..maxBuy..".")
		if finalNeeded > maxBuy then
			local stacks = finalNeeded / maxBuy
			stackCycle = math.floor(stacks)
			stackRem = finalNeeded - (stackCycle * maxBuy)
		else
			stackRem = finalNeeded
		end
	end

	if stackCycle and stackCycle <= 0 then stackCycle = nil end
	if stackRem and stackRem <= 0 then stackRem = nil end

	return stackCycle, stackRem
end

--[[--------------------------------------------------------------------------------
  Bank Processing
-----------------------------------------------------------------------------------]]

function FreeRefills:BANKFRAME_OPENED()
	self:debug("Bank Opened")
	for itemID,amount in pairs(self.db.profile.refills) do
		local amountInBags = GetItemCount(itemID)
		local amountInBank = GetItemCount(itemID, true)
		if amountInBank > amountInBags then
			amountInBank = amountInBank - amountInBags
			local amountNeeded = amount - amountInBags
			if amountInBags >= amount then
				self:debug("Already have enough in bags.")
			else
				if amountNeeded > amountInBank then
					amountNeeded = amountInBank end
				self:debug(amountNeeded.." item(s) to be looted.")
				self:LootBank(itemID, amountNeeded)
			end
		end
	end
end

local function linkDecode(link)
	if link then
		return select(3, link:find("Hitem[^|]+|h%[([^[]+)%]"))
	end
end

function FreeRefills:LootBank(itemID, amountNeeded)
	self:debug("Bank Looting Logic: "..itemID.." - "..amountNeeded)
	--Scan the main bank first
	for slot = 1, 24 do
		local slotID = GetContainerItemLink(BANK_CONTAINER, slot)
		local checkitemID = linkDecode(itemID)
		local checkslotID = linkDecode(slotID)
		if checkslotID == checkitemID then
			local slotCount = select(2, GetContainerItemInfo(BANK_CONTAINER, slot))
			self:debug(slotCount.." Item(s) Found in Bank:Slot "..slot)
			if slotCount <= amountNeeded then --We don't have to split this stack, we can cheat and use UseContainerItem
				self:debug("Looting Entire Stack")
				UseContainerItem(BANK_CONTAINER, slot)
				amountNeeded = amountNeeded - slotCount
				self:debug(slotCount.." Looted - Need "..amountNeeded.." more item(s)")
			else
				SplitContainerItem(BANK_CONTAINER, slot, amountNeeded)
				for bag = NUM_BAG_SLOTS, 0, -1 do
					self:debug("Scanning Bag #"..bag)

					if select(7, GetItemInfo(GetBagName(bag))) == "Bag" then
						local size = GetContainerNumSlots(bag)
						for slot = 1, size, 1 do
							local slotID = GetContainerItemLink(bag,slot)
							if not slotID then
								if bag == 0 then
									PutItemInBackpack()
								else
									PutItemInBag(bag + 19)
								end
							end
						end
					end
				end
				local amountLooted = amountNeeded
				amountNeeded = amountNeeded - amountLooted -- This should always result in 0
				self:debug(amountLooted.." Looted - Need "..amountNeeded.." more item(s)")
			end
		end
		if amountNeeded == 0 then self:debug(amountNeeded.." item(s) # "..itemID.." needed.  Next item.") return end
	end
	self:debug("Main Bank didn't cover it, scanning additional Bags")
	--Now Scan bank bags
	for bag = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS, 1 do
		local size = GetContainerNumSlots(bag)
		if (size > 0) then
			for slot = 1, size do
				local slotID = GetContainerItemLink(bag, slot)
				local checkitemID = linkDecode(itemID)
				local checkslotID = linkDecode(slotID)
				if checkslotID == checkitemID then
					local slotCount = select(2, GetContainerItemInfo(bag, slot))
					self:debug(slotCount.." Item(s) Found in Bag "..bag..":Slot "..slot..". Need to loot "..amountNeeded)
					if slotCount <= amountNeeded then --We don't have to split this stack, we can cheat and use UseContainerItem
						self:debug("Looting Entire Stack")
						UseContainerItem(bag, slot)
						amountNeeded = amountNeeded - slotCount
						self:debug(slotCount.." Looted - Need "..amountNeeded.." more item(s)")
					else
						SplitContainerItem(bag, slot, amountNeeded)
						for bag = NUM_BAG_SLOTS, 0, -1 do
							self:debug("Scanning Bag #"..bag)
							local bagName = GetBagName(bag)
							if bagName:find("Quiver", 1) == nil and bagName:find("Pouch", 1) == nil then
								local size = GetContainerNumSlots(bag)
								for slot = 1, size, 1 do
									local slotID = GetContainerItemLink(bag,slot)
									if not slotID then
										if bag == 0 then
											self:debug("Item in Bag#"..bag)
											PutItemInBackpack()
										else
											self:debug("Item in Bag#"..bag)
											PutItemInBag(bag + 19)
										end
									end
								end
							end
						end
						local amountLooted = amountNeeded
						amountNeeded = amountNeeded - amountLooted -- This should always result in 0
						self:debug(amountLooted.." Looted - Need "..amountNeeded.." more item(s)")
					end
				end
				if amountNeeded == 0 then self:debug(amountNeeded.." item(s) # "..itemID.." needed.  Next item.") return end
			end
		end
	end
end

--[[--------------------------------------------------------------------------------
  Shared Functions
-----------------------------------------------------------------------------------]]

--[[--------------------------------------------------------------------------------
  Command Handlers
-----------------------------------------------------------------------------------]]

function FreeRefills:AddRefillItem(msg)
	--add an item to the refill list
	local link, num = select(3, msg:find("(.+)%s(%d+)"))
	if not link or not num then
		self:Print(L["Invalid input; input must be '<item> #'."])
		return
	end
	num = tonumber(num)
	self.db.profile.refills[link] = num
	self:Print(L["Added %s - Amount:%d"]:format(link, num))
--	self:Print("Added "..itemID.." - Amount:"..num)
end

local function GetStackSize(item)
	local itemStack = select(8, GetItemInfo(item))
	return itemStack
end

function FreeRefills:AddRefillItemStack(msg)
	--add an item to the refill list by stack
	local link, num = select(3, msg:find("(.+)%s(%d+)"))
	if not link or not num then
		self:Print(L["Invalid input; input must be '<item> #'."])
		return
	end
	num = tonumber(num)
	num = num * GetStackSize(link)
	self.db.profile.refills[link] = num
	self:Print(L["Added %s - Amount:%d"]:format(link, num))
----	self:Print("Added "..itemID.." - Amount:"..num)
end

function FreeRefills:RemoveRefillItem(msg)
	--remove an item from the refill list
	if not self.db.profile.refills[msg] then return end
	self.db.profile.refills[msg] = nil
	self:Print(L["Removed %s."]:format(msg))
end

function FreeRefills:ClearRefills()
	--clear the refill list
	self.db.profile.refills = {}
	self:Print(L["Item List Cleared"])
end

function FreeRefills:List()
	--report back which items are currently on the refill list, and their quanitity
	self:Print(L["Refill List: "])
	local notempty
	for itemID,amount in pairs(self.db.profile.refills) do
		self:Print("     "..itemID.." ("..amount..")")
		notempty = 1
	end
	if not notempty then self:Print(L["     None"]) end
end

