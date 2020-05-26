#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

temp_low_fg_color=""
temp_medium_fg_color=""
temp_high_fg_color=""

temp_low_default_fg_color="#[fg=green]"
temp_medium_default_fg_color="#[fg=yellow]"
temp_high_default_fg_color="#[fg=red]"

get_fg_color_settings() {
  temp_low_fg_color=$(get_tmux_option "@temp_low_fg_color" "$temp_low_default_fg_color")
  temp_medium_fg_color=$(get_tmux_option "@temp_medium_fg_color" "$temp_medium_default_fg_color")
  temp_high_fg_color=$(get_tmux_option "@temp_high_fg_color" "$temp_high_default_fg_color")
}

print_fg_color() {
  local temp=$($CURRENT_DIR/temp_cpu.sh | sed -e 's/[.].*$//')
  if [ $temp -lt 50 ]; then
    echo "$temp_low_fg_color"
  elif [ $temp -lt 65 ]; then
    echo "$temp_medium_fg_color"
  else
    echo "$temp_high_fg_color"
  fi
}

main() {
  get_fg_color_settings
  print_fg_color
}
main
