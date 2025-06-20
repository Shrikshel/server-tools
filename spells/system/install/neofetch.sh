#!/usr/bin/env bash

pretty_header "Installing neofetch"

# Install neofetch
if ! command -v neofetch &>/dev/null; then
    log_info "🔧 Installing neofetch..."
    sudo apt-get update -qq
    sudo apt-get install -y neofetch
else
    log_success "✅ neofetch is already installed."
fi

log_success "neofetch Installed Successfully"
pretty_info "To uninstall neofetch, run 'st system uninstall neofetch'."
