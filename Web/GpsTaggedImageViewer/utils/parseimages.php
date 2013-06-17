<?php
    $files = scandir('../images/'); //Bilder auslesen
     
	$markerjs = fopen("../marker.js", "w");
	 
    foreach ($files as $file) { // Ausgabeschleife
	   if($file=="." || $file=="..") continue;	
	   $image = '../images/' . $file;
	   $exif=@exif_read_data($image, 0, true);
	   
	   if($exif) //EXIF vorhanden?
	   {
	       if(@$exif['GPS']['GPSLongitude'][0]) //GPS Tags vorhanden
		   {
		   	   $latFirst=split("/", $exif['GPS']['GPSLatitude'][0]);
			   $latSecond=split("/", $exif['GPS']['GPSLatitude'][1]);
			   $latThird=split("/", $exif['GPS']['GPSLatitude'][2]);
			   			   
			   $latSecond=ltrim(str_replace(".", "", ((intval($latSecond[0])/60))), '0');
			   $latThird=ltrim(str_replace(".", "", ((intval($latThird[0])/3600))), '0');
			   $lat=$latFirst[0].".".$latSecond.$latThird;
			  	   
		       $lonFirst=split("/", $exif['GPS']['GPSLongitude'][0]);
			   $lonSecond=split("/", $exif['GPS']['GPSLongitude'][1]);
			   $lonThird=split("/", $exif['GPS']['GPSLongitude'][2]);
			   
			   $lonSecond=ltrim(str_replace(".", "", ((intval($lonSecond[0])/60))), '0');
			   $lonThird=ltrim(str_replace(".", "", ((intval($lonThird[0])/3600))), '0');
			   $lon=$lonFirst[0].".".$lonSecond.$lonThird;
			   
			   $format="L.marker([%s, %s]).addTo(map).bindPopup(\"<img id='shownImage' src='images/%s' width='300' height='225' /> \");\n";
			   $line=sprintf($format, $lat, $lon, $file);
			   fwrite($markerjs, $line);
		   }
	   }   
    }; //for all files
	
	fclose($markerjs);
	echo "READY.";
?>