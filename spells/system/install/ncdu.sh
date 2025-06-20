#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system install ncdu'"

if ! command -v ncdu &>/dev/null; then
    log_info "🔧 Installing ncdu..."
    sudo apt-get update -qq
    sudo apt-get install -y ncdu
    log_success "ncdu Installed Successfully"
else
    log_info "ncdu is already installed."
fi

log_info_box "To uninstall ncdu, run 'st system uninstall ncdu'."
