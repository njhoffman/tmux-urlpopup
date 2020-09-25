#!/usr/bin/env bash

set -euf -o pipefail

readonly CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/scripts/helpers.sh"

readonly KEY="$(get_tmux_option '@urlscan-key' 'u')"

tmux bind-key "$KEY" run-shell "$CURRENT_DIR/scripts/urlscan_extract.sh"

# vim: sw=2 ts=2 et fdm=marker
