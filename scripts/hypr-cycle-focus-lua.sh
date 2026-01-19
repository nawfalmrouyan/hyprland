#!/usr/bin/env bash

if [[ "$#" -lt 3 ]]; then
  echo "Usage: $0 <type value> [<type value> ...] <spawn command>"
  echo "Types: class, title, tag"
  exit 1
fi

STATE_DIR="${XDG_RUNTIME_DIR:-$HOME/.cache}/hypr-cycle-focus"
mkdir -p "$STATE_DIR"

declare -a TYPES
declare -a VALUES

if [ "$1" = "class" ]; then
  SKIP="3"
else
  SKIP="1"
fi

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

KEY=""
for i in "${!TYPES[@]}"; do
  KEY+="${TYPES[$i]}:${VALUES[$i]}_"
done

STATE_FILE="$STATE_DIR/${KEY%.state}"

get_clients() {
  local JQ_EXPR='map(select('

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

  local JQ_ARGS=()
  for i in "${!VALUES[@]}"; do
    JQ_ARGS+=(--arg "val$i" "${VALUES[$i]}")
  done

  hyprctl -j clients | jq -r "${JQ_ARGS[@]}" "$JQ_EXPR"
}

CLIENTS=$(get_clients)
COUNT=$(echo "$CLIENTS" | grep -c .)

if [[ "$COUNT" -eq 0 ]]; then
  SPAWN=$(echo "$SPAWN_CMD" | cut -d' ' -f$SKIP-)
  hyprctl eval "hl.dispatch(hl.dsp.exec_cmd(\"$SPAWN\"))"
  # echo $SPAWN
  exit 0
fi

if [[ "$COUNT" -eq 1 ]]; then
  ADDR=$(echo "$CLIENTS" | head -1)
  echo "$ADDR" >"$STATE_FILE"
  hyprctl eval "hl.dispatch(hl.dsp.focus({ window = \"address:$ADDR\" }))"
  # echo "$ADDR"
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
  if [[ -f "$STATE_FILE" ]]; then
    LAST_FOCUSED=$(cat "$STATE_FILE")
    for i in "${!ADDR_ARRAY[@]}"; do
      if [[ "${ADDR_ARRAY[$i]}" == "$LAST_FOCUSED" ]]; then
        hyprctl eval "hl.dispatch(hl.dsp.focus({ window = \"address:${ADDR_ARRAY[$i]}\" }))"
        echo "${ADDR_ARRAY[$i]}" >"$STATE_FILE"
        exit 0
      fi
    done
  fi
  hyprctl eval "hl.dispatch(hl.dsp.focus({ window = \"address:${ADDR_ARRAY[0]}\" }))"
  echo "${ADDR_ARRAY[0]}" >"$STATE_FILE"
  exit 0
fi

NEXT_INDEX=$(((CURRENT_INDEX + 1) % COUNT))
hyprctl eval "hl.dispatch(hl.dsp.focus({ window = \"address:${ADDR_ARRAY[$NEXT_INDEX]}\" }))"
echo "${ADDR_ARRAY[$NEXT_INDEX]}" >"$STATE_FILE"
