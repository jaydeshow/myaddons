-- settings --
local zUF_PlayerRPShow = false			-- true 显示声望值条 		false 显示经验值条
local zUF_XPPctShow = false				-- true 显示经验值百分比	false 显示奖励经验值


function zUF_XPRP_OnLoad()
    this:RegisterEvent("PLAYER_XP_UPDATE")
    this:RegisterEvent("UPDATE_EXHAUSTION")
    this:RegisterEvent("UPDATE_FACTION")
    this:RegisterEvent("PLAYER_ENTERING_WORLD")
	PetFrame:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 72, -72)
	PetName:SetPoint("BOTTOMLEFT", "PetFrame", "BOTTOMLEFT", 50, 32)
end

function zUF_XPRP_OnEvent(event)
	if event == "PLAYER_XP_UPDATE" or event == "UPDATE_EXHAUSTION" or event == "UPDATE_FACTION" then
        zUF_XPRP_Update()
	elseif event == "PLAYER_ENTERING_WORLD" then
		zUF_PlayerFrameXPRPBarBorder:SetDesaturated(1)
		zUF_PlayerFrameXPRPBarBorderExt:SetDesaturated(1)
		if zUF_ExtraBorder then
			zUF_PlayerFrameXPRPBarBkgExt:SetWidth(192)
			zUF_PlayerFrameXPRPBarBorderExt:SetWidth(80)
			zUF_PlayerFrameXPRPBarBorderExt:SetTexCoord(0.5703125, 0.8828125, 0, 1)
			zUF_PlayerFrameXPRPBar:SetWidth(190)
			zUF_PlayerFrameXPRPText:SetPoint("CENTER", "PlayerFrame", 90, -19)
		else
			zUF_PlayerFrameXPRPBarBkgExt:SetWidth(122)
			zUF_PlayerFrameXPRPBarBorderExt:SetWidth(9)
			zUF_PlayerFrameXPRPBarBorderExt:SetTexCoord(0.84765625, 0.8828125, 0, 1)
			zUF_PlayerFrameXPRPBar:SetWidth(119)
			zUF_PlayerFrameXPRPText:SetPoint("CENTER", "PlayerFrame", 50, -19)
		end
		zUF_XPRP_Update()
    end
end

function zUF_XPRP_Update()
	local name, reaction, minRP, maxRP, value = GetWatchedFactionInfo()
	if zUF_PlayerRPShow and name then
		local color = FACTION_BAR_COLORS[reaction]
		value = value - minRP
		maxRP = maxRP - minRP
		minRP = 0
		if zUF_ExtraBorder then
			local pctRP = (value * 100) / maxRP
			zUF_PlayerFrameXPRPText:SetText(string.format("%s / %s   (%.1f%%)", value, maxRP, pctRP))
		else
			zUF_PlayerFrameXPRPText:SetText(string.format("%s / %s", value, maxRP))
		end
		zUF_PlayerFrameXPRPBar:SetMinMaxValues(minRP, maxRP)
		zUF_PlayerFrameXPRPBar:SetValue(value)
		zUF_PlayerFrameXPRPBar:SetStatusBarColor(color.r, color.g, color.b)
	else
		local playerXP = UnitXP("player")
		local playerXPMax = UnitXPMax("player")
		local playerXPRest = GetXPExhaustion()
		if zUF_ExtraBorder then
			if zUF_XPPctShow then
				local playerXPPct = (playerXP * 100) / playerXPMax
				zUF_PlayerFrameXPRPText:SetText(string.format("%s / %s   (%.1f%%)", playerXP, playerXPMax, playerXPPct))
			elseif playerXPRest and playerXPRest > 0 then
				zUF_PlayerFrameXPRPText:SetText(string.format("%s/%s  (+%s)", playerXP, playerXPMax, playerXPRest/2))
			else
				zUF_PlayerFrameXPRPText:SetText(string.format("%s / %s", playerXP, playerXPMax))
			end
		else
			zUF_PlayerFrameXPRPText:SetText(string.format("%s / %s", playerXP, playerXPMax))
		end
		zUF_PlayerFrameXPRPBar:SetMinMaxValues(min(0, playerXP), playerXPMax)
		zUF_PlayerFrameXPRPBar:SetValue(playerXP)
		if playerXPRest then
			zUF_PlayerFrameXPRPBar:SetStatusBarColor(0, 0.39, 0.88)
		else
			zUF_PlayerFrameXPRPBar:SetStatusBarColor(0.58, 0, 0.55)
		end
	end
end