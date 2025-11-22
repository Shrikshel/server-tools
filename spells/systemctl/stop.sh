SERVICE_NAME="${args[service]}"

# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl stop <service-name>"
    exit 1
fi

log_info "Stopping systemd service: $SERVICE_NAME"
systemctl stop "$SERVICE_NAME"
log_info "Service '$SERVICE_NAME' stopped."