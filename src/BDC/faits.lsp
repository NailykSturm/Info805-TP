(defpackage #:faits
    (:use #:cl)
    (:export 
    #:faits 
    #:test 
    #:*facts* #:add-fact
    #:*types* #:find-type-of-pokemon #:valid-type-of-pokemon
    #:*predicats* #:get-predicat #:add-predicat 
    #:predicat #:make-predicat #:predicat-value 
    #:pokemon #:make-pokemon #:pokemon-name #:pokemon-typesPoke #:pokemon-stats #:pokemon-level
    #:typePokemon #:typePokemon-frenchName #:typePokemon-weakness #:typePokemon-resistance #:typePokemon-immunity 
    #:getJson #:get-pokemon-list-of-type-url #:get-API-pokemon
    #:init-pokemon #:init-type)
)

(in-package #:faits)

(defvar API-url "https://pokeapi.co/api/v2/type/")

; Définition de la structure d'un type de pokemon
(defstruct typePokemon
  id
  frenchName
  englishName
  weakness
  resistance
  immunity
)

(defvar Normal    (make-typePokemon :id 1))
(defvar Fighting  (make-typePokemon :id 2))
(defvar Flying    (make-typePokemon :id 3))
(defvar Poison    (make-typePokemon :id 4))
(defvar Ground    (make-typePokemon :id 5))
(defvar Rock      (make-typePokemon :id 6))
(defvar Bug       (make-typePokemon :id 7))
(defvar Ghost     (make-typePokemon :id 8))
(defvar Steel     (make-typePokemon :id 9))
(defvar Fire      (make-typePokemon :id 10))
(defvar Water     (make-typePokemon :id 11))
(defvar Grass     (make-typePokemon :id 12))
(defvar Electric  (make-typePokemon :id 13))
(defvar Psychic   (make-typePokemon :id 14))
(defvar Ice       (make-typePokemon :id 15))
(defvar Dragon    (make-typePokemon :id 16))
(defvar Dark      (make-typePokemon :id 17))
(defvar Fairy     (make-typePokemon :id 18))
(defvar Unknown   (make-typePokemon :id 10001))
(defvar Obscur    (make-typePokemon :id 10002))

(defparameter *types* (list Normal Fighting Flying Poison Ground Rock Bug Ghost Steel Fire Water Grass Electric Psychic Ice Dragon Dark Fairy Unknown Obscur))

(defun requete-API (url)
  (progn 
    (require :cl-json)
    (require :dexador)
    ; (print (format nil "Requête API ~a" url))
    (cl-json:decode-json-from-string 
      (dex:get url)
    )
  )
)

; Getters pour les types de pokemons
(defun get-API-type (idType)
  (requete-API (concatenate 'string API-url (write-to-string idType)))
)

(defun get-API-pokemon (namePokemon)
  (requete-API (concatenate 'string "https://pokeapi.co/api/v2/pokemon/" namePokemon))
)

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
  (getJson (getJson json :damage--relations) :double--damage--from)
)

(defun get-type-damage-relation-half-damage-to (json)
  (getJson (getJson json :damage--relations) :half--damage--to)
)

(defun get-type-damage-relation-no-damage-to (json)
  (getJson (getJson json :damage--relations) :no--damage--to)
)

(defun get-pokemon-list-of-type-url (url)
  (getJson (requete-API url) :pokemon)
)

(defun init-type (liste)
  (cond 
    ((null liste) nil)
    (t (progn 
      (format T ".")
      (finish-output)
      (let ((currenttype (get-API-type (typePokemon-id (car liste)))))
        (setf (typePokemon-frenchName (car liste)) (find-type-name-fr (get-type-names currentType)))
        (setf (typePokemon-englishName (car liste)) (find-type-name-en (get-type-names currentType)))
        (setf (typePokemon-weakness (car liste)) (get-type-damage-relation-double-damage-from currentType))
        (setf (typePokemon-resistance (car liste)) (get-type-damage-relation-half-damage-to currentType))
        (setf (typePokemon-immunity (car liste)) (get-type-damage-relation-no-damage-to currentType))
      )
      (init-type (cdr liste))
      )
    )
  )
)

(defvar res nil)

(defun valid-type-of-pokemon (type liste)
  (setq res nil)
  (dolist (typeLocal liste)
    (if (equal (string-downcase (typePokemon-englishName typeLocal)) (string-downcase type))
      (progn
        (push typeLocal res)
      )
    )
  )
  (return-from valid-type-of-pokemon res)
)

(defun find-type-of-pokemon (json-types liste)
  (setq res nil)
  (dolist (type json-types)
    (dolist (typeLocal liste)
      (if (equal (string-downcase (typePokemon-englishName typeLocal)) (getJson (getJson type :type) :name))
        (progn
          ; (format T "Trouvé !~%")
          (push typeLocal res)
        )
        ; (format T "~a != ~a~%"(typePokemon-englishName typeLocal) (getJson (getJson type :type) :name))
      )
    )
  )
  (return-from find-type-of-pokemon res)
)

; (print  *types*)
; (print (getJson (get-API-type (typePokemon-id (car *types*))) :damage--relations ))
; Chercher le nom d'un type de pokemon dans le json dans différentes langues
; (print (find-type-name-fr (get-type-names currentType)))
; (print (find-type-name-en (get-type-names currentType)))


; Définition de la structure d'un pokemon
(defstruct pokemon
  name
  typesPoke
  stats
  level
)

; Exemple d'initialisation d'un pokemon
(defvar pikachu (make-pokemon :name "pikachu" :typesPoke electric :level 10))
(defvar charmander (make-pokemon :name "charmander" :typesPoke fire :level 5))
(defvar bulbasaur (make-pokemon :name "bulbasaur" :typesPoke grass :level 7))
; Convertisseur nom de pokemon français -> nom de pokemon anglais
; https://www.pokemon-element-sh.fr/traducteur/

; Liste des pokemons
(defparameter *facts*
  '()
)

; Ajouter un pokemon à la base de faitss
(defun add-fact (pokemon)
  (push pokemon *facts*)
)

(defun estDans (s1 s2)
  (cond 
    ((null s2) nil)
    ((equal (pokemon-name s1) (pokemon-name (car s2))) t)
    ( t (estDans s1 (cdr s2)))
  )
)

(defun init-pokemon (liste)
  (cond 
    ((null liste) nil)
    (t 
      (progn 
        ; (format nil ".")
        (let ((currentPokemon (requete-API(getJson (getJson (car liste) :pokemon) :url))))
          ; (print currentPokemon)
          (let ((tempPoke (make-pokemon
              :name (getJson currentPokemon :name)
              :typesPoke (getJson currentPokemon :types)
              :stats (getJson currentPokemon :stats)
              :level nil
            )))
            (if (estDans tempPoke *facts*)
              (format T "Pokemon déjà présent dans la base de faits~%")
              (progn
                (add-fact tempPoke)
                (format T "Pokemon ajouté à la base de faits~%")
              )
            )
          )
          
          (init-pokemon (cdr liste))
        )
      )
    )
  )
)

; (add-fact pikachu)
; (print *facts*)

; Définition de la structure d'un predicat
(defstruct predicat
  name
  value)

; (defvar predicat1 (make-predicat :name "typePokemon" :value electric))
; (defvar predicat2 (make-predicat :name "typeRecherche" :value "Defense"))

; Liste des predicats
(defparameter *predicats*
  nil
)

(defun add-predicat (predicat)
  (push predicat *predicats*)
)
; (add-predicat (make-predicat :name "nomPokemon" :value "pidgey"))

(defun get-predicat (predicatName liste)
  (cond 
    ((null liste) nil)
    ((equal (predicat-name (car liste)) predicatName) (car liste))
    (t (get-predicat predicatName (cdr liste)))
  )
)

; (print (get-predicat "typeRecherche" *predicats*))

(defun test ()
    (format t "test from faits~%")
)