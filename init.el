;; code below is from http://ianeslick.com/2013/05/17/clojure-debugging-13-emacs-nrepl-and-ritz/, 6/8/13
;; "install the emacs packages" code snippet spliced in from https://github.com/pallet/ritz/tree/develop/nrepl

(require 'package)
(add-to-list 'package-archives
'("melpa" . "http://melpa.milkbox.net/packages/") t) ; t means "add to end of list"

 (add-to-list 'package-archives
 '("marmalade" . "http://marmalade-repo.org/packages/") ;;from ritz page
  t)

(package-initialize)

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


;; code to add nrepl-inspect support
(load-file "/Users/gr/tech/emacsstuff/user-libs/nrepl-inspect/nrepl-inspect.el")
(define-key nrepl-mode-map (kbd "C-c C-i") 'nrepl-inspect)

;; NOTE: uses the following in profiles.clj
;;{:user {:dependencies [[nrepl-inspect "0.3.0"]]
;;		:repl-options {:nrepl-middleware
;;						[inspector.middleware/wrap-inspect]}}}
