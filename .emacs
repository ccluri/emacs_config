;;  ;Initialize Package and include stable MELPA
;; (require 'package)
;;   (add-to-list 'package-archives
;; 	                    '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
;; (add-to-list 'package-archives
;; 	                  '("elpy" . "https://jorgenschaefer.github.io/packages/"))


;; elpy - https://github.com/jorgenschaefer/elpy
(package-initialize)
(elpy-enable)


;; flycheck mode - http://www.flycheck.org/en/latest/ (needs use-package installed)
(use-package flycheck
:ensure t
:init (global-flycheck-mode))


;; ;; python
;; (setq python-shell-interpreter "python")

;; ipython
;; (when (executable-find "ipython")
;;   (setq python-shell-interpreter "ipython"))

;; load solarized color theme - https://github.com/sellout/emacs-color-theme-solarized
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)


