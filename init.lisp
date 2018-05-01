;; Stuart Dilts 2017
(in-package :stumpwm)

;; start swank server
(require :swank)
(swank-loader:init)
(swank:create-server :port 4004
		     :dont-close t)

;(add-hook *quit-hook* '(swank:stop-server 4004))

(setf *mode-line-timeout* 25)

;;(add-to-load-path #p"~/.stumpwm.d/stumpwm-contrib/")
(stumpwm:init-load-path #p"~/.stumpwm.d/")
;; (add-to-load-path #p"~/.stumpwm.d/stumpwm-contrib/modeline/battery-portable/")
;; (add-to-load-path #p"~/.stumpwm.d/pulse-utils/")
;; (add-to-load-path #p"~/.stumpwm.d/stumpwm-contrib/util/end-session/")

;; add some stuff to stumpwm: (needed for pulse-utils to work)
(load "~/.stumpwm.d/utils.lisp")
(load "~/.stumpwm.d/multi-media.lisp")

(load-module "battery-portable")
(load-module "end-session")
(load-module "pulse-utils")

(toggle-mode-line (current-screen)
		  (current-head)
		  "%B %d [^b%n^b] %v %h")

;; run emacs in the client:
(defcommand emacs () ()
  "Start emacs client unless it is already running, in which case focus it."
  (run-or-raise "emacs-c" '(:class "Emacs")))

(setf *mouse-focus-policy* :click)
(setf *window-border-style* :thin)
(run-shell-command "xrdb -merge ~/.Xresources")
(run-shell-command "xmodmap ~/.Xmodmap")
(run-shell-command "feh --bg-scale ~/Pictures/simonstalenhag_gas.jpg")
(run-shell-command "xscreensaver -nosplash")

(defcommand dmenu-run () ()
  (run-shell-command "dmenu_run"))

(define-key *root-map* (kbd "!") "dmenu-run")
(define-key *groups-map* (kbd "l") "grouplist")

(add-hook *quit-hook* (lambda () (run-shell-command "emacsclient -ne -e \"(kill-emacs)\"")))




(defun print-transition (new-window current-window)
  (with-open-file (stream "~/stumpwm-debug.txt" :direction :output :if-exists :append)
    (format stream "~A => ~A~%" current-window new-window)))

(add-hook *focus-window-hook* 'print-transition)
