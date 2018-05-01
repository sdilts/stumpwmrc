;;;; package.lisp

(defpackage #:pulse-utils
  (:use #:cl :stumpwm)
  (:export :*max-volume-level*
	   :*volume-step-number*
	   #:volume-toggle
	   #:audio-switch-output
	   #:volume-dec
	   #:volume-inc))
