(defpackage #:exept
  (:use #:cl)
  (:export #:exept #:test)
)

(in-package #:exept)
(defun test ()
    (format t "test form exept~%")
)