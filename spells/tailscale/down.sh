# Check if tailscale is installed
is_command_exist tailscale

log_info "Bringing Tailscale down..."
sudo tailscale down
log_success "Tailscale is now down."