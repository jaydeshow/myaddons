local TradeTabs = CreateFrame("Frame","TradeTabs")

local tradeSpells = {
	28596, -- Alchemy
	29844, -- Blacksmithing
	33359, -- Cooking
	30350, -- Engineering
	27028, -- First Aid
	28897, -- Jewel Crafting
	32549, -- Leatherworking
	2842,  -- Poisons
	2656,  -- Smelting
	26790, -- Tailoring
}

local craftSpells = {
	5149,  -- Beast Training
	28029, -- Enchanting
}

local MACRO_TEXT_FORMAT = [[
/script HideUIPanel(%s)
/cast %s 
]]


function TradeTabs:OnEvent(event,...)
	self:UnregisterEvent(event)
	if not IsLoggedIn() then
		self:RegisterEvent(event)
	elseif InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		self.queue = self.queue or {}
		self.queue[event] = true
	else	
		if self.queue then
			for v in pairs(self.queue) do
				self.queue[v] = nil
				if v ~= event then
					self:Initialize(v)
				end
			end
		end
		if event == "TRADE_SKILL_SHOW" or event == "CRAFT_SHOW" then
			self:Initialize(event)
		end		
	end
end


function TradeTabs:Initialize(event)
	if not self.tradeSpells then
		self:InitSpells()
	end

	local parent
	if SkilletFrame then
		parent = SkilletFrame
		self:UnregisterAllEvents()
	elseif ATSWFrame then
		parent = ATSWFrame
		self:UnregisterAllEvents()
	elseif event == "TRADE_SKILL_SHOW" then
		parent = TradeSkillFrame
	elseif event == "CRAFT_SHOW" then
		parent = CraftFrame
	end	
	
	local prev = self:BuildTabs(self.tradeSpells,nil,parent,"CraftFrame")
	self:BuildTabs(self.craftSpells,prev,parent,"TradeSkillFrame")
end

function TradeTabs:BuildTabs(list,prev,parent,hideFrame)
	for spell,spellid in pairs(list) do
		local tab = self:CreateTab(spell,spellid,parent,hideFrame)
		local point,relPoint,x,y = "TOPLEFT","BOTTOMLEFT",0,-17
		if not prev then
			prev,relPoint,x,y = parent,"TOPRIGHT",-32,-64
			if (parent == SkilletFrame) or (IsAddOnLoaded("Skinner")) then x = 0 end-- Special case. ew
		end
		tab:SetPoint(point,prev,relPoint,x,y)
		prev = tab
	end
	return prev
end

local function fillList(list)
	for i = 1,#list do
		list[GetSpellInfo(list[i])] = true
	end
end

function TradeTabs:InitSpells()
	fillList(tradeSpells)
	fillList(craftSpells)

	self.tradeSpells = {}
	self.craftSpells = {}
	
	for i=1,MAX_SPELLS do
		local n = GetSpellName(i,"spell")
		if tradeSpells[n] then
			self.tradeSpells[n] = i
		elseif craftSpells[n] then
			self.craftSpells[n] = i
		end		
	end
end

local function onEnter(self) 
    GameTooltip:SetOwner(self,"ANCHOR_RIGHT") GameTooltip:SetText(self.tooltip) 
    self:GetParent():LockHighlight()
end

local function onLeave(self) 
    GameTooltip:Hide()
    self:GetParent():UnlockHighlight()
end   

local function updateSelection(self)
	if IsCurrentSpell(self.spellID,"spell") then
		self:SetChecked(true)
		self.clickStopper:Show()
	else
		self:SetChecked(false)
		self.clickStopper:Hide()
	end
end

local function createClickStopper(button)
    local f = CreateFrame("Frame",nil,button)
    f:SetAllPoints(button)
    f:EnableMouse(true)
    f:SetScript("OnEnter",onEnter)
    f:SetScript("OnLeave",onLeave)
    button.clickStopper = f
    f.tooltip = button.tooltip
    f:Hide()
end


function TradeTabs:CreateTab(spell,spellID,parent,hideFrame)
    local button = CreateFrame("CheckButton",nil,parent,"SpellBookSkillLineTabTemplate,SecureActionButtonTemplate")
    button.tooltip = spell
    button.hideFrame = hideFrame
	button:Show()
    button:SetAttribute("type","macro")
    button:SetAttribute("macrotext",MACRO_TEXT_FORMAT:format(hideFrame,spell))
    button.spellID = spellID
    button:SetNormalTexture(GetSpellTexture(spellID, "spell"))
	
	button:SetScript("OnEvent",updateSelection)
	button:RegisterEvent("TRADE_SKILL_SHOW")
	button:RegisterEvent("TRADE_SKILL_CLOSE")
	button:RegisterEvent("CRAFT_SHOW")
	button:RegisterEvent("CRAFT_CLOSE")
	button:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

    createClickStopper(button)
    updateSelection(button)
	return button
end

TradeTabs:RegisterEvent("TRADE_SKILL_SHOW")
TradeTabs:RegisterEvent("CRAFT_SHOW")
TradeTabs:RegisterEvent("UNIT_SPELLCAST_SUECCEEDED")
TradeTabs:SetScript("OnEvent",TradeTabs.OnEvent)
