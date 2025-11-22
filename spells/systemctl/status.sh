SERVICE_NAME="${args[service]}"

# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl status <service-name>"
    exit 1
fi

log_info "Checking status of systemd service: $SERVICE_NAME"


systemctl status "$SERVICE_NAME" --no-pager

log_info "Status check completed."