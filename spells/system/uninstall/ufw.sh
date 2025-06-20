#!/usr/bin/env bash

pretty_header "Uninstalling ufw"

if command -v ufw &>/dev/null; then
    log_info "🔧 Uninstalling ufw..."
    sudo apt-get remove --purge -y ufw
else
    log_success "✅ ufw is not installed."
fi

log_success "ufw Uninstalled Successfully"
pretty_info "To reinstall ufw, run 'st system install ufw'."