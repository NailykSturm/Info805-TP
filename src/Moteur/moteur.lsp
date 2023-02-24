(load "src/BDC/faits.lsp")
(load "src/BDC/regles.lsp")
(load "src/Exeptions/exept.lsp")
(defpackage #:moteur
    (:use #:cl)
    (:export #:moteur #:moteurRun)
)

(in-package #:moteur)

(defvar prochaineRegle (regles:make-rule :name "prochaine-regle" :weight 0 :conditions nil :actions nil))

; Le moteur d'inference parcours les règles 
; et applique la règle qui a le plus de poids si les conditions sont respectees 
(defun moteurRun()
    (dolist (regle regles:*rules*)
        (if (not(equal (regles:rule-name regle) "prochaine-regle"))
            (if (funcall (regles:rule-conditions regle) faits:*predicats* faits:*facts*) 
                (if (> (regles:rule-weight regle) (regles:rule-weight prochaineRegle))
                    (setf prochaineRegle regle)
                )
            )
        ) 
    )
    (if (not (eq (regles:rule-name prochaineRegle) "prochaine-regle"))
        (funcall (regles:rule-actions prochaineRegle) faits:*predicats* faits:*facts*)
        (error "Aucune regle ne peut etre appliquee")
    )    
)













(defun test ()
    (format t "test from moteur~%")
    (exept:test)
    (faits:test)
    (regles:test)
)

