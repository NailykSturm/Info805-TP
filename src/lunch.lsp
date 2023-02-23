; Gestionnaire de librarie de Common Lisp pour importer les autres librairies depuis internet
(require "quicklisp" "src/Import/quicklisp/setup.lisp")

; Importation des librairies
(quicklisp:quickload "dexador") ; Librairie pour faire des requêtes HTTP
(quicklisp:quickload "cl-json") ; Librairie pour parser du JSON

; Chargement des fichiers sources du projet
;(load "src/BDC/faits.lsp")
;(load "src/BDC/regles.lsp")
;(load "src/Exeptions/exept.lsp")
;(load "src/Moteur/moteur.lsp")
(load "src/UI/ui.lsp")


; Main
; (ui:testUI)
(ui:main)

; Test de la librairie dexador + cl-json
; (print
;     (cl-json:decode-json-from-string 
;         (dex:get "https://pokeapi.co/api/v2/type/1")
;     )
; )