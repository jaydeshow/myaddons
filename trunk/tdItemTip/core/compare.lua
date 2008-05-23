
CURRENTLY_EQUIPPED = "|cffffff9a----"..CURRENTLY_EQUIPPED.."----|r"
local _G = getfenv(0)
local find = string.find

local GameTooltip = GameTooltip
local ItemRefTooltip = ItemRefTooltip
local tdItemTip = tdItemTip
local GameTooltip1, GameTooltip2, GameTooltip3, GameTooltip4

-- create tooltip func
local function CreateTooltip(name, owner)
	local tip = CreateFrame("GameTooltip", name, owner, "GameTooltipTemplate")
	tip:SetFrameStrata("TOOLTIP")
	tip:SetClampedToScreen(true)
	_G[name.."TextLeft2"]:SetFont(GameTooltipTextLeft1:GetFont())

	return tip
end

local function UpdateTooltip()
	if not tdItemTipDB.chatshowequip then return end
	if IsShiftKeyDown() or not tdItemTipDB.chatshift then
		if not GameTooltip1:IsVisible() then
			GameTooltip_ShowCompareItem()
		end
	else
		if GameTooltip1:IsVisible() then
			GameTooltip1:Hide()
			GameTooltip2:Hide()
		end
	end
end

local function OnHyperlinkEnter(frame, link, ...)
	if not tdItemTipDB.chatshowtip then return end 
	if find(link, "^item") or
           find(link, "^enchant") or
           find(link, "^spell") or
           find(link, "^quest") or
           find(link, "^unit") then
		GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
		UpdateTooltip()
	end
end

local function OnHyperlinkLeave(frame, ...)
	GameTooltip:Hide()
end

GameTooltip1 = CreateTooltip("tdItemTip1", GameTooltip)
GameTooltip2 = CreateTooltip("tdItemTip2", GameTooltip)

_G.ShoppingTooltip1 = GameTooltip1
_G.ShoppingTooltip2 = GameTooltip2

-- ItemRefTooltip
GameTooltip3 = CreateTooltip("GameTooltip3", ItemRefTooltip)
GameTooltip4 = CreateTooltip("GameTooltip4", ItemRefTooltip)

tdItemTip:HookFrameScript(GameTooltip, "OnTooltipSetItem", function(frame, ...)
	if tdItemTipDB.shift then return end
	if not GameTooltip1:IsVisible() then
		GameTooltip_ShowCompareItem();
	end
end)

tdItemTip:HookFrameScript(ItemRefTooltip, "OnTooltipSetItem", function(frame, ...)
	if not tdItemTipDB.refshowequip then return end
	GameTooltip_ShowCompareItem(this, GameTooltip3, GameTooltip4)
end)

-- chat frame
for i = 1, NUM_CHAT_WINDOWS do
	local frame = _G["ChatFrame"..i]

	tdItemTip:HookFrameScript(frame, "OnHyperlinkEnter", OnHyperlinkEnter)
	tdItemTip:HookFrameScript(frame, "OnHyperlinkLeave", OnHyperlinkLeave)
	frame.UpdateTooltip = UpdateTooltip
end

function GameTooltip_ShowCompareItem(tip, tip1, tip2)
	if not tip then tip = GameTooltip end

	local link = select(2, tip:GetItem());
	if not link then return end

	local f = GetMouseFocus() and GetMouseFocus():GetName() or ""
	if f == "WorldFrame" or
	       (_G[f.."HotKey"] and not tdItemTipDB.actionshowequip) or
	       find(f, "^Character.*Slot$") or
	       find(f, "^TempEnchant%d+$") then
		return
	end

	if not tip1 then tip1 = GameTooltip1; end
	if not tip2 then tip2 = GameTooltip2; end

	local item1, item2 = tip1:SetHyperlinkCompareItem(link, 1), tip2:SetHyperlinkCompareItem(link, 2);

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
