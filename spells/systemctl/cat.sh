SERVICE_NAME="${args[service]}"
# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl cat <service-name>"
    exit 1
fi

log_info "Displaying unit file for systemd service: $SERVICE_NAME"
systemctl cat "$SERVICE_NAME"
log_info "Displayed unit file for service '$SERVICE_NAME'."