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

# Check if the session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  log_error "Session '$SESSION_NAME' already exists."
fi

# Create a new tmux session with the specified name
tmux new-session -d -s "$SESSION_NAME"
log_info "Created tmux session: $SESSION_NAME"


# Prompt user to attach to the session
log_inline 31 "INPUT" "Do you want to attach to the session '$SESSION_NAME'? [Y/n]: "
read -r attach_choice

attach_choice=${attach_choice:-Y}
if [[ "$attach_choice" =~ ^[Yy]$ ]]; then
  tmux attach-session -t "$SESSION_NAME"
else
  log_info "Session '$SESSION_NAME' created but not attached."
fi
