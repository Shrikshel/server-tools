#!/usr/bin/env bash

# Remove alias from .bashrc if present
if grep -q "alias bat='batcat'" ~/.bashrc 2>/dev/null; then
    sed -i "/alias bat='batcat'/d" ~/.bashrc
    log_info "Removed alias: bat -> batcat from ~/.bashrc"
fi

if command -v bat &>/dev/null || command -v batcat &>/dev/null; then
    log_info "🔧 Uninstalling bat..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove -y bat
        log_success "bat Uninstalled Successfully"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall bat
        log_success "bat Uninstalled Successfully"
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
else
    log_debug "bat is already uninstalled."
fi

log_info_box "To install bat, run 'st system install bat'."
