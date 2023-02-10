(defpackage #:faits
    (:use #:cl)
    (:export #:faits #:test)
)

(in-package #:faits)

(defun test ()
    (format t "test from faits~%")
)