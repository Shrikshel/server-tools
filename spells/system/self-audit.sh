print_header() {
  printf "\n\033[1;38;5;44m%10s  %s\033[0m\n" "[AUDIT]" "$1"
  printf "\033[38;5;240m%s\033[0m\n" "$(printf '─%.0s' {1..70})"
}

check() {
  local title="$1"
  local cmd="$2"
  local good="$3"
  local bad="$4"

  if eval "$cmd" &>/dev/null; then
    printf "\033[1;32m%10s\033[0m  %s — %s\n" "[OK]" "$title" "$good"
  else
    printf "\033[1;31m%10s\033[0m  %s — %s\n" "[FAIL]" "$title" "$bad"
  fi
}

print_info() {
  printf "\033[1;34m%10s\033[0m  %s\n" "[INFO]" "$1"
}

# ─────────────────────────────────────────────────────────────
print_header "System Info"
print_info "Hostname:  $(hostname)"
print_info "Uptime:    $(uptime -p)"
print_info "Kernel:    $(uname -r)"
print_info "OS:        $(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"

# ─────────────────────────────────────────────────────────────
print_header "Security Checks"
check "SSH Key Auth"       "grep -q '^PasswordAuthentication no' /etc/ssh/sshd_config" "Password login disabled" "Password login may be enabled"
check "Root SSH Disabled"  "grep -q '^PermitRootLogin no' /etc/ssh/sshd_config" "Root login disabled" "Root login may be allowed"
check "UFW Active"         "ufw status | grep -q 'Status: active'" "Firewall is enabled" "Firewall is disabled"
check "Fail2Ban Installed" "command -v fail2ban-client" "Fail2Ban is installed" "Fail2Ban is not found"
check "Auto Updates"       "systemctl is-enabled unattended-upgrades | grep -q enabled" "Enabled" "Not enabled"

# ─────────────────────────────────────────────────────────────
print_header "Disk & SMART Status"
check "Root Disk Usage" \
  "df -h / | awk 'NR==2 {exit (\$5+0 < 90)}'" \
  "Disk usage under 90%" \
  "Disk usage is 90% or higher"

# SMART health check (safely identify main disk first)
main_disk=$(lsblk -ndo PKNAME "$(df / | awk 'END{print $1}')" | head -n1)
smart_device="/dev/${main_disk:-sda}"

if command -v smartctl &>/dev/null; then
  check "SMART Health ($smart_device)" \
    "smartctl -H $smart_device | grep -q PASSED" \
    "SMART reports healthy" \
    "SMART check failed or not enabled"
else
  printf "\033[1;33m%10s\033[0m  smartctl not installed — cannot run SMART check\n" "[WARN]"
fi

# ─────────────────────────────────────────────────────────────
print_header "Services"
check "Cron Running" "systemctl is-active cron | grep -q active" "cron is running" "cron is not running"
check "SSH Running"  "systemctl is-active ssh | grep -q active" "ssh is running" "ssh is not running"
check "Docker Installed" "command -v docker" "Docker is installed" "Docker not found"

# ─────────────────────────────────────────────────────────────
log_info "Audit complete. Review any [FAIL] or [WARN] items above."

echo