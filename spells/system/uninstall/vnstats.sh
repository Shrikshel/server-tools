#!/usr/bin/env bash

pretty_header "Uninstalling vnstats"

if command -v vnstats &>/dev/null; then
    log_info "🔧 Uninstalling vnstats..."
    sudo apt-get remove --purge -y vnstats
else
    log_success "✅ vnstats is not installed."
fi

log_success "vnstats Uninstalled Successfully"
pretty_info "To reinstall vnstats, run 'st system install vnstats'."