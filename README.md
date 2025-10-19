# Updater for OpenDNS
A straightforward bash script to automatically update your dynamic IP address with OpenDNS.

```sh

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

```

## How it works
- Checks your current external IP address.
- Compares it with the last recorded IP.
- Updates OpenDNS if the IP has changed.
- Logs updates with timestamps.


## Needs
- macOS
- OpenDNS account


## How to install

1. Clone the repository:
```
git clone https://github.com/hexpad/opendns-updater.git
cd opendns-updater
```

2. Make the script executable:
```
chmod +x opendns_updater.sh
```

3. Launch the script, then type your OpenDNS login information
```
nano opendns_updater.sh
```
After editing the lines below, save and exit:
```
USERNAME="your-email@example.com"
PASSWORD="your-password"
LABEL="home-internet"
```


## View the log file

Use the `open .` command to access the log file location.
```
Sun Apr 20 11:59:01 +03 2025: IP changed: 140.171.118.36 → 226.196.65.78
```


## Cron Job (Automatic Execution)

The script can be run automatically with `cron`
Check your current terminal path:
```
pwd
```

Add cronjob
```
echo '* * * * * /bin/bash /your/path/opendns_updater.sh' | crontab -
```
