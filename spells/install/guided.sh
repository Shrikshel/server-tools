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
  log_info "\n🧑‍💻 Welcome to the Server Tools Guided Installer!"
  log_info "This wizard will help you install popular server utilities one by one."
  log_info

  for pkg in "${PACKAGES[@]}"; do
    desc="${DESCRIPTIONS[$pkg]}"
    if ! st "$pkg" --version &>/dev/null && ! command -v "$pkg" &>/dev/null; then
      gum confirm "Install $pkg — $desc?" && st install "$pkg"
      echo
    else
      log_info "$pkg is already installed. Skipping."
    fi
  done

  log_success "✅ Guided installation complete!"
}

main "$@"
