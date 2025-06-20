#!/usr/bin/env bash
set -e

REPO="Shrikshel/Server-Tools"

echo "🔍 Fetching latest release info for $REPO..."
LATEST_URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest \
  | grep "browser_download_url" \
  | grep ".deb" \
  | cut -d '"' -f 4)

if [[ -z "$LATEST_URL" ]]; then
  echo "❌ Could not find .deb in the latest release."
  exit 1
fi

echo "⬇️  Downloading latest .deb from:"
echo "$LATEST_URL"

TMP_FILE=$(mktemp --suffix=.deb)
curl -L "$LATEST_URL" -o "$TMP_FILE"

echo "📦 Installing..."
sudo dpkg -i "$TMP_FILE" || sudo apt-get install -f -y

echo "✅ Installed successfully!"
st --help || true
