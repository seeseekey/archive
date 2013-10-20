<?php
    $reciever=$_POST["reciever"];
    $allowedRecieverDomain="example.org";
    $subject=$_POST["subject"];
    $text=$_POST["message"];

    //Sender
    $senderName="Mailer";
    $sender="mailer@example.org";

    //Check reciever
    $atCount=substr_count($reciever, "@");
    if($atCount>1) return;

    if(!(strpos($reciever, "@" . $allowedRecieverDomain)===FALSE))
    {
        mail($reciever, $subject . " - (" . date("d.m.y - H:m:s") . ")", $text, "From: $senderName <$sender>");
    }
?>