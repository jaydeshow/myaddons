
local CSB_SIZE = 30; -- Pixel Size of Spell Icons
local CSB_MAX_WIDTH = 4; -- 4 Icons across per row

function CSB_SpellLister_OnLoad(self)
	-- Prepare needed attributes
	self.spellAnchor = self; -- Points to SpellButton from the book
	self.spellButtons = 0; -- Number of Spells created
	self.offset = 0; -- Lowest Rank Spell for spell id
end

function CSB_SpellLister_SpellButtonEntered(spellButton,lowestRank,highestRank)
	-- When a Spell Button is entered, populate frame and show
	if (CSB_SpellLister.offset == (lowestRank-1)) then
		-- Same button, no change.
		CSB_SpellLister:Show();
		return;
	end
	
	-- If the rank boundaries are bad, don't show.
	if (lowestRank > MAX_SPELLS or highestRank > MAX_SPELLS) then
		CSB_SpellLister:Hide();
		return;
	end

	CSB_SpellLister.spellAnchor = spellButton;
	CSB_SpellLister:SetPoint("TOPLEFT",spellButton,"TOPRIGHT");
	CSB_SpellLister.offset = lowestRank-1;
	CSB_SpellLister.spellRanks = highestRank;
	local current,op;
	op = 0;
	--Set first Frame down
	--Create new frames as needed or reset old
	for i = lowestRank,highestRank do 
		op = op + 1;
		current = getglobal("CSB_SpellListButton"..op);
		if (current) then
		end
		if (current == nil) then -- if it don't exist
			current = CreateFrame("CheckButton","CSB_SpellListButton"..op,CSB_SpellLister,"CSB_SpellListButtonTemplate");
			local y = floor((op-1) / CSB_MAX_WIDTH);
			local x = ((op-1) % CSB_MAX_WIDTH);
			current:SetPoint("TOPLEFT",CSB_SpellLister,"TOPLEFT",(x*CSB_SIZE),-(y*CSB_SIZE));
		end
		current:SetID(i);
		current:Enable();
		current:Show();
	end
	CSB_SpellLister:Show();
	-- Update existing button count list
	-- If a button exists but is not used, disable and hide it
	if (op >= CSB_SpellLister.spellButtons) then
		CSB_SpellLister.spellButtons = op;
	else
		for i = (op+1), CSB_SpellLister.spellButtons do
			current = getglobal("CSB_SpellListButton"..i);
			current:Disable();
			current:Hide();
		end
	end
end

--------------------
-- SpellButton Stuff
--------------------

function CSB_SpellListButton_OnLoad(self)
	-- set static attributes 
	self:RegisterForDrag("LeftButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	self:SetAttribute("type*","spell");
	self:SetAttribute("CHATLINK-spell",ATTRIBUTE_NOOP);
	self:SetAttribute("PICKUPACTION-spell",ATTRIBUTE_NOOP);
end

function CSB_SpellListButton_OnEvent(self,event)
	-- Lower Ranks only need the cooldown updated
	if ( event == "SPELL_UPDATE_COOLDOWN" ) then 
		CSB_SpellListButton_UpdateButton(self);
	end
end

function CSB_SpellListButton_OnShow(self)
	-- Register used events when usable
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	
	CSB_SpellListButton_UpdateButton(self);
end

function CSB_SpellListButton_OnHide(self)
	-- Unregister events when not usable
	self:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
end
 
function CSB_SpellListButton_OnEnter(self)
	-- When entered, show the tooltip
	local id = self:GetID();
	local spellId = id ;
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( GameTooltip:SetSpell(spellId, SpellBookFrame.bookType) ) then
		self.UpdateTooltip = CSB_SpellListButton_OnEnter;
	else
		self.UpdateTooltip = nil;
	end
end


function CSB_SpellListButton_OnLeave(self)
	-- On leaving, hide the tooltip
	GameTooltip:Hide();
end

function CSB_SpellListButton_PostClick(self,button) 
	-- On Modified Click but set to work after click
	local id = self:GetID();
	if ( IsModifiedClick("CHATLINK") ) then
		if ( MacroFrame and MacroFrame:IsShown() ) then
			local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
			if ( spellName and not IsPassiveSpell(id, SpellBookFrame.bookType) ) then
				if ( subSpellName and (strlen(subSpellName) > 0) ) then
					ChatEdit_InsertLink(spellName.."("..subSpellName..")");
				else
					ChatEdit_InsertLink(spellName);
				end
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

function CSB_SpellListButton_OnDrag(self)
	-- Pick up the spell when dragged 
	local id = self:GetID();
	PickupSpell(id, SpellBookFrame.bookType);
end

function CSB_SpellListButton_UpdateButton(self)
	-- Update the Spell Button
	local id = self:GetID();
	local name = self:GetName();
	local iconTexture = getglobal(name.."IconTexture");
	local spellRank = getglobal(name.."SpellRank");
	local cooldown = getglobal(name.."Cooldown");
	local texture = GetSpellTexture(id, SpellBookFrame.bookType);
	
	local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
	local fullName = spellName.."("..subSpellName..")";
	self:SetAttribute("spell", fullName);
	local start, duration, enable = GetSpellCooldown(id, SpellBookFrame.bookType);
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
	if ( enable == 1 ) then
		iconTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		iconTexture:SetVertexColor(0.4, 0.4, 0.4);
	end

	iconTexture:SetTexture(texture);
	spellRank:SetText(strsub(subSpellName,-2));
	iconTexture:Show();
	spellRank:Show();
end