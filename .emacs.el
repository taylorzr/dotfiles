;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ac-solargraph ruby-electric fzf tmux-pane naviate flycheck yasnippet company lsp-ui lsp-mode evil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(use-package evil
  :init
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-normal-state-map (kbd "C-p") nil)
  ;(define-key evil-normal-state-map (kbd "C-p") 'fzf)
  (global-set-key (kbd "C-p") 'fzf)
)

;; Go configuration
(use-package go-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp)
  :hook (ruby-mode . lsp)
  ; :hook (go-mode . lsp-deferred))
)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(setq org-directory "/home/taylorzr/Dropbox/sync/")
(setq org-agenda-files '("~/Dropbox/sync/work.org"))

;; End Go Configuration

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package fzf
  :ensure t)

(use-package tmux-pane
  :ensure t
  :config
  (global-set-key (kbd "C-l") 'tmux-pane-omni-window-right)
  (global-set-key (kbd "C-h") 'tmux-pane-omni-window-left)
  (global-set-key (kbd "C-k") 'tmux-pane-omni-window-up)
  (global-set-key (kbd "C-j") 'tmux-pane-omni-window-down))

(global-set-key (kbd "C-s") 'save-buffer)

(use-package ruby-electric
  :ensure t)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

; TODO: Use system clipboard
