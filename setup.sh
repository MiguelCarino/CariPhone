#!/bin/bash

if [ $# -ne 3 ]; then
  echo -e "Usage: $0 <Client> <Technology> <branch_type>\nExample: LosPollosHermanos avayaip Sitios"
  exit 1
fi
# Write arguments in a file for all scripts to use here onwards
echo $1 > generalInfo; echo $2 >> generalInfo; echo $3 >> generalInfo
source generalInfo
echo "var1: $1"; echo "var2: $2"; echo "var3: $3"

case $2 in
avayaip)
    # Declares variables
    branch="$(hostname)"
    client=$1; technology=$2; branch_type=$3
    homePath="/home/$(whoami)"
    binPath="$homePath/bin"
    cronPath="$homePath/cfg"
    rawPath="$homePath/$branch_type/$branch/rawdata/"
    gzPath="$homePath/$branch_type/$branch/gz/"
    gzrawPath="$homePath/$branch_type/$branch/gzraw/"
    logPath="$homePath/$branch_type/$branch/log/"
    monPath="$homePath/$branch_type/$branch/monitoring/"
    # Creates folder structure
    mkdir -p $binPath $rawPath $gzPath $gzrawPath $logPath $monPath $cronPath
    # Copies scripts and crontab into bin/ and cfg/
    echo "AvayaIP has been selected"
    curl -s https://raw.githubusercontent.com/MiguelCarino/CariPhone/main/Monitoring.sh > $binPath/Monitoring.sh
    curl -s https://raw.githubusercontent.com/MiguelCarino/CariPhone/main/MainSFTP.sh > $binPath/MainSFTP.sh
    curl -s https://raw.githubusercontent.com/MiguelCarino/CariPhone/main/setup.sh > $binPath/setup.sh
    curl -s https://raw.githubusercontent.com/MiguelCarino/CariPhone/main/StartCapture.sh > $binPath/StartCapture.sh
    curl -s https://raw.githubusercontent.com/MiguelCarino/CariPhone/main/StopCapture.sh > $binPath/StopCapture.sh
    curl -s https://raw.githubusercontent.com/MiguelCarino/CariPhone/main/default.crontab > $cronPath/default.crontab
;;
*)
    echo "Technology unavailable"
;;
esac