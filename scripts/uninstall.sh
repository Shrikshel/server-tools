#!/usr/bin/env bash
set -e

PKG_NAME="st"

if dpkg -s "$PKG_NAME" &> /dev/null; then
  echo "📦 Uninstalling $PKG_NAME..."
  sudo apt-get remove --purge -y "$PKG_NAME"
  echo "✅ Uninstalled successfully!"
else
  echo "ℹ️ Package '$PKG_NAME' is not installed."
fi
