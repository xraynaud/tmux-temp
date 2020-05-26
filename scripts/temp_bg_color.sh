#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

temp_low_bg_color=""
temp_medium_bg_color=""
temp_high_bg_color=""

temp_low_default_bg_color="#[bg=green]"
temp_medium_default_bg_color="#[bg=yellow]"
temp_high_default_bg_color="#[bg=red]"

get_bg_color_settings() {
  temp_low_bg_color=$(get_tmux_option "@temp_low_bg_color" "$temp_low_default_bg_color")
  temp_medium_bg_color=$(get_tmux_option "@temp_medium_bg_color" "$temp_medium_default_bg_color")
  temp_high_bg_color=$(get_tmux_option "@temp_high_bg_color" "$temp_high_default_bg_color")
}

print_bg_color() {
  local temp=$($CURRENT_DIR/temp_cpu.sh | sed -e 's/°[A-Z]//')
  if [ $temp < 50 ]; then
    echo "$temp_low_bg_color"
  elif [ $temp <65 ]; then
    echo "$temp_medium_bg_color"
  else
    echo "$temp_high_bg_color"
  fi
}

main() {
  get_bg_color_settings
  print_bg_color
}
main
