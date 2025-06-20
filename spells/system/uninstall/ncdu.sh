#!/usr/bin/env bash

pretty_header "Uninstalling ncdu"

if command -v ncdu &>/dev/null; then
    log_info "🔧 Uninstalling ncdu..."
    sudo apt-get remove --purge -y ncdu
else
    log_success "✅ ncdu is not installed."
fi

log_success "ncdu Uninstalled Successfully"

pretty_info "To reinstall ncdu, run 'st system install ncdu'."
