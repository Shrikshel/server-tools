SERVICE_NAME="${args[service]}"
# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl restart <service-name>"
    exit 1
fi

log_info "Restarting systemd service: $SERVICE_NAME"
systemctl restart "$SERVICE_NAME"
log_info "Service '$SERVICE_NAME' restarted."