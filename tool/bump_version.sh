#!/usr/bin/env bash
#
# Bump the app version in pubspec.yaml (drives both Android and iOS versions).
#
# Usage:
#   tool/bump_version.sh [major|minor|patch|build]
#
#   build (default)  1.0.0+1 -> 1.0.0+2   (same release, new upload)
#   patch            1.0.0+1 -> 1.0.1+2
#   minor            1.0.0+1 -> 1.1.0+2
#   major            1.0.0+1 -> 2.0.0+2
#
# The build number (after the '+') always increases, which the App Store and
# Play Store require for every upload.
set -euo pipefail

cd "$(dirname "$0")/.."
part="${1:-build}"

current="$(grep -E '^version:[[:space:]]' pubspec.yaml | head -1 | sed -E 's/^version:[[:space:]]*//')"
name="${current%%+*}"
build="${current##*+}"
IFS='.' read -r major minor patch <<<"$name"

case "$part" in
  major) major=$((major + 1)); minor=0; patch=0 ;;
  minor) minor=$((minor + 1)); patch=0 ;;
  patch) patch=$((patch + 1)) ;;
  build) ;;
  *) echo "Usage: $0 [major|minor|patch|build]" >&2; exit 1 ;;
esac
build=$((build + 1))

new="${major}.${minor}.${patch}+${build}"
tmp="$(mktemp)"
sed -E "s/^version:.*/version: ${new}/" pubspec.yaml >"$tmp" && mv "$tmp" pubspec.yaml
echo "version: ${current} -> ${new}"
