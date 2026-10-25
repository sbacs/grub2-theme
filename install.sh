#!/usr/bin/env bash
# Usage: ./copy-theme.sh -d DEST_DIR [-a]
set -e

THEME_DIR="$(cd "$(dirname "$0")" && pwd)/theme"
ACTIVATE=false

while getopts "d:a" opt; do
  case "$opt" in
    d) DEST_DIR="${OPTARG/#\~/$HOME}" ;;
    a) ACTIVATE=true ;;
  esac
done

[ -z "$DEST_DIR" ] && read -r -p "Destination folder: " DEST_DIR && DEST_DIR="${DEST_DIR/#\~/$HOME}"

mkdir -p "$DEST_DIR"
rm -rf "$DEST_DIR/theme"
cp -r "$THEME_DIR" "$DEST_DIR/"

if $ACTIVATE; then
  sudo grub2-mkconfig -o /boot/grub2/grub.cfg
fi