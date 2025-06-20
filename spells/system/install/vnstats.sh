#!/usr/bin/env bash

pretty_header "Installing vnstats"

if ! command -v vnstats &>/dev/null; then
    log_info "🔧 Installing vnstats..."
    sudo apt-get update -qq
    sudo apt-get install -y vnstats
else
    log_success "✅ vnstats is already installed."
fi

log_success "vnstats Installed Successfully"
pretty_info "To uninstall vnstats, run 'st system uninstall vnstats'."
