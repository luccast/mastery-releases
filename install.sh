#!/bin/sh
set -eu

REPO_OWNER="${REPO_OWNER:-luccast}"
RELEASE_REPO="${RELEASE_REPO:-mastery-releases}"
SOURCE_REPO="${SOURCE_REPO:-mastery}"
MANIFEST_URL="${MANIFEST_URL:-https://github.com/${REPO_OWNER}/${RELEASE_REPO}/releases/latest/download/latest-linux.yml}"
ICON_URL="${ICON_URL:-https://raw.githubusercontent.com/${REPO_OWNER}/${SOURCE_REPO}/master/build/icons/png/512x512.png}"

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required to install Mastery." >&2
  exit 1
fi

case "$(uname -m)" in
  x86_64|amd64) ;;
  *)
    echo "Mastery currently ships Linux builds for x86_64 only." >&2
    exit 1
    ;;
esac

BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
ICON_DIR="$DATA_DIR/icons/hicolor/512x512/apps"
DESKTOP_DIR="$DATA_DIR/applications"
APP_PATH="$BIN_DIR/Mastery.AppImage"
ICON_PATH="$ICON_DIR/mastery.png"
DESKTOP_PATH="$DESKTOP_DIR/mastery.desktop"

mkdir -p "$BIN_DIR" "$ICON_DIR" "$DESKTOP_DIR"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT HUP INT TERM

MANIFEST_PATH="$TMP_DIR/latest-linux.yml"
curl -fsSL "$MANIFEST_URL" > "$MANIFEST_PATH"

APPIMAGE_FILE="$(awk -F': ' '/^path:/ {print $2; exit}' "$MANIFEST_PATH")"
VERSION="$(awk -F': ' '/^version:/ {print $2; exit}' "$MANIFEST_PATH")"

if [ -z "$APPIMAGE_FILE" ]; then
  echo "Could not determine the latest Linux release asset." >&2
  exit 1
fi

APP_URL="https://github.com/${REPO_OWNER}/${RELEASE_REPO}/releases/latest/download/${APPIMAGE_FILE}"

curl -fsSL "$APP_URL" > "$APP_PATH"
chmod +x "$APP_PATH"
curl -fsSL "$ICON_URL" > "$ICON_PATH"

cat > "$DESKTOP_PATH" <<EOF
[Desktop Entry]
Name=Mastery
Comment=Agent Skill Manager
Exec=$APP_PATH
Icon=$ICON_PATH
Type=Application
Terminal=false
Categories=Development;
StartupNotify=true
EOF

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$DESKTOP_DIR" >/dev/null 2>&1 || true
fi

echo "Installed Mastery ${VERSION:-latest} to $APP_PATH"
echo "Launch it from your app menu or run: $APP_PATH"
