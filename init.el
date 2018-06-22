;; This sets up the load path so that we can override it
(message "Hello-world -- this is my init.el file loading!")
(require 'package)
(setq package-enable-at-startup nil)

(setq initial-scratch-message "") ;; Uh, I know what Scratch is for
(setq visible-bell t)             ;; Get rid of the beeps

(when (window-system)
  (tool-bar-mode 0)               ;; Toolbars were only cool with XEmacs
  (when (fboundp 'horizontal-scroll-bar-mode)
    (horizontal-scroll-bar-mode -1))
  (scroll-bar-mode -1))          
;; (menu-bar-mode -1)
;; (tool-bar-mode -1)
(tooltip-mode -1)
(setq tooltip-use-echo-area t)
(setq inhibit-startup-screen t)

(require 're-builder)
(setq reb-re-syntax 'string)

(package-initialize)
(setq use-package-always-ensure t)

(require 'ido)
(ido-mode t)
(setq ido-create-new-buffer 'always)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defvar myPackages '(better-defaults elpy ;; add the elpy package
  material-theme py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))

(setq user-full-name "Mrinal Raghupathi"
      user-mail-address "mrinalraghupathi@gmail.com")

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))

(display-time-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)

;;(use-package color-theme)
;;(use-package color-theme-solarized)
(require 'ergoemacs-mode)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(use-package smartscan
  :defer t
  :config (global-smartscan-mode t))

;; Keybindings


(setq ergoemacs-theme "lvl2") ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-mode 1)

(if (not (and (boundp 'ergoemacs-theme)
	 (or (string= ergoemacs-theme "lvl2")
	     (string= ergoemancs-theme "lvl1"))))
	(global-set-key (kbd "C-e") 'execute-extended-command))

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(setq inhibit-startup-messagee t) ;; hide the startup message
(load-theme 'material t) ;; load material theme

(defun my/light-theme ()
    (interactive)
    (load-theme 'material-light t))



(global-linum-mode t) ;; enable line numbers globally
(use-package windmove
  :bind
  (("<f2> <right>" . windmove-right)
   ("<f2> <left>" . windmove-left)
   ("<f2> <up>" . windmove-up)
   ("<f2> <down>" . windmove-down)
   ))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(require 'cl)

(use-package dash
  :ensure t
  :config (eval-after-load "dash" '(dash-enable-font-lock)))

(use-package s
  :ensure t)

(use-package f
  :ensure t)

(elpy-enable)
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 120))

;; (setq elpy-rpc-python-command "")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(package-selected-packages
   (quote
    (emmet-mode projectile f markdown-mode color-theme-modern py-autopep8 org-jira exec-path-from-shell use-package smartscan material-theme magit ergoemacs-mode elpy color-theme-solarized better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#263238" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Menlo")))))
