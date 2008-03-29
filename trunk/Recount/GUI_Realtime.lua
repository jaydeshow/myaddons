local Graph = LibStub:GetLibrary("LibGraph-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Recount")
-- local Graph = AceLibrary("Graph-1.0")
local me={}
local FreeWindows={}
local WindowNum=1
local dewdrop = AceLibrary("Dewdrop-2.0")

function me:ResizeRealtimeWindow()
	self.Graph:SetWidth(self:GetWidth()-3)
	self.Graph:SetHeight(self:GetHeight()-33)
	self:UpdateTitle()
end

local Log2=math.log(2)


function me:DetermineGridSpacing()
	local MaxValue=self.Graph:GetMaxValue()
	local Spacing,Inbetween

	if MaxValue<25 then
		Spacing=-1
	else
		Spacing=math.log(MaxValue/100)/Log2
	end

	Inbetween=math.ceil(Spacing)-Spacing
	
	if Inbetween==0 then
		Inbetween=1
	end

	Spacing=25*math.pow(2,math.floor(Spacing))
	
	self.Graph:SetGridSpacing(1.0,Spacing)
	self.Graph:SetGridColorSecondary({0.5,0.5,0.5,0.5*Inbetween})
end

function me:UpdateTitle()
	self:DetermineGridSpacing()
	

	local Width,StartText, EndText
	Width=self:GetWidth()-32
	StartText=self.TitleText
	EndText=" - "..string.format("%.1f",self.Graph:GetValue(-0.05))

	self.Title:SetText(StartText..EndText)

	while self.Title:GetStringWidth()>Width do
		StartText=strsub(StartText,1,#StartText-1)
		self.Title:SetText(StartText.."..."..EndText)
	end
end

function me:SavePosition()
	local xOfs, yOfs = self:GetCenter()  -- Elsia: This is clean code straight from ckknight's pitbull
	local s = self:GetEffectiveScale()
	local uis = UIParent:GetScale()
	xOfs = xOfs*s - GetScreenWidth()*uis/2
	yOfs = yOfs*s - GetScreenHeight()*uis/2
	
	if self.id and Recount.db.char.RealtimeWindows[self.id] ~= nil then -- Elsia: Fixed bug for free'd realtime windows
		Recount.db.char.RealtimeWindows[self.id][4]=xOfs/uis
		Recount.db.char.RealtimeWindows[self.id][5]=yOfs/uis
		Recount.db.char.RealtimeWindows[self.id][6]=self:GetWidth()
		Recount.db.char.RealtimeWindows[self.id][7]=self:GetHeight()
		Recount.db.char.RealtimeWindows[self.id][8]=true
	end
end

function me:FreeWindow()
	Recount:UnregisterTracking(this.id,this.who,this.tracking)
	table.insert(FreeWindows,this)
	Recount:CancelScheduledEvent(this.id)
	Recount.db.char.RealtimeWindows[this.id][8]=false -- Elsia: set closed state
end

function me:SetRealtimeColor()
	self.Graph:SetBarColors(Recount.Colors:GetColor("Realtime",self.TitleText.." Bottom"),Recount.Colors:GetColor("Realtime",self.TitleText.." Top"))
end

local WhichWindow
local Menu={
	{
		text = L["Top Color"],
		colorFunc = function(r,g,b,a) Recount.Colors:EditColor("Realtime",WhichWindow.TitleText.." Top",WhichWindow) end, -- Elsia: Using EditColor allows to attach
		hasColorSwatch = true,
		r = 1,
		g = 1,
		b = 1,
		a = 1,
		hasOpacity = true,
		notCheckable=true
	},
	{
		text = L["Bottom Color"],
		colorFunc = function(r,g,b,a) Recount.Colors:EditColor("Realtime",WhichWindow.TitleText.." Bottom",WhichWindow) end,
		hasColorSwatch = true,
		r = 1,
		g = 1,
		b = 1,
		a = 1,
		hasOpacity = true,
		notCheckable=true
	},

}

function me:CreateDewdrop()
	local TopColor,BotColor
	TopColor=Recount.Colors:GetColor("Realtime",WhichWindow.TitleText.." Top")
	BotColor=Recount.Colors:GetColor("Realtime",WhichWindow.TitleText.." Bottom")

	Menu[1].r=TopColor.r
	Menu[1].g=TopColor.g
	Menu[1].b=TopColor.b
	Menu[1].opacity=TopColor.a

	Menu[2].r=BotColor.r
	Menu[2].g=BotColor.g
	Menu[2].b=BotColor.b
	Menu[2].opacity=BotColor.a

	dewdrop:FeedTable(Menu)
end

function me:CreateRealtimeWindow(who,tracking,ending) -- Elsia: This function creates a new window and stores it. To other ways, either override it's storage or use the other function
	local theFrame=Recount:CreateFrame(nil,"",232,200,nil, me.FreeWindow)

	theFrame:SetResizable(true)

	theFrame:SetMinResize(150,64)
	theFrame:SetMaxResize(400,432)	

	theFrame:SetScript("OnSizeChanged", function()
						if ( this.isResizing ) then
							me.ResizeRealtimeWindow(this) -- Elsia: Changed self to this here to make it work!
							
						end
					end)

	if string.sub(who,1,1)~="!" then
		theFrame.TitleText=who..ending
	else
		theFrame.TitleText=ending
	end

	theFrame.Title:SetText(theFrame.TitleText.." - 0.0")

	theFrame.DragBottomRight = CreateFrame("Frame", nil, theFrame)
	theFrame.DragBottomRight:Show()
	theFrame.DragBottomRight:SetFrameLevel( theFrame:GetFrameLevel() + 10)
	theFrame.DragBottomRight:SetWidth(16)
	theFrame.DragBottomRight:SetHeight(16)
	theFrame.DragBottomRight:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOMRIGHT", 0, 0)
	theFrame.DragBottomRight:EnableMouse(true)
	theFrame.DragBottomRight:SetScript("OnMouseDown", function() if ((( not this:GetParent().isLocked ) or ( this:GetParent().isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then this:GetParent().isResizing = true; this:GetParent():StartSizing("BOTTOMRIGHT") end end ) -- Elsia: Disallow resizing when locked
	theFrame.DragBottomRight:SetScript("OnMouseUp", function() if this:GetParent().isResizing == true then this:GetParent():StopMovingOrSizing(); this:GetParent().isResizing = false;this:GetParent():SavePosition() end end )


	theFrame.DragBottomLeft = CreateFrame("Frame", nil, theFrame)
	theFrame.DragBottomLeft:Show()
	theFrame.DragBottomLeft:SetFrameLevel( theFrame:GetFrameLevel() + 10)
	theFrame.DragBottomLeft:SetWidth(16)
	theFrame.DragBottomLeft:SetHeight(16)
	theFrame.DragBottomLeft:SetPoint("BOTTOMLEFT", theFrame, "BOTTOMLEFT", 0, 0)
	theFrame.DragBottomLeft:EnableMouse(true)
	theFrame.DragBottomLeft:SetScript("OnMouseDown", function() if ((( not this:GetParent().isLocked ) or ( this:GetParent().isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then this:GetParent().isResizing = true; this:GetParent():StartSizing("BOTTOMLEFT") end end ) -- Elsia: Disallow resizing when locked
	theFrame.DragBottomLeft:SetScript("OnMouseUp", function() if this:GetParent().isResizing == true then this:GetParent():StopMovingOrSizing(); this:GetParent().isResizing = false;this:GetParent():SavePosition() end end )

	local g=Graph:CreateGraphRealtime("Recount_Realtime_"..who.."_"..tracking,theFrame,"BOTTOM","BOTTOM",0,2,197,199)
	g:SetAutoScale(true)
	g:SetGridSpacing(1.0,100)
	g:SetYMax(120)
	g:SetXAxis(-10,-0)
	g:SetMode("EXP")
	g:SetDecay(0.5)
	g:SetFilterRadius(2)
	g:SetMinMaxY(100)
	g:SetBarColors(Recount.Colors:GetColor("Realtime",theFrame.TitleText.." Bottom"),Recount.Colors:GetColor("Realtime",theFrame.TitleText.." Top"))
	
	g:SetUpdateLimit(0.05)
	g:SetGridColorSecondary({0.5,0.5,0.5,0.25})
	g:SetYLabels(true,true)
	g:SetGridSecondaryMultiple(1,2)
	g.Window=theFrame

	g:EnableMouse(true)
	g:SetScript("OnMouseDown",function() WhichWindow=this.Window;dewdrop:Open(this) end)
	dewdrop:Register(g,'children',me.CreateDewdrop)

	
	theFrame.DetermineGridSpacing=me.DetermineGridSpacing
	theFrame.Graph=g
	
	theFrame.id = "Realtime_"..who.."_"..tracking
	theFrame.who=who
	theFrame.ending=ending
	theFrame.tracking=tracking
	theFrame.SavePosition=me.SavePosition
	theFrame.ResizeRealtimeWindow=me.ResizeRealtimeWindow
	theFrame.UpdateTitle=me.UpdateTitle

	Recount.db.char.RealtimeWindows[theFrame.id]={who,tracking,ending}
	theFrame:StartMoving()
	theFrame:StopMovingOrSizing()
	theFrame:UpdateTitle()
	theFrame:SavePosition()

	Recount:RegisterTracking(theFrame.id,who,tracking,g.AddTimeData,g)

	--Need to add it to our window ordering system
	Recount:AddWindow(theFrame)

	Recount:ScheduleRepeatingEvent(theFrame.id,me.UpdateTitle,0.1,theFrame)

	Recount.Colors:RegisterFunction("Realtime",theFrame.TitleText.." Top",me.SetRealtimeColor,theFrame)
	Recount.Colors:RegisterFunction("Realtime",theFrame.TitleText.." Bottom",me.SetRealtimeColor,theFrame)

	return theFrame
end

function Recount:CreateRealtimeWindow(who,tracking,ending)

	local curID = "Realtime_"..who.."_"..tracking

	if Recount.db.char.RealtimeWindows and Recount.db.char.RealtimeWindows[curID] and Recount.db.char.RealtimeWindows[curID][8] == true then -- Don't allow opening twice
		return
	end

	local Window=table.maxn(FreeWindows)
	if Window>0 then
		if string.sub(who,1,1)~="!" then
			FreeWindows[Window].TitleText=who..ending
		else
			FreeWindows[Window].TitleText=ending
		end
		FreeWindows[Window].Title:SetText(FreeWindows[Window].TitleText.." - 0.0")
		FreeWindows[Window].id=curID
		FreeWindows[Window].who=who
		FreeWindows[Window].tracking=tracking

		local f = FreeWindows[Window]
		if Recount.db.char.RealtimeWindows and Recount.db.char.RealtimeWindows[FreeWindows[Window].id] then
			Recount:RestoreRealtimeWindowPosition(f,Recount:RealtimeWindowPositionFromID(FreeWindows[Window].id))
		else
			f:SetWidth(200)
			f:SetHeight(232)
			f:ClearAllPoints()
			f:SetPoint("CENTER",UIParent)
		end
		me.ResizeRealtimeWindow(FreeWindows[Window])

		FreeWindows[Window]:UpdateTitle()
		Recount:RegisterTracking(FreeWindows[Window].id,who,tracking,FreeWindows[Window].Graph.AddTimeData,FreeWindows[Window].Graph)
		Recount:ScheduleRepeatingEvent(FreeWindows[Window].id,me.UpdateTitle,0.1,FreeWindows[Window])
		FreeWindows[Window]:Show()

		Recount.Colors:UnregisterItem(FreeWindows[Window])
		Recount.Colors:RegisterFunction("Realtime",FreeWindows[Window].TitleText.." Top",me.SetRealtimeColor,FreeWindows[Window])
		Recount.Colors:RegisterFunction("Realtime",FreeWindows[Window].TitleText.." Bottom",me.SetRealtimeColor,FreeWindows[Window])

		Recount.db.char.RealtimeWindows[FreeWindows[Window].id]={who,tracking,ending}
		FreeWindows[Window]:SavePosition()
			
		table.remove(FreeWindows,Window)
	else

		if Recount.db.char.RealtimeWindows and Recount.db.char.RealtimeWindows[curID] then
			local x,y,width,height = Recount:RealtimeWindowPositionFromID(curID)
			f=me:CreateRealtimeWindow(who,tracking,ending)
			Recount:RestoreRealtimeWindowPosition(f,x,y,width,height)
			f:ResizeRealtimeWindow()
			f:SavePosition()
		else
			f=me:CreateRealtimeWindow(who,tracking,ending)
		end
	end
end

function Recount:RealtimeWindowPositionFromID(id)
	local x,y,width,height
	if Recount.db.char.RealtimeWindows and Recount.db.char.RealtimeWindows[id] then
		x = Recount.db.char.RealtimeWindows[id][4]
		y = Recount.db.char.RealtimeWindows[id][5]
		width = Recount.db.char.RealtimeWindows[id][6]
		height = Recount.db.char.RealtimeWindows[id][7]
	end
	return x,y,width,height
end

function Recount:RestoreRealtimeWindowPosition(f,x, y, width, height)
	local s = f:GetEffectiveScale() -- Elsia: Fixed position code, with inspiration from ckknight's handing in pitbull
	local uis = UIParent:GetScale()
	f:SetPoint("CENTER", UIParent, "CENTER", x*uis/s, y*uis/s)
	f:SetWidth(width)
	f:SetHeight(height)
	f:ResizeRealtimeWindow()
	f:SavePosition()
end

function Recount:CreateRealtimeWindowSized(who,tracking,ending, x, y, width, height)
	local f=me:CreateRealtimeWindow(who,tracking,ending)
	Recount:RestoreRealtimeWindowPosition(f,x,y,width,height)
end
