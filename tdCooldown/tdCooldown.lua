local timers = {}
local shines = {}
local actives = {}
local defaultFont = GameTooltipTextLeft1:GetFont()
local version = GetAddOnMetadata("tdCooldown", "Version")
local limit = "20400.7"
local L = TDCOOLDOWN_LACALE

tCD = CreateFrame("Frame", nil, UIParent)
tCD:Hide()
tCD:SetScript("OnEvent", function(self, event, ...) if self[event] then self[event](self, ...) end end)
tCD:SetScript("OnUpdate", function(self, elapsed) self:UpdateAllShines(elapsed) end)

tCD.type = {
	{key = 1, value = "^SpellButton", type = "SPELL"  },
	{key = 2, value = "AutoCastable", type = "PET"    },
	{key = 2, value = "HotKey",       type = "ACTION" },
	{key = 2, value = "Stock",        type = "ITEM"   },
}

tCD.style = {
	"Interface\\Cooldown\\star4",
	"Interface\\Cooldown\\ping4",
	"Interface\\Cooldown\\starburst",
	"Interface\\AddOns\\tdCooldown\\heart",
}

local function Timer_Update(self, elapsed)
	if not self.cooldown:IsVisible() then
		self:Hide()
	end
	if self.nextUpdate <= 0 then
		tCD:UpdateTimer(self)
	else
		self.nextUpdate = self.nextUpdate - elapsed
	end
end

local function Timer_Hide(self)
	self.nextUpdate = 0
	self.cooldown:SetAlpha(1)
end

function tCD:GetDefault()
	return {
		ACTION = {
			min = 3,
			config = true,
			hidecooldown = true,
			shine = true,
			scale = 4,
			time = 1,
			style = 0,
		},
		ITEM = {
			min = 3,
			config = true,
			hidecooldown = true,
			shine = true,
			scale = 4,
			time = 1,
			style = 0,
		},
		SPELL = {
			min = 3,
			config = true,
			hidecooldown = true,
			shine = true,
			scale = 4,
			time = 1,
			style = 0,
		},
		PET = {
			min = 3,
			config = true,
			hidecooldown = true,
			shine = true,
			scale = 4,
			time = 1,
			style = 0,
		},
		BUFF = {
			config = true,
			max = 60,
			hidecooldown = true,
			point = "TOPRIGHT"
		},
		style = {
			days  = {r = 0.4, g = 0.4, b = 0.4, s = 0.6},
			hrs   = {r = 0.6, g = 0.4, b = 0.0, s = 0.6},
			mins  = {r = 0.8, g = 0.6, b = 0.0, s = 0.7},
			secs  = {r = 1.0, g = 0.8, b = 0.0, s = 0.9},
			short = {r = 1.0, g = 0.1, b = 0.1, s = 1.2},
			
		},
		bar = {
			locked = false,
			sound = true,
			hidden = false,
			spacing = 5,
			height = 24,
			width = 100,
			alpha = 0.9,
			reverse = nil,
			size = 15,
			p = "CENTER",
			r = "CENTER",
			x = 0,
			y = 0,
			flashing = true,
		},
		center = {
			config = true,
			alpha = 1,
			width = 100,
			mode = true,
			time = 1.2,
			p = "CENTER",
			r = "CENTER",
			x = 0,
			y = 0,
			size = 30,
			sct = true,
			text = true,
		},
		long = true,
		size = 24,
		font = defaultFont,
		version = version,
	}
end

function tCD:FormatVersion(value)
	value = value and tostring(value)
	if not value then
		return 0, 0
	end
	local wow, ui = value:match("^(%d+).(%d+)$")
	return wow and tonumber(wow) or 0, ui and tonumber(ui) or 0
end

function tCD:UpdateSettings()
	-- 20400.9
	for i, v in ipairs({"ACTION", "ITEM", "SPELL", "PET"}) do
		tCDDB[v].style = tCDDB[v].style and tonumber(tCDDB[v].style) or 0
	end
end

function tCD:UpdateVersion()
	if not tCDDB then
		tCDDB = self:GetDefault()
		self:print(L.NewUser)
	else
		local oWow, oUi = self:FormatVersion(tCDDB.version)
		local nWow, nUi = self:FormatVersion(limit)
		if oWow < nWow or (oWow == nWow and oUi < nUi) then
			tCDDB = self:GetDefault()
			self:print(L.UpdatedIncompatible, 1)
			self:print(format(L.Updated, version))
		elseif tCDDB.version ~= version then
			tCDDB.version = version
			self:UpdateSettings()
			self:print(format(L.Updated, version))
		end
	end
	self.db = tCDDB
end

function tCD:TestFont(font)
	if not self.testfontstring then
		self.testfontstring = CreateFont("tCDTestFontString")
	end
	if font and self.testfontstring:SetFont(font, 12) then
		return font
	else
		self:print(format(L.ErrorFont, font or "", defaultFont), 1)
		return defaultFont
	end
end

function tCD:VARIABLES_LOADED()
	self:UpdateVersion()
	self.db.font = self:TestFont(self.db.font)

	self:HookCooldown()
	local f = CreateFrame('Frame', nil, InterfaceOptionsFrame)
	f:SetScript('OnShow', function(self) LoadAddOn("tdCooldown_Option") self:SetScript('OnShow', nil) end)

	if self.EnableCenter then self:EnableCenter() end
end

function tCD:GetButtonType(button)
	local name = button:GetName()
	if name then
		for _, index in ipairs(self.type) do
			if index.key == 1 then
				if string.find(name, index.value) then
					return index.type
				end
			elseif index.key == 2 then
				if getglobal(name..index.value) then
					return index.type
				end
			end
		end
	end
	return "BUFF"
end

function tCD:HookCooldown()
	local methods = getmetatable(CreateFrame("Cooldown", nil, nil, "CooldownFrameTemplate")).__index
	hooksecurefunc(methods, "SetCooldown", function(cooldown, start, duration)
		tCD:SetCooldown(cooldown, start, duration)
	end)
end

function tCD:print(msg, iserror)
	if msg and tostring(msg) and DEFAULT_CHAT_FRAME then
		if iserror then
			DEFAULT_CHAT_FRAME:AddMessage("|cff7fff7ftdCooldown|r|cffffffff:|r "..tostring(msg), 1, 0, 0)
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff7fff7ftdCooldown|r: "..tostring(msg))
		end
	end
end

function tCD:SetCooldown(cooldown, start, duration)
	cooldown.button = cooldown.button or cooldown:GetParent()
	cooldown.type = cooldown.type or self:GetButtonType(cooldown.button)
	if not cooldown.type then
		return
	end
	if start > 0 and duration > (self.db[cooldown.type].min or 0) and self.db[cooldown.type].config then
		self:StartTimer(cooldown, start, duration)
	elseif timers[cooldown] then
		timers[cooldown]:Hide()
	end
end

function tCD:CreateTimer(cooldown)
	local timer = CreateFrame("Frame", nil, cooldown.button)
	timer:SetFrameLevel(cooldown:GetFrameLevel() + 5)
	timer:SetAllPoints(cooldown)
	timer:SetToplevel(true)
	timer:Hide()
	timer:SetScript("OnUpdate", Timer_Update)
	timer:SetScript("OnHide", Timer_Hide)

	local text = timer:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", timer, self.db[cooldown.type].point or "CENTER", 0, 0)
	timer.text = text

	if cooldown.button.icon then
		timer.icon = cooldown.button.icon
	else
		local name = cooldown.button:GetName()
		if name then
			timer.icon = getglobal(name .. "Icon") or getglobal(name .. "IconTexture")
		end
	end

	timers[cooldown] = timer
	return timer 
end

function tCD:UpdateTimer(timer)
	timer.cooldown:SetAlpha(self.db[timer.cooldown.type].hidecooldown and 0 or 1)

	local time = timer.duration - (GetTime() - timer.start)
	local max = self.db[timer.cooldown.type].max
	if max and max > 0 and time > max then
		timer.text:Hide()
		return
	end
	if time > 0 then
		local str, scale, r, g, b, nextUpdate = self:GetFormattedTime(time)
		local text = timer.text
		local size = timer:GetWidth() or timer.cooldown.button:GetWidth()
		size = floor(size / 36 * self.db.size * scale)
		if size <= 0 then
			timer.nextUpdate = 0.2
			return
		end

		local set = text:SetFont(self.db.font, size, "OUTLINE")
		if not set then
			local button = timer.cooldown.button
			self:print("error:Font not set, is button --"..(button and button.GetName and button:GetName() or "<unname>"), 1)
			timer:Hide()
			return
		end
		text:SetText(str)
		text:SetTextColor(r, g, b)
		text:SetPoint("CENTER", timer, self.db[timer.cooldown.type].point or "CENTER", 0, 0)
		text:Show()

		timer.nextUpdate = nextUpdate
	else
		timer:Hide()
		if time > -1 and self.db[timer.cooldown.type].shine then
			self:StartShine(timer)
		end
	end
end

function tCD:StartTimer(cooldown, start, duration)
	local timer = timers[cooldown] or self:CreateTimer(cooldown)
	if timer then
		timer.start = start
		timer.duration = duration
		timer.cooldown = cooldown
		timer.nextUpdate = 0
		timer:Show()
	end
end

function tCD:GetFormattedTime(t)
	local style = self.db.style
	local str, nextUpdate
	if t < 9 then
		style = style.short
		str = ceil(t)
		nextUpdate = t-floor(t)
	elseif t < 60 then
		style = style.secs
		str = ceil(t)
		nextUpdate = t-floor(t)
	elseif t < 3600 then
		style = style.mins
		if t < 600 and self.db.long then
			str = format("%d:%02d",floor(t/60),t%60)
			nextUpdate = t-floor(t)
		else
			str = format("%dm", ceil(t/60))
			nextUpdate = t%60
		end
	elseif (t < 86400) then
		style = style.hrs
		str = format("%dh", ceil(t/3600))
		nextUpdate = t%3600
	else
		style = style.days
		str = format("%dd", ceil(t))
		nextUpdate = t%86400
	end
	return str, style.s, style.r, style.g, style.b, nextUpdate
end

tCD:RegisterEvent("VARIABLES_LOADED")

-- shine
function tCD:CreateShine(button)
	local frame = CreateFrame("Frame", nil, button)
	frame:SetAllPoints(button)
	frame:SetToplevel(true)

	local icon = frame:CreateTexture(nil, 'OVERLAY')
	icon:SetPoint('CENTER')
	icon:SetBlendMode('ADD')
	icon:SetHeight(frame:GetHeight())
	icon:SetWidth(frame:GetWidth())
	frame.icon = icon

	shines[button] = frame
	return frame
end

function tCD:StartShine(timer)
	local icon = timer.icon
	local button = timer.cooldown.button
	if button and button:IsVisible() then
		local shine = shines[button] or self:CreateShine(button)
		if shine and not actives[shine] then
			shine.type = timer.cooldown.type
			local style = self.style[self.db[shine.type].style]
			if not style and icon then
				shine.icon:SetTexture(icon:GetTexture())
			else
				shine.icon:SetTexture(style)
			end
			
			--local r, g, b = icon:GetVertexColor()
			--shine.icon:SetVertexColor(r, g, b, 0.7)

			shine.completed = 0
			shine:Show()

			actives[shine] = true
			self:Show()
		end
	end
end

function tCD:UpdateShine(shine, elapsed)
	shine.completed = (shine.completed or 0) + elapsed

	local scale = (self.db[shine.type].scale - 1) * (self.db[shine.type].time - shine.completed) + 1

	if scale <= 1 then
		actives[shine] = nil
		shine:Hide()
	else
		shine.icon:SetHeight(shine:GetHeight() * scale)
		shine.icon:SetWidth(shine:GetWidth() * scale)
	end
end

function tCD:UpdateAllShines(elapsed)
	if next(actives) then
		for shine in pairs(actives) do
			self:UpdateShine(shine, elapsed)
		end
	else
		self:Hide()
	end
end