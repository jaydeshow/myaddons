
--[[-------------------------------------------------------------------------------
Hadar's Focus Frame (v1.04a for 20100) by Author: Hadar <Sunder> - Khaz Modan 
*	Creates a movable frame that will show the Health, mana
	and casting bars of the Focus unit and the target of the
	focus unit.
Usage:
*	Use "/FF" to SHOW/HIDE the window. (Use the X button to close the window, too)
*	Use "/FF LOCK" to LOCK/UNLOCK the window.
*	LEFT CLICK and drag the window handle to MOVE the window.
*	RIGHT CLICK the window handle to SET your current target as your focus target.  
*	RIGHT CLICK the window handle to with no target to CLEAR your focus target.  	
]]---------------------------------------------------------------------------------

--Backgrounds
local tooltipBackdrop = { bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
				tile = true, tileSize = 16, edgeSize = 16, 
				insets = { left = 5, right = 5, top = 5, bottom = 5 }}; 
				
local titleColor = {
		normal = {r=1.0,g=1.0,b=1.0,a=0.15},
		highlight = {r=0.5,g=1.0,b=0.8,a=0.45}
		};

--Status bar width
local sbWidth = 75;

--BarFrame Height
bfWidth = 75;
bfHeight = 33;

--Main frame Width and Height
local frameWidth = 176;
local frameHeight = 43;

-- Prints a message to the default chat window
local function focusPrint(msg)
    DEFAULT_CHAT_FRAME:AddMessage(tostring(msg));
end

--Create Main Frame
local focusMain = CreateFrame("Frame", "FocusMainFrame", UIParent);
focusMain:SetWidth(frameWidth);
focusMain:SetHeight(frameHeight);
focusMain:SetPoint("CENTER", "UIParent");
focusMain:SetMovable(true);
focusMain:EnableMouse(true);
focusMain:SetClampedToScreen(true);
focusMain:SetBackdrop(tooltipBackdrop);
focusMain:SetBackdropColor(0, 0, 0, 0.75);
focusMain:SetBackdropBorderColor(1, 1, 1, 0.55);

focusMain.sepBar = focusMain:CreateTexture(nil, "OVERLAY");
focusMain.sepBar:SetTexture(1.0, 1.0, 1.0, 0.3);
focusMain.sepBar:SetWidth(1);
focusMain.sepBar:SetHeight(34);
focusMain.sepBar:SetPoint("CENTER", focusMain, "CENTER", -7, 0);

--Add a title button to the main frame
local titleButton = CreateFrame("Button", nil, focusMain, "SecureActionButtonTemplate");
titleButton:SetWidth(13);
titleButton:SetHeight(34);
titleButton:SetPoint("RIGHT", focusMain, "RIGHT", -4, 0);

titleButton:RegisterForClicks("LeftButtonUp", "RightButtonUp", "LeftButtonDown", "RightButtonDown");
titleButton:SetAttribute("type2", "focus");

titleButton.texture = titleButton:CreateTexture(nil, "OVERLAY");
titleButton.texture:SetAllPoints(titleButton);
titleButton.texture:SetTexture(titleColor.normal.r, titleColor.normal.g, titleColor.normal.b, titleColor.normal.a);

--Add Text to the title
titleButton.title = titleButton:CreateFontString(nil, "OVERLAY");
titleButton.title:SetFontObject("GameFontNormalSmall");
titleButton.title:SetJustifyH("CENTER");
titleButton.title:SetPoint("CENTER", -3, 0);
titleButton.title:SetText("F");
titleButton.title:SetTextColor(1.0, 1.0, 1.0);

titleButton.title2 = titleButton:CreateFontString(nil, "OVERLAY");
titleButton.title2:SetFontObject("GameFontNormalSmall");
titleButton.title2:SetJustifyH("CENTER");
titleButton.title2:SetPoint("CENTER",titleButton.title,"CENTER", 4, -3);
titleButton.title2:SetText("F");
titleButton.title2:SetTextColor(0.8, 0.8, 0.3);

--Make the title button change color on mouse Enter and Leave
titleButton:SetScript("OnEnter", function(self, motion)
	titleButton.texture:SetTexture(titleColor.highlight.r, titleColor.highlight.g, titleColor.highlight.b, titleColor.highlight.a);
end );

titleButton:SetScript("OnLeave", function(self, motion)
	titleButton.texture:SetTexture(titleColor.normal.r, titleColor.normal.g, titleColor.normal.b, titleColor.normal.a);
end );

--Make the title button move the main frame with a left mouse click and drag
titleButton:SetScript("OnMouseDown", function(self, button)
	if ( button == "LeftButton" and self:GetParent():IsMovable() ) then
		self:GetParent():StartMoving();
	end	
end );

titleButton:SetScript("OnMouseUp", function(self, button)
	if ( button == "LeftButton" and self:GetParent():IsMovable() ) then
		self:GetParent():StopMovingOrSizing();
	end
end );

--Add a close button to the title button.  Closes the main frame
local closeButton = CreateFrame("Button", nil, titleButton, "UIPanelCloseButton");
closeButton:SetWidth(18);
closeButton:SetHeight(18);
closeButton:SetPoint("TOPRIGHT", titleButton, "TOPRIGHT", 2, 3);
closeButton:SetScript("OnClick", function(self,button,down) HideUIPanel(self:GetParent():GetParent()); end);

--Helper Function to create status bars
local function createStatusBar(parent, width, height, name)
	local w = width or 100;
	local h = height or 10;

	local frame = CreateFrame("StatusBar", name, parent);
	frame:SetWidth(w);
	frame:SetHeight(h);
	frame:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar", "BORDER");
	frame:SetStatusBarColor(0.0, 1.0, 0.0, 0.7);
	frame.text = frame:CreateFontString(nil, "OVERLAY");
	frame.text:Show();
	frame.text:SetFontObject("GameFontNormalSmall");
	frame.text:SetWidth(frame:GetWidth());
	frame.text:SetHeight(frame:GetHeight());
	frame.text:ClearAllPoints();
	frame.text:SetPoint("CENTER", frame, "CENTER", 0, 1);
	frame.text:SetJustifyH("CENTER");
	frame.text:SetTextColor(1.0, 1.0, 1.0);
	frame:Show();

	return frame;
end

--Helper function to create a frame that holds 3 status bars
local function createFocusBarsFrame(parent, width, height, name, unit)
	local focusFrame = CreateFrame("Button", name, parent, "SecureUnitButtonTemplate");
	focusFrame:SetWidth(width);
	focusFrame:SetHeight(height);
	focusFrame:SetAttribute("unit", unit);
	focusFrame:SetAttribute("type1", "target");

	focusFrame.raidIcon = focusFrame:CreateTexture();	
	focusFrame.raidIcon:SetWidth(10);
	focusFrame.raidIcon:SetHeight(10);
	focusFrame.raidIcon:SetPoint("TOPRIGHT", focusFrame, "TOPRIGHT", 0 ,0);
	focusFrame.raidIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetIcons");

	focusFrame.texture = focusFrame:CreateTexture(nil, "OVERLAY");
	focusFrame.texture:SetTexture(0.0, 1.0, 0.0, 0.5);
	focusFrame.texture:SetPoint("TOP");
	focusFrame.texture:SetWidth(width);
	focusFrame.texture:SetHeight(10);

	focusFrame.name = focusFrame:CreateFontString(nil, "OVERLAY");
	focusFrame.name:SetFontObject("GameFontNormalSmall");
	focusFrame.name:SetWidth(width);
	focusFrame.name:SetHeight(10);
	focusFrame.name:SetJustifyH("CENTER");
	focusFrame.name:SetPoint("TOP", focusFrame, "TOP", 0,0);
	focusFrame.name:SetTextColor(1.0, 1.0, 1.0);
		
	focusFrame.bar = {};
	focusFrame.bar[1] = createStatusBar(focusFrame, width, 10);
	focusFrame.bar[2] = createStatusBar(focusFrame, width, 5);
	focusFrame.bar[3] = createStatusBar(focusFrame, width, 5);
	
	--Anchor and set the position of each status bar
	local currentAnchor = focusFrame;
	for x = 1, 3, 1 do
		if (x == 1) then
			focusFrame.bar[x]:SetPoint("TOPLEFT", currentAnchor, "TOPLEFT", 0, -11);
		else
			focusFrame.bar[x]:SetPoint("TOPLEFT", currentAnchor, "BOTTOMLEFT", 0, 0);
		end
		currentAnchor = focusFrame.bar[x];
	end
	
	focusFrame.unit = unit;
	focusFrame.name:Show();
	return focusFrame;
end

--Create 2 sets of status bars
focusMain.barFrames = {};
focusMain.barFrames[1] = createFocusBarsFrame(focusMain, bfWidth, bfHeight, "theFocus", "focus");
focusMain.barFrames[2] = createFocusBarsFrame(focusMain, bfWidth, bfHeight, "theToFocus", "focustarget");

--Set their position
focusMain.barFrames[1]:SetPoint("TOPLEFT", focusMain, "TOPLEFT", 5, -5);
focusMain.barFrames[2]:SetPoint("TOPLEFT", focusMain.barFrames[1], "TOPRIGHT", 2.5, 0);

--Register Focus frames for click casting (ex: Clique Addon)
ClickCastFrames = ClickCastFrames or {};
ClickCastFrames[focusMain.barFrames[1]] = true;
ClickCastFrames[focusMain.barFrames[2]] = true;

--Show the main frame
focusMain:Show();

---------------------------------
--End UI Creation Section--------
---------------------------------

local function focusFrame_GetUnitColor(unit)
	local red = 0.0;
	local green = 0.0; 
	local blue = 0.0;
		
	if ( UnitPlayerControlled(unit) ) then
		if ( UnitCanAttack(unit, "player") ) then
			-- Hostile players are red
			if ( not UnitCanAttack("player", unit) ) then
				red = 0.0;
				green = 0.0;
				blue = 1.0;
			else
				red = UnitReactionColor[2].r;
				green = UnitReactionColor[2].g;
				blue = UnitReactionColor[2].b;
			end
		elseif ( UnitCanAttack("player", unit) ) then
			-- Players we can attack but which are not hostile are yellow
			red = UnitReactionColor[4].r;
			green = UnitReactionColor[4].g;
			blue = UnitReactionColor[4].b;
		elseif ( UnitIsPVP(unit) and not UnitIsPVPSanctuary(unit) and not UnitIsPVPSanctuary("player") ) then
			-- Players we can assist but are PvP flagged are green
			red = UnitReactionColor[6].r;
			green = UnitReactionColor[6].g;
			blue = UnitReactionColor[6].b;
		else
			-- All other players are blue (the usual state on the "blue" server)
			red = 0.0;
			green = 0.0;
			blue = 1.0;
		end
	elseif ( UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) ) then
		red = 0.5;
		green = 0.5;
		blue = 0.5;
	else
		local reaction = UnitReaction(unit, "player");
		if ( reaction ) then
			red = UnitReactionColor[reaction].r;
			green = UnitReactionColor[reaction].g;
			blue = UnitReactionColor[reaction].b;
		else
			red = 0.0;
			green = 0.0;
			blue = 0.0;
		end
	end

	return red, green, blue;
end

--Update the status bars in the Focus frame
local function focusBarsFrameUpdate(barsFrame)
	local health, max, percentage, unit;
	unit = barsFrame.unit;	
	health = UnitHealth(unit);
	max = UnitHealthMax(unit);
	
	if (max <= 0) then
		percentage = 0;
		barsFrame.bar[1].text:SetText("");
	else
		percentage = ceil( (health / max) * 100 );
		barsFrame.bar[1].text:SetText(percentage.."%");
	end
	
	if ( UnitExists(unit) ) then
		local red;
		local green;
		local blue;
		red, green, blue = focusFrame_GetUnitColor(unit);
		barsFrame.texture:SetTexture(red, green, blue, 0.3);

		local index = GetRaidTargetIndex(unit);
		if (index) then
			SetRaidTargetIconTexture(barsFrame.raidIcon, index);
			barsFrame.raidIcon:Show();
		else
			barsFrame.raidIcon:Hide();	
		end
	else
		barsFrame.texture:SetTexture(0, 0, 0, 0);
		barsFrame.raidIcon:Hide();
	end
	
	barsFrame.name:SetText(UnitName(unit));
	barsFrame.bar[1]:SetMinMaxValues(0, UnitHealthMax(unit));
	barsFrame.bar[1]:SetValue(UnitHealth(unit));
	barsFrame.bar[2]:SetMinMaxValues(0, UnitManaMax(unit));
	barsFrame.bar[2]:SetValue(UnitMana(unit));
	
	if (UnitPowerType(unit) == 3) then
		barsFrame.bar[2]:SetStatusBarColor(1.0, 1.0, 0.0);	--Energy for Rogues
	elseif (UnitPowerType(unit) == 1) then
		barsFrame.bar[2]:SetStatusBarColor(1.0, 0.0, 0.0);	--Rage for Warriors
	else
		barsFrame.bar[2]:SetStatusBarColor(0.0, 0.0, 1.0);	--Else Mana
	end
	
	if (UnitCastingInfo(unit)) then
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unit);
		barsFrame.bar[3]:Show();
		barsFrame.bar[3]:SetMinMaxValues(startTime, endTime);
		barsFrame.bar[3]:SetValue(GetTime()*1000);
		barsFrame.bar[3].text:SetText(displayName);
		barsFrame.bar[3]:SetStatusBarColor(1.0, 0.7, 0.0);
	elseif (UnitChannelInfo(unit)) then
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit);
		barsFrame.bar[3]:Show();
		barsFrame.bar[3]:SetMinMaxValues(startTime, endTime);
		barsFrame.bar[3]:SetValue(endTime - ((GetTime()*1000) - startTime));
		barsFrame.bar[3].text:SetText(displayName);
		barsFrame.bar[3]:SetStatusBarColor(0.0, 1.0, 0.0);
	else	
		barsFrame.bar[3]:Hide();
	end
			
end

--On Update function handler
local function FocusOnUpdate()
	if (focusMain:IsVisible()) then
		focusBarsFrameUpdate(focusMain.barFrames[1]);
		focusBarsFrameUpdate(focusMain.barFrames[2]);
	end
end
	
--On Event function handler
local function FocusOnEvent(self, event)
	if (event == "ADDON_LOADED" and arg1 == "Hadar_FocusFrame") then
		FocusOnUpdate();
	end			
end

--Create an event frame to handle events
local focusEventFrame = CreateFrame("Frame");
focusEventFrame:SetScript("OnUpdate",function() FocusOnUpdate(); end);
focusEventFrame:SetScript("OnEvent",function(self, event) FocusOnEvent(self, event); end);
focusEventFrame:RegisterEvent("ADDON_LOADED");

-- Slash command handler
local function FocusFrame_SlashHandler(cmd)
	if (cmd ~= "") then
		if (strlower(cmd) == "lock") then
			if ( focusMain:IsMovable() ) then
				focusPrint("Focus Frame Locked");
				focusMain:SetMovable(false);
			else
				focusPrint("Focus Frame Unlocked");
				focusMain:SetMovable(true);
			end
		end
	else
		if (FocusMainFrame:IsVisible()) then
			FocusMainFrame:Hide();
		else
			FocusMainFrame:Show();
		end	
	end
end

-- Set up slash command
SlashCmdList["HADARFOCUSFRAME"] = FocusFrame_SlashHandler;
SLASH_HADARFOCUSFRAME1 = "/ff";

--local pendingUpdate = false;