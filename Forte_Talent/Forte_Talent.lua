-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x
local TA = FW:Module("Talent");
local FW = FW;

local SelectedSpecc;
local BuiltSpecc = {[1]={},[2]={},[3]={}};

function TA:BuildTab(n,str)
	FW:ERASE(BuiltSpecc[n]);
	BuiltSpecc[n][0] = 0;
	local r;
	for i=1,string.len(str),3 do
		r = tonumber(strsub(str,i+2,i+2));
		BuiltSpecc[n][tonumber(strsub(str,i,i+1))] = r;
		BuiltSpecc[n][0] = BuiltSpecc[n][0] + r;
	end
end

function TA:SelectSpecc(name)
	if name ~= FW.PLAYER and FC_Saved.Speccs[FW.CLASS][name] then
		SelectedSpecc = name;
		local tab1,tab2,tab3 = strsplit(" ",FC_Saved.Speccs[FW.CLASS][name]);
		TA:BuildTab(1,tab1);
		TA:BuildTab(2,tab2);
		TA:BuildTab(3,tab3);
	else
		SelectedSpecc = nil;
	end
	if PlayerTalentFrame then 
		TalentFrame_Update(PlayerTalentFrame);
	end
end

function TA:DeleteSpecc()
	if SelectedSpecc then
		FC_Saved.Speccs[FW.CLASS][SelectedSpecc] = nil;
		TA:ResetSpecc();
	end
end

function TA:ResetSpecc()
	TA:SelectSpecc(FW.PLAYER);
	UIDropDownMenu_SetSelectedValue(FWSpeccDropDown,FW.PLAYER);
	UIDropDownMenu_SetText(FW.PLAYER,FWSpeccDropDown);
end

function TA:TalentFrame_SetPrereqs(TalentFrame, buttonTier, buttonColumn, forceDesaturated, tierUnlocked, ...)
	if SelectedSpecc then
		local tier, column, isLearnable;
		local requirementsMet;
		if ( tierUnlocked and not forceDesaturated ) then
			requirementsMet = 1;
		else
			requirementsMet = nil;
		end
		for i=1, select("#", ...), 3 do
			tier, column, isLearnable = select(i, ...);
			if (forceDesaturated) then
				requirementsMet = nil;
			end
			TalentFrame_DrawLines(buttonTier, buttonColumn, tier, column, requirementsMet, TalentFrame);
		end
		return requirementsMet;
	end
end

local TA_OriginalSetPortraitTexture;
local function TA_SetPortraitTexture(p,u)
	if SelectedSpecc and p == PlayerTalentFramePortrait and u == "player" then
		local id = FW:NameToRaidID(SelectedSpecc) or FW:NameToPartyID(SelectedSpecc);
		if id then
			TA_OriginalSetPortraitTexture(p,id);
		else
			SetPortraitToTexture(p,"Interface\\CharacterFrame\\TempPortrait");
		end
	else
		TA_OriginalSetPortraitTexture(p,u);
	end
	
end

local TA_OriginalTalentFrame_Update;
local function TA_TalentFrame_Update(TalentFrame)
	if TalentFrame ~= PlayerTalentFrame or not SelectedSpecc then
		TA_OriginalTalentFrame_Update(TalentFrame);
	else
		-- Setup Tabs
		local numTabs = GetNumTalentTabs();
		for i=1, MAX_TALENT_TABS do
			tab = getglobal("PlayerTalentFrameTab"..i);
			if ( i <= numTabs ) then
				local name, _, _ = GetTalentTabInfo(i);
				
				if ( i == PanelTemplates_GetSelectedTab(PlayerTalentFrame) ) then
					-- If tab is the selected tab set the points spent info
					TalentFrame.pointsSpent = BuiltSpecc[i][0];
					getglobal("PlayerTalentFrameSpentPoints"):SetText(format(MASTERY_POINTS_SPENT, name).." "..HIGHLIGHT_FONT_COLOR_CODE..TalentFrame.pointsSpent..FONT_COLOR_CODE_CLOSE);
				end
				tab:SetText(name);
				PanelTemplates_TabResize(10, tab);
				tab:Show();
			else
				tab:Hide();
			end
		end

		PanelTemplates_SetNumTabs(PlayerTalentFrame, numTabs);
		PanelTemplates_UpdateTabs(PlayerTalentFrame);

		SetPortraitTexture(PlayerTalentFramePortrait, PlayerTalentFrame.unit);
		
		PlayerTalentFrame.currentSelectedTab = PanelTemplates_GetSelectedTab(PlayerTalentFrame);
		
		TalentFrame_UpdateTalentPoints(TalentFrame);

		-- Setup Frame
		local base;
		local name, texture, points, fileName = GetTalentTabInfo(TalentFrame.currentSelectedTab, TalentFrame.inspect);
		if ( name ) then
			base = "Interface\\TalentFrame\\"..fileName.."-";
		else
			-- temporary default for classes without talents poor guys
			base = "Interface\\TalentFrame\\MageFire-";
		end

		getglobal(TalentFrame:GetName().."BackgroundTopLeft"):SetTexture(base.."TopLeft");
		getglobal(TalentFrame:GetName().."BackgroundTopRight"):SetTexture(base.."TopRight");
		getglobal(TalentFrame:GetName().."BackgroundBottomLeft"):SetTexture(base.."BottomLeft");
		getglobal(TalentFrame:GetName().."BackgroundBottomRight"):SetTexture(base.."BottomRight");

		local numTalents = GetNumTalents(TalentFrame.currentSelectedTab);
		-- Just a reminder error if there are more talents than available buttons
		if ( numTalents > MAX_NUM_TALENTS ) then
			message("Too many talents in talent frame!");
		end

		TalentFrame_ResetBranches(TalentFrame);
		local tier, column, rank, maxRank, isExceptional, isLearnable;
		local forceDesaturated, tierUnlocked;
		for i=1, MAX_NUM_TALENTS do
			local button = getglobal(TalentFrame:GetName().."Talent"..i);
			if ( i <= numTalents ) then
				-- Set the button info
				name, iconTexture, tier, column, _, maxRank, isExceptional, _ = GetTalentInfo(TalentFrame.currentSelectedTab, i);
				
				rank = BuiltSpecc[TalentFrame.currentSelectedTab][i] or 0;
				
				getglobal(TalentFrame:GetName().."Talent"..i.."Rank"):SetText(rank);
				SetTalentButtonLocation(button, tier, column);
				TalentFrame.TALENT_BRANCH_ARRAY[tier][column].id = button:GetID();

				-- If player has no talent points then show only talents with points in them
				if ( rank == 0 ) then
					forceDesaturated = 1;
				else
					forceDesaturated = nil;
				end

				-- If the player has spent at least 5 talent points in the previous tier
				if ( (tier - 1) * 5 <= TalentFrame.pointsSpent ) then
					tierUnlocked = 1;
				else
					tierUnlocked = nil;
				end
				SetItemButtonTexture(button, iconTexture);

				-- Talent must meet prereqs or the player must have no points to spend
				if ( TA:TalentFrame_SetPrereqs(TalentFrame, tier, column, forceDesaturated, tierUnlocked, GetTalentPrereqs(TalentFrame.currentSelectedTab, i))) then
					SetItemButtonDesaturated(button, nil);

					if ( rank < maxRank ) then
						-- Rank is green if not maxed out
						getglobal(TalentFrame:GetName().."Talent"..i.."Slot"):SetVertexColor(0.1, 1.0, 0.1);
						getglobal(TalentFrame:GetName().."Talent"..i.."Rank"):SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
					else
						getglobal(TalentFrame:GetName().."Talent"..i.."Slot"):SetVertexColor(1.0, 0.82, 0);
						getglobal(TalentFrame:GetName().."Talent"..i.."Rank"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
					end
					getglobal(TalentFrame:GetName().."Talent"..i.."RankBorder"):Show();
					getglobal(TalentFrame:GetName().."Talent"..i.."Rank"):Show();
				else
					SetItemButtonDesaturated(button, 1, 0.65, 0.65, 0.65);
					getglobal(TalentFrame:GetName().."Talent"..i.."Slot"):SetVertexColor(0.5, 0.5, 0.5);
					if ( rank == 0 ) then
						getglobal(TalentFrame:GetName().."Talent"..i.."RankBorder"):Hide();
						getglobal(TalentFrame:GetName().."Talent"..i.."Rank"):Hide();
					else
						getglobal(TalentFrame:GetName().."Talent"..i.."RankBorder"):SetVertexColor(0.5, 0.5, 0.5);
						getglobal(TalentFrame:GetName().."Talent"..i.."Rank"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
					end
				end

				button:Show();
			else	
				button:Hide();
			end
		end

		-- Draw the prerq branches
		local node;
		local textureIndex = 1;
		local xOffset, yOffset;
		local texCoords;
		-- Variable that decides whether or not to ignore drawing pieces
		local ignoreUp;
		local tempNode;
		TalentFrame_ResetBranchTextureCount(TalentFrame);
		TalentFrame_ResetArrowTextureCount(TalentFrame);
		for i=1, MAX_NUM_TALENT_TIERS do
			for j=1, NUM_TALENT_COLUMNS do
				node = TalentFrame.TALENT_BRANCH_ARRAY[i][j];

				-- Setup offsets
				xOffset = ((j - 1) * 63) + INITIAL_TALENT_OFFSET_X + 2;
				yOffset = -((i - 1) * 63) - INITIAL_TALENT_OFFSET_Y - 2;

				if ( node.id ) then
					-- Has talent
					if ( node.up ~= 0 ) then
						if ( not ignoreUp ) then
							TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset, yOffset + TALENT_BUTTON_SIZE, TalentFrame);
						else
							ignoreUp = nil;
						end
					end
					if ( node.down ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset, yOffset - TALENT_BUTTON_SIZE + 1, TalentFrame);
					end
					if ( node.left ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset - TALENT_BUTTON_SIZE, yOffset, TalentFrame);
					end
					if ( node.right ~= 0 ) then
						-- See if any connecting branches are gray and if so color them gray
						tempNode = TalentFrame.TALENT_BRANCH_ARRAY[i][j+1];	
						if ( tempNode.left ~= 0 and tempNode.down < 0 ) then
							TalentFrame_SetBranchTexture(i, j-1, TALENT_BRANCH_TEXTURECOORDS["right"][tempNode.down], xOffset + TALENT_BUTTON_SIZE, yOffset, TalentFrame);
						else
							TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE + 1, yOffset, TalentFrame);
						end

					end
					-- Draw arrows
					if ( node.rightArrow ~= 0 ) then
						TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["right"][node.rightArrow], xOffset + TALENT_BUTTON_SIZE/2 + 5, yOffset, TalentFrame);
					end
					if ( node.leftArrow ~= 0 ) then
						TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["left"][node.leftArrow], xOffset - TALENT_BUTTON_SIZE/2 - 5, yOffset, TalentFrame);
					end
					if ( node.topArrow ~= 0 ) then
						TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["top"][node.topArrow], xOffset, yOffset + TALENT_BUTTON_SIZE/2 + 5, TalentFrame);
					end
				else
					-- Doesn't have a talent
					if ( node.up ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tup"][node.up], xOffset , yOffset, TalentFrame);
					elseif ( node.down ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tdown"][node.down], xOffset , yOffset, TalentFrame);
					elseif ( node.left ~= 0 and node.down ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topright"][node.left], xOffset , yOffset, TalentFrame);
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, TalentFrame);
					elseif ( node.left ~= 0 and node.up ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomright"][node.left], xOffset , yOffset, TalentFrame);
					elseif ( node.left ~= 0 and node.right ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE, yOffset, TalentFrame);
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset + 1, yOffset, TalentFrame);
					elseif ( node.right ~= 0 and node.down ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topleft"][node.right], xOffset , yOffset, TalentFrame);
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, TalentFrame);
					elseif ( node.right ~= 0 and node.up ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomleft"][node.right], xOffset , yOffset, TalentFrame);
					elseif ( node.up ~= 0 and node.down ~= 0 ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset , yOffset, TalentFrame);
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, TalentFrame);
						ignoreUp = 1;
					end
				end
			end
		end
		-- Hide any unused branch textures
		for i=TalentFrame_GetBranchTextureCount(TalentFrame), MAX_NUM_BRANCH_TEXTURES do
			getglobal(TalentFrame:GetName().."Branch"..i):Hide();
		end
		-- Hide and unused arrowl textures
		for i=TalentFrame_GetArrowTextureCount(TalentFrame), MAX_NUM_ARROW_TEXTURES do
			getglobal(TalentFrame:GetName().."Arrow"..i):Hide();
		end
	end
end

local function TA_PlayerTalentFrameTalent_OnClick()
	if SelectedSpecc then return; end
	PlayerTalentFrameTalent_OnClick();
end

-- dropdown functions
local function TA_SpeccDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(FWSpeccDropDown, this.value);
	TA:SelectSpecc(this.value)
end

local function TA_SpeccDropDown_Initialize()
	if FW:IsWarlock("player") then
		local info = UIDropDownMenu_CreateInfo();
		if FC_Saved.Speccs[FW.CLASS] then
			for k,v in pairs(FC_Saved.Speccs[FW.CLASS]) do
				info.text = k;
				info.func = TA_SpeccDropDown_OnClick;
				info.value = k;
				info.checked = (k==SelectedSpecc);
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

local function TA_SetAnchors()
	if FWSpeccDropDown then
		FWSpeccDropDown:SetPoint("TOP",PlayerTalentFrameTitleText,"BOTTOM",-40+FW.Settings.TalentOffsetX,-7+FW.Settings.TalentOffsetY);
		FWSpeccDelete:SetPoint("TOP",PlayerTalentFrameTitleText,"BOTTOM",112+FW.Settings.TalentOffsetX,-4+FW.Settings.TalentOffsetY);
		FWSpeccReset:SetPoint("TOP",PlayerTalentFrameTitleText,"BOTTOM",64+FW.Settings.TalentOffsetX,-4+FW.Settings.TalentOffsetY);
	end
end

local function TA_CreateSpeccDropDown(frame)
	if frame == PlayerTalentFrame then
		if not FWSpeccDropDown then
			CreateFrame("Frame", "FWSpeccDropDown", PlayerTalentFrame, "UIDropDownMenuTemplate");
			UIDropDownMenu_Initialize(FWSpeccDropDown, TA_SpeccDropDown_Initialize);
			UIDropDownMenu_SetSelectedValue(FWSpeccDropDown,SelectedSpecc or FW.PLAYER);
			UIDropDownMenu_SetText(SelectedSpecc or FW.PLAYER,FWSpeccDropDown);	

			UIDropDownMenu_SetWidth(140, FWSpeccDropDown);
			UIDropDownMenu_JustifyText("LEFT", FWSpeccDropDown);
			FWSpeccDropDownLeft:SetHeight(50);
			FWSpeccDropDownMiddle:SetHeight(50);
			FWSpeccDropDownRight:SetHeight(50);
			FWSpeccDropDownButton:SetPoint("TOPRIGHT", FWSpeccDropDownRight, "TOPRIGHT", -16, -12);


			CreateFrame("Button", "FWSpeccDelete", PlayerTalentFrame, "UIPanelButtonTemplate");
			FWSpeccDelete:SetWidth(50);
			FWSpeccDelete:SetHeight(18);
			FWSpeccDelete:SetText("Delete");
			FWSpeccDelete:SetScript("OnClick",TA.DeleteSpecc);

			CreateFrame("Button", "FWSpeccReset", PlayerTalentFrame, "UIPanelButtonTemplate");
			FWSpeccReset:SetWidth(50);
			FWSpeccReset:SetHeight(18);
			FWSpeccReset:SetText("Reset");
			FWSpeccReset:SetScript("OnClick",TA.ResetSpecc);
			
			TA_SetAnchors();
			
			TA_OriginalSetPortraitTexture = SetPortraitTexture;
			SetPortraitTexture = TA_SetPortraitTexture;
			TA_OriginalTalentFrame_Update = TalentFrame_Update;
			TalentFrame_Update = TA_TalentFrame_Update;
			
			local button;
			for i=1, MAX_NUM_TALENTS do
				button = getglobal("PlayerTalentFrameTalent"..i);
				if ( button ) then
					button.talentButton_OnClick = TA_PlayerTalentFrameTalent_OnClick;
				end
			end
		else
			TA:ResetSpecc();
		end
	end
end

hooksecurefunc("ShowUIPanel",TA_CreateSpeccDropDown);

FW:SetMainCategory(FW.L.TS,FW.ICON_DEFAULT,12,"DEFAULT");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.TS_USE);
		FW:RegisterOption(FW.INF,2,FW.NON,FW.L.TS_HINT);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.TALENT_OFFSETX, FW.L.TALENT_OFFSET_TT,	"TalentOffsetX",	TA_SetAnchors);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.TALENT_OFFSETY, FW.L.TALENT_OFFSET_TT,	"TalentOffsetY",	TA_SetAnchors);

FW.Default.TalentOffsetX = 0;
FW.Default.TalentOffsetY = 0;