log_info "Running Local (LAN) IP Check..."
ip=$(hostname -I | awk '{print $1}')    
log_success "Your local (LAN) IP address is: $ip"