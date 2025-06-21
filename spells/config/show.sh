log_info "Config File is Located at: ${CONFIG_FILE}"

if [[ -f "$CONFIG_FILE" ]]; then
    grep -E '^[A-Za-z_][A-Za-z0-9_]*=' "$CONFIG_FILE" | while IFS= read -r line; do
        echo "$line"
    done
else
    log_error "Config file not found: $CONFIG_FILE"
fi

