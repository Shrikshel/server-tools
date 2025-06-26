# Check if tmux is installed
is_command_exist tmux

# Predefined sorted array of 3-character session names
local session_names=(app bat elf fox gem hex ion neo ora zen)

SESSION_NAME="${args[session_name]}"

if [[ -z "$SESSION_NAME" ]]; then
  for name in "${session_names[@]}"; do
    if ! tmux has-session -t "$name" 2>/dev/null; then
      SESSION_NAME="$name"
      log_error "No session name provided. Using random session name: $SESSION_NAME"
      break
    fi
  done

  if [[ -z "$SESSION_NAME" ]]; then
    log_error "No available session names left. Please provide a session name using --session-name"
  fi
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  log_error "Session '$SESSION_NAME' already exists."
fi

tmux new-session -d -s "$SESSION_NAME"
log_info "Created tmux session: $SESSION_NAME"
