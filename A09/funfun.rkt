;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname funfun) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; (multi-apply lof) consumes a list of functions (lof), all
;;   of which consume and produce the same type, and a value,
;;   of that same type. This function applies the functions
;;   from left to right on the given value
;; multi-apply: (listof (X -> X)) Any -> Any
;; Examples:
(check-expect (multi-apply (list sub1 sqr add1) 3) 5)
(check-expect (multi-apply (list add1 sqr sub1) 3) 15)

(define (multi-apply lof val)
  (foldl (lambda (f val) (f val)) val lof))

;; Tests:
(check-expect (multi-apply (list boolean?) true) true)
(check-expect (multi-apply (list string->list) "string") (list #\s #\t #\r #\i #\n #\g))

;; (aop n) consumes a natural number n and produces a function
;;   that behaves like the “all one polynomial” of degree n,
;;   which is a polynomial where all the coefficients are one
;; aop: Nat -> (Nat -> Nat)
;; Examples:
(check-expect ((aop 4) 2) 31)
(check-expect ((aop 0) 5) 1)
(check-expect ((aop 16) 1) 17)
(check-expect ((aop 1) 5) 6)

(define (aop n)
  (local [(define (polynomial x)
  (foldl + 0 (build-list
              (add1 n)
              (lambda (exponent)
                (expt x exponent)))))] polynomial))

;; Tests:
(check-expect ((aop 1) 1) 2)
(check-expect ((aop 2) 2) 7)
(check-expect ((aop 3) 3) 40)
(check-expect ((aop 4) 4) 341)

;; (multi-compose lof) consumes a list of functions, all of
;;   which consume one value of the same type, and produce a
;;   value of the same type. The function multi-compose produces
;;   a function which consumes one value, and will
;;   compose the functions from right to left on that value
;; multi-compose: (listof (X -> X)) -> (X -> X)
;; Examples:
(check-expect ((multi-compose (list sub1 sqr add1)) 3) 15)
(check-expect ((multi-compose (list add1 sqr sub1)) 3) 5)

(define (multi-compose lof)
  (local
    [(define (foldr-custom val)
       (foldr (lambda (f val) (f val)) val lof))] foldr-custom))

;; Tests:
(check-expect ((multi-compose (list boolean?)) true) true)
(check-expect ((multi-compose (list string->list)) "string") (list #\s #\t #\r #\i #\n #\g))