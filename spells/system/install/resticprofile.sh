#!/usr/bin/env bash

if ! command -v resticprofile &>/dev/null; then
    log_info "Installing restic profile..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -LO https://raw.githubusercontent.com/creativeprojects/resticprofile/master/install.sh
        chmod +x install.sh
        sudo ./install.sh -b /usr/local/bin
    fi
else
    log_info "resticprofile is already installed."
fi

log_info_box "To uninstall resticprofile, run 'st system uninstall resticprofile'."
