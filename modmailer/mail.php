<?php
require '../PHPMailer-master/PHPMailerAutoload.php';

$emailaccount = "email@address.here";
$emailpassword = "passwordhere";
$emailfrom = "Your server name or network or whatever goes here.";

if (is_null($_POST["emails"])) {
	echo 'Error: Emails not found.';
} else if (is_null($_POST["playername"])) {
	echo 'Error: Player name that called for mods not found.';
} else if (is_null($_POST["message"])) {
	echo 'Error: A message is required.';
} else if (is_null($_POST["servername"])) {
	echo 'Error: A server name is required.';
} else if ($_SERVER['REMOTE_ADDR'] != "127.0.0.1" && $_SERVER['REMOTE_ADDR'] != "localhost") {
	echo 'This page can only be used by the server itself. Go away.';
} else {
	echo 'Now attempting to send email from ' . $_POST["playername"] . ' to  ' . htmlspecialchars($_POST["emails"]). '!';
	$emails = explode(",", str_replace('"', "", $_POST["emails"]));
	$playername = str_replace('"', "", $_POST["playername"]);
	$message = str_replace('"', "", $_POST["message"]);
	$servername = str_replace('"', "", $_POST["servername"]);
	
	/**
	 * This example shows settings to use when sending via Google's Gmail servers.
	 */
	//SMTP needs accurate times, and the PHP time zone MUST be set
	//This should be done in your php.ini, but this is how to do it if you don't have access to that
	date_default_timezone_set('Etc/UTC');
	//Create a new PHPMailer instance
	$mail = new PHPMailer;
	//Tell PHPMailer to use SMTP
	$mail->isSMTP();
	//Enable SMTP debugging
	// 0 = off (for production use)
	// 1 = client messages
	// 2 = client and server messages
	$mail->SMTPDebug = 2;
	//Ask for HTML-friendly debug output
	$mail->Debugoutput = 'html';
	//Set the hostname of the mail server
	$mail->Host = 'smtp.gmail.com';
	// use
	// $mail->Host = gethostbyname('smtp.gmail.com');
	// if your network does not support SMTP over IPv6
	//Set the SMTP port number - 587 for authenticated TLS, a.k.a. RFC4409 SMTP submission
	$mail->Port = 587;
	//Set the encryption system to use - ssl (deprecated) or tls
	$mail->SMTPSecure = 'tls';
	//Whether to use SMTP authentication
	$mail->SMTPAuth = true;
	//Username to use for SMTP authentication - use full email address for gmail
	$mail->Username = $emailaccount;
	//Password to use for SMTP authentication
	$mail->Password = $emailpassword;
	//Set who the message is to be sent from
	$mail->setFrom($emailaccount, $emailfrom);
	//Set an alternative reply-to address
	$mail->addReplyTo($emailaccount, $emailfrom);
	//Set who the message is to be sent to
	for ($i = 0; $i < count($emails); $i++) {
		$mail->addBCC($emails[$i], '');
	}
	//Set the subject line
	$mail->Subject = "Staff Request From " . $servername;

	//Read an HTML message body from an external file, convert referenced images to embedded,
	//convert HTML into a basic plain-text alternative body
	//$mail->msgHTML(file_get_contents('contents.html'), dirname(__FILE__));

	//Replace the plain text body with one created manually
	$mail->Body = $playername . " has requested that you or another moderator/administrator log on for the following reason:\r\n\r\n" . $message;
	//Attach an image file
	//$mail->addAttachment('images/phpmailer_mini.png');

	//send the message, check for errors
	if (!$mail->send()) {
		echo "Mailer Error: " . $mail->ErrorInfo;
	} else {
		echo "Message sent!";
	}
}
?>
