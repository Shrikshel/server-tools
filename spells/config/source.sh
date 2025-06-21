log_info "Loading configuration from: ${CONFIG_FILE}"

set -a        # export all variables
CONFIG_FILE="${ST_CONFIG_FILE:-$HOME/.config/.st.conf}"
log_debug "Using config file: ${CONFIG_FILE}"
cat $CONFIG_FILE
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"
log_debug "Configuration loaded from ${CONFIG_FILE}"
set +a        # turn off auto-export