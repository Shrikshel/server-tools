check_required_env_vars ST_TELEGRAM_BOT_TOKEN ST_TELEGRAM_CHAT_ID

MESSAGE="${args[message]}"

if [[ -z "$MESSAGE" ]]; then
    log_error "Message is required. Please provide a message using the --message option."
    log_info "Example usage:  st telegram send "Hello, World!""
    exit 1
fi

 curl -s -X POST "https://api.telegram.org/bot${ST_TELEGRAM_BOT_TOKEN}/sendMessage" \
      -d chat_id="$ST_TELEGRAM_CHAT_ID" \
      --data-urlencode text="$MESSAGE" > /dev/null

log_info "Message Sent via Telegram: $MESSAGE"