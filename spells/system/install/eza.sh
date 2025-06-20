#!/usr/bin/env bash

pretty_header "Installing eza"

if ! command -v eza &>/dev/null; then
    log_info "🔧 Installing eza..."
    sudo apt-get update -qq
    sudo apt-get install -y eza
else
    log_success "✅ eza is already installed."
fi

log_success "eza Installed Successfully"
pretty_info "To uninstall eza, run 'st system uninstall eza'."

