(defpackage #:faits
    (:use #:cl)
    (:export #:faits #:test)
)

(in-package #:faits)

; Définition de la structure d'un pokemon
(defstruct pokemon
  name
  typePoke
  level)

; Exemple d'initialisation d'un pokemon
(defvar pikachu (make-pokemon :name 'pikachu :typePoke 'electric :level 10))
(defvar charmander (make-pokemon :name 'charmander :typePoke 'fire :level 5))
(defvar bulbasaur (make-pokemon :name 'bulbasaur :typePoke 'grass :level 7))

; Liste des pokemons
(defparameter *facts*
  '((pikachu)
    (charmander)
    (bulbasaur))
)

(defun test ()
    (format t "test from faits~%")
)