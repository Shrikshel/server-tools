
print_header() {
  printf "\n\033[1;38;5;44m%10s  %s\033[0m\n" "[AUDIT]" "$1"
  printf "\033[38;5;240m%*s\033[0m\n" "${COLUMNS:-80}" "" | tr ' ' '─'
}

check() {
  local title="$1"
  local cmd="$2"
  local good="$3"
  local bad="$4"

  if eval "$cmd" &>/dev/null; then
    printf "\033[1;32m%10s\033[0m  %s\n" "[OK]" "$title — $good"
  else
    printf "\033[1;31m%10s\033[0m  %s\n" "[FAIL]" "$title — $bad"
  fi
}

check_file() {
  local file="$1"
  local title="$2"

  if [[ -f "$file" ]]; then
    printf "\033[1;32m%10s\033[0m  %s exists\n" "[OK]" "$title"
  else
    printf "\033[1;33m%10s\033[0m  %s missing\n" "[WARN]" "$title"
  fi
}

print_header "Security Checks"
check "SSH Key Auth"       "grep -q '^PasswordAuthentication no' /etc/ssh/sshd_config" "PasswordAuthentication is disabled" "PasswordAuthentication may be enabled"
check "Root SSH Disabled"  "grep -q '^PermitRootLogin no' /etc/ssh/sshd_config" "Root login disabled" "Root login may be allowed"
check "UFW Active"         "ufw status | grep -q 'Status: active'" "Firewall is enabled" "Firewall is disabled"
check "Fail2Ban Installed" "command -v fail2ban-client" "Fail2Ban installed" "Fail2Ban not found"
check "Automatic Updates"  "systemctl is-enabled unattended-upgrades" "Auto updates enabled" "Unattended upgrades not active"

print_header "System Info"
uptime_line=$(uptime -p)
printf "\033[1;34m%10s\033[0m  Uptime: %s\n" "[INFO]" "$uptime_line"

printf "\033[1;34m%10s\033[0m  Kernel: \033[0;37m$(uname -r)\033[0m\n" "[INFO]"
printf "\033[1;34m%10s\033[0m  Hostname: \033[0;37m$(hostname)\033[0m\n" "[INFO]"
printf "\033[1;34m%10s\033[0m  OS: \033[0;37m$(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')\033[0m\n" "[INFO]"

print_header "Backup Sanity"
check_file "$HOME/.config/restic"         "Restic config dir"
check_file "$ST_RESTIC_PROFILE_FILE"      "Restic profile YAML"
check "Restic Installed"     "command -v restic" "restic is installed" "restic not found"
check "Restic Repo Accessible" "restic snapshots &>/dev/null" "Snapshots accessible" "Could not access repo"

print_header "Disk & SMART"
check "Disk Usage OK" "df / | awk 'NR==2 {exit (\$5+0 < 90)}'" "Root disk usage < 90%" "Disk space low on /"
check "SMART Enabled" "smartctl -H /dev/sda | grep -q 'PASSED'" "SMART reports healthy" "SMART health check failed"

print_header "Cron & Services"
check "Cron Service Running" "systemctl is-active cron" "cron is active" "cron is not running"
check "SSHD Running"         "systemctl is-active ssh" "SSH is active" "SSH service down"
check "Docker Installed"     "command -v docker" "Docker is installed" "Docker not found"

print_header "Summary"
log_info "Audit complete. Review any [FAIL] or [WARN] entries above."
log_info "Use 'st fix <area>' (future command) to automatically address issues."