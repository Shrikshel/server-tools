#!/usr/bin/env bash

#Install ncdu
if ! command -v ncdu &>/dev/null; then
    log_info "🔧 Installing ncdu..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update -qq && sudo apt-get install -y ncdu
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ncdu
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 ncdu Installed Successfully"
else
    log_info "✅ ncdu is already installed."
fi

log_info_box "To uninstall ncdu, run 'st system uninstall ncdu'."
