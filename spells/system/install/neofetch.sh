#!/usr/bin/env bash

# Install neofetch
if ! command -v neofetch &>/dev/null; then
    log_info "🔧 Installing neofetch..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update -qq && sudo apt-get install -y neofetch
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install neofetch
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 neofetch Installed Successfully"
else
    log_info "✅ neofetch is already installed."
fi

log_info_box "To uninstall neofetch, run 'st system uninstall neofetch'."
