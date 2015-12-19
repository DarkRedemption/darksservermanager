DSM.Config = {}
DSM.Config.CallMods = {}
--Stores the last time a user used !callmods
DSM.Config.CallMods.UserLastCallTable = {}
--Stores the Unix Timestamp indicating the last time the 
DSM.Config.CallMods.ServerLastCall = 0
--Players in these groups can call for a mod.
DSM.Config.CallMods.AuthorizedUserGroups = {"Regular", "Trusted", "Moderator", "admin", "superadmin"}

--Serverwide cooldown, in seconds, for calling a mod. Default: 15 Minutes (900 Seconds)
DSM.Config.CallMods.ServerCooldown = 900

--Cooldown, in seconds, for a specific player to call a mod. Default: 60 Minutes (3600 Seconds)
DSM.Config.CallMods.UserCooldown = 3600

--List of email addresses to send to. All of your mod and admin emails go here.
DSM.Config.CallMods.Emails = {"email@goes.here", "anotheremails@goes.here"}

--List of SteamIds of people you generally like enough to keep on the server but are abusing the !callmods command.
DSM.Config.CallMods.Blacklist = {"STEAM_0:x:xxxxxx", "STEAM_0:x:xxxxxx"}

--The Url that sends the email.
DSM.Config.CallMods.MailerUrl = "http://localhost/modmailer/mail.php"

--Shared Secret (essentially a password) for the mail.php file.
DSM.Config.CallMods.SharedSecret = "somehugerandompasswordthinggoeshere"