;;; init-files.el -*- lexical-binding: t; -*-

(font-lock-add-keywords
 'dired-mode
 '(("^..-[-r][-w][xs]" (".+" (dired-move-to-filename) nil (0 'success)))))

(provide 'init-files)
