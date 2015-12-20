DSM = {}
DSM.Database = {}
DSM.Gui = {}
DSM.Hashing = {}
DSM.Version = "0.2.3"

if SERVER then
  AddCSLuaFile("shared/timeradditions.lua")
  AddCSLuaFile("affiliatedservers/sh_init.lua")
  AddCSLuaFile("callmods/sh_init.lua")
  include("shared/database/sv_table.lua")
  include("shared/sha1.lua")
end

if CLIENT then
  include("shared/timeradditions.lua")
  DSM.Timer.CreateDelayedTimer("DSM_Main_PSA", 60, 900, 0, function()
    chat.AddText("This server is running Dark's Server Manager v" .. DSM.Version)
    chat.AddText("https://github.com/DarkRedemption/darksservermanager")
  end)
end

include("affiliatedservers/sh_init.lua")
include("callmods/sh_init.lua")


    
