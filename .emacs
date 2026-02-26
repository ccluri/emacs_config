(setq native-comp-async-report-warnings-errors 'silent) ;; Hide the warning buffer
;; ==========================================================
;; 1. PACKAGE SYSTEM SETUP
;; ==========================================================
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ==========================================================
;; 2. APPEARANCE, THEME & UI
;; ==========================================================
(electric-pair-mode t)
(use-package solarized-theme
  :config
  (load-theme 'solarized-light t))

;; ;; Customize the Mode Line colors
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(mode-line ((t (:background "black" :foreground "white" :box nil))))
;;  '(mode-line-inactive ((t (:background "#202020" :foreground "#888888" :box nil)))))

(use-package nerd-icons
  :ensure t)

;; --- Global UI Improvements ---
;; (global-display-line-numbers-mode t) ;; Show line numbers
;; (setq display-line-numbers-type 'relative) ;; Optional: use 't' for standard numbers

;; --- Handling Long Lines ---
(setq-default fill-column 79)        ;; Set PEP8 standard line width
(add-hook 'python-mode-hook 'display-fill-column-indicator-mode) ;; Vertical ruler
(add-hook 'python-mode-hook 'visual-line-mode) ;; Wrap long lines visually

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 4)
  ;; Tell doom-modeline to use nerd-icons
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  
  (set-face-attribute 'mode-line nil :background "black" :foreground "white"))

;; ==========================================================
;; 3. CONDA ENVIRONMENT MANAGEMENT
;; ==========================================================
(use-package conda
  :config
  (setq conda-anaconda-home (expand-file-name "~/miniforge3"))
  (conda-env-autoactivate-mode t)
  :bind
  (("C-c c a" . conda-env-activate)
   ("C-c c d" . conda-env-deactivate)))

;; ==========================================================
;; 4. PYTHON IDE (ELPY, FLYCHECK, COMPANY)
;; ==========================================================

;; --- Flycheck: The Linter (PEP8) ---
(use-package flycheck
  :init (global-flycheck-mode t)
  :config
  (setq-default flycheck-disabled-checkers '(python-pylint python-pycompile)))

;; --- Company: Auto-completion ---
(use-package company
  :ensure t
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection)
              ("TAB" . company-complete-selection))
  :config
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 1)
  (global-company-mode t))

;; --- Elpy: The Engine ---
(use-package elpy
  :init
  (elpy-enable)
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'company-mode)
  (add-hook 'elpy-mode-hook 'my/flycheck-python-setup))

;; --- PEP8 Auto-Formatting on Save ---
(use-package py-autopep8
  :hook (python-mode . py-autopep8-mode))

;; ==========================================================
;; 5. HELPER FUNCTIONS
;; ==========================================================
(defun my/flycheck-python-setup ()
  "Ensure Flycheck uses the flake8/python from the active conda env."
  (let ((python-exe (executable-find "python")))
    (when python-exe
      (setq-local flycheck-python-flake8-executable "flake8")
      (setq-local flycheck-python-pycompile-executable python-exe))))

;; ==========================================================
;; 6. THE "STORAGE LOCKER"
;; ==========================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons doom-modeline py-autopep8 company flycheck conda elpy solarized-theme)))

