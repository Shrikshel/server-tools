#!/usr/bin/env bash

# Install bat
if command -v bat &>/dev/null || command -v batcat &>/dev/null; then
    log_debug "bat or batcat is already installed."
else
    log_info "🔧 Installing bat..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y bat
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install bat
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
        log_success "🔧 bat Installed Successfully"
fi

# Add alias if not already present
if ! grep -q 'alias bat=' ~/.bashrc 2>/dev/null; then
    echo "alias bat='batcat'" >> ~/.bashrc
    log_info "Added alias: bat -> batcat to ~/.bashrc"
else
    log_debug "Alias for bat already present in ~/.bashrc"
fi

log_info_box "To uninstall bat, run 'st system uninstall bat'."
