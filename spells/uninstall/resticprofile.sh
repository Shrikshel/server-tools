#!/usr/bin/env bash

# Uninstall resticprofile
if command -v resticprofile &> /dev/null; then
    log_info "Uninstalling resticprofile..."
    sudo rm -f /usr/local/bin/resticprofile
else
    log_info "resticprofile is not installed."
fi
log_info_box "To reinstall resticprofile, run 'st system install resticprofile'."
