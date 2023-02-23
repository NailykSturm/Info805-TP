; (load "src/BDC/faits.lsp")

(defpackage #:regles
    (:use #:cl)
    (:export #:regles #:test #:rule #:*rules* #:make-rule #:rule-conditions #:rule-weight #:rule-name #:rule-actions)
)

(in-package #:regles)

; Définition de la structure d'une règle
(defstruct rule 
  name
  weight
  conditions
  actions)

; Exemple d'initialisation d'une règle (sans conditions)
; (defvar pokemon-stronger-than 
;     (make-rule 
;         :name 'pokemon-stronger-than 
;         :weight 1 
;         :conditions () 
;         :actions (lambda (pokemon1 pokemon2)
;             (if (> (pokemon-level pokemon1) (pokemon-level pokemon2))
;                 (format t "~a est plus fort que ~a.~%" (pokemon-name pokemon1) (pokemon-name pokemon2))
;                 (format t "~a n'est pas plus fort que ~a.~%" (pokemon-name pokemon1) (pokemon-name pokemon2))
;             )
;         )
;     )
; )

; Pour changer un attribut d'une règle
; (setf (rule-weight pokemon-stronger-than) 2)

; Pour appliquer une règle
; (funcall (rule-actions pokemon-stronger-than) charmander pikachu)

; Liste des règles :
; ------------------

;
(defvar pokemon-of-opposite-type 
    (make-rule 
        :name 'pokemon-of-opposite-type 
        :weight 1 
        :conditions (lambda (predicats faits)
            (if (faits:get-predicat "typePokemon" predicats)
                (if (faits:get-predicat "typeRecherche" predicats)
                    (progn 
                        (print "Pokemon of opposite type Ok")
                        T
                    )
                    nil   
                )
                nil
            )
        ) 
        :actions (lambda (predicats faits)
            (if (equal (faits:predicat-value (faits:get-predicat "typeRecherche" predicats)) "Attaque")
                (progn
                    (print "Pokemon of opposite type : Attaque")
                    (dolist (weak-type (faits:typePokemon-weakness (faits:predicat-value (faits:get-predicat "typePokemon" predicats))))
                        (faits:init-pokemon (faits:get-pokemon-list-of-type-url (faits:getJson weak-type :url)))
                    )
                )
                (print "Pas le bon prédicat")

            )
        )
    )
)

(funcall (rule-actions pokemon-of-opposite-type) faits:*predicats* faits:*facts*)
(print faits:*facts*)

; Liste des règles
(defparameter *rules* (list pokemon-of-opposite-type))

(defun test ()
    (format t "test from regles~%")
)