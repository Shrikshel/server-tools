SERVICE_NAME="${args[service]}"
# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl disable <service-name>"
    exit 1
fi

log_info "Disabling systemd service from starting on boot: $SERVICE_NAME"
systemctl disable "$SERVICE_NAME"
log_info "Service '$SERVICE_NAME' disabled from starting on boot."