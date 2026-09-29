#!/usr/bin/env bash
# Toggles a scratch terminal pane taking up ~40% of the window's height.
# Re-running this while the pane is open closes it again.
set -euo pipefail

scratch_pane=$(tmux list-panes -F '#{pane_id} #{@scratch_term}' | awk '$2 == "1" {print $1; exit}')

if [[ -n "${scratch_pane:-}" ]]; then
	tmux kill-pane -t "$scratch_pane"
else
	new_pane=$(tmux split-window -v -l 40% -c "#{pane_current_path}" -P -F '#{pane_id}')
	tmux set-option -p -t "$new_pane" @scratch_term 1
fi
