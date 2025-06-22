is_command_exist restic
is_command_exist resticprofile
check_required_env_vars RESTIC_REPOSITORY RESTIC_PASSWORD RESTIC_PROFILE

log_info "Restic Profile File is located at: $RESTIC_PROFILE"
print_file "$RESTIC_PROFILE"