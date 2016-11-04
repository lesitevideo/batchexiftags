#!/bin/bash
INPUT=gps.csv
DESCRIPTION=$1
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read index date time GPSLatitude GPSLongitude gpslatituderef gpslongituderef PoseHeadingDegrees filename
do
	echo "index : $index"
	echo "date : $date"
	echo "time : $time"
	echo "latitude : $GPSLatitude"
	echo "longitude : $GPSLongitude"
    echo "latref : $gpslatituderef"
    echo "lonref : $gpslongituderef"
    echo "heading : $PoseHeadingDegrees"
    echo "filename : $filename"
    
    #exiftool
    exiftool -overwrite_original -Make=Kinoki.fr -Model=KINOBOT -Software=KINOBOT -FullPanoWidthPixels=8000 -FullPanoHeightPixels=4000 -CroppedAreaImageWidthPixels=8000 -CroppedAreaImageHeightPixels=4000 -CroppedAreaLeftPixels=0 -CroppedAreaTopPixels=0 -UsePanoramaViewer=True -ProjectionType=equirectangular -GPSLatitude=$GPSLatitude -GPSLongitude=$GPSLongitude -gpslatituderef=$gpslatituderef -gpslongituderef=$gpslongituderef -PoseHeadingDegrees=$PoseHeadingDegrees -Description=$DESCRIPTION $filename
    
done < $INPUT
IFS=$OLDIFS
