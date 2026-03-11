## i3status configuration

This directory contains configuration for `i3status`, which provides status information to the i3 bar.

### `config`

- Sets the `output_format` to `i3bar` with colors enabled.
- Refresh interval of 3 seconds.
- Displays, in order:
  - Wireless status for interface `wlan0`.
  - Battery status for `BAT1` with custom labels and low-battery threshold.
  - Root filesystem free space (`/`).
  - Available memory.
  - Local time and date in the format `%d/%m-%y %H:%M`.

