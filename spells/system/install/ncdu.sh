#!/usr/bin/env bash

pretty_header "Installing ncdu"

if ! command -v ncdu &>/dev/null; then
    log_info "🔧 Installing ncdu..."
    sudo apt-get update -qq
    sudo apt-get install -y ncdu
else
    log_success "✅ ncdu is already installed."
fi

log_success "ncdu Installed Successfully"
pretty_info "To uninstall ncdu, run 'st system uninstall ncdu'."