## initialize hook
##
## Any code here will be placed inside the `initialize()` function and called
## before running anything else.
##
## You can safely delete this file if you do not need it.

# Config loading
CONFIG_FILE="${ST_CONFIG_FILE:-$HOME/.config/.bashly.conf}"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

# Header/Footer
pretty_header() {
  echo -e "\n\033[1;34m╭────────────────────────────────────────────────────────────────────────────────────────╮"
  echo -e "│  🚀 Running: $1 "
  echo -e "╰────────────────────────────────────────────────────────────────────────────────────────╯\033[0m"
}

pretty_footer() {
  echo -e "\033[1;32m╭────────────────────────────────────────────────────────────────────────────────────────╮"
  echo -e "│  ✅   $1 "
  echo -e "╰────────────────────────────────────────────────────────────────────────────────────────╯\n\033[0m"
}

pretty_warning() {
  echo -e "\033[1;33m╭────────────────────────────────────────────────────────────────────────────────────────╮"
  echo -e "│  ⚠️   $1 "
  echo -e "╰────────────────────────────────────────────────────────────────────────────────────────╯\n\033[0m"
}

pretty_error() {
  echo -e "\033[1;31m╔══════════════════════════════════════════════════════════════╗"
  echo -e "║  ❌  $1"
  echo -e "╚══════════════════════════════════════════════════════════════╝\033[0m"
}

pretty_info() {
  echo -e "\033[1;34m╭──────────────────────────────────────────────────────────────╮"
  echo -e "│   💡  $1"
  echo -e "╰─▶\033[0m"
}

pretty_info_zap() {
  echo -e "\033[1;36m⚡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━⚡"
  echo -e "   👉  $1"
  echo -e "⚡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━⚡\033[0m"
}

log_info() {
  printf "\033[1;34m%10s  %s\033[0m\n" "[INFO]" "$*"
}

log_warn() {
  printf "\033[1;33m%10s  %s\033[0m\n" "[WARN]" "$*"
}

log_error() {
  printf "\033[1;31m%10s  %s\033[0m\n" "[ERROR]" "$*"
}

log_success() {
  printf "\033[1;32m%10s  %s\033[0m\n" "[SUCCESS]" "$*"
}

log_debug() {
  printf "\033[1;90m%10s  %s\033[0m\n" "[DEBUG]" "$*"
}

log_fatal() {
  printf "\033[1;41m%10s  %s\033[0m\n" "[FATAL]" "$*"
}
