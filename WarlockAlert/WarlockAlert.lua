local L = AceLibrary("AceLocale-2.2"):new("WarlockAlert")

--WarlockAlert.xml
WARLOCKALERT_PROC = L["Proc"]
WARLOCKALERT_HP_MANA = L["HP/Mana"]
--textures.xml
WARLOCKALERT_SHADOWTRANCE = L["ShadowTrance!"]
WARLOCKALERT_BACKLASH = L["Backlash!"]
--proc.xml hpmana.xml
WARLOCKALERT_PROC_SHADOWTRANCEL = L["Shadow Trance"]
WARLOCKALERT_PROC_BACKLASHL = L["Backlash"]
WARLOCKALERT_SETMESSAGE = L["Set Message:"]
WARLOCKALERT_FULL_SCREEN_FLASH = L["Full Screen Flash"]
WARLOCKALERT_TEXT_MESSAGE = L["Text Message"]
WARLOCKALERT_ONLY_IN_COMBAT = L["Only In Combat"]
WARLOCKALERT_HEALTH_WARNING = L["Health Warning"]
WARLOCKALERT_MANA_WARNING = L["Mana Warning"]
WARLOCKALERT_HEALTH_TRESHOLD = L["Health treshold"]
WARLOCKALERT_MANA_TRESHOLD = L["Mana treshold"]
WARLOCKALERT_SOULSHARD = L["SoulShard"]
WARLOCKALERT_SOUNDS = L["Sounds"]
WARLOCKALERT_TEXTURE = L["Texture"]
WARLOCKALERT_SIZE = L["Size"]
local options = { 
    type='group',
    args = {
		config = {
	    	name = L["config"],
		    type = 'execute',
		    desc = L["brings up the config menu"],
	    	func = "showsomething"
		},
	},
}
WarlockAlert = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0");
WarlockAlert:RegisterChatCommand({"/WarlockAlert", "/WA"}, options)

-----------------------------------------------------------------
-----------------------------------------------------------------

WarlockAlert:RegisterDB("WarlockAlertDB", "WarlockAlertDBPC")
WarlockAlert:RegisterDefaults("profile", {
	nfFlashVisibility = true,
	nfTextVisibility = true,
	nfmessage = L["Shadow Trance"],
	nfcolor = {
	    r = 0.6,
	    g = 0,
	    b = 1,
		a = 1,
	    On = true,
	},
	blFlashVisibility = true,
	blTextVisibility = true,
	blmessage = L["Backlash"],
	blcolor = {
	    r = 1,
	    g = 0.25,
	    b = 0,
		a = 1,
	    On = true,
	},
	ssFlashVisibility = true,
	SoundEnabled = true,
	InGameSoundEnabled = true,
	SoundName = "RaidWarning",
	NFsnr = 1,
	NFtexture = "WaTexturesFrameTextureNF1",
	NFSize = 1,
	BLsnr = 1,
	BLtexture = "WaTexturesFrameTextureBL1",
	BLSize= 1,
	HealthFlashVisibility = true,
	HealthOnlyInCombat = true,
	HealthTreshold = 0.8,	
	ManaFlashVisibility = true,
	ManaOnlyInCombat = true,
	ManaTreshold = 0.8	
})
-----------------------------------------------------------------
-----------------------------------------------------------------

function WarlockAlert:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("PLAYER_DEAD")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("UNIT_MANA")
	if self:GetProfile() == "Default" then
		self:SetProfile("char")
	end
	WaConfigFrameTexture_OnLoad();
	WarlockAlert.NFTest = false
	WarlockAlert.BLTest = false
	GameTooltip:Hide()
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WarlockAlert:CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS()
	if (string.find(arg1, L["Backlash"])) then
		if WarlockAlert.db.profile.blFlashVisibility then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureBL)
			UIFrameFlash(WaTexturesFrameTextureBL, 0.2, 0.8, 10, false, 0.2, 0)
			WarlockAlert.db.profile.BLtexture:SetVertexColor(WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b, WarlockAlert.db.profile.blcolor.a)
		end
		if WarlockAlert.db.profile.blTextVisibility then
			BacklashTextStr:SetTextColor(WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b, 1)
			BacklashTextStr:SetText(WarlockAlert.db.profile.blmessage)
			UIFrameFlashRemoveFrame(BacklashTextStr)
			BacklashTextStr:Show()
			if ShadowTranceTextStr:IsShown() then
				ShadowTranceTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 40)
			end			
		end
		if WarlockAlert.db.profile.SoundEnabled then
			if WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySound(WarlockAlert.db.profile.SoundName)
			elseif not WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySoundFile("Interface\\AddOns\\WarlockAlert\\Sounds\\Backlash.mp3");
			end
		end
	end
	if (string.find(arg1, L["Shadow Trance"])) then
		if WarlockAlert.db.profile.nfFlashVisibility then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureNF)
			WarlockAlert.db.profile.NFtexture:SetVertexColor(WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b, WarlockAlert.db.profile.nfcolor.a)
			UIFrameFlash(WaTexturesFrameTextureNF, 0.2, 0.8, 10, false, 0.2, 0)
		end
		if WarlockAlert.db.profile.nfTextVisibility then
			ShadowTranceTextStr:SetTextColor(WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b, 1)
			ShadowTranceTextStr:SetText(WarlockAlert.db.profile.nfmessage)
			UIFrameFlashRemoveFrame(ShadowTranceTextStr)
			ShadowTranceTextStr:Show()
			if BacklashTextStr:IsShown() then
				BacklashTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 40)
			end			

		end
		if WarlockAlert.db.profile.SoundEnabled then
			if WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySound(WarlockAlert.db.profile.SoundName)
			elseif not WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySoundFile("Interface\\AddOns\\WarlockAlert\\Sounds\\ShadowTrance.mp3");
			end
		end
	end
end

-----------------------------------------------------------------

function WarlockAlert:CHAT_MSG_SPELL_AURA_GONE_SELF()
	if (string.find(arg1, L["Backlash"])) then
		if WarlockAlert.db.profile.blFlashVisibility  then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureBL)
			UIFrameFadeOut(WaTexturesFrameTextureBL, 0.4, WaTexturesFrameTextureBL:GetAlpha(), 0)
		end
		if BacklashTextStr:IsShown() then
			UIFrameFadeOut(BacklashTextStr, 0.4, BacklashTextStr:GetAlpha(), 0)
			ShadowTranceTextStr:SetPoint("CENTER", WaTexturesFrame)
		end
	end
	if (string.find(arg1, L["Shadow Trance"])) then
		if WarlockAlert.db.profile.nfFlashVisibility  then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureNF)
			UIFrameFadeOut(WaTexturesFrameTextureNF, 0.4, WaTexturesFrameTextureNF:GetAlpha(), 0)
		end
		if ShadowTranceTextStr:IsShown() then
			UIFrameFadeOut(ShadowTranceTextStr, 0.4, ShadowTranceTextStr:GetAlpha(), 0)
			BacklashTextStr:SetPoint("CENTER", WaTexturesFrame)
		end
	end
end

-----------------------------------------------------------------

function WarlockAlert:CHAT_MSG_LOOT()
	if (string.find(arg1, L["create"]) and string.find(arg1, L["Soul Shard"])) then
		if WarlockAlert.db.profile.ssFlashVisibility then
			UIFrameFlash(WaTexturesFrameTextureSS, 0.3, 0.7, 1, false, 0, 0)
		end
	end
end

-----------------------------------------------------------------

function WarlockAlert:PLAYER_DEAD()
	if WaTexturesFrameTextureNF:IsShown() then
		UIFrameFadeOut(WaTexturesFrameTextureNF, 0.4, WaTexturesFrameTextureNF:GetAlpha(), 0)
	end
	if ShadowTranceTextStr:IsShown() then
		UIFrameFadeOut(ShadowTranceTextStr, 0.4, ShadowTranceTextStr:GetAlpha(), 0)
	end
	ShadowTranceTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 0)
	if WaTexturesFrameTextureBL:IsShown() then
		UIFrameFadeOut(WaTexturesFrameTextureBL, 0.4, WaTexturesFrameTextureBL:GetAlpha(), 0)
	end
	if BacklashTextStr:IsShown() then
		UIFrameFadeOut(BacklashTextStr, 0.4, BacklashTextStr:GetAlpha(), 0)
	end
	BacklashTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 0)
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WaConfigFrame_OnShow()
	WaConfigFrameProc:Show()
end

function WaConfigFrame_OnHide()
	if WarlockAlert.NFTest == true then
		WarlockAlert.NFTest = false
		if WaTexturesFrameTextureNF:IsShown() then
			UIFrameFadeOut(WaTexturesFrameTextureNF, 0.4, WaTexturesFrameTextureNF:GetAlpha(), 0)
		end
		if ShadowTranceTextStr:IsShown() then
			UIFrameFadeOut(ShadowTranceTextStr, 0.4, ShadowTranceTextStr:GetAlpha(), 0)
		end
		ShadowTranceTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 0)
	end
	if WarlockAlert.BLTest == true then
		WarlockAlert.BLTest = false
		if WaTexturesFrameTextureBL:IsShown() then
			UIFrameFadeOut(WaTexturesFrameTextureBL, 0.4, WaTexturesFrameTextureBL:GetAlpha(), 0)
		end
		if BacklashTextStr:IsShown() then
			UIFrameFadeOut(BacklashTextStr, 0.4, BacklashTextStr:GetAlpha(), 0)
		end
		BacklashTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 0)
	end
end

function WaConfigFrameProc_OnShow()
	if WarlockAlert.db.profile.nfFlashVisibility then
		WaConfigFrameNFFlashCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.nfFlashVisibility then
		WaConfigFrameNFFlashCheckButton:SetChecked("false");
	end
	if WarlockAlert.db.profile.nfTextVisibility then
		WaConfigFrameNFTextCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.nfTextVisibility then
		WaConfigFrameNFTextCheckButton:SetChecked("false");
	end
	if WarlockAlert.db.profile.blFlashVisibility then
		WaConfigFrameBLFlashCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.blFlashVisibility then
		WaConfigFrameBLFlashCheckButton:SetChecked("false");
	end
	if WarlockAlert.db.profile.blTextVisibility then
		WaConfigFrameBLTextCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.blTextVisibility then
		WaConfigFrameBLTextCheckButton:SetChecked("false");
	end
	NFMessageEditBox:SetText(WarlockAlert.db.profile.nfmessage);
	BLMessageEditBox:SetText(WarlockAlert.db.profile.blmessage);
	WaBLColorChangeButtonNormalTexture:SetVertexColor(WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b)
	WaNFColorChangeButtonNormalTexture:SetVertexColor(WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b)
end

function WarlockAlert:showsomething()
	WaConfigFrame:Show()
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WaNFColorChangeButton_OnClick()
	ColorPickerFrame.func = WaNFColorChangeButton_FUNCTION
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacityFunc = WaNFColorChangeButton_opacityFUNCTION
	ColorPickerFrame.cancelFunc = WaNFColorChangeButton_cancelFUNCTION
	ColorPickerFrame:SetColorRGB(WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b);
	ColorPickerFrame.previousValues = {WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b, WarlockAlert.db.profile.nfcolor.a}
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacity = (1-WarlockAlert.db.profile.nfcolor.a);
	ColorPickerFrame:Show();
end


function WaNFColorChangeButton_FUNCTION()
	 WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b = ColorPickerFrame:GetColorRGB();
	 WaNFColorChangeButtonNormalTexture:SetVertexColor(WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b)
end

function WaNFColorChangeButton_opacityFUNCTION()
	WarlockAlert.db.profile.nfcolor.a = (1-OpacitySliderFrame:GetValue());
end

function WaNFColorChangeButton_cancelFUNCTION(prevvals)
	WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b, WarlockAlert.db.profile.nfcolor.a = unpack(prevvals)
end

function WarlockAlert_NFFlashCheckbuttononclick()
    WarlockAlert.db.profile.nfFlashVisibility = not WarlockAlert.db.profile.nfFlashVisibility
end

function WarlockAlert_NFTextCheckbuttononclick()
    WarlockAlert.db.profile.nfTextVisibility = not WarlockAlert.db.profile.nfTextVisibility
end

--------------------------------

function WaBLColorChangeButton_OnClick()
	ColorPickerFrame.func = WaBLColorChangeButton_FUNCTION
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacityFunc = WaBLColorChangeButton_opacityFUNCTION
	ColorPickerFrame.cancelFunc = WaBLColorChangeButton_cancelFUNCTION
	ColorPickerFrame:SetColorRGB(WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b);
	ColorPickerFrame.previousValues = {WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b, WarlockAlert.db.profile.blcolor.a}
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacity = (1-WarlockAlert.db.profile.blcolor.a);
	ColorPickerFrame:Show();
end

function WaBLColorChangeButton_FUNCTION()
	 WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b = ColorPickerFrame:GetColorRGB();
	 WaBLColorChangeButtonNormalTexture:SetVertexColor(WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b)
end

function WaBLColorChangeButton_opacityFUNCTION()
	WarlockAlert.db.profile.blcolor.a = (1-OpacitySliderFrame:GetValue());
end

function WaBLColorChangeButton_cancelFUNCTION(prevvals)
	WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b, WarlockAlert.db.profile.blcolor.a = unpack(prevvals)
end

function WarlockAlert_BLFlashCheckbuttononclick()
    WarlockAlert.db.profile.blFlashVisibility = not WarlockAlert.db.profile.blFlashVisibility
end

function WarlockAlert_BLTextCheckbuttononclick()
    WarlockAlert.db.profile.blTextVisibility = not WarlockAlert.db.profile.blTextVisibility
end

--------------------------------

function NFMessageEditBox_OnChar()
	    WarlockAlert.db.profile.nfmessage = NFMessageEditBox:GetText()
end

function BLMessageEditBox_OnChar()
	    WarlockAlert.db.profile.blmessage = BLMessageEditBox:GetText()
end

--------------------------------

function WarlockAlert_WaConfigFrameSSFlashCheckButtononclick()
    WarlockAlert.db.profile.ssFlashVisibility = not WarlockAlert.db.profile.ssFlashVisibility
end

--------------------------------

function WarlockAlert_WaConfigFrameSoundCheckButtononclick()
    WarlockAlert.db.profile.SoundEnabled = not WarlockAlert.db.profile.SoundEnabled
	if WarlockAlert.db.profile.SoundEnabled then
		WaConfigFrameIGSCheckButton:Enable();
		IGS:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	elseif not WarlockAlert.db.profile.SoundEnabled then
		WaConfigFrameIGSCheckButton:Disable();
		IGS:SetVertexColor(0.5, 0.5, 0.5);
	end
end

function WarlockAlert_IGSCheckButtononclick()
    WarlockAlert.db.profile.InGameSoundEnabled = not WarlockAlert.db.profile.InGameSoundEnabled
end

function IGSNameEditBox_OnChar()
	    WarlockAlert.db.profile.SoundName = IGSNameEditBox:GetText()
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WaConfigFrameTexture_OnLoad()
	WaTexturesFrameTextureNF1:SetAllPoints(WorldUi)
	WaTexturesFrameTextureNF2:SetAllPoints(WorldUi)
	WaTexturesFrameTextureBL1:SetAllPoints(WorldUi)
	WaTexturesFrameTextureBL2:SetAllPoints(WorldUi)
	WaConfigFrameTextureNFSlider:SetValue(WarlockAlert.db.profile.NFsnr)
	WaConfigFrameTextureNFSize:SetValue(WarlockAlert.db.profile.NFSize)
	WaConfigFrameTextureBLSlider:SetValue(WarlockAlert.db.profile.BLsnr)
	WaConfigFrameTextureBLSize:SetValue(WarlockAlert.db.profile.BLSize)
	WaTexturesFrameTextureSST:SetVertexColor(1, 0.5, 0.8, 1)
end

-----------------------------------------------------------------

function WaConfigFrameTextureNFSize_OnValueChanged()
		WarlockAlert.db.profile.NFSize = WaConfigFrameTextureNFSize:GetValue()
		WaTexturesFrameTextureNF:SetHeight(512*WarlockAlert.db.profile.NFSize)
		WaTexturesFrameTextureNF:SetWidth(512*WarlockAlert.db.profile.NFSize)
end

function WaConfigFrameTextureNFSlider_OnValueChanged()
		WarlockAlert.db.profile.NFsnr = WaConfigFrameTextureNFSlider:GetValue()
		WaTexturesFrameTextureNF1:SetAlpha(0)
		WaTexturesFrameTextureNF2:SetAlpha(0)
		WaTexturesFrameTextureNF3:SetAlpha(0)
		WaTexturesFrameTextureNF4:SetAlpha(0)
		WaTexturesFrameTextureNF5:SetAlpha(0)
		if WarlockAlert.db.profile.NFsnr == 1 then
			WarlockAlert.db.profile.NFtexture = WaTexturesFrameTextureNF1
		elseif WarlockAlert.db.profile.NFsnr == 2 then
			WarlockAlert.db.profile.NFtexture = WaTexturesFrameTextureNF2
		elseif WarlockAlert.db.profile.NFsnr == 3 then
			WarlockAlert.db.profile.NFtexture = WaTexturesFrameTextureNF3
		elseif WarlockAlert.db.profile.NFsnr == 4 then
			WarlockAlert.db.profile.NFtexture = WaTexturesFrameTextureNF4
		elseif WarlockAlert.db.profile.NFsnr == 5 then
			WarlockAlert.db.profile.NFtexture = WaTexturesFrameTextureNF5
		end
end

-----------------------------------------------------------------

function WaConfigFrameTextureBLSlider_OnValueChanged()
		WarlockAlert.db.profile.BLsnr = WaConfigFrameTextureBLSlider:GetValue()
		WaTexturesFrameTextureBL1:SetAlpha(0)
		WaTexturesFrameTextureBL2:SetAlpha(0)
		WaTexturesFrameTextureBL3:SetAlpha(0)
		WaTexturesFrameTextureBL4:SetAlpha(0)
		WaTexturesFrameTextureBL5:SetAlpha(0)
		if WarlockAlert.db.profile.BLsnr == 1 then
			WarlockAlert.db.profile.BLtexture = WaTexturesFrameTextureBL1
		elseif WarlockAlert.db.profile.BLsnr == 2 then
			WarlockAlert.db.profile.BLtexture = WaTexturesFrameTextureBL2
		elseif WarlockAlert.db.profile.BLsnr == 3 then
			WarlockAlert.db.profile.BLtexture = WaTexturesFrameTextureBL3
		elseif WarlockAlert.db.profile.BLsnr == 4 then
			WarlockAlert.db.profile.BLtexture = WaTexturesFrameTextureBL4
		elseif WarlockAlert.db.profile.BLsnr == 5 then
			WarlockAlert.db.profile.BLtexture = WaTexturesFrameTextureBL5
		end
end

function WaConfigFrameTextureBLSize_OnValueChanged()
		WarlockAlert.db.profile.BLSize = WaConfigFrameTextureBLSize:GetValue()
		WaTexturesFrameTextureBL:SetHeight(512*WarlockAlert.db.profile.BLSize)
		WaTexturesFrameTextureBL:SetWidth(512*WarlockAlert.db.profile.BLSize)
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WaConfigFrameHPMANA_OnShow()
	if WarlockAlert.db.profile.HealthFlashVisibility then
		WaConfigFrameHPFlashCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.HealthFlashVisibility then
		WaConfigFrameHPFlashCheckButton:SetChecked("false");
	end
	if WarlockAlert.db.profile.HealthOnlyInCombat then
		WaConfigFrameHPInCombatButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.HealthOnlyInCombat then
		WaConfigFrameHPInCombatButton:SetChecked("false");
	end
	WaConfigFrameTextureHPSlider:SetValue(WarlockAlert.db.profile.HealthTreshold*100)
	if WarlockAlert.db.profile.ManaFlashVisibility then
		WaConfigFrameManaFlashCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.ManaFlashVisibility then
		WaConfigFrameManaFlashCheckButton:SetChecked("false");
	end
	if WarlockAlert.db.profile.ManaOnlyInCombat then
		WaConfigFrameManaInCombatButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.ManaOnlyInCombat then
		WaConfigFrameManaInCombatButton:SetChecked("false");
	end
	WaConfigFrameTextureManaSlider:SetValue(WarlockAlert.db.profile.ManaTreshold*100)
	if WarlockAlert.db.profile.ssFlashVisibility then
		WaConfigFrameSSFlashCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.ssFlashVisibility then
		WaConfigFrameSSFlashCheckButton:SetChecked("false");
	end
	if WarlockAlert.db.profile.SoundEnabled then
		WaConfigFrameSoundCheckButton:SetChecked("true");
		WaConfigFrameIGSCheckButton:Enable();
		IGS:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	elseif not WarlockAlert.db.profile.SoundEnabled then
		WaConfigFrameSoundCheckButton:SetChecked("false");
		WaConfigFrameIGSCheckButton:Disable();
		IGS:SetVertexColor(0.5, 0.5, 0.5);
	end
	if WarlockAlert.db.profile.InGameSoundEnabled then
		WaConfigFrameIGSCheckButton:SetChecked("true");
	elseif not WarlockAlert.db.profile.InGameSoundEnabled then
		WaConfigFrameIGSCheckButton:SetChecked("false");
	end
	IGSNameEditBox:SetText(WarlockAlert.db.profile.SoundName);
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WarlockAlert:PLAYER_REGEN_DISABLED()
	WarlockAlert.inCombat = true
end

function WarlockAlert:PLAYER_REGEN_ENABLED()
	WarlockAlert.inCombat = false
	if WarlockAlert.db.profile.HealthOnlyInCombat then
		if UIFrameIsFlashing(WaTexturesFrameTextureHP) then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureHP)
			UIFrameFadeOut(WaTexturesFrameTextureHP, 0.4, WaTexturesFrameTextureHP:GetAlpha(), 0)
		end
	end
	if WarlockAlert.db.profile.ManaOnlyInCombat then
		if UIFrameIsFlashing(WaTexturesFrameTextureMana) then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureMana)
			UIFrameFadeOut(WaTexturesFrameTextureMana, 0.4, WaTexturesFrameTextureMana:GetAlpha(), 0)
		end
	end
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WarlockAlert:UNIT_HEALTH(unit)
	if WarlockAlert.db.profile.HealthFlashVisibility then
		if unit == "player" then
			if UnitHealth("player") / UnitHealthMax("player") <= (WarlockAlert.db.profile.HealthTreshold) and
			not UnitIsDeadOrGhost("player") then
				if WarlockAlert.db.profile.HealthOnlyInCombat then
					if WarlockAlert.inCombat == true then
						if UIFrameIsFlashing(WaTexturesFrameTextureHP) == nil then
							UIFrameFlash(WaTexturesFrameTextureHP, 0.2, 0.8, 10000, true, 0.2, 0)
						end
					end
				elseif not WarlockAlert.db.profile.HealthOnlyInCombat then
					if UIFrameIsFlashing(WaTexturesFrameTextureHP) == nil then
						UIFrameFlash(WaTexturesFrameTextureHP, 0.2, 0.8, 10000, true, 0.2, 0)
					end
				end
			elseif UnitHealth("player") / UnitHealthMax("player") > (WarlockAlert.db.profile.HealthTreshold) then
				if UIFrameIsFlashing(WaTexturesFrameTextureHP) then
					UIFrameFlashRemoveFrame(WaTexturesFrameTextureHP)
					UIFrameFadeOut(WaTexturesFrameTextureHP, 0.4, WaTexturesFrameTextureHP:GetAlpha(), 0)
				end
			end
		end
	end
end

-----------------------------------------------------------------

function WaConfigFrameTextureHPSlider_OnValueChanged()
		WarlockAlert.db.profile.HealthTreshold = WaConfigFrameTextureHPSlider:GetValue()/100
end

function WarlockAlert_HPFlashCheckbuttononclick()
    WarlockAlert.db.profile.HealthFlashVisibility = not WarlockAlert.db.profile.HealthFlashVisibility
end

function WarlockAlert_HPInCombatCheckbuttononclick()
    WarlockAlert.db.profile.HealthOnlyInCombat = not WarlockAlert.db.profile.HealthOnlyInCombat
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function WarlockAlert:UNIT_MANA(unit)
	if WarlockAlert.db.profile.ManaFlashVisibility then
		if unit == "player" then
			if UnitMana("player") / UnitManaMax("player") < (WarlockAlert.db.profile.ManaTreshold) and
			not UnitIsDeadOrGhost("player") then
				if WarlockAlert.db.profile.ManaOnlyInCombat then
					if WarlockAlert.inCombat == true then
						if UIFrameIsFlashing(WaTexturesFrameTextureMana) == nil then
							UIFrameFlash(WaTexturesFrameTextureMana, 0.2, 0.8, 10000, true, 0.2, 0)
						end
					end
				elseif not WarlockAlert.db.profile.ManaOnlyInCombat then
					if UIFrameIsFlashing(WaTexturesFrameTextureMana) == nil then
						UIFrameFlash(WaTexturesFrameTextureMana, 0.2, 0.8, 10000, true, 0.2, 0)
					end
				end
			elseif UnitMana("player") / UnitManaMax("player") >= (WarlockAlert.db.profile.ManaTreshold) then
				if UIFrameIsFlashing(WaTexturesFrameTextureMana) then
					UIFrameFlashRemoveFrame(WaTexturesFrameTextureMana)
					UIFrameFadeOut(WaTexturesFrameTextureMana, 0.4, WaTexturesFrameTextureMana:GetAlpha(), 0)
				end
			end
		end
	end
end

-----------------------------------------------------------------

function WaConfigFrameTextureManaSlider_OnValueChanged()
		WarlockAlert.db.profile.ManaTreshold = WaConfigFrameTextureManaSlider:GetValue()/100
end

function WarlockAlert_ManaFlashCheckbuttononclick()
    WarlockAlert.db.profile.ManaFlashVisibility = not WarlockAlert.db.profile.ManaFlashVisibility
end

function WarlockAlert_ManaInCombatCheckbuttononclick()
    WarlockAlert.db.profile.ManaOnlyInCombat = not WarlockAlert.db.profile.ManaOnlyInCombat
end

-----------------------------------------------------------------
-----------------------------------------------------------------

function BLTest()
	if 	WarlockAlert.BLTest == false then
		WarlockAlert.BLTest = true
		if WarlockAlert.db.profile.blFlashVisibility then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureBL)
			WarlockAlert.db.profile.BLtexture:SetVertexColor(WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b, WarlockAlert.db.profile.blcolor.a)
			UIFrameFlash(WaTexturesFrameTextureBL, 0.2, 0.8, 1000, false, 0.2, 0)
		end
		if WarlockAlert.db.profile.blTextVisibility then
			BacklashTextStr:SetTextColor(WarlockAlert.db.profile.blcolor.r, WarlockAlert.db.profile.blcolor.g, WarlockAlert.db.profile.blcolor.b, 1)
			BacklashTextStr:SetText(WarlockAlert.db.profile.blmessage)
			UIFrameFlashRemoveFrame(BacklashTextStr)
			BacklashTextStr:Show()
			if ShadowTranceTextStr:IsShown() then
				ShadowTranceTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 40)
			end			
		end
		if WarlockAlert.db.profile.SoundEnabled then
			if WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySound(WarlockAlert.db.profile.SoundName)
			elseif not WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySoundFile("Interface\\AddOns\\WarlockAlert\\Sounds\\Backlash.mp3");
			end
		end
	elseif WarlockAlert.BLTest == true then
		WarlockAlert.BLTest = false
		if WaTexturesFrameTextureBL:IsShown() then
			UIFrameFadeOut(WaTexturesFrameTextureBL, 0.4, WaTexturesFrameTextureBL:GetAlpha(), 0)
		end
		if BacklashTextStr:IsShown() then
			UIFrameFadeOut(BacklashTextStr, 0.4, BacklashTextStr:GetAlpha(), 0)
		end
		BacklashTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 0)
	end
end

-----------------------------------------------------------------

function NFTest()
	if 	WarlockAlert.NFTest == false then
		WarlockAlert.NFTest = true
		if WarlockAlert.db.profile.nfFlashVisibility then
			UIFrameFlashRemoveFrame(WaTexturesFrameTextureNF)
			WarlockAlert.db.profile.NFtexture:SetVertexColor(WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b, WarlockAlert.db.profile.nfcolor.a)
			UIFrameFlash(WaTexturesFrameTextureNF, 0.2, 0.8, 1000, false, 0.2, 0)
		end
		if WarlockAlert.db.profile.nfTextVisibility then
			ShadowTranceTextStr:SetTextColor(WarlockAlert.db.profile.nfcolor.r, WarlockAlert.db.profile.nfcolor.g, WarlockAlert.db.profile.nfcolor.b, 1)
			ShadowTranceTextStr:SetText(WarlockAlert.db.profile.nfmessage)
			UIFrameFlashRemoveFrame(ShadowTranceTextStr)
			ShadowTranceTextStr:Show()
			if BacklashTextStr:IsShown() then
				BacklashTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 40)
			end			
		end
		if WarlockAlert.db.profile.SoundEnabled then
			if WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySound(WarlockAlert.db.profile.SoundName)
			elseif not WarlockAlert.db.profile.InGameSoundEnabled then
				PlaySoundFile("Interface\\AddOns\\WarlockAlert\\Sounds\\ShadowTrance.mp3");
			end
		end
	elseif WarlockAlert.NFTest == true then
		WarlockAlert.NFTest = false
		if WaTexturesFrameTextureNF:IsShown() then
			UIFrameFadeOut(WaTexturesFrameTextureNF, 0.4, WaTexturesFrameTextureNF:GetAlpha(), 0)
		end
		if ShadowTranceTextStr:IsShown() then
			UIFrameFadeOut(ShadowTranceTextStr, 0.4, ShadowTranceTextStr:GetAlpha(), 0)
		end
		ShadowTranceTextStr:SetPoint("CENTER", WaTexturesFrame, "CENTER", 0, 0)
	end
end



