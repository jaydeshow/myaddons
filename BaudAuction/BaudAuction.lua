--[[Ideas:
  Auctioning multiple items at once
]]

local HideBliz = {
  BrowseQualitySort,
  BrowseLevelSort,
  BrowseDurationSort,
  BrowseHighBidderSort,
  BrowseCurrentBidSort,
};

local AuctionTime = {"< 30m", "30m-2h", "2h-12h", "> 12h"};

local SortColumn = 6;
local SortReverse;
local BrowseDisplay = {};
local SelectedItem;
local SearchParam;
local SearchDelay = 0;
local CurrentPage;
local ScanPage;
local UpdateResults = nil;
local ScrollBox, ScrollBar, Highlight;

local SearchResults = {};

local SearchItem;
local Text;
local Columns = {
  {Name = NAME, Width = 160, Align = "LEFT", Display = function()
    Text = select(4,GetItemQualityColor(SearchItem[4]))..(SearchItem[1]or "Unknown");
    if(SearchItem[3] > 1)then
      Text = SearchItem[3].." "..Text;
    end
    return Text;
  end, Sort = 1},
  {Name = LEVEL_ABBR, Width = 50, Align = "CENTER", Display = function()
    return SearchItem[6];
  end, Sort = 6},
  {Name = CLOSES_IN, Width = 80, Align = "CENTER", Display = function()
    return AuctionTime[SearchItem[13]];
  end, Sort = 13},
  {Name = AUCTION_CREATOR, Width = 80, Align = "CENTER", Display = function()
    return SearchItem[12];
  end, Sort = 12},
  {Name = BID.."/Unit", Width = 70, Align = "RIGHT", Display = function()
    Text = BaudAuctionToMoney(SearchItem[16]);
    if SearchItem[11]then
      Text = "|cffDD75ff*|r"..Text;  --Your bid
    elseif(SearchItem[10]~=0)then
      Text = "|cff00f0f0*|r"..Text;  --Other bid
    end
    return Text;
  end, Sort = 16},
  {Name = "BO/Unit", Width = 70, Align = "RIGHT", Display = function()
    return (SearchItem[9]==0)and "None" or BaudAuctionToMoney(SearchItem[17]);
  end, Sort = 17},
  {Name = BUYOUT, Width = 70, Align = "RIGHT", Display = function()
    return (SearchItem[9]==0)and "None" or BaudAuctionToMoney(SearchItem[9]);
  end, Sort = 9},
};

--name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner  = GetAuctionItemInfo("type",

function BaudAuctionToMoney(Money)
  Money = floor(Money);
  local Text = "";
  if(Money % 100 > 0)and(Money < 10000)or(Money==0)then
    --203,163,133
    Text = "|cffba795a"..(Money % 100).."c|r";
  end
  Money = floor(Money / 100);
  if(Money % 100 > 0)and(Money < 100000)then
    --C0C0C0
    Text = (Money % 100).."s"..Text;
  end
  Money = floor(Money / 100);
  if(Money > 0)then
    --227,216,128
    Text = "|cfff0f020"..Money.."g|r"..Text;
  end
  return Text;
end


function BaudAuction_OnLoad(self)
  BaudAuctionBuyoutCheckText:SetText("Match "..STARTING_PRICE);

  AuctionFrame:SetMovable(true);
  AuctionFrame:RegisterForDrag("LeftButton");
  AuctionFrame:SetScript("OnDragStart", BaudAuction_OnDragStart);
  AuctionFrame:SetScript("OnDragStop", BaudAuction_OnDragStop);

  BaudAuctionVariablesLoaded();

  self:RegisterEvent("ADDON_LOADED");
  self:RegisterEvent("VARIABLES_LOADED");
  self:RegisterEvent("AUCTION_HOUSE_CLOSED");
  self:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");

  AuctionsPriceText:SetPoint("TOPLEFT", AuctionsItemText, 0, -55); -- -70
  AuctionsDurationText:SetPoint("TOPLEFT", AuctionsPriceText, 0, -70); -- -50

  AuctionsBuyoutText:SetPoint("TOPLEFT", AuctionsDurationText, 0, -80); -- -94 (-144)
  AuctionsDepositText:SetPoint("TOPLEFT", AuctionsBuyoutText, 0, -76); -- -67

  BaudAuctionUnitPrice.previousFocus = BuyoutPrice.previousFocus;
  BaudAuctionUnitPrice.nextFocus = StartPrice.nextFocus;
  StartPrice.nextFocus = BaudAuctionUnitPriceGold;
  BuyoutPrice.previousFocus = BaudAuctionUnitPriceCopper;


  AuctionFrameBrowse:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
  NUM_BROWSE_TO_DISPLAY = 0;
  AuctionsRadioButton_OnClick(3);

  for Key, Value in ipairs(HideBliz)do
    Value:Hide();
  end
  for Index = 1, 8 do
    getglobal("BrowseButton"..Index):Hide();
  end

  ScrollBox = BaudAuctionBrowseScrollBox;
  ScrollBar = getglobal(ScrollBox:GetName().."ScrollBar");
  Highlight = getglobal(ScrollBox:GetName().."Highlight");

  local Left = 26;
  local Button, Text, Texture;
  for Key, Value in ipairs(Columns)do
    Button = CreateFrame("Button",self:GetName().."Col"..Key, self, "AuctionSortButtonTemplate");
    Button:SetID(Key);
    Button:SetNormalTexture(nil);
    Value.Header = Button;
    Button:SetWidth(Value.Width);
    Button:SetHeight(19);
    Button:SetScript("OnClick", BaudAuctionColumn_OnClick);
    Button:SetPoint("BOTTOMLEFT", ScrollBox, "TOPLEFT", Left, 0);
    Text = getglobal(Button:GetName().."Text");--Button:CreateFontString(Button:GetName().."Text", "ARTWORK", "GameFontNormal");
    Text:SetText(Value.Name);
    Left = Left + Value.Width;
  end

  local Entry;
  ScrollBox.Entries = 19;

  local function ChildClickFunc(self)
    BaudAuctionBrowseEntry_OnClick(self:GetParent());
  end
  for Index = 1, ScrollBox.Entries do
    Entry = CreateFrame("Button", ScrollBox:GetName().."Entry"..Index, ScrollBox);
    Entry:SetHeight(16);
    Entry:SetPoint("LEFT", 6, 0);
    Entry:SetPoint("RIGHT", -6, 0);
    Entry:SetPoint("TOP", 0, -3 - (Index - 1) * 16);
    Entry:Hide();
    Entry:SetID(0); --Hack for using Blizzard's on enter function
    Button = CreateFrame("Button", Entry:GetName().."Icon", Entry);
    Button:SetPoint("LEFT");
    Button:SetHeight(16);
    Button:SetWidth(16);
    Button:CreateTexture(Entry:GetName().."Texture", "ARTWORK"):SetAllPoints();
    Button:EnableMouse(true);
    Button:SetScript("OnEnter", BaudAuctionBrowseEntry_OnEnter);
    Button:SetScript("OnLeave", BaudAuctionBrowseEntry_OnLeave);
    Button:SetScript("OnClick", ChildClickFunc);
    --Button:SetScript("OnUpdate", BaudAuctionBrowseEntry_OnUpdate);
    for Key, Value in ipairs(Columns)do
      Text = Entry:CreateFontString(Entry:GetName().."Text"..Key, "ARTWORK", "GameFontHighlight");
      Text:SetPoint("TOP");
      Text:SetPoint("BOTTOM");
      Text:SetPoint("LEFT", Value.Header);
      Text:SetPoint("RIGHT", Value.Header);
      Text:SetJustifyH(Value.Align);
    end
--    Entry:RegisterForClicks("RightButtonUp");
    Entry:SetScript("OnClick", BaudAuctionBrowseEntry_OnClick);
  end

--  DEFAULT_CHAT_FRAME:AddMessage("Baud Auction: AddOn loaded.");
end


function BaudAuctionUpdateBuyoutPrice(NoUnit)
  local Money = MoneyInputFrame_GetCopper(StartPrice);

  if not NoUnit then
    MoneyInputFrame_SetCopper(BaudAuctionUnitPrice, floor(Money / (select(3,GetAuctionSellItemInfo())or 1)));
    BaudAuctionUnitPrice.expectChanges = BaudAuctionUnitPrice.expectChanges + 1;
  end

  if not BaudAuctionBuyoutCheck:GetChecked()then
    return;
  end
  MoneyInputFrame_SetCopper(BuyoutPrice, MoneyInputFrame_GetCopper(StartPrice));
end
hooksecurefunc(StartPrice, "onvalueChangedFunc", BaudAuctionUpdateBuyoutPrice);


function BaudAuctionUpdateStartPrice()
  MoneyInputFrame_SetCopper(StartPrice, MoneyInputFrame_GetCopper(BaudAuctionUnitPrice) * (select(3,GetAuctionSellItemInfo())or 1));
  StartPrice.expectChanges = StartPrice.expectChanges + 1;
  BaudAuctionUpdateBuyoutPrice(true);
end


function BaudAuctionUpdateProgress(Progress)
  BaudAuctionProgressBar:SetValue(Progress);
  BaudAuctionProgressBarText:SetText(floor(Progress * 100 + 0.5).."%");
  if(Progress >= 1)then
    BaudAuctionProgressBarText2:SetText("Search Complete");
    BaudAuctionProgressBarDots:Hide();
    BaudAuctionProgress.Finish = GetTime();
  else
    BaudAuctionProgressBarText2:SetText("Searching");
    BaudAuctionProgressBarDots:Show();
  end
  BaudAuctionProgress:Show();
end


function BaudAuctionProgress_OnUpdate(self)
  if not BaudAuctionProgress.Finish then
    BaudAuctionProgressBarDots:SetText(strrep(".", floor(GetTime()) % 4));
    return;
  end
  local Elapsed = GetTime() - BaudAuctionProgress.Finish - 1;
  if(Elapsed < 0)then
    return;
  end
  if(Elapsed > 1)then
    self:Hide();
  end
  self:SetAlpha(1 - Elapsed);
end


function BaudAuctionUpdateBidButtons()
  local Index = GetSelectedAuctionItem("list");
  if(Index==0)then
    BrowseBidButton:Disable();
    BrowseBuyoutButton:Disable();
  else
    AuctionFrame.buyoutPrice = select(9, GetAuctionItemInfo("list",Index));
    BrowseBidButton:Enable();
    if(AuctionFrame.buyoutPrice > 0)then
      BrowseBuyoutButton:Enable();
    else
      BrowseBuyoutButton:Disable();
    end
  end
end


function BaudAuction_OnEvent()
  if(event=="VARIABLES_LOADED")or(event=="ADDON_LOADED")and(arg1=="BaudAuction")then
    BaudAuctionVariablesLoaded();

  elseif(event=="AUCTION_HOUSE_CLOSED")then
    BaudAuctionProgress:Hide();
    SearchResults = {};
    SearchParam = nil;
    ScanPage = nil;
    SelectedItem = nil;
    BaudAuctionSortBrowseList();
--[[    AuctionFrame:ClearAllPoints();
    AuctionFrame:SetPoint("TOPLEFT",0,-104);]]

  elseif(event=="AUCTION_ITEM_LIST_UPDATE")then
    UpdateResults = true;
  end
end


function BaudAuctionBuyoutCheck_OnClick(self)
  PlaySound("igMainMenuOptionCheckBoxOn");
  BaudAuctionMatchBid = self:GetChecked()and true or false;
end


function BaudAuctionVariablesLoaded()
  if(BaudAuctionMatchBid==nil)then
    BaudAuctionMatchBid = true;
  end
  BaudAuctionBuyoutCheck:SetChecked(BaudAuctionMatchBid);
end


function BaudAuctionIsMatch(Item1, Item2)
  return Item1 and Item2 and(Item1[1]==Item2[1])and(Item1[3]==Item2[3])and(Item1[7]==Item2[7])and(Item1[9]==Item2[9])and(Item1[12]==Item2[12]);
end


function BaudAuctionListUpdate()
  UpdateResults = nil;
  if not SearchParam then
    return;
  end

  local Batch, Total = GetNumAuctionItems("list");
  if(Total==0)then
    BrowseNoResultsText:SetText(BROWSE_NO_RESULTS);
    BrowseNoResultsText:Show();
  end

  CurrentPage = SearchParam[7];

  if(ScanPage==CurrentPage)then
    local Progress = (Total == 0)and 1 or ((ScanPage + 1) / ceil(Total / NUM_AUCTION_ITEMS_PER_PAGE));
    BaudAuctionUpdateProgress(Progress);
    if(Progress >= 1)then
      ScanPage = nil;
    else
      ScanPage = ScanPage + 1;
    end
  end
--  ChatFrame1:AddMessage(Batch.." results, "..Total.." Total, page "..CurrentPage);
  local Offset = NUM_AUCTION_ITEMS_PER_PAGE * CurrentPage;
--[[  local OldData;
  if(Offset + NUM_AUCTION_ITEMS_PER_PAGE < Total)then
    OldData = {};
    for Index = 1, NUM_AUCTION_ITEMS_PER_PAGE do
      OldData[Index] = SearchResults[Offset + Index];
    end
  end]]

  local SelectedData;
  if SelectedItem and(SelectedItem > Offset)and(SelectedItem <= Offset + NUM_AUCTION_ITEMS_PER_PAGE)then
    SelectedData = SearchResults[SelectedItem];
  end

  local Item;
  for Index = 1, Batch do
    Item = {GetAuctionItemInfo("list",Index)};
    Item[13] = GetAuctionItemTimeLeft("list",Index);
    Item[14] = GetAuctionItemLink("list", Index);
    Item[15] = (Item[10]~=0)and(Item[10] + Item[8])or Item[7]; --Minimum bid amount, including beating an existing bid
    if(Item[9]~=0)and(Item[15] > Item[9])then
      Item[15] = Item[9]; --Bid price cannot exceed buyout price
    end
    Item[16] = Item[15] / Item[3];
    Item[17] = Item[9] / Item[3];  --Per unit price for sorting
--[[    if OldData then
      for Key, Value in ipairs(OldData)do
        if BaudAuctionIsMatch(Value, Item)then
          tremove(OldData, Key);
          break;
        end
      end
    end]]
    SearchResults[Index + Offset] = Item;
  end
  for Index = Total + 1, #SearchResults do
    SearchResults[Index] = nil;
  end

  if SelectedData then
    if BaudAuctionIsMatch(SearchResults[SelectedItem], SelectedData)then
      BaudAuctionSelectItem();
    end
    SelectedItem = nil;
  end

  BaudAuctionUpdateBidButtons();
  BaudAuctionSortBrowseList();
end


function BaudAuction_OnUpdate()
  if UpdateResults then
    BaudAuctionListUpdate();
  end
  if(ScanPage or SelectedItem)and CanSendAuctionQuery()and(SearchDelay <= GetTime())then
    local Selected = GetSelectedAuctionItem("list");
    if(Selected~=0)then
      SelectedItem = NUM_AUCTION_ITEMS_PER_PAGE * CurrentPage + Selected;
    end
    SearchParam[7] = ScanPage or ceil(SelectedItem / NUM_AUCTION_ITEMS_PER_PAGE - 1);
    QueryAuctionItems(unpack(SearchParam));
    SearchDelay = GetTime() + 1;
  end
end


function BaudAuctionSearchCancelButton_OnClick()
  if BaudAuctionProgress.Finish then
    return;
  end
  BaudAuctionProgress.Finish = GetTime();
  ScanPage = nil;
  BaudAuctionProgressBarText2:SetText("Search Canceled");
  BaudAuctionProgressBarDots:Hide();
  CloseAuctionStaticPopups();
end


function BaudAuction_OnShow()
  BaudAuctionSortBrowseList();
end


function BaudAuction_OnHide()
end


function BaudAuction_OnDragStart(self)
  self:StartMoving();
end


function BaudAuction_OnDragStop(self)
  self:StopMovingOrSizing();
  self:SetUserPlaced(false);
end


function BaudAuctionColumn_OnClick(self)
  PlaySound("igMainMenuOptionCheckBoxOn");
  if(self:GetID()==SortColumn)then
    SortReverse = not SortReverse;
  else
    SortColumn = self:GetID();
    SortReverse = nil;
  end
  BaudAuctionSortBrowseList();
end


function BaudAuctionSelectItem()
  if(CurrentPage == ceil(SelectedItem / NUM_AUCTION_ITEMS_PER_PAGE) - 1)then
    SetSelectedAuctionItem("list", (SelectedItem - 1) % NUM_AUCTION_ITEMS_PER_PAGE + 1);
    SelectedItem = nil;
  else
    SetSelectedAuctionItem("list", 0);
  end
end


function BaudAuctionBrowseEntry_OnClick(self)
  if IsControlKeyDown()then
    DressUpItemLink(SearchResults[self.Index][14]);
  elseif ( IsShiftKeyDown() ) then
    ChatEdit_InsertLink(SearchResults[self.Index][14]);
  else
    SelectedItem = self.Index;
    if(AUCTION_DISPLAY_ON_CHARACTER == "1")then
      DressUpItemLink(SearchResults[SelectedItem][14]);
    end
    MoneyInputFrame_SetCopper(BrowseBidPrice, SearchResults[SelectedItem][15]);
    BaudAuctionSelectItem();
    BaudAuctionUpdateBidButtons();
    BaudAuctionBrowseScrollBar_Update();
  end
end


local HackFrame = CreateFrame("Frame", "BrowseButton0");
local RefreshFunc = function(self)
  if GameTooltip:IsOwned(self)then
    BaudAuctionBrowseEntry_OnEnter(self);
  else
    self:SetScript("OnUpdate", nil);
  end
end
function BaudAuctionBrowseEntry_OnEnter(self)
  local Index = self:GetParent().Index;
  local Item = SearchResults[Index];
  if(CurrentPage==floor((Index - 1) / NUM_AUCTION_ITEMS_PER_PAGE))then
  	--GameTooltip:SetAuctionItem("list", (Index - 1) % NUM_AUCTION_ITEMS_PER_PAGE + 1);
  	--The way this is designed is to work using the original Blizzard function so that other addons can hook on
    HackFrame.itemCount = Item[3];
    HackFrame.bidAmount = (Item[10]~=0)and Item[10]or Item[7];
    HackFrame.buyoutPrice = Item[9];
  	AuctionFrameItem_OnEnter("list", (Index - 1) % NUM_AUCTION_ITEMS_PER_PAGE + 1);
    self.UpdateTooltip = nil;
  	self:SetScript("OnUpdate", RefreshFunc);
  	return;
  end
  self.UpdateTooltip = BaudAuctionBrowseEntry_OnEnter;
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
  GameTooltip:SetHyperlink(string.match(Item[14], "(item[:%-%d]+)"));
  if(Item[3] > 1)then
    if Item[11]then
      GameTooltip:AddLine("|n");
      SetTooltipMoney(GameTooltip, ceil(Item[10] / Item[3]), "STATIC", "<"..AUCTION_TOOLTIP_BID_PREFIX, ">");
    end
    if(Item[9] > 0)then
      SetTooltipMoney(GameTooltip, ceil(Item[9] / Item[3]), "STATIC", "<"..AUCTION_TOOLTIP_BUYOUT_PREFIX, ">");
    end
    GameTooltip:Show();
  end
	GameTooltip_ShowCompareItem();
	if IsModifiedClick("DRESSUP")then
		ShowInspectCursor();
	else
		ResetCursor();
	end
end


function BaudAuctionBrowseEntry_OnLeave()
  GameTooltip:Hide();
  ResetCursor();
end


hooksecurefunc("QueryAuctionItems", function(...)
--  ChatFrame1:AddMessage("Item search page "..select(7, ...));
  SearchDelay = GetTime() + 1;
  if(this ~= BaudAuctionUpdateFrame)then
    SearchResults = {};
    SelectedItem = nil;
    BaudAuctionSortBrowseList();
    if(select(7, ...)==0)then
      ScanPage = 0;
      SearchParam = {...};
      BaudAuctionUpdateProgress(0);
      BaudAuctionProgress.Finish = nil;
      BaudAuctionProgress:SetAlpha(1);
      BaudAuctionProgress:Show();
    end
  end
end);


hooksecurefunc("AuctionFrameBrowse_Search", function()
  AuctionFrameBrowse.isSearching = nil;
  BrowseNoResultsText:Hide();
  BrowseSearchDotsText:Hide();
end);


function BaudAuctionSortBrowseList()
  BaudAuctionArrow:ClearAllPoints();
  BaudAuctionArrow:SetPoint("LEFT", getglobal(Columns[SortColumn].Header:GetName().."Text"), "RIGHT", 3, -2);
  if SortReverse then
    BaudAuctionArrow:SetTexCoord(0, 0.5625, 1.0, 0);
  else
    BaudAuctionArrow:SetTexCoord(0, 0.5625, 0, 1.0);
  end

  for Index = #SearchResults + 1, #BrowseDisplay do
    BrowseDisplay[Index] = nil;
  end
  for Index = 1, #SearchResults do
    BrowseDisplay[Index] = Index;
  end

  local Sort = Columns[SortColumn].Sort;
  table.sort(BrowseDisplay, function(a, b)
    if(SearchResults[a][Sort]==SearchResults[b][Sort])then
      return(a < b);
    elseif not SortReverse then
      return(SearchResults[a][Sort] < SearchResults[b][Sort]);
    else
      return(SearchResults[a][Sort] > SearchResults[b][Sort]);
    end
  end);
  BaudAuctionBrowseScrollBar_Update();
end


function BaudAuctionBrowseScrollBar_Update()
  FauxScrollFrame_Update(ScrollBar, #SearchResults, ScrollBox.Entries, 16);
  local Entry, Index, Text;
  Highlight:Hide();
  local Selected = GetSelectedAuctionItem("list");
  if(Selected==0)then
    Selected = SelectedItem;
    Highlight:SetVertexColor(0, 0, 0.5);
  else
    Selected = CurrentPage * NUM_AUCTION_ITEMS_PER_PAGE + Selected;
    Highlight:SetVertexColor(0.5, 0.5, 0);
  end

  for Line = 1, ScrollBox.Entries do
    Entry = getglobal(ScrollBox:GetName().."Entry"..Line);
    Index = Line + FauxScrollFrame_GetOffset(ScrollBar);
    if(Index > #SearchResults)then
      Entry:Hide();
    else
      Index = BrowseDisplay[Index];
      Entry.Index = Index;
      SearchItem = SearchResults[Index];
      getglobal(Entry:GetName().."Texture"):SetTexture(SearchItem[2]);
      for Key, Value in ipairs(Columns)do
        getglobal(Entry:GetName().."Text"..Key):SetText(Value.Display());
      end
      if(Index==Selected)then
        Highlight:SetPoint("TOP", Entry);
        Highlight:Show();
      end
      Entry:Show();
    end
  end
end