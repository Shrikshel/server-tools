
log_info "Reloading daemon to apply systemd unit file changes"
systemctl daemon-reload
log_info "Daemon reloaded successfully."