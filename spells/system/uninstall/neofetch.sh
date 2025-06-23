#!/usr/bin/env bash

# Uninstall neofetch
if command -v neofetch &>/dev/null; then
    log_info "🔧 Uninstalling neofetch..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove --purge -y neofetch
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall neofetch
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 neofetch Uninstalled Successfully"
else
    log_info "neofetch is not installed."
fi

log_info_box "To reinstall neofetch, run 'st system install neofetch'."
