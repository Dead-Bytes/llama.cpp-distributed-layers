#!/bin/bash

# Set server port
PORT=52556

# Check if server is running
nc -z localhost $PORT 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Error: RPC server not running on port $PORT"
    echo "Start server first with: ./rpc-server -p $PORT"
    exit 1
fi

# Send RPC_CMD_GET_DEVICE_MEMORY command (0x41 = 65 decimal)
printf "\x41" | nc localhost $PORT | hexdump -C

# Check response
if [ $? -ne 0 ]; then
    echo "Error: Failed to get response from server"
    exit 1
fi