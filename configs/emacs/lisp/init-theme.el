;;; init-theme.el -*- lexical-binding: t; -*-

(set-face-attribute 'default nil :family "GeistMono Nerd Font" :height 200)

(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(load-theme 'lackluster t)

(provide 'init-theme)
