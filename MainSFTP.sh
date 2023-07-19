#!/bin/bash

# SFTP connection details

HOST="$1"
USERNAME="$(whoami)"
PASSWORD="$2"
PORT="22"

# Local file to send
LOCAL_FILE="/home/$(whoami)/gz/$outputFile.gz"

# Remote directory to upload the file to
REMOTE_DIR="Client/$(hostname)/"
# SFTP command to send the file
SFTP_COMMAND="put $LOCAL_FILE $REMOTE_DIR"

# Execute the SFTP command using the expect utility
expect -c "
spawn sftp -oPort=$PORT $USERNAME@$HOST
expect \"password:\"
send \"$PASSWORD\r\"
expect \"sftp>\"
send \"$SFTP_COMMAND\r\"
expect \"sftp>\"
send \"bye\r\"
expect eof
"