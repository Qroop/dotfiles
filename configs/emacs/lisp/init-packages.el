;;; init-packages.el -*- lexical-binding: t; -*-

(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :if (or (eq system-type 'darwin) (daemonp))
  :config
  (setq exec-path-from-shell-arguments '("-l" "-i"))
  (exec-path-from-shell-initialize))

(provide 'init-packages)
