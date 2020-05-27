#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

print_cpu_temp() {
  local temp
  local temp_cmd
  local temp_expr
  local units=$1

  # if this is Raspberry Pi
  if [[ $(uname -mr) =~ (arm|aarch64|raspi) ]]; then
    temp_cmd="vcgencmd"
    temp_args=" measure_temp | tr -d -c 0-9."
  else # else use lmsensors
    temp_cmd="sensors"
    temp_args=" | sed '/^[^Package]/d' | sed '/^\s*$/d' | tail -n 1 | awk '{a=$4} END {printf("%f", a)}'"
  fi

  if command_exists $temp_cmd; then
    temp=$(eval "${temp_cmd} ${temp_args}")
    else
    echo "no sensors found"
  fi


  if [ "$units" = "F" ]; then
    temp=$(celsius_to_fahrenheit "$temp")
  fi
  printf "%4.1f°%s" "$temp" "$units"
}

main() {
  local units
  units=$(get_tmux_option "@temp_units" "C")
  print_cpu_temp "$units"
}
main
