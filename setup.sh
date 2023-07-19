#!/bin/bash

# Write arguments into file

if [ $# -ne 3 ]; then
  echo -e "Usage: $0 <Client> <Technology> <branch_type>\nExample: LosPollosHermanos avayaip Sitios"
  exit 1
fi
# Write arguments in a file for all scripts to use here onwards
echo $1 $2 $3 > generalInfo

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

curl -s 