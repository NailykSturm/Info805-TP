(defpackage #:faits
    (:use #:cl)
    (:export #:faits #:test)
)

(in-package #:faits)

; Définition de la structure d'un type de pokemon
(defstruct typePokemon
  name
  weakness
  resistance
  immunity
)

(defvar API-url "https://pokeapi.co/api/v2/type/")

; Getters pour les types de pokemons
(defun get-API-type (idType)
  (cl-json:decode-json-from-string 
    (dex:get (concatenate 'string API-url (write-to-string idType)))
  )
)

; Exemple d'initialisation d'un type de pokemon
(defvar currentType (get-API-type 10))

; Parcourir le json
(defun getJson (json key)
  (cdr (assoc key json))
)

; Trouver les noms d'un type de pokemon dans le json
(defun get-type-names (json)
  (getJson json :names)
)

(defun find-type-name-fr (json)
  (cond 
    ((null json) nil)
    ((equal (getJson (getJson (car json) :language) :name) (string "fr")) (getJson (car json) :name))
    (t (find-type-name-fr (cdr json)))
  )
)

(defun find-type-name-en (json)
  (cond 
    ((null json) nil)
    ((equal (getJson (getJson (car json) :language) :name) (string "en")) (getJson (car json) :name))
    (t (find-type-name-en (cdr json)))
  )
)

(defun get-type-damage-relation-double-damage-from (json)
  (getJson json :double_damage_from)
)

(defvar (eval(intern "FEU")) (make-typePokemon :name (string (find-type-name-fr (get-type-names currentType))) :weakness nil :resistance nil :immunity nil))

(print FEU)
; Chercher le nom d'un type de pokemon dans le json dans différentes langues
(print (find-type-name-fr (get-type-names currentType)))
(print (find-type-name-en (get-type-names currentType)))


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