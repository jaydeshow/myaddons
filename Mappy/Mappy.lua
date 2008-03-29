gMappy_Settings = nil;

Mappy =
{
	StackingInfo = {},

	PresetMapButtonNames =
	{
		"GameTimeFrame",
		"MiniMapTrackingFrame",
		"MiniMapMailFrame",
		"MiniMapWorldMapButton",
		"MiniMapBattlefieldFrame",
		"MiniMapMeetingStoneFrame",
		"MinimapZoomIn",
		"MinimapZoomOut",
		
		"CT_RASets_Button",
	},
	
	IgnoreFrames =
	{
		Minimap = true,
		MinimapBackdrop = true,
		MiniMapPing = true,
		MinimapToggleButton = true,
		MinimapZoneTextButton = true,
		
		CT_RASetsFrame = true,
	},
	
	StartingCorner = "TOPRIGHT",
	
	CornerInfo =
	{
		TOPRIGHT =
		{
			NextCorner = "BOTTOMRIGHT",
			AnchorPoint = "TOP",
			RelativePoint = "BOTTOM",
			ButtonGap = 1,
			HorizGap = 0,
			VertGap = -1,
		},
		
		BOTTOMRIGHT =
		{
			NextCorner = "BOTTOMLEFT",
			AnchorPoint = "RIGHT",
			RelativePoint = "LEFT",
			ButtonGap = 1,
			HorizGap = -1,
			VertGap = 0,
		},
		
		BOTTOMLEFT =
		{
			NextCorner = "TOPLEFT",
			AnchorPoint = "BOTTOM",
			RelativePoint = "TOP",
			ButtonGap = 1,
			HorizGap = 0,
			VertGap = 1,
		},
		
		TOPLEFT =
		{
			NextCorner = "TOPRIGHT",
			AnchorPoint = "LEFT",
			RelativePoint = "RIGHT",
			ButtonGap = 1,
			HorizGap = 1,
			VertGap = 0,
		},
	},
};

function Mappy:VariablesLoaded()
	if not gMappy_Settings then
		gMappy_Settings = {};
		
		gMappy_Settings.MinimapSize = 140;
		gMappy_Settings.MinimapAlpha = 1;
		gMappy_Settings.MinimapCombatAlpha = 0.2;
		
		gMappy_Settings.MinimapRightOffset = -32;
		gMappy_Settings.MinimapTopOffset = -32;
	end
	
	self.Orig_StaticPopup_EscapePressed = StaticPopup_EscapePressed;
	
	StaticPopup_EscapePressed = function () return Mappy:EscapePressed() end;
	
	MCSchedulerLib:ScheduleUniqueTask(0.5, self.InitializeMinimap, self);
end

function Mappy:InitializeMinimap()
	-- Find the minimap buttons
	
	self.MinimapButtons = {};
	self.MinimapButtonsByFrame = {};
	
	for _, vButtonName in ipairs(self.PresetMapButtonNames) do
		self.IgnoreFrames[vButtonName] = true;
		
		local	vButton = getglobal(vButtonName);
		
		if vButton then
			table.insert(self.MinimapButtons, vButton);
			self.MinimapButtonsByFrame[vButton] = true;
		end
	end
	
	self:FindAddonButtons(MinimapCluster)
	self:FindAddonButtons(MinimapBackdrop)
	self:FindAddonButtons(Minimap)
	
	-- Initialize the minimap buttons
	
	for _, vButton in ipairs(self.MinimapButtons) do
		vButton.Mappy_SetPoint = vButton.SetPoint;
		vButton.Mappy_ClearAllPoints = vButton.ClearAllPoints;
		vButton.Mappy_OnHide = vButton:GetScript("OnHide");
		vButton.Mappy_OnShow = vButton:GetScript("OnShow");
		
		vButton.SetPoint = function () end;
		vButton.ClearAllPoints = function () end;
		vButton:SetScript("OnHide", Mappy.Button_OnHide);
		vButton:SetScript("OnShow", Mappy.Button_OnShow);
	end
	
	-- Enable dragging
	
	MinimapCluster:SetMovable(true)
	Minimap:RegisterForDrag("LeftButton")
	Minimap:SetScript("OnDragStart", function() Mappy:StartMovingMinimap() end)
	Minimap:SetScript("OnDragStop", function() Mappy:StopMovingMinimap() end)
	
	MinimapCluster.Mappy_SetPoint = MinimapCluster.SetPoint;
	MinimapCluster.Mappy_ClearAllPoints = MinimapCluster.ClearAllPoints;
	MinimapCluster.SetPoint = function () end;
	MinimapCluster.ClearAllPoints = function () end;
	
	MinimapCluster:Mappy_ClearAllPoints();
	MinimapCluster:Mappy_SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", gMappy_Settings.MinimapRightOffset or -32, gMappy_Settings.MinimapTopOffset or -32);
	
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 0, 0);
	
	-- Configure for square shape
	
	Minimap:SetMaskTexture("Interface\\Addons\\Mappy\\Textures\\MinimapMask");
	MinimapBorder:SetTexture(nil);
	
	MinimapBackdrop:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}});

	MinimapBackdrop:SetBackdropBorderColor(0.75, 0.75, 0.75);
	MinimapBackdrop:SetBackdropColor(0.15, 0.15, 0.15, 0.0);
	MinimapBackdrop:SetAlpha(1.0);
	
	Minimap_OnClick = Mappy_Minimap_OnClick;
	
	-- Change the backdrop to size with the map
	
	MinimapBackdrop:ClearAllPoints()
	MinimapBackdrop:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -4, 4);
	MinimapBackdrop:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 4, -4);
	
	-- Move the zone text to the top
	
	MinimapZoneTextButton:ClearAllPoints();
	MinimapZoneTextButton:SetPoint("BOTTOM", Minimap, "TOP", 0, 4);
	
	-- Get rid of the hide/show button
	
	MinimapToggleButton:Hide();
	
	MinimapBorderTop:Hide();
	
	-- Add scroll wheel support
	
	Minimap:SetScript("OnMouseWheel", function () Mappy:MinimapMouseWheel(arg1) end);
	Minimap:EnableMouseWheel(1);
	
	-- Add the coordinates display
	
	self.CoordString = Minimap:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
	self.CoordString:SetHeight(12);
	self.CoordString:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 15, 15);
	
	if not gMappy_Settings.HideCoordinates then
		MCSchedulerLib:ScheduleRepeatingTask(0.2, self.UpdateCoords, self);
	end
	
	-- Anchor the temporary enchant frame (and therefore buff and debuff frames)
	
	TemporaryEnchantFrame:ClearAllPoints();
	TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -15, 0);
	
	hooksecurefunc("TicketStatusFrame_OnEvent", self.ReanchorTemporyEnchantFrame);
	
	-- Hide requested buttons
	
	if gMappy_Settings.HideTimeOfDay then
		GameTimeFrame:Hide();
	end

	if gMappy_Settings.HideZoom then
		MinimapZoomIn:Hide();
		MinimapZoomOut:Hide();
	end
	
	if gMappy_Settings.HideWorldMap then
		MiniMapWorldMapButton:Hide();
	end
	
	if gMappy_Settings.HideZoneName then
		MinimapZoneTextButton:Hide();
	end
	
	-- Register for events
	
	MCEventLib:RegisterEvent("ZONE_CHANGED_NEW_AREA", self.ZoneChangedNewArea, self);
	MCEventLib:RegisterEvent("ZONE_CHANGED", self.ZoneChanged, self);
	MCEventLib:RegisterEvent("ZONE_CHANGED_INDOORS", self.ZoneChanged, self);
	
	MCEventLib:RegisterEvent("PLAYER_ENTERING_WORLD", self.RegenEnabled, self);
	MCEventLib:RegisterEvent("PLAYER_REGEN_ENABLED", self.RegenEnabled, self);
	MCEventLib:RegisterEvent("PLAYER_REGEN_DISABLED", self.RegenDisabled, self);
	
	self:RegenEnabled();

	-- Schedule the configuration (repeated to ensure it "sticks")
	
	MCSchedulerLib:ScheduleUniqueTask(0.5, self.ConfigureMinimap, self);
end

function Mappy:BeginStackingButtons()
	self.StackingInfo.Corner = self.StartingCorner;
	self.StackingInfo.CornerInfo = self.CornerInfo[self.StackingInfo.Corner];
	self.StackingInfo.PreviousButton = nil;
	self.StackingInfo.SpaceRemaining = Minimap:GetHeight();
	self.StackingInfo.ButtonFrameLevel = Minimap:GetFrameLevel() + 5;
end

function Mappy:StackButton(pButton, pNextButton)
	-- Calculate the space used by the button
	
	local	vSpaceUsed;
	local	vButtonSize = pButton:GetHeight();
	
	if not self.StackingInfo.PreviousButton then
		vSpaceUsed = vButtonSize / 2;
	else
		vSpaceUsed = vButtonSize + self.StackingInfo.CornerInfo.ButtonGap;
	end
	
	-- See if there's going to be room for the next button
	
	if pNextButton then
		local	vSpaceNeeded = vSpaceUsed + pNextButton:GetHeight() / 2;
		
		if self.StackingInfo.SpaceRemaining < vSpaceNeeded then
			-- Change the stacking direction and corner
			
			self.StackingInfo.Corner = self.StackingInfo.CornerInfo.NextCorner;
			self.StackingInfo.CornerInfo = self.CornerInfo[self.StackingInfo.Corner];
			self.StackingInfo.PreviousButton = nil;
			self.StackingInfo.SpaceRemaining = Minimap:GetHeight();

			vSpaceUsed = vButtonSize / 2;
		end
	end
	
	-- Stack the button
	
	MinimapCluster:SetAlpha(1);
	
	pButton:SetParent(MinimapCluster);
	pButton:SetAlpha(1);
	Mappy_SetFrameLevel(pButton, self.StackingInfo.ButtonFrameLevel);
	pButton:Mappy_ClearAllPoints();
	
	if not self.StackingInfo.PreviousButton then
		pButton:Mappy_SetPoint("CENTER", Minimap, self.StackingInfo.Corner);
		self.StackingInfo.PreviousButton = pButton;
	else
		pButton:Mappy_SetPoint(
				self.StackingInfo.CornerInfo.AnchorPoint,
				self.StackingInfo.PreviousButton,
				self.StackingInfo.CornerInfo.RelativePoint,
				self.StackingInfo.CornerInfo.HorizGap, self.StackingInfo.CornerInfo.VertGap);
	end
	
	self.StackingInfo.SpaceRemaining = self.StackingInfo.SpaceRemaining - vSpaceUsed;
	self.StackingInfo.PreviousButton = pButton;
end

function Mappy:SetMinimapAlpha(pAlpha)
	if self.DisableUpdates then
		return
	end
	
	gMappy_Settings.MinimapAlpha = pAlpha;
	self:AdjustAlpha(pAlpha);
end

function Mappy:SetMinimapCombatAlpha(pAlpha)
	if self.DisableUpdates then
		return
	end
	
	gMappy_Settings.MinimapCombatAlpha = pAlpha;
	self:AdjustAlpha(pAlpha);
end

function Mappy:SetMinimapSize(pSize)
	if self.DisableUpdates then
		return
	end
	
	gMappy_Settings.MinimapSize = pSize;
	MCSchedulerLib:ScheduleUniqueTask(0, self.ConfigureMinimap, self);
end

function Mappy:ConfigureMinimap()
	Minimap:SetWidth(gMappy_Settings.MinimapSize);
	Minimap:SetHeight(gMappy_Settings.MinimapSize);
	
	MinimapCluster:SetWidth(gMappy_Settings.MinimapSize);
	MinimapCluster:SetHeight(gMappy_Settings.MinimapSize);
	
	Minimap:SetScale(1.001); -- Flip the scale to force a refresh of the minimap size
	Minimap:SetScale(1);
	
	-- Stack all the known buttons
	
	self:BeginStackingButtons();

	local	vPreviousButton;
	
	for _, vButton in pairs(self.MinimapButtons) do
		if vPreviousButton and vPreviousButton:IsVisible() then
			self:StackButton(vPreviousButton, vButton);
		end
		
		vPreviousButton = vButton;
	end
	
	if vPreviousButton and vPreviousButton:IsVisible() then
		self:StackButton(vPreviousButton, nil);
	end
end

function Mappy:ZoneChangedNewArea()
	SetMapToCurrentZone();
end

function Mappy:GetUIObjectDescription(pUIObject)
	local	vDimensions = math.floor(pUIObject:GetWidth() + 0.5).."x"..math.floor(pUIObject:GetHeight() + 0.5);
	local	vIsShown;
	
	if pUIObject:IsShown() then
		vIsShown = "true";
	else
		vIsShown = "false";
	end
	
	return string.format("Type=%s Size=%s IsShown=%s", pUIObject:GetObjectType(), vDimensions, vIsShown);
end

function Mappy:ShowFrameTree(pFrame, pPrefix)
	local	vNumRegions = pFrame:GetNumRegions();
	local	vNumChildren = pFrame:GetNumChildren();
	local	vDimensions = math.floor(pFrame:GetWidth() + 0.5).."x"..math.floor(pFrame:GetHeight() + 0.5);
	
	if not pPrefix then
		Mappy.AnonFrames = {};
		pPrefix = pFrame:GetName() or "Unnamed";
	else
		pPrefix = pPrefix.."."..(pFrame:GetName() or "Unnamed");
	end
	
	DEFAULT_CHAT_FRAME:AddMessage(string.format("%s %s NumRegions=%d NumChildren=%d", pPrefix, self:GetUIObjectDescription(pFrame), vNumRegions, vNumChildren));
	
	for _, vRegion in pairs({pFrame:GetRegions()}) do
		local	vRegionName = vRegion:GetName();
		local	vRegionLabel = pPrefix.."."..(vRegionName or "Unnamed");
		
		-- DEFAULT_CHAT_FRAME:AddMessage(vRegionLabel.." Region "..self:GetUIObjectDescription(vRegion));
	end
	
	for _, vFrame in pairs({pFrame:GetChildren()}) do
		local	vFrameName = vFrame:GetName();
		local	vFrameLabel = pPrefix.."."..(vFrameName or "Unnamed");
		
		if not vFrameName then
			table.insert(Mappy.AnonFrames, vFrame);
			-- self:ShowFrameTree(vFrame, vFrameLabel);
		elseif not Mappy.IgnoreFrames[vFrameName] then
			DEFAULT_CHAT_FRAME:AddMessage(vFrameLabel.." Frame "..self:GetUIObjectDescription(vFrame));
		end
	end
end

function Mappy:IsAnchoredToFrame(pFrame, pAnchoredTo)
	local	vNumPoints = pFrame:GetNumPoints();

	for vPointIndex = 1, vNumPoints do
		local vPoint, vRelativeTo, vRelativePoint, vXOffset, vYOffset = pFrame:GetPoint(vPointIndex);
		
		if vRelativeTo == pAnchoredTo then
			return true;
		end
	end
	
	return false;
end

function Mappy:IsButtonFrame(pFrame, pAnchoredTo)
	local	vFrameName = pFrame:GetName() or "Anonymous";
	local	vFrameType = pFrame:GetFrameType();
	local	vFrameWidth = pFrame:GetWidth();
	local	vFrameHeight = pFrame:GetHeight();

	if self.IgnoreFrames[vFrameName]
	or self.MinimapButtonsByFrame[pFrame]
	or vFrameType == "Model"
	or vFrameWidth < 24 or vFrameWidth > 48
	or vFrameHeight ~= vFrameWidth then
		return false;
	end
	
	if pAnchoredTo and not self:IsAnchoredToFrame(pFrame, pAnchoredTo) then
		return false;
	end
	
	-- DEFAULT_CHAT_FRAME:AddMessage("Found minimap button "..vFrameName);
	return true;
end

function Mappy:FindAddonButtons(pFrame, pAnchoredTo)
	for _, vFrame in pairs({pFrame:GetChildren()}) do
		if self:IsButtonFrame(vFrame, pAnchoredTo) then
			table.insert(self.MinimapButtons, vFrame);
			self.MinimapButtonsByFrame[vFrame] = true;
		end
	end
	
	if not pAnchoredTo then
		self:FindAddonButtons(UIParent, pFrame);
	end
end

function Mappy:UpdateCoords()
	local	vX, vY = GetPlayerMapPosition("player");
	
	if vX == 0 and vY == 0 then
		self.CoordString:SetText("");
	else
		self.CoordString:SetText(string.format("%.1f, %.1f", vX * 100, vY * 100));
	end
end

function Mappy:AdjustAlpha(pForceAlpha)
	if pForceAlpha then
		Minimap:SetAlpha(pForceAlpha);
	elseif IsInInstance() or IsIndoors() then
		Minimap:SetAlpha(1);
	elseif self.InCombat then
		Minimap:SetAlpha(gMappy_Settings.MinimapCombatAlpha or 0.2);
	else
		Minimap:SetAlpha(gMappy_Settings.MinimapAlpha or 1);
	end
end

function Mappy:ZoneChanged()
	self:AdjustAlpha();
end

function Mappy:RegenEnabled()
	self.InCombat = false;
	self:AdjustAlpha();
end

function Mappy:RegenDisabled()
	self.InCombat = true;
	self:AdjustAlpha();
end

function Mappy:InitializeSettingsDialog()
	self.SettingsDialog = CreateFrame("Frame", nil, MinimapCluster);
	self.SettingsDialog:SetFrameStrata("DIALOG");
	
	self.SettingsDialog:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}});

	self.SettingsDialog:SetBackdropBorderColor(0.75, 0.75, 0.75);
	self.SettingsDialog:SetBackdropColor(0, 0, 0, 0.9);
	self.SettingsDialog:SetAlpha(1);
	
	self.SettingsDialog:SetWidth(180);
	self.SettingsDialog:SetHeight(310);
	
	-- Size slider
	
	self.SizeSlider = CreateFrame("Slider", "MappySizeSlider", self.SettingsDialog, "OptionsSliderTemplate");
	self.SizeSlider:SetPoint("TOPLEFT", self.SettingsDialog, "TOPLEFT", 15, -20);
	self.SizeSlider:SetMinMaxValues(80, 600);
	self.SizeSlider:SetScript("OnValueChanged", function () Mappy:SetMinimapSize(this:GetValue()) end);
	getglobal("MappySizeSliderText"):SetText("尺寸");
	getglobal("MappySizeSliderLow"):SetText("小");
	getglobal("MappySizeSliderHigh"):SetText("大");
	
	-- Alpha slider
	
	self.AlphaSlider = CreateFrame("Slider", "MappyAlphaSlider", self.SettingsDialog, "OptionsSliderTemplate");
	self.AlphaSlider:SetPoint("TOPLEFT", self.SizeSlider, "BOTTOMLEFT", 0, -30);
	self.AlphaSlider:SetScript("OnValueChanged", function () Mappy:SetMinimapAlpha(this:GetValue()) end);
	getglobal("MappyAlphaSliderText"):SetText("透明度");
	self.AlphaSlider:SetMinMaxValues(0.05, 1);
	
	-- Combat alpha slider
	
	self.CombatAlphaSlider = CreateFrame("Slider", "MappyCombatAlphaSlider", self.SettingsDialog, "OptionsSliderTemplate");
	self.CombatAlphaSlider:SetPoint("TOPLEFT", self.AlphaSlider, "BOTTOMLEFT", 0, -30);
	self.CombatAlphaSlider:SetScript("OnValueChanged", function () Mappy:SetMinimapCombatAlpha(this:GetValue()) end);
	getglobal("MappyCombatAlphaSliderText"):SetText("战斗中透明度");
	self.CombatAlphaSlider:SetMinMaxValues(0.05, 1);
	
	-- Hide time-of-day
	
	self.HideTimeOfDayCheckbutton = CreateFrame("Checkbutton", "MappyHideTimeOfDayCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate");
	self.HideTimeOfDayCheckbutton:SetPoint("TOPLEFT", self.CombatAlphaSlider, "BOTTOMLEFT", -5, -15);
	self.HideTimeOfDayCheckbutton:SetScript("OnShow", function () this:SetChecked(gMappy_Settings.HideTimeOfDay) end);
	self.HideTimeOfDayCheckbutton:SetScript("OnClick", function () Mappy:SetHideTimeOfDay(this:GetChecked()) end);
	MappyHideTimeOfDayCheckbuttonText:SetText("隐藏时间按钮");
	
	-- Hide zoom in/out

	self.HideZoomCheckbutton = CreateFrame("Checkbutton", "MappyHideZoomCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate");
	self.HideZoomCheckbutton:SetPoint("TOPLEFT", self.HideTimeOfDayCheckbutton, "BOTTOMLEFT", 0, 7);
	self.HideZoomCheckbutton:SetScript("OnShow", function () this:SetChecked(gMappy_Settings.HideZoom) end);
	self.HideZoomCheckbutton:SetScript("OnClick", function () Mappy:SetHideZoom(this:GetChecked()) end);
	MappyHideZoomCheckbuttonText:SetText("隐藏放大缩小按钮");

	-- Hide world map button

	self.HideWorldMapCheckbutton = CreateFrame("Checkbutton", "MappyHideWorldMapCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate");
	self.HideWorldMapCheckbutton:SetPoint("TOPLEFT", self.HideZoomCheckbutton, "BOTTOMLEFT", 0, 7);
	self.HideWorldMapCheckbutton:SetScript("OnShow", function () this:SetChecked(gMappy_Settings.HideWorldMap) end);
	self.HideWorldMapCheckbutton:SetScript("OnClick", function () Mappy:SetHideWorldMap(this:GetChecked()) end);
	MappyHideWorldMapCheckbuttonText:SetText("隐藏世界地图按钮");

	-- Hide coordinates

	self.HideCoordinatesCheckbutton = CreateFrame("Checkbutton", "MappyHideCoordinatesCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate");
	self.HideCoordinatesCheckbutton:SetPoint("TOPLEFT", self.HideWorldMapCheckbutton, "BOTTOMLEFT", 0, 7);
	self.HideCoordinatesCheckbutton:SetScript("OnShow", function () this:SetChecked(gMappy_Settings.HideCoordinates) end);
	self.HideCoordinatesCheckbutton:SetScript("OnClick", function () Mappy:SetHideCoordinates(this:GetChecked()) end);
	MappyHideCoordinatesCheckbuttonText:SetText("隐藏坐标");

	-- Hide zone name

	self.HideZoneNameCheckbutton = CreateFrame("Checkbutton", "MappyHideZoneNameCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate");
	self.HideZoneNameCheckbutton:SetPoint("TOPLEFT", self.HideCoordinatesCheckbutton, "BOTTOMLEFT", 0, 7);
	self.HideZoneNameCheckbutton:SetScript("OnShow", function () this:SetChecked(gMappy_Settings.HideZoneName) end);
	self.HideZoneNameCheckbutton:SetScript("OnClick", function () Mappy:SetHideZoneName(this:GetChecked()) end);
	MappyHideZoneNameCheckbuttonText:SetText("隐藏地区名称");

	-- Lock position

	self.LockPositionCheckbutton = CreateFrame("Checkbutton", "MappyLockPositionCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate");
	self.LockPositionCheckbutton:SetPoint("TOPLEFT", self.HideZoneNameCheckbutton, "BOTTOMLEFT", 0, 7);
	self.LockPositionCheckbutton:SetScript("OnShow", function () this:SetChecked(gMappy_Settings.LockPosition) end);
	self.LockPositionCheckbutton:SetScript("OnClick", function () Mappy:SetLockPosition(this:GetChecked()) end);
	MappyLockPositionCheckbuttonText:SetText("锁定位置");
end

function Mappy:SetHideTimeOfDay(pHide)
	if pHide then
		gMappy_Settings.HideTimeOfDay = true;
		GameTimeFrame:Hide();
	else
		gMappy_Settings.HideTimeOfDay = nil;
		GameTimeFrame:Show();
	end
end

function Mappy:SetHideZoom(pHide)
	if pHide then
		gMappy_Settings.HideZoom = true;
		MinimapZoomIn:Hide();
		MinimapZoomOut:Hide();
	else
		gMappy_Settings.HideZoom = nil;
		MinimapZoomIn:Show();
		MinimapZoomOut:Show();
	end
end

function Mappy:SetHideWorldMap(pHide)
	if pHide then
		gMappy_Settings.HideWorldMap = true;
		MiniMapWorldMapButton:Hide();
	else
		gMappy_Settings.HideWorldMap = nil;
		MiniMapWorldMapButton:Show();
	end
end

function Mappy:SetHideCoordinates(pHide)
	if pHide then
		gMappy_Settings.HideCoordinates = true;
		self.CoordString:SetText("");
		MCSchedulerLib:UnscheduleTask(self.UpdateCoords, self);
	else
		gMappy_Settings.HideCoordinates = nil;
		MCSchedulerLib:ScheduleRepeatingTask(0.2, self.UpdateCoords, self);
	end
end

function Mappy:SetHideZoneName(pHide)
	if pHide then
		gMappy_Settings.HideZoneName = true;
		MinimapZoneTextButton:Hide();
	else
		gMappy_Settings.HideZoneName = nil;
		MinimapZoneTextButton:Show();
	end
end

function Mappy:SetLockPosition(pLock)
	if pLock then
		gMappy_Settings.LockPosition = true;
	else
		gMappy_Settings.LockPosition = nil;
	end
end

function Mappy:ShowSettingsDialog()
	if not self.SettingsDialog then
		self:InitializeSettingsDialog();
	end
	
	self.DisableUpdates = true;
	self.SizeSlider:SetValue(gMappy_Settings.MinimapSize or 140);
	self.AlphaSlider:SetValue(gMappy_Settings.MinimapAlpha or 1);
	self.CombatAlphaSlider:SetValue(gMappy_Settings.MinimapCombatAlpha or 0.2);
	self.DisableUpdates = false;
	
	-- Put the dialog under the cursor
	
	local	vCursorX, vCursorY = GetCursorPosition();
	local	vUIScale = UIParent:GetScale();
	
	vCursorX = vCursorX / vUIScale;
	vCursorY = vCursorY / vUIScale;
	
	self.SettingsDialog:ClearAllPoints();
	
	local	vAnchorPoint;
	
	if vCursorY < 0.5 * (UIParent:GetTop() + UIParent:GetBottom()) then
		vAnchorPoint = "BOTTOM";
	else
		vAnchorPoint = "TOP";
	end
	
	self.SettingsDialog:SetPoint(vAnchorPoint, UIParent, "BOTTOMLEFT", vCursorX, vCursorY);
	self.SettingsDialog:Show();
end

function Mappy:HideSettingsDialog()
	if not self.SettingsDialog
	or not self.SettingsDialog:IsVisible() then
		return false;
	end

	self.SettingsDialog:Hide();
	self:AdjustAlpha();
	
	return true;
end

function Mappy:EscapePressed()
	local	vClosed = self.Orig_StaticPopup_EscapePressed();

	if Mappy:HideSettingsDialog() then
		vClosed = 1;
	end
	
	return vClosed;
end

function Mappy.Button_OnHide(...)
	local	vResult;
	
	if this.Mappy_OnHide then
		vResult = this.Mappy_OnHide(...);
	end
	
	MCSchedulerLib:ScheduleUniqueTask(0, Mappy.ConfigureMinimap, Mappy);
	
	return vResult;
end

function Mappy.Button_OnShow(...)
	local	vResult;
	
	if this.Mappy_OnShow then
		vResult = this.Mappy_OnShow(...);
	end
	
	MCSchedulerLib:ScheduleUniqueTask(0, Mappy.ConfigureMinimap, Mappy);
	
	return vResult;
end

function Mappy_Minimap_OnClick()
	if arg1 == "RightButton" then
		if Mappy.SettingsDialog
		and Mappy.SettingsDialog:IsVisible() then
			Mappy:HideSettingsDialog();
		else
			Mappy:ShowSettingsDialog();
		end
	else
		Mappy:HideSettingsDialog();
		
		local vCenterX, vCenterY = this:GetCenter();
		local vX, vY = GetCursorPosition();
		
		Minimap:PingLocation(
				vX / this:GetEffectiveScale() - vCenterX,
				vY / this:GetEffectiveScale() - vCenterY);
	end
end

function Mappy:MinimapMouseWheel(pWheelDirection)
	local	vZoom = Minimap:GetZoom();
	
	if pWheelDirection > 0 then
		if vZoom < (Minimap:GetZoomLevels() - 1) then
			Minimap:SetZoom(vZoom + 1);
		end
		
		MinimapZoomOut:Enable();
		
		if Minimap:GetZoom() == (Minimap:GetZoomLevels() - 1) then
			MinimapZoomIn:Disable();
		end
	else
		if vZoom > 0 then
			Minimap:SetZoom(vZoom - 1);
		end

		MinimapZoomIn:Enable();
		
		if Minimap:GetZoom() == 0 then
			MinimapZoomOut:Disable();
		end
	end
end

function Mappy:StartMovingMinimap()
	if gMappy_Settings.LockPosition then
		return;
	end
	
	-- Hide settings
	
	Mappy:HideSettingsDialog();
	
	-- Enable moving
	
	MinimapCluster.SetPoint = MinimapCluster.Mappy_SetPoint;
	MinimapCluster.ClearAllPoints = MinimapCluster.Mappy_ClearAllPoints;
	
	-- Start moving
	
	MinimapCluster:StartMoving();
end

function Mappy:StopMovingMinimap()
	if gMappy_Settings.LockPosition then
		return;
	end
	
	-- Stop moving
	
	MinimapCluster:StopMovingOrSizing();
	
	-- Disable moving
	
	MinimapCluster.SetPoint = function () end;
	MinimapCluster.ClearAllPoints = function () end;
	
	-- Save the new position
	
	MinimapCluster:SetUserPlaced(0);
	
	local	vRight = MinimapCluster:GetRight();
	local	vTop = MinimapCluster:GetTop();
	
	gMappy_Settings.MinimapRightOffset = vRight - UIParent:GetRight();
	gMappy_Settings.MinimapTopOffset = vTop - UIParent:GetTop();

	MinimapCluster:Mappy_ClearAllPoints();
	MinimapCluster:Mappy_SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", gMappy_Settings.MinimapRightOffset, gMappy_Settings.MinimapTopOffset);
end

function Mappy.ReanchorTemporyEnchantFrame()
	TemporaryEnchantFrame:ClearAllPoints();
	TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -15, 0);
end

function Mappy_SetFrameLevel(pFrame, pLevel)
	local	vOldLevel = pFrame:GetFrameLevel();
	
	pFrame:SetFrameLevel(pLevel);
	
	local	vChildren = {pFrame:GetChildren()};
	
	for _, vChildFrame in pairs(vChildren) do
		Mappy_SetFrameLevel(vChildFrame, pLevel + (vChildFrame:GetFrameLevel() - vOldLevel));
	end
end

MCEventLib:RegisterEvent("VARIABLES_LOADED", Mappy.VariablesLoaded, Mappy);
