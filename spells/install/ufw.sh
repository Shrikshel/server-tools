#!/usr/bin/env bash

#Install ufw
if ! command -v ufw &>/dev/null; then
    log_info "🔧 Installing ufw..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update -qq
        sudo apt-get install -y ufw
        log_info "🔧 Enabling ufw..."
        sudo ufw allow 22
        sudo ufw enable
        log_success "ufw Installed Successfully"
        log_info "🔧 Please run 'sudo ufw allow <port>' to allow other ports as needed. Then run 'sudo ufw enable' to enable the firewall"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        log_error "UFW is not supported on macOS. Please use the built-in firewall or another solution."
        exit 1
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi

else
    log_info "✅ ufw is already installed."
fi

log_info_box "To uninstall ufw, run 'st system uninstall ufw'."
