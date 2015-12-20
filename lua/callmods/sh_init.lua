if SERVER then
  AddCSLuaFile("net/cl_sendmail.lua")
  include("config/sv_callconfig.lua")
  include("net/sv_sendmail.lua")
 end

if CLIENT then
  include("net/cl_sendmail.lua")
  
  DSM.Timer.CreateDelayedTimer("DSM_CallMods_PSA", 120, 900, 0, function()
    local red = Color(255, 0, 0, 255)
    local yellow = Color(255, 255, 0, 255)
    chat.AddText(red, "Got some randoms online that are RDMing, but there's no mods around?")
    chat.AddText(red, "Type ", yellow, "!callmods <message>", Color(255, 0, 0, 255), " to send a quick email telling the mods to get on.")
  end)
end