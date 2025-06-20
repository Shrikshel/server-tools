#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system install docker'"

if ! command -v docker &>/dev/null; then
    log_info "🔧 Installing Docker..."
    sudo apt-get update -qq
    curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh

    log_info_box "Please run the following commands to set up Docker permissions:"
    log_warn "sudo groupadd docker"
    log_warn "sudo usermod -aG docker $USER"
    log_warn "newgrp docker"

    log_success "🔧 Docker installation complete."
else
    log_info "Docker is already installed."
fi

log_info_box "To uninstall Docker, run 'st system uninstall docker'."
