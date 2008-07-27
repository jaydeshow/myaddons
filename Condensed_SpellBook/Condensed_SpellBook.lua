MAX_SPELLS = 1024;
MAX_SKILLLINE_TABS = 8;
SPELLS_PER_PAGE = 12;
MAX_SPELL_PAGES = ceil(MAX_SPELLS / SPELLS_PER_PAGE);
BOOKTYPE_SPELL = "spell";
BOOKTYPE_PET = "pet";
SPELL_ID_LIST = {}; 
SPELL_NUM = 0; -- How many items in SPELL_ID_LIST

------
-- SpellBook Frame
------

function SBL_ToggleSpellBook(bookType)
	-- This is called when the SpellBook or the Pet SpellBook are opened
	-- If calling one book with the other open will toggle over to the the called book

	-- Set Tabs on first run.
	-- Solves a loading problem
	if (SBL_SpellBookFrame.construct) then
		SBL_SpellBookFrame.construct = nil;
		SBL_SpellBookFrame_UpdateStructure(SBL_SpellBookFrame);
	end
	
	-- If has no pet spells and is trying to open the corresponding book, then do nothing
	local hasPet = HasPetSpells();
	if ( not hasPet and bookType == BOOKTYPE_PET ) then
		return;
	end
	
	local isShown = SBL_SpellBookFrame:IsShown();
	HideUIPanel(SBL_SpellBookFrame);
	local isChanged = (SBL_SpellBookFrame.bookType ~= bookType);
	if ( (not isShown or isChanged) ) then
		SBL_SpellBookFrame.bookType = bookType;
		SBL_SpellBookTitleText:SetText(SPELLBOOK);
		if ( hasPet ) then
			if( isChanged ) then
				SBL_SpellBook_UpdateLists();
			end
			local skillTab = getglobal("SBL_SpellBookSkillLineTab"..SBL_SpellBookFrame.selectedSkillLine);
			if (bookType == BOOKTYPE_PET) then
				SBL_SpellBookFrameTabButton1:Enable();
				SBL_SpellBookFrameTabButton2:Disable();
				skillTab:SetChecked(nil);
				skillTab:Enable();
			else
				SBL_SpellBookFrameTabButton1:Disable();
				SBL_SpellBookFrameTabButton2:Enable();
				skillTab:SetChecked(1);
				skillTab:Disable();
			end
		end
		ShowUIPanel(SBL_SpellBookFrame);
	end
end

-- Hook new ToggleSpellBook option
ToggleSpellBook = SBL_ToggleSpellBook;

function SBL_SpellBookFrame_OnLoad(self)
	-- Register Events
	self:RegisterEvent("LEARNED_SPELL_IN_TAB");
	self:RegisterEvent("PLAYER_LOGIN");
	-- Set main variables for operation
	self.bookType = BOOKTYPE_SPELL;
	self.selectedSkillLine = 1;
	
	-- Init page nums
	SPELLBOOK_PAGENUMBERS[1] = 1;
	SPELLBOOK_PAGENUMBERS[2] = 1;
	SPELLBOOK_PAGENUMBERS[3] = 1;
	SPELLBOOK_PAGENUMBERS[4] = 1;
	SPELLBOOK_PAGENUMBERS[5] = 1;
	SPELLBOOK_PAGENUMBERS[6] = 1;
	SPELLBOOK_PAGENUMBERS[7] = 1;
	SPELLBOOK_PAGENUMBERS[8] = 1;
	SPELLBOOK_PAGENUMBERS[BOOKTYPE_PET] = 1;

	-- A little less optimal, but solves a loading issue
	SBL_SpellBookFrame.construct = 1;
	-- Set to the first tab by default
	SBL_SpellBookSkillLineTab_OnClick(SBL_SpellBookSkillLineTab1);
	-- Initialize tab flashing
	self.flashTabs = nil;
end

function SBL_SpellBookFrame_OnEvent(self,event)
	if ( event == "LEARNED_SPELL_IN_TAB" ) then
		SBL_SpellBookFrame_UpdateStructure(self);
		local flashFrame = getglobal("SBL_SpellBookSkillLineTab"..arg1.."Flash");
		if ( SBL_SpellBookFrame.bookType == BOOKTYPE_PET ) then
			return;
		else
			if ( flashFrame ) then
				flashFrame:Show();
				SBL_SpellBookFrame.flashTabs = 1;
			end
		end
	elseif ( event == "PLAYER_LOGIN" ) then
		SpellBookFrame:UnregisterAllEvents();
	end
end

function SBL_SpellBookFrame_OnShow(self)
	SBL_SpellBookFrame_UpdatePages();
	PlaySound("igSpellBookOpen");
	
	if ( SBL_SpellBookFrame.flashTabs ) then
		UIFrameFlash(SBL_SpellBookTabFlashFrame, 0.5, 0.5, 30, nil);
	end

	-- Show multibar slots
	MultiActionBar_ShowAllGrids();
	SBL_UpdateMicroButtons();
end

function SBL_SpellBookFrame_UpdateStructure(self)
	local numSkillLines = GetNumSpellTabs();
	local name, texture;
	local skillLineTab;
	for i=1, MAX_SKILLLINE_TABS do
		skillLineTab = getglobal("SBL_SpellBookSkillLineTab"..i);
		if ( i <= numSkillLines ) then
			name, texture = GetSpellTabInfo(i);
			skillLineTab:SetNormalTexture(texture);
			skillLineTab.tooltip = name;
			skillLineTab:Show();
		else
			skillLineTab:Hide();
		end
	end	

	local hasPets, petToken = HasPetSpells();
	SBL_SpellBookFrame.petTitle = nil;
	if ( hasPets ) then
		-- SpellBook Tab
		SBL_SpellBookFrameTabButton1.bookType = BOOKTYPE_SPELL;
		SBL_SpellBookFrameTabButton1:SetText(SPELLBOOK);
		SBL_SpellBookFrameTabButton1.binding = "TOGGLESPELLBOOK";
		SBL_SpellBookFrameTabButton1:Show();
		-- Pet Book Tab
		SBL_SpellBookFrameTabButton2.bookType = BOOKTYPE_PET;
		SBL_SpellBookFrameTabButton2:SetText(getglobal("PET_TYPE_"..petToken));
		SBL_SpellBookFrameTabButton2.binding = "TOGGLEPETBOOK";
		SBL_SpellBookFrameTabButton2:Show();
		SBL_SpellBookFrame.petTitle = getglobal("PET_TYPE_"..petToken);
		-- Place Holder 3rd Tab
		SBL_SpellBookFrameTabButton3:Hide();
	end
	SBL_SpellBook_UpdateLists();
end

function SBL_SpellBookFrame_OnHide(self)
	if ( self.bookType == BOOKTYPE_SPELL ) then
		-- Spell Book Sound
		PlaySound("igSpellBookClose");
	else
		-- Pet Book Sound
		PlaySound("igAbilityClose");
	end
	SBL_UpdateMicroButtons();

	UIFrameFlashRemoveFrame(SBL_SpellBookTabFlashFrame);
	for i=1, MAX_SKILLLINE_TABS do
		getglobal("SBL_SpellBookSkillLineTab"..i.."Flash"):Hide();
	end

	-- Hide multibar slots
	MultiActionBar_HideAllGrids();
end

------
-- Page Turning
------

function SBL_SpellBookFrame_UpdatePages()
	local currentPage, maxPages = SBL_SpellBook_GetCurrentPage();
	if ( maxPages == 0 ) then
		return;
	end
	if ( currentPage > maxPages ) then
		SPELLBOOK_PAGENUMBERS[SBL_SpellBookFrame.selectedSkillLine] = maxPages;
		currentPage = maxPages;
	end
	if ( currentPage == 1 ) then
		SBL_SpellBookPrevPageButton:Disable();
	else
		SBL_SpellBookPrevPageButton:Enable();
	end
	if ( currentPage == maxPages ) then
		SBL_SpellBookNextPageButton:Disable();
	else
		SBL_SpellBookNextPageButton:Enable();
	end
	SBL_SpellBookPageText:SetFormattedText(PAGE_NUMBER, currentPage);
	UpdateSpells();
end

function SBL_TurnPageButton_OnClick(offset)
	local currentPage, maxPages = SBL_SpellBook_GetCurrentPage();
	currentPage = currentPage + offset;
	PlaySound("igAbiliityPageTurn");
	if ( SBL_SpellBookFrame.bookType == BOOKTYPE_SPELL ) then
		SPELLBOOK_PAGENUMBERS[SBL_SpellBookFrame.selectedSkillLine] = currentPage;
	else
		SPELLBOOK_PAGENUMBERS[BOOKTYPE_PET] = currentPage;
	end
	SBL_SpellBookFrame_UpdatePages();
end

function SBL_SpellBook_GetCurrentPage()
	local currentPage, maxPages;
	if (SBL_SpellBookFrame.bookType == BOOKTYPE_PET ) then
		currentPage = SPELLBOOK_PAGENUMBERS[BOOKTYPE_PET];
		maxPages = ceil(SPELL_NUM/SPELLS_PER_PAGE);
	else
		currentPage = SPELLBOOK_PAGENUMBERS[SBL_SpellBookFrame.selectedSkillLine];
		maxPages = ceil(SPELL_NUM/SPELLS_PER_PAGE);
	end
	return currentPage, maxPages;
end

--------
-- Tab changing
--------

function SBL_SpellBookSkillLineTab_OnClick(self)
	local oldtab = getglobal("SBL_SpellBookSkillLineTab"..SBL_SpellBookFrame.selectedSkillLine);
	oldtab:Enable(); -- Enable old tab
	self:Disable(); -- Disable current tab to prevent unnecessary actions
	
	oldtab:SetChecked(nil);
	self:SetChecked(1);
	local id = self:GetID();
	SBL_SpellBookFrame.selectedSkillLine = id;
	SBL_SpellBookFrame.bookType = BOOKTYPE_SPELL;
	SBL_SpellBookFrameTabButton1:Disable();
	SBL_SpellBookFrameTabButton2:Enable();
	SBL_SpellBook_UpdateLists();
	SBL_SpellBookFrame_UpdatePages();
	
	-- Stop tab flashing
	local tabFlash = getglobal(self:GetName().."Flash");
	if ( tabFlash ) then
		tabFlash:Hide();
	end
	if (SBL_SpellBookFrame:IsShown()) then
		PlaySound("igSpellBookClose");
	end
end

--------
-- Spell Buttons
--------

function SBL_SpellButton_OnLoad(self) 
	self:RegisterForDrag("LeftButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	self:SetAttribute("type*","spell");
	self:SetAttribute("CHATLINK-spell",ATTRIBUTE_NOOP);
	self:SetAttribute("PICKUPACTION-spell",ATTRIBUTE_NOOP);
end

function SBL_SpellButton_OnEvent(self,event)
	if ( event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_COOLDOWN" ) then 
		SBL_SpellButton_UpdateButton(self);
	elseif ( event == "CURRENT_SPELL_CAST_CHANGED" ) then
		SBL_SpellButton_UpdateSelection(self);
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		SBL_SpellButton_UpdateSelection(self);
	elseif ( event == "PET_BAR_UPDATE" ) then
		if ( SBL_SpellBookFrame.bookType == BOOKTYPE_PET ) then
			SBL_SpellButton_UpdateButton(self);
		end
	end
end

function SBL_SpellButton_OnShow(self)
	self:RegisterEvent("SPELLS_CHANGED");
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
	self:RegisterEvent("CRAFT_SHOW");
	self:RegisterEvent("CRAFT_CLOSE");
	self:RegisterEvent("TRADE_SKILL_SHOW");
	self:RegisterEvent("TRADE_SKILL_CLOSE");
	self:RegisterEvent("PET_BAR_UPDATE");

	SBL_SpellButton_UpdateButton(self);
end

function SBL_SpellButton_OnHide(self)
	self:UnregisterEvent("SPELLS_CHANGED");
	self:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
	self:UnregisterEvent("CURRENT_SPELL_CAST_CHANGED");
	self:UnregisterEvent("CRAFT_SHOW");
	self:UnregisterEvent("CRAFT_CLOSE");
	self:UnregisterEvent("TRADE_SKILL_SHOW");
	self:UnregisterEvent("TRADE_SKILL_CLOSE");
	self:UnregisterEvent("PET_BAR_UPDATE");
end
 
function SBL_SpellButton_OnEnter(self)
	local name, texture, offset, numSpells = GetSpellTabInfo(SBL_SpellBookFrame.selectedSkillLine);
	local id = self:GetID();
	local spellId, lowerId = SBL_SpellBook_GetSpellID(self);
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( GameTooltip:SetSpell(spellId, SBL_SpellBookFrame.bookType) ) then
		self.UpdateTooltip = SBL_SpellButton_OnEnter;
	else
		self.UpdateTooltip = nil;
	end
	if ((spellId - lowerId) > 0 ) then
		SBL_SpellListFrame_SpellButtonEntered(self, lowerId, spellId);
	end
end


function SBL_SpellButton_OnLeave(self)
	GameTooltip:Hide();
end

function SBL_SpellButton_PostClick(self,button) 
	-- On Modified Click but set to work after click
	local id = SBL_SpellBook_GetSpellID(self);
	if ( id > MAX_SPELLS ) then
		return;
	end
	if ( IsModifiedClick("CHATLINK") ) then
		if ( MacroFrame and MacroFrame:IsShown() ) then
			local spellName, subSpellName = GetSpellName(id, SBL_SpellBookFrame.bookType);
			if ( spellName and not IsPassiveSpell(id, SBL_SpellBookFrame.bookType) ) then
				if ( subSpellName and (strlen(subSpellName) > 0) ) then
					ChatEdit_InsertLink(spellName.."("..subSpellName..")");
				else
					ChatEdit_InsertLink(spellName);
				end
			end
			return;
		else
			local spellLink = GetSpellLink(id, SBL_SpellBookFrame.bookType);
			if(spellLink) then
				ChatEdit_InsertLink(spellLink);
			end
			return;
		end
	end
	if ( IsModifiedClick("PICKUPACTION") ) then
		PickupSpell(id, SBL_SpellBookFrame.bookType);
		return;
	end
end

function SBL_SpellButton_OnDrag(self) 
	local id = SBL_SpellBook_GetSpellID(self);
	if ( id > MAX_SPELLS or not getglobal(self:GetName().."IconTexture"):IsShown() ) then
		return;
	end
	self:SetChecked(0);
	PickupSpell(id, SBL_SpellBookFrame.bookType);
end

function SBL_SpellButton_UpdateSelection(self)
	local temp, texture, offset, numSpells = GetSpellTabInfo(SBL_SpellBookFrame.selectedSkillLine);
	local id = SBL_SpellBook_GetSpellID(self);
	if ( (SBL_SpellBookFrame.bookType ~= BOOKTYPE_PET) and (id > (offset + numSpells)) ) then
		self:SetChecked("false");
		return;
	end

	if ( IsSelectedSpell(id, SBL_SpellBookFrame.bookType) ) then
		self:SetChecked("true");
	else
		self:SetChecked("false");
	end
end

function SBL_SpellButton_UpdateButton(self)
	if ( not SBL_SpellBookFrame.selectedSkillLine ) then
		SBL_SpellBookFrame.selectedSkillLine = 1;
	end
	local temp, texture, offset, numSpells = GetSpellTabInfo(SBL_SpellBookFrame.selectedSkillLine);
	SBL_SpellBookFrame.selectedSkillLineOffset = offset;
	local id = SBL_SpellBook_GetSpellID(self);
	local name = self:GetName();
	local iconTexture = getglobal(name.."IconTexture");
	local spellString = getglobal(name.."SpellName");
	local subSpellString = getglobal(name.."SubSpellName");
	local cooldown = getglobal(name.."Cooldown");
	local autoCastableTexture = getglobal(name.."AutoCastable");
	local autoCastModel = getglobal(name.."AutoCast");
	if ( id > (offset + numSpells) ) then
		self:Disable();
		iconTexture:Hide();
		spellString:Hide();
		subSpellString:Hide();
		cooldown:Hide();
		autoCastableTexture:Hide();
		autoCastModel:Hide();
		self:SetChecked(0);
		getglobal(name.."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
		return;
	else
		self:Enable();
	end
	local texture = GetSpellTexture(id, SBL_SpellBookFrame.bookType);
	local highlightTexture = getglobal(name.."Highlight");
	local normalTexture = getglobal(name.."NormalTexture");
	-- If no spell, hide everything and return
	if ( not texture or (strlen(texture) == 0) ) then
		iconTexture:Hide();
		spellString:Hide();
		subSpellString:Hide();
		cooldown:Hide();
		autoCastableTexture:Hide();
		autoCastModel:Hide();
		highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square");
		self:SetChecked(0);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		return;
	end
	
	local spellName, subSpellName = GetSpellName(id, SBL_SpellBookFrame.bookType);
	local fullName = spellName.."("..subSpellName..")";
	self:SetAttribute("spell", fullName);

	local start, duration, enable = GetSpellCooldown(id, SBL_SpellBookFrame.bookType);
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
	if ( enable == 1 ) then
		iconTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		iconTexture:SetVertexColor(0.4, 0.4, 0.4);
	end

	local autoCastAllowed, autoCastEnabled = GetSpellAutocast(id, SBL_SpellBookFrame.bookType);
	if ( autoCastAllowed ) then
		self:SetAttribute("type2","macro");
		self:SetAttribute("macrotext","/petautocasttoggle "..fullName);
		autoCastableTexture:Show();
	else
		self:SetAttribute("type2","spell");
		autoCastableTexture:Hide();
	end
	if ( autoCastEnabled ) then
		autoCastModel:Show();
	else
		autoCastModel:Hide();
	end


	local isPassive = IsPassiveSpell(id, SBL_SpellBookFrame.bookType);
	if ( isPassive ) then
		normalTexture:SetVertexColor(0, 0, 0);
		highlightTexture:SetTexture("Interface\\Buttons\\UI-PassiveHighlight");
		--subSpellName = PASSIVE_PARENS;
		spellString:SetTextColor(PASSIVE_SPELL_FONT_COLOR.r, PASSIVE_SPELL_FONT_COLOR.g, PASSIVE_SPELL_FONT_COLOR.b);
	else
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square");
		spellString:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	
	iconTexture:SetTexture(texture);
	spellString:SetText(spellName);
	subSpellString:SetText(subSpellName);
	if ( subSpellName ~= "" ) then
		spellString:SetPoint("LEFT", self, "RIGHT", 4, 4);
	else
		spellString:SetPoint("LEFT", self, "RIGHT", 4, 2);
	end
	
	iconTexture:Show();
	spellString:Show();
	subSpellString:Show();
	SBL_SpellButton_UpdateSelection(self);
end

------
-- Spell Indexing
------

function SBL_SpellBook_GetSpellID(self)
	--If ID is out of range, return max number
	local id = self:GetID();
	local trueID = 0;
	if ( SBL_SpellBookFrame.bookType == BOOKTYPE_PET ) then
		trueID = id + (SPELLS_PER_PAGE * (SPELLBOOK_PAGENUMBERS[BOOKTYPE_PET] - 1));
	else
		trueID = id + (SPELLS_PER_PAGE * (SPELLBOOK_PAGENUMBERS[SBL_SpellBookFrame.selectedSkillLine] - 1));
	end
	if (trueID > SPELL_NUM) then
		return MAX_SPELLS;
	else 
		return SPELL_ID_LIST[trueID], (SPELL_ID_LIST[trueID-1]+1);
	end
end

function SBL_SpellBook_UpdateLists()
	--Instead of listing every spell available to the character individually,
	--list only the highest rank of each spell, and have available through
	--special means to access the lower ranks.
	
	--The spells are updated very often, thus refreshing the full spell list in wasteful
	--programming.  Therefore, only the shown spell list should be condensed.

	local temp1,temp2, offset, numSpells;
	if (SBL_SpellBookFrame.bookType == BOOKTYPE_PET) then
		--The Pet book does not have tabs, just one book
		offset = 0;
		numSpells = HasPetSpells();
	else
		--The Spellbook has a selected tab.
		temp1, temp2, offset, numSpells = GetSpellTabInfo(SBL_SpellBookFrame.selectedSkillLine);
	end
	
	--empty existing list
	SPELL_ID_LIST = {};
	SPELL_ID_LIST[0] = offset;
	local cSpellName, nSpellName, unique;

	unique = 1;
	nSpellName = GetSpellName((offset+1), SBL_SpellBookFrame.bookType);
	local max = offset + numSpells;
	for i= (offset+1), max do
		--Get current Spell
		cSpellName = nSpellName;
		nSpellName = GetSpellName((i+1), SBL_SpellBookFrame.bookType);

		-- If current Spell is not same as previous spell, a new unique spell was found
		if (cSpellName ~= nSpellName) then
			--Current Spell is different
			--Set real spell id of highest rank and number of ranks
			SPELL_ID_LIST[unique] = i;
			unique = unique + 1;
		end
	end
	SPELL_NUM = unique-1;
end

-------
-- Extra Functions
-------

function SBL_UpdateMicroButtons()
	if ( SBL_SpellBookFrame:IsShown() ) then
		SpellbookMicroButton:SetButtonState("PUSHED", 1);
	else
		SpellbookMicroButton:SetButtonState("NORMAL");
	end
end