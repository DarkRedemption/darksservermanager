local MainWindow = {}

local function makeBasePanel()
  local DermaPanel = vgui.Create("DFrame") -- Creates the frame itself
   -- Position on the players screen
  DermaPanel:SetSize(800, 300) -- Size of the frame
  DSM.Gui.centerPanel(DermaPanel)
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
  list:SetSize(550, 200)
  list:SetMultiSelect(false)
  local idColumn = list:AddColumn("Id")
  local nameColumn = list:AddColumn("Server Name")
  local gameColumn = list:AddColumn("Game")
  idColumn:SetWidth(25)
  nameColumn:SetWidth(450)
  gameColumn:SetWidth(75)
  return list
end

local function makeServerDescriptionText(panel)
  local richtext = vgui.Create( "RichText", panel )
  richtext:Dock(RIGHT)
  richtext:SetWidth(100)
  richtext:DockMargin(0, 22, 15, 46)
  richtext:SetSize(200, 200)
  
  function richtext:PerformLayout()
    self:SetBGColor(Color(255, 255, 255))
  end
  return richtext
end

local function makeConnectButton(panel)
  local button = vgui.Create("DButton")
  button:SetParent(panel)
  button:SetText( "Connect to Server" )
  button:SetPos(25, 250)
  button:SetSize(150, 25)
  button.DoClick = function ()
   print("Unimplemented.")
  end
  return button
end

local function onClickLine(line, isSelected, serverList, serverDescriptionRichText, connectButton)
   serverDescriptionRichText:SetText("")
    if (isSelected) then
      local id = line:GetValue(1)
      --The fact that I can't just get something at a specific index is insane
      for key, server in ipairs(serverList) do
        if (key == id) then
          server:renderDescription(serverDescriptionRichText)
          return server
        end
      end
    end
    return nil
end

local function onClickConnectButton(selectedServer, connectButton)
  net.Start("DSM_ConnectToServer")
  net.WriteString(selectedServer.name)
  net.SendToServer()
  --Give the net stuff a little time to send
  timer.Simple(0.3, function()
    LocalPlayer():ConCommand("connect " .. selectedServer.ip .. ":" .. tostring(selectedServer.port))
    end)
end

local function getServerList(listView, serverDescriptionRichText, connectButton)
  listView:Clear()
  local serverList = {}
  net.Start("DSM_GetServerList")
  net.SendToServer()
  net.Receive("DSM_GetServerList", function(len, _)
   local count = net.ReadInt(8)
   for i=1,count,1 do
     local server = DSM.AffiliatedServers.ServerListing.deserialize()
     listView:AddLine(i, server.name, server.gameType)
     table.insert(serverList, server)
    end
  end
)

  connectButton:SetDisabled(true)
  
  listView.OnClickLine = function(parent, line, isSelected)
    local selectedServer = onClickLine(line, isSelected, serverList, serverDescriptionRichText, connectButton)
    if (selectedServer == nil) then
      connectButton:SetDisabled(true)
    else
      connectButton:SetEnabled(true)
      function connectButton:DoClick()
        onClickConnectButton(selectedServer, connectButton)
      end
    end
  end
  
  return serverList
end

function MainWindow:drawMainWindow()
  local mainWindow = makeBasePanel()
  local listView = makeServerList(mainWindow)
  local serverDescriptionRichText = makeServerDescriptionText(mainWindow)
  local connectButton = makeConnectButton(mainWindow)
  getServerList(listView, serverDescriptionRichText, connectButton)
  mainWindow:MakePopup()
end

DSM.AffiliatedServers.Gui.MainWindow = MainWindow