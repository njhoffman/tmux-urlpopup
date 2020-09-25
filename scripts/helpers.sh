#!/usr/bin/env bash

set -euf -o pipefail

command_exists() { # {{{
  command -v "$1" &> /dev/null
} # }}}

get_tmux_option() { # {{{
  local value
  value="$(tmux show-option -gqv "$1")"
  [[ -n "$value" ]] && echo "$value" || echo "$2"
} # }}}

# vim: sw=2 ts=2 et fdm=marker
