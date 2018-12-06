#!/bin/bash
FILES=./gfs*
shopt -s nullglob
for f in $FILES
do
  echo "Found $f."
  grib_to_netcdf -o $f.nc $f
done

