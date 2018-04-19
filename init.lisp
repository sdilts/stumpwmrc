(in-package :stumpwm)

;; start swank server
(require :swank)
(swank-loader:init)
(swank:create-server :port 4004
		     :dont-close t)

;(add-hook *quit-hook* '(swank:stop-server 4004))

(setf *mode-line-timeout* 25)

(add-to-load-path #p"~/.stumpwm.d/stumpwm-contrib/modeline/battery-portable/")
(add-to-load-path #p"~/.stumpwm.d/stumpwm-contrib/util/end-session/")

(load-module "battery-portable")
(load-module "end-session")


(toggle-mode-line (current-screen)
		  (current-head)
		  "%B %d [^b%n^b] %v %h")

;; run emacs in the client:
(defcommand emacs () ()
  "Start emacs client unless it is already running, in which case focus it."
  (run-or-raise "emacs-c" '(:class "Emacs")))

(load "~/.stumpwm.d/utils.lisp")
(load "~/.stumpwm.d/multi-media.lisp")

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
