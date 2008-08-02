BAD_SPELL_ID = 1025; -- This is when functions fail
SPELL_ID_LIST = {}; 
SPELL_NUM = 0; -- How many items in SPELL_ID_LIST
SPELL_ID_MAX = 0; -- Highest Spell ID in list
FRAME_TAB_LIST = {}; -- For 3.00 Compatibility
StandardToggle = {}; -- Holds old ToggleSpellBook function

------
-- SpellBook Frame
------

function CSB_ToggleSpellBook(bookType)
	local hasPet = HasPetSpells();
	if ( (not hasPet) and bookType == BOOKTYPE_PET ) then
		return;
	end
	
	local isShown = CSB_SpellBookFrame:IsShown();
	local isChanged = (SpellBookFrame.bookType ~= bookType);
	HideUIPanel(CSB_SpellBookFrame);

	if ( (not isShown or isChanged) ) then
		SpellBookFrame.bookType = bookType;
		if (hasPet) then
			CSB_SetFrameTabs(FRAME_TAB_LIST[bookType]);
			if (isChanged) then
				CSB_UpdateSpellList();
			end
		end
		ShowUIPanel(CSB_SpellBookFrame);
	end
end

function CSB_BookSwap(self)
	local skillTab = getglobal("CSB_SpellBookSkillLineTab"..SpellBookFrame.selectedSkillLine);
	if (self:GetID() == 1) then
		skillTab:Enable();
		skillTab:SetChecked(nil);
		HideUIPanel(CSB_SpellBookFrame);
		ToggleSpellBook = StandardToggle;
	else
		CSB_SpellBookSkillLineTab_OnClick(skillTab);
		HideUIPanel(SpellBookFrame);
		ToggleSpellBook = CSB_ToggleSpellBook;
	end
	ToggleSpellBook(BOOKTYPE_SPELL);
end

function Update_FrameTab4()
	CSB_SpellBookFrameTabButton4:Show();
	if (HasPetSpells()) then
		SpellBookFrameTabButton4:SetPoint("CENTER",SpellBookFrame,"BOTTOMLEFT",79,36);
	else
		SpellBookFrameTabButton4:SetPoint("CENTER",SpellBookFrame,"BOTTOMLEFT",79,61);
	end
end

function CSB_SpellBookFrame_OnLoad(self)
	-- Register Events
	self:RegisterEvent("SKILL_LINES_CHANGED");
	self:RegisterEvent("UNIT_PET");
	self:RegisterEvent("LEARNED_SPELL_IN_TAB");

	SpellBookFrame.bookType = BOOKTYPE_SPELL;
	SpellBookFrame.selectedSkillLine = 1;
	
	FRAME_TAB_LIST[BOOKTYPE_SPELL] = 1;
	FRAME_TAB_LIST[BOOKTYPE_PET] = 2;
	
	-- Set Swap Buttons and Tabs that will never change
	CSB_SpellBookFrameTabButton4:SetScript("OnClick", CSB_BookSwap);
	CSB_SpellBookFrameTabButton4.bookType = BOOKTYPE_SPELL;
	CSB_SpellBookFrameTabButton4:SetText("Regular SpellBook");
	CSB_SpellBookFrameTabButton4.binding = "";
	CSB_SpellBookFrameTabButton4:Show();
	CSB_SpellBookFrameTabButton4:SetID(1);

	otherTab = CreateFrame("Button","SpellBookFrameTabButton4",SpellBookFrame,"SpellBookFrameTabButtonTemplate");
	otherTab:SetScript("OnClick", CSB_BookSwap);
	otherTab.bookType = BOOKTYPE_SPELL;
	otherTab:SetText("Condensed Book");
	otherTab.binding = "";
	otherTab:Show();
	otherTab:SetID(2);
	
	CSB_SpellBookFrameTabButton1.bookType = BOOKTYPE_SPELL;
	CSB_SpellBookFrameTabButton1:SetText(SPELLBOOK);
	CSB_SpellBookFrameTabButton1.binding = "TOGGLESPELLBOOK";

	-- Set Hooks
	StandardToggle = ToggleSpellBook;
	ToggleSpellBook = CSB_ToggleSpellBook;
	hooksecurefunc("SpellBookFrame_Update",Update_FrameTab4);
	self.flashTabs = nil; -- No objects need flashing
end

function CSB_SpellBookFrame_OnEvent(self,event,...)
	if ( event == "SKILL_LINES_CHANGED" ) then
		-- Skills Changed, check tabs
		CSB_UpdateSkillTabs(); -- Set SkillTabs
		CSB_SpellBookSkillLineTab_OnClick(CSB_SpellBookSkillLineTab1); -- Initialize to first tab	
	elseif ( event == "UNIT_PET" ) then
		-- Pet Summoned, Dismissed, or changed
		CSB_UpdateFrameTabs(); -- Adjust Frame Tabs
	elseif ( event == "LEARNED_SPELL_IN_TAB" ) then
		-- Update Tabs and set the tab that will flash
		CSB_UpdateTabs();
		local flashFrame = getglobal("SpellBookSkillLineTab"..arg1.."Flash");
		if ( SpellBookFrame.bookType == BOOKTYPE_PET ) then
			return;
		else
			if ( flashFrame ) then
				flashFrame:Show();
				SpellBookFrame.flashTabs = 1;
			end
		end
	end
end

function CSB_SpellBookFrame_OnShow(self)
	-- Update the Page and play open sound
	CSB_SpellBookFrame_UpdatePage();
	PlaySound("igSpellBookOpen");
	
	if ( self.flashTabs ) then
		UIFrameFlash(CSB_SpellBookTabFlashFrame, 0.5, 0.5, 30, nil);
	end

	-- Show multibar slots
	MultiActionBar_ShowAllGrids();
	CSB_UpdateMicroButtons();
end

function CSB_SpellBookFrame_OnHide(self)
	-- Play Close sound and remove flashing items
	if ( SpellBookFrame.bookType == BOOKTYPE_SPELL ) then
		-- Spell Book Sound
		PlaySound("igSpellBookClose");
	else
		-- Pet Book Sound
		PlaySound("igAbilityClose");
	end
	CSB_UpdateMicroButtons();

	UIFrameFlashRemoveFrame(CSB_SpellBookTabFlashFrame);
	for i=1, MAX_SKILLLINE_TABS do
		getglobal("CSB_SpellBookSkillLineTab"..i.."Flash"):Hide();
	end

	-- Hide multibar slots
	MultiActionBar_HideAllGrids();
end

------
-- Page Turning
------

function CSB_SpellBookFrame_UpdatePage()
	-- Set to proper page, enable the allowed paging buttons
	-- and tell the spell buttons to update to current page
	local currentPage, maxPages = CSB_SpellBook_GetCurrentPage();
	if ( maxPages == 0 ) then
		return;
	end
	if ( currentPage > maxPages ) then
		SPELLBOOK_PAGENUMBERS[SpellBookFrame.selectedSkillLine] = maxPages;
		currentPage = maxPages;
	end
	if ( currentPage == 1 ) then
		CSB_SpellBookPrevPageButton:Disable();
	else
		CSB_SpellBookPrevPageButton:Enable();
	end
	if ( currentPage == maxPages ) then
		CSB_SpellBookNextPageButton:Disable();
	else
		CSB_SpellBookNextPageButton:Enable();
	end
	CSB_SpellBookPageText:SetFormattedText(PAGE_NUMBER, currentPage);
	UpdateSpells();
end

function CSB_TurnPageButton_OnClick(self,offset)
	-- turn page based on the direction of the button
	local currentPage, maxPages = CSB_SpellBook_GetCurrentPage();
	currentPage = currentPage + offset;
	PlaySound("igAbiliityPageTurn");
	if ( SpellBookFrame.bookType == BOOKTYPE_SPELL ) then
		SPELLBOOK_PAGENUMBERS[SpellBookFrame.selectedSkillLine] = currentPage;
	else
		SPELLBOOK_PAGENUMBERS[BOOKTYPE_PET] = currentPage;
	end
	CSB_SpellBookFrame_UpdatePage();
end

function CSB_SpellBook_GetCurrentPage()
	-- report current page
	local currentPage, maxPages;
	if (SpellBookFrame.bookType == BOOKTYPE_PET ) then
		currentPage = SPELLBOOK_PAGENUMBERS[BOOKTYPE_PET];
		maxPages = ceil(SPELL_NUM/SPELLS_PER_PAGE);
	else
		currentPage = SPELLBOOK_PAGENUMBERS[SpellBookFrame.selectedSkillLine];
		maxPages = ceil(SPELL_NUM/SPELLS_PER_PAGE);
	end
	return currentPage, maxPages;
end

--------
-- Tab changing
--------

function CSB_SpellBookSkillLineTab_OnClick(self)
	-- when skill tab is clicked, Update Spell List
	-- and set checks
	local oldtab = getglobal("CSB_SpellBookSkillLineTab"..SpellBookFrame.selectedSkillLine);
	local id = self:GetID();
	if (oldtab:GetID() == id) then
		-- same tab, do nothing
		return;
	end	
	
	oldtab:SetChecked(nil);
	self:SetChecked(1);
	SpellBookFrame.selectedSkillLine = id;
	CSB_UpdateSpellList();
	CSB_SpellBookFrame_UpdatePage();
	
	-- Stop tab flashing
	local tabFlash = getglobal(self:GetName().."Flash");
	if ( tabFlash ) then
		tabFlash:Hide();
	end
	if (CSB_SpellBookFrame:IsShown()) then
		PlaySound("igSpellBookClose");
	end
end

function CSB_SetFrameTabs(tabNum)
	-- Enable proper frame tabs and hide skill tabs if not the spellbook
	local tabButton;
	for i = 1, 2 do
		tabButton = getglobal("CSB_SpellBookFrameTabButton"..i);
		if ( i ~= tabNum) then
			tabButton:Enable();
		else
			tabButton:Disable();
		end
	end
	if (SpellBookFrame.bookType ~= BOOKTYPE_SPELL) then
		CSB_HideSkillTabs();
	else
		CSB_UpdateSkillTabs();
	end			
end

function CSB_HideSkillTabs()
	-- Hides the Skill Tabs
	for i = 1, MAX_SKILLLINE_TABS do
		getglobal("CSB_SpellBookSkillLineTab"..i):Hide();
	end
end

function CSB_UpdateSkillTabs()
	-- Shows and assigns Skill Tabs
	local numSkillLines = GetNumSpellTabs();
	local name, texture;
	local skillLineTab;
	for i=1, MAX_SKILLLINE_TABS do
		skillLineTab = getglobal("CSB_SpellBookSkillLineTab"..i);
		if ( i <= numSkillLines ) then
			name, texture = GetSpellTabInfo(i);
			skillLineTab:SetNormalTexture(texture);
			skillLineTab.tooltip = name;
			skillLineTab:Show();
		else
			skillLineTab:Hide();
		end
	end
end

function CSB_UpdateFrameTabs()
	-- Assigns Frame Tabs
	local hasPets, petToken = HasPetSpells();
	if ( hasPets ) then
		-- SpellBook Tab
		CSB_SpellBookFrameTabButton1:Show();
		-- Pet Book Tab
		CSB_SpellBookFrameTabButton2.bookType = BOOKTYPE_PET;
		CSB_SpellBookFrameTabButton2:SetText(getglobal("PET_TYPE_"..petToken));
		CSB_SpellBookFrameTabButton2.binding = "TOGGLEPETBOOK";
		CSB_SpellBookFrameTabButton2:Show();
		-- Locate Tab 4
		CSB_SpellBookFrameTabButton4:SetPoint("CENTER",CSB_SpellBookFrame,"BOTTOMLEFT",79,36);
	else
		CSB_SpellBookFrameTabButton1:Hide();
		CSB_SpellBookFrameTabButton2:Hide();
		CSB_SpellBookFrameTabButton3:Hide();		
		CSB_SpellBookFrameTabButton4:SetPoint("CENTER",CSB_SpellBookFrame,"BOTTOMLEFT",79,61);
	end
	CSB_SetFrameTabs(FRAME_TAB_LIST[SpellBookFrame.bookType]);
end

--------
-- Spell Buttons
--------

function CSB_SpellButton_OnLoad(self)
	-- Set Button registers and non-changing secure frame attributes
	self:RegisterForDrag("LeftButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	self:SetAttribute("type*","spell");
	self:SetAttribute("CHATLINK-spell",ATTRIBUTE_NOOP);
	self:SetAttribute("PICKUPACTION-spell",ATTRIBUTE_NOOP);
end

function CSB_SpellButton_OnEvent(self,event)
	if ( event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_COOLDOWN" ) then 
		CSB_SpellButton_UpdateButton(self);
	elseif ( event == "CURRENT_SPELL_CAST_CHANGED" ) then
		CSB_SpellButton_UpdateSelection(self);
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		CSB_SpellButton_UpdateSelection(self);
	elseif ( event == "PET_BAR_UPDATE" ) then
		if ( SpellBookFrame.bookType == BOOKTYPE_PET ) then
			CSB_SpellButton_UpdateButton(self);
		end
	end
end

function CSB_SpellButton_OnShow(self)
	-- When available, adjust to events
	self:RegisterEvent("SPELLS_CHANGED");
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
	self:RegisterEvent("CRAFT_SHOW");
	self:RegisterEvent("CRAFT_CLOSE");
	self:RegisterEvent("TRADE_SKILL_SHOW");
	self:RegisterEvent("TRADE_SKILL_CLOSE");
	self:RegisterEvent("PET_BAR_UPDATE");

	CSB_SpellButton_UpdateButton(self);
end

function CSB_SpellButton_OnHide(self)
	-- When unavailable, unregister events
	self:UnregisterEvent("SPELLS_CHANGED");
	self:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
	self:UnregisterEvent("CURRENT_SPELL_CAST_CHANGED");
	self:UnregisterEvent("CRAFT_SHOW");
	self:UnregisterEvent("CRAFT_CLOSE");
	self:UnregisterEvent("TRADE_SKILL_SHOW");
	self:UnregisterEvent("TRADE_SKILL_CLOSE");
	self:UnregisterEvent("PET_BAR_UPDATE");
end
 
function CSB_SpellButton_OnEnter(self)
	-- When entered, set the tooltip and show the lower ranks if exist
	local name, texture, offset, numSpells = GetSpellTabInfo(SpellBookFrame.selectedSkillLine);
	local spellId, lowerId = CSB_GetSpellID(self);
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( GameTooltip:SetSpell(spellId, SpellBookFrame.bookType) ) then
		self.UpdateTooltip = CSB_SpellButton_OnEnter;
	else
		self.UpdateTooltip = nil;
	end
	if ((spellId - lowerId) > 0 ) then
		CSB_SpellLister_SpellButtonEntered(self, lowerId, spellId);
	end
end


function CSB_SpellButton_OnLeave(self)
	-- Hide just the tooltip
	GameTooltip:Hide();
end

function CSB_SpellButton_PostClick(self,button) 
	-- On Modified Click but set to work after click
	local id = CSB_GetSpellID(self);
	if (id == BAD_SPELL_ID) then 
		return; 
	end
	if ( IsModifiedClick("CHATLINK") ) then
		if ( MacroFrame and MacroFrame:IsShown() ) then
			local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
			if ( not IsPassiveSpell(id, SpellBookFrame.bookType) ) then
				ChatEdit_InsertLink(spellName);
			end
			return;
		else
			local spellLink = GetSpellLink(id, SpellBookFrame.bookType);
			if(spellLink) then
				ChatEdit_InsertLink(spellLink);
			end
			return;
		end
	end
	if ( IsModifiedClick("PICKUPACTION") ) then
		PickupSpell(id, SpellBookFrame.bookType);
		return;
	end
end

function CSB_SpellButton_OnDrag(self)
	-- When dragged, pick up the spell button 
	local id = CSB_GetSpellID(self);
	if ( not getglobal(self:GetName().."IconTexture"):IsShown() ) then
		return;
	end
	self:SetChecked(0);
	PickupSpell(id, SpellBookFrame.bookType);
end

function CSB_SpellButton_UpdateSelection(self)
	-- Update checked status
	local temp, texture, offset, numSpells = GetSpellTabInfo(SpellBookFrame.selectedSkillLine);
	local id = CSB_GetSpellID(self);
	
	self:SetChecked("false");
	if ( (id ~= BAD_SPELL_ID) and IsSelectedSpell(id, SpellBookFrame.bookType) ) then
		self:SetChecked("true");
	end
end

function CSB_SpellButton_UpdateButton(self)
	-- Update the Button to current
	local id = CSB_GetSpellID(self);
	local name = self:GetName();
	local iconTexture = getglobal(name.."IconTexture");
	local spellString = getglobal(name.."SpellName");
	local subSpellString = getglobal(name.."SubSpellName");
	local cooldown = getglobal(name.."Cooldown");
	local autoCastableTexture = getglobal(name.."AutoCastable");
	local autoCastModel = getglobal(name.."AutoCast");
	if ( id > SPELL_ID_MAX  ) then
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
	
	local texture = GetSpellTexture(id, SpellBookFrame.bookType);
	local highlightTexture = getglobal(name.."Highlight");
	local normalTexture = getglobal(name.."NormalTexture");
	
	local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
	local fullName;
	if ((not subSpellName) or (strlen(subSpellName) == 0)) then
		fullName = spellName;
	else
		fullName = spellName.."("..subSpellName..")";
	end
	self:SetAttribute("spell", fullName);

	local start, duration, enable = GetSpellCooldown(id, SpellBookFrame.bookType);
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
	if ( enable == 1 ) then
		iconTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		iconTexture:SetVertexColor(0.4, 0.4, 0.4);
	end

	local autoCastAllowed, autoCastEnabled = GetSpellAutocast(id, SpellBookFrame.bookType);
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


	local isPassive = IsPassiveSpell(id, SpellBookFrame.bookType);
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
	CSB_SpellButton_UpdateSelection(self);
end

------
-- Spell Indexing
------

function CSB_GetSpellID(self)
	--Return the proper spell ID, or return a bad spell id
	local id = self:GetID();
	local trueID = 0;
	if ( SpellBookFrame.bookType == BOOKTYPE_PET ) then
		trueID = id + (SPELLS_PER_PAGE * (SPELLBOOK_PAGENUMBERS[BOOKTYPE_PET] - 1));
	else
		trueID = id + (SPELLS_PER_PAGE * (SPELLBOOK_PAGENUMBERS[SpellBookFrame.selectedSkillLine] - 1));
	end
	if (trueID > SPELL_NUM) then
		return BAD_SPELL_ID;
	else 
		return SPELL_ID_LIST[trueID], (SPELL_ID_LIST[trueID-1]+1);
	end
end

function CSB_UpdateSpellList()
	--Instead of listing every spell available to the character individually,
	--list only the highest rank of each spell, and have available through
	--special means to access the lower ranks.
	
	--The spells are updated very often, thus refreshing the full spell list in wasteful
	--programming.  Therefore, only the shown spell list should be condensed.

	local temp1,temp2, offset, numSpells;
	if (SpellBookFrame.bookType == BOOKTYPE_PET) then
		--The Pet book does not have tabs, just one book
		offset = 0;
		numSpells = HasPetSpells();
	else
		--The Spellbook has a selected tab.
		temp1, temp2, offset, numSpells = GetSpellTabInfo(SpellBookFrame.selectedSkillLine);
	end
	
	--empty existing list
	SPELL_ID_LIST = {};
	SPELL_ID_LIST[0] = offset;
	local cSpellName, nSpellName, unique;

	unique = 1;
	nSpellName = GetSpellName((offset+1), SpellBookFrame.bookType);
	SPELL_ID_MAX = offset + numSpells;
	for i= (offset+1), SPELL_ID_MAX do
		--Get current Spell
		cSpellName = nSpellName;
		nSpellName = GetSpellName((i+1), SpellBookFrame.bookType);

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

function CSB_UpdateMicroButtons()
	-- Toggle the SpellBook's Micro Button
	if ( CSB_SpellBookFrame:IsShown() ) then
		SpellbookMicroButton:SetButtonState("PUSHED", 1);
	else
		SpellbookMicroButton:SetButtonState("NORMAL");
	end
end