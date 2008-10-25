-- Stackpack 1.3 by JuiCe
-- Stackpack 1.3 cN translate by dTzY@CWDG
-- Jason Green 修改与JPack集成。

BINDING_HEADER_STACKPACK_BINDING_HEADER = "Stackpack";
SPCycle = 0;
SPToggle = 0;

local Version = "1.3";
local Enabled = 0;
local Queued = -1;
local ForceScan = 0;
local Stacking = 0;
local BankOpen = 0;
local GuildBankOpen = 0;
local GuildBankDelay = 0;
local ReadyID = 0;
local State = 0;
local Queue = {};
local Ready = {};
local WFrame = getglobal("WorldFrame");

function CheckCTMail()
local Buffer = nil;
	if (CT_MailFrame == nil) then
		Buffer = nil;
	else
		if (CT_MailFrame:IsVisible() ~= 1) then
			Buffer = nil;
		else
			Buffer = 1;
		end
	end
return Buffer;
end

function FindStacks(n,c)
local itemCount = 0;
local itemStack = 0;
local itemID;
local itemName;
	if (GuildBankOpen == 1) then
		local Texture, Count, Locked = GetGuildBankItemInfo(n,c);
		if (Count > 0) then
			local ItemLink = GetGuildBankItemLink(n,c);
			if (ItemLink ~= nil) then
				return;
			end
			local Item, Link, Quality, ItemLevel, RequiredLevel, stackType, otherType, Stack, equipLoc, Texture = GetItemInfo(ItemLink);
			itemCount = Count;
			itemStack = Stack;
			itemID = ItemLink;
			itemName = Item;
		end
	else
		local Texture, Count, Locked, Quality, Readable = GetContainerItemInfo(n,c);
		if (Quality == -1) then
			local ID = GetItemID(GetContainerItemLink(n,c));
			local Item, Link, Quality, ItemLevel, RequiredLevel, stackType, otherType, Stack, Texture = GetItemInfo(ID);
			itemCount = Count;
			itemStack = Stack;
			itemID = ID;
			itemName = Item;
		end
	end
	if (itemStack ~= nil) then
		if (itemCount < itemStack) then
			Queued = Queued + 1;
			Queue[Queued] = { ["Item"]=itemName,["Bag"]=n,["Slot"]=c,["ID"]=itemID,["Stack"]=itemStack,["Count"]=itemCount,["Need"]=itemStack-itemCount }
		end
	end
end

function GetItemID(link)
local Buffer = "";
	_, _, Buffer = strfind(link,"item:(%d+):");
		if (Buffer ~= nil) then
			return Buffer;
		end
end

function InitScan()
local Bags = -1;
local DropBag = -1;
local DropSlot = -1;
local OpenBag = -1;
local OpenSlot = -1;
local StackID = -1;
local FirstBag = 0;
local BagPosition = {};
	Queue = {};
	Queued = -1;
		if (BankOpen == 1) then
			FirstBag = 5;
				for c=5,11 do
					if (GetContainerNumSlots(c) > 0) then 
						Bags = Bags + 1;
						BagPosition[Bags+5] = c;
					end
				end
			if (Bags > -1) then
				Bags = Bags + 5;
			end
		elseif (GuildBankOpen == 1) then
			local bankTab = GetCurrentGuildBankTab();
			tabName, tabIcon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = GetGuildBankTabInfo(bankTab);
			if (IsGuildLeader(UnitName("player")) == 1) then canDeposit = 1 end
			if (canDeposit ~= 1) then return end
			FirstBag = 1;
			Bags = 1;
			BagPosition[1] = bankTab;
		else
			FirstBag = 0;
			for c=0,4 do
				if (GetContainerNumSlots(c) > 0) then 
					Bags = Bags + 1;
					BagPosition[Bags] = c;
				end
			end
		end
	if (Bags > -1 or BankOpen == 1 or GuildBankOpen == 1) then
		for c=FirstBag,Bags do Scan(BagPosition[c]) end
			if (BankOpen == 1) then
				for c=1,28 do
					FindStacks(-1,c);
				end
			end
		if (Queued > 0) then
			for c=0,Queued do
				for n=0,Queued do
					if (n ~= c) then
						if (Queue[n].ID == Queue[c].ID and Queue[c].ID ~= -1 and Queue[n].ID ~= -1) then
							if (Queue[c].Need <= Queue[n].Need) then
								if (Queue[n].Count < Queue[c].Need) then
									StackID = StackID + 1;
									DropBag = Queue[c].Bag;
									DropSlot = Queue[c].Slot;
									OpenBag = Queue[n].Bag;
									OpenSlot = Queue[n].Slot;
									Ready[StackID] = { ["Mode"]="All", ["Count"]=Queue[n].Count, ["OpenBag"]=OpenBag, ["OpenSlot"]=OpenSlot, ["DropBag"]=DropBag, ["DropSlot"]=DropSlot }
									Queue[c].Count = Queue[c].Count + Queue[n].Count;
									Queue[c].Need = Queue[c].Stack - Queue[c].Count;
									Queue[n] = { ["Item"]="",["Bag"]=-1,["Slot"]=-1,["ID"]=-1,["Stack"]=0,["Count"]=0,["Need"]=0 }
								elseif (Queue[n].Count == Queue[c].Need) then
									StackID = StackID + 1;
									DropBag = Queue[c].Bag;
									DropSlot = Queue[c].Slot;
									OpenBag = Queue[n].Bag;
									OpenSlot = Queue[n].Slot;
									Ready[StackID] = { ["Mode"]="All", ["Count"]=Queue[n].Count, ["OpenBag"]=OpenBag, ["OpenSlot"]=OpenSlot, ["DropBag"]=DropBag, ["DropSlot"]=DropSlot }
									Queue[c] = { ["Item"]="",["Bag"]=-1,["Slot"]=-1,["ID"]=-1,["Stack"]=0,["Count"]=0,["Need"]=0 }
									Queue[n] = { ["Item"]="",["Bag"]=-1,["Slot"]=-1,["ID"]=-1,["Stack"]=0,["Count"]=0,["Need"]=0 }
								elseif (Queue[n].Count > Queue[c].Need) then
									StackID = StackID + 1;
									DropBag = Queue[c].Bag;
									DropSlot = Queue[c].Slot;
									OpenBag = Queue[n].Bag;
									OpenSlot = Queue[n].Slot;
									Ready[StackID] = { ["Mode"]="Split", ["Count"]=Queue[c].Need, ["OpenBag"]=OpenBag, ["OpenSlot"]=OpenSlot, ["DropBag"]=DropBag, ["DropSlot"]=DropSlot }
									Queue[n].Count = Queue[n].Count - Queue[c].Need;
									Queue[n].Need = Queue[n].Stack - Queue[n].Count;
									Queue[c] = { ["Item"]="",["Bag"]=-1,["Slot"]=-1,["ID"]=-1,["Stack"]=0,["Count"]=0,["Need"]=0 }
								end
							end
						end
					end
				end
			end
		end
	end
	if (StackID == -1) then
		ForceScan = 0;
		JPACK_STEP=JPACK_STACK_OVER;--Jason Green added. Jpack相关步骤，堆叠完毕
		debug("堆叠完毕,JPack_STEP="..JPACK_STEP)
	else
		Stacking = 1;
		ReadyID = 0;
		State = 0;
		WFrame:SetScript("OnUpdate", function() Stack() end);
	end
end

function Push(msg, r, g, b)
	if (r == nil or g == nil or b == nil) then
		r = 0.74;
		g = 0.74;
		b = 0.36;
	end
	DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b);
end

function QueryScan()
	if (CursorHasItem() == nil and CursorHasMoney() == nil and CursorHasSpell() == nil and Stacking == 0) then
		if (Enabled == 1) then
			InitScan();
		elseif (ForceScan == 1) then
			InitScan();
		end
	elseif (Stacking == 1 and State == 2) then
		State = 3;
	end
end

function Scan(n)
local Slots = 0;
	if (GuildBankOpen == 1) then
		Slots = 98;
	else
		Slots = GetContainerNumSlots(n);
	end
	for c=1,Slots do
		FindStacks(n,c);
	end
end

function Stack()
	if (State == 0) then
		if (GuildBankOpen == 1) then
			if (Ready[ReadyID].Mode == "All") then
				PickupGuildBankItem(Ready[ReadyID].OpenBag, Ready[ReadyID].OpenSlot);
			elseif (Ready[ReadyID].Mode == "Split") then
				SplitGuildBankItem(Ready[ReadyID].OpenBag, Ready[ReadyID].OpenSlot, Ready[ReadyID].Count);
			end
		else
			if (Ready[ReadyID].Mode == "All") then
				PickupContainerItem(Ready[ReadyID].OpenBag, Ready[ReadyID].OpenSlot);
			elseif (Ready[ReadyID].Mode == "Split") then
				SplitContainerItem(Ready[ReadyID].OpenBag, Ready[ReadyID].OpenSlot, Ready[ReadyID].Count);
			end
		end
		debug('state change 1')
		State = 1;
	elseif (State == 1) then
		if (CursorHasItem() or GuildBankOpen == 1) then
			if (GuildBankOpen == 1) then
				GuildBankDelay = GuildBankDelay + 1; -- CursorHasItem() / GetCursorInfo() bugged.
				if (GuildBankDelay > 15) then
					GuildBankDelay = 0;
					PickupGuildBankItem(Ready[ReadyID].DropBag, Ready[ReadyID].DropSlot);
					debug('state change 2')
					State = 2;
				end
			else
				PickupContainerItem(Ready[ReadyID].DropBag, Ready[ReadyID].DropSlot);
				debug('state change 2')
				State = 2;
			end
		end
	elseif (State == 3) then
		ReadyID = ReadyID + 1;
			if (Ready[ReadyID] == nil) then
				WFrame:SetScript("OnUpdate", nil);
				Ready = {};
				Stacking = 0;
				ReadyID = 0;
				JPACK_STEP=JPACK_STACK_OVER;--Jason Green added. Jpack相关步骤，堆叠完毕
				debug("堆叠完毕,JPack_STEP="..JPACK_STEP)
			end
		State = 0;
	end
end

function Stackpack_Command(cmd)
	cmd = strlower(cmd);
		if (cmd == "on") then
			Enabled = 1;
			Push("Stackpack已开启.")
		elseif (cmd == "off") then
			Enabled = 0;
			Push("Stackpack已关闭.")
		elseif (cmd == "scan" or cmd == "start" or cmd == "go" or cmd == "stack") then
			if (CursorHasItem() or CursorHasMoney() or CursorHasSpell()) then
				Push("Stackpack tells you, \"请先拿掉你鼠标上的物品.\"",2,0.28,2);
			--elseif (Stacking == 1) then
			--	Push("Stackpack tells you, \"系统繁忙, 请稍后重试.\"",2,0.28,2);				
			else
				ForceScan = 1;
				InitScan();
			end
		elseif (cmd == "toggle") then
			if (SPToggle == 0) then
				SPCycle = 0;
				SPToggle = 1;
				Push("Stackpack 将忽略下一次物品变化.");
			else
				SPCycle = 0;
				SPToggle = 0;
				Push("Stackpack 将恢复堆叠物品.");
			end
		elseif (cmd == "help" or cmd == "") then
			Push("Stackpack 帮助",1,1,0);
			Push("使用 /stackpack 或 /sp 加以下参数");
			Push("   <go/scan/stack/start> - 让 Stackpack 开始堆叠物品.");
			Push("   <on/off> - 开启(on)或关闭(off) Stackpack.");
			Push("   toggle - 暂时开启或关闭Stackpack.");
		end
end

function Stackpack_OnLoad()
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	this:RegisterEvent("TRADE_CLOSED");
	this:RegisterEvent("MAIL_CLOSED");
	this:RegisterEvent("AUCTION_HOUSE_CLOSED");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("GUILDBANKFRAME_OPENED");
	this:RegisterEvent("GUILDBANKFRAME_CLOSED");
	this:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED");
	--SLASH_STACK1 = "/stackpack";
	--SLASH_STACK2 = "/sp";
	--SlashCmdList["STACK"] = Stackpack_Command;
	--Push("|cff646436Stackpack |cffb69d23"..Version.."|cff646436 载入 - 汉化 坦然. 键入 |cffb69d23/sp help|cff646436 得到帮助.");
end

--Jason Green added. Dynamic create frame
StackFrame=CreateFrame("Frame",nil,UIParent);
StackFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
StackFrame:RegisterEvent("PLAYER_LOGIN")
StackFrame:RegisterEvent("UPDATE_FACTION")

function StackFrame:OnEvent()
	if (event == "BAG_UPDATE") then
		if (SPToggle == 0) then
			local CTMail = CheckCTMail();
				if (TradeFrame:IsVisible() ~= 1 and SendMailFrame:IsVisible() ~= 1 and CTMail ~= 1) then
					if (AuctionFrame ~= nil) then
						if (AuctionFrame:IsVisible() ~= 1) then
							QueryScan();
						end
					else
						QueryScan();
					end
				end
		else
			SPCycle = SPCycle + 1;
				if (SPCycle >= 4) then
					SPCycle = 0;
					SPToggle = 0;
					Push("Stackpack 将恢复堆叠.");
				end
		end
	elseif (event == "TRADE_CLOSED" or event == "MAIL_CLOSED" or event == "AUCTION_HOUSE_CLOSED") then
		if (CursorHasItem() == nil and CursorHasMoney() == nil and CursorHasSpell() == nil and Stacking == 0) then
			if (Enabled == 1) then
				InitScan();
			end
		end
	elseif (event == "PLAYERBANKSLOTS_CHANGED") then
		if (SPToggle == 0) then
			QueryScan();
		end
	elseif (event == "BANKFRAME_OPENED") then
		if (SPToggle == 0) then
			BankOpen = 1;
			QueryScan();
		end
	elseif (event == "BANKFRAME_CLOSED") then
		BankOpen = 0;
	elseif (event == "GUILDBANKFRAME_OPENED") then
		if (SPToggle == 0) then
			GuildBankOpen = 1;
			QueryScan();
		end
	elseif (event == "GUILDBANKFRAME_CLOSED") then
		GuildBankOpen = 0;
	elseif (event == "GUILDBANKBAGSLOTS_CHANGED") then
		if (SPToggle == 0) then
			QueryScan();
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		self:Init()
	end
end
StackFrame:SetScript("OnEvent",StackFrame.OnEvent);
function StackFrame:Init()
	StackFrame:RegisterEvent("BAG_UPDATE");
	StackFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	StackFrame:RegisterEvent("TRADE_CLOSED");
	StackFrame:RegisterEvent("MAIL_CLOSED");
	StackFrame:RegisterEvent("AUCTION_HOUSE_CLOSED");
	StackFrame:RegisterEvent("BANKFRAME_OPENED");
	StackFrame:RegisterEvent("BANKFRAME_CLOSED");
	StackFrame:RegisterEvent("GUILDBANKFRAME_OPENED");
	StackFrame:RegisterEvent("GUILDBANKFRAME_CLOSED");
	StackFrame:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED");
end
