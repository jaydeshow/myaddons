
tCDblackData = {}
tCDcoolingData = {}

local cooldownlist = {}
local centerData = {}
local succeededData = {}
local timers = {}

local L = TDCOOLDOWN_LACALE

local _G = getfenv(0)
local font, size, mode = GameFontNormalSmall:GetFont()

local function Bar_Update(self)
	tCD:UpdateBar()
	tCD:UpdateCenter()
end

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", Bar_Update)
f:Show()

local function Center_Update()
	this.finish = this.finish + arg1
	local alpha = tCD.db.center.alpha
	if this.finish > tCD.db.center.time / 2 then
		alpha = (1 - this.finish / tCD.db.center.time) * 2 * alpha
	end
	this:SetAlpha(alpha)

	if this.finish >= tCD.db.center.time then
		tremove(centerData,1)
		this.finish = 0
		this:Hide()
	end
end

function tCD:TestRank(rank)
	if not rank or rank == "" or rank == " " or not string.find(rank.." ", L.Rank) then
		rank = 0
	end
	return rank
end

function tCD:CreateBar(index)
	local bar = CreateFrame("StatusBar", "tCDBar"..index, UIParent, "tCDBarTemplate")
	local p, r, y
	if self.db.bar.reverse then
		p = "BOTTOMLEFT"; r = "TOPLEFT"; y = self.db.bar.spacing
	else
		p = "TOPLEFT"; r = "BOTTOMLEFT"; y = - self.db.bar.spacing
	end
	bar:SetAlpha(self.db.bar.alpha)
	bar:SetWidth(self.db.bar.width)
	bar:SetHeight(self.db.bar.height)
	bar.Name:SetWidth(self.db.bar.width)
	bar.Name:SetHeight(self.db.bar.height)
	bar.Icon:SetWidth(self.db.bar.height)
	bar.Icon:SetHeight(self.db.bar.height)
	bar:SetPoint(p, timers[index-1], r, 0, y)

	bar.Name:SetFont(font, self.db.bar.size, mode)
	bar.Timer:SetFont(font, self.db.bar.size, mode)
	timers[index] = bar
	return bar
end

function tCD:GetInfo(id, type)
	if not id or not type then
		return
	end
	local start, duration, icon, name
	if type == "spell" or type == "pet" then
		start, duration, enable = GetSpellCooldown(id, type)
		icon = GetSpellTexture(id, type)
	elseif type == "item" then
		start, duration, enable = GetItemCooldown(id)
		name,_,_,_,_,_,_,_,_,icon = GetItemInfo(id)
	end
	return start, duration, enable, name, icon
end

function tCD:GetFormattedBarTime(s)
	if s < 10 then
		return format("%.1f", s)
	elseif s < 3600 then
		return format("%d:%02d",floor(s/60),s%60)
	else
		return "> 1 h"
	end
end

function tCD:GetTablePos(table, var, value)
	for i, v in ipairs(table) do
		if (var and v[var] or v) == value then
			return i
		end
	end
	return nil
end

function tCD:GetSpellID(spell, rank)
	if not spell then
		return
	end
	local i, s, r
	for _, book in ipairs({"spell", "pet"}) do
		i = 1
		while spell do
			s = GetSpellName(i, book)
			if not s then
				break
			end
			if s == spell then
				return i, book
			end
			i = i + 1
		end
	end
	local slots, link
	for i = 1, 19 do
		link = GetInventoryItemLink("player", i)
		if link then
			s, r = GetItemSpell(link)
			r = self:TestRank(r)
			if s and s == spell and r == rank then
				return link, "item"
			end
		end
	end
	for i = 0, 4 do
		slots = GetContainerNumSlots(i)
		if slots > 0 then
			for j = 1, slots do
				link = GetContainerItemLink(i, j)
				if link then
					s, r = GetItemSpell(link)
					r = self:TestRank(r)
					if s and s == spell and r == rank then
						return link, "item"
					end
				end
			end
		end
	end
end

function tCD:GetBarColor(value)
	local r, g
	if value > 0.5 then
		r = (1 - value) * 2;
		g = 1;
	else
		r = 1;
		g = value * 2;
	end
	return r, g, 0;
end

function tCD:QuitCooling(i)
	if i and tCDcoolingData[i] then
		local spell = tCDcoolingData[i].spell
		tremove(tCDcoolingData, i)
		cooldownlist[spell] = nil
	end
end

function tCD:UpdateBar()
	local timer, time, maxValue
	for i, v in ipairs(tCDcoolingData) do
		if tCDblackData[v.name] or tCDblackData[v.spell] then
			self:QuitCooling(i)
		else
			time = v.start + v.duration - GetTime()
			if time <= 0 then
				if self.db.center.config then
					tinsert(centerData, v)
				end
				if self.db.bar.sound then
					PlaySoundFile("Interface\\AddOns\\tdCooldown\\sound.wav")
				end
				self:QuitCooling(i)
			elseif time < 3 then
				tCDcoolingData[i].locked = true
			elseif time > v.duration then
				self:QuitCooling(i)
			end

			if not self.db.bar.hidden and cooldownlist[v.spell] then
				timer = timers[i] or self:CreateBar(i)
				maxValue = select(2, timer:GetMinMaxValues())
				if maxValue ~= v.duration then
					timer:SetMinMaxValues(0, v.duration)
				end
				if timer.Name:GetText() ~= (v.name or v.spell) then
					timer.Name:SetText(v.name or v.spell)
				end
				if timer.Icon:GetTexture() ~= v.icon then
					timer.Icon:SetTexture(v.icon)
				end
				timer:SetStatusBarColor(self:GetBarColor(time / v.duration))
				timer.Timer:SetText(self:GetFormattedBarTime(time))
				timer:SetValue(time)
				timer:Show()
			end
		end
	end
	if #(tCDcoolingData) >= #(timers) then
		return
	end
	for i = #(tCDcoolingData) + 1, #(timers) do
		timers[i]:Hide()
	end
end

function tCD:UpdateCenter()
	if self.db.center.config and #(centerData) > 0 and (not self.center or not self.center:IsVisible()) then
		if not self.center then
			local center = CreateFrame("frame", nil, UIParent)
			center:Hide()
			center:SetAllPoints(UIParent)
			center:SetFrameStrata("HIGH")
			center:SetScript("OnUpdate", Center_Update)

			center.icon = center:CreateTexture(nil, "OVERLAY")
			center.icon:Show()
			center.text = center:CreateFontString(nil, "ARTWORK", "SystemFont")
			center.text:SetPoint("TOP", center.icon, "BOTTOM")

			self.center = center
		end
		self.center.icon:ClearAllPoints()
		self.center.icon:SetPoint(self.db.center.p, UIParent, self.db.center.r, self.db.center.x, self.db.center.y)
		self.center.icon:SetWidth(self.db.center.width)
		self.center.icon:SetHeight(self.db.center.width)
		self.center.icon:SetBlendMode(self.db.center.mode and "ADD" or "BLEND")
		self.center.icon:SetTexture(centerData[1].icon)

		if self.db.center.text then
			if self.db.center.sct and DSCT_Display_Message then
				self.center.text:Hide()
				DSCT_Display_Message(format(L.CDOver,
					"|cff"..format("%2x%2x%2x",0*255,1*255,1*255)..(centerData[1].name or centerData[1].spell).."|r"),
					{r=1, g=1, b=1})
			else
				self.center.text:SetFont(font, self.db.center.size, "OUTLINE")
				self.center.text:SetText(format(L.CDOver,
					"|cff"..format("%2x%2x%2x",0*255,1*255,1*255)..(centerData[1].name or centerData[1].spell).."|r"))
				self.center.text:Show()
			end
		else
			self.center.text:Hide()
		end
		self.center.finish = 0
		self.center:Show()
	end
end
---- event

function tCD:EnableCenter()
	local pos = CreateFrame("Button", "tCDBar0", UIParent, "UIPanelButtonTemplate")
	pos:SetWidth(60); pos:SetHeight(20)
	pos:SetText(L.Move)
	pos:SetPoint(self.db.bar.p, UIParent, self.db.bar.r, self.db.bar.x, self.db.bar.y)
	pos:SetMovable(true)
	pos:EnableMouse(true)
	pos:RegisterForDrag("LeftButton")
	pos:SetScript("OnDragStart",function() this:StartMoving() end)
	pos:SetScript("OnDragStop",function()
		this:StopMovingOrSizing()
		local p, _, r, x, y = this:GetPoint()
		self.db.bar.p = p; self.db.bar.r = r; self.db.bar.x = x; self.db.bar.y = y
	end)
	timers[0] = pos
	if self.db.bar.locked then
		pos:Hide()
	else
		pos:Show()
	end
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function tCD:SPELL_UPDATE_COOLDOWN()
	local start, duration, enable, name, icon, pos
	for i, v in ipairs(succeededData) do
		start, duration, enable, name, icon = self:GetInfo(v.id, v.type)
		if start and duration and enable and enable > 0 and start > 0 and duration > 3 then
			if cooldownlist[v.spell] then
				pos = self:GetTablePos(tCDcoolingData, "spell", v.spell)
				if pos then
					local date = tCDcoolingData[pos]
					if start ~= date.start or duration ~= date.duration then
						tCDcoolingData[pos].start = start
						tCDcoolingData[pos].duration = duration
					end
				end
			else
				tinsert(tCDcoolingData, {
					spell = v.spell,
					rank = v.rank,
					name = name,
					icon = icon,
					start = start,
					duration = duration,
				})
				cooldownlist[v.spell] = true
				tremove(succeededData, i)
			end
		end
	end
	self:TestAllCooling()
end

function tCD:TestAllCooling()
	local id, type, start, duration
	for i, v in ipairs(tCDcoolingData) do
		if not v.locked then
			id, type = self:GetSpellID(v.spell, v.rank)
			if id and type and (type == "spell" or type == "pet") then
				start, duration, enable = self:GetInfo(id, type)
				if not start or start == 0 or duration <= 3 or not enable or enable <= 0 then
					self:QuitCooling(i)
				else
					cooldownlist[v.spell] = true
				end
			end
		end
	end
end

function tCD:UNIT_SPELLCAST_SUCCEEDED(unit, spell, rank)
	if (unit ~= "player" and unit ~= "pet") or tCDblackData[spell] then
		return
	end
	local pos = self:GetTablePos(succeededData, "spell", spell)
	if not pos then
		rank = self:TestRank(rank)
		local id, type = self:GetSpellID(spell, rank)
		if id then
			if type == "item" then
				local name = GetItemInfo(id)
				if name and tCDblackData[name] then
					return
				end
			end
			tinsert(succeededData, {id = id, type = type, spell = spell, rank = rank, num = 1})
		end
	else
		succeededData[pos].num = succeededData[pos].num + 1
		if succeededData[pos].num >= 4 then
			tCDblackData[spell] = true
			tremove(succeededData, pos)
		end
	end
end

function tCD:PLAYER_ENTERING_WORLD()
	local start, duration, id, type, timed
	for i, v in ipairs(tCDcoolingData) do
		if v.spell == "Test Spell" then
			tremove(tCDcoolingData, i)
			cooldownlist[v.spell] = nil
		else
			id, type = self:GetSpellID(v.spell, v.rank)
			if not id then
				self:QuitCooling(i)
			else
				start, duration, enable = self:GetInfo(id, type)
				timed = GetTime() - start
				if not enable or enable <= 0 or not start or start == 0 or duration <= 3 or timed < 0 or timed > duration then
					self:QuitCooling(i)
				else
					cooldownlist[v.spell] = true
				end
			end
		end
	end
end
