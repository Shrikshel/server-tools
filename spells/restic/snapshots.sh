is_command_exist restic
check_required_env_vars RESTIC_REPOSITORY RESTIC_PASSWORD


if [[ "${args[--full]}" == "1" ]]; then
  restic snapshots
else
  restic snapshots -c
fi