#!/usr/bin/env bash

# ====================== CONFIG ======================
CONFIG_DIR="$HOME/.config/waybar/scripts/color-tool"
CONFIG_FILE="$CONFIG_DIR/random-color.txt"
# ===================================================

RESULT=$(pastel random | pastel format hex | head -n 1 | tr -d '[:space:]')

echo "$RESULT" > "$CONFIG_FILE"

# Clean JSON - single line, no extra output
cat << EOF
{"text": "<span foreground=\"${RESULT}\">⬤</span>", "class": "color-random", "tooltip": "Random Color → ${RESULT}"}
EOF