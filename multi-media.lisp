;; This file is mostly taken from https://github.com/areina/stumpwm.d/blob/master/media-keys.lisp

;; -*-lisp-*-

(in-package :stumpwm)
(load "~/.stumpwm.d/pulse-utils/parse_pactl.lisp")

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

(defcommand volume-inc () ()
  (volume-adjust (/ *max-volume-level* *volume-step-number*)))
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "volume-inc")

(defcommand volume-dec () ()
  (volume-adjust (- (/ *max-volume-level* *volume-step-number*))))
(define-key *top-map* (kbd "XF86AudioLowerVolume") "volume-dec")

(defcommand volume-toggle () ()
  (let ((output (run-shell-command "amixer set Master toggle" t)))
    (multiple-value-bind (result matches)
	(cl-ppcre:scan-to-strings "\\[(on|off)\\]" output)
      (let ((muted (if (equal (aref matches 0) "on") "OFF" "ON")))
		(message "~A ~A"
		 "Volume:"
		 (concat "Mute " muted))))))
(define-key *top-map* (kbd "XF86AudioMute") "volume-toggle")

(define-key *top-map* (kbd "XF86Tools") "exec xfce4-power-manager -c")
(define-key *top-map* (kbd "Print") "exec xfce4-screenshooter")
