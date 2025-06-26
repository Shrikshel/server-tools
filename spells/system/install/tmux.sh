#!/usr/bin/env bash

# Install tmux
if ! command -v tmux &> /dev/null; then
    log_info "🔧 Installing tmux..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt install tmux -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install tmux
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 tmux installation complete."
else
    log_info "✅ tmux is already installed."
fi

log_info_box "To uninstall tmux, run 'st system uninstall tmux'."