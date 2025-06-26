#!/usr/bin/env bash

log_info "Updating server-tools from GitHub..."

UPDATE_URL="https://raw.githubusercontent.com/Shrikshel/server-tools/main/scripts/install.sh"

if command -v curl &>/dev/null; then
  curl -fsSL "$UPDATE_URL" | bash
  log_success "Server Tools CLI Updated Successfully"
elif command -v wget &>/dev/null; then
  wget -qO- "$UPDATE_URL" | bash
  log_success "Server Tools CLI Updated Successfully"
else
  log_error "Neither curl nor wget is available to perform the update."
  exit 1
fi
