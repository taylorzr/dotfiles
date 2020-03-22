;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Emacs config
(setq make-backup-files nil)

;; Setup Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-org helm-projectile projectile helm-ag helm evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Setup Evil Org
(unless (package-installed-p 'evil-org)
  (package-install 'evil-org))
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

;; Setup tmux navigator
(unless (package-installed-p 'tmux-pane)
  (package-install 'tmux-pane))

;; Setup Helm
(unless (package-installed-p 'helm)
  (package-install 'helm))
(require 'helm-config)
(helm-mode 1)

;; Setup Projectile
(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(require 'helm-projectile)
(helm-projectile-on)

;; Key bindings
(global-set-key (kbd "C-x C-p") 'helm-projectile) ;; TODO: How to set to C-p, doesn't seem to work!??!
(global-set-key (kbd "C-s") 'save-buffer)
