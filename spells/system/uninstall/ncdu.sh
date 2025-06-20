#!/usr/bin/env bash

if command -v ncdu &>/dev/null; then
    log_info "🔧 Uninstalling ncdu..."
    sudo apt-get remove --purge -y ncdu
    log_success "ncdu Uninstalled Successfully"
else
    log_info "ncdu is not installed."
fi

log_info_box "To reinstall ncdu, run 'st system install ncdu'."
