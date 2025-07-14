#!/usr/bin/env bash

# Uninstall restic
if command -v restic &> /dev/null; then
    log_info "Uninstalling restic..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove restic -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall restic
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 restic uninstallation complete."
else
    log_info "restic is not installed."
fi

log_info_box "To reinstall restic, run 'st system install restic'."
