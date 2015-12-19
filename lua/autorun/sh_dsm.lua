DSM = {}
DSM.Database = {}
DSM.Gui = {}
DSM.Hashing = {}
DSM.Version = "0.2.2"

if SERVER then
  AddCSLuaFile("affiliatedservers/sh_init.lua")
  AddCSLuaFile("callmods/sh_init.lua")
  include("shared/database/sv_table.lua")
  include("shared/sha1.lua")
  timer.Create("DSMPSA", 900, 0, function()
    PrintMessage(HUD_PRINTTALK, "This server is running Dark's Server Manager v" .. DSM.Version .. ", providing:")
    PrintMessage(HUD_PRINTTALK, "!callmods - Summon mods via email if none are on to punish rulebreakers.")
    PrintMessage(HUD_PRINTTALK, "!servers - View and connect to affiliated servers.")
  end)
end

include("affiliatedservers/sh_init.lua")
include("callmods/sh_init.lua")


    
