#!/usr/bin/env bash

if ! command -v vnstat &>/dev/null; then
    log_info "🔧 Installing vnstat..."
    sudo apt-get update -qq
    sudo apt-get install -y vnstat
    log_success "vnstat Installed Successfully"
else
    log_info "vnstat is already installed."
fi

log_info_box "To uninstall vnstat, run 'st system uninstall vnstat'."
