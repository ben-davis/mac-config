media=(
  script="$PLUGIN_DIR/media.sh"
  updates=on
  # icon=$APPLE_MUSIC
  icon.align=left
  icon.color=$GREY
  icon.font="$FONT:Regular:14.0"
)

sketchybar --add item media right \
           --set media "${media[@]}" \
           --subscribe media media_change
