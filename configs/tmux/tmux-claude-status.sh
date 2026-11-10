#!/usr/bin/env bash
# Records Claude Code's state on the tmux window it runs in (@claude_state),
# so the window list can show which windows need attention.
# Usage: tmux-claude-status.sh working|waiting|done|clear
# Called from Claude Code hooks (see configs/claude/settings.json).
set -euo pipefail

state=${1:?usage: tmux-claude-status.sh working|waiting|done|clear}

[[ -n "${TMUX:-}" ]] || exit 0
pane=${TMUX_PANE:-}
[[ -n "$pane" ]] || exit 0

if [[ "$state" == clear ]]; then
	tmux set-option -w -u -t "$pane" @claude_state
else
	tmux set-option -w -t "$pane" @claude_state "$state"
fi
