if SERVER then
  AddCSLuaFile("net/cl_sendmail.lua")
  include("config/sv_callconfig.lua")
  include("net/sv_sendmail.lua")
 end

if CLIENT then
  include("net/cl_sendmail.lua")
end