#!/usr/bin/env bash

set -euf -o pipefail

readonly CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

readonly PROG="$(get_tmux_option '@urlscan-prog' 'urlscan')"
readonly ARGS="$(get_tmux_option '@urlscan-args' '-c -d')"
# TODO(filip): To avoid security holes, do not use the output of `mktemp -u` to create a file
readonly TMPFILE="$(mktemp -u --tmpdir tmux-urlscan.XXXXXX)"

if command_exists "$PROG"; then
  tmux capture-pane -J \; \
    save-buffer "$TMPFILE" \; \
    delete-buffer \; \
    popup \
    -xC -yC \
    -w100 \
    -K -E -R \
    "$PROG $ARGS $TMPFILE; trap 'rm -f $TMPFILE' EXIT"
else
  tmux display-message "$PROG: command not found"
fi

# vim: sw=2 ts=2 et fdm=marker
