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


is_command_exist() {
  local cmd="$1"
  if ! command -v "$cmd" &> /dev/null; then
    log_error "Command '$cmd' is not installed."
    log_info "Please install it to continue."
    exit 1
  fi
  log_success "Command '$cmd' is installed."
}

print_file() {
    local file="$1"
    if command -v batcat &> /dev/null; then
        batcat "$file"
    else
        cat "$file"
    fi
}
