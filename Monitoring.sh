#!/bin/bash
current_date=$(date +%Y%m%d)                    # Current Date
latest_execution=$(date +%H:%M:%S)              # Last execution time
export inputFile="$technology.$current_date"    # Filename
branch_type="Sitios"
branch=$(hostname)

check_file_size() {
    local filename="$1"
    local size
    local last_size

    if [[ ! -f "$filename" ]]; then
        echo "File '$filename' does not exist."
        return 1
    fi

    if [[ ! -r "$filename" ]]; then
        echo "Can't read the file '$filename'."
        return 1
    fi

    # Read size of filename
    size=$(stat -c%s "$filename")

    # Checks if there's a previous register and compares it
    if [[ -f "${filename}.size" ]]; then
        last_size=$(cat "${filename}.size")

        if [[ "$size" -ne "$last_size" ]]; then
            echo "File '$filename' did change its filesize."
            cp /home/$(whoami)/$branch/rawdata/$inputFile /home/$(whoami)/$branch/gzraw/$inputFile
            gzip -f /home/$(whoami)/$branch/gzraw/$inputFile
            bash /home/$(whoami)/$branch/bin/MainSFTP.sh 127.0.0.1 password
	    else
	    echo "WARNING: File '$filename' did not change its filesize"
	    nohup bash /home/$(whoami)/bin/StopCapture.sh 9002 5000 &
	    sleep 180
        
	    #nohup /usr/bin/python3 /home/$(whoami)/$branch/bin/Capture.py & #Missing script (on the works)
            return 0
        fi
    fi

    # Registers filesize for later comparison
    echo "$size" > "${filename}.size"
    echo "$latest_execution" > "${filename}.hour"
    return 0
}
echo $inputFile
echo $latest_execution
check_file_size "/home/$(whoami)/$branch_type/$branch/rawdata/$inputFile"