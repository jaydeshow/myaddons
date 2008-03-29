--[[
	MapNotes: Adds a note system to the WorldMap and other AddOns that use the Plugins facility provided

	See the README file for more information.
]]



MapNotesDropDown = {}
MapNotesDropDown.registeredButtons = 0
local id = 0;


function MapNotes_RegisterDropDownButton(name, toggle, submenu)
	MapNotesDropDown.registeredButtons = MapNotesDropDown.registeredButtons+1
	MapNotesDropDownList:SetHeight(16 * MapNotesDropDown.registeredButtons + 28)
	MapNotesDropDown[MapNotesDropDown.registeredButtons] = {}
	MapNotesDropDown[MapNotesDropDown.registeredButtons].toggle = toggle
	if submenu then
		MapNotesDropDown[MapNotesDropDown.registeredButtons].submenu = submenu
		getglobal("MapNotesDropDown"..MapNotesDropDown.registeredButtons.."ExpandArrow"):Show()
		getglobal(submenu):SetPoint("TOPLEFT", "MapNotesDropDown"..MapNotesDropDown.registeredButtons, "TOPRIGHT", 3, 8)
	else
		getglobal("MapNotesDropDown"..MapNotesDropDown.registeredButtons.."ExpandArrow"):Hide()
	end
	getglobal("MapNotesDropDown"..MapNotesDropDown.registeredButtons):Show()
end



function MapNotes_CloseDropDownMenus(level)
	MapNotesDropDownList:Hide()
	for i=1, MapNotesDropDown.registeredButtons, 1 do
	  if MapNotesDropDown[i].submenu then
			getglobal(MapNotesDropDown[i].submenu):Hide()
		end
	end
end



function MapNotes_DropDownOnClick(m_id)
	m_id = tonumber(m_id);					-- Hacky way to avoid the DropDown menu hooks
								-- but then, they were always OVER-KILL for 1
	if ( m_id == 1 ) then					-- single menu option !
		if ( MapNotes_Options.shownotes ) then
			MapNotes_Options.shownotes = false;
			getglobal("MapNotesDropDown"..m_id.."Check"):Hide()
		else
			MapNotes_Options.shownotes = true;
			getglobal("MapNotesDropDown"..m_id.."Check"):Show()
		end
	end

	MapNotes_WorldMapButton_OnUpdate();
end



function MapNotes_DropDownToggleSubMenu(m_id)
	m_id = tonumber(m_id)
	if (getglobal(MapNotesDropDown[m_id].submenu):IsVisible()) then
		getglobal(MapNotesDropDown[m_id].submenu):Hide()
	else
		getglobal(MapNotesDropDown[m_id].submenu):Show()
	end
end



function MapNotes_DropDownCloseSubMenuExcept(m_id)
	m_id = tonumber(m_id)
	for i=1, MapNotesDropDown.registeredButtons, 1 do
		if (MapNotesDropDown[i].submenu and i ~= m_id) then
			getglobal(MapNotesDropDown[i].submenu):Hide()
		end
	end
end



function MapNotes_DropDownExpandArrowOnEnter(m_id)
	m_id = tonumber(m_id)
	for i=1, MapNotesDropDown.registeredButtons, 1 do
		if (i == m_id) then
			getglobal(MapNotesDropDown[m_id].submenu):Show()
		elseif (MapNotesDropDown[i].submenu and i ~= m_id) then
			getglobal(MapNotesDropDown[i].submenu):Hide()
		end
	end
end
-- WorldMapMagnifyingGlassButton
local oriF = WorldMapFrameAreaLabel.Show;
WorldMapMagnifyingGlassButton.oriShow = WorldMapMagnifyingGlassButton.Show;
local function tmpF()
	-- Do nothing at all
end

function MapNotes_ToggleDropDownMenu()
	if ( ( MapNotesDropDownList:IsVisible() ) ) then
		MapNotes_CloseDropDownMenus()
		WorldMapFrameAreaLabel.Show = oriF;
		WorldMapFrameAreaLabel:Show();
		WorldMapMagnifyingGlassButton.Show = WorldMapMagnifyingGlassButton.oriShow
		WorldMapMagnifyingGlassButton:Show();
	else
		CloseDropDownMenus()
		MapNotesDropDownList:Show()
		WorldMapFrameAreaLabel.Show = tmpF;
		WorldMapFrameAreaLabel:Hide();
		WorldMapMagnifyingGlassButton.Show = tmpF;
		WorldMapMagnifyingGlassButton:Hide();
	end
end

function MapNotes_ToggleClosedDropDownMenus(boo)
	MN_toggleClosed = boo;
end

function MapNotes_AsynchronousClosing()
	if ( MN_toggleClosed ) then
		if ( MapNotesDropDownList:IsVisible() ) then
			MapNotes_ToggleDropDownMenu();
			MN_toggleClosed = nil;
		end
	end
end