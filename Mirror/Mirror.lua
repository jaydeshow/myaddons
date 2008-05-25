Mirror_hover = false

Mirror = AceLibrary("AceAddon-2.0"):new("AceHook-2.1")

SlashCmdList["MIRROR"] = function()
	Mirror_hover = not Mirror_hover
	DEFAULT_CHAT_FRAME:AddMessage((Mirror_hover and "Tooltips on link-hover have been enabled. Please reload UI (/rl) for changes to take effect") or "Tooltips on link-hover have been disabled. Please reload UI (/rl) for changes to take effect")
end
SLASH_MIRROR1 = "/mirror"

local function OnHyperlinkEnter(frame,link,...)
	if string.match(link,"item:") or string.match(link,"enchant:") then
		GameTooltip:SetOwner(frame,"ANCHOR_RIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
	return Mirror.hooks[frame]["OnHyperlinkEnter"](link,...)
end

function Mirror:OnEnable()
	self:HookScript(GameTooltip,"OnTooltipSetItem")
	self:HookScript(ItemRefTooltip,"OnTooltipSetItem","ItemRefSetItem")
	self:HookScript(ItemRefTooltip,"OnDragStop","ItemRefOnDragStop")
	
	if Mirror_hover then
		--register all frames for hover events
		local frame
		for i=1,NUM_CHAT_WINDOWS do
			frame = getglobal("ChatFrame"..i)
			Mirror:HookScript(frame,"OnHyperlinkEnter",function(...) OnHyperlinkEnter(...); return Mirror.hooks[frame]["OnHyperlinkEnter"](...) end)
			Mirror:HookScript(frame,"OnHyperlinkLeave",function(...) GameTooltip:Hide(); return Mirror.hooks[frame]["OnHyperlinkLeave"](...) end)
			Mirror:HookScript(frame,"OnHyperlinkClick",function(...) GameTooltip:Hide(); return Mirror.hooks[frame]["OnHyperlinkClick"](...) end)
		end
	end
end

function Mirror:OnTooltipSetItem(...)
	local tooltipOwner = GameTooltip:GetOwner()
	--just in case there is no owner
	if tooltipOwner then
		tooltipOwner = tooltipOwner:GetName() or ""
		--no comparison for items on the action bars
		if string.match(tooltipOwner,"ActionButton") or string.match(tooltipOwner,"MultiBar") then
			return self.hooks[GameTooltip]["OnTooltipSetItem"](...)
		end
		--handle CharacterXXXSlot differently
		--only compare rings, trinkets, and weapons
		local slot = string.match(tooltipOwner,"Character(%a+)%d?Slot")
		if slot and not (slot == "Trinket" or slot == "Finger" or slot == "MainHand" or slot == "SecondaryHand") then
			return self.hooks[GameTooltip]["OnTooltipSetItem"](...)
		end
	end
	GameTooltip_ShowCompareItem()
	return self.hooks[GameTooltip]["OnTooltipSetItem"](...)
end

function Mirror:ItemRefSetItem(...)
	MirrorTooltip1:Hide()
	MirrorTooltip2:Hide()
	self:ItemRef_ShowCompareItem()
	return self.hooks[ItemRefTooltip]["OnTooltipSetItem"](...)
end

function Mirror:ItemRefOnDragStop(...)
	self:ItemRef_ShowCompareItem()
	return self.hooks[ItemRefTooltip]["OnDragStop"](...)
end

--blizzard's tooltip comparison function ripoff applied to itemRefTooltip
function Mirror:ItemRef_ShowCompareItem()
	local item, link = ItemRefTooltip:GetItem();
	if ( not link ) then
		return;
	end

	local item1 = nil;
	local item2 = nil;
	local side = "left";
	if ( MirrorTooltip1:SetHyperlinkCompareItem(link, 1) ) then
		item1 = true;
	end
	if ( MirrorTooltip2:SetHyperlinkCompareItem(link, 2) ) then
		item2 = true;
	end

	-- find correct side
	local rightDist = 0;
	local leftPos = ItemRefTooltip:GetLeft();
	local rightPos = ItemRefTooltip:GetRight();
	if ( not rightPos ) then
		rightPos = 0;
	end
	if ( not leftPos ) then
		leftPos = 0;
	end

	rightDist = GetScreenWidth() - rightPos;

	if (leftPos and (rightDist < leftPos)) then
		side = "left";
	else
		side = "right";
	end

	-- see if we should slide the tooltip
	if ( ItemRefTooltip:GetAnchorType() ) then
		local totalWidth = 0;
		if ( item1  ) then
			totalWidth = totalWidth + MirrorTooltip1:GetWidth();
		end
		if ( item2  ) then
			totalWidth = totalWidth + MirrorTooltip2:GetWidth();
		end

		if ( (side == "left") and (totalWidth > leftPos) ) then
			ItemRefTooltip:SetAnchorType(ItemRefTooltip:GetAnchorType(), (totalWidth - leftPos), 0);
		elseif ( (side == "right") and (rightPos + totalWidth) >  GetScreenWidth() ) then
			ItemRefTooltip:SetAnchorType(ItemRefTooltip:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0);
		end
	end

	-- anchor the compare tooltips
	if ( item1 ) then
		MirrorTooltip1:SetOwner(ItemRefTooltip, "ANCHOR_NONE");
		MirrorTooltip1:ClearAllPoints();
		if ( side and side == "left" ) then
			MirrorTooltip1:SetPoint("TOPRIGHT", "ItemRefTooltip", "TOPLEFT", 0, -10);
		else
			MirrorTooltip1:SetPoint("TOPLEFT", "ItemRefTooltip", "TOPRIGHT", 0, -10);
		end
		MirrorTooltip1:SetHyperlinkCompareItem(link, 1);
		MirrorTooltip1:Show();

		if ( item2 ) then
			MirrorTooltip2:SetOwner(MirrorTooltip1, "ANCHOR_NONE");
			MirrorTooltip2:ClearAllPoints();
			if ( side and side == "left" ) then
				MirrorTooltip2:SetPoint("TOPRIGHT", "MirrorTooltip1", "TOPLEFT", 0, 0);
			else
				MirrorTooltip2:SetPoint("TOPLEFT", "MirrorTooltip1", "TOPRIGHT", 0, 0);
			end
			MirrorTooltip2:SetHyperlinkCompareItem(link, 2);
			MirrorTooltip2:Show();
		end
	end
end
