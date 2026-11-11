;;; init-options.el -*- lexical-binding: t; -*-

(load custom-file 'noerror 'nomessage)

(setq inhibit-startup-screen t
      initial-scratch-message nil
      initial-major-mode 'fundamental-mode)
(advice-add #'display-startup-echo-area-message :override #'ignore)

(setq make-backup-files nil
      create-lockfiles nil
      auto-save-default nil
      use-short-answers t
      scroll-margin 8
      scroll-conservatively 101
      display-line-numbers-type 'relative)

(setq-default tab-width 4
              indent-tabs-mode t
              truncate-lines t)

(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)
(global-auto-revert-mode 1)

(when (eq system-type 'darwin)
  (setq ns-alternate-modifier 'meta
        ns-right-alternate-modifier 'none))

(blink-cursor-mode 0)

(provide 'init-options)
