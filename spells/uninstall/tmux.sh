#!/usr/bin/env bash

#Uninstall tmux
if command -v tmux &>/dev/null; then
    log_info "🔧 Uninstalling tmux..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove --purge -y tmux
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew uninstall tmux
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_success "🔧 tmux Uninstalled Successfully"
else
    log_info "tmux is not installed."
fi

log_info_box "To reinstall tmux, run 'st system install tmux'."
