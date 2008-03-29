--[[
Copyright (c) 2006, Hendrik Leppkes < mail@nevcairiel.net >
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
       copyright notice, this list of conditions and the following
       disclaimer in the documentation and/or other materials provided
       with the distribution.
    * Neither the name of the Bartender3 Development Team nor the names of
       its contributors may be used to endorse or promote products derived
       from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Modified for AutoBar support
Toadkiller 2007
-- http://code.google.com/p/autobar/
]]

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 53552 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")

AutoBar.styleValidateList = {["Default"] = L["Default"], ["Zoomed"] = L["Zoomed"], ["Dreamlayout"] = L["Dreamlayout"]}
AutoBar.styles = {
	["Default"] = { name = L["Default"]},
	["Zoomed"] = { name = L["Zoomed"], coords = {0.07,0.93,0.07,0.93} },
	["Dreamlayout"] = {
		name = L["Dreamlayout"],
		coords = {0.08,0.92,0.08,0.92},
		insetPadding = 3,
		customframe = true,
		FrameFunc = function(button)
			local frame = CreateFrame("Frame", button:GetName().."DL", button)
			frame:ClearAllPoints()
			frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})
			frame:SetBackdropColor(0, 0, 0, 0.6)
			frame:SetAllPoints(button)
			frame:SetFrameLevel(0)
			return frame
		end,
	},
	["cyCircled"] = {
		name = "cyCircled",
		noHotKey = true,
		callbackFunc = nil,
		callbackSelf = nil,
	},
}
-- Button Skinning support needs a style above, as well as a callbackFunc set
-- Setting callbackFunc stops regular formatting
-- Set the style via AutoBar:SetStyle() below
-- If there are missing attributes you want handled let Toadkiller know


function AutoBar:GetButtonSize(barKey, buttonIndex)
	local buttonWidth = AutoBar:GetDB(barKey).buttonWidth
	local buttonHeight = AutoBar:GetDB(barKey).buttonHeight
	local padding = AutoBar:GetDB(barKey).padding
	local style = AutoBar:GetStyle()
	if (style.buttonWidth) then
		buttonWidth = style.buttonWidth
	end
	if (style.buttonHeight) then
		buttonHeight = style.buttonHeight
	end
	if (style.padding) then
		padding = style.padding
	end
	return buttonWidth, buttonHeight, padding
end


function AutoBar:GetStyle()
	return AutoBar.styles[AutoBar:GetDB().style or "Dreamlayout"]
end


-- Set Style to the given key, or insert the new style & set it as well
-- Returns the style index
function AutoBar:SetStyle(newStyle)
	-- Backwards compatibility for cyCircled
	-- ToDo: remove after a bit
	if (type(newStyle) == "number") then
		newStyle = "cyCircled"
	end

	if (type(newStyle) == "string") then
		AutoBar.style = newStyle
	elseif (type(newStyle) == "table") then
		AutoBar.styles[newStyle.name] = newStyle
		AutoBar.style = newStyle.name
		AutoBar.styleValidateList[newStyle.name] = newStyle.name
	end
	if (AutoBar.delay and AutoBar.delay["UpdateStyles"]) then
		AutoBar.delay["UpdateStyles"]:Start()
	end
	return AutoBar.style
end


function AutoBar:RefreshStyle(button, bar)
--AutoBar:Print("AutoBar:RefreshStyle button " .. tostring(button) .. " self.buttonName " .. tostring(button.class.buttonName) .. " bar " .. tostring(bar.barKey))
	if (not button.icon) then
		return
	end

	local style = AutoBar:GetStyle()
	if not style then return end

	if (style == "cyCircled") then
		if not button.overlay then
			button.overlay = getglobal(button.buttonName .. "Overlay")
		end
	end

	if (style.customframe and style.FrameFunc and not button.overlay) then
		if (not button.customframe) then
			button.customframe = style.FrameFunc(button)
		end
	elseif button.customframe then
		button.customframe:Hide()
		button.customframe = nil
	end

	-- cyCircled support
	if (not button:GetAttribute("itemId") and button.class and not button.class.parentBar.config.showGrid) then
		if (button.customframe) then
			button.customframe:Hide()
		end
		if (button.overlay) then
			button.overlay:Hide()
		end
	else
		if (button.customframe) then
			button.customframe:Show()
		end
		if (button.overlay) then
			button.overlay:Show()
		end
	end

	if (button.overlay) then
		return
	end

	local buttonWidth, buttonHeight, padding = self:GetButtonSize(bar.barKey)
	button:SetWidth(buttonWidth)
	button:SetHeight(buttonHeight)

	if (style.noHotKey) then
		if (style.noHotKey == true) then
			button.hotKey:Hide()
		else
			button.hotKey:Show()
		end
	end

	-- Skinning Hook
	if (style.callbackFunc) then
		if (style.callbackSelf) then
			style.callbackFunc(style.callbackSelf, button)
		else
			style.callbackFunc(button)
		end
		return
	end

	-- Regular Styles
	if style.coords then
		button.icon:SetTexCoord(style.coords[1], style.coords[2], style.coords[3], style.coords[4])
	else
		button.icon:SetTexCoord(0, 1, 0, 1)
	end

	button.icon:ClearAllPoints()
	if (style.insetPadding) then
		button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", style.insetPadding, -style.insetPadding)
		button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -style.insetPadding, style.insetPadding)
--AutoBar:Print("AutoBar:RefreshStyle button " .. tostring(button) .. " self.buttonName " .. tostring(button.class.buttonName) .. " bar " .. tostring(bar.barKey))
	else
		button.icon:SetAllPoints(button)
	end
end

--/script AutoBar.barList["AutoBarClassBarBasic"].activeButtonList[1].customframe:Hide()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.normalTexture:Hide()
--/script AutoBar.barList["AutoBarClassBarBasic"].activeButtonList[1]:HideButton()
--/dump AutoBar.barList["AutoBarClassBarBasic"].activeButtonList[4]:IsActive()

--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.flash:Show()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.flash:Hide()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.hotKey:Show()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.hotKey:Hide()

--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.border:Show()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.border:Hide()

--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.icon:Hide()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[3].frame.count:Hide()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.cooldown:Hide()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.macroName:Hide()
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.normalTexture:Hide()

--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.parentBar = nil
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.buttonDB = nil
--/script AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame.class = nil
--/dump AutoBar.barList["AutoBarClassBarBasic"].buttonList[1].frame

