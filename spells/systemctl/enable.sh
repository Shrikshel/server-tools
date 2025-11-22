SERVICE_NAME="${args[service]}"
# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl enable <service-name>"
    exit 1
fi

log_info "Enabling systemd service to start on boot: $SERVICE_NAME"
systemctl enable "$SERVICE_NAME"
log_info "Service '$SERVICE_NAME' enabled to start on boot."