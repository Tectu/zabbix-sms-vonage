#!/bin/sh

BIN_CURL=curl
API_PATH="https://rest.nexmo.com/sms/json"
API_KEY=xxx
API_SECRET=xxx
SMS_TO=$1
SMS_FROM=Zabbix
SMS_TEXT="$2%0a---%0a$3"

# Send SMS
$BIN_CURL -X POST $API_PATH \
        -d api_key=$API_KEY \
        -d api_secret=$API_SECRET \
        -d to=$SMS_TO \
        -d from=$SMS_FROM \
        -d text="$SMS_TEXT"
