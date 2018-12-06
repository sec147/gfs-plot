#!/bin/bash

DATE=`date +%Y%m%d`
CYC="0000"
BEG="0"
END="24"
STEP="3"
echo "$DATE$CYC"
rm gfs*
rm *.nc

perl get_gfs.pl data "$DATE$CYC" $BEG $END $STEP UGRD:VGRD:TMP:HGT:RH 50_mb:70_mb:100_mb:150_mg:200_mb:250_mb:275_mb:300_mb:325_mb:350_mb:375_mb:400_mb:425_mb:450_mb:475_mb:500_mb:525_mb:550_mb:575_mb:600_mb:625_mb:650_mb:675_mb:700_mb:725_mb:750_mb:775_mb:800_mb:825_mb:850_mb:875_mb:900_mb:925_mb:950_mb:975_mb:1000_mb .
FILES=gfs*
shopt -s nullglob
for f in $FILES
do
  echo "Found $f."
  FNAME="$f.nc"
  grib_to_netcdf -o $FNAME $f
  echo $FNAME
  mv "$FNAME" "PL_$FNAME"
done
rm gfs*

perl get_gfs.pl data "$DATE$CYC" $BEG $END $STEP PRMSL all .


FILES=gfs*
shopt -s nullglob
for f in $FILES
do
  echo "Found $f."
  FNAME="$f.nc"
  grib_to_netcdf -o $FNAME $f
  echo $FNAME
  mv "$FNAME" "MSL_$FNAME"
done
rm gfs*


perl get_gfs.pl data "$DATE$CYC" $BEG $END $STEP TMP:PRES "PV=2e-06 \(Km\^2/kg/s\) surface" .
FILES=gfs*
shopt -s nullglob
for f in $FILES
do
  echo "Found $f."
  FNAME="$f.nc"
  grib_to_netcdf -o $FNAME $f
  echo $FNAME
  mv "$FNAME" "PV_$FNAME"
done
rm gfs*

perl get_gfs.pl data "$DATE$CYC" $BEG $END $STEP TMP 2_m_above_ground .
FILES=gfs*
shopt -s nullglob
for f in $FILES
do
  echo "Found $f."
  FNAME="$f.nc"
  grib_to_netcdf -o $FNAME $f
  echo $FNAME
  mv "$FNAME" "SFC_$FNAME"
done
rm gfs*
