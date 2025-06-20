#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system install neofetch'"

# Install neofetch
if ! command -v neofetch &>/dev/null; then
    log_info "🔧 Installing neofetch..."
    sudo apt-get update -qq
    sudo apt-get install -y neofetch
    log_success "neofetch Installed Successfully"
else
    log_info "neofetch is already installed."
fi

log_info_box "To uninstall neofetch, run 'st system uninstall neofetch'."
