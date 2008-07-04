--[[
****************************************************************************************

ARLFrame.lua

Frame functions for all of AckisRecipeList

$Date: 2008-07-03 14:37:48 -0400 (Thu, 03 Jul 2008) $
$Rev: 77747 $

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
			RecipeText = string.match(this:GetText(), "|c.*%[.*%]|r %- (.*)")
		elseif (sorttype == "Name") then
			RecipeText = string.match(this:GetText(), "(.*) %- |c.*%[.*%]|r")
		end

		-- Changed the graphic of the + to a -
		this:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
		this:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
		this:SetHighlightTexture("Interface\\Buttons\\UI-MinusButton-Hilight")

		-- Keep track of button state
		this.IsPushed = true

		-- Show expanded text
		if (addon.MissingRecipeListing[RecipeText] == nil) then
			this.RecipeAquireText:SetText(L["Unknown"])
		else
			this.RecipeAquireText:SetText("    - " .. addon.MissingRecipeListing[RecipeText]["Acquire"])
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
				RecipeFrame:SetTextColor(1, 1, 1)
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
				RecipeFrame.RecipeAquireText:SetTextColor(1, 1, 1)
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
				--RecipeFrame:SetPoint("TOPLEFT", addon.Frame.ScrollChild, "TOPLEFT", 5, -30)
				RecipeFrame:SetPoint("TOPLEFT",addon.Frame.ScrollChild,"TOPLEFT",5,0)
			else
				RecipeFrame:SetPoint("TOPLEFT", "AckisRecipeListRecipe" .. (RecipeCount - 1), "BOTTOMLEFT", 0, -1)
			end

			local temprecipetext

			local sorttype = addon.db.profile.sorting

			if (sorttype == "Skill") or (sorttype == "Aquisition") then
				if (addon.MissingRecipeListing[RecipeName]["Level"] > CurrentProfessionLevel) then
					temprecipetext = addon:Red("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]") .. " - " .. RecipeName
				else
					temprecipetext = addon:White("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]") .. " - " .. RecipeName
				end
			elseif (sorttype == "Name") then
				if (addon.MissingRecipeListing[RecipeName]["Level"] > CurrentProfessionLevel) then
					temprecipetext = RecipeName .. " - " .. addon:Red("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]")
				else
					temprecipetext = RecipeName .. " - " .. addon:White("[" .. addon.MissingRecipeListing[RecipeName]["Level"] .. "]")
				end
			end

			RecipeFrame:SetText(temprecipetext)
			RecipeFrame:SetScript("OnEnter", function(this)
					GameTooltip_SetDefaultAnchor(GameTooltip, this)
					if (addon.RecipeListing[RecipeName]["RecipeLink"] ~= nil) then
						GameTooltip:SetHyperlink(addon.RecipeListing[RecipeName]["RecipeLink"])
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
		addon.ScanButton:SetTextColor(1, 0.8, 0)
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
		addon.ScanButton:SetTextColor(1, 1, 0)
		addon.ScanButton:SetWidth(addon.ScanButton:GetTextWidth() + 10)
	-- Add to ATSW
	elseif (ATSWFrame and not CraftIsPetTraining()) then
		addon.ScanButton:SetParent(ATSWFrame)
		addon.ScanButton:ClearAllPoints()
		addon.ScanButton:SetPoint("RIGHT", ATSWOptionsButton, "LEFT", 0, 0)
		addon.ScanButton:SetTextColor(ATSWOptionsButton:GetTextColor())
		addon.ScanButton:SetHeight(ATSWOptionsButton:GetHeight())
		addon.ScanButton:SetWidth(80)
	elseif (addon.SkillType == "Trade") then
	-- Anchor to trade window
		addon.ScanButton:SetParent(TradeSkillFrame)
		addon.ScanButton:ClearAllPoints()
		addon.ScanButton:SetPoint("RIGHT",TradeSkillFrameCloseButton,"LEFT",10,0)
		addon.ScanButton:SetTextColor(1, 1, 0)
		addon.ScanButton:SetWidth(addon.ScanButton:GetTextWidth() + 10)
	-- Anchor to crafting window
	elseif (addon.SkillType == "Craft") then
		addon.ScanButton:SetParent(CraftFrame)
		addon.ScanButton:ClearAllPoints()
		addon.ScanButton:SetPoint("RIGHT",CraftFrameCloseButton,"LEFT",10,0)
		addon.ScanButton:SetTextColor(1, 1, 0)
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
		addon.Frame:SetWidth(309)
		addon.Frame:SetHeight(447)
		addon.bgTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\main]] )
		addon.bgTexture:SetAllPoints( addon.Frame )
		addon.bgTexture:SetTexCoord( 0, (309/512), 0, (447/512) )
		addon.Frame._Expanded = false
		addon.Frame:SetPoint( "BOTTOMLEFT", UIParent, "BOTTOMLEFT", xPos, yPos )
		-- Change the text and tooltip for the filter button
		ARL_FilterButton:SetText( L["FILTER_OPEN"] )
		addon:TooltipDisplay( ARL_FilterButton, L["FILTER_OPEN_TT"] )
		-- Hide the Filter CBs
		ARL_VendorCB:Hide()
		ARL_TrainerCB:Hide()
		ARL_WorldCB:Hide()
		ARL_MobCB:Hide()
		ARL_QuestCB:Hide()
		ARL_SeasonCB:Hide()
		ARL_RepCB:Hide()
		ARL_InstanceCB:Hide()
		ARL_BoPCB:Hide()
		ARL_HordeCB:Hide()
		ARL_AllianceCB:Hide()
		ARL_KnownCB:Hide()
		ARL_UnknownCB:Hide()
		-- and finally, show our frame
		addon.Frame:Show()
	else
		-- Adjust the frame size and texture
		addon.Frame:Hide()
		addon.Frame:ClearAllPoints()
		addon.Frame:SetWidth(480)
		addon.Frame:SetHeight(447)
		addon.bgTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\expanded]] )
		addon.bgTexture:SetAllPoints( addon.Frame )
		addon.bgTexture:SetTexCoord( 0, (480/512), 0, (447/512) )
		addon.Frame._Expanded = true
		addon.Frame:SetPoint( "BOTTOMLEFT", UIParent, "BOTTOMLEFT", xPos, yPos )
		-- Change the text and tooltip for the filter button
		ARL_FilterButton:SetText( L["FILTER_CLOSE"] )
		addon:TooltipDisplay( ARL_FilterButton, L["FILTER_CLOSE_TT"] )
		-- Show the Filter CBs
		ARL_VendorCB:Show()
		ARL_TrainerCB:Show()
		ARL_WorldCB:Show()
		ARL_MobCB:Show()
		ARL_QuestCB:Show()
		ARL_SeasonCB:Show()
		ARL_RepCB:Show()
		ARL_InstanceCB:Show()
		ARL_BoPCB:Show()
		ARL_HordeCB:Show()
		ARL_AllianceCB:Show()
		ARL_KnownCB:Show()
		ARL_UnknownCB:Show()
		-- and finally, show our frame
		addon.Frame:Show()
	end
end

function addon:GenericMakeCB( cButton, anchorFrame, ttText, scriptVal, sep )
	cButton:SetHeight( 24 )
	cButton:SetWidth( 24 )
	if ( sep == 1 ) then
		cButton:SetPoint( "TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -8 )
	else
		cButton:SetPoint( "TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, 4 )
	end
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

	if not ( noTextures == 1 ) then
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
		addon.Frame.Header.Texture:SetWidth(384)
		addon.Frame.Header.Texture:SetHeight(64)
		addon.Frame.Header.Texture:ClearAllPoints()
		addon.Frame.Header.Texture:SetPoint("TOP", addon.Frame.Header, "TOP", 0, 5)

		-- Add text to header frame
		addon.Frame.Header.Text = addon.Frame.Header:CreateFontString("addon.Frame.Header.Text", "ARTWORK")

		addon.Frame.Header.Text:SetFontObject(GameFontNormal)
		addon.Frame.Header.Text:ClearAllPoints()
		addon.Frame.Header.Text:SetPoint("CENTER", addon.Frame.Header, "CENTER", 0, 0)
		addon.Frame.Header.Text:SetText(addon.ARLTitle)

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
												GameTooltip:SetText(L["Close Window"])
												GameTooltip:Show()
											end
										)
		addon.Frame.CloseButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
		addon.Frame.CloseButton:SetFont("GameFontHighlightSmall",12)
		addon.Frame.CloseButton:SetTextColor(1, 1, 1)
		addon.Frame.CloseButton:SetText(L["Close"])
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
		addon.Frame.ExpandAllButton:SetTextColor(1, 1, 1)
		addon.Frame.ExpandAllButton:SetScript("OnClick", function() self:ExpandAll() end)
		addon.Frame.ExpandAllButton:SetScript("OnEnter", function(this)
												GameTooltip_SetDefaultAnchor(GameTooltip, this)
												GameTooltip:SetText(L["Expand All"])
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
		addon.Frame.CollapseAllButton:SetTextColor(1, 1, 1)
		addon.Frame.CollapseAllButton:SetScript("OnClick", function() self:CloseAll() end)
		addon.Frame.CollapseAllButton:SetScript("OnEnter", function(this)
												GameTooltip_SetDefaultAnchor(GameTooltip, this)
												GameTooltip:SetText(L["Collapse All"])
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
												GameTooltip:SetText(L["Close Window"])
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
		addon.Frame.ScrollChild:SetHeight(355)
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
		addon.Frame.ProfessionText:SetTextColor(1.0, 1.0, 0.1)
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
		addon.Frame.ProfessionText:SetText(CurrentProfession)
	else
		addon.Frame.ProfessionText:SetText(CurrentProfession .. " - " .. CurrentSpeciality)
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

	-- New dev GUI
	else
		self:Print("Test purposes only")
		if (not addon.Frame) then
			-- Create the main frame
			addon.Frame = CreateFrame("Frame", "addon.Frame", UIParent)
			--Allows ARL to be closed with the Escape key
			tinsert(UISpecialFrames, "addon.Frame")

			addon.Frame:SetWidth(309)
			addon.Frame:SetHeight(447)
--[[			addon.Frame:SetBackdrop(
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
			}) ]]--

			addon.bgTexture = addon.Frame:CreateTexture( "AckisRecipeList.bgTexture", "ARTWORK" )
			addon.bgTexture:SetTexture( [[Interface\Addons\AckisRecipeList\img\main]] )
			addon.bgTexture:SetAllPoints( addon.Frame )
			addon.bgTexture:SetTexCoord( 0, (309/512), 0, (447/512) )
			addon.Frame:SetFrameStrata( "BACKGROUND" )
			addon.Frame:SetHitRectInsets( 5, 5, 5, 5 )

--			addon.Frame:SetBackdropColor(0, 0, 0)
			addon.Frame:EnableMouse(true)
			addon.Frame:EnableKeyboard(true)
			addon.Frame:SetMovable(true)
			addon.Frame:SetScript("OnMouseDown", function() addon.Frame:StartMoving() end)
			addon.Frame:SetScript("OnHide", function() self:CloseWindow()	end)
			addon.Frame:SetScript("OnMouseUp", function()	addon.Frame:StopMovingOrSizing() end)

			addon.Frame:ClearAllPoints()
			addon.Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
			addon.Frame:Show()
			addon.Frame._Expanded = false

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
				"GameFontHighlightSmall", L["FILTER_OPEN"], "CENTER", L["FILTER_OPEN_TT"] )
				ARL_FilterButton:SetScript( "OnClick", addon.ToggleFilters )

			local ARL_SortButton = addon:GenericCreateButton( "ARL_SortButton", addon.Frame,
				25, 90, "TOPLEFT", addon.Frame, "TOPLEFT", 80, -40, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Sort"], "CENTER", L["SORT_TT"] )

			local ARL_ResetButton = addon:GenericCreateButton( "ARL_ResetButton", addon.Frame,
				25, 90, "TOPLEFT", ARL_SortButton, "BOTTOMRIGHT", 41, -4, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Reset"], "CENTER", L["RESET_TT"] )

			local ARL_CloseButton = addon:GenericCreateButton( "ARL_CloseButton", addon.Frame,
				22, 85, "BOTTOMRIGHT", addon.Frame, "BOTTOMRIGHT", -4, 3, "GameFontNormalSmall",
				"GameFontHighlightSmall", L["Close"], "CENTER", L["Close Window"] )
				ARL_CloseButton:SetScript( "OnClick",
					function(this)
						this:GetParent():Hide()
					end
				)
			-- Filter checkboxes...
			local ARL_VendorCB = CreateFrame( "CheckButton", "ARL_VendorCB", addon.Frame, "UICheckButtonTemplate" )
			ARL_VendorCB:SetHeight( 24 )
			ARL_VendorCB:SetWidth( 24 )
			ARL_VendorCB:SetPoint( "TOPLEFT", ARL_ResetButton, "BOTTOMRIGHT", 20, -10 )
			ARL_VendorCBText:SetText( L["Vendor"] )
			addon:TooltipDisplay( ARL_VendorCB, L["VENDOR_TT"], 1 )
			ARL_VendorCB:SetScript( "OnClick", function () addon.filterSwitch( 1 ) end )
			ARL_VendorCB:Hide()

			local ARL_TrainerCB = CreateFrame( "CheckButton", "ARL_TrainerCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_TrainerCB, ARL_VendorCB, L["TRAINER_TT"], 2, 0 )
				ARL_TrainerCBText:SetText( L["Trainer"] )
			local ARL_WorldCB = CreateFrame( "CheckButton", "ARL_WorldCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_WorldCB, ARL_TrainerCB, L["WORLD_TT"], 3, 0 )
				ARL_WorldCBText:SetText( L["World Drop"] )
			local ARL_MobCB = CreateFrame( "CheckButton", "ARL_MobCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_MobCB, ARL_WorldCB, L["MOB_TT"], 4, 0 )
				ARL_MobCBText:SetText( L["Mob Drop"] )
			local ARL_QuestCB = CreateFrame( "CheckButton", "ARL_QuestCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_QuestCB, ARL_MobCB, L["QUEST_TT"], 5, 0 )
				ARL_QuestCBText:SetText( L["Quest"] )
			local ARL_SeasonCB = CreateFrame( "CheckButton", "ARL_SeasonCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_SeasonCB, ARL_QuestCB, L["SEASON_TT"], 6, 0 )
				ARL_SeasonCBText:SetText( L["Seasonal"] )
			local ARL_RepCB = CreateFrame( "CheckButton", "ARL_RepCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_RepCB, ARL_SeasonCB, L["REP_TT"], 7, 0 )
				ARL_RepCBText:SetText( L["Reputation"] )
			local ARL_InstanceCB = CreateFrame( "CheckButton", "ARL_InstanceCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_InstanceCB, ARL_RepCB, L["INSTANCE_TT"], 8, 0 )
				ARL_InstanceCBText:SetText( L["Instance"] )

			local ARL_BoPCB = CreateFrame( "CheckButton", "ARL_BoPCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_BoPCB, ARL_InstanceCB, L["BOP_TT"], 9, 1 )
				ARL_BoPCBText:SetText( L["BoPMenu"] )

			local ARL_HordeCB = CreateFrame( "CheckButton", "ARL_HordeCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_HordeCB, ARL_BoPCB, L["HORDE_TT"], 10, 1 )
				ARL_HordeCBText:SetText( L["Horde"] )
			local ARL_AllianceCB = CreateFrame( "CheckButton", "ARL_AllianceCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_AllianceCB, ARL_HordeCB, L["ALLIANCE_TT"], 11, 0 )
				ARL_AllianceCBText:SetText( L["Alliance"] )

			local ARL_KnownCB = CreateFrame( "CheckButton", "ARL_KnownCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_KnownCB, ARL_AllianceCB, L["KNOWN_TT"], 12, 1 )
				ARL_KnownCBText:SetText( L["Known"] )
			local ARL_UnknownCB = CreateFrame( "CheckButton", "ARL_UnknownCB", addon.Frame, "UICheckButtonTemplate" )
				addon:GenericMakeCB( ARL_UnknownCB, ARL_KnownCB, L["UNKNOWN_TT"], 13, 0 )
				ARL_UnknownCBText:SetText( L["Unknown"] )
		end
	end
end