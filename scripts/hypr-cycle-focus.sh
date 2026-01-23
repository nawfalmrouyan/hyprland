#!/usr/bin/env bash

if [[ "$#" -lt 3 ]]; then
  echo "Usage: $0 <type value> [<type value> ...] <spawn command>"
  echo "Types: class, title, tag"
  exit 1
fi

# -----------------------------
# Parse identifier pairs
# -----------------------------
declare -a TYPES
declare -a VALUES

while [[ "$#" -gt 1 ]]; do
  case "$1" in
  class | title | tag)
    TYPES+=("$1")
    VALUES+=("$2")
    shift 2
    ;;
  *)
    break
    ;;
  esac
done

SPAWN_CMD="$*"

if [[ -z "$SPAWN_CMD" || "${#TYPES[@]}" -eq 0 ]]; then
  echo "Invalid arguments."
  exit 1
fi

# -----------------------------
# Build jq filter dynamically
# -----------------------------
JQ_EXPR='map(select('

for i in "${!TYPES[@]}"; do
  TYPE="${TYPES[$i]}"
  VALUE="${VALUES[$i]}"

  if [[ "$i" -gt 0 ]]; then
    JQ_EXPR+=' and '
  fi

  if [[ "$TYPE" == "tag" ]]; then
    JQ_EXPR+="(.tags[]? == \$val$i)"
  else
    JQ_EXPR+="(.[\"$TYPE\"] == \$val$i)"
  fi
done

JQ_EXPR+=')) | .[].address'

# Build jq args
JQ_ARGS=()
for i in "${!VALUES[@]}"; do
  JQ_ARGS+=(--arg "val$i" "${VALUES[$i]}")
done

CLIENTS=$(hyprctl -j clients | jq -r "${JQ_ARGS[@]}" "$JQ_EXPR")

COUNT=$(echo "$CLIENTS" | grep -c .)

# -----------------------------
# Spawn if none
# -----------------------------
if [[ "$COUNT" -eq 0 ]]; then
  hyprctl dispatch exec "$SPAWN_CMD"
  exit 0
fi

# -----------------------------
# Focus logic
# -----------------------------
if [[ "$COUNT" -eq 1 ]]; then
  hyprctl dispatch focuswindow "address:$CLIENTS"
  exit 0
fi

CURRENT=$(hyprctl -j activewindow | jq -r '.address')
mapfile -t ADDR_ARRAY <<<"$CLIENTS"

CURRENT_INDEX=-1
for i in "${!ADDR_ARRAY[@]}"; do
  if [[ "${ADDR_ARRAY[$i]}" == "$CURRENT" ]]; then
    CURRENT_INDEX=$i
    break
  fi
done

if [[ "$CURRENT_INDEX" -eq -1 ]]; then
  hyprctl dispatch focuswindow "address:${ADDR_ARRAY[0]}"
  exit 0
fi

NEXT_INDEX=$(((CURRENT_INDEX + 1) % COUNT))
hyprctl dispatch focuswindow "address:${ADDR_ARRAY[$NEXT_INDEX]}"
