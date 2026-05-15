#!/bin/bash

if pgrep -f "^gpu-screen-recorder" >/dev/null; then
  # Configuration
  DIRECTORY="$HOME/Videos/"

  # Get newest file size in MB
  size_mb=$(find "$DIRECTORY" -type f -exec stat -c '%Y %s %n' {} + 2>/dev/null \
            | sort -nr | head -1 | awk '{printf "%.1f", $2 / 1048576}')

  # Output the JSON with size included
  echo "{\"text\": \"‣ Recording... ${size_mb} MB\", \"tooltip\": \"Stop recording\", \"class\": \"active\"}"
else
  echo '{"text": ""}'
fi
