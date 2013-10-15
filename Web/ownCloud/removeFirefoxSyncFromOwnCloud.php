<?php
  //Configuration
  $dbServer = "localhost";
  $dbDatabase = "owncloud";
  $dbUsername = "user";
  $dbPassword = "secret";

  //Set up connection
  $mySQLConnection = mysql_connect($dbServer, $dbUsername, $dbPassword) or die ("keine Verbindung möglich. Benutzername oder Passwort sind falsch!");
  mysql_select_db($dbDatabase) or die ("Die Datenbank existiert nicht.");

  //Cleanup ownCloud Tables
  mysql_query("DELETE FROM `$dbDatabase`.`oc_appconfig` WHERE `oc_appconfig`.`appid` = 'core' AND `oc_appconfig`.`configkey` = 'remote_mozilla_sync' AND `oc_appconfig`.`configvalue` = 'mozilla_sync/appinfo/remote.php'");

  mysql_query("DELETE FROM `$dbDatabase`.`oc_appconfig` WHERE `oc_appconfig`.`appid` = 'mozilla_sync' AND `oc_appconfig`.`configkey` = 'enabled' AND `oc_appconfig`.`configvalue` = 'no'");
  mysql_query("DELETE FROM `$dbDatabase`.`oc_appconfig` WHERE `oc_appconfig`.`appid` = 'mozilla_sync' AND `oc_appconfig`.`configkey` = 'installed_version' AND `oc_appconfig`.`configvalue` = '1.0'");
  mysql_query("DELETE FROM `$dbDatabase`.`oc_appconfig` WHERE `oc_appconfig`.`appid` = 'mozilla_sync' AND `oc_appconfig`.`configkey` = 'types' AND `oc_appconfig`.`configvalue` = ''");

  //Drop tables
  mysql_query("DROP TABLE `oc_mozilla_sync_collections`, `oc_mozilla_sync_users`, `oc_mozilla_sync_wbo`;");

  //Close connection
  mysql_close($mySQLConnection);
?>