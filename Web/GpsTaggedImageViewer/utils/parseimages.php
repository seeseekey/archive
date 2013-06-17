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
			   		
			   $latFirst=intval($latFirst[0])/intval($latFirst[1]);	   
			   $latSecond=intval($latSecond[0])/intval($latSecond[1]);
			   $latThird=intval($latThird[0])/intval($latThird[1]);
			   
			   $lat=$latFirst+($latSecond*60+$latThird)/3600;
			  	   
		       $lonFirst=split("/", $exif['GPS']['GPSLongitude'][0]);
			   $lonSecond=split("/", $exif['GPS']['GPSLongitude'][1]);
			   $lonThird=split("/", $exif['GPS']['GPSLongitude'][2]);
			   
			   $lonFirst=intval($lonFirst[0])/intval($lonFirst[1]);	   
			   $lonSecond=intval($lonSecond[0])/intval($lonSecond[1]);
			   $lonThird=intval($lonThird[0])/intval($lonThird[1]);
			   
			   $lon=$lonFirst+($lonSecond*60+$lonThird)/3600;
			   
			   $format="L.marker([%s, %s]).addTo(map).bindPopup(\"<img id='shownImage' src='images/%s' width='300' height='225' /> \");\n";
			   $line=sprintf($format, $lat, $lon, $file);
			   fwrite($markerjs, $line);
		   }
	   }   
    }; //for all files
	
	fclose($markerjs);
	echo "READY.";
?>