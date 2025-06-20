#!/usr/bin/env bash

pretty_header "Uninstalling btop"

if command -v btop &>/dev/null; then
    log_info "🔧 Uninstalling btop..."
    sudo apt-get remove --purge -y btop
else
    log_success "✅ btop is not installed."
fi

pretty_footer "btop Uninstalled Successfully"
pretty_info "To reinstall btop, run 'st system install btop'."
