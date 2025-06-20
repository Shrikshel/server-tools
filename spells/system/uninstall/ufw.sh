#!/usr/bin/env bash

if command -v ufw &>/dev/null; then
    log_info "🔧 Uninstalling ufw..."
    sudo apt-get remove --purge -y ufw
    log_info "ufw Uninstalled Successfully"
else
    log_info "ufw is not installed."
fi

log_info_box "To reinstall ufw, run 'st system install ufw'."
