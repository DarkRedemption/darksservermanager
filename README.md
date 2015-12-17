# darksservermanager

An addon for Garry's Mod for managing multiple servers, as well as calling mods to those servers.

Dependencies:

Bromsock (https://github.com/Bromvlieg/gm_bromsock/)

A PHP server with PHPMailer installed, or some other server that allows for parameters to be passed in via POST.
PHPMailer link: https://www.google.com/search?q=phpmailer&ie=utf-8&oe=utf-8

To install:

1. Place the Bromsock .dll that your server needs in its garrysmod/lua/bin directory. (Create the bin directory if it doesn't exist.)
2. Put the lua directory in your Garry's Mod server's addon folder.
3. Configure the sv_callconfig.lua file.
4. Place the modmailer folder on your PHP server.
5. Install PHPMailer if using php. Install a mailing plugin for whatever type of server you are using if you aren't using php.
6. Check the modmailer mail.php file, be sure it's pointing at your PHPMailer directory, and configure the email settings. Alternatively, if not using PHP, use mail.php as a base to create an equivalent file.
7. Test with !callmods (message)
