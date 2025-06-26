# Ensure tmux is installed
is_command_exist tmux

SESSION_NAME="${args[session_name]}"

# If no session name provided, prompt interactively
if [ -z "$SESSION_NAME" ]; then
    mapfile -t sessions < <(tmux list-sessions -F '#S' 2>/dev/null)

    if [ "${#sessions[@]}" -eq 0 ]; then
        log_error "No active tmux sessions found."
        exit 1
    fi

    echo
    log_info "Active tmux sessions:"
    for i in "${!sessions[@]}"; do
        index=$((i + 1))
        log "38;5;208" "$index" "${sessions[$i]}"
    done
    echo
    
    # read -rp "Enter the number or name of the session to kill: " selection
    log_inline 31 "INPUT" "Enter the number or name of the session to kill: "
    read -r selection

    # Convert number to name if input is numeric
    if [[ "$selection" =~ ^[0-9]+$ ]]; then
        idx=$((selection - 1))
        if [ "$idx" -ge 0 ] && [ "$idx" -lt "${#sessions[@]}" ]; then
            SESSION_NAME="${sessions[$idx]}"
        else
            log_error "Invalid session number."
            exit 1
        fi
    else
        # Assume it's a name
        SESSION_NAME="$selection"
    fi
fi

# Check if the selected session exists
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    log_error "Session '$SESSION_NAME' not found."
    exit 1
fi

# Attempt to kill the session
if tmux kill-session -t "$SESSION_NAME" 2>/dev/null; then
    log_info "Session '$SESSION_NAME' killed."
    echo
else
    log_error "Failed to kill session '$SESSION_NAME'."
    exit 1
fi
