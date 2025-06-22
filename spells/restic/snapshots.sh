log_info "Checking if 'restic' command is available..."
is_command_exist restic
log_info "Checking if all required environment variables are set..."
check_required_env_vars RESTIC_REPOSITORY RESTIC_PASSWORD
log_success "All required environment variables are set."

if [[ "${args[--full]}" == "1" ]]; then
  restic snapshots
else
  restic snapshots -c
fi