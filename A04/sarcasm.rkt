;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sarcasm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))

;; pair-listof-X-template: (listof-X) -> Any
(define (pair-listof-X-template plox)
    (cond 
        [(empty? plox) ...]
        [else (... (first plox) (second plox) (listof-X-template (rest plox)))]))

;; (sarcastic) produces a sarcastic version of a given text with even positioned 
;; characters capitzlied
;; Examples
(check-expect (sarcastic "GOOD LUCK... you'll need it!") "GoOd lUcK... yOu'lL NeEd iT!")
(check-expect (sarcastic "Hello") "HeLlO")

;; sarcastic: STR -> STR
(define (sarcastic string)
    (cond 
        [(empty? (string->list string)) ""]
        [else (string-append (string-upcase (substring string 0 1))
            (string-downcase (substring string 1 2))
            (sarcastic (substring string 2)))]))

;; Tests
(check-expect (sarcastic "") "")
(check-expect (sarcastic "TEST") "TeSt")