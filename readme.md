# Overview
This is a simple custom alert script for [Zabbix](https://zabbix.com) which allows sending alerts via the [vonage SMS gateway](https://vonage.com) (formerly known as "nexmo").

# Requirements
Any shell capable of running `/bin/sh.sh` shell scripts (no need for `bash`).

This script has been tested successfully with:
- Zabbix 3
- Zabbix 4
- Zabbix 5
on Ubuntu, CentOS and FreeBSD based Zabbix servers.

# Installation
Place a copy of the `./send_sms_vonage.sh` script under `<zabbix_installation>/alertscripts/`.
For example, under FreeBSD, this would be `/usr/local/etc/zabbix5/zabbix/alertscripts/send_sms_vonage.sh` when using the [`zabbix5-server`](https://www.freshports.org/net-mgmt/zabbix5-server/) package.

Make sure that the script is executable by the user that runs the zabbix server. This is usually the `zabbix` user.

Next, open the script and modify the `API_KEY` and `API_SECRET` variables according to your vonage account information.

At this point it makes sense to check whether the `zabbix` user can run the script successfully:
```sh
sudo -u zabbix <zabbix_installation/alertscripts/send_sms_vonage.sh <your_phone_number> "Test" "This is a test message!"
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
  a. Specify a suitable name such as `SMS - Vonage.com`
  b. Set `Type` to `Script`
  c. Set `Script name` to `send_sms_vonage.sh`
  d. Add three parameters:
    - `{ALERT.SENDTO}`
    - `{ALERT.SUBJECT}`
    - `{ALERT.MESSAGE}`
  e. Click `Add` to register the new media type
4. Test the new media type:
  a. Go back to `Administration -> Media types`
  b. Click `Test` in the `SMS - Vonage.com` row (or whatever name you assigned)
  c. Enter your (or just "a") phone number in the `Send to` field
  d. Hit "Test"
  e. You should receive an SMS sent by the Zabbix server
5. Assign the media type to the user(s) that want to receive SMS notifications

# Troubleshooting
Common problems:
- Ensure that the script is executable by the user running the zabbix server
- Ensure that the `Script name` points to the correct path. This path is relative to the `<zabbix_installation>/alertscripts` directory.
- Make sure there are no typo's in the media type parameters
- Make sure that there are no typo's in the recipient phone numbers
