#!/usr/bin/env bash

# ====================== CONFIG ======================
CONFIG_DIR="$HOME/.config/waybar/scripts/color-tool"
CONFIG_FILE="$CONFIG_DIR/pasted-color.txt"
# ===================================================

mkdir -p "$CONFIG_DIR"

# ====================== SAVE MODE ======================
# Check clipboard for a color
CLIPBOARD=$(wl-paste -n 2>/dev/null | tr -d '[:space:]' || echo "")
SAVED=false

save_color() {
    echo "$1" > "$CONFIG_FILE"
    # Optional: echo "Saved $1"   # uncomment if you want terminal feedback
}

# HEX check
if [[ "$CLIPBOARD" =~ ^#?([0-9a-fA-F]{3}){1,2}$ ]]; then
    COLOR="$CLIPBOARD"
    [[ "$COLOR" != \#* ]] && COLOR="#$COLOR"
    COLOR=$(echo "$COLOR" | tr '[:upper:]' '[:lower:]')
    save_color "$COLOR"
    SAVED=true
fi

# RGB / RGBA check
if [[ "$CLIPBOARD" =~ ^rgba?\(([0-9]{1,3}),([0-9]{1,3}),([0-9]{1,3}) ]]; then
    R="${BASH_REMATCH[1]}"
    G="${BASH_REMATCH[2]}"
    B="${BASH_REMATCH[3]}"
    if (( R <= 255 && G <= 255 && B <= 255 )); then
        HEX=$(pastel color "rgb($R,$G,$B)" | pastel format hex)
        save_color "$HEX"
        SAVED=true
    fi
fi

# HSL / HSLA CHECK
if [[ "$CLIPBOARD" =~ ^hsla?\([[:space:]]*([0-9]{1,3})[[:space:]]*,[[:space:]]*([0-9]{1,3})%[[:space:]]*,[[:space:]]*([0-9]{1,3})% ]]; then
    H="${BASH_REMATCH[1]}"
    S="${BASH_REMATCH[2]}"
    L="${BASH_REMATCH[3]}"

    # Validate ranges
    if (( H <= 360 && S <= 100 && L <= 100 )); then
        HEX=$(pastel color "hsl($H,$S%,$L%)" | pastel format hex)
        save_color "$HEX"
        SAVED=true
    fi
fi

# CSS named colors check
if pastel color "$CLIPBOARD" >/dev/null 2>&1; then
    HEX=$(pastel color "$CLIPBOARD" | pastel format hex 2>/dev/null)

    if [[ "$HEX" =~ ^#[0-9a-f]{6}$ ]]; then
        save_color "$HEX"
        SAVED=true
    fi
fi

# If clipboard was not a valid color → clear the file (hide modules)
if [ "$SAVED" = false ]; then
    > "$CONFIG_FILE"          # Truncate / empty the file
fi

# ====================== DISPLAY MODE (Waybar) ======================
if [ ! -s "$CONFIG_FILE" ]; then
    echo '{"text": ""}'        # Empty text = hide the module
    exit 0
fi

COLOR=$(tr -d '[:space:]' < "$CONFIG_FILE")

# Output JSON for Waybar
cat << EOF
{"text": "<span foreground=\"${COLOR}\">⬤</span>", "class": "color-middle", "tooltip": "Base color: ${COLOR}\nClick to refresh from clipboard"}
EOF