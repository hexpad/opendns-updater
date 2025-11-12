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
