----------------------------------------------------------------------------------------------------
-- Drood Focus 2.2.20b: Options
----------------------------------------------------------------------------------------------------
DroodFocusOptions = { };

local _G = getfenv(0);

----------------------------------------------------------------------------------------------------
-- Widgets Handlers
----------------------------------------------------------------------------------------------------
function DroodFocusOptions:Handler()
	if(DroodFocusOptionsFrame:IsVisible()) then
		_G["DebuffContener"].texture:SetTexture(0,0,0,0);
		HideUIPanel(DroodFocusOptionsFrame);
	else
		ShowUIPanel(DroodFocusOptionsFrame);
	end
end

----------------------------------------------------------------------------------------------------
-- Scaling
----------------------------------------------------------------------------------------------------
local function DroodFocusOptionsScaleSlider_Init()
	if(not DroodFocusOptions.scaleSliderLoaded) then
		local Text, Low, Full;
		Text = _G[this:GetName().."Text"];
		Low = _G[this:GetName().."Low"];
		High = _G[this:GetName().."High"];
		
		Text:SetText(DROODFOCUS_SCALE);
		Low:SetText(DROODFOCUS_LOW);
		High:SetText(DROODFOCUS_HIGH);
		
		this:SetMinMaxValues(1.0, 2.0);
		this:SetValueStep(.1);
		
		DroodFocusOptions.scaleSliderLoaded = true;
	end
	local value = format("%.1f", DroodFocusConfig.Scale);
	_G[this:GetName().."Value"]:SetText(value);
	DroodFocusFrame:SetScale(DroodFocusConfig.Scale);
end

local function DroodFocusOptionsContenerXSlider_Init()
	if(not DroodFocusOptions.ContenerXSliderLoaded) then
		local Text, Low, Full;
		Text = _G[this:GetName().."Text"];
		Low = _G[this:GetName().."Low"];
		High = _G[this:GetName().."High"];
		
		Text:SetText(DROODFOCUS_CONTX);
		Low:SetText(DROODFOCUS_MINI);
		High:SetText(DROODFOCUS_MAXI);
		
		this:SetMinMaxValues(-400, 400);
		this:SetValueStep(0.5);
		
		DroodFocusOptions.ContenerXSliderLoaded = true;
	end
	local value = format("%.1f", DroodFocusConfig.contenerX);
	_G[this:GetName().."Value"]:SetText(value);
	_G["DebuffContener"]:SetPoint("CENTER", UIparent, "CENTER", DroodFocusConfig.contenerX, DroodFocusConfig.contenerY);
end

local function DroodFocusOptionsContenerYSlider_Init()
	if(not DroodFocusOptions.ContenerYSliderLoaded) then
		local Text, Low, Full;
		Text = _G[this:GetName().."Text"];
		Low = _G[this:GetName().."Low"];
		High = _G[this:GetName().."High"];
		
		Text:SetText(DROODFOCUS_CONTY);
		Low:SetText(DROODFOCUS_MINI);
		High:SetText(DROODFOCUS_MAXI);
		
		this:SetMinMaxValues(-400, 400);
		this:SetValueStep(0.5);
		
		DroodFocusOptions.ContenerYSliderLoaded = true;
	end
	local value = format("%.1f", DroodFocusConfig.contenerY);
	_G[this:GetName().."Value"]:SetText(value);
	_G["DebuffContener"]:SetPoint("CENTER", UIparent, "CENTER", DroodFocusConfig.contenerX, DroodFocusConfig.contenerY);
end

local function DroodFocusOptionsContenerScaleSlider_Init()
	if(not DroodFocusOptions.ContenerScaleSliderLoaded) then
		local Text, Low, Full;
		Text = _G[this:GetName().."Text"];
		Low = _G[this:GetName().."Low"];
		High = _G[this:GetName().."High"];
		
		Text:SetText(DROODFOCUS_SCALE);
		Low:SetText(DROODFOCUS_LOW);
		High:SetText(DROODFOCUS_HIGH);
		
		this:SetMinMaxValues(1.0, 2.0);
		this:SetValueStep(.1);
				
		DroodFocusOptions.ContenerScaleSliderLoaded = true;
	end
	local value = format("%.1f", DroodFocusConfig.contenerScale);
	_G[this:GetName().."Value"]:SetText(value);
	_G["DebuffContener"]:SetScale(DroodFocusConfig.contenerScale);
end

local function DroodFocusOptionsBloodAlphaSlider_Init()
	if(not DroodFocusOptions.BloodAlphaSliderLoaded) then
		local Text, Low, Full;
		Text = _G[this:GetName().."Text"];
		Low = _G[this:GetName().."Low"];
		High = _G[this:GetName().."High"];
		
		Text:SetText(DROODFOCUS_ALPHA);
		Low:SetText(DROODFOCUS_LOW);
		High:SetText(DROODFOCUS_HIGH);
		
		this:SetMinMaxValues(0, 1.0);
		this:SetValueStep(.1);
				
		DroodFocusOptions.BloodAlphaSliderLoaded = true;
	end
	local value = format("%.1f", DroodFocusConfig.BloodAlpha);
	_G[this:GetName().."Value"]:SetText(value);
	
	DroodFocus:newClaw();DroodFocus:newClaw();
	DroodFocus:newBlood();DroodFocus:newBlood();DroodFocus:newBlood();
	
end

-- slider
function DroodFocusOptions:ScaleSlider_OnShow()
	DroodFocusOptionsScaleSlider_Init();
	this:SetValue(DroodFocusConfig.Scale);
end

function DroodFocusOptions:ScaleSlider_OnValueChanged()
	DroodFocusConfig.Scale = this:GetValue();
	DroodFocusOptionsScaleSlider_Init();
end

function DroodFocusOptions:ContenerXSlider_OnShow()
	DroodFocusOptionsContenerXSlider_Init();
	this:SetValue(DroodFocusConfig.contenerX);
end

function DroodFocusOptions:ContenerXSlider_OnValueChanged()
	DroodFocusConfig.contenerX = this:GetValue();
	DroodFocusOptionsContenerXSlider_Init();
end

function DroodFocusOptions:ContenerYSlider_OnShow()
	DroodFocusOptionsContenerYSlider_Init();
	this:SetValue(DroodFocusConfig.contenerY);
end

function DroodFocusOptions:ContenerYSlider_OnValueChanged()
	DroodFocusConfig.contenerY = this:GetValue();
	DroodFocusOptionsContenerYSlider_Init();
end

function DroodFocusOptions:ContenerScaleSlider_OnShow()
	DroodFocusOptionsContenerScaleSlider_Init();
	this:SetValue(DroodFocusConfig.contenerScale);
end

function DroodFocusOptions:ContenerScaleSlider_OnValueChanged()
	DroodFocusConfig.contenerScale = this:GetValue();
	DroodFocusOptionsContenerScaleSlider_Init();
end

function DroodFocusOptions:BloodAlphaSlider_OnShow()
	DroodFocusOptionsBloodAlphaSlider_Init();
	this:SetValue(DroodFocusConfig.BloodAlpha);
end

function DroodFocusOptions:BloodAlphaSlider_OnValueChanged()
	DroodFocusConfig.BloodAlpha = this:GetValue();
	DroodFocusOptionsBloodAlphaSlider_Init();
end

--lock
function DroodFocusOptions:LockCheckButton_OnShow()
	this:SetChecked(DroodFocusConfig.Locked);
end

function DroodFocusOptions:LockCheckButton_OnClick()
	if(1 == this:GetChecked()) then
		DroodFocusConfig.Locked = true;
	else
		DroodFocusConfig.Locked = false;
	end
	DroodFocus:Toggle();
end

--enable
function DroodFocusOptions:EnableCheckButton_OnShow()
	this:SetChecked(DroodFocusConfig.Enable);
end

function DroodFocusOptions:EnableCheckButton_OnClick()
	if(1 == this:GetChecked()) then
		DroodFocusConfig.Enable = true;
	else
		DroodFocusConfig.Enable = false;
	end
	DroodFocus:Toggle();
end

--claws
function DroodFocusOptions:ClawCheckButton_OnShow()
	this:SetChecked(DroodFocusConfig.Claws);
end

function DroodFocusOptions:ClawCheckButton_OnClick()
	if(1 == this:GetChecked()) then
		DroodFocusConfig.Claws = true;
	else
		DroodFocusConfig.Claws = false;
	end
	DroodFocus:Toggle();
end

--tracker
function DroodFocusOptions:TrackerCheckButton_OnShow()
	this:SetChecked(DroodFocusConfig.Tracker);
	if (DroodFocusConfig.Tracker) then
		_G["DebuffContener"].texture:SetTexture(0,0,0,0.5);
	else
		_G["DebuffContener"].texture:SetTexture(0,0,0,0);
	end
	DroodFocus:Toggle();
end

function DroodFocusOptions:TrackerCheckButton_OnClick()
	if(1 == this:GetChecked()) then
		DroodFocusConfig.Tracker = true;
		_G["DebuffContener"].texture:SetTexture(0,0,0,0.5);
	else
		DroodFocusConfig.Tracker = false;
		_G["DebuffContener"].texture:SetTexture(0,0,0,0);
	end
	DroodFocus:Toggle();
end