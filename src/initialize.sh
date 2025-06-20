## initialize hook
##
## Any code here will be placed inside the `initialize()` function and called
## before running anything else.
##
## You can safely delete this file if you do not need it.

# Config loading
CONFIG_FILE="${ST_CONFIG_FILE:-$HOME/.config/.bashly.conf}"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

source "./src/lib/log.sh"