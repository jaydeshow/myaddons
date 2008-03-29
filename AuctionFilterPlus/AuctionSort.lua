local AuctionFrameItem_OnEnter_ORIGIN
local GetAuctionItemLink_ORIGIN
local GetAuctionItemInfo_ORIGIN
local GetAuctionItemTimeLeft_ORIGIN
local AuctionFrameBrowse_Update_ORIGIN
local PlaceAuctionBid_ORIGIN
AUCTION_SORT_MAPPING = nil;
--GetSelectedAuctionItem
--BrowseButton_OnClick
--StaticPopupDialogs["BUYOUT_AUCTION"].OnAccept
CURRENT_NAME_ORDER = {};
PPU=nil; --PricePerUnit

function AuctionFilterPlus_OnLoad()
	this:RegisterEvent("AUCTION_HOUSE_SHOW");

	local BrowseBuyoutSort = CreateFrame("Button", "BrowseBuyoutSort", AuctionFrameBrowse, "AuctionSortButtonTemplate")
	BrowseBuyoutSort:SetWidth(70)
	BrowseBuyoutSort:SetHeight(19)
	BrowseBuyoutSort:SetText("单价")
	BrowseBuyoutSort:SetScript("OnClick", function()
		if(PPU==nil) then
			AUCTION_SORT_MAPPING = nil;

			if(AuctionFrameBrowse_Update~=AuctionSort_AuctionFrameBrowse_Update) then
				AuctionFrameBrowse_Update_ORIGIN = AuctionFrameBrowse_Update;
			end
			AuctionFrameBrowse_Update = AuctionSort_AuctionFrameBrowse_Update;
			BrowseBuyoutSortArrow:SetTexCoord(0, 0.5625, 1.0, 0)
			BrowseBuyoutSortArrow:Show();

			AuctionFrameBrowse_Update();
			PPU=1;
		else
			AUCTION_SORT_MAPPING = nil;
			AuctionFrameBrowse_Update = AuctionFrameBrowse_Update_ORIGIN;
			BrowseBuyoutSortArrow:SetTexCoord(0, 0, 0, 0)

			AuctionFrameBrowse_Update();
			PPU=nil;
		end
	end)

	local BrowseNameSort = CreateFrame("Button", "BrowseNameSort", AuctionFrameBrowse, "AuctionSortButtonTemplate")
	BrowseNameSort:SetWidth(95)
	BrowseNameSort:SetHeight(19)
	BrowseNameSort:SetText(NAME)
	BrowseNameSort:SetScript("OnClick", function()
		AuctionSort_SetSort("name");
		AuctionFrameBrowse_Search();
		--SortAuctionItems("list", "name");
	end)

	AuctionSort_HookAuctionUI()
	BrowseCurrentBidSort.SetWidth_ORIGIN = BrowseCurrentBidSort.SetWidth;
	BrowseCurrentBidSort.SetWidth = AuctionSort_NewSetWidth;
	--self:SecureHook(BrowseCurrentBidSort, "SetWidth", "NewSetWidth")
	-- We need this to prevent some weird shrinkage later on.
	BQSWidth = BrowseQualitySort:GetWidth()

	hooksecurefunc("AuctionFrameBrowse_UpdateArrows", function()
		AuctionSort_UpdateArrow(BrowseNameSort, "name");
	end);

	hooksecurefunc("AuctionFrame_OnClickSortColumn", function()
		CURRENT_NAME_ORDER = {};
		AUCTION_SORT_MAPPING = nil;
	end);

	hooksecurefunc("SortAuctionItems", function()
		AUCTION_SORT_MAPPING = nil;
	end);
end

function AuctionSort_OnEvent()
	if (event == "AUCTION_HOUSE_SHOW") then
		BrowseBuyoutSort:ClearAllPoints()
		BrowseBuyoutSort:SetPoint("LEFT", "BrowseCurrentBidSort", "RIGHT", -2, 0)
		BrowseBuyoutSort:Show()
		BrowseBuyoutSortArrow:Hide();

		BrowseNameSort:ClearAllPoints()
		BrowseNameSort:SetPoint("TOPLEFT", "AuctionFrameBrowse", "TOPLEFT", 186, -82)
		BrowseNameSort:Show()

		BrowseQualitySort:ClearAllPoints()
		BrowseQualitySort:SetPoint("LEFT", "BrowseNameSort", "RIGHT", -2, 0)
		BrowseQualitySort:SetWidth(BQSWidth)
		BrowseQualitySort:SetWidth(BrowseQualitySort:GetWidth() - BrowseNameSort:GetWidth())
		BrowseQualitySort:Show()

		AuctionSort_NewSetWidth(nil, 207)

		AuctionSort_SetSort("name");
		this:UnregisterEvent("AUCTION_HOUSE_SHOW");
	end
end

function AuctionSort_NewSetWidth(obj, width)
	if width >= 180 then
		width = width - BrowseBuyoutSort:GetWidth() + 2
	end
	-- Set the new width
	BrowseCurrentBidSort:SetWidth_ORIGIN(width)
end

function AuctionSort_UpdateArrow(button, type)
	if (CURRENT_NAME_ORDER[type]=="up") then
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 1.0, 0)
		getglobal(button:GetName().."Arrow"):Show();
	elseif (CURRENT_NAME_ORDER[type]=="down") then
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 0, 1.0)
		getglobal(button:GetName().."Arrow"):Show();
	else
		getglobal(button:GetName().."Arrow"):Hide();
	end
end

function AuctionSort_SetSort(type)
	if(CURRENT_NAME_ORDER[type]=="up") then
		CURRENT_NAME_ORDER[type]="down";
	else
		CURRENT_NAME_ORDER[type]="up";
	end

	SortAuctionClearSort("list");
	if(type=="name") then
		SortAuctionSetSort("list", "bid", false);
		SortAuctionSetSort("list", "name", CURRENT_NAME_ORDER[type]=="down");
		AuctionSort_UpdateArrow(BrowseNameSort, type)
	end
end

function AuctionSort_HookAuctionUI()
	AuctionFrameItem_OnEnter_ORIGIN = AuctionFrameItem_OnEnter;
	GetAuctionItemLink_ORIGIN = GetAuctionItemLink;
	GetAuctionItemInfo_ORIGIN = GetAuctionItemInfo;
	GetAuctionItemTimeLeft_ORIGIN = GetAuctionItemTimeLeft;
	PlaceAuctionBid_ORIGIN = PlaceAuctionBid;
	AuctionFrameBrowse_Update_ORIGIN = AuctionFrameBrowse_Update;

	AuctionFrameItem_OnEnter = function(type, index)
		if(type~="list" or AUCTION_SORT_MAPPING==nil or AUCTION_SORT_MAPPING[index]==nil) then
			return AuctionFrameItem_OnEnter_ORIGIN(type, index);
		else
			return AuctionFrameItem_OnEnter_ORIGIN(type, AUCTION_SORT_MAPPING[index]);
		end
	end;

	GetAuctionItemLink = function(type, index)
		if(type~="list" or AUCTION_SORT_MAPPING==nil or AUCTION_SORT_MAPPING[index]==nil) then
			return GetAuctionItemLink_ORIGIN(type, index);
		else
			return GetAuctionItemLink_ORIGIN(type, AUCTION_SORT_MAPPING[index]);
		end
	end;

	GetAuctionItemInfo = function(type, index)
		if(type~="list" or AUCTION_SORT_MAPPING==nil or AUCTION_SORT_MAPPING[index]==nil) then
			return GetAuctionItemInfo_ORIGIN(type, index);
		else
			return GetAuctionItemInfo_ORIGIN(type, AUCTION_SORT_MAPPING[index]);
		end
	end;

	GetAuctionItemTimeLeft = function(type, index)
		if(type~="list" or AUCTION_SORT_MAPPING==nil or AUCTION_SORT_MAPPING[index]==nil) then
			return GetAuctionItemTimeLeft_ORIGIN(type, index);
		else
			return GetAuctionItemTimeLeft_ORIGIN(type, AUCTION_SORT_MAPPING[index]);
		end
	end;

	PlaceAuctionBid = function(type, index, price)
		if(type~="list" or AUCTION_SORT_MAPPING==nil or AUCTION_SORT_MAPPING[index]==nil) then
			return PlaceAuctionBid_ORIGIN(type, index, price);
		else
			return PlaceAuctionBid_ORIGIN(type, AUCTION_SORT_MAPPING[index], price);
		end
	end;

end

function AuctionSort_AuctionFrameBrowse_Update()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	if(numBatchAuctions <=0) then
		AUCTION_SORT_MAPPING = nil;
	else
		tmp = {};
		local i,j;
		for i=1,numBatchAuctions do
			local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  GetAuctionItemInfo_ORIGIN("list", i);
			tmp[i] = {};
			tmp[i].index = i;
			tmp[i].name = name;
			tmp[i].price = (((bidAmount > 0) and bidAmount or minBid) + minIncrement) / count;
		end
		AUCTION_SORT_MAPPING = {};
		for i=1,numBatchAuctions-1 do
			local swap = i;
			for j=i+1,numBatchAuctions do
				if(CURRENT_NAME_ORDER and CURRENT_NAME_ORDER["name"]=="down") then
					if(tmp[swap].name<tmp[j].name or (tmp[swap].name==tmp[j].name and tmp[swap].price>tmp[j].price)) then
					--if(tmp[swap].price>tmp[j].price) then
						swap = j;
					end
				else
					if(tmp[swap].name>tmp[j].name or (tmp[swap].name==tmp[j].name and tmp[swap].price>tmp[j].price)) then
					--if(tmp[swap].price>tmp[j].price) then
						swap = j;
					end
				end
			end
			if(swap~=i)then local t = tmp[i]; tmp[i] = tmp[swap]; tmp[swap] = t; t = nil; end
			AUCTION_SORT_MAPPING[i] = tmp[i].index;
		end
		AUCTION_SORT_MAPPING[numBatchAuctions] = tmp[numBatchAuctions].index;
		tmp = nil;
	end
	AuctionFrameBrowse_Update_ORIGIN();
end