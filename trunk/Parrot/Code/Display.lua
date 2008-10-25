local VERSION = tonumber(("$Revision: 330 $"):match("%d+"))

local Parrot = Parrot
local Parrot_Display = Parrot:NewModule("Display", "LibRockTimer-1.0", "LibRockHook-1.0")
if Parrot.revision < VERSION then
	Parrot.version = "r" .. VERSION
	Parrot.revision = VERSION
	Parrot.date = ("$Date: 2008-05-11 17:44:45 +0200 (Sun, 11 May 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end


--local L = Parrot:L("Parrot_Display")
-- TODO make modular
local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Display")

local SharedMedia = Rock("LibSharedMedia-3.0")

local newList, del = Rock:GetRecyclingFunctions("Parrot", "newList", "del")

local ParrotFrame

Parrot_Display.db = Parrot:GetDatabaseNamespace("Display")
Parrot:SetDatabaseNamespaceDefaults("Display", 'profile', {
	alpha = 1,
	iconAlpha = 1,
	iconsEnabled = true,
	font = "Friz Quadrata TT",
	fontSize = 18,
	fontOutline = "THICKOUTLINE",
	stickyFont = "Friz Quadrata TT",
	stickyFontSize = 26,
	stickyFontOutline = "THICKOUTLINE",
})

local Parrot_AnimationStyles
local Parrot_Suppressions
local Parrot_ScrollAreas
function Parrot_Display:OnEnable()
	Parrot_AnimationStyles = Parrot:GetModule("AnimationStyles")
	Parrot_Suppressions = Parrot:GetModule("Suppressions")
	Parrot_ScrollAreas = Parrot:GetModule("ScrollAreas")
	if not ParrotFrame then
		ParrotFrame = CreateFrame("Frame", "ParrotFrame", UIParent)
		ParrotFrame:SetFrameStrata("HIGH")
		ParrotFrame:SetToplevel(true)
		ParrotFrame:SetPoint("CENTER")
		ParrotFrame:SetWidth(0.0001)
		ParrotFrame:SetHeight(0.0001)
	end
	
	if _G.CombatText_AddMessage then
		self:AddHook("CombatText_AddMessage")
	else
		function _G.CombatText_AddMessage(...)
			self:CombatText_AddMessage(...)
		end
	end
end

function Parrot_Display:OnDisable()
end

-- #NODOC
function Parrot_Display:CombatText_AddMessage(message, scrollFunction, r, g, b, displayType, isStaggered)
	if type(message) ~= "string" then
		return
	end
	if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then
		r, g, b = 1, 1, 1
	end
	self:ShowMessage(message, "Notification", displayType == "crit", r, g, b, nil, nil, nil)
end

function Parrot_Display:OnOptionsCreate()
	local outlineChoices = {
		NONE = L["None"],
		OUTLINE = L["Thin"],
		THICKOUTLINE = L["Thick"],
	}
	
	Parrot.addedOptions.general.args.alpha = {
		type = 'number',
		name = L["Text transparency"],
		desc = L["How opaque/transparent the text should be."],
		min = 0.25,
		max = 1,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
		get = function()
			return self.db.profile.alpha
		end,
		set = function(value)
			self.db.profile.alpha = value
		end
	}
	Parrot.addedOptions.general.args.iconAlpha = {
		type = 'number',
		name = L["Icon transparency"],
		desc = L["How opaque/transparent icons should be."],
		min = 0.25,
		max = 1,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
		get = function()
			return self.db.profile.iconAlpha
		end,
		set = function(value)
			self.db.profile.iconAlpha = value
		end
	}
	Parrot.addedOptions.general.args.enableIcons = {
		type = 'boolean',
		name = L["Enable icons"],
		desc = L["Set whether icons should be enabled or disabled altogether."],
		get = function()
			return self.db.profile.iconsEnabled
		end,
		set = function(value)
			self.db.profile.iconsEnabled = value
		end
	}
	Parrot.addedOptions.general.args.font = {
		type = 'group',
		name = L["Master font settings"],
		desc = L["Master font settings"],
		args = {
			normalFace = {
				type = 'choice',
				name = L["Normal font"],
				desc = L["Normal font face."],
				get = function()
					return Parrot_Display.db.profile.font
				end,
				set = function(value)
					Parrot_Display.db.profile.font = value
				end,
				choices = SharedMedia:List("font"),
				choiceFonts = SharedMedia:HashTable("font"),
			},
			normalSize = {
				type = 'number',
				name = L["Normal font size"],
				desc = L["Normal font size"],
				min = 12,
				max = 32,
				step = 1,
				get = function()
					return Parrot_Display.db.profile.fontSize
				end,
				set = function(value)
					Parrot_Display.db.profile.fontSize = value
				end,
			},
			normalBorder = {
				type = 'choice',
				name = L["Normal outline"],
				desc = L["Normal outline"],
				choices = outlineChoices,
				get = function()
					return Parrot_Display.db.profile.fontOutline
				end,
				set = function(value)
					Parrot_Display.db.profile.fontOutline = value
				end,
			},
			stickyFace = {
				type = 'choice',
				name = L["Sticky font"],
				desc = L["Sticky font face."],
				get = function()
					return Parrot_Display.db.profile.stickyFont
				end,
				set = function(value)
					Parrot_Display.db.profile.stickyFont = value
				end,
				choices = SharedMedia:List("font"),
				choiceFonts = SharedMedia:HashTable("font"),
			},
			stickySize = {
				type = 'number',
				name = L["Sticky font size"],
				desc = L["Sticky font size"],
				min = 12,
				max = 32,
				step = 1,
				get = function()
					return Parrot_Display.db.profile.stickyFontSize
				end,
				set = function(value)
					Parrot_Display.db.profile.stickyFontSize = value
				end,
			},
			stickyBorder = {
				type = 'choice',
				name = L["Sticky outline"],
				desc = L["Sticky outline"],
				choices = outlineChoices,
				get = function()
					return Parrot_Display.db.profile.stickyFontOutline
				end,
				set = function(value)
					Parrot_Display.db.profile.stickyFontOutline = value
				end,
			},
		}
	}
end

local freeFrames = {}
local wildFrames
local frame_num = 0
local frameIDs = {}
local freeTextures = {}
local texture_num = 0
local freeFontStrings = {}
local fontString_num = 0

--[[----------------------------------------------------------------------------------
Arguments:
	string - the text you wish to show.
	[optional] string - the scroll area to show in. Default: "Notification"
	[optional] boolean - whether to show in the sticky-style, e.g. crits. Default: false
	[optional] number - [0, 1] the red part of the color. Default: 1
	[optional] number - [0, 1] the green part of the color. Default: 1
	[optional] number - [0, 1] the blue part of the color. Default: 1
	[optional] string - the font to use (as determined by SharedMedia-1.0). Defaults to the scroll area's setting.
	[optional] number - the font size to use. Defaults to the scroll area's setting.
	[optional] string - the font outline to use. Defaults to the scroll area's setting.
	[optional] string - the icon texture to show alongside the message.
Notes:
	* See :GetScrollAreasValidate() for a validation list of scroll areas.
	* Messages are suppressed if the user has set a specific suppression matching the text.
Example:
	Parrot:ShowMessage("Hello, world!", "Notification", false, 0.5, 0.5, 1)
------------------------------------------------------------------------------------]]
function Parrot_Display:ShowMessage(text, scrollArea, sticky, r, g, b, font, fontSize, outline, icon)
	self = Parrot_Display -- for those who do Parrot:ShowMessage
	if not Parrot:IsModuleActive(self) then
		return
	end
	if Parrot_Suppressions:ShouldSuppress(text) then
		return
	end
	if not Parrot_ScrollAreas:HasScrollArea(scrollArea) then
		if Parrot_ScrollAreas:HasScrollArea("Notification") then
			scrollArea = "Notification"
		else
			scrollArea = Parrot_ScrollAreas:GetRandomScrollArea()
			if not scrollArea then
				return
			end
		end
	end
	
	scrollArea = Parrot_ScrollAreas:GetScrollArea(scrollArea)
	if not sticky then
		if not font then
			font = scrollArea.font or self.db.profile.font
		end
		if not fontSize then
			fontSize = scrollArea.fontSize or self.db.profile.fontSize
		end
		if not outline then
			outline = scrollArea.fontOutline or self.db.profile.fontOutline
		end
	else
		if not font then
			font = scrollArea.stickyFont or self.db.profile.stickyFont
		end
		if not fontSize then
			fontSize = scrollArea.stickyFontSize or self.db.profile.stickyFontSize
		end
		if not outline then
			outline = scrollArea.stickyFontOutline or self.db.profile.stickyFontOutline
		end
	end
	if outline == "NONE" then
		outline = ""
	end
	
	local frame = next(freeFrames)
	if frame then
		frame:ClearAllPoints()
		freeFrames[frame] = nil
	else
		frame_num = frame_num + 1
		frame = CreateFrame("Frame", "ParrotFrameFrame" .. frame_num, ParrotFrame)
	end
	
	local fs = next(freeFontStrings)
	if fs then
		fs:ClearAllPoints()
		freeFontStrings[fs] = nil
		fs:SetParent(frame)
	else
		fontString_num = fontString_num + 1
		fs = frame:CreateFontString("ParrotFrameFontString" .. fontString_num, "ARTWORK", "MasterFont")
	end
	fs:SetFont(SharedMedia:Fetch('font', font), fontSize, outline)
	if not fs:GetFont() then
		fs:SetFont([[Fonts\FRIZQT__.TTF]], fontSize, outline)
	end
	
	frame.fs = fs
	
	
	
	local tex
	if type(icon) == "string" and icon ~= "Interface\\Icons\\Temp" and scrollArea.iconSide ~= "DISABLE" and self.db.profile.iconsEnabled then
		tex = next(freeTextures)
		if tex then
			tex:Show()
			tex:ClearAllPoints()
			freeTextures[tex] = nil
			tex:SetParent(frame)
		else
			texture_num = texture_num + 1
			tex = frame:CreateTexture("ParrotFrameTexture" .. texture_num, "OVERLAY")
		end
		if not tex:SetTexture(icon) then
			tex:Hide()
			tex:SetTexture(nil)
			freeTextures[tex] = true
			tex:SetParent(ParrotFrame)
		else
			frame.icon = tex
			if icon:find("^Interface\\Icons\\") then
				tex:SetTexCoord(0.07, 0.93, 0.07, 0.93)
			else
				tex:SetTexCoord(0, 1, 0, 1)
			end
			tex:SetWidth(fontSize)
			tex:SetHeight(fontSize)
		end
	end
	
	if tex then
		if scrollArea.iconSide == "CENTER" then
			
		elseif scrollArea.iconSide == "RIGHT" then
			tex:SetPoint("LEFT", fs, "RIGHT", 3, 0)
			fs:SetPoint("LEFT", frame, "LEFT")
		else
			tex:SetPoint("RIGHT", fs, "LEFT", -3, 0)
			fs:SetPoint("RIGHT", frame, "RIGHT")
		end
	else	
		fs:SetPoint("LEFT", frame, "LEFT")
	end
	
	if r and g and b then
		fs:SetTextColor(r, g, b)
	else
		fs:SetTextColor(1, 1, 1)
	end
	fs:SetText(text)
	frame.start = GetTime()
	frame.scrollArea = scrollArea
	frame.sticky = sticky
	
	if(sticky) then
		frame:SetFrameLevel(1)
	else
		frame:SetFrameLevel(0)
	end
	
	local animationStyle
	if sticky then
		animationStyle = scrollArea.stickyAnimationStyle
	else
		animationStyle = scrollArea.animationStyle
	end
	local aniStyle = Parrot_AnimationStyles:GetAnimationStyle(animationStyle)
	if not wildFrames then
		wildFrames = newList()
		self:AddRepeatingTimer("Parrot_OnUpdate", 0, "OnUpdate")
	end
	local wildFrames_scrollArea = wildFrames[scrollArea]
	if not wildFrames_scrollArea then
		wildFrames_scrollArea = newList()
		wildFrames[scrollArea] = wildFrames_scrollArea
	end
	local wildFrames_scrollArea_aniStyle = wildFrames_scrollArea[aniStyle]
	if not wildFrames_scrollArea_aniStyle then
		wildFrames_scrollArea_aniStyle = newList()
		wildFrames_scrollArea[aniStyle] = wildFrames_scrollArea_aniStyle
	end	
	wildFrames_scrollArea_aniStyle.length = scrollArea[sticky and "stickySpeed" or "speed"] or 3
	local frameIDs_scrollArea = frameIDs[scrollArea]
	if not frameIDs_scrollArea then
		frameIDs_scrollArea = newList()
		frameIDs[scrollArea] = frameIDs_scrollArea
	end
	local frameIDs_scrollArea_aniStyle = frameIDs_scrollArea[aniStyle]
	if not frameIDs_scrollArea_aniStyle then
		frameIDs_scrollArea_aniStyle = 1
	else
		frameIDs_scrollArea_aniStyle = frameIDs_scrollArea_aniStyle + 1
	end
	frameIDs_scrollArea[aniStyle] = frameIDs_scrollArea_aniStyle
	frame.id = frameIDs_scrollArea_aniStyle
	
	table.insert(wildFrames_scrollArea_aniStyle, 1, frame)
	fs:Show()
	frame:Show()
	frame.font, frame.fontSize, frame.fontOutline = fs:GetFont()
	local init = aniStyle.init
	if init then
		init(frame, scrollArea.xOffset, scrollArea.yOffset, scrollArea.size, scrollArea[sticky and "stickyDirection" or "direction"] or aniStyle.defaultDirection, frameIDs_scrollArea_aniStyle)
	end
	fs:SetAlpha(self.db.profile.alpha)
	if tex then
		tex:SetAlpha(self.db.profile.iconAlpha)
	end
	self:OnUpdate(scrollArea, aniStyle)
end
Parrot.ShowMessage = Parrot_Display.ShowMessage

local function isOverlapping(alpha, bravo)
	if alpha:GetLeft() <= bravo:GetRight() and bravo:GetLeft() <= alpha:GetRight() and alpha:GetBottom() <= bravo:GetTop() and bravo:GetBottom() <= alpha:GetTop() then
		return true
	end
end

function Parrot_Display:OnUpdate()
	local now = GetTime()
	for scrollArea, u in pairs(wildFrames) do
		for animationStyle, t in pairs(u) do
			local t_len = #t
			local lastFrame = newList()
			for i, frame in ipairs(t) do
				local start, length = frame.start, t.length
				if start + length <= now then
					for j = i, t_len do
						local frame = t[j]
						local cleanup = animationStyle.cleanup
						if cleanup then
							cleanup(frame, scrollArea.xOffset, scrollArea.yOffset, scrollArea.size, scrollArea[frame.sticky and "stickyDirection" or "direction"] or animationStyle.defaultDirection, frame.id)
						end
						frame:Hide()
						t[j] = nil
						freeFrames[frame] = true
						local fs = frame.fs
						fs:Hide()
						fs:SetParent(ParrotFrame)
						freeFontStrings[fs] = true
						local icon = frame.icon
						frame.icon = nil
						if icon then
							freeTextures[icon] = true
							icon:Hide()
							icon:SetTexture(nil)
							icon:ClearAllPoints()
							icon:SetParent(ParrotFrame)
						end
					end
					break
				end
				local percent = (now - start) / length
				if percent >= 0.8 then
					local alpha = (1-percent) * 5
					frame.fs:SetAlpha(alpha * self.db.profile.alpha)
					if frame.icon then
						frame.icon:SetAlpha(alpha * self.db.profile.iconAlpha)
					end
				end
				
				frame:ClearAllPoints()
				animationStyle.func(frame, scrollArea.xOffset, scrollArea.yOffset, scrollArea.size, percent, scrollArea[frame.sticky and "stickyDirection" or "direction"] or animationStyle.defaultDirection, i, t_len, frame.id)
				frame:SetWidth(frame.fs:GetWidth() + (frame.icon and (frame.icon:GetWidth() + 3) or 0))
				frame:SetHeight(math.max(frame.fs:GetHeight(), frame.icon and frame.icon:GetHeight() or 0))
				
				if animationStyle.overlap then
					for h = #lastFrame, 1, -1 do
						if isOverlapping(lastFrame[h], frame) then
							local done = false
							local minimum = percent
							local maximum = 1
							local current = (percent + maximum) / 2
							while maximum - minimum > 0.01 do
								animationStyle.func(frame, scrollArea.xOffset, scrollArea.yOffset, scrollArea.size, current, scrollArea[frame.sticky and "stickyDirection" or "direction"] or animationStyle.defaultDirection, i, t_len, frame.id)
								frame:SetWidth(frame.fs:GetWidth() + (frame.icon and (frame.icon:GetWidth() + 3) or 0))
								frame:SetHeight(math.max(frame.fs:GetHeight(), frame.icon and frame.icon:GetHeight() or 0))
								if isOverlapping(lastFrame[h], frame) then
									minimum = current
								else
									maximum = current
								end
								current = (maximum + minimum) / 2
							end
							current = current + 0.01
							frame.start = -current * length + now
							animationStyle.func(frame, scrollArea.xOffset, scrollArea.yOffset, scrollArea.size, current, scrollArea[frame.sticky and "stickyDirection" or "direction"] or animationStyle.defaultDirection, i, t_len, frame.id)
							frame:SetWidth(frame.fs:GetWidth() + (frame.icon and (frame.icon:GetWidth() + 3) or 0))
							frame:SetHeight(math.max(frame.fs:GetHeight(), frame.icon and frame.icon:GetHeight() or 0))
							for j = i+1, t_len do
								local v = t[j]
								if v.start > frame.start then
									v.start = frame.start
								end
							end
						end
					end
				end
				lastFrame[#lastFrame+1] = frame
			end
			lastFrame = del(lastFrame)
			if not t[1] then
				u[animationStyle] = del(t)
			end
		end
		if not next(u) then
			wildFrames[scrollArea] = del(u)
		end
	end
	if not next(wildFrames) then
		wildFrames = del(wildFrames)
		self:RemoveTimer("Parrot_OnUpdate")
	end
end
