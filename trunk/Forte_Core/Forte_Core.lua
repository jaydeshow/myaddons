-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x

local FW_Debug = false;
FW = {}; -- core table
local FW = FW;
FC_Saved = {}; -- save table


FW.L = {}; -- locale table
FW.Default = {};

local Commands = {};
local FW_Frames = {};
local FW_Events = {};
local FW_Timed = {};
local FW_Loaded = {};
local FW_DelayedLoaded = {};
local FW_VariablesLoaded = {};
local FW_Updated = {};
local FW_Messages = {};
local FW_oRAMessages = {};

local FW_EnterPartyRaid = {};

local FW_OnEnterCombat = {};
local FW_OnLeaveCombat = {};

local FilterRefresh = {};

local ipairs = ipairs;
local pairs = pairs;
local select = select;

local VERSION = "v0.985";
local PREFIX = "ForteWarlock";
local ENABLE = false;

local NUM_PROFILE_LIST = 15;
local NUM_FILTER_LIST = 3;

FW.BORDER = 3;

FW.PLAYER = UnitName("player");
FW.CLASS = select(2,UnitClass("player"));
FW.SERVER = GetRealmName();

FW.ID_SOULSHARD = 6265;

FW.ORA_SHARD_REQUEST = "ITMC "..FW.ID_SOULSHARD;
FW.ORA_ITEM_RESPONSE = "ITM ([%d%-]+) (%d+)";
FW.ORA_ITEM_RESPONSE_SHORT = "ITM %s %s %s";
FW.ORA_ITEM_REQUEST_SHORT = "ITMC ";
FW.ORA_ITEM_REQUEST = "ITMC (%d+)$";

FW.PARTY = {};for i=1,4,1 do tinsert(FW.PARTY,"party"..i);end
FW.RAID = {};for i=1,40,1 do tinsert(FW.RAID,"raid"..i);end

local IMP_HS = {[0]=" (0/2)",[1]=" (1/2)",[2]=" (2/2)"};

FW.FLAG_RES = 0; -- can res with ss
FW.FLAG_DI = 1; -- is di-ed
FW.FLAG_TIME = 2; -- normal soulstone duration
FW.FLAG_WARLOCK = 3;
FW.FLAG_DRUID = 4;
FW.FLAG_PALADIN = 5;
FW.FLAG_SHAMAN = 6;

FW.FLAG_NORMAL = 0;
FW.FLAG_UNKNOWN = 1;
FW.FLAG_DEAD = 2;
FW.FLAG_OFFLINE = 3;

FW.FILTER_NONE = 0;
FW.FILTER_HIDE = -1;
FW.FILTER_COLOR = -2;

local CLASS_ICONS = {
	["WARRIOR"]	= {0, 0.25, 0, 0.25},
	["MAGE"]	= {0.25, 0.49609375, 0, 0.25},
	["ROGUE"]	= {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"]	= {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"]	= {0, 0.25, 0.25, 0.5},
	["SHAMAN"]	= {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"]	= {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"]	= {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"]	= {0, 0.25, 0.5, 0.75},
};

FW.NIL = "";
FW.CHK = "FWCheckTemplate";
FW.MSG = "FWMessageTemplate";
FW.MS2 = "FWMessageTemplate2";
FW.TXT = "FWTextureTemplate";
FW.COL = "FWColorTemplate";
FW.NUM = "FWNumberTemplate";
FW.INF = "FWInfoTemplate";
FW.FNT = "FWFontTemplate";
FW.FIL = "FWFilterTemplate";
FW.PRO = "FWProfileTemplate";

FW.NON = 0;
FW.LEF = 1;
FW.RIG = 2;

FW.ICON_DEFAULT = "Interface\\GossipFrame\\BinderGossipIcon";
FW.ICON_PROFILE = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up";
FW.ICON_HINT = "Interface\\GossipFrame\\AvailableQuestIcon";
FW.ICON_APPEARANCE = "Interface\\Icons\\INV_Enchant_ShardPrismaticLarge";
FW.ICON_FILTER = "Interface\\Icons\\INV_Ingot_Eternium";
FW.ICON_BASIC = "Interface\\Buttons\\UI-CheckBox-Check-Disabled";
FW.ICON_SPECIFIC = "Interface\\Buttons\\UI-CheckBox-Check";
FW.ICON_SIZE = "Interface\\Minimap\\UI-Minimap-ZoomInButton-Up"

FW.ICON_CD = "Interface\\Icons\\Spell_Shadow_LastingAfflictions";
FW.ICON_HS = "Interface\\AddOns\\Forte_Core\\Textures\\HS1";
FW.ICON_SS = "Interface\\AddOns\\Forte_Core\\Textures\\SS1";
FW.ICON_SH = "Interface\\AddOns\\Forte_Core\\Textures\\SH1";
FW.ICON_SU = "Interface\\AddOns\\Forte_Core\\Textures\\SU1";
FW.ICON_ST = "Interface\\AddOns\\Forte_Core\\Textures\\ST";

--FW.ICON_TALENT = "Interface\\Buttons\\UI-MicroButton-Talents-Up";
FW.ICON_MESSAGE = "Interface\\GossipFrame\\PetitionGossipIcon";
FW.ICON_SELFMESSAGE = "Interface\\GossipFrame\\GossipGossipIcon";

--[[FW.C = {};
FW.C.DEFAULT = 		{0.55,0.00,0.88,0.50};
FW.C.COOLDOWN = 	{0.00,0.75,1.00,0.50};
FW.C.TIMER = 		{1.00,0.00,0.50,0.50};
FW.C.HEALTHSTONE = 	{0.55,0.00,0.88,0.50};]]

local FW_Options = {};
local Anchors = {};

local FW_FontList = {};

function FW:RegisterFont(path,name)
	tinsert(FW_FontList,{path,name});
end

function FW:SetDefaultFont(path,size)
	FW.Default.Font = path;
	FW.Default.FontSize = size;
end

FW:RegisterFont("Fonts\\ARIALN.TTF","Arial Narrow");
FW:RegisterFont("Fonts\\FRIZQT__.TTF","Friz Quadrata TT");
FW:RegisterFont("Fonts\\MORPHEUS.TTF","Morpheus");
FW:RegisterFont("Fonts\\SKURRI.TTF","Skurri");
FW:RegisterFont("Interface\\AddOns\\Forte_Core\\Fonts\\FORTE.TTF","Forte");
FW:SetDefaultFont("Fonts\\FRIZQT__.TTF",10);

local FW_TextureList = {
	"Interface\\AddOns\\Forte_Core\\Textures\\Xus",
	"Interface\\AddOns\\Forte_Core\\Textures\\Otravi",
	"Interface\\AddOns\\Forte_Core\\Textures\\Litestep",
	"Interface\\AddOns\\Forte_Core\\Textures\\Bantobar",
	"Interface\\AddOns\\Forte_Core\\Textures\\Charcoal",
	"Interface\\AddOns\\Forte_Core\\Textures\\Perl",
	"Interface\\AddOns\\Forte_Core\\Textures\\Smooth",
	"Interface\\AddOns\\Forte_Core\\Textures\\Smudge",
	"Interface\\AddOns\\Forte_Core\\Textures\\Striped",
	"Interface\\AddOns\\Forte_Core\\Textures\\Glaze",
	"Interface\\AddOns\\Forte_Core\\Textures\\Frost",
	"Interface\\AddOns\\Forte_Core\\Textures\\HealBot",
	"Interface\\AddOns\\Forte_Core\\Textures\\Rocks",
	"Interface\\AddOns\\Forte_Core\\Textures\\Runes",
	"Interface\\AddOns\\Forte_Core\\Textures\\Xeon",
	"Interface\\AddOns\\Forte_Core\\Textures\\SWSDefault",
	"Interface\\TargetingFrame\\UI-StatusBar",
	"Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
}


FW.Modules = {};
function FW:ClassModule(module)
	FW.ClassModules = module;
	return FW:Module(module);
end
function FW:Module(module)
	FW.Modules[module] = {};
	return FW.Modules[module];
end

local DeleteOld = 3600;

FW.GET_SHARDS = "SG";
FW.GET_HEALTHSTONE = "HG"
FW.SEND_HEALTHSTONE = "HS";
FW.SEND_SHARDS = "SH";

local SEND_VERSION = "VE"
local GET_VERSION = "VG";
local GET_SPECC = "SPG";
local SEND_SPECC = "SPS";

local LastRess;
local LeaveCombat;
local UILoaded;

local SynchBuffer = {};
local SynchBufferUpdate = -1;

FW.LastShardCheck = 0;
FW.LastHSCheck = 0;

FW.Healthstone = {};

FW.Zones = {};
FW.Ranks = {};
FW.Version = {};
FW.Ready = {};

FW.SetBonus = {};
FW.Talent = {};

--[[function FW:PrintTable(table)
	for key, val in pairs(table) do
		local str = ""
		for k, v in pairs(val) do
			str = str..v.." ";
		end
		FW:Show(key..": "..str);
	end
end]]

function FW:ShowTip()
	if this.tip and this.title then
		GameTooltip_AddNewbieTip(this.title, 1.0, 1.0, 1.0,this.tip);
	end
end

function FW:HideTip()
	HideUIPanel(GameTooltip);
end

function FW:Show(msg,r,g,b,a) DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b,a); end

function FW:ShowDebug(msg) if FW_Debug then FW:Show("Debug: "..msg,1,0.5,0); end end

local function FW_VersionCheck()
	FW:SendData(GET_VERSION);
end
local function FW_GetSpeccInfo()
	FW:SendData(GET_SPECC);
end

local function FW_HealthstoneSpecc(player)
	if FC_Saved.Speccs.WARLOCK and FC_Saved.Speccs.WARLOCK[player] then
		return tonumber(strsub(FC_Saved.Speccs.WARLOCK[player], strlen(FC_Saved.Speccs.WARLOCK[player])-1 ));
	else
		return 0;
	end
end

local function FW_HealthstoneRankByLevel(unit)
	if select(2,UnitClass(unit)) == "WARLOCK" then
		local level = UnitLevel(unit);
		if level < 10 then
			return 0;
		elseif 	level < 22 then
			return 1;
		elseif level < 34 then
			return 2;
		elseif level < 46 then
			return 3;
		elseif level < 58 then
			return 4;
		elseif level < 68 then
			return 5;
		else
			return 6;
		end
	else
		return 0;
	end
end

local function FW_HealthstoneRank()
	if FW.CLASS == "WARLOCK" then
		local high = 0;
		local spellName, spellRank;
		local i = 1
		
		while true do
			spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);

			if not spellName then break; end

			if spellName == FW.L.CREATE_HEALTHSTONE then
				_,_,spellRank = string.find(spellRank,FW.L.SPELL_RANK);
				spellRank = tonumber(spellRank);
				if spellRank > high then
					high = spellRank;
				end
			end
			i = i + 1;
		end
		return high;
	else
		return 0;
	end
end

local function FW_HealthstoneAdd(specc) -- adds a healstone type to track at the hs spy
	table.sort(FW.Healthstone);
	for k, v in ipairs(FW.Healthstone) do
		if v == specc then
			return;
		end
	end
	if #FW.Healthstone >= FW.Settings.HealthstoneNumber then
		if specc > FW.Healthstone[1] then
			FW.Healthstone[1] = specc;
		end
	else
		tinsert(FW.Healthstone,specc);
	end
end

function FW:CreateHealthstoneTypes() -- decides what types of healthstone to track based on warlock speccs, also called from healthstone module
	FW:ERASE(FW.Healthstone);
	local specc;
	
	for warlock, data in pairs(FC_Saved.Shards) do
		if data[2] == FC_Saved.Update then
			specc = FW_HealthstoneSpecc(warlock);
			while (specc > 0) do
				FW_HealthstoneAdd(specc);
				specc = specc - 3;
			end
		end
	end
	
	if FW.Settings.HealthstoneTopRank then
		local i = #FW.Healthstone;
		if i>0 then
			local top = FW.ID_HEALTHSTONE[ FW.Healthstone[i] ][5];
			while (i>0) do
				if FW.ID_HEALTHSTONE[FW.Healthstone[i]][5] < top then
					tremove(FW.Healthstone,i);
				end
				i=i-1;
			end
		end
	end
end

local function FW_MakeSpeccInfo(inspect) -- creates you own specc information string, or that of someone you're inspecting
	local player,class,hsrank;
        if inspect then
        	if not InspectFrame or not InspectFrame.unit then return; end -- avoid saving wrong speccs to the wrong ppl for now!!
        	player = UnitName("target");
        	class = select(2,UnitClass("target"));
		if not player or not class or (not UnitInParty("target") and not UnitInRaid("target")) or player == FW.PLAYER then return;end
		hsrank = FW_HealthstoneRankByLevel("target");
	else
		player = FW.PLAYER;
		class = FW.CLASS;
		hsrank = FW_HealthstoneRank();
	end
	--FW:Show("building talents for "..player);
	local currentRank;
	local str = "";
	for tab=1,GetNumTalentTabs(inspect),1 do
		for i=1,GetNumTalents(tab,inspect),1 do
			currentRank = ( select( 5,GetTalentInfo(tab,i,inspect) ) );
			if currentRank > 0 then
				str = str..string.format("%02d",i)..currentRank;
			end
		end
		str=str.." ";
	end
	if not FC_Saved.Speccs[class] then
		FC_Saved.Speccs[class] = {};
	end
	if hsrank == 0 then
		FC_Saved.Speccs[class][player] = str.."00";
	else
		FC_Saved.Speccs[class][player] = str..string.format( "%02d", 3*hsrank+select(5,GetTalentInfo(2,1,inspect))-2 );
	end
	FW:CreateHealthstoneTypes();
	-- will later use the last digits for other classes as well, for now it's always zero for non-warlocks
end

----------------------------------------------------------------------------------------------------------------------------
--------- STUFF TO MINIMIZE TABLE MEMORY GARBAGE SINCE I LIKE TO USE '2D' TABLES A LOT -------------------------------------
----------------------------------------------------------------------------------------------------------------------------

local r1,r2,val1,val2;

local function FW_SWAPO(t) -- optimized a bit
	for c=1,t.columns,1 do
		t[r1+c],t[r2+c] = t[r2+c],t[r1+c];
	end
end

local function FW_BSTR(t,i,j,c,asc,a)
	r1=(j-2)*t.columns;
	r2=(j-1)*t.columns;
	val1 = t[ r1+c[a] ];
	val2 = t[ r2+c[a] ];
	if asc[a] == 1 and val1 > val2 or asc[a] == 0 and val1 < val2 then
		FW_SWAPO(t)
		return;
	end
	if val1 == val2 and c[a+1] then		
		FW_BSTR(t,i,j,c,asc,a+1);
	end
end

function FW:BST(t,c,asc) -- sorts my '2d table'
	if not t.columns or not t.rows then return; end
	--local time= GetTime()
	local i = 1;
	local j;
	while i <= t.rows do
		j = t.rows;
		while i<j do
			FW_BSTR(t,i,j,c,asc,1);
			j=j-1;
		end
		i=i+1;
	end
	--FW:Show(GetTime()-time);
end

function FW:INSERT(t,...) -- insert a new row in my '2d table' with ... columns
	t.columns = select("#",...);
	for i=1,t.columns,1 do
		tinsert(t,(select(i,...)));
	end
	t.rows = #t/t.columns;
end

function FW:FIND(t,v,c) -- find value v in '2d table' t at column c (first if nil) returns _index_ !
	if not t.columns then return; end
	if not c then c = 1; end
	for i=c,#t,t.columns do
		if t[i] == v then 
			return i;
		end
	end
	return nil;
end

function FW:FIND2(t,v1,c1,v2,c2) -- returns the index of c2/v2
	if not t.columns then return; end
	c1=c2-c1;
	for i=c2,#t,t.columns do
		if t[i-c1] == v1 and t[i] == v2 then 
			return i;
		end
	end
end

local function FW_RowMatch(t,i,...)
	local index;
	for j=2,select("#",...),2 do
		index = i + (select(j,...));
		if t[index] ~= (select(j-1,...)) then
			return nil;
		end
	end
	return index;
end

function FW:FINDN(t,...) -- returns the index of last
	if not t.columns then return; end
	for i=1,t.columns,1 do
		local match = FW_RowMatch(t,(i-1)*t.columns,...);
		if match then return match; end
	end
end

function FW:GET(t,r,c)  -- gets an element from my '2d table' if c column is nil it will return every val in this row :D
	--if not t.columns or not r or r>t.rows then return; end
	if c then
		--if c>t.columns then return; end
		return t[(r-1)*t.columns+c];
	else
		return unpack(t,(r-1)*t.columns+1,r*t.columns);
	end
end

function FW:SET(t,r,c,v) -- sets an element in my '2d table'
	--if not t.columns or not c or not r then return; end
	t[(r-1)*t.columns+c] = v;
end

function FW:REMOVE(t,r) -- remove row r
	local i=(r-1)*t.columns+1
	for n=1,t.columns,1 do
		table.remove(t,i);
	end
	t.rows = #t/t.columns;
end

function FW:REMOVE_INDEX(t,index)
	FW:REMOVE(t,math.ceil(index/t.columns));
end

function FW:ERASE(t) -- erases any table
	for k in pairs(t) do
		if type(t[k])=="table" then
			FW:ERASE(t[k]);
		end
		t[k]= nil;
	end
end

function FW:ROWS(t) -- get num rows of my '2d table'
	return t.rows or 0;
end

function FW:SETKEY(t,k,...) -- Set a row with 'key', MUST have the same num columns!
	local n = FW:FIND(t,k,1);
	if n then
		for i=1,select("#",...),1 do
			t[n+i] = (select(i,...));
		end
	else
		FW:INSERT(t,k,...);
	end
end

function FW:TO_ROW(t,index)
	return math.ceil(index/t.columns);
end

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
local function FW_EnterCombat()
	--FW:ShowDebug("enter combat");
	for i,f in ipairs(FW_OnEnterCombat) do
		f();
	end
end
local function FW_LeaveCombat()
	--FW:ShowDebug("leave combat");
	for i,f in ipairs(FW_OnLeaveCombat) do
		f();
	end
end

local function FW_Ress()
	if not UnitIsDeadOrGhost("player") and not LastRess then
		LastRess = GetTime()+5; -- wait 5 seconds with checking combat
	end
end


--[[function FW:ShowTable(t)
	local str,n = "1: ",1;
	for i=1,#t,1 do
		str=str..t[i].." ";
		if i%t.columns == 0 then
			FW:Show(str);
			n=n+1;
			str=n..": ";
		end
	end
end]]

---------------------------------------------------------------------------

function FW:OnEvent(event)
	--[[if event~="CHAT_MSG_ADDON" then
	local debug = GetTime().." "..event;
	if arg1 then debug = debug.." 1:"..tostring(arg1); end
	if arg2 then debug = debug.." 2:"..tostring(arg2); end
	if arg3 then debug = debug.." 3:"..tostring(arg3); end
	if arg4 then debug = debug.." 4:"..tostring(arg4); end
	if arg5 then debug = debug.." 5:"..tostring(arg5); end
	if arg6 then debug = debug.." 6:"..tostring(arg6); end
	if arg7 then debug = debug.." 7:"..tostring(arg7); end
	if arg8 then debug = debug.." 8:"..tostring(arg8); end
	if arg9 then debug = debug.." 9:"..tostring(arg9); end
	if arg10 then debug = debug.." 10:"..tostring(arg10); end
	if arg11 then debug = debug.." 11:"..tostring(arg11); end
	if arg12 then debug = debug.." 12:"..tostring(arg12); end
	if arg13 then debug = debug.." 13:"..tostring(arg13); end
	if arg14 then debug = debug.." 14:"..tostring(arg14); end
	if arg15 then debug = debug.." 15:"..tostring(arg15); end
	if arg16 then debug = debug.." 16:"..tostring(arg16); end
	if arg17 then debug = debug.." 17:"..tostring(arg17); end
	if arg18 then debug = debug.." 18:"..tostring(arg18); end
	if arg19 then debug = debug.." 19:"..tostring(arg19); end
	FW:Show(debug,0,1,1);
	end]]
	
	if FW_Events[event] then 
		for k,v in ipairs(FW_Events[event]) do
			v(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
		end
	end
end

------------------------------------------------------------------------------------------------------------------
local FW_Scans = {};
--FW.Online = {};

local function FW_ScanUnit(unit,update)
	local unitName = UnitName(unit);
	local _, unitClass = UnitClass(unit);
	local flag;
	if UnitIsConnected(unit) then
		if UnitIsDeadOrGhost(unit) then	
			flag = FW.FLAG_DEAD;
		else
			flag = FW.FLAG_NORMAL;
		end
	else
		flag = FW.FLAG_OFFLINE;
	end
	
	for i,f in ipairs(FW_Scans) do
		f(unit,unitName,unitClass,flag,update);
	end
end

local function FW_Scan()
	
	local update = GetTime();
	--
	for k in pairs(FW.Ready) do
		FW.Ready[k][2] = -1;
	end
	FW:RosterInfo();
	
	-- ss scan, raid or party
	if GetNumRaidMembers() > 0 then	
		-- Do scans
		for i=1,GetNumRaidMembers(),1 do
			FW_ScanUnit(FW.RAID[i],update);
		end
	else
		if GetNumPartyMembers() > 0 then
			for i=1,GetNumPartyMembers(),1 do
				FW_ScanUnit(FW.PARTY[i],update);
			end
		end
		FW_ScanUnit("player",update);
	end
	FC_Saved.Update = update; 
	-- updating raw data complete
end

local function FW_ShardScan(unit,unitName,unitClass,flag,update)
	
	if FW:IsWarlock(unit) then

		if not FC_Saved.Shards[unitName] then
			FC_Saved.Shards[unitName] = {-1,update,FW.FLAG_NORMAL};
		end
		FC_Saved.Shards[unitName][2] = update;
		FC_Saved.Shards[unitName][3] = flag;
	end
end

local function FW_HealthstoneScan(unit,unitName,unitClass,flag,update)
	if not FC_Saved.Healthstone[unitName] then
		FC_Saved.Healthstone[unitName] = {};
		FC_Saved.Healthstone[unitName][0] = update;
	end
	if flag ~= FW.FLAG_OFFLINE then FC_Saved.Healthstone[unitName][0] = update;end
end

function FW:Load()
	SlashCmdList["FORTECLASS"] = function(msg)
		local s = strsplit(" ",msg);
		if Commands[s] then
			Commands[s]( strsub(msg,strlen(s)+2) );
		else
			FWOptions:Show();
		end
	end
	
	SLASH_FORTECLASS1 = "/fw";
	SLASH_FORTECLASS2 = "/fortewarlock";
	SLASH_FORTECLASS3 = "/fc";
	SLASH_FORTECLASS4 = "/forteclass";

	FW:RegisterEvents();
end

--[[FW.OldIsConsumableAction = IsConsumableAction;
function FW:IsConsumableAction(action)
	if FW.Settings.BlockShardReagent and ( GetActionInfo(action) ) == "spell" then
		return nil;
	else
		return FW.OldIsConsumableAction(action);
	end
end

function FW:ActionButton_UpdateCount()
	local text = getglobal(this:GetName().."Count");
	local action = ActionButton_GetPagedID(this);
	if not IsStackableAction(action) and (FW.Settings.BlockShardReagent and (GetActionInfo(action))=="spell" or not IsConsumableAction(action)) then
		text:SetText("");
	end
end]]

local SpecialSaved = {};
local function FW_Reset()
	for k, v in pairs(SpecialSaved) do
		if v==true then
			FW:ERASE(FC_Saved[k]);
		end
	end
end
local function FW_ResetOld(time)
	for key, val in pairs(SpecialSaved) do
		if val==true then
			for k, v in pairs(FC_Saved[key]) do
				if type(v)=="table" then
					if (v[0]) then
						if(time-v[0] > 900) then
							FC_Saved[key][k] = nil;
						end
					elseif (v[2]) then
						if (time-v[2] > DeleteOld) then
							FC_Saved[key][k] = nil;
						end
					end
				elseif (time-FC_Saved.Update > DeleteOld) then
					FC_Saved[key][k] = nil;
				end
			end
		end
	end
end

local function FW_RefreshAllFilters()
	for i,f in ipairs(FilterRefresh) do
		f();
	end
end

local function FW_InitConfig2(from,to)
	for key, val in pairs(from) do
		
		if type(val) == "table" then
			if to[key] == nil or type(to[key]) ~= "table" then
				to[key] = {};
			end
			FW_InitConfig2(val,to[key]);
		else
			if to[key] == nil then
				to[key] = val;
			end
		end
	
	end
end

local function FW_InitConfig3(from,to) -- copies old saved data to the new profile format
	for key, val in pairs(from) do
		if SpecialSaved[key] == nil then
			if type(val) == "table" then
				if to[key] == nil or type(to[key]) ~= "table" then
					to[key] = {};
				end
				FW_InitConfig2(val,to[key]);
			else
				if to[key] == nil then
					to[key] = val;
					
				end
			end
			from[key] = nil;
		end
	end
end

local function FW_InitConfig()
	if FC_Saved.Profiles == nil then 
		FC_Saved.Profiles = {};
		FC_Saved.Profiles["Default"] = {};
		FW_InitConfig3(FC_Saved,FC_Saved.Profiles["Default"]);
		FC_Saved.PROFILE = "Default";
	end
	if FC_Saved.Profiles[FW.PLAYER.." "..FW.SERVER] then
		FW:UseProfile(FW.PLAYER.." "..FW.SERVER,1);
	elseif FC_Saved.Profiles[strlower(FW.PLAYER).." "..strlower(FW.SERVER)] then
		FW:UseProfile(strlower(FW.PLAYER).." "..strlower(FW.SERVER),1);
	
	elseif FC_Saved.Profiles[FW.CLASS] then
		FW:UseProfile(FW.CLASS,1);
	elseif FC_Saved.Profiles[strlower(FW.CLASS)] then
		FW:UseProfile(strlower(FW.CLASS),1);
	else
		FW:UseProfile(FC_Saved.PROFILE,1);
	end
end


local function FW_Variables()
	local time = GetTime();
	
	if FW_Saved then
		FW_InitConfig2(FW_Saved,FC_Saved);
		
		DisableAddOn("ForteWarlock");
--		FW:Show("|cffff0000IMPORTANT|r YOUR OLD FORTEWARLOCK SETTINGS HAVE BEEN COPIED, IT WILL BE DISABLED ON RELOAD. DISABLE IT FOR ALL CHARACTERS THE NEXT TIME YOU LOG IN.",1,1,0);
	end -- copy my old setting from ForteWarlock
	
	FW:RegisterSpecialSaved("Profiles",false,nil);
	FW:RegisterSpecialSaved("VERSION",false,"");
	FW:RegisterSpecialSaved("RAID",false,false);
	FW:RegisterSpecialSaved("PARTY",false,false);
	FW:RegisterSpecialSaved("SCALE",false,1);
	FW:RegisterSpecialSaved("PROFILE",false,"");
	FW:RegisterSpecialSaved("Speccs",false,{});
	FW:RegisterSpecialSaved("Exceptions",false,{});
	FW:RegisterSpecialSaved("Update",false,0);
	
	FW:RegisterSpecialSaved("GotORA",true,{});
	
	FW:RegisterSpecialSaved("Timers",true,{});
	FW:RegisterSpecialSaved("Warlocks",true,{});
	FW:RegisterSpecialSaved("Cooldowns",true,{});
	FW:RegisterSpecialSaved("Shards",true,{});
	FW:RegisterSpecialSaved("Healthstone",true,{});

	
	FW_InitConfig2(FW.Exceptions,FC_Saved.Exceptions);
	
	FW_InitConfig();
	
	for i,f in ipairs(FW_VariablesLoaded) do
		f();
	end
	
	FW:Show("Forte Class Addon "..VERSION.." by Xus - "..FC_Saved.PROFILE.." - /fw for options",0,1,0);
	FW:Show("Class Module: "..FW.ClassModules.." - Modules: "..FW:Size(FW.Modules),0,1,0);
	
	FW:ShowDebug("Warning: Debug mode is on!");
	
	if FC_Saved.VERSION ~= VERSION then -- version change
		if FC_Saved.VERSION < "v0.98" then
			for profile, data in pairs(FC_Saved.Profiles) do -- replace the font/texture paths from ForteWarlock with Forte_Core
				for k, v in pairs(data) do
					if type(v) == "string" then
						FC_Saved.Profiles[profile][k] = string.gsub(v,"ForteWarlock","Forte_Core",1);
					end
				end
			end
		end
		FC_Saved.VERSION = VERSION;
	end
	
	if FC_Saved.Update > time then -- pc rebooted, have to clear all timers
		FW_Reset();
	else
		FW_ResetOld(time);
	end

	FW:RegisterFrame("FWOptions");
	
	if FW.Settings.SafeBlockShardReagent then
		--Standard UI
		--hooksecurefunc("ActionButton_UpdateCount", FW.ActionButton_UpdateCount);
	else
		-- unsafe way for non-standard ui
		--IsConsumableAction = FW.IsConsumableAction;
	end
	
	
	FW.Version[FW.PLAYER] = VERSION;
end

function FW:RegisterEnterPartyRaid(func)
	tinsert(FW_EnterPartyRaid,func);
end

local function FW_PartyRaid() -- also run on ui load plx!
	for i,f in ipairs(FW_EnterPartyRaid) do
		f();
	end
end

local function FW_TimedRaidParty()
	local t1, t2 = IsInInstance();
	local t3, t4;
	if t1 and t2 ~= "raid" and t2 ~= "party" then -- switch everything raid related off if we're inside a battleground
		t3 = false;t4 = false;
	else
		t3 = GetNumRaidMembers()>0;
		t4 = GetNumPartyMembers()>0;
	end
	if FC_Saved.RAID ~= t3 then
		FC_Saved.RAID = t3;
		if not FC_Saved.PARTY and FC_Saved.RAID then
			FW_PartyRaid();
		end
		
	end
	if FC_Saved.PARTY ~= t4 then
		FC_Saved.PARTY = t4;
		if not FC_Saved.RAID and FC_Saved.PARTY then
			FW_PartyRaid();
		end
	end
end

local function FW_TimedClearBuffers()
  	if SynchBufferUpdate >= 5 then
		SynchBufferUpdate = -1;
		FW:ERASE(SynchBuffer);--
	elseif SynchBufferUpdate ~= -1 then -- -1 means do nothing
		SynchBufferUpdate = SynchBufferUpdate + 1;
	end
end

local function FW_UpdateCore()
	if LastRess and LastRess <= GetTime() then -- delays combat checking when you're ressed, so in case of a combat res or ss use your timers wont be cleared instantly
		if not InCombatLockdown() then FW_LeaveCombat(); end
		LastRess = nil;
	end
	if LeaveCombat then -- this is only used when zoning, to make sure buttons arent still locked when FW_LeaveCombat is called
		if not InCombatLockdown() then FW_LeaveCombat(); end
		LeaveCombat = nil;
	end
	
	-- run the timed events
	for key, val in pairs(FW_Timed) do
		FW_Timed[key][0] = FW_Timed[key][0] + arg1;
		if FW_Timed[key][0] >= key then
			FW_Timed[key][0] = FW_Timed[key][0]%key;
			for k, v in ipairs(FW_Timed[key]) do
				v();
			end
		end
	end
			
end

function FW:OnUpdate()
	
	if ENABLE then
		for i, f in ipairs(FW_Updated) do
			f();
		end
	else
		if UILoaded then -- enable update actions 2 sec after UI is fully loaded
			--FW:Show(GetTime() - UILoaded);
			
			if GetTime() - UILoaded >= FW.Settings.LoadDelay then
			
				ENABLE = true;-- do stuff when the addon is fully enabled!
				for i, f in ipairs(FW_DelayedLoaded) do
					f();
				end

			end
		else
			UILoaded = GetTime();
		end	
	end
end

local function FW_RelevantTalent()
	for tab=1,GetNumTalentTabs(),1 do
		for i=1,GetNumTalents(tab),1 do
			local name, _, _, _, rank = GetTalentInfo(tab, i);
			if FW.Talent[name] then
				FW.Talent[name] = rank;
			end
		end
	end
end

local function FW_RelevantSetBonus()
	for k, v in pairs(FW.SetBonus) do
		FW.SetBonus[k] = 0;
	end
	local t1;
	for i=1,12,1 do -- from head to 2nd ring
		t1 = GetInventoryItemLink("player", i);
		if t1 then
			for k,v in pairs(FW.SetBonus) do
				if string.find(t1,k) then
					FW.SetBonus[k] = FW.SetBonus[k] + 1;
				end
			end
		end
	end
end

function FW:UnitHasBuff(unit,buff) -- returns 1 or nil
	local b = 1;
	local name;
	while true do
		name = UnitBuff(unit,b);
		if name then
			if name == buff then
				return 1;
			end
			b=b+1;
		else
			return nil;
		end
	end
end

function FW:UnitHasDebuff(unit,buff,texture) -- returns buff index
	local b = 1;
	local d,t;--debuff name, texture
	while true do
		d,_,t = UnitDebuff(unit,b);
		if d then
			if d == buff and (not texture or texture == t) then
				return b;
			end
			b=b+1;
		else
			return nil;
		end
	end
end

function FW:UnitHasYourDebuff(unit,buff) -- returns time left
	local b = 1;
	local d,y,t;--debuff name, yours/total, time left
	while true do
		d,_,_,_,_,y,t = UnitDebuff(unit,b);
		if d then
			if y and d == buff then
				return t;
			end
			b=b+1;
		else
			return nil;
		end
	end
end

function FW:PlayerHasBuff(buff) -- returns buff index
	local b = 1;
	local name;
	while true do
		name = GetPlayerBuffName(b)
		if name then
			if name == buff then
				return b;
			end
			b=b+1;
		else
			return nil;
		end
	end
	
end

function FW:SecToTimeD(t)
	if FW.Settings.TimeFormat then
		if t >= 60 then 
			return math.floor(t/60)..":"..string.format("%02d",t%60);
		else
			return string.format("%.1f",t);
		end
	else
		if t >= 60 then return ceil(t/60).."m";else return string.format("%.1f",t).."s"; end
	end
end

function FW:SecToTime(t)
	if FW.Settings.TimeFormat then
		return math.floor(t/60)..":"..string.format("%02d",t%60);
	else
		if t >= 60 then return ceil(t/60).."m"; else return floor(t).."s";end
	end
end

function FW:NameToRaidID(name)
	for i=1,GetNumRaidMembers(),1 do
		if name == UnitName(FW.RAID[i]) then
			return FW.RAID[i];
		end
	end
end
function FW:NameToPartyID(name)
	for i=1,GetNumPartyMembers(),1 do
		if name == UnitName(FW.PARTY[i]) then
			return FW.PARTY[i];
		end
	end
end
function FW:NameToID(name)
	if name == FW.PLAYER then return "player";end
	for i=1,GetNumRaidMembers(),1 do
		if name == UnitName(FW.RAID[i]) then
			return FW.RAID[i];
		end
	end
	for i=1,GetNumPartyMembers(),1 do
		if name == UnitName(FW.PARTY[i]) then
			return FW.PARTY[i];
		end
	end
end



function FW:RosterInfo()
	if not FC_Saved.RAID then return; end
	local t1,t2,t3;
	for i=1,40,1 do
		t1, t2, _, _, _, _, t3 = GetRaidRosterInfo(i);
		if t1 then
			FW.Ranks[t1] = t2;
			FW.Zones[t1] = t3;
		end
	end
end

function FW:IsWarlock(unit)
	local _,unitClass = UnitClass(unit);
	if unitClass == "WARLOCK" then return 1;end
end

function FW:GotSoulstone() -- returns the name of the best ss in your inventory
	for i=#FW.ID_SOULSTONE ,1,-1 do
		if GetItemCount(FW.ID_SOULSTONE[i][2]) ~= 0 then
			return FW.ID_SOULSTONE[i][1];
		end
	end
end

function FW:GotShards() -- returns number of shards
	return GetItemCount(FW.ID_SOULSHARD);
end


function FW:BestSoulstone() -- returns name of best soulstone you can create, ising in cooldown and soulstone module
	if FW.CLASS == "WARLOCK" then
		local i = 1
		local high = 1;
		local spellName, spellRank;
		while true do
			spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
			if not spellName then break; end
			if spellName == FW.L.CREATE_SOULSTONE then
				_,_,spellRank = string.find(spellRank,FW.L.SPELL_RANK);
				spellRank = tonumber(spellRank);
				if spellRank > high then
					high = spellRank;
				end
			end
			i = i + 1;
		end
		return FW.ID_SOULSTONE[high][1];
	else
		return FW.L.NONE;
	end
end

function FW:GotThisHealthstone(healthstone) -- returns the best hs of this name
	for i=#FW.ID_HEALTHSTONE,1,-1 do
		if FW.ID_HEALTHSTONE[i][1] == healthstone then
			if GetItemCount(FW.ID_HEALTHSTONE[i][2]) ~= 0 then
				return FW.ID_HEALTHSTONE[i][2],FW.ID_HEALTHSTONE[i][3];
			end
		end
	end
end

function FW:GotHealthstone() -- returns the name of the best hs in your inventory
	for i=#FW.ID_HEALTHSTONE,1,-1 do
		if GetItemCount(FW.ID_HEALTHSTONE[i][2]) ~= 0 then
			return FW.ID_HEALTHSTONE[i][1],FW.ID_HEALTHSTONE[i][3];
		end
	end
end

function FW:BestHealthstone()
	if FW.CLASS == "WARLOCK" then
		local index = FW_HealthstoneSpecc(FW.PLAYER);
		local high = math.ceil(index/3);
		return FW.ID_HEALTHSTONE[index][1],index,high;
	else
		return FW.L.NONE,0,0;
	end
end

--[[
function FW:TimeStart()
	FW.StartTime = GetTime();
end

function FW:TimeEnd(label)
	FW:Show(label..": "..(GetTime()-FW.StartTime),0,0,1);
end]]

local function FW_SendVersion()
	FW:SendData(SEND_VERSION..VERSION);
end


local function FW_SendSpeccInfo()
	if FC_Saved.Speccs[FW.CLASS] and FC_Saved.Speccs[FW.CLASS][FW.PLAYER] then
		FW:SendData(SEND_SPECC..FC_Saved.Speccs[FW.CLASS][FW.PLAYER]);
	--else
		--FW:Show("failed to send");
	end
end

local function FW_SynchBufferOut(msg,from)
	FW:ShowDebug("New Synched "..from..": "..msg);
	for i,d in ipairs(FW_Messages) do
		if string.find(msg,d[1]) then
			--FW:ShowDebug("Running function for "..d[1]);
			d[2]( strsub(msg,strlen(d[1])), from );
			return;
		end
	end
end

local function FW_SynchBufferIn(msg,from,self)
	if not self and from == FW.PLAYER then return; end -- ignore message from yourself by default
	for i,d in ipairs(FW_Messages) do
		if string.find(msg,d[1]) then
			if d[3] then -- messages that need to be merged, rest are always 'unique' --
				SynchBufferUpdate = 0;
				local index = FW:FIND(SynchBuffer,msg,2);-- might not be worth the cpu cost tbh
				if index then
					local f,m,n;

					index = FW:FIND2(SynchBuffer,from,1,msg,2);
					if index then
						SynchBuffer[index+1] = SynchBuffer[index+1] + 1;
						for i=1,FW:ROWS(SynchBuffer),1 do
							f,m,n =  FW:GET(SynchBuffer,i);
							if f ~= from and SynchBuffer[index+1] <= n and m == msg then
								return;
							end
						end
					else
						FW:INSERT(SynchBuffer, from,msg,1);
						for i=1,FW:ROWS(SynchBuffer),1 do
							f,m,n =  FW:GET(SynchBuffer,i);
							if f ~= from and n>=1 and m == msg then
								return;
							end
						end
					end
				else
					FW:INSERT(SynchBuffer, from,msg,1);
				end	
			end
			FW_SynchBufferOut(msg,from);
			return;
		end
	end
	FW:ShowDebug("Unknown Synched "..from..": "..msg);
end

local function FW_AddonMessage()

	if arg1 == PREFIX then
		FW_SynchBufferIn(arg2,arg4);
		--FW:Show(arg4..": "..arg2,0,1,1);
	elseif arg1 == "oRA" or arg1 == "CTRA" then
		--[[local debug = GetTime().." "..event;
		if arg1 then debug = debug.." "..tostring(arg1); end
		if arg2 then debug = debug.." "..tostring(arg2); end
		if arg3 then debug = debug.." "..tostring(arg3); end
		if arg4 then debug = debug.." "..tostring(arg4); end
		if arg5 then debug = debug.." "..tostring(arg5); end
		if arg6 then debug = debug.." "..tostring(arg6); end
		if arg7 then debug = debug.." "..tostring(arg7); end
		if arg8 then debug = debug.." "..tostring(arg8); end
		if arg9 then debug = debug.." "..tostring(arg9); end
		FW:Show(debug,0,1,1);]]
		local found,t1,t2;
		for i,d in ipairs(FW_oRAMessages) do
			if not d[3] or not FW.Version[f] then --check only receive from ora if this player doesnt have fw
				found,_,t1,t2 = string.find(arg2,d[1]);
				if found then
					--FW:ShowDebug("Running function for "..d[1]);
					if d[2]( t1,t2, arg4 ) then return;end; -- stop looking if function actually returns something

				end
			end
		end
	end
end

--------------------------------------------
function FW:SendMergedData(msg)
	FW_SynchBufferIn(msg,FW.PLAYER,true); -- dont wait for data channel with messages sent by self
	SendAddonMessage(PREFIX,msg,"RAID");
end

function FW:SendData(msg)
	FW_SynchBufferOut(msg,FW.PLAYER);
	SendAddonMessage(PREFIX,msg,"RAID");
end
--------------------------------------------

--[[function FW:ORAItemCheckDisabled()
	if oRA and oRA.consoleOptions.args["item"] and oRA.consoleOptions.args["item"].args["disableItem"] and oRA.consoleOptions.args["item"].args["disableItem"].get then 
		return oRA.consoleOptions.args["item"].args["disableItem"].get();
	else
		return true;
	end
end]]

function FW:CheckHealthstone()
	local master = FW:Master();
	if master then
		for who in pairs(FC_Saved.Healthstone) do
			if FC_Saved.Healthstone[who][0]==FC_Saved.Update and not FW.Version[who] and FC_Saved.GotORA[who]==1 then
				
				for k, v in ipairs(FW.Healthstone) do
					FC_Saved.Healthstone[who][v] = 0;
				end
			end
		end
		if master == FW.PLAYER then
			-- fix to an oRA error
			if oRA and oRA.consoleOptions.args["item"] and oRA.consoleOptions.args["item"].handler then 
				for k, v in ipairs(FW.Healthstone) do
					oRA.consoleOptions.args["item"].handler:PerformItemCheck(tostring(FW.ID_HEALTHSTONE[v][2]));
				end
				oRA:CloseWindow();
			elseif  oRA and oRA.consoleOptions.args["item"] and oRA.consoleOptions.args["item"].args["check"] and oRA.consoleOptions.args["item"].args["check"].handler then 
				for k, v in ipairs(FW.Healthstone) do
					oRA.consoleOptions.args["item"].args["check"].handler:PerformItemCheck(tostring(FW.ID_HEALTHSTONE[v][2]));
				end
				oRA:CloseWindow();
			else
				for k, v in ipairs(FW.Healthstone) do
					SendAddonMessage("CTRA",FW.ORA_ITEM_REQUEST_SHORT..FW.ID_HEALTHSTONE[v][2],"RAID");
				end				
			end
		end
	end
end

function FW:CheckShards()
	local master = FW:Master();
	for who in pairs(FC_Saved.Shards) do
		if master and FC_Saved.Shards[who][3]~=FW.FLAG_OFFLINE and not FW.Version[who] and FC_Saved.GotORA[who]==1 then
			FC_Saved.Shards[who][1] = 0;
		end
	end
	if FW.CLASS == "WARLOCK" then FW:SendShards(FW:GotShards()); end
	
	if master == FW.PLAYER then
		-- fix to an oRA error
		if oRA and oRA.consoleOptions.args["item"] and oRA.consoleOptions.args["item"].handler then 
			oRA.consoleOptions.args["item"].handler:PerformItemCheck(tostring(FW.ID_SOULSHARD));
			oRA:CloseWindow();
		elseif oRA and oRA.consoleOptions.args["item"] and oRA.consoleOptions.args["item"].args["check"] and oRA.consoleOptions.args["item"].args["check"].handler then 
			oRA.consoleOptions.args["item"].args["check"].handler:PerformItemCheck(tostring(FW.ID_SOULSHARD));
			oRA:CloseWindow();
		else
			SendAddonMessage("CTRA",FW.ORA_SHARD_REQUEST,"RAID");
		end
		
	end
end

-- still want to reply to shards/healstonew requests no matter hwat modules are loaded
function FW:SendShards(n)
	SendAddonMessage(PREFIX,FW.SEND_SHARDS..n,"RAID");--can completely ignore this yourself
end

function FW:SendHealthstone(index,n)
	SendAddonMessage(PREFIX,FW.SEND_HEALTHSTONE..index.." "..n,"RAID");--can completely ignore this yourself
end

---------------------------------------------------------------------------
-- register functions
---------------------------------------------------------------------------

function FW:RegisterORAMessage(start,func,ignorewithfw) -- note that the ora message recognition needs the function to give a return value to stop/break early
	tinsert(FW_oRAMessages,{"^"..start,func,ignorewithfw});
end

function FW:RegisterMessage(start,func,merge) -- will always stop/break when a prefix match is found at this time
	tinsert(FW_Messages,{"^"..start,func,merge});
end

function FW:RegisterSpecialSaved(saved,reset,default)
	SpecialSaved[saved] = reset;
	if FC_Saved[saved]==nil then  FC_Saved[saved] = default; end
end

function FW:RegisterFilterRefresh(func)
	tinsert(FilterRefresh,func);
end

-- the normal events aren't accurate enough in case of zoning for instance
function FW:RegisterOnLeaveCombat(func)
	tinsert(FW_OnLeaveCombat,func);
end
function FW:RegisterOnEnterCombat(func)
	tinsert(FW_OnEnterCombat,func);
end

function FW:RegisterScan(func)
	tinsert(FW_Scans,func);
end

function FW:AddCommand(k,f)
	Commands[k] = f;
end

function FW:RegisterFrame(frame,showfunc,savename)
	tinsert(FW_Frames,{frame,showfunc,savename});
end

function FW:RegisterToEvent(event,func)
	if not FW_Events[event] then
		FCUpdateFrame:RegisterEvent(event);
		FW_Events[event] = {};
	end
	for i,f in ipairs(FW_Events[event]) do
		if f == func then
			return;
		end
	end
	tinsert(FW_Events[event],func);
end

function FW:UnregisterToEvent(event,func)
	if not FW_Events[event] then return; end
	for i,f in ipairs(FW_Events[event]) do
		if f == func then
			tremove(FW_Events[event],i);
			if #FW_Events[event]==0 then
				FW_Events[event] = nil;
				FCUpdateFrame:UnregisterEvent(event);
			end
			return;
		end
	end
end

function FW:RegisterVariablesEvent(func)
	tinsert(FW_VariablesLoaded,func);
end

function FW:RegisterUpdatedEvent(func)
	tinsert(FW_Updated,func);
end

function FW:RegisterLoadEvent(func)
	tinsert(FW_Loaded,func);
end

function FW:RegisterDelayedLoadEvent(func)
	tinsert(FW_DelayedLoaded,func);
end

function FW:RegisterTimedEvent(interval,func)
	if type(interval) == "string" then
		if FW.Settings[interval] then
			interval = FW.Settings[interval];
		else
			FW:Show("error adding interval: "..interval);
		end
	end
	if not FW_Timed[interval] then
		FW_Timed[interval] = {[0]=0};
	end
	tinsert(FW_Timed[interval],func);
end

---------------------------------------------------------------------------
-- some local frame functions
---------------------------------------------------------------------------
local function FW_GetHeight(frame)
	return frame:GetHeight()*frame:GetEffectiveScale();
end

local function FW_GetWidth(frame)
	return frame:GetWidth()*frame:GetEffectiveScale();
end

local function FW_GetTop(frame)
	return frame:GetTop()*frame:GetEffectiveScale();
end

local function FW_GetBottom(frame)
	return frame:GetBottom()*frame:GetEffectiveScale();
end

local function FW_GetLeft(frame)
	return frame:GetLeft()*frame:GetEffectiveScale();
end

local function FW_GetRight(frame)
	return frame:GetRight()*frame:GetEffectiveScale();
end

local function FW_GetCenter(frame) -- used in options.lua too
	local x,y = frame:GetCenter()
	return x*frame:GetEffectiveScale(),y*frame:GetEffectiveScale();
end

local function FW_RefreshFrames()
	for i,f in ipairs(FW_Frames) do
		if f[2] then f[2](); end
	end
end
local function FW_SetPosition(frame,x,y)

	frame:ClearAllPoints();
	frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x/frame:GetEffectiveScale(), y/frame:GetEffectiveScale());
end

local function FW_InitFramePositions(onload)
	if not onload then
		for i,f in ipairs(FW_Frames) do	

			if not FW.Settings[f[1]] then
				FW.Settings[f[1]] = {};
				FW.Settings[f[1]].x,FW.Settings[f[1]].y = FW_GetCenter( getglobal(f[1]) );
			else
				FW_SetPosition(getglobal(f[1]),FW.Settings[f[1]].x,FW.Settings[f[1]].y);
			end
		end
	end
end
---------------------------------------------------------------------------
-- globally accessable
---------------------------------------------------------------------------
function FW:Master() -- returns the promoted warlock with the highest version (and 'highest' name after that)
	local master;
	for name in pairs(FW.Version) do
		if FC_Saved.Shards[name] and FC_Saved.Shards[name][2]==FC_Saved.Update and FC_Saved.Shards[name][3]~=FW.FLAG_OFFLINE and FW.Ranks[name] and FW.Ranks[name] > 0 and (not master or master<name or FW.Version[master]<FW.Version[name]) then
			master=name;
		end
	end
	return master;
end

function FW:ToGroup(msg)
	if not FW.Settings["OutputRaid"] then return; end
	if GetNumRaidMembers() > 0 then
		SendChatMessage(msg,"RAID");
	elseif GetNumPartyMembers() > 0 then
		SendChatMessage(msg,"PARTY");
	else
		FW:Show(msg);
	end

end

function FW:ToChannel(msg)
	if not FW.Settings["Output"] then return; end
	if strlower(FW.Settings["OutputMsg"]) == "say" then
		SendChatMessage(msg,"SAY");
	else
		local index = tonumber(FW.Settings["OutputMsg"]) or GetChannelName(FW.Settings["OutputMsg"]);
		if index then
			SendChatMessage(msg,"CHANNEL",nil,index);
		end
	end
end

function FW:MixColors(v,c1,c2)
	-- v == 0 then color = c1, v == 1 then color = c2
	if v<0 then v=0; elseif v>1 then v=1;end
	return c1[1]*(1-v)+c2[1]*v,c1[2]*(1-v)+c2[2]*v,c1[3]*(1-v)+c2[3]*v;
end

function FW:MixColors2(v,c1r,c1g,c1b,c2r,c2g,c2b)
	-- v == 0 then color = c1, v == 1 then color = c2
	if v<0 then v=0; elseif v>1 then v=1;end
	return c1r*(1-v)+c2r*v,c1g*(1-v)+c2g*v,c1b*(1-v)+c2b*v;
end

function FW:Whisper(msg,to)
	SendChatMessage(msg,"WHISPER",nil,to);
end

function FW:AutoComplete(...) -- auto complete editbox with keys from x tables
	local text = this:GetText();
	local textlen = strlen(text);
	
	for i=1,select("#",...),1 do
		local t = (select(i,...));
		if t then
			for name in pairs(t) do

				if ( text ~= "" and strfind(strlower(name), "^"..strlower(text)) ) then
					this:SetText(name);
					this:HighlightText(textlen, -1);
					return;
				end
			end
		end
	end
end

function FW:Size(t)
	local i = 0;
	for k, v in pairs(t) do i=i+1;end
	return i;
end

function FW:GiveID() -- will be replaced by the proper one if timer module is loaded
	return 1;
end

function FW:DeleteProfile(name)
	if FC_Saved.Profiles[name] == nil then return; end
	
	for key, val in pairs(FC_Saved.Profiles) do
		if key ~= name then
			FW:UseProfile(key);
			FC_Saved.Profiles[name]=nil;
			return;
		end
	end
end

function FW:CreateProfile(name)
	if FC_Saved.PROFILE == name then return;end
	
	if FC_Saved.Profiles[name] == nil then
		FC_Saved.Profiles[name] = {};
	else
		FW:ERASE(FC_Saved.Profiles[name]);
	end
	FW_InitConfig2(FW.Settings,FC_Saved.Profiles[name]);
	
	FC_Saved.PROFILE = name;
	FW.Settings = FC_Saved.Profiles[FC_Saved.PROFILE];
	FW:RefreshOptions();
end

function FW:UseProfile(name,onload)
	if FC_Saved.Profiles[name] == nil then return; end
	
	FC_Saved.PROFILE = name;
	FW.Settings = FC_Saved.Profiles[FC_Saved.PROFILE];
	FW_InitConfig2(FW.Default,FW.Settings);
	FW:RefreshOptions();
	FW_RefreshFrames();
	FW_RefreshAllFilters();
	FW_InitFramePositions(onload);
end
---------------------------------------------------------------------------
-- template/option functions
---------------------------------------------------------------------------
function FW:RefreshOptions()
	if FWOptions:IsVisible() then FWOptions:Hide();FWOptions:Show(); end
end

function FW:CorrectScale(frame)
	FW_SetPosition(frame,FW.Settings[frame:GetName()].x,FW.Settings[frame:GetName()].y);
end

function FW:StartMoving(button)
	if IsAltKeyDown() and button=="LeftButton" then 
		local cx,cy = GetCursorPosition();
		local tx,ty = FW_GetCenter(this);
		this.fwmovingx = tx-cx;
		this.fwmovingy = ty-cy;
	end
end

function FW:StopMoving()
	this.fwmovingx = nil;
	this.fwmovingy = nil;
end

function FW:ScrollTo(v)
	v = Anchors[v] or v or 0;
	if FWOptions:IsVisible() and (math.abs(FWOptionsFrameScrollBar:GetValue() - v)<1) then
		FWOptions:Hide();
	elseif FW.Settings.RightClickOptions then
		FWOptions.scrollto = v;
		FWOptions:Show();
	end
end

function FW:AutoScroll()
	if this.scrollto then
		FWOptionsFrameScrollBar:SetValue(this.scrollto);
		FWOptionsFrame:UpdateScrollChildRect();
		
		if math.abs(FWOptionsFrameScrollBar:GetValue() - this.scrollto)<1 or (FWOptionsFrame:GetVerticalScrollRange()>0 and FWOptionsFrame:GetVerticalScrollRange()<this.scrollto) then
			this.scrollto=nil;
		end
	end			
end

function FW:FontName(font)
	for i, data in ipairs(FW_FontList) do
		if strlower(data[1]) == strlower(font) then
			return data[2];
		end
	end
	return "Custom Font";
end

function FW:TypeName(t)
	for i, data in ipairs(FW.FilterListOptions) do
		if data[1] == t then
			return data[2];
		end
	end	
end

function FW:RestorePosition()
	local frame = this:GetParent().frame
	if frame then
		getglobal(frame):ClearAllPoints();
		getglobal(frame):SetPoint("CENTER",UIParent, "CENTER",0,0);
		FW.Settings[frame].x,FW.Settings[frame].y = FW_GetCenter(getglobal(frame));
	end
end

function FW:SetFilterType(t)
	FWFilterList.button:SetText(FW:TypeName(t));
	local spell = getglobal(FWFilterList.button:GetParent():GetName().."EditBox"):GetText();
	
	FWFilterList.button:GetParent().func(spell,t);
	
	if not FW.Settings[FWFilterList.button:GetParent().option][spell] then FW.Settings[FWFilterList.button:GetParent().option][spell] = {};end
	FW.Settings[FWFilterList.button:GetParent().option][spell][1]=t;

	FW:SetFilterColor(FW.Settings[FWFilterList.button:GetParent().option][spell],FWFilterList.button:GetParent());
end

function FW:SetFilterColor(data,filter)
	if data and data[1] == -2 then
		if not data[2] then
			data[2],data[3],data[4] = 1,1,1;
		end
		getglobal(filter:GetName().."ColorSwatchNormalTexture"):SetVertexColor(data[2],data[3],data[4],1);
		getglobal(filter:GetName().."ColorSwatch"):EnableMouse(true);
	else
		getglobal(filter:GetName().."ColorSwatchNormalTexture"):SetVertexColor(0,0,0,0.1);
		getglobal(filter:GetName().."ColorSwatch"):EnableMouse(false);
	end
end

function FW:FilterSpellUpdate(spell)
	if FW.Settings[this:GetParent().option][spell] then
		getglobal(this:GetParent():GetName().."TypeButton"):SetText(FW:TypeName(FW.Settings[this:GetParent().option][spell][1]));
	else
		getglobal(this:GetParent():GetName().."TypeButton"):SetText(FW:TypeName(0));
	end
 	FW:SetFilterColor(FW.Settings[this:GetParent().option][spell],this:GetParent())
end

function FW:FilterColorPickerApply()
	ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4]=ColorPickerFrame:GetColorRGB();
	getglobal(ColorPickerFrame.button:GetName().."NormalTexture"):SetVertexColor(ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4],1);
end

function FW:FilterColorPickerCancel()
	ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4]=ColorPickerFrame.previousValues[1],ColorPickerFrame.previousValues[2],ColorPickerFrame.previousValues[3];
	getglobal(ColorPickerFrame.button:GetName().."NormalTexture"):SetVertexColor(ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4],1);
end

function FW:FontApply(font)
	FW.Settings[FWFontList.button:GetParent().option] = font;
	FWFontList.button:SetText(FW:FontName(font));
	FWFontList.button:SetFont(font,FW.Settings[FWFontList.button:GetParent().option.."Size"]);
	getglobal(FWFontList.button:GetParent():GetName().."EditBox"):SetText(font);
	if FWFontList.button:GetParent().func then FWFontList.button:GetParent().func(); end
end

function FW:TextureApply(texture)
	FW.Settings[FWTextureList.button:GetParent().option] = texture;
	FWTextureList.button:SetNormalTexture(texture);
	getglobal(FWTextureList.button:GetParent():GetName().."EditBox"):SetText(texture);
	if FWTextureList.button:GetParent().func then FWTextureList.button:GetParent().func(); end
end

function FW:AlphaApply()
	if ColorPickerFrame.hasOpacity then
		FW.Settings[ColorPickerFrame.button:GetParent().option][4] =  1.0 - OpacitySliderFrame:GetValue();
	else
		FW.Settings[ColorPickerFrame.button:GetParent().option][4] =  nil;
	end
	getglobal(ColorPickerFrame.button:GetName().."NormalTexture"):SetVertexColor(FW.Settings[ColorPickerFrame.button:GetParent().option][1],FW.Settings[ColorPickerFrame.button:GetParent().option][2],FW.Settings[ColorPickerFrame.button:GetParent().option][3],FW.Settings[ColorPickerFrame.button:GetParent().option][4]);
	
	if ColorPickerFrame.button:GetParent().func then ColorPickerFrame.button:GetParent().func();end
end

function FW:ColorPickerApply()
	FW.Settings[ColorPickerFrame.button:GetParent().option][1],FW.Settings[ColorPickerFrame.button:GetParent().option][2],FW.Settings[ColorPickerFrame.button:GetParent().option][3]=ColorPickerFrame:GetColorRGB();

	getglobal(ColorPickerFrame.button:GetName().."NormalTexture"):SetVertexColor(FW.Settings[ColorPickerFrame.button:GetParent().option][1],FW.Settings[ColorPickerFrame.button:GetParent().option][2],FW.Settings[ColorPickerFrame.button:GetParent().option][3],FW.Settings[ColorPickerFrame.button:GetParent().option][4]);

	if ColorPickerFrame.button:GetParent().func then ColorPickerFrame.button:GetParent().func();end
end

function FW:ColorPickerCancel()
	FW.Settings[ColorPickerFrame.button:GetParent().option][1],FW.Settings[ColorPickerFrame.button:GetParent().option][2],FW.Settings[ColorPickerFrame.button:GetParent().option][3]=ColorPickerFrame.previousValues[1],ColorPickerFrame.previousValues[2],ColorPickerFrame.previousValues[3];
	FW.Settings[ColorPickerFrame.button:GetParent().option][4] = ColorPickerFrame.previousValues[4];
	getglobal(ColorPickerFrame.button:GetName().."NormalTexture"):SetVertexColor(FW.Settings[ColorPickerFrame.button:GetParent().option][1],FW.Settings[ColorPickerFrame.button:GetParent().option][2],FW.Settings[ColorPickerFrame.button:GetParent().option][3],FW.Settings[ColorPickerFrame.button:GetParent().option][4]);
	
	if ColorPickerFrame.button:GetParent().func then ColorPickerFrame.button:GetParent().func();end
end

local function FW_DragFrames()
	
	local frame;
	local frame1,frame2;
	local cx,cy = GetCursorPosition();
	for i,f in ipairs(FW_Frames) do
		frame = getglobal(f[1]);
		if frame.fwmovingx then
			
			frame1 = getglobal(strsub(f[1],1,4).."Background") or getglobal(f[1]);
			
			local oy = select(2,FW_GetCenter(frame)) - select(2,FW_GetCenter(frame1));
			
			
			local x = frame.fwmovingx+cx;
			local y = frame.fwmovingy+cy;
			
			local hh = FW_GetHeight(frame1)/2;
			local hw = FW_GetWidth(frame1)/2;
			
			local vl = frame.fwmovingx+cx-hw;
			local vr = frame.fwmovingx+cx+hw;
			local vt = frame.fwmovingy+cy+hh-oy;
			local vb = frame.fwmovingy+cy-hh-oy;
			
			if FW.Settings.FrameSnap and f[1]~="FWOptions"  then
				for j,g in ipairs(FW_Frames) do
					if g[1]~=f[1] and g[1]~="FWOptions" then
						
						frame2 = getglobal(strsub(g[1],1,4).."Background") or getglobal(g[1]);

						if frame2:IsVisible() then
							local t = FW_GetTop(frame2);
							local b = FW_GetBottom(frame2);
							local l = FW_GetLeft(frame2);
							local r = FW_GetRight(frame2);
							
							if t > vt-FW.Settings.FrameSnapDistance and t < vt+FW.Settings.FrameSnapDistance then
								y = t - hh + oy;

							elseif b > vt-FW.Settings.FrameSnapDistance and b < vt+FW.Settings.FrameSnapDistance then
								y = b - hh -FW.Settings.FrameDistance + oy;

							elseif t < vb+FW.Settings.FrameSnapDistance and t > vb-FW.Settings.FrameSnapDistance then
								y = t + hh + FW.Settings.FrameDistance + oy;

							elseif b < vb+FW.Settings.FrameSnapDistance and b > vb-FW.Settings.FrameSnapDistance then
								y = b + hh + oy;

							end
							
							if r > vr-FW.Settings.FrameSnapDistance and r < vr+FW.Settings.FrameSnapDistance then
								x = r - hw;

							elseif l > vr-FW.Settings.FrameSnapDistance and l < vr+FW.Settings.FrameSnapDistance then
								x = l - hw -FW.Settings.FrameDistance;

							elseif r < vl+FW.Settings.FrameSnapDistance and r > vl-FW.Settings.FrameSnapDistance then
								x = r + hw + FW.Settings.FrameDistance;

							elseif l < vl+FW.Settings.FrameSnapDistance and l > vl-FW.Settings.FrameSnapDistance then
								x = l + hw;

							end								
						end
					end
				end
				if vt>FW_GetTop(UIParent) then
					y = FW_GetTop(UIParent) -hh - FW.Settings.FrameDistance + oy;
				elseif vb< 0 then
					y = hh + FW.Settings.FrameDistance + oy;
				end
				if vr>FW_GetRight(UIParent) then
					x = FW_GetRight(UIParent) -hw - FW.Settings.FrameDistance;
				elseif vl<0 then
					x = hw + FW.Settings.FrameDistance;
				end
			end

			
			FW_SetPosition(frame,x,y);			
			FW.Settings[f[1]].x,FW.Settings[f[1]].y = x,y;
			return;
		end
		--if frame.fwsizing then

		--end

	end
end

local function FW_SetAllTextures()
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		for sub_index, sub_data in ipairs(main_data[6]) do -- SUB OPTION LEVEL
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				if d[1] and d[1] == FW.TXT then
					FW.Settings[ d[6] ] = FW.Settings.Texture;
				end
			end
		end
	end
	FW_RefreshFrames()
	FW:RefreshOptions();
end

local function FW_SetAllFonts()
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		for sub_index, sub_data in ipairs(main_data[6]) do -- SUB OPTION LEVEL
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				if d[1] and d[1] == FW.FNT and d[6] ~= "OptionsFont" and d[6] ~= "OptionsHeaderFont"then
					FW.Settings[ d[6] ] = FW.Settings.Font;
					FW.Settings[ d[6].."Size" ] = FW.Settings.FontSize;
				end
			end
		end
	end
	FW_RefreshFrames()
	FW:RefreshOptions();
end

local function FW_FindCategory(t,name)
	for i, data in ipairs(t) do
		if data[1] == name then
			return i;
		end
	end
end
local function FW_FindOption(t,typ,name)
	for i, data in ipairs(t) do
		if data[1] == typ and data[4] == name then
			return i;
		end
	end
end

local function FW_RestoreOption(d)
	if d[1] and d[1] ~= FW.NIL and d[1] ~= FW.INF and d[1] ~= FW.FIL and d[1] ~= FW.PRO then
		if d[1] == FW.COL then
			for x in ipairs(FW.Default[ d[6] ]) do
				FW.Settings[ d[6] ][x] = FW.Default[ d[6] ][x];
			end
		else
			FW.Settings[ d[6] ] = FW.Default[ d[6] ];
		end
		if d[1] == FW.MSG or d[1] == FW.MS2 then
			FW.Settings[d[6].."Msg"] = FW.Default[d[6].."Msg"];
		elseif d[1] == FW.FNT then
			FW.Settings[d[6].."Size"] = FW.Default[d[6].."Size"];
		end
		if d[7] then d[7](); end
	end
end

function FW:RestoreDefaults()
	if this:GetParent():GetParent().index then
		local mainindex = this:GetParent():GetParent().index;
		local subindex = this:GetParent().index;
		for i, d in ipairs(FW_Options[mainindex][6][subindex][4]) do -- OPTION LEVEL
			FW_RestoreOption(d);
		end
	else
		local index = this:GetParent().index;
		
		for sub_index, sub_data in ipairs(FW_Options[index][6]) do -- SUB OPTION LEVEL
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				FW_RestoreOption(d);
			end
		end
	end
	FW:RefreshOptions();
end

local maincat,mainicon,mainindex,color,frame;
local subcat,subicon,subindex;

function FW:SetMainCategory(a1,a2,a3,a4,a5)
	maincat,mainicon,mainindex,color,frame = a1,a2,a3,a4,a5;
end
function FW:SetSubCategory(a1,a2,a3)
	subcat,subicon,subindex = a1,a2,a3;
end

function FW:RegisterOption(typ,width,pos,text,tip,option,func)
	-- maincat: main category
	-- mainicon: icon for main category (nil for none)
	-- mainindex: priority index of this category
	-- frame: frame belonging to this category (nil for none)
	
	-- subcat: sub category ("" for not adding a sub category)
	-- subicon (nil for none)
	-- subindex: priority index of this sub category
	
	-- typ: the template to use
	-- width: the number of rows the option will take up (1 or 2)
	-- pos: preferred postion (0 = none, 1=left, 2=right)
	-- text: text for this option
	-- tip: tooltip displayed for this option (nil for none)
	-- func: function to execute after change (nil for none)
	
	local mc = FW_FindCategory(FW_Options,maincat);
	if not mc then
		mc = 1;
		while(mc<=#FW_Options and FW_Options[mc][3]<=mainindex) do
			mc=mc+1;
		end
		tinsert(FW_Options,mc,{maincat,mainicon,mainindex,color,frame,{}});	
	end
	local sc = FW_FindCategory(FW_Options[mc][6],subcat);
	if not sc then
		sc = 1;
		while(sc<=#FW_Options[mc][6] and FW_Options[mc][6][sc][3]<=subindex) do
			sc=sc+1;
		end
		tinsert(FW_Options[mc][6],sc,{subcat,subicon,subindex,{}});
	end
	if not FW_FindOption(FW_Options[mc][6][sc][4],typ,text) then
		tinsert(FW_Options[mc][6][sc][4],{typ,width,pos,text,tip,option,func});
	end
end

function FW:SetOptionsFont()
	FWOptionsHeaderTitle:SetFont(FW.Settings.OptionsHeaderFont,FW.Settings.OptionsHeaderFontSize);

	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		
		getglobal("FWShortcut"..main_index):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
		
		getglobal("FWOptions"..main_index.."HeaderTitle"):SetFont(FW.Settings.OptionsHeaderFont,FW.Settings.OptionsHeaderFontSize);
		
		getglobal("FWOptions"..main_index.."Default"):SetText(FW.L.DEFAULTS);
		getglobal("FWOptions"..main_index.."Default"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
	
		getglobal("FWOptions"..main_index.."Position"):SetText(FW.L.POSITION);
		getglobal("FWOptions"..main_index.."Position"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
		
		for sub_index, sub_data in ipairs(main_data[6]) do -- SUB OPTION LEVEL
			
			if sub_data[1] and sub_data[1] ~= FW.NIL then
				getglobal("FWOption"..main_index.."."..sub_index.."HeaderTitle"):SetFont(FW.Settings.OptionsHeaderFont,FW.Settings.OptionsHeaderFontSize);
				
				getglobal("FWOption"..main_index.."."..sub_index.."Default"):SetText(FW.L.DEFAULTS);
				getglobal("FWOption"..main_index.."."..sub_index.."Default"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
			end
			
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				
				if d[1] and d[1] ~= FW.NIL then
					local name = "FWOption"..main_index.."."..sub_index.."."..i;
					
					getglobal(name.."Text" ):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					
					if d[1] ~= FW.INF and d[1] ~= FW.PRO then
						getglobal(name.."Default"):SetText(FW.L.DEFAULT);
						getglobal(name.."Default"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					end
					if d[1] == FW.TXT or d[1] == FW.FNT or d[1] == FW.FIL or d[1] == FW.MSG or d[1] == FW.NUM or d[1] == FW.MS2 or d[1] == FW.PRO then
						getglobal(name.."EditBox"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					end
					
					if d[1] == FW.FNT then
						getglobal(name.."EditBox2"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					elseif d[1] == FW.FIL then
						getglobal(name.."TypeButton"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					elseif d[1] == FW.PRO then
						getglobal(name.."Button"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
						getglobal(name.."Delete"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
						getglobal(name.."Create"):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					end
				end
			end
		end
	end
	for i, data in ipairs(FW_FontList) do
		getglobal("FWFontList"..i):SetFont( data[1] ,FW.Settings.OptionsFontSize+2);
	end
	for i=1,NUM_PROFILE_LIST,1 do
		getglobal("FWProfileList"..i):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
	end
	for i=1,NUM_FILTER_LIST,1 do
		getglobal("FWFilterList"..i):SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
	end
end

function FW:SetOptionsColor()
	local r,g,b,a = unpack(FW.Settings.ColorOptionHeader);
	FWOptionsHeader:SetBackdropBorderColor(r,g,b,a);
	FWOptionsHeader:SetBackdropColor(r,g,b,a);
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		getglobal("FWShortcut"..main_index):SetBackdropBorderColor(r,g,b,1);
		getglobal("FWShortcut"..main_index):SetBackdropColor(r,g,b,1);
		getglobal("FWOptions"..main_index.."Header"):SetBackdropBorderColor(r,g,b,a);
		getglobal("FWOptions"..main_index.."Header"):SetBackdropColor(r,g,b,a);
		getglobal("FWOptions"..main_index):SetBackdropBorderColor(unpack(FW.Settings.ColorOptionBackground));
		getglobal("FWOptions"..main_index):SetBackdropColor(unpack(FW.Settings.ColorOptionBackground));
		for sub_index, sub_data in ipairs(main_data[6]) do -- SUB OPTION LEVEL
			if sub_data[1] and sub_data[1] ~= FW.NIL then
				getglobal("FWOption"..main_index.."."..sub_index.."Header"):SetBackdropBorderColor(r,g,b,a);
			end
		end
	end
	a = 0.8;
	FWTextureList:SetBackdropBorderColor(r,g,b,1);
	FWTextureList:SetBackdropColor(r,g,b,a);
	FWFontList:SetBackdropBorderColor(r,g,b,1);
	FWFontList:SetBackdropColor(r,g,b,a);
	FWProfileList:SetBackdropBorderColor(r,g,b,1);
	FWProfileList:SetBackdropColor(r,g,b,a);
	FWFilterList:SetBackdropBorderColor(r,g,b,1);
	FWFilterList:SetBackdropColor(r,g,b,a);
end

local function FW_BuildOptions2()
	local f,s;
	local offset = 0;
	local x,y = 0,0;
	local width = 560;--total option space width
	local half = width/2;
	local h = 20;--height of one option
	
	local r,g,b,a = unpack(FW.Settings.ColorOptionHeader);
	
	-- build main options
	FWOptionsHeaderIcon:SetTexCoord(unpack(CLASS_ICONS[FW.CLASS]));
	
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		
		x,y = 0,-h;
		f=CreateFrame("Frame", "FWOptions"..main_index, FWOptionsContent, "FWOptionsTemplate");
		getglobal("FWOptions"..main_index.."HeaderTitle"):SetText(main_data[1]);
		getglobal("FWOptions"..main_index.."HeaderIcon"):SetTexture(main_data[2]);
		
		f.frame = main_data[5];
		if f.frame then getglobal("FWOptions"..main_index.."Position"):Show();end
		f:SetPoint("TOPLEFT", FWOptionsContent, "TOPLEFT",0,offset);
		f:Show();
		f.index = main_index;
		for sub_index, sub_data in ipairs(main_data[6]) do -- SUB OPTION LEVEL
			
			if sub_data[1] and sub_data[1] ~= FW.NIL then
				if x>0 then
					x = 0;y = y -h;
				end
				s=CreateFrame("Frame", "FWOption"..main_index.."."..sub_index, getglobal("FWOptions"..main_index), "FWSubOptionsTemplate");
				s:SetWidth(width);
				s:SetPoint("TOPLEFT",getglobal("FWOptions"..main_index), "TOPLEFT",x,y);
				getglobal( "FWOption"..main_index.."."..sub_index.."HeaderTitle"):SetText(sub_data[1]);
				getglobal( "FWOption"..main_index.."."..sub_index.."HeaderIcon"):SetTexture(sub_data[2]);
	
				s:Show();
				s.index = sub_index;
				y = y -h;
			end
			
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL

				if d[1] and d[1] ~= FW.NIL then
					s=CreateFrame("Frame", "FWOption"..main_index.."."..sub_index.."."..i , getglobal("FWOptions"..main_index), d[1]);
					
					s.title = d[4];
					if d[5] then
						local c = "|cff888888";
						s.tip = d[5];
						if d[1] == FW.COL then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FW.L.USE_COLOR_PICKER;
						elseif d[1] == FW.TXT then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FW.L.USE_TEXTURE;
						elseif d[1] == FW.FNT then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FW.L.USE_FONT;
						elseif d[1] == FW.FIL then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FW.L.USE_FILTER
						elseif d[1] == FW.MSG or d[1] == FW.NUM then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FW.L.USE_EDITBOX;
						elseif d[1] == FW.MS2 then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FW.L.USE_MSG2;
						end
					end
					s.option = d[6];
					s.func = d[7];
					
					-- correct the option's layout
					if d[2]==2 then
						if x>0 then
							x = 0;y = y -h;
						end
					else
						if x==0 then
							if d[3] == FW.RIG then
								x = x + d[2]*half;
							end
						else
							if d[3] == FW.LEF then
								x = 0;y = y -h;
							end
						end
					end
					s:SetWidth(d[2]*half);
					s:SetPoint("TOPLEFT",getglobal("FWOptions"..main_index), "TOPLEFT",x,y);
					getglobal( "FWOption"..main_index.."."..sub_index.."."..i.."Text"):SetText(d[4]);
					s:Show();
				end

				x = x + d[2]*half;

				if x >= width then
					x = 0;y = y -h;
				end
			end		
		end
		if x>0 then x = 0;y = y -h;end
		Anchors[main_data[1]] = -offset;
		offset = offset + y - 10;
		f:SetHeight(-y+5);
	end
	local columns = 4;
	local w = 600/columns;
	h=16;
	y = h*math.floor(#FW_Options/columns);
	x = 0;

	FWOptionsFrame:SetHeight(440-h*math.floor(#FW_Options/columns));
	
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL

		s=CreateFrame("Button","FWShortcut"..main_index,FWOptions,"FWShortcutButtonTemplate");
		
		s:SetPoint("BOTTOMLEFT",FWOptions, "BOTTOMLEFT",x,y);
		s:SetWidth(w);
		s:SetHeight(h);
		s:SetText(main_data[1]);
		s.tip = FW.L.SCROLL_TO_..main_data[1];
		s.title = main_data[1];
		s:SetNormalTexture(main_data[2]);
		
		s:SetScript("OnClick",function() FWOptions.scrollto = Anchors[ main_data[1] ];end);
		
		x=x+w;
		if x>=600 then
			x=0;y=y-h;
		end		
	end
	
	
	-- build texture selection frame
	f=CreateFrame("Frame", "FWTextureList", FWOptions,"FWDropdownTemplate");
	f:SetFrameStrata("DIALOG")
	f:Hide();
	local j=0
	for i, texture in ipairs(FW_TextureList) do
		s=CreateFrame("Button","FWTextureList"..i,FWTextureList,"FWTextureButtonTemplate");
		
		s:SetNormalTexture(texture);
		if s:GetNormalTexture():GetTexture() == texture then
			s.option=texture;
			s:SetPoint("TOPLEFT",FWTextureList, "TOPLEFT",5+(j%3)*142,-5-math.floor(j/3)*18);
			s:Show();
			j=j+1;
		end
	end
	f:SetWidth((142)*3+8);
	f:SetHeight(math.floor((j-1)/3)*18+26);
	
	-- build font selection frame
	f=CreateFrame("Frame", "FWFontList", FWOptions,"FWDropdownTemplate");
	f:SetFrameStrata("DIALOG")
	f:SetHeight(#FW_FontList*18+8);
	f:SetWidth(150);
	f:Hide();
	for i, data in ipairs(FW_FontList) do
		f=CreateFrame("Button","FWFontList"..i,FWFontList,"FWFontButtonTemplate");
		f:SetText(data[2]);
		f:SetFont(data[1],14);
		f.option=data[1];
		f:SetPoint("TOPLEFT",FWFontList, "TOPLEFT",5,13-i*18);
		f:Show();
	end
	
	-- build profile selection frame
	f=CreateFrame("Frame", "FWProfileList", FWOptions,"FWDropdownTemplate");
	f:SetFrameStrata("DIALOG")
	f:SetWidth(150);
	f:Hide();
	for i=1,NUM_PROFILE_LIST,1 do
		f=CreateFrame("Button","FWProfileList"..i,FWProfileList,"FWProfileButtonTemplate");
		f:SetPoint("TOPLEFT",FWProfileList, "TOPLEFT",5,13-i*18);
		f:Show();
	end
	
	-- build filter selection frame
	f=CreateFrame("Frame", "FWFilterList", FWOptions,"FWDropdownTemplate");
	f:SetFrameStrata("DIALOG")
	f:SetWidth(150);
	f:Hide();
	for i=1,NUM_FILTER_LIST,1 do
		f=CreateFrame("Button","FWFilterList"..i,FWFilterList,"FWFilterButtonTemplate");
		f:SetPoint("TOPLEFT",FWFilterList, "TOPLEFT",5,13-i*18);
		f:Show();
	end
end

function FW:FilterList()

	local i=0;
	for key,val in ipairs(FW.FilterListOptions) do
		i=i+1;
		getglobal("FWFilterList"..i):SetText(val[2]);
		getglobal("FWFilterList"..i).option=val[1];
		getglobal("FWFilterList"..i):Show();
	end
	FWFilterList:SetHeight(i*18+8);
	for j=i+1,NUM_FILTER_LIST,1 do
		getglobal("FWFilterList"..j):Hide();
	end
	FWFilterList:Show();
end

function FW:ProfileList()
	local i=0;
	for key in pairs(FC_Saved.Profiles) do
		i=i+1;
		getglobal("FWProfileList"..i):SetText(key);
		getglobal("FWProfileList"..i).option=key;
		getglobal("FWProfileList"..i):Show();
	end
	FWProfileList:SetHeight(i*18+8);
	for j=i+1,NUM_PROFILE_LIST,1 do
		getglobal("FWProfileList"..j):Hide();
	end
	FWProfileList:Show();
end

local ICON = "";

local function FW_LoadedFunc()
	for i, f in ipairs(FW_Loaded) do
			f();
	end
end

---------------------------------------------------------------------------
-- options & events
---------------------------------------------------------------------------
function FW:RegisterEvents()
	-- time based events
	
	-- things to do at load (after load delay)
	FW:RegisterDelayedLoadEvent(FW_Scan);
	FW:RegisterDelayedLoadEvent(FW_RelevantSetBonus);
	FW:RegisterDelayedLoadEvent(FW_RelevantTalent);
	FW:RegisterOnLeaveCombat(FW_InitFramePositions);
	
	-- things to do on update event
	FW:RegisterUpdatedEvent(FW_UpdateCore);
	FW:RegisterUpdatedEvent(FW_DragFrames);
		
	FW:RegisterScan(FW_ShardScan);
	FW:RegisterScan(FW_HealthstoneScan);
	
	FW:RegisterVariablesEvent(function()
		FW_BuildOptions2();
		FW:RegisterTimedEvent("UpdateInterval",		FW_TimedRaidParty);
		FW:RegisterTimedEvent("UpdateInterval",		FW_Scan);
		FW:RegisterTimedEvent("UpdateInterval",		FW_TimedClearBuffers);
	end);
	FW:RegisterLoadEvent(FW_InitFramePositions);
	FW:RegisterDelayedLoadEvent(FW_PartyRaid);
	FW:RegisterDelayedLoadEvent(FW_MakeSpeccInfo);--doesnt work at load event
	
	FW:RegisterToEvent("PLAYER_REGEN_ENABLED",	FW_LeaveCombat);
	FW:RegisterToEvent("PLAYER_REGEN_DISABLED",	FW_EnterCombat);
	FW:RegisterToEvent("PLAYER_ALIVE",		FW_Ress)
	FW:RegisterToEvent("PLAYER_UNGHOST",		FW_Ress);
	FW:RegisterToEvent("PLAYER_LEAVING_WORLD",	function() LeaveCombat = 1; end);
	FW:RegisterToEvent("UNIT_INVENTORY_CHANGED",	FW_RelevantSetBonus);
	FW:RegisterToEvent("CHARACTER_POINTS_CHANGED",	FW_RelevantTalent);
	
	FW:RegisterToEvent("CHARACTER_POINTS_CHANGED",	FW_MakeSpeccInfo);
	FW:RegisterToEvent("CHARACTER_POINTS_CHANGED",	FW_SendSpeccInfo);
	FW:RegisterToEvent("LEARNED_SPELL_IN_TAB",	FW_MakeSpeccInfo);
	FW:RegisterToEvent("LEARNED_SPELL_IN_TAB",	FW_SendSpeccInfo);
	
	FW:RegisterToEvent("VARIABLES_LOADED",		FW_Variables);
	FW:RegisterToEvent("INSPECT_TALENT_READY",	function() FW_MakeSpeccInfo(1); end);
	FW:RegisterToEvent("CHAT_MSG_ADDON",		FW_AddonMessage);
	
	FW:RegisterToEvent("PLAYER_ENTERING_WORLD", 	FW_LoadedFunc);
	
	FW:RegisterEnterPartyRaid(FW_VersionCheck);
	FW:RegisterEnterPartyRaid(FW_GetSpeccInfo);
	
	--FW:RegisterToEvent("COMBAT_LOG_EVENT",nil);
end

FW:AddCommand("commands",
	function()
		for k,v in pairs(Commands) do
			FW:Show(k,1,1,0);
		end
	end
);
FW:AddCommand("version",
	function()
		for k, v in pairs(FW.Version) do
			FW:Show(k..": "..v);
		end
	end
);
FW:AddCommand("position",
	function()
		FWOptions:ClearAllPoints();
		FWOptions:SetPoint("CENTER",UIParent, "CENTER",0,0);
		FW.Settings["FWOptions"].x,FW.Settings["FWOptions"].y = FW_GetCenter(FWOptions);
	end
);
FW:AddCommand("master",
	function()
		local master = FW:Master();
		if master then
			FW:Show("Master Warlock: "..master,1,1,0);
		else
			FW:Show("No Master Warlock available",1,1,0);
		end
	end
);
FW:AddCommand("debug",
	function()
		FW_Debug = not FW_Debug;
		if FW_Debug then
			FW:Show("fw debugging enabled",1,1,0);
		else
			FW:Show("fw debugging disabled",1,1,0);
		end
	end
);

FW:RegisterMessage(FW.GET_SHARDS,
	function() 
		if FW.LastShardCheck + 5 < GetTime() then
			FW.LastShardCheck = GetTime();
			FW:CheckShards();
		end
	end,
nil);
FW:RegisterMessage(FW.GET_HEALTHSTONE,
	function() 
		if FW.LastHSCheck + 5 < GetTime() then
			FW.LastHSCheck = GetTime();
			FW:CheckHealthstone();
		end
	end,
nil);
FW:RegisterMessage(GET_VERSION,FW_SendVersion,nil);
FW:RegisterMessage(SEND_VERSION,
	function(m,f)
		FW.Version[f] = m;
	end,
nil);
FW:RegisterMessage(GET_SPECC,FW_SendSpeccInfo,nil);
FW:RegisterMessage(SEND_SPECC,
	function(m,f)
		local id = FW:NameToID(f);
		if id then
			local class = select(2,UnitClass(id));
			if not FC_Saved.Speccs[class] then
				FC_Saved.Speccs[class] = {};
			end
			FC_Saved.Speccs[class][f] =  m;
			FW:CreateHealthstoneTypes();
		end
	end,
nil);
FW:RegisterORAMessage("oRAV ",
	function(a1,a2,f)
		FC_Saved.GotORA[f] = 1;
		return 1;
	end,
nil);
FW:RegisterORAMessage("V ",
	function(a1,a2,f)
		if FC_Saved.GotORA[f] == nil then 
			FC_Saved.GotORA[f] = 0;
		end
		return 1;
	end,
nil);
-- reply to num healthstones no matter what modules i'm using
FW:RegisterORAMessage(FW.ORA_ITEM_REQUEST,
	function(a1,a2,f)
		a1=tonumber(a1);
		if a1 then
			for i=#FW.ID_HEALTHSTONE,1,-1 do
				if a1==FW.ID_HEALTHSTONE[i][2] then
					FW:SendHealthstone(i,GetItemCount(a1));
					return 1;
				end
			end
		end
	end,
nil);

function FW:LocalizedData()

	FW.ID_HEALTHSTONE = {
		{FW.L.MINOR_HS,		5512,	FW.L.MINOR..IMP_HS[0],	1,1},
		{FW.L.MINOR_HS,		19004,	FW.L.MINOR..IMP_HS[1],	2,1},
		{FW.L.MINOR_HS,		19005,	FW.L.MINOR..IMP_HS[2],	3,1},
		{FW.L.LESSER_HS,	5511,	FW.L.LESSER..IMP_HS[0],	1,2},
		{FW.L.LESSER_HS,	19006,	FW.L.LESSER..IMP_HS[1],	2,2},
		{FW.L.LESSER_HS,	19007,	FW.L.LESSER..IMP_HS[2],	3,2},
		{FW.L.NORMAL_HS,	5509,	FW.L.NORMAL..IMP_HS[0],	1,3},
		{FW.L.NORMAL_HS,	19008,	FW.L.NORMAL..IMP_HS[1],	2,3},
		{FW.L.NORMAL_HS,	19009,	FW.L.NORMAL..IMP_HS[2],	3,3},
		{FW.L.GREATER_HS,	5510,	FW.L.GREATER..IMP_HS[0],1,4},
		{FW.L.GREATER_HS,	19010,	FW.L.GREATER..IMP_HS[1],2,4},
		{FW.L.GREATER_HS,	19011,	FW.L.GREATER..IMP_HS[2],3,4},
		{FW.L.MAJOR_HS,		9421,	FW.L.MAJOR..IMP_HS[0],	1,5},
		{FW.L.MAJOR_HS,		19012,	FW.L.MAJOR..IMP_HS[1],	2,5},
		{FW.L.MAJOR_HS,		19013,	FW.L.MAJOR..IMP_HS[2],	3,5},
		{FW.L.MASTER_HS,	22103,	FW.L.MASTER..IMP_HS[0],	1,6},
		{FW.L.MASTER_HS,	22104,	FW.L.MASTER..IMP_HS[1],	2,6},
		{FW.L.MASTER_HS,	22105,	FW.L.MASTER..IMP_HS[2],	3,6},
		
		[0]={FW.L.NONE, 0, FW.L.NONE,0,0},
	};

	FW.ID_SOULSTONE = {
		{FW.L.MINOR_SS,5232},
		{FW.L.LESSER_SS,16892},
		{FW.L.NORMAL_SS,16893},
		{FW.L.GREATER_SS,16895},
		{FW.L.MAJOR_SS,16896},
		{FW.L.MASTER_SS,22116},
	};
	FW.Exceptions = {
		[FW.L.HELLFIRE_CHANNELER] = 0,
		[FW.L.GRAND_ASTROMANCER_CAPERNIAN] = 1,
		[FW.L.MASTER_ENGINEER_TELONICUS] = 1,
		[FW.L.FATHOM_GUARD_SHARKKIS] = 1,
		[FW.L.THALADRED_THE_DARKENER] = 1,
		[FW.L.LORD_SANGUINAR] = 1,
		[FW.L.FATHOM_GUARD_CARIBDIS] = 1,
		[FW.L.FATHOM_GUARD_TIDALVESS] = 1,
	};

	
	FW.FilterListOptions = {
		{ 0,FW.L.FILTER_NONE},
		{-1,FW.L.FILTER_IGNORE},
		{-2,FW.L.FILTER_COLOR},
	}

	FW.ClassModules = FW.L.MODULE_NONE;
	
	FW:SetMainCategory(FW.L.GENERAL,FW.ICON_DEFAULT,1,"DEFAULT","FWOptions");

		FW:SetSubCategory(FW.L.GENERAL_TIPS,FW.ICON_HINT,1);
			FW:RegisterOption(FW.INF,2,FW.NON,	FW.L.GENERAL_TIPS1);
			FW:RegisterOption(FW.INF,2,FW.NON,	FW.L.GENERAL_TIPS2);
			FW:RegisterOption(FW.INF,2,FW.NON,	FW.L.GENERAL_TIPS3);
			FW:RegisterOption(FW.INF,2,FW.NON,	FW.L.GENERAL_TIPS4);

		FW:SetSubCategory(FW.L.GENERAL_MO,FW.ICON_DEFAULT,2);
			FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.GENERAL_MO1,	FW.L.GENERAL_MO1_TT,	"RightClickOptions");
			FW:RegisterOption(FW.CHK,1,FW.NON,FW.L.GENERAL_MO2,	FW.L.GENERAL_MO2_TT,	"TimeFormat");
			FW:RegisterOption(FW.CHK,1,FW.LEF,FW.L.GENERAL_MO3,	FW.L.GENERAL_MO3_TT,	"FrameSnap");
			FW:RegisterOption(FW.NUM,1,FW.RIG,FW.L.GENERAL_MO4,	FW.L.GENERAL_MO4_TT,	"FrameSnapDistance");
			FW:RegisterOption(FW.NUM,1,FW.RIG,FW.L.GENERAL_MO5,	FW.L.GENERAL_MO5_TT,	"FrameDistance");

		FW:SetSubCategory(FW.L.GENERAL_MA,FW.ICON_APPEARANCE,3);
			FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.BAR_FONT,	FW.L.GENERAL_MA1_TT,	"Font",				FW_SetAllFonts);
			FW:RegisterOption(FW.TXT,2,FW.NON,FW.L.BAR_TEXTURE,	FW.L.GENERAL_MA2_TT,	"Texture",			FW_SetAllTextures);

		FW:SetSubCategory(FW.L.GENERAL_OA,FW.ICON_APPEARANCE,4);
			FW:RegisterOption(FW.COL,1,FW.NON,FW.L.GENERAL_OA1,	FW.L.GENERAL_OA1_TT,	"ColorOptionHeader",		FW.SetOptionsColor);
			FW:RegisterOption(FW.COL,1,FW.NON,FW.L.GENERAL_OA2,	FW.L.GENERAL_OA2_TT,	"ColorOptionBackground",	FW.SetOptionsColor);
			FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.GENERAL_OA3,	FW.L.GENERAL_OA3_TT,	"OptionsHeaderFont",		FW.SetOptionsFont);
			FW:RegisterOption(FW.FNT,2,FW.NON,FW.L.GENERAL_OA4,	FW.L.GENERAL_OA4_TT,	"OptionsFont",			FW.SetOptionsFont);

	FW:SetMainCategory(FW.L.PROFILES,FW.ICON_PROFILE,2,"DEFAULT");

		FW:SetSubCategory(FW.NIL);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.PROFILES_HINT1);
			FW:RegisterOption(FW.PRO,2,FW.NON,FW.L.PROFILES_CURRENT,FW.L.PROFILES_CURRENT_TT);

	FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");

		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.ADVANCED_HINT1);
			FW:RegisterOption(FW.INF,2,FW.NON,FW.L.ADVANCED_HINT2);
			
		FW:SetSubCategory(FW.L.CORE,FW.ICON_DEFAULT,2);
			FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.LOADING_DELAY,			"",	"LoadDelay");
			FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.UPDATE_INTERVAL_CORE,		"",	"UpdateInterval");
			FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.UPDATE_INTERVAL_ANIMATIONS,	"",	"AnimationInterval");
			
			
	FW.Default.OptionsFont = FW.Default.Font;
	FW.Default.OptionsFontSize = FW.Default.FontSize;
	FW.Default.OptionsHeaderFont = FW.Default.Font;
	FW.Default.OptionsHeaderFontSize = FW.Default.FontSize;
	
	FW.RaidIcons = {
		FW.L.YELLOW_STAR,
		FW.L.ORANGE_CIRCLE,
		FW.L.PRUPLE_DIAMOND,
		FW.L.GREEN_TRIANGLE, 
		FW.L.MOON,
		FW.L.BLUE_SQUARE,
		FW.L.CROSS,
		FW.L.SKULL
	}
end

FW.Default.OptionsFontLabelColor = {1,1,1};
FW.Default.OptionsFontInputColor = {1,1,1};

FW.Default.AnimationInterval = 0.05;
FW.Default.LoadDelay = 1;
FW.Default.UpdateInterval = 0.5;

FW.Default.FrameSnapDistance = 5;
FW.Default.FrameDistance = 0;
FW.Default.FrameSnap = true;
--FW.Default.FrameAnchor = false;

FW.Default.TimeFormat = false;

FW.Default.ColorBloodpactGain = {1.00,0.40,0.00};
FW.Default.ColorBloodpactLoss = {1.00,0.00,0.00};
FW.Default.ColorSoulstoneMsg = 	{1.00,0.00,1.00};
FW.Default.ColorFailedMsg = 	{1.00,0.00,0.55};

FW.Default.Texture = "Interface\\AddOns\\Forte_Core\\Textures\\Xus";
FW.Default.Mix = 0.5;

FW.Default.BlockShardReagent = false;
FW.Default.SafeBlockShardReagent = true;
FW.Default.RightClickOptions = true;

FW.Default.ColorOptionBackground = {0.55,0.00,0.88,0.50};
FW.Default.ColorOptionHeader = {0.35,0.00,0.62,1.00};

FW.Default.HealthstoneNumber = 3;
FW.Default.HealthstoneTopRank = true;
