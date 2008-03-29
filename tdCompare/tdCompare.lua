
tdCompareAction = false;	-- 开启或关闭动作条上装备比较
tdCompareChatShow = true;	-- 开启或关闭鼠标经过聊天窗口显示装备详情
tdCompareChat = true;		-- 开启或关闭聊天窗口装备比较[开启需要先开启上一项]
tdCompareShift = false;		-- 开启或关闭按下Shift才比较装备(只限背包内物品 某些鼠标提示插件会导致按下Shift不比较)

CURRENTLY_EQUIPPED = LIGHTYELLOW_FONT_COLOR_CODE.."----"..CURRENTLY_EQUIPPED.."----".. FONT_COLOR_CODE_CLOSE

local _G = getfenv(0)
local i
for i = 3, 4 do
	CreateFrame("GameTooltip", "ShoppingTooltip" .. i, ItemRefTooltip, "ShoppingTooltipTemplate")
	_G["ShoppingTooltip"..i]:SetFrameStrata("TOOLTIP")
	_G["ShoppingTooltip"..i]:SetClampedToScreen(true)
end
local font, size, outline = GameTooltipText:GetFont()
GameTooltipTextSmall:SetFont(font, size, outline)
for i = 1, 4 do
	_G["ShoppingTooltip"..i.."TextLeft3"]:SetFont(font, size, outline)
	_G["ShoppingTooltip"..i.."TextRight3"]:SetFont(font, size, outline)
	_G["ShoppingTooltip"..i.."TextRight4"]:SetFont(font, size, outline)
end

local orig1
if not tdCompareShift then
	orig1 = GameTooltip:GetScript("OnTooltipSetItem")
	GameTooltip:SetScript("OnTooltipSetItem", function(frame, ...)
		if not ShoppingTooltip1:IsVisible() then
			GameTooltip_ShowCompareItem()
		end
		if orig1 then
			return orig1(frame, ...)
		end
	end)
end

local orig2 = ItemRefTooltip:GetScript("OnTooltipSetItem")
ItemRefTooltip:SetScript("OnTooltipSetItem", function(frame, ...)
	GameTooltip_ShowCompareItem(this, ShoppingTooltip3, ShoppingTooltip4)
	if orig2 then
		return orig2(frame, ...)
	end
end)

function GameTooltip_ShowCompareItem(tip, tip1, tip2)
	if not tip then
		tip = GameTooltip
	end

	local _, link = tip:GetItem();
	local f = GetMouseFocus() and GetMouseFocus():GetName() or ""
	if not link or
	       f == "WorldFrame" or
	       (_G[f.."HotKey"] and not tdCompareAction) or
	       (string.find(tip:GetOwner():GetName() or "", "^ChatFrame") and not tdCompareChat) or
	       string.find(f, "^Character.*Slot$") or
	       string.find(f, "^TempEnchant%d+$") then
		return
	end

	if not tip1 then tip1 = ShoppingTooltip1; end
	if not tip2 then tip2 = ShoppingTooltip2; end

	local item1, item2 = nil, nil;
	if tip1:SetHyperlinkCompareItem(link, 1) then item1 = true; end
	if tip2:SetHyperlinkCompareItem(link, 2) then item2 = true; end
	if not item1 and not item2 then return; end

	local left, right, anchor1, anchor2 = tip:GetLeft(), tip:GetRight(), "TOPLEFT", "TOPRIGHT"
	if not left or not right then return; end

	if (GetScreenWidth() - right) < left then anchor1, anchor2 = anchor2, anchor1 end
	local changed
	if item2 and not item1 then
		tip1, tip2, item1, item2 = tip2, tip1, true, nil;
		changed = true
	end

	if item1 then
		tip1:SetOwner(tip, "ANCHOR_NONE")
		tip1:ClearAllPoints()
		tip1:SetPoint(anchor1, tip, anchor2, 0, -10)
		tip1:SetHyperlinkCompareItem(link, changed and 2 or 1)
		tip1:Show()
		tip1:SetBackdropColor(0.0, 0.0, 0.5)

		if item2 then
			tip2:SetOwner(tip, "ANCHOR_NONE")
			tip2:SetHyperlinkCompareItem(link, changed and 1 or 2)
			tip2:Show()
			tip2:ClearAllPoints()
			if tip2:GetWidth() > left or tip2:GetWidth() > (GetScreenWidth() - right) then
				tip2:SetPoint(anchor1, tip1, anchor2, 0, 0)
			else
				tip2:SetPoint(anchor2, tip, anchor1, 0, -10)
			end
			tip2:SetBackdropColor(0.0, 0.0, 0.5)
		end
	end
end


if tdCompareChatShow then
	local orig3, orig4 = {}, {}

	local function OnHyperlinkEnter(frame, link, ...)
		if string.find(link, "^item") or string.find(link, "^enchant") then
			GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()
		end

		if orig3[frame] then return
			orig3[frame](frame, link, ...)
		end
	end

	local function OnHyperlinkLeave(frame, ...)
		GameTooltip:Hide()
		if orig4[frame] then
			return orig4[frame](frame, ...)
		end
	end

	for i=1, NUM_CHAT_WINDOWS do
		local frame = _G["ChatFrame"..i]
		orig3[frame] = frame:GetScript("OnHyperlinkEnter")
		frame:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)

		orig4[frame] = frame:GetScript("OnHyperlinkLeave")
		frame:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)

		if tdCompareShift then
			frame.UpdateTooltip = function()
				if IsShiftKeyDown() then
					if not ShoppingTooltip1:IsVisible() then
						GameTooltip_ShowCompareItem()
					end
				else
					if ShoppingTooltip1:IsVisible() then
						ShoppingTooltip1:Hide()
						ShoppingTooltip2:Hide()
					end
				end
			end
		end
	end
end
