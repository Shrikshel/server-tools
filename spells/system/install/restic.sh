#!/usr/bin/env bash

# Install restic
if ! command -v restic &> /dev/null; then
    log_info "🔧 Installing restic..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt install restic -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install restic
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 restic installation complete."
else
    log_info "✅ restic is already installed."
fi

log_info_box "To uninstall restic, run 'st system uninstall restic'."