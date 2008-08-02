

--[[
	AccountantData.lua
	
	Declare the global namespace, data, and constants
--]]

-- Reserve the naamespace
Accountant = {}
-- Saved by WoW so leave in global namespace
Accountant_SaveData = nil;

-- Create a short cut
local SC = Accountant

SC.Version = "3.0";
SC.AUTHOR = "urnati"
ACCOUNTANT_OPTIONS_TITLE = "Accountant Options";
ACCOUNTANT_BUTTON_TOOLTIP = "Toggle Accountant";

SC.log_modes = {"Session","Day","Week","Total"};
SC.log_modes_short = {"Sess","Day","Week","Tot"};
	