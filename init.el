(setq inhibit-startup-message t
      visible-bell t)
;;(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(column-number-mode)
(scroll-bar-mode -1)
(set-fringe-mode 10)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(global-hl-line-mode 1)
(set-default 'truncate-lines t)
(set-face-attribute 'default nil :font "Source Code Pro" :height 150)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; Make ESC quit prompts



;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;;Initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(typescript-mode lsp-mode company evil-collection evil which-key doom-themes doom-modeline all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; first time config load on new machine
;; need to run this one time M-x all-the-icons-install-fonts
;; if you some fonts are still missing try installing this
;; https://github.com/ryanoasis/nerd-fonts
(use-package all-the-icons)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;;use C-z to toggel emacs mode and evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;;use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package company
 :bind (:map company-active-map
 ("C-n" . company-select-next)
 ("C-p" . company-select-previous))
 :config
 (setq company-idle-delay 0.2)
 (global-company-mode t))
