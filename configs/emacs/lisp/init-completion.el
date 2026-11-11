;;; init-completion.el -*- lexical-binding: t; -*-

(use-package vertico
  :config
  (vertico-mode 1))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :config
  (marginalia-mode 1))

(provide 'init-completion)
