SERVICE_NAME="${args[service]}"
# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl start <service-name>"
    exit 1
fi

log_info "Starting systemd service: $SERVICE_NAME"
systemctl start "$SERVICE_NAME"
log_info "Service '$SERVICE_NAME' started."