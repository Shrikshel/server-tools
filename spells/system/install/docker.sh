#!/usr/bin/env bash

pretty_header "Installing Docker"

if ! command -v docker &>/dev/null; then
    log_info "🔧 Installing Docker..."
    sudo apt-get update -qq
    curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh

    
    pretty_info "Please run the following commands to set up Docker permissions:"
    log_warn "sudo groupadd docker"
    log_warn "sudo usermod -aG docker $USER"
    log_warn "newgrp docker"

    log_success "🔧 Docker installation complete."
else
    log_success "✅ Docker is already installed."
fi

log_success "Docker Installed Successfully"
pretty_info "To uninstall Docker, run 'st system uninstall docker'."
