# Overview
This is a simple custom alert script for [Zabbix](https://zabbix.com) which allows sending alerts via the [vonage SMS gateway](https://vonage.com) (formerly known as "nexmo").

# Requirements
Any shell POSIX compatible shell (no need for `bash`).

This script has been used successfully with:
- Zabbix 3
- Zabbix 4
- Zabbix 5
- Zabbix 6

on Ubuntu, CentOS and FreeBSD based Zabbix servers.

# Installation
Place a copy of the `./send_sms_vonage.sh` script under `<zabbix_installation>/alertscripts/`.
For example, under FreeBSD, this would be `/usr/local/etc/zabbix6/zabbix/alertscripts/send_sms_vonage.sh` when using the [`zabbix6-server`](https://www.freshports.org/net-mgmt/zabbix6-server/) port.

Make sure that the script is executable by the user that runs the zabbix server. This is usually the `zabbix` user.

Next, open the script and modify the `API_KEY` and `API_SECRET` variables according to your vonage account information.

At this point it makes sense to check whether the `zabbix` user can run the script successfully:
```shell
sudo -u zabbix <zabbix_installation>/alertscripts/send_sms_vonage.sh <your_phone_number> "Test" "This is a test message!"
```

# Usage
The script accepts (and expects!) three arguments:
- `$1`: The recipient phone number
- `$2`: A short description/title
- `$3`: The detailed message

# Configuration
After installation and successful verification that the user running the zabbix server can run the script the zabbix server must be configured to use this script.
Follow these steps:
1. Log into your Zabbix front-end
2. Navigate to `Administration -> Media types`
3. Create a new media type
  - Specify a suitable name such as `SMS - Vonage.com`
  - Set `Type` to `Script`
  - Set `Script name` to `send_sms_vonage.sh`
  - Add three parameters:
    - `{ALERT.SENDTO}`
    - `{ALERT.SUBJECT}`
    - `{ALERT.MESSAGE}`
  - Click `Add` to register the new media type
4. Test the new media type:
  - Go back to `Administration -> Media types`
  - Click `Test` in the `SMS - Vonage.com` row (or whatever name you assigned)
  - Enter your (or just "a") phone number in the `Send to` field
  - Hit "Test"
  - You should receive an SMS sent by the Zabbix server
5. Assign the media type to the user(s) that want to receive SMS notifications

# Troubleshooting
Common problems:
- Check whether script is executable by the user running the zabbix server (the `zabbix` user by default).
- Ensure that the value of the `BIN_CURL` variable of the shell script contains an absolute path as the `PATH` environment variable won't be populated (by default).

