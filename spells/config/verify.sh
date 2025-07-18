log_debug "Verifying that ${CONFIG_FILE} has all required variables with non-empty values"

REQUIRED_VARS=("ST_PROD_STACKS_PATH" "ST_RESTIC_REPOSITORY" "ST_RESTIC_PASSWORD" "ST_RESTIC_PROFILE_FILE" "ST_RESTIC_PROFILES" "ST_TELEGRAM_BOT_TOKEN" "ST_TELEGRAM_CHAT_ID") # <-- Add required variable names here

missing_vars=()
unset_vars=()

for var in "${REQUIRED_VARS[@]}"; do
    value=$(grep -E "^${var}=" "${CONFIG_FILE}" 2>/dev/null | cut -d'=' -f2- | xargs)
    if [[ -z "$value" ]]; then
        missing_vars+=("$var")
    fi
done

if [[ ${#missing_vars[@]} -eq 0 ]]; then
    log_success "All required variables are set in ${CONFIG_FILE}."
else
    log_error "The following required variables are missing or empty in ${CONFIG_FILE}:"
    for var in "${missing_vars[@]}"; do
        log_warn "  - $var"
    done
    log_error "Run 'st config edit' to set them.."
fi
