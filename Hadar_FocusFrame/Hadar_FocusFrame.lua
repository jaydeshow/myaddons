--[[------------------------------------------------------
Hadar's Focus Frame (ver. 1.09)
*	Creates a movable frame that will show the Health, mana
	and casting bars of the Focus unit and the target of the
	focus unit.  
Usage:
* Slash Commands:
	/ff -- Shows or Hides the window. (Use the X button to close the window, too)
	/ff lock -- Locks or Unlocks the window.
	/ff friend buffs|debuffs|dispellable -- Sets the buffs/debuffs to show for friendly units
	/ff enemy buffs|debuffs|dispellable -- Sets the buffs/debuffs to show for enemy units
	/ff show buffs -- Shows the buff/debuff icons
	/ff hide buffs -- Hides the buff/debuff icons
	/ff options -- Shows the options window

* LEFT CLICK and drag the window handle to MOVE the window.
* RIGHT CLICK the window handle to SET your current target as your focus target.  
* RIGHT CLICK the window handle to with no target to CLEAR your focus target.  	

]]--------------------------------------------------------

local FF_MAX_DEBUFF_ICONS = 4;

--Backgrounds
local tooltipBackdrop = { bgFile="Interface\\Tooltips\\UI-Tooltip-Background", 
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
				tile = true, tileSize = 16, edgeSize = 16, 
				insets = { left = 5, right = 5, top = 5, bottom = 5 }
}; 

--Title color
local titleColor = {
		normal = {r=1.0,g=1.0,b=1.0,a=0.15},
		highlight = {r=0.5,g=1.0,b=0.8,a=0.45}
};

--Status bar width
local sbWidth = 75;

--BarFrame Height
local bfWidth = 75;
local bfHeight = 33;

--Main frame Width and Height
local frameWidth = 176;
local frameHeight = 43;

-- Prints a message to the default chat window
local function focusFrame_Print(msg)
	if (msg) then
		DEFAULT_CHAT_FRAME:AddMessage("[FF]: "..tostring(msg));
	end
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

--------------------
--Create status bars
--------------------
local function focusFrame_CreateStatusBar(parent, width, height, name)
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
-----------------------------------------
--Create a frame that holds 3 status bars
-----------------------------------------
local function focusFrame_CreateBarsFrame(parent, width, height, name, unit)
	local barsFrame = CreateFrame("Button", name, parent, "SecureUnitButtonTemplate");
	barsFrame:SetWidth(width);
	barsFrame:SetHeight(height);
	barsFrame:SetAttribute("unit", unit);
	barsFrame:SetAttribute("type1", "target");

	barsFrame.texture = barsFrame:CreateTexture(nil, "OVERLAY");
	barsFrame.texture:SetTexture(0.0, 1.0, 0.0, 0.5);
	barsFrame.texture:SetPoint("TOPLEFT", barsFrame, "TOPLEFT");
	barsFrame.texture:SetWidth(width);
	barsFrame.texture:SetHeight(10);

	barsFrame.name = barsFrame:CreateFontString(nil, "OVERLAY");
	barsFrame.name:SetFontObject("GameFontNormalSmall");
	barsFrame.name:SetWidth(width);
	barsFrame.name:SetHeight(10);
	barsFrame.name:SetJustifyH("CENTER");
	barsFrame.name:SetPoint("TOPLEFT", barsFrame, "TOPLEFT", 0,0);
	barsFrame.name:SetTextColor(1.0, 1.0, 1.0);
		
	barsFrame.bar = {};
	barsFrame.bar[1] = focusFrame_CreateStatusBar(barsFrame, width, 10);
	barsFrame.bar[2] = focusFrame_CreateStatusBar(barsFrame, width, 5);
	barsFrame.bar[3] = focusFrame_CreateStatusBar(barsFrame, width, 5);
	
	--Anchor and set the position of each status bar
	local currentAnchor = barsFrame;
	for x = 1, 3, 1 do
		if (x == 1) then
			barsFrame.bar[x]:SetPoint("TOPLEFT", currentAnchor, "TOPLEFT", 0, -11);
		else
			barsFrame.bar[x]:SetPoint("TOPLEFT", currentAnchor, "BOTTOMLEFT", 0, 0);
		end
		currentAnchor = barsFrame.bar[x];
	end
	
	barsFrame.raidIcon = barsFrame:CreateTexture(nil, "ARTWORK");	
	barsFrame.raidIcon:SetWidth(10);
	barsFrame.raidIcon:SetHeight(10);
	barsFrame.raidIcon:SetPoint("TOPRIGHT", barsFrame, "TOPRIGHT", 0 ,0);
	barsFrame.raidIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons");
	barsFrame.raidIcon:Show();	

	barsFrame.unit = unit;
	barsFrame.name:Show();
	return barsFrame;
end

-----------------------
--Create Debuff buttons
-----------------------
local function focusFrame_CreateDebuffButtons(parent)
	local name = parent:GetName();
	local dBtn1 = CreateFrame("Button", name.."Debuff1", parent, "FocusFrame_DebuffButtonTemplate");
	local dBtn2 = CreateFrame("Button", name.."Debuff2", parent, "FocusFrame_DebuffButtonTemplate");
	local dBtn3 = CreateFrame("Button", name.."Debuff3", parent, "FocusFrame_DebuffButtonTemplate");
	local dBtn4 = CreateFrame("Button", name.."Debuff4", parent, "FocusFrame_DebuffButtonTemplate");

	dBtn1:SetID(1);
	dBtn2:SetID(2);
	dBtn3:SetID(3);
	dBtn4:SetID(4);

	dBtn1:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0,-4);
	dBtn2:SetPoint("LEFT", dBtn1, "RIGHT", 2,0);
	dBtn3:SetPoint("LEFT", dBtn2, "RIGHT", 2,0);
	dBtn4:SetPoint("LEFT", dBtn3, "RIGHT", 2,0);
end

--Create 2 sets of status bars
focusMain.barFrames = {};
focusMain.barFrames[1] = focusFrame_CreateBarsFrame(focusMain, bfWidth, bfHeight, "theFocus", "focus");
focusMain.barFrames[2] = focusFrame_CreateBarsFrame(focusMain, bfWidth, bfHeight, "theToFocus", "focustarget");

focusFrame_CreateDebuffButtons(focusMain.barFrames[1]);
focusFrame_CreateDebuffButtons(focusMain.barFrames[2]);

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

-------------------------
--Get unit reaction color
-------------------------
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

--------------------
--Refresh buff icons
--------------------
function focusFrame_RefreshBuffs(button, showBuffs, unit)
	local buttonName = button:GetName();
	local name, rank, icon, debuffStack, debuffType, duration, timeLeft;
	local debuffColor, debuffCount;
	local cooldown, startCooldownTime;

	for i=1, FF_MAX_DEBUFF_ICONS do

		local debuffBorder = getglobal(buttonName.."Debuff"..i.."Border");
		local debuffIcon = getglobal(buttonName.."Debuff"..i.."Icon");

		-- Show all Buffs
		if ( showBuffs == "buffs" ) then
			name, rank, icon, debuffStack, duration, timeLeft = UnitBuff(unit, i); --, SHOW_CASTABLE_BUFFS);
			debuffBorder:Show();
		-- Show all debuffs
		elseif ( showBuffs == "debuffs" ) then
			name, rank, icon, debuffStack, debuffType, duration, timeLeft = UnitDebuff(unit, i);
			debuffBorder:Show();
		-- Show dispellable debuffs (value nil or anything ~= 0 or 1)
		elseif ( showBuffs == "dispellable" ) then
			name, rank, icon, debuffStack, debuffType, duration, timeLeft = UnitDebuff(unit, i, SHOW_DISPELLABLE_DEBUFFS);
			debuffBorder:Show();
		end
		
		if ( icon ) then
			debuffIcon:SetTexture(icon);
			
			if (showBuffs ~= "buffs") then
				if ( debuffType ) then
					debuffColor = DebuffTypeColor[debuffType];
				else
					debuffColor = DebuffTypeColor["none"];
				end
				debuffBorder:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b);
				debuffBorder:Show();
			else
				debuffBorder:Hide();
			end

			debuffCount = getglobal(buttonName.."Debuff"..i.."Count");
			
			if ( debuffStack > 1 ) then
				debuffCount:SetText(debuffStack);
				debuffCount:Show();
			else
				debuffCount:Hide();
			end

			cooldown = getglobal(buttonName.."Debuff"..i.."Cooldown");
			if ( duration  ) then
				if ( duration > 0 ) then
					cooldown:Show();
					startCooldownTime = GetTime()-(duration-timeLeft);
					CooldownFrame_SetTimer(cooldown, startCooldownTime, duration, 1);
				else
					cooldown:Hide();
				end
			else
				cooldown:Hide();
			end

			getglobal(buttonName.."Debuff"..i):Show();
		else
			getglobal(buttonName.."Debuff"..i):Hide();
		end
	end
end

-------------------------------------------
--Update the status bars in the Focus frame
-------------------------------------------
local function focusFrame_BarsFrameUpdate(barsFrame)
	local health, max, percentage, unit, name;
	unit = barsFrame.unit;	
	health = UnitHealth(unit);
	max = UnitHealthMax(unit);
	name = UnitName(unit);
	
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
			barsFrame.texture:SetWidth(bfWidth - 10);
			barsFrame.name:SetWidth(bfWidth - 10);
			barsFrame.raidIcon:Show();
		else
			barsFrame.texture:SetWidth(bfWidth);
			barsFrame.name:SetWidth(bfWidth);
			barsFrame.raidIcon:Hide();	
		end
	else
		barsFrame.texture:SetTexture(0, 0, 0, 0);
		barsFrame.raidIcon:Hide();
	end
	
	if (name and name ~= "Unknown") then
		barsFrame.name:SetText(name);
	else
		barsFrame.name:SetText("");
	end

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
		barsFrame.bar[3]:SetMinMaxValues((startTime or 0), (endTime or 0));
		barsFrame.bar[3]:SetValue(GetTime()*1000);
		barsFrame.bar[3].text:SetText(displayName);
		barsFrame.bar[3]:SetStatusBarColor(1.0, 0.7, 0.0);
		barsFrame.bar[3]:Show();
	elseif (UnitChannelInfo(unit)) then
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit);
		barsFrame.bar[3]:SetMinMaxValues((startTime or 0), (endTime or 0));
		barsFrame.bar[3]:SetValue(endTime - ((GetTime()*1000) - startTime));
		barsFrame.bar[3].text:SetText(displayName);
		barsFrame.bar[3]:SetStatusBarColor(0.0, 1.0, 0.0);
		barsFrame.bar[3]:Show();
	else	
		barsFrame.bar[3]:Hide();
	end
	
	if (FF_Options.showBuffs) then
		if (UnitIsFriend(unit, "player")) then
			focusFrame_RefreshBuffs(barsFrame, FF_Options.friend.type, unit);
		else
			focusFrame_RefreshBuffs(barsFrame, FF_Options.enemy.type, unit);
		end
	end
			
end

----------------------------
--On Update function handler
----------------------------
local function focusFrame_OnUpdate()
	if (focusMain:IsVisible()) then
		focusFrame_BarsFrameUpdate(focusMain.barFrames[1]);
		focusFrame_BarsFrameUpdate(focusMain.barFrames[2]);
	end
end
	
---------------------------
--On Event function handler
---------------------------
local function focusFrame_OnEvent(self, event)
	if (event == "ADDON_LOADED" and arg1 == "Hadar_FocusFrame") then
			
		if (not FF_Options) then
			FF_Options = {
				scale = 100,
				lock = false,
				showBuffs = true,
				friend = {type = "debuffs"},
				enemy = {type = "debuffs"}
			};
		end
		
		focusMain:SetMovable(not FF_Options.lock);
		focusMain:SetScale(FF_Options.scale / 100);
		focusFrame_OnUpdate();
	end			
end

----------------------------------------
--Create an event frame to handle events
----------------------------------------
local focusEventFrame = CreateFrame("Frame");
focusEventFrame:SetScript("OnUpdate",function() focusFrame_OnUpdate(); end);
focusEventFrame:SetScript("OnEvent",function(self, event) focusFrame_OnEvent(self, event); end);
focusEventFrame:RegisterEvent("ADDON_LOADED");

------------
--Hide Buffs
------------
function focusFrame_HideBuffs()
	for i = 1, FF_MAX_DEBUFF_ICONS do
		getglobal(focusMain.barFrames[1]:GetName().."Debuff"..i):Hide();
		getglobal(focusMain.barFrames[2]:GetName().."Debuff"..i):Hide();
	end
end

-----------------------
--Slash command handler
-----------------------
local function focusFrame_SlashHandler(cmd)
	if (cmd ~= "") then
		
		local args = {strsplit(" ",strlower(cmd))};
		
		if (args[1] == "lock") then
			if ( focusMain:IsMovable() ) then
				focusFrame_Print("Focus Frame Locked");
				focusMain:SetMovable(false);
				FF_Options.lock = true;
			else
				focusFrame_Print("Focus Frame Unlocked");
				focusMain:SetMovable(true);
				FF_Options.lock = false;
			end

		elseif (args[1] == "friend" or args[1] == "enemy") then
			if (args[2] == "buffs" or args[2] == "debuffs" or args[2] == "dispellable") then
				FF_Options[args[1]].type = args[2];
				focusFrame_Print(args[1]..": "..args[2]);
			end

		elseif (args[1] == "hide" and args[2] == "buffs") then
			FF_Options.showBuffs = false;
			focusFrame_Print("Hiding FocusFrame buff/debuff icons.");
			focusFrame_HideBuffs();

		elseif (args[1] == "show" and args[2] == "buffs") then
			FF_Options.showBuffs = true;
			focusFrame_Print("Showing FocusFrame buff/debuff icons.");
		
		elseif (args[1] == "options") then
			InterfaceOptionsFrame_OpenToFrame("Hadar's Focus Frame")
		
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
SlashCmdList["HADARFOCUSFRAME"] = focusFrame_SlashHandler;
SLASH_HADARFOCUSFRAME1 = "/ff";

