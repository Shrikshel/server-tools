#!/usr/bin/env bash

pretty_header "Uninstalling duf"

if command -v duf &>/dev/null; then
    log_info "🔧 Uninstalling duf..."
    sudo apt-get remove --purge -y duf
else
    log_success "✅ duf is not installed."
fi

pretty_footer "duf Uninstalled Successfully"
pretty_info "To reinstall duf, run 'st system install duf'."
