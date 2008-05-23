-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x
local FW = FW;
local SH = FW:Module("Shard");

local r, g, b, a;
local t1,t2,t3,t4;

local MaxShards = 28;
local sh = {};
local NUM_SHARDS = 10;

local SORT={
	SHARD =		{ORDER=	{5,2},		ASC={0,1}},
}

local function SH_ShardShow(auto) -- with auto set, will only refresh the frame if it's not hidden/shown properly yet

	if FW.Settings.Shard and (not FW.Settings.ShardAuto or FC_Saved.PARTY or FC_Saved.RAID) then
	
		if not auto or not FWSHFrame:IsShown() then
		
			FWSHFrame:Show();
			FWSHBackground:Show();
			FWSHBackground:ClearAllPoints();
			
			FWSHFrame:SetWidth(FW.Settings.ShardWidth+2*FW.BORDER);
			FWSHBackground:SetWidth(FW.Settings.ShardWidth+2*FW.BORDER);
			FWSHFrame:SetScale(FW.Settings.ShardScale);
			FWSHBackground:SetScale(FW.Settings.ShardScale);
			
			FWSHBackground:SetBackdropColor(unpack(FW.Settings.ColorShardBg));
			FWSHBackground:SetBackdropBorderColor(unpack(FW.Settings.ColorShardBg));

			FWSHFrameAmount:SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
			FWSHFrameInfo:SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
			
			r,g,b = unpack(FW.Settings.ColorShardText);
			for i=1,NUM_SHARDS,1 do
				getglobal("FWSHBar"..i):ClearAllPoints();
				
				getglobal("FWSHBar"..i.."Name"):SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
				getglobal("FWSHBar"..i.."Amount"):SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
				
				getglobal("FWSHBar"..i):SetWidth(FW.Settings.ShardWidth);
				getglobal("FWSHBar"..i):SetHeight(FW.Settings.ShardHeight);
				getglobal("FWSHBar"..i):SetStatusBarTexture(FW.Settings.ShardTexture);
				getglobal("FWSHBar"..i.."Back"):SetTexture(FW.Settings.ShardTexture);
				getglobal("FWSHBar"..i.."Name"):SetTextColor(r,g,b);
				getglobal("FWSHBar"..i.."Amount"):SetTextColor(r,g,b);

				getglobal("FWSHBar"..i.."Spark"):SetWidth(FW.Settings.ShardHeight);
				getglobal("FWSHBar"..i.."Spark"):SetHeight(FW.Settings.ShardHeight*2);
			end
			
			if FW.Settings.ShardExpand then
				FWSHBackground:SetPoint("BOTTOMRIGHT", FWSHFrame, "BOTTOMRIGHT", 0, 0);
				FWSHBar1:SetPoint("BOTTOMLEFT", FWSHBackground, "BOTTOMLEFT", FW.BORDER, 18);

				for i=2,NUM_SHARDS,1 do
					getglobal("FWSHBar"..i):SetPoint("BOTTOMLEFT", getglobal("FWSHBar"..(i-1)), "TOPLEFT", 0, FW.Settings.ShardSpace);
				end
			else
				FWSHBackground:SetPoint("TOPLEFT", FWSHFrame, "TOPLEFT", 0, 0);
				FWSHBar1:SetPoint("TOPLEFT", FWSHBackground, "TOPLEFT", FW.BORDER, -18);

				for i=2,NUM_SHARDS,1 do
					getglobal("FWSHBar"..i):SetPoint("TOPLEFT", getglobal("FWSHBar"..(i-1)), "BOTTOMLEFT", 0, -FW.Settings.ShardSpace);
				end
			end
		end
	else 
		if not auto or FWSHFrame:IsShown() then
	
			FWSHFrame:Hide();
			FWSHBackground:Hide();
		end
	end
end

local function SH_ShardScale()
	FW:CorrectScale(FWSHFrame);
	SH_ShardShow();
end

local function ColorVal(v,flag)
	
	if flag == FW.FLAG_NORMAL then
		r,g,b = FW:MixColors(v,FW.Settings.ColorShardMin,FW.Settings.ColorShardMax);
	elseif flag == FW.FLAG_DEAD then
		r,g,b = unpack(FW.Settings.ColorShardDead);
	elseif flag == FW.FLAG_OFFLINE then
		r,g,b = unpack(FW.Settings.ColorShardOffline);
	elseif flag == FW.FLAG_UNKNOWN then
		r,g,b = unpack(FW.Settings.ColorShardUnknown);
	end
end

local function SH_DrawShard()
	if not FWSHFrame:IsShown() then return; end
	local n=0;
	local Bar,Spark;
	for i=1, NUM_SHARDS, 1 do
		Bar = getglobal("FWSHBar"..i);
		if FW.Settings.ShardDetails and (not FW.Settings.ShardDetailsAuto or FC_Saved.PARTY or FC_Saved.RAID) and i <= FW.Settings.ShardMax and i <= FW:ROWS(sh) then
			t1,t2,t3,t4 = FW:GET(sh,i)
		
			Spark = getglobal("FWSHBar"..i.."Spark");
			ColorVal(t1,t4);
			
			Bar:SetStatusBarColor(r,g,b);
			getglobal("FWSHBar"..i.."Back"):SetVertexColor(r,g,b,0.5);
			
			getglobal("FWSHBar"..i.."Name"):SetText(t2);
			getglobal("FWSHBar"..i.."Amount"):SetText(t3);

			Bar:SetValue(t1);
			Spark:SetPoint("CENTER", Bar, "LEFT", t1*Bar:GetWidth(), 0);
			n=n+1;
			Bar:Show();
		else
			Bar:Hide();
		end

	end
	if n>0 then
		FWSHBackground:SetHeight(21+(FW.Settings.ShardHeight+FW.Settings.ShardSpace)*n-FW.Settings.ShardSpace);
	else
		FWSHBackground:SetHeight(20);
	end
end

local function SH_ProcessShard()

	t1 = FW:GotShards();
	if FC_Saved.Shards[FW.PLAYER] and t1 ~= FC_Saved.Shards[FW.PLAYER][1] then
		FC_Saved.Shards[FW.PLAYER][1] = t1;
		FW:SendShards(t1);
	end
	if FW.Settings.Shard then--no combat problems
		FW:ERASE(sh);
		t4 = 0;
		FWSHFrameAmount:SetText("x"..t1);
		for name, data in pairs(FC_Saved.Shards) do
			if data[2] == FC_Saved.Update then
				t3,t2,t1 = data[3],data[1]/MaxShards,data[1];

				if t1 == -1 then-- no response from ora/ctra
					t1 = "??";
					t2=1;
					if t3 == FW.FLAG_NORMAL then t3 = FW.FLAG_UNKNOWN end;
				else
					t4 = t4 + t1;
				end
				if t2 > 1 then t2 = 1 end;
				FW:INSERT(sh, t2,name,t1,t3,data[1]);
			end
		end
		FWSHFrameInfo:SetText(string.format(FW.L._TOTAL,t4));
		FW:BST(sh,SORT.SHARD.ORDER,SORT.SHARD.ASC); -- sort viewable data

		SH_DrawShard();
	end
end

local function SH_ShardsReceived(n,who)
	if who ~= FW.PLAYER and FC_Saved.Shards[who] then
		FC_Saved.Shards[who][1] = n;
	end
end

--globally accessable

function FW:SHFrame_OnClick(button)
	if this.fwmovingx then return; end
	if button == "LeftButton" then
		FW.Settings.ShardDetails = not FW.Settings.ShardDetails;
		SH_DrawShard();
		FW:RefreshOptions();
	else
		FW:ScrollTo(FW.L.SHARD_SPY);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:ShardCheck() -- clicked from ui (and time-based)
	FW:SendData(FW.GET_SHARDS);
end


function FW:ShardOnload()
	FW:RegisterFrame("FWSHFrame",SH_ShardShow,"Shard");

	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("ShardInterval",		SH_ProcessShard);
		FW:RegisterTimedEvent("ShardInterval",		function() SH_ShardShow(1); end);
		FW:RegisterTimedEvent("ShardCheckTime",		FW.ShardCheck);	
	end);
	
	FW:RegisterLoadEvent(SU_ShardShow);
	
	FW:RegisterORAMessage(FW.ORA_ITEM_RESPONSE,
		function(a1,a2,f)
			a1,a2=tonumber(a1),tonumber(a2);
			if a1 and a2 then
				if a2 == FW.ID_SOULSHARD then
					return SH_ShardsReceived(a1,f);
				end
			end
		end,
	1);--ignore for ppl with fw
	FW:RegisterMessage(FW.SEND_SHARDS,
		function(m,f) 
			SH_ShardsReceived(tonumber(m),f);
		end,
	nil);
	--FW:Show("Shard Module Loaded");
end
FW:SetMainCategory(FW.L.SHARD_SPY,FW.ICON_SH,6,"DEFAULT","FWSHFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.ORA_HINT);
		
	FW:SetSubCategory(FW.L.BASIC,FW.ICON_BASIC,2);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.ENABLE,		FW.L.SH_ENABLE_TT,	"Shard",		SH_ShardShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.AUTO_HIDE,	FW.L.AUTO_HIDE_TT,	"ShardAuto",		SH_ShardShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.AUTO_MINIMIZE,	FW.L.AUTO_MINIMIZE_TT,	"ShardDetailsAuto");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.SHOW_BARS,	FW.L.SHOW_BARS_TT,	"ShardDetails");
		FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.EXPAND_UP,	FW.L.EXPAND_UP_TT,	"ShardExpand",		SH_ShardShow);

--	FW:SetSubCategory(FW.L.SPECIFIC,FW.ICON_SPECIFIC,3);	
	
	FW:SetSubCategory(FW.L.SIZING,FW.ICON_SIZE,4);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_WIDTH,			"",	"ShardWidth",		SH_ShardShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_HEIGHT,			"",	"ShardHeight",		SH_ShardShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.BAR_SPACING,			"",	"ShardSpace",		SH_ShardShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SCALE,				"",	"ShardScale",		SH_ShardScale);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.MAX_SHOWN,			"",	"ShardMax");	
	
	FW:SetSubCategory(FW.L.BAR_COLORING,FW.ICON_FILTER,5);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.LITTLE_SHARDS,			"",	"ColorShardMin");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.MANY_SHARDS,			"",	"ColorShardMax");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.UNKNOWN_N,			"",	"ColorShardUnknown");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.DEAD,				"",	"ColorShardDead");
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.OFFLINE,				"",	"ColorShardOffline");
		
	FW:SetSubCategory(FW.L.APPEARANCE,FW.ICON_APPEARANCE,6);	
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.BAR_TEXT,			"",	"ColorShardText",	SH_ShardShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FW.L.FRAME_BACKGROUND,		"",	"ColorShardBg",		SH_ShardShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.BAR_FONT,			"",	"ShardFont",		SH_ShardShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FW.L.BAR_TEXTURE,			"",	"ShardTexture",		SH_ShardShow);
		
FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FW.L.SHARD_SPY,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SHARD_CHECK_TIME,		"",	"ShardCheckTime");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.SHARD_DRAW_INTERVAL,		"",	"ShardInterval");

FW.Default.ShardInterval = 2;
FW.Default.ShardCheckTime = 60;

FW.Default.ShardFont = FW.Default.Font;
FW.Default.ShardFontSize = FW.Default.FontSize;
FW.Default.ShardTexture = FW.Default.Texture;
FW.Default.Shard = true;
FW.Default.ShardDetails = true;
FW.Default.ShardDetailsAuto = false;
FW.Default.ShardAuto = false;
FW.Default.ShardMax = 5;
FW.Default.ShardWidth = 100;
FW.Default.ShardHeight = 12;
FW.Default.ShardScale = 1;
FW.Default.ShardSpace = 1;
FW.Default.ShardExpand = false;

FW.Default.ColorShardBg = 	{0.55,0.00,0.88,0.75};
FW.Default.ColorShardMin = 	{1.00,0.00,0.60};
FW.Default.ColorShardMax = 	{0.64,0.21,0.93};
FW.Default.ColorShardUnknown = 	{1.00,0.00,0.60};
FW.Default.ColorShardDead = 	{0.60,0.60,0.60};
FW.Default.ColorShardOffline = 	{0.40,0.40,0.40};
FW.Default.ColorShardText = 	{1.00,1.00,1.00};