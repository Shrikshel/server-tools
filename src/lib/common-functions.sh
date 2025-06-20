check_required_env_vars() {
  local missing_vars=()
  local config_file="$HOME/.config/.bashly.conf"

  for var in "$@"; do
    if [[ -z "${!var}" ]]; then
      log_error "Environment variable '$var' is not set."
      missing_vars+=("$var")
    fi
  done

  if (( ${#missing_vars[@]} > 0 )); then
    echo
    log_info "You can define the missing environment variables in your config file:"
    log_info "  $config_file"
    echo

    log_info "Copy and paste the following to append placeholders to your config file:"
    echo
    printf "tee -a \"%s\" > /dev/null <<'EOF'\n" "$config_file"
    for var in "${missing_vars[@]}"; do
      echo "$var="
    done
    echo "EOF"
    echo

    log_info "Then edit the file to provide the actual values."
    log_info "Finally, load it with:"
    echo "  source \"$config_file\""
    echo
    exit 1
  fi
}