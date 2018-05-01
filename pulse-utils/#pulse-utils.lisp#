;;;; pulse-utils.lisp

(in-package #:pulse-utils)

;;; "pulse-utils" goes here. Hacks and glory await!

(defun generate-sink-menu ()
  (flet ((build-pair (sink)
	     (declare (type sink-info sink))
	     (list (sink-info-description sink)
		   sink)))
    (mapcar #'build-pair (get-available-sinks))))

(defcommand audio-switch-output () ()
  (let ((choice (select-from-menu (stumpwm::current-screen) (generate-sink-menu)
				  "Choose output sink")))
    (switch-to-sink (second choice))))

(stumpwm:defcommand volume-inc () ()
  (volume-adjust (/ *max-volume-level* *volume-step-number*)))
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "volume-inc")

(stumpwm:defcommand volume-dec () ()
  (volume-adjust (- (/ *max-volume-level* *volume-step-number*))))
(define-key *top-map* (kbd "XF86AudioLowerVolume") "volume-dec")

(stumpwm:defcommand volume-toggle () ()
  (let ((output (run-shell-command "amixer set Master toggle" t)))
    (multiple-value-bind (result matches)
	(cl-ppcre:scan-to-strings "\\[(on|off)\\]" output)
      (let ((muted (if (equal (aref matches 0) "on") "OFF" "ON")))
		(message "~A ~A"
		 "Volume:"
		 (concat "Mute " muted))))))
(define-key *top-map* (kbd "XF86AudioMute") "volume-toggle")
