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
DSM.Config.CallMods.Emails = {"mod1email@goes.here", "mod2email@goes.here", "mod3email@goes.here"}

--Array of times which are acceptable for each mod and admin to receive emails for each day of the week, hours are in 24 hour format and based out of the server's clock
---------------------------------Sunday--------Monday---------------Tuesday-------------Wednesday--------------Thursday-----------Friday------------Saturday
DSM.Config.CallMods.Times = {	{"00-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "00-24"}, --Mod 1 hours
								{"00-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "00-24"}, --Mod 2 hours
								{"00-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "08-12;13-18;19-24", "00-24"}} --Mod 3 hours

--List of SteamIds of people you generally like enough to keep on the server but are abusing the !callmods command.
DSM.Config.CallMods.Blacklist = {"STEAM_0:x:xxxxxx", "STEAM_0:x:xxxxxx"}

--The Url that sends the email.
DSM.Config.CallMods.MailerUrl = "http://localhost/modmailer/mail.php"

--Shared Secret (essentially a password) for the mail.php file.
DSM.Config.CallMods.SharedSecret = "somehugerandompasswordthinggoeshere"