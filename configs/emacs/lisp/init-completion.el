;;; init-completion.el -*- lexical-binding: t; -*-

(use-package vertico
  :config
  (vertico-mode 1)
  (require 'vertico-repeat)
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :config
  (marginalia-mode 1))

(setq recentf-save-file (expand-file-name "recentf" my/state-dir))
(recentf-mode 1)

(use-package consult
  :config
  (setq consult-project-function #'my/project-root
        consult-async-min-input 1
        consult-async-input-debounce 0.05
        consult-async-input-throttle 0.1
        consult-async-refresh-delay 0.05))

(defun my/project-root (&rest _)
  "Root of the current project, or nil outside one."
  (when-let* ((project (project-current)))
    (project-root project)))

(defun my/find-files ()
  "Pick a file from the project root, listing everything up front."
  (interactive)
  (let* ((default-directory (or (my/project-root) default-directory))
         (orderless-matching-styles '(orderless-flex))
         (vertico-sort-function #'vertico-sort-length-alpha)
         (files (process-lines "fd" "--type" "f" "--color" "never")))
    (find-file (completing-read "Find files: " files nil t))))

(provide 'init-completion)
