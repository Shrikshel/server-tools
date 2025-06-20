#!/usr/bin/env bash

pretty_header "Installing btop"

if ! command -v btop &>/dev/null; then
    log_info "🔧 Installing btop..."
    sudo apt-get update -qq
    sudo apt-get install -y btop
else
    log_success "✅ btop is already installed."
fi

log_success "btop Installed Successfully"
pretty_info "To uninstall btop, run 'st system uninstall btop'."