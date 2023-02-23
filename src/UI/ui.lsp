(load "src/Moteur/moteur.lsp")
(defpackage #:ui
  (:use #:cl #:moteur)
  (:export 
    #:main #:testUI 
    #:afficherPokemon #:notImplementedFunction
  )
)
(in-package #:ui)

;; Diverses fonctions mour mettre de la couleur, et gérer les caractères, dans le terminal
(defun newLine () (format t "~%"))
(defun pRes () (format t "~c[0m" #\ESC))
(defun pCol (code) (format t "~c[~am" #\ESC code))
(defun pRGBFore (r g b) (format t "~c[38;2;~a;~a;~am" #\ESC r g b ))
(defun pRGBBack (r g b) (format t "~c[48;2;~a;~a;~am" #\ESC r g b))
(defun pComplex (code r g b) (format t "~c[~a;2;~a;~a;~am" #\ESC code r g b))
(defun notImplemented (command) (pcol 5) (prgbfore 110 50 50) (format t "TODO : command > ") (pRes) (prgbfore 110 50 50) (format t "~a" command) (format t " not implemented yet > ") (pres) (newLine))
(defun notImplementedFunction (function) (pcol 5) (prgbfore 110 50 50) (format t "TODO : function > ") (pRes) (prgbfore 110 50 50) (format t "~a" function) (format t " not implemented yet") (pres) (newLine))
(defun unknownCommand (command) (pcol 1) (pcol 4) (prgbfore 110 50 50) (format t "Commande ~a inconnue " command) (pRes) (pcol 1) (prgbfore 110 50 50) (format t "vérifier l'orthographe ou utiliser la commande help") (pres) (newLine))

;; Affiche l'aide de l'application
(defun help (&optional command)
    (cond 
        ((null command)
            (pCol 1) (pCol 4) (pRGBFore 150 0 200) (format t "Voici la liste des instructions disponibles :") (pRes) (newLine)
            (format t "- ") (pCol 3) (pRGBFore 150 0 200) (format t "help ") (pRes) (prgbfore 150 0 200) (format t ": affiche cette liste") (pRes) (newLine)
            (format t "- ") (pCol 3) (pRGBFore 150 0 200) (format t "help <command> ") (pRes) (prgbfore 150 0 200) (format t ": obtiens de l'aide sur la commande") (pRes) (newLine)
            (format t "- ") (pCol 3) (pRGBFore 150 0 200) (format t "exit ") (pRes) (prgbfore 150 0 200) (format t ": quitte l'application") (pres) (newLine)
            (format t "- ") (pCol 3) (pRGBFore 150 0 200) (format t "find ") (pRes) (prgbfore 150 0 200) (format t ": permet de rechercher quelque chose") (pres) (newLine)
        )
        (
            (cond 
                ((string= command "find") 
                    (pCol 1) (pCol 4) (pRGBFore 150 0 200) (format t "Voici la liste des instructions disponibles :") (pRes) (newLine)
                    (format t "- ") (pCol 3) (pRGBFore 150 0 200) (format t "find pokemon ") (pRes) (prgbfore 150 0 200) (format t ": permet de rechercher un pokemon") (pres) (newLine)
                )
                (t (unknownCommand command))
            )
        )
    )
)

;; Verifie si la commande entrée est bien une qu'on connait
(defun checkInput (in)
    (cond 
        ((null in) t)
        ((search "help" in) 
            (cond 
                ((equal (length in) 4) (help))
                (t (help (subseq in 5)))
            )
        )
        ((string= in "exit") t)
        ((string= in "find") (findSmth))
        (t (unknownCommand in))
    )
)

;; Fonction principale de l'application
(defun app ()
    (newline) (pcol 4) (format t "Que voulez-vous faire ?") (pres) (newline)
    (let ((in (read-line)))
        (let ((continue (checkInput in)))
            (cond ((null continue) (app))
                (t (pcol 1) (format t "Au revoir !") (pres) (newline))
            )
        )
    )
)

(defun findSmth ()
    (pcol 4) (format t "Que voulez-vous rechercher ?") (pres) (newline)
    (let ((src (read-line)))
        (cond 
            ((string= src "pokemon") (notImplementedFunction "find pokemon"))
            (t (unknownCommand src))
        )
    )
)

(defun afficherPokemon (pokemon) (notImplementedFunction "afficherPokemon"))

;; Fonction de test pour tous types d'essais pour l'interface utilisateur
(defun testUI ()
    (help)
    ; (format t "test") (newline) (newline) (format t "retest") (newline)
    ; (app)
    ; (format t "Quel est votre nom ?~%")
    ; (let ((name (read-line)))
    ;     (prgbfore 175 0 175) (pcol 4) (pcomplex 58 25 175 25)  (format t "Bonjour ~a malheureusement, vous êtes sur la partie de test. Cette discussion va s'arrêter là!" name) (pres) (newline)
    ; )
)

(defun main ()
    (format t "~%Ui Start !~%")
    (format t "~%Initialisation des types de pokemons~%")
    (faits:init-type faits:*types*)
    (format t "~%Lancement du moteur~%")
    (print faits:*predicats*)
    (print (length faits:*predicats*))
    (moteur:moteurRun)
    (faits:add-predicat (faits:make-predicat :name "typeRecherche" :value "Attaque"))
    (print faits:*predicats*)
    (print (length faits:*predicats*))
    (moteur:moteurRun)
    (print (length faits:*facts*))
    (help)
    (app)
)