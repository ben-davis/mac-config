#!/bin/bash

date=(
  icon=cal
  icon.font="$FONT:Heavy:12.0"
  icon.padding_right=0
  label.width=68
  label.font="JetBrains Mono:Mono:12.0"
  label.align=right
  padding_left=0
  update_freq=1
  script="$PLUGIN_DIR/date.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item date right       \
           --set date "${date[@]}" \
           --subscribe date system_woke
