;;; early-init.el -*- lexical-binding: t; -*-

(defconst my/data-dir (expand-file-name "emacs/" (or (getenv "XDG_DATA_HOME") "~/.local/share")))
(defconst my/state-dir (expand-file-name "emacs/" (or (getenv "XDG_STATE_HOME") "~/.local/state")))
(defconst my/cache-dir (expand-file-name "emacs/" (or (getenv "XDG_CACHE_HOME") "~/.cache")))

(dolist (dir (list my/data-dir my/state-dir my/cache-dir))
  (make-directory dir t))

(setq package-user-dir (expand-file-name "elpa" my/data-dir)
      auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" my/state-dir)
      custom-file (expand-file-name "custom.el" my/state-dir))

(setq frame-inhibit-implied-resize t)
(dolist (param '((menu-bar-lines . 0)
                 (tool-bar-lines . 0)
                 (vertical-scroll-bars . nil)
                 (horizontal-scroll-bars . nil)))
  (add-to-list 'default-frame-alist param))

(setq native-comp-async-report-warnings-errors 'silent
      warning-minimum-level :error
      byte-compile-warnings nil)

(when (eq system-type 'darwin)
  (setq native-comp-jit-compilation nil
        native-comp-enable-subr-trampolines nil))

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache (expand-file-name "eln-cache" my/cache-dir)))
