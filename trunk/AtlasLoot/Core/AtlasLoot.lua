--[[
Atlasloot Enhanced
Author Daviesh
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)

Functions:
AtlasLoot_OnEvent(event)
AtlasLoot_ShowMenu()
AtlasLoot_OnVariablesLoaded()
AtlasLoot_SlashCommand(msg)
AtlasLootOptions_Toggle()
AtlasLoot_OnLoad()
AtlasLootBoss_OnClick()
AtlasLoot_SetItemPrice(text, icon, textData, iconData)
AtlasLoot_ShowItemsFrame()
AtlasLoot_SetupForAtlas()
AtlasLoot_SetItemInfoFrame()
AtlasLootItemsFrame_OnCloseButton()
AtlasLootMenuItem_OnClick()
AtlasLoot_NavButton_OnClick()
AtlasLoot_HeroicModeToggle()
AtlasLoot_IsLootTableAvailable(dataID)
AtlasLoot_GetLODModule(dataSource)
AtlasLoot_LoadAllModules()
]]

AtlasLoot = AceLibrary("AceAddon-2.0"):new("AceDB-2.0")

--Instance required libraries
local BabbleBoss = AceLibrary("Babble-Boss-2.2");
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

--Establish version number and compatible version of Atlas
local VERSION_MAJOR = "4";
local VERSION_MINOR = "04";
local VERSION_BOSSES = "00";
ATLASLOOT_VERSION = "|cffFF8400AtlasLoot Enhanced v"..VERSION_MAJOR.."."..VERSION_MINOR.."."..VERSION_BOSSES.."|r";
ATLASLOOT_CURRENT_ATLAS = "1.11.0";
ATLASLOOT_PREVIEW_ATLAS = "1.11.1";

--Standard indent to line text up with Atlas text
ATLASLOOT_INDENT = "   ";

--Make the Dewdrop menu in the standalone loot browser accessible here
AtlasLoot_Dewdrop = AceLibrary("Dewdrop-2.0");
AtlasLoot_DewdropSubMenu = AceLibrary("Dewdrop-2.0");

--Variable to cap debug spam
ATLASLOOT_DEBUGSHOWN = false;

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--Establish number of boss lines in the Atlas frame for scrolling
local ATLAS_LOOT_BOSS_LINES	= 25;

--Flag so that error messages do not spam
local ATLASLOOT_POPUPSHOWN = false;

--Set the default anchor for the loot frame to the Atlas frame
AtlasLoot_AnchorFrame = AtlasFrame;

--Variables to hold hooked Atlas functions
Hooked_Atlas_Refresh = nil;
Hooked_Atlas_OnShow = nil;

AtlasLootCharDB={};

AtlasLoot:RegisterDB("AtlasLootDB");

AtlasLoot:RegisterDefaults('profile', {
    SavedTooltips = {},
    SafeLinks = true,
    AllLinks = true,
    DefaultTT = true,
    LootlinkTT = false,
    ItemSyncTT = false,
    EquipCompare = false,
    Opaque = false,
    ItemIDs = false,
    ItemSpam = false,
    MinimapButton = true,
    HidePanel = false,
    LastBoss = "HCRampWatchkeeper",
    LastBossText = BabbleBoss["Watchkeeper Gargolmar"],
    HeroicMode = false,
    AtlasLootVersion = "1",
    AutoQuery = false,
    LoDNotify = false,
    LoadAllLoDStartup = false,
})

AtlasLoot_MenuList = {
    "ABMENU",
    "AQ40SET",
    "AQ20SET",
    "PRE60SET",
    "ZGSET",
    "T6SET",
    "T5SET",
    "T4SET",
    "T3SET",
    "T2SET",
    "T1SET",
    "T0SET",
    "PVPMENU",
    "PVPSET",
    "PVP70RepSET",
    "PVP70NONSETEPICS",
    "ARENASET",
    "ARENA2SET",
    "ARENA3SET",
    "ARENA4SET",
    "DS3SET",
    "CRAFTSET",
    "CRAFTSET2",
    "REPMENU_AZEROTHPREBC",
    "REPMENU_AZEROTHPOSTBC",
    "REPMENU_OUTLAND",
    "REPMENU_SHATTRATH",
    "REPMENU",
    "SETMENU",
    "CRAFTINGMENU",
    "SKETTISMENU",
    "70TOKENMENU",
    "WORLDEPICS",
    "WORLDEVENTMENY",
    "WSGMENU",
    "ABYSSALMENU",
    "ETHEREUMMENU",
    "HONORMENU",
    "ARENAMENU",
    "ALCHEMYMENU",
};

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
  text = AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."].."\n\n"..AL["New feature in 4.02.01: Type '/atlasloot options' to bring up the options menu and '/atlasloot reset' to reset AtlasLoot after a disconnect."].."\n\n"..AL["New feature in 4.03.00: Introducing the Wishlist!  Simply alt-click on any item to add it to the wishlist.  To delete an item from the wishlist, open up your wishlist and alt-click the item to remove it.  It's that simple.  Buttons to view the wishlist have been added to the Atlas interface and the loot browser."],
  button1 = AL["Setup"],
  OnAccept = function()
      AtlasLootOptions_Toggle();
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--Popup Box for an old version of Atlas
StaticPopupDialogs["ATLASLOOT_OLD_ATLAS"] = {
  text = AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("]..ATLASLOOT_CURRENT_ATLAS..AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."],
  button1 = AL["OK"],
  OnAccept = function()
      DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Incompatible Atlas Detected"]);
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--[[
AtlasLoot_OnEvent(event):
event - Name of the event, passed from the API
Invoked whenever a relevant event is detected by the engine.  The function then
decides what action to take depending on the event.
]]
function AtlasLoot_OnEvent(event)
    --Addons all loaded
    if(event == "VARIABLES_LOADED") then
        AtlasLoot_OnVariablesLoaded();
    --Taint errors
    elseif(arg1 == "AtlasLoot") then
        --Junk command to suppress taint message
        local i=3;
    end
end

--[[
AtlasLoot_ShowMenu:
Legacy function used in Cosmos integration to open the loot browser
]]
function AtlasLoot_ShowMenu()
    AtlasLootDefaultFrame:Show();
end

--[[
AtlasLoot_OnVariablesLoaded:
Invoked by the VARIABLES_LOADED event.  Now that we are sure all the assets
the addon needs are in place, we can properly set up the mod
]]
function AtlasLoot_OnVariablesLoaded()
    if AtlasLootCharDB == nil or AtlasLootCharDB["WishList"] == nil then
        AtlasLootCharDB["WishList"] = {};
    end
    --Add the loot browser to the special frames tables to enable closing wih the ESC key
    tinsert(UISpecialFrames, "AtlasLootDefaultFrame");
    --Set up options frame
    AtlasLootOptions_OnLoad();
    --Legacy code for those using the ultimately failed attempt at making Atlas load on demand
    if AtlasButton_LoadAtlas then
        AtlasButton_LoadAtlas();
    end
    --Hook the necessary Atlas functions
    Hooked_Atlas_Refresh = Atlas_Refresh;
    Atlas_Refresh = AtlasLoot_Refresh;
    Hooked_Atlas_OnShow = Atlas_OnShow;
    Atlas_OnShow = AtlasLoot_Atlas_OnShow;
    --Instead of hooking, replace the scrollbar driver function
    AtlasScrollBar_Update = AtlasLoot_AtlasScrollBar_Update;
    --Disable options that don't have the supporting mods
    if( not LootLink_SetTooltip and (AtlasLoot.db.profile.LootlinkTT == true)) then
        AtlasLoot.db.profile.LootlinkTT = false;
        AtlasLoot.db.profile.DefaultTT = true;
    end
    if( not ItemSync and (AtlasLoot.db.profile.ItemSyncTT == true)) then
        AtlasLoot.db.profile.ItemSyncTT = false;
        AtlasLoot.db.profile.DefaultTT = true;
    end
    --If using an opaque items frame, change the alpha value of the backing texture
    if (AtlasLoot.db.profile.Opaque) then
        AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1);
    else
        AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65);
    end
    --If Atlas is installed, set up for Atlas
    if ( Hooked_Atlas_Refresh ) then
        AtlasLoot_SetupForAtlas();
        --If a first time user, set up options
        if( (AtlasLoot.db.profile.AtlasLootVersion == nil) or (tonumber(AtlasLoot.db.profile.AtlasLootVersion) < 40201)) then
            AtlasLoot.db.profile.SafeLinks = true;
            AtlasLoot.db.profile.AllLinks = false;
            AtlasLoot.db.profile.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
            StaticPopup_Show ("ATLASLOOT_SETUP");
        end
        --If not the expected Atlas version
        if( ATLAS_VERSION ~= ATLASLOOT_CURRENT_ATLAS and ATLAS_VERSION ~= ATLASLOOT_PREVIEW_ATLAS ) then
            StaticPopup_Show ("ATLASLOOT_OLD_ATLAS");
        end
        AtlasLoot_Refresh();
    else
        --If we are not using Atlas, keep the items frame out of the way
        AtlasLootItemsFrame:Hide();
    end
	--Check and migrate old WishList entry format to the newer one
	if((AtlasLootCharDB.AtlasLootVersion == nil) or (tonumber(AtlasLootCharDB.AtlasLootVersion) < 40301)) then
		--Check if we really need to do a migration since it will load all modules
		--We also create a helper table here which store IDs that need to search for
		local idsToSearch = {};
		for i = 1, #AtlasLootCharDB["WishList"] do
			if (AtlasLootCharDB["WishList"][i][1] > 0 and not AtlasLootCharDB["WishList"][i][5]) then
				tinsert(idsToSearch, i, AtlasLootCharDB["WishList"][i][1]);
			end
		end
		if #idsToSearch > 0 then
			--Let's do this
			AtlasLoot_LoadAllModules();
			for _, dataSource in ipairs(AtlasLoot_SearchTables) do
				if AtlasLoot_Data[dataSource] then
					for dataID, lootTable in pairs(AtlasLoot_Data[dataSource]) do
						for _, entry in ipairs(lootTable) do
							for k, v in pairs(idsToSearch) do
								if(entry[1] == v)then
									AtlasLootCharDB["WishList"][k][5] = dataID.."|"..dataSource;
									break;
								end
							end
						end
					end
				end
			end
		end
		AtlasLootCharDB.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
	end
    if((AtlasLootCharDB.AtlasLootVersion == nil) or (tonumber(AtlasLootCharDB.AtlasLootVersion) < 40301)) then
        AtlasLootCharDB.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
        AtlasLootCharDB.AutoQuery = false;
        AtlasLootOptions_Init();
    end
    --Adds an AtlasLoot button to the Feature Frame in Cosmos
    if(EarthFeature_AddButton) then
        EarthFeature_AddButton(
            {
                id = string.sub(ATLASLOOT_VERSION, 11, 28);
                name = string.sub(ATLASLOOT_VERSION, 11, 28);
                subtext = string.sub(ATLASLOOT_VERSION, 30, 39);
                tooltip = "";
                icon = "Interface\\Icons\\INV_Box_01";
                callback = AtlasLoot_ShowMenu;
                test = nil;
            }
    );
    --Adds AtlasLoot to old style Cosmos installations
    elseif(Cosmos_RegisterButton) then
        Cosmos_RegisterButton(
            string.sub(ATLASLOOT_VERSION, 11, 28),
            string.sub(ATLASLOOT_VERSION, 11, 28),
            "",
            "Interface\\Icons\\INV_Box_01",
            AtlasLoot_ShowMenu
        );
    end
    --Set up the menu in the loot browser
    AtlasLoot_DewdropRegister();
    --Enable or disable AtlasLootFu based on seleced options
    if AtlasLoot.db.profile.MinimapButton == false then
        AtlasLootFu:Hide();
    else
        AtlasLootFu:Show();
        if FuBar then
            if AtlasLootFu:IsMinimapAttached() then
                AtlasLootFu:ToggleMinimapAttached()
            end
        end
    end
    --If EquipCompare is available, use it
    if((EquipCompare_RegisterTooltip) and (AtlasLoot.db.profile.EquipCompare == true)) then
        EquipCompare_RegisterTooltip(AtlasLootTooltip);
    end
    --Position relevant UI objects for loot browser and set up menu
    AtlasLootDefaultFrame_SelectedCategory:SetPoint("TOP", "AtlasLootDefaultFrame_Menu", "BOTTOM", 0, -4);
    AtlasLootDefaultFrame_SelectedTable:SetPoint("TOP", "AtlasLootDefaultFrame_SubMenu", "BOTTOM", 0, -4);
    AtlasLootDefaultFrame_SelectedCategory:SetText(AL["Choose Table ..."]);
    AtlasLootDefaultFrame_SelectedTable:SetText("");
    AtlasLootDefaultFrame_SelectedCategory:Show();
    AtlasLootDefaultFrame_SelectedTable:Show();
    AtlasLootDefaultFrame_SubMenu:Disable();
    if (AtlasLoot.db.profile.LoadAllLoDStartup == true) then
	    AtlasLoot_LoadAllModules();
    else
	    collectgarbage("collect");
    end
end

--[[
AtlasLoot_SlashCommand(msg):
msg - takes the argument for the /atlasloot command so that the appropriate action can be performed
If someone types /atlasloot, bring up the options box
]]
function AtlasLoot_SlashCommand(msg)
    if msg == AL["reset"] then
        AtlasLoot.db.profile.LastBoss = "HCRampWatchkeeper";
        AtlasLoot.db.profile.LastBossText = BabbleBoss["Watchkeeper Gargolmar"];
	    AtlasLootDefaultFrame:ClearAllPoints();
        AtlasLootDefaultFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
        AtlasLootOptionsFrame:ClearAllPoints();
        AtlasLootOptionsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	    DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Reset complete!"]);
    elseif msg == AL["options"] then
        AtlasLootOptions_Toggle();
    else
        AtlasLootDefaultFrame:Show();
    end
end

--[[
AtlasLootOptions_Toggle:
Toggle on/off the options window
]]
function AtlasLootOptions_Toggle()
    if(AtlasLootOptionsFrame:IsVisible()) then
        --Hide the options frame if already shown
        AtlasLootOptionsFrame:Hide();
    else
        AtlasLootOptionsFrame:Show();
        --Workaround for a weird quirk where tooltip settings so not immediately take effect
        if(AtlasLoot.db.profile.DefaultTT == true) then
            AtlasLootOptions_DefaultTTToggle();
        elseif(AtlasLoot.db.profile.LootlinkTT == true) then
            AtlasLootOptions_LootlinkTTToggle();
        elseif(AtlasLoot.db.profile.ItemSyncTT == true) then
            AtlasLootOptions_ItemSyncTTToggle();
        end
    end
end

--[[
AtlasLoot_OnLoad:
Performs inital setup of the mod and registers it for further setup when
the required resources are in place
]]
function AtlasLoot_OnLoad()
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("ADDON_ACTION_FORBIDDEN");
    this:RegisterEvent("ADDON_ACTION_BLOCKED");
    --Enable the use of /al or /atlasloot to open the loot browser
    SLASH_ATLASLOOT1 = "/atlasloot";
    SLASH_ATLASLOOT2 = "/al";
    SlashCmdList["ATLASLOOT"] = function(msg)
        AtlasLoot_SlashCommand(msg);
    end
end

--[[
AtlasLoot_SetItemPrice(text, icon, textData, iconData):
text - The FontString displaying price number
icon - The Texture displaying currency icon
textData - Price value in loot tables
iconData - Icon value in loot tables
Return true if values have been set successfully, otherwise return false
]]
local function AtlasLoot_SetItemPrice(text, icon, textData, iconData)
	if textData and textData ~= "" then
		text:SetText(textData);
		icon:SetTexture(AtlasLoot_FixText(iconData));
		text:Show();
		icon:Show();
		return true;
	end
	return false;
end

--[[
AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame):
dataID - Name of the loot table
dataSource - Table in the database where the loot table is stored
boss - Text string to use as a title for the loot page
pFrame - Data structure describing how and where to anchor the item frame (more details, see the function AtlasLoot_SetItemInfoFrame)
This fuction is not normally called directly, it is usually invoked by AtlasLoot_ShowBossLoot.
It is the workhorse of the mod and allows the loot tables to be displayed any way anywhere in any mod.
]]
function AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame)
    --Set up local variables needed for GetItemInfo, etc
    local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemColor;
    local iconFrame, nameFrame, extraFrame;
    local text, extra;
    local wlPage, wlPageMax = 1, 1;

    dataSource_backup = dataSource;
    if dataSource ~= "dummy" then
    	if dataID == "WishList" then
			dataSource = {};
			-- Match the page number to display
			wlPage = tonumber(dataSource_backup:match("%d+$"));
			-- Aquiring items of the page
			dataSource[dataID], wlPageMax = AtlasLoot_GetWishListPage(wlPage);
			-- Make page number reasonable
			if wlPage < 1 then wlPage = 1 end
			if wlPage > wlPageMax then wlPage = wlPageMax end
        else
            dataSource = AtlasLoot_Data[dataSource_backup];
        end
    end

    --If the data source has not been passed, throw up a debugging statement
    if dataSource==nil then
        DEFAULT_CHAT_FRAME:AddMessage("No dataSource!");
    end

    --If the loot table name has not been passed, throw up a debugging statement
    if dataID==nil then
        DEFAULT_CHAT_FRAME:AddMessage("No dataID!");
    end

    --Set up checks to see if we have a heroic loot table or not
    local HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
    local HeroicdataID=dataID.."HEROIC";
    local NonHeroicdataID=string.sub(dataID, 1, string.len(dataID)-6);

    --Get AtlasQuest out of the way
    if (AtlasQuestInsideFrame) then
        HideUIPanel(AtlasQuestInsideFrame);
    end

    --Hide the toggle to switch between heroic and normal loot tables, we will only show it if required
    AtlasLootItemsFrame_Heroic:Hide();

    --Change the dataID to be consistant with the Heroic Mode toggle
    if((AtlasLoot.db.profile.HeroicMode == nil) or (AtlasLoot.db.profile.HeroicMode == false)) then
        if(HeroicCheck == "HEROIC") then
            if dataSource[NonHeroicdataID] then
                dataID=NonHeroicdataID;
            end
        end
    elseif(AtlasLoot.db.profile.HeroicMode == true) then
        if(HeroicCheck ~= "HEROIC") then
            if dataSource[HeroicdataID] then
                dataID=HeroicdataID;
            end
        end
    end

    --Hide the menu objects.  These are not required for a loot table
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end

    --Escape out of this function if creating a menu, this function only handles loot tables.
    --Inserting escapes in this way allows consistant calling of data whether it is a loot table or a menu.
    if(dataID=="AQ40SET") then
        AtlasLootAQ40SetMenu();
    elseif(dataID=="AQ20SET") then
        AtlasLootAQ20SetMenu();
    elseif(dataID=="PRE60SET") then
        AtlasLootPRE60SetMenu();
    elseif(dataID=="ZGSET") then
        AtlasLootZGSetMenu();
    elseif(dataID=="T6SET") then
        AtlasLootT6SetMenu();
    elseif(dataID=="T5SET") then
        AtlasLootT5SetMenu();
    elseif(dataID=="T4SET") then
        AtlasLootT4SetMenu();
    elseif(dataID=="T3SET") then
        AtlasLootT3SetMenu();
    elseif(dataID=="T2SET") then
        AtlasLootT2SetMenu();
    elseif(dataID=="T1SET") then
        AtlasLootT1SetMenu();
    elseif(dataID=="T0SET") then
        AtlasLootT0SetMenu();
    elseif(dataID=="PVPMENU") then
        AtlasLootPvPMenu();
    elseif(dataID=="PVPSET") then
        AtlasLootPVPSetMenu();
    elseif(dataID=="PVP70RepSET") then
        AtlasLootPVP70RepSetMenu();
    elseif(dataID=="PVP70NONSETEPICS") then
        AtlasLootPvPNonSetEpics();
    elseif(dataID=="ARENASET") then
        AtlasLootARENASetMenu();
    elseif(dataID=="ARENA2SET") then
        AtlasLootARENA2SetMenu();
    elseif(dataID=="ARENA3SET") then
        AtlasLootARENA3SetMenu();
    elseif(dataID=="ARENA4SET") then
        AtlasLootARENA4SetMenu();
    elseif(dataID=="DS3SET") then
        AtlasLootDS3SetMenu();
    elseif(dataID=="CRAFTINGMENU") then
        AtlasLoot_CraftingMenu();
    elseif(dataID=="CRAFTSET") then
        AtlasLootCraftedSetMenu();
    elseif(dataID=="CRAFTSET2") then
        AtlasLootCraftedSetMenu2();
    elseif(dataID=="REPMENU_AZEROTHPREBC") then
        AtlasLootRepMenu_AzerothPreBC();
    elseif(dataID=="REPMENU_AZEROTHPOSTBC") then
        AtlasLootRepMenu_AzerothPostBC();
    elseif(dataID=="REPMENU_OUTLAND") then
        AtlasLootRepMenu_Outland();
    elseif(dataID=="REPMENU_SHATTRATH") then
        AtlasLootRepMenu_Shattrath();
    elseif(dataID=="REPMENU") then
        AtlasLootRepMenu();
    elseif(dataID=="SETMENU") then
        AtlasLootSetMenu();
    elseif(dataID=="70TOKENMENU") then
        AtlasLoot70TokenMenu();
    elseif(dataID=="WORLDEPICS") then
        AtlasLootWorldEpicsMenu();
    elseif(dataID=="WSGMENU") then
        AtlasLootWSGRewardsMenu();
    elseif(dataID=="ABMENU") then
        AtlasLootABRewardsMenu();
    elseif(dataID=="WORLDEVENTMENU") then
        AtlasLootWorldEventMenu();
    elseif(dataID=="SKETTISMENU") then
        AtlasLootSkettisMenu();
    elseif(dataID=="ETHEREUMMENU") then
        AtlasLootEthereumPrisonMenu();
    elseif(dataID=="ABYSSALMENU") then
        AtlasLootAbyssalCouncilMenu();
    elseif(dataID=="HONORMENU") then
        AtlasLootPvPHonorSystemMenu();
    elseif(dataID=="ARENAMENU") then
        AtlasLootPvPArenaSystemMenu();
    elseif(dataID=="ALCHEMYMENU") then
        AtlasLoot_AlchemyMenu();
    else
        --Iterate through each item object and set its properties
        for i = 1, 30, 1 do
            --Check for a valid object (that it exists, and that it has a name)
            if(dataSource[dataID][i] ~= nil and dataSource[dataID][i][3] ~= "") then
                itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(dataSource[dataID][i][1]);
                --If the client has the name of the item in cache, use that instead.
                --This is poor man's localisation, English is replaced be whatever is needed
                if(GetItemInfo(dataSource[dataID][i][1])) then
                    _, _, _, itemColor = GetItemQualityColor(itemQuality);
                    text = itemColor..itemName;
                else
                    if AtlasLoot.db.profile.AutoQuery then
                        GameTooltip:SetHyperlink("item:"..dataSource[dataID][i][1]..":0:0:0:0:0:0:0");
                    end
                    if(GetItemInfo(dataSource[dataID][i][1])) then
                        _, _, _, itemColor = GetItemQualityColor(itemQuality);
                        text = itemColor..itemName;
                    else
                        --If the item is not in cache, use the saved value and process it
                        text = dataSource[dataID][i][3];
                        text = AtlasLoot_FixText(text);
                    end
                end

                --Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
                AtlasLootItemsFrame.refresh = {dataID, dataSource_backup, boss, pFrame};

                --Insert the item description
                extra = dataSource[dataID][i][4];
                extra = AtlasLoot_FixText(extra);

                --Use shortcuts for easier reference to parts of the item button
                iconFrame  = getglobal("AtlasLootItem_"..i.."_Icon");
                nameFrame  = getglobal("AtlasLootItem_"..i.."_Name");
                extraFrame = getglobal("AtlasLootItem_"..i.."_Extra");
                pricetext1 = getglobal("AtlasLootItem_"..i.."_PriceText1");
                pricetext2 = getglobal("AtlasLootItem_"..i.."_PriceText2");
                pricetext3 = getglobal("AtlasLootItem_"..i.."_PriceText3");
                pricetext4 = getglobal("AtlasLootItem_"..i.."_PriceText4");
                pricetext5 = getglobal("AtlasLootItem_"..i.."_PriceText5");
                priceicon1 = getglobal("AtlasLootItem_"..i.."_PriceIcon1");
                priceicon2 = getglobal("AtlasLootItem_"..i.."_PriceIcon2");
                priceicon3 = getglobal("AtlasLootItem_"..i.."_PriceIcon3");
                priceicon4 = getglobal("AtlasLootItem_"..i.."_PriceIcon4");
                priceicon5 = getglobal("AtlasLootItem_"..i.."_PriceIcon5");

                --If there is no data on the texture an item should have, show a big red question mark
                if dataSource[dataID][i][2] == "?" then
                    iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
                else
                    --else show the texture
                    iconFrame:SetTexture("Interface\\Icons\\"..dataSource[dataID][i][2]);
                    if iconFrame:GetTexture() == nil then
                        iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
                    end
                end
                --Set the name and description of the item
                nameFrame:SetText(text);
                extraFrame:SetText(extra);
                extraFrame:Show();

                --Hide the price UI objects, we only want the ones we are using to be visible
                pricetext1:Hide();
                pricetext2:Hide();
                pricetext3:Hide();
                pricetext4:Hide();
                pricetext5:Hide();
                priceicon1:Hide();
                priceicon2:Hide();
                priceicon3:Hide();
                priceicon4:Hide();
                priceicon5:Hide();

                --Set prices for items, up to 5 different currencies can be used in combination
				--If at WishList page, display price instead of boss name
				if dataID == "WishList" and dataSource[dataID][i][5] then
					local wishDataID, wishDataSource = strsplit("|", dataSource[dataID][i][5]);
					--Determine if need to do a price search, this may not the best way but an easy and fast one
					if wishDataSource == "AtlasLootBGItems" or wishDataSource == "AtlasLootGeneralPvPItems" or wishDataSource == "AtlasLootSetItems" or wishDataSource == "AtlasLootWorldPvPItems" then
						if wishDataID and AtlasLoot_IsLootTableAvailable(wishDataID) then
							for _, v in ipairs(AtlasLoot_Data[wishDataSource][wishDataID]) do
								if dataSource[dataID][i][1] == v[1] then
									if AtlasLoot_SetItemPrice(pricetext1, priceicon1, v[6], v[7]) then extraFrame:Hide() end
					                if AtlasLoot_SetItemPrice(pricetext2, priceicon2, v[8], v[9]) then extraFrame:Hide() end
					                if AtlasLoot_SetItemPrice(pricetext3, priceicon3, v[10], v[11]) then extraFrame:Hide() end
					                if AtlasLoot_SetItemPrice(pricetext4, priceicon4, v[12], v[13]) then extraFrame:Hide() end
					                if AtlasLoot_SetItemPrice(pricetext5, priceicon5, v[14], v[15]) then extraFrame:Hide() end
									break;
								end
							end
						end
					end
				else
					if AtlasLoot_SetItemPrice(pricetext1, priceicon1, dataSource[dataID][i][6], dataSource[dataID][i][7]) then extraFrame:Hide() end
	                if AtlasLoot_SetItemPrice(pricetext2, priceicon2, dataSource[dataID][i][8], dataSource[dataID][i][9]) then extraFrame:Hide() end
	                if AtlasLoot_SetItemPrice(pricetext3, priceicon3, dataSource[dataID][i][10], dataSource[dataID][i][11]) then extraFrame:Hide() end
	                if AtlasLoot_SetItemPrice(pricetext4, priceicon4, dataSource[dataID][i][12], dataSource[dataID][i][13]) then extraFrame:Hide() end
	                if AtlasLoot_SetItemPrice(pricetext5, priceicon5, dataSource[dataID][i][14], dataSource[dataID][i][15]) then extraFrame:Hide() end
				end

                --For convenience, we store information about the objects in the objects so that it can be easily accessed later
                getglobal("AtlasLootItem_"..i).itemID = dataSource[dataID][i][1];
                getglobal("AtlasLootItem_"..i).storeID = dataSource[dataID][i][1];
                getglobal("AtlasLootItem_"..i).iteminfo = {};
                getglobal("AtlasLootItem_"..i).iteminfo.idcore = dataSource[dataID][i][1];
                getglobal("AtlasLootItem_"..i).iteminfo.icontexture = "Interface\\Icons\\"..dataSource[dataID][i][2];
                getglobal("AtlasLootItem_"..i).itemTexture = dataSource[dataID][i][2];
                if dataID == "WishList" then
					getglobal("AtlasLootItem_"..i).sourcePage = dataSource[dataID][i][5];
				else
					getglobal("AtlasLootItem_"..i).droprate = dataSource[dataID][i][5];
				end
                if getglobal("AtlasLootItem_"..i).droprate == "" then
                    getglobal("AtlasLootItem_"..i).droprate = nil;
                end
                getglobal("AtlasLootItem_"..i).i = 1;
                getglobal("AtlasLootItem_"..i):Show();

                --If the item is not in cache, querying the server may cause a disconnect
                --Show a red box around the item to indicate this to the user
                if((not GetItemInfo(dataSource[dataID][i][1])) and (dataSource[dataID][i][1] ~= 0)) then
                    getglobal("AtlasLootItem_"..i.."_Unsafe"):Show();
                else
                    getglobal("AtlasLootItem_"..i.."_Unsafe"):Hide();
                end

                --Decide whether to show the Heroic mode toggle
                --Checks if a heroic version of the loot table is available.
                HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
                HeroicdataID=dataID.."HEROIC";
                if dataSource[HeroicdataID] then
                    AtlasLootItemsFrame_Heroic:Show();
                    AtlasLootItemsFrame_Heroic:SetChecked(false);
                else
                    if HeroicCheck=="HEROIC" then
                        AtlasLootItemsFrame_Heroic:Show();
                        AtlasLootItemsFrame_Heroic:SetChecked(true);
                    end
                end
            else
                getglobal("AtlasLootItem_"..i):Hide();
            end
        end

        --Hide navigation buttons by default, only show what we need
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        AtlasLoot_BossName:SetText(boss);
        --Consult the button registry to determine what nav buttons are required
        if dataID == "WishList" then
			if wlPage < wlPageMax then
				getglobal("AtlasLootItemsFrame_NEXT"):Show();
                getglobal("AtlasLootItemsFrame_NEXT").lootpage = "WishListPage"..(wlPage + 1);
			end
			if wlPage > 1 then
				getglobal("AtlasLootItemsFrame_PREV"):Show();
                getglobal("AtlasLootItemsFrame_PREV").lootpage = "WishListPage"..(wlPage - 1);
			end
        elseif AtlasLoot_ButtonRegistry[dataID] then
            local tablebase = AtlasLoot_ButtonRegistry[dataID];
            AtlasLoot_BossName:SetText(tablebase.Title);
            if tablebase.Next_Page then
                getglobal("AtlasLootItemsFrame_NEXT"):Show();
                getglobal("AtlasLootItemsFrame_NEXT").lootpage = tablebase.Next_Page;
                getglobal("AtlasLootItemsFrame_NEXT").title = tablebase.Next_Title;
            end
            if tablebase.Prev_Page then
                getglobal("AtlasLootItemsFrame_PREV"):Show();
                getglobal("AtlasLootItemsFrame_PREV").lootpage = tablebase.Prev_Page;
                getglobal("AtlasLootItemsFrame_PREV").title = tablebase.Prev_Title;
            end
            if tablebase.Back_Page then
                getglobal("AtlasLootItemsFrame_BACK"):Show();
                getglobal("AtlasLootItemsFrame_BACK").lootpage = tablebase.Back_Page;
                getglobal("AtlasLootItemsFrame_BACK").title = tablebase.Back_Title;
            end
        end
    end

    --For Alphamap and Atlas integration, show a 'close' button to hide the loot table and restore the map view
    if (AtlasLootItemsFrame:GetParent() == AlphaMapAlphaMapFrame or AtlasLootItemsFrame:GetParent() == AtlasFrame) then
        AtlasLootItemsFrame_CloseButton:Show();
    else
        AtlasLootItemsFrame_CloseButton:Hide();
    end

    --Anchor the item frame where it is supposed to be
    AtlasLoot_SetItemInfoFrame(pFrame);
end

--[[
AtlasLoot_SetItemInfoFrame(pFrame):
pFrame - Data structure with anchor info.  Format: {Anchor Point, Relative Frame, Relative Point, X Offset, Y Offset }
This function anchors the item frame where appropriate.  The main Atlas frame can be passed instead of a custom pFrame.
If no pFrame is specified, the Atlas Frame is used if Atlas is installed.
]]
function AtlasLoot_SetItemInfoFrame(pFrame)
    if ( pFrame ) then
        --If a pFrame is specified, use it
        if(pFrame==AtlasFrame and AtlasFrame) then
            AtlasLootItemsFrame:ClearAllPoints();
            AtlasLootItemsFrame:SetParent(AtlasFrame);
            AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
        else
            AtlasLootItemsFrame:ClearAllPoints();
            AtlasLootItemsFrame:SetParent(pFrame[2]);
            AtlasLootItemsFrame:ClearAllPoints();
            AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
        end
    elseif ( AtlasFrame ) then
        --If no pFrame is specified and Atlas is installed, anchor in Atlas
        AtlasLootItemsFrame:ClearAllPoints();
        AtlasLootItemsFrame:SetParent(AtlasFrame);
        AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
    else
        --Last resort, dump the items frame in the middle of the screen
        AtlasLootItemsFrame:ClearAllPoints();
        AtlasLootItemsFrame:SetParent(UIParent);
        AtlasLootItemsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
    end
    AtlasLootItemsFrame:Show();
end

--[[
AtlasLootItemsFrame_OnCloseButton:
Called when the close button on the item frame is clicked
]]
function AtlasLootItemsFrame_OnCloseButton()
    --Set no loot table as currently selected
    AtlasLootItemsFrame.activeBoss = nil;
    --Fix the boss buttons so the correct icons are displayed
    if ATLAS_CUR_LINES then
        for i=1,ATLAS_CUR_LINES do
            if getglobal("AtlasBossLine"..i.."_Selected"):IsVisible() then
                getglobal("AtlasBossLine"..i.."_Selected"):Hide();
                getglobal("AtlasBossLine"..i.."_Loot"):Show();
            end
        end
    end
    --Hide the item frame
    AtlasLootItemsFrame:Hide();
end

--[[
AtlasLootMenuItem_OnClick:
Requests the relevant loot page from a menu screen
]]
function AtlasLootMenuItem_OnClick()
    if this.isheader == nil or this.isheader == false then
        AtlasLoot_ShowBossLoot(this.lootpage, getglobal(this:GetName().."_Name"):GetText(), AtlasLoot_AnchorFrame);
    end
end

--[[
AtlasLoot_NavButton_OnClick:
Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
]]
function AtlasLoot_NavButton_OnClick()
    if AtlasLootItemsFrame.refresh and AtlasLootItemsFrame.refresh[2] and AtlasLootItemsFrame.refresh[4] then
		if strsub(this.lootpage, 1, 12) == "WishListPage" then
			AtlasLoot_ShowItemsFrame("WishList", this.lootpage, AL["WishList"], AtlasLootItemsFrame.refresh[4]);
		else
        	AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItemsFrame.refresh[2], this.title, AtlasLootItemsFrame.refresh[4]);
        end
    else
        --Fallback for if the requested loot page is a menu and does not have a .refresh instance
        AtlasLoot_ShowItemsFrame(this.lootpage, "dummy", this.title, AtlasFrame);
    end
end

--[[
AtlasLoot_HeroicModeToggle:
Switches between the heroic and normal versions of a loot page
]]
function AtlasLoot_HeroicModeToggle()
    local Heroic = AtlasLootItemsFrame.refresh[1].."HEROIC";
    local dataID = AtlasLootItemsFrame.refresh[1];
    local HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
    local Lootpage;
    if HeroicCheck=="HEROIC" then
        Lootpage=string.sub(dataID, 1, string.len(dataID)-6);
        AtlasLoot.db.profile.HeroicMode = false;
    else
        Lootpage=Heroic;
        AtlasLoot.db.profile.HeroicMode = true;
    end
    AtlasLoot_ShowItemsFrame(Lootpage, AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]);
end

--[[
AtlasLoot_IsLootTableAvailable(dataID):
Checks if a loot table is in memory and attempts to load the correct LoD module if it isn't
dataID: Loot table dataID
]]
function AtlasLoot_IsLootTableAvailable(dataID)

    local menu_check=false;

    local moduleName=nil;

    for k,v in pairs(AtlasLoot_MenuList) do
        if v == dataID then
            menu_check=true;
        end
    end

    if menu_check then
        return true;
    else
        if not AtlasLoot_TableNames[dataID] then
            DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..WHITE..dataID..AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"]);
            return false;
        end

        local dataSource = AtlasLoot_TableNames[dataID][2];

        moduleName = AtlasLoot_GetLODModule(dataSource);

        if AtlasLoot_Data[dataSource] then
            if AtlasLoot_Data[dataSource][dataID] then
                return true;
            end
        else
            if not IsAddOnLoaded(moduleName) then
                loaded, reason=LoadAddOn(moduleName);
                if not loaded then
                    if (reason == "MISSING") or (reason == "DISABLED") then
                        DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..AtlasLoot_TableNames[dataID][1]..WHITE..AL[" is unavailable, the following load on demand module is required: "]..ORANGE..moduleName);
                        return false;
                    else
                        DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..WHITE..AL["Status of the following module could not be determined: "]..ORANGE..moduleName);
                        return false;
                    end
                end
            end
            if AtlasLoot_Data[dataSource][dataID] then
                if AtlasLoot.db.profile.LoDNotify then
                    DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..moduleName..WHITE.." "..AL["sucessfully loaded."]);
                end
                collectgarbage("collect");
                return true;
            else
                DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..ORANGE..AtlasLoot_TableNames[dataID][1]..WHITE..AL[" could not be accessed, the following module may be out of date: "]..ORANGE..moduleName);
                return false;
            end
        end
    end
end

--[[
AtlasLoot_GetLODModule(dataSource)
Returns the name of the module that needs to be loaded
dataSource: Location of the loot table
]]
function AtlasLoot_GetLODModule(dataSource)
    if (dataSource=="AtlasLootItems") then
        return "AtlasLoot_OldInstances";
    elseif (dataSource=="AtlasLootExpansionItems") then
        return "AtlasLoot_BCInstances";
    elseif (dataSource=="AtlasLootCrafting") then
        return "AtlasLoot_Crafting";
    elseif (dataSource=="AtlasLootBGItems") or (dataSource=="AtlasLootGeneralPvPItems") or (dataSource=="AtlasLootWorldPvPItems") or (dataSource=="AtlasLootSetItems") then
        return "AtlasLoot_SetsandPvP";
    elseif (dataSource=="AtlasLootRepItems") then
        return "AtlasLoot_RepFactions";
    elseif (dataSource=="AtlasLootWBItems") or (dataSource=="AtlasLootWorldEvents") then
        return "AtlasLoot_WorldLoot";
    end
end

--[[
AtlasLoot_LoadAllModules()
Used to load all available LoD modules
]]
function AtlasLoot_LoadAllModules()
    local flag=0;
    if not AtlasLoot_Data["AtlasLootItems"] then
        LoadAddOn("AtlasLoot_OldInstances");
        flag=1;
    end
    if not AtlasLoot_Data["AtlasLootExpansionItems"] then
        LoadAddOn("AtlasLoot_BCInstances");
        flag=1;
    end
    if not AtlasLoot_Data["AtlasLootBGItems"] then
        LoadAddOn("AtlasLoot_SetsandPvP");
        flag=1;
    end
    if not AtlasLoot_Data["AtlasLootRepItems"] then
        LoadAddOn("AtlasLoot_RepFactions");
        flag=1;
    end
    if not AtlasLoot_Data["AtlasLootWBItems"] then
        LoadAddOn("AtlasLoot_WorldLoot");
        flag=1;
    end
    if not AtlasLoot_Data["AtlasLootCrafting"] then
        LoadAddOn("AtlasLoot_Crafting");
        flag=1;
    end
    if flag == 1 then
        if AtlasLoot.db.profile.LoDNotify then
            DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..WHITE..AL["All Available Modules Loaded"]);
        end
        collectgarbage("collect");
    end
end
