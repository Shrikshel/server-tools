#!/usr/bin/env bash

# Install vnstat
if ! command -v vnstat &>/dev/null; then
    log_info "🔧 Installing vnstat..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update -qq && sudo apt-get install -y vnstat
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install vnstat
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 vnstat Installed Successfully"
else
    log_info "✅ vnstat is already installed."
fi

log_info_box "To uninstall vnstat, run 'st system uninstall vnstat'."
