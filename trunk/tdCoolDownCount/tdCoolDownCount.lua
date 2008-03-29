
local localization = {}

if GetLocale() == "zhCN" then
	localization = {
		loaded = "|cff7fff7fTCC|r--|cff7fff7f太多|r冷却:插件已载入，输入/TCC进行相关设置。",
		sorry = "|cff7fff7fTCC|r--|cff7fff7f太多|r冷却:设置恢复到默认，我对些感到非常报歉。",
	}
elseif GetLocale() == "zhTW" then
	localization = {
		loaded = "|cff7fff7fTCC|r--|cff7fff7f太多|r冷卻:插件已載入，輸入/TCC進行相關設置。",
		sorry = "|cff7fff7fTCC|r--|cff7fff7f太多|r冷卻:設置恢復到默認，我對些感到非常報歉。",
	}
else
	localization = {
		loaded = "|cff7fff7fTCC|r-|cff7fff7fTaiDuo|rCoolDown:AddOn has been loaded, input /TCC associated installed.",
		sorry = "|cff7fff7fTCC|r-|cff7fff7fTaiDuo|rCoolDown:Settings back to default, the more I'm very sorry.",
	}
end

local limitversion = 4.15
local timers = {}
local shines = {}
local activeShines = {}
local font = GameTooltipTextLeft1:GetFont(); font = string.lower(font)
local version = GetAddOnMetadata("tdCoolDownCount", "Version")

TCCBUTTONTYPE = {
	{key = 1, value = "^SpellButton", type = "Spell"  },
	{key = 2, value = "AutoCastable", type = "Pet"    },
	{key = 2, value = "HotKey",       type = "Action" },
	{key = 2, value = "Stock",        type = "Item"   },
}

local shine_style = {
	"",
	"Interface\\Cooldown\\star4",
	"Interface\\Cooldown\\ping4",
	"Interface\\Cooldown\\starburst",
	"Interface\\AddOns\\tdCoolDownCount\\heart",
}

tCC = CreateFrame("Frame")
tCC:Hide()
tCC:SetScript("OnUpdate", function(self, elapsed) self:UpdateAllShines(elapsed) end)
tCC:RegisterEvent("VARIABLES_LOADED")
tCC:SetScript("OnEvent", function(self, event, ...)
	if self[event] then
		self[event](self, ...)
	end
end)

-- event
function tCC.VARIABLES_LOADED(self)
	self:print(localization.loaded)
	if tCCDB and tCCDB.version and tonumber(tCCDB.version) and tonumber(tCCDB.version) >= limitversion then
		tCCDB.version = version
	else
		if tCCDB then
			self:print(localization.sorry)
		end
		self:GetDefault()
	end
	SLASH_TCCSLASH1 = "/tCC"
	SlashCmdList["TCCSLASH"] = function()
		if IsAddOnLoaded("tdCoolDownOption") or tCC_Option_Init then
			if tCC_Option.ready then
				if tCC_Option:IsVisible() then
					tCC_Option:Hide()
				else
					tCC_Option:Show()
				end
			else
				tCC_Option_Init()
				collectgarbage('collect')
			end
		else
			if LoadAddOn("tdCoolDownOption") then
				tCC_Option_Init()
				collectgarbage('collect')
			end
		end
	end
	local methods = getmetatable(CreateFrame("Cooldown", nil, nil, "CooldownFrameTemplate")).__index
	hooksecurefunc(methods, "SetCooldown", function(cd, start, duration)
		local btn = cd:GetParent()
		local type = cd.type or tCC:ButtonGetType(btn)
		if not cd.type then
			cd.type = type
		end
		if start > 0 and duration > ( tCCDB[type].min or 0 ) and tCCDB[type].config then
			tCC:StartTimer(cd, start, duration, type)
		end
	end)
end

--timer
local function Timer_OnUpdate(self, elapsed)
	if not tCCDB[self.type].config or not self.cd:IsVisible() or self.duration <= (tCCDB[self.type].min or 0) then
		self:Hide()
		return
	end
	if self.nextUpdate <= 0 then
		tCC:UpdateTimer(self)
	else
		self.nextUpdate = self.nextUpdate - elapsed
	end
end

function tCC:StartTimer(cd, start, duration, type)
	local timer = timers[cd] or self:CreateTimer(cd)
	if timer then
		cd:SetAlpha(tCCDB[type].hide and 0 or 1)
		timer.start = start
		timer.duration = duration
		timer.type = type
		timer.cd = cd
		timer.nextUpdate = 0
		timer:Show()
	end
end

function tCC:CreateTimer(cd)
	local timer = CreateFrame("Frame", nil, cd:GetParent())
	timer:SetFrameLevel(cd:GetFrameLevel() + 5)
	timer:SetAllPoints(cd)
	timer:SetToplevel(true)
	timer:Hide()
	timer:SetScript("OnUpdate", Timer_OnUpdate)

	local text = timer:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", timer, tCCDB[cd.type].point or "CENTER", 0, 1)
	timer.text = text

	local btn = cd:GetParent()
	if btn then
		if btn.icon then
			timer.icon = btn.icon
		else
			local name = btn:GetName()
			if name then
				timer.icon = getglobal(name .. "Icon") or getglobal(name .. "IconTexture")
			end
		end
	end
	timers[cd] = timer
	return timer
end

function tCC:UpdateTimer(timer)
	local type = timer.type
	local time = timer.start + timer.duration - GetTime()
	local max = tCCDB[type].max
	if max then
		if time > max and max ~= 0 then
			if timer.text:IsVisible() then
				timer.text:Hide()
			end
			return
		else
			if not timer.text:IsVisible() then
				timer.text:Show()
			end
		end
	end

	if timer.text:IsVisible() then
		local text, scale, r, g, b, nextUpdate = self:GetFormattedTime(time)

		timer.text:SetFont(tCCDB[type].font, tCCDB[type].size, "OUTLINE")
		timer.text:SetText(text)
		timer.text:SetTextColor(r, g, b)
		timer.text:SetPoint("CENTER", timer, tCCDB[type].point or "CENTER", 0, 0)
		timer:SetScale(scale)

		timer.nextUpdate = nextUpdate
	end

	if time < 0.2 then
		timer:Hide()
		timer.cd:SetAlpha(1)
		if tCCDB[type].shine then
			self:StartShine(timer)
		end
		if self.CenterSound then
			self:CenterSound(timer)
		end
	end

end

-- shines
function tCC:UpdateAllShines(elapsed)
	if next(activeShines) then
		for shine in pairs(activeShines) do
			self:UpdateShine(shine, elapsed)
		end
	else
		self:Hide()
	end
end

function tCC:UpdateShine(shine, elapsed)
	local type = shine.type
	if tCCDB[type].shine then
		shine.finish = shine.finish + elapsed
		if shine.finish >= tCCDB[type].time then
			activeShines[shine] = nil
			shine:Hide()
			return
		end
		local time = tCCDB[type].time
		local alpha = 1 - shine.finish / time
		local scale = tCCDB[type].scale * ( 1 - shine.finish / time)
		shine.icon:SetWidth(scale)
		shine.icon:SetHeight(scale)
		shine.icon:SetAlpha(alpha)
	end
end

function tCC:StartShine(timer)
	local btn = timer:GetParent()

	if btn and btn:IsVisible() then
		local shine = shines[btn] or self:CreateShine(btn)
		if shine and not activeShines[shine] then
			shine.finish = 0
			shine.type = timer.type
			if tCCDB[timer.type].style == 1 then
				shine.icon:SetTexture(timer.icon:GetTexture())
			else
				shine.icon:SetTexture(shine_style[tCCDB[timer.type].style])
			end
			activeShines[shine] = true
			shine:Show()
			self:Show()
		end
	end
end

function tCC:CreateShine(btn)
	local shine = CreateFrame("Frame", nil, btn)
	shine:SetAllPoints(btn)
	shine:SetToplevel(true)

	local icon = shine:CreateTexture(nil, "OVERLAY")
	icon:SetPoint("CENTER")
	icon:SetBlendMode("ADD")
	icon:SetHeight(shine:GetHeight())
	icon:SetWidth(shine:GetWidth())

	shine.icon = icon

	shines[btn] = shine
	return shine
end

-- tcc
function tCC:GetFormattedTime(t)
	if t >= 50 * 86400 then t = t % (50 * 86400) end  -- 尝试解决50天的问题
	if t < 9 then
		return ceil(t), 1.3,					-- scale
			1, t-floor(t)>0.5 and 0.12 or 0.82, 0.12,	-- rgb
			0.2						-- nextUpdate
	elseif t < 60 then
		return ceil(t), 1,	-- scale
			1, 0.82, 0,	-- rgb
			t-floor(t)	-- nextUpdate
	elseif t < 600 then
		if tCCDB.Other.type then
			return format("%d:%02d",floor(t/60),t%60), 0.7,	-- scale
				0.8,0.6,0,				-- rgb
				t-floor(t)				-- nextUpdate
		end
		return ceil(t/60).."m", 0.85,	-- scale
			0.8,0.6,0,		-- rgb
			t-floor(t)		-- nextUpdate
	elseif t < 3600 then
		return ceil(t/60).."m", 0.7,	-- scale
			0.8,0.6,0,		-- rgb
			t%60			-- nextUpdate
	elseif (t < 86400) then
		return ceil(t / 3600).."h", 0.6,	-- scale
			0.6,0.4,0,			-- rgb
			t%3600				-- nextUpdate
	else
		return ceil(t / 86400).."d", 0.6,	-- scale
			0.4,0.4,0.4,			-- rgb
			t%86400				-- nextUpdate
	end
end

function tCC:ButtonGetType(btn)
	local name, index = btn:GetName()
	for _, index in ipairs(TCCBUTTONTYPE) do
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
	return "Buff"
end

function tCC:GetDefault()
	tCCDB = {
		version = version,
		Action = {
			config = true,  min = 3, font = font, size = 28, shine = true, sound = true,
			time = 1, scale = 200, style = 1, center = true,  cscale = 100, ctime = 1, calpha = 1, cmode = true, hide = false
		},
		Pet = {
			config = true,  min = 3, font = font, size = 28, shine = true, sound = true,
			time = 1, scale = 200, style = 1, center = true,  cscale = 100, ctime = 1, calpha = 1, cmode = true, hide = false
		},
		Buff = {
			config = true,  max = 60, font = font, size = 18,
			point = "TOPRIGHT", hide = true
		},
		Spell = {
			config = false, min = 3, font = font, size = 28, shine = true,
			time = 1, scale = 200, style = 1, hide = false
		},
		Item = {
			config = true,  min = 3, font = font, size = 28, shine = true,
			time = 1, scale = 200, style = 1, hide = false
		},
		Color = {
			Range =  {r = 0.5, g = 0.1, b = 0.1},
			Mana =   {r = 0.5, g = 0.5, b = 1.0},
			Usable = {r = 0.4, g = 0.4, b = 0.4},
			TextColor = {r = 0, g = 1, b = 1},
		},
		Other = {
			text = true, type = nil, font = font, size = 30, Days = 0, Hours = 0, Mins = 0, Secs = 0, Short = 0,
			Color = {"Mana", "Usable", "Range"},
		},
		Fonts = {font},
	}
end

function tCC:print(msg)
	if msg then
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end