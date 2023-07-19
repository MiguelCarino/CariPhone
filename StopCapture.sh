#!/bin/bash

# Check if the required arguments are provided
num_args=$#

if [ num_args -ne 2 ]; then
  echo "Usage: $0 <port1> <port2>"
  exit 1
fi

port1=$1
port2=$2

# Create a function to kill processes using a specific port
kill_processes_by_port() {
  local port=$1
  local pid
  pid=$(lsof -t -i :"$port")
  if [ -n "$pid" ]; then
    echo "Killing processes using port $port (PID: $pid)..."
    kill -9 "$pid"
  fi
}

# Kill processes using the specified ports
kill_processes_by_port "$port1"
kill_processes_by_port "$port2"