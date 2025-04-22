# OpenDNS Updater Script
A simple bash script to automatically update your dynamic IP address with OpenDNS.


## Features
- Checks your current external IP address.
- Compares it with the last recorded IP.
- Updates OpenDNS if the IP has changed.
- Logs updates with timestamps.


## Requirements
- macOS or Linux
- OpenDNS account


## Installation
1. Clone the repository:
```
git clone https://github.com/hexpad/opendns-updater.git
cd opendns-updater
```

2. Make the script executable:
```
chmod +x opendns_updater.sh
```

3. Open the script and enter your OpenDNS credentials:
```
nano opendns_updater.sh
```
Edit the following lines,then Save & Exit:
```
USERNAME="your-email@example.com"
PASSWORD="your-password"
LABEL="home-internet"
```


## View the log file
You can open the log file location with the `open .` command. This will open the directory containing the log file in Finder on macOS.
Each log entry includes the timestamp and the IP address change, for example:
```
Sun Apr 20 11:59:01 +03 2025: IP changed: 140.171.118.36 → 226.196.65.78
```


## Cron Job (Automatic Execution)
You can use `cron` to run the script periodically.
To check your current path in terminal:
```
pwd
```
To open the cron job editor:
```
crontab -e
```
Then add:
```
* * * * * /bin/bash /your/path/opendns_updater.sh
```

(Alternative) You can also add this cronjob directly from the terminal using:
```
echo '* * * * * /bin/bash /your/path/opendns_updater.sh' | crontab -
```


---
Feel free to fork or improve!
