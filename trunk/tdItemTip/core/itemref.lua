
local tooltips = {}
local links = {}
local _G = getfenv(0)

local function OnHide()
	links[this.link] = nil
	this.link = nil
end

local function tdCreateTooltip()
	local name = "ItemRefTooltip"..#(tooltips)

	local tip = CreateFrame("GameTooltip", name, UIParent, "GameTooltipTemplate")
	tip:SetFrameStrata("TOOLTIP")
	tip:SetClampedToScreen(true)
	tip:EnableMouse(true)
	tip:SetToplevel(true)
	tip:SetMovable(true)
	tip:SetWidth(128) tip:SetHeight(64)
	tip:SetPoint("BOTTOM", 0, 130)
	tip:SetPadding(16);
	tip:RegisterForDrag("LeftButton");
	tip:SetScript("OnHide", OnHide)
	tip:SetScript("OnDragStart", tip.StartMoving)
	tip:SetScript("OnDragStop", tip.StopMovingOrSizing)

	local close = CreateFrame("Button", nil, tip, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", 1, 0)
	close:SetScript("OnClick", function() HideUIPanel(this:GetParent()) end)

	tdItemTip:HookFrameMethod(tip, "SetHyperlink");

	tinsert(tooltips, tip)
	tinsert(UISpecialFrames, name);

	return tip
end

local function tdGetTooltip()
	for i, tip in ipairs(tooltips) do
		if not tip:IsVisible() then
			return tip
		end
	end
end

local function tdSetHyperlink(frame, link)
	if not tdItemTipDB.itemref then return end
	HideUIPanel(frame)

	local tip = links[link]
	if tip then
		links[link] = nil
		if tip:IsVisible() then
			HideUIPanel(tip)
			return
		end
	end

	tip = tdGetTooltip() or tdCreateTooltip()
	if tip then
        	tip:SetOwner(UIParent, "ANCHOR_PRESERVE");
		tip:SetHyperlink(link)
		tip.link = link

		links[link] = tip

		ShowUIPanel(tip)
	end
end

hooksecurefunc(ItemRefTooltip, 'SetHyperlink', tdSetHyperlink)
