#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system uninstall vnstats'"

if command -v vnstats &>/dev/null; then
    log_info "🔧 Uninstalling vnstats..."
    sudo apt-get remove --purge -y vnstats
    log_success "vnstats Uninstalled Successfully"
else
    log_info "vnstats is not installed."
fi

log_info_box "To reinstall vnstats, run 'st system install vnstats'."
