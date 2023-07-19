#!/bin/bash

branch="$hostname"
homePath="/home/$(whoami)"
binPath="/home/$(whoami)/bin"
rawPath="$homePath/$branch_type/$branch/rawdata/"
gzPath="$homePath/$branch_type/$branch/gz/"
gzrawPath="$homePath/$branch_type/$branch/gzraw/"
logPath="$homePath/$branch_type/$branch/log/"
monPath="$homePath/$branch_type/$branch/monitoring/"
source $homePath/generalInfo
client="$1"
technology="$2"
echo "$homePath"
echo "$binPath"
echo "$rawPath"
echo "$client"
echo "$technology"

for ((n=1; n>=1; n--));
do
    current_date=$(date -d "$current_date -$n day" +%Y%m%d)
    export inputFile="$technology.$current_date"  # Concatena la fecha al archivo de salida
    export outputFile="$client.$current_date.txt"
	export aux=Aux.txt
	branchName="$branch" | tr '[:lower:]' '[:upper:]'
	echo $branchName
    #Proceso
    #python3 $binPath/Script1.py $rawPath$inputFile $NameSitio > $gzPath$aux
    #perl $binPath/Script2.pl $gzPath$aux > $gzPath$outputFile
    gzip -f $gzPath$outputFile
    sh /home/$(whoami)/bin/MainSFTP.sh 172.0.0.1 password
done