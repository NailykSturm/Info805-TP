(defpackage #:regles
    (:use #:cl)
    (:export #:regles #:test)
)

(in-package #:regles)

(defun test ()
    (format t "test from regles~%")
)