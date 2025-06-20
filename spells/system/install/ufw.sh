#!/usr/bin/env bash

pretty_header "🚀 Installing ufw"

if ! command -v ufw &>/dev/null; then
    log_info "🔧 Installing ufw..."
    sudo apt-get update -qq
    sudo apt-get install -y ufw
    log_info "🔧 Enabling ufw..."
    sudo ufw allow 22
    sudo ufw enable
    log_info "🔧 Please run 'sudo ufw allow <port>' to allow other ports as needed. Then run 'sudo ufw enable' to enable the firewall"
else
    log_success "✅ ufw is already installed."
fi

log_success "ufw Installed Successfully"
pretty_info "To uninstall ufw, run 'st system uninstall ufw'."
