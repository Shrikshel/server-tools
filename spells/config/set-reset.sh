set -e

log_info "Config File is Located at: ${CONFIG_FILE}"

# Step 1: Validate config exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  log_error "Config file not found: $CONFIG_FILE"
  exit 1
fi

# Step 2: Load all variables
mapfile -t config_lines < <(grep -E '^[A-Za-z_][A-Za-z0-9_]*=' "$CONFIG_FILE")

if [[ ${#config_lines[@]} -eq 0 ]]; then
  log_warn "No variables found in config file."
  exit 1
fi

# Step 3: Display numbered list
log_info "Select a variable to update:"
for i in "${!config_lines[@]}"; do
  var_name=$(cut -d= -f1 <<< "${config_lines[$i]}")
  var_value=$(cut -d= -f2- <<< "${config_lines[$i]}")
  printf "\033[1;36m%3d)\033[0m %-35s = %s\n" "$((i+1))" "$var_name" "$var_value"
done

# Step 4: Read selection
echo
read -rp "$(log_inline 31 "INPUT" "Enter number of variable to change: ")" selection
if ! [[ "$selection" =~ ^[0-9]+$ ]] || (( selection < 1 || selection > ${#config_lines[@]} )); then
  log_error "Invalid selection."
  exit 1
fi

# Step 5: Prompt for new value
chosen_line="${config_lines[$((selection-1))]}"
var_name=$(cut -d= -f1 <<< "$chosen_line")

read -rp "$(log_inline 31 "INPUT" "Enter new value for $var_name: ")" new_value
if [[ -z "$new_value" ]]; then
  log_warn "Empty value entered. Aborting."
  exit 1
fi

# Step 6: Replace line in-place
sed -i "s|^${var_name}=.*|${var_name}=${new_value}|" "$CONFIG_FILE"
log_success "Updated ${var_name} in $CONFIG_FILE"