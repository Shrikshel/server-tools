#!/usr/bin/env bash

pretty_header "Uninstalling neofetch"

if command -v neofetch &>/dev/null; then
    log_info "🔧 Uninstalling neofetch..."
    sudo apt-get remove --purge -y neofetch
else
    log_success "✅ neofetch is not installed."
fi

log_success "neofetch Uninstalled Successfully"
pretty_info "To reinstall neofetch, run 'st system install neofetch'."