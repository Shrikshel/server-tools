#!/usr/bin/env bash
set -e

# Ensure gum is installed
if ! command -v gum &>/dev/null; then
  echo "❌ gum is not installed. Please install it first." >&2
  exit 1
fi

# -------------------------------
# Ordered Menu Definitions
# -------------------------------

MAIN_MENU_ORDER=(system docker network ssh rclone restic resticprofile tmux tailscale config)

declare -A COMMAND_GROUPS=(
  [system]="System management utilities"
  [docker]="Docker container tools"
  [network]="Network helper utilities"
  [ssh]="SSH key management"
  [rclone]="Cloud sync via Rclone"
  [restic]="Backups with Restic"
  [resticprofile]="Restic profile manager"
  [tmux]="Tmux session manager"
  [tailscale]="Tailscale VPN management"
  [config]="Tool configuration"
)

# Ordered subcommand lists per group
declare -A SUBCOMMANDS_order_system=( [0]=info [1]=smart [2]=disk [3]=update [4]=upgrade [5]=update-upgrade [6]=install [7]=uninstall )
declare -A SUBCOMMANDS_order_docker=( [0]=compose [1]=stop-all [2]=start-all [3]=manage-stacks )
declare -A SUBCOMMANDS_order_network=( [0]=interfaces [1]=linkspeed [2]=speedtest [3]=publicip [4]=localip [5]=wifiinfo )
declare -A SUBCOMMANDS_order_ssh=( [0]=keygen )
declare -A SUBCOMMANDS_order_rclone=( [0]=dry-sync [1]=sync )
declare -A SUBCOMMANDS_order_restic=( [0]=snapshots [1]=check [2]=restore )
declare -A SUBCOMMANDS_order_resticprofile=( [0]=show [1]=snapshots [2]=stats [3]=forget [4]=list )
declare -A SUBCOMMANDS_order_tmux=( [0]=list-sessions [1]=new-session [2]=attach-session [3]=kill-session [4]=cheatsheet )
declare -A SUBCOMMANDS_order_tailscale=( [0]=up [1]=down [2]=status )
declare -A SUBCOMMANDS_order_config=( [0]=show [1]=edit [2]=verify [3]=source )

# Subcommand descriptions per group
declare -A SUBCOMMANDS_system=(
  [info]="System info"
  [smart]="SSD SMART status"
  [disk]="Disk usage"
  [update]="Update packages"
  [upgrade]="Upgrade packages"
  [update-upgrade]="Update and upgrade"
  [install]="Install packages"
  [uninstall]="Uninstall packages"
)
declare -A SUBCOMMANDS_docker=(
  [compose]="Docker Compose utilities"
  [stop-all]="Stop all containers"
  [start-all]="Start all containers"
  [manage-stacks]="Manage Compose stacks"
)
declare -A SUBCOMMANDS_network=(
  [interfaces]="Show interfaces"
  [linkspeed]="Link speed"
  [speedtest]="Speed test"
  [publicip]="Public IP"
  [localip]="Local IP"
  [wifiinfo]="Wi-Fi info"
)
declare -A SUBCOMMANDS_ssh=( [keygen]="Generate SSH keys" )
declare -A SUBCOMMANDS_rclone=( [dry-sync]="Dry sync" [sync]="Perform sync" )
declare -A SUBCOMMANDS_restic=( [snapshots]="List snapshots" [check]="Check repository" [restore]="Restore from backup" )
declare -A SUBCOMMANDS_resticprofile=(
  [show]="Show profile"
  [snapshots]="Profile snapshots"
  [stats]="Profile stats"
  [forget]="Forget/prune old backups"
  [list]="List profiles"
)
declare -A SUBCOMMANDS_tmux=(
  [list-sessions]="List tmux sessions"
  [new-session]="New tmux session"
  [attach-session]="Attach to session"
  [kill-session]="Kill tmux session"
  [cheatsheet]="Tmux cheatsheet"
)
declare -A SUBCOMMANDS_tailscale=(
  [up]="Bring Tailscale up"
  [down]="Bring Tailscale down"
  [status]="Show Tailscale status"
)
declare -A SUBCOMMANDS_config=( [show]="Show config" [edit]="Edit config" [verify]="Verify config" [source]="Source config" )

# Installable packages
INSTALL_ORDER=(btop htop neofetch ncdu duf vnstat ufw bat docker restic rclone resticprofile eza)
declare -A INSTALLABLE_PACKAGES=(
  [btop]="Resource monitor"
  [htop]="Process viewer"
  [neofetch]="System summary"
  [ncdu]="Disk usage visualizer"
  [duf]="Disk utility frontend"
  [vnstat]="Network monitor"
  [ufw]="Firewall manager"
  [bat]="Cat with wings"
  [docker]="Docker runtime"
  [restic]="Restic backup"
  [rclone]="Cloud sync"
  [resticprofile]="Profile wrapper"
  [eza]="Modern ls alternative"
)

# -------------------------------
# UI Helpers
# -------------------------------

pad() {
  printf "%-15s: %s" "$1" "$2"
}

build_menu_ordered() {
  local -n order_ref=$1
  local -n desc_ref=$2
  local items=()
  for key in "${order_ref[@]}"; do
    items+=("$(pad "$key" "${desc_ref[$key]}")")
  done
  printf "%s\n" "${items[@]}"
}

invoke_command() {
  local group sub arg
  group="$(echo "$1" | xargs)"
  sub="$(echo "$2" | xargs)"
  arg="$(echo "$3" | xargs)"
  local func="cmd::${group}_${sub}"
  if declare -f "$func" &>/dev/null; then
    $func "$arg"
  else
    echo "⚠️ No function handler for '$group $sub'" >&2
  fi
}

# -------------------------------
# Main UI Loop
# -------------------------------

main_loop() {
  while true; do
    mapfile -t menu_items < <(build_menu_ordered MAIN_MENU_ORDER COMMAND_GROUPS)
    menu_items+=("exit: Quit")
    main_choice=$(gum choose "${menu_items[@]}")
    group="$(echo "${main_choice%%:*}" | xargs)"
    [[ "$group" == "exit" ]] && echo "👋 Goodbye!" && exit 0

    sub_order="SUBCOMMANDS_order_${group}"
    sub_desc="SUBCOMMANDS_${group}"
    declare -n order_arr="$sub_order"
    declare -n desc_map="$sub_desc"

    while true; do
      mapfile -t sub_items < <(build_menu_ordered order_arr desc_map)
      sub_items+=("back: Return")
      sub_choice=$(gum choose "${sub_items[@]}")
      sub="$(echo "${sub_choice%%:*}" | xargs)"
      [[ "$sub" == "back" ]] && break

      if [[ "$group" == "system" && "$sub" =~ ^(install|uninstall)$ ]]; then
        mapfile -t pkg_items < <(build_menu_ordered INSTALL_ORDER INSTALLABLE_PACKAGES)
        pkg_items+=("back: Cancel")
        pkg_choice=$(gum choose "${pkg_items[@]}")
        pkg="$(echo "${pkg_choice%%:*}" | xargs)"
        [[ "$pkg" == "back" ]] && continue
        invoke_command "$group" "$sub" "$pkg"
      else
        invoke_command "$group" "$sub"
      fi

      echo
      gum confirm "Run another $group command?" || break
    done
  done
}

# -------------------------------
# Function Handlers (call st)
# -------------------------------

cmd::system_info()          { st system info; }
cmd::system_smart()         { st system smart; }
cmd::system_disk()          { st system disk; }
cmd::system_update()        { st system update; }
cmd::system_upgrade()       { st system upgrade; }
cmd::system_update-upgrade(){ st system update-upgrade; }
cmd::system_install()       { st system install "$1"; }
cmd::system_uninstall()     { st system uninstall "$1"; }

cmd::docker_compose()       { st docker compose; }
cmd::docker_stop-all()      { st docker compose stop-all; }
cmd::docker_start-all()     { st docker compose start-all; }
cmd::docker_manage-stacks() { st docker compose manage-stacks; }

cmd::network_interfaces()   { st network interfaces; }
cmd::network_linkspeed()    { st network linkspeed; }
cmd::network_speedtest()    { st network speedtest; }
cmd::network_publicip()     { st network publicip; }
cmd::network_localip()      { st network localip; }
cmd::network_wifiinfo()     { st network wifiinfo; }

cmd::ssh_keygen()           { st ssh keygen; }

# cmd::rclone_dry-sync()      { st rclone dry-sync; }
# cmd::rclone_sync()          { st rclone sync; }

cmd::restic_snapshots()     { st restic snapshots; }
cmd::restic_check()         { st restic check; }
cmd::restic_restore()       { st restic restore; }

cmd::resticprofile_show()   { st resticprofile show; }
cmd::resticprofile_snapshots() { st resticprofile snapshots; }
cmd::resticprofile_stats() { st resticprofile stats; }
cmd::resticprofile_forget() { st resticprofile forget; }
cmd::resticprofile_list() { st resticprofile list; }

cmd::config_show()          { st config show; }
cmd::config_edit()          { st config edit; }
cmd::config_verify()        { st config verify; }
cmd::config_source()        { st config source; }

cmd::tmux_list-sessions()   { st tmux list-sessions; }
cmd::tmux_new-session()     { st tmux new-session; }
cmd::tmux_attach-session()  { st tmux attach-session; }
cmd::tmux_kill-session()    { st tmux kill-session; }
cmd::tmux_cheatsheet()      { st tmux cheatsheet; }

cmd::tailscale_up()      { st tailscale up; }
cmd::tailscale_down()    { st tailscale down; }
cmd::tailscale_status()  { st tailscale status; }

cmd::rclone_dry-sync() {
  if ! command -v rclone &>/dev/null; then
    echo "❌ rclone is not installed. Please install it first."
    return 1
  fi

  local source target
  source=$(gum input --placeholder "Enter source path" --prompt "📂 Source: ") || return
  [[ -z "$source" ]] && echo "❌ Source is required." && return

  target=$(gum input --placeholder "Enter target path" --prompt "📁 Target: ") || return
  [[ -z "$target" ]] && echo "❌ Target is required." && return

  echo -e "\n🔄 Sync plan:"
  echo "Source ➜ $source"
  echo "Target ➜ $target"
  echo

  gum confirm "Proceed with dry-sync?" && st rclone dry-sync "$source" "$target"
}

cmd::rclone_sync() {
  if ! command -v rclone &>/dev/null; then
    echo "❌ rclone is not installed. Please install it first."
    return 1
  fi

  local source target
  source=$(gum input --placeholder "Enter source path" --prompt "📂 Source: ") || return
  [[ -z "$source" ]] && echo "❌ Source is required." && return

  target=$(gum input --placeholder "Enter target path" --prompt "📁 Target: ") || return
  [[ -z "$target" ]] && echo "❌ Target is required." && return

  echo -e "\n🚀 Sync plan:"
  echo "Source ➜ $source"
  echo "Target ➜ $target"
  echo

  gum confirm "Proceed with full sync?" && st rclone sync "$source" "$target"
}

# -------------------------------
# Launch
# -------------------------------
main_loop
