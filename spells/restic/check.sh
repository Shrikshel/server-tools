log_info "Checking if 'restic' command is available..."
chceck_command_exists restic
log_info "Checking if all required environment variables are set..."
check_required_env_vars RESTIC_REPOSITORY RESTIC_PASSWORD
log_success "All required environment variables are set."

restic check