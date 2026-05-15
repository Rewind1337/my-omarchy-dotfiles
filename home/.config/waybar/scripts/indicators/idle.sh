#!/bin/bash

if pgrep -x hypridle >/dev/null; then
  echo '{"text": ""}'
else
  echo '{"text": "✪ nolock", "tooltip": "Idle lock disabled", "class": "active"}'
fi
