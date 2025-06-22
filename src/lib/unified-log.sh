# Unified log function with colored output.
# Usage:
#   log <color_code> <label> <message>
#
# Arguments:
#   <color_code> : ANSI color code for text.
#   <label>      : Log level or custom label (right-aligned).
#   <message>    : The message to display (left-aligned).
#
# Standard foreground color codes:
#   30 = Black       90 = Bright Black (Gray)
#   31 = Red         91 = Bright Red
#   32 = Green       92 = Bright Green
#   33 = Yellow      93 = Bright Yellow
#   34 = Blue        94 = Bright Blue
#   35 = Magenta     95 = Bright Magenta
#   36 = Cyan        96 = Bright Cyan
#   37 = White       97 = Bright White
#
# Extended (256-color) example (orange, pink, teal):
#   log "38;5;208" "ORANGE"  "Orange-colored log"
#   log "38;5;213" "PINK"    "Pink-ish log"
#   log "38;5;37"  "TEAL"    "Teal-colored log"
#
# Background color example (bold red background):
#   log "1;41" "FATAL" "Something really broke"

# ─── Usage Examples ─────────────────────────────────────────────

# log 34        "INFO"     "System is starting"
# log 33        "WARN"     "Disk usage above 80%"
# log 31        "ERROR"    "Cannot connect to database"
# log 32        "SUCCESS"  "Backup completed"
# log 90        "DEBUG"    "Loaded config from ~/.myapp.conf"
# log "38;5;208" "ORANGE"   "This is an orange message"
# log "38;5;213" "PINK"     "Soft pink message"
# log "38;5;37"  "TEAL"     "Cool teal message"
# log "1;41"     "FATAL"    "Kernel panic"


log() {
  local color="$1"
  local label="$2"
  shift 2
  local message="$*"
  printf "\033[1;%sm%10s  %s\033[0m\n" "$color" "[$label]" "$message"
}

