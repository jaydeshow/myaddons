local frame ;
local L = AlchemyProcsLocals;

--Default GUI options 
local DefaultAlchemyProcsOptions = {
	version = L["GUIVersion"],	--GUI option version,field to keep back compatibility
	showColor = true,			--Show procs with color if true.
	maxRow = 15,				--Max row to display
	showProc = {true, true, true, true ,[0] = true},  --Show the proc column if true
	sortColumn = nil,			--The id of the column to sort or nil if needn't sort
	sortOrder = nil,			--Sort by ascending order if true, or descending order if false.
	orderKey = nil,				--Order by amount if true,or chance% if false. This value is nil when sorting item name or item made.	
};

AlchemyProcsOptions = {};

local MAX_ROW,PROC_COLUMN,MAX_PROC_COLUMN;

-- Status
local Status = {
	["GUI"] = nil;				--GUI status. True when the frame shows,false when it hides and nil if it hasn't been created.
	["DataChanged"] = true;		--Data status. True when data have been changed,or false if not.
	["SortingChanged"] = true;	--Sorting status. True when data sorting option have been changed,or false if not.
}

-- local tables
local T = {
	["Header"] = {},	--Column headers
	["Row"] = {},		--Table rows
	["Total"] = {},		--Total row
	["Data"] = {},		--Saved data
	["Index"] = {},		--Index after sorting
	["Width"] = {		--Column width
		["Item"] = 135,
		["Made"] = 50,
		["Created"] = 120,
		["Procs"] = 100,
		["Proc"] = 100,
	},
	["Color"] = {
		"|cff00ff00",
		"|cff69cdf1",
		"|cffffff00",
		"|cffff0000",
	},	
};


--Sort data
local function sortData(a,b)		
	local key = AlchemyProcsOptions.sortColumn;
	if ( AlchemyProcsOptions.orderKey ~= nil and not AlchemyProcsOptions.orderKey ) then
		key = key.."%";
	end
	local v1,v2 = T["Data"][a][key],T["Data"][b][key];
	if ( AlchemyProcsOptions.sortOrder ) then
		v1,v2 = v2,v1;
	end
	return v1 < v2;
end

--Build index to access sorted data
local function buildIndex()	
	while (#T["Index"] > 0) do
		table.remove(T["Index"]);
	end	
	for itemId in pairs(T["Data"]) do
		table.insert(T["Index"],itemId);
	end
	
	if ( AlchemyProcsOptions.sortColumn ) then
		table.sort(T["Index"],sortData);
	end;
end

--Get text of the column header
local function getColumnHeaderText(columnId)
	local procN = string.match(columnId,"Proc[0-4]")
	if ( procN ) then
		return L["Proc"][tonumber(string.sub(procN,5))];
	end
	return L[columnId]
end

--Update the column header
local function updateColumnHeader(columnHeader)	
	local text = getColumnHeaderText(columnHeader.id);	
	if ( AlchemyProcsOptions.sortColumn == columnHeader.id) then
		local arrow = AlchemyProcsOptions.sortOrder and "↑" or "↓";
		text = AlchemyProcsOptions.orderKey and arrow..text or text..arrow;		
	end
	columnHeader:SetText(text);
end

-- Format data
local function formatData(data,columnId)
	if ( not data[columnId] or data[columnId] == 0 ) then
		return "---";
	end	
	if ( columnId == "Made" or columnId == "Item" ) then
		return data[columnId];
	else
		local procN = string.match(columnId,"Proc[1-4]")
		local color = "";
		if ( procN and AlchemyProcsOptions.showColor ) then
			color = T["Color"][tonumber(string.sub(procN,5))];
		end
		return string.format(color.."%d (%.2f%%)", data[columnId],data[columnId.."%"] * 100 );
	end
end

-- Summary data
local function summaryData()
	local total = {
		["Expected"] = 0;
	};
	for _,data in pairs(T["Data"]) do
		for columnId in pairs(T["Total"]) do
			if ( not total[columnId] ) then
				total[columnId] = 0;
			end
			total[columnId] = total[columnId] + data[columnId];
		end
		total["Expected"] = total["Expected"] + data["Expected"];
	end
	total["Created%"] = total["Created"] / total["Expected"];
	total["Procs%"] = total["Procs"] / total["Made"];	
	for i = 0,4 do
		total["Proc"..i.."%"] = total["Proc"..i] / total["Made"];
	end	
	return total;
end

--Update GUI,resort data and update column headers when the arg is true
function updateGUI()
	if( not Status["GUI"] ) then		
		return		--Do not update GUI when the frame hides or hasn't been created
	end
	
	if ( Status["DataChanged"] or Status["SortingChanged"] ) then		
		buildIndex();
		Status["SortingChanged"] = false;
	end
	FauxScrollFrame_Update(frame.scroll, #(T["Index"]), MAX_ROW, 22);
	
	local usedRows = 0;
	
	--Update rows
	for index, itemId in pairs(T["Index"]) do				
		if( index > FauxScrollFrame_GetOffset(frame.scroll) and usedRows < MAX_ROW ) then
			usedRows = usedRows + 1
			
			local data = T["Data"][itemId];
			local row = T["Row"][usedRows];
			
			for columnId in pairs(row) do
				row[columnId]:SetText(formatData(data,columnId));
				row[columnId]:Show();
			end
			row["Item"].link = data["Link"];			
		end
	end
	
	-- Hide unused
	for i = usedRows + 1, 15 do
		local row = T["Row"][i]
		for columnId in pairs(row) do
			row[columnId]:Hide();
		end
	end

	if ( Status["DataChanged"] ) then
		-- Update total 
		if ( #T["Index"] ~=0 ) then	--Do not update if no data
			local total = summaryData();
			for columnId in pairs(T["Total"]) do
				T["Total"][columnId]:SetText(formatData(total,columnId));
			end
		end
		Status["DataChanged"] = false;
	end
end

--Change sorting states
local function sortColumn(this)		
	if( this.id ) then	
		if( this.id ~= AlchemyProcsOptions.sortColumn ) then
			local oldColumn;
			if ( AlchemyProcsOptions.sortColumn and T["Header"][AlchemyProcsOptions.sortColumn] ) then
				-- Restore the column header
				oldColumn = T["Header"][AlchemyProcsOptions.sortColumn];
			end
			AlchemyProcsOptions.sortOrder = true;
			if ( this.id == "Item" or this.id == "Made" ) then
				AlchemyProcsOptions.orderKey = nil;
			else
				AlchemyProcsOptions.orderKey = true;
			end
			AlchemyProcsOptions.sortColumn = this.id;
			if ( oldColumn ) then 
				updateColumnHeader(oldColumn);
			end
		else
			-- Change sort type			
			if ( not (AlchemyProcsOptions.sortOrder or AlchemyProcsOptions.orderKey) ) then
				AlchemyProcsOptions.sortColumn = nil;
			else
				AlchemyProcsOptions.sortOrder = not AlchemyProcsOptions.sortOrder;
				if ( AlchemyProcsOptions.sortOrder and AlchemyProcsOptions.orderKey ~= nil ) then
					AlchemyProcsOptions.orderKey = not AlchemyProcsOptions.orderKey;
				end
			end
		end
		
		updateColumnHeader(this);
		Status["SortingChanged"] = true;
		updateGUI();
	end
end

local offset = 15;
--Create column header
local function createHeader(columnId,width)	
	
	local header = CreateFrame("Button", nil, frame);
		
	header:SetPoint("TOPLEFT", offset, -20);
	header:SetScript("OnClick", sortColumn);
	header:SetTextFontObject(GameFontNormal);
	header:SetText("dummy");
	header:SetHeight(20);
	header:GetFontString():SetJustifyH("CENTER");
	header:SetWidth(width);
	offset = offset + width;
	
	header.id = columnId;	
	T["Header"][columnId] = header;
	updateColumnHeader(header);
		
	return header;
end

--Create font string
local FONT = "GameFontHighlightSmall";
local STYLE = "OVERLAY";
local function createFontString(anchor,width,offsetX,offsetY)	
	local fs = frame:CreateFontString(nil, STYLE, FONT);
	fs:SetPoint("TOPLEFT", anchor, "TOPLEFT", offsetX, offsetY);
	fs:SetWidth(width);	
	fs:SetJustifyH("RIGHT");
	return fs;
end

--Create GUI
local function createGUI()

	--Never change after creating
	MAX_ROW = AlchemyProcsOptions.maxRow;	
	PROC_COLUMN = AlchemyProcsOptions.showProc;		
	MAX_PROC_COLUMN = 0
	for i = 0,4 do 
		if ( PROC_COLUMN[i] ) then
			MAX_PROC_COLUMN = MAX_PROC_COLUMN + 1;
		end
	end
	
	local width = T["Width"]["Item"] + T["Width"]["Made"] + T["Width"]["Created"] + T["Width"]["Procs"] + T["Width"]["Proc"] * MAX_PROC_COLUMN + 65;
	
	frame:SetWidth( width );
	frame:SetHeight( MAX_ROW*18 + 100 );
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetClampedToScreen(true);
	frame:SetScript("OnShow",updateGUI);
	frame:SetToplevel(true);
	frame:SetFrameLevel(0);
	frame:Hide();
	
	frame:SetAttribute("UIPanelLayout-defined", true);
	frame:SetAttribute("UIPanelLayout-enabled", true);
 	frame:SetAttribute("UIPanelLayout-area", "doublewide");
	frame:SetAttribute("UIPanelLayout-whileDead", true);
	table.insert(UISpecialFrames, "AlchemyProcsFrame");

	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = {left = 10, right = 10, top = 10, bottom = 10},
	});
			
	frame:SetPoint("CENTER");	
	
	-- Create title
	local texture = frame:CreateTexture(nil, "ARTWORK");
	texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header");
	texture:SetPoint("TOP", 0, 12);
	texture:SetWidth(300);
	texture:SetHeight(60);
	
	local title = CreateFrame("Button", nil, frame);
	title:SetPoint("TOP", 0, 4);
	title:SetText(L["Title"]);
	title:SetPushedTextOffset(0, 0);

	title:SetTextFontObject(GameFontNormal);
	title:SetHeight(20);
	title:SetWidth(200);
	title:RegisterForDrag("LeftButton");	
	title:SetScript("OnDragStart", function(this)
		isMoving = true;
		frame:StartMoving();
	end);
	
	title:SetScript("OnDragStop", function(this)
		if( isMoving ) then
			isMoving = nil;
			frame:StopMovingOrSizing();
		end
	end)
	
	-- Close button
	local button = CreateFrame("Button", nil, frame, "UIPanelCloseButton");
	button:SetPoint("TOPRIGHT", -4, -4);
	button:SetScript("OnClick", function()
		Status["GUI"] = false;
		frame:Hide();
	end);
	
	-- Create headers
	local itemHeader = createHeader("Item",T["Width"]["Item"]);
	local madeHeader = createHeader("Made",T["Width"]["Made"]);
	local createdHeader = createHeader("Created",T["Width"]["Created"]);
	local procCountHeader = createHeader("Procs",T["Width"]["Procs"]);	
	local procHeader = {};
	local count = 0;
	for i = 0,4 do
		if ( PROC_COLUMN[i] ) then
			procHeader[i] = createHeader("Proc"..i,T["Width"]["Proc"]);
			count = count + 1;
		end
	end
	
	-- Create rows	
		
	for i=1, MAX_ROW do
		local item = CreateFrame("Button", nil, frame);
		item:SetWidth(T["Width"]["Item"]);
		item:SetHeight(10);		
		item:SetTextFontObject(GameFontHighlightSmall);		
		item:SetText("*");
		item:SetPushedTextOffset(0, 0);
		
		local fs = item:GetFontString();
		fs:SetWidth(T["Width"]["Item"])
		fs:SetHeight(10)
		fs:SetJustifyH("LEFT")						
		fs:SetPoint("LEFT", item, "LEFT");
		
		
		item:SetScript("OnEnter", function (this)		--Show item tooltip
			if ( this.link ) then
				GameTooltip:SetOwner(item, "ANCHOR_TOPLEFT");	
				GameTooltip:SetHyperlink(this.link);
				GameTooltip:Show();
			end
		end);
		item:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end);
		
		local row =  {};
		row["Item"] = item;
		if( i > 1 ) then			
			local x, y = 0 ,-18;
			item:SetPoint("TOPLEFT", T["Row"][i - 1]["Item"], "TOPLEFT", x, y);			
			row["Made"] = createFontString(T["Row"][i - 1]["Made"], T["Width"]["Made"], x, y);			
			row["Created"] = createFontString(T["Row"][i - 1]["Created"], T["Width"]["Created"], x, y);			
			row["Procs"] = createFontString(T["Row"][i - 1]["Procs"], T["Width"]["Procs"], x, y);						
			for j = 0,4 do
				if ( PROC_COLUMN[j] ) then
					row["Proc"..j] = createFontString(T["Row"][i - 1]["Proc"..j], T["Width"]["Proc"], x, y);
				end
			end
		else
			local x, y =1, -25;
			item:SetPoint("TOPLEFT", itemHeader, "TOPLEFT", x, y);			
			row["Made"] = createFontString(madeHeader, T["Width"]["Made"], x, y);			
			row["Created"] = createFontString(createdHeader, T["Width"]["Created"], x, y);			
			row["Procs"] = createFontString(procCountHeader, T["Width"]["Procs"], x, y);			
			for j = 0,4 do
				if ( PROC_COLUMN[j] ) then
					row["Proc"..j] = createFontString(procHeader[j], T["Width"]["Proc"], x, y);
				end
			end
		end	
		
		T["Row"][i] = row;
	end
				
	
	-- Make the three containers backdrops for style
	local headerContainer = CreateFrame("Frame", nil, frame);
	headerContainer:SetFrameStrata("LOW");
	headerContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -20);
	headerContainer:SetHeight( 25 );
	headerContainer:SetWidth( frame:GetWidth() - 20 );
	headerContainer:SetBackdrop({
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		edgeSize = 16,
		insets = { left = 2, right = 2, top = 2, bottom = 2 },
	});	
	
	local rowContainer = CreateFrame("Frame", nil, frame);
	rowContainer:SetFrameStrata("LOW");
	rowContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -20);
	rowContainer:SetHeight( MAX_ROW*18 + 25 );
	rowContainer:SetWidth( frame:GetWidth() - 20 );
	
	rowContainer:SetBackdrop({
		bgFile = "Interface\\TabardFrame\\TabardFrameBackground",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",		
		--edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 2, right = 2, top = 2, bottom = 2 },
	});
--	rowContainer:SetBackdropColor(0, 0, 0, 1);
--	rowContainer:SetBackdropBorderColor(0.75, 0.75, 0.75, 1);

	-- Scroll bar
	frame.scroll = CreateFrame("ScrollFrame", "AlchemyProcsScrollFrame", rowContainer, "FauxScrollFrameTemplate");
	frame.scroll:SetPoint("TOPLEFT", rowContainer, "TOPLEFT", 25, -30);
	frame.scroll:SetPoint("BOTTOMRIGHT", rowContainer, "BOTTOMRIGHT", -35, 10);
	frame.scroll:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(22, updateGUI) end);
	
	-- Total frame
	local totalContainer = CreateFrame("Frame", nil, frame);
	totalContainer:SetFrameStrata("LOW");
	totalContainer:SetPoint("TOPLEFT", rowContainer, "BOTTOMLEFT");
	totalContainer:SetHeight(40);
	totalContainer:SetWidth( frame:GetWidth() - 20 );
	
	totalContainer:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 2, right = 2, top = 2, bottom = 2 },
	});
--	totalContainer:SetBackdropColor(0, 0, 0, 1);
--	totalContainer:SetBackdropBorderColor(0.75, 0.75, 0.75, 1);

	-- Total Text
	local text = createFontString(T["Row"][MAX_ROW]["Item"], 60, 5, -35);
	text:SetTextColor(GameFontNormal:GetTextColor());
	text:SetText(L["Total"]);

	
	T["Total"] = {
		["Made"] = createFontString(T["Row"][MAX_ROW]["Made"], T["Width"]["Made"], 0, -35), -- Total made
		["Created"] = createFontString(T["Row"][MAX_ROW]["Created"], T["Width"]["Created"], 0, -35), -- Total created
		["Procs"] = createFontString(T["Row"][MAX_ROW]["Procs"], T["Width"]["Procs"], 0, -35),  -- Total proc count
	};
	
	-- Total procs
	for i = 0,4 do
		if ( PROC_COLUMN[i] ) then
			T["Total"]["Proc"..i] = createFontString(T["Row"][MAX_ROW]["Proc"..i], T["Width"]["Proc"], 0, -35)
		end
	end	

end

--Update data
function AlchemyProcs_UpdateData(itemId)
	if ( not itemId ) then	--Update all data
		local oldGUIStatus = GUIStatus;
		GUIStatus = nil;	--Suspend GUI update
		for itemId in pairs(AlchemyProcs) do
			if ( itemId ~= "Version" ) then	--Skip the version field
				AlchemyProcs_UpdateData(itemId);			
			end
		end
		GUIStatus = oldGUIStatus;
	else
		local data = AlchemyProcs[itemId];
		if ( data ) then
			local newData = {
				["Made"] = 0,
				["Created"] = 0,
			};
			local _,itemLink = GetItemInfo(itemId);
			if ( itemLink ) then 
				newData["Item"] = itemLink;
				newData["Link"] = itemLink;
			else
				newData["Item"] = L["Item"]..itemId;
			end
			local proc = {}
			local amountExpected;
			proc[0],proc[1],proc[2],proc[3],proc[4],amountExpected= string.split(":", AlchemyProcs[itemId]);			
			amountExpected = tonumber(amountExpected);
			for i = 0,4 do
				newData["Proc"..i] = tonumber(proc[i]);
				newData["Made"] = newData["Made"] + proc[i];
				newData["Created"] = newData["Created"] + proc[i]*( amountExpected + i );				
			end
			newData["Procs"] = newData["Made"] - newData["Proc0"];
			newData["Procs%"] = newData["Procs"] / newData["Made"];
			newData["Expected"] = newData["Made"] * amountExpected;
			newData["Created%"] = newData["Created"] / newData["Expected"];
			for i = 0,4 do
				newData["Proc"..i.."%"] = newData["Proc"..i] / newData["Made"];
			end
									
			T["Data"][itemId] = newData;
		else
			T["Data"][itemId] = nil;
		end
	end
	Status["DataChanged"] = true;
	updateGUI(true);
end

-- Conver old GUI options
local function converOldVersion(oldVersion)
	local newOptions = DefaultAlchemyProcsOptions;	
	AlchemyProcsOptions = newOptions;
	DEFAULT_CHAT_FRAME:AddMessage(L["GUI reseted"]);
end

function AlchemyProcs_ToggleGUI()
	if ( Status["GUI"] == nil ) then		
		if ( AlchemyProcsOptions.version ~= L["GUIVersion"] ) then
			converOldVersion(AlchemyProcsOptions.version)
		end
		createGUI();		
		AlchemyProcs_UpdateData();
	end
	Status["GUI"] = not Status["GUI"];
	if ( Status["GUI"] ) then
		frame:Show();
	else
		frame:Hide();
	end	
end

frame = CreateFrame("Frame", "AlchemyProcsFrame",UIParent);
frame:SetScript("OnEvent",AlchemyProcs_OnEvent);
frame:RegisterEvent("VARIABLES_LOADED");
frame:RegisterEvent("CHAT_MSG_LOOT");	
frame:RegisterEvent("TRADE_SKILL_SHOW");
