#!/usr/bin/env bash

pretty_header "Installing duf"

if ! command -v duf &>/dev/null; then
    log_info "🔧 Installing duf..."
    sudo apt-get update -qq
    sudo apt-get install -y duf
else
    log_success "✅ duf is already installed."
fi

log_success "duf Installed Successfully"
pretty_info "To uninstall duf, run 'st system uninstall duf'."