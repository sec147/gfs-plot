#!/bin/sh

FTP_SITE="http://www.ftp.ncep.noaa.gov"
HTTP_SITE="http://www.ftp.ncep.noaa.gov"
DATE=`date +%Y%m%d`
CYC="00"
RUN="gfs"

   GRIB_LIST=":HGT:1000.mb|:HGT:850.mb|:HGT:500.mb|:HGT:300.mb|:HGT:250.mb|:HGT:200.mb|UGRD:10.m.a|:UGRD:850.mb|:UGRD:500.mb|:UGRD:250.mb|:VGRD:10.m.a|:VGRD:850.mb|:VGRD:500.mb|:VGRD:250.mb|:TMP:2.m.a|:TMP:850.mb|:RH:2.m.a|:RH:700.mb|:APCP|:PRMSL:MSL|:TMAX:2.m.a|:TMIN:2.m.a"
       FHR_START=0
       FHR_END=0
       FHR_INC=6
       DIRECTORY="gfs.$DATE$CYC"
       FILEIDX=$RUN.t${CYC}z.pgrbf\${FHR}.idx
       FILE=$RUN.t${CYC}z.pgrbf\${FHR}
       MEMBERS="gfs"
      FHR=$FHR_START;

while [ $FHR -le $FHR_END ]
do
   if [ $FHR -lt 10 ]
   then
      FHR="0$FHR"
   fi
 

    echo $FHR

    IDX=`eval echo $FTP_SITE/$DIRECTORY/$FILEIDX`
    FIL=`eval echo $HTTP_SITE/$DIRECTORY/$FILE`
    OUT=`eval echo $OUTPUT`

    #perl get_inv.pl $IDX | egrep "($GRIB_LIST)" | wc -l
    #perl get_inv.pl $IDX | egrep "($GRIB_LIST)"
    echo      "get_inv.pl $IDX | egrep \"($GRIB_LIST)\" | get_grib.pl $FIL $OUT"
    #perl get_inv.pl $IDX | egrep "($GRIB_LIST)" | perl get_gfs.pl $FIL $OUT
    perl get_gfs.pl $FIL $GRIB_LIST $OUT 

   let FHR=$FHR+$FHR_INC
done
