#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/waybar/scripts/color-tool"
CONFIG_FILE="$CONFIG_DIR/pasted-color.txt"
CONFIG_FILE_RANDOM="$CONFIG_DIR/random-color.txt"

case "$1" in
    middle)
        COLOR=$(tr -d '[:space:]' < "$CONFIG_FILE")
        ;;
    random)
        COLOR=$(tr -d '[:space:]' < "$CONFIG_FILE_RANDOM")

        ;;
    darken|lighten)
        # Re-calculate the adjusted color
        ACTION="$1"
        AMOUNT="0.1"
        SAVED_COLOR=$(tr -d '[:space:]' < "$CONFIG_FILE")
        COLOR=$(pastel "$ACTION" "$AMOUNT" "$SAVED_COLOR" | pastel format hex)
        ;;
    *)
        COLOR=$(tr -d '[:space:]' < "$CONFIG_FILE")
        ;;
esac

if [ -n "$COLOR" ]; then
    echo -n "$COLOR" | wl-copy
fi