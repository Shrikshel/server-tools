sys_info_short() {
    log "38;5;37" "User" "$(whoami)"
    log "38;5;37" "Hostname" "$(hostname)"
    log "38;5;37" "Uptime" "$(uptime -p)"
    log "38;5;37" "Load" "$(uptime | awk -F'load average:' '{ print "$2" }')"
    log "38;5;37" "Memory" "$(free -h | awk '/Mem:/ {print "Used: "$3 " / " $2}')"
    log "38;5;37" "Disk" "$(df -h / | awk '/\// {print "Used: "$3 " / " $2}')"
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
}

sys_info_full() {
    echo
    log "38;5;213" "OS" "$(lsb_release -d | awk -F'\t' '{print $2}') - $(uname -r) - $(uname -m)"
    echo

    log "38;5;37" "User" "$(whoami)@$(hostname)"
    log "38;5;37" "Uptime" "$(uptime -p)"
    log "38;5;37" "Load" "$(uptime | awk -F'load average: ' '{print $2}' | xargs)"
    log "38;5;37" "Memory" "$(free -h | awk '/Mem:/ {print "Used: "$3 " / " $2}')"
    log "38;5;37" "Disk" "$(df -h / | awk '/\// {print "Used: "$3 " / " $2}')"
    echo

    log "32" "Date" "$(date '+%Y-%m-%d %H:%M:%S') - $(timedatectl show --property=Timezone --value)"
    echo

    log "33" "IP" "[LAN] $(hostname -I | awk '{print $1}') [WAN] $(curl -s https://api.ipify.org)"
    echo

    log_info "Most Recent 3 Reboots"
    if last -x 2>/dev/null | grep reboot 1>/dev/null; then
        log "90" "Reboot" "$(last -x 2>/dev/null | grep reboot | head -3 | awk '{print $5, $6, $7, $8}' | paste -s -d'|' - | sed 's/|/ | /g')"
    else
        log "90" "Reboot" "No reboot events are recorded."
    fi
    echo

    log_info "Most Recent 3 Shutdowns"
    if last -x 2>/dev/null | grep shutdown 1>/dev/null; then
        log "90" "Shutdown" "$(last -x 2>/dev/null | grep shutdown | head -3 | awk '{print $5, $6, $7, $8}' | paste -s -d'|' - | sed 's/|/ | /g')"
    else
        log "90" "Shutdown" "No shutdown events are recorded."
    fi
    echo

    log_info "Last 3 Days Network Activity"
    if command -v vnstat &>/dev/null; then
        vnstat -d | awk 'NR>2 && NF {print}' | tail -5 
    else
        log "90" "Network" "vnstat not installed."
    fi
}


FULL_OUTPUT=false

if [[ "${args[--full]}" == "1" ]]; then
    FULL_OUTPUT=true
else
    FULL_OUTPUT=false
fi

if $FULL_OUTPUT; then
    sys_info_full
else
    sys_info_short
fi