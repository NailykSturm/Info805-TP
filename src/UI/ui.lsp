(load "src/Moteur/moteur.lsp")
(defpackage #:ui
  (:use #:cl #:moteur)
  (:export #:main #:testUI)
)

(in-package #:ui)

(defun testUI ()
  (format t "test from ui~%")
)

(defun main ()
  (format t "Ui Start !~%")
  ; (moteur:moteurRun)
)