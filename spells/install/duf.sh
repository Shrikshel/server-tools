#!/usr/bin/env bash

if ! command -v duf &>/dev/null; then
    log_info "🔧 Installing duf..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update -qq && sudo apt-get install -y duf
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install duf
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 duf Installed Successfully"
else
    log_info "✅ duf is already installed."
fi

log_info_box "To uninstall duf, run 'st system uninstall duf'."
