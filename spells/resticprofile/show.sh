is_command_exist restic
is_command_exist resticprofile
check_required_env_vars ST_RESTIC_PROFILE_FILE ST_RESTIC_PROFILES

log_info "Restic Profile File is located at: $ST_RESTIC_PROFILE_FILE"
print_file "$ST_RESTIC_PROFILE_FILE"

st resticprofile list