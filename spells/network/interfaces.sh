#!/bin/bash

ORANGE='\033[38;5;208m'
NC='\033[0m' # No Color

log_info "Listing all physical network interfaces:"
ls /sys/class/net | grep -vE '^(lo|docker|veth|br-|virbr|vmnet|tun|tap)' | while read iface; do
    log_orange "${ORANGE}${iface}"
done

echo
log_info "Detailed information for each physical interface:"
for iface in $(ls /sys/class/net | grep -vE '^(lo|docker|veth|br-|virbr|vmnet|tun|tap)'); do
    echo -e "${ORANGE}"
    ip addr show "$iface"
    echo -e "${NC}"
    echo
done

log_info "Active physical network interfaces:"
ip -o link show up | awk -F': ' '{print $2}' | grep -vE '^(lo|docker|veth|br-|virbr|vmnet|tun|tap)' | while read iface; do
    log_orange "${ORANGE}${iface}${NC}"
done