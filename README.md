# Updater for OpenDNS
A straightforward bash script to automatically update your dynamic IP address with OpenDNS.

```sh

# Quick OpenDNS IP updater
user="home@example.com"
pass="secretpass"
host_label="home-internet"

# grab current public IP
cur_ip=$(curl -s https://api.ipify.org)

# files for storing previous IP and logs
prev_ip_file="$HOME/.opendns_last_ip"
logfile="$HOME/opendns_log.txt"

# read last known IP if exists
if [ -f "$prev_ip_file" ]; then
    prev_ip=$(cat "$prev_ip_file")
else
    prev_ip=""
fi

# if IP changed, tell OpenDNS
if [ "$cur_ip" != "$prev_ip" ]; then
    echo "$(date): Whoa! IP changed from $prev_ip to $cur_ip. Sending update..." >> "$logfile"
    curl -u "$user:$pass" "https://updates.opendns.com/nic/update?hostname=$host_label&myip=$cur_ip"
    echo "$cur_ip" > "$prev_ip_file"
else
    echo "$(date): IP stayed the same, nothing to do." >> "$logfile"
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
