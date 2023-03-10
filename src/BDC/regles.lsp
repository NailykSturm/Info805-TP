; (load "src/UI/ui.lsp")
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
  actions
)

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
        :weight 2 
        :conditions (lambda (predicats faits)
            (if (faits:get-predicat "typePokemon" predicats)
                (if (faits:get-predicat "typeRecherche" predicats)
                    (progn 
                        ; (print "Pokemon of opposite type Ok")
                        T
                    )
                    nil   
                )
                nil
            )
        ) 
        :actions (lambda (predicats faits)
            (format t "Pokemon of opposite type : Start~%")
            (if (equal (faits:predicat-value (faits:get-predicat "typeRecherche" predicats)) "Attaque")
                (progn
                    (format t "Pokemon of opposite type : Attaque~%")
                    (dolist (weak-type (faits:typePokemon-weakness (car (faits:predicat-value (faits:get-predicat "typePokemon" predicats)))))
                        (faits:init-pokemon (faits:get-pokemon-list-of-type-url (faits:getJson weak-type :url)))
                    )
                )
                (progn
                    (format t "Pokemon of opposite type : Defense~%")
                    (dolist (resis-type (faits:typePokemon-resistance (car (faits:predicat-value (faits:get-predicat "typePokemon" predicats)))))
                        (faits:init-pokemon (faits:get-pokemon-list-of-type-url (faits:getJson resis-type :url)))
                    )
                    (dolist (immun-type (faits:typePokemon-immunity (car (faits:predicat-value (faits:get-predicat "typePokemon" predicats)))))
                        (faits:init-pokemon (faits:get-pokemon-list-of-type-url (faits:getJson immun-type :url)))
                    )
                )
            )
        )
    )
)

(defvar find-pokemon-name
    (make-rule 
        :name 'find-pokemon-name
        :weight 1 
        :conditions (lambda (predicats faits)
            (if (faits:get-predicat "nomPokemon" predicats)
                (progn 
                    T
                )
                nil   
            )
        ) 
        :actions (lambda (predicats faits)
            (let ((currentPokemon (faits:get-API-pokemon (faits:predicat-value (faits:get-predicat "nomPokemon" predicats)))))
                (if (not (equal currentPokemon nil)) 
                    (faits:add-predicat (faits:make-predicat :name "typePokemon" 
                        :value (faits:find-type-of-pokemon (faits:getJson currentPokemon :types) faits:*types*)))
                    (print "Pokemon not found")
                )
            )
        )
    )
)

(defvar no-posture-set
    (make-rule 
        :name 'no-posture-set
        :weight 1 
        :conditions (lambda (predicats faits)
            (if (faits:get-predicat "typePokemon" predicats)
                (if (not (faits:get-predicat "typeRecherche" predicats))
                    (progn 
                        ; (print "No posture set Ok")
                        T
                    )
                    nil   
                )
                nil
            )
        ) 
        :actions (lambda (predicats faits)
            ; (ui:warningRun "regles.no-posture-set" "Veillez choisir une posture (Attaque/Defense)")
            (format t "Veillez choisir une posture (Attaque/Defense)~%")
        )
    )
)

; (funcall (rule-actions pokemon-of-opposite-type) faits:*predicats* faits:*facts*)

; Liste des règles
(defparameter *rules* (list 
    pokemon-of-opposite-type 
    find-pokemon-name 
    no-posture-set))

(defun test ()
    (format t "test from regles~%")
)