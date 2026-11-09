#!/usr/bin/env bash
# Records Claude Code's state on the tmux window it runs in (@claude_state),
# so the window list can show which windows need attention.
# Usage: tmux-claude-status.sh working|waiting|done|clear
# Called from Claude Code hooks (see ~/.claude/settings.json) and from tmux
# focus hooks (see tmux.conf).
set -euo pipefail

state=${1:?usage: tmux-claude-status.sh working|waiting|done|clear}

[[ -n "${TMUX:-}" ]] || exit 0
pane=${TMUX_PANE:-}
[[ -n "$pane" ]] || exit 0

# "done" and "waiting" only matter if you are not already looking at the window.
if [[ "$state" == done || "$state" == waiting ]]; then
	active=$(tmux display-message -p -t "$pane" '#{window_active}')
	focused=$(tmux list-clients -F '#{client_flags}' | grep -c focused || true)
	if [[ "$active" == 1 && "$focused" -gt 0 ]]; then
		state=clear
	fi
fi

if [[ "$state" == clear ]]; then
	tmux set-option -w -u -t "$pane" @claude_state
else
	tmux set-option -w -t "$pane" @claude_state "$state"
fi
