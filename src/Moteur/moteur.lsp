(load "src/BDC/faits.lsp")
(load "src/BDC/regles.lsp")
(load "src/Exeptions/exept.lsp")
(defpackage #:moteur
    (:use #:cl)
    (:export #:moteur #:moteurRun)
)

(in-package #:moteur)

(defvar prochaineRegle (regles:make-rule :name "prochaine-regle" :weight 0 :conditions nil :actions nil))

; Le moteur d'inference parcours les regles et applique la regle qui a le plus de poids si les conditions sont respectees 
(defun moteurRun()
    (progn
        (dolist (regle regles:*rules*)
            (if (not(equal (regles:rule-name regle) "prochaine-regle"))
                (if (funcall (regles:rule-conditions regle) faits:*predicats* faits:*facts*) 
                    (if (> (regles:rule-weight regle) (regles:rule-weight prochaineRegle))
                        (setf prochaineRegle regle)
                    )
                )
            ) 
        )
        (print "Parcours des regles termine")
        (finish-output)
        (if (not (eq (regles:rule-name prochaineRegle) "prochaine-regle"))
            (funcall (regles:rule-actions prochaineRegle) faits:*predicats* faits:*facts*)
            (format t "Aucune regle ne peut etre appliquee~%")
        )    
    )
)













(defun test ()
    (format t "test from moteur~%")
    (exept:test)
    (faits:test)
    (regles:test)
)

