#!/usr/bin/env bash

log_info "Uninstalling Server Tools CLI..."

UNINSTALL_URL="https://raw.githubusercontent.com/Shrikshel/server-tools/main/scripts/uninstall.sh"

if command -v curl &>/dev/null; then
  curl -fsSL "$UNINSTALL_URL" | bash
  log_success "Server Tools CLI Uninstalled Successfully"
elif command -v wget &>/dev/null; then
  wget -qO- "$UNINSTALL_URL" | bash
  log_success "Server Tools CLI Uninstalled Successfully"
else
  log_error "Neither curl nor wget is available to perform the update."
  exit 1
fi
