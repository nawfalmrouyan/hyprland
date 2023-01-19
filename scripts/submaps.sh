# shellcheck shell=sh

# shellevents sample event file

# when entering the resize submap dim all inactive windows and
# add a very loud border to the active window

CURRENT_SUBMAP="${CURRENT_SUBMAP:=}"

# resize='keyword decoration:dim_inactive 1;keyword general:col.active_border 0xFFe7691e'
enter='keyword decoration:dim_inactive 1;keyword general:col.active_border 0xffeba0ac'
exit='keyword decoration:dim_inactive 0;keyword general:col.active_border 0xffcba6f7 0xff89b4fa 45deg'

event_submap() {
  printf >&2 '%s\n' "$SUBMAPNAME"
  case "$SUBMAPNAME" in
  "resize"|"move"|"focus")
    CURRENT_SUBMAP='resize'
    hyprctl --batch "$enter"
    ;;
  *)
    case "$CURRENT_SUBMAP" in
    "resize"|"move"|"focus")
      CURRENT_SUBMAP=''
      hyprctl --batch "$exit"
      ;;
    esac
    ;;
  esac
}
