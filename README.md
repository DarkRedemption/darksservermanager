# Dark's Server Manager

An addon for Garry's Mod for managing multiple servers.

## Features:
**!callmods <message>** - Email all mods and admins that have provided an email address.

**!servers** - Display a list of affiliated servers to allow users to easily move between servers on your gaming network.

**Command Replication (not yet implemented)** - Replay ulx ban, ulx unban, and awarn_warn messages across your servers.

## Dependencies:

Bromsock (https://github.com/Bromvlieg/gm_bromsock/)

A PHP server with PHPMailer installed.
PHPMailer link: https://www.google.com/search?q=phpmailer&ie=utf-8&oe=utf-8

A gmail account (for now) which has less secure apps enabled, since setting up OAUTH is a massive annonyance with PHPMailer and Gmail at this time. https://support.google.com/accounts/answer/6010255?hl=en

## Installation

### File Placement Instructions
1. Put all the lua code in your addons directory. It should look like /addons/darksservermanager/lua.
2. Get the Bromsock .dll and place it in your server's garrysmod/lua/bin directory. (Create the bin directory if it doesn't exist.)
3. Get phpmailer. If you can't php commands directly on your server, run the composer file on your local host and upload the updated phpmailer directory to your server.
4. Put the modmailer code and phpmailer on your website. The directory structure should look something like /site/modmailer, /site/phpmailer. You can put them somewhere else, but you'll have to change mail.php to point at phpmailer's different location. 
5. If you didn't run the composer file on your localhost, do step 2 directly on your server now.
6. In modmailer/config, password protect the directory however your server allows so no one can see it. This often means putting a .htaccess and .htpasswd file in the config directory.

### Affiliated Servers
1. Open the configuration file, found in affiliatedservers/config.
2. Edit the example code to point at your server and describe it. Note that the "ip" parameter can also be a url that points at your server's ip.
3. Copy the configuration code and rename the copied variables for every server you have until all your servers are listed.

### Modmailer/callmods
1. Open the callmods/config/sv_callconfig.lua file.
2. Add any user groups you want to give permissions to in the AuthorizedUserGroups section. Placing the "user" rank, or whatever rank your server happens to give randoms here, is NOT recommended.
3. Add the emails of all mods/admins you wish to have emailed by !callmods.
4. Add any SteamIDs in the blacklist you wish to ban.
5. Point at your website's modmailer/mail.php file under the MailerUrl section.
6. Change the shared secret to some random password.
7. Go to your website's file manager and open your modmailer/config/config.ini file.
8. Change the shared secret to the same value as you put into your callmods/config/sv_callconfig.lua file.
9. Change the username and password to the gmail account you wish to use.
10. Change the "from" setting so it indicates the emails are from your gaming network.
11. Ensure your gmail account allows less secure apps. See the dependencies section of this readme for more on that.
12. Test with !callmods (message)
