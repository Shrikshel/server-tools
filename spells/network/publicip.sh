log_info "Running Public IP Check..."
ip=$(curl -s https://api.ipify.org)
log_success "Your public IP address is: $ip"