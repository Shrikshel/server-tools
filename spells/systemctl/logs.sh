SERVICE_NAME="${args[service]}"
# Check argument
if [[ -z "$SERVICE_NAME" ]]; then
    log_error "Please provide a service name. Usage: systemctl logs <service-name>"
    exit 1
fi

log_info "Fetching logs for systemd service: $SERVICE_NAME"
journalctl -u "$SERVICE_NAME" --no-pager
log_info "Logs fetched."

log_warn "Note: You can use 'journalctl -u $SERVICE_NAME -f' to follow the logs in real-time."

log_info "Do you want to do that now? (y/n)"
read -r FOLLOW_LOGS
if [[ "$FOLLOW_LOGS" != "y" && "$FOLLOW_LOGS" != "Y" ]]; then
    log_info "Exiting without following logs."
    exit 0
else
    log_info "Following logs for service: $SERVICE_NAME"
    journalctl -u "$SERVICE_NAME" -f
fi