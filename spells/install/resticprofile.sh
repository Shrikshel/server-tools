#!/usr/bin/env bash

#Install resticprofile
if ! command -v resticprofile &>/dev/null; then
    log_info "Installing restic profile..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -LO https://raw.githubusercontent.com/creativeprojects/resticprofile/master/install.sh
        chmod +x install.sh
        sudo ./install.sh -b /usr/local/bin
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        log_error "resticprofile is not supported on macOS. Please install it manually."
        exit 1
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
else
    log_info "resticprofile is already installed."
fi

log_info_box "To uninstall resticprofile, run 'st system uninstall resticprofile'."
