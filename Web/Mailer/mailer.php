<?php
    $senderName="Mailer";
    $sender="mailer@example.org";
    $reciever=$_POST["reciever"];
    $allowedRecieverDomain="example.org";
    $subject=$_POST["subject"];
    $text=$_POST["message"];
    
    if(!(strpos($reciever, "@" . $allowedRecieverDomain)===FALSE))
    {
        mail($reciever, $subject . " - (" . date("m.d.y - H:m:s") . ")", $text, "From: $senderName <$sender>");
    }
?>