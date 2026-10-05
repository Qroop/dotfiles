# Agent instructions for tmux

The user typically runs this CLI agent inside a tmux session. Killing the
tmux server also kills the agent's own session, ending the conversation.

- **Never run `tmux kill-server`, `tmux kill-session` (on the session the
  agent is running in), or anything else that would terminate the tmux
  server/session you are currently attached to.**
- **Do not test tmux config changes yourself** (bindings, popups, scripts) —
  not even on an isolated throwaway socket. Key-press behavior (prefixes,
  timing, terminal state) doesn't reliably reproduce through scripted
  `send-keys`/detached sessions, so this leads to false negatives/positives.
  Instead, describe what changed and ask the user to test it themselves in
  their real session.
