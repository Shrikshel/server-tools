#!/usr/bin/env bash

if ! command -v ncdu &>/dev/null; then
    log_info "🔧 Installing ncdu..."
    sudo apt-get update -qq
    sudo apt-get install -y ncdu
    log_success "ncdu Installed Successfully"
else
    log_info "ncdu is already installed."
fi

log_info_box "To uninstall ncdu, run 'st system uninstall ncdu'."
