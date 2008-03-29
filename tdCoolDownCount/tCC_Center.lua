
if IsAddOnLoaded("tCT") then
	return
end

local cdover
if GetLocale() == "zhCN" then
	cdover = "技能 %s 冷却完成了!"
elseif GetLocale() == "zhTW" then
	cdover = "技能 %s 冷卻完成了!"
else
	cdover = "%s Cooldown Completed!"
end

local centerData = {}
local text, color, center
local function Center_OnUpdate()
	this.finish = this.finish + arg1
	local alpha = tCCDB[this.type].calpha
	if this.finish > tCCDB[this.type].ctime / 2 then
		alpha = (1 - this.finish / tCCDB[this.type].ctime) * 2 * alpha
	end
	this:SetAlpha(alpha)

	if this.finish >= tCCDB[this.type].ctime then
		this.finish = 0
		this:Hide()
	end
end

tCC:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
function tCC:UNIT_SPELLCAST_SUCCEEDED()
	if arg1 ~= "player" then return end
	local icon = self:GetIcon(arg2)
	if icon then
		centerData[icon] = arg2
	end
end

function tCC:GetIcon(name)
	if ( not name ) then return end
	local booktype = {"spell", "pet"}
	local i, spell, j, _ = 1
	for _, book in pairs(booktype) do
		while name do
			spell, _ = GetSpellName(i,book)
			if ( not spell ) then
				i = 1
				break
			end
			if ( string.lower(name) == string.lower(spell)) then
				return GetSpellTexture(i, book)
			end
			i=i+1;
		end
	end
end

function tCC:CreateCenter()
	center = CreateFrame("frame", nil, UIParent)
	center:Hide()
	center:SetAllPoints(UIParent)
	center:SetFrameStrata("HIGH")
	center:SetScript("OnUpdate", Center_OnUpdate)

	center.icon = center:CreateTexture(nil, "OVERLAY")
	center.icon:Show()
	center.text = center:CreateFontString(nil, "ARTWORK", "SystemFont")
	center.text:SetPoint("TOP", center.icon, "BOTTOM")

	self.center = center
	return center
end

function tCC:StartCenter(timer)
	center = self.center or self:CreateCenter()
	text = centerData[timer.icon:GetTexture()]
	center.text:SetText("")

	if text and tCCDB.Other.text then
		color = tCCDB.Color.TextColor
		center.text:SetFont(tCCDB.Other.font, tCCDB.Other.size, "OUTLINE")
		center.text:SetText(format(cdover, "|cff"..format("%2x%2x%2x",color.r*255,color.g*255,color.b*255)..text.."|r"))
	end
	if center:IsVisible() and center.start and center.start == timer.start then
		if text then
			centerData[timer.icon:GetTexture()] = nil
		else
			return
		end
	end
	center:ClearAllPoints()
	if tCCDB[timer.type].p then
		center.icon:SetPoint(tCCDB[timer.type].p,
			UIParent,
			tCCDB[timer.type].s,
			tCCDB[timer.type].x,
			tCCDB[timer.type].y)
	else
		center.icon:SetPoint("CENTER",UIParent,"CENTER",0,0)
	end
	center.icon:SetWidth(tCCDB[timer.type].cscale)
	center.icon:SetHeight(tCCDB[timer.type].cscale)
	center.icon:SetBlendMode(tCCDB[timer.type].cmode and "ADD" or "BLEND")
	center.icon:SetTexture(timer.icon:GetTexture())

	center.finish = 0
	center.start = timer.start
	center.type = timer.type
	center:Show()
end

function tCC:CenterSound(timer)
	if tCCDB[timer.type].sound and timer.icon and centerData[timer.icon:GetTexture()] then
		PlaySoundFile("Interface\\AddOns\\tdCoolDownCount\\sound.wav")
	end
	if tCCDB[timer.type].center then
		self:StartCenter(timer)
	end
end