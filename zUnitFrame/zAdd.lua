-- settings --
local zUF_OTWarning = true				-- true 开启OT报警 						false 关闭
local zUF_targetShield = true			-- true 显示目标破甲值					false 不显示
local zUF_ToT6Debuffs = true			-- true 系统ToT显示6个大图标debuff		false 不显示


local zUF_OTSound_Play = 0
local zUF_SHIELD_THRESHOLD_RED = 2250
local zUF_SHIELD_THRESHOLD_YELLOW = 900
zUF_MAX_TARGETTARGET_DEBUFFS = 6

function zUF_Add_OnUpdate()
	if zUF_OTWarning then
		zUpdateOTWarning()
	end
	if zUF_targetShield then
		zUpdateTatgetShield()
    end
    if zUF_ToT6Debuffs then
		zToTDebuff_RefreshBuffs()
    end
end

-- OT Warning --
if zUF_OTWarning then
	function zUpdateOTWarning()
		if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
			if UnitIsUnit("targettarget", "player") and UnitCanAttack("target", "player") then
				if zUF_OTSound_Play ~= 1 then
					PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav")
					zUF_OTSound_Play = 1
				end
			else
				zUF_OTSound_Play = 0
			end
		end
	end
end

-- Target Shield --
if zUF_targetShield then
	TargetFrame:CreateFontString("TargetFrameShield", "ARTWORK", "GameFontNormalSmall")
	TargetFrameShield:SetPoint("BOTTOMRIGHT", TargetFrameNameBackground, "TOPRIGHT", -15, 1)
	
	function zUpdateTatgetShield()
		local targetShieldString = ""
		if UnitExists("target") and not UnitIsPlayer("target") and not UnitIsDead("target") then
			local i, debuffTexture, debuffCount
			local targetShield = 0
			for i = 1, 16 do
				_, _, debuffTexture, debuffCount = UnitDebuff("target", i)
				if debuffTexture and debuffCount and debuffTexture == "Interface\\Icons\\Ability_Warrior_Sunder" then
					targetShield = debuffCount * 450
				end
			end
			if targetShield > 0 then
				if (targetShield < zUF_SHIELD_THRESHOLD_YELLOW) then
					targetShieldString = "|cffffffff" .. targetShield .. "|r"
				elseif (targetShield < zUF_SHIELD_THRESHOLD_RED) then
					targetShieldString = "|cffffff00" .. targetShield .. "|r"
				else
					targetShieldString = "|cffff0000" .. targetShield .. "|r"
				end
				targetShieldString = ">>" .. targetShieldString
			end
		end
		TargetFrameShield:SetText(targetShieldString)
	end
end

-- ToT Debuff --
if zUF_ToT6Debuffs then
	function zToTDebuff_RefreshBuffs()
		if TargetofTargetFrame:IsShown() then
			for i = 1, 4 do
				getglobal("TargetofTargetFrameDebuff"..i):Hide()
			end
			local debuffTexture, debuffCount, debuffType
			local button, icon, count, border, color
			for i = 1, zUF_MAX_TARGETTARGET_DEBUFFS do
				button = getglobal("zUF_TargetTargetDeBuffFrameDeBuff"..i)
				icon = getglobal("zUF_TargetTargetDeBuffFrameDeBuff"..i.."Icon")
				count = getglobal("zUF_TargetTargetDeBuffFrameDeBuff"..i.."Count")
				border = getglobal("zUF_TargetTargetDeBuffFrameDeBuff"..i.."Border")
				_, _, debuffTexture, debuffCount, debuffType = UnitDebuff("targettarget", i)
				if debuffTexture then
					icon:SetTexture(debuffTexture)
					if debuffCount > 1 then
						count:SetText(debuffCount)
						count:Show()
					else
						count:Hide()
					end
					color = DebuffTypeColor[(debuffType or "none")]
					border:SetVertexColor(color.r, color.g, color.b)
					button:Show()
				else
					button:Hide()
				end
			end
		else
			for i = 1, zUF_MAX_TARGETTARGET_DEBUFFS do
				getglobal("zUF_TargetTargetDeBuffFrameDeBuff"..i):Hide()
			end
		end
	end
end