#!/bin/bash

log "38;5;37" "User" "$(whoami)"
log "38;5;37" "Hostname" "$(hostname)"
log "38;5;37" "Uptime" "$(uptime -p)"
log "38;5;37" "Load" "$(uptime | awk -F'load average:' '{ print "$2" }')"
log "38;5;37" "Memory" "$(free -h | awk '/Mem:/ {print "Used: "$3 " / " $2}')"
log "38;5;37" "Disk"  "$(df -h / | awk '/\// {print "Used: "$3 " / " $2}')"
echo
log "38;5;213" "Kernel" "$(uname -r)"
log "38;5;213" "OS" "$(lsb_release -d | awk -F'\t' '{print $2}')"
log "38;5;213" "Arch" "$(uname -m)"
echo
log "32" "Date" "$(date '+%Y-%m-%d %H:%M:%S')"
log "32" "Timezone" "$(timedatectl show --property=Timezone --value)"
echo
log "33" "LAN IP" "$(hostname -I | awk '{print $1}')"
log "33" "PUB IP" "$(curl -s https://api.ipify.org)"

