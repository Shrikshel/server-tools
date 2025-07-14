#!/usr/bin/env bash

# Install btop
if ! command -v btop &> /dev/null; then
    log_info "Installing btop..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y btop
        log_success "btop Installed Successfully"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install btop
        log_success "btop Installed Successfully"
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
else
    log_info "btop is already installed."
fi
log_info_box "To uninstall btop, run 'st system uninstall btop'."