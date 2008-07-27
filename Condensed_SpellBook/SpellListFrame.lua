SBL_SIZE = 30; -- Pixel Size of Spell Icons
SBL_MAX_WIDTH = 4; -- 4 Icons across per row

function SBL_SpellListFrame_OnLoad(self)
	self:RegisterEvent("SPELLS_CHANGED");
	self.spellAnchor = self; -- Points to SpellButton from the book
	self.spellButtons = 0; -- Number of Spells created
	self.offset = 0; -- Lowest Rank Spell for spell id
end

function SBL_SpellListFrame_SpellButtonEntered(spellButton,lowestRank,highestRank)
	-- When a Spell Button is entered, populate frame and show
	if (SBL_SpellListFrame.offset == (lowestRank-1)) then
		-- Same button, no change.
		SBL_SpellListFrame:Show();
		return;
	end

	SBL_SpellListFrame.spellAnchor = spellButton;
	SBL_SpellListFrame:SetPoint("TOPLEFT",spellButton,"TOPRIGHT");
	SBL_SpellListFrame:SetHeight(SBL_SIZE);
	SBL_SpellListFrame:SetWidth(SBL_SIZE);
	SBL_SpellListFrame.offset = lowestRank-1;
	SBL_SpellListFrame.spellRanks = highestRank;
	local current,op;
	op = 0;
	--Set first Frame down
	--Create new frames as needed or reset old
	for i = lowestRank,highestRank do 
		op = op + 1;
		current = getglobal("SBL_SpellListButton"..op);
		if (current) then
		end
		if (current == nil) then -- if it don't exist
			current = CreateFrame("CheckButton","SBL_SpellListButton"..op,SBL_SpellListFrame,"SBL_SpellListButtonTemplate");
			local y = floor((op-1) / SBL_MAX_WIDTH);
			local x = ((op-1) % SBL_MAX_WIDTH);
			current:SetPoint("TOPLEFT",SBL_SpellListFrame,"TOPLEFT",(x*SBL_SIZE),-(y*SBL_SIZE));
		end
		current:SetID(i);
		current:Show();
	end
	UpdateSpells();
	SBL_SpellListFrame:Show();
	if (op >= SBL_SpellListFrame.spellButtons) then
		SBL_SpellListFrame.spellButtons = op;
	else
		for i = (op+1), SBL_SpellListFrame.spellButtons do
			current = getglobal("SBL_SpellListButton"..i);
			current:Hide();
		end
	end
end

--------------------
-- SpellButton Stuff
--------------------

function SBL_SpellListButton_OnLoad(self) 
	self:RegisterForDrag("LeftButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	self:SetAttribute("type*","spell");
	self:SetAttribute("CHATLINK-spell",ATTRIBUTE_NOOP);
	self:SetAttribute("PICKUPACTION-spell",ATTRIBUTE_NOOP);
end

function SBL_SpellListButton_OnEvent(self,event)
	if ( event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_COOLDOWN" ) then 
		SBL_SpellListButton_UpdateButton(self);
	elseif ( event == "CURRENT_SPELL_CAST_CHANGED" ) then
		SBL_SpellListButton_UpdateSelection(self);
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		SBL_SpellListButton_UpdateSelection(self);
	elseif ( event == "PET_BAR_UPDATE" ) then
		if ( SBL_SpellBookFrame.bookType == BOOKTYPE_PET ) then
			SBL_SpellListButton_UpdateButton(self);
		end
	end
end

function SBL_SpellListButton_OnShow(self)
	self:RegisterEvent("SPELLS_CHANGED");
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
	self:RegisterEvent("CRAFT_SHOW");
	self:RegisterEvent("CRAFT_CLOSE");
	self:RegisterEvent("TRADE_SKILL_SHOW");
	self:RegisterEvent("TRADE_SKILL_CLOSE");
	self:RegisterEvent("PET_BAR_UPDATE");

	SBL_SpellListButton_UpdateButton(self);
end

function SBL_SpellListButton_OnHide(self)
	self:UnregisterEvent("SPELLS_CHANGED");
	self:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
	self:UnregisterEvent("CURRENT_SPELL_CAST_CHANGED");
	self:UnregisterEvent("CRAFT_SHOW");
	self:UnregisterEvent("CRAFT_CLOSE");
	self:UnregisterEvent("TRADE_SKILL_SHOW");
	self:UnregisterEvent("TRADE_SKILL_CLOSE");
	self:UnregisterEvent("PET_BAR_UPDATE");
end
 
function SBL_SpellListButton_OnEnter(self)
	local id = self:GetID();
	local spellId = id ;
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( GameTooltip:SetSpell(spellId, SBL_SpellBookFrame.bookType) ) then
		self.UpdateTooltip = SBL_SpellListButton_OnEnter;
	else
		self.UpdateTooltip = nil;
	end
end


function SBL_SpellListButton_OnLeave(self)
	GameTooltip:Hide();
end

function SBL_SpellListButton_PostClick(self,button) 
	-- On Modified Click but set to work after click
	local id = self:GetID();
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

function SBL_SpellListButton_OnDrag(self) 
	local id = self:GetID();
	if ( id > MAX_SPELLS or not getglobal(self:GetName().."IconTexture"):IsShown() ) then
		return;
	end
	self:SetChecked(0);
	PickupSpell(id, SBL_SpellBookFrame.bookType);
end

function SBL_SpellListButton_UpdateSelection(self)
	local id =self:GetID();
	if ( (SBL_SpellBookFrame.bookType ~= BOOKTYPE_PET) and (id > SBL_SpellListFrame.spellRanks) ) then
		self:SetChecked("false");
		return;
	end

	if ( IsSelectedSpell(id, SBL_SpellBookFrame.bookType) ) then
		self:SetChecked("true");
	else
		self:SetChecked("false");
	end
end

function SBL_SpellListButton_UpdateButton(self)
	local id = self:GetID();
	local name = self:GetName();
	local iconTexture = getglobal(name.."IconTexture");
	local spellRank = getglobal(name.."SpellRank");
	local cooldown = getglobal(name.."Cooldown");
	local autoCastableTexture = getglobal(name.."AutoCastable");
	local autoCastModel = getglobal(name.."AutoCast");
	if ( id > SBL_SpellListFrame.spellRanks ) then
		self:Disable();
		iconTexture:Hide();
		spellRank:Hide();
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
		spellRank:Hide();
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
	else
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square");
	end
	
	iconTexture:SetTexture(texture);
	spellRank:SetText(strsub(subSpellName,-2));
	iconTexture:Show();
	spellRank:Show();
	SBL_SpellListButton_UpdateSelection(self);
end