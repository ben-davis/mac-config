#!/bin/bash
NEXT_EVENT=$(icalBuddy -eed -n -nc -nrd -ea -iep datetime,title -b '' -ps "| @ |" -li 1 eventsToday)


if [ "$NEXT_EVENT" == "" ]; then
  sketchybar --set $NAME label="No more events today" drawing=on
else
  current_time=$(date +%s)
  IFS="@" read -r summary startTime <<< "$NEXT_EVENT"
  echo $startTime
  event_time=$(date -d "$(echo $startTime | sed 's/T/ /;s/ \(.*\)//')" "+%s")
  time_diff=$(( (event_time - current_time) / 60 ))
  echo "$summary in $time_diff mins"

  sketchybar --set $NAME label="$NEXT_EVENT" drawing=on
fi
