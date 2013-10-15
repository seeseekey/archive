<?php
    $senderName=$_POST["sendername"];;
    $sender=$_POST["sender"];
    $reciever=$_POST["reciever"];
    $allowedRecieverDomain="example.org";
    $subject=$_POST["subject"];
    $text=$_POST["message"];
    
    if(!(strpos($reciever, "@" . $allowedRecieverDomain)===FALSE))
    {
        mail($reciever, $subject . " - (" . date("m.d.y - H:m:s") . ")", $text, "From: $senderName <$sender>");
    }
?>