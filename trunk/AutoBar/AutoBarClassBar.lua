--
-- AutoBarClassBar
-- Copyright 2007+ Toadkiller of Proudmoore.
-- A lot of code borrowed from Bartender3
--
-- Layout Bars for AutoBar
-- Layout Bars logically organize similar buttons and provide for layout options for the Bar and its Buttons
-- Sticky dragging is provided as well
-- http://code.google.com/p/autobar/
--

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 55034 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("AutoBar")
local LBS = LibStub("LibBabble-Spell-3.0")
local BS = LBS:GetLookupTable()
local LibStickyFrames = LibStub("LibStickyFrames-1.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local _G = getfenv(0)

-- List of Bars for the current user
AutoBar.barList = {}

if not AutoBar.Class then
	AutoBar.Class = {}
end

-- Basic Bar that can do the classic AutoBar layout grid
-- Provides snapto when dragging layouts
AutoBar.Class.Bar = AceOO.Class("AceEvent-2.0")


function AutoBar.Class.Bar.prototype:init(barKey)
	AutoBar.Class.Bar.super.prototype.init(self) -- very important. Will fail without this.

	self.barKey = barKey
	self.config = AutoBar:GetDB().bars[barKey]
	self.barname = L[barKey]
--	if self.statebar and self.id == 1 then self.mainbar = true end

	self:CreateBarFrame()

	self.buttonList = {}		-- Button by index
	self.activeButtonList = {}	-- Button by index, non-empty & enabled ones only
	self:UpdateObjects()
end

function AutoBar.Class.Bar.prototype:CreateBarFrame()
	local name = self.barKey .. "Driver"
	local driver = CreateFrame("Button", name, UIParent, "SecureStateDriverTemplate")
	driver.class = self
	driver:EnableMouse(false)
	driver:SetMovable(true)
	driver:RegisterForDrag("LeftButton")
	driver:RegisterForClicks("RightButtonDown", "LeftButtonUp")
	driver:SetWidth(10)
	driver:SetHeight(10)
	driver:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},})
	driver:SetBackdropColor(0, 1, 1, 0)
	driver:ClearAllPoints()
	driver:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	driver.text = driver:CreateFontString(nil, "ARTWORK")
	driver.text:SetFontObject(GameFontNormal)
	driver.text:SetText()
	driver.text:Show()
	driver.text:ClearAllPoints()
	driver.text:SetPoint("CENTER", driver, "CENTER", 0, 0)
	if (self.config.hide) then
		driver:Hide()
	else
		driver:Show()
	end
	self.frame = driver

	-- For debugging
	driver.StateChanged = AutoBar.StateChanged

	self.elapsed = 0
	if (self.config.fadeOut) then
	end
--AutoBar:Print(tostring(driver) .. " Driver: UIParent")
end

-- Refresh the Bar
-- New buttons are added, unused ones removed
function AutoBar.Class.Bar.prototype:UpdateObjects()
	local buttonList = self.buttonList
	local buttonDBList = AutoBar:GetDB(self.barKey).buttons

	-- Create or Refresh the Bar's Buttons
	for buttonDBIndex, buttonDB in ipairs(buttonDBList) do
		if (buttonDB.enabled) then
			-- Recover from disabled cache
			if (AutoBar.buttonListDisabled[buttonDB.name]) then
				AutoBar.buttonList[buttonDB.name] = AutoBar.buttonListDisabled[buttonDB.name]
				AutoBar.buttonListDisabled[buttonDB.name] = nil
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateObjects Thaw " .. tostring(buttonDB.name) .. " <-- buttonListDisabled")
			end

			if (AutoBar.buttonList[buttonDB.name]) then
				buttonList[buttonDBIndex] = AutoBar.buttonList[buttonDB.name]
				buttonList[buttonDBIndex]:Refresh(self, buttonDB)
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateObjects existing buttonDBIndex " .. tostring(buttonDBIndex) .. " buttonDB.name " .. tostring(buttonDB.name))
			else
				buttonList[buttonDBIndex] = AutoBar.Class[buttonDB.buttonClass]:new(self, buttonDB)
				AutoBar.buttonList[buttonDB.name] = buttonList[buttonDBIndex]
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateObjects new buttonDBIndex " .. tostring(buttonDBIndex) .. " buttonDB.name " .. tostring(buttonDB.name))
			end
		else
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateObjects Disabled " .. tostring(buttonDB.name) .. " --> buttonListDisabled ?")
			-- Move to disabled cache
			if (AutoBar.buttonList[buttonDB.name]) then
				buttonList[buttonDBIndex] = AutoBar.buttonList[buttonDB.name]
				buttonList[buttonDBIndex]:Refresh(self, buttonDB)
				AutoBar.buttonListDisabled[buttonDB.name] = AutoBar.buttonList[buttonDB.name]
				AutoBar.buttonList[buttonDB.name] = nil
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateObjects Freeze " .. tostring(buttonDB.name) .. " --> buttonListDisabled")
			elseif (AutoBar.buttonListDisabled[buttonDB.name]) then
				buttonList[buttonDBIndex] = AutoBar.buttonListDisabled[buttonDB.name]
				buttonList[buttonDBIndex]:Refresh(self, buttonDB)
			else
				buttonList[buttonDBIndex] = AutoBar.Class[buttonDB.buttonClass]:new(self, buttonDB)
				AutoBar.buttonListDisabled[buttonDB.name] = buttonList[buttonDBIndex]
			end
		end
	end

	-- Trim Excess
	for buttonIndex = # buttonList, # buttonDBList + 1, -1 do
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateObjects Trim " .. tostring(buttonList[buttonIndex].buttonDB.name) .. " buttonIndex " .. tostring(buttonIndex))
		buttonList[buttonIndex] = nil
	end

end
--/dump AutoBar.buttonList["CustomButton33"]
--/dump AutoBar.buttonList["AutoBarButtonBandages"]
--/dump AutoBar.buttonList["CustomButton28"]:IsActive()
--/dump AutoBar.buttonListDisabled["CustomButton30"]:IsActive()
--/script AutoBar.buttonListDisabled["CustomButton30"].frame:Show()
--/dump AutoBar.barList["AutoBarClassBarBasic"].buttonList[24].buttonName
--/script AutoBar.barList["AutoBarClassBarBasic"]:UpdateActive()
--/dump (# AutoBar.barList["AutoBarClassBarBasic"].activeButtonList)
--/dump (# AutoBar.barList["AutoBarClassBarBasic"].buttonList)
--/dump (# AutoBar:GetDB("AutoBarClassBarBasic").buttons)
--/dump (# AutoBar.buttonList)
--/dump (# AutoBar.buttonListDisabled)


-- Based on the current Scan results, update the Button and Popup Attributes
-- Create Popup Buttons as needed
function AutoBar.Class.Bar.prototype:UpdateAttributes()
	local buttonList = self.buttonList
	local buttonDBList = AutoBar:GetDB(self.barKey).buttons

	-- Create or Refresh the Bar's Buttons
	for buttonIndex, button in ipairs(buttonList) do
		button:SetupButton()
	end
end


-- The activeButtonList contains only active buttons.  Make it so.
function AutoBar.Class.Bar.prototype:UpdateActive()
	local activeButtonList = self.activeButtonList
	local buttonDBList = self.config.buttons
	local maxButtons = # self.buttonList
	local activeIndex = 1
	local maxActiveButtons = self.config.rows * self.config.columns

--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateActive maxButtons " .. tostring(maxButtons))
	for index = 1, maxButtons, 1 do
		local button = self.buttonList[index]
		if (button and button:IsActive()) then
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateActive Active " .. tostring(activeIndex) .. " " .. tostring(button.buttonName))
			activeButtonList[activeIndex] = button
			activeIndex = activeIndex + 1
			button.frame:Show()
		elseif (button) then
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateActive Inactive " .. tostring(index))
			button.frame:Hide()
		end
	end

	-- Ditch buttons in excess of rows * columns
	if ((activeIndex - 1) > maxActiveButtons and not AutoBar.unlockButtons) then
--AutoBar:Print("AutoBar.Class.Bar.prototype:UpdateActive activeIndex " .. tostring(activeIndex - 1) .. " maxActiveButtons " .. tostring(maxActiveButtons) .. " = rows " .. tostring(self.config.rows) .. " columns " .. tostring(self.config.columns))
		activeIndex = maxActiveButtons + 1
	end

	-- Trim Excess
	for i = activeIndex, # activeButtonList, 1 do
		local button = activeButtonList[i]
		button:Disable()
		activeButtonList[i] = nil
	end
end
-- /dump AutoBar.buttonListDisabled
-- /dump (# AutoBar.buttonList)
-- /dump (# AutoBar.barList["AutoBarClassBarBasic"].buttonList)
-- /dump AutoBar.barList["AutoBarClassBarBasic"].buttonList[6]
-- /dump AutoBar.barList["AutoBarClassBarBasic"].activeButtonList[10]
-- /script AutoBar.barList["AutoBarClassBarBasic"].activeButtonList[4].frame:SetChecked(1)


function AutoBar.Class.Bar.prototype:OnUpdate(elapsed)
--AutoBar:Print("AutoBar.Class.Bar.prototype:OnUpdate self.config.fadeOut " .. tostring(self.config.fadeOut))
	if (self.config.fadeOut) then
		if (MouseIsOver(self.frame) and self.faded) then
			self.frame:SetAlpha(self.config.alpha)
			self.faded = nil
			if (# self.buttonList > 0) then
				for index, button in pairs(self.buttonList) do
					button:UpdateCooldown()
				end
			end
		elseif (not MouseIsOver(self.frame) and not self.faded) then
			self.frame:SetAlpha(0)
			self.faded = true
			for index, button in pairs(self.buttonList) do
				if (button.frame.cooldown) then
					button.frame.cooldown:Hide()
				end
			end
		end
	end
end

function AutoBar.Class.Bar.prototype:SetFadeOut(fadeOut)
	self.config.fadeOut = fadeOut
	self.faded = nil
	if not fadeOut then
		self.frame:SetAlpha(self.config.alpha)
	else
	end
end

local function onEnterFunc(bar)
	if (bar.class.isStickTarget and AutoBar.stickyMode) then
		bar:SetBackdropColor(LibStickyFrames.ColorStickTargetHover.r, LibStickyFrames.ColorStickTargetHover.g, LibStickyFrames.ColorStickTargetHover.b, LibStickyFrames.ColorStickTargetHover.a)
	elseif (bar.class.config.hide and AutoBar.stickyMode) then
		bar:SetBackdropColor(LibStickyFrames.ColorHiddenHover.r, LibStickyFrames.ColorHiddenHover.g, LibStickyFrames.ColorHiddenHover.b, LibStickyFrames.ColorHiddenHover.a)
	elseif (AutoBar.stickyMode) then
		bar:SetBackdropColor(LibStickyFrames.ColorEnabledHover.r, LibStickyFrames.ColorEnabledHover.g, LibStickyFrames.ColorEnabledHover.b, LibStickyFrames.ColorEnabledHover.a)
	end
end

local function onLeaveFunc(bar)
	if (bar.class.isStickTarget and AutoBar.stickyMode) then
		bar:SetBackdropColor(LibStickyFrames.ColorStickTarget.r, LibStickyFrames.ColorStickTarget.g, LibStickyFrames.ColorStickTarget.b, LibStickyFrames.ColorStickTarget.a)
	elseif (bar.class.config.hide and AutoBar.stickyMode) then
		bar:SetBackdropColor(LibStickyFrames.ColorHidden.r, LibStickyFrames.ColorHidden.g, LibStickyFrames.ColorHidden.b, LibStickyFrames.ColorHidden.a)
	elseif (AutoBar.stickyMode) then
		bar:SetBackdropColor(LibStickyFrames.ColorEnabled.r, LibStickyFrames.ColorEnabled.g, LibStickyFrames.ColorEnabled.b, LibStickyFrames.ColorEnabled.a)
	end
end

function AutoBar.Class.Bar.prototype:StickTo(frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
	LibStickyFrames:StickToFrame(frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
	self.config.stickPoint = point
	self.config.stickToFrameName = stickToFrame:GetName()
--AutoBar:Print("AutoBar.Class.Bar.prototype:StickTo " .. tostring(self.config.stickToFrameName))
	self.config.stickToPoint = stickToPoint
	self.config.stickToX = stickToX
	self.config.stickToY = stickToY
end

local function onStickFunc(self, frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
--AutoBar:Print("onStickFunc " .. tostring(self.barname) .. " frame " .. tostring(frame) .. " point " .. tostring(point) .. " stickToFrame " .. tostring(stickToFrame) .. " stickToPoint " .. tostring(stickToPoint))
	self:StickTo(frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
end

local function onStickTargetFunc(stickToFrame, isStickTarget)
--AutoBar:Print("onStickFunc " .. tostring(self.barname) .. " frame " .. tostring(frame) .. " point " .. tostring(point) .. " stickToFrame " .. tostring(stickToFrame) .. " stickToPoint " .. tostring(stickToPoint))
	stickToFrame.class.isStickTarget = isStickTarget
	if (isStickTarget) then
		onEnterFunc(stickToFrame)
	else
		onLeaveFunc(stickToFrame)
	end
end

local stickyInfo = {
	frameList = {},
	left = 0,
	top = 0,
	right = 0,
	bottom = 0,
	stickTargetFunc = onStickTargetFunc,
	stickyModeFunc = AutoBar.SetStickyMode,
}

function AutoBar.Class.Bar:RegisterStickyFrames()
	LibStickyFrames:Register("AutoBar", stickyInfo)
end


local function onDragStartFunc(bar)
	if (AutoBar.db.profile.sticky and LibStickyFrames) then
		local frameList = stickyInfo.frameList
		for k in pairs(frameList) do
			frameList[k] = nil
		end
		for k, bar in pairs(AutoBar.barList) do
			table.insert(frameList, bar.frame)
		end
		LibStickyFrames:StartMoving(bar, onStickFunc, bar.class, nil)
	else
		bar:StartMoving()
	end
	bar:SetBackdropBorderColor(0, 0, 0, 0)
end

local function onDragStopFunc(bar)
	local self = bar.class
	if AutoBar.db.profile.sticky and LibStickyFrames then
		LibStickyFrames:StopMoving(bar)
	else
		bar:StopMovingOrSizing()
	end
	self:SavePosition()
end

local function onClickFunc(bar, button, down)
	local self = bar.class
	if button == "RightButton" then
		self:ShowBarOptions()
	elseif button == "LeftButton" then
		self:ToggleVisibilty()
	end
end

function AutoBar.Class.Bar.prototype:UnlockBars()
	local frame = self.frame
	frame:EnableMouse(true)
	frame:SetScript("OnEnter", onEnterFunc)
	frame:SetScript("OnLeave", onLeaveFunc)
	frame:SetScript("OnDragStart", onDragStartFunc)
	frame:SetScript("OnDragStop", onDragStopFunc)
	frame:SetScript("OnClick", onClickFunc)
	if self.config.hide then
		frame:SetBackdropColor(LibStickyFrames.ColorHidden.r, LibStickyFrames.ColorHidden.g, LibStickyFrames.ColorHidden.b, LibStickyFrames.ColorHidden.a)
	else
		frame:SetBackdropColor(LibStickyFrames.ColorEnabled.r, LibStickyFrames.ColorEnabled.g, LibStickyFrames.ColorEnabled.b, LibStickyFrames.ColorEnabled.a)
	end
	frame:SetFrameLevel(3)
	frame.text:SetText(self.barname)
	frame:Show()
	if self.config.fadeOut then
		frame:SetAlpha(self.config.alpha)
		self.faded = nil
	end
end

function AutoBar.Class.Bar.prototype:LockBars()
	local frame = self.frame
	onDragStopFunc(frame)
	frame:EnableMouse(false)
	frame:SetScript("OnEnter", nil)
	frame:SetScript("OnLeave", nil)
	frame:SetScript("OnDragStart", nil)
	frame:SetScript("OnDragStop", nil)
	frame:SetScript("OnClick", nil)
	frame:SetBackdropColor(0, 0, 0, 0)
	frame:SetBackdropBorderColor(0, 0, 0, 0)
	frame.text:SetText("")
	frame:SetFrameLevel(1)
	if (self.config.hide) then
		self.frame:Hide()
	else
		self.frame:Show()
	end
	if self.config.fadeOut then
	end
end

function AutoBar.Class.Bar.prototype:UnlockButtons()
	for index, button in pairs(self.buttonList) do
		button:UnlockButtons()
	end
end

function AutoBar.Class.Bar.prototype:LockButtons()
	for index, button in pairs(self.buttonList) do
		button:LockButtons()
	end
end


function AutoBar.Class.Bar.prototype:ToggleVisibilty()
	-- Disable during combat
	if (InCombatLockdown()) then
		return
	end

	self.config.hide = not self.config.hide
	if (self.config.hide and AutoBar.stickyMode) then
		self.frame:SetBackdropColor(LibStickyFrames.ColorHidden.r, LibStickyFrames.ColorHidden.g, LibStickyFrames.ColorHidden.b, LibStickyFrames.ColorHidden.a)
	elseif (self.config.hide) then
		self.frame:Hide()
	elseif (AutoBar.stickyMode) then
		self.frame:SetBackdropColor(LibStickyFrames.ColorEnabled.r, LibStickyFrames.ColorEnabled.g, LibStickyFrames.ColorEnabled.b, LibStickyFrames.ColorEnabled.a)
	else
		self.frame:Show()
	end
end

function AutoBar.Class.Bar.prototype:RefreshLayout()
	-- Disable during combat
	if (InCombatLockdown()) then
		return
	end

	self:RefreshScale()
	self:RefreshButtonLayout()
	self:RefreshAlpha()
	self:LoadPosition()
	if (self.config.hide and not AutoBar.stickyMode and self.config.enabled) then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

function AutoBar.Class.Bar.prototype:LoadPosition()
	if (self.config.stickToFrameName and _G[self.config.stickToFrameName]) then
		local stickToFrame = _G[self.config.stickToFrameName]
		local barDB = self.config
		LibStickyFrames:StickToFrame(self.frame, barDB.stickPoint, stickToFrame, barDB.stickToPoint, barDB.stickToX, barDB.stickToY)
--AutoBar:Print("AutoBar.Class.Bar.prototype:LoadPosition " .. tostring(barDB.stickToFrameName))
	else
		local x, y, s = self.config.posX, self.config.posY, self.frame:GetEffectiveScale()
		local defaultX = (AutoBar.defaultPositions[self.barKey].posX) or 0
		local defaultY = (AutoBar.defaultPositions[self.barKey].posY) or 0
		local defaultAnchor = AutoBar.defaultPositions[self.barKey].anchor or "BOTTOMLEFT"
		if (x and y) then
			x, y = x/s, y/s
		end
		self.frame:ClearAllPoints()
		self.frame:SetPoint("BOTTOMLEFT", UIParent, x and "BOTTOMLEFT" or defaultAnchor, x or defaultX, y or defaultY)
	end
end

function AutoBar.Class.Bar.prototype:SavePosition()
	local frame = self.frame
	local x, y = frame:GetLeft(), frame:GetBottom()
	local s = frame:GetEffectiveScale()
	x, y = x * s, y * s
	self.config.posX = x
	self.config.posY = y
end


-- Translate the alignButtons setting
local function getAlignPoint(alignButtons)
	local alignPoint, columnRelativePoint, rowRelativePoint, signX, signY

	if (alignButtons == "3") then
		alignPoint = "BOTTOMLEFT"
		rowRelativePoint = "BOTTOMRIGHT"
		columnRelativePoint = "TOPLEFT"
		signX, signY = 1, 1
	elseif (alignButtons == "6") then
		alignPoint = "BOTTOMLEFT"
		rowRelativePoint = "BOTTOMRIGHT"
		columnRelativePoint = "TOPLEFT"
		signX, signY = 1, 1
	elseif (alignButtons == "9") then
		alignPoint = "BOTTOMRIGHT"
		rowRelativePoint = "BOTTOMLEFT"
		columnRelativePoint = "TOPRIGHT"
		signX, signY = -1, 1
	elseif (alignButtons == "8") then
		alignPoint = "BOTTOMRIGHT"
		rowRelativePoint = "BOTTOMLEFT"
		columnRelativePoint = "TOPRIGHT"
		signX, signY = -1, 1
	elseif (alignButtons == "5") then
		alignPoint = "BOTTOMLEFT"
		rowRelativePoint = "BOTTOMRIGHT"
		columnRelativePoint = "TOPLEFT"
		signX, signY = 1, 1
	elseif (alignButtons == "2") then
		alignPoint = "BOTTOMLEFT"
		rowRelativePoint = "BOTTOMRIGHT"
		columnRelativePoint = "TOPLEFT"
		signX, signY = 1, 1
	elseif (alignButtons == "7") then
		alignPoint = "TOPRIGHT"
		rowRelativePoint = "TOPLEFT"
		columnRelativePoint = "BOTTOMRIGHT"
		signX, signY = -1, -1
	elseif (alignButtons == "4") then
		alignPoint = "TOPLEFT"
		rowRelativePoint = "TOPRIGHT"
		columnRelativePoint = "BOTTOMLEFT"
		signX, signY = 1, -1
	elseif (alignButtons == "1") then
		alignPoint = "TOPLEFT"
		rowRelativePoint = "TOPRIGHT"
		columnRelativePoint = "BOTTOMLEFT"
		signX, signY = 1, -1
	end
	return alignPoint, rowRelativePoint, columnRelativePoint, signX, signY
end

--	["1"] = L["TOPLEFT"],
--	["2"] = L["LEFT"],
--	["3"] = L["BOTTOMLEFT"],
--	["4"] = L["TOP"],
--	["5"] = L["CENTER"],
--	["6"] = L["BOTTOM"],
--	["7"] = L["TOPRIGHT"],
--	["8"] = L["RIGHT"],
--	["9"] = L["BOTTOMRIGHT"],

-- Get offsets for any of the centered options of alignButtons
local function getCenterShift(alignButtons, signX, signY, rows, columns, displayedRows, displayedColumns, buttonWidth, buttonHeight, padding)
	local centerShiftX = 0
	local centerShiftY = 0

	local x = buttonWidth + padding
	local y = buttonHeight + padding

	if (alignButtons == "6") then
		centerShiftX = signX * (columns - displayedColumns) * ((buttonWidth + padding)) / 2
	elseif (alignButtons == "8") then
		centerShiftY = signY * (rows - displayedRows) * ((buttonHeight + padding)) / 2
	elseif (alignButtons == "5") then
		centerShiftX = signX * (columns - displayedColumns) * ((buttonWidth + padding)) / 2
		centerShiftY = signY * (rows - displayedRows) * ((buttonHeight + padding)) / 2
	elseif (alignButtons == "2") then
		centerShiftY = signY * (rows - displayedRows) * ((buttonHeight + padding)) / 2
	elseif (alignButtons == "4") then
		centerShiftX = signX * (columns - displayedColumns) * ((buttonWidth + padding)) / 2
	end
	return centerShiftX, centerShiftY
end


-- Lay out the buttons in the rows, columns grid specified
-- Collapse holes if collapseButtons is true
-- Obey the alignment options in alignButtons
function AutoBar.Class.Bar.prototype:RefreshButtonLayout()
	local buttons = # self.buttonList
	local rows = self.config.rows or 1
	local columns = self.config.columns or 24
	local buttonWidth, buttonHeight, padding = AutoBar:GetButtonSize(self.barKey)
	local alignButtons = self.config.alignButtons or "3"
	local alignPoint, rowRelativePoint, columnRelativePoint, signX, signY = getAlignPoint(alignButtons)
	local collapseButtons = self.config.collapseButtons

	self.frame:SetWidth(buttonWidth * columns + ((columns - 1) * padding))
	self.frame:SetHeight(buttonHeight * rows + ((rows - 1) * padding))

	local anchorFrame = self.frame

	local activeButtonList = self.activeButtonList

	local displayedRows = math.floor((# activeButtonList - 1) / columns) + 1
	local displayedColumns = math.min(# activeButtonList, columns)
	local centerShiftX, centerShiftY = getCenterShift(alignButtons, signX, signY, rows, columns, displayedRows, displayedColumns, buttonWidth, buttonHeight, padding)

--AutoBar:Print("AutoBar.Class.Bar.prototype:RefreshButtonLayout displayedRows " .. tostring(displayedRows) .. " displayedColumns " .. tostring(displayedColumns) .. " centerShiftX " .. tostring(centerShiftX) .. " centerShiftY " .. tostring(centerShiftY))

	for i = 1, # activeButtonList do
		local frame = activeButtonList[i].frame
		frame:ClearAllPoints()
		frame:SetPoint(alignPoint, anchorFrame, alignPoint, ((i - 1) % columns) * signX * (buttonWidth + padding) + signX * padding + centerShiftX, (math.floor((i - 1) / columns)) * signY * (buttonHeight + padding) + signY * padding + centerShiftY)
	end
end


function AutoBar.Class.Bar.prototype:RefreshStyle()
	local style = self.config.style
--AutoBar:Print("AutoBar.Class.Bar.prototype:RefreshStyle #  " .. tostring(# self.activeButtonList))
	for index, button in pairs(self.buttonList) do
		AutoBar:RefreshStyle(button.frame, self)
		local popupHeader = button.frame.popupHeader
		if (popupHeader) then
			local popupButtonList = popupHeader.popupButtonList
			for popupButtonIndex, popupButton in pairs(popupButtonList) do
				AutoBar:RefreshStyle(popupButton.frame, self)
			end
		end
	end
end

function AutoBar.Class.Bar.prototype:RefreshScale()
	self.frame:SetScale(self.config.scale or 1)
	self:LoadPosition()
end

function AutoBar.Class.Bar.prototype:RefreshAlpha()
	for index, button in pairs(self.buttonList) do
		button.frame:SetAlpha(self.config.alpha or 1)
	end
end


-- Remove a button from the Bar
function AutoBar.Class.Bar.prototype:ButtonRemove(buttonDB)
	for i, button in pairs(self.buttonList) do
		if (button.buttonDB == buttonDB) then
			button.frame:SetAttribute("showstates", nil)
			button.frame:SetAttribute("hidestates", "*")
			button.frame:SetAttribute("category", nil)
			button.frame:SetAttribute("itemId", nil)
			button.frame:Hide()

			if (AutoBar.buttonListDisabled[buttonDB.name]) then
				AutoBar.buttonListDisabled[buttonDB.name] = nil
			end
			if (AutoBar.buttonList[buttonDB.name]) then
				AutoBar.buttonList[buttonDB.name] = nil
			end

			for j = i, # self.buttonList, 1 do
				if (self.buttonList[j + 1]) then
					self.buttonList[j] = self.buttonList[j + 1]
					self.buttonList[j + 1] = nil
				end
			end
			break
		end
	end
end


function AutoBar.Class.Bar.prototype:ShowBarOptions()
	if InCombatLockdown() then
		return
	end
	self.optionstable = AutoBar:CreateBarOptions(self.barKey, self.optionstable)
	dewdrop:Open(self.frame, 'children', function() dewdrop:FeedAceOptionsTable(self.optionstable) end, 'cursorX', true, 'cursorY', true)
end

--/dump AutoBar.barList
--/script AutoBarClassBarBasicFrame:Show()
--/script AutoBar.barList["AutoBarClassBarBasic"]:UnlockFrames()
