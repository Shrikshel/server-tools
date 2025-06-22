is_command_exist restic
is_command_exist resticprofile
check_required_env_vars ST_RESTIC_REPOSITORY ST_RESTIC_PASSWORD ST_RESTIC_PROFILE

log_info "Restic Profile File is located at: $RESTIC_PROFILE"
print_file "$RESTIC_PROFILE"