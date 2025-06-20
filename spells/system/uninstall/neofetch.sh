#!/usr/bin/env bash

if command -v neofetch &>/dev/null; then
    log_info "🔧 Uninstalling neofetch..."
    sudo apt-get remove --purge -y neofetch
    log_success "neofetch Uninstalled Successfully"
else
    log_info "neofetch is not installed."
fi

log_info_box "To reinstall neofetch, run 'st system install neofetch'."
