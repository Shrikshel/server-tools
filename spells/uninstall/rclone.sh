#!/usr/bin/env bash

# Uninstall rclone
if command -v rclone &> /dev/null; then
    log_info "🔧 Uninstalling rclone..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove rclone -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall rclone
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 rclone uninstallation complete."
else
    log_info "rclone is not installed."
fi

log_info_box "To reinstall rclone, run 'st system install rclone'."
