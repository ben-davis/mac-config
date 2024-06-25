#!/bin/bash
NEXT_EVENT=$(icalBuddy -eed -n -nc -nrd -ea -iep datetime,title -b '' -ps "| @ |" -li 1 eventsToday)

if [ "$NEXT_EVENT" == "" ]; then
  sketchybar --set $NAME drawing=off
else
  sketchybar --set $NAME label="$NEXT_EVENT" drawing=on
fi
