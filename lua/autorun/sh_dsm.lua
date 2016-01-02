DSM = {}
DSM.Config = {}
DSM.Database = {}
DSM.Gui = {}
DSM.Hashing = {}
DSM.Version = "0.3.0"

if SERVER then
  AddCSLuaFile("config/sh_moduleconfig.lua")
  AddCSLuaFile("shared/timeradditions.lua")
  AddCSLuaFile("shared/gui/cl_centerpanel.lua")
  AddCSLuaFile("affiliatedservers/sh_init.lua")
  AddCSLuaFile("callmods/sh_init.lua")
  AddCSLuaFile("admin/sh_init.lua")
  include("config/sh_moduleconfig.lua")
  include("shared/database/sv_table.lua")
  include("shared/sha1.lua")
  if (DSM.Config.EnableTagger) then
    include("tagger/sv_init.lua")
  end
end

if CLIENT then
  include("config/sh_moduleconfig.lua")
  include("shared/timeradditions.lua")
  include("shared/gui/cl_centerpanel.lua")
  include("admin/sh_init.lua")
  DSM.Timer.CreateDelayedTimer("DSM_Main_PSA", 60, 900, 0, function()
    chat.AddText("This server is running Dark's Server Manager v" .. DSM.Version)
    chat.AddText("https://github.com/DarkRedemption/darksservermanager")
  end)
end

include("affiliatedservers/sh_init.lua")
include("callmods/sh_init.lua")
include("admin/sh_init.lua")

    
