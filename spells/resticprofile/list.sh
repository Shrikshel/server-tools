if [[ -z "$ST_RESTIC_PROFILES" ]]; then
  log_warn "No profiles configured."
  exit 0
fi

# Parse string into array
IFS=' ' read -r -a profiles <<< "$ST_RESTIC_PROFILES"

log_info "Available Restic Profiles:"
echo

i=1
for profile in "${profiles[@]}"; do
  printf "\033[1;36m%10s\033[0m  %s\n" "[${i}]" "$profile"
  ((i++))
done

log_success "Total: $((i - 1)) profile(s)"
echo