local MainWindow = {}

local function makeBasePanel()
  local DermaPanel = vgui.Create("DFrame") -- Creates the frame itself
  DermaPanel:SetPos( 50,50 ) -- Position on the players screen
  DermaPanel:SetSize(800, 600) -- Size of the frame
  DermaPanel:SetTitle("Affiliated Servers") -- Title of the frame
  DermaPanel:SetVisible(true)
  DermaPanel:SetDraggable(true) -- Draggable by mouse?
  DermaPanel:ShowCloseButton(true) -- Show the close button?
  return DermaPanel
end

local function makeServerList(panel) 
  local list = vgui.Create("DListView")
  list:SetParent(panel)
  list:SetPos(25, 50)
  list:SetSize(550, 500)
  list:SetMultiSelect(false)
  local nameColumn = list:AddColumn("Server Name")
  local gameColumn = list:AddColumn("Game")
  local mapColumn = list:AddColumn("Map")
  local playersColumn = list:AddColumn("Players")
  nameColumn:SetWidth(300)
  gameColumn:SetWidth(75)
  mapColumn:SetWidth(100)
  playersColumn:SetWidth(75)
end

local function makeServerDescriptionText(panel)
  local richtext = vgui.Create( "RichText", panel )
  richtext:Dock(RIGHT)
  richtext:SetWidth(100)
  richtext:DockMargin(0, 22, 15, 46)
  richtext:SetSize(200, 500)
  -- Text segment #1 (grayish color)
  richtext:InsertColorChange(192, 192, 192, 255)
  richtext:AppendText("This \nRichText \nis \n")

  -- Text segment #2 (light yellow)
  richtext:InsertColorChange(255, 255, 224, 255)
  richtext:AppendText("AWESOME\n\n")

  -- Text segment #3 (red ESRB notice localized string)
  richtext:InsertColorChange(255, 64, 64, 255)
  richtext:AppendText("#ServerBrowser_ESRBNotice")
  
  function richtext:PerformLayout()
    self:SetBGColor(Color(255, 255, 255))
  end
end

local function makeConnectButton(panel)
  local button = vgui.Create("DButton")
  button:SetParent(panel)
  button:SetText( "Connect to Server" )
  button:SetPos(25, 550)
  button:SetSize(150, 25)
  button.DoClick = function ()
   print("Unimplemented.")
  end
end

function MainWindow:drawMainWindow()
  local mainWindow = makeBasePanel()
  makeServerList(mainWindow)
  makeServerDescriptionText(mainWindow)
  makeConnectButton(mainWindow)
  mainWindow:MakePopup()
end

DSM.Gui.MainWindow = MainWindow