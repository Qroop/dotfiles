;;; init-keymaps.el -*- lexical-binding: t; -*-

(keymap-global-set "C-=" 'text-scale-increase)
(keymap-global-set "C--" 'text-scale-decrease)

;; macos corne zoom in/out
(keymap-global-set "s-<kp-add>" 'text-scale-increase)
(keymap-global-set "s-<kp-subtract>" 'text-scale-decrease)

(provide 'init-keymaps)

