DSM = {}
DSM.Gui = {}
DSM.Version = "0.1"
AddCSLuaFile("gui/cl_mainwindow.lua")

local function checkForChatCommand(ply, chatMessage)
  if (chatMessage == "!servers") then
      ply:ConCommand("dsm")
      return ""
  else
    return chatMessage
  end
end

if SERVER then
  AddCSLuaFile("gui/cl_mainwindow.lua")
  include("config/sv_callconfig.lua")
  --include("net/sv_getserverinfo.lua")
  include("net/sv_sendmail.lua")
  
  timer.Create("DSMPSA", 1800, 0, function()
    PrintMessage(HUD_PRINTTALK, "This server is running Dark's Server Manager v" .. DSM.Version .. ", providing:")
    PrintMessage(HUD_PRINTTALK, "!callmods - Summon mods via email if none are on to punish rulebreakers.")
  end)

end

if CLIENT then
  include("gui/cl_mainwindow.lua")
  concommand.Add("dsm", function() DSM.Gui.MainWindow.drawMainWindow() end)
end

hook.Add("PlayerSay", "Catch when someone is looking for the server list", function(ply, text, isTeamChat)
    return checkForChatCommand(ply, text) 
  end)
    
