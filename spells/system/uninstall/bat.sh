#!/usr/bin/env bash

# Remove alias from .bashrc if present
if grep -q "alias bat='batcat'" ~/.bashrc 2>/dev/null; then
    sed -i "/alias bat='batcat'/d" ~/.bashrc
    log_info "Removed alias: bat -> batcat from ~/.bashrc"
fi

if command -v bat &>/dev/null || command -v batcat &>/dev/null; then
    log_info "🔧 Uninstalling bat..."
    sudo apt-get remove -y bat
    log_success "bat Uninstalled Successfully"
else
    log_debug "bat is already uninstalled."
fi

log_info_box "To install bat, run 'st system install bat'."
