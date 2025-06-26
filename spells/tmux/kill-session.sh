# Check if tmux is installed
is_command_exist tmux

SESSION_NAME="${args[session_name]}"

# Check if session name is provided
if [ -z "$SESSION_NAME" ]; then
    log_info "Please provide a session name using --session-name" >&2
    exit 1
fi

# Check if the session exists
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    log_error "Session '$SESSION_NAME' not found." >&2
    exit 1
fi

# Kill the tmux session
if tmux kill-session -t "$SESSION_NAME" 2>/dev/null; then
    log_info "Session '$SESSION_NAME' killed."
else
    log_error "Failed to kill session '$SESSION_NAME'." >&2
    exit 1
fi
