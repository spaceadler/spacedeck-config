#!/usr/bin/env bash

set -euo pipefail

EMOJI_COLUMNS="${EMOJI_COLUMNS:-6}"
EMOJI_LINES="${EMOJI_LINES:-7}"

for cmd in rofi wl-copy notify-send; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    notify-send "Emoji Picker" "Missing dependency: $cmd"
    exit 1
  fi
done

if ! rofi -modi emoji -show emoji -help >/dev/null 2>&1; then
  notify-send "Emoji Picker" "rofi-emoji mode is not available"
  exit 1
fi

selection="$(
  rofi -modi emoji -show emoji -emoji-format '{emoji}' \
    -p "Emoji" \
    -theme "$HOME/.config/rofi/themes/glass.rasi" \
    -theme-str "
    listview {
      layout: vertical;
      columns: ${EMOJI_COLUMNS};
      fixed-columns: true;
      lines: ${EMOJI_LINES};
      dynamic: false;
      fixed-height: true;
    }

    element {
      orientation: horizontal;
      children: [ element-text ];
    }

    element-text {
      horizontal-align: 0.5;
    }"
)"

[[ -z "$selection" ]] && exit 0

if ! [[ "$selection_index" =~ ^[0-9]+$ ]] || ((selection_index >= ${#raw_entries[@]})); then
  exit 1
fi

# 1. Copy the raw emoji character to Wayland
printf '%s' "$selection" | wl-copy

# 2. Wait for Rofi to close and window to regain focus
sleep 0.1

# 3. Simulate pasting
wtype -M ctrl -k v -m ctrl

notify-send "Emoji Picker" "Copied $selection"
