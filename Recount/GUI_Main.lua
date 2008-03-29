local me={}
local SM = LibStub:GetLibrary("LibSharedMedia-3.0")
local Events = AceLibrary("AceEvent-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Recount")

function me:SetFontSize(string, size)
	local Font, Height, Flags = string:GetFont()
	string:SetFont(Font, size, Flags)
end

--Violation was my reference (I like the basic look of violation just not the backend)
--Make sure to start with row 1 and go upwards when creating though should be safe if you don't just more function calls
function me:CreateRow(num)
	if num<1 or Recount.MainWindow.Rows[num] then
		return
	end

	local row=CreateFrame("Button","Recount_MainWindow_Bar"..num,Recount.MainWindow)
	
	row:SetPoint("TOPLEFT",Recount.MainWindow,"TOPLEFT",2,-32-(Recount.db.char.MainWindow.RowHeight+Recount.db.char.MainWindow.RowSpacing)*(num-1))
	row:SetHeight(Recount.db.char.MainWindow.RowHeight)
	row:SetWidth(Recount.MainWindow:GetWidth()-4)
	row:SetScript("OnClick", function() 
					if arg1=="RightButton" then
						dewdrop:Open(this)
					elseif type(this.clickFunc)=="function" and this.clickData then
						this:clickFunc(this.clickData)						
					end
				end)
	row:SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");Recount.MainWindow:TooltipFunc(this.Name,this.TooltipData);GameTooltip:Show() end)
	row:SetScript("OnLeave", function() GameTooltip:Hide() end)
	row:EnableMouse(true)
	row:RegisterForClicks("LeftButtonDown","RightButtonUp")

	--Add code for the button later
	
	row.StatusBar=CreateFrame("StatusBar",nil,row)
	row.StatusBar:SetAllPoints(row)

	local BarTexture

	if not BarTexture then
		BarTexture=Recount.db.char.BarTexture
	end

	if BarTexture==nil then
		BarTexture=SM:Fetch("statusbar","BantoBar")
	else
		BarTexture=SM:Fetch("statusbar",BarTexture)
	end
	row.StatusBar:SetStatusBarTexture(BarTexture)
	row.StatusBar:SetStatusBarColor(.5, .5, .5, 1)
	row.StatusBar:SetMinMaxValues(0,100)
	row.StatusBar:SetValue(100)
	row.StatusBar:Show()

	row.LeftText=row.StatusBar:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
	row.LeftText:SetPoint("LEFT", row.StatusBar,"LEFT",2)
	row.LeftText:SetJustifyH("LEFT")
	row.LeftText:SetText("Test")
	row.LeftText:SetTextColor(1,1,1,1)
	me:SetFontSize(row.LeftText,Recount.db.char.MainWindow.RowHeight*0.75)
	Recount:AddFontString(row.LeftText)

	row.RightText=row.StatusBar:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
	row.RightText:SetPoint("RIGHT", row.StatusBar,"RIGHT",-2)
	row.RightText:SetJustifyH("RIGHT")
	row.RightText:SetText("0")
	row.RightText:SetTextColor(1,1,1,1)
	me:SetFontSize(row.RightText,Recount.db.char.MainWindow.RowHeight*0.75)
	Recount:AddFontString(row.RightText)

	Recount.MainWindow.Rows[num]=row
	Recount.MainWindow.RowsCreated=num

	row.id=num

	dewdrop:Register(row,'children',me.ShowRowDropdown)
end

function me:ShowRowDropdown()
	if this and this.LeftText then
		dewdrop:AddLine('text',this.LeftText:GetText(),'isTitle',true,'notCheckable', true)
		dewdrop:AddLine('text',L["Show Details (Left Click)"],'func',me.ShowDetail,'arg1',me,'arg2',this.name,'notCheckable', true, 'closeWhenClicked', true)
		dewdrop:AddLine('text',L["Show Graph (Shift Click)"],'func',me.ShowGraphWindow,'arg1',me,'arg2',this.name,'notCheckable', true, 'closeWhenClicked', true)
		dewdrop:AddLine('text',L["Add to Current Graph (Alt Click)"],'func',me.AddCombatantToGraph,'arg1',me,'arg2',this.name,'notCheckable', true, 'closeWhenClicked', true)
		local Settings=Recount.MainWindow.RealtimeSettings
		if Settings then
			dewdrop:AddLine('text',L["Show Realtime Graph (Ctrl Click)"],'func',me.ShowRealtime,'arg1',me,'arg2',this.name,'notCheckable', true, 'closeWhenClicked', true)
		end
		dewdrop:AddLine('text',L["Delete Combatant (Ctrl-Alt Click)"],'func',me.DeleteCombatant,'arg1',me,'arg2',this.name,'notCheckable',true,'closeWhenClicked', true) -- Elsia: Add delete combatant feature
	end
end

function me:DeleteCombatant(name) -- Elsia: Add delete combatant feature
	Recount.db.char.combatants[name]=nil
	Recount:SetMainWindowMode(Recount.MainWindowMode)
	Recount:FullRefreshMainWindow()
end

function Recount:FullRefreshMainWindow()
	Recount:FreeTableRecurseLimit(Recount.MainWindow.DispTableSorted,1)
	Recount:FreeTable(Recount.MainWindow.DispTableLookup)
	Recount.MainWindow.DispTableSorted=Recount:GetTable()
	Recount.MainWindow.DispTableLookup=Recount:GetTable()
end

function me:FixRow(i)
	local row=Recount.MainWindow.Rows[i]
	local MaxNameWidth=row:GetWidth()-row.RightText:GetStringWidth()-4
	
	if MaxNameWidth<16 then
		MaxNameWidth=16
	end

	local LText=row.LeftText:GetText()
	
	while row.LeftText:GetStringWidth()>MaxNameWidth do
		LText=strsub(LText,1,#LText-1)
		row.LeftText:SetText(LText.."...")
	end
end

function Recount:BarsChanged()
	for k, v in pairs(Recount.MainWindow.Rows) do
		v:SetHeight(Recount.db.char.MainWindow.RowHeight)
		v:SetPoint("TOPLEFT",Recount.MainWindow,"TOPLEFT",2,-32-(Recount.db.char.MainWindow.RowHeight+Recount.db.char.MainWindow.RowSpacing)*(k-1))
		me:SetFontSize(v.LeftText,Recount.db.char.MainWindow.RowHeight*0.75)
		me:SetFontSize(v.RightText,Recount.db.char.MainWindow.RowHeight*0.75)
	end
	Recount:ResizeMainWindow()
end

function Recount:UpdateBarTextures()
	for _, v in pairs(Recount.MainWindow.Rows) do
		v.StatusBar:SetStatusBarTexture(SM:Fetch(SM.MediaType.STATUSBAR, Recount.db.char.BarTexture))
	end
	
	if Recount.db.char.Font then
		Recount:SetFont(Recount.db.char.Font)
	end
end

function Recount:SetBarTextures(handle)
	local Texture=SM:Fetch(SM.MediaType.STATUSBAR,handle) -- "statusbar"
	Recount.db.char.BarTexture=handle
	for _, v in pairs(Recount.MainWindow.Rows) do
		v.StatusBar:SetStatusBarTexture(Texture)
	end
end

--[[function Recount:SharedMedia_SetGlobal(_,type, handle)	
	Recount:SetBarTextures(handle)
end--]]

function me:SetBar(num,left,right,value,color,clickData,clickFunc,tooltipData)
	if num<1 or not Recount.MainWindow.Rows[num] then
		return
	end
	
	local Row=Recount.MainWindow.Rows[num]
	Row:Show()
	Row.StatusBar:SetValue(value)
	Row.LeftText:SetText(left)
	Row.RightText:SetText(right)
	Row.Name=left
	Row.TooltipData=tooltipData
	Row.clickData=clickData
	Row.clickFunc=clickFunc

	if color then
		Row.StatusBar:SetStatusBarColor(color.r,color.g,color.b,1)
--		Recount.Colors:RegisterFunction("Class","MOB",me.SetBarColors,Row.StatusBar) -- tooltipData.enClass
--		Recount.Colors:RegisterTexture("Class",tooltipData.enClass, Row.StatusBar)
--		Recount.Colors:RegisterBackground("Class",tooltipData.enClass, Row.StatusBar)
--		Recount:Print(tooltipData.enClass)
	end
	
	Row.LeftText:SetTextColor(Recount.db.profile.Colors.Bar["Bar Text"].r,Recount.db.profile.Colors.Bar["Bar Text"].g,Recount.db.profile.Colors.Bar["Bar Text"].b,1);
	Row.RightText:SetTextColor(Recount.db.profile.Colors.Bar["Bar Text"].r,Recount.db.profile.Colors.Bar["Bar Text"].g,Recount.db.profile.Colors.Bar["Bar Text"].b,1);
end

function me:SetBarColors(r,g,b)
	
	self:SetStatusBarColor(r,g,b,1)
end

function Recount:ResizeMainWindow()
	--How many bars do we have now?
	local Bars=math.floor((Recount.MainWindow:GetHeight()-32.95)/(Recount.db.char.MainWindow.RowHeight+Recount.db.char.MainWindow.RowSpacing))
	

	if Bars<Recount.MainWindow.CurRows then
		for i=Bars+1,Recount.MainWindow.CurRows do
			Recount.MainWindow.Rows[i]:Hide()
		end
	elseif Bars>Recount.MainWindow.RowsCreated then
		for i=Recount.MainWindow.RowsCreated+1,Bars do
			me:CreateRow(i)
		end
	end

	--Update all the bar widths
	local CurWidth=Recount.MainWindow:GetWidth()-4
	for i=1,Bars do
		Recount.MainWindow.Rows[i]:Show()
		Recount.MainWindow.Rows[i]:SetWidth(CurWidth)
	end

	Recount.MainWindow.CurRows=Bars

	Recount.MainWindow.ScrollBar:SetPoint("TOPLEFT", Recount.MainWindow.Rows[1], "TOPLEFT", -4, 0)
	Recount.MainWindow.ScrollBar:SetPoint("BOTTOMRIGHT", Recount.MainWindow.Rows[Bars], "BOTTOMRIGHT", -4, 0)

	Recount:RefreshMainWindow()
end

function Recount:CreateMainWindow()
	Recount.MainWindow=Recount:CreateFrame("Recount_MainWindow",L["Main"],140,200, function() Events:ScheduleRepeatingEvent(Recount.RefreshMainWindow,1);Recount.db.char.MainWindowVis=true end, function() Events:CancelAllScheduledEvents();Recount.db.char.MainWindowVis=false end)

	local theFrame=Recount.MainWindow

	theFrame:SetResizable(true)
	theFrame:SetMinResize(140,63)
	theFrame:SetMaxResize(400,520)		

	theFrame:SetScript("OnSizeChanged", function()
						if ( this.isResizing ) then
							Recount:ResizeMainWindow()
							
							Recount.db.char.MainWindowHeight=this:GetHeight()
							Recount.db.char.MainWindowWidth=this:GetWidth()
						end
					end)

	theFrame.TitleClick=CreateFrame("FRAME",nil,theFrame)
	theFrame.TitleClick:SetAllPoints(theFrame.Title)
	theFrame.TitleClick:EnableMouse(true)
	theFrame.TitleClick:SetScript("OnMouseDown",function() dewdrop:Open(this) 
							local parent=this:GetParent()
							if ( ( ( not parent.isLocked ) or ( parent.isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then
							  Recount:SetWindowTop(parent)
							  parent:StartMoving();
							  parent.isMoving = true;
							 end
							end)
	theFrame.TitleClick:SetScript("OnMouseUp", function() 
						local parent=this:GetParent()
						if ( parent.isMoving ) then
						  parent:StopMovingOrSizing();
						  parent.isMoving = false;
						 end
						end)


	theFrame.ScrollBar=CreateFrame("SCROLLFRAME","Recount_MainWindow_ScrollBar",theFrame,"FauxScrollFrameTemplate")
	theFrame.ScrollBar:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(20, Recount.RefreshMainWindow) end)
	Recount:SetupScrollbar("Recount_MainWindow_ScrollBar")

	


	theFrame.DragBottomRight = CreateFrame("Frame", nil, theFrame)
	theFrame.DragBottomRight:Show()
	theFrame.DragBottomRight:SetFrameLevel( theFrame:GetFrameLevel() + 10)
	theFrame.DragBottomRight:SetWidth(16)
	theFrame.DragBottomRight:SetHeight(16)
	theFrame.DragBottomRight:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOMRIGHT", 0, 0)
	theFrame.DragBottomRight:EnableMouse(true)
	theFrame.DragBottomRight:SetScript("OnMouseDown", function() if ((( not this:GetParent().isLocked ) or ( this:GetParent().isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then this:GetParent().isResizing = true; this:GetParent():StartSizing("BOTTOMRIGHT") end end ) -- Elsia: disallow resizing when locked.
	theFrame.DragBottomRight:SetScript("OnMouseUp", function() if this:GetParent().isResizing == true then this:GetParent():StopMovingOrSizing(); this:GetParent().isResizing = false; end end )

	theFrame.DragBottomLeft = CreateFrame("Frame", nil, theFrame)
	theFrame.DragBottomLeft:Show()
	theFrame.DragBottomLeft:SetFrameLevel( theFrame:GetFrameLevel() + 10)
	theFrame.DragBottomLeft:SetWidth(16)
	theFrame.DragBottomLeft:SetHeight(16)
	theFrame.DragBottomLeft:SetPoint("BOTTOMLEFT", theFrame, "BOTTOMLEFT", 0, 0)
	theFrame.DragBottomLeft:EnableMouse(true)
	theFrame.DragBottomLeft:SetScript("OnMouseDown", function() if ((( not this:GetParent().isLocked ) or ( this:GetParent().isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then this:GetParent().isResizing = true; this:GetParent():StartSizing("BOTTOMLEFT") end end ) -- Elsia: disallow resizing when locked.
	theFrame.DragBottomLeft:SetScript("OnMouseUp", function() if this:GetParent().isResizing == true then this:GetParent():StopMovingOrSizing(); this:GetParent().isResizing = false; end end )

	theFrame.RightButton=CreateFrame("Button",nil,theFrame)
	theFrame.RightButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up.blp")
	theFrame.RightButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down.blp")	
	theFrame.RightButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	theFrame.RightButton:SetWidth(16)
	theFrame.RightButton:SetHeight(18)
	-- theFrame.RightButton:SetPoint("LEFT",theFrame.LeftButton,"RIGHT",0,0)
	theFrame.RightButton:SetPoint("TOPRIGHT",theFrame,"TOPRIGHT",-38+16,-12)
	theFrame.RightButton:SetScript("OnClick",function() Recount:MainWindowNextMode() end)
	theFrame.RightButton:SetFrameLevel(theFrame.RightButton:GetFrameLevel()+1)

	theFrame.LeftButton=CreateFrame("Button",nil,theFrame)
	theFrame.LeftButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up.blp")
	theFrame.LeftButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down.blp")
	theFrame.LeftButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	theFrame.LeftButton:SetWidth(16)
	theFrame.LeftButton:SetHeight(18)
	theFrame.LeftButton:SetPoint("RIGHT",theFrame.RightButton,"LEFT",0,0)
	-- theFrame.LeftButton:SetPoint("TOPRIGHT",theFrame,"TOPRIGHT",-38,-12)
	theFrame.LeftButton:SetScript("OnClick",function() Recount:MainWindowPrevMode() end)
	theFrame.LeftButton:SetFrameLevel(theFrame.LeftButton:GetFrameLevel()+1)

	theFrame.ResetButton=CreateFrame("Button",nil,theFrame)
	theFrame.ResetButton:SetNormalTexture("Interface\\Addons\\Recount\\Textures\\icon-reset")
	theFrame.ResetButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	theFrame.ResetButton:SetWidth(16)
	theFrame.ResetButton:SetHeight(16)
	theFrame.ResetButton:SetPoint("RIGHT",theFrame.LeftButton,"LEFT",0,0)
	theFrame.ResetButton:SetScript("OnClick",function() Recount:ShowReset() end)
	theFrame.ResetButton:SetFrameLevel(theFrame.ResetButton:GetFrameLevel()+1)

	theFrame.FileButton=CreateFrame("Button",nil,theFrame)
	theFrame.FileButton:SetNormalTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Up.blp")
	theFrame.FileButton:SetPushedTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Down.blp")	
	theFrame.FileButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	theFrame.FileButton:SetWidth(16)
	theFrame.FileButton:SetHeight(16)
	theFrame.FileButton:SetPoint("RIGHT",theFrame.ResetButton,"LEFT",0,0)
	theFrame.FileButton:SetScript("OnClick",function() dewdrop:Open(this) end)
	theFrame.FileButton:SetFrameLevel(theFrame.FileButton:GetFrameLevel()+1)

	theFrame.ConfigButton=CreateFrame("Button",nil,theFrame)
	theFrame.ConfigButton:SetNormalTexture("Interface\\Addons\\Recount\\Textures\\icon-config")
	theFrame.ConfigButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	theFrame.ConfigButton:SetWidth(16)
	theFrame.ConfigButton:SetHeight(16)
	theFrame.ConfigButton:SetPoint("RIGHT",theFrame.FileButton,"LEFT",0,0)
	theFrame.ConfigButton:SetScript("OnClick",function() Recount:ShowConfig() end)
	theFrame.ConfigButton:SetFrameLevel(theFrame.ConfigButton:GetFrameLevel()+1)

	theFrame.ReportButton=CreateFrame("Button",nil,theFrame)
	theFrame.ReportButton:SetNormalTexture("Interface\\Buttons\\UI-GuildButton-MOTD-Up.blp")
	theFrame.ReportButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	theFrame.ReportButton:SetWidth(16)
	theFrame.ReportButton:SetHeight(16)
	theFrame.ReportButton:SetPoint("RIGHT",theFrame.ConfigButton,"LEFT",0,0)
	theFrame.ReportButton:SetScript("OnClick",function() Recount:ShowReport("Main",Recount.ReportData) end)
	theFrame.ReportButton:SetFrameLevel(theFrame.ReportButton:GetFrameLevel()+1)

	dewdrop:Register(theFrame.FileButton,'children',me.SetupDropdown)


	dewdrop:Register(theFrame.TitleClick,'children',me.CreateModeDropdown)

	Recount.MainWindow.Rows={}
	Recount.MainWindow.CurRows=0
	Recount.MainWindow.RowsCreated=0
	
	Recount.MainWindow.DispTableSorted={}
	Recount.MainWindow.DispTableLookup={}

	Recount:ResizeMainWindow()
	Recount:SetupMainWindowButtons()
	Events:ScheduleRepeatingEvent(Recount.RefreshMainWindow,1)

	if not Recount.db.char.MainWindowVis then
		theFrame:Hide()
	end
end

function Recount:SetupMainWindowButtons()
	for k, v in pairs(Recount.db.char.MainWindow.Buttons) do
		if v then
			Recount.MainWindow[k]:Show()
			Recount.MainWindow[k]:SetWidth(16)
		else
			--Have to use width of 1 since 0 is invalid but you can't tell the diff really
			Recount.MainWindow[k]:SetWidth(1)
			Recount.MainWindow[k]:Hide()
			
		end
	end
end


--Actual Data Functions
local function sortFunc(a, b)
	if a[2]>b[2] then
		return true
	elseif a[2]==b[2] then
		if a[1]<b[1] then
			return true
		end
	end
	return false
end

function Recount:LoadMainWindowData(DataTable)
	Recount.MainWindowData=DataTable
	Recount:SetMainWindowMode(1)
end

local ConvertName={
	OverallData="(Overall)",
	CurrentFightData="(Current)",
	LastFightData="(Last)",
}


function Recount:SetMainWindowMode(mode)
	Recount.MainWindowMode=mode
	Recount.DetailMode=1
	local data=Recount.MainWindowData[mode]
	Recount.MainWindow.Title:SetText(data[1])
	Recount.MainWindow.GetData=data[2]
	Recount.MainWindow.TooltipFunc=data[3]
	Recount.MainWindow.SpecialTotal=data[4]
	Recount.MainWindow.RealtimeSettings=data[5]
	Recount:FreeTableRecurseLimit(Recount.MainWindow.DispTableSorted,1)
	Recount:FreeTable(Recount.MainWindow.DispTableLookup)
	Recount.MainWindow.DispTableSorted=Recount:GetTable()
	Recount.MainWindow.DispTableLookup=Recount:GetTable()
	Recount:RefreshMainWindow()
end

function me:UpdateDetailData()
	if Recount.DetailWindow:IsVisible() and Recount.MainWindow.Selected then
		local _, Data=Recount.MainWindow:GetData(Recount.db.char.combatants[Recount.MainWindow.Selected])
		local mode=Recount.DetailMode

		if type(Data)=="table" then
			if type(Data[mode][2])~="function" then
				Recount:SetupDetailTitles(Recount.MainWindow.Selected,Data[mode][2],Data[mode][3])
				Recount:FillUpperDetailTable(Data[mode][1])
			else
				Data[mode][2](Recount,Recount.MainWindow.Selected,Data[mode][1])
			end
		end
	end
end

function Recount:MainWindowNextMode()
	local mode=Recount.MainWindowMode+1
	if mode>table.maxn(Recount.MainWindowData) then
		mode=1
	end
	Recount:SetMainWindowMode(mode)

	me:UpdateDetailData()
end

function Recount:MainWindowPrevMode()
	local mode=Recount.MainWindowMode-1
	if mode==0 then
		mode=table.maxn(Recount.MainWindowData)
	end
	Recount:SetMainWindowMode(mode)

	me:UpdateDetailData()
end

function Recount:DetailWindowNextMode()
	local _, Data=Recount.MainWindow:GetData(Recount.db.char.combatants[Recount.MainWindow.Selected])
	
	local mode=Recount.DetailMode+1
	if mode>table.maxn(Data) then
		mode=1
	end
	Recount.DetailMode=mode
	Recount.DetailWindow.Locked=false

	me:MainWindowSelectPlayer(Recount.MainWindow.Selected)
end

function Recount:DetailWindowPrevMode()
	local _, Data=Recount.MainWindow:GetData(Recount.db.char.combatants[Recount.MainWindow.Selected])
	local mode=Recount.DetailMode-1
	if mode==0 then
		mode=table.maxn(Data)
	end
	Recount.DetailMode=mode
	Recount.DetailWindow.Locked=false
	
	me:MainWindowSelectPlayer(Recount.MainWindow.Selected)
end

function me:MainWindowSelectPlayer(name)
	if IsShiftKeyDown() then
		me:ShowGraphWindow(name)
		return
	end
	
	if IsControlKeyDown() and IsAltKeyDown() then -- Elsia: Add delete combatant feature
		me:DeleteCombatant(name)
		return
	end
	
	local Settings=Recount.MainWindow.RealtimeSettings
	if IsControlKeyDown() and Settings then
		Recount:CreateRealtimeWindow(name,Settings[1],Settings[2])
		return
	end

	if IsAltKeyDown() then
		me:AddCombatantToGraph(name)
		return
	end

	me:ShowDetail(name)
end

function me:ShowGraphWindow(name)
	Recount:SetGraphData(name,Recount.db.char.combatants[name].TimeData,Recount.db.char.CombatTimes)
	Recount.GraphCompare=false
end

function me:ShowRealtime(name)
	local Settings=Recount.MainWindow.RealtimeSettings
	if Settings then
		Recount:CreateRealtimeWindow(name,Settings[1],Settings[2])
	end
end

function me:ShowDetail(name)
	local _, Data=Recount.MainWindow:GetData(Recount.db.char.combatants[name])

	if type(Data)=="table" then
		local mode=Recount.DetailMode

		if type(Data[mode][2])~="function" then
			Recount:SetupDetailTitles(name,Data[mode][2],Data[mode][3])
			Recount:FillUpperDetailTable(Data[mode][1])
			Recount:SelectUpperDetailTable(1)
		else
			Data[mode][2](Recount,name,Data[mode][1])
			Data[mode][3](Recount,1)
		end

		Recount:UpdateSummaryMode(name)
		Recount:SetWindowTop(Recount.DetailWindow)
	end

	Recount.MainWindow.Selected=name
end

function Recount:CheckShowPet(mob)
	if mob.enClass == "PET" then
		return Recount.db.char.Filters.Show[DetermineType(mob.Owner)]
	else
		return true
	end
end

function Recount:RefreshMainWindow()
	if not Recount.MainWindow.GetData or not Recount.MainWindow:IsShown() then
		return
	end
	local data=Recount.db.char.combatants
	local i, maxValue
	local dispTable=Recount.MainWindow.DispTableSorted
	local lookup=Recount.MainWindow.DispTableLookup
	local Total=0
	local Value,PerSec

	if type(Recount.MainWindowData[Recount.MainWindowMode][6])=="function" then
		Recount.MainWindow.Title:SetText(Recount.MainWindowData[Recount.MainWindowMode][6]())
	end

	for k,v in pairs(lookup) do
		if v[4].Fights[Recount.CurDataSet] then
			Value=Recount.MainWindow:GetData(v[4],1)
		else
			Value=0
		end
		if Value<=0 then
			lookup[k]=nil
					
			for k2,v2 in pairs(dispTable) do
				if v2[1]==v[4] then
					table.remove(dispTable,k2)
					break
				end
			end
		end

	end

	
	if type(data)=="table" then
		for k,v in pairs(data) do
			if Recount.db.char.Filters.Show[v.type] and not (v.type == "Pet" and not Recount.db.char.Filters.Show[Recount.db.char.combatants[v.Owner].type]) then -- Elsia: Added owner inheritance filtering for pets
				if v.Fights[Recount.CurDataSet] then
					Value,PerSec=Recount.MainWindow:GetData(v,1)
					
					
					if Value>0 then
						if v.type ~= "Pet" or not Recount.db.char.MergePets then -- Elsia: Only add to total if not merging pets.
							Total=Total+Value
						end
						
						if type(lookup[k])=="table" then
							lookup[k][1]=k
							lookup[k][2]=Value
							lookup[k][3]=Recount.db.profile.Colors.Class[v.enClass]
							lookup[k][4]=v
							lookup[k][5]=PerSec
						else
							lookup[k]={k,Value,Recount.Colors:GetColor("Class",v.enClass),v,PerSec}
							table.insert(dispTable,lookup[k])
						end
					elseif type(lookup[k])=="table" then
						for k2,v2 in ipairs(lookup) do
							if v2==lookup[k] then
								table.remove(lookup,k2)
								break
							end
						end
						
						for k2,v2 in pairs(dispTable) do
							if v2[1]==k then
								table.remove(dispTable,k2)
								break
							end
						end
					end
				end
			end
		end
	end
	
	if table.maxn(dispTable)>0 then
		table.sort(dispTable,sortFunc)
		MaxValue=dispTable[1][2]
	end

	local RowWidth=Recount.MainWindow:GetWidth()-4
	if table.getn(dispTable)>Recount.MainWindow.CurRows and Recount.db.char.MainWindow.ShowScrollbar == true then
		RowWidth=Recount.MainWindow:GetWidth()-23
	end
	
	if Recount.db.char.MainWindow.ShowScrollbar == true then
		Recount:ShowScrollbarElements("Recount_MainWindow_ScrollBar")
	end

		FauxScrollFrame_Update(Recount.MainWindow.ScrollBar, table.getn(dispTable), Recount.MainWindow.CurRows, 20)
	local offset = FauxScrollFrame_GetOffset(Recount.MainWindow.ScrollBar)

	if Recount.db.char.MainWindow.ShowScrollbar == false then
		Recount:HideScrollbarElements("Recount_MainWindow_ScrollBar")
	end
	
	if type(Recount.MainWindow.SpecialTotal)=="function" then
		Total=Recount.MainWindow:SpecialTotal()
	end

	for i=1,Recount.MainWindow.CurRows do
		local v=dispTable[i+offset]
		
		if v then
			local percent=100*v[2]/Total
			if v[5] then
				if type(v[5])=="number" then
					PerSec=string.format("%.1f, ",v[5])
				else
					PerSec=v[5]
				end
			else
				PerSec=""
			end
			me:SetBar(i,i+offset..". "..v[1],string.format("%.0f (%s%.1f%%)",v[2],PerSec,percent),100*v[2]/MaxValue,v[3],v[1],me.MainWindowSelectPlayer,v[4])
			me:FixRow(i)
			Recount.MainWindow.Rows[i].name=v[1]
		else
			Recount.MainWindow.Rows[i]:Hide()
		end

		Recount.MainWindow.Rows[i]:SetWidth(RowWidth)
	end

	me:UpdateDetailData()
end




--Pulldown for selecting data set
--[[local Graph_DataMenu = {
	a_overall = ,
	b_current = ,
	c_last = {
		text = "Last Fight",
		func = function() Recount.CurDataSet="LastFightData";me:UpdateDetailData();Recount.MainWindow.DispTableSorted={};Recount.MainWindow.DispTableLookup={};Recount.MainWindow.Title:SetText(Recount.MainWindowData[Recount.MainWindowMode][1].." "..ConvertName[Recount.CurDataSet]) end,
		checked = false,
	}
}]]

local ConvertDataSet2={}
ConvertDataSet2["OverallData"]="a_overall"
ConvertDataSet2["CurrentFightData"]="b_current"
ConvertDataSet2["LastFightData"]="c_last"


--Should add saved datasets here
function me:SetupDropdown()
	local Menu={}
	table.insert(Menu,
	{
		text = L["Overall Data"],
		selects="OverallData",
		func = function() Recount.CurDataSet="OverallData";me:UpdateDetailData();Recount.MainWindow.DispTableSorted={};Recount.MainWindow.DispTableLookup={};Recount.FightName=L["Overall Data"] end,
		checked = false,
	})
	table.insert(Menu,
	{
		text = L["Current Fight"],
		selects="CurrentFightData",
		func = function() Recount.CurDataSet="CurrentFightData";me:UpdateDetailData();Recount.MainWindow.DispTableSorted={};Recount.MainWindow.DispTableLookup={};Recount.FightName=L["Current Fight"] end,
		checked = false,
	})

	for k, v in pairs(Recount.db.char.FoughtWho) do
		table.insert(Menu,
		{
			text = L["Fight"].." "..k.." - "..v,
			selects = "Fight"..k,
			func = function() Recount.CurDataSet="Fight"..k;me:UpdateDetailData();Recount.MainWindow.DispTableSorted={};Recount.MainWindow.DispTableLookup={};Recount.FightName=v end,
			checked = false,
		})
	end


	for _,v in pairs(Menu) do
		if v.selects==Recount.CurDataSet then
			v.checked=true
		end
		v.selects=nil
	end

	dewdrop:FeedTable(Menu)
end

local Mode_Dropdown={}
function me:CreateModeDropdown()
	local Entry
--	if #Mode_Dropdown==0 then
		for k,v in pairs(Recount.MainWindowData) do
			Entry={}
			Entry.text=v[1]
			Entry.func=function() Recount:SetMainWindowMode(k) end
			if Recount.MainWindowMode==k then
				Entry.checked=true
			else
				Entry.checked=false
			end
			Mode_Dropdown[k]=Entry
		end
	--end
	dewdrop:FeedTable(Mode_Dropdown)
end

local ConvertDataSet={}
ConvertDataSet["OverallData"]="Overall Data"
ConvertDataSet["CurrentFightData"]="Current Fight"
ConvertDataSet["LastFightData"]="Last Fight"

function Recount:ReportData(amount,loc,loc2)
	local dataMode=Recount.MainWindowData[Recount.MainWindowMode]
	local data=Recount.db.char.combatants
	local i, maxValue
	local reportTable=Recount.MainWindow.DispTableSorted
	local lookup=Recount.MainWindow.DispTableLookup
	local Total=0
	local Value,PerSec


	
	if type(data)=="table" then
		for k,v in pairs(data) do
			if Recount.db.char.Filters.Show[v.type]  and not (v.type == "Pet" and not Recount.db.char.Filters.Show[Recount.db.char.combatants[v.Owner].type]) then -- Elsia: Added owner inheritance filtering for pets
				if v.Fights[Recount.CurDataSet] then
					Value,PerSec=dataMode[2](this,v,1)
					if Value>0 then
						if v.type ~= "Pet" or not Recount.db.char.MergePets then -- Elsia: Only add to total if not merging pets.
							Total=Total+Value
						end

						if type(lookup[k])=="table" then
							lookup[k][1]=k
							lookup[k][2]=Value
							lookup[k][5]=PerSec
						else
							lookup[k]={k,Value,Recount.Colors:GetColor("Class",v.enClass),v,PerSec}
							table.insert(reportTable,lookup[k])
						end
					end
				end
			end
		end
	end
	
	if table.maxn(reportTable)>0 then
		table.sort(reportTable,sortFunc)
		MaxValue=reportTable[1][2]
	end

	if type(dataMode[4])=="function" then
		Total=Recount.MainWindow:SpecialTotal()
	end
	
	if type(dataMode[6])=="function" then
		SendChatMessage("Recount - "..dataMode[6](),loc,nil,loc2)
	else
		if ConvertDataSet[Recount.CurDataSet] then
			SendChatMessage("Recount - "..dataMode[1].." for "..ConvertDataSet[Recount.CurDataSet],loc,nil,loc2)
		elseif Recount.FightName then -- Elsia: Cover nil error here.
			SendChatMessage("Recount - "..dataMode[1].." for "..Recount.FightName,loc,nil,loc2)		
		end
	end
	for i=1,amount do
		if reportTable[i] and reportTable[i][2]>0 then
			if reportTable[i][5] then
				if type(reportTable[i][5])=="number" then
					PerSec=string.format("%.1f, ",reportTable[i][5])
				else
					PerSec=reportTable[i][5]
				end
			else
				PerSec=""
			end
			SendChatMessage(i..". "..reportTable[i][1].."  "..(math.floor(10*reportTable[i][2])/10).." ("..PerSec..(math.floor(1000*reportTable[i][2]/Total)/10).."%)",loc,nil,loc2)
		end
	end
end


--Functions for graph data selecting
local GraphName={
	Damage="Damage",
	DamageTaken="Damage Taken",
	Healing="Healing",
	HealingTaken="Healing Taken",
	Overhealing="Overhealing",
	Threat="Threat",
}

function me:AddCombatantToGraph(name)
	local DataComparing=Recount.MainWindowData[Recount.MainWindowMode][7]
	if not DataComparing then
		return
	end

	local DataName=GraphName[DataComparing]

	

	if (not Recount.GraphCompare) or (not Recount.GraphWindow:IsShown()) or Recount.GraphCompareMode~=DataComparing then		
		Recount.GraphCompare=true
		Recount.GraphCompareMode=DataComparing

		if not Recount.GraphClass then
			Recount.GraphClass={}
		end

		for k, _ in pairs(Recount.GraphClass) do
			Recount.GraphClass[k]=nil
		end
		Recount.GraphClass[name.."'s "..DataName]=Recount.db.char.combatants[name].enClass

		Recount:SetGraphData(DataName.." Comparison",{[name.."'s "..DataName]=Recount.db.char.combatants[name].TimeData[DataComparing]},Recount.db.char.CombatTimes)
		return
	end
	
	Recount.GraphWindow.Data[name.."'s "..DataName]=Recount.db.char.combatants[name].TimeData[DataComparing]
	Recount.GraphClass[name.."'s "..DataName]=Recount.db.char.combatants[name].enClass
	Recount:SetGraphData(DataName.." Comparison",Recount.GraphWindow.Data,Recount.db.char.CombatTimes)	
end

function me:AddCombatantToGraphData(name)
	local DataComparing=Recount.MainWindowData[Recount.MainWindowMode][7]
	if not DataComparing then
		return
	end

	local DataName=GraphName[DataComparing]

	

	if (not Recount.GraphCompare) or (not Recount.GraphWindow:IsShown()) or Recount.GraphCompareMode~=DataComparing then		
		Recount.GraphCompare=true
		Recount.GraphCompareMode=DataComparing

		if not Recount.GraphClass then
			Recount.GraphClass={}
		end

		for k, _ in pairs(Recount.GraphClass) do
			Recount.GraphClass[k]=nil
		end
		Recount.GraphClass[name.."'s "..DataName]=Recount.db.char.combatants[name].enClass

		Recount.GraphWindow.Data={}
		Recount.GraphWindow.Data[name.."'s "..DataName]=Recount.db.char.combatants[name].TimeData[DataComparing]
		return
	end
	
	Recount.GraphWindow.Data[name.."'s "..DataName]=Recount.db.char.combatants[name].TimeData[DataComparing]
	Recount.GraphClass[name.."'s "..DataName]=Recount.db.char.combatants[name].enClass
		
end

function Recount:AddAllToGraph()
	local DataComparing=Recount.MainWindowData[Recount.MainWindowMode][7]
	if not DataComparing then
		return
	end
	local dispTable=Recount.MainWindow.DispTableSorted
	local DataName=GraphName[DataComparing]
	for _,v in pairs(dispTable) do
		me:AddCombatantToGraphData(v[1])
	end

	Recount:SetGraphData(DataName.." Comparison",Recount.GraphWindow.Data,Recount.db.char.CombatTimes)
end