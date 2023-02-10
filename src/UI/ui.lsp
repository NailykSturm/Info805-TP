(load "src/Moteur/moteur.lsp")
(defpackage #:ui
  (:use #:cl #:moteur)
  (:export #:main #:testUI)
)

(in-package #:ui)

(defun testUI ()
  (format t "test from ui~%")
  (moteur:test)
)

(defun main ()
  (format t "Hello, world!~%")
)