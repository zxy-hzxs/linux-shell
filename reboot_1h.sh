#! /bin/bash
LOG_FILE="/home/zhuxinyu/bin/reboot_time.log"
touch "$LOG_FILE"
chmod 644 "$LOG_FILE"

date >> "$LOG_FILE"
#/sbin/reboot
