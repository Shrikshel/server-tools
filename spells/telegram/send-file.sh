check_required_env_vars ST_TELEGRAM_BOT_TOKEN ST_TELEGRAM_CHAT_ID

filePath="${args[file_path]}"

if [[ -z "$filePath" ]]; then
    log_error "File path is required. Please provide a file path using the --file-path option."
    log_info "Example usage: st telegram send-file --file-path /path/to/file"
fi

curl -s -X POST "https://api.telegram.org/bot${ST_TELEGRAM_BOT_TOKEN}/sendDocument" \
    -F chat_id="$ST_TELEGRAM_CHAT_ID" \
    -F document=@"$filePath" >/dev/null

log_info "File Sent via Telegram: $filePath"
