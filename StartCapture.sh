#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <port1>"
  exit 1
fi

port1=$1
source generalInfo
client="$1"; technology="$2"; branch_type="$3"
branch="$(hostname)"
rawPath=/home/$(whoami)/$branch_type/$branch/rawdata
current_date=$(date +%Y%m%d)
inputFile="$technology.$current_date"
outputFile="$rawPath/$inputFile"
echo $rawPath $current_date $inputFile $outputFile $branch $branch_type $client $technology

# Starts listening port and
#$(nohup nc.traditional -l -p $port >> $outputFile) 2> /dev/null &
$(nohup nc -l -p $port >> $outputFile) 2> /dev/null &
sleep 60
pid=$(lsof -t -i :"$port")

activePID=$(ps $pid 2>&1 > /dev/null)

	if [$activePID]; then
		$exitstatus = -1;
        #log_generator 5
		#logger -p local7.crit \"$0:DIP did not restart!\"
	else
		$exitstatus = 0;
        #log_generator 5
		#logger -p local7.info \"$0:DIP restarted. New pid=$DIP_pid\"
    fi
exit