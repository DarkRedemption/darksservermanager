# Dark's Server Manager

An addon for Garry's Mod for managing multiple servers, as well as calling mods to those servers.

## Dependencies:

Bromsock (https://github.com/Bromvlieg/gm_bromsock/)

A PHP server with PHPMailer installed.
PHPMailer link: https://www.google.com/search?q=phpmailer&ie=utf-8&oe=utf-8

There's not much to the PHP code, so if you need to, it shouldn't be too hard to replace with an equivalent if your server is not using PHP and you know how to code.

## Installation

1. Place the Bromsock .dll that your server needs in its garrysmod/lua/bin directory. (Create the bin directory if it doesn't exist.)
2. Put the lua directory in your Garry's Mod server's addon folder.
3. Configure the sv_callconfig.lua file.
4. Place the modmailer folder on your PHP server.
5. Install PHPMailer on your server.
6. Check the modmailer mail.php file, be sure it's pointing at your PHPMailer directory, and configure the email settings.
7. Test with !callmods (message)
