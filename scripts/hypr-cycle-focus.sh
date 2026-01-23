#!/usr/bin/env bash

CLASS="$1"
shift
SPAWN_CMD="$@"

if [[ -z "$CLASS" || -z "$SPAWN_CMD" ]]; then
  echo "Usage: $0 <class> <spawn command>"
  exit 1
fi

# Get matching clients (Hyprland returns them in MRU order)
CLIENTS=$(hyprctl -j clients | jq -r --arg class "$CLASS" '
    map(select(.class == $class)) | .[].address')

COUNT=$(echo "$CLIENTS" | grep -c .)

# No clients → spawn
if [[ "$COUNT" -eq 0 ]]; then
  hyprctl dispatch exec "$SPAWN_CMD"
  exit 0
fi

# One client → focus it
if [[ "$COUNT" -eq 1 ]]; then
  hyprctl dispatch focuswindow "address:$CLIENTS"
  exit 0
fi

CURRENT=$(hyprctl -j activewindow | jq -r '.address')

# Convert to array
mapfile -t ADDR_ARRAY <<<"$CLIENTS"

# Find current index
CURRENT_INDEX=-1
for i in "${!ADDR_ARRAY[@]}"; do
  if [[ "${ADDR_ARRAY[$i]}" == "$CURRENT" ]]; then
    CURRENT_INDEX=$i
    break
  fi
done

# If current not found → focus most recent (index 0)
if [[ "$CURRENT_INDEX" -eq -1 ]]; then
  hyprctl dispatch focuswindow "address:${ADDR_ARRAY[0]}"
  exit 0
fi

# Compute next index (wrap around)
NEXT_INDEX=$(((CURRENT_INDEX + 1) % COUNT))

hyprctl dispatch focuswindow "address:${ADDR_ARRAY[$NEXT_INDEX]}"
