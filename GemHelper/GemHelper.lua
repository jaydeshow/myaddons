--[[	****************************************************************************************
	GemHelper v1.5
	15 November 2007
	(Written for live servers v2.3.0.7561)

	Author: Xinhuan @ US Blackrock Alliance
	****************************************************************************************
	Description:
		Search, filter and craft gems in the game!

		For non-Jewelcrafters, GemHelper serves as a encyclopedia for gems much like
		what AtlasLoot Enhanced is for instance and reputation loot. With many search
		filters for the exact gem colours, stats and materials, users can quickly find
		the best gem to socket into their new equipment without having to harass a
		Jewelcrafter or check a website about what gems are available.

		For Jewelcrafters, GemHelper goes a step further and allows users to craft gems
		directly from the GemHelper UI with extra options such as "Have Materials" that
		Enchanters currently have. Jewelcrafters are also able to replace the default
		Blizzard Jewelcrafting UI.

		The gem tooltips will list the materials needed to craft it or the location
		where the gem can be found/purchased. Currently, the database contains 206 gems.
		All gems should be (more or less) safe to query the server for (the link)
		because if someone has the gem on the server (in inventory, bank or socketted
		in gear) and has logged on since the last server reboot, it will be safe to
		query.

		To use GemHelper, type /gh or /gemhelper ingame. If you are a Jewelcrafter, you
		open the GemHelper window by pressing the Jewelcrafting button on your actionbar
		or spellbook.

		This addon can be used along with GemList, CraftList, CraftList2, ATSW, Skillet.

	Quirks:
		If you open the GemHelper window via the slash command (/gh or /gemhelper), you
		will not be able to craft gems from it. You must open the GemHelper window via
		the Jewelcrafting button on your actionbars/spellbook. This is NOT a bug and is
		a limitation of the WoW game engine.

	What I need:
		Localization needed for Spanish.
		GemHelper will currently work for English, French, German, Taiwan, Chinese and
		Korean clients.

		If you would like to help with localization, send me your localization LUA file
		at xinhuan@gmail.com for the various languages and name your email subject
		topic "GemHelper Localization".

	Credits:
		Beta Testers: Astrae, Karenwise
		And many thanks to my guild members for helping with gems!
	****************************************************************************************

]]

-- 5 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.1
-- Creation of addon, basic frames and checkbuttons.
-- Code to save the state of checkbuttons.
-- Added slash command.

-- 8 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.2
-- Added gem data tables.

-- 9 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.3
-- Added search/filter functions.

-- 10 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.4
-- Added display window, and itemlinking.

-- 11 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.5
-- Added server querying of unsafe links.
-- Added filters for jewelcrafting, enchanting, vendor and instance drop gems.

-- 12 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.6
-- Added more epic gems to database.

-- 20 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.7
-- Added ability to craft gems from GemHelper directly if you are a Jewelcrafter.
-- Added ability to move the GemHelper window.
-- Added sorting of gem list by rarity.

-- 25 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.8
-- Added option to replace the default UI JC tradeskill window.
-- Added even more epic gems to the database.
-- Added english localization.

-- 26 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.8.1
-- Made the gem materials under the "Filter by Material" section linkable.
-- Changed the GemHelper window to be on the same framestrata as most windows so that they will be brough up to the top when clicked on.
-- Removed the spam "beta message" that occurs on opening the GemHelper window.
-- Fixed the "+" button that opens the default UI JC tradeskill window to toggle properly.

-- 28 February 2007, by Xinhuan @ Blackrock US Alliance: Version 0.9
-- Added "That I Can Craft" filter for Jewelcrafters. This option is disabled for non-JCs.
-- Added "Have Materials" filter option.
-- Added buttons to collapse/expand filtering options.
-- Moved gem data to its own file. Moved localization data to their own files.

-- 8 March 2007, by Xinhuan @ Blackrock US Alliance: Version 1.0
-- Added descriptions for materials/costs/locations of gems.
-- Added a "close" button at the upper right corner.
-- Added more gems from heroic instances to the database, hopefully the epic gems database from heroics should be complete now.
-- Added ability to remember/show what your other chars can craft when not on your main character.
-- When a meta gem cooldown timer is active, the meta gem tooltips will now show the cooldown timer. Hovering the mouse over the Create/Create All button (if they are enabled) will also show it.
-- Added buttons to reset/clear the filtering options.
-- Fixed a bug that resetted the number of gems to craft back to 1 on using the Create button.

-- 22 March 2007, by Xinhuan @ Blackrock US Alliance: Version 1.1
-- Added 11 missing epic gems to the database from heroic instances.
-- Added German and French localization.
-- Added the ability to set GemHelper's background color/opacity.
-- GemHelper will now cooperate with AdvancedTradeSkillWindow (it will treat ATSW as though it is the default UI).
-- You can now shift-click a link in GemHelper to add the name to the AH window.

-- 6 June 2007, by Xinhuan @ Blackrock US Alliance: Version 1.2
-- Written for live servers v2.1.1.6739. TOC Update to 20100.
-- Added 9 gems to the database which are introduced in patch v2.1.
-- Did NOT add the new gems available from Black Temple/Hyjal. The server will disconnect you for querying the itemlink as few guilds have even stepped in there worldwide.
-- Don't ask about the 20 other new gems that can be found on wowhead/allakhazam databases. They don't exist in game yet.
-- Updated German and French localization.

-- 9 August 2007, by Xinhuan @ Blackrock US Alliance: Version 1.3
-- Written for live servers v2.1.3.6898.
-- GemHelper will no longer open automatically if the "Replace default JC UI" checkbox is off. Use /gh or /gemhelper.
-- Added 43 gems to the database from Halaa, Blade's Edge Mountains, Black Temple and Hyjal.
-- Removed the final boss names from heroic instance drop gems since any boss in that instance may now drop it.
-- Updated the price of the pvp gems.
-- Added Taiwan localization.
-- GemHelper is now more memory friendly and will no longer generate garbage to be collected.

-- 14 August 2007, by Xinhuan @ Blackrock US Alliance: Version 1.31
-- Written for live servers v2.1.3.6898.
-- GemHelper will no longer perform checks/updates behind the scene when not shown.
-- GemHelper will now use AddonLoader if present to delay loading until needed.
-- Some minor changes to reduce CPU and memory usage.
-- Fixed a few minor issues for the French localization.

-- 26 September 2007, by Xinhuan @ Blackrock US Alliance: Version 1.4
-- Written for live servers v2.2.0.7272. TOC Update to 20200.
-- Fixed base epic gems being unlinkable.
-- Added 8 new gems that are craftable from designs available from the various faction reputations and Halaa.
-- Updated localization where possible.
-- Updated Unstable Talasite colors.

-- 10 October 2007, by Xinhuan @ Blackrock US Alliance: Version 1.41
-- Written for live servers v2.2.3.7359.
-- Added the 5 uncommon quality gems introduced in patch 2.2.2.
-- Updated localizations where possible.
-- Fixed spelling error for Blood of Ember to Blood of Amber.
-- GemHelper will now cooperate with Skillet (it will treat Skillet as though it is the default UI). Skillet is an Ace2 addon similar to ATSW.

-- 15 November 2007, by Xinhuan @ Blackrock US Alliance: Version 1.5
-- Written for live servers v2.3.0.7561.
-- Added Chaotic Skyfire Diamond introduced in patch 2.3.0.
-- Added localization for Korea and China. Updated localizations for the rest.
-- Added Charmed Amani Jewel from Zul'Aman.
-- Fixed an issue that can potentially result in the X, Options and other buttons being shown near the minimap.


---------------------------------------------------------
-- Local variables

local GEMHELPER_DISP_HEIGHT	= 16;
local GEMHELPER_ITEMS_SHOWN	= 8;

-- For setting up use
local GemHelper_CheckButtonIndexes = {	1, 2, 3,
					11, 12, 13, 14,
					21, 22, 23, 24, 25, 26, 27,
					31, 32, 33, 34, 35, 36, 37,
					41, 42,
					51, 52, 53, 54, 55, 56,
					61, 62, 63, 64, 65, 66,
					71, 72, 73, 74, 75, 76,
					80, 81, 82, 83, 84, 85, 86,
					101, 102, 103, 104,
					1011, 1012,
					111 };
-- For filtering use
local GemHelper_GCheckButtonIndexes = { {11, 12, 13, 14},
					{21, 22, 23, 24, 25, 26, 27,
					31, 32, 33, 34, 35, 36, 37,
					41, 42,
					51, 52, 53, 54, 55, 56},
					{61, 62, 63, 64, 65, 66,
					71, 72, 73, 74, 75, 76,
					80, 81, 82, 83, 84, 85, 86},
					{101, 102, 103, 104},
					[101] = {1011, 1012} };
-- For collapsing use
local GemHelper_CollapseHeight	= { {50, 30},
				{170, 30},
				{150, 30} };

local GemHelper_DispResults = {};
local selectedGemID = nil;
local info = {};
local bagScan = {};

-- Localize some globals
local tsort, tinsert = table.sort, tinsert;
local pairs, ipairs = pairs, ipairs;
local strfind, strsplit, gsub = strfind, strsplit, gsub;
local GetItemInfo, GetContainerItemLink = GetItemInfo, GetContainerItemLink;
local GetTradeSkillItemLink, GetTradeSkillInfo = GetTradeSkillItemLink, GetTradeSkillInfo;
local GameTooltip = GameTooltip;


---------------------------------------------------------
-- Gem Helper functions

local function GemHelper_Init()
	local checkButton, checkButtonText;
	local CreateFrame = CreateFrame;

	if (not GemHelper_Save) then
		-- SavedVariable
		GemHelper_Save = {};
	end

	if (not GemHelper_SaveCraft) then
		-- SavedVariable
		GemHelper_SaveCraft = {};
	end

	-- Background color defaults
	if (not GemHelper_Save.r) then GemHelper_Save.r = 0; end
	if (not GemHelper_Save.g) then GemHelper_Save.g = 0; end
	if (not GemHelper_Save.b) then GemHelper_Save.b = 0; end
	if (not GemHelper_Save.a) then GemHelper_Save.a = 0.5; end
	GemHelper_Frame:SetBackdropColor(GemHelper_Save.r, GemHelper_Save.g, GemHelper_Save.b, GemHelper_Save.a);
	GemHelper_ColorSwatchNormalTexture:SetVertexColor(GemHelper_Save.r, GemHelper_Save.g, GemHelper_Save.b);

	-- Default positioning
	if (not GemHelper_Save.pospoint) then
		GemHelper_Save.pospoint = "TOPLEFT";
		GemHelper_Save.posrelpoint = "TOPLEFT";
		GemHelper_Save.posoffsetx = 300;
		GemHelper_Save.posoffsety = -150;
	end
	GemHelper_Frame:ClearAllPoints();
	GemHelper_Frame:SetPoint(GemHelper_Save.pospoint, nil, GemHelper_Save.posrelpoint, GemHelper_Save.posoffsetx, GemHelper_Save.posoffsety);
	GemHelper_Frame:SetUserPlaced(nil);

	for k, v in ipairs(GemHelper_CheckButtonIndexes) do
		if (GemHelper_Save[v] == nil) then
			-- SavedVariable Defaults
			if (v == 101) then
				GemHelper_Save[v] = true;
			else
				GemHelper_Save[v] = false;
			end
		end
		checkButton = CreateFrame("CheckButton", "GemHelper_CheckButton"..v, GemHelper_Frame, "GemHelperCheckButtonTemplate");
		checkButton:SetID(v);
		checkButton:SetFrameLevel(checkButton:GetFrameLevel() + 1);
		checkButtonText = getglobal("GemHelper_CheckButton"..v.."Text");
		checkButtonText:SetText(GEMHELPER_CHECKBUTTON_TEXT[v]);
		checkButton:SetHitRectInsets(5, -(checkButtonText:GetWidth() + 5), 5, 5)
		checkButton:SetChecked(GemHelper_Save[v]);
	end

	for v = 1, 4 do
		checkButton = CreateFrame("CheckButton", "GemHelper_Background"..v, GemHelper_Frame, "GemHelperOptionBackground");
	end

	for v = 1, 3 do
		checkButton = CreateFrame("Button", "GemHelper_CollapseButton"..v, GemHelper_Frame, "GemHelper_CollapseButtonTemplate");
		RaiseFrameLevel(checkButton);
		checkButton:SetID(v);
		checkButton:SetPoint("TOPRIGHT", getglobal("GemHelper_Background"..v), "TOPRIGHT", -3, -3);
		if (GemHelper_Save[-v] == nil) then
			-- SavedVariable Defaults
			GemHelper_Save[-v] = false;
		end

		checkButton = CreateFrame("Button", "GemHelper_ResetButton"..v, GemHelper_Frame, "GemHelper_ResetButtonTemplate");
		RaiseFrameLevel(checkButton);
		checkButton:SetID(v);
		checkButton:SetPoint("TOPRIGHT", getglobal("GemHelper_CollapseButton"..v), "TOPLEFT", 5, 0);
	end

	GemHelper_CheckButton1:SetPoint("TOPLEFT", GemHelper_Frame, "TOPLEFT", 25, -20);
	GemHelper_CheckButton11:SetPoint("TOPLEFT", GemHelper_CheckButton1, "BOTTOMLEFT", 25, 12);
	GemHelper_CheckButton12:SetPoint("TOPLEFT", GemHelper_CheckButton1, "BOTTOMLEFT", 125, 12);
	GemHelper_CheckButton13:SetPoint("TOPLEFT", GemHelper_CheckButton1, "BOTTOMLEFT", 225, 12);
	GemHelper_CheckButton14:SetPoint("TOPLEFT", GemHelper_CheckButton1, "BOTTOMLEFT", 325, 12);

	GemHelper_CheckButton2:SetPoint("TOPLEFT", GemHelper_CheckButton1, "TOPLEFT", 0, -GemHelper_CollapseHeight[1][1]);
	GemHelper_CheckButton21:SetPoint("TOPLEFT", GemHelper_CheckButton2, "BOTTOMLEFT", 25, 12);
	GemHelper_CheckButton22:SetPoint("TOPLEFT", GemHelper_CheckButton21, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton23:SetPoint("TOPLEFT", GemHelper_CheckButton22, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton24:SetPoint("TOPLEFT", GemHelper_CheckButton23, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton25:SetPoint("TOPLEFT", GemHelper_CheckButton24, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton26:SetPoint("TOPLEFT", GemHelper_CheckButton25, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton27:SetPoint("TOPLEFT", GemHelper_CheckButton26, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton31:SetPoint("TOPLEFT", GemHelper_CheckButton2, "BOTTOMLEFT", 175, 12);
	GemHelper_CheckButton32:SetPoint("TOPLEFT", GemHelper_CheckButton31, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton33:SetPoint("TOPLEFT", GemHelper_CheckButton32, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton34:SetPoint("TOPLEFT", GemHelper_CheckButton33, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton35:SetPoint("TOPLEFT", GemHelper_CheckButton34, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton36:SetPoint("TOPLEFT", GemHelper_CheckButton35, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton37:SetPoint("TOPLEFT", GemHelper_CheckButton36, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton51:SetPoint("TOPLEFT", GemHelper_CheckButton2, "BOTTOMLEFT", 325, 12);
	GemHelper_CheckButton52:SetPoint("TOPLEFT", GemHelper_CheckButton51, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton53:SetPoint("TOPLEFT", GemHelper_CheckButton52, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton54:SetPoint("TOPLEFT", GemHelper_CheckButton53, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton55:SetPoint("TOPLEFT", GemHelper_CheckButton54, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton56:SetPoint("TOPLEFT", GemHelper_CheckButton55, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton42:SetPoint("TOPLEFT", GemHelper_CheckButton2, "TOPLEFT", 175, 0);
	GemHelper_CheckButton41:SetPoint("TOPLEFT", GemHelper_CheckButton2, "TOPLEFT", 325, 0);

	GemHelper_CheckButton3:SetPoint("TOPLEFT", GemHelper_CheckButton2, "TOPLEFT", 0, -GemHelper_CollapseHeight[2][1]);
	GemHelper_CheckButton61:SetPoint("TOPLEFT", GemHelper_CheckButton3, "BOTTOMLEFT", 25, 12);
	GemHelper_CheckButton62:SetPoint("TOPLEFT", GemHelper_CheckButton61, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton63:SetPoint("TOPLEFT", GemHelper_CheckButton62, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton64:SetPoint("TOPLEFT", GemHelper_CheckButton63, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton65:SetPoint("TOPLEFT", GemHelper_CheckButton64, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton66:SetPoint("TOPLEFT", GemHelper_CheckButton65, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton71:SetPoint("TOPLEFT", GemHelper_CheckButton3, "BOTTOMLEFT", 325, 12);
	GemHelper_CheckButton72:SetPoint("TOPLEFT", GemHelper_CheckButton71, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton73:SetPoint("TOPLEFT", GemHelper_CheckButton72, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton74:SetPoint("TOPLEFT", GemHelper_CheckButton73, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton75:SetPoint("TOPLEFT", GemHelper_CheckButton74, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton76:SetPoint("TOPLEFT", GemHelper_CheckButton75, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton80:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 175, 0);
	GemHelper_CheckButton81:SetPoint("TOPLEFT", GemHelper_CheckButton3, "BOTTOMLEFT", 175, 12);
	GemHelper_CheckButton82:SetPoint("TOPLEFT", GemHelper_CheckButton81, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton83:SetPoint("TOPLEFT", GemHelper_CheckButton82, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton84:SetPoint("TOPLEFT", GemHelper_CheckButton83, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton85:SetPoint("TOPLEFT", GemHelper_CheckButton84, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton86:SetPoint("TOPLEFT", GemHelper_CheckButton85, "BOTTOMLEFT", 0, 12);

	GemHelper_CheckButton101:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 275, -GemHelper_CollapseHeight[3][1]);
	GemHelper_CheckButton1011:SetPoint("TOPLEFT", GemHelper_CheckButton101, "BOTTOMLEFT", 25, 12);
	GemHelper_CheckButton1012:SetPoint("TOPLEFT", GemHelper_CheckButton1011, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton102:SetPoint("TOPLEFT", GemHelper_CheckButton1012, "BOTTOMLEFT", -25, 12);
	GemHelper_CheckButton103:SetPoint("TOPLEFT", GemHelper_CheckButton102, "BOTTOMLEFT", 0, 12);
	GemHelper_CheckButton104:SetPoint("TOPLEFT", GemHelper_CheckButton103, "BOTTOMLEFT", 0, 12);

	-- Adjust for longer string lengths for French
	if (GetLocale() == "frFR") then
		GemHelper_CheckButton12:SetPoint("TOPLEFT", GemHelper_CheckButton1, "BOTTOMLEFT", 140, 12);
		GemHelper_CheckButton13:SetPoint("TOPLEFT", GemHelper_CheckButton1, "BOTTOMLEFT", 255, 12);
		GemHelper_CheckButton14:SetPoint("TOPLEFT", GemHelper_CheckButton1, "BOTTOMLEFT", 370, 12);
		GemHelper_CheckButton31:SetPoint("TOPLEFT", GemHelper_CheckButton2, "BOTTOMLEFT", 195, 12);
		GemHelper_CheckButton42:SetPoint("TOPLEFT", GemHelper_CheckButton2, "TOPLEFT", 195, 0);
		GemHelper_CheckButton71:SetPoint("TOPLEFT", GemHelper_CheckButton3, "BOTTOMLEFT", 345, 12);
	end

	GemHelper_CheckButton111:SetPoint("LEFT", GemHelper_CreateButton, "RIGHT", 0, 0);
	if (GemHelper_isJewelcrafter()) then
		GemHelper_CheckButton111:Enable();
	else
		GemHelper_CheckButton111:Disable();
	end

	for v = 1, GEMHELPER_ITEMS_SHOWN do
		checkButton = CreateFrame("Button", "GemHelper_ItemButton"..v, GemHelper_Frame, "GemHelper_ItemButtonTemplate");
		RaiseFrameLevel(checkButton);
		if (v == 1) then
			checkButton:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[3][1] - 5);
		else
			checkButton:SetPoint("TOPLEFT", getglobal("GemHelper_ItemButton"..v-1), "BOTTOMLEFT", 0, 0);
		end
	end

	checkButton = CreateFrame("ScrollFrame", "GemHelper_ListScrollFrame", GemHelper_Frame, "FauxScrollFrameTemplate");
	GemHelper_ListScrollFrame:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[3][1] - 5);
	GemHelper_ListScrollFrame:SetWidth(GemHelper_ItemButton1:GetWidth() - 3);
	GemHelper_ListScrollFrame:SetHeight(GemHelper_ItemButton1:GetHeight() * GEMHELPER_ITEMS_SHOWN);
	GemHelper_ListScrollFrame:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(GEMHELPER_DISP_HEIGHT, GemHelper_Update); end);

	GemHelper_Background1:SetPoint("TOPLEFT", GemHelper_CheckButton1);
	GemHelper_Background1:SetWidth(505);
	GemHelper_Background1:SetHeight(GemHelper_CollapseHeight[1][1]);
	GemHelper_Background2:SetPoint("TOPLEFT", GemHelper_CheckButton2);
	GemHelper_Background2:SetWidth(505);
	GemHelper_Background2:SetHeight(GemHelper_CollapseHeight[2][1]);
	GemHelper_Background3:SetPoint("TOPLEFT", GemHelper_CheckButton3);
	GemHelper_Background3:SetWidth(505);
	GemHelper_Background3:SetHeight(GemHelper_CollapseHeight[3][1]);
	GemHelper_Background4:SetPoint("TOPLEFT", GemHelper_ItemButton1, "TOPLEFT", -5, 5);
	GemHelper_Background4:SetWidth(GemHelper_ItemButton1:GetWidth() + 10);
	GemHelper_Background4:SetHeight(GemHelper_ItemButton1:GetHeight() * GEMHELPER_ITEMS_SHOWN + 10);

	GemHelper_CreateAllButton:SetPoint("TOPLEFT", GemHelper_Background4, "BOTTOMLEFT", 0, 0);
	GemHelper_CreateAllButton:Disable();
	GemHelper_CreateButton:Disable();

	-- Filter by Material
	for _, v in ipairs(GemHelper_GCheckButtonIndexes[2]) do
		checkButton = getglobal("GemHelper_CheckButton"..v);
		checkButton:SetScript("OnEnter", GemHelper_CheckboxMaterial_OnEnter);
	end

	for buttonID = 1, 3 do
		if (GemHelper_Save[-buttonID]) then
			-- Collapse
			for k, v in ipairs(GemHelper_GCheckButtonIndexes[buttonID]) do
				getglobal("GemHelper_CheckButton"..v):Hide();
			end
			checkButton = getglobal("GemHelper_CollapseButton"..buttonID);
			checkButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
			checkButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
			checkButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
			checkButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
			getglobal("GemHelper_Background"..buttonID):SetHeight(GemHelper_CollapseHeight[buttonID][2]);
			if (buttonID < 3) then
				getglobal("GemHelper_CheckButton"..(buttonID+1)):SetPoint("TOPLEFT", getglobal("GemHelper_CheckButton"..buttonID), "TOPLEFT", 0, -GemHelper_CollapseHeight[buttonID][2]);
			else
				GemHelper_ListScrollFrame:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][2] - 5);
				GemHelper_CheckButton101:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 275, -GemHelper_CollapseHeight[buttonID][2]);
				GemHelper_ItemButton1:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][2] - 5);
			end
			GemHelper_Frame:SetHeight(GemHelper_Frame:GetHeight() - GemHelper_CollapseHeight[buttonID][1] + GemHelper_CollapseHeight[buttonID][2]);
		else
			-- Uncollapse
			for k, v in ipairs(GemHelper_GCheckButtonIndexes[buttonID]) do
				getglobal("GemHelper_CheckButton"..v):Show();
			end
			checkButton = getglobal("GemHelper_CollapseButton"..buttonID);
			checkButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up");
			checkButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
			checkButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Disabled");
			checkButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Down");
			getglobal("GemHelper_Background"..buttonID):SetHeight(GemHelper_CollapseHeight[buttonID][1]);
			if (buttonID < 3) then
				getglobal("GemHelper_CheckButton"..(buttonID+1)):SetPoint("TOPLEFT", getglobal("GemHelper_CheckButton"..buttonID), "TOPLEFT", 0, -GemHelper_CollapseHeight[buttonID][1]);
			else
				GemHelper_ListScrollFrame:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][1] - 5);
				GemHelper_CheckButton101:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 275, -GemHelper_CollapseHeight[buttonID][1]);
				GemHelper_ItemButton1:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][1] - 5);
			end
		end
	end

	checkButton = CreateFrame("Frame", "GemHelper_UserDropdown", GemHelper_CheckButton1012, "UIDropDownMenuTemplate");
	GemHelper_UserDropdownLeft:Hide();
	GemHelper_UserDropdownMiddle:Hide();
	GemHelper_UserDropdownRight:Hide();
	GemHelper_UserDropdownText:Hide();
	GemHelper_UserDropdownButtonHighlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Round");
	--GemHelper_UserDropdown:SetPoint("LEFT", GemHelper_CheckButton1012, "LEFT", 7, -2);
	GemHelper_UserDropdown:SetPoint("LEFT", GemHelper_CheckButton1012, "LEFT", 1, -4);
	GemHelper_CheckButton1012Text:SetPoint("LEFT", GemHelper_CheckButton1012, "RIGHT", 17, 0);

	-- Add the slash command
	SlashCmdList["GEMHELPER"] = function(msg) GemHelper_Frame:Show() end;
	SLASH_GEMHELPER1 = "/gemhelper";
	SLASH_GEMHELPER2 = "/gh";

	-- Makes ESC key close GemHelper
	tinsert(UISpecialFrames, "GemHelper_Frame");

	GemHelper_UpdateCheckboxes(1);
	GemHelper_UpdateCheckboxes(2);
	GemHelper_UpdateCheckboxes(3);
	GemHelper_UpdateCheckboxes(101);

	hooksecurefunc("CloseTradeSkill", GemHelper_Update);

	if (IsLoggedIn()) then
		if (GemHelper_isJewelcraftingPanel()) then
			GemHelper_ScanJCPanel();
			if (GemHelper_Save[111] == true) then
				GemHelper_Frame:Show();
				HideUIPanel(TradeSkillFrame);
				GemHelper_HookTradeSkillFrame_Show();
				if (ATSWFrame) then
					HideUIPanel(ATSWFrame);
					GemHelper_ATSW_ShowWindow();
				end
				if (SkilletFrame) then
					Skillet:HideTradeSkillWindow();
					GemHelper_Skillet_ShowWindow();
				end
			end
		end
	end

	GemHelper_Frame:UnregisterEvent("ADDON_LOADED");

	-- Create a frame for doing OnUpdates, this isn't used for anything else or shown
	-- This is to reduce the number of times BankItems records bag/worn item changes
	GemHelper_UpdateFrame = CreateFrame("Frame");
end

function GemHelper_Filter()
	for k, v in pairs(GemHelper_DispResults) do
		GemHelper_DispResults[k] = nil;
	end

	local flag, flag2, flag3, flag4, flag5, flag6;
	local playerName = GemHelper_UserDropdown_GetValue();

	-- Scan bags for filter for "Have Materials"
	if (GemHelper_Save[101] and GemHelper_Save[1011]) then
		local bagNum_Slots, itemLink, itemID;
		for k, v in pairs(bagScan) do
			bagScan[k] = nil;
		end
		for bagNum = 0, 4 do
			bagNum_Slots = GetContainerNumSlots(bagNum);
			for bagItem = 1, bagNum_Slots do
				itemLink = GetContainerItemLink(bagNum, bagItem);
				itemID = nil;
				if (itemLink) then
					_, _, itemID = strfind(itemLink, "item:(%d+):");
					itemID = tonumber(itemID);
				end
				if (itemID and GemHelper_ReverseMaterialGemID[itemID]) then
					bagScan[GemHelper_ReverseMaterialGemID[itemID]] = true;
				end
			end
		end
	end

	for gemID, gemTable in pairs(GemHelper_GemData) do
		-- Filter by Gem Colour
		flag1 = true;
		if (GemHelper_Save[1]) then
			flag1 = false;
			for _, i in ipairs(GemHelper_GCheckButtonIndexes[1]) do
				if (GemHelper_Save[i] and gemTable[i]) then
					flag1 = true;
					break;
				end
			end
		end

		-- Filter by Material
		flag2 = true;
		if (GemHelper_Save[2]) then
			flag2 = false;
			for _, i in ipairs(GemHelper_GCheckButtonIndexes[2]) do
				if (GemHelper_Save[i] and gemTable[i]) then
					flag2 = true;
					break;
				end
			end
		end

		-- Filter by Statistic
		flag3 = true;
		if (GemHelper_Save[3]) then
			flag3 = false;
			for _, i in ipairs(GemHelper_GCheckButtonIndexes[3]) do
				if (GemHelper_Save[i] and gemTable[i]) then
					flag3 = true;
					break;
				end
			end
		end

		-- Filter by Creation
		flag4 = false;
		for _, i in ipairs(GemHelper_GCheckButtonIndexes[4]) do
			if (GemHelper_Save[i] and gemTable[i]) then
				flag4 = true;
				break;
			end
		end

		-- Filter for "Have Materials"
		flag5 = true;
		if (GemHelper_Save[101] and GemHelper_Save[1011]) then
			flag5 = false;
			for _, i in ipairs(GemHelper_GCheckButtonIndexes[2]) do
				if (bagScan[i] and gemTable[i]) then
					flag5 = true;
					break;
				end
			end
		end

		-- Filter for "That I can cut"
		flag6 = true;
		if (GemHelper_Save[101] and GemHelper_Save[1012]) then
			flag6 = false;
			if (GemHelper_SaveCraft[playerName][gemID]) then
				flag6 = true;
			end
		end

		if (flag1 and flag2 and flag3 and flag4 and flag5 and flag6) then
			-- Gem matches filters
			tinsert(GemHelper_DispResults, gemID);
		end
	end

	tsort(GemHelper_DispResults, GemHelper_SortResults);
end

function GemHelper_SortResults(a, b)
	if (GemHelper_GemData[a].r ~= GemHelper_GemData[b].r) then	-- Rarity sort
		return GemHelper_GemData[a].r > GemHelper_GemData[b].r;
	elseif (GemHelper_GemLocaleData[a] and GemHelper_GemLocaleData[b] and GemHelper_GemLocaleData[a].n and GemHelper_GemLocaleData[b].n) then
		-- If same rarity then go by name
		return GemHelper_GemLocaleData[a].n < GemHelper_GemLocaleData[b].n;
	else	-- If name data isn't available, then go by gem ID
		return a < b;
	end
end

function GemHelper_UpdateFrame_OnUpdate(self, elapsed)
	GemHelper_Update();
	self:SetScript("OnUpdate", nil);
end

function GemHelper_OnEvent(event, arg1)
	if (((event == "UNIT_INVENTORY_CHANGED" and arg1 == "player") or event == "BAG_UPDATE") and GemHelper_Save[101] and GemHelper_Save[1011]) then
		-- Delay updating to the next frame as multiple UNIT_INVENTORY_CHANGED events can occur in 1 frame
		GemHelper_UpdateFrame:SetScript("OnUpdate", GemHelper_UpdateFrame_OnUpdate);
	elseif (event == "TRADE_SKILL_UPDATE") then
		GemHelper_Update();
	elseif (event == "TRADE_SKILL_SHOW") then
		if (GemHelper_isJewelcraftingPanel()) then
			GemHelper_ScanJCPanel();
			if (GemHelper_Save[111] == true) then
				GemHelper_Frame:Show();
			end
		end
	elseif (event == "TRADE_SKILL_CLOSE") then
		if (GemHelper_Save[111] == true) then
			GemHelper_Frame:Hide();
		elseif (GemHelper_Frame:IsVisible()) then
			GemHelper_Update();
		end
	elseif (event == "UPDATE_TRADESKILL_RECAST") then
		GemHelper_InputBox:SetNumber(GetTradeskillRepeatCount());
	elseif (event == "ADDON_LOADED" and strfind(arg1, "GemHelper")) then
		GemHelper_Init();
	end
end

function GemHelper_isJewelcraftingPanel()
	--if (not TradeSkillFrameTitleText) or (not strfind(TradeSkillFrameTitleText:GetText(), GEMHELPER_JEWELCRAFTING_TEXT)) then
	if (not strfind(GetTradeSkillLine(), GEMHELPER_JEWELCRAFTING_TEXT)) then
		return false;
	end
	return true;
end

function GemHelper_isJewelcrafter()
	local skillname, isHeader;
	for i = 1, GetNumSkillLines() do
		skillname, isHeader = GetSkillLineInfo(i);
		if (not isHeader) then
			if (strfind(skillname, GEMHELPER_JEWELCRAFTING_TEXT)) then
				return true;
			end
		end
	end
	return false;
end

function GemHelper_ScanJCPanel()
	local playerName = UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName"));

	if (not GemHelper_SaveCraft[playerName]) then
		GemHelper_SaveCraft[playerName] = {};
	end

	for k, v in pairs(GemHelper_SaveCraft[playerName]) do
		-- Set all to 0 index
		GemHelper_SaveCraft[playerName][k] = 0;
	end

	if (GemHelper_isJewelcraftingPanel()) then
		local skillName, skillType, numAvailable, isExpanded;
		local itemID;

		for i = 1, GetNumTradeSkills() do
			skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i);
			if ( skillType ~= "header" and GetTradeSkillItemLink(i)) then
				_, _, itemID = strfind(GetTradeSkillItemLink(i), "item:(%d+):");
				itemID = tonumber(itemID);
				if (GemHelper_GemData[itemID]) then
					-- Set to tradeskill index
					GemHelper_SaveCraft[playerName][itemID] = i;
					--ChatFrame1:AddMessage("I can make "..GetTradeSkillItemLink(i).." with itemID "..itemID);
				end
			end
		end
	end
end

function GemHelper_Trim(s)
	return gsub(s, "^%s*(.-)%s*$", "%1");
end

function GemHelper_CheckButton_OnClick(button)
	local buttonID = this:GetID();

	-- If user shift-clicked a material to link it in chat, then do so
	if (buttonID > 20 and buttonID < 60) then
		local itemName, itemLink, itemRarity = GetItemInfo(GemHelper_MaterialGemID[buttonID]);
		if (itemLink and button == "LeftButton" and IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
			-- Insert itemlink into chat
			ChatFrameEditBox:Insert(itemLink);
			this:SetChecked(GemHelper_Save[buttonID]);
			return;
		end

		if (itemLink and button == "LeftButton" and IsShiftKeyDown() and (not ChatFrameEditBox:IsVisible()) and (BrowseName and BrowseName:IsVisible())) then
			if (IsAltKeyDown()) then
				BrowseName:SetText(BrowseName:GetText()..itemName);
			else
				BrowseName:SetText(itemName);
			end
			this:SetChecked(GemHelper_Save[buttonID]);
			return;
		end
	end

	-- Else toggle the checkbox itself
	if (GemHelper_Save[buttonID]) then
		GemHelper_Save[buttonID] = false;
	else
		GemHelper_Save[buttonID] = true;
	end
	this:SetChecked(GemHelper_Save[buttonID]);
	if ((buttonID >= 1 and buttonID <= 3) or (buttonID == 101)) then
		GemHelper_UpdateCheckboxes(buttonID);
	end
	PlayClickSound();
	GemHelper_Update();
end

function GemHelper_CheckboxMaterial_OnEnter()
	local buttonID = this:GetID();
	local itemName, itemLink, itemRarity = GetItemInfo(GemHelper_MaterialGemID[buttonID]);
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	if (itemLink) then
		GameTooltip:SetHyperlink(itemLink);
	end
end

function GemHelper_UpdateCheckboxes(buttonID)
	for k, v in ipairs(GemHelper_GCheckButtonIndexes[buttonID]) do
		if (GemHelper_Save[buttonID]) then
			--OptionsFrame_EnableCheckBox(getglobal("GemHelper_CheckButton"..v));
			GemHelper_EnableCheckBox(getglobal("GemHelper_CheckButton"..v));
		else
			--OptionsFrame_DisableCheckBox(getglobal("GemHelper_CheckButton"..v));
			GemHelper_DisableCheckBox(getglobal("GemHelper_CheckButton"..v));
		end
	end
	if (buttonID == 101) then
		if (GemHelper_Save[101]) then
			UIDropDownMenu_EnableDropDown(GemHelper_UserDropdown);
		else
			UIDropDownMenu_DisableDropDown(GemHelper_UserDropdown);
		end
	end
end

function GemHelper_DisableCheckBox(checkBox)
	--checkBox:Disable();
	checkBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
	getglobal(checkBox:GetName().."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function GemHelper_EnableCheckBox(checkBox, setChecked, checked, isWhite)
	if ( setChecked ) then
		checkBox:SetChecked(checked);
	end
	--checkBox:Enable();
	checkBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
	if ( isWhite ) then
		getglobal(checkBox:GetName().."Text"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		getglobal(checkBox:GetName().."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
end

function GemHelper_CollapseButton_OnClick()
	local buttonID = this:GetID();
	if (GemHelper_Save[-buttonID]) then
		-- Uncollapse
		GemHelper_Save[-buttonID] = false;
		for k, v in ipairs(GemHelper_GCheckButtonIndexes[buttonID]) do
			getglobal("GemHelper_CheckButton"..v):Show();
		end
		this:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up");
		this:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
		this:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Disabled");
		this:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Down");
		getglobal("GemHelper_Background"..buttonID):SetHeight(GemHelper_CollapseHeight[buttonID][1]);
		if (buttonID < 3) then
			getglobal("GemHelper_CheckButton"..(buttonID+1)):SetPoint("TOPLEFT", getglobal("GemHelper_CheckButton"..buttonID), "TOPLEFT", 0, -GemHelper_CollapseHeight[buttonID][1]);
		else
			GemHelper_ListScrollFrame:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][1] - 5);
			GemHelper_CheckButton101:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 275, -GemHelper_CollapseHeight[buttonID][1]);
			GemHelper_ItemButton1:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][1] - 5);
		end
		GemHelper_Frame:SetHeight(GemHelper_Frame:GetHeight() + GemHelper_CollapseHeight[buttonID][1] - GemHelper_CollapseHeight[buttonID][2]);
	else
		-- Collapse
		GemHelper_Save[-buttonID] = true;
		for k, v in ipairs(GemHelper_GCheckButtonIndexes[buttonID]) do
			getglobal("GemHelper_CheckButton"..v):Hide();
		end
		this:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
		this:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
		this:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
		this:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
		getglobal("GemHelper_Background"..buttonID):SetHeight(GemHelper_CollapseHeight[buttonID][2]);
		if (buttonID < 3) then
			getglobal("GemHelper_CheckButton"..(buttonID+1)):SetPoint("TOPLEFT", getglobal("GemHelper_CheckButton"..buttonID), "TOPLEFT", 0, -GemHelper_CollapseHeight[buttonID][2]);
		else
			GemHelper_ListScrollFrame:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][2] - 5);
			GemHelper_CheckButton101:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 275, -GemHelper_CollapseHeight[buttonID][2]);
			GemHelper_ItemButton1:SetPoint("TOPLEFT", GemHelper_CheckButton3, "TOPLEFT", 5, -GemHelper_CollapseHeight[buttonID][2] - 5);
		end
		GemHelper_Frame:SetHeight(GemHelper_Frame:GetHeight() - GemHelper_CollapseHeight[buttonID][1] + GemHelper_CollapseHeight[buttonID][2]);
	end
end

function GemHelper_ResetButton_OnClick()
	local buttonID = this:GetID();
	for k, v in ipairs(GemHelper_GCheckButtonIndexes[buttonID]) do
		if (GemHelper_Save[v]) then
			GemHelper_Save[v] = false;
		end
		getglobal("GemHelper_CheckButton"..v):SetChecked(GemHelper_Save[v]);
	end
	PlaySound("igMainMenuOptionCheckBoxOff");
	GemHelper_Update();
end

function GemHelper_Update()
	if (not GemHelper_Frame:IsVisible()) then
		return;
	end

	if (GemHelper_isJewelcrafter()) then
		OptionsFrame_EnableCheckBox(GemHelper_CheckButton111);
	else
		OptionsFrame_DisableCheckBox(GemHelper_CheckButton111);
	end

	if (GemHelper_Save[111] and GemHelper_isJewelcrafter() and GemHelper_isJewelcraftingPanel()) then
		GemHelper_PlusButton:Show();
	else
		GemHelper_PlusButton:Hide();
	end

	GemHelper_CheckButton1012Text:SetFormattedText(GEMHELPER_CHECKBUTTON_TEXT[1012], strsplit("|", GemHelper_UserDropdown_GetValue()));
	GemHelper_CheckButton1012:SetHitRectInsets(5, -(GemHelper_CheckButton1012Text:GetWidth() + 24), 5, 5);

	local playerName = UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName"));
	local itemIndex, button;
	local itemID, itemName, itemLink, itemRarity;
	local skillName, skillType, numAvailable, isExpanded;

	-- Scan JC panel and generate results
	GemHelper_ScanJCPanel();
	GemHelper_Filter();

	FauxScrollFrame_Update(GemHelper_ListScrollFrame, #GemHelper_DispResults, GEMHELPER_ITEMS_SHOWN, GEMHELPER_DISP_HEIGHT);
	for i = 1, GEMHELPER_ITEMS_SHOWN do
		itemIndex = i + FauxScrollFrame_GetOffset(GemHelper_ListScrollFrame);
		button = getglobal("GemHelper_ItemButton"..i);
		
		if (itemIndex <= #GemHelper_DispResults) then
			itemID = GemHelper_DispResults[itemIndex];
			itemName, itemLink, itemRarity = GetItemInfo(itemID);
			numAvailable = 0;
			if (GemHelper_SaveCraft[playerName][itemID] and GemHelper_SaveCraft[playerName][itemID] > 0) then
				skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(GemHelper_SaveCraft[playerName][itemID]);
			end

			if (itemName) then
				if ( numAvailable == 0 ) then
					button:SetText(itemName);
				else
					button:SetText(itemName.." ["..numAvailable.."]");
				end
				button:SetTextColor(ITEM_QUALITY_COLORS[itemRarity].r, ITEM_QUALITY_COLORS[itemRarity].g, ITEM_QUALITY_COLORS[itemRarity].b);
			else
				if (GemHelper_GemLocaleData[itemID] and GemHelper_GemLocaleData[itemID].n) then
					button:SetText(GemHelper_GemLocaleData[itemID].n);
				else
					button:SetText("Gem itemID "..itemID);
				end
				button:SetTextColor(0.25, 1.0, 0.75);		-- Teal for unknown
				--GameTooltip:SetHyperlink("item:"..itemID);	-- Request gem from server
			end
			button:SetID(itemID);

			if (itemID == selectedGemID) then
				button:LockHighlight();
				getglobal("GemHelper_ItemButton"..i.."Highlight"):Show();
			else
				button:UnlockHighlight();
				getglobal("GemHelper_ItemButton"..i.."Highlight"):Hide();
			end
			button:Show();
		else
			button:Hide();
		end
	end

	-- Enable the Create buttons if the selectedGem is in the results, and the player can craft it, with mats available
	numAvailable = nil;
	if (GemHelper_SaveCraft[playerName][selectedGemID] and GemHelper_SaveCraft[playerName][selectedGemID] > 0) then
		skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(GemHelper_SaveCraft[playerName][selectedGemID]);
	end
	if ( numAvailable and numAvailable > 0 and tContains(GemHelper_DispResults, selectedGemID)) then
		GemHelper_CreateAllButton:Enable();
		GemHelper_CreateButton:Enable();
	else
		GemHelper_CreateAllButton:Disable();
		GemHelper_CreateButton:Disable();
	end
end

function GemHelper_ItemButton_OnClick(button)
	local playerName = UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName"));
	local itemID = this:GetID();

	local itemName, itemLink, itemRarity = GetItemInfo(itemID);
	local skillName, skillType, numAvailable, isExpanded;

	numAvailable = 0;
	if (GemHelper_SaveCraft[playerName][itemID] and GemHelper_SaveCraft[playerName][itemID] > 0) then
		skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(GemHelper_SaveCraft[playerName][itemID]);
	end

	if (itemLink) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(itemLink);
		if (GemHelper_GemLocaleData[itemID] and GemHelper_GemLocaleData[itemID].d) then
			GameTooltip:AddLine(GemHelper_GemLocaleData[itemID].d, ITEM_QUALITY_COLORS[2].r, ITEM_QUALITY_COLORS[2].g, ITEM_QUALITY_COLORS[2].b, 1);
		end

		local id = GemHelper_SaveCraft[playerName][itemID];
		if ( id and GetTradeSkillCooldown(id) ) then
			GameTooltip:AddLine(COOLDOWN_REMAINING.." "..SecondsToTime(GetTradeSkillCooldown(id)), 1, nil, nil, 1);
		end

		GameTooltip:Show();
		if ( numAvailable == 0 ) then
			this:SetText(itemName);
		else
			this:SetText(itemName.." ["..numAvailable.."]");
		end
		this:SetTextColor(ITEM_QUALITY_COLORS[itemRarity].r, ITEM_QUALITY_COLORS[itemRarity].g, ITEM_QUALITY_COLORS[itemRarity].b);
	end

	if (itemLink and button == "LeftButton" and IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
		-- Insert itemlink into chat
		ChatFrameEditBox:Insert(itemLink);
		return;
	end

	if (itemLink and button == "LeftButton" and IsShiftKeyDown() and (not ChatFrameEditBox:IsVisible()) and (BrowseName and BrowseName:IsVisible())) then
		if (IsAltKeyDown()) then
			BrowseName:SetText(BrowseName:GetText()..itemName);
		else
			BrowseName:SetText(itemName);
		end
		return;
	end

	if (button == "LeftButton") then
		-- Set current button/gem as selected
		selectedGemID = itemID;
		GemHelper_Update();
		return;
	end

	if (not itemLink and button == "RightButton") then
		-- Query server for gem
        	ChatFrame1:AddMessage(GEMHELPER_QUERY_MESSAGE.."|cff40ffc0".."["..this:GetText().."]".."|r.");
		GameTooltip:SetHyperlink("item:"..itemID);
		return;
	end
end

function GemHelper_ItemButton_OnEnter()
	local playerName = UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName"));
	local itemID = this:GetID();

	local itemName, itemLink, itemRarity = GetItemInfo(itemID);
	local skillName, skillType, numAvailable, isExpanded;

	numAvailable = 0;
	if (GemHelper_SaveCraft[playerName][itemID] and GemHelper_SaveCraft[playerName][itemID] > 0) then
		skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(GemHelper_SaveCraft[playerName][itemID]);
	end

	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");

	if (itemLink) then
		GameTooltip:SetHyperlink(itemLink);
		if ( numAvailable == 0 ) then
			this:SetText(itemName);
		else
			this:SetText(itemName.." ["..numAvailable.."]");
		end
		this:SetTextColor(ITEM_QUALITY_COLORS[itemRarity].r, ITEM_QUALITY_COLORS[itemRarity].g, ITEM_QUALITY_COLORS[itemRarity].b);
	else
		GameTooltip:SetHyperlink("item:"..itemID); -- query server
		GameTooltip:ClearLines();
		GameTooltip:AddLine(GEMHELPER_ERRORTOOLTIP_L1);
		GameTooltip:AddLine(GEMHELPER_ERRORTOOLTIP_L2..this:GetID());
		GameTooltip:AddLine(GEMHELPER_ERRORTOOLTIP_L3, 1, 1, 1, 1);
		GameTooltip:AddLine(GEMHELPER_ERRORTOOLTIP_L4, nil, nil, nil, 1);
	end
	if (GemHelper_GemLocaleData[itemID] and GemHelper_GemLocaleData[itemID].d) then
		GameTooltip:AddLine(GemHelper_GemLocaleData[itemID].d, ITEM_QUALITY_COLORS[2].r, ITEM_QUALITY_COLORS[2].g, ITEM_QUALITY_COLORS[2].b, 1);
	end

	local id = GemHelper_SaveCraft[playerName][itemID];
	if ( id and GetTradeSkillCooldown(id) ) then
		GameTooltip:AddLine(COOLDOWN_REMAINING.." "..SecondsToTime(GetTradeSkillCooldown(id)), 1, nil, nil, 1);
	end

	GameTooltip:Show();
end

function GemHelper_ItemButton_OnLeave()
	GameTooltip:Hide();
end

function GemHelper_Increment_OnClick()
	if ( GemHelper_InputBox:GetNumber() < 100 ) then
		GemHelper_InputBox:SetNumber(GemHelper_InputBox:GetNumber() + 1);
	end
end

function GemHelper_Decrement_OnClick()
	if ( GemHelper_InputBox:GetNumber() > 1 ) then
		GemHelper_InputBox:SetNumber(GemHelper_InputBox:GetNumber() - 1);
	end
end

function GemHelper_CreateAll_OnClick()
	local playerName = UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName"));
	local skillName, skillType, numAvailable, isExpanded;
	local id;

	GemHelper_Update();

	id = GemHelper_SaveCraft[playerName][selectedGemID];
	numAvailable = nil;
	if (id and id > 0) then
		skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(id);
	end
	if ( numAvailable and numAvailable > 0 and tContains(GemHelper_DispResults, selectedGemID)) then
		SelectTradeSkill(id);
		if ( GetTradeSkillSelectionIndex() > GetNumTradeSkills() ) then
			return;
		end
		GemHelper_InputBox:SetNumber(numAvailable);
		DoTradeSkill(id, numAvailable);
	end
end

function GemHelper_Create_OnClick()
	local playerName = UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName"));
	local skillName, skillType, numAvailable, isExpanded;
	local id;

	GemHelper_Update();

	id = GemHelper_SaveCraft[playerName][selectedGemID];
	numAvailable = nil;
	if (id and id > 0) then
		skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(id);
	end
	if ( numAvailable and numAvailable > 0 and tContains(GemHelper_DispResults, selectedGemID)) then
		SelectTradeSkill(id);
		if ( GetTradeSkillSelectionIndex() > GetNumTradeSkills() ) then
			return;
		end
		DoTradeSkill(id, GemHelper_InputBox:GetNumber());
	end
end

function GemHelper_CheckCooldown()
	if (not selectedGemID) then
		return;
	end

	local playerName = UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName"));
	local id = GemHelper_SaveCraft[playerName][selectedGemID];

	if ( id and GetTradeSkillCooldown(id) ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:ClearLines();
		GameTooltip:AddLine(COOLDOWN_REMAINING.." "..SecondsToTime(GetTradeSkillCooldown(id)), nil, nil, nil, 1);
		GameTooltip:Show();
	end
end

function GemHelper_UserDropdown_GetValue()
	if (not GemHelper_Save.selectedPlayer) then
		GemHelper_Save.selectedPlayer = (UnitName("player").."|"..GemHelper_Trim(GetCVar("realmName")));
	end
	return GemHelper_Save.selectedPlayer;
end

function GemHelper_UserDropdown_OnShow()
	UIDropDownMenu_Initialize(GemHelper_UserDropdown, GemHelper_UserDropdown_Initialize);
	UIDropDownMenu_SetSelectedValue(GemHelper_UserDropdown, GemHelper_UserDropdown_GetValue());
	UIDropDownMenu_SetWidth(9, GemHelper_UserDropdown);
	if (GemHelper_Save[101]) then
		UIDropDownMenu_EnableDropDown(GemHelper_UserDropdown);
	else
		UIDropDownMenu_DisableDropDown(GemHelper_UserDropdown);
	end
end

function GemHelper_UserDropdown_OnClick()
	UIDropDownMenu_SetSelectedValue(GemHelper_UserDropdown, this.value);
	GemHelper_Save.selectedPlayer = this.value;
	GemHelper_Update();
end

function GemHelper_UserDropdown_Initialize()
	--local selectedValue = UIDropDownMenu_GetSelectedValue(GemHelper_UserDropdown);
	local selectedValue = GemHelper_UserDropdown_GetValue();
	local currRealm = GemHelper_Trim(GetCVar("realmName"));
	local allRealms = 1;	-- Always show all realms for now

	for k, v in pairs(GemHelper_SaveCraft) do
		if (type(v) == "table") then
			local theName, thisRealmPlayers = strsplit("|", k);
			if ((allRealms == 1) or (thisRealmPlayers == currRealm)) then
				info.text = theName.." of "..thisRealmPlayers;
				info.value = k;
				info.func = GemHelper_UserDropdown_OnClick;
				if ( selectedValue == info.value ) then
					info.checked = 1;
				else
					info.checked = nil;
				end
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function GemHelper_SetNewBackgroundColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local a = 1.0 - OpacitySliderFrame:GetValue();
	GemHelper_Frame:SetBackdropColor(r, g, b, a);
	GemHelper_ColorSwatchNormalTexture:SetVertexColor(r, g, b);
	GemHelper_Save.r = r;
	GemHelper_Save.g = g;
	GemHelper_Save.b = b;
	GemHelper_Save.a = a;
end

function GemHelper_SetOldBackgroundColor(colortable)
	GemHelper_Frame:SetBackdropColor(colortable.r, colortable.g, colortable.b, colortable.a);
	GemHelper_ColorSwatchNormalTexture:SetVertexColor(colortable.r, colortable.g, colortable.b);
	GemHelper_Save.r = colortable.r;
	GemHelper_Save.g = colortable.g;
	GemHelper_Save.b = colortable.b;
	GemHelper_Save.a = colortable.a;
end

function GemHelper_SelectBackgroundColor()
	-- These 2 lines fix a bug for an uninitialised OpacitySliderFrame returning and saving a
	-- value of 0 on SetColorRGB and SetValue
	ColorPickerFrame.opacityFunc = nil;
	OpacitySliderFrame:SetValue(1.0 - GemHelper_Save.a);

	ColorPickerFrame.func = GemHelper_SetNewBackgroundColor;
	ColorPickerFrame.hasOpacity = 1;
	ColorPickerFrame.opacityFunc = GemHelper_SetNewBackgroundColor;
	ColorPickerFrame.opacity = 1.0 - GemHelper_Save.a;
	ColorPickerFrame.previousValues = {["r"] = GemHelper_Save.r, ["g"] = GemHelper_Save.g, ["b"] = GemHelper_Save.b, ["a"] = GemHelper_Save.a};
	ColorPickerFrame.cancelFunc = GemHelper_SetOldBackgroundColor;
	ColorPickerFrame:SetColorRGB(GemHelper_Save.r, GemHelper_Save.g, GemHelper_Save.b);
	ShowUIPanel(ColorPickerFrame);
end

--[[
Hook TradeSkillFrame_Show() and check if the GetTradeSkillLine() == GEMHELPER_JEWELCRAFTING_TEXT
to prevent it from opening. If it isn't shown, make sure to call CloseTradeSkill() on closing GH window.
]]

TradeSkillFrame_LoadUI();
GemHelper_OrigTradeSkillFrame_Show = TradeSkillFrame_Show;
function GemHelper_HookTradeSkillFrame_Show()
	if (GetTradeSkillLine() == GEMHELPER_JEWELCRAFTING_TEXT) then
		if (GemHelper_Save[111] == true) then
			CloseDropDownMenus();
		else
			GemHelper_OrigTradeSkillFrame_Show();
			GemHelper_PlusButton:SetText("-");
		end
	else
		GemHelper_OrigTradeSkillFrame_Show();
		GemHelper_PlusButton:SetText("-");
	end
end
TradeSkillFrame_Show = GemHelper_HookTradeSkillFrame_Show;

--[[
Hooking the OnHide script handler directly instead of TradeSkillFrame_Hide().
]]

GemHelper_OrigTradeSkillFrame_OnHide = TradeSkillFrame:GetScript("OnHide");
function GemHelper_TradeSkillFrame_OnHide(self)
	if (GetTradeSkillLine() == GEMHELPER_JEWELCRAFTING_TEXT) then
		if (GemHelper_Save[111] == true) then
			PlaySound("igCharacterInfoClose");
			if (not GemHelper_Frame:IsShown()) then
				GemHelper_OrigTradeSkillFrame_OnHide(self);
			end
		else
			GemHelper_OrigTradeSkillFrame_OnHide(self);
		end
	else
		GemHelper_OrigTradeSkillFrame_OnHide(self);
	end
	GemHelper_PlusButton:SetText("+");
end
TradeSkillFrame:SetScript("OnHide", GemHelper_TradeSkillFrame_OnHide);

--[[
Repeat and hook the same thing for AdvancedTradeSkillWindow
]]
if (ATSW_ShowWindow and ATSW_HideWindow) then
	GemHelper_Orig_ATSW_ShowWindow = ATSW_ShowWindow;
	function GemHelper_ATSW_ShowWindow()
		if (GetTradeSkillLine() == GEMHELPER_JEWELCRAFTING_TEXT) then
			if (GemHelper_Save[111] == true) then
				CloseDropDownMenus();
			else
				GemHelper_Orig_ATSW_ShowWindow();
				GemHelper_PlusButton:SetText("-");
			end
		else
			GemHelper_Orig_ATSW_ShowWindow();
			GemHelper_PlusButton:SetText("-");
		end
	end
	ATSW_ShowWindow = GemHelper_ATSW_ShowWindow;

	function GemHelper_ATSW_HideWindow()
		GemHelper_PlusButton:SetText("+");
	end
	hooksecurefunc("ATSW_HideWindow", GemHelper_ATSW_HideWindow);
end


--[[
Repeat and hook the same thing for Skillet
]]
if (Skillet and SkilletFrame) then
	function GemHelper_Skillet_ShowWindow()
		if (GetTradeSkillLine() == GEMHELPER_JEWELCRAFTING_TEXT) then
			if (GemHelper_Save[111] == true) then
				CloseDropDownMenus();
			else
				GemHelper_Orig_Skillet_ShowWindow(Skillet);
				GemHelper_PlusButton:SetText("-");
			end
		else
			GemHelper_Orig_Skillet_ShowWindow(Skillet);
			GemHelper_PlusButton:SetText("-");
		end
	end
	GemHelper_Orig_Skillet_ShowWindow = Skillet.ShowTradeSkillWindow;
	Skillet.ShowTradeSkillWindow = GemHelper_Skillet_ShowWindow;

	GemHelper_Orig_Skillet_OnHide = SkilletFrame:GetScript("OnHide");
	function GemHelper_SkilletFrame_OnHide(self)
		if (GetTradeSkillLine() == GEMHELPER_JEWELCRAFTING_TEXT) then
			if (GemHelper_Save[111] == true) then
				PlaySound("igCharacterInfoClose");
				if (not GemHelper_Frame:IsShown()) then
					GemHelper_Orig_Skillet_OnHide(self);
				end
			else
				GemHelper_Orig_Skillet_OnHide(self);
			end
		else
			GemHelper_Orig_Skillet_OnHide(self);
		end
		GemHelper_PlusButton:SetText("+");
	end
	SkilletFrame:SetScript("OnHide", GemHelper_SkilletFrame_OnHide);
end
