gMappy_Settings = nil

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
}

MCDebugLib:InstallDebugger("Mappy", Mappy, {r=0.5,g=1,b=0.7})

function Mappy:VariablesLoaded()
	if not gMappy_Settings then
		gMappy_Settings =
		{
			Profiles =
			{
				DEFAULT =
				{
					MinimapSize = 140,
					MinimapAlpha = 1,
					MinimapCombatAlpha = 0.2,
					
					MinimapRightOffset = -32,
					MinimapTopOffset = -32,
					
					HideTimeOfDay = false,
					HideZoom = false,
					HideWorldMap = false,
					HideZoneName = false,
					GhostMinimap = false,
					AutoArrangeButtons = true,
				}
			}
		}
		
		self:AddStandardProfiles()
		
	elseif not gMappy_Settings.Profiles then
		local vProfile = {}
		
		for vKey, vValue in pairs(gMappy_Settings) do
			vProfile[vKey] = vValue
			gMappy_Settings[vKey] = nil
		end
		
		vProfile.AutoArrangeButtons = true
		
		gMappy_Settings.Profiles = {}
		gMappy_Settings.Profiles.DEFAULT = vProfile
		
		gMappy_Settings.CurrentProfileName = nil
		
		self:AddStandardProfiles()
	end
	
	self.CurrentProfile = gMappy_Settings.Profiles[gMappy_Settings.CurrentProfileName]
	
	if not self.CurrentProfile then
		self.CurrentProfile = gMappy_Settings.Profiles.DEFAULT
	end
	
	self.Orig_StaticPopup_EscapePressed = StaticPopup_EscapePressed
	StaticPopup_EscapePressed = function () return Mappy:EscapePressed() end
	
	MCSchedulerLib:ScheduleUniqueTask(0.5, self.InitializeMinimap, self)
	
	-- Commands
	
	SlashCmdList.MAPPY = function (...) Mappy:ExecuteCommand(...) end
	SLASH_MAPPY1 = "/mappy"
end

function Mappy:AddStandardProfiles()
	gMappy_Settings.Profiles.gather =
	{
		MinimapSize = 800,
		MinimapAlpha = 0,
		MinimapCombatAlpha = 0,
		
		MinimapRightOffset = -32,
		MinimapTopOffset = 0,
		
		HideTimeOfDay = false,
		HideZoom = false,
		HideWorldMap = false,
		HideZoneName = false,
		GhostMinimap = true,
		AutoArrangeButtons = true,
	}
end

function Mappy:InitializeMinimap()
	self:FindMinimapButtons()
	
	-- Initialize the minimap buttons
	
	self:InitializeDragging()
	self:InitializeSquareShape()

	Minimap_OnClick = Mappy_Minimap_OnClick
	
	-- Get rid of the hide/show button
	
	MinimapToggleButton:Hide()
	
	MinimapBorderTop:Hide()
	
	-- Add scroll wheel support
	
	Minimap:SetScript("OnMouseWheel", function () Mappy:MinimapMouseWheel(arg1) end)
	Minimap:EnableMouseWheel(1)
	
	-- Add the coordinates display
	
	self.CoordString = Minimap:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	self.CoordString:SetHeight(12)
	self.CoordString:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 15, 15)
	
	MCSchedulerLib:ScheduleRepeatingTask(0.2, self.Update, self)
	
	-- Anchor the temporary enchant frame (and therefore buff and debuff frames)
	
	TemporaryEnchantFrame:ClearAllPoints()
	TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -15, 0)
	
	hooksecurefunc("TicketStatusFrame_OnEvent", self.ReanchorTemporyEnchantFrame)
	
	-- Re-parent the player direction arrow so that it doesn't fade with the minimap alpha
	
	for vFrameIndex, vFrame in ipairs({Minimap:GetChildren()}) do
		if not vFrame:GetName()
		and vFrame:GetObjectType() == "Model"
		and vFrame:GetWidth() > 37
		and vFrame:GetWidth() < 39
		and vFrame:GetHeight() > 37
		and vFrame:GetHeight() < 39 then
			vFrame:SetParent(MinimapCluster)
			vFrame:SetScale(1.5)
			Mappy.PlayerArrow = vFrame
			break
		end
	end
	
	-- Register for events
	
	MCEventLib:RegisterEvent("ZONE_CHANGED_NEW_AREA", self.ZoneChangedNewArea, self)
	MCEventLib:RegisterEvent("ZONE_CHANGED", self.ZoneChanged, self)
	MCEventLib:RegisterEvent("ZONE_CHANGED_INDOORS", self.ZoneChanged, self)
	
	MCEventLib:RegisterEvent("PLAYER_ENTERING_WORLD", self.RegenEnabled, self)
	MCEventLib:RegisterEvent("PLAYER_REGEN_ENABLED", self.RegenEnabled, self)
	MCEventLib:RegisterEvent("PLAYER_REGEN_DISABLED", self.RegenDisabled, self)
	
	self:RegenEnabled()

	-- Schedule the configuration
	
	MCSchedulerLib:ScheduleUniqueTask(0.5, self.ConfigureMinimap, self)
	
	-- Monitor the mounted state so we can determine which opacity setting to use
	
	MCSchedulerLib:ScheduleUniqueRepeatingTask(0.5, self.UpdateMountedState, self)
end

function Mappy:FindMinimapButtons()
	self.MinimapButtons = {}
	self.MinimapButtonsByFrame = {}
	
	for _, vButtonName in ipairs(self.PresetMapButtonNames) do
		self.IgnoreFrames[vButtonName] = true
	
		local	vButton = getglobal(vButtonName)
		
		if vButton then
			table.insert(self.MinimapButtons, vButton)
			self.MinimapButtonsByFrame[vButton] = true
		end
	end
	
	-- self:ShowFrameTree(Minimap)
	
	self:FindAddonButtons(MinimapCluster)
	self:FindAddonButtons(MinimapBackdrop)
	self:FindAddonButtons(Minimap)
end

function Mappy:ConfigureMinimapOptions()
	if self.CurrentProfile.AutoArrangeButtons then
		self:EnableButtonStacking()
	else
		self:DisableButtonStacking()
	end
	
	if self.CurrentProfile.HideTimeOfDay then
		GameTimeFrame:Hide()
	else
		GameTimeFrame:Show()
	end

	if self.CurrentProfile.HideZoom then
		MinimapZoomIn:Hide()
		MinimapZoomOut:Hide()
	else
		MinimapZoomIn:Show()
		MinimapZoomOut:Show()
	end
	
	if self.CurrentProfile.HideWorldMap then
		MiniMapWorldMapButton:Hide()
	else
		MiniMapWorldMapButton:Show()
	end
	
	if self.CurrentProfile.HideZoneName then
		MinimapZoneTextButton:Hide()
	else
		MinimapZoneTextButton:Show()
	end
	
	if self.CurrentProfile.GhostMinimap then
		self:GhostMinimap()
	else
		self:UnghostMinimap()
	end
end

function Mappy:EnableButtonStacking()
	for _, vButton in ipairs(self.MinimapButtons) do
		if not vButton.Mappy_SetPoint then
			vButton.Mappy_SetPoint = vButton.SetPoint
			vButton.Mappy_ClearAllPoints = vButton.ClearAllPoints
			vButton.Mappy_OnHide = vButton:GetScript("OnHide")
			vButton.Mappy_OnShow = vButton:GetScript("OnShow")
			
			vButton.SetPoint = function () end
			vButton.ClearAllPoints = function () end
			vButton:SetScript("OnHide", Mappy.Button_OnHide)
			vButton:SetScript("OnShow", Mappy.Button_OnShow)
		end
	end
end

function Mappy:DisableButtonStacking()
	for _, vButton in ipairs(self.MinimapButtons) do
		if vButton.Mappy_SetPoint then
			vButton.SetPoint = vButton.Mappy_SetPoint
			vButton.ClearAllPoints = vButton.Mappy_ClearAllPoints
			vButton:SetScript("OnHide", vButton.Mappy_OnHide)
			vButton:SetScript("OnShow", vButton.Mappy_OnShow)
			
			vButton.Mappy_SetPoint = nil
			vButton.Mappy_ClearAllPoints = nil
			vButton.Mappy_OnHide = nil
			vButton.Mappy_OnShow = nil
		end
	end
end

function Mappy:InitializeDragging()
	MinimapCluster:SetMovable(true)
	MinimapCluster:SetUserPlaced(true)
	
	Minimap:RegisterForDrag("LeftButton")
	Minimap:SetScript("OnDragStart", function() Mappy:StartMovingMinimap() end)
	Minimap:SetScript("OnDragStop", function() Mappy:StopMovingMinimap() end)
	
	MinimapCluster.Mappy_SetPoint = MinimapCluster.SetPoint
	MinimapCluster.Mappy_ClearAllPoints = MinimapCluster.ClearAllPoints
	MinimapCluster.SetPoint = function () end
	MinimapCluster.ClearAllPoints = function () end
	
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 0, 0)
end

function Mappy:InitializeSquareShape()
	Minimap:SetMaskTexture("Interface\\Addons\\Mappy\\Textures\\MinimapMask")
	MinimapBorder:SetTexture(nil)
	
	MinimapBackdrop:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}})

	MinimapBackdrop:SetBackdropBorderColor(0.75, 0.75, 0.75)
	MinimapBackdrop:SetBackdropColor(0.15, 0.15, 0.15, 0.0)
	MinimapBackdrop:SetAlpha(1.0)

	-- Change the backdrop to size with the map
	
	MinimapBackdrop:ClearAllPoints()
	MinimapBackdrop:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -4, 4)
	MinimapBackdrop:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 4, -4)
	
	-- Move the zone text to the top
	
	MinimapZoneTextButton:ClearAllPoints()
	MinimapZoneTextButton:SetPoint("BOTTOM", Minimap, "TOP", 0, 4)
	
end

function Mappy:GhostMinimap()
	self.CurrentProfile.GhostMinimap = true
	
	Minimap:RegisterForDrag()
	Minimap:EnableMouse(false)

	MinimapCluster:RegisterForDrag()
	MinimapCluster:EnableMouse(false)

	Minimap:EnableMouseWheel(0)
end

function Mappy:UnghostMinimap()
	self.CurrentProfile.GhostMinimap = false
	
	Minimap:RegisterForDrag("LeftButton")
	Minimap:EnableMouse(true)

	Minimap:SetScript("OnMouseWheel", function () Mappy:MinimapMouseWheel(arg1) end)
	Minimap:EnableMouseWheel(1)
end

function Mappy:SaveProfile(pName)
	if not pName or pName == "" then
		Mappy:ErrorMessage("You must specify a name for the profile")
		return
	end
	
	local vName = string.lower(pName)
	
	-- Clone the current profile
	
	local vProfile = {}
	
	for vKey, vValue in pairs(self.CurrentProfile) do
		vProfile[vKey] = vValue
	end
	
	gMappy_Settings.Profiles[vName] = vProfile
	gMappy_Settings.CurrentProfileName = vName
	
	self.CurrentProfile = vProfile
end

function Mappy:LoadProfileName(pName)
	if not pName or pName == "" then
		Mappy:ErrorMessage("You must specify a name for the profile")
		return
	end
	
	local vName = string.lower(pName)
	
	if not gMappy_Settings.Profiles[vName] then
		Mappy:ErrorMessage("Couldn't find a saved profile with the name %s", pName)
		return
	end
	
	gMappy_Settings.CurrentProfileName = vName
	self:LoadProfile(gMappy_Settings.Profiles[vName])
end

function Mappy:LoadDefaultProfile()
	gMappy_Settings.CurrentProfileName = "DEFAULT"
	self:LoadProfile(gMappy_Settings.Profiles.DEFAULT)
end

function Mappy:LoadProfile(pProfile)
	self.CurrentProfile = pProfile
	
	MCSchedulerLib:ScheduleUniqueTask(0, self.ConfigureMinimap, self)
end

function Mappy:ExecuteCommand(pCommand)
	local	vCommands =
	{
		ghost = {func = self.GhostMinimap},
		unghost = {func = self.UnghostMinimap},
		save = {func = self.SaveProfile},
		load = {func = self.LoadProfileName},
		default = {func = self.LoadDefaultProfile},
	}
	
	local	vStartIndex, vEndIndex, vCommand, vParameter = string.find(pCommand, "(%w+) ?(.*)")
	
	if not vCommand then
		Mappy:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/mappy ghost"..NORMAL_FONT_COLOR_CODE..": Mouse clicks in the minimap will be passed through to the background")
		Mappy:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/mappy unghost"..NORMAL_FONT_COLOR_CODE..": Mouse clicks work as usual")
		return
	end
	
	vCommand = strlower(vCommand)
	
	local	vCommandInfo = vCommands[vCommand]
	
	if not vCommandInfo then
		Mappy:ErrorMessage("Expected command")
		return
	end
	
	vCommandInfo.func(self, vParameter)
end

function Mappy:BeginStackingButtons()
	self.StackingInfo.Corner = self.StartingCorner
	self.StackingInfo.CornerInfo = self.CornerInfo[self.StackingInfo.Corner]
	self.StackingInfo.PreviousButton = nil
	self.StackingInfo.SpaceRemaining = Minimap:GetHeight()
	self.StackingInfo.ButtonFrameLevel = Minimap:GetFrameLevel() + 5
end

function Mappy:StackButton(pButton, pNextButton)
	-- Calculate the space used by the button
	
	local	vSpaceUsed
	local	vButtonSize = pButton:GetHeight()
	
	if not self.StackingInfo.PreviousButton then
		vSpaceUsed = vButtonSize / 2
	else
		vSpaceUsed = vButtonSize + self.StackingInfo.CornerInfo.ButtonGap
	end
	
	-- See if there's going to be room for the next button
	
	if pNextButton then
		local	vSpaceNeeded = vSpaceUsed + pNextButton:GetHeight() / 2
		
		if self.StackingInfo.SpaceRemaining < vSpaceNeeded then
			-- Change the stacking direction and corner
			
			self.StackingInfo.Corner = self.StackingInfo.CornerInfo.NextCorner
			self.StackingInfo.CornerInfo = self.CornerInfo[self.StackingInfo.Corner]
			self.StackingInfo.PreviousButton = nil
			self.StackingInfo.SpaceRemaining = Minimap:GetHeight()

			vSpaceUsed = vButtonSize / 2
		end
	end
	
	-- Stack the button
	
	MinimapCluster:SetAlpha(1)
	
	pButton:SetParent(MinimapCluster)
	pButton:SetAlpha(1)
	Mappy.SetFrameLevel(pButton, self.StackingInfo.ButtonFrameLevel)
	pButton:Mappy_ClearAllPoints()
	
	if not self.StackingInfo.PreviousButton then
		pButton:Mappy_SetPoint("CENTER", Minimap, self.StackingInfo.Corner)
		self.StackingInfo.PreviousButton = pButton
	else
		pButton:Mappy_SetPoint(
				self.StackingInfo.CornerInfo.AnchorPoint,
				self.StackingInfo.PreviousButton,
				self.StackingInfo.CornerInfo.RelativePoint,
				self.StackingInfo.CornerInfo.HorizGap, self.StackingInfo.CornerInfo.VertGap)
	end
	
	self.StackingInfo.SpaceRemaining = self.StackingInfo.SpaceRemaining - vSpaceUsed
	self.StackingInfo.PreviousButton = pButton
end

function Mappy:SetMinimapAlpha(pAlpha)
	if self.DisableUpdates then
		return
	end
	
	self.CurrentProfile.MinimapAlpha = pAlpha
	self:AdjustAlpha(pAlpha)
end

function Mappy:SetMinimapCombatAlpha(pAlpha)
	if self.DisableUpdates then
		return
	end
	
	self.CurrentProfile.MinimapCombatAlpha = pAlpha
	self:AdjustAlpha(pAlpha)
end

function Mappy:SetMinimapSize(pSize)
	if self.DisableUpdates then
		return
	end
	
	self.CurrentProfile.MinimapSize = pSize
	MCSchedulerLib:ScheduleUniqueTask(0, self.ConfigureMinimap, self)
end

function Mappy:ConfigureMinimap()
	self:ConfigureMinimapOptions()
	
	MinimapCluster:Mappy_ClearAllPoints()
	MinimapCluster:Mappy_SetPoint(
			"TOPRIGHT", 
			UIParent,
			"TOPRIGHT",
			self.CurrentProfile.MinimapRightOffset or -32,
			self.CurrentProfile.MinimapTopOffset or -32)
	
	Minimap:SetWidth(self.CurrentProfile.MinimapSize)
	Minimap:SetHeight(self.CurrentProfile.MinimapSize)
	
	MinimapCluster:SetWidth(self.CurrentProfile.MinimapSize)
	MinimapCluster:SetHeight(self.CurrentProfile.MinimapSize)
	
	Minimap:SetScale(1.001) -- Flip the scale to force a refresh of the minimap size
	Minimap:SetScale(1)
	
	-- Stack all the known buttons
	
	self:BeginStackingButtons()

	local	vPreviousButton
	
	for _, vButton in pairs(self.MinimapButtons) do
		if vPreviousButton and vPreviousButton:IsVisible() then
			self:StackButton(vPreviousButton, vButton)
		end
		
		vPreviousButton = vButton
	end
	
	if vPreviousButton and vPreviousButton:IsVisible() then
		self:StackButton(vPreviousButton, nil)
	end
	
	self:AdjustAlpha()
end

function Mappy:ZoneChangedNewArea()
	SetMapToCurrentZone()
end

function Mappy:GetUIObjectDescription(pUIObject)
	local	vDimensions = math.floor(pUIObject:GetWidth() + 0.5).."x"..math.floor(pUIObject:GetHeight() + 0.5)
	local	vIsShown, vIsVisible
	
	if pUIObject:IsShown() then
		vIsShown = "shown"
	else
		vIsShown = "hidden"
	end
	
	if pUIObject:IsVisible() then
		vIsVisible = "visible"
	else
		vIsVisible = "invisible"
	end
	
	return string.format("%s %s %s %s", vDimensions, pUIObject:GetObjectType(), vIsShown, vIsVisible)
end

function Mappy:ShowFrameTree(pFrame, pFrameLabel, pIndentString)
	local	vNumRegions = pFrame:GetNumRegions()
	local	vNumChildren = pFrame:GetNumChildren()
	
	if not pIndentString then
		pIndentString = ""
	end
	
	if not pFrameLabel then
		Mappy.AnonFrames = {}
		pFrameLabel = pFrame:GetName() or "anonymous"
	end
	
	Mappy:DebugMessage(string.format("%s%s: %s", pIndentString, pFrameLabel, self:GetUIObjectDescription(pFrame)))
	
	local	vIndentString = pIndentString.."    "
	
	if vNumRegions > 0 then
		Mappy:DebugMessage(string.format("%sRegions (%d)", pIndentString, vNumRegions))
		
		for vRegionIndex, vRegion in pairs({pFrame:GetRegions()}) do
			local	vRegionLabel = vRegion:GetName() or ("["..vRegionIndex.."]")
			
			Mappy:DebugMessage(string.format("%s%s: %s", vIndentString, vRegionLabel, self:GetUIObjectDescription(vRegion)))
		end
	end
	
	if vNumChildren > 0 then
		Mappy:DebugMessage(string.format("%sChildren (%d)", pIndentString, vNumChildren))
		
		for vFrameIndex, vFrame in pairs({pFrame:GetChildren()}) do
			local	vFrameName = vFrame:GetName()
			local	vFrameLabel = vFrameName or ("["..vFrameIndex.."]")
			
			if not vFrameName then
				table.insert(Mappy.AnonFrames, vFrame)
			end
			
			if not vFrameName
			and vFrame:GetObjectType() == "Model"
			and vFrame:GetWidth() > 37
			and vFrame:GetWidth() < 39
			and vFrame:GetHeight() > 37
			and vFrame:GetHeight() < 39 then
				Mappy.PlayerArrow = vFrame
			end
			
			self:ShowFrameTree(vFrame, vFrameLabel, vIndentString)
		end
	end
end

function Mappy:IsAnchoredToFrame(pFrame, pAnchoredTo)
	local	vNumPoints = pFrame:GetNumPoints()

	for vPointIndex = 1, vNumPoints do
		local vPoint, vRelativeTo, vRelativePoint, vXOffset, vYOffset = pFrame:GetPoint(vPointIndex)
		
		if vRelativeTo == pAnchoredTo then
			return true
		end
	end
	
	return false
end

function Mappy:IsButtonFrame(pFrame, pAnchoredTo)
	local	vFrameName = pFrame:GetName() or "Anonymous"
	local	vFrameType = pFrame:GetFrameType()
	local	vFrameWidth = pFrame:GetWidth()
	local	vFrameHeight = pFrame:GetHeight()

	if self.IgnoreFrames[vFrameName]
	or self.MinimapButtonsByFrame[pFrame]
	or vFrameType == "Model"
	or vFrameWidth < 24 or vFrameWidth > 48
	or vFrameHeight ~= vFrameWidth then
		return false
	end
	
	if pAnchoredTo and not self:IsAnchoredToFrame(pFrame, pAnchoredTo) then
		return false
	end
	
	-- DEFAULT_CHAT_FRAME:AddMessage("Found minimap button "..vFrameName)
	return true
end

function Mappy:FindAddonButtons(pFrame, pAnchoredTo)
	for _, vFrame in pairs({pFrame:GetChildren()}) do
		if self:IsButtonFrame(vFrame, pAnchoredTo) then
			table.insert(self.MinimapButtons, vFrame)
			self.MinimapButtonsByFrame[vFrame] = true
		end
	end
	
	if not pAnchoredTo then
		self:FindAddonButtons(UIParent, pFrame)
	end
end

function Mappy:Update()
	if not self.CurrentProfile.HideCoordinates then
		self:UpdateCoords()
	end
	
	local	vIndoors = IsIndoors()
	
	if self.wasIndoors ~= vIndoors then
		self.wasIndoors = vIndoors
		self:AdjustAlpha()
	end

	local	vResting = IsResting()
	
	if self.wasResting ~= vResting then
		self.wasResting = vResting
		self:AdjustAlpha()
	end
end

function Mappy:UpdateCoords()
	local	vX, vY = GetPlayerMapPosition("player")
	
	if vX == 0 and vY == 0 then
		self.CoordString:SetText("")
	else
		self.CoordString:SetText(string.format("%.1f, %.1f", vX * 100, vY * 100))
	end
end

function Mappy:AdjustAlpha(pForceAlpha)
	if pForceAlpha then
		Minimap:SetAlpha(pForceAlpha)
	else
		local	vAlpha
		
		if self.InCombat and not self.IsMounted then
			vAlpha = self.CurrentProfile.MinimapCombatAlpha or 0.2
		else
			vAlpha = self.CurrentProfile.MinimapAlpha or 1
		end
		
		-- Force the alpha to 1 if we're indoors.  The minimap doesn't work
		-- properly if the alpha isn't 1 (it'll just show solid black) while
		-- indoors (in this case, indoors means any major city, inside any building, any dungeon)
		-- Detection of 'indoors' is imperfect however, so there are still times that the minimap
		-- will go black when you don't want it to
		
		local	vMinimapIsInteriorMode = IsInInstance() or IsIndoors() or IsResting()
		
		if vAlpha > 0 and vMinimapIsInteriorMode then
			vAlpha = 1
		end

		Minimap:SetAlpha(vAlpha)
	end
end

function Mappy:ZoneChanged()
	self:AdjustAlpha()
end

function Mappy:RegenEnabled()
	self.InCombat = false
	self:AdjustAlpha()
end

function Mappy:RegenDisabled()
	self.InCombat = true
	self:AdjustAlpha()
end

function Mappy:UpdateMountedState()
	local	vIsMounted = IsMounted()
	
	if (self.IsMounted == vIsMounted) then
		return
	end
	
	self.IsMounted = vIsMounted
	self:AdjustAlpha()
end

function Mappy:InitializeSettingsDialog()
	self.SettingsDialog = CreateFrame("Frame", nil, MinimapCluster)
	self.SettingsDialog:SetFrameStrata("DIALOG")
	
	self.SettingsDialog:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}})

	self.SettingsDialog:SetBackdropBorderColor(0.75, 0.75, 0.75)
	self.SettingsDialog:SetBackdropColor(0, 0, 0, 0.9)
	self.SettingsDialog:SetAlpha(1)
	
	self.SettingsDialog:SetWidth(180)
	self.SettingsDialog:SetHeight(330)
	
	-- Size slider
	
	self.SizeSlider = CreateFrame("Slider", "MappySizeSlider", self.SettingsDialog, "OptionsSliderTemplate")
	self.SizeSlider:SetPoint("TOPLEFT", self.SettingsDialog, "TOPLEFT", 15, -20)
	self.SizeSlider:SetMinMaxValues(80, 1000)
	self.SizeSlider:SetScript("OnValueChanged", function () Mappy:SetMinimapSize(this:GetValue()) end)
	getglobal("MappySizeSliderText"):SetText("Size")
	getglobal("MappySizeSliderLow"):SetText("Small")
	getglobal("MappySizeSliderHigh"):SetText("Large")
	
	-- Alpha slider
	
	self.AlphaSlider = CreateFrame("Slider", "MappyAlphaSlider", self.SettingsDialog, "OptionsSliderTemplate")
	self.AlphaSlider:SetPoint("TOPLEFT", self.SizeSlider, "BOTTOMLEFT", 0, -30)
	self.AlphaSlider:SetScript("OnValueChanged", function () Mappy:SetMinimapAlpha(this:GetValue()) end)
	getglobal("MappyAlphaSliderText"):SetText("Alpha")
	self.AlphaSlider:SetMinMaxValues(0, 1)
	
	-- Combat alpha slider
	
	self.CombatAlphaSlider = CreateFrame("Slider", "MappyCombatAlphaSlider", self.SettingsDialog, "OptionsSliderTemplate")
	self.CombatAlphaSlider:SetPoint("TOPLEFT", self.AlphaSlider, "BOTTOMLEFT", 0, -30)
	self.CombatAlphaSlider:SetScript("OnValueChanged", function () Mappy:SetMinimapCombatAlpha(this:GetValue()) end)
	getglobal("MappyCombatAlphaSliderText"):SetText("Combat Alpha")
	self.CombatAlphaSlider:SetMinMaxValues(0, 1)
	
	-- Hide time-of-day
	
	self.HideTimeOfDayCheckbutton = CreateFrame("Checkbutton", "MappyHideTimeOfDayCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate")
	self.HideTimeOfDayCheckbutton:SetPoint("TOPLEFT", self.CombatAlphaSlider, "BOTTOMLEFT", -5, -15)
	self.HideTimeOfDayCheckbutton:SetScript("OnShow", function () this:SetChecked(self.CurrentProfile.HideTimeOfDay) end)
	self.HideTimeOfDayCheckbutton:SetScript("OnClick", function () Mappy:SetHideTimeOfDay(this:GetChecked()) end)
	MappyHideTimeOfDayCheckbuttonText:SetText("Hide time of day")
	
	-- Hide zoom in/out

	self.HideZoomCheckbutton = CreateFrame("Checkbutton", "MappyHideZoomCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate")
	self.HideZoomCheckbutton:SetPoint("TOPLEFT", self.HideTimeOfDayCheckbutton, "BOTTOMLEFT", 0, 7)
	self.HideZoomCheckbutton:SetScript("OnShow", function () this:SetChecked(self.CurrentProfile.HideZoom) end)
	self.HideZoomCheckbutton:SetScript("OnClick", function () Mappy:SetHideZoom(this:GetChecked()) end)
	MappyHideZoomCheckbuttonText:SetText("Hide zoom buttons")

	-- Hide world map button

	self.HideWorldMapCheckbutton = CreateFrame("Checkbutton", "MappyHideWorldMapCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate")
	self.HideWorldMapCheckbutton:SetPoint("TOPLEFT", self.HideZoomCheckbutton, "BOTTOMLEFT", 0, 7)
	self.HideWorldMapCheckbutton:SetScript("OnShow", function () this:SetChecked(self.CurrentProfile.HideWorldMap) end)
	self.HideWorldMapCheckbutton:SetScript("OnClick", function () Mappy:SetHideWorldMap(this:GetChecked()) end)
	MappyHideWorldMapCheckbuttonText:SetText("Hide world map button")

	-- Hide coordinates

	self.HideCoordinatesCheckbutton = CreateFrame("Checkbutton", "MappyHideCoordinatesCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate")
	self.HideCoordinatesCheckbutton:SetPoint("TOPLEFT", self.HideWorldMapCheckbutton, "BOTTOMLEFT", 0, 7)
	self.HideCoordinatesCheckbutton:SetScript("OnShow", function () this:SetChecked(self.CurrentProfile.HideCoordinates) end)
	self.HideCoordinatesCheckbutton:SetScript("OnClick", function () Mappy:SetHideCoordinates(this:GetChecked()) end)
	MappyHideCoordinatesCheckbuttonText:SetText("Hide coordinates")

	-- Hide zone name

	self.HideZoneNameCheckbutton = CreateFrame("Checkbutton", "MappyHideZoneNameCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate")
	self.HideZoneNameCheckbutton:SetPoint("TOPLEFT", self.HideCoordinatesCheckbutton, "BOTTOMLEFT", 0, 7)
	self.HideZoneNameCheckbutton:SetScript("OnShow", function () this:SetChecked(self.CurrentProfile.HideZoneName) end)
	self.HideZoneNameCheckbutton:SetScript("OnClick", function () Mappy:SetHideZoneName(this:GetChecked()) end)
	MappyHideZoneNameCheckbuttonText:SetText("Hide zone name")

	-- Lock position

	self.LockPositionCheckbutton = CreateFrame("Checkbutton", "MappyLockPositionCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate")
	self.LockPositionCheckbutton:SetPoint("TOPLEFT", self.HideZoneNameCheckbutton, "BOTTOMLEFT", 0, 7)
	self.LockPositionCheckbutton:SetScript("OnShow", function () this:SetChecked(self.CurrentProfile.LockPosition) end)
	self.LockPositionCheckbutton:SetScript("OnClick", function () Mappy:SetLockPosition(this:GetChecked()) end)
	MappyLockPositionCheckbuttonText:SetText("Lock position")

	-- Addon button stacking

	self.AutoStackCheckbutton = CreateFrame("Checkbutton", "MappyAutoStackCheckbutton", self.SettingsDialog, "OptionsCheckButtonTemplate")
	self.AutoStackCheckbutton:SetPoint("TOPLEFT", self.LockPositionCheckbutton, "BOTTOMLEFT", 0, 7)
	self.AutoStackCheckbutton:SetScript("OnShow", function () this:SetChecked(self.CurrentProfile.AutoArrangeButtons) end)
	self.AutoStackCheckbutton:SetScript("OnClick", function () this:SetAutoArrangeButtons(this:GetChecked()) end)
	MappyAutoStackCheckbuttonText:SetText("Auto-arrange buttons")
end

function Mappy:SetHideTimeOfDay(pHide)
	if pHide then
		self.CurrentProfile.HideTimeOfDay = true
		GameTimeFrame:Hide()
	else
		self.CurrentProfile.HideTimeOfDay = nil
		GameTimeFrame:Show()
	end
end

function Mappy:SetHideZoom(pHide)
	if pHide then
		self.CurrentProfile.HideZoom = true
		MinimapZoomIn:Hide()
		MinimapZoomOut:Hide()
	else
		self.CurrentProfile.HideZoom = nil
		MinimapZoomIn:Show()
		MinimapZoomOut:Show()
	end
end

function Mappy:SetHideWorldMap(pHide)
	if pHide then
		self.CurrentProfile.HideWorldMap = true
		MiniMapWorldMapButton:Hide()
	else
		self.CurrentProfile.HideWorldMap = nil
		MiniMapWorldMapButton:Show()
	end
end

function Mappy:SetHideCoordinates(pHide)
	if pHide then
		self.CurrentProfile.HideCoordinates = true
		self.CoordString:SetText("")
	else
		self.CurrentProfile.HideCoordinates = nil
	end
end

function Mappy:SetHideZoneName(pHide)
	if pHide then
		self.CurrentProfile.HideZoneName = true
		MinimapZoneTextButton:Hide()
	else
		self.CurrentProfile.HideZoneName = nil
		MinimapZoneTextButton:Show()
	end
end

function Mappy:SetLockPosition(pLock)
	if pLock then
		self.CurrentProfile.LockPosition = true
	else
		self.CurrentProfile.LockPosition = nil
	end
end

function Mappy:SetAutoArrangeButtons(pEnable)
	if pEnable then
		self.CurrentProfile.AutoArrangeButtons = true
		self:EnableButtonStacking()
	else
		self.CurrentProfile.AutoArrangeButtons = nil
		self:DisableButtonStacking()
	end
end

function Mappy:ShowSettingsDialog()
	if not self.SettingsDialog then
		self:InitializeSettingsDialog()
	end
	
	self.DisableUpdates = true
	self.SizeSlider:SetValue(self.CurrentProfile.MinimapSize or 140)
	self.AlphaSlider:SetValue(self.CurrentProfile.MinimapAlpha or 1)
	self.CombatAlphaSlider:SetValue(self.CurrentProfile.MinimapCombatAlpha or 0.2)
	self.DisableUpdates = false
	
	-- Put the dialog under the cursor
	
	local	vCursorX, vCursorY = GetCursorPosition()
	local	vUIScale = UIParent:GetScale()
	
	vCursorX = vCursorX / vUIScale
	vCursorY = vCursorY / vUIScale
	
	self.SettingsDialog:ClearAllPoints()
	
	local	vAnchorPoint
	
	if vCursorY < 0.5 * (UIParent:GetTop() + UIParent:GetBottom()) then
		vAnchorPoint = "BOTTOM"
	else
		vAnchorPoint = "TOP"
	end
	
	self.SettingsDialog:SetPoint(vAnchorPoint, UIParent, "BOTTOMLEFT", vCursorX, vCursorY)
	self.SettingsDialog:Show()
end

function Mappy:HideSettingsDialog()
	if not self.SettingsDialog
	or not self.SettingsDialog:IsVisible() then
		return false
	end

	self.SettingsDialog:Hide()
	self:AdjustAlpha()
	
	return true
end

function Mappy:EscapePressed()
	local	vClosed = self.Orig_StaticPopup_EscapePressed()

	if Mappy:HideSettingsDialog() then
		vClosed = 1
	end
	
	return vClosed
end

function Mappy.Button_OnHide(...)
	local	vResult
	
	if this.Mappy_OnHide then
		vResult = this.Mappy_OnHide(...)
	end
	
	MCSchedulerLib:ScheduleUniqueTask(0, Mappy.ConfigureMinimap, Mappy)
	
	return vResult
end

function Mappy.Button_OnShow(...)
	local	vResult
	
	if this.Mappy_OnShow then
		vResult = this.Mappy_OnShow(...)
	end
	
	MCSchedulerLib:ScheduleUniqueTask(0, Mappy.ConfigureMinimap, Mappy)
	
	return vResult
end

function Mappy_Minimap_OnClick()
	if arg1 == "RightButton" then
		if Mappy.SettingsDialog
		and Mappy.SettingsDialog:IsVisible() then
			Mappy:HideSettingsDialog()
		else
			Mappy:ShowSettingsDialog()
		end
	else
		Mappy:HideSettingsDialog()
		
		local vCenterX, vCenterY = this:GetCenter()
		local vX, vY = GetCursorPosition()
		
		Minimap:PingLocation(
				vX / this:GetEffectiveScale() - vCenterX,
				vY / this:GetEffectiveScale() - vCenterY)
	end
end

function Mappy:MinimapMouseWheel(pWheelDirection)
	local	vZoom = Minimap:GetZoom()
	
	if pWheelDirection > 0 then
		if vZoom < (Minimap:GetZoomLevels() - 1) then
			Minimap:SetZoom(vZoom + 1)
		end
		
		MinimapZoomOut:Enable()
		
		if Minimap:GetZoom() == (Minimap:GetZoomLevels() - 1) then
			MinimapZoomIn:Disable()
		end
	else
		if vZoom > 0 then
			Minimap:SetZoom(vZoom - 1)
		end

		MinimapZoomIn:Enable()
		
		if Minimap:GetZoom() == 0 then
			MinimapZoomOut:Disable()
		end
	end
end

function Mappy:StartMovingMinimap()
	if self.CurrentProfile.LockPosition then
		return
	end
	
	-- Hide settings
	
	Mappy:HideSettingsDialog()
	
	-- Enable moving
	
	MinimapCluster.SetPoint = MinimapCluster.Mappy_SetPoint
	MinimapCluster.ClearAllPoints = MinimapCluster.Mappy_ClearAllPoints
	
	-- Start moving
	
	MinimapCluster:StartMoving()
end

function Mappy:StopMovingMinimap()
	if self.CurrentProfile.LockPosition then
		return
	end
	
	-- Stop moving
	
	MinimapCluster:StopMovingOrSizing()
	
	-- Disable moving
	
	MinimapCluster.SetPoint = function () end
	MinimapCluster.ClearAllPoints = function () end
	
	-- Save the new position
	
	MinimapCluster:SetUserPlaced(true) -- Must leave this true or UIParent will screw up laying out windows
	
	local	vRight = MinimapCluster:GetRight()
	local	vTop = MinimapCluster:GetTop()
	
	self.CurrentProfile.MinimapRightOffset = vRight - UIParent:GetRight()
	self.CurrentProfile.MinimapTopOffset = vTop - UIParent:GetTop()

	MinimapCluster:Mappy_ClearAllPoints()
	MinimapCluster:Mappy_SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", self.CurrentProfile.MinimapRightOffset, self.CurrentProfile.MinimapTopOffset)
end

function Mappy.ReanchorTemporyEnchantFrame()
	TemporaryEnchantFrame:ClearAllPoints()
	TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -15, 0)
end

function Mappy.SetFrameLevel(pFrame, pLevel)
	local	vOldLevel = pFrame:GetFrameLevel()
	
	pFrame:SetFrameLevel(pLevel)
	
	local	vChildren = {pFrame:GetChildren()}
	
	for _, vChildFrame in pairs(vChildren) do
		Mappy.SetFrameLevel(vChildFrame, pLevel + (vChildFrame:GetFrameLevel() - vOldLevel))
	end
end

MCEventLib:RegisterEvent("VARIABLES_LOADED", Mappy.VariablesLoaded, Mappy)
