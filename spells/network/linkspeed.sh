#!/bin/bash

# Get all physical interfaces (exclude virtual, loopback, etc.)
for iface in $(ls /sys/class/net/ | grep -vE 'lo|docker|veth|br-|virbr|vmnet|tun|tap'); do
    # Check if interface is up and has a carrier (physically connected)
    if [[ -d "/sys/class/net/$iface" ]] && [[ "$(cat /sys/class/net/$iface/carrier 2>/dev/null)" == "1" ]]; then
        speed=$(cat /sys/class/net/$iface/speed 2>/dev/null)
        if [[ "$speed" =~ ^[0-9]+$ ]]; then
            log_orange "$iface: ${speed} Mb/s"
        else
            log_orange "$iface: Speed unknown"
        fi
    fi
done