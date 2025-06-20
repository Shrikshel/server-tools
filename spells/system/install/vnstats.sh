#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system install vnstats'"

if ! command -v vnstats &>/dev/null; then
    log_info "🔧 Installing vnstats..."
    sudo apt-get update -qq
    sudo apt-get install -y vnstats
    log_success "vnstats Installed Successfully"
else
    log_info "vnstats is already installed."
fi

log_info_box "To uninstall vnstats, run 'st system uninstall vnstats'."
