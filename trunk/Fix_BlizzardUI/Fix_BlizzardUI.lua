------------------------------------------------------
--    Fix_BlizzardUI
------------------------------------------------------
-- A simple addon that fixes the default Blizzard UI
-- issues, such as,
--
-- 1, Raid buttons being un-clickable,
-- 2, The annoying "Blizzard_InspectUI" error that pops
--    up when the player first opens his character/honor
--    UI frames.
--
-- SPECIAL NOTES
--
-- Actually this addon was inspired by numerous addons,
-- ideas and researches that have been done by other
-- people over the internet. I simply assembled and 
-- integrated their works into one addon, even though I
-- don't exactly know who they are, they shall have all 
-- credits and my salute. :)
--
-- July 2nd, 2007
--
-- Abin (abinn32@yahoo.com)
------------------------------------------------------

function Fix_BlizzardUI_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Fix_BlizzardUI|r by Abin Loaded.");
end

function Fix_BlizzardUI_OnEvent()
	if arg1 == "Blizzard_RaidUI" then
		local frame = getglobal("RaidFrame");
		if type(frame) == "table" and type(frame.SetScript) == "function" then
			frame:SetScript("OnShow", Fix_BlizzardUI_HookedRaidFrame_OnShow);
		end
	end
end

function Fix_BlizzardUI_HookedRaidFrame_OnShow()
	local i;
	for i = 1, 40 do 
		local button = getglobal("RaidGroupButton"..i);
		if type(button) == "table" and button.unit then
			button:SetAttribute("type", "target");
			button:SetAttribute("unit", button.unit);
		end
	end
end