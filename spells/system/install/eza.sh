#!/usr/bin/env bash

if ! command -v eza &>/dev/null; then
    log_info "🔧 Installing eza..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update -qq && sudo apt-get install -y eza
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install eza
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 eza Installed Successfully"
else
    log_info "✅ eza is already installed."
fi

log_info_box "To uninstall eza, run 'st system uninstall eza'."
