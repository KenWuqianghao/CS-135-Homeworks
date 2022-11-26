;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname funfun) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; (multi-apply lof) consumes a list of functions (lof), all
;;   of which consume and produce the same type, and a value,
;;   of that same type. This function applies the functions
;;   from left to right on the given value
;; multi-apply: (listof function) -> 2D-Image
;; Examples:
(check-expect (multi-apply (list sub1 sqr add1) 3) 5)
(check-expect (multi-apply (list add1 sqr sub1) 3) 15)

(define (multi-apply lof)
  (...))

;; Tests:

;; (aop n) consumes a natural number n and produces a function
;;   that behaves like the “all one polynomial” of degree n,
;;   which is a polynomial where all the coefficients are one
;; aop: Nat -> Function
;; Examples:
(check-expect ((aop 4) 2) 31)
(check-expect ((aop 0) 5) 1)
(check-expect ((aop 16) 1) 17)
(check-expect ((aop 1) 5) 6)

(define (aop n)
  (...))

;; Tests:

;; (multi-compose lof) consumes a list of functions, all of
;;   which consume one value of the same type, and produce a
;;   value of the same type
;; multi-compose: (listof Function) -> Any
;; Examples:
(check-expect ((multi-compose (list sub1 sqr add1)) 3) 15)
(check-expect ((multi-compose (list add1 sqr sub1)) 3) 5)

(define (multi-compose lof)
  (...))

;; Tests: