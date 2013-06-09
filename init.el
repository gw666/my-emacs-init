;; code below is from http://ianeslick.com/2013/05/17/clojure-debugging-13-emacs-nrepl-and-ritz/, 6/8/13
;; "install the emacs packages" code snippet spliced in from https://github.com/pallet/ritz/tree/develop/nrepl

(require 'package)
(add-to-list 'package-archives
'("melpa" . "http://melpa.milkbox.net/packages/") t) ; t means "add to end of list"

 (add-to-list 'package-archives
 '("marmalade" . "http://marmalade-repo.org/packages/") ;;from ritz page
  t)

(package-initialize)

;; BEGIN code from ritz page
(defvar my-packages '(clojure-mode
                      nrepl
                      nrepl-ritz))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
	;; END code from ritz page
	
	
(require 'nrepl)
 
;; Configure nrepl.el
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces-in-repl t)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")
 
;; Some default eldoc facilities
(add-hook 'nrepl-connected-hook
(defun pnh-clojure-mode-eldoc-hook ()
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(nrepl-enable-on-existing-clojure-buffers)))
 
;; Repl mode hook
(add-hook 'nrepl-mode-hook 'subword-mode)
 
;; Auto completion for NREPL
(require 'ac-nrepl)
(eval-after-load "auto-complete"
'(add-to-list 'ac-modes 'nrepl-mode))
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)

(load-file "/Users/gr/tech/emacsstuff/user-libs/nrepl-inspect/nrepl-inspect.el")
(define-key nrepl-mode-map (kbd "C-c C-i") 'nrepl-inspect)

;; enabling nrepl-ritz
;;
(require 'nrepl-ritz) ;; after (require 'nrepl)
 
;; Ritz middleware
(define-key nrepl-interaction-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-interaction-mode-map (kbd "C-c C-a") 'nrepl-apropos)
(define-key nrepl-mode-map (kbd "C-c C-a") 'nrepl-apropos)

;; final code from https://github.com/pallet/ritz/tree/develop/nrepl
;;
(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup) ; probably overwrites previous assignment
(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))
