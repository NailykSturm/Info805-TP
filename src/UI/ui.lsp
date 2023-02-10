(defpackage ui
  (:use :cl)
  (:export :ui #:main)
)

(in-package ui)

(defun main ()
  (format t "Hello, world!~%")
)