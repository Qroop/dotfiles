;;; init-files.el -*- lexical-binding: t; -*-

(font-lock-add-keywords
 'dired-mode
 '(("^..-[-r][-w][xs]" (".+" (dired-move-to-filename) nil (0 'success)))))

(with-eval-after-load 'dired
  (evil-define-key '(normal visual motion) dired-mode-map
    (kbd "SPC") my/leader-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(provide 'init-files)
