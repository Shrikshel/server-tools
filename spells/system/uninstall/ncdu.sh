#!/usr/bin/env bash

#Uninstall ncdu
if command -v ncdu &>/dev/null; then
    log_info "🔧 Uninstalling ncdu..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove --purge -y ncdu
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall ncdu
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 ncdu Uninstalled Successfully"
else
    log_info "ncdu is not installed."
fi

log_info_box "To reinstall ncdu, run 'st system install ncdu'."
