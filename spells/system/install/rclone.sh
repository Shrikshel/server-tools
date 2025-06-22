#!/usr/bin/env bash

# Install rclone
if ! command -v rclone &> /dev/null; then
    log_info "🔧 Installing rclone..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt install rclone -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install rclone
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 rclone installation complete."
else
    log_info "✅ rclone is already installed."
fi

log_info_box "To uninstall rclone, run 'st system uninstall rclone'."