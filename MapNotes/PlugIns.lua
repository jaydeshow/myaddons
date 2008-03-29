--[[
	MapNotes: Adds a note system to the WorldMap and other AddOns that use the Plugins facility provided

	See the README file for more information.
]]

-- Global Variables to allow access from other Scripts. Other AddOns may add to the MAPNOTES_PLUGINS_LIST in order to take
--  advantage of MapNotes note making ability within their own code

MAPNOTES_PLUGINS_LIST = {};
MAPNOTES_DISABLED_PLUGINS = {};
			
-- AlphaMap
-- AlphaMap Registers its data and functions from within that AddOn itself
--  so see download and look at that AddOn for an example of how AddOns can 'Plug In' to MapNotes functionality

-- ATLAS PLUGIN CODE MOVED TO ITS OWN ADDON --

--MAPNOTES_PLUGINS_LIST.Atlas = {	name	= "Atlas",		-- Used internally by MapNotes to ensure returned Keys are unique
--				frame 	= "AtlasFrame",		-- Other AddOn's main frame on which to make notes (String)
--								--
--				keyVal 	= "Atlas_MN_Query",	-- Function to return a MapNotes Key for recording notes against.
--								--  Equals MapNotes own [Continent][Zone] key for organising notes.
--								-- Preferably, also return a Localised name associated with the Key
--				lclFnc	= "Atlas_MN_Localiser",	-- Return a Localised name based on a 'key' value--		initFnc	= "AlphaMap_MN_Initialise",	-- Can include a custom initialisation function
--				wmflag  = "1"			-- Indicates the Plugin will display (BlizzardFrame)World MapNotes
--								--  (See  AlphaMap (Fan's Update)  for an example)
--								--
--				initFnc	= "Atlas_MN_Init",	-- Can include an initialisation routine of your own that will execute
--								--  when the Plugin is Registered with MapNotes
--								--
--								-- BELOW NOT IMPLEMENTED ATM
--								-- Potentially add other controls such as ...
--		mBttn		= "RightButton",		--  What mouse button should be used for note creation
--		cKey1		= IsControlKeyDown,		--  What 'control' keys should be pressed in conjunction with the mouse
--		cKey2		= IsAltKeyDown,			--   before we create a note / open a MapNotes Menu...
--		cKey3		= IsShiftKeyDown,		--   (Remember 'control' keys are function names)
--		tt		= GameTooltip			--  Specify explicitly the tooltip to be displayed OnEnter...TipBuddy?
--};

MAPNOTES_ACTIVE_PLUGIN = nil;

local MapNotes_PlugInsMonitorInterval = 0.1;
local MapNotes_PlugInsRefreshInterval = 0.25;
local MapNotes_Plugin_Updating = nil;

MapNotes_PlugInFrames = {};

---------------------------------------------------------------------------------------------
-- Functions acting as Handlers for Specific PlugIns
-- NOTE That these could be written and included in the other AddOn and don't have to be included
-- in the base of MapNotes
---------------------------------------------------------------------------------------------

-- AlphaMap

-- AlphaMap Registers its data and functions from within that AddOn itself
--  so see download and look at that AddOn for an example of how AddOns can 'Plug In' to MapNotes functionality



-- Atlas

--function Atlas_MN_Query()
--	local key = nil;
--	local mapRaw = AtlasMap:GetTexture();
--
--	if ( mapRaw ) then
--		local i, l = 0;				-- note that 'l' is deliberately left 'nil' by this assignment
--		while ( true ) do
--			i = string.find(mapRaw, "\\", i+2);
--			if ( i ) then
--				l = i+1;
--			else
--				break;
--			end
--		end
--		if ( l ) then
--			key = string.sub(mapRaw, l);
--		end
--	end
--
--	return key;
--end

--function Atlas_MN_Localiser(key)
--	if ( AtlasText[key] ) then
--		return AtlasText[key].ZoneName;
--	end
--
--	return;
--end



-- ...



---------------------------------------------------------------------------------------------
-- General PlugIn Management
---------------------------------------------------------------------------------------------

function MapNotes_LoadPlugIns()
	-- Called after Variables are Loaded to initialise all 'natively supported' PlugIns
	-- (Which is currently none, as I felt Atlas Plugin code was best moved to its own AddOn)
	for index, values in pairs(MAPNOTES_PLUGINS_LIST) do
		local plugInFrame = getglobal(values.frame);
		if ( plugInFrame ) then
			MapNotes_RegisterPlugin(values);
		end
	end
end

function MapNotes_RegisterPlugin(Plugin)
	local plugInFrame = getglobal(Plugin.frame);
	-- Create a 'control' Frame over the other AddOn's main frame with an OnUpdate function
	--  so that we know when the other AddOn's frame IsVisible
	local ctrlName = Plugin.frame .."_MNControl";
	local ctrl = CreateFrame("Frame", ctrlName, plugInFrame);	-- Other AddOn's main frame is Parent so
	ctrl:SetScript("OnUpdate", MapNotes_PlugInsOnUpdate);		-- so only shows when other AddOn Frame IsVisible()
	ctrl.MapNotes_PlugInsMonitorTimer = 0;				-- and OnUpdate only executes when visible...
	ctrl.MapNotes_PlugInsRefreshTimer = 0;
	ctrl:SetAllPoints(plugInFrame);
	ctrl.Plugin = Plugin;
	ctrl.currentKey = "";
	ctrl:SetScript("OnShow", MapNotes_PlugInsDrawNotes);

	-- Create a Frame equivalent to the WorldMapButton, so that we can register Clicks for
	--  note creation
	local bttnName = Plugin.frame .."_MNOverlay";
	local bttn = CreateFrame("Button", bttnName, plugInFrame);
	bttn:SetAllPoints(plugInFrame);
	bttn:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	bttn:SetScript("OnClick", MapNotes_PlugInsOnClick);
	bttn:Hide();
	bttn.Plugin = Plugin;

	-- Create a Frame for the Drawing of Lines
	local lineFrameName = Plugin.frame .."_MNLinesFrame";
	local lineFrame = CreateFrame("Frame", lineFrameName, plugInFrame);
	lineFrame:SetAllPoints(plugInFrame);
	lineFrame:SetScript("OnShow", MapNotes_PlugInsOnShow);

	-- Allow Party notes on any Plugin frame
	local p = CreateFrame("Button", Plugin.name .. "PartyNote", plugInFrame, "WorldMapMapNotesMiscTemplate");
	p:SetID(1);
	p.note = "party";
	p.Plugin = Plugin;		-- 29/07/2007
	-- If Displaying WorldMap Notes, then create tloc notes
	if ( Plugin.wmflag ) then
		local t = CreateFrame("Button", Plugin.name .. "tlocNote", plugInFrame, "WorldMapMapNotesMiscTemplate");
		t:SetID(0);
		t.note = "tloc";		-- 29/07/2007
		t.Plugin = Plugin;		-- 29/07/2007
	end

	-- Create an entry in a second PlugIn array, so that we can look up a PlugIn's details from the XML Parent of a Note
	-- i.e. when we click on a note displayed in another AddOn, we can fetch the name of the Note's Parent Frame, and check
	--      this array for the relevant PlugIn details
	MapNotes_PlugInFrames[plugInFrame] = Plugin;

	-- Run the Plugin's associated Initialisation Script if it exists...
	if ( Plugin.initFnc ) then
		local initFnc = getglobal(Plugin.initFnc);
		if ( ( initFnc ) and ( type(initFnc) == "function" ) ) then
			initFnc();
		end
	end
end

-- All Plugins are 'Enabled' by default when Registered
-- This only needs to be used after a call to MapNotes_DisablePlugin()
function MapNotes_EnablePlugin(Plugin)
	if ( ( Plugin ) and ( MAPNOTES_DISABLED_PLUGINS[ Plugin.name ] ) ) then
		MAPNOTES_DISABLED_PLUGINS[ Plugin.name ] = nil;
		MapNotes_PlugInsDrawNotes(Plugin);
	end
end

function MapNotes_DisablePlugin(Plugin)
	if ( ( Plugin ) and ( not MAPNOTES_DISABLED_PLUGINS[ Plugin.name ] ) ) then
		MAPNOTES_DISABLED_PLUGINS[ Plugin.name ] = true;
		local overLay = getglobal( Plugin.frame .."MNOverlay" );
		if ( overLay ) then
			overLay:Hide();
		end
		MapNotes_PlugInsDrawNotes(Plugin);
	end
end

---------------------------------------------------------------------------------------------
-- The following functions are associated and used by ANY/ALL PlugIns, and are 'personalised'
--  to that AddOn by the changing value of "this", and 'local' variables associated with them
--  via dot notation, and passed parameters
-- e.g. "AlphaMapAlphaMapFrame_MNControl.MapNotes_PlugInsTimer" = "this.MapNotes_PlugInsTimer"
---------------------------------------------------------------------------------------------

function MapNotes_PlugInsGetKey(Plugin)
	if ( Plugin ) then
		local keyVal = getglobal(Plugin.keyVal);
		if ( type(keyVal) == "function" ) then
			local key = keyVal();
			if ( key ) then
				if ( not Plugin.wmflag ) then			-- Allow for Plugins editing real MapNotes
					key = (Plugin.name).." "..key;		--  which will already be prefixed with "WM "
				end						-- Otherwise, makes sure its unique per AddOn
				return key;
			end
		end
	end

	return nil;
end



function MapNotes_PlugInsOnUpdate()

	if ( not MAPNOTES_DISABLED_PLUGINS[ this.Plugin.name ] ) then
		-- Default OnUpdate arg1 = elapsed time since last OnUpdate
		-- "this" obviously referencing the Frame whose OnUpdate this is being executed for

		this.MapNotes_PlugInsMonitorTimer = this.MapNotes_PlugInsMonitorTimer + arg1;
		if ( this.MapNotes_PlugInsMonitorTimer > MapNotes_PlugInsMonitorInterval ) then
			local plugInFrame = this:GetParent();
			local plugInOverlay = getglobal( (plugInFrame:GetName()).."_MNOverlay" );

			-- Toggle a 'mouse interactive' frame that can capture mouse clicks for note creation
			-- Check frequently for pressing of Control key

			if ( IsControlKeyDown() ) then
				if ( not plugInOverlay:IsVisible() ) then
					plugInOverlay:Show();
				end
			else
				if ( plugInOverlay:IsVisible() ) then
					plugInOverlay:Hide();
				end
			end

			this.MapNotes_PlugInsMonitorTimer = 0;
		end

		this.MapNotes_PlugInsRefreshTimer = this.MapNotes_PlugInsRefreshTimer + arg1;
		if ( this.MapNotes_PlugInsRefreshTimer > MapNotes_PlugInsRefreshInterval ) then
			local key = MapNotes_PlugInsGetKey(this.Plugin);

			-- Check less frequently for a change in the other AddOns Key which will require an update to the displayed MapNotes
			-- Can force a 'relatively' quick update of the displayed MapNotes by resetting the value of .currentKey elsewhere.

			if ( this.currentKey ~= key ) then
				this.currentKey = key;
				MapNotes_PlugInsDrawNotes(this.Plugin);
			end

			this.MapNotes_PlugInsRefreshTimer = 0;
		end

	end
end



function MapNotes_PlugInsOnShow()
	this:SetFrameLevel( this:GetParent():GetFrameLevel() + 1 );
end



function MapNotes_PlugInsOnClick()

	-- Default OnClick arg1 = Mouse button clicked
	-- "this" obviously being the _MNOverlay frame that was clicked

	local mouseBttn = arg1;

	if ( mouseBttn == "RightButton" ) then				-- emulating MapNotes standard functionality
		local MapNotes_PlugInFrame = this:GetParent();
		local x, y = MapNotes_GetMouseXY(MapNotes_PlugInFrame);

		MAPNOTES_ACTIVE_PLUGIN = this.Plugin;

		if ( IsShiftKeyDown() ) then
			if ( MAPNOTES_ACTIVE_PLUGIN.wmflag ) then
				MapNotes_SetPartyNote(x, y);	
			else
				local key = MapNotes_PlugInsGetKey(MAPNOTES_ACTIVE_PLUGIN);
				MapNotes_SetPartyNote(x, y, key);
				MapNotes_PlugInsDrawNotes(MAPNOTES_ACTIVE_PLUGIN);
			end

		elseif ( IsAltKeyDown() ) then				-- Telic_Beta_1
			if ( MAPNOTES_ACTIVE_PLUGIN.wmflag ) then
				MapNotes_ShortCutNote(x, y);
				MapNotes_MapUpdate();
			else
				MapNotes_ShortCutNote(x, y, MAPNOTES_ACTIVE_PLUGIN);
				MapNotes_PlugInsDrawNotes(MAPNOTES_ACTIVE_PLUGIN);
			end

		else
			local key = MapNotes_PlugInsGetKey(MAPNOTES_ACTIVE_PLUGIN);

			if ( key ) then
				MapNotesButtonNewNote:Enable();
				MapNotes_ShowNewFrame(x, y, MapNotes_PlugInFrame);
			end
		end
	end
end



function MapNotes_PlugInsRefresh()
	for frame, Plugin in pairs(MapNotes_PlugInFrames) do
		if ( frame:IsVisible() ) then
			MapNotes_PlugInsDrawNotes(Plugin);
		end
	end
end



function MapNotes_PlugInsDrawNotes(Plugin)
	if ( ( not Plugin ) or ( not MapNotes_Options.aFactor ) ) then
		Plugin = this.Plugin;
	end

	if ( ( not Plugin ) or ( not Plugin.name ) ) then	-- Some dodgy calls arriving...?
		return;
	end

	if ( MapNotes_Plugin_Updating ) then
		return;
	end

	MapNotes_Plugin_Updating = true;

	local nNotes, nLines = 1, 1;
	local key = MapNotes_PlugInsGetKey(Plugin);
	local plugInFrame = getglobal( Plugin.frame );
	local width = plugInFrame:GetWidth();
	local height = plugInFrame:GetHeight();

	if ( key ) then
		if ( not MapNotes_Data_Notes[key] ) then
			MapNotes_Data_Notes[key] = {};
			MapNotes_Data_Lines[key] = {};
		end

		if ( ( MapNotes_Options.shownotes ) and ( not MAPNOTES_DISABLED_PLUGINS[ Plugin.name ] ) ) then
			local currentZone = MapNotes_Data_Notes[key];
			local currentLineZone = MapNotes_Data_Lines[key];
			local POI, POIMininote, POIHighlight, POILastnote, POIName;
			local findIn;
			
			for i, value in ipairs(currentZone) do
				POI = MapNotes_AssignPOI(i, Plugin);	-- fetches with getglobal, or creates if doesn't exist yet
				POIName = POI:GetName();
				local xOffset = (currentZone[i].xPos * width);
				local yOffset = -(currentZone[i].yPos * height);
				POI:SetUserPlaced(false);
				POI:ClearAllPoints();
				POI:SetPoint("CENTER", plugInFrame, "TOPLEFT", xOffset, yOffset);
				-- Custom
				POITexture = getglobal(POIName.."Texture");
				POIMininote = getglobal(POIName.."Mininote");
				POILastnote = getglobal(POIName.."Lastnote");
				POIHighlight = getglobal(POIName.."Highlight");
				POITexture:SetTexture(nil);
				if ( currentZone[i].customIcon ) then
					POITexture:SetTexture( currentZone[i].customIcon );
				end
				local txtr = POITexture:GetTexture();
				if ( not txtr ) then
					POITexture:SetTexture(MN_POI_ICONS_PATH.."\\Icon"..currentZone[i].icon);
				end

				findIn = string.lower(value.name);
				if ( ( MapNotes_HighlightedNote ~= "" ) and ( string.find( findIn, MapNotes_HighlightedNote ) ) ) then
					POIHighlight:Show();
					if ( ( findIn == MapNotes_HighlightedNote ) and ( MapNotes_Options[13] ~= "off" ) ) then
						-- Custom
						POIMininote:Show();
					end
				-- Custom
				elseif ( ( currentZone[i].mininote ) and ( MapNotes_Options[13] ~= "off" ) ) then
					POIMininote:Show();
					POIHighlight:Hide();

				else
					POIMininote:Hide();
					POIHighlight:Hide();
				end

				if MapNotes_Options[currentZone[i].icon] ~= "off" then
					if ( ( ( MapNotes_Options[10] ~= "off" ) and ( currentZone[i].creator == UnitName("player") ) )
					or ( ( MapNotes_Options[11] ~= "off" ) and ( currentZone[i].creator ~= UnitName("player") ) ) ) then
						POI:SetWidth( MapNotes_Options.iFactor );
						POIMininote:SetWidth( MapNotes_Options.iFactor + MAPNOTES_BORDER );
						POI:SetHeight( MapNotes_Options.iFactor );
						POIMininote:SetHeight( MapNotes_Options.iFactor + MAPNOTES_BORDER );
						POI:SetAlpha( MapNotes_Options.aFactor );
						POILastnote:Hide();
						POI:Show();
					end
				else
					POI:Hide();
				end
				nNotes = nNotes + 1;
			end

			if ( MapNotes_Options[12] ~= "off" ) then
				if ( ( POI ) and ( POI:IsVisible() ) ) then
					POILastnote:SetWidth( MapNotes_Options.iFactor + MAPNOTES_BORDER );
					POILastnote:SetHeight( MapNotes_Options.iFactor + MAPNOTES_BORDER );
					POILastnote:Show();
				end
			end
			
			if ( currentLineZone ) then
				for i, line in ipairs(currentLineZone) do
					MapNotes_DrawLine(i, line.x1, line.y1, line.x2, line.y2, Plugin);
					nLines = nLines + 1;
				end
			end
		end
	end

	local POI = getglobal( (Plugin.frame) .. "POI" .. nNotes );
	while ( POI ) do
		POI:Hide();
		nNotes = nNotes + 1;
		POI = getglobal( (Plugin.frame) .. "POI" .. nNotes );
	end

	local otherLines = getglobal( (Plugin.frame) .. "_MNLinesFrameLines_" .. nLines );
	while ( otherLines ) do
		otherLines:Hide();
		nLines = nLines + 1;
		otherLines = getglobal( (Plugin.frame) .. "_MNLinesFrameLines_" .. nLines );
	end

	-- tloc button
	local tlocNote = getglobal(Plugin.name .. "tlocNote");
	if ( tlocNote ) then
		if ( ( MapNotes_tloc_xPos ) and ( MapNotes_tloc_key == key ) ) then
			local tlocNoteTexture = getglobal(Plugin.name .. "tlocNoteTexture");
			local tlocNoteMininote = getglobal(Plugin.name .. "tlocNoteMininote");
			if ( tlocNoteTexture ) then
				tlocNoteTexture:SetTexture(nil);
				if ( MN_TLOC_ICON ) then
					tlocNoteTexture:SetTexture(MN_TLOC_ICON);
				end
				local txtr = tlocNoteTexture:GetTexture();
				if ( not txtr ) then
					if ( MN_TLOC_ICON ) then MN_TLOC_ICON = nil; end
					tlocNoteTexture:SetTexture(MN_POI_ICONS_PATH.."\\Icontloc");
				end
			end
			if ( ( MapNotes_Options[13] ~= "off" ) and ( MapNotes_MiniNote_Data.icon == "tloc" ) ) then
				tlocNoteMininote:SetWidth( MapNotes_Options.iFactor + MAPNOTES_BORDER );
				tlocNoteMininote:SetHeight( MapNotes_Options.iFactor + MAPNOTES_BORDER );
				tlocNoteMininote:Show();
			else
				tlocNoteMininote:Hide();
			end
			xOffset = MapNotes_tloc_xPos * width;
			yOffset = -MapNotes_tloc_yPos * height;
			tlocNote:SetPoint("CENTER", Plugin.frame, "TOPLEFT", xOffset, yOffset);
			tlocNote:SetWidth( MapNotes_Options.iFactor );
			tlocNote:SetHeight( MapNotes_Options.iFactor );
			tlocNote:SetAlpha( MapNotes_Options.aFactor );
			tlocNote:Show();
		else
			tlocNote:Hide();
		end
	end

	-- party note
	local partyNote = getglobal(Plugin.name .. "PartyNote");
	if ( partyNote ) then
		if ( ( MapNotes_PartyNoteData.xPos ) and ( key == MapNotes_PartyNoteData.key ) ) then		--Telic_5
			local partyNoteTexture = getglobal(Plugin.name .. "PartyNoteTexture");
			local partyNoteMininote = getglobal(Plugin.name .. "PartyNoteMininote");
			partyNoteTexture:SetTexture(nil);
			if ( MN_PARTY_ICON ) then			-- 5.60
				partyNoteTexture:SetTexture(MN_PARTY_ICON);									-- 5.60
			end
			local txtr = partyNoteTexture:GetTexture();
			if ( not txtr ) then																	-- 5.60
				if ( MN_PARTY_ICON ) then MN_PARTY_ICON = nil; end
				partyNoteTexture:SetTexture(MN_POI_ICONS_PATH.."\\Iconparty");
			end
			if MapNotes_Options[13] ~= "off" and MapNotes_MiniNote_Data.icon == "party" then
				partyNoteMininote:SetWidth( MapNotes_Options.iFactor + MAPNOTES_BORDER );
				partyNoteMininote:SetHeight( MapNotes_Options.iFactor + MAPNOTES_BORDER );
				partyNoteMininote:Show();
			else
				partyNoteMininote:Hide();
			end
			xOffset = (MapNotes_PartyNoteData.xPos * width);
			yOffset = (-MapNotes_PartyNoteData.yPos * height);
			partyNote:SetPoint("CENTER", Plugin.frame, "TOPLEFT", xOffset, yOffset);
			partyNote:SetWidth( MapNotes_Options.iFactor );
			partyNote:SetHeight( MapNotes_Options.iFactor );
			partyNote:SetAlpha( MapNotes_Options.aFactor );
			partyNote:Show();
		else
			partyNote:Hide();
		end
	end

	if ( ( Plugin.wmflag ) and ( not MapNotesFU_Drawing ) ) then
		MapNotes_MapUpdate();
	end

	MapNotes_Plugin_Updating = nil;
end



function MapNotes_PlugInsNoteOnEnter(Plugin, n_id, note)
	local key = MapNotes_PlugInsGetKey(Plugin);

	if ( ( key ) and ( note ) ) then
		local pluginFrame = getglobal(Plugin.frame);
		local x, y = note:GetCenter();
		local x2, y2 = pluginFrame:GetCenter();
		local anchor = "";
		if x > x2 then
			anchor = "ANCHOR_LEFT";
		else
			anchor = "ANCHOR_RIGHT";
		end

		local noteDetails = MapNotes_Data_Notes[key][n_id];
		local cRef = noteDetails.ncol;
		local colours = MapNotes_Colors[cRef];
		if ( MapNotes_Options.colourT[1][cRef] ) then
			colours = MapNotes_Options.colourT[1][cRef];
		end
		GameTooltip:SetOwner(note, anchor);
		GameTooltip:SetText(noteDetails.name, colours.r, colours.g, colours.b);
		if ( ( noteDetails.inf1 ~= nil ) and ( noteDetails.inf1 ~= "" ) ) then
			cRef = noteDetails.in1c;
			colours = MapNotes_Colors[cRef];
			if ( MapNotes_Options.colourT[2][cRef] ) then
				colours = MapNotes_Options.colourT[2][cRef];
			end
			GameTooltip:AddLine(noteDetails.inf1, colours.r, colours.g, colours.b);
		end
		if ( ( noteDetails.inf2 ~= nil ) and ( noteDetails.inf2 ~= "" ) ) then
			cRef = noteDetails.in2c;
			colours = MapNotes_Colors[cRef];
			if ( MapNotes_Options.colourT[3][cRef] ) then
				colours = MapNotes_Options.colourT[3][cRef];
			end
			GameTooltip:AddLine(noteDetails.inf2, colours.r, colours.g, colours.b);
		end
		if ( ( noteDetails.creator ) and ( noteDetails.creator ~= "" ) ) then
			GameTooltip:AddDoubleLine(MAPNOTES_CREATEDBY, noteDetails.creator, 0.79, 0.69, 0.0, 0.79, 0.69, 0.0)
		end
		GameTooltip:SetFrameStrata("TOOLTIP");
		GameTooltip:SetFrameLevel( note:GetFrameLevel() + 2 );
		GameTooltip:Show();

	else
		GameTooltip:Hide();			-- Covering all bases, by
		WorldMapTooltip:Hide();		--  hiding both main Tooltips
	end
end
