(load "src/BDC/faits.lsp")
(load "src/BDC/regles.lsp")
(load "src/Exeptions/exept.lsp")
(defpackage #:moteur
    (:use #:cl)
    (:export #:moteur #:test)
)

(in-package #:moteur)

(defun test ()
    (format t "test from moteur~%")
    (exept:test)
    (faits:test)
    (regles:test)
)
