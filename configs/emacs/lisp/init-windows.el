;;; init-windows.el -*- lexical-binding: t; -*-

(require 'project)

(let ((dir (expand-file-name "emacs" (or (getenv "XDG_STATE_HOME") "~/.local/state"))))
  (make-directory dir t)
  (setq project-list-file (expand-file-name "projects.eld" dir)))

(setq project-switch-commands 'project-find-file)

(defvar my/project-search-paths '("~/Projects" "~/Forefront")
  "Directories whose immediate subdirectories are offered as projects.")

(defvar my/project-direct-paths '("~/dotfiles")
  "Directories offered as projects as they are.")

(defun my/project-candidates ()
  "Known project roots plus configured directories, deduplicated."
  (let ((dirs (append (project-known-project-roots)
                      (mapcar #'expand-file-name my/project-direct-paths))))
    (dolist (parent my/project-search-paths)
      (setq parent (expand-file-name parent))
      (when (file-directory-p parent)
        (dolist (d (directory-files parent t directory-files-no-dot-files-regexp))
          (when (file-directory-p d) (push d dirs)))))
    (delete-dups (mapcar (lambda (d) (abbreviate-file-name (file-name-as-directory d)))
                         dirs))))

(defun my/switch-project ()
  "Pick a project directory and open its file finder."
  (interactive)
  (project-switch-project
   (completing-read "Project: " (my/project-candidates) nil t)))

(provide 'init-windows)
