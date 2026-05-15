#!/usr/bin/env bash

# ====================== CONFIG ======================
CONFIG_DIR="$HOME/.config/waybar/scripts/color-tool"
CONFIG_FILE="$CONFIG_DIR/pasted-color.txt"
# ===================================================

if [ ! -s "$CONFIG_FILE" ]; then
    echo '{"text": ""}'      # Hide when no color
    exit 0
fi

SAVED_COLOR=$(tr -d '[:space:]' < "$CONFIG_FILE")

ACTION="lighten"
AMOUNT="0.1"

if [ $# -eq 1 ]; then
    if [[ "$1" == -* ]]; then
        ACTION="darken"
        AMOUNT="${1#-}"
    else
        ACTION="lighten"
        AMOUNT="$1"
    fi
elif [ $# -eq 2 ]; then
    ACTION="$1"
    AMOUNT="$2"
fi

RESULT=$(pastel "$ACTION" "$AMOUNT" "$SAVED_COLOR" | pastel format hex)

# Clean JSON - single line, no extra output
cat << EOF
{"text": "<span foreground=\"${RESULT}\">⬤</span>", "class": "color-adjust", "tooltip": "${ACTION^}ed by ${AMOUNT} → ${RESULT}"}
EOF