#!/usr/bin/env bash

pretty_header "Uninstalling eza"

if command -v eza &>/dev/null; then
    log_info "🔧 Uninstalling eza..."
    sudo apt-get remove --purge -y eza
else
    log_success "✅ eza is not installed."
fi

pretty_footer "eza Uninstalled Successfully"
pretty_info "To reinstall eza, run 'st system install eza'."
