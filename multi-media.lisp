;; This file is mostly taken from https://github.com/areina/stumpwm.d/blob/master/media-keys.lisp

;; -*-lisp-*-

(in-package :stumpwm)

;; Functions
(defun brightness-get ()
  (read-from-string (run-shell-command "xbacklight -getf" t)))

(defun brightness-adjust (delta)
  (run-shell-command (concat "xbacklight " delta))
  (echo-progress (brightness-get) :label "Brightness"))


;; Keys

(defcommand brightness-inc () ()
  (brightness-adjust "+5"))
(define-key *top-map* (kbd "XF86MonBrightnessUp") "brightness-inc")

(defcommand brightness-dec () ()
  (brightness-adjust "-5"))
(define-key *top-map* (kbd "XF86MonBrightnessDown") "brightness-dec")

(define-key *top-map* (kbd "XF86Tools") "exec xfce4-power-manager -c")
(define-key *top-map* (kbd "Print") "exec xfce4-screenshooter")
