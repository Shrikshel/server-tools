#!/usr/bin/env bash
set -e

# ========== Color Codes ==========
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ========== Config Paths ==========
REPO="Shrikshel/Server-Tools"
CONFIG_DIR="$HOME/.config"
CONFIG_FILE="$CONFIG_DIR/.st.conf"

# ========== Functions ==========

fetch_latest_release_url() {
  echo -e "${BLUE}🔍 Fetching latest release info for $REPO...${NC}"
  LATEST_URL=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" |
    grep "browser_download_url" |
    grep ".deb" |
    cut -d '"' -f 4)

  if [[ -z "$LATEST_URL" ]]; then
    echo -e "${RED}❌ Could not find .deb in the latest release.${NC}"
    exit 1
  fi

  echo -e "${YELLOW}⬇️  Downloading latest .deb from:${NC}"
  echo -e "${BLUE}$LATEST_URL${NC}"
}

download_and_install() {
  TMP_FILE=$(mktemp --suffix=.deb)
  curl -L "$LATEST_URL" -o "$TMP_FILE"

  echo -e "${YELLOW}📦 Installing...${NC}"
  sudo dpkg -i "$TMP_FILE" || sudo apt-get install -f -y
}

create_default_config_if_missing() {
  mkdir -p "$CONFIG_DIR"

  if [[ ! -f "$CONFIG_FILE" ]]; then
    touch "$CONFIG_FILE"
    echo "Created empty config at $CONFIG_FILE"
  else
    echo "Config file already exists at $CONFIG_FILE. Skipping creation."
  fi
}

install_dependencies() {
  echo -e "${YELLOW}🔧 Installing dependencies...${NC}"
  sudo apt-get update
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
  sudo apt update && sudo apt install gum
}

# ========== Configurable Defaults ==========
declare -A DEFAULT_VARS=(
  ["ST_PROD_STACKS_PATH"]=""
  ["ST_RESTIC_REPOSITORY"]=""
  ["ST_RESTIC_PASSWORD"]=""
  ["ST_RESTIC_PROFILE"]=""
)

add_missing_vars() {
  for key in "${!DEFAULT_VARS[@]}"; do
    if grep -qE "^[[:space:]]*${key}=" "$CONFIG_FILE"; then
      continue
    fi
    echo "${key}=${DEFAULT_VARS[$key]}" >>"$CONFIG_FILE"
    echo "Added '${key}=${DEFAULT_VARS[$key]}' to config."
  done
}

# ========== Main Execution ==========

fetch_latest_release_url
download_and_install
install_dependencies
create_default_config_if_missing
add_missing_vars

echo -e "${GREEN}✅ Installed successfully!${NC}"
st --help || true
