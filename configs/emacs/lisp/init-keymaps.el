;;; init-keymaps.el -*- lexical-binding: t; -*-

(keymap-global-set "C-=" 'text-scale-increase)
(keymap-global-set "C--" 'text-scale-decrease)

;; macos corne zoom in/out
(keymap-global-set "s-<kp-add>" 'text-scale-increase)
(keymap-global-set "s-<kp-subtract>" 'text-scale-decrease)

(defvar my/leader-map (make-sparse-keymap)
  "Prefix keymap bound to SPC in normal, visual and motion state.")

(evil-define-key '(normal visual motion) 'global (kbd "SPC") my/leader-map)

(provide 'init-keymaps)
