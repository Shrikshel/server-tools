#!/usr/bin/env bash

if command -v btop &>/dev/null; then
    log_debug "btop is already installed."
else
    log_info "🔧 Installing btop..."
    sudo apt-get update && sudo apt-get install -y btop
    log_success "btop Installed Successfully"
fi

log_info_box "To uninstall btop, run 'st system uninstall btop'."
