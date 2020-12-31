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
   (quote
    (yaml-mode evil-surround evil-commentary git-gutter evil-leader evil-org go-mode use-package ac-solargraph ruby-electric fzf tmux-pane naviate flycheck yasnippet company lsp-ui lsp-mode evil))))

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
(setq use-package-always-ensure t)

(setq make-backup-files nil)
(menu-bar-mode -1)
(global-set-key (kbd "C-s") 'save-buffer)
(setq org-directory "/home/taylorzr/Dropbox/sync/")
(setq org-agenda-files '("~/Dropbox/sync/work.org"))

(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))

(use-package tmux-pane
  :ensure t
  :config
  (global-set-key (kbd "C-H") 'help-command) ; because we bind C-h to window-left
  (global-set-key (kbd "C-l") 'tmux-pane-omni-window-right)
  (global-set-key (kbd "C-h") 'tmux-pane-omni-window-left)
  (global-set-key (kbd "C-k") 'tmux-pane-omni-window-up)
  (global-set-key (kbd "C-j") 'tmux-pane-omni-window-down))

;; evil

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)
  (setq evil-symbol-word-search t)
  :config
  (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-normal-state-map (kbd "C-p") nil)
  (define-key evil-normal-state-map (kbd "\t") nil)
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)
  (global-set-key (kbd "C-g") 'helm-projectile-ag)
  ; (evil-mode 1) Enabled by evil-leader because
  ; https://github.com/cofi/evil-leader#usage
)

; NOTE: Hmn, leader docs say (global-evil-leader-mode) needs to come before evil but this breaks tab
; key in org mode...
(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode) ;; supposedly needs to be enabled before evil-mode
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
  "f" 'fzf
  "y" 'pbcopy
  "p" 'pbpaste
  "x" 'org-archive-subtree
  "i" 'org-insert-heading-after-current
  )
  (advice-add 'org-archive-subtree :after #'org-save-all-org-buffers)
  (evil-mode 1)
)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  (setq org-M-RET-may-split-line nil)
)

(use-package evil-commentary :ensure t
  :config
  (evil-commentary-mode)
)

;; end evil

(use-package undo-fu
  :ensure t
  :config
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)
  :after evil
)

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

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package fzf :ensure t)

(use-package go-mode :ensure t)

(use-package ruby-electric :ensure t)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

(use-package helm :ensure t :config (helm-mode t))
(use-package projectile :ensure t)
(use-package helm-projectile :ensure t)
(use-package helm-ag :ensure t)

(use-package git-gutter :ensure t)
(global-git-gutter-mode +1)

(use-package yaml-mode :ensure t)
