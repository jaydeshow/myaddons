if ZUF_Style then
--[[ Style ]]
-- borders
PlayerFrameTexture:Hide()
PlayerFrameExtraBorder:Hide()
PetFrameTexture:Hide()
TargetFrameTexture:Hide()
TargetofTargetTexture:Hide()
TargetofTargetBackground:SetPoint("BOTTOMLEFT",45,15)
if TargetofTargetTargetFrame then
	TargetofTargetTargetFrameTexture:Hide()
	TargetofTargetTargetFramePortrait:ClearAllPoints()
	TargetofTargetTargetFramePortrait:SetPoint("Right", TargetofTargetTargetFrameHealthBar, "Left")
end
for i = 1, 4 do
	getglobal("PartyMemberFrame"..i.."Texture"):Hide()
	getglobal("PartyMemberFrame"..i.."PetFrameTexture"):Hide()
end

-- status bar heights
PlayerFrameHealthBar:SetHeight(10)
PlayerFrameManaBar:SetHeight(10)
TargetFrameHealthBar:SetHeight(10)
TargetFrameManaBar:SetHeight(10)
PetFrameHealthBar:SetHeight(6)
PetFrameManaBar:SetHeight(6)
for i = 1, 4 do
	getglobal("PartyMemberFrame"..i.."HealthBar"):SetHeight(8)
	getglobal("PartyMemberFrame"..i.."ManaBar"):SetHeight(8)
	getglobal("PartyMemberFrame"..i.."PetFrameHealthBar"):SetHeight(8)
end

-- override target name color
local zOld_TargetFrame_CheckFaction = TargetFrame_CheckFaction
function TargetFrame_CheckFaction()
	zOld_TargetFrame_CheckFaction()
	TargetFrameNameBackground:SetAlpha(0.5)
end
-- override target Elite
TargetFrameTextureFrame:CreateFontString("TargetElite", "BACKGROUND")
TargetElite:SetFont("Fonts\\FZLBJW.TTF",15,"OUTLINE")
TargetElite:SetShadowOffset(1,-1)
TargetElite:SetShadowColor(0,0,0)
TargetElite:SetJustifyH("LEFT")
TargetElite:SetPoint("LEFT",TargetFrameTextureFrame,"CENTER",70,-16)
TargetElite:SetText(ELITE)
TargetElite:SetTextColor(1.0,1.0,0.1)
local zOld_TargetFrame_CheckClassification = TargetFrame_CheckClassification
function TargetFrame_CheckClassification()
	zOld_TargetFrame_CheckClassification()
	if TargetFrameTexture:GetTexture() == "Interface\\TargetingFrame\\UI-TargetingFrame-Elite" then
		TargetElite:Show()
	else
		TargetElite:Hide()
	end
end
-- text outlines
PlayerLevelText:SetFont("Fonts\\FZLBJW.TTF",15,"OUTLINE")
TargetLevelText:SetFont("Fonts\\FZLBJW.TTF",15,"OUTLINE")
end