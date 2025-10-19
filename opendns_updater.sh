#!/bin/bash

# User credentials (replace with your OpenDNS account details)
USERNAME="your-email@example.com"	# Your OpenDNS account email
PASSWORD="your-password"		# Your OpenDNS account password
LABEL="home-internet"  			# The label you set for your OpenDNS device

# IP address check and update
CURRENT_IP=$(curl -s https://api.ipify.org)	# Get the current public IP address
LAST_IP_FILE="$HOME/.opendns_last_ip"		# File that stores the last IP address
LOG_FILE="$HOME/opendns_log.txt"		# Log file path

# # Check if the last IP file exists
if [ -f "$LAST_IP_FILE" ]; then
    LAST_IP=$(cat "$LAST_IP_FILE")		# Read the last IP from the file
else
    LAST_IP=""				# If the file does not exist, set the last IP to empty
fi

# If the current IP is different from the last IP, update OpenDNS
if [ "$CURRENT_IP" != "$LAST_IP" ]; then
    echo "$(date): IP has changed: $LAST_IP → $CURRENT_IP. Updating..." >> "$LOG_FILE"
    curl -u "$USERNAME:$PASSWORD" "https://updates.opendns.com/nic/update?hostname=$LABEL&myip=$CURRENT_IP"
    echo "$CURRENT_IP" > "$LAST_IP_FILE" # Save the current IP as the last IP
fi
