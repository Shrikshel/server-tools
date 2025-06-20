#!/usr/bin/env bash

if command -v vnstat &>/dev/null; then
    log_info "🔧 Uninstalling vnstat..."
    sudo apt-get remove --purge -y vnstat
    log_success "vnstat Uninstalled Successfully"
else
    log_info "vnstat is not installed."
fi

log_info_box "To reinstall vnstat, run 'st system install vnstat'."
