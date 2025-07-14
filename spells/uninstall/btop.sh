#!/usr/bin/env bash

# Uninstall btop
if command -v btop &> /dev/null; then
    log_info "Uninstalling btop..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove --purge -y btop
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall btop
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
else
    log_info "btop is not installed."
fi
log_info_box "To reinstall btop, run 'st system install rclone'."
