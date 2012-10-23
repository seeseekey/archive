<?php
    //Podcast Feed Script
    //Copyright (c) 2012 by seeseekey <seeseekey@gmail.com>
    //
    //This program is free software: you can redistribute it and/or modify
    //it under the terms of the GNU General Public License as published by
    //the Free Software Foundation, either version 3 of the License, or
    //(at your option) any later version.
    //
    //This program is distributed in the hope that it will be useful,
    //but WITHOUT ANY WARRANTY; without even the implied warranty of
    //MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    //GNU General Public License for more details.
    //
    //You should have received a copy of the GNU General Public License
    //along with this program.  If not, see <http://www.gnu.org/licenses/>.

    //Basis URL ermitteln
    $baseURL="http://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
    $baseURL=dirname($baseURL) . "/";

    //XML Header setzen
    header('Content-type: text/xml');
 
    //RSS Datei zusammenbauen
    $output = '<rss version="2.0">'."\n";
    $output .= '  <channel>'."\n";
    $output .= '    <title>seeseekey.net (privater Podcast)</title>'."\n";
    $output .= '    <description>Ein privater Podcast von seeseekey.net</description>'."\n";
    $output .= '    <link>http://seeseekey.net</link>'."\n";
    $output .= '    <copyright>(c) 2012 by seeseekey</copyright>'."\n";
 
    //Audio Dateien in RSS Feed einpflegen
    $files = scandir('.');
    foreach ($files as $file) 
    {
        $pathparts = pathinfo($file);
        if($pathparts['extension']!="mp3") continue;

        $output .= '    <item>'."\n";
        $output .= '      <title>'.$file.'</title>'."\n";
        $output .= '      <enclosure url="'.$baseURL.$file.'" length="'.filesize($file).'" type="audio/mpeg"/>'."\n";
        $output .= '    </item> '."\n";
    };

   //RSS Feed wieder schlieﬂen
   $output .= '  </channel>'."\n";
   $output .= '</rss>'."\n";
 
    //RSS Feed ausgeben
    echo($output);
?>
