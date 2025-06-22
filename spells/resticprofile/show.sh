log_info "Checking if 'restic' command is available..."
is_command_exist restic
is_command_exist resticprofile
log_info "Checking if all required environment variables are set..."
check_required_env_vars RESTIC_REPOSITORY RESTIC_PASSWORD RESTIC_PROFILE
log_success "All required environment variables are set."


log_info "Restic Profile File is located at: $RESTIC_PROFILE"
print_file "$RESTIC_PROFILE"