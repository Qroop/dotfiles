;;; init-keymaps.el -*- lexical-binding: t; -*-

(keymap-global-set "C-=" 'text-scale-increase)
(keymap-global-set "C--" 'text-scale-decrease)

;; macos corne zoom in/out
(keymap-global-set "s-<kp-add>" 'text-scale-increase)
(keymap-global-set "s-<kp-subtract>" 'text-scale-decrease)

(defvar my/leader-map (make-sparse-keymap)
  "Prefix keymap bound to SPC in normal, visual and motion state.")

(evil-define-key '(normal visual motion) 'global (kbd "SPC") my/leader-map)

(use-package which-key
  :config
  (setq which-key-idle-delay 0.3)
  (which-key-mode 1))

(defun my/source-config ()
  "Load init.el."
  (interactive)
  (let ((init (expand-file-name "init.el" user-emacs-directory)))
    (load init nil 'nomessage)
    (message "Sourced %s" (abbreviate-file-name init))))

(keymap-set my/leader-map "s" 'my/source-config)
(which-key-add-keymap-based-replacements my/leader-map "s" "Source config")

(provide 'init-keymaps)
