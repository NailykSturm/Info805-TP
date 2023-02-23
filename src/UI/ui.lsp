(load "src/Moteur/moteur.lsp")
(defpackage #:ui
  (:use #:cl #:moteur)
  (:export #:main #:testUI)
)

(in-package #:ui)

(defun printColorReset (txt) (format nil "~a~c[0m" txt #\ESC))
(defun printColorRGBBack (r g b txt) (format nil "~c[48;2;~a;~a;~am~a" #\ESC r g b txt))
(defun printColorRGBFore (r g b txt) (format nil "~c[38;2;~a;~a;~am~a" #\ESC r g b txt))

(defparameter *color* (list ))

(defun testUI ()
  (print (format nil "~c[5mtestststs~c[0m" #\ESC #\ESC))
  (format t "test from ui~%")
  (format t "~c[38;2;255;157;5mcolor~c[0m~%" #\ESC #\ESC)
  ; (print (format nil "~c[5mYOYOYLYOYLOYLOLOLOLOOLO" (color-codeANSI reset) #\ESC #\ESC))
  ; (printcolor red "red")
  (print (printColorReset (printColorRGBBack 255 157 5 (printColorRGBFore 0 0 0 "test"))))
)

(defun main ()
  (format t "Ui Start !~%")
  ; (moteur:moteurRun)
)