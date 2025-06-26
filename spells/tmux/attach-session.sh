# Check if tmux is installed
is_command_exist tmux

SESSION_NAME="${args[session_name]}"

# Check if session name is provided
if [ -z "$SESSION_NAME" ]; then
    echo "Please provide a session name using --session-name" >&2
    exit 1
fi

# Check if the session exists
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' not found." >&2
    exit 1
fi

# Attach to the tmux session
exec tmux attach-session -t "$SESSION_NAME"
