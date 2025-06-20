FULL_OUTPUT=false

if [[ "${args[--full]}" == "1" ]]; then
  FULL_OUTPUT=true
else
  FULL_OUTPUT=false
fi

log_warn "This command installs smartmontools if not already installed, scans for disks, and displays SMART information."

if ! command -v smartctl &>/dev/null; then
    log_info "🔧 Installing smartmontools..."
    sudo apt-get update -qq
    sudo apt-get install -y smartmontools
else
    log_success "✅ smartmontools already installed."
fi


mapfile -t devices < <(smartctl --scan | awk '{print $1}')

if [[ ${#devices[@]} -eq 0 ]]; then
  log_error "❌ No SMART-capable devices found."
  exit 1
fi

for dev in "${devices[@]}"; do
  echo -e "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo -e "📦 \033[1;34mSMART Info for: $dev\033[0m"
  echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  if $FULL_OUTPUT; then
    sudo smartctl -a "$dev" | GREP_COLOR='1;33' grep --color=always -E 'Model|Serial|Firmware|Capacity|Temperature|Health|Wear|Power|Reallocated|SMART|$'
  else
    sudo smartctl -a "$dev" | awk '
      /Device Model:/     { model=$0 }
      /Serial Number:/    { serial=$0 }
      /Firmware Version:/ { fw=$0 }
      /User Capacity:/    { cap=$0 }
      /SMART overall-health/ { health=$0 }
      /Temperature/       { temp=$0 }
      /Power_On_Hours/    { hours=$0 }
      /Reallocated_Sector_Ct/ { realloc=$0 }
      /Wear_Leveling_Count/ { wear=$0 }
      /Percentage Used:/  { usage=$0 }

      END {
        print "\033[1;36m🔸 " model "\033[0m"
        print "\033[1;36m🔸 " serial "\033[0m"
        print "\033[1;36m🔸 " fw "\033[0m"
        print "\033[1;36m🔸 " cap "\033[0m"
        print "\033[1;32m🔸 " health "\033[0m"
        print "\033[1;35m🔸 " temp "\033[0m"
        print "\033[1;36m🔸 " hours "\033[0m"
        print "\033[1;31m🔸 " realloc "\033[0m"
        if (wear)  print "\033[1;33m🔸 " wear "\033[0m"
        if (usage) print "\033[1;33m🔸 " usage "\033[0m"
      }
    '
  fi
done

log_info "✅ SMART report complete"