#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system uninstall ufw'"

if command -v ufw &>/dev/null; then
    log_info "🔧 Uninstalling ufw..."
    sudo apt-get remove --purge -y ufw
else
    log_success "✅ ufw is not installed."
fi

log_success "ufw Uninstalled Successfully"
log_info_box "To reinstall ufw, run 'st system install ufw'."