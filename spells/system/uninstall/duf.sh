#!/usr/bin/env bash

if command -v duf &>/dev/null; then
    log_info "🔧 Uninstalling duf..."
    sudo apt-get remove --purge -y duf
    log_success "duf Uninstalled Successfully"
else
    log_info "duf is not installed."
fi

log_info_box "To reinstall duf, run 'st system install duf'."
