;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fizz-buzz-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; (make-div-pred n) consumes a positive integer n and
;;   produces a new predicate function. The generated
;;   predicate function consumes an integer m and produces
;;   true if m is divisible by n and false otherwise
;; make-div-pred: Nat -> (Int -> Bool)

(define (make-div-pred n)
  (local
    [(define (div? m)
       (= (remainder m n) 0))] div?))

;; (fizz-buzz-2 start end laib) produces a (listof Any) using
;;   in the range of start and end, depending on the predicate
;;   function laib
;; fizz-buzz-2: Int Int (list Any (Int -> Bool)) -> (listof
;;                Any)
;; Examples:
(check-expect (fizz-buzz-2 8 15 (list (list 'honk (make-div-pred 15))
(list 'fizz (make-div-pred 3))
(list 'buzz (make-div-pred 5)))) '(8 fizz buzz 11 fizz 13 14 honk))
(check-expect (fizz-buzz-2 8 16 (list (list 'honk (make-div-pred 15))
(list 'fizz (make-div-pred 3))
(list 'buzz (make-div-pred 5)))) '(8 fizz buzz 11 fizz 13 14 honk 16))

(define (fizz-buzz-2 start end laib)
  (cond
    [(> start end) empty]
    [(= start end) (cons (symbol-gen start laib) empty)]
    [else (cons (symbol-gen start laib) (fizz-buzz-2 (add1 start) end laib))]))

(define (symbol-gen start laib)
  (local
    [(define pred
       (cond
         [(empty? laib) empty]
         [else (second (first laib))]))]
  (cond
    [(empty? laib) start]
    [(pred start) (first (first laib))]
    [else (symbol-gen start (rest laib))])))

;; Tests:
(check-expect (fizz-buzz-2 20 15 (list (list 'honk (make-div-pred 15))
(list 'fizz (make-div-pred 3))
(list 'buzz (make-div-pred 5)))) empty)
(check-expect (fizz-buzz-2 8 16 (list (list 'honk (make-div-pred 6))
(list 'fizz (make-div-pred 2))
(list 'buzz (make-div-pred 3)))) '(fizz buzz fizz 11 honk 13 fizz buzz fizz))
(check-expect (fizz-buzz-2 8 16 (list (list 'honk (make-div-pred 100))
(list 'fizz (make-div-pred 200))
(list 'buzz (make-div-pred 300)))) '(8 9 10 11 12 13 14 15 16))