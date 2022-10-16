;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hot-dog) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (contains-hot-dog?) produces a boolean value indicating if the symbol hot-dog 
;; is a part of the list
;; Examples
(check-expect (contains-hot-dog? (cons 'hot-dog (cons 'ketchup empty))) true)
(check-expect (ordinality (cons 'corn-dog (cons 'mayo empty))) false)

;; contains-hot-dog?: LIST -> BOOL
(define (contains-hot-dog? items)
    (cond
        [(empty? items) false]
        [(symbol=? (first items) 'hot-dog) true]
        [else (contains-hot-dog? (rest items))]))
        
;; Tests
(check-expect (contains-hot-dog? empty) false)
(check-expect (contains-hot-dog? (cons 'table (cons 'chair empty))) false)
(check-expect (contains-hot-dog? (cons 'burger (cons 'hot-dog empty))) true)

;; (spells-hot-dog?) produces a boolean value indicating whether hot-dog 
;; is a substring of the input
;; Examples
(check-expect (spells-hot-dog? "hdog") false)
(check-expect (spells-hot-dog? "hot dog") true)

;; spells-hot-dog?: STR -> BOOL
(define (spells-hot-dog? string)
    (and
        (manual-string-contains? "h" (string-downcase string))
        (manual-string-contains? "t" (string-downcase string))
        (manual-string-contains? "d" (string-downcase string))
        (manual-string-contains? "g" (string-downcase string))
        (manual-string-contains? " " (string-downcase string))
        (<= 2 (two_os string))))

;; Tests
(check-expect (spells-hot-dog? "") false)
(check-expect (spells-hot-dog? "hotdog") false)
(check-expect (spells-hot-dog? "doghot") true)

(define (two_os string)
    (cond
        [(empty? (string->list string)) 0]
        [(char=? #\o (first (string->list (string-downcase string)))) 
        (+ 1 (two_os (list->string (rest (string->list string)))))]
        [else (two_os (list->string (rest (string->list string))))]))

(define (manual-string-contains? char string)
    (cond
        [(empty? (string->list string)) false]
        [(string=? char (substring string 0 1)) true]
        [else (manual-string-contains? char (substring string 1))]))