is_command_exist restic
check_required_env_vars ST_RESTIC_REPOSITORY ST_RESTIC_PASSWORD


if [[ -z "${args[target]}" ]]; then
  log_error "No target specified for restore."
  exit 1
fi

if [[ -z "${args[snapshot]}" ]]; then
  log_error "No snapshot specified for restore. Using latest snapshot."
fi

restic restore "${args[snapshot]:-latest}" --target "${args[target]}"