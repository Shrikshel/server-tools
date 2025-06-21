log_warn "Modifying Config File: ${CONFIG_FILE}"

if command -v nano &>/dev/null; then
    nano "${CONFIG_FILE}"
elif command -v vi &>/dev/null; then
    log_warn "nano is not installed. Opening with vi."
    vi "${CONFIG_FILE}"
else
    log_error "Neither nano nor vi is installed. Please install nano for easier editing: sudo apt install nano"
fi