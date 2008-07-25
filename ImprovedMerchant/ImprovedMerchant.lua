local LOCALE = {
	["NOTHING"] = {
		["deDE"] = "Keine Filterung",
		["enUS"] = "Nothing",
		["enGB"] = "Nothing",
		["frFR"] = "Rien",
		["zhCN"] = "无",
		["zhTW"] = "無",
	},
	["USABLE"] = { 
		["deDE"] = "Verwendbar",
		["enUS"] = "Usable",
		["enGB"] = "Usable",
		["frFR"] = "Utilisable",
		["enES"] = "Utilisable",
		["koKR"] = "Usable",
		["zhCN"] = "可用",
		["zhTW"] = "可用",
	},
	["SEARCH"] = {
		["deDE"] = "Suche",
		["enUS"] = "Search",
		["enGB"] = "Search",
		["frFR"] = "Recherche",
		["enES"] = "Recherche",
		["koKR"] = "Search",
		["zhCN"] = "搜索",
		["zhTW"] = "檢索",
	},
	["RATINGBUSTER"] = {
		["deDE"] = "Werteübersicht",
		["enUS"] = "Stat Summary",
		["enGB"] = "Stat Summary",
		["enES"] = "Resumen Estad",
		["koKR"] = "능력치 요약",
		["zhCN"] = "属性统计",
		["zhTW"] = "屬性統計",
	},
}

local function GetLocaleString(localeString)
	local locale = GetLocale()
	if locale == "deDE" or "enUS" or "enUS" or "koKR" or "zhCN" or "zhTW" then
		return LOCALE[localeString][locale]
	else
		return LOCALE[localeString]["enUS"]
	end
end


CreateFrame("Frame", "ImprovedMerchantFilter", MerchantFrame)
CreateFrame("ScrollFrame", "ImprovedMerchant", MerchantFrame, "UIPanelScrollFrameTemplate2")
CreateFrame("Frame", "ImprovedMerchantScrollChild", ImprovedMerchant)
CreateFrame("Button", "ImprovedMerchantSortList", ImprovedMerchantFilter, "UIDropDownMenuTemplate")
CreateFrame("EditBox", "ImprovedMerchantSearchBox", ImprovedMerchantFilter, "InputBoxTemplate")
CreateFrame("Button", "ImprovedMerchantToggleFilter", MerchantFrame)

ImprovedMerchant.sortTypeList = {}

ImprovedMerchant:SetFrameLevel(9)
ImprovedMerchant:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 16, - 76)
ImprovedMerchantScrollChild:SetPoint("TOPLEFT", ImprovedMerchant, "TOPLEFT")
ImprovedMerchantScrollChild:SetWidth(299)

ImprovedMerchant:SetScrollChild(ImprovedMerchantScrollChild)

function ImprovedMerchant:CreateItemCostInfo(itemId, index)
	local itemCost = CreateFrame("Button", nil, _G["itemInfo"..itemId])
	local texture, value, link = GetMerchantItemCostItem(itemId, index)
	if texture then
		itemCost.texture = itemCost:CreateTexture()
		itemCost.texture:SetPoint("BOTTOMRIGHT", itemCost)
		itemCost.texture:SetTexture(texture)
		itemCost.texture:SetWidth(16)
		itemCost.texture:SetHeight(16)
		
		itemCost.count = itemCost:CreateFontString()
		itemCost.count:SetFontObject("NumberFontNormal")
		itemCost.count:SetPoint("RIGHT", itemCost.texture, "LEFT", -2, 0)
		itemCost.count:SetText(value)
		
		itemCost:SetScript("OnEnter", function()
			if _G["itemInfo"..itemId].mode == "buy" then
				GameTooltip:SetOwner(itemCost, "ANCHOR_RIGHT")
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()
				_G["itemInfo"..itemId]:LockHighlight()
			end
		end)
		
		itemCost:SetScript("OnLeave", function()
			GameTooltip:Hide()
			_G["itemInfo"..itemId]:UnlockHighlight()
		end)
		return itemCost
	else
		return CreateFrame("Frame")
	end
end

function ImprovedMerchant:CreateHonorFrame(price, i)
	moneyFrame = CreateFrame("Frame", nil, _G["itemInfo"..i])
	if price then
		moneyFrame.honorIcon = moneyFrame.honorIcon or moneyFrame:CreateTexture()
		moneyFrame.honorIcon:SetWidth(16)
		moneyFrame.honorIcon:SetHeight(16)
		moneyFrame.honorIcon:SetTexture("Interface\\PVPFrame\\PVP-Currency-"..UnitFactionGroup("player"))
		moneyFrame.honorIcon:SetPoint("BOTTOMRIGHT", moneyFrame, "BOTTOMRIGHT")
		moneyFrame.honor = moneyFrame.honor or moneyFrame:CreateFontString()
		moneyFrame.honor:SetFontObject("NumberFontNormal")
		moneyFrame.honor:SetText(price)
		moneyFrame.honor:SetPoint("BOTTOMRIGHT", moneyFrame.honorIcon, "BOTTOMLEFT")
		moneyFrame.honor:SetPoint("BOTTOMLEFT", moneyFrame, "BOTTOMLEFT")
		moneyFrame.honor:SetJustifyH("RIGHT")
		moneyFrame:SetWidth(moneyFrame.honor:GetStringWidth() + 24)
		moneyFrame:Show()
	end
	moneyFrame:SetHeight(16)
	return moneyFrame
end

function ImprovedMerchant:CreateArenaFrame(price, i)
	moneyFrame = CreateFrame("Frame", nil, _G["itemInfo"..i])
	if price then
		moneyFrame.arenaIcon = moneyFrame.arenaIcon or moneyFrame:CreateTexture()
		moneyFrame.arenaIcon:SetWidth(16)
		moneyFrame.arenaIcon:SetHeight(16)
		moneyFrame.arenaIcon:SetTexture("Interface\\PVPFrame\\PVP-ArenaPoints-Icon")
		moneyFrame.arenaIcon:SetPoint("BOTTOMRIGHT", moneyFrame, "BOTTOMRIGHT")
		moneyFrame.arena = moneyFrame.arena or moneyFrame:CreateFontString()
		moneyFrame.arena:SetFontObject("NumberFontNormal")
		moneyFrame.arena:SetText(price)
		moneyFrame.arena:SetPoint("BOTTOMRIGHT", moneyFrame.arenaIcon, "BOTTOMLEFT")
		moneyFrame.arena:SetPoint("BOTTOMLEFT", moneyFrame, "BOTTOMLEFT")	
		moneyFrame.arena:SetJustifyH("RIGHT")
		moneyFrame:SetWidth(moneyFrame.arena:GetStringWidth() + 24)
		moneyFrame:Show()		
	end
	moneyFrame:SetHeight(16)
	return moneyFrame
end

function ImprovedMerchant:SearchTooltip(search, i)
	local result = false
	GameTooltip:ClearLines()
	if search then
		GameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
		GameTooltip:SetMerchantItem(i)
		GameTooltip:Show()
		for line=1,GameTooltip:NumLines() do
			local mytext = getglobal("GameTooltipTextLeft" .. line)
			local text = mytext:GetText()
			if text and string.find(text, LOCALE.RATINGBUSTER[GetLocale()]) then
				break
			end
			if text and string.find(string.lower(text), string.lower(search)) then
				result= true
			end
			local mytext = getglobal("GameTooltipTextRight" .. line)
			local text = mytext:GetText()
			if text and string.find(string.lower(text), string.lower(search)) then
				result = true
			end
		end
	end
	GameTooltip:Hide()
	return result
end

function ImprovedMerchant:CreateMerchantItem(mode, i, filterTable)
	itemInfo = _G["itemInfo"..i] or CreateFrame("BUTTON", "itemInfo"..i, ImprovedMerchantScrollChild)
	
	local name, texture, price, quantity, numAvailable, isUsable, extendedCost
	local itemRarity, itemMinLevel, itemType, itemSubType
	local honorPoints, arenaPoints, itemCount
	if mode == "buy" then
		if GetMerchantItemLink(i) then
			name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(i)
			_, _, itemRarity, _, itemMinLevel, itemType, itemSubType, _, _, _ = GetItemInfo(GetMerchantItemLink(i)) 
			honorPoints, arenaPoints, itemCount = GetMerchantItemCostInfo(i)
			itemInfo:Enable()
			itemInfo.link = GetMerchantItemLink(i)
		end
	else
		if GetBuybackItemLink(i) then
			name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetBuybackItemInfo(i)
			_, _, itemRarity, _, itemMinLevel, itemType, itemSubType, _, _, _ = GetItemInfo(GetBuybackItemLink(i)) 
			itemInfo:Enable()
		end
	end
	
	local isFiltered
	if type(filterTable) == "table" then
		for it, subType in pairs(filterTable) do
			if it == "Search" or subType == "Search" then
				if ImprovedMerchant:SearchTooltip(subType, i) ~= true then
					isFiltered = true
				end
			elseif it == "Usable" or it == GetLocaleString("USABLE") then
				if not isUsable then
					isFiltered = true
				end
			elseif itemSubType ~= it then
				isFiltered = true
			end
		end
	end
	
	if isFiltered == true then
		return CreateFrame("Button")
	end
	
	itemInfo.extendedCost = extendedCost
	itemInfo.price = price or 0
	itemInfo.honorPoints = honorPoints or 0
	itemInfo.arenaPoints = arenaPoints or 0
	itemInfo.count = quantity or 1

	itemInfo.texture = texture
	
	itemInfo.itexture = itemInfo.itexture or itemInfo:CreateTexture("itemInfo"..i.."Texture")
	itemInfo.itexture:SetPoint("TOPLEFT", itemInfo, "TOPLEFT", 6,0)
	itemInfo.itexture:SetWidth(32)
	itemInfo.itexture:SetHeight(32)
	itemInfo.itexture:SetTexture(texture)
	if not isUsable then
		itemInfo.itexture:SetVertexColor(1,0,0)
	else
		itemInfo.itexture:SetVertexColor(1,1,1)
	end
	
	
	itemInfo.icount = itemInfo.icount or itemInfo:CreateFontString("itemInfo"..i.."StackCount")
	itemInfo.icount:SetPoint("BOTTOMRIGHT", itemInfo.itexture, "BOTTOMRIGHT")
	itemInfo.icount:SetFontObject("NumberFontNormal")
	if quantity and quantity > 1 and numAvailable == -1 then
			itemInfo.icount:SetVertexColor(1,1,1)
			itemInfo.icount:SetText(quantity)
	elseif numAvailable and numAvailable > 0 then
		itemInfo.icount:SetVertexColor(1,0.81,0)
		itemInfo.icount:SetText(numAvailable.."x")
	else
		itemInfo.icount:SetText("")
	end
	itemInfo.name = itemInfo.name or itemInfo:CreateFontString("itemInfo"..i.."Name")
	itemInfo.name:SetPoint("TOPLEFT", itemInfo.itexture, "TOPRIGHT", 0)
	itemInfo.name:SetFontObject("GameFontNormal")
	itemInfo.name:SetJustifyH("LEFT")
	
	itemInfo.name:SetHeight(16)
	
	local r,g,b  = GetItemQualityColor(itemRarity or 1)

	itemInfo.name:SetVertexColor(r,g,b)
	itemInfo.name:SetText(name)
	itemInfo.name:SetPoint("TOPRIGHT", itemInfo,"TOPRIGHT", 0, 0)
	
	itemInfo.type = itemInfo.type or itemInfo:CreateFontString("itemInfo"..i.."Type")
	itemInfo.type:SetPoint("TOPLEFT", itemInfo.name, "BOTTOMLEFT", 0)
	itemInfo.type:SetFontObject("GameFontDisable")
	itemInfo.type:SetText(itemSubType)
	itemInfo.type:SetJustifyH("LEFT")
	itemInfo.type:SetPoint("RIGHT", itemInfo)
	
	if itemInfo.price > 0 then
		itemInfo.money = itemInfo.money or CreateFrame("Frame", "itemInfo"..i.."MoneyFrame", itemInfo, "SmallMoneyFrameTemplate")
		MoneyFrame_SetType("STATIC", itemInfo.money)
		MoneyFrame_Update(itemInfo.money:GetName(), itemInfo.price)
		itemInfo.money:Show()
	end
	
	if itemInfo.honorPoints > 0 then
		itemInfo.honor = ImprovedMerchant:CreateHonorFrame(itemInfo.honorPoints, i)	
		itemInfo.honor:Show()
	end

	if itemInfo.arenaPoints > 0 then
		itemInfo.arena = ImprovedMerchant:CreateArenaFrame(itemInfo.arenaPoints, i)	
		itemInfo.arena:Show()
	end

	if itemInfo.extendedCost and itemInfo.extendedCost > 0 then
		itemInfo.extendedItem = {}
		for index = 1, itemInfo.extendedCost do
			itemInfo.extendedItem[index] = ImprovedMerchant:CreateItemCostInfo(i, index)
			if index == 1 then
				itemInfo.extendedItem[index]:SetPoint("BOTTOMRIGHT", itemInfo, "BOTTOMRIGHT", -2,2)
			else
				itemInfo.extendedItem[index]:SetPoint("BOTTOMRIGHT", itemInfo.extendedItem[index-1], "BOTTOMLEFT", 0,0)
			end	
			itemInfo.extendedItem[index]:SetWidth(34)
			itemInfo.extendedItem[index]:SetHeight(16)
		end
	else
		itemInfo.extendedItem = nil
	end
	
	if itemInfo.price > 0 and itemInfo.extendedItem and itemInfo.honorPoints > 0 then
		itemInfo.money:SetPoint("BOTTOMRIGHT", itemInfo.extendedItem[getn(itemInfo.extendedItem)], "BOTTOMLEFT", 0, 0)
		itemInfo.honor:SetPoint("RIGHT", itemInfo.money, "LEFT", 0,0)
	elseif itemInfo.extendedItem and itemInfo.honorPoints > 0 then
		itemInfo.honor:SetPoint("BOTTOMRIGHT", itemInfo.extendedItem[getn(itemInfo.extendedItem)], "BOTTOMLEFT", 0, 0)
	elseif itemInfo.price > 0 and not itemInfo.extendedItem and itemInfo.honorPoints > 0 then
		itemInfo.money:SetPoint("BOTTOMRIGHT", itemInfo, "BOTTOMRIGHT", 8, 2)
		itemInfo.honor:SetPoint("RIGHT", itemInfo.money, "LEFT", 0, 0)
	elseif itemInfo.honorPoints > 0 and itemInfo.arenaPoints > 0 then
		itemInfo.arena:SetPoint("RIGHT", itemInfo.honor, "LEFT", 0,0)
	elseif itemInfo.price > 0 then
		itemInfo.money:SetPoint("BOTTOMRIGHT", itemInfo, "BOTTOMRIGHT", 8, 2)
	elseif itemInfo.arenaPoints > 0 then
		itemInfo.arena:SetPoint("BOTTOMRIGHT", itemInfo, "BOTTOMRIGHT", -2,2)
	elseif itemInfo.honorPoints > 0 then
		itemInfo.honor:SetPoint("BOTTOMRIGHT", itemInfo, "BOTTOMRIGHT", -2,2)
	end
	
	itemInfo.id = i
	
	itemInfo.mode = mode
	
	itemInfo:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	
	itemInfo:RegisterForClicks("LeftButtonUp","RightButtonUp")
	itemInfo:RegisterForDrag("LeftButton")
	
	itemInfo:SetScript("OnDragStart", function(itemInfo)
		MerchantItemButton_OnClick("LeftButton")
	end)
	
	function itemInfo:GetID()
		return self.id
	end
	
	itemInfo.SplitStack = function(button, split)
		if split > 0 then
			BuyMerchantItem(button.id, split)
		end
	end
	
	function itemInfo:update(i)
		local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(self:GetID() or i)
		if numAvailable and numAvailable > 0 then
			self.icount:SetVertexColor(1,0.81,0)
			self.icount:SetText(numAvailable.."x")
		elseif numAvailable and numAvailable == 0 then
			self.icount:SetText(numAvailable.."x")
			self.name:SetFontObject("GameFontDisable")
			self.name:SetVertexColor(0.6,0.6,0.6)
			self.itexture:SetVertexColor(0.6,0.6,0.6)
			if self.money then
				self.money:Hide()
			end
			if self.arena then
				self.arena:Hide()
			end
			if self.honor then
				self.honor:Hide()
			end
		elseif quantity and quantity > 1 and numAvailable == -1 then
			self.name:SetFontObject("GameFontNormal")
			itemInfo.icount:SetVertexColor(1,1,1)
			itemInfo.icount:SetText(quantity)
			if not isUsable then
				self.itexture:SetVertexColor(1,0,0)
			else
				self.itexture:SetVertexColor(1,1,1)
			end		
			if self.money and self.price > 0 then
				self.money:Show()
			end
			if self.arena and self.arenaPoints > 0 then
				self.arena:Show()
			end
			if self.honor and self.honorPoints > 0 then
				self.honor:Show()
			end
		end
	end
	
	
	itemInfo:SetScript("OnClick", function(itemInfo, button)
		if IsModifiedClick() then
			MerchantItemButton_OnModifiedClick(button)
		else
			MerchantItemButton_OnClick(button)
		end
		MerchantFrame_UpdateMerchantInfo()
	end)
	
	itemInfo:SetScript("OnEnter", function()
		MerchantItemButton_OnEnter(this)
	end)
	
	itemInfo:SetScript("OnLeave", function()
		GameTooltip:Hide()
		ResetCursor()
		MerchantFrame.itemHover = nil
	end)
	
	itemInfo:SetScript("OnHide", function()
		if ( this.hasStackSplit == 1 ) then
			StackSplitFrame:Hide();
		end
	end)
	
	if not ImprovedMerchant.sortTypeList[itemSubType] and ((GetMerchantItemLink(i) and mode == "buy") or (GetBuybackItemLink(i) and mode == "buyback")) and type(filterType) ~= "table" then 
		ImprovedMerchant.sortTypeList[itemSubType] = itemSubType
	end
	
	itemInfo:update()
	
	return itemInfo
end

function ImprovedMerchant:DepopulateMerchantList()
	local i = 1
	while _G["itemInfo"..i] and _G["itemInfo"..i]:IsObjectType("Button") do
		itemInfo = _G["itemInfo"..i]
		if itemInfo.itexture then
			itemInfo.itexture:SetTexture()
		end
		if itemInfo.name then
			itemInfo.name:SetText("")
		end
		if itemInfo.type then
			itemInfo.type:SetText("")
		end
		if itemInfo.money then
			itemInfo.money:Hide()
		end
		if itemInfo.honor then
			itemInfo.honor:Hide()
		end
		if itemInfo.arena then
			itemInfo.arena:Hide()
		end
		if itemInfo.extendedItem then
			if itemInfo.extendedItem[1] then
				itemInfo.extendedItem[1]:Hide()
			end
			if itemInfo.extendedItem[2] then
				itemInfo.extendedItem[2]:Hide()
			end
			if itemInfo.extendedItem[3] then
				itemInfo.extendedItem[3]:Hide()
			end
		end
		itemInfo.mode = nil
		itemInfo:Disable()
		itemInfo.link = nil
		itemInfo.id = nil
		itemInfo.link = ""
		itemInfo:Hide()
		itemInfo = nil
		i = i + 1
	end
	ImprovedMerchantScrollChild:SetHeight(0)
end

function ImprovedMerchant:PopulateMerchantList(mode, filterTable)
	if mode then
		if type(filterTable) ~= "table" then
			ImprovedMerchant.sortTypeList = {}
		end
		local num = 12
		if mode == "buy" then
			num = GetMerchantNumItems()
		elseif mode == "buyback" then
			num = GetNumBuybackItems()
		end
		local previousItem = ImprovedMerchantScrollChild
		for iterator = 1, num do
			local item = ImprovedMerchant:CreateMerchantItem(mode, iterator, filterTable)
			if iterator == 1 then
				item:SetPoint("TOPLEFT", ImprovedMerchantScrollChild)
			else
				if previousItem == ImprovedMerchantScrollChild then
					item:SetPoint("TOPLEFT", previousItem, "TOPLEFT")
				else
					item:SetPoint("TOPLEFT", previousItem, "BOTTOMLEFT")
				end
			end
			item:SetPoint("RIGHT", ImprovedMerchantScrollChild)
			item:Hide()
			item:Disable()
			item:SetHeight(0)

			if item.id ~= nil then
				previousItem = item
				item:SetHeight(32)
				ImprovedMerchantScrollChild:SetHeight(ImprovedMerchantScrollChild:GetHeight() + (item:GetHeight()*item:GetScale()))
				item:Show()
				item:Enable()
			end
		end
		
	end
end 

function ImprovedMerchant:RefreshItems(list)
	for p = 1, 13 do
		MerchantNextPageButton:Click()
		for i = 1, 12 do
			if GetMerchantItemLink(i*p) then
				GetItemInfo(GetMerchantItemLink(i*p))
			end
		end
	end
	ImprovedMerchant:DepopulateMerchantList()
	ImprovedMerchant:PopulateMerchantList("buy")
	ImprovedMerchant.timeOut = 0
	ImprovedMerchant:SetScript("OnUpdate", function()
		ImprovedMerchant.timeOut = ImprovedMerchant.timeOut + 1
		if ImprovedMerchant.timeOut == 50 then
			ImprovedMerchant:DepopulateMerchantList()
			if MerchantFrame.selectedTab == 1 then
				ImprovedMerchant:PopulateMerchantList("buy", list)
			else
				ImprovedMerchant:PopulateMerchantList("buyback", list)
			end
			ImprovedMerchant:SetScript("OnUpdate", nil)
			ImprovedMerchant.timeOut = 0
		end
	end)
end

ImprovedMerchant:SetScript("OnEvent", function()
	if event == "MERCHANT_UPDATE" then
		if MerchantFrame.selectedTab == 2 then
			ImprovedMerchant:DepopulateMerchantList()
			ImprovedMerchant:PopulateMerchantList("buyback")
		
			for i = 1, 12 do
				_G["MerchantItem"..i]:Hide()
			end
		end
		if MerchantFrame.selectedTab == 1 then
			for i = 1, GetMerchantNumItems() do
				_G["itemInfo"..i]:update(i)
			end
		end
	end
	if event == "MERCHANT_SHOW" then
		if ATSWAutoBuyButtonFrame then
			--ATSWAutoButButtonTopText
			--ATSWAutoBuyButton
		end
		
		for i = 1, 12 do
			_G["MerchantItem"..i]:Hide()
		end

		ImprovedMerchant:SetVerticalScroll(0)
		ImprovedMerchant:RefreshItems()
		ImprovedMerchant:DepopulateMerchantList()
		ImprovedMerchant:PopulateMerchantList("buy")
		ImprovedMerchantSortListText:SetText(GetLocaleString("NOTHING"))
		ImprovedMerchant:SetWidth(299)
		ImprovedMerchant:SetHeight(295)
		MerchantPrevPageButton:Hide()
		MerchantNextPageButton:Hide()
		MerchantPageText:Hide()
		MerchantPrevPageButton.Show = function() end
		MerchantNextPageButton.Show = function() end
		MerchantPageText.Show = function() end
		
		if not filterToggled then
			ImprovedMerchantFilter:Show()
		end
		
		ImprovedMerchantToggleFilter:Show()
		
		UIDropDownMenu_Initialize(ImprovedMerchantSortList, function()
			local level = 1
			local info = UIDropDownMenu_CreateInfo()
			info.text = GetLocaleString("NOTHING")
			info.func = function()
				ImprovedMerchant:DepopulateMerchantList()
				if ImprovedMerchantSearchBox:GetText() then
					ImprovedMerchant:PopulateMerchantList("buy", {Search = ImprovedMerchantSearchBox:GetText()})
				else
					ImprovedMerchant:PopulateMerchantList("buy")
				end
				ImprovedMerchantSortListText:SetText(GetLocaleString("NOTHING"))
			end
			UIDropDownMenu_AddButton(info, level)
			local info = UIDropDownMenu_CreateInfo()
			info.text = GetLocaleString("USABLE")
			info.func = function()
				ImprovedMerchant:DepopulateMerchantList()
				ImprovedMerchant:PopulateMerchantList("buy", {Usable = "Usable"})
				ImprovedMerchantSortListText:SetText(GetLocaleString("USABLE"))
			end
			UIDropDownMenu_AddButton(info, level)
			
			for vals in pairs(ImprovedMerchant.sortTypeList) do
				local info = UIDropDownMenu_CreateInfo()
				info.text = vals
				info.func = function()
					ImprovedMerchant:DepopulateMerchantList()
					if ImprovedMerchantSearchBox:GetText() then
						ImprovedMerchant:PopulateMerchantList("buy", {[vals] = vals, Search = ImprovedMerchantSearchBox:GetText()})
					else
						ImprovedMerchant:PopulateMerchantList("buy", {[vals] = vals})
					end
					ImprovedMerchantSortListText:SetText(vals)
				end
				UIDropDownMenu_AddButton(info, level)
			end
		end)
		
	elseif event == "MERCHANT_CLOSED" then
		ImprovedMerchant:DepopulateMerchantList()
	end
end)

local orgTab1Func = MerchantFrameTab1:GetScript("OnClick")

MerchantFrameTab1:SetScript("OnClick", function()
	orgTab1Func()
	ImprovedMerchant:DepopulateMerchantList()
	local list = {}
	if ImprovedMerchantSortListText:GetText() ~= GetLocaleString("NOTHING") then
		if ImprovedMerchantSortListText:GetText() == GetLocaleString("USABLE") then
			list["Usable"] = "Usable"
		else
			list[ImprovedMerchantSortListText:GetText()] = ImprovedMerchantSortListText:GetText()
		end
	end
	if ImprovedMerchantSearchBox:GetText() then
		list["Search"] = ImprovedMerchantSearchBox:GetText()
	end
	ImprovedMerchant:PopulateMerchantList("buy", list)
	ImprovedMerchant:SetWidth(299)
	ImprovedMerchant:SetHeight(295)

	if ImprovedMerchantSearchBox:GetText() == "" then
		ImprovedMerchantSearchBoxInfo:Show()
	else
		ImprovedMerchantSearchBoxInfo:Hide()
	end
	
	if not filterToggled then
		ImprovedMerchantFilter:Show()
	end
	
	ImprovedMerchantToggleFilter:Show()
	
	for i = 1, 12 do
		_G["MerchantItem"..i]:Hide()
	end
end)

local orgTab2Func = MerchantFrameTab2:GetScript("OnClick")

MerchantFrameTab2:SetScript("OnClick", function()
	orgTab2Func()
	ImprovedMerchant:DepopulateMerchantList()
	ImprovedMerchant:PopulateMerchantList("buyback")
	ImprovedMerchant:SetWidth(299)
	ImprovedMerchant:SetHeight(350)
	ImprovedMerchantFilter:Hide()
	ImprovedMerchantToggleFilter:Hide()
	
	for i = 1, 12 do
		_G["MerchantItem"..i]:Hide()
	end
end)


ImprovedMerchant:RegisterEvent("MERCHANT_SHOW")
ImprovedMerchant:RegisterEvent("MERCHANT_CLOSED")
ImprovedMerchant:RegisterEvent("MERCHANT_UPDATE")

ImprovedMerchantToggleFilter:SetHeight(16)
ImprovedMerchantToggleFilter:SetWidth(16)
ImprovedMerchantToggleFilter:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 64, -50)

ImprovedMerchantToggleFilter:SetNormalTexture("Interface\\MoneyFrame\\Arrow-Left-Up")
ImprovedMerchantToggleFilter:SetPushedTexture("Interface\\MoneyFrame\\Arrow-Left-Down")

ImprovedMerchantToggleFilter:SetScript("OnClick", function()
	if ImprovedMerchantFilter:IsShown() then
		ImprovedMerchantFilter:Hide()
		this:SetNormalTexture("Interface\\MoneyFrame\\Arrow-Right-Up")
		this:SetPushedTexture("Interface\\MoneyFrame\\Arrow-Right-Down")
		filterToggled = true
	else
		ImprovedMerchantFilter:Show()
		this:SetNormalTexture("Interface\\MoneyFrame\\Arrow-Left-Up")
		this:SetPushedTexture("Interface\\MoneyFrame\\Arrow-Left-Down")
		filterToggled = nil
	end
end)

ImprovedMerchantFilter:SetPoint("LEFT", ImprovedMerchantToggleFilter, "RIGHT", 0, 0)
ImprovedMerchantFilter:SetPoint("RIGHT", MerchantFrame, "RIGHT", -44, 0)
ImprovedMerchantFilter:SetHeight(40)

ImprovedMerchantSortList:SetPoint("LEFT", ImprovedMerchantFilter, "LEFT", -6, 0)
ImprovedMerchantSortList:SetFrameLevel(1)

ImprovedMerchantToggleFilter:SetFrameLevel(3)

ImprovedMerchantSearchBox:SetPoint("LEFT", ImprovedMerchantSortListButton, "RIGHT", 8, 0)
ImprovedMerchantSearchBox:SetPoint("RIGHT")
ImprovedMerchantSearchBox:SetFontObject("ChatFontSmall")
ImprovedMerchantSearchBox:SetAutoFocus(false)
ImprovedMerchantSearchBox:SetHeight(20)

ImprovedMerchantSearchBox:SetScript("OnEditFocusGained", function()
	ImprovedMerchantSearchBoxInfo:Hide()
end)
ImprovedMerchantSearchBox:SetScript("OnEnterPressed", function()
	if ImprovedMerchantSortListText:GetText() ~= GetLocaleString("NOTHING") then
		list = {Search = ImprovedMerchantSearchBox:GetText(), [ImprovedMerchantSortListText:GetText()] = true}
	else
		list = {Search = ImprovedMerchantSearchBox:GetText()}
	end
	ImprovedMerchant:DepopulateMerchantList()
	ImprovedMerchant:PopulateMerchantList("buy", list)
	ImprovedMerchantSearchBox:ClearFocus()
end)

ImprovedMerchantSearchBox:SetScript("OnEscapePressed", function()
	ImprovedMerchant:DepopulateMerchantList()
	ImprovedMerchant:PopulateMerchantList("buy")
	ImprovedMerchantSearchBox:SetText("")
	ImprovedMerchantSearchBox:ClearFocus()
	ImprovedMerchantSearchBoxInfo:Show()
end)

ImprovedMerchantSearchBox:SetScript("OnChar", function()
	ImprovedMerchantSearchBoxInfo:Hide()
end)

ImprovedMerchantSearchBoxInfo = ImprovedMerchantSearchBox:CreateFontString()
ImprovedMerchantSearchBoxInfo:SetFontObject("ChatFontSmall")
ImprovedMerchantSearchBoxInfo:SetPoint("LEFT", ImprovedMerchantSearchBox, "LEFT")
ImprovedMerchantSearchBoxInfo:SetText(GetLocaleString("SEARCH"))