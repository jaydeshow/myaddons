-- Create appropriate namespace. Populate slots with applicable slots to be searched for gems..
GCount = {};
GCount.Func = {};
GCount.Func.Hooked = {};
GCount.Slots = {};
GCount.Slots[1] = "HeadSlot";
GCount.Slots[2] = "NeckSlot";
GCount.Slots[3] = "ShoulderSlot";
GCount.Slots[4] = "BackSlot";
GCount.Slots[5] = "ChestSlot";
GCount.Slots[6] = "WristSlot";
GCount.Slots[7] = "HandsSlot";
GCount.Slots[8] = "WaistSlot";
GCount.Slots[9] = "LegsSlot";
GCount.Slots[10] = "FeetSlot";
GCount.Slots[11] = "Finger0Slot";
GCount.Slots[12] = "Finger1Slot";
GCount.Slots[13] = "MainHandSlot";
GCount.Slots[14] = "SecondaryHandSlot"; 
GCount.Slots[15] = "RangedSlot";

--Function to parse a gem and return the colors it accounts for.
--
--Expects: gem - ItemLink of an existing gem.
--Returns:
--        4 element table. Elements indexed: 1, 2, 3, 4
--          1 = Meta. Values interpreted as:
--                  0 = No meta.
--                  1 = Meta found. Dormant.
--                  2 = Meta found. Active.
--          2 = Red. Values interpreted as:
--                  0 = Gem does not count as red.
--                  1 = Gem counts as red.
--          3 = Yellow. Values interpreted as:
--                  0 = Gem does not count as yellow.
--                  1 = Gem counts as yellow.
--          4 = Blue. Values interpreted as:
--                  0 = Gem does not count as blue.
--                  1 = Gem counts as blue.
function GCount.Func.ParseGem(gem)
    
    local self = {};
    self[1] = 0;
    self[2] = 0;
    self[3] = 0;
    self[4] = 0;
    
    local intrnl = {};
    intrnl.linecount = 0;
    intrnl.line = nil;
    intrnl.text = "";
    
    GCountTooltip:ClearLines();
    GCountTooltip:SetHyperlink(gem);
    intrnl.linecount = GCountTooltip:NumLines();
    intrnl.line = getglobal("GCountTooltipTextLeft" .. intrnl.linecount);
    intrnl.color = intrnl.line:GetTextColor();
    intrnl.text = intrnl.line:GetText();

    if (strfind(intrnl.text,"多彩") ~= nil) then
        if (strfind(getglobal("GCountTooltipTextLeft3"):GetText(),"|cff808080") ~= nil) then
            self[1] = 1;
        else
            self[1] = 2;
        end
    end
    if (strfind(intrnl.text,"红") ~= nil) then
        self[2] = 1;
    end
    if (strfind(intrnl.text,"黄") ~= nil) then
        self[3] = 1;
    end
    if (strfind(intrnl.text,"蓝") ~= nil) then
        self[4] = 1;
    end
    
    return self;
    
end

--Function to list gems included within a slot of the player.
--
--Expects: slot - InventorySlotType value of slot to be searched.
--Returns: 
--        Nil if no item in slot, or
--        3 element table. Elements indexed: 1, 2, 3
--          1 = First gem.
--              ItemLink = Gem found. ItemLink indexed.
--              Nil = No gem.
--          2 = Second gem.
--              ItemLink = Gem found. ItemLink indexed.
--              Nil = No gem.
--          3 = Third gem.
--              ItemLink = Gem found. ItemLink indexed.
--              Nil = No gem.
function GCount.Func.GetGems(slot)
    
    local self = {};
	local item = GetInventoryItemLink("player",GetInventorySlotInfo(slot));
    if (item) then
        _, self[1] = GetItemGem(item,1)
        _, self[2] = GetItemGem(item,2)
        _, self[3] = GetItemGem(item,3)
        return self;
    else
        return nil;
    end
    
    
    
end

--Function is post-hooked to the "UpdatePaperdollStats" function within the Blizzard interface.
--Reacts to an additional dropdown menu selection, providing expected utility.
--Formats the dropdown tab with the correct information, supplied from "GetGems" and "ParseGem" functions.
--Hooked instead of supplied as a seperate function to allow for seamless adaptation to changes applied
--within the "UpdatePaperdollStats" function that are meant to be constant across all tabs.
--
--Expects: 
--        prefix - Supplied UI element prefix, used to differentiate between tabs.
--        index - Currently selected tab.
--Returns: Nil
function GCount.Func.UpdateGems(prefix, index,...)
    
    getglobal(prefix .. 3):SetScript("OnEnter", PaperDollStatTooltip);
    getglobal(prefix .. 5):SetScript("OnEnter", PaperDollStatTooltip);
    getglobal(prefix .. 6):SetScript("OnEnter", PaperDollStatTooltip);
    
	if (index == "PLAYERSTAT_GEMS") then
        
        
        local count = {};
        count[1] = 0;
        count[2] = 0;
        count[3] = 0;
        count[4] = 0;
        
        local Labels = {}
        for i = 1, 6 do
        Labels[i] = getglobal(prefix .. i);
        Labels[i]:SetScript("OnEnter",nil);
        end
        
        getglobal(Labels[1]:GetName() .. "Label"):SetText("多彩特效:");
        getglobal(Labels[2]:GetName() .. "Label"):SetText("|CFFFF0000红色宝石:");
        getglobal(Labels[3]:GetName() .. "Label"):SetText("|Cffffff00黄色宝石:");
        getglobal(Labels[4]:GetName() .. "Label"):SetText("|CFF00FFFF蓝色宝石:");
        getglobal(Labels[5]:GetName() .. "Label"):SetText("");
        getglobal(Labels[6]:GetName() .. "Label"):SetText("|Cff808080 汉化：Entruv");
    
        for _,v in pairs(GCount.Slots) do
            local intrnl = GCount.Func.GetGems(v);
            if (intrnl) then
                for _,v in pairs(intrnl) do
                    if (v) then
                        local xintrnl = GCount.Func.ParseGem(v);
                        count[1] = count[1] + xintrnl[1];
                        count[2] = count[2] + xintrnl[2];
                        count[3] = count[3] + xintrnl[3];
                        count[4] = count[4] + xintrnl[4];
                    end
                end
            end
        end
        
        if (count[1] == 0) then
            getglobal(Labels[1]:GetName() .. "StatText"):SetText("无");
        elseif (count[1] == 1) then
            getglobal(Labels[1]:GetName() .. "StatText"):SetText("|cffff2020失效 |r");
        else
            getglobal(Labels[1]:GetName() .. "StatText"):SetText("|cff20ff20激活|r");
        end
        
        getglobal(Labels[2]:GetName() .. "StatText"):SetText(count[2]);
        getglobal(Labels[3]:GetName() .. "StatText"):SetText(count[3]);
        getglobal(Labels[4]:GetName() .. "StatText"):SetText(count[4]);
        getglobal(Labels[5]:GetName() .. "StatText"):SetText("");
        getglobal(Labels[6]:GetName() .. "StatText"):SetText("");
        
    end
    
end

--Function is actual hook of "UpdatePaperdollStats" Replaces function and runs replaced when called.
--Then runs additional post-hook function.
--
--Expects:
--        prefix - prefix - Supplied UI element prefix, used to differentiate between tabs.
--        index - Currently selected tab.
--Returns: All values passed. Allows additional parameters to be accepted and passed to Blizzard function.
GCount.Func.Hooked.UpdatePaperdollStats = UpdatePaperdollStats;
function UpdatePaperdollStats(prefix,index,...)
    GCount.Func.Hooked.UpdatePaperdollStats(prefix,index,...)
    GCount.Func.UpdateGems(prefix,index,...)
    return prefix, index, ...;
    
end

--Function adds actual buttons to selected dropdown menu on the Character sheet.
--
--Expects: side - "Left" or "Right". Specific side button should be added.
--Returns: Nil
function GCount.Func.AddButton(side)

	local info = UIDropDownMenu_CreateInfo();
	local checked;
    if ( "宝石" == getglobal("PLAYERSTAT_" .. strupper(side) .. "DROPDOWN_SELECTION") ) then
		checked = 1;
	else
		checked = nil;
	end
	info.text = "宝石";
	info.func = getglobal("PlayerStatFrame" .. side .. "DropDown_OnClick");
	info.value = "PLAYERSTAT_GEMS";
	info.checked = checked;
	info.owner = UIDROPDOWNMENU_OPEN_MENU;
	UIDropDownMenu_AddButton(info);
    
end

--Function hooks the initilization function that pertains to the left dropdown menu on the Character sheet.
--Runs hooked function, and independant function, that adds the Gems dropdown option to the left window.
--
--Expects: Any. Allows additional parameters to be accepted and passed to Blizzard function.
--Returns: Nil
GCount.Func.Hooked.PlayerStatFrameLeftDropDown_Initialize = PlayerStatFrameLeftDropDown_Initialize;
function PlayerStatFrameLeftDropDown_Initialize(...)
    
    GCount.Func.Hooked.PlayerStatFrameLeftDropDown_Initialize(...);
    GCount.Func.AddButton("Left");
    return ...;
    
end

--Function hooks the initilization function that pertains to the right dropdown menu on the Character sheet.
--Runs hooked function, and independant function, that adds the Gems dropdown option to the right window.
--
--Expects: Any. Allows additional parameters to be accepted and passed to Blizzard function.
--Returns: Nil
GCount.Func.Hooked.PlayerStatFrameRightDropDown_Initialize = PlayerStatFrameRightDropDown_Initialize;
function PlayerStatFrameRightDropDown_Initialize(...)
    
    GCount.Func.Hooked.PlayerStatFrameRightDropDown_Initialize(...);
    GCount.Func.AddButton("Right");
    return ...;
    
end
