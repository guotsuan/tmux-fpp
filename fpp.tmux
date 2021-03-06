#!/usr/bin/env bash

get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z $option_value ]; then
    echo $default_value
  else
    echo $option_value
  fi
}

readonly fpp_path="$(get_tmux_option "@fpp-path" "fpp")"
readonly key="$(get_tmux_option "@fpp-key" "f")"

tmux bind-key "$key" capture-pane \\\; \
    save-buffer /tmp/tmux-buffer \\\; \
    new-window -c "#{pane_current_path}" "sh -c 'cat /tmp/tmux-buffer | ${fpp_path} && rm /tmp/tmux-buffer'"

