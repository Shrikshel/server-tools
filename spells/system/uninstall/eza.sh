#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system uninstall eza'"

if command -v eza &>/dev/null; then
    log_info "🔧 Uninstalling eza..."
    sudo apt-get remove --purge -y eza
    log_success "eza Uninstalled Successfully"
else
    log_info "eza is not installed."
fi

log_info_box "To reinstall eza, run 'st system install eza'."
