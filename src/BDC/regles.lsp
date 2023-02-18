(defpackage #:regles
    (:use #:cl)
    (:export #:regles #:test)
)

(in-package #:regles)

; Définition de la structure d'une règle
(defstruct rule 
  name
  weight
  conditions
  actions)

; Exemple d'initialisation d'une règle (sans conditions)
(defvar pokemon-stronger-than 
    (make-rule 
        :name 'pokemon-stronger-than 
        :weight 1 
        :conditions () 
        :actions (lambda (pokemon1 pokemon2)
            (if (> (pokemon-level pokemon1) (pokemon-level pokemon2))
                (format t "~a est plus fort que ~a.~%" (pokemon-name pokemon1) (pokemon-name pokemon2))
                (format t "~a n'est pas plus fort que ~a.~%" (pokemon-name pokemon1) (pokemon-name pokemon2))
            )
        )
    )
)

; Pour changer un attribut d'une règle
; (setf (rule-weight pokemon-stronger-than) 2)

; Pour appliquer une règle
; (funcall (rule-actions pokemon-stronger-than) charmander pikachu)

; Liste des règles
(defparameter *rules* (list pokemon-stronger-than))

(defun test ()
    (format t "test from regles~%")
)