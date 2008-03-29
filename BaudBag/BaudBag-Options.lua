local CheckButtons = {
  {Text = BaudBagAutoOpen,SavedVar="AutoOpen",Default=false,
    TooltipText = BaudBagAutoOpenTooltip},
  {Text = BaudBagBlankontop,SavedVar="BlankTop",Default=false,
    TooltipText = BaudBagBlankontopTooltip},
  {Text = BaudBagRarityColoring,SavedVar="RarityColor",Default=true,
    TooltipText = BaudBagRarityColoringTooltip}
};

local SliderBars = {
  {Text = BaudBagColumns,Low="2",High="20",SavedVar="Columns", Default={8,12},
    TooltipText = BaudBagColumnsTooltip},
  {Text = BaudBagScale,Low="50%",High="200%",SavedVar="Scale", Default={100,100}, 
    TooltipText = BaudBagScaleTooltip}
};

local Prefix = "BaudBag";
local SelectedBags = 1;
local SelectedContainer = 1;
local MaxBags = NUM_BANKBAGSLOTS + 1;
local SetSize = {6,NUM_BANKBAGSLOTS + 1};
local Updating, CfgBackup;


local function DebugMsg(msg)
  if BaudBag_Debug then
    DEFAULT_CHAT_FRAME:AddMessage(msg);
  end
end


function CopyTable(Value)
  if(type(Value)~="table")then
    return Value;
  end
  local Table = {};
  table.foreach(Value, function(k,v) Table[k]=CopyTable(v) end);
  return Table;
end


function BaudBagOptionsFrame_OnLoad()
  this:RegisterEvent("PLAYER_LOGIN");
  tinsert(UIMenus,this:GetName());
  SlashCmdList[Prefix.."_Options"] = function() BaudBagOptionsFrame:Show();end
  SLASH_BaudBag_Options1 = "/baudbag";
  SLASH_BaudBag_OptionsMenuName = "Baud Bag"; --Baud Menu Info
  DEFAULT_CHAT_FRAME:AddMessage(BaudBagAddMessage);

  BaudBagOptionsFrame:SetWidth(43 * MaxBags + 70);
  local Button, Check;
  for Bag = 1, MaxBags do
    Button = CreateFrame("CheckButton","BaudBagOptionsBag"..Bag,BaudBagOptionsFrame,"BaudBagOptionsBagTemplate");
    CreateFrame("Frame","BaudBagOptionsContainer"..Bag,BaudBagOptionsFrame,"BaudBagOptionsContainerTemplate");
    if(Bag == 1)then
      BaudBagOptionsContainer1:SetPoint("LEFT",BaudBagOptionsBag1,"LEFT",-6,0);
    else
      Button:SetPoint("LEFT","BaudBagOptionsBag"..(Bag-1),"RIGHT",8,0);
      Check = CreateFrame("CheckButton","BaudBagOptionsJoinCheck"..Bag,Button,"BaudBagOptionsJoinCheckTemplate");
      Check:SetPoint("BOTTOM",Button,"TOPLEFT",-4,4);
      Check:SetID(Bag);
      Check.tooltipText = BaudBagCheckTooltip;
    end
  end

  BaudBagEnabledCheckText:SetText(BaudBagEnabledText);
  BaudBagEnabledCheck.tooltipText = BaudBagEnabledTextTooltip;

  for Key, Value in ipairs(SliderBars)do
    getglobal(Prefix.."Slider"..Key.."Low"):SetText(Value.Low);
    getglobal(Prefix.."Slider"..Key.."High"):SetText(Value.High);
    getglobal(Prefix.."Slider"..Key).tooltipText = Value.TooltipText;
  end
  for Key, Value in ipairs(CheckButtons)do
    getglobal(Prefix.."CheckButton"..Key.."Text"):SetText(Value.Text);
    getglobal(Prefix.."CheckButton"..Key).tooltipText = Value.TooltipText;
  end
end


function BaudBagOptionsFrame_OnEvent()
  --Restoring the config also updates the bags, which requires the info available at login
  if(event=="PLAYER_LOGIN")then
    UIDropDownMenu_SetWidth(90, BaudBagOptionsSetDropDown);
    
    UIDropDownMenu_SetWidth(90, BaudBagOptionsBackgroundDropDown);
  end
end


function BaudBagOptionsFrame_OnShow()
  CfgBackup = CopyTable(BaudBag_Cfg);
  this.SaveChanges = false;
  BaudBagOptionsUpdate();
end


function BaudBagOptionsFrame_OnHide()
  if(this.SaveChanges==false)and CfgBackup then
    DebugMsg("Restoring config from backup.");
    this.SaveChanges = true;
    BaudBag_Cfg = CfgBackup;
    BaudBagRestoreCfg();
  end
  CfgBackup = nil;
end


function BaudBagRestoreCfg()
  DebugMsg("Restoring config structure.");
  if(type(BaudBag_Cfg)~="table")then
    BaudBag_Cfg = {};
  end
  for BagSet = 1, 2 do
    if(type(BaudBag_Cfg[BagSet])~="table")then
      BaudBag_Cfg[BagSet] = {};
    end
    if(type(BaudBag_Cfg[BagSet].Enabled)~="boolean")then
      BaudBag_Cfg[BagSet].Enabled = true;
    end
    if(type(BaudBag_Cfg[BagSet].Joined)~="table")then
      BaudBag_Cfg[BagSet].Joined = {};
    end
    if(type(BaudBag_Cfg[BagSet].ShowBags)~="boolean")then
      BaudBag_Cfg[BagSet].ShowBags = (BagSet==2)and true or false;
    end
    local Container = 0;
    BaudBagForEachBag(BagSet,function(Bag, Index)
      if(Bag==-2)and(BaudBag_Cfg[BagSet].Joined[Index]==nil)then
        BaudBag_Cfg[BagSet].Joined[Index] = false;
      end
      if(Container == 0)or(BaudBag_Cfg[BagSet].Joined[Index]==false)then
        Container = Container + 1;
        if(type(BaudBag_Cfg[BagSet][Container])~="table")then
          if(Container == 1)or(Bag==-2)then
            BaudBag_Cfg[BagSet][Container] = {};
          else
            BaudBag_Cfg[BagSet][Container] = CopyTable(BaudBag_Cfg[BagSet][Container-1]);
          end
        end
        if not BaudBag_Cfg[BagSet][Container].Name then
          --With the key ring, there isn't enough room for the player name aswell
          BaudBag_Cfg[BagSet][Container].Name = (Bag==-2)and BaudBagKeyRing or UnitName("player")..BaudBagOf..((BagSet==1)and BaudBagInventory or BaudBagBankBox);
        end
        if(type(BaudBag_Cfg[BagSet][Container].Background)~="number")then
          BaudBag_Cfg[BagSet][Container].Background = (Bag==-2)and 3 or 1;
        end
        for Key, Value in ipairs(SliderBars)do
          if(type(BaudBag_Cfg[BagSet][Container][Value.SavedVar])~="number")then
            BaudBag_Cfg[BagSet][Container][Value.SavedVar] = (Bag==-2)and(Value.SavedVar=="Columns")and 4 or Value.Default[BagSet];
          end
        end
        for Key, Value in ipairs(CheckButtons)do
          if(type(BaudBag_Cfg[BagSet][Container][Value.SavedVar])~="boolean")then
            BaudBag_Cfg[BagSet][Container][Value.SavedVar] = Value.Default;
          end
        end
      end
    end);
  end
  
  BaudUpdateJoinedBags();
  BaudBagUpdateBagFrames();
  BaudBagOptionsUpdate();
end


--This function is used by the drop down menu on containers
function BaudBagOptionsSelectContainer(BagSet, Container)
  SelectedBags = BagSet;
  SelectedContainer = Container;
  BaudBagOptionsUpdate();
end


function BaudBagOptionsUpdate()
  local Button, Check, Container, Texture;
  local ContNum = 1;
  local Bags = SetSize[SelectedBags];
  Updating = true;
  
  UIDropDownMenu_Initialize(BaudBagOptionsSetDropDown, BaudBagOptionsSetDropDown_Initialize);
  UIDropDownMenu_SetSelectedValue(BaudBagOptionsSetDropDown, SelectedBags);
  BaudBagEnabledCheck:SetChecked(BaudBag_Cfg[SelectedBags].Enabled~=false);

  BaudBagForEachBag(SelectedBags,function(Bag,Index)
    Button = getglobal("BaudBagOptionsBag"..Index);
    Check = getglobal("BaudBagOptionsJoinCheck"..Index);

    if(Index == 1)then
      --Only the first bag needs its position set, since the others are anchored to it always
      Button:SetPoint("LEFT",BaudBagOptionsFrame,"TOP",(Bags / 2) * -44,-120);
    else
      Check:SetChecked(BaudBag_Cfg[SelectedBags].Joined[Index]~=false);
      if not Check:GetChecked()then
        getglobal("BaudBagOptionsContainer"..ContNum):SetPoint("RIGHT","BaudBagOptionsBag"..(Index - 1),"RIGHT",6,0);
        ContNum = ContNum + 1;
        getglobal("BaudBagOptionsContainer"..ContNum):SetPoint("LEFT","BaudBagOptionsBag"..Index,"LEFT",-6,0);
      end
    end
    if BaudBagIcons[Bag]then
      Texture = BaudBagIcons[Bag];
    elseif(SelectedBags == 1)then
      Texture = GetInventoryItemTexture("player",ContainerIDToInventoryID(Bag));
    elseif BaudBag_Cache[Bag] and BaudBag_Cache[Bag].BagLink then
      Texture = select(10,GetItemInfo(BaudBag_Cache[Bag].BagLink));
    else
      Texture = nil;
    end
    getglobal(Button:GetName().."IconTexture"):SetTexture(Texture or select(2,GetInventorySlotInfo("Bag0Slot")));
    Button:SetID(ContNum);
    Button:Show();
  end);
  getglobal("BaudBagOptionsContainer"..ContNum):SetPoint("RIGHT","BaudBagOptionsBag"..Bags,"RIGHT",6,0);
  
  for Index = Bags + 1, MaxBags do
    getglobal("BaudBagOptionsBag"..Index):Hide();
  end

  if(SelectedContainer > ContNum)then
    SelectedContainer = 1;
  end
  local R, G, B;
  for Bag = 1, MaxBags do
    Container = getglobal("BaudBagOptionsContainer"..Bag);
    Button = getglobal("BaudBagOptionsBag"..Bag);
    Button:SetChecked(Button:GetID()==SelectedContainer);
    if(Bag <= ContNum)then
      if(Bag==SelectedContainer)then
        Container:SetBackdropColor(1,1,0);
        Container:SetBackdropBorderColor(1,1,0);
      else
        Container:SetBackdropColor(1,1,1);
        Container:SetBackdropBorderColor(1,1,1);
      end
      Container:Show();
    else
      Container:Hide();
    end
  end
  
  BaudBagNameEditBox:SetText(BaudBag_Cfg[SelectedBags][SelectedContainer].Name or "");
  
  UIDropDownMenu_Initialize(BaudBagOptionsBackgroundDropDown, BaudBagOptionsBackgroundDropDown_Initialize);
  UIDropDownMenu_SetSelectedValue(BaudBagOptionsBackgroundDropDown,BaudBag_Cfg[SelectedBags][SelectedContainer].Background);
  
  for Key, Value in ipairs(SliderBars)do
    local Slider = getglobal(Prefix.."Slider"..Key);
    Slider:SetValue(BaudBag_Cfg[SelectedBags][SelectedContainer][Value.SavedVar]);
  end
  
  for Key, Value in ipairs(CheckButtons)do
    local Button = getglobal(Prefix.."CheckButton"..Key);
    Button:SetChecked(BaudBag_Cfg[SelectedBags][SelectedContainer][Value.SavedVar]);
  end
  Updating = false;
end


function BaudBagNameEditBox_OnTextChanged()
  if Updating then
    return;
  end
  BaudBag_Cfg[SelectedBags][SelectedContainer].Name = BaudBagNameEditBox:GetText();
  BaudBagUpdateName(getglobal("BBCont"..SelectedBags.."_"..SelectedContainer));
end


function BaudBagOptionsSetDropDown_Initialize()
  local info = {}; --UIDropDownMenu_CreateInfo();
  info.func = BaudBagOptionsSetDropDown_OnClick;

  info.text = BaudBagInventory;
  info.value = 1;
  info.checked = (info.value == SelectedBags)and 1 or nil;
  UIDropDownMenu_AddButton(info);

  info.text = BaudBagBankBox;
  info.value = 2;
  info.checked = (info.value == SelectedBags)and 1 or nil;
  UIDropDownMenu_AddButton(info);
end


function BaudBagOptionsSetDropDown_OnClick()
  SelectedBags = this.value;

  BaudBagOptionsUpdate();
end


local TextureNames = {BaudBagBlizInventory,BaudBagBlizBank,BaudBagBlizKeyring,BaudBagTransparent,BaudBagSolid};

function BaudBagOptionsBackgroundDropDown_Initialize()
  local info = {}; --UIDropDownMenu_CreateInfo();
  info.func = BaudBagOptionsBackgroundDropDown_OnClick;
  local Selected = BaudBag_Cfg[SelectedBags][SelectedContainer].Background;

  for Key, Value in pairs(TextureNames)do
    info.text = Value;
    info.value = Key;
    info.checked = (Key == Selected)and 1 or nil;
    UIDropDownMenu_AddButton(info);
  end
end


function BaudBagOptionsBackgroundDropDown_OnClick()
  BaudBag_Cfg[SelectedBags][SelectedContainer].Background = this.value;
  UIDropDownMenu_SetSelectedValue(BaudBagOptionsBackgroundDropDown,this.value);
  BaudBagUpdateContainer(getglobal("BBCont"..SelectedBags.."_"..SelectedContainer));
end


function BaudBagEnabledCheck_OnClick()
  if(this:GetChecked())then
    PlaySound("igMainMenuOptionCheckBoxOff");
  else
    PlaySound("igMainMenuOptionCheckBoxOn");
    BaudBagCloseBagSet(SelectedBags);
  end
  BaudBag_Cfg[SelectedBags].Enabled = (this:GetChecked()==1);
end


function BaudBagOptionsBag_OnClick()
  SelectedContainer = this:GetID();
  BaudBagOptionsUpdate();
end


function BaudBagOptionsJoinCheck_OnClick()
  if(this:GetChecked())then
    PlaySound("igMainMenuOptionCheckBoxOff");
  else
    PlaySound("igMainMenuOptionCheckBoxOn");
  end
  BaudBag_Cfg[SelectedBags].Joined[this:GetID()] = this:GetChecked()and true or false;
  local ContNum = 2;
  for Bag = 2,(this:GetID()-1)do
    if(BaudBag_Cfg[SelectedBags].Joined[Bag]==false)then
      ContNum = ContNum + 1;
    end
  end
  if this:GetChecked()then
    tremove(BaudBag_Cfg[SelectedBags],ContNum);
  else
    tinsert(BaudBag_Cfg[SelectedBags],ContNum,CopyTable(BaudBag_Cfg[SelectedBags][ContNum-1]));
  end
  BaudBagOptionsUpdate();
  BaudUpdateJoinedBags();
  --Newly created bags could "Jump" infront of the options frame
  BaudBagOptionsFrame:Raise();
end


function BaudBagOptions_Defaults()
  DebugMsg("Setting default config.");
  BaudBag_Cfg = nil;
  BaudBagRestoreCfg();
end


function BaudBagCheckButton_OnClick()
  if(this:GetChecked())then
    PlaySound("igMainMenuOptionCheckBoxOff");
  else
    PlaySound("igMainMenuOptionCheckBoxOn");
  end
  local SavedVar = CheckButtons[this:GetID()].SavedVar;
  BaudBag_Cfg[SelectedBags][SelectedContainer][SavedVar] = (this:GetChecked()==1);
  if(SavedVar=="BlankTop")or(SavedVar=="RarityColor")then
    BaudBagUpdateContainer(getglobal("BBCont"..SelectedBags.."_"..SelectedContainer));
  end
end


function BaudBagSlider_OnValueChanged()
  getglobal(this:GetName().."Text"):SetText(format(SliderBars[this:GetID()].Text,this:GetValue()));
  if Updating then
    return;
  end
  local SavedVar = SliderBars[this:GetID()].SavedVar;
  BaudBag_Cfg[SelectedBags][SelectedContainer][SavedVar] = this:GetValue();
  if(SavedVar=="Scale")then
    BaudUpdateContainerData(SelectedBags,SelectedContainer);
  elseif(SavedVar=="Columns")then
    BaudBagUpdateContainer(getglobal("BBCont"..SelectedBags.."_"..SelectedContainer));
  end
end