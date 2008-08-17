--[[
****************************************************************************************

ARLFrame.lua

Frame functions for all of AckisRecipeList

$Date: 2008-08-15 17:16:34 -0400 (Fri, 15 Aug 2008) $
$Rev: 80505 $

****************************************************************************************
]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")

local addon = AckisRecipeList

local string = string
local ipairs = ipairs
local tinsert = tinsert
local CraftIsPetTraining = CraftIsPetTraining

-- Prototype: http://i30.tinypic.com/2hoxncl.jpg
-- I want to turn the GUI into that, but prettier... most functionality is in already, all the tables etc are created, just need to actually use the information now.

-- Calculates the total height of all the recipes in the child frame

local function CalculateChildHeight()

	local tempheight = 0
	local RecipeFrame = AckisRecipeListRecipe1

	while (RecipeFrame ~= nil) do
		tempheight = RecipeFrame:GetHeight() + RecipeFrame.RecipeAquireText:GetHeight() + tempheight
		RecipeFrame = RecipeFrame.NextRecipe
	end

	return tempheight

end

-- Adds recipe text info to the frames
-- Function to run when the + is clicked in the frame.  Will expand the recipe name and print out how to obtain it.

local function OnClickExpandRecipe()

	if (this.IsPushed == false) then
		local RecipeText = nil

		local sorttype = addon.db.profile.sorting
		if (sorttype == "Skill") or (sorttype == "Aquisition") then
			--RecipeText = string.match(this:GetText(), "|c.*%[.*%]|r %- |c%x*(.*)|r")
			RecipeText = string.match(this:GetText(), "%- |c%x%x%x%x%x%x%x%x(.*)|r$")
		elseif (sorttype == "Name") then
			--RecipeText = string.match(this:GetText(), "|c%x*(.*)|r %- |c.*%[.*%]|r")
			RecipeText = string.match(this:GetText(), "|c%x%x%x%x%x%x%x%x(.-)|r")
		end

		-- Changed the graphic of the + to a -
		this:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
		this:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
		this:SetHighlightTexture("Interface\\Buttons\\UI-MinusButton-Hilight")

		-- Keep track of button state
		this.IsPushed = true

		-- Show expanded text
		if (addon.MissingRecipeListing[RecipeText] == nil) then
			this.RecipeAquireText:SetText(addon:White(L["Unknown"]))
		else
			this.RecipeAquireText:SetText(addon:White("    - " .. addon.MissingRecipeListing[RecipeText]["Acquire"]))
		end

		this.RecipeAquireText:SetWidth(300)

		this.RecipeAquireText:Show()

		-- Reposition the next recipe entry
		if (this.NextRecipe ~= nil) then
			this.NextRecipe:ClearAllPoints()
			this.NextRecipe:SetPoint("TOPLEFT", this.RecipeAquireText, "BOTTOMLEFT", -20, -5)
		end

	else

		-- Changed the graphic of the - to a +
		this:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		this:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
		this:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")

		-- Keep track of button state
		this.IsPushed = false

		-- Hide expanded text
		this.RecipeAquireText:SetText("")
		this.RecipeAquireText:Hide()

		-- Reposition the next recipe entry
		if (this.NextRecipe ~= nil) then
			this.NextRecipe:ClearAllPoints()
			this.NextRecipe:SetPoint("TOPLEFT", this, "BOTTOMLEFT", 0, 0)
		end
	end

	addon.Frame.ScrollFrame:UpdateScrollChildRect()

end

-- Adds recipe text info to the frames

local function AddRecipeInfo(CurrentProfession, CurrentProfessionLevel, SortedList, CurrentSpeciality)

	local OldFrame = nil
	local RecipeFrame = nil
	local RecipeCount = 1
	
	for i, RecipeName in ipairs(SortedList) do

		if (addon:CheckDisplayRecipe(RecipeName, CurrentProfessionLevel, CurrentProfession, CurrentSpeciality)) then

			-- If the frame isn't created, then create it and set the parameters for it, otherwise use the current frame (recycle it)
			if (not _G["AckisRecipeListRecipe" .. RecipeCount]) then
				RecipeFrame = CreateFrame("Button", "AckisRecipeListRecipe" .. RecipeCount, addon.Frame.ScrollChild, "ClassTrainerSkillButtonTemplate")
				RecipeFrame:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
				RecipeFrame:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
				RecipeFrame:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
				RecipeFrame:SetWidth(18)
				RecipeFrame:SetScript("OnClick",
											OnClickExpandRecipe
									)
				RecipeFrame:SetScript("OnLeave", function()
											GameTooltip:Hide()
										end
							)
				RecipeFrame.IsPushed = false

				-- Create aquire text for the recipe
				RecipeFrame.RecipeAquireText = RecipeFrame:CreateFontString("AckisRecipeListRecipe" .. RecipeCount .. "Text", "DIALOG")

				RecipeFrame.RecipeAquireText:ClearAllPoints()
				RecipeFrame.RecipeAquireText:SetPoint("TOPLEFT", RecipeFrame, "BOTTOMLEFT", 20, 0)
				RecipeFrame.RecipeAquireText:SetFontObject("GameFontNormalSmall")
				RecipeFrame.RecipeAquireText:SetJustifyH("LEFT")

			else

				-- Grab the frame from the global stack
				RecipeFrame = _G["AckisRecipeListRecipe" .. RecipeCount]

			end

			-- If we have a previous recipe, set the previous recipe next recipe to this current recipe
			if (OldFrame ~= nil) then
				OldFrame.NextRecipe = RecipeFrame
			end

			-- If we're at the last recipe, set the next reicpe to nil, otherwise set the previous entries nextrecipe to a temp variable.
			local NumMissingRecipes = addon.NumberOfRecipes - addon.FoundRecipes
			if (i == NumMissingRecipes) then
				RecipeFrame.NextRecipe = nil
			else
				OldFrame = RecipeFrame
			end

			RecipeFrame:ClearAllPoints()

			-- If we're on the first recipe, set the points in relation to the main frame, otherwise set them in relation to the previous recipe
			if (RecipeCount == 1) then
				RecipeFrame:SetPoint("TOPLEFT",addon.Frame.ScrollChild,"TOPLEFT",5,0)
			else
				RecipeFrame:SetPoint("TOPLEFT", "AckisRecipeListRecipe" .. (RecipeCount - 1), "BOTTOMLEFT", 0, -1)
			end

			local temprecipetext

			local sorttype = addon.db.profile.sorting

			if (sorttype == "Skill") or (sorttype == "Aquisition") then
				if (addon.MissingRecipeListing[RecipeName]["Level"] > CurrentProfessionLevel) then
					temprecipetext = addon:Red("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]") .. " - " .. addon:White(RecipeName)
				else
					temprecipetext = addon:White("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]") .. " - " .. addon:White(RecipeName)
				end
			elseif (sorttype == "Name") then
				if (addon.MissingRecipeListing[RecipeName]["Level"] > CurrentProfessionLevel) then
					temprecipetext = addon:White(RecipeName) .. " - " .. addon:Red("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]")
				else
					temprecipetext = addon:White(RecipeName) .. " - " .. addon:White("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]")
				end
			end

			RecipeFrame:SetText(temprecipetext)
			RecipeFrame:SetScript("OnEnter", function(this)
					GameTooltip_SetDefaultAnchor(GameTooltip, this)
					if (addon.RecipeListing[RecipeName]["RecipeLink"] ~= nil) then
						GameTooltip:SetHyperlink(temprecipetext .. addon.br .. addon.RecipeListing[RecipeName]["RecipeLink"] .. addon.br ..  addon.MissingRecipeListing[RecipeName]["Acquire"])
					else
						GameTooltip:SetText(temprecipetext .. addon.br ..  addon.MissingRecipeListing[RecipeName]["Acquire"]) 
					end
					GameTooltip:Show()
				end
			)

			RecipeFrame:Show()
			RecipeCount = RecipeCount + 1
		end
	end
end

-- Closes the frame and cleans sets everything that was displayed to nil

function addon:CloseWindow()

	-- Clean up recipe entries
	local RecipeFrame = AckisRecipeListRecipe1

	-- Clear x number of entries for all missing recipes
	while (RecipeFrame ~= nil) do
		RecipeFrame.RecipeAquireText:SetText("")
		RecipeFrame.RecipeAquireText:Hide()

		RecipeFrame:SetText("")
		RecipeFrame:Hide()

		if (RecipeFrame.IsPushed == true) then
			RecipeFrame:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
			RecipeFrame:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
			RecipeFrame:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")
			RecipeFrame:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
			RecipeFrame.IsPushed = false
		end

		RecipeFrame.RecipeAquireText:SetText("")
		RecipeFrame.RecipeAquireText:Hide()
		RecipeFrame = RecipeFrame.NextRecipe
	end

	addon.Frame:Hide()

	addon.ResetOkayARL = true

	if (addon.ResetOkayBlizz and addon.ResetOkayARL) then
		addon:ResetVariables()
	end

end

-- Expands all the headers

function addon:ExpandAll()

	local frame = _G["AckisRecipeListRecipe1"]

	while (frame) do
		if (frame:IsShown() ~= nil) then
			if (frame.IsPushed == false) then
				frame:Click()
			end
		end
		frame = frame.NextRecipe
	end

end

-- Closes all the headers

function addon:CloseAll()

	local frame = _G["AckisRecipeListRecipe1"]

	while (frame) do
		if (frame:IsShown() ~= nil) then
			if (frame.IsPushed == true) then
				frame:Click()
			end
		end
		frame = frame.NextRecipe
	end

end

-- Create the scan button and add it to Skillet if applicable

function addon:CreateScanButton()
	-- Create the scan button
	if (not addon.ScanButton) then
		addon.ScanButton = CreateFrame("Button","addon.ScanButton",UIParent,"UIPanelButtonTemplate")
	end

	-- Add to Skillet interface
	if (Skillet and Skillet:IsActive()) then
		addon.ScanButton:SetParent(SkilletFrame)
		addon.ScanButton:Show()
		Skillet:AddButtonToTradeskillWindow(addon.ScanButton)
		addon.ScanButton:SetWidth(80)
	end

	-- Set some of the common button properties
	addon.ScanButton:SetHeight(20)
	addon.ScanButton:RegisterForClicks("LeftButtonUp")
	addon.ScanButton:SetScript("OnClick", function()
											addon:ToggleFrame()
										end
							)
	addon.ScanButton:SetScript("OnEnter", function(this)
											GameTooltip_SetDefaultAnchor(GameTooltip, this)
											GameTooltip:SetText(L["Scan Skills Long"])
											GameTooltip:Show()
										end
							)
	addon.ScanButton:SetScript("OnLeave", function()
											GameTooltip:Hide()
										end
							)
	addon.ScanButton:SetText(L["ScanButton"])
	addon.ScanButton:Enable()
end

-- Adds a button to the trade skill/skillet/crafting skill window allowing you to scan

function addon:ShowScanButton()
	-- Add to Fizzwidget Hunter's Helper
	if (FHH_UI and CraftIsPetTraining()) then
		addon.ScanButton:SetParent(FHH_UI)
		addon.ScanButton:ClearAllPoints()
		addon.ScanButton:SetPoint("RIGHT",FHH_UICloseButton,"LEFT",10,0)
		addon.ScanButton:SetWidth(addon.ScanButton:GetTextWidth() + 10)
	-- Add to ATSW
	elseif (ATSWFrame and not CraftIsPetTraining()) then
		addon.ScanButton:SetParent(ATSWFrame)
		addon.ScanButton:ClearAllPoints()
		addon.ScanButton:SetPoint("RIGHT", ATSWOptionsButton, "LEFT", 0, 0)
		addon.ScanButton:SetHeight(ATSWOptionsButton:GetHeight())
		addon.ScanButton:SetWidth(80)
	elseif (addon.SkillType == "Trade") then
	-- Anchor to trade window
		addon.ScanButton:SetParent(TradeSkillFrame)
		addon.ScanButton:ClearAllPoints()
		addon.ScanButton:SetPoint("RIGHT",TradeSkillFrameCloseButton,"LEFT",10,0)
		addon.ScanButton:SetWidth(addon.ScanButton:GetTextWidth() + 10)
	-- Anchor to crafting window
	elseif (addon.SkillType == "Craft") then
		addon.ScanButton:SetParent(CraftFrame)
		addon.ScanButton:ClearAllPoints()
		addon.ScanButton:SetPoint("RIGHT",CraftFrameCloseButton,"LEFT",10,0)
		addon.ScanButton:SetWidth(addon.ScanButton:GetTextWidth() + 10)
	end
	addon.ScanButton:SetFrameStrata("DIALOG")
	addon.ScanButton:Show()
end

-- imported by Zhinjio from SKG, generic button creation with nice borders
-- automagically takes care of normal button methods. Thanks again, ckk

function addon:TooltipDisplay( this, textLabel )
	this:SetScript( "OnEnter",
		function ( this )
			GameTooltip_SetDefaultAnchor( GameTooltip, this )
			GameTooltip:SetText( textLabel, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b )
			GameTooltip:Show()
		end
	)
	this:SetScript( "OnLeave",
		function( this )
			GameTooltip:Hide()
		end
	)
end

function addon.filterSwitch( val )
end

function addon.ToggleFilters()
	local xPos = addon.Frame:GetLeft()
	local yPos = addon.Frame:GetBottom()
	if ( addon.Frame._Expanded == true ) then
		-- Adjust the frame size and texture
		addon.Frame:Hide()
		addon.Frame:ClearAllPoints()
		addon.Frame:SetWidth(293)
		addon.Frame:SetHeight(447)
		addon.bgTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\main]] )
		addon.bgTexture:SetAllPoints( addon.Frame )
		addon.bgTexture:SetTexCoord( 0, (293/512), 0, (447/512) )
		addon.Frame._Expanded = false
		addon.Frame:SetPoint( "BOTTOMLEFT", UIParent, "BOTTOMLEFT", xPos, yPos )
		-- Change the text and tooltip for the filter button
		ARL_FilterButton:SetText( L["FILTER_OPEN"] )
		addon:TooltipDisplay( ARL_FilterButton, L["FILTER_OPEN_TT"] )

		ARL_ResetButton:Hide()
		ARL_ApplyButton:Hide()
		-- Hide the Filter CBs
--[[
		ARL_FLTGenText:Hide()
		ARL_AllianceCB:Hide()
		ARL_HordeCB:Hide()
		ARL_LevelCB:Hide()
		ARL_SpecialtyCB:Hide()
		ARL_ClassCB:Hide()
		ARL_KnownCB:Hide()
		ARL_UnknownCB:Hide()

		ARL_FLTObtText:Hide()
		ARL_InstanceCB:Hide()
		ARL_RaidCB:Hide()
		ARL_QuestCB:Hide()
		ARL_SeasonalCB:Hide()
		ARL_TrainerCB:Hide()
		ARL_VendorCB:Hide()
		ARL_PVPCB:Hide()
		ARL_DiscoveryCB:Hide()
		ARL_ReputationCB:Hide()
		ARL_RepPlus:Hide()

		ARL_FLTITypeText:Hide()
		ARL_ArmorCB:Hide()
		ARL_WeaponCB:Hide()
		ARL_BOPCB:Hide()
		ARL_ArmorPlus:Hide()
		ARL_WeaponPlus:Hide()

		ARL_FLTPTypeText:Hide()
		ARL_TankCB:Hide()
		ARL_MeleeCB:Hide()
		ARL_HealerCB:Hide()
		ARL_CasterCB:Hide()
]]--
		-- and finally, show our frame
		addon.Frame:Show()
	else
		-- Adjust the frame size and texture
		addon.Frame:Hide()
		addon.Frame:ClearAllPoints()
		addon.Frame:SetWidth(512)
		addon.Frame:SetHeight(447)
		addon.bgTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\expanded]] )
		addon.bgTexture:SetAllPoints( addon.Frame )
		addon.bgTexture:SetTexCoord( 0, 1, 0, (447/512) )
		addon.Frame._Expanded = true
		addon.Frame:SetPoint( "BOTTOMLEFT", UIParent, "BOTTOMLEFT", xPos, yPos )
		-- Change the text and tooltip for the filter button
		ARL_FilterButton:SetText( L["FILTER_CLOSE"] )
		addon:TooltipDisplay( ARL_FilterButton, L["FILTER_CLOSE_TT"] )

		ARL_ResetButton:Show()
		ARL_ApplyButton:Show()
		-- Show the Filter CBs
--[[
		ARL_FLTGenText:Show()
		ARL_AllianceCB:Show()
		ARL_HordeCB:Show()
		ARL_LevelCB:Show()
		ARL_SpecialtyCB:Show()
		ARL_ClassCB:Show()
		ARL_KnownCB:Show()
		ARL_UnknownCB:Show()

		ARL_FLTObtText:Show()
		ARL_InstanceCB:Show()
		ARL_RaidCB:Show()
		ARL_QuestCB:Show()
		ARL_SeasonalCB:Show()
		ARL_TrainerCB:Show()
		ARL_VendorCB:Show()
		ARL_PVPCB:Show()
		ARL_DiscoveryCB:Show()
		ARL_ReputationCB:Show()
		ARL_RepPlus:Show()

		ARL_FLTITypeText:Show()
		ARL_ArmorCB:Show()
		ARL_WeaponCB:Show()
		ARL_BOPCB:Show()
		ARL_ArmorPlus:Show()
		ARL_WeaponPlus:Show()

		ARL_FLTPTypeText:Show()
		ARL_TankCB:Show()
		ARL_MeleeCB:Show()
		ARL_HealerCB:Show()
		ARL_CasterCB:Show()
]]--
		-- and finally, show our frame
		addon.Frame:Show()
	end
end

function addon:GenericMakeCB( cButton, anchorFrame, ttText, scriptVal, row, col  )
	cButton:SetHeight( 24 )
	cButton:SetWidth( 24 )
	local xPos = 5 + ( ( col - 1 ) * 100 )
	local yPos = 3 - ( ( row - 1 ) * 18 )
	cButton:SetPoint( "TOPLEFT", anchorFrame, "BOTTOMLEFT", xPos, yPos )

	addon:TooltipDisplay( cButton, ttText, 1 )
	cButton:SetScript( "OnClick", function() addon.filterSwitch( scriptVal ) end )
	cButton:Hide()
end

function addon:GenericCreateButton(
	bName, parentFrame,	bHeight, bWidth,
	anchorFrom, anchorFrame, anchorTo, xOffset, yOffset,
	bNormFont, bHighFont, initText, tAlign, tooltipText, noTextures )

	-- I hate stretchy buttons. Thanks very much to ckknight for this code
	-- (found in RockConfig)

	-- when pressed, the button should look pressed
	local function button_OnMouseDown(this)
		if this:IsEnabled() == 1 then
			this.left:SetTexture([[Interface\Buttons\UI-Panel-Button-Down]])
			this.middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Down]])
			this.right:SetTexture([[Interface\Buttons\UI-Panel-Button-Down]])
		end
	end
	-- when depressed, return to normal
	local function button_OnMouseUp(this)
		if this:IsEnabled() == 1 then
			this.left:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
			this.middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
			this.right:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		end
	end

	local function button_Disable(this)
		this.left:SetTexture([[Interface\Buttons\UI-Panel-Button-Disabled]])
		this.middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Disabled]])
		this.right:SetTexture([[Interface\Buttons\UI-Panel-Button-Disabled]])
		this:__Disable()
		this:EnableMouse(false)
	end

	local function button_Enable(this)
		this.left:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		this.middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		this.right:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		this:__Enable()
		this:EnableMouse(true)
	end

	local button = CreateFrame( "Button", bName, parentFrame )

	button:SetWidth( bWidth )
	button:SetHeight( bHeight )

	if ( noTextures == 1 ) then
		local left = button:CreateTexture(button:GetName() .. "_LeftTexture", "BACKGROUND")
		button.left = left
		local middle = button:CreateTexture(button:GetName() .. "_MiddleTexture", "BACKGROUND")
		button.middle = middle
		local right = button:CreateTexture(button:GetName() .. "_RightTexture", "BACKGROUND")
		button.right = right

		left:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		right:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]])

		left:SetPoint("TOPLEFT")
		left:SetPoint("BOTTOMLEFT")
		left:SetWidth(12)
		left:SetTexCoord(0, 0.09375, 0, 0.6875)

		right:SetPoint("TOPRIGHT")
		right:SetPoint("BOTTOMRIGHT")
		right:SetWidth(12)
		right:SetTexCoord(0.53125, 0.625, 0, 0.6875)

		middle:SetPoint("TOPLEFT", left, "TOPRIGHT")
		middle:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")
		middle:SetTexCoord(0.09375, 0.53125, 0, 0.6875)

		button:SetScript("OnMouseDown", button_OnMouseDown)
		button:SetScript("OnMouseUp", button_OnMouseUp)
		button:SetScript("OnEnter", SubControl_OnEnter)
		button:SetScript("OnLeave", SubControl_OnLeave)

		button.__Enable = button.Enable
		button.__Disable = button.Disable
		button.Enable = button_Enable
		button.Disable = button_Disable

		local highlight = button:CreateTexture(button:GetName() .. "_Highlight", "OVERLAY", "UIPanelButtonHighlightTexture")
		button:SetHighlightTexture(highlight)
	elseif ( noTextures == 2 ) then
		button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		button:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
		button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
		button:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")
	elseif ( noTextures == 3 ) then
		button:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		button:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Hilight")
		button:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disable")
	end

	local text = button:CreateFontString(button:GetName() .. "_FontString", "ARTWORK")
	button:SetFontString(text)
	button.text = text
	text:SetPoint("LEFT", button, "LEFT", 7, 0)
	text:SetPoint("RIGHT", button, "RIGHT", -7, 0)
	text:SetJustifyH( tAlign )

	button:SetTextFontObject(bNormFont)
	button:SetHighlightFontObject(bHighFont)
	button:SetDisabledFontObject(GameFontDisableSmall)

	text:SetText( initText )		

	button:SetPoint( anchorFrom, anchorFrame, anchorTo, xOffset, yOffset )
	if ( tooltipText ~= "" ) then
		addon:TooltipDisplay( button, tooltipText)
	end

	return button
end

-- Allows the scan button to close the scan window

function addon:ToggleFrame()
	if (addon.Frame and addon.Frame:IsVisible()) then
		addon.Frame:Hide()
	else
		addon:AckisRecipeList_Command()
	end
end

-- Set the texture on the switcher button.

function addon.SetSwitcherTexture( tex )
-- This is really only called the first
-- time its displayed. It should reflect the first profession the user has 
-- selected, or that shows up in his lists.

-- For now, just display the first texture
	local ARL_S_NTexture = ARL_SwitcherButton:CreateTexture( "ARL_S_NTexture", "BACKGROUND" )
	ARL_S_NTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\]] .. tex .. [[_up]] )
	ARL_S_NTexture:SetTexCoord( 0, 1, 0, 1 )
	ARL_S_NTexture:SetAllPoints( ARL_SwitcherButton )
	local ARL_S_PTexture = ARL_SwitcherButton:CreateTexture( "ARL_S_PTexture", "BACKGROUND" )
	ARL_S_PTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\]] .. tex .. [[_down]] )
	ARL_S_PTexture:SetTexCoord( 0, 1, 0, 1 )
	ARL_S_PTexture:SetAllPoints( ARL_SwitcherButton )
	local ARL_S_DTexture = ARL_SwitcherButton:CreateTexture( "ARL_S_DTexture", "BACKGROUND" )
	ARL_S_DTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\]] .. tex .. [[_up]] )
	ARL_S_DTexture:SetTexCoord( 0, 1, 0, 1 )
	ARL_S_DTexture:SetAllPoints( ARL_SwitcherButton )

	ARL_SwitcherButton:SetNormalTexture( ARL_S_NTexture )
	ARL_SwitcherButton:SetPushedTexture( ARL_S_PTexture )
	ARL_SwitcherButton:SetDisabledTexture( ARL_S_DTexture )
end

-- Switch the displayed profession in the main panel

function addon.SwitchProfs()
	-- Figure out what professions we know...
	addon:GetKnownProfessions()

	-- This loop is gonna be weird. The reason is because we need to
	-- ensure that we cycle through all the known professions, but also
	-- that we do so in order. That means that if the currently displayed
	-- profession is the last one in the list, we're actually going to
	-- iterate completely once to get to the currently displayed profession
	-- and then iterate again to make sure we display the next one in line.
	-- Further, there is the nuance that the person may not know any
	-- professions yet at all. User are so annoying.
	local startLoop = 0
	local endLoop = 0
	local displayProf = 0

	-- ok, so first off, if we've never done this before, there is no "current"
	-- and a single iteration will do nicely, thank you
	if ( addon.CurrentProf == 0 ) then
		startLoop = 1
		endLoop = addon.MaxProfessions + 1
	else
		startLoop = addon.CurrentProf + 1
		endLoop = addon.CurrentProf
	end
	local index = startLoop
	while ( index ~= endLoop ) do
		if ( index > addon.MaxProfessions ) then
			index = 1
		else
			if ( addon.KnownProfessions[addon.SortedProfessions[index].name] == true ) then
				displayProf = index
				addon.CurrentProf = index
				break
			else
				index = index + 1
			end
		end
	end
	-- Redisplay the button with the new skill
	addon.SetSwitcherTexture( addon.SortedProfessions[addon.CurrentProf].texture )
end

-- What to do if someone clicks on a recipe button
function addon.RecipeItem_OnClick( button )
end

-- What to do if someone click on a plus button
function addon.PlusItem_OnClick( button )
end

-- Scrollframe update stuff
function addon.RecipeList_Update()
end

-- Creates the initial frame to display recipes into

function addon:CreateFrame(CurrentProfession, CurrentProfessionLevel, SortedRecipeIndex, CurrentSpeciality)

	addon.ResetOkayARL = false

	-- Normal GUI
	if (not addon.db.profile.testgui) then
		if (not addon.Frame) then

			-- Create the main frame
			addon.Frame = CreateFrame("Frame", "addon.Frame", UIParent)
			--Allows ARL to be closed with the Escape key
			tinsert(UISpecialFrames, "addon.Frame")

			addon.Frame:SetWidth(384)
			addon.Frame:SetHeight(430)
			addon.Frame:SetBackdrop(
			{
				bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
				edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
				tile="false",
				edgeSize = 16,
				insets = {
					left = 5,
					right = 5,
					top = 5,
					bottom = 5
				}
			})
			addon.Frame:SetBackdropColor(0, 0, 0)
			addon.Frame:EnableMouse(true)
			addon.Frame:EnableKeyboard(true)
			addon.Frame:SetMovable(true)
			addon.Frame:SetScript("OnMouseDown", function() addon.Frame:StartMoving() end)
			addon.Frame:SetScript("OnHide", function() self:CloseWindow()	end)
			addon.Frame:SetScript("OnMouseUp", function()	addon.Frame:StopMovingOrSizing() end)

			-- ATSW for some reason has a window "bigger" than what you can see
			if (ATSWFrame and not CraftIsPetTraining()) then
				addon.Frame:SetFrameStrata("DIALOG")
			end

			-- Add header frame
			addon.Frame.Header = CreateFrame("Frame", "addon.Frame.Header", addon.Frame)

			addon.Frame.Header:SetWidth(192)
			addon.Frame.Header:SetHeight(32)
			addon.Frame.Header:ClearAllPoints()
			addon.Frame.Header:SetPoint("TOP", addon.Frame, "TOP", 0, 6)
			addon.Frame.Header:EnableMouse(true)
			addon.Frame.Header:SetMovable(true)
			addon.Frame.Header:SetScript("OnMouseDown", function()
											addon.Frame:StartMoving()
										end
			)
			addon.Frame.Header:SetScript("OnMouseUp", function()
											addon.Frame:StopMovingOrSizing()
										end
			)

			-- Add texture to the header frame
			addon.Frame.Header.Texture = addon.Frame.Header:CreateTexture("addon.Frame.Header.Texture", "ARTWORK")

			addon.Frame.Header.Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
			addon.Frame.Header.Texture:SetWidth(475)
			addon.Frame.Header.Texture:SetHeight(64)
			addon.Frame.Header.Texture:ClearAllPoints()
			addon.Frame.Header.Texture:SetPoint("TOP", addon.Frame.Header, "TOP", 0, 5)

			-- Add text to header frame
			addon.Frame.Header.Text = addon.Frame.Header:CreateFontString("addon.Frame.Header.Text", "ARTWORK")

			addon.Frame.Header.Text:SetFontObject(GameFontNormal)
			addon.Frame.Header.Text:ClearAllPoints()
			addon.Frame.Header.Text:SetPoint("CENTER", addon.Frame.Header, "CENTER", 0, 0)
			addon.Frame.Header.Text:SetText(self:White(addon.ARLTitle))

			-- Add close button
			addon.Frame.CloseButton = CreateFrame("Button","addon.Frame.CloseButton",addon.Frame,"UIPanelButtonTemplate")

			addon.Frame.CloseButton:SetWidth(100)
			addon.Frame.CloseButton:SetHeight(24)
			addon.Frame.CloseButton:ClearAllPoints()
			addon.Frame.CloseButton:SetPoint("BOTTOMRIGHT", addon.Frame, -10, 10)
			addon.Frame.CloseButton:RegisterForClicks("LeftButtonUp")
			addon.Frame.CloseButton:SetScript("OnClick", function() self:CloseWindow() end)
			addon.Frame.CloseButton:SetScript("OnEnter", function(this)
												GameTooltip_SetDefaultAnchor(GameTooltip, this)
												GameTooltip:SetText(self:White(L["Close Window"]))
												GameTooltip:Show()
			end
										)
			addon.Frame.CloseButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
			if (not addon.wrath) then
				addon.Frame.CloseButton:SetFont("GameFontHighlightSmall",12)
			end
			addon.Frame.CloseButton:SetText(self:White(L["Close"]))
			addon.Frame.CloseButton:Enable()

			-- Add expand all button
			addon.Frame.ExpandAllButton = CreateFrame("Button","addon.Frame.ExpandAllButton",addon.Frame,"UIPanelButtonTemplate")

			addon.Frame.ExpandAllButton:SetWidth(16)
			addon.Frame.ExpandAllButton:SetHeight(16)
			addon.Frame.ExpandAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
			addon.Frame.ExpandAllButton:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
			addon.Frame.ExpandAllButton:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
			addon.Frame.ExpandAllButton:ClearAllPoints()
			addon.Frame.ExpandAllButton:SetPoint("TOPRIGHT",addon.Frame,"TOPRIGHT",-10,-20)
			addon.Frame.ExpandAllButton:SetScript("OnClick", function() self:ExpandAll() end)
			addon.Frame.ExpandAllButton:SetScript("OnEnter", function(this)
													GameTooltip_SetDefaultAnchor(GameTooltip, this)
													GameTooltip:SetText(self:White(L["Expand All"]))
													GameTooltip:Show()
												end
			)
			addon.Frame.ExpandAllButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
			addon.Frame.ExpandAllButton:Enable()

			-- Add collaspse all button
			addon.Frame.CollapseAllButton = CreateFrame("Button","addon.Frame.CollapseAllButton",addon.Frame,"UIPanelButtonTemplate")

			addon.Frame.CollapseAllButton:SetWidth(16)
			addon.Frame.CollapseAllButton:SetHeight(16)
			addon.Frame.CollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
			addon.Frame.CollapseAllButton:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
			addon.Frame.CollapseAllButton:SetHighlightTexture("Interface\\Buttons\\UI-MinusButton-Hilight")
			addon.Frame.CollapseAllButton:ClearAllPoints()
			addon.Frame.CollapseAllButton:SetPoint("TOPRIGHT",addon.Frame,"TOPRIGHT",-30,-20)
			addon.Frame.CollapseAllButton:SetScript("OnClick", function() self:CloseAll() end)
			addon.Frame.CollapseAllButton:SetScript("OnEnter", function(this)
														GameTooltip_SetDefaultAnchor(GameTooltip, this)
														GameTooltip:SetText(self:White(L["Collapse All"]))
														GameTooltip:Show()
													end
			)
			addon.Frame.CollapseAllButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
			addon.Frame.CollapseAllButton:Enable()

			-- Add a "close with x" button
			addon.Frame.XButton = CreateFrame("Button","addon.Frame.XButton",addon.Frame,"UIPanelCloseButton")

			addon.Frame.XButton:ClearAllPoints()
			addon.Frame.XButton:SetPoint("TOPRIGHT",addon.Frame,"TOPRIGHT",0,0)
			addon.Frame.XButton:RegisterForClicks("LeftButtonUp")
			addon.Frame.XButton:SetScript("OnClick", function() self:CloseWindow() end)
			addon.Frame.XButton:SetScript("OnEnter", function(this)
											GameTooltip_SetDefaultAnchor(GameTooltip, this)
											GameTooltip:SetText(self:White(L["Close Window"]))
											GameTooltip:Show()
										end
			)
			addon.Frame.XButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
			addon.Frame.XButton:Enable()

			-- Adds scroll frame to mainframe
			addon.Frame.ScrollFrame = CreateFrame("ScrollFrame", "addon.Frame.ScrollFrame", addon.Frame, "UIPanelScrollFrameTemplate")
	
			addon.Frame.ScrollFrame:ClearAllPoints()
			addon.Frame.ScrollFrame:SetPoint("TOPLEFT", addon.Frame, "TOPLEFT", 10, -50)
			addon.Frame.ScrollFrame:SetHeight(345)
			addon.Frame.ScrollFrame:SetWidth(344)
			addon.Frame.ScrollFrame:EnableMouseWheel(true)
			addon.Frame.ScrollFrame:EnableMouse(true)

			addon.Frame.ScrollChild = CreateFrame("Frame", "addon.Frame.ScrollChild", addon.Frame.ScrollFrame)

			addon.Frame.ScrollChild:ClearAllPoints()
			addon.Frame.ScrollChild:SetPoint("TOPLEFT", addon.Frame.ScrollFrame, "TOPLEFT", 10, -30)
			addon.Frame.ScrollChild:SetWidth(340)
			addon.Frame.ScrollChild:SetHeight(345)
			addon.Frame.ScrollChild:EnableMouseWheel(true)
			addon.Frame.ScrollChild:EnableMouse(true)

			addon.Frame.ScrollFrame:SetScrollChild(addon.Frame.ScrollChild)

			-- Add progress bar to frame
			addon.Frame.ProgressBar = CreateFrame("StatusBar", "addon.Frame.ProgressBar", addon.Frame)
		
			addon.Frame.ProgressBar:SetWidth(260)
			addon.Frame.ProgressBar:SetHeight(20)
			addon.Frame.ProgressBar:ClearAllPoints()
			addon.Frame.ProgressBar:SetPoint("BOTTOMLEFT", addon.Frame, 10, 10)
			addon.Frame.ProgressBar:SetStatusBarTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar")
			addon.Frame.ProgressBar:SetOrientation("HORIZONTAL")
			addon.Frame.ProgressBar:SetStatusBarColor(0.25, 0.25, 0.75)

			addon.Frame.ProgressBarBorder = CreateFrame("Button", "addon.Frame.ProgressBarBorder", addon.Frame.ProgressBar)

			-- Add border to status bar
			addon.Frame.ProgressBarBorder:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder")
			addon.Frame.ProgressBarBorder:SetWidth(270)
			addon.Frame.ProgressBarBorder:SetHeight(40)
			addon.Frame.ProgressBarBorder:ClearAllPoints()
			addon.Frame.ProgressBarBorder:SetPoint("CENTER", addon.Frame.ProgressBar, "CENTER", 0, 0)

			addon.Frame.ProgressBarText = addon.Frame.ProgressBar:CreateFontString("addon.Frame.ProgressBarText", "ARTWORK")

			-- Add text to header frame
			addon.Frame.ProgressBarText:SetFontObject(GameFontHighlightSmall)
			addon.Frame.ProgressBarText:ClearAllPoints()
			addon.Frame.ProgressBarText:SetPoint("CENTER", addon.Frame.ProgressBar, "CENTER", 0, 0)

			-- Adds Profession header text
			addon.Frame.ProfessionText = addon.Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			addon.Frame.ProfessionText:ClearAllPoints()
			addon.Frame.ProfessionText:SetPoint("TOP", 0, -30)

		end

		addon.Frame:ClearAllPoints()

		-- Anchor the frame to a specific window

		-- Anchors to Skillet window
		if (Skillet and Skillet:IsActive() and not CraftIsPetTraining()) then
			addon.Frame:SetPoint("LEFT", SkilletFrame, "RIGHT", 0, 0)
		-- Anchor to Beast window if skillet is active
		elseif (Skillet and Skillet:IsActive() and CraftIsPetTraining()) then
			addon.Frame:SetPoint("RIGHT", CraftFrame, "RIGHT", 345, 30)
		-- Anchor to ATSW
		elseif (ATSWFrame) then
			addon.Frame:SetPoint("RIGHT", ATSWFrame, "RIGHT", 350, 25)
		-- Move the window over a bit for trade tabs to be seen
		elseif (TradeTabs) then
			if (addon.SkillType == "Trade") then
				addon.Frame:SetPoint("RIGHT", TradeSkillFrame, "RIGHT", 385, 30)
			-- Anchor to crafting window
			elseif (addon.SkillType == "Craft") then
				addon.Frame:SetPoint("RIGHT", CraftFrame, "RIGHT", 385, 30)
			end
		-- Anchor to trade skill window
		elseif (addon.SkillType == "Trade") then
			addon.Frame:SetPoint("RIGHT", TradeSkillFrame, "RIGHT", 345, 30)
		-- Anchor to crafting window
		elseif (addon.SkillType == "Craft") then
			addon.Frame:SetPoint("RIGHT", CraftFrame, "RIGHT", 345, 30)
		-- Nothing found to anchor, just put it up in the middle
		else
			addon.Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end

		-- Set the text / status bar display  of the progress bar
		if (CurrentSpeciality == "") then
			addon.Frame.ProfessionText:SetText(self:Yellow(CurrentProfession))
		else
			addon.Frame.ProfessionText:SetText(self:Yellow(CurrentProfession .. " - " .. CurrentSpeciality))
		end

		addon.Frame:Show()

		-- Add frame elements
		AddRecipeInfo(CurrentProfession, CurrentProfessionLevel, SortedRecipeIndex, CurrentSpeciality)

		-- Include filtered recipes in overall count
		if (addon.db.profile.includefiltered) then
			addon.Frame.ProgressBar:SetMinMaxValues(0, addon.NumberOfRecipes)
			addon.Frame.ProgressBar:SetValue(addon.FoundRecipes)
			addon.Frame.ProgressBarText:SetText(addon.FoundRecipes .. " \\ " .. addon.NumberOfRecipes .. " - " .. math.floor(addon.FoundRecipes / addon.NumberOfRecipes * 100) .. "%")
		-- Do not include filtered recipes
		else
			addon.Frame.ProgressBar:SetMinMaxValues(0, addon.NumberOfRecipes - addon.FilteredRecipes)
			addon.Frame.ProgressBar:SetValue(addon.FoundRecipes)
			addon.Frame.ProgressBarText:SetText(addon.FoundRecipes .. " \\ " .. addon.NumberOfRecipes - addon.FilteredRecipes .. " - " .. math.floor(addon.FoundRecipes / (addon.NumberOfRecipes - addon.FilteredRecipes) * 100) .. "%")
		end

	else
		-- New dev GUI
		self:Print("Test purposes only.")
		if (not addon.Frame) then
			-- Create the main frame
			addon.Frame = CreateFrame("Frame", "addon.Frame", UIParent)
			--Allows ARL to be closed with the Escape key
			tinsert(UISpecialFrames, "addon.Frame")

			addon.Frame:SetWidth(293)
			addon.Frame:SetHeight(447)

			addon.bgTexture = addon.Frame:CreateTexture( "AckisRecipeList.bgTexture", "ARTWORK" )
			addon.bgTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\main]] )
			addon.bgTexture:SetAllPoints( addon.Frame )
			addon.bgTexture:SetTexCoord( 0, (293/512), 0, (447/512) )
			addon.Frame:SetFrameStrata( "BACKGROUND" )
			addon.Frame:SetHitRectInsets( 5, 5, 5, 5 )

			addon.Frame:EnableMouse(true)
			addon.Frame:EnableKeyboard(true)
			addon.Frame:SetMovable(true)
			addon.Frame:SetScript("OnMouseDown", function() addon.Frame:StartMoving() end)
			addon.Frame:SetScript("OnHide", function() self:CloseWindow() end)
			addon.Frame:SetScript("OnMouseUp", function() addon.Frame:StopMovingOrSizing() end)

			addon.Frame:ClearAllPoints()
			addon.Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
			addon.Frame:Show()
			addon.Frame._Expanded = false

			local ARL_SwitcherButton = CreateFrame( "Button", "ARL_SwitcherButton", addon.Frame, "UIPanelButtonTemplate" )
			ARL_SwitcherButton:SetWidth( 64 )
			ARL_SwitcherButton:SetHeight( 64 )
			ARL_SwitcherButton:SetPoint( "TOPLEFT", addon.Frame, "TOPLEFT", 1, -2 )
			addon.SetSwitcherTexture( addon.CurrentProf )
			ARL_SwitcherButton:SetScript( "OnClick", addon.SwitchProfs )

			local ARL_CloseXButton = CreateFrame( "Button", "ARL_CloseXButton", addon.Frame, "UIPanelCloseButton" )
				ARL_CloseXButton:SetFrameLevel( 5 )
				ARL_CloseXButton:SetScript( "OnClick",
					function(this)
						this:GetParent():Hide()
					end
				)
				ARL_CloseXButton:SetPoint( "TOPRIGHT", addon.Frame, "TOPRIGHT", 5, -6 )

			local ARL_FilterButton = addon:GenericCreateButton( "ARL_FilterButton", addon.Frame,
				25, 90, "TOPRIGHT", addon.Frame, "TOPRIGHT", -8, -40, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["FILTER_OPEN"], "CENTER", L["FILTER_OPEN_TT"], 1 )
				ARL_FilterButton:SetScript( "OnClick", addon.ToggleFilters )
--[[
			local ARL_ResetButton = addon:GenericCreateButton( "ARL_ResetButton", addon.Frame,
				25, 90, "TOPRIGHT", ARL_FilterButton, "BOTTOMRIGHT", 0, -2, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Reset"], "CENTER", L["RESET_TT"], 1 )
			ARL_ResetButton:Hide()
--]]
			local ARL_SortButton = addon:GenericCreateButton( "ARL_SortButton", addon.Frame,
				25, 90, "TOPLEFT", addon.Frame, "TOPLEFT", 80, -40, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Sort"], "CENTER", L["SORT_TT"], 1 )

			local ARL_ExpandButton = addon:GenericCreateButton( "ARL_ExpandButton", addon.Frame,
				21, 40, "TOPRIGHT", ARL_SortButton, "BOTTOMLEFT", -26, -6, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["ExpandAll"], "CENTER", L["EXPAND_TT"], 1 )
--			ARL_ExpandButton:SetFont( [[Fonts\ARIALN.TTF]], 11 )

			local ARL_SearchButton = addon:GenericCreateButton( "ARL_SearchButton", addon.Frame,
				25, 74, "TOPLEFT", ARL_SortButton, "BOTTOMRIGHT", 41, -2, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Search"], "CENTER", L["SEARCH_TT"], 1 )

			local ARL_ClearButton = addon:GenericCreateButton( "ARL_ClearButton", addon.Frame,
				28, 28, "RIGHT", ARL_SearchButton, "LEFT", 3, -1, "GameFontNormalSmall",
				"GameFontHighlightSmall", "", "CENTER", L["CLEAR_TT"], 3 )

			local ARL_CloseButton = addon:GenericCreateButton( "ARL_CloseButton", addon.Frame,
				22, 69, "BOTTOMRIGHT", addon.Frame, "BOTTOMRIGHT", -4, 3, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Close"], "CENTER", L["Close Window"], 1 )
				ARL_CloseButton:SetScript( "OnClick",
					function(this)
						this:GetParent():Hide()
					end
				)
--[[
			local ARL_ApplyButton = addon:GenericCreateButton( "ARL_ApplyButton", addon.Frame,
				22, 69, "RIGHT", ARL_CloseButton, "LEFT", -80, 0, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Apply"], "CENTER", L["Apply_TT"], 1 )
			ARL_ApplyButton:Hide()
]]--
			local ARL_PlusList = {}
			local ARL_RecipeList = {}
			for i = 1, addon.maxVisibleRecipes do
				local Temp_Plus = addon:GenericCreateButton( "ARL_PlusList" .. i, addon.Frame,
					16, 16, "TOPLEFT", addon.Frame, "TOPLEFT", 20, -98, "GameFontNormalSmall",
					"GameFontHighlightSmall", "", "LEFT", "testTT", 2 )
				local Temp_Recipe = addon:GenericCreateButton( "ARL_RecipeList" .. i, addon.Frame,
					17, 224, "TOPLEFT", addon.Frame, "TOPLEFT", 37, -97, "GameFontNormalSmall",
					"GameFontHighlightSmall", "Blort", "LEFT", "blortTT", 1 )
				if not ( i == 1 ) then
					Temp_Plus:SetPoint( "TOPLEFT", ARL_PlusList[i-1], "BOTTOMLEFT", 0, -1 )
					Temp_Recipe:SetPoint( "TOPLEFT", ARL_RecipeList[i-1], "BOTTOMLEFT", 0, 0 )
				end
				Temp_Plus:SetScript( "OnClick", function ()
					addon.PlusItem_OnClick( i )
				end )
				Temp_Recipe:SetScript( "OnClick", function ()
					addon.RecipeItem_OnClick( i )
				end )
				ARL_PlusList[i] = Temp_Plus
				ARL_RecipeList[i] = Temp_Recipe
			end

			local ARL_RecipeScrollFrame = CreateFrame( "ScrollFrame", "ARL_RecipeScrollFrame",
				addon.Frame, "FauxScrollFrameTemplate" )
			ARL_RecipeScrollFrame:SetHeight( 322 )
			ARL_RecipeScrollFrame:SetWidth( 243 )
			ARL_RecipeScrollFrame:SetPoint( "TOPLEFT", addon.Frame, "TOPLEFT", 20, -97 )
			ARL_RecipeScrollFrame:SetScript( "OnVerticalScroll", function()
				FauxScrollFrame_OnVerticalScroll( 17, addon.RecipeList_Update )
			end )

--[[	General:
			( ) Class Specific recipes
			( ) Craft Specialty recipes
			( ) All skill levels
			( ) Horde     ( ) Alliance
			( ) Known	  ( ) Unknown		]]--
--[[
			local ARL_FLTGenText = addon.Frame:CreateFontString( "ARL_FLTGenText", "OVERLAY", "GameFontHighlight" )
			ARL_FLTGenText:SetText( L["General"] )
			ARL_FLTGenText:SetPoint( "TOPLEFT", ARL_SearchButton, "BOTTOMRIGHT", 15, -5 )
			ARL_FLTGenText:SetHeight( 14 )
			ARL_FLTGenText:SetWidth( 150 )
			ARL_FLTGenText:SetJustifyH( "LEFT" )
			ARL_FLTGenText:Hide()

			local ARL_ClassCB = CreateFrame( "CheckButton", "ARL_ClassCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_ClassCB, ARL_FLTGenText, L["CLASS_TOGGLE"], 1, 1, 1 )
				ARL_ClassCBText:SetText( L["Class Specific recipes"] )
			local ARL_SpecialtyCB = CreateFrame( "CheckButton", "ARL_SpecialtyCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_SpecialtyCB, ARL_FLTGenText, L["SPECIALITY_TOGGLE"], 2, 2, 1 )
				ARL_SpecialtyCBText:SetText( L["Craft Specialty recipes"] )
			local ARL_LevelCB = CreateFrame( "CheckButton", "ARL_LevelCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_LevelCB, ARL_FLTGenText, L["SKILL_TOGGLE"], 3, 3, 1 )
				ARL_LevelCBText:SetText( L["All Skill Levels"] )
			local ARL_HordeCB = CreateFrame( "CheckButton", "ARL_HordeCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_HordeCB, ARL_FLTGenText, L["HORDE_TT"], 4, 4, 1 )
				ARL_HordeCBText:SetText( L["Horde"] )
			local ARL_AllianceCB = CreateFrame( "CheckButton", "ARL_AllianceCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_AllianceCB, ARL_FLTGenText, L["ALLIANCE_TT"], 5, 4, 2 )
				ARL_AllianceCBText:SetText( L["Alliance"] )
			local ARL_KnownCB = CreateFrame( "CheckButton", "ARL_KnownCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_KnownCB, ARL_FLTGenText, L["KNOWN_TT"], 6, 5, 1 )
				ARL_KnownCBText:SetText( L["Known"] )
			local ARL_UnknownCB = CreateFrame( "CheckButton", "ARL_UnknownCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_UnknownCB, ARL_FLTGenText, L["UNKNOWN_TT"], 7, 5, 2 )
				ARL_UnknownCBText:SetText( L["Unknown"] )
]]--
--[[		Obtain:
				( ) Instance  ( ) Raid
				( ) Quest     ( ) Seasonal
				( ) Trainer   ( ) Vendor
				( ) PVP		  ( ) Discovery
				( ) Reputation **					]]--
--[[
			local ARL_FLTObtText = addon.Frame:CreateFontString( "ARL_FLTObtText", "OVERLAY", "GameFontHighlight" )
			ARL_FLTObtText:SetText( L["Obtain"] )
			ARL_FLTObtText:SetPoint( "TOPLEFT", ARL_SearchButton, "BOTTOMRIGHT", 15, -113 )
			ARL_FLTObtText:SetHeight( 14 )
			ARL_FLTObtText:SetWidth( 150 )
			ARL_FLTObtText:SetJustifyH( "LEFT" )
			ARL_FLTObtText:Hide()

			local ARL_InstanceCB = CreateFrame( "CheckButton", "ARL_InstanceCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_InstanceCB, ARL_FLTObtText, L["INSTANCE_TOGGLE"], 8, 1, 1 )
				ARL_InstanceCBText:SetText( L["Instance"] )
			local ARL_RaidCB = CreateFrame( "CheckButton", "ARL_RaidCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_RaidCB, ARL_FLTObtText, L["RAID_TOGGLE"], 9, 1, 2 )
				ARL_RaidCBText:SetText( L["Raid"] )
			local ARL_QuestCB = CreateFrame( "CheckButton", "ARL_QuestCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_QuestCB, ARL_FLTObtText, L["QUEST_TOGGLE"], 10, 2, 1 )
				ARL_QuestCBText:SetText( L["Quest"] )
			local ARL_SeasonalCB = CreateFrame( "CheckButton", "ARL_SeasonalCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_SeasonalCB, ARL_FLTObtText, L["SEASONAL_TOGGLE"], 11, 2, 2 )
				ARL_SeasonalCBText:SetText( L["Seasonal"] )
			local ARL_TrainerCB = CreateFrame( "CheckButton", "ARL_TrainerCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_TrainerCB, ARL_FLTObtText, L["TRAINER_TOGGLE"], 12, 3, 1 )
				ARL_TrainerCBText:SetText( L["Trainer"] )
			local ARL_VendorCB = CreateFrame( "CheckButton", "ARL_VendorCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_VendorCB, ARL_FLTObtText, L["VENDOR_TOGGLE"], 13, 3, 2 )
				ARL_VendorCBText:SetText( L["Vendor"] )
			local ARL_PVPCB = CreateFrame( "CheckButton", "ARL_PVPCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_PVPCB, ARL_FLTObtText, L["PVP_TOGGLE"], 14, 4, 1 )
				ARL_PVPCBText:SetText( L["PVP"] )
			local ARL_DiscoveryCB = CreateFrame( "CheckButton", "ARL_DiscoveryCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_DiscoveryCB, ARL_FLTObtText, L["DISCOVERY_TT"], 15, 4, 2 )
				ARL_DiscoveryCBText:SetText( L["Discovery"] )
			local ARL_ReputationCB = CreateFrame( "CheckButton", "ARL_ReputationCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_ReputationCB, ARL_FLTObtText, L["REP_TT"], 16, 5, 1 )
				ARL_ReputationCBText:SetText( L["Reputation"] )

			local ARL_RepPlus = addon:GenericCreateButton( "ARL_RepPlus", addon.Frame,
				16, 16, "LEFT", ARL_ReputationCBText, "RIGHT", 1, -1, "GameFontNormalSmall",
				"GameFontHighlightSmall", "", "LEFT", "testTT", 2 )
			ARL_RepPlus:Hide()
]]--
--[[		Item Type:
				( ) Armor **  ( ) Weapon **
				( ) BoP								]]--
--[[
			local ARL_FLTITypeText = addon.Frame:CreateFontString( "ARL_FLTITypeText", "OVERLAY", "GameFontHighlight" )
			ARL_FLTITypeText:SetText( L["Item Type"] )
			ARL_FLTITypeText:SetPoint( "TOPLEFT", ARL_SearchButton, "BOTTOMRIGHT", 15, -220 )
			ARL_FLTITypeText:SetHeight( 14 )
			ARL_FLTITypeText:SetWidth( 150 )
			ARL_FLTITypeText:SetJustifyH( "LEFT" )
			ARL_FLTITypeText:Hide()

			local ARL_ArmorCB = CreateFrame( "CheckButton", "ARL_ArmorCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_ArmorCB, ARL_FLTITypeText, L["ARMOR_TT"], 17, 1, 1 )
				ARL_ArmorCBText:SetText( L["Armor"] )
				-- Disabled for now
				ARL_ArmorCBText:SetText( addon:Grey( L["Armor"] ) )
				ARL_ArmorCB:Disable()
			local ARL_WeaponCB = CreateFrame( "CheckButton", "ARL_WeaponCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_WeaponCB, ARL_FLTITypeText, L["WEAPON_TT"], 18, 1, 2 )
				ARL_WeaponCBText:SetText( L["Weapon"] )
				-- Disabled for now
				ARL_WeaponCBText:SetText( addon:Grey( L["Weapon"] ) )
				ARL_WeaponCB:Disable()
			local ARL_BOPCB = CreateFrame( "CheckButton", "ARL_BOPCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_BOPCB, ARL_FLTITypeText, L["BOP_TOGGLE"], 19, 2, 1 )
				ARL_BOPCBText:SetText( L["BoPMenu"] )

			local ARL_ArmorPlus = addon:GenericCreateButton( "ARL_ArmorPlus", addon.Frame,
				16, 16, "LEFT", ARL_ArmorCBText, "RIGHT", 1, -1, "GameFontNormalSmall",
				"GameFontHighlightSmall", "", "LEFT", "testTT", 2 )
				ARL_ArmorPlus:Disable()
				ARL_ArmorPlus:Hide()
			local ARL_WeaponPlus = addon:GenericCreateButton( "ARL_WeaponPlus", addon.Frame,
				16, 16, "LEFT", ARL_WeaponCBText, "RIGHT", 1, -1, "GameFontNormalSmall",
				"GameFontHighlightSmall", "", "LEFT", "testTT", 2 )
				ARL_WeaponPlus:Disable()
				ARL_WeaponPlus:Hide()
]]--
--[[		Player Type:
				( ) Tank	  ( ) Melee DPS
				( ) Healer	  ( ) Caster DPS		]]--
--[[
			local ARL_FLTPTypeText = addon.Frame:CreateFontString( "ARL_FLTPTypeText", "OVERLAY", "GameFontHighlight" )
			ARL_FLTPTypeText:SetText( L["Player Type"] )
			ARL_FLTPTypeText:SetPoint( "TOPLEFT", ARL_SearchButton, "BOTTOMRIGHT", 15, -273 )
			ARL_FLTPTypeText:SetHeight( 14 )
			ARL_FLTPTypeText:SetWidth( 150 )
			ARL_FLTPTypeText:SetJustifyH( "LEFT" )
			-- Since this function is disabled for now, throw this in:
			ARL_FLTPTypeText:SetText( addon:Grey( L["Player Type"] ) )
			ARL_FLTPTypeText:Hide()

			local ARL_TankCB = CreateFrame( "CheckButton", "ARL_TankCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_TankCB, ARL_FLTPTypeText, L["TANKING_TOGGLE"], 20, 1, 1 )
				ARL_TankCBText:SetText( L["Tank"] )
				-- Disabled for now...
				ARL_TankCBText:SetText( addon:Grey( L["Tank"] ) )
				ARL_TankCB:Disable()
			local ARL_MeleeCB = CreateFrame( "CheckButton", "ARL_MeleeCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_MeleeCB, ARL_FLTPTypeText, L["MELEE_TOGGLE"], 21, 1, 2 )
				ARL_MeleeCBText:SetText( L["Melee DPS"] )
				-- Disabled for now...
				ARL_MeleeCBText:SetText( addon:Grey( L["Melee DPS"] ) )
				ARL_MeleeCB:Disable()
			local ARL_HealerCB = CreateFrame( "CheckButton", "ARL_HealerCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_HealerCB, ARL_FLTPTypeText, L["HEALING_TOGGLE"], 22, 2, 1 )
				ARL_HealerCBText:SetText( L["Healer"] )
				-- Disabled for now...
				ARL_HealerCBText:SetText( addon:Grey( L["Healer"] ) )
				ARL_HealerCB:Disable()
			local ARL_CasterCB = CreateFrame( "CheckButton", "ARL_CasterCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_CasterCB, ARL_FLTPTypeText, L["CASTERDPS_TOGGLE"], 23, 2, 2 )
				ARL_CasterCBText:SetText( L["Caster DPS"] )
				-- Disabled for now...
				ARL_CasterCBText:SetText( addon:Grey( L["Caster DPS"] ) )
				ARL_CasterCB:Disable()
]]--
		end
	end
end