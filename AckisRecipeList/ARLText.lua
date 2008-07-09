--[[
****************************************************************************************

ARLText.lua

Text based output functions for all of AckisRecipeList

$Date: 2008-07-07 00:27:15 -0400 (Mon, 07 Jul 2008) $
$Rev: 77962 $

****************************************************************************************
]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")

local addon = AckisRecipeList

--[[

	Non-gui output functions

]]--

-- Prints out to chat the recipe and where it can be found.

function addon:PrintRecipeInfo(RecipeName)

	if (addon.MissingRecipeListing[RecipeName]["Acquire"] ~= nil) then

		DEFAULT_CHAT_FRAME:AddMessage(self:Purple(L["MissingRecipePrefix"]) .. self:Green(RecipeName .. " - [" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]") .. addon.br .. addon.MissingRecipeListing[RecipeName]["Acquire"])

	else

		DEFAULT_CHAT_FRAME:AddMessage(self:Purple(L["MissingRecipePrefix"]) .. self:Green(RecipeName .. " - [" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]"))

	end

end

-- Identifies that a scan is occuring in chat

function addon:InitiateScan(CurrentProfession, CurrentProfessionLevel, CurrentSpeciality)

	if (CurrentSpeciality == "") then

		-- Identify scan occuring in chat
		DEFAULT_CHAT_FRAME:AddMessage(self:Copper(addon.ARLTitle))
		DEFAULT_CHAT_FRAME:AddMessage(self:Purple(L["InitiateScan"]:format(CurrentProfession, CurrentProfessionLevel)))

	else

		-- Identify scan occuring in chat
		DEFAULT_CHAT_FRAME:AddMessage(self:Purple(L["InitiateScanSpecial"]:format(CurrentProfession, CurrentSpeciality, CurrentProfessionLevel)))
	
	end

end

-- Displays a summary of known recipes, total recipes and percentages.

function addon:PrintRecipeListSummary()

	local NumMissingRecipes = addon.NumberOfRecipes - addon.FoundRecipes
	DEFAULT_CHAT_FRAME:AddMessage(self:Purple(L["RecipeListSummary"]:format(addon.FoundRecipes, addon.NumberOfRecipes, math.floor(addon.FoundRecipes / addon.NumberOfRecipes * 100), NumMissingRecipes)))

end

-- Determines which recipes are known and which are not known, printing them out to the chat frame.

function addon:DisplayRecipeResults(CurrentProfessionLevel, SortedList, CurrentProfession, CurrentSpeciality)

	-- Parse the addon.MissingRecipeListing, printing out the entries
	if (addon.MissingRecipeListing ~= nil) then

		-- No sorting at all
		if (SortedList == nil) then

			local RecipeName = next(addon.MissingRecipeListing, nil)

			while (RecipeName ~= nil) do

				if (addon:CheckDisplayRecipe(RecipeName, CurrentProfessionLevel, CurrentProfession, CurrentSpeciality)) then

					addon:PrintRecipeInfo(RecipeName)

				end

				-- Move on to the next entry in the table
				RecipeName = next(addon.MissingRecipeListing, RecipeName)
	
			end

		else

			for i, RecipeName in ipairs(SortedList) do

				if (addon:CheckDisplayRecipe(RecipeName, CurrentProfessionLevel, CurrentProfession, CurrentSpeciality)) then

					addon:PrintRecipeInfo(RecipeName)

				end

			end

		end

	end

	addon:PrintRecipeListSummary()

end

--[[

	GUI text output functions

]]--

-- Prints out to chat a message stating that a current recipe is missing from the internal database.

function addon:printMissingSkill(RecipeName)

	self:Print(self:Red(RecipeName) .. self:White(L["MissingFromDB"]))

end
