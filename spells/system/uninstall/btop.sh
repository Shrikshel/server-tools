#!/usr/bin/env bash

log_info_zap "🚧 Executing Command 'st system uninstall btop'"

if command -v btop &>/dev/null; then
    sudo apt-get remove --purge -y btop
    log_debug "btop Uninstalled Successfully"
else
    log_info "btop is not installed."
fi

log_info_box "To reinstall btop, run 'st system install btop'."