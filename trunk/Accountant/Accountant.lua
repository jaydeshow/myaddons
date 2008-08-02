--[[
 Accountant
    Originally by Sabaki (sabaki@gmail.com)
    Redone by urnati - 2.6
  
	Tracks your incoming / outgoing cash

	Thanks To:
	Jay for testing
	Atlas by Razark for the minimap icon code that was lifted
	Everyone who commented and voted for the mod on curse-gaming.com
]]

-- Create a short cut
local SC = Accountant

SC.data = nil;
--Accountant_Disabled = false;
SC.mode = "";
SC.refund_mode = "";
--Accountant_MailIndex = "";
SC.sender = "";
SC.current_money = 0;
SC.last_money = 0;
SC.verbose = false;
SC.got_name = false;
SC.current_tab = 1;
Accountant.player = "";
SC.could_repair = false;
SC.can_repair = "";
SC.repair_cost, SC.repair_money = 0,0;
local Accountant_RepairAllItems_old;
local Accountant_CursorHasItem_old;
local tmpstr = "";


--[[
 AccountantButton.lua

	Declare the minimap button routines for Accountant
]]

--
-- Toggle the Accountant window on click of the mini-map button
--
function SC.Button_OnClick()
	if AccountantFrame:IsVisible() then
		HideUIPanel(AccountantFrame);
	else
		ShowUIPanel(AccountantFrame);
	end
	
end

--
-- Create the name so the right Accountnat data can be looked up.
--
function SC.Button_makename()
	acc_realm = GetRealmName();
	acc_name = acc_realm.."-"..UnitName("player");
	return acc_name;
end

--
-- On start, show or hide the mini-map button based on the user's selection
-- for that character.
--
function SC.Button_Init()
	if(Accountant_SaveData[SC.Button_makename()]["options"].showbutton) then
		AccountantButtonFrame:Show();
	else
		AccountantButtonFrame:Hide();
	end
end

--
-- Honor the user's selection to show or hide the min-map button
-- for that character.
--
function SC.Button_Toggle()
	if(AccountantButtonFrame:IsVisible()) then
		AccountantButtonFrame:Hide();
		Accountant_SaveData[SC.Button_makename()]["options"].showbutton = false;
	else
		AccountantButtonFrame:Show();
		Accountant_SaveData[SC.Button_makename()]["options"].showbutton = true;
	end
end

--
-- Place the mini-map button where the user selects for that character.
--
function SC.Button_UpdatePosition()
	AccountantButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		50 - (75 * cos(Accountant_SaveData[SC.Button_makename()]["options"].buttonpos)),
		(75 * sin(Accountant_SaveData[SC.Button_makename()]["options"].buttonpos)) - 50
--[[
 55 - (75 * cos(Accountant_SaveData[SC.Button_makename()]["options"].buttonpos)),
(75 * sin(Accountant_SaveData[SC.Button_makename()]["options"].buttonpos)) - 55
--]]
	);
end


--[[
 AccountantButton.lua end
]]

--[[
 AccountantOptions.lua begin
]]

--
-- Show / hide the options window when the user clicks the Options button
--
function Accountant.Options_Toggle()
	if(AccountantOptionsFrame:IsVisible()) then
		AccountantOptionsFrame:Hide();
	else
		AccountantOptionsFrame:Show();
	end
end

--
-- Create the options window frame on load
--
function Accountant.Options_OnLoad()
	UIPanelWindows['AccountantOptionsFrame'] = {area = 'center', pushable = 0};
end


--
-- Draw the options window frame when requested
--
function Accountant.Options_OnShow()
	AccountantOptionsFrameToggleButtonText:SetText(ACCLOC_MINIBUT);
	AccountantSliderButtonPosText:SetText(ACCLOC_BUTPOS);
	AccountantOptionsFrameWeekLabel:SetText(ACCLOC_STARTWEEK);

	AccountantOptionsFrameToggleButton:SetChecked(Accountant_SaveData[Accountant.player]["options"].showbutton);

	AccountantSliderButtonPos:SetValue(Accountant_SaveData[Accountant.player]["options"].buttonpos);

	UIDropDownMenu_Initialize(AccountantOptionsFrameWeek, 
		function () SC.OptionsFrameWeek_Init () end);
	UIDropDownMenu_SetSelectedID(AccountantOptionsFrameWeek, Accountant_SaveData[Accountant.player]["options"].weekstart);
end

function Accountant.Options_OnHide()
	if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		ShowUIPanel(myAddOnsFrame);
	end
end

--
-- Create the week start options window frame on load
--
function Accountant.OptionsFrameWeek_Init()
	local info;
	Accountant_DayList = {ACCLOC_WD_SUN,ACCLOC_WD_MON,ACCLOC_WD_TUE,ACCLOC_WD_WED,ACCLOC_WD_THU,ACCLOC_WD_FRI,ACCLOC_WD_SAT};
	for i = 1, getn(Accountant_DayList), 1 do
		info = { };
		info.text = Accountant_DayList[i];
		info.func = function () SC.OptionsFrameWeek_OnClick () end;
		UIDropDownMenu_AddButton(info);
	end
end

--
-- Draw the week start options window frame when requested
--
function Accountant.OptionsFrameWeek_OnClick()
	UIDropDownMenu_SetSelectedID(AccountantOptionsFrameWeek, this:GetID());
	-- Set all chars to the same weekstart
	for player in next,Accountant_SaveData do
		Accountant_SaveData[player]["options"].weekstart = this:GetID();
	end
end

--[[
AccountantOptions.lua end
--]]


--[[
 Accountant.lua begin
]]

--
-- Register for all the events needed to track the flow of gold
--
function SC.RegisterEvents()
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_CLOSED");
	this:RegisterEvent("MERCHANT_UPDATE");

	this:RegisterEvent("QUEST_COMPLETE");
	this:RegisterEvent("QUEST_FINISHED");
	
	this:RegisterEvent("LOOT_OPENED");
	this:RegisterEvent("LOOT_CLOSED");
	
	this:RegisterEvent("TAXIMAP_OPENED");
	this:RegisterEvent("TAXIMAP_CLOSED");

	this:RegisterEvent("TRADE_SHOW");
	this:RegisterEvent("TRADE_CLOSE");
	
	this:RegisterEvent("MAIL_SHOW");
	this:RegisterEvent("MAIL_INBOX_UPDATE");
	this:RegisterEvent("MAIL_CLOSED");
--	this:RegisterEvent("MAIL_SEND_INFO_UPDATE");
--	this:RegisterEvent("MAIL_SEND_SUCCESS");

	this:RegisterEvent("TRAINER_SHOW");
	this:RegisterEvent("TRAINER_CLOSED");

	this:RegisterEvent("AUCTION_HOUSE_SHOW");
	this:RegisterEvent("AUCTION_HOUSE_CLOSED");

	this:RegisterEvent("PLAYER_MONEY");

	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this:RegisterEvent("UPDATE_INVENTORY_DURABILITY");
end

--
-- Create the various labels and headers for the Accountant frame
--
function SC.SetLabels()
	if SC.current_tab == 5 then
		AccountantFrameSource:SetText(ACCLOC_CHAR);
		AccountantFrameIn:SetText(ACCLOC_MONEY);
		AccountantFrameOut:SetText(ACCLOC_UPDATED);
		AccountantFrameTotalIn:SetText(ACCLOC_SUM..":");
		AccountantFrameTotalOut:SetText("");
		AccountantFrameTotalFlow:SetText("");
		AccountantFrameTotalInValue:SetText("");
		AccountantFrameTotalOutValue:SetText("");
		AccountantFrameTotalFlowValue:SetText("");
		for i = 1, 15, 1 do
			getglobal("AccountantFrameRow"..i.."Title"):SetText("");
			getglobal("AccountantFrameRow"..i.."In"):SetText("");
			getglobal("AccountantFrameRow"..i.."Out"):SetText("");
		end
		AccountantFrameResetButton:Hide();
		return;
	end
	AccountantFrameResetButton:Show();

	AccountantFrameSource:SetText(ACCLOC_SOURCE);
	AccountantFrameIn:SetText(ACCLOC_IN);
	AccountantFrameOut:SetText(ACCLOC_OUT);
	AccountantFrameTotalIn:SetText(ACCLOC_TOT_IN..":");
	AccountantFrameTotalOut:SetText(ACCLOC_TOT_OUT..":");
	AccountantFrameTotalFlow:SetText(ACCLOC_NET..":");

	-- Row Labels (auto generate)
	InPos = 1
	for key,value in next,SC.data do
		SC.data[key].InPos = InPos;
		getglobal("AccountantFrameRow"..InPos.."Title"):SetText(SC.data[key].Title);
		InPos = InPos + 1;
	end

	-- Set the header
	local name = this:GetName();
	local header = getglobal(name.."TitleText");
	if ( header ) then 
		header:SetText(ACCLOC_TITLE.." "..SC.Version);
	end
end

--
-- Do all the setup needed on load of Accountant
--
function SC.OnLoad()	
	Accountant_Realm = GetRealmName();
	Accountant_Char = UnitName("player");
	Accountant.player = Accountant_Realm.."-"..Accountant_Char;

 -- shamelessly print a load message to chat window
	DEFAULT_CHAT_FRAME:AddMessage(
		GREEN_FONT_COLOR_CODE.."Accountant "
		..SC.Version
		.." by "
		..FONT_COLOR_CODE_CLOSE
		.."|cFFFFFF00"..SC.AUTHOR..FONT_COLOR_CODE_CLOSE
		.." for "
		..SC.player
		);

	-- Setup
	SC.LoadData();
	SC.SetLabels();

	-- Current Cash
	SC.current_money = GetMoney();
	SC.last_money = SC.current_money;

	-- Register the slash Commands
	SlashCmdList["ACCOUNTANT"] = SC.Slash;
	SLASH_ACCOUNTANT1 = "/accountant";
	SLASH_ACCOUNTANT2 = "/acc";

	-- Add myAddOns support
	if myAddOnsList then
		myAddOnsList.Accountant = {name = "Accountant", description = "Tracks your revenues / expenditures", version = SC.Version, frame = "AccountantFrame", optionsframe = "AccountantFrame"};
	end

	-- Create the confirm box to use if needed
	StaticPopupDialogs["ACCOUNTANT_RESET"] = {
		text = TEXT("meh"),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			SC.ResetConfirmed();
		end,
		showAlert = 1,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		interruptCinematic = 1
	};

	-- Set the tabs at the bpttom of the Accountant window
	AccountantFrameTab1:SetText(ACCLOC_SESS);
	PanelTemplates_TabResize(10, AccountantFrameTab1);
	AccountantFrameTab2:SetText(ACCLOC_DAY);
	PanelTemplates_TabResize(10, AccountantFrameTab1);
	AccountantFrameTab3:SetText(ACCLOC_WEEK);
	PanelTemplates_TabResize(10, AccountantFrameTab2);
	AccountantFrameTab4:SetText(ACCLOC_TOTAL);
	PanelTemplates_TabResize(10, AccountantFrameTab4);
	AccountantFrameTab5:SetText(ACCLOC_CHARS);
	PanelTemplates_TabResize(10, AccountantFrameTab5);
	PanelTemplates_SetNumTabs(AccountantFrame, 5);
	PanelTemplates_SetTab(AccountantFrame, AccountantFrameTab1);
	PanelTemplates_UpdateTabs(AccountantFrame);
end

--
-- Load the account data of the character that is being played
--
function SC.LoadData()
	SC.data = {};
	SC.data["LOOT"] = {Title = ACCLOC_LOOT};
	SC.data["MERCH"] = {Title = ACCLOC_MERCH};
	SC.data["QUEST"] = {Title = ACCLOC_QUEST};
	SC.data["TRADE"] = {Title = ACCLOC_TRADE};
	SC.data["MAIL"] = {Title = ACCLOC_MAIL};
	SC.data["AH"] = {Title = ACCLOC_AUC};
	SC.data["TRAIN"] = {Title = ACCLOC_TRAIN};
	SC.data["TAXI"] = {Title = ACCLOC_TAXI};
	SC.data["REPAIRS"] = {Title = ACCLOC_REPAIR};
	SC.data["OTHER"] = {Title = ACCLOC_OTHER};

	for key,value in next,SC.data do
		for modekey,mode in next,SC.log_modes do
			SC.data[key][mode] = {In=0,Out=0};
		end
	end

	if(Accountant_SaveData == nil) then
		Accountant_SaveData = {};
	end

	if (Accountant_SaveData[Accountant.player] == nil ) then
		cdate = date();
		cdate = string.sub(cdate,0,8);
		cweek = "";
		Accountant_SaveData[Accountant.player] = {options={showbutton=true,buttonpos=0,version=SC.Version,date=cdate,weekdate=cweek,weekstart=3,totalcash=0},data={}};
		
		-- Quel's mod: make sure introdudction of a new character gets the same weekstart as
		-- existing chars, otherwise it will prematurely wipe out the weekly totals.
		for player in next,Accountant_SaveData do
			-- Quel's mod: only consider chars on the same server
			if (string.find(player, Accountant_Realm) ~= nil) then
				if (Accountant_SaveData[player]["options"]["weekstart"] ~= nil) then
					SC.Print2("Adding a new account for new character, "..Accountant.player..", weekstart = "..Accountant_SaveData[player]["options"]["weekstart"]);
					Accountant_SaveData[Accountant.player]["options"]["weekstart"] = Accountant_SaveData[player]["options"]["weekstart"];
				end
				if (Accountant_SaveData[player]["options"]["dateweek"] ~= nil) then
					SC.Print2("Adding a new account for new character, "..Accountant.player..", dateweek = "..Accountant_SaveData[player]["options"]["dateweek"]);
					Accountant_SaveData[Accountant.player]["options"]["dateweek"] = Accountant_SaveData[player]["options"]["dateweek"];
				end			
			end
		end
--		SC.Print(ACCLOC_NEWPROFILE.." "..Accountant.player);
	else
--		SC.Print(ACCLOC_LOADPROFILE.." "..Accountant.player);
	end

	order = 1;
	for key,value in next,SC.data do
		if Accountant_SaveData[Accountant.player]["data"][key] == nil then
			Accountant_SaveData[Accountant.player]["data"][key] = {}
		end
		for modekey,mode in next,SC.log_modes do
			if Accountant_SaveData[Accountant.player]["data"][key][mode] == nil then
				Accountant_SaveData[Accountant.player]["data"][key][mode] = {In=0,Out=0};
			end
			SC.data[key][mode].In  = Accountant_SaveData[Accountant.player]["data"][key][mode].In;
			SC.data[key][mode].Out = Accountant_SaveData[Accountant.player]["data"][key][mode].Out;
		end
		SC.data[key]["Session"].In = 0;
		SC.data[key]["Session"].Out = 0;

		-- Old Version Conversion
		if Accountant_SaveData[Accountant.player]["data"][key].TotalIn ~= nil then
			Accountant_SaveData[Accountant.player]["data"][key]["Total"].In = Accountant_SaveData[Accountant.player]["data"][key].TotalIn;
			SC.data[key]["Total"].In = Accountant_SaveData[Accountant.player]["data"][key].TotalIn;
			Accountant_SaveData[Accountant.player]["data"][key].TotalIn = nil;
		end
		if Accountant_SaveData[Accountant.player]["data"][key].TotalOut ~= nil then
			Accountant_SaveData[Accountant.player]["data"][key]["Total"].Out = Accountant_SaveData[Accountant.player]["data"][key].TotalOut;
			SC.data[key]["Total"].Out = Accountant_SaveData[Accountant.player]["data"][key].TotalOut;
			Accountant_SaveData[Accountant.player]["data"][key].TotalOut = nil;
		end
		if Accountant_SaveData[key] ~= nil then
			Accountant_SaveData[key] = nil;
		end
		-- End OVC
		SC.data[key].order = order;
		order = order + 1;

		-- Quel's modifications to track income/expense across all characters relies on the savedata structure,
		-- so we have to reset the session totals for all players each time we log in, only for chars on this server.
		for player in next,Accountant_SaveData do
			if (string.find(player, Accountant_Realm) ~= nil) then
--				SC.Print2("Blanking session data for: "..player..", "..key);
				Accountant_SaveData[player]["data"][key]["Session"].In = 0;
				Accountant_SaveData[player]["data"][key]["Session"].Out = 0;
			end
		end

	end

	Accountant_SaveData[Accountant.player]["options"].version = SC.Version;
	Accountant_SaveData[Accountant.player]["options"].totalcash = GetMoney();

	if Accountant_SaveData[Accountant.player]["options"]["weekstart"] == nil then
		Accountant_SaveData[Accountant.player]["options"]["weekstart"] = 3;
		-- Quel's mod: make sure introdudction of a new character gets the same cdate as
		-- existing chars on this realm, otherwise it will prematurely wipe out the daily totals
		for player in next,Accountant_SaveData do
			if (string.find(player, Accountant_Realm) ~= nil) then
				if (Accountant_SaveData[player]["options"]["weekstart"] ~= nil) then
--					SC.Print2("Setting weekstart for "..AccountantPlayer.." to match "..player.." value: "..Accountant_SaveData[player]["options"]["weekstart"]);
					Accountant_SaveData[Accountant.player]["options"]["weekstart"] = Accountant_SaveData[player]["options"]["weekstart"];
				end
			end
		end
	end
	if Accountant_SaveData[Accountant.player]["options"]["dateweek"] == nil then
		Accountant_SaveData[Accountant.player]["options"]["dateweek"] = SC.WeekStart();
		-- Quel's mod: make sure introdudction of a new character gets the same cdate as
		-- existing chars on this server, otherwise it will prematurely wipe out the daily totals.
		for player in next,Accountant_SaveData do
			if (string.find(player, Accountant_Realm) ~= nil) then
				if (Accountant_SaveData[player]["options"]["dateweek"] ~= nil) then
--					SC.Print2("Setting dateweek for "..Accountant.player.." to match "..player.." value: "..Accountant_SaveData[player]["options"]["dateweek"]);
					Accountant_SaveData[Accountant.player]["options"]["dateweek"] = Accountant_SaveData[player]["options"]["dateweek"];
				end
			end
		end
	end
	if Accountant_SaveData[Accountant.player]["options"]["date"] == nil then
		cdate = date();
		cdate = string.sub(cdate,0,8);
		Accountant_SaveData[Accountant.player]["options"]["date"] = cdate;

		-- Quel's mod: make sure introdudction of a new character gets the same cdate as
		-- existing chars on this server, otherwise it will prematurely wipe out the daily totals.
		for player in next,Accountant_SaveData do
			if (string.find(player, Accountant_Realm) ~= nil) then
				if (Accountant_SaveData[player]["options"]["date"] ~= nil) then
--					SC.Print2("Setting date for "..AccountantPlayer.." to match "..player.." value: "..Accountant_SaveData[player]["options"]["date"]);
					Accountant_SaveData[Accountant.player]["options"]["date"] = Accountant_SaveData[player]["options"]["date"];
				end
			end
		end
	end

	-- Quel's mod: the following code to check for a new day/week was originally in OnShow(), which had
	-- a serious flaw. If you collected money on the first day of the week, then opened Accountant, the
	-- OnShow function would see a new week, blank the weekly values, then show zeros (losing the income
	-- or expenses). The session totals remained correct since they weren't reset. I moved all initialization
	-- code here.

	-- Check to see if the day has rolled over
	cdate = date();
	cdate = string.sub(cdate,0,8);
	if Accountant_SaveData[Accountant.player]["options"]["date"] ~= cdate then
		-- Its a new day! clear out the day tab
--		SC.Print2("Found a new day!");
		for mode,value in next,SC.data do
			SC.data[mode]["Day"].In = 0;
			SC.data[mode]["Day"].Out = 0;

			-- Quel's mod: have to clear data for all chars on this server when it rolls over and update
			-- their date to match.
			for player in next,Accountant_SaveData do
				if (string.find(player, Accountant_Realm) ~= nil) then
--					SC.Print2("	Setting Accountant_SaveData["..player.."][data]["..mode.."][date] = "..cdate);
					Accountant_SaveData[player]["data"][mode]["Day"].In = 0;
					Accountant_SaveData[player]["data"][mode]["Day"].Out = 0;
					Accountant_SaveData[player]["options"]["date"] = cdate;
				end
			end
		end
	end
	
	-- Check to see if the week has rolled over
	if Accountant_SaveData[Accountant.player]["options"]["dateweek"] ~= SC.WeekStart() then
--		SC.Print2("Found a new week!");
		-- Its a new week! clear out the week tab
		for mode,value in next,SC.data do
			SC.data[mode]["Week"].In = 0;
			SC.data[mode]["Week"].Out = 0;

			-- Quel's mod: have to clear data for all chars on this server when it rolls over and update
			-- their date to match.
			for player in next,Accountant_SaveData do
				if (string.find(player, Accountant_Realm) ~= nil) then
--					SC.Print2("	Setting Accountant_SaveData["..player.."][data]["..mode.."][dateweek] = "..SC.WeekStart() );
					Accountant_SaveData[player]["data"][mode]["Week"].In = 0;
					Accountant_SaveData[player]["data"][mode]["Week"].Out = 0;
					Accountant_SaveData[player]["options"]["dateweek"] = SC.WeekStart();
				end
			end
		end
	end
end

--
-- Consume and act on the Accountant slash commands
--
function SC.Slash(msg)
	if msg == nil or msg == "" then
		msg = "log";
	end
	local args = {n=0}
	local function helper(word) table.insert(args, word) end
	string.gsub(msg, "[_%w]+", helper);
	if args[1] == 'log'  then
		ShowUIPanel(AccountantFrame);
	elseif args[1] == 'verbose' then
		if SC.verbose == nil then
			SC.verbose = 1;
			SC.Print("Verbose Mode On");
		else
			SC.verbose = nil;
			SC.Print("Verbose Mode Off");
		end
	elseif args[1] == 'week' then
		SC.Print(SC.WeekStart());
	else
		SC.ShowUsage();
	end
end

--
-- Handle the events Accountant registered for
--
function SC.OnEvent(event, arg1)
	local oldmode = SC.mode;

	if ( event == "UNIT_NAME_UPDATE" and arg1 == "player" ) 
        or (event=="PLAYER_ENTERING_WORLD") then
		if (SC.got_name) then
			return;
		end
		local playerName = UnitName("player");
		if ( playerName ~= UNKNOWNBEING 
            and playerName ~= UNKNOWNOBJECT 
            and playerName ~= nil ) then
			SC.got_name = true;
			SC.OnLoad();
			SC.Options_OnLoad();
			SC.Button_Init();
			SC.Button_UpdatePosition();
		end
		return;
	end
 if ( event == "MERCHANT_SHOW"
 	or event == "MERCHANT_CLOSED"
	or event == "MERCHANT_UPDATE"
	or event == "UPDATE_INVENTORY_ALERTS"
	or event == "UPDATE_INVENTORY_DURABILITY" ) then
--	DEFAULT_CHAT_FRAME:AddMessage(" ACC event: "..event.." : "..tmp);
end
	if event == "MERCHANT_SHOW" then
		SC.mode = "MERCH";
		SC.repair_money = GetMoney();
		SC.could_repair = CanMerchantRepair();
        -- if merchant can repair set up variables so we can track repairs
		if ( SC.could_repair ) then
			SC.repair_cost, SC.can_repair = GetRepairAllCost();
        else
        end
--[[
        if ( SC.could_repair ) then
			tmpstr = "true";
		else
			tmpstr = "false";
		end
		DEFAULT_CHAT_FRAME:AddMessage(" ACC Merch show: "
			..tmpstr.." : "..SC.repair_cost.." : "..SC.repair_money);
--]]
	elseif event == "MERCHANT_CLOSED" then
		SC.mode = "";
		Account_RepairCost = 0;
	elseif event == "MERCHANT_UPDATE" then
		-- Could have bought something before or after repair
		SC.repair_money = GetMoney();
	elseif event == "UPDATE_INVENTORY_DURABILITY" then
--[[
    if ( SC.could_repair ) then
		tmpstr = "true";
	else
		tmpstr = "false";
	end
	DEFAULT_CHAT_FRAME:AddMessage(" ACC dura: "
		..tmpstr.." : "..SC.repair_cost);
--]]
        if ( SC.could_repair and SC.repair_cost > 0 ) then
			local cash = GetMoney();
--			DEFAULT_CHAT_FRAME:AddMessage(" ACC dura-1: "
--				..SC.repair_money.." : "..cash);
			if ( SC.repair_money > cash ) then
				-- most likely this is a repair bill
				local tmpMode = SC.mode;
				SC.mode = "REPAIRS";
				SC.UpdateLog();
--				DEFAULT_CHAT_FRAME:AddMessage(" ACC repair: "
--					..SC.repair_cost);
				SC.mode = tmpMode;
				-- a single item could have been repaired
				SC.repair_money = cash;
				-- reset the repair cost for the next repair
				SC.repair_cost, SC.can_repair = GetRepairAllCost();
--				DEFAULT_CHAT_FRAME:AddMessage(" ACC dura-2: "
--					..SC.repair_cost.." : ");
			end				
		end
	elseif event == "TAXIMAP_OPENED" then
		SC.mode = "TAXI";
	elseif event == "TAXIMAP_CLOSED" then
		-- Commented out due to taximap closing before money transaction
		-- SC.mode = "";
	elseif event == "LOOT_OPENED" then
		SC.mode = "LOOT";
	elseif event == "LOOT_CLOSED" then
		-- Commented out due to loot window closing before money transaction
		-- SC.mode = "";
	elseif event == "TRADE_SHOW" then
		SC.mode = "TRADE";
	elseif event == "TRADE_CLOSE" then
		SC.mode = "";
	elseif event == "QUEST_COMPLETE" then
		SC.mode = "QUEST";
	elseif event == "QUEST_FINISHED" then
		-- Commented out due to quest window closing before money transaction
		-- SC.mode = "";
	elseif event == "MAIL_SHOW" then
		SC.mode = "MAIL";
	elseif event == "MAIL_INBOX_UPDATE" then
		-- Quel's fix: when we open a mail message, see if this is a successfull Auction. 
		if (nil ~= InboxFrame.openMailID) then
			a, b, sender, subject, money = GetInboxHeaderInfo(InboxFrame.openMailID);
			if (nil ~= sender) then
				if (string.find(subject,ACCLOC_AH_SOLD_MAIL_SUBJECT) ~= nil) then
					SC.mode="AH";
				elseif (string.find (subject, ACCLOC_AH_OUTBID_MAIL_SUBJECT) ~= nil) then
					SC.mode="IGNORE";
					SC.refund_mode="AH";
					SC.sender = Accountant.player;
				elseif (nil ~= money ) then
					sender = Accountant_Realm.."-"..sender;
					for char in next,Accountant_SaveData do
						if (sender == char) then
							SC.mode="IGNORE";
							SC.refund_mode = "MAIL"
							SC.sender=sender;
						end
					end
				end
			end
		end
	elseif event == "MAIL_CLOSED" then
		SC.mode = "";
	elseif event == "TRAINER_SHOW" then
		SC.mode = "TRAIN";
	elseif event == "TRAINER_CLOSED" then
		SC.mode = "";
	elseif event == "AUCTION_HOUSE_SHOW" then
		SC.mode = "AH";
	elseif event == "AUCTION_HOUSE_CLOSED" then
		SC.mode = "";
	elseif event == "PLAYER_MONEY" then
		SC.UpdateLog();
	end
	if SC.verbose and SC.mode ~= oldmode then 
        SC.Print("Accountant mode changed to '"..SC.mode.."'"); 
    end
end

--
-- Take the 'amount' of gold nad make it into a nice, colorful string
-- of g c s (gold silver copper)
--
function SC.NiceCash(amount)
	local agold = 10000;
	local asilver = 100;
	local outstr = "";
	local gold = 0;
	local silver = 0;

	if amount >= agold then
		gold = math.floor(amount / agold);
		outstr = "|cFFFFFF00" .. gold .. "g "..FONT_COLOR_CODE_CLOSE;
	end
	amount = amount - (gold * agold);
	if amount >= asilver then
		silver = math.floor(amount / asilver);
		outstr = outstr .. "|cFFCCCCCC" .. silver .. "s "..FONT_COLOR_CODE_CLOSE;
	end
	amount = amount - (silver * asilver);
	if amount > 0 then
		outstr = outstr .. "|cFFFF6600" .. amount .. "c"..FONT_COLOR_CODE_CLOSE;
	end
	return outstr;
end

--
-- Find and return the chosen week start
--
function SC.WeekStart()
	oneday = 86400;
	ct = time();
	dt = date("*t",ct);
	thisDay = dt["wday"];
	while thisDay ~= Accountant_SaveData[Accountant.player]["options"].weekstart do
		ct = ct - oneday;
		dt = date("*t",ct);
		thisDay = dt["wday"];
	end
	cdate = date(nil,ct);
	return string.sub(cdate,0,8);
end

--
-- This routime is used by Titan Panel Accountant.
-- Others are welcome to use it as well.
--
-- logmode = the mode from log_modes.
--   session, week, ...
-- all_t0ons = is a boolean to return the gold 
--   of the character being played
--   or all characters on the server the user is logged into
--
-- <return> = is a string consisting of
--    <logmode> - the shortened version from log_modes_short
--        colored according to
--        positive gold = GREEN
--        zero gold = HIGHLIGHT (white)
--        negative gold = RED
--    <gold> - output of NiceCash
--
function Accountant_GetCurrentBal(logmode, all_toons)
	local mode_in, mode_out, m_in, m_out, diff = 0;
    local tmpstr = "";
	 local shortMode = ""
--	 SC.Print("Accountant Bal '"..logmode.."' for "..Accountant.player);
	 
	 if all_toons then
	 	mode_in, mode_out = SC.GetNetBalForAllToonsForMode(logmode)
	 else
		 mode_in, mode_out = SC.GetNetBalForToonForMode(logmode)
	 end
    diff = mode_in - mode_out;

	 
	 -- determine the short label for the button
	 for key,logmodeptr in next,SC.log_modes do
	 	if (logmode == SC.log_modes[key]) then
			 shortMode = SC.log_modes_short[key];
		 end
	 end
	
	 if ( diff > 0 ) then
        tmpstr = GREEN_FONT_COLOR_CODE
		  	..shortMode.." "
			..FONT_COLOR_CODE_CLOSE
		  	..SC.NiceCash(diff);
    elseif ( diff == 0 ) then
        tmpstr = HIGHLIGHT_FONT_COLOR_CODE
		  	..shortMode.." "
			..FONT_COLOR_CODE_CLOSE
			.."|cFFFFFF00"..tostring(0)..FONT_COLOR_CODE_CLOSE;
    else  -- less than 0
        tmpstr = RED_FONT_COLOR_CODE
		  	..shortMode.." "
			..FONT_COLOR_CODE_CLOSE
		  	..SC.NiceCash(diff * -1);
		  -- nice cash only deals with positive cash
    end
--	 SC.Print("Accountant Bal end '"..tmpstr.."' for "..Accountant.player);
    
	return tmpstr;
end

--
-- get the net balance for this toon for the requested mode
-- used by Accountant_GetCurrentBal
--
function SC.GetNetBalForToonForMode(mode)
 local TotalRowIn = 0;
	local TotalRowOut = 0;
	local TotalIn = 0
	local TotalOut = 0

for key,value in next,SC.data do

	if (string.find(Accountant.player, Accountant_Realm) ~= nil) then
		TotalRowIn = TotalRowIn + Accountant_SaveData[Accountant.player]["data"][key][mode].In;

		TotalRowOut = TotalRowOut + Accountant_SaveData[Accountant.player]["data"][key][mode].Out;
	end

	TotalIn = TotalIn + TotalRowIn;
	TotalOut = TotalOut + TotalRowOut;
 end
 
 return TotalIn, TotalOut
end

--
-- get the net balance of all toons for the requested mode
-- used by Accountant_GetCurrentBal
--
function SC.GetNetBalForAllToonsForMode(mode)
local TotalRowIn
local TotalRowOut
local TotalIn = 0
local TotalOut = 0

	for key,value in next,SC.data do
		TotalRowIn = 0;
		TotalRowOut = 0;

			for player in next,Accountant_SaveData do
				if (string.find(player, Accountant_Realm) ~= nil) then
					TotalRowIn = TotalRowIn + Accountant_SaveData[player]["data"][key][mode].In;

					TotalRowOut = TotalRowOut + Accountant_SaveData[player]["data"][key][mode].Out;
				end
			end

			TotalIn = TotalIn + TotalRowIn;
			TotalOut = TotalOut + TotalRowOut;
    end
    
    return TotalIn, TotalOut
end

--
-- Show the Accountant window on request
--
function SC.OnShow()
	SC.SetLabels();
	if SC.current_tab ~= 5 then
		TotalIn = 0;
		TotalOut = 0;
		mode = SC.log_modes[SC.current_tab];

		for key,value in next,SC.data do
			TotalRowIn = 0;
			TotalRowOut = 0;

			for player in next,Accountant_SaveData do
				if (string.find(player, Accountant_Realm) ~= nil) then
					TotalRowIn = TotalRowIn + Accountant_SaveData[player]["data"][key][mode].In;

					TotalRowOut = TotalRowOut + Accountant_SaveData[player]["data"][key][mode].Out;
				end
			end

			TotalIn = TotalIn + TotalRowIn;
			TotalOut = TotalOut + TotalRowOut;

			row = getglobal("AccountantFrameRow" ..SC.data[key].InPos.."In");
			row:SetText(SC.NiceCash(TotalRowIn));

			row = getglobal("AccountantFrameRow" ..SC.data[key].InPos.."Out");
			row:SetText(SC.NiceCash(TotalRowOut));
		end

		AccountantFrameTotalInValue:SetText(SC.NiceCash(TotalIn));
		AccountantFrameTotalOutValue:SetText(SC.NiceCash(TotalOut));
		
		if TotalOut > TotalIn then
			diff = TotalOut-TotalIn;
			AccountantFrameTotalFlow:SetText("|cFFFF3333"..ACCLOC_NETLOSS..":");
			AccountantFrameTotalFlowValue:SetText(SC.NiceCash(diff));
		else
			if TotalOut ~= TotalIn then
				diff = TotalIn-TotalOut;
				AccountantFrameTotalFlow:SetText("|cFF00FF00"..ACCLOC_NETPROF..":");
				AccountantFrameTotalFlowValue:SetText(SC.NiceCash(diff));
			else
				AccountantFrameTotalFlow:SetText(ACCLOC_NET);
				AccountantFrameTotalFlowValue:SetText("");
			end
		end
	else
		-- charachter totals
		local alltotal = 0;
		local i=1;
		for char,charvalue in next,Accountant_SaveData do
			if (string.find(char, Accountant_Realm) ~= nil) then
				getglobal("AccountantFrameRow" ..i.."Title"):SetText(char);
				if Accountant_SaveData[char]["options"]["totalcash"] ~= nil then
					getglobal("AccountantFrameRow" ..i.."In"):SetText(SC.NiceCash(Accountant_SaveData[char]["options"]["totalcash"]));
					alltotal = alltotal + Accountant_SaveData[char]["options"]["totalcash"];
					getglobal("AccountantFrameRow" ..i.."Out"):SetText(Accountant_SaveData[char]["options"]["date"]);
				else
					getglobal("AccountantFrameRow" ..i.."In"):SetText("Unknown");
				end
				i=i+1;
			end
		end
		AccountantFrameTotalInValue:SetText(SC.NiceCash(alltotal));
	
	end
	SetPortraitTexture(AccountantFramePortrait, "player");

	if SC.current_tab == 3 then
		AccountantFrameExtra:SetText(ACCLOC_WEEKSTART..":");
		AccountantFrameExtraValue:SetText(Accountant_SaveData[Accountant.player]["options"]["dateweek"]);
	else
		AccountantFrameExtra:SetText("");
		AccountantFrameExtraValue:SetText("");
	end

	PanelTemplates_SetTab(AccountantFrame, SC.current_tab);

end

function SC.OnHide()
	if MYADDONS_ACTIVE_OPTIONSFRAME == this then
		ShowUIPanel(myAddOnsFrame);
	end
end

--
-- Accountant print
--
function SC.Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(format("Accountant: "..msg));
end

--
-- Accountant print used mainly for debug
--
function SC.Print2(msg)
	ChatFrame4:AddMessage(format("Accountant: "..msg));
end

function SC.ShowUsage()
	QM_Print("/accountant log\n");
end

--
-- request confirmation from the user to make sure they
-- really really want to reset all the data
--
function SC.ResetData()
	local type = SC.log_modes[SC.current_tab];
	if type == "Total" then
		type = "overall";
	end
	StaticPopupDialogs["ACCOUNTANT_RESET"].text = ACCLOC_RESET_CONF.." "..type.." "..ACCLOC_TOTAL.."?";
	local dialog = StaticPopup_Show("ACCOUNTANT_RESET","weeee");
end

--
-- On confirmation from the user, reset all the data
--
function SC.ResetConfirmed()
	local type = SC.log_modes[SC.current_tab];
	for key,value in next,SC.data do
		SC.data[key][type].In = 0;
		SC.data[key][type].Out = 0;
		-- Clear every player on the realm on a reset.
		for player in next,Accountant_SaveData do
			if (string.find(player, Accountant_Realm) ~= nil) then
				Accountant_SaveData[player]["data"][key][type].In = 0;
				Accountant_SaveData[player]["data"][key][type].Out = 0;
			end
		end
	end
	if AccountantFrame:IsVisible() then
		SC.OnShow();
	end
end

--
-- Update the Accountant data based on the current Accountant mode
-- The mode sets the category of gold income or expense shown in 
-- the Accountant window
--
function SC.UpdateLog()
	SC.current_money = GetMoney();
	Accountant_SaveData[Accountant.player]["options"].totalcash = SC.current_money;
	diff = SC.current_money - SC.last_money;
	SC.last_money = SC.current_money;
	if diff == 0 or diff == nil then
		return;
	end		

	local mode = SC.mode;
	if mode == "" then mode = "OTHER"; end

	-- Quel's mod: ignore cash transfers between the player's characters
	if (SC.mode ~= "IGNORE") then
		if diff >0 then
			for key,logmode in next,SC.log_modes do
				SC.data[mode][logmode].In = SC.data[mode][logmode].In + diff;
				Accountant_SaveData[Accountant.player]["data"][mode][logmode].In = SC.data[mode][logmode].In;
			end
			if SC.verbose then SC.Print("Gained "..SC.NiceCash(diff).." from "..mode); end

		elseif diff < 0 then
			diff = diff * -1;
			for key,logmode in next,SC.log_modes do
				SC.data[mode][logmode].Out = SC.data[mode][logmode].Out + diff;
				Accountant_SaveData[Accountant.player]["data"][mode][logmode].Out = SC.data[mode][logmode].Out;
			end
			if SC.verbose then SC.Print("Lost "..SC.NiceCash(diff).." from "..mode); end
		end
	else
		if (SC.refund_mode == "AH") then
			postage = 0;
		else
			postage = 30;
		end

		-- if xfer between the player's chars or outbid auction back to the sender's totals
		for key,logmode in next,SC.log_modes do
			Accountant_SaveData[SC.sender]["data"][SC.refund_mode][logmode].Out = Accountant_SaveData[SC.sender]["data"][SC.refund_mode][logmode].Out - (diff - postage);
			if (Accountant_SaveData[SC.sender]["data"][SC.refund_mode][logmode].Out < 0) then
				Accountant_SaveData[SC.sender]["data"][SC.refund_mode][logmode].Out = 0;
			end
		end

			if SC.verbose then 
				SC.Print("IGNORE: "..SC.NiceCash(diff).." mode = "..SC.refund_mode .." refundee = "..SC.sender);
			end
		end

	-- special case mode resets
--	if SC.mode == "REPAIRS" then
--		SC.mode = "MERCH";
--	end

	if AccountantFrame:IsVisible() then
		SC.OnShow();
	end
end

--
-- Switch tabs on the Accountant window on user request (click)
function SC.Tab_OnClick()
	PanelTemplates_SetTab(AccountantFrame, this:GetID());
	SC.current_tab = this:GetID();
	PlaySound("igCharacterInfoTab");
	SC.OnShow();
end


