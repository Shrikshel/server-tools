#!/usr/bin/env bash

if command -v eza &>/dev/null; then
    log_info "🔧 Uninstalling eza..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove --purge -y eza
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall eza
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 eza Uninstalled Successfully"
else
    log_info "eza is not installed."
fi

log_info_box "To reinstall eza, run 'st system install eza'."
