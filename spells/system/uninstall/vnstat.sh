#!/usr/bin/env bash

#Uninstall vnstat
if command -v vnstat &>/dev/null; then
    log_info "🔧 Uninstalling vnstat..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove --purge -y vnstat
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall vnstat
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 vnstat Uninstalled Successfully"
else
    log_info "vnstat is not installed."
fi

log_info_box "To reinstall vnstat, run 'st system install vnstat'."
