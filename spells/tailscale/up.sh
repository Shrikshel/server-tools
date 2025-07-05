# Check if tailscale is installed
is_command_exist tailscale

log_info "Bringing Tailscale up..."
sudo tailscale up
log_success "Tailscale is now up."
