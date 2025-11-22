log_info "Listing all systemd services:"
systemctl list-units --type=service --all --no-pager
log_info "Service listing completed."
