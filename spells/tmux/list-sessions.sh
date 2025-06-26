# Check if tmux is installed
is_command_exist tmux

# List all tmux sessions and number them starting from 1
count=1
tmux list-sessions -F '#{session_name}' 2>/dev/null | while read -r session; do
  if [[ -n "$session" ]]; then
    log "38;5;208" "$count" "$session"
    ((count++))
  else
    log_error "No active tmux sessions found."
  fi
done
