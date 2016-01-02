local adminWindow = {}

local function makeBaseFrame()
  local frame = vgui.Create("DFrame")
  frame:SetSize(800, 300)
  DSM.Gui.centerPanel(frame)
  frame:SetTitle("Dark's Server Manager - Admin Controls")
  frame:SetVisible(true)
  frame:SetDraggable(true)
  frame:ShowCloseButton(true) 
  return frame
end

local function makePropertySheet(frame)
  local sheet = vgui.Create("DPropertySheet", frame)
  sheet:Dock(FILL)
  return sheet
end

local function addServersTab(sheet)
  local serversTab = vgui.Create("DPanel", sheet)
  --Oddly, the paint function makes the backgrounder whiter than SetBackgroundColor. Sloppy programming.
  serversTab.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 255, 255 ) ) end
  sheet:AddSheet("AffiliatedServers", serversTab, nil)
end

function adminWindow:drawAdminWindow()
  local frame = makeBaseFrame()
  local sheet = makePropertySheet(frame)
  addServersTab(sheet)
  frame:MakePopup()
end

DSM.Admin.Gui.AdminWindow = adminWindow