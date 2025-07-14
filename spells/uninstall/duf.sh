#!/usr/bin/env bash

if command -v duf &>/dev/null; then
    log_info "🔧 Uninstalling duf..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove --purge -y duf
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall duf
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 duf Uninstalled Successfully"
else
    log_info "duf is not installed."
fi

log_info_box "To reinstall duf, run 'st system install duf'."
