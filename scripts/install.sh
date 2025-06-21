#!/usr/bin/env bash
set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

REPO="Shrikshel/Server-Tools"

echo -e "${BLUE}🔍 Fetching latest release info for $REPO...${NC}"
LATEST_URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest \
  | grep "browser_download_url" \
  | grep ".deb" \
  | cut -d '"' -f 4)

if [[ -z "$LATEST_URL" ]]; then
  echo -e "${RED}❌ Could not find .deb in the latest release.${NC}"
  exit 1
fi

echo -e "${YELLOW}⬇️  Downloading latest .deb from:${NC}"
echo -e "${BLUE}$LATEST_URL${NC}"

TMP_FILE=$(mktemp --suffix=.deb)
curl -L "$LATEST_URL" -o "$TMP_FILE"

echo -e "${YELLOW}📦 Installing...${NC}"
sudo dpkg -i "$TMP_FILE" || sudo apt-get install -f -y

CONFIG_DIR="$HOME/.config"
CONFIG_FILE="$CONFIG_DIR/.st.conf"
mkdir -p "$CONFIG_DIR"
cat > "$CONFIG_FILE" <<EOL
# Environment variables for Server Tools
ST_PROD_STACKS_PATH=
# Add more variables below as needed
EOL

echo -e "${GREEN}Created config file at $CONFIG_FILE with example variables.${NC}"

echo -e "${GREEN}✅ Installed successfully!${NC}"
st --help || true
