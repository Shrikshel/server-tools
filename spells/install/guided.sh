#!/usr/bin/env bash
set -e

# Guided installer for st install
# Requires gum for interactive prompts
if ! command -v gum &>/dev/null; then
  echo "❌ gum is not installed. Please install it first." >&2
  exit 1
fi

# List of installable packages (keep in sync with st UI)
PACKAGES=(
  bat
  btop
  docker
  duf
  eza
  ncdu
  neofetch
  rclone
  restic
  resticprofile
  tmux
  ufw
  vnstat
)

declare -A DESCRIPTIONS=(
  [bat]="Cat with wings"
  [btop]="Resource monitor"
  [docker]="Docker runtime"
  [duf]="Disk utility frontend"
  [eza]="Modern ls alternative"
  [ncdu]="Disk usage visualizer"
  [neofetch]="System summary"
  [rclone]="Cloud sync"
  [restic]="Restic backup"
  [resticprofile]="Profile wrapper"
  [tmux]="Terminal multiplexer"
  [ufw]="Firewall manager"
  [vnstat]="Network monitor"
)

main() {
  echo "\n🧑‍💻 Welcome to the Server Tools Guided Installer!"
  echo "This wizard will help you install popular server utilities one by one."
  echo

  for pkg in "${PACKAGES[@]}"; do
    desc="${DESCRIPTIONS[$pkg]}"
    gum confirm "Install $pkg — $desc?" && st install "$pkg"
    echo
  done

  echo "✅ Guided installation complete!"
}

main "$@"
