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

(keymap-set my/leader-map "SPC" 'execute-extended-command)
(which-key-add-keymap-based-replacements my/leader-map "SPC" "Run command")

(defvar my/leader-find-map (make-sparse-keymap))
(keymap-set my/leader-map "f" my/leader-find-map)
(which-key-add-keymap-based-replacements my/leader-map "f" "Find")
(keymap-set my/leader-find-map "f" 'my/find-files)
(keymap-set my/leader-find-map "g" 'consult-ripgrep)
(keymap-set my/leader-find-map "b" 'consult-buffer)
(keymap-set my/leader-find-map "o" 'consult-recent-file)
(keymap-set my/leader-find-map "r" 'vertico-repeat)
(which-key-add-keymap-based-replacements my/leader-find-map
  "f" "Find files"
  "g" "Find by grep"
  "b" "Find buffers"
  "o" "Find recent files"
  "r" "Resume picker")

(keymap-set my/leader-map "s" 'my/source-config)
(which-key-add-keymap-based-replacements my/leader-map "s" "Source config")

;; ESC quits the minibuffer (completion prompts, M-x, etc.)
(define-key minibuffer-local-map (kbd "<escape>") #'abort-recursive-edit)
(define-key minibuffer-local-ns-map (kbd "<escape>") #'abort-recursive-edit)
(define-key minibuffer-local-completion-map (kbd "<escape>") #'abort-recursive-edit)
(define-key minibuffer-local-must-match-map (kbd "<escape>") #'abort-recursive-edit)

(provide 'init-keymaps)
