local BLUE="\033[1;34m"
local GREEN="\033[1;32m"
local YELLOW="\033[1;33m"
local MAGENTA="\033[1;31m"
local CYAN="\033[1;36m"
local RED="\033[1;31m"
local BOLD="\033[1m"
local RESET="\033[0m"

echo -e "${BLUE}┌──────────────────────────────────────────────────────┐"
echo -e "│     ${CYAN}🧠 TMUX HOTKEY CHEATSHEET — CORE COMMANDS${BLUE}        │"
echo -e "└──────────────────────────────────────────────────────┘${RESET}"
echo -e "${BOLD}${GREEN}Prefix: ${RESET}${YELLOW}Ctrl+b${RESET} (hold ${YELLOW}Ctrl${RESET}, press ${YELLOW}b${RESET}, then next key)"

echo
echo -e "${YELLOW}▶ Window Management${RESET}"
echo -e "  ${MAGENTA}Ctrl+b c      ${RESET}- Create new window"
echo -e "  ${MAGENTA}Ctrl+b ,      ${RESET}- Rename current window"
echo -e "  ${MAGENTA}Ctrl+b w      ${RESET}- List all windows"
echo -e "  ${MAGENTA}Ctrl+b 0..9   ${RESET}- Switch to window number"
echo -e "  ${MAGENTA}Ctrl+b &      ${RESET}- Kill current window"
echo -e "  ${MAGENTA}Ctrl+b p / n  ${RESET}- Previous / next window"

echo
echo -e "${YELLOW}▶ Pane Management${RESET}"
echo -e "  ${MAGENTA}Ctrl+b %      ${RESET}- Split pane vertically"
echo -e "  ${MAGENTA}Ctrl+b \"      ${RESET}- Split pane horizontally"
echo -e "  ${MAGENTA}Ctrl+b o      ${RESET}- Switch to next pane"
echo -e "  ${MAGENTA}Ctrl+b ;      ${RESET}- Last active pane"
echo -e "  ${MAGENTA}Ctrl+b x      ${RESET}- Kill current pane"
echo -e "  ${MAGENTA}Ctrl+b z      ${RESET}- Toggle zoom for a pane"
echo -e "  ${MAGENTA}Ctrl+b Space  ${RESET}- Cycle pane layouts"

echo
echo -e "${YELLOW}▶ Navigating Panes${RESET}"
echo -e "  ${MAGENTA}Ctrl+b ↑↓←→   ${RESET}- Move between panes"
echo -e "  ${MAGENTA}Ctrl+b q      ${RESET}- Show pane numbers (then press to select)"
echo -e "  ${MAGENTA}Ctrl+b Ctrl+↑↓←→${RESET}- Resize panes (hold both)"

echo
echo -e "${YELLOW}▶ Other Useful Commands${RESET}"
echo -e "  ${MAGENTA}Ctrl+b d      ${RESET}- Detach from session"
echo -e "  ${MAGENTA}Ctrl+b t      ${RESET}- Show current time"
echo -e "  ${MAGENTA}Ctrl+b ?      ${RESET}- Help (all key bindings)"
echo -e "  ${MAGENTA}Ctrl+b :      ${RESET}- Command prompt (e.g., kill-pane)"

echo
echo -e "${CYAN}💡 Tip:${RESET} You can remap ${YELLOW}Ctrl+b${RESET} to something easier like ${YELLOW}Ctrl+a${RESET} in ~/.tmux.conf"
