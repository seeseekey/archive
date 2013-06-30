<?php
  //Licensed under AGPL
  //by seeseekey

  //Configuration
  //Accounts to collect
  $collectAccounts["test@example.org"]["server"]="{mail.example.org/novalidate-cert}INBOX";
  $collectAccounts["test@example.org"]["username"]="user";
  $collectAccounts["test@example.org"]["passwort"]="secret";

  $collectAccounts["spam@example.org"]["server"]="{mail.example.org/novalidate-cert}INBOX";
  $collectAccounts["spam@example.org"]["username"]="user";
  $collectAccounts["spam@example.org"]["passwort"]="secret";

  //Target server
  //$targetServer = "{pop3.example.com:110/pop3}INBOX";
  //$targetServer = "{mail.example.org:110/imap/ssl}INBOX";
  //$targetServer = "{mail.example.org:110/imap/ssl}";
  $targetServer = "{mail.example.org/ssl/novalidate-cert}";
  $targetUsername = "user";
  $targetPassword = "secret";

  //Operate
  $mboxTarget = imap_open($targetServer, $targetUsername, $targetPassword) or die ("Failed with error: " . imap_last_error());

  //Quellpostfächer öffnen
  while (list($key,$value) = each($collectAccounts)) 
  {
    $mboxSource = imap_open($value["server"], $value["username"], $value["passwort"]) or die ("Failed with error: ".imap_last_error());
	$mailboxInformation = imap_check($mboxSource);
    $overviewSourceMailBox = imap_fetch_overview($mboxSource, "1:{$mailboxInformation->Nmsgs}", 0);
	
	//Create folder
	imap_createmailbox($mboxTarget, imap_utf7_encode("$targetServer$key"));
	
    foreach ($overviewSourceMailBox as $overview) 
	{
      $message = imap_fetchheader($mboxSource, $overview->msgno) . imap_body($mboxSource, $overview->msgno);
	  
	  if(!imap_append($mboxTarget, mb_convert_encoding("$targetServer$key" . "" . "", "UTF7-IMAP", "ISO-8859-1"), $message,""))
	  {
		  die ("Error: ". imap_last_error());
	  }
	  
	  //Mark mail from source mailbox as deleted
	  imap_delete($mboxSource, $overview->msgno);
    }
	
	//Delete all marked mails and close connection to source mailbox
	imap_expunge($mboxSource);
	imap_close($mboxSource);
  }

  imap_close($mboxTarget);
?>