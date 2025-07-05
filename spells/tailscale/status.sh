# Check if tailscale is installed
is_command_exist tailscale

log_info "Showing Tailscale status..."
sudo tailscale status
