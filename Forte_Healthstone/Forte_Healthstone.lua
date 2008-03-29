-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x
local FW = FW;
local HS = FW:Module("Healthstone");

local r, g, b, a;
local t1,t2,t3,t4,t5,t6;
local s1;

local NUM_HS = 6;
local hs = {};


local HealthstoneShow = nil;
local function HS_HealthstoneShow(auto)
	if not auto then HealthstoneShow = 1;end
	if FW.Settings.Healthstone and (not FW.Settings.HealthstoneAuto or FC_Saved.PARTY or FC_Saved.RAID) then
	
		if HealthstoneShow or not FWHSFrame:IsShown() then
		
			FWHSBackground:ClearAllPoints();
			if not InCombatLockdown() then
				HealthstoneShow = nil;
				FWHSFrame:Show();
				FWHSBackground:Show();

				FWHSFrame:SetWidth(FW.Settings.HealthstoneWidth+2*FW.BORDER);
				FWHSFrame:SetScale(FW.Settings.HealthstoneScale);
			end
			FWHSBackground:SetWidth(FW.Settings.HealthstoneWidth+2*FW.BORDER);
			FWHSBackground:SetScale(FW.Settings.HealthstoneScale);
			
			FWHSBackground:SetBackdropColor(unpack(FW.Settings.ColorHealthstoneBg));
			FWHSBackground:SetBackdropBorderColor(unpack(FW.Settings.ColorHealthstoneBg));

			FWHSFrameAmount1:SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
			FWHSFrameAmount2:SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
			
			r,g,b = unpack(FW.Settings.ColorHealthstoneText);
			for i=1,NUM_HS,1 do
				getglobal("FWHSBar"..i):ClearAllPoints();
				
				getglobal("FWHSBar"..i.."Name"):SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
				getglobal("FWHSBar"..i.."Amount"):SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
				
				getglobal("FWHSBar"..i):SetWidth(FW.Settings.HealthstoneWidth);
				getglobal("FWHSBar"..i):SetHeight(FW.Settings.HealthstoneHeight);
				getglobal("FWHSBar"..i):SetStatusBarTexture(FW.Settings.HealthstoneTexture);
				getglobal("FWHSBar"..i.."Back"):SetTexture(FW.Settings.HealthstoneTexture);
				getglobal("FWHSBar"..i.."Name"):SetTextColor(r,g,b);
				getglobal("FWHSBar"..i.."Amount"):SetTextColor(r,g,b);

				getglobal("FWHSBar"..i.."Spark"):SetWidth(FW.Settings.HealthstoneHeight);
				getglobal("FWHSBar"..i.."Spark"):SetHeight(FW.Settings.HealthstoneHeight*2);
			end
			
			if FW.Settings.HealthstoneExpand then
				FWHSBackground:SetPoint("BOTTOMRIGHT", FWHSFrame, "BOTTOMRIGHT", 0, 0);
				FWHSBar1:SetPoint("BOTTOMLEFT", FWHSBackground, "BOTTOMLEFT", FW.BORDER, 18);

				for i=2,NUM_HS,1 do
					getglobal("FWHSBar"..i):SetPoint("BOTTOMLEFT", getglobal("FWHSBar"..(i-1)), "TOPLEFT", 0, FW.Settings.HealthstoneSpace);
				end
			else
				FWHSBackground:SetPoint("TOPLEFT", FWHSFrame, "TOPLEFT", 0, 0);
				FWHSBar1:SetPoint("TOPLEFT", FWHSBackground, "TOPLEFT", FW.BORDER, -18);

				for i=2,NUM_HS,1 do
					getglobal("FWHSBar"..i):SetPoint("TOPLEFT", getglobal("FWHSBar"..(i-1)), "BOTTOMLEFT", 0, -FW.Settings.HealthstoneSpace);
				end
			end
		end
	else 
		if (HealthstoneShow or FWHSFrame:IsShown()) and not InCombatLockdown() then
			HealthstoneShow = nil;
			FWHSFrame:Hide();
			FWHSBackground:Hide();
		end
	end
end

local function HS_HealthstoneScale()
	HS_HealthstoneShow();
	FW:CorrectScale(FWHSFrame);
end

local function ColorVal(v)
	r,g,b = FW:MixColors(v,FW.Settings.ColorHealthstoneMin,FW.Settings.ColorHealthstoneMax);
end

local function HS_DrawHealthstone()
	if not FWHSFrame:IsShown() then return; end
	local n=0;
	local Bar,Spark;
	for i=1, NUM_HS, 1 do
		Bar = getglobal("FWHSBar"..i);
		if FW.Settings.HealthstoneDetails and (not FW.Settings.HealthstoneDetailsAuto or FC_Saved.PARTY or FC_Saved.RAID) and i <= FW:ROWS(hs) then
			t1,t2,t3,t4 = FW:GET(hs,i);
			Bar.title = "Missing "..t3;
			Bar.tip = t4;
			Spark = getglobal("FWHSBar"..i.."Spark");
			ColorVal(t1/t2);
			
			Bar:SetStatusBarColor(r,g,b);
			getglobal("FWHSBar"..i.."Back"):SetVertexColor(r,g,b,0.5);
			
			getglobal("FWHSBar"..i.."Name"):SetText(t3);
			
			if FW.Settings.HealthstoneMissing then
				getglobal("FWHSBar"..i.."Amount"):SetText(t2-t1);
			else
				getglobal("FWHSBar"..i.."Amount"):SetText(t1);
			end
			Bar:SetValue(t1/t2);
			Spark:SetPoint("CENTER", Bar, "LEFT", t1/t2*Bar:GetWidth(), 0);
			n=n+1;
			Bar:Show();
		else
			Bar:Hide();
		end
	end
	if n>0 then
		FWHSBackground:SetHeight(21+(FW.Settings.HealthstoneHeight+FW.Settings.HealthstoneSpace)*n-FW.Settings.HealthstoneSpace);
	else
		FWHSBackground:SetHeight(20);
	end
end

local function HS_SetHSButton()
	t1,_,t3 = FW:BestHealthstone();
	t2 = FW:GotHealthstone();
	t4=0;
	local HSTip = "";
	for k,v in ipairs(FW.ID_HEALTHSTONE) do
		t6 = GetItemCount(v[2]);
		if t6>0 then
			t4=t4+t6;
			HSTip = HSTip.."\n"..v[3];
		end
	end
	FWHSFrameAmount1:SetText("x"..t4);	

	if not InCombatLockdown() then -- update the use function in case it wasnt loaded properly due to combat or whatever
		if t2 then FWHSButton:SetAttribute("*item2", t2 ); end
	end
	t5 = FWHSButton:GetAttribute("*","item","2");
	if t5 and FW:GotThisHealthstone(t5) then
		FWHSButton.title=string.format(FW.L.USE_,t5);
		FWHSButton.tip=string.format(FW.L.RIGHT_CLICK_TO_USE_,t5).."\n"..string.format(FW.L.LEFT_CLICK_TO_CREATE_,t1).."\n|cffffffff"..FW.L.YOU_HAVE_.."|r"..HSTip;
		
		FWHSButton:SetNormalTexture("Interface\\AddOns\\Forte_Core\\Textures\\HS2");
	else
		FWHSButton.title=string.format(FW.L.CREATE_,t1);
		FWHSButton.tip=string.format(FW.L.LEFT_CLICK_TO_CREATE_,t1);
		
		FWHSButton:SetNormalTexture("Interface\\AddOns\\Forte_Core\\Textures\\HS3");
	end

end

local function HS_ProcessHealthstone()
	for i,v in ipairs(FW.Healthstone) do
		
		t1=GetItemCount(FW.ID_HEALTHSTONE[v][2]);
		if FC_Saved.Healthstone[FW.PLAYER][v] ~= t1 then
			FC_Saved.Healthstone[FW.PLAYER][v] = t1;
			FW:SendHealthstone(v,t1);
		end

	end
	if FWHSFrame:IsShown() then
		FW:ERASE(hs);
		t3 = 0;
		_,t2 = FW:BestHealthstone();
		for k, v in ipairs(FW.Healthstone) do
			t5 = t2;
			t4 = 0;
			t1 = 0;
			s1 = FW.L.NOBODY;
			for name, data in pairs(FC_Saved.Healthstone) do
				if data[0] == FC_Saved.Update and data[v] and data[v] ~= -1 then
					t4=t4+1;
					if data[v]>0 then t1 = t1 + data[v];else if s1==FW.L.NOBODY then s1=name else s1 = s1.."\n"..name;end end
				end
			end
			while (t5>0) do
				if t5 == v then
					t3 = t3 + (t4-t1);
					break;
				end
				t5 = t5 - 3;
			end
			FW:INSERT(hs, t1,t4,FW.ID_HEALTHSTONE[v][3],s1);
		end
		FWHSFrameAmount2:SetText("x"..t3);
		HS_DrawHealthstone();
		HS_SetHSButton();
	end
end

local function HS_HealthstoneReceived(n,id,who)
	--FW:Show("hs "..id.." x"..n.." from "..who);
	if FC_Saved.Healthstone[who] then
		if id > #FW.ID_HEALTHSTONE then
			for i=#FW.ID_HEALTHSTONE,1,-1 do
				if FW.ID_HEALTHSTONE[i][2] == id then
					FC_Saved.Healthstone[who][ i ] = n;
					return 1;
				end
			end
		else
			FC_Saved.Healthstone[who][ id ] = n;
			return 1;
		end
	end
end

--globally accessable

function FW:HSFrame_OnClick(button)
	if this.fwmovingx then return; end
	if button == "LeftButton" then
		if FW.Settings.HealthstoneDetails then
			if FW.Settings.HealthstoneMissing then
				FW.Settings.HealthstoneDetails = false;
			else
				FW.Settings.HealthstoneMissing = true;
			end
		
		else
			FW.Settings.HealthstoneDetails = true;
			FW.Settings.HealthstoneMissing = false;
		end
		HS_DrawHealthstone();
		FW:RefreshOptions();
	else
		FW:ScrollTo(FW.L.HEALTHSTONE_SPY);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:HealthstoneCheck() -- clicked from ui (and time-based)
	FW:SendData(FW.GET_HEALTHSTONE);
end

function FW:HealthstoneOnload()
	FW:RegisterFrame("FWHSFrame",HS_HealthstoneShow,"Healthstone");
	
	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("HealthstoneInterval",	FW.CreateHealthstoneTypes);	
		FW:RegisterTimedEvent("HealthstoneInterval",	HS_ProcessHealthstone);
		FW:RegisterTimedEvent("HealthstoneInterval",	function() HS_HealthstoneShow(1); end);
		FW:RegisterTimedEvent("HealthstoneCheckTime",	FW.HealthstoneCheck);
	end);
	
	FW:RegisterLoadEvent(HS_HealthstoneShow);
	
	FW:RegisterOnEnterCombat(HS_SetHSButton); -- Hopefully set correct spell just before the buttons are locked if loading up in combat, if it failed during loading the button somehow
	
	
	FW:RegisterORAMessage(FW.ORA_ITEM_RESPONSE,
		function(a1,a2,f)
			a1,a2=tonumber(a1),tonumber(a2);
			if a1 and a2 then
				return HS_HealthstoneReceived(a1,a2,f);
			end
		end,
	1);--ignore for ppl with fw
	FW:RegisterMessage(FW.SEND_HEALTHSTONE,
		function(m,f) 
			local _,_,t1,t2 = string.find(m,"^(%d+) (%d+)$");
			t1,t2=tonumber(t1),tonumber(t2);
			if t1 and t2 then
				HS_HealthstoneReceived(t2,t1,f);
			end
		end,
	nil);
end

FW:SetMainCategory(FW.L.HEALTHSTONE_SPY,FW.ICON_HS,7,"HEALTHSTONE","FWHSFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.COMBAT_HINT);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.ORA_HINT);
		
	FW:SetSubCategory(FW.L.BASIC,FW.ICON_BASIC,2);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ENABLE,		FW.L.HS_ENABLE_TT,	"Healthstone",		HS_HealthstoneShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.AUTO_HIDE,	FW.L.AUTO_HIDE_TT,	"HealthstoneAuto",	HS_HealthstoneShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.AUTO_MINIMIZE,	FW.L.AUTO_MINIMIZE_TT,	"HealthstoneDetailsAuto");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_BARS,	FW.L.SHOW_BARS_TT,	"HealthstoneDetails");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXPAND_UP,	FW.L.EXPAND_UP_TT,	"HealthstoneExpand",	HS_HealthstoneShow);
		
	FW:SetSubCategory(FW.L.SPECIFIC,FW.ICON_SPECIFIC,3);	
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_MISSING,	FW.L.SHOW_MISSING_TT,	"HealthstoneMissing",	HS_DrawHealthstone);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.NUM_TYPES,	FW.L.NUM_TYPES_TT,	"HealthstoneNumber");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ONLY_TOP_RANK,	FW.L.ONLY_TOP_RANK_TT,	"HealthstoneTopRank");

	FW:SetSubCategory(FW.L.SIZING,FW.ICON_SIZE,4);	
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_WIDTH,			"",	"HealthstoneWidth",	HS_HealthstoneShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_HEIGHT,			"",	"HealthstoneHeight",	HS_HealthstoneShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_SPACING,			"",	"HealthstoneSpace",	HS_HealthstoneShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SCALE,				"",	"HealthstoneScale",	HS_HealthstoneScale);
		
	FW:SetSubCategory(FW.L.BAR_COLORING,FW.ICON_FILTER,5);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.LITTLE_HS,			"",	"ColorHealthstoneMin");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.MANY_HS,				"",	"ColorHealthstoneMax");
		
	FW:SetSubCategory(FW.L.APPEARANCE,FW.ICON_APPEARANCE,6);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BAR_TEXT,			"",	"ColorHealthstoneText",	HS_HealthstoneShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FRAME_BACKGROUND,		"",	"ColorHealthstoneBg",	HS_HealthstoneShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.BAR_FONT,			"",	"HealthstoneFont",	HS_HealthstoneShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FW.L.BAR_TEXTURE,			"",	"HealthstoneTexture",	HS_HealthstoneShow);

FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FW.L.HEALTHSTONE_SPY,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.HEALTHSTONE_CHECK_TIME,		"",	"HealthstoneCheckTime");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.HEALTHSTONE_DRAW_INTERVAL,	"",	"HealthstoneInterval");

FW.Default.HealthstoneInterval = 2;
FW.Default.HealthstoneCheckTime = 60;

FW.Default.ColorHealthstoneText =	{1.00,1.00,1.00};
FW.Default.ColorHealthstoneBg =		{0.55,0.00,0.88,0.75};
FW.Default.ColorHealthstoneMin = 	{0.93,1.00,0.00};
FW.Default.ColorHealthstoneMax = 	{0.53,1.00,0.00};

FW.Default.HealthstoneFont = FW.Default.Font;
FW.Default.HealthstoneFontSize = FW.Default.FontSize;
FW.Default.HealthstoneTexture = FW.Default.Texture;
FW.Default.Healthstone = true;
FW.Default.HealthstoneDetails = true;
FW.Default.HealthstoneDetailsAuto = false;
FW.Default.HealthstoneAuto = false;
FW.Default.HealthstoneMax = 5;
FW.Default.HealthstoneWidth = 100;
FW.Default.HealthstoneHeight = 12;
FW.Default.HealthstoneScale = 1;
FW.Default.HealthstoneSpace = 1;
FW.Default.HealthstoneExpand = false;
FW.Default.HealthstoneMissing = true;
--FW.Default.HealthstoneNumber = 3;
--FW.Default.HealthstoneTopRank = true;
