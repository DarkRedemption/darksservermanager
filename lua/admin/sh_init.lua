--Initializes a GUI for admins to configure DSM and analyze data.
DSM.Admin = {}
DSM.Admin.Gui = {}

AddCSLuaFile("gui/cl_adminwindow.lua")
include("gui/cl_adminwindow.lua")

concommand.Add("dsm_admin", function() DSM.Admin.Gui.AdminWindow:drawAdminWindow() end)
